local AS = unpack(AddOnSkins)
--if IsAddOnLoaded("DuffedUI") then return end


function AS:Blizzard_Friends()
	local StripAllTextures = {
		FriendsFrame,
		FriendsListFrame,
		FriendsTabHeader,
		FriendsListFrameScrollFrame,
		WhoFrameColumnHeader1,
		WhoFrameColumnHeader2,
		WhoFrameColumnHeader3,
		WhoFrameColumnHeader4,
		AddFriendFrame,
		FriendsFriendsFrame,
		IgnoreListFrame,
		FriendsFrameInset,
		WhoFrameListInset,
		WhoFrameEditBoxInset,
		LFRQueueFrameListInset,
		LFRQueueFrameRoleInset,
		LFRQueueFrameCommentInset,
		FriendsFrameBattlenetFrame,
		BattleTagInviteFrame,
		QuickJoinScrollFrame,
		QuickJoinRoleSelectionFrame,
		FriendsFrameBattlenetFrame.BroadcastFrame,
		FriendsFrameBattlenetFrame.UnavailableInfoFrame
	}

	for i = 1, #StripAllTextures do
		AS:StripTextures(StripAllTextures[i])
	end

	local KillTextures = {
		FriendsFrameIcon
	}

	for i = 1, #KillTextures do
		AS:Kill(KillTextures[i])
	end

	local buttons = {
		FriendsFrameAddFriendButton,
		FriendsFrameSendMessageButton,
		WhoFrameWhoButton,
		WhoFrameAddFriendButton,
		WhoFrameGroupInviteButton,
		FriendsFrameIgnorePlayerButton,
		FriendsFrameUnsquelchButton,
		AddFriendEntryFrameAcceptButton,
		AddFriendEntryFrameCancelButton,
		AddFriendInfoFrameContinueButton,
		QuickJoinFrame.JoinQueueButton,
		QuickJoinRoleSelectionFrame.AcceptButton,
		QuickJoinRoleSelectionFrame.CancelButton,
		FriendsListFrameScrollFrame.PendingInvitesHeaderButton,
		FriendsFrameBattlenetFrame.BroadcastFrame.CancelButton,
		FriendsFrameBattlenetFrame.BroadcastFrame.UpdateButton
	}

	for i = 1, #buttons do
		AS:SkinButton(buttons[i])
	end

	local scrollbars = {
		FriendsListFrameScrollFrame.scrollBar,
		FriendsFriendsScrollFrame.scrollBar,
		IgnoreListFrameScrollFrame.scrollBar,
		WhoListScrollFrame.scrollBar,
		QuickJoinScrollFrame.scrollBar
	}

	for i = 1, #scrollbars do
		AS:SkinScrollBar(scrollbars[i])
	end

	-- Reposition buttons
	WhoFrameWhoButton:SetPoint("RIGHT", WhoFrameAddFriendButton, "LEFT", -3, 0)
	WhoFrameAddFriendButton:SetPoint("RIGHT", WhoFrameGroupInviteButton, "LEFT", -3, 0)
	WhoFrameGroupInviteButton:SetPoint("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameAddFriendButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameSendMessageButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)
	FriendsFrameIgnorePlayerButton:SetPoint("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 4, 4)
	FriendsFrameUnsquelchButton:SetPoint("BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -4, 4)

	-- Resize Buttons
	WhoFrameWhoButton:SetSize(WhoFrameWhoButton:GetWidth() + 7, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:SetSize(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:SetSize(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	AS:SkinEditBox(WhoFrameEditBox, WhoFrameEditBox:GetWidth() + 30, WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:SetPoint("BOTTOM", WhoFrame, "BOTTOM", 0, 31)

	AS:SkinEditBox(AddFriendNameEditBox)
	AddFriendNameEditBox:SetHeight(AddFriendNameEditBox:GetHeight() - 5)
	AS:SkinFrame(AddFriendFrame)
	AS:SkinFrame(FriendsFriendsFrame)

	-- Quick Join Frame
	QuickJoinRoleSelectionFrame:SetTemplate("Transparent")
	AS:SkinCloseButton(QuickJoinRoleSelectionFrame.CloseButton)
	AS:SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonTank.CheckButton)
	AS:SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonHealer.CheckButton)
	AS:SkinCheckBox(QuickJoinRoleSelectionFrame.RoleButtonDPS.CheckButton)

	-- Pending invites
	local function SkinFriendRequest(frame)
		if not frame.isSkinned then
			frame.DeclineButton:SetPoint("RIGHT", frame, "RIGHT", -2, 1)
			AS:SkinButton(frame.DeclineButton)
			AS:SkinButton(frame.AcceptButton)
			frame.isSkinned = true
		end
	end
	hooksecurefunc(FriendsListFrameScrollFrame.invitePool, "Acquire", function()
		for object in pairs(FriendsListFrameScrollFrame.invitePool.activeObjects) do
			SkinFriendRequest(object)
		end
	end)

	-- Who Frame
	local function UpdateWhoSkins()
		WhoListScrollFrame:StripTextures()
	end

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)

	-- BNet Frame
	FriendsFrameBattlenetFrame.BroadcastButton:SetAlpha(0)
	FriendsFrameBattlenetFrame.BroadcastButton:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAllPoints(FriendsFrameBattlenetFrame)

	AS:SkinBackdropFrame(FriendsFrameBattlenetFrame.BroadcastFrame)
	FriendsFrameBattlenetFrame.BroadcastFrame.Backdrop:SetPoint("TOPLEFT", 1, 1)
	FriendsFrameBattlenetFrame.BroadcastFrame.Backdrop:SetPoint("BOTTOMRIGHT", 1, 1)

	AS:SkinEditBox(FriendsFrameBattlenetFrame.BroadcastFrame.EditBox, nil, 24)

	AS:SkinBackdropFrame(FriendsFrameBattlenetFrame.UnavailableInfoFrame)
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.Backdrop:SetPoint("TOPLEFT", 4, -4)
	FriendsFrameBattlenetFrame.UnavailableInfoFrame.Backdrop:SetPoint("BOTTOMRIGHT", -4, 4)

	AS:SkinFrame(BattleTagInviteFrame)
	for i = 1, BattleTagInviteFrame:GetNumChildren() do
		local child = select(i, BattleTagInviteFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			child:SkinButton()
		end
	end

	AS:SkinFrame(FriendsFrame)
	AS:SkinFrame(RecruitAFriendFrame)
	FriendsFrameStatusDropDown:SetPoint("TOPLEFT", 1, -27)

	for i = 1, FRIENDS_TO_DISPLAY do
		local button = _G["FriendsListFrameScrollFrameButton"..i]
		local icon = button.gameIcon

		icon.b = CreateFrame("Frame", nil, button)
		AS:SkinButton(icon.b)
		icon.b:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
		icon.b:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

		icon:SetParent(icon.b)
		icon:SetSize(22, 22)
		icon:SetTexCoord(.15, .85, .15, .85)
		icon:ClearAllPoints()
		icon:SetPoint("RIGHT", button, "RIGHT", -24, 0)
		icon.SetPoint = AS.Noop

		button.travelPassButton:SetSize(20, 32)
		AS:SkinButton(button.travelPassButton)
		button.background:Hide()

		button.inv = button.travelPassButton:CreateTexture(nil, "OVERLAY", nil, 7)
		button.inv:SetTexture([[Interface\FriendsFrame\PlusManz-PlusManz]])
		button.inv:SetPoint("TOPRIGHT", 1, -4)
		button.inv:SetSize(22, 22)
	end

	hooksecurefunc("FriendsFrame_UpdateFriendButton", function(button)
		if button.buttonType == FRIENDS_BUTTON_TYPE_BNET and button.travelPassButton then
			local isEnabled = button.travelPassButton:IsEnabled()
			button.travelPassButton:SetAlpha(isEnabled and 1 or 0.4)
		end

		if button.gameIcon.b then
			button.gameIcon.b:SetShown(button.gameIcon:IsShown())
		end
	end)

	AS:SkinCloseButton(FriendsFrameCloseButton)
	AS:SkinDropDownBox(WhoFrameDropDown, 150)
	AS:SkinDropDownBox(FriendsFrameStatusDropDown, 70)
	AS:SkinDropDownBox(FriendsFriendsFrameDropDown)

	-- Bottom Tabs
	for i = 1, 4 do
		AS:SkinTab(_G["FriendsFrameTab"..i])
	end

	for i = 1, 3 do
		AS:SkinTab(_G["FriendsTabHeaderTab"..i], true)
	end
end

AS:RegisterSkin('Blizzard_Friends', AS.Blizzard_Friends)