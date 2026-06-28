-- Credit note for using the script
-- This script is created by constanceprimeau. If you use it or improve upon it, please credit appropriately.
--getgenv().StratCreditsAuthor = "Optional"
repeat task.wait() until game:IsLoaded()
if getgenv().mapcheckerbetter then
    print("has better map checker on")
else
    getgenv().mapcheckerbetter = false
end

getgenv().Typefarm = "Survival" --if you want Hardcore change it to Hardcore else not hardcore then Survival
local map = {"Tropical Isles","Toyboard","Summer Castle","Abyssal Trench"} -- put map here
local towersToEquip = {"Minigunner", "Tesla", "Commander", "Turret", "Cowboy"}
local Remote = game:GetService("ReplicatedStorage").RemoteFunction
local RunService = game:GetService("RunService") or cloneref(game:GetService("RunService"))
local TeleportService = game:GetService("TeleportService") or cloneref(game:GetService("TeleportService")) 
RunService:Set3dRenderingEnabled(false)
-- setfpscap custom creation
if getgenv().antilagprefix then
    local RunService = game:GetService("RunService")
    local FPSCap = 15
    local frameTime = 1 / FPSCap

    RunService.Heartbeat:Connect(function()
        local t0 = tick()

        while (tick() - t0) < frameTime do

            task.wait()
        end
    end)
end
local function checkmap(map)
--coming soon
end
function claimDailyQuest() 
for _,v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Quests"):WaitForChild("RF:RequestState"):InvokeServer().groups.daily) do 
for _,a in pairs(v) do  -- Claim All Quest
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Quests"):WaitForChild("RF:ClaimQuest"):InvokeServer(a)
task.wait(0.2)
end
end
end
function claimWeeklyQuest()
for _,v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Quests"):WaitForChild("RF:RequestState"):InvokeServer().groups.weekly) do 
for _,a in pairs(v) do  -- Claim All Quest
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Quests"):WaitForChild("RF:ClaimQuest"):InvokeServer(a)
task.wait(0.2)
end
end
end
local function redeemreward()
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("DailySpin"):WaitForChild("RF:RedeemReward"):InvokeServer()
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("DailySpin"):WaitForChild("RF:RedeemSpin"):InvokeServer()
for i=1,6 do 
local args = {
	i
}
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("PlaytimeRewards"):WaitForChild("RF:ClaimReward"):InvokeServer(unpack(args))
claimWeeklyQuest()
claimDailyQuest() 
end
end
local function equipTowers()
    local troops = Remote:InvokeServer("Session", "Search", "Inventory.Troops")
    for i, v in pairs(troops) do
        if v.Equipped then --and table.find(towersToEquip,i.Name) then --and table.find(towersToEquip, i.Name)  then
            print(i .. " is already equipped.")
        elseif not v.Equipped and table.find(towersToEquip, i.Name) then
            Remote:FireServer("Inventory","Unequip","Tower",i)
            local args = {
                [1] = "Inventory",
                [2] = "Equip",
                [3] = "tower",
                [4] = i
            }
            Remote:InvokeServer(unpack(args))
            print("Equipped tower: " .. i)
        end
    end
end
--[[local function equipTowers()

    local troops = Remote:InvokeServer("Session", "Search", "Inventory.Troops")

    if not troops then
        print("Error: Failed to fetch troops.")
        return
    end

    -- Iterate through troops and equip towers
    for i, v in pairs(troops) do
        if v.Equipped and table.find(towersToEquip, i.Name) then
            print(v.Name .. " is already equipped and in the list.")
        elseif not v.Equipped and table.find(towersToEquip, i.Name) then
            Remote:FireServer("Inventory","Unequip","Tower",i)
            local args = {
                [1] = "Inventory",
                [2] = "Equip",
                [3] = "tower",
                [4] = i
            }
            Remote:InvokeServer(unpack(args))
            print("Equipped tower: " .. v.Name)
        end
    end
end]]

if game.PlaceId == 3260590327 then
    equipTowers()
    redeemreward()
    --[[if Hardcore then 
        local Elevators = game:GetService("Workspace").Elevator
    else
        local Elevators = game:GetService("Workspace").NewLobby.Elevator
    ]]
    while true do
        task.wait()
        for _, elevator in pairs(game:GetService("Workspace").NewLobby.Elevators:GetChildren()) do
            local elevatorMap = elevator:GetAttribute("Map")
            local ElevatorType = elevator:GetAttribute("Type")
            local playerCount = elevator:GetAttribute("Players")

            if table.find(map, elevatorMap) and playerCount < 1 and ElevatorType == getgenv().Typefarm  then
game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Elevators"):WaitForChild("RF:Enter"):InvokeServer(elevator)
                print("Joined elevator with map: " .. elevatorMap)
                task.wait(0.1)
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Elevators"):WaitForChild("RF:SetSize"):InvokeServer(1)
                task.wait(0.01)
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Elevators"):WaitForChild("RF:SetReady"):InvokeServer(true)

            elseif playerCount > 2 then

                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Elevators"):WaitForChild("RF:Leave"):InvokeServer()
                print("Left the elevator due to too many players.")
            end
        end
    end

elseif game.PlaceId == 5591597781 then
-- idk but it's the same
    --[[if getgenv().mapcheckerbetter then
    local currentMap = game:GetService("Workspace"):GetAttribute("Map")
    else
    local currentMap = game:GetService("ReplicatedStorage").State.Map.Value
end
    local currentMap = game:GetService("ReplicatedStorage").State.Map.Value]]
local currentMap
game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer("TicketsManager","UnlockTimeScale")
for i=1,2 do -- make it to x2
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer("TicketsManager","CycleTimeScale")
task.wait(0.1)
end
if getgenv().mapcheckerbetter then
    currentMap = game:GetService("Workspace"):GetAttribute("Map")
else
    currentMap = game:GetService("ReplicatedStorage").State.Map.Value
end
 if currentMap == map[1] then
        print("Current map is: " .. map[1])
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chief575012/TDS-FARM/refs/heads/main/MoltenFarmV2/Tropical_Isles"))()
    elseif currentMap == map[2] then
        print("Current map is: " .. map[2])
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chief575012/TDS-FARM/refs/heads/main/MoltenFarmV2/Toyboard.lua"))()
    elseif currentMap == map[3] then
        print("Current map is: " .. map[3])
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chief575012/TDS-FARM/refs/heads/main/MoltenFarmV2/Summer_Castle.lua"))()
     elseif currentMap == map[4] then
        print("Current map is: " .. map[3])
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chief575012/TDS-FARM/refs/heads/main/MoltenFarmV2/Abyssal_Trench.lua"))()
   --[[

   elseif currentMap == map[5] then
        print("Current map is: " .. map[5])

    elseif currentMap == map[6] then
        print("Current map is: " .. map[6])]]

else
TeleportService:Teleport(3260590327)
    end
end
getgenv().testingaudiofarm = true
if getgenv().testingaudiofarm then
    local workspace = game:GetService("Workspace")
local musicValue = workspace:WaitForChild("Music")

musicValue:GetPropertyChangedSignal("Value"):Connect(function()
    if musicValue.Value ~= "adidasLobby" then
        musicValue.Value = "adidasLobby"
    end
end)
end
getgenv().aprilfools = false
if getgenv().aprilfools then
if game.PlaceId == 5591597781 then
repeat task.wait() until game:GetService("ReplicatedStorage").Assets.Troops.Scout
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Define the folder path
local scoutSkinsFolder = replicatedStorage.Assets.Troops.Scout.Skins

-- The ID of the new model to insert
local modelId = "rbxassetid://72418216100327"

-- Load the model using game:GetObjects
local success, objects = pcall(function()
    return game:GetObjects(modelId)
end)

if success and objects then
    -- If the model is successfully loaded, proceed with the replacement
    local newModel = objects[1] -- Get the first object (it should be the model)

    -- Remove any existing model called "Haz3mn"
    local existingModel = scoutSkinsFolder:FindFirstChild("Default")
    if existingModel then
        existingModel:Destroy()
    end

    -- Rename the new model and set its parent
    newModel.Name = "Default"
    newModel.Parent = scoutSkinsFolder
    print("Model replaced and renamed successfully.")
else
    print("Failed to load the model. Please check the model ID or permissions.")
end
end
end
