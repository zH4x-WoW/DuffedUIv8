local D, C, L = select(2, ...):unpack()
local Miscellaneous = CreateFrame("Frame")
 
Miscellaneous:RegisterEvent("ADDON_LOADED")
Miscellaneous:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then return end

 	if C["misc"].ThreatBarEnable then self.ThreatBar:Enable() end
	if C["misc"].AltPowerBarEnable then self.AltPowerBar:Enable() end
	self.MirrorTimers:Enable()
	self.DropDown:Enable()
	self.CollectGarbage:Enable()
	self.GameMenu:Enable()
	self.LossControl:Enable()
	self.StaticPopups:Enable()
	
	-- Need a little delay for Objective Tracker
	D.Delay(1, function()
		self.ObjectiveTracker:Enable()
	end)
	
	self:UnregisterEvent("ADDON_LOADED")
end)
 
D["Miscellaneous"] = Miscellaneous