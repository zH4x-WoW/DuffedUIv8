local AS = unpack(AddOnSkins)

--Lua functions
local _G = _G
local pairs, select, unpack = pairs, select, unpack
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

--WoW API / Variables
local hooksecurefunc = hooksecurefunc

-- Credits: siweia (AuroraClassic)

local function SkinEditBoxes(Frame)
	AS:SkinEditBox(Frame.MinLevel)
	AS:SkinEditBox(Frame.MaxLevel)
end

local function SkinFilterButton(Button)
	AS:SkinEditBox(Button.LevelRangeFrame)

	AS:SkinCloseButton(Button.ClearFiltersButton)
	AS:SkinButton(Button)
end

local function HandleSearchBarFrame(Frame)
	AS:SkinButton(Frame.FilterButton)

	AS:SkinButton(Frame.SearchButton)
	AS:SkinEditBox(Frame.SearchBox)
	AS:SkinButton(Frame.FavoritesSearchButton)
	Frame.FavoritesSearchButton:SetSize(22, 22)
end

local function HandleListIcon(frame)
	if not frame.tableBuilder then return end

	for i = 1, 22 do
		local row = frame.tableBuilder.rows[i]
		if row then
			for j = 1, 4 do
				local cell = row.cells and row.cells[j]
				if cell and cell.Icon then
					if not cell.IsSkinned then
						AS:SkinTexture(cell.Icon)
						if cell.IconBorder then cell.IconBorder:SetAlpha(0) end

						cell.IsSkinned = true
					end
				end
			end
		end
	end
end

local function HandleSummaryIcons(frame)
	for i = 1, 23 do
		local child = select(i, frame.ScrollFrame.scrollChild:GetChildren())

		if child and child.Icon then
			if not child.IsSkinned then
				AS:SkinTexture(child.Icon)
				child.IsSkinned = true
			end
		end
	end
end

local function SkinItemDisplay(frame)
	local ItemDisplay = frame.ItemDisplay
	AS:StripTextures(ItemDisplay)
	AS:CreateBackdrop(ItemDisplay)
	ItemDisplay.Backdrop:SetPoint("TOPLEFT", 3, -3)
	ItemDisplay.Backdrop:SetPoint("BOTTOMRIGHT", -3, 0)

	local ItemButton = ItemDisplay.ItemButton
	ItemButton.CircleMask:Hide()

	-- We skin the new IconBorder from the AH, it looks really cool tbh.
	ItemButton.Icon:SetTexCoord(.08, .92, .08, .92)
	ItemButton.Icon:SetSize(44, 44)
	ItemButton.IconBorder:SetTexCoord(.08, .92, .08, .92)
end

local function HandleHeaders(frame)
	local maxHeaders = frame.HeaderContainer:GetNumChildren()
	for i = 1, maxHeaders do
		local header = select(i, frame.HeaderContainer:GetChildren())
		if header and not header.IsSkinned then
			header:DisableDrawLayer("BACKGROUND")
			if not header.Backdrop then
				AS:CreateBackdrop(header)
			end

			header.IsSkinned = true
		end

		if header.Backdrop then
			header.Backdrop:SetPoint("BOTTOMRIGHT", i < maxHeaders and -5 or 0, -2)
		end
	end

	HandleListIcon(frame)
end

local function HandleAuctionButtons(button)
	AS:SkinButton(button)
	button:SetSize(22,22)
end

local function HandleSellFrame(frame)
	AS:StripTextures(frame)

	local ItemDisplay = frame.ItemDisplay
	AS:StripTextures(ItemDisplay)
	AS:CreateBackdrop(ItemDisplay)

	local ItemButton = ItemDisplay.ItemButton
	if ItemButton.IconMask then ItemButton.IconMask:Hide() end
	if ItemButton.IconBorder then ItemButton.IconBorder:SetAlpha(0) end

	ItemButton.EmptyBackground:Hide()
	ItemButton:SetPushedTexture("")
	ItemButton.Highlight:SetColorTexture(1, 1, 1, .25)
	ItemButton.Highlight:SetAllPoints(ItemButton.Icon)

	AS:SkinTexture(ItemButton.Icon, true)
	hooksecurefunc(ItemButton.IconBorder, "SetVertexColor", function(self, r, g, b) ItemButton.Icon.Backdrop:SetBackdropBorderColor(r, g, b) end)
	hooksecurefunc(ItemButton.IconBorder, "Hide", function() ItemButton.Icon.Backdrop:SetBackdropBorderColor(unpack(AS.BorderColor)) end)

	AS:SkinEditBox(frame.QuantityInput.InputBox)
	AS:SkinButton(frame.QuantityInput.MaxButton)
	AS:SkinEditBox(frame.PriceInput.MoneyInputFrame.GoldBox)
	AS:SkinEditBox(frame.PriceInput.MoneyInputFrame.SilverBox)

	if frame.SecondaryPriceInput then
		AS:SkinEditBox(frame.SecondaryPriceInput.MoneyInputFrame.GoldBox)
		AS:SkinEditBox(frame.SecondaryPriceInput.MoneyInputFrame.SilverBox)
	end

	AS:SkinDropDownBox(frame.DurationDropDown.DropDown)
	AS:SkinButton(frame.PostButton)

	if frame.BuyoutModeCheckButton then
		AS:SkinCheckBox(frame.BuyoutModeCheckButton)
		frame.BuyoutModeCheckButton:SetSize(20, 20)
	end
end

local function HandleSellList(frame, hasHeader)
	AS:StripTextures(frame)

	if frame.RefreshFrame then
		HandleAuctionButtons(frame.RefreshFrame.RefreshButton)
	end

	AS:SkinScrollBar(frame.ScrollFrame.scrollBar)

	if hasHeader then
		AS:CreateBackdrop(frame.ScrollFrame)
		hooksecurefunc(frame, "RefreshScrollFrame", HandleHeaders)
	else
		hooksecurefunc(frame, "RefreshScrollFrame", HandleSummaryIcons)
	end
end


function AS:Blizzard_AuctionUI(event, addon)
	if addon ~= "Blizzard_AuctionHouseUI" then return end

	--[[ Main Frame | TAB 1]]--
	local Frame = _G.AuctionHouseFrame
	AS:Kill(AuctionHouseFramePortrait)
	AS:StripTextures(Frame)
	AS:CreateBackdrop(Frame)
	AS:Kill(_G.AuctionHouseFrame.MoneyFrameInset.NineSlice)
	AS:SkinCloseButton(AuctionHouseFrameCloseButton)

	local Tabs = {
		_G.AuctionHouseFrameBuyTab,
		_G.AuctionHouseFrameSellTab,
		_G.AuctionHouseFrameAuctionsTab,
	}

	for _, tab in pairs(Tabs) do
		if tab then
			AS:SkinTab(tab)
		end
	end

	_G.AuctionHouseFrameBuyTab:ClearAllPoints()
	_G.AuctionHouseFrameBuyTab:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 0, -32)

	-- SearchBar Frame
	HandleSearchBarFrame(Frame.SearchBar)

	Frame.MoneyFrameBorder:StripTextures()
	Frame.MoneyFrameInset:StripTextures()

	--[[ Categorie List ]]--
	local Categories = Frame.CategoriesList
	AS:StripTextures(Categories.ScrollFrame)
	Categories.Background:Hide()
	Categories.NineSlice:Hide()

	AS:SkinScrollBar(_G.AuctionHouseFrameScrollBar)

	for i = 1, _G.NUM_FILTERS_TO_DISPLAY do
		local button = Categories.FilterButtons[i]

		AS:StripTextures(button)
		AS:StyleButton(button)

		button.SelectedTexture:SetInside(button)
	end

	hooksecurefunc("AuctionFrameFilters_UpdateCategories", function(categoriesList, _)
		for _, button in ipairs(categoriesList.FilterButtons) do
			button.SelectedTexture:SetAtlas(nil)
			button.SelectedTexture:SetColorTexture(0.7, 0.7, 0.7, 0.4)
		end
	end)

	--[[ Browse Frame ]]--
	local Browse = Frame.BrowseResultsFrame

	local ItemList = Browse.ItemList
	AS:StripTextures(ItemList)
	hooksecurefunc(ItemList, "RefreshScrollFrame", HandleHeaders)

	AS:SkinScrollBar(ItemList.ScrollFrame.scrollBar)

	--[[ BuyOut Frame]]
	local CommoditiesBuyFrame = Frame.CommoditiesBuyFrame
	CommoditiesBuyFrame.BuyDisplay:StripTextures()
	AS:SkinButton(CommoditiesBuyFrame.BackButton)

	local ItemList = Frame.CommoditiesBuyFrame.ItemList
	AS:StripTextures(ItemList)
	AS:CreateBackdrop(ItemList)
	AS:SkinButton(ItemList.RefreshFrame.RefreshButton)
	AS:SkinScrollBar(ItemList.ScrollFrame.scrollBar)

	local BuyDisplay = Frame.CommoditiesBuyFrame.BuyDisplay
	AS:SkinEditBox(BuyDisplay.QuantityInput.InputBox)
	AS:SkinButton(BuyDisplay.BuyButton)

	SkinItemDisplay(BuyDisplay)

	--[[ ItemBuyOut Frame]]
	local ItemBuyFrame = Frame.ItemBuyFrame
	AS:SkinButton(ItemBuyFrame.BackButton)
	AS:SkinButton(ItemBuyFrame.BuyoutFrame.BuyoutButton)

	SkinItemDisplay(ItemBuyFrame)

	local ItemList = ItemBuyFrame.ItemList
	AS:StripTextures(ItemList)
	AS:CreateBackdrop(ItemList)
	AS:SkinScrollBar(ItemList.ScrollFrame.scrollBar)
	AS:SkinButton(ItemList.RefreshFrame.RefreshButton)
	hooksecurefunc(ItemList, "RefreshScrollFrame", HandleHeaders)

	local EditBoxes = {
		_G.AuctionHouseFrameGold,
		_G.AuctionHouseFrameSilver,
	}

	for _, EditBox in pairs(EditBoxes) do
		AS:SkinEditBox(EditBox)
		EditBox:SetTextInsets(1, 1, -1, 1)
	end

	AS:SkinButton(ItemBuyFrame.BidFrame.BidButton)
	ItemBuyFrame.BidFrame.BidButton:ClearAllPoints()
	ItemBuyFrame.BidFrame.BidButton:SetPoint("LEFT", ItemBuyFrame.BidFrame.BidAmount, "RIGHT", 2, -2)
	AS:SkinButton(ItemBuyFrame.BidFrame.BidButton)

	--[[ Item Sell Frame | TAB 2 ]]--
	local SellFrame = Frame.ItemSellFrame
	HandleSellFrame(SellFrame)

	local ItemList = Frame.ItemSellList
	HandleSellList(ItemList, true)

	local CommoditiesSellFrame = Frame.CommoditiesSellFrame
	HandleSellFrame(CommoditiesSellFrame)

	local ItemList = Frame.CommoditiesSellList
	HandleSellList(ItemList, true)

	--[[ Auctions Frame | TAB 3 ]]--
	local AuctionsFrame = _G.AuctionHouseFrameAuctionsFrame
	AS:StripTextures(AuctionsFrame)

	SkinItemDisplay(AuctionsFrame)

	local CommoditiesList = AuctionsFrame.CommoditiesList
	HandleSellList(CommoditiesList, true)
	AS:SkinButton(CommoditiesList.RefreshFrame.RefreshButton)

	local ItemList = AuctionsFrame.ItemList
	HandleSellList(ItemList, true)
	AS:SkinButton(ItemList.RefreshFrame.RefreshButton)

	local Tabs = {
		_G.AuctionHouseFrameAuctionsFrameAuctionsTab,
		_G.AuctionHouseFrameAuctionsFrameBidsTab,
	}

	for _, tab in pairs(Tabs) do
		if tab then
			AS:SkinTab(tab)
		end
	end

	local SummaryList = AuctionsFrame.SummaryList
	HandleSellList(SummaryList)
	AS:SkinButton(AuctionsFrame.CancelAuctionButton)

	local AllAuctionsList = AuctionsFrame.AllAuctionsList
	HandleSellList(AllAuctionsList, true)
	AS:SkinButton(AllAuctionsList.RefreshFrame.RefreshButton)

	local BidsList = AuctionsFrame.BidsList
	HandleSellList(BidsList, true)
	AS:SkinButton(BidsList.RefreshFrame.RefreshButton)
	AS:SkinEditBox(_G.AuctionHouseFrameAuctionsFrameGold)
	AS:SkinEditBox(_G.AuctionHouseFrameAuctionsFrameSilver)
	AS:SkinButton(AuctionsFrame.BidFrame.BidButton)

	--[[ ProgressBars ]]--

	--[[ WoW Token Category ]]--
	local TokenFrame = Frame.WoWTokenResults
	TokenFrame:StripTextures()
	AS:SkinButton(TokenFrame.Buyout)
	AS:SkinScrollBar(TokenFrame.DummyScrollBar) --MONITOR THIS

	local Token = TokenFrame.TokenDisplay
	AS:StripTextures(Token)
	AS:CreateBackdrop(Token)

	local ItemButton = Token.ItemButton
	AS:SkinTexture(ItemButton.Icon, true)
	local _, _, itemRarity = GetItemInfo(_G.WOW_TOKEN_ITEM_ID)
	local r, g, b
	if itemRarity then
		r, g, b = GetItemQualityColor(itemRarity)
	end
	ItemButton.Icon.Backdrop:SetBackdropBorderColor(r, g, b)
	ItemButton.IconBorder:SetAlpha(0)

	--WoW Token Tutorial Frame
	local WowTokenGameTimeTutorial = Frame.WoWTokenResults.GameTimeTutorial
	WowTokenGameTimeTutorial.TitleBg:SetAlpha(0)
	WowTokenGameTimeTutorial:CreateBackdrop("Transparent")
	AS:SkinCloseButton(WowTokenGameTimeTutorial.CloseButton)
	AS:SkinButton(WowTokenGameTimeTutorial.RightDisplay.StoreButton)
	WowTokenGameTimeTutorial.Bg:SetAlpha(0)

	--[[ Dialogs ]]--
	Frame.BuyDialog:StripTextures()
	Frame.BuyDialog:CreateBackdrop("Transparent")
	AS:SkinButton(Frame.BuyDialog.BuyNowButton)
	AS:SkinButton(Frame.BuyDialog.CancelButton)	
end

-- BlackMarket
function AS:Blizzard_BlackMarketUI(event, addon)
	if addon ~= "Blizzard_BlackMarketUI" then return end

	AS:SkinFrame(_G.BlackMarketFrame)
	AS:SkinCloseButton(_G.BlackMarketFrame.CloseButton)

	AS:SkinBackdropFrame(_G.BlackMarketScrollFrame)
	_G.BlackMarketScrollFrame.Backdrop:SetPoint('TOPLEFT', -3, 0)
	_G.BlackMarketScrollFrame.Backdrop:SetPoint('BOTTOMRIGHT', -2, 2)
	AS:SkinScrollBar(_G.BlackMarketScrollFrameScrollBar)

	AS:SkinFrame(_G.BlackMarketFrame.MoneyFrameBorder)
	_G.BlackMarketFrame.MoneyFrameBorder:SetPoint('BOTTOMLEFT', _G.BlackMarketFrame, 'BOTTOMLEFT', 29, 12)
	_G.BlackMarketMoneyFrame:SetPoint("BOTTOMRIGHT", _G.BlackMarketFrame.MoneyFrameBorder, "BOTTOMRIGHT", 8, 4)

	AS:SkinEditBox(_G.BlackMarketBidPriceGold)
	_G.BlackMarketBidPriceGold.Backdrop:SetAllPoints()
	_G.BlackMarketBidPriceGold:SetHeight(16)
	_G.BlackMarketBidPriceGold:SetPoint("BOTTOMRIGHT", _G.BlackMarketFrame.BidButton, "BOTTOMLEFT", -1, 0)

	AS:SkinButton(_G.BlackMarketFrame.BidButton)
	_G.BlackMarketFrame.BidButton:SetHeight(20)
	_G.BlackMarketFrame.BidButton:SetPoint("BOTTOMRIGHT", -285, 12)

	for i = 1, _G.BlackMarketFrame:GetNumRegions() do
		local region = select(i, _G.BlackMarketFrame:GetRegions())
		if region and region:IsObjectType("FontString") and region:GetText() == _G.BLACK_MARKET_TITLE then
			region:ClearAllPoints()
			region:SetPoint("TOP", _G.BlackMarketFrame, "TOP", 0, -4)
		end
	end

	AS:StripTextures(_G.BlackMarketFrame.HotDeal)
	AS:SetTemplate(_G.BlackMarketFrame.HotDeal.Item)
	AS:StyleButton(_G.BlackMarketFrame.HotDeal.Item)
	AS:SkinTexture(_G.BlackMarketFrame.HotDeal.Item.IconTexture)
	_G.BlackMarketFrame.HotDeal.Item.IconTexture:SetInside()
	_G.BlackMarketFrame.HotDeal.Item.IconBorder:SetAlpha(0)

	hooksecurefunc(_G.BlackMarketFrame.HotDeal.Item.IconBorder, 'SetVertexColor', function(self, r, g, b) _G.BlackMarketFrame.HotDeal.Item:SetBackdropBorderColor(r, g, b) end)
	hooksecurefunc(_G.BlackMarketFrame.HotDeal.Item.IconBorder, 'Hide', function() _G.BlackMarketFrame.HotDeal.Item:SetBackdropBorderColor(unpack(AS.BorderColor)) end)

	for _, Tab in pairs({ 'ColumnName', 'ColumnLevel', 'ColumnType', 'ColumnDuration', 'ColumnHighBidder', 'ColumnCurrentBid' }) do
		AS:SkinButton(_G.BlackMarketFrame[Tab])
	end

	hooksecurefunc("BlackMarketScrollFrame_Update", function()
		for _, Button in pairs(_G.BlackMarketScrollFrame.buttons) do
			if not Button.skinned then
				AS:StripTextures(Button)
				AS:StyleButton(Button)
				Button:GetHighlightTexture():SetAllPoints(Button.Selection)
				Button:GetPushedTexture():SetAllPoints(Button.Selection)
				Button.Selection:SetColorTexture(1, 1, 1, .3)
				AS:SkinFrame(Button.Item)
				AS:StyleButton(Button.Item)

				AS:SkinTexture(Button.Item.IconTexture)

				Button.Item.IconTexture:SetInside()
				Button.Item.IconBorder:SetAlpha(0)
				hooksecurefunc(Button.Item.IconBorder, 'SetVertexColor', function(self, r, g, b) Button.Item:SetBackdropBorderColor(r, g, b) end)
				hooksecurefunc(Button.Item.IconBorder, 'Hide', function() Button.Item:SetBackdropBorderColor(unpack(AS.BorderColor)) end)

				Button.skinned = true
			end
		end
	end)

	AS:UnregisterSkinEvent(addon, event)
end

AS:RegisterSkin('Blizzard_AuctionHouseUI', AS.Blizzard_AuctionUI, 'ADDON_LOADED')
AS:RegisterSkin('Blizzard_BlackMarketUI', AS.Blizzard_BlackMarketUI, 'ADDON_LOADED')
