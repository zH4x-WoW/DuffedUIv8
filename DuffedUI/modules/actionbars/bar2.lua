local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = D["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C["actionbars"].NormalButtonSize
local Spacing = C["actionbars"].ButtonSpacing
local MultiBarBottomLeft = MultiBarBottomLeft

function DuffedUIActionBars:CreateBar2()
	local ActionBar2 = D.Panels.ActionBar2
	
	MultiBarBottomLeft:SetParent(ActionBar2)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local PreviousButton = _G["MultiBarBottomLeftButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar2, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end
		
		ActionBar2["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar2, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end