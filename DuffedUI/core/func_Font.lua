local D, C, L = unpack(select(2, ...))

if D.Client == "zhTW" then
	C["media"].font = C["media"].tw_font
	C["media"].dmgfont = C["media"].tw_dmgfont
elseif D.Client == "zhCN" then
	C["media"].font = C["media"].cn_font
	C["media"].dmgfont = C["media"].cn_dmgfont
end