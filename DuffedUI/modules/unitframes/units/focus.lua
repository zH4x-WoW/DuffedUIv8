local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local _, Class = UnitClass("player")
local Font = D.GetFont(C["unitframes"].Font)
local HealthTexture = D.GetTexture(C["unitframes"].HealthTexture)
local PowerTexture = D.GetTexture(C["unitframes"].PowerTexture)

function DuffedUIUnitFrames:Focus()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(17)
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
	Health.Value:Point("RIGHT", Health, "RIGHT", 0, 1)

	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorTapping = true
	Health.colorClass = true
	Health.colorReaction = true

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

	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 85, 0)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", -9, -3)
	Power:SetStatusBarTexture(PowerTexture)
	Power:SetFrameLevel(Health:GetFrameLevel() + 2)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(.1, .1, .1)
	Power.Background.multiplier = 0.3

	-- Border for Power
	local PowerBorder = CreateFrame("Frame", nil, Power)
	PowerBorder:SetPoint("TOPLEFT", Power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:CreateShadow("Default")
	PowerBorder:SetFrameLevel(Health:GetFrameLevel() + 1)

	Power.Value = Power:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:Point("RIGHT", Health, "RIGHT", -2, 0)
	Power.Value:Hide()

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true
	if (C["unitframes"].Smooth) then Power.Smooth = true end

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:Point("LEFT", Health, "LEFT", 2, 1)
	Name:SetJustifyH("CENTER")
	Name:SetFontObject(Font)
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")
	
	local Debuffs = CreateFrame("Frame", nil, self)
	Debuffs:Point("RIGHT", self, "LEFT", -4, 10)
	Debuffs:SetHeight(30)
	Debuffs:SetWidth(200)
	Debuffs.size = 28
	Debuffs.num = 3
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "RIGHT"
	Debuffs["growth-x"] = "LEFT"
	Debuffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura

	local CastBar = CreateFrame("StatusBar", nil, self)
	CastBar:SetPoint("LEFT", 2, 0)
	CastBar:SetPoint("RIGHT", -24, 0)
	CastBar:SetPoint("BOTTOM", 0, -22)
	CastBar:SetHeight(10)
	CastBar:SetStatusBarTexture(C["medias"].Normal)
	CastBar:SetFrameLevel(6)

	CastBar.Background = CreateFrame("Frame", nil, CastBar)
	CastBar.Background:SetTemplate("Default")
	CastBar.Background:SetBackdropBorderColor(C["general"].BorderColor[1] * 0.7, C["general"].BorderColor[2] * 0.7, C["general"].BorderColor[3] * 0.7)
	CastBar.Background:Point("TOPLEFT", -2, 2)
	CastBar.Background:Point("BOTTOMRIGHT", 2, -2)
	CastBar.Background:SetFrameLevel(5)

	-- Border for CastBar
	local CastBarBorder = CreateFrame("Frame", nil, CastBar)
	CastBarBorder:SetPoint("TOPLEFT", CastBar, "TOPLEFT", D.Scale(-2), D.Scale(2))
	CastBarBorder:SetPoint("BOTTOMRIGHT", CastBar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	CastBarBorder:SetTemplate("Default")
	CastBarBorder:CreateShadow("Default")
	CastBarBorder:SetFrameLevel(2)

	CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
	CastBar.Time:SetFontObject(Font)
	CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
	CastBar.Time:SetJustifyH("RIGHT")

	CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
	CastBar.Text:SetFontObject(Font)
	CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
	CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

	CastBar.Button = CreateFrame("Frame", nil, CastBar)
	CastBar.Button:Size(20, 20)
	CastBar.Button:SetTemplate()
	CastBar.Button:SetPoint("LEFT", CastBar, "RIGHT", 4, 0)
	CastBar.Button:SetBackdropBorderColor(C["general"].BorderColor[1] * 0.7, C["general"].BorderColor[2] * 0.7, C["general"].BorderColor[3] * 0.7)
	CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
	CastBar.Icon:SetInside()
	CastBar.Icon:SetTexCoord(unpack(D.IconCoord))

	CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
	CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
	CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
	CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

	self.Castbar = CastBar
	self.Castbar.Icon = CastBar.Icon
	self.CastBarBorder = CastBarBorder
	
	if C["plugins"].FocusButton then
		local Focus = CreateFrame("Button", nil, self, "SecureActionButtonTemplate")
		Focus:Size(50, 10)
		Focus:SetTemplate("Default")
		Focus:EnableMouse(true)
		Focus:RegisterForClicks("AnyUp")
		Focus:StripTextures()
		
		Focus:SetPoint("TOP", Health, "TOPRIGHT", -25, 15)
		Focus:SetAttribute("type1", "macro")
		Focus:SetAttribute("macrotext1", "/clearfocus")
		Focus:SetFrameLevel(Health:GetFrameLevel() + 2)
		
		Focus.Text = Focus:CreateFontString(nil, "OVERLAY")
		Focus.Text:SetFont(C["medias"].Font, 12, "THINOUTLINE")
		Focus.Text:SetShadowOffset(0, 0)
		Focus.Text:SetPoint("CENTER")
		Focus.Text:SetText("Clear Focus") -- D.panelcolor..
	end

	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
	self.Name = Name
	self.Debuffs = Debuffs
end