local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARLOCK") then return end

function DuffedUIUnitFrames:AddWarlockFeatures()
	local Texture = C["medias"].Normal
	local Font = C["medias"].Font
	local Color = RAID_CLASS_COLORS[Class]	

	-- Warlock Class Shards
	local Shards = CreateFrame("Frame", nil, self)
	Shards:Point("BOTTOM", AnchorFrameRessources, "TOP", 0, 3)
	Shards:Size((50 * 4) + 9, 5)
	Shards:CreateBackdrop()
	
	for i = 1, 4 do
		Shards[i] = CreateFrame("StatusBar", nil, Shards)
		Shards[i]:Height(5)
		Shards[i]:SetStatusBarTexture(Texture)
		
		if i == 1 then
			Shards[i]:Width(48)
			Shards[i]:SetPoint("LEFT", Shards, "LEFT", 0, 0)
		else
			Shards[i]:Width(49)
			Shards[i]:SetPoint("LEFT", Shards[i - 1], "RIGHT", 1, 0)
		end
	end

	-- Energy Bar
	local EnergyBarBG = CreateFrame("Frame", "EnergyBarBG", Shards)
	EnergyBarBG:SetPoint("TOPLEFT", Shards, "BOTTOMLEFT", -2, -3)
	EnergyBarBG:SetPoint("TOPRIGHT", Shards, "BOTTOMRIGHT", 2, -3)
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
				self.text:SetText(D.ShortValue(power))
			end
			self.TimeSinceLastUpdate = 0
		end
	end)

	Shards:RegisterEvent("PLAYER_REGEN_DISABLED")
	Shards:RegisterEvent("PLAYER_REGEN_ENABLED")
	Shards:RegisterEvent("PLAYER_ENTERING_WORLD")
	Shards:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
		elseif event == "PLAYER_ENTERING_WORLD" then
			if not InCombatLockdown() then
				Shards:SetAlpha(0)
			end
		end
	end)
	
	-- Register
	self.WarlockSpecBars = Shards		
end