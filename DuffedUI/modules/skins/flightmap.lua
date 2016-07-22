local D, C, L = unpack(select(2, ...))
--if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	--FlightMapFrame.ScrollContainer:StripTextures()
	--FlightMapFrame.ScrollContainer:SetFrameLevel(5)
	--FlightMapFrame.ScrollContainer:SetFrameStrata("HIGH")
	--FlightMapFrameTitleText:SetAlpha(0)
	--FlightMapFrameCloseButton:SkinCloseButton()
	--FlightMapFrameCloseButton:ClearAllPoints()
	--FlightMapFrameCloseButton:SetPoint("TOPRIGHT", 0, -20)
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)