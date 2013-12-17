local D, C, L = select(2, ...):unpack()

if (not C["Misc"].AltPowerBarEnable) then
	return
end

local Panels = D["Panels"]
local DataTextRight = Panels.DataTextRight
local TimeSinceLastUpdate = 1

local OnUpdate = function(self, elapsed)
	if (not self:IsShown()) then
		return
	end
	
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		local Power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		local R, G, B = D.ColorGradient(Power,MaxPower, 0,.8,0,.8,.8,0,.8,0,0)
	
		self.Text:SetText(Power.." / "..MaxPower)
		self.Status:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		self.Status:SetValue(Power)
		self.Status:SetStatusBarColor(R, G, B)
		TimeSinceLastUpdate = 0
	end
end

local OnEvent = function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	if UnitAlternatePowerInfo("player") then
		self:Show()
		self:SetScript("OnUpdate", OnUpdate)
	else
		self:Hide()
		self:SetScript("OnUpdate", nil)
	end
end

PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")

local AltPowerBar = CreateFrame("Frame", nil, DataTextRight)
AltPowerBar:SetAllPoints()
AltPowerBar:SetFrameStrata("MEDIUM")
AltPowerBar:SetFrameLevel(DataTextRight:GetFrameLevel() + 1)
AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
AltPowerBar:SetScript("OnEvent", OnEvent)

AltPowerBar.Status = CreateFrame("StatusBar", nil, AltPowerBar)
AltPowerBar.Status:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBar.Status:SetStatusBarTexture(C.Medias.Normal)
AltPowerBar.Status:SetMinMaxValues(0, 100)
AltPowerBar.Status:Point("TOPLEFT", DataTextRight, "TOPLEFT", 1, -1)
AltPowerBar.Status:Point("BOTTOMRIGHT", DataTextRight, "BOTTOMRIGHT", -1, 1)

AltPowerBar.Text = AltPowerBar.Status:CreateFontString(nil, "OVERLAY")
AltPowerBar.Text:SetFont(C.Medias.Font, 12)
AltPowerBar.Text:Point("CENTER", AltPowerBar, "CENTER", 0, 0)
AltPowerBar.Text:SetShadowColor(0, 0, 0)
AltPowerBar.Text:SetShadowOffset(1.25, -1.25)

Panels.AltPowerBar = AltPowerBar