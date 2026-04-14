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
local HttpService=game:GetService("HttpService")local UserInputService=game:GetService("UserInputService")local TweenService=game:GetService("TweenService")local CoreGui=game:GetService("CoreGui")local GITHUB_BASE_URL="https://raw.githubusercontent.com/safetrademarketplace/scripts/refs/heads/main/"local CERBERUS_TITLE="CERBERUS LOADER"local CERBERUS_PRIMARY=Color3.fromRGB(90,255,140)local CERBERUS_SECONDARY=Color3.fromRGB(45,200,100)local CERBERUS_BG_DARK=Color3.fromRGB(10,14,20)local CERBERUS_BG_CARD=Color3.fromRGB(18,24,32)local CERBERUS_BG_HEADER=Color3.fromRGB(18,30,40)local CERBERUS_ERROR_RED=Color3.fromRGB(255,90,90)local CERBERUS_TEXT_MAIN=Color3.fromRGB(235,245,255)local CERBERUS_LOGO_ASSET="rbxassetid://136497541793809"local CERBERUS_DISCORD_URL="https://getcerberus.com/discord"local UNIVERSE_MAP={["3764534614"]="runeSlayer.lua",["6115988515"]="animeSaga.lua",["7095682825"]="beaks.lua",["4777817887"]="bladeBall.lua",["18668065416"]="blueLock.lua",["85896571713843"]="bgsi.lua",["7018190066"]="deadRails.lua",["2880808628"]="ffo.lua",["5750914919"]="fisch.lua",["6331902150"]="foresaken.lua",["7436755782"]="gag.lua",["2535080489"]="herosOnline.lua",["7314989375"]="hunters.lua",["6048923315"]="kaizen.lua",["7513130835"]="untitledDrillGame.lua",["6931042565"]="volleyballLegends.lua",["4931927012"]="basketballLegends.lua",["6770632849"]="mugen.lua",["7218065222"]="dig.lua",["4737765103"]="murimCultivation.lua",["4871329703"]="typeSoul.lua",["5569032992"]="dandysWorld.lua",["7709344486"]="stealABrainrot.lua",["5677613211"]="eatTheWorld.lua",["7822444776"]="buildAPlane.lua",["7326934954"]="99NITF.lua",["4862269388"]="archived.lua",["8051387991"]="rebornCultivation.lua",["7882829745"]="animeEternal.lua",["7219654364"]="murderersVsSheriffs.lua",["1946714362"]="bloodlines.lua",["7718422952"]="newMoon.lua",["7671049560"]="theForge.lua",["6490954291"]="ghoulRe.lua",["9391202356"]="ghoulRe.lua",["7440311707"]="demonHunter.lua",["7024319539"]="reawakened.lua",["9363735110"]="tsunamiBrainrot.lua",["9344307274"]="breakALuckyBlock.lua",["5831253580"]="sorcererAscent.lua",["1828997286"]="excry.lua",["8144728961"]="abyss.lua",["6701277882"]="fishIt.lua",["9649298941"]="ELFB.lua",["9563386957"]="CFB.lua",["7048187681"]="slayerbound.lua",["9484779066"]="SAB.lua",["7983308985"]="lastLetter.lua",["648454481"]="GPO.lua",["9509842868"]="gardenHorizons.lua",["5130394318"]="bizzareLineage.lua",["9663968307"]="hooked.lua",["9872691883"]="everwind.lua",["4818959878"]="mashle.lua",["3726919761"]="cursedGear.lua",["8524572339"]="bridger.lua",["8202280624"]="bbn.lua",["9186719164"]="sailor.lua",["6161049307"]="pixelBlade.lua",["3646793294"]="paradox.lua",["4658598196"]="aotr.lua"}local LUARMOR_SDK_URL="https://sdkapi-public.luarmor.net/library.lua"local LUARMOR_SCRIPT_ID="2a503330cb8ca154841314e3b291f7bf"local LuarmorAPI;local LuarmorInitDone=false;local function initLuarmor()if LuarmorInitDone then return end;LuarmorInitDone=true;if type(LUARMOR_SCRIPT_ID)~="string"or LUARMOR_SCRIPT_ID==""then return end;local ok,libOrErr=pcall(function()return loadstring(game:HttpGet(LUARMOR_SDK_URL))()end)if ok and type(libOrErr)=="table"then LuarmorAPI=libOrErr;LuarmorAPI.script_id=LUARMOR_SCRIPT_ID end end;local function makeDraggable(frame,dragArea)local dragging,dragInput,dragStart,startPos;local function update(input)local delta=input.Position-dragStart;frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)end;dragArea.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=input.Position;startPos=frame.Position;input.Changed:Connect(function()if input.UserInputState==Enum.UserInputState.End then dragging=false end end)end end)dragArea.InputChanged:Connect(function(input)if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)UserInputService.InputChanged:Connect(function(input)if input==dragInput and dragging then update(input)end end)end;local function showErrorGui(message,copyMode)copyMode=copyMode or"error"local existing=CoreGui:FindFirstChild("CerberusLoaderGui")if existing then existing:Destroy()end;local scr=Instance.new("ScreenGui",CoreGui)scr.Name="CerberusLoaderGui"scr.IgnoreGuiInset=true;scr.ResetOnSpawn=false;local frame=Instance.new("Frame",scr)frame.Name="Card"frame.Size=UDim2.new(0,520,0,240)frame.Position=UDim2.new(0.5,-260,0.5,-120)frame.BackgroundColor3=CERBERUS_BG_CARD;frame.BorderSizePixel=0;local cardCorner=Instance.new("UICorner",frame)cardCorner.CornerRadius=UDim.new(0,18)local header=Instance.new("Frame",frame)header.Name="Header"header.BackgroundColor3=CERBERUS_BG_HEADER;header.BorderSizePixel=0;header.Size=UDim2.new(1,0,0,46)local headCorner=Instance.new("UICorner",header)headCorner.CornerRadius=UDim.new(0,18)makeDraggable(frame,header)local title=Instance.new("TextLabel",header)title.Size=UDim2.new(1,-60,1,0)title.Position=UDim2.new(0,20,0,0)title.Font=Enum.Font.GothamBold;title.TextSize=20;title.TextColor3=CERBERUS_TEXT_MAIN;title.TextXAlignment=Enum.TextXAlignment.Left;title.Text="ERROR"title.BackgroundTransparency=1;local content=Instance.new("ScrollingFrame",frame)content.Name="Content"content.BackgroundTransparency=1;content.BorderSizePixel=0;content.Size=UDim2.new(1,-32,1,-110)content.Position=UDim2.new(0,16,0,60)content.ScrollBarThickness=3;content.CanvasSize=UDim2.new(0,0,0,0)content.AutomaticCanvasSize=Enum.AutomaticSize.Y;local txt=Instance.new("TextLabel",content)txt.Size=UDim2.new(1,-10,0,0)txt.AutomaticSize=Enum.AutomaticSize.Y;txt.Font=Enum.Font.GothamSemibold;txt.TextSize=16;txt.TextColor3=CERBERUS_ERROR_RED;txt.TextWrapped=true;txt.TextXAlignment=Enum.TextXAlignment.Left;txt.TextYAlignment=Enum.TextYAlignment.Top;txt.Text=tostring(message or"Unknown error.")txt.BackgroundTransparency=1;local btnContainer=Instance.new("Frame",frame)btnContainer.Size=UDim2.new(1,-32,0,40)btnContainer.Position=UDim2.new(0,16,1,-55)btnContainer.BackgroundTransparency=1;local layout=Instance.new("UIListLayout",btnContainer)layout.FillDirection=Enum.FillDirection.Horizontal;layout.HorizontalAlignment=Enum.HorizontalAlignment.Center;layout.Padding=UDim.new(0,15)local closeBtn=Instance.new("TextButton",btnContainer)closeBtn.Size=UDim2.new(0,150,1,0)closeBtn.BackgroundColor3=Color3.fromRGB(40,45,55)closeBtn.Font=Enum.Font.GothamBold;closeBtn.TextSize=18;closeBtn.TextColor3=CERBERUS_TEXT_MAIN;closeBtn.Text="Close"Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,10)local copyBtn=Instance.new("TextButton",btnContainer)copyBtn.Size=UDim2.new(0,150,1,0)copyBtn.BackgroundColor3=CERBERUS_PRIMARY;copyBtn.Font=Enum.Font.GothamBold;copyBtn.TextSize=18;copyBtn.TextColor3=CERBERUS_BG_DARK;copyBtn.Text=(copyMode=="discord")and"Copy Discord"or"Copy Error"Instance.new("UICorner",copyBtn).CornerRadius=UDim.new(0,10)closeBtn.MouseButton1Click:Connect(function()scr:Destroy()end)copyBtn.MouseButton1Click:Connect(function()local payload=(copyMode=="discord")and CERBERUS_DISCORD_URL or tostring(message)if setclipboard then setclipboard(payload)copyBtn.Text="Copied!"task.delay(1.5,function()copyBtn.Text=(copyMode=="discord")and"Copy Discord"or"Copy Error"end)else copyBtn.Text="Error!"end end)end;local function softLuarmorGate()initLuarmor()if not LuarmorAPI then return true end;local key=_G.script_key or script_key;if not key or#tostring(key)<20 then showErrorGui("No Cerberus key detected.\n\nGet one from our Discord:\n"..CERBERUS_DISCORD_URL,"discord")return false end;local status;pcall(function()status=LuarmorAPI.check_key(tostring(key))end)if status and status.code=="KEY_VALID"then return true else showErrorGui("Key Validation Failed: "..tostring(status and status.code or"UNKNOWN"),"error")return false end end;local function robustDownload(url)local content=nil;local err_msg="Unknown error"local max_attempts=3;local reqFunc=(type(request)=="function"and request)or(type(http_request)=="function"and http_request)or(type(syn)=="table"and type(syn.request)=="function"and syn.request)for i=1,max_attempts do local cleanUrl=url.."?t="..tostring(math.random(1,1000000))local success,res=pcall(function()return game:HttpGet(cleanUrl)end)if success and type(res)=="string"and#res>10 then return res else err_msg=tostring(res)end;if reqFunc then local reqSuccess,reqResult=pcall(function()return reqFunc({Url=cleanUrl,Method="GET"})end)if reqSuccess and reqResult and reqResult.Body then if#reqResult.Body>10 then return reqResult.Body end end end;task.wait(1)end;return nil,err_msg end;local universeId=tostring(game.GameId)local fileName=UNIVERSE_MAP[universeId]if not fileName then loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/1acad587672d96c8afb9c5bbc36bf921.lua"))()return end;if _G.VARIANT and type(_G.VARIANT)=="string"then fileName=fileName:gsub("%.lua$","")..".".._G.VARIANT..".lua"end;if not softLuarmorGate()then return end;local finalUrl=GITHUB_BASE_URL..fileName;local scriptContent,downloadErr=robustDownload(finalUrl)if scriptContent then local func,loadErr=loadstring(scriptContent)if func then pcall(func)else showErrorGui("Failed to parse script:\n"..tostring(loadErr),"error")end else showErrorGui("Failed to download script after retries.\n\nError: "..tostring(downloadErr),"error")end
