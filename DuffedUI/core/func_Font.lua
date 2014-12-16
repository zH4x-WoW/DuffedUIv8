local D, C, L = unpack(select(2, ...))

if D.Client == "ruRU" then
	C["media"].font = C["media"].ru_font
	C["media"].dmgfont = C["media"].ru_dmgfont
elseif D.Client == "zhTW" then
	C["media"].font = C["media"].tw_font
	C["media"].dmgfont = C["media"].tw_dmgfont
elseif D.Client == "koKR" then
	C["media"].font = C["media"].kr_font
	C["media"].dmgfont = C["media"].kr_dmgfont
elseif D.Client == "frFR" then
	C["media"].font = C["media"].fr_font
	C["media"].dmgfont = C["media"].fr_dmgfont
elseif D.Client == "zhCN" then
	C["media"].font = C["media"].cn_font
	C["media"].dmgfont = C["media"].cn_dmgfont
end

local duffed = CreateFont("DuffedUI")
duffed:SetFont(C["media"].font, C["font"].duffeduisize, "THINOUTLINE")

local duffed_alt = CreateFont("DuffedUI_Alt")
duffed_alt:SetFont(C["media"].font2, C["font"].duffedui_altsize, "THINOUTLINE")

local pixel = CreateFont("PixelFont")
pixel:SetFont(C["media"].pixelfont, C["font"].pixelfontsize, "MONOCHROMEOUTLINE")

local MakeFont = {
	["DuffedUI"] = "DuffedUI",
	["Pixel Font"] = "PixelFont",
	["DuffedUI Alternativ"] = "DuffedUI_Alt",
}

D.Font = function(value)
	if MakeFont[value] then return MakeFont[value] else return MakeFont["DuffedUI"] end
end