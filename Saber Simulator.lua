
--format numbers (ignore)
local a={}local function b(c)return"'"..c.."'"end;function a.AbbreviationToCLDR(d,e)local f={}for g,h in ipairs(d)do for i=1,3 do if h==''or not h then table.insert(f,'0')else table.insert(f,(e and'¤'or'')..('0'):rep(i)..h:gsub('¤',"'¤'"):gsub('‰',"'‰'"):gsub("[.;,#%%]",b):gsub("'","''"))end end end;return f end;local j=a.AbbreviationToCLDR{"k","M","B","T","qd","Qn","sx","Sp","O","N","de","Ud","DD","tdD","qdD","QnD","sxD","SpD","OcD","NvD","Vgn","UVg","DVg","TVg","qtV","QnV","SeV","SPG","OVG","NVG","TGN","UTG","DTG","tsTG","qtTG","QnTG","ssTG","SpTG","OcTG","NoTG","QdDR","uQDR","dQDR","tQDR","qdQDR","QnQDR","sxQDR","SpQDR","OQDDr","NQDDr","qQGNT","uQGNT","dQGNT","tQGNT","qdQGNT","QnQGNT","sxQGNT","SpQGNT","OQQGNT","NQQGNT","SXGNTL","USXGNTL","DSXGNTL","TSXGNTL","QTSXGNTL","QNSXGNTL","SXSXGNTL","SPSXGNTL","OSXGNTL","NVSXGNTL","SPTGNTL","USPTGNTL","DSPTGNTL","TSPTGNTL","QTSPTGNTL","QNSPTGNTL","SXSPTGNTL","SPSPTGNTL","OSPTGNTL","NVSPTGNTL","OTGNTL","UOTGNTL","DOTGNTL","TOTGNTL","QTOTGNTL","QNOTGNTL","SXOTGNTL","SPOTGNTL","OTOTGNTL","NVOTGNTL","NONGNTL","UNONGNTL","DNONGNTL","TNONGNTL","QTNONGNTL","QNNONGNTL","SXNONGNTL","SPNONGNTL","OTNONGNTL","NONONGNTL","CENT","UNCENT"}local k={'¤','%','-','+','E','','‰','*'}local function l(m)local n=m;if type(m)~="string"then error("Compact patterns must be a table of string",4)end;local f,o,p={},0,1;while p do local q=math.min(m:find("[0-9@#.,+%%;*'-]",p)or#m+1,m:find('¤',p)or#m+1,m:find('‰',p)or#m+1)local r=q+((m:sub(q,q+1)=='¤'or m:sub(q,q+1)=='‰')and 1 or 0)local s=m:sub(q,r)if s=="'"then local t=m:sub(p,q-1)p=m:find("'",q+1)if p==q+1 then t=t.."'"elseif p then t=t..m:sub(q+1,p-1)else error("'"..n.."' is not a valid pattern",2)end;table.insert(f,t)p=p+1 elseif s:match('[1-9]')then error("The rounding (1-9) pattern isn't supported",4)elseif s=='¤'or s=='‰'or s:match('[%%*+%-]')then error("The '"..s.."' pattern isn't supported",4)elseif s=='0'then table.insert(f,m:sub(p,q-1))table.insert(f,0)p=m:find('[^0]',q)local u=m:sub(q,(p or#m+1)-1)if not u:match('^0+$')or o>0 then error("'"..n.."' is not a valid pattern",4)end;o=#u else table.insert(f,m:sub(p))p=nil end end;return f,o end;local v={groupSymbol="f/str",decimalSymbol="f/str",compactPattern="f/table",style={"decimal","currency","percent"},useGrouping={"min2","always","never"},minimumIntegerDigits="f/1..",maximumIntegerDigits="f/minimumIntegerDigits..inf",minimumFractionDigits="f/0..",maximumFractionDigits="f/minimumFractionDigits..inf",minimumSignificantDigits="f/1..",maximumSignificantDigits="f/minimumSignificantDigits..inf",currency="f/str",rounding={"halfUp","halfEven","halfDown","ceiling","floor"}}local function w(x,y,z,A)local B=v[z]if not B then return end;local C=rawget(y,z)local D=false;if type(B)=="table"then D=table.find(B,C)elseif B=='f/bool'then D=type(C)=="boolean"elseif B=='f/str'then D=type(C)=="string"elseif B=='f/table'then D=type(C)=="table"elseif not B then D=true elseif type(C)=="number"and C%1==0 or C==math.huge then local E,F=B:match("f/(%w*)%.%.(%w*)")D=C>=(x[E]or tonumber(E)or 0)and(F==''and C~=math.huge or C<=tonumber(F))end;if D then x[z]=C;return elseif C==nil then if type(A)=="string"and A:sub(1,7)=='error: 'then error(A:sub(8),4)end;x[z]=A;return end;error(z.." value is out of range.",4)end;local function G(H,I)local f={}if type(I)~="table"then I={}end;w(f,I,"groupSymbol",',')w(f,I,"decimalSymbol",'.')w(f,I,'useGrouping',H=="compact"and"min2"or"always")w(f,I,'style','decimal')if H=="compact"then w(f,I,'compactPattern',j)end;if f.style=="currency"then w(f,I,'currency','error: Currency is required with currency style')end;w(f,I,'rounding','halfEven')f.isSignificant=not not(rawget(I,'minimumSignificantDigits')or rawget(I,'maximumSignificantDigits'))if f.isSignificant then w(f,I,'minimumSignificantDigits',1)w(f,I,'maximumSignificantDigits')else w(f,I,'minimumIntegerDigits',1)w(f,I,'maximumIntegerDigits')w(f,I,'minimumFractionDigits')w(f,I,'maximumFractionDigits')if not(f.minimumFractionDigits or f.maximumFractionDigits)then if f.style=="percent"then f.minimumFractionDigits=0;f.maximumFractionDigits=0 elseif H~="compact"then f.minimumFractionDigits=0;f.maximumFractionDigits=3 end end end;return f end;local function J(K,L,M)local N,O=('0'..K):gsub('%.',''),(K:find('%.')or#K+1)+1;local P=O+L;if P>#N then return K:match("^(%d*)%.?(%d*)$")end;N=N:split('')local Q=M=='ceiling'if M~="ceiling"and M~="floor"then Q=N[P]:match((M=="halfEven"and(N[P-1]or'0'):match('[02468]')or M=="halfDown")and'[6-9]'or'[5-9]')end;for h=P,#N do N[h]=0 end;if Q then repeat if N[P]==10 then N[P]=0 end;P=P-1;N[P]=tonumber(N[P])+1 until N[P]~=10 end;return table.concat(N,'',1,O-1),table.concat(N,'',O)end;local function R(K,L)K=('0'):rep(-L)..K..('0'):rep(L)local S=K:gsub("[.,]",'')local T=#K;local U=(K:find("[.,]")or T+1)+L;return S:sub(1,U-1)..'.'..S:sub(U)end;local function V(K,o)K=K:gsub('%.','')return K:sub(1,o)..'.'..K:sub(o+1)end;local function W(K,X,Y,Z,_,M)local a0,a1;if _ and _~=math.huge then a0,a1=J(K,_,M)else a0,a1=K:match("^(%d*)%.?(%d*)$")end;a0=a0:gsub('^0+','')a1=a1:gsub('0+$','')local a2=#a0;local a3=#a1;if X and a2<X then a0=('0'):rep(X-a2)..a0 end;if Z and a3<Z then a1=a1 ..('0'):rep(Z-a3)end;if Y and a2>Y then a0=a0:sub(-Y)end;if a1==''then return a0 end;return a0 ..'.'..a1 end;local function a4(K,E,F,M)local a0,a1;if F and F~=math.huge then a0,a1=J(K,F-((K:find('%.')or#K+1)-1),M)else a0,a1=K:match("^(%d*)%.?(%d*)$")end;a0=a0:gsub('^0+','')a1=a1:gsub('0+$','')if E then E=math.max(E-#K:gsub('%.%d*$',''),0)if#a1<E then a1=a1 ..('0'):rep(E-#a1)end end;if a1==''then return a0 end;return a0 ..'.'..a1 end;local function a5(K)if not K:find('[eE]')then return K end;local a6,K,L=K:match('^([+%-]?)(%d*%.?%d*)[eE]([+%-]?%d+)$')if K then L=tonumber(L)if not L then return nil end;if K==''then return nil end;return a6 ..R(K,L)end;return nil end;local function a7(C,a8)local a9=typeof(C)if a9=="number"then C=('%.17f'):format(C)else C=tostring(C)C=a5(C)or C:lower()end;if a8 then C=R(C,a8)end;return C end;local function aa(H,...)if select('#',...)==0 then error("missing argument #1",3)end;local C,I=...I=G(H,I)C=a7(C,I.style=="percent"and 2)local a6,ab=C:match("^([+%-]?)(.+)$")local ac;if ab:match("^[%d.]*$")and select(2,ab:gsub('%.',''))<2 then local Z,_=I.minimumFractionDigits,I.maximumFractionDigits;if H=="compact"then ab=ab:gsub('^0+$','')local ad=#ab:gsub('%..*','')-3;if(I.compactPattern[math.min(ad,#I.compactPattern)]or'0')~='0'then local o;ac,o=l(I.compactPattern[math.min(ad,#I.compactPattern)])ab=V(ab,o+math.max(ad-#I.compactPattern,0))end;if not(Z or _)then _=#ab:gsub('%.%d*$','')<2 and 1 or 0 end end;if I.isSignificant then ab=a4(ab,I.minimumSignificantDigits,I.maximumSignificantDigits,I.rounding)else ab=W(ab,I.minimumIntegerDigits,I.maximumIntegerDigits,Z,_,I.rounding)end elseif ab=="inf"or ab=="infinity"then return a6=='-'and'-∞'or'∞'else return'NaN'end;a6=a6=='-'local f;local ae,a0,a1=ab:match("^(%d)(%d*)%.?(%d*)$")if I.useGrouping~="never"and#a0>(I.useGrouping=="min2"and 3 or 2)then a0=a0:reverse():gsub("%d%d%d","%1"..I.groupSymbol:reverse()):reverse()end;f=(a6 and'-'or'')..(I.currency and I.currency..(I.currency:match("%a$")and' 'or'')or'')..ae..a0 ..(a1==''and''or I.decimalSymbol..a1)..(I.style=="percent"and'%'or'')if ac then local af=table.find(ac,0)if af then ac[af]=f end;return table.concat(ac)end;return f end;function a.FormatCompact(...)return aa('compact',...)end
--split (ignore)
function split(s, delimiter) result = {}; for match in (s..delimiter):gmatch("(.-)"..delimiter) do table.insert(result, match); end return result end
--vars
local WS = game.Workspace
local RunService = game:GetService("RunService")
local Camera = WS.Camera
local _Flags = WS.Flags
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local ReplicatedStorage = game.ReplicatedStorage
local Eggs = ReplicatedStorage.Eggs
local Events = ReplicatedStorage.Events
local BuyAll = Events.BuyAll
if _G.loaded then
_G.SaberGUILoading = true
elseif _G.loaded == nil then
	--unlockislands
	for i,v in pairs(PlayerGui.Gui.Submenus.Portal.Frame.ScrollingFrame.Frame:GetChildren()) do
		if v:IsA("ImageLabel") then
		v.Teleport.Visible = true
		v.Unlock:Remove()
		end
	end
	PlayerGui.Gui.Home.MSG.Text = "Unlocking islands..."
	wait(0.5)
	PlayerGui.Gui.Home.MSG.Text = "Unlocked!"
	wait(0.2)
	PlayerGui.Gui.Home.MSG.Text = ""
local New_CFrame = CFrame.new(631, 258710, -167)
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local char = game.Players.LocalPlayer.Character

local part = char.HumanoidRootPart
local ti = TweenInfo.new(1, Enum.EasingStyle.Linear)
local tp = {CFrame = New_CFrame}

        ts:Create(part, ti, tp):Play()
		PlayerGui.Gui.Home.MSG.Text = "Saber Simulator Script its loading wait..."
wait(2)
PlayerGui.Gui.Home.MSG.Text = ""
local New_CFrame = CFrame.new(511.50579833984, 184.78834533691, 50.392555236816)
local tp = {CFrame = New_CFrame}
 ts:Create(part, ti, tp):Play()
_G.SaberGUILoading = false
end

if _G.SaberGUILoading == false then
_G.loaded = true
if _Flags:FindFirstChild("Flag") then
	IsVIP = false
else
	IsVIP = true
	PlayerGui.Gui.Home.MSG.Text = "VIP Server Detected!"
	wait(0.5)
	PlayerGui.Gui.Home.MSG.Text = " "
end

local SafeZonePos = CFrame.new(511.50579833984, 184.78834533691, 50.392555236816)
--important functions
function EquipTool()
	local Backpack = LocalPlayer.Backpack
	for i, v in pairs(Backpack:GetChildren()) do
		if v:IsA("Tool") and v.Name ~= "Phone" then
			LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
		end
	end
end
local function TP(X, Y, Z)
	LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(X, Y, Z)
end
local function TP3(X, Y, Z)
	local CurrentPos = LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
	TP(X, Y, Z)
	wait(0.5)
	TP(CurrentPos.X, CurrentPos.Y, CurrentPos.Z)
end
local function TPPart(P)
	TP(P.Position.X, P.Position.Y, P.Position.Z)
end
local function TPBypass(X, Y, Z)
	local Character = LocalPlayer.Character
	if Character:FindFirstChild("AntiPort") then
		Character:FindFirstChild("AntiPort").Disabled = true
	end
	if Character:FindFirstChild("AntiPortNew") then
		Character:FindFirstChild("AntiPortNew").Disabled = true
	end
	local NX = math.floor(X + 0.5)
	local NY = math.floor(Y + 0.5)
	local NZ = math.floor(Z + 0.5)
	local H = Character.Humanoid
	local HRP = Character.HumanoidRootPart
	local Teleporting = true
	while Teleporting do
		WS.Gravity = 0
		Teleporting = false
		if HRP.Position.X < NX - 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X + 1000, Pos.Y, Pos.Z)
			Teleporting = true
		elseif HRP.Position.X > NX + 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X - 1000, Pos.Y, Pos.Z)
			Teleporting = true
		end
		if HRP.Position.Y < NY - 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X, Pos.Y + 1000, Pos.Z)
			Teleporting = true
		elseif HRP.Position.Y > NY + 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X, Pos.Y - 1000, Pos.Z)
			Teleporting = true
		end
		if HRP.Position.Z < NZ - 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z + 1000)
			Teleporting = true
		elseif HRP.Position.Z > NZ + 1500 then
			local Pos = HRP.Position
			HRP.CFrame = CFrame.new(Pos.X, Pos.Y, Pos.Z - 1000)
			Teleporting = true
		end
		wait()
	end
	HRP.CFrame = CFrame.new(X, Y, Z)
	WS.Gravity = 196.2
end
local function TPBypassPart(P)
	TPBypass(P.Position.X, P.Position.Y, P.Position.Z)
end
local function SilentTP(X, Y, Z, Delay)
	LocalPlayer.Character.Archivable = true
	local Clone = LocalPlayer.Character:Clone()
	Clone.Name = "CharClone"
	Clone.Parent = WS
	local CamCFrame = Camera.CFrame
	local CurrentPosition = LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
	TP(X, Y, Z)
	Camera.CameraType = Enum.CameraType.Scriptable
	wait(Delay)
	TP(CurrentPosition.X, CurrentPosition.Y, CurrentPosition.Z)
	WS:FindFirstChild("CharClone"):Remove()
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CFrame = CamCFrame
end
local function HatchEgg(v, i)
	Events.HatchEggs:InvokeServer(Eggs[v], i)
end
local function EquipTool()	
end
local function waitrandom()
	return math.random(1, 10) / 1000
end
local library = loadstring(game:HttpGet("https://scripthandler.000webhostapp.com/ui.lua"))()
local xd = library:main()
local Auto = xd:section("Auto")
local AutoPet = xd:section("Auto Pet")
local Misc = xd:section("Misc")
local Stuff = xd:section("Stuff")
local Credits = xd:section("Credits")
Credits:addlabel("Scripting")
Credits:addlabel("Dollar | MEE3795#9019")
Credits:addlabel("HUNT#3014")
Credits:addlabel("Stuff Help [Stuff]")
Credits:addlabel("Dichill#7174")
Credits:addlabel("Naryxian#0001")
Credits:addlabel("Ping = Pong#8634")
Credits:addlabel("MisterLuuk#9536")
Credits:addlabel("Idea Help [Idea]")
Credits:addlabel("xMitchz#2416")
Credits:addlabel("Beta Testers")
Credits:addlabel("Drugs#6969")
Credits:addlabel("ur dad#9010")
Credits:addlabel("xMxttz#6522")
Credits:addlabel("LuKa#8011")
Credits:addlabel("Users: GUI Users <3")
local af;
local as;
--auto farm
Auto:addtoggle("Auto Strength", function(state)
	pcall(function()
		if state then
			af = RunService.Heartbeat:Connect(function()
				pcall(function ()
				EquipTool()
				Events.Clicked:FireServer()
				LocalPlayer.Character:FindFirstChildOfClass("Tool").RemoteClick:FireServer()
				wait(0.01)
				end)
			end)
		else
			af:Disconnect()
		end
	end)
end)
local CollectName = "None"
local ac
for i, v in pairs(WS.CandyHolder:GetChildren()) do
	if v:FindFirstChild("TouchInterest") then
		CollectName = v.Name
	end
end
if CollectName ~= "None" then
	Auto:addtoggle("Auto " .. CollectName, function(state)
		while true do
			if state then
			LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = WS.CandyHolder:WaitForChild(CollectName).CFrame
			    local oldCollectDistance = 99999
			    local oldCollect = nil
				for i, v in pairs(WS.CandyHolder:GetChildren()) do
					if v.Name == CollectName then
						if not _G["AutoCollect" .. CollectName] then
							return
						end
						LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.CFrame
						wait(0.1)
					end
				end
				if oldCollect == nil then
					if Character:FindFirstChild("AntiPort") then
						Character:FindFirstChild("AntiPort").Disabled = true
					end
					if Character:FindFirstChild("AntiPortNew") then
						Character:FindFirstChild("AntiPortNew").Disabled = true
					end
				    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = WS.CandyHolder:WaitForChild(CollectName).CFrame
				else
					while math.floor(LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.X) ~= math.floor(oldCollect.Position.X) and math.floor(LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.Z) ~= math.floor(oldCollect.Position.Z) do
						if not _G["AutoCollect" .. CollectName] then
							return
						end
						wait()
						LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.CFrame
						wait(0.1)
						for i = 1, 100 do
							H:ChangeState(11)
						end
					end
					wait(0.5)
				end
				wait(0.1)
		else
			wait(0.1)
		end
	end
	end)
end

local CollectName = "None"
for i, v in pairs(WS.GoldenEggsHolder:GetChildren()) do
	if v:FindFirstChild("TouchInterest") then
		CollectName = v.Name
	end
end

if CollectName ~= "None" then
	Auto:addtoggle("Auto " .. CollectName, function(state)
		if state then
			ac = RunService.Heartbeat:Connect(function()
				LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = WS.CandyHolder:WaitForChild(CollectName).CFrame
			    local oldCollectDistance = 99999
			    local oldCollect = nil
				for i, v in pairs(WS.GoldenEggsHolder:GetChildren()) do
					if v.Name == CollectName then
						if not _G["AutoCollect" .. CollectName] then
							return
						end
						local newCollectDistance = (LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position - v.Position).Magnitude
						if newCollectDistance > 3 and newCollectDistance < oldCollectDistance then
							oldCollectDistance = newCollectDistance
							oldCollect = v
						end
					end
				end
				if oldCollect == nil then
					if Character:FindFirstChild("AntiPort") then
						Character:FindFirstChild("AntiPort").Disabled = true
					end
					if Character:FindFirstChild("AntiPortNew") then
						Character:FindFirstChild("AntiPortNew").Disabled = true
					end
					LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = WS.GoldenEggsHolder:WaitForChild(CollectName).CFrame
				else
					while math.floor(LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.X) ~= math.floor(oldCollect.Position.X) and math.floor(LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position.Z) ~= math.floor(oldCollect.Position.Z) do
						if not _G["AutoCollect" .. CollectName] then
							return
						end
						wait()
						local H = LocalPlayer.Character:WaitForChild("Humanoid")
						H:MoveTo(tostring(oldCollect.CFrame))
						for i = 1, 100 do
							H:ChangeState(11)
						end
					end
					wait(0.5)
				end
				wait()
			end)
		else
			ac:Disconnect()
		end
	end)
end
local as1
Auto:addtoggle("Auto Sell", function(state)
	if state then
		as1 = RunService.Heartbeat:Connect(function()
			if PlayerGui:FindFirstChild("Gui") then
				Sand = PlayerGui.Gui.Home.Sand.Amount.Text
				CurrentSand = split(Sand, " / ")[1]
				MaxSand = split(Sand, " / ")[2]
					TP3(532.80011, 183.835846, 151.486023)
					wait(0.5)
					TP(SafeZonePos.X or 511.50579833984, SafeZonePos.Y or 184.78834533691, SafeZonePos.Z or 50.392555236816)
					wait(0.5)
			end
		end)
	else
		as1:Disconnect()
	end
end)
local Home = PlayerGui.Gui.Home
local DailyRewardInfo = Home.DailyRewardInfo
local MSG = Home.MSG
local function ShowMSG2(msg, duration)
	PlayerGui.Gui.Home.MSG.Text = msg
	wait(duration)
	PlayerGui.Gui.Home.MSG.Text = ""
end
local abcdfg
Auto:addtoggle("Auto Boss", function(state)
	abcdfg = state
	if abcdfg then
		while wait(0.25) do
			if abcdfg then
				if not IsVIP then
					if game:GetService("Workspace"):FindFirstChild("Boss") then
						LocalPlayer.Character.Humanoid:MoveTo(game:GetService("Workspace").Boss.HumanoidRootPart.Position)
					else
						LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(SafeZonePos.X or 511.50579833984, SafeZonePos.Y or 184.78834533691, SafeZonePos.Z or 50.392555236816))
					end
				else
					if game:GetService("Workspace"):FindFirstChild("Boss") then
						TPPart(game:GetService("Workspace").Boss.HumanoidRootPart)
					else
						TP(SafeZonePos.X or 511.50579833984, SafeZonePos.Y or 184.78834533691, SafeZonePos.Z or 50.392555236816)
					end
				end
			else break end
		end
	else wait(0.1) end
end)

Auto:addbutton("Set SafeZone Pos", function()
	SafeZonePos = LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
end)

Auto:addlabel("AutoBuy")
local abs
Auto:addtoggle("Saber", function(state)
	if state then
		abs = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("Swords")
			wait(waitrandom())
		end)
	else abs:Disconnect() end
end)
local abd
Auto:addtoggle("DNA", function(state)
	if state then
		abd = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("Backpacks")
			wait(waitrandom())
		end)
	else
		abd:Disconnect()
	end
end)
local abj
Auto:addtoggle("Jumps", function(state)
	if state then
		abj = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("JumpBoosts")
			wait(waitrandom())
		end)
	else
		abj:Disconnect()
	end
end)
local abbh
Auto:addtoggle("Boss Hit", function(state)
	if state then
		abbh = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("BossBoosts")
			wait(waitrandom())
		end)
	else abbh:Disconnect() end 
end)
local aba
Auto:addtoggle("Aura", function(state)
	if state then
		aba = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("Auras")
			wait(waitrandom())
		end)
	else aba:Disconnect() end
end)
local abpa
Auto:addtoggle("Pet Aura", function(state)
	if state then
		abpa = RunService.Heartbeat:Connect(function()
			BuyAll:FireServer("PetAuras")
			wait(waitrandom())
		end)
	else abpa:Disconnect() end
end)
local abc
Auto:addtoggle("Class", function(state)
	if state then
		abc = RunService.Heartbeat:Connect(function()
			for i, v in pairs(ReplicatedStorage.ShopItems.Classes:GetChildren()) do
				Events.BuyItem:FireServer(v)
				wait(waitrandom())
			end
			wait(waitrandom())
		end)
	else abc:Disconnect() end
end)

Auto:addtoggle("Auto Kill Plrs", function(state)
	st = state
	while wait(0.1) do
		if st then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v ~= LocalPlayer then
					if v.Character:FindFirstChild("Head") then
						if not v.Character.Head.RankingGui.Safe.Visible then
							while v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 do
								if not AutoKill then
									return
								end
								if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not v.Character.Head.RankingGui.Safe.Visible then
									LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 7)
								end
								wait(waitrandom())
							end
						end
					end
				end
			end
			wait(waitrandom())
		else wait(0.1) end end
end)
AutoPet:addlabel("Island TP (finally added!)")
local ises = {}
local islands = game:GetService("ReplicatedStorage").IslandCF
for mu,me in pairs(game.ReplicatedStorage.IslandCF:GetChildren()) do
table.insert(ises, me.Name)
end
AutoPet:adddropdown("Choose the island:", ises, function(text)
	LocalPlayer.Character.HumanoidRootPart.CFrame = islands[text].Value
	end)
AutoPet:addlabel("Eggs")
AutoPet:addlabel("For 3x Hatch you need the gamepass!")
--Tables and splitting
local gga = {}
for i, v in pairs(Eggs:GetChildren()) do
	table.insert(gga, v.Name)
end
local legay;
--Primary group of eggs
AutoPet:adddropdown("Choose the egg", gga, function(text)
	print(text)
legay = Eggs[tostring(text)]
PlayerGui.Gui.Home.MSG.Text = "Egg Price: "..a.FormatCompact(legay.Price.Value);
wait(5)
PlayerGui.Gui.Home.MSG.Text = " "
end)
--End of doing shit to eggs
AutoPet:addtoggle("Auto Hatch x1",function(hatch)
ha = hatch
while wait() do
if ha == true then
	
local userdata_1 = Eggs[tostring(legay)]
local number_1 = 1;
local Target = game:GetService("ReplicatedStorage").Events.HatchEggs;
Target:InvokeServer(userdata_1, number_1);
else repeat wait() until ha == true end
wait(0.1)
end
end)
AutoPet:addtoggle("Auto Hatch x3",function(hatch1)
ha = hatch1
while wait() do
if ha == true then
	
local userdata_1 = Eggs[tostring(legay)]
local number_1 = 3;
local Target = game:GetService("ReplicatedStorage").Events.HatchEggs;
Target:InvokeServer(userdata_1, number_1);
else repeat wait() until ha == true end
wait(0.1)
end
end)

AutoPet:addtoggle("Auto Craft", function(state)
	st = state
	if st then
		local AutoCraft = true
		while AutoCraft do
			Events.CombineAll:FireServer()
			wait(10)
		end
	else
		AutoCraft = false
	end
end)

AutoPet:addlabel("AutoDelete")
for i = 1, 7 do
	if i == 1 then
		Color = "Gray"
	elseif i == 2 then
		Color = "Green"
	elseif i == 3 then
		Color = "Blue"
	elseif i == 4 then
		Color = "Purple"
	elseif i == 5 then
		Color = "Orange"
	elseif i == 6 then
		Color = "Moon"
	elseif i == 7 then
		Color = "Double Moon"
	end
	AutoPet:addtoggle(Color, function(state)
		st = state
		while wait(0.1) do
		if st then
				if PlayerGui:FindFirstChild("Gui") then
					for n, v in pairs(PlayerGui.Gui.Submenus.PetsInventory.PetsFrame.Frame:GetChildren()) do
						if v.Name ~= "UIGridLayout" then
							if _G.AutoDeleteIgnoreGolden and v.Golden.Visible then
							elseif _G.AutoDeleteIgnoreShiny and v.Shiny.Visible then
							elseif _G.AutoDeleteIgnoreRainbow and v.Rainbow.Visible then
							elseif _G.AutoDeleteIgnoreVoid and v.Void.Visible then
							elseif _G.AutoDeleteIgnoreEquipped and v.Equipped.Visible then
							else
								for _, x in pairs(ReplicatedStorage.Pets:GetChildren()) do
									if v:FindFirstChild("IMG") then
										if x.Name == v.IMG:GetChildren()[1].Name then
											if x.Rarity.Value == i then
												Events.PetCommand:FireServer(v.Name, "Delete")
											end
										end
									end
								end
							end
						end
						wait(waitrandom())
					end
				end
				wait(waitrandom())
			else wait(0.1) end end
	end)
end

AutoPet:addlabel("IgnoreRarity")

AutoPet:addtoggle("Golden", function(state)
	st = state
	if st then
		_G.AutoDeleteIgnoreGolden = true
	else
		_G.AutoDeleteIgnoreGolden = false
	end
end)

AutoPet:addtoggle("Shiny", function(state)
	st = state
	if st then
		_G.AutoDeleteIgnoreShiny = true
	else
		_G.AutoDeleteIgnoreShiny = false
	end
end)

AutoPet:addtoggle("Rainbow", function(state)
	st = state
	if st then
		_G.AutoDeleteIgnoreRainbow = true
	else
		_G.AutoDeleteIgnoreRainbow = false
	end
end)

AutoPet:addtoggle("Void", function(state)
	st = state
	if st then
		_G.AutoDeleteIgnoreVoid = true
	else
		_G.AutoDeleteIgnoreVoid = false
	end
end)

AutoPet:addtoggle("Equipped", function(state)
	st = state
	if st then
		_G.AutoDeleteIgnoreEquipped = true
	else
		_G.AutoDeleteIgnoreEquipped = false
	end
end)
AutoPet:addlabel("Note: Turn On Ur Pets Inventory To")
AutoPet:addlabel("Use Auto Delete Faster, Ignore Equipped")
AutoPet:addlabel("Can till Delete Ur Pets For About")
AutoPet:addlabel("10 Seconds After U Die! :O")

Misc:addtoggle("Auto Flag", function(state)
	st = state
	if st then
		local AutoFlag = st
		while AutoFlag do
			local CurrentPos = LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position
			for i, v in pairs(_Flags:GetChildren()) do
				LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = v.Base.CFrame
				if v.OwnerValue.Value ~= LocalPlayer.Name then
					wait(15 + v.CapValue.Value)
				else
					wait(12 - v.CapValue.Value)
				end
				if not AutoFlag then
					return
				end
			end
			TP(CurrentPos.X, CurrentPos.Y, CurrentPos.Z)
			wait(waitrandom())
		end
	else
		local AutoFlag = false
	end
end)

local Drops = {}
for i, v in pairs(_Flags:GetChildren()) do
	table.insert(Drops, "Flag" .. tostring(i))
end
Misc:adddropdown("TP To Flag", Drops, function(text)
	for i, v in pairs(_Flags:GetChildren()) do
		if tostring(i) == text:gsub("Flag", "") then
			local BasePos = v.Base.Position
			TP(BasePos.X, BasePos.Y, BasePos.Z)
		end
	end
end)
local omfg
Misc:addtoggle("Better Island TP Gui", function (state)
	omfg = state
	if omfg then
		while wait(0.5) do
			pcall(function ()
				local ui = game:GetService("Players").LocalPlayer.PlayerGui.Gui.Submenus.Portal.Frame.ScrollingFrame.Frame.UIGridLayout
				ui.CellSize = UDim2.new(0,75,0,75)
				ui.CellPadding = UDim2.new(0,0,0,0)
			end)
		end
	else wait(0.1) end
end)

Stuff:addbutton("Hill", function()
	TPBypass(791.358, 252.105, 32.121)
end)

Stuff:addbutton("Sell", function()
	TP3(532.80011, 183.835846, 151.486023)
end)

Stuff:addbutton("Unlock Islands", function()
	for i, v in pairs(Eggs:GetChildren()) do
		for _, x in pairs(WS:GetChildren()) do
			if x:FindFirstChild("SignPart") then
				if x.SignPart.EggName.Value == v.Name then
					TPBypassPart(x.SignPart)
					wait(waitrandom() * 100)
				end
			end
		end
	end
end)

Stuff:addbutton("Shop", function()
	local Shop = PlayerGui.Gui.Submenus.Shop
	Shop.Visible = true
	Shop.Position = UDim2.new(.5, 0, .5, 0)
end)

Stuff:addbutton("Crown Shop", function()
	local CrownShop = PlayerGui.Gui.Submenus.CrownShop
	CrownShop.Visible = true
	CrownShop.Position = UDim2.new(.5, 0, .5, 0)
end)

Stuff:addbutton("Skill Shop", function()
	local SkillShop = PlayerGui.Gui.Submenus.SkillShop
	SkillShop.Visible = true
	SkillShop.Position = UDim2.new(.5, 0, .5, 0)
end)
--[[ My UI lib doesn't have boxes rn, just ignore walkspeed and jumppower
Stuff:Box("WalkSpeed", function(object)
	_G.WS = tonumber(object) or 16
	while wait() do
		LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = _G.WS
	end
end)

Stuff:Box("JumpPower", function(object)
	_G.JP = tonumber(object) or 60
	while wait() do
		LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = _G.JP
		wait()
	end
end)]]--
Stuff:addtoggle("No Name (Client sidded)", function(state)
	st = state
	while wait(0.5) do
		if st then
			if LocalPlayer.Character:FindFirstChild("Head") then
				local Head = LocalPlayer.Character.Head
				if Head:FindFirstChild("RankingGui") then
					local RankingGui = Head.RankingGui
					if RankingGui:FindFirstChild("PName") then
						RankingGui.PName:Remove()
					end
					if RankingGui:FindFirstChild("Tag1") then
						RankingGui.Tag1:Remove()
					end
					if RankingGui:FindFirstChild("Tag2") then
						RankingGui.Tag2:Remove()
					end
				end
			end
			wait(2)
		end
	end
end)
else
PlayerGui.Gui.Home.MSG.Text = "Script Already Loaded!"
wait(3)
PlayerGui.Gui.Home.MSG.Text = " "
end
