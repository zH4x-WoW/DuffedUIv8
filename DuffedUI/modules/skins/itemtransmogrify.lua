local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	TransmogrifyFrame:StripTextures()
	TransmogrifyFrame:SetTemplate("Transparent")
	TransmogrifyModelFrame:SetFrameLevel(TransmogrifyFrame:GetFrameLevel() + 2)

	local KillTextures = {
		"TransmogrifyModelFrameLines",
		"TransmogrifyModelFrameMarbleBg",
		"TransmogrifyFrameButtonFrameButtonBorder",
		"TransmogrifyFrameButtonFrameButtonBottomBorder",
		"TransmogrifyFrameButtonFrameMoneyLeft",
		"TransmogrifyFrameButtonFrameMoneyRight",
		"TransmogrifyFrameButtonFrameMoneyMiddle",
	}

	for _, texture in pairs(KillTextures) do _G[texture]:Kill() end

	select(2, TransmogrifyModelFrame:GetRegions()):Kill()
	TransmogrifyFrameButtonFrame:GetRegions():Kill()

	TransmogrifyApplyButton:SkinButton(true)
	TransmogrifyApplyButton:Point("BOTTOMRIGHT", TransmogrifyFrame, "BOTTOMRIGHT", -4, 4)
	TransmogrifyArtFrameCloseButton:SkinCloseButton()
	TransmogrifyArtFrame:StripTextures()

	local slots = {
		"Head",
		"Shoulder",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Back",
		"MainHand",
		"SecondaryHand"
	}
	for _, slot in pairs(slots) do
		local icon = _G["TransmogrifyFrame" .. slot .. "SlotIconTexture"]
		local slot = _G["TransmogrifyFrame" .. slot .. "Slot"]

		if slot then
			slot:StripTextures()
			slot:StyleButton(false)
			slot:SetFrameLevel(slot:GetFrameLevel() + 2)
			slot:CreateBackdrop("Default")
			slot.backdrop:SetAllPoints()

			icon:SetTexCoord(unpack(D.IconCoord))
			icon:ClearAllPoints()
			icon:SetInside()
		end
	end

	TransmogrifyConfirmationPopup:SetParent(UIParent)
	TransmogrifyConfirmationPopup:StripTextures()
	TransmogrifyConfirmationPopup:SetTemplate("Transparent")
	TransmogrifyConfirmationPopup.Button1:SkinButton()
	TransmogrifyConfirmationPopup.Button2:SkinButton()
	TransmogrifyConfirmationPopupItemFrame1:SkinButton(true)
	TransmogrifyConfirmationPopupItemFrame2:SkinButton(true)

	EquipmentFlyoutFrameHighlight:Kill()
	local function SkinItemFlyouts()
		EquipmentFlyoutFrameButtons:StripTextures()

		local i = 1
		local button = _G["EquipmentFlyoutFrameButton" .. i]

		while button do
			local icon = _G["EquipmentFlyoutFrameButton" .. i .. "IconTexture"]
			button:StyleButton(false)

			icon:SetTexCoord(unpack(D.IconCoord))
			button:GetNormalTexture():SetTexture(nil)

			icon:SetInside()
			button:SetFrameLevel(button:GetFrameLevel() + 2)
			if not button.backdrop then
				button:CreateBackdrop("Default")
				button.backdrop:SetAllPoints()
			end
			i = i + 1
			button = _G["EquipmentFlyoutFrameButton" .. i]
		end
	end

	--[[Swap item flyout frame]]--
	EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
	hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)
end

D.SkinFuncs["Blizzard_ItemAlterationUI"] = LoadSkin