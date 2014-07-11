local D, C = select(2, ...):unpack()

local DuffedUIFont = CreateFont("DuffedUIFont")
DuffedUIFont:SetFont(C["medias"].Font, 12)
DuffedUIFont:SetShadowColor(0, 0, 0)
DuffedUIFont:SetShadowOffset(1.25, -1.25)

local DuffedUIFontOutline = CreateFont("DuffedUIFontOutline")
DuffedUIFontOutline:SetFont(C["medias"].Font, 12, "THINOUTLINE")

local DuffedUIUFFont = CreateFont("DuffedUIUFFont")
DuffedUIUFFont:SetFont(C["medias"].AltFont, 12)
DuffedUIUFFont:SetShadowColor(0, 0, 0)
DuffedUIUFFont:SetShadowOffset(1.25, -1.25)

local PixelFont = CreateFont("DuffedUIPixelFont")
PixelFont:SetFont(C["medias"].PixelFont, 12, "MONOCHROMEOUTLINE")

D.GetFont = function(s)
	if (s == "DuffedUI") then
		return DuffedUIFont
	elseif (s == "DuffedUI2") then
		return DuffedUIFontOutline
	elseif (s == "DuffedUI3") then
		return DuffedUIUFFont
	else
		return PixelFont
	end
end