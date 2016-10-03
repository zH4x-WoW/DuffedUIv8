local D, C, L = unpack(select(2, ...))
--if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	FlightMapFramePortrait:Kill()
	FlightMapFramePortraitFrame:Kill()
	FlightMapFrame:CreateBackdrop("Transparent")
	FlightMapFrame.BorderFrame:StripTextures()

	FlightMapFrameCloseButton:SkinCloseButton()
end

D.SkinFuncs["Blizzard_FlightMap"] = LoadSkin