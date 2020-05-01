local D, C, L = unpack(select(2, ...))
local Module = D:NewModule("Bags", "AceEvent-3.0", "AceTimer-3.0")
local cargBags = cargBags or D.cargBags

local ceil = _G.ceil
local ipairs = _G.ipairs
local string_match = _G.strmatch
local unpack = _G.unpack
local table_wipe = _G.table.wipe

local C_Item_CanScrapItem = _G.C_Item.CanScrapItem
local C_Item_DoesItemExist = _G.C_Item.DoesItemExist
local C_NewItems_IsNewItem = _G.C_NewItems.IsNewItem
local C_NewItems_RemoveNewItem = _G.C_NewItems.RemoveNewItem
local C_Timer_After = _G.C_Timer.After
local ClearCursor = _G.ClearCursor
local CreateFrame = _G.CreateFrame
local DeleteCursorItem = _G.DeleteCursorItem
local GetContainerItemID = _G.GetContainerItemID
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerNumFreeSlots = _G.GetContainerNumFreeSlots
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetInventoryItemID = _G.GetInventoryItemID
local GetItemInfo = _G.GetItemInfo
local InCombatLockdown = _G.InCombatLockdown
local IsAltKeyDown = _G.IsAltKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local LE_ITEM_CLASS_ARMOR = _G.LE_ITEM_CLASS_ARMOR
local LE_ITEM_CLASS_WEAPON = _G.LE_ITEM_CLASS_WEAPON
local LE_ITEM_QUALITY_POOR = _G.LE_ITEM_QUALITY_POOR
local LE_ITEM_QUALITY_RARE = _G.LE_ITEM_QUALITY_RARE
local PickupContainerItem = _G.PickupContainerItem
local PlaySound = _G.PlaySound
local SortBags = _G.SortBags
local SortBankBags = _G.SortBankBags
local SortReagentBankBags = _G.SortReagentBankBags

local deleteEnable, favouriteEnable
local IsCorruptedItem = IsCorruptedItem
local ITEM_UPGRADE_CHECK_TIME = 0.5
local move = D['move']

local sortCache = {}
function Module:ReverseSort()
	for bag = 0, 4 do
		local numSlots = GetContainerNumSlots(bag)
		for slot = 1, numSlots do
			local texture, _, locked = GetContainerItemInfo(bag, slot)
			if (slot <= numSlots / 2) and texture and not locked and not sortCache["b"..bag.."s"..slot] then
				PickupContainerItem(bag, slot)
				PickupContainerItem(bag, numSlots+1 - slot)
				sortCache["b"..bag.."s"..slot] = true
			end
		end
	end

	DUFFEDUI_Backpack.isSorting = false
	DUFFEDUI_Backpack:BAG_UPDATE()
end

function Module:UpdateItemUpgradeIcon()
	if not C["bags"].UpgradeIcon then
		self.UpgradeIcon:SetShown(false)
		self:SetScript("OnUpdate", nil)
		return
	end

	local itemIsUpgrade = _G.IsContainerItemAnUpgrade(self:GetParent():GetID(), self:GetID())
	if itemIsUpgrade == nil then
		self.UpgradeIcon:SetShown(false)
		self:SetScript("OnUpdate", Module.UpgradeCheck_OnUpdate)
	else
		self.UpgradeIcon:SetShown(itemIsUpgrade)
		self:SetScript("OnUpdate", nil)
	end
end

function Module:UpgradeCheck_OnUpdate(elapsed)
	self.timeSinceUpgradeCheck = (self.timeSinceUpgradeCheck or 0) + elapsed
	if self.timeSinceUpgradeCheck >= ITEM_UPGRADE_CHECK_TIME then
		Module.UpdateItemUpgradeIcon(self)
		self.timeSinceUpgradeCheck = 0
	end
end

function Module:UpdateItemScrapIcon()
	if not C["bags"].ScrapIcon then
		self.ScrapIcon:SetShown(false)
		return
	end

	local itemLoc = _G.ItemLocation:CreateFromBagAndSlot(self:GetParent():GetID(), self:GetID())
	if itemLoc and itemLoc ~= "" then
		if C["bags"].ScrapIcon and (C_Item.DoesItemExist(itemLoc) and C_Item.CanScrapItem(itemLoc)) then
			self.ScrapIcon:SetShown(itemLoc)
		else
			self.ScrapIcon:SetShown(false)
		end
	end
end

function Module:UpdateAnchors(parent, bags)
	local anchor = parent
	for _, bag in ipairs(bags) do
		if bag:GetHeight() > 45 then
			bag:Show()
		else
			bag:Hide()
		end

		if bag:IsShown() then
			bag:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 0, 5)
			anchor = bag
		end
	end
end

local function highlightFunction(button, match)
	button:SetAlpha(match and 1 or .3)
end

function Module:CreateInfoFrame()
	local infoFrame = CreateFrame("Button", nil, self)
	infoFrame:SetPoint("TOPLEFT", 10, 0)
	infoFrame:SetSize(200, 32)

	local icon = infoFrame:CreateTexture()
	icon:SetSize(24, 24)
	icon:SetPoint("LEFT")
	icon:SetTexture("Interface\\Minimap\\Tracking\\None")
	icon:SetTexCoord(1, 0, 0, 1)

	local search = self:SpawnPlugin("SearchBar", infoFrame)
	search.highlightFunction = highlightFunction
	search.isGlobal = true
	search:SetPoint("LEFT", 0, 5)
	search:DisableDrawLayer("BACKGROUND")
	search:CreateBackdrop()
	search.backdrop:SetPoint("TOPLEFT", -5, -7)
	search.backdrop:SetPoint("BOTTOMRIGHT", 5, 7)

	local moneyTag = self:SpawnPlugin("TagDisplay", "[money]", infoFrame)
	moneyTag:SetFont(C['media']['font'], 11, 'OUTLINE')
	moneyTag:SetPoint("RIGHT", -5, 0)

	local currencyTag = self:SpawnPlugin("TagDisplay", "[currencies]", infoFrame)
	currencyTag:SetFont(C['media']['font'], 11, 'OUTLINE')
	currencyTag:SetPoint("TOP", self, "BOTTOM", 0, -6)
end

function Module:CreateBagBar(settings, columns)
	local bagBar = self:SpawnPlugin("BagBar", settings.Bags)
	local width, height = bagBar:LayoutButtons("grid", columns, 5, 5, -5)
	bagBar:SetSize(width + 10, height + 10)
	bagBar:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -5)
	bagBar:CreateBorder()
	bagBar.highlightFunction = highlightFunction
	bagBar.isGlobal = true
	bagBar:Hide()

	self.BagBar = bagBar
end

function Module:CreateCloseButton()
	local closeButton = CreateFrame("Button", nil, self)
	closeButton:SetSize(18, 18)
	closeButton:CreateBorder()
	closeButton:StyleButton()

	closeButton.Icon = closeButton:CreateTexture(nil, "ARTWORK")
	closeButton.Icon:SetAllPoints()
	closeButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	closeButton.Icon:SetTexture("Interface\\AddOns\\DuffedUI\\media\\textures\\CloseButton_32")

	closeButton:SetScript("OnClick", CloseAllBags)
	closeButton.title = CLOSE
	D.AddTooltip(closeButton, "ANCHOR_TOP")

	return closeButton
end

function Module:CreateRestoreButton(f)
	local restoreButton = CreateFrame("Button", nil, self)
	restoreButton:SetSize(18, 18)
	restoreButton:CreateBorder()
	restoreButton:StyleButton()

	restoreButton.Icon = restoreButton:CreateTexture(nil, "ARTWORK")
	restoreButton.Icon:SetAllPoints()
	restoreButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	restoreButton.Icon:SetAtlas("transmog-icon-revert")

	restoreButton:SetScript("OnClick", function()
		f.main:ClearAllPoints()
		f.main:SetPoint("BOTTOMRIGHT", -50, 320)
		f.bank:ClearAllPoints()
		f.bank:SetPoint("BOTTOMRIGHT", f.main, "BOTTOMLEFT", -10, 0)
		f.reagent:ClearAllPoints()
		f.reagent:SetPoint("BOTTOMLEFT", f.bank)
		PlaySound(SOUNDKIT.IG_MINIMAP_OPEN)
	end)
	restoreButton.title = RESET
	D.AddTooltip(restoreButton, "ANCHOR_TOP")

	return restoreButton
end

function Module:CreateReagentButton(f)
	local reagentButton = CreateFrame("Button", nil, self)
	reagentButton:SetSize(18, 18)
	reagentButton:CreateBorder()
	reagentButton:StyleButton()

	reagentButton.Icon = reagentButton:CreateTexture(nil, "ARTWORK")
	reagentButton.Icon:SetAllPoints()
	reagentButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	reagentButton.Icon:SetTexture("Interface\\ICONS\\INV_Enchant_DustArcane")

	reagentButton:RegisterForClicks("AnyUp")
	reagentButton:SetScript("OnClick", function(_, btn)
		if not IsReagentBankUnlocked() then
			StaticPopup_Show("CONFIRM_BUY_REAGENTBANK_TAB")
		else
			PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
			ReagentBankFrame:Show()
			BankFrame.selectedTab = 2
			f.reagent:Show()
			f.bank:Hide()

			if btn == "RightButton" then
				DepositReagentBank()
			end
		end
	end)
	reagentButton.title = REAGENT_BANK
	D.AddTooltip(reagentButton, "ANCHOR_TOP")

	return reagentButton
end

function Module:CreateBankButton(f)
	local BankButton = CreateFrame("Button", nil, self)
	BankButton:SetSize(18, 18)
	BankButton:CreateBorder()
	BankButton:StyleButton()

	BankButton.Icon = BankButton:CreateTexture(nil, "ARTWORK")
	BankButton.Icon:SetAllPoints()
	BankButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	BankButton.Icon:SetTexture("Interface\\ICONS\\achievement_guildperk_mobilebanking")

	BankButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
		ReagentBankFrame:Hide()
		BankFrame.selectedTab = 1
		f.reagent:Hide()
		f.bank:Show()
	end)

	BankButton.title = BANK
	D.AddTooltip(BankButton, "ANCHOR_TOP")

	return BankButton
end

function Module:CreateDepositButton()
	local DepositButton = CreateFrame("Button", nil, self)
	DepositButton:SetSize(18, 18)
	DepositButton:CreateBorder()
	DepositButton:StyleButton()

	DepositButton.Icon = DepositButton:CreateTexture(nil, "ARTWORK")
	DepositButton.Icon:SetAllPoints()
	DepositButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	DepositButton.Icon:SetTexture("Interface\\ICONS\\misc_arrowdown")

	DepositButton:SetScript("OnClick", DepositReagentBank)

	DepositButton.title = REAGENTBANK_DEPOSIT
	D.AddTooltip(DepositButton, "ANCHOR_TOP")

	return DepositButton
end

function Module:CreateBagToggle()
	local bagToggleButton = CreateFrame("Button", nil, self)
	bagToggleButton:SetSize(18, 18)
	bagToggleButton:CreateBorder()
	bagToggleButton:StyleButton()

	bagToggleButton.Icon = bagToggleButton:CreateTexture(nil, "ARTWORK")
	bagToggleButton.Icon:SetAllPoints()
	bagToggleButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	bagToggleButton.Icon:SetTexture("Interface\\Buttons\\Button-Backpack-Up")

	bagToggleButton:SetScript("OnClick", function()
		ToggleFrame(self.BagBar)
		if self.BagBar:IsShown() then
			bagToggleButton:SetBackdropBorderColor(1, .8, 0)
			PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
		else
			bagToggleButton:SetBackdropBorderColor()
			PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
		end
	end)
	bagToggleButton.title = BACKPACK_TOOLTIP
	D.AddTooltip(bagToggleButton, "ANCHOR_TOP")

	return bagToggleButton
end

function Module:CreateSortButton(name)
	local sortButton = CreateFrame("Button", nil, self)
	sortButton:SetSize(18, 18)
	sortButton:CreateBorder()
	sortButton:StyleButton()

	sortButton.Icon = sortButton:CreateTexture(nil, "ARTWORK")
	sortButton.Icon:SetAllPoints()
	sortButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	sortButton.Icon:SetTexture("Interface\\AddOns\\DuffedUI\\media\\textures\\INV_Pet_Broom.blp")

	sortButton:SetScript("OnClick", function()
		if name == "Bank" then
			SortBankBags()
		elseif name == "Reagent" then
			SortReagentBankBags()
		else
			if C["bags"].ReverseSort then
				if InCombatLockdown() then
					UIErrorsFrame:AddMessage(D.InfoColor..ERR_NOT_IN_COMBAT)
				else
					SortBags()
					table_wipe(sortCache)
					DUFFEDUI_Backpack.isSorting = true
					C_Timer_After(.5, Module.ReverseSort)
				end
			else
				SortBags()
			end
		end
	end)
	sortButton.title = L['bags']["Sort"]
	D.AddTooltip(sortButton, "ANCHOR_TOP")

	return sortButton
end

function Module:CreateDeleteButton()
	local enabledText = D.SystemColor..L['bags']["Delete Mode Enabled"]

	local deleteButton = CreateFrame("Button", nil, self)
	deleteButton:SetSize(18, 18)
	deleteButton:CreateBorder()
	deleteButton:StyleButton()

	deleteButton.Icon = deleteButton:CreateTexture(nil, "ARTWORK")
	deleteButton.Icon:SetPoint("TOPLEFT", 3, -2)
	deleteButton.Icon:SetPoint("BOTTOMRIGHT", -1, 2)
	deleteButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	deleteButton.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")

	deleteButton:SetScript("OnClick", function(self)
		deleteEnable = not deleteEnable
		if deleteEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.Icon:SetDesaturated(true)
			self.text = enabledText
		else
			self:SetBackdropBorderColor()
			self.Icon:SetDesaturated(false)
			self.text = nil
		end
		self:GetScript("OnEnter")(self)
	end)
	deleteButton.title = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t"..L['bags']["Item Delete Mode"]
	D.AddTooltip(deleteButton, "ANCHOR_TOP")

	return deleteButton
end

local function deleteButtonOnClick(self)
	if not deleteEnable then
		return
	end

	local texture, _, _, quality = GetContainerItemInfo(self.bagID, self.slotID)
	if IsControlKeyDown() and IsAltKeyDown() and texture and (quality < LE_ITEM_QUALITY_RARE) then
		PickupContainerItem(self.bagID, self.slotID)
		DeleteCursorItem()
	end
end

function Module:CreateFavouriteButton()
	local enabledText = D.SystemColor..L['bags']["Favourite Mode Enabled"]

	local favouriteButton = CreateFrame("Button", nil, self)
	favouriteButton:SetSize(18, 18)
	favouriteButton:CreateBorder()
	favouriteButton:StyleButton()

	favouriteButton.Icon = favouriteButton:CreateTexture(nil, "ARTWORK")
	favouriteButton.Icon:SetPoint("TOPLEFT", -5, 0)
	favouriteButton.Icon:SetPoint("BOTTOMRIGHT", 5, -5)
	favouriteButton.Icon:SetTexCoord(unpack(D['IconCoord']))
	favouriteButton.Icon:SetTexture("Interface\\Common\\friendship-heart")

	favouriteButton:SetScript("OnClick", function(self)
		favouriteEnable = not favouriteEnable
		if favouriteEnable then
			self:SetBackdropBorderColor(1, .8, 0)
			self.Icon:SetDesaturated(true)
			self.text = enabledText
		else
			self:SetBackdropBorderColor()
			self.Icon:SetDesaturated(false)
			self.text = nil
		end
		self:GetScript("OnEnter")(self)
	end)
	favouriteButton.title = L['bags']["Favourite Mode"]
	D.AddTooltip(favouriteButton, "ANCHOR_TOP")

	return favouriteButton
end

local function favouriteOnClick(self)
	if not favouriteEnable then
		return
	end

	local texture, _, _, quality, _, _, _, _, _, itemID = GetContainerItemInfo(self.bagID, self.slotID)
	if texture and quality > LE_ITEM_QUALITY_POOR then
		if DuffedUIData.FavouriteItems[itemID] then
			DuffedUIData.FavouriteItems[itemID] = nil
		else
			DuffedUIData.FavouriteItems[itemID] = true
		end
		ClearCursor()
		DUFFEDUI_Backpack:BAG_UPDATE()
		--Module.UpdateAllBags()
	end
end

function Module:ButtonOnClick(btn)
	if btn ~= "LeftButton" then
		return
	end

	deleteButtonOnClick(self)
	favouriteOnClick(self)
end

function Module:UpdateAllBags()
	if self.Bags and self.Bags:IsShown() then
		self.Bags:BAG_UPDATE()
	end
end

function Module:GetContainerEmptySlot(bagID)
	for slotID = 1, GetContainerNumSlots(bagID) do
		if not GetContainerItemID(bagID, slotID) then
			return slotID
		end
	end
end

function Module:GetEmptySlot(name)
	if name == "Main" then
		for bagID = 0, 4 do
			local slotID = Module:GetContainerEmptySlot(bagID)
			if slotID then
				return bagID, slotID
			end
		end
	elseif name == "Bank" then
		local slotID = Module:GetContainerEmptySlot(-1)
		if slotID then
			return -1, slotID
		end

		for bagID = 5, 11 do
			local slotID = Module:GetContainerEmptySlot(bagID)
			if slotID then
				return bagID, slotID
			end
		end
	elseif name == "Reagent" then
		local slotID = Module:GetContainerEmptySlot(-3)
		if slotID then
			return -3, slotID
		end
	end
end

function Module:FreeSlotOnDrop()
	local bagID, slotID = Module:GetEmptySlot(self.__name)
	if slotID then
		PickupContainerItem(bagID, slotID)
	end
end

local freeSlotContainer = {
	["Main"] = true,
	["Bank"] = true,
	["Reagent"] = true,
}

function Module:CreateFreeSlots()
	local name = self.name
	if not freeSlotContainer[name] then
		return
	end

	local slot = CreateFrame("Button", name.."FreeSlot", self)
	slot:SetSize(self.iconSize, self.iconSize)
	slot:CreateBorder()
	slot:SetScript("OnMouseUp", Module.FreeSlotOnDrop)
	slot:SetScript("OnReceiveDrag", Module.FreeSlotOnDrop)
	D.AddTooltip(slot, "ANCHOR_RIGHT", L['bags']["FreeSlots"])
	slot.__name = name

	local tag = self:SpawnPlugin("TagDisplay", "[space]", slot)
	tag:SetFont(C['media']['font'], 16, 'OUTLINE')
	tag:SetPoint("CENTER", 1, 0)
	tag.__name = name

	self.freeSlot = slot
end

local function DragFunction(self, mode)
	for index = 1, select("#", self:GetChildren()) do
		local frame = select(index, self:GetChildren())
		if frame:GetName() and frame:GetName():match("DUFFEDUI_Backpack") then
			if mode then
				frame:Hide()
			else
				frame:Show()
			end
		end
	end
end

function Module:OnEnable()
	if not C["bags"].Enable then
		return
	end

	-- Settings
	local bagsWidth = C["bags"].BagsWidth
	local bankWidth = C["bags"].BankWidth
	local iconSize = C["bags"].IconSize
	local showItemLevel = C["bags"].BagsiLvl
	local deleteButton = C["bags"].DeleteButton
	local itemSetFilter = C["bags"].ItemSetFilter

	-- Init
	local Backpack = cargBags:NewImplementation("DUFFEDUI_Backpack")
	Backpack:RegisterBlizzard()
	Backpack:SetScale(1)

	Backpack:HookScript("OnShow", function()
		PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
	end)

	Backpack:HookScript("OnHide", function()
		PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
	end)

	Module.Bags = Backpack
	Module.BagsType = {}
	Module.BagsType[0] = 0	-- Backpack
	Module.BagsType[-1] = 0	-- Bank
	Module.BagsType[-3] = 0	-- Reagent

	local f = {}	
	local onlyBags, bagAzeriteItem,  bagCorruptionItem, bagEquipment, bagConsumble, bagTradeGoods, bagQuestItem, bagsJunk, onlyBank, bankAzeriteItem, bankCorruptionItem, bankLegendary, bankEquipment, bankConsumble, onlyReagent, bagMountPet, bankMountPet, bagFavourite, bankFavourite = self:GetFilters()

	function Backpack:OnInit()
		local MyContainer = self:GetContainerClass()

		f.main = MyContainer:New("Main", {Columns = bagsWidth, Bags = "bags"})
		f.main:SetFilter(onlyBags, true)
		f.main:SetPoint("BOTTOMRIGHT", -50, 320)

		f.junk = MyContainer:New("Junk", {Columns = bagsWidth, Parent = f.main})
		f.junk:SetFilter(bagsJunk, true)

		f.bagFavourite = MyContainer:New("BagFavourite", {Columns = bagsWidth, Parent = f.main})
		f.bagFavourite:SetFilter(bagFavourite, true)

		f.azeriteItem = MyContainer:New("AzeriteItem", {Columns = bagsWidth, Parent = f.main})
		f.azeriteItem:SetFilter(bagAzeriteItem, true)
		
		f.corruptionItem = MyContainer:New("CorruptionItem", {Columns = bagsWidth, Parent = f.main})
		f.corruptionItem:SetFilter(bagCorruptionItem, true)

		f.equipment = MyContainer:New("Equipment", {Columns = bagsWidth, Parent = f.main})
		f.equipment:SetFilter(bagEquipment, true)

		f.consumble = MyContainer:New("Consumble", {Columns = bagsWidth, Parent = f.main})
		f.consumble:SetFilter(bagConsumble, true)

		f.bagCompanion = MyContainer:New("BagCompanion", {Columns = bagsWidth, Parent = f.main})
		f.bagCompanion:SetFilter(bagMountPet, true)

		f.tradegoods = MyContainer:New("TradeGoods", {Columns = bagsWidth, Parent = f.main})
		f.tradegoods:SetFilter(bagTradeGoods, true)

		f.questitem = MyContainer:New("QuestItem", {Columns = bagsWidth, Parent = f.main})
		f.questitem:SetFilter(bagQuestItem, true)

		f.bank = MyContainer:New("Bank", {Columns = bankWidth, Bags = "bank"})
		f.bank:SetFilter(onlyBank, true)
		f.bank:SetPoint("BOTTOMRIGHT", f.main, "BOTTOMLEFT", -10, 0)
		f.bank:Hide()

		f.bankFavourite = MyContainer:New("BankFavourite", {Columns = bankWidth, Parent = f.bank})
		f.bankFavourite:SetFilter(bankFavourite, true)

		f.bankAzeriteItem = MyContainer:New("BankAzeriteItem", {Columns = bankWidth, Parent = f.bank})
		f.bankAzeriteItem:SetFilter(bankAzeriteItem, true)
		
		f.bankCorruptionItem = MyContainer:New("BankCorruptionItem", {Columns = bankWidth, Parent = f.bank})
		f.bankCorruptionItem:SetFilter(bankCorruptionItem, true)

		f.bankLegendary = MyContainer:New("BankLegendary", {Columns = bankWidth, Parent = f.bank})
		f.bankLegendary:SetFilter(bankLegendary, true)

		f.bankEquipment = MyContainer:New("BankEquipment", {Columns = bankWidth, Parent = f.bank})
		f.bankEquipment:SetFilter(bankEquipment, true)

		f.bankConsumble = MyContainer:New("BankConsumble", {Columns = bankWidth, Parent = f.bank})
		f.bankConsumble:SetFilter(bankConsumble, true)

		f.bankCompanion = MyContainer:New("BankCompanion", {Columns = bankWidth, Parent = f.bank})
		f.bankCompanion:SetFilter(bankMountPet, true)

		f.reagent = MyContainer:New("Reagent", {Columns = bankWidth})
		f.reagent:SetFilter(onlyReagent, true)
		f.reagent:SetPoint("BOTTOMLEFT", f.bank)
		f.reagent:Hide()
	end

	local initBagType
	function Backpack:OnBankOpened()
		BankFrame:Show()
		self:GetContainer("Bank"):Show()

		if not initBagType then
			DUFFEDUI_Backpack:BAG_UPDATE()
			initBagType = true
		end
	end

	function Backpack:OnBankClosed()
		BankFrame.selectedTab = 1
		BankFrame:Hide()
		self:GetContainer("Bank"):Hide()
		self:GetContainer("Reagent"):Hide()
		ReagentBankFrame:Hide()
	end

	local MyButton = Backpack:GetItemButtonClass()
	MyButton:Scaffold("Default")

	function MyButton:OnCreate()
		self:SetNormalTexture(nil)
		self:SetPushedTexture(nil)
		self:SetSize(iconSize, iconSize)

		self.Icon:SetAllPoints()
		self.Icon:SetTexCoord(unpack(D['IconCoord']))
		self.Count:SetPoint("BOTTOMRIGHT", 1, 1)
		self.Count:SetFont(C['media']['font'], 11, 'OUTLINE')

		self:CreateBorder()

		self.junkIcon = self:CreateTexture(nil, "ARTWORK")
		self.junkIcon:SetAtlas("bags-junkcoin")
		self.junkIcon:SetSize(20, 20)
		self.junkIcon:SetPoint("TOPRIGHT", 1, 0)

		self.ScrapIcon = self:CreateTexture(nil, "OVERLAY")
		self.ScrapIcon:SetAtlas("bags-icon-scrappable")
		self.ScrapIcon:SetSize(14, 12)
		self.ScrapIcon:SetPoint("TOPRIGHT", 1, -1)

		self.Quest = self:CreateTexture(nil, "ARTWORK")
		self.Quest:SetSize(26, 26)
		self.Quest:SetTexture("Interface\\AddOns\\DuffedUI\\media\\textures\\QuestIcon.tga")
		self.Quest:ClearAllPoints()
		self.Quest:SetPoint("LEFT", self, "LEFT", 0, 1)

		self.Azerite = self:CreateTexture(nil, "ARTWORK", nil, 1)
		self.Azerite:SetAtlas("AzeriteIconFrame")
		self.Azerite:SetAllPoints()

		self.Corrupt = self:CreateTexture(nil, "ARTWORK")
		self.Corrupt:SetAtlas("Nzoth-inventory-icon")
		self.Corrupt:SetAllPoints()
		
		local parentFrame = CreateFrame("Frame", nil, self)
		
		self.Favourite = self:CreateTexture(nil, "OVERLAY", nil, 2)
		self.Favourite:SetAtlas("collections-icon-favorites")
		self.Favourite:SetSize(24, 24)
		self.Favourite:SetPoint("TOPLEFT", -12, 9)

		if showItemLevel then
			self.iLvl = self:CreateFontString(nil, 'OVERLAY')
			self.iLvl:SetFont(C['media']['font'], 11, 'OUTLINE')
			self.iLvl:SetPoint("BOTTOMLEFT", 1, 1)
			
		end

		self.glowFrame = self:CreateTexture(nil, "OVERLAY")
		self.glowFrame:SetInside(self, 0, 0)
		self.glowFrame:SetAtlas("bags-glow-white")

		self.glowFrame.Animation = self.glowFrame:CreateAnimationGroup()
		self.glowFrame.Animation:SetLooping("BOUNCE")

		self.glowFrame.Animation.FadeOut = self.glowFrame.Animation:CreateAnimation("Alpha")
		self.glowFrame.Animation.FadeOut:SetFromAlpha(1)
		self.glowFrame.Animation.FadeOut:SetToAlpha(0.3)
		self.glowFrame.Animation.FadeOut:SetDuration(0.6)
		self.glowFrame.Animation.FadeOut:SetSmoothing("IN_OUT")

		self:HookScript("OnHide", function()
			if self.glowFrame and self.glowFrame.Animation:IsPlaying() then
				self.glowFrame.Animation:Stop()
				self.glowFrame.Animation.Playing = false
				self.glowFrame:Hide()
			end
		end)

		self:HookScript("OnClick", Module.ButtonOnClick)
	end

	function MyButton:ItemOnEnter()
		if self.glowFrame and self.glowFrame.Animation then
			self.glowFrame.Animation:Stop()
			self.glowFrame.Animation.Playing = false
			self.glowFrame:Hide()
			C_NewItems_RemoveNewItem(self.bagID, self.slotID)
		end
	end
	
	local function isItemNeedsLevel(item)
		return item.link and item.level and item.rarity > 1 and (item.subType == EJ_LOOT_SLOT_FILTER_ARTIFACT_RELIC or item.classID == LE_ITEM_CLASS_WEAPON or item.classID == LE_ITEM_CLASS_ARMOR)
	end

	local bagTypeColor = {
		[0] = {0, 0, 0, .25},
		[1] = false,
		[2] = {0, .5, 0, .25},
		[3] = {.8, 0, .8, .25},
		[4] = {1, .8, 0, .25},
		[5] = {0, .8, .8, .25},
		[6] = {.5, .4, 0, .25},
		[7] = {.8, .5, .5, .25},
		[8] = {.8, .8, .8, .25},
		[9] = {.4, .6, 1, .25},
		[10] = {.8, 0, 0, .25},
	}

	function MyButton:OnUpdate(item)
		if MerchantFrame:IsShown() then
			if item.isInSet then
				self:SetAlpha(.5)
			else
				self:SetAlpha(1)
			end
		end

		if item.rarity == LE_ITEM_QUALITY_POOR and item.sellPrice > 0 then
			self.junkIcon:SetAlpha(1)
		else
			self.junkIcon:SetAlpha(0)
		end
		
		if self.UpgradeIcon then
			Module.UpdateItemUpgradeIcon(self)
		end

		if self.ScrapIcon then
			Module.UpdateItemScrapIcon(self)
		end
		
		if IsAddOnLoaded("CanIMogIt") then
			CIMI_AddToFrame(self, ContainerFrameItemButton_CIMIUpdateIcon)
			ContainerFrameItemButton_CIMIUpdateIcon(self.CanIMogItOverlay)
		end

		if item.link and C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(item.link) then
			self.Azerite:SetAlpha(1)
		else
			self.Azerite:SetAlpha(0)
		end
		
		if item.link and IsCorruptedItem(item.link) then
			self.Corrupt:SetAlpha(1)
		else
			self.Corrupt:SetAlpha(0)
		end

		if DuffedUIData == nil then DuffedUIData = {} end
		if DuffedUIData['FavouriteItems'] == nil then DuffedUIData['FavouriteItems'] = {} end
		if DuffedUIData.FavouriteItems[item.id] then
			self.Favourite:SetAlpha(1)
		else
			self.Favourite:SetAlpha(0)
		end

		if showItemLevel then
			if isItemNeedsLevel(item) then
				local level = D.GetItemLevel(item.link, item.bagID, item.slotID) or item.level
				local color = D.QualityColors[item.rarity]

				self.iLvl:SetText(level)
				self.iLvl:SetTextColor(color.r, color.g, color.b)
			else
				self.iLvl:SetText("")
			end
		end

		if self.glowFrame then
			if C_NewItems_IsNewItem(item.bagID, item.slotID) and self.glowFrame and self.glowFrame.Animation then
				self.glowFrame:Show()
				self.glowFrame.Animation:Play()
				self.glowFrame.Animation.Playing = true
			else
				self.glowFrame.Animation:Stop()
				self.glowFrame.Animation.Playing = false
				self.glowFrame:Hide()
			end
		end
		
		if C["bags"].SpecialBagsColor then
			local bagType = Module.BagsType[item.bagID]
			local color = bagTypeColor[bagType] or bagTypeColor[0]
			self:SetBackdropColor(unpack(color))
		else
			self:SetBackdropColor(.04, .04, .04, 0.9)
		end
	end

	function MyButton:OnUpdateQuest(item)
		if item.questID and not item.questActive then
			self.Quest:SetAlpha(1)
		else
			self.Quest:SetAlpha(0)
		end

		if item.questID or item.isQuestItem then
			self:SetBackdropBorderColor(1, 0.30, 0.30)
		elseif item.rarity and item.rarity > -1 then
			local color =  D.QualityColors[item.rarity]
			self:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			self:SetBackdropBorderColor()
		end
	end

	local MyContainer = Backpack:GetContainerClass()
	function MyContainer:OnContentsChanged()
		self:SortButtons("bagSlot")

		local columns = self.Settings.Columns
		local offset = 38
		local spacing = 5
		local xOffset = 5
		local yOffset = -offset + spacing
		local _, height = self:LayoutButtons("grid", columns, spacing, xOffset, yOffset)
		local width = columns * (iconSize+spacing) - spacing
		if self.freeSlot then
			if C["bags"].GatherEmpty then
				local numSlots = #self.buttons + 1
				local row = ceil(numSlots / columns)
				local col = numSlots % columns
				if col == 0 then
					col = columns
				end

				local xPos = (col-1) * (iconSize + spacing)
				local yPos = -1 * (row-1) * (iconSize + spacing)

				self.freeSlot:ClearAllPoints()
				self.freeSlot:SetPoint("TOPLEFT", self, "TOPLEFT", xPos+xOffset, yPos+yOffset)
				self.freeSlot:Show()

				if height < 0 then
					height = iconSize
				elseif col == 1 then
					height = height + iconSize + spacing
				end
			else
				self.freeSlot:Hide()
			end
		end
		self:SetSize(width + xOffset * 2, height + offset)

		Module:UpdateAnchors(f.main, {f.azeriteItem, f.corruptionItem, f.equipment, f.bagCompanion, f.consumble, f.bagFavourite, f.tradegoods, f.questitem, f.junk})
		Module:UpdateAnchors(f.bank, {f.bankAzeriteItem, f.bankCorruptionItem, f.bankEquipment, f.bankLegendary, f.bankCompanion, f.bankConsumble, f.bankFavourite})
	end

	function MyContainer:OnCreate(name, settings)
		self.Settings = settings
		self:SetParent(settings.Parent or Backpack)
		self:SetFrameStrata("HIGH")
		self:SetClampedToScreen(true)
		self:CreateBorder()
		self:SetMovable(true)
		self:RegisterForDrag('LeftButton', 'RightButton')
		move:RegisterFrame(self, settings.Parent, true)

		local label
		if string_match(name, "AzeriteItem$") then
			label = "Azerite Armor"
		elseif string_match(name, "CorruptionItem$") then
			label = CORRUPTION_TOOLTIP_TITLE
		elseif string_match(name, "Equipment$") then
			if itemSetFilter then
				label = "Equipement Set"
			else
				label = BAG_FILTER_EQUIPMENT
			end
		elseif name == "BankLegendary" then
			label = LOOT_JOURNAL_LEGENDARIES
		elseif string_match(name, "Consumble$") then
			label = BAG_FILTER_CONSUMABLES
		elseif string_match(name, "TradeGoods$") then
			label = BAG_FILTER_TRADE_GOODS
		elseif string_match(name, "QuestItem$") then
			label = AUCTION_CATEGORY_QUEST_ITEMS
		elseif name == "Junk" then
			label = BAG_FILTER_JUNK
		elseif string_match(name, "Companion") then
			label = MOUNTS_AND_PETS
		elseif string_match(name, "Favourite") then
			label = PREFERENCES
		end

		if label then
			D.CreateFontString(self, 13, label, "OUTLINE", true, "TOPLEFT", 5, -8)
			return
		end

		Module.CreateInfoFrame(self)

		local buttons = {}
		buttons[1] = Module.CreateCloseButton(self)
		if name == "Main" then
			Module.CreateBagBar(self, settings, 4)
			buttons[2] = Module.CreateRestoreButton(self, f)
			buttons[3] = Module.CreateBagToggle(self)
			--buttons[4] = Module.CreateSortButton(self, name)
			buttons[5] = Module.CreateFavouriteButton(self)
			if deleteButton then
				buttons[6] = Module.CreateDeleteButton(self)
			end
		elseif name == "Bank" then
			Module.CreateBagBar(self, settings, 7)
			buttons[2] = Module.CreateReagentButton(self, f)
			buttons[3] = Module.CreateBagToggle(self)
		elseif name == "Reagent" then
			buttons[2] = Module.CreateBankButton(self, f)
			buttons[3] = Module.CreateDepositButton(self)
		end
		buttons[4] = Module.CreateSortButton(self, name)

		for i = 1, 6 do
			local bu = buttons[i]
			if not bu then break end
			if i == 1 then
				bu:SetPoint("TOPRIGHT", -6, -6)
			else
				bu:SetPoint("RIGHT", buttons[i-1], "LEFT", -5, 0)
			end
		end
		
		self:SetScript('OnDragStart', function(self)
			if IsShiftKeyDown() then
				self:StartMoving()
				DragFunction(self, true)
			end
		end)

		self:SetScript('OnDragStop', function(self)
			self:StopMovingOrSizing()
			DragFunction(self, false)
		end)

		self:SetScript('OnEnter', function(self)
			if GameTooltip:IsForbidden() then
				return
			end

			GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 0, 4)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(L['bags']['Shift_Move'])

			GameTooltip:Show()
		end)

		self:SetScript('OnLeave', function()
			if not GameTooltip:IsForbidden() then
				GameTooltip:Hide()
			end
		end)

		self.iconSize = iconSize
		Module.CreateFreeSlots(self)
	end

	local BagButton = Backpack:GetClass("BagButton", true, "BagButton")
	function BagButton:OnCreate()
		self:SetNormalTexture(nil)
		self:SetPushedTexture(nil)

		self:SetSize(iconSize, iconSize)
		self:CreateBorder()

		self.Icon:SetAllPoints()
		self.Icon:SetTexCoord(unpack(D['IconCoord']))
	end

	function BagButton:OnUpdate()
		local id = GetInventoryItemID("player", (self.GetInventorySlot and self:GetInventorySlot()) or self.invID)
		if not id then return end
		local _, _, quality, _, _, _, _, _, _, _, _, classID, subClassID = GetItemInfo(id)
		if not quality or quality == 1 then quality = 0 end
		local color = D.QualityColors[quality]
		if not self.hidden and not self.notBought then
			self:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			self:SetBackdropBorderColor()
		end

		if classID == LE_ITEM_CLASS_CONTAINER then
			Module.BagsType[self.bagID] = subClassID or 0
		else
			Module.BagsType[self.bagID] = 0
		end
	end

	ToggleAllBags()
	ToggleAllBags()
	Module.initComplete = true

	ReagentBankFrame:Kill()
	BankFrame:Kill()
	BankFrame.GetRight = function()
		return f.bank:GetRight()
	end
	BankFrameItemButton_Update = D.Noop

	SetSortBagsRightToLeft(not C["bags"].ReverseSort)
	SetInsertItemsLeftToRight(false)
end