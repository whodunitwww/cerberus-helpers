-- configDefaults.lua
-- Centralized config defaults for Cerberus.
return function(ctx)
    local Services = ctx.Services
    local References = ctx.References

    local Configs = {}

    Configs.HomeConfig = {
        About = true,
        Links = true,
        Executor = true,
        Updates = true,
        Feedback = true,
        Credits = true,
    }

    Configs.Utils = {
        Enabled = true
    }

    Configs.WebhookConfig = {
        Enabled = true,
        Events = {
            Launch = true,
            Chat = true,
            InventoryChange = true,
            PlayerJoinLeave = true,
            ItemDrops = true,
            BossRaid = true,
        }
    }

    Configs.TeleportsConfig = {
        Enabled = true,
        Waypoints = {
            Enabled = true,
            Keybinds = true,
        },
        DefaultCategory = "Players",
        Categories = {
            {
                key = "Players",
                label = "Players",
                type = "players",
            },
            {
                key = "Entities",
                label = "Entities",
                type = "entities",
            },
            {
                key = "NPCs",
                label = "NPCs",
                type = "npcs",
            },
            {
                key = "Regions",
                label = "Regions",
                type = "regions",
            },
            {
                key = "Extras",
                label = "Extras",
                type = "extras",
            },
            {
                key = "Waypoints",
                label = "Waypoints",
                type = "waypoints",
            },
        },
    }

    Configs.AutoPromptConfig = {
        Enabled = true,
        ProximityName = true,
        ProximityRadius = {
            Enabled = true,
            Min = 4,
            Max = 50,
            Default = 12,
            Rounding = 0,
        },
        ProximityDelay = {
            Enabled = true,
            Min = 0,
            Max = 2,
            Default = 0.2,
            Rounding = 2,
        },
        ProximityHold = {
            Enabled = true,
            Min = 0,
            Max = 5,
            Default = 0,
            Rounding = 2,
        },
    }

    Configs.InstakillConfig = {
        Enabled = true,
        IKRange = {
            Enabled = true,
            Min = 10,
            Max = 5000,
            Default = 150,
        },
        IKThreshold = {
            Enabled = true,
            Min = 0,
            Max = 100,
            Default = 90,
        },
        Dev = {
            Step = 0.12,
            Tooltip = "This ONLY works on mobs NOT players, and only sometimes.",
        },
    }

    Configs.MovementConfig = {
        Enabled = true,
        ClickToTp = true,
        Flight = {
            Enabled = true,
            FlightSpeed = {
                Enabled = true,
                Min = 30,
                Max = 400,
                Default = 100,
            },
        },
        Speed = {
            Enabled = true,
            SpeedSlider = {
                Enabled = true,
                Min = 16,
                Max = 300,
                Default = 30,
            },
        },
        Jump = {
            Enabled = true,
            InfiniteJump = true,
            JumpHeight = {
                Enabled = true,
                Min = 5,
                Max = 200,
                Default = 7.2,
            },
        },
        CTW = {
            Enabled = true,
            WalkSpeed = {
                Enabled = true,
                Min = 8,
                Max = 300,
                Default = 16,
            },
        },
        Dev = {
            CTW = {
                MaxHopDistance = 700,
                MinRepathInterval = 0.30,
            },
        },
    }

    Configs.PlayerUtilsConfig = {
        Enabled = true,
        NoClip = true,
        Desync = true,
        AutoUseTool = true,
        PerformanceMode = true,
        RemoveKillBricks = true,
        ModSafety = true,
        AntiAFK = true,
        AutoRejoin = true,
        FPSCap = true,
        QuickReset = true,
        Zoom = {
            Enabled = true,
            ZoomStrength = {
                Enabled = true,
                Min = 1,
                Max = 10,
                Default = 2,
            },
        },
        Dev = {
        },
    }

    Configs.VisualsConfig = {
        Enabled = true,
        Radar = {
            Enabled = true,
            RadarMode = true,
            RadarRange = {
                Enabled = true,
                Min = 100,
                Max = 2000,
                Default = 500,
            },
            RadarScale = {
                Enabled = true,
                Min = 50,
                Max = 200,
                Default = 100,
            },
        },
        Visuals = {
            Enabled = true,
            InfiniteCam = true,
            NoFog = true,
            Xray = true,
            FOV = {
                Enabled = true,
                Min = 40,
                Max = 120,
                Default = 70,
            },
            Fullbright = {
                Enabled = true,
                Brightness = {
                    Enabled = true,
                    Min = 0.01,
                    Max = 5,
                    Default = 1,
                },
            },
            Freecam = {
                Enabled = true,
                Sensitivity = {
                    Enabled = true,
                    Min = 0.1,
                    Max = 3,
                    Default = 1,
                },
            },
        },
        Dev = {
        },
    }

    Configs.SaveManagerConfig = {
        WebConfigs = {},
    }

    Configs.AutoParryConfig = {
        Enabled = true,
        DefaultPreset = "Custom Config",
        ConfigPath = (References and References.gameDir or "Cerberus/Paradox") .. "/AP_Config.json",
        FallbackConfigPath = (References and References.gameDir or "Cerberus/Paradox") .. "/AP_Config_Generated.json",
        Presets = {
            {
                Name = "Custom Config",
                File = "AP_Config.json",
                ExtraFile = "AP_Config_Extra.json",
                Default = true,
            },
            {
                Name = "Encrypted Test",
                EncryptedUrl = "https://raw.githubusercontent.com/whodunitwww/cerberus-helpers/refs/heads/main/template/test/AP_Config.json",
            },--[[
            {
                Name = "drey/e Config",
                Url = "https://raw.githubusercontent.com/whodunitwww/noxhelpers/refs/heads/main/devilhunter/drey-e%20config.txt",
                PaidKey = "a78w4bwx98xja9tm",
                PurchaseUrl = "https://discord.com/channels/1349561505548599367/1461924912297017650/1461924912297017650",
            },]]
        },
        DefaultConfig = {
            ["17030773401"] = {
                name = "Zombie Attack",
                startSec = 0.42,
                hold = 0.30,
                rollOnFail = true,
                distanceAdj = 0,
            },
        },
        DefaultExtra = {
            parryKey = "F",
            rollKey = "Q",
        },
        BlockHoldMs = {
            Min = 50,
            Max = 600,
            Default = 200,
        },
        FOV = {
            Min = 30,
            Max = 180,
            Default = 110,
        },
        Facing = {
            Min = 30,
            Max = 180,
            Default = 90,
        },
        RangePadding = {
            Min = -10,
            Max = 30,
            Default = 0,
        },
        PingScale = {
            Min = 0,
            Max = 2,
            Default = 1,
            Rounding = 2,
        },
        ManualLeadMs = {
            Min = -100,
            Max = 250,
            Default = 0,
        },
        FlashstepCooldownMs = {
            Min = 100,
            Max = 1500,
            Default = 400,
        },
        UsePingAdjustment = true,
        UseFOV = true,
        UseFacingCheck = true,
        FlashstepOnFail = true,
        TrackPlayers = true,
        TrackNPCs = true,
        DebugMode = false,
    }

    Configs.AimbotConfig = {
        Enabled = true,
        Defaults = {
            AimbotEnabled = false,
            AimKey = "Q",
            FOV = 100,
            FOVColor = Color3.fromRGB(255, 255, 255),
            FOVCircleVisible = false,
            FOVFilled = false,
            FOVTransparency = 1,
            Smoothness = 0.5,
            Prediction = 0,
            DropCompensation = 0,
            TargetParts = { "Head" },
            BodyChance = 0,
            TargetTypes = { "Enemy Players" },
            WallCheck = false,
            MobileAutoAim = false,
            ShowAimLine = false,
        },
    }

    Configs.ESPConfig = {
        Enabled = true,
        Universal = {
            Enabled = true,
            TextSize = {
                Enabled = true,
                Default = 13,
                Min = 10,
                Max = 28,
            },
            TracerOrigin = {
                Enabled = true,
                Default = "Bottom",
                Values = { "Bottom", "Middle", "Top" },
            },
            LimitRange = {
                Enabled = true,
                Default = false,
            },
            MaxRange = {
                Enabled = true,
                Default = 150,
                Min = 50,
                Max = 2000,
            },
        },
        Groups = {
            {
                Enabled = true,
                key = "Players",
                title = "Player ESP",
                icon = "users",
                uiSide = "left",
                FullGroup = true,
                type = "players",
                sideDefault = "Enemy",
                features = {
                    box = {
                        Enabled = true,
                        Default = true,
                        color = Color3.fromRGB(255, 60, 60),
                        outline = true,
                        fill = false,
                        fillAlpha = 35,
                    },
                    name = {
                        Enabled = true,
                        Default = true,
                        color = Color3.new(1, 1, 1),
                    },
                    distance = {
                        Enabled = true,
                        Default = false,
                        color = Color3.new(1, 1, 1),
                    },
                    healthBar = {
                        Enabled = true,
                        Default = true,
                    },
                    weapon = {
                        Enabled = true,
                        Default = false,
                    },
                    tracer = {
                        Enabled = true,
                        Default = false,
                        color = Color3.fromRGB(255, 60, 60),
                    },
                    chams = {
                        Enabled = true,
                        Default = true,
                    },
                },
            },
            {
                Enabled = true,
                key = "Entities",
                title = "Entity ESP",
                icon = "user-cog",
                uiSide = "right",
                FullGroup = true,
                type = "sense_instances",
                subtype = "humanoid",
                sourceFolder = "Alive",
                refreshInterval = 1.0,
                maxTracked = 80,
                selector = function(root)
                    local list, nameSet = {}, {}
                    for _, plr in ipairs(Services.Players:GetPlayers()) do
                        nameSet[plr.Name] = true
                    end
                    for _, m in ipairs(root:GetDescendants()) do
                        if m:IsA("Model")
                            and m:FindFirstChildOfClass("Humanoid")
                            and not nameSet[m.Name]
                        then
                            table.insert(list, m)
                        end
                    end
                    return list
                end,
                features = {
                    box = {
                        Enabled = true,
                        Default = true,
                        color = Color3.fromRGB(255, 255, 0),
                        outline = true,
                        fill = false,
                        fillAlpha = 25,
                    },
                    name = {
                        Enabled = true,
                        Default = true,
                        color = Color3.new(1, 1, 1),
                    },
                    distance = {
                        Enabled = true,
                        Default = false,
                        color = Color3.new(1, 1, 1),
                    },
                    tracer = {
                        Enabled = true,
                        Default = false,
                        color = Color3.fromRGB(255, 255, 0),
                    },
                    healthBar = {
                        Enabled = true,
                        Default = false,
                    },
                    chams = {
                        Enabled = true,
                        Default = false,
                    },
                },
            },
        },
        Objects = {
            Enabled = true,
            Types = {
                {
                    key = "ESP_NPCs",
                    label = "NPCs",
                    getEntries = function()
                        local entries = {}
                        local folder = Services.Workspace:FindFirstChild("NPCs")
                        if not folder then
                            return entries
                        end

                        for _, npc in ipairs(folder:GetChildren()) do
                            if npc:IsA("Model") then
                                local pos
                                local ok, piv = pcall(npc.GetPivot, npc)
                                if ok and typeof(piv) == "CFrame" then
                                    pos = piv.Position
                                end
                                if not pos then
                                    local part = npc:FindFirstChild("HumanoidRootPart")
                                        or npc:FindFirstChildWhichIsA("BasePart")
                                    pos = part and part.Position
                                end
                                if pos then
                                    entries[#entries + 1] = {
                                        key = "NPC:" .. npc:GetDebugId(),
                                        name = npc.Name or "NPC",
                                        position = pos,
                                    }
                                end
                            end
                        end

                        return entries
                    end,
                },
                {
                    key = "ESP_Regions",
                    label = "Regions",
                    getEntries = function()
                        local entries = {}
                        local folder = Services.Workspace:FindFirstChild("Regions")
                        if not folder then
                            return entries
                        end

                        for _, part in ipairs(folder:GetChildren()) do
                            if part:IsA("BasePart") then
                                entries[#entries + 1] = {
                                    key = "Region:" .. part:GetDebugId(),
                                    name = part.Name or "Region",
                                    position = part.Position,
                                }
                            end
                        end

                        return entries
                    end,
                },
                {
                    key = "ESP_Extras",
                    label = "Extras",
                    getEntries = function()
                        local entries = {}
                        local playerName = Services.Players.LocalPlayer and Services.Players.LocalPlayer.Name
                        local map = Services.Workspace:FindFirstChild("Map")
                        local plots = map and map:FindFirstChild("InnerWorldPlots")
                        local innerWorld = playerName and plots and plots:FindFirstChild(playerName .. "InnerWorld")
                        if not innerWorld then
                            return entries
                        end

                        local pos
                        local ok, piv = pcall(innerWorld.GetPivot, innerWorld)
                        if ok and typeof(piv) == "CFrame" then
                            pos = piv.Position
                        end
                        if not pos then
                            local part = innerWorld:FindFirstChildWhichIsA("BasePart", true)
                            pos = part and part.Position
                        end
                        if pos then
                            entries[#entries + 1] = {
                                key = "Extra:" .. innerWorld:GetDebugId(),
                                name = "Inner World",
                                position = pos,
                            }
                        end

                        return entries
                    end,
                },
                {
                    key = "ESP_TimePortal",
                    label = "Time Portal",
                    getEntries = function()
                        local entries = {}
                        local junk = Services.Workspace:FindFirstChild("Junk")
                        local timeGate = junk and junk:FindFirstChild("TimeGate")
                        if not timeGate then
                            return entries
                        end

                        local pos
                        if timeGate:IsA("BasePart") then
                            pos = timeGate.Position
                        else
                            local ok, piv = pcall(timeGate.GetPivot, timeGate)
                            if ok and typeof(piv) == "CFrame" then
                                pos = piv.Position
                            end
                        end
                        if not pos and timeGate:IsA("Attachment") then
                            pos = timeGate.WorldPosition
                        end
                        if not pos then
                            local part = timeGate:FindFirstChildWhichIsA("BasePart", true)
                            pos = part and part.Position
                        end
                        if pos then
                            entries[#entries + 1] = {
                                key = "Extra:" .. timeGate:GetDebugId(),
                                name = "Time Portal",
                                position = pos,
                            }
                        end

                        return entries
                    end,
                },
                {
                    key = "ESP_Waypoints",
                    label = "Waypoints",
                    getEntries = function()
                        local entries = {}
                        if not (isfile and readfile) then
                            return entries
                        end

                        local path = References.gameDir .. "/waypoints.json"
                        if not isfile(path) then
                            return entries
                        end

                        local okRead, raw = pcall(readfile, path)
                        if not okRead or type(raw) ~= "string" or raw == "" then
                            return entries
                        end

                        local okDecode, decoded = pcall(Services.HttpService.JSONDecode, Services.HttpService, raw)
                        if not okDecode or type(decoded) ~= "table" then
                            return entries
                        end

                        local list = decoded.list or {}
                        local order = decoded.order or {}
                        local seen = {}

                        local function toVector3(v)
                            if typeof(v) == "Vector3" then
                                return v
                            end
                            if type(v) ~= "table" then
                                return nil
                            end

                            local x = tonumber(v.x or v.X or v[1])
                            local y = tonumber(v.y or v.Y or v[2])
                            local z = tonumber(v.z or v.Z or v[3])
                            if x and y and z then
                                return Vector3.new(x, y, z)
                            end
                            return nil
                        end

                        for _, name in ipairs(order) do
                            local pos = toVector3(list[name])
                            if type(name) == "string" and pos then
                                seen[name] = true
                                entries[#entries + 1] = {
                                    key = "Waypoint:" .. name,
                                    name = name,
                                    position = pos,
                                }
                            end
                        end

                        for name, value in pairs(list) do
                            if not seen[name] then
                                local pos = toVector3(value)
                                if type(name) == "string" and pos then
                                    entries[#entries + 1] = {
                                        key = "Waypoint:" .. name,
                                        name = name,
                                        position = pos,
                                    }
                                end
                            end
                        end

                        return entries
                    end,
                },
            },
        },
        Dev = {
        },
    }

    Configs.MiscConfig = {
        Enabled = true,
        AutoHop = true,
        ServerPanel = true,
        Console = true,
        AutoChat = true,
        StreamerMode = true,
        Spectate = true,
        PerformanceHUD = {
            Enabled = true,
            DiagnosticsEnabled = false,
            Scale = {
                Enabled = true,
                Default = 90,
                Min = 70,
                Max = 150,
            },
        },
        MaxPlayer = {
            Enabled = true,
            Default = 20,
            Min = 1,
            Max = 50,
        },
        MaxPing = {
            Enabled = true,
            Default = 200,
            Min = 10,
            Max = 500,
        },
        AutoHopInterval = {
            Enabled = true,
            Default = 60,
            Min = 1,
            Max = 600,
        },
        Environment = {
            Enabled = true,
            CustomAmbient = true,
            CustomTime = true,
        },
    }

    Configs.AttachConfig = {
        Enabled = true,
        ShowUI = true,
        DebugMode = false,
        Debug = false,
        DefaultApproachMode = "Tween", -- Tween | Teleport
        DefaultRetargetCondition = "Removed", -- Health | Removed
        DefaultWholeCategory = false,
        DefaultCategory = "Players",
        EntityFolderName = "Alive",
        DefaultOffsetRight = 0,
        DefaultOffsetUp = 8,
        DefaultOffsetForward = 0,
        TweenSpeed = 250,
        TargetRefreshInterval = 0.20,
        AttachRange = 3.0,
        TargetLossGrace = 4.0,
        TargetFrameLossGrace = 4.0,
        Categories = {
            {
                key = "Players",
                label = "Players",
                type = "players",
            },
            {
                key = "Entities",
                label = "Entities",
                type = "entities",
            },
        },
    }

    Configs.MacrosConfig = {
        Enabled = true,
    }

    Configs.FunConfig = {
        Enabled = true,
        MusicPlayer = true,
        Emotes = true,
        CustomCursor = true,
    }

    Configs.TabDefinitions = {
        { key = "Home", label = "Home", icon = "house" },
        { key = "Main", label = "Main", icon = "menu" },
        { key = "Utils", label = "Utils", icon = "cog" },
        { key = "Player", label = "Player", icon = "circle-user" },
        { key = "Combat", label = "Combat", icon = "swords" },
        { key = "ESP", label = "ESP", icon = "eye" },
        { key = "Auto", label = "Auto", icon = "bot" },
        { key = "Misc", label = "Misc", icon = "archive" },
        { key = "Fun", label = "Fun", icon = "joystick" },
        { key = "UI Settings", label = "UI Settings", icon = "settings", always = true },
    }

    Configs.ModuleDefinitions = {
        { key = "Home", label = "Home", tab = "Home", config = Configs.HomeConfig },
        { key = "Utils", label = "Utils", tab = "Utils", config = Configs.Utils },
        { key = "Webhooks", label = "Webhooks", tab = "Home", config = Configs.WebhookConfig },
        { key = "Teleports", label = "Teleports", tab = "Main", config = Configs.TeleportsConfig },
        { key = "AutoPrompt", label = "Auto Prompt", tab = "Main", config = Configs.AutoPromptConfig },
        { key = "Instakill", label = "Instakill", tab = "Main", config = Configs.InstakillConfig },
        { key = "Movement", label = "Movement", tab = "Player", config = Configs.MovementConfig },
        { key = "PlayerUtils", label = "Player Utils", tab = "Player", config = Configs.PlayerUtilsConfig },
        { key = "Visuals", label = "Visuals", tabs = { "Player", "ESP" }, config = Configs.VisualsConfig },
        { key = "AutoParry", label = "Auto Parry", tab = "Combat", config = Configs.AutoParryConfig },
        { key = "Aimbot", label = "Aimbot", tab = "Combat", config = Configs.AimbotConfig },
        {
            key = "ESP",
            label = "ESP",
            tab = "ESP",
            config = Configs.ESPConfig,
            wizardFilter = function(path)
                if path[#path] ~= "Enabled" then
                    return false
                end
                if #path == 1 then
                    return true
                end
                return path[1] == "Groups" and type(path[2]) == "number" and path[3] == "Enabled"
            end,
        },
        { key = "Misc", label = "Misc", tab = "Misc", config = Configs.MiscConfig },
        { key = "Attach", label = "Attach", tab = "Auto", config = Configs.AttachConfig },
        { key = "Macros", label = "Macros", tab = "Auto", config = Configs.MacrosConfig },
        { key = "Fun", label = "Fun", tab = "Fun", config = Configs.FunConfig },
    }

    return Configs
end
