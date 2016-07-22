local D, C, L = unpack(select(2, ...))
--if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	DressUpFrame:StripTextures(true)
	DressUpFrame:CreateBackdrop("Transparent")
	DressUpFrame.backdrop:Point("TOPLEFT", 6, 0)
	DressUpFrame.backdrop:Point("BOTTOMRIGHT", -32, 70)

	DressUpFrameResetButton:SkinButton()
	DressUpFrameCancelButton:SkinButton()
	DressUpFrameCloseButton:SkinCloseButton(DressUpFrame.backdrop)
	DressUpFrameResetButton:Point("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
	
	WardrobeOutfitFrame:StripTextures()
	WardrobeOutfitFrame:CreateBackdrop("Transparent")
	
	DressUpFrameOutfitDropDown:SkinDropDownBox()
	DressUpFrameOutfitDropDown:SetSize(200, 34)
	DressUpFrameOutfitDropDown.SaveButton:ClearAllPoints()
	DressUpFrameOutfitDropDown.SaveButton:SetPoint("RIGHT", DressUpFrameOutfitDropDown, 83, 4)
	DressUpFrameOutfitDropDown.SaveButton:SkinButton()
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)