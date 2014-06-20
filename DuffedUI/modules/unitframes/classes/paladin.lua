local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PALADIN") then
	return
end

function DuffedUIUnitFrames:AddPaladinFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]
	
	-- Holy Power
	local HPBar = CreateFrame("Frame", nil, self)
	HPBar:Point("BOTTOMLEFT", AnchorFrameRessources, "TOPLEFT", 0, 3)
	HPBar:Size((40 * 5) + 8, 10)
	HPBar:SetTemplate("Transparent")

	for i = 1, 5 do
		HPBar[i] = CreateFrame("StatusBar", nil, HPBar)
		HPBar[i]:Height(6)
		HPBar[i]:SetStatusBarTexture(Texture)
		HPBar[i]:SetStatusBarColor(0.89, 0.88, 0.06)

		if i == 1 then
			HPBar[i]:Width(40)
			HPBar[i]:Point("LEFT", HPBar, "LEFT", 2, 0)
		else
			HPBar[i]:Width(40)
			HPBar[i]:Point("LEFT", HPBar[i-1], "RIGHT", 1, 0)
		end
	end

	-- Energy Bar
	local EnergyBarBG = CreateFrame("Frame", "EnergyBarBG", HPBar)
	EnergyBarBG:SetPoint("TOPLEFT", HPBar, "BOTTOMLEFT", 0, -1)
	EnergyBarBG:SetPoint("TOPRIGHT", HPBar, "BOTTOMRIGHT", 0, -1)
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

	HPBar:RegisterEvent("PLAYER_REGEN_DISABLED")
	HPBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	HPBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	HPBar:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				HPBar:SetAlpha(0)
			end
		end
	end)
	
	-- Register
	self.HolyPower = HPBar
end