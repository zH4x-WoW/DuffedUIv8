local D, C, L = select(2, ...):unpack()

if (not C.ActionBars.Enable) then
	return
end

local _G = _G
local DuffedUIActionBars = T["ActionBars"]
local Panels = T["Panels"]
local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing

function DuffedUIActionBars:CreateStanceBar()
	local Bar = D.Panels.StanceBar
	
	Bar:RegisterEvent("PLAYER_LOGIN")
	Bar:RegisterEvent("PLAYER_ENTERING_WORLD")
	Bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	Bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
	Bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
	Bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	Bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	Bar:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
			StanceBarFrame.ignoreFramePositionManager = true
			StanceBarFrame:StripTextures()
			StanceBarFrame:SetParent(self)
			StanceBarFrame:ClearAllPoints()
			StanceBarFrame:SetPoint("TOPLEFT", self, "TOPLEFT", -7, 0)
			StanceBarFrame:EnableMouse(false)
			
			for i = 1, NUM_STANCE_SLOTS do
				local Button = _G["StanceButton"..i]
				
				Button:SetFrameStrata("LOW")
				Button:Show()
				
				if i ~= 1 then
					local Previous = _G["StanceButton"..i-1]
					
					Button:ClearAllPoints()				
					Button:Point("LEFT", Previous, "RIGHT", Spacing, 0)
				end
			end
			
			RegisterStateDriver(self, "visibility", "[vehicleui][petbattle] hide; show")
		elseif event == "UPDATE_SHAPESHIFT_FORMS" then

		elseif event == "PLAYER_ENTERING_WORLD" then
			DuffedUIActionBars.UpdateStanceBar(self)
			DuffedUIActionBars.SkinStanceButtons()
		else
			DuffedUIActionBars.UpdateStanceBar(self)
		end
	end)

	RegisterStateDriver(Bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end