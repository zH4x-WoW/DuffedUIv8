local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]

function DuffedUIUnitFrames:TargetOfTarget()
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
	Health:Height(18)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C.Medias.Normal)
	Health.frequentUpdates = true
	Health.PostUpdate = D.PostUpdatePetColor
	Health.colorDisconnected = true	
	Health.colorClass = true
	Health.colorReaction = true	
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:Point("TOPLEFT", Health, -1, 1)
	Health.Background:Point("BOTTOMRIGHT", Health, 1, -1)
	Health.Background:SetTexture(0, 0, 0)
	
	if C["unitframes"].Smooth then
		Health.Smooth = true
	end

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Name:SetFont(C.Medias.AltFont, 12)
	Name:SetJustifyH("CENTER")
	
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameMedium]")
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Name = Name
end