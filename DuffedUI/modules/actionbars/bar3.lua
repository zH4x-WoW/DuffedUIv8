local D, C, L = select(2, ...):unpack()
if (not C["actionbars"].Enable) then return end

local DuffedUIActionBars = D["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C["actionbars"].NormalButtonSize - 4
local Spacing = C["actionbars"].ButtonSpacing
local MultiBarBottomRight = MultiBarBottomRight

function DuffedUIActionBars:CreateBar3()
	local ActionBar3 = D.Panels.ActionBar3
	
	MultiBarBottomRight:SetParent(ActionBar3)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local PreviousButton = _G["MultiBarBottomRightButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar3, Spacing, -Spacing)
		elseif (i == 7) then
			Button:SetPoint("TOPRIGHT", ActionBar3, -Spacing, -Spacing)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
		end
		
		ActionBar3["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar3, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end