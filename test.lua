repeat task.wait() until game:IsLoaded()

-- ============================================================
-- A Project Chick Chick (Headless Multi-Instance Version)
-- ============================================================

local Config = getgenv().Config
if not Config then
    warn("AProject: Config not found!")
    return
end

local SeedsList = {
    "All", "Acorn", "Apple", "Baby Cactus", "Bamboo", "Banana", "Beanstalk", "Blueberry", 
    "Buttercup", "Cactus", "Carrot", "Cherry", "Coconut", "Corn", "Dragon Fruit", 
    "Dragon's Breath", "Ghost Pepper", "Glow Mushroom", "Gold", "Grape", "Green Bean", 
    "Horned Melon", "Lotus", "Mango", "Moon Bloom", "Mushroom", "Pineapple", "Pinetree", 
    "Poison Apple", "Poison Ivy", "Pomegranate", "Pumpkin", "Rainbow", "Romanesco", 
    "Strawberry", "Sunflower", "Thorn Rose", "Tomato", "Tulip", "Venus Fly Trap"
}

local GearsList = {
    "All", "Common Watering Can", "Common Sprinkler", "Sign", "Lantern", "Wheelbarrow", 
    "Uncommon Sprinkler", "Rare Sprinkler", "Legendary Sprinkler", "Super Sprinkler", 
    "Trowel", "Speed Mushroom", "Jump Mushroom", "Gnome", "Shrink Mushroom", 
    "Supersize Mushroom", "Invisibility Mushroom", "Teleporter", "Super Watering Can", 
    "Basic Pot", "Flashbang"
}

local PetsPrices = {
    ["Frog"] = 10000,
    ["Bunny"] = 20000,
    ["Owl"] = 25000,
    ["Deer"] = 50000,
    ["Robin"] = 75000,
    ["Bee"] = 1000000,
    ["Monkey"] = 1000000,
    ["Black Dragon"] = 1000000,
    ["Golden Dragonfly"] = 3000000,
    ["Unicorn"] = 4000000,
    ["Raccoon"] = 5000000
}

-- ============================================================
-- Auto Bypass (Loading Screen & Tutorial)
-- ============================================================
task.spawn(function()
    -- 1. บังคับข้ามหน้าสอนเล่น (Tutorial) เพื่อให้ส่งของให้คนอื่นได้เลย
    pcall(function()
        local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
        Networking.Tutorial.Complete:Fire()
    end)
    
    -- 2. ข้ามหน้าโหลดเกม (สำหรับคนเปิดหลายจอแล้วเมาส์ไม่ได้อยู่ในจอ)
    task.spawn(function()
        local vim = game:GetService("VirtualInputManager")
        for i = 1, 60 do -- เช็คเผื่อโหลดช้าเป็นเวลา 120 วินาที
            local needsToPress = false
            pcall(function()
                local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
                if playerGui then
                    local loadingGui = playerGui:FindFirstChild("LoadingGui")
                    if loadingGui and loadingGui.Enabled then
                        needsToPress = true
                    end
                end
            end)
            
            if needsToPress then
                vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.1)
                vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
            task.wait(2)
        end
    end)
end)

local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)

-- Helper Function for converting Array to Lookup Dictionary for easier checking
local function getLookup(arr)
    local dict = {}
    local hasAll = false
    if type(arr) == "table" then
        for _, v in ipairs(arr) do
            if v == "All" then hasAll = true end
            dict[v] = true
        end
    elseif type(arr) == "string" then
        if arr == "All" then hasAll = true end
        dict[arr] = true
    end
    return dict, hasAll
end

-- ============================================================
-- Core Loops
-- ============================================================

-- [1] Auto Harvest
task.spawn(function()
    while true do
        if Config.AutoHarvest then
            pcall(function()
                for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.ActionText == "Harvest" then
                        fireproximityprompt(prompt)
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)

-- [2] Auto Plant
task.spawn(function()
    while true do
        if Config.AutoPlant then
            pcall(function()
                local lp = game.Players.LocalPlayer
                local plotId = lp:GetAttribute("PlotId")
                if not plotId then return end
                
                local plot = workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId))
                if not plot then return end
                
                local plantAreas = {}
                for _, v in ipairs(game:GetService("CollectionService"):GetTagged("PlantArea")) do
                    if v:IsDescendantOf(plot) then
                        table.insert(plantAreas, v)
                    end
                end
                if #plantAreas == 0 then return end
                
                local plantsFolder = plot:FindFirstChild("Plants")
                if not plantsFolder then return end

                local validSeeds, hasAll = getLookup(Config.PlantSeeds)
                if not next(validSeeds) and not hasAll then return end

                local tool = nil
                local function checkTool(item)
                    if item:IsA("Tool") and item:GetAttribute("SeedTool") then
                        local seedName = string.gsub(item.Name, " Seed", "")
                        if hasAll or validSeeds[seedName] then
                            return item
                        end
                    end
                    return nil
                end
                
                for _, v in ipairs(lp.Backpack:GetChildren()) do
                    tool = checkTool(v)
                    if tool then break end
                end
                if not tool and lp.Character then
                    for _, v in ipairs(lp.Character:GetChildren()) do
                        tool = checkTool(v)
                        if tool then break end
                    end
                end

                if tool then
                    local seedId = tool:GetAttribute("SeedTool")
                    local area = plantAreas[math.random(1, #plantAreas)]
                    if area then
                        local size = area.Size
                        local cf = area.CFrame
                        for i = 1, 10 do
                            local rx = (math.random() - 0.5) * size.X
                            local rz = (math.random() - 0.5) * size.Z
                            local tryPos = cf * Vector3.new(rx, size.Y/2, rz)
                            
                            local tooClose = false
                            for _, plant in ipairs(plantsFolder:GetChildren()) do
                                if plant:IsA("Model") and plant.PrimaryPart then
                                    local pPos = plant.PrimaryPart.Position
                                    if (Vector2.new(tryPos.X, tryPos.Z) - Vector2.new(pPos.X, pPos.Z)).Magnitude < 1.5 then
                                        tooClose = true
                                        break
                                    end
                                end
                            end
                            
                            if not tooClose then
                                Networking.Plant.PlantSeed:Fire(tryPos, seedId, tool)
                                task.wait(0.2)
                                break
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- [3] Auto Pick Event
task.spawn(function()
    local tickCounter = 0
    while true do
        if Config.AutoPickEvent then
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                
                local mapFolder = game:GetService("Workspace"):FindFirstChild("Map")
                if mapFolder then
                    local seedPackFolder = mapFolder:FindFirstChild("SeedPackSpawnServerLocations")
                    if seedPackFolder then
                        for _, item in ipairs(seedPackFolder:GetChildren()) do
                            if item:IsA("BasePart") or item:IsA("Model") then
                                local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                                if prompt then fireproximityprompt(prompt) end
                                
                                local targetPart = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)) or item
                                if hrp and targetPart and targetPart:IsA("BasePart") then
                                    if firetouchinterest then
                                        firetouchinterest(hrp, targetPart, 0)
                                        firetouchinterest(hrp, targetPart, 1)
                                    end
                                    hrp.CFrame = targetPart.CFrame
                                    task.wait() 
                                end
                            end
                        end
                    end
                end

                tickCounter = tickCounter + 1
                if tickCounter >= 10 then 
                    tickCounter = 0
                    local droppedItemsFolder = game:GetService("Workspace"):FindFirstChild("DroppedItems")
                    if droppedItemsFolder then
                        for _, item in ipairs(droppedItemsFolder:GetDescendants()) do
                            if item:IsA("ProximityPrompt") then
                                fireproximityprompt(item)
                            end
                        end
                    end
                    
                    for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            local text = string.lower(prompt.ActionText)
                            if text == "collect" or text == "pick up" or text == "pickup" or text == "open" or text == "take" then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end
            end)
        end
        task.wait()
    end
end)

-- [4] Auto Sell Full Backpack
task.spawn(function()
    while true do
        if Config.AutoSellFull then
            pcall(function()
                local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
                if PlayerGui then
                    local backpackGui = PlayerGui:FindFirstChild("BackpackGui")
                    if backpackGui then
                        local invLabel = backpackGui:FindFirstChild("FruitInventory", true)
                        if invLabel and invLabel:IsA("TextLabel") then
                            local current, max = string.match(invLabel.Text, "(%d+)/(%d+)")
                            if current and max then
                                if tonumber(current) >= tonumber(max) then
                                    Networking.NPCS.SellAll:Fire()
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- [5] Anti AFK
task.spawn(function()
    local AntiAfkConnection
    while true do
        if Config.AntiAfk then
            if not AntiAfkConnection then
                local VirtualUser = game:GetService("VirtualUser")
                AntiAfkConnection = game.Players.LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end
        else
            if AntiAfkConnection then
                AntiAfkConnection:Disconnect()
                AntiAfkConnection = nil
            end
        end
        task.wait(5)
    end
end)

-- [6] Auto Buy Seeds
task.spawn(function()
    while true do
        if Config.AutoBuySeeds then
            pcall(function()
                local valid, hasAll = getLookup(Config.BuySeedsList)
                local function buy(seed)
                    if seed ~= "All" then
                        Networking.SeedShop.PurchaseSeed:Fire(seed)
                        task.wait(0.1)
                    end
                end
                
                if hasAll then
                    for _, seed in ipairs(SeedsList) do buy(seed) end
                else
                    for seed, _ in pairs(valid) do buy(seed) end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- [7] Auto Buy Gears
task.spawn(function()
    while true do
        if Config.AutoBuyGears then
            pcall(function()
                local valid, hasAll = getLookup(Config.BuyGearsList)
                local function buy(gear)
                    if gear ~= "All" then
                        Networking.GearShop.PurchaseGear:Fire(gear)
                        task.wait(0.1)
                    end
                end
                
                if hasAll then
                    for _, gear in ipairs(GearsList) do buy(gear) end
                else
                    for gear, _ in pairs(valid) do buy(gear) end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- [8] Auto Sell Select Fruits
task.spawn(function()
    while true do
        if Config.AutoSellFruits then
            pcall(function()
                local valid, hasAll = getLookup(Config.SellFruitsList)
                if hasAll then
                    Networking.NPCS.SellAll:Fire()
                else
                    local player = game.Players.LocalPlayer
                    local toolsToSell = {}
                    
                    local function checkFolder(folder)
                        for _, tool in ipairs(folder:GetChildren()) do
                            if tool:IsA("Tool") then
                                local fruitName = tool:GetAttribute("FruitName")
                                if fruitName and valid[fruitName] then
                                    local id = tool:GetAttribute("Id")
                                    if id then table.insert(toolsToSell, id) end
                                end
                            end
                        end
                    end
                    
                    if player.Character then checkFolder(player.Character) end
                    checkFolder(player.Backpack)
                    
                    for _, id in ipairs(toolsToSell) do
                        Networking.NPCS.SellFruit:Fire(id)
                        task.wait(0.1)
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- [9] Auto Send Mail
task.spawn(function()
    local TargetUserIdCache = {}
    local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
    
    while true do
        if Config.AutoSendMail then
            pcall(function()
                local targetName = Config.TargetPlayerMail
                if targetName and targetName ~= "" then
                    local targetUserId = TargetUserIdCache[targetName]
                    if not targetUserId then
                        local s, r = pcall(function()
                            return game.Players:GetUserIdFromNameAsync(targetName)
                        end)
                        if s and r then
                            targetUserId = r
                            TargetUserIdCache[targetName] = r
                        end
                    end
                    
                    if targetUserId then
                        local inventory = PlayerStateClient.GetLocalReplica().Data.Inventory
                        local itemsToSend = {}
                        
                        local seedsDict, isAllSeeds = getLookup(Config.SendSeedsList)
                        local gearsDict, isAllGears = getLookup(Config.SendGearsList)
                        
                        for category, categoryItems in pairs(inventory) do
                            if category ~= "HarvestedFruits" and category ~= "Pets" then
                                for itemKey, count in pairs(categoryItems) do
                                    if count > 0 then
                                        local shouldSend = false
                                        if category == "Seeds" then
                                            if isAllSeeds or seedsDict[itemKey] then shouldSend = true end
                                        else
                                            if isAllGears or gearsDict[itemKey] then shouldSend = true end
                                        end
                                        
                                        if shouldSend then
                                            table.insert(itemsToSend, {
                                                Category = category,
                                                ItemKey = itemKey,
                                                Count = count
                                            })
                                        end
                                    end
                                end
                            end
                        end
                        
                        if #itemsToSend > 0 then
                            local batch = {}
                            for _, item in ipairs(itemsToSend) do
                                table.insert(batch, item)
                                if #batch >= 5 then
                                    Networking.Mailbox.SendBatch:Fire(targetUserId, batch, "Gift")
                                    task.wait(1.5)
                                    batch = {}
                                end
                            end
                            if #batch > 0 then
                                Networking.Mailbox.SendBatch:Fire(targetUserId, batch, "Gift")
                                task.wait(1.5)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(2)
    end
end)

-- [10] Auto Buy Pets
task.spawn(function()
    local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
    while true do
        if Config.AutoBuyPets then
            pcall(function()
                local valid, hasAll = getLookup(Config.BuyPetsList)
                local targetPets = {}
                if hasAll then
                    for pet, _ in pairs(PetsPrices) do targetPets[pet] = true end
                else
                    for pet, _ in pairs(valid) do targetPets[pet] = true end
                end
                
                local replicaData = PlayerStateClient.GetLocalReplica().Data
                local myMoney = replicaData.Sheckles or replicaData.Coins or replicaData.Cash or replicaData.Money or 0
                local lp = game.Players.LocalPlayer
                local char = lp.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if not hrp then return end

                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and targetPets[obj.Name] then
                        local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt and prompt.Enabled then
                            local price = PetsPrices[obj.Name] or 0
                            if myMoney >= price then
                                local targetCFrame = obj.PrimaryPart and obj.PrimaryPart.CFrame or obj:GetModelCFrame()
                                if targetCFrame then
                                    hrp.CFrame = targetCFrame
                                    task.wait(0.3)
                                    fireproximityprompt(prompt)
                                    task.wait(0.5)
                                    
                                    local plotId = lp:GetAttribute("PlotId")
                                    if plotId then
                                        local plot = workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId))
                                        if plot then
                                            local plotCFrame = plot.PrimaryPart and plot.PrimaryPart.CFrame or plot:GetModelCFrame()
                                            hrp.CFrame = plotCFrame + Vector3.new(0, 10, 0)
                                            task.wait(1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

