repeat wait() until game:IsLoaded()

_G.AutoFarmLevel = false

if _G.HazeSeasAutoFarmCleanup then
	pcall(_G.HazeSeasAutoFarmCleanup)
end

task.wait(0.75)

_G.AutoFarmLevel = true

local PreviousConfig = type(_G.HazeSeasAutoFarm) == "table" and _G.HazeSeasAutoFarm or nil

_G.HazeSeasAutoFarmRunId = (_G.HazeSeasAutoFarmRunId or 0) + 1
_G.HazeSeasAutoFarm = {}

local Config = _G.HazeSeasAutoFarm

if PreviousConfig then
	for key, value in next, PreviousConfig do
		if key ~= "Enabled" and key ~= "Status" then
			Config[key] = value
		end
	end
end

local RunId = _G.HazeSeasAutoFarmRunId

Config.Enabled = true
Config.RunId = RunId
Config.HoverHeight = Config.HoverHeight or 8
Config.AttackDelay = math.min(Config.AttackDelay or 0.06, 0.06)
Config.AttackBurst = math.max(2, math.floor(Config.AttackBurst or 2))
Config.AttackBurstDelay = math.min(Config.AttackBurstDelay or 0.02, 0.02)
Config.LoopDelay = math.min(Config.LoopDelay or 0.08, 0.08)
Config.TargetRefreshDelay = Config.TargetRefreshDelay or 0.75
Config.QuestRetryDelay = Config.QuestRetryDelay or 2
Config.ContainerRefreshDelay = Config.ContainerRefreshDelay or 10
Config.TeleportDistance = math.max(Config.TeleportDistance or 55, 55)
Config.DirectLockDistance = math.max(Config.DirectLockDistance or 140, 140)
Config.SmoothTravel = Config.SmoothTravel ~= false
Config.FastTravel = Config.FastTravel ~= false
Config.TravelSpeed = math.max(Config.TravelSpeed or 650, 650)
Config.TravelStepDelay = math.min(Config.TravelStepDelay or 0.015, 0.015)
Config.TravelMaxStep = math.max(Config.TravelMaxStep or 22, 22)
Config.SafePositionFloor = Config.SafePositionFloor or -10000
Config.PreferTool = Config.PreferTool or nil
Config.PreferMelee = Config.PreferMelee ~= false
Config.NoClip = Config.NoClip ~= false
Config.AntiAfk = Config.AntiAfk ~= false
Config.AntiAfkInterval = Config.AntiAfkInterval or 60
Config.AutoHaki = Config.AutoHaki ~= false
Config.AutoBuso = Config.AutoBuso ~= false
Config.AutoObservationHaki = Config.AutoObservationHaki == true
Config.AutoConquerorHaki = Config.AutoConquerorHaki == true
Config.HakiCheckDelay = Config.HakiCheckDelay or 1
Config.HakiRetryDelay = Config.HakiRetryDelay or 3
Config.BossFallback = Config.BossFallback ~= false
Config.BossFallbackSameGiver = Config.BossFallbackSameGiver ~= false
Config.BossFallbackSwitchToBoss = Config.BossFallbackSwitchToBoss ~= false
Config.BossFallbackCheckDelay = Config.BossFallbackCheckDelay or 1
Config.BossMissingCancelDelay = Config.BossMissingCancelDelay or 4
Config.BossFallbackRequireSpawnedMob = Config.BossFallbackRequireSpawnedMob ~= false
Config.BossFallbackFarmWithoutCancel = Config.BossFallbackFarmWithoutCancel ~= false
Config.BossQuestKillThreshold = Config.BossQuestKillThreshold or 1
Config.QuestCancelRetryDelay = Config.QuestCancelRetryDelay or 3
Config.QuestCancelWait = Config.QuestCancelWait or 1.5
Config.ClickPlay = Config.ClickPlay ~= false
Config.SearchPlayDelay = Config.SearchPlayDelay or 0.5
Config.SearchPlayTimeout = Config.SearchPlayTimeout or 60
Config.PlayBlockWords = Config.PlayBlockWords or {
	"playtime",
	"afk reward",
	"teleport to afk",
}
Config.PlaySignals = Config.PlaySignals or {
	"Activated",
	"MouseButton1Click",
	"MouseButton1Down",
	"MouseButton1Up",
}
Config.AutoStats = Config.AutoStats ~= false
Config.StatMax = Config.StatMax or 4500
Config.StatChunk = Config.StatChunk or 50
Config.StatDelay = Config.StatDelay or 0.25
Config.StatLoopDelay = Config.StatLoopDelay or 1
Config.StatOrder = Config.StatOrder or {
	"Sword",
	"Defense",
	"Fruit",
}
Config.Debug = Config.Debug == true
Config.Status = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = nil

pcall(function()
	VirtualInputManager = game:GetService("VirtualInputManager")
end)

local function debugPrint(...)
	if Config.Debug then
		print("[HazeSeas AutoFarm]", ...)
	end
end

local function setStatus(key, value)
	Config.Status[key] = value
	Config.Status.UpdatedAt = tick()
end

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function isPlayGuiVisible(button, playerGui)
	local current = button

	while current and current ~= playerGui do
		if current:IsA("GuiObject") then
			if not current.Visible or current.AbsoluteSize.X <= 0 or current.AbsoluteSize.Y <= 0 then
				return false
			end
		elseif current:IsA("ScreenGui") and not current.Enabled then
			return false
		end

		current = current.Parent
	end

	return true
end

local function insertGuiText(array, instance)
	local success, text = pcall(function()
		return instance.Text
	end)

	if success and text and text ~= "" then
		table.insert(array, tostring(text))
	end
end

local function addChildText(array, root, depth)
	if depth > 3 then
		return
	end

	insertGuiText(array, root)

	for _, child in next, root:GetChildren() do
		addChildText(array, child, depth + 1)
	end
end

local function getButtonContext(button, playerGui)
	local array = { button.Name }
	local current = button.Parent

	for _ = 1, 5 do
		if not current or current == playerGui then
			break
		end

		table.insert(array, current.Name)
		current = current.Parent
	end

	addChildText(array, button, 0)

	return string.lower(table.concat(array, " "))
end

local function getButtonText(button)
	local success, text = pcall(function()
		return button.Text
	end)

	if success and text then
		return string.lower(tostring(text))
	end

	return ""
end

local function hasPlayBlockedWord(context)
	for _, word in next, Config.PlayBlockWords do
		if string.find(context, string.lower(tostring(word)), 1, true) then
			return true
		end
	end

	return false
end

local function getPlayScore(button, playerGui)
	if not isPlayGuiVisible(button, playerGui) then
		return 0
	end

	local context = getButtonContext(button, playerGui)

	if hasPlayBlockedWord(context) then
		return 0
	end

	local name = string.lower(button.Name)
	local text = getButtonText(button)

	if name == "play" or text == "play" then
		return 100
	end

	if string.find(name, "playbutton", 1, true)
		or string.find(name, "play_button", 1, true)
		or string.find(context, "play button", 1, true)
	then
		return 90
	end

	if (string.find(context, "main menu", 1, true) or string.find(context, "mainmenu", 1, true))
		and string.find(context, "play", 1, true)
	then
		return 75
	end

	if string.match(context, "%f[%a]play%f[%A]") then
		return 60
	end

	return 0
end

local function walkGui(root, callback)
	for _, child in next, root:GetChildren() do
		callback(child)
		walkGui(child, callback)
	end
end

local function findPlayButton(playerGui)
	local bestButton = nil
	local bestScore = 0

	walkGui(playerGui, function(instance)
		if instance:IsA("TextButton") or instance:IsA("ImageButton") then
			local score = getPlayScore(instance, playerGui)

			if score > bestScore then
				bestButton = instance
				bestScore = score
			end
		end
	end)

	return bestButton
end

local function clickPlayButton(button)
	local clicked = false

	if type(firesignal) == "function" then
		for _, signalName in next, Config.PlaySignals do
			pcall(function()
				firesignal(button[signalName])
				clicked = true
			end)
		end
	end

	pcall(function()
		button:Activate()
		clicked = true
	end)

	pcall(function()
		if not VirtualInputManager then
			return
		end

		local position = button.AbsolutePosition
		local size = button.AbsoluteSize
		local x = position.X + (size.X / 2)
		local y = position.Y + (size.Y / 2)

		VirtualInputManager:SendMouseMoveEvent(x, y, game)
		VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
		task.wait(0.05)
		VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
		clicked = true
	end)

	return clicked
end

local function clickPlayWhenReady()
	if not Config.ClickPlay then
		return false
	end

	local startedAt = os.clock()

	setStatus("ClickPlay", "searching")

	repeat
		local playButton = findPlayButton(PlayerGui)

		if playButton then
			local clicked = clickPlayButton(playButton)

			setStatus("ClickPlay", clicked and "clicked" or "failed")
			setStatus("ClickPlayButton", playButton.Name)

			return clicked
		end

		task.wait(math.max(Config.SearchPlayDelay, 0.05))
	until Config.Enabled == false
		or _G.AutoFarmLevel == false
		or _G.HazeSeasAutoFarmRunId ~= RunId
		or os.clock() - startedAt >= Config.SearchPlayTimeout

	setStatus("ClickPlay", "timeout")

	return false
end

task.spawn(clickPlayWhenReady)

local QuestGui = PlayerGui:WaitForChild("QuestGui")
local QuestFunction = QuestGui:WaitForChild("QuestFunction")
local QuestGivers = workspace:WaitForChild("Npc_Workspace"):WaitForChild("QuestGivers")
local NpcZones = workspace:WaitForChild("NPC Zones")

local Connections = {}
local QuestCache = {}
local NpcContainers = {}
local LastQuestCacheBuild = 0
local LastContainerScan = 0
local LastAttack = 0
local LastQuestAttempt = 0
local LastTargetSearch = 0
local LastAntiAfkPulse = 0
local LastHakiCheck = 0
local LastHakiAttempt = {}
local LastBossFallbackCheck = 0
local LastQuestCancelAttempt = 0
local BossMissingSince = 0
local CurrentQuest = nil
local CurrentTarget = nil
local CurrentTraveling = false
local PreviousObjective = ""
local findMob
local ActiveBossFallbackQuest = nil

local BossQuestNames = {
	["bandit boss"] = true,
	["clown boss"] = true,
	["shark boss"] = true,
	["bomb boss"] = true,
	["krieg boss"] = true,
	["king gorilla"] = true,
	["marine captain"] = true,
	["minotaur"] = true,
	["vice admiral"] = true,
	["ice admiral"] = true,
	["thunder god"] = true,
	["revolutionary boss"] = true,
	["warden"] = true,
	["vergo"] = true,
	["snow harpy"] = true,
	["neptune"] = true,
	["shiryu"] = true,
	["g4 boss"] = true,
	["ryummy"] = true,
}

local function isRunning()
	return Config.Enabled ~= false and _G.AutoFarmLevel ~= false and _G.HazeSeasAutoFarmRunId == RunId
end

local function getCharacter()
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

	return character, humanoid, root
end

local function getValue(parent, name, fallback)
	local value = parent and parent:FindFirstChild(name)

	if value and value:IsA("ValueBase") then
		return value.Value
	end

	return fallback
end

local function getPlayerData()
	return LocalPlayer:FindFirstChild("PlayerData")
end

local function getExperienceFolder()
	local playerData = getPlayerData()

	return playerData and playerData:FindFirstChild("Experience")
end

local function getLevel()
	local experience = getExperienceFolder()

	return getValue(experience, "Level", 1)
end

local function getClientEvent(name)
	local replication = ReplicatedStorage:FindFirstChild("Replication")
	local clientEvents = replication and replication:FindFirstChild("ClientEvents")

	return clientEvents and clientEvents:FindFirstChild(name)
end

local function getStatValue(name)
	local experience = getExperienceFolder()

	return tonumber(getValue(experience, name, 0)) or 0
end

local function getPointValue()
	local experience = getExperienceFolder()

	return math.floor(tonumber(getValue(experience, "Points", 0)) or 0)
end

local function buildStatSpendPlan()
	local array = {}
	local pointsLeft = getPointValue()
	local statMax = tonumber(Config.StatMax) or 4500

	if pointsLeft <= 0 then
		return array
	end

	for _, statName in next, Config.StatOrder do
		if pointsLeft <= 0 then
			break
		end

		local current = getStatValue(statName)
		local remainingToMax = math.max(statMax - current, 0)
		local spend = math.min(pointsLeft, remainingToMax)

		if spend > 0 then
			table.insert(array, {
				Name = statName,
				Amount = spend,
			})

			pointsLeft = pointsLeft - spend
		end
	end

	return array
end

local function spendStatPoints()
	local statsEvent = getClientEvent("Stats_Event")
	local plan = buildStatSpendPlan()

	setStatus("StatPoints", getPointValue())
	setStatus("SwordStat", getStatValue("Sword"))
	setStatus("DefenseStat", getStatValue("Defense"))
	setStatus("FruitStat", getStatValue("Fruit"))

	if not statsEvent then
		setStatus("AutoStats", "missing_remote")

		return false
	end

	if #plan == 0 then
		setStatus("AutoStats", getPointValue() > 0 and "maxed" or "waiting_points")

		return false
	end

	setStatus("AutoStats", "spending")

	for _, entry in next, plan do
		local remaining = entry.Amount

		while remaining > 0 and isRunning() and Config.AutoStats do
			local chunk = math.min(remaining, Config.StatChunk, getPointValue())

			if chunk <= 0 then
				break
			end

			local success, result = pcall(function()
				statsEvent:FireServer(entry.Name, chunk)
			end)

			if not success then
				setStatus("AutoStats", "failed")
				setStatus("AutoStatsError", tostring(result))

				return false
			end

			setStatus("LastStatName", entry.Name)
			setStatus("LastStatAmount", chunk)
			setStatus("AutoStatsError", nil)

			remaining = remaining - chunk
			task.wait(Config.StatDelay)
		end
	end

	setStatus("AutoStats", "spent")

	return true
end

local function autoUpgradeStats()
	if not Config.AutoStats then
		return
	end

	while isRunning() and Config.AutoStats do
		if getPointValue() > 0 then
			spendStatPoints()
		else
			setStatus("StatPoints", 0)
			setStatus("AutoStats", "waiting_points")
		end

		task.wait(Config.StatLoopDelay)
	end
end

local function getBusoLevel()
	local playerData = getPlayerData()
	local buso = playerData and playerData:FindFirstChild("Buso")

	return tonumber(getValue(buso, "BusoLevel", 0)) or 0
end

local function getObservationHakiLevel()
	local playerData = getPlayerData()
	local haki = playerData and playerData:FindFirstChild("Haki")

	return tonumber(getValue(haki, "ObservationHakiLevel", 0)) or 0
end

local function getConquerorHakiLevel()
	local playerData = getPlayerData()
	local haki = playerData and playerData:FindFirstChild("Haki")
	local haoLevel = tonumber(getValue(playerData, "HaoLevel", 0)) or 0
	local conquerorLevel = tonumber(getValue(haki, "ConquerorLevel", 0)) or 0

	return math.max(haoLevel, conquerorLevel)
end

local function getFormerStarterCharacterScripts()
	return PlayerGui:FindFirstChild("FormerStarterCharacterScripts")
end

local function getCommunicationRemote(container)
	local remote = container and container:FindFirstChild("Comunication")

	if remote and remote:IsA("RemoteEvent") then
		return remote
	end

	return nil
end

local function getAbilityRemote(abilityName)
	local character = LocalPlayer.Character
	local formerScripts = getFormerStarterCharacterScripts()

	if abilityName == "Buso" then
		local remote = getCommunicationRemote(character and character:FindFirstChild("Buso_Server"))

		return remote or getCommunicationRemote(formerScripts and formerScripts:FindFirstChild("Buso_Server"))
	end

	if abilityName == "Observation" then
		return getCommunicationRemote(PlayerGui:FindFirstChild("ObservationHaki_Server"))
	end

	if abilityName == "Conqueror" then
		local remote = getCommunicationRemote(character and character:FindFirstChild("Haki_Server"))

		return remote or getCommunicationRemote(formerScripts and formerScripts:FindFirstChild("Haki_Server"))
	end

	return nil
end

local function getWorkspacePlayer()
	local playersFolder = workspace:FindFirstChild("Players")

	return playersFolder and playersFolder:FindFirstChild(LocalPlayer.Name) or nil
end

local function getCharacterBool(name)
	local character = LocalPlayer.Character
	local value = character and character:FindFirstChild(name)

	if value and value:IsA("BoolValue") then
		return value
	end

	local workspacePlayer = getWorkspacePlayer()
	value = workspacePlayer and workspacePlayer:FindFirstChild(name)

	if value and value:IsA("BoolValue") then
		return value
	end

	return nil
end

local function isBusoActive()
	local busoEnabled = getCharacterBool("BusoEnabled")
	local haki = getCharacterBool("Haki")

	return (busoEnabled and busoEnabled.Value == true) or (haki and haki.Value == true)
end

local function canToggleBuso()
	local character = LocalPlayer.Character
	local flying = character and character:FindFirstChild("Flying")
	local flyingClient = character and character:FindFirstChild("FlyingClient")

	return not (flying and flying:IsA("BoolValue") and flying.Value)
		and not (flyingClient and flyingClient:IsA("BoolValue") and flyingClient.Value)
end

local function isObservationHakiActive()
	local observationHaki = getCharacterBool("ObservationHaki")
	local observationServer = PlayerGui:FindFirstChild("ObservationHaki_Server")
	local dodgeLeft = observationServer and observationServer:FindFirstChild("DodgeLeft")
	local obsDodges = LocalPlayer:GetAttribute("ObsDodges")

	return (observationHaki and observationHaki.Value == true)
		or (dodgeLeft and dodgeLeft:IsA("NumberValue") and dodgeLeft.Value > 0)
		or (type(obsDodges) == "number" and obsDodges > 0)
end

local function tryFireHakiRemote(key, remote)
	if not remote then
		setStatus("Auto" .. key .. "Haki", "missing_remote")

		return false
	end

	if tick() - (LastHakiAttempt[key] or 0) < Config.HakiRetryDelay then
		return false
	end

	LastHakiAttempt[key] = tick()

	local ok, result = pcall(function()
		remote:FireServer()
	end)

	setStatus("Auto" .. key .. "Haki", ok and "requested" or "failed")

	if ok then
		setStatus("Auto" .. key .. "HakiError", nil)
	else
		setStatus("Auto" .. key .. "HakiError", tostring(result))
	end

	return ok
end

local function ensureAutoHaki(target)
	if not Config.AutoHaki then
		return
	end

	if tick() - LastHakiCheck < Config.HakiCheckDelay then
		return
	end

	LastHakiCheck = tick()

	if Config.AutoBuso then
		local busoLevel = getBusoLevel()

		setStatus("BusoLevel", busoLevel)

		if busoLevel <= 0 then
			setStatus("AutoBusoHaki", "no_level")
		elseif isBusoActive() then
			setStatus("AutoBusoHaki", "active")
		elseif not canToggleBuso() then
			setStatus("AutoBusoHaki", "flying")
		else
			tryFireHakiRemote("Buso", getAbilityRemote("Buso"))
		end
	end

	if Config.AutoObservationHaki then
		local observationLevel = getObservationHakiLevel()

		setStatus("ObservationHakiLevel", observationLevel)

		if observationLevel <= 0 then
			setStatus("AutoObservationHaki", "no_level")
		elseif isObservationHakiActive() then
			setStatus("AutoObservationHaki", "active")
		else
			tryFireHakiRemote("Observation", getAbilityRemote("Observation"))
		end
	end

	if Config.AutoConquerorHaki then
		local conquerorLevel = getConquerorHakiLevel()

		setStatus("ConquerorHakiLevel", conquerorLevel)

		if conquerorLevel <= 0 then
			setStatus("AutoConquerorHaki", "no_level")
		elseif not target then
			setStatus("AutoConquerorHaki", "no_target")
		else
			tryFireHakiRemote("Conqueror", getAbilityRemote("Conqueror"))
		end
	end
end

local function getQuestFolder()
	local playerQuest = LocalPlayer:FindFirstChild("Quest")

	if playerQuest then
		return playerQuest
	end

	local handler = QuestGui:FindFirstChild("QuestHandler")

	return handler and handler:FindFirstChild("Quest") or nil
end

local function getQuestState()
	local quest = getQuestFolder()
	local npcName = getValue(quest, "NPCName", "")
	local rawObjective = getValue(quest, "Objective", "")
	local questName = getValue(quest, "QuestName", "")
	local objective = rawObjective

	if objective == "" then
		objective = npcName ~= "" and npcName or questName
	end

	return {
		NPCName = npcName,
		Objective = objective,
		RawObjective = rawObjective,
		QuestName = questName,
		GiverName = getValue(quest, "GiverName", ""),
		Progress = getValue(quest, "Progress", 0),
		Target = getValue(quest, "Target", 0)
	}
end

local function hasActiveQuest()
	local state = getQuestState()

	return state.NPCName ~= "" or state.Objective ~= "" or state.QuestName ~= ""
end

local function isSafePosition(position)
	return position and position.Y > Config.SafePositionFloor
end

local function getSafePart(instance)
	if not instance then
		return nil
	end

	if instance:IsA("BasePart") and isSafePosition(instance.Position) then
		return instance
	end

	if not instance:IsA("Model") then
		return nil
	end

	for _, partName in next, { "Clicker", "Quest", "HumanoidRootPart", "Head" } do
		local part = instance:FindFirstChild(partName)

		if part and part:IsA("BasePart") and isSafePosition(part.Position) then
			return part
		end
	end

	for _, child in next, instance:GetChildren() do
		if child:IsA("BasePart") and isSafePosition(child.Position) then
			return child
		end
	end

	return nil
end

local function getInstanceCFrame(instance)
	if not instance then
		return nil
	end

	if instance:IsA("BasePart") then
		return isSafePosition(instance.Position) and instance.CFrame or nil
	end

	if instance:IsA("Model") then
		local safePart = getSafePart(instance)

		if safePart then
			return safePart.CFrame
		end

		local ok, pivot = pcall(function()
			return instance:GetPivot()
		end)

		if ok and pivot and isSafePosition(pivot.Position) then
			return pivot
		end

		local primaryPart = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)

		return primaryPart and isSafePosition(primaryPart.Position) and primaryPart.CFrame or nil
	end

	return nil
end

local function setCharacterCFrame(cframe)
	local character, humanoid, root = getCharacter()

	if Config.NoClip then
		for _, part in next, character:GetChildren() do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	humanoid.PlatformStand = false
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	root.CFrame = cframe
end

local function getHoverCFrame(targetRoot)
	local hoverPosition = targetRoot.Position + Vector3.new(0, Config.HoverHeight, 0)

	return CFrame.new(hoverPosition) * CFrame.Angles(math.rad(-90), 0, 0)
end

local function travelToCFrame(destination)
	if not destination then
		return false
	end

	if not Config.SmoothTravel then
		setCharacterCFrame(destination)
		return true
	end

	CurrentTraveling = true

	local _, humanoid, root = getCharacter()
	local reached = false

	while isRunning() and humanoid.Health > 0 do
		local delta = destination.Position - root.Position
		local distance = delta.Magnitude

		if distance <= Config.TeleportDistance then
			reached = true
			break
		end

		local step = Config.TravelSpeed * Config.TravelStepDelay

		if Config.FastTravel then
			step = math.min(distance, Config.TravelMaxStep, step)
		else
			step = math.min(distance, step)
		end

		local nextPosition = root.Position + delta.Unit * step

		setCharacterCFrame(CFrame.new(nextPosition, destination.Position))
		task.wait(Config.TravelStepDelay)
	end

	if reached then
		setCharacterCFrame(destination)
	end

	CurrentTraveling = false

	return reached
end

local function moveNearInstance(instance)
	local cframe = getInstanceCFrame(instance)

	if cframe then
		return travelToCFrame(cframe + Vector3.new(0, Config.HoverHeight, 0))
	end

	return false
end

local function buildQuestCache()
	local quests = {}

	for _, giver in next, QuestGivers:GetChildren() do
		local configuration = giver:FindFirstChild("Configuration")
		local questRoot = configuration and configuration:FindFirstChild("Quests")

		if questRoot then
			for _, levelFolder in next, questRoot:GetChildren() do
				local level = tonumber(levelFolder.Name:match("%d+"))

				if level then
					for _, objectiveFolder in next, levelFolder:GetChildren() do
						local numberValue = objectiveFolder:FindFirstChild("Number")

						if objectiveFolder:IsA("Folder") and numberValue then
							local requiredKills = tonumber(numberValue.Value) or 0
							local objectiveName = tostring(objectiveFolder.Name)
							local objectiveKey = objectiveName:lower()

							table.insert(quests, {
								Level = level,
								LevelName = levelFolder.Name,
								Giver = giver,
								MobName = objectiveName,
								RequiredKills = requiredKills,
								IsBoss = BossQuestNames[objectiveKey] == true
									or objectiveKey:find("boss", 1, true) ~= nil
									or (Config.BossQuestKillThreshold > 0 and requiredKills > 0 and requiredKills <= Config.BossQuestKillThreshold)
							})
						end
					end
				end
			end
		end
	end

	table.sort(quests, function(left, right)
		if left.Level == right.Level then
			return left.MobName < right.MobName
		end

		return left.Level > right.Level
	end)

	return quests
end

local function getQuestCache(force)
	if force or #QuestCache == 0 or tick() - LastQuestCacheBuild > 30 then
		QuestCache = buildQuestCache()
		LastQuestCacheBuild = tick()
	end

	return QuestCache
end

local function selectQuestForLevel(level)
	for _, quest in next, getQuestCache(false) do
		if quest.Level <= level then
			return quest
		end
	end

	return nil
end

local function isBossQuest(quest)
	if not quest then
		return false
	end

	local mobName = tostring(quest.MobName or "")
	local requiredKills = tonumber(quest.RequiredKills) or 0

	return quest.IsBoss == true
		or BossQuestNames[mobName:lower()] == true
		or mobName:lower():find("boss", 1, true) ~= nil
		or (Config.BossQuestKillThreshold > 0 and requiredKills > 0 and requiredKills <= Config.BossQuestKillThreshold)
end

local function isSameQuest(left, right)
	return left and right and left.Level == right.Level and left.MobName == right.MobName and left.Giver == right.Giver
end

local function getFallbackQuestForBoss(bossQuest)
	if not bossQuest then
		return nil
	end

	local fallback = nil
	local unavailableFallback = nil

	local function canUseFallbackQuest(quest)
		if not Config.BossFallbackRequireSpawnedMob then
			return true
		end

		local target = findMob(quest.MobName)

		setStatus("LastFallbackProbe", quest.MobName)
		setStatus("LastFallbackProbeFound", target and target.Name or nil)

		return target ~= nil
	end

	if Config.BossFallbackSameGiver then
		for _, quest in next, getQuestCache(false) do
			if quest.Level < bossQuest.Level and quest.Giver == bossQuest.Giver and not isBossQuest(quest) then
				if canUseFallbackQuest(quest) then
					setStatus("LastFallbackQuest", quest.LevelName .. " " .. quest.MobName)
					return quest
				end

				unavailableFallback = unavailableFallback or quest
			end
		end
	end

	for _, quest in next, getQuestCache(false) do
		if quest.Level < bossQuest.Level and not isBossQuest(quest) then
			if canUseFallbackQuest(quest) then
				fallback = quest
				setStatus("LastFallbackQuest", quest.LevelName .. " " .. quest.MobName)
				break
			end

			unavailableFallback = unavailableFallback or quest
		end
	end

	if fallback then
		return fallback
	end

	debugPrint("No spawned fallback mob found, using configured fallback:", unavailableFallback and unavailableFallback.MobName or "none")
	setStatus("LastFallbackQuest", unavailableFallback and (unavailableFallback.LevelName .. " " .. unavailableFallback.MobName) or nil)

	return unavailableFallback
end

local function selectFarmQuest(level)
	local quest = selectQuestForLevel(level)

	if not Config.BossFallback or not isBossQuest(quest) then
		return quest, nil
	end

	local bossTarget = findMob(quest.MobName)

	if bossTarget then
		setStatus("LastFarmQuestReason", "boss_spawned")
		return quest, "boss_spawned"
	end

	local fallback = getFallbackQuestForBoss(quest)

	if fallback then
		debugPrint("Boss not spawned, using fallback:", quest.MobName, "->", fallback.MobName)
		setStatus("LastFarmQuestReason", "boss_wait_fallback")

		return fallback, "boss_wait_fallback"
	end

	setStatus("LastFarmQuestReason", "boss_no_fallback")

	return quest, "boss_no_fallback"
end

local function getActiveBossFallbackObjective(quest)
	if not Config.BossFallback or not Config.BossFallbackFarmWithoutCancel or not isBossQuest(quest) then
		ActiveBossFallbackQuest = nil

		return nil
	end

	local bossTarget = findMob(quest.MobName)

	if bossTarget then
		BossMissingSince = 0
		ActiveBossFallbackQuest = nil
		setStatus("BossFallbackMode", "boss_spawned")
		setStatus("ActiveBossFallbackQuest", nil)

		return nil
	end

	if BossMissingSince == 0 then
		BossMissingSince = tick()
	end

	if tick() - BossMissingSince < Config.BossMissingCancelDelay then
		return nil
	end

	local fallbackQuest = getFallbackQuestForBoss(quest)

	if not fallbackQuest then
		ActiveBossFallbackQuest = nil
		setStatus("BossFallbackMode", "boss_wait_no_fallback")
		setStatus("ActiveBossFallbackQuest", nil)

		return nil
	end

	ActiveBossFallbackQuest = fallbackQuest
	setStatus("BossFallbackMode", "active_boss_wait_fallback")
	setStatus("ActiveBossQuest", quest.LevelName .. " " .. quest.MobName)
	setStatus("ActiveBossFallbackQuest", fallbackQuest.LevelName .. " " .. fallbackQuest.MobName)

	return fallbackQuest.MobName, fallbackQuest
end

local function findQuestByObjective(objective)
	if objective == "" then
		return nil
	end

	local best = nil

	for _, quest in next, getQuestCache(false) do
		if quest.MobName == objective and quest.Level <= getLevel() then
			if not best or quest.Level > best.Level then
				best = quest
			end
		end
	end

	return best
end

local function acceptQuest(quest)
	if not quest then
		return false, "NoQuest"
	end

	moveNearInstance(quest.Giver)
	task.wait(0.25)

	local ok, result = pcall(function()
		return QuestFunction:InvokeServer(quest.Giver, quest.LevelName)
	end)

	if not ok then
		return false, result
	end

	if result == true or result == "AlreadyOnQuest" then
		for _ = 1, 20 do
			local state = getQuestState()

			if state.Objective ~= "" or hasActiveQuest() then
				return true, result
			end

			task.wait(0.15)
		end
	end

	return result == true, result
end

local function getQuestCloseButton()
	local mainFrame = QuestGui:FindFirstChild("MainFrame")

	return mainFrame and mainFrame:FindFirstChild("CloseButton") or nil
end

local function clickGuiButton(button)
	if not button or not button:IsA("GuiButton") then
		return false
	end

	local clicked = false

	pcall(function()
		if typeof(firesignal) == "function" then
			firesignal(button.MouseButton1Click)
			firesignal(button.Activated)
			clicked = true
		end
	end)

	pcall(function()
		if typeof(getconnections) == "function" then
			for _, signal in next, { button.MouseButton1Click, button.Activated } do
				for _, connection in next, getconnections(signal) do
					pcall(function()
						connection:Fire()
					end)
					clicked = true
				end
			end
		end
	end)

	pcall(function()
		button:Activate()
		clicked = true
	end)

	if VirtualInputManager and button.AbsoluteSize.X > 0 and button.AbsoluteSize.Y > 0 then
		pcall(function()
			local center = button.AbsolutePosition + (button.AbsoluteSize / 2)

			VirtualInputManager:SendMouseMoveEvent(center.X, center.Y, game)
			task.wait(0.03)
			VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 1)
			task.wait(0.05)
			VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 1)
			clicked = true
		end)
	end

	return clicked
end

local function waitForQuestClear(timeout)
	local started = tick()

	while tick() - started < timeout do
		if not hasActiveQuest() then
			return true
		end

		task.wait(0.1)
	end

	return not hasActiveQuest()
end

local function cancelActiveQuest(reason)
	if not hasActiveQuest() then
		return true, "NoActiveQuest"
	end

	if tick() - LastQuestCancelAttempt < Config.QuestCancelRetryDelay then
		return false, "Cooldown"
	end

	LastQuestCancelAttempt = tick()

	local closeButton = getQuestCloseButton()

	if not closeButton then
		return false, "NoCloseButton"
	end

	debugPrint("Cancel quest", reason or "manual")

	if not clickGuiButton(closeButton) then
		return false, "ClickFailed"
	end

	if waitForQuestClear(Config.QuestCancelWait) then
		return true, "Canceled"
	end

	return false, "StillActive"
end

local function getSpawnedBossForFallback(level, activeQuest)
	if not Config.BossFallback or not Config.BossFallbackSwitchToBoss then
		return nil
	end

	if tick() - LastBossFallbackCheck < Config.BossFallbackCheckDelay then
		return nil
	end

	LastBossFallbackCheck = tick()

	local bossQuest = selectQuestForLevel(level)

	if not isBossQuest(bossQuest) or not activeQuest or isSameQuest(activeQuest, bossQuest) or isBossQuest(activeQuest) then
		return nil
	end

	if activeQuest.Level >= bossQuest.Level then
		return nil
	end

	return findMob(bossQuest.MobName) and bossQuest or nil
end

local function getHumanoid(model)
	return model and model:FindFirstChildWhichIsA("Humanoid", true) or nil
end

local function getRootPart(model)
	if not model then
		return nil
	end

	return model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
end

local function trimName(name)
	name = tostring(name or "")
	name = name:gsub("^%s+", "")
	name = name:gsub("%s+$", "")

	return name
end

local function getMobName(model)
	local npcName = model and model:FindFirstChild("NPCName")

	if npcName and npcName:IsA("StringValue") and npcName.Value ~= "" then
		return npcName.Value
	end

	local monsterName = model and model:GetAttribute("Monster")

	if typeof(monsterName) == "string" and monsterName ~= "" then
		return monsterName
	end

	return model and model.Name:gsub("%d+$", "") or ""
end

local function matchesMob(model, targetName)
	local target = trimName(targetName)

	if target == "" or not model then
		return false
	end

	local mobName = trimName(getMobName(model))

	if mobName == target then
		return true
	end

	local strippedName = trimName(model.Name:gsub("%d+$", ""))

	if strippedName == target then
		return true
	end

	if model.Name:sub(1, #target) == target then
		local nextCharacter = model.Name:sub(#target + 1, #target + 1)

		return nextCharacter == "" or tonumber(nextCharacter) ~= nil
	end

	return false
end

local function isAliveMob(model)
	local humanoid = getHumanoid(model)

	return model and model:IsDescendantOf(workspace) and humanoid and humanoid.Health > 0
end

local function refreshNpcContainers(force)
	if not force and #NpcContainers > 0 and tick() - LastContainerScan < Config.ContainerRefreshDelay then
		return
	end

	NpcContainers = {}
	LastContainerScan = tick()

	local function scan(container, depth)
		if depth > 6 then
			return
		end

		for _, child in next, container:GetChildren() do
			if child.Name == "NPCS" then
				table.insert(NpcContainers, child)
			end

			if child:IsA("Folder") or child:IsA("Model") then
				scan(child, depth + 1)
			end
		end
	end

	scan(NpcZones, 0)
end

findMob = function(targetName)
	refreshNpcContainers(false)

	local _, _, playerRoot = getCharacter()
	local closestMob = nil
	local closestDistance = math.huge

	for _, container in next, NpcContainers do
		if container and container:IsDescendantOf(workspace) then
			for _, model in next, container:GetChildren() do
				if model:IsA("Model") and matchesMob(model, targetName) and isAliveMob(model) then
					local root = getRootPart(model)

					if root then
						local distance = (root.Position - playerRoot.Position).Magnitude

						if distance < closestDistance then
							closestDistance = distance
							closestMob = model
						end
					end
				end
			end
		end
	end

	return closestMob
end

local function getToolScore(tool)
	if not tool or not tool:IsA("Tool") then
		return -math.huge
	end

	if Config.PreferTool and tool.Name == Config.PreferTool then
		return 1000
	end

	if not Config.PreferMelee then
		return 1
	end

	if tool:FindFirstChild("SwordServer", true) or tool:FindFirstChild("SwordClient", true) then
		return 100
	end

	if tool.Name == "Combat" or tool:FindFirstChild("Combat_Server", true) or tool:FindFirstChild("Punch", true) then
		return 90
	end

	if tool:FindFirstChild("Activate", true) then
		return 25
	end

	return 10
end

local function getPreferredTool()
	local character, humanoid = getCharacter()
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	local equippedTool = character:FindFirstChildOfClass("Tool")

	if Config.PreferTool then
		if equippedTool and equippedTool.Name == Config.PreferTool then
			return equippedTool
		end

		local preferredTool = character:FindFirstChild(Config.PreferTool) or (backpack and backpack:FindFirstChild(Config.PreferTool))

		if preferredTool and preferredTool:IsA("Tool") then
			humanoid:EquipTool(preferredTool)
			task.wait(0.08)

			return preferredTool
		end
	end

	local bestTool = equippedTool
	local bestScore = getToolScore(equippedTool)

	if backpack then
		for _, tool in next, backpack:GetChildren() do
			local score = getToolScore(tool)

			if score > bestScore then
				bestTool = tool
				bestScore = score
			end
		end
	end

	if bestTool and bestTool.Parent == backpack then
		humanoid:EquipTool(bestTool)
		task.wait(0.08)

		return bestTool
	end

	if bestTool then
		return bestTool
	end

	if equippedTool then
		return equippedTool
	end

	if backpack then
		for _, tool in next, backpack:GetChildren() do
			if tool:IsA("Tool") then
				humanoid:EquipTool(tool)
				task.wait(0.08)

				return tool
			end
		end
	end

	return character:FindFirstChildOfClass("Tool")
end

local function updateToolMouse(tool, targetRoot)
	local remote = tool and tool:FindFirstChild("UpdateMousePosition", true)

	if remote and remote:IsA("RemoteEvent") then
		pcall(function()
			remote:FireServer(targetRoot.Position)
		end)
	end
end

local function attackTarget(target)
	if tick() - LastAttack < Config.AttackDelay then
		return
	end

	local targetRoot = getRootPart(target)

	if not targetRoot then
		return
	end

	LastAttack = tick()

	ensureAutoHaki(target)

	local tool = getPreferredTool()

	if tool then
		for attackIndex = 1, Config.AttackBurst do
			updateToolMouse(tool, targetRoot)
			pcall(function()
				tool:Activate()
			end)

			if attackIndex < Config.AttackBurst then
				task.wait(Config.AttackBurstDelay)
			end
		end
	end
end

local function antiAfkPulse(reason)
	if not Config.AntiAfk then
		return
	end

	if tick() - LastAntiAfkPulse < 5 then
		return
	end

	LastAntiAfkPulse = tick()

	pcall(function()
		VirtualUser:CaptureController()
	end)

	pcall(function()
		local camera = workspace.CurrentCamera
		local cameraCFrame = camera and camera.CFrame or CFrame.new()

		VirtualUser:Button2Down(Vector2.new(0, 0), cameraCFrame)
		task.wait(0.15)
		VirtualUser:Button2Up(Vector2.new(0, 0), cameraCFrame)
	end)

	debugPrint("Anti-AFK pulse", reason or "timer")
end

table.insert(Connections, LocalPlayer.Idled:Connect(function()
	antiAfkPulse("idled")
end))

task.spawn(function()
	while isRunning() do
		task.wait(Config.AntiAfkInterval)
		antiAfkPulse("interval")
	end
end)

task.spawn(autoUpgradeStats)

table.insert(Connections, RunService.Heartbeat:Connect(function()
	if not isRunning() then
		return
	end

	if CurrentTraveling then
		return
	end

	if CurrentTarget and isAliveMob(CurrentTarget) then
		local targetRoot = getRootPart(CurrentTarget)

		if targetRoot then
			local _, _, root = getCharacter()
			local distance = (root.Position - targetRoot.Position).Magnitude

			if distance > Config.DirectLockDistance then
				return
			end

			setCharacterCFrame(getHoverCFrame(targetRoot))
		end
	end
end))

_G.HazeSeasAutoFarmCleanup = function()
	Config.Enabled = false
	_G.AutoFarmLevel = false
	CurrentTarget = nil

	for _, connection in next, Connections do
		pcall(function()
			connection:Disconnect()
		end)
	end
end

assert(type(selectQuestForLevel) == "function", "quest selector missing")
assert(type(selectFarmQuest) == "function", "farm quest selector missing")
assert(type(findMob) == "function", "mob finder missing")
assert(type(cancelActiveQuest) == "function", "quest cancel helper missing")

task.spawn(function()
	refreshNpcContainers(true)
	getQuestCache(true)
	debugPrint("Loaded. Level:", getLevel(), "Quests:", #QuestCache)
	setStatus("Loaded", true)
	setStatus("QuestCount", #QuestCache)

	while isRunning() do
		local character, humanoid, root = getCharacter()

		if humanoid.Health <= 0 then
			CurrentTarget = nil
			setStatus("State", "dead_wait")
			task.wait(3)
		else
			local level = getLevel()
			local questState = getQuestState()
			local objective = questState.Objective
			setStatus("Level", level)
			setStatus("ActiveObjective", objective)
			setStatus("ActiveNPCName", questState.NPCName)
			setStatus("ActiveQuestName", questState.QuestName)
			setStatus("ActiveProgress", questState.Progress)
			setStatus("ActiveTarget", questState.Target)
			ensureAutoHaki(CurrentTarget)

			-- Detect quest completion: Progress >= Target means quest is done
			local questCompleted = objective ~= "" and questState.Target > 0 and questState.Progress >= questState.Target
			if questCompleted then
				debugPrint("Quest completed!", objective, questState.Progress, "/", questState.Target, "- going to turn in")
				-- Move to the quest giver to turn in
				local turnInQuest = CurrentQuest or findQuestByObjective(objective)
				if turnInQuest then
					moveNearInstance(turnInQuest.Giver)
					task.wait(0.5)
				end
				-- Clear state to force re-accept
				CurrentTarget = nil
				CurrentQuest = nil
				PreviousObjective = ""
				objective = ""
				-- Wait for server to clear quest state
				for _ = 1, 30 do
					if not hasActiveQuest() then
						debugPrint("Quest turned in successfully")
						break
					end
					task.wait(0.2)
				end
			end

			-- Detect objective change: reset target when quest switches
			if objective ~= PreviousObjective then
				if PreviousObjective ~= "" and objective ~= "" then
					debugPrint("Quest changed:", PreviousObjective, "->", objective)
				end
				CurrentTarget = nil
				LastTargetSearch = 0
				refreshNpcContainers(true)
				PreviousObjective = objective
			end

			if objective == "" then
				local questReason = nil

				CurrentQuest, questReason = selectFarmQuest(level)
				setStatus("SelectedQuest", CurrentQuest and (CurrentQuest.LevelName .. " " .. CurrentQuest.MobName) or nil)
				setStatus("SelectedQuestReason", questReason or "normal")

				if CurrentQuest and tick() - LastQuestAttempt >= Config.QuestRetryDelay then
					LastQuestAttempt = tick()
					setStatus("LastAcceptQuest", CurrentQuest.LevelName .. " " .. CurrentQuest.MobName)

					local accepted, result = acceptQuest(CurrentQuest)
					setStatus("LastAcceptAccepted", accepted)
					setStatus("LastAcceptResult", tostring(result))
					debugPrint("Quest", CurrentQuest.LevelName, CurrentQuest.MobName, questReason or "normal", accepted, result)

					if accepted then
						task.wait(0.35)
						questState = getQuestState()
						objective = questState.Objective ~= "" and questState.Objective or CurrentQuest.MobName
						PreviousObjective = objective
						BossMissingSince = 0
					else
						moveNearInstance(CurrentQuest.Giver)
						objective = CurrentQuest.MobName
					end
				elseif CurrentQuest then
					objective = CurrentQuest.MobName
				else
					CurrentTarget = nil
					warn("[HazeSeas AutoFarm] No quest found for level", level)
					task.wait(2)
				end
			else
				CurrentQuest = findQuestByObjective(objective) or CurrentQuest

				local spawnedBossQuest = getSpawnedBossForFallback(level, CurrentQuest)

				if spawnedBossQuest then
					local canceled, cancelResult = cancelActiveQuest("boss spawned: " .. spawnedBossQuest.MobName)
					debugPrint("Switch fallback to boss", spawnedBossQuest.MobName, canceled, cancelResult)

					if canceled then
						CurrentQuest = nil
						CurrentTarget = nil
						PreviousObjective = ""
						questState = getQuestState()
						objective = questState.Objective
					end
				end

				local fallbackObjective = getActiveBossFallbackObjective(CurrentQuest)

				if fallbackObjective then
					objective = fallbackObjective
					setStatus("SelectedQuestReason", "active_boss_wait_fallback")

					if objective ~= PreviousObjective then
						CurrentTarget = nil
						LastTargetSearch = 0
						refreshNpcContainers(true)
						PreviousObjective = objective
					end
				end
			end

			if objective ~= "" then
				if not CurrentTarget or not isAliveMob(CurrentTarget) or not matchesMob(CurrentTarget, objective) or tick() - LastTargetSearch >= Config.TargetRefreshDelay then
					CurrentTarget = findMob(objective)
					LastTargetSearch = tick()
					setStatus("LastTargetSearch", objective)
					setStatus("LastTargetFound", CurrentTarget and CurrentTarget.Name or nil)
					setStatus("LastTargetPath", CurrentTarget and CurrentTarget:GetFullName() or nil)
				end

				if CurrentTarget and isAliveMob(CurrentTarget) then
					setStatus("State", "farming")
					local targetRoot = getRootPart(CurrentTarget)

					if targetRoot then
						local targetCFrame = getHoverCFrame(targetRoot)
						local distance = (root.Position - targetRoot.Position).Magnitude

						if distance > Config.DirectLockDistance then
							travelToCFrame(targetCFrame)
						elseif distance > Config.TeleportDistance then
							setCharacterCFrame(targetCFrame)
						end

						attackTarget(CurrentTarget)
					end
				else
					setStatus("State", "target_missing")
					setStatus("LastMissingTarget", objective)
					if CurrentQuest and isBossQuest(CurrentQuest) then
						if BossMissingSince == 0 then
							BossMissingSince = tick()
						end

						local fallbackQuest = getFallbackQuestForBoss(CurrentQuest)

						if fallbackQuest and tick() - BossMissingSince >= Config.BossMissingCancelDelay then
							local canceled, cancelResult = cancelActiveQuest("boss missing: " .. CurrentQuest.MobName)
							debugPrint("Switch boss to fallback", CurrentQuest.MobName, "->", fallbackQuest.MobName, canceled, cancelResult)

							if canceled then
								CurrentQuest = nil
								CurrentTarget = nil
								PreviousObjective = ""
								BossMissingSince = 0
								objective = ""
							end
						end
					else
						BossMissingSince = 0
						ActiveBossFallbackQuest = nil
					end

					local questForMove = ActiveBossFallbackQuest or CurrentQuest or selectFarmQuest(level)

					if questForMove then
						moveNearInstance(questForMove.Giver)
					end

					task.wait(0.5)
				end
			end

			task.wait(Config.LoopDelay)
		end
	end

	CurrentTarget = nil
	debugPrint("Stopped")
end)
