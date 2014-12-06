local D, C, L = unpack(select(2, ...)) 
if not C["datatext"].garrison or C["datatext"].garrison == 0 then return end

--[[Textfield]]--
local Stat = CreateFrame("Frame", "DuffedUIStatgarrison")
Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
Stat:RegisterEvent("GET_ITEM_INFO_RECEIVED")
Stat:RegisterEvent("GARRISON_MISSION_LIST_UPDATE")
Stat:RegisterEvent("GARRISON_MISSION_STARTED")
Stat:RegisterEvent("GARRISON_MISSION_FINISHED")
Stat:RegisterEvent("GARRISON_MISSION_COMPLETE_RESPONSE")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("PLAYER_LOGIN")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat.Option = C["datatext"].garrison
Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

local font = D.Font(C["font"].datatext)
local Text  = Stat:CreateFontString("DuffedUIStatgarrisonText", "OVERLAY")
Text:SetFontObject(font)
D.DataTextPosition(C["datatext"].garrison, Text)

--[[Update for textfield]]--
local function Update(self, event)
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
	if count > 0 then Text:SetText(Stat.Color1 .. format(GARRISON_LANDING_IN_PROGRESS, count)) else Text:SetText(Stat.Color2 .. GARRISON_LOCATION_TOOLTIP) end
	self:SetAllPoints(Text)
end

--[[Ressources]]--
local function Currency(id, weekly, capped)	
	local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)
	if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount, 1, 1, 1) end
end

--[[Tooltip]]--
Stat:SetScript("OnEnter", function(self)
	if not C["datatext"].ShowInCombat then
		if InCombatLockdown() then return end
	end

	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	GameTooltip:AddLine(Stat.Color1 .. GARRISON_LANDING_PAGE_TITLE)
	GameTooltip:AddLine(" ")

	GameTooltip:AddDoubleLine("Active " .. GARRISON_MISSIONS)
	local num = C_Garrison.GetNumFollowers()
	for k,v in pairs(C_Garrison.GetInProgressMissions()) do
		GameTooltip:AddDoubleLine(v["name"], v["timeLeft"], 1, 1, 1)
		num = num - v["numFollowers"]
	end
	GameTooltip:AddLine(" ")

	GameTooltip:AddDoubleLine(GARRISON_FOLLOWERS .. " & " .. GARRISON_MISSIONS)
	GameTooltip:AddDoubleLine(GARRISON_FOLLOWERS .. ":", num .. "/" .. C_Garrison.GetNumFollowers(), 1, 1, 1)
	GameTooltip:AddDoubleLine(GARRISON_MISSIONS .. ":", #C_Garrison.GetInProgressMissions() .. "/" .. #C_Garrison.GetAvailableMissions(), 1, 1, 1)
	GameTooltip:AddLine(" ")

	GameTooltip:AddDoubleLine(Currency(824))
	GameTooltip:Show()
end)
Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnEvent", Update)
Stat:SetScript("OnMouseDown", function() GarrisonLandingPageMinimapButton_OnClick() end)