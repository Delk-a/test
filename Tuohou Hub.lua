local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
--------------------------------------------------------------------------------------------------------------------------------------------
local Window = Fluent:CreateWindow({
    --Phần Tên
    --Touhou Hub :>
    Title = "Touhou Hub",
    SubTitle = "Version 1.0.0
",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 350),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End -- Used when theres no MinimizeKeybind
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Setting = Window:AddTab({ Title = "Setting Farming", Icon = "settings" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "plus-circle" }),
    Player = Window:AddTab({ Title = "Player", Icon = "baby" }),
    Teleport = Window:AddTab({ Title = "Travel", Icon = "palmtree" }),
    Fruit = Window:AddTab({ Title = "Devil Fruit", Icon = "cherry" }),
    Raid = Window:AddTab({ Title = "Raid", Icon = "swords" }),
    Race = Window:AddTab({ Title = "Race V4", Icon = "chevrons-right" }),
    Shop = Window:AddTab({ Title = "Buy Items", Icon = "shopping-cart" }),
	Misc = Window:AddTab({ Title = "Miscellaneous", Icon = "list-plus" }),
    Hop = Window:AddTab({ Title = "Hop", Icon = "wifi" }),
}
local Options = Fluent.Options
do
--------------------------------------------------------------------------------------------------------------------------------------------
function AntiBan()
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    
    local character = player.Character
    local playerScripts = player.PlayerScripts
    
    -- Xóa LocalScripts trong Character
    for _, script in pairs(character:GetDescendants()) do
        if script:IsA("LocalScript") then
            local scriptsToRemove = {
                "General", "Shiftlock", "FallDamage", "4444", 
                "CamBob", "JumpCD", "Looking", "Run"
            }
            
            if table.find(scriptsToRemove, script.Name) then
                pcall(function() script:Destroy() end)
            end
        end
    end
    
    -- Xóa LocalScripts trong PlayerScripts
    for _, script in pairs(playerScripts:GetDescendants()) do
        if script:IsA("LocalScript") then
            local scriptsToRemove = {
                "RobloxMotor6DBugFix", "Clans", "Codes", 
                "CustomForceField", "MenuBloodSp", "PlayerList"
            }
            
            if table.find(scriptsToRemove, script.Name) then
                pcall(function() script:Destroy() end)
            end
        end
    end
end

-- Gọi hàm AntiBan
task.spawn(AntiBan)
--------------------------------------------------------------------------------------------------------------------------------------------
local function WaitForCondition(condition, timeout)
    local startTime = tick()
    while not condition() do
        if timeout and tick() - startTime > timeout then
            warn("Condition wait timed out")
            return false
        end
        task.wait()
    end
    return true
end

local function AutoSelectTeam()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local MainGui = PlayerGui:WaitForChild("Main")
    
    -- Kiểm tra giao diện chọn team
    local chooseTeamFrame = MainGui:FindFirstChild("ChooseTeam")
    if not chooseTeamFrame then return false end
    
    -- Xác định team mặc định
    local teamToSelect = _G.Team or "Pirates"
    teamToSelect = teamToSelect:lower()
    
    -- Bảng ánh xạ team
    local teamSelectors = {
        ["pirate"] = MainGui.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton,
        ["marine"] = MainGui.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton
    }
    
    -- Chọn team
    local selectedTeamButton = teamSelectors[teamToSelect] or teamSelectors["pirate"]
    
    -- Kích hoạt nút chọn team
    local connections = getconnections(selectedTeamButton.Activated)
    for _, connection in ipairs(connections) do
        pcall(connection.Function)
    end
    
    return true
end

local function GameLoader()
    -- Đợi các dịch vụ và điều kiện cần thiết
    local conditions = {
        function() return game.Players ~= nil end,
        function() return game.Players.LocalPlayer ~= nil end,
        function() return game.ReplicatedStorage ~= nil end,
        function() return game.ReplicatedStorage:FindFirstChild("Remotes") ~= nil end,
        function() return game.Players.LocalPlayer:FindFirstChild("PlayerGui") ~= nil end,
        function() return game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main") ~= nil end,
        function() return game:GetService("Players").LocalPlayer.Character:FindFirstChild("Energy") ~= nil end
    }
    
    -- Kiểm tra từng điều kiện
    for _, condition in ipairs(conditions) do
        WaitForCondition(condition, 30)  -- Timeout 30 giây
    end
    
    -- Đảm bảo game đã load hoàn toàn
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    -- Chọn team nếu cần
    local teamFrame = game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam")
    if teamFrame and teamFrame.Visible then
        WaitForCondition(function() 
            return AutoSelectTeam() or 
                   game.Players.LocalPlayer.Team ~= nil 
        end, 15)
    end
end

-- Chạy hàm loader
task.spawn(GameLoader)
      
------// BLOX FRUIT
--// Sea world
First_Sea = false
Second_Sea = false
Third_Sea = false
local placeId = game.PlaceId
if placeId == 2753915549 then
First_Sea = true
elseif placeId == 4442272183 then
Second_Sea = true
elseif placeId == 7449423635 then
Third_Sea = true
end

--// Check Quest
function CheckLevel()
local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
if First_Sea then
if Lv == 1 or Lv <= 9 or SelectMonster == "Bandit" or SelectArea == '' then -- Bandit
Ms = "Bandit"
NameQuest = "BanditQuest1"
QuestLv = 1
NameMon = "Bandit"
CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey" or SelectArea == 'Jungle' then -- Monkey
Ms = "Monkey"
NameQuest = "JungleQuest"
QuestLv = 1
NameMon = "Monkey"
CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla" or SelectArea == 'Jungle' then -- Gorilla
Ms = "Gorilla"
NameQuest = "JungleQuest"
QuestLv = 2
NameMon = "Gorilla"
CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate" or SelectArea == 'Buggy' then -- Pirate
Ms = "Pirate"
NameQuest = "BuggyQuest1"
QuestLv = 1
NameMon = "Pirate"
CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute" or SelectArea == 'Buggy' then -- Brute
Ms = "Brute"
NameQuest = "BuggyQuest1"
QuestLv = 2
NameMon = "Brute"
CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit" or SelectArea == 'Desert' then -- Desert Bandit
Ms = "Desert Bandit"
NameQuest = "DesertQuest"
QuestLv = 1
NameMon = "Desert Bandit"
CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer" or SelectArea == 'Desert' then -- Desert Officer
Ms = "Desert Officer"
NameQuest = "DesertQuest"
QuestLv = 2
NameMon = "Desert Officer"
CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit" or SelectArea == 'Snow' then -- Snow Bandit
Ms = "Snow Bandit"
NameQuest = "SnowQuest"
QuestLv = 1
NameMon = "Snow Bandit"
CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman" or SelectArea == 'Snow' then -- Snowman
Ms = "Snowman"
NameQuest = "SnowQuest"
QuestLv = 2
NameMon = "Snowman"
CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer" or SelectArea == 'Marine' then -- Chief Petty Officer
Ms = "Chief Petty Officer"
NameQuest = "MarineQuest2"
QuestLv = 1
NameMon = "Chief Petty Officer"
CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit" or SelectArea == 'Sky' then -- Sky Bandit
Ms = "Sky Bandit"
NameQuest = "SkyQuest"
QuestLv = 1
NameMon = "Sky Bandit"
CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
elseif Lv == 175 or Lv <= 189 or SelectMonster == "Dark Master" or SelectArea == 'Sky' then -- Dark Master
Ms = "Dark Master"
NameQuest = "SkyQuest"
QuestLv = 2
NameMon = "Dark Master"
CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
elseif Lv == 190 or Lv <= 209 or SelectMonster == "Prisoner" or SelectArea == 'Prison' then -- Prisoner
Ms = "Prisoner"
NameQuest = "PrisonerQuest"
QuestLv = 1
NameMon = "Prisoner"
CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, -0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)
elseif Lv == 210 or Lv <= 249 or SelectMonster == "Dangerous Prisoner" or SelectArea == 'Prison' then -- Dangerous Prisoner
Ms = "Dangerous Prisoner"
NameQuest = "PrisonerQuest"
QuestLv = 2
NameMon = "Dangerous Prisoner"
CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, -0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)
elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior" or SelectArea == 'Colosseum' then -- Toga Warrior
Ms = "Toga Warrior"
NameQuest = "ColosseumQuest"
QuestLv = 1
NameMon = "Toga Warrior"
CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator" or SelectArea == 'Colosseum' then -- Gladiator
Ms = "Gladiator"
NameQuest = "ColosseumQuest"
QuestLv = 2
NameMon = "Gladiator"
CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
elseif Lv == 300 or Lv <= 324 or SelectMonster == "Military Soldier" or SelectArea == 'Magma' then -- Military Soldier
Ms = "Military Soldier"
NameQuest = "MagmaQuest"
QuestLv = 1
NameMon = "Military Soldier"
CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
elseif Lv == 325 or Lv <= 374 or SelectMonster == "Military Spy" or SelectArea == 'Magma' then -- Military Spy
Ms = "Military Spy"
NameQuest = "MagmaQuest"
QuestLv = 2
NameMon = "Military Spy"
CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior" or SelectArea == 'Fishman' then -- Fishman Warrior
Ms = "Fishman Warrior"
NameQuest = "FishmanQuest"
QuestLv = 1
NameMon = "Fishman Warrior"
CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
end
elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando" or SelectArea == 'Fishman' then -- Fishman Commando
Ms = "Fishman Commando"
NameQuest = "FishmanQuest"
QuestLv = 2
NameMon = "Fishman Commando"
CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
end
elseif Lv == 10 or Lv <= 474 or SelectMonster == "God's Guard" or SelectArea == 'Sky Island' then -- God's Guard
Ms = "God's Guard"
NameQuest = "SkyExp1Quest"
QuestLv = 1
NameMon = "God's Guard"
CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
end
elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda" or SelectArea == 'Sky Island' then -- Shanda
Ms = "Shanda"
NameQuest = "SkyExp1Quest"
QuestLv = 2
NameMon = "Shanda"
CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
end
elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad" or SelectArea == 'Sky Island' then -- Royal Squad
Ms = "Royal Squad"
NameQuest = "SkyExp2Quest"
QuestLv = 1
NameMon = "Royal Squad"
CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier" or SelectArea == 'Sky Island' then -- Royal Soldier
Ms = "Royal Soldier"
NameQuest = "SkyExp2Quest"
QuestLv = 2
NameMon = "Royal Soldier"
CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate" or SelectArea == 'Fountain' then -- Galley Pirate
Ms = "Galley Pirate"
NameQuest = "FountainQuest"
QuestLv = 1
NameMon = "Galley Pirate"
CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
elseif Lv >= 650 or SelectMonster == "Galley Captain" or SelectArea == 'Fountain' then -- Galley Captain
Ms = "Galley Captain"
NameQuest = "FountainQuest"
QuestLv = 2
NameMon = "Galley Captain"
CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
end
end
if Second_Sea then
if Lv == 700 or Lv <= 724 or SelectMonster == "Raider" or SelectArea == 'Area 1' then -- Raider
Ms = "Raider"
NameQuest = "Area1Quest"
QuestLv = 1
NameMon = "Raider"
CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary" or SelectArea == 'Area 1' then -- Mercenary
Ms = "Mercenary"
NameQuest = "Area1Quest"
QuestLv = 2
NameMon = "Mercenary"
CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate" or SelectArea == 'Area 2' then -- Swan Pirate
Ms = "Swan Pirate"
NameQuest = "Area2Quest"
QuestLv = 1
NameMon = "Swan Pirate"
CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff" or SelectArea == 'Area 2' then -- Factory Staff
Ms = "Factory Staff"
NameQuest = "Area2Quest"
QuestLv = 2
NameMon = "Factory Staff"
CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenan" or SelectArea == 'Marine' then -- Marine Lieutenant
Ms = "Marine Lieutenant"
NameQuest = "MarineQuest3"
QuestLv = 1
NameMon = "Marine Lieutenant"
CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain" or SelectArea == 'Marine' then -- Marine Captain
Ms = "Marine Captain"
NameQuest = "MarineQuest3"
QuestLv = 2
NameMon = "Marine Captain"
CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie" or SelectArea == 'Zombie' then -- Zombie
Ms = "Zombie"
NameQuest = "ZombieQuest"
QuestLv = 1
NameMon = "Zombie"
CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire" or SelectArea == 'Zombie' then -- Vampire
Ms = "Vampire"
NameQuest = "ZombieQuest"
QuestLv = 2
NameMon = "Vampire"
CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper" or SelectArea == 'Snow Mountain' then -- Snow Trooper
Ms = "Snow Trooper"
NameQuest = "SnowMountainQuest"
QuestLv = 1
NameMon = "Snow Trooper"
CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior" or SelectArea == 'Snow Mountain' then -- Winter Warrior
Ms = "Winter Warrior"
NameQuest = "SnowMountainQuest"
QuestLv = 2
NameMon = "Winter Warrior"
CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate" or SelectArea == 'Ice Fire' then -- Lab Subordinate
Ms = "Lab Subordinate"
NameQuest = "IceSideQuest"
QuestLv = 1
NameMon = "Lab Subordinate"
CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior" or SelectArea == 'Ice Fire' then -- Horned Warrior
Ms = "Horned Warrior"
NameQuest = "IceSideQuest"
QuestLv = 2
NameMon = "Horned Warrior"
CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja" or SelectArea == 'Ice Fire' then -- Magma Ninja
Ms = "Magma Ninja"
NameQuest = "FireSideQuest"
QuestLv = 1
NameMon = "Magma Ninja"
CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate" or SelectArea == 'Ice Fire' then -- Lava Pirate
Ms = "Lava Pirate"
NameQuest = "FireSideQuest"
QuestLv = 2
NameMon = "Lava Pirate"
CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand" or SelectArea == 'Ship' then -- Ship Deckhand
Ms = "Ship Deckhand"
NameQuest = "ShipQuest1"
QuestLv = 1
NameMon = "Ship Deckhand"
CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
end
elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer" or SelectArea == 'Ship' then -- Ship Engineer
Ms = "Ship Engineer"
NameQuest = "ShipQuest1"
QuestLv = 2
NameMon = "Ship Engineer"
CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
end
elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward" or SelectArea == 'Ship' then -- Ship Steward
Ms = "Ship Steward"
NameQuest = "ShipQuest2"
QuestLv = 1
NameMon = "Ship Steward"
CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
end
elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer" or SelectArea == 'Ship' then -- Ship Officer
Ms = "Ship Officer"
NameQuest = "ShipQuest2"
QuestLv = 2
NameMon = "Ship Officer"
CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
end
elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior" or SelectArea == 'Frost' then -- Arctic Warrior
Ms = "Arctic Warrior"
NameQuest = "FrostQuest"
QuestLv = 1
NameMon = "Arctic Warrior"
CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
end
elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker" or SelectArea == 'Frost' then -- Snow Lurker
Ms = "Snow Lurker"
NameQuest = "FrostQuest"
QuestLv = 2
NameMon = "Snow Lurker"
CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier" or SelectArea == 'Forgotten' then -- Sea Soldier
Ms = "Sea Soldier"
NameQuest = "ForgottenQuest"
QuestLv = 1
NameMon = "Sea Soldier"
CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
elseif Lv >= 1450 or SelectMonster == "Water Fighter" or SelectArea == 'Forgotten' then -- Water Fighter
Ms = "Water Fighter"
NameQuest = "ForgottenQuest"
QuestLv = 2
NameMon = "Water Fighter"
CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
end
end
if Third_Sea then
if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire" or SelectArea == 'Pirate Port' then -- Pirate Millionaire
Ms = "Pirate Millionaire"
NameQuest = "PiratePortQuest"
QuestLv = 1
NameMon = "Pirate Millionaire"
CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire" or SelectArea == 'Pirate Port' then -- Pistol Billoonaire
Ms = "Pistol Billionaire"
NameQuest = "PiratePortQuest"
QuestLv = 2
NameMon = "Pistol Billionaire"
CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior" or SelectArea == 'Amazon' then -- Dragon Crew Warrior
Ms = "Dragon Crew Warrior"
NameQuest = "AmazonQuest"
QuestLv = 1
NameMon = "Dragon Crew Warrior"
CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer" or SelectArea == 'Amazon' then -- Dragon Crew Archer
Ms = "Dragon Crew Archer"
NameQuest = "AmazonQuest"
QuestLv = 2
NameMon = "Dragon Crew Archer"
CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander" or SelectArea == 'Amazon' then -- Female Islander
Ms = "Female Islander"
NameQuest = "AmazonQuest2"
QuestLv = 1
NameMon = "Female Islander"
CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander" or SelectArea == 'Amazon' then -- Giant Islander
Ms = "Giant Islander"
NameQuest = "AmazonQuest2"
QuestLv = 2
NameMon = "Giant Islander"
CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore" or SelectArea == 'Marine Tree' then -- Marine Commodore
Ms = "Marine Commodore"
NameQuest = "MarineTreeIsland"
QuestLv = 1
NameMon = "Marine Commodore"
CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral" or SelectArea == 'Marine Tree' then -- Marine Rear Admiral
Ms = "Marine Rear Admiral"
NameQuest = "MarineTreeIsland"
QuestLv = 2
NameMon = "Marine Rear Admiral"
CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider" or SelectArea == 'Deep Forest' then -- Fishman Raide
Ms = "Fishman Raider"
NameQuest = "DeepForestIsland3"
QuestLv = 1
NameMon = "Fishman Raider"
CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain" or SelectArea == 'Deep Forest' then -- Fishman Captain
Ms = "Fishman Captain"
NameQuest = "DeepForestIsland3"
QuestLv = 2
NameMon = "Fishman Captain"
CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate" or SelectArea == 'Deep Forest' then -- Forest Pirate
Ms = "Forest Pirate"
NameQuest = "DeepForestIsland"
QuestLv = 1
NameMon = "Forest Pirate"
CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate" or SelectArea == 'Deep Forest' then -- Mythological Pirate
Ms = "Mythological Pirate"
NameQuest = "DeepForestIsland"
QuestLv = 2
NameMon = "Mythological Pirate"
CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate" or SelectArea == 'Deep Forest' then -- Jungle Pirate
Ms = "Jungle Pirate"
NameQuest = "DeepForestIsland2"
QuestLv = 1
NameMon = "Jungle Pirate"
CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate" or SelectArea == 'Deep Forest' then -- Musketeer Pirate
Ms = "Musketeer Pirate"
NameQuest = "DeepForestIsland2"
QuestLv = 2
NameMon = "Musketeer Pirate"
CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton" or SelectArea == 'Haunted Castle' then
Ms = "Reborn Skeleton"
NameQuest = "HauntedQuest1"
QuestLv = 1
NameMon = "Reborn Skeleton"
CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie" or SelectArea == 'Haunted Castle' then
Ms = "Living Zombie"
NameQuest = "HauntedQuest1"
QuestLv = 2
NameMon = "Living Zombie"
CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul" or SelectArea == 'Haunted Castle' then
Ms = "Demonic Soul"
NameQuest = "HauntedQuest2"
QuestLv = 1
NameMon = "Demonic Soul"
CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
elseif Lv == 2050 or Lv <= 2074 or SelectMonster == "Posessed Mummy" or SelectArea == 'Haunted Castle' then
Ms = "Posessed Mummy"
NameQuest = "HauntedQuest2"
QuestLv = 2
NameMon = "Posessed Mummy"
CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
elseif Lv == 2075 or Lv <= 2099 or SelectMonster == "Peanut Scout" or SelectArea == 'Nut Island' then
Ms = "Peanut Scout"
NameQuest = "NutsIslandQuest"
QuestLv = 1
NameMon = "Peanut Scout"
CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
elseif Lv == 2100 or Lv <= 2124 or SelectMonster == "Peanut President" or SelectArea == 'Nut Island' then
Ms = "Peanut President"
NameQuest = "NutsIslandQuest"
QuestLv = 2
NameMon = "Peanut President"
CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
elseif Lv == 2125 or Lv <= 2149 or SelectMonster == "Ice Cream Chef" or SelectArea == 'Ice Cream Island' then
Ms = "Ice Cream Chef"
NameQuest = "IceCreamIslandQuest"
QuestLv = 1
NameMon = "Ice Cream Chef"
CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
elseif Lv == 2150 or Lv <= 2199 or SelectMonster == "Ice Cream Commander" or SelectArea == 'Ice Cream Island' then
Ms = "Ice Cream Commander"
NameQuest = "IceCreamIslandQuest"
QuestLv = 2
NameMon = "Ice Cream Commander"
CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
elseif Lv == 2200 or Lv <= 2224 or SelectMonster == "Cookie Crafter" or SelectArea == 'Cake Island' then
Ms = "Cookie Crafter"
NameQuest = "CakeQuest1"
QuestLv = 1
NameMon = "Cookie Crafter"
CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
elseif Lv == 2225 or Lv <= 2249 or SelectMonster == "Cake Guard" or SelectArea == 'Cake Island' then
Ms = "Cake Guard"
NameQuest = "CakeQuest1"
QuestLv = 2
NameMon = "Cake Guard"
CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
elseif Lv == 2250 or Lv <= 2274 or SelectMonster == "Baking Staff" or SelectArea == 'Cake Island' then
Ms = "Baking Staff"
NameQuest = "CakeQuest2"
QuestLv = 1
NameMon = "Baking Staff"
CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
elseif Lv == 2275 or Lv <= 2299 or SelectMonster == "Head Baker" or SelectArea == 'Cake Island' then
Ms = "Head Baker"
NameQuest = "CakeQuest2"
QuestLv = 2
NameMon = "Head Baker"
CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
CFrameMon = CFrame.new(-2251.5791, 52.2714615, -13033.3965, -0.991971016, 0, -0.126466095, 0, 1, 0, 0.126466095, 0, -0.991971016)
elseif Lv == 2300 or Lv <= 2324 or SelectMonster == "Cocoa Warrior" or SelectArea == 'Choco Island' then
Ms = "Cocoa Warrior"
NameQuest = "ChocQuest1"
QuestLv = 1
NameMon = "Cocoa Warrior"
CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
CFrameMon = CFrame.new(167.978516, 26.2254658, -12238.874, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961)
elseif Lv == 2325 or Lv <= 2349 or SelectMonster == "Chocolate Bar Battler" or SelectArea == 'Choco Island' then
Ms = "Chocolate Bar Battler"
NameQuest = "ChocQuest1"
QuestLv = 2
NameMon = "Chocolate Bar Battler"
CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
CFrameMon = CFrame.new(701.312073, 25.5824986, -12708.2148, -0.342042685, 0, -0.939684391, 0, 1, 0, 0.939684391, 0, -0.342042685)
elseif Lv == 2350 or Lv <= 2374 or SelectMonster == "Sweet Thief" or SelectArea == 'Choco Island' then
Ms = "Sweet Thief"
NameQuest = "ChocQuest2"
QuestLv = 1
NameMon = "Sweet Thief"
CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
CFrameMon = CFrame.new(-140.258301, 25.5824986, -12652.3115, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
elseif Lv == 2375 or Lv <= 2400 or SelectMonster == "Candy Rebel" or SelectArea == 'Choco Island' then
Ms = "Candy Rebel"
NameQuest = "ChocQuest2"
QuestLv = 2
NameMon = "Candy Rebel"
CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
CFrameMon = CFrame.new(47.9231453, 25.5824986, -13029.2402, -0.819156051, 0, -0.573571265, 0, 1, 0, 0.573571265, 0, -0.819156051)
elseif Lv == 2400 or Lv <= 2424 or SelectMonster == "Candy Pirate" or SelectArea == 'Candy Island' then
Ms = "Candy Pirate"
NameQuest = "CandyQuest1"
QuestLv = 1
NameMon = "Candy Pirate"
CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
CFrameMon = CFrame.new(-1437.56348, 17.1481285, -14385.6934, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
elseif Lv == 2425 or Lv <= 2449 or SelectMonster == "Snow Demon" or SelectArea == 'Candy Island' then
Ms = "Snow Demon"
NameQuest = "CandyQuest1"
QuestLv = 2
NameMon = "Snow Demon"
CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
CFrameMon = CFrame.new(-916.222656, 17.1481285, -14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
elseif Lv == 2450 or Lv <= 2474 or SelectMonster == "Isle Outlaw" or SelectArea == 'Tiki Outpost' then
Ms = "Isle Outlaw"
NameQuest = "TikiQuest1"
QuestLv = 1
NameMon = "Isle Outlaw"
CFrameQ = CFrame.new(-16549.890625, 55.68635559082031, -179.91360473632812)
CFrameMon = CFrame.new(-16162.8193359375, 11.6863374710083, -96.45481872558594)
elseif Lv == 2475 or Lv <= 2524 or SelectMonster == "Island Boy" or SelectArea == 'Tiki Outpost' then
Ms = "Island Boy"
NameQuest = "TikiQuest1"
QuestLv = 2
NameMon = "Island Boy"
CFrameQ = CFrame.new(-16549.890625, 55.68635559082031, -179.91360473632812)
CFrameMon = CFrame.new(-16912.130859375, 11.787443161010742, -133.0850830078125)
elseif Lv >= 2525 or SelectMonster == "Isle Champion" or SelectArea == 'Tiki Outpost' then
Ms = "Isle Champion"
NameQuest = "TikiQuest2"
QuestLv = 2
NameMon = "Isle Champion"
CFrameQ = CFrame.new(-16542.447265625, 55.68632888793945, 1044.41650390625)
CFrameMon = CFrame.new(-16848.94140625, 21.68633460998535, 1041.4490966796875)
end
end
end

--// Select Monster
if First_Sea then
tableMon = {
  "Bandit","Monkey","Gorilla","Pirate","Brute","Desert Bandit","Desert Officer","Snow Bandit","Snowman","Chief Petty Officer","Sky Bandit","Dark Master","Prisoner", "Dangerous Prisoner","Toga Warrior","Gladiator","Military Soldier","Military Spy","Fishman Warrior","Fishman Commando","God's Guard","Shanda","Royal Squad","Royal Soldier","Galley Pirate","Galley Captain"
} elseif Second_Sea then
tableMon = {
  "Raider","Mercenary","Swan Pirate","Factory Staff","Marine Lieutenant","Marine Captain","Zombie","Vampire","Snow Trooper","Winter Warrior","Lab Subordinate","Horned Warrior","Magma Ninja","Lava Pirate","Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer","Arctic Warrior","Snow Lurker","Sea Soldier","Water Fighter"
} elseif Third_Sea then
tableMon = {
  "Pirate Millionaire","Dragon Crew Warrior","Dragon Crew Archer","Female Islander","Giant Islander","Marine Commodore","Marine Rear Admiral","Fishman Raider","Fishman Captain","Forest Pirate","Mythological Pirate","Jungle Pirate","Musketeer Pirate","Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy", "Peanut Scout", "Peanut President", "Ice Cream Chef", "Ice Cream Commander", "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker", "Cocoa Warrior", "Chocolate Bar Battler", "Sweet Thief", "Candy Rebel", "Candy Pirate", "Snow Demon","Isle Outlaw","Island Boy","Isle Champion"
}
end

--// Select Island
if First_Sea then
AreaList = {
  'Jungle', 'Buggy', 'Desert', 'Snow', 'Marine', 'Sky', 'Prison', 'Colosseum', 'Magma', 'Fishman', 'Sky Island', 'Fountain'
} elseif Second_Sea then
AreaList = {
  'Area 1', 'Area 2', 'Zombie', 'Marine', 'Snow Mountain', 'Ice fire', 'Ship', 'Frost', 'Forgotten'
} elseif Third_Sea then
AreaList = {
  'Pirate Port', 'Amazon', 'Marine Tree', 'Deep Forest', 'Haunted Castle', 'Nut Island', 'Ice Cream Island', 'Cake Island', 'Choco Island', 'Candy Island','Tiki Outpost'
}
end

--// Check Boss Quest
function CheckBossQuest()
if First_Sea then
if SelectBoss == "The Gorilla King" then
BossMon = "The Gorilla King"
NameBoss = 'The Gorrila King'
NameQuestBoss = "JungleQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$2,000\n7,000 Exp."
CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
elseif SelectBoss == "Bobby" then
BossMon = "Bobby"
NameBoss = 'Bobby'
NameQuestBoss = "BuggyQuest1"
QuestLvBoss = 3
RewardBoss = "Reward:\n$8,000\n35,000 Exp."
CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
elseif SelectBoss == "The Saw" then
BossMon = "The Saw"
NameBoss = 'The Saw'
CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
elseif SelectBoss == "Yeti" then
BossMon = "Yeti"
NameBoss = 'Yeti'
NameQuestBoss = "SnowQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$10,000\n180,000 Exp."
CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
elseif SelectBoss == "Mob Leader" then
BossMon = "Mob Leader"
NameBoss = 'Mob Leader'
CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
elseif SelectBoss == "Vice Admiral" then
BossMon = "Vice Admiral"
NameBoss = 'Vice Admiral'
NameQuestBoss = "MarineQuest2"
QuestLvBoss = 2
RewardBoss = "Reward:\n$10,000\n180,000 Exp."
CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
elseif SelectBoss == "Saber Expert" then
NameBoss = 'Saber Expert'
BossMon = "Saber Expert"
CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
elseif SelectBoss == "Warden" then
BossMon = "Warden"
NameBoss = 'Warden'
NameQuestBoss = "ImpelQuest"
QuestLvBoss = 1
RewardBoss = "Reward:\n$6,000\n850,000 Exp."
CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
elseif SelectBoss == "Chief Warden" then
BossMon = "Chief Warden"
NameBoss = 'Chief Warden'
NameQuestBoss = "ImpelQuest"
QuestLvBoss = 2
RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
elseif SelectBoss == "Swan" then
BossMon = "Swan"
NameBoss = 'Swan'
NameQuestBoss = "ImpelQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
elseif SelectBoss == "Magma Admiral" then
BossMon = "Magma Admiral"
NameBoss = 'Magma Admiral'
NameQuestBoss = "MagmaQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
elseif SelectBoss == "Fishman Lord" then
BossMon = "Fishman Lord"
NameBoss = 'Fishman Lord'
NameQuestBoss = "FishmanQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
elseif SelectBoss == "Wysper" then
BossMon = "Wysper"
NameBoss = 'Wysper'
NameQuestBoss = "SkyExp1Quest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
elseif SelectBoss == "Thunder God" then
BossMon = "Thunder God"
NameBoss = 'Thunder God'
NameQuestBoss = "SkyExp2Quest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
elseif SelectBoss == "Cyborg" then
BossMon = "Cyborg"
NameBoss = 'Cyborg'
NameQuestBoss = "FountainQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
elseif SelectBoss == "Ice Admiral" then
BossMon = "Ice Admiral"
NameBoss = 'Ice Admiral'
CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
elseif SelectBoss == "Greybeard" then
BossMon = "Greybeard"
NameBoss = 'Greybeard'
CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
end
end
if Second_Sea then
if SelectBoss == "Diamond" then
BossMon = "Diamond"
NameBoss = 'Diamond'
NameQuestBoss = "Area1Quest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
elseif SelectBoss == "Jeremy" then
BossMon = "Jeremy"
NameBoss = 'Jeremy'
NameQuestBoss = "Area2Quest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
elseif SelectBoss == "Fajita" then
BossMon = "Fajita"
NameBoss = 'Fajita'
NameQuestBoss = "MarineQuest3"
QuestLvBoss = 3
RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
elseif SelectBoss == "Don Swan" then
BossMon = "Don Swan"
NameBoss = 'Don Swan'
CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
elseif SelectBoss == "Smoke Admiral" then
BossMon = "Smoke Admiral"
NameBoss = 'Smoke Admiral'
NameQuestBoss = "IceSideQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
elseif SelectBoss == "Awakened Ice Admiral" then
BossMon = "Awakened Ice Admiral"
NameBoss = 'Awakened Ice Admiral'
NameQuestBoss = "FrostQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
elseif SelectBoss == "Tide Keeper" then
BossMon = "Tide Keeper"
NameBoss = 'Tide Keeper'
NameQuestBoss = "ForgottenQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
elseif SelectBoss == "Darkbeard" then
BossMon = "Darkbeard"
NameBoss = 'Darkbeard'
CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
elseif SelectBoss == "Cursed Captain" then
BossMon = "Cursed Captain"
NameBoss = 'Cursed Captain'
CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
elseif SelectBoss == "Order" then
BossMon = "Order"
NameBoss = 'Order'
CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
end
end
if Third_Sea then
if SelectBoss == "Stone" then
BossMon = "Stone"
NameBoss = 'Stone'
NameQuestBoss = "PiratePortQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
elseif SelectBoss == "Island Empress" then
BossMon = "Island Empress"
NameBoss = 'Island Empress'
NameQuestBoss = "AmazonQuest2"
QuestLvBoss = 3
RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
elseif SelectBoss == "Kilo Admiral" then
BossMon = "Kilo Admiral"
NameBoss = 'Kilo Admiral'
NameQuestBoss = "MarineTreeIsland"
QuestLvBoss = 3
RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
elseif SelectBoss == "Captain Elephant" then
BossMon = "Captain Elephant"
NameBoss = 'Captain Elephant'
NameQuestBoss = "DeepForestIsland"
QuestLvBoss = 3
RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
elseif SelectBoss == "Beautiful Pirate" then
BossMon = "Beautiful Pirate"
NameBoss = 'Beautiful Pirate'
NameQuestBoss = "DeepForestIsland2"
QuestLvBoss = 3
RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
elseif SelectBoss == "Cake Queen" then
BossMon = "Cake Queen"
NameBoss = 'Cake Queen'
NameQuestBoss = "IceCreamIslandQuest"
QuestLvBoss = 3
RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
CFrameQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
elseif SelectBoss == "Longma" then
BossMon = "Longma"
NameBoss = 'Longma'
CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
elseif SelectBoss == "Soul Reaper" then
BossMon = "Soul Reaper"
NameBoss = 'Soul Reaper'
CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
elseif SelectBoss == "rip_indra True Form" then
BossMon = "rip_indra True Form"
NameBoss = 'rip_indra True Form'
CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
end
end
end

--// Check Material
function MaterialMon()
if SelectMaterial == "Radioactive Material" then
MMon = "Factory Staff"
MPos = CFrame.new(295,73,-56)
SP = "Default"
elseif SelectMaterial == "Mystic Droplet" then
MMon = "Water Fighter"
MPos = CFrame.new(-3385,239,-10542)
SP = "Default"
elseif SelectMaterial == "Magma Ore" then
if First_Sea then
MMon = "Military Spy"
MPos = CFrame.new(-5815,84,8820)
SP = "Default"
elseif Second_Sea then
MMon = "Magma Ninja"
MPos = CFrame.new(-5428,78,-5959)
SP = "Default"
end
elseif SelectMaterial == "Angel Wings" then
MMon = "God's Guard"
MPos = CFrame.new(-4698,845,-1912)
SP = "Default"
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7859.09814, 5544.19043, -381.476196))
end
elseif SelectMaterial == "Leather" then
if First_Sea then
MMon = "Brute"
MPos = CFrame.new(-1145,15,4350)
SP = "Default"
elseif Second_Sea then
MMon = "Marine Captain"
MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
SP = "Default"
elseif Third_Sea then
MMon = "Jungle Pirate"
MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
SP = "Default"
end
elseif SelectMaterial == "Scrap Metal" then
if First_Sea then
MMon = "Brute"
MPos = CFrame.new(-1145,15,4350)
SP = "Default"
elseif Second_Sea then
MMon = "Swan Pirate"
MPos = CFrame.new(878,122,1235)
SP = "Default"
elseif Third_Sea then
MMon = "Jungle Pirate"
MPos = CFrame.new(-12107,332,-10549)
SP = "Default"
end
elseif SelectMaterial == "Fish Tail" then
if Third_Sea then
MMon = "Fishman Raider"
MPos = CFrame.new(-10993,332,-8940)
SP = "Default"
elseif First_Sea then
MMon = "Fishman Warrior"
MPos = CFrame.new(61123,19,1569)
SP = "Default"
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
end
end
elseif SelectMaterial == "Demonic Wisp" then
MMon = "Demonic Soul"
MPos = CFrame.new(-9507,172,6158)
SP = "Default"
elseif SelectMaterial == "Vampire Fang" then
MMon = "Vampire"
MPos = CFrame.new(-6033,7,-1317)
SP = "Default"
elseif SelectMaterial == "Conjured Cocoa" then
MMon = "Chocolate Bar Battler"
MPos = CFrame.new(620.6344604492188,78.93644714355469, -12581.369140625)
SP = "Default"
elseif SelectMaterial == "Dragon Scale" then
MMon = "Dragon Crew Archer"
MPos = CFrame.new(6594,383,139)
SP = "Default"
elseif SelectMaterial == "Gunpowder" then
MMon = "Pistol Billionaire"
MPos = CFrame.new(-469,74,5904)
SP = "Default"
elseif SelectMaterial == "Mini Tusk" then
MMon = "Mythological Pirate"
MPos = CFrame.new(-13545,470,-6917)
SP = "Default"
end
end




---------------------Esp
function UpdateIslandESP() 
    for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then 
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = "GothamBold"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(8, 0, 0)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
for i,v in pairs(game:GetService'Players':GetChildren()) do
    pcall(function()
        if not isnil(v.Character) then
            if ESPPlayer then
                if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v.Character.Head)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v.Character.Head
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size10"
                    name.TextWrapped = true
                    name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance')
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    if v.Team == game.Players.LocalPlayer.Team then
                        name.TextColor3 = Color3.new(0,0,254)
                    else
                        name.TextColor3 = Color3.new(255,0,0)
                    end
                else
                    v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
                end
            else
                if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end
    end)
end
end
function UpdateChestChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if string.find(v.Name,"Chest") then
            if ChestESP then
                if string.find(v.Name,"Chest") then
                    if not v:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Name == "Chest1" then
                            name.TextColor3 = Color3.fromRGB(109, 109, 109)
                            name.Text = ("Chest 1" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                        if v.Name == "Chest2" then
                            name.TextColor3 = Color3.fromRGB(173, 158, 21)
                            name.Text = ("Chest 2" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                        if v.Name == "Chest3" then
                            name.TextColor3 = Color3.fromRGB(85, 255, 255)
                            name.Text = ("Chest 3" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                    else
                        v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp'..Number) then
                    v:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end
    end)
end
end
function UpdateDevilChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if DevilFruitESP then
            if string.find(v.Name, "Fruit") then   
                if not v.Handle:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v.Handle)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 255, 255)
                    name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                else
                    v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                end
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end
    end)
end
end
function UpdateFlowerChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if v.Name == "Flower2" or v.Name == "Flower1" then
            if FlowerESP then 
                if not v:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    if v.Name == "Flower1" then 
                        name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        name.TextColor3 = Color3.fromRGB(0, 0, 255)
                    end
                    if v.Name == "Flower2" then
                        name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                else
                    v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                end
            else
                if v:FindFirstChild('NameEsp'..Number) then
                v:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end   
    end)
end
end
function UpdateRealFruitChams() 
for i,v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(255, 0, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
for i,v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(255, 174, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
for i,v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(251, 255, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
end

function UpdateIslandESP() 
    for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then 
                if v.Name ~= "Sea" then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = "GothamBold"
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(7, 236, 240)
                    else
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
for i,v in pairs(game:GetService'Players':GetChildren()) do
    pcall(function()
        if not isnil(v.Character) then
            if ESPPlayer then
                if not isnil(v.Character.Head) and not v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v.Character.Head)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v.Character.Head
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance')
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    if v.Team == game.Players.LocalPlayer.Team then
                        name.TextColor3 = Color3.new(0,255,0)
                    else
                        name.TextColor3 = Color3.new(255,0,0)
                    end
                else
                    v.Character.Head['NameEsp'..Number].TextLabel.Text = (v.Name ..' | '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude/3) ..' Distance\nHealth : ' .. round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth) .. '%')
                end
            else
                if v.Character.Head:FindFirstChild('NameEsp'..Number) then
                    v.Character.Head:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end
    end)
end
end
function UpdateChestChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if string.find(v.Name,"Chest") then
            if ChestESP then
                if string.find(v.Name,"Chest") then
                    if not v:FindFirstChild('NameEsp'..Number) then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameEsp'..Number
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.GothamSemibold
                        name.FontSize = "Size14"
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = 'Top'
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        if v.Name == "Chest1" then
                            name.TextColor3 = Color3.fromRGB(109, 109, 109)
                            name.Text = ("Chest 1" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                        if v.Name == "Chest2" then
                            name.TextColor3 = Color3.fromRGB(173, 158, 21)
                            name.Text = ("Chest 2" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                        if v.Name == "Chest3" then
                            name.TextColor3 = Color3.fromRGB(85, 255, 255)
                            name.Text = ("Chest 3" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        end
                    else
                        v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                    end
                end
            else
                if v:FindFirstChild('NameEsp'..Number) then
                    v:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end
    end)
end
end
function UpdateDevilChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if DevilFruitESP then
            if string.find(v.Name, "Fruit") then   
                if not v.Handle:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v.Handle)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v.Handle
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 255, 255)
                    name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                else
                    v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
                end
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end
    end)
end
end
function UpdateFlowerChams() 
for i,v in pairs(game.Workspace:GetChildren()) do
    pcall(function()
        if v.Name == "Flower2" or v.Name == "Flower1" then
            if FlowerESP then 
                if not v:FindFirstChild('NameEsp'..Number) then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'..Number
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = Enum.Font.GothamSemibold
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    if v.Name == "Flower1" then 
                        name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        name.TextColor3 = Color3.fromRGB(0, 0, 255)
                    end
                    if v.Name == "Flower2" then
                        name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                        name.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                else
                    v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' Distance')
                end
            else
                if v:FindFirstChild('NameEsp'..Number) then
                v:FindFirstChild('NameEsp'..Number):Destroy()
                end
            end
        end   
    end)
end
end
function UpdateRealFruitChams() 
for i,v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(255, 0, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
for i,v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(255, 174, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
for i,v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
    if v:IsA("Tool") then
        if RealFruitESP then 
            if not v.Handle:FindFirstChild('NameEsp'..Number) then
                local bill = Instance.new('BillboardGui',v.Handle)
                bill.Name = 'NameEsp'..Number
                bill.ExtentsOffset = Vector3.new(0, 1, 0)
                bill.Size = UDim2.new(1,200,1,30)
                bill.Adornee = v.Handle
                bill.AlwaysOnTop = true
                local name = Instance.new('TextLabel',bill)
                name.Font = Enum.Font.GothamSemibold
                name.FontSize = "Size14"
                name.TextWrapped = true
                name.Size = UDim2.new(1,0,1,0)
                name.TextYAlignment = 'Top'
                name.BackgroundTransparency = 1
                name.TextStrokeTransparency = 0.5
                name.TextColor3 = Color3.fromRGB(251, 255, 0)
                name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            else
                v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' Distance')
            end
        else
            if v.Handle:FindFirstChild('NameEsp'..Number) then
                v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
            end
        end 
    end
end
end

spawn(function()
while wait() do
    pcall(function()
        if MobESP then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:FindFirstChild('HumanoidRootPart') then
                    if not v:FindFirstChild("MobEap") then
                        local BillboardGui = Instance.new("BillboardGui")
                        local TextLabel = Instance.new("TextLabel")

                        BillboardGui.Parent = v
                        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BillboardGui.Active = true
                        BillboardGui.Name = "MobEap"
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.LightInfluence = 1.000
                        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                        BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)

                        TextLabel.Parent = BillboardGui
                        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.BackgroundTransparency = 1.000
                        TextLabel.Size = UDim2.new(0, 200, 0, 50)
                        TextLabel.Font = Enum.Font.GothamBold
                        TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                        TextLabel.Text.Size = 35
                    end
                    local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                    v.MobEap.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                end
            end
        else
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:FindFirstChild("MobEap") then
                    v.MobEap:Destroy()
                end
            end
        end
    end)
end
end)

spawn(function()
while wait() do
    pcall(function()
        if SeaESP then
            for i,v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                if v:FindFirstChild('HumanoidRootPart') then
                    if not v:FindFirstChild("Seaesps") then
                        local BillboardGui = Instance.new("BillboardGui")
                        local TextLabel = Instance.new("TextLabel")

                        BillboardGui.Parent = v
                        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BillboardGui.Active = true
                        BillboardGui.Name = "Seaesps"
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.LightInfluence = 1.000
                        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                        BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)

                        TextLabel.Parent = BillboardGui
                        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.BackgroundTransparency = 1.000
                        TextLabel.Size = UDim2.new(0, 200, 0, 50)
                        TextLabel.Font = Enum.Font.GothamBold
                        TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                        TextLabel.Text.Size = 35
                    end
                    local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                    v.Seaesps.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                end
            end
        else
            for i,v in pairs (game:GetService("Workspace").SeaBeasts:GetChildren()) do
                if v:FindFirstChild("Seaesps") then
                    v.Seaesps:Destroy()
                end
            end
        end
    end)
end
end)

spawn(function()
while wait() do
    pcall(function()
        if NpcESP then
            for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                if v:FindFirstChild('HumanoidRootPart') then
                    if not v:FindFirstChild("NpcEspes") then
                        local BillboardGui = Instance.new("BillboardGui")
                        local TextLabel = Instance.new("TextLabel")

                        BillboardGui.Parent = v
                        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BillboardGui.Active = true
                        BillboardGui.Name = "NpcEspes"
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.LightInfluence = 1.000
                        BillboardGui.Size = UDim2.new(0, 200, 0, 50)
                        BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)

                        TextLabel.Parent = BillboardGui
                        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.BackgroundTransparency = 1.000
                        TextLabel.Size = UDim2.new(0, 200, 0, 50)
                        TextLabel.Font = Enum.Font.GothamBold
                        TextLabel.TextColor3 = Color3.fromRGB(7, 236, 240)
                        TextLabel.Text.Size = 35
                    end
                    local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude)
                    v.NpcEspes.TextLabel.Text = v.Name.." - "..Dis.." Distance"
                end
            end
        else
            for i,v in pairs (game:GetService("Workspace").NPCs:GetChildren()) do
                if v:FindFirstChild("NpcEspes") then
                    v.NpcEspes:Destroy()
                end
            end
        end
    end)
end
end)

function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)

function UpdateIslandMirageESP() 
for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
    pcall(function()
        if MirageIslandESP then 
            if v.Name == "Mirage Island" then
                if not v:FindFirstChild('NameEsp') then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = "Code"
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(80, 245, 245)
                else
                    v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                end
            end
        else
            if v:FindFirstChild('NameEsp') then
                v:FindFirstChild('NameEsp'):Destroy()
            end
        end
    end)
end
end

function isnil(thing)
return (thing == nil)
end
local function round(n)
return math.floor(tonumber(n) + 0.5)
end
Number = math.random(1, 1000000)

function UpdateAfdESP() 
for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
    pcall(function()
        if AfdESP then 
            if v.Name == "Advanced Fruit Dealer" then
                if not v:FindFirstChild('NameEsp') then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = "Code"
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(80, 245, 245)
                else
                    v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                end
            end
        else
            if v:FindFirstChild('NameEsp') then
                v:FindFirstChild('NameEsp'):Destroy()
            end
        end
    end)
end
end

function UpdateAuraESP() 
for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
    pcall(function()
        if AuraESP then 
            if v.Name == "Master of Enhancement" then
                if not v:FindFirstChild('NameEsp') then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = "Code"
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(80, 245, 245)
                else
                    v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                end
            end
        else
            if v:FindFirstChild('NameEsp') then
                v:FindFirstChild('NameEsp'):Destroy()
            end
        end
    end)
end
end

function UpdateLSDESP() 
for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
    pcall(function()
        if LADESP then 
            if v.Name == "Legendary Sword Dealer" then
                if not v:FindFirstChild('NameEsp') then
                    local bill = Instance.new('BillboardGui',v)
                    bill.Name = 'NameEsp'
                    bill.ExtentsOffset = Vector3.new(0, 1, 0)
                    bill.Size = UDim2.new(1,200,1,30)
                    bill.Adornee = v
                    bill.AlwaysOnTop = true
                    local name = Instance.new('TextLabel',bill)
                    name.Font = "Code"
                    name.FontSize = "Size14"
                    name.TextWrapped = true
                    name.Size = UDim2.new(1,0,1,0)
                    name.TextYAlignment = 'Top'
                    name.BackgroundTransparency = 1
                    name.TextStrokeTransparency = 0.5
                    name.TextColor3 = Color3.fromRGB(80, 245, 245)
                else
                    v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
                end
            end
        else
            if v:FindFirstChild('NameEsp') then
                v:FindFirstChild('NameEsp'):Destroy()
            end
        end
    end)
end
end

function UpdateGeaESP() 
    for i,v in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        pcall(function()
            if GeaESP then 
                -- Điều kiện mở rộng cho các loại Gear
                if v:IsA("Model") and (v.Name == "Gear" or string.find(v.Name, "Gear") or v:FindFirstChild("GearPart")) then
                    if not v:FindFirstChild('NameEsp') then
                        local bill = Instance.new('BillboardGui',v)
                        bill.Name = 'NameESP'
                        bill.ExtentsOffset = Vector3.new(0, 1, 0)
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.Adornee = v
                        bill.AlwaysOnTop = true
                        
                        local name = Instance.new('TextLabel',bill)
                        name.Font = Enum.Font.Code
                        name.FontSize = Enum.FontSize.Size14
                        name.TextWrapped = true
                        name.Size = UDim2.new(1,0,1,0)
                        name.TextYAlignment = Enum.TextYAlignment.Top
                        name.BackgroundTransparency = 1
                        name.TextStrokeTransparency = 0.5
                        name.TextColor3 = Color3.fromRGB(80, 245, 245)  -- Màu cam
                        
                        -- Xác định vị trí để tính khoảng cách
                        local targetPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("GearPart") or v
                        
                        name.Text = (v.Name ..'   \n'.. 
                            round((game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude/3) ..' M')
                    else
                        local targetPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("GearPart") or v
                        
                        v['NameEsp'].TextLabel.Text = (v.Name ..'   \n'.. 
                            round((game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude/3) ..' M')
                    end
                end
            else
                -- Xóa ESP nếu tắt chức năng
                if v:FindFirstChild('NameEsp') then
                    v:FindFirstChild('NameEsp'):Destroy()
                end
            end
        end)
    end
end

-- Hàm làm tròn số (đảm bảo có sẵn)
local function round(n)
    return math.floor(tonumber(n) + 0.5)
end
--------------------------------------------------------------------------------------------------------------------------------------------
local slashHit = game:GetService("ReplicatedStorage").Assets:FindFirstChild('SlashHit')
if slashHit then
    slashHit:Destroy()
end

---------Tween

 function Tween(P1, customSpeed)
    -- Kiểm tra đầu vào hợp lệ
    if not P1 or not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character.HumanoidRootPart then
        warn("Invalid tween parameters")
        return
    end

    -- Tính toán khoảng cách
    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local Distance = (P1.Position - playerPos).Magnitude
    
    -- Sử dụng tốc độ tùy chỉnh hoặc mặc định
    local Speed = customSpeed or ChangeSpeed or 300
    
    -- Đảm bảo tốc độ không bằng 0
    Speed = math.max(Speed, 1)

    -- Tạo tween
    local tweenService = game:GetService("TweenService")
    local tween = tweenService:Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), 
        {CFrame = P1}
    )
    
    -- Xử lý hủy tween
    local function handleTweenCancel()
        if _G.StopTween then
            tween:Cancel()
            return true
        end
        return false
    end

    -- Thực thi tween
    if not handleTweenCancel() then
        tween:Play()
    end
end

function CancelTween(target)
    -- Nếu không có target cụ thể, hủy tween hiện tại
    if not target then
        _G.StopTween = true
        task.wait() -- Sử dụng task.wait() thay cho wait()
        
        -- Trở về vị trí hiện tại
        local localPlayer = game.Players.LocalPlayer
        if localPlayer and localPlayer.Character and localPlayer.Character.HumanoidRootPart then
            Tween(localPlayer.Character.HumanoidRootPart.CFrame)
        end
        
        task.wait()
        _G.StopTween = false
    end
end

function Tween2(P1)
    -- Tương tự như Tween nhưng có thêm xử lý clip
    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    local Distance = (P1.Position - playerPos).Magnitude
    
    local Speed = 300
    local tweenService = game:GetService("TweenService")
    
    local tween = tweenService:Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear), 
        {CFrame = P1}
    )
    
    -- Xử lý hủy tween
    if _G.CancelTween2 then
        tween:Cancel()
        return
    end
    
    -- Xử lý clip
    _G.Clip2 = true
    tween:Play()
    
    -- Chờ hoàn thành tween
    task.wait(Distance/Speed)
    _G.Clip2 = false
end



   -- Tween Ship
function TweenShip(CFgo)
    -- Kiểm tra đầu vào
    if not CFgo then 
        warn("Invalid CFrame for TweenShip")
        return 
    end

    local tween_s = game:GetService("TweenService")
    local boat = game:GetService("Workspace").Boats.MarineBrigade
    
    -- Kiểm tra tồn tại của đối tượng
    if not boat or not boat:FindFirstChild("VehicleSeat") then
        warn("Boat or VehicleSeat not found")
        return
    end

    local distance = (boat.VehicleSeat.CFrame.Position - CFgo.Position).Magnitude
    local speed = 300
    
    local info = TweenInfo.new(distance/speed, Enum.EasingStyle.Linear)
    local tween = tween_s:Create(boat.VehicleSeat, info, {CFrame = CFgo})
    
    local tweenfunc = {}

    function tweenfunc:Stop()
        if tween then
            tween:Cancel()
        end
    end

    function tweenfunc:Play()
        if tween then
            tween:Play()
        end
    end

    tween:Play()
    return tweenfunc
end

-- Tween Boat
function TweenBoat(CFgo)
    -- Kiểm tra đầu vào
    if not CFgo then 
        warn("Invalid CFrame for TweenBoat")
        return 
    end

    local player = game.Players.LocalPlayer
    
    -- Kiểm tra trạng thái nhân vật
    if not player or not player.Character then
        warn("Player or Character not found")
        return
    end

    local humanoid = player.Character:FindFirstChild("Humanoid")
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")

    -- Kiểm tra chết
    if humanoid and humanoid.Health <= 0 then
        -- Xử lý khi chết
        repeat 
            task.wait() 
        until player.Character and 
               player.Character:FindFirstChild("Humanoid") and 
               player.Character.Humanoid.Health > 0
        
        task.wait(7)  -- Chờ hồi sinh
        return
    end

    -- Kiểm tra rootPart
    if not rootPart then
        warn("HumanoidRootPart not found")
        return
    end

    local tween_s = game:GetService("TweenService")
    local distance = (rootPart.Position - CFgo.Position).Magnitude
    local speed = 325
    
    local info = TweenInfo.new(distance/speed, Enum.EasingStyle.Linear)
    local tween = tween_s:Create(rootPart, info, {CFrame = CFgo})
    
    local tweenfunc = {}

    function tweenfunc:Stop()
        if tween then
            tween:Cancel()
        end
    end

    function tweenfunc:Play()
        if tween then
            tween:Play()
        end
    end

    tween:Play()
    return tweenfunc
end

-- Equip Tool
function EquipTool(ToolSe)
    -- Kiểm tra đầu vào
    if not ToolSe then
        warn("No tool name provided")
        return
    end

    local player = game.Players.LocalPlayer
    
    -- Kiểm tra tồn tại player
    if not player then
        warn("LocalPlayer not found")
        return
    end

    -- Kiểm tra backpack
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then
        warn("Backpack not found")
        return
    end

    -- Tìm tool
    local tool = backpack:FindFirstChild(ToolSe)
    if tool then
        -- Sử dụng task.delay thay vì wait
        task.delay(0.5, function()
            local character = player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            
            if humanoid then
                humanoid:EquipTool(tool)
            end
        end)
    else
        warn("Tool not found in backpack: " .. tostring(ToolSe))
    end
end

-- Aimbot Mastery (Cải tiến)
local function setupAimbotMastery()
    local metatable = getrawmetatable(game)
    local oldNamecall = metatable.__namecall
    
    setreadonly(metatable, false)
    
    metatable.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        
        -- Kiểm tra điều kiện FireServer
        if method == "FireServer" then
            if _G.UseSkill then
                -- Kiểm tra RemoteEvent và vị trí kỹ năng
                if args[1] == "RemoteEvent" and 
                   args[2] ~= "true" and 
                   args[2] ~= "false" then
                    
                    -- Điều chỉnh vị trí kỹ năng
                    if type(args[2]) == "vector" then
                        args[2] = PositionSkillMasteryDevilFruit
                    else
                        args[2] = CFrame.new(PositionSkillMasteryDevilFruit)
                    end
                end
            end
        end
        
        return oldNamecall(unpack(args))
    end)
    
    setreadonly(metatable, true)
end

-- Gọi hàm setup
spawn(setupAimbotMastery)

    --aimbot mastery
local function setupAimbotMastery()
    -- Kiểm tra và bảo vệ môi trường
    local success, metatable = pcall(getrawmetatable, game)
    if not success or not metatable then
        warn("[AimbotMastery] Cannot get game metatable")
        return
    end

    -- Lưu trữ phương thức gốc
    local oldNamecall = metatable.__namecall

    -- Đảm bảo an toàn khi thao tác
    local function safeNamecall(...)
        local method = getnamecallmethod()
        local args = {...}

        -- Kiểm tra điều kiện chi tiết
        local isValidFireServer = 
            method == "FireServer" and 
            #args >= 2 and 
            tostring(args[1]) == "RemoteEvent" and
            tostring(args[2]) ~= "true" and 
            tostring(args[2]) ~= "false"

        -- Kiểm tra kích hoạt kỹ năng
        if isValidFireServer and _G.UseSkill then
            -- Kiểm tra và điều chỉnh vị trí
            if type(args[2]) == "vector" then
                args[2] = PositionSkillMasteryDevilFruit or args[2]
            elseif typeof(args[2]) == "CFrame" then
                args[2] = CFrame.new(PositionSkillMasteryDevilFruit or args[2].Position)
            end
        end

        -- Gọi phương thức gốc
        return oldNamecall(unpack(args))
    end

    -- Chuẩn bị thay đổi metatable
    setreadonly(metatable, false)
    
    -- Áp dụng phương thức mới
    metatable.__namecall = newcclosure(safeNamecall)
    
    -- Khóa lại để bảo vệ
    setreadonly(metatable, true)
end

-- Hàm kích hoạt an toàn
local function initializeAimbotMastery()
    -- Sử dụng xpcall để bắt lỗi
    xpcall(
        setupAimbotMastery, 
        function(err)
            warn("[AimbotMastery] Initialization error: " .. tostring(err))
        end
    )
end

-- Chạy trong một luồng riêng
spawn(initializeAimbotMastery)


-- [Body Gyro]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function setupBodyGyro()
    -- Danh sách các trạng thái tự động được rút gọn
    local autoStates = {
        "TeleportIsland", "TeleportPly", "SailBoat", "AutoBuyBoat", 
        "DriveMytic", "PirateShip", "AutoLevel", "AutoFarmNoQuest", 
        "AutoFarmSelectMonsterQuest", "AutoFarmSelectMonsterNoQuest", 
        "AutoFarmSelectArea", "AutoSecondSea", "AutoThirdSea", 
        "AutoAllBoss", "BossRaid", "AutoBoss", "AutoFarmBossQuest",
        "AutoDeathStep", "AutoSuperhuman", "AutoSharkman", 
        "AutoElectricClaw", "AutoDragonTalon", "AutoGodhuman",
        "AutoMasGun", "AutoMasDevilFruit", "AutoRengoku", 
        "AutoBuddySword", "AutoPole", "AutoHallowSycthe",
        "Auto_Holy_Torch", "FindMirageIsland", "AutoMirageIsland", 
        "AutoQuestRace", "AutoFishCrew", "AutoShark", "AutoSeaBeast", 
        "AutoTerrorshark", "farmpiranya", "Tweenfruit", "AutoCakeV2", 
        "AutoCakeV2V2", "AutoFarmAcient", "Auto_Law", "AutoTushita",
        "AutoMaterial", "Auto_Quest_Yama_1", "Auto_Quest_Yama_2", 
        "Auto_Quest_Yama_3", "Auto_Quest_Tushita_1", 
        "Auto_Quest_Tushita_2", "Auto_Quest_Tushita_3",
        "AutoKillPlayerMelee", "AutoKillPlayerGun", "AutoKillPlayerFruit",
        "AutoDungeon", "AutoNextIsland", "AutoAdvanceDungeon",
        "AutoHolyTorch", "AutoTorch", "UseSkill", "Clip2", "AutoBone", 
        "AutoNear", "GrabChest", "AutoRainbowHaki", "AutoSaber", 
        "AutoFarmKen", "AutoKenHop", "AutoKenV2", "Factory", 
        "SwanGlasses", "Ectoplasm", "AutoBartilo", "AutoEvoRace", 
        "BringChestz", "BringFruitz", "AutoCitizen", "AutoElite", 
        "CakePrince", "AutoSoulGuitar", "Auto_Cursed_Dual_Katana", 
        "Auto_Serpent_Bow", "AutoCavander", "AutoDarkDagger"
    }

    local function isAnyAutoStateActive()
        for _, state in ipairs(autoStates) do
            if _G[state] then
                return true
            end
        end
        return false
    end

    local function setupBodyClip()
        local character = LocalPlayer.Character
        if not character then return end

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        local existingBodyClip = humanoidRootPart:FindFirstChild("BodyClip")

        if isAnyAutoStateActive() then
            if not existingBodyClip then
                local bodyClip = Instance.new("BodyVelocity")
                bodyClip.Name = "BodyClip"
                bodyClip.Parent = humanoidRootPart
                bodyClip.MaxForce = Vector3.new(400000, 400000, 400000)
                bodyClip.Velocity = Vector3.new(0, 0, 0)
            end
        else
            if existingBodyClip then
                existingBodyClip:Destroy()
            end
        end
    end

    local function mainLoop()
        while task.wait(0.1) do
            pcall(setupBodyClip)
        end
    end

    spawn(function()
        if not LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Wait()
        end
        mainLoop()
    end)
end

-- Khởi tạo _G với các trạng thái mặc định
for _, state in ipairs({
    "TeleportIsland", "TeleportPly", "SailBoat", "AutoBuyBoat", 
    "DriveMytic", "PirateShip", "AutoLevel", "AutoFarmNoQuest",
             "AutoFarmSelectMonsterQuest", "AutoFarmSelectMonsterNoQuest", 
        "AutoFarmSelectArea", "AutoSecondSea", "AutoThirdSea", 
        "AutoAllBoss", "BossRaid", "AutoBoss", "AutoFarmBossQuest",
        "AutoDeathStep", "AutoSuperhuman", "AutoSharkman", 
        "AutoElectricClaw", "AutoDragonTalon", "AutoGodhuman",
        "AutoMasGun", "AutoMasDevilFruit", "AutoRengoku", 
        "AutoBuddySword", "AutoPole", "AutoHallowSycthe",
        "Auto_Holy_Torch", "FindMirageIsland", "AutoMirageIsland", 
        "AutoQuestRace", "AutoFishCrew", "AutoShark", "AutoSeaBeast", 
        "AutoTerrorshark", "farmpiranya", "Tweenfruit", "AutoCakeV2", 
        "AutoCakeV2V2", "AutoFarmAcient", "Auto_Law", "AutoTushita",
        "AutoMaterial", "Auto_Quest_Yama_1", "Auto_Quest_Yama_2", 
        "Auto_Quest_Yama_3", "Auto_Quest_Tushita_1", 
        "Auto_Quest_Tushita_2", "Auto_Quest_Tushita_3",
        "AutoKillPlayerMelee", "AutoKillPlayerGun", "AutoKillPlayerFruit",
        "AutoDungeon", "AutoNextIsland", "AutoAdvanceDungeon",
        "AutoHolyTorch", "AutoTorch", "UseSkill", "Clip2", "AutoBone", 
        "AutoNear", "GrabChest", "AutoRainbowHaki", "AutoSaber", 
        "AutoFarmKen", "AutoKenHop", "AutoKenV2", "Factory", 
        "SwanGlasses", "Ectoplasm", "AutoBartilo", "AutoEvoRace", 
        "BringChestz", "BringFruitz", "AutoCitizen", "AutoElite", 
        "CakePrince", "AutoSoulGuitar", "Auto_Cursed_Dual_Katana", 
        "Auto_Serpent_Bow", "AutoCavander", "AutoDarkDagger"
    -- Thêm các trạng thái khác từ danh sách autoStates
}) do
    _G[state] = false
end

-- Thêm các hàm tiện ích vào _G
_G.SetConfig = function(key, value)
    if _G[key] ~= nil then
        _G[key] = value
        print("Updated " .. key .. " to " .. tostring(value))
    else
        warn("Invalid configuration key: " .. tostring(key))
    end
end

_G.ToggleAll = function(state)
    for _, key in ipairs(autoStates) do
        _G[key] = state
    end
    print("Toggled all auto modes to: " .. tostring(state))
end

_G.ResetAll = function()
    for _, key in ipairs(autoStates) do
        _G[key] = false
    end
    print("Reset all auto modes to false")
end

-- Chạy hàm thiết lập
setupBodyGyro()

-- Các dòng bạn đã có
setupBodyGyro()

-- Thêm các dòng sau
local function safeSetup()
    pcall(function()
        if not LocalPlayer then
            Players.PlayerAdded:Wait()
            LocalPlayer = Players.LocalPlayer
        end
        setupBodyGyro()
    end)
end

-- Chạy setup an toàn
safeSetup()

-- Tùy chọn: Xử lý khi người chơi thay đổi
Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then
        safeSetup()
    end
end)


--No CLip Auto Farm
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            local autoStates = {
                "TeleportIsland", "SailBoat", "Auto_Holy_Torch", "Tweenfruit", 
                "FindMirageIsland", "TeleportPly", "AutoFishCrew", "AutoShark", 
                "AutoMysticIsland", "AutoCakeV2", "AutoQuestRace", "AutoBuyBoat", 
                "dao", "AutoFarmAcient", "AutoMirage", "Auto_Law", 
                "AutoAllBoss", "AutoHolyTorch", "AutoTushita", "farmpiranya", 
                "AutoTerrorshark", "AutoNear", "AutoCakeV2V2", "PirateShip", 
                "AutoSeaBeast", "DriveMytic", "BossRaid", "GrabChest", 
                "AutoCitizen", "Ectoplasm", "AutoEvoRace", "AutoBartilo", 
                "AutoFactory", "BringChestz", "BringFruitz", "AutoLevel", 
                "Clip2", "AutoFarmNoQuest", "AutoBone", "AutoFarmSelectMonsterQuest", 
                "AutoFarmSelectMonsterNoQuest", "AutoBoss", "AutoFarmBossQuest", 
                "AutoFarmMasGun", "AutoFarmMasDevilFruit", "AutoFarmSelectArea", 
                "AutoSecondSea", "AutoThirdSea", "AutoDeathStep", "AutoSuperhuman", 
                "AutoSharkman", "AutoElectricClaw", "AutoDragonTalon", "AutoGodhuman", 
                "AutoRengoku", "AutoBuddySword", "AutoPole", "AutoHallowSycthe", 
                "AutoCavander", "AutoTushita", "AutoDarkDagger", "CakePrince", 
                "AutoElite", "AutoRainbowHaki", "AutoSaber", "AutoFarmKen", 
                "AutoKenHop", "AutoKenV2", "AutoKillPlayerMelee", "AutoKillPlayerGun", 
                "AutoKillPlayerFruit", "AutoDungeon", "AutoNextIsland", 
                "AutoAdvanceDungeon", "Musketeer", "RipIndra", "Auto_Serpent_Bow", 
                "AutoTorch", "AutoSoulGuitar", "Auto_Cursed_Dual_Katana", 
                "AutoMaterial", "Auto_Quest_Yama_1", "Auto_Quest_Yama_2", 
                "Auto_Quest_Yama_3", "Auto_Quest_Tushita_1", "Auto_Quest_Tushita_2", 
                "Auto_Quest_Tushita_3", "Factory", "SwanGlasses"
            }

            local function isAnyAutoStateActive()
                for _, state in ipairs(autoStates) do
                    if _G[state] or _G["_" .. state] then
                        return true
                    end
                end
                return false
            end

            local character = game.Players.LocalPlayer.Character
            if not character then return end

            if isAnyAutoStateActive() then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end)
end)


--Check Material
function CheckMaterial(matname)
    -- Kiểm tra đầu vào
    if not matname or type(matname) ~= "string" then
        warn("Invalid material name")
        return 0
    end

    -- Sử dụng pcall để xử lý lỗi
    local success, inventory = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    end)

    -- Kiểm tra kết quả gọi API
    if not success then
        warn("Failed to retrieve inventory: " .. tostring(inventory))
        return 0
    end

    -- Kiểm tra kiểu dữ liệu của inventory
    if type(inventory) ~= "table" then
        warn("Unexpected inventory data type")
        return 0
    end

    -- Tìm kiếm vật liệu
    for _, item in ipairs(inventory) do
        if type(item) == "table" and 
           item.Type == "Material" and 
           item.Name == matname then
            return item.Count or 0
        end
    end

    -- Trả về 0 nếu không tìm thấy
    return 0
end

-- Sử dụng ví dụ
local function SafeCheckMaterial(materialName)
    local count = CheckMaterial(materialName)
    print(string.format("Material '%s' count: %d", materialName, count))
    return count
end
-----------------------------------------------------------------------------------------------------------------------------------------------
--Click Camera
function ClickCamera(x, y)
    -- Kiểm tra môi trường
    local virtualUser = game:GetService("VirtualUser")
    local workspace = game:GetService("Workspace")
    local camera = workspace.Camera
    
    -- Sử dụng tham số mặc định nếu không truyền
    x = x or 851
    y = y or 158
    
    -- Thêm pcall để xử lý lỗi
    local success, err = pcall(function()
        -- Kiểm tra các dịch vụ và đối tượng
        if not virtualUser or not camera then
            error("Required services or objects not found")
        end
        
        -- Capture controller
        virtualUser:CaptureController()
        
        -- Click với Vector2 an toàn
        virtualUser:ClickButton1(
            Vector2.new(math.floor(x), math.floor(y)), 
            camera.CFrame
        )
    end)
    
    -- Xử lý lỗi nếu có
    if not success then
        warn("ClickCamera error: " .. tostring(err))
    end
end

-- Sử dụng ví dụ
local function SafeClickCamera()
    -- Thêm độ trễ ngẫu nhiên để tránh anti-cheat
    task.wait(math.random(10, 50) / 100)
    ClickCamera()
end

------AttackNoCD

local plr = game.Players.LocalPlayer
local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade() 
    local success, result = pcall(function()
        local p13 = CbFw2.activeController
        if not p13 or not p13.blades then return nil end
        
        local ret = p13.blades[1]
        if not ret then return nil end
        
        while ret.Parent ~= game.Players.LocalPlayer.Character do 
            ret = ret.Parent 
            if not ret then return nil end
        end
        
        return ret
    end)
    
    if success then 
        return result 
    else
        warn("Error in GetCurrentBlade: " .. tostring(result))
        return nil
    end
end

function AttackNoCD()
    -- Check if farming conditions are met
    if AutoFarmMasDevilFruit or AutoFarmMasGun or Auto_Raid then 
        return 
    end
    
    local success, err = pcall(function()
        local AC = CbFw2.activeController
        if not AC or not AC.attack then return end
        
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            plr.Character,
            {plr.Character.HumanoidRootPart},
            60
        )
        
        local cac = {}
        local hash = {}
        for k, v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                table.insert(cac, v.Parent.HumanoidRootPart)
                hash[v.Parent] = true
            end
        end
        bladehit = cac
        
        if #bladehit > 0 then
            -- Get upvalues for attack manipulation
            local u8 = debug.getupvalue(AC.attack, 5)
            local u9 = debug.getupvalue(AC.attack, 6)
            local u7 = debug.getupvalue(AC.attack, 4)
            local u10 = debug.getupvalue(AC.attack, 7)
            
            -- Calculate attack parameters
            local u12 = (u8 * 798405 + u7 * 727595) % u9
            local u13 = u7 * 798405
            
            -- Update attack values
            u12 = (u12 * u9 + u13) % 1099511627776
            u8 = math.floor(u12 / u9)
            u7 = u12 - u8 * u9
            u10 = u10 + 1
            
            -- Set updated upvalues
            debug.setupvalue(AC.attack, 5, u8)
            debug.setupvalue(AC.attack, 6, u9)
            debug.setupvalue(AC.attack, 4, u7)
            debug.setupvalue(AC.attack, 7, u10)
            
            -- Perform attack
            local currentBlade = GetCurrentBlade()
            if currentBlade and plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
                AC.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
                
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
                    "weaponChange", 
                    tostring(currentBlade)
                )
                
                game.ReplicatedStorage.Remotes.Validator:FireServer(
                    math.floor(u12 / 1099511627776 * 16777215), 
                    u10
                )
                
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
                    "hit", 
                    bladehit, 
                    1, 
                    ""
                )
            end
        end
    end)
    
    if not success then
        warn("Error in AttackNoCD: " .. tostring(err))
    end
end

--Attack Mastery
function NormalAttack()
    -- Kiểm tra điều kiện trước khi thực hiện
    if _G.NormalAttack then return end
    
    local success, err = pcall(function()
        -- An toàn hơn khi require module
        local plr = game.Players.LocalPlayer
        local Module = plr and plr.PlayerScripts and plr.PlayerScripts:FindFirstChild("CombatFramework")
        
        if not Module then 
            warn("CombatFramework module not found")
            return 
        end
        
        local ModuleRequire = require(Module)
        local CombatFramework = debug.getupvalues(ModuleRequire)[2]
        
        -- Kiểm tra tính hợp lệ của CombatFramework
        if not CombatFramework or not CombatFramework.activeController then
            warn("Invalid CombatFramework structure")
            return
        end
        
        -- Disable camera shake for smoother experience
        local CamShake = require(game.ReplicatedStorage.Util.CameraShaker)
        if CamShake and CamShake.Stop then
            pcall(function() CamShake:Stop() end)
        end
        
        -- Reset attack controller
        local activeController = CombatFramework.activeController
        activeController.attacking = false
        activeController.timeToNextAttack = 0
        activeController.hitboxMagnitude = 180
        
        -- Virtual user attack with error handling
        local VirtualUser = game:GetService('VirtualUser')
        if VirtualUser then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(1280, 672))
            end)
        end
    end)
    
    -- Ghi log lỗi nếu có
    if not success then
        warn("Error in NormalAttack: " .. tostring(err))
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------

-- [Remove Effect]
spawn(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    
    -- Danh sách các hiệu ứng cần xóa
    local effectsToRemove = {
        "CurvedRing", 
        "SlashHit", 
        "SwordSlash", 
        "SlashTail"
    }
    
    -- Tối ưu hóa việc kiểm tra và xóa hiệu ứng
    while task.wait(0.1) do  -- Thay đổi từ wait() sang task.wait() để hiệu quả hơn
        local worldOrigin = Workspace["_WorldOrigin"]
        
        -- Kiểm tra worldOrigin tồn tại
        if not worldOrigin then 
            warn("WorldOrigin not found in Workspace")
            break 
        end
        
        for _, v in ipairs(worldOrigin:GetChildren()) do
            -- Sử dụng ipairs và kiểm tra nhanh hơn
            if table.find(effectsToRemove, v.Name) then
                pcall(function()
                    v:Destroy()
                end)
            end
        end
    end
end)

-- Nâng cấp xử lý hiệu ứng chết và hồi sinh
local function removeEffects()
    local success, err = pcall(function()
        local effectContainer = game:GetService("ReplicatedStorage").Effect.Container
        
        -- Kiểm tra tồn tại container
        if not effectContainer then
            warn("Effect Container not found")
            return
        end
        
        -- Xóa hiệu ứng chết
        local deathEffect = effectContainer:FindFirstChild("Death")
        if deathEffect then
            deathEffect:Destroy()
        end
        
        -- Xóa hiệu ứng hồi sinh
        local respawnEffect = effectContainer:FindFirstChild("Respawn")
        if respawnEffect then
            respawnEffect:Destroy()
        end
    end)
    
    -- Xử lý lỗi nếu có
    if not success then
        warn("Error removing death/respawn effects: " .. tostring(err))
    end
end

-- Sử dụng biến môi trường an toàn hơn
local NoDieEffect = true  -- Thay đổi getgenv() để giảm thiểu rủi ro
if NoDieEffect then
    removeEffects()
end


-- [remove effect Combat]
local function SafeRequire(path, maxAttempts)
    maxAttempts = maxAttempts or 3
    local attempts = 0
    
    while attempts < maxAttempts do
        local success, module = pcall(function()
            return require(path)
        end)
        
        if success and module then
            return module
        end
        
        attempts = attempts + 1
        warn(string.format("Require attempt %d failed for %s", attempts, tostring(path)))
        task.wait(0.5)  -- Chờ một chút trước khi thử lại
    end
    
    error(string.format("Failed to require module after %d attempts", maxAttempts))
end

local function SafeGetUpvalues(module)
    local success, upvalues = pcall(debug.getupvalues, module)
    
    if success and type(upvalues) == "table" and #upvalues > 0 then
        return upvalues
    else
        warn("Failed to get upvalues for module")
        return {}
    end
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function InitializeCombatFramework()
    local LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then 
        error("LocalPlayer not found")
        return nil 
    end

    local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts", 10)
    if not PlayerScripts then
        error("PlayerScripts not found")
        return nil
    end

    local combatFrameworkModule = PlayerScripts:FindFirstChild("CombatFramework")
    local rigControllerModule = combatFrameworkModule and combatFrameworkModule:FindFirstChild("RigController")

    if not combatFrameworkModule or not rigControllerModule then
        error("Required modules not found")
        return nil
    end

    local CombatFramework = SafeRequire(combatFrameworkModule)
    local RigController = SafeRequire(rigControllerModule)

    local CombatFrameworkR = SafeGetUpvalues(CombatFramework)[2]
    local RigControllerR = SafeGetUpvalues(RigController)[2]
    local RealBHit = SafeRequire(ReplicatedStorage.CombatFramework.RigLib)

    return {
        CombatFramework = CombatFramework,
        CombatFrameworkR = CombatFrameworkR,
        RigController = RigController,
        RigControllerR = RigControllerR,
        RealBHit = RealBHit,
        CooldownFastAttack = tick()
    }
end

-- Cách sử dụng
local combatData = InitializeCombatFramework()

-- Kiểm tra và sử dụng
if combatData then
    -- Bạn có thể truy cập các giá trị như:
    -- local cooldownFastAttack = combatData.CooldownFastAttack
else
    warn("Failed to initialize Combat Framework")
end

--Sword Weapon
local function GetWeaponInventory(weaponName)
    -- Kiểm tra đầu vào
    if not weaponName or type(weaponName) ~= "string" then
        warn("Invalid weapon name provided")
        return false
    end

    -- Xử lý an toàn khi gọi remote
    local success, inventory = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    end)

    -- Kiểm tra kết quả gọi remote
    if not success then
        warn("Failed to retrieve inventory: " .. tostring(inventory))
        return false
    end

    -- Kiểm tra tính hợp lệ của inventory
    if type(inventory) ~= "table" then
        warn("Inventory is not a valid table")
        return false
    end

    -- Tối ưu hóa việc tìm kiếm
    for _, item in ipairs(inventory) do
        -- Kiểm tra đầy đủ điều kiện
        if type(item) == "table" 
           and item.Type == "Sword" 
           and item.Name == weaponName then
            return true
        end
    end

    return false
end

-- Phiên bản nâng cao hơn với cache và tối ưu
local WeaponInventoryCache = {}
local function GetWeaponInventoryAdvanced(weaponName, forceRefresh)
    -- Kiểm tra đầu vào
    if not weaponName or type(weaponName) ~= "string" then
        warn("Invalid weapon name provided")
        return false
    end

    -- Sử dụng cache nếu không yêu cầu refresh
    if not forceRefresh and WeaponInventoryCache[weaponName] ~= nil then
        return WeaponInventoryCache[weaponName]
    end

    -- Xử lý an toàn khi gọi remote
    local success, inventory = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    end)

    -- Kiểm tra kết quả gọi remote
    if not success then
        warn("Failed to retrieve inventory: " .. tostring(inventory))
        return false
    end

    -- Kiểm tra tính hợp lệ của inventory
    if type(inventory) ~= "table" then
        warn("Inventory is not a valid table")
        return false
    end

    -- Tìm kiếm và cache kết quả
    for _, item in ipairs(inventory) do
        if type(item) == "table" 
           and item.Type == "Sword" 
           and item.Name == weaponName then
            WeaponInventoryCache[weaponName] = true
            return true
        end
    end

    -- Cache kết quả false
    WeaponInventoryCache[weaponName] = false
    return false
end

-- Cách sử dụng
local hasWeapon = GetWeaponInventory("ExampleSword")
print(hasWeapon)

-- Sử dụng phiên bản nâng cao
local hasWeaponAdvanced = GetWeaponInventoryAdvanced("ExampleSword")
print(hasWeaponAdvanced)

-- Refresh cache nếu cần
local forceRefreshResult = GetWeaponInventoryAdvanced("ExampleSword", true)


---Method Wait Mob
local Type11 = 1
local Pos2 = CFrame.new(0, 0, 0)

-- Sử dụng task.spawn để quản lý luồng tốt hơn
local function PositionUpdater()
    while task.wait(0.1) do
        if Type11 == 1 then
            Pos2 = CFrame.new(120, 60, 0)
        elseif Type11 == 2 then
            Pos2 = CFrame.new(-120, 60, 0)
        end
    end
end

local function TypeCycler()
    while task.wait(0.1) do
        Type11 = 1
        task.wait(2)
        Type11 = 2
        task.wait(2)
    end
end

-- Quản lý luồng an toàn
local function StartThreads()
    local threads = {
        task.spawn(PositionUpdater),
        task.spawn(TypeCycler)
    }
    
    -- Có thể thêm logic dừng luồng nếu cần
    return threads
end

-- Bắt đầu các luồng
local activeThreads = StartThreads()


---Method Farm
local Type = 1  -- Khởi tạo biến Type
local Pos = CFrame.new(0, 0, 0)  -- Khởi tạo Pos với giá trị mặc định

-- Bảng ánh xạ vị trí để dễ dàng mở rộng và bảo trì
local POSITION_MAPPING = {
    [1] = CFrame.new(0, 60, 0),
    [2] = CFrame.new(-30, 0, -30),
    [3] = CFrame.new(0, 0, -60),
    [4] = CFrame.new(-60, 0, 0)
}

-- Hàm an toàn để spawn thread
local function SafeSpawn(func)
    return task.spawn(function()
        local success, err = pcall(func)
        if not success then
            warn("Error in spawned function: " .. tostring(err))
        end
    end)
end

-- Hàm cập nhật vị trí
local function UpdatePosition()
    while task.wait(0.1) do
        -- Sử dụng bảng ánh xạ để lấy vị trí
        Pos = POSITION_MAPPING[Type] or CFrame.new(0, 0, 0)
    end
end

-- Hàm chu kỳ Type
local function CycleType()
    while task.wait(0.1) do
        -- Chu kỳ tuần tự các Type
        for i = 1, 4 do
            Type = i
            task.wait(1)  -- Chờ 1 giây giữa các Type
        end
    end
end

-- Quản lý và khởi động các thread
local function StartPositionThreads()
    local threads = {
        task.spawn(UpdatePosition),
        task.spawn(CycleType)
    }
    return threads
end

-- Khởi động các thread
local activeThreads = StartPositionThreads()

-- Hàm để dừng các thread nếu cần
local function StopThreads(threads)
    for _, thread in ipairs(threads) do
        task.cancel(thread)
    end
end

-- Ví dụ sử dụng nâng cao
local function AdvancedPositionControl()
    -- Thêm logic điều khiển vị trí tùy chỉnh
    while task.wait(1) do
        -- Ví dụ: Thay đổi Type động
        if someCondition then
            Type = math.random(1, 4)
        end
    end
end

-- Có thể thêm thread điều khiển nâng cao
local advancedThread = task.spawn(AdvancedPositionControl)
--auto turn haki
  function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end
---Bypass Teleport
--made DelK
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function SafeBTP(p)
    local player = Players.LocalPlayer
    if not player or not player.Character then return end

    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end

    -- Kiểm tra điều kiện di chuyển
    local shouldMove = pcall(function()
        local distance = (p.Position - rootPart.Position).Magnitude
        return distance >= 2000 and 
               humanoid.Health > 0 and 
               not _G.Auto_Raid  -- Giả sử biến global
    end)

    if not shouldMove then return end

    -- Bảng ánh xạ điểm đến đặc biệt
    local specialLocations = {
        ["FishmanQuest"] = Vector3.new(61163.8515625, 11.6796875, 1819.7841796875),
        ["God's Guard"] = Vector3.new(-4607.82275, 872.54248, -1667.55688),
        ["SkyExp1Quest"] = Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047),
        ["ShipQuest1"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        ["ShipQuest2"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        ["FrostQuest"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    }

    -- Xử lý các địa điểm đặc biệt
    local function handleSpecialLocation(locationName)
        local specialLocation = specialLocations[locationName]
        if specialLocation then
            -- Tween đến vị trí hiện tại
            if typeof(Tween) == "function" then
                Tween(rootPart.CFrame)
            end
            
            task.wait(0.1)
            
            -- Gọi remote để vào khu vực
            ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", specialLocation)
            return true
        end
        return false
    end

    -- Xử lý di chuyển chính
    local function moveToPosition()
        local attempts = 0
        local maxAttempts = 5

        while attempts < maxAttempts do
            -- Thay đổi trạng thái Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            
            -- Di chuyển
            rootPart.CFrame = p
            task.wait(0.1)

            -- Kiểm tra khoảng cách
            local currentDistance = (p.Position - rootPart.Position).Magnitude
            if currentDistance < 2500 then
                return true
            end

            attempts = attempts + 1
            task.wait(0.5)
        end

        return false
    end

    -- Thực thi di chuyển
    local success, result = pcall(function()
        -- Kiểm tra và xử lý địa điểm đặc biệt
        if typeof(_G.NameMon) == "string" and handleSpecialLocation(_G.NameMon) then
            return true
        end

        -- Di chuyển thông thường
        return moveToPosition()
    end)

    if not success then
        warn("BTP Error: " .. tostring(result))
    end
end

-- Wrapper để tương thích với code cũ
function BTP(p)
    SafeBTP(p)
end

-----------------------------------------------------------------------------------------------------------------------------------

---Close gui
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function CreateDraggableButton()
    -- Tạo các Instance
    local ScreenGui = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

    -- Cấu hình ScreenGui
    ScreenGui.Name = "CustomDraggableButton"
    ScreenGui.Parent = Players.LocalPlayer.PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Cấu hình ImageButton
    ImageButton.Parent = ScreenGui
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageButton.Position = UDim2.new(0.10615778, 0, 0.16217947, 0)
    ImageButton.Size = UDim2.new(0.0627121851, 0, 0.107579626, 0)
    ImageButton.Image = "rbxassetid://15970725955"

    -- Cấu hình UICorner
    UICorner.CornerRadius = UDim.new(0, 30)
    UICorner.Parent = ImageButton

    -- Cấu hình UIGradient
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(244, 0, 0)), 
        ColorSequenceKeypoint.new(0.32, Color3.fromRGB(146, 255, 251)), 
        ColorSequenceKeypoint.new(0.65, Color3.fromRGB(180, 255, 255)), 
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(96, 255, 231))
    }
    UIGradient.Parent = ImageButton

    -- Cấu hình UIAspectRatioConstraint
    UIAspectRatioConstraint.Parent = ImageButton
    UIAspectRatioConstraint.AspectRatio = 0.988

    -- Hàm xoay gradient
    local function AnimateGradient()
        local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
        local tween = TweenService:Create(UIGradient, tweenInfo, {Rotation = 360})
        tween:Play()
    end

    -- Hàm kéo thả button
    local function MakeDraggable()
        local dragToggle = false
        local dragStart = nil
        local startPos = nil

        local function UpdateDrag(input)
            local delta = input.Position - dragStart
            local newPosition = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
            
            TweenService:Create(ImageButton, TweenInfo.new(0.1), {Position = newPosition}):Play()
        end

        ImageButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or 
               input.UserInputType == Enum.UserInputType.Touch then
                dragToggle = true
                dragStart = input.Position
                startPos = ImageButton.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or 
                input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
                UpdateDrag(input)
            end
        end)
    end

    -- Xử lý sự kiện click
    local function HandleClick()
        ImageButton.MouseButton1Click:Connect(function()
            -- Gửi sự kiện phím End
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.End, false, game)
        end)
    end

    -- Khởi chạy các chức năng
    AnimateGradient()
    MakeDraggable()
    HandleClick()

    return ScreenGui
end

-- Gọi hàm tạo button
local CustomButton = CreateDraggableButton()
--------------------------------------------------------------------------------------------------------------------------------------------
-- KKK
--------------------------------------------------------------------------------------------------------------------------------------------
--Create Tabs
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function SetupFarmingTab(Tabs)
    -- Danh sách chế độ tấn công
    local listFastAttack = {
        'Normal Attack', 
        'Fast Attack', 
        'Super Fast Attack'
    }

    -- Dropdown chọn chế độ tấn công
    local DropdownDelayAttack = Tabs.Main:AddDropdown("DropdownDelayAttack", {
        Title = "Select Fast Attack",
        Values = listFastAttack,
        Multi = false,
        Default = 1,
    })

    -- Cấu hình delay tấn công
    DropdownDelayAttack:SetValue("Fast Attack")
    DropdownDelayAttack:OnChanged(function(Value)
        _G.FastAttackFaiFao_Mode = Value
        _G.Fast_Delay = ({
            ["Fast Attack"] = 0.5,
            ["Normal Attack"] = 0.25,
            ["Super Fast Attack"] = 0.05
        })[Value] or 0.15
    end)

    -- Dropdown chọn vũ khí
    local DropdownSelectWeapon = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
        Title = "Weapon",
        Values = {'Melee', 'Sword', 'Blox Fruit'},
        Multi = false,
        Default = 1,
    })

    local ChooseWeapon = 'Melee'
    local SelectWeapon = nil

    DropdownSelectWeapon:SetValue('Melee')
    DropdownSelectWeapon:OnChanged(function(Value)
        ChooseWeapon = Value
    end)

    -- Hàm chọn vũ khí tối ưu
    local function SelectWeaponOptimized()
        local weaponType = ({
            ["Melee"] = "Melee",
            ["Sword"] = "Sword",
            ["Blox Fruit"] = "Blox Fruit"
        })[ChooseWeapon] or "Melee"

        for _, weapon in pairs(LocalPlayer.Backpack:GetChildren()) do
            if weapon.ToolTip == weaponType then
                SelectWeapon = weapon.Name
                return
            end
        end
    end

    -- Luồng chọn vũ khí liên tục
    task.spawn(function()
        while task.wait(1) do
            pcall(SelectWeaponOptimized)
        end
    end)

    -- Toggle Auto Level
    local ToggleLevel = Tabs.Main:AddToggle("ToggleLevel", {
        Title = "Auto Level", 
        Default = false 
    })

    ToggleLevel:OnChanged(function(Value)
        _G.AutoLevel = Value
    end)
    Options.ToggleLevel:SetValue(false)

    -- Hàm nâng cấp Auto Farm
    local function AdvancedAutoFarm()
        if not _G.AutoLevel then return end

        pcall(function()
            local QuestGui = LocalPlayer.PlayerGui.Main.Quest
            local QuestTitle = QuestGui.Container.QuestTitle.Title.Text

            -- Kiểm tra và bỏ nhiệm vụ cũ
            if not string.find(QuestTitle, NameMon) or not QuestGui.Visible then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                
                -- Teleport đến vị trí nhiệm vụ
                if BypassTP and (Character.HumanoidRootPart.Position - CFrameQ.Position).Magnitude > 2500 then
                    BTP(CFrameQ)
                else
                    Tween(CFrameQ)
                end

                -- Bắt đầu nhiệm vụ
                if (CFrameQ.Position - Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                end
            else
                -- Tìm và tiêu diệt quái
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if enemy.Name == Ms and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        -- Các hàm hỗ trợ chiến đấu
                        AttackNoCD()
                        AutoHaki()
                        EquipTool(SelectWeapon)

                        -- Di chuyển và vô hiệu hóa quái
                        Tween(enemy.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                        enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        enemy.HumanoidRootPart.Transparency = 1
                        enemy.Humanoid.WalkSpeed = 0
                        enemy.HumanoidRootPart.CanCollide = false

                        break
                    end
                end
            end
        end)
    end

    -- Luồng Auto Farm
    task.spawn(function()
        while task.wait() do
            AdvancedAutoFarm()
        end
    end)
end

-- Gọi hàm setup
SetupFarmingTab(Tabs)


--------------------------------------------------------------------------------------------------------------------------------------------

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function SetupMobAuraAndUtilities(Tabs)
    -- Mob Aura Toggle
    local ToggleMobAura = Tabs.Main:AddToggle("ToggleMobAura", {
        Title = "Kill Near / Mob Aura", 
        Default = false 
    })

    ToggleMobAura:OnChanged(function(Value)
        _G.AutoNear = Value
    end)
    Options.ToggleMobAura:SetValue(false)

    -- Nâng cấp Mob Aura
    local function AdvancedMobAura()
        if not _G.AutoNear then return end

        pcall(function()
            for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                -- Kiểm tra điều kiện quái
                if enemy:FindFirstChild("Humanoid") and 
                   enemy:FindFirstChild("HumanoidRootPart") and 
                   enemy.Humanoid.Health > 0 then
                    
                    local distance = (Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                    
                    -- Giới hạn khoảng cách
                    if distance <= 5000 then
                        repeat 
                            task.wait(_G.Fast_Delay)
                            
                            -- Các hàm hỗ trợ chiến đấu
                            AttackNoCD()
                            AutoHaki()
                            EquipTool(SelectWeapon)
                            
                            -- Di chuyển và vô hiệu hóa quái
                            Tween(enemy.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                            
                            enemy.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                            enemy.HumanoidRootPart.Transparency = 1
                            enemy.Humanoid.WalkSpeed = 0
                            enemy.HumanoidRootPart.CanCollide = false
                            
                            FarmPos = enemy.HumanoidRootPart.CFrame
                            MonFarm = enemy.Name
                        until not _G.AutoNear or 
                              not enemy.Parent or 
                              enemy.Humanoid.Health <= 0 or 
                              not Workspace.Enemies:FindFirstChild(enemy.Name)
                    end
                end
            end
        end)
    end

    -- Luồng Mob Aura
    task.spawn(function()
        while task.wait(0.1) do
            AdvancedMobAura()
        end
    end)

    -- Nâng cấp Redeem Code
    local CodeList = {
        "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", 
        "Starcodeheo", "Bluxxy", "THEGREATACE", "SUB2GAMERROBOT_EXP1", 
        "StrawHatMaine", "Sub2OfficialNoobie", "SUB2NOOBMASTER123", 
        "Sub2Daigrock", "Axiore", "TantaiGaming", "STRAWHATMAINE"
    }

    local function RedeemAllCodes()
        for _, code in ipairs(CodeList) do
            pcall(function()
                ReplicatedStorage.Remotes.Redeem:InvokeServer(code)
                task.wait(0.5)  -- Delay giữa các lần redeem
            end)
        end
    end

    Tabs.Main:AddButton({
        Title = "Redeem All Code",
        Description = "Redeem all code x2 exp",
        Callback = RedeemAllCodes
    })

    -- FPS Booster nâng cấp
    local function AdvancedFPSBooster()
        -- Cấu hình Lighting
        local settingLighting = {
            Technology = 2,
            GlobalShadows = false,
            Brightness = 0,
            FogEnd = 9e9
        }

        for prop, value in pairs(settingLighting) do
            pcall(function()
                Lighting[prop] = value
            end)
        end

        -- Cấu hình Terrain
        local terrain = Workspace.Terrain
        local terrainSettings = {
            WaterWaveSize = 0,
            WaterWaveSpeed = 0,
            WaterReflectance = 0,
            WaterTransparency = 0,
            Decoration = false
        }

        for prop, value in pairs(terrainSettings) do
            pcall(function()
                terrain[prop] = value
            end)
        end

        -- Rendering
        settings().Rendering.QualityLevel = "Level01"

        -- Tối ưu các đối tượng
        for _, v in pairs(game:GetDescendants()) do
            pcall(function()
                if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("MeshPart") then
                    v.Material = "Plastic"
                    v.Reflectance = 0
                    v.TextureID = 10385902758728957
                end
            end)
        end

        -- Vô hiệu hóa các hiệu ứng
        for _, effect in pairs(Lighting:GetChildren()) do
            pcall(function()
                if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or 
                   effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or 
                   effect:IsA("DepthOfFieldEffect") then
                    effect.Enabled = false
                end
            end)
        end
    end

    Tabs.Main:AddButton({
        Title = "Fps Booster",
        Description = "Boost your fps",
        Callback = AdvancedFPSBooster
    })
end

-- Gọi hàm setup
SetupMobAuraAndUtilities(Tabs)

--------------------------------------------------------------------------------------------------------------------------------------------
--Mastery
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function SetupMasteryFarm(Tabs)
    -- Section Mastery
    local Mastery = Tabs.Main:AddSection("Mastery Farm")

    -- Dropdown Mastery Mode
    local DropdownMastery = Tabs.Main:AddDropdown("DropdownMastery", {
        Title = "Mastery Mode",
        Values = {"Level", "Near Mobs", "Boss"},
        Multi = false,
        Default = 1,
    })

    DropdownMastery:SetValue("Level")
    local TypeMastery = "Level"

    DropdownMastery:OnChanged(function(Value)
        TypeMastery = Value
    end)

    -- Toggle Mastery Farming
    local ToggleMasteryFruit = Tabs.Main:AddToggle("ToggleMasteryFruit", {
        Title = "Auto BF Mastery", 
        Default = false 
    })
    local AutoFarmMasDevilFruit = false
    ToggleMasteryFruit:OnChanged(function(Value)
        AutoFarmMasDevilFruit = Value
    end)

    local ToggleMasteryGun = Tabs.Main:AddToggle("ToggleMasteryGun", {
        Title = "Auto Gun Mastery", 
        Default = false 
    })
    local AutoFarmMasGun = false
    ToggleMasteryGun:OnChanged(function(Value)
        AutoFarmMasGun = Value
    end)

    -- Health Slider
    local SliderHealth = Tabs.Main:AddSlider("SliderHealth", {
        Title = "Health (%) Mob",
        Description = "Percentage of health to start skill",
        Default = 25,
        Min = 0,
        Max = 100,
        Rounding = 1,
    })
    local KillPercent = 25
    SliderHealth:OnChanged(function(Value)
        KillPercent = Value
    end)

    -- Advanced Mastery Farming Function
    local function AdvancedMasteryFarm()
        local function FarmDevilFruitMastery()
            if not AutoFarmMasDevilFruit then return end

            pcall(function()
                CheckLevel(SelectMonster)
                
                -- Quest Management
                local QuestGui = LocalPlayer.PlayerGui.Main.Quest
                if not string.find(QuestGui.Container.QuestTitle.Title.Text, NameMon) or not QuestGui.Visible then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                    
                    -- Teleport Logic
                    if BypassTP and (Character.HumanoidRootPart.Position - CFrameQ.Position).Magnitude > 2500 then
                        BTP(CFrameQ)
                    else
                        Tween(CFrameQ)
                    end

                    if (CFrameQ.Position - Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                else
                    -- Enemy Farming
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Name == Ms then
                            local healthPercentage = enemy.Humanoid.Health / enemy.Humanoid.MaxHealth * 100
                            
                            if healthPercentage <= KillPercent then
                                _G.UseSkill = true
                                EquipDevilFruit()
                                UseDevilFruitSkills(enemy)
                            else
                                _G.UseSkill = false
                                NormalFarmingLogic(enemy)
                            end
                        end
                    end
                end
            end)
        end

        local function FarmGunMastery()
            if not AutoFarmMasGun then return end

            pcall(function()
                -- Similar structure to Devil Fruit Mastery, but for Gun
                -- Implement gun-specific farming logic here
            end)
        end

        -- Main Farming Loop
        task.spawn(function()
            while task.wait(0.1) do
                if TypeMastery == "Level" then
                    FarmDevilFruitMastery()
                elseif TypeMastery == "Near Mobs" then
                    FarmGunMastery()
                end
            end
        end)
    end

    -- Skill Usage Functions
    local function UseDevilFruitSkills(enemy)
        local DevilFruit = LocalPlayer.Character:FindFirstChild(LocalPlayer.Data.DevilFruit.Value)
        if not DevilFruit then return end

        local skillSequence = {
            {key = "Z", minLevel = 1},
            {key = "X", minLevel = 2},
            {key = "C", minLevel = 3},
            {key = "V", minLevel = 4},
            {key = "F", minLevel = 5}
        }

        for _, skill in ipairs(skillSequence) do
            if _G.UseSkill and DevilFruit.Level.Value >= skill.minLevel then
                VirtualInputManager:SendKeyEvent(true, skill.key, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, skill.key, false, game)
            end
        end
    end

    -- Initialize
    AdvancedMasteryFarm()
end

-- Call setup function
SetupMasteryFarm(Tabs)
---------Near Mas
    elseif AutoFarmMasDevilFruit and TypeMastery == 'Near Mobs' then
    pcall(function()
      for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
      if v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
      if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 2000 then
      repeat game:GetService("RunService").Heartbeat:wait()
      if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
      _G.UseSkill = true
      else
        _G.UseSkill = false
		AutoHaki()
      EquipTool(SelectWeapon)
      Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
      v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
      v.HumanoidRootPart.Transparency = 1
      v.Humanoid.JumpPower = 0
      v.Humanoid.WalkSpeed = 0
      v.HumanoidRootPart.CanCollide = false
  --v.Humanoid:ChangeState(11)
  --v.Humanoid:ChangeState(14)
      FarmPos = v.HumanoidRootPart.CFrame
      MonFarm = v.Name
      _G.FastAttackFaiFao = false
       NormalAttack()
      end
      until not AutoFarmMasDevilFruit or not MasteryType == 'Near Mobs' or not v.Parent or v.Humanoid.Health == 0 or not TypeMastery == 'Near Mobs'
      _G.UseSkill = false
      _G.FastAttackFaiFao = true
    end
end
end
end)
end
end
end)
	

local MiscFarm = Tabs.Main:AddSection("Misc Farm")

if Third_Sea then
local ToggleBone = Tabs.Main:AddToggle("ToggleBone", {Title = "Auto Bone", Default = false })
ToggleBone:OnChanged(function(Value)
    _G.AutoBone = Value
end)
Options.ToggleBone:SetValue(false)
local BoneCFrame = CFrame.new(-9515.75, 174.8521728515625, 6079.40625)
local BoneCFrame2 = CFrame.new(-9359.453125, 141.32679748535156, 5446.81982421875)


spawn(function()
    while wait() do
        if _G.AutoBone then
            pcall(function()
                local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                if not string.find(QuestTitle, "Demonic Soul") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    if BypassTP then
                        wait()
                       if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - BoneCFrame2.Position).Magnitude > 2500 then
                       BTP(BoneCFrame2)
                       elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - BoneCFrame.Position).Magnitude < 2500 then
                       Tween(BoneCFrame)
                       end
                 else
                         Tween(BoneCFrame)
                         end
                if (BoneCFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then    
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","HauntedQuest2",1)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                                        repeat wait(_G.Fast_Delay)
                                            AttackNoCD()
                                            AutoHaki()
                                            EquipTool(SelectWeapon)
                                                      Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
			                                v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                            v.HumanoidRootPart.Transparency = 1
                                            v.Humanoid.JumpPower = 0
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                
                                            --Click
                                        until not _G.AutoBone or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                    end
                                end
                            end
                        end
                    else
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Demonic Soul") then
                        Tween(v.HumanoidRootPart.CFrame * Pos2)
                        end
                    end
                    
                end
            end)

        end
    end
end)


local ToggleCake = Tabs.Main:AddToggle("ToggleCake", {Title = "Auto Cake Prince", Default = false })
ToggleCake:OnChanged(function(Value)
 _G.CakePrince = Value
end)
Options.ToggleCake:SetValue(false)
spawn(function()
		while wait() do
			if _G.CakePrince then
				pcall(function()
                    local CakeCFrame = CFrame.new(-2077, 252, -12373)
                    if BypassTP then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CakeCFrame.Position).Magnitude > 2000 then
                    BTP(CakeCFrame)
                    wait(3)
                    elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CakeCFrame.Position).Magnitude < 2000 then
                    Tween(CakeCFrame)
                    end
                end
					if game.ReplicatedStorage:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then   
						if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
								if v.Name == "Cake Prince" then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
										AutoHaki()
										EquipTool(SelectWeapon)
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
										v.HumanoidRootPart.CanCollide = false
										Tween(v.HumanoidRootPart.CFrame * Pos)
										--Click
									until _G.CakePrince == false or not v.Parent or v.Humanoid.Health <= 0
								end    
							end    
						else
							Tween(CFrame.new(-2009.2802734375, 4532.97216796875, -14937.3076171875)) 
						end
					else
                        if game.Workspace.Enemies:FindFirstChild("Baking Staff") or game.Workspace.Enemies:FindFirstChild("Head Baker") or game.Workspace.Enemies:FindFirstChild("Cake Guard") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter")  then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do  
                                if (v.Name == "Baking Staff" or v.Name == "Head Baker" or v.Name == "Cake Guard" or v.Name == "Cookie Crafter") and v.Humanoid.Health > 0 then
									repeat wait()
										AutoHaki()
										EquipTool(SelectWeapon)
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)  
										FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
										Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
										--Click
									until _G.CakePrince == false or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						else
							Tween(CakeCFrame)
						end
					end
				end)
			end
		end
    end)
    end
    if Second_Sea then
    local ToggleVatChatKiDi = Tabs.Main:AddToggle("ToggleVatChatKiDi", {Title = "Auto Ectoplasm", Default = false })
    ToggleVatChatKiDi:OnChanged(function(Value)
        _G.Ectoplasm = Value
    end)
    Options.ToggleVatChatKiDi:SetValue(false)

    spawn(function()
        while wait(.1) do
            pcall(function()
                if _G.Ectoplasm then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Ship Steward" or v.Name == "Ship Engineer" or v.Name == "Ship Deckhand" or v.Name == "Ship Officer" and v:FindFirstChild("Humanoid") then
                                if v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.CanCollide = false
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        --Click
                                    until _G.Ectoplasm == false or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                                end
                            end
                        end
                    else
                        local Distance = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if Distance > 20000 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                        end
                        Tween(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
                    end
                end
            end)
        end

    end)
end



local boss = Tabs.Main:AddSection("Boss Farm")


    if First_Sea then
		tableBoss = {"The Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Saber Expert"}
	elseif Second_Sea then
		tableBoss = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral","Cursed Captain","Darkbeard","Order","Awakened Ice Admiral","Tide Keeper"}
	elseif Third_Sea then
		tableBoss = {"Stone","Island Empress","Kilo Admiral","Captain Elephant","Beautiful Pirate","rip_indra True Form","Longma","Soul Reaper","Cake Queen"}
	end


    local DropdownBoss = Tabs.Main:AddDropdown("DropdownBoss", {
        Title = "Dropdown",
        Values = tableBoss,
        Multi = false,
        Default = 1,
    })

    DropdownBoss:SetValue("DauCoGhe [Lv. 5000]")
    DropdownBoss:OnChanged(function(Value)
		_G.SelectBoss = Value
    end)


	local ToggleAutoFarmBoss = Tabs.Main:AddToggle("ToggleAutoFarmBoss", {Title = "Kill Boss", Default = false })

    ToggleAutoFarmBoss:OnChanged(function(Value)
		_G.AutoBoss = Value
    end)

    Options.ToggleAutoFarmBoss:SetValue(false)
	spawn(function()
        while wait() do
            if _G.AutoBoss and BypassTP then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == _G.SelectBoss then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            
                                       --Click
									   _G.BringMob = false
                                        sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                    until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
							_G.BringMob = true
                        end
                    elseif game.ReplicatedStorage:FindFirstChild(_G.SelectBoss) then
						if ((game.ReplicatedStorage:FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
							Tween(game.ReplicatedStorage:FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame)
						else
							BTP(game.ReplicatedStorage:FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame)
					    end
						_G.BringMob = true
            
                    end
                end)
            end
        end
    end)
    
    spawn(function()
        while wait() do
            if _G.AutoBoss and not BypassTP then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == _G.SelectBoss then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                        --Click
										_G.BringMob = false
                                    until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        if game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5,10,7))
                        end
                    end
                end)
				_G.BringMob = true
            end
        end
    end)

    local Material = Tabs.Main:AddSection("Material Farm")

    if First_Sea then
        MaterialList = {
          "Scrap Metal","Leather","Angel Wings","Magma Ore","Fish Tail"
        } elseif Second_Sea then
        MaterialList = {
          "Scrap Metal","Leather","Radioactive Material","Mystic Droplet","Magma Ore","Vampire Fang"
        } elseif Third_Sea then
        MaterialList = {
          "Scrap Metal","Leather","Demonic Wisp","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"
        }
        end

    local DropdownMaterial = Tabs.Main:AddDropdown("DropdownMaterial", {
        Title = "Dropdown",
        Values = MaterialList,
        Multi = false,
        Default = 1,
    })

    DropdownMaterial:SetValue("Conjured Cocoa")

    DropdownMaterial:OnChanged(function(Value)
        SelectMaterial = Value
    end)


    local ToggleMaterial = Tabs.Main:AddToggle("ToggleMaterial", {Title = "Auto Material", Default = false })

    ToggleMaterial:OnChanged(function(Value)
        _G.AutoMaterial = Value
    end)
    Options.ToggleMaterial:SetValue(false)
    spawn(function()
        while task.wait() do
        if _G.AutoMaterial then
        pcall(function()
          MaterialMon(SelectMaterial)
          if BypassTP then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - MPos.Position).Magnitude > 3500 then
          BTP(MPos)
          elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - MPos.Position).Magnitude < 3500 then
          Tween(MPos)
          end
          else
            Tween(MPos)
          end
          if game:GetService("Workspace").Enemies:FindFirstChild(MMon) then
          for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
          if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
          if v.Name == MMon then
            repeat wait(_G.Fast_Delay)
                AttackNoCD()
          AutoHaki()
          EquipTool(SelectWeapon)
          Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
          v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
          v.HumanoidRootPart.Transparency = 1
          v.Humanoid.JumpPower = 0
          v.Humanoid.WalkSpeed = 0
          v.HumanoidRootPart.CanCollide = false
          FarmPos = v.HumanoidRootPart.CFrame
          MonFarm = v.Name
  
          --Click
          until not _G.AutoMaterial or not v.Parent or v.Humanoid.Health <= 0
          end
          end
          end
          else
            for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
          if string.find(v.Name, Mon) then
          if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude >= 10 then
          Tween(v.CFrame * CFrame.new(posX,posY,posZ))
  
          end
          end
          end
          end
          end)
        end
        end
      end)
if Third_Sea then

    local RoughSea = Tabs.Main:AddSection("Rough Sea")

    local ToggleSailBoat = Tabs.Main:AddToggle("ToggleSailBoat", {Title = "Sail Boat", Default = false })

    ToggleSailBoat:OnChanged(function(Value)
        _G.SailBoat = Value
    end)
    Options.ToggleSailBoat:SetValue(false)


    spawn(function()
        while wait() do
            pcall(function()
                if _G.SailBoat then
                    if not game:GetService("Workspace").Enemies:FindFirstChild("Shark") or not game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") or not game:GetService("Workspace").Enemies:FindFirstChild("Piranha") or not game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
                        if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                            buyb = TweenBoat(CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781))
                            if (CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                if buyb then buyb:Stop() end
                                local args = {
                                    [1] = "BuyBoat",
                                    [2] = "PirateGrandBrigade"
                                }
    
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                            if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                TweenBoat(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0,1,0))
                            else
                                for i,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                    if v.Name == "PirateGrandBrigade" then
                                        repeat wait()
                                            if (CFrame.new(-17013.80078125, 10.962434768676758, 438.0169982910156).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                                TweenShip(CFrame.new(-33163.1875, 10.964323997497559, -324.4842224121094))
                                            elseif (CFrame.new(-33163.1875, 10.964323997497559, -324.4842224121094).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                                TweenShip(CFrame.new(-37952.49609375, 10.96342945098877, -1324.12109375))
                                            elseif (CFrame.new(-37952.49609375, 10.96342945098877, -1324.12109375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                                TweenShip(CFrame.new(-33163.1875, 10.964323997497559, -324.4842224121094))
                                            end 
                                        until game:GetService("Workspace").Enemies:FindFirstChild("Shark") or game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") or game:GetService("Workspace").Enemies:FindFirstChild("Piranha") or game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") or _G.SailBoat == false
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    spawn(function()
		pcall(function()
			while wait() do
				if _G.SailBoat then
					if game:GetService("Workspace").Enemies:FindFirstChild("Shark") or game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") or game:GetService("Workspace").Enemies:FindFirstChild("Piranha") or game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
					    game.Players.LocalPlayer.Character.Humanoid.Sit = false
					end
				end
			end
		end)
	end)
	



    local ToggleTerrorshark = Tabs.Main:AddToggle("ToggleTerrorshark", {Title = " Kill Terrorshark", Default = false })

    ToggleTerrorshark:OnChanged(function(Value)
        _G.AutoTerrorshark = Value
    end)
    Options.ToggleTerrorshark:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoTerrorshark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Terrorshark" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                            
                                        --Click
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    until not _G.AutoTerrorshark or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                      
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else
                        end
                    end
                end)
    
            end
        end
     end)



     local TogglePiranha = Tabs.Main:AddToggle("TogglePiranha", {Title = " Kill Piranha", Default = false })

     TogglePiranha:OnChanged(function(Value)
        _G.farmpiranya = Value
     end)
     Options.TogglePiranha:SetValue(false)

     spawn(function()
        while wait() do
            if _G.farmpiranya then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Piranha") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Piranha" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                            
                                        --Click
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    until not _G.farmpiranya or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                     
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Piranha") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Piranha").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else  
                        end
                    end
        
                end)
            end
        end
     end)



     local ToggleShark = Tabs.Main:AddToggle("ToggleShark", {Title = " Kill Shark", Default = false })
     ToggleShark:OnChanged(function(Value)
        _G.AutoShark = Value
     end)
     Options.ToggleShark:SetValue(false)
     spawn(function()
        while wait() do
            if _G.AutoShark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Shark") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Shark" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                    until not _G.AutoShark or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0,1,0))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else
                        end
                    end
                end)
    
            end
        end
    end)



    local ToggleFishCrew = Tabs.Main:AddToggle("ToggleFishCrew", {Title = " Kill Fish Crew", Default = false })
    ToggleFishCrew:OnChanged(function(Value)
       _G.AutoFishCrew = Value
    end)
    Options.ToggleFishCrew:SetValue(false)

    spawn(function()
        while wait() do
            if _G.AutoFishCrew then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Fish Crew Member" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                            
                                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                    until not _G.AutoFishCrew or not v.Parent or v.Humanoid.Health <= 0
                                end
                            
                            end
                        end
                    else
                  
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0,1,0))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else
                           
                        end
                    end
        
                end)
            end
        end
    end)


    local AutoElite = Tabs.Main:AddSection("Elite Hunter Farm")

    local ToggleElite = Tabs.Main:AddToggle("ToggleElite", {Title = "Auto Elite Hunter", Default = false })

    ToggleElite:OnChanged(function(Value)
       _G.AutoElite = Value
       end)
       Options.ToggleElite:SetValue(false)
       spawn(function()
           while task.wait() do
               if _G.AutoElite then
                   pcall(function()
                       if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                           if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
                               if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                                   for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                       if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                           if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                            repeat wait(_G.Fast_Delay)
                                                AttackNoCD()
                                                   EquipTool(SelectWeapon)
                                                   AutoHaki()
                                                   Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                                   MonsterPosition = v.HumanoidRootPart.CFrame
                                                   v.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                                   v.Humanoid.JumpPower = 0
                                                   v.Humanoid.WalkSpeed = 0
                                                   v.HumanoidRootPart.CanCollide = false
                                       
                                                   --Click
                                                   FarmPos = v.HumanoidRootPart.CFrame
                                                   MonFarm = v.Name
                                                   v.HumanoidRootPart.Size = Vector3.new(1, 1, 1)
                                                   _G.BringMob = false
                                               until _G.AutoElite == false or v.Humanoid.Health <= 0 or not v.Parent
                                           end
                                       end
                                   end
                               else
                                   if BypassTP then
                                   if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                       BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                       BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                       BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   end
                               else
                                   if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                       Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                       Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                       Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                   end
   
                               end
                               end
                           end
                       else
                           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                       end
                   end)
               end
			   _G.BringMob = true
           end
       end)
    end


if Third_Sea then
    local Sea = Tabs.Main:AddSection("Sea Beast")


local ToggleSeaBeAst = Tabs.Main:AddToggle("ToggleSeaBeAst", {Title = "Auto Sea Beast", Default = false })

ToggleSeaBeAst:OnChanged(function(Value)
    _G.AutoSeaBeast = Value
    end)
    Options.ToggleSeaBeAst:SetValue(false)
 
    
    Skillz = true
    Skillx = true
    Skillc = true
    Skillv = true
    
    spawn(function()
        while wait() do
            pcall(function()
                if AutoSkill then
                    if Skillz then
                        game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
                    end
                    if Skillx then
                        game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
                    end
                    if Skillc then
                        game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
                    end
                    if Skillv then
                        game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                    end
                end
            end)
        end
    end)
    task.spawn(function()
        while wait() do
            pcall(function()
                if _G.AutoSeaBeast then
                    if not game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") then
                        if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then 
                            if not game:GetService("Workspace").Boats:FindFirstChild("PirateBasic") then
                                if not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                    buyb = TweenBoat(CFrame.new(-4513.90087890625, 16.76398277282715, -2658.820556640625))
                                    if (CFrame.new(-4513.90087890625, 16.76398277282715, -2658.820556640625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                        if buyb then buyb:Stop() end
                                        local args = {
                                            [1] = "BuyBoat",
                                            [2] = "PirateGrandBrigade"
                                        }
            
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                        TweenBoat(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0,1,0))
                                    elseif game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
                                        repeat wait()
                                            if (game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 10 then
                                                TweenShip(CFrame.new(35.04552459716797, 17.750778198242188, 4819.267578125))
                                            end
                                        until game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") or _G.AutoSeaBeast == false
                                    end
                                end
                            elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                                for is,vs in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                    if vs.Name == "PirateGrandBrigade" then
                                        if vs:FindFirstChild("VehicleSeat") then
                                            repeat wait()
                                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                                TweenBoat(vs.VehicleSeat.CFrame * CFrame.new(0,1,0))
                                            until not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") or _G.AutoSeaBeast == false
                                        end
                                    end
                                end
                            end
                        elseif game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") then
                            for iss,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == "PirateGrandBrigade" then
                                    if v:FindFirstChild("VehicleSeat") then
                                        repeat wait()
                                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                            TweenBoat(v.VehicleSeat.CFrame * CFrame.new(0,1,0))
                                        until not game:GetService("Workspace").Boats:FindFirstChild("PirateGrandBrigade") or _G.AutoSeaBeast == false
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").SeaBeasts:FindFirstChild("SeaBeast1") then  
                        for i,v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") then
                                repeat wait()
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                                    TweenBoat(v.HumanoidRootPart.CFrame * CFrame.new(0,500,0))
                                    EquipAllWeapon()  
                                    AutoSkill = true
                                    AimBotSkillPosition = v.HumanoidRootPart
                                    Skillaimbot = true
                                until not v:FindFirstChild("HumanoidRootPart") or _G.AutoSeaBeast == false
                                AutoSkill = false
                                Skillaimbot = false
                            end
                        end
                    end
                end
            end)
        end
    end)

local ToggleAutoW = Tabs.Main:AddToggle("ToggleAutoW", {Title = "Auto Press W", Default = false })
ToggleAutoW:OnChanged(function(Value)
    _G.AutoW = Value
    end)
 Options.ToggleAutoW:SetValue(false)
 spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoW then
                game:GetService("VirtualInputManager"):SendKeyEvent(true,"W",false,game)
            end
        end)
    end
    end)




    local AutoMysticIsland = Tabs.Main:AddSection("Mirage Island")

local ToggleTweenMirageIsland = Tabs.Main:AddToggle("ToggleTweenMirageIsland", {Title = "Tween To Mirage Island", Default = false })
ToggleTweenMirageIsland:OnChanged(function(Value)
    _G.AutoMysticIsland = Value
end) 
Options.ToggleTweenMirageIsland:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoMysticIsland then
                if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                    Tween(CFrame.new(game:GetService("Workspace").Map.MysticIsland.Center.Position.X,500,game:GetService("Workspace").Map.MysticIsland.Center.Position.Z))
                end
            end
        end
    end)
end)




local ToggleTweenGear = Tabs.Main:AddToggle("ToggleTweenGear", {Title = "Tween To Gear", Default = false })
ToggleTweenGear:OnChanged(function(Value)
    _G.TweenToGear = Value
end) 
Options.ToggleTweenGear:SetValue(false)

spawn(function()
    pcall(function()
        while wait() do
            if _G.TweenToGear then
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
					for i,v in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do 
						if v:IsA("MeshPart")then 
                            if v.Material ==  Enum.Material.Neon then  
                                Tween(v.CFrame)
                            end
                        end
					end
				end
			end
        end
    end)
    end)




    local Togglelockmoon = Tabs.Main:AddToggle("Togglelockmoon", {Title = "Lock Moon and Use Race Skill", Default = false })
    Togglelockmoon:OnChanged(function(Value)
        _G.AutoLockMoon = Value
    end) 
    Options.Togglelockmoon:SetValue(false)

    spawn(function()
        while wait() do
            pcall(function()
                if _G.AutoLockMoon then
                    local moonDir = game.Lighting:GetMoonDirection()
                    local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + moonDir * 100
                    game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos)
                end
            end)
        end
    end)


    spawn(function()
        while wait() do
            pcall(function()
                if _G.AutoLockMoon then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true,"T",false,game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false,"T",false,game)
                end
            end)
        end
    end)


local ToggleMirage = Tabs.Main:AddToggle("ToggleMirage", {Title = "Auto Mirage Island", Default = false })
ToggleMirage:OnChanged(function(Value)
 _G.AutoSeaBeast = Value
end) 

 Options.ToggleMirage:SetValue(false)

 local AutoW = Tabs.Main:AddToggle("AutoW", {Title = "Auto Press W", Default = false })
 AutoW:OnChanged(function(Value)
    _G.AutoW = Value
     end)
  Options.AutoW:SetValue(false)
  spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoW then
                game:GetService("VirtualInputManager"):SendKeyEvent(true,"W",false,game)
            end
        end)
    end
    end)
end

local Items = Tabs.Main:AddSection("Items Farm")

if Third_Sea then
    local ToggleHallow = Tabs.Main:AddToggle("ToggleHallow", {Title = "Auto Hallow Scythe [Fully]", Default = false })

    ToggleHallow:OnChanged(function(Value)
        AutoHallowSycthe = Value
    end)
    Options.ToggleHallow:SetValue(false)
    spawn(function()
        while wait() do
            if AutoHallowSycthe then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if string.find(v.Name , "Soul Reaper") then
                                repeat wait(_G.Fast_Delay)
                                    AttackNoCD()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Transparency = 1
                                    sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                        
									--Click
                                until v.Humanoid.Health <= 0 or AutoHallowSycthe == false
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                        repeat Tween(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)) wait() until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8                        
                        EquipTool("Hallow Essence")
                    else
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else
                        end
                    end
                end)
    
            end
        end
    end)
	
	
	spawn(function()
           while wait(0.001) do
           if AutoHallowSycthe then
           local args = {
            [1] = "Bones",
            [2] = "Buy",
            [3] = 1,
            [4] = 1
           }
          
           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
           end
           end
           end)
        
           
           local ToggleYama = Tabs.Main:AddToggle("ToggleYama", {Title = "Auto Get Yama", Default = false })
           ToggleYama:OnChanged(function(Value)
            _G.AutoYama = Value
           end)
           Options.ToggleYama:SetValue(false)
           spawn(function()
            while wait() do
                if _G.AutoYama then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
                        repeat wait(.1)
                            fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                        until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or not _G.AutoYama
                    end
                end
            end
        end)


        local ToggleTushita = Tabs.Main:AddToggle("ToggleTushita", {Title = "Auto Tushita", Default = false })
        ToggleTushita:OnChanged(function(Value)
            AutoTushita = Value
        end)
        Options.ToggleTushita:SetValue(false)
           spawn(function()
                   while wait() do
                               if AutoTushita then
                                   if game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                                       for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                           if v.Name == ("Longma" or v.Name == "Longma") and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                            repeat wait(_G.Fast_Delay)
                                                AttackNoCD()
                                                   AutoHaki()
                                                   if not game.Players.LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                                       wait()
                                                       EquipTool(SelectWeapon)
                                                   end
                                                   FarmPos = v.HumanoidRootPart.CFrame
                                                     --Click
                                                   v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                                   v.Humanoid.JumpPower = 0
                                                   v.Humanoid.WalkSpeed = 0
                                                   v.HumanoidRootPart.CanCollide = false
                                                   v.Humanoid:ChangeState(11)
                                                   Tween(v.HumanoidRootPart.CFrame * Pos)
                                               until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
                                           end
                                       end
                                   else
                                       Tween(CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125))
                                   end
                               end
                           end
                   end)


                   local ToggleHoly = Tabs.Main:AddToggle("ToggleHoly", {Title = "Auto Holy Torch", Default = false })
                   ToggleHoly:OnChanged(function(Value)
                    _G.Auto_Holy_Torch = Value
                   end)
                   Options.ToggleHoly:SetValue(false)
                   spawn(function()
                    while wait() do
                        if _G.Auto_Holy_Torch then
                            pcall(function()
                                wait(1)
                                repeat Tween(CFrame.new(-10752, 417, -9366)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10752, 417, -9366)).Magnitude <= 10
                                wait(1)
                                repeat Tween(CFrame.new(-11672, 334, -9474)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-11672, 334, -9474)).Magnitude <= 10
                                wait(1)
                                repeat Tween(CFrame.new(-12132, 521, -10655)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12132, 521, -10655)).Magnitude <= 10
                                wait(1)
                                repeat Tween(CFrame.new(-13336, 486, -6985)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13336, 486, -6985)).Magnitude <= 10
                                wait(1)
                                repeat Tween(CFrame.new(-13489, 332, -7925)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13489, 332, -7925)).Magnitude <= 10
                            end)
                        end
                    end
                end)
            end
        end


if Second_Sea then
        local ToggleFactory = Tabs.Main:AddToggle("ToggleFactory", {Title = "Auto Farm Factory", Default = false })
        ToggleFactory:OnChanged(function(Value)
            _G.Factory = Value
        end)
        Options.ToggleFactory:SetValue(false)

        spawn(function()
            while wait() do
                if _G.Factory then
                    if game.Workspace.Enemies:FindFirstChild("Core") then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Core" and v.Humanoid.Health > 0 then
                                repeat wait(_G.Fast_Delay)
                                    AttackNoCD()
                                    repeat Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                                        wait()
                                    until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
                                    EquipTool(SelectWeapon)
                                    AutoHaki()
                                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                        
                                    --Click
                                until not v.Parent or v.Humanoid.Health <= 0  or _G.Factory == false
                            end
                        end
                    elseif game.ReplicatedStorage:FindFirstChild("Core") then
                        repeat Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                            wait()
                        until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
                    end
        
                end
            end
        end)

    end

        if Third_Sea then
    local ToggleCakeV2 = Tabs.Main:AddToggle("ToggleCakeV2", {Title = "Kill Dought King [Need Spawn]", Default = false })
    ToggleCakeV2:OnChanged(function(Value)
        _G.AutoCakeV2 = Value
    end)
        Options.ToggleCakeV2:SetValue(false)
end
    spawn(function()
        while wait() do
            if _G.AutoCakeV2 then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Dough King" then
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat wait(_G.Fast_Delay)
                                        AttackNoCD()
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX,posY,posZ))
                                        --Click
                                        sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                    until not _G.AutoCakeV2 or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    else
                    Tween(CFrame.new(-2662.818603515625, 1062.3480224609375, -11853.6953125))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") then
                     Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Dough King").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                        else
                        end
            
                    end
                end)
            end
        end
    end)

    
if Second_Sea or Third_Sea then
    local ToggleHakiColor = Tabs.Main:AddToggle("ToggleHakiColor", {Title = "Buy Haki Color",Default = false })
    ToggleHakiColor:OnChanged(function(Value)
        _G.Auto_Buy_Enchancement = Value
    end)
        Options.ToggleHakiColor:SetValue(false)
    spawn(function()
            while wait() do
                if _G.Auto_Buy_Enchancement then
                    local args = {
                        [1] = "ColorsDealer",
                        [2] = "2"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end 
            end
        end)
end

if Second_Sea then
    local ToggleSwordLengend = Tabs.Main:AddToggle("ToggleSwordLengend", {Title = "Buy Sword Lengendary",Default = false })
    ToggleSwordLengend:OnChanged(function(Value)
        _G.BuyLengendSword = Value
    end)
        Options.ToggleSwordLengend:SetValue(false)

        spawn(function()
            while wait(.1) do
                pcall(function()
                    if _G.BuyLengendSword or Triple_A then
                        local args = {
                            [1] = "LegendarySwordDealer",
                            [2] = "2"
                        }
                        -- Triple_A
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    else
                        wait(2)
                    end
                end)
            end
        end)
    end
--------------------------------------------------------------------------------------------------------------------------------------------
--Setting
-- Tạo namespace để quản lý các cài đặt
local FarmSettings = {
    FastAttack = {
        Enabled = true,
        Delay = 0.1  -- Có thể điều chỉnh
    },
    BringMob = {
        Enabled = true,
        MaxDistance = 350
    },
    BypassTP = false,
    RemoveText = {
        DamageCounter = true,
        Notifications = false
    },
    WhiteScreen = false,
    Skills = {
        Z = true,
        X = true,
        C = true,
        V = true,
        F = false
    },
    FarmPosition = {
        X = 0,
        Y = 30,
        Z = 0
    }
}

-- Hàm thiết lập các toggle và slider
local function SetupFarmSettings(Tabs)
    -- Phần cài đặt chung
    local SettingFarm = Tabs.Setting:AddSection("Setting Farming")

    -- Fast Attack
    local ToggleFastAttack = Tabs.Setting:AddToggle("ToggleFastAttack", {
        Title = "Fast Attack", 
        Default = FarmSettings.FastAttack.Enabled 
    })
    ToggleFastAttack:OnChanged(function(Value)
        FarmSettings.FastAttack.Enabled = Value
        _G.FastAttackFaiFao = Value
    end)

    -- Spawn thread Fast Attack
    spawn(function()
        while wait(0.5) do
            pcall(function()
                if FarmSettings.FastAttack.Enabled then
                    repeat wait(FarmSettings.FastAttack.Delay)
                        AttackNoCD()
                    until not FarmSettings.FastAttack.Enabled
                end
            end)
        end
    end)

    -- Bring Mob
    local ToggleBringMob = Tabs.Setting:AddToggle("ToggleBringMob", {
        Title = "Bring Mob", 
        Default = FarmSettings.BringMob.Enabled 
    })
    ToggleBringMob:OnChanged(function(Value)
        FarmSettings.BringMob.Enabled = Value
        _G.BringMob = Value
    end)

    -- Bring Mob Logic
    task.spawn(function()
        while task.wait() do
            if FarmSettings.BringMob.Enabled then
                pcall(function()
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        if not string.find(enemy.Name, "Boss") and 
                           enemy.Name == MonFarm and 
                           (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= FarmSettings.BringMob.MaxDistance then
                            
                            if InMyNetWork(enemy.HumanoidRootPart) then
                                enemy.HumanoidRootPart.CFrame = FarmPos
                                enemy.HumanoidRootPart.CanCollide = false
                                enemy.HumanoidRootPart.Size = Vector3.new(1,1,1)
                                
                                if enemy.Humanoid:FindFirstChild("Animator") then
                                    enemy.Humanoid.Animator:Destroy()
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- Các toggle và slider khác tương tự...
    -- Skill Toggles
    local skillKeys = {"Z", "X", "C", "V", "F"}
    for _, key in ipairs(skillKeys) do
        local toggle = Tabs.Setting:AddToggle("Toggle"..key, {
            Title = "Skill "..key, 
            Default = FarmSettings.Skills[key]
        })
        toggle:OnChanged(function(Value)
            FarmSettings.Skills[key] = Value
            _G["Skill"..key] = Value
        end)
    end

    -- Vị trí Farm
    local function CreatePositionSlider(key, defaultValue)
        local slider = Tabs.Setting:AddSlider("SliderPos"..key, {
            Title = "Pos "..key,
            Default = defaultValue,
            Min = -60,
            Max = 60,
            Rounding = 1
        })
        slider:OnChanged(function(Value)
            FarmSettings.FarmPosition[key] = Value
        end)
        return slider
    end

    local SliderPosX = CreatePositionSlider("X", 0)
    local SliderPosY = CreatePositionSlider("Y", 30)
    local SliderPosZ = CreatePositionSlider("Z", 0)

    -- Các cài đặt khác...
end

-- Gọi hàm thiết lập
SetupFarmSettings(Tabs)

--------------------------------------------------------------------------------------------------------------------------------------------

-- Namespace quản lý cài đặt Stats
local StatSettings = {
    TweenSpeed = {
        Value = 300,
        Min = 100,
        Max = 1000
    },
    AutoStats = {
        Melee = false,
        Defense = false,
        Sword = false,
        Gun = false,
        DevilFruit = false
    }
}

-- Hàm thiết lập cài đặt Tween Speed
local function SetupTweenSpeedSettings(Tabs)
    local SettingTweenSpeed = Tabs.Setting:AddSection("Setting Tween Speed")

    local SliderTween = Tabs.Setting:AddSlider("SliderTween", {
        Title = "Teleport / Tween",
        Description = "Điều chỉnh tốc độ di chuyển",
        Default = StatSettings.TweenSpeed.Value,
        Min = StatSettings.TweenSpeed.Min,
        Max = StatSettings.TweenSpeed.Max,
        Rounding = 1
    })

    SliderTween:OnChanged(function(Value)
        StatSettings.TweenSpeed.Value = Value
        ChangeSpeed = Value  -- Giữ lại biến gốc nếu cần
    end)

    SliderTween:SetValue(StatSettings.TweenSpeed.Value)
end

-- Hàm nâng cấp điểm Stats
local function SetupAutoStatUpgrade(Tabs)
    local StatsSection = Tabs.Stats:AddSection("Auto Upgrade Stats")

    -- Danh sách các stats để tự động nâng
    local statsConfig = {
        {
            Name = "Melee",
            GlobalVar = "_G.Auto_Stats_Melee",
            SettingsKey = "Melee"
        },
        {
            Name = "Defense", 
            GlobalVar = "_G.Auto_Stats_Defense",
            SettingsKey = "Defense"
        },
        {
            Name = "Sword",
            GlobalVar = "_G.Auto_Stats_Sword", 
            SettingsKey = "Sword"
        },
        {
            Name = "Gun",
            GlobalVar = "_G.Auto_Stats_Gun",
            SettingsKey = "Gun"
        },
        {
            Name = "Demon Fruit",
            GlobalVar = "_G.Auto_Stats_Devil_Fruit",
            SettingsKey = "DevilFruit"
        }
    }

    -- Tạo toggle cho từng stat
    for _, statConfig in ipairs(statsConfig) do
        local toggle = Tabs.Stats:AddToggle("Toggle" .. statConfig.Name, {
            Title = "Auto " .. statConfig.Name,
            Default = StatSettings.AutoStats[statConfig.SettingsKey]
        })

        toggle:OnChanged(function(Value)
            StatSettings.AutoStats[statConfig.SettingsKey] = Value
            _G[statConfig.GlobalVar:sub(3)] = Value
        end)

        toggle:SetValue(false)
    end

    -- Hàm nâng cấp điểm stats
    local function UpgradeStats()
        for _, statConfig in ipairs(statsConfig) do
            spawn(function()
                while wait() do
                    if StatSettings.AutoStats[statConfig.SettingsKey] then
                        local success, error = pcall(function()
                            local args = {
                                [1] = "AddPoint",
                                [2] = statConfig.Name,
                                [3] = 3  -- Số điểm nâng mỗi lần
                            }
                            
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end)

                        if not success then
                            warn("Lỗi nâng cấp " .. statConfig.Name .. ": " .. tostring(error))
                        end
                    end
                end
            end)
        end
    end

    -- Gọi hàm nâng cấp
    UpgradeStats()
end

-- Hàm chính để thiết lập tất cả cài đặt
local function SetupStatSettings(Tabs)
    SetupTweenSpeedSettings(Tabs)
    SetupAutoStatUpgrade(Tabs)
end

-- Gọi hàm thiết lập
SetupStatSettings(Tabs)
--------------------------------------------------------------------------------------------------------------------------------------------
--Player

-- Namespace quản lý chức năng Player
local PlayerSettings = {
    SelectedPlayer = nil,
    IsTeleporting = false,
    IsSpectating = false
}

-- Hàm cập nhật danh sách người chơi
local function UpdatePlayersList()
    local Playerslist = {}
    for _, player in pairs(game:GetService("Players"):GetChildren()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(Playerslist, player.Name)
        end
    end
    return Playerslist
end

-- Hàm thiết lập các chức năng liên quan đến Player
local function SetupPlayerFeatures(Tabs)
    -- Dropdown chọn người chơi
    local SelectedPly = Tabs.Player:AddDropdown("SelectedPly", {
        Title = "Select Player to Interact",
        Values = UpdatePlayersList(),
        Multi = false,
        Default = 1,
    })

    -- Cập nhật danh sách người chơi khi có thay đổi
    game:GetService("Players").PlayerAdded:Connect(function()
        SelectedPly:SetValues(UpdatePlayersList())
    end)
    
    game:GetService("Players").PlayerRemoving:Connect(function()
        SelectedPly:SetValues(UpdatePlayersList())
    end)

    -- Xử lý khi chọn người chơi
    SelectedPly:OnChanged(function(Value)
        PlayerSettings.SelectedPlayer = Value
        _G.SelectPly = Value
    end)

    -- Toggle Teleport
    local ToggleTeleport = Tabs.Player:AddToggle("ToggleTeleport", {
        Title = "Teleport To Player", 
        Default = false 
    })

    ToggleTeleport:OnChanged(function(Value)
        PlayerSettings.IsTeleporting = Value
        
        spawn(function()
            while PlayerSettings.IsTeleporting do
                local success, error = pcall(function()
                    if PlayerSettings.SelectedPlayer then
                        local targetPlayer = game:GetService("Players")[PlayerSettings.SelectedPlayer]
                        if targetPlayer and targetPlayer.Character then
                            local targetRoot = targetPlayer.Character.HumanoidRootPart
                            Tween(targetRoot.CFrame)
                        else
                            warn("Không tìm thấy người chơi hoặc nhân vật")
                            PlayerSettings.IsTeleporting = false
                        end
                    else
                        warn("Chưa chọn người chơi")
                        PlayerSettings.IsTeleporting = false
                    end
                end)
                
                if not success then
                    warn("Lỗi teleport: " .. tostring(error))
                    PlayerSettings.IsTeleporting = false
                end
                
                wait(0.5)  -- Ngăn chặn spam
            end
        end)
    end)

    -- Toggle Quan Sát
    local ToggleQuanSat = Tabs.Player:AddToggle("ToggleQuanSat", {
        Title = "Spectate Player", 
        Default = false 
    })

    ToggleQuanSat:OnChanged(function(Value)
        PlayerSettings.IsSpectating = Value
        
        spawn(function()
            local localPlayer = game:GetService("Players").LocalPlayer
            local camera = game:GetService("Workspace").Camera
            
            while PlayerSettings.IsSpectating do
                local success, error = pcall(function()
                    if PlayerSettings.SelectedPlayer then
                        local targetPlayer = game:GetService("Players"):FindFirstChild(PlayerSettings.SelectedPlayer)
                        if targetPlayer and targetPlayer.Character then
                            camera.CameraSubject = targetPlayer.Character.Humanoid
                        else
                            warn("Không tìm thấy người chơi để quan sát")
                            PlayerSettings.IsSpectating = false
                        end
                    else
                        warn("Chưa chọn người chơi để quan sát")
                        PlayerSettings.IsSpectating = false
                    end
                end)
                
                if not success then
                    warn("Lỗi quan sát: " .. tostring(error))
                    PlayerSettings.IsSpectating = false
                end
                
                wait(0.1)
            end
            
            -- Quay lại nhân vật của người chơi
            camera.CameraSubject = localPlayer.Character.Humanoid
        end)
    end)

    -- Đặt giá trị mặc định ban đầu
    SelectedPly:SetValue("nil")
    ToggleTeleport:SetValue(false)
    ToggleQuanSat:SetValue(false)
end

-- Gọi hàm thiết lập
SetupPlayerFeatures(Tabs)

-- Namespace quản lý Auto Kill
local AutoKillSettings = {
    IsAutoKilling = false,
    SelectedPlayer = nil,
    KillMethod = "Melee", -- Có thể chọn: "Melee", "Sword", "Gun", "Fruit"
    AttackDistance = 25,  -- Khoảng cách tấn công
    KillDelay = 0.5       -- Độ trễ giữa các lần tấn công
}

-- Hàm thiết lập Auto Kill
local function SetupAutoKill(Tabs)
    -- Dropdown chọn người chơi để giết
    local SelectedKillPly = Tabs.Player:AddDropdown("SelectedKillPly", {
        Title = "Select Player to Kill",
        Values = UpdatePlayersList(),
        Multi = false,
        Default = 1,
    })

    -- Dropdown chọn phương thức tấn công
    local KillMethodDropdown = Tabs.Player:AddDropdown("KillMethodDropdown", {
        Title = "Kill Method",
        Values = {"Melee", "Sword", "Gun", "Fruit"},
        Multi = false,
        Default = 1,
    })

    -- Slider điều chỉnh khoảng cách tấn công
    local KillDistanceSlider = Tabs.Player:AddSlider("KillDistanceSlider", {
        Title = "Attack Distance",
        Description = "Khoảng cách tấn công tối đa",
        Default = 25,
        Min = 10,
        Max = 50,
        Rounding = 1
    })

    -- Cập nhật cài đặt khi thay đổi
    SelectedKillPly:OnChanged(function(Value)
        AutoKillSettings.SelectedPlayer = Value
    end)

    KillMethodDropdown:OnChanged(function(Value)
        AutoKillSettings.KillMethod = Value
    end)

    KillDistanceSlider:OnChanged(function(Value)
        AutoKillSettings.AttackDistance = Value
    end)

    -- Toggle Auto Kill
    local ToggleAutoKill = Tabs.Player:AddToggle("ToggleAutoKill", {
        Title = "Auto Kill Player", 
        Default = false 
    })

    -- Hàm kiểm tra và tấn công người chơi
    local function AttackPlayer()
        local localPlayer = game:GetService("Players").LocalPlayer
        local targetPlayer = game:GetService("Players"):FindFirstChild(AutoKillSettings.SelectedPlayer)
        
        if not targetPlayer or not targetPlayer.Character then return false end
        
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not targetRoot or not localRoot then return false end
        
        -- Kiểm tra khoảng cách
        local distance = (targetRoot.Position - localRoot.Position).Magnitude
        if distance > AutoKillSettings.AttackDistance then return false end
        
        -- Chọn phương thức tấn công
        local attackMethod = {
            ["Melee"] = function()
                -- Tấn công bằng đấm
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                wait(0.1)
                game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0))
            end,
            ["Sword"] = function()
                -- Tấn công bằng kiếm (có thể cần điều chỉnh)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MouseEvent", "LeftDown")
                wait(0.1)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MouseEvent", "LeftUp")
            end,
            ["Gun"] = function()
                -- Tấn công bằng súng
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Shoot", targetRoot.Position, targetRoot)
            end,
            ["Fruit"] = function()
                -- Sử dụng năng lực trái ác quỷ (cần điều chỉnh)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UseFruit")
            end
        }
        
        -- Thực hiện tấn công
        local attackFunc = attackMethod[AutoKillSettings.KillMethod]
        if attackFunc then
            attackFunc()
            return true
        end
        
        return false
    end

    -- Luồng chính của Auto Kill
    ToggleAutoKill:OnChanged(function(Value)
        AutoKillSettings.IsAutoKilling = Value
        
        spawn(function()
            while AutoKillSettings.IsAutoKilling do
                local success, result = pcall(function()
                    if AutoKillSettings.SelectedPlayer then
                        if not AttackPlayer() then
                            -- Nếu không thể tấn công, thử di chuyển đến gần mục tiêu
                            local targetPlayer = game:GetService("Players"):FindFirstChild(AutoKillSettings.SelectedPlayer)
                            if targetPlayer and targetPlayer.Character then
                                local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if targetRoot then
                                    Tween(targetRoot.CFrame)
                                end
                            end
                        end
                    else
                        warn("Chưa chọn mục tiêu để giết")
                        AutoKillSettings.IsAutoKilling = false
                    end
                end)
                
                if not success then
                    warn("Lỗi Auto Kill: " .. tostring(result))
                    AutoKillSettings.IsAutoKilling = false
                end
                
                wait(AutoKillSettings.KillDelay)
            end
        end)
    end)

    -- Đặt giá trị mặc định
    SelectedKillPly:SetValue("nil")
    KillMethodDropdown:SetValue("Melee")
    ToggleAutoKill:SetValue(false)
end

-- Gọi hàm thiết lập
SetupAutoKill(Tabs)

-----------------------------------------------------------------------------------------------------------------------------------------------
--Teleport
local TeleportManager = {
    CurrentSea = nil,
    SelectedIsland = nil,
    IsTeleporting = false,
    
    -- Danh sách địa điểm teleport theo từng sea
    IslandLocations = {
        FirstSea = {
            ["WindMill"] = CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594),
            ["Marine"] = CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156),
            ["Middle Town"] = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094),
            ["Jungle"] = CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754),
            ["Pirate Village"] = CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969),
            ["Desert"] = CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688),
            ["Snow Island"] = CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469),
            ["MarineFord"] = CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313),
            ["Colosseum"] = CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969),
            ["Sky Island 1"] = CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063),
            ["Prison"] = CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656),
            ["Magma Village"] = CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875),
            ["Fountain City"] = CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813),
            ["Shank Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478),
            ["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268)
        },
        SecondSea = {
            ["The Cafe"] = CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828),
            ["Frist Spot"] = CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375),
            ["Dark Area"] = CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375),
            ["Flamingo Mansion"] = CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234),
            ["Flamingo Room"] = CFrame.new(2284.4140625, 15.152037620544, 875.72534179688),
            ["Green Zone"] = CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344),
            ["Factory"] = CFrame.new(424.12698364258, 211.16171264648, -427.54049682617),
            ["Colossuim"] = CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641),
            ["Zombie Island"] = CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094),
            ["Two Snow Mountain"] = CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938),
            ["Punk Hazard"] = CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125),
            ["Cursed Ship"] = CFrame.new(923.40197753906, 125.05712890625, 32885.875),
            ["Ice Castle"] = CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188),
            ["Forgotten Island"] = CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875),
            ["Ussop Island"] = CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781),
            ["Mini Sky Island"] = CFrame.new(-288.74060058594, 49326.31640625, -35248.59375)
        },
        ThirdSea = {
            ["Mansion"] = CFrame.new(-12468.5380859375, 375.0094299316406, -7554.62548828125),
            ["Port Town"] = CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375),
            ["Great Tree"] = CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625),
            ["Castle On The Sea"] = CFrame.new(-5075.50927734375, 314.5155029296875, -3150.0224609375),
            ["MiniSky"] = CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125),
            ["Hydra Island"] = CFrame.new(5753.5478515625, 610.7880859375, -282.33172607421875),
            ["Floating Turtle"] = CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625),
            ["Haunted Castle"] = CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562),
            ["Ice Cream Island"] = CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625),
            ["Peanut Island"] = CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375),
            ["Cake Island"] = CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375),
            ["Cocoa Island"] = CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375),
            ["Candy Island"] = CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625),
            ["Isle Outpost"] = CFrame.new(-16542.447265625, 55.68632888793945, 1044.41650390625)
        }
    },
    
    -- Hàm xác định sea hiện tại
    DetectCurrentSea = function(self)
        local player = game.Players.LocalPlayer
        local playerLevel = player.Data.Level.Value
        
        if playerLevel < 700 then
            self.CurrentSea = "FirstSea"
        elseif playerLevel >= 700 and playerLevel < 1500 then
            self.CurrentSea = "SecondSea"
        else
            self.CurrentSea = "ThirdSea"
        end
        
        return self.CurrentSea
    end,
    
    -- Hàm lấy danh sách địa điểm
    GetIslandList = function(self)
        self:DetectCurrentSea()
        
        local islands = {}
        if self.CurrentSea == "FirstSea" then
            islands = self:GetTableKeys(self.IslandLocations.FirstSea)
        elseif self.CurrentSea == "SecondSea" then
            islands = self:GetTableKeys(self.IslandLocations.SecondSea)
        else
            islands = self:GetTableKeys(self.IslandLocations.ThirdSea)
        end
        
        return islands
    end,
    
    -- Hàm trợ giúp lấy keys của bảng
    GetTableKeys = function(self, tbl)
        local keys = {}
        for k, _ in pairs(tbl) do
            table.insert(keys, k)
        end
        return keys
    end,
    
    -- Hàm teleport an toàn
    SafeTeleport = function(self, targetCFrame)
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if not character or not character:FindFirstChild("HumanoidRootPart") then 
            return false 
        end
        
        local success, error = pcall(function()
            -- Teleport với phương thức an toàn
            character.HumanoidRootPart.CFrame = targetCFrame
            wait(0.5)
            character.HumanoidRootPart.CFrame = targetCFrame
        end)
        
        if not success then
            warn("Teleport Error: " .. tostring(error))
            return false
        end
        
        return true
    end,
    
    -- Hàm teleport đặc biệt (cho các địa điểm yêu cầu remote)
    SpecialTeleport = function(self, islandName)
        local specialTeleports = {
            ["Sky Island 2"] = function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance", 
                    Vector3.new(-4607.82275, 872.54248, -1667.55688)
                )
            end,
            ["Sky Island 3"] = function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance", 
                    Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047)
                )
            end,
            ["Under Water Island"] = function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "requestEntrance", 
                    Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)
                )
            end
        }
        
        if specialTeleports[islandName] then
            specialTeleports[islandName]()
            return true
        end
        
        return false
    end
}

-- Thiết lập giao diện Teleport
local function SetupTeleportInterface(Tabs)
    -- Tạo section Teleport World
    local TeleportWorld = Tabs.Teleport:AddSection("Teleport World")
    
    -- Nút teleport giữa các sea
    local seaTeleportButtons = {
        {Title = "First Sea", RemoteFunction = "TravelMain"},
        {Title = "Second Sea", RemoteFunction = "TravelDressrosa"},
        {Title = "Third Sea", RemoteFunction = "TravelZou"}
    }
    
    for _, buttonInfo in ipairs(seaTeleportButtons) do
        Tabs.Teleport:AddButton({
            Title = buttonInfo.Title,
            Description = "Teleport to " .. buttonInfo.Title,
            Callback = function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(buttonInfo.RemoteFunction)
            end
        })
    end
    
    -- Tạo section Teleport Island
    local TeleportIsland = Tabs.Teleport:AddSection("Teleport Island")
    
    -- Dropdown chọn đảo
    local DropdownIsland = Tabs.Teleport:AddDropdown("DropdownIsland", {
        Title = "Select Island",
        Values = TeleportManager:GetIslandList(),
        Multi = false,
        Default = 1,
    })
    
    -- Cập nhật danh sách đảo khi sea thay đổi
    game.Players.LocalPlayer.Data.Level.Changed:Connect(function()
        DropdownIsland:SetValues(TeleportManager:GetIslandList())
    end)
    
    DropdownIsland:SetValue("...")
    DropdownIsland:OnChanged(function(Value)
        TeleportManager.SelectedIsland = Value
    end)
    
    -- Toggle Teleport
    local ToggleIsland = Tabs.Teleport:AddToggle("ToggleIsland", {
        Title = "Auto Teleport", 
        Default = false 
    })
    
    ToggleIsland:OnChanged(function(Value)
        TeleportManager.IsTeleporting = Value
        
        spawn(function()
            while TeleportManager.IsTeleporting do
                if TeleportManager.SelectedIsland then
                    local success = false
                    
                    -- Thử teleport đặc biệt trước
                    if TeleportManager:SpecialTeleport(TeleportManager.SelectedIsland) then
                        success = true
                    else
                        -- Tìm vị trí teleport
                        local targetCFrame = nil
                        for sea, islands in pairs(TeleportManager.IslandLocations) do
                            if islands[TeleportManager.SelectedIsland] then
                                targetCFrame = islands[TeleportManager.SelectedIsland]
                                break
                            end
                        end
                        
                        -- Teleport
                        if targetCFrame then
                            success = TeleportManager:SafeTeleport(targetCFrame)
                        end
                    end
                    
                    if not success then
                        warn("Không thể teleport đến " .. TeleportManager.SelectedIsland)
                        TeleportManager.IsTeleporting = false
                    end
                else
                    warn("Chưa chọn đảo để teleport")
                    TeleportManager.IsTeleporting = false
                end
                
                wait(1)  -- Chờ 1 giây trước khi thử teleport lại
            end
        end)
    end)
    
    -- Đặt giá trị mặc định
    ToggleIsland:SetValue(false)
end

-- Gọi hàm thiết lập giao diện Teleport
SetupTeleportInterface(Tabs)
--------------------------------------------------------------------------------------------------------------------------------------------
--Fruit

local FruitManager = {
    -- Quản lý danh sách trái ác quỷ
    DevilFruitList = {},
    ShopDevilFruitList = {},
    SelectedFruit = nil,
    
    -- Hàm khởi tạo danh sách trái ác quỷ
    InitializeFruitList = function(self)
        local Remote_GetFruits = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits")
        
        self.DevilFruitList = {}
        self.ShopDevilFruitList = {}
        
        for _, fruitData in pairs(Remote_GetFruits) do
            table.insert(self.DevilFruitList, fruitData.Name)
            
            if fruitData.OnSale then
                table.insert(self.ShopDevilFruitList, fruitData.Name)
            end
        end
        
        return self.DevilFruitList
    end,
    
    -- Hàm mua trái ác quỷ
    BuyFruit = function(self, fruitName)
        if not fruitName then 
            fruitName = self.SelectedFruit or self.DevilFruitList[1]
        end
        
        local success, result = pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", fruitName, false)
        end)
        
        if not success then
            warn("Lỗi khi mua trái: " .. tostring(result))
            return false
        end
        
        return true
    end,
    
    -- Hàm lưu trữ trái ác quỷ
    StoreFruits = function(self)
        local player = game:GetService("Players").LocalPlayer
        local fruitStorageMap = {
            ["Bomb Fruit"] = "Bomb-Bomb",
            ["Spike Fruit"] = "Spike-Spike",
            ["Chop Fruit"] = "Chop-Chop",
            ["Spring Fruit"] = "Spring-Spring",
            ["Rocket Fruit"] = "Rocket-Rocket",
            ["Kilo Fruit"] = "Rocket-Rocket",
            ["Smoke Fruit"] = "Smoke-Smoke",
            ["Spin Fruit"] = "Spin-Spin",
            ["Flame Fruit"] = "Flame-Flame",
            ["Bird: Falcon Fruit"] = "Bird-Bird: Falcon",
            ["Ice Fruit"] = "Ice-Ice",
            ["Sand Fruit"] = "Sand-Sand",
            ["Dark Fruit"] = "Dark-Dark",
            ["Revive Fruit"] = "Ghost-Ghost",
            ["Diamond Fruit"] = "Diamond-Diamond",
            ["Light Fruit"] = "Light-Light",
            ["Love Fruit"] = "Love-Love",
            ["Rubber Fruit"] = "Rubber-Rubber",
            ["Barrier Fruit"] = "Barrier-Barrier",
            ["Magma Fruit"] = "Magma-Magma",
            ["Door Fruit"] = "Door-Door",
            ["Quake Fruit"] = "Quake-Quake",
            ["Human-Human: Buddha Fruit"] = "Human-Human: Buddha",
            ["Spider Fruit"] = "Spider-Spider",
            ["Bird: Phoenix Fruit"] = "Bird-Bird: Phoenix",
            ["Rumble Fruit"] = "Rumble-Rumble",
            ["Paw Fruit"] = "Pain-Pain",
            ["Gravity Fruit"] = "Gravity-Gravity",
            ["Dough Fruit"] = "Dough-Dough",
            ["Shadow Fruit"] = "Shadow-Shadow",
            ["Venom Fruit"] = "Venom-Venom",
            ["Control Fruit"] = "Control-Control",
            ["Soul Fruit"] = "Soul-Soul",
            ["Dragon Fruit"] = "Dragon-Dragon",
            ["Leopard Fruit"] = "Leopard-Leopard"
        }
        
        for fruitName, storageName in pairs(fruitStorageMap) do
            local fruitInCharacter = player.Character:FindFirstChild(fruitName)
            local fruitInBackpack = player.Backpack:FindFirstChild(fruitName)
            
            if fruitInCharacter or fruitInBackpack then
                local fruitToStore = fruitInCharacter or fruitInBackpack
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                    "StoreFruit", 
                    storageName, 
                    fruitToStore
                )
            end
        end
    end,
    
    -- Hàm thu thập trái ác quỷ ngẫu nhiên
    CollectRandomFruit = function(self)
        local success, result = pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
        end)
        
        if not success then
            warn("Lỗi khi thu thập trái ngẫu nhiên: " .. tostring(result))
            return false
        end
        
        return true
    end,
    
    -- Hàm tự động thu thập trái ác quỷ trong map
    AutoCollectFruits = function(self)
        for _, v in pairs(game.Workspace:GetChildren()) do
            if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                Tween(v.Handle.CFrame)  -- Giả định hàm Tween đã được định nghĩa
            end
        end
    end
}

-- Hàm thiết lập giao diện quản lý trái ác quỷ
local function SetupFruitInterface(Tabs)
    -- Khởi tạo danh sách trái ác quỷ
    local fruitList = FruitManager:InitializeFruitList()
    
    -- Dropdown chọn trái ác quỷ
    local DropdownFruit = Tabs.Fruit:AddDropdown("DropdownFruit", {
        Title = "Chọn Trái Ác Quỷ",
        Values = fruitList,
        Multi = false,
        Default = 1,
    })
    
    DropdownFruit:SetValue("...")
    DropdownFruit:OnChanged(function(Value)
        FruitManager.SelectedFruit = Value
    end)
    
    -- Toggle mua trái ác quỷ
    local ToggleFruit = Tabs.Fruit:AddToggle("ToggleFruit", {
        Title = "Tự Động Mua Trái", 
        Default = false 
    })
    
    ToggleFruit:OnChanged(function(Value)
        spawn(function()
            while Value do
                FruitManager:BuyFruit()
                wait(0.1)
            end
        end)
    end)
    
    -- Toggle lưu trữ trái ác quỷ
    local ToggleStore = Tabs.Fruit:AddToggle("ToggleStore", {
        Title = "Tự Động Lưu Trữ", 
        Default = false 
    })
    
    ToggleStore:OnChanged(function(Value)
        spawn(function()
            while Value do
                FruitManager:StoreFruits()
                wait(0.3)
            end
        end)
    end)
    
    -- Toggle thu thập trái ngẫu nhiên
    local ToggleRandomFruit = Tabs.Fruit:AddToggle("ToggleRandomFruit", {
        Title = "Thu Thập Ngẫu Nhiên", 
        Default = false 
    })
    
    ToggleRandomFruit:OnChanged(function(Value)
        spawn(function()
            while Value do
                FruitManager:CollectRandomFruit()
                wait(0.1)
            end
        end)
    end)
    
    -- Toggle thu thập trái trong map
    local ToggleCollect = Tabs.Fruit:AddToggle("ToggleCollect", {
        Title = "Thu Thập Trái Trong Map", 
        Default = false 
    })
    
    ToggleCollect:OnChanged(function(Value)
        spawn(function()
            while Value do
                FruitManager:AutoCollectFruits()
                wait(0.1)
            end
        end)
    end)
    
    -- Các toggle ESP khác được giữ nguyên như code gốc
    -- ...
end

-- Gọi hàm thiết lập giao diện
SetupFruitInterface(Tabs)






--------------------------------------------------------------------------------------------------------------------------------------------
--Raid



local RaidManager = {
    -- Danh sách chip raid
    RaidChips = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"},
    
    -- Biến trạng thái
    SelectedChip = nil,
    IsAutoBuyChips = false,
    IsAutoStartRaid = false,
    IsKillAura = false,
    IsAutoNextIsland = false,
    IsAutoAwaken = false,
    IsAutoGetFruit = false,
    IsAutoLaw = false,
    
    -- Hàm mua chip raid
    BuyRaidChip = function(self)
        if not self.SelectedChip then return end
        
        local success, error = pcall(function()
            local args = {
                [1] = "RaidsNpc",
                [2] = "Select",
                [3] = self.SelectedChip
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end)
        
        if not success then
            warn("Lỗi khi mua chip raid: " .. tostring(error))
        end
    end,
    
    -- Hàm bắt đầu raid
    StartRaid = function(self)
        local player = game:GetService("Players").LocalPlayer
        local worldOrigin = game:GetService("Workspace")["_WorldOrigin"]
        
        if player.PlayerGui.Main.Timer.Visible == false then
            if not worldOrigin.Locations:FindFirstChild("Island 1") then
                local microchip = player.Backpack:FindFirstChild("Special Microchip") or 
                                   player.Character:FindFirstChild("Special Microchip")
                
                if microchip then
                    if Second_Sea then
                        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                    elseif Third_Sea then
                        fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                    end
                end
            end
        end
    end,
    
    -- Hàm kill aura
    KillAura = function(self)
        for _, enemy in pairs(game.Workspace.Enemies:GetDescendants()) do
            if enemy:FindFirstChild("Humanoid") and 
               enemy:FindFirstChild("HumanoidRootPart") and 
               enemy.Humanoid.Health > 0 then
                
                sethiddenproperty(game:GetService('Players').LocalPlayer, "SimulationRadius", math.huge)
                enemy.Humanoid.Health = 0
                enemy.HumanoidRootPart.CanCollide = false
            end
        end
    end,
    
    -- Hàm chuyển đảo
    NextIsland = function(self)
        local worldOrigin = game:GetService("Workspace")["_WorldOrigin"]
        local player = game:GetService("Players").LocalPlayer
        
        if player.PlayerGui.Main.Timer.Visible then
            local islandPriority = {"Island 5", "Island 4", "Island 3", "Island 2", "Island 1"}
            
            for _, islandName in ipairs(islandPriority) do
                local island = worldOrigin.Locations:FindFirstChild(islandName)
                if island then
                    Tween(island.CFrame * CFrame.new(0, 70, 100))
                    break
                end
            end
        end
    end,
    
    -- Hàm tự động kích hoạt năng lực
    AutoAwaken = function(self)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken")
    end,
    
    -- Hàm lấy trái cấp thấp
    GetLowBelyFruit = function(self)
        local lowBelyFruits = {
            "Rocket-Rocket", "Spin-Spin", "Chop-Chop", "Spring-Spring", 
            "Bomb-Bomb", "Smoke-Smoke", "Spike-Spike", "Flame-Flame", 
            "Falcon-Falcon", "Ice-Ice", "Sand-Sand", "Dark-Dark", 
            "Ghost-Ghost", "Diamond-Diamond", "Light-Light", 
            "Rubber-Rubber", "Barrier-Barrier"
        }
        
        for _, fruitName in ipairs(lowBelyFruits) do
            local success, error = pcall(function()
                local args = {
                    [1] = "LoadFruit",
                    [2] = fruitName
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
            
            if not success then
                warn("Lỗi khi lấy trái: " .. tostring(error))
            end
        end
    end,
    
    -- Hàm Auto Law Raid
    AutoLawRaid = function(self)
        local player = game:GetService("Players").LocalPlayer
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local workspace = game:GetService("Workspace")
        
        -- Kiểm tra và lấy microchip
        if not player.Character:FindFirstChild("Microchip") and 
           not player.Backpack:FindFirstChild("Microchip") and 
           not workspace.Enemies:FindFirstChild("Order") and 
           not replicatedStorage:FindFirstChild("Order") then
            
            replicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "1")
            replicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
        end
        
        -- Bắt đầu raid Law
        if not workspace.Enemies:FindFirstChild("Order") and 
           not replicatedStorage:FindFirstChild("Order") then
            
            if player.Character:FindFirstChild("Microchip") or 
               player.Backpack:FindFirstChild("Microchip") then
                fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            end
        end
        
        -- Chiến đấu với Boss Order
        if replicatedStorage:FindFirstChild("Order") or 
           workspace.Enemies:FindFirstChild("Order") then
            
            if workspace.Enemies:FindFirstChild("Order") then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v.Name == "Order" then
                        repeat 
                            wait(_G.Fast_Delay)
                            AttackNoCD()
                            AutoHaki()
                            EquipTool(SelectWeapon)
                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                            v.HumanoidRootPart.CanCollide = false
                            v.HumanoidRootPart.Size = Vector3.new(120, 120, 120)
                        until not v.Parent or v.Humanoid.Health <= 0 or not self.IsAutoLaw
                    end
                end
            elseif replicatedStorage:FindFirstChild("Order") then
                Tween(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
            end
        end
    end
}

-- Hàm thiết lập giao diện Raid
local function SetupRaidInterface(Tabs)
    -- Dropdown chọn chip
    local DropdownRaid = Tabs.Raid:AddDropdown("DropdownRaid", {
        Title = "Chọn Chip Raid",
        Values = RaidManager.RaidChips,
        Multi = false,
        Default = 1,
    })
    
    DropdownRaid:SetValue("...")
    DropdownRaid:OnChanged(function(Value)
        RaidManager.SelectedChip = Value
    end)
    
    -- Các toggle và spawn tương ứng
    local toggleConfigs = {
        {name = "ToggleBuy", var = "IsAutoBuyChips", func = "BuyRaidChip"},
        {name = "ToggleStart", var = "IsAutoStartRaid", func = "StartRaid"},
        {name = "ToggleKillAura", var = "IsKillAura", func = "KillAura"},
        {name = "ToggleNextIsland", var = "IsAutoNextIsland", func = "NextIsland"},
        {name = "ToggleAwake", var = "IsAutoAwaken", func = "AutoAwaken"},
        {name = "ToggleGetFruit", var = "IsAutoGetFruit", func = "GetLowBelyFruit"},
        {name = "ToggleLaw", var = "IsAutoLaw", func = "AutoLawRaid"}
    }
    
    for _, config in ipairs(toggleConfigs) do
        local toggle = Tabs.Raid:AddToggle(config.name, {
            Title = config.name:gsub("Toggle", "Auto "),
            Default = false
        })
        
        toggle:OnChanged(function(Value)
            RaidManager[config.var] = Value
            
            spawn(function()
                while RaidManager[config.var] do
                    pcall(function()
                        RaidManager[config.func](RaidManager)
                    end)
                    wait(0.1)
                end
            end)
        end)
        
        Options[config.name]:SetValue(false)
    end
    
    -- Nút teleport Raid Lab
    if Second_Sea then
        Tabs.Raid:AddButton({
            Title = "Raid Lab",
            Description = "",
            Callback = function()
                Tween2(CFrame.new(-6438.73535, 250.645355, -4501.50684))
            end
        })
    elseif Third_Sea then
        Tabs.Raid:AddButton({
            Title = "Raid Lab",
            Description = "",
            Callback = function()
                Tween2(CFrame.new(-5017.40869, 314.844055, -2823.0127))
            end
        })
    end
end

-- Gọi hàm thiết lập
SetupRaidInterface(Tabs)

--------------------------------------------------------------------------------------------------------------------------------------------
--RaceV4


local RaceManager = {
    -- Vị trí điểm quan trọng
    Locations = {
        TempleOfTime = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875),
        LeverPull = CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734),
        AncientOne = CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375),
        AncientQuest = CFrame.new(216.211181640625, 126.9352035522461, -12599.0732421875)
    },

    -- Cấu hình race door
    RaceDoorLocations = {
        ["Human"] = CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375),
        ["Skypiea"] = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375),
        ["Fishman"] = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156),
        ["Cyborg"] = CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156),
        ["Ghoul"] = CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156),
        ["Mink"] = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094)
    },

    -- Trạng thái các chức năng
    IsAutoTrial = false,
    IsAutoAncientQuest = false,
    IsHumanGhoulTrial = false,

    -- Teleport đến vị trí
    TeleportTo = function(self, location)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = location
    end,

    -- Xử lý race door
    HandleRaceDoor = function(self)
        local player = game:GetService("Players").LocalPlayer
        local currentRace = player.Data.Race.Value
        
        -- Teleport nhiều lần để đảm bảo
        for i = 1, 4 do
            self:TeleportTo(self.Locations.TempleOfTime)
            wait(0.1)
        end
        
        wait(0.5)
        
        -- Teleport đến cổng race tương ứng
        if self.RaceDoorLocations[currentRace] then
            Tween2(self.RaceDoorLocations[currentRace])
        end
    end,

    -- Xử lý thử thách race
    HandleRaceTrial = function(self)
        local player = game:GetService("Players").LocalPlayer
        local currentRace = player.Data.Race.Value

        if currentRace == "Human" or currentRace == "Ghoul" then
            self:KillEnemiesInArea()
        elseif currentRace == "Skypiea" then
            self:HandleSkypieaTrial()
        elseif currentRace == "Fishman" then
            self:HandleFishmanTrial()
        elseif currentRace == "Cyborg" then
            self:HandleCyborgTrial()
        elseif currentRace == "Mink" then
            self:HandleMinkTrial()
        end
    end,

    -- Giết quái trong khu vực
    KillEnemiesInArea = function(self)
        for _, enemy in pairs(game.Workspace.Enemies:GetDescendants()) do
            if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                enemy.Humanoid.Health = 0
                enemy.HumanoidRootPart.CanCollide = false
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
        end
    end,

    -- Xử lý thử thách Skypiea
    HandleSkypieaTrial = function(self)
        for _, v in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetDescendants()) do
            if v.Name == "snowisland_Cylinder.081" then
                Tween(v.CFrame)
                break
            end
        end
    end,

    -- Xử lý thử thách Fishman
    HandleFishmanTrial = function(self)
        local seaBeast = game:GetService("Workspace").SeaBeasts.SeaBeast1
        for _, v in pairs(seaBeast:GetDescendants()) do
            if v.Name == "HumanoidRootPart" then
                self:PerformFishmanActions(v)
                break
            end
        end
    end,

    -- Thực hiện các hành động cho Fishman
    PerformFishmanActions = function(self, target)
        Tween(target.CFrame)
        self:EquipToolByType("Melee")
        self:SendVirtualInput("z")
        self:SendVirtualInput("x")
        self:SendVirtualInput("c")
        
        self:EquipToolByType("Blox Fruit")
        self:SendVirtualInput("z")
        self:SendVirtualInput("x")
        self:SendVirtualInput("c")
        
        self:EquipToolByType("Sword")
        self:SendVirtualInput("z")
        self:SendVirtualInput("x")
        self:SendVirtualInput("c")
        
        self:EquipToolByType("Gun")
        self:SendVirtualInput("z")
        self:SendVirtualInput("x")
        self:SendVirtualInput("c")
    end,

    -- Trang bị vũ khí theo loại
    EquipToolByType = function(self, toolType)
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.ToolTip == toolType then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end
        end
    end,

    -- Gửi input ảo
    SendVirtualInput = function(self, key)
        local keyCode = string.byte(key)
        local inputManager = game:GetService("VirtualInputManager")
        local character = game.Players.LocalPlayer.Character.HumanoidRootPart
        
        inputManager:SendKeyEvent(true, keyCode, false, character)
        wait(0.2)
        inputManager:SendKeyEvent(false, keyCode, false, character)
    end,

    -- Xử lý thử thách Cyborg
    HandleCyborgTrial = function(self)
        Tween(CFrame.new(28654, 14898.7832, -30))
    end,

    -- Xử lý thử thách Mink
    HandleMinkTrial = function(self)
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.Name == "StartPoint" then
                Tween(v.CFrame * CFrame.new(0, 10, 0))
                break
            end
        end
    end,

    -- Quản lý nhiệm vụ cổ đại
    HandleAncientQuest = function(self)
        local ancientEnemies = {
            "Cocoa Warrior", 
            "Chocolate Bar Battler", 
            "Sweet Thief", 
            "Candy Rebel"
        }

        local player = game.Players.LocalPlayer
        local character = player.Character

        -- Kiểm tra trạng thái chuyển đổi
        if character.RaceTransformed.Value then
            self:TeleportTo(self.Locations.AncientQuest)
            return
        end

        -- Tìm và tiêu diệt quái
        local enemies = game:GetService("Workspace").Enemies
        for _, enemyName in ipairs(ancientEnemies) do
            local enemy = enemies:FindFirstChild(enemyName)
            if enemy then
                self:FightEnemy(enemy)
                break
            end
        end

        -- Nếu không có quái, di chuyển đến điểm quest
        if not enemies:FindFirstChild(ancientEnemies[1]) then
            if BypassTP then
                BTP(self.Locations.AncientQuest)
            else
                Tween(self.Locations.AncientQuest)
            end
        end
    end,

    -- Chiến đấu với quái
    FightEnemy = function(self, enemy)
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            repeat 
                wait(_G.Fast_Delay)
                AttackNoCD()
                AutoHaki()
                EquipTool(SelectWeapon)
                
                enemy.HumanoidRootPart.CanCollide = false
                enemy.Humanoid.WalkSpeed = 0
                enemy.Head.CanCollide = false
                
                Tween(enemy.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
            until not self.IsAutoAncientQuest or not enemy.Parent or enemy.Humanoid.Health <= 0
        end
    end
}

-- Thiết lập giao diện Race
local function SetupRaceInterface(Tabs)
    -- Các nút teleport
    local teleportButtons = {
        {"Temple Of Time", RaceManager.Locations.TempleOfTime},
        {"Lever Pull", RaceManager.Locations.LeverPull},
        {"Acient One", RaceManager.Locations.AncientOne}
    }

    for _, buttonInfo in ipairs(teleportButtons) do
        Tabs.Race:AddButton({
            Title = buttonInfo[1],
            Description = "",
            Callback = function()
                RaceManager:TeleportTo(buttonInfo[2])
            end
        })
    end

    -- Nút Race Door
    Tabs.Race:AddButton({
        Title = "Race Door",
        Description = "",
        Callback = function()
            RaceManager:HandleRaceDoor()
        end
    })

    -- Toggle và spawn các chức năng
    local toggleConfigs = {
        {
            name = "ToggleHumanandghoul", 
            var = "IsHumanGhoulTrial", 
            title = "Auto [ Human / Ghoul ] Trial"
        },
        {
            name = "ToggleAutotrial", 
            var = "IsAutoTrial", 
            title = "Auto Trial"
        },
        {
            name = "ToggleAutoAcientQuest", 
            var = "IsAutoAncientQuest", 
            title = "Auto Acient Quest"
        }
    }

    for _, config in ipairs(toggleConfigs) do
        local toggle = Tabs.Race:AddToggle(config.name, {
            Title = config.title, 
            Default = false
        })

        toggle:OnChanged(function(Value)
            RaceManager[config.var] = Value
            
            spawn(function()
                while RaceManager[config.var] do
                    pcall(function()
                        if config.var == "IsAutoTrial" then
                            RaceManager:HandleRaceTrial()
                        elseif config.var == "IsAutoAncientQuest" then
                            RaceManager:HandleAncientQuest()
                        end
                    end)
                    wait(0.1)
                end
            end)
        end)

        Options[config.name]:SetValue(false)
    end

    -- Spawn các luồng phụ
    spawn(function()
        while wait() do
            pcall(function()
                if RaceManager.IsAutoAncientQuest then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game)
                end
            end)
        end
    end)
end

-- Gọi hàm thiết lập
SetupRaceInterface(Tabs)
--------------------------------------------------------------------------------------------------------------------------------------------
--Quest Dojo

local DojoTrainerManager = {
    -- Cấu hình vị trí
    Locations = {
        DojoIsland = CFrame.new(-1868.67346, 44.4773941, 1863.94348),
        NinjaTrainer = CFrame.new(-1868.67346, 44.4773941, 1863.94348),
        FirstDojo = CFrame.new(-1868.67346, 44.4773941, 1863.94348),
        SecondDojo = CFrame.new(-1868.67346, 44.4773941, 1863.94348),
        ThirdDojo = CFrame.new(-1868.67346, 44.4773941, 1863.94348)
    },

    -- Trạng thái chức năng
    IsAutoDojoQuest = false,
    IsAutoDojoFarm = false,
    
    -- Thông tin quest hiện tại
    CurrentQuestProgress = 0,
    MaxQuestProgress = 250,

    -- Hàm kiểm tra điều kiện quest
    CanStartQuest = function(self)
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        -- Kiểm tra level và điều kiện quest
        return player.Level >= 500 and 
               not player.PlayerGui.Main.Quest.Visible and 
               character:FindFirstChild("Humanoid").Health > 0
    end,

    -- Hàm nhận quest từ NPC
    StartDojoQuest = function(self)
        local npcParts = game:GetService("Workspace").NPCs:GetChildren()
        local ninjaTrainer = nil

        -- Tìm NPC Ninja Trainer
        for _, npc in pairs(npcParts) do
            if npc.Name == "Ninja Trainer" then
                ninjaTrainer = npc
                break
            end
        end

        if ninjaTrainer then
            -- Teleport đến NPC
            Tween(ninjaTrainer:FindFirstChild("HumanoidRootPart").CFrame)
            wait(1)

            -- Tương tác với NPC để nhận quest
            fireclickdetector(ninjaTrainer:FindFirstChild("ClickDetector", true))
        end
    end,

    -- Hàm farm quest Dojo
    FarmDojoQuest = function(self)
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Kiểm tra quest đang hoạt động
        local questGui = player.PlayerGui.Main.Quest
        if not questGui.Visible then return end

        -- Xác định mục tiêu quest
        local questTarget = questGui.Container.QuestTitle.Title.Text:match("Kill (.+)")
        if not questTarget then return end

        -- Tìm và tiêu diệt quái
        local enemies = game:GetService("Workspace").Enemies:GetChildren()
        for _, enemy in pairs(enemies) do
            if enemy.Name == questTarget and 
               enemy:FindFirstChild("Humanoid") and 
               enemy:FindFirstChild("HumanoidRootPart") and 
               enemy.Humanoid.Health > 0 then
                
                -- Di chuyển và tấn công
                Tween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                
                -- Sử dụng các hàm attack
                AttackNoCD()
                AutoHaki()
                EquipTool(SelectWeapon)

                -- Đảm bảo quái chết
                enemy.Humanoid.Health = 0
                enemy.HumanoidRootPart.CanCollide = false
            end
        end
    end,

    -- Hàm teleport đến Dojo
    TeleportToDojo = function(self)
        Tween(self.Locations.DojoIsland)
    end,

    -- Hàm chọn level Dojo
    SelectDojoLevel = function(self, level)
        local dojoLevels = {
            [1] = self.Locations.FirstDojo,
            [2] = self.Locations.SecondDojo,
            [3] = self.Locations.ThirdDojo
        }

        if dojoLevels[level] then
            Tween(dojoLevels[level])
        end
    end,

    -- Hàm chính quản lý quest Dojo
    ManageDojoQuest = function(self)
        -- Kiểm tra điều kiện bắt đầu quest
        if self:CanStartQuest() then
            self:StartDojoQuest()
        end

        -- Farm quest nếu đã nhận
        self:FarmDojoQuest()
    end,

    -- Hàm auto farm Dojo
    AutoFarmDojo = function(self)
        local player = game:GetService("Players").LocalPlayer

        -- Di chuyển đến Dojo
        self:TeleportToDojo()

        -- Chọn level Dojo
        self:SelectDojoLevel(1)  -- Mặc định level 1, có thể thay đổi

        -- Chiến đấu và nhận thưởng
        while self.IsAutoDojoFarm do
            -- Tìm và đánh quái
            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    Tween(enemy.HumanoidRootPart.CFrame)
                    
                    -- Tấn công
                    AttackNoCD()
                    AutoHaki()
                    EquipTool(SelectWeapon)
                end
            end

            wait(0.5)
        end
    end
}

-- Hàm thiết lập giao diện
local function SetupDojoInterface(Tabs)
    -- Toggle Auto Dojo Quest
    local toggleDojoQuest = Tabs.Dojo:AddToggle("ToggleDojoQuest", {
        Title = "Auto Dojo Quest", 
        Default = false 
    })

    toggleDojoQuest:OnChanged(function(Value)
        DojoTrainerManager.IsAutoDojoQuest = Value
        
        spawn(function()
            while DojoTrainerManager.IsAutoDojoQuest do
                pcall(function()
                    DojoTrainerManager:ManageDojoQuest()
                end)
                wait(0.5)
            end
        end)
    end)

    -- Toggle Auto Farm Dojo
    local toggleDojoFarm = Tabs.Dojo:AddToggle("ToggleDojoFarm", {
        Title = "Auto Farm Dojo", 
        Default = false 
    })

    toggleDojoFarm:OnChanged(function(Value)
        DojoTrainerManager.IsAutoDojoFarm = Value
        
        spawn(function()
            while DojoTrainerManager.IsAutoDojoFarm do
                pcall(function()
                    DojoTrainerManager:AutoFarmDojo()
                end)
                wait(0.5)
            end
        end)
    end)

    -- Nút Teleport Dojo
    Tabs.Dojo:AddButton({
        Title = "Teleport Dojo",
        Description = "Di chuyển đến đảo Dojo",
        Callback = function()
            DojoTrainerManager:TeleportToDojo()
        end
    })

    -- Dropdown chọn level Dojo
    Tabs.Dojo:AddDropdown("DojoLevelSelect", {
        Title = "Chọn Level Dojo",
        Values = {"Level 1", "Level 2", "Level 3"},
        Multi = false,
        Default = 1,
        Callback = function(Value)
            local level = tonumber(Value:match("%d"))
            DojoTrainerManager:SelectDojoLevel(level)
        end
    })
end

-- Gọi hàm thiết lập
SetupDojoInterface(Tabs)

--------------------------------------------------------------------------------------------------------------------------------------------
--shop

local ShopManager = {
    -- Danh sách các chức năng mua
    BuyFunctions = {
        -- Haki
        Geppo = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo") 
        end,
        Buso = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso") 
        end,
        Soru = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru") 
        end,
        KenHaki = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy") 
        end,

        -- Fighting Styles
        BlackLeg = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg") 
        end,
        Electro = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro") 
        end,
        FishmanKarate = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate") 
        end,
        DragonClaw = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
        end,
        Superhuman = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman") 
        end,
        DeathStep = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep") 
        end,
        SharkmanKarate = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
        end,
        ElectricClaw = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw") 
        end,
        DragonTalon = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon") 
        end,
        Godhuman = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman") 
        end,

        -- Misc
        RefundStats = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
        end,
        RerollRace = function() 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
        end
    },

    -- Tự động mua Bone
    AutoRandomBone = {
        IsEnabled = false,
        Start = function(self)
            spawn(function()
                while self.IsEnabled do
                    local args = {
                        [1] = "Bones",
                        [2] = "Buy",
                        [3] = 1,
                        [4] = 1
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    task.wait(0.1)  -- Sử dụng task.wait() để hiệu quả hơn
                end
            end)
        end,
        Stop = function(self)
            self.IsEnabled = false
        end
    }
}

-- Thiết lập giao diện Shop
local function SetupShopInterface(Tabs)
    -- Toggle Random Bone
    local ToggleRandomBone = Tabs.Shop:AddToggle("ToggleRandomBone", {
        Title = "Random Bone", 
        Default = false 
    })

    ToggleRandomBone:OnChanged(function(Value)
        ShopManager.AutoRandomBone.IsEnabled = Value
        if Value then
            ShopManager.AutoRandomBone:Start()
        else
            ShopManager.AutoRandomBone:Stop()
        end
    end)

    -- Hàm tạo nút mua chung
    local function CreateBuyButton(name, buyFunction)
        Tabs.Shop:AddButton({
            Title = name,
            Description = "Mua " .. name,
            Callback = function()
                pcall(buyFunction)  -- Sử dụng pcall để tránh lỗi
            end
        })
    end

    -- Phần Haki
    local HakiSection = Tabs.Shop:AddSection("Haki")
    CreateBuyButton("Geppo", ShopManager.BuyFunctions.Geppo)
    CreateBuyButton("Buso Haki", ShopManager.BuyFunctions.Buso)
    CreateBuyButton("Soru", ShopManager.BuyFunctions.Soru)
    CreateBuyButton("Ken Haki", ShopManager.BuyFunctions.KenHaki)

    -- Phần Fighting Styles
    local FightingStylesSection = Tabs.Shop:AddSection("Fighting Styles")
    CreateBuyButton("Black Leg", ShopManager.BuyFunctions.BlackLeg)
    CreateBuyButton("Electro", ShopManager.BuyFunctions.Electro)
    CreateBuyButton("Fishman Karate", ShopManager.BuyFunctions.FishmanKarate)
    CreateBuyButton("Dragon Claw", ShopManager.BuyFunctions.DragonClaw)
    CreateBuyButton("Superhuman", ShopManager.BuyFunctions.Superhuman)
    CreateBuyButton("Death Step", ShopManager.BuyFunctions.DeathStep)
    CreateBuyButton("Sharkman Karate", ShopManager.BuyFunctions.SharkmanKarate)
    CreateBuyButton("Electric Claw", ShopManager.BuyFunctions.ElectricClaw)
    CreateBuyButton("Dragon Talon", ShopManager.BuyFunctions.DragonTalon)
    CreateBuyButton("Godhuman", ShopManager.BuyFunctions.Godhuman)

    -- Phần Misc
    local MiscSection = Tabs.Shop:AddSection("Misc Items")
    CreateBuyButton("Refund Stats", ShopManager.BuyFunctions.RefundStats)
    CreateBuyButton("Reroll Race", ShopManager.BuyFunctions.RerollRace)
end

-- Gọi hàm thiết lập
SetupShopInterface(Tabs)

--------------------------------------------------------------------------------------------------------------------------------------------
--misc

local ServerHopManager = {
    -- Quản lý chức năng chuyển server
    HopServer = function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        
        local function TPReturner()
            local Site = game.HttpService:JSONDecode(
                game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. 
                '/servers/Public?sortOrder=Asc&limit=100' .. 
                (foundAnything ~= "" and "&cursor=" .. foundAnything or ""))
            )
            
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" then
                foundAnything = Site.nextPageCursor
            end
            
            for _, serverData in pairs(Site.data) do
                local serverID = tostring(serverData.id)
                local availableSlots = tonumber(serverData.maxPlayers) - tonumber(serverData.playing)
                
                if availableSlots > 0 and not table.find(AllIDs, serverID) then
                    table.insert(AllIDs, serverID)
                    
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, serverID, game.Players.LocalPlayer)
                    end)
                    
                    return true
                end
            end
            
            return false
        end
        
        local function Teleport()
            while true do
                if TPReturner() then break end
                task.wait(1)
            end
        end
        
        Teleport()
    end,

    -- Các chức năng UI và mở cửa sổ
    UIFunctions = {
        OpenDevilShop = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
            game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitShop.Visible = true
        end,
        
        OpenColorHaki = function()
            game.Players.LocalPlayer.PlayerGui.Main.Colors.Visible = true
        end,
        
        OpenTitleName = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getTitles")
            game.Players.LocalPlayer.PlayerGui.Main.Titles.Visible = true
        end,
        
        OpenAwakening = function()
            game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
        end
    },

    -- Chức năng trolling
    TrollingFunctions = {
        RainFruit = function()
            local fruitModel = game:GetObjects("rbxassetid://15970729030")[1]
            local player = game.Players.LocalPlayer
            local character = player.Character
            
            if not character then return end
            
            for _, v in pairs(fruitModel:GetChildren()) do
                v.Parent = game.Workspace.Map
                v:MoveTo(character.PrimaryPart.Position + Vector3.new(
                    math.random(-50, 50), 
                    100, 
                    math.random(-50, 50)
                ))
                
                local fruit = v:FindFirstChild("Fruit")
                if fruit and fruit:FindFirstChild("AnimationController") then
                    local animation = fruit:FindFirstChild("Idle")
                    if animation then
                        fruit.AnimationController:LoadAnimation(animation):Play()
                    end
                end
                
                v.Handle.Touched:Connect(function(otherPart)
                    if otherPart.Parent == character then
                        v.Parent = player.Backpack
                    end
                end)
            end
        end
    }
}

-- Thiết lập giao diện
local function SetupMiscInterface(Tabs)
    -- Kiểm tra Sea để hiển thị phù hợp
    if not Third_Sea then
        local SeaSection = Tabs.Hop:AddSection("Third Sea Please !!!")
    else
        -- Toggle tìm trăng đầy
        local ToggleFindMoon = Tabs.Hop:AddToggle("ToggleFindMoon", {
            Title = "Find Full Moon", 
            Default = false 
        })
        
        ToggleFindMoon:OnChanged(function(Value)
            _G.AutoFindMoon = Value
        end)
    end

    -- Phần Server
    local ServerSection = Tabs.Misc:AddSection("Server")
    Tabs.Misc:AddButton({
        Title = "Rejoin Server",
        Description = "Quay lại server hiện tại",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
    })

    Tabs.Misc:AddButton({
        Title = "Hop Server", 
        Description = "Chuyển sang server khác",
        Callback = ServerHopManager.HopServer
    })

    -- Phần Open UI
    local UISection = Tabs.Misc:AddSection("Open Ui")
    
    local UIButtons = {
        {"Devil Shop", ServerHopManager.UIFunctions.OpenDevilShop},
        {"Color Haki", ServerHopManager.UIFunctions.OpenColorHaki},
        {"Title Name", ServerHopManager.UIFunctions.OpenTitleName},
        {"Open Awakening", ServerHopManager.UIFunctions.OpenAwakening}
    }

    for _, buttonInfo in ipairs(UIButtons) do
        Tabs.Misc:AddButton({
            Title = buttonInfo[1],
            Description = "",
            Callback = buttonInfo[2]
        })
    end

    -- Phần Trolling
    local TrollingSection = Tabs.Misc:AddSection("Trolling")
    Tabs.Misc:AddButton({
        Title = "Rain Fruit",
        Description = "Rain fruit (Fake)",
        Callback = ServerHopManager.TrollingFunctions.RainFruit
    })
end

-- Gọi hàm thiết lập
SetupMiscInterface(Tabs)





--------------------------------------------------------------------------------------------------------------------------------------------
--Hop
(false)


spawn(function()
    while wait() do
        if _G.AutoFindMoon then
        if game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149052" or game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431" then
            wait(2.0)
        elseif game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709143733" then
            Hop()
            Fluent:Notify({
                Title = "NINO Hub",
                Content = "Turn Off Find Full Moon...",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        elseif game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709150401" then
            Hop()
            Fluent:Notify({
                Title = "NINO Hub",
                Content = "Hop...",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        elseif game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149680" then
            Hop()
            Fluent:Notify({
                Title = "NINO Hub",
                Content = "Hop...",
                SubContent = "", -- Optional
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        else
            Hop()
            end
        end
    end
end)


local ToggleMirageIsland = Tabs.Hop:AddToggle("ToggleMirageIsland", {Title = "Find Mirage Island", Default = false })
ToggleMirageIsland:OnChanged(function(Value)
    _G.FindMirageIsland = Value
end)
Options.ToggleMirageIsland:SetValue(false)

spawn(function()
    while wait() do
    if _G.FindMirageIsland then
        if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") or game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
            if HighestPointRealCFrame and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - HighestPointRealCFrame.Position).Magnitude > 10 then
            Tween(getHighestPoint().CFrame * CFrame.new(0, 211.88, 0))
                end
        elseif not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") or not game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
            Hop()
            end
        end
    end
end)
end

------------------------------------------------------------------------------------------------------------------------------------------
