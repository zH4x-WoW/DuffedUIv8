local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]

function DuffedUIUnitFrames:Arena()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	self:SetAttribute("type2", "focus")

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(22)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["Medias"].Normal)
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	Health:FontString("Value", C["Medias"].AltFont, 12, "OUTLINE")
	Health.Value:Point("LEFT", 2, 0)
	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth
	Health.frequentUpdates = true
	Health.colorClass = true
	Health.colorDisconnected = true
	Health.colorReaction = true
	if (C["UnitFrames"].Smooth) then
		Health.Smooth = true
	end

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(6)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetTexture(C["Medias"].Normal)
	Power.Background.multiplier = 0.3
	Power:SetStatusBarTexture(C["Medias"].Normal)
	Power:FontString("Value", C["Medias"].AltFont, 12, "OUTLINE")
	Power.Value:Point("RIGHT", -2, 0)
	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower
	Power.frequentUpdates = true
	Power.colorPower = true
	if (C["UnitFrames"].Smooth) then
		Health.Smooth = true
	end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	Name:SetJustifyH("CENTER")
	Name:SetFont(C["Medias"].AltFont, 12, "OUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	Name.frequentUpdates = 0.2

	local Debuffs = CreateFrame("Frame", nil, self)
	Debuffs:SetHeight(26)
	Debuffs:SetWidth(200)
	Debuffs:Point("LEFT", self, "RIGHT", 4, 0)
	Debuffs.size = 26
	Debuffs.num = 5
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "LEFT"
	Debuffs["growth-x"] = "RIGHT"
	Debuffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura

	local SpecIcon = CreateFrame("Frame", nil, self)
	SpecIcon:Size(22)
	SpecIcon:SetPoint("RIGHT", self, "LEFT", -6, 0)
	SpecIcon:CreateBackdrop()
	SpecIcon.Backdrop:CreateShadow()

	local Trinket = CreateFrame("Frame", nil, self)
	Trinket:Size(22)
	Trinket:SetPoint("RIGHT", self, "LEFT", -34, 0)
	Trinket:CreateBackdrop()
	Trinket.Backdrop:CreateShadow()

	if (C["UnitFrames"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetPoint("LEFT", 24, 0)
		CastBar:SetPoint("RIGHT", -2, 0)
		CastBar:SetPoint("BOTTOM", 0, -22)
		CastBar:SetHeight(16)
		CastBar:SetStatusBarTexture(C["Medias"].Normal)
		CastBar:SetFrameLevel(6)
		CastBar.Background = CreateFrame("Frame", nil, CastBar)
		CastBar.Background:SetTemplate("Default")
		CastBar.Background:SetBackdropBorderColor(C["Medias"].BorderColor[1] * 0.7, C["Medias"].BorderColor[2] * 0.7, C["Medias"].BorderColor[3] * 0.7)
		CastBar.Background:Point("TOPLEFT", -2, 2)
		CastBar.Background:Point("BOTTOMRIGHT", 2, -2)
		CastBar.Background:SetFrameLevel(5)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["Medias"].AltFont, 12)
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")
		CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["Medias"].AltFont, 12)
		CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
		CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

		CastBar.Button = CreateFrame("Frame", nil, CastBar)
		CastBar.Button:Height(CastBar:GetHeight() + 4)
		CastBar.Button:Width(CastBar:GetHeight() + 4)
		CastBar.Button:Point("RIGHT", CastBar, "LEFT", -4, 0)
		CastBar.Button:SetTemplate()
		CastBar.Button:SetBackdropBorderColor(C["Medias"].BorderColor[1] * 0.7, C["Medias"].BorderColor[2] * 0.7, C["Medias"].BorderColor[3] * 0.7)

		CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
		CastBar.Icon:Point("TOPLEFT", CastBar.Button, 2, -2)
		CastBar.Icon:Point("BOTTOMRIGHT", CastBar.Button, -2, 2)
		CastBar.Icon:SetTexCoord(D.IconCoord)

		self.Castbar = CastBar
		self.Castbar.Time = CastBar.Time
		self.Castbar.Icon = CastBar.Icon
	end

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.Debuffs = Debuffs
	self.PVPSpecIcon = SpecIcon
	self.Trinket = Trinket
end