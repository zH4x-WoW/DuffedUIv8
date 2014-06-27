local D, C, L = select(2, ...):unpack()
local Miscellaneous = CreateFrame("Frame")

Miscellaneous:RegisterEvent("ADDON_LOADED")
Miscellaneous:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then return end

	self.ThreatBar:Create()
	self.MirrorTimers:Load()
end)

D["Miscellaneous"] = Miscellaneous