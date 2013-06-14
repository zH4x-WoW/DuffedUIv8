local T, C, L = select(2, ...):unpack()

local Panels = T["Panels"]
local DataTextRight = Panels.DataTextRight

local format = string.format
local floor = math.floor
local UnitName = UnitName

local TukuiThreatBar = CreateFrame("StatusBar", nil, DataTextRight)
TukuiThreatBar:Point("TOPLEFT", 2, -2)
TukuiThreatBar:Point("BOTTOMRIGHT", -2, 2)
TukuiThreatBar:SetFrameLevel(DataTextRight:GetFrameLevel() + 2)
TukuiThreatBar:SetFrameStrata("HIGH")
TukuiThreatBar:SetStatusBarTexture(C.Media.Normal)
TukuiThreatBar:SetMinMaxValues(0, 100)

TukuiThreatBar.Text = TukuiThreatBar:CreateFontString(nil, "OVERLAY")
TukuiThreatBar.Text:SetFont(C.Media.Font, 12)
TukuiThreatBar.Text:Point("RIGHT", TukuiThreatBar, -30, 0)
TukuiThreatBar.Text:SetShadowColor(0, 0, 0)
TukuiThreatBar.Text:SetShadowOffset(1.25, -1.25)

TukuiThreatBar.Title = TukuiThreatBar:CreateFontString(nil, "OVERLAY")
TukuiThreatBar.Title:SetFont(C.Media.Font, 12)
TukuiThreatBar.Title:Point("LEFT", TukuiThreatBar, 30, 0)
TukuiThreatBar.Title:SetShadowColor(0, 0, 0)
TukuiThreatBar.Title:SetShadowOffset(1.25, -1.25)

local ThreatBG = TukuiThreatBar:CreateTexture(nil, "BORDER")
ThreatBG:Point("TOPLEFT", TukuiThreatBar, 0, 0)
ThreatBG:Point("BOTTOMRIGHT", TukuiThreatBar, 0, 0)
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

		local R, G, B = T.ColorGradient(ThreatValue, 100, 0,.8,0,.8,.8,0,.8,0,0)
		self:SetStatusBarColor(R, G, B)

		if (ThreatValue > 0) then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
end

TukuiThreatBar:SetScript("OnShow", function(self)
	self:SetScript("OnUpdate", OnUpdate)
end)

TukuiThreatBar:SetScript("OnHide", function(self)
	self:SetScript("OnUpdate", nil)
end)

TukuiThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
TukuiThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
TukuiThreatBar:SetScript("OnEvent", OnEvent)
TukuiThreatBar.unit = "player"
TukuiThreatBar.tar = TukuiThreatBar.unit.."target"
TukuiThreatBar:SetAlpha(0)