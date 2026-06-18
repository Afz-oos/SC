if getgenv().Gag2RunningID then
    getgenv().Gag2RunningID = getgenv().Gag2RunningID + 1
else
    getgenv().Gag2RunningID = 1
end
local currentID = getgenv().Gag2RunningID

repeat task.wait() until game:IsLoaded()

-- ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¸Ã‚Â¸ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¹Ã…â€™ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â² GitHub Rate Limit ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢
task.wait(math.random(10, 50) / 10) 

local function safeLoadstringCached(url, fileName)
    if isfile and readfile and writefile then
        if isfile(fileName) then
            local content = readfile(fileName)
            if content and string.len(content) > 100 then
                return loadstring(content)()
            end
        end
    end
    
    local success, result
    repeat
        success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if not success or not result or string.len(result) < 100 then
            task.wait(math.random(2, 5))
            success = false
        end
    until success
    
    if isfile and writefile then
        pcall(function() writefile(fileName, result) end)
    end
    
    return loadstring(result)()
end

local Fluent = safeLoadstringCached("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", "AProject_Fluent.lua")
local SaveManager = safeLoadstringCached("https://raw.githubusercontent.com/Afz-oos/PJAX/refs/heads/main/Config.lua", "AProject_SaveManager.lua")
local InterfaceManager = safeLoadstringCached("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua", "AProject_Interface.lua")

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
    Gift = Window:AddTab({ Title = "Gift", Icon = "gift" }),
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
    -- 1. ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ (Tutorial) ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â¢
    pcall(function()
        local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
        Networking.Tutorial.Complete:Fire()
    end)
    
    -- 2. ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¡ (ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¸Ã‚Â³ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¹Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¹Ã…â€™ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚Â¹ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­)
    task.spawn(function()
        local VirtualInputManager = game:GetService("VirtualInputManager")
        task.wait(25)
        pcall(function()
            local screenCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
            VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, false, game, 0)
        end)
    end)
end)

-- ============================================================
-- Main Tab
-- ============================================================

Tabs.Main:AddParagraph({
    Title = "Grow A Garden 2 | By ChickChick",
    Content = "Welcome to ChickChick\n[Discord] ChickChick\nPower By Ao Pro Free"
})

-- ============================================================
-- Farm Tab
-- ============================================================

local AutoHarvestTask

local Toggle = Tabs.Farm:AddToggle("AutoHarvestToggle", {Title = "Auto Harvest", Default = false })
Toggle:OnChanged(function()
    if Options.AutoHarvestToggle.Value then
        AutoHarvestTask = task.spawn(function()
            local lp = game.Players.LocalPlayer
            while Options.AutoHarvestToggle.Value and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    local myPlotId = lp:GetAttribute("PlotId")
                    local gardens = game:GetService("Workspace"):FindFirstChild("Gardens")
                    if gardens then
                        if myPlotId then
                            local plot = gardens:FindFirstChild("Plot" .. tostring(myPlotId))
                            if plot then
                                local plants = plot:FindFirstChild("Plants")
                                if plants then
                                    for _, plant in ipairs(plants:GetChildren()) do
                                        local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
                                        if prompt and prompt.ActionText == "Harvest" then
                                            fireproximityprompt(prompt)
                                        end
                                    end
                                end
                            end
                        else
                            -- Fallback ÃƒÂ Ã‚Â¸ ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã¢â‚¬Å“ÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Âµ PlotId
                            for _, plot in ipairs(gardens:GetChildren()) do
                                local plants = plot:FindFirstChild("Plants")
                                if plants then
                                    for _, plant in ipairs(plants:GetChildren()) do
                                        local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
                                        if prompt and prompt.ActionText == "Harvest" then
                                            fireproximityprompt(prompt)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5) -- ÃƒÂ Ã‚Â¹ ÃƒÂ Ã‚Â¸ ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¹ ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚ÂªÃƒÂ Ã‚Â¹ ÃƒÂ Ã‚Â¸ ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¸Ã…Â¸ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã…â€™ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°
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
            while Options.AutoPlantToggle.Value and getgenv().Gag2RunningID == currentID do
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

                    local hasAll = validSeeds["All"] == true

                    -- Find a seed tool
                    local tool = nil
                    for _, v in ipairs(lp.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v:GetAttribute("SeedTool") then
                            local seedName = string.gsub(v.Name, " Seed", "")
                            if validSeeds[seedName] or hasAll then
                                tool = v
                                break
                            end
                        end
                    end
                    if not tool and lp.Character then
                        for _, v in ipairs(lp.Character:GetChildren()) do
                            if v:IsA("Tool") and v:GetAttribute("SeedTool") then
                                local seedName = string.gsub(v.Name, " Seed", "")
                                if validSeeds[seedName] or hasAll then
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
local _seedPackConnections = {}

local PickToggle = Tabs.Farm:AddToggle("AutoPickEventToggle", {Title = "Auto Pick Event", Default = false })
PickToggle:OnChanged(function()
    if Options.AutoPickEventToggle.Value then
        AutoPickEventTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local mapFolder = workspace:FindFirstChild("Map")
            if not mapFolder then return end
            
            local pickedPacks = {}
            
            local function grabPack(item)
                if pickedPacks[item] then return end
                pickedPacks[item] = true
                
                -- Fire ClickPack FIRST (before teleport = fastest possible)
                pcall(function() Networking.SeedPack.ClickPack:Fire(item) end)
                
                -- Teleport to it
                local lp = game.Players.LocalPlayer
                local char = lp and lp.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local tp = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)) or item
                    if tp and tp:IsA("BasePart") then
                        hrp.CFrame = tp.CFrame
                    end
                end
                
                -- Fire again after teleport (double tap)
                pcall(function() Networking.SeedPack.ClickPack:Fire(item) end)
                
                -- Fallback methods
                local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt then fireproximityprompt(prompt) end
                if hrp and firetouchinterest then
                    local tp2 = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)) or item
                    if tp2 and tp2:IsA("BasePart") then
                        firetouchinterest(hrp, tp2, 0)
                        firetouchinterest(hrp, tp2, 1)
                    end
                end
            end
            
            -- ChildAdded: detect new seed packs INSTANTLY
            local foldersToWatch = {
                mapFolder:FindFirstChild("SeedPackSpawnClient"),
                mapFolder:FindFirstChild("SeedPackSpawnServerLocations"),
            }
            
            for _, folder in ipairs(foldersToWatch) do
                if folder then
                    for _, item in ipairs(folder:GetChildren()) do
                        task.spawn(grabPack, item)
                    end
                    local conn = folder.ChildAdded:Connect(function(item)
                        if Options.AutoPickEventToggle.Value and getgenv().Gag2RunningID == currentID then
                            task.spawn(grabPack, item)
                        end
                    end)
                    table.insert(_seedPackConnections, conn)
                end
            end
            
            -- Backup loop: recheck + DroppedItems + Workspace prompts
            local tickCounter = 0
            while Options.AutoPickEventToggle.Value and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    for _, folder in ipairs(foldersToWatch) do
                        if folder then
                            for _, item in ipairs(folder:GetChildren()) do
                                if not pickedPacks[item] then
                                    task.spawn(grabPack, item)
                                end
                            end
                        end
                    end
                    
                    tickCounter = tickCounter + 1
                    if tickCounter >= 30 then
                        tickCounter = 0
                        local droppedItemsFolder = workspace:FindFirstChild("DroppedItems")
                        if droppedItemsFolder then
                            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            for _, item in ipairs(droppedItemsFolder:GetChildren()) do
                                if hrp then
                                    local tp = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart", true)) or item
                                    if tp and tp:IsA("BasePart") then hrp.CFrame = tp.CFrame end
                                end
                                local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                        for _, prompt in ipairs(workspace:GetDescendants()) do
                            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                                local text = string.lower(prompt.ActionText)
                                if text == "collect" or text == "pick up" or text == "pickup" or text == "open" or text == "take" or text == "grab" or text == "dig" or text == "dig up" then
                                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if hrp and prompt.Parent and prompt.Parent:IsA("BasePart") then
                                        hrp.CFrame = prompt.Parent.CFrame
                                    end
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    else
        if AutoPickEventTask then
            task.cancel(AutoPickEventTask)
            AutoPickEventTask = nil
        end
        for _, conn in ipairs(_seedPackConnections) do
            pcall(function() conn:Disconnect() end)
        end
        _seedPackConnections = {}
    end
end)

local AutoSellFullTask

local SellFullToggle = Tabs.Farm:AddToggle("AutoSellFullToggle", {Title = "Auto Sell Backpack Full", Default = false })
SellFullToggle:OnChanged(function()
    if Options.AutoSellFullToggle.Value then
        AutoSellFullTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            while Options.AutoSellFullToggle.Value and getgenv().Gag2RunningID == currentID do
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

local AntiStealTask
local AntiStealToggle = Tabs.Farm:AddToggle("AntiStealToggle", {Title = "Anti Steal (Hit nearby players)", Default = false })
AntiStealToggle:OnChanged(function()
    if Options.AntiStealToggle.Value then
        AntiStealTask = task.spawn(function()
            while Options.AntiStealToggle.Value and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    local lp = game.Players.LocalPlayer
                    local char = lp.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    local hrp = char.HumanoidRootPart
                    
                    local myPlot
                    local gardens = game:GetService("Workspace"):FindFirstChild("Gardens")
                    if gardens then
                        for _, plot in ipairs(gardens:GetChildren()) do
                            local ownerVal = plot:FindFirstChild("Owner")
                            if ownerVal and tostring(ownerVal.Value) == lp.Name then
                                myPlot = plot
                                break
                            end
                        end
                    end
                    
                    if myPlot then
                        local centerPart = myPlot:FindFirstChild("PlotSizeReference") or myPlot:FindFirstChild("SpawnPoint") or myPlot.PrimaryPart
                        if centerPart then
                            local plotCenter = centerPart.Position
                            local plotRadius = 60
                            
                            for _, player in ipairs(game.Players:GetPlayers()) do
                                if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                    local targetHrp = player.Character.HumanoidRootPart
                                    local distance = (targetHrp.Position - plotCenter).Magnitude
                                    
                                    if distance <= plotRadius then
                                        local shovel = char:FindFirstChild("Shovel") or (lp:FindFirstChild("Backpack") and lp.Backpack:FindFirstChild("Shovel"))
                                        if shovel then
                                            local hum = char:FindFirstChild("Humanoid")
                                            if hum and shovel.Parent ~= char then
                                                hum:EquipTool(shovel)
                                            end
                                            
                                            local oldCFrame = hrp.CFrame
                                            hrp.CFrame = targetHrp.CFrame * CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
                                            shovel:Activate()
                                                task.wait()
                                            hrp.CFrame = oldCFrame
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(0.2)
            end
        end)
    else
        if AntiStealTask then
            task.cancel(AntiStealTask)
            AntiStealTask = nil
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
            while Options.AutoBuyToggle.Value and getgenv().Gag2RunningID == currentID do
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
            while Options.AutoBuyGearToggle.Value and getgenv().Gag2RunningID == currentID do
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
            while Options.AutoSellToggle.Value and getgenv().Gag2RunningID == currentID do
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
                        -- ÃƒÂ Ã‚Â¸Ã¢â‚¬â€œÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â All ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã…â€œÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ SellAll ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Âµ
                        Networking.NPCS.SellAll:Fire()
                    else
                        -- ÃƒÂ Ã‚Â¸Ã¢â‚¬â€œÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â² Tool ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Âµ FruitName ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢
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
                task.wait(1) -- ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â ÃƒÂ Ã‚Â¹Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Â¸ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¹Ã¢â‚¬Â  1 ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Âµ
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

local SendMailAmountInput = Tabs.Trade:AddInput("SendMailAmount", {
    Title = "Amount to Send (0 = All)",
    Default = "0",
    Placeholder = "Enter amount",
    Numeric = true,
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
            
            local sentTracker = {}
            local targetAmount = tonumber(Options.SendMailAmount.Value) or 0
            
            while Options.AutoSendMailToggle.Value and getgenv().Gag2RunningID == currentID do
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
                                                local finalCount = count
                                                if targetAmount > 0 then
                                                    local sent = sentTracker[itemKey] or 0
                                                    if sent >= targetAmount then
                                                        shouldSend = false
                                                    else
                                                        finalCount = math.min(count, targetAmount - sent)
                                                        sentTracker[itemKey] = sent + finalCount
                                                    end
                                                end
                                                
                                                if shouldSend and finalCount > 0 then
                                                    table.insert(itemsToSend, {
                                                        Category = category,
                                                        ItemKey = itemKey,
                                                        Count = finalCount
                                                    })
                                                end
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

Tabs.Trade:AddButton({
    Title = "Send Mail (Once)",
    Description = "Send the selected items to the target player one time",
    Callback = function()
        task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
            
            local targetName = Options.TargetPlayerMail.Value
            if not targetName or targetName == "" then 
                Fluent:Notify({ Title = "Warning", Content = "Please enter Target Player Name!", Duration = 3 })
                return 
            end
            
            local targetUserId = TargetUserIdCache[targetName]
            if not targetUserId then
                local s, r = pcall(function() return game.Players:GetUserIdFromNameAsync(targetName) end)
                if s and r then
                    targetUserId = r
                    TargetUserIdCache[targetName] = r
                else
                    Fluent:Notify({ Title = "Error", Content = "Player not found!", Duration = 3 })
                    return
                end
            end
            
            local inventory = PlayerStateClient.GetLocalReplica().Data.Inventory
            local itemsToSend = {}
            local targetAmount = tonumber(Options.SendMailAmount.Value) or 0
            
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
                                if isAllSeeds or seedsDict[itemKey] then shouldSend = true end
                            else
                                if isAllGears or gearsDict[itemKey] then shouldSend = true end
                            end
                            
                            if shouldSend then
                                local finalCount = count
                                if targetAmount > 0 then
                                    finalCount = math.min(count, targetAmount)
                                end
                                
                                if finalCount > 0 then
                                    table.insert(itemsToSend, {
                                        Category = category,
                                        ItemKey = itemKey,
                                        Count = finalCount
                                    })
                                end
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
                end
                Fluent:Notify({ Title = "Success", Content = "Sent Mail Successfully!", Duration = 3 })
            else
                Fluent:Notify({ Title = "Warning", Content = "No selected items found in inventory!", Duration = 3 })
            end
        end)
    end
})

-- ============================================================
-- Gift Tab
-- ============================================================

local GiftSeedsList = {"None"}
for _, v in ipairs(SeedsList) do table.insert(GiftSeedsList, v) end

local GiftGearsList = {"None"}
for _, v in ipairs(GearsList) do table.insert(GiftGearsList, v) end

local GiftTargetInput = Tabs.Gift:AddInput("GiftTargetName", {
    Title = "Target Player Name",
    Default = "",
    Placeholder = "Enter username here",
    Numeric = false,
    Finished = false,
})

local GiftAmountInput = Tabs.Gift:AddInput("GiftAmount", {
    Title = "Amount to Send (0 = All)",
    Default = "0",
    Placeholder = "Enter amount",
    Numeric = true,
    Finished = false,
})

local GiftSeedDropdown = Tabs.Gift:AddDropdown("GiftSelectSeed", {
    Title = "Select Seed to Send",
    Values = GiftSeedsList,
    Multi = false,
    Default = "None",
})

local GiftFruitDropdown = Tabs.Gift:AddDropdown("GiftSelectFruit", {
    Title = "Select Fruit to Send",
    Values = GiftSeedsList,
    Multi = false,
    Default = "None",
})

local GiftGearDropdown = Tabs.Gift:AddDropdown("GiftSelectGear", {
    Title = "Select Gear to Send",
    Values = GiftGearsList,
    Multi = false,
    Default = "None",
})

local AutoGiftTask

local AutoGiftToggle = Tabs.Gift:AddToggle("AutoGiftToggle", {Title = "Auto Send Gift", Default = false })
AutoGiftToggle:OnChanged(function()
    if Options.AutoGiftToggle.Value then
        AutoGiftTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
            
            local sentTracker = {}
            while Options.AutoGiftToggle.Value and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    local targetName = Options.GiftTargetName.Value
                    if not targetName or targetName == "" then return end
                    
                    local targetUserId = TargetUserIdCache[targetName]
                    if not targetUserId then
                        local s, r = pcall(function() return game.Players:GetUserIdFromNameAsync(targetName) end)
                        if s and r then
                            targetUserId = r
                            TargetUserIdCache[targetName] = r
                        end
                    end
                    
                    if targetUserId then
                        local inventory = PlayerStateClient.GetLocalReplica().Data.Inventory
                        local itemsToSend = {}
                        local targetAmount = tonumber(Options.GiftAmount.Value) or 0
                        
                        local selSeed = Options.GiftSelectSeed.Value
                        local selFruit = Options.GiftSelectFruit.Value
                        local selGear = Options.GiftSelectGear.Value
                        
                        for category, categoryItems in pairs(inventory) do
                            for itemKey, count in pairs(categoryItems) do
                                if count > 0 then
                                    local shouldSend = false
                                    
                                    if category == "Seeds" and selSeed ~= "None" and (selSeed == "All" or selSeed == itemKey) then
                                        shouldSend = true
                                    elseif category == "HarvestedFruits" and selFruit ~= "None" and (selFruit == "All" or selFruit == itemKey) then
                                        shouldSend = true
                                    elseif category ~= "Seeds" and category ~= "HarvestedFruits" and category ~= "Pets" and selGear ~= "None" and (selGear == "All" or selGear == itemKey) then
                                        shouldSend = true
                                    end
                                    
                                    if shouldSend then
                                        local finalCount = count
                                        if targetAmount > 0 then
                                            local sentKey = category .. "_" .. itemKey
                                            local sent = sentTracker[sentKey] or 0
                                            if sent >= targetAmount then
                                                shouldSend = false
                                            else
                                                finalCount = math.min(count, targetAmount - sent)
                                                sentTracker[sentKey] = sent + finalCount
                                            end
                                        end
                                        
                                        if shouldSend and finalCount > 0 then
                                            table.insert(itemsToSend, {
                                                Category = category,
                                                ItemKey = itemKey,
                                                Count = finalCount
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
                end)
                task.wait(2)
            end
        end)
    else
        if AutoGiftTask then
            task.cancel(AutoGiftTask)
            AutoGiftTask = nil
        end
    end
end)

Tabs.Gift:AddButton({
    Title = "Send Gift (Once)",
    Description = "Send the selected items to the target player one time",
    Callback = function()
        task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            local PlayerStateClient = require(game:GetService("ReplicatedStorage").ClientModules.PlayerStateClient)
            
            local targetName = Options.GiftTargetName.Value
            if not targetName or targetName == "" then 
                Fluent:Notify({ Title = "Warning", Content = "Please enter Target Player Name!", Duration = 3 })
                return 
            end
            
            local targetUserId = TargetUserIdCache[targetName]
            if not targetUserId then
                local s, r = pcall(function() return game.Players:GetUserIdFromNameAsync(targetName) end)
                if s and r then
                    targetUserId = r
                    TargetUserIdCache[targetName] = r
                else
                    Fluent:Notify({ Title = "Error", Content = "Player not found!", Duration = 3 })
                    return
                end
            end
            
            local inventory = PlayerStateClient.GetLocalReplica().Data.Inventory
            local itemsToSend = {}
            local targetAmount = tonumber(Options.GiftAmount.Value) or 0
            
            local selSeed = Options.GiftSelectSeed.Value
            local selFruit = Options.GiftSelectFruit.Value
            local selGear = Options.GiftSelectGear.Value
            
            for category, categoryItems in pairs(inventory) do
                for itemKey, count in pairs(categoryItems) do
                    if count > 0 then
                        local shouldSend = false
                        if category == "Seeds" and selSeed ~= "None" and (selSeed == "All" or selSeed == itemKey) then
                            shouldSend = true
                        elseif category == "HarvestedFruits" and selFruit ~= "None" and (selFruit == "All" or selFruit == itemKey) then
                            shouldSend = true
                        elseif category ~= "Seeds" and category ~= "HarvestedFruits" and category ~= "Pets" and selGear ~= "None" and (selGear == "All" or selGear == itemKey) then
                            shouldSend = true
                        end
                        
                        if shouldSend then
                            local finalCount = count
                            if targetAmount > 0 then
                                finalCount = math.min(count, targetAmount)
                            end
                            
                            if finalCount > 0 then
                                table.insert(itemsToSend, {
                                    Category = category,
                                    ItemKey = itemKey,
                                    Count = finalCount
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
                end
                Fluent:Notify({ Title = "Success", Content = "Sent Gift Successfully!", Duration = 3 })
            else
                Fluent:Notify({ Title = "Warning", Content = "No selected items found in inventory!", Duration = 3 })
            end
        end)
    end
})

local AutoClaimGiftTask
local ClaimGiftToggle = Tabs.Gift:AddToggle("AutoClaimGiftToggle", {Title = "Auto Claim Incoming Gifts", Default = false })
ClaimGiftToggle:OnChanged(function()
    if Options.AutoClaimGiftToggle.Value then
        AutoClaimGiftTask = task.spawn(function()
            local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
            while Options.AutoClaimGiftToggle.Value and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    local s, res = pcall(function() return Networking.Mailbox.OpenInbox:Fire() end)
                    if s and type(res) == "table" then
                        local giftsList = res.Gifts or res
                        if type(giftsList) == "table" then
                            for k, v in pairs(giftsList) do
                                local giftId = type(v) == "table" and (v.Id or k) or k
                                if giftId then
                                    Networking.Mailbox.Claim:Fire(giftId)
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end)
                task.wait(5)
            end
        end)
    else
        if AutoClaimGiftTask then
            task.cancel(AutoClaimGiftTask)
            AutoClaimGiftTask = nil
        end
    end
end)


-- ============================================================
-- Pets Tab
-- ============================================================

local PetsList = {"All", "Frog", "Bunny", "Owl", "Deer", "Robin", "Bee", "Monkey", "Black Dragon", "Golden Dragonfly", "Unicorn", "Raccoon"}

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
            while Options.AutoBuyPetToggle.Value and getgenv().Gag2RunningID == currentID do
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
                    
                    local lp = game.Players.LocalPlayer
                    local char = lp.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if not hrp then return end

                    for _, obj in ipairs(workspace:GetDescendants()) do
                        local petNameMatch = nil
                        for tPet, _ in pairs(targetPets) do
                            if string.find(string.lower(obj.Name), string.lower(tPet)) then
                                petNameMatch = tPet
                                break
                            end
                        end
                        
                        if (obj:IsA("Model") or obj:IsA("BasePart")) and petNameMatch then
                            local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt and prompt.Enabled then
                                -- ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â ÃƒÂ Ã‚Â¹Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ (myMoney >= price) ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¹Ã‚ÂÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã…Â ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­
                                -- ÃƒÂ Ã‚Â¹Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¡ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã‚Â¢ ÃƒÂ Ã‚Â¸Ã¢â‚¬â€œÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â ÃƒÂ Ã‚Â¹Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã¢â‚¬â€œÃƒÂ Ã‚Â¸Ã‚Â¶ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â°ÃƒÂ Ã‚Â¸Ã‚Â¢ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â£ÃƒÂ Ã‚Â¹Ã…â€™ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬Âº
                                local targetCFrame = obj:IsA("Model") and (obj.PrimaryPart and obj.PrimaryPart.CFrame or obj:GetModelCFrame()) or obj.CFrame
                                if targetCFrame then
                                    hrp.CFrame = targetCFrame
                                    task.wait(0.3)
                                    
                                    -- ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â±ÃƒÂ Ã‚Â¸Ã…Â¡ÃƒÂ Ã‚Â¸Ã‚ÂÃƒÂ Ã‚Â¸Ã¢â‚¬Â (Bypass Hold Duration)
                                    local oldHold = prompt.HoldDuration
                                    prompt.HoldDuration = 0
                                    fireproximityprompt(prompt)
                                    task.wait(0.1)
                                    prompt.HoldDuration = oldHold
                                    
                                    task.wait(0.5)
                                    
                                    -- Escort back to garden safely
                                    local plotId = lp:GetAttribute("PlotId")
                                    if plotId then
                                        local plot = workspace.Gardens:FindFirstChild("Plot" .. tostring(plotId))
                                        if plot then
                                            local plotCFrame = plot.PrimaryPart and plot.PrimaryPart.CFrame or plot:GetModelCFrame()
                                            hrp.CFrame = plotCFrame + Vector3.new(0, 10, 0)
                                            task.wait(2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(3) -- ÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬â€œÃƒÂ Ã‚Â¸Ã‚ÂµÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã‚Â 1 ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã¢â‚¬ÂºÃƒÂ Ã‚Â¹Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ 3 ÃƒÂ Ã‚Â¸Ã‚Â§ÃƒÂ Ã‚Â¸Ã‚Â´ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¸Ã‚Â²ÃƒÂ Ã‚Â¸Ã¢â‚¬â€ÃƒÂ Ã‚Â¸Ã‚Âµ ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â¾ÃƒÂ Ã‚Â¸Ã‚Â·ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¹Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â¡ÃƒÂ Ã‚Â¹Ã‹â€ ÃƒÂ Ã‚Â¹Ã†â€™ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¹Ã¢â‚¬Â°ÃƒÂ Ã‚Â¹Ã‚ÂÃƒÂ Ã‚Â¸Ã‚Â¥ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã¢â‚¬Â¢ÃƒÂ Ã‚Â¸Ã‚Â­ÃƒÂ Ã‚Â¸Ã¢â€žÂ¢ÃƒÂ Ã‚Â¹Ã¢â€šÂ¬ÃƒÂ Ã‚Â¸Ã…Â ÃƒÂ Ã‚Â¹Ã¢â‚¬Â¡ÃƒÂ Ã‚Â¸Ã¢â‚¬Å¾ÃƒÂ Ã‚Â¸Ã‚Â«ÃƒÂ Ã‚Â¸Ã‚Â² Pets
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
-- Auto Hop Pets
-- ============================================================

local HopPetsList = {"Black Dragon", "Golden Dragonfly", "Unicorn", "Raccoon", "Frog", "Bunny", "Owl", "Deer", "Robin", "Bee", "Monkey"}

Tabs.Pets:AddParagraph({
    Title = "⚡ Auto Hop Pets",
    Content = "ย้ายเซิฟออโต้หาสัตว์"
})

local HopPetDropdown = Tabs.Pets:AddDropdown("SelectHopPet", {
    Title = "🎯 Select Pets",
    Values = HopPetsList,
    Multi = true,
    Default = {"Black Dragon"},
})

local AutoHopPetTask
local _hopPetRunning = false

local HopPetToggle = Tabs.Pets:AddToggle("AutoHopPetToggle", {Title = "🚀 Auto Hop Pets (Server Hop)", Default = false })

local function saveConfigNow()
    pcall(function()
        local configName = SaveManager.AutoloadConfig
        if configName and configName ~= "" then
            SaveManager:Save(configName)
        else
            SaveManager:Save("default")
        end
    end)
end

HopPetToggle:OnChanged(function()
    if Options.AutoHopPetToggle.Value then
        _hopPetRunning = true
        -- Auto-save config เมื่อเปิดฟังก์ชัน
        saveConfigNow()
        AutoHopPetTask = task.spawn(function()
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local lp = Players.LocalPlayer

            while _hopPetRunning and getgenv().Gag2RunningID == currentID do
                pcall(function()
                    -- ดึง target pets จาก dropdown
                    local selectedPets = Options.SelectHopPet.Value
                    local targetPets = {}
                    if type(selectedPets) == "table" then
                        for k, v in pairs(selectedPets) do
                            local name = type(k) == "number" and v or k
                            if v == true or type(k) == "number" then
                                targetPets[string.lower(name)] = name
                            end
                        end
                    elseif type(selectedPets) == "string" then
                        targetPets[string.lower(selectedPets)] = selectedPets
                    end

                    if not next(targetPets) then return end

                    -- สแกน WildPetSpawns ในเซิร์ฟปัจจุบัน
                    local mapFolder = workspace:FindFirstChild("Map")
                    local spawnsFolder = mapFolder and mapFolder:FindFirstChild("WildPetSpawns")

                    if spawnsFolder then
                        for _, obj in ipairs(spawnsFolder:GetChildren()) do
                            if not _hopPetRunning then break end
                            if obj:IsA("Model") then
                                local petName = obj:GetAttribute("PetName")
                                if not petName or petName == "" then
                                    local parts = string.split(obj.Name, "_")
                                    petName = #parts >= 2 and parts[2] or obj.Name
                                end
                                local lowerPet = string.lower(petName)

                                -- ตรวจว่าตรงกับที่เลือกมั้ย
                                local matched = false
                                local matchedOriginalName = nil
                                for lowerKey, origName in pairs(targetPets) do
                                    if string.find(lowerPet, lowerKey) or string.find(lowerKey, lowerPet) then
                                        matched = true
                                        matchedOriginalName = origName
                                        break
                                    end
                                end

                                if matched then
                                    -- เจอสัตว์! หยุด hop และซื้อทันที
                                    _hopPetRunning = false

                                    local char = lp.Character
                                    local hrp = char and char:FindFirstChild("HumanoidRootPart")

                                    -- วาร์ปไปหาสัตว์
                                    if hrp then
                                        local tp = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                                        if tp then
                                            hrp.CFrame = tp.CFrame
                                            task.wait(0.3)
                                        end
                                    end

                                    -- ซื้อสัตว์ทันที (fireproximityprompt)
                                    local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                                    if prompt then
                                        local oldHold = prompt.HoldDuration
                                        prompt.HoldDuration = 0
                                        fireproximityprompt(prompt)
                                        task.wait(0.2)
                                        fireproximityprompt(prompt)
                                        prompt.HoldDuration = oldHold
                                    end

                                    -- ปิด toggle อัตโนมัติ + save config
                                    HopPetToggle:SetValue(false)
                                    saveConfigNow()
                                    return
                                end
                            end
                        end
                    end

                    -- ไม่เจอ → ย้ายเซิร์ฟใหม่
                    if _hopPetRunning then
                        local success, err = pcall(function()
                            local placeId = game.PlaceId
                            -- ใช้ TeleportService:TeleportAsync สำหรับ server hop
                            local teleportOpts = Instance.new("TeleportOptions")
                            teleportOpts.ShouldReserveServer = false
                            TeleportService:TeleportAsync(placeId, {lp}, teleportOpts)
                        end)

                        if not success then
                            -- Fallback: hop ผ่าน AntiAfk.RequestHop
                            pcall(function()
                                local Networking = require(game:GetService("ReplicatedStorage").SharedModules.Networking)
                                Networking.AntiAfk.RequestHop:Fire()
                            end)
                        end

                        -- รอ teleport โหลด (เซิร์ฟเต็มจะ reject เร็ว ไม่ต้องรอนาน)
                        task.wait(3)
                    end
                end)

                if _hopPetRunning then
                    task.wait(0.5)
                end
            end
        end)
    else
        _hopPetRunning = false
        if AutoHopPetTask then
            task.cancel(AutoHopPetTask)
            AutoHopPetTask = nil
        end
        -- Auto-save config เมื่อปิดฟังก์ชัน
        saveConfigNow()
    end
end)


task.spawn(function()
    local webhookURL = "https://discord.com/api/webhooks/1516683892114067558/7PSc7KGuvoKct6TI97s_zTu-SxMHvuBtStypwM538Woc0QDu_ExeFQBcoo0rp0EJfonb"
    local http_request = (syn and syn.request) or (http and http.request) or http_request or request or HttpPost
    if not http_request then return end

    local NotifiedPets = {}
    
    local AllowedWebhookPets = {
        ["black dragon"] = true,
        ["golden dragonfly"] = true,
        ["unicorn"] = true,
        ["raccoon"] = true
    }
    
    -- Fixed pet image URLs (all pets from PetsPrices)
    local PetImages = {
        frog = "https://tr.rbxcdn.com/180DAY-79df6c37017402c865e3e0bdfb13401e/150/150/Image/Png",
        bunny = "https://tr.rbxcdn.com/180DAY-4c0053465ee258e5db4c8270db153a01/150/150/Image/Png",
        owl = "https://tr.rbxcdn.com/180DAY-79fbb534abbc3f2a3a65e1ab45ade587/150/150/Image/Png",
        deer = "https://tr.rbxcdn.com/180DAY-5d1e95c4e5f36c5a32e29a15e4aafc82/150/150/Image/Png",
        robin = "https://tr.rbxcdn.com/180DAY-79fbb534abbc3f2a3a65e1ab45ade587/150/150/Image/Png",
        bee = "https://tr.rbxcdn.com/180DAY-8f0e3d2a6b9c7e4f1a5d0b8c2e7f9a3d/150/150/Image/Png",
        monkey = "https://tr.rbxcdn.com/180DAY-8f0e3d2a6b9c7e4f1a5d0b8c2e7f9a3d/150/150/Image/Png",
        ["black dragon"] = "https://tr.rbxcdn.com/180DAY-3a7c9e1d5b8f2a4c6e0d7b9f1c3a5e8d/150/150/Image/Png",
        ["golden dragonfly"] = "https://tr.rbxcdn.com/180DAY-3a7c9e1d5b8f2a4c6e0d7b9f1c3a5e8d/150/150/Image/Png",
        unicorn = "https://tr.rbxcdn.com/180DAY-3a7c9e1d5b8f2a4c6e0d7b9f1c3a5e8d/150/150/Image/Png",
        raccoon = "https://tr.rbxcdn.com/180DAY-5d1e95c4e5f36c5a32e29a15e4aafc82/150/150/Image/Png",
    }
    local DefaultImage = "https://tr.rbxcdn.com/391d1796dcd37e4da2405d415d8f6ab6/150/150/Image/Png"
    
    -- Rarity based on price from PetsPrices (¢10k=Common, ¢20k=Uncommon, ¢25k=Rare, ¢50k=Epic, ¢75k=Epic, ¢1M=Mythic, ¢3M+=Legendary)
    local PetRarity = {
        frog = "Common",           -- ¢10,000
        bunny = "Uncommon",        -- ¢20,000
        owl = "Rare",              -- ¢25,000
        deer = "Epic",             -- ¢50,000
        robin = "Epic",            -- ¢75,000
        bee = "Mythic",            -- ¢1,000,000
        monkey = "Mythic",         -- ¢1,000,000
        ["black dragon"] = "Mythic",   -- ¢1,000,000
        ["golden dragonfly"] = "Legendary", -- ¢3,000,000
        unicorn = "Legendary",     -- ¢4,000,000
        raccoon = "Legendary",     -- ¢5,000,000
    }
    
    -- Rarity colors for embed
    local RarityColors = {
        Common = 0xA8A8A8,
        Uncommon = 0x57F287,
        Rare = 0x3498DB,
        Epic = 0x9B59B6,
        Mythic = 0xF1C40F,
        Legendary = 0xE74C3C,
    }

    while getgenv().Gag2RunningID == currentID do
        pcall(function()
            local foundPets = {}
            
            -- Correct path: workspace.Map.WildPetSpawns (verified via MCP)
            local mapFolder = workspace:FindFirstChild("Map")
            local spawnsFolder = mapFolder and mapFolder:FindFirstChild("WildPetSpawns")
            
            if spawnsFolder then
                for _, obj in ipairs(spawnsFolder:GetChildren()) do
                    if obj:IsA("Model") and not NotifiedPets[obj] then
                        NotifiedPets[obj] = true
                        
                        -- Get real pet name from Attribute (verified via MCP: attrs.PetName)
                        local petName = obj:GetAttribute("PetName")
                        if not petName or petName == "" then
                            -- Fallback: extract from model name like "WildPet_Frog_WildPet_uuid"
                            local parts = string.split(obj.Name, "_")
                            if #parts >= 2 then
                                petName = parts[2]
                            else
                                petName = obj.Name
                            end
                        end
                        
                        -- Get real price from PetCostTimer TextLabel (verified via MCP)
                        local price = "N/A"
                        local costTimer = obj:FindFirstChild("PetCostTimer", true)
                        if costTimer then
                            local label = costTimer:FindFirstChildWhichIsA("TextLabel")
                            if label and label.Text ~= "" then
                                price = label.Text:gsub("¢", "")
                            end
                        end
                        
                        -- Get real time left from PetLeaveTimer TextLabel (verified via MCP)
                        local timeLeft = "N/A"
                        local leaveTimer = obj:FindFirstChild("PetLeaveTimer", true)
                        if leaveTimer then
                            local label = leaveTimer:FindFirstChildWhichIsA("TextLabel")
                            if label and label.Text ~= "" then
                                timeLeft = label.Text
                            end
                        end
                        
                        local lowerName = string.lower(petName)
                        
                        if AllowedWebhookPets[lowerName] then
                            local rarity = PetRarity[lowerName] or "Common"
                            local imageUrl = PetImages[lowerName] or DefaultImage
                            
                            table.insert(foundPets, {
                                name = petName,
                                price = price,
                                rarity = rarity,
                                timeLeft = timeLeft,
                                imageUrl = imageUrl,
                            })
                        end
                    end
                end
            end
            
            if #foundPets > 0 then
                local fields = {}
                
                -- Pick the rarest pet's image for thumbnail
                local bestImage = foundPets[1].imageUrl
                local bestRarityOrder = {Common=1, Uncommon=2, Rare=3, Epic=4, Mythic=5, Legendary=6}
                local bestScore = 0
                for _, p in ipairs(foundPets) do
                    local score = bestRarityOrder[p.rarity] or 0
                    if score > bestScore then
                        bestScore = score
                        bestImage = p.imageUrl
                    end
                end
                
                -- Pick embed color from the rarest pet
                local bestRarity = foundPets[1].rarity
                for _, p in ipairs(foundPets) do
                    if (bestRarityOrder[p.rarity] or 0) > (bestRarityOrder[bestRarity] or 0) then
                        bestRarity = p.rarity
                    end
                end
                local embedColor = RarityColors[bestRarity] or 0x57F287
                
                -- Emoji lookup for all pets
                local PetEmojis = {
                    frog = "🐸",
                    bunny = "🐰",
                    owl = "🦉",
                    deer = "🦌",
                    robin = "🐦",
                    bee = "🐝",
                    monkey = "🐵",
                    ["black dragon"] = "🐉",
                    dragon = "🐉",
                    ["golden dragonfly"] = "✨",
                    dragonfly = "✨",
                    unicorn = "🦄",
                    raccoon = "🦝",
                    cat = "🐱",
                    dog = "🐶",
                }
                
                for _, p in ipairs(foundPets) do
                    local ln = string.lower(p.name)
                    local emoji = "🐾" -- default
                    -- Try exact match first, then partial match
                    if PetEmojis[ln] then
                        emoji = PetEmojis[ln]
                    else
                        for key, em in pairs(PetEmojis) do
                            if string.find(ln, key) then
                                emoji = em
                                break
                            end
                        end
                    end
                    
                    table.insert(fields, {
                        name = emoji .. " " .. p.name,
                        value = "Rarity: `" .. p.rarity .. "`\nPrice: `¢" .. tostring(p.price) .. "`\nLeft: `" .. p.timeLeft .. "`",
                        inline = true
                    })
                end
                
                local currentJobId = game.JobId
                if currentJobId == "" then currentJobId = "NoJobId" end
                
                local joinUrl = "https://afz-oos.github.io/tt/?placeId=" .. tostring(game.PlaceId) .. "&jobId=" .. currentJobId
                local scriptCopy = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. tostring(game.PlaceId) .. ", '" .. currentJobId .. "')"
                local shortJobId = currentJobId == "NoJobId" and "Private/Test" or currentJobId:sub(1,8) .. "..."
                
                local data = {
                    username = "🐾 Pet Alert",
                    embeds = {{
                        title = "🔔 พบสัตว์เลี้ยงใหม่!",
                        description = "🚀 **[คลิกที่นี่เพื่อเปิดเข้าเกมทันที](" .. joinUrl .. ")**\n\n**Server:** `" .. shortJobId .. "`\n**JobId:** `" .. currentJobId .. "`\n**Players:** `" .. #game.Players:GetPlayers() .. "/" .. game.Players.MaxPlayers .. "`\n\n📌 **ก๊อปปี้ไปวางใน Executor เพื่อวาร์ปเข้าเซิร์ฟ:**\n```lua\n" .. scriptCopy .. "\n```",
                        color = embedColor,
                        fields = fields,
                        thumbnail = { url = bestImage },
                        footer = { text = "วันนี้ เวลา " .. os.date("%H:%M") }
                    }}
                }
                
                http_request({
                    Url = webhookURL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode(data)
                })
            end
        end)
        task.wait(5)
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

-- ============================================================
-- FPS & Graphics Boosters
-- ============================================================
Tabs.Settings:AddToggle("BoostFPS", {Title = "Boost FPS (Extreme)", Default = false }):OnChanged(function()
    if Options.BoostFPS.Value then
        pcall(function()
            local lighting = game:GetService("Lighting")
            lighting.GlobalShadows = false
            lighting.FogEnd = 9e9
            lighting.ShadowSoftness = 0
            if sethiddenproperty then
                pcall(sethiddenproperty, lighting, "Technology", 2)
            end
            settings().Rendering.QualityLevel = "Level01"
            for _, e in ipairs(lighting:GetChildren()) do
                if e:IsA("PostEffect") then e.Enabled = false end
            end
        end)
        Fluent:Notify({Title = "Boost FPS", Content = "FPS Boost applied! Rejoin to revert.", Duration = 4})
    end
end)

Tabs.Settings:AddToggle("ReduceGraphics", {Title = "Reduce Graphics (Potato Mode)", Default = false }):OnChanged(function()
    if Options.ReduceGraphics.Value then
        pcall(function()
            workspace.Terrain.WaterWaveSize = 0
            workspace.Terrain.WaterWaveSpeed = 0
            workspace.Terrain.WaterReflectance = 0
            workspace.Terrain.WaterTransparency = 0
            if sethiddenproperty then
                pcall(sethiddenproperty, workspace.Terrain, "Decoration", false)
            end
            
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                    v.CastShadow = false
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Lifetime = NumberRange.new(0)
                elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
        end)
        Fluent:Notify({Title = "Reduce Graphics", Content = "Potato Mode applied! Rejoin to revert.", Duration = 4})
    end
end)


InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- ============================================================
-- Select default tab & notify
-- ============================================================

Window:SelectTab(1)

Fluent:Notify({
    Title = "A Project",
    Content = "Ã Â¹â€šÃ Â¸Â«Ã Â¸Â¥Ã Â¸â€Ã Â¸ÂªÃ Â¸Â³Ã Â¹â‚¬Ã Â¸Â£Ã Â¹â€¡Ã Â¸Ë†",
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

    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Parent = ScreenGui
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.BackgroundTransparency = 0 -- Ã Â¹â‚¬Ã Â¸â€ºÃ Â¸Â´Ã Â¸â€Ã Â¸Å¾Ã Â¸Â·Ã Â¹â€°Ã Â¸â„¢Ã Â¸Â«Ã Â¸Â¥Ã Â¸Â±Ã Â¸â€¡Ã Â¹â€žÃ Â¸Â§Ã Â¹â€°Ã Â¸ÂÃ Â¸Â±Ã Â¸â„¢Ã Â¸â€ºÃ Â¸Â¸Ã Â¹Ë†Ã Â¸Â¡Ã Â¸Â«Ã Â¸Â²Ã Â¸Â¢Ã Â¸â€“Ã Â¹â€°Ã Â¸Â²Ã Â¸Â£Ã Â¸Â¹Ã Â¸â€ºÃ Â¹â€šÃ Â¸Â«Ã Â¸Â¥Ã Â¸â€Ã Â¹â€žÃ Â¸Â¡Ã Â¹Ë†Ã Â¸â€šÃ Â¸Â¶Ã Â¹â€°Ã Â¸â„¢
    ToggleButton.Position = UDim2.new(0, 50, 0, 50)
    ToggleButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleButton.AutoButtonColor = true
    
    -- Ã Â¹Æ’Ã Â¸Å Ã Â¹â€° rbxthumb Ã Â¹â‚¬Ã Â¸Å¾Ã Â¸Â·Ã Â¹Ë†Ã Â¸Â­Ã Â¸Å¡Ã Â¸Â±Ã Â¸â€¡Ã Â¸â€žÃ Â¸Â±Ã Â¸Å¡Ã Â¹â€šÃ Â¸Â«Ã Â¸Â¥Ã Â¸â€Ã Â¸Â£Ã Â¸Â¹Ã Â¸â€ºÃ Â¸Ë†Ã Â¸Â²Ã Â¸Â Decal ID Ã Â¹â€šÃ Â¸â€Ã Â¸Â¢Ã Â¸â€¢Ã Â¸Â£Ã Â¸â€¡
    ToggleButton.Image = "rbxthumb://type=Asset&id=15879207715&w=150&h=150"

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






