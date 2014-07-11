local DuffedUIConfig = CreateFrame("Frame", "DuffedUIConfig", UIParent)
DuffedUIConfig.Functions = {}
local GroupPages = {}
local Locale = GetLocale()

function DuffedUIConfig:SetOption(group, option, value)
	local C = DuffedUIConfigShared
	
	C[group][option] = value -- Save our setting
	
	if (not self.Functions[group]) then
		return
	end
	
	if self.Functions[group][option] then
		self.Functions[group][option](value) -- Run the associated function
	end
end

function DuffedUIConfig:SetCallback(group, option, func)
	if (not self.Functions[group]) then
		self.Functions[group] = {}
	end
	
	self.Functions[group][option] = func -- Set a function to call
end

-- Filter unwanted groups
local Filter = {
	["medias"] = true,
}

local DuffedUICredits = {
	"Shaney",
	"Juhawny",
	"Rav",
	"loki",
	"Sinaris",
}

local Credits = {
	"Elv",
	"Hydra",
	"Haste",
	"Nightcracker",
	"Haleth",
	"Caellian",
	"Shestak",
	"Tekkub",
	"Roth",
	"Alza",
	"P3lim",
	"Tulla",
	"Hungtar",
	"Ishtara",
	"Caith",
	"Azilroka",
}

local GetOrderedIndex = function(t)
    local OrderedIndex = {}

    for key in pairs(t) do
        table.insert(OrderedIndex, key)
    end

    table.sort(OrderedIndex)

    return OrderedIndex
end

local OrderedNext = function(t, state)
	local Key

    if (state == nil) then
        t.OrderedIndex = GetOrderedIndex(t)
        Key = t.OrderedIndex[1]

        return Key, t[Key]
    end

    Key = nil

    for i = 1, #t.OrderedIndex do
        if (t.OrderedIndex[i] == state) then
            Key = t.OrderedIndex[i + 1]
        end
    end

    if Key then
        return Key, t[Key]
    end

    t.OrderedIndex = nil

    return
end

local PairsByKeys = function(t)
    return OrderedNext, t, nil
end

-- Create custom controls for options.
local Fonts = {
	["Pixel"] = "DuffedUIPixelFont",
	["DuffedUI"] = "DuffedUIFont",
	["DuffedUI2"] = "DuffedUIFontOutline",
	["DuffedUI3"] = "DuffedUIUFFont",
}

local SortedFonts = {
	"DuffedUI",
	"DuffedUI2",
	"DuffedUI3",
	"Pixel",
}

local ControlOnEnter = function(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 2)
	GameTooltip:AddLine(self.Tooltip, 1, 1, 1, 1, 1)
	GameTooltip:Show()
end

local ControlOnLeave = function(self)
	GameTooltip:Hide()
end

local SetControlInformation = function(control, group, option)
	if (not DuffedUIConfig[Locale]) then
		return
	end
	
	if (not DuffedUIConfig[Locale][group]) then
		return
	end
	
	local Info = DuffedUIConfig[Locale][group][option]
	
	if (not Info) then
		return
	end
	
	control.Label:SetText(Info.Name)
	
	if control.Box then
		control.Box.Tooltip = Info.Desc
		control.Box:HookScript("OnEnter", ControlOnEnter)
		control.Box:HookScript("OnLeave", ControlOnLeave)
	else
		control.Tooltip = Info.Desc
		control:HookScript("OnEnter", ControlOnEnter)
		control:HookScript("OnLeave", ControlOnLeave)
	end
end

local EditBoxOnMouseDown = function(self)
	self:SetAutoFocus(true)
end

local EditBoxOnEditFocusLost = function(self)
	self:SetAutoFocus(false)
end

local EditBoxOnEnterPressed = function(self)
	self:SetAutoFocus(false)
	self:ClearFocus()
	
	local Value = self:GetText()
	
	if (type(tonumber(Value)) == "number") then -- Assume we want a number, not a string
		Value = tonumber(Value)
	end
	
	DuffedUIConfig:SetOption(self.Group, self.Option, Value)
end

local ButtonOnClick = function(self)
	if self.Toggled then
		self.Tex:SetAnimation("Gradient", "texture", 0, 0.3, 1, 0, 0, nil, 0, 1, 0)
		self.Toggled = false
	else
		self.Tex:SetAnimation("Gradient", "texture", 0, 0.3, 0, 1, 0, nil, 1, 0, 0)
		self.Toggled = true
	end
	
	DuffedUIConfig:SetOption(self.Group, self.Option, self.Toggled)
end

local ButtonCheck = function(self)
	self.Toggled = false
	ButtonOnClick(self)
end

local ButtonUncheck = function(self)
	self.Toggled = true
	ButtonOnClick(self)
end

local DropDownOnClick = function(self, arg1)
	UIDropDownMenu_SetSelectedID(arg1, self:GetID())

	DuffedUIConfig:SetOption(arg1.Group, arg1.Option, self.value)
end

local DropDownInitialize = function(self, level)
	local Info = UIDropDownMenu_CreateInfo()

	for i = 1, #SortedFonts do
		Info = UIDropDownMenu_CreateInfo()
		Info.text = SortedFonts[i]
		Info.value = SortedFonts[i]
		Info.func = DropDownOnClick
		Info.arg1 = self
		Info.fontObject = Fonts[SortedFonts[i]]
		UIDropDownMenu_AddButton(Info, level)
	end
end

local Callback = function(cancel)
	local R, G, B
	
	if cancel then
		R, G, B = unpack(cancel)
	else
		R, G, B = ColorPickerFrame:GetColorRGB()
	end
	
	local Current = ColorPickerFrame.Current
	Current.Color:SetTexture(R, G, B)
	
	DuffedUIConfig:SetOption(Current.Group, Current.Option, {R, G, B})
end

local InitColorPicker = function(self, r, g, b)
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorPickerFrame.previousValues = {r, g, b}
	ColorPickerFrame.func = Callback
	ColorPickerFrame.cancelFunc = Callback
	ColorPickerFrame.Current = self
	
	ColorPickerFrame:Hide()
	ColorPickerFrame:Show()
end

local ColorPickerOnClick = function(self)
	InitColorPicker(self, unpack(self.Colors))
end

local CreateConfigButton = function(parent, group, option, value)
	local C = select(2, DuffedUI:unpack())
	
	local Button = CreateFrame("Button", nil, parent)
	Button:SetTemplate()
	Button:SetSize(20, 20)
	Button.Toggled = false
	Button:SetScript("OnClick", ButtonOnClick)
	Button.Type = "Button"
	
	Button.Tex = Button:CreateTexture(nil, "OVERLAY")
	Button.Tex:SetPoint("TOPLEFT", 2, -2)
	Button.Tex:SetPoint("BOTTOMRIGHT", -2, 2)
	Button.Tex:SetTexture(1, 0, 0)
	
	Button.Check = ButtonCheck
	Button.Uncheck = ButtonUncheck
	
	Button.Group = group
	Button.Option = option
	
	Button.Label = Button:CreateFontString(nil, "OVERLAY")
	Button.Label:SetFont(C["medias"].Font, 12)
	Button.Label:SetPoint("LEFT", Button, "RIGHT", 5, 0)
	Button.Label:SetShadowColor(0, 0, 0)
	Button.Label:SetShadowOffset(1.25, -1.25)
	
	if value then
		Button:Check()
	else
		Button:Uncheck()
	end
	
	return Button
end

local CreateConfigEditBox = function(parent, group, option, value)
	local C = select(2, DuffedUI:unpack())
	
	local EditBox = CreateFrame("Frame", nil, parent)
	EditBox:SetSize(150, 20)
	EditBox:SetTemplate()
	EditBox.Type = "EditBox"
	
	EditBox.Box = CreateFrame("EditBox", nil, EditBox)
	EditBox.Box:SetFont(C["medias"].Font, 12)
	EditBox.Box:SetPoint("TOPLEFT", EditBox, 4, -2)
	EditBox.Box:SetPoint("BOTTOMRIGHT", EditBox, -4, 2)
	EditBox.Box:SetMaxLetters(20)
	EditBox.Box:SetAutoFocus(false)
	EditBox.Box:EnableKeyboard(true)
	EditBox.Box:EnableMouse(true)
	EditBox.Box:SetScript("OnMouseDown", EditBoxOnMouseDown)
	EditBox.Box:SetScript("OnEscapePressed", EditBoxOnEnterPressed)
	EditBox.Box:SetScript("OnEnterPressed", EditBoxOnEnterPressed)
	EditBox.Box:SetScript("OnEditFocusLost", EditBoxOnEditFocusLost)
	EditBox.Box:SetText(value)
	
	EditBox.Label = EditBox:CreateFontString(nil, "OVERLAY")
	EditBox.Label:SetFont(C["medias"].Font, 12)
	EditBox.Label:SetPoint("LEFT", EditBox, "RIGHT", 5, 0)
	EditBox.Label:SetShadowColor(0, 0, 0)
	EditBox.Label:SetShadowOffset(1.25, -1.25)
	
	EditBox.Box.Group = group
	EditBox.Box.Option = option
	EditBox.Box.Label = EditBox.Label
	
	return EditBox
end

local CreateConfigColorPicker = function(parent, group, option, value)
	local C = select(2, DuffedUI:unpack())
	
	local Button = CreateFrame("Button", nil, parent)
	Button:SetTemplate()
	Button:SetSize(50, 20)
	Button.Colors = value
	Button:SetScript("OnClick", ColorPickerOnClick)
	Button.Type = "Color"
	
	Button.Group = group
	Button.Option = option
	
	Button.Name = Button:CreateFontString(nil, "OVERLAY")
	Button.Name:SetFont(C["medias"].Font, 12)
	Button.Name:SetPoint("CENTER", Button)
	Button.Name:SetShadowColor(0, 0, 0)
	Button.Name:SetShadowOffset(1.25, -1.25)
	Button.Name:SetText(COLOR)
	
	Button.Color = Button:CreateTexture(nil, "OVERLAY")
	Button.Color:Point("TOPLEFT", 2, -2)
	Button.Color:Point("BOTTOMRIGHT", -2, 2)
	Button.Color:SetTexture(value[1], value[2], value[3])
	
	Button.Label = Button:CreateFontString(nil, "OVERLAY")
	Button.Label:SetFont(C["medias"].Font, 12)
	Button.Label:SetPoint("LEFT", Button, "RIGHT", 5, 0)
	Button.Label:SetShadowColor(0, 0, 0)
	Button.Label:SetShadowOffset(1.25, -1.25)
	
	return Button
end

local CreateConfigDropDown = function(parent, group, option, value)
	local C = select(2, DuffedUI:unpack())

	local DropDown = CreateFrame("Button", "DropDownMenu" .. group .. option, parent, "UIDropDownMenuTemplate")
	DropDown.Group = group
	DropDown.Option = option
	DropDown.Type = "DropDown"

	UIDropDownMenu_Initialize(DropDown, DropDownInitialize)
	UIDropDownMenu_SetWidth(DropDown, 90)
	UIDropDownMenu_SetButtonWidth(DropDown, 24)
	UIDropDownMenu_SetSelectedName(DropDown, value) -- need to figure out defaults for this to work.

	DropDown:SkinDropDown(90)
	DropDown:Show()

	DropDown.Label = DropDown:CreateFontString(nil, "OVERLAY")
	DropDown.Label:SetFont(C["medias"].Font, 12)
	DropDown.Label:SetPoint("LEFT", DropDown, "RIGHT", -2, 4)
	DropDown.Label:SetShadowColor(0, 0, 0)
	DropDown.Label:SetShadowOffset(1.25, -1.25)

	return DropDown
end

local ShowGroup = function(group)
	if (not GroupPages[group]) then
		return
	end

	for group, page in pairs(GroupPages) do
		page:Hide()
	end
	
	GroupPages[group]:Show()
	DuffedUIConfigFrameTitle.Text:SetText(group)
end

local GroupButtonOnClick = function(self)
	ShowGroup(self.Group)
end

-- Create the config window
function DuffedUIConfig:CreateConfigWindow()
	local C = select(2, DuffedUI:unpack())
	
	if (not DuffedUIConfigShared) then
		-- create a default Saved Variables file with default settings.
		DuffedUIConfigShared = C
	end
	
	local ConfigFrame = CreateFrame("Frame", "DuffedUIConfigFrame", UIParent)
	ConfigFrame:Size(647, 492)
	ConfigFrame:Point("CENTER")
	ConfigFrame:SetFrameStrata("HIGH")
		
	local LeftWindow = CreateFrame("Frame", "DuffedUIConfigFrameLeft", ConfigFrame)
	LeftWindow:SetTemplate()
	LeftWindow:Size(164, 492)
	LeftWindow:Point("LEFT", ConfigFrame)
	LeftWindow:SetTemplate("Transparent")
	LeftWindow:EnableMouse(true)
	
	local RightWindow = CreateFrame("Frame", "DuffedUIConfigFrameRight", ConfigFrame)
	RightWindow:SetTemplate()
	RightWindow:Size(480, 492)
	RightWindow:Point("RIGHT", ConfigFrame)
	RightWindow:SetTemplate("Transparent")
	RightWindow:EnableMouse(true)
	
	local TitleFrame = CreateFrame("Frame", "DuffedUIConfigFrameTitle", ConfigFrame)
	TitleFrame:Size(614, 30)
	TitleFrame:Point("BOTTOM", ConfigFrame, "TOP", -17, 3)
	TitleFrame:SetTemplate("Transparent")
	
	TitleFrame.Text = TitleFrame:CreateFontString(nil, "OVERLAY")
	TitleFrame.Text:SetFont(C["medias"].Font, 16)
	TitleFrame.Text:Point("CENTER", TitleFrame, 0, -1)
	TitleFrame.Text:SetShadowColor(0, 0, 0)
	TitleFrame.Text:SetShadowOffset(1.25, -1.25)
	
	local TitleIcon = CreateFrame("Frame", "DuffedUIConfigTitleIcon", TitleFrame)
	TitleIcon:Size(30, 30)
	TitleIcon:SetPoint("LEFT", TitleFrame, "RIGHT", 3, 0)
	TitleIcon:SetTemplate("Transparent")

	TitleIcon.bg = TitleIcon:CreateTexture(nil, "ARTWORK")
	TitleIcon.bg:Point("TOPLEFT", 2, -2)
	TitleIcon.bg:Point("BOTTOMRIGHT", -2, 2)
	TitleIcon.bg:SetTexture(C["medias"].Duffed)
	
	local CloseButton = CreateFrame("Button", nil, ConfigFrame)
	CloseButton:Size(132, 20)
	CloseButton:SetTemplate("Transparent")
	CloseButton:SetScript("OnClick", function() ConfigFrame:Hide() end)
	CloseButton:StyleButton()
	CloseButton:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
	CloseButton:SetPoint("TOPLEFT", RightWindow, "TOPRIGHT", 3, 0)
	
	CloseButton.Text = CloseButton:CreateFontString(nil, "OVERLAY")
	CloseButton.Text:SetFont(C["medias"].Font, 12)
	CloseButton.Text:Point("CENTER", CloseButton)
	CloseButton.Text:SetText(CLOSE)
	
	local ReloadButton = CreateFrame("Button", nil, ConfigFrame)
	ReloadButton:Size(132, 20)
	ReloadButton:SetTemplate("Transparent")
	ReloadButton:SetScript("OnClick", function() ReloadUI() end)
	ReloadButton:StyleButton()
	ReloadButton:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
	ReloadButton:SetPoint("TOP", CloseButton, "BOTTOM", 0, -4)

	ReloadButton.Text = ReloadButton:CreateFontString(nil, "OVERLAY")
	ReloadButton.Text:SetFont(C["medias"].Font, 12)
	ReloadButton.Text:Point("CENTER", ReloadButton)
	ReloadButton.Text:SetText("Reload UI")
	
	local LastButton
	local ButtonCount = 0
	
	for Group, Table in PairsByKeys(C) do
		if (not Filter[Group]) then
			local GroupPage = CreateFrame("Frame", nil, ConfigFrame)
			GroupPage:SetTemplate("Transparent")
			GroupPage:SetAllPoints(RightWindow)
			
			GroupPage.Controls = {["EditBox"] = {}, ["Color"] = {}, ["Button"] = {}, ["DropDown"] = {}}
			GroupPages[Group] = GroupPage
		
			local Button = CreateFrame("Button", nil, ConfigFrame)
			Button.Group = Group
			
			Button:Size(132, 20)
			Button:SetTemplate()
			Button:SetScript("OnClick", GroupButtonOnClick)
			Button:StyleButton()
			Button:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
			
			Button.Text = Button:CreateFontString(nil, "OVERLAY")
			Button.Text:SetFont(C["medias"].Font, 12)
			Button.Text:Point("CENTER", Button)
			Button.Text:SetText(Group)
			
			if (ButtonCount == 0) then
				Button:SetPoint("TOP", LeftWindow, 0, -6)
			else
				Button:SetPoint("TOP", LastButton, "BOTTOM", 0, -4)
			end
			
			ButtonCount = ButtonCount + 1
			LastButton = Button
			
			local Control
			local LastControl
			
			for Option, Value in pairs(Table) do
				if (type(Value) == "boolean") then -- Button
					Control = CreateConfigButton(GroupPage, Group, Option, Value)
				elseif (type(Value) == "number") then -- EditBox
					Control = CreateConfigEditBox(GroupPage, Group, Option, Value)
				elseif (type(Value) == "table") then -- Color Picker
					Control = CreateConfigColorPicker(GroupPage, Group, Option, Value)
				elseif (type(Value) == "string") then -- DropDown
					Control = CreateConfigDropDown(GroupPage, Group, Option, Value)
				end
				
				SetControlInformation(Control, Group, Option) -- Set the label and tooltip
				
				tinsert(GroupPage.Controls[Control.Type], Control)
			end
			
			local Buttons = GroupPage.Controls["Button"]
			local EditBoxes = GroupPage.Controls["EditBox"]
			local ColorPickers = GroupPage.Controls["Color"]
			local DropDowns = GroupPage.Controls["DropDown"]
			
			for i = 1, #Buttons do
				if (i == 1) then
					if LastControl then
						Buttons[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
					else
						Buttons[i]:Point("TOPLEFT", GroupPage, 8, -8)
					end
				else
					Buttons[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				end
				
				LastControl = Buttons[i]
			end
			
			for i = 1, #EditBoxes do
				if (i == 1) then
					if LastControl then
						EditBoxes[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
					else
						EditBoxes[i]:Point("TOPLEFT", GroupPage, 8, -8)
					end
				else
					EditBoxes[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				end
				
				LastControl = EditBoxes[i]
			end
			
			for i = 1, #ColorPickers do
				if (i == 1) then
					if LastControl then
						ColorPickers[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
					else
						ColorPickers[i]:Point("TOPLEFT", GroupPage, 8, -8)
					end
				else
					ColorPickers[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				end
				
				LastControl = ColorPickers[i]
			end
			
			for i = 1, #DropDowns do -- We shouldn't need more than one, but i'll leave this here for now.
				if (i == 1) then
					if LastControl then
						DropDowns[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", -20, -2)
					else
						DropDowns[i]:Point("TOPLEFT", GroupPage, 8, -8)
					end
				else
					DropDowns[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				end

				LastControl = DropDowns[i]
			end
		end
	end
	
	-- Credits for DuffedUI
	local DuffedUICreditFrame = CreateFrame("Frame", "DuffedUIFrameCredit", ConfigFrame)
	DuffedUICreditFrame:SetTemplate()
	DuffedUICreditFrame:Size(647, 22)
	DuffedUICreditFrame:Point("TOP", ConfigFrame, "BOTTOM", 0, -3)

	local DuffedUIScrollFrame = CreateFrame("ScrollFrame", nil, ConfigFrame)
	DuffedUIScrollFrame:SetAllPoints(DuffedUICreditFrame)

	local DuffedUIScrollable = CreateFrame("Frame", nil, DuffedUIScrollFrame)
	DuffedUIScrollable:SetWidth(639)
	DuffedUIScrollable:SetHeight(22)
	DuffedUIScrollable:SetPoint("CENTER", DuffedUICreditFrame)

	DuffedUIScrollFrame:SetScrollChild(DuffedUIScrollable)

	local DuffedUICreditString = "Special thanks for my Tester: "

	for i = 1, #DuffedUICredits do
		if (i ~= 1) then
			DuffedUICreditString = DuffedUICreditString .. ", " .. "|cffC41F3B" .. DuffedUICredits[i] .. "|r"
		else
			DuffedUICreditString = DuffedUICreditString .. "|cffC41F3B" .. DuffedUICredits[i] .. "|r"
		end
	end

	local DuffedUICreditText = DuffedUIScrollable:CreateFontString(nil, "OVERLAY")
	DuffedUICreditText:SetFont(C["medias"].Font, 14)
	DuffedUICreditText:SetText(DuffedUICreditString)
	DuffedUICreditText:Point("LEFT", DuffedUIScrollable, "RIGHT", 4, 0)

	DuffedUIScrollable:SetAnimation("Move", "Horizontal", -1250, 0.5)

	DuffedUIScrollable:AnimOnFinished("Move", function(self)
		if (not ConfigFrame:IsVisible()) then
			return
		end

		self:ClearAllPoints()
		self:SetPoint("CENTER", DuffedUICreditFrame)
		self:SetAnimation("Move", "Horizontal", -1250, 0.5)
	end)
	
	-- Credits for Tukui
	local CreditFrame = CreateFrame("Frame", "TukuiFrameCredit", ConfigFrame)
	CreditFrame:SetTemplate()
	CreditFrame:Size(647, 22)
	CreditFrame:Point("TOP", DuffedUIFrameCredit, "BOTTOM", 0, -3)

	local ScrollFrame = CreateFrame("ScrollFrame", nil, ConfigFrame)
	ScrollFrame:SetAllPoints(CreditFrame)

	local Scrollable = CreateFrame("Frame", nil, ScrollFrame)
	Scrollable:SetWidth(639)
	Scrollable:SetHeight(22)
	Scrollable:SetPoint("CENTER", CreditFrame)

	ScrollFrame:SetScrollChild(Scrollable)

	local CreditString = "Special thanks to: "

	for i = 1, #Credits do
		if (i ~= 1) then
			CreditString = CreditString .. ", " .. Credits[i]
		else
			CreditString = CreditString .. Credits[i]
		end
	end

	local CreditText = Scrollable:CreateFontString(nil, "OVERLAY")
	CreditText:SetFont(C["medias"].Font, 14)
	CreditText:SetText(CreditString)
	CreditText:Point("LEFT", Scrollable, "RIGHT", 4, 0)

	Scrollable:SetAnimation("Move", "Horizontal", -1250, 0.5)

	Scrollable:AnimOnFinished("Move", function(self)
		if (not ConfigFrame:IsVisible()) then
			return
		end

		self:ClearAllPoints()
		self:SetPoint("CENTER", CreditFrame)
		self:SetAnimation("Move", "Horizontal", -1250, 0.5)
	end)
	
	ShowGroup("general") -- Show General options by default
	
	ConfigFrame:Hide()
end