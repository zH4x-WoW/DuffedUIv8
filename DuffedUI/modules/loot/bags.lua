local D, C, L, G = unpack(select(2,  ...))

local _G = _G
local Noop = function() end
local ReplaceBags = 0
local LastButtonBag, LastButtonBank, LastButtonReagent
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local ReagentBankFrame = ReagentBankFrame
local BagHelpBox = BagHelpBox
local ButtonSize, ButtonSpacing, ItemsPerRow
local Bags = CreateFrame('Frame')
local QuestColor = {1, 1, 0}

local BlizzardBags = {
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
}

local BlizzardBank = {
	BankSlotsFrame['Bag1'],
	BankSlotsFrame['Bag2'],
	BankSlotsFrame['Bag3'],
	BankSlotsFrame['Bag4'],
	BankSlotsFrame['Bag5'],
	BankSlotsFrame['Bag6'],
	BankSlotsFrame['Bag7'],
}

local BagType = {
	[8] = true,     -- Leatherworking Bag
	[16] = true,    -- Inscription Bag
	[32] = true,    -- Herb Bag
	[64] = true,    -- Enchanting Bag
	[128] = true,   -- Engineering Bag
	[512] = true,   -- Gem Bag
	[1024] = true,  -- Mining Bag
	[32768] = true, -- Fishing Bag
}

function Bags:IsProfessionBag(bag)
	local Type = select(2, GetContainerNumFreeSlots(bag))
	if BagType[Type] then return true end
end

function Bags:SkinBagButton()
	if self.IsSkinned then return end

	local Icon = _G[self:GetName()..'IconTexture']
	local Quest = _G[self:GetName()..'IconQuestTexture']
	local JunkIcon = self.JunkIcon
	local Border = self.IconBorder
	local BattlePay = self.BattlepayItemTexture

	Border:SetAlpha(0)

	Icon:SetTexCoord(unpack(D['IconCoord']))
	Icon:SetInside(self)

	if Quest then Quest:SetAlpha(0) end
	if JunkIcon then JunkIcon:SetAlpha(0) end
	if BattlePay then BattlePay:SetAlpha(0) end

	self:SetNormalTexture('')
	self:SetPushedTexture('')
	self:SetTemplate()
	self:StyleButton()

	self.IsSkinned = true
end

function Bags:HideBlizzard()
	local TokenFrame = _G['BackpackTokenFrame']
	local Inset = _G['BankFrameMoneyFrameInset']
	local Border = _G['BankFrameMoneyFrameBorder']
	local BankClose = _G['BankFrameCloseButton']
	local BankPortraitTexture = _G['BankPortraitTexture']
	local BankSlotsFrame = _G['BankSlotsFrame']

	TokenFrame:GetRegions():SetAlpha(0)
	Inset:Hide()
	Border:Hide()
	BankClose:Hide()
	BankPortraitTexture:Hide()
	BagHelpBox:Kill()
	BankFrame:EnableMouse(false)
	BankFrame.NineSlice:Kill()

	for i = 1, 12 do
		local CloseButton = _G['ContainerFrame'..i..'CloseButton']
		CloseButton:Hide()

		for k = 1, 7 do
			local Container = _G['ContainerFrame'..i]
			select(k, Container:GetRegions()):SetAlpha(0)
		end
	end

	for i = 1, BankFrame:GetNumRegions() do
		local Region = select(i, BankFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, BankSlotsFrame:GetNumRegions() do
		local Region = select(i, BankSlotsFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, 2 do
		local Tab = _G['BankFrameTab'..i]
		Tab:Hide()
	end
end

function Bags:CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame('Frame', 'DuffedUIReagent', UIParent)
	local SwitchBankButton = CreateFrame('Button', nil, Reagent)
	local SortButton = CreateFrame('Button', nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton
	local Movers = D['move']

	Reagent:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	if C['chat']['lbackground'] then Reagent:SetPoint('BOTTOMLEFT', DuffedUIChatBackgroundLeft, 'TOPLEFT', 0, 5) else Reagent:SetPoint('BOTTOMLEFT', DuffedUIInfoLeft, 'TOPLEFT', 0, 5) end
	Reagent:SetTemplate('Transparent')
	Reagent:SetFrameStrata(self.Bank:GetFrameStrata())
	Reagent:SetFrameLevel(self.Bank:GetFrameLevel())

	SwitchBankButton:Size(75, 23)
	SwitchBankButton:SkinButton()
	SwitchBankButton:Point('BOTTOMLEFT', Reagent, 'BOTTOMLEFT', 10, 7)
	SwitchBankButton:FontString('Text', C['media']['font'], 11, 'THINOUTLINE')
	SwitchBankButton.Text:SetPoint('CENTER')
	SwitchBankButton.Text:SetText(BANK)
	SwitchBankButton.Text:SetTextColor(1, 1, 1)
	SwitchBankButton:SetScript('OnClick', function()
		Reagent:Hide()
		self.Bank:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)

		for i = 5, 11 do
			if (not IsBagOpen(i)) then self:OpenBag(i, 1) end
		end
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:Size(120, 23)
	Deposit:Point('BOTTOM', Reagent, 'BOTTOM', 0, 7)
	Deposit:SkinButton()

	if C['bags']['SortingButton'] then
		SortButton:Size(75, 23)
		SortButton:SetPoint('BOTTOMRIGHT', Reagent, 'BOTTOMRIGHT', -10, 7)
		SortButton:SkinButton()
		SortButton:FontString('Text', C['media']['font'], 11, 'THINOUTLINE')
		SortButton.Text:SetPoint('CENTER')
		SortButton.Text:SetText(BAG_FILTER_CLEANUP)
		SortButton.Text:SetTextColor(1, 1, 1)
		SortButton:SetScript('OnClick', BankFrame_AutoSortButtonOnClick)
	end

	for i = 1, 98 do
		local Button = _G['ReagentBankFrameItem'..i]
		local Count = _G[Button:GetName()..'Count']
		local Icon = _G[Button:GetName()..'IconTexture']

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetNormalTexture('')
		Button:SetPushedTexture('')
		Button:SetHighlightTexture('')
		Button:SetTemplate()
		Button.IconBorder:SetAlpha(0)
		if (i == 1) then
			Button:SetPoint('TOPLEFT', Reagent, 'TOPLEFT', 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint('TOPRIGHT', LastRowButton, 'TOPRIGHT', 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint('BOTTOMLEFT', LastRowButton, 'BOTTOMLEFT', 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint('TOPRIGHT', LastButton, 'TOPRIGHT', (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint('BOTTOMLEFT', LastButton, 'BOTTOMLEFT', (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end
		Icon:SetTexCoord(unpack(D['IconCoord']))
		Icon:SetInside()
		LastButton = Button
		self:SlotUpdate(-3, Button)

		Count:ClearAllPoints()
		Count:SetPoint('BOTTOMRIGHT', -3, 3)
		Count:SetFont(C['media']['font'], 11, 'THINOUTLINE')
		Count:SetTextColor(1, 1, 1)
	end

	Reagent:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
	Reagent:SetScript('OnHide', function() ReagentBankFrame:Hide() end)

	local Unlock = ReagentBankFrameUnlockInfo
	local UnlockButton = ReagentBankFrameUnlockInfoPurchaseButton

	Unlock:StripTextures()
	Unlock:SetAllPoints(Reagent)
	Unlock:SetTemplate('Transparent')
	UnlockButton:SkinButton()
	ReagentBankFrameUnlockInfoText:SetFont(C['media']['font'], 10)
	Movers:RegisterFrame(Reagent)

	self.Reagent = Reagent
	self.Reagent.SwitchBankButton = SwitchBankButton
	self.Reagent.SortButton = SortButton
end

function Bags:CreateContainer(storagetype, ...)
	local Container = CreateFrame('Frame', 'DuffedUI'.. storagetype, UIParent)
	Container:SetScale(C['bags']['scale'])
	Container:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Container:SetPoint(...)
	Container:SetFrameStrata('MEDIUM')
	Container:SetFrameLevel(50)
	Container:Hide()
	Container:SetTemplate('Transparent')
	Container:EnableMouse(true)

	if (storagetype == 'Bag') then
		local Sort = BagItemAutoSortButton
		local BagsContainer = CreateFrame('Frame', nil, UIParent)
		local ToggleBagsContainer = CreateFrame('Frame')

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint('BOTTOMRIGHT', Container, 'BOTTOMLEFT', -3, 0)
		BagsContainer:SetTemplate('Transparent')

		if C['bags']['SortingButton'] then
			Sort:Size(75, 23)
			Sort:ClearAllPoints()
			Sort:SetPoint('BOTTOMLEFT', Container, 'BOTTOMLEFT', 10, 7)
			Sort:SetFrameLevel(Container:GetFrameLevel())
			Sort:SetFrameStrata(Container:GetFrameStrata())
			Sort:StripTextures()
			Sort:SkinButton()
			Sort:FontString(Text, C['media']['font'], 11)
			Sort.Text:SetPoint('CENTER', 0, 0)
			Sort.Text:SetText(BAG_FILTER_CLEANUP)
			Sort.Text:SetTextColor(1, 1, 1)
			Sort.ClearAllPoints = D['Dummy']
			Sort.SetPoint = D['Dummy']
		end

		ToggleBagsContainer:SetHeight(20)
		ToggleBagsContainer:SetWidth(20)
		ToggleBagsContainer:SetPoint('TOPRIGHT', Container, 'TOPRIGHT', -6, -6)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer:EnableMouse(true)
		ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString('button')
		ToggleBagsContainer.Text:SetPoint('CENTER', ToggleBagsContainer, 'CENTER')
		ToggleBagsContainer.Text:SetFont(C['media']['font'], 11)
		ToggleBagsContainer.Text:SetText('X')
		ToggleBagsContainer.Text:SetTextColor(.5, .5, .5)
		ToggleBagsContainer:SetScript('OnMouseUp', function(self, button)
			CloseBankFrame()
			ToggleAllBags()
		end)

		for _, Button in pairs(BlizzardBags) do
			local Count = _G[Button:GetName()..'Count']
			local Icon = _G[Button:GetName()..'IconTexture']

			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata('HIGH')
			Button:SetFrameLevel(3)
			Button:SetNormalTexture('')
			Button:SetPushedTexture('')
			Button:SetCheckedTexture('')
			Button:SetTemplate()
			Button.IconBorder:SetAlpha(0)
			Button:SkinButton()
			if LastButtonBag then Button:SetPoint('TOP', LastButtonBag, 'BOTTOM', 0, -4) else Button:SetPoint('TOPLEFT', BagsContainer, 'TOPLEFT', 4, -4) end

			Icon:SetTexCoord(unpack(D['IconCoord']))
			Icon:SetInside()
			LastButtonBag = Button
			BagsContainer:SetWidth(ButtonSize + (ButtonSpacing * 2))
			BagsContainer:SetHeight((ButtonSize * getn(BlizzardBags)) + (ButtonSpacing * (getn(BlizzardBags) + 1)))
		end

		Container.BagsContainer = BagsContainer
		Container.CloseButton = ToggleBagsContainer
		Container.SortButton = Sort
	else
		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		local SortButton = CreateFrame('Button', nil, Container)
		local BankBagsContainer = CreateFrame('Frame', nil, Container)

		CostText:ClearAllPoints()
		CostText:SetPoint('BOTTOMLEFT', 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint('LEFT', CostText, 'RIGHT', 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint('BOTTOMRIGHT', -10, 10)
		PurchaseButton:SkinButton()
		BankItemAutoSortButton:Hide()

		local SwitchReagentButton = CreateFrame('Button', nil, Container)
		SwitchReagentButton:Size(85, 23)
		SwitchReagentButton:SkinButton()
		SwitchReagentButton:Point('BOTTOMLEFT', Container, 'BOTTOMLEFT', 10, 7)
		SwitchReagentButton:FontString('Text', C['media']['font'], 11, 'THINOUTLINE')
		SwitchReagentButton.Text:SetPoint('CENTER')
		SwitchReagentButton.Text:SetText(REAGENT_BANK)
		SwitchReagentButton.Text:SetTextColor(1, 1, 1)
		SwitchReagentButton:SetScript('OnClick', function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			if (not ReagentBankFrame.isMade) then
				self:CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				self.Reagent:Show()
			end
			for i = 5, 11 do self:CloseBag(i) end
		end)

		if C['bags']['SortingButton'] then
			SortButton:Size(75, 23)
			SortButton:SetPoint('BOTTOMRIGHT', Container, 'BOTTOMRIGHT', -10, 7)
			SortButton:SkinButton()
			SortButton:FontString('Text', C['media']['font'], 11, 'THINOUTLINE')
			SortButton.Text:SetPoint('CENTER')
			SortButton.Text:SetText(BAG_FILTER_CLEANUP)
			SortButton.Text:SetTextColor(1, 1, 1)
			SortButton:SetScript('OnClick', BankFrame_AutoSortButtonOnClick)
		end

		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth())
		Purchase:SetHeight(70)
		Purchase:SetPoint('BOTTOM', Container, 'TOP', 0, 3)
		Purchase:CreateBackdrop('Transparent')
		Purchase.backdrop:SetPoint('TOPLEFT', 0, 0)
		Purchase.backdrop:SetPoint('BOTTOMRIGHT', 0, 0)

		BankBagsContainer:Size(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		BankBagsContainer:SetTemplate()
		BankBagsContainer:SetPoint('BOTTOMLEFT', SwitchReagentButton, 'TOPLEFT', 0, 2)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		for i = 1, 7 do
			local Bag = BankSlotsFrame['Bag'..i]
			Bag:SetParent(BankBagsContainer)
			Bag:SetWidth(ButtonSize)
			Bag:SetHeight(ButtonSize)
			Bag.IconBorder:SetAlpha(0)
			Bag.icon:SetTexCoord(unpack(D['IconCoord']))
			Bag.icon:SetInside()
			Bag:SkinButton()
			Bag:ClearAllPoints()
			if i == 1 then Bag:SetPoint('TOPLEFT', BankBagsContainer, 'TOPLEFT', ButtonSpacing, -ButtonSpacing) else Bag:SetPoint('TOP', BankSlotsFrame['Bag' .. i-1], 'BOTTOM', 0, -ButtonSpacing) end
		end

		BankBagsContainer:SetParent(Container)
		BankBagsContainer:SetWidth(ButtonSize + (ButtonSpacing * 2))
		BankBagsContainer:SetHeight((ButtonSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetTemplate('Transparent')
		BankBagsContainer:ClearAllPoints()
		BankBagsContainer:SetPoint('BOTTOMLEFT', Container, 'BOTTOMRIGHT', 3, 0)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		BankFrame:EnableMouse(false)

		Container.BagsContainer = BankBagsContainer
		Container.ReagentButton = SwitchReagentButton
		Container.SortButton = SortButton
	end
	self[storagetype] = Container
end

function Bags:SetBagsSearchPosition()
	local BagItemSearchBox = BagItemSearchBox
	local BankItemSearchBox = BankItemSearchBox

	BagItemSearchBox:SetParent(self.Bag)
	BagItemSearchBox:SetWidth(BagItemSearchBox:GetWidth() + 25)
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint('TOPRIGHT', self.Bag, 'TOPRIGHT', -28, -10)
	BagItemSearchBox:StripTextures()
	BagItemSearchBox.SetParent = D['Dummy']
	BagItemSearchBox.ClearAllPoints = D['Dummy']
	BagItemSearchBox.SetPoint = D['Dummy']
	BagItemSearchBox.Backdrop = CreateFrame('Frame', nil, BagItemSearchBox)
	BagItemSearchBox.Backdrop:SetPoint('TOPLEFT', 7, 4)
	BagItemSearchBox.Backdrop:SetPoint('BOTTOMRIGHT', 2, -2)
	BagItemSearchBox.Backdrop:SetTemplate()
	BagItemSearchBox.Backdrop:SetFrameLevel(BagItemSearchBox:GetFrameLevel() - 1)

	BankItemSearchBox:Hide()
end

function Bags:SlotUpdate(id, button)
	if not button then return end

	local ItemLink = GetContainerItemLink(id, button:GetID())
	local Texture, Count, Lock, quality, _, _, _, _, _, ItemID = GetContainerItemInfo(id, button:GetID())
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())

	if IsNewItem ~= true and button.Animation and button.Animation:IsPlaying() then button.Animation:Stop() end
	if (button.ItemID == ItemID) then return end

	button.ItemID = ItemID

	local IsQuestItem, QuestId, IsActive = GetContainerItemQuestInfo(id, button:GetID())
	local IsBattlePayItem = IsBattlePayItem(id, button:GetID())
	local NewItem = button.NewItemTexture
	local IconQuestTexture = button.IconQuestTexture

	if IconQuestTexture then IconQuestTexture:SetAlpha(0) end

	if IsNewItem and NewItem then
		NewItem:SetAlpha(0)

		if C['bags']['Bounce'] then
			if not button.Animation then
				button.Animation = button:CreateAnimationGroup()
				button.Animation:SetLooping('BOUNCE')
				button.FadeOut = button.Animation:CreateAnimation('Alpha')
				button.FadeOut:SetFromAlpha(1)
				button.FadeOut:SetToAlpha(0)
				button.FadeOut:SetDuration(0.40)
				button.FadeOut:SetSmoothing('IN_OUT')
			end
			button.Animation:Play()
		end
	end

	if IsQuestItem then
		button:SetBackdropBorderColor(1, 1, 0)
	elseif ItemLink then
		local Rarity = select(3, GetItemInfo(ItemLink)) or 0
		if (Rarity and Rarity > 1) then button:SetBackdropBorderColor(GetItemQualityColor(Rarity)) else button:SetBackdropBorderColor(unpack(C['general']['bordercolor'])) end
	else
		button:SetBackdropBorderColor(unpack(C['general']['bordercolor']))
	end
end

function Bags:BagUpdate(id)
	local Size = GetContainerNumSlots(id)

	for Slot = 1, Size do
		local Button = _G['ContainerFrame'..(id + 1)..'Item'..Slot]
		local Count = _G[Button:GetName()..'Count']

		if Button then
			if not Button:IsShown() then Button:Show() end
			self:SlotUpdate(id, Button)
			Count:ClearAllPoints()
			Count:SetPoint('BOTTOMRIGHT', 0, 3)
			Count:SetFont(C['media']['font'], 11, 'THINOUTLINE')
			Count:SetTextColor(1, 1, 1)
		end
	end
end

function Bags:UpdateAllBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	local FirstButton

	for Bag = 5, 1, -1 do
		local ID = Bag - 1
		local Slots = GetContainerNumSlots(ID)

		for Item = Slots, 1, -1 do
			local Button = _G['ContainerFrame'..Bag..'Item'..Item]
			local Money = ContainerFrame1MoneyFrame

			if not FirstButton then FirstButton = Button end

			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetScale(C['bags']['scale'])
			Button:SetFrameStrata('HIGH')
			Button:SetFrameLevel(2)
			Button.newitemglowAnim:Stop()
			Button.newitemglowAnim.Play = Noop
			Button.flashAnim:Stop()
			Button.flashAnim.Play = Noop

			Money:ClearAllPoints()
			Money:Show()
			Money:SetPoint('TOPLEFT', Bags.Bag, 'TOPLEFT', 8, -10)
			Money:SetFrameStrata('HIGH')
			Money:SetFrameLevel(2)
			Money:SetScale(C['bags']['scale'])

			if (Button == FirstButton) then
				Button:SetPoint('TOPLEFT', Bags.Bag, 'TOPLEFT', 10, -40)
				LastRowButton = Button
				LastButton = Button
			elseif (NumButtons == ItemsPerRow) then
				Button:SetPoint('TOPRIGHT', LastRowButton, 'TOPRIGHT', 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint('BOTTOMLEFT', LastRowButton, 'BOTTOMLEFT', 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint('TOPRIGHT', LastButton, 'TOPRIGHT', (ButtonSpacing + ButtonSize), 0)
				Button:SetPoint('BOTTOMLEFT', LastButton, 'BOTTOMLEFT', (ButtonSpacing + ButtonSize), 0)
				NumButtons = NumButtons + 1
			end
			Bags.SkinBagButton(Button)
			LastButton = Button
		end
		Bags:BagUpdate(ID)
	end
	Bags.Bag:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 54 + BagItemSearchBox:GetHeight() + (ButtonSpacing * 4)) - ButtonSpacing)
end

function Bags:UpdateAllBankBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1

	for Bank = 1, 28 do
		local Button = _G['BankFrameItem'..Bank]
		local Count = _G[Button:GetName()..'Count']
		local Money = ContainerFrame2MoneyFrame
		local BankFrameMoneyFrame = BankFrameMoneyFrame

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetFrameStrata('HIGH')
		Button:SetFrameLevel(2)
		Button:SetScale(C['bags']['scale'])
		Button.IconBorder:SetAlpha(0)
		BankFrameMoneyFrame:Hide()

		if (Bank == 1) then
			Button:SetPoint('TOPLEFT', Bags.Bank, 'TOPLEFT', 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint('TOPRIGHT', LastRowButton, 'TOPRIGHT', 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint('BOTTOMLEFT', LastRowButton, 'BOTTOMLEFT', 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint('TOPRIGHT', LastButton, 'TOPRIGHT', (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint('BOTTOMLEFT', LastButton, 'BOTTOMLEFT', (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end
		Bags.SkinBagButton(Button)
		Bags.SlotUpdate(self, -1, Button)
		LastButton = Button

		Count:ClearAllPoints()
		Count:SetPoint('BOTTOMRIGHT', 0, 3)
		Count:SetFont(C['media']['font'], 11, 'THINOUTLINE')
		Count:SetTextColor(1, 1, 1)
	end

	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)

		for Item = Slots, 1, -1 do
			local Button = _G['ContainerFrame'..Bag..'Item'..Item]
			local Count = _G[Button:GetName()..'Count']

			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata('HIGH')
			Button:SetFrameLevel(2)
			Button:SetScale(C['bags']['scale'])
			Button.IconBorder:SetAlpha(0)

			if (NumButtons == ItemsPerRow) then
				Button:SetPoint('TOPRIGHT', LastRowButton, 'TOPRIGHT', 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint('BOTTOMLEFT', LastRowButton, 'BOTTOMLEFT', 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint('TOPRIGHT', LastButton, 'TOPRIGHT', (ButtonSpacing+ButtonSize), 0)
				Button:SetPoint('BOTTOMLEFT', LastButton, 'BOTTOMLEFT', (ButtonSpacing+ButtonSize), 0)
				NumButtons = NumButtons + 1
			end
			Bags.SkinBagButton(Button)
			Bags.SlotUpdate(self, Bag - 1, Button)
			LastButton = Button

			Count:ClearAllPoints()
			Count:SetPoint('BOTTOMRIGHT', 0, 3)
			Count:SetFont(C['media']['font'], 11, 'THINOUTLINE')
			Count:SetTextColor(1, 1, 1)
		end
	end
	Bags.Bank:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
end

function Bags:OpenBag(id)
	if (not CanOpenPanels()) then
		if (UnitIsDead('player')) then NotWhileDeadError() end
		return
	end

	local Size = GetContainerNumSlots(id)
	local OpenFrame = ContainerFrame_GetOpenFrame()
	for i = 1, Size, 1 do
		local Index = Size - i + 1
		local Button = _G[OpenFrame:GetName()..'Item'..i]

		Button:SetID(Index)
		Button:Show()
	end

	OpenFrame.size = Size
	OpenFrame:SetID(id)
	OpenFrame:Show()
	if (id == 4) then Bags:UpdateAllBags() elseif (id == 11) then Bags:UpdateAllBankBags() end
end

function Bags:CloseBag(id) CloseBag(id) end

function Bags:OpenAllBags()
	self:OpenBag(0, 1)
	for i = 1, 4 do self:OpenBag(i, 1) end

	if IsBagOpen(0) then
		self.Bag:Show()
		if not self.Bag.MoverAdded then
			local Movers = D['move']
			Movers:RegisterFrame(self.Bag)
			self.Bag.MoverAdded = true
		end
	end
end

function Bags:OpenAllBankBags()
	local Bank = BankFrame

	if Bank:IsShown() then
		self.Bank:Show()

		for i = 5, 11 do
			if (not IsBagOpen(i)) then self:OpenBag(i, 1) end
		end

		if not self.Bank.MoverAdded then
			local Movers = D['move']
			Movers:RegisterFrame(self.Bank)
			self.Bank.MoverAdded = true
		end
	end
end

function Bags:CloseAllBags()
	if MerchantFrame:IsVisible() or InboxFrame:IsVisible() then return end
	CloseAllBags()
	PlaySound(863)
end

function Bags:CloseAllBankBags()
	local Bank = BankFrame

	if (Bank:IsVisible()) then
		CloseBankBagFrames()
		CloseBankFrame()
	end
end

function Bags:ToggleBags()
	if (self.Bag:IsShown() and BankFrame:IsShown()) and (not self.Bank:IsShown())  and (not ReagentBankFrame:IsShown()) then
		self:OpenAllBankBags()
		return
	end

	if (self.Bag:IsShown() or self.Bank:IsShown()) then
		if MerchantFrame:IsVisible() or InboxFrame:IsVisible() then return end
		self:CloseAllBags()
		self:CloseAllBankBags()
		return
	end

	if not self.Bag:IsShown() then self:OpenAllBags() end
	if not self.Bank:IsShown() and BankFrame:IsShown() then self:OpenAllBankBags() end
end

function Bags:OnEvent(event, ...)
	if (event == 'BAG_UPDATE') then
		self:BagUpdate(...)
	elseif (event == 'BAG_CLOSED') then
		local Bag = ... + 1
		local Container = _G['ContainerFrame'..Bag]
		local Size = Container.size

		for i = 1, Size do
			local Button = _G['ContainerFrame'..Bag..'Item'..i]
			if Button then Button:Hide() end
		end

		self:CloseAllBags()
		self:CloseAllBankBags()
	elseif (event == 'PLAYERBANKSLOTS_CHANGED') then
		local ID = ...
		if ID <= 28 then
			local Button = _G['BankFrameItem'..ID]
			if (Button) then self:SlotUpdate(-1, Button) end
		end
	elseif (event == 'PLAYERREAGENTBANKSLOTS_CHANGED') then
		local ID = ...
		local Button = _G['ReagentBankFrameItem'..ID]
		if (Button) then self:SlotUpdate(-3, Button) end
	end
end

function Bags:Enable()
	if not C['bags']['enable'] then return end

	SetSortBagsRightToLeft(C['bags']['BagsRtL'])
	SetInsertItemsLeftToRight(C['bags']['ItemsLtR'])

	Font = C['media']['font']
	ButtonSize = C['bags']['buttonsize']
	ButtonSpacing = C['bags']['spacing']
	ItemsPerRow = C['bags']['bpr']

	local Bag = ContainerFrame1
	local GameMenu = GameMenuFrame
	local Bank = BankFrameItem1
	local BankFrame = BankFrame

	if C['chat']['rbackground'] then self:CreateContainer('Bag', 'BOTTOMRIGHT', DuffedUIChatBackgroundRight, 'TOPRIGHT', 0, 5) else self:CreateContainer('Bag', 'BOTTOMRIGHT', DuffedUIInfoRight, 'TOPRIGHT', 0, 5) end
	if C['chat']['lbackground'] then self:CreateContainer('Bank', 'BOTTOMLEFT', DuffedUIChatBackgroundLeft, 'TOPLEFT', 0, 5) else self:CreateContainer('Bank', 'BOTTOMLEFT', DuffedUIInfoLeft, 'TOPLEFT', 0, 5) end
	self:HideBlizzard()
	self:SetBagsSearchPosition()

	Bag:SetScript('OnHide', function()
		self.Bag:Hide()
		if self.Reagent and self.Reagent:IsShown() then self.Reagent:Hide() end
	end)

	Bank:SetScript('OnHide', function() self.Bank:Hide() end)

	BankFrame:HookScript('OnHide', function()
		if self.Reagent and self.Reagent:IsShown() then self.Reagent:Hide() end
	end)

	function UpdateContainerFrameAnchors() end
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags() end
	function OpenBackpack() ToggleAllBags() end
	function ToggleAllBags() self:ToggleBags() end

	self:RegisterEvent('BAG_UPDATE')
	self:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
	self:RegisterEvent('PLAYERREAGENTBANKSLOTS_CHANGED')
	self:RegisterEvent('BAG_CLOSED')
	self:SetScript('OnEvent', self.OnEvent)

	function ManageBackpackTokenFrame() end
end

Bags:RegisterEvent('ADDON_LOADED')
Bags:RegisterEvent('PLAYER_ENTERING_WORLD')
Bags:SetScript('OnEvent', function(self, event, ...)
	Bags:Enable()
end)