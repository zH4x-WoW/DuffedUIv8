local D, C, L = unpack(select(2, ...))
if D.Class ~= "PRIEST" then return end

local texture = C["media"].normTex
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

if not C["unitframes"].attached then
	D.ConstructEnergy("Mana", 216, 5)
end

D.ConstructRessources = function(name, width, height)
	local pb = CreateFrame("Frame", name, UIParent)
	pb:Size(width, height)
	pb:SetBackdrop(backdrop)
	pb:SetBackdropColor(0, 0, 0)
	pb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		pb[i] = CreateFrame("StatusBar", name .. i, pb)
		pb[i]:Height(height)
		pb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			pb[i]:Width(width / 5)
			pb[i]:SetPoint("LEFT", pb, "LEFT", 0, 0)
		else
			pb[i]:Width((width / 5) - 1)
			pb[i]:SetPoint("LEFT", pb[i - 1], "RIGHT", 1, 0)
		end
	end
	pb:CreateBackdrop()

	if C["unitframes"].oocHide then
		pb:RegisterEvent("PLAYER_REGEN_DISABLED")
		pb:RegisterEvent("PLAYER_REGEN_ENABLED")
		pb:RegisterEvent("PLAYER_ENTERING_WORLD")
		pb:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then
					pb:SetAlpha(0)
				end
			end
		end)
	end
end