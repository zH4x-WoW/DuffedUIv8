local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Font = D.GetFont(C["unitframes"].Font)
local HealthTexture = D.GetTexture(C["unitframes"].HealthTexture)

function DuffedUIUnitFrames:FocusTarget()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(10)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(0.1, 0.1, 0.1)

	-- Border for Health
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	Health.Value:Point("LEFT", Health, "LEFT", 2, 0)
	Health.Value:Hide()

	Health.frequentUpdates = true
	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if C["unitframes"].UniColor == true then
		Health.colorDisconnected = false
		Health.colorClass = false
		Health.colorReaction = false
		Health:SetStatusBarColor(unpack(C["unitframes"].HealthBarColor))
		Health.Background:SetVertexColor(unpack(C["unitframes"].HealthBGColor))
	else
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
		Health.Background:SetTexture(.1, .1, .1)
	end
	if (C["unitframes"].Smooth) then Health.Smooth = true end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(D.Mult, -D.Mult)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameShort]")

	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Name = Name
end