local D, C, L = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

local bar = DuffedUIBar2
local FrameScale = C["general"].FrameScaleActionBar
MultiBarBottomLeft:SetParent(bar)

for i = 1, 12 do
	local b = _G["MultiBarBottomLeftButton" .. i]
	local b2 = _G["MultiBarBottomLeftButton" .. i - 1]
	b:SetSize((D.buttonsize * FrameScale), (D.buttonsize * FrameScale))
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)

	if i == 1 then b:SetPoint("BOTTOMLEFT", bar, (D.buttonspacing * FrameScale), (D.buttonspacing * FrameScale)) else b:SetPoint("LEFT", b2, "RIGHT", (D.buttonspacing * FrameScale), 0) end
end