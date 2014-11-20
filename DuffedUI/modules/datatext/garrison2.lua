local D, C, L = unpack(select(2, ...)) 
if not C["datatext"].garrison or C["datatext"].garrison == 0 then return end

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

local function Currency(id, weekly, capped)	
	local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)
	if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. Stat.Color1 .. name, Stat.Color2 ..  amount) end
end

Stat:SetScript("OnEnter", function(self)	
	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	GameTooltip:AddLine(Stat.Color2 .. GARRISON_LANDING_PAGE_TITLE .. ":")
	GameTooltip:AddLine(" ")

	local num = C_Garrison.GetNumFollowers()
	for k,v in pairs(C_Garrison.GetInProgressMissions()) do
		GameTooltip:AddDoubleLine(Stat.Color1 .. v['name'],Stat.Color2 .. v['timeLeft'])
		num = num - v['numFollowers']
	end
	GameTooltip:AddDoubleLine(Stat.Color1 ..GARRISON_FOLLOWERS .. ":", Stat.Color2 .. num .. "/" .. C_Garrison.GetNumFollowers())
	GameTooltip:AddDoubleLine(Stat.Color1 .. GARRISON_MISSIONS .. ":", Stat.Color2 .. #C_Garrison.GetInProgressMissions() .. "/" .. #C_Garrison.GetAvailableMissions())

	GameTooltip:AddDoubleLine(" ")
	GameTooltip:AddDoubleLine(Currency(824))		
	GameTooltip:Show()	
end)
Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	
Stat:SetScript("OnEvent", Update)
Stat:SetScript("OnMouseDown", function() GarrisonLandingPageMinimapButton_OnClick() end)