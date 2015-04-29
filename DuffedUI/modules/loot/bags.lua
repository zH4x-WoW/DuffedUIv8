local D, C, L, G = unpack(select(2,  ...))
if not C["bags"].enable == true then return end

local _G = _G
local ReplaceBags = 0
local LastButtonBag, LastButtonBank, LastButtonReagent
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local ReagentBankFrame = ReagentBankFrame
local BagHelpBox = BagHelpBox
local ButtonSize = C["bags"].buttonsize
local ButtonSpacing = C["bags"].spacing
local ItemsPerRow = C["bags"].bpr

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

function SkinBagButton(Button)
	if Button.IsSkinned then return end

	local Icon = _G[Button:GetName()  ..  "IconTexture"]
	local Quest = _G[Button:GetName()  ..  "IconQuestTexture"]
	local JunkIcon = Button.JunkIcon
	local Border = Button.IconBorder
	local BattlePay = Button.BattlepayItemTexture

	Border:SetAlpha(0)

	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:SetInside(Button)
	if Quest then Quest:SetAlpha(0) end
	if JunkIcon then JunkIcon:SetAlpha(0) end
	if BattlePay then BattlePay:SetAlpha(0) end

	Button:SetNormalTexture("")
	Button:SetPushedTexture("")
	Button:SetTemplate()
	Button:StyleButton()

	Button.IsSkinned = true
end

function HideBlizzard()
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

	for i = 1, BankFrame:GetNumRegions() do
		local Region = select(i, BankFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, BankSlotsFrame:GetNumRegions() do
		local Region = select(i, BankSlotsFrame:GetRegions())
		Region:SetAlpha(0)
	end

	for i = 1, 2 do
		local Tab = _G["BankFrameTab" .. i]
		Tab:Hide()
	end
end

function CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame("Frame", "DuffedUI_Reagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local SortButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	if C["chat"].lbackground then Reagent:SetPoint("BOTTOMLEFT", DuffedUIChatBackgroundLeft, "TOPLEFT", 0, 6) else Reagent:SetPoint("BOTTOMLEFT", DuffedUIInfoLeft, "TOPLEFT", 0, 6) end
	Reagent:SetTemplate("Transparent")
	Reagent:SetFrameStrata(_G["DuffedUI_Bank"]:GetFrameStrata())
	Reagent:SetFrameLevel(_G["DuffedUI_Bank"]:GetFrameLevel())

	SwitchBankButton:Size(75, 23)
	SwitchBankButton:SkinButton()
	SwitchBankButton:Point("BOTTOMLEFT", Reagent, "BOTTOMLEFT", 10, 7)
	SwitchBankButton:FontString("Text", C["media"].font, 11)
	SwitchBankButton.Text:SetPoint("CENTER")
	SwitchBankButton.Text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		_G["DuffedUI_Bank"]:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		for i = 5, 11 do
			if (not IsBagOpen(i)) then OpenBag(i, 1) end
		end
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:Size(120, 23)
	Deposit:Point("BOTTOM", Reagent, "BOTTOM", 0, 7)
	Deposit:SkinButton()

	if C["bags"]["SortingButton"] then
		SortButton:Size(75, 23)
		SortButton:SetPoint("BOTTOMRIGHT", Reagent, "BOTTOMRIGHT", -10, 7)
		SortButton:SkinButton()
		SortButton:FontString("Text", C["media"].font, 11)
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText(BAG_FILTER_CLEANUP)
		SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)
	end

	for i = 1, 98 do
		local Button = _G["ReagentBankFrameItem" .. i]
		local Icon = _G[Button:GetName() .. "IconTexture"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		Button:ClearAllPoints()
		Button:Size(ButtonSize, ButtonSize)
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

	local Unlock = ReagentBankFrameUnlockInfo
	local UnlockButton = ReagentBankFrameUnlockInfoPurchaseButton
	Unlock:StripTextures()
	Unlock:SetAllPoints(Reagent)
	Unlock:SetTemplate()
	UnlockButton:SkinButton()
end

function CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", "DuffedUI_" .. storagetype, UIParent)
	Container:SetScale(C["bags"].scale)
	Container:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Container:SetPoint(...)
	Container:SetFrameStrata("HIGH")
	Container:SetFrameLevel(1)
	Container:Hide()
	Container:SetTemplate("Transparent")
	Container:EnableMouse(true)
	if C["bags"].movable then
		Container:SetMovable(true)
		Container:SetClampedToScreen(true)
		Container:SetScript("OnMouseDown", function() Container:ClearAllPoints() Container:StartMoving() end)
		Container:SetScript("OnMouseUp", function() Container:StopMovingOrSizing() end)
	end

	if (storagetype == "Bag") then
		local Sort = BagItemAutoSortButton
		local BagsContainer = CreateFrame("Frame", nil, UIParent)
		local ToggleBagsContainer = CreateFrame("Frame")

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 3)
		BagsContainer:Hide()
		BagsContainer:SetTemplate("Transparent")

		if C["bags"]["SortingButton"] then
			Sort:Size(75, 23)
			Sort:ClearAllPoints()
			Sort:SetPoint("BOTTOMLEFT", Container, "BOTTOMLEFT", 10, 7)
			Sort:SetFrameLevel(Container:GetFrameLevel() + 1)
			Sort:SetFrameStrata(Container:GetFrameStrata())
			Sort:StripTextures()
			Sort:SkinButton()
			Sort:SetScript("OnClick", SortBags)
			Sort:FontString("Text", C["media"].font, 11)
			Sort.Text:SetPoint("CENTER")
			Sort.Text:SetText(BAG_FILTER_CLEANUP)
			Sort.ClearAllPoints = D.Dummy
			Sort.SetPoint = D.Dummy
		end

		ToggleBagsContainer:SetHeight(20)
		ToggleBagsContainer:SetWidth(20)
		ToggleBagsContainer:SetPoint("TOPRIGHT", Container, "TOPRIGHT", -6, -6)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer:EnableMouse(true)
		ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString("button")
		ToggleBagsContainer.Text:SetPoint("CENTER", ToggleBagsContainer, "CENTER")
		ToggleBagsContainer.Text:SetFont(C["media"].font, 11)
		ToggleBagsContainer.Text:SetText("X")
		ToggleBagsContainer.Text:SetTextColor(.5, .5, .5)
		ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
			local Purchase = BankFramePurchaseInfo
			if (button == "RightButton") then
				local BanksContainer = _G["DuffedUI_Bank"].BagsContainer
				local Purchase = BankFramePurchaseInfo
				local ReagentButton = _G["DuffedUI_Bank"].ReagentButton
				if (ReplaceBags == 0) then
					ReplaceBags = 1
					BagsContainer:Show()
					BanksContainer:Show()
					BanksContainer:ClearAllPoints()
					ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
					if Purchase:IsShown() then BanksContainer:SetPoint("BOTTOMLEFT", _G["DuffedUI_Bank"], "TOPLEFT", 0, 3) else BanksContainer:SetPoint("BOTTOMLEFT", _G["DuffedUI_Bank"], "TOPLEFT", 0, 3) end
				else
					ReplaceBags = 0
					BagsContainer:Hide()
					BanksContainer:Hide()
					ToggleBagsContainer.Text:SetTextColor(.4, .4, .4)
				end
			else
				if BankFrame:IsShown() then CloseBankFrame() else ToggleAllBags() end
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
		SwitchReagentButton:FontString("Text", C["media"].font, 11)
		SwitchReagentButton.Text:SetPoint("CENTER")
		SwitchReagentButton.Text:SetText(REAGENT_BANK)
		SwitchReagentButton:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			if (not ReagentBankFrame.isMade) then
				CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				_G["DuffedUI_Reagent"]:Show()
			end
			for i = 5, 11 do CloseBag(i) end
		end)

		if C["bags"]["SortingButton"] then
			SortButton:Size(75, 23)
			SortButton:SetPoint("BOTTOMRIGHT", Container, "BOTTOMRIGHT", -10, 7)
			SortButton:SkinButton()
			SortButton:FontString("Text", C["media"].font, 11)
			SortButton.Text:SetPoint("CENTER")
			SortButton.Text:SetText(BAG_FILTER_CLEANUP)
			SortButton:SetScript("OnClick", SortBags)
		end

		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth())
		Purchase:SetHeight(70)
		Purchase:SetPoint("BOTTOM", Container, "TOP", 0, 3)
		Purchase:CreateBackdrop("Transparent")
		Purchase.backdrop:SetPoint("TOPLEFT", 0, 0)
		Purchase.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)

		BankBagsContainer:SetParent(Container)
		BankBagsContainer:Size(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		BankBagsContainer:SetTemplate("Transparent")
		BankBagsContainer:ClearAllPoints()
		BankBagsContainer:SetPoint("BOTTOMLEFT", Container, "TOPLEFT", 0, 3)
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
			Bag:SetNormalTexture("")
			Bag:SetPushedTexture("")
			Bag:SetTemplate()
			Bag:SkinButton()
			Bag:ClearAllPoints()
			if i == 1 then Bag:SetPoint("TOPLEFT", BankBagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing) else Bag:SetPoint("LEFT", BankSlotsFrame["Bag" .. i-1], "RIGHT", ButtonSpacing, 0) end
		end

		BankBagsContainer:SetWidth((ButtonSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		BankBagsContainer:Hide()

		BankFrame:EnableMouse(false)

		_G["DuffedUI_Bank"].BagsContainer = BankBagsContainer
		_G["DuffedUI_Bank"].ReagentButton = SwitchReagentButton
		Container.SortButton = SortButton
	end
end

function SetBagsSearchPosition()
	local BagItemSearchBox = BagItemSearchBox
	local BankItemSearchBox = BankItemSearchBox

	BagItemSearchBox:SetParent(_G["DuffedUI_Bag"])
	BagItemSearchBox:SetFrameLevel(_G["DuffedUI_Bag"]:GetFrameLevel() + 2)
	BagItemSearchBox:SetFrameStrata(_G["DuffedUI_Bag"]:GetFrameStrata())
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("TOPRIGHT", _G["DuffedUI_Bag"], "TOPRIGHT", -28, -6)
	BagItemSearchBox:StripTextures()
	BagItemSearchBox:SetTemplate()
	BagItemSearchBox.SetParent = D.Dummy
	BagItemSearchBox.ClearAllPoints = D.Dummy
	BagItemSearchBox.SetPoint = D.Dummy

	BankItemSearchBox:Hide()
end

function SkinEditBoxes()
	for _, Frame in pairs(Boxes) do
		Frame:SkinEditBox()
		Frame.backdrop:StripTextures()
	end
end

function SlotUpdate(id, button)
	local ItemLink = GetContainerItemLink(id, button:GetID())
	local Texture, Count, Lock = GetContainerItemInfo(id, button:GetID())
	local IsQuestItem, QuestId, IsActive = GetContainerItemQuestInfo(id, button:GetID())
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())
	local IsBattlePayItem = IsBattlePayItem(id, button:GetID())
	local NewItem = button.NewItemTexture

	if IsNewItem then
		NewItem:SetAlpha(0)
		if C["bags"].Bounce then
			if not button.Animation then
				button.Animation = button:CreateAnimationGroup()
				button.Animation:SetLooping("BOUNCE")
				button.FadeOut = button.Animation:CreateAnimation("Alpha")
				button.FadeOut:SetChange(-0.5)
				button.FadeOut:SetDuration(0.40)
				button.FadeOut:SetSmoothing("IN_OUT")
			end
			button.Animation:Play()
		end
	else
		if button.Animation and button.Animation:IsPlaying() then button.Animation:Stop() end
	end

	if IsQuestItem then
		if button.BorderColor ~= QuestColor then
			button:SetBackdropBorderColor(1, 1, 0)
			button.BorderColor = QuestColor
		end
		return
	end

	if ItemLink then
		local Name, _, Rarity, _, _, Type = GetItemInfo(ItemLink)
		if Rarity and Rarity > 1 then
			if button.BorderColor ~= GetItemQualityColor(Rarity) then
				button:SetBackdropBorderColor(GetItemQualityColor(Rarity))
				button.BorderColor = GetItemQualityColor(Rarity)
			end
		else
			if (button.BorderColor ~= C["general"].bordercolor) then
				button:SetBackdropBorderColor(unpack(C["general"].bordercolor))
				button.BorderColor = C["general"].bordercolor
			end
		end
	else
		if (button.BorderColor ~= C["general"].bordercolor) then
			button:SetBackdropBorderColor(unpack(C["general"].bordercolor))
			button.BorderColor = C["general"].bordercolor
		end
	end
end

function BagUpdate(id)
	local Size = GetContainerNumSlots(id)
	for Slot = 1, Size do
		local Button = _G["ContainerFrame" .. (id + 1) .. "Item" .. Slot]
		SlotUpdate(id, Button)
	end
end

function UpdateAllBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	for Bag = 1, 5 do
		local ID = Bag - 1
		local Slots = GetContainerNumSlots(ID)
		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item"  ..  Item]
			local Money = ContainerFrame1MoneyFrame

			Button:ClearAllPoints()
			Button:Size(ButtonSize, ButtonSize)
			Button:SetScale(C["bags"].scale)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button.newitemglowAnim:Stop()
			Button.newitemglowAnim.Play = D.Dummy
			Button.flashAnim:Stop()
			Button.flashAnim.Play = D.Dummy

			Money:ClearAllPoints()
			Money:Show()
			Money:SetPoint("TOPLEFT", _G["DuffedUI_Bag"], "TOPLEFT", 8, -10)
			Money:SetFrameStrata("HIGH")
			Money:SetFrameLevel(2)
			Money:SetScale(C["bags"].scale)
			if (Bag == 1 and Item == 16) then
				Button:SetPoint("TOPLEFT", _G["DuffedUI_Bag"], "TOPLEFT", 10, -40)
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
			SkinBagButton(Button)
			LastButton = Button
		end
		BagUpdate(ID)
	end
	_G["DuffedUI_Bag"]:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 76) - ButtonSpacing)
end

function UpdateAllBankBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	for Bank = 1, 28 do
		local Button = _G["BankFrameItem" .. Bank]
		local Money = ContainerFrame2MoneyFrame
		local BankFrameMoneyFrame = BankFrameMoneyFrame

		Button:ClearAllPoints()
		Button:Size(ButtonSize, ButtonSize)
		Button:SetFrameStrata("HIGH")
		Button:SetFrameLevel(2)
		Button:SetScale(C["bags"].scale)
		Button.IconBorder:SetAlpha(0)

		BankFrameMoneyFrame:Hide()
		if (Bank == 1) then
			Button:SetPoint("TOPLEFT", _G["DuffedUI_Bank"], "TOPLEFT", 10, -10)
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
		SkinBagButton(Button)
		SlotUpdate(-1, Button)
		LastButton = Button
	end

	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)
		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"  ..  Bag  ..  "Item" .. Item]
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize, ButtonSize)
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
			SkinBagButton(Button)
			SlotUpdate(Bag - 1, Button)
			LastButton = Button
		end
	end
	_G["DuffedUI_Bank"]:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 50) - ButtonSpacing)
end

function Options()
	SetSortBagsRightToLeft(false)
	SetInsertItemsLeftToRight(false)
	InterfaceOptionsControlsPanelReverseCleanUpBags:Hide()
	InterfaceOptionsControlsPanelReverseNewLoot:Hide()
end

ContainerFrame1Item1:SetScript("OnHide", function()
	_G["DuffedUI_Bag"]:Hide()
	if _G["DuffedUI_Reagent"] and _G["DuffedUI_Reagent"]:IsShown() then
		_G["DuffedUI_Reagent"]:Hide()
	end
end)

BankFrameItem1:SetScript("OnHide", function() _G["DuffedUI_Bank"]:Hide() end)

BankFrameItem1:SetScript("OnShow", function() _G["DuffedUI_Bank"]:Show() end)

if C["chat"].rbackground then CreateContainer("Bag", "BOTTOMRIGHT", DuffedUIChatBackgroundRight, "TOPRIGHT", 0, 6) else CreateContainer("Bag", "BOTTOMRIGHT", DuffedUIInfoRight, "TOPRIGHT", 0, 6) end
if C["chat"].lbackground then CreateContainer("Bank", "BOTTOMLEFT", DuffedUIChatBackgroundLeft, "TOPLEFT", 0, 6) else CreateContainer("Bank", "BOTTOMLEFT", DuffedUIInfoLeft, "TOPLEFT", 0, 6) end

HideBlizzard()
SetBagsSearchPosition()
SkinEditBoxes()
Options()

function OpenBag(id, IsBank)
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

	if (id == 4) then UpdateAllBags() elseif (id == 11) then UpdateAllBankBags() end
end

function UpdateContainerFrameAnchors() end
function ToggleBag() ToggleAllBags() end
function ToggleBackpack() ToggleAllBags() end
function OpenAllBags() ToggleAllBags() end
function OpenBackpack() ToggleAllBags() end
function ToggleAllBags()
	if ((MerchantFrame:IsShown() or InboxFrame:IsVisible()) and ContainerFrame1:IsShown()) then return end
	if ContainerFrame1:IsShown() then
		if not BankFrame:IsShown() then
			_G["DuffedUI_Bag"]:Hide()
			CloseBag(0)
			for i = 1, 4 do CloseBag(i) end
		end
	else
		_G["DuffedUI_Bag"]:Show()
		OpenBag(0, 1)
		for i = 1, 4 do OpenBag(i, 1) end
	end

	if BankFrame:IsShown() then
		_G["DuffedUI_Bank"]:Show()
		for i = 5, 11 do
			if not IsBagOpen(i) then OpenBag(i, 1) end
		end
	else
		_G["DuffedUI_Bank"]:Hide()
		for i = 5, 11 do CloseBag(i) end
	end
end

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("BAG_UPDATE")
EventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
EventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
EventFrame:RegisterEvent("ITEM_LOCK_CHANGED")
EventFrame:RegisterEvent("BANKFRAME_OPENED")
EventFrame:RegisterEvent("BANKFRAME_CLOSED")
EventFrame:RegisterEvent("BAG_CLOSED")
EventFrame:RegisterEvent("REAGENTBANK_UPDATE")
EventFrame:RegisterEvent("BANK_BAG_SLOT_FLAGS_UPDATED")
EventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "BAG_UPDATE" then
		BagUpdate(...)
	elseif event == "PLAYERBANKSLOTS_CHANGED" then
		local ID = ...
		if ID <= 28 then
			local Button = _G["BankFrameItem" .. ID]
			SlotUpdate(-1, Button)
		end
	elseif event == "BANKFRAME_CLOSED" then
		if _G["DuffedUI_Reagent"] and _G["DuffedUI_Reagent"]:IsShown() then
			_G["DuffedUI_Reagent"]:Hide()
		end
	end
end)