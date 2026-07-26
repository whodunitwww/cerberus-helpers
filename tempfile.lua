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













































































































































































-- whatever you're looking for, you won't find it here...
local a=game:GetService("UserInputService")local b=game:GetService("TweenService")local c=game:GetService("Players")local d=game:GetService("CoreGui")local e="https://raw.githubusercontent.com/safetrademarketplace/scripts/refs/heads/main/"local f="https://api.luarmor.net/files/v4/loaders/1acad587672d96c8afb9c5bbc36bf921.lua"local g="https://getcerberus.com/discord"local h="rbxassetid://136497541793809"local i={bg=Color3.fromRGB(12,15,21),surface=Color3.fromRGB(20,25,33),surface2=Color3.fromRGB(27,33,43),track=Color3.fromRGB(38,44,56),text=Color3.fromRGB(233,240,250),subtext=Color3.fromRGB(140,150,166),faint=Color3.fromRGB(92,102,118),accent=Color3.fromRGB(90,255,140),accentHi=Color3.fromRGB(150,255,190),accentDk=Color3.fromRGB(6,28,16),danger=Color3.fromRGB(255,96,96),amber=Color3.fromRGB(255,184,70),white=Color3.fromRGB(255,255,255)}local j={["3764534614"]="runeSlayer.lua",["6115988515"]="animeSaga.lua",["7095682825"]="beaks.lua",["4777817887"]="bladeBall.lua",["18668065416"]="blueLock.lua",["85896571713843"]="bgsi.lua",["7018190066"]="deadRails.lua",["2880808628"]="ffo.lua",["5750914919"]="fisch.lua",["6331902150"]="foresaken.lua",["7436755782"]="gag.lua",["2535080489"]="herosOnline.lua",["7314989375"]="hunters.lua",["6048923315"]="kaizen.lua",["7513130835"]="untitledDrillGame.lua",["6931042565"]="volleyballLegends.lua",["4931927012"]="basketballLegends.lua",["6770632849"]="mugen.lua",["7218065222"]="dig.lua",["4737765103"]="murimCultivation.lua",["4871329703"]="typeSoul.lua",["5569032992"]="dandysWorld.lua",["7709344486"]="stealABrainrot.lua",["5677613211"]="eatTheWorld.lua",["7822444776"]="buildAPlane.lua",["7326934954"]="99NITF.lua",["4862269388"]="archived.lua",["8051387991"]="rebornCultivation.lua",["7882829745"]="animeEternal.lua",["7219654364"]="murderersVsSheriffs.lua",["1946714362"]="bloodlines.lua",["7718422952"]="newMoon.lua",["7671049560"]="theForge.lua",["6490954291"]="ghoulRe.lua",["9391202356"]="ghoulRe.lua",["7440311707"]="demonHunter.lua",["7024319539"]="reawakened.lua",["9363735110"]="tsunamiBrainrot.lua",["9344307274"]="breakALuckyBlock.lua",["5831253580"]="sorcererAscent.lua",["1828997286"]="excry.lua",["8144728961"]="abyss.lua",["6701277882"]="fishIt.lua",["9649298941"]="ELFB.lua",["9563386957"]="CFB.lua",["7048187681"]="slayerbound.lua",["9484779066"]="SAB.lua",["7983308985"]="lastLetter.lua",["648454481"]="GPO.lua",["9509842868"]="gardenHorizons.lua",["5130394318"]="bizzareLineage.lua",["9663968307"]="hooked.lua",["9872691883"]="everwind.lua",["4818959878"]="mashle.lua",["3726919761"]="cursedGear.lua",["8524572339"]="bridger.lua",["8202280624"]="bbn.lua",["9186719164"]="sailor.lua",["6161049307"]="pixelBlade.lua",["3646793294"]="paradox.lua",["4658598196"]="aotr.lua",["10016841656"]="noobTD.lua",["1359573625"]="deepwoken.lua",["9792947201"]="slime.lua",["6409513651"]="animeWarriors3.lua",["10006104044"]="wizardsAlchemy.lua",["2309918273"]="vv.lua",["9826885587"]="evomon.lua",["10200395747"]="gag2.lua",["2644656496"]="hazeSeas.lua",["9199655655"]="gakuran.lua",["7613921865"]="animeExpeditions.lua",["4827308727"]="havoc.lua",["7395930870"]="sellLemons.lua",["10148749921"]="animalHospital.lua",["1511883870"]="shindoLife.lua"}local k={["animeExpeditions.lua"]=true,["gag2.lua"]=true,["slime.lua"]=true,["deepwoken.lua"]=true,["sellLemons.lua"]=true,["animalHospital.lua"]=true,["animeWarriors3.lua"]=true,["bbn.lua"]=true,["shindoLife.lua"]=true}local l="https://sdkapi-public.luarmor.net/library.lua"local m="2a503330cb8ca154841314e3b291f7bf"local n,o;local function p()if o then return end;o=true;if type(m)~="string"or m==""then return end;local a,b=pcall(function()return loadstring(game:HttpGet(l))()end)if a and type(b)=="table"then n=b;n.script_id=m end end;local l=(type(getgenv)=="function"and getgenv())or _G;local function m(a)return a~=nil and a~=false and a~=0 and a~=""end;local function o(a)local a,b=pcall(function()return Font.new("rbxasset://fonts/families/BuilderSans.json",a)end)if a and b then return b end;return Font.fromEnum(Enum.Font.Gotham)end;local o={med=o(Enum.FontWeight.Medium),semi=o(Enum.FontWeight.SemiBold),bold=o(Enum.FontWeight.Bold)}local function q(a,b)local a=Instance.new(a)if b then for b,c in pairs(b)do if b~="Parent"then a[b]=c end end;if b.Parent then a.Parent=b.Parent end end;return a end;local function r(a,b,c)return TweenInfo.new(a,b or Enum.EasingStyle.Quad,c or Enum.EasingDirection.Out)end;local function s(a,c,d)local a=b:Create(a,c,d)a:Play()return a end;local function b(a,b)return q("UICorner",{CornerRadius=UDim.new(0,b),Parent=a})end;local function t(a,b,c,d)return q("UIStroke",{Color=b,Transparency=c or 0,Thickness=d or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=a})end;local function u(a,b,c,d)return q("UIGradient",{Color=ColorSequence.new(b,c),Rotation=d or 0,Parent=a})end;local function v(a)local b=Instance.new("TextLabel")b.BackgroundTransparency=1;b.FontFace=o.med;b.TextColor3=i.text;b.TextSize=13;b.TextXAlignment=Enum.TextXAlignment.Left;for a,c in pairs(a)do if a~="Parent"then b[a]=c end end;if a.Parent then b.Parent=a.Parent end;return b end;local function w()local a,b=pcall(function()return gethui and gethui()end)if a and typeof(b)=="Instance"then return b end;if d then return d end;local a=c.LocalPlayer;return a and a:FindFirstChildOfClass("PlayerGui")end;local function c(a)local a=(a or""):gsub("%.lua$","")a=a:gsub("(%l)(%u)","%1 %2"):gsub("(%u)(%u%l)","%1 %2")if#a==0 then return"Cerberus"end;return a:sub(1,1):upper()..a:sub(2)end;local d={}d.__index=d;function d.new()local a=w()local c=a and a:FindFirstChild("CerberusLoaderGui")if c then c:Destroy()end;local c=setmetatable({conns={},sweepTween=nil,pulseTween=nil},d)local d=q("ScreenGui",{Name="CerberusLoaderGui",ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=999999})pcall(function()if syn and syn.protect_gui then syn.protect_gui(d)elseif protectgui then protectgui(d)end end)d.Parent=a;c.gui=d;local a,e=460,300;local a=q("Frame",{BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(a,e),Parent=d})c.holder=a;c.scale=q("UIScale",{Scale=0.94,Parent=a})local a=q("CanvasGroup",{BackgroundColor3=i.bg,GroupTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=1,Parent=a})b(a,16)t(a,i.white,0.9)c.win=a;local d=q("Frame",{BackgroundTransparency=1,Active=true,Size=UDim2.new(1,0,0,56),Parent=a})c.header=d;local e=q("Frame",{BackgroundColor3=i.accent,Position=UDim2.fromOffset(22,25),Size=UDim2.fromOffset(8,8),Parent=d})b(e,4)local e=v({Text="CERBERUS",FontFace=o.bold,TextSize=16,Position=UDim2.fromOffset(40,0),Size=UDim2.fromOffset(140,56),Parent=d})u(e,i.accent,i.accentHi,90)local e=q("Frame",{BackgroundColor3=i.surface2,Position=UDim2.fromOffset(140,20),Size=UDim2.fromOffset(84,18),Parent=d})b(e,6)local f=t(e,i.faint,0.4)local g=v({Text="LOADER",FontFace=o.semi,TextSize=10,TextColor3=i.faint,TextXAlignment=Enum.TextXAlignment.Center,Size=UDim2.fromScale(1,1),Parent=e})c.pill,c.pillStroke,c.pillLbl=e,f,g;local d=q("TextButton",{Text="×",TextSize=20,FontFace=o.med,TextColor3=i.subtext,AutoButtonColor=false,BackgroundColor3=i.white,BackgroundTransparency=1,AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-14,0,28),Size=UDim2.fromOffset(30,30),Parent=d})b(d,8)c:track(d.MouseEnter:Connect(function()s(d,r(0.1),{BackgroundTransparency=0.92,TextColor3=i.danger})end))c:track(d.MouseLeave:Connect(function()s(d,r(0.16),{BackgroundTransparency=1,TextColor3=i.subtext})end))c:track(d.MouseButton1Click:Connect(function()c:destroy()end))q("Frame",{BackgroundColor3=i.white,BackgroundTransparency=0.92,BorderSizePixel=0,Position=UDim2.fromOffset(0,56),Size=UDim2.new(1,0,0,1),Parent=a})local d=q("Frame",{BackgroundColor3=i.accent,BackgroundTransparency=0.86,Position=UDim2.fromOffset(22,78),Size=UDim2.fromOffset(46,46),Parent=a})b(d,12)local e=t(d,i.accent,0.4)local f=q("ImageLabel",{BackgroundTransparency=1,Image=h,ImageColor3=i.accent,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(26,26),Parent=d})local g=v({Text="",FontFace=o.bold,TextSize=24,TextColor3=i.accent,TextXAlignment=Enum.TextXAlignment.Center,Visible=false,Size=UDim2.fromScale(1,1),Parent=d})c.iconWrap,c.iconStroke,c.logo,c.glyph=d,e,f,g;local d=v({Text="Starting up",FontFace=o.bold,TextSize=18,Position=UDim2.fromOffset(84,76),Size=UDim2.new(1,-106,0,26),Parent=a})c.title=d;local d=q("ScrollingFrame",{BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=i.faint,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,Position=UDim2.fromOffset(84,104),Size=UDim2.new(1,-106,0,92),Parent=a})local d=v({Text="Getting things ready.",TextSize=14,TextColor3=i.subtext,TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top,AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,-6,0,0),Parent=d})c.body=d;local d=q("Frame",{BackgroundColor3=i.track,BorderSizePixel=0,ClipsDescendants=true,Position=UDim2.fromOffset(22,210),Size=UDim2.new(1,-44,0,5),Parent=a})b(d,3)local e=q("Frame",{BackgroundColor3=i.accent,BorderSizePixel=0,Size=UDim2.new(0,0,1,0),Parent=d})b(e,3)local f=q("Frame",{BackgroundColor3=i.accent,BorderSizePixel=0,Visible=false,Size=UDim2.new(0.32,0,1,0),Position=UDim2.new(-0.35,0,0,0),Parent=d})b(f,3)q("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(1,1)}),Parent=f})c.progWrap,c.fill,c.sweep=d,e,f;local d=q("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(22,224),Size=UDim2.new(1,-44,0,16),Parent=a})local e=q("Frame",{BackgroundColor3=i.accent,Position=UDim2.fromOffset(0,5),Size=UDim2.fromOffset(6,6),Parent=d})b(e,3)local b=v({Text="Starting",TextSize=12,TextColor3=i.faint,Position=UDim2.fromOffset(14,0),Size=UDim2.new(1,-14,1,0),Parent=d})c.statusRow,c.statusDot,c.statusLbl=d,e,b;local a=q("Frame",{BackgroundTransparency=1,Visible=false,AnchorPoint=Vector2.new(0.5,1),Position=UDim2.new(0.5,0,1,-16),Size=UDim2.new(1,-44,0,38),Parent=a})q("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Center,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder,Parent=a})c.btnRow=a;c:_enter()c:_drag()c:_keys()c:startPulse()return c end;function d:track(a)table.insert(self.conns,a)return a end;function d:_enter()s(self.win,r(0.22),{GroupTransparency=0})s(self.scale,r(0.32,Enum.EasingStyle.Back),{Scale=1})end;function d:_drag()local b,c,d;self:track(self.header.InputBegan:Connect(function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then b,c,d=true,a.Position,self.holder.Position end end))self:track(a.InputChanged:Connect(function(a)if b and(a.UserInputType==Enum.UserInputType.MouseMovement or a.UserInputType==Enum.UserInputType.Touch)then local a=a.Position-c;self.holder.Position=UDim2.new(d.X.Scale,d.X.Offset+a.X,d.Y.Scale,d.Y.Offset+a.Y)end end))self:track(a.InputEnded:Connect(function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch then b=false end end))end;function d:_keys()self:track(a.InputBegan:Connect(function(a,b)if not b and a.KeyCode==Enum.KeyCode.Return then self:destroy()end end))end;function d:startPulse()if self.pulseTween then return end;self.iconStroke.Transparency=0.4;self.pulseTween=s(self.iconStroke,TweenInfo.new(0.9,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{Transparency=0.8})end;function d:stopPulse()if self.pulseTween then self.pulseTween:Cancel()self.pulseTween=nil end;self.iconStroke.Transparency=0.4 end;function d:mode(a,b)self.pillLbl.Text=a;self.pillLbl.TextColor3=b;self.pillStroke.Color=b;self.pillStroke.Transparency=b==i.faint and 0.4 or 0.25 end;function d:icon(a,b)self.iconWrap.BackgroundColor3=a;self.iconStroke.Color=a;if b then self.logo.Visible=false;self.glyph.Visible=true;self.glyph.Text=b;self.glyph.TextColor3=a else self.glyph.Visible=false;self.logo.Visible=true;self.logo.ImageColor3=a end end;function d:set(a)if a.title then self.title.Text=a.title end;if a.titleColor then self.title.TextColor3=a.titleColor end;if a.body then self.body.Text=a.body end;if a.status then self.statusLbl.Text=a.status end;if a.statusDot then self.statusDot.BackgroundColor3=a.statusDot end end;function d:working(a)self.progWrap.Visible=a;self.statusRow.Visible=a;self.btnRow.Visible=not a;if a then self:startPulse()else self:stopPulse()end end;function d:progress(a)self.sweep.Visible=false;if self.sweepTween then self.sweepTween:Cancel()self.sweepTween=nil end;s(self.fill,r(0.35),{Size=UDim2.new(math.clamp(a,0,1),0,1,0)})end;function d:busy()self:working(true)self.fill.Size=UDim2.new(0,0,1,0)self.sweep.Visible=true;if self.sweepTween then self.sweepTween:Cancel()end;self.sweep.Position=UDim2.new(-0.35,0,0,0)self.sweepTween=s(self.sweep,TweenInfo.new(1.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,-1),{Position=UDim2.new(1.03,0,0,0)})end;function d:nag(a,b)self:mode("KEYLESS",i.accent)self:icon(i.accent)self:set({title="Free & Keyless",titleColor=i.accent,body="This script is completely free and keyless, from Cerberus.\n\nJoin our Discord to skip the wait — and to unlock all our other keyless scripts, free."})self.progWrap.Visible=true;self.statusRow.Visible=true;self:startPulse()self:buttons({{text="Copy Discord",kind="primary",flash="Link copied!",cb=function()if setclipboard then setclipboard(b)return true end;return false end},{text="Skip the wait",kind="ghost",cb=function()self:popup({title="Skip the wait — go keyless",intro="This script is free forever. Grab it from our Discord and you'll never see this wait again.",steps={"Join the Cerberus Discord.","Open the #free-panel channel.","Run the loader posted there — instant, every time."},footer="Every other Cerberus keyless script lives there too, all free.",buttons={{text="Copy Discord",kind="primary",flash="Link copied!",cb=function()if setclipboard then setclipboard(b)return true end;return false end},{text="Got it",kind="ghost",close=true}}})end}})self.sweep.Visible=false;if self.sweepTween then self.sweepTween:Cancel()self.sweepTween=nil end;self.fill.Size=UDim2.new(0,0,1,0)s(self.fill,TweenInfo.new(a,Enum.EasingStyle.Linear),{Size=UDim2.new(1,0,1,0)})for a=a,1,-1 do if not self.gui then return false end;self.statusLbl.Text="Continuing in "..a.."s"task.wait(1)end;self:closePopup()return self.gui~=nil end;function d:popup(a)self:closePopup()local c=q("TextButton",{Text="",AutoButtonColor=false,BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=500,Parent=self.gui})s(c,r(0.18),{BackgroundTransparency=0.55})local d=q("Frame",{BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(400,10),AutomaticSize=Enum.AutomaticSize.Y,ZIndex=501,Parent=self.gui})local e=q("UIScale",{Scale=0.9,Parent=d})local f=q("Frame",{BackgroundColor3=i.surface,Size=UDim2.new(1,0,0,10),AutomaticSize=Enum.AutomaticSize.Y,Parent=d})b(f,16)t(f,i.white,0.88)q("UIPadding",{PaddingTop=UDim.new(0,18),PaddingBottom=UDim.new(0,16),PaddingLeft=UDim.new(0,18),PaddingRight=UDim.new(0,18),Parent=f})q("UIListLayout",{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder,Parent=f})v({Text=a.title or"Cerberus",FontFace=o.bold,TextSize=18,TextColor3=i.text,Size=UDim2.new(1,0,0,24),LayoutOrder=1,Parent=f})if a.intro then v({Text=a.intro,TextSize=13,TextColor3=i.subtext,TextWrapped=true,AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,0,0,0),LayoutOrder=2,Parent=f})end;for a,c in ipairs(a.steps or{})do local d=q("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,26),LayoutOrder=10+a,Parent=f})local e=q("Frame",{BackgroundColor3=i.accent,BackgroundTransparency=0.85,Position=UDim2.fromOffset(0,2),Size=UDim2.fromOffset(22,22),Parent=d})b(e,6)t(e,i.accent,0.4)v({Text=tostring(a),FontFace=o.bold,TextSize=12,TextColor3=i.accent,TextXAlignment=Enum.TextXAlignment.Center,Size=UDim2.fromScale(1,1),Parent=e})v({Text=c,TextSize=13,TextColor3=i.text,TextYAlignment=Enum.TextYAlignment.Center,Position=UDim2.fromOffset(32,0),Size=UDim2.new(1,-32,1,0),Parent=d})end;if a.footer then v({Text=a.footer,TextSize=12,TextColor3=i.faint,TextWrapped=true,AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,0,0,0),LayoutOrder=40,Parent=f})end;local f=q("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,38),LayoutOrder=50,Parent=f})q("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Center,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,10),Parent=f})for a,c in ipairs(a.buttons or{})do local d=c.kind=="primary"local a=q("TextButton",{Text=c.text,FontFace=d and o.semi or o.med,TextSize=13,TextColor3=d and i.accentDk or i.subtext,AutoButtonColor=false,BackgroundColor3=d and i.accent or i.surface2,Size=UDim2.fromOffset(d and 150 or 96,34),LayoutOrder=a,Parent=f})b(a,9)if not d then t(a,i.white,0.9)end;self:track(a.MouseEnter:Connect(function()s(a,r(0.1),d and{BackgroundColor3=i.accentHi}or{TextColor3=i.text,BackgroundColor3=i.track})end))self:track(a.MouseLeave:Connect(function()s(a,r(0.16),d and{BackgroundColor3=i.accent}or{TextColor3=i.subtext,BackgroundColor3=i.surface2})end))self:track(a.MouseButton1Click:Connect(function()local b=c.cb and c.cb()if c.flash then a.Text=b==false and"Unavailable"or c.flash;task.delay(1.4,function()if a.Parent then a.Text=c.text end end)end;if c.close then self:closePopup()end end))end;s(e,r(0.28,Enum.EasingStyle.Back),{Scale=1})self._popup={scrim=c,holder=d,scale=e}self:track(c.MouseButton1Click:Connect(function()self:closePopup()end))end;function d:closePopup()local a=self._popup;if not a then return end;self._popup=nil;s(a.scrim,r(0.16),{BackgroundTransparency=1})local b=s(a.scale,r(0.14),{Scale=0.9})b.Completed:Connect(function()if a.scrim then a.scrim:Destroy()end;if a.holder then a.holder:Destroy()end end)end;function d:buttons(a)for a,a in ipairs(self.btnRow:GetChildren())do if a:IsA("TextButton")then a:Destroy()end end;if not a or#a==0 then self.btnRow.Visible=false;return end;for a,c in ipairs(a)do local d=c.kind=="primary"local e=d and 158 or 116;local a=q("TextButton",{Text=c.text,FontFace=d and o.semi or o.med,TextSize=13,TextColor3=d and i.accentDk or i.subtext,AutoButtonColor=false,BackgroundColor3=d and i.accent or i.surface2,LayoutOrder=a,Size=UDim2.fromOffset(e,36),Parent=self.btnRow})b(a,10)if not d then t(a,i.white,0.9)end;self:track(a.MouseEnter:Connect(function()s(a,r(0.1),d and{BackgroundColor3=i.accentHi}or{TextColor3=i.text,BackgroundColor3=i.track})end))self:track(a.MouseLeave:Connect(function()s(a,r(0.16),d and{BackgroundColor3=i.accent}or{TextColor3=i.subtext,BackgroundColor3=i.surface2})end))self:track(a.MouseButton1Click:Connect(function()if c.flash then local b=c.cb and c.cb()a.Text=b==false and"Unavailable"or c.flash;task.delay(1.4,function()if a.Parent then a.Text=c.text end end)elseif c.cb then c.cb()end end))end;self.btnRow.Visible=true end;function d:fadeOut(a)self:stopPulse()if self.sweepTween then self.sweepTween:Cancel()self.sweepTween=nil end;s(self.scale,r(0.2),{Scale=0.96})local b=s(self.win,r(0.2),{GroupTransparency=1})b.Completed:Connect(function()self:destroy()if a then a()end end)end;function d:destroy()for a,a in ipairs(self.conns)do pcall(function()a:Disconnect()end)end;table.clear(self.conns)if self.gui then self.gui:Destroy()self.gui=nil end end;local a=d.new()local function b(a)if setclipboard then setclipboard(a)return true end;return false end;local function d(b)a:stopPulse()a:working(false)a:mode(b.pill or"ERROR",b.color or i.danger)a:icon(b.color or i.danger,b.glyph or"!")a:set({title=b.title,titleColor=b.color or i.danger,body=b.body})a:buttons(b.buttons)end;local h={text="Close",kind="ghost",cb=function()a:destroy()end}local o={text="Copy Discord",kind="primary",flash="Discord copied!",cb=function()return b(g)end}local function q()p()if not n then return true,"NO_SDK"end;local a=l.script_key or _G.script_key or script_key;if not a or#tostring(a)<20 then return false,"NO_KEY"end;local b;pcall(function()b=n.check_key(tostring(a))end)if b and b.code=="KEY_VALID"then return true,"KEY_VALID"end;return false,(b and b.code)or"UNKNOWN"end;local function n(a,b)local a=b and(a.."?t="..tostring(math.random(1,1000000)))or a;local b,c=pcall(function()return game:HttpGet(a)end)if b and type(c)=="string"and#c>10 then return c end;local b=(type(request)=="function"and request)or(type(http_request)=="function"and http_request)or(type(syn)=="table"and type(syn.request)=="function"and syn.request)if b then local a,b=pcall(function()return b({Url=a,Method="GET"})end)if a and b and b.Body and#b.Body>10 then return b.Body end end;return nil,tostring(c)end;local function p(c,e,f)a:set({status="Loading "..e,statusDot=i.accent})a:busy()local g,j=n(c,f)if not g then d({title="Couldn't reach the servers",pill="OFFLINE",body="We couldn't fetch "..e..". Check your connection and try again.\n\n"..tostring(j),buttons={{text="Retry",kind="primary",cb=function()task.spawn(p,c,e,f)end},{text="Copy Error",kind="ghost",flash="Copied!",cb=function()return b(tostring(j))end},h}})return end;local g,j=loadstring(g)if not g then d({title="Couldn't run the script",pill="ERROR",body="The script loaded but wouldn't compile — usually a temporary build issue. Try again shortly.\n\n"..tostring(j),buttons={{text="Retry",kind="primary",cb=function()task.spawn(p,c,e,f)end},{text="Copy Error",kind="ghost",flash="Copied!",cb=function()return b(tostring(j))end},h}})return end;a:set({title="Ready",body="Launching "..e..".",status="Loaded",statusDot=i.accent})a:progress(1)task.wait(0.2)a:fadeOut(function()pcall(g)end)end;task.spawn(function()local n=l.script_key or _G.script_key or script_key;local n=m(l.inDiscord or _G.inDiscord)or m(n)if not n then if not a:nag(60,g)then return end end;a:set({title="Starting up",body="Getting Cerberus ready.",status="Detecting game",statusDot=i.accent})a:busy()task.wait(0.35)local g=tostring(game.GameId)local g=j[g]if not g then a:mode("UNIVERSAL",i.amber)a:icon(i.amber,"∞")a:set({title="Universal Mode",titleColor=i.amber,body="This game isn't in the Cerberus catalog yet, so we're loading the universal script instead.",status="Falling back to universal",statusDot=i.amber})a:busy()task.wait(1.1)p(f,"the Universal script",false)return end;local f=g;local c=c(f)local j=l.VARIANT or _G.VARIANT;if type(j)=="string"and j~=""then g=g:gsub("%.lua$","").."."..j..".lua"end;a:set({title=c,body="Found a dedicated Cerberus script for this game.",status="Game detected",statusDot=i.accent})a:progress(0.25)task.wait(0.3)local f=k[f]==true;local j=m(l.CERBERUS_ALLOW_NO_KEY or _G.CERBERUS_ALLOW_NO_KEY)if f then a:mode("FREE",i.accent)a:set({status="No key required",statusDot=i.accent})elseif j then a:mode("NO-KEY",i.amber)a:set({status="Key check bypassed",statusDot=i.amber})else a:set({status="Verifying key"})a:progress(0.45)task.wait(0.2)local c,e=q()if not c then if e=="NO_KEY"then d({title="No key found",pill="NO KEY",body="We couldn't find a Cerberus key. Grab one from our Discord, then run the script again.\n\nAlready loaded a key? Make sure script_key is set before running the loader.",buttons={o,h}})else d({title="Key not valid",pill="KEY",body="Your key didn't pass verification ("..tostring(e).."). It may be expired, reset, or for a different plan. Get a fresh one from our Discord.",buttons={o,{text="Copy Code",kind="ghost",flash="Copied!",cb=function()return b(tostring(e))end},h}})end;return end;a:set({status="Key verified",statusDot=i.accent})end;a:progress(0.6)task.wait(0.2)p(e..g,c,true)end)
