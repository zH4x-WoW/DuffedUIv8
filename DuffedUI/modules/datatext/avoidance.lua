local D, C, L = unpack(select(2, ...)) 

if C["datatext"].avd and C["datatext"].avd > 0 then
	local dodge, parry, block, avoidance, targetlv, playerlv, basemisschance, leveldifference
	local Stat = CreateFrame("Frame", "DuffedUIStatAvoidance")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C["datatext"].avd
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatAvoidanceText", "OVERLAY")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].avd, Text)

	local targetlv, playerlv

	local function Update(self)
		local format = string.format
		targetlv, playerlv = UnitLevel("target"), UnitLevel("player")
		local basemisschance, leveldifference, avoidance
		
		if targetlv == -1 then
			basemisschance = (5 - (3*.2))  --Boss Value
			leveldifference = 3
		elseif targetlv > playerlv then
			basemisschance = (5 - ((targetlv - playerlv)*.2)) --Mobs above player level
			leveldifference = (targetlv - playerlv)
		elseif targetlv < playerlv and targetlv > 0 then
			basemisschance = (5 + ((playerlv - targetlv) * .2))
			leveldifference = (targetlv - playerlv)
		else
			basemisschance = 5
			leveldifference = 0
		end
		if D.MyRace == "NightElf" then basemisschance = basemisschance + 2 end

		if leveldifference >= 0 then
			dodge = (GetDodgeChance() - leveldifference * .2)
			parry = (GetParryChance() - leveldifference * .2)
			block = (GetBlockChance() - leveldifference * .2)
			avoidance = (dodge + parry + block)
			Text:SetText(Stat.Color1 .. L["dt"]["avd"] .. "|r" .. Stat.Color2 .. format("%.2f", avoidance) .. "|r")
		else
			dodge = (GetDodgeChance() + abs(leveldifference * .2))
			parry = (GetParryChance() + abs(leveldifference * .2))
			block = (GetBlockChance() + abs(leveldifference * .2))
			avoidance = (dodge + parry + block)
			Text:SetText(Stat.Color1 .. L["dt"]["avd"] .. "|r" .. Stat.Color2 .. format("%.2f", avoidance) .. "|r")
		end
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("PLAYER_TARGET_CHANGED")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnEnter", function(self)
		if not C["datatext"].ShowInCombat then
			if InCombatLockdown() then return end
		end

		local anchor, yoff = D.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(self, anchor, 0, yoff)
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, D.mult)
		GameTooltip:ClearLines()
		if targetlv > 1 then
			GameTooltip:AddDoubleLine(L["dt"]["avoidance"] .. " (" .. L["dt"]["lvl"] .. " " .. targetlv ..")")
		elseif targetlv == -1 then
			GameTooltip:AddDoubleLine(L["dt"]["avoidance"] .. " (" .. BOSS .. ")")
		else
			GameTooltip:AddDoubleLine(L["dt"]["avoidance"] .." (" .. L["dt"]["lvl"] .. " " .. targetlv .. ")")
		end
		GameTooltip:AddDoubleLine(STAT_DODGE, format("%.2f", dodge) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(STAT_PARRY, format("%.2f", parry) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(STAT_DODGE, format("%.2f", block) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end