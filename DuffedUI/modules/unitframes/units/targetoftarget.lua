local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Layout = C["unitframes"].Layout
local Font = D.GetFont(C["unitframes"].Font)
local HealthTexture = D.GetTexture(C["unitframes"].HealthTexture)

function DuffedUIUnitFrames:TargetOfTarget()
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	
	local Health = CreateFrame("StatusBar", nil, self)
	if (Layout == 1) or (Layout == 3) then
		Health:Height(16)
		Health:SetPoint("TOPLEFT")
		Health:SetPoint("TOPRIGHT")
	elseif (Layout == 2) then
		Health:SetPoint("TOPLEFT", 2, -2)
		Health:SetPoint("BOTTOMRIGHT", -2, 2)
	end
	Health:SetStatusBarTexture(HealthTexture)
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:Point("TOPLEFT", Health, -1, 1)
	Health.Background:Point("BOTTOMRIGHT", Health, 1, -1)
	Health.Background:SetTexture(0, 0, 0)

	-- Border for HealthBar
	local HealthBorder = CreateFrame("Frame", nil, Health)
	HealthBorder:SetPoint("TOPLEFT", Health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:CreateShadow("Default")
	HealthBorder:SetFrameLevel(2)

	Health.frequentUpdates = true
	Health.PostUpdate = D.PostUpdatePetColor
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
	
	if C["unitframes"].Smooth then Health.Smooth = true end
	
	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	Name:SetFontObject(Font)
	Name:SetJustifyH("CENTER")

	if (Layout == 1) then
		-- Portraits
		local Portrait = CreateFrame("Frame", nil, self)
		Portrait:Size(16)
		Portrait:SetPoint("BOTTOMLEFT", HealthBorder, "BOTTOMRIGHT", 4, 2)
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

		-- Lines
		Line1 = CreateFrame("Frame", nil, Health)
		Line1:SetTemplate("Default")
		Line1:Size(13, 2)
		Line1:Point("RIGHT", Health, "LEFT", -3, 0)
		
		Line2 = CreateFrame("Frame", nil, Health)
		Line2:SetTemplate("Default")
		Line2:Size(2, 12)
		Line2:Point("BOTTOM", Line1, "LEFT", 0, -1)
	end
	
	self:Tag(Name, "[DuffedUI:GetNameColor][DuffedUI:NameMedium] [DuffedUI:DiffColor][level]")
	self.Health = Health
	self.Health.bg = Health.Background
	self.HealthBorder = HealthBorder
	self.Name = Name
end