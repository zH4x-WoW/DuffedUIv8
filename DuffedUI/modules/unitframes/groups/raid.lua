local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

-- NOTE : Health.Value? Aggro? Symbols? HealComm? Raid Debuffs Plugin? Weakened Soul Bar?

function DuffedUIUnitFrames:Raid()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(28)
	Health:SetStatusBarTexture(C.Medias.Normal)
	Health:SetOrientation("VERTICAL")
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
	Power:Height(3)
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
	
	local Panel = CreateFrame("Frame", nil, self)
	Panel:Point("TOPLEFT", Power, "BOTTOMLEFT", 0, -1)
	Panel:Point("TOPRIGHT", Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:SetTemplate()
	Panel:SetBackdropBorderColor(C.Medias.BorderColor[1] * 0.7, C.Medias.BorderColor[2] * 0.7, C.Medias.BorderColor[3] * 0.7)
	
	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER")
	Name:SetFont(C.Medias.AltFont, 12)
	
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
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheck = ReadyCheck
	self.LFDRole = LFDRole
	self.ResurrectIcon = ResurrectIcon
	self.Range = Range
end