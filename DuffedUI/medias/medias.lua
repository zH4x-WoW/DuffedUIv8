local D, C, L, G = select(2, ...):unpack()

C["media"] = {
	-- fonts (ENGLISH, SPANISH)
	["font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_font.ttf]],
	["pixelfont"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],

	-- fonts (DEUTSCH)
	["de_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["de_dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_font.ttf]],

	-- fonts (FRENCH)
	["fr_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["fr_dmgfont"] = [=[Interface\AddOns\DuffedUI\medias\fonts\combat_font.ttf]=],

	-- fonts (RUSSIAN)
	["ru_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["ru_dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_font_rus.ttf]],

	-- fonts (TAIWAN ONLY)
	["tw_font"] = [=[Fonts\bLEI00D.ttf]=],
	["tw_dmgfont"] = [[Fonts\bLEI00D.ttf]],

	-- fonts (KOREAN ONLY)
	["kr_font"] = [=[Fonts\2002.TTF]=],
	["kr_dmgfont"] = [[Fonts\2002.TTF]],

	-- fonts (China ONLY)
	["cn_font"] = [=[Fonts\ARKai_T.TTF]=],
	["cn_dmgfont"] = [[Fonts\ARKai_C.TTF]],

	-- textures
	["normTex"] = [[Interface\AddOns\DuffedUI\medias\textures\normTex]],
	["glowTex"] = [[Interface\AddOns\DuffedUI\medias\textures\glowTex]],
	["bubbleTex"] = [[Interface\AddOns\DuffedUI\medias\textures\bubbleTex]],
	["copyicon"] = [[Interface\AddOns\DuffedUI\medias\textures\copy]],
	["blank"] = [[Interface\AddOns\DuffedUI\medias\textures\blank]],
	["buttonhover"] = [[Interface\AddOns\DuffedUI\medias\textures\button_hover]],
	["duffed"] = [[Interface\AddOns\DuffedUI\medias\textures\duffed]],
	["alliance"] = [[Interface\AddOns\DuffedUI\medias\textures\alliance]],
	["d3"] = [[Interface\AddOns\DuffedUI\medias\textures\d3]],
	["horde"] = [[Interface\AddOns\DuffedUI\medias\textures\horde]],
	["neutral"] = [[Interface\AddOns\DuffedUI\medias\textures\neutral]],
	["sc2"] = [[Interface\AddOns\DuffedUI\medias\textures\sc2]],
	["pointer"] = [[Interface\AddOns\DuffedUI\medias\textures\arrow]],
	
	-- colors
	["bordercolor"] = C["general"].bordercolor or { .125, .125, .125 },
	["backdropcolor"] = C["general"].backdropcolor or { .05, .05, .05 },
	["datatextcolor1"] = { .4, .4, .4 }, -- color of datatext title
	["datatextcolor2"] = { 1, 1, 1 }, -- color of datatext result
	
	-- sound
	["whisper"] = [[Interface\AddOns\DuffedUI\medias\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\DuffedUI\medias\sounds\warning.mp3]],
}

local frames = {PetBarFrame,StanceBarFrame}
 
local function CheckForTextures(f)
  for _, child in pairs({ f:GetChildren() }) do
    CheckForTextures(child)
  end
  for _, region in pairs({ f:GetRegions() }) do
    if region:GetObjectType() == "Texture" then
      print("region",region:GetName(),region:GetTexture())
    end  
  end
end
 
for k, v in pairs(frames) do
  CheckForTextures(v)
end

-------------------------------------------------------------------
-- Used to overwrite default medias outside DuffedUI
-------------------------------------------------------------------

--[[local settings = DuffedUIEditedDefaultConfig
if settings then
	local media = settings.media
	if media then
		for option, value in pairs(media) do
			C.media[option] = value
		end
	end
end]]--