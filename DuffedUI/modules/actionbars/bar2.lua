local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing
local MultiBarBottomLeft = MultiBarBottomLeft

function DuffedUIActionBars:CreateBar2()
	local ActionBar2 = T.Panels.ActionBar2
	
	MultiBarBottomLeft:SetParent(ActionBar2)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local PreviousButton = _G["MultiBarBottomLeftButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("BOTTOMRIGHT", ActionBar2, -Spacing, Spacing)
		elseif (i == 7) then
			Button:SetPoint("TOPRIGHT", ActionBar2, -Spacing, -Spacing)
		else
			Button:SetPoint("RIGHT", PreviousButton, "LEFT", -Spacing, 0)
		end
		
		ActionBar2["Button"..i] = Button
	end

	for i = 7, 12 do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local Button1 = _G["MultiBarBottomLeftButton1"]
		
		Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
	end
	
	RegisterStateDriver(ActionBar2, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end