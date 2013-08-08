local D, C = unpack(select(2, ...))

C["Media"] = {
	-- Fonts (ENGLISH)
	["Font"] = [=[Interface\Addons\DuffedUI\Medias\Fonts\normal_font.ttf]=],
	["AltFont"] = [[Interface\AddOns\DuffedUI\Medias\Fonts\uf_font.ttf]],
	["DamageFont"] = [[Interface\AddOns\DuffedUI\Medias\Fonts\combat_font.ttf]],
	["PixelFont"] = [=[Interface\Addons\DuffedUI\Medias\Fonts\pixel_font.ttf]=],
	["ActionBarFont"] = [=[Interface\Addons\DuffedUI\Medias\Fonts\actionbar_font.ttf]=],

	-- Textures
	["Normal"] = [[Interface\AddOns\DuffedUI\Medias\Textures\normTex]],
	["Glow"] = [[Interface\AddOns\DuffedUI\Medias\Textures\glowTex]],
	["Bubble"] = [[Interface\AddOns\DuffedUI\Medias\Textures\bubbleTex]],
	["Copy"] = [[Interface\AddOns\DuffedUI\Medias\Textures\copy]],
	["Blank"] = [[Interface\AddOns\DuffedUI\Medias\Textures\blank]],
	["HoverButton"] = [[Interface\AddOns\DuffedUI\Medias\Textures\button_hover]],
	
	-- colors
	["BorderColor"] = (not C["General"].InOut and { .125, .125, .125 }) or C["General"].BorderColor or { .125, .125, .125 },
	["BackdropColor"] = C["General"].BackdropColor or { .05, .05, .05 },
	["PrimaryDataTextColor"] = { .4, .4, .4 },
	["SecondaryDataTextColor"] = { 1, 1, 1 },
	
	-- sound
	["Whisper"] = [[Interface\AddOns\DuffedUI\Medias\Sounds\whisper.mp3]],
	["Warning"] = [[Interface\AddOns\DuffedUI\Medias\Sounds\warning.mp3]],
}