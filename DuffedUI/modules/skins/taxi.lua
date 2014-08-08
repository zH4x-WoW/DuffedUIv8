local D, C, L, G = select(2, ...):unpack()

local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame.TitleText:SetAlpha(0)
	TaxiRouteMap:CreateBackdrop("Transparent")
	TaxiFrame.CloseButton:SkinCloseButton()
	TaxiFrame.CloseButton:ClearAllPoints()
	TaxiFrame.CloseButton:SetPoint("TOPRIGHT", 0, -20)
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)