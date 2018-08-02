local D, C, L = unpack(select(2, ...)) 
-- Mastery

if not C['datatext'].mastery or C['datatext'].mastery == 0 then return end

local Stat = CreateFrame('Frame', 'DuffedUIStatMastery')
Stat.Color1 = D['RGBoHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBoHex'](unpack(C['media']['datatextcolor2']))

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text  = Stat:CreateFontString('DuffedUIStatMasteryText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['mastery'], Text)

local int = 1

local function Update(self, t)
	int = int - t
	if int < 0 then
		Text:SetText(Stat.Color1..STAT_MASTERY..':|r '..Stat.Color2..GetCombatRating(26)..'|r')
		int = 1
	end
end

Stat:SetScript('OnUpdate', Update)
Update(Stat, 10)