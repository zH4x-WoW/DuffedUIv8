local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Panels = D["Panels"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:Player()
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
	Health.Value:Point("RIGHT", Health, "RIGHT", -4, 0)

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
	Power.Value:Point("TOPLEFT", Health, "TOPLEFT", 4, 17)

	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("TOPRIGHT",-4,18)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Health:CreateFontString(nil, "OVERLAY")
	Status:SetFont(C["medias"].Font, 12)
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
		CastBar:SetHeight(21)
		if C["castbar"].CastBarIcon then CastBar:SetWidth(Panels.ActionBar1:GetWidth() - 32) else CastBar:SetWidth(Panels.ActionBar1:GetWidth()) end
		CastBar:SetFrameLevel(6)
		CastBar:Point("BOTTOMRIGHT", Panels.ActionBar1, "TOPRIGHT", -2, 5)

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
			CastBar.Button:Point("RIGHT", CastBar, "LEFT", -5, 0)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(D.IconCoord))
		end

		if (C["castbar"].CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(C["medias"].Normal)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
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
		Portrait:SetPoint("BOTTOMRIGHT", PowerBorder, "BOTTOMLEFT", -4, 2)
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
		CombatFeedbackText:SetFont(C["medias"].Font, 14, "OUTLINE")
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

	if (C["unitframes"].HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(C["medias"].Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(C["medias"].Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(C["medias"].Normal)
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

	if (C["unitframes"].TotemBar) then
		-- Default layout of Totems match Shaman class.
		local Bar = CreateFrame("Frame", nil, self)
		Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		Bar:Size(250, 8)

		Bar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Bar:SetBackdropColor(0, 0, 0)
		Bar:SetBackdropBorderColor(0, 0, 0)

		Bar.activeTotems = 0
		Bar.Override = DuffedUIUnitFrames.UpdateTotemOverride

		Bar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateShadow(self, 12)
		end)

		Bar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateShadow(self, 4)
		end)
		
		-- Totem Bar
		for i = 1, MAX_TOTEMS do
			Bar[i] = CreateFrame("StatusBar", nil, Bar)
			Bar[i]:Height(8)
			Bar[i]:SetStatusBarTexture(C["medias"].Normal)
			Bar[i]:EnableMouse(true)

			if i == 1 then
				Bar[i]:Width((250 / 4) - 2)
				Bar[i]:Point("LEFT", Bar, "LEFT", 0, 0)
			else
				Bar[i]:Width((250 / 4) - 1)
				Bar[i]:Point("LEFT", Bar[i-1], "RIGHT", 1, 0)
			end

			Bar[i]:SetBackdrop(DuffedUIUnitFrames.Backdrop)
			Bar[i]:SetBackdropColor(0, 0, 0)
			Bar[i]:SetMinMaxValues(0, 1)

			Bar[i].bg = Bar[i]:CreateTexture(nil, "BORDER")
			Bar[i].bg:SetAllPoints()
			Bar[i].bg:SetTexture(C["medias"].Normal)
			Bar[i].bg.multiplier = 0.3
		end
	
		self.Totems = Bar
	end

	-- Experience bar
	if (D.MyLevel ~= MAX_PLAYER_LEVEL) then
		local Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
		Experience:SetStatusBarTexture(C["medias"].Normal)
		Experience:SetStatusBarColor(0, 0.4, 1)
		Experience:SetOrientation("VERTICAL")
		Experience:Size(5, Minimap:GetHeight() + 20)
		Experience:Point("TOPLEFT", Minimap, "TOPLEFT", -12, 0)
		Experience:SetFrameLevel(2)

		Experience.Tooltip = true

		Experience.Rested = CreateFrame("StatusBar", nil, self)
		Experience.Rested:SetParent(Experience)
		Experience.Rested:SetAllPoints(Experience)
		Experience.Rested:SetStatusBarTexture(C["medias"].Normal)
		Experience.Rested:SetOrientation("VERTICAL")
		Experience.Rested:SetStatusBarColor(1, 0, 1, 0.3)

		-- Border for the experience bar
		local ExperienceBorder = CreateFrame("Frame", nil, Experience)
		ExperienceBorder:SetPoint("TOPLEFT", Experience, "TOPLEFT", D.Scale(-2), D.Scale(2))
		ExperienceBorder:SetPoint("BOTTOMRIGHT", Experience, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		ExperienceBorder:SetTemplate("Default")
		ExperienceBorder:SetFrameLevel(2)

		local Resting = Experience:CreateTexture(nil, "OVERLAY")
		Resting:SetHeight(28)
		Resting:SetWidth(28)
		Resting:SetPoint("LEFT", -18, 76)
		Resting:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
		Resting:SetTexCoord(0, 0.5, 0, 0.421875)

		self.Resting = Resting
		self.Experience = Experience
	end

	-- Reputation bar
	if (D.MyLevel == MAX_PLAYER_LEVEL) then
		local Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
		Reputation:SetStatusBarTexture(C["medias"].Normal)
		Reputation:SetOrientation("VERTICAL")
		Reputation:Size(5, Minimap:GetHeight() + 20)
		Reputation:Point("TOPLEFT", Minimap, "TOPLEFT", -12, 0)
		Reputation:SetFrameLevel(2)

		-- Border for the experience bar
		local ReputationBorder = CreateFrame("Frame", nil, Reputation)
		ReputationBorder:SetPoint("TOPLEFT", Reputation, "TOPLEFT", D.Scale(-2), D.Scale(2))
		ReputationBorder:SetPoint("BOTTOMRIGHT", Reputation, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		ReputationBorder:SetTemplate("Default")
		ReputationBorder:SetFrameLevel(2)

		Reputation.PostUpdate = DuffedUIUnitFrames.UpdateReputationColor
		Reputation.Tooltip = true
		self.Reputation = Reputation
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD", DuffedUIUnitFrames.Update) -- http://www.tukui.org/tickets/tukui/index.php?page=bug_show&bug_id=218
	self:HookScript("OnEnter", DuffedUIUnitFrames.MouseOnPlayer)
	self:HookScript("OnLeave", DuffedUIUnitFrames.MouseOnPlayer)
	
	-- Register with oUF
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
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