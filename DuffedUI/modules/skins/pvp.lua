local D, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	PVPUIFrame:StripTextures()
	PVPUIFrame:SetTemplate("Transparent")
	PVPUIFrame.LeftInset:StripTextures()
	PVPUIFrame.Shadows:StripTextures()
	PVPUIFrameCloseButton:SkinCloseButton()

	for i = 1, 3 do
		local button = _G["PVPQueueFrameCategoryButton"..i]
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

		button:CreateShadow("Default")

		if i == 1 then button.shadow:SetAlpha(1) else button.shadow:SetAlpha(0) end

		button:HookScript("OnClick", function(self)
			for j=1, 3 do
				local b = _G["PVPQueueFrameCategoryButton"..j]
				if self:GetID() == b:GetID() then
					b.shadow:SetAlpha(1)
				else
					b.shadow:SetAlpha(0)
				end
			end
		end)
	end

	-- HONOR FRAME
	HonorFrameTypeDropDown:SkinDropDownBox()
	HonorFrame.Inset:StripTextures()
	HonorFrameSpecificFrameScrollBar:SkinScrollBar()
	HonorFrameSoloQueueButton:SkinButton(true)
	HonorFrameGroupQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:SkinButton()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	HonorFrame.BonusFrame.CallToArmsButton:StripTextures()
	HonorFrame.BonusFrame.CallToArmsButton:SkinButton()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	
	HonorFrame.RoleInset:StripTextures()
	HonorFrame.RoleInset.DPSIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.DPSIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.DPSIcon:GetFrameLevel() + 2)
	HonorFrame.RoleInset.TankIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.TankIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.TankIcon:GetFrameLevel() + 2)
	HonorFrame.RoleInset.HealerIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.HealerIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.HealerIcon:GetFrameLevel() + 2)

	for i = 1, 2 do
		local b = HonorFrame.BonusFrame["WorldPVP"..i.."Button"]
		b:StripTextures()
		b:SkinButton()
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetAllPoints()
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end
	
	-- CONQUEST FRAME
	ConquestFrame.Inset:StripTextures()
	ConquestPointsBarLeft:Kill()
	ConquestPointsBarRight:Kill()
	ConquestPointsBarMiddle:Kill()
	ConquestPointsBarBG:Kill()
	ConquestPointsBarShadow:Kill()
	ConquestPointsBar.progress:SetTexture(C["media"].normTex)
	ConquestPointsBar:CreateBackdrop("Default")
	ConquestPointsBar.backdrop:SetOutside(ConquestPointsBar, nil, -D.mult)
	ConquestFrame:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()
	ConquestFrame.RatedBG:StripTextures()
	ConquestFrame.RatedBG:SkinButton()
	ConquestFrame.RatedBG.SelectedTexture:ClearAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestJoinButton:SkinButton(true)
	
	-- PvP Ready Dialog
	PVPReadyDialog:StripTextures()
	PVPReadyDialog:SetTemplate("Transparent")
	PVPReadyDialog.SetBackdrop = D.dummy
	PVPReadyDialog.filigree:SetAlpha(0)
	PVPReadyDialog.bottomArt:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	PVPReadyDialogCloseButton:SkinCloseButton()
	PVPReadyDialogCloseButton.t:SetText("_")

	-- WARGRAMES FRAME
	WarGamesFrame:StripTextures()
	WarGamesFrame.RightInset:StripTextures()
	WarGameStartButton:SkinButton(true)
	WarGamesFrameScrollFrameScrollBar:SkinScrollBar()
	WarGamesFrame.HorizontalBar:StripTextures()
	
	WarGameStartButton:StripTextures()
	WarGameStartButton:SkinButton()
end

D.SkinFuncs["Blizzard_PVPUI"] = LoadSkin