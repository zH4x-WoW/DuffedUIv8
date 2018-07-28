local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded('AddOnSkins') then return end

local function LoadSkin()
	-- MainFrame
	TradeSkillFramePortrait:Kill()
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:SetTemplate('Transparent')
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:SetStatusBarTexture(C['media'].normTex)
	TradeSkillFrame.RankFrame:CreateBackdrop()
	TradeSkillFrame.FilterButton:StripTextures(true)
	TradeSkillFrame.FilterButton:CreateBackdrop('Default', true)
	TradeSkillFrame.FilterButton.backdrop:SetAllPoints()
	TradeSkillFrame.LinkToButton:GetNormalTexture():SetTexCoord(0.25, 0.7, 0.37, 0.75)
	TradeSkillFrame.LinkToButton:GetPushedTexture():SetTexCoord(0.25, 0.7, 0.45, 0.8)
	TradeSkillFrame.LinkToButton:GetHighlightTexture():Kill()
	TradeSkillFrame.LinkToButton:CreateBackdrop('Default')
	TradeSkillFrame.LinkToButton:Size(17, 14)
	TradeSkillFrame.LinkToButton:SetPoint('BOTTOMRIGHT', TradeSkillFrame.FilterButton, 'TOPRIGHT', -2, 4)

	TradeSkillFrame.SearchBox:SkinEditBox()
	TradeSkillFrameCloseButton:SkinCloseButton()

	-- RecipeList
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.RecipeList.LearnedTab:StripTextures()
	TradeSkillFrame.RecipeList.UnlearnedTab:StripTextures()

	-- DetailsFrame
	TradeSkillFrame.DetailsFrame:StripTextures()
	TradeSkillFrame.DetailsInset:StripTextures()
	TradeSkillFrame.DetailsFrame.Background:Hide()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:SkinEditBox()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:DisableDrawLayer('BACKGROUND')

	TradeSkillFrame.DetailsFrame.CreateAllButton:SkinButton(true)
	TradeSkillFrame.DetailsFrame.CreateButton:SkinButton(true)
	TradeSkillFrame.DetailsFrame.ExitButton:SkinButton(true)

	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton:SkinNextPrevButton(nil, true)
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SkinNextPrevButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:Point('LEFT', TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, 'RIGHT', 4, 0)

	hooksecurefunc(TradeSkillFrame.DetailsFrame, 'RefreshDisplay', function()
		local ResultIcon = TradeSkillFrame.DetailsFrame.Contents.ResultIcon
		ResultIcon:StyleButton()
		if ResultIcon:GetNormalTexture() then
			ResultIcon:GetNormalTexture():SetTexCoord(unpack(D['IconCoord']))
			ResultIcon:GetNormalTexture():SetInside()
		end
		ResultIcon:SetTemplate('Default')

		for i = 1, #TradeSkillFrame.DetailsFrame.Contents.Reagents do
			local Button = TradeSkillFrame.DetailsFrame.Contents.Reagents[i]
			local Icon = Button.Icon
			local Count = Button.Count
			
			Icon:SetTexCoord(unpack(D['IconCoord']))
			Icon:SetDrawLayer('OVERLAY')
			if not Icon.backdrop then
				Icon.backdrop = CreateFrame('Frame', nil, Button)
				Icon.backdrop:SetFrameLevel(Button:GetFrameLevel() - 1)
				Icon.backdrop:SetTemplate('Default')
				Icon.backdrop:SetOutside(Icon)
			end
			
			Icon:SetParent(Icon.backdrop)
			Count:SetParent(Icon.backdrop)
			Count:SetDrawLayer('OVERLAY')
			Button.NameFrame:Kill()
		end
	end)

	--Guild Crafters
	TradeSkillFrame.DetailsFrame.GuildFrame.CloseButton:SkinCloseButton()
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton:SkinButton()
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton.LeftSeparator:SetTexture(nil)
	TradeSkillFrame.DetailsFrame.ViewGuildCraftersButton.RightSeparator:SetTexture(nil)
	TradeSkillFrame.DetailsFrame.GuildFrame:StripTextures()
	TradeSkillFrame.DetailsFrame.GuildFrame:SetTemplate('Transparent')
	TradeSkillFrame.DetailsFrame.GuildFrame.Container:StripTextures()
	TradeSkillFrame.DetailsFrame.GuildFrame.Container:SetTemplate('Transparent')

	--BUGFIX: TradeSkillFrame.RecipeList.scrollBar
	--Hide current scrollbar
	TradeSkillFrame.RecipeList.scrollBar.ScrollBarTop:Hide()
	TradeSkillFrame.RecipeList.scrollBar.ScrollBarTop = nil
	TradeSkillFrame.RecipeList.scrollBar.ScrollBarBottom:Hide()
	TradeSkillFrame.RecipeList.scrollBar.ScrollBarBottom = nil
	TradeSkillFrame.RecipeList.scrollBar.ScrollBarMiddle:Hide()
	TradeSkillFrame.RecipeList.scrollBar.thumbTexture:Hide()
	TradeSkillFrame.RecipeList.scrollBar.thumbTexture = nil
	TradeSkillFrameScrollUpButton:Hide()
	TradeSkillFrameScrollUpButton = nil
	TradeSkillFrameScrollDownButton:Hide()
	TradeSkillFrameScrollDownButton = nil

	--Create new one with fixed template
	TradeSkillFrame.RecipeList.scrollBar = CreateFrame('Slider', nil, TradeSkillFrame.RecipeList, 'HybridScrollBarTemplateFixed')
	C_Timer.After(0.25, function()
		TradeSkillFrame.RecipeList.scrollBar:SetValue(1)
		TradeSkillFrame.RecipeList.scrollBar:SetValue(0)
	end)
end

D['SkinFuncs']['Blizzard_TradeSkillUI'] = LoadSkin