local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Panels = D["Panels"]
local Class = select(2, UnitClass("player"))
local Layout = C["unitframes"].Layout
local Font = D.GetFont(C["unitframes"].Font)
local HealthTexture = D.GetTexture(C["unitframes"].HealthTexture)
local PowerTexture = D.GetTexture(C["unitframes"].PowerTexture)

function DuffedUIUnitFrames:Player()
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

	if C["unitframes"].Percent then
		local percHP
		percHP = D.SetFontString(Health, C["medias"].Font, 20, "THINOUTLINE")
		percHP:SetTextColor(unpack(C["medias"].PrimaryDataTextColor))
		percHP:SetPoint("LEFT", Health, "RIGHT", 25, -10)
		--[[elseif unit == "target" then
			percHP:SetPoint("RIGHT", health, "LEFT", -25, -10)
		end]]--
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
		Power:Point("TOPRIGHT", Panel, "BOTTOMRIGHT", -2, -5)
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
		L1:Point("RIGHT", Power, "LEFT", -3, 0)
		L2:SetTemplate("Default")
		L2:Size(2, 8)
		L2:Point("BOTTOM", L1, "LEFT", 0, -1)
	end

	Power.Value = Health:CreateFontString(nil, "OVERLAY")
	Power.Value:SetFontObject(Font)
	if (Layout == 1) then
		Power.Value:Point("TOPLEFT", Health, "TOPLEFT", 4, 17)
	elseif (Layout == 2) then
		Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)
	elseif (Layout == 3) then
		Power.Value:Point("LEFT", Health, "LEFT", 4, 0)
	end

	Power.frequentUpdates = true
	if C["unitframes"].UniColor then
		Power.colorClass = true
	else
		Power.colorPower = true
	end
	Power.colorDisconnected = true
	if (C["unitframes"].Smooth) then Power.Smooth = true end

	Power.PostUpdate = DuffedUIUnitFrames.PostUpdatePower

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("TOP", Health, "TOPRIGHT", 0, 12)
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
	MasterLooter:Point("TOPLEFT", 18, 8)

	if (C["castbar"].CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(Texture)
		CastBar:SetHeight(21)
		if C["castbar"].CastBarIcon then CastBar:SetWidth(Panels.ActionBar1:GetWidth() - 32) else CastBar:SetWidth(Panels.ActionBar1:GetWidth()) end
		CastBar:SetFrameLevel(6)
		CastBar:Point("BOTTOMRIGHT", Panels.ActionBar1, "TOPRIGHT", -2, 5)

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
			CastBar.Button:Point("RIGHT", CastBar, "LEFT", -5, 0)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(D.IconCoord))
		end

		if (C["castbar"].CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(Texture)
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
		if (Layout == 1) then
			Portrait:Size(45)
			Portrait:SetPoint("BOTTOMRIGHT", PowerBorder, "BOTTOMLEFT", -4, 2)
		elseif (Layout == 2) then
			Portrait:Size(38)
			Portrait:SetPoint("BOTTOMRIGHT", Panel, "BOTTOMLEFT", -5, 2)
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

	if (C["unitframes"].HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(Texture)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, .5)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(Texture)
		SecondBar:SetStatusBarColor(0, 0.3, 0, .5)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(Texture)
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

	if (D.MyClass == "SHAMAN") or (D.MyClass == "MAGE") or (D.MyClass == "DRUID") then
		-- Default layout of Totems match Shaman class.
		local Bar = CreateFrame("Frame", nil, self)
		Bar:Point("TOP", AnchorFrameRessources, "BOTTOM", 0, -2)
		Bar:Size(202, 8)

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
			Bar[i]:SetStatusBarTexture(Texture)
			Bar[i]:EnableMouse(true)

			if i == 1 then
				Bar[i]:Width((200 / 4) - 2)
				Bar[i]:Point("LEFT", Bar, "LEFT", 0, 0)
			else
				Bar[i]:Width((200 / 4) - 1)
				Bar[i]:Point("LEFT", Bar[i-1], "RIGHT", 1, 0)
			end

			Bar[i]:SetBackdrop(DuffedUIUnitFrames.Backdrop)
			Bar[i]:SetBackdropColor(0, 0, 0)
			Bar[i]:SetMinMaxValues(0, 1)

			Bar[i].bg = Bar[i]:CreateTexture(nil, "BORDER")
			Bar[i].bg:SetAllPoints()
			Bar[i].bg:SetTexture(Texture)
			Bar[i].bg.multiplier = 0.3
		end

		Bar:RegisterEvent("PLAYER_REGEN_DISABLED")
		Bar:RegisterEvent("PLAYER_REGEN_ENABLED")
		Bar:RegisterEvent("PLAYER_ENTERING_WORLD")
		Bar:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then
					Bar:SetAlpha(0)
				end
			end
		end)

		self.Totems = Bar
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD", DuffedUIUnitFrames.Update)
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