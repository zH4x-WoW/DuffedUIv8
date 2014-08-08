local D, C, L, G = select(2, ...):unpack()

local function LoadSkin()
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Transparent")
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)