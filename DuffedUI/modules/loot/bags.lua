local D, C, L, G = unpack(select(2,  ...))
if not C["bags"].enable == true then return end

-- Modified Script from Tukui T16
local _G = _G
local Noop = function() end
local ReplaceBags = 0
local LastButtonBag, LastButtonBank, LastButtonReagent
local Token1, Token2, Token3 = BackpackTokenFrameToken1, BackpackTokenFrameToken2, BackpackTokenFrameToken3
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local ReagentBankFrame = ReagentBankFrame
local BagHelpBox = BagHelpBox
local ButtonSize = C["bags"].buttonsize
local ButtonSpacing = C["bags"].spacing
local ItemsPerRow = C["bags"].bpr
local Bags = CreateFrame("Frame")

local Boxes = {
	BagItemSearchBox,
	BankItemSearchBox,
}

local BlizzardBags = {
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
}

local BlizzardBank = {
	BankFrameBag1,
	BankFrameBag2,
	BankFrameBag3,
	BankFrameBag4,
	BankFrameBag5,
	BankFrameBag6,
	BankFrameBag7,
}

function Bags:SkinBagButton()
	if self.IsSkinned then return end

	local Icon = _G[self:GetName()  ..  "IconTexture"]
	local Quest = _G[self:GetName()  ..  "IconQuestTexture"]
	local JunkIcon = self.JunkIcon
	local Border = self.IconBorder
	local BattlePay = self.BattlepayItemTexture

	Border:SetAlpha(0)

	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:SetInside(self)
	if Quest then Quest:SetAlpha(0) end
	if JunkIcon then JunkIcon:SetAlpha(0) end
	if BattlePay then BattlePay:SetAlpha(0) end

	self:SetNormalTexture("")
	self:SetPushedTexture("")
	self:SetTemplate()
	self:StyleButton()

	self.IsSkinned = true
end

function Bags:HideBlizzard()
	local TokenFrame = _G["BackpackTokenFrame"]
	local Inset = _G["BankFrameMoneyFrameInset"]
	local Border = _G["BankFrameMoneyFrameBorder"]
	local BankClose = _G["BankFrameCloseButton"]
	local BankPortraitTexture = _G["BankPortraitTexture"]
	local BankSlotsFrame = _G["BankSlotsFrame"]

	TokenFrame:GetRegions():SetAlpha(0)
	Inset:Hide()
	Border:Hide()
	BankClose:Hide()
	BankPortraitTexture:Hide()
	BagHelpBox:Kill()
	BankFrame:EnableMouse(0)

	for i = 1, 12 do
		local CloseButton = _G["ContainerFrame" .. i .. "CloseButton"]
		CloseButton:Hide()
		for k = 1, 7 do
			local Container = _G["ContainerFrame" .. i]
			select(k, Container:GetRegions()):SetAlpha(0)
		end
	end

	-- Hide Bank Frame Textures
	for i = 1, BankFrame:GetNumRegions() do
		local Region = select(i, BankFrame:GetRegions())
		Region:SetAlpha(0)
	end

	-- Hide BankSlotsFrame Textures and Fonts
	for i = 1, BankSlotsFrame:GetNumRegions() do
		local Region = select(i, BankSlotsFrame:GetRegions())
		Region:SetAlpha(0)
	end

	-- Hide Tabs, we will create our tabs
	for i = 1, 2 do
		local Tab = _G["BankFrameTab" .. i]
		Tab:Hide()
	end
end

function Bags:CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame("Frame", nil, UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local SortButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	if C["chat"].lbackground then Reagent:SetPoint("BOTTOMLEFT", DuffedUIChatBackgroundLeft, "TOPLEFT", 0, 6) else Reagent:SetPoint("BOTTOMLEFT", DuffedUIInfoLeft, "TOPLEFT", 0, 6) end
	Reagent:SetTemplate("Transparent")
	Reagent:SetFrameStrata(self.Bank:GetFrameStrata())
	Reagent:SetFrameLevel(self.Bank:GetFrameLevel())

	SwitchBankButton:Size(75, 23)
	SwitchBankButton:SkinButton()
	SwitchBankButton:Point("BOTTOMLEFT", Reagent, "BOTTOMLEFT", 10, 7)
	SwitchBankButton:FontString("Text", C["media"].font, 12)
	SwitchBankButton.Text:SetPoint("CENTER")
	SwitchBankButton.Text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
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
	Deposit:Point("BOTTOM", Reagent, "BOTTOM", 0, 7)
	Deposit:SkinButton()

	SortButton:Size(75, 23)
	SortButton:SetPoint("BOTTOMRIGHT", Reagent, "BOTTOMRIGHT", -10, 7)
	SortButton:SkinButton()
	SortButton:FontString("Text", C["media"].font, 12)
	SortButton.Text:SetPoint("CENTER")
	SortButton.Text:SetText(BAG_FILTER_CLEANUP)
	SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick) 

	for i = 1, 98 do
		local Button = _G["ReagentBankFrameItem" .. i]
		--local Count = _G[Button:GetName() .. "Count"]
		local Icon = _G[Button:GetName() .. "IconTexture"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetNormalTexture("")
		Button:SetPushedTexture("")
		Button:SetHighlightTexture("")
		Button:SetTemplate()
		Button.IconBorder:SetAlpha(0)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end
		Icon:SetTexCoord(unpack(D.IconCoord))
		Icon:SetInside()
		LastButton = Button
	end
	Reagent:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)

	-- Unlock window
	local Unlock = ReagentBankFrameUnlockInfo
	local UnlockButton = ReagentBankFrameUnlockInfoPurchaseButton
	Unlock:StripTextures()
	Unlock:SetAllPoints(Reagent)
	Unlock:SetTemplate()
	UnlockButton:SkinButton()
	self.Reagent = Reagent
end

function Bags:CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", nil, UIParent)
	Container:SetScale(C["bags"].scale)
	Container:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Container:SetPoint(...)
	Container:SetFrameStrata("HIGH")
	Container:SetFrameLevel(1)
	Container:Hide()
	Container:SetTemplate("Transparent")
	Container:EnableMouse(true)

	if (storagetype == "Bag") then
		local Sort = BagItemAutoSortButton
		local BagsContainer = CreateFrame("Frame", nil, UIParent)
		local ToggleBagsContainer = CreateFrame("Frame")

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 27)
		BagsContainer:Hide()
		BagsContainer:SetTemplate()

		Sort:Size(75, 23)
		Sort:ClearAllPoints()
		Sort:SetPoint("BOTTOMLEFT", Container, "BOTTOMLEFT", 10, 7)
		Sort:SetFrameLevel(Container:GetFrameLevel())
		Sort:SetFrameStrata(Container:GetFrameStrata())
		Sort:StripTextures()
		Sort:SkinButton()
		Sort:FontString("Text", C["media"].font, 12)
		Sort.Text:SetPoint("CENTER")
		Sort.Text:SetText(BAG_FILTER_CLEANUP)
		Sort.ClearAllPoints = Noop
		Sort.SetPoint = Noop

		ToggleBagsContainer:SetHeight(20)
		ToggleBagsContainer:SetWidth(20)
		ToggleBagsContainer:SetPoint("TOPRIGHT", Container, "TOPRIGHT", -6, -6)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer:EnableMouse(true)
		ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString("button")
		ToggleBagsContainer.Text:SetPoint("CENTER", ToggleBagsContainer, "CENTER")
		ToggleBagsContainer.Text:SetFont(C["media"].font, 12)
		ToggleBagsContainer.Text:SetText("X")
		ToggleBagsContainer.Text:SetTextColor(.5, .5, .5)
		ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
			local Purchase = BankFramePurchaseInfo
			if (button == "RightButton") then
				local BanksContainer = Bags.Bank.BagsContainer
				local Purchase = BankFramePurchaseInfo
				local ReagentButton = Bags.Bank.ReagentButton
				if (ReplaceBags == 0) then
					ReplaceBags = 1
					BagsContainer:Show()
					BanksContainer:Show()
					BanksContainer:ClearAllPoints()
					ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
					if Purchase:IsShown() then
						BanksContainer:SetPoint("BOTTOMLEFT", Purchase, "TOPLEFT", 50, 2)
					else
						BanksContainer:SetPoint("BOTTOMLEFT", ReagentButton, "TOPLEFT", 0, 2)
					end
				else
					ReplaceBags = 0
					BagsContainer:Hide()
					BanksContainer:Hide()
					ToggleBagsContainer.Text:SetTextColor(.4, .4, .4)
				end
			else
				if BankFrame:IsShown() then
					CloseBankFrame()
				else
					ToggleAllBags()
				end
			end
		end)

		for _, Button in pairs(BlizzardBags) do
			local Icon = _G[Button:GetName() .. "IconTexture"]

			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:SetCheckedTexture("")
			Button:SetTemplate()
			Button.IconBorder:SetAlpha(0)
			Button:SkinButton()
			if LastButtonBag then Button:SetPoint("LEFT", LastButtonBag, "RIGHT", 4, 0) else Button:SetPoint("TOPLEFT", BagsContainer, "TOPLEFT", 4, -4) end

			Icon:SetTexCoord(unpack(D.IconCoord))
			Icon:SetInside()
			LastButtonBag = Button
			BagsContainer:SetWidth((ButtonSize * getn(BlizzardBags)) + (ButtonSpacing * (getn(BlizzardBags) + 1)))
			BagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		end
		
		Container.BagsContainer = BagsContainer
		Container.CloseButton = ToggleBagsContainer
		Container.SortButton = Sort
	else
		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		local SortButton = CreateFrame("Button", nil, Container)
		local BankBagsContainer = CreateFrame("Frame", nil, Container)

		CostText:ClearAllPoints()
		CostText:SetPoint("BOTTOMLEFT", 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint("LEFT", CostText, "RIGHT", 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint("BOTTOMRIGHT", -10, 10)
		PurchaseButton:SkinButton()
		BankItemAutoSortButton:Hide()

		local SwitchReagentButton = CreateFrame("Button", nil, Container)
		SwitchReagentButton:Size(75, 23)
		SwitchReagentButton:SkinButton()
		SwitchReagentButton:Point("BOTTOMLEFT", Container, "BOTTOMLEFT", 10, 7)
		SwitchReagentButton:FontString("Text", C["media"].font, 12)
		SwitchReagentButton.Text:SetPoint("CENTER")
		SwitchReagentButton.Text:SetText(REAGENT_BANK)
		SwitchReagentButton:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			if (not ReagentBankFrame.isMade) then
				self:CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				self.Reagent:Show()
			end
			for i = 5, 11 do self:CloseBag(i) end
		end)

		SortButton:Size(75, 23)
		SortButton:SetPoint("BOTTOMRIGHT", Container, "BOTTOMRIGHT", -10, 7)
		SortButton:SkinButton()
		SortButton:FontString("Text", C["media"].font, 12)
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText(BAG_FILTER_CLEANUP)
		SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)

		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth() + 50)
		Purchase:SetHeight(70)
		Purchase:SetPoint("BOTTOMLEFT", SwitchReagentButton, "TOPLEFT", -50, 2)
		Purchase:CreateBackdrop()
		Purchase.backdrop:SetPoint("TOPLEFT", 50, 0)
		Purchase.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

		BankBagsContainer:Size(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		BankBagsContainer:SetTemplate()
		BankBagsContainer:SetPoint("BOTTOMLEFT", SwitchReagentButton, "TOPLEFT", 0, 2)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		for i = 1, 7 do
			local Bag = BankSlotsFrame["Bag" .. i]
			Bag:SetParent(BankBagsContainer)
			Bag:SetWidth(ButtonSize)
			Bag:SetHeight(ButtonSize)
			Bag.IconBorder:SetAlpha(0)
			Bag.icon:SetTexCoord(unpack(D.IconCoord))
			Bag.icon:SetInside()
			Bag:SkinButton()
			Bag:ClearAllPoints()
			if i == 1 then Bag:SetPoint("TOPLEFT", BankBagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing) else Bag:SetPoint("LEFT", BankSlotsFrame["Bag" .. i-1], "RIGHT", ButtonSpacing, 0) end
		end

		BankBagsContainer:SetWidth((ButtonSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		BankBagsContainer:Hide()

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
	BagItemSearchBox:SetFrameLevel(self.Bag:GetFrameLevel() + 2)
	BagItemSearchBox:SetFrameStrata(self.Bag:GetFrameStrata())
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("TOPRIGHT", self.Bag, "TOPRIGHT", -28, -6)
	BagItemSearchBox:StripTextures()
	BagItemSearchBox:SetTemplate()
	BagItemSearchBox.SetParent = Noop
	BagItemSearchBox.ClearAllPoints = Noop
	BagItemSearchBox.SetPoint = Noop

	BankItemSearchBox:Hide()
end

function Bags:SetTokensPosition()
	Token3:ClearAllPoints()
	Token3:SetPoint("BOTTOMRIGHT", self.Bag, "BOTTOMRIGHT", -16, 8)
	Token2:ClearAllPoints()
	Token2:SetPoint("RIGHT", Token3, "LEFT", -10, 0)
	Token1:ClearAllPoints()
	Token1:SetPoint("RIGHT", Token2, "LEFT", -10, 0)
end

function Bags:SkinTokens()
	for i = 1, 3 do
		local Token = _G["BackpackTokenFrameToken"  ..  i]
		local Icon = _G["BackpackTokenFrameToken"  ..  i  ..  "Icon"]
		local PreviousToken = _G["BackpackTokenFrameToken"  ..  (i - 1)]

		Token:SetFrameStrata("HIGH")
		Token:SetFrameLevel(5)
		Token:SetScale(C["bags"].scale)
		Token:CreateBackdrop()
		Token.backdrop:SetOutside(Icon)
		Icon:SetSize(12,12) 
		Icon:SetTexCoord(unpack(D.IconCoord)) 
		Icon:SetPoint("LEFT", Token, "RIGHT", -8, 2) 
	end
end

function Bags:SkinEditBoxes()
	for _, Frame in pairs(Boxes) do
		Frame:SkinEditBox()
		Frame.backdrop:StripTextures()
	end
end

function Bags:SlotUpdate(id, button)
	local ItemLink = GetContainerItemLink(id, button:GetID())
	local Texture, Count, Lock = GetContainerItemInfo(id, button:GetID())
	local IsQuestItem, QuestId, IsActive = GetContainerItemQuestInfo(id, button:GetID())
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())
	local IsBattlePayItem = IsBattlePayItem(id, button:GetID())
	local NewItem = button.NewItemTexture

	if Texture then
		-- update cooldown code here
	end

	if IsNewItem then
		NewItem:SetAlpha(0)
		if not button.Animation then
			button.Animation = button:CreateAnimationGroup()
			button.Animation:SetLooping("BOUNCE")
			button.FadeOut = button.Animation:CreateAnimation("Alpha")
			button.FadeOut:SetChange(-0.5)
			button.FadeOut:SetDuration(0.40)
			button.FadeOut:SetSmoothing("IN_OUT")
		end
		button.Animation:Play()
	else
		if button.Animation and button.Animation:IsPlaying() then button.Animation:Stop() end
	end

	if IsQuestItem then
		button:SetBackdropBorderColor(1, 1, 0)
		return
	end

	if ItemLink then
		local Name, _, Rarity, _, _, Type = GetItemInfo(ItemLink)
		if not Lock and Rarity and Rarity > 1 then button:SetBackdropBorderColor(GetItemQualityColor(Rarity)) else button:SetBackdropBorderColor(unpack(C["general"].bordercolor)) end
	else
		button:SetBackdropBorderColor(unpack(C["general"].bordercolor))
	end
end

function Bags:BagUpdate(id)
	local Size = GetContainerNumSlots(id)
	for Slot = 1, Size do
		local Button = _G["ContainerFrame" .. (id + 1) .. "Item" .. Slot]
		self:SlotUpdate(id, Button)
	end
end

function Bags:UpdateAllBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1

	for Bag = 1, 5 do
		local ID = Bag - 1
		local Slots = GetContainerNumSlots(ID)
		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item"  ..  Item]
			local Money = ContainerFrame1MoneyFrame

			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetScale(C["bags"].scale)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button.newitemglowAnim:Stop()
			Button.newitemglowAnim.Play = Noop
			Button.flashAnim:Stop()
			Button.flashAnim.Play = Noop

			Money:ClearAllPoints()
			Money:Show()
			Money:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 8, -10)
			Money:SetFrameStrata("HIGH")
			Money:SetFrameLevel(2)
			Money:SetScale(C["bags"].scale)
			if (Bag == 1 and Item == 16) then
				Button:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 10, -40)
				LastRowButton = Button
				LastButton = Button
			elseif (NumButtons == ItemsPerRow) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
				NumButtons = NumButtons + 1
			end
			Bags.SkinBagButton(Button)
			LastButton = Button
		end
		Bags:BagUpdate(ID)
	end

	Bags.Bag:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 76) - ButtonSpacing)
end

function Bags:UpdateAllBankBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1

	for Bank = 1, 28 do
		local Button = _G["BankFrameItem" .. Bank]
		local Money = ContainerFrame2MoneyFrame
		local BankFrameMoneyFrame = BankFrameMoneyFrame

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetFrameStrata("HIGH")
		Button:SetFrameLevel(2)
		Button:SetScale(C["bags"].scale)
		Button.IconBorder:SetAlpha(0)

		BankFrameMoneyFrame:Hide()
		if (Bank == 1) then
			Button:SetPoint("TOPLEFT", Bags.Bank, "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end
		Bags.SkinBagButton(Button)
		Bags.SlotUpdate(self, -1, Button)
		LastButton = Button
	end

	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)

		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item" .. Item]
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetScale(C["bags"].scale)
			Button.IconBorder:SetAlpha(0)
			if (NumButtons == ItemsPerRow) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing+ButtonSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing+ButtonSize), 0)
				NumButtons = NumButtons + 1
			end
			Bags.SkinBagButton(Button)
			LastButton = Button
		end
	end
	Bags.Bank:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
end

function Bags:OpenBag(id)
	if (not CanOpenPanels()) then
		if (UnitIsDead("player")) then NotWhileDeadError() end
		return
	end

	local Size = GetContainerNumSlots(id)
	local OpenFrame = ContainerFrame_GetOpenFrame()

	if OpenFrame.size and OpenFrame.size ~= Size then
		for i = 1, OpenFrame.size do
			local Button = _G[OpenFrame:GetName() .. "Item" .. i]
			
			Button:Hide()
		end
	end

	for i = 1, Size, 1 do
		local Index = Size - i + 1
		local Button = _G[OpenFrame:GetName() .. "Item" .. i]
		Button:SetID(Index)
		Button:Show()
	end
	OpenFrame.size = Size
	OpenFrame:SetID(id)
	OpenFrame:Show()

	if (id == 4) then Bags:UpdateAllBags() elseif (id == 11) then Bags:UpdateAllBankBags() end
end

function Bags:CloseBag(id) CloseBag(id) end

function Bags:ToggleBags()
	local Bag = ContainerFrame1
	local Bank = BankFrame

	-- Bags Toggle
	if Bag:IsShown() then
		if not Bank:IsShown() then
			self.Bag:Hide()
			self:CloseBag(0)
			for i = 1, 4 do self:CloseBag(i) end
		end
	else
		self.Bag:Show()
		self:OpenBag(0, 1)
		for i = 1, 4 do self:OpenBag(i, 1) end
	end

	-- Bank Toggle
	if Bank:IsShown() then
		self.Bank:Show()
		for i = 5, 11 do
			if (not IsBagOpen(i)) then self:OpenBag(i, 1) end
		end
	else
		self.Bank:Hide()
		for i = 5, 11 do self:CloseBag(i) end
	end
end

function Bags:OnEvent(event, ...)
	if (event == "BAG_UPDATE") then
		self:BagUpdate(...)
	elseif (event == "PLAYERBANKSLOTS_CHANGED") then
		local ID =  ...
		if ID <= 28 then
			local Button = _G["BankFrameItem" .. ID]
			self:SlotUpdate(-1, Button)
		else
			CloseBankFrame()
		end
	elseif (event == "BAG_UPDATE_COOLDOWN") then
		-- Cooldown Update Codes  ...
	elseif (event == "ITEM_LOCK_CHANGED") then
		-- Lock!
	end
end

function Bags:Enable()
	local Bag = ContainerFrame1
	local GameMenu = GameMenuFrame
	local Bank = BankFrameItem1

	if C["chat"].rbackground then 
		self:CreateContainer("Bag", "BOTTOMRIGHT", DuffedUIChatBackgroundRight, "TOPRIGHT", 0, 6)
	else
		self:CreateContainer("Bag", "BOTTOMRIGHT", DuffedUIInfoRight, "TOPRIGHT", 0, 6)
	end
	if C["chat"].lbackground then
		self:CreateContainer("Bank", "BOTTOMLEFT", DuffedUIChatBackgroundLeft, "TOPLEFT", 0, 6)
	else
		self:CreateContainer("Bank", "BOTTOMLEFT", DuffedUIInfoLeft, "TOPLEFT", 0, 6)
	end
	self:HideBlizzard()
	self:SetBagsSearchPosition()
	self:SkinEditBoxes()
	self:SetTokensPosition()
	self:SkinTokens()

	Bag:SetScript("OnHide", function()
		self.Bag:Hide()
		if self.Reagent and self.Reagent:IsShown() then self.Reagent:Hide() end
	end)

	Bank:SetScript("OnHide", function() self.Bank:Hide() end)

	function UpdateContainerFrameAnchors() end
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags() end
	function OpenBackpack()  ToggleAllBags() end
	function ToggleAllBags() self:ToggleBags() end

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("BAG_CLOSED")
	self:RegisterEvent("REAGENTBANK_UPDATE")
	self:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
	self:SetScript("OnEvent", self.OnEvent)
end

Bags:RegisterEvent("ADDON_LOADED")
Bags:RegisterEvent("PLAYER_ENTERING_WORLD")
Bags:SetScript("OnEvent", function(self, event,  ...)
	Bags:Enable()
end)