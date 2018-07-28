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
	HonorFrame.BonusFrame.RandomBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:SkinButton()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetColorTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.Arena1Button:StripTextures()
	HonorFrame.BonusFrame.Arena1Button:SkinButton()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:SetColorTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.RandomEpicBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomEpicBGButton:SkinButton()
	HonorFrame.BonusFrame.RandomEpicBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomEpicBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomEpicBGButton.SelectedTexture:SetColorTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.BrawlButton:StripTextures()
	HonorFrame.BonusFrame.BrawlButton:SkinButton()
	HonorFrame.BonusFrame.BrawlButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.BrawlButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.BrawlButton.SelectedTexture:SetColorTexture(0, 1, 0, .1)

	HonorFrame.DPSIcon.checkButton:SkinCheckBox()
	HonorFrame.DPSIcon.checkButton:SetFrameLevel(HonorFrame.DPSIcon:GetFrameLevel() + 2)
	HonorFrame.TankIcon.checkButton:SkinCheckBox()
	HonorFrame.TankIcon.checkButton:SetFrameLevel(HonorFrame.TankIcon:GetFrameLevel() + 2)
	HonorFrame.HealerIcon.checkButton:SkinCheckBox()
	HonorFrame.HealerIcon.checkButton:SetFrameLevel(HonorFrame.HealerIcon:GetFrameLevel() + 2)

	PVPQueueFrame.HonorInset:StripTextures()

	-- Conquest Frame
	ConquestFrame.Inset:StripTextures()
	ConquestFrame:StripTextures()
	ConquestFrame:SetFrameLevel(5)
	ConquestFrame:SetFrameStrata('HIGH')
	ConquestFrame.ShadowOverlay:StripTextures()

	ConquestFrame.DPSIcon.checkButton:SkinCheckBox()
	ConquestFrame.DPSIcon.checkButton:SetFrameLevel(ConquestFrame.DPSIcon:GetFrameLevel() + 2)
	ConquestFrame.TankIcon.checkButton:SkinCheckBox()
	ConquestFrame.TankIcon.checkButton:SetFrameLevel(ConquestFrame.TankIcon:GetFrameLevel() + 2)
	ConquestFrame.HealerIcon.checkButton:SkinCheckBox()
	ConquestFrame.HealerIcon.checkButton:SetFrameLevel(ConquestFrame.HealerIcon:GetFrameLevel() + 2)

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
	PVPReadyDialog.SetBackdrop = D.Dummy
	PVPReadyDialog.filigree:SetAlpha(0)
	PVPReadyDialog.bottomArt:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	PVPReadyDialogCloseButton:SkinCloseButton()
	PVPReadyDialogCloseButton.t:SetText('_')
end

D['SkinFuncs']['Blizzard_PVPUI'] = LoadSkin