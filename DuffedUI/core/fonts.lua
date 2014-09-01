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