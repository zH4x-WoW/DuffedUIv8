local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	FlightMapFrame:StripTextures()
	FlightMapFrame:SetTemplate("Transparent")
	FlightMapFrameCloseButton:SkinCloseButton()
	
	FlightMapFrame.BorderFrame:StripTextures()
end

D.SkinFuncs["Blizzard_FlightMap"] = LoadSkin