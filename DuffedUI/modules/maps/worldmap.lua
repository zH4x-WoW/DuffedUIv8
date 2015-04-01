local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

-- Modified Script from Tukui T16
-- Credits got to Tukz & Hydra
local _G = _G
local WorldMap = CreateFrame("Frame")
local fontflag = "THINOUTLINE"

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

		if Completed then Objective:SetTextColor(0, 1, 0) else Objective:SetTextColor(1, 0, 0) end
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
	local QuestScroll = QuestScrollFrame
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
	local QuestBackground = QuestScrollFrame.Background
	local StoryTooltip = QuestScrollFrame.StoryTooltip
	local TrackingMenuButton = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button
	local TrackingMenuBackground = WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background
	local DetailsScroll = QuestMapDetailsScrollFrame

	Map:StripTextures()
	Map:CreateBackdrop()
	Map.backdrop:ClearAllPoints()
	Map.backdrop:Size(701, 470)
	Map.backdrop:Point("TOPLEFT", 0, -66)
	Map.Header = CreateFrame("Frame", nil, Map)
	Map.Header:Size(Map.backdrop:GetWidth(), 23)
	Map.Header:SetPoint("BOTTOMLEFT", Map.backdrop, "TOPLEFT", 0, 2)
	Map.Header:SetTemplate()
	WorldMapFrame.BorderFrame:StripTextures()
	WorldMapFrame.BorderFrame.Inset:StripTextures()
	WorldMapLevelDropDown:StripTextures()
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPLEFT", Map.Header, -17, 1)

	QuestMapFrame.DetailsFrame:StripTextures()
	QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
	QuestScrollFrame.Contents.StoryHeader:StripTextures()
	QuestMapFrame:StripTextures()

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
		local Text = (i == 1 and QUESTS_LABEL.." ->") or ("<- "..QUESTS_LABEL)

		Button:ClearAllPoints()
		Button:SetPoint("BOTTOMRIGHT", -3, 3)
		Button:Size(100, 23)
		Button:StripTextures()
		Button:SkinButton()
		Button:FontString("Text", C["media"].font, 11, fontflag)
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
end

function WorldMap:Coords()
	local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
	local fontheight = 11 * 1.1
	coords:SetFrameLevel(90)
	coords:FontString("PlayerText", C["media"].font, fontheight, fontflag)
	coords:FontString("MouseText", C["media"].font, fontheight, fontflag)
	coords.PlayerText:SetTextColor(235 / 255, 245 / 255, 0 / 255)
	coords.MouseText:SetTextColor(235 / 255, 245 / 255, 0 / 255)
	coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", 5, 5)
	coords.PlayerText:SetText("Player:   0, 0")
	coords.MouseText:SetPoint("BOTTOMLEFT", coords.PlayerText, "TOPLEFT", 0, 5)
	coords.MouseText:SetText("Mouse:   0, 0")
	local int = 0

	WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
		int = int + 1
		if int >= 3 then
			local inInstance, _ = IsInInstance()
			local x, y = GetPlayerMapPosition("player")
			x = math.floor(100 * x)
			y = math.floor(100 * y)
			if x ~= 0 and y ~= 0 then coords.PlayerText:SetText(PLAYER..":   "..x..", "..y) else coords.PlayerText:SetText(" ") end

			local scale = WorldMapDetailFrame:GetEffectiveScale()
			local width = WorldMapDetailFrame:GetWidth()
			local height = WorldMapDetailFrame:GetHeight()
			local centerX, centerY = WorldMapDetailFrame:GetCenter()
			local x, y = GetCursorPosition()
			local adjustedX = (x / scale - (centerX - (width/2))) / width
			local adjustedY = (centerY + (height/2) - y / scale) / height

			if (adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
				adjustedX = math.floor(100 * adjustedX)
				adjustedY = math.floor(100 * adjustedY)
				coords.MouseText:SetText(MOUSE_LABEL..":   "..adjustedX..", "..adjustedY)
			else
				coords.MouseText:SetText(" ")
			end
			int = 0
		end
	end)
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
	self:Coords()
	self:AddHooks()
end

WorldMap:RegisterEvent("ADDON_LOADED")
WorldMap:RegisterEvent("PLAYER_ENTERING_WORLD")
WorldMap:SetScript("OnEvent", function(self, event, ...)
	WorldMap:Enable()
end)