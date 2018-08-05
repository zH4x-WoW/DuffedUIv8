local D, C, L = unpack(select(2, ...)) 

local function CommunitySkin()
	local CommunitiesFrame = _G['CommunitiesFrame']
	CommunitiesFrame:StripTextures()
	CommunitiesFrame.PortraitOverlay:Kill()
	CommunitiesFrame.PortraitOverlay.Portrait:Hide()
	CommunitiesFrame.PortraitOverlay.PortraitFrame:Hide()
	CommunitiesFrame.CommunitiesList.InsetFrame:StripTextures()
	CommunitiesFrame.TopBorder:Hide()
	CommunitiesFrame.LeftBorder:Hide()
	CommunitiesFrame.TopLeftCorner:Hide()

	CommunitiesFrame:CreateBackdrop('Transparent')
	CommunitiesFrameCommunitiesList.FilligreeOverlay:Hide()
	CommunitiesFrameCommunitiesList.Bg:Hide()
	CommunitiesFrameCommunitiesList.TopFiligree:Hide()
	CommunitiesFrameCommunitiesList.BottomFiligree:Hide()
	CommunitiesFrameTopTileStreaks:Hide()
	CommunitiesFrameCommunitiesListListScrollFrame:StripTextures()
	CommunitiesFrameInsetBg:Hide()
	CommunitiesFrameInsetInsetBottomBorder:Hide()
	CommunitiesFrameInsetInsetLeftBorder:Hide()
	CommunitiesFrameInsetInsetBotLeftCorner:Hide()
	CommunitiesFrameInsetInsetBotRightCorner:Hide()
	CommunitiesFrameInsetInsetRightBorder:Hide()
	CommunitiesFrameInsetInsetLeftBorder:Hide()
	CommunitiesFrameInsetInsetTopBorder:Hide()
	CommunitiesFrameInsetInsetTopLeftCorner:Hide()
	CommunitiesFrameInsetInsetTopRightCorner:Hide()
	CommunitiesFrameCommunitiesListInsetBottomBorder:Hide()
	CommunitiesFrameCommunitiesListInsetBotRightCorner:Hide()
	CommunitiesFrameCommunitiesListInsetRightBorder:Hide()
	CommunitiesFrameInsetBottomBorder:Hide()
	CommunitiesFrameInsetLeftBorder:Hide()
	CommunitiesFrameInsetRightBorder:Hide()
	CommunitiesFrameInsetTopRightCorner:Hide()
	CommunitiesFrameInsetTopLeftCorner:Hide()
	CommunitiesFrameInsetTopBorder:Hide()
	CommunitiesFrameInsetBotRightCorner:Hide()
	CommunitiesFrameInsetBotLeftCorner:Hide()

	hooksecurefunc(CommunitiesListEntryMixin, 'SetClubInfo', function(self, clubInfo)
		if clubInfo then
			self:SetSize(166, 67)
			self.Background:Hide()
			self:SetFrameLevel(self:GetFrameLevel()+5)

			self.Icon:SkinCropIcon()
			self.Icon:RemoveMaskTexture(self.CircleMask)
			self.Icon:SetDrawLayer('OVERLAY', 1)
			self.Icon:SetTexCoord(unpack(D['IconCoord']))
			self.IconRing:Hide()

			if not self.bg then
				self.bg = CreateFrame('Frame', nil, self)
				self.bg:CreateBackdrop('Overlay')
				self.bg:SetFrameLevel(self:GetFrameLevel() -2)
				self.bg:Point('TOPLEFT', 4, -3)
				self.bg:Point('BOTTOMRIGHT', -1, 3)
			end

			local isGuild = clubInfo.clubType == Enum.ClubType.Guild
			if isGuild then
				self.Selection:SetInside(self.bg)
				self.Selection:SetColorTexture(0, 1, 0, 0.2)
			else
				self.Selection:SetInside(self.bg)
				self.Selection:SetColorTexture(FRIENDS_BNET_BACKGROUND_COLOR.r, FRIENDS_BNET_BACKGROUND_COLOR.g, FRIENDS_BNET_BACKGROUND_COLOR.b, 0.2)
			end

			local highlight = self:GetHighlightTexture()
			highlight:SetColorTexture(1, 1, 1, 0.3)
			highlight:SetInside(self.bg)
		end
	end)

	hooksecurefunc(CommunitiesListEntryMixin, 'SetAddCommunity', function(self)
		self:SetSize(166, 67)

		self.Background:Hide()
		self:SetFrameLevel(self:GetFrameLevel()+5)
		self.Icon:SkinCropIcon()
		self.CircleMask:Hide()
		self.Icon:SetDrawLayer('OVERLAY', 1)
		self.Icon:SetTexCoord(unpack(D['IconCoord']))
		self.IconRing:Hide()

		if not self.bg then
			self.bg = CreateFrame('Frame', nil, self)
			self.bg:CreateBackdrop('Overlay')
			self.bg:SetFrameLevel(self:GetFrameLevel() -2)
			self.bg:Point('TOPLEFT', 4, -3)
			self.bg:Point('BOTTOMRIGHT', -1, 3)
		end

		local highlight = self:GetHighlightTexture()
		highlight:SetColorTexture(1, 1, 1, 0.3)
		highlight:SetInside(self.bg)
	end)

	local function SkinTab(tab)
		local normTex = tab:GetNormalTexture()
		if normTex then
			normTex:SetTexCoord(unpack(D['IconCoord']))
			normTex:SetInside()
		end

		if not tab.isSkinned then
			for i = 1, tab:GetNumRegions() do
				local region = select(i, tab:GetRegions())
				if region:GetObjectType() == 'Texture' then
					if region:GetTexture() == 'Interface\\SpellBook\\SpellBook-SkillLineTab' then region:Kill() end
				end
			end

			tab.pushed = true
			tab:CreateBackdrop('Default')
			tab.backdrop:Point('TOPLEFT', -2, 2)
			tab.backdrop:Point('BOTTOMRIGHT', 2, -2)
			tab:StyleButton(true)
			tab.Icon:SetTexCoord(unpack(D['IconCoord']))

			hooksecurefunc(tab:GetHighlightTexture(), 'SetTexture', function(self, texPath)
				if texPath ~= nil then self:SetPushedTexture(nil) end
			end)

			hooksecurefunc(tab:GetCheckedTexture(), 'SetTexture', function(self, texPath)
				if texPath ~= nil then
					self:SetHighlightTexture(nil)
				end
			end)

			local point, relatedTo, point2, _, y = tab:GetPoint()
			tab:Point(point, relatedTo, point2, 1, y)
		end

		tab.isSkinned = true
	end

	CommunitiesFrame.CommunitiesList:SkinInsetFrameTemplate()
	CommunitiesFrame.MaximizeMinimizeFrame:SkinMaxMinFrame()
	CommunitiesFrameCloseButton:SkinCloseButton()
	CommunitiesFrame.InviteButton:SkinButton()
	CommunitiesFrame.AddToChatButton:ClearAllPoints()
	CommunitiesFrame.AddToChatButton:SetPoint('BOTTOM', CommunitiesFrame.ChatEditBox, 'BOTTOMRIGHT', -5, -30) -- needs probably adjustment
	CommunitiesFrame.AddToChatButton:SkinButton()
	CommunitiesFrame.GuildFinderFrame.FindAGuildButton:SkinButton()

	-- Chat tab
	CommunitiesFrame.MemberList:StripTextures()
	CommunitiesFrame.MemberList.InsetFrame:Hide()
	CommunitiesFrame.Chat.InsetFrame:StripTextures()
	CommunitiesFrame.Chat.InsetFrame:SetTemplate('Transparent')
	CommunitiesFrame.GuildFinderFrame:StripTextures()
	CommunitiesFrame.GuildFinderFrame.InsetFrame:StripTextures()
	CommunitiesFrame.ChatEditBox:SkinEditBox()
	CommunitiesFrame.ChatEditBox:SetSize(120, 20)

	-- Member details
	CommunitiesFrame.GuildMemberDetailFrame:StripTextures()
	CommunitiesFrame.GuildMemberDetailFrame:CreateBackdrop('Transparent')
	CommunitiesFrame.GuildMemberDetailFrame.NoteBackground:SetTemplate('Transparent')
	CommunitiesFrame.GuildMemberDetailFrame.OfficerNoteBackground:SetTemplate('Transparent')
	CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SkinCloseButton()
	CommunitiesFrame.GuildMemberDetailFrame.RemoveButton:SkinButton()
	CommunitiesFrame.GuildMemberDetailFrame.GroupInviteButton:SkinButton()

	-- Roster tab
	local MemberList = CommunitiesFrame.MemberList
	local ColumnDisplay = MemberList.ColumnDisplay
	ColumnDisplay:StripTextures()
	ColumnDisplay.InsetBorderLeft:Hide()
	ColumnDisplay.InsetBorderBottomLeft:Hide()
	ColumnDisplay.InsetBorderTopLeft:Hide()
	ColumnDisplay.InsetBorderTop:Hide()

	CommunitiesFrame.MemberList.InsetFrame:SkinInsetFrameTemplate()
	CommunitiesFrame.CommunitiesControlFrame.GuildControlButton:SkinButton()
	CommunitiesFrame.CommunitiesControlFrame.GuildRecruitmentButton:SkinButton()
	CommunitiesFrame.CommunitiesControlFrame.CommunitiesSettingsButton:SkinButton()
	CommunitiesFrame.MemberList.ShowOfflineButton:SkinCheckBox()

	local function UpdateNames(self)
		if not self.expanded then return end

		local memberInfo = self:GetMemberInfo()
		if memberInfo and memberInfo.classID then
			local classInfo = C_CreatureInfo.GetClassInfo(memberInfo.classID)
			if classInfo then
				local tcoords = CLASS_ICON_TCOORDS[classInfo.classFile]
				self.Class:SetTexCoord(tcoords[1] + .022, tcoords[2] - .025, tcoords[3] + .022, tcoords[4] - .025)
			end
		end
	end

	hooksecurefunc(CommunitiesFrame.MemberList, 'RefreshListDisplay', function(self)
		for i = 1, self.ColumnDisplay:GetNumChildren() do
			local child = select(i, self.ColumnDisplay:GetChildren())
			if not child.IsSkinned then
				child:StripTextures()
				child:SetTemplate('Transparent')

				child.IsSkinned = true
			end
		end

		for _, button in ipairs(self.ListScrollFrame.buttons or {}) do
			if button and not button.hooked then
				hooksecurefunc(button, 'RefreshExpandedColumns', UpdateNames)
				if button.ProfessionHeader then
					local header = button.ProfessionHeader
					for i = 1, 3 do select(i, header:GetRegions()):Hide() end
					header:SetTemplate('Transparent')
				end

				button.hooked = true
			end
			if button and button.bg then button.bg:SetShown(button.Class:IsShown()) end
		end
	end)

	-- Perks tab
	local GuildBenefitsFrame = CommunitiesFrame.GuildBenefitsFrame
	GuildBenefitsFrame.InsetBorderLeft:Hide()
	GuildBenefitsFrame.InsetBorderRight:Hide()
	GuildBenefitsFrame.InsetBorderBottomRight:Hide()
	GuildBenefitsFrame.InsetBorderBottomLeft:Hide()
	GuildBenefitsFrame.InsetBorderTopRight:Hide()
	GuildBenefitsFrame.InsetBorderTopLeft:Hide()
	GuildBenefitsFrame.InsetBorderLeft2:Hide()
	GuildBenefitsFrame.InsetBorderBottomLeft2:Hide()
	GuildBenefitsFrame.InsetBorderTopLeft2:Hide()
	GuildBenefitsFrame.Perks:StripTextures()

	for i = 1, 5 do
		local button = _G['CommunitiesFrameContainerButton'..i]
		button:DisableDrawLayer('BACKGROUND')
		button:DisableDrawLayer('BORDER')
		button:CreateBackdrop('Default')

		button.Icon:SetTexCoord(unpack(D['IconCoord']))
	end
	GuildBenefitsFrame.Rewards.Bg:Hide()

	hooksecurefunc('CommunitiesGuildRewards_Update', function(self)
		local scrollFrame = self.RewardsContainer
		local offset = HybridScrollFrame_GetOffset(scrollFrame)
		local buttons = scrollFrame.buttons
		local button, index
		local numButtons = #buttons

		for i = 1, numButtons do
			button = buttons[i]
			index = offset + i
			button:CreateBackdrop('Default')

			button:SetNormalTexture('')
			button:SetHighlightTexture('')

			local hover = button:CreateTexture()
			hover:SetColorTexture(1, 1, 1, 0.3)
			hover:SetInside()
			button.hover = hover
			button:SetHighlightTexture(hover)

			button.Icon:SetTexCoord(unpack(D['IconCoord']))

			button.index = index
		end
	end)

	-- Guild Reputation Bar TO DO: Adjust me!
	local StatusBar = CommunitiesFrame.GuildBenefitsFrame.FactionFrame.Bar
	StatusBar.Middle:Hide()
	StatusBar.Right:Hide()
	StatusBar.Left:Hide()
	StatusBar.BG:Hide()
	StatusBar.Shadow:Hide()
	StatusBar.Progress:SetTexture(C['media']['normTex'])
	StatusBar.Progress:SetAllPoints()

	local bg = CreateFrame('Frame', nil, StatusBar)
	bg:SetPoint('TOPLEFT', 0, -3)
	bg:SetPoint('BOTTOMRIGHT', 0, 1)
	bg:SetFrameLevel(StatusBar:GetFrameLevel())
	bg:CreateBackdrop('Default')

	-- Info tab
	local GuildDetails = _G['CommunitiesFrameGuildDetailsFrame']
	GuildDetails.InsetBorderLeft:Hide()
	GuildDetails.InsetBorderRight:Hide()
	GuildDetails.InsetBorderBottomRight:Hide()
	GuildDetails.InsetBorderBottomLeft:Hide()
	GuildDetails.InsetBorderTopRight:Hide()
	GuildDetails.InsetBorderTopLeft:Hide()
	GuildDetails.InsetBorderLeft2:Hide()
	GuildDetails.InsetBorderBottomLeft2:Hide()
	GuildDetails.InsetBorderTopLeft2:Hide()

	local striptextures = {
		'CommunitiesFrameGuildDetailsFrameInfo',
		'CommunitiesFrameGuildDetailsFrameNews',
		'CommunitiesGuildNewsFiltersFrame',
	}
	for _, frame in pairs(striptextures) do _G[frame]:StripTextures() end

	hooksecurefunc('CommunitiesGuildNewsButton_SetNews', function(button)
		if button.header:IsShown() then button.header:SetAlpha(0) end
	end)

	CommunitiesFrameGuildDetailsFrameInfoScrollBar:SkinScrollBar()
	CommunitiesFrame.GuildLogButton:SkinButton()

	-- Filters Frame
	local FiltersFrame = _G['CommunitiesGuildNewsFiltersFrame']
	FiltersFrame:CreateBackdrop('Transparent')
	FiltersFrame.GuildAchievement:SkinCheckBox()
	FiltersFrame.Achievement:SkinCheckBox()
	FiltersFrame.DungeonEncounter:SkinCheckBox()
	FiltersFrame.EpicItemLooted:SkinCheckBox()
	FiltersFrame.EpicItemCrafted:SkinCheckBox()
	FiltersFrame.EpicItemPurchased:SkinCheckBox()
	FiltersFrame.LegendaryItemLooted:SkinCheckBox()
	FiltersFrame.CloseButton:SkinCloseButton()

	-- Guild Message EditBox
	CommunitiesGuildTextEditFrame:StripTextures()
	CommunitiesGuildTextEditFrame:SetTemplate('Transparent')
	CommunitiesGuildTextEditFrame.Container:SetTemplate('Transparent')
	CommunitiesGuildTextEditFrameAcceptButton:SkinButton()
	CommunitiesGuildTextEditFrameCloseButton:SkinButton() -- Same Name as the other Close Button, WTF?!
	CommunitiesGuildTextEditFrameCloseButton:SkinCloseButton()

	-- Guild Log
	CommunitiesGuildLogFrame:StripTextures()
	CommunitiesGuildLogFrame.Container:StripTextures()
	CommunitiesGuildLogFrame:CreateBackdrop('Transparent')
	CommunitiesGuildLogFrameScrollBar:SkinScrollBar()
	CommunitiesGuildLogFrameCloseButton:SkinCloseButton()

	-- Recruitment Info
	CommunitiesGuildRecruitmentFrame:StripTextures()
	CommunitiesGuildRecruitmentFrame:CreateBackdrop('Transparent')
	CommunitiesGuildRecruitmentFrameInset:StripTextures(false)

	-- CheckBoxes
	CommunitiesGuildRecruitmentFrameRecruitment.InterestFrame.QuestButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.InterestFrame.DungeonButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.InterestFrame.RaidButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.InterestFrame.PvPButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.InterestFrame.RPButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.AvailabilityFrame.WeekdaysButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.AvailabilityFrame.WeekendsButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.RolesFrame.TankButton.checkButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.RolesFrame.HealerButton.checkButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameRecruitment.RolesFrame.DamagerButton.checkButton:SkinCheckBox()
	CommunitiesGuildRecruitmentFrameCloseButton:SkinCloseButton()
	CommunitiesGuildRecruitmentFrameRecruitment.ListGuildButton.LeftSeparator:Hide()
	CommunitiesGuildRecruitmentFrameRecruitment.ListGuildButton:SkinButton()

	-- Tabs
	for i = 1, 2 do _G['CommunitiesGuildRecruitmentFrameTab'..i]:SkinTab() end

	CommunitiesGuildRecruitmentFrameRecruitment.CommentFrame.CommentInputFrame:StripTextures()
	CommunitiesGuildRecruitmentFrameRecruitment.CommentFrame.CommentInputFrame:SkinEditBox()

	-- Recruitment Request
	CommunitiesGuildRecruitmentFrameApplicants.InviteButton.RightSeparator:Hide()
	CommunitiesGuildRecruitmentFrameApplicants.DeclineButton.LeftSeparator:Hide()
	CommunitiesGuildRecruitmentFrameApplicants.InviteButton:SkinButton()
	CommunitiesGuildRecruitmentFrameApplicants.MessageButton:SkinButton()
	CommunitiesGuildRecruitmentFrameApplicants.DeclineButton:SkinButton()

	for i = 1, 5 do
		local bu = _G['CommunitiesGuildRecruitmentFrameApplicantsContainerButton'..i]
		bu:SetBackdrop(nil)
	end

	-- Notification Settings Dialog
	local NotificationSettings = _G['CommunitiesFrame'].NotificationSettingsDialog
	NotificationSettings:StripTextures()
	NotificationSettings:CreateBackdrop('Transparent')
	NotificationSettings.backdrop:SetAllPoints()
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.QuickJoinButton:SkinCheckBox()
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.AllButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.Child.NoneButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.OkayButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.CancelButton:SkinButton()
	CommunitiesFrame.NotificationSettingsDialog.ScrollFrame.ScrollBar:SkinScrollBar() -- Adjust me

	-- Create Channel Dialog
	local EditStreamDialog = CommunitiesFrame.EditStreamDialog
	EditStreamDialog:StripTextures()
	EditStreamDialog:CreateBackdrop('Transparent')
	EditStreamDialog.backdrop:SetAllPoints()
	EditStreamDialog.NameEdit:SkinEditBox()
	EditStreamDialog.NameEdit:SetSize(280, 20)
	EditStreamDialog.Description:SkinEditBox()
	EditStreamDialog.TypeCheckBox:SkinCheckBox()
	EditStreamDialog.Accept:SkinButton()
	EditStreamDialog.Cancel:SkinButton()

	-- Communities Settings
	local Settings = _G['CommunitiesSettingsDialog']
	Settings:StripTextures()
	Settings:CreateBackdrop('Transparent')
	Settings.backdrop:SetAllPoints()
	Settings.IconPreview:SetTexCoord(unpack(D['IconCoord']))
	Settings.IconPreviewRing:Hide()
	Settings.NameEdit:SkinEditBox()
	Settings.ShortNameEdit:SkinEditBox()
	Settings.Description:SkinEditBox()
	Settings.MessageOfTheDay:SkinEditBox()
	Settings.ChangeAvatarButton:SkinButton()
	Settings.Accept:SkinButton()
	Settings.Delete:SkinButton()
	Settings.Cancel:SkinButton()

	-- Avatar Picker
	local Avatar = _G['CommunitiesAvatarPickerDialog']
	Avatar:StripTextures()
	Avatar:CreateBackdrop('Transparent')
	Avatar.backdrop:SetAllPoints()
	Avatar.ScrollFrame:StripTextures()
	CommunitiesAvatarPickerDialogScrollBar:SkinScrollBar()
	Avatar.OkayButton:SkinButton()
	Avatar.CancelButton:SkinButton()

	-- Invite Frame (Ticket Manager - Blizz WTF?!)
	local TicketManager = _G['CommunitiesTicketManagerDialog']
	TicketManager:StripTextures()
	TicketManager.InviteManager.ArtOverlay:Hide()
	TicketManager.InviteManager.ColumnDisplay:StripTextures()
	TicketManager.InviteManager.ColumnDisplay.InsetBorderLeft:Hide()
	TicketManager.InviteManager.ColumnDisplay.InsetBorderBottomLeft:Hide()
	-- TO DO: Fix the Tabs
	TicketManager.InviteManager.ListScrollFrame:StripTextures()

	TicketManager:CreateBackdrop('Transparent')
	TicketManager.backdrop:SetAllPoints()
	TicketManager.LinkToChat:SkinButton()
	TicketManager.Copy:SkinButton()
	TicketManager.Close:SkinButton()
	TicketManager.GenerateLinkButton:SkinButton()
	TicketManager.MaximizeButton:SkinButton()
end

D['SkinFuncs']['Blizzard_Communities'] = CommunitySkin
