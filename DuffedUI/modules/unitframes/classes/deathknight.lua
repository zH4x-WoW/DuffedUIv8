local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DEATHKNIGHT") then return end

function DuffedUIUnitFrames:AddDeathKnightFeatures()
	local colors = {
		{ 0.69, 0.31, 0.31 }, -- blood
		{ 0.33, 0.59, 0.33 }, -- unholy
		{ 0.31, 0.45, 0.63 }, -- frost
		{ 0.84, 0.75, 0.65 }, -- death
		{ 0, 0.82, 1 }, -- runic power
	}
	local runes = {}
	local runemap = { 1, 2, 3, 4, 5, 6 }

	Runes = CreateFrame("Frame", "Runes", UIParent)
	Runes:SetPoint("BOTTOM", AnchorFrameRessources, "TOP", 0, 3)
	Runes:SetSize((40 * 6) + 9, 9)
	Runes:SetTemplate("Transparent")
	Runes:CreateShadow("Default")

	for i = 1, 6 do
		local rune = CreateFrame("StatusBar", "RunesRune"..i, Runes)
		rune:SetStatusBarTexture(C["medias"].Normal)
		rune:SetStatusBarColor(unpack(colors[math.ceil(runemap[i] / 2) ]))
		rune:SetMinMaxValues(0, 10)

		rune:SetHeight(5)

		if i == 1 then
			rune:SetWidth(40)
			rune:SetPoint("LEFT", Runes, "LEFT", 2, 0)
		else
			rune:SetWidth(runes[1]:GetWidth())
			rune:SetPoint("LEFT", runes[i - 1], "RIGHT", 1, 0)
		end

		tinsert(runes, rune)
	end

	local rpbarbg = CreateFrame("Frame", "RunesRunicPower", Runes)
	rpbarbg:SetPoint("TOPLEFT", Runes, "BOTTOMLEFT", 0, -1)
	rpbarbg:SetPoint("TOPRIGHT", Runes, "BOTTOMRIGHT", 0, -1)
	rpbarbg:SetHeight(7)
	rpbarbg:CreateShadow("Default")
	rpbarbg:SetTemplate("Transparent")

	local rpbar = CreateFrame("StatusBar", nil, rpbarbg)
	rpbar:SetStatusBarTexture(C["medias"].Normal)
	rpbar:SetStatusBarColor(unpack(colors[5]))
	rpbar:SetMinMaxValues(0, 100)
	rpbar:SetPoint("TOPLEFT", rpbarbg, "TOPLEFT", 2, -2)
	rpbar:SetPoint("BOTTOMRIGHT", rpbarbg, "BOTTOMRIGHT", -2, 2)

	rpbar.text = rpbar:CreateFontString(nil, "ARTWORK")
	rpbar.text:SetFont(C["medias"].Font, 16, "THINOUTLINE")
	rpbar.text:SetPoint("RIGHT",RunesRunicPower, "LEFT", -1, 1)
	rpbar.text:SetTextColor(unpack(colors[5]))

	rpbar.TimeSinceLastUpdate = 0
	rpbar:SetScript("OnUpdate", function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed 

		if self.TimeSinceLastUpdate > 0.07 then
			self:SetMinMaxValues(0, UnitPowerMax("player"))
			local power = UnitPower("player")
			self:SetValue(power)
			if self.text then
				self.text:SetText(power)
			end
			self.TimeSinceLastUpdate = 0
		end
	end)

	local function UpdateRune(id, start, duration, finished)
		local rune = runes[id]

		rune:SetStatusBarColor(unpack(colors[GetRuneType(runemap[id])]))
		rune:SetMinMaxValues(0, duration)

		if finished then rune:SetValue(duration) else rune:SetValue(GetTime() - start) end
	end

	local OnUpdate = CreateFrame("Frame")
	OnUpdate.TimeSinceLastUpdate = 0
	local updateFunc = function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed

		if self.TimeSinceLastUpdate > 0.07 then
			for i = 1, 6 do
				UpdateRune(i, GetRuneCooldown(runemap[i]))
			end
			self.TimeSinceLastUpdate = 0
		end
	end
	OnUpdate:SetScript("OnUpdate", updateFunc)

	Runes:RegisterEvent("PLAYER_REGEN_DISABLED")
	Runes:RegisterEvent("PLAYER_REGEN_ENABLED")
	Runes:RegisterEvent("PLAYER_ENTERING_WORLD")
	Runes:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			OnUpdate:SetScript("OnUpdate", updateFunc)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			OnUpdate:SetScript("OnUpdate", nil)
		elseif event == "PLAYER_ENTERING_WORLD" then
			RuneFrame:ClearAllPoints()
			if not InCombatLockdown() then
				Runes:SetAlpha(0)
			end
		end
	end)

	RuneFrame:Hide()
	RuneFrame:SetScript("OnShow", function(self)
		self:Hide()
	end)

	local TotemBar = self.Totems
	-- Totem Bar (Risen Ally - Raise Dead)
	if (C["unitframes"].TotemBar) then
		D["Colors"].totems[1] = {0.60, 0.40, 0}
		
		local TotemBar = self.Totems
		TotemBar:ClearAllPoints()
		TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)
		
		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end
		
		TotemBar:SetScript("OnShow", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, 22)
		end)
		
		TotemBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, 12)
		end)
	end
end