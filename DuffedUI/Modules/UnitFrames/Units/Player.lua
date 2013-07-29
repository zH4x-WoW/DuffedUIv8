local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local _, Class = UnitClass("player")

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

	if (C.UnitFrames.Smooth) then
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

	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Size(19, 19)
	Combat:Point("LEFT",0,1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)

	local Status = Panel:CreateFontString(nil, "OVERLAY")
	Status:SetFont(C["Media"].AltFont, 12)
	Status:Point("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY")
	Leader:Size(14, 14)
	Leader:Point("TOPLEFT", 2, 8)

	local MasterLooter = Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Size(14, 14)
	MasterLooter:Point("TOPRIGHT", -2, 8)

	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(C["Media"].Normal)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel)

		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C["Media"].Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)

		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C["Media"].AltFont, 12)
		CastBar.Time:Point("RIGHT", Panel, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")

		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C["Media"].AltFont, 12)
		CastBar.Text:Point("LEFT", Panel, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)

		if (C.UnitFrames.CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:Size(26)
			CastBar.Button:SetTemplate()
			CastBar.Button:CreateShadow()
			CastBar.Button:Point("LEFT", -46.5, 26.5)

			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(D.IconCoord))
		end

		if (C.UnitFrames.CastBarLatency) then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(C["Media"].Normal)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end

		CastBar.CustomTimeText = DuffedUIUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = DuffedUIUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = DuffedUIUnitFrames.CheckCast
		CastBar.PostChannelStart = DuffedUIUnitFrames.CheckChannel

		self.Castbar = CastBar
	end

	if (C.UnitFrames.CombatLog) then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY")
		CombatFeedbackText:SetFont(C["Media"].AltFont, 14, "OUTLINE")
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

	if (C.UnitFrames.HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, self.Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:SetWidth(250)
		FirstBar:SetStatusBarTexture(C["Media"].Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(C["Media"].Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(C["Media"].Normal)
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

	if (C.UnitFrames.StatueBar) then
		local Bar = CreateFrame("StatusBar", nil, self)
		Bar:Size(250, 8)
		--Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		Bar:SetStatusBarTexture(C["Media"].Normal)

		Bar.Backdrop = CreateFrame("Frame", nil, Bar)
		Bar.Backdrop:SetAllPoints()
		Bar.Backdrop:SetFrameLevel(Bar:GetFrameLevel() - 1)
		Bar.Backdrop:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Bar.Backdrop:SetBackdropColor(0, 0, 0)
		Bar.Backdrop:SetBackdropBorderColor(0,0,0)

		Bar.Background = Bar:CreateTexture(nil, "BORDER")
		Bar.Background:SetAllPoints()
		Bar:Hide()

		self.Statue = Bar
	end

	if (Class == "DEATHKNIGHT") then
		local RunesBar = CreateFrame("Frame", nil, self)
		RunesBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		RunesBar:Size(250, 8)
		RunesBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		RunesBar:SetBackdropColor(0, 0, 0)
		RunesBar:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 6 do
			RunesBar[i] = CreateFrame("StatusBar", nil, RunesBar)
			RunesBar[i]:Height(8)
			RunesBar[i]:SetStatusBarTexture(C["Media"].Normal)

			if i == 1 then
				RunesBar[i]:Width(40)
				RunesBar[i]:Point("LEFT", RunesBar, "LEFT", 0, 0)
			else
				RunesBar[i]:Width(41)
				RunesBar[i]:Point("LEFT", RunesBar[i-1], "RIGHT", 1, 0)
			end
		end

		RunesBar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)

		RunesBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		self.Statue:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 22)
		end)

		self.Statue:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 12)
		end)

		self.Statue:ClearAllPoints()
		self.Statue:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)

		self.Runes = RunesBar
	elseif (Class == "DRUID") then
		-- Druid
	elseif (Class == "MAGE") then
		local ArcaneChargeBar = CreateFrame("Frame", nil, self)
		ArcaneChargeBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		ArcaneChargeBar:Size(250, 8)
		ArcaneChargeBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		ArcaneChargeBar:SetBackdropColor(0, 0, 0)
		ArcaneChargeBar:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 4 do
			ArcaneChargeBar[i] = CreateFrame("StatusBar", nil, ArcaneChargeBar)
			ArcaneChargeBar[i]:Height(8)
			ArcaneChargeBar[i]:SetStatusBarTexture(C["Media"].Normal)

			if i == 1 then
				ArcaneChargeBar[i]:Width((250 / 4) - 2)
				ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
			else
				ArcaneChargeBar[i]:Width((250 / 4 - 1))
				ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
			end
		end

		ArcaneChargeBar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)

		ArcaneChargeBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		self.ArcaneChargeBar = ArcaneChargeBar
	elseif (Class == "MONK") then
		-- Monk
	elseif (Class == "PALADIN") then
		local HPBar = CreateFrame("Frame", nil, self)
		HPBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		HPBar:Size(250, 8)
		HPBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		HPBar:SetBackdropColor(0, 0, 0)
		HPBar:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 5 do
			HPBar[i] = CreateFrame("StatusBar", nil, HPBar)
			HPBar[i]:Height(8)
			HPBar[i]:SetStatusBarTexture(C["Media"].Normal)
			HPBar[i]:SetStatusBarColor(0.89, 0.88, 0.06)

			if i == 1 then
				HPBar[i]:Width(49)
				HPBar[i]:Point("LEFT", HPBar, "LEFT", 0, 0)
			else
				HPBar[i]:Width(50)
				HPBar[i]:Point("LEFT", HPBar[i-1], "RIGHT", 1, 0)
			end
		end

		HPBar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)

		HPBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		self.HolyPower = HPBar
	elseif (Class == "PRIEST") then
		local SOBar = CreateFrame("Frame", nil, self)
		SOBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		SOBar:Size(250, 8)
		SOBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		SOBar:SetBackdropColor(0, 0, 0)
		SOBar:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 3 do
			SOBar[i] = CreateFrame("StatusBar", nil, SOBar)
			SOBar[i]:Height(8)
			SOBar[i]:SetStatusBarTexture(C["Media"].Normal)

			if i == 1 then
				SOBar[i]:Width((250 / 3) - 1)
				SOBar[i]:Point("LEFT", SOBar, "LEFT", 0, 0)
			else
				SOBar[i]:Width((250 / 3))
				SOBar[i]:Point("LEFT", SOBar[i-1], "RIGHT", 1, 0)
			end
		end

		SOBar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)

		SOBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		self.ShadowOrbsBar = SOBar

		if (C.UnitFrames.WeakBar) then
			local WSBar = CreateFrame("StatusBar", nil, Power)
			WSBar:SetAllPoints(Power)
			WSBar:SetStatusBarTexture(C["Media"].Normal)
			WSBar:GetStatusBarTexture():SetHorizTile(false)
			WSBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
			WSBar:SetBackdropColor(unpack(C["Media"].BackdropColor))
			WSBar:SetStatusBarColor(0.75, 0.04, 0.04)

			self.WeakenedSoul = WSBar
		end
	elseif (Class == "ROGUE") then
		-- Rogue
	elseif (Class == "SHAMAN") then
		local TotemBar = {}

		local TotemBar = CreateFrame("Frame", nil, self)
		TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		TotemBar:Size(250, 8)
		TotemBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		TotemBar:SetBackdropColor(0, 0, 0)
		TotemBar:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 4 do
			TotemBar[i] = CreateFrame("StatusBar", nil, TotemBar)
			TotemBar[i]:Height(8)
			TotemBar[i]:SetStatusBarTexture(C["Media"].Normal)

			if i == 1 then
				TotemBar[i]:Width((250 / 4) - 2)
				TotemBar[i]:Point("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width((250 / 4 - 1))
				TotemBar[i]:Point("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
			end

			TotemBar[i]:SetBackdrop(backdrop)
			TotemBar[i]:SetBackdropColor(0, 0, 0)
			TotemBar[i]:SetMinMaxValues(0, 1)

			TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
			TotemBar[i].bg:SetAllPoints(TotemBar[i])
			TotemBar[i].bg:SetTexture(C["Media"].Normal)
			TotemBar[i].bg.multiplier = 0.3
		end

		TotemBar:SetScript("OnShow", function(self) 
			DuffedUIUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)

		TotemBar:SetScript("OnHide", function(self)
			DuffedUIUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		TotemBar.Destroy = true
		self.TotemBar = TotemBar

	elseif (Class == "WARRIOR") then
		-- Warrior
	elseif (Class == "WARLOCK") then
		-- Warlock
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD", DuffedUIUnitFrames.Update) -- http://www.tukui.org/tickets/tukui/index.php?page=bug_show&bug_id=218
	self:SetScript("OnEnter", DuffedUIUnitFrames.MouseOnPlayer)
	self:SetScript("OnLeave", DuffedUIUnitFrames.MouseOnPlayer)

	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Combat = Combat
	self.Status = Status
	self.Leader = Leader
	self.MasterLooter = MasterLooter
end