local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Transparent")
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)