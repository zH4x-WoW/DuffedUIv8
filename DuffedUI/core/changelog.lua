local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('Changelog', 'AceEvent-3.0', 'AceTimer-3.0')

local _G = _G
local format, gmatch, gsub, find, sub = string.format, string.gmatch, string.gsub, string.find, string.sub
local pairs, tostring = pairs, tostring

local CreateFrame = _G.CreateFrame
local SOUNDKIT = _G.SOUNDKIT
local PlaySound = _G.PlaySound
local CLOSE = _G.CLOSE

local ChangeLogData = {
	"Changes:",
		"• Update AddOnSkins",
		"• Update Project Azilroka",
		"• Bugfix moving Actionbar1",
		"• Bugfix Shapeshiftbar vanished after zoning",
		"• Add Corruptionbar to left chat",
		"• Add Corruptionranks to Tooltip",
		"• Add Nyalotha Raiddebuffs (Thx Simpy)",
		"• Add Color for Special Bags",
		"• Add Corruption Filter for Bags/Bank",
		"• Add Summary for Corruptions on Characterframe ->Corrution Eye",
		"• Add New Datatext System",
		"• Add MoveUI to Config Menu (Right Side)",
		"• Add New Menu if you click '+' on Right Chat",
		"• Add Mechagnome and Vulpera Spellcooldowns",
		--"• ",
	" ",
	"Special:",
		"• Pawn users have to deactivate the upgrade border under Pawn tooltip options.",
	" ",
	"Notes:",
		"• For the old friendslist use Enhanced Friendslist from Project Azilroka.",
		"• For skins use AddOnSkins because most of the skins are removed.",
		"• For skinning the Chatbubbles in Instance/Raids download the Texturekit from Github.",
}

local function ModifiedString(string)
	local count = string.find(string, ':')
	local newString = string

	if count then
		local prefix = string.sub(string, 0, count)
		local suffix = string.sub(string, count + 1)
		local subHeader = string.find(string, '•')

		if subHeader then newString = tostring('|cFFFFFF00'.. prefix .. '|r' .. suffix) else newString = tostring('|cffC41F3B' .. prefix .. '|r' .. suffix) end
	end

	for pattern in gmatch(string, "('.*')") do newString = newString:gsub(pattern, "|cffffcc00" .. pattern:gsub("'", "") .. "|r") end
	return newString
end

local function GetChangeLogInfo(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

_G.StaticPopupDialogs['BUGREPORT'] = {
	text = "Bugreporting for DuffedUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...)
		self.editBox:SetFocus()
		self.editBox:SetText('https://github.com/liquidbase/DuffedUIv8/issues')
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

function Module:CreateChangelog()
	local frame = CreateFrame('Frame', 'DuffedUIChangeLog', UIParent)
	frame:SetPoint('CENTER')
	frame:SetSize(445, 430)  -- was 445, 245
	frame:SetTemplate('Transparent')
	frame:SetFrameStrata('TOOLTIP')

	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag('LeftButton')
	frame:SetScript('OnDragStart', frame.StartMoving)
	frame:SetScript('OnDragStop', frame.StopMovingOrSizing)
	frame:SetClampedToScreen(true)
	
	local icon = CreateFrame('Frame', nil, frame)
	icon:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 0, 3)
	icon:SetSize(20, 20)
	icon:SetTemplate('Transparent')
	icon.bg = icon:CreateTexture(nil, 'ARTWORK')
	icon.bg:Point('TOPLEFT', 2, -2)
	icon.bg:Point('BOTTOMRIGHT', -2, 2)
	icon.bg:SetTexture(C['media'].duffed)
	
	local title = CreateFrame('Frame', nil, frame)
	title:SetPoint('LEFT', icon, 'RIGHT', 3, 0)
	title:SetSize(422, 20)
	title:SetTemplate('Transparent')
	title.text = title:CreateFontString(nil, 'OVERLAY')
	title.text:SetPoint('CENTER', title, 0, -1)
	title.text:SetFont(C['media']['font'], 15)
	title.text:SetText('|cffC41F3BDuffedUI|r - ChangeLog ' .. D['Version'])

	local close = CreateFrame('Button', nil, frame, 'UIPanelButtonTemplate')
	close:SetPoint('BOTTOMRIGHT', frame, -5, 5)
	close:SetText(CLOSE)
	close:SetSize(95, 19)
	close:SetScript('OnClick', function()
		frame:Hide()
	end)
	close:StripTextures()
	close:SkinButton()
	close:Disable()
	frame.close = close

	local countdown = close:CreateFontString(nil, 'OVERLAY')
	countdown:SetFont(C['media']['font'], 12)
	countdown:SetPoint('LEFT', close.Text, 'RIGHT', 3, 0)
	countdown:SetTextColor(DISABLED_FONT_COLOR:GetRGB())
	frame.countdown = countdown
	
	D['CreateBtn']('bReport', frame, 65, 19, 'Bugreport', 'Bugreport')
	bReport:SetPoint('BOTTOMLEFT', frame, 5, 5)
	bReport:SetScript('OnClick', function(self) StaticPopup_Show('BUGREPORT') end)
	
	local offset = 4
	for i = 1, #ChangeLogData do
		local button = CreateFrame('Frame', 'Button'..i, frame)
		button:SetSize(375, 16)
		button:SetPoint('TOPLEFT', frame, 'TOPLEFT', 5, -offset)

		if i <= #ChangeLogData then
			local string = ModifiedString(GetChangeLogInfo(i))

			button.Text = button:CreateFontString(nil, 'OVERLAY')
			button.Text:SetFont(C['media']['font'], 11)
			button.Text:SetPoint('CENTER')
			button.Text:SetPoint('LEFT', 0, 0)
			button.Text:SetText(string)
			button.Text:SetWordWrap(true)
		end

		offset = offset + 16
	end
end

function Module:CountDown()
	self.time = self.time - 1

	if self.time == 0 then
		DuffedUIChangeLog.countdown:SetText(' ')
		DuffedUIChangeLog.close:Enable()
		self:CancelAllTimers()
	else
		DuffedUIChangeLog.countdown:SetText(format("(%s)", self.time))
	end
end

function Module:ToggleChangeLog()
	if not DuffedUIChangeLog then
		self:CreateChangelog()
	end

	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF or 857)

	local fadeInfo = {}
	fadeInfo.mode = 'IN'
	fadeInfo.timeToFade = 0.5
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	UIFrameFade(DuffedUIChangeLog, fadeInfo)

	self.time = 6
	self:CancelAllTimers()
	Module:CountDown()
	self:ScheduleRepeatingTimer('CountDown', 1)
end

function Module:CheckVersion()
	if not DuffedUIData['Version'] or (DuffedUIData['Version'] and DuffedUIData['Version'] ~= D['Version']) then
		DuffedUIData['Version'] = D['Version']
		Module:ToggleChangeLog()
	end
end

function Module:OnInitialize()
	D.Delay(6, function()
		Module:CheckVersion()
	end)
end