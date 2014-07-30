local D, C = select(2, ...):unpack()

local DuffedUIMedia = CreateFrame("Frame")

-- Create our own fonts
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

local DuffedUIFont = CreateFont("DuffedUIFontNP")
DuffedUIFont:SetFont(C["medias"].Font, 11, "THINOUTLINE")
DuffedUIFont:SetShadowColor(0, 0, 0)
DuffedUIFont:SetShadowOffset(1.25, -1.25)

local DuffedUIFont = CreateFont("DuffedUIFontNPDebuffs")
DuffedUIFont:SetFont(C["medias"].Font, 9, "THINOUTLINE")
DuffedUIFont:SetTextColor(.85, .89, .25)
DuffedUIFont:SetShadowColor(0, 0, 0)
DuffedUIFont:SetShadowOffset(1.25, -1.25)

local TextureTable = {
	["Blank"] = "Interface\\BUTTONS\\WHITE8X8.tga",
	["Raid"] = "Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill.tga",
	["Highlight"] = "Interface\\BUTTONS\\UI-Listbox-Highlight2.tga",
	--["DuffedUI"] = C["medias"].Normal,
}

local FontTable = {
	["DuffedUI"] = "DuffedUIFont",
	["DuffedUI Outline"] = "DuffedUIFontOutline",
	["DuffedUI UF"] = "DuffedUIUFFont",
	["Pixel"] = "DuffedUIPixelFont",
	["Highlight"] = "GameFontHighlight",
	["Combat Log"] = "CombatLogFont",
	["Game Font"] = "GameFontWhite",
	["DuffedUI Nameplates"] = "DuffedUIFontNP",
	["DuffedUI NP Debuff"] = "DuffedUIFontNPDebuffs",
}

D.GetFont = function(font)
	if FontTable[font] then
		return FontTable[font]
	else
		return FontTable["DuffedUI"]
	end
end

D.GetTexture = function(texture)
	if TextureTable[texture] then
		return TextureTable[texture]
	else
		return TextureTable["Blank"] -- Return something to prevent errors
	end
end

function DuffedUIMedia:RegisterTexture(name, path)
	if (not TextureTable[name]) then
		TextureTable[name] = path
	end
end

function DuffedUIMedia:RegisterFont(name, path)
	if (not FontTable[name]) then
		FontTable[name] = path
	end
end

D["Media"] = DuffedUIMedia
D.FontTable = FontTable
D.TextureTable = TextureTable