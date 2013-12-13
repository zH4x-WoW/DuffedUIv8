local D, C, L = select(2, ...):unpack()

local _G = _G
local Maps = CreateFrame("Frame")

Maps:RegisterEvent("ADDON_LOADED")

Maps:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TimeManager") then
		local Time = _G["TimeManagerClockButton"]

		Time:Kill()
	elseif (addon == "DuffedUI") then
		-- Minimap
		self:DisableMinimapElements()
		self:StyleMinimap()
		self:PositionMinimap()
		self:AddMinimapDataTexts()
		
		-- Worldmap
		self:SetWorldmap()
		self:SkinWorldmap()
	end
end)

T["Maps"] = Maps