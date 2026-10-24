--[[
                                        ==                                     
                             =   ===    ====     ==                            
                            ========   =======  ====     ==                    
                           =========    ============     ===  ==               
                        ============    ===============  ========              
                      =============== ================== ==========            
                    =====  ======================   ====== ==========          
                 =================== ======================== === ====         
                 ================== ====================================       
                  =======================================================      
                   =====================================================       
                           ====== ==================     ========= ===         
                           ====== =============================                
                           ========================= =========           =     
                           ===================================         ==      
                          =====================================       ===      
                          ======================================     ====      
                           ======================================    ====      
                           ========================================   =====    
                            ========================================   =====   
                           ==========================================   ====   
                           ========= === ============================   -====  
                          =========     ============= ================   ====  
                          ========      ============= ================   ====  
                         ========      ============== ================  ====   
                         =======       ======= ======= ===============  ===    
                        =======       =======   ======== =================     
                     ==========   ==========      ===== ==============         
                   ===========   ===========    ===== ===============          
                   ==========   ===========    ===== ==============            
]]













































































































































































local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")

local GITHUB_BASE_URL  = "https://raw.githubusercontent.com/safetrademarketplace/scripts/refs/heads/main/"
local UNIVERSAL_URL    = "https://api.luarmor.net/files/v4/loaders/1acad587672d96c8afb9c5bbc36bf921.lua"
local DISCORD_URL      = "https://getcerberus.com/discord"
local CHIMERA_DISCORD  = "https://discord.gg/fhErCU8GJx"
local CHIMERA_LOGO     = "rbxassetid://109836038071568"
local SUNC_RESULTS     = "https://r.sunc.su/w6aTeygyt9"
local MYRIAD_RESULTS   = "https://myriad.tools/view/s/e195a47b49"
local SKIP_FOLDER      = "Cerberus"
local SKIP_FILE        = "Cerberus/executor_warning.txt"
local LOGO_ASSET       = "rbxassetid://136497541793809"

-- off chimera, a keyless run waits FREE_WAIT; a keyed run gets a short pitch one run in PAID_PITCH_ODDS
local FREE_WAIT        = 30
local PAID_PITCH_WAIT  = 5
local PAID_PITCH_ODDS  = 3

-- the window, shrunk to fit small screens; the pitch slides fill its body between the header and the progress bar
local WIN_W, WIN_H     = 560, 380
local SLIDE_W, SLIDE_H = WIN_W - 44, WIN_H - 174

-- cerberus' own look; every surface the pitch re-dresses reads a palette shaped like this one
local C = {
    bg        = Color3.fromRGB(12, 15, 21),
    surface   = Color3.fromRGB(20, 25, 33),
    surface2  = Color3.fromRGB(27, 33, 43),
    track     = Color3.fromRGB(38, 44, 56),
    text      = Color3.fromRGB(233, 240, 250),
    subtext   = Color3.fromRGB(140, 150, 166),
    faint     = Color3.fromRGB(92, 102, 118),
    accent    = Color3.fromRGB(90, 255, 140),
    accentHi  = Color3.fromRGB(150, 255, 190),
    accentDk  = Color3.fromRGB(6, 28, 16),
    danger    = Color3.fromRGB(255, 96, 96),
    amber     = Color3.fromRGB(255, 184, 70),
    white     = Color3.fromRGB(255, 255, 255),
    edge      = Color3.fromRGB(255, 255, 255),
    edgeFade  = 0.9,
}

-- chimera's crest theme (chimera-v5 build-config/ui-theme.json): near-black panels, quiet 1px lines, gold on dark ink
local CH = {
    bg        = Color3.fromRGB(12, 13, 13),
    surface   = Color3.fromRGB(23, 24, 26),
    surface2  = Color3.fromRGB(34, 35, 37),
    track     = Color3.fromRGB(44, 45, 48),
    text      = Color3.fromRGB(230, 231, 234),
    textSoft  = Color3.fromRGB(205, 208, 213),
    subtext   = Color3.fromRGB(159, 163, 173),
    faint     = Color3.fromRGB(127, 133, 143),
    accent    = Color3.fromRGB(214, 168, 78),
    accentHi  = Color3.fromRGB(237, 201, 119),
    accentDk  = Color3.fromRGB(26, 20, 8),
    teal      = Color3.fromRGB(93, 192, 179),
    lineSoft  = Color3.fromRGB(40, 41, 44),
    danger    = C.danger,
    amber     = C.amber,
    white     = C.white,
    edge      = Color3.fromRGB(57, 59, 63),
    edgeFade  = 0,
}
local GOLD_HEX = "#d6a84e"
-- a word in chimera's gold italics, for rich-text headlines
local function gold(word) return ('<i><font color="%s">%s</font></i>'):format(GOLD_HEX, word) end

local UNIVERSE_MAP = {
    ["3764534614"] = "runeSlayer.lua", ["6115988515"] = "animeSaga.lua", ["7095682825"] = "beaks.lua",
    ["4777817887"] = "bladeBall.lua", ["18668065416"] = "blueLock.lua", ["85896571713843"] = "bgsi.lua",
    ["7018190066"] = "deadRails.lua", ["2880808628"] = "ffo.lua", ["5750914919"] = "fisch.lua",
    ["6331902150"] = "foresaken.lua", ["7436755782"] = "gag.lua", ["2535080489"] = "herosOnline.lua",
    ["7314989375"] = "hunters.lua", ["6048923315"] = "kaizen.lua", ["7513130835"] = "untitledDrillGame.lua",
    ["6931042565"] = "volleyballLegends.lua", ["4931927012"] = "basketballLegends.lua",
    ["6770632849"] = "mugen.lua", ["7218065222"] = "dig.lua", ["4737765103"] = "murimCultivation.lua",
    ["4871329703"] = "typeSoul.lua", ["5569032992"] = "dandysWorld.lua", ["7709344486"] = "stealABrainrot.lua",
    ["5677613211"] = "eatTheWorld.lua", ["7822444776"] = "buildAPlane.lua", ["7326934954"] = "99NITF.lua",
    ["4862269388"] = "archived.lua", ["8051387991"] = "rebornCultivation.lua", ["7882829745"] = "animeEternal.lua",
    ["7219654364"] = "murderersVsSheriffs.lua", ["1946714362"] = "bloodlines.lua", ["7718422952"] = "newMoon.lua",
    ["7671049560"] = "theForge.lua", ["6490954291"] = "ghoulRe.lua", ["9391202356"] = "ghoulRe.lua",
    ["7440311707"] = "demonHunter.lua", ["7024319539"] = "reawakened.lua", ["9363735110"] = "tsunamiBrainrot.lua",
    ["9344307274"] = "breakALuckyBlock.lua", ["5831253580"] = "sorcererAscent.lua", ["1828997286"] = "excry.lua",
    ["8144728961"] = "abyss.lua", ["6701277882"] = "fishIt.lua", ["9649298941"] = "ELFB.lua",
    ["9563386957"] = "CFB.lua", ["7048187681"] = "slayerbound.lua", ["9484779066"] = "SAB.lua",
    ["7983308985"] = "lastLetter.lua", ["648454481"] = "GPO.lua", ["9509842868"] = "gardenHorizons.lua",
    ["5130394318"] = "bizzareLineage.lua", ["9663968307"] = "hooked.lua", ["9872691883"] = "everwind.lua",
    ["4818959878"] = "mashle.lua", ["3726919761"] = "cursedGear.lua", ["8524572339"] = "bridger.lua",
    ["8202280624"] = "bbn.lua", ["9186719164"] = "sailor.lua", ["6161049307"] = "pixelBlade.lua",
    ["3646793294"] = "paradox.lua", ["4658598196"] = "aotr.lua", ["10016841656"] = "noobTD.lua",
    ["1359573625"] = "deepwoken.lua", ["9792947201"] = "slime.lua", ["6409513651"] = "animeWarriors3.lua",
    ["10006104044"] = "wizardsAlchemy.lua", ["2309918273"] = "vv.lua", ["9826885587"] = "evomon.lua",
    ["10200395747"] = "gag2.lua", ["2644656496"] = "hazeSeas.lua", ["9199655655"] = "gakuran.lua",
    ["7613921865"] = "animeExpeditions.lua", ["4827308727"] = "havoc.lua", ["7395930870"] = "sellLemons.lua",
    ["10148749921"] = "animalHospital.lua", ["1511883870"] = "shindoLife.lua", ["7529591378"] = "practicalBasketball.lua", ["578392296"] = "aba.lua",
    ["6035872082"] = "rivals.lua", ["6385532960"] = "ryujin.lua", ["10563114921"] = "stealAnEgg.lua", ["4760747038"] = "wonderland.lua",
    ["6739698191"] = "violenceDistrict.lua", ["9931749389"] = "dqr.lua", ["2459091562"] = "RH2.lua", ["7970033072"] = "theVeil.lua",
    ["5595353122"] = "projectSlayers2.lua", ["3164482049"] = "cloverRPG.lua"
}

local FREE_SCRIPTS = {
    ["animeExpeditions.lua"] = true, ["gag2.lua"] = true, ["slime.lua"] = true, ["deepwoken.lua"] = true,
    ["sellLemons.lua"] = true, ["animalHospital.lua"] = true, ["animeWarriors3.lua"] = true, ["bbn.lua"] = true,
    ["shindoLife.lua"] = true, ["practicalBasketball.lua"] = true, ["aba.lua"] = true, ["rivals.lua"] = true, ["ryujin.lua"] = true,
    ["stealAnEgg.lua"] = true, ["wonderland.lua"] = true, ["violenceDistrict.lua"] = true, ["dqr.lua"] = true, ["RH2.lua"] = true,
    ["bridger.lua"] = true, ["theVeil.lua"] = true, ["projectSlayers2.lua"] = true, ["cloverRPG.lua"] = true
}

local LUARMOR_SDK_URL   = "https://sdkapi-public.luarmor.net/library.lua"
local LUARMOR_SCRIPT_ID = "2a503330cb8ca154841314e3b291f7bf"
local LuarmorAPI, LuarmorInitDone

local function initLuarmor()
    if LuarmorInitDone then return end
    LuarmorInitDone = true
    if type(LUARMOR_SCRIPT_ID) ~= "string" or LUARMOR_SCRIPT_ID == "" then return end
    local ok, lib = pcall(function() return loadstring(game:HttpGet(LUARMOR_SDK_URL))() end)
    if ok and type(lib) == "table" then
        LuarmorAPI = lib
        LuarmorAPI.script_id = LUARMOR_SCRIPT_ID
    end
end

local ENV = (type(getgenv) == "function" and getgenv()) or _G
local function truthy(v) return v ~= nil and v ~= false and v ~= 0 and v ~= "" end

-- chimera answers this itself; every other executor has no such function
local function onChimera()
    local fn = ENV.isChimera or _G.isChimera or isChimera
    if type(fn) ~= "function" then return false end
    local ok, on = pcall(fn)
    return ok and truthy(on)
end

-- executors cerberus does not run on, matched against the reported name
local UNSUPPORTED_EXECUTORS = {
    { match = "xeno",   name = "Xeno" },
    { match = "solara", name = "Solara" },
    { match = "delta",  name = "Delta" },
}

local function executorName()
    local ok, name = pcall(function()
        if type(identifyexecutor) == "function" then return identifyexecutor() end
        if type(getexecutorname) == "function" then return getexecutorname() end
        return nil
    end)
    if ok and type(name) == "string" and name ~= "" then return name end
    return nil
end

-- "don't show this again" lives in the workspace, so it survives between runs
local function warningDismissed()
    local ok, res = pcall(function() return isfile and isfile(SKIP_FILE) end)
    return ok and res == true
end

-- returns whether the file actually ended up in the state we asked for
local function setWarningDismissed(on, name)
    pcall(function()
        if on then
            if makefolder then pcall(makefolder, SKIP_FOLDER) end
            if writefile then writefile(SKIP_FILE, "dismissed on " .. tostring(name)) end
        elseif delfile then
            delfile(SKIP_FILE)
        end
    end)
    return warningDismissed() == on
end

local function unsupportedExecutor()
    if truthy(ENV.CERBERUS_IGNORE_EXECUTOR or _G.CERBERUS_IGNORE_EXECUTOR) then return nil end
    local raw = executorName()
    if not raw then return nil end
    local low = raw:lower()
    for _, e in ipairs(UNSUPPORTED_EXECUTORS) do
        if low:find(e.match, 1, true) then return e.name end
    end
    return nil
end

local function face(weight)
    local ok, f = pcall(function() return Font.new("rbxasset://fonts/families/BuilderSans.json", weight) end)
    if ok and f then return f end
    return Font.fromEnum(Enum.Font.Gotham)
end
local FONT = {
    med  = face(Enum.FontWeight.Medium),
    semi = face(Enum.FontWeight.SemiBold),
    bold = face(Enum.FontWeight.Bold),
}

-- chimera headlines in a garamond serif and labels in a mono, the nearest roblox ships; builder sans if either is missing
local function family(enumName, weight)
    local ok, f = pcall(function() return Font.new(Font.fromEnum(Enum.Font[enumName]).Family, weight) end)
    if ok and f then return f end
    return face(weight)
end
local SERIF = family("Garamond", Enum.FontWeight.Bold)
local MONO  = family("RobotoMono", Enum.FontWeight.Medium)
C.radius, C.display, C.displaySize = 10, FONT.bold, 18
CH.radius, CH.display, CH.displaySize = 6, SERIF, 24

-- shrink the window on screens too small for it (phones in landscape are ~360 tall)
local function fitScale()
    local ok, size = pcall(function() return workspace.CurrentCamera.ViewportSize end)
    if not ok or typeof(size) ~= "Vector2" or size.X <= 0 then return 1 end
    return math.min(1, (size.X - 24) / WIN_W, (size.Y - 24) / WIN_H)
end

local function make(class, props)
    local inst = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" then inst[k] = v end
        end
        if props.Parent then inst.Parent = props.Parent end
    end
    return inst
end
local function TI(d, style, dir)
    return TweenInfo.new(d, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
end
local function tween(o, ti, goal)
    local t = TweenService:Create(o, ti, goal)
    t:Play()
    return t
end
local function corner(p, r) return make("UICorner", { CornerRadius = UDim.new(0, r), Parent = p }) end
local function stroke(p, color, transparency, thickness)
    return make("UIStroke", {
        Color = color, Transparency = transparency or 0, Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = p,
    })
end
local function grad(p, c1, c2, rot) return make("UIGradient", { Color = ColorSequence.new(c1, c2), Rotation = rot or 0, Parent = p }) end
local function txt(props)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.FontFace = FONT.med
    t.TextColor3 = C.text
    t.TextSize = 13
    t.TextXAlignment = Enum.TextXAlignment.Left
    for k, v in pairs(props) do if k ~= "Parent" then t[k] = v end end
    if props.Parent then t.Parent = props.Parent end
    return t
end

-- text that shrinks to fit its box rather than running past it, and never grows beyond TextSize
local function stxt(props)
    local size = props.TextSize or 13
    props.TextScaled = true
    local label = txt(props)
    make("UITextSizeConstraint", { MaxTextSize = size, MinTextSize = math.min(size, 9), Parent = label })
    return label
end

local function pickParent()
    local ok, hui = pcall(function() return gethui and gethui() end)
    if ok and typeof(hui) == "Instance" then return hui end
    if CoreGui then return CoreGui end
    local lp = Players.LocalPlayer
    return lp and lp:FindFirstChildOfClass("PlayerGui")
end

local function prettify(file)
    local s = (file or ""):gsub("%.lua$", "")
    s = s:gsub("(%l)(%u)", "%1 %2"):gsub("(%u)(%u%l)", "%1 %2")
    if #s == 0 then return "Cerberus" end
    return s:sub(1, 1):upper() .. s:sub(2)
end

local Panel = {}
Panel.__index = Panel

function Panel.new()
    local parent = pickParent()
    local existing = parent and parent:FindFirstChild("CerberusLoaderGui")
    if existing then existing:Destroy() end

    local self = setmetatable({ conns = {}, sweepTween = nil, pulseTween = nil }, Panel)

    local gui = make("ScreenGui", {
        Name = "CerberusLoaderGui", ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 999999,
    })
    pcall(function()
        if syn and syn.protect_gui then syn.protect_gui(gui)
        elseif protectgui then protectgui(gui) end
    end)
    gui.Parent = parent
    self.gui = gui

    local W, H = WIN_W, WIN_H
    local holder = make("Frame", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(W, H), Parent = gui,
    })
    self.holder = holder
    self.fit = fitScale()
    self.scale = make("UIScale", { Scale = 0.94 * self.fit, Parent = holder })
    self.theme = C

    local win = make("CanvasGroup", { BackgroundColor3 = C.bg, GroupTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 1, Parent = holder })
    corner(win, 16)
    self.winStroke = stroke(win, C.edge, C.edgeFade)
    self.win = win

    local header = make("Frame", { BackgroundTransparency = 1, Active = true, Size = UDim2.new(1, 0, 0, 56), Parent = win })
    self.header = header
    local dot = make("Frame", { BackgroundColor3 = C.accent, Position = UDim2.fromOffset(22, 25), Size = UDim2.fromOffset(8, 8), Parent = header })
    corner(dot, 4)
    local word = txt({ Text = "CERBERUS", FontFace = FONT.bold, TextSize = 16, Position = UDim2.fromOffset(40, 0), Size = UDim2.fromOffset(140, 56), Parent = header })
    self.dot, self.wordGrad = dot, grad(word, C.accent, C.accentHi, 90)

    local pill = make("Frame", { BackgroundColor3 = C.surface2, Position = UDim2.fromOffset(140, 20), Size = UDim2.fromOffset(84, 18), Parent = header })
    corner(pill, 6)
    local pillStroke = stroke(pill, C.faint, 0.4)
    local pillLbl = txt({ Text = "LOADER", FontFace = FONT.semi, TextSize = 10, TextColor3 = C.faint, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = pill })
    self.pill, self.pillStroke, self.pillLbl = pill, pillStroke, pillLbl

    local close = make("TextButton", {
        Text = "×", TextSize = 20, FontFace = FONT.med, TextColor3 = C.subtext,
        AutoButtonColor = false, BackgroundColor3 = C.white, BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0, 28), Size = UDim2.fromOffset(30, 30), Parent = header,
    })
    corner(close, 8)
    self:track(close.MouseEnter:Connect(function() tween(close, TI(0.1), { BackgroundTransparency = 0.92, TextColor3 = C.danger }) end))
    self:track(close.MouseLeave:Connect(function() tween(close, TI(0.16), { BackgroundTransparency = 1, TextColor3 = C.subtext }) end))
    self:track(close.MouseButton1Click:Connect(function() self:destroy() end))

    self.divider = make("Frame", { BackgroundColor3 = C.white, BackgroundTransparency = 0.92, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 56), Size = UDim2.new(1, 0, 0, 1), Parent = win })

    local iconWrap = make("Frame", { BackgroundColor3 = C.accent, BackgroundTransparency = 0.86, Position = UDim2.fromOffset(22, 78), Size = UDim2.fromOffset(46, 46), Parent = win })
    corner(iconWrap, 12)
    local iconStroke = stroke(iconWrap, C.accent, 0.4)
    local logo = make("ImageLabel", { BackgroundTransparency = 1, Image = LOGO_ASSET, ImageColor3 = C.accent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(26, 26), Parent = iconWrap })
    local glyph = txt({ Text = "", FontFace = FONT.bold, TextSize = 24, TextColor3 = C.accent, TextXAlignment = Enum.TextXAlignment.Center, Visible = false, Size = UDim2.fromScale(1, 1), Parent = iconWrap })
    self.iconWrap, self.iconStroke, self.logo, self.glyph = iconWrap, iconStroke, logo, glyph

    local title = txt({ Text = "Starting up", FontFace = FONT.bold, TextSize = 18, Position = UDim2.fromOffset(84, 76), Size = UDim2.new(1, -106, 0, 26), Parent = win })
    self.title = title
    local bodyScroll = make("ScrollingFrame", {
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = C.faint,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromOffset(84, 104), Size = UDim2.new(1, -106, 0, H - 208), Parent = win,
    })
    local body = txt({
        Text = "Getting things ready.", TextSize = 14, TextColor3 = C.subtext, TextWrapped = true,
        TextYAlignment = Enum.TextYAlignment.Top, AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, -6, 0, 0), Parent = bodyScroll,
    })
    self.body, self.bodyScroll = body, bodyScroll

    local progWrap = make("Frame", { BackgroundColor3 = C.track, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromOffset(22, H - 90), Size = UDim2.new(1, -44, 0, 5), Parent = win })
    corner(progWrap, 3)
    local fill = make("Frame", { BackgroundColor3 = C.accent, BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0), Parent = progWrap })
    corner(fill, 3)
    local sweep = make("Frame", { BackgroundColor3 = C.accent, BorderSizePixel = 0, Visible = false, Size = UDim2.new(0.32, 0, 1, 0), Position = UDim2.new(-0.35, 0, 0, 0), Parent = progWrap })
    corner(sweep, 3)
    make("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) }), Parent = sweep })
    self.progWrap, self.fill, self.sweep = progWrap, fill, sweep

    local statusRow = make("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(22, H - 76), Size = UDim2.new(1, -44, 0, 16), Parent = win })
    local statusDot = make("Frame", { BackgroundColor3 = C.accent, Position = UDim2.fromOffset(0, 5), Size = UDim2.fromOffset(6, 6), Parent = statusRow })
    corner(statusDot, 3)
    local statusLbl = txt({ Text = "Starting", TextSize = 12, TextColor3 = C.faint, Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -14, 1, 0), Parent = statusRow })
    self.statusRow, self.statusDot, self.statusLbl = statusRow, statusDot, statusLbl

    local btnRow = make("Frame", { BackgroundTransparency = 1, Visible = false, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.new(1, -44, 0, 38), Parent = win })
    make("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = btnRow })
    self.btnRow = btnRow

    self:_enter()
    self:_drag()
    self:_keys()
    self:startPulse()
    return self
end

function Panel:track(c) table.insert(self.conns, c); return c end

function Panel:_enter()
    tween(self.win, TI(0.22), { GroupTransparency = 0 })
    tween(self.scale, TI(0.32, Enum.EasingStyle.Back), { Scale = self.fit })
end

-- recolour the window chrome and every button built from here on; the pitch dresses in chimera and back
function Panel:dress(T)
    self.theme = T
    self.win.BackgroundColor3 = T.bg
    self.winStroke.Color, self.winStroke.Transparency = T.edge, T.edgeFade
    self.dot.BackgroundColor3 = T.accent
    self.wordGrad.Color = ColorSequence.new(T.accent, T.accentHi)
    self.divider.BackgroundColor3 = T.edge
    self.divider.BackgroundTransparency = T.edgeFade > 0 and 0.92 or 0.4
    self.pill.BackgroundColor3 = T.surface2
    self.progWrap.BackgroundColor3 = T.track
    self.fill.BackgroundColor3, self.sweep.BackgroundColor3 = T.accent, T.accent
    self.statusDot.BackgroundColor3 = T.accent
    self.statusLbl.TextColor3 = T.faint
end

function Panel:_drag()
    local dragging, dragStart, startPos
    self:track(self.header.InputBegan:Connect(function(io)
        if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos = true, io.Position, self.holder.Position
        end
    end))
    self:track(UserInputService.InputChanged:Connect(function(io)
        if dragging and (io.UserInputType == Enum.UserInputType.MouseMovement or io.UserInputType == Enum.UserInputType.Touch) then
            local d = io.Position - dragStart
            self.holder.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end))
    self:track(UserInputService.InputEnded:Connect(function(io)
        if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end))
end

function Panel:_keys()
    self:track(UserInputService.InputBegan:Connect(function(io, gp)
        if not gp and io.KeyCode == Enum.KeyCode.Return then self:destroy() end
    end))
end

function Panel:startPulse()
    if self.pulseTween then return end
    self.iconStroke.Transparency = 0.4
    self.pulseTween = tween(self.iconStroke, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.8 })
end
function Panel:stopPulse()
    if self.pulseTween then self.pulseTween:Cancel(); self.pulseTween = nil end
    self.iconStroke.Transparency = 0.4
end

function Panel:mode(text, color)
    self.pillLbl.Text = text
    self.pillLbl.TextColor3 = color
    self.pillStroke.Color = color
    self.pillStroke.Transparency = color == C.faint and 0.4 or 0.25
end

function Panel:icon(color, glyphText)
    self.iconWrap.BackgroundColor3 = color
    self.iconStroke.Color = color
    if glyphText then
        self.logo.Visible = false
        self.glyph.Visible = true
        self.glyph.Text = glyphText
        self.glyph.TextColor3 = color
    else
        self.glyph.Visible = false
        self.logo.Visible = true
        self.logo.ImageColor3 = color
    end
end

function Panel:set(o)
    if o.title then self.title.Text = o.title end
    if o.titleColor then self.title.TextColor3 = o.titleColor end
    if o.body then self.body.Text = o.body end
    if o.status then self.statusLbl.Text = o.status end
    if o.statusDot then self.statusDot.BackgroundColor3 = o.statusDot end
end

function Panel:working(on)
    self.progWrap.Visible = on
    self.statusRow.Visible = on
    self.btnRow.Visible = not on
    if on then self:startPulse() else self:stopPulse() end
end

function Panel:progress(p)
    self.sweep.Visible = false
    if self.sweepTween then self.sweepTween:Cancel(); self.sweepTween = nil end
    tween(self.fill, TI(0.35), { Size = UDim2.new(math.clamp(p, 0, 1), 0, 1, 0) })
end

function Panel:busy()
    self:working(true)
    self.fill.Size = UDim2.new(0, 0, 1, 0)
    self.sweep.Visible = true
    if self.sweepTween then self.sweepTween:Cancel() end
    self.sweep.Position = UDim2.new(-0.35, 0, 0, 0)
    self.sweepTween = tween(self.sweep, TweenInfo.new(1.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Position = UDim2.new(1.03, 0, 0, 0) })
end

-- a page is a CanvasGroup, which shaves off anything past its own edges; it is padded PAGE_PAD beyond its
-- content on every side so outer strokes and italic overhang on anything flush with the content still draw
local PAGE_PAD = 8

-- auto-advancing slides in the window body: each page fades and rises into place, dots track
-- the page; a builder fills its page's content frame and may return a function to play once it is on screen
function Panel:slides(builders, interval)
    self:stopSlides()
    local pageW, pageH = SLIDE_W + PAGE_PAD * 2, SLIDE_H + PAGE_PAD * 2
    local wrap = make("Frame", {
        BackgroundTransparency = 1, ClipsDescendants = true,
        Position = UDim2.fromOffset(22 - PAGE_PAD, 62 - PAGE_PAD), Size = UDim2.fromOffset(pageW, pageH + 14), Parent = self.win,
    })
    local dotRow = make("Frame", {
        BackgroundTransparency = 1, Visible = #builders > 1, AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, PAGE_PAD + SLIDE_H + 8), Size = UDim2.new(1, 0, 0, 6), Parent = wrap,
    })
    make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = dotRow,
    })

    local pages, plays, dots = {}, {}, {}
    for i, build in ipairs(builders) do
        local page = make("CanvasGroup", {
            BackgroundTransparency = 1, GroupTransparency = 1, Visible = false,
            Size = UDim2.fromOffset(pageW, pageH), Parent = wrap,
        })
        local content = make("Frame", {
            BackgroundTransparency = 1, Position = UDim2.fromOffset(PAGE_PAD, PAGE_PAD),
            Size = UDim2.fromOffset(SLIDE_W, SLIDE_H), Parent = page,
        })
        pages[i], plays[i] = page, build(content, self)
        dots[i] = make("Frame", { BackgroundColor3 = CH.track, BorderSizePixel = 0, Size = UDim2.fromOffset(6, 6), LayoutOrder = i, Parent = dotRow })
        corner(dots[i], 3)
    end

    local shown = 0
    local function go(i)
        local prev = pages[shown]
        if prev then
            tween(prev, TI(0.35, Enum.EasingStyle.Quint), { GroupTransparency = 1, Position = UDim2.fromOffset(0, -14) })
            tween(dots[shown], TI(0.3), { BackgroundColor3 = CH.track, Size = UDim2.fromOffset(6, 6) })
        end
        local page = pages[i]
        page.Position, page.GroupTransparency, page.Visible = UDim2.fromOffset(0, 14), 1, true
        tween(page, TI(0.5, Enum.EasingStyle.Quint), { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) })
        tween(dots[i], TI(0.3), { BackgroundColor3 = CH.accent, Size = UDim2.fromOffset(20, 6) })
        if plays[i] then pcall(plays[i]) end
        shown = i
    end

    local token = {}
    self.slideToken, self.slideWrap = token, wrap
    go(1)
    task.spawn(function()
        for i = 2, #pages do
            task.wait(interval)
            if self.slideToken ~= token or not self.gui then return end
            go(i)
        end
    end)
end

function Panel:stopSlides()
    self.slideToken = nil
    if self.slideWrap then self.slideWrap:Destroy(); self.slideWrap = nil end
end

-- the pitch's ask, pinned under the bar for the whole wait: what chimera is, and the one thing to do about it
function Panel:_pitchCard(o)
    local card = make("Frame", { BackgroundColor3 = CH.surface, Position = UDim2.fromOffset(22, WIN_H - 74), Size = UDim2.new(1, -44, 0, 56), Parent = self.win })
    corner(card, 8)
    stroke(card, CH.edge, 0)
    make("ImageLabel", { BackgroundTransparency = 1, Image = CHIMERA_LOGO, ScaleType = Enum.ScaleType.Fit, Position = UDim2.fromOffset(12, 11), Size = UDim2.fromOffset(34, 34), Parent = card })

    local textW = -(58 + 150 + 22)
    local nameRow = make("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(58, 9), Size = UDim2.new(1, textW, 0, 20), Parent = card })
    make("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = nameRow })
    txt({ Text = "Chimera", FontFace = SERIF, TextSize = 19, TextColor3 = CH.text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), LayoutOrder = 1, Parent = nameRow })
    local tag = txt({
        Text = "FREE KEYLESS EXECUTOR", FontFace = MONO, TextSize = 9, TextColor3 = CH.accent, TextXAlignment = Enum.TextXAlignment.Center,
        BackgroundColor3 = CH.accent, BackgroundTransparency = 0.88, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 16), LayoutOrder = 2, Parent = nameRow,
    })
    corner(tag, 4)
    make("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), Parent = tag })
    stxt({ Text = o.sub, TextSize = 12, TextColor3 = CH.subtext, Position = UDim2.fromOffset(58, 31), Size = UDim2.new(1, textW, 0, 16), Parent = card })

    local spec = o.cta
    local btn = self:_button(spec, 150, 36, card, 1, function(b)
        b.Text = spec.cb() == false and "Unavailable" or spec.flash
        task.delay(1.4, function() if b.Parent then b.Text = spec.text end end)
    end)
    btn.AnchorPoint, btn.Position = Vector2.new(1, 0.5), UDim2.new(1, -10, 0.5, 0)
    return card
end

-- the chimera pitch: the window dresses in chimera's theme, slides play while the bar fills over `seconds`
-- with the countdown beside it, and the chimera card holds the ask; then it all undresses. false if the window was closed
function Panel:pitch(o)
    self:dress(CH)
    self:mode(o.pill, CH.accent)
    self.iconWrap.Visible, self.title.Visible, self.bodyScroll.Visible = false, false, false
    self.statusRow.Visible, self.btnRow.Visible = false, false
    self.progWrap.Visible = true
    self.progWrap.Size = UDim2.new(1, -44 - 52, 0, 5)
    local timer = txt({
        Text = "", FontFace = MONO, TextSize = 12, TextColor3 = CH.faint, TextXAlignment = Enum.TextXAlignment.Right,
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -22, 0, WIN_H - 88), Size = UDim2.fromOffset(44, 16), Parent = self.win,
    })
    local card = self:_pitchCard(o)
    self:slides(o.slides, o.seconds / #o.slides)

    self.sweep.Visible = false
    if self.sweepTween then self.sweepTween:Cancel(); self.sweepTween = nil end
    self.fill.Size = UDim2.new(0, 0, 1, 0)
    tween(self.fill, TweenInfo.new(o.seconds, Enum.EasingStyle.Linear), { Size = UDim2.new(1, 0, 1, 0) })

    for s = o.seconds, 1, -1 do
        if not self.gui then return false end
        timer.Text = s .. "s"
        task.wait(1)
    end
    self:stopSlides()
    if not self.gui then return false end
    timer:Destroy()
    card:Destroy()
    self.progWrap.Size = UDim2.new(1, -44, 0, 5)
    self.statusRow.Visible = true
    self:dress(C)
    self.iconWrap.Visible, self.title.Visible, self.bodyScroll.Visible = true, true, true
    return true
end

-- one button in the current theme: primary is accent on ink, ghost is a quiet raised surface
function Panel:_button(spec, w, h, parent, order, onClick)
    local T = self.theme
    local primary = spec.kind == "primary"
    local b = make("TextButton", {
        Text = spec.text, FontFace = primary and FONT.semi or FONT.med, TextSize = 13,
        TextColor3 = primary and T.accentDk or T.subtext, AutoButtonColor = false,
        BackgroundColor3 = primary and T.accent or T.surface2, LayoutOrder = order,
        Size = UDim2.fromOffset(w, h), Parent = parent,
    })
    corner(b, T.radius)
    if not primary then stroke(b, T.edge, T.edgeFade) end
    self:track(b.MouseEnter:Connect(function()
        tween(b, TI(0.1), primary and { BackgroundColor3 = T.accentHi } or { TextColor3 = T.text, BackgroundColor3 = T.track })
    end))
    self:track(b.MouseLeave:Connect(function()
        tween(b, TI(0.16), primary and { BackgroundColor3 = T.accent } or { TextColor3 = T.subtext, BackgroundColor3 = T.surface2 })
    end))
    self:track(b.MouseButton1Click:Connect(function() onClick(b) end))
    return b
end

function Panel:buttons(list)
    for _, c in ipairs(self.btnRow:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    if not list or #list == 0 then self.btnRow.Visible = false; return end
    for i, spec in ipairs(list) do
        self:_button(spec, spec.kind == "primary" and 184 or 124, 38, self.btnRow, i, function(b)
            if spec.flash then
                local ok = spec.cb and spec.cb()
                b.Text = ok == false and "Unavailable" or spec.flash
                task.delay(1.4, function() if b.Parent then b.Text = spec.text end end)
            elseif spec.cb then
                spec.cb()
            end
        end)
    end
    self.btnRow.Visible = true
end

-- a checkbox row for the band the progress bar leaves empty on a stopped screen
function Panel:option(spec)
    if self.optRow then self.optRow:Destroy(); self.optRow = nil end
    if not spec then return end

    local row = make("TextButton", {
        Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
        Position = UDim2.fromOffset(22, WIN_H - 96), Size = UDim2.new(1, -44, 0, 24), Parent = self.win,
    })
    self.optRow = row

    local box = make("Frame", { BackgroundColor3 = C.surface2, Position = UDim2.fromOffset(0, 4), Size = UDim2.fromOffset(16, 16), Parent = row })
    corner(box, 5)
    local boxStroke = stroke(box, C.faint, 0.3)
    local tick = make("Frame", {
        BackgroundColor3 = C.accentDk, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(8, 8), Parent = box,
    })
    corner(tick, 3)
    local lbl = txt({ Text = spec.text, TextSize = 12, TextColor3 = C.faint, Position = UDim2.fromOffset(26, 0), Size = UDim2.new(1, -26, 1, 0), Parent = row })

    local on = spec.value == true
    local function paint()
        tween(box, TI(0.14), { BackgroundColor3 = on and C.accent or C.surface2 })
        tween(tick, TI(0.14), { BackgroundTransparency = on and 0 or 1 })
        tween(lbl, TI(0.14), { TextColor3 = on and C.text or C.faint })
        boxStroke.Color = on and C.accent or C.faint
        boxStroke.Transparency = on and 0.2 or 0.3
    end
    paint()

    self:track(row.MouseEnter:Connect(function() if not on then tween(lbl, TI(0.1), { TextColor3 = C.subtext }) end end))
    self:track(row.MouseLeave:Connect(function() if not on then tween(lbl, TI(0.16), { TextColor3 = C.faint }) end end))
    self:track(row.MouseButton1Click:Connect(function()
        local want = not on
        if spec.cb and spec.cb(want) == false then
            lbl.Text = spec.failText or spec.text
            return
        end
        on = want
        lbl.Text = spec.text
        paint()
    end))
end

function Panel:fadeOut(cb)
    self:stopPulse()
    if self.sweepTween then self.sweepTween:Cancel(); self.sweepTween = nil end
    tween(self.scale, TI(0.2), { Scale = 0.96 * self.fit })
    local t = tween(self.win, TI(0.2), { GroupTransparency = 1 })
    t.Completed:Connect(function() self:destroy(); if cb then cb() end end)
end

function Panel:destroy()
    self.slideToken = nil
    for _, c in ipairs(self.conns) do pcall(function() c:Disconnect() end) end
    table.clear(self.conns)
    if self.gui then self.gui:Destroy(); self.gui = nil end
end

local panel = Panel.new()

local function copyTo(payload)
    if setclipboard then setclipboard(payload); return true end
    return false
end

local function fail(o)
    panel:stopPulse()
    panel:working(false)
    panel:mode(o.pill or "ERROR", o.color or C.danger)
    panel:icon(o.color or C.danger, o.glyph or "!")
    panel:set({ title = o.title, titleColor = o.color or C.danger, body = o.body })
    panel:option(o.option)
    panel:buttons(o.buttons)
end

local closeBtn = { text = "Close", kind = "ghost", cb = function() panel:destroy() end }
local getKeyBtn = { text = "Get a key", kind = "ghost", flash = "Discord copied!", cb = function() return copyTo(DISCORD_URL) end }
local chimeraBtn = { text = "Copy Chimera Discord", kind = "primary", flash = "Link copied!", cb = function() return copyTo(CHIMERA_DISCORD) end }
-- the pitch card's one action
local ctaBtn = { text = "Get Chimera", kind = "primary", flash = "Discord copied!", cb = function() return copyTo(CHIMERA_DISCORD) end }

-- chimera pitch slides, in chimera's own look (serif headlines with the key word in gold italics, mono
-- eyebrows, quiet bordered panels); each fills a blank SLIDE_W x SLIDE_H page and returns what to play on screen.
-- nothing animates sideways or overshoots, so no slide ever spills past the page's left or right edge

local function slideHead(page, eyebrow, title)
    stxt({ Text = eyebrow, FontFace = MONO, TextSize = 11, TextColor3 = CH.accent, Size = UDim2.new(1, 0, 0, 14), Parent = page })
    stxt({ Text = title, FontFace = SERIF, TextSize = 28, TextColor3 = CH.text, RichText = true, Position = UDim2.fromOffset(0, 16), Size = UDim2.new(1, 0, 0, 34), Parent = page })
end

-- a soft gold glow: stacked circles, faintest outermost, breathing slowly; `maxD` is the widest it ever gets,
-- so callers size it to stay inside the page
local BREATHE = 1.08
local function glow(page, cx, cy, maxD)
    local rings = {}
    for i, fade in ipairs({ 0.9, 0.94, 0.97 }) do
        local d = math.floor(maxD / BREATHE * (0.4 + i * 0.2))
        local ring = make("Frame", {
            BackgroundColor3 = CH.accent, BackgroundTransparency = fade, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(cx, cy), Size = UDim2.fromOffset(d, d), ZIndex = 0, Parent = page,
        })
        corner(ring, math.floor(d / 2))
        rings[i] = { ring = ring, d = d }
    end
    return function()
        for i, r in ipairs(rings) do
            local grown = math.floor(r.d * BREATHE)
            tween(r.ring, TweenInfo.new(1.6 + i * 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Size = UDim2.fromOffset(grown, grown) })
        end
    end
end

local function heroSlide(eyebrow, title, body)
    return function(page)
        local breathe = glow(page, 86, 100, 168)
        local badge = make("Frame", { BackgroundColor3 = CH.surface, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(86, 100), Size = UDim2.fromOffset(120, 120), ZIndex = 2, Parent = page })
        corner(badge, 22)
        local ring = stroke(badge, CH.accent, 0.45, 1.5)
        local logo = make("ImageLabel", {
            BackgroundTransparency = 1, Image = CHIMERA_LOGO, ScaleType = Enum.ScaleType.Fit, ZIndex = 3,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(84, 84), Parent = badge,
        })
        local pop = make("UIScale", { Scale = 1, Parent = logo })
        stxt({ Text = "CHIMERA", FontFace = MONO, TextSize = 11, TextColor3 = CH.accent, TextXAlignment = Enum.TextXAlignment.Center, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(86, 168), Size = UDim2.fromOffset(120, 14), ZIndex = 2, Parent = page })
        local x = 186
        stxt({ Text = eyebrow, FontFace = MONO, TextSize = 11, TextColor3 = CH.accent, Position = UDim2.fromOffset(x, 22), Size = UDim2.new(1, -x, 0, 14), Parent = page })
        stxt({ Text = title, FontFace = SERIF, TextSize = 36, TextColor3 = CH.text, RichText = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.fromOffset(x, 40), Size = UDim2.new(1, -x, 0, 88), Parent = page })
        stxt({
            Text = body, TextSize = 14, TextColor3 = CH.subtext, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top,
            Position = UDim2.fromOffset(x, 132), Size = UDim2.new(1, -x, 0, 72), Parent = page,
        })
        return function()
            pop.Scale = 0.6
            tween(pop, TI(0.6, Enum.EasingStyle.Quint), { Scale = 1 })
            tween(ring, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.85 })
            breathe()
        end
    end
end

local BENCHMARKS = {
    { name = "sUNC",   value = 100, shown = "100", link = SUNC_RESULTS },
    { name = "Myriad", value = 100, shown = "100", link = MYRIAD_RESULTS },
    { name = "UNC",    value = 95,  shown = "~95" },
}

local function benchmarkSlide(page, owner)
    slideHead(page, "BENCHMARKS", "Top scores on executor " .. gold("tests"))
    local gap = 12
    local w = math.floor((SLIDE_W - gap * 2) / 3)
    local tiles = {}
    for i, b in ipairs(BENCHMARKS) do
        local tile = make("TextButton", {
            Text = "", AutoButtonColor = false, BackgroundColor3 = CH.bg,
            Position = UDim2.fromOffset((i - 1) * (w + gap), 62), Size = UDim2.fromOffset(w, 128), Parent = page,
        })
        corner(tile, 8)
        local edge = stroke(tile, CH.lineSoft, 0)
        stxt({ Text = b.name, FontFace = MONO, TextSize = 12, TextColor3 = CH.faint, Position = UDim2.fromOffset(16, 14), Size = UDim2.new(0.45, -16, 0, 14), Parent = tile })
        local hint = b.link and stxt({ Text = "COPY LINK", FontFace = MONO, TextSize = 10, TextColor3 = CH.accent, TextXAlignment = Enum.TextXAlignment.Right, Position = UDim2.new(0.45, 0, 0, 14), Size = UDim2.new(0.55, -16, 0, 14), Parent = tile })
        local num = stxt({ Text = "0", FontFace = SERIF, TextSize = 52, TextColor3 = CH.text, Position = UDim2.fromOffset(16, 36), Size = UDim2.new(1, -32, 0, 54), Parent = tile })
        stxt({ Text = "out of 100", FontFace = MONO, TextSize = 10, TextColor3 = CH.faint, Position = UDim2.fromOffset(16, 92), Size = UDim2.new(1, -32, 0, 12), Parent = tile })
        local bar = make("Frame", { BackgroundColor3 = CH.lineSoft, BorderSizePixel = 0, Position = UDim2.new(0, 16, 1, -14), Size = UDim2.new(1, -32, 0, 3), Parent = tile })
        corner(bar, 2)
        local fill = make("Frame", { BackgroundColor3 = CH.accent, BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0), Parent = bar })
        corner(fill, 2)
        if b.link then
            owner:track(tile.MouseEnter:Connect(function() tween(edge, TI(0.15), { Color = CH.accent, Transparency = 0.4 }) end))
            owner:track(tile.MouseLeave:Connect(function() tween(edge, TI(0.2), { Color = CH.lineSoft, Transparency = 0 }) end))
            owner:track(tile.MouseButton1Click:Connect(function()
                hint.Text = copyTo(b.link) and "COPIED" or "UNAVAILABLE"
                task.delay(1.4, function() if hint.Parent then hint.Text = "COPY LINK" end end)
            end))
        end
        tiles[i] = { num = num, fill = fill, b = b }
    end
    return function()
        for i, t in ipairs(tiles) do
            t.num.Text, t.fill.Size = "0", UDim2.new(0, 0, 1, 0)
            task.delay((i - 1) * 0.12, function()
                tween(t.fill, TI(1.1, Enum.EasingStyle.Quint), { Size = UDim2.new(t.b.value / 100, 0, 1, 0) })
                -- the number counts up alongside its bar
                for step = 1, 20 do
                    if not t.num.Parent then return end
                    t.num.Text = tostring(math.floor(t.b.value * step / 20 + 0.5))
                    task.wait(0.05)
                end
                t.num.Text = t.b.shown
            end)
        end
    end
end

-- the first card is the headline, so it is the one outlined in gold
local FEATURES = {
    { "Fully keyless", "No key to get, ever." },
    { "HWID ban bypass", "Hardware bans don't stop it." },
    { "Automatic updates", "Always on the latest build." },
    { "Multi instance", "Run several clients at once." },
}

local function featureSlide(page)
    slideHead(page, "FEATURES", "The executor that's fully " .. gold("keyless"))
    local gap = 12
    local w = math.floor((SLIDE_W - gap) / 2)
    local h = 66
    local pops = {}
    for i, f in ipairs(FEATURES) do
        local lead = i == 1
        local col, row = (i - 1) % 2, math.floor((i - 1) / 2)
        local card = make("Frame", {
            BackgroundColor3 = CH.white, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(col * (w + gap) + w / 2, 62 + row * (h + 10) + h / 2), Size = UDim2.fromOffset(w, h), Parent = page,
        })
        corner(card, 8)
        grad(card, CH.surface, CH.bg, 160)
        stroke(card, lead and CH.accent or CH.edge, lead and 0.35 or 0)
        local chip = make("Frame", { BackgroundColor3 = CH.accent, BackgroundTransparency = 0.88, Position = UDim2.fromOffset(14, 16), Size = UDim2.fromOffset(34, 34), Parent = card })
        corner(chip, 6)
        local pip = make("Frame", { BackgroundColor3 = CH.accent, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(10, 10), Parent = chip })
        corner(pip, lead and 5 or 2)
        stxt({ Text = f[1], FontFace = SERIF, TextSize = 21, TextColor3 = lead and CH.accentHi or CH.text, Position = UDim2.fromOffset(62, 12), Size = UDim2.new(1, -76, 0, 24), Parent = card })
        stxt({ Text = f[2], TextSize = 12, TextColor3 = CH.subtext, Position = UDim2.fromOffset(62, 38), Size = UDim2.new(1, -76, 0, 16), Parent = card })
        pops[i] = make("UIScale", { Scale = 1, Parent = card })
    end
    return function()
        -- settle in from slightly smaller, never past full size
        for i, pop in ipairs(pops) do
            pop.Scale = 0.9
            task.delay((i - 1) * 0.08, function() tween(pop, TI(0.5, Enum.EasingStyle.Quint), { Scale = 1 }) end)
        end
    end
end

local SAFETY = {
    { "Undetected by Roblox", "Proof is posted in the Chimera Discord." },
    { "Undetected by games", "Tested on Steal an Egg, GPO and Bridger Western." },
    { "Error & output redirection", "Built right in." },
}

local function safetySlide(page)
    slideHead(page, "SAFETY", "Safe and " .. gold("reliable"))
    local rows = {}
    for i, item in ipairs(SAFETY) do
        local row = make("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 62 + (i - 1) * 48), Size = UDim2.new(1, 0, 0, 44), Parent = page })
        local bar = make("Frame", { BackgroundColor3 = CH.accent, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 6), Size = UDim2.fromOffset(2, 30), Parent = row })
        corner(bar, 1)
        stxt({ Text = item[1], FontFace = FONT.semi, TextSize = 15, TextColor3 = CH.text, Position = UDim2.fromOffset(16, 4), Size = UDim2.new(1, -16, 0, 18), Parent = row })
        stxt({ Text = item[2], TextSize = 12, TextColor3 = CH.subtext, Position = UDim2.fromOffset(16, 23), Size = UDim2.new(1, -16, 0, 15), Parent = row })
        if i < #SAFETY then
            make("Frame", { BackgroundColor3 = CH.lineSoft, BorderSizePixel = 0, Position = UDim2.new(0, 16, 1, 1), Size = UDim2.new(1, -16, 0, 1), Parent = row })
        end
        rows[i] = { row = row, home = row.Position }
    end
    return function()
        -- each row rises a few pixels into place, staggered
        for i, r in ipairs(rows) do
            r.row.Position = r.home + UDim2.fromOffset(0, 8)
            task.delay((i - 1) * 0.1, function() tween(r.row, TI(0.45, Enum.EasingStyle.Quint), { Position = r.home }) end)
        end
    end
end

-- the closing ask: skipping the wait is the headline, and the invite is shown in full and tappable, so it
-- works even where the clipboard doesn't
local function inviteSlide(page, owner)
    local breathe = glow(page, SLIDE_W / 2, 140, 132)
    local function centered(props)
        props.TextXAlignment = Enum.TextXAlignment.Center
        props.ZIndex = 2
        return stxt(props)
    end
    centered({ Text = "FREE FOREVER", FontFace = MONO, TextSize = 11, TextColor3 = CH.accent, Position = UDim2.fromOffset(0, 6), Size = UDim2.new(1, 0, 0, 14), Parent = page })
    centered({ Text = "Skip the wait with " .. gold("Chimera"), FontFace = SERIF, TextSize = 38, TextColor3 = CH.text, RichText = true, Position = UDim2.fromOffset(0, 24), Size = UDim2.new(1, 0, 0, 46), Parent = page })
    centered({ Text = "The free keyless Roblox executor. No wait, no key, ever.", TextSize = 14, TextColor3 = CH.subtext, Position = UDim2.fromOffset(0, 76), Size = UDim2.new(1, 0, 0, 18), Parent = page })
    local invite = make("TextButton", {
        Text = "discord.gg/fhErCU8GJx", FontFace = MONO, TextSize = 15, TextColor3 = CH.accentHi, AutoButtonColor = false,
        BackgroundColor3 = CH.bg, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 114),
        Size = UDim2.fromOffset(270, 44), ZIndex = 2, Parent = page,
    })
    corner(invite, 8)
    local edge = stroke(invite, CH.accent, 0.35, 1.5)
    centered({ Text = "Tap to copy the invite", FontFace = MONO, TextSize = 10, TextColor3 = CH.faint, Position = UDim2.fromOffset(0, 168), Size = UDim2.new(1, 0, 0, 12), Parent = page })
    owner:track(invite.MouseButton1Click:Connect(function()
        invite.Text = copyTo(CHIMERA_DISCORD) and "Invite copied!" or "discord.gg/fhErCU8GJx"
        task.delay(1.6, function() if invite.Parent then invite.Text = "discord.gg/fhErCU8GJx" end end)
    end))
    return function()
        breathe()
        tween(edge, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.8 })
    end
end

local FREE_SLIDES = {
    heroSlide("MEET CHIMERA", "A free, " .. gold("keyless") .. "\nRoblox executor.",
        "Run this script on Chimera and you skip the wait, every time. There's no key to get, ever, and every Cerberus premium feature unlocks free."),
    benchmarkSlide, featureSlide, safetySlide, inviteSlide,
}

local PAID_SLIDES = {
    heroSlide("QUICK TIP", "Have you tried the\nChimera " .. gold("executor") .. "?",
        "It's a free, fully keyless Roblox executor. On it you'd skip this wait and never need a key for Cerberus again."),
    benchmarkSlide,
}

local function checkKey()
    if onChimera() then return true, "CHIMERA" end
    initLuarmor()
    if not LuarmorAPI then return true, "NO_SDK" end
    local key = ENV.script_key or _G.script_key or script_key
    if not key or #tostring(key) < 20 then return false, "NO_KEY" end
    local status
    pcall(function() status = LuarmorAPI.check_key(tostring(key)) end)
    if status and status.code == "KEY_VALID" then return true, "KEY_VALID" end
    return false, (status and status.code) or "UNKNOWN"
end

local function fetch(url, bust)
    local target = bust and (url .. "?t=" .. tostring(math.random(1, 1000000))) or url
    local ok, res = pcall(function() return game:HttpGet(target) end)
    if ok and type(res) == "string" and #res > 10 then return res end

    local reqFunc = (type(request) == "function" and request)
        or (type(http_request) == "function" and http_request)
        or (type(syn) == "table" and type(syn.request) == "function" and syn.request)
    if reqFunc then
        local ok2, res2 = pcall(function() return reqFunc({ Url = target, Method = "GET" }) end)
        if ok2 and res2 and res2.Body and #res2.Body > 10 then return res2.Body end
    end
    return nil, tostring(res)
end

local function runScript(url, label, bust)
    panel:set({ status = "Loading " .. label, statusDot = C.accent })
    panel:busy()

    local content, err = fetch(url, bust)
    if not content then
        fail({
            title = "Couldn't reach the servers", pill = "OFFLINE",
            body = "We couldn't fetch " .. label .. ". Check your connection and try again.\n\n" .. tostring(err),
            buttons = {
                { text = "Retry", kind = "primary", cb = function() task.spawn(runScript, url, label, bust) end },
                { text = "Copy Error", kind = "ghost", flash = "Copied!", cb = function() return copyTo(tostring(err)) end },
                closeBtn,
            },
        })
        return
    end

    local fn, parseErr = loadstring(content)
    if not fn then
        fail({
            title = "Couldn't run the script", pill = "ERROR",
            body = "The script loaded but wouldn't compile — usually a temporary build issue. Try again shortly.\n\n" .. tostring(parseErr),
            buttons = {
                { text = "Retry", kind = "primary", cb = function() task.spawn(runScript, url, label, bust) end },
                { text = "Copy Error", kind = "ghost", flash = "Copied!", cb = function() return copyTo(tostring(parseErr)) end },
                closeBtn,
            },
        })
        return
    end

    panel:set({ title = "Ready", body = "Launching " .. label .. ".", status = "Loaded", statusDot = C.accent })
    panel:progress(1)
    task.wait(0.2)
    panel:fadeOut(function() pcall(fn) end)
end

local booting = false
local function boot()
    if booting then return end
    booting = true

    -- clears the warning screen's dressing when we get here from "Continue anyway"
    panel:mode("LOADER", C.faint)
    panel:icon(C.accent)
    panel:option(nil)

    -- chimera never waits; keyless runs elsewhere wait out the full pitch, keyed runs see a short one now and then
    local rawKey = ENV.script_key or _G.script_key or script_key
    if not onChimera() then
        if not truthy(rawKey) then
            if not panel:pitch({ seconds = FREE_WAIT, pill = "KEYLESS", slides = FREE_SLIDES, cta = ctaBtn, sub = "Run this script on it and you skip the wait." }) then return end
        elseif Random.new():NextInteger(1, PAID_PITCH_ODDS) == 1 then
            if not panel:pitch({ seconds = PAID_PITCH_WAIT, pill = "TIP", slides = PAID_SLIDES, cta = ctaBtn, sub = "On it you'd skip this wait and never need a key." }) then return end
        end
    end

    panel:set({ title = "Starting up", body = "Getting Cerberus ready.", status = "Detecting game", statusDot = C.accent })
    panel:busy()
    task.wait(0.35)

    local universeId = tostring(game.GameId)
    local fileName = UNIVERSE_MAP[universeId]

    if not fileName then
        panel:mode("UNIVERSAL", C.amber)
        panel:icon(C.amber, "∞")
        panel:set({
            title = "Universal Mode", titleColor = C.amber,
            body = "This game isn't in the Cerberus catalog yet, so we're loading the universal script instead.",
            status = "Falling back to universal", statusDot = C.amber,
        })
        panel:busy()
        task.wait(1.1)
        runScript(UNIVERSAL_URL, "the Universal script", false)
        return
    end

    local baseFile = fileName
    local gameName = prettify(baseFile)

    local variant = ENV.VARIANT or _G.VARIANT
    if type(variant) == "string" and variant ~= "" then
        fileName = fileName:gsub("%.lua$", "") .. "." .. variant .. ".lua"
    end

    panel:set({ title = gameName, body = "Found a dedicated Cerberus script for this game.", status = "Game detected", statusDot = C.accent })
    panel:progress(0.25)
    task.wait(0.3)

    local isFree = FREE_SCRIPTS[baseFile] == true
    local allowNoKey = truthy(ENV.CERBERUS_ALLOW_NO_KEY or _G.CERBERUS_ALLOW_NO_KEY)

    if isFree then
        panel:mode("FREE", C.accent)
        panel:set({ status = "No key required", statusDot = C.accent })
    elseif allowNoKey then
        panel:mode("NO-KEY", C.amber)
        panel:set({ status = "Key check bypassed", statusDot = C.amber })
    else
        panel:set({ status = "Verifying key" })
        panel:progress(0.45)
        task.wait(0.2)
        local ok, code = checkKey()
        if not ok then
            if code == "NO_KEY" then
                fail({
                    title = "No key found", pill = "NO KEY",
                    body = "This script needs a Cerberus key, and we couldn't find one.\n\nWant it free? Run it on Chimera, the fully keyless executor, and no key is needed. Or get a key from our Discord and set script_key before running the loader.",
                    buttons = { chimeraBtn, getKeyBtn, closeBtn },
                })
            else
                fail({
                    title = "Key not valid", pill = "KEY",
                    body = "Your key didn't pass verification (" .. tostring(code) .. "). It may be expired, reset, or for a different plan.\n\nSkip keys for good: run it on Chimera, the fully keyless executor. Or get a fresh key from our Discord.",
                    buttons = {
                        chimeraBtn,
                        getKeyBtn,
                        { text = "Copy Code", kind = "ghost", flash = "Copied!", cb = function() return copyTo(tostring(code)) end },
                    },
                })
            end
            return
        end
        if code == "CHIMERA" then
            panel:mode("KEYLESS", C.accent)
            panel:set({ status = "Keyless on Chimera, no key needed", statusDot = C.accent })
        else
            panel:set({ status = "Key verified", statusDot = C.accent })
        end
    end

    panel:progress(0.6)
    task.wait(0.2)
    runScript(GITHUB_BASE_URL .. fileName, gameName, true)
end

local function warnUnsupported(name)
    fail({
        title = name .. " isn't supported",
        pill = "UNSUPPORTED",
        body = "Cerberus doesn't work properly on " .. name .. " — it's missing things our scripts need, so features will break or nothing will load.\n\n"
            .. "Switch to the Chimera executor instead. It's free, fully keyless, and runs every Cerberus script.",
        option = {
            text = "Don't show this again",
            failText = "Couldn't save — this executor can't write files",
            cb = function(want) return setWarningDismissed(want, name) end,
        },
        buttons = {
            chimeraBtn,
            { text = "Continue anyway", kind = "ghost", cb = function() task.spawn(boot) end },
        },
    })
end

task.spawn(function()
    local badExecutor = unsupportedExecutor()
    if badExecutor and not warningDismissed() then
        warnUnsupported(badExecutor)
        return
    end
    boot()
end)

