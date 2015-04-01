local D, C, L = unpack(select(2, ...))
if not C["actionbar"].enable == true then return end

local cp = "|cff319f1b" -- +
local cm = "|cff9a1212" -- -
local function ShowOrHideBar(bar, button)
	local db = DuffedUIDataPerChar

	if bar:IsShown() then
		if bar == DuffedUIBar3 then
			if button == DuffedUIBar3Button then
				UnregisterStateDriver(bar, "visibility")
				bar:Hide()
				db.bar3 = true
			end
		end

		if bar == DuffedUIBar4 then
			if button == DuffedUIBar4Button then
				UnregisterStateDriver(bar, "visibility")
				bar:Hide()
				db.bar4 = true
			end
		end

		if bar == DuffedUIBar5 then
			if button == DuffedUIBar5Button then
				UnregisterStateDriver(bar, "visibility")
				bar:Hide()
				db.bar5 = true
			end
		end
	else
		if bar == DuffedUIBar3 then
			db.bar3 = false
			RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle] show; show")
		end

		if bar == DuffedUIBar4 then
			db.bar4 = false
			RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle] show; show")
		end

		if bar == DuffedUIBar5 then
			db.bar5 = false
			RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle] show; show")
		end
	end
end

local function MoveButtonBar(button, bar)
	local db = DuffedUIDataPerChar

	if button == DuffedUIBar3Button then
		if bar:IsShown() then button.text:SetText(cm.."-|r") else button.text:SetText(cp.."+|r") end
	end

	if button == DuffedUIBar4Button then
		if bar:IsShown() then button.text:SetText(cm.."-|r") else button.text:SetText(cp.."+|r") end
	end

	if button == DuffedUIBar5Button then
		if bar:IsShown() then
			button.text:SetText(cm..">|r")
			DuffedUIPetBarMover:Point("RIGHT", DuffedUIBar5, "LEFT", -6, 0)
		else
			button.text:SetText(cp.."<|r")
			DuffedUIPetBarMover:Point("RIGHT", UIParent, "RIGHT", -14, -14)
		end
	end
end

local function UpdateBar(self, bar)
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	local button = self

	ShowOrHideBar(bar, button)
	MoveButtonBar(button, bar)
end

local DuffedUIBar3Button = CreateFrame("Button", "DuffedUIBar3Button", UIParent)
DuffedUIBar3Button:SetTemplate("Default")
DuffedUIBar3Button:RegisterForClicks("AnyUp")
DuffedUIBar3Button.text = D.SetFontString(DuffedUIBar3Button, C["media"].font, 11, "THINOUTLINE")
DuffedUIBar3Button:SetScript("OnClick", function(self, btn)
	if btn == "RightButton" then
		if DuffedUIInfoLeftBattleGround and UnitInBattleground("player") then ToggleFrame(DuffedUIInfoLeftBattleGround) end
	else
		if not C["actionbar"].Leftsidebars then UpdateBar(self, DuffedUIBar3) end
	end
end)
DuffedUIBar3Button:Size(DuffedUIInfoLeft:GetHeight())
DuffedUIBar3Button:Point("LEFT", DuffedUIInfoLeft, "RIGHT", 2, 0)
DuffedUIBar3Button.text:Point("CENTER", 2, -1)
DuffedUIBar3Button:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(C["media"].datatextcolor1)) end)
DuffedUIBar3Button:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C["media"].bordercolor)) end)
DuffedUIBar3Button.text:SetText(cm .. "-|r")

local DuffedUIBar4Button = CreateFrame("Button", "DuffedUIBar4Button", UIParent)
DuffedUIBar4Button:SetTemplate("Default")
DuffedUIBar4Button:RegisterForClicks("AnyUp")
DuffedUIBar4Button.text = D.SetFontString(DuffedUIBar4Button, C["media"].font, 11, "THINOUTLINE")
if not C["actionbar"].Rightsidebars then DuffedUIBar4Button:SetScript("OnClick", function(self, btn) UpdateBar(self, DuffedUIBar4) end) end
DuffedUIBar4Button:Size(DuffedUIInfoLeft:GetHeight())
DuffedUIBar4Button:Point("RIGHT", DuffedUIInfoRight, "LEFT", -2, 0)
DuffedUIBar4Button.text:Point("CENTER", 2, -1)
DuffedUIBar4Button:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(C["media"].datatextcolor1)) end)
DuffedUIBar4Button:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C["media"].bordercolor)) end)
DuffedUIBar4Button.text:SetText(cm .. "-|r")

local DuffedUIBar5Button = CreateFrame("Button", "DuffedUIBar5Button", UIParent)
DuffedUIBar5Button:Width(12)
DuffedUIBar5Button:Height(130)
DuffedUIBar5Button:Point("RIGHT", UIParent, "RIGHT", 1, -14)
DuffedUIBar5Button:SetTemplate("Default")
DuffedUIBar5Button:RegisterForClicks("AnyUp")
DuffedUIBar5Button:SetAlpha(0)
if not C["actionbar"].rightbarvertical then
	DuffedUIBar5Button:SetScript("OnClick", function(self, btn) UpdateBar(self, DuffedUIBar5) end)
end
if C["actionbar"].rightbarsmouseover == true then
	DuffedUIBar5Button:SetScript("OnEnter", function(self) DuffedUIRightBarsMouseover(1) end)
	DuffedUIBar5Button:SetScript("OnLeave", function(self) DuffedUIRightBarsMouseover(0) end)
else
	DuffedUIBar5Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
	DuffedUIBar5Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
end
DuffedUIBar5Button.text = D.SetFontString(DuffedUIBar5Button, C["media"].font, 13)
DuffedUIBar5Button.text:Point("CENTER", 0, 0)
DuffedUIBar5Button.text:SetText(cm .. ">|r")

local vehicleleft = CreateFrame("Button", "DuffedUIExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetAllPoints(DuffedUIInfoLeft)
vehicleleft:SetFrameStrata("LOW")
vehicleleft:SetFrameLevel(10)
vehicleleft:SetTemplate("Default")
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft:FontString("text", C["media"].font, 11)
vehicleleft.text:Point("CENTER", 0, 0)
vehicleleft.text:SetText("|cff4BAF4C" .. string.upper(LEAVE_VEHICLE) .. "|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

local vehicleright = CreateFrame("Button", "DuffedUIExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetAllPoints(DuffedUIInfoRight)
vehicleright:SetTemplate("Default")
vehicleright:SetFrameStrata("LOW")
vehicleright:SetFrameLevel(10)
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright:FontString("text", C["media"].font, 11)
vehicleright.text:Point("CENTER", 0, 0)
vehicleright.text:SetText("|cff4BAF4C" .. string.upper(LEAVE_VEHICLE) .. "|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")

local function Vehicle_OnEvent(self, event)
	if CanExitVehicle() and ActionBarController_GetCurrentActionBarState() == LE_ACTIONBAR_STATE_MAIN then
		self:Show()
		self:EnableMouse(true)
	else
		self:Hide()
	end
end

local function Vehicle_OnClick(self)
	if UnitOnTaxi("player") then
		TaxiRequestEarlyLanding()
		self:EnableMouse(false)
	else
		VehicleExit()
	end
end

local vehicleflight = CreateFrame("Button", "DuffedUIExitFlightButton", UIParent, "SecureHandlerClickTemplate")
vehicleflight:SetAllPoints(DuffedUIInfoRight)
vehicleflight:SetTemplate("Default")
vehicleflight:SetFrameStrata("LOW")
vehicleflight:SetFrameLevel(10)
vehicleflight:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleflight:FontString("text", C["media"].font, 11)
vehicleflight.text:Point("CENTER", 0, 0)
vehicleflight.text:SetText("|cff4BAF4C" .. string.upper(TAXI_CANCEL_DESCRIPTION) .. "|r")
vehicleflight:SetScript("OnClick", Vehicle_OnClick)
vehicleflight:SetScript("OnEnter", MainMenuBarVehicleLeaveButton_OnEnter)
vehicleflight:SetScript("OnLeave", GameTooltip_Hide)
vehicleflight:RegisterEvent("PLAYER_ENTERING_WORLD");
vehicleflight:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
vehicleflight:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR");
vehicleflight:RegisterEvent("UNIT_ENTERED_VEHICLE");
vehicleflight:RegisterEvent("UNIT_EXITED_VEHICLE");
vehicleflight:RegisterEvent("VEHICLE_UPDATE");
vehicleflight:SetScript("OnEvent", Vehicle_OnEvent)

vehicleflight:Hide()

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not DuffedUIDataPerChar then D.SetPerCharVariable("DuffedUIDataPerChar", {}) end
	local db = DuffedUIDataPerChar

	if db.bar3 then UpdateBar(DuffedUIBar3Button, DuffedUIBar3) end

	if db.bar4 then UpdateBar(DuffedUIBar4Button, DuffedUIBar4) end

	if db.bar5 then UpdateBar(DuffedUIBar5Button, DuffedUIBar5) end
end)