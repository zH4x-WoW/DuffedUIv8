local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DRUID") then return end

function DuffedUIUnitFrames:AddDruidFeatures()
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)
	local EclipseBar = CreateFrame("Frame", nil, self)
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]

	-- Druid Mana
	DruidMana:Size(217, 2)
	DruidMana:Point("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, 0)
	DruidMana:SetStatusBarTexture(Texture)
	DruidMana:SetStatusBarColor(0.30, 0.52, 0.90)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(0.30, 0.52, 0.90, 0.2)

	-- Totem Bar (Wild Mushrooms)
	if (C["unitframes"].TotemBar) then
		D["Colors"].totems = {
			[1] = { 95/255, 222/255, 95/255 },
			[2] = { 95/255, 222/255, 95/255 },
			[3] = { 95/255, 222/255, 95/255 },
		}

		local TotemBar = self.Totems
		for i = 1, 3 do
			TotemBar[i]:ClearAllPoints()
			TotemBar[i]:Height(8)

			if i == 1 then
				TotemBar[i]:Width((200 / 3) - 1)
				TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width(200 / 3)
				TotemBar[i]:SetPoint("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
			end
		end

		TotemBar[4]:Hide()
	end

	EclipseBar:Point("CENTER", AnchorFrameRessources, "CENTER", 0, 1)
	EclipseBar:SetFrameStrata("MEDIUM")
	EclipseBar:SetFrameLevel(8)
	EclipseBar:Size(200, 6)
	EclipseBar:CreateBackdrop()

	EclipseBar.LunarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.LunarBar:SetPoint("LEFT", EclipseBar, "LEFT", 0, 0)
	EclipseBar.LunarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.LunarBar:SetStatusBarTexture(Texture)
	EclipseBar.LunarBar:SetStatusBarColor(.50, .52, .70)

	EclipseBar.SolarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.SolarBar:SetPoint("LEFT", EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	EclipseBar.SolarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.SolarBar:SetStatusBarTexture(Texture)
	EclipseBar.SolarBar:SetStatusBarColor(.80, .82,  .60)

	EclipseBar.Text = EclipseBar:CreateFontString(nil, "OVERLAY")
	EclipseBar.Text:SetPoint("TOP", self.Health)
	EclipseBar.Text:SetPoint("BOTTOM", self.Health)
	EclipseBar.Text:SetFont(Font, 12, "THINOUTLINE")
	
	EclipseBar:RegisterEvent("PLAYER_REGEN_DISABLED")
	EclipseBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	EclipseBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	EclipseBar:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				EclipseBar:SetAlpha(0)
			end
		end
	end)

	EclipseBar.PostUpdatePower = DuffedUIUnitFrames.EclipseDirection
	
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

	-- Register
	self.DruidMana = DruidMana
	self.DruidMana.bg = DruidMana.Background
	self.EclipseBar = EclipseBar
	self.EnergyBar = EnergyBar
end