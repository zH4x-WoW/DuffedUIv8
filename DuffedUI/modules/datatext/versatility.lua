local D, C, L = unpack(select(2, ...))

if C["datatext"].versatility and C["datatext"].versatility > 0 then
	local vDB = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE)
	local vDTR = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN)

	local font = D.Font(C["font"].datatext)
	local Stat = CreateFrame("Frame", "DuffedUIStatVersatility")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].versatility
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local Text  = Stat:CreateFontString("DuffedUIStatVersatilityText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].versatility, Text)

	local function Update(self)
		Text:SetText(Stat.Color1 .. STAT_VERSATILITY .. ": " .. "|r" .. Stat.Color2 .. format("%.2f%%", vDB) .. "|r ")
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
		GameTooltip:AddLine(STAT_VERSATILITY)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(DAMAGE .. " & " .. SHOW_COMBAT_HEALING .. ":", format("%.2f%%", vDB), 1, 1, 1)
		GameTooltip:AddDoubleLine(COMBAT_TEXT_SHOW_RESISTANCES_TEXT .. ":", format("%.2f%%", vDTR), 1, 1, 1)
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnEvent", Update)
	Update(Stat, 29)
end