local D, C, L = unpack(select(2, ...))

if C["datatext"].multistrike and C["datatext"].multistrike > 0 then
	local multistrike = GetMultistrike()

	local Stat = CreateFrame("Frame", "DuffedUIStatMultistrike")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].multistrike
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatMultistrikeText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].multistrike, Text)

	local function Update(self)
		Text:SetText(Stat.Color1 .. STAT_MULTISTRIKE .. ": " .. "|r" .. Stat.Color2 .. format("%.2f%%", multistrike) .. "|r ")
		self:SetAllPoints(Text)
	end
	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", Update)
	Update(Stat, 12)
end