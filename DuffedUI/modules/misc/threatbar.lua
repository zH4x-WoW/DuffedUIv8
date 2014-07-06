local D, C, L = select(2, ...):unpack()

if (not C["misc"].ThreatBarEnable) then return end

local Miscellaneous = D["Miscellaneous"]
local DataTextRight = D["Panels"].DataTextRight
local format = string.format
local floor = math.floor
local UnitName = UnitName
local ThreatBar = CreateFrame("Frame")
local GetColor = D.ColorGradient

ThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
ThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
ThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")

function ThreatBar:OnEvent(event)
	local StatusBar = self.StatusBar
	local Party = GetNumGroupMembers()
	local Raid = GetNumGroupMembers()
	local Pet = HasPetUI()

	if event == "PLAYER_ENTERING_WORLD" then
		self:Hide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:Hide()
	elseif event == "PLAYER_REGEN_DISABLED" then
		if Party > 0 or Raid > 0 or Pet == 1 then
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
	--[[if (event == "PLAYER_REGEN_ENABLED") then
		self:Hide()
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if (Party > 0 or Raid > 0 or Pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	else
		self:Hide()

		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end]]--
end

function ThreatBar:OnUpdate()
	if UnitAffectingCombat("player") then
		local _, _, ThreatPercent = UnitDetailedThreatSituation("player", "target")
		local ThreatValue = ThreatPercent or 0
		local StatusBar = self.StatusBar
		local Text = self.Text
		local Title = self.Title

		StatusBar:SetValue(ThreatValue)
		Text:SetText(floor(ThreatValue) .. "%")
		Title:SetText((UnitName("target") and UnitName("target") .. ":") or nil)

		local R, G, B = GetColor(ThreatValue, 100, 0,.8,0,.8,.8,0,.8,0,0)
		StatusBar:SetStatusBarColor(R, G, B)

		if (ThreatValue > 0) then
			StatusBar:SetAlpha(1)
		else
			StatusBar:SetAlpha(0)
		end
	end
end

function ThreatBar:Create()
	self.StatusBar = CreateFrame("StatusBar", nil, DataTextRight)
	self.StatusBar:Point("TOPLEFT", 2, -2)
	self.StatusBar:Point("BOTTOMRIGHT", -2, 2)
	self.StatusBar:SetFrameLevel(DataTextRight:GetFrameLevel() + 2)
	self.StatusBar:SetFrameStrata("HIGH")
	self.StatusBar:SetStatusBarTexture(C["medias"].Normal)
	self.StatusBar:SetMinMaxValues(0, 100)
	self.StatusBar:SetAlpha(0)

	self.Text = self.StatusBar:CreateFontString(nil, "OVERLAY")
	self.Text:SetFont(C["medias"].Font, 12)
	self.Text:Point("RIGHT", self.StatusBar, -30, 0)
	self.Text:SetShadowColor(0, 0, 0)
	self.Text:SetShadowOffset(1.25, -1.25)

	self.Title = self.StatusBar:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C["medias"].Font, 12)
	self.Title:Point("LEFT", self.StatusBar, 30, 0)
	self.Title:SetShadowColor(0, 0, 0)
	self.Title:SetShadowOffset(1.25, -1.25)

	self.Background = self.StatusBar:CreateTexture(nil, "BORDER")
	self.Background:Point("TOPLEFT", self.StatusBar, 0, 0)
	self.Background:Point("BOTTOMRIGHT", self.StatusBar, 0, 0)
	self.Background:SetTexture(0.15, 0.15, 0.15)

	self:SetScript("OnShow", function(self)
		self:SetScript("OnUpdate", self.OnUpdate)
	end)

	self:SetScript("OnHide", function(self)
		self:SetScript("OnUpdate", nil)
	end)

	self:SetScript("OnEvent", self.OnEvent)
end

function ThreatBar:Enable() self:Create() end

Miscellaneous.ThreatBar = ThreatBar