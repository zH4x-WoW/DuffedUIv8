local D, C, L = unpack(select(2, ...))
if D.Class ~= "ROGUE" then return end

local texture = C["media"].normTex
local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
	[6] = {.70, .30, .30},
	[7] = {.70, .40, .30},
	[8] = {.60, .60, .30},
	[9] = {.40, .70, .30},
	[10] = {.30, .70, .30},
}

if not C["unitframes"].attached then D.ConstructEnergy("Energy", 216, 5) end

D.ConstructRessources = function(name, width, height)
	local ComboPoints = CreateFrame("Frame", name, UIParent)
	ComboPoints:Size(width, height)
	ComboPoints:CreateBackdrop()

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", name .. i, ComboPoints)
		ComboPoints[i]:Height(height)
		ComboPoints[i]:SetStatusBarTexture(texture)
		ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
		ComboPoints[i].bg = ComboPoints[i]:CreateTexture(nil, "BORDER")
		ComboPoints[i].bg:SetTexture(unpack(Colors[i]))
		if i == 1 then
			ComboPoints[i]:SetPoint("LEFT", ComboPoints)
			ComboPoints[i]:Width(44)
			ComboPoints[i].bg:SetAllPoints(ComboPoints[i])
		else
			ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
			ComboPoints[i]:Width(42)
			ComboPoints[i].bg:SetAllPoints(ComboPoints[i])
		end
		ComboPoints[i].bg:SetTexture(texture)
		ComboPoints[i].bg:SetAlpha(.15)
	end

	local Anticipation = CreateFrame("Frame")
	Anticipation:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
	Anticipation:RegisterEvent("PLAYER_LOGIN")

	function Anticipation:PLAYER_LOGIN()
		Anticipation:RegisterEvent("UNIT_AURA")
		AnticipationPoints = CreateFrame("Frame", "Anticipation" .. name, UIParent)

		for i = 6, 10 do
			ComboPoints[i] = CreateFrame("StatusBar", name .. i, AnticipationPoints)
			ComboPoints[i]:Height(height)
			ComboPoints[i]:SetStatusBarTexture(texture)
			ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
			if i == 6 then
				ComboPoints[i]:SetPoint("BOTTOM", _G["ComboPoints"..i - 5], "TOP", 0, 5)
				ComboPoints[i]:Width(44)
				ComboPoints[i]:CreateBackdrop()
			else
				ComboPoints[i]:SetPoint("BOTTOM", _G["ComboPoints"..i - 5], "TOP", 0, 5)
				ComboPoints[i]:Width(42)
				ComboPoints[i]:CreateBackdrop()
			end
			ComboPoints[i]:Hide()
		end
		DuffedUITarget:HookScript("OnShow", function() AnticipationPoints:Show() end)
		DuffedUITarget:HookScript("OnHide", function() AnticipationPoints:Hide() end)
	end

	function Anticipation:UNIT_AURA(unit)
		if unit ~= "player" then return end

		for i = 6, 10 do ComboPoints[i]:Hide() end
		local AntiStacks = select(4, UnitBuff("player", GetSpellInfo(115189)))
		if AntiStacks then 
			for i = 6, AntiStacks + 5 do ComboPoints[i]:Show() end
		end
	end

	if C["unitframes"].oocHide then
		ComboPoints:RegisterEvent("PLAYER_REGEN_DISABLED")
		ComboPoints:RegisterEvent("PLAYER_REGEN_ENABLED")
		ComboPoints:RegisterEvent("PLAYER_ENTERING_WORLD")
		ComboPoints:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then ComboPoints:SetAlpha(0) end
			end
		end)
	end
end