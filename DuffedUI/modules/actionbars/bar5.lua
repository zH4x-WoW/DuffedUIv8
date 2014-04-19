local D, C, L = select(2, ...):unpack()
if (not C["actionbars"].Enable) then return end

local DuffedUIActionBars = D["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C["actionbars"].NormalButtonSize
local Spacing = C["actionbars"].ButtonSpacing
local MultiBarRight = MultiBarRight

function DuffedUIActionBars:CreateBar5()
	local ActionBar5 = D.Panels.ActionBar5
	
	MultiBarRight:SetParent(ActionBar5)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local PreviousButton = _G["MultiBarRightButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar5, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end

		ActionBar5["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar5, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end