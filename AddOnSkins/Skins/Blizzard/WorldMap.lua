local AS = unpack(AddOnSkins)

function AS:Blizzard_WorldMap()
	WorldMapFrame.NavBar:StripTextures() 
	WorldMapFrame.NavBar.overlay:StripTextures()

	AS:SkinBackdropFrame(WorldMapFrameHomeButton)
	WorldMapFrameHomeButton.Backdrop:SetPoint("TOPLEFT", WorldMapFrameHomeButton, "TOPLEFT", 0, 0)
	WorldMapFrameHomeButton.Backdrop:SetPoint("BOTTOMRIGHT", WorldMapFrameHomeButton, "BOTTOMRIGHT", -15, 0)
	WorldMapFrameHomeButton:SetFrameLevel(1)

	AS:SkinBackdropFrame(WorldMapFrame.BorderFrame)
	WorldMapFrame.BorderFrame:SetFrameStrata(WorldMapFrame:GetFrameStrata())

	AS:SkinScrollBar(QuestScrollFrameScrollBar)

	WorldMapFrame.BorderFrame.Tutorial:Kill()

	AS:SkinButton(QuestMapFrame.DetailsFrame.BackButton)
	AS:SkinButton(QuestMapFrame.DetailsFrame.AbandonButton)
	AS:SkinButton(QuestMapFrame.DetailsFrame.ShareButton, true)
	AS:SkinButton(QuestMapFrame.DetailsFrame.TrackButton)
	AS:SkinButton(QuestMapFrame.DetailsFrame.CompleteQuestFrame.CompleteButton, true)

	AS:SkinFrame(QuestMapFrame.QuestsFrame.StoryTooltip)
	QuestMapFrame.DetailsFrame.CompleteQuestFrame:StripTextures()
	QuestMapFrame.QuestsFrame.StoryTooltip:SetTemplate("Transparent")

	AS:SkinCloseButton(WorldMapFrameCloseButton)

	for _, Button in pairs({ WorldMapFrameSizeDownButton, WorldMapFrameSizeUpButton }) do
		AS:SkinButton(Button, true)
		Button:SetSize(16, 16)
		Button.Text = Button:CreateFontString(nil, 'OVERLAY')
		Button.Text:SetFont('Interface\\AddOns\\AddOnSkins\\Media\\Fonts\\Arial.ttf', 12)
		Button.Text:SetPoint('CENTER', Button)
	end

	local rewardFrames = {
		['MoneyFrame'] = true,
		['HonorFrame'] = true,
		['XPFrame'] = true,
		['SpellFrame'] = true,
		['SkillPointFrame'] = true,
	}

	local function HandleReward(frame)
		if not frame then return end
		frame.NameFrame:SetAlpha(0)
		AS:SkinTexture(frame.Icon)
		AS:CreateBackdrop(frame)
		frame.Backdrop:SetOutside(frame.Icon)
		frame.Count:ClearAllPoints()
		frame.Count:SetPoint("BOTTOMRIGHT", frame.Icon, "BOTTOMRIGHT", 2, 0)
		if (frame.CircleBackground) then
			frame.CircleBackground:SetAlpha(0)
			frame.CircleBackgroundGlow:SetAlpha(0)
		end
	end

	for frame, _ in pairs(rewardFrames) do
		HandleReward(MapQuestInfoRewardsFrame[frame])
	end

	hooksecurefunc('QuestInfo_GetRewardButton', function(rewardsFrame, index)
		local button = MapQuestInfoRewardsFrame.RewardButtons[index]
		if (button) then
			HandleReward(button)
		end
	end)

	AS:SkinNextPrevButton(WorldMapFrame.SidePanelToggle.OpenButton)
	AS:SkinNextPrevButton(WorldMapFrame.SidePanelToggle.CloseButton)

	AS:SkinMaxMinFrame(WorldMapFrame.BorderFrame.MaximizeMinimizeFrame)

	local function HandleTooltipStatusBar()
		local bar = _G["WorldMapTaskTooltipStatusBar"].Bar
		local label = bar.Label

		if bar and not bar.isSkinned then
			bar.isSkinned = true
			AS:SkinStatusBar(bar)

			label:ClearAllPoints()
			label:SetPoint("CENTER", bar, 0, 0)
			label:SetDrawLayer("OVERLAY")
		end
	end
	hooksecurefunc("TaskPOI_OnEnter", HandleTooltipStatusBar)

	if not AS.ParchmentEnabled then
		AS:SkinScrollBar(QuestMapDetailsScrollFrameScrollBar)
		AS:StripTextures(QuestMapFrame.DetailsFrame)
		AS:StripTextures(QuestMapFrame.DetailsFrame.RewardsFrame)
	end

	AS:SkinFrame(WorldMapFrame.SidePanelToggle.OpenButton)
	WorldMapFrame.SidePanelToggle.OpenButton.Text = WorldMapFrame.SidePanelToggle.OpenButton:CreateFontString(nil, 'OVERLAY')
	WorldMapFrame.SidePanelToggle.OpenButton.Text:SetFont('Interface\\AddOns\\AddOnSkins\\Media\\Fonts\\Arial.ttf', 12)
	WorldMapFrame.SidePanelToggle.OpenButton.Text:SetText('►')
	WorldMapFrame.SidePanelToggle.OpenButton.Text:SetPoint('CENTER', WorldMapFrame.SidePanelToggle.OpenButton)

	AS:SkinFrame(WorldMapFrame.SidePanelToggle.CloseButton)
	WorldMapFrame.SidePanelToggle.CloseButton.Text = WorldMapFrame.SidePanelToggle.CloseButton:CreateFontString(nil, 'OVERLAY')
	WorldMapFrame.SidePanelToggle.CloseButton.Text:SetFont('Interface\\AddOns\\AddOnSkins\\Media\\Fonts\\Arial.ttf', 12)
	WorldMapFrame.SidePanelToggle.CloseButton.Text:SetText('◄')
	WorldMapFrame.SidePanelToggle.CloseButton.Text:SetPoint('CENTER', WorldMapFrame.SidePanelToggle.CloseButton)

	--[[AS:SkinButton(WorldMapFrame.UIElementsFrame.TrackingOptionsButton)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Background:SetAlpha(0)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.IconOverlay:SetAlpha(0)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button.Border:SetAlpha(0)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button.Shine:SetAlpha(0)
	WorldMapFrame.UIElementsFrame.TrackingOptionsButton.Button:SetHighlightTexture('')]]--
end

AS:RegisterSkin('Blizzard_WorldMap', AS.Blizzard_WorldMap)