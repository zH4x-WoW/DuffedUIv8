local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

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

	-- Border for HealthBar
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-6))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)
	
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
	Name:SetPoint("CENTER")
	Name:SetFont(C["medias"].Font, 12)
	
	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")

	local LFDRole = Health:CreateTexture(nil, "OVERLAY")
	LFDRole:SetInside(Panel)
	LFDRole:SetTexture(0, 0, 0, 0)
	LFDRole.Override = DuffedUIUnitFrames.SetGridGroupRole
	
	local ResurrectIcon = Health:CreateTexture(nil, "OVERLAY")
	ResurrectIcon:Size(16)
	ResurrectIcon:SetPoint("CENTER")
	
	local Range = {
		insideAlpha = 1, 
		outsideAlpha = 0.3,
	}

	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameShort]")
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheck = ReadyCheck
	self.LFDRole = LFDRole
	self.ResurrectIcon = ResurrectIcon
	self.Range = Range
end