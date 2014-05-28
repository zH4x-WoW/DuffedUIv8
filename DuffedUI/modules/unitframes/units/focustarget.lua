local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]

function DuffedUIUnitFrames:FocusTarget()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(10)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["medias"].Normal)
	Health:CreateBackdrop()

	Health:FontString("Value", C["medias"].AltFont, 12, "OUTLINE")
	Health.Value:Point("LEFT", Health, "LEFT", 2, 0)
	Health.Value:SetAlpha(0)

	Health.frequentUpdates = true
	if C["general"].UniColor then
		Health.colorDisconnected = false
		Health.colorClass = false
		Health:SetStatusBarColor(unpack(C["unitframes"].HealthBarColor))
	else
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
	end
	Health.colorTapping = true

	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if (C["unitframes"].Smooth) then
		Health.Smooth = true
	end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFont(C["medias"].AltFont, 11, "THINOUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(D.Mult, -D.Mult)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")

	self.Health = Health
	self.Name = Name
end