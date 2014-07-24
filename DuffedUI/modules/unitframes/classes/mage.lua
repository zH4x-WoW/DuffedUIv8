-- NOTE : Please Fix me, Totem Bar Position, when Arcane Bar Is Show!

local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MAGE") then return end

function DuffedUIUnitFrames:AddMageFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]

	-- Arcane Charges
	local ArcaneChargeBar = CreateFrame("Frame", nil, self)
	ArcaneChargeBar:Point("BOTTOM", AnchorFrameRessources, "TOP", 0, 3)
	ArcaneChargeBar:Size((50 * 4) + 7, 10)
	ArcaneChargeBar:SetTemplate("Transparent")

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", nil, ArcaneChargeBar)
		ArcaneChargeBar[i]:Height(6)
		ArcaneChargeBar[i]:SetStatusBarTexture(Texture)
		ArcaneChargeBar[i].bg = ArcaneChargeBar[i]:CreateTexture(nil, 'ARTWORK')

		if i == 1 then
			ArcaneChargeBar[i]:Width(50)
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar, "LEFT", 2, 0)
		else
			ArcaneChargeBar[i]:Width(50)
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar[i - 1], "RIGHT", 1, 0)
		end
	end

	for i = 1, 40 do
		local _, _, _, _, _, _, _, spellID = select(4, UnitDebuff("player", i))
		if spellID == 36032 then
			ArcaneChargeBar:RegisterEvent("PLAYER_REGEN_DISABLED")
			ArcaneChargeBar:RegisterEvent("PLAYER_REGEN_ENABLED")
			ArcaneChargeBar:RegisterEvent("PLAYER_ENTERING_WORLD")
			ArcaneChargeBar:SetScript("OnEvent", function(self, event)
				if event == "PLAYER_REGEN_DISABLED" then
					UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
				elseif event == "PLAYER_REGEN_ENABLED" then
					UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
				elseif event == "PLAYER_ENTERING_WORLD" then
					if not InCombatLockdown() then
						ArcaneChargeBar:SetAlpha(0)
					end
				end
			end)
		end
	end
	
	-- Energy Bar
	local EnergyBar = CreateFrame("StatusBar", nil, self)
	EnergyBar:Point("CENTER", AnchorFrameRessources, "CENTER", 0, 1)
	EnergyBar:Size(203, 6)
	EnergyBar:SetStatusBarTexture(Texture)
	EnergyBar:SetStatusBarColor(Color.r, Color.g, Color.b)
	EnergyBar:SetMinMaxValues(0, 100)
	EnergyBar:CreateBackdrop()

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
				self.text:SetText(D.ShortValue(power))
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

	-- Register
	self.ArcaneChargeBar = ArcaneChargeBar

	-- Totem Bar (Rune of Power)
	if C["unitframes"].TotemBar then
		D["Colors"].totems = {
			[1] = { 132/255, 112/255, 255/255 },
			[2] = { 132/255, 112/255, 255/255 },
		}

		local TotemBar = self.Totems
		for i = 1, 2 do
			TotemBar[i]:ClearAllPoints()
			TotemBar[i]:Height(6)

			if i == 1 then
				TotemBar[i]:Width(101)
				TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width(101)
				TotemBar[i]:SetPoint("LEFT", TotemBar[i - 1], "RIGHT", 1, 0)
			end
		end

		TotemBar[3]:Hide()
		TotemBar[4]:Hide()
	end
end