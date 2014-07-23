local D, C, L = select(2, ...):unpack()

local _G = _G
local Maps = CreateFrame("Frame")

Maps:RegisterEvent("ADDON_LOADED")
Maps:RegisterEvent("PLAYER_LOGIN")

Maps:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		self.WorldMap:Enable()
	else
		if (addon == "Blizzard_TimeManager") then
			local Time = _G["TimeManagerClockButton"]

			Time:Kill()
		elseif (addon == "DuffedUI") then
			self.Minimap:Enable()
		end
	end
end)

D["Maps"] = Maps