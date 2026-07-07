repeat task.wait() until game:IsLoaded()

local Ex = {
    Config = {
        PlaceId = {
            Source = 106600795455627,
            Target = 6918802270,
        },
        Delay = {
            CheckPlace = 1,
            RetryTeleport = 5,
            SearchPlay = 0.5,
        },
        Timeout = {
            SearchPlay = 60,
        },
        PlayBlockWords = {
            "playtime",
            "afk reward",
            "teleport to afk",
        },
        PlaySignals = {
            "Activated",
            "MouseButton1Click",
            "MouseButton1Down",
            "MouseButton1Up",
        },
        AutoFarm = {
            Enabled = true,
            FarmMode = "Above", -- Above = -90, Below = 90
            Distance = 8,
            AttackDelay = 0.18,
            AttackRepeat = 2,
            AttackRepeatDelay = 0.03,
            QuestRemoteOnly = true,
            RequireQuestBeforeFarm = true,
            QuestDelay = 0.75,
            PendingQuestDelay = 10,
            SearchMobDelay = 0.25,
            MissingMobTeleportDelay = 0.75,
            StartDelay = 2,
            HitOffset = Vector3.new(0, 0.2, 0),
            FarmWrongQuestFallback = true,
            StrictQuestIsland = true,
            BypassTeleport = true,
            TeleportTweenSpeed = 4500,
            TeleportTweenMinDuration = 0.2,
            TeleportTweenMaxDuration = 2.5,
            TeleportTweenPollDelay = 0.05,
            TeleportHoldTime = 1.5,
            TeleportHoldStep = 0.08,
            TeleportLoadTimeout = 8,
            TeleportMaxRetries = 3,
            TeleportRetryDelay = 1,
            TeleportDistanceCheck = 120,
            SetSpawnOnIslandLoad = true,
            SetSpawnCooldown = 10,
            WatchdogDelay = 2,
            StaleHeartbeatTime = 6,
            ErrorDelay = 1,
            NoReturnAfterQuest = true,
            KeepCurrentQuestUntilDone = true,
            QuestSyncGraceTime = 12,
            KeepLockedMobBeforeQuest = true,
            RefreshQuestLockWhileFarming = true,
            WaitAtDeathUntilRespawn = true,
            WaitAtDeathBossOnly = true,
            RespawnWaitRadius = 80,
            RespawnHoldDelay = 0.12,
            MissingMobWaitBeforeProbe = 0.5,
            ReturnToLastFarmDistance = 180,
            LastFarmPointTimeout = 300,
            TargetLockEnabled = true,
            SmoothFarmFollow = true,
            FarmFollowAlpha = 0.28,
            FarmFollowTweenDistance = 75,
            FarmFollowTweenSpeed = 550,
            FarmFollowTweenMinDuration = 0.25,
            FarmFollowTweenMaxDuration = 2.8,
            FarmAnchorRoot = false,
            FarmOrbitEnabled = true,
            FarmOrbitRadius = 6.5,
            FarmOrbitHeight = 0,
            FarmOrbitSpeed = 300,
            FarmOrbitTween = true,
            FarmOrbitTweenSpeed = 75,
            FarmOrbitTweenMinDuration = 0.1,
            FarmOrbitTweenMaxDuration = 0.2,
            FarmOrbitContinuous = true,
            FarmOrbitHoldTime = 0.4,
            FarmOrbitStepDelay = 0.03,
            FarmOrbitStepAlpha = 0.85,
            FarmOrbitStepMaxDistance = 35,
            FarmOrbitFaceHit = true,
            FarmOrbitUseFarmAngle = false,
            FarmAvailableMobWhenTargetMissing = true,
            TargetProbeBeforeFallback = true,
            FallbackAfterMissingTargetTime = 6,
            DeepMobScan = true,
            DeepMobScanMaxDepth = 7,
            DeepMobScanMaxNodes = 3500,
            LoadProbeEnabled = true,
            LoadProbeHoldTime = 1,
            LoadProbeHeight = 18,
            LoadProbeRadius = 380,
            LoadProbeMaxPoints = 24,
            LoadProbePartMinSize = 45,
            TryCancelWrongQuest = true,
            BringTarget = true,
            NoClip = true,
            RespawnBossMobs = {
                "Bandit Boss",
                "Clown Boss",
                "Shark Boss",
                "Bomb Boss",
                "Krieg Boss",
                "Tashii",
                "King Gorilla",
                "Minotaur",
                "Vice Admiral",
                "Ice Admiral",
                "Thunder God",
                "Revolutionary Boss",
                "Warden",
                "Vergo",
                "Neptune",
                "Shiryu",
                "G4 Boss",
                "Ryummy",
            },
        },
        Startup = {
            Enabled = true,
            RetryDelay = 0.5,
            WaitCharacterTimeout = 45,
            RedeemDelay = 0.35,
            BuyDelay = 0.75,
            WaitToolTimeout = 10,
            StatDelay = 0.25,
            StatLoopDelay = 1,
            StatChunk = 50,
            StatMax = 4500,
            AutoStats = true,
            SwordName = "Katana",
            Codes = {
                "OKUCHI",
                "Sub2XenoTy",
                "Sub2CaptainMaui",
                "RELEASE",
                "FREECASH",
                "FREEGEMS",
                "PATCH",
                "HAZESEAS2026",
                "SUBSCRIBETOHAZEYT",
                "Sub2Nikkolapz",
                "Sub2BadiTubes",
                "Sub2BrosSiam",
                "Sub2BuilderboyTV",
            },
            StatRatio = {
                Sword = 70,
                Defense = 30,
            },
        },
        Haki = {
            Enabled = true,
            RequiredLevel = 355,
            RequiredBeli = 100000,
            BuyRetryDelay = 3,
            BuyTimeout = 26,
            BuyDelay = 0.75,
            LoadHoldTime = 1.2,
            UseBeforeAttack = true,
            UseCooldown = 0.8,
            UseDelay = 0.12,
            BusoLevelName = "1",
            BusoNpcCFrame = CFrame.new(-2745.901123046875, 101.63304901123047, 2251.0966796875),
            BusoLoadCFrames = {
                CFrame.new(-2472.894775390625, 55, 2253.22705078125),
                CFrame.new(-2722.894775390625, 55, 2253.22705078125),
                CFrame.new(-2972.894775390625, 55, 2253.22705078125),
                CFrame.new(-2679.924560546875, 45, 2042.1256103515625),
            },
        },
        Description = {
            Enabled = true,
            UpdateDelay = 10,
            UseEncodeJson = true,
            EmptyText = "None",
            Separator = "  •  ",
            MaxFruitNames = 20,
        },
        QuestCancelPayloads = {
            "Cancel",
            "CancelQuest",
            "Abandon",
            "AbandonQuest",
            "StopQuest",
        },
        QuestList = {
            { Level = 1, Mob = "Thief", Giver = "1", Island = "Starter Island" },
            { Level = 10, Mob = "Bandit", Giver = "1", Island = "Starter Island" },
            { Level = 25, Mob = "Bandit Boss", Giver = "1", Island = "Starter Island" },
            { Level = 40, Mob = "Pirate Clown", Giver = "2", Island = "Clown Island" },
            { Level = 60, Mob = "Clown Boss", Giver = "2", Island = "Clown Island" },
            { Level = 90, Mob = "Fishman", Giver = "3", Island = "Shark Park" },
            { Level = 120, Mob = "Shark Boss", Giver = "3", Island = "Shark Park" },
            { Level = 160, Mob = "Desert Thief", Giver = "4", Island = "Desert Ruins" },
            { Level = 200, Mob = "Bomb Boss", Giver = "4", Island = "Desert Ruins" },
            { Level = 250, Mob = "Krieg Pirate", Giver = "5", Island = "Sea Restaurant" },
            { Level = 300, Mob = "Krieg Boss", Giver = "5", Island = "Sea Restaurant" },
            { Level = 350, Mob = "Marine Recruit", Giver = "6", Island = "Logue Town" },
            { Level = 400, Mob = "Tashii", Giver = "6", Island = "Logue Town" },
            { Level = 450, Mob = "Monkey", Giver = "7", Island = "Tall Woods" },
            { Level = 500, Mob = "Gorilla", Giver = "7", Island = "Tall Woods" },
            { Level = 550, Mob = "King Gorilla", Giver = "7", Island = "Tall Woods" },
            { Level = 600, Mob = "Marine Grunt", Giver = "8", Island = "Marine Base Town" },
            { Level = 650, Mob = "Marine Captain", Giver = "8", Island = "Marine Base Town" },
            { Level = 700, Mob = "Satyr", Giver = "9", Island = "Three Islands" },
            { Level = 750, Mob = "Minotaur", Giver = "9", Island = "Three Islands" },
            { Level = 800, Mob = "Elite Marine", Giver = "10", Island = "Marine HQ" },
            { Level = 850, Mob = "Vice Admiral", Giver = "10", Island = "Marine HQ" },
            { Level = 900, Mob = "Ice Admiral", Giver = "10", Island = "Marine HQ" },
            { Level = 950, Mob = "Sandorian Warrior", Giver = "11", Island = "Sky Islands" },
            { Level = 1000, Mob = "Divine Soldier", Giver = "11", Island = "Sky Islands" },
            { Level = 1050, Mob = "Holy Soldier", Giver = "12", Island = "Sky Islands" },
            { Level = 1100, Mob = "Thunder God", Giver = "12", Island = "Sky Islands" },
            { Level = 1150, Mob = "Revolutionary", Giver = "13", Island = "Revolutionary Base" },
            { Level = 1200, Mob = "Revolutionary Elite", Giver = "13", Island = "Revolutionary Base" },
            { Level = 1250, Mob = "Revolutionary Boss", Giver = "13", Island = "Revolutionary Base" },
            { Level = 1300, Mob = "Impel Guard", Giver = "14", Island = "Impel Jail" },
            { Level = 1350, Mob = "Impel Elite", Giver = "14", Island = "Impel Jail" },
            { Level = 1400, Mob = "Warden", Giver = "14", Island = "Impel Jail" },
            { Level = 1450, Mob = "Corrupt Marine", Giver = "15", Island = "Half Hot Half Cold" },
            { Level = 1500, Mob = "Vergo", Giver = "15", Island = "Half Hot Half Cold" },
            { Level = 1550, Mob = "Snow Harpy", Giver = "15", Island = "Half Hot Half Cold" },
            { Level = 1600, Mob = "Island Fishman", Giver = "16", Island = "Fishman Island" },
            { Level = 1650, Mob = "Fishman Elite", Giver = "16", Island = "Fishman Island" },
            { Level = 1700, Mob = "Neptune", Giver = "16", Island = "Fishman Island" },
            { Level = 1750, Mob = "Skull Pirate", Giver = "17", Island = "Skull Island" },
            { Level = 1800, Mob = "Pirate Elite", Giver = "17", Island = "Skull Island" },
            { Level = 1850, Mob = "Shiryu", Giver = "17", Island = "Skull Island" },
            { Level = 1900, Mob = "Pirate", Giver = "18", Island = "Bubble Island" },
            { Level = 1950, Mob = "Armored Marine", Giver = "18", Island = "Bubble Island" },
            { Level = 2000, Mob = "G4 Boss", Giver = "18", Island = "Bubble Island" },
            { Level = 2050, Mob = "Skeleton", Giver = "19", Island = "Thriller Boat" },
            { Level = 2100, Mob = "Mummy", Giver = "19", Island = "Thriller Boat" },
            { Level = 2150, Mob = "Ryummy", Giver = "19", Island = "Thriller Boat" },
        },
        IslandAlias = {
            ["Logue Town"] = "Logue City",
            ["Sky Islands"] = "Skypiean islands",
            ["Half Cold"] = "Half Hot Half Cold",
            ["Cold Island"] = "Half Hot Half Cold",
        },
        HitParts = {
            "HumanoidRootPart",
            "UpperTorso",
            "LowerTorso",
            "Head",
        },
    },
    Service = {},
    State = {
        Queued = false,
        StartupDone = false,
        StartupCodesDone = false,
        StartupSwordDone = false,
        StartupHakiDone = false,
        CodeResults = {},
        LastSpawnSet = {},
        LoadProbeIndex = {},
        MissingMobSince = {},
        LastFarmCFrame = {},
        LastFarmAt = {},
        LastFarmHoldCFrame = {},
        LastFarmHoldAt = {},
        LockedMob = nil,
        LockedMobQuestKey = nil,
        LockedMobAt = nil,
        QuestLock = nil,
        RespawnWait = nil,
        OrbitMob = nil,
        OrbitAngle = 0,
        OrbitLastAt = nil,
        BuyingHaki = false,
        LastHakiBuyAttempt = 0,
        LastHakiBuyResponse = nil,
        LastBusoUseAt = 0,
        FruitPowerMap = nil,
        LastDescription = nil,
        LastDescriptionJson = nil,
        LastDescriptionAt = 0,
        LastDescriptionError = nil,
        LastQuestAcceptResponse = nil,
        LastQuestAcceptError = nil,
    },
    Function = {},
}

Ex.Service.Players = game:GetService("Players")
Ex.Service.TeleportService = game:GetService("TeleportService")
Ex.Service.ReplicatedStorage = game:GetService("ReplicatedStorage")
Ex.Service.TweenService = game:GetService("TweenService")
Ex.Service.HttpService = game:GetService("HttpService")
Ex.Service.Player = Ex.Service.Players.LocalPlayer or Ex.Service.Players.PlayerAdded:Wait()
Ex.Service.Shared = (getgenv and getgenv()) or _G
Ex.Service.Shared.__HazeSeasAutoFarm = Ex

pcall(function()
    Ex.Service.VirtualInputManager = game:GetService("VirtualInputManager")
end)

pcall(function()
    if type(getgc) ~= "function" then
        return
    end

    for _, Object in next, getgc(true) do
        if type(Object) == "table" and Object ~= Ex and rawget(Object, "Config") and rawget(Object, "Function") then
            local Config = rawget(Object, "Config")
            local PlaceId = type(Config) == "table" and rawget(Config, "PlaceId")

            if type(PlaceId) == "table" and PlaceId.Target == Ex.Config.PlaceId.Target then
                if type(Config.AutoFarm) == "table" then
                    Config.AutoFarm.Enabled = false
                end

                if type(Config.Startup) == "table" then
                    Config.Startup.AutoStats = false
                end
            end
        end
    end
end)

Ex.Service.Shared.__HazeSeasPlaceGuardRunning = nil
Ex.Service.Shared.__HazeSeasTargetRunnerRunning = nil
Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning = nil
Ex.Service.Shared.__HazeSeasAutoStatRunning = nil
Ex.Service.Shared.__HazeSeasAutoFarmKeeperRunning = nil
Ex.Service.Shared.__HazeSeasAutoFarmHeartbeat = nil
Ex.Service.Shared.__HazeSeasDescriptionRunning = nil

if Ex.Service.Shared.__HazeSeasPlaceGuardRunning then
    return
end

Ex.Service.Shared.__HazeSeasPlaceGuardRunning = true

Ex.QueueCode = [=[
local Reloaded = false

pcall(function()
    if type(readfile) ~= "function" or type(loadstring) ~= "function" then
        return
    end

    local Paths = {
        "Haze Seas/Haze Seas kiatun.lua",
        "C:\\Users\\Administrator\\Desktop\\" .. utf8.char(3591, 3634, 3609) .. "\\Script\\Haze Seas\\Haze Seas kiatun.lua",
    }

    for _, Path in next, Paths do
        local ReadSuccess, Source = pcall(readfile, Path)

        if ReadSuccess and type(Source) == "string" and Source ~= "" then
            local LoadSuccess, Chunk = pcall(loadstring, Source)

            if LoadSuccess and type(Chunk) == "function" then
                local RunSuccess = pcall(Chunk)

                if RunSuccess then
                    Reloaded = true
                    break
                end
            end
        end
    end
end)

if Reloaded then
    return
end

local Ex = {
    Config = {
        PlaceId = {
            Target = 6918802270,
        },
        Delay = {
            SearchPlay = 0.5,
        },
        Timeout = {
            SearchPlay = 60,
        },
        PlayBlockWords = {
            "playtime",
            "afk reward",
            "teleport to afk",
        },
        PlaySignals = {
            "Activated",
            "MouseButton1Click",
            "MouseButton1Down",
            "MouseButton1Up",
        },
    },
    Service = {},
    Function = {},
}

if game.PlaceId ~= Ex.Config.PlaceId.Target then
    return
end

Ex.Service.Players = game:GetService("Players")
Ex.Service.Player = Ex.Service.Players.LocalPlayer or Ex.Service.Players.PlayerAdded:Wait()

pcall(function()
    Ex.Service.VirtualInputManager = game:GetService("VirtualInputManager")
end)

function Ex.Function.IsVisible(Button, PlayerGui)
    local Current = Button

    while Current and Current ~= PlayerGui do
        if Current:IsA("GuiObject") then
            if not Current.Visible or Current.AbsoluteSize.X <= 0 or Current.AbsoluteSize.Y <= 0 then
                return false
            end
        elseif Current:IsA("ScreenGui") and not Current.Enabled then
            return false
        end

        Current = Current.Parent
    end

    return true
end

function Ex.Function.InsertGuiText(Array, Instance)
    local Success, Text = pcall(function()
        return Instance.Text
    end)

    if Success and Text and Text ~= "" then
        table.insert(Array, tostring(Text))
    end
end

function Ex.Function.AddChildText(Array, Root, Depth)
    if Depth > 3 then
        return
    end

    Ex.Function.InsertGuiText(Array, Root)

    for _, Child in next, Root:GetChildren() do
        Ex.Function.AddChildText(Array, Child, Depth + 1)
    end
end

function Ex.Function.GetButtonContext(Button, PlayerGui)
    local Array = { Button.Name }
    local Current = Button.Parent

    for _ = 1, 5 do
        if not Current or Current == PlayerGui then
            break
        end

        table.insert(Array, Current.Name)
        Current = Current.Parent
    end

    Ex.Function.AddChildText(Array, Button, 0)

    return string.lower(table.concat(Array, " "))
end

function Ex.Function.GetButtonText(Button)
    local Success, Text = pcall(function()
        return Button.Text
    end)

    if Success and Text then
        return string.lower(tostring(Text))
    end

    return ""
end

function Ex.Function.HasBlockedWord(Context)
    for _, Word in next, Ex.Config.PlayBlockWords do
        if string.find(Context, Word, 1, true) then
            return true
        end
    end

    return false
end

function Ex.Function.GetPlayScore(Button, PlayerGui)
    if not Ex.Function.IsVisible(Button, PlayerGui) then
        return 0
    end

    local Context = Ex.Function.GetButtonContext(Button, PlayerGui)

    if Ex.Function.HasBlockedWord(Context) then
        return 0
    end

    local Name = string.lower(Button.Name)
    local Text = Ex.Function.GetButtonText(Button)

    if Name == "play" or Text == "play" then
        return 100
    end

    if string.find(Name, "playbutton", 1, true)
        or string.find(Name, "play_button", 1, true)
        or string.find(Context, "play button", 1, true)
    then
        return 90
    end

    if (string.find(Context, "main menu", 1, true) or string.find(Context, "mainmenu", 1, true))
        and string.find(Context, "play", 1, true)
    then
        return 75
    end

    if string.match(Context, "%f[%a]play%f[%A]") then
        return 60
    end

    return 0
end

function Ex.Function.WalkGui(Root, Callback)
    for _, Child in next, Root:GetChildren() do
        Callback(Child)
        Ex.Function.WalkGui(Child, Callback)
    end
end

function Ex.Function.FindPlayButton(PlayerGui)
    local Array = {
        Button = nil,
        Score = 0,
    }

    Ex.Function.WalkGui(PlayerGui, function(Instance)
        if Instance:IsA("TextButton") or Instance:IsA("ImageButton") then
            local Score = Ex.Function.GetPlayScore(Instance, PlayerGui)

            if Score > Array.Score then
                Array.Score = Score
                Array.Button = Instance
            end
        end
    end)

    return Array.Button
end

function Ex.Function.ClickButton(Button)
    local Clicked = false

    if type(firesignal) == "function" then
        for _, SignalName in next, Ex.Config.PlaySignals do
            pcall(function()
                firesignal(Button[SignalName])
                Clicked = true
            end)
        end
    end

    pcall(function()
        if not Ex.Service.VirtualInputManager then
            return
        end

        local Position = Button.AbsolutePosition
        local Size = Button.AbsoluteSize
        local X = Position.X + (Size.X / 2)
        local Y = Position.Y + (Size.Y / 2)

        Ex.Service.VirtualInputManager:SendMouseMoveEvent(X, Y, game)
        Ex.Service.VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 0)
        task.wait(0.05)
        Ex.Service.VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 0)
        Clicked = true
    end)

    return Clicked
end

function Ex.Function.ClickPlayWhenReady()
    local StartedAt = os.clock()

    repeat
        local PlayerGui = Ex.Service.Player:FindFirstChildOfClass("PlayerGui")

        if PlayerGui then
            local PlayButton = Ex.Function.FindPlayButton(PlayerGui)

            if PlayButton then
                return Ex.Function.ClickButton(PlayButton)
            end
        end

        task.wait(Ex.Config.Delay.SearchPlay)
    until os.clock() - StartedAt >= Ex.Config.Timeout.SearchPlay

    return false
end

task.spawn(Ex.Function.ClickPlayWhenReady)
]=]

function Ex.Function.IsVisible(Button, PlayerGui)
    local Current = Button

    while Current and Current ~= PlayerGui do
        if Current:IsA("GuiObject") then
            if not Current.Visible or Current.AbsoluteSize.X <= 0 or Current.AbsoluteSize.Y <= 0 then
                return false
            end
        elseif Current:IsA("ScreenGui") and not Current.Enabled then
            return false
        end

        Current = Current.Parent
    end

    return true
end

function Ex.Function.InsertGuiText(Array, Instance)
    local Success, Text = pcall(function()
        return Instance.Text
    end)

    if Success and Text and Text ~= "" then
        table.insert(Array, tostring(Text))
    end
end

function Ex.Function.AddChildText(Array, Root, Depth)
    if Depth > 3 then
        return
    end

    Ex.Function.InsertGuiText(Array, Root)

    for _, Child in next, Root:GetChildren() do
        Ex.Function.AddChildText(Array, Child, Depth + 1)
    end
end

function Ex.Function.GetButtonContext(Button, PlayerGui)
    local Array = { Button.Name }
    local Current = Button.Parent

    for _ = 1, 5 do
        if not Current or Current == PlayerGui then
            break
        end

        table.insert(Array, Current.Name)
        Current = Current.Parent
    end

    Ex.Function.AddChildText(Array, Button, 0)

    return string.lower(table.concat(Array, " "))
end

function Ex.Function.GetButtonText(Button)
    local Success, Text = pcall(function()
        return Button.Text
    end)

    if Success and Text then
        return string.lower(tostring(Text))
    end

    return ""
end

function Ex.Function.HasBlockedWord(Context)
    for _, Word in next, Ex.Config.PlayBlockWords do
        if string.find(Context, Word, 1, true) then
            return true
        end
    end

    return false
end

function Ex.Function.GetPlayScore(Button, PlayerGui)
    if not Ex.Function.IsVisible(Button, PlayerGui) then
        return 0
    end

    local Context = Ex.Function.GetButtonContext(Button, PlayerGui)

    if Ex.Function.HasBlockedWord(Context) then
        return 0
    end

    local Name = string.lower(Button.Name)
    local Text = Ex.Function.GetButtonText(Button)

    if Name == "play" or Text == "play" then
        return 100
    end

    if string.find(Name, "playbutton", 1, true)
        or string.find(Name, "play_button", 1, true)
        or string.find(Context, "play button", 1, true)
    then
        return 90
    end

    if (string.find(Context, "main menu", 1, true) or string.find(Context, "mainmenu", 1, true))
        and string.find(Context, "play", 1, true)
    then
        return 75
    end

    if string.match(Context, "%f[%a]play%f[%A]") then
        return 60
    end

    return 0
end

function Ex.Function.WalkGui(Root, Callback)
    for _, Child in next, Root:GetChildren() do
        Callback(Child)
        Ex.Function.WalkGui(Child, Callback)
    end
end

function Ex.Function.FindPlayButton(PlayerGui)
    local Array = {
        Button = nil,
        Score = 0,
    }

    Ex.Function.WalkGui(PlayerGui, function(Instance)
        if Instance:IsA("TextButton") or Instance:IsA("ImageButton") then
            local Score = Ex.Function.GetPlayScore(Instance, PlayerGui)

            if Score > Array.Score then
                Array.Score = Score
                Array.Button = Instance
            end
        end
    end)

    return Array.Button
end

function Ex.Function.ClickButton(Button)
    local Clicked = false

    if type(firesignal) == "function" then
        for _, SignalName in next, Ex.Config.PlaySignals do
            pcall(function()
                firesignal(Button[SignalName])
                Clicked = true
            end)
        end
    end

    pcall(function()
        if not Ex.Service.VirtualInputManager then
            return
        end

        local Position = Button.AbsolutePosition
        local Size = Button.AbsoluteSize
        local X = Position.X + (Size.X / 2)
        local Y = Position.Y + (Size.Y / 2)

        Ex.Service.VirtualInputManager:SendMouseMoveEvent(X, Y, game)
        Ex.Service.VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 0)
        task.wait(0.05)
        Ex.Service.VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 0)
        Clicked = true
    end)

    return Clicked
end

function Ex.Function.ClickPlayWhenReady()
    local StartedAt = os.clock()

    repeat
        local PlayerGui = Ex.Service.Player:FindFirstChildOfClass("PlayerGui")

        if PlayerGui then
            local PlayButton = Ex.Function.FindPlayButton(PlayerGui)

            if PlayButton then
                return Ex.Function.ClickButton(PlayButton)
            end
        end

        task.wait(Ex.Config.Delay.SearchPlay)
    until os.clock() - StartedAt >= Ex.Config.Timeout.SearchPlay

    return false
end

function Ex.Function.WalkInstance(Root, Callback)
    for _, Child in next, Root:GetChildren() do
        Callback(Child)
        Ex.Function.WalkInstance(Child, Callback)
    end
end

function Ex.Function.GetCharacter()
    return Ex.Service.Player.Character or Ex.Service.Player.CharacterAdded:Wait()
end

function Ex.Function.GetRoot()
    local Character = Ex.Function.GetCharacter()

    return Character:FindFirstChild("HumanoidRootPart")
end

function Ex.Function.GetHumanoid()
    local Character = Ex.Function.GetCharacter()

    return Character:FindFirstChildOfClass("Humanoid")
end

function Ex.Function.GetPlayerData()
    return Ex.Service.Player:FindFirstChild("PlayerData")
end

function Ex.Function.GetExperienceFolder()
    local PlayerData = Ex.Function.GetPlayerData()

    return PlayerData and PlayerData:FindFirstChild("Experience")
end

function Ex.Function.GetClientEvent(Name)
    local Replication = Ex.Service.ReplicatedStorage:FindFirstChild("Replication")
    local ClientEvents = Replication and Replication:FindFirstChild("ClientEvents")

    return ClientEvents and ClientEvents:FindFirstChild(Name)
end

function Ex.Function.GetStatValue(Name)
    local Experience = Ex.Function.GetExperienceFolder()
    local Stat = Experience and Experience:FindFirstChild(Name)

    if Stat then
        return Stat.Value
    end

    return 0
end

function Ex.Function.GetPointValue()
    local Experience = Ex.Function.GetExperienceFolder()
    local Points = Experience and Experience:FindFirstChild("Points")

    if Points then
        return Points.Value
    end

    return 0
end

function Ex.Function.WaitForCharacter(Timeout)
    local StartedAt = os.clock()

    repeat
        local Character = Ex.Service.Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local Root = Character and Character:FindFirstChild("HumanoidRootPart")

        if Character and Humanoid and Root and Humanoid.Health > 0 then
            return Character
        end

        task.wait(Ex.Config.Startup.RetryDelay)
    until Timeout and os.clock() - StartedAt >= Timeout

    return nil
end

function Ex.Function.FindToolByName(Name)
    if not Name or Name == "" then
        return nil
    end

    local Character = Ex.Service.Player.Character

    if Character then
        local Tool = Character:FindFirstChild(Name)

        if Tool and Tool:IsA("Tool") then
            return Tool
        end
    end

    local Backpack = Ex.Service.Player:FindFirstChild("Backpack")
    local Tool = Backpack and Backpack:FindFirstChild(Name)

    if Tool and Tool:IsA("Tool") then
        return Tool
    end

    return nil
end

function Ex.Function.GetCurrentSwordName()
    local PlayerData = Ex.Function.GetPlayerData()
    local Sword = PlayerData and PlayerData:FindFirstChild("Sword")
    local CurrentSword = Sword and Sword:FindFirstChild("CurrentSword")

    if CurrentSword then
        return CurrentSword.Value
    end

    return ""
end

function Ex.Function.GetOwnedSwordArray()
    local Array = {}
    local PlayerData = Ex.Function.GetPlayerData()
    local Sword = PlayerData and PlayerData:FindFirstChild("Sword")
    local OwnedSwords = Sword and Sword:FindFirstChild("OwnedSwords")

    if not OwnedSwords or OwnedSwords.Value == "" then
        return Array
    end

    local Success, Result = pcall(function()
        return Ex.Service.HttpService:JSONDecode(OwnedSwords.Value)
    end)

    if Success and type(Result) == "table" then
        for _, SwordName in next, Result do
            table.insert(Array, tostring(SwordName))
        end
    end

    return Array
end

function Ex.Function.HasOwnedSword(Name)
    if not Name or Name == "" then
        return false
    end

    if Ex.Function.GetCurrentSwordName() == Name or Ex.Function.FindToolByName(Name) then
        return true
    end

    for _, SwordName in next, Ex.Function.GetOwnedSwordArray() do
        if SwordName == Name or SwordName == Name .. " V2" then
            return true
        end
    end

    return false
end

function Ex.Function.GetSwordSellerModel()
    local NpcWorkspace = workspace:FindFirstChild("Npc_Workspace")
    local Sellers = NpcWorkspace and NpcWorkspace:FindFirstChild("Sword Sellers")

    return Sellers and Sellers:FindFirstChild(Ex.Config.Startup.SwordName)
end

function Ex.Function.GetSwordSellerCFrame()
    local Seller = Ex.Function.GetSwordSellerModel()
    local Part = Seller and (Seller:FindFirstChild("HumanoidRootPart", true) or Seller.PrimaryPart or Seller:FindFirstChildWhichIsA("BasePart", true))

    if Part then
        return Part.CFrame * CFrame.new(0, 4, -6)
    end

    return nil
end

function Ex.Function.WaitForSwordTool(Name, Timeout)
    local StartedAt = os.clock()

    repeat
        local Tool = Ex.Function.FindToolByName(Name)

        if Tool and Tool:FindFirstChild("SwordServer") then
            return Tool
        end

        task.wait(0.1)
    until Timeout and os.clock() - StartedAt >= Timeout

    return Ex.Function.FindToolByName(Name)
end

function Ex.Function.GetPlayerLevel()
    local PlayerData = Ex.Service.Player:FindFirstChild("PlayerData")
    local Experience = PlayerData and PlayerData:FindFirstChild("Experience")
    local Level = Experience and Experience:FindFirstChild("Level")

    if Level then
        return Level.Value
    end

    return 1
end

function Ex.Function.GetCurrency()
    local PlayerData = Ex.Service.Player:FindFirstChild("PlayerData")
    local Currency = PlayerData and PlayerData:FindFirstChild("Currency")

    return tonumber(Currency and Currency.Value) or 0
end

function Ex.Function.GetGems()
    local PlayerData = Ex.Service.Player:FindFirstChild("PlayerData")
    local Gems = PlayerData and PlayerData:FindFirstChild("Gems")

    return tonumber(Gems and Gems.Value) or 0
end

function Ex.Function.GetStringValue(Parent, Name)
    local Value = Parent and Parent:FindFirstChild(Name)

    if not Value then
        return ""
    end

    return tostring(Value.Value or "")
end

function Ex.Function.GetFruitPowerMap()
    if Ex.State.FruitPowerMap then
        return Ex.State.FruitPowerMap
    end

    local Map = {}
    local Config = Ex.Service.ReplicatedStorage:FindFirstChild("Config")
    local Powers = Config and Config:FindFirstChild("Powers")
    local Success, Result = pcall(function()
        return Powers and require(Powers)
    end)

    if Success and type(Result) == "table" then
        for FruitName, FruitData in next, Result do
            Map[tostring(FruitName)] = FruitData
        end
    end

    Ex.State.FruitPowerMap = Map

    return Map
end

function Ex.Function.NormalizeFruitName(Name)
    Name = tostring(Name or "")

    if Name == "" then
        return nil
    end

    local Powers = Ex.Function.GetFruitPowerMap()

    if Powers[Name] then
        return Name
    end

    local WithoutFruit = string.gsub(Name, "%s[Ff]ruit$", "")

    if Powers[WithoutFruit] then
        return WithoutFruit
    end

    return nil
end

function Ex.Function.DecodeJsonTable(Value)
    if type(Value) ~= "string" or Value == "" then
        return {}
    end

    local Success, Result = pcall(function()
        return Ex.Service.HttpService:JSONDecode(Value)
    end)

    if Success and type(Result) == "table" then
        return Result
    end

    return {}
end

function Ex.Function.InsertFruitEntry(Array, Index, Name, Amount, Source)
    local FruitName = Ex.Function.NormalizeFruitName(Name)

    if not FruitName then
        return false
    end

    local Count = math.max(1, math.floor(tonumber(Amount) or 1))
    local Entry = Index[FruitName]

    if Entry then
        Entry.Amount = Entry.Amount + Count
        return true
    end

    Entry = {
        Name = FruitName,
        Amount = Count,
        Source = Source,
    }

    table.insert(Array, Entry)
    Index[FruitName] = Entry

    return true
end

function Ex.Function.CollectJsonFruits(Value, Source)
    local Array = {}
    local Index = {}
    local Decoded = Ex.Function.DecodeJsonTable(Value)

    for Key, Data in next, Decoded do
        if type(Data) == "string" then
            Ex.Function.InsertFruitEntry(Array, Index, Data, 1, Source)
        elseif type(Data) == "number" then
            Ex.Function.InsertFruitEntry(Array, Index, Key, Data, Source)
        elseif type(Data) == "boolean" then
            if Data then
                Ex.Function.InsertFruitEntry(Array, Index, Key, 1, Source)
            end
        elseif type(Data) == "table" then
            local Name = Data.Name or Data.Fruit or Data.FruitName or Data.Item or Data.Power or Key
            local Amount = Data.Amount or Data.Count or Data.Quantity or Data.Copies or Data[2] or 1

            Ex.Function.InsertFruitEntry(Array, Index, Name, Amount, Source)
        end
    end

    return Array
end

function Ex.Function.MergeFruitArrays(TargetArray, TargetIndex, SourceArray)
    for _, Entry in next, SourceArray do
        Ex.Function.InsertFruitEntry(TargetArray, TargetIndex, Entry.Name, Entry.Amount, Entry.Source)
    end
end

function Ex.Function.CollectToolFruits(Container, Source)
    local Array = {}
    local Index = {}

    if not Container then
        return Array
    end

    for _, Tool in next, Container:GetChildren() do
        if Tool:IsA("Tool") then
            local FruitName = Tool:GetAttribute("FruitPower") or Tool:GetAttribute("Power") or Tool:GetAttribute("FruitName") or Tool.Name

            Ex.Function.InsertFruitEntry(Array, Index, FruitName, 1, Source)
        end
    end

    return Array
end

function Ex.Function.CollectToolbarGuiFruits()
    local Array = {}
    local Index = {}
    local PlayerGui = Ex.Service.Player:FindFirstChildOfClass("PlayerGui")
    local Toolbar = PlayerGui and PlayerGui:FindFirstChild("Toolbar")
    local Mainframe = Toolbar and Toolbar:FindFirstChild("Mainframe")
    local Wrapper = Mainframe and Mainframe:FindFirstChild("Wrapper")

    if not Wrapper then
        return Array
    end

    for _, Child in next, Wrapper:GetChildren() do
        Ex.Function.InsertFruitEntry(Array, Index, Child.Name, 1, "ToolbarGui")
    end

    return Array
end

function Ex.Function.GetFruitSnapshot()
    local PlayerData = Ex.Service.Player:FindFirstChild("PlayerData")
    local Backpack = Ex.Service.Player:FindFirstChild("Backpack")
    local Character = Ex.Function.GetCharacter()
    local InventoryArray = {}
    local InventoryIndex = {}
    local ToolbarArray = {}
    local ToolbarIndex = {}

    if PlayerData then
        Ex.Function.MergeFruitArrays(InventoryArray, InventoryIndex, Ex.Function.CollectJsonFruits(Ex.Function.GetStringValue(PlayerData, "FruitStorage"), "FruitStorage"))
        Ex.Function.MergeFruitArrays(ToolbarArray, ToolbarIndex, Ex.Function.CollectJsonFruits(Ex.Function.GetStringValue(PlayerData, "FruitsInToolbar"), "FruitsInToolbar"))
    end

    Ex.Function.MergeFruitArrays(ToolbarArray, ToolbarIndex, Ex.Function.CollectToolFruits(Backpack, "Backpack"))
    Ex.Function.MergeFruitArrays(ToolbarArray, ToolbarIndex, Ex.Function.CollectToolFruits(Character, "Character"))
    Ex.Function.MergeFruitArrays(ToolbarArray, ToolbarIndex, Ex.Function.CollectToolbarGuiFruits())

    return {
        Inventory = InventoryArray,
        Toolbar = ToolbarArray,
        CurrentSuperPower = PlayerData and Ex.Function.GetStringValue(PlayerData, "CurrentSuperPower") or "",
    }
end

function Ex.Function.FormatFruitList(Array)
    if not Array or #Array == 0 then
        return Ex.Config.Description.EmptyText
    end

    local Output = {}
    local Limit = math.min(#Array, Ex.Config.Description.MaxFruitNames)

    for Index = 1, Limit do
        local Entry = Array[Index]
        local Text = Entry.Name

        if Entry.Amount and Entry.Amount > 1 then
            Text = Text .. " x" .. tostring(Entry.Amount)
        end

        table.insert(Output, Text)
    end

    if #Array > Limit then
        table.insert(Output, "+" .. tostring(#Array - Limit) .. " more")
    end

    return table.concat(Output, ", ")
end

function Ex.Function.FormatNumber(Value)
    local NumberText = tostring(math.floor(tonumber(Value) or 0))
    local Output = ""
    local Count = 0

    for Index = #NumberText, 1, -1 do
        if Count > 0 and Count % 3 == 0 then
            Output = "," .. Output
        end

        Output = string.sub(NumberText, Index, Index) .. Output
        Count = Count + 1
    end

    return Output
end

function Ex.Function.SanitizeDescription(Text)
    Text = tostring(Text or "")
    Text = string.gsub(Text, "|", ",")
    Text = string.gsub(Text, ";", ",")

    return Text
end

function Ex.Function.GetDescriptionSetter()
    local Shared = Ex.Service.Shared

    if type(G_Horst_SetDescription) == "function" then
        return G_Horst_SetDescription
    end

    if type(Horst_SetDescription) == "function" then
        return Horst_SetDescription
    end

    if type(Shared) == "table" then
        if type(Shared.G_Horst_SetDescription) == "function" then
            return Shared.G_Horst_SetDescription
        end

        if type(Shared.Horst_SetDescription) == "function" then
            return Shared.Horst_SetDescription
        end
    end

    if type(_G) == "table" then
        if type(_G.G_Horst_SetDescription) == "function" then
            return _G.G_Horst_SetDescription
        end

        if type(_G.Horst_SetDescription) == "function" then
            return _G.Horst_SetDescription
        end
    end

    return nil
end

function Ex.Function.BuildDescriptionData()
    local Fruits = Ex.Function.GetFruitSnapshot()

    return {
        Level = Ex.Function.GetPlayerLevel(),
        Money = Ex.Function.GetCurrency(),
        Gems = Ex.Function.GetGems(),
        InventoryFruits = Fruits.Inventory,
        ToolbarFruits = Fruits.Toolbar,
        CurrentSuperPower = Fruits.CurrentSuperPower ~= "" and Fruits.CurrentSuperPower or Ex.Config.Description.EmptyText,
    }
end

function Ex.Function.BuildDescriptionPayload()
    local Data = Ex.Function.BuildDescriptionData()
    local Description = table.concat({
        "💰 " .. Ex.Function.FormatNumber(Data.Money),
        "💎 " .. Ex.Function.FormatNumber(Data.Gems),
        "⭐ Lv." .. tostring(Data.Level),
        "🎒 " .. Ex.Function.FormatFruitList(Data.InventoryFruits),
        "🧰 " .. Ex.Function.FormatFruitList(Data.ToolbarFruits),
        "🍈 " .. tostring(Data.CurrentSuperPower),
    }, Ex.Config.Description.Separator)
    local EncodedJson = ""

    if Ex.Config.Description.UseEncodeJson then
        local Success, Result = pcall(function()
            return Ex.Service.HttpService:JSONEncode(Data)
        end)

        if Success then
            EncodedJson = Result
        end
    end

    return Ex.Function.SanitizeDescription(Description), EncodedJson, Data
end

function Ex.Function.UpdateDescription()
    if not Ex.Config.Description.Enabled then
        return false
    end

    local Setter = Ex.Function.GetDescriptionSetter()
    local Description, EncodedJson = Ex.Function.BuildDescriptionPayload()

    Ex.State.LastDescription = Description
    Ex.State.LastDescriptionJson = EncodedJson
    Ex.State.LastDescriptionAt = os.clock()

    if not Setter then
        Ex.State.LastDescriptionError = "MissingDescriptionSetter"
        return false
    end

    local Success = pcall(function()
        Setter(Description, EncodedJson)
    end)

    if not Success then
        Success = pcall(function()
            Setter(Description)
        end)
    end

    if Success then
        Ex.State.LastDescriptionError = nil
    else
        Ex.State.LastDescriptionError = "SetDescriptionFailed"
    end

    return Success
end

function Ex.Function.KeepDescriptionUpdated()
    if Ex.Service.Shared.__HazeSeasDescriptionRunning then
        return
    end

    Ex.Service.Shared.__HazeSeasDescriptionRunning = true

    while Ex.Config.Description.Enabled and game.PlaceId == Ex.Config.PlaceId.Target do
        Ex.Function.UpdateDescription()
        task.wait(Ex.Config.Description.UpdateDelay)
    end

    Ex.Service.Shared.__HazeSeasDescriptionRunning = nil
end

function Ex.Function.GetBusoLevel()
    local PlayerData = Ex.Service.Player:FindFirstChild("PlayerData")
    local Buso = PlayerData and PlayerData:FindFirstChild("Buso")
    local BusoLevel = Buso and Buso:FindFirstChild("BusoLevel")

    return tonumber(BusoLevel and BusoLevel.Value) or 0
end

function Ex.Function.HasBusoHaki()
    return Ex.Function.GetBusoLevel() >= 1
end

function Ex.Function.GetInstanceRootPart(InstanceData)
    if not InstanceData then
        return nil
    end

    if InstanceData:IsA("BasePart") then
        return InstanceData
    end

    if InstanceData:IsA("Model") then
        return InstanceData:FindFirstChild("HumanoidRootPart", true) or InstanceData.PrimaryPart or InstanceData:FindFirstChildWhichIsA("BasePart", true)
    end

    return InstanceData:FindFirstChildWhichIsA("BasePart", true)
end

function Ex.Function.GetBusoFolder()
    local NpcWorkspace = workspace:FindFirstChild("Npc_Workspace")

    return NpcWorkspace and NpcWorkspace:FindFirstChild("Buso")
end

function Ex.Function.GetBusoTrainerModel()
    local Folder = Ex.Function.GetBusoFolder()

    if not Folder then
        return nil
    end

    local Trainer = Folder:FindFirstChild(Ex.Config.Haki.BusoLevelName)

    if Trainer then
        return Trainer
    end

    local Selected = nil
    local BestLevel = math.huge

    for _, Child in next, Folder:GetChildren() do
        local Level = tonumber(Child.Name)

        if Level and Level < BestLevel then
            Selected = Child
            BestLevel = Level
        end
    end

    return Selected
end

function Ex.Function.GetBusoTrainerCFrame()
    local Trainer = Ex.Function.GetBusoTrainerModel()
    local Part = Ex.Function.GetInstanceRootPart(Trainer)

    if Part then
        return Part.CFrame * CFrame.new(0, 4, -6)
    end

    return Ex.Config.Haki.BusoNpcCFrame
end

function Ex.Function.WaitForBusoTrainer(Timeout)
    local StartedAt = os.clock()

    Timeout = Timeout or Ex.Config.Haki.BuyTimeout

    repeat
        local Trainer = Ex.Function.GetBusoTrainerModel()

        if Trainer then
            return Trainer
        end

        for _, TargetCFrame in next, Ex.Config.Haki.BusoLoadCFrames do
            Ex.Function.TeleportToCFrame(TargetCFrame, true)

            local HoldStartedAt = os.clock()

            repeat
                Trainer = Ex.Function.GetBusoTrainerModel()

                if Trainer then
                    return Trainer
                end

                local Root = Ex.Function.GetRoot()

                if Root then
                    Ex.Function.SetRootCFrame(Root, TargetCFrame)
                    Ex.Function.SetFarmHoldState(Root)
                    Ex.Function.SetNoClip()
                end

                task.wait(0.25)
            until os.clock() - HoldStartedAt >= Ex.Config.Haki.LoadHoldTime or os.clock() - StartedAt >= Timeout

            if os.clock() - StartedAt >= Timeout then
                break
            end
        end

        task.wait(0.2)
    until os.clock() - StartedAt >= Timeout

    return Ex.Function.GetBusoTrainerModel()
end

function Ex.Function.ShouldBuyBusoHaki()
    if not Ex.Config.Haki.Enabled or Ex.State.StartupHakiDone or Ex.State.BuyingHaki then
        return false
    end

    if Ex.Function.HasBusoHaki() then
        Ex.State.StartupHakiDone = true
        return false
    end

    if Ex.Function.GetPlayerLevel() < Ex.Config.Haki.RequiredLevel then
        return false
    end

    if Ex.Function.GetCurrency() < Ex.Config.Haki.RequiredBeli then
        return false
    end

    return os.clock() - (Ex.State.LastHakiBuyAttempt or 0) >= Ex.Config.Haki.BuyRetryDelay
end

function Ex.Function.UseBusoHaki(Force)
    if not Ex.Config.Haki.UseBeforeAttack or not Ex.Function.HasBusoHaki() then
        return false
    end

    local Character = Ex.Function.GetCharacter()
    local BusoEnabled = Character and Character:FindFirstChild("BusoEnabled")

    if BusoEnabled and BusoEnabled.Value == true then
        return true
    end

    if not Force and os.clock() - (Ex.State.LastBusoUseAt or 0) < Ex.Config.Haki.UseCooldown then
        return false
    end

    local PlayerGui = Ex.Service.Player:FindFirstChildOfClass("PlayerGui")
    local FormerScripts = PlayerGui and PlayerGui:FindFirstChild("FormerStarterCharacterScripts")
    local BusoServer = FormerScripts and FormerScripts:FindFirstChild("Buso_Server")
    local Communication = BusoServer and BusoServer:FindFirstChild("Comunication")

    if not Communication then
        return false
    end

    Ex.State.LastBusoUseAt = os.clock()

    pcall(function()
        Communication:FireServer()
    end)

    task.wait(Ex.Config.Haki.UseDelay)

    return BusoEnabled and BusoEnabled.Value == true or true
end

function Ex.Function.BuyBusoHaki()
    if not Ex.Config.Haki.Enabled then
        return false
    end

    if Ex.Function.HasBusoHaki() then
        Ex.State.StartupHakiDone = true
        Ex.Function.UseBusoHaki(true)
        return true
    end

    if Ex.Function.GetPlayerLevel() < Ex.Config.Haki.RequiredLevel or Ex.Function.GetCurrency() < Ex.Config.Haki.RequiredBeli then
        return false
    end

    Ex.State.BuyingHaki = true
    Ex.State.LastHakiBuyAttempt = os.clock()
    Ex.Function.ClearLockedMob()
    Ex.Function.ClearRespawnWait()

    local Success = false

    local RunSuccess, ErrorMessage = pcall(function()
        local Trainer = Ex.Function.WaitForBusoTrainer(Ex.Config.Haki.BuyTimeout)
        local BusoRemote = Ex.Function.GetClientEvent("Buso")

        if not Trainer or not BusoRemote then
            Ex.State.LastHakiBuyResponse = "MissingTrainerOrRemote"
            return
        end

        Ex.Function.TeleportToCFrame(Ex.Function.GetBusoTrainerCFrame(), true)
        task.wait(Ex.Config.Haki.BuyDelay)

        local InvokeSuccess, Response = pcall(function()
            return BusoRemote:InvokeServer(Trainer)
        end)

        Ex.State.LastHakiBuyResponse = InvokeSuccess and tostring(Response) or "InvokeFailed"

        if not InvokeSuccess then
            return
        end

        local WaitStartedAt = os.clock()

        repeat
            if Ex.Function.HasBusoHaki() then
                Ex.State.StartupHakiDone = true
                Ex.Function.UseBusoHaki(true)
                Success = true
                return
            end

            task.wait(0.25)
        until os.clock() - WaitStartedAt >= 3
    end)

    if not RunSuccess then
        Ex.State.LastHakiBuyResponse = tostring(ErrorMessage)
    end

    Ex.State.BuyingHaki = false

    return Success
end

function Ex.Function.GetQuestFolder()
    return Ex.Service.Player:FindFirstChild("Quest")
end

function Ex.Function.GetQuestValue(Name)
    local Quest = Ex.Function.GetQuestFolder()
    local Value = Quest and Quest:FindFirstChild(Name)

    if not Value then
        return nil
    end

    return Value.Value
end

function Ex.Function.HasQuest()
    local NPCName = Ex.Function.GetQuestValue("NPCName") or ""
    local QuestName = Ex.Function.GetQuestValue("QuestName") or ""
    local Objective = Ex.Function.GetQuestValue("Objective") or ""

    return NPCName ~= "" or QuestName ~= "" or Objective ~= ""
end

function Ex.Function.GetQuestByMob(MobName)
    if not MobName or MobName == "" then
        return nil
    end

    for _, Quest in next, Ex.Config.QuestList do
        if Quest.Mob == MobName then
            return Quest
        end
    end

    return nil
end

function Ex.Function.GetQuestForLevel(Level)
    local Selected = Ex.Config.QuestList[1]

    for _, Quest in next, Ex.Config.QuestList do
        if Quest.Level <= Level then
            Selected = Quest
        else
            break
        end
    end

    return Selected
end

function Ex.Function.GetActiveQuestData()
    local MobName = Ex.Function.GetQuestValue("NPCName")

    if not MobName or MobName == "" then
        MobName = Ex.Function.GetQuestValue("QuestName")
    end

    return Ex.Function.GetQuestByMob(MobName)
end

function Ex.Function.IsQuestMatch(Quest)
    if not Quest then
        return false
    end

    local NPCName = Ex.Function.GetQuestValue("NPCName") or ""
    local QuestName = Ex.Function.GetQuestValue("QuestName") or ""

    return NPCName == Quest.Mob or QuestName == Quest.Mob
end

function Ex.Function.GetPlayerGui()
    return Ex.Service.Player:FindFirstChildOfClass("PlayerGui")
end

function Ex.Function.GetQuestGuiRemote(Name)
    local PlayerGui = Ex.Function.GetPlayerGui()
    local QuestGui = PlayerGui and PlayerGui:FindFirstChild("QuestGui")

    return QuestGui and QuestGui:FindFirstChild(Name)
end

function Ex.Function.GetQuestGiver(Quest)
    local NpcWorkspace = workspace:FindFirstChild("Npc_Workspace")
    local QuestGivers = NpcWorkspace and NpcWorkspace:FindFirstChild("QuestGivers")

    return QuestGivers and QuestGivers:FindFirstChild(Quest.Giver)
end

function Ex.Function.GetQuestLevelName(Quest)
    return Quest.LevelName or ("Level " .. tostring(Quest.Level))
end

function Ex.Function.SetPendingQuest(Quest)
    if not Quest then
        return
    end

    Ex.State.PendingQuest = {
        Mob = Quest.Mob,
        Level = Quest.Level,
        ExpiresAt = os.clock() + Ex.Config.AutoFarm.PendingQuestDelay,
    }
end

function Ex.Function.ClearPendingQuest(Quest)
    local PendingQuest = Ex.State.PendingQuest

    if not PendingQuest then
        return
    end

    if not Quest or PendingQuest.Mob == Quest.Mob then
        Ex.State.PendingQuest = nil
    end
end

function Ex.Function.IsPendingQuest(Quest)
    local PendingQuest = Ex.State.PendingQuest

    if not PendingQuest or not Quest then
        return false
    end

    if os.clock() >= PendingQuest.ExpiresAt then
        Ex.State.PendingQuest = nil
        return false
    end

    return PendingQuest.Mob == Quest.Mob and PendingQuest.Level == Quest.Level
end

function Ex.Function.GetQuestKey(Quest)
    if not Quest then
        return ""
    end

    return tostring(Quest.Giver) .. ":" .. tostring(Quest.Level) .. ":" .. tostring(Quest.Mob)
end

function Ex.Function.GetQuestByKey(QuestKey)
    if not QuestKey or QuestKey == "" then
        return nil
    end

    for _, Quest in next, Ex.Config.QuestList do
        if Ex.Function.GetQuestKey(Quest) == QuestKey then
            return Quest
        end
    end

    return nil
end

function Ex.Function.SetQuestLock(Quest)
    if not Quest then
        return
    end

    Ex.State.QuestLock = {
        Key = Ex.Function.GetQuestKey(Quest),
        Mob = Quest.Mob,
        Level = Quest.Level,
        ExpiresAt = os.clock() + Ex.Config.AutoFarm.QuestSyncGraceTime,
    }
end

function Ex.Function.GetQuestLock(Quest)
    local QuestLock = Ex.State.QuestLock

    if not QuestLock then
        return nil
    end

    if os.clock() >= QuestLock.ExpiresAt then
        Ex.State.QuestLock = nil
        return nil
    end

    if Quest and QuestLock.Key ~= Ex.Function.GetQuestKey(Quest) then
        return nil
    end

    return Ex.Function.GetQuestByKey(QuestLock.Key)
end

function Ex.Function.IsQuestLocked(Quest)
    return Ex.Function.GetQuestLock(Quest) ~= nil
end

function Ex.Function.MarkFarmQuest(Quest)
    if not Quest then
        return
    end

    local QuestKey = Ex.Function.GetQuestKey(Quest)

    if Ex.State.ActiveFarmKey and Ex.State.ActiveFarmKey ~= QuestKey then
        Ex.Function.ClearLockedMob()
    end

    Ex.State.ActiveFarmKey = QuestKey
end

function Ex.Function.ClearLockedMob(Quest)
    if Quest and Ex.State.LockedMobQuestKey ~= Ex.Function.GetQuestKey(Quest) then
        return
    end

    Ex.State.LockedMob = nil
    Ex.State.LockedMobQuestKey = nil
    Ex.State.LockedMobAt = nil
    Ex.State.OrbitMob = nil
    Ex.State.OrbitLastAt = nil
end

function Ex.Function.SetRootCFrame(Root, TargetCFrame)
    if not Root or not TargetCFrame then
        return false
    end

    Root.CFrame = TargetCFrame
    Root.AssemblyLinearVelocity = Vector3.zero
    Root.AssemblyAngularVelocity = Vector3.zero

    return true
end

function Ex.Function.SetTransportState(Root, Enabled)
    local Humanoid = Ex.Function.GetHumanoid()

    if not Root then
        return
    end

    pcall(function()
        Root.Anchored = Enabled
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
    end)

    if Humanoid then
        pcall(function()
            Humanoid.Sit = false
            Humanoid.PlatformStand = false
        end)
    end
end

function Ex.Function.SetFarmHoldState(Root)
    local Humanoid = Ex.Function.GetHumanoid()

    if not Root then
        return
    end

    pcall(function()
        Root.Anchored = Ex.Config.AutoFarm.FarmAnchorRoot == true
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
    end)

    if Humanoid then
        pcall(function()
            Humanoid.Sit = false
            Humanoid.PlatformStand = false
        end)
    end
end

function Ex.Function.TeleportToCFrame(TargetCFrame, ForceBypass)
    local Root = Ex.Function.GetRoot()
    local Config = Ex.Config.AutoFarm

    if not Root or not TargetCFrame then
        return false
    end

    local Distance = (Root.Position - TargetCFrame.Position).Magnitude

    if not (ForceBypass or Config.BypassTeleport) or Distance <= Config.TeleportDistanceCheck then
        return Ex.Function.SetRootCFrame(Root, TargetCFrame)
    end

    local Duration = math.clamp(Distance / math.max(1, Config.TeleportTweenSpeed), Config.TeleportTweenMinDuration, Config.TeleportTweenMaxDuration)
    local TweenInfoData = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local Mover = Instance.new("CFrameValue")
    local Success, Tween = pcall(function()
        return Ex.Service.TweenService:Create(Mover, TweenInfoData, {
            Value = TargetCFrame,
        })
    end)
    local LastRoot = Root
    local Finished = false
    local Connection = nil
    local MoveConnection = nil

    Mover.Value = Root.CFrame

    if not Success or not Tween then
        Mover:Destroy()
        return Ex.Function.SetRootCFrame(Root, TargetCFrame)
    end

    local StartedAt = os.clock()

    Ex.Function.SetTransportState(LastRoot, false)

    Connection = Tween.Completed:Connect(function()
        Finished = true
    end)

    MoveConnection = Mover:GetPropertyChangedSignal("Value"):Connect(function()
        local CurrentRoot = Ex.Function.GetRoot()

        if CurrentRoot and CurrentRoot == LastRoot then
            Ex.Function.SetRootCFrame(CurrentRoot, Mover.Value)
        end
    end)

    pcall(function()
        Tween:Play()
    end)

    repeat
        Root = Ex.Function.GetRoot()

        if not Root or Root ~= LastRoot then
            pcall(function()
                Tween:Cancel()
            end)

            if Connection then
                Connection:Disconnect()
            end

            if MoveConnection then
                MoveConnection:Disconnect()
            end

            Mover:Destroy()
            Ex.Function.SetTransportState(LastRoot, false)
            return false
        end

        Ex.Function.SetTransportState(Root, false)

        if Ex.Function.SetNoClip then
            Ex.Function.SetNoClip()
        end

        task.wait(Config.TeleportTweenPollDelay)
    until Finished or os.clock() - StartedAt >= Duration + 0.75

    if Connection then
        Connection:Disconnect()
    end

    if MoveConnection then
        MoveConnection:Disconnect()
    end

    if not Finished then
        pcall(function()
            Tween:Cancel()
        end)
    end

    Mover:Destroy()
    Ex.Function.SetRootCFrame(LastRoot, TargetCFrame)

    StartedAt = os.clock()

    repeat
        Root = Ex.Function.GetRoot()

        if not Root or Root ~= LastRoot then
            Ex.Function.SetTransportState(LastRoot, false)
            return false
        end

        Ex.Function.SetTransportState(Root, false)
        Ex.Function.SetRootCFrame(Root, TargetCFrame)

        if Ex.Function.SetNoClip then
            Ex.Function.SetNoClip()
        end

        task.wait(Config.TeleportHoldStep)
    until os.clock() - StartedAt >= Config.TeleportHoldTime

    Ex.Function.SetRootCFrame(LastRoot, TargetCFrame)
    Ex.Function.SetTransportState(LastRoot, false)

    return true
end

function Ex.Function.SmoothFarmMoveToCFrame(TargetCFrame, ForceTween)
    local Root = Ex.Function.GetRoot()
    local Config = Ex.Config.AutoFarm

    if not Root or not TargetCFrame then
        return false
    end

    local Distance = (Root.Position - TargetCFrame.Position).Magnitude

    if not Config.SmoothFarmFollow then
        return Ex.Function.SetRootCFrame(Root, TargetCFrame)
    end

    if Distance <= Config.FarmFollowTweenDistance and not ForceTween then
        local Alpha = math.clamp(Config.FarmFollowAlpha, 0.05, 1)
        local Moved = Ex.Function.SetRootCFrame(Root, Root.CFrame:Lerp(TargetCFrame, Alpha))

        Ex.Function.SetFarmHoldState(Root)
        return Moved
    end

    local MoveSpeed = ForceTween and Config.FarmOrbitTweenSpeed or Config.FarmFollowTweenSpeed
    local MinDuration = ForceTween and Config.FarmOrbitTweenMinDuration or Config.FarmFollowTweenMinDuration
    local MaxDuration = ForceTween and Config.FarmOrbitTweenMaxDuration or Config.FarmFollowTweenMaxDuration
    local Duration = math.clamp(Distance / math.max(1, MoveSpeed), MinDuration, MaxDuration)
    local TweenInfoData = TweenInfo.new(Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local Mover = Instance.new("CFrameValue")
    local Success, Tween = pcall(function()
        return Ex.Service.TweenService:Create(Mover, TweenInfoData, {
            Value = TargetCFrame,
        })
    end)
    local LastRoot = Root
    local Finished = false
    local Connection = nil
    local MoveConnection = nil

    Mover.Value = Root.CFrame

    if not Success or not Tween then
        Mover:Destroy()
        return Ex.Function.SetRootCFrame(Root, TargetCFrame)
    end

    local StartedAt = os.clock()

    Connection = Tween.Completed:Connect(function()
        Finished = true
    end)

    MoveConnection = Mover:GetPropertyChangedSignal("Value"):Connect(function()
        local CurrentRoot = Ex.Function.GetRoot()

        if CurrentRoot and CurrentRoot == LastRoot then
            Ex.Function.SetRootCFrame(CurrentRoot, Mover.Value)
        end
    end)

    pcall(function()
        Tween:Play()
    end)

    repeat
        Root = Ex.Function.GetRoot()

        if not Root or Root ~= LastRoot then
            pcall(function()
                Tween:Cancel()
            end)

            if Connection then
                Connection:Disconnect()
            end

            if MoveConnection then
                MoveConnection:Disconnect()
            end

            Mover:Destroy()
            return false
        end

        Ex.Function.SetFarmHoldState(Root)

        if Ex.Function.SetNoClip then
            Ex.Function.SetNoClip()
        end

        task.wait(Config.TeleportTweenPollDelay)
    until Finished or os.clock() - StartedAt >= Duration + 0.35

    if Connection then
        Connection:Disconnect()
    end

    if MoveConnection then
        MoveConnection:Disconnect()
    end

    if not Finished then
        pcall(function()
            Tween:Cancel()
        end)
    end

    Mover:Destroy()
    local Moved = Ex.Function.SetRootCFrame(LastRoot, TargetCFrame)

    Ex.Function.SetFarmHoldState(LastRoot)
    return Moved
end

function Ex.Function.FindQuestGiverCFrame(Quest)
    if not Quest then
        return nil
    end

    local Positions = workspace:FindFirstChild("Logic") and workspace.Logic:FindFirstChild("QuestGiverPositions")
    local Position = Positions and Positions:FindFirstChild(Quest.Giver)

    if Position and Position:IsA("BasePart") then
        return Position.CFrame * CFrame.new(0, 4, -5)
    end

    local Giver = Ex.Function.GetQuestGiver(Quest)
    local GiverRoot = Giver and (Giver:FindFirstChild("HumanoidRootPart", true) or (Giver:IsA("Model") and Giver.PrimaryPart) or Giver:FindFirstChildWhichIsA("BasePart", true))

    if GiverRoot then
        return GiverRoot.CFrame * CFrame.new(0, 4, -5)
    end

    return nil
end

function Ex.Function.FindChildWithIslandAlias(Container, IslandName)
    if not Container or not IslandName then
        return nil
    end

    local Alias = Ex.Config.IslandAlias[IslandName]
    local Child = Container:FindFirstChild(IslandName) or (Alias and Container:FindFirstChild(Alias))

    if Child then
        return Child
    end

    for AliasName, TargetName in next, Ex.Config.IslandAlias do
        if TargetName == IslandName then
            Child = Container:FindFirstChild(AliasName)

            if Child then
                return Child
            end
        end
    end

    return nil
end

function Ex.Function.FindIslandCFrame(IslandName)
    local NpcWorkspace = workspace:FindFirstChild("Npc_Workspace")
    local SpawnSetters = NpcWorkspace and NpcWorkspace:FindFirstChild("Spawn Setters")
    local Setter = Ex.Function.FindChildWithIslandAlias(SpawnSetters, IslandName)
    local Part = Setter and (Setter:FindFirstChild("Quest", true) or Setter:FindFirstChild("HumanoidRootPart", true) or (Setter:IsA("Model") and Setter.PrimaryPart) or Setter:FindFirstChildWhichIsA("BasePart", true))

    if Part then
        return Part.CFrame * CFrame.new(0, 8, 0)
    end

    return nil
end

function Ex.Function.GetQuestZone(IslandName)
    local Zones = workspace:FindFirstChild("NPC Zones")

    if not Zones or not IslandName then
        return nil
    end

    return Ex.Function.FindChildWithIslandAlias(Zones, IslandName)
end

function Ex.Function.GetQuestNpcFolder(IslandName)
    local Zone = Ex.Function.GetQuestZone(IslandName)

    return Zone and Zone:FindFirstChild("NPCS")
end

function Ex.Function.SetIslandSpawnPoint(IslandName)
    if not Ex.Config.AutoFarm.SetSpawnOnIslandLoad or not IslandName then
        return false
    end

    if Ex.State.LastSpawnSet[IslandName] and os.clock() - Ex.State.LastSpawnSet[IslandName] < Ex.Config.AutoFarm.SetSpawnCooldown then
        return true
    end

    local SetSpawnPoint = Ex.Function.GetClientEvent("SetSpawnPoint")

    if not SetSpawnPoint then
        return false
    end

    local IslandNames = {
        IslandName,
        Ex.Config.IslandAlias[IslandName],
    }

    for _, Name in next, IslandNames do
        if Name and Name ~= "" then
            pcall(function()
                SetSpawnPoint:FireServer(Name)
            end)

            Ex.State.LastSpawnSet[IslandName] = os.clock()
            task.wait(0.1)
        end
    end

    return true
end

function Ex.Function.FindMobSpawnCFrame(Quest)
    if not Quest then
        return nil
    end

    local IslandMobs = Ex.Function.GetQuestNpcFolder(Quest.Island)

    if IslandMobs then
        for _, Mob in next, IslandMobs:GetChildren() do
            if Ex.Function.GetMobName(Mob) == Quest.Mob then
                local SpawnCFrame = Mob:FindFirstChild("SpawnCFrame")

                if SpawnCFrame and SpawnCFrame:IsA("CFrameValue") then
                    return SpawnCFrame.Value * CFrame.new(0, 8, 0)
                end
            end
        end
    end

    return nil
end

function Ex.Function.FindIslandAnchorCFrame(Quest)
    if not Quest then
        return nil
    end

    return Ex.Function.FindMobSpawnCFrame(Quest) or Ex.Function.FindIslandCFrame(Quest.Island) or Ex.Function.FindQuestGiverCFrame(Quest)
end

function Ex.Function.RememberFarmPoint(Quest, Mob)
    local MobRoot = Mob and Mob:FindFirstChild("HumanoidRootPart")

    if not Quest or not MobRoot then
        return
    end

    local QuestKey = Ex.Function.GetQuestKey(Quest)

    Ex.State.LastFarmCFrame[QuestKey] = MobRoot.CFrame
    Ex.State.LastFarmAt[QuestKey] = os.clock()
end

function Ex.Function.RememberFarmHoldPoint(Quest)
    local Root = Ex.Function.GetRoot()

    if not Quest or not Root then
        return
    end

    local QuestKey = Ex.Function.GetQuestKey(Quest)

    Ex.State.LastFarmHoldCFrame[QuestKey] = Root.CFrame
    Ex.State.LastFarmHoldAt[QuestKey] = os.clock()
end

function Ex.Function.GetRememberedFarmCFrame(Quest)
    local QuestKey = Ex.Function.GetQuestKey(Quest)
    local SavedAt = Ex.State.LastFarmAt[QuestKey]
    local SavedCFrame = Ex.State.LastFarmCFrame[QuestKey]

    if not SavedAt or not SavedCFrame then
        return nil
    end

    if os.clock() - SavedAt >= Ex.Config.AutoFarm.LastFarmPointTimeout then
        Ex.State.LastFarmCFrame[QuestKey] = nil
        Ex.State.LastFarmAt[QuestKey] = nil
        return nil
    end

    return SavedCFrame * CFrame.new(0, Ex.Config.AutoFarm.Distance, 0)
end

function Ex.Function.GetRememberedFarmHoldCFrame(Quest)
    local QuestKey = Ex.Function.GetQuestKey(Quest)
    local SavedAt = Ex.State.LastFarmHoldAt[QuestKey]
    local SavedCFrame = Ex.State.LastFarmHoldCFrame[QuestKey]

    if not SavedAt or not SavedCFrame then
        return nil
    end

    if os.clock() - SavedAt >= Ex.Config.AutoFarm.LastFarmPointTimeout then
        Ex.State.LastFarmHoldCFrame[QuestKey] = nil
        Ex.State.LastFarmHoldAt[QuestKey] = nil
        return nil
    end

    return SavedCFrame
end

function Ex.Function.ClearRespawnWait(Quest)
    if Quest and Ex.State.RespawnWait and Ex.State.RespawnWait.Key ~= Ex.Function.GetQuestKey(Quest) then
        return
    end

    Ex.State.RespawnWait = nil
end

function Ex.Function.GetRespawnWaitQuest()
    local RespawnWait = Ex.State.RespawnWait

    if not RespawnWait then
        return nil
    end

    local Quest = Ex.Function.GetQuestByKey(RespawnWait.Key)

    if not Quest then
        Ex.Function.ClearRespawnWait()
        return nil
    end

    if not Ex.Function.CanWaitAtDeathForQuest(Quest) then
        Ex.Function.ClearRespawnWait(Quest)
        return nil
    end

    return Quest
end

function Ex.Function.IsBossMobName(MobName)
    if not MobName or MobName == "" then
        return false
    end

    if string.find(string.lower(MobName), "boss", 1, true) then
        return true
    end

    for _, BossName in next, Ex.Config.AutoFarm.RespawnBossMobs do
        if BossName == MobName then
            return true
        end
    end

    return false
end

function Ex.Function.IsBossMobModel(Mob)
    if not Mob then
        return false
    end

    local AttributeNames = {
        "Boss",
        "IsBoss",
        "boss",
        "isBoss",
    }

    for _, AttributeName in next, AttributeNames do
        local Success, Value = pcall(function()
            return Mob:GetAttribute(AttributeName)
        end)

        if Success and Value == true then
            return true
        end
    end

    return Mob:FindFirstChild("Boss") ~= nil or Mob:FindFirstChild("IsBoss") ~= nil
end

function Ex.Function.CanWaitAtDeathForQuest(Quest, Mob)
    if not Ex.Config.AutoFarm.WaitAtDeathBossOnly then
        return true
    end

    return Quest and (Ex.Function.IsBossMobName(Quest.Mob) or Ex.Function.IsBossMobModel(Mob))
end

function Ex.Function.StartRespawnWait(Quest, Mob)
    if not Ex.Config.AutoFarm.WaitAtDeathUntilRespawn or not Quest then
        return false
    end

    if not Ex.Function.CanWaitAtDeathForQuest(Quest, Mob) then
        Ex.Function.ClearRespawnWait(Quest)
        return false
    end

    local Root = Ex.Function.GetRoot()
    local MobRoot = Mob and Mob:FindFirstChild("HumanoidRootPart")
    local QuestKey = Ex.Function.GetQuestKey(Quest)
    local SavedMobCFrame = Ex.State.LastFarmCFrame[QuestKey]
    local HoldCFrame = Ex.Function.GetRememberedFarmHoldCFrame(Quest) or (Root and Root.CFrame) or (MobRoot and MobRoot.CFrame)
    local DeathPosition = MobRoot and MobRoot.Position or (SavedMobCFrame and SavedMobCFrame.Position) or (HoldCFrame and HoldCFrame.Position)

    if not HoldCFrame or not DeathPosition then
        return false
    end

    Ex.State.RespawnWait = {
        Key = QuestKey,
        Mob = Quest.Mob,
        Island = Quest.Island,
        HoldCFrame = HoldCFrame,
        DeathPosition = DeathPosition,
        StartedAt = os.clock(),
    }

    return true
end

function Ex.Function.IsRespawnWaitActive(Quest)
    local RespawnWait = Ex.State.RespawnWait

    if not Ex.Config.AutoFarm.WaitAtDeathUntilRespawn or not RespawnWait or not Quest then
        return false
    end

    if RespawnWait.Key ~= Ex.Function.GetQuestKey(Quest) then
        Ex.Function.ClearRespawnWait()
        return false
    end

    if not Ex.Function.CanWaitAtDeathForQuest(Quest) then
        Ex.Function.ClearRespawnWait(Quest)
        return false
    end

    if Ex.Function.HasQuest() or Ex.Function.IsPendingQuest(Quest) then
        Ex.Function.SetQuestLock(Quest)
        return true
    end

    if not Ex.Function.IsQuestLocked(Quest) then
        Ex.Function.ClearRespawnWait(Quest)
        return false
    end

    return true
end

function Ex.Function.HoldRespawnWaitPosition(Quest)
    if not Ex.Function.IsRespawnWaitActive(Quest) then
        return false
    end

    local Root = Ex.Function.GetRoot()
    local RespawnWait = Ex.State.RespawnWait

    if not Root or not RespawnWait.HoldCFrame then
        return false
    end

    Ex.Function.SetRootCFrame(Root, RespawnWait.HoldCFrame)
    Ex.Function.SetFarmHoldState(Root)
    Ex.Function.SetNoClip()

    return true
end

function Ex.Function.FindRespawnWaitMob(Quest)
    if not Ex.Function.IsRespawnWaitActive(Quest) then
        return nil
    end

    local RespawnWait = Ex.State.RespawnWait
    local AnchorCFrame = CFrame.new(RespawnWait.DeathPosition)
    local Mob = Ex.Function.FindBestQuestMob(Quest, AnchorCFrame)
    local MobRoot = Mob and Mob:FindFirstChild("HumanoidRootPart")

    if MobRoot and (MobRoot.Position - RespawnWait.DeathPosition).Magnitude <= Ex.Config.AutoFarm.RespawnWaitRadius then
        Ex.Function.ClearRespawnWait(Quest)
        return Mob
    end

    return nil
end

function Ex.Function.HandleRespawnWait(Quest)
    if not Ex.Function.IsRespawnWaitActive(Quest) then
        return nil, false
    end

    local Mob = Ex.Function.FindRespawnWaitMob(Quest)

    if Mob then
        return Mob, false
    end

    Ex.Function.HoldRespawnWaitPosition(Quest)
    task.wait(Ex.Config.AutoFarm.RespawnHoldDelay)

    return nil, true
end

function Ex.Function.AddProbeCFrame(Array, ProbeCFrame)
    if not ProbeCFrame then
        return false
    end

    for _, SavedCFrame in next, Array do
        if (SavedCFrame.Position - ProbeCFrame.Position).Magnitude <= 35 then
            return false
        end
    end

    table.insert(Array, ProbeCFrame)
    return true
end

function Ex.Function.GetIslandModel(IslandName)
    local Islands = workspace:FindFirstChild("Islands")

    return Ex.Function.FindChildWithIslandAlias(Islands, IslandName)
end

function Ex.Function.CollectIslandProbeCFrames(Object, Array, Depth)
    local Config = Ex.Config.AutoFarm

    if not Object or Depth > 5 or #Array >= Config.LoadProbeMaxPoints then
        return
    end

    for _, Child in next, Object:GetChildren() do
        if Child:IsA("BasePart") then
            local Size = math.max(Child.Size.X, Child.Size.Z)

            if Size >= Config.LoadProbePartMinSize then
                Ex.Function.AddProbeCFrame(Array, CFrame.new(Child.Position + Vector3.new(0, Config.LoadProbeHeight, 0)))
            end
        end

        if #Array >= Config.LoadProbeMaxPoints then
            return
        end

        Ex.Function.CollectIslandProbeCFrames(Child, Array, Depth + 1)
    end
end

function Ex.Function.BuildQuestLoadProbeCFrames(Quest, FarmOnly)
    local Array = {}
    local Config = Ex.Config.AutoFarm
    local AnchorCFrame = Ex.Function.FindIslandAnchorCFrame(Quest)
    local QuestGiverCFrame = Ex.Function.FindQuestGiverCFrame(Quest)
    local IslandCFrame = Quest and Ex.Function.FindIslandCFrame(Quest.Island)
    local MobSpawnCFrame = Ex.Function.FindMobSpawnCFrame(Quest)
    local RememberedCFrame = Ex.Function.GetRememberedFarmCFrame(Quest)
    local AllowWideProbe = not FarmOnly or not (RememberedCFrame or MobSpawnCFrame)
    local BaseCFrame = RememberedCFrame or MobSpawnCFrame or (AllowWideProbe and (AnchorCFrame or IslandCFrame or QuestGiverCFrame))

    Ex.Function.AddProbeCFrame(Array, RememberedCFrame)
    Ex.Function.AddProbeCFrame(Array, MobSpawnCFrame)

    if AllowWideProbe then
        Ex.Function.AddProbeCFrame(Array, AnchorCFrame)
        Ex.Function.AddProbeCFrame(Array, IslandCFrame)
        Ex.Function.AddProbeCFrame(Array, QuestGiverCFrame)
    end

    if BaseCFrame then
        local Position = BaseCFrame.Position
        local Radius = Config.LoadProbeRadius
        local Offsets = {
            Vector3.new(Radius, 0, 0),
            Vector3.new(-Radius, 0, 0),
            Vector3.new(0, 0, Radius),
            Vector3.new(0, 0, -Radius),
            Vector3.new(Radius, 0, Radius),
            Vector3.new(-Radius, 0, Radius),
            Vector3.new(Radius, 0, -Radius),
            Vector3.new(-Radius, 0, -Radius),
        }

        for _, Offset in next, Offsets do
            Ex.Function.AddProbeCFrame(Array, CFrame.new(Position + Offset + Vector3.new(0, Config.LoadProbeHeight, 0)))
        end
    end

    Ex.Function.CollectIslandProbeCFrames(Quest and Ex.Function.GetIslandModel(Quest.Island), Array, 0)

    return Array
end

function Ex.Function.ProbeQuestIsland(Quest, FarmOnly)
    if not Ex.Config.AutoFarm.LoadProbeEnabled or not Quest then
        return false
    end

    local ProbeCFrames = Ex.Function.BuildQuestLoadProbeCFrames(Quest, FarmOnly)

    if #ProbeCFrames <= 0 then
        return false
    end

    local Key = Quest.Island .. ":" .. Quest.Mob .. ":" .. tostring(FarmOnly)
    local Index = Ex.State.LoadProbeIndex[Key] or 1

    for _ = 1, #ProbeCFrames do
        local ProbeCFrame = ProbeCFrames[Index]
        Ex.State.LoadProbeIndex[Key] = (Index % #ProbeCFrames) + 1

        if ProbeCFrame then
            Ex.Function.TeleportToCFrame(ProbeCFrame, true)
        end

        local StartedAt = os.clock()

        repeat
            if Ex.Function.IsQuestFarmAreaLoaded(Quest) then
                return true
            end

            task.wait(0.2)
        until os.clock() - StartedAt >= Ex.Config.AutoFarm.LoadProbeHoldTime

        Index = Ex.State.LoadProbeIndex[Key]
    end

    return Ex.Function.IsQuestFarmAreaLoaded(Quest)
end

function Ex.Function.IsQuestZoneLoaded(Quest)
    return Ex.Function.IsQuestTargetLoaded(Quest)
end

function Ex.Function.IsQuestFarmAreaLoaded(Quest)
    if not Quest then
        return false
    end

    if Ex.Function.IsQuestZoneLoaded(Quest) then
        return true
    end

    return Ex.Function.CanUseFallbackMob(Quest) and Ex.Function.FindIslandFallbackMob(Quest) ~= nil
end

function Ex.Function.WaitForQuestZone(Quest, Timeout)
    local StartedAt = os.clock()

    repeat
        if Ex.Function.IsQuestZoneLoaded(Quest) then
            return true
        end

        task.wait(0.25)
    until Timeout and os.clock() - StartedAt >= Timeout

    return Ex.Function.IsQuestZoneLoaded(Quest)
end

function Ex.Function.EnsureQuestIslandLoaded(Quest)
    if not Quest then
        return false
    end

    local Config = Ex.Config.AutoFarm
    local AnchorCFrame = Ex.Function.FindIslandAnchorCFrame(Quest)
    local ZoneReady = Ex.Function.IsQuestFarmAreaLoaded(Quest)

    if ZoneReady then
        Ex.Function.SetIslandSpawnPoint(Quest.Island)
        return true
    end

    if not AnchorCFrame then
        return Ex.Function.ProbeQuestIsland(Quest) or Ex.Function.IsQuestFarmAreaLoaded(Quest)
    end

    for Attempt = 1, Config.TeleportMaxRetries do
        Ex.Function.TeleportToCFrame(AnchorCFrame, true)

        if Ex.Function.WaitForQuestZone(Quest, Config.TeleportLoadTimeout) or Ex.Function.IsQuestFarmAreaLoaded(Quest) then
            Ex.Function.SetIslandSpawnPoint(Quest.Island)
            return true
        end

        if Ex.Function.ProbeQuestIsland(Quest) then
            Ex.Function.SetIslandSpawnPoint(Quest.Island)
            return true
        end

        task.wait(Config.TeleportRetryDelay)
    end

    return Ex.Function.IsQuestFarmAreaLoaded(Quest)
end

function Ex.Function.TeleportToQuestArea(Quest, AllowQuestGiverFallback)
    if Ex.Function.IsQuestFarmAreaLoaded(Quest) then
        return true
    end

    if Ex.Function.EnsureQuestIslandLoaded(Quest) then
        return true
    end

    if Ex.Function.TeleportToCFrame(Ex.Function.FindMobSpawnCFrame(Quest), true) then
        return true
    end

    if AllowQuestGiverFallback then
        return Ex.Function.TeleportToCFrame(Ex.Function.FindQuestGiverCFrame(Quest), true)
    end

    return false
end

function Ex.Function.AcceptQuest(Quest)
    if not Quest or Ex.Function.IsQuestMatch(Quest) then
        return true
    end

    local QuestFunction = Ex.Function.GetQuestGuiRemote("QuestFunction")
    local Giver = Ex.Function.GetQuestGiver(Quest)

    if not QuestFunction or not Giver then
        Ex.State.LastQuestAcceptError = "MissingQuestRemoteOrGiver"
        return false
    end

    local Success, Response = pcall(function()
        return QuestFunction:InvokeServer(Giver, Ex.Function.GetQuestLevelName(Quest))
    end)

    Ex.State.LastQuestAcceptResponse = tostring(Response)
    if Success then
        Ex.State.LastQuestAcceptError = nil
    else
        Ex.State.LastQuestAcceptError = "InvokeFailed"
    end

    if Success and (Response == true or Response == "AlreadyOnQuest") then
        Ex.Function.MarkFarmQuest(Quest)
        Ex.Function.SetQuestLock(Quest)
        Ex.Function.SetPendingQuest(Quest)
        task.wait(Ex.Config.AutoFarm.QuestDelay)
    end

    if Ex.Function.IsQuestMatch(Quest) then
        Ex.Function.MarkFarmQuest(Quest)
        Ex.Function.SetQuestLock(Quest)
        Ex.Function.ClearPendingQuest(Quest)
        return true
    end

    if Ex.Config.AutoFarm.QuestRemoteOnly then
        return false
    end

    Ex.Function.TeleportToCFrame(Ex.Function.FindQuestGiverCFrame(Quest))
    task.wait(Ex.Config.AutoFarm.QuestDelay)

    Success, Response = pcall(function()
        return QuestFunction:InvokeServer(Giver, Ex.Function.GetQuestLevelName(Quest))
    end)

    Ex.State.LastQuestAcceptResponse = tostring(Response)
    if Success then
        Ex.State.LastQuestAcceptError = nil
    else
        Ex.State.LastQuestAcceptError = "InvokeFailed"
    end

    if Success and (Response == true or Response == "AlreadyOnQuest") then
        Ex.Function.MarkFarmQuest(Quest)
        Ex.Function.SetQuestLock(Quest)
        Ex.Function.SetPendingQuest(Quest)
        task.wait(Ex.Config.AutoFarm.QuestDelay)
    end

    if Ex.Function.IsQuestMatch(Quest) then
        Ex.Function.MarkFarmQuest(Quest)
        Ex.Function.SetQuestLock(Quest)
        Ex.Function.ClearPendingQuest(Quest)
        return true
    end

    return Ex.Function.IsPendingQuest(Quest)
end

function Ex.Function.EnsureQuestReadyToFarm(Quest)
    if not Ex.Config.AutoFarm.RequireQuestBeforeFarm or not Quest then
        return true
    end

    if Ex.Function.IsQuestMatch(Quest) or Ex.Function.IsPendingQuest(Quest) then
        return true
    end

    if Ex.Function.HasQuest() then
        return false
    end

    return Ex.Function.AcceptQuest(Quest)
end

function Ex.Function.CancelWrongQuest()
    if not Ex.Config.AutoFarm.TryCancelWrongQuest then
        return false
    end

    local QuestEvent = Ex.Function.GetQuestGuiRemote("QuestEvent")

    if not QuestEvent then
        return false
    end

    for _, Payload in next, Ex.Config.QuestCancelPayloads do
        pcall(function()
            QuestEvent:FireServer(Payload)
        end)

        task.wait(0.15)

        if not Ex.Function.HasQuest() then
            return true
        end
    end

    return not Ex.Function.HasQuest()
end

function Ex.Function.GetMobName(Mob)
    local NPCName = Mob:FindFirstChild("NPCName")

    if NPCName and NPCName:IsA("StringValue") then
        return NPCName.Value
    end

    return string.gsub(Mob.Name, "%d+$", "")
end

function Ex.Function.IsAliveMob(Mob, MobName)
    if not Mob or Ex.Function.GetMobName(Mob) ~= MobName then
        return false
    end

    local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
    local Root = Mob:FindFirstChild("HumanoidRootPart")

    return Humanoid and Root and Humanoid.Health > 0
end

function Ex.Function.IsAliveAnyMob(Mob)
    if not Mob then
        return false
    end

    local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
    local Root = Mob:FindFirstChild("HumanoidRootPart")

    return Humanoid and Root and Humanoid.Health > 0
end

function Ex.Function.IsMobInQuestIsland(Mob, Quest)
    local QuestZone = Quest and Ex.Function.GetQuestZone(Quest.Island)
    local IslandMobs = Quest and Ex.Function.GetQuestNpcFolder(Quest.Island)

    return Mob and ((IslandMobs and Mob:IsDescendantOf(IslandMobs)) or (QuestZone and Mob:IsDescendantOf(QuestZone)))
end

function Ex.Function.IsValidQuestMob(Mob, Quest)
    return Quest and Ex.Function.IsAliveMob(Mob, Quest.Mob) and Ex.Function.IsMobInQuestIsland(Mob, Quest)
end

function Ex.Function.GetLockedFarmQuest()
    if not Ex.Config.AutoFarm.KeepLockedMobBeforeQuest then
        return nil, nil
    end

    local QuestKey = Ex.State.LockedMobQuestKey or Ex.State.ActiveFarmKey
    local Quest = Ex.Function.GetQuestByKey(QuestKey)

    if not Quest or not Ex.Function.IsValidQuestMob(Ex.State.LockedMob, Quest) then
        return nil, nil
    end

    Ex.Function.MarkFarmQuest(Quest)

    if Ex.Config.AutoFarm.RefreshQuestLockWhileFarming then
        Ex.Function.SetQuestLock(Quest)
    end

    return Quest, Ex.State.LockedMob
end

function Ex.Function.GetLockedMob(Quest)
    if not Ex.Config.AutoFarm.TargetLockEnabled or not Quest then
        return nil
    end

    if Ex.State.LockedMobQuestKey ~= Ex.Function.GetQuestKey(Quest) then
        return nil
    end

    if Ex.Function.IsValidQuestMob(Ex.State.LockedMob, Quest) then
        if Ex.Config.AutoFarm.RefreshQuestLockWhileFarming then
            Ex.Function.SetQuestLock(Quest)
        end

        return Ex.State.LockedMob
    end

    if Ex.State.LockedMob and Ex.State.LockedMobQuestKey == Ex.Function.GetQuestKey(Quest) then
        Ex.Function.StartRespawnWait(Quest, Ex.State.LockedMob)
    end

    Ex.Function.ClearLockedMob(Quest)
    return nil
end

function Ex.Function.SetLockedMob(Quest, Mob)
    if not Ex.Config.AutoFarm.TargetLockEnabled or not Ex.Function.IsValidQuestMob(Mob, Quest) then
        return Mob
    end

    if Ex.State.LockedMob ~= Mob then
        Ex.State.OrbitMob = nil
        Ex.State.OrbitLastAt = nil
    end

    Ex.State.LockedMob = Mob
    Ex.State.LockedMobQuestKey = Ex.Function.GetQuestKey(Quest)
    Ex.State.LockedMobAt = os.clock()

    if Ex.Config.AutoFarm.RefreshQuestLockWhileFarming then
        Ex.Function.SetQuestLock(Quest)
    end

    return Mob
end

function Ex.Function.ScanMobs(Container, MobName, AnchorCFrame)
    local Found = nil
    local Root = Ex.Function.GetRoot()
    local AnchorPosition = AnchorCFrame and AnchorCFrame.Position or (Root and Root.Position)
    local BestDistance = math.huge

    if not Container then
        return nil
    end

    for _, Mob in next, Container:GetChildren() do
        if Ex.Function.IsAliveMob(Mob, MobName) then
            local MobRoot = Mob:FindFirstChild("HumanoidRootPart")
            local Distance = AnchorPosition and MobRoot and (AnchorPosition - MobRoot.Position).Magnitude or 0

            if not Found or Distance < BestDistance then
                Found = Mob
                BestDistance = Distance
            end
        end
    end

    return Found
end

function Ex.Function.ShouldUseMobForScan(Mob, MobName, AnyMob, SkipMobName)
    if not Ex.Function.IsAliveAnyMob(Mob) then
        return false
    end

    local Name = Ex.Function.GetMobName(Mob)

    if SkipMobName and Name == SkipMobName then
        return false
    end

    return AnyMob or Name == MobName
end

function Ex.Function.ScanMobsDeep(Container, MobName, AnchorCFrame, AnyMob, SkipMobName)
    local Config = Ex.Config.AutoFarm
    local Found = nil
    local Root = Ex.Function.GetRoot()
    local AnchorPosition = AnchorCFrame and AnchorCFrame.Position or (Root and Root.Position)
    local BestDistance = math.huge
    local Scanned = 0

    if not Config.DeepMobScan or not Container then
        return nil
    end

    local function ScanObject(Object, Depth)
        if not Object or Depth > Config.DeepMobScanMaxDepth or Scanned >= Config.DeepMobScanMaxNodes then
            return
        end

        Scanned = Scanned + 1

        if Object:IsA("Model") and Ex.Function.ShouldUseMobForScan(Object, MobName, AnyMob, SkipMobName) then
            local MobRoot = Object:FindFirstChild("HumanoidRootPart")
            local Distance = AnchorPosition and MobRoot and (AnchorPosition - MobRoot.Position).Magnitude or 0

            if not Found or Distance < BestDistance then
                Found = Object
                BestDistance = Distance
            end
        end

        for _, Child in next, Object:GetChildren() do
            ScanObject(Child, Depth + 1)
        end
    end

    ScanObject(Container, 0)

    return Found
end

function Ex.Function.FindLoadedMobAcrossZones(MobName, AnchorCFrame)
    local Zones = workspace:FindFirstChild("NPC Zones")

    return Ex.Function.ScanMobsDeep(Zones, MobName, AnchorCFrame, false)
end

function Ex.Function.GetMissingTargetAge(Quest)
    local QuestKey = Ex.Function.GetQuestKey(Quest)

    Ex.State.MissingMobSince[QuestKey] = Ex.State.MissingMobSince[QuestKey] or os.clock()

    return os.clock() - Ex.State.MissingMobSince[QuestKey]
end

function Ex.Function.CanUseFallbackMob(Quest)
    if not Ex.Config.AutoFarm.TargetProbeBeforeFallback then
        return true
    end

    return Ex.Function.GetMissingTargetAge(Quest) >= Ex.Config.AutoFarm.FallbackAfterMissingTargetTime
end

function Ex.Function.FindIslandFallbackMob(Quest)
    if not Ex.Config.AutoFarm.FarmAvailableMobWhenTargetMissing or not Quest then
        return nil
    end

    local IslandMobs = Ex.Function.GetQuestNpcFolder(Quest.Island)
    local QuestZone = Ex.Function.GetQuestZone(Quest.Island)
    local Root = Ex.Function.GetRoot()
    local AnchorCFrame = Ex.Function.GetRememberedFarmCFrame(Quest) or (Root and Root.CFrame)
    local Found = nil
    local BestDistance = math.huge

    if IslandMobs then
        for _, Mob in next, IslandMobs:GetChildren() do
            if Ex.Function.IsAliveAnyMob(Mob) and Ex.Function.GetMobName(Mob) ~= Quest.Mob then
                local MobRoot = Mob:FindFirstChild("HumanoidRootPart")
                local Distance = AnchorCFrame and MobRoot and (AnchorCFrame.Position - MobRoot.Position).Magnitude or 0

                if not Found or Distance < BestDistance then
                    Found = Mob
                    BestDistance = Distance
                end
            end
        end
    end

    if Found then
        return Found
    end

    return Ex.Function.ScanMobsDeep(QuestZone, nil, AnchorCFrame, true, Quest.Mob)
end

function Ex.Function.IsQuestTargetLoaded(Quest)
    local QuestZone = Quest and Ex.Function.GetQuestZone(Quest.Island)
    local IslandMobs = Quest and Ex.Function.GetQuestNpcFolder(Quest.Island)

    if not Quest then
        return false
    end

    if IslandMobs then
        for _, Mob in next, IslandMobs:GetChildren() do
            if Ex.Function.GetMobName(Mob) == Quest.Mob then
                return true
            end
        end
    end

    if QuestZone and Ex.Function.ScanMobsDeep(QuestZone, Quest.Mob, nil, false) then
        return true
    end

    return false
end

function Ex.Function.FindBestQuestMob(Quest, AnchorCFrame)
    local IslandMobs = Quest and Ex.Function.GetQuestNpcFolder(Quest.Island)
    local QuestZone = Quest and Ex.Function.GetQuestZone(Quest.Island)
    local Found = Ex.Function.ScanMobs(IslandMobs, Quest.Mob, AnchorCFrame)

    if Found then
        return Found
    end

    Found = Ex.Function.ScanMobsDeep(QuestZone, Quest.Mob, AnchorCFrame, false)

    if Found then
        return Found
    end

    return Ex.Function.FindLoadedMobAcrossZones(Quest.Mob, AnchorCFrame)
end

function Ex.Function.FindMob(Quest)
    if not Quest then
        return nil
    end

    local Root = Ex.Function.GetRoot()
    local AnchorCFrame = Ex.Function.GetRememberedFarmCFrame(Quest) or (Root and Root.CFrame)
    local Found = Ex.Function.FindBestQuestMob(Quest, AnchorCFrame)

    if Found then
        return Found
    end

    if Ex.Config.AutoFarm.StrictQuestIsland then
        return nil
    end

    local Zones = workspace:FindFirstChild("NPC Zones")

    if not Zones then
        return nil
    end

    for _, Zone in next, Zones:GetChildren() do
        local NPCS = Zone:FindFirstChild("NPCS")

        Found = Ex.Function.ScanMobs(NPCS, Quest.Mob, AnchorCFrame)

        if Found then
            return Found
        end
    end

    return nil
end

function Ex.Function.KeepQuestAtFarmArea(Quest)
    if not Quest then
        return false
    end

    local QuestKey = Ex.Function.GetQuestKey(Quest)
    local Root = Ex.Function.GetRoot()
    local RememberedCFrame = Ex.Function.GetRememberedFarmCFrame(Quest)

    if RememberedCFrame and Root and (Root.Position - RememberedCFrame.Position).Magnitude > Ex.Config.AutoFarm.ReturnToLastFarmDistance then
        return Ex.Function.SmoothFarmMoveToCFrame(RememberedCFrame)
    end

    if Ex.Function.IsQuestFarmAreaLoaded(Quest) then
        return true
    end

    if not RememberedCFrame and Ex.Function.EnsureQuestIslandLoaded(Quest) then
        return true
    end

    Ex.State.MissingMobSince[QuestKey] = Ex.State.MissingMobSince[QuestKey] or os.clock()

    if os.clock() - Ex.State.MissingMobSince[QuestKey] >= Ex.Config.AutoFarm.MissingMobWaitBeforeProbe then
        Ex.State.MissingMobSince[QuestKey] = os.clock()
        return Ex.Function.ProbeQuestIsland(Quest, true)
    end

    return false
end

function Ex.Function.GetFarmOffset()
    local Distance = math.abs(Ex.Config.AutoFarm.Distance)

    if Ex.Config.AutoFarm.FarmMode == "Below" then
        return -Distance, 90
    end

    return Distance, -90
end

function Ex.Function.GetVectorAngleXZ(Offset)
    if math.abs(Offset.X) <= 0.001 then
        return Offset.Z >= 0 and math.pi / 2 or -math.pi / 2
    end

    local Angle = math.atan(Offset.Z / Offset.X)

    if Offset.X < 0 then
        Angle = Angle + math.pi
    end

    return Angle
end

function Ex.Function.UpdateFarmOrbitAngle(Mob, MobRoot)
    local Now = os.clock()
    local Config = Ex.Config.AutoFarm

    if Ex.State.OrbitMob ~= Mob then
        local Root = Ex.Function.GetRoot()
        local Offset = Root and MobRoot and (Root.Position - MobRoot.Position)
        local Angle = Ex.State.OrbitAngle or 0

        if Offset and Vector3.new(Offset.X, 0, Offset.Z).Magnitude > 0.5 then
            Angle = Ex.Function.GetVectorAngleXZ(Offset)
        end

        Ex.State.OrbitMob = Mob
        Ex.State.OrbitAngle = Angle
        Ex.State.OrbitLastAt = Now

        return Angle
    end

    local LastAt = Ex.State.OrbitLastAt or Now
    local Delta = math.clamp(Now - LastAt, 0, 0.25)

    Ex.State.OrbitLastAt = Now
    Ex.State.OrbitAngle = ((Ex.State.OrbitAngle or 0) + math.rad(Config.FarmOrbitSpeed) * Delta) % (math.pi * 2)

    return Ex.State.OrbitAngle
end

function Ex.Function.GetLookAtCFrame(Position, LookPosition)
    if not Position or not LookPosition or (Position - LookPosition).Magnitude <= 0.05 then
        return Position and CFrame.new(Position) or nil
    end

    return CFrame.new(Position, LookPosition)
end

function Ex.Function.GetLevelLookAtCFrame(Position, LookPosition)
    if not Position or not LookPosition then
        return Position and CFrame.new(Position) or nil
    end

    return Ex.Function.GetLookAtCFrame(Position, Vector3.new(LookPosition.X, Position.Y, LookPosition.Z))
end

function Ex.Function.GetFarmTargetCFrame(Mob)
    local MobRoot = Mob and Mob:FindFirstChild("HumanoidRootPart")

    if not MobRoot then
        return nil
    end

    local Config = Ex.Config.AutoFarm
    local Distance, Angle = Ex.Function.GetFarmOffset()

    if not Config.FarmOrbitEnabled then
        return MobRoot.CFrame * CFrame.new(0, Distance, 0) * CFrame.Angles(math.rad(Angle), 0, 0)
    end

    local OrbitAngle = Ex.Function.UpdateFarmOrbitAngle(Mob, MobRoot)
    local Radius = math.max(0, Config.FarmOrbitRadius)
    local Height = tonumber(Config.FarmOrbitHeight) or 0
    local Offset = Vector3.new(math.cos(OrbitAngle) * Radius, Height, math.sin(OrbitAngle) * Radius)
    local TargetPosition = MobRoot.Position + Offset
    local HitPosition = Ex.Function.GetHitPosition(Mob) or MobRoot.Position
    local TargetCFrame = Config.FarmOrbitFaceHit and Ex.Function.GetLevelLookAtCFrame(TargetPosition, HitPosition) or CFrame.new(TargetPosition)

    if Config.FarmOrbitUseFarmAngle then
        TargetCFrame = TargetCFrame * CFrame.Angles(math.rad(Angle), 0, 0)
    end

    return TargetCFrame
end

function Ex.Function.SetNoClip()
    if not Ex.Config.AutoFarm.NoClip then
        return
    end

    local Character = Ex.Function.GetCharacter()

    for _, Child in next, Character:GetChildren() do
        if Child:IsA("BasePart") then
            Child.CanCollide = false
        end
    end
end

function Ex.Function.MoveToMob(Mob, QuickStep)
    local Root = Ex.Function.GetRoot()
    local MobRoot = Mob and Mob:FindFirstChild("HumanoidRootPart")
    local Config = Ex.Config.AutoFarm

    if not Root or not MobRoot then
        return false
    end

    local TargetCFrame = Ex.Function.GetFarmTargetCFrame(Mob)

    if QuickStep and Config.FarmOrbitEnabled then
        local Distance = (Root.Position - TargetCFrame.Position).Magnitude

        if Distance <= Config.FarmOrbitStepMaxDistance then
            local Alpha = math.clamp(Config.FarmOrbitStepAlpha, 0.05, 1)

            Ex.Function.SetRootCFrame(Root, Root.CFrame:Lerp(TargetCFrame, Alpha))
        elseif not Ex.Function.SmoothFarmMoveToCFrame(TargetCFrame, true) then
            return false
        end
    elseif not Ex.Function.SmoothFarmMoveToCFrame(TargetCFrame, Config.FarmOrbitEnabled and Config.FarmOrbitTween) then
        return false
    end

    Ex.Function.SetFarmHoldState(Ex.Function.GetRoot())

    if Config.BringTarget then
        pcall(function()
            MobRoot.CanCollide = false
            MobRoot.AssemblyLinearVelocity = Vector3.zero
            MobRoot.AssemblyAngularVelocity = Vector3.zero
        end)
    end

    return true
end

function Ex.Function.GetSwordTool()
    local Character = Ex.Function.GetCharacter()
    local Backpack = Ex.Service.Player:FindFirstChild("Backpack")
    local Selected = nil
    local Preferred = Ex.Function.FindToolByName(Ex.Config.Startup.SwordName)

    if Preferred and Preferred:FindFirstChild("SwordServer") then
        return Preferred
    end

    for _, Tool in next, Character:GetChildren() do
        if Tool:IsA("Tool") and Tool:FindFirstChild("SwordServer") then
            return Tool
        end
    end

    if Backpack then
        for _, Tool in next, Backpack:GetChildren() do
            if Tool:IsA("Tool") and Tool:FindFirstChild("SwordServer") then
                Selected = Tool
                break
            end
        end
    end

    return Selected
end

function Ex.Function.EquipSword()
    local Tool = Ex.Function.GetSwordTool()
    local Humanoid = Ex.Function.GetHumanoid()
    local Character = Ex.Function.GetCharacter()

    if not Tool or not Humanoid then
        return nil
    end

    if Tool.Parent ~= Character then
        pcall(function()
            Humanoid:EquipTool(Tool)
        end)

        task.wait(0.1)
    end

    return Character:FindFirstChild(Tool.Name) or Tool
end

function Ex.Function.GetHitPosition(Mob)
    local CharacterRoot = Ex.Function.GetRoot()
    local BestPart = nil
    local BestDistance = math.huge

    for _, PartName in next, Ex.Config.HitParts do
        local Part = Mob:FindFirstChild(PartName)

        if Part and Part:IsA("BasePart") then
            local Distance = CharacterRoot and (CharacterRoot.Position - Part.Position).Magnitude or 0

            if Distance < BestDistance then
                BestDistance = Distance
                BestPart = Part
            end
        end
    end

    if BestPart then
        return BestPart.Position + Ex.Config.AutoFarm.HitOffset
    end

    local MobRoot = Mob:FindFirstChild("HumanoidRootPart")

    return MobRoot and MobRoot.Position or nil
end

function Ex.Function.AttackMob(Mob)
    local Tool = Ex.Function.EquipSword()

    if not Tool then
        return false
    end

    Ex.Function.UseBusoHaki()

    local SwordServer = Tool:FindFirstChild("SwordServer")
    local UpdateMousePosition = SwordServer and SwordServer:FindFirstChild("UpdateMousePosition")
    local RepeatCount = math.max(1, math.floor(Ex.Config.AutoFarm.AttackRepeat or 1))

    for Index = 1, RepeatCount do
        local HitPosition = Ex.Function.GetHitPosition(Mob)

        if UpdateMousePosition and HitPosition then
            pcall(function()
                UpdateMousePosition:FireServer(HitPosition)
            end)
        end

        pcall(function()
            Tool:Activate()
        end)

        if UpdateMousePosition and HitPosition then
            pcall(function()
                UpdateMousePosition:FireServer(HitPosition)
            end)
        end

        if Index < RepeatCount then
            task.wait(Ex.Config.AutoFarm.AttackRepeatDelay)
        end
    end

    return true
end

function Ex.Function.HoldOrbitOnMob(Mob, Quest, Duration)
    local Config = Ex.Config.AutoFarm
    local StartedAt = os.clock()
    local NextAttackAt = 0

    Duration = Duration or Config.FarmOrbitHoldTime

    repeat
        Ex.Service.Shared.__HazeSeasAutoFarmHeartbeat = os.clock()

        if not Ex.Function.IsAliveAnyMob(Mob) then
            Ex.Function.StartRespawnWait(Quest, Mob)
            return false
        end

        Ex.Function.SetNoClip()
        if Quest and Config.RefreshQuestLockWhileFarming then
            Ex.Function.SetQuestLock(Quest)
        end

        Ex.Function.MoveToMob(Mob, true)
        Ex.Function.RememberFarmHoldPoint(Quest)

        if os.clock() >= NextAttackAt then
            Ex.Function.AttackMob(Mob)
            NextAttackAt = os.clock() + Config.AttackDelay
        end

        task.wait(Config.FarmOrbitStepDelay)
    until os.clock() - StartedAt >= Duration

    if not Ex.Function.IsAliveAnyMob(Mob) then
        Ex.Function.StartRespawnWait(Quest, Mob)
        return false
    end

    return true
end

function Ex.Function.RedeemCodes()
    if Ex.State.StartupCodesDone then
        return true
    end

    local ClaimCode = Ex.Function.GetClientEvent("ClaimCode")

    if not ClaimCode then
        return false
    end

    for _, Code in next, Ex.Config.Startup.Codes do
        if not Ex.State.CodeResults[Code] then
            local Success, ResponseText, Rewards = pcall(function()
                return ClaimCode:InvokeServer(Code)
            end)

            if not Success then
                return false
            end

            Ex.State.CodeResults[Code] = {
                Text = tostring(ResponseText or ""),
                Rewards = Rewards,
                Success = Rewards ~= nil,
            }

            task.wait(Ex.Config.Startup.RedeemDelay)
        end
    end

    Ex.State.StartupCodesDone = true
    return true
end

function Ex.Function.BuyConfiguredSword()
    if Ex.State.StartupSwordDone then
        return true
    end

    if Ex.Function.HasOwnedSword(Ex.Config.Startup.SwordName) then
        Ex.Function.WaitForSwordTool(Ex.Config.Startup.SwordName, 1)
        Ex.Function.EquipSword()
        Ex.State.StartupSwordDone = true
        return true
    end

    local Seller = Ex.Function.GetSwordSellerModel()
    local BuySword = Ex.Function.GetClientEvent("BuySword")

    if not Seller or not BuySword then
        return false
    end

    Ex.Function.TeleportToCFrame(Ex.Function.GetSwordSellerCFrame())
    task.wait(Ex.Config.Startup.BuyDelay)

    local Success = pcall(function()
        BuySword:InvokeServer(Seller)
    end)

    if not Success then
        return false
    end

    task.wait(Ex.Config.Startup.BuyDelay)

    if Ex.Function.HasOwnedSword(Ex.Config.Startup.SwordName) or Ex.Function.WaitForSwordTool(Ex.Config.Startup.SwordName, Ex.Config.Startup.WaitToolTimeout) then
        Ex.Function.EquipSword()
        Ex.State.StartupSwordDone = true
        return true
    end

    return false
end

function Ex.Function.BuildStatSpendPlan()
    local Array = {}
    local Points = Ex.Function.GetPointValue()
    local Ratio = Ex.Config.Startup.StatRatio
    local RatioTotal = (tonumber(Ratio.Sword) or 0) + (tonumber(Ratio.Defense) or 0)

    if Points <= 0 then
        return Array
    end

    if RatioTotal <= 0 then
        Ratio.Sword = 70
        Ratio.Defense = 30
        RatioTotal = 100
    end

    local Current = {
        Sword = Ex.Function.GetStatValue("Sword"),
        Defense = Ex.Function.GetStatValue("Defense"),
    }
    local Limits = {
        Sword = math.max(Ex.Config.Startup.StatMax - Current.Sword, 0),
        Defense = math.max(Ex.Config.Startup.StatMax - Current.Defense, 0),
    }
    local Spend = {
        Sword = 0,
        Defense = 0,
    }
    local DesiredSword = math.floor((((Current.Sword + Current.Defense) + Points) * ((tonumber(Ratio.Sword) or 0) / RatioTotal)) + 0.5)

    Spend.Sword = math.clamp(DesiredSword - Current.Sword, 0, math.min(Points, Limits.Sword))
    Spend.Defense = math.min(Points - Spend.Sword, Limits.Defense)

    local Left = Points - Spend.Sword - Spend.Defense

    if Left > 0 then
        local AddSword = math.min(Left, math.max(Limits.Sword - Spend.Sword, 0))

        Spend.Sword = Spend.Sword + AddSword
        Left = Left - AddSword
    end

    if Left > 0 then
        local AddDefense = math.min(Left, math.max(Limits.Defense - Spend.Defense, 0))

        Spend.Defense = Spend.Defense + AddDefense
    end

    if Spend.Sword > 0 then
        table.insert(Array, {
            Name = "Sword",
            Amount = Spend.Sword,
        })
    end

    if Spend.Defense > 0 then
        table.insert(Array, {
            Name = "Defense",
            Amount = Spend.Defense,
        })
    end

    return Array
end

function Ex.Function.SpendStatPoints()
    local StatsEvent = Ex.Function.GetClientEvent("Stats_Event")
    local Plan = Ex.Function.BuildStatSpendPlan()

    if not StatsEvent or #Plan == 0 then
        return false
    end

    for _, Entry in next, Plan do
        local Remaining = Entry.Amount

        while Remaining > 0 and game.PlaceId == Ex.Config.PlaceId.Target do
            local Chunk = math.min(Remaining, Ex.Config.Startup.StatChunk, Ex.Function.GetPointValue())

            if Chunk <= 0 then
                break
            end

            pcall(function()
                StatsEvent:FireServer(Entry.Name, Chunk)
            end)

            Remaining = Remaining - Chunk
            task.wait(Ex.Config.Startup.StatDelay)
        end
    end

    return true
end

function Ex.Function.AutoUpgradeStats()
    if Ex.Service.Shared.__HazeSeasAutoStatRunning or not Ex.Config.Startup.AutoStats then
        return
    end

    Ex.Service.Shared.__HazeSeasAutoStatRunning = true

    while game.PlaceId == Ex.Config.PlaceId.Target and Ex.Config.Startup.AutoStats do
        if Ex.Function.GetPointValue() > 0 then
            Ex.Function.SpendStatPoints()
        end

        task.wait(Ex.Config.Startup.StatLoopDelay)
    end

    Ex.Service.Shared.__HazeSeasAutoStatRunning = nil
end

function Ex.Function.ResolveFarmQuest()
    local LockedFarmQuest = Ex.Function.GetLockedFarmQuest()

    if LockedFarmQuest then
        return LockedFarmQuest
    end

    local WantedQuest = Ex.Function.GetQuestForLevel(Ex.Function.GetPlayerLevel())
    local ActiveQuest = Ex.Function.GetActiveQuestData()

    if Ex.Config.AutoFarm.KeepCurrentQuestUntilDone and Ex.Function.HasQuest() and ActiveQuest then
        Ex.Function.MarkFarmQuest(ActiveQuest)
        Ex.Function.SetQuestLock(ActiveQuest)
        Ex.Function.ClearPendingQuest(ActiveQuest)
        return ActiveQuest
    end

    if Ex.Function.IsQuestMatch(WantedQuest) then
        Ex.Function.MarkFarmQuest(WantedQuest)
        Ex.Function.SetQuestLock(WantedQuest)
        Ex.Function.ClearPendingQuest(WantedQuest)
        return WantedQuest
    end

    if Ex.Function.IsPendingQuest(WantedQuest) then
        Ex.Function.MarkFarmQuest(WantedQuest)
        return WantedQuest
    end

    local LockedQuest = Ex.Function.GetQuestLock()

    if LockedQuest and not Ex.Function.HasQuest() then
        Ex.Function.MarkFarmQuest(LockedQuest)
        return LockedQuest
    end

    if not Ex.Function.HasQuest() then
        Ex.Function.AcceptQuest(WantedQuest)
        return WantedQuest
    end

    if LockedQuest and Ex.Config.AutoFarm.NoReturnAfterQuest then
        Ex.Function.MarkFarmQuest(LockedQuest)
        return LockedQuest
    end

    Ex.Function.CancelWrongQuest()

    if not Ex.Function.HasQuest() then
        Ex.Function.AcceptQuest(WantedQuest)
        return WantedQuest
    end

    if Ex.Config.AutoFarm.FarmWrongQuestFallback then
        return Ex.Function.GetActiveQuestData() or LockedQuest or WantedQuest
    end

    return WantedQuest
end

function Ex.Function.AutoFarmLevel()
    if Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning then
        return
    end

    Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning = true
    Ex.Service.Shared.__HazeSeasAutoFarmHeartbeat = os.clock()
    task.wait(Ex.Config.AutoFarm.StartDelay)

    while Ex.Config.AutoFarm.Enabled and game.PlaceId == Ex.Config.PlaceId.Target do
        Ex.Service.Shared.__HazeSeasAutoFarmHeartbeat = os.clock()

        local Success, ErrorMessage = pcall(function()
            if Ex.Function.ShouldBuyBusoHaki() then
                Ex.State.SkipAutoFarmSearchWait = true
                Ex.Function.BuyBusoHaki()
                return
            end

            local Quest, Mob = Ex.Function.GetLockedFarmQuest()
            local WaitingForRespawn = false
            local RespawnQuest = Ex.Function.GetRespawnWaitQuest()

            if not Mob and RespawnQuest then
                Mob, WaitingForRespawn = Ex.Function.HandleRespawnWait(RespawnQuest)

                if Mob or WaitingForRespawn then
                    Quest = RespawnQuest
                end
            end

            if WaitingForRespawn then
                Ex.State.SkipAutoFarmSearchWait = true
                return
            end

            if not Quest then
                Quest = Ex.Function.ResolveFarmQuest()
            end

            if Quest and not Ex.Function.EnsureQuestReadyToFarm(Quest) then
                Ex.Function.ClearLockedMob(Quest)
                Ex.State.SkipAutoFarmSearchWait = true
                return
            end

            if Quest and not Mob then
                Mob, WaitingForRespawn = Ex.Function.HandleRespawnWait(Quest)
            end

            if WaitingForRespawn then
                Ex.State.SkipAutoFarmSearchWait = true
                return
            end

            if Quest and not Mob then
                Mob = Ex.Function.GetLockedMob(Quest)
            end

            if Quest and not Mob and Ex.Function.IsRespawnWaitActive(Quest) then
                Ex.Function.HoldRespawnWaitPosition(Quest)
                Ex.State.SkipAutoFarmSearchWait = true
                return
            end

            if Quest and not Mob then
                Mob = Ex.Function.FindMob(Quest)
            end

            if Quest and not Mob and Ex.Function.CanUseFallbackMob(Quest) then
                Mob = Ex.Function.FindIslandFallbackMob(Quest)
            end

            Ex.Function.SetNoClip()

            if Mob then
                local QuestKey = Ex.Function.GetQuestKey(Quest)

                Ex.State.MissingMobSince[QuestKey] = nil
                Ex.Function.MarkFarmQuest(Quest)
                if Ex.Config.AutoFarm.RefreshQuestLockWhileFarming then
                    Ex.Function.SetQuestLock(Quest)
                end

                Ex.Function.SetLockedMob(Quest, Mob)
                Ex.Function.RememberFarmPoint(Quest, Mob)

                if Ex.Config.AutoFarm.FarmOrbitEnabled and Ex.Config.AutoFarm.FarmOrbitContinuous then
                    Ex.State.SkipAutoFarmSearchWait = true
                    Ex.Function.HoldOrbitOnMob(Mob, Quest, Ex.Config.AutoFarm.FarmOrbitHoldTime)
                else
                    Ex.Function.MoveToMob(Mob)
                    Ex.Function.RememberFarmHoldPoint(Quest)
                    Ex.Function.AttackMob(Mob)
                    if not Ex.Function.IsAliveAnyMob(Mob) then
                        Ex.Function.StartRespawnWait(Quest, Mob)
                    end
                    task.wait(Ex.Config.AutoFarm.AttackDelay)
                end
            else
                Ex.Function.ClearLockedMob(Quest)

                if Quest then
                    local QuestActive = Ex.Function.HasQuest() or Ex.Function.IsPendingQuest(Quest) or Ex.Function.IsQuestLocked(Quest)

                    if QuestActive and Ex.Config.AutoFarm.NoReturnAfterQuest then
                        Ex.Function.KeepQuestAtFarmArea(Quest)
                    elseif not (QuestActive and Ex.Function.IsQuestFarmAreaLoaded(Quest)) then
                        Ex.Function.TeleportToQuestArea(Quest, not QuestActive and not Ex.Config.AutoFarm.QuestRemoteOnly)
                    end
                end

                task.wait(Ex.Config.AutoFarm.MissingMobTeleportDelay)
            end
        end)

        if not Success then
            Ex.State.LastAutoFarmError = tostring(ErrorMessage)

            pcall(function()
                warn("[HazeSeas] AutoFarmLevel error:", ErrorMessage)
            end)

            task.wait(Ex.Config.AutoFarm.ErrorDelay)
        end

        if Ex.State.SkipAutoFarmSearchWait then
            Ex.State.SkipAutoFarmSearchWait = nil
        else
            task.wait(Ex.Config.AutoFarm.SearchMobDelay)
        end
    end

    Ex.Function.SetTransportState(Ex.Function.GetRoot(), false)
    Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning = nil
end

function Ex.Function.KeepAutoFarmLevelRunning()
    if Ex.Service.Shared.__HazeSeasAutoFarmKeeperRunning then
        return
    end

    Ex.Service.Shared.__HazeSeasAutoFarmKeeperRunning = true

    while Ex.Config.AutoFarm.Enabled and game.PlaceId == Ex.Config.PlaceId.Target do
        local Heartbeat = tonumber(Ex.Service.Shared.__HazeSeasAutoFarmHeartbeat) or 0

        if not Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning or os.clock() - Heartbeat >= Ex.Config.AutoFarm.StaleHeartbeatTime then
            Ex.Service.Shared.__HazeSeasAutoFarmLevelRunning = nil
            task.spawn(Ex.Function.AutoFarmLevel)
        end

        task.wait(Ex.Config.AutoFarm.WatchdogDelay)
    end

    Ex.Service.Shared.__HazeSeasAutoFarmKeeperRunning = nil
end

function Ex.Function.RunStartupFlow()
    if Ex.State.StartupDone then
        task.spawn(Ex.Function.KeepDescriptionUpdated)
        task.spawn(Ex.Function.AutoUpgradeStats)
        task.spawn(Ex.Function.KeepAutoFarmLevelRunning)
        return true
    end

    if not Ex.Config.Startup.Enabled then
        Ex.State.StartupDone = true
        task.spawn(Ex.Function.KeepDescriptionUpdated)
        task.spawn(Ex.Function.KeepAutoFarmLevelRunning)
        return true
    end

    if not Ex.Function.WaitForCharacter(Ex.Config.Startup.WaitCharacterTimeout) then
        return false
    end

    if not Ex.State.StartupCodesDone and not Ex.Function.RedeemCodes() then
        return false
    end

    if not Ex.State.StartupSwordDone and not Ex.Function.BuyConfiguredSword() then
        if not Ex.Function.WaitForSwordTool(Ex.Config.Startup.SwordName, 1) and not Ex.Function.GetSwordTool() then
            return false
        end
    end

    if Ex.Function.ShouldBuyBusoHaki() then
        Ex.Function.BuyBusoHaki()
    end

    Ex.Function.EquipSword()
    Ex.Function.UseBusoHaki(true)
    Ex.Function.SpendStatPoints()

    Ex.State.StartupDone = true

    task.spawn(Ex.Function.KeepDescriptionUpdated)
    task.spawn(Ex.Function.AutoUpgradeStats)
    task.spawn(Ex.Function.KeepAutoFarmLevelRunning)

    return true
end

function Ex.Function.StartTargetFlow()
    if Ex.Service.Shared.__HazeSeasTargetRunnerRunning then
        return
    end

    Ex.Service.Shared.__HazeSeasTargetRunnerRunning = true
    task.spawn(Ex.Function.KeepDescriptionUpdated)
    task.spawn(Ex.Function.ClickPlayWhenReady)

    while game.PlaceId == Ex.Config.PlaceId.Target do
        if Ex.Function.RunStartupFlow() then
            break
        end

        task.wait(Ex.Config.Startup.RetryDelay)
    end

    Ex.Service.Shared.__HazeSeasTargetRunnerRunning = nil
end

function Ex.Function.GetQueueOnTeleport()
    if type(queue_on_teleport) == "function" then
        return queue_on_teleport
    end

    if type(queueonteleport) == "function" then
        return queueonteleport
    end

    if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
        return syn.queue_on_teleport
    end

    if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
        return fluxus.queue_on_teleport
    end

    return nil
end

function Ex.Function.QueueTargetRunner()
    if Ex.State.Queued then
        return true
    end

    local Queue = Ex.Function.GetQueueOnTeleport()

    if not Queue then
        return false
    end

    local Success = pcall(function()
        Queue(Ex.QueueCode)
    end)

    if Success then
        Ex.State.Queued = true
    end

    return Success
end

function Ex.Function.TeleportToTarget()
    Ex.Function.QueueTargetRunner()

    pcall(function()
        Ex.Service.TeleportService:Teleport(Ex.Config.PlaceId.Target, Ex.Service.Player)
    end)
end

task.spawn(function()
    Ex.State.LastTeleportAt = 0

    while true do
        if game.PlaceId == Ex.Config.PlaceId.Target then
            Ex.Function.StartTargetFlow()
            break
        end

        if game.PlaceId ~= Ex.Config.PlaceId.Source then
            break
        end

        if os.clock() - Ex.State.LastTeleportAt >= Ex.Config.Delay.RetryTeleport then
            Ex.State.LastTeleportAt = os.clock()
            Ex.Function.TeleportToTarget()
        end

        task.wait(Ex.Config.Delay.CheckPlace)
    end

    Ex.Service.Shared.__HazeSeasPlaceGuardRunning = nil
end)
