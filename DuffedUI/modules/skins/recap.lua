local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function RecapSkin()
	DeathRecapFrame:StripTextures()
	DeathRecapFrame:SetTemplate("Transparent")
	DeathRecapFrame.CloseXButton:SkinCloseButton()
	DeathRecapFrame.CloseButton:SkinButton()
end

D.SkinFuncs["Blizzard_DeathRecap"] = RecapSkin