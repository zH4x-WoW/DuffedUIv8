local D, C, L = unpack(select(2, ...))

if C["datatext"].bonusarmor and C["datatext"].bonusarmor > 0 then
	local _, effectiveArmor, _, _, _ = UnitArmor("player")
	local armorReduction = PaperDollFrame_GetArmorReduction(effectiveArmor, UnitLevel("player"))
	local bonusArmor, _ = UnitBonusArmor("player")

	local Stat = CreateFrame("Frame", "DuffedUIStatBonusArmor")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].bonusarmor
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatBonusArmorText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].bonusarmor, Text)

	local function Update(self)
		Text:SetText(Stat.Color2.. bonusArmor .."|r "..Stat.Color1 .. STAT_BONUS_ARMOR .. "|r")
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEnter", function(self)
		if not C["datatext"].ShowInCombat then
			if InCombatLockdown() then return end
		end

		local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)	
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(STAT_BONUS_ARMOR)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(COMBAT_TEXT_SHOW_RESISTANCES_TEXT .. ":", format("%.2f%%", armorReduction), 1, 1, 1)
		GameTooltip:AddDoubleLine(ATTACK_POWER_TOOLTIP .. ":", bonusArmor,  1, 1, 1)
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnEvent", Update)
end