local D, C, L = unpack(select(2, ...))
--if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	local function OnEnter_Button(self)
		self:SkinButton()
	end

	--[[Main]]--
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillFrameCloseButton:SkinCloseButton()
	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:SetStatusBarTexture(C["media"].normTex)
	TradeSkillFrame.RankFrame:CreateBackdrop()
	TradeSkillFrame.FilterButton:SkinButton()
	TradeSkillFrame.FilterButton:SetScript("OnEnter", OnEnter_Button)
	TradeSkillFrame.FilterButton:SetScript("OnLeave", OnEnter_Button)
	TradeSkillFrame.SearchBox:SkinEditBox()
	TradeSkillFrame.SearchBox:SetHeight(15)
	
	--[[Recipelist]]--
	TradeSkillFrame.RecipeList:StripTextures()
	TradeSkillFrame.RecipeInset:StripTextures()
	TradeSkillFrame.RecipeList.LearnedTab:StripTextures()
	TradeSkillFrame.RecipeList.UnlearnedTab:StripTextures()
	
	--[[Detailsframe]]--
	TradeSkillFrame.DetailsFrame:StripTextures()
	TradeSkillFrame.DetailsInset:StripTextures()
	TradeSkillFrame.DetailsFrame.Background:Hide()
	TradeSkillFrame.DetailsFrame.CreateAllButton:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateAllButton:SkinButton()
	TradeSkillFrame.DetailsFrame.CreateButton:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateButton:SkinButton()
	TradeSkillFrame.DetailsFrame.ExitButton:StripTextures()
	TradeSkillFrame.DetailsFrame.ExitButton:SkinButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:SkinEditBox()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton:SkinNextPrevButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SkinNextPrevButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:ClearAllPoints()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, "RIGHT", 5, 0)
end

D.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin