local T, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = T["UnitFrames"]

function DuffedUIUnitFrames:Pet()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetTemplate()
	Panel:Size(129, 17)
	Panel:Point("BOTTOM", self, 0, 0)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")
	Panel:SetBackdropBorderColor(C.Medias.BorderColor[1] * 0.7, C.Medias.BorderColor[2] * 0.7, C.Medias.BorderColor[3] * 0.7)
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(13)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C.Medias.Normal)
	Health.frequentUpdates = true
	Health.PostUpdate = T.PostUpdatePetColor
	Health.colorDisconnected = true	
	Health.colorClass = true
	Health.colorReaction = true	
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:Point("TOPLEFT", Health, -1, 1)
	Health.Background:Point("BOTTOMRIGHT", Health, 1, -1)
	Health.Background:SetTexture(0, 0, 0)
	
	if C.UnitFrames.Smooth then
		Health.Smooth = true
	end
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(4)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(C.Medias.Normal)
	Power.frequentUpdates = true
	Power.colorPower = true
	
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:Point("TOPLEFT", Power, -1, 1)
	Power.Background:Point("BOTTOMRIGHT", Power, 1, -1)
	Power.Background:SetTexture(0, 0, 0)
	
	if C.UnitFrames.Smooth then
		Power.Smooth = true
	end

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Name:SetFont(C.Medias.AltFont, 12)
	Name:SetJustifyH("CENTER")
	
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameMedium] [DuffedUI:DiffColor][level]")
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
end