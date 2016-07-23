local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadAddon_ManagerSkin()
	local Frames = {
		AddonList,
		AddonListInset,
	}

	local Buttons = {
		AddonListEnableAllButton,
		AddonListDisableAllButton,
		AddonListCancelButton,
		AddonListOkayButton,
	}

	for _, Frames in pairs(Frames) do Frames:StripTextures() end

	for _, Buttons in pairs(Buttons) do Buttons:StripTextures() end

	AddonList:SetTemplate("Transparent")
	AddonListInset:SetTemplate()

	for _, Buttons in pairs(Buttons) do Buttons:SkinButton() end

	AddonListForceLoad:SkinCheckBox()
	AddonCharacterDropDown:SkinDropDownBox()
	AddonListEnableAllButton:SetHeight(AddonListEnableAllButton:GetHeight() - 3)
	AddonListDisableAllButton:SetHeight(AddonListDisableAllButton:GetHeight() - 3)
	AddonListCancelButton:SetHeight(AddonListCancelButton:GetHeight() - 3)
	AddonListOkayButton:SetHeight(AddonListOkayButton:GetHeight() - 3)

	for i = 1, MAX_ADDONS_DISPLAYED do _G["AddonListEntry" .. i .. "Enabled"]:SkinCheckBox() end

	AddonListScrollFrameScrollBar:SkinScrollBar()
	AddonListCloseButton:SkinCloseButton()
end

tinsert(D.SkinFuncs["DuffedUI"], LoadAddon_ManagerSkin)