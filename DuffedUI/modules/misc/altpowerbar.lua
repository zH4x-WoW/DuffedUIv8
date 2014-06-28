local D, C, L = select(2, ...):unpack()

if (not C["misc"].AltPowerBarEnable) then return end

local Miscellaneous = D["Miscellaneous"]
local Panels = D["Panels"]
local DataTextLeft = Panels.DataTextLeft
local AltPowerBar = CreateFrame("Frame")

function AltPowerBar:Update()
	if not self:IsShown() then return end
	local Power = UnitPower("player", ALTERNATE_POWER_INDEX)
	local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
	local R, G, B = D.ColorGradient(Power,MaxPower, 0,.8,0,.8,.8,0,.8,0,0)
	
	self.Text:SetText(Power.." / "..MaxPower)
	self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
	self:SetValue(Power)
	self:SetStatusBarColor(R, G, B)
end

function AltPowerBar:OnEvent(event)
	if event == "PLAYER_ENTERING_WORLD" then self:UnregisterEvent(event) end

	if event == 'UNIT_POWER_BAR_SHOW' or UnitAlternatePowerInfo("player") then
		self:Show()
	else
		self:Hide()
	end
end

function AltPowerBar:UnregisterFrames()
	local BlizzardAltPower = PlayerPowerBarAlt

	BlizzardAltPower:UnregisterEvent("UNIT_POWER_BAR_SHOW")
	BlizzardAltPower:UnregisterEvent("UNIT_POWER_BAR_HIDE")
	BlizzardAltPower:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function AltPowerBar:Create()
	self:UnregisterFrames()
	self:SetParent(DataTextLeft)
	self:SetAllPoints()
	self:SetTemplate()
	self:SetFrameStrata("MEDIUM")
	self:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", AltPowerBar.OnEvent)

	self.Status = CreateFrame("StatusBar", nil, self)
	self.Status:SetFrameLevel(self:GetFrameLevel() + 1)
	self.Status:SetStatusBarTexture(C["medias"].Normal)
	self.Status:SetMinMaxValues(0, 100)
	self.Status:Point("TOPLEFT", DataTextLeft, "TOPLEFT", 1, -1)
	self.Status:Point("BOTTOMRIGHT", DataTextLeft, "BOTTOMRIGHT", -1, 1)

	self.Status.Text = self.Status:CreateFontString(nil, "OVERLAY")
	self.Status.Text:SetFont(C["medias"].Font, 12)
	self.Status.Text:Point("CENTER", self, "CENTER", 0, 0)
	self.Status.Text:SetShadowColor(0, 0, 0)
	self.Status.Text:SetShadowOffset(1.25, -1.25)

	self.Status:RegisterUnitEvent("UNIT_POWER", "player")
	self.Status:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
	self.Status:SetScript("OnEvent", AltPowerBar.Update)
end

function AltPowerBar:Enable()
	self:Create()
end

Miscellaneous.AltPowerBar = AltPowerBar