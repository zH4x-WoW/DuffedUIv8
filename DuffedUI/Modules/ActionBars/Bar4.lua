local D, C, L = select(2, ...):unpack()
if (not C["ActionBars"].Enable) then return end

local DuffedUIActionBars = D["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C["ActionBars"].NormalButtonSize
local Spacing = C["ActionBars"].ButtonSpacing
local MultiBarLeft = MultiBarLeft

function DuffedUIActionBars:CreateBar4()
	local ActionBar5 = D.Panels.ActionBar5
	
	MultiBarLeft:SetParent(ActionBar5)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarLeftButton"..i]
		local PreviousButton = _G["MultiBarLeftButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar5, Spacing, -Spacing)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
		end
		
		ActionBar5["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar5, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end