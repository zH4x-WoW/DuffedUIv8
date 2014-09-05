local D, C, L = unpack(select(2, ...)) 
--------------------------------------------------------------------
-- Mastery
----------------------------------------------------------------

if not C["datatext"].mastery == nil or C["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatMastery")
	Stat.Option = C.datatext.mastery
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatMasteryText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].mastery, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		if int < 0 then
			Text:SetText(Stat.Color1..STAT_MASTERY..":|r "..Stat.Color2..GetCombatRating(26).."|r")
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end