local D, C, L = select(2, ...):unpack()
if (not C["actionbars"].Enable) then return end

local DuffedUIActionBars = D["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local Size = C["actionbars"].NormalButtonSize
local Spacing = C["actionbars"].ButtonSpacing
local MultiBarLeft = MultiBarLeft

function DuffedUIActionBars:CreateBar4()
	local ActionBar4 = D.Panels.ActionBar4
	
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
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
		end
		
		ActionBar4["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar4, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end

---------------
-- Mouseover --
---------------
if C["actionbars"].rightbarsmouseover ~= true then return end

-- Frame i created cause mouseover rightbars sux if it fades out when ur mouse is behind (right) of them ..
local rbmoh = CreateFrame("Frame", nil, D.Panels.ActionBar4)
rbmoh:Point("RIGHT", UIParent, "RIGHT", 0, -14)
rbmoh:SetSize(24, (Size * 12) + (Spacing * 13))

function DuffedUIRightBarsMouseover(alpha)
	D.Panels.ActionBar4:SetAlpha(alpha)
	D.Panels.ActionBar4ToggleButton(alpha)
	MultiBarLeft:SetAlpha(alpha)
	if C["actionbars"].petbaralwaysvisible ~= true then
		D.Panels.PetActionBar:SetAlpha(alpha)
		for i=1, NUM_PET_ACTION_SLOTS do
			_G["PetActionButton"..i]:SetAlpha(alpha)
		end
	end
end

local function mouseover(frame)
	frame:EnableMouse(true)
	frame:SetAlpha(0)
	frame:HookScript("OnEnter", function() DuffedUIRightBarsMouseover(1) end)
	frame:HookScript("OnLeave", function() DuffedUIRightBarsMouseover(0) end)
end
mouseover(D.Panels.ActionBar4)
mouseover(rbmoh)

for i = 1, 12 do
	_G["MultiBarLeftButton"..i]:EnableMouse(true)
	_G["MultiBarLeftButton"..i]:HookScript("OnEnter", function() DuffedUIRightBarsMouseover(1) end)
	_G["MultiBarLeftButton"..i]:HookScript("OnLeave", function() DuffedUIRightBarsMouseover(0) end)
end

if C["actionbars"].petbaralwaysvisible ~= true then
	for i = 1, NUM_PET_ACTION_SLOTS do
		_G["PetActionButton"..i]:EnableMouse(true)
		_G["PetActionButton"..i]:HookScript("OnEnter", function() DuffedUIRightBarsMouseover(1) end)
		_G["PetActionButton"..i]:HookScript("OnLeave", function() DuffedUIRightBarsMouseover(0) end)
	end
	mouseover(D["Panels"].PetActionBar)
end