local D, C, L = unpack(select(2, ...))
if D.Class ~= "MONK" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout

if not C["unitframes"].attached then
	D.ConstructEnergy("Energy", 216, 5)
end

D.ConstructRessources = function(name, width, height)
	local Bar = CreateFrame("Frame", name, UIParent)
	Bar:Size(width, height)
	Bar:SetBackdrop(backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	Bar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		Bar[i] = CreateFrame("StatusBar", name .. i, Bar)
		Bar[i]:Height(5)
		Bar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			Bar[i]:Width(width / 6)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width(width / 6)
			Bar[i]:SetPoint("LEFT", Bar[i - 1], "RIGHT", 1, 0)
		end
	end
	Bar:CreateBackdrop()

	if C["unitframes"].oocHide then
		Bar:RegisterEvent("PLAYER_REGEN_DISABLED")
		Bar:RegisterEvent("PLAYER_REGEN_ENABLED")
		Bar:RegisterEvent("PLAYER_ENTERING_WORLD")
		Bar:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then
					Bar:SetAlpha(0)
				end
			end
		end)
	end
end