local D, C, L = unpack(select(2, ...))

local resolution = GetCurrentResolution() > 0 and select(GetCurrentResolution(), GetScreenResolutions()) or nil
local window = Display_DisplayModeDropDown:windowedmode()
local fullscreen = Display_DisplayModeDropDown:fullscreenmode()

D['Dummy'] = function() return end
D['MyName'] = select(1, UnitName('player'))
D['Class'] = select(2, UnitClass('player'))
D['MyRace'] = select(2, UnitRace('player'))
D['Faction'], D['LocalizedFaction'] = UnitFactionGroup("player")
D['Level'] = UnitLevel('player')
D['MyRealm'] = GetRealmName()
D['Client'] = GetLocale()
D['Resolution'] = resolution or (window and GetCVar('gxWindowedResolution')) or GetCVar('gxFullscreenResolution')
D['ScreenHeight'] = tonumber(string.match(D['Resolution'], '%d+x(%d+)'))
D['ScreenWidth'] = tonumber(string.match(D['Resolution'], '(%d+)x+%d'))
D['Version'] = GetAddOnMetadata('DuffedUI', 'Version')
D['VersionNumber'] = tonumber(D['Version'])
D['Patch'], D['BuildText'], D['ReleaseDate'], D['Toc'] = GetBuildInfo()
D['build'] = tonumber(D['BuildText'])
D['InfoLeftRightWidth'] = 370
D['IconCoord'] = {.08, .92, .08, .92}
D['Guild'] = select(1, GetGuildInfo('player'))

D['Credits'] = {
	'Dejablue',
	'Tukz',
	'Hydra',
	'Elv',
	'Azilroka',
	'Caith',
	'Ishtara',
	'Hungtar',
	'Tulla',
	'P3lim',
	'Alza',
	'Roth',
	'Tekkub',
	'Shestak',
	'Caellian',
	'Haleth',
	'Nightcracker',
	'Haste',
	'humfras aka Shinizu',
	'Hizuro',
	'Duugu',
	'Phanx',
	'ObbleYeah',
}

D['DuffedCredits'] = {
	'Chrisey',
	'Rolfman',
	'Lhunephel',
	'Elenarda',
	'fiffzek',
	'Skunkzord',
	'exodors',
	'Voodoom',
	'Lock85',
	'EviReborn',
	'SidDii',
}