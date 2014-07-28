local D, C, L = select(2, ...):unpack()

local _G = _G
local Maps = D["Maps"]
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
	for _, Text in pairs(WorldMap.QuestTexts) do
		Text:SetTextColor(1, 1, 1)
	end
	
	local Objectives = GetNumQuestLeaderBoards()
	
	for i = 1, Objectives do
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
	Reward:CreateBackdrop()
	Reward.Icon:SetTexture(Texture)
	Reward.Backdrop:ClearAllPoints()
	Reward.Backdrop:SetOutside(Reward.Icon)
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
	Map:CreateShadow()
	Map.Backdrop:ClearAllPoints()
	Map.Backdrop:Size(701, 470)
	Map.Backdrop:Point("TOPLEFT", 0, -66)
	Map.Header = CreateFrame("Frame", nil, Map)
	Map.Header:Size(Map.Backdrop:GetWidth(), 23)
	Map.Header:SetPoint("BOTTOMLEFT", Map.Backdrop, "TOPLEFT", 0, 2)
	Map.Header:SetTemplate("Transparent")
	
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
	QuestScroll.Backdrop:ClearAllPoints()
	QuestScroll.Backdrop:SetTemplate("Transparent")
	QuestScroll.Backdrop:SetPoint("LEFT", 1, 0)
	QuestScroll.Backdrop:SetPoint("RIGHT", 30, 0)
	QuestScroll.Backdrop:SetPoint("TOP", 0, 3)
	QuestScroll.Backdrop:SetPoint("BOTTOM", 0, -5)
	
	DetailsScroll:CreateBackdrop()
	DetailsScroll.Backdrop:SetAllPoints(QuestScroll.Backdrop)
	DetailsScroll.Backdrop:SetTemplate("Transparent")
	
	ViewAllButton:SkinButton()
	ViewAllButton:ClearAllPoints()
	ViewAllButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	ViewAllButton:Size(288, 23)
	ViewAllButton:SetTemplate("Transparent")
	
	BackButton:SkinButton()
	BackButton:ClearAllPoints()
	BackButton:SetPoint("LEFT", Map.Header, "RIGHT", 2, 0)
	BackButton:Size(288, 23)
	
	AbandonButton:StripTextures()
	AbandonButton:SkinButton()
	AbandonButton:Size(QuestMapFrame.DetailsFrame.AbandonButton:GetWidth() - 4, QuestMapFrame.DetailsFrame.AbandonButton:GetHeight() - 4)
	AbandonButton:ClearAllPoints()
	AbandonButton:SetPoint("BOTTOMLEFT", Details, "BOTTOMLEFT", 3, -2)

	ShareButton:StripTextures()
	ShareButton:SkinButton()
	ShareButton:Size(ShareButton:GetWidth() - 4, ShareButton:GetHeight() - 4)
	ShareButton:ClearAllPoints()
	ShareButton:SetPoint("LEFT", AbandonButton, "RIGHT", 2, 0)	
	
	TrackButton:StripTextures()
	TrackButton:SkinButton()
	TrackButton:Size(TrackButton:GetWidth() - 4, TrackButton:GetHeight() - 4)
	TrackButton:ClearAllPoints()
	TrackButton:SetPoint("LEFT", ShareButton, "RIGHT", 2, 0)
	
	-- Quests Buttons
	for i = 1, 2 do
		local Button = i == 1 and WorldMapFrame.UIElementsFrame.OpenQuestPanelButton or WorldMapFrame.UIElementsFrame.CloseQuestPanelButton
		local Text = (i == 1 and QUESTS_LABEL.." -->") or ("<-- "..QUESTS_LABEL)
		
		Button:ClearAllPoints()
		Button:SetPoint("BOTTOMRIGHT", -3, 3)
		Button:Size(100, 23)
		Button:StripTextures()
		Button:SkinButton()
		Button:FontString("Text", C["medias"].Font, 12)
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
	Money.Backdrop:ClearAllPoints()
	Money.Backdrop:SetOutside(Money.Icon)
	
	XP:StripTextures()
	XP:CreateBackdrop()
	XP.Icon:SetTexture("Interface\\Icons\\XP_Icon")
	XP.Icon:SetTexCoord(unpack(D.IconCoord))
	XP.Backdrop:ClearAllPoints()
	XP.Backdrop:SetOutside(XP.Icon)
	
	WMDropDown:SkinDropDown()
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

Maps.WorldMap = WorldMap



