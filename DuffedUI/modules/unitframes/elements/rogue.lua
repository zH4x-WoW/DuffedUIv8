local D, C, L = unpack(select(2, ...))
if D.Class ~= "ROGUE" then return end

local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

if not C["unitframes"].attached then
	D.ConstructEnergy("Energy", 216, 5)
end

D.ConstructRessources = function(name, width, height)
	local ComboPoints= CreateFrame("Frame", name, UIParent)
	ComboPoints:Size(width, height)
	ComboPoints:CreateBackdrop()
	--ComboPoints:SetBackdrop(backdrop)
	--ComboPoints:SetBackdropColor(0, 0, 0)
	--ComboPoints:SetBackdropBorderColor(0, 0, 0, 0)

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
				if not InCombatLockdown() then
					ComboPoints:SetAlpha(0)
				end
			end
		end)
	end
end