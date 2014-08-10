local D, C, L, G = unpack(select(2, ...))
if C["actionbar"].enable ~= true then return end

---------------------------------------------------------------------------
-- setup MultiBarRight as bar #4
---------------------------------------------------------------------------

local bar = DuffedUIBar4
MultiBarLeft:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:SetSize((D.buttonsize - 4), (D.buttonsize - 4))
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPLEFT", bar, D.buttonspacing, -D.buttonspacing)
	elseif i == 7 then
		b:SetPoint("TOPRIGHT", bar, -D.buttonspacing, -D.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -D.buttonspacing)
	end
end
RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")