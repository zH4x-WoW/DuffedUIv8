local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MONK") then
	return
end

function DuffedUIUnitFrames:AddMonkFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]

	-- Harmony Bar
	local Harmony = CreateFrame("Frame", nil, self)
	Harmony:Point("BOTTOM", AnchorFrameRessources, "TOP", 0, 3)
	Harmony:Size((40 * 5) + 8, 10)
	Harmony:SetTemplate("Transparent")

	for i = 1, 5 do
		Harmony[i] = CreateFrame("StatusBar", nil, Harmony)
		Harmony[i]:Height(6)
		Harmony[i]:SetStatusBarTexture(Texture)

		if i == 1 then
			Harmony[i]:Width(40)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 2, 0)
		else
			Harmony[i]:Width(40)
			Harmony[i]:SetPoint("LEFT", Harmony[i - 1], "RIGHT", 1, 0)
		end
	end

	-- Energy Bar
	local EnergyBarBG = CreateFrame("Frame", "EnergyBarBG", Harmony)
	EnergyBarBG:SetPoint("TOPLEFT", Harmony, "BOTTOMLEFT", 0, -1)
	EnergyBarBG:SetPoint("TOPRIGHT", Harmony, "BOTTOMRIGHT", 0, -1)
	EnergyBarBG:SetHeight(7)
	EnergyBarBG:SetTemplate("Transparent")

	local EnergyBar = CreateFrame("StatusBar", nil, EnergyBarBG)
	EnergyBar:SetStatusBarTexture(Texture)
	EnergyBar:SetStatusBarColor(Color.r, Color.g, Color.b)
	EnergyBar:SetMinMaxValues(0, 100)
	EnergyBar:SetPoint("TOPLEFT", EnergyBarBG, "TOPLEFT", 2, -2)
	EnergyBar:SetPoint("BOTTOMRIGHT", EnergyBarBG, "BOTTOMRIGHT", -2, 2)

	EnergyBar.text = EnergyBar:CreateFontString(nil, "ARTWORK")
	EnergyBar.text:SetFont(Font, 16, "THINOUTLINE")
	EnergyBar.text:SetPoint("LEFT", EnergyBarBG, "RIGHT", 3, 0)
	EnergyBar.text:SetTextColor(Color.r, Color.g, Color.b)

	EnergyBar.TimeSinceLastUpdate = 0
	EnergyBar:SetScript("OnUpdate", function(self, elapsed)
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

	Harmony:RegisterEvent("PLAYER_REGEN_DISABLED")
	Harmony:RegisterEvent("PLAYER_REGEN_ENABLED")
	Harmony:RegisterEvent("PLAYER_ENTERING_WORLD")
	Harmony:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				Harmony:SetAlpha(0)
			end
		end
	end)

	-- Totem Bar (Black Ox / Jade Serpent Statue)
	if C["unitframes"].TotemBar then
		D["Colors"].totems[1] = { 95/255, 222/255, 95/255 }

		local TotemBar = self.Totems
		TotemBar:ClearAllPoints()
		TotemBar:SetWidth(204)
		TotemBar:Point("TOP", Harmony, "BOTTOM", 0, -11)

		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end

		TotemBar:SetScript("OnShow", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 22)
		end)

		TotemBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 12)
		end)
	end

	-- Register
	self.HarmonyBar = Harmony
end