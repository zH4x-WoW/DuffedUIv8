local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MONK") then return end

function DuffedUIUnitFrames:AddMonkFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]

	-- Harmony Bar
	local Harmony = CreateFrame("Frame", nil, self)
	Harmony:Point("BOTTOM", AnchorFrameRessources, "TOP", 0, 3)
	Harmony:Size((33 * 6) + 8, 10)
	Harmony:SetTemplate("Transparent")

	for i = 1, 6 do
		Harmony[i] = CreateFrame("StatusBar", nil, Harmony)
		Harmony[i]:Height(6)
		Harmony[i]:SetStatusBarTexture(Texture)

		if i == 1 then
			Harmony[i]:Width(33)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 2, 0)
		else
			Harmony[i]:Width(33)
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
	local bar = CreateFrame("StatusBar", "DuffedUIStatueBar", self)
	bar:SetWidth(5)
	bar:SetHeight(28)
	bar:Point("BOTTOMLEFT", oUF_DuffedUIPlayer, "BOTTOMRIGHT", 6, -1)
	bar:SetStatusBarTexture(Texture)
	bar:SetOrientation("VERTICAL")
	bar.bg = bar:CreateTexture(nil, 'ARTWORK')
	
	bar.background = CreateFrame("Frame", "DuffedUIStatue", bar)
	bar.background:SetAllPoints()
	bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar.background:SetBackdrop(backdrop)
	bar.background:SetBackdropColor(0, 0, 0)
	bar.background:SetBackdropBorderColor(0,0,0)
	bar:CreateBackdrop()

	-- Register
	self.HarmonyBar = Harmony
	self.Statue = bar
end