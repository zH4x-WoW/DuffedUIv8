local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:Player()
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
	Panel:SetBackdropBorderColor(C["Medias"].BorderColor[1] * 0.7, C["Medias"].BorderColor[2] * 0.7, C["Medias"].BorderColor[3] * 0.7)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(26)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C["Medias"].Normal)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)

	Health:FontString("Value", C["Medias"].AltFont, 12)
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
	Power:SetStatusBarTexture(C["Medias"].Normal)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C["Medias"].Normal)
	Power.Background.multiplier = 0.3

	Power:FontString("Value", C["Medias"].AltFont, 12)
	Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("LEFT",0,1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Panel:CreateFontString(nil, "OVERLAY")
	Status:SetFont(C["Medias"].AltFont, 12)
	Status:Point("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY")
	Leader:Size(14, 14)
	Leader:Point("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Size(14, 14)
	MasterLooter:Point("TOPRIGHT", -2, 8)

	if (C["UnitFrames"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(C["Medias"].Normal)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C["Medias"].Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["Medias"].AltFont, 12)
		CastBar.Time:Point("RIGHT", Panel, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["Medias"].AltFont, 12)
		CastBar.Text:Point("LEFT", Panel, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		if (C["UnitFrames"].CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:Size(26)
			CastBar.Button:SetTemplate()
			CastBar.Button:CreateShadow()
			CastBar.Button:Point("LEFT", -46.5, 26.5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(D.IconCoord))
		end

		if (C["UnitFrames"].CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(C["Medias"].Normal)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end

		CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
		CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

		self.Castbar = CastBar
	end

	if (C["UnitFrames"].CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY")
		CombatFeedbackText:SetFont(C["Medias"].AltFont, 14, "OUTLINE")
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

	if (C["UnitFrames"].HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(C["Medias"].Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(C["Medias"].Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(C["Medias"].Normal)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, 1)

		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)

		self.HealPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absBar = ThirdBar,
			maxOverflow = 1,
		}
	end

	if (C["UnitFrames"].StatueBar) then
		local Bar = CreateFrame("StatusBar", nil, self)
		Bar:Size(250, 8)
		Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		Bar:SetStatusBarTexture(C["Medias"].Normal)

		Bar.Backdrop = CreateFrame("Frame", nil, Bar)
		Bar.Backdrop:SetAllPoints()
		Bar.Backdrop:SetFrameLevel(Bar:GetFrameLevel() - 1)
		Bar.Backdrop:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Bar.Backdrop:SetBackdropColor(0, 0, 0)
		Bar.Backdrop:SetBackdropBorderColor(0,0,0)

		Bar.Background = Bar:CreateTexture(nil, "BORDER")
		Bar.Background:SetAllPoints()
		Bar:Hide()
		
		Bar:SetScript("OnShow", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
		end)

		Bar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
		end)

		self.Statue = Bar
	end
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD", DuffedUIUnitFrames.Update) -- http://www.tukui.org/tickets/tukui/index.php?page=bug_show&bug_id=218
	self:SetScript("OnEnter", DuffedUIUnitFrames.MouseOnPlayer)
	self:SetScript("OnLeave", DuffedUIUnitFrames.MouseOnPlayer)

	-- Register with oUF
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Combat = Combat
	self.Status = Status
	self.Leader = Leader
	self.MasterLooter = MasterLooter

	-- Classes
	if (Class == "DEATHKNIGHT") then
		DuffedUIUnitFrames.AddDeathKnightFeatures(self)
	elseif (Class == "DRUID") then
		DuffedUIUnitFrames.AddDruidFeatures(self)
	elseif (Class == "WARRIOR") then
		DuffedUIUnitFrames.AddWarriorFeatures(self)
	elseif (Class == "MAGE") then
		DuffedUIUnitFrames.AddMageFeatures(self)
	elseif (Class == "MONK") then
		DuffedUIUnitFrames.AddMonkFeatures(self)
	elseif (Class == "PALADIN") then
		DuffedUIUnitFrames.AddPaladinFeatures(self)
	elseif (Class == "PRIEST") then
		DuffedUIUnitFrames.AddPriestFeatures(self)
	elseif (Class == "ROGUE") then
		DuffedUIUnitFrames.AddRogueFeatures(self)
	elseif (Class == "SHAMAN") then
		DuffedUIUnitFrames.AddShamanFeatures(self)
	elseif (Class == "WARLOCK") then
		DuffedUIUnitFrames.AddWarlockFeatures(self)
	elseif (Class == "HUNTER") then
		DuffedUIUnitFrames.AddHunterFeatures(self)
	end
end