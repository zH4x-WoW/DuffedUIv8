local D, C, L = unpack(select(2, ...))
if not C["datatext"].garrison or C["datatext"].garrison == 0 then return end

local Stat = CreateFrame("Frame")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat:EnableMouse(true)
local scolor1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
local scolor2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

local font = D.Font(C["font"].datatext)
local Text  = DuffedUIInfoLeft:CreateFontString(nil, "OVERLAY")
Text:SetFontObject(font)
D.DataTextPosition(C["datatext"].garrison, Text)

local function = Update(self, event)
	if not GarrisonMissionFrame then LoadAddOn("Blizzard_GarrisonUI") end
	GarrisonMissionList_UpdateMissions()

	local missions = GarrisonMissionFrame.MissionTab.MissionList.inProgressMissions
	local count = 0

	C_Garrison.GetInProgressMissions(missions)
	for i = 1, #missions do
		if missions[i].inProgress then
			local tl = missions[i].timeLeft:match("%d")
			if tl ~= "0" then count = count + 1 end
		end
	end
	if count > 0 then Text:SetText(scolor2 .. format(GARRISON_LANDING_IN_PROGRESS, count)) else Text:SetText(scolor1 .. GARRISON_LOCATION_TOOLTIP) end
end

Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
Stat:RegisterEvent("GET_ITEM_INFO_RECEIVED")
Stat:RegisterEvent("GARRISON_MISSION_LIST_UPDATE")
Stat:RegisterEvent("GARRISON_MISSION_STARTED")
Stat:RegisterEvent("GARRISON_MISSION_FINISHED")
Stat:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEnter", function(self)
	if not C["datatext"].ShowInCombat then
		if InCombatLockdown() then return end
	end
	if not GarrisonMissionFrame then return end
	GarrisonMissionList_UpdateMissions()

	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	local missions = GarrisonMissionFrame.MissionTab.MissionList.inProgressMissions
	local numMission = #missions

	C_Garrison.GetInProgressMissions(Missions)
	if numMission == 0 then return end
	GameTooltip:AddLine(GARRISON_MISSIONS)

	for i = 1, numMission do
		local mission = missions[i]
		local tl = mission.timeLeft:match("%d")

		if (mission.inProgress and (tl ~= "0")) then GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, 1, 1, 1, 1, 1, 1) end
	end

	local available = GarrisonMissionFrame.MissionTab.MissionList.availableMissions
	local numAvailable = #available

	if numAvailable > 0 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(format(GARRISON_LANDING_AVAILABLE, numAvailable))
	end

	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnEvent", Update)
Stat:SetScript("OnMouseDown", function() GarrisonLandingPage_Toggle end)
Update(Stat)