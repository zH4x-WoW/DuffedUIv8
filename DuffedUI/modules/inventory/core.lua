local D, C, L = select(2, ...):unpack()
local Inventory = CreateFrame("Frame")

Inventory:RegisterEvent("ADDON_LOADED")
Inventory:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then
		return
	end
	
	-- Bags
	local Bag = ContainerFrame1
	local GameMenu = GameMenuFrame
	local Bank = BankFrameItem1
	local DataTextLeft = T["Panels"].DataTextLeft
	local DataTextRight = T["Panels"].DataTextRight
	
	self:HideBlizzard()
	self:CreateContainer("Bag", "BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, 6)
	self:CreateContainer("Bank", "BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 6)
	self:SetBagsSearchPosition()
	self:SetBankSearchPosition()
	self:SkinEditBoxes()
	self:SetTokensPosition()
	self:SkinTokens()
	
	Bag:SetScript("OnHide", function()
		self.Bag:Hide()
	end)
	
	Bank:SetScript("OnHide", function()
		self.Bank:Hide()
	end)
	
	-- Rewrite Blizzard Bags Functions
	function UpdateContainerFrameAnchors() end
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags() end
	function OpenBackpack()  ToggleAllBags() end
	function ToggleAllBags() self:ToggleBags() end
	
	-- Loot Frame
	self:SkinLootFrame()
	self:AddLootFrameHooks()
end)

T["Inventory"] = Inventory