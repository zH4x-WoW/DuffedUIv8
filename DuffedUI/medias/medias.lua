local D, C = unpack(select(2, ...))

C["medias"] = {
	-- fonts (ENGLISH)
	["Font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["AltFont"] = [[Interface\AddOns\DuffedUI\medias\fonts\uf_font.ttf]],
	["DamageFont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_font.ttf]],
	["PixelFont"] = [=[Interface\Addons\DuffedUI\medias\fonts\pixel_font.ttf]=],
	["ActionBarFont"] = [=[Interface\Addons\DuffedUI\medias\fonts\actionbar_font.ttf]=],

	-- textures
	["Normal"] = [[Interface\AddOns\DuffedUI\medias\textures\normTex]],
	["Glow"] = [[Interface\AddOns\DuffedUI\medias\textures\glowTex]],
	["Bubble"] = [[Interface\AddOns\DuffedUI\medias\textures\bubbleTex]],
	["Copy"] = [[Interface\AddOns\DuffedUI\medias\textures\copy]],
	["Blank"] = [[Interface\AddOns\DuffedUI\medias\textures\blank]],
	["HoverButton"] = [[Interface\AddOns\DuffedUI\medias\textures\button_hover]],
	["Logo"] = [[Interface\AddOns\DuffedUI\medias\textures\logo]],
	["Duffed"] =  [[Interface\AddOns\DuffedUI\medias\textures\duffed]],
	
	-- colors
	["BorderColor"] = (not C["general"].InOut and { 0, 0, 0 }) or C["general"].BorderColor or { .5, .5, .5 },
	["BackdropColor"] = C["general"].BackdropColor or { .1,.1,.1 },
	["PrimaryDataTextColor"] = { 1, 1, 1 },
	["SecondaryDataTextColor"] = { 1, 1, 1 },
	
	-- sound
	["Whisper"] = [[Interface\AddOns\DuffedUI\medias\sounds\whisper.mp3]],
	["Warning"] = [[Interface\AddOns\DuffedUI\medias\sounds\warning.mp3]],
}