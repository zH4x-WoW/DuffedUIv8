local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	PVEFrame:StripTextures()
	PVEFrame:StripTextures()
	PVEFrameLeftInset:StripTextures()

	PVEFrameBg:Hide()
	PVEFrameTitleBg:Hide()
	PVEFramePortrait:Hide()
	PVEFramePortraitFrame:Hide()
	PVEFrameTopRightCorner:Hide()
	PVEFrameTopBorder:Hide()
	PVEFrameLeftInsetBg:Hide()
	PVEFrameLeftInsetInsetRightBorder:Hide()
	PVEFrame.shadows:Hide()

	for i = 1, 4 do
		local bu = GroupFinderFrame["groupButton" .. i]
		bu.ring:Hide()
		bu.bg:SetTexture("")
		bu.bg:SetAllPoints()
		bu:CreateBackdrop()
		bu:StyleButton()
		bu.icon:SetTexCoord(.08, .92, .08, .92)
		bu.icon:SetPoint("LEFT", bu, "LEFT")
		bu.icon:SetDrawLayer("OVERLAY")
		bu.icon:Size(40)
		bu.icon:ClearAllPoints()
		bu.icon:SetPoint("LEFT", 10, 0)
		bu.border = CreateFrame("Frame", nil, bu)
		bu.border:CreateBackdrop("Default")
		bu.border.backdrop:Point("TOPLEFT", bu.icon, -2, 2)
		bu.border.backdrop:Point("BOTTOMRIGHT", bu.icon, 2, -2)
	end

	PVEFrame:CreateBackdrop("Transparent")
	PVEFrameTab1:SkinTab()
	PVEFrameTab2:SkinTab()
	PVEFrameTab3:SkinTab()
	PVEFrameCloseButton:SkinCloseButton()

	-- Dungeon finder
	LFDQueueFrameFindGroupButton:StripTextures()
	LFDQueueFrameFindGroupButton:SkinButton()
	LFDParentFrame:StripTextures()
	LFDParentFrameInset:StripTextures()
	local function ReskinRewards()
		LFDQueueFrame:StripTextures()
		for i = 1, LFD_MAX_REWARDS do
			local button = _G["LFDQueueFrameRandomScrollFrameChildFrameItem" .. i]
			local icon = _G["LFDQueueFrameRandomScrollFrameChildFrameItem" .. i .. "IconTexture"]

			if button then
				if not button.reskinned then
					local cta = _G["LFDQueueFrameRandomScrollFrameChildFrameItem" .. i .. "ShortageBorder"]
					local count = _G["LFDQueueFrameRandomScrollFrameChildFrameItem" .. i .. "Count"]
					local na = _G["LFDQueueFrameRandomScrollFrameChildFrameItem" .. i .. "NameFrame"]

					icon:SetTexCoord(.08, .92, .08, .92)
					icon:SetDrawLayer("OVERLAY")
					count:SetDrawLayer("OVERLAY")
					na:SetColorTexture(0, 0, 0, .25)
					na:SetSize(118, 39)
					cta:SetAlpha(0)

					button:StripTextures()

					button.border = CreateFrame("Frame", nil, button)
					button.border:CreateBackdrop("Default")
					button.border.backdrop:Point("TOPLEFT", icon, -2, 2)
					button.border.backdrop:Point("BOTTOMRIGHT", icon, 2, -2)
					button.border.backdrop:SetBackdropColor(0, 0, 0, 0)

					button.reskinned = true
				end
			end
		end
	end
	hooksecurefunc("LFDQueueFrameRandom_UpdateFrame", ReskinRewards)
	
	local function HandleGoldIcon(button)
		_G[button.."IconTexture"]:SetTexCoord(unpack(D["IconCoord"]))
		_G[button.."IconTexture"]:SetDrawLayer("OVERLAY")
		_G[button.."Count"]:SetDrawLayer("OVERLAY")
		_G[button.."NameFrame"]:SetTexture()
		_G[button.."NameFrame"]:SetSize(118, 39)

		_G[button].border = CreateFrame("Frame", nil, _G[button])
		_G[button].border:SetTemplate()
		_G[button].border:SetOutside(_G[button.."IconTexture"])
		_G[button.."IconTexture"]:SetParent(_G[button].border)
		_G[button.."Count"]:SetParent(_G[button].border)
	end
	HandleGoldIcon("LFDQueueFrameRandomScrollFrameChildFrameMoneyReward")
	HandleGoldIcon("RaidFinderQueueFrameScrollFrameChildFrameMoneyReward")
	HandleGoldIcon("ScenarioQueueFrameRandomScrollFrameChildFrameMoneyReward")

	for i = 1, NUM_LFD_CHOICE_BUTTONS do _G["LFDQueueFrameSpecificListButton"..i].enableButton:SkinCheckBox() end

	for i = 1, NUM_LFR_CHOICE_BUTTONS do
		local bu = _G["LFRQueueFrameSpecificListButton"..i].enableButton
		bu:SkinCheckBox()
		bu.SetNormalTexture = D.Dummy
		bu.SetPushedTexture = D.Dummy
	end

	LFDQueueFrameTypeDropDown:SkinDropDownBox()
	LFDQueueFrameRandomScrollFrameChildFrameBonusRepFrame.ChooseButton:SkinButton()

	-- Raid Finder
	RaidFinderFrame:StripTextures()
	RaidFinderFrameBottomInset:StripTextures()
	RaidFinderFrameRoleInset:StripTextures()
	RaidFinderFrameBottomInsetBg:Hide()
	RaidFinderFrameBtnCornerRight:Hide()
	RaidFinderFrameButtonBottomBorder:Hide()
	RaidFinderQueueFrameSelectionDropDown:SkinDropDownBox()
	RaidFinderFrameFindRaidButton:StripTextures()
	RaidFinderFrameFindRaidButton:SkinButton()
	RaidFinderQueueFrame:StripTextures()
	RaidFinderQueueFrameBackground:SetAlpha(0)
	RaidFinderQueueFramePartyBackfillBackfillButton:SkinButton()
	RaidFinderQueueFramePartyBackfillNoBackfillButton:SkinButton()

	for i = 1, LFD_MAX_REWARDS do
		local button = _G["RaidFinderQueueFrameScrollFrameChildFrameItem" .. i]
		local icon = _G["RaidFinderQueueFrameScrollFrameChildFrameItem" .. i .. "IconTexture"]

		if button then
			if not button.reskinned then
				local cta = _G["RaidFinderQueueFrameScrollFrameChildFrameItem" .. i .. "ShortageBorder"]
				local count = _G["RaidFinderQueueFrameScrollFrameChildFrameItem" .. i .. "Count"]
				local na = _G["RaidFinderQueueFrameScrollFrameChildFrameItem" .. i .. "NameFrame"]

				icon:SetTexCoord(.08, .92, .08, .92)
				icon:SetDrawLayer("OVERLAY")
				count:SetDrawLayer("OVERLAY")
				na:SetColorTexture(0, 0, 0, .25)
				na:SetSize(118, 39)
				cta:SetAlpha(0)

				button:StripTextures()

				button.border = CreateFrame("Frame", nil, button)
				button.border:CreateBackdrop("Default")
				button.border.backdrop:Point("TOPLEFT", icon, -2, 2)
				button.border.backdrop:Point("BOTTOMRIGHT", icon, 2, -2)
				button.border.backdrop:SetBackdropColor(0, 0, 0, 0)

				button.reskinned = true
			end
		end
		RaidFinderQueueFrameScrollFrameChildFrameMoneyReward:StripTextures()
	end

	-- Scenario finder
	ScenarioFinderFrameInset:DisableDrawLayer("BORDER")
	ScenarioFinderFrame.TopTileStreaks:Hide()
	ScenarioFinderFrameBtnCornerRight:Hide()
	ScenarioFinderFrameButtonBottomBorder:Hide()
	ScenarioQueueFrame.Bg:Hide()
	ScenarioFinderFrameInset:GetRegions():Hide()

	ScenarioQueueFrameFindGroupButton:StripTextures()
	ScenarioQueueFrameFindGroupButton:SkinButton()
	ScenarioQueueFrameTypeDropDown:SkinDropDownBox()
	ScenarioQueueFrameTypeDropDown:ClearAllPoints()
	ScenarioQueueFrameTypeDropDown:Point("TOPRIGHT", -5, -40)
	ScenarioQueueFrameSpecificScrollFrameScrollBackgroundTopLeft:Hide()
	ScenarioQueueFrameSpecificScrollFrameScrollBackgroundBottomRight:Hide()
	ScenarioQueueFrameSpecificScrollFrameScrollBar:SkinScrollBar()

	local function SkinScenarioCheckBox()
		if NUM_SCENARIO_CHOICE_BUTTONS then
			for i = 1, NUM_SCENARIO_CHOICE_BUTTONS do
				local button = _G["ScenarioQueueFrameSpecificButton" .. i]
				if button and not button.isSkinned then
					button.enableButton:SkinCheckBox()
					button.isSkinned = true
				end
			end
		end
	end
	hooksecurefunc("ScenarioQueueFrameSpecific_Update", SkinScenarioCheckBox)

	local function SkinScenarioRewards()
		for i = 1, 4 do
			local b = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem" .. i]
			local icon = _G["ScenarioQueueFrameRandomScrollFrameChildFrameItem" .. i .. "IconTexture"]
			if b and not b.isSkinned then
				icon:SetTexCoord(.1, .9, .1, .9)
				icon:SetDrawLayer("OVERLAY")
				b:StripTextures()
				b.isSkinned = true

				b.border = CreateFrame("Frame", nil, b)
				b.border:SetOutside(icon)
				b.border:SetTemplate()
				b.border:SetBackdropColor(0,0,0,0)
			end
		end
		ScenarioQueueFrameRandomScrollFrameChildFrameMoneyReward:StripTextures()
	end
	hooksecurefunc("ScenarioQueueFrameRandom_UpdateFrame", SkinScenarioRewards)

	-- Raid frame (social frame)
	RaidFrameAllAssistCheckButton:SkinCheckBox()

	-- Looking for raid
	LFRBrowseFrameRoleInset:DisableDrawLayer("BORDER")
	RaidBrowserFrameBg:Hide()
	LFRQueueFrameSpecificListScrollFrameScrollBackgroundTopLeft:Hide()
	LFRQueueFrameSpecificListScrollFrameScrollBackgroundBottomRight:Hide()
	LFRBrowseFrameRoleInsetBg:Hide()

	for i = 1, 14 do
		if i ~= 6 and i ~= 8 then select(i, RaidBrowserFrame:GetRegions()):Hide() end
	end

	RaidBrowserFrame:CreateBackdrop("Transparent")
	RaidBrowserFrame:StripTextures()
	RaidBrowserFrameCloseButton:SkinCloseButton()
	LFRQueueFrameSpecificListScrollFrameScrollBar:SkinScrollBar()
	LFRQueueFrameCommentScrollFrameScrollBar:SkinScrollBar()
	LFRQueueFrameFindGroupButton:SkinButton()
	LFRQueueFrameAcceptCommentButton:SkinButton()

	for i = 1, 2 do
		local tab = _G["LFRParentFrameSideTab" .. i]
		select(1, tab:GetRegions()):Hide()

		tab:GetNormalTexture():SetTexCoord(.1, .9, .1, .9)
		tab:GetNormalTexture():ClearAllPoints()
		tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
		tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

		tab:CreateBackdrop("Default")
		tab.backdrop:SetAllPoints()
		tab:StyleButton()

		local point, relatedTo, point2, x, y = tab:GetPoint()
		if i == 1 then tab:Point(point, relatedTo, point2, 3, 2) end
	end

	for i = 1, 7 do
		local h = _G["LFRBrowseFrameColumnHeader"..i]
		select(1, h:GetRegions()):Hide()
		select(2, h:GetRegions()):Hide()
		select(3, h:GetRegions()):Hide()
		h:StyleButton()
	end

	LFRBrowseFrameListScrollFrameScrollBar:SkinScrollBar()
	LFRBrowseFrame:StripTextures()
	LFRBrowseFrameSendMessageButton:SkinButton()
	LFRBrowseFrameInviteButton:SkinButton()
	LFRBrowseFrameRefreshButton:SkinButton()
	LFRBrowseFrameRaidDropDown:SkinDropDownBox()

	local StripAllTextures = {
		"LFDQueueFrameSpecific",
		"LFDQueueFrameRandom",
		"LFDDungeonReadyDialog",
		"LFGDungeonReadyDialog",
	}

	local KillTextures = {
		"LFDQueueFrameBackground",
		"LFDParentFrameInset",
		"LFDParentFrameEyeFrame",
		"LFDDungeonReadyDialogBackground",
		"LFGDungeonReadyDialogBackground",
	}

	local buttons = {
		"LFDQueueFramePartyBackfillBackfillButton",
		"LFDQueueFramePartyBackfillNoBackfillButton",
	}

	local checkButtons = {
		"LFDQueueFrameRoleButtonTank",
		"LFDQueueFrameRoleButtonHealer",
		"LFDQueueFrameRoleButtonDPS",
		"LFDQueueFrameRoleButtonLeader",
		"RaidFinderQueueFrameRoleButtonTank",
		"RaidFinderQueueFrameRoleButtonHealer",
		"RaidFinderQueueFrameRoleButtonDPS",
		"RaidFinderQueueFrameRoleButtonLeader",
	}

	for _, object in pairs(checkButtons) do
		_G[object]:GetChildren():SetFrameLevel(_G[object]:GetChildren():GetFrameLevel() + 2)
		_G[object]:GetChildren():SkinCheckBox()
	end

	for _, object in pairs(StripAllTextures) do 
		if _G[object] then _G[object]:StripTextures() end
	end

	for _, texture in pairs(KillTextures) do
		if _G[texture] then _G[texture]:Kill() end
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end	

	for i= 1,15 do
		_G["LFDQueueFrameSpecificListButton"..i.."EnableButton"]:SkinCheckBox()
	end

	LFDQueueFrameTypeDropDown:Point("RIGHT",-10,0)
	LFDQueueFrameSpecificListScrollFrameScrollBar:SkinScrollBar()

	LFGDungeonReadyPopup:SetTemplate("Transparent")
	LFGDungeonReadyDialog.SetBackdrop = D.Dummy
	LFGDungeonReadyDialog.filigree:SetAlpha(0)
	LFGDungeonReadyDialog.bottomArt:SetAlpha(0)
	LFGDungeonReadyDialogLeaveQueueButton:SkinButton()
	LFGDungeonReadyDialogEnterDungeonButton:SkinButton()
	LFGDungeonReadyDialogCloseButton:SkinCloseButton()
	LFGDungeonReadyDialogCloseButton.t:SetText("_")
	LFGDungeonReadyStatus:SetTemplate("Transparent")
	LFGDungeonReadyStatusCloseButton:SkinCloseButton()
	LFGDungeonReadyStatusCloseButton.t:SetText("_")
	PVEFrameTab1:Point("BOTTOMLEFT", PVEFrame, "BOTTOMLEFT", 19, -32)
	RaidFinderQueueFrameCooldownFrame:Point("BOTTOMRIGHT", RaidFinderQueueFrame, "BOTTOMRIGHT", -6, 28)
	LFDQueueFrameTypeDropDown:ClearAllPoints()
	LFDQueueFrameTypeDropDown:Point("TOPRIGHT", LFDQueueFrame, "TOPRIGHT", -10, -111)
	RaidFinderQueueFrameSelectionDropDown:ClearAllPoints()
	RaidFinderQueueFrameSelectionDropDown:Point("TOPRIGHT", RaidFinderQueueFrame, "TOPRIGHT", -10, -109)
	ScenarioQueueFrameRandomScrollFrameChildFrameBonusRepFrame.ChooseButton:SkinButton()
	LFDQueueFrameRandomScrollFrameScrollBar:StripTextures()
	LFDQueueFrameRandomScrollFrameScrollBar:SkinScrollBar()
	
	--LFGListFrame
	LFGListFrame.CategorySelection.Inset:StripTextures()
	LFGListFrame.CategorySelection.StartGroupButton:SkinButton(true)
	LFGListFrame.CategorySelection.FindGroupButton:SkinButton(true)
	LFGListFrame.CategorySelection.StartGroupButton:ClearAllPoints()
	LFGListFrame.CategorySelection.StartGroupButton:Point("BOTTOMLEFT", -1, 3)
	LFGListFrame.CategorySelection.FindGroupButton:ClearAllPoints()
	LFGListFrame.CategorySelection.FindGroupButton:Point("BOTTOMRIGHT", -6, 3)

	--Fix issue with labels not following changes to GameFontNormal as they should
	local function SetLabelFontObject(self, btnIndex)
		local button = self.CategoryButtons[btnIndex]
		if button then button.Label:SetFontObject(GameFontNormal) end
	end
	hooksecurefunc("LFGListCategorySelection_AddButton", SetLabelFontObject)

	LFGListFrame.EntryCreation.Name:SkinEditBox()
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SkinEditBox()
	LFGListFrame.EntryCreation.HonorLevel.EditBox:SkinEditBox()
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SkinEditBox()

	LFGListEntryCreationActivityDropDown:SkinDropDownBox()
	LFGListEntryCreationGroupDropDown:SkinDropDownBox()
	LFGListEntryCreationCategoryDropDown:SkinDropDownBox(330)

	LFGListFrame.EntryCreation.ItemLevel.CheckButton:SkinCheckBox()
	LFGListFrame.EntryCreation.HonorLevel.CheckButton:SkinCheckBox()
	LFGListFrame.EntryCreation.VoiceChat.CheckButton:SkinCheckBox()

	LFGListFrame.EntryCreation.ActivityFinder.Dialog:StripTextures()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog:SetTemplate("Transparent")
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:StripTextures()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.BorderFrame:SetTemplate("Transparent")

	LFGListFrame.EntryCreation.ActivityFinder.Dialog.EntryBox:SkinEditBox()
	LFGListEntryCreationSearchScrollFrameScrollBar:SkinEditBox()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.SelectButton:SkinButton()
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.CancelButton:SkinButton()

	LFGListInviteDialog:SetTemplate("Transparent")
	LFGListInviteDialog.AcknowledgeButton:SkinButton()
	LFGListInviteDialog.AcceptButton:SkinButton()
	LFGListInviteDialog.DeclineButton:SkinButton()
	LFGListInviteDialog.RoleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICONS-ROLEBACKGROUNDS")
	local function SetRoleIcon(self, resultID)
		local _,_,_,_, role = C_LFGList_GetApplicationInfo(resultID)
		self.RoleIcon:SetTexCoord(GetBackgroundTexCoordsForRole(role))
	end
	hooksecurefunc("LFGListInviteDialog_Show", SetRoleIcon)

	LFGListFrame.SearchPanel.SearchBox:SkinEditBox()

	LFGListFrame.SearchPanel.BackButton:SkinButton(true)
	LFGListFrame.SearchPanel.SignUpButton:SkinButton(true)
	LFGListSearchPanelScrollFrame.StartGroupButton:SkinButton(true)
	LFGListFrame.SearchPanel.BackButton:ClearAllPoints()
	LFGListFrame.SearchPanel.BackButton:Point("BOTTOMLEFT", -1, 3)
	LFGListFrame.SearchPanel.SignUpButton:ClearAllPoints()
	LFGListFrame.SearchPanel.SignUpButton:Point("BOTTOMRIGHT", -6, 3)
	LFGListFrame.SearchPanel.ResultsInset:StripTextures()
	LFGListSearchPanelScrollFrameScrollBar:SkinScrollBar()
	LFGListFrame.SearchPanel.AutoCompleteFrame:StripTextures()
	LFGListFrame.SearchPanel.AutoCompleteFrame:SetTemplate("Transparent")

	LFGListFrame.SearchPanel.FilterButton:SkinButton()
	LFGListFrame.SearchPanel.RefreshButton:SkinButton()
	LFGListFrame.SearchPanel.RefreshButton:Size(26)


	--ApplicationViewer (Custom Groups)
	LFGListFrame.ApplicationViewer.InfoBackground:SetTexCoord(unpack(D["IconCoord"]))
	LFGListFrame.ApplicationViewer.AutoAcceptButton:SkinCheckBox()

	LFGListFrame.ApplicationViewer.Inset:StripTextures()
	LFGListFrame.ApplicationViewer.Inset:SetTemplate("Transparent")

	LFGListFrame.ApplicationViewer.NameColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.RoleColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SkinButton(true)
	LFGListFrame.ApplicationViewer.NameColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.NameColumnHeader:Point("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPLEFT", 0, 1)
	LFGListFrame.ApplicationViewer.RoleColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RoleColumnHeader:Point("LEFT", LFGListFrame.ApplicationViewer.NameColumnHeader, "RIGHT", 1, 0)
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:ClearAllPoints()
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:Point("LEFT", LFGListFrame.ApplicationViewer.RoleColumnHeader, "RIGHT", 1, 0)

	LFGListFrame.ApplicationViewer.RefreshButton:SkinButton()
	LFGListFrame.ApplicationViewer.RefreshButton:SetSize(24,24)
	LFGListFrame.ApplicationViewer.RefreshButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RefreshButton:Point("BOTTOMRIGHT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 16, 4)

	LFGListFrame.ApplicationViewer.RemoveEntryButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.EditButton:SkinButton(true)
	LFGListFrame.ApplicationViewer.RemoveEntryButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.RemoveEntryButton:Point("BOTTOMLEFT", -1, 3)
	LFGListFrame.ApplicationViewer.EditButton:ClearAllPoints()
	LFGListFrame.ApplicationViewer.EditButton:Point("BOTTOMRIGHT", -6, 3)

	LFGListApplicationViewerScrollFrameScrollBar:SkinScrollBar()
	LFGListApplicationViewerScrollFrameScrollBar:ClearAllPoints()
	LFGListApplicationViewerScrollFrameScrollBar:Point("TOPLEFT", LFGListFrame.ApplicationViewer.Inset, "TOPRIGHT", 0, -14)
	LFGListApplicationViewerScrollFrameScrollBar:Point("BOTTOMLEFT", LFGListFrame.ApplicationViewer.Inset, "BOTTOMRIGHT", 0, 14)
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)

local function LoadSecondarySkin()
	ChallengesFrameInset:StripTextures()
	ChallengesFrameInsetBg:Hide()
	ChallengesFrame.Background:Hide()
end

D.SkinFuncs["Blizzard_ChallengesUI"] = LoadSecondarySkin