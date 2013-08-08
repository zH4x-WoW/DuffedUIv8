local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]

function DuffedUIUnitFrames:FocusTarget()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(22)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["Media"].Normal)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(0.1, 0.1, 0.1)

	Health:FontString("Value", C["Media"].AltFont, 12, "OUTLINE")
	Health.Value:Point("LEFT", Health, "LEFT", 2, 0)

	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorTapping = true	
	Health.colorClass = true
	Health.colorReaction = true	

	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if (C["UnitFrames"].Smooth) then
		Health.Smooth = true
	end

	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(6)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(C["Media"].Normal)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C["Media"].Normal)
	Power.Background.multiplier = 0.3

	Power:FontString("Value", C["Media"].AltFont, 12, "OUTLINE")
	Power.Value:Point("RIGHT", Health, "RIGHT", -2, 0)

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFont(C["Media"].AltFont, 12, "OUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(D.Mult, -D.Mult)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")

	if (C["UnitFrames"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetPoint("LEFT", 2, 0)
		CastBar:SetPoint("RIGHT", -24, 0)
		CastBar:SetPoint("BOTTOM", 0, -22)
		CastBar:SetHeight(16)
		CastBar:SetStatusBarTexture(C["Media"].Normal)
		CastBar:SetFrameLevel(6)

		CastBar.Background = CreateFrame("Frame", nil, CastBar)
		CastBar.Background:SetTemplate("Default")
		CastBar.Background:SetBackdropBorderColor(C["Media"].BorderColor[1] * 0.7, C["Media"].BorderColor[2] * 0.7, C["Media"].BorderColor[3] * 0.7)
		CastBar.Background:Point("TOPLEFT", -2, 2)
		CastBar.Background:Point("BOTTOMRIGHT", 2, -2)
		CastBar.Background:SetFrameLevel(5)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["Media"].AltFont, 12)
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["Media"].AltFont, 12)
		CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		CastBar.Button = CreateFrame("Frame", nil, CastBar)
		CastBar.Button:Size(20, 20)
		CastBar.Button:SetTemplate()
		CastBar.Button:SetPoint("LEFT", CastBar, "RIGHT", 4, 0)
		CastBar.Button:SetBackdropBorderColor(C["Media"].BorderColor[1] * 0.7, C["Media"].BorderColor[2] * 0.7, C["Media"].BorderColor[3] * 0.7)
		CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
		CastBar.Icon:SetInside()
		CastBar.Icon:SetTexCoord(unpack(D.IconCoord))

		CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
		CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

		self.Castbar = CastBar
		self.Castbar.Icon = CastBar.Icon
	end

	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
end