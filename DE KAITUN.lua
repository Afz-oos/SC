repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if game.PlaceId == 99421106727783 then
    pcall(function()
        local Event = game:GetService("ReplicatedStorage").Remotes.AFKServer
        Event:FireServer(
            "LeaveButton"
        )
    end)
    game:GetService("TeleportService"):Teleport(3351674303, LocalPlayer)
    return
end

repeat task.wait() until LocalPlayer.Character and LocalPlayer:FindFirstChild("PlayerGui")

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local VirtualUser = game:GetService("VirtualUser")

if game.PlaceId == 3351674303 then
    task.spawn(function()
        while task.wait(1) do
            if game.PlaceId == 99421106727783 then
                pcall(function()
                    local Event = game:GetService("ReplicatedStorage").Remotes.AFKServer
                    Event:FireServer(
                        "LeaveButton"
                    )
                end)
                game:GetService("TeleportService"):Teleport(3351674303, LocalPlayer)
            end
        end
    end)
end

local Camera = Workspace.CurrentCamera

local UserConfig = (getgenv and getgenv().Config) or _G.Config or {}
local TargetMiles = UserConfig.TargetMiles or 100
local EnableAutoFarm = UserConfig.EnableAutoFarm
if EnableAutoFarm == nil then EnableAutoFarm = true end
local EnableWhiteScreen = UserConfig.WhiteScreen or false
local EnableSuperBoostFPS = UserConfig.SuperBoostFPS or false

if EnableWhiteScreen then
    task.spawn(function()
        local RunService = game:GetService("RunService")
        pcall(function() RunService:Set3dRenderingEnabled(false) end)
        local gui = Instance.new("ScreenGui")
        gui.Name = "WhiteScreen"
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        local frame = Instance.new("Frame")
        frame.BackgroundColor3 = Color3.new(1, 1, 1)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.Parent = gui
        pcall(function()
            gui.Parent = game:GetService("CoreGui")
        end)
        if not gui.Parent then
            gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end
    end)
end

if EnableSuperBoostFPS then
    task.spawn(function()
        local Lighting = game:GetService("Lighting")
        local Terrain = Workspace.Terrain
        
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.ShadowSoftness = 0
        pcall(function() sethiddenproperty(Lighting, "Technology", 2) end)
        
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        
        Lighting:ClearAllChildren()
        
        local function applyFPSBoost(v)
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            end
        end

        for i, v in pairs(Workspace:GetDescendants()) do
            applyFPSBoost(v)
        end
        
        Workspace.DescendantAdded:Connect(applyFPSBoost)
    end)
end

local AutoFarm = EnableAutoFarm
local TouchTheRoad = false
local AutoFarmRunning = false
local LastNotif = 0

local function GetCurrentVehicle()
	local Char = LocalPlayer.Character
	if Char and Char:FindFirstChild("Humanoid") then
		local SeatPart = Char.Humanoid.SeatPart
		if SeatPart then
			return SeatPart.Parent
		end
	end
	return nil
end

for _, v in next, getconnections(LocalPlayer.Idled) do
	v:Disable()
end

local function TP(cframe)
	local Vehicle = GetCurrentVehicle()
	if Vehicle and Vehicle.PrimaryPart then
		Vehicle:SetPrimaryPartCFrame(cframe)
	end
end

local function VelocityTP(cframe)
	local Vehicle = GetCurrentVehicle()
	if not Vehicle or not Vehicle.PrimaryPart then
		return
	end

	local TeleportSpeed = math.random(700, 700)
	local PrimaryPart = Vehicle.PrimaryPart

	local BodyGyro = Instance.new("BodyGyro", PrimaryPart)
	BodyGyro.P = 5000
	BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	BodyGyro.CFrame = PrimaryPart.CFrame

	local BodyVelocity = Instance.new("BodyVelocity", PrimaryPart)
	BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	BodyVelocity.Velocity = CFrame.new(PrimaryPart.Position, cframe.Position).LookVector * TeleportSpeed

	task.wait((PrimaryPart.Position - cframe.Position).Magnitude / TeleportSpeed)
	BodyVelocity.Velocity = Vector3.new()

	task.wait(0.1)
	BodyVelocity:Destroy()
	BodyGyro:Destroy()
end

local EndPosition = CFrame.new(Vector3.new(-34567.375, 34.895652770996094, -32846.046875), Vector3.new())
local StartPosition = CFrame.new(Vector3.new(-31448.3515625, 34.925010681152344, -26616.25), Vector3.new())

function ClickGui(v__1)
	local v__2 = {"Activated", "MouseButton1Down", "MouseButton1Click", "MouseButton1Up"}
	for _, v__3 in next, v__2 do
		pcall(function()
			if v__1[v__3] then
				for _, v__4 in next, getconnections(v__1[v__3]) do
					v__4.Function()
				end
			end
		end)
	end
end

--game:GetService("Players").LocalPlayer.PlayerGui.Loading.Menu.Main.Play

task.spawn(function() 
    while task.wait() do 
		local Load = LocalPlayer.PlayerGui:FindFirstChild("LoadingUI")
        if Load and Load.Enabled then 
            ClickGui(LocalPlayer.PlayerGui.LoadingUI.Menu.Main.Play)
        end 
		if LocalPlayer.PlayerGui.MainHUD.StarterCars.Visible then 
			ClickGui(LocalPlayer.PlayerGui.MainHUD.StarterCars.StarterCarsWindow.InnerFrame.CarList["McLaren-600LTCoupe"].SelectionCanvas.SelectionFrame.Button)
		end
    end 
end)

task.spawn(function()
	while task.wait() do
		if not AutoFarm then
			AutoFarmRunning = false
			continue
		end
		AutoFarmRunning = true
		pcall(function()
			local Vehicle = GetCurrentVehicle()
			if not Vehicle then
				if tick() - LastNotif > 5 then
					LastNotif = tick()
					LocalPlayer.Character.HumanoidRootPart.CFrame = EndPosition
					ReplicatedStorage.Remotes.VehicleEvent:FireServer("Spawn","McLaren-600LTCoupe")
				end
				return
			end
			TP(StartPosition + Vector3.new(0, -3, 0))
			VelocityTP(EndPosition + Vector3.new(0, -3, 0))
			TP(EndPosition + Vector3.new(0, -3, 0))
			VelocityTP(StartPosition + Vector3.new(0, -3, 0))
		end)
	end
end)

-- ฟังก์ชัน Auto Delivery แบบสมบูรณ์
local function AutoDelivery()
    local ENV = (getgenv and getgenv()) or _G

    local DEFAULT_CONFIG = {
        TeleportHeight = 4,
        AfterTeleportDelay = 0.25,
        AfterLeaveDelay = 0.4,
        StatePollDelay = 0.2,
        LoopDelay = 0.35,
        InteractDelay = 0.65,
        StartTimeout = 8,
        CollectTimeout = 14,
        DropTimeout = 12,
        NextStateTimeout = 6,
        UseDirectFunctions = false,
        UseDirectPickupFunction = false,
        UseDirectCompleteFunction = false,
        MinDropoffWait = 10.5,
        CollectingStopTimeout = 4,
        QuitOtherJobs = true,
        AntiAfk = true,
        Debug = true,
    }

    ENV.DY_DELIVERY_FARM_CONFIG = ENV.DY_DELIVERY_FARM_CONFIG or {}
    local CONFIG = ENV.DY_DELIVERY_FARM_CONFIG
    for key, value in pairs(DEFAULT_CONFIG) do
        if CONFIG[key] == nil then
            CONFIG[key] = value
        end
    end

    local runId = tostring(os.clock()) .. ":" .. tostring(math.random(1, 1e9))
    ENV.DY_DELIVERY_FARM_ENABLED = true
    ENV.DY_DELIVERY_FARM_RUN_ID = runId

    local function isEnabled()
        return ENV.DY_DELIVERY_FARM_ENABLED == true and ENV.DY_DELIVERY_FARM_RUN_ID == runId
    end

    local function log(...)
        if CONFIG.Debug then
            print("[Dy Delivery]", ...)
        end
    end

    local function warnLog(...)
        warn("[Dy Delivery]", ...)
    end

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CollectionService = game:GetService("CollectionService")
    local Workspace = game:GetService("Workspace")
    local VirtualUser = game:GetService("VirtualUser")

    local LocalPlayer = Players.LocalPlayer
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")

    local RequestStartJobSession = Remotes:WaitForChild("RequestStartJobSession")
    local RequestEndJobSession = Remotes:WaitForChild("RequestEndJobSession")
    local DeliveryLocationInteracted = Remotes:WaitForChild("DeliveryLocationInteracted")
    local DeliveryLocationLeft = Remotes:WaitForChild("DeliveryLocationLeft")
    local DeliveryStateChanged = Remotes:WaitForChild("DeliveryStateChanged")
    local DeliveryCompleted = Remotes:WaitForChild("DeliveryCompleted")
    local AttemptDeliveryPickup = Remotes:FindFirstChild("AttemptDeliveryPickup")
    local AttemptDeliveryComplete = Remotes:FindFirstChild("AttemptDeliveryComplete")

    local DeliveryJobTask
    local DeliveryUtil

    pcall(function()
        DeliveryJobTask = require(ReplicatedStorage.Modules.Client.Jobs.Tasks.DeliveryJobTask)
    end)

    pcall(function()
        DeliveryUtil = require(ReplicatedStorage.Modules.Shared.Jobs.Delivery.DeliveryUtil)
    end)

    local pickupRadius = 25
    pcall(function()
        if DeliveryUtil then
            pickupRadius = DeliveryUtil.GetPickupRadius()
        end
    end)

    local currentState = nil
    local lastCompletedAt = 0
    local lastCompletedPayload = nil

    DeliveryStateChanged.OnClientEvent:Connect(function(state)
        currentState = state
    end)

    DeliveryCompleted.OnClientEvent:Connect(function(payload)
        lastCompletedAt = os.clock()
        lastCompletedPayload = payload
    end)

    if CONFIG.AntiAfk then
        LocalPlayer.Idled:Connect(function()
            pcall(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
            end)
        end)
    end

    local function getState()
        if DeliveryJobTask then
            local ok, state = pcall(function()
                return DeliveryJobTask.GetCurrentDeliveryState()
            end)

            if ok then
                currentState = state
            end
        end

        return currentState
    end

    local function waitFor(predicate, timeout)
        local start = os.clock()

        repeat
            local state = getState()
            if predicate(state) then
                return state
            end

            task.wait(CONFIG.StatePollDelay)
        until not isEnabled() or os.clock() - start >= timeout

        return getState()
    end

    local function getCharacter()
        return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    end

    local function getRootPart()
        local character = getCharacter()
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")

        if humanoid and humanoid.SeatPart then
            humanoid.Sit = false
            task.wait(0.15)
        end

        return character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
    end

    local function teleportTo(position)
        local root = getRootPart()
        if not root then
            return false
        end

        root.CFrame = CFrame.new(position + Vector3.new(0, CONFIG.TeleportHeight, 0))
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        task.wait(CONFIG.AfterTeleportDelay)
        return true
    end

    local function getDeliveryLocations()
        local locations = {}

        for _, instance in ipairs(CollectionService:GetTagged("DeliveryLocation")) do
            if instance:IsA("BasePart") and instance:IsDescendantOf(Workspace) then
                table.insert(locations, instance)
            end
        end

        if #locations > 0 then
            return locations
        end

        local deliveryFolder = Workspace:FindFirstChild("Game")
            and Workspace.Game:FindFirstChild("Jobs")
            and Workspace.Game.Jobs:FindFirstChild("Delivery")
            and Workspace.Game.Jobs.Delivery:FindFirstChild("DeliveryLocations")

        if deliveryFolder then
            for _, instance in ipairs(deliveryFolder:GetChildren()) do
                if instance:IsA("BasePart") then
                    table.insert(locations, instance)
                end
            end
        end

        return locations
    end

    local function findClosestLocation(position)
        local bestLocation = nil
        local bestDistance = math.huge

        for _, location in ipairs(getDeliveryLocations()) do
            local distance = (location.Position - position).Magnitude
            if distance < bestDistance then
                bestLocation = location
                bestDistance = distance
            end
        end

        return bestLocation, bestDistance
    end

    local function findClosestLocationToPlayer()
        local root = getRootPart()
        if not root then
            return nil, math.huge
        end

        return findClosestLocation(root.Position)
    end

    local function fireInteract(location)
        if not location or not location.Parent then
            return
        end

        pcall(function()
            DeliveryLocationInteracted:FireServer(location)
        end)
    end

    local function fireLeave(location)
        if not location or not location.Parent then
            return
        end

        pcall(function()
            DeliveryLocationLeft:FireServer(location)
        end)
    end

    local function invokeRemote(remote, location)
        if not remote or not location or not location.Parent then
            return nil
        end

        local ok, result = pcall(function()
            return remote:InvokeServer(location)
        end)

        if not ok then
            return nil
        end

        return result
    end

    local function samePosition(a, b)
        return typeof(a) == "Vector3" and typeof(b) == "Vector3" and (a - b).Magnitude < 1
    end

    local function getMinDropoffWait(state)
        local minWait = CONFIG.MinDropoffWait or 0

        if DeliveryUtil and state and state.DeliveryTypeId then
            local ok, typeMinCutoff = pcall(function()
                return DeliveryUtil.GetTypeMinCutoff(state.DeliveryTypeId, LocalPlayer)
            end)

            if ok and typeof(typeMinCutoff) == "number" then
                minWait = math.max(minWait, typeMinCutoff)
            end
        end

        return minWait
    end

    local function waitForDropoffWindow(state)
        if not state or not state.DeliveryStartTime or state.DeliveryStartTime <= 0 then
            return
        end

        local minWait = getMinDropoffWait(state)
        if minWait <= 0 then
            return
        end

        local elapsed = Workspace:GetServerTimeNow() - state.DeliveryStartTime
        if elapsed >= minWait then
            return
        end

        local remaining = minWait - elapsed
        log("waiting dropoff window:", string.format("%.1fs", remaining))

        local start = os.clock()
        while isEnabled() and os.clock() - start < remaining do
            task.wait(math.min(CONFIG.StatePollDelay, math.max(remaining - (os.clock() - start), 0.05)))
        end
    end

    local function ensureDeliveryJob()
        local jobId = LocalPlayer:GetAttribute("JobId")

        if jobId and jobId ~= "Delivery" and CONFIG.QuitOtherJobs then
            log("ending current job:", jobId)
            RequestEndJobSession:FireServer("jobPad")
            task.wait(1)
        end

        if LocalPlayer:GetAttribute("JobId") ~= "Delivery" then
            log("starting Delivery job")
            RequestStartJobSession:FireServer("Delivery", "jobPad")

            waitFor(function()
                return LocalPlayer:GetAttribute("JobId") == "Delivery"
            end, CONFIG.StartTimeout)
        end

        if getState() then
            return true
        end

        local location = findClosestLocationToPlayer()
        if location then
            log("requesting first delivery plan")
            teleportTo(location.Position)
            fireInteract(location)
            waitFor(function(state)
                return state ~= nil
            end, CONFIG.StartTimeout)
        end

        return LocalPlayer:GetAttribute("JobId") == "Delivery"
    end

    local function collectPickup(state)
        if not state or not state.PickupPosition then
            return false
        end

        local pickupLocation = findClosestLocation(state.PickupPosition)
        if not pickupLocation then
            warnLog("pickup location not found")
            return false
        end

        log("pickup:", pickupLocation:GetFullName())
        teleportTo(state.PickupPosition)

        local start = os.clock()
        repeat
            state = getState() or state

            if state.DestinationPosition and (state.ItemsCarried or 0) >= (state.MaxCapacity or 4) then
                break
            end

            if state.PickupPosition and not samePosition(state.PickupPosition, pickupLocation.Position) then
                pickupLocation = findClosestLocation(state.PickupPosition) or pickupLocation
                teleportTo(state.PickupPosition)
            end

            fireInteract(pickupLocation)

            if CONFIG.UseDirectFunctions or CONFIG.UseDirectPickupFunction then
                invokeRemote(AttemptDeliveryPickup, pickupLocation)
            end

            task.wait(CONFIG.InteractDelay)
        until not isEnabled() or os.clock() - start >= CONFIG.CollectTimeout

        fireLeave(pickupLocation)
        task.wait(CONFIG.AfterLeaveDelay)

        state = waitFor(function(nextState)
            return nextState
                and nextState.DestinationPosition ~= nil
                and (nextState.ItemsCarried or 0) > 0
        end, 2)

        if state and state.IsCollecting then
            state = waitFor(function(nextState)
                return nextState
                    and nextState.DestinationPosition ~= nil
                    and (nextState.ItemsCarried or 0) > 0
                    and nextState.IsCollecting ~= true
            end, CONFIG.CollectingStopTimeout)
        end

        if state and state.DestinationPosition and (state.ItemsCarried or 0) > 0 then
            log("collected:", tostring(state.ItemsCarried), "/", tostring(state.MaxCapacity or "?"))
            return true
        end

        warnLog("pickup timed out")
        return false
    end

    local function completeDropoff(state)
        if not state or not state.DestinationPosition or (state.ItemsCarried or 0) <= 0 then
            return false
        end

        local destinationLocation = findClosestLocation(state.DestinationPosition)
        if not destinationLocation then
            warnLog("dropoff location not found")
            return false
        end

        local oldPickupPosition = state.PickupPosition
        local completedBefore = lastCompletedAt

        log("dropoff:", destinationLocation:GetFullName())
        waitForDropoffWindow(state)
        teleportTo(state.DestinationPosition)

        local start = os.clock()
        repeat
            state = getState() or state

            if not state or state.IsPlanned or (state.ItemsCarried or 0) <= 0 then
                break
            end

            if state.DestinationPosition and not samePosition(state.DestinationPosition, destinationLocation.Position) then
                destinationLocation = findClosestLocation(state.DestinationPosition) or destinationLocation
                teleportTo(state.DestinationPosition)
            end

            fireInteract(destinationLocation)

            if CONFIG.UseDirectFunctions or CONFIG.UseDirectCompleteFunction then
                invokeRemote(AttemptDeliveryComplete, destinationLocation)
            end

            if lastCompletedAt > completedBefore then
                break
            end

            task.wait(CONFIG.InteractDelay)
        until not isEnabled() or os.clock() - start >= CONFIG.DropTimeout

        fireLeave(destinationLocation)
        task.wait(CONFIG.AfterLeaveDelay)

        waitFor(function(nextState)
            if lastCompletedAt > completedBefore then
                return true
            end

            if not nextState then
                return true
            end

            if nextState.IsPlanned and (nextState.ItemsCarried or 0) == 0 then
                return true
            end

            return oldPickupPosition and nextState.PickupPosition and not samePosition(oldPickupPosition, nextState.PickupPosition)
        end, CONFIG.NextStateTimeout)

        if lastCompletedPayload then
            log("last payout:", tostring(lastCompletedPayload.CashReward or 0))
        end

        return lastCompletedAt > completedBefore
    end

    task.spawn(function()
        log("started. Stop with: getgenv().DY_DELIVERY_FARM_ENABLED = false")

        while isEnabled() do
            local ok, err = pcall(function()
                if not ensureDeliveryJob() then
                    task.wait(1)
                    return
                end

                local state = waitFor(function(nextState)
                    return nextState ~= nil
                end, CONFIG.StartTimeout)

                if not state then
                    local location = findClosestLocationToPlayer()
                    if location then
                        teleportTo(location.Position)
                        fireInteract(location)
                    end
                    task.wait(1)
                    return
                end

                if state.DestinationPosition and (state.ItemsCarried or 0) > 0 then
                    completeDropoff(state)
                elseif state.PickupPosition then
                    collectPickup(state)
                else
                    local location = findClosestLocationToPlayer()
                    if location then
                        teleportTo(location.Position)
                        fireInteract(location)
                    end
                end
            end)

            if not ok then
                warnLog(err)
                task.wait(1)
            end

            task.wait(CONFIG.LoopDelay)
        end

        ENV.DY_DELIVERY_FARM_RUNNING = false
        log("stopped")
    end)

    ENV.DY_DELIVERY_FARM_RUNNING = true
end

task.spawn(function()
    local leaderstats = LocalPlayer:WaitForChild("leaderstats", 9e9)
    local miles = leaderstats:WaitForChild("Miles", 9e9)

    local function checkAndStartJob()
        local currentMiles = tonumber(miles.Value) or 0
        print("[System] กำลังเช็คระยะทาง... ปัจจุบันมี: " .. tostring(currentMiles) .. " Miles")
        
        if not EnableAutoFarm or currentMiles >= TargetMiles then
            if not EnableAutoFarm then
                print("[System] AutoFarm ขับรถถูกตั้งค่าปิดไว้ กำลังข้ามไปรับงาน Delivery ทันที...")
            else
                print("[System] ระยะทางครบ " .. tostring(TargetMiles) .. " Miles แล้ว! กำลังปิด AutoFarm และเริ่มส่งของ...")
            end
            -- 1. ปิดออโต้ฟาร์ม (หยุด loop วาร์ป)
            AutoFarm = false
            
            -- 2. รีเซ็ตตัวละครให้ตายและเกิดใหม่
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = 0
                LocalPlayer.CharacterAdded:Wait()
                task.wait(1.5) -- รอโหลดแมพสักครู่
            end

            -- 3. รันรีโมทเริ่มงาน
            local Event = ReplicatedStorage:WaitForChild("Remotes", 5)
            if Event then
                local reqEvent = Event:WaitForChild("RequestStartJobSession", 5)
                if reqEvent then
                    reqEvent:FireServer("Delivery", "jobPad")
                end
            end
            
            -- 4. เรียกใช้ฟังก์ชัน Auto Delivery
            AutoDelivery()
        else
            print("[System] ระยะทางยังไม่ครบ " .. tostring(TargetMiles) .. " (ปัจจุบัน " .. tostring(currentMiles) .. ") ระบบ AutoFarm จะขับรถต่อไป...")
        end
    end

    checkAndStartJob()

    miles:GetPropertyChangedSignal("Value"):Connect(checkAndStartJob)
end)

