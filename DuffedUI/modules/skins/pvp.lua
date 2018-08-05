local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded('AddOnSkins') then return end

local function LoadSkin()
	PVPUIFrame:StripTextures()

	-- Category Buttons
	for i = 1, 3 do
		local button = _G['PVPQueueFrameCategoryButton' .. i]
		button:SetTemplate()
		button.Background:Kill()
		button.Ring:Kill()
		button.Icon:Size(45)
		button.Icon:SetTexCoord(.15, .85, .15, .85)
		button:CreateBackdrop()
		button.backdrop:SetOutside(button.Icon)
		button.backdrop:SetFrameLevel(button:GetFrameLevel())
		button.Icon:SetParent(button.backdrop)
		button:StyleButton()
	end

	-- Honor Frame
	HonorFrameTypeDropDown:SkinDropDownBox()
	HonorFrameTypeDropDown:ClearAllPoints()
	HonorFrameTypeDropDown:SetPoint('BOTTOMRIGHT', HonorFrame.BonusFrame.RandomBGButton, 'TOPRIGHT', 9, 19)
	HonorFrame.Inset:StripTextures()
	HonorFrameSpecificFrameScrollBar:SkinScrollBar()
	HonorFrameQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame:SetFrameLevel(5)
	HonorFrame.BonusFrame:SetFrameStrata('HIGH')
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()

	for _, Section in pairs({ 'RandomBGButton', 'RandomEpicBGButton', 'Arena1Button', 'BrawlButton' }) do
		local Button = HonorFrame.BonusFrame[Section]
		Button:StripTextures()
		Button:SkinButton()
		Button:HookScript('OnEnter', function(self)
			self:SetBackdropBorderColor(1, .82, 0)
		end)
		Button:HookScript('OnLeave', function(self)
			if self.SelectedTexture:IsShown() then
				self:SetBackdropBorderColor(0, 0.44, .87, 1)
			else
				self:SetBackdropBorderColor(C['general']['bordercolor'])
			end
		end)
		Button.SelectedTexture:SetTexture('')
	end

	hooksecurefunc('HonorFrame_UpdateQueueButtons', function()
		for _, Section in pairs({ 'RandomBGButton', 'RandomEpicBGButton', 'Arena1Button', 'BrawlButton' }) do
			local Button = HonorFrame.BonusFrame[Section]
			if Button.SelectedTexture:IsShown() then
				Button:SetBackdropBorderColor(0, 0.44, .87, 1)
			else
				Button:SetBackdropBorderColor(C['general']['bordercolor'])
			end
		end
	end)

	HonorFrame.DPSIcon.checkButton:SkinCheckBox()
	HonorFrame.TankIcon.checkButton:SkinCheckBox()
	HonorFrame.HealerIcon.checkButton:SkinCheckBox()

	PVPQueueFrame.HonorInset:StripTextures()

	-- Conquest Frame
	ConquestFrame.Inset:StripTextures()
	ConquestFrame:StripTextures()
	ConquestFrame:SetFrameLevel(5)
	ConquestFrame:SetFrameStrata('HIGH')
	ConquestFrame.ShadowOverlay:StripTextures()

	ConquestFrame.DPSIcon.checkButton:SkinCheckBox()
	ConquestFrame.TankIcon.checkButton:SkinCheckBox()
	ConquestFrame.HealerIcon.checkButton:SkinCheckBox()

	local function SkinRated(button)
		button:StripTextures()
		button:SkinButton()
		button.SelectedTexture:ClearAllPoints()
		button.SelectedTexture:SetAllPoints()
		button.SelectedTexture:SetColorTexture(0, 1, 0, .1)
	end
	SkinRated(ConquestFrame.RatedBG)
	SkinRated(ConquestFrame.Arena2v2)
	SkinRated(ConquestFrame.Arena3v3)
	ConquestJoinButton:SkinButton(true)

	-- PvP Ready Dialog
	PVPReadyDialog:StripTextures()
	PVPReadyDialog:SetTemplate('Transparent')
	PVPReadyDialog.SetBackdrop = D['Dummy']
	PVPReadyDialog.filigree:SetAlpha(0)
	PVPReadyDialog.bottomArt:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	PVPReadyDialogCloseButton:SkinCloseButton()
	PVPReadyDialogCloseButton.t:SetText('_')
end

D['SkinFuncs']['Blizzard_PVPUI'] = LoadSkin