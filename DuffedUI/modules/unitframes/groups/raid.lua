local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["raid"]["layout"]
local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructUFRaid"] = function(self)
	self.colors = D["oUF_colors"]
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	--[[Health]]--
	local health = CreateFrame("StatusBar", nil, self)
	if layout == "dps" then
		health:Height(15)
		health:Width(140)
		health:Point("TOPLEFT", self, "BOTTOMLEFT", 0, 15)
		health:Point("TOPRIGHT", self, "BOTTOMRIGHT", 0, 15)
	else
		health:Height(C["raid"]["frameheight"] - 15)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
	end
	health:SetStatusBarTexture(texture)
	health:CreateBackdrop()
	if layout == "heal" then health:SetOrientation("VERTICAL") end

	health.bg = health:CreateTexture(nil, "BORDER")
	health.bg:SetAllPoints(health)
	health.bg:SetTexture(texture)
	health.bg.multiplier = (.3)

	health.value = health:CreateFontString(nil, "OVERLAY")
	if layout == "heal" then health.value:Point("BOTTOM", health, 1, 2) else health.value:Point("LEFT", health, 8, 0) end
	health.value:SetFontObject(font)

	health.PostUpdate = D["PostUpdateHealthRaid"]
	health.frequentUpdates = true
	health.Smooth = true
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

	self.Health = health
	self.Health.bg = health.bg
	self.Health.value = health.value

	--[[Power]]--
	local power = CreateFrame("StatusBar", nil, self)
	power:SetStatusBarTexture(texture)
	if layout == "heal" then
		power:SetHeight(3)
		power:Point("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -2)
		power:Point("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -2)
	else
		power:Height(2)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 2)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 2)
		power:SetFrameLevel(health:GetFrameLevel() + 1)
	end

	power.bg = power:CreateTexture(nil, "BORDER")
	power.bg:SetAllPoints(power)
	power.bg:SetTexture(texture)
	power.bg.multiplier = .3

	power.Smooth = true
	power.frequentUpdates = true
	power.colorDisconnected = true
	if C["unitframes"]["unicolor"] then
		power.colorClass = true
		power.colorClassPet = true
	else
		power.colorClass = false
		power.colorClassPet = false
	end

	self.Power = power
	self.Power.bg = power.bg

	--[[Panel]]--
	local panel = CreateFrame("Frame", nil, self)
	panel:SetTemplate("Default")
	panel:Size(1, 1)
	panel:Point("TOPLEFT", health, "TOPLEFT", -2, 2)
	panel:Point("BOTTOMRIGHT", power, "BOTTOMRIGHT", 2, -2)
	self.panel = panel

	--[[Elements]]--
	local name = health:CreateFontString(nil, "OVERLAY")
	name:SetFontObject(font)
	if layout == "heal" then
		name:Point("CENTER", health, "TOP", 0, -7)
		self:Tag(name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
	else
		name:Point("LEFT", health, "RIGHT", 5, 0)
		if C["unitframes"]["unicolor"] then self:Tag(name, "[DuffedUI:getnamecolor][DuffedUI:namemedium]") else self:Tag(name, "[DuffedUI:namemedium]") end
	end
	self.Name = name

	if C["raid"]["aggro"] then
		table.insert(self.__elements, D.UpdateThreat)
		self:RegisterEvent("PLAYER_TARGET_CHANGED", D.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", D.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", D.UpdateThreat)
	end

	if C["raid"]["showsymbols"] then
		local RaidIcon = health:CreateTexture(nil, "OVERLAY")
		RaidIcon:Height(18)
		RaidIcon:Width(18)
		RaidIcon:SetPoint("CENTER", self, "TOP")
		RaidIcon:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\raidicons.blp") -- thx hankthetank for texture
		self.RaidIcon = RaidIcon
	end

	local LFDRole = health:CreateTexture(nil, "OVERLAY")
	LFDRole:Height(12)
	LFDRole:Width(12)
	LFDRole:Point("TOPRIGHT", -1, -1)
	LFDRole:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\lfdicons2.blp")
	self.LFDRole = LFDRole

	local Resurrect = CreateFrame("Frame", nil, self)
	Resurrect:SetFrameLevel(20)
	local ResurrectIcon = Resurrect:CreateTexture(nil, "OVERLAY")
	ResurrectIcon:Point("CENTER", health, 0, 0)
	ResurrectIcon:Size(20, 15)
	ResurrectIcon:SetDrawLayer("OVERLAY", 7)
	self.ResurrectIcon = ResurrectIcon

	local ReadyCheck = power:CreateTexture(nil, "OVERLAY")
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")
	self.ReadyCheck = ReadyCheck

	local leader = health:CreateTexture(nil, "OVERLAY")
	leader:Height(12)
	leader:Width(12)
	leader:Point("TOPLEFT", 0, 8)
	self.Leader = leader

	local MasterLooter = health:CreateTexture(nil, "OVERLAY")
	MasterLooter:Height(12)
	MasterLooter:Width(12)
	self.MasterLooter = MasterLooter
	self:RegisterEvent("PARTY_LEADER_CHANGED", D.MLAnchorUpdate)
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", D.MLAnchorUpdate)

	if C["raid"]["showrange"] then
		local range = {insideAlpha = 1, outsideAlpha = C["raid"]["raidalphaoor"]}
		self.Range = range
	end

	if layout == "heal" then
		if not C["raid"]["raidunitdebuffwatch"] then
			self.DebuffHighlightAlpha = 1
			self.DebuffHighlightBackdrop = true
			self.DebuffHighlightFilter = true
		end

		--[[Healcom]]--
		if C["unitframes"]["healcomm"] then
			local mhpb = CreateFrame("StatusBar", nil, self.Health)
			mhpb:SetOrientation("VERTICAL")
			mhpb:SetPoint("BOTTOM", self.Health:GetStatusBarTexture(), "TOP", 0, 0)
			mhpb:Width(68)
			mhpb:Height(31)
			mhpb:SetStatusBarTexture(texture)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

			local ohpb = CreateFrame("StatusBar", nil, self.Health)
			ohpb:SetOrientation("VERTICAL")
			ohpb:SetPoint("BOTTOM", mhpb:GetStatusBarTexture(), "TOP", 0, 0)
			ohpb:Width(68)
			ohpb:Height(31)
			ohpb:SetStatusBarTexture(texture)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			local absb = CreateFrame("StatusBar", nil, self.Health)
			absb:SetOrientation("VERTICAL")
			absb:SetPoint("BOTTOM", ohpb:GetStatusBarTexture(), "TOP", 0, 0)
			absb:Width(68)
			absb:Height(31)
			absb:SetStatusBarTexture(texture)
			absb:SetStatusBarColor(1, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				absorbBar = absb,
				maxOverflow = 1,
			}
		end

		--[[WeakenedSoul-Bar]]--
		if D["Class"] == "PRIEST" and C["unitframes"]["weakenedsoulbar"] then
			local ws = CreateFrame("StatusBar", self:GetName().."_WeakenedSoul", power)
			ws:SetAllPoints(power)
			ws:SetStatusBarTexture(texture)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C["media"].backdropcolor))
			ws:SetStatusBarColor(.75, .04, .04)   
			self.WeakenedSoul = ws
		end

		--[[RaidDebuffs]]--
		if C["raid"]["raidunitdebuffwatch"] then
			D.createAuraWatch(self,unit)

			local RaidDebuffs = CreateFrame("Frame", nil, self)
			RaidDebuffs:Height(24)
			RaidDebuffs:Width(24)
			RaidDebuffs:Point("CENTER", health, 1,0)
			RaidDebuffs:SetFrameStrata(health:GetFrameStrata())
			RaidDebuffs:SetFrameLevel(health:GetFrameLevel() + 2)
			RaidDebuffs:SetTemplate("Default")

			RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "OVERLAY")
			RaidDebuffs.icon:SetTexCoord(unpack(D["IconCoord"]))
			RaidDebuffs.icon:Point("TOPLEFT", 2, -2)
			RaidDebuffs.icon:Point("BOTTOMRIGHT", -2, 2)

			RaidDebuffs.time = RaidDebuffs:CreateFontString(nil, "OVERLAY")
			RaidDebuffs.time:SetFontObject(font)
			RaidDebuffs.time:Point("CENTER", 1, 0)
			RaidDebuffs.time:SetTextColor(1, .9, 0)

			RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
			RaidDebuffs.count:SetFontObject(font)
			RaidDebuffs.count:Point("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 0, 2)
			RaidDebuffs.count:SetTextColor(1, .9, 0)
			self.RaidDebuffs = RaidDebuffs
		end
	end
end