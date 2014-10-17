local D, C, L = unpack(select(2, ...)) 

if C["datatext"].armor and C["datatext"].armor > 0 then
	local effectiveArmor

	local Stat = CreateFrame("Frame", "DuffedUIStatArmor")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].armor
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatArmorText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].armor, Text)

	local function Update(self)
		effectiveArmor = select(2, UnitArmor("player"))
		Text:SetText(Stat.Color2 .. (effectiveArmor) .. "|r " .. Stat.Color1 .. ARMOR .. "|r")
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not C["datatext"].ShowInCombat then
			if InCombatLockdown() then return end
		end

		local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)	
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(L["dt"]["mitigation"])
		local lv = 83
		local mitigation = (effectiveArmor/(effectiveArmor+(467.5*lv-22167.5)))
		for i = 1, 4 do
			local format = string.format
			if mitigation > .75 then
				mitigation = .75
			end
			GameTooltip:AddDoubleLine(lv,format("%.2f", mitigation*100) .. "%",1,1,1)
			lv = lv - 1
		end
		if UnitLevel("target") > 0 and UnitLevel("target") < UnitLevel("player") then
			if mitigation > .75 then
				mitigation = .75
			end
			GameTooltip:AddDoubleLine(UnitLevel("target"),format("%.2f", mitigation*100) .. "%",1,1,1)
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end