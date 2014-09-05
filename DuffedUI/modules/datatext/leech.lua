local D, C, L = unpack(select(2, ...))

if C["datatext"].leech and C["datatext"].leech > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatLeech")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].leech
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatLeechText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].leech, Text)

	local function Update(self)
		leech = GetCombatRating(17)
		Text:SetText(Stat.Color2 .. D.CommaValue(leech) .. "|r " .. Stat.Color1 .. STAT_LIFESTEAL .. "|r")
		self:SetAllPoints(Text)
	end
	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", Update)
	Update(Stat, 17)
end