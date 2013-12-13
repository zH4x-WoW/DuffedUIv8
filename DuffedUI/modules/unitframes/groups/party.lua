local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:Party()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(self:GetHeight() - 5)
	Health:SetStatusBarTexture(C.Medias.Normal)
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetTexture(.1, .1, .1)
	Health.frequentUpdates = true
	Health.colorClass = true
	Health.colorDisconnected = true
	Health.colorReaction = true
	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end
	
	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(4)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetTexture(C.Medias.Normal)
	Power.Background.multiplier = 0.3
	Power:SetStatusBarTexture(C.Medias.Normal)
	Power.frequentUpdates = true
	Power.colorPower = true
	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("TOPLEFT", -1, 18)
	Name:SetFont(C.Medias.AltFont, 14, "THINOUTLINE")
	
	local Role = Health:CreateFontString(nil, "OVERLAY")
	Role:SetPoint("TOPRIGHT", 3, 18)
	Role:SetFont(C.Medias.AltFont, 14, "THINOUTLINE")
	
	if (C.Party.Portrait) then
		local Portrait = CreateFrame("Frame", nil, self)
		Portrait:Size(40)
		Portrait:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", -4,0)
		Portrait:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		Portrait:SetBackdropColor(0, 0, 0)
		Portrait:CreateShadow()
		
		Portrait.Model = CreateFrame("PlayerModel", nil, Portrait)
		Portrait.Model:SetInside(Portrait, 1, 1)
		
		self.Portrait = Portrait.Model
	end
	
	local Buffs = CreateFrame("Frame", nil, self)
	Buffs:Point("TOPLEFT", C.Party.Portrait and self.Portrait:GetParent() or self, "BOTTOMLEFT", 0, -6)
	Buffs:SetHeight(24)
	Buffs:SetWidth(250)
	Buffs.size = 24
	Buffs.num = 8
	Buffs.numRow = 1
	Buffs.spacing = 2
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.PostCreateIcon = DuffedUIUnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = DuffedUIUnitFrames.PostUpdateAura
	
	local Debuffs = CreateFrame("Frame", nil, self)
	Debuffs:Point("LEFT", self, "RIGHT", 6, 0)
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
	Leader:SetPoint("TOPRIGHT", C.Party.Portrait and self.Portrait or self, "TOPLEFT", -4, 0)
	
	local MasterLooter = self:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(16, 16)
	MasterLooter:SetPoint("TOPRIGHT", C.Party.Portrait and self.Portrait or self, "TOPLEFT", -4.5, -20)
	
	local ReadyCheck = Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetPoint("CENTER", Health, "CENTER")
	ReadyCheck:SetSize(16, 16)
	
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.Leader = Leader
	self.MasterLooter = MasterLooter
	self.ReadyCheck = ReadyCheck
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameLong]")
	self:Tag(Role, "[DuffedUI:Role]")
end