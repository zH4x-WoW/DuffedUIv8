local D, C, L = unpack(select(2, ...))
if D.Class ~= "WARLOCK" then return end

local texture = C["media"].normTex
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

if not C["unitframes"].attached then D.ConstructEnergy("Energy", 216, 5) end

D.ConstructRessources = function(name, width, height)
	local wb = CreateFrame("Frame", name, UIParent)
	wb:Size(width, height)
	wb:SetBackdrop(backdrop)
	wb:SetBackdropColor(0, 0, 0)
	wb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		wb[i] = CreateFrame("StatusBar", name..i, wb)
		wb[i]:Height(height)
		wb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			wb[i]:Width(width / 4)
			wb[i]:SetPoint("LEFT", wb, "LEFT", 0, 0)
		else
			wb[i]:Width(width / 4)
			wb[i]:SetPoint("LEFT", wb[i - 1], "RIGHT", 1, 0)
		end
		wb[i].bg = wb[i]:CreateTexture(nil, "ARTWORK")
	end
	wb:CreateBackdrop()

	if C["unitframes"].oocHide then
		wb:RegisterEvent("PLAYER_REGEN_DISABLED")
		wb:RegisterEvent("PLAYER_REGEN_ENABLED")
		wb:RegisterEvent("PLAYER_ENTERING_WORLD")
		wb:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then wb:SetAlpha(0) end
			end
		end)
	end
end