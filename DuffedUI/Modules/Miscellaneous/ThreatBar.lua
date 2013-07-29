local D, C, L = select(2, ...):unpack()

local Panels = D["Panels"]
local DataTextRight = Panels.DataTextRight

local format = string.format
local floor = math.floor
local UnitName = UnitName

local DuffedUIThreatBar = CreateFrame("StatusBar", nil, DataTextRight)
DuffedUIThreatBar:Point("TOPLEFT", 2, -2)
DuffedUIThreatBar:Point("BOTTOMRIGHT", -2, 2)
DuffedUIThreatBar:SetFrameLevel(DataTextRight:GetFrameLevel() + 2)
DuffedUIThreatBar:SetFrameStrata("HIGH")
DuffedUIThreatBar:SetStatusBarTexture(C["Media"].Normal)
DuffedUIThreatBar:SetMinMaxValues(0, 100)

DuffedUIThreatBar.Text = DuffedUIThreatBar:CreateFontString(nil, "OVERLAY")
DuffedUIThreatBar.Text:SetFont(C["Media"].Font, 12)
DuffedUIThreatBar.Text:Point("RIGHT", DuffedUIThreatBar, -30, 0)
DuffedUIThreatBar.Text:SetShadowColor(0, 0, 0)
DuffedUIThreatBar.Text:SetShadowOffset(1.25, -1.25)

DuffedUIThreatBar.Title = DuffedUIThreatBar:CreateFontString(nil, "OVERLAY")
DuffedUIThreatBar.Title:SetFont(C["Media"].Font, 12)
DuffedUIThreatBar.Title:Point("LEFT", DuffedUIThreatBar, 30, 0)
DuffedUIThreatBar.Title:SetShadowColor(0, 0, 0)
DuffedUIThreatBar.Title:SetShadowOffset(1.25, -1.25)

local ThreatBG = DuffedUIThreatBar:CreateTexture(nil, "BORDER")
ThreatBG:Point("TOPLEFT", DuffedUIThreatBar, 0, 0)
ThreatBG:Point("BOTTOMRIGHT", DuffedUIThreatBar, 0, 0)
ThreatBG:SetTexture(0.15, 0.15, 0.15)

local OnEvent = function(self, event)
	local Party = GetNumGroupMembers()
	local Raid = GetNumGroupMembers()
	local Pet = HasPetUI()
	
	if (event == "PLAYER_ENTERING_WORLD") then
		self:Hide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif (event == "PLAYER_REGEN_ENABLED") then
		self:Hide()
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if (Party > 0 or Raid > 0 or Pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	else
		if (InCombatLockdown()) and (Party > 0 or Raid > 0 or Pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	end
end

local OnUpdate = function(self)
	if UnitAffectingCombat(self.unit) then
		local _, _, ThreatPercent = UnitDetailedThreatSituation(self.unit, self.tar)
		local ThreatValue = ThreatPercent or 0
		
		self:SetValue(ThreatValue)
		self.Text:SetText(floor(ThreatValue) .. "%")
		self.Title:SetText((UnitName("target") and UnitName("target") .. ":") or nil)

		local R, G, B = D.ColorGradient(ThreatValue, 100, 0,.8,0,.8,.8,0,.8,0,0)
		self:SetStatusBarColor(R, G, B)

		if (ThreatValue > 0) then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
end

DuffedUIThreatBar:SetScript("OnShow", function(self)
	self:SetScript("OnUpdate", OnUpdate)
end)

DuffedUIThreatBar:SetScript("OnHide", function(self)
	self:SetScript("OnUpdate", nil)
end)

DuffedUIThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
DuffedUIThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
DuffedUIThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
DuffedUIThreatBar:SetScript("OnEvent", OnEvent)
DuffedUIThreatBar.unit = "player"
DuffedUIThreatBar.tar = DuffedUIThreatBar.unit.."target"
DuffedUIThreatBar:SetAlpha(0)