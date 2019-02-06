local D, C, L = unpack(select(2, ...))

if not C['datatext']['crit'] or C['datatext']['crit'] == 0 then return end

local Stat = CreateFrame('Frame', 'DuffedUIStatCrit')
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext']['crit']
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text  = Stat:CreateFontString('DuffedUIStatCritText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['crit'], Text)

local int = 1

local function Update(self, t)
	int = int - t
	local meleecrit = GetCritChance()
	local spellcrit = GetSpellCritChance(1)
	local rangedcrit = GetRangedCritChance()
	local CritChance
	if spellcrit > meleecrit then
		CritChance = spellcrit
	elseif select(2, UnitClass('Player')) == 'HUNTER' then
		CritChance = rangedcrit
	else
		CritChance = meleecrit
	end
	if int < 0 then
		Text:SetText(Stat.Color2..format('%.2f', CritChance) .. '%|r'.. Stat.Color1 .. L['dt']['crit'] ..'|r')
		int = 1
	end
end

Stat:SetScript('OnUpdate', Update)
Update(Stat, 10)