local D, C, L = select(2, ...):unpack()
local Inventory = CreateFrame("Frame")

Inventory:RegisterEvent("ADDON_LOADED")
Inventory:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then return end

	-- Bags
	if (C["bags"].Enable) then self.Bags:Enable() end

	-- Loot Frame
	self.Loot:Enable()

	-- Merchant
	self.Merchant:Enable()
	
	-- Bag Filter
	if C["bags"].BagFilter then self.BagFilter:Enable() end

	-- Unregister
	self:UnregisterEvent("ADDON_LOADED")
end)

D["Inventory"] = Inventory