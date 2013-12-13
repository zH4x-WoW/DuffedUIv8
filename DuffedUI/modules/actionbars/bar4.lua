local T, C, L = select(2, ...):unpack()
if (not C.ActionBars.Enable) then return end

local TukuiActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing
local MultiBarLeft = MultiBarLeft

function TukuiActionBars:CreateBar4()
	local ActionBar4 = T.Panels.ActionBar4
	
	MultiBarLeft:SetParent(ActionBar4)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarLeftButton"..i]
		local PreviousButton = _G["MultiBarLeftButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar4, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end
		
		ActionBar4["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar4, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end