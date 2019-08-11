local AddOnName, Engine = ...

local AddOn = LibStub('AceAddon-3.0'):NewAddon(AddOnName, 'AceConsole-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceHook-3.0')
local About = LibStub:GetLibrary('LibAboutPanel', true)

Engine[1] = AddOn
Engine[2] = {}
Engine[3] = {}
Engine[4] = {}

_G[AddOnName] = Engine

AddOn.Title = GetAddOnMetadata(AddOnName, 'Title')
AddOn.Author = GetAddOnMetadata(AddOnName, 'Author')
AddOn.Version = GetAddOnMetadata(AddOnName, 'Version')
AddOn.Credits = GetAddOnMetadata(AddOnName, 'X-Credits')

ERR_NOT_IN_RAID = ''

AddOn.SetPerCharVariable = function(varName, value)
	_G [varName] = value
end

AddOn.ScanTooltip = CreateFrame('GameTooltip', 'DuffedUI_ScanTooltip', _G.UIParent, 'GameTooltipTemplate')
AddOn.Color = AddOn.Class == "PRIEST" and AddOn.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[AddOn.Class] or RAID_CLASS_COLORS[AddOn.Class])
AddOn.WowPatch, AddOn.WowBuild, AddOn.WowRelease, AddOn.TocVersion = GetBuildInfo()
AddOn.WowBuild = tonumber(AddOn.WowBuild)

AddOn.Noop = function()
	return
end

if (About) then
	AddOn.optionsFrame = About.new(nil, AddOnName)
end

AddOn.AddOns = {}
AddOn.AddOnVersion = {}
for i = 1, GetNumAddOns() do
	local Name = GetAddOnInfo(i)
	AddOn.AddOns[string.lower(Name)] = GetAddOnEnableState(AddOn.Name, Name) == 2 or false
	AddOn.AddOnVersion[string.lower(Name)] = GetAddOnMetadata(Name, 'Version')
end

function AddOn.ScanTooltipTextures(clean, grabTextures)
	local textures
	for i = 1, 10 do
		local tex = _G["DuffedUI_ScanTooltipTexture"..i]
		local texture = tex and tex:GetTexture()
		if texture then
			if grabTextures then
				if not textures then
					textures = {}
				end
				textures[i] = texture
			end

			if clean then
				tex:SetTexture()
			end
		end
	end

	return textures
end

--[[

	The code below works around a issue of the WoD Beta Client 6.0.2 b18934
	on OS X 10.10 where data stored in 'SavedVariablesPerCharacter' variables
	is not reliably restored after exiting and reentering the game if the
	player's name contains 'umlauts'.

	The corresponding bug report can be found under:

		http://eu.battle.net/wow/en/forum/topic/12206010700

	To enable this workaround enter the followin commands into the chat window:

		/script DuffedUIData.usePerCharData = true
		/reload

	The code can be removed once the client issue has been fixed. Only the
	'SetPerCharVariable' part above should stay in for compatibility
	(otherwise all uses of the function must be replaced with an
	assignment statement again).

--]]

local DuffedUIOnVarsLoaded = CreateFrame('Frame')
DuffedUIOnVarsLoaded:RegisterEvent('VARIABLES_LOADED')
DuffedUIOnVarsLoaded:SetScript('OnEvent', function(self, event)
	self:UnregisterEvent('VARIABLES_LOADED')

	if DuffedUIData == nil then
		DuffedUIData = {}
	end

	if DuffedUIData.usePerCharData then
		local playerName = UnitName('player') .. '@' .. GetRealmName()

		if DuffedUIData.perCharData ~= nil and DuffedUIData.perCharData[playerName] ~= nil then
			local pcd = DuffedUIData.perCharData[playerName]

			if DuffedUIDataPerChar == nil then
				DuffedUIDataPerChar = pcd.DuffedUIDataPerChar
			end
			if ClickCast == nil then
				ClickCast = pcd.ClickCast
			end
			if ImprovedCurrency == nil then
				ImprovedCurrency = pcd.ImprovedCurrency
			end
		end

		local SetPerCharVariable = function(varName, value)
			if DuffedUIData.perCharData == nil then
				DuffedUIData.perCharData = {}
			end

			if DuffedUIData.perCharData[playerName] == nil then
				DuffedUIData.perCharData[playerName] = {}
			end

			local pcd = DuffedUIData.perCharData[playerName]

			_G [varName] = value
			pcd [varName] = value
		end

		DuffedUI[1].SetPerCharVariable = SetPerCharVariable
	end
end)
