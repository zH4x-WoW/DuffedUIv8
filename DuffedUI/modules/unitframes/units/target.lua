local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Panels = D["Panels"]
local Layout = C["unitframes"].Layout
local Font = D.GetFont(C["unitframes"].Font)
local HealthTexture = D.GetTexture(C["unitframes"].HealthTexture)
local PowerTexture = D.GetTexture(C["unitframes"].PowerTexture)

function DuffedUIUnitFrames:Target()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Panel = CreateFrame("Frame", nil, self)
	if (Layout == 1) then
		Panel:Height(17)
	elseif (Layout == 2) then
		Panel:Size(217, 13)
		Panel:SetTemplate("Default")
		Panel:Point("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
		Panel:SetFrameLevel(2)
		Panel:SetFrameStrata("MEDIUM")
	elseif (Layout == 3) then
		Panel:SetTemplate("Default")
		Panel:Size(217, 21)
		Panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
		Panel:SetAlpha(0)
	end

	local Health = CreateFrame("StatusBar", nil, self)
	if (Layout == 1) then
		Health:Height(23)
		Health:SetPoint("TOPLEFT", 0, -16)
		Health:SetPoint("TOPRIGHT", 0, -16)
	elseif (Layout == 2) then
		Health:Height(22)
		Health:SetPoint("BOTTOMLEFT", Panel, "TOPLEFT", 2, 5)
		Health:SetPoint("BOTTOMRIGHT", Panel, "TOPRIGHT", -2, 5)
	elseif (Layout == 3) then
		Health:Height(20)
		Health:SetPoint("TOPLEFT")
		Health:SetPoint("TOPRIGHT")
	end
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)

	-- Border for HealthBar
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(Font)
	if (Layout == (1 or 2)) then
		Health.Value:Point("LEFT", Health, "LEFT", 4, 0)
	elseif (Layout == 3) then
		Health.Value:Point("RIGHT", Health, "RIGHT", -4, 0)
	end

	Health.frequentUpdates = true
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
	Health.colorTapping = true

	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if (C["unitframes"].Smooth) then Health.Smooth = true end

	if C["unitframes"].Percent then
		local percHP
		percHP = D.SetFontString(Health, C["medias"].Font, 20, "THINOUTLINE")
		percHP:SetTextColor(unpack(C["medias"].PrimaryDataTextColor))
		percHP:SetPoint("RIGHT", Health, "LEFT", -25, -10)
		self:Tag(percHP, "[DuffedUI:perchp]")
		self.percHP = percHP
	end

	local Power = CreateFrame("StatusBar", nil, self)
	if (Layout == 1) then
		Power:Height(2)
		Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -3)
		Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -3)
	elseif (Layout == 2) then
		Power:Size(140, 5)
		Power:Point("TOPLEFT", Panel, "BOTTOMLEFT", 2, -5)
	elseif (Layout == 3) then
		Power:Size(228, 18)
		Power:Point("TOP", Health, "BOTTOM", 2, 9)
		Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 5, -2)
		Power:SetStatusBarTexture(Texture)
		Power:SetFrameLevel(Health:GetFrameLevel() + 2)
		Power:SetFrameStrata("BACKGROUND")
	end
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(.1, .1, .1)
	Power.Background.multiplier = 0.3

	-- Border for PowerBar
	local PowerBorder = CreateFrame("Frame", nil, Power)
	PowerBorder:SetPoint("TOPLEFT", Power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:CreateShadow("Default")
	PowerBorder:SetFrameLevel(2)

	if (Layout == 2) then
		local L1 = CreateFrame("Frame", nil, Power)
		local L2 = CreateFrame("Frame", nil, L1)

		L1:SetTemplate("Default")
		L1:Size(9, 2)
		L1:Point("LEFT", Power, "RIGHT", 3, 0)
		L2:SetTemplate("Default")
		L2:Size(2, 8)
		L2:Point("BOTTOM", L1, "RIGHT", 0, -1)
	end

	Power.Value = Power:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	Power.Value:Point("RIGHT", Health, "RIGHT", -4, 0)
	if (Layout == 3) then Power.Value:Hide() end

	Power.frequentUpdates = true
	if C["unitframes"].UniColor then
		Power.colorTapping = true
		Power.colorClass = true
	else
		Power.colorPower = true
	end
	Power.colorDisconnected = true
	if (C["unitframes"].Smooth) then Power.Smooth = true end

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("TOPRIGHT",-4,18)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Health:CreateFontString(nil, "OVERLAY")
	Status:SetFontObject(Font)
	Status:Point("CENTER", Health, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY")
	Leader:Size(14, 14)
	Leader:Point("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Size(14, 14)
	MasterLooter:Point("TOPRIGHT", -2, 8)
	
	if (C["unitframes"].HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(C["medias"].Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, .5)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(C["medias"].Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, .5)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(C["medias"].Normal)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, .5)

		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)

		self.HealPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absBar = ThirdBar,
			maxOverflow = 1,
		}
	end

	if (C["castbar"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(Texture)
		CastBar:SetHeight(18)
		CastBar:SetWidth(225)
		CastBar:SetFrameLevel(6)
		CastBar:Point("BOTTOM", Panels.ActionBar1, "TOP", 0, 260)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(Texture)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		-- Border for CastBar
		local CastBorder = CreateFrame("Frame", nil, CastBar)
		CastBorder:SetPoint("TOPLEFT", CastBar, "TOPLEFT", D.Scale(-2), D.Scale(2))
		CastBorder:SetPoint("BOTTOMRIGHT", CastBar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		CastBorder:SetTemplate("Default")
		CastBorder:CreateShadow("Default")
		CastBorder:SetFrameLevel(2)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFontObject(Font)
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFontObject(Font)
		CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		if (C["castbar"].CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:Size(25)
			CastBar.Button:SetTemplate()
			CastBar.Button:CreateShadow()
			CastBar.Button:Point("BOTTOM", CastBar, "TOP", 0, 5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(D.IconCoord))
		end

		CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
		CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

		self.Castbar = CastBar
	end

	-- portraits
	if C["unitframes"].CharPortrait == true then
		local Portrait = CreateFrame("Frame", nil, self)
		if (Layout == 1) then
			Portrait:Size(45)
			Portrait:SetPoint("BOTTOMLEFT", PowerBorder, "BOTTOMRIGHT", 4, 2)
		elseif (Layout == 2) then
			Portrait:Size(38)
			Portrait:SetPoint("BOTTOMLEFT", Panel, "BOTTOMRIGHT", 5, 2)
		elseif (Layout == 3) then
			Portrait:SetFrameLevel(Health:GetFrameLevel())
			Portrait:SetAlpha(0.15)
			Portrait:SetAllPoints(Health)
		end
		Portrait:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Portrait:SetBackdropColor(0, 0, 0)
		Portrait:CreateShadow()
		
		Portrait.Model = CreateFrame("PlayerModel", nil, Portrait)
		Portrait.Model:SetInside(Portrait, 1, 1)

		-- Border for Portrait
		local PortraitBorder = CreateFrame("Frame", nil, Portrait)
		PortraitBorder:SetPoint("TOPLEFT", Portrait, "TOPLEFT", D.Scale(-2), D.Scale(2))
		PortraitBorder:SetPoint("BOTTOMRIGHT", Portrait, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		PortraitBorder:SetTemplate("Default")
		PortraitBorder:CreateShadow("Default")
		PortraitBorder:SetFrameLevel(2)
		
		self.Portrait = Portrait.Model
	end

	if (C["unitframes"].CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY")
		CombatFeedbackText:SetFontObject(Font)
		CombatFeedbackText:SetPoint("CENTER", 0, 1)
		CombatFeedbackText.colors = {
			DAMAGE = {0.69, 0.31, 0.31},
			CRUSHING = {0.69, 0.31, 0.31},
			CRITICAL = {0.69, 0.31, 0.31},
			GLANCING = {0.69, 0.31, 0.31},
			STANDARD = {0.84, 0.75, 0.65},
			IMMUNE = {0.84, 0.75, 0.65},
			ABSORB = {0.84, 0.75, 0.65},
			BLOCK = {0.84, 0.75, 0.65},
			RESIST = {0.84, 0.75, 0.65},
			MISS = {0.84, 0.75, 0.65},
			HEAL = {0.33, 0.59, 0.33},
			CRITHEAL = {0.33, 0.59, 0.33},
			ENERGIZE = {0.31, 0.45, 0.63},
			CRITENERGIZE = {0.31, 0.45, 0.63},
		}

		self.CombatFeedbackText = CombatFeedbackText
	end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	if (Layout == 1) then
		Name:Point("TOPLEFT", Health, "TOPLEFT", 4, 17)
		Name:SetFontObject(Font)
	elseif (Layout == 2) then
		Name:Point("TOPLEFT", Panel, "TOPLEFT", 4, -1)
		Name:SetFontObject(Font)
	elseif (Layout == 3) then
		Name:Point("LEFT", Health, "LEFT", 4, 0)
		Name:SetFontObject(Font)
	end
	Name:SetJustifyH("LEFT")

	------ Special Note ------
	-- The animation is currently broken. I tried some things out but i dont get it working at the moment.
	-- Also the icons in PostCreateAura are not working.
	--------------------------
	local Buffs = CreateFrame("Frame", nil, self)
	local Debuffs = CreateFrame("Frame", nil, self)

	Buffs:Point("BOTTOMLEFT", self, "TOPLEFT", -2, 4)

	Buffs:SetHeight(26)
	Buffs:SetWidth(218)
	Buffs.size = 22
	Buffs.num = 36
	Buffs.numRow = 9

	Debuffs:SetHeight(26)
	Debuffs:SetWidth(218)
	Debuffs:SetPoint("BOTTOMLEFT", Buffs, "TOPLEFT", 1, 0)
	Debuffs.size = 22
	Debuffs.num = 36

	Buffs.spacing = 3
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	Buffs.PostUpdate = DuffedUIUnitFrames.UpdateTargetDebuffsHeader

	Debuffs.spacing = 3
	Debuffs.initialAnchor = "TOPRIGHT"
	Debuffs["growth-y"] = "UP"
	Debuffs["growth-x"] = "LEFT"
	Debuffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	Debuffs.onlyShowPlayer = C["unitframes"].OnlySelfDebuffs

	self.Buffs = Buffs
	self.Debuffs = Debuffs
	
	if C["plugins"].FocusButton then
		local Focus = CreateFrame("Button", nil, self, "SecureActionButtonTemplate")
		Focus:Size(50, 10)
		Focus:SetTemplate("Default")
		Focus:EnableMouse(true)
		Focus:RegisterForClicks("AnyUp")
		Focus:StripTextures()
		
		if (Layout == 1) then
			Focus:SetPoint("BOTTOMLEFT", Power, "BOTTOMLEFT", -13, -15)
		elseif (Layout == 2) then
			Focus:SetPoint("BOTTOMRIGHT", Panel, "BOTTOMRIGHT", 12, -13)
		elseif (Layout == 3) then
			Focus:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", 16, -15)
		end
		Focus:SetAttribute("type1", "macro")
		Focus:SetAttribute("macrotext1", "/focus")
		Focus:SetFrameLevel(Power:GetFrameLevel() + 2)
		
		Focus.Text = Focus:CreateFontString(nil, "OVERLAY")
		Focus.Text:SetFont(C["medias"].Font, 12, "THINOUTLINE")
		Focus.Text:SetShadowOffset(0, 0)
		Focus.Text:SetPoint("CENTER")
		Focus.Text:SetText("Focus") -- D.panelcolor..
	end

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong] [DuffedUI:DiffColor][level] [shortclassification]")
	self.Name = Name
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
end