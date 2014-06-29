local D, C, L = select(2, ...):unpack()
local Inventory = CreateFrame("Frame")

Inventory:RegisterEvent("ADDON_LOADED")
Inventory:SetScript("OnEvent", function(self, event, addon)
	if (event == "MERCHANT_SHOW") then
		self:MerchantOnEvent()
	else
		if (addon ~= "DuffedUI") then return end

		-- Bags
		if (C["bags"].Enable) then
			self:EnableBags()
		end

		-- Loot Frame
		self:EnableLootFrame()

		-- Merchant
		self:EnableMerchant()

		-- Unregister
		self:UnregisterEvent("ADDON_LOADED")
	end
end)

D["Inventory"] = Inventory