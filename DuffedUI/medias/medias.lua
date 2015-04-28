local D, C, L = unpack(select(2, ...))

C["media"] = {
	["font"] = [[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]],
	["font2"] = [[Interface\Addons\DuffedUI\medias\fonts\normal_font2.ttf]],
	["dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat.ttf]],
	["pixelfont"] = [[Interface\Addons\DuffedUI\medias\fonts\pixel_font.ttf]],

	["fr_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["fr_dmgfont"] = [=[Interface\AddOns\DuffedUI\medias\fonts\combat.ttf]=],

	["ru_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["ru_dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_rus.ttf]],

	["tw_font"] = [=[Fonts\bLEI00D.ttf]=],
	["tw_dmgfont"] = [[Fonts\bLEI00D.ttf]],

	["kr_font"] = [=[Fonts\2002.TTF]=],
	["kr_dmgfont"] = [[Fonts\2002.TTF]],

	["cn_font"] = [=[Fonts\ARKai_T.TTF]=],
	["cn_dmgfont"] = [[Fonts\ARKai_C.TTF]],

	["normTex"] = [[Interface\AddOns\DuffedUI\medias\textures\normTex]],
	["glowTex"] = [[Interface\AddOns\DuffedUI\medias\textures\glowTex]],
	["copyicon"] = [[Interface\AddOns\DuffedUI\medias\textures\copy]],
	["blank"] = [[Interface\AddOns\DuffedUI\medias\textures\blank]],
	["duffed"] = [[Interface\AddOns\DuffedUI\medias\textures\duffed]],
	["duffed_logo"] = [[Interface\AddOns\DuffedUI\medias\textures\logo]],
	["alliance"] = [[Interface\AddOns\DuffedUI\medias\textures\alliance]],
	["d3"] = [[Interface\AddOns\DuffedUI\medias\textures\d3]],
	["horde"] = [[Interface\AddOns\DuffedUI\medias\textures\horde]],
	["neutral"] = [[Interface\AddOns\DuffedUI\medias\textures\neutral]],
	["sc2"] = [[Interface\AddOns\DuffedUI\medias\textures\sc2]],
	["RaidIcons"] = [[Interface\AddOns\DuffedUI\medias\textures\raidicons]],

	["bordercolor"] = C["general"].bordercolor or { .125, .125, .125 },
	["backdropcolor"] = C["general"].backdropcolor or { .05, .05, .05 },
	["datatextcolor1"] = { .4, .4, .4 }, -- color of datatext title
	["datatextcolor2"] = { 1, 1, 1 }, -- color of datatext result

	["whisper"] = [[Interface\AddOns\DuffedUI\medias\sounds\whisper.ogg]],
	["warning"] = [[Interface\AddOns\DuffedUI\medias\sounds\warning.ogg]],
}