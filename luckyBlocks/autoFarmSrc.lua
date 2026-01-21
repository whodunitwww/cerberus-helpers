return function(env)
    local Services = env.Services
    local References = env.References
    local Tabs = env.Tabs
    local Unloader = env.Unloader
    local Library = env.Library -- Get Library for Notifications

    local PathfindingService = env.PathfindingService or Services.PathfindingService
    if not Tabs or not Tabs.Auto or not PathfindingService then
        return {}
    end

    -- Remotes
    local DropBrainrotEvent = Services.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DropBrainrotEvent")
    local DamageBlockEvent = Services.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DamageBlockEvent")

    -- UI Setup
    local AutoFarmBox = Tabs.Auto:AddLeftGroupbox("AutoFarm", "spinner")
    local AutoFarmStatusLabel = AutoFarmBox:AddLabel("Idle", true)

    -- State Tables
    local AutoFarmState = {
        Enabled = false,
        RunId = 0,
        TravelSpeed = 38,
        StopDistance = 10, -- Default for BLOCKS
        ActiveHumanoid = nil,
        OriginalWalkSpeed = nil,
        BlocksData = nil,
        UnreachableTargets = {},
        IncomeThreshold = 5000,
        BrainrotRange = 100,
        AuraRange = 25,
    }

    local function setStatus(text)
        if AutoFarmStatusLabel.SetText then
            AutoFarmStatusLabel:SetText(text)
        else
            AutoFarmStatusLabel.Text = text
        end
    end

    local function safeNotify(msg, duration)
        if Library and Library.Notify then
            Library:Notify(msg, duration or 3)
        end
    end

    local function loadBlocksData()
        if AutoFarmState.BlocksData then
            return AutoFarmState.BlocksData
        end
        local ok, result = pcall(function()
            return require(Services.ReplicatedStorage:WaitForChild("BlocksModule", 5))
        end)
        AutoFarmState.BlocksData = ok and type(result) == "table" and result or {}
        return AutoFarmState.BlocksData
    end

    local TargetIgnoreDuration = 5
    local MinCountdownRemaining = 8

    local function isTargetIgnored(block)
        if not block then
            return false
        end
        local timestamp = AutoFarmState.UnreachableTargets[block]
        if not timestamp then
            return false
        end
        if tick() - timestamp >= TargetIgnoreDuration then
            AutoFarmState.UnreachableTargets[block] = nil
            return false
        end
        return true
    end

    local function markTargetUnreachable(block)
        if block then
            AutoFarmState.UnreachableTargets[block] = tick()
        end
    end

    local function getBlockPosition(node)
        if not node then
            return nil
        end
        if node:IsA("BasePart") then
            return node.Position
        end
        if node:IsA("Model") then
            local pivotOk, pivot = pcall(function()
                return node:GetPivot()
            end)
            if pivotOk and pivot then
                return pivot.Position
            end
            local part = node:FindFirstChildWhichIsA("BasePart")
            if part then
                return part.Position
            end
        end
        return nil
    end

    -- ==== HELPERS ==== --
    
    local function isRagdolled(humanoid)
        if not humanoid then return false end
        return humanoid.PlatformStand or humanoid:GetState() == Enum.HumanoidStateType.Physics
    end

    local function parseIncomeValue(text)
        if type(text) ~= "string" then
            return nil
        end
        local digits = text:gsub("[^%d%.]", "")
        if digits == "" then
            return nil
        end
        return tonumber(digits)
    end

    local function getBrainrotIncome(brainrot)
        if not brainrot then
            return nil
        end
        local mesh = brainrot:FindFirstChild("Mesh")
        local infoGui = mesh and mesh:FindFirstChild("InfoGui")
        local frame = infoGui and infoGui:FindFirstChild("Frame")
        local charCash = frame and frame:FindFirstChild("CharCash")
        local text = charCash and charCash.Text
        return parseIncomeValue(text)
    end

    local function getBrainrotPrompt(brainrot)
        local mesh = brainrot and brainrot:FindFirstChild("Mesh")
        if not mesh then
            return nil
        end
        local prompt = mesh:FindFirstChild("PickupPrompt")
        if prompt and prompt:IsA("ProximityPrompt") then
            return prompt
        end
        return nil
    end

    local function getBrainrotDestination(brainrot)
        local position = getBlockPosition(brainrot)
        if not position then
            return nil
        end
        return position
    end

    local function getBrainrotRemaining(brainrot)
        if not brainrot then
            return nil
        end
        local countdown = brainrot:GetAttribute("CountdownEnd")
        if type(countdown) ~= "number" then
            countdown = tonumber(countdown)
        end
        if type(countdown) ~= "number" then
            return nil
        end
        local remaining = countdown - os.time()
        return remaining
    end

    local function getBestBlock(origin)
        local folder = Services.Workspace:FindFirstChild("LuckyBlocks")
        if not folder then
            return nil
        end

        local lookup = loadBlocksData()
        local bestRarity = math.huge
        local bestCandidates = {}

        for _, block in ipairs(folder:GetChildren()) do
            if isTargetIgnored(block) then
                continue
            end
            local position = getBlockPosition(block)
            if position then
                local rarity = math.huge
                local rarityLabel = "Unknown"
                local blockInfo = lookup[block.Name]
                if type(blockInfo) == "table" then
                    rarity = tonumber(blockInfo.Rarity) or rarity
                    rarityLabel = blockInfo.RarityType or rarityLabel
                end
                if rarity < bestRarity then
                    bestRarity = rarity
                    bestCandidates = {}
                end
                if rarity == bestRarity then
                    local distance = origin and (position - origin).Magnitude or 0
                    bestCandidates[#bestCandidates + 1] = {
                        instance = block,
                        position = position,
                        rarity = rarity,
                        rarityLabel = rarityLabel,
                        distance = distance,
                    }
                end
            end
        end

        if #bestCandidates == 0 then
            return nil
        end

        local closest = bestCandidates[1]
        for i = 2, #bestCandidates do
            if bestCandidates[i].distance < closest.distance then
                closest = bestCandidates[i]
            end
        end
        return closest
    end

    local function ensurePickaxeEquipped()
        if not References.player then return end
        local character = References.character or References.player.Character
        local backpack = References.player:FindFirstChild("Backpack")
        local humanoid = References.humanoid
        
        if not backpack or not humanoid or not character then return end

        -- 1. Unequip EVERYTHING that isn't "Six Seven"
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Tool") and child.Name ~= "Six Seven" then
                child.Parent = backpack -- Move to backpack (Unequip)
            end
        end

        -- 2. Check if we are already holding "Six Seven"
        local equippedTool = character:FindFirstChild("Six Seven")
        if equippedTool then
            return -- We are good, we have it equipped and nothing else
        end

        -- 3. If not equipped, find it in backpack and equip it
        local toolInBackpack = backpack:FindFirstChild("Six Seven")
        if toolInBackpack and toolInBackpack:IsA("Tool") then
            humanoid:EquipTool(toolInBackpack)
        end
    end

    local function getBestBrainrot(origin)
        local folder = Services.Workspace:FindFirstChild("Brainrots")
        if not folder then
            return nil
        end

        local best = nil
        for _, brainrot in ipairs(folder:GetChildren()) do
            if not brainrot or not brainrot.Parent then
                continue
            end
            if isTargetIgnored(brainrot) then
                continue
            end
            local position = getBrainrotDestination(brainrot)
            if not position then
                continue
            end
            
            local distance = origin and (position - origin).Magnitude or math.huge

            -- Check if another player has it
            if brainrot:GetAttribute("Carried") == true then
                -- If it says carried, but we are > 10 studs away, assume someone else has it and ignore it
                if distance > 10 then
                    continue
                end
            end

            if distance > AutoFarmState.BrainrotRange then
                continue
            end
            local income = getBrainrotIncome(brainrot)
            if not income or income < AutoFarmState.IncomeThreshold then
                continue
            end
            local remaining = getBrainrotRemaining(brainrot)
            if remaining and remaining < MinCountdownRemaining then
                continue
            end
            if not best or income > best.income or (income == best.income and distance < best.distance) then
                best = {
                    instance = brainrot,
                    position = position,
                    income = income,
                    distance = distance,
                }
            end
        end

        return best
    end

    local function applySpeedOverride(humanoid)
        if not humanoid then
            return
        end
        if AutoFarmState.ActiveHumanoid and AutoFarmState.ActiveHumanoid ~= humanoid then
            if AutoFarmState.OriginalWalkSpeed then
                AutoFarmState.ActiveHumanoid.WalkSpeed = AutoFarmState.OriginalWalkSpeed
            end
            AutoFarmState.ActiveHumanoid = nil
            AutoFarmState.OriginalWalkSpeed = nil
        end
        if not AutoFarmState.ActiveHumanoid then
            AutoFarmState.ActiveHumanoid = humanoid
            AutoFarmState.OriginalWalkSpeed = humanoid.WalkSpeed
        end
        humanoid.WalkSpeed = AutoFarmState.TravelSpeed
    end

    local function resetSpeed()
        if AutoFarmState.ActiveHumanoid and AutoFarmState.OriginalWalkSpeed then
            AutoFarmState.ActiveHumanoid.WalkSpeed = AutoFarmState.OriginalWalkSpeed
        end
        AutoFarmState.ActiveHumanoid = nil
        AutoFarmState.OriginalWalkSpeed = nil
    end

    local function getApproachPosition(origin, targetPosition, overrideDistance)
        if not origin or not targetPosition then
            return nil
        end
        
        local dist = overrideDistance or AutoFarmState.StopDistance

        local direction = (targetPosition - origin)
        local distance = direction.Magnitude
        if distance <= dist then
            return origin
        end
        if distance == 0 then
            return origin
        end
        local normalized = direction.Unit
        return targetPosition - normalized * dist
    end

    local function followPathTo(targetPosition, humanoid, origin, runId, brainrotCheck, arrivalDistance)
        if not humanoid or not origin or not targetPosition then
            return false
        end

        local effectiveStopDist = arrivalDistance or AutoFarmState.StopDistance

        local path = PathfindingService:CreatePath({
            AgentHeight = 5,
            AgentRadius = 2,
            AgentCanJump = true,
        })

        local ok, err = pcall(function()
            path:ComputeAsync(origin, targetPosition)
        end)

        if not ok or path.Status ~= Enum.PathStatus.Success then
            if path.Status == Enum.PathStatus.NoPath then return false, "NoPath" end
            return false, "ComputeFailed"
        end

        local waypoints = path:GetWaypoints()
        
        -- Stuck Detection Variables
        local lastPosition = References.humanoidRootPart and References.humanoidRootPart.Position or origin
        local stuckTimerStart = tick()
        local stuckThreshold = 0.2 -- studs
        local stuckTimeLimit = 1.5 -- seconds before trying to jump
        local stuckFailLimit = 3.5 -- seconds before aborting

        for _, waypoint in ipairs(waypoints) do
            if AutoFarmState.RunId ~= runId or not AutoFarmState.Enabled then return false end

            -- Brainrot Check
            if brainrotCheck and (not brainrotCheck.Parent or not brainrotCheck:GetAttribute("Carried")) then
                return false, "LostBrainrot"
            end

            -- Ragdoll Check during pathfinding
            if isRagdolled(humanoid) then
                return false, "Ragdolled"
            end

            if waypoint.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end

            humanoid:MoveTo(waypoint.Position)

            local moveSuccess = false
            local reached = false
            
            while not reached do
                if AutoFarmState.RunId ~= runId or not AutoFarmState.Enabled then return false end
                
                -- Brainrot Check during move
                if brainrotCheck and (not brainrotCheck.Parent or not brainrotCheck:GetAttribute("Carried")) then
                    return false, "LostBrainrot"
                end
                
                -- Ragdoll Check during move
                if isRagdolled(humanoid) then
                    return false, "Ragdolled"
                end

                -- Check dist
                local currentPos = References.humanoidRootPart.Position
                local distToWaypoint = (Vector3.new(currentPos.X, 0, currentPos.Z) - Vector3.new(waypoint.Position.X, 0, waypoint.Position.Z)).Magnitude
                
                if distToWaypoint < effectiveStopDist then 
                     if (targetPosition - currentPos).Magnitude < effectiveStopDist then
                        reached = true
                        moveSuccess = true
                        break
                     end
                end
                
                -- Basic generic waypoint arrival
                if distToWaypoint < 4 then
                    reached = true
                    moveSuccess = true
                    break
                end

                -- Stuck Check
                local distMoved = (currentPos - lastPosition).Magnitude
                if distMoved < stuckThreshold then
                    if tick() - stuckTimerStart > stuckFailLimit then
                        return false, "StuckHard"
                    elseif tick() - stuckTimerStart > stuckTimeLimit then
                        humanoid.Jump = true
                    end
                else
                    stuckTimerStart = tick()
                    lastPosition = currentPos
                end

                task.wait(0.1)
            end

            if not moveSuccess then return false, "MoveToFailed" end
        end

        return true, nil
    end

    local function followPathSegmented(targetPosition, humanoid, origin, runId, brainrotCheck, arrivalDistance)
        -- Invisible Wall Fix
        if References.humanoidRootPart and References.humanoidRootPart.Position.Z < -120 then
            local currentPos = References.humanoidRootPart.Position
            References.humanoidRootPart.CFrame = CFrame.new(currentPos.X, currentPos.Y, -119)
            task.wait(0.05)
            origin = References.humanoidRootPart.Position
        end

        local effectiveStopDist = arrivalDistance or AutoFarmState.StopDistance

        local MaxSegment = 120
        local start = origin
        local attempts = 0
        local MaxAttempts = 15 

        while true do
            if brainrotCheck and (not brainrotCheck.Parent or not brainrotCheck:GetAttribute("Carried")) then
                return false, "LostBrainrot"
            end
            
            if isRagdolled(humanoid) then
                return false, "Ragdolled"
            end

            local direction = targetPosition - start
            local distance = direction.Magnitude
            if distance <= 0.5 then
                return true, nil
            end
            
            local segmentTarget = targetPosition
            if distance > MaxSegment then
                segmentTarget = start + direction.Unit * MaxSegment
            end
            
            local moved, reason = followPathTo(segmentTarget, humanoid, start, runId, brainrotCheck, effectiveStopDist)
            
            if not moved then
                return false, reason
            end
            
            start = References.humanoidRootPart and References.humanoidRootPart.Position or segmentTarget
            
            -- Success check
            if (targetPosition - start).Magnitude <= effectiveStopDist then
                return true, nil
            end

            attempts = attempts + 1
            if attempts >= MaxAttempts then
                return false, "SegmentLimit"
            end
        end
    end

    local function ensureCrossLine(hrp, humanoid, runId, brainrotInstance)
        if not hrp or not humanoid then
            return false
        end
        if hrp.Position.Z <= -130 then
            return true
        end

        if brainrotInstance and not brainrotInstance:GetAttribute("Carried") then
             warn("[AutoFarm] Not carrying brainrot, skipping return trip.")
             return false
        end

        -- [UPDATED] Retry Loop for Pathfinding to Intermediate Point (-115)
        local retries = 0
        local MaxRetries = 3
        local success = false
        
        while retries < MaxRetries do
            local intermediateDest = Vector3.new(hrp.Position.X, hrp.Position.Y, -115)
            
            -- Use default StopDistance (10) for navigation
            local arrived, reason = followPathSegmented(intermediateDest, humanoid, hrp.Position, runId, brainrotInstance)
            
            if reason == "Ragdolled" then return false end -- Pause completely if ragdolled
            
            if not arrived and reason == "LostBrainrot" then
                warn("[AutoFarm] Lost brainrot while returning! Aborting return.")
                return false
            end
            
            if arrived then
                success = true
                break
            else
                warn("[AutoFarm] Return path failed ("..tostring(reason).."), retrying... " .. tostring(retries + 1))
                retries = retries + 1
                task.wait(0.5) -- Wait before repathing
            end
        end

        -- Step 2: Force Teleport to Z = -130 (Final Destination)
        -- Even if pathfinding failed after 3 tries, we attempt teleport as last resort if we still hold the item
        if brainrotInstance and not brainrotInstance:GetAttribute("Carried") then
             warn("[AutoFarm] Lost brainrot before teleport! Aborting.")
             return false
        end

        local finalDest = Vector3.new(hrp.Position.X, hrp.Position.Y, -130)
        if hrp then
            hrp.CFrame = CFrame.new(finalDest)
            task.wait(0.1) 
        end

        return true
    end

    local function handleBrainrotTarget(target, humanoid, hrp, runId)
        if not target or not target.instance or not humanoid or not hrp then return false end
        
        safeNotify(("Found Brainrot: %s ($%s/s)"):format(target.instance.Name, tostring(target.income)), 3)

        if not target.instance:GetAttribute("Carried") then
            DropBrainrotEvent:FireServer()
            task.wait(0.1) 
        end

        -- Use 5 stud stop distance specifically for Brainrots
        local approach = getApproachPosition(hrp.Position, target.position, 5)
        if not approach then return false end

        -- Pass 5 stud arrival distance to pathfinder
        local moved, reason = followPathSegmented(approach, humanoid, hrp.Position, runId, nil, 5)
        
        if not moved then
            if reason == "Ragdolled" then
                return false
            end
            if reason == "NoPath" or reason == "StuckHard" then
                markTargetUnreachable(target.instance)
            end
            safeNotify("Failed to reach brainrot: "..(reason or "?"), 2)
            return false
        end

        setStatus(("Collecting brainrot %s ($%s/s)"):format(target.instance.Name, tostring(target.income)))
        
        local pickupAttempts = 0
        local MaxPickupAttempts = 3
        local carried = false

        while pickupAttempts < MaxPickupAttempts and not carried do
            local prompt = getBrainrotPrompt(target.instance)
            if prompt and fireproximityprompt then
                pcall(fireproximityprompt, prompt, 0)
            end
            task.wait(0.4)

            local waitCount = 0
            while waitCount < 10 do 
                if not target.instance or not target.instance.Parent then break end
                if target.instance:GetAttribute("Carried") == true then
                    carried = true
                    break
                end
                task.wait(0.1)
                waitCount = waitCount + 1
            end
            
            if not carried then
                pickupAttempts = pickupAttempts + 1
                if pickupAttempts < MaxPickupAttempts then
                    safeNotify("Pickup failed, retrying...", 1)
                    task.wait(0.5)
                end
            end
        end

        if carried then
            safeNotify("Picked up! Returning to base...", 3)
            applySpeedOverride(humanoid) 
            setStatus("Crossing line threshold")
            ensureCrossLine(hrp, humanoid, runId, target.instance)
            return true
        else
            safeNotify("Failed to pick up brainrot after retries.", 3)
            return false
        end
    end

    local function startAutoFarmLoop()
        AutoFarmState.RunId = AutoFarmState.RunId + 1
        local runId = AutoFarmState.RunId

        -- [AURA THREAD] 
        task.spawn(function()
            while AutoFarmState.Enabled and AutoFarmState.RunId == runId do
                pcall(function()
                    local blocksFolder = Services.Workspace:FindFirstChild("LuckyBlocks")
                    local hrp = References.humanoidRootPart

                    if blocksFolder and hrp then
                        local origin = hrp.Position
                        for _, block in ipairs(blocksFolder:GetChildren()) do
                            if not AutoFarmState.Enabled or AutoFarmState.RunId ~= runId then break end
                            local blockPos = getBlockPosition(block)
                            if blockPos and (blockPos - origin).Magnitude <= AutoFarmState.AuraRange then
                                DamageBlockEvent:FireServer(block)
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)

        -- [MAIN THREAD]
        task.spawn(function()
            while AutoFarmState.Enabled and AutoFarmState.RunId == runId do
                local humanoid = References.humanoid
                local hrp = References.humanoidRootPart

                -- Ragdoll Logic
                if isRagdolled(humanoid) then
                    setStatus("Ragdolled - Waiting...")
                    task.wait(0.1)
                    continue
                end

                if not humanoid or not hrp or humanoid.Health <= 0 then
                    setStatus("Waiting for character...")
                    task.wait(0.5)
                else
                    applySpeedOverride(humanoid)
                    ensurePickaxeEquipped()

                    local brainrotTarget = getBestBrainrot(hrp.Position)
                    if brainrotTarget then
                        setStatus(("Heading to brainrot %s ($%s/s)"):format(brainrotTarget.instance.Name, tostring(brainrotTarget.income)))
                        handleBrainrotTarget(brainrotTarget, humanoid, hrp, runId)
                        task.wait(0.1) 
                    else
                        local target = getBestBlock(hrp.Position)
                        if not target or not target.instance or not target.instance.Parent then
                            setStatus("No lucky blocks available")
                            task.wait(1)
                        else
                            local distance = (target.position - hrp.Position).Magnitude
                            local displayName = ("%s (%s rarity)"):format(target.instance.Name, target.rarityLabel)

                            if distance <= AutoFarmState.StopDistance then
                                setStatus(("Near %s"):format(displayName))
                                
                                -- Rarity Wait Logic
                                if target.rarity and target.rarity < 50 then
                                    local waitStart = tick()
                                    while tick() - waitStart < 1.5 do
                                        if not AutoFarmState.Enabled then break end
                                        
                                        local potentialBrainrot = getBestBrainrot(hrp.Position)
                                        if potentialBrainrot then
                                            setStatus("Interrupting wait for Brainrot!")
                                            handleBrainrotTarget(potentialBrainrot, humanoid, hrp, runId)
                                            break 
                                        end
                                        task.wait(0.1)
                                    end
                                else
                                    task.wait(0.2)
                                end
                            else
                                setStatus(("Heading to %s"):format(displayName))
                                local currentPosition = getBlockPosition(target.instance)
                                
                                -- Uses default 10 stud stop distance for blocks
                                local approach = getApproachPosition(hrp.Position, currentPosition or target.position)
                                
                                if not approach then
                                    setStatus("Target vanished")
                                    task.wait(0.3)
                                else
                                    local moved, reason = followPathSegmented(approach, humanoid, hrp.Position, runId)
                                    if moved then
                                        setStatus(("Arrived at %s"):format(displayName))
                                        task.wait(0.1)
                                    else
                                        if reason == "NoPath" or reason == "StuckHard" then
                                            markTargetUnreachable(target.instance)
                                        end
                                        setStatus(("Could not reach %s: %s"):format(displayName, reason or "unknown"))
                                        warn("[AutoFarm] Failed to reach target:", reason or "unknown")
                                        task.wait(0.2)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            resetSpeed()
        end)
    end

    local function stopAutoFarmLoop()
        AutoFarmState.Enabled = false
        AutoFarmState.RunId = AutoFarmState.RunId + 1
        resetSpeed()
    end

    local function setAutoFarmEnabled(value)
        if AutoFarmState.Enabled == value then return end

        if value then
            AutoFarmState.Enabled = true
            setStatus("Starting AutoFarm...")
            startAutoFarmLoop()
        else
            setStatus("Stopping AutoFarm...")
            stopAutoFarmLoop()
            setStatus("AutoFarm disabled")
        end
    end

    -- Setup UI Components
    AutoFarmBox:AddToggle("AutoFarmEnabled", {
        Text = "Enable AutoFarm",
        Default = false,
        Callback = setAutoFarmEnabled,
    })

    AutoFarmBox:AddSlider("AutoFarmIncome", {
        Text = "Brainrot Income Threshold ($/s)",
        Min = 100,
        Max = 50000,
        Rounding = 0,
        Default = AutoFarmState.IncomeThreshold,
        Callback = function(value)
            AutoFarmState.IncomeThreshold = value
        end,
    })

    AutoFarmBox:AddSlider("AutoFarmRange", {
        Text = "Brainrot Range (studs)",
        Min = 20,
        Max = 400,
        Rounding = 0,
        Default = AutoFarmState.BrainrotRange,
        Callback = function(value)
            AutoFarmState.BrainrotRange = value
        end,
    })

    Unloader:Register(function()
        stopAutoFarmLoop()
        setStatus("AutoFarm disabled")
    end)

    return {
        SetEnabled = setAutoFarmEnabled,
    }
end
