local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "SHAMAN") then return end

function DuffedUIUnitFrames:AddShamanFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]

	-- Default layout of Totems match Shaman class.
	local Bar = CreateFrame("Frame", nil, self)
	Bar:Point("TOP", AnchorFrameRessources, "BOTTOM", 0, -2)
	Bar:Size(202, 8)

	-- Border for the experience bar
	local TotemBorder = CreateFrame("Frame", nil, Bar)
	TotemBorder:SetPoint("TOPLEFT", Bar, "TOPLEFT", D.Scale(-2), D.Scale(2))
	TotemBorder:SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	TotemBorder:SetTemplate("Default")
	TotemBorder:SetFrameLevel(2)

	Bar.activeTotems = 0
	Bar.Override = DuffedUIUnitFrames.UpdateTotemOverride

	Bar:SetScript("OnShow", function(self) 
		DuffedUIUnitFrames.UpdateShadow(self, 12)
	end)

	Bar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, 4)
	end)
	
	-- Totem Bar
	for i = 1, MAX_TOTEMS do
		Bar[i] = CreateFrame("StatusBar", nil, Bar)
		Bar[i]:Height(8)
		Bar[i]:SetStatusBarTexture(Texture)
		Bar[i]:EnableMouse(true)

		if i == 1 then
			Bar[i]:Width((250 / 4) - 2)
			Bar[i]:Point("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width((250 / 4) - 1)
			Bar[i]:Point("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end

		Bar[i]:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Bar[i]:SetBackdropColor(0, 0, 0)
		Bar[i]:SetMinMaxValues(0, 1)

		Bar[i].bg = Bar[i]:CreateTexture(nil, "BORDER")
		Bar[i].bg:SetAllPoints()
		Bar[i].bg:SetTexture(Texture)
		Bar[i].bg.multiplier = 0.3
	end

	Bar:RegisterEvent("PLAYER_REGEN_DISABLED")
	Bar:RegisterEvent("PLAYER_REGEN_ENABLED")
	Bar:RegisterEvent("PLAYER_ENTERING_WORLD")
	Bar:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				Bar:SetAlpha(0)
			end
		end
	end)

	self.Totems = Bar
	-- Energy Bar
	local EnergyBar = CreateFrame("StatusBar", nil, self)
	EnergyBar:Point("CENTER", AnchorFrameRessources, "CENTER", 0, 1)
	EnergyBar:Size(202, 8)
	EnergyBar:SetStatusBarTexture(Texture)
	EnergyBar:SetStatusBarColor(Color.r, Color.g, Color.b)
	EnergyBar:SetMinMaxValues(0, 100)

	-- Border for EnergyBarBar
	local EnergyBarBorder = CreateFrame("Frame", nil, EnergyBar)
	EnergyBarBorder:SetPoint("TOPLEFT", EnergyBar, "TOPLEFT", D.Scale(-2), D.Scale(2))
	EnergyBarBorder:SetPoint("BOTTOMRIGHT", EnergyBar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	EnergyBarBorder:SetTemplate("Default")
	EnergyBarBorder:SetFrameLevel(2)

	EnergyBar.text = EnergyBar:CreateFontString(nil, "ARTWORK")
	EnergyBar.text:SetFont(Font, 16, "THINOUTLINE")
	EnergyBar.text:SetPoint("LEFT", EnergyBar, "RIGHT", 3, -1)
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

	EnergyBar:RegisterEvent("PLAYER_REGEN_DISABLED")
	EnergyBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	EnergyBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	EnergyBar:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				EnergyBar:SetAlpha(0)
			end
		end
	end)
end