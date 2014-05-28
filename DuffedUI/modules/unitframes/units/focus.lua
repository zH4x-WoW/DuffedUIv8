local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local _, Class = UnitClass("player")

function DuffedUIUnitFrames:Focus()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(18)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["medias"].Normal)
	Health:CreateBackdrop()

	Health:FontString("Value", C["medias"].AltFont, 12, "OUTLINE")
	Health.Value:Point("RIGHT", Health, "RIGHT", -2, 0)

	Health.frequentUpdates = true
	if C["unitframes"].UniColor then
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

	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 85, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", -9, -1)
	Power:SetStatusBarTexture(C["medias"].Normal)
	Power:SetFrameLevel(Health:GetFrameLevel() + 2)
	Power:CreateBackdrop()

	Power:FontString("Value", C["medias"].AltFont, 12, "OUTLINE")
	Power.Value:Point("RIGHT", Health, "RIGHT", -2, 0)
	Power.Value:SetAlpha(0)

	Power.colorPower = true
	Power.frequentUpdates = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("LEFT", Health, "LEFT", 2, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFont(C["medias"].AltFont, 11, "THINOUTLINE")
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(D.Mult, -D.Mult)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")

	if (C["unitframes"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetPoint("LEFT", 2, 0)
		CastBar:SetPoint("RIGHT", -24, 0)
		CastBar:SetPoint("BOTTOM", 0, -22)
		CastBar:SetHeight(16)
		CastBar:SetStatusBarTexture(C["medias"].Normal)
		CastBar:SetFrameLevel(6)

		CastBar.Background = CreateFrame("Frame", nil, CastBar)
		CastBar.Background:SetTemplate("Default")
		CastBar.Background:SetBackdropBorderColor(C["medias"].BorderColor[1] * 0.7, C["medias"].BorderColor[2] * 0.7, C["medias"].BorderColor[3] * 0.7)
		CastBar.Background:Point("TOPLEFT", -2, 2)
		CastBar.Background:Point("BOTTOMRIGHT", 2, -2)
		CastBar.Background:SetFrameLevel(5)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["medias"].AltFont, 12)
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["medias"].AltFont, 12)
		CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		CastBar.Button = CreateFrame("Frame", nil, CastBar)
		CastBar.Button:Size(20, 20)
		CastBar.Button:SetTemplate()
		CastBar.Button:SetPoint("LEFT", CastBar, "RIGHT", 4, 0)
		CastBar.Button:SetBackdropBorderColor(C["medias"].BorderColor[1] * 0.7, C["medias"].BorderColor[2] * 0.7, C["medias"].BorderColor[3] * 0.7)
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
	self.Power = Power
	self.Name = Name
end