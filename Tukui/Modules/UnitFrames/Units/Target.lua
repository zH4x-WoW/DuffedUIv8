local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:Target()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetTemplate()
	Panel:Size(250, 21)
	Panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")
	Panel:SetBackdropBorderColor(C.Media.BorderColor[1] * 0.7, C.Media.BorderColor[2] * 0.7, C.Media.BorderColor[3] * 0.7)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(26)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C.Media.Normal)
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorTapping = true	
	Health.colorClass = true
	Health.colorReaction = true	
	Health:FontString("Value", C.Media.AltFont, 12)
	Health.Value:Point("RIGHT", Panel, "RIGHT", -4, 0)
	Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth
	
	if C.UnitFrames.Smooth then
		Health.Smooth = true
	end
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(8)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(C.Media.Normal)
	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C.Media.Normal)
	Power.Background.multiplier = 0.3
	Power:FontString("Value", C.Media.AltFont, 12)
	Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)
	Power.PostUpdate = TukuiUnitFrames.PostUpdatePower
	
	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:Point("LEFT", Panel, "LEFT", 4, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFont(C.Media.AltFont, 12)

	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong] [Tukui:DiffColor][level] [shortclassification]")
	self.Name = Name
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
end