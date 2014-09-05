local D, C, L = unpack(select(2, ...))

--------------------------------------------------------------------
-- Honor
--------------------------------------------------------------------
if C["datatext"].honor and C["datatext"].honor > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatHonor")

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatHonorText", "LOW")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].honor, Text)

	local function OnEvent(self, event)
		local _, amount, _ = GetCurrencyInfo(392)
		Text:SetText("Honor: "..D.panelcolor..amount)
	end

	-- Make sure the panel gets displayed when the player logs in
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Make sure the panel updates when your amount of honor changes
	Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")

	Stat:SetScript("OnEvent", OnEvent)
end

--------------------------------------------------------------------
-- Honorable Kills
--------------------------------------------------------------------
if C["datatext"].honorablekills and C["datatext"].honorablekills > 0 then
	local Stat = CreateFrame("Frame", "DuffedUIStatHK")

	local font = D.Font(C["font"].datatext)
	local Text  = Stat:CreateFontString("DuffedUIStatHKText", "LOW")
	Text:SetFontObject(font)
	D.DataTextPosition(C["datatext"].honorablekills, Text)

	local function OnEvent(self, event)
		Text:SetText("Kills: "..D.panelcolor..GetPVPLifetimeStats())
	end

	-- Make sure the panel gets displayed when the player logs in
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Make sure the panel updates when your amount of honorable kills changes
	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")

	Stat:SetScript("OnEvent", OnEvent)
end