-- setupWizard.lua
-- Pre-run setup wizard that builds a config profile and saves it per game.
return function(ctx)
    local Services = ctx.Services
    local References = ctx.References
    local UILib = ctx.UILib
    local Modules = ctx.Modules or {}
    local Tabs = ctx.Tabs or {}
    local WizardTabs = {}

    local function isWizardTab(tab)
        return type(tab) == "table" and tab.key ~= "UI Settings"
    end

    local function moduleVisible(mod)
        if not mod or type(mod) ~= "table" then
            return false
        end
        if mod.hidden == true or mod.wizardHidden == true then
            return false
        end
        if type(mod.config) == "table" and mod.config.Enabled == false then
            return false
        end
        return true
    end

    local function tabHasVisibleModules(tabKey)
        for _, mod in ipairs(Modules) do
            if moduleVisible(mod) then
                if mod.tab == tabKey then
                    return true
                end
                if mod.tabs and type(mod.tabs) == "table" and table.find(mod.tabs, tabKey) then
                    return true
                end
            end
        end
        return false
    end

    for _, tab in ipairs(Tabs) do
        if isWizardTab(tab) and tabHasVisibleModules(tab.key) then
            WizardTabs[#WizardTabs + 1] = tab
        end
    end

    local HttpService = Services.HttpService
    local savePath = References.gameDir .. "/setup.json"

    local function readJson(path)
        if isfile and isfile(path) then
            local ok, data = pcall(readfile, path)
            if ok and type(data) == "string" and #data > 0 then
                local ok2, obj = pcall(function()
                    return HttpService:JSONDecode(data)
                end)
                if ok2 and type(obj) == "table" then
                    return obj
                end
            end
        end
        return nil
    end

    local function writeJson(path, obj)
        if not writefile then
            return false
        end
        local ok, encoded = pcall(function()
            return HttpService:JSONEncode(obj)
        end)
        if not ok then
            return false
        end
        pcall(writefile, path, encoded)
        return true
    end

    local function prettyName(s)
        s = tostring(s or "")
        s = s:gsub("_", " ")
        s = s:gsub("(%l)(%u)", "%1 %2")
        s = s:gsub("(%u)(%u%l)", "%1 %2")
        s = s:gsub("%s+", " ")
        s = s:gsub("^%s+", ""):gsub("%s+$", "")
        if s == "" then
            return "Item"
        end
        return s
    end

    local function describePath(root, path)
        local parts = {}
        local node = root
        for i = 1, #path do
            local key = path[i]
            local child = type(node) == "table" and node[key] or nil
            if type(key) == "number" then
                if type(child) == "table" then
                    local label = child.title or child.label or child.key
                    if type(label) == "string" then
                        parts[#parts + 1] = label
                    end
                end
            elseif key ~= "Enabled" then
                parts[#parts + 1] = prettyName(key)
            end
            node = child
        end
        if #parts == 0 then
            return "Enabled"
        end
        return table.concat(parts, " / ")
    end

    local IGNORE_KEYS = {
        Dev = true,
        Defaults = true,
        DodgeConfig = true,
        AutoYOffsetConfig = true,
    }

    local function collectToggles(root, node, path, out, filter)
        if type(node) ~= "table" then
            return
        end
        for k, v in pairs(node) do
            if not IGNORE_KEYS[k] then
                if type(v) == "boolean" then
                    local p = { table.unpack(path) }
                    p[#p + 1] = k
                    if not filter or filter(p, v, root) then
                        out[#out + 1] = {
                            path = p,
                            label = describePath(root, p),
                            default = v,
                        }
                    end
                elseif type(v) == "table" then
                    local p = { table.unpack(path) }
                    p[#p + 1] = k
                    collectToggles(root, v, p, out, filter)
                end
            end
        end
    end

    local function setPath(tbl, path, value)
        local t = tbl
        for i = 1, #path - 1 do
            local k = path[i]
            if type(t[k]) ~= "table" then
                t[k] = {}
            end
            t = t[k]
        end
        t[path[#path]] = value
    end

    local function allTabsEnabled()
        local out = {}
        for _, tab in ipairs(WizardTabs) do
            out[tab.key] = true
        end
        return out
    end

    local function buildAllOverrides()
        local out = {}
        for _, mod in ipairs(Modules) do
            if moduleVisible(mod) then
                local cfg = mod.config
                local toggles = {}
                if type(cfg) == "table" then
                    collectToggles(cfg, cfg, {}, toggles, mod.wizardFilter)
                    local modOut = {}
                    for _, item in ipairs(toggles) do
                        setPath(modOut, item.path, item.default == true)
                    end
                    out[mod.key] = modOut
                end
            end
        end
        return out
    end

    local saved = readJson(savePath)
    if saved and type(saved) == "table" and saved.mode then
        return saved
    end

    if type(UILib) == "function" then
        UILib = UILib()
    end

    local ui = UILib.new({
        Title = "Cerberus Setup",
        Name = "CerberusSetupUI",
    })
    local theme = ui.Theme or {}

    local done = Instance.new("BindableEvent")
    local result

    local pageMode = ui:CreatePage("mode", "Cerberus Setup")
    do
        local hero = Instance.new("Frame")
        hero.BackgroundColor3 = theme.panel2 or Color3.fromRGB(34, 36, 44)
        hero.BorderSizePixel = 0
        hero.Size = UDim2.new(1, 0, 0, 128)
        hero.Parent = pageMode.Frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = hero

        local stroke = Instance.new("UIStroke")
        stroke.Color = theme.border or Color3.fromRGB(50, 54, 64)
        stroke.Thickness = 1
        stroke.Parent = hero

        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, theme.panel2 or Color3.fromRGB(34, 36, 44)),
            ColorSequenceKeypoint.new(1, theme.bg or Color3.fromRGB(20, 22, 28)),
        })
        gradient.Rotation = 90
        gradient.Parent = hero

        local accent = Instance.new("Frame")
        accent.BackgroundColor3 = theme.accent or Color3.fromRGB(54, 178, 110)
        accent.BorderSizePixel = 0
        accent.Position = UDim2.new(0, 12, 0, 10)
        accent.Size = UDim2.new(0, 6, 1, -20)
        accent.Parent = hero
        local accentCorner = Instance.new("UICorner")
        accentCorner.CornerRadius = UDim.new(0, 4)
        accentCorner.Parent = accent

        local heroTitle = Instance.new("TextLabel")
        heroTitle.BackgroundTransparency = 1
        heroTitle.Position = UDim2.new(0, 28, 0, 12)
        heroTitle.Size = UDim2.new(1, -140, 0, 24)
        heroTitle.Font = Enum.Font.GothamBlack
        heroTitle.Text = "Welcome to Cerberus Setup"
        heroTitle.TextColor3 = theme.text or Color3.new(1, 1, 1)
        heroTitle.TextSize = 18
        heroTitle.TextXAlignment = Enum.TextXAlignment.Left
        heroTitle.Parent = hero

        local heroSub = Instance.new("TextLabel")
        heroSub.BackgroundTransparency = 1
        heroSub.Position = UDim2.new(0, 28, 0, 42)
        heroSub.Size = UDim2.new(1, -140, 0, 60)
        heroSub.Font = Enum.Font.Gotham
        heroSub.Text = "Pick a quick preset or fine-tune tabs one by one. Only enable what you actually use."
        heroSub.TextColor3 = theme.subtext or Color3.fromRGB(180, 180, 180)
        heroSub.TextSize = 13
        heroSub.TextWrapped = true
        heroSub.TextXAlignment = Enum.TextXAlignment.Left
        heroSub.TextYAlignment = Enum.TextYAlignment.Top
        heroSub.Parent = hero

        local heroTag = Instance.new("TextLabel")
        heroTag.BackgroundColor3 = theme.accent or Color3.fromRGB(54, 178, 110)
        heroTag.BorderSizePixel = 0
        heroTag.Position = UDim2.new(1, -96, 0, 12)
        heroTag.Size = UDim2.new(0, 84, 0, 22)
        heroTag.Font = Enum.Font.GothamBold
        heroTag.Text = "STEP 1"
        heroTag.TextColor3 = theme.text or Color3.new(1, 1, 1)
        heroTag.TextSize = 11
        heroTag.Parent = hero
        local tagCorner = Instance.new("UICorner")
        tagCorner.CornerRadius = UDim.new(0, 6)
        tagCorner.Parent = heroTag
    end

    pageMode:AddSpacer(12)
    pageMode:AddSection("Choose your setup")
    pageMode:AddLabel("Quick preset now, or customize tab by tab.", true)
    pageMode:AddSpacer(6)

    local modeGrid = pageMode:AddCardGrid(1, 120)
    modeGrid:AddActionCard(
        "Include Everything",
        "Enable every tab while keeping default feature settings.",
        function()
            result = {
                mode = "all",
                tabs = allTabsEnabled(),
                modules = buildAllOverrides(),
            }
            writeJson(savePath, result)
            done:Fire()
        end,
        true,
        "RECOMMENDED"
    )
    modeGrid:AddActionCard(
        "Custom Setup",
        "Pick the tabs you want, then toggle features per module.",
        function()
            ui:ShowPage("tabs")
        end,
        false,
        "CUSTOM"
    )

    local buildFlow
    local buildResult
    local renderTabConfig

    local pageTabs = ui:CreatePage("tabs", "Select Tabs")
    pageTabs:AddLabel("Choose the tabs you want in the main UI.")
    pageTabs:AddLabel("UI Settings is always included and does not appear here.", true)
    pageTabs:AddDivider()

    local tabToggles = {}
    do
        local grid = pageTabs:AddCardGrid(2, 92)
        for _, tab in ipairs(WizardTabs) do
            local card = grid:AddToggleCard(tab.label or tab.key, true, nil, "Click Configure to edit this tab.")
            tabToggles[tab.key] = card

            local cfgBtn = Instance.new("TextButton")
            cfgBtn.BackgroundColor3 = theme.panel or Color3.fromRGB(28, 30, 36)
            cfgBtn.BorderSizePixel = 0
            cfgBtn.Position = UDim2.new(1, -84, 1, -28)
            cfgBtn.Size = UDim2.new(0, 72, 0, 20)
            cfgBtn.Font = Enum.Font.GothamBold
            cfgBtn.Text = "Configure"
            cfgBtn.TextColor3 = theme.text or Color3.new(1, 1, 1)
            cfgBtn.TextSize = 11
            cfgBtn.ZIndex = (card.Frame.ZIndex or 1) + 2
            cfgBtn.Parent = card.Frame
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = cfgBtn
            local stroke = Instance.new("UIStroke")
            stroke.Color = theme.border or Color3.fromRGB(50, 54, 64)
            stroke.Thickness = 1
            stroke.Parent = cfgBtn

            cfgBtn.MouseButton1Click:Connect(function()
                buildFlow()
                renderTabConfig(tab.key)
                ui:ShowPage("features")
            end)
        end
    end

    pageTabs:AddDivider()
    pageTabs:AddButton("Select All Tabs", function()
        for _, tgl in pairs(tabToggles) do
            tgl.SetValue(true)
        end
    end, false)
    pageTabs:AddButton("Select No Tabs", function()
        for _, tgl in pairs(tabToggles) do
            tgl.SetValue(false)
        end
    end, false)
    pageTabs:AddButton("Back", function()
        ui:ShowPage("mode")
    end, false)

    local pageFeatures = ui:CreatePage("features", "Tab Setup")
    local moduleStates = {}
    local moduleTabMap = {}

    local function moduleAllowed(mod, tabsEnabled)
        if not moduleVisible(mod) then
            return false
        end
        if mod.tabs and type(mod.tabs) == "table" then
            for _, t in ipairs(mod.tabs) do
                if not tabsEnabled[t] then
                    return false
                end
            end
            return true
        end
        if mod.tab then
            return tabsEnabled[mod.tab] == true
        end
        return true
    end

    local function seedModuleState(mod)
        if moduleStates[mod.key] then
            return
        end
        local state = {}
        local toggles = {}
        if type(mod.config) == "table" then
            collectToggles(mod.config, mod.config, {}, toggles, mod.wizardFilter)
        end
        for _, item in ipairs(toggles) do
            state[table.concat(item.path, ".")] = item.default == true
        end
        moduleStates[mod.key] = state
    end

    local function getTabsEnabled()
        local out = {}
        for _, tab in ipairs(WizardTabs) do
            local tgl = tabToggles[tab.key]
            out[tab.key] = tgl and tgl.Value == true or false
        end
        return out
    end

    buildFlow = function()
        moduleTabMap = {}
        local tabsEnabled = getTabsEnabled()

        for _, mod in ipairs(Modules) do
            if moduleAllowed(mod, tabsEnabled) then
                seedModuleState(mod)
                local assigned
                if mod.tabs and type(mod.tabs) == "table" then
                    for _, tab in ipairs(WizardTabs) do
                        if tabsEnabled[tab.key] and table.find(mod.tabs, tab.key) then
                            assigned = tab.key
                            break
                        end
                    end
                elseif mod.tab and tabsEnabled[mod.tab] then
                    assigned = mod.tab
                end
                moduleTabMap[mod.key] = assigned
            end
        end

        return tabsEnabled
    end

    buildResult = function()
        local tabsOut = getTabsEnabled()
        buildFlow()

        local modulesOut = {}
        for _, mod in ipairs(Modules) do
            if moduleVisible(mod) then
                seedModuleState(mod)
                local state = moduleStates[mod.key]
                if state then
                    local modOut = {}
                    for key, val in pairs(state) do
                        local path = {}
                        for part in string.gmatch(key, "[^%.]+") do
                            path[#path + 1] = part
                        end
                        setPath(modOut, path, val == true)
                    end
                    modulesOut[mod.key] = modOut
                end
            end
        end

        result = {
            mode = "custom",
            tabs = tabsOut,
            modules = modulesOut,
        }
        writeJson(savePath, result)
        done:Fire()
    end

    local function clearFrame()
        for _, child in ipairs(pageFeatures.Frame:GetChildren()) do
            child:Destroy()
        end
    end

    local function addPadding()
        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 32)
        pad.PaddingRight = UDim.new(0, 32)
        pad.PaddingTop = UDim.new(0, 20)
        pad.PaddingBottom = UDim.new(0, 32)
        pad.Parent = pageFeatures.Frame
    end

    local function addLayout()
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = pageFeatures.Frame
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            pageFeatures.Frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 32)
        end)
    end

    renderTabConfig = function(tabKey)
        clearFrame()
        addPadding()
        addLayout()

        local tab
        for _, tabDef in ipairs(WizardTabs) do
            if tabDef.key == tabKey then
                tab = tabDef
                break
            end
        end
        if not tab then
            ui:ShowPage("tabs")
            return
        end

        ui:SetTitle((tab.label or tab.key) .. " Setup")

        pageFeatures:AddLabel((tab.label or tab.key) .. " setup")
        pageFeatures:AddLabel("Pick the features you want to keep for this tab.", true)
        pageFeatures:AddDivider()

        local tabsEnabled = buildFlow()
        if not tabsEnabled[tab.key] then
            pageFeatures:AddLabel("This tab is disabled in the main UI. Enable it to load its modules.", true)
            pageFeatures:AddDivider()
        end

        local tabCards = {}
        local hasModules = false

        for _, mod in ipairs(Modules) do
            if moduleTabMap[mod.key] == tab.key then
                hasModules = true
                pageFeatures:AddSection(mod.label or mod.key)

                local grid = pageFeatures:AddCardGrid(2, 78)
                local toggles = {}
                if type(mod.config) == "table" then
                    collectToggles(mod.config, mod.config, {}, toggles, mod.wizardFilter)
                end
                table.sort(toggles, function(a, b)
                    return tostring(a.label) < tostring(b.label)
                end)

                for _, item in ipairs(toggles) do
                    local key = table.concat(item.path, ".")
                    local state = moduleStates[mod.key][key]
                    local card = grid:AddToggleCard(item.label, state, function(val)
                        moduleStates[mod.key][key] = val == true
                    end)
                    tabCards[#tabCards + 1] = card
                end
            end
        end

        if not hasModules then
            pageFeatures:AddLabel("No configurable features in this tab.", true)
        end

        pageFeatures:AddDivider()
        if #tabCards > 0 then
            pageFeatures:AddButton("Enable All In Tab", function()
                for _, card in ipairs(tabCards) do
                    card.SetValue(true)
                end
            end, false)
            pageFeatures:AddButton("Disable All In Tab", function()
                for _, card in ipairs(tabCards) do
                    card.SetValue(false)
                end
            end, false)
        end

        pageFeatures:AddButton("Back to Tabs", function()
            ui:ShowPage("tabs")
        end, false)
        pageFeatures:AddButton("Save & Continue", function()
            buildResult()
        end, true)
        pageFeatures:AddSpacer(12)
    end

    pageTabs:AddButton("Save & Continue", function()
        buildResult()
    end, true)
    pageTabs:AddSpacer(12)

    ui:ShowPage("mode")
    done.Event:Wait()
    ui:Destroy()

    return result
end
