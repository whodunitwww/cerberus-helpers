local cloneref = (cloneref or clonereference or function(instance: any) return instance end)
local httpService = cloneref(game:GetService("HttpService"))
local Players = cloneref(game:GetService("Players"))
local isfolder, isfile, listfiles = isfolder, isfile, listfiles

if typeof(copyfunction) == "function" then
    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.
    local
        isfolder_copy,
        isfile_copy,
        listfiles_copy = copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles)

    local isfolder_success, isfolder_error = pcall(function()
        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
    end)

    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return (if success then data else false)
        end

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return (if success then data else false)
        end

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return (if success then data else {})
        end
    end
end

local SaveManager = {} do
    SaveManager.Folder = "ObsidianLibSettings"
    SaveManager.SubFolder = ""
    SaveManager.Ignore = {}
    SaveManager.Library = nil
    SaveManager.PlayerConfigs = {} -- Cache for player specific configs
    SaveManager.WebConfigs = {}
    SaveManager.WebConfigIndex = {}
    SaveManager.SecretKey = nil
    SaveManager.Parser = {
        Toggle = {
            Save = function(idx, object)
                return { type = "Toggle", idx = idx, value = object.Value }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Toggles[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        Slider = {
            Save = function(idx, object)
                return { type = "Slider", idx = idx, value = tostring(object.Value) }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        Dropdown = {
            Save = function(idx, object)
                return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.value then
                    object:SetValue(data.value)
                end
            end,
        },
        ColorPicker = {
            Save = function(idx, object)
                return { type = "ColorPicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
            end,
            Load = function(idx, data)
                if SaveManager.Library.Options[idx] then
                    SaveManager.Library.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
                end
            end,
        },
        KeyPicker = {
            Save = function(idx, object)
                return { type = "KeyPicker", idx = idx, mode = object.Mode, key = object.Value }
            end,
            Load = function(idx, data)
                if SaveManager.Library.Options[idx] then
                    SaveManager.Library.Options[idx]:SetValue({ data.key, data.mode })
                end
            end,
        },
        Input = {
            Save = function(idx, object)
                return { type = "Input", idx = idx, text = object.Value }
            end,
            Load = function(idx, data)
                local object = SaveManager.Library.Options[idx]
                if object and object.Value ~= data.text and type(data.text) == "string" then
                    SaveManager.Library.Options[idx]:SetValue(data.text)
                end
            end,
        },
    }

    local function normalizeWebConfigs(list)
        local configs = {}
        if type(list) == "table" then
            for i, cfg in ipairs(list) do
                if type(cfg) == "table" then
                    local name = tostring(cfg.Name or cfg.name or ("Web Config " .. i))
                    configs[#configs + 1] = {
                        Name = name,
                        Url = cfg.Url or cfg.url,
                        EncryptedUrl = cfg.EncryptedUrl or cfg.encryptedUrl or cfg.EncryptedURL or cfg.encryptedURL,
                        Config = cfg.Config or cfg.config,
                    }
                end
            end
        end
        return configs
    end

    local function decodeBase64(data)
        if type(data) ~= "string" then
            return nil
        end
        local ok, res = pcall(function()
            if crypt and crypt.base64 and crypt.base64.decode then
                return crypt.base64.decode(data)
            elseif bit and bit.base64 and bit.base64.decode then
                return bit.base64.decode(data)
            end
            return httpService:JSONDecode('"' .. data .. '"')
        end)
        if ok and type(res) == "string" then
            return res
        end
        return nil
    end

    local function xorDecrypt(decodedStr, key)
        if type(decodedStr) ~= "string" or decodedStr == "" then
            return nil
        end
        if type(key) ~= "string" or key == "" then
            return nil
        end
        if not (bit32 and bit32.bxor) then
            return nil
        end
        local output = table.create(#decodedStr)
        local keyLen = #key
        for i = 1, #decodedStr do
            local b = string.byte(decodedStr, i, i)
            local k = string.byte(key, (i - 1) % keyLen + 1, (i - 1) % keyLen + 1)
            output[i] = string.char(bit32.bxor(b, k))
        end
        return table.concat(output)
    end

    local function decryptPayload(encryptedString, key)
        if type(encryptedString) ~= "string" then
            return nil, "invalid payload"
        end
        if type(key) ~= "string" or key == "" then
            return nil, "missing key"
        end
        local decodedStr = decodeBase64(encryptedString)
        if not decodedStr then
            return nil, "base64 decode failed"
        end
        local plain = xorDecrypt(decodedStr, key)
        if not plain then
            return nil, "xor decrypt failed"
        end
        return plain
    end

    function SaveManager:SetLibrary(library)
        self.Library = library
    end

    function SaveManager:SetConfigSecrets(secrets)
        if type(secrets) == "table" then
            self.SecretKey = secrets.Key or secrets.ConfigKey or secrets.AutoParryKey
        elseif type(secrets) == "string" then
            self.SecretKey = secrets
        end
    end

    function SaveManager:SetWebConfigs(list)
        self.WebConfigs = normalizeWebConfigs(list)
        self.WebConfigIndex = {}
        for _, cfg in ipairs(self.WebConfigs) do
            if type(cfg.Name) == "string" then
                self.WebConfigIndex[cfg.Name] = cfg
            end
        end
    end

    function SaveManager:IgnoreThemeSettings()
        self:SetIgnoreIndexes({
            "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", "FontFace", -- themes
            "ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName", -- themes
        })
    end

    --// Folders \\--
    function SaveManager:CheckSubFolder(createFolder)
        if typeof(self.SubFolder) ~= "string" or self.SubFolder == "" then return false end

        if createFolder == true then
            if not isfolder(self.Folder .. "/settings/" .. self.SubFolder) then
                makefolder(self.Folder .. "/settings/" .. self.SubFolder)
            end
        end

        return true
    end

    function SaveManager:GetPaths()
        local paths = {}

        local parts = self.Folder:split("/")
        for idx = 1, #parts do
            local path = table.concat(parts, "/", 1, idx)
            if not table.find(paths, path) then paths[#paths + 1] = path end
        end

        paths[#paths + 1] = self.Folder .. "/themes"
        paths[#paths + 1] = self.Folder .. "/settings"

        if self:CheckSubFolder(false) then
            local subFolder = self.Folder .. "/settings/" .. self.SubFolder
            parts = subFolder:split("/")

            for idx = 1, #parts do
                local path = table.concat(parts, "/", 1, idx)
                if not table.find(paths, path) then paths[#paths + 1] = path end
            end
        end

        return paths
    end

    function SaveManager:BuildFolderTree()
        local paths = self:GetPaths()

        for i = 1, #paths do
            local str = paths[i]
            if isfolder(str) then continue end

            makefolder(str)
        end
    end

    function SaveManager:CheckFolderTree()
        if isfolder(self.Folder) then return end
        SaveManager:BuildFolderTree()

        task.wait(0.1)
    end

    function SaveManager:SetIgnoreIndexes(list)
        for _, key in pairs(list) do
            self.Ignore[key] = true
        end
    end

    function SaveManager:SetFolder(folder)
        self.Folder = folder
        self:BuildFolderTree()
    end

    function SaveManager:SetSubFolder(folder)
        self.SubFolder = folder
        self:BuildFolderTree()
    end

    --// Save, Load, Delete, Refresh \\--
    function SaveManager:Save(name)
        if (not name) then
            return false, "no config file is selected"
        end
        SaveManager:CheckFolderTree()

        local fullPath = self.Folder .. "/settings/" .. name .. ".json"
        if SaveManager:CheckSubFolder(true) then
            fullPath = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
        end

        local data = {
            objects = {}
        }

        for idx, toggle in pairs(self.Library.Toggles) do
            if not toggle.Type then continue end
            if not self.Parser[toggle.Type] then continue end
            if self.Ignore[idx] then continue end

            table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
        end

        for idx, option in pairs(self.Library.Options) do
            if not option.Type then continue end
            if not self.Parser[option.Type] then continue end
            if self.Ignore[idx] then continue end

            table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
        end

        local success, encoded = pcall(httpService.JSONEncode, httpService, data)
        if not success then
            return false, "failed to encode data"
        end

        writefile(fullPath, encoded)
        return true
    end

    function SaveManager:ApplyConfigData(decoded)
        if type(decoded) ~= "table" then
            return false, "invalid config data"
        end
        local objects = decoded.objects
        if objects == nil then
            objects = decoded
        end
        if type(objects) ~= "table" then
            return false, "invalid config data"
        end

        for _, option in pairs(objects) do
            if not option.type then continue end
            if not self.Parser[option.type] then continue end

            task.spawn(self.Parser[option.type].Load, option.idx, option)
        end
        return true
    end

    function SaveManager:LoadWebConfig(entry)
        if type(entry) ~= "table" then
            return false, "invalid web config"
        end

        local decoded
        if type(entry.Config) == "table" then
            decoded = entry.Config
        elseif type(entry.EncryptedUrl) == "string" and entry.EncryptedUrl ~= "" then
            local s, r = pcall(game.HttpGet, game, entry.EncryptedUrl)
            if not s then
                return false, "fetch error"
            end
            local payload = r:gsub("%s+", "")
            local plain, err = decryptPayload(payload, self.SecretKey)
            if not plain then
                return false, "decrypt failed: " .. tostring(err)
            end
            local s2, d = pcall(httpService.JSONDecode, httpService, plain)
            if not s2 then
                return false, "decode error"
            end
            decoded = d
        elseif type(entry.Url) == "string" and entry.Url ~= "" then
            local s, r = pcall(game.HttpGet, game, entry.Url)
            if not s then
                return false, "fetch error"
            end
            local s2, d = pcall(httpService.JSONDecode, httpService, r)
            if not s2 then
                return false, "decode error"
            end
            decoded = d
        else
            return false, "missing config source"
        end

        return self:ApplyConfigData(decoded)
    end

    function SaveManager:Load(name)
        if (not name) then
            return false, "no config file is selected"
        end
        SaveManager:CheckFolderTree()

        local webConfig = self.WebConfigIndex and self.WebConfigIndex[name]
        if webConfig then
            return self:LoadWebConfig(webConfig)
        end

        local file = self.Folder .. "/settings/" .. name .. ".json"
        if SaveManager:CheckSubFolder(true) then
            file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
        end

        if not isfile(file) then return false, "invalid file" end

        local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))
        if not success then return false, "decode error" end
        return self:ApplyConfigData(decoded)
    end

    function SaveManager:Delete(name)
        if (not name) then
            return false, "no config file is selected"
        end

        local file = self.Folder .. "/settings/" .. name .. ".json"
        if SaveManager:CheckSubFolder(true) then
            file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
        end

        if not isfile(file) then return false, "invalid file" end

        local success = pcall(delfile, file)
        if not success then return false, "delete file error" end

        return true
    end

    function SaveManager:RefreshConfigList()
        local success, data = pcall(function()
            SaveManager:CheckFolderTree()

            local list = {}
            local out = {}

            if SaveManager:CheckSubFolder(true) then
                list = listfiles(self.Folder .. "/settings/" .. self.SubFolder)
            else
                list = listfiles(self.Folder .. "/settings")
            end
            if typeof(list) ~= "table" then list = {} end

            for i = 1, #list do
                local file = list[i]
                if file:sub(-5) == ".json" then
                    local pos = file:find(".json", 1, true)
                    local start = pos

                    local char = file:sub(pos, pos)
                    while char ~= "/" and char ~= "\\" and char ~= "" do
                        pos = pos - 1
                        char = file:sub(pos, pos)
                    end

                    if char == "/" or char == "\\" then
                        local cfgName = file:sub(pos + 1, start - 1)
                        if cfgName ~= "autoload_players" then -- Exclude our internal file
                            table.insert(out, cfgName)
                        end
                    end
                end
            end

            return out
        end)

        if (not success) then
            if self.Library then
                self.Library:Notify("Failed to load config list: " .. tostring(data))
            else
                warn("Failed to load config list: " .. tostring(data))
            end

            return {}
        end

        local merged = data
        if type(self.WebConfigs) == "table" then
            for _, cfg in ipairs(self.WebConfigs) do
                if cfg.Name and not table.find(merged, cfg.Name) then
                    table.insert(merged, cfg.Name)
                end
            end
        end

        return merged
    end

    --// Player Autoload Helpers \\--
    function SaveManager:GetPlayerConfigPath()
        local path = self.Folder .. "/settings/autoload_players.json"
        if SaveManager:CheckSubFolder(true) then
            path = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload_players.json"
        end
        return path
    end

    function SaveManager:LoadPlayerConfigs()
        local path = self:GetPlayerConfigPath()
        if isfile(path) then
            local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(path))
            if success and type(decoded) == "table" then
                self.PlayerConfigs = decoded
            else
                self.PlayerConfigs = {}
            end
        else
            self.PlayerConfigs = {}
        end
        return self.PlayerConfigs
    end

    function SaveManager:SavePlayerConfigs()
        local path = self:GetPlayerConfigPath()
        local success, encoded = pcall(httpService.JSONEncode, httpService, self.PlayerConfigs)
        if success then
            writefile(path, encoded)
        end
        return success
    end

    --// Auto Load \\--
    function SaveManager:GetAutoloadConfig()
        SaveManager:CheckFolderTree()

        -- 1. Check for Per-Player Config
        self:LoadPlayerConfigs()
        local localPlayerName = Players.LocalPlayer.Name
        if self.PlayerConfigs[localPlayerName] and self.PlayerConfigs[localPlayerName] ~= "" then
            return self.PlayerConfigs[localPlayerName]
        end

        -- 2. Fallback to Global Autoload
        local autoLoadPath = self.Folder .. "/settings/autoload.txt"
        if SaveManager:CheckSubFolder(true) then
            autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
        end

        if isfile(autoLoadPath) then
            local successRead, name = pcall(readfile, autoLoadPath)
            if not successRead then return "none" end
            name = tostring(name)
            return if name == "" then "none" else name
        end

        return "none"
    end

    function SaveManager:LoadAutoloadConfig()
        SaveManager:CheckFolderTree()

        local configName = self:GetAutoloadConfig()
        
        if configName ~= "none" then
            local success, err = self:Load(configName)
            if not success then
                return self.Library:Notify("Failed to load autoload config: " .. err)
            end
            self.Library:Notify(string.format("Auto loaded config %q", configName))
        end
    end

    function SaveManager:SaveAutoloadConfig(name, target)
        SaveManager:CheckFolderTree()

        if target and target ~= "Global" then
            -- Save for specific player
            self:LoadPlayerConfigs() 
            self.PlayerConfigs[target] = name
            if not self:SavePlayerConfigs() then
                return false, "write file error (player)"
            end
            return true, ""
        else
            -- Save Global
            local autoLoadPath = self.Folder .. "/settings/autoload.txt"
            if SaveManager:CheckSubFolder(true) then
                autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
            end

            local success = pcall(writefile, autoLoadPath, name)
            if not success then return false, "write file error" end
            return true, ""
        end
    end

    function SaveManager:DeleteAutoLoadConfig(target)
        SaveManager:CheckFolderTree()

        if target and target ~= "Global" then
            -- Clear for specific player (set to empty string, keeping them in list)
            self:LoadPlayerConfigs()
            if self.PlayerConfigs[target] then
                self.PlayerConfigs[target] = "" -- Empty string means no config assigned
                self:SavePlayerConfigs()
            end
            return true, ""
        else
            -- Delete Global
            local autoLoadPath = self.Folder .. "/settings/autoload.txt"
            if SaveManager:CheckSubFolder(true) then
                autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
            end

            local success = pcall(delfile, autoLoadPath)
            if not success then return false, "delete file error" end
            return true, ""
        end
    end

    --// GUI \\--
    function SaveManager:BuildConfigSection(tab)
        assert(self.Library, "Must set SaveManager.Library")

        local section = tab:AddRightGroupbox("Configuration", "folder-cog")

        section:AddInput("SaveManager_ConfigName",    { Text = "Config name" })
        section:AddButton("Create config", function()
            local name = self.Library.Options.SaveManager_ConfigName.Value

            if name:gsub(" ", "") == "" then
                return self.Library:Notify("Invalid config name (empty)", 2)
            end

            local success, err = self:Save(name)
            if not success then
                return self.Library:Notify("Failed to create config: " .. err)
            end

            self.Library:Notify(string.format("Created config %q", name))

            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddDivider()

        section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })
        section:AddButton("Load config", function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Load(name)
            if not success then
                return self.Library:Notify("Failed to load config: " .. err)
            end

            self.Library:Notify(string.format("Loaded config %q", name))
        end)
        section:AddButton("Overwrite config", function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Save(name)
            if not success then
                return self.Library:Notify("Failed to overwrite config: " .. err)
            end

            self.Library:Notify(string.format("Overwrote config %q", name))
        end)

        section:AddButton("Delete config", function()
            local name = self.Library.Options.SaveManager_ConfigList.Value

            local success, err = self:Delete(name)
            if not success then
                return self.Library:Notify("Failed to delete config: " .. err)
            end

            self.Library:Notify(string.format("Deleted config %q", name))
            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddButton("Refresh list", function()
            self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
            self.Library.Options.SaveManager_ConfigList:SetValue(nil)
        end)

        section:AddDivider()
        
        --// Autoload Logic \\--
        
        -- Helper to get dropdown values for players
        local function GetAutoloadTargets()
            local targets = { "Global" }
            self:LoadPlayerConfigs()
            for name, _ in pairs(self.PlayerConfigs) do
                table.insert(targets, name)
            end
            return targets
        end

        section:AddDropdown("SaveManager_AutoloadTarget", { Text = "Autoload Target", Values = GetAutoloadTargets(), Default = "Global", AllowNull = false })
        
        section:AddButton("Set as autoload", function()
            local name = self.Library.Options.SaveManager_ConfigList.Value
            local target = self.Library.Options.SaveManager_AutoloadTarget.Value

            if name == nil then 
                return self.Library:Notify("No config selected to set as autoload")
            end

            local success, err = self:SaveAutoloadConfig(name, target)
            if not success then
                return self.Library:Notify("Failed to set autoload config: " .. err)
            end

            self.Library:Notify(string.format("Set %q to auto load for %s", name, target))
            SaveManager.AutoloadLabel:SetText("Current autoload config: " .. self:GetAutoloadConfig())
        end)

        section:AddButton("Reset autoload", function()
            local target = self.Library.Options.SaveManager_AutoloadTarget.Value
            local success, err = self:DeleteAutoLoadConfig(target)
            if not success then
                return self.Library:Notify("Failed to reset autoload config: " .. err)
            end

            self.Library:Notify("Reset autoload for " .. target)
            SaveManager.AutoloadLabel:SetText("Current autoload config: " .. self:GetAutoloadConfig())
        end)

        self.AutoloadLabel = section:AddLabel("Current autoload config: " .. self:GetAutoloadConfig(), true)

        section:AddDivider()

        -- Groupbox for Player Management
        local playerGroup = tab:AddRightGroupbox("Player Management", "users")
        
        playerGroup:AddInput("SaveManager_PlayerInput", { Text = "Username" })
        
        playerGroup:AddButton("Add User to List", function()
            local username = self.Library.Options.SaveManager_PlayerInput.Value
            if username:gsub(" ", "") == "" then
                return self.Library:Notify("Invalid username")
            end

            self:LoadPlayerConfigs()
            if not self.PlayerConfigs[username] then
                self.PlayerConfigs[username] = "" -- Add with empty config
                self:SavePlayerConfigs()
                self.Library.Options.SaveManager_AutoloadTarget:SetValues(GetAutoloadTargets())
                self.Library:Notify("Added " .. username .. " to player list")
            else
                self.Library:Notify("User already in list")
            end
        end)

        playerGroup:AddButton("Remove User from List", function()
            local target = self.Library.Options.SaveManager_AutoloadTarget.Value
            if target == "Global" then
                return self.Library:Notify("Cannot remove Global from list")
            end

            self:LoadPlayerConfigs()
            if self.PlayerConfigs[target] ~= nil then
                self.PlayerConfigs[target] = nil -- Remove key
                self:SavePlayerConfigs()
                self.Library.Options.SaveManager_AutoloadTarget:SetValues(GetAutoloadTargets())
                self.Library.Options.SaveManager_AutoloadTarget:SetValue("Global")
                self.Library:Notify("Removed " .. target .. " from list")
            else
                self.Library:Notify("User not found in list")
            end
        end)

        self:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName", "SaveManager_AutoloadTarget", "SaveManager_PlayerInput" })
    end

    SaveManager:BuildFolderTree()
end

return SaveManager
