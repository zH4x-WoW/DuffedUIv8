local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]

function DuffedUIUnitFrames:Target()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetTemplate()
	Panel:Size(250, 21)
	Panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")
	Panel:SetBackdropBorderColor(C["Media"].BorderColor[1] * 0.7, C["Media"].BorderColor[2] * 0.7, C["Media"].BorderColor[3] * 0.7)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(26)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["Media"].Normal)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)

	Health:FontString("Value", C["Media"].AltFont, 12)
	Health.Value:Point("RIGHT", Panel, "RIGHT", -4, 0)

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
	Power:Height(8)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(C["Media"].Normal)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C["Media"].Normal)
	Power.Background.multiplier = 0.3

	Power:FontString("Value", C["Media"].AltFont, 12)
	Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:Point("LEFT", Panel, "LEFT", 4, 0)
	Name:SetJustifyH("LEFT")
	Name:SetFont(C["Media"].AltFont, 12)

	------ Special Note ------
	-- The animation is currently broken. I tried some things out but i dont get it working at the moment.
	-- Also the icons in PostCreateAura are not working.
	--------------------------
	local Buffs = CreateFrame("Frame", nil, self)
	local Debuffs = CreateFrame("Frame", nil, self)

	Buffs:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 4)

	Buffs:SetHeight(26)
	Buffs:SetWidth(252)
	Buffs.size = 26
	Buffs.num = 36
	Buffs.numRow = 9

	Debuffs:SetHeight(26)
	Debuffs:SetWidth(252)
	Debuffs:SetPoint("BOTTOMLEFT", Buffs, "TOPLEFT", -2, 2)
	Debuffs.size = 26
	Debuffs.num = 36

	Buffs.spacing = 2
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	Buffs.PostUpdate = DuffedUIUnitFrames.UpdateTargetDebuffsHeader

	Debuffs.spacing = 2
	Debuffs.initialAnchor = "TOPRIGHT"
	Debuffs["growth-y"] = "UP"
	Debuffs["growth-x"] = "LEFT"
	Debuffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	Debuffs.onlyShowPlayer = C["UnitFrames"].OnlySelfDebuffs

	local ComboPoints = CreateFrame("Frame", nil, self)
	ComboPoints:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ComboPoints:Width(250)
	ComboPoints:Height(8)
	ComboPoints:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	ComboPoints:SetBackdropColor(0, 0, 0)
	ComboPoints:SetBackdropBorderColor(unpack(C["Media"].BorderColor))

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
		ComboPoints[i]:Height(8)
		ComboPoints[i]:SetStatusBarTexture(C["Media"].Normal)

		if i == 1 then
			ComboPoints[i]:Point("LEFT", ComboPoints, "LEFT", 0, 0)
			ComboPoints[i]:Width(250 / 5)
		else
			ComboPoints[i]:Point("LEFT", ComboPoints[i-1], "RIGHT", 1, 0)
			ComboPoints[i]:Width(250 / 5 - 1)
		end
	end

	ComboPoints:SetScript("OnShow", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
		DuffedUIUnitFrames.UpdateAurasHeaderPosition(self, "OnShow", 0, 14)
	end)

	ComboPoints:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
		DuffedUIUnitFrames.UpdateAurasHeaderPosition(self, "OnHide", 0, 4)
	end)

	self.Buffs = Buffs
	self.Debuffs = Debuffs

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong] [DuffedUI:DiffColor][level] [shortclassification]")
	self.Name = Name
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.ComboPointsBar = ComboPoints
end