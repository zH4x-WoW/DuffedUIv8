local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]

if class ~= "DEATHKNIGHT" then return end

D["ClassRessource"]["DEATHKNIGHT"] = function(self)
	local RuneColors = {
			{.69, .31, .31}, -- blood
			{.33, .59, .33}, -- unholy
			{.31, .45, .63}, -- frost
			{.84, .75, .65}, -- death
			{0, .82, 1 }, -- runic power
	}
	local Runes = {}
	local RuneMap = { 1, 2, 3, 4, 5, 6 }

	Runes = CreateFrame("Frame", Runes, UIParent)
	Runes:SetSize(216, 5)
	Runes:CreateBackdrop()
	Runes:SetParent(DuffedUIPetBattleHider)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			Runes:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			Runes:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			Runes:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			Runes:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		Runes:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("RunicPower", 216, 5)
	end

	for i = 1, 6 do
		local rune = CreateFrame("StatusBar", "Rune"..i, Runes)
		rune:SetStatusBarTexture(texture)
		rune:SetStatusBarColor(unpack(RuneColors[math.ceil(RuneMap[i] / 2) ]))
		rune:SetMinMaxValues(0, 10)
		rune:SetHeight(5)

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

	if C["unitframes"].oocHide then D["oocHide"](Runes) end
end