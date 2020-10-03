plrh = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
plrh.CFrame = CFrame.new(247.587051, 63695, -515.850525)
   noclip = false
local library = loadstring(game:HttpGet("https://pastebin.com/raw/fLX8A5hY"))();
-- Farming Tab
local farm = library:CreateSection("Farming");
--AutThrow
farm:Toggle("Auto Throw",function(throw)
throw1 = throw;
while wait(0.01) do
if throw1 == true then
local A_1 = "Throw"
local A_2 = Vector3.new(10, -9000,10)
local Event = game:GetService("ReplicatedStorage").RE
Event:FireServer(A_1, A_2)
else
repeat
wait(1)
until throw1 == true
end
end	
end)
--Auto Buy Blade
farm:Toggle("Auto Buy Blade",function(blade)
blade1 = blade;
while wait(0.01) do
if blade1 == true then
local A_1 = "BuyBlade"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
else
repeat
wait(1)
until blade1 == true
end	
end
end)

--Auto Buy Energy
farm:Toggle("Auto Buy Energy",function(energy)
energy1 = energy;
while wait(0.01) do
if energy1 == true then
local A_1 = "BuyEnergy"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
else
repeat
wait(1)
until energy1 == true
end
end	
end)

--Auto Buy Ranks
farm:Toggle("Auto Buy Ranks",function(rank)
rank1 = rank;
while wait(0.01) do
if rank1 == true then
local A_1 = "BuyRank"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
else
repeat
wait(1)
until rank1 == true
end	
end
end)
--Auto Buy Auras
farm:Toggle("Auto Buy Auras",function(au)
aur = au;
while wait(0.01) do
if aur == true then
local A_1 = "BuyAura"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
else
repeat
wait(1)
until aur == true
end	
end
end)
--Auto Sell
farm:Toggle("Auto Sell",function(sell)
sell1 = sell;
while wait(0.01) do
if sell1  == true then

game.Workspace.Ignore.Rings["24Sell"].CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
wait(0.1)
game.Workspace.Ignore.Rings["24Sell"].Collider.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
wait(0.1)
game.Workspace.Ignore.Rings["24Sell"].Collider.Transparency = 1
wait(0.1)
game.Workspace.Ignore.Rings["24Sell"].CFrame = CFrame.new(1,1,1)
wait(0.1)
game.Workspace.Ignore.Rings["24Sell"].Transparency = 1
wait(0.1)
game.Workspace.Ignore.Rings["24Sell"].Collider.CFrame = CFrame.new(1,1,1)
else
repeat
wait(1)
until sell1 == true
end
end
end)
---xd?

--Auto Boss
local bossfarm = farm:Toggle("Auto Boss",function(aboss)

boss = aboss;
local RunService = game:GetService("RunService")
 
RunService.RenderStepped:Connect(function()

if boss == true then
noclip = true
if game.Workspace:WaitForChild("Boss").DataCost > 10 then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
for i,v in pairs(game.Workspace.Boss:GetChildren()) do
plrh.CFrame = CFrame.new(164, -106, -761) 

local A_1 = "HitBoss"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RE
Event:FireServer(A_1, A_2)
wait(5)
plrh.CFrame = CFrame.new(183.077545, 63699, -776.550476)

local A_1 = "HitBoss"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RE
Event:FireServer(A_1, A_2)
wait(5)
end
wait(5)
end
wait(5)
end
else repeat  noclip = false wait()  until boss == true 
wait(5)
end
wait(5)
end)
wait(5)
end)

--Auto KOTH
farm:Toggle("Auto KOTH",function(koth)
koth1 = koth;
while wait(0.01) do
if koth1 == true then
noclip = true
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
if boss then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Workspace.Boss.DataCost == 4 then
plrh.CFrame = loler.CFrame

wait(10)
else 
repeat 
wait(10) 
until game.Workspace.Boss.DataCost == 4
end
else
plrh.CFrame = loler.CFrame
end
end
else
repeat
noclip = false
wait(1)
until koth1 == true

end
end
end)
--kothfixer
farm:Button("Fix KOTH", function()
while wait() do
game.Workspace["_MapUpdated"].MeshPart:Destroy()
end
end)
--Pets Tab
local pets = library:CreateSection("Pets")
local Eggs = {}
for i,v in next, game.workspace.Eggs:GetChildren() do 
if v then 
table.insert(Eggs,v.Name)
end
end

--Select and open
pets:Dropdown("Select Egg", Eggs,function(open)
onegg = open;
end)

pets:Toggle("Open Eggs",function(hatcher)
hatcher1 = false
hatcher1 = hatcher;
while wait(0.01) do
if hatcher1 == true then
local A_1 = "BuyEgg"
local A_2 = onegg
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
else
repeat
wait(1)
until hatcher1 == true
end
end
end)
--autoevolve
pets:Toggle("Auto Evolve",function(oml)
ae = oml;
while wait() do
if ae == true then

local A_1 = "EvolveAll"
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1)

else
repeat
wait(1)
until ae == true
end
end
end)

pets:Toggle("Auto Equip Best Pet",function(eb)
ebola = eb;
while wait() do
if ebola==true then
local A_1 = "EquipBest"
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1)
else
repeat
wait(1)
until ae == true
end
end
end)
--pet sell
--sell all Dark CR
pets:Toggle("Sell All Dark Crystal Rocket ",function(LCR)
ce1 = LCR;
if ce1 == true then
while wait() do
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
for i,v in pairs(game:GetService("Players").LocalPlayer.Data.Pets:GetChildren()) do

if v.Tag.Value == "Dark Crystal Rocket" then
while wait() do
local A_1 = "Sell"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
wait(0.2)
  end
end
else
repeat
wait(1)
until ce1 == true
end
end)
--Sell Light CR
pets:Toggle("Sell All Light Crystal Rocket ",function(LCR1)
ce2 = LCR1;
if ce2 == true then
while wait() do
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
for i,v in pairs(game:GetService("Players").LocalPlayer.Data.Pets:GetChildren()) do

if v.Tag.Value == "Light Crystal Rocket" then
while wait() do
local A_1 = "Sell"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
wait(0.2)
  end
end
else
repeat
wait(1)
until ce2 == true
end
end)
--sell Light SA
pets:Toggle("Sell All Light Spectral Assasin ",function(LCR2)
ce3 = LCR2;
if ce3 == true then
while wait() do
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
for i,v in pairs(game:GetService("Players").LocalPlayer.Data.Pets:GetChildren()) do

if v.Tag.Value == "Light Spectral Assasin" then
while wait() do
local A_1 = "Sell"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
wait(0.2)
  end
end
else
repeat
wait(1)
until ce3 == true
end
end)
--sell Dark SA
pets:Toggle("Sell All Dark Spectral Assasin ",function(LCR3)
ce4 = LCR3;
if ce4 == true then
while wait() do
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
for i,v in pairs(game:GetService("Players").LocalPlayer.Data.Pets:GetChildren()) do

if v.Tag.Value == "Dark Spectral Assasin" then
while wait() do
local A_1 = "Sell"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
wait(0.2)
end
end
else
repeat
wait(1)
until ce4 == true
end
end)
--sell Light SD
pets:Toggle("Sell All Light Spectral Dragon ",function(LCR4)
ce5 = LCR4;
if ce5 == true then
while wait() do
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
for i,v in pairs(game:GetService("Players").LocalPlayer.Data.Pets:GetChildren()) do

if v.Tag.Value == "Light Spectral Dragon" then
while wait() do
local A_1 = "Sell"
local A_2 = v
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
wait(0.2)
  end
end
else
repeat
wait(1)
until ce5 == true
end
end)
--Misc Tab
local misc = library:CreateSection("Misc")
misc:Button("Go to Shop", function()
plrh.CFrame = CFrame.new(187.355484, 63696.7148, -419.702698)
end)
--Infi jump
misc:Button("Infinite Jump",function()
   game.Players.LocalPlayer.Data.GP.InfiniteJump.Value = true
end)
--x2Speed
misc:Button("x2 Speed", function()
   game.Players.LocalPlayer.Data.GP.DoubleSpeed.Value = true
end)
--Get Chestssss
misc:Button("Collect Chests", function()
--Spawn chest
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(38.5474701, -95, -591.230103)
   wait(5)
--Moon chest   
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(173.011108, 629, -678.114197)
   wait(5)
--Aqua chest
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(209.454514, 3400, -540)
   wait(5)
--Volcano chest
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(132.928162, 8560, -411.53476)
   wait(5)
--Winter chest
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(121.336937, 11510.5479, -330.531128)
   wait(5)
--Cyber chest
   game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(188.137512, 13547.4336, -335.257599)
   wait(5)

end)

--removefullbag
misc:Button("Remove Full Bag", function()
   game.Players.LocalPlayer.PlayerGui.UI.Full:Destroy()
end)

game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)

misc:Button("Remove NameTag", function()
game.Players.LocalPlayer.Character.Head.Info:Remove()
end)

game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
end
end)
misc:Toggle("Auto Spin to win",function(spin)
s2w = spin;
while wait() do
if s2w==true then
local A_1 = "Wheel"
local A_2 = "Wheel1"
local Event = game:GetService("ReplicatedStorage").RF
Event:InvokeServer(A_1, A_2)
end
end
end)
--remove robux purchases
misc:Toggle('Remove Robux Purchases', function(kidrbx)
kid = kidrbx;
if kid == true then
game.CoreGui.RobloxPromptGui.Enabled = False
game.CoreGui.PurchasePromptApp.Enabled = False
else
 game.CoreGui.RobloxPromptGui.Enabled = True
game.CoreGui.PurchasePromptApp.Enabled = True
end
end)
--ctrl to hide

game:GetService('Players').PlayerAdded:connect(function(player)
    player.CharacterAdded:connect(function(character)
        character:WaitForChild("Humanoid").Died:connect(function()
while wait(0.01) do
if boss == true then
noclip = true
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Workspace:WaitForChild("Boss").DataCost > 1250 then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
local lg = game.Workspace.Boss:WaitForChild("Lava Golem")
plrh.CFrame = CFrame.new(0,34,0)*lg:WaitForChild("Torso").CFrame
end 
end
if game.Workspace.Boss.DataCost <1249 then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
for i,v in pairs(game:GetService("Workspace").Boss:GetChildren()) do
plrh.CFrame = CFrame.new(0,34,0)*v:WaitForChild("Torso").CFrame
wait(0.1)
end
end
end
end
else repeat wait() until boss == ture noclip = false
end
end
			wait()
			while wait(0.01) do
if koth1 == true then
noclip = true
local plrh = game.Players.LocalPlayer.Character.HumanoidRootPart
if boss then
if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") then
if game.Workspace.Boss.DataCost == 4 then
plrh.CFrame = loler.CFrame

wait(10)
else 
repeat 
wait(10) 
until game.Workspace.Boss.DataCost == 4
end
else
plrh.CFrame = loler.CFrame
end
end
else
repeat
wait(1)
until koth1 == true
noclip = false
end
end
        end)
    end)
end)


game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Credits", Text = "This script was made by AnonymousErrors#0404", Duration = 45 })
library:Ready();
--blah blah
local library = loadstring(game:HttpGet("https://pastebin.com/raw/JsdM2jiP",true))()
library.options.underlinecolor = "rainbow"

local Pets = library:CreateWindow("Perk hacks")
Pets:Section("this will change")
Pets:Section("only first perk")
local Settings = {}
local Perks = {}
for i,v in pairs(game.Players.LocalPlayer.Data.Perks:GetChildren()) do
if v then 
table.insert(Perks,v.Name)
end
end
Pets:Dropdown('Perks', {location = Settings, flag = "Perk", list = Perks})
local cperk = Pets:Button("Change perk!", function()
print(Settings.Perk)
local hperk = game.ReplicatedStorage.Perks:FindFirstChild("1")
hperk.Value = tostring(Settings.Perk)
end)


wait(1)

loler = Instance.new("Part", workspace)

loler.Anchored = true

loler.Size = Vector3.new(30,3,30)

loler.CFrame = CFrame.new(-316.118164, -25, -453)

loler.CanCollide = true

loler.Velocity = Vector3.new(0,0,0)

loler.Orientation = Vector3.new(0,0,0)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
