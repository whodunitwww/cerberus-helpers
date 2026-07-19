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
local a=game:GetService("HttpService")local a=game:GetService("UserInputService")local b=game:GetService("TweenService")local b=game:GetService("CoreGui")local c="https://raw.githubusercontent.com/safetrademarketplace/scripts/refs/heads/main/"local d="CERBERUS LOADER"local d=Color3.fromRGB(90,255,140)local e=Color3.fromRGB(45,200,100)local e=Color3.fromRGB(10,14,20)local f=Color3.fromRGB(18,24,32)local g=Color3.fromRGB(18,30,40)local h=Color3.fromRGB(255,90,90)local i=Color3.fromRGB(235,245,255)local j="rbxassetid://136497541793809"local j="https://getcerberus.com/discord"local k={["3764534614"]="runeSlayer.lua",["6115988515"]="animeSaga.lua",["7095682825"]="beaks.lua",["4777817887"]="bladeBall.lua",["18668065416"]="blueLock.lua",["85896571713843"]="bgsi.lua",["7018190066"]="deadRails.lua",["2880808628"]="ffo.lua",["5750914919"]="fisch.lua",["6331902150"]="foresaken.lua",["7436755782"]="gag.lua",["2535080489"]="herosOnline.lua",["7314989375"]="hunters.lua",["6048923315"]="kaizen.lua",["7513130835"]="untitledDrillGame.lua",["6931042565"]="volleyballLegends.lua",["4931927012"]="basketballLegends.lua",["6770632849"]="mugen.lua",["7218065222"]="dig.lua",["4737765103"]="murimCultivation.lua",["4871329703"]="typeSoul.lua",["5569032992"]="dandysWorld.lua",["7709344486"]="stealABrainrot.lua",["5677613211"]="eatTheWorld.lua",["7822444776"]="buildAPlane.lua",["7326934954"]="99NITF.lua",["4862269388"]="archived.lua",["8051387991"]="rebornCultivation.lua",["7882829745"]="animeEternal.lua",["7219654364"]="murderersVsSheriffs.lua",["1946714362"]="bloodlines.lua",["7718422952"]="newMoon.lua",["7671049560"]="theForge.lua",["6490954291"]="ghoulRe.lua",["9391202356"]="ghoulRe.lua",["7440311707"]="demonHunter.lua",["7024319539"]="reawakened.lua",["9363735110"]="tsunamiBrainrot.lua",["9344307274"]="breakALuckyBlock.lua",["5831253580"]="sorcererAscent.lua",["1828997286"]="excry.lua",["8144728961"]="abyss.lua",["6701277882"]="fishIt.lua",["9649298941"]="ELFB.lua",["9563386957"]="CFB.lua",["7048187681"]="slayerbound.lua",["9484779066"]="SAB.lua",["7983308985"]="lastLetter.lua",["648454481"]="GPO.lua",["9509842868"]="gardenHorizons.lua",["5130394318"]="bizzareLineage.lua",["9663968307"]="hooked.lua",["9872691883"]="everwind.lua",["4818959878"]="mashle.lua",["3726919761"]="cursedGear.lua",["8524572339"]="bridger.lua",["8202280624"]="bbn.lua",["9186719164"]="sailor.lua",["6161049307"]="pixelBlade.lua",["3646793294"]="paradox.lua",["4658598196"]="aotr.lua",["10016841656"]="noobTD.lua",["1359573625"]="deepwoken.lua",["9792947201"]="slime.lua",["6409513651"]="animeWarriors3.lua",["10006104044"]="wizardsAlchemy.lua",["2309918273"]="vv.lua",["9826885587"]="evomon.lua",["10200395747"]="gag2.lua",["2644656496"]="hazeSeas.lua",["9199655655"]="gakuran.lua",["7613921865"]="animeExpeditions.lua"}local l="https://sdkapi-public.luarmor.net/library.lua"local m="2a503330cb8ca154841314e3b291f7bf"local n;local o=false;local function p()if o then return end;o=true;if type(m)~="string"or m==""then return end;local a,b=pcall(function()return loadstring(game:HttpGet(l))()end)if a and type(b)=="table"then n=b;n.script_id=m end end;local function l(b,c)local d,e,f,g;local function h(a)local a=a.Position-f;b.Position=UDim2.new(g.X.Scale,g.X.Offset+a.X,g.Y.Scale,g.Y.Offset+a.Y)end;c.InputBegan:Connect(function(a)if a.UserInputType==Enum.UserInputType.MouseButton1 then d=true;f=a.Position;g=b.Position;a.Changed:Connect(function()if a.UserInputState==Enum.UserInputState.End then d=false end end)end end)c.InputChanged:Connect(function(a)if a.UserInputType==Enum.UserInputType.MouseMovement then e=a end end)a.InputChanged:Connect(function(a)if a==e and d then h(a)end end)end;local function a(a,c)c=c or"error"local k=b:FindFirstChild("CerberusLoaderGui")if k then k:Destroy()end;local b=Instance.new("ScreenGui",b)b.Name="CerberusLoaderGui"b.IgnoreGuiInset=true;b.ResetOnSpawn=false;local k=Instance.new("Frame",b)k.Name="Card"k.Size=UDim2.new(0,520,0,240)k.Position=UDim2.new(0.5,-260,0.5,-120)k.BackgroundColor3=f;k.BorderSizePixel=0;local f=Instance.new("UICorner",k)f.CornerRadius=UDim.new(0,18)local f=Instance.new("Frame",k)f.Name="Header"f.BackgroundColor3=g;f.BorderSizePixel=0;f.Size=UDim2.new(1,0,0,46)local g=Instance.new("UICorner",f)g.CornerRadius=UDim.new(0,18)l(k,f)local f=Instance.new("TextLabel",f)f.Size=UDim2.new(1,-60,1,0)f.Position=UDim2.new(0,20,0,0)f.Font=Enum.Font.GothamBold;f.TextSize=20;f.TextColor3=i;f.TextXAlignment=Enum.TextXAlignment.Left;f.Text="ERROR"f.BackgroundTransparency=1;local f=Instance.new("ScrollingFrame",k)f.Name="Content"f.BackgroundTransparency=1;f.BorderSizePixel=0;f.Size=UDim2.new(1,-32,1,-110)f.Position=UDim2.new(0,16,0,60)f.ScrollBarThickness=3;f.CanvasSize=UDim2.new(0,0,0,0)f.AutomaticCanvasSize=Enum.AutomaticSize.Y;local f=Instance.new("TextLabel",f)f.Size=UDim2.new(1,-10,0,0)f.AutomaticSize=Enum.AutomaticSize.Y;f.Font=Enum.Font.GothamSemibold;f.TextSize=16;f.TextColor3=h;f.TextWrapped=true;f.TextXAlignment=Enum.TextXAlignment.Left;f.TextYAlignment=Enum.TextYAlignment.Top;f.Text=tostring(a or"Unknown error.")f.BackgroundTransparency=1;local f=Instance.new("Frame",k)f.Size=UDim2.new(1,-32,0,40)f.Position=UDim2.new(0,16,1,-55)f.BackgroundTransparency=1;local g=Instance.new("UIListLayout",f)g.FillDirection=Enum.FillDirection.Horizontal;g.HorizontalAlignment=Enum.HorizontalAlignment.Center;g.Padding=UDim.new(0,15)local g=Instance.new("TextButton",f)g.Size=UDim2.new(0,150,1,0)g.BackgroundColor3=Color3.fromRGB(40,45,55)g.Font=Enum.Font.GothamBold;g.TextSize=18;g.TextColor3=i;g.Text="Close"Instance.new("UICorner",g).CornerRadius=UDim.new(0,10)local f=Instance.new("TextButton",f)f.Size=UDim2.new(0,150,1,0)f.BackgroundColor3=d;f.Font=Enum.Font.GothamBold;f.TextSize=18;f.TextColor3=e;f.Text=(c=="discord")and"Copy Discord"or"Copy Error"Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)g.MouseButton1Click:Connect(function()b:Destroy()end)f.MouseButton1Click:Connect(function()local a=(c=="discord")and j or tostring(a)if setclipboard then setclipboard(a)f.Text="Copied!"task.delay(1.5,function()f.Text=(c=="discord")and"Copy Discord"or"Copy Error"end)else f.Text="Error!"end end)end;local function b()p()if not n then return true end;local b=_G.script_key or script_key;if not b or#tostring(b)<20 then a("No Cerberus key detected.\n\nGet one from our Discord:\n"..j,"discord")return false end;local c;pcall(function()c=n.check_key(tostring(b))end)if c and c.code=="KEY_VALID"then return true else a("Key Validation Failed: "..tostring(c and c.code or"UNKNOWN"),"error")return false end end;local function d(a)local b=nil;local b="Unknown error"local c=3;local d=(type(request)=="function"and request)or(type(http_request)=="function"and http_request)or(type(syn)=="table"and type(syn.request)=="function"and syn.request)for c=1,c do local a=a.."?t="..tostring(math.random(1,1000000))local c,e=pcall(function()return game:HttpGet(a)end)if c and type(e)=="string"and#e>10 then return e else b=tostring(e)end;if d then local a,b=pcall(function()return d({Url=a,Method="GET"})end)if a and b and b.Body then if#b.Body>10 then return b.Body end end end;task.wait(1)end;return nil,b end;local e=tostring(game.GameId)local e=k[e]if not e then loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/1acad587672d96c8afb9c5bbc36bf921.lua"))()return end;if _G.VARIANT and type(_G.VARIANT)=="string"then e=e:gsub("%.lua$","")..".".._G.VARIANT..".lua"end;if not b()then return end;local b=c..e;local b,c=d(b)if b then local b,c=loadstring(b)if b then pcall(b)else a("Failed to parse script:\n"..tostring(c),"error")end else a("Failed to download script after retries.\n\nError: "..tostring(c),"error")end
