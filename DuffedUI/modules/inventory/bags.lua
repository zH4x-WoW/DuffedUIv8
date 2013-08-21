local D, C, L = select(2, ...):unpack()

if not C["bags"].Enable
	then return
end

local _G = _G
local Noop = function() end
local ToggleBags, ToggleBank = 0,0
local ReplaceBags = 0
local LastButtonBag, LastButtonBank
local Token1, Token2, Token3 = BackpackTokenFrameToken1, BackpackTokenFrameToken2, BackpackTokenFrameToken3
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local Bags = D["Inventory"]

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
	if self.IsSkinned then
		return
	end
	
	local Icon = _G[self:GetName().."IconTexture"]
	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:SetInside(self)
	
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
	local BankFrame = _G["BankFrame"]
	local BankPortraitTexture = _G["BankPortraitTexture"]
	
	TokenFrame:GetRegions():SetAlpha(0)
	Inset:Hide()
	Border:Hide()
	BankClose:Hide()
	BankPortraitTexture:Hide()
	BankFrame:EnableMouse(0)
	
	for i = 1, 12 do
		local CloseButton = _G["ContainerFrame"..i.."CloseButton"]
		CloseButton:Hide()
		
		for k = 1, 7 do
			local Container = _G["ContainerFrame"..i]
			select(k, Container:GetRegions()):SetAlpha(0)
		end
	end
	
	for i = 1, 80 do
		local Region = select(i, BankFrame:GetRegions())
		
		if not Region then
			break
		else
			Region:SetAlpha(0)
		end
	end
	
	for i = 1, 7 do
		local BankBag = _G["BankFrameBag"..i]
		BankBag:Hide()
	end
end

function Bags:CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", nil, UIParent)
	Container:SetScale(C["bags"].Scale)
	Container:SetWidth(((C["bags"].ButtonSize + C["bags"].Spacing) * C["bags"].ItemsPerRow) + 22 - C["bags"].Spacing)
	Container:SetPoint(...)
	Container:SetFrameStrata("HIGH")
	Container:SetFrameLevel(1)
	Container:RegisterForDrag("LeftButton","RightButton")
	Container:SetScript("OnDragStart", function(self) self:StartMoving() end)
	Container:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	Container:Hide()
	Container:SetTemplate()
    --Container:SetClampedToScreen(true)
    --Container:SetMovable(true)
    --Container:SetUserPlaced(true)
	--Container:EnableMouse(true)
	--Container:RegisterForDrag("LeftButton","RightButton")
	
	local BagsContainer = CreateFrame('Frame', nil, UIParent)
	BagsContainer:SetParent(Container)
	BagsContainer:SetWidth(10)
	BagsContainer:SetHeight(10)
	BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 4)
	BagsContainer:Hide()
	BagsContainer:SetTemplate()
	
	local ToggleBagsContainer = CreateFrame('Frame')
	ToggleBagsContainer:SetHeight(20)
	ToggleBagsContainer:SetWidth(20)
	ToggleBagsContainer:SetPoint("TOPRIGHT", Container, "TOPRIGHT", -6, -6)
	ToggleBagsContainer:SetParent(Container)
	ToggleBagsContainer:EnableMouse(true)
	ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString("button")
	ToggleBagsContainer.Text:SetPoint("CENTER", ToggleBagsContainer, "CENTER")
	ToggleBagsContainer.Text:SetFont(C["medias"].Font, 12, "OUTLINE")
	ToggleBagsContainer.Text:SetText("X")
	ToggleBagsContainer.Text:SetTextColor(.4, .4, .4)
	ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
		local Purchase = BankFramePurchaseInfo
		
		if button == "RightButton" then
			if ReplaceBags == 0 then
				ReplaceBags = 1
				BagsContainer:Show()
				ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
				
				if (Purchase:IsShown()) then
					BagsContainer:ClearAllPoints()
					BagsContainer:SetPoint("BOTTOMRIGHT", Purchase, "TOPRIGHT", 0, 4)
				else
					BagsContainer:ClearAllPoints()
					BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 4)
				end
			else
				ReplaceBags = 0
				BagsContainer:Hide()
				ToggleBagsContainer.Text:SetTextColor(.4, .4, .4)
			end
		else
			ToggleAllBags()
		end
	end)
	
	if (storagetype == "Bag") then
		for _, Button in pairs(BlizzardBags) do
			local Count = _G[Button:GetName().."Count"]
			local Icon = _G[Button:GetName().."IconTexture"]
			
			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(24)
			Button:SetHeight(24)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:SetCheckedTexture("")
			Button:SetTemplate()
			
			if LastButtonBag then
				Button:SetPoint("LEFT", LastButtonBag, "RIGHT", C["bags"].Spacing, 0)
			else
				Button:SetPoint("TOPLEFT", BagsContainer, "TOPLEFT", 8, -8)
			end
			
			Count.Show = Noop
			Count:Hide()

			Icon:SetTexCoord(unpack(D.IconCoord))
			Icon:SetInside()

			LastButtonBag = Button
			BagsContainer:SetWidth((24 + C["bags"].Spacing) * (getn(BlizzardBags)) + 14)
			BagsContainer:SetHeight(40)
		end
	else
		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		
		for _, Button in pairs(BlizzardBank) do
			local Count = _G[Button:GetName().."Count"]
			local Icon = _G[Button:GetName().."IconTexture"]
			
			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(24)
			Button:SetHeight(24)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:SetHighlightTexture("")
			Button:SetTemplate()
			
			if LastButtonBank then
				Button:SetPoint("LEFT", LastButtonBank, "RIGHT", C["bags"].Spacing, 0)
			else
				Button:SetPoint("TOPLEFT", BagsContainer, "TOPLEFT", 8, -8)
			end
			
			Count.Show = Noop
			Count:Hide()

			Icon:SetTexCoord(unpack(D.IconCoord))

			LastButtonBank = Button
			BagsContainer:SetWidth((24 + C["bags"].Spacing) * (getn(BlizzardBank)) + 14)
			BagsContainer:SetHeight(40)
		end
		
		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth() + 50)
		Purchase:SetHeight(70)
		Purchase:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 2)
		Purchase:CreateBackdrop()
		Purchase.Backdrop:SetPoint("TOPLEFT", 50, 0)
		Purchase.Backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		CostText:ClearAllPoints()
		CostText:SetPoint("BOTTOMLEFT", 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint("LEFT", CostText, "RIGHT", 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint("BOTTOMRIGHT", -10, 10)
		PurchaseButton:SkinButton()
	end
	
	self[storagetype] = Container
end

function Bags:SetBagsSearchPosition()
	local BagItemSearchBox = BagItemSearchBox
	
	BagItemSearchBox:SetFrameLevel(self.Bag:GetFrameLevel() + 2)
	BagItemSearchBox:SetFrameStrata(self.Bag:GetFrameStrata())
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("TOPRIGHT", self.Bag, "TOPRIGHT", -28, -6)
	BagItemSearchBox.ClearAllPoints = Noop
	BagItemSearchBox.SetPoint = Noop
end

function Bags:SetBankSearchPosition()
	local BankItemSearchBox = BankItemSearchBox
	
	BankItemSearchBox:SetFrameLevel(self.Bank:GetFrameLevel() + 2)
	BankItemSearchBox:SetFrameStrata(self.Bank:GetFrameStrata())
	BankItemSearchBox:ClearAllPoints()
	BankItemSearchBox:SetPoint("TOPRIGHT", self.Bank, "TOPRIGHT", -28, -6)
	BankItemSearchBox.ClearAllPoints = Noop
	BankItemSearchBox.SetPoint = Noop
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
		local Token = _G["BackpackTokenFrameToken"..i]
		local Icon = _G["BackpackTokenFrameToken"..i.."Icon"]
		local Count = _G["BackpackTokenFrameToken"..i.."Count"]
		local PreviousToken = _G["BackpackTokenFrameToken"..(i - 1)]
		
		Token:SetFrameStrata("HIGH")
		Token:SetFrameLevel(5)
		Token:SetScale(C["bags"].Scale)
		Token:CreateBackdrop()
		Token.Backdrop:SetOutside(Icon)
		
		Icon:SetSize(12,12) 
		Icon:SetTexCoord(unpack(D.IconCoord)) 
		Icon:SetPoint("LEFT", Token, "RIGHT", -8, 2) 
		
		Count:SetFont(C["medias"].Font, 13)
	end
end

function Bags:SkinEditBoxes()
	for _, Frame in pairs(Boxes) do
		Frame:SkinEditBox()
		Frame.Backdrop:StripTextures()
	end
end

function Bags:Update(size, id)
	local Item1, Size, Id = ContainerFrame1Item1, size, id
	self.size = size
	
	for i=1, Size, 1 do
		local Index = Size - i + 1
		local Button = _G[self:GetName().."Item"..i]
		Button:SetID(Index)
		Button:Show()
	end
	
	self:SetID(id)
	self:Show()
	
	if (id < 5) then
		local NumRows, LastRowButton, NumButtons, LastButton = 0, Item1, 1, Item1
		
		for Bag = 1, 5 do
			local Slots = GetContainerNumSlots(Bag - 1)
			for Item = Slots, 1, -1 do
				local Button = _G["ContainerFrame"..Bag.."Item"..Item]
				local Money = ContainerFrame1MoneyFrame
				
				Button:ClearAllPoints()
				Button:SetWidth(C["bags"].ButtonSize)
				Button:SetHeight(C["bags"].ButtonSize)
				Button:SetScale(C["bags"].Scale)
				Button:SetFrameStrata("HIGH")
				Button:SetFrameLevel(2)
				
				Money:ClearAllPoints()
				Money:Show()
				Money:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 8, -10)
				Money:SetFrameStrata("HIGH")
				Money:SetFrameLevel(2)
				Money:SetScale(C["bags"].Scale)
				
				if (Bag == 1 and Item == 16) then
					Button:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 10, -40)
					LastRowButton = Button
					LastButton = Button
				elseif (NumButtons == C["bags"].ItemsPerRow) then
					Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
					Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
					LastRowButton = Button
					NumRows = NumRows + 1
					NumButtons = 1
				else
					Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C["bags"].Spacing + C["bags"].ButtonSize), 0)
					Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C["bags"].Spacing + C["bags"].ButtonSize), 0)
					NumButtons = NumButtons + 1
				end
				
				Bags.SkinBagButton(Button)
				LastButton = Button
			end
		end
		
		if (Token1:IsShown()) then
			Bags.Bag:SetHeight(((C["bags"].ButtonSize + C["bags"].Spacing) * (NumRows + 1) + 76) - C["bags"].Spacing)
		else
			Bags.Bag:SetHeight(((C["bags"].ButtonSize + C["bags"].Spacing) * (NumRows + 1) + 54) - C["bags"].Spacing)
		end
	else
		local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
		
		for Bank = 1, 28 do
			local Button = _G["BankFrameItem"..Bank]
			local Money = ContainerFrame2MoneyFrame
			local BankFrameMoneyFrame = BankFrameMoneyFrame
			
			Button:ClearAllPoints()
			Button:SetWidth(C["bags"].ButtonSize)
			Button:SetHeight(C["bags"].ButtonSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetScale(C["bags"].Scale)
			
			Money:Show()
			Money:ClearAllPoints()
			Money:SetPoint("TOPLEFT", Bags.Bank, "TOPLEFT", 8, -10)
			Money:SetFrameStrata("HIGH")
			Money:SetFrameLevel(2)
			Money:SetParent(Bags.Bank)
			Money:SetScale(C["bags"].Scale)
			
			BankFrameMoneyFrame:Hide()
			
			if Bank == 1 then
				Button:SetPoint("TOPLEFT", Bags.Bank, "TOPLEFT", 10, -40)
				LastRowButton = Button
				LastButton = Button
			elseif NumButtons==C["bags"].ItemsPerRow then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C["bags"].Spacing + C["bags"].ButtonSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C["bags"].Spacing + C["bags"].ButtonSize), 0)
				NumButtons = NumButtons + 1
			end
			Bags.SkinBagButton(Button)
			LastButton = Button
		end
		
		for Bag = 6, 12 do
			local Slots = GetContainerNumSlots(Bag-1)
			for Item = Slots, 1, -1 do
				local Button = _G["ContainerFrame"..Bag.."Item"..Item]
				
				Button:ClearAllPoints()
				Button:SetWidth(C["bags"].ButtonSize)
				Button:SetHeight(C["bags"].ButtonSize)
				Button:SetFrameStrata("HIGH")
				Button:SetFrameLevel(2)
				Button:SetScale(C["bags"].Scale)
				
				if NumButtons == C["bags"].ItemsPerRow then
					Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
					Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C["bags"].Spacing + C["bags"].ButtonSize))
					LastRowButton = Button
					NumRows = NumRows + 1
					NumButtons = 1
				else
					Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C["bags"].Spacing+C["bags"].ButtonSize), 0)
					Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C["bags"].Spacing+C["bags"].ButtonSize), 0)
					NumButtons = NumButtons + 1
				end
				
				Bags.SkinBagButton(Button)
				LastButton = Button
			end
		end
		
		Bags.Bank:SetHeight(((C["bags"].ButtonSize + C["bags"].Spacing) * (NumRows + 1) + 52) - C["bags"].Spacing)
	end
end

function Bags:OpenBag(id)
    if (not CanOpenPanels()) then
        if (UnitIsDead("player")) then
            NotWhileDeadError()
        end
		
        return
    end
	
	local Size = GetContainerNumSlots(id)
	local Display
	
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local Container = _G["ContainerFrame"..i]
		if (Container:IsShown() and Container:GetID() == id) then
			Display = i
		end
	end
	
	if (not Display) then
		Bags.Update(ContainerFrame_GetOpenFrame(), Size, id)
	end
end

function Bags:CloseBag(id)
	CloseBag(id)
end

function Bags:ToggleBags()
	if (ToggleBags == 1) then
		if (not BankFrame:IsShown()) then 
			ToggleBags = 0
			self:CloseBag(0, 1)
			self.Bag:Hide()
			for i=1, NUM_BAG_FRAMES, 1 do
				self:CloseBag(i)
			end
		end
	else
		ToggleBags = 1
		self.Bag:Show()
		self:OpenBag(0,1)
		for i=1, NUM_BAG_FRAMES, 1 do
			self:OpenBag(i,1)
		end
	end

	
	if (BankFrame:IsShown()) then
		if (ToggleBank == 1) then
			ToggleBank = 0
			self.Bank:Hide()
			BankFrame:Hide()
			for i=NUM_BAG_FRAMES+1, NUM_CONTAINER_FRAMES, 1 do
				if (IsBagOpen(i)) then
					self:CloseBag(i)
				end
			end
		else
			ToggleBank = 1
			self.Bank:Show()
			BankFrame:Show()
			for i=1, NUM_CONTAINER_FRAMES, 1 do
				if (not IsBagOpen(i)) then
					self:OpenBag(i,1)
				end
			end
		end
	end
end