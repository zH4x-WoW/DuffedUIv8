local D, C, L = unpack(select(2, ...))
if not C["unitframes"].enable or C["unitframes"].layout ~= 1 then return end

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

--[[Local Variables]]--
local normTex = C["media"].normTex
local glowTex = C["media"].glowTex
local bubbleTex = C["media"].bubbleTex
local font = D.Font(C["font"].unitframes)

local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D.mult, left = -D.mult, bottom = -D.mult, right = -D.mult},
}

--[[Layout]]--
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

	--[[Fader]]--
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

	--[[Player & Target]]--
	if (unit == "player" or unit == "target") then
	
	end

	--[[Target of Target & Pet]]--
	if (unit == "targetoftarget" or unit == "pet") then
	
	end
	
	--[[Focus]]--
	if (unit == "focus") then
		local health = CreateFrame("StatusBar", nil, self)
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

		local healthBG = health:CreateTexture(nil, "BORDER")
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

		local power = CreateFrame("StatusBar", nil, self)
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

		local powerBG = power:CreateTexture(nil, "BORDER")
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

		self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:namelong]")
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

	--[[Focus Target]]--
	if (unit == "focustarget") then
		local health = CreateFrame("StatusBar", nil, self)
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

		local healthBG = health:CreateTexture(nil, "BORDER")
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

		self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
		self.Name = Name
	end

	--[[Arena- / Boss-Frames]]--
	if (unit and unit:find("arena%d") and C["raid"].arena == true) or (unit and unit:find("boss%d") and C["raid"].showboss == true) then
		self:SetAttribute("type2", "togglemenu")

		local health = CreateFrame("StatusBar", nil, self)
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

		local healthBG = health:CreateTexture(nil, "BORDER")
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

		local power = CreateFrame("StatusBar", nil, self)
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

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3

		power.value = power:CreateFontString(nil, "OVERLAY")
		power.value:SetFontObject(font)
		power.value:Point("RIGHT", health, -2, 0.5)
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

		self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
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
			buffs.initialAnchor = "RIGHT"
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = D.PostCreateAura
			buffs.PostUpdateIcon = D.PostUpdateAura
			self.Buffs = buffs

			self:HookScript("OnShow", D.updateAllElements)
		end

		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint("TOPLEFT", self, "TOPRIGHT", D.Scale(5), 2)
		debuffs.size = 26
		debuffs.num = 4
		debuffs.spacing = 3
		debuffs.initialAnchor = "LEFT"
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = D.PostCreateAura
		debuffs.PostUpdateIcon = D.PostUpdateAura
		debuffs.onlyShowPlayer = true
		self.Debuffs = debuffs

		if C["raid"].arena and (unit and unit:find("arena%d")) then
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

	--[[Main Tanks]]--
	if(self:GetParent():GetName():match"DuffedUIMainTank" or self:GetParent():GetName():match"DuffedUIMainAssist") then
		self:SetAttribute("type2", "focus")

		local health = CreateFrame("StatusBar", nil, self)
		health:Height(20)
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		local healthBG = health:CreateTexture(nil, "BORDER")
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

		self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
		self.Name = Name
	end
	return self
end

--[[Default Position]]--
if C["unitframes"].totdebuffs then totdebuffs = 24 end
oUF:RegisterStyle("DuffedUI", Shared)

local player = oUF:Spawn("player", "DuffedUIPlayer")
player:SetParent(DuffedUIPetBattleHider)
player:Point("BOTTOM", UIParent, "BOTTOM", -340, 225)
player:Size(218, 44)

local target = oUF:Spawn("target", "DuffedUITarget")
target:SetParent(DuffedUIPetBattleHider)
target:Point("BOTTOM", UIParent, "BOTTOM", 340, 225)
target:Size(218, 44)

if C["unitframes"].Enable_ToT then
	local tot = oUF:Spawn("targettarget", "DuffedUITargetTarget")
	if C["raid"].center then tot:SetPoint("TOPRIGHT", DuffedUITarget, "BOTTOMLEFT", 129, -2) else tot:SetPoint("TOPRIGHT", DuffedUITarget, "BOTTOMLEFT", 0, -2) end
	tot:Size(129, 36)
end

local pet = oUF:Spawn("pet", "DuffedUIPet")
pet:SetParent(DuffedUIPetBattleHider)
if C["raid"].center then pet:SetPoint("TOPLEFT", DuffedUIPlayer, "BOTTOMRIGHT", -129, -2) else pet:SetPoint("TOPLEFT", DuffedUIPlayer, "BOTTOMRIGHT", 0, -2) end
pet:Size(129, 36)

local focus = oUF:Spawn("focus", "DuffedUIFocus")
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
		if i == 1 then arena[i]:SetPoint("RIGHT", UIParent, "RIGHT", -163, -250) else arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 35) end
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
		if i == 1 then boss[i]:SetPoint("RIGHT", UIParent, "RIGHT", -163, -250) else boss[i]:SetPoint("BOTTOM", boss[i-1], "TOP", 0, 35) end
		boss[i]:Size(200, 27)
	end
end

local assisttank_width = 90
local assisttank_height  = 20
if C["raid"].maintank == true then
	local tank = oUF:SpawnHeader("DuffedUIMainTank", nil, "raid",
		"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		"showRaid", true,
		"groupFilter", "MAINTANK",
		"yOffset", 7,
		"point" , "BOTTOM",
		"template", "oUF_DuffedUIMtt"
	)
	tank:SetParent(DuffedUIPetBattleHider)
	if C["chat"].rbackground then tank:SetPoint("TOPLEFT", DuffedUIChatBackgroundRight, "TOPLEFT", 2, 52) else tank:SetPoint("TOPLEFT", ChatFrame4, "TOPLEFT", 2, 62) end
end
 
if C["raid"].mainassist == true then
	local assist = oUF:SpawnHeader("DuffedUIMainAssist", nil, "raid",
		"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
		]]):format(assisttank_width, assisttank_height),
		"showRaid", true,
		"groupFilter", "MAINASSIST",
		"yOffset", 7,
		"point" , "BOTTOM",
		"template", "oUF_DuffedUIMtt"
	)
	assist:SetParent(DuffedUIPetBattleHider)
	if C["raid"].maintank == true then assist:SetPoint("TOPLEFT", DuffedUIMainTank, "BOTTOMLEFT", 2, -50) else assist:SetPoint("CENTER", UIParent, "CENTER", 0, 0) end
end

local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)