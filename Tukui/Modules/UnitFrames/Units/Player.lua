local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:Player()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetTemplate()
	Panel:Size(250, 21)
	Panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")
	Panel:SetBackdropBorderColor(C.Media.BorderColor[1] * 0.7, C.Media.BorderColor[2] * 0.7, C.Media.BorderColor[3] * 0.7)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(26)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(C.Media.Normal)
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorTapping = true	
	Health.colorClass = true
	Health.colorReaction = true	
	Health:FontString("Value", C.Media.AltFont, 12)
	Health.Value:Point("RIGHT", Panel, "RIGHT", -4, 0)
	Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth
	
	if C.UnitFrames.Smooth then
		Health.Smooth = true
	end
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(8)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(C.Media.Normal)
	Power.colorPower = true
	Power.frequentUpdates = true
	Power.colorDisconnected = true
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints()
	Power.Background:SetTexture(C.Media.Normal)
	Power.Background.multiplier = 0.3
	Power:FontString("Value", C.Media.AltFont, 12)
	Power.Value:Point("LEFT", Panel, "LEFT", 4, 0)
	Power.PostUpdate = TukuiUnitFrames.PostUpdatePower
	
	local Combat = Health:CreateTexture(nil, "OVERLAY")
	Combat:Height(19)
	Combat:Width(19)
	Combat:SetPoint("LEFT",0,1)
	Combat:SetVertexColor(0.69, 0.31, 0.31)
	
	local Status = Panel:CreateFontString(nil, "OVERLAY")
	Status:SetFont(C.Media.AltFont, 12)
	Status:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Status:SetTextColor(0.69, 0.31, 0.31)
	Status:Hide()

	local Leader = Health:CreateTexture(nil, "OVERLAY")
	Leader:Height(14)
	Leader:Width(14)
	Leader:Point("TOPLEFT", 2, 8)
	
	local MasterLooter = Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Height(14)
	MasterLooter:Width(14)
	MasterLooter:Point("TOPRIGHT", -2, 8)
	
	if (C.UnitFrames.CastBar) then
		local CastBar = CreateFrame("StatusBar", nil, self)
		CastBar:SetStatusBarTexture(C.Media.Normal)
		CastBar.Background = CastBar:CreateTexture(nil, "BORDER")
		CastBar.Background:SetAllPoints(CastBar)
		CastBar.Background:SetTexture(C.Media.Normal)
		CastBar.Background:SetVertexColor(0.15, 0.15, 0.15)
		CastBar:SetFrameLevel(6)
		CastBar:SetInside(Panel)
		CastBar.Time = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Time:SetFont(C.Media.AltFont, 12)
		CastBar.Time:Point("RIGHT", Panel, "RIGHT", -4, 0)
		CastBar.Time:SetTextColor(0.84, 0.75, 0.65)
		CastBar.Time:SetJustifyH("RIGHT")
		CastBar.Text = CastBar:CreateFontString(nil, "OVERLAY")
		CastBar.Text:SetFont(C.Media.AltFont, 12)
		CastBar.Text:Point("LEFT", Panel, "LEFT", 4, 0)
		CastBar.Text:SetTextColor(0.84, 0.75, 0.65)
		
		if (C.UnitFrames.CastBarIcon) then
			CastBar.Button = CreateFrame("Frame", nil, CastBar)
			CastBar.Button:Size(26)
			CastBar.Button:SetTemplate()
			CastBar.Button:CreateShadow()
			CastBar.Button:SetPoint("LEFT", -46.5, 26.5)
			CastBar.Icon = CastBar.Button:CreateTexture(nil, "ARTWORK")
			CastBar.Icon:SetInside()
			CastBar.Icon:SetTexCoord(unpack(T.IconCoord))
		end
		
		if C.UnitFrames.CastBarLatency then
			CastBar.SafeZone = CastBar:CreateTexture(nil, "ARTWORK")
			CastBar.SafeZone:SetTexture(C.Media.Normal)
			CastBar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end
		
		CastBar.CustomTimeText = TukuiUnitFrames.CustomCastTimeText
		CastBar.CustomDelayText = TukuiUnitFrames.CustomCastDelayText
		CastBar.PostCastStart = TukuiUnitFrames.CheckCast
		CastBar.PostChannelStart = TukuiUnitFrames.CheckChannel
		
		self.Castbar = CastBar
	end
	
	if C.UnitFrames.CombatLog then
		local CombatFeedbackText = Health:CreateFontString(nil, "OVERLAY")
		CombatFeedbackText:SetFont(C.Media.AltFont, 14, "OUTLINE")
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
		FirstBar:SetStatusBarTexture(C.Media.Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:SetWidth(250)
		SecondBar:SetStatusBarTexture(C.Media.Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:SetWidth(250)
		ThirdBar:SetStatusBarTexture(C.Media.Normal)
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
	
	if C.UnitFrames.StatueBar then
		local Bar = CreateFrame("StatusBar", nil, self)
		Bar:SetWidth(250)
		Bar:SetHeight(8)
		Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		Bar:SetStatusBarTexture(C.Media.Normal)
		Bar.Backdrop = CreateFrame("Frame", nil, Bar)
		Bar.Backdrop:SetAllPoints()
		Bar.Backdrop:SetFrameLevel(Bar:GetFrameLevel() - 1)
		Bar.Backdrop:SetBackdrop(TukuiUnitFrames.Backdrop)
		Bar.Backdrop:SetBackdropColor(0, 0, 0)
		Bar.Backdrop:SetBackdropBorderColor(0,0,0)
		Bar.Background = Bar:CreateTexture(nil, "BORDER")
		Bar.Background:SetAllPoints()
		Bar:Hide()
		
		Bar:SetScript("OnShow", function(self) 
			TukuiUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)
		
		Bar:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)

		self.Statue = Bar
	end
	
	if (Class == "PRIEST") then
		local SOBar = CreateFrame("Frame", nil, self)
		SOBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		SOBar:SetWidth(250)
		SOBar:SetHeight(8)
		SOBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		SOBar:SetBackdropColor(0, 0, 0)
		SOBar:SetBackdropBorderColor(0, 0, 0)	
		
		for i = 1, 3 do
			SOBar[i] = CreateFrame("StatusBar", nil, SOBar)
			SOBar[i]:Height(8)
			SOBar[i]:SetStatusBarTexture(C.Media.Normal)
			
			if i == 1 then
				SOBar[i]:Width((250 / 3) - 1)
				SOBar[i]:SetPoint("LEFT", SOBar, "LEFT", 0, 0)
			else
				SOBar[i]:Width((250 / 3))
				SOBar[i]:SetPoint("LEFT", SOBar[i-1], "RIGHT", 1, 0)
			end
		end
		
		SOBar:SetScript("OnShow", function(self) 
			TukuiUnitFrames.UpdateClassBar(self, "OnShow", -4, 12)
		end)
		
		SOBar:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateClassBar(self, "OnHide", -4, 4)
		end)
		
		self.ShadowOrbsBar = SOBar
		
		if (C.UnitFrames.WeakBar) then
			local WSBar = CreateFrame("StatusBar", nil, Power)
			WSBar:SetAllPoints(Power)
			WSBar:SetStatusBarTexture(C.Media.Normal)
			WSBar:GetStatusBarTexture():SetHorizTile(false)
			WSBar:SetBackdrop(TukuiUnitFrames.Backdrop)
			WSBar:SetBackdropColor(unpack(C.Media.BackdropColor))
			WSBar:SetStatusBarColor(191/255, 10/255, 10/255)

			self.WeakenedSoul = WSBar
		end
	end
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD", TukuiUnitFrames.Update) -- http://www.tukui.org/tickets/tukui/index.php?page=bug_show&bug_id=218
	self:SetScript("OnEnter", TukuiUnitFrames.MouseOnPlayer)
	self:SetScript("OnLeave", TukuiUnitFrames.MouseOnPlayer)

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