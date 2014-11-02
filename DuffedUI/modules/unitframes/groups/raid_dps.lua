local D, C, L = unpack(select(2, ...))
if (C["raid"].enable ~= true or C["raid"].layout == "heal") then return end

--[[oUF]]--
local ADDON_NAME, ns = ...
local oUF = oUFDuffedUI or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

--[[locals]]--
local font = D.Font(C["font"].unitframes)
local texture = C["media"].normTex
local FrameScale = C["raid"].FrameScaleRaid
local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D.mult, left = -D.mult, bottom = -D.mult, right = -D.mult},
}

local function Shared(self, unit)
	self.colors = D.oUF_colors
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnEnter)

	--[[health]]--
	local health = CreateFrame("Statusbar", nil, self)
	health:Point("TOPLEFT", self, "BOTTOMLEFT", 0, 15)
	health:Point("TOPRIGHT", self, "BOTTOMRIGHT", 0, 15)
	health:Height(15 * FrameScale)
	health:Width(140 * FrameScale)
	health:SetStatusBarTexture(texture)
	health:CreateBackdrop()

	health.bg = health:CreateTexture(nil, "BORDER")
	health.bg:SetAllPoints(health)
	health.bg:SetTexture(texture)
	health.bg.multiplier = .3

	health.value = health:CreateFontString(nil, "OVERLAY")
	health.value:Point("LEFT", health, 8, 0)
	health.value:SetFontObject(font)

	self.Health = health
	self.Health.bg = health.bg
	self.Health.value = health.value

	health.PostUpdate = D.PostUpdateHealthRaid
	health.frequentUpdates = true

	if C["unitframes"].unicolor then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
		health.bg:SetVertexColor(unpack(C["unitframes"].deficitcolor))
		health.bg:SetTexture(.6, .6, .6)
		if C["unitframes"].ColorGradient then
			health.colorSmooth = true
			health.bg:SetTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true
		health.bg:SetTexture(.1, .1, .1)
	end

	--[[Power]]--
	if not C["raid"].HidePower then
		local power = CreateFrame("Statusbar", nil, self)
		power:Height(2)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 2)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 2)
		power:SetStatusBarTexture(texture)
		power:SetFrameLevel(health:GetFrameLevel() + 1)
		power.colorClass = true
		self.Power = power

		power.bg = self.Power:CreateTexture(nil, "BORDER")
		power.bg:SetAllPoints(power)
		power.bg:SetTexture(texture)
		power.bg:SetAlpha(1)
		power.bg.multiplier = .3
		self.Power.bg = power.bg

		power.frequentUpdates = true
		power.colorDisconnected = false
	end

	--[[Panel]]--
	local panel = CreateFrame("Frame", nil, self)
	panel:SetTemplate("Default")
	panel:Size(1, 1)
	panel:Point("TOPLEFT", health, "TOPLEFT", -2, 2)
	panel:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", 2, -2)
	self.panel = panel

	--[[Elements]]--
	local name = health:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(font)
	if C["raid"].NameOutside then name:Point("LEFT", health, "RIGHT", 5, 0) else name:Point("RIGHT", health, -5, 0) end
	if C["unitframes"].unicolor then self:Tag(name, "[DuffedUI:getnamecolor][DuffedUI:namemedium]") else self:Tag(name, "[DuffedUI:namemedium]") end
	self.Name = name

	if C["raid"].showsymbols == true then
		RaidIcon = health:CreateTexture(nil, "OVERLAY")
		RaidIcon:Height(14)
		RaidIcon:Width(14)
		RaidIcon:SetPoint("CENTER", self, "CENTER")
		RaidIcon:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\raidicons.blp")
		self.RaidIcon = RaidIcon
	end

	if C["raid"].aggro then
		table.insert(self.__elements, D.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", D.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", D.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", D.UpdateThreat)
	end

	local LFDRole = health:CreateTexture(nil, "OVERLAY")
	LFDRole:Height(6 * D.raidscale)
	LFDRole:Width(6 * D.raidscale)
	LFDRole:Point("TOPLEFT", 2, -2)
	LFDRole:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\lfdicons.blp")
	self.LFDRole = LFDRole

	local Resurrect = CreateFrame("Frame", nil, self)
	Resurrect:SetFrameLevel(20)
	local ResurrectIcon = Resurrect:CreateTexture(nil, "OVERLAY")
	ResurrectIcon:Point("CENTER", health, 0, -1)
	ResurrectIcon:Size(10, 10)
	ResurrectIcon:SetDrawLayer("OVERLAY", 7)
	self.ResurrectIcon = ResurrectIcon

	local ReadyCheck = health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")
	self.ReadyCheck = ReadyCheck

	local leader = self.Health:CreateTexture(nil, "OVERLAY")
	leader:Height(12)
	leader:Width(12)
	leader:SetPoint("TOPLEFT", 0, 8)
	self.Leader = leader

	local MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Height(12)
	MasterLooter:Width(12)
	self.MasterLooter = MasterLooter
	self:RegisterEvent("PARTY_LEADER_CHANGED", D.MLAnchorUpdate)
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", D.MLAnchorUpdate)

	if C["raid"].showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = C["raid"].raidalphaoor}
		self.Range = range
	end
end

oUF:RegisterStyle("DPS", Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("DPS")

	local raid = self:SpawnHeader("oUF_DPS", nil, "custom [@raid40,exists] hide;show", 
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", D.Scale(140 * FrameScale),
		"initial-height", D.Scale(14 * FrameScale),
		"initial-anchor", "BOTTOM",
		"showPlayer", C["raid"].showplayerinparty,
		"showParty", true,
		"showRaid", true,
		"showSolo", true,
		"groupFilter", "1,2,3,4,5,6,7,8", 
		"groupingOrder", "1,2,3,4,5,6,7,8", 
		"groupBy", "GROUP", 
		"yOffset", D.Scale(8),
		"point", "BOTTOM"
	)
	if DuffedUIChatBackgroundLeft then
		raid:Point("BOTTOMLEFT", DuffedUIChatBackgroundLeft, "TOPLEFT", 2, 16)
	else
		raid:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 2, 33)
	end
end)