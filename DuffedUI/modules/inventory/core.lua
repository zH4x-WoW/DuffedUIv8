local D, C, L = select(2, ...):unpack()
local Inventory = CreateFrame("Frame")

Inventory:RegisterEvent("ADDON_LOADED")
Inventory:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then
		return
	end

	-- Bags
	local Bag1 = ContainerFrame1
	local GameMenu = GameMenuFrame
	local BankSlot1 = BankFrameItem1
	local DataTextLeft = D["Panels"].DataTextLeft
	local DataTextRight = D["Panels"].DataTextRight

	self:HideBlizzard()
	self:CreateContainer("Bag", "BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, 6)
	self:CreateContainer("Bank", "BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 6)
	self:SetBagsSearchPosition()
	self:SetBankSearchPosition()
	self:SkinEditBoxes()
	self:SetTokensPosition()
	self:SkinTokens()

	Bag1:SetScript("OnHide", function()
		self.Bag:Hide()
	end)

	GameMenu:SetScript("OnShow", function()
		ToggleBags = 1
		ToggleAllBags()
	end)

	BankSlot1:SetScript("OnHide", function()
		self.Bank:Hide()
		ToggleBank = 0
	end)

	BankSlot1:SetScript("OnShow", function()
		self.Bank:Show()
	end)

	-- Rewrite Blizzard Bags Functions
	function UpdateContainerFrameAnchors() end
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags() end
	function OpenBackpack()  ToggleAllBags() end
	function CloseBackpack() ToggleAllBags() end
	function CloseAllBags() ToggleAllBags() end
	function ToggleAllBags() self:ToggleBags() end

	-- Loot Frame
	self:SkinLootFrame()
	self:AddLootFrameHooks()
end)

D["Inventory"] = Inventory