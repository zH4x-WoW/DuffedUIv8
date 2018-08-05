local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded('AddOnSkins') then return end

local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame.TitleText:SetAlpha(0)
	TaxiRouteMap:CreateBackdrop('Transparent')
	TaxiFrame.CloseButton:SkinCloseButton()
	TaxiFrame.CloseButton:ClearAllPoints()
	TaxiFrame.CloseButton:SetPoint('TOPRIGHT', 0, -20)
end

local function LoadFlightMapSkin()
	FlightMapFrame:StripTextures()
	FlightMapFrame:SetTemplate('Transparent')
	FlightMapFrameCloseButton:SkinCloseButton()
	
	FlightMapFrame.BorderFrame:StripTextures()
end

D['SkinFuncs']['Blizzard_FlightMap'] = LoadFlightMapSkin
tinsert(D['SkinFuncs']['DuffedUI'], LoadSkin)