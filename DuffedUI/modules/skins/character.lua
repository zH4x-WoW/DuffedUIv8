local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded('AddOnSkins') then return end

local function IsMaxLevel()
	if UnitLevel('player') == MAX_PLAYER_LEVEL then return true end
end

local function LoadSkin()
	if IsMaxLevel then
		ToggleCharacter('TokenFrame')
		ToggleCharacter('TokenFrame')
	end
	CharacterFrameCloseButton:SkinCloseButton()
	ReputationListScrollFrameScrollBar:SkinScrollBar()
	TokenFrameContainerScrollBar:SkinScrollBar()
	GearManagerDialogPopupScrollFrameScrollBar:SkinScrollBar()

	local slots = {
		'HeadSlot',
		'NeckSlot',
		'ShoulderSlot',
		'BackSlot',
		'ChestSlot',
		'ShirtSlot',
		'TabardSlot',
		'WristSlot',
		'HandsSlot',
		'WaistSlot',
		'LegsSlot',
		'FeetSlot',
		'Finger0Slot',
		'Finger1Slot',
		'Trinket0Slot',
		'Trinket1Slot',
		'MainHandSlot',
		'SecondaryHandSlot',
	}
	for _, slot in pairs(slots) do
		local icon = _G['Character' .. slot .. 'IconTexture']
		slot = _G['Character' .. slot]
		slot:StripTextures()
		slot:StyleButton(false)
		slot.ignoreTexture:SetTexture([[Interface\PaperDollInfoFrame\UI-GearManager-LeaveItem-Transparent]])
		slot:SetTemplate('Default', true)
		icon:SetTexCoord(unpack(D.IconCoord))
		icon:SetInside()

		hooksecurefunc(slot.IconBorder, 'SetVertexColor', function(self, r, g, b) self:GetParent():SetBackdropBorderColor(r, g, b) end)
		hooksecurefunc(slot.IconBorder, 'Hide', function(self) self:GetParent():SetBackdropBorderColor(unpack(C['media']['bordercolor'])) end)
	end

	-- Strip Textures
	local charframe = {
		'CharacterFrame',
		'CharacterModelFrame',
		'CharacterFrameInset',
		'CharacterStatsPane',
		'CharacterFrameInsetRight',
		'PaperDollSidebarTabs',
	}

	ReputationDetailCloseButton:SkinCloseButton()
	TokenFramePopupCloseButton:SkinCloseButton()

	ReputationDetailAtWarCheckBox:SkinCheckBox()
	ReputationDetailMainScreenCheckBox:SkinCheckBox()
	ReputationDetailInactiveCheckBox:SkinCheckBox()
	ReputationDetailLFGBonusReputationCheckBox:SkinCheckBox()
	TokenFramePopupInactiveCheckBox:SkinCheckBox()
	TokenFramePopupBackpackCheckBox:SkinCheckBox()

	EquipmentFlyoutFrameHighlight:Kill()
	local function SkinItemFlyouts()
		EquipmentFlyoutFrameButtons:StripTextures()

		local i = 1
		local button = _G['EquipmentFlyoutFrameButton' .. i]

		while button do
			local icon = _G['EquipmentFlyoutFrameButton' .. i .. 'IconTexture']
			button:StyleButton(false)

			icon:SetTexCoord(unpack(D.IconCoord))
			button:GetNormalTexture():SetTexture(nil)

			icon:SetInside()
			button:SetFrameLevel(button:GetFrameLevel() + 2)
			if not button.backdrop then
				button:CreateBackdrop('Default')
				button.backdrop:SetAllPoints()
			end
			i = i + 1
			button = _G['EquipmentFlyoutFrameButton' .. i]
		end
	end

	-- Swap item flyout frame
	EquipmentFlyoutFrame:HookScript('OnShow', SkinItemFlyouts)
	hooksecurefunc('EquipmentFlyout_Show', SkinItemFlyouts)

	-- Icon in upper right corner of character frame
	CharacterFramePortrait:Kill()

	local scrollbars = {
		'PaperDollTitlesPaneScrollBar',
		'PaperDollEquipmentManagerPaneScrollBar',
		'ReputationListScrollFrameScrollBar',
	}

	for _, scrollbar in pairs(scrollbars) do _G[scrollbar]:SkinScrollBar(5) end
	for _, object in pairs(charframe) do _G[object]:StripTextures() end
	CharacterStatsPane.ItemLevelCategory:StripTextures()
	CharacterStatsPane.ItemLevelCategory:SetTemplate('Transparent')
	CharacterStatsPane.ItemLevelCategory:SetHeight(CharacterStatsPane.ItemLevelCategory:GetHeight() - 20)
	CharacterStatsPane.AttributesCategory:StripTextures()
	CharacterStatsPane.AttributesCategory:SetTemplate('Transparent')
	CharacterStatsPane.AttributesCategory:SetHeight(CharacterStatsPane.AttributesCategory:GetHeight() - 20)
	CharacterStatsPane.AttributesCategory.Title:ClearAllPoints()
	CharacterStatsPane.AttributesCategory.Title:SetPoint('CENTER', 0, -1)
	CharacterStatsPane.EnhancementsCategory:StripTextures()
	CharacterStatsPane.EnhancementsCategory:SetTemplate('Transparent')
	CharacterStatsPane.EnhancementsCategory:SetHeight(CharacterStatsPane.EnhancementsCategory:GetHeight() - 20)
	CharacterStatsPane.EnhancementsCategory.Title:ClearAllPoints()
	CharacterStatsPane.EnhancementsCategory.Title:SetPoint('CENTER', 0, -1)

	CharacterFrame:SetTemplate('Transparent')

	-- Titles
	PaperDollTitlesPane:HookScript('OnShow', function(self)
		for x, object in pairs(PaperDollTitlesPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)
			object.Check:SetTexture(nil)
			object.text:SetFont(C['media'].font, 11)
			object.text.SetFont = D.Dummy
		end
	end)

	-- Equipement Manager
	PaperDollEquipmentManagerPaneEquipSet:SkinButton()
	PaperDollEquipmentManagerPaneSaveSet:SkinButton()
	PaperDollEquipmentManagerPaneEquipSet:Width(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneSaveSet:Width(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneEquipSet:Point('TOPLEFT', PaperDollEquipmentManagerPane, 'TOPLEFT', 8, 0)
	PaperDollEquipmentManagerPaneSaveSet:Point('LEFT', PaperDollEquipmentManagerPaneEquipSet, 'RIGHT', 4, 0)
	PaperDollEquipmentManagerPaneEquipSet.ButtonBackground:SetTexture(nil)
	PaperDollEquipmentManagerPane:HookScript('OnShow', function(self)
		for x, object in pairs(PaperDollEquipmentManagerPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)
			object.icon:Size(36, 36)
			object.icon:SetTexCoord(unpack(D.IconCoord))

			-- Making all icons the same size and position because otherwise BlizzardUI tries to attach itself to itself when it refreshes
			object.icon:SetPoint('LEFT', object, 'LEFT', 4, 0)
			hooksecurefunc(object.icon, 'SetPoint', function(self, point, attachTo, anchorPoint, xOffset, yOffset, isForced)
				if isForced ~= true then self:SetPoint('LEFT', object, 'LEFT', 4, 0, true) end
			end)

			hooksecurefunc(object.icon, 'SetSize', function(self, width, height)
				if width == 30 or height == 30 then self:Size(36, 36) end
			end)
		end
		GearManagerDialogPopup:StripTextures()
		GearManagerDialogPopup:SetTemplate('Transparent')
		GearManagerDialogPopup:Point('LEFT', PaperDollFrame, 'RIGHT', 4, 0)
		GearManagerDialogPopupEditBox:StripTextures()
		GearManagerDialogPopupEditBox:SetTemplate('Default')
		GearManagerDialogPopup.BorderBox:StripTextures()
		GearManagerDialogPopupOkay:SkinButton()
		GearManagerDialogPopupCancel:SkinButton()

		for i = 1, NUM_GEARSET_ICONS_SHOWN do
			local button = _G['GearManagerDialogPopupButton' .. i]
			local icon = button.icon

			if button then
				button:StripTextures()
				button:StyleButton(true)
				icon:SetTexCoord(unpack(D.IconCoord))
				_G['GearManagerDialogPopupButton' .. i .. 'Icon']:SetTexture(nil)
				icon:SetInside()
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				if not button.backdrop then
					button:CreateBackdrop('Default')
					button.backdrop:SetAllPoints()
				end
			end
		end
	end)

	-- Handle Tabs at bottom of character frame
	for i = 1, 3 do _G['CharacterFrameTab' .. i]:SkinTab()	end

	-- Buttons used to toggle between equipment manager, titles, and character stats
	local function FixSidebarTabCoords()
		for i = 1, #PAPERDOLL_SIDEBARS do
			local tab = _G['PaperDollSidebarTab' .. i]
			if tab and not tab.backdrop then
				tab.Highlight:SetColorTexture(1, 1, 1, 0.3)
				tab.Highlight:Point('TOPLEFT', 3, -4)
				tab.Highlight:Point('BOTTOMRIGHT', -1, 0)
				tab.Hider:SetColorTexture(.4, .4, .4, .4)
				tab.Hider:Point('TOPLEFT', 3, -4)
				tab.Hider:Point('BOTTOMRIGHT', -1, 0)
				tab.TabBg:Kill()

				if i == 1 then
					for i=1, tab:GetNumRegions() do
						local region = select(i, tab:GetRegions())
						region:SetTexCoord(.16, .86, .16, .86)
						hooksecurefunc(region, 'SetTexCoord', function(self, x1, y1, x2, y2)
							if x1 ~= .16001 then self:SetTexCoord(.16001, .86, .16, .86) end
						end)
					end
				end
				tab:CreateBackdrop('Default')
				tab.backdrop:Point('TOPLEFT', 1, -2)
				tab.backdrop:Point('BOTTOMRIGHT', 1, -2)
			end
		end
	end
	hooksecurefunc('PaperDollFrame_UpdateSidebarTabs', FixSidebarTabCoords)

	-- Reputation
	local function UpdateFactionSkins()
		ReputationFrame:StripTextures(true)
		for i = 1, GetNumFactions() do
			local statusbar = _G['ReputationBar' .. i .. 'ReputationBar']

			if statusbar then
				statusbar:SetStatusBarTexture(C['media'].normTex)
				if not statusbar.backdrop then statusbar:CreateBackdrop('Default') end

				_G['ReputationBar' .. i .. 'Background']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarHighlight1']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarHighlight2']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarAtWarHighlight1']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarAtWarHighlight2']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarLeftTexture']:SetTexture(nil)
				_G['ReputationBar' .. i .. 'ReputationBarRightTexture']:SetTexture(nil)

			end
		end
		ReputationDetailFrame:StripTextures()
		ReputationDetailFrame:SetTemplate('Transparent')
		ReputationDetailFrame:Point('TOPLEFT', ReputationFrame, 'TOPRIGHT', 4, -28)
	end
	ReputationFrame:HookScript('OnShow', UpdateFactionSkins)
	hooksecurefunc('ExpandFactionHeader', UpdateFactionSkins)
	hooksecurefunc('CollapseFactionHeader', UpdateFactionSkins)

	local tooltip = EmbeddedItemTooltip
	local reward = tooltip.ItemTooltip
	local icon = reward.Icon
	tooltip:SetTemplate('Transparent')
	if icon then
		icon:SkinIcon()
		hooksecurefunc(reward.IconBorder, 'SetVertexColor', function(self, r, g, b)
			self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
			self:SetTexture('')
		end)
		hooksecurefunc(reward.IconBorder, 'Hide', function(self)
			self:GetParent().backdrop:SetBackdropBorderColor(unpack(C['media']['bordercolor']))
		end)
	end
	tooltip:HookScript('OnShow', function(self)
		self:SetTemplate('Transparent')
	end)

	-- Currency
	local function UpdateCurrencySkins()
		if TokenFramePopup then
			if not TokenFramePopup.template then
				TokenFramePopup:StripTextures();
				TokenFramePopup:SetTemplate('Transparent');
			end
			TokenFramePopup:Point('TOPLEFT', TokenFrame, 'TOPRIGHT', 4, -28);
		end

		if not TokenFrameContainer.buttons then return end
		local buttons = TokenFrameContainer.buttons;
		local numButtons = #buttons;

		for i = 1, numButtons do
			local button = buttons[i];

			if button then
				if button.highlight then button.highlight:Kill() end
				if button.categoryLeft then button.categoryLeft:Kill() end
				if button.categoryRight then button.categoryRight:Kill() end
				if button.categoryMiddle then button.categoryMiddle:Kill() end

				if button.icon then
					button.icon:SetTexCoord(unpack(D['IconCoord']));
				end

				if button.expandIcon then
					if not button.highlightTexture then
						button.highlightTexture = button:CreateTexture(button:GetName()..'HighlightTexture', 'HIGHLIGHT');
						button.highlightTexture:SetTexture('Interface\\Buttons\\UI-PlusButton-Hilight');
						button.highlightTexture:SetBlendMode('ADD');
						button.highlightTexture:SetInside(button.expandIcon);

						-- these two only need to be called once
						-- adding them here will prevent additional calls
						button.expandIcon:Point('LEFT', 4, 0);
						button.expandIcon:SetSize(15, 15);
					end
					if button.isHeader then
						if button.isExpanded then
							button.expandIcon:SetTexture('Interface\\AddOns\\DuffedUI\\media\\textures\\MinusButton');
							button.expandIcon:SetTexCoord(0,1,0,1);
						else
							button.expandIcon:SetTexture('Interface\\AddOns\\DuffedUI\\media\\textures\\PlusButton');
							button.expandIcon:SetTexCoord(0,1,0,1);
						end
						button.highlightTexture:Show()
					else
						button.highlightTexture:Hide()
					end
				end
			end
		end
	end
	hooksecurefunc('TokenFrame_Update', UpdateCurrencySkins)
	hooksecurefunc(TokenFrameContainer, 'update', UpdateCurrencySkins)
end

tinsert(D.SkinFuncs['DuffedUI'], LoadSkin)