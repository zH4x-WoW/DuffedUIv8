local D, C, L = select(2, ...):unpack()

if (not C["misc"].AltPowerBarEnable) then
	return
end

local Panels = D["Panels"]
local DataTextLeft = Panels.DataTextLeft
local TimeSinceLastUpdate = 1

local StatusBarEvent = function(self)
	if not self:IsShown() then return end
	local Power = UnitPower("player", ALTERNATE_POWER_INDEX)
	local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
	local R, G, B = D.ColorGradient(Power,MaxPower, 0,.8,0,.8,.8,0,.8,0,0)
	
	self.Text:SetText(Power.." / "..MaxPower)
	self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
	self:SetValue(Power)
	self:SetStatusBarColor(R, G, B)
end

local OnEvent = function(self, event)
	if event == 'PLAYER_ENTERING_WORLD' then self:UnregisterEvent(event) end

	if event == 'UNIT_POWER_BAR_SHOW' or UnitAlternatePowerInfo("player") then
		self:Show()
	else
		self:Hide()
	end
end

PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")

local AltPowerBar = CreateFrame("Frame", nil, DataTextLeft)
AltPowerBar:SetAllPoints()
AltPowerBar:SetTemplate()
AltPowerBar:SetFrameStrata("MEDIUM")
AltPowerBar:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
AltPowerBar:SetScript("OnEvent", OnEvent)

AltPowerBar.Status = CreateFrame("StatusBar", nil, AltPowerBar)
AltPowerBar.Status:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBar.Status:SetStatusBarTexture(C["medias"].Normal)
AltPowerBar.Status:SetMinMaxValues(0, 100)
AltPowerBar.Status:Point("TOPLEFT", DataTextLeft, "TOPLEFT", 1, -1)
AltPowerBar.Status:Point("BOTTOMRIGHT", DataTextLeft, "BOTTOMRIGHT", -1, 1)

AltPowerBar.Status.Text = AltPowerBar.Status:CreateFontString(nil, "OVERLAY")
AltPowerBar.Status.Text:SetFont(C["medias"].Font, 12)
AltPowerBar.Status.Text:Point("CENTER", AltPowerBar, "CENTER", 0, 0)
AltPowerBar.Status.Text:SetShadowColor(0, 0, 0)
AltPowerBar.Status.Text:SetShadowOffset(1.25, -1.25)

AltPowerBar.Status:RegisterUnitEvent("UNIT_POWER", 'player')
AltPowerBar.Status:RegisterUnitEvent("UNIT_POWER_FREQUENT", 'player')
AltPowerBar.Status:SetScript('OnEvent', StatusBarEvent)

Panels.AltPowerBar = AltPowerBar