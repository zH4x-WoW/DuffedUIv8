local D, C, L = unpack(select(2, ...))
if not C["unitframes"].enable or C["unitframes"].layout ~= 1 then return end

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

--	local variables
local normTex = C["media"].normTex
local glowTex = C["media"].glowTex
local bubbleTex = C["media"].bubbleTex
local font = D.Font(C["font"].unitframes)

local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D.mult, left = -D.mult, bottom = -D.mult, right = -D.mult},
}

--	Layout
local function Shared(self, unit)
	self.colors = D.UnitColor

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self.menu = D.SpawnMenu

	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()

	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\raidicons.blp")
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 11)
	self.RaidIcon = RaidIcon

	-- Fader
	if C["unitframes"].fader == true then
		self.FadeCasting = true
		self.FadeCombat = true
		self.FadeTarget = true
		self.FadeHealth = true
		self.FadePower = true
		self.FadeHover = true

		self.FadeSmooth = 0.5
		self.FadeMinAlpha = C["unitframes"].minalpha
		self.FadeMaxAlpha = 1
	end

	--	Player and Target
	if (unit == "player" or unit == "target") then
		local panel = CreateFrame("Frame", nil, self)
		panel:SetTemplate("Default")
		panel:Size(250, 21)
		panel:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(unpack(C["media"].bordercolor))
		panel:SetAlpha(0)
		self.panel = panel

		local health = CreateFrame("StatusBar", nil, self)
		health:Height(20)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		local healthBG = health:CreateTexture(nil, "BORDER")
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		if C["unitframes"].percent then
			local percHP
			percHP = D.SetFontString(health, C["media"].font, 20, "THINOUTLINE")
			percHP:SetTextColor(unpack(C["media"].datatextcolor1))
			if unit == "player" then
				percHP:SetPoint("LEFT", health, "RIGHT", 25, -10)
			elseif unit == "target" then
				percHP:SetPoint("RIGHT", health, "LEFT", -25, -10)
			end
			self:Tag(percHP, "[DuffedUI:perchp]")
			self.percHP = percHP
		end

		health.value = health:CreateFontString(nil, "OVERLAY")
		health.value:SetFontObject(font)
		health.value:Point("RIGHT", health, "RIGHT", -4, -1)
		health.PostUpdate = D.PostUpdateHealth

		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end

		if C["unitframes"].unicolor == true then
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end
		else
			health.colorDisconnected = true
			health.colorTapping = true
			health.colorClass = true
			health.colorReaction = true
		end

		local power = CreateFrame('StatusBar', nil, self)
		power:Height(18)
		power:Width(228)
		power:Point("TOP", health, "BOTTOM", 2, 9)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 5, -2)
		power:SetStatusBarTexture(normTex)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)
		power:SetFrameStrata("BACKGROUND")

		local PowerBorder = CreateFrame("Frame", nil, power)
		PowerBorder:SetPoint("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
		PowerBorder:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		PowerBorder:SetTemplate("Default")
		PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		self.PowerBorder = PowerBorder

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3

		power.value = health:CreateFontString(nil, "OVERLAY")
		power.value:SetFontObject(font)
		if (unit == "player") then power.value:Point("LEFT", health, "LEFT", 4, -1) end

		self.Power = power
		self.Power.bg = powerBG

		power.PreUpdate = D.PreUpdatePower
		power.PostUpdate = D.PostUpdatePower

		power.frequentUpdates = true
		power.colorDisconnected = true

		if C["unitframes"].showsmooth == true then power.Smooth = true end
		
		if C["unitframes"].unicolor == true then
			power.colorTapping = true
			power.colorClass = true
		else
			power.colorPower = true
		end

		if C["unitframes"].charportrait == true then
			local portrait = CreateFrame("PlayerModel", nil, health)
			portrait:SetFrameLevel(health:GetFrameLevel())
			portrait:SetAllPoints(health)
			portrait:SetAlpha(.15)
			portrait.PostUpdate = D.PortraitUpdate 
			self.Portrait = portrait
		end

		if C["unitframes"].playermodel == "Icon" then
			local classicon = CreateFrame("Frame", nil, health)
			classicon:Size(29)
			if unit == "player" then classicon:Point("BOTTOMRIGHT", power, "BOTTOMLEFT", -5, 0) else classicon:Point("BOTTOMLEFT", power, "BOTTOMRIGHT", 5, 0) end
			classicon:CreateBackdrop()
			classicon.tex = classicon:CreateTexture("ClassIcon", "ARTWORK")
			classicon.tex:SetAllPoints(classicon)
			self.ClassIcon = classicon.tex
		end

		if D.Class == "PRIEST" and C["unitframes"].weakenedsoulbar then
			local ws = CreateFrame("StatusBar", self:GetName().."_WeakenedSoul", power)
			ws:SetAllPoints(power)
			ws:SetStatusBarTexture(C["media"].normTex)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C["media"].backdropcolor))
			ws:SetStatusBarColor(205/255, 20/255, 20/255)
			self.WeakenedSoul = ws
		end

		local AltPowerBar = CreateFrame("StatusBar", self:GetName().."_AltPowerBar", self.Health)
		AltPowerBar:SetFrameLevel(0)
		AltPowerBar:SetFrameStrata("LOW")
		AltPowerBar:SetHeight(5)
		AltPowerBar:SetStatusBarTexture(C["media"].normTex)
		AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
		AltPowerBar:SetStatusBarColor(163/255,  24/255,  24/255)
		AltPowerBar:EnableMouse(true)

		AltPowerBar:Point("LEFT", DuffedUIInfoLeft, 2, -2)
		AltPowerBar:Point("RIGHT", DuffedUIInfoLeft, -2, 2)
		AltPowerBar:Point("TOP", DuffedUIInfoLeft, 2, -2)
		AltPowerBar:Point("BOTTOM", DuffedUIInfoLeft, -2, 2)
		AltPowerBar:SetBackdrop({
			bgFile = C["media"].blank, 
			edgeFile = C["media"].blank, 
			tile = false, tileSize = 0, edgeSize = 1, 
			insets = { left = 0, right = 0, top = 0, bottom = D.Scale(-1)}
		})
		AltPowerBar:SetBackdropColor(0, 0, 0)
		self.AltPowerBar = AltPowerBar

		if (unit == "player") then
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:Height(19)
			Combat:Width(19)
			Combat:SetPoint("TOP", health, "TOPLEFT", 0, 12)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			FlashInfo = CreateFrame("Frame", "DuffedUIFlashInfo", self)
			FlashInfo:SetScript("OnUpdate", D.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetAllPoints(health)
			FlashInfo.ManaLevel = FlashInfo:CreateFontString(nil, "OVERLAY")
			FlashInfo.ManaLevel:SetFontObject(font)
			FlashInfo.ManaLevel:SetPoint("CENTER", health, "CENTER", 0, 1)
			self.FlashInfo = FlashInfo

			local PVP = health:CreateTexture(nil, "OVERLAY")
			PVP:SetHeight(D.Scale(32))
			PVP:SetWidth(D.Scale(32))
			PVP:SetPoint("TOPLEFT", health, "TOPRIGHT", -7, 7)
			self.PvP = PVP

			local Leader = InvFrame:CreateTexture(nil, "OVERLAY")
			Leader:Height(14)
			Leader:Width(14)
			Leader:Point("TOPLEFT", 2, 8)
			self.Leader = Leader

			local MasterLooter = InvFrame:CreateTexture(nil, "OVERLAY")
			MasterLooter:Height(14)
			MasterLooter:Width(14)
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", D.MLAnchorUpdate)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", D.MLAnchorUpdate)

			if (D.Class == "WARRIOR" or D.Class == "MONK" or D.Class == "PRIEST") and C["unitframes"].showstatuebar then
				local bar = CreateFrame("StatusBar", "DuffedUIStatueBar", self)
				bar:SetWidth(5)
				bar:SetHeight(29)
				bar:Point("LEFT", power, "RIGHT", 7, 5)
				bar:SetStatusBarTexture(C["media"].normTex)
				bar:SetOrientation("VERTICAL")
				bar.bg = bar:CreateTexture(nil, 'ARTWORK')
				bar.background = CreateFrame("Frame", "DuffedUIStatue", bar)
				bar.background:SetAllPoints()
				bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
				bar.background:SetBackdrop(backdrop)
				bar.background:SetBackdropColor(0, 0, 0)
				bar.background:SetBackdropBorderColor(0,0,0)
				bar:CreateBackdrop()
				self.Statue = bar
			end

			if C["unitframes"].classbar then
				if D.Class == "DEATHKNIGHT" then
					D.ConstructRessources("Runes", 216, 5)
					if C["unitframes"].attached then Runes:Point("TOP", power, "BOTTOM", 0, 0) else Runes:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
				end

				if D.Class == "DRUID" then
					local DruidManaUpdate = CreateFrame("Frame")
					DruidManaUpdate:SetScript("OnUpdate", function() D.UpdateDruidManaText(self) end)
					local DruidManaText = health:CreateFontString(nil, "OVERLAY")
					DruidManaText:SetFontObject(font)
					DruidManaText:Point("LEFT", power.value, "RIGHT", 5, 0)
					DruidManaText:SetTextColor( 1, .49, .04 )
					self.DruidManaText = DruidManaText

					D.ConstructRessources("Druid", 216, 5)
					if C["unitframes"].attached then
						DruidMana:Point("TOP", power, "BOTTOM", 0, -8)
						DruidEclipseBar:Point("TOP", power, "BOTTOM", 0, 0)
						DruidWildMushroom:Point("TOP", power, "BOTTOM", 0, -8)
						DruidComboPoints:SetPoint("TOP", power, "BOTTOM", 0, 0)
					else
						DruidMana:Point("TOP", CBAnchor, "BOTTOM", 0, -5)
						DruidEclipseBar:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
						DruidWildMushroom:Point("TOP", CBAnchor, "BOTTOM", 0, -5)
						DruidComboPoints:SetPoint("BOTTOM", CBAnchor, "TOP", 0, -5)
					end
					self.DruidMana = DruidMana
					self.DruidMana.bg = DruidMana.Background
					self.EclipseBar = DruidEclipseBar
					self.WildMushroom = DruidWildMushroom
					self.ComboPointsBar = DruidComboPoints
				end

				if D.Class == "MAGE" then
					D.ConstructRessources("mb", "rp", 216, 5)
					if C["unitframes"].attached then
						mb:Point("TOP", power, "BOTTOM", 0, 0)
						rp:Point("TOP", power, "BOTTOM", 0, -8)
					else
						mb:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
						rp:Point("TOP", CBAnchor, "BOTTOM", 0, -5)
					end
					self.ArcaneChargeBar = mb
					self.RunePower = rp
				end

				if D.Class == "MONK" then
					D.ConstructRessources("Bar", 216, 5)
					if C["unitframes"].attached then Bar:Point("TOP", power, "BOTTOM", 0, 0) else Bar:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.HarmonyBar = Bar
				end

				if D.Class == "PALADIN" then
					D.ConstructRessources("bars", 216, 5)
					if C["unitframes"].attached then bars:Point("TOP", power, "BOTTOM", 0, 0) else bars:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.HolyPower = bars
				end

				if D.Class == "PRIEST" then
					D.ConstructRessources("pb", 216, 5)
					if C["unitframes"].attached then pb:Point("TOP", power, "BOTTOM", 0, 0) else pb:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.ShadowOrbsBar = pb
				end

				if D.Class == "ROGUE" then
					D.ConstructRessources("ComboPoints", 216, 5)
					if C["unitframes"].attached then ComboPoints:Point("TOP", power, "BOTTOM", 0, 0) else ComboPoints:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.ComboPointsBar = ComboPoints
					self.AnticipationBar = ComboPointsAnticipationBar
				end

				if D.Class == "SHAMAN" then
					D.ConstructRessources("TotemBar", 216, 5)
					if C["unitframes"].attached then TotemBar:Point("TOP", power, "BOTTOM", 0, 0) else TotemBar:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.TotemBar = TotemBar
				end

				if D.Class == "WARLOCK" then
					D.ConstructRessources("wb", 216, 5)
					if C["unitframes"].attached then wb:Point("TOP", power, "BOTTOM", 0, 0) else wb:Point("BOTTOM", CBAnchor, "TOP", 0, -5) end
					self.WarlockSpecBars = wb
				end
			end

			self:SetScript("OnEnter", function(self)
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Hide()
				end
				FlashInfo.ManaLevel:Hide()
				UnitFrame_OnEnter(self) 
			end)
			self:SetScript("OnLeave", function(self) 
				if self.EclipseBar and self.EclipseBar:IsShown() then 
					self.EclipseBar.Text:Show()
				end
				FlashInfo.ManaLevel:Show()
				UnitFrame_OnLeave(self) 
			end)
		end

		if (unit == "target") then
			local Name = health:CreateFontString(nil, "OVERLAY")
			Name:Point("LEFT", health, "LEFT", 4, 0)
			Name:SetJustifyH("LEFT")
			Name:SetFontObject(font)
			Name:SetShadowOffset(1.25, -1.25)
			self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:namelong] [DuffedUI:diffcolor][level] [shortclassification]')
			self.Name = Name
		end

		if (unit == "target" and C["unitframes"].targetauras) then
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)

			buffs:SetHeight(20)
			buffs:SetWidth(218)
			buffs:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 25)
			buffs.size = 20
			buffs.num = 18

			debuffs:SetHeight(20)
			debuffs:SetWidth(218)
			debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", 4, 2)
			debuffs.size = 20
			debuffs.num = 27

			buffs.spacing = 2
			buffs.initialAnchor = 'TOPLEFT'
			buffs["growth-y"] = "UP"
			buffs["growth-x"] = "RIGHT"
			buffs.PostCreateIcon = D.PostCreateAura
			buffs.PostUpdateIcon = D.PostUpdateAura
			self.Buffs = buffs

			debuffs.spacing = 2
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = D.PostCreateAura
			debuffs.PostUpdateIcon = D.PostUpdateAura

			if unit == "target" then debuffs.onlyShowPlayer = C["unitframes"].onlyselfdebuffs end
			self.Debuffs = debuffs
		end
		
		-- cast bar for player and target
		if C["castbar"].enable == true then
			local tcb = CreateFrame("Frame", "TCBanchor", UIParent)
			tcb:SetTemplate("Default")
			tcb:Size(225, 18)
			tcb:Point("BOTTOM", UIParent, "BOTTOM", 0, 395)
			tcb:SetClampedToScreen(true)
			tcb:SetMovable(true)
			tcb:SetBackdropColor(0, 0, 0)
			tcb:SetBackdropBorderColor(1, 0, 0)
			tcb.text = D.SetFontString(tcb, C["media"].font, 11)
			tcb.text:SetPoint("CENTER")
			tcb.text:SetText(L["move"]["target"])
			tcb:Hide()
			tinsert(D.AllowFrameMoving, TCBanchor)

			local pcb = CreateFrame("Frame", "PCBanchor", UIParent)
			pcb:SetTemplate("Default")
			pcb:Size(DuffedUIBar1:GetWidth(), 21)
			pcb:Point("BOTTOM", DuffedUIBar1, "TOP", 0, 5)
			pcb:SetClampedToScreen(true)
			pcb:SetMovable(true)
			pcb:SetBackdropColor(0, 0, 0)
			pcb:SetBackdropBorderColor(1, 0, 0)
			pcb.text = D.SetFontString(pcb, C["media"].font, 11)
			pcb.text:SetPoint("CENTER")
			pcb.text:SetText(L["move"]["player"])
			pcb:Hide()
			tinsert(D.AllowFrameMoving, PCBanchor)

			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetStatusBarTexture(normTex)
			if unit == "player" then
				castbar:Height(21)
				if C["castbar"].cbicons then
					castbar:Width(C["castbar"].playerwidth - 31)
				else
					castbar:Width(C["castbar"].playerwidth)
				end
				castbar:Point("RIGHT", PCBanchor, "RIGHT", -2, 0)
			elseif unit == "target" then
				castbar:Width(225)
				castbar:Height(18)
				castbar:Point("LEFT", TCBanchor, "LEFT", 0, 0)
			end

			castbar.CustomTimeText = D.CustomTimeText
			castbar.CustomDelayText = CustomDelayText
			castbar.PostCastStart = D.CastBar
			castbar.PostChannelStart = D.CastBar

			castbar.time = castbar:CreateFontString(nil, "OVERLAY")
			castbar.time:SetFontObject(font)
			castbar.time:Point("RIGHT", castbar, "RIGHT", -5, 0)
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
			castbar.Text:SetFontObject(font)
			castbar.Text:Point("LEFT", castbar, "LEFT", 6, 0)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			castbar:CreateBackdrop()

			if C["castbar"].cbicons then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetTemplate("Default")

				if unit == "player" then
					castbar.button:Size(25)
					castbar.button:Point("RIGHT", castbar, "LEFT", -4, 0)
				elseif unit == "target" then
					castbar.button:Size(25)
					castbar.button:Point("BOTTOM", castbar, "TOP", 0, 5)
				end
				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
				castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			end

			if unit == "player" and C["castbar"].cblatency then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(normTex)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end

			if unit == "player" and C["castbar"].spark then
				castbar.Spark = castbar:CreateTexture(nil, "OVERLAY")
				castbar.Spark:SetHeight(40)
				castbar.Spark:SetWidth(10)
				castbar.Spark:SetBlendMode("ADD")
			end

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end

		if C["unitframes"].combatfeedback == true then
			local CombatFeedbackText 
			CombatFeedbackText = D.SetFontString(health, C["media"].font, 11, "THINOUTLINE")
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end

		if C["unitframes"].healcomm then
			local mhpb = CreateFrame('StatusBar', nil, self.Health)
			mhpb:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			mhpb:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			mhpb:SetWidth(250)
			mhpb:SetStatusBarTexture(normTex)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			mhpb:SetMinMaxValues(0,1)

			local ohpb = CreateFrame('StatusBar', nil, self.Health)
			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			ohpb:SetWidth(250)
			ohpb:SetStatusBarTexture(normTex)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			local absb = CreateFrame("StatusBar", nil, self.Health)
			absb:SetPoint("TOPLEFT", ohpb:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
			absb:SetPoint("BOTTOMLEFT", ohpb:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
			absb:SetWidth(250)
			absb:SetStatusBarTexture(normTex)
			absb:SetStatusBarColor(1, 1, 0, 0.25)

			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				absBar = absb,
				maxOverflow = 1,
			}
		end

		if C["unitframes"].playeraggro == true then
			table.insert(self.__elements, D.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', D.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', D.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', D.UpdateThreat)
		end

		if unit == "player" then self:RegisterEvent("PLAYER_ENTERING_WORLD", D.updateAllElements) end
	end

	--	Target of Target
	if (unit == "targettarget") or (unit == "pet") then
		local panel = CreateFrame("Frame", nil, self)
		panel:SetTemplate("Default")
		panel:Size(129, 17)
		panel:Point("BOTTOM", self, "BOTTOM", 0, D.Scale(0))
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(unpack(C["media"].bordercolor))
		panel:SetAlpha(0)
		self.panel = panel

		local health = CreateFrame('StatusBar', nil, self)
		health:Height(17)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		self.Health = health
		self.Health.bg = healthBG
		health.PostUpdate = D.PostUpdatePetColor

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end
		if C["unitframes"].unicolor == true then
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end
		else
			health.colorDisconnected = true
			health.colorTapping = true
			health.colorClass = true
			health.colorReaction = true
		end

		local power = CreateFrame('StatusBar', nil, self)
		power:Height(3)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 9, 1)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", -9, -2)
		power:SetStatusBarTexture(normTex)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

		local PowerBorder = CreateFrame("Frame", nil, power)
		PowerBorder:SetPoint("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
		PowerBorder:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		PowerBorder:SetTemplate("Default")
		PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		self.PowerBorder = PowerBorder

		power.frequentUpdates = true
		if C["unitframes"].showsmooth == true then power.Smooth = true end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3

		if C["unitframes"].unicolor == true then
			power.colorTapping = true
			power.colorClass = true
		else
			power.colorPower = true
		end

		self.Power = power
		self.Power.bg = powerBG

		if C["unitframes"].showsmooth == true then power.Smooth = true end

		local Name = health:CreateFontString(nil, "OVERLAY")
		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort] [DuffedUI:diffcolor][level] [shortclassification]')
		Name:SetPoint("CENTER", health, "CENTER", 2, 2)
		Name:SetJustifyH("CENTER")
		Name:SetFontObject(font)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		self.Name = Name

		if C["unitframes"].totdebuffs == true and (unit == "targettarget") then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:Height(20)
			debuffs:Width(300)
			debuffs.size = C["unitframes"].totdbsize
			debuffs.spacing = 3
			debuffs.num = 5

			debuffs:Point("TOPLEFT", health, "TOPLEFT", -1.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = D.PostCreateAura
			debuffs.PostUpdateIcon = D.PostUpdateAura
			self.Debuffs = debuffs
		end

		if (C["castbar"].enable == true) and (unit == "pet") then
			local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
			castbar:SetStatusBarTexture(normTex)
			castbar:Height(3)
			self.Castbar = castbar
			castbar:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 16)
			castbar:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 16)

			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:SetTexture(normTex)
			castbar.bg:SetVertexColor(0, 0, 0)
			castbar:SetFrameLevel(6)

			castbar.CustomTimeText = D.CustomTimeText
			castbar.CustomDelayText = D.CustomDelayText
			castbar.PostCastStart = D.CastBar
			castbar.PostChannelStart = D.CastBar

			self.Castbar.Time = castbar.time
		end
		self:RegisterEvent("UNIT_PET", D.updateAllElements)
	end

	--	Focus
	if (unit == "focus") then
		local health = CreateFrame('StatusBar', nil, self)
		health:Height(17)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end
		health.colorClass = true

		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		health.value =health:CreateFontString(nil, "OVERLAY")
		health.value:SetFontObject(font)
		health.value:Point("RIGHT", 0, 1)
		health.PostUpdate = D.PostUpdateHealth
		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end
		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end	
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end

		local power = CreateFrame('StatusBar', nil, self)
		power:Height(3)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 85, 0)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", -9, -3)
		power:SetStatusBarTexture(normTex)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

		local PowerBorder = CreateFrame("Frame", nil, power)
		PowerBorder:SetPoint("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
		PowerBorder:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		PowerBorder:SetTemplate("Default")
		PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		self.PowerBorder = PowerBorder

		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then power.Smooth = true end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		self.Power = power
		self.Power.bg = powerBG

		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("LEFT", health, "LEFT", 2, 0)
		Name:SetJustifyH("CENTER")
		Name:SetFontObject(font)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:namelong]')
		self.Name = Name

		if C["unitframes"].focusdebuffs then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(30)
			debuffs:SetWidth(200)
			debuffs:Point("RIGHT", self, "LEFT", -4, 10)
			debuffs.size = 28
			debuffs.num = 4
			debuffs.spacing = 2
			debuffs.initialAnchor = "RIGHT"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = D.PostCreateAura
			debuffs.PostUpdateIcon = D.PostUpdateAura
			self.Debuffs = debuffs
		end

		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
		castbar:SetStatusBarTexture(normTex)
		castbar:SetFrameLevel(10)
		castbar:Height(10)
		castbar:Width(201)
		castbar:SetPoint("LEFT", 8, 0)
		castbar:SetPoint("RIGHT", -16, 0)
		castbar:SetPoint("BOTTOM", 0, -12)
		castbar:CreateBackdrop()

		castbar.time = castbar:CreateFontString(nil, "OVERLAY")
		castbar.time:SetFontObject(font)
		castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.time:SetTextColor(0.84, 0.75, 0.65)
		castbar.time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = D.CustomTimeText

		castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
		castbar.Text:SetFontObject(font)
		castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
		castbar.Text:SetTextColor(0.84, 0.75, 0.65)
		castbar.CustomDelayText = D.CustomDelayText
		castbar.PostCastStart = D.CastBar
		castbar.PostChannelStart = D.CastBar

		castbar.button = CreateFrame("Frame", nil, castbar)
		castbar.button:Height(castbar:GetHeight()+4)
		castbar.button:Width(castbar:GetHeight()+4)
		castbar.button:Point("LEFT", castbar, "RIGHT", 4, 0)
		castbar.button:SetTemplate("Default")

		castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
		castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
		castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
		castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

		self.Castbar = castbar
		self.Castbar.Icon = castbar.icon
		self.Castbar.Time = castbar.time
	end

	--	Focus target
	if (unit == "focustarget") then
		local health = CreateFrame('StatusBar', nil, self)
		health:Height(10)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end
		health.colorClass = true

		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		self.Health = health
		self.Health.bg = healthBG
		health.PostUpdate = D.PostUpdatePetColor

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end

		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end

		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, -1)
		Name:SetJustifyH("CENTER")
		Name:SetFontObject(font)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort]')
		self.Name = Name
	end

	--	Arena or boss
	if (unit and unit:find("arena%d") and C["raid"].arena == true) or (unit and unit:find("boss%d") and C["raid"].showboss == true) then
		self:SetAttribute("type2", "togglemenu")

		local health = CreateFrame('StatusBar', nil, self)
		health:Height(22)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		health.frequentUpdates = true
		health.colorDisconnected = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end
		health.colorClass = true

		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		health.value = health:CreateFontString(nil, "OVERLAY")
		health.value:SetFontObject(font)
		health.value:Point("LEFT", 2, 0.5)
		health.PostUpdate = D.PostUpdateHealth

		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end

		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end

		local power = CreateFrame('StatusBar', nil, self)
		power:Height(3)
		power:Point("TOPLEFT", health, "BOTTOMLEFT", 85, 0)
		power:Point("TOPRIGHT", health, "BOTTOMRIGHT", -9, -3)
		power:SetStatusBarTexture(normTex)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

		local PowerBorder = CreateFrame("Frame", nil, power)
		PowerBorder:SetPoint("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
		PowerBorder:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		PowerBorder:SetTemplate("Default")
		PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
		self.PowerBorder = PowerBorder

		power.frequentUpdates = true
		power.colorPower = true
		if C["unitframes"].showsmooth == true then power.Smooth = true end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3

		power.value = power:CreateFontString(nil, "OVERLAY")
		power.value:SetFontObject(font)
		power.value:Point("RIGHT", -2, 0.5)
		power.PreUpdate = D.PreUpdatePower
		power.PostUpdate = D.PostUpdatePower

		self.Power = power
		self.Power.bg = powerBG

		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 1)
		Name:SetJustifyH("CENTER")
		Name:SetFontObject(font)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		Name.frequentUpdates = 0.2

		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort]')
		self.Name = Name

		if (unit and unit:find("boss%d")) then
			local AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
			AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
			AltPowerBar:Height(4)
			AltPowerBar:SetStatusBarTexture(C["media"].normTex)
			AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
			AltPowerBar:SetStatusBarColor(1, 0, 0)

			AltPowerBar:SetPoint("LEFT")
			AltPowerBar:SetPoint("RIGHT")
			AltPowerBar:SetPoint("TOP", self.Health, "TOP")
			AltPowerBar:SetBackdrop(backdrop)
			AltPowerBar:SetBackdropColor(0, 0, 0)

			self.AltPowerBar = AltPowerBar

			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(26)
			buffs:SetWidth(252)
			buffs:Point("TOPRIGHT", self, "TOPLEFT", -5, 2)
			buffs.size = 26
			buffs.num = 3
			buffs.spacing = 3
			buffs.initialAnchor = 'RIGHT'
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = D.PostCreateAura
			buffs.PostUpdateIcon = D.PostUpdateAura
			self.Buffs = buffs

			self:HookScript("OnShow", D.updateAllElements)
		end

		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', D.Scale(5), 2)
		debuffs.size = 26
		debuffs.num = 4
		debuffs.spacing = 3
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = D.PostCreateAura
		debuffs.PostUpdateIcon = D.PostUpdateAura
		debuffs.onlyShowPlayer = true
		self.Debuffs = debuffs

		if C["raid"].arena and (unit and unit:find('arena%d')) then
			local Trinket = CreateFrame("Frame", nil, self)
			Trinket:Size(26)
			Trinket:SetPoint("TOPRIGHT", self, "TOPLEFT", -5, 2)
			Trinket:CreateBackdrop("Default")
			Trinket.trinketUseAnnounce = true
			self.Trinket = Trinket
		end

		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)		
		castbar:SetHeight(12)
		castbar:SetStatusBarTexture(normTex)
		castbar:SetFrameLevel(10)
		castbar:SetPoint("LEFT", 23, -1)
		castbar:SetPoint("RIGHT", 0, -1)
		castbar:SetPoint("BOTTOM", 0, -21)
		castbar:CreateBackdrop()

		castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
		castbar.Text:SetFontObject(font)
		castbar.Text:Point("LEFT", castbar, "LEFT", 4, 0)
		castbar.Text:SetTextColor(0.84, 0.75, 0.65)

		castbar.time = castbar:CreateFontString(nil, "OVERLAY")
		castbar.time:SetFontObject(font)
		castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.time:SetTextColor(0.84, 0.75, 0.65)
		castbar.time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = D.CustomTimeText

		castbar.CustomDelayText = D.CustomDelayText
		castbar.PostCastStart = D.CastBar
		castbar.PostChannelStart = D.CastBar

		castbar.button = CreateFrame("Frame", nil, castbar)
		castbar.button:SetTemplate("Default")
		castbar.button:Size(16, 16)
		castbar.button:Point("BOTTOMRIGHT", castbar, "BOTTOMLEFT",-5,-2)

		castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
		castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
		castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
		castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)

		self.Castbar = castbar
		self.Castbar.Icon = castbar.icon
		self.Castbar.Time = castbar.time
	end

	--	Main tanks
	if(self:GetParent():GetName():match"DuffedUIMainTank" or self:GetParent():GetName():match"DuffedUIMainAssist") then
		self:SetAttribute("type2", "focus")

		local health = CreateFrame('StatusBar', nil, self)
		health:Height(20)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(0, 0, 0)

		local HealthBorder = CreateFrame("Frame", nil, health)
		HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
		HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
		HealthBorder:SetTemplate("Default")
		HealthBorder:SetFrameLevel(2)
		self.HealthBorder = HealthBorder

		self.Health = health
		self.Health.bg = healthBG
		health.PostUpdate = D.PostUpdatePetColor

		health.frequentUpdates = true
		if C["unitframes"].showsmooth == true then health.Smooth = true end

		if C["unitframes"].unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
			healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
			healthBG:SetTexture(.6, .6, .6)
			if C["unitframes"].ColorGradient then
				health.colorSmooth = true
				healthBG:SetTexture(0, 0, 0)
			end
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end

		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, 1)
		Name:SetJustifyH("CENTER")
		Name:SetFontObject(font)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort]')
		self.Name = Name
	end
	return self
end

--	Default position
if C["unitframes"].totdebuffs then totdebuffs = 24 end
oUF:RegisterStyle('DuffedUI', Shared)

local player = oUF:Spawn('player', "DuffedUIPlayer")
player:SetParent(DuffedUIPetBattleHider)
player:Point("BOTTOM", UIParent, "BOTTOM", -340, 240)
player:Size(218, 44)

local target = oUF:Spawn('target', "DuffedUITarget")
target:SetParent(DuffedUIPetBattleHider)
target:Point("BOTTOM", UIParent, "BOTTOM", 340, 240)
target:Size(218, 44)

local tot = oUF:Spawn('targettarget', "DuffedUITargetTarget")
tot:SetPoint("TOPRIGHT", DuffedUITarget, "BOTTOMLEFT", 0, -2)
tot:Size(129, 36)

local pet = oUF:Spawn('pet', "DuffedUIPet")
pet:SetParent(DuffedUIPetBattleHider)
pet:SetPoint("TOPLEFT", DuffedUIPlayer, "BOTTOMRIGHT", 0, -2)
pet:Size(129, 36)

local focus = oUF:Spawn('focus', "DuffedUIFocus")
focus:SetParent(DuffedUIPetBattleHider)
focus:SetPoint("BOTTOMLEFT", InvDuffedUIActionBarBackground, "BOTTOM", 275, 500)
focus:Size(200, 30)

local focustarget = oUF:Spawn("focustarget", "DuffedUIFocusTarget")
focustarget:SetPoint("TOPRIGHT", focus, "BOTTOMLEFT", 0, -2)
focustarget:Size(75, 10)

if C["raid"].arena then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "DuffedUIArena"..i)
		arena[i]:SetParent(DuffedUIPetBattleHider)
		if i == 1 then
			arena[i]:SetPoint("RIGHT", UIParent, "RIGHT", -163, -250)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 35)
		end
		arena[i]:Size(200, 27)
	end

	local DuffedUIPrepArena = {}
	for i = 1, 5 do
		DuffedUIPrepArena[i] = CreateFrame("Frame", "DuffedUIPrepArena"..i, UIParent)
		DuffedUIPrepArena[i]:SetAllPoints(arena[i])
		DuffedUIPrepArena[i]:SetBackdrop(backdrop)
		DuffedUIPrepArena[i]:SetBackdropColor(0,0,0)
		DuffedUIPrepArena[i].Health = CreateFrame("StatusBar", nil, DuffedUIPrepArena[i])
		DuffedUIPrepArena[i].Health:SetAllPoints()
		DuffedUIPrepArena[i].Health:SetStatusBarTexture(normTex)
		DuffedUIPrepArena[i].Health:SetStatusBarColor(.3, .3, .3, 1)
		DuffedUIPrepArena[i].SpecClass = DuffedUIPrepArena[i].Health:CreateFontString(nil, "OVERLAY")
		DuffedUIPrepArena[i].SpecClass:SetFontObject(font)
		DuffedUIPrepArena[i].SpecClass:SetPoint("CENTER")
		DuffedUIPrepArena[i]:Hide()
	end

	local ArenaListener = CreateFrame("Frame", "DuffedUIArenaListener", UIParent)
	ArenaListener:RegisterEvent("PLAYER_ENTERING_WORLD")
	ArenaListener:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	ArenaListener:RegisterEvent("ARENA_OPPONENT_UPDATE")
	ArenaListener:SetScript("OnEvent", function(self, event)
		if event == "ARENA_OPPONENT_UPDATE" then
			for i=1, 5 do
				local f = _G["DuffedUIPrepArena"..i]
				f:Hide()
			end
		else
			local numOpps = GetNumArenaOpponentSpecs()

			if numOpps > 0 then
				for i=1, 5 do
					local f = _G["DuffedUIPrepArena"..i]
					local s = GetArenaOpponentSpec(i)
					local _, spec, class = nil, "UNKNOWN", "UNKNOWN"

					if s and s > 0 then 
						_, spec, _, _, _, _, class = GetSpecializationInfoByID(s)
					end

					if (i <= numOpps) then
						if class and spec then
							f.SpecClass:SetText(spec.."  -  "..LOCALIZED_CLASS_NAMES_MALE[class])
							if not C["unitframes"].unicolor then
								local color = arena[i].colors.class[class]
								f.Health:SetStatusBarColor(unpack(color))
							end
							f:Show()
						end
					else
						f:Hide()
					end
				end
			else
				for i=1, 5 do
					local f = _G["DuffedUIPrepArena"..i]
					f:Hide()
				end			
			end
		end
	end)
end

if C["raid"].showboss then
	for i = 1, MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = D.Dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "DuffedUIBoss"..i)
		boss[i]:SetParent(DuffedUIPetBattleHider)
		if i == 1 then
			boss[i]:SetPoint("RIGHT", UIParent, "RIGHT", -163, -250)
		else
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 35)             
		end
		boss[i]:Size(200, 27)
	end
end

local assisttank_width = 90
local assisttank_height  = 20
if C["raid"].maintank == true then
	local tank = oUF:SpawnHeader('DuffedUIMainTank', nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINTANK',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_DuffedUIMtt'
	)
	tank:SetParent(DuffedUIPetBattleHider)
	if C["chat"].rbackground then
		tank:SetPoint("TOPLEFT", DuffedUIChatBackgroundRight, "TOPLEFT", 2, 52)
	else
		tank:SetPoint("TOPLEFT", ChatFrame4, "TOPLEFT", 2, 62)
	end
end
 
if C["raid"].mainassist == true then
	local assist = oUF:SpawnHeader("DuffedUIMainAssist", nil, 'raid',
		'oUF-initialConfigFunction', ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		'showRaid', true,
		'groupFilter', 'MAINASSIST',
		'yOffset', 7,
		'point' , 'BOTTOM',
		'template', 'oUF_DuffedUIMtt'
	)
	assist:SetParent(DuffedUIPetBattleHider)
	if C["raid"].maintank == true then
		assist:SetPoint("TOPLEFT", DuffedUIMainTank, "BOTTOMLEFT", 2, -50)
	else
		assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)