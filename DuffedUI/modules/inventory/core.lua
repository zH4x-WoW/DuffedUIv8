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
	local DataTextLeft = D["Panels"].DataTextLeft
	local DataTextRight = D["Panels"].DataTextRight
	local LeftBackground = D["Panels"].LeftChatBackground
	local RightBackground = D["Panels"].RightChatBackground
	
	self:HideBlizzard()
	if C["chat"].rBackground then self:CreateContainer("Bag", "BOTTOMRIGHT", RightBackground, "TOPRIGHT", 0, 3) else self:CreateContainer("Bag", "BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, 3) end
	if C["chat"].lBackground then self:CreateContainer("Bank", "BOTTOMLEFT", LeftBackground, "TOPLEFT", 0, 3) else self:CreateContainer("Bank", "BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 3) end
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

D["Inventory"] = Inventory