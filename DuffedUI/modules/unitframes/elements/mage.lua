local D, C, L = unpack(select(2, ...))
if D.Class ~= "MAGE" then return end

local texture = C["media"].normTex
local font, fontheight, fontflag = C["media"].font, 12, "THINOUTLINE"
local layout = C["unitframes"].layout

if not C["unitframes"].attached then D.ConstructEnergy("Mana", 216, 5) end

D.ConstructRessources = function(name, name2, width, height)
	local mb = CreateFrame("Frame", name, UIParent)
	mb:Size(width, height)
	mb:SetBackdrop(backdrop)
	mb:SetBackdropColor(0, 0, 0)
	mb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		mb[i] = CreateFrame("StatusBar", name .. i, mb)
		mb[i]:Height(height)
		mb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			mb[i]:Width(width / 4)
			mb[i]:SetPoint("LEFT", mb, "LEFT", 0, 0)
		else
			mb[i]:Width((width / 4) - 1)
			mb[i]:SetPoint("LEFT", mb[i - 1], "RIGHT", 1, 0)
		end
		mb[i].bg = mb[i]:CreateTexture(nil, 'ARTWORK')
	end
	mb:CreateBackdrop()

	if C["unitframes"].runeofpower then
		local rp = CreateFrame("Frame", name2, UIParent)
		rp:Size(width, height)
		rp:SetBackdrop(backdrop)
		rp:SetBackdropColor(0, 0, 0)
		rp:SetBackdropBorderColor(0, 0, 0)
		for i = 1, 2 do
			rp[i] = CreateFrame("StatusBar", "DuffedUIRunePower"..i, rp)
			rp[i]:Height(5)
			rp[i]:SetStatusBarTexture(texture)
			if i == 1 then
				rp[i]:Width(width / 2)
				rp[i]:SetPoint("LEFT", rp, "LEFT", 0, 0)
			else
				rp[i]:Width(width / 2)
				rp[i]:SetPoint("LEFT", rp[i - 1], "RIGHT", 1, 0)
			end
			rp[i].bg = rp[i]:CreateTexture(nil, 'ARTWORK')
		end
		if layout == 1 or layout == 3 then rp:CreateBackdrop() end
	end
	
	if C["unitframes"].oocHide then
		mb:RegisterEvent("PLAYER_REGEN_DISABLED")
		mb:RegisterEvent("PLAYER_REGEN_ENABLED")
		mb:RegisterEvent("PLAYER_ENTERING_WORLD")
		mb:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then mb:SetAlpha(0) end
			end
		end)

		rp:RegisterEvent("PLAYER_REGEN_DISABLED")
		rp:RegisterEvent("PLAYER_REGEN_ENABLED")
		rp:RegisterEvent("PLAYER_ENTERING_WORLD")
		rp:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then rp:SetAlpha(0) end
			end
		end)
	end
end