local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local Panels = T["Panels"]

local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing
local IsShiftKeyDown = IsShiftKeyDown
local InCombatLockdown = InCombatLockdown
local error = ERR_NOT_IN_COMBAT

local BarButtons = {}

local OnEnter = function(self)
	self:SetAlpha(1)
end

local OnLeave = function(self)
	self:SetAlpha(0)
end

function ActionBars:ShowAllButtons(bar, num)
	local Button

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		Button = bar["Button"..i]
		Button:Show()
	end

	if (num == 2 or num == 3) then
		bar:Width((Size * 6) + (Spacing * 7))
	elseif (num == 5) then
		bar:Height((Size * 12) + (Spacing * 13))
	end
end

function ActionBars:RemoveColumn(bar, num)
	local Data = TukuiDataPerChar

	if (not bar.NextColumnToHide) then
		bar.NextColumnToHide = 6
	end
	
	if (bar.NextColumnToHide <= 1) then -- Reset the count at 1 button shown
		bar.NextColumnToHide = 6
		self:ShowAllButtons(bar, num)
		Data["Bar"..num.."Buttons"] = bar.NextColumnToHide
		
		return
	end
	
	local Button1 = bar["Button"..bar.NextColumnToHide]
	local Button2 = bar["Button"..bar.NextColumnToHide + 6]

	Button1:Hide()
	Button2:Hide()

	--bar:Width((Size * (bar.NextColumnToHide - 1)) + (Spacing * bar.NextColumnToHide))
	bar:Animation("Width", ((Size * (bar.NextColumnToHide - 1)) + (Spacing * bar.NextColumnToHide)), 8)

	bar.NextColumnToHide = bar.NextColumnToHide - 1

	Data["Bar"..num.."Buttons"] = bar.NextColumnToHide
end

function ActionBars:RemoveButton(bar, num)
	local Data = TukuiDataPerChar

	if (not bar.NextButtonToHide) then
		bar.NextButtonToHide = 12
	end
	
	if (bar.NextButtonToHide <= 1) then -- Reset the count at 1 button shown
		bar.NextButtonToHide = 12
		self:ShowAllButtons(bar, num)
		Data["Bar"..num.."Buttons"] = bar.NextButtonToHide
		
		return
	end

	local Button = bar["Button"..bar.NextButtonToHide]
	
	Button:Hide()
	
	--bar:Height((Size * (bar.NextButtonToHide - 1)) + (Spacing * bar.NextButtonToHide))
	bar:Animation("Height", ((Size * (bar.NextButtonToHide - 1)) + (Spacing * bar.NextButtonToHide)), 8)

	bar.NextButtonToHide = bar.NextButtonToHide - 1

	Data["Bar"..num.."Buttons"] = bar.NextButtonToHide
end

function ActionBars:ShowTopButtons(bar)
	local Button
	local Value = bar.NextColumnToHide or 6

	for i = 7, (Value + 6) do
		Button = bar["Button"..i]
		
		Button:Show()
	end
end

-- Restore buttons to previous state on load
function ActionBars:RestoreBarState()
	local Data = TukuiDataPerChar

	for bar = 2, 3 do
		if Data["Bar"..bar.."Buttons"] then
			for button = 1, (6 - Data["Bar"..bar.."Buttons"]) do
				self:RemoveColumn(Panels["ActionBar"..bar], bar)
			end
		end
	end
	
	for bar = 4, 5 do
		if Data["Bar"..bar.."Buttons"] then
			for button = 1, (6 - Data["Bar"..bar.."Buttons"]) do
				self:RemoveButton(Panels["ActionBar"..bar], bar)
			end
		end
	end
end

local OnClick = function(self)
	if InCombatLockdown() then
		return print(error)
	end
	
	local ShiftClick = IsShiftKeyDown()
	local Data = TukuiDataPerChar
	local Text = self.Text
	local Bar = self.Bar
	local Num = self.Num

	if Bar:IsVisible() then
		if (ShiftClick and Num ~= 4) then -- Handle shift-clicks on the button
			if (Num == 2 or Num ==  3) then	
				ActionBars:RemoveColumn(Bar, Num)
			else
				ActionBars:RemoveButton(Bar, Num)
			end
			
			return
		else
			-- Visibility
			UnregisterStateDriver(Bar, "visibility")
			Bar:Hide()
			
			if (Num == 4) then
				local Bar2 = Panels["ActionBar2"]
				local Bar3 = Panels["ActionBar3"]
			
				for i = 7, 12 do
					Bar2["Button"..i]:Hide()
					Bar3["Button"..i]:Hide()
				end
				
				Bar2:Height((Size * 1) + (Spacing * 2))
				Bar3:Height((Size * 1) + (Spacing * 2))
				BarButtons[2]:Height((Size * 1) + (Spacing * 2))
				BarButtons[3]:Height((Size * 1) + (Spacing * 2))
			end
			
			-- Move the button
			self:ClearAllPoints()
			
			if (Num == 2) then
				self:Point("RIGHT", Bar, "RIGHT", 0, 0)
				Text:SetText(L.ActionBars.ArrowLeft)
			elseif (Num == 3) then
				self:Point("LEFT", Bar, "LEFT", 0, 0)
				Text:SetText(L.ActionBars.ArrowRight)
			elseif (Num == 4) then
				self:Point("TOP", Panels.ActionBar1, "BOTTOM", 0, -3)
				Text:SetText(L.ActionBars.ArrowUp)
			elseif (Num == 5) then
				self:Size(Size, Bar:GetHeight() - 40)
				self:Point("LEFT", Bar, "RIGHT", 3, 0)
				Text:SetText(L.ActionBars.ArrowLeft)
			end
			
			-- Set value
			Data["HideBar"..Num] = true
		end
	else
		-- Visibility
		RegisterStateDriver(Bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
		Bar:Show()
		
		if (Num == 4) then
			local Bar2 = Panels["ActionBar2"]
			local Bar3 = Panels["ActionBar3"]

			ActionBars:ShowTopButtons(Bar2)
			ActionBars:ShowTopButtons(Bar3)
			
			Bar2:Height((Size * 2) + (Spacing * 3))
			Bar3:Height((Size * 2) + (Spacing * 3))
			BarButtons[2]:Height((Size * 2) + (Spacing * 3))
			BarButtons[3]:Height((Size * 2) + (Spacing * 3))
		end
		
		-- Move the button
		self:ClearAllPoints()

		if (Num == 2) then
			self:Point("RIGHT", Bar, "LEFT", -3, 0)
			Text:SetText(L.ActionBars.ArrowRight)
		elseif (Num == 3) then
			self:Point("LEFT", Bar, "RIGHT", 3, 0)
			Text:SetText(L.ActionBars.ArrowLeft)
		elseif (Num == 4) then
			self:Point("TOP", Panels.ActionBar1, "BOTTOM", 0, -3)
			Text:SetText(L.ActionBars.ArrowDown)
		elseif (Num == 5) then
			self:Size(Bar:GetWidth(), 18)
			self:Point("TOP", Bar, "BOTTOM", 0, -3)
			Text:SetText(L.ActionBars.ArrowRight)
		end
		
		-- Set value
		Data["HideBar"..Num] = false
	end
end

function ActionBars:CreateToggleButtons()
	for i = 2, 5  do
		local Bar = Panels["ActionBar" .. i]
		local Width = Bar:GetWidth()
		local Height = Bar:GetHeight()
		
		local Button = CreateFrame("Button", nil, UIParent)
		Button:SetTemplate()
		Button:RegisterForClicks("AnyUp")
		Button:SetAlpha(0)
		Button.Bar = Bar
		Button.Num = i
		
		Button:SetScript("OnClick", OnClick)
		Button:SetScript("OnEnter", OnEnter)
		Button:SetScript("OnLeave", OnLeave)
		
		Button.Text = Button:CreateFontString(nil, "OVERLAY")
		Button.Text:Point("CENTER", Button, 0, 0)
		Button.Text:SetFont(C.Medias.ActionBarFont, 12)
		
		if (i == 2) then
			Button:Size(18, Height)
			Button:Point("RIGHT", Bar, "LEFT", -3, 0)
			Button.Text:SetText(L.ActionBars.ArrowRight)
		elseif (i == 3) then
			Button:Size(18, Height)
			Button:Point("LEFT", Bar, "RIGHT", 3, 0)
			Button.Text:SetText(L.ActionBars.ArrowLeft)
		elseif (i == 4) then
			Button:Size(Width, 12)
			Button:Point("TOP", Panels.ActionBar1, "BOTTOM", 0, -3)
			Button.Text:SetText(L.ActionBars.ArrowDown)
		elseif (i == 5) then
			Button:Size(Width, 18)
			Button:Point("TOP", Bar, "BOTTOM", 0, -3)
			Button.Text:SetText(L.ActionBars.ArrowRight)
		end
		
		BarButtons[i] = Button
	end
end

function ActionBars:LoadVariables()
	if (not TukuiDataPerChar) then
		TukuiDataPerChar = {}
	end
	
	local Data = TukuiDataPerChar

	for i = 2, 5 do
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
	VehicleLeft.Text:SetFont(C.Medias.Font, 12)
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
	VehicleRight.Text:SetFont(C.Medias.Font, 12)
	VehicleRight.Text:Point("CENTER", 0, 0)
	VehicleRight.Text:SetText("|cffFF0000" .. LEAVE_VEHICLE .. "|r")
	VehicleRight.Text:SetShadowOffset(1.25, -1.25)

	RegisterStateDriver(VehicleLeft, "visibility", "[target=vehicle, exists] show; hide")
	RegisterStateDriver(VehicleRight, "visibility", "[target=vehicle, exists] show; hide")
	
	Panels.VehicleButtonLeft = VehicleLeft
	Panels.VehicleButtonRight = VehicleRight
end