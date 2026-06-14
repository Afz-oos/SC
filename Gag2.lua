local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Afz-oos/PJAX/refs/heads/main/Config.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "A Project Chick Chick",
    SubTitle = "by Ao Pro Free",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Override theme to light blue
Fluent:SetTheme("Amethyst")
local customAccent = Color3.fromRGB(100, 180, 255)

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "gamepad-2" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Trade = Window:AddTab({ Title = "Trade", Icon = "arrow-left-right" }),
    Pets = Window:AddTab({ Title = "Pets", Icon = "smile" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

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
        local VirtualInputManager = game:GetService("VirtualInputManager")

        local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
        task.wait(25)
        VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, true, game, 0)
        task.wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, false, game, 0)
    end)
end)

-- ============================================================
-- Main Tab
-- ============================================================

Tabs.Main:AddParagraph({
    Title = "🎮 A Project",
    Content = "Welcome to A Project\n[Discord] ChickChick\nPower By Ao Pro Free"
})

-- ============================================================
-- Farm Tab
-- ============================================================

local AutoHarvestTask

local Toggle = Tabs.Farm:AddToggle("AutoHarvestToggle", {Title = "Auto Harvest", Default = false })
Toggle:OnChanged(function()
    if Options.AutoHarvestToggle.Value then
        AutoHarvestTask = task.spawn(function()
            while Options.AutoHarvestToggle.Value do
                pcall(function()
                    for _, prompt in ipairs(game:GetService("Workspace"):GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and prompt.ActionText == "Harvest" then
                            fireproximityprompt(prompt)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    else
        if AutoHarvestTask then
            task.cancel(AutoHarvestTask)
            AutoHarvestTask = nil
        end
    end
end)

local AutoPlantTask
local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)

local PlantSeedDropdown = Tabs.Farm:AddDropdown("SelectPlantSeed", {
    Title = "Select Seeds to Plant",
    Values = SeedsList,
    Multi = true,
    Default = {"Apple"},
})

local PlantToggle = Tabs.Farm:AddToggle("AutoPlantToggle", {Title = "Auto Plant (Use Seeds from Inventory)", Default = false })
PlantToggle:OnChanged(function()
    if Options.AutoPlantToggle.Value then
        AutoPlantTask = task.spawn(function()
            while Options.AutoPlantToggle.Value do
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

                    -- Validate selected seeds
                    local selectedSeeds = Options.SelectPlantSeed.Value
                    local validSeeds = {}
                    if type(selectedSeeds) == "table" then
                        for k, v in pairs(selectedSeeds) do
                            if type(k) == "number" and type(v) == "string" then
                                validSeeds[v] = true
                            elseif type(k) == "string" and v == true then
                                validSeeds[k] = true
                            end
                        end
                    end
                    if not next(validSeeds) then return end

                    -- Find a seed tool
                    local tool = nil
                    for _, v in ipairs(lp.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v:GetAttribute("SeedTool") then
                            local seedName = string.gsub(v.Name, " Seed", "")
                            if validSeeds[seedName] then
                                tool = v
                                break
                            end
                        end
                    end
                    if not tool and lp.Character then
                        for _, v in ipairs(lp.Character:GetChildren()) do
                            if v:IsA("Tool") and v:GetAttribute("SeedTool") then
                                local seedName = string.gsub(v.Name, " Seed", "")
                                if validSeeds[seedName] then
                                    tool = v
                                    break
                                end
                            end
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
                task.wait(0.5)
            end
        end)
    else
        if AutoPlantTask then
            task.cancel(AutoPlantTask)
            AutoPlantTask = nil
        end
    end
end)

local AutoPickEventTask

local PickToggle = Tabs.Farm:AddToggle("AutoPickEventToggle", {Title = "Auto Pick Event", Default = false })
PickToggle:OnChanged(function()
    if Options.AutoPickEventToggle.Value then
        AutoPickEventTask = task.spawn(function()
            local tickCounter = 0
            while Options.AutoPickEventToggle.Value do
                pcall(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    
                    -- 1. ลุยโฟลเดอร์ SeedPackSpawnServerLocations เร็วพิเศษแบบไม่มีดีเลย์!
                    local mapFolder = game:GetService("Workspace"):FindFirstChild("Map")
                    if mapFolder then
                        local seedPackFolder = mapFolder:FindFirstChild("SeedPackSpawnServerLocations")
                        if seedPackFolder then
                            for _, item in ipairs(seedPackFolder:GetChildren()) do
                                if item:IsA("BasePart") or item:IsA("Model") then
                                    local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                                    if prompt then
                                        fireproximityprompt(prompt)
                                    end
                                    
                                    local targetPart = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)) or item
                                    if hrp and targetPart and targetPart:IsA("BasePart") then
                                        -- ชนแล้วเก็บทันทีไม่มีรอ!
                                        if firetouchinterest then
                                            firetouchinterest(hrp, targetPart, 0)
                                            firetouchinterest(hrp, targetPart, 1)
                                        end
                                        hrp.CFrame = targetPart.CFrame
                                        task.wait() -- วาร์ปรัวๆทีละเฟรม
                                    end
                                end
                            end
                        end
                    end

                    tickCounter = tickCounter + 1
                    if tickCounter >= 10 then -- เช็คโฟลเดอร์ใหญ่ทุกๆ 10 เฟรมเพื่อไม่ให้เกมแลค
                        tickCounter = 0
                        -- 2. ดึงจาก DroppedItems (ของตกทั่วไปรวมถึงของ Event)
                        local droppedItemsFolder = game:GetService("Workspace"):FindFirstChild("DroppedItems")
                        if droppedItemsFolder then
                            for _, item in ipairs(droppedItemsFolder:GetDescendants()) do
                                if item:IsA("ProximityPrompt") then
                                    fireproximityprompt(item)
                                end
                            end
                        end
                        
                        -- 3. ดึงจาก Workspace เผื่อว่าของ Event มันไม่ได้อยู่ใน DroppedItems
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
                task.wait() -- ไวแสง! (รันทุกๆเฟรมเรนเดอร์ของจอ 60fps+)
            end
        end)
    else
        if AutoPickEventTask then
            task.cancel(AutoPickEventTask)
            AutoPickEventTask = nil
        end
    end
end)

local AutoSellFullTask

local SellFullToggle = Tabs.Farm:AddToggle("AutoSellFullToggle", {Title = "Auto Sell Backpack Full", Default = false })
SellFullToggle:OnChanged(function()
    if Options.AutoSellFullToggle.Value then
        AutoSellFullTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            while Options.AutoSellFullToggle.Value do
                pcall(function()
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
                end)
                task.wait(1)
            end
        end)
    else
        if AutoSellFullTask then
            task.cancel(AutoSellFullTask)
            AutoSellFullTask = nil
        end
    end
end)

local AntiAfkConnection
local AntiAfkToggle = Tabs.Farm:AddToggle("AntiAfkToggle", {Title = "Advanced Anti AFK", Default = false })
AntiAfkToggle:OnChanged(function()
    if Options.AntiAfkToggle.Value then
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
end)

-- ============================================================
-- Shop Tab
-- ============================================================

local Dropdown = Tabs.Shop:AddDropdown("SelectSeed", {
    Title = "Select Seeds",
    Values = SeedsList,
    Multi = true,
    Default = {"Apple"},
})

local AutoBuyTask

local BuyToggle = Tabs.Shop:AddToggle("AutoBuyToggle", {Title = "Auto Buy Selected Seeds", Default = false })
BuyToggle:OnChanged(function()
    if Options.AutoBuyToggle.Value then
        AutoBuyTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            while Options.AutoBuyToggle.Value do
                pcall(function()
                    local currentSelection = Options.SelectSeed.Value
                    if type(currentSelection) == "table" then
                        local hasAll = false
                        local selected = {}
                        for k, v in pairs(currentSelection) do
                            local seedToBuy
                            if type(k) == "number" and type(v) == "string" then
                                seedToBuy = v
                            elseif type(k) == "string" and v == true then
                                seedToBuy = k
                            end
                            if seedToBuy == "All" then hasAll = true end
                            if seedToBuy then selected[seedToBuy] = true end
                        end
                        
                        local function buy(seed)
                            if seed ~= "All" then
                                Networking.SeedShop.PurchaseSeed:Fire(seed)
                                task.wait(0.1)
                            end
                        end
                        
                        if hasAll then
                            for _, seed in ipairs(SeedsList) do buy(seed) end
                        else
                            for seed, _ in pairs(selected) do buy(seed) end
                        end
                    elseif type(currentSelection) == "string" then
                        if currentSelection == "All" then
                            for _, seed in ipairs(SeedsList) do
                                if seed ~= "All" then
                                    Networking.SeedShop.PurchaseSeed:Fire(seed)
                                    task.wait(0.1)
                                end
                            end
                        else
                            Networking.SeedShop.PurchaseSeed:Fire(currentSelection)
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        if AutoBuyTask then
            task.cancel(AutoBuyTask)
            AutoBuyTask = nil
        end
    end
end)

local GearsList = {
    "Common Watering Can", "Common Sprinkler", "Sign", "Lantern", "Wheelbarrow", 
    "Uncommon Sprinkler", "Rare Sprinkler", "Legendary Sprinkler", "Super Sprinkler", 
    "Trowel", "Speed Mushroom", "Jump Mushroom", "Gnome", "Shrink Mushroom", 
    "Supersize Mushroom", "Invisibility Mushroom", "Teleporter", "Super Watering Can", 
    "Basic Pot", "Flashbang"
}

local GearDropdown = Tabs.Shop:AddDropdown("SelectGear", {
    Title = "Select Gears",
    Values = GearsList,
    Multi = true,
    Default = {"Common Watering Can"},
})

local AutoBuyGearTask

local BuyGearToggle = Tabs.Shop:AddToggle("AutoBuyGearToggle", {Title = "Auto Buy Selected Gears", Default = false })
BuyGearToggle:OnChanged(function()
    if Options.AutoBuyGearToggle.Value then
        AutoBuyGearTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            while Options.AutoBuyGearToggle.Value do
                pcall(function()
                    local currentSelection = Options.SelectGear.Value
                    if type(currentSelection) == "table" then
                        local hasAll = false
                        local selected = {}
                        for k, v in pairs(currentSelection) do
                            local gearToBuy
                            if type(k) == "number" and type(v) == "string" then
                                gearToBuy = v
                            elseif type(k) == "string" and v == true then
                                gearToBuy = k
                            end
                            if gearToBuy == "All" then hasAll = true end
                            if gearToBuy then selected[gearToBuy] = true end
                        end
                        
                        local function buy(gear)
                            if gear ~= "All" then
                                Networking.GearShop.PurchaseGear:Fire(gear)
                                task.wait(0.1)
                            end
                        end
                        
                        if hasAll then
                            for _, gear in ipairs(GearsList) do buy(gear) end
                        else
                            for gear, _ in pairs(selected) do buy(gear) end
                        end
                    elseif type(currentSelection) == "string" then
                        if currentSelection == "All" then
                            for _, gear in ipairs(GearsList) do
                                if gear ~= "All" then
                                    Networking.GearShop.PurchaseGear:Fire(gear)
                                    task.wait(0.1)
                                end
                            end
                        else
                            Networking.GearShop.PurchaseGear:Fire(currentSelection)
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        if AutoBuyGearTask then
            task.cancel(AutoBuyGearTask)
            AutoBuyGearTask = nil
        end
    end
end)

local SellDropdown = Tabs.Shop:AddDropdown("SelectSell", {
    Title = "Select Fruits to Sell",
    Values = SeedsList,
    Multi = true,
    Default = {"All"},
})

local AutoSellTask

local SellToggle = Tabs.Shop:AddToggle("AutoSellToggle", {Title = "Auto Sell Selected Fruits", Default = false })
SellToggle:OnChanged(function()
    if Options.AutoSellToggle.Value then
        AutoSellTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            while Options.AutoSellToggle.Value do
                pcall(function()
                    local currentSelection = Options.SelectSell.Value
                    local selectedFruits = {}
                    
                    if type(currentSelection) == "table" then
                        for k, v in pairs(currentSelection) do
                            if type(k) == "number" and type(v) == "string" then
                                selectedFruits[v] = true
                            elseif type(k) == "string" and v == true then
                                selectedFruits[k] = true
                            end
                        end
                    elseif type(currentSelection) == "string" then
                        selectedFruits[currentSelection] = true
                    end
                    
                    if selectedFruits["All"] then
                        -- ถ้าเลือก All ให้กดขายทั้งหมดผ่าน SellAll ทันที
                        Networking.NPCS.SellAll:Fire()
                    else
                        -- ถ้าเลือกเฉพาะบางอัน ให้ค้นหา Tool ในตัวเราที่มี FruitName ตรงกัน
                        local player = game.Players.LocalPlayer
                        local toolsToSell = {}
                        
                        local function checkFolder(folder)
                            for _, tool in ipairs(folder:GetChildren()) do
                                if tool:IsA("Tool") then
                                    local fruitName = tool:GetAttribute("FruitName")
                                    if fruitName and selectedFruits[fruitName] then
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
                task.wait(1) -- รันเช็คทุกๆ 1 วินาที
            end
        end)
    else
        if AutoSellTask then
            task.cancel(AutoSellTask)
            AutoSellTask = nil
        end
    end
end)

-- ============================================================
-- Treads Tab
-- ============================================================

local AutoSendMailTask
local TargetUserIdCache = {}

local TargetPlayerInput = Tabs.Trade:AddInput("TargetPlayerMail", {
    Title = "Target Player Name",
    Default = "",
    Placeholder = "Enter username here",
    Numeric = false,
    Finished = false,
})

local SendSeedDropdown = Tabs.Trade:AddDropdown("SelectSeedToSend", {
    Title = "Select Seeds to Send",
    Values = SeedsList,
    Multi = true,
    Default = {},
})

local SendGearDropdown = Tabs.Trade:AddDropdown("SelectGearToSend", {
    Title = "Select Gears to Send",
    Values = GearsList,
    Multi = true,
    Default = {},
})

local SendMailToggle = Tabs.Trade:AddToggle("AutoSendMailToggle", {Title = "Auto SendMail", Default = false })
SendMailToggle:OnChanged(function()
    if Options.AutoSendMailToggle.Value then
        AutoSendMailTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
            
            while Options.AutoSendMailToggle.Value do
                pcall(function()
                    local targetName = Options.TargetPlayerMail.Value
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
                            
                            local selSeeds = Options.SelectSeedToSend.Value
                            local selGears = Options.SelectGearToSend.Value
                            
                            local isAllSeeds = false
                            local seedsDict = {}
                            if type(selSeeds) == "table" then
                                for k, v in pairs(selSeeds) do
                                    local name = type(k) == "number" and v or k
                                    if name == "All" and (v == true or type(k) == "number") then isAllSeeds = true end
                                    if v == true or type(k) == "number" then seedsDict[name] = true end
                                end
                            end
                            
                            local isAllGears = false
                            local gearsDict = {}
                            if type(selGears) == "table" then
                                for k, v in pairs(selGears) do
                                    local name = type(k) == "number" and v or k
                                    if name == "All" and (v == true or type(k) == "number") then isAllGears = true end
                                    if v == true or type(k) == "number" then gearsDict[name] = true end
                                end
                            end
                            
                            for category, categoryItems in pairs(inventory) do
                                if category ~= "HarvestedFruits" and category ~= "Pets" then
                                    for itemKey, count in pairs(categoryItems) do
                                        if count > 0 then
                                            local shouldSend = false
                                            if category == "Seeds" then
                                                if isAllSeeds or seedsDict[itemKey] then
                                                    shouldSend = true
                                                end
                                            else
                                                if isAllGears or gearsDict[itemKey] then
                                                    shouldSend = true
                                                end
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
                task.wait(2)
            end
        end)
    else
        if AutoSendMailTask then
            task.cancel(AutoSendMailTask)
            AutoSendMailTask = nil
        end
    end
end)

-- ============================================================
-- Pets Tab
-- ============================================================

local PetsList = {"All"}
for pet, _ in pairs(PetsPrices) do
    table.insert(PetsList, pet)
end

local PetDropdown = Tabs.Pets:AddDropdown("SelectPetToBuy", {
    Title = "Select Pets to Auto Buy",
    Values = PetsList,
    Multi = true,
    Default = {"All"},
})

local AutoBuyPetTask
local BuyPetToggle = Tabs.Pets:AddToggle("AutoBuyPetToggle", {Title = "Auto Buy Selected Pets", Default = false })

BuyPetToggle:OnChanged(function()
    if Options.AutoBuyPetToggle.Value then
        AutoBuyPetTask = task.spawn(function()
            local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
            while Options.AutoBuyPetToggle.Value do
                pcall(function()
                    local selectedPets = Options.SelectPetToBuy.Value
                    local targetPets = {}
                    local hasAll = false
                    
                    if type(selectedPets) == "table" then
                        for k, v in pairs(selectedPets) do
                            local name = type(k) == "number" and v or k
                            if name == "All" and (v == true or type(k) == "number") then hasAll = true end
                            if v == true or type(k) == "number" then targetPets[name] = true end
                        end
                    end
                    
                    if hasAll then
                        for pet, _ in pairs(PetsPrices) do targetPets[pet] = true end
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
                                    local oldPos = hrp.CFrame
                                    local targetCFrame = obj.PrimaryPart and obj.PrimaryPart.CFrame or obj:GetModelCFrame()
                                    if targetCFrame then
                                        hrp.CFrame = targetCFrame
                                        task.wait(0.3)
                                        fireproximityprompt(prompt)
                                        task.wait(0.5)
                                        
                                        -- Escort back to garden safely
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
                task.wait(1)
            end
        end)
    else
        if AutoBuyPetTask then
            task.cancel(AutoBuyPetTask)
            AutoBuyPetTask = nil
        end
    end
end)

-- ============================================================
-- Settings Tab (Save/Load Config + Interface)
-- ============================================================

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

-- Fix SaveManager Dropdown Multi Bug
SaveManager.Parser.Dropdown = {
    Save = function(idx, object)
        return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
    end,
    Load = function(idx, data)
        if SaveManager.Options[idx] then 
            local val = data.value
            if data.mutli and type(val) == "table" then
                local dict = {}
                for k, v in pairs(val) do
                    if type(k) == "number" and type(v) == "string" then
                        dict[v] = true
                    else
                        dict[k] = v
                    end
                end
                SaveManager.Options[idx]:SetValue(dict)
            else
                SaveManager.Options[idx]:SetValue(val)
            end
        end
    end,
}

InterfaceManager:SetFolder("AProject")
SaveManager:SetFolder("AProject/config")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- ============================================================
-- Select default tab & notify
-- ============================================================

Window:SelectTab(1)

Fluent:Notify({
    Title = "A Project",
    Content = "โหลดสคริปสำเร็จ!",
    Duration = 5
})

SaveManager:LoadAutoloadConfig()

-- ============================================================
-- Mobile UI Toggle Button (Draggable)
-- ============================================================
task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local existingToggle = CoreGui:FindFirstChild("AProjectMobileToggle")
    if existingToggle then existingToggle:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AProjectMobileToggle"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Parent = ScreenGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Position = UDim2.new(0, 50, 0, 50)
    ToggleButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "UI"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 18
    ToggleButton.AutoButtonColor = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = ToggleButton

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(100, 180, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = ToggleButton

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local dragStartPos = Vector3.new()

    local function update(input)
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ToggleButton.Position
            dragStartPos = input.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    local dist = (input.Position - dragStartPos).Magnitude
                    if dist < 15 then
                        local vim = game:GetService("VirtualInputManager")
                        vim:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                        task.wait()
                        vim:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                    end
                end
            end)
        end
    end)

    ToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end)
