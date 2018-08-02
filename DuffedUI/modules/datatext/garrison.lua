local D, C, L = unpack(select(2, ...)) 
if not C['datatext']['garrison'] or C['datatext']['garrison'] == 0 then return end

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
local LE_FOLLOWER_TYPE_SHIPYARD_6_2 = LE_FOLLOWER_TYPE_SHIPYARD_6_2
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'

local Stat = CreateFrame('Frame', 'DuffedUIStatgarrison')
Stat:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
Stat:RegisterEvent('GET_ITEM_INFO_RECEIVED')
Stat:RegisterEvent('GARRISON_MISSION_LIST_UPDATE')
Stat:RegisterEvent('GARRISON_MISSION_STARTED')
Stat:RegisterEvent('GARRISON_MISSION_FINISHED')
Stat:RegisterEvent('GARRISON_MISSION_COMPLETE_RESPONSE')
Stat:RegisterEvent('GARRISON_LANDINGPAGE_SHIPMENTS')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext'].garrison
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local Text  = Stat:CreateFontString('DuffedUIStatgarrisonText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext'].garrison, Text)

local function sortFunction(a, b) return a.missionEndTime < b.missionEndTime end

local function Update(self, event)
	if not GarrisonMissionFrame then LoadAddOn('Blizzard_GarrisonUI') end
	
	local Missions = {}
	C_GarrisonGetInProgressMissions(Missions, LE_FOLLOWER_TYPE_GARRISON_6_0)
	local CountInProgress = 0
	local CountCompleted = 0
	
	for i = 1, #Missions do
		if Missions[i].inProgress then
			local TimeLeft = Missions[i].timeLeft:match('%d')
			
			if (TimeLeft ~= '0') then CountInProgress = CountInProgress + 1 else CountCompleted = CountCompleted + 1 end
		end
	end

	if (CountInProgress > 0) then Text:SetText(Stat.Color1 .. format(GARRISON_MISSIONS, CountCompleted, #Missions)) else Text:SetText(Stat.Color2 ..('Garrison')) end	
	self:SetAllPoints(Text)
end

Stat:SetScript('OnEnter', function(self)
if InCombatLockdown() then return end
	
	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	--Buildings
	local buildings = C_GarrisonGetBuildings(LE_GARRISON_TYPE_6_0);
	local numBuildings = #buildings
	local hasBuilding = false
	if(numBuildings > 0) then
		for i = 1, #buildings do
			local buildingID = buildings[i].buildingID;
			if ( buildingID ) then
				local name, _, _, shipmentsReady, shipmentsTotal = C_GarrisonGetLandingPageShipmentInfo(buildingID);
				if ( name and shipmentsReady and shipmentsTotal ) then
					if(hasBuilding == false) then
						GameTooltip:AddLine(CAPACITANCE_WORK_ORDERS)
						hasBuilding = true
					end

					GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
				end
			end
		end
	end

	--Garrison Missions
	local inProgressMissions = {};
	C_GarrisonGetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_6_0)
	local numMissions = #inProgressMissions
	if(numMissions > 0) then
		tsort(inProgressMissions, sortFunction) --Sort by time left, lowest first

		if(numBuildings > 0) then GameTooltip:AddLine(' ') end
		GameTooltip:AddLine(GARRISON_MISSIONS_TITLE)
		for i=1, numMissions do
			local mission = inProgressMissions[i]
			local timeLeft = mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if(mission.isRare) then r, g, b = .09, .51, .81 end
			if(timeLeft and timeLeft == '0') then GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0) else GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b) end
		end
	end	

	--Naval Missions
	local inProgressShipMissions = {};
	C_GarrisonGetInProgressMissions(inProgressShipMissions, LE_FOLLOWER_TYPE_SHIPYARD_6_2)
	local numShipMissions = #inProgressShipMissions
	if(numShipMissions > 0) then
		tsort(inProgressShipMissions, sortFunction) --Sort by time left, lowest first

		if(numBuildings > 0 or numMissions > 0) then GameTooltip:AddLine(' ') end
		GameTooltip:AddLine(SPLASH_NEW_6_2_FEATURE2_TITLE)
		for i=1, numShipMissions do
			local mission = inProgressShipMissions[i]
			local timeLeft = mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if(mission.isRare) then r, g, b = .09, .51, .81 end
			if(timeLeft and timeLeft == '0') then GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0) else GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b) end
		end
	end

	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(TOKENS)
	GameTooltip:AddDoubleLine(D['Currency'](824))
	GameTooltip:AddDoubleLine(D['Currency'](1101))
	GameTooltip:Show()
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)	
Stat:SetScript('OnEvent', Update)
Stat:SetScript('OnMouseDown', function() GarrisonLandingPageMinimapButton_OnClick() end)