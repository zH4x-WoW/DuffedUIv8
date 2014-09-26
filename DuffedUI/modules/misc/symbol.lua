local D, C, L = unpack(select(2,  ...))

local menuFrame = CreateFrame("Frame", "DuffedUIMarkingFrame", UIParent, "UIDropDownMenuTemplate")

local menuList = {
	{text = L["symbol"]["clear"],
	func = function() SetRaidTarget("target", 0) end},
	{text = L["symbol"]["skull"],
	func = function() SetRaidTarget("target", 8) end},
	{text = "|cffff0000" .. L["symbol"]["cross"] .. "|r",
	func = function() SetRaidTarget("target", 7) end},
	{text = "|cff00ffff" .. L["symbol"]["square"] .. "|r",
	func = function() SetRaidTarget("target", 6) end},
	{text = "|cffC7C7C7" .. L["symbol"]["moon"] .. "|r",
	func = function() SetRaidTarget("target", 5) end},
	{text = "|cff00ff00" .. L["symbol"]["triangle"] .. "|r",
	func = function() SetRaidTarget("target", 4) end},
	{text = "|cff912CEE" .. L["symbol"]["diamond"] .. "|r",
	func = function() SetRaidTarget("target", 3) end},
	{text = "|cffFF8000" .. L["symbol"]["circle"] .. "|r",
	func = function() SetRaidTarget("target", 2) end},
	{text = "|cffffff00" .. L["symbol"]["star"] .. "|r",
	func = function() SetRaidTarget("target", 1) end},
}

WorldFrame:HookScript("OnMouseDown", function(self, button)
	if(button=="RightButton" and IsShiftKeyDown() and IsControlKeyDown() and UnitExists("mouseover")) then 
		local inParty = (GetNumGroupMembers() > 0)
		local inRaid = (GetNumGroupMembers() > 0)
		if (inRaid and (IsRaidLeader() or IsRaidOfficer()) or (inParty and not inRaid)) or (not inParty and not inRaid) then EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", nil) end
	end
end)