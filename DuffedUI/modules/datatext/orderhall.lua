local D, C, L = unpack(select(2, ...)) 
if not C["datatext"].orderhall or C["datatext"].orderhall == 0 then return end

--[[Variables]]--
local format = string.format
local tsort = table.sort
local GetMouseFocus = GetMouseFocus
local C_GarrisonRequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local C_GarrisonGetBuildings = C_Garrison.GetBuildings
local C_GarrisonGetInProgressMissions = C_Garrison.GetInProgressMissions
local C_GarrisonGetLandingPageShipmentInfo = C_Garrison.GetLandingPageShipmentInfo
local GARRISON_LANDING_SHIPMENT_COUNT = GARRISON_LANDING_SHIPMENT_COUNT
local COMPLETE = COMPLETE
local LE_FOLLOWER_TYPE_GARRISON_6_0 = LE_FOLLOWER_TYPE_GARRISON_6_0
local LE_FOLLOWER_TYPE_GARRISON_7_0 = LE_FOLLOWER_TYPE_GARRISON_7_0
local LE_FOLLOWER_TYPE_SHIPYARD_6_2 = LE_FOLLOWER_TYPE_SHIPYARD_6_2
local C_Garrison_GetCompleteTalent = C_Garrison.GetCompleteTalent
local C_Garrison_GetFollowerShipments = C_Garrison.GetFollowerShipments
local C_Garrison_GetInProgressMissions = C_Garrison.GetInProgressMissions
local C_Garrison_GetLandingPageShipmentInfoByContainerID = C_Garrison.GetLandingPageShipmentInfoByContainerID
local C_Garrison_GetLooseShipments = C_Garrison.GetLooseShipments
local C_Garrison_GetTalentTreeIDsByClassID = C_Garrison.GetTalentTreeIDsByClassID
local C_Garrison_GetTalentTreeInfoForID = C_Garrison.GetTalentTreeInfoForID
local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local C_Garrison_RequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local GetCurrencyInfo = GetCurrencyInfo
local GetMouseFocus = GetMouseFocus
local HideUIPanel = HideUIPanel
local ShowGarrisonLandingPage = ShowGarrisonLandingPage
local UnitClass = UnitClass
local CAPACITANCE_WORK_ORDERS = CAPACITANCE_WORK_ORDERS
local COMPLETE = COMPLETE
local FOLLOWERLIST_LABEL_TROOPS = FOLLOWERLIST_LABEL_TROOPS
local GARRISON_LANDING_SHIPMENT_COUNT = GARRISON_LANDING_SHIPMENT_COUNT
local GARRISON_TALENT_ORDER_ADVANCEMENT = GARRISON_TALENT_ORDER_ADVANCEMENT
local LE_FOLLOWER_TYPE_GARRISON_7_0 = LE_FOLLOWER_TYPE_GARRISON_7_0
local LE_GARRISON_TYPE_7_0 = LE_GARRISON_TYPE_7_0
local ORDER_HALL_MISSIONS = ORDER_HALL_MISSIONS
local f, fs, ff = C["media"]["font"], 11, "THINOUTLINE"

local Stat = CreateFrame("Frame", "DuffedUIStatgarrison")
Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
--Stat:RegisterEvent("GET_ITEM_INStatO_RECEIVED")
Stat:RegisterEvent("GARRISON_MISSION_LIST_UPDATE")
Stat:RegisterEvent("GARRISON_MISSION_STARTED")
Stat:RegisterEvent("GARRISON_MISSION_FINISHED")
Stat:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
Stat:RegisterEvent("GARRISON_LANDINGPAGE_SHIPMENTS")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat.Option = C["datatext"].orderhall
Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

local Text  = Stat:CreateFontString("DuffedUIStatgarrisonText", "OVERLAY")
Text:SetFont(f, fs, ff)
D.DataTextPosition(C["datatext"].orderhall, Text)

local function sortFunction(a, b) return a.missionEndTime < b.missionEndTime end

local function Update(self, event)
	if not GarrisonMissionFrame then LoadAddOn("Blizzard_GarrisonUI") end
	if not OrderHallMissionFrame then LoadAddOn("Blizzard_OrderHallUI") end
	
	local Missions = {}
	C_GarrisonGetInProgressMissions(Missions, LE_FOLLOWER_TYPE_GARRISON_7_0)
	local CountInProgress = 0
	local CountCompleted = 0
	
	for i = 1, #Missions do
		if Missions[i].inProgress then
			local TimeLeft = Missions[i].timeLeft:match("%d")
			if (TimeLeft ~= "0") then CountInProgress = CountInProgress + 1 else CountCompleted = CountCompleted + 1 end
		end
	end

	if (CountInProgress > 0) then Text:SetText(Stat.Color1 .. format(L["dt"]["noorderhallwo"], CountCompleted, #Missions)) else Text:SetText(Stat.Color2 ..(L["dt"]["noorderhallnowo"])) end	
	self:SetAllPoints(Text)
end

Stat:SetScript("OnEnter", function(self)
if InCombatLockdown() then return end
	
	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	
	if not (C_Garrison_HasGarrison(LE_GARRISON_TYPE_7_0)) then return GameTooltip:AddLine(L["dt"]["noorderhall"]) end	
	
	--[[Loose Work Orders]]--
	local looseShipments = C_Garrison_GetLooseShipments(LE_GARRISON_TYPE_7_0)	
	if (looseShipments) then
		GameTooltip:AddLine(CAPACITANCE_WORK_ORDERS)
		for i = 1, #looseShipments do
			local name, _, _, shipmentsReady, shipmentsTotal = C_Garrison_GetLandingPageShipmentInfoByContainerID(looseShipments[i])
			GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
		end
	end
	
	--[[Orderhall Missions]]--
	local inProgressMissions = {}
	C_Garrison_GetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_7_0)
	local numMissions = #inProgressMissions
	if(numMissions > 0) then
		tsort(inProgressMissions, sortFunction)

		if (looseShipments) then GameTooltip:AddLine(" ") end
		GameTooltip:AddLine(GARRISON_MISSIONS_TITLE)
		for i = 1, numMissions do
			local mission = inProgressMissions[i]
			local timeLeft = mission.timeLeft:match("%d")
			local r, g, b = 1, 1, 1
			if(mission.isRare) then r, g, b = .09, .51, .81 end
			if(timeLeft and timeLeft == "0") then GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0) else GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b) end
		end
	end
	
	--[[Troop Work Orders]]--
	local followerShipments = C_Garrison_GetFollowerShipments(LE_GARRISON_TYPE_7_0)
	local hasFollowers = false
	if (followerShipments) then
		for i = 1, #followerShipments do
			local name, _, _, shipmentsReady, shipmentsTotal = C_Garrison_GetLandingPageShipmentInfoByContainerID(followerShipments[i])
			if ( name and shipmentsReady and shipmentsTotal ) then
				if(hasFollowers == false) then
				if(numMissions > 0) then GameTooltip:AddLine(" ") end
					GameTooltip:AddLine(FOLLOWERLIST_LABEL_TROOPS)
					GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
					hasFollowers = true
				end
			end
		end
	end
	
	--[[Talents]]--
	local talentTreeIDs = C_Garrison_GetTalentTreeIDsByClassID(LE_GARRISON_TYPE_7_0, select(3, UnitClass("player")));
 	local hasTalent = false
	if talentTreeIDs then
		local completeTalentID = C_Garrison_GetCompleteTalent(LE_GARRISON_TYPE_7_0);
		for treeIndex, treeID in ipairs(talentTreeIDs) do
			local _, _, tree
			if D["build"] >= 24904 then
				_, _, tree = C_Garrison_GetTalentTreeInfoForID(treeID);
			else
				_, _, tree = C_Garrison_GetTalentTreeInfoForID(LE_GARRISON_TYPE_7_0, treeID);
			end
			for talentIndex, talent in ipairs(tree) do
				local showTalent = false
				if talent.isBeingResearched then showTalent = true end
				if talent.id == completeTalentID then showTalent = true end
				if showTalent then
					GameTooltip:AddLine(GARRISON_TALENT_ORDER_ADVANCEMENT)
					GameTooltip:AddDoubleLine(talent.name, format(GARRISON_LANDING_SHIPMENT_COUNT, talent.isBeingResearched and 0 or 1, 1), 1, 1, 1)
				end
			end
		end
	end	
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(TOKENS)
	GameTooltip:AddDoubleLine(D["Currency"](1220))
	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)	
Stat:SetScript("OnEvent", Update)
Stat:SetScript("OnMouseDown", function() 
	if not (C_Garrison_HasGarrison(LE_GARRISON_TYPE_7_0)) then return end

	local isShown = GarrisonLandingPage and GarrisonLandingPage:IsShown()
	if (not isShown) then
		ShowGarrisonLandingPage(LE_GARRISON_TYPE_7_0)
	elseif (GarrisonLandingPage) then
		local currentGarrType = GarrisonLandingPage.garrTypeID
		HideUIPanel(GarrisonLandingPage)
		if (currentGarrType ~= LE_GARRISON_TYPE_7_0) then
			ShowGarrisonLandingPage(LE_GARRISON_TYPE_7_0)
		end
	end
end)