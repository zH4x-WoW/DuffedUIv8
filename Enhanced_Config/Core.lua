if not (Tukui or AsphyxiaUI or DuffedUI) then return end
local EC = unpack(select(2, ...))
local AddOnName = EC.Name
local Version = EC.Version
local LSM = LibStub('LibSharedMedia-3.0')
local AC, ACR, ACD, GUI = LibStub('AceConfig-3.0'), LibStub('AceConfigRegistry-3.0'), LibStub('AceConfigDialog-3.0'), LibStub('AceGUI-3.0')

local DEVELOPERS = {
	'Elv',
	'Tukz',
	'Hydrazine',
}

local DEVELOPER_STRING = ''

sort(DEVELOPERS, function(a,b) return a < b end)
for _, devName in pairs(DEVELOPERS) do
	DEVELOPER_STRING = DEVELOPER_STRING..'\n'..devName
end

EC.Options.args = {
	EC_Header = {
		order = 1,
		type = 'header',
		name = 'Version'..' '..Version,
		width = 'full',
	},
	credits = {
		type = 'group',
		name = 'Credits',
		order = -1,
			args = {
				text = {
					order = 1,
					type = 'description',
					name = 'Coding:\n'..DEVELOPER_STRING,
				},
			},
	},
},

AC:RegisterOptionsTable(AddOnName, EC.Options)
ACD:SetDefaultSize(AddOnName, 800, 600)
EC:RegisterChatCommand('ec', 'ToggleConfig')

function EC.OnConfigClosed(widget, event)
	if not EnhancedConfigPrivateDB[EC.ProfileKey] then EnhancedConfigPrivateDB[EC.ProfileKey] = {} end
	EnhancedConfigPrivateDB[EC.ProfileKey] = ElvUI[1].private
	EnhancedConfigGlobalDB = ElvUI[1].global
	EnhancedConfigDB = ElvUI[1].db
	ACD.OpenFrames[AddOnName] = nil
	GUI:Release(widget)
end

function EC:ToggleConfig()
	if not ACD.OpenFrames[AddOnName] then
		local Container = GUI:Create('Frame')
		ACD.OpenFrames[AddOnName] = Container
		Container:SetCallback('OnClose', EC.OnConfigClosed)
		ACD:Open(AddOnName, Container)
	end
	GameTooltip:Hide()
end
