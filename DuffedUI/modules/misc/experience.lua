local D, C, L = unpack(select(2, ...))

local barHeight, barWidth = 10, 250
local font, fontsize, flags = C["media"].font, 11, "THINOUTLINE"
local barTex = C["media"].normTex
local flatTex = C["media"].normTex
local class = D.myclass
local color = RAID_CLASS_COLORS[class]
local FactionInfo = {
	[1] = {{ 170/255, 70/255,  70/255 }, "Hated", "FFaa4646"},
	[2] = {{ 170/255, 70/255,  70/255 }, "Hostile", "FFaa4646"},
	[3] = {{ 170/255, 70/255,  70/255 }, "Unfriendly", "FFaa4646"},
	[4] = {{ 200/255, 180/255, 100/255 }, "Neutral", "FFc8b464"},
	[5] = {{ 75/255,  175/255, 75/255 }, "Friendly", "FF4baf4b"},
	[6] = {{ 75/255,  175/255, 75/255 }, "Honored", "FF4baf4b"},
	[7] = {{ 75/255,  175/255, 75/255 }, "Revered", "FF4baf4b"},
	[8] = {{ 155/255,  255/255, 155/255 }, "Exalted","FF9bff9b"},
}

function CommaValue(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function colorize(r)
	return FactionInfo[r][3]
end

local function IsMaxLevel()
	if UnitLevel("player") == MAX_PLAYER_LEVEL then
		return true
	end
end

local backdrop = CreateFrame("Frame", "Experience_Backdrop", UIParent)
backdrop:Size(barWidth, barHeight)
backdrop:SetPoint("TOP", UIParent, "TOP", -0, -32)
backdrop:SetBackdropColor(C["general"].backdropcolor)
backdrop:SetBackdropBorderColor(C["general"].backdropcolor)
backdrop:CreateBackdrop()

local xpBar = CreateFrame("StatusBar",  "Experience_xpBar", backdrop, "TextStatusBar")
xpBar:SetWidth(barWidth)
xpBar:SetHeight(GetWatchedFactionInfo() and (barHeight) or barHeight)
xpBar:SetPoint("TOP", backdrop,"TOP", 0, 0)
xpBar:SetStatusBarTexture(barTex)
if C["general"].classcolor then xpBar:SetStatusBarColor(color.r, color.g, color.b) else xpBar:SetStatusBarColor(31/255, 41/255, 130/255) end

local restedxpBar = CreateFrame("StatusBar", "Experience_restedxpBar", backdrop, "TextStatusBar")
restedxpBar:SetHeight(GetWatchedFactionInfo() and (barHeight) or barHeight)
restedxpBar:SetWidth(barWidth)
restedxpBar:SetPoint("TOP", backdrop, "TOP", 0, 0)
restedxpBar:SetStatusBarTexture(barTex)
restedxpBar:Hide()

local repBar = CreateFrame("StatusBar", "Experience_repBar", backdrop, "TextStatusBar")
repBar:SetWidth(barWidth)
repBar:SetHeight(IsMaxLevel() and barHeight - 0 or 0)
repBar:SetPoint("BOTTOM", backdrop, "BOTTOM", 0, 0)
repBar:SetStatusBarTexture(barTex)

local mouseFrame = CreateFrame("Frame", "Experience_mouseFrame", backdrop)
mouseFrame:SetAllPoints(backdrop)
mouseFrame:EnableMouse(true)

local Text = mouseFrame:CreateFontString("mouseFrame_Text", "OVERLAY")
Text:SetFont(font, fontsize, flags)
Text:SetPoint("CENTER", mouseFrame, "CENTER", 0, 0)

backdrop:SetFrameLevel(0)
restedxpBar:SetFrameLevel(1)
repBar:SetFrameLevel(2)
xpBar:SetFrameLevel(2)
mouseFrame:SetFrameLevel(3)

local function GetPlayerXP()
	return UnitXP("player"), UnitXPMax("player")
end

local function updateStatus()
	local XP, maxXP = GetPlayerXP()
	local restXP = GetXPExhaustion()
	local percXP = floor(XP / maxXP * 100)

	if IsMaxLevel() then
		xpBar:Hide()
		restedxpBar:Hide()
		repBar:SetHeight(barHeight)
		if not GetWatchedFactionInfo() then
			backdrop:Hide()
		else
			backdrop:Show()
		end
	else
		xpBar:SetMinMaxValues(min(0, XP), maxXP)
		xpBar:SetValue(XP)

		if restXP then
			Text:SetText(format("%s/%s (%s%%|cffb3e1ff+%d%%|r)", D.ShortValue(XP), D.ShortValue(maxXP), percXP, restXP / maxXP * 100))
			restedxpBar:Show()
			local r, g, b = color.r, color.g, color.b
			restedxpBar:SetStatusBarColor(r, g, b, .40)
			restedxpBar:SetMinMaxValues(min(0, XP), maxXP)
			restedxpBar:SetValue(XP + restXP)
		else
			restedxpBar:Hide()
			Text:SetText(format("%s/%s (%s%%)", D.ShortValue(XP), D.ShortValue(maxXP), percXP))
		end

		if GetWatchedFactionInfo() then
			xpBar:SetHeight(barHeight)
			restedxpBar:SetHeight(barHeight)
			repBar:SetHeight(2)
			repBar:Show()
		else
			xpBar:SetHeight(barHeight)
			restedxpBar:SetHeight(barHeight)
			repBar:Hide()
		end
	end

	if GetWatchedFactionInfo() then
		local name, rank, minRep, maxRep, value = GetWatchedFactionInfo()
		repBar:SetMinMaxValues(minRep, maxRep)
		repBar:SetValue(value)
		repBar:SetStatusBarColor(unpack(FactionInfo[rank][1]))
		Text:SetText(format("%d / %d (%d%%)", value-minRep, maxRep-minRep, (value - minRep)/(maxRep - minRep) * 100))
	end

	mouseFrame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(mouseFrame, "ANCHOR_BOTTOMLEFT", -3, barHeight)
		GameTooltip:ClearLines()
		if not IsMaxLevel() then
			GameTooltip:AddLine("Experience:")
			GameTooltip:AddLine(string.format('XP: %s/%s (%d%%)', CommaValue(XP), CommaValue(maxXP), (XP / maxXP) * 100))
			GameTooltip:AddLine(string.format('Remaining: %s', CommaValue(maxXP - XP)))
			if restXP then
				GameTooltip:AddLine(string.format('|cffb3e1ffRested: %s (%d%%)', CommaValue(restXP), restXP / maxXP * 100))
			end
		end
		if GetWatchedFactionInfo() then
			local name, rank, min, max, value = GetWatchedFactionInfo()
			if not IsMaxLevel() then GameTooltip:AddLine(" ") end
			GameTooltip:AddLine(string.format('Reputation: %s', name))
			GameTooltip:AddLine(string.format('Standing: |c'..colorize(rank)..'%s|r', FactionInfo[rank][2]))
			GameTooltip:AddLine(string.format('Rep: %s/%s (%d%%)', CommaValue(value - min), CommaValue(max - min), (value - min)/(max - min) * 100))
			GameTooltip:AddLine(string.format('Remaining: %s', CommaValue(max - value)))
		end
		GameTooltip:Show()
	end)
	mouseFrame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
end

local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_XP_UPDATE")
frame:RegisterEvent("UPDATE_EXHAUSTION")
frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", updateStatus)