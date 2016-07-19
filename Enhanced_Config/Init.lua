if not (Tukui or AsphyxiaUI or DuffedUI) then return end
local A, C, L = unpack(Tukui or AsphyxiaUI or DuffedUI or ShestakUI)

local AddOnName, Engine = ...
local AddOn = LibStub('AceAddon-3.0'):NewAddon(AddOnName, 'AceConsole-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceHook-3.0')
local LSM = LibStub('LibSharedMedia-3.0')

Engine[1] = AddOn
Enhanced_Config = Engine

AddOn.A = A
AddOn.C = C
AddOn.MyClass = select(2, UnitClass('player'))
AddOn.ProfileKey = format('%s - %s', UnitName('player'), GetRealmName())

local Frame = CreateFrame('Frame')
Frame:RegisterEvent('PLAYER_ENTERING_WORLD')
Frame:Hide()
Frame:SetTemplate()

AddOn.Blank = LSM:Fetch('background', 'Solid')
AddOn.NormTex = AsphyxiaUI and LSM:Fetch('statusbar', 'Asphyxia') or LSM:Fetch('statusbar', 'Tukui')
AddOn.Font = LSM:Fetch('font', 'PT Sans Narrow Bold')
AddOn.PixelFont = AsphyxiaUI and LSM:Fetch('font', 'Homespun TT BRK') or LSM:Fetch('font', 'Visitor TT2 BRK')
AddOn.ActionBarFont = LSM:Fetch('font', 'Arial')
AddOn.UIScale = GetCVar('uiScale') or UIParent:GetScale()
AddOn.Mult = 768/strmatch(GetCVar('gxWindowedResolution'), '%d+x(%d+)')/AddOn.UIScale
AddOn.BackdropColor = { Frame:GetBackdropColor() }
AddOn.BorderColor = { Frame:GetBackdropBorderColor() }

if Tukui and tonumber(GetAddOnMetadata('Tukui', 'Version')) >= 16.00 then
	AddOn.DataTextFontSize = A['DataTexts'].Size
elseif AsphyxiaUI then
	AddOn.DataTextFontSize = 12
else
	AddOn.DataTextFontSize = C['datatext'].fontsize
end

AddOn.Name = _G[AddOnName]
AddOn.Title = select(2, GetAddOnInfo(AddOnName))
AddOn.Version = GetAddOnMetadata(AddOnName, 'Version')
AddOn.Noop = function() return end
AddOn.Options = {
	type = 'group',
	name = AddOn.Title,
	args = {},
}

-- EVERYTHING BELOW THIS LINE WILL CAUSE MASSIVE ERRORS IF FUCKED WITH. SO DON'T FUCK WITH IT.
----------------------------------------------------------------------------------------------
EnhancedConfigDB = {}
EnhancedConfigGlobalDB = {}
EnhancedConfigPrivateDB = {}
-- ElvUI Table Stubbing
ElvUI = {}
-- E
ElvUI[1] = LibStub('AceAddon-3.0'):GetAddon(AddOnName)
local E = ElvUI[1]

E.db = {}
E.global = {}
E.CreatedMovers = {}
E.myclass = AddOn.MyClass
E.ClassRole = {
	["PALADIN"] = {
		[1] = "Caster",
		[2] = "Tank",
		[3] = "Melee",
	},
	["PRIEST"] = "Caster",
	["WARLOCK"] = "Caster",
	["WARRIOR"] = {
		[1] = "Melee",
		[2] = "Melee",
		[3] = "Tank",
	},
	["HUNTER"] = "Melee",
	["SHAMAN"] = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Caster",
	},
	["ROGUE"] = "Melee",
	["MAGE"] = "Caster",
	["DEATHKNIGHT"] = {
		[1] = "Tank",
		[2] = "Melee",
		[3] = "Melee",
	},
	["DRUID"] = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Tank",
		[4] = "Caster"
	},
	["MONK"] = {
		[1] = "Tank",
		[2] = "Caster",
		[3] = "Melee",
	},
}

E.TexCoords = { .1, .9, .1, .9 }
E.mult = AddOn.Mult
E.resolution = GetCVar('gxWindowedResolution')
E.screenheight = tonumber(strmatch(E.resolution, '%d+x(%d+)'))
E.screenwidth = tonumber(strmatch(E.resolution, '(%d+)x+%d'))
E.DF = {}
E.DF['profile'] = {}
E.DF['global'] = {}
E.Options = AddOn.Options
E.privateVars = {}
E.privateVars['profile'] = {}
E.UIParent = UIParent
E.PixelMode = false
E.media = {}
E.media.backdropcolor = AddOn.BackdropColor
E.media.bordercolor = AddOn.BorderColor
E.media.blankTex = AddOn.Blank
E.noop = function() return end
-- Locale
ElvUI[2] = LibStub('AceLocale-3.0'):GetLocale(AddOnName)
-- V (Private)
ElvUI[3] = E.privateVars['profile']
-- P (Profile)
ElvUI[4] = E.DF['profile']
ElvUI[4].general = {}
ElvUI[4].general.backdropcolor = AddOn.BackdropColor
ElvUI[4].general.bordercolor = AddOn.BorderColor

-- Global
ElvUI[5] = E.DF['global']

function E:Delay(delay, func, ...)
	A.Delay(delay, func, ...)
end

local function FontTemplate(fs, font, fontSize, fontStyle)
	fs.font = font
	fs.fontSize = fontSize
	fs.fontStyle = fontStyle
	
	if not font then font = LSM:Fetch('font', 'PT Sans Narrow Bold') end
	if not fontSize then fontSize = 12 end
	if fontStyle == 'OUTLINE' and strlower(font):strfind('pixel') then
		if (fontSize > 10 and not fs.fontSize) then
			fontStyle = 'MONOCHROMEOUTLINE'
			fontSize = 10
		end
	end
	
	fs:SetFont(font, fontSize, fontStyle)
	if fontStyle then
		fs:SetShadowColor(0, 0, 0, 0.2)
	else
		fs:SetShadowColor(0, 0, 0, 1)
	end
	fs:SetShadowOffset((E.mult or 1), -(E.mult or 1))
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.FontTemplate then mt.FontTemplate = FontTemplate end
end

local handled = {['Frame'] = true}
local object = CreateFrame('Frame')
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end

function E:CreateMover(parent, name, frametext, overlay, snapoffset, postdrag, moverTypes)
	if not parent then return end
	local mover = CreateFrame("Frame", name, parent)
	mover:SetTemplate()
	mover:SetBackdropBorderColor(1, 0, 0)
	mover:SetFrameStrata("HIGH")
	mover:SetMovable(true)
	mover:SetFrameLevel(parent:GetFrameLevel() + 1)
	mover:SetWidth(parent:GetWidth())
	mover:SetHeight(parent:GetHeight())
	mover:Hide()
	mover:SetPoint(parent:GetPoint())
	mover:FontString('text', AddOn.Font, 12)
	mover.text:SetText(frametext)
	mover.text:SetPoint('CENTER')
	tinsert(A.AllowFrameMoving, mover)
	if not E.CreatedMovers[name] then E.CreatedMovers[name] = {} end
	E.CreatedMovers[name].mover = mover
	hooksecurefunc(A, 'MoveUIElements', function()
		if mover:IsShown() then
			mover:Hide()
		else
			mover:Show()
		end
	end)
end

function E:RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

function E:HexToRGB(hex)
	local rhex, ghex, bhex = sub(hex, 1, 2), sub(hex, 3, 4), sub(hex, 5, 6)
	return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
end

function E:CopyTable(currentTable, defaultTable)
	if type(currentTable) ~= 'table' then currentTable = {} end
	
	if type(defaultTable) == 'table' then
		for option, value in pairs(defaultTable) do
			if type(value) == 'table' then
				value = self:CopyTable(currentTable[option], value)
			end
			
			currentTable[option] = value			
		end
	end
	
	return currentTable
end

function table.copy(t, deep, seen)
    seen = seen or {}
    if t == nil then return nil end
    if seen[t] then return seen[t] end

    local nt = {}
    for k, v in pairs(t) do
        if deep and type(v) == 'table' then
            nt[k] = table.copy(v, deep, seen)
        else
            nt[k] = v
        end
    end
    setmetatable(nt, table.copy(getmetatable(t), deep, seen))
    seen[t] = nt
    return nt
end

local tcopy = table.copy

E['RegisteredModules'] = {}

function E:RegisterModule(name)
	if AddOn.initialized then
		self:GetModule(name):Initialize()
	else
		self['RegisteredModules'][#self['RegisteredModules'] + 1] = name
	end
end

function E:InitializeModules()	
	for _, module in pairs(E['RegisteredModules']) do
		local module = self:GetModule(module)
		if module.Initialize then
			local _, catch = pcall(module.Initialize, module)
			if catch and GetCVarBool('scriptErrors') == 1 then
				print(module, catch) --ScriptErrorsFrame_OnError(catch, false) -- Why does this break?
			end
		end
	end
end

StaticPopupDialogs['CONFIG_RL'] = {
	text = 'One or more of the changes you have made require a reload.',
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
}

function AddOn:OnEnable()
	E.db = tcopy(E.DF.profile, true)
	E.global = tcopy(E.DF.global, true)
	E.private = tcopy(E.privateVars.profile, true)
	E:CopyTable(E.private, EnhancedConfigPrivateDB[AddOn.ProfileKey])
	E:CopyTable(E.global, EnhancedConfigGlobalDB)
	E:CopyTable(E.db, EnhancedConfigDB)
end

Frame:SetScript('OnEvent', function(self, event)
	E:InitializeModules()
	local Anchor = IsAddOnLoaded('Tukui_ConfigUI') and GameMenuTukuiButtonOptions or IsAddOnLoaded('DuffedUI_ConfigUI') and GameMenuDuffedUIButtonOptions or GameMenuButtonUIOptions
	local ConfigButton = CreateFrame('Button', 'Enhanced_ConfigButton', GameMenuFrame, 'GameMenuButtonTemplate')
	ConfigButton:Size(Anchor:GetWidth(), Anchor:GetHeight())
	ConfigButton:Point('TOP', Anchor, 'BOTTOM', 0 , -1)
	ConfigButton:SetScript('OnClick', function() Enhanced_Config[1]:ToggleConfig() HideUIPanel(GameMenuFrame) end)
	ConfigButton:SetText(AddOn.Title)
	GameMenuFrame:Height(GameMenuFrame:GetHeight() + Anchor:GetHeight())
	GameMenuButtonKeybindings:ClearAllPoints()
	GameMenuButtonKeybindings:Point("TOP", ConfigButton, "BOTTOM", 0, -1)
	ConfigButton:SkinButton()
	self:UnregisterEvent(event)
end)