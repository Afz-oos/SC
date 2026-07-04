repeat task.wait() until game:IsLoaded()
task.wait(10)

-- ══════════════════════════════════════════════
--               CONFIG
-- ══════════════════════════════════════════════
if not getgenv().Config then
    getgenv().Config = {
        AutoChest = false,
        AutoBattle = false,
        AutoRandomSuit = false, -- ปรับเป็น true เพื่อใช้งาน (จะรอให้ AutoChest เก็บกล่องเสร็จก่อนค่อยเริ่มสุ่ม)
        AutoQuest = true, -- ระบบ Auto Quest (ทำเควสอัตโนมัติ)
        MaxFarmLevel = 20, -- เลเวลสูงสุดที่จะฟาร์ม (ถ้าระบบอ่านจาก UI ไม่เจอจะใช้ค่านี้)
    }
end
local Config = getgenv().Config

-- ══════════════════════════════════════════════
--               SERVICES & VARS
-- ══════════════════════════════════════════════
local Players             = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local TeleportService     = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Remote              = ReplicatedStorage.Remote

local LocalPlayer = Players.LocalPlayer
local UserId      = LocalPlayer.UserId

-- ══════════════════════════════════════════════
--           TUTORIAL AUTO-CHECK & SKIP
-- ══════════════════════════════════════════════
local TUTORIAL_POS = Vector3.new(6162.71240234375, -3.5336031913757324, -1645.9775390625)
local CHECK_RADIUS = 1500

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local rootPart  = character:WaitForChild("HumanoidRootPart")

local inTutorial = (rootPart.Position - TUTORIAL_POS).Magnitude <= CHECK_RADIUS

if inTutorial then
    -- ยังอยู่ใน Tutorial → skip แล้ว rejoin
    Remote.Dialogue.ResDialogueEnded:InvokeServer(1, 4, true)  task.wait(0.5)
    Remote.Dialogue.ResDialogueEnded:InvokeServer(1, 4, true)  task.wait(0.5)
    Remote.Guider.ReqClaimNewbiePet:InvokeServer(2)             task.wait(0.5)
    Remote.Pet.ReqGetPlayerMainPet:InvokeServer(UserId)         task.wait(0.5)
    Remote.Guider.ReqUpdateGuiderStep:InvokeServer(6)           task.wait(0.5)
    Remote.Guider.ReqUpdateGuiderStep:InvokeServer(9)           task.wait(0.5)

    pcall(function()
        local queue = (syn and syn.queue_on_teleport)
                   or (fluxus and fluxus.queue_on_teleport)
                   or (typeof(queue_on_teleport) == "function" and queue_on_teleport)
                   or nil
        if queue then
            queue([[
                repeat task.wait() until game:IsLoaded()
                local lp = game:GetService("Players").LocalPlayer
                if not lp.Character then lp.CharacterAdded:Wait() end
                repeat task.wait(0.2) until lp.Character:FindFirstChild("HumanoidRootPart")
                task.wait(12)
                local root = lp.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local ts = game:GetService("TweenService")
                    local tw = ts:Create(root,
                        TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        { CFrame = CFrame.new(6164.43262, 0.265996933, -1714.05029, 1,0,0, 0,1,0, 0,0,1) }
                    )
                    tw:Play()
                    tw.Completed:Wait()
                end
            ]])
        end
        if #Players:GetPlayers() > 1 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
    return -- หยุด รอ rejoin
end

-- ══════════════════════════════════════════════
-- ข้าม Tutorial แล้ว → เริ่มรัน Features
-- ══════════════════════════════════════════════
getgenv().TutorialDone = true

-- ══════════════════════════════════════════════
--              FEATURE: AUTO CHEST
-- ══════════════════════════════════════════════
local AutoChest, AutoRandomSuit, AutoQuest -- Forward Declarations

AutoChest = function()
    local chestFolder = workspace:FindFirstChild("RuntimeCache")
        and workspace.RuntimeCache:FindFirstChild("RuntimeCacheClient")
        and workspace.RuntimeCache.RuntimeCacheClient:FindFirstChild("Chest")

    if not chestFolder then return end

    while Config.AutoChest do
        local chests = chestFolder:GetChildren()

        if #chests == 0 then
            Config.AutoChest = false
            break
        end

        local openedCount = 0

        for _, chest in ipairs(chests) do
            if not Config.AutoChest then break end
            if not chest:FindFirstChild("lockParticleClone") then
                openedCount = openedCount + 1
                pcall(function()
                    Remote.Chest.ReqClaimExploreReward:InvokeServer(chest.Name)
                end)
            end
            task.wait(0.5)
        end

        if openedCount == 0 or #chestFolder:GetChildren() == 0 then
            Config.AutoChest = false
            break
        end

        task.wait(3)
    end
end
-- ══════════════════════════════════════════════
--              FEATURE: AUTO SEND DESCRIPTION
-- ══════════════════════════════════════════════
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/latavee1399-dev/AKO/refs/heads/main/log%20EVOMON.lua"))()
    end)
end)

-- ══════════════════════════════════════════════
--              FEATURE: AUTO RANDOM SUIT
-- ══════════════════════════════════════════════
AutoRandomSuit = function()
    warn("[AutoRandomSuit] ═══ เริ่มระบบ AutoRandomSuit ═══")
    local targetPlaceId = 113840348235813
    
    while Config.AutoRandomSuit do
        -- 1. บังคับให้เก็บกล่องจนหมดแมพก่อนวาร์ป (แม้จะไม่ได้เปิด AutoChest ไว้ใน Config)
        local chestFolder = workspace:FindFirstChild("RuntimeCache")
            and workspace.RuntimeCache:FindFirstChild("RuntimeCacheClient")
            and workspace.RuntimeCache.RuntimeCacheClient:FindFirstChild("Chest")
        
        local validChests = 0
        if chestFolder then
            for _, c in ipairs(chestFolder:GetChildren()) do
                if not c:FindFirstChild("lockParticleClone") then
                    validChests = validChests + 1
                end
            end
        end
        
        if validChests > 0 then
            if not Config.AutoChest then
                warn("[AutoRandomSuit] ⚠️ ยังมีกล่องในแมพ! สั่งเปิด AutoChest อัตโนมัติ...")
                Config.AutoChest = true
                task.spawn(AutoChest)
            end
            task.wait(2)
        elseif Config.AutoChest then
            -- กรณีที่ AutoChest ทำงานอยู่ ให้รอจนกว่าจะเสร็จ (มันจะเปลี่ยนเป็น false เองเมื่อหมดกล่อง)
            task.wait(2)
        elseif not getgenv().TutorialDone then
            task.wait(1)
        else
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not rootPart then
                task.wait(1)
            else

        -- 2. เช็คว่าสุ่มได้ชุด Mythic / Eternal หรือยัง
        local stopSpinning = false
        pcall(function()
            local gui = LocalPlayer.PlayerGui
            local profWindow = gui:FindFirstChild("ProfessionWindow", true)
            if profWindow then
                for _, v in ipairs(profWindow:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Visible then
                        local txt = v.Text:lower()
                        -- เช็คคำว่า mythic/eternal แต่ต้องไม่มีเครื่องหมาย % (เพื่อหลีกเลี่ยงตารางโอกาสสุ่ม)
                        if (txt:match("mythic") or txt:match("eternal")) and not txt:match("%%") then
                            warn("[AutoRandomSuit] 🎉 ยินดีด้วย! คุณสุ่มได้ชุดระดับเทพ (" .. v.Text .. ") แล้ว! บอทจะหยุดสุ่มทันที")
                            stopSpinning = true
                            break
                        end
                    end
                end
            end
        end)

        if stopSpinning then return end -- ข้ามการสุ่มถัดไปถ้าได้แล้ว

        -- 3. ยิง Remote สุ่มชุดตรงๆ (ไม่ต้องพึ่ง NPC Debby หรือเปิด UI)
        pcall(function()
            local buyRecordRemote = ReplicatedStorage:FindFirstChild("Remote") 
                and ReplicatedStorage.Remote:FindFirstChild("Shop")
                and ReplicatedStorage.Remote.Shop:FindFirstChild("ReqGetPlayerBuyRecord")
            
            if buyRecordRemote then
                buyRecordRemote:InvokeServer(LocalPlayer)
            end

            local suitRemote = ReplicatedStorage:FindFirstChild("Remote") 
                and ReplicatedStorage.Remote:FindFirstChild("Profession")
                and ReplicatedStorage.Remote.Profession:FindFirstChild("ReqDrawProfession")
            
            if suitRemote then
                local s, res = pcall(function() return suitRemote:InvokeServer(1, 1) end)
                if s then
                    -- แกะกล่องข้อมูลดิบจากเซิร์ฟเวอร์โดยตรง (แม่นยำ 100% ไม่ต้องง้อ UI!)
                    local jsonStr = ""
                    pcall(function() jsonStr = game:GetService("HttpService"):JSONEncode(res) end)
                    local lowerStr = jsonStr:lower()

                    -- แปลงและอัพเดทค่า LastSuit ทันที
                    if lowerStr:match("eternal") then _G.LastSuit = "Eternal"
                    elseif lowerStr:match("mythic") then _G.LastSuit = "Mythic"
                    elseif lowerStr:match("legendary") then _G.LastSuit = "Legendary"
                    elseif lowerStr:match("epic") or lowerStr:match("master") or lowerStr:match("expert") then _G.LastSuit = "Epic"
                    elseif lowerStr:match("rare") or lowerStr:match("novice") then _G.LastSuit = "Rare"
                    end

                    warn("[AutoRandomSuit] 🎲 สุ่มสำเร็จ! ดึงข้อมูลได้ระดับ: " .. tostring(_G.LastSuit))

                    -- เช็คว่าถึงเป้าหมายหรือยัง
                    if lowerStr:match("mythic") or lowerStr:match("eternal") then
                        warn("[AutoRandomSuit] 🎉 ยินดีด้วย! คุณสุ่มได้ชุดระดับ " .. _G.LastSuit .. " แล้ว! บอทจะหยุดสุ่มทันที")
                        Config.AutoRandomSuit = false
                        stopSpinning = true
                    end
                else
                    warn("[AutoRandomSuit] ⚠️ สุ่มไม่สำเร็จ (เงินอาจจะไม่พอ หรือติด Cooldown): " .. tostring(res))
                end
            else
                warn("[AutoRandomSuit] ❌ ไม่พบ Remote สำหรับสุ่มชุด!")
            end
        end)
        
        if stopSpinning then
            Config.AutoRandomSuit = false
            break
        end

        task.wait(1.5)
        end -- ปิด else ของ rootPart
        end -- ปิด if validChests > 0
    end -- ปิด while
end -- ปิด function

-- ══════════════════════════════════════════════
--              FEATURE: AUTO BATTLE
-- ══════════════════════════════════════════════

-- ดึงข้อมูลเลเวลสัตว์เลี้ยงของเรา จาก Creature System ของเกมโดยตรง
local function GetPlayerPetLevel()
    local level = Config.MaxFarmLevel or 20
    pcall(function()
        local allCreatures = Remote.Creature.ReqGetAllCreatures:InvokeServer()
        local myId = UserId
        -- หาสัตว์เลี้ยงที่เป็นของเรา (type 4 = pet ของผู้เล่น, type 2 = pet follow)
        local highestLevel = 0
        for _, c in pairs(allCreatures) do
            if type(c) == "table" and (c.type == 4 or c.type == 2) and c.master == myId then
                if c.level and c.level > highestLevel then
                    highestLevel = c.level
                end
            end
        end
        -- ถ้าหาจาก creature ไม่เจอ ลองหาจาก model ใน workspace
        if highestLevel == 0 then
            for _, pet in ipairs(workspace:GetDescendants()) do
                if pet:IsA("Model") and pet.Name:match("Pet") then
                    if pet:GetAttribute("Owner") == myId or pet:GetAttribute("OwnerId") == myId then
                        local lvl = pet:GetAttribute("Level") or pet:GetAttribute("Lv")
                        if lvl and tonumber(lvl) > highestLevel then
                            highestLevel = tonumber(lvl)
                        end
                    end
                end
            end
        end
        if highestLevel > 0 then
            level = highestLevel
        end
    end)
    return level
end

-- หามอนสเตอร์ป่าที่เหมาะสม สแกนทั้งแมพ!
-- เป้าหมาย: มอนสเตอร์เลเวลเท่ากับ หรือสูงกว่าสัตว์เลี้ยงเราไม่เกิน 2 เลเวล
-- ถ้าโซนนี้ไม่มี → วาร์ปข้ามเกาะไปหาเลย!
-- คืนค่า {uid, level, dist, pos} หรือ nil
local function GetTargetMonster()
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end

    local myPetLevel = GetPlayerPetLevel()
    warn("[AutoBattle] เลเวลสัตว์เลี้ยง: " .. tostring(myPetLevel))
    
    -- ดึงข้อมูลมอนสเตอร์ทั้งหมดจากเซิร์ฟเวอร์ (ทั้งแมพ!)
    local allCreatures = nil
    pcall(function()
        allCreatures = Remote.Creature.ReqGetAllCreatures:InvokeServer()
    end)
    if not allCreatures then 
        warn("[AutoBattle] ดึงข้อมูล Creature ไม่ได้!")
        return nil 
    end

    -- ═══ เป้าหมายหลัก: มอนสเตอร์เลเวลเท่ากับ หรือสูงกว่าเราไม่เกิน 2 ═══
    local minLevel = myPetLevel        -- เลเวลเท่ากับเรา
    local maxLevel = myPetLevel + 2    -- สูงกว่าเราไม่เกิน 2

    local bestTarget = nil      -- มอนสเตอร์ในช่วงเลเวลที่ดีที่สุด (ใกล้ที่สุด)
    local closestDist = math.huge
    
    -- ═══ สำรอง: ถ้าไม่เจอตรงช่วง → เอาตัวที่เลเวลใกล้เคียงกับเรามากที่สุด ═══
    local nearestLevelTarget = nil
    local nearestLevelDiff = math.huge
    
    for _, c in pairs(allCreatures) do
        if type(c) == "table" 
            and c.type == 3          -- type 3 = มอนสเตอร์ป่า
            and c.aliveState == 1    -- ยังมีชีวิตอยู่
            and not c.isCombating    -- ไม่ได้กำลังสู้กับคนอื่น
            and c.level              -- มีข้อมูลเลเวล
        then
            -- หาตำแหน่งของมอนสเตอร์
            local pos = nil
            if c.pos then
                pos = c.pos.Position
            elseif c.entity then
                local model = c.entity:FindFirstChildOfClass("Model")
                if model then
                    local pRoot = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart
                    if pRoot then
                        pos = pRoot.Position
                    end
                end
            end
            
            if pos then
                local dist = (rootPart.Position - pos).Magnitude
                
                -- เช็คว่ามอนสเตอร์อยู่ในช่วงเลเวลที่ต้องการหรือไม่
                if c.level >= minLevel and c.level <= maxLevel then
                    if dist < closestDist then
                        closestDist = dist
                        bestTarget = {
                            uid = c.uid,
                            level = c.level,
                            dist = dist,
                            pos = pos,
                        }
                    end
                end
                
                -- Fallback: เก็บตัวที่เลเวลใกล้เคียงกับเรามากที่สุด (ห้ามเกิน petLevel+5 เด็ดขาด)
                local levelDiff = math.abs(c.level - myPetLevel)
                if c.level <= myPetLevel + 5 and levelDiff < nearestLevelDiff then
                    nearestLevelDiff = levelDiff
                    nearestLevelTarget = {
                        uid = c.uid,
                        level = c.level,
                        dist = dist,
                        pos = pos,
                    }
                end
            end
        end
    end
    
    if bestTarget then
        warn("[AutoBattle] ล็อคเป้า: UID=" .. bestTarget.uid .. " Lv." .. bestTarget.level .. " ระยะ=" .. math.floor(bestTarget.dist) .. " (ฟาร์มได้ EXP!)")
        return bestTarget
    elseif nearestLevelTarget then
        warn("[AutoBattle] ไม่เจอเลเวล " .. minLevel .. "-" .. maxLevel .. " → ใช้ตัวเลเวลใกล้เคียง: Lv." .. nearestLevelTarget.level)
        return nearestLevelTarget
    end
    
    warn("[AutoBattle] ไม่เจอมอนสเตอร์เลย!")
    return nil
end

local function AutoBattle()
    local wasInBattle = false
    warn("[AutoBattle] ═══ เริ่มระบบ AutoBattle ═══")
    
    while Config.AutoBattle do
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if not character or not rootPart then
            task.wait(1)
        else
        
        -- ═══ เช็คว่าอยู่ในฉากต่อสู้หรือไม่ ═══
        local inBattle = false
        pcall(function()
            local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
            if battleUI and battleUI.Enabled then
                inBattle = true
            end
        end)
        
        if inBattle then
            wasInBattle = true
            
            -- ═══ ตรวจสอบเลเวลผู้เล่น (เพื่อเลือกระบบโจมตี) ═══
            local isAutoLocked = false
            pcall(function()
                -- ดึงเลเวลตัวละครผู้เล่นจาก UI
                local playerLvl = 0
                local mainWindow = LocalPlayer.PlayerGui:FindFirstChild("MainWindow", true)
                local playerBtn = mainWindow and mainWindow:FindFirstChild("PlayerBtn", true)
                local levelText = playerBtn and playerBtn:FindFirstChild("LevelText", true)
                if levelText then
                    playerLvl = tonumber(levelText.Text:match("%d+")) or 0
                end
                
                -- ตรวจสอบ UI ปุ่ม Auto ว่าล็อคอยู่หรือไม่
                local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
                local autoBtn = battleUI and battleUI:FindFirstChild("AutoButton", true)
                local lockIcon = autoBtn and autoBtn:FindFirstChild("Lock", true)
                
                if lockIcon and lockIcon.Visible then
                    isAutoLocked = true
                elseif playerLvl > 0 and playerLvl < 10 then
                    isAutoLocked = true
                end
                
                -- ถ้าเลเวล 10 ขึ้นไป และปลดล็อคแล้ว → เปิดระบบ Auto 
                if not isAutoLocked and autoBtn then
                    local promptImg = autoBtn:FindFirstChild("AutoPromptImg", true)
                    if promptImg and promptImg.Visible then
                        warn("[AutoBattle] ⚙️ เลเวล " .. (playerLvl > 0 and tostring(playerLvl) or "10+") .. " ตรวจพบว่า Auto ปิดอยู่ กำลังเปิดให้...")
                        Remote.Battle.ReqAutoBattle:InvokeServer(true)
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
                        task.wait(0.1)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
                        task.wait(0.5)
                    end
                end
            end)
            
            -- ═══ ระบบสลับมอนสเตอร์อัตโนมัติ (เมื่อตัวตาย) ═══
            pcall(function()
                local petWindowCtrl = require(game:GetService("ReplicatedStorage").Controller.BattlePetWindowController)
                local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
                local hpTextLabel = battleUI and battleUI:FindFirstChild("SelfHpText", true)
                
                -- เช็คว่าเกมบังคับให้สลับตัว (isForceOpen) หรือ เลือดปัจจุบันเป็น 0
                local needSwitch = false
                if petWindowCtrl and petWindowCtrl.isForceOpen and petWindowCtrl:isForceOpen() then
                    needSwitch = true
                elseif hpTextLabel and hpTextLabel.Text:match("^0%s*/") then
                    needSwitch = true
                end
                
                if needSwitch then
                    local multiPetsUI = LocalPlayer.PlayerGui:FindFirstChild("MultiPetsWindow", true)
                    if multiPetsUI then
                        local scrollView = multiPetsUI:FindFirstChild("PetScrollView", true)
                        if scrollView then
                            local highestLvl = -1
                            local bestKey = nil
                            
                            -- วนหาตัวที่เลเวลสูงที่สุดฝั่งซ้ายมือ ที่ยังมีชีวิตอยู่
                            for _, item in ipairs(scrollView:GetChildren()) do
                                if item:IsA("Frame") then
                                    local hpFill = item:FindFirstChild("HPFillMaskFrame", true)
                                    local hpScale = hpFill and hpFill.Size.X.Scale or 0
                                    
                                    if hpScale > 0 then -- มีชีวิตอยู่
                                        local lvlText = item:FindFirstChild("LevelText", true)
                                        if lvlText then
                                            local lvl = tonumber(lvlText.Text:match("%d+")) or 0
                                            if lvl > highestLvl then
                                                highestLvl = lvl
                                                local keyText = item:FindFirstChild("KeyText", true)
                                                if keyText then
                                                    bestKey = keyText.Text
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            
                            if bestKey then
                                warn("[AutoBattle] 💀 มอนสเตอร์ตาย! กำลังสลับไปใช้ Lv." .. highestLvl .. " (ปุ่ม " .. bestKey .. ")")
                                local keyMap = {["1"]="One", ["2"]="Two", ["3"]="Three", ["4"]="Four", ["5"]="Five", ["6"]="Six"}
                                local keyName = keyMap[bestKey]
                                if keyName and Enum.KeyCode[keyName] then
                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[keyName], false, game)
                                    task.wait(0.1)
                                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[keyName], false, game)
                                    task.wait(2) -- รออนิเมชั่นสลับตัวสักครู่
                                end
                            end
                        end
                    end
                end
            end)

            if isAutoLocked then
                -- เลเวลยังไม่ถึง 10 (Auto ยังไม่ปลดล็อค) → กดสกิล 1 แทนไปก่อน
                pcall(function()
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
                end)
            end

            task.wait(0.5)
        elseif wasInBattle then
            -- ═══ เพิ่งจบการต่อสู้ → รอ cooldown แล้วปลดล็อค ═══
            wasInBattle = false
            warn("[AutoBattle] จบ Battle แล้ว! กำลังรอ cooldown 3 วินาที...")
            
            -- ปลด Anchored เผื่อตัวเกมล็อคตัวละครไว้หลังจบ Battle
            if rootPart.Anchored then
                rootPart.Anchored = false
            end
            
            task.wait(3) -- รอให้เกมโหลดกลับเข้าแมพปกติ 3 วินาที
            
            -- บังคับปลดล็อคสถานะห้ามต่อสู้ (Cooldown) ของตัวเกม
            pcall(function()
                local triggerCtrl = require(ReplicatedStorage.Controller.WildBattleTriggerController)
                if triggerCtrl and triggerCtrl.forceRecoverEnterBattleState then
                    triggerCtrl:forceRecoverEnterBattleState()
                end
            end)
            
            task.wait(1) -- รอเพิ่ม 1 วินาทีหลัง forceRecover เพื่อให้ระบบพร้อม
            warn("[AutoBattle] ปลดล็อค cooldown เสร็จ! กำลังหามอนสเตอร์ตัวต่อไป...")
        end
        
        -- ═══ หามอนสเตอร์เป้าหมาย ═══
        local target = GetTargetMonster()
        
        if target then
            -- วาร์ปไปใกล้มอนสเตอร์ก่อน (เพื่อไม่ให้โดนจับว่า TP ข้ามแมพ)
            rootPart.CFrame = CFrame.new(target.pos)
            task.wait(0.3)
            
            -- ═══ ยิง Remote เข้า Battle โดยตรง (ไม่ต้องพึ่งการชน!) ═══
            warn("[AutoBattle] ยิง ReqEnterPetBattle → UID=" .. target.uid)
            pcall(function()
                Remote.Battle.ReqEnterPetBattle:FireServer(target.uid)
            end)
            
            -- รอให้เข้าฉาก Battle (สูงสุด 5 วินาที)
            local enteredBattle = false
            for i = 1, 50 do
                task.wait(0.1)
                local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
                if battleUI and battleUI.Enabled then
                    enteredBattle = true
                    break
                end
            end
            
            if enteredBattle then
                warn("[AutoBattle] ✅ เข้า Battle สำเร็จ!")
            end
            
            -- ถ้าไม่เข้า Battle (มอนหายไปแล้ว / คูลดาวน์) → ลองปลดล็อคแล้วไปตัวถัดไป
            if not enteredBattle then
                pcall(function()
                    local triggerCtrl = require(ReplicatedStorage.Controller.WildBattleTriggerController)
                    if triggerCtrl and triggerCtrl.forceRecoverEnterBattleState then
                        triggerCtrl:forceRecoverEnterBattleState()
                    end
                end)
                task.wait(1)
                warn("[AutoBattle] ⚠️ ไม่เข้า Battle → ปลดล็อคแล้วไปตัวต่อไป")
            end
        else
            -- ไม่เจอมอนสเตอร์ในช่วงเลเวลที่ต้องการ → รอสักครู่แล้วลองใหม่
            task.wait(2)
        end
        end -- ปิด else ของ character check
    end
end


-- ══════════════════════════════════════════════
--              FEATURE: AUTO QUEST
-- ══════════════════════════════════════════════
AutoQuest = function()
    warn("[AutoQuest] ═══ เริ่มระบบ Auto Quest ═══")

    while Config.AutoQuest do
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if not character or not rootPart then
            task.wait(1)
        else
            -- ═══ ดึงข้อมูล Quest ปัจจุบัน ═══
            local currentQuest = {
                text = "",
                progress = "",
                canClaim = false
            }

            pcall(function()
                local questFrame = LocalPlayer.PlayerGui.UIPrefabs.MainWindow.MainCanvasGroup.RightFrame.QuestFrame
                local questBtn = questFrame:FindFirstChild("QuestButton")

                if questBtn and questBtn.Visible then
                    local desText = questBtn:FindFirstChild("QuestDesText")
                    local progressText = questBtn:FindFirstChild("QuestProgressText")
                    local canClaimImg = questBtn:FindFirstChild("CanClaimImage")

                    currentQuest.text = desText and desText.Text or ""
                    currentQuest.progress = progressText and progressText.Text or ""
                    currentQuest.canClaim = canClaimImg and canClaimImg.Visible or false
                end
            end)

            -- ═══ เช็คว่ามี Quest หรือไม่ ═══
            if currentQuest.text == "" then
                warn("[AutoQuest] ไม่พบ Quest ที่ต้องทำ")
                task.wait(5)
            else
                warn("[AutoQuest] 📋 Quest: " .. currentQuest.text .. " " .. currentQuest.progress)

                -- ═══ เช็คว่าทำเสร็จแล้วหรือยัง ═══
                if currentQuest.canClaim then
                    warn("[AutoQuest] ✅ Quest เสร็จแล้ว! กำลังเคลมรางวัล...")
                    -- คลิกปุ่ม Quest เพื่อเคลม
                    pcall(function()
                        local questFrame = LocalPlayer.PlayerGui.UIPrefabs.MainWindow.MainCanvasGroup.RightFrame.QuestFrame
                        local questBtn = questFrame:FindFirstChild("QuestButton")
                        if questBtn then
                            for _, conn in pairs(getconnections(questBtn.MouseButton1Click)) do
                                conn:Fire()
                            end
                        end
                    end)
                    task.wait(2)
                else
                    -- ═══ Quest #1: จับ Pebble (Catch 3 Pebble in Verdant Valley) ═══
                    if currentQuest.text:match("Catch") and currentQuest.text:match("Pebble") then
                        -- แยกจำนวนที่ทำไปแล้ว/เป้าหมาย
                        local current, target = 0, 3
                        if currentQuest.progress:match("%((%d+)/(%d+)%)") then
                            local c, t = currentQuest.progress:match("%((%d+)/(%d+)%)")
                            current = tonumber(c)
                            target = tonumber(t)
                        end

                        warn("[AutoQuest] 🎯 เควส: จับ Pebble (" .. current .. "/" .. target .. ")")
                        warn("[AutoQuest] 📌 เป้าหมาย: Battle กับ Pebble 5 ตัว (เพราะมีโอกาสหลุด)")

                        -- หา Pebble ในแมพและ Battle
                        local foundPebble = false
                        pcall(function()
                            local allCreatures = Remote.Creature.ReqGetAllCreatures:InvokeServer()
                            for _, c in pairs(allCreatures) do
                                if type(c) == "table" and c.type == 3 and c.aliveState == 1 and not c.isCombating then
                                    -- เช็คว่าเป็น Pebble หรือไม่ (มอนสเตอร์เลเวลต่ำ 1-8 ใน Verdant Valley)
                                    if c.level and c.level >= 1 and c.level <= 8 then
                                        foundPebble = true

                                        -- วาร์ปไปหา Pebble
                                        if c.pos then
                                            rootPart.CFrame = CFrame.new(c.pos.Position)
                                            task.wait(0.5)

                                            -- เข้า Battle
                                            warn("[AutoQuest] ⚔️ เข้าสู้กับ Pebble (UID: " .. c.uid .. ")")
                                            Remote.Battle.ReqEnterPetBattle:FireServer(c.uid)
                                            task.wait(2)

                                            -- รอให้เข้า Battle
                                            local enteredBattle = false
                                            for i = 1, 30 do
                                                task.wait(0.1)
                                                local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
                                                if battleUI and battleUI.Enabled then
                                                    enteredBattle = true
                                                    break
                                                end
                                            end

                                            if enteredBattle then
                                                warn("[AutoQuest] ✅ เข้า Battle สำเร็จ! รอจนกว่าจะจบ...")

                                                -- รอจนกว่า Battle จะจบ (พร้อมกดโจมตี)
                                                while true do
                                                    -- กดปุ่ม 1 เพื่อโจมตี
                                                    pcall(function()
                                                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.One, false, game)
                                                        task.wait(0.1)
                                                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.One, false, game)
                                                    end)

                                                    task.wait(0.5)

                                                    -- เช็คว่า Battle จบหรือยัง
                                                    local battleUI = LocalPlayer.PlayerGui:FindFirstChild("MainBattleWindow", true)
                                                    if not battleUI or not battleUI.Enabled then
                                                        warn("[AutoQuest] 🎉 Battle จบแล้ว!")
                                                        break
                                                    end
                                                end

                                                task.wait(3) -- รอ cooldown
                                            end

                                            break
                                        end
                                    end
                                end
                            end
                        end)

                        if not foundPebble then
                            warn("[AutoQuest] ⚠️ ไม่พบ Pebble ในแมพ! รอ 3 วินาทีแล้วลองใหม่...")
                            task.wait(3)
                        end
                    else
                        -- เควสอื่นๆ (รอคุณบอกต่อ)
                        warn("[AutoQuest] ⏳ เควสนี้ยังไม่รองรับ: " .. currentQuest.text)
                        task.wait(5)
                    end
                end
            end
        end
    end

    warn("[AutoQuest] ═══ หยุดระบบ Auto Quest ═══")
end


-- ══════════════════════════════════════════════
--              START FEATURES
-- (รันได้เฉพาะตอน TutorialDone = true เท่านั้น)
-- ══════════════════════════════════════════════
if getgenv().TutorialDone then
    if Config.AutoChest then
        task.spawn(AutoChest)
    end
    if Config.AutoBattle then
        task.spawn(AutoBattle)
    end
    if Config.AutoRandomSuit then
        task.spawn(AutoRandomSuit)
    end
    if Config.AutoQuest then
        task.spawn(AutoQuest)
    end
end
