local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing
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
			Button:SetPoint("TOPRIGHT", ActionBar5, -Spacing, -Spacing)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
		end

		ActionBar5["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar5, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end