local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARRIOR") then return end

function DuffedUIUnitFrames:AddWarriorFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]
	
	-- Energy Bar
	local EnergyBarBG = CreateFrame("Frame", "EnergyBarBG", self)
	EnergyBarBG:SetPoint("TOP", AnchorFrameRessources, "BOTTOM", 0, 0)
	EnergyBarBG:Size(200, 6)
	EnergyBarBG:CreateBackdrop()

	local EnergyBar = CreateFrame("StatusBar", nil, EnergyBarBG)
	EnergyBar:SetStatusBarTexture(Texture)
	EnergyBar:SetStatusBarColor(Color.r, Color.g, Color.b)
	EnergyBar:SetMinMaxValues(0, 100)
	EnergyBar:SetPoint("LEFT", EnergyBarBG, "LEFT", 0, 0)
	EnergyBar:Size(200, 6)

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
				self.text:SetText(D.ShortValue(power))
			end
			self.TimeSinceLastUpdate = 0
		end
	end)
	
	EnergyBarBG:RegisterEvent("PLAYER_REGEN_DISABLED")
	EnergyBarBG:RegisterEvent("PLAYER_REGEN_ENABLED")
	EnergyBarBG:RegisterEvent("PLAYER_ENTERING_WORLD")
	EnergyBarBG:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				EnergyBarBG:SetAlpha(0)
			end
		end
	end)
	
	-- Totem Bar (Demoralizing / Mocking / Skull Banner)
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
	self.Statue = bar
	self.EnergyBar = EnergyBar
end