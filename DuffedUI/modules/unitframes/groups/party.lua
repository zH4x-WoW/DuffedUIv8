local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:Party()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(self:GetHeight() - 10)
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
	if (C["unitframes"].Smooth) then Health.Smooth = true end
	
	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 75, 0)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", -9, -3)
	Power:SetStatusBarTexture(C["medias"].Normal)
	Power:SetFrameLevel(Health:GetFrameLevel() + 2)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetTexture(C["medias"].Normal)
	Power.Background.multiplier = 0.3

	-- Border for Power
	local PowerBorder = CreateFrame("Frame", nil, Power)
	PowerBorder:SetPoint("TOPLEFT", Power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", Power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:CreateShadow("Default")
	PowerBorder:SetFrameLevel(Health:GetFrameLevel() + 2)
	
	Power.frequentUpdates = true
	Power.colorPower = true
	if (C["unitframes"].Smooth) then Health.Smooth = true end
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("LEFT", Health, "LEFT", 4, -1)
	Name:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	
	local Role = Health:CreateFontString(nil, "OVERLAY")
	Role:SetPoint("RIGHT", Health, "RIGHT", -4, 0)
	Role:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	
	if (C["party"].Portrait) then
		local Portrait = CreateFrame("Frame", nil, self)
		Portrait:SetFrameLevel(Health:GetFrameLevel())
		Portrait:SetAlpha(0.15)
		Portrait:SetAllPoints(Health)
		
		Portrait.Model = CreateFrame("PlayerModel", nil, Portrait)
		Portrait.Model:SetInside(Portrait, 1, 1)

		self.Portrait = Portrait.Model
	end
	
	local Buffs = CreateFrame("Frame", nil, self)
	if C["party"].BuffsEnable then
		Buffs:Point("TOPLEFT", self, "BOTTOMLEFT", -2, 0)
		Buffs:SetHeight(24)
		Buffs:SetWidth(250)
		Buffs.size = 24
		Buffs.num = 8
		Buffs.numRow = 1
		Buffs.spacing = 2
		Buffs.initialAnchor = "TOPLEFT"
		Buffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
		Buffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	end
	
	local Debuffs = CreateFrame("Frame", nil, self)
	Debuffs:Point("LEFT", self, "RIGHT", 6, 5)
	Debuffs:SetHeight(self:GetHeight())
	Debuffs:SetWidth(250)
	Debuffs.size = self:GetHeight()
	Debuffs.num = 6
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "TOPLEFT"
	Debuffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	
	local Leader = self:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(16, 16)
	Leader:SetPoint("TOPLEFT", Health, 2, 10)
	
	local MasterLooter = self:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(16, 16)
	MasterLooter:SetPoint("TOPLEFT", Health, 18, 10)
	
	local ReadyCheck = Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetPoint("CENTER", Health, "CENTER")
	ReadyCheck:SetSize(16, 16)
	
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Power = Power
	self.Power.bg = Power.Background
	self.PowerBorder = PowerBorder
	self.Name = Name
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Leader = Leader
	self.MasterLooter = MasterLooter
	self.ReadyCheck = ReadyCheck
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")
	self:Tag(Role, "[DuffedUI:Role]")
end