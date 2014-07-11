local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))
local Font = D.GetFont(C["unitframes"].Font)

-- NOTE : Health.Value? Aggro? Symbols? HealComm? Raid Debuffs Plugin? Weakened Soul Bar?

function DuffedUIUnitFrames:Raid()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(30 * C["raid"].GridScale)
	Health:SetStatusBarTexture(C["medias"].Normal)
	Health:SetOrientation("VERTICAL")
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	
	Health.Value = CreateFontString(nil, "OVERLAY")
	Health:SetFontObject(Font)
	Health.Value:Point("CENTER", Health, 0, -6)
	
	Health.frequentUpdates = true
	if C["unitframes"].UniColor then
		Health.colorClass = false
		Health.colorDisconnected = false
		Health.colorReaction = false
		Health:SetStatusBarColor(unpack(C["unitframes"].HealthBarColor))
		Health.Background:SetVertexColor(unpack(C["unitframes"].HealthBGColor))
	else
		Health.colorClass = true
		Health.colorDisconnected = true
		Health.colorReaction = true
	end
	if (C["unitframes"].Smooth) then Health.Smooth = true end
	Health.PostUpdate = DuffedUIUnitFrames.PostUpdateHealthRaid

	-- Border for HealthBar
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-6))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)
	
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	
	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetTexture(C["medias"].Normal)
	Power.Background.multiplier = 0.3
	Power:SetStatusBarTexture(C["medias"].Normal)
	
	Power.frequentUpdates = true
	if C["unitframes"].UnitColor then Power.colorClass = true else Power.colorPower = true end
	if (C["unitframes"].Smooth) then Health.Smooth = true end
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Health, "TOP", 0, -7)
	Name:SetFontObject(Font)
	
	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")
	
	if C["raid"].Aggro then
		table.insert(self.__elements, D.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', D.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', D.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', D.UpdateThreat)
	end
	
	if C["raid"].ShowSymbols then
		local RaidIcon = Health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:Height(D.Scale(18))
		RaidIcon:Width(D.Scale(18))
		RaidIcon:SetPoint('CENTER', self, 'TOP')
		RaidIcon:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
		self.RaidIcon = RaidIcon
	end

	local LFDRole = Health:CreateTexture(nil, "OVERLAY")
    LFDRole:Height(D.Scale(6))
    LFDRole:Width(D.Scale(6))
	LFDRole:Point("TOPRIGHT", -2, -2)
	LFDRole:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\lfdicons.blp")
	LFDRole.Override = DuffedUIUnitFrames.SetGridGroupRole
	
	local ResurrectIcon = Health:CreateTexture(nil, "OVERLAY")
	ResurrectIcon:Size(16)
	ResurrectIcon:SetPoint("CENTER")
	
	local Range = {
		insideAlpha = 1, 
		outsideAlpha = 0.3,
	}
	
	if (C["raid"].HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
		FirstBar:Width(D.Scale(C["raid"].FrameWidth))
		FirstBar:Height(D.Scale(C["raid"].FrameHeight))
		FirstBar:SetStatusBarTexture(C["medias"].Normal)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, .7)
		FirstBar:SetMinMaxValues(0, 1)
		FirstBar:SetOrientation("VERTICAL")

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
		SecondBar:Width(D.Scale(C["raid"].FrameWidth))
		SecondBar:Height(D.Scale(C["raid"].FrameHeight))
		SecondBar:SetStatusBarTexture(C["medias"].Normal)
		SecondBar:SetStatusBarColor(0, 0.3, 0, .7)
		SecondBar:SetOrientation("VERTICAL")

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
		ThirdBar:Width(D.Scale(C["raid"].FrameWidth))
		ThirdBar:Height(D.Scale(C["raid"].FrameHeight))
		ThirdBar:SetStatusBarTexture(C["medias"].Normal)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, .7)
		ThirdBar:SetOrientation("VERTICAL")

		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)

		self.HealPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absBar = ThirdBar,
			maxOverflow = 1,
		}
	end
	
	-- AuraWatch (corner icon)
	if C["raid"].AuraWatch then
		DuffedUIUnitFrames:CreateAuraWatch(self)

		-- Raid Debuffs (big middle icon)
		local RaidDebuffs = CreateFrame("Frame", nil, self)
		RaidDebuffs:Height(24)
		RaidDebuffs:Width(24)
		RaidDebuffs:Point("CENTER", Health, 1, 0)
		RaidDebuffs:SetFrameStrata(Health:GetFrameStrata())
		RaidDebuffs:SetFrameLevel(Health:GetFrameLevel() + 2)

		RaidDebuffs:SetTemplate("Default")

		RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "OVERLAY")
		RaidDebuffs.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		RaidDebuffs.icon:Point("TOPLEFT", 2, -2)
		RaidDebuffs.icon:Point("BOTTOMRIGHT", -2, 2)

		RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
		RaidDebuffs.count:SetFont(C["medias"].Font, 9, "THINOUTLINE")
		RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 0, 2)
		RaidDebuffs.count:SetTextColor(1, .9, 0)

		RaidDebuffs:FontString("time", C["medias"].Font, 9, "THINOUTLINE")
		RaidDebuffs.time:SetPoint("CENTER")
		RaidDebuffs.time:SetTextColor(1, .9, 0)

		self.RaidDebuffs = RaidDebuffs
	end

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameShort]")
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheck = ReadyCheck
	self.LFDRole = LFDRole
	self.ResurrectIcon = ResurrectIcon
	self.Range = Range
end