local D, C, L = select(2, ...):unpack()
if (not C["actionbars"].Enable) then return end

local _G = _G
local DuffedUIActionBars = D["ActionBars"]
local Panels = D["Panels"]
local Num = NUM_ACTIONBAR_BUTTONS
local MainMenuBar_OnEvent = MainMenuBar_OnEvent
local Size = C["actionbars"].NormalButtonSize
local PetSize = C["actionbars"].PetButtonSize
local Spacing = C["actionbars"].ButtonSpacing

function DuffedUIActionBars:CreateBar1()
	local ActionBar1 = Panels.ActionBar1
	local Warrior, Rogue, Warlock = "", "", ""

	if C["actionbars"].OwnWarriorStanceBar then
		Warrior = "[stance:1] 7; [stance:2] 8; [stance:3] 9;"
	end

	if C["actionbars"].OwnShadowDanceBar then
		Rogue = "[stance:3] 10; "
	end

	if C["actionbars"].OwnMetamorphosisBar then
		Warlock = "[stance:1] 10; "
	end

	ActionBar1.Page = {
		["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;",
		["WARRIOR"] = Warrior,
		["PRIEST"] = "[bonusbar:1] 7;",
		["ROGUE"] = Rogue .. "[bonusbar:1] 7;",
		["WARLOCK"] = Warlock,
		["MONK"] = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;",
		["DEFAULT"] = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [shapeshift] 13; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
	}

	function ActionBar1:GetBar()
		local Condition = ActionBar1.Page["DEFAULT"]
		local Class = select(2, UnitClass("player"))
		local Page = ActionBar1.Page[Class]
		
		if Page then
			Condition = Condition .. " " .. Page
		end
		
		Condition = Condition .. " [form] 1; 1"

		return Condition
	end

	ActionBar1:RegisterEvent("PLAYER_LOGIN")
	ActionBar1:RegisterEvent("PLAYER_ENTERING_WORLD")
	ActionBar1:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
	ActionBar1:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	ActionBar1:RegisterEvent("BAG_UPDATE")
	ActionBar1:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
	ActionBar1:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR")
	ActionBar1:SetScript("OnEvent", function(self, event, unit, ...)
		local Button
			
		if (event == "PLAYER_LOGIN" or event == "ACTIVE_TALENT_GROUP_CHANGED") then		
			for i = 1, Num do
				Button = _G["ActionButton"..i]
				self:SetFrameRef("ActionButton"..i, Button)
				self["Button"..i] = Button
			end	

			self:Execute([[
				Button = table.new()
				for i = 1, 12 do
					table.insert(Button, self:GetFrameRef("ActionButton"..i))
				end
			]])

			self:SetAttribute("_onstate-page", [[ 
				if HasTempShapeshiftActionBar() then
					newstate = GetTempShapeshiftBarIndex() or newstate
				end
				
				for i, Button in ipairs(Button) do
					Button:SetAttribute("actionpage", tonumber(newstate))
				end
			]])
			
			RegisterStateDriver(self, "page", self.GetBar())	
		elseif (event == "PLAYER_ENTERING_WORLD") then
			for i = 1, Num do
				Button = _G["ActionButton"..i]
				Button:Size(Size)
				Button:ClearAllPoints()
				Button:SetParent(self)
				Button:SetFrameStrata("BACKGROUND")
				Button:SetFrameLevel(15)
				if (i == 1) then
					Button:SetPoint("BOTTOMLEFT", Spacing, Spacing)
				else
					local Previous = _G["ActionButton"..i-1]
					Button:SetPoint("LEFT", Previous, "RIGHT", Spacing, 0)
				end
			end
		elseif (event == "UPDATE_VEHICLE_ACTIONBAR" or event == "UPDATE_OVERRIDE_ACTIONBAR") then
			if HasVehicleActionBar() or HasOverrideActionBar() then

			else

			end
		else
			MainMenuBar_OnEvent(self, event, ...)
		end
	end)
end