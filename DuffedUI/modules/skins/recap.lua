local D, C, L = unpack(select(2, ...))

local function RecapSkin()
	DeathRecapFrame:StripTextures()
	DeathRecapFrame:SetTemplate("Transparent")
	DeathRecapFrame.CloseXButton:SkinCloseButton()
end

D.SkinFuncs["Blizzard_DeathRecap"] = RecapSkin