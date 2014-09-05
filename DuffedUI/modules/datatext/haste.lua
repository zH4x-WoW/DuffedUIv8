local D, C, L = unpack(select(2, ...)) 

if C["datatext"].haste and C["datatext"].haste > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatHaste")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].haste
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatHasteText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].haste, Text)

	local int = 1

	local function Update(self, t)
		local spellhaste = UnitSpellHaste("player")
		local rangedhaste = GetRangedHaste()
		local attackhaste = GetMeleeHaste()

		if attackhaste > spellhaste and select(2, UnitClass("Player")) ~= "HUNTER" then
			haste = attackhaste
		elseif select(2, UnitClass("Player")) == "HUNTER" then
			haste = rangedhaste
		else
			haste = spellhaste
		end

		int = int - t
		if int < 0 then
			Text:SetText(Stat.Color2 .. format("%.2f", haste) .. "% |r" .. Stat.Color1 .. STAT_HASTE .."|r")
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end
