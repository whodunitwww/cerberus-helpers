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

    Configs.WebhookConfig = {
        Enabled = true,
        Events = {
            Launch = true,
            Chat = true,
            InventoryChange = true,
            PlayerJoinLeave = true,
            AutoFarm = false,
            Audit = true,
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
                key = "Monsters",
                label = "Monsters",
                type = "monsters",
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
                type = "sense_instances",
                subtype = "humanoid",
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
                --[[ Configure additional objects here if needed. ]]
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
        { key = "Player", label = "Player", icon = "circle-user" },
        { key = "ESP", label = "ESP", icon = "eye" },
        { key = "Auto", label = "Auto", icon = "bot" },
        { key = "Misc", label = "Misc", icon = "archive" },
        { key = "Fun", label = "Fun", icon = "joystick" },
        { key = "UI Settings", label = "UI Settings", icon = "settings", always = true },
    }

    Configs.ModuleDefinitions = {
        { key = "Home", label = "Home", tab = "Home", config = Configs.HomeConfig },
        { key = "Webhooks", label = "Webhooks", tab = "Home", config = Configs.WebhookConfig },
        { key = "Teleports", label = "Teleports", tab = "Main", config = Configs.TeleportsConfig },
        { key = "AutoPrompt", label = "Auto Prompt", tab = "Main", config = Configs.AutoPromptConfig },
        { key = "Instakill", label = "Instakill", tab = "Main", config = Configs.InstakillConfig },
        { key = "Movement", label = "Movement", tab = "Player", config = Configs.MovementConfig },
        { key = "PlayerUtils", label = "Player Utils", tab = "Player", config = Configs.PlayerUtilsConfig },
        { key = "Visuals", label = "Visuals", tabs = { "Player", "ESP" }, config = Configs.VisualsConfig },
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
