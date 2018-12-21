local D, C, L
local myPlayerRealm = GetRealmName()
local myPlayerName  = UnitName('player')

local ALLOWED_GROUPS = {
	['general'] = 1,
	['unitframes'] = 1,
	['actionbar'] = 1,
	['bags'] = 1,
	['loot'] = 1,
	['cooldown'] = 1,
	['datatext'] = 1,
	['chat'] = 1,
	['tooltip'] = 1,
	['merchant'] = 1,
	['auras'] =  1,
	['castbar'] = 1,
	['misc'] = 1,
	['duffed'] = 1,
	['classtimer'] = 1,
	['raid'] = 1,
	['nameplate'] = 1,
}

if DuffedUIEditedDefaultConfig then
	for group, value in pairs(DuffedUIEditedDefaultConfig) do
		if group ~= 'media' and not ALLOWED_GROUPS[group] then ALLOWED_GROUPS[group] = 1 end
	end
end

local TableFilter = {
	['filter'] = 1,
}

local function Local(o)
	local string = o
	for option, value in pairs(DuffedUIConfigUILocalization) do
		if option == o then string = value end
	end
	return string
end

local NewButton = function(text, parent)
	local D, C, L = unpack(DuffedUI)
	local result = CreateFrame('Button', nil, parent)
	local label = result:CreateFontString(nil, 'OVERLAY', nil)

	label:SetFont(C['media']['font'], 11, 'THINOUTLINE')
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)
	return result
end

local function SetValue(group, option, value)
	local mergesettings
	if DuffedUIConfigPrivate == DuffedUIConfigPublic then mergesettings = true else mergesettings = false end

	if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then
		if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
		if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
		DuffedUIConfigPrivate[group][option] = value
	else
		if mergesettings == true then
			if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
			if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
			DuffedUIConfigPrivate[group][option] = value
		end
		if not DuffedUIConfigPublic then DuffedUIConfigPublic = {} end
		if not DuffedUIConfigPublic[group] then DuffedUIConfigPublic[group] = {} end
		DuffedUIConfigPublic[group][option] = value
	end
end

local GetOrderedIndex = function(t)
	local OrderedIndex = {}

	for key in pairs(t) do table.insert(OrderedIndex, key) end
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
		if (t.OrderedIndex[i] == state) then Key = t.OrderedIndex[i + 1] end
	end

	if Key then return Key, t[Key] end
	t.OrderedIndex = nil
	return
end

local PairsByKeys = function(t) return OrderedNext, t, nil end

local VISIBLE_GROUP = nil
local function ShowGroup(group)
	local D, C, L = unpack(DuffedUI)

	if VISIBLE_GROUP then _G['DuffedUIConfigUI'..VISIBLE_GROUP]:Hide() end
	if _G['DuffedUIConfigUI'..group] then
		local o = 'DuffedUIConfigUI'..group
		local translate = Local(group)

		_G['DuffedUIConfigUITitle']:SetText(translate)
		local height = _G['DuffedUIConfigUI'..group]:GetHeight()
		_G['DuffedUIConfigUI'..group]:Show()
		local scrollamntmax = 305
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1
		if max == 1 then
			_G['DuffedUIConfigUIGroupSlider']:SetValue(1)
			_G['DuffedUIConfigUIGroupSlider']:Hide()
		else
			_G['DuffedUIConfigUIGroupSlider']:SetMinMaxValues(0, max)
			_G['DuffedUIConfigUIGroupSlider']:Show()
			_G['DuffedUIConfigUIGroupSlider']:SetValue(1)
		end
		_G['DuffedUIConfigUIGroup']:SetScrollChild(_G['DuffedUIConfigUI'..group])

		local x
		if DuffedUIConfigUIGroupSlider:IsShown() then 
			_G['DuffedUIConfigUIGroup']:EnableMouseWheel(true)
			_G['DuffedUIConfigUIGroup']:SetScript('OnMouseWheel', function(self, delta)
				if DuffedUIConfigUIGroupSlider:IsShown() then
					if delta == -1 then
						x = _G['DuffedUIConfigUIGroupSlider']:GetValue()
						_G['DuffedUIConfigUIGroupSlider']:SetValue(x + 10)
					elseif delta == 1 then
						x = _G['DuffedUIConfigUIGroupSlider']:GetValue()
						_G['DuffedUIConfigUIGroupSlider']:SetValue(x - 30)
					end
				end
			end)
		else
			_G['DuffedUIConfigUIGroup']:EnableMouseWheel(false)
		end
		VISIBLE_GROUP = group
	end
end

function CreateDuffedUIConfigUI()
	if DuffedUIConfigUI then
		ShowGroup('general')
		DuffedUIConfigUI:Show()
		return
	end

	D['CreatePopup']['PERCHAR'] = {
		question = DuffedUIConfigUILocalization.option_perchar,
		function1 = function()
			if DuffedUIConfigAllCharacters:GetChecked() then 
				DuffedUIConfigAll[myPlayerRealm][myPlayerName] = true
				DuffedUIConfigPublic = nil
			else 
				DuffedUIConfigAll[myPlayerRealm][myPlayerName] = false
				DuffedUIConfigPrivate = nil
			end
			ReloadUI()
		end,
		function2 = function() 
			DuffedUIConfigCover:Hide()
			if DuffedUIConfigAllCharacters:GetChecked() then
				DuffedUIConfigAllCharacters:SetChecked(false)
			else 
				DuffedUIConfigAllCharacters:SetChecked(true)
			end
		end,
		answer1 = ACCEPT,
		answer2 = CANCEL,
	}

	D['CreatePopup']['RESET_PERCHAR'] = {
		question = DuffedUIConfigUILocalization.option_resetchar,
		function1 = function()
			DuffedUIConfig = DuffedUIConfigPublic
			ReloadUI() 
		end,
		function2 = function()
			if DuffedUIConfigUI and DuffedUIConfigUI:IsShown() then DuffedUIConfigCover:Hide() end
		end,
		answer1 = ACCEPT,
		answer2 = CANCEL,
	}

	D['CreatePopup']['RESET_ALL'] = {
		question = DuffedUIConfigUILocalization.option_resetall,
		function1 = function()
			DuffedUIConfigPublic = nil
			DuffedUIConfigPrivate = nil
			ReloadUI()
		end,
		function2 = function() DuffedUIConfigCover:Hide() end,
		answer1 = ACCEPT,
		answer2 = CANCEL,
	}

	local DuffedUIConfigUI = CreateFrame('Frame', 'DuffedUIConfigUI', UIParent)
	DuffedUIConfigUI:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
	DuffedUIConfigUI:SetWidth(750)
	DuffedUIConfigUI:SetHeight(420)
	DuffedUIConfigUI:SetFrameStrata('HIGH')
	DuffedUIConfigUI:EnableMouse(true)
	DuffedUIConfigUI:SetScript('OnMouseDown', function() DuffedUIConfigUI:StartMoving() end)
	DuffedUIConfigUI:SetScript('OnMouseUp', function() DuffedUIConfigUI:StopMovingOrSizing() end)
	DuffedUIConfigUI:SetClampedToScreen(true)
	DuffedUIConfigUI:SetMovable(true)

	local DuffedUIConfigUIBG = CreateFrame('Frame', 'DuffedUIConfigUI', DuffedUIConfigUI)
	DuffedUIConfigUIBG:SetPoint('TOPLEFT', -10, 10)
	DuffedUIConfigUIBG:SetPoint('BOTTOMRIGHT', 10, -10)
	DuffedUIConfigUIBG:SetTemplate('Transparent')

	local DuffedUIConfigUITitleBox = CreateFrame('Frame', 'DuffedUIConfigUI', DuffedUIConfigUI)
	DuffedUIConfigUITitleBox:Size(DuffedUIConfigUIBG:GetWidth() - 33, 30)
	DuffedUIConfigUITitleBox:SetPoint('BOTTOMLEFT', DuffedUIConfigUIBG, 'TOPLEFT', 0, 3)
	DuffedUIConfigUITitleBox:SetTemplate('Transparent')

	local DuffedUIConfigUITitle = DuffedUIConfigUITitleBox:CreateFontString('DuffedUIConfigUITitle', 'OVERLAY')
	DuffedUIConfigUITitle:SetFont(C['media']['font'], 12, 'THINOUTLINE')
	DuffedUIConfigUITitle:SetPoint('LEFT', DuffedUIConfigUITitleBox, 'LEFT', 10, 0)

	local DuffedUIConfigUIIcon = CreateFrame('Frame', 'DuffedUIConfigUITitle', DuffedUIConfigUI)
	DuffedUIConfigUIIcon:Size(30, 30)
	DuffedUIConfigUIIcon:SetPoint('LEFT', DuffedUIConfigUITitleBox, 'RIGHT', 3, 0)
	DuffedUIConfigUIIcon:SetTemplate('Transparent')

	DuffedUIConfigUIIcon.bg = DuffedUIConfigUIIcon:CreateTexture(nil, 'ARTWORK')
	DuffedUIConfigUIIcon.bg:Point('TOPLEFT', 2, -2)
	DuffedUIConfigUIIcon.bg:Point('BOTTOMRIGHT', -2, 2)
	DuffedUIConfigUIIcon.bg:SetTexture(C['media'].duffed)

	local groups = CreateFrame('ScrollFrame', 'DuffedUICatagoryGroup', DuffedUIConfigUI)
	groups:SetPoint('TOPLEFT', 10, -10)
	groups:SetWidth(150)
	groups:SetHeight(400)

	local groupsBG = CreateFrame('Frame', 'DuffedUIConfigUI', DuffedUIConfigUI)
	groupsBG:SetPoint('TOPLEFT', groups, -10, 10)
	groupsBG:SetPoint('BOTTOMRIGHT', groups, 10, -10)
	groupsBG:SetTemplate('Transparent')

	local DuffedUIConfigCover = CreateFrame('Frame', 'DuffedUIConfigCover', DuffedUIConfigUI)
	DuffedUIConfigCover:SetPoint('TOPLEFT', DuffedUICatagoryGroup, 'TOPLEFT')
	DuffedUIConfigCover:SetPoint('BOTTOMRIGHT', DuffedUIConfigUI, 'BOTTOMRIGHT')
	DuffedUIConfigCover:SetFrameLevel(DuffedUIConfigUI:GetFrameLevel() + 20)
	DuffedUIConfigCover:EnableMouse(true)
	DuffedUIConfigCover:SetScript('OnMouseDown', function(self)
		print(DuffedUIConfigUILocalization.option_makeselection)
	end)
	DuffedUIConfigCover:Hide()

	local slider = CreateFrame('Slider', 'DuffedUIConfigUICatagorySlider', groups)
	slider:SetPoint('TOPRIGHT', 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture('Interface\\Buttons\\UI-ScrollBar-Knob')
	slider:SetOrientation('VERTICAL')
	slider:SetValueStep(20)
	slider:SetTemplate('Transparent')
	slider:SetScript('OnValueChanged', function(self, value)
		groups:SetVerticalScroll(value)
	end)

	local child = CreateFrame('Frame', nil, groups)
	child:SetPoint('TOPLEFT')

	local offset = 5
	for group, table in PairsByKeys(ALLOWED_GROUPS) do
		local o = 'DuffedUIConfigUI'..group
		local translate = Local(group)
		local button = NewButton('|cffffffff'.. translate..'|r', child)

		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint('TOPLEFT', 5, -(offset))
		button:SetScript('OnEnter', function(self)
			self:SetText(D['PanelColor']..translate)
		end)
		button:SetScript('OnLeave', function(self)
			self:SetText('|cffffffff'..translate..'|r')
		end)
		button:SetScript('OnClick', function(self)
			ShowGroup(group)
		end)
		offset = offset + 20
	end

	child:SetWidth(125)
	child:SetHeight(offset)
	slider:SetMinMaxValues(0, (offset == 0 and 1 or offset -12 * 25))
	slider:SetValue(1)
	groups:SetScrollChild(child)

	local x
	_G['DuffedUICatagoryGroup']:EnableMouseWheel(true)
	_G['DuffedUICatagoryGroup']:SetScript('OnMouseWheel', function(self, delta)
		if _G['DuffedUIConfigUICatagorySlider']:IsShown() then
			if delta == -1 then
				x = _G['DuffedUIConfigUICatagorySlider']:GetValue()
				_G['DuffedUIConfigUICatagorySlider']:SetValue(x + 10)
			elseif delta == 1 then
				x = _G['DuffedUIConfigUICatagorySlider']:GetValue()
				_G['DuffedUIConfigUICatagorySlider']:SetValue(x - 20)
			end
		end
	end)

	local group = CreateFrame('ScrollFrame', 'DuffedUIConfigUIGroup', DuffedUIConfigUI)
	group:SetPoint('TOPRIGHT', -10, -10)
	group:SetWidth(550)
	group:SetHeight(400)

	local groupBG = CreateFrame('Frame', 'DuffedUIConfigUI', DuffedUIConfigUI)
	groupBG:SetPoint('TOPLEFT', group, -10, 10)
	groupBG:SetPoint('BOTTOMRIGHT', group, 10, -10)
	groupBG:SetTemplate('Transparent')

	local slider = CreateFrame('Slider', 'DuffedUIConfigUIGroupSlider', group)
	slider:SetPoint('TOPRIGHT', 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(400)
	slider:SetThumbTexture('Interface\\Buttons\\UI-ScrollBar-Knob')
	slider:SetOrientation('VERTICAL')
	slider:SetValueStep(20)
	slider:SetTemplate('Transparent')
	slider:SetScript('OnValueChanged', function(self, value)
		group:SetVerticalScroll(value)
	end)

	for group, table in PairsByKeys(ALLOWED_GROUPS) do
		local frame = CreateFrame('Frame', 'DuffedUIConfigUI'..group, DuffedUIConfigUIGroup)
		frame:SetPoint('TOPLEFT')
		frame:SetWidth(325)

		local offset = 5

		if type(C[group]) ~= 'table' then error(group..' GroupName not found in config table.') return end
		for option, value in  PairsByKeys(C[group]) do
			if type(value) == 'boolean' then
				local button = CreateFrame('CheckButton', 'DuffedUIConfigUI'..group..option, frame, 'InterfaceOptionsCheckButtonTemplate')
				local o = 'DuffedUIConfigUI'..group..option
				local translate = Local(group..option)

				_G['DuffedUIConfigUI' .. group..option..'Text']:SetText(translate)
				_G['DuffedUIConfigUI' .. group..option..'Text']:SetFont(C['media']['font'], 11, '')
				button:SetChecked(value)
				button:SkinCheckBox()
				button.backdrop:SetBackdropColor( 0, 0, 0, 0 )
				button:SetCheckedTexture( 'Interface\\Buttons\\UI-CheckBox-Check' )
				button:SetScript('OnClick', function(self) SetValue(group, option, (self:GetChecked() and true or false)) end)
				button:SetPoint('TOPLEFT', 5, -(offset))
				offset = offset + 25
			elseif type(value) == 'number' or type(value) == 'string' then
				local label = frame:CreateFontString(nil, 'OVERLAY', nil)
				label:SetFont(C['media']['font'], 11, '')
				local o = 'DuffedUIConfigUI'..group..option
				local translate = Local(group..option)

				label:SetText(translate)
				label:SetWidth(420)
				label:SetHeight(20)
				label:SetJustifyH('LEFT')
				label:SetPoint('TOPLEFT', 5, -(offset))

				local editbox = CreateFrame('EditBox', nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(280)
				editbox:SetHeight(20)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3, 0, 0, 0)
				editbox:SetBackdrop({
					bgFile = C['media']['blank'], 
					tiled = false,
				})
				editbox:SetBackdropColor(0, 0, 0, 0.5)
				editbox:SetBackdropBorderColor(0, 0, 0, 1)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint('TOPLEFT', 5, -(offset + 20))
				editbox:SetText(value)
				editbox:SetTemplate('Transparent')

				local okbutton = CreateFrame('Button', nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SetWidth(editbox:GetHeight())
				okbutton:SetTemplate('Transparent')
				okbutton:SetPoint('LEFT', editbox, 'RIGHT', 3, 0)

				local oktext = okbutton:CreateFontString(nil, 'OVERLAY', nil)
				oktext:SetFont(C['media']['font'], 11, '')
				oktext:SetText('OK')
				oktext:SetPoint('CENTER', D['Scale'](1), 0)
				oktext:SetJustifyH('CENTER')
				okbutton:Hide()
 
				if type(value) == 'number' then
					editbox:SetScript('OnEscapePressed', function(self)
						okbutton:Hide()
						self:ClearFocus()
						self:SetText(value)
					end)
					editbox:SetScript('OnChar', function(self)
						okbutton:Show()
					end)
					editbox:SetScript('OnEnterPressed', function(self)
						okbutton:Hide()
						self:ClearFocus()
						SetValue(group, option, tonumber(self:GetText()))
					end)
					okbutton:SetScript('OnMouseDown', function(self)
						editbox:ClearFocus()
						self:Hide()
						SetValue(group, option, tonumber(editbox:GetText()))
					end)
				else
					editbox:SetScript('OnEscapePressed', function(self)
						okbutton:Hide()
						self:ClearFocus()
						self:SetText(value)
					end)
					editbox:SetScript('OnChar', function(self)
						okbutton:Show()
					end)
					editbox:SetScript('OnEnterPressed', function(self)
						okbutton:Hide()
						self:ClearFocus()
						SetValue(group, option, tostring(self:GetText()))
					end)
					okbutton:SetScript('OnMouseDown', function(self)
						editbox:ClearFocus()
						self:Hide()
						SetValue(group, option, tostring(editbox:GetText()))
					end)
				end
				offset = offset + 45
			elseif type(value) == 'table' and not TableFilter[option] then
				local label = frame:CreateFontString(nil, 'OVERLAY', nil)
				label:SetFont(C['media']['font'], 11, 'THINOUTLINE')
				local o = 'DuffedUIConfigUI'..group..option
				local translate = Local(group .. option)

				label:SetText(translate)
				label:SetWidth(420)
				label:SetHeight(20)
				label:SetJustifyH('LEFT')
				label:SetPoint('TOPLEFT', 5, -(offset))

				colorbuttonname = (label:GetText()..'ColorPicker')
				local colorbutton = CreateFrame('Button', colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetWidth(60)
				colorbutton:SetTemplate('Transparent')
				colorbutton:SetBackdropColor(unpack(value))
				colorbutton:SetBackdropBorderColor(.125, .125, .125)
				colorbutton:SetPoint('LEFT', label, 'RIGHT', 3, 0)

				local colortext = colorbutton:CreateFontString(nil, 'OVERLAY', nil)
				colortext:SetFont(C['media']['font'], 11, 'THINOUTLINE')
				colortext:SetText('Set Color')
				colortext:SetPoint('CENTER', 0, -1)
				colortext:SetJustifyH('CENTER')

				local function round(number, decimal) return (('%%.%df'):format(decimal)):format(number) end
				colorbutton:SetScript('OnMouseDown', function(button)
					if ColorPickerFrame:IsShown() then return end

					local oldr, oldg, oldb, olda = unpack(value)
					local function ShowColorPicker(r, g, b, a, changedCallback, sameCallback)
						HideUIPanel(ColorPickerFrame)
						ColorPickerFrame.button = button
						ColorPickerFrame:SetColorRGB(r, g, b)
						ColorPickerFrame.hasOpacity = (a ~= nil and a < 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = { oldr, oldg, oldb, olda }
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, sameCallback
						ColorPickerFrame:SetFrameLevel(DuffedUIConfigUI:GetFrameLevel() + 4)
						ColorPickerFrame:SetFrameStrata('HIGH')
						ShowUIPanel(ColorPickerFrame)
					end

					local function ColorCallback(restore)
						if restore ~= nil or button ~= ColorPickerFrame.button then return end
						local newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						value = { newR, newG, newB, newA }
						SetValue(group, option, (value)) 
						button:SetBackdropBorderColor(newR, newG, newB, newA)
					end

					local function SameColorCallback()
						value = { oldr, oldg, oldb, olda }
						SetValue(group, option, (value))
						button:SetBackdropBorderColor(oldr, oldg, oldb, olda)
					end
					ShowColorPicker(oldr, oldg, oldb, olda, ColorCallback, SameColorCallback)
				end)
				offset = offset+25
			end
		end
		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NewButton(DuffedUIConfigUILocalization.option_button_reset, DuffedUIConfigUI)
	reset:Size(100, 20)
	reset:SetPoint('TOPRIGHT', DuffedUIConfigUIBG, 'TOPRIGHT', 103, 0)
	reset:SetScript('OnClick', function(self)
		DuffedUIConfigCover:Show()
		if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then D.ShowPopup('RESET_PERCHAR') else D.ShowPopup('RESET_ALL') end
		DuffedUIConfigUI:Hide()
	end)
	reset:SetTemplate('Transparent')

	local close = NewButton(DuffedUIConfigUILocalization.option_button_close, DuffedUIConfigUI)
	close:Size(100, 20)
	close:SetPoint('TOPRIGHT', DuffedUIConfigUIBG, 'TOPRIGHT', 103, -23)
	close:SetScript('OnClick', function(self) DuffedUIConfigUI:Hide() end)
	close:SetTemplate('Transparent')

	local load = NewButton(DuffedUIConfigUILocalization.option_button_load, DuffedUIConfigUI)
	load:Size(100, 20)
	load:SetPoint('TOPRIGHT', DuffedUIConfigUIBG, 'TOPRIGHT', 103, -46)
	load:SetScript('OnClick', function(self) ReloadUI() end)
	load:SetTemplate('Transparent')

	if DuffedUIConfigAll then
		local button = CreateFrame('CheckButton', 'DuffedUIConfigAllCharacters', DuffedUIConfigUITitleBox, 'InterfaceOptionsCheckButtonTemplate')
		button:SetScript('OnClick', function(self)
			D.ShowPopup('PERCHAR')
			DuffedUIConfigUI:Hide()
		end)
		button:SetPoint('RIGHT', DuffedUIConfigUITitleBox, 'RIGHT', -3, 0)
		local label = DuffedUIConfigAllCharacters:CreateFontString(nil, 'OVERLAY', nil)
		label:SetFont(C['media']['font'], 11)
		label:SetText(DuffedUIConfigUILocalization.option_setsavedsetttings)
		label:SetPoint('RIGHT', button, 'LEFT')
		if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then button:SetChecked(true) else button:SetChecked(false) end
		button:SkinCheckBox()
	end

	ShowGroup('general')

	--[[Global Credits]]--
	local cf = CreateFrame('Frame', 'CreditFrame', DuffedUIConfigUI)
	cf:SetTemplate('Transparent')
	cf:Size(770, 22)
	cf:Point('TOP', DuffedUIConfigUI, 'BOTTOM', 0, -13)

	local sf = CreateFrame('ScrollFrame', nil, DuffedUIConfigUI)
	sf:SetSize(770, 22)
	sf:SetPoint('CENTER', cf, 0, 0)

	local scroll = CreateFrame('Frame', nil, sf)
	scroll:Size(770, 22)
	scroll:SetPoint('CENTER', cf)
	sf:SetScrollChild(scroll)

	local credit = 'Special thanks to: '
	for i = 1, #D.Credits do
		if (i ~= 1) then credit = credit .. ', ' .. '|cffff8000' .. D.Credits[i] .. '|r' else credit = credit .. '|cffff8000' .. D.Credits[i] .. '|r' end
	end

	local ct = scroll:CreateFontString(nil, 'OVERLAY')
	ct:SetFont(C['media']['font'], 14)
	ct:SetText(credit)
	ct:Point('LEFT', scroll, 'RIGHT', 4, 0)
	scroll:SetAnimation('Move', 'Horizontal', -1500, 0.5)

	scroll:AnimOnFinished('Move', function(self)
		if (not DuffedUIConfigUI:IsVisible()) then return end
		self:ClearAllPoints()
		self:SetPoint('CENTER', cf)
		self:SetAnimation('Move', 'Horizontal', -1500, 0.5)
	end)

	--[[DuffedUI Credits]]--
	local cf2 = CreateFrame('Frame', 'CreditFrame2', DuffedUIConfigUI)
	cf2:SetTemplate('Transparent')
	cf2:Size(770, 22)
	cf2:Point('TOP', DuffedUIConfigUI, 'BOTTOM', 0, -38)

	local sf2 = CreateFrame('ScrollFrame', nil, DuffedUIConfigUI)
	sf2:SetSize(766, 22)
	sf2:SetPoint('CENTER', cf2, 0, 0)

	local scroll2 = CreateFrame('Frame', nil, sf2)
	scroll2:Size(766, 22)
	scroll2:SetPoint('CENTER', cf2)
	sf2:SetScrollChild(scroll2)

	local credit2 = 'Special thanks to my Betatester & Bugreporter: '
	for i = 1, #D.DuffedCredits do
		if (i ~= 1) then credit2 = credit2 .. ', ' .. '|cffC41F3B' ..  D.DuffedCredits[i]  .. '|r' else credit2 = credit2 .. '|cffC41F3B' ..  D.DuffedCredits[i]  .. '|r' end
	end

	local ct2 = scroll2:CreateFontString(nil, 'OVERLAY')
	ct2:SetFont(C['media']['font'], 14)
	ct2:SetText(credit2)
	ct2:Point('LEFT', scroll2, 'RIGHT', 4, 0)
	scroll2:SetAnimation('Move', 'Horizontal', -1500, 0.5)

	scroll2:AnimOnFinished('Move', function(self)
		if (not DuffedUIConfigUI:IsVisible()) then return end
		self:ClearAllPoints()
		self:SetPoint('CENTER', cf2)
		self:SetAnimation('Move', 'Horizontal', -1500, 0.5)
	end)
end

do
	SLASH_RESETCONFIG1 = '/resetui'
	function SlashCmdList.RESETCONFIG()
		if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
		if DuffedUIConfigUI and DuffedUIConfigUI:IsShown() then DuffedUIConfigCover:Show() end
		if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then D.ShowPopup('RESET_PERCHAR') else D.ShowPopup('RESET_ALL') end
	end

	local loaded = CreateFrame('Frame')
	loaded:RegisterEvent('PLAYER_LOGIN')
	loaded:SetScript('OnEvent', function(self, event, addon)
		D, C, L = unpack(DuffedUI)
		local menu = GameMenuFrame
		local menuy = menu:GetHeight()
		local quit = GameMenuButtonQuit
		local continue = GameMenuButtonContinue
		local continuex = continue:GetWidth()
		local continuey = continue:GetHeight()
		local config = DuffedUIConfigUI
		local interface = GameMenuButtonUIOptions
		local keybinds = GameMenuButtonKeybindings

		menu:SetHeight(menuy + continuey)

		local button = CreateFrame('BUTTON', 'GameMenuDuffedUIButtonOptions', menu, 'GameMenuButtonTemplate')
		button:SetSize(continuex, continuey)
		if IsAddOnLoaded('ProjectAzilroka') then
			button:Point('TOP', Enhanced_ConfigButton, 'BOTTOM', 0, -1)
			Enhanced_ConfigButton:SkinButton()
		else
			button:Point('TOP', interface, 'BOTTOM', 0, -1)
		end
		button:SetText('DuffedUI')
		button:SkinButton()
		button:SetScript('OnClick', function(self)
			if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
			local config = DuffedUIConfigUI
			if config and config:IsShown() then
				DuffedUIConfigUI:Hide()
			else
				CreateDuffedUIConfigUI()
				HideUIPanel(menu)
			end
		end)
		keybinds:ClearAllPoints()
		keybinds:Point('TOP', button, 'BOTTOM', 0, -1)
	end)
end