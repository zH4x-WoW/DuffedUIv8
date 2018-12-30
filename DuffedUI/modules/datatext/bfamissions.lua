local D, C, L = unpack(select(2, ...)) 
if not C['datatext']['bfamissions'] or C['datatext']['bfamissions'] == 0 then return end

-- Variables
local format = string.format
local tsort = table.sort
local ipairs = ipairs
local C_Garrison_GetFollowerShipments = C_Garrison.GetFollowerShipments
local C_Garrison_GetInProgressMissions = C_Garrison.GetInProgressMissions
local C_Garrison_RequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local C_Garrison_GetLandingPageShipmentInfoByContainerID = C_Garrison.GetLandingPageShipmentInfoByContainerID
local C_Garrison_GetTalentTreeIDsByClassID = C_Garrison.GetTalentTreeIDsByClassID
local C_Garrison_GetTalentTreeInfoForID = C_Garrison.GetTalentTreeInfoForID
local C_Garrison_GetCompleteTalent = C_Garrison.GetCompleteTalent
local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local ShowGarrisonLandingPage = ShowGarrisonLandingPage
local HideUIPanel = HideUIPanel
local GetCurrencyInfo = GetCurrencyInfo
local GetMouseFocus = GetMouseFocus
local COMPLETE = COMPLETE
local RESEARCH_TIME_LABEL = RESEARCH_TIME_LABEL
local GARRISON_LANDING_SHIPMENT_COUNT = GARRISON_LANDING_SHIPMENT_COUNT
local FOLLOWERLIST_LABEL_TROOPS = FOLLOWERLIST_LABEL_TROOPS
local LE_FOLLOWER_TYPE_GARRISON_8_0 = LE_FOLLOWER_TYPE_GARRISON_8_0
local LE_GARRISON_TYPE_8_0 = LE_GARRISON_TYPE_8_0
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'

local Stat = CreateFrame('Frame', 'DuffedUIStatbfamissions')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
Stat:RegisterEvent('GARRISON_LANDINGPAGE_SHIPMENTS')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext']['bfamissions']
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local Text  = Stat:CreateFontString('DuffedUIStatbfamissionsText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['bfamissions'], Text)

local function sortFunction(a, b) return a.missionEndTime < b.missionEndTime end

local function Update(self, event)
	local Missions = {}
	
	C_Garrison_GetInProgressMissions(Missions, LE_FOLLOWER_TYPE_GARRISON_8_0)
	local CountInProgress = 0
	local CountCompleted = 0

	for i = 1, #Missions do
		if Missions[i].inProgress then
			local TimeLeft = Missions[i].timeLeft:match("%d")

			if (TimeLeft ~= "0") then CountInProgress = CountInProgress + 1 else CountCompleted = CountCompleted + 1 end
		end
	end

	if (CountInProgress > 0) then
		Text:SetText(Stat.Color1 .. format(L['dt']['missions'], CountCompleted, #Missions))
	else
		Text:SetText(Stat.Color2 ..(L['dt']['nomissions']))
	end
	self:SetAllPoints(Text)
end

Stat:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	
	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	
	C_Garrison_RequestLandingPageShipmentInfo()
	
	--Missions
	local inProgressMissions = {}
	C_Garrison_GetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_8_0)
	local numMissions = #inProgressMissions
	if (numMissions > 0) then
		tsort(inProgressMissions, sortFunction)
		firstLine = false
		
		GameTooltip:AddLine(L['dt']['report'])
		for i = 1, numMissions do
			local mission = inProgressMissions[i]
			local timeLeft = mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if (mission.isRare) then r, g, b = 0.09, 0.51, 0.81 end

			if (timeLeft and timeLeft == "0") then
				GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0)
			else
				GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b)
			end
		end
	end

	-- Troop Work Orders
	local followerShipments = C_Garrison_GetFollowerShipments(LE_GARRISON_TYPE_8_0)
	local hasFollowers = false
	if (followerShipments) then
		for i = 1, #followerShipments do
			local name, _, _, shipmentsReady, shipmentsTotal = C_Garrison_GetLandingPageShipmentInfoByContainerID(followerShipments[i])
			if (name and shipmentsReady and shipmentsTotal) then
				if (hasFollowers == false) then
					if not firstLine then GameTooltip:AddLine(' ') end
					firstLine = false
					GameTooltip:AddLine(FOLLOWERLIST_LABEL_TROOPS)
					hasFollowers = true
				end

				GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
			end
		end
	end

	-- Talents
	local talentTreeIDs = C_Garrison_GetTalentTreeIDsByClassID(LE_GARRISON_TYPE_8_0, select(3, UnitClass('player')))
	local hasTalent = false
	if (talentTreeIDs) then
		local completeTalentID = C_Garrison_GetCompleteTalent(LE_GARRISON_TYPE_8_0)
		for _, treeID in ipairs(talentTreeIDs) do
			local _, _, tree = C_Garrison_GetTalentTreeInfoForID(treeID)
			for _, talent in ipairs(tree) do
				local showTalent = false
				if (talent.isBeingResearched) then
					showTalent = true
				end
				if (talent.id == completeTalentID) then
					showTalent = true
				end
				if (showTalent) then
					if not firstLine then GameTooltip:AddLine(' ') end
					firstLine = false
					GameTooltip:AddLine(RESEARCH_TIME_LABEL)
					GameTooltip:AddDoubleLine(talent.name, format(GARRISON_LANDING_SHIPMENT_COUNT, talent.isBeingResearched and 0 or 1, 1), 1, 1, 1)
					hasTalent = true
				end
			end
		end
	end

	-- Island Expeditions
	local hasIsland = false
	if (UnitLevel('player') >= GetMaxLevelForExpansionLevel(LE_EXPANSION_BATTLE_FOR_AZEROTH)) then
		local questID = C_IslandsQueue_GetIslandsWeeklyQuestID() or nil
		if questID then
			local _, _, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
			local text = ''
			local r1, g1 ,b1

			if finished or IsQuestFlaggedCompleted(questID) then
				text = GOAL_COMPLETED
				r1, g1, b1 = GREEN_FONT_COLOR:GetRGB()
			else
				text = ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS:format(numFulfilled, numRequired)
				r1, g1, b1 = selectioncolor
			end
			if not firstLine then GameTooltip:AddLine(' ') end
			firstLine = false
			GameTooltip:AddLine(ISLANDS_HEADER..":")
			GameTooltip:AddDoubleLine(ISLANDS_QUEUE_FRAME_TITLE, text, 1, 1, 1, r1, g1, b1)
			hasIsland = true
		end
	end

	if not firstLine then GameTooltip:AddLine(' ') end

	GameTooltip:AddLine(TOKENS)
	GameTooltip:AddDoubleLine(D['Currency'](1560))
	GameTooltip:Show()
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)	
Stat:SetScript('OnEvent', Update)
Stat:SetScript('OnMouseDown', function() 
	if not (C_Garrison_HasGarrison(LE_GARRISON_TYPE_8_0)) then return end

	local isShown = GarrisonLandingPage and GarrisonLandingPage:IsShown()
	if (not isShown) then
		ShowGarrisonLandingPage(LE_GARRISON_TYPE_8_0)
	elseif (GarrisonLandingPage) then
		local currentGarrType = GarrisonLandingPage.garrTypeID
		HideUIPanel(GarrisonLandingPage)
		if (currentGarrType ~= LE_GARRISON_TYPE_8_0) then
			ShowGarrisonLandingPage(LE_GARRISON_TYPE_8_0)
		end
	end
end)