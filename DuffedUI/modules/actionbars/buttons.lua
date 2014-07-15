local D, C, L = select(2, ...):unpack()

local ActionBars = D["ActionBars"]
local Panels = D["Panels"]

local Size = C["actionbars"].NormalButtonSize
local Spacing = C["actionbars"].ButtonSpacing
local IsShiftKeyDown = IsShiftKeyDown
local InCombatLockdown = InCombatLockdown
local error = ERR_NOT_IN_COMBAT
local Green = "|cff319f1b"
local Red = "|cff9a1212"

local BarButtons = {}

local OnClick = function(self, button)
	if InCombatLockdown() then
		return print(error)
	end
	
	local Data = DuffedUIDataPerChar
	local Text = self.Text
	local Bar = self.Bar
	local Num = self.Num

	if (Bar:IsVisible()) then
		-- Visibility
		UnregisterStateDriver(Bar, "visibility")
		Bar:Hide()
		
		-- Move the button
		self:ClearAllPoints()
		
		if (Num == 3) then
			self:Point("LEFT", D["Panels"].DataTextLeft, "RIGHT", 2, 0)
			Text:SetText(Green .. "+|r")
		elseif (Num == 4) then
			self:Point("LEFT", Bar, "RIGHT", 2, 0)
			Text:SetText(Green .. "<|r")
		elseif (Num == 5) then
			self:Point("RIGHT", D["Panels"].DataTextRight, "LEFT", -2, 0)
			Text:SetText(Green .. "+|r")
		end
		
		-- Set value
		Data["HideBar"..Num] = true
	else
		-- Visibility
		RegisterStateDriver(Bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
		Bar:Show()
		
		-- Move the button
		self:ClearAllPoints()

		if (Num == 3) then
			self:Point("LEFT", D["Panels"].DataTextLeft, "RIGHT", 2, 0)
			Text:SetText(Red .. "-|r")
		elseif (Num == 4) then
			self:Point("LEFT", Bar, "RIGHT", 2, 0)
			Text:SetText(Red .. ">|r")
		elseif (Num == 5) then
			self:Point("RIGHT", D["Panels"].DataTextRight, "LEFT", -2, 0)
			Text:SetText(Red .. "-|r")
		end
		
		-- Set value
		Data["HideBar"..Num] = false
	end
end

function ActionBars:CreateToggleButtons()
	for i = 3, 5  do
		local Bar = Panels["ActionBar" .. i]
		
		local Button = CreateFrame("Button", nil, UIParent)
		Button:SetTemplate()
		Button:RegisterForClicks("AnyUp")
		Button.Bar = Bar
		Button.Num = i
		
		Button:SetScript("OnClick", OnClick)
		
		Button.Text = Button:CreateFontString(nil, "OVERLAY")
		Button.Text:Point("CENTER", Button, -1, 1)
		Button.Text:SetFont(C["medias"].ActionBarFont, 12)
		
		if (i == 3) then
			Button:Size(20)
			Button:Point("LEFT", D["Panels"].DataTextLeft, "RIGHT", 2, 0)
			Button.Text:SetText(Red .. "-|r")
			Button.Text:SetPoint("CENTER", 0, -1)
		elseif (i == 4) then
			Button:Size(15, 150)
			Button:Point("LEFT", Panels.ActionBar4, "RIGHT", 2, 0)
			Button.Text:SetText(Red .. ">|r")
			if C["actionbars"].Rightbutton then
				Button:SetAlpha(0)
				Button:SetScript("OnEnter", function() Button:SetAlpha(1) end)
				Button:SetScript("OnLeave", function() Button:SetAlpha(0) end)
			end
		elseif (i == 5) then
			Button:Size(20)
			Button:Point("RIGHT", D["Panels"].DataTextRight, "LEFT", -2, 0)
			Button.Text:SetText(Red .. "-|r")
			Button.Text:SetPoint("CENTER", 0, -1)
		end
		
		BarButtons[i] = Button
		
		Panels["ActionBar" .. i .. "ToggleButton"] = Button
	end
end

function ActionBars:LoadVariables()
	if (not DuffedUIDataPerChar) then
		DuffedUIDataPerChar = {}
	end
	
	local Data = DuffedUIDataPerChar

	-- Hide Bars
	for i = 3, 5 do
		local Button = BarButtons[i]
		
		if Data["HideBar"..i] then
			OnClick(Button)
		end
	end
end

function ActionBars:CreateVehicleButtons()
	local VehicleLeft = CreateFrame("Button", nil, UIParent, "SecureHandlerClickTemplate")
	VehicleLeft:SetAllPoints(Panels.DataTextLeft)
	VehicleLeft:SetFrameStrata("MEDIUM")
	VehicleLeft:SetFrameLevel(10)
	VehicleLeft:SetTemplate()
	VehicleLeft:RegisterForClicks("AnyUp")
	VehicleLeft:SetScript("OnClick", VehicleExit)

	VehicleLeft.Text = VehicleLeft:CreateFontString(nil, "OVERLAY")
	VehicleLeft.Text:SetFont(C["medias"].Font, 12)
	VehicleLeft.Text:Point("CENTER", 0, 0)
	VehicleLeft.Text:SetText("|cffFF0000" .. LEAVE_VEHICLE .. "|r")
	VehicleLeft.Text:SetShadowOffset(1.25, -1.25)

	local VehicleRight = CreateFrame("Button", nil, UIParent, "SecureHandlerClickTemplate")
	VehicleRight:SetAllPoints(Panels.DataTextRight)
	VehicleRight:SetTemplate()
	VehicleRight:SetFrameStrata("MEDIUM")
	VehicleRight:SetFrameLevel(10)
	VehicleRight:RegisterForClicks("AnyUp")
	VehicleRight:SetScript("OnClick", VehicleExit)

	VehicleRight.Text = VehicleRight:CreateFontString(nil, "OVERLAY")
	VehicleRight.Text:SetFont(C["medias"].Font, 12)
	VehicleRight.Text:Point("CENTER", 0, 0)
	VehicleRight.Text:SetText("|cffFF0000" .. LEAVE_VEHICLE .. "|r")
	VehicleRight.Text:SetShadowOffset(1.25, -1.25)

	RegisterStateDriver(VehicleLeft, "visibility", "[target=vehicle, exists] show; hide")
	RegisterStateDriver(VehicleRight, "visibility", "[target=vehicle, exists] show; hide")
	
	Panels.VehicleButtonLeft = VehicleLeft
	Panels.VehicleButtonRight = VehicleRight
end