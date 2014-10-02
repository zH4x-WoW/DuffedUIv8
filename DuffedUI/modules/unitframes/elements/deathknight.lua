local D, C, L = unpack(select(2, ...))
if D.Class ~= "DEATHKNIGHT" then return end

local texture = C["media"].normTex
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"
local RuneColors = {
		{ 0.69, 0.31, 0.31 }, -- blood
		{ 0.33, 0.59, 0.33 }, -- unholy
		{ 0.31, 0.45, 0.63 }, -- frost
		{ 0.84, 0.75, 0.65 }, -- death
		{ 0, 0.82, 1 }, -- runic power
	}
local Runes = {}
local RuneMap = { 1, 2, 3, 4, 5, 6 }

if not C["unitframes"].attached then D.ConstructEnergy("RunicPower", 216, 5) end

D.ConstructRessources = function(name, width, height)
	Runes = CreateFrame("Frame", name, UIParent)
	Runes:SetSize(width, height)
	Runes:CreateBackdrop()
	if not C["unitframes"].attached then Runes:SetParent(DuffedUIPetBattleHider) end

	for i = 1, 6 do
		local rune = CreateFrame("StatusBar", "Rune"..i, Runes)
		rune:SetStatusBarTexture(texture)
		rune:SetStatusBarColor(unpack(RuneColors[math.ceil(RuneMap[i] / 2) ]))
		rune:SetMinMaxValues(0, 10)
		rune:SetHeight(height)

		if i == 1 then
			rune:SetWidth(36)
			rune:SetPoint("LEFT", Runes, "LEFT", 0, 0)
		else
			rune:SetWidth(35)
			rune:SetPoint("LEFT", Runes[i - 1], "RIGHT", 1, 0)
		end

		tinsert(Runes, rune)
	end

	local function UpdateRune(id, start, duration, finished)
		local rune = Runes[id]
		rune:SetStatusBarColor(unpack(RuneColors[GetRuneType(RuneMap[id])]))
		rune:SetMinMaxValues(0, duration)

		if finished then rune:SetValue(duration) else rune:SetValue(GetTime() - start) end
	end

	local OnUpdate = CreateFrame("Frame")
	OnUpdate.TimeSinceLastUpdate = 0
	local updateFunc = function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed

		if self.TimeSinceLastUpdate > 0.07 then
			for i = 1, 6 do UpdateRune(i, GetRuneCooldown(RuneMap[i])) end
			self.TimeSinceLastUpdate = 0
		end
	end
	OnUpdate:SetScript("OnUpdate", updateFunc)

	Runes:RegisterEvent("PLAYER_REGEN_DISABLED")
	Runes:RegisterEvent("PLAYER_REGEN_ENABLED")
	Runes:RegisterEvent("PLAYER_ENTERING_WORLD")
	Runes:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			OnUpdate:SetScript("OnUpdate", updateFunc)
		elseif event == "PLAYER_REGEN_ENABLED" then
			OnUpdate:SetScript("OnUpdate", updateFunc)
		elseif event == "PLAYER_ENTERING_WORLD" then
			RuneFrame:ClearAllPoints()
		end
	end)

	if C["unitframes"].oocHide then
		Runes:RegisterEvent("PLAYER_REGEN_DISABLED")
		Runes:RegisterEvent("PLAYER_REGEN_ENABLED")
		Runes:RegisterEvent("PLAYER_ENTERING_WORLD")
		Runes:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then Runes:SetAlpha(0) end
			end
		end)
	end
end