local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Panels = D["Panels"]

function DuffedUIUnitFrames:Target()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Panel = CreateFrame("Frame", nil, self)
	Panel:Height(17)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(23)
	Health:SetPoint("TOPLEFT", 0, -16)
	Health:SetPoint("TOPRIGHT", 0, -16)
	Health:SetStatusBarTexture(C["medias"].Normal)

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

	Health:FontString("Value", C["medias"].Font, 12, "THINOUTLINE")
	Health.Value:Point("LEFT", Health, "LEFT", 4, 0)

	Health.frequentUpdates = true
	if C["unitframes"].UniColor == true then
		Health.colorDisconnected = false
		Health.colorClass = false
		Health:SetStatusBarColor(unpack(C["unitframes"].HealthBarColor))
		Health.Background:SetVertexColor(unpack(C["unitframes"].HealthBGColor))
		--[[if C["unitframes"].ColorGradient then
			Health.colorSmooth = true
			Health.Background:SetTexture(0, 0, 0)
		end]]--
	else
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
		Health.Background:SetTexture(.1, .1, .1)
	end
	Health.colorTapping = true

	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealth

	if (C["unitframes"].Smooth) then
		Health.Smooth = true
	end

	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(2)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -3)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -3)
	Power:SetStatusBarTexture(C["medias"].Normal)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C["medias"].Normal)
	Power.Background.multiplier = 0.3

	-- Border for PowerBar
	local PowerBorder = CreateFrame("Frame", nil, Power)
	PowerBorder:SetPoint("TOPLEFT", Power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:CreateShadow("Default")
	PowerBorder:SetFrameLevel(2)

	Power:FontString("Value", C["medias"].Font, 12, "THINOUTLINE")
	Power.Value:Point("RIGHT", Health, "RIGHT", -4, 0)

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("TOPRIGHT",-4,18)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Health:CreateFontString(nil, "OVERLAY")
	Status:SetFont(C["medias"].AltFont, 12)
	Status:Point("CENTER", Health, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY")
	Leader:Size(14, 14)
	Leader:Point("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Size(14, 14)
	MasterLooter:Point("TOPRIGHT", -2, 8)

	if (C["castbar"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(C["medias"].Normal)
		CastBar:SetHeight(18)
		CastBar:SetWidth(225)
		CastBar:SetFrameLevel(6)
		CastBar:Point("BOTTOM", Panels.ActionBar1, "TOP", 0, 250)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C["medias"].Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		-- Border for CastBar
		local CastBorder = CreateFrame("Frame", nil, CastBar)
		CastBorder:SetPoint("TOPLEFT", CastBar, "TOPLEFT", D.Scale(-2), D.Scale(2))
		CastBorder:SetPoint("BOTTOMRIGHT", CastBar, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		CastBorder:SetTemplate("Default")
		CastBorder:CreateShadow("Default")
		CastBorder:SetFrameLevel(2)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["medias"].Font, 12, "THINOUTLINE")
		CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["medias"].Font, 12, "THINOUTLINE")
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
		Portrait:Size(45)
		Portrait:SetPoint("BOTTOMLEFT", PowerBorder, "BOTTOMRIGHT", 4, 2)
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
		CombatFeedbackText:SetFont(C["medias"].AltFont, 14, "OUTLINE")
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
	Name:Point("TOPLEFT", Health, "TOPLEFT", 4, 17)
	Name:SetJustifyH("LEFT")
	Name:SetFont(C["medias"].Font, 12, "THINOUTLINE")

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
	
	local ComboPoints = CreateFrame("Frame", nil, self)
	ComboPoints:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ComboPoints:Width(250)
	ComboPoints:Height(8)
	ComboPoints:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	ComboPoints:SetBackdropColor(0, 0, 0)
	ComboPoints:SetBackdropBorderColor(unpack(C["medias"].BorderColor))

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
		ComboPoints[i]:Height(8)
		ComboPoints[i]:SetStatusBarTexture(C["medias"].Normal)
		
		if i == 1 then
			ComboPoints[i]:Point("LEFT", ComboPoints, "LEFT", 0, 0)
			ComboPoints[i]:Width(250 / 5)
		else
			ComboPoints[i]:Point("LEFT", ComboPoints[i-1], "RIGHT", 1, 0)
			ComboPoints[i]:Width(250 / 5 - 1)
		end					
	end
	
	ComboPoints:SetScript("OnShow", function(self) 
		DuffedUIUnitFrames.UpdateShadow(self, 12)
		DuffedUIUnitFrames.UpdateAurasHeaderPosition(self, 14)
	end)

	ComboPoints:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, 4)
		DuffedUIUnitFrames.UpdateAurasHeaderPosition(self, 4)
	end)

	self.Buffs = Buffs
	self.Debuffs = Debuffs

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong] [DuffedUI:DiffColor][level] [shortclassification]")
	self.Name = Name
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
	self.ComboPointsBar = ComboPoints
end