local D, C, L = unpack(select(2, ...))

local _G = _G
local Noop = function() end
local WorldMap = CreateFrame("Frame")

WorldMap.QuestTexts = {
	QuestInfoTitleHeader,
	QuestInfoDescriptionHeader,
	QuestInfoObjectivesHeader,
	QuestInfoRewardsFrame.Header,
	QuestInfoDescriptionText,
	QuestInfoObjectivesText,
	QuestInfoGroupSize,
	QuestInfoRewardText,
	QuestInfoRewardsFrame.ItemChooseText,
	QuestInfoRewardsFrame.ItemReceiveText,
	QuestInfoRewardsFrame.SpellLearnText,
	QuestInfoRewardsFrame.PlayerTitleText,
	QuestInfoRewardsFrame.XPFrame.ReceiveText,
}

function WorldMap:ColorQuestText()
	for _, Text in pairs(WorldMap.QuestTexts) do Text:SetTextColor(1, 1, 1) end
	
	local Objectives = QuestInfoObjectivesFrame.Objectives
	
	for i = 1, #Objectives do
		local Objective = _G["QuestInfoObjective"..i]
		local Completed = select(3, GetQuestLogLeaderBoard(i))
		
		if Completed then
			Objective:SetTextColor(0, 1, 0)
		else
			Objective:SetTextColor(1, 0, 0)
		end
	end
end

function WorldMap:SkinReward(i)
	local Reward = _G[self:GetName().."QuestInfoItem"..i]
	local Texture = Reward.Icon:GetTexture()
	
	Reward:StripTextures()
	Reward:StyleButton()
	Reward:CreateBackdrop()
	Reward.Icon:SetTexture(Texture)
	Reward.backdrop:ClearAllPoints()
	Reward.backdrop:SetOutside(Reward.Icon)
	Reward.Icon:SetTexCoord(unpack(D.IconCoord))
end

function WorldMap:Skin()
	local Map = WorldMapFrame
	local MapScroll = WorldMapScrollFrame
	local MapBorder = WorldMapFrame.BorderFrame
	local MapBorderInset = WorldMapFrame.BorderFrame.Inset
	local QuestScroll = QuestScrollFrame
	local Quest = QuestMapFrame
	local Details = QuestMapFrame.DetailsFrame
	local Rewards = QuestMapFrame.DetailsFrame.RewardsFrame
	local Navigation = WorldMapFrameNavBar
	local TutorialButton = WorldMapFrameTutorialButton
	local TitleButton = WorldMapTitleButton
	local ViewAllButton = QuestScrollFrame.ViewAll
	local BackButton = QuestMapFrame.DetailsFrame.BackButton
	local AbandonButton = QuestMapFrame.DetailsFrame.AbandonButton
	local ShareButton = QuestMapFrame.DetailsFrame.ShareButton
	local TrackButton = QuestMapFrame.DetailsFrame.TrackButton
	local ScrollBar = QuestScrollFrame.ScrollBar
	local Title = WorldMapFrame.BorderFrame.TitleText
	local CloseButton = WorldMapFrameCloseButton
	local SizeButton = WorldMapFrameSizeUpButton
	local RewardsInfo = MapQuestInfoRewardsFrame
	local Money = MapQuestInfoRewardsFrame.MoneyFrame
	local XP = MapQuestInfoRewardsFrame.XPFrame
	local StoryHeader = QuestScrollFrame.Contents.StoryHeader
	local QuestBackground = QuestScrollFrame.Background
	local StoryTooltip = QuestScrollFrame.StoryTooltip
	local MapDetails = WorldMapDetailFrame
	local TrackingMenuButton = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button
	local TrackingMenuBackground = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background
	local DetailsScroll = QuestMapDetailsScrollFrame
	local WMDropDown = WorldMapLevelDropDown

	Map:StripTextures()
	Map:CreateBackdrop()
	Map.backdrop:ClearAllPoints()
	Map.backdrop:Size(701, 470)
	Map.backdrop:Point("TOPLEFT", 0, -66)
	Map.Header = CreateFrame("Frame", nil, Map)
	Map.Header:Size(Map.backdrop:GetWidth(), 23)
	Map.Header:SetPoint("BOTTOMLEFT", Map.backdrop, "TOPLEFT", 0, 2)
	Map.Header:SetTemplate()

	MapBorder:StripTextures()
	MapBorderInset:StripTextures()
	Details:StripTextures()
	Rewards:StripTextures()
	StoryHeader:StripTextures()
	Quest:StripTextures()

	StoryTooltip:StripTextures()
	StoryTooltip:SetTemplate("Transparent")

	QuestBackground:SetAlpha(0)

	TutorialButton:Kill()

	TrackingMenuButton:SetAlpha(0)
	TrackingMenuBackground:SetAlpha(0)

	QuestScroll:CreateBackdrop()
	QuestScroll.backdrop:ClearAllPoints()
	QuestScroll.backdrop:SetTemplate("Transparent")
	QuestScroll.backdrop:Size(299, 470)
	QuestScroll.backdrop:SetPoint("LEFT", Map.backdrop, "RIGHT", 2, 0)
	QuestScrollFrameScrollBar:SkinScrollBar()

	DetailsScroll:CreateBackdrop()
	DetailsScroll.backdrop:SetAllPoints(QuestScroll.backdrop)
	DetailsScroll.backdrop:SetTemplate("Transparent")
	DetailsScroll.backdrop:ClearAllPoints()
	DetailsScroll.backdrop:Size(299, 470)
	DetailsScroll.backdrop:SetPoint("LEFT", Map.backdrop, "RIGHT", 2, 0)
	QuestMapDetailsScrollFrameScrollBar:SkinScrollBar()

	ViewAllButton:SkinButton()
	ViewAllButton:ClearAllPoints()
	ViewAllButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	ViewAllButton:Size(299, 23)

	BackButton:SkinButton()
	BackButton:ClearAllPoints()
	BackButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	BackButton:Size(299, 23)

	AbandonButton:StripTextures()
	AbandonButton:SkinButton()
	AbandonButton:ClearAllPoints()
	AbandonButton:SetPoint("BOTTOMLEFT", QuestScroll.backdrop, "BOTTOMLEFT", 3, 3)

	ShareButton:StripTextures()
	ShareButton:SkinButton()

	TrackButton:StripTextures()
	TrackButton:SkinButton()

	QuestNPCModel:StripTextures()
	QuestNPCModel:CreateBackdrop("Transparent")
	QuestNPCModel:ClearAllPoints()
	QuestNPCModel:Point("TOPLEFT", BackButton, "TOPRIGHT", 2, -2)
	QuestNPCModelTextFrame:StripTextures()
	QuestNPCModelTextFrame:CreateBackdrop("Default")
	QuestNPCModelTextFrame.backdrop:Point("TOPLEFT", QuestNPCModel.backdrop, "BOTTOMLEFT", 0, -2)
	hooksecurefunc("QuestFrame_ShowQuestPortrait", function(parentFrame, portrait, text, name, x, y)
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", x + 16, y)
	end)

	-- Quests Buttons
	for i = 1, 2 do
		local Button = i == 1 and WorldMapFrame.UIElementsFrame.OpenQuestPanelButton or WorldMapFrame.UIElementsFrame.CloseQuestPanelButton
		local Text = (i == 1 and QUESTS_LABEL.." -->") or ("<-- "..QUESTS_LABEL)

		Button:ClearAllPoints()
		Button:SetPoint("BOTTOMRIGHT", -3, 3)
		Button:Size(100, 23)
		Button:StripTextures()
		Button:SkinButton()
		Button:FontString("Text", C["media"].font, 12)
		Button.Text:SetPoint("CENTER")
		Button.Text:SetText(Text)
	end

	Navigation:Hide()

	TitleButton:ClearAllPoints()
	TitleButton:SetAllPoints(Map.Header)
	
	Title:ClearAllPoints()
	Title:SetPoint("CENTER", Map.Header)

	CloseButton:StripTextures()
	CloseButton:ClearAllPoints()
	CloseButton:SetPoint("RIGHT", Map.Header, "RIGHT", 8, -1)
	CloseButton:SkinCloseButton()

	SizeButton:Kill()

	ScrollBar:Hide()

	Money:StripTextures()
	Money:CreateBackdrop()
	Money.Icon:SetTexture("Interface\\Icons\\inv_misc_coin_01")
	Money.Icon:SetTexCoord(unpack(D.IconCoord))
	Money.backdrop:ClearAllPoints()
	Money.backdrop:SetOutside(Money.Icon)

	XP:StripTextures()
	XP:CreateBackdrop()
	XP.Icon:SetTexture("Interface\\Icons\\XP_Icon")
	XP.Icon:SetTexCoord(unpack(D.IconCoord))
	XP.backdrop:ClearAllPoints()
	XP.backdrop:SetOutside(XP.Icon)

	WMDropDown:SkinDropDownBox()
	WMDropDown:ClearAllPoints()
	WMDropDown:SetPoint("TOPLEFT", -18, -2)
end

function WorldMap:AddHooks()
	hooksecurefunc("QuestInfo_Display", self.ColorQuestText)
	hooksecurefunc("QuestInfo_GetRewardButton", self.SkinReward)
end

function WorldMap:Enable()
	local SmallerMap = GetCVarBool("miniWorldMap")
	
	if not SmallerMap then
		ToggleWorldMap()
		WorldMapFrameSizeUpButton:Click()
		ToggleWorldMap()
	end

	self:Skin()
	self:AddHooks()
end

WorldMap:RegisterEvent("ADDON_LOADED")
WorldMap:RegisterEvent("PLAYER_ENTERING_WORLD")
WorldMap:SetScript("OnEvent", function(self, event, ...)
	WorldMap:Enable()
end)