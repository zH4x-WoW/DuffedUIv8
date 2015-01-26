local D, C, L = unpack(select(2, ...))
if not D.Patch == "6.1.0" then return end

local function RecapSkin()
	DeathRecapFrame:StripTextures()
	DeathRecapFrame:SetTemplate("Transparent")
	DeathRecapFrame.CloseXButton:SkinCloseButton()
end

D.SkinFuncs["Blizzard_DeathRecap"] = RecapSkin