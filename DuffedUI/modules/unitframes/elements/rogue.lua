local D, C, L = unpack(select(2, ...))
if D.Class ~= "ROGUE" then return end

local texture = C["media"].normTex
local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
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

	local AnticipationBar = CreateFrame("Frame", name .. "AnticipationBar", UIParent)
	AnticipationBar:Point("BOTTOM", ComboPoints, "TOP", 0, 5)
	AnticipationBar:Size(width, height)
	AnticipationBar:CreateBackdrop()

	for i = 1, 5 do
		AnticipationBar[i] = CreateFrame("StatusBar", name .. "AnticipationBar" .. i, AnticipationBar)
		AnticipationBar[i]:Height(height)
		AnticipationBar[i]:SetStatusBarTexture(texture)
		AnticipationBar[i]:SetStatusBarColor(unpack(Colors[i]))
		AnticipationBar[i].bg = AnticipationBar[i]:CreateTexture(nil, "BORDER")
		AnticipationBar[i].bg:SetTexture(unpack(Colors[i]))
		if i == 1 then
			AnticipationBar[i]:Point("LEFT", AnticipationBar, "LEFT", 0, 0)
			AnticipationBar[i]:Width(44)
			AnticipationBar[i].bg:SetAllPoints(AnticipationBar[i])
		else
			AnticipationBar[i]:Point("LEFT", AnticipationBar[i-1], "RIGHT", 1, 0)
			AnticipationBar[i]:Width(42)
			AnticipationBar[i].bg:SetAllPoints(AnticipationBar[i])
		end
		AnticipationBar[i].bg:SetTexture(texture)
		AnticipationBar[i].bg:SetAlpha(.15)
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

		AnticipationBar:RegisterEvent("PLAYER_REGEN_DISABLED")
		AnticipationBar:RegisterEvent("PLAYER_REGEN_ENABLED")
		AnticipationBar:RegisterEvent("PLAYER_ENTERING_WORLD")
		AnticipationBar:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then AnticipationBar:SetAlpha(0) end
			end
		end)
	end
end