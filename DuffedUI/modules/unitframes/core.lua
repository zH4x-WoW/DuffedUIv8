local D, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local Panels = D["Panels"]
local Colors = D["Colors"]
local Noop = function() end
local DuffedUIUnitFrames = CreateFrame("Frame")

-- Lib globals
local strfind = strfind
local format = format
local floor = floor

-- WoW globals (I don't really wanna import all the funcs we use here, so localize the ones called a LOT, like in Health/Power functions)
local UnitIsEnemy = UnitIsEnemy
local UnitIsPlayer = UnitIsPlayer
local UnitIsFriend = UnitIsFriend
local UnitIsConnected = UnitIsConnected
local UnitPlayerControlled = UnitPlayerControlled
local UnitIsGhost = UnitIsGhost
local UnitIsDead = UnitIsDead
local UnitPowerType = UnitPowerType
local Class = select(2, UnitClass("player"))
local BossFrames = MAX_BOSS_FRAMES
local Layout = C["unitframes"].Layout

DuffedUIUnitFrames.Units = {}
DuffedUIUnitFrames.Headers = {}
DuffedUIUnitFrames.Framework = DuffedUIUnitFrameFramework
DuffedUIUnitFrames.Backdrop = {
	bgFile = C["medias"].Blank,
	insets = {top = -D.Mult, left = -D.Mult, bottom = -D.Mult, right = -D.Mult},
}

function DuffedUIUnitFrames:DisableBlizzard()
	for i = 1, MAX_BOSS_FRAMES do
		local Boss = _G["Boss"..i.."TargetFrame"]
		local Health = _G["Boss"..i.."TargetFrame".."HealthBar"]
		local Power = _G["Boss"..i.."TargetFrame".."ManaBar"]
		
		Boss:UnregisterAllEvents()
		Boss.Show = Noop
		Boss:Hide()
		
		Health:UnregisterAllEvents()
		Power:UnregisterAllEvents()
	end
	
	if C["raid"].Enable then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		
		CompactRaidFrameManager:SetParent(Panels.Hider)
		CompactUnitFrameProfiles:UnregisterAllEvents()
			
		for i = 1, MAX_PARTY_MEMBERS do
			local PartyMember = _G["PartyMemberFrame" .. i]
			local Health = _G["PartyMemberFrame" .. i .. "HealthBar"]
			local Power = _G["PartyMemberFrame" .. i .. "ManaBar"]
			local Pet = _G["PartyMemberFrame" .. i .."PetFrame"]
			local PetHealth = _G["PartyMemberFrame" .. i .."PetFrame" .. "HealthBar"]

			PartyMember:UnregisterAllEvents()
			PartyMember:SetParent(Panels.Hider)
			PartyMember:Hide()
			Health:UnregisterAllEvents()
			Power:UnregisterAllEvents()
			
			Pet:UnregisterAllEvents()
			Pet:SetParent(Panels.Hider)
			PetHealth:UnregisterAllEvents()
			
			HidePartyFrame()
			ShowPartyFrame = Noop
			HidePartyFrame = Noop
		end
	end
end

function DuffedUIUnitFrames:ShortValue()
	if self <= 999 then
		return self
	end

	local Value

	if self >= 1000000 then
		Value = format("%.1fm", self/1000000)
		return Value
	elseif self >= 1000 then
		Value = format("%.1fk", self/1000)
		return Value
	end
end

function DuffedUIUnitFrames:UTF8Sub(i, dots)
	if not self then return end

	local Bytes = self:len()
	if (Bytes <= i) then
		return self
	else
		local Len, Pos = 0, 1
		while(Pos <= Bytes) do
			Len = Len + 1
			local c = self:byte(Pos)
			if (c > 0 and c <= 127) then
				Pos = Pos + 1
			elseif (c >= 192 and c <= 223) then
				Pos = Pos + 2
			elseif (c >= 224 and c <= 239) then
				Pos = Pos + 3
			elseif (c >= 240 and c <= 247) then
				Pos = Pos + 4
			end
			if (Len == i) then break end
		end

		if (Len == i and Pos <= Bytes) then
			return self:sub(1, Pos - 1)..(dots and '...' or '')
		else
			return self
		end
	end
end

function DuffedUIUnitFrames:MouseOnPlayer()
	local Status = self.Status
	local MouseOver = GetMouseFocus()

	if (MouseOver == self) then
		Status:Show()

		if (UnitIsPVP("player")) then
			Status:SetText("PVP")
		end
	else
		Status:Hide()
		Status:SetText()
	end
end

function DuffedUIUnitFrames:UpdateShadow(height)
	local Frame = self:GetParent()
	local Shadow = Frame.Shadow
	
	if not Shadow then
		return
	end

	Shadow:Point("TOPLEFT", -4, height)
end

function DuffedUIUnitFrames:UpdateAurasHeaderPosition(script, x, y)
	local Frame = self:GetParent()
	local Buffs = Frame.Buffs

	if not Buffs then
		return
	end

	Buffs:ClearAllPoints()
	Buffs:Point("BOTTOMLEFT", Frame, "TOPLEFT", 0, height)
end

function DuffedUIUnitFrames:CustomCastTimeText(duration)
	local Value = format("%.1f / %.1f", self.channeling and duration or self.max - duration, self.max)

	self.Time:SetText(Value)
end

function DuffedUIUnitFrames:CustomCastDelayText(duration)
	local Value = format("%.1f |cffaf5050%s %.1f|r", self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay)

	self.Time:SetText(Value)
end

function DuffedUIUnitFrames:CheckInterrupt(unit)
	if (unit == "vehicle") then
		unit = "player"
	end

	if (self.interrupt and UnitCanAttack("player", unit)) then
		self:SetStatusBarColor(1, 0, 0, 0.5)
	else
		self:SetStatusBarColor(0.31, 0.45, 0.63, 0.5)
	end
end

function DuffedUIUnitFrames:CheckCast(unit, name, rank, castid)
	DuffedUIUnitFrames.CheckInterrupt(self, unit)
end

-- check if we can interrupt on channel cast
function DuffedUIUnitFrames:CheckChannel(unit, name, rank)
	DuffedUIUnitFrames.CheckInterrupt(self, unit)
end

function DuffedUIUnitFrames:PostUpdateHealth(unit, min, max)
	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		if (not UnitIsConnected(unit)) then
			self.Value:SetText("|cffD7BEA5"..FRIENDS_LIST_OFFLINE.."|r")
		elseif (UnitIsDead(unit)) then
			self.Value:SetText("|cffD7BEA5"..DEAD.."|r")
		elseif (UnitIsGhost(unit)) then
			self.Value:SetText("|cffD7BEA5"..L.UnitFrames.Ghost.."|r")
		end
	else
		local r, g, b

		if not C["unitframes"].UniColor then
			if (unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
				local Color = Colors.reaction[UnitReaction(unit, "player")]
				r, g, b = Color[1], Color[2], Color[3]
				self:SetStatusBarColor(r, g, b)
			end
		end
		
		if C["unitframes"].ColorGradient and C["unitframes"].UniColor then
			local r, g, b = D.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			self:SetStatusBarColor(r, g, b)
		end

		if (min ~= max) then
			r, g, b = D.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				if C["unitframes"].ShowTotalHP then
					self.Value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", DuffedUIUnitFrames.ShortValue(min), DuffedUIUnitFrames.ShortValue(max))
				else
					self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", DuffedUIUnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif (unit == "target" or (unit and strfind(unit, "boss%d"))) then
				if C["unitframes"].ShowTotalHP then
					self.Value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", DuffedUIUnitFrames.ShortValue(min), DuffedUIUnitFrames.ShortValue(max))
				else
					self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", DuffedUIUnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif (unit and strfind(unit, "arena%d")) or (unit == "focus") or (unit == "focustarget") then
				if C["unitframes"].ShowTotalHP then
					self.Value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", DuffedUIUnitFrames.ShortValue(min), DuffedUIUnitFrames.ShortValue(max))
				else
					self.Value:SetText("|cff559655"..DuffedUIUnitFrames.ShortValue(min).."|r")
				end
			else
				self.Value:SetText("|cff559655-"..DuffedUIUnitFrames.ShortValue(max-min).."|r")
			end
		else
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetText("|cff559655"..DuffedUIUnitFrames.ShortValue(max).."|r")
			elseif (unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText("|cff559655"..DuffedUIUnitFrames.ShortValue(max).."|r")
			else
				self.Value:SetText(" ")
			end
		end
	end
end

function DuffedUIUnitFrames:PostUpdateHealthRaid(unit, min, max)
	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		if (not UnitIsConnected(unit)) then
			self.Value:SetText("|cffD7BEA5"..FRIENDS_LIST_OFFLINE.."|r")
		elseif (UnitIsDead(unit)) then
			self.Value:SetText("|cffD7BEA5"..DEAD.."|r")
		elseif (UnitIsGhost(unit)) then
			self.Value:SetText("|cffD7BEA5"..L.UnitFrames.Ghost.."|r")
		end
	else
		local r, g, b
		
		if C["unitframes"].ColorGradient and C["unitframes"].UniColor then
			local r, g, b = D.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			self:SetStatusBarColor(r, g, b)
		end
		
		if not C["unitframes"].UniColor then
			if (unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
				local Color = Colors.reaction[UnitReaction(unit, "player")]
				r, g, b = Color[1], Color[2], Color[3]
				self:SetStatusBarColor(r, g, b)
			end
		end

		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"].UniColor ~= true then
			local Color = Colors.reaction[5]
			local r, g, b = Color[1], Color[2], Color[3]
			self:SetStatusBarColor(r, g, b)
			self.bg:SetTexture(.1, .1, .1)
		end
		
		if min ~= max then
			self.Value:SetText("|cff559655-"..DuffedUIUnitFrames.ShortValue(max-min).."|r")
		else
			self.Value:SetText(" ")
		end
	end
end

function DuffedUIUnitFrames:PostUpdatePower(unit, min, max)
	local Parent = self:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local Color = Colors.power[pToken]

	if Color then
		self.Value:SetTextColor(Color[1], Color[2], Color[3])
	end

	if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) then
		self.Value:SetText()
	elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
		self.Value:SetText()
	else
		if (min ~= max) then
			if (pType == 0) then
				if (unit == "target") then
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), DuffedUIUnitFrames.ShortValue(max - (max - min)))
				elseif (unit == "player" and Parent:GetAttribute("normalUnit") == "pet" or unit == "pet") then
					self.Value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and strfind(unit, "arena%d")) or unit == "focus" or unit == "focustarget" then
					self.Value:SetText(DuffedUIUnitFrames.ShortValue(min))
				else
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
				end
			else
				self.Value:SetText(max - (max - min))
			end
		else
			if (unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText(DuffedUIUnitFrames.ShortValue(min))
			else
				self.Value:SetText(min)
			end
		end
	end
end

function DuffedUIUnitFrames:UpdateReputationColor(event, unit, bar)
	local _, ID = GetWatchedFactionInfo()

	bar:SetStatusBarColor(FACTION_BAR_COLORS[ID].r, FACTION_BAR_COLORS[ID].g, FACTION_BAR_COLORS[ID].b)
end

local function UpdateTotemTimer(self, elapsed)
	self.timeLeft = self.timeLeft - elapsed

	local timeLeft = self.timeLeft
	if timeLeft > 0 then
		self:SetValue(timeLeft)
	else
		self:SetValue(0)
		self:SetScript("OnUpdate", nil)
	end
end

local function hasbit(x, p)
	return x % (p + p) >= p
end

local function setbit(x, p)
	return hasbit(x, p) and x or x + p
end

local function clearbit(x, p)
	return hasbit(x, p) and x - p or x
end

function DuffedUIUnitFrames:UpdateTotemOverride(event, slot)
	local Bar = self.Totems
	local priorities = Bar.__map

	if Bar.PreUpdate then Bar:PreUpdate(priorities[slot]) end

	local totem = Bar[priorities[slot]]
	local haveTotem, name, start, duration, icon = GetTotemInfo(slot)
	if haveTotem then
		totem.timeLeft = (start + duration) - GetTime()
		totem:SetMinMaxValues(0, duration)
		totem:SetScript("OnUpdate", UpdateTotemTimer)

		local r, g, b = unpack(Colors.totems[slot])
		totem:SetStatusBarColor(r, g, b)
		if totem.bg then
			local mu = totem.bg.multiplier or 1
			r, g, b = r * mu, g * mu, b * mu
			totem.bg:SetVertexColor(r, g, b)
		end

		Bar.activeTotems = setbit(Bar.activeTotems, 2 ^ (slot - 1))
		totem:Show()
	else
		totem:SetValue(0)
		totem:SetScript("OnUpdate", nil)

		Bar.activeTotems = clearbit(Bar.activeTotems, 2 ^ (slot - 1))
		totem:Hide()
	end

	if Bar.activeTotems > 0 then
		Bar:Show()
	else
		Bar:Hide()
	end

	if Bar.PostUpdate then
		return Bar:PostUpdate(priorities[slot], haveTotem, name, start, duration, icon)
	end
end

function DuffedUIUnitFrames:CreateAuraTimer(elapsed)
	if (self.TimeLeft) then
		self.Elapsed = (self.Elapsed or 0) + elapsed

		if self.Elapsed >= 0.1 then
			if not self.First then
				self.TimeLeft = self.TimeLeft - self.Elapsed
			else
				self.TimeLeft = self.TimeLeft - GetTime()
				self.First = false
			end

			if self.TimeLeft > 0 then
				local Time = D.FormatTime(self.TimeLeft)
				self.Remaining:SetText(Time)
				
				if self.TimeLeft <= 5 then
					self.Remaining:SetTextColor(0.99, 0.31, 0.31)
				else
					self.Remaining:SetTextColor(1, 1, 1)
				end
			else
				self.Remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end

			self.Elapsed = 0
		end
	end
end

function DuffedUIUnitFrames:PostCreateAura(button)
	button:SetTemplate("Default")

	button.Remaining = button:CreateFontString(nil, "OVERLAY")
	button.Remaining:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	button.Remaining:Point("TOPLEFT", 1, -3)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse()
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetInside()

	button.icon:SetInside()
	button.icon:SetTexCoord(unpack(D.IconCoord))
	button.icon:SetDrawLayer('ARTWORK')

	button.count:Point("BOTTOMRIGHT", 1, 1)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C["medias"].Font, 9, "THINOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)

	button.OverlayFrame = CreateFrame("Frame", nil, button, nil)
	button.OverlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
	button.overlay:SetParent(button.OverlayFrame)
	button.count:SetParent(button.OverlayFrame)
	button.Remaining:SetParent(button.OverlayFrame)

	button.Animation = button:CreateAnimationGroup()
	button.Animation:SetLooping("BOUNCE")

	button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
	button.Animation.FadeOut:SetChange(-.9)
	button.Animation.FadeOut:SetDuration(.6)
	button.Animation.FadeOut:SetSmoothing("IN_OUT")
end

function DuffedUIUnitFrames:PostUpdateAura(unit, button, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, DType, Duration, ExpirationTime, UnitCaster, IsStealable = UnitAura(unit, index, button.filter)

	if button then
		if(button.filter == "HARMFUL") then
			if(not UnitIsFriend("player", unit) and button.owner ~= "player" and button.owner ~= "vehicle") then
				button.icon:SetDesaturated(true)
				button:SetBackdropBorderColor(unpack(C["general"].BorderColor))
			else
				local color = DebuffTypeColor[DType] or DebuffTypeColor.none
				button.icon:SetDesaturated(false)
				button:SetBackdropBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			end
		else
			if (IsStealable or DType == "Magic") and not UnitIsFriend("player", unit) and not button.Animation.Playing then
				button.Animation:Play()
				button.Animation.Playing = true
			else
				button.Animation:Stop()
				button.Animation.Playing = false
			end
		end

		if Duration and Duration > 0 then
			button.Remaining:Show()
		else
			button.Remaining:Hide()
		end

		button.Duration = Duration
		button.TimeLeft = ExpirationTime
		button.First = true
		button:SetScript("OnUpdate", DuffedUIUnitFrames.CreateAuraTimer)
	end
end

function DuffedUIUnitFrames:SetGridGroupRole()
	local LFDRole = self.LFDRole
	local Role = UnitGroupRolesAssigned(self.unit)
	
	if Role == "TANK" then
		LFDRole:SetTexture(67/255, 110/255, 238/255,.3)
		LFDRole:Show()
	elseif Role == "HEALER" then
		LFDRole:SetTexture(130/255,  255/255, 130/255, .15)
		LFDRole:Show()
	elseif Role == "DAMAGER" then
		LFDRole:SetTexture(176/255, 23/255, 31/255, .27)
		LFDRole:Show()
	else
		LFDRole:Hide()
	end
end

DuffedUIUnitFrames.CountOffsets = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

-- skin the icon
function DuffedUIUnitFrames:CreateAuraWatchIcon(icon)
	icon:SetTemplate()
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon.icon:SetDrawLayer("ARTWORK")

	if (icon.cd) then
		icon.cd:SetReverse()
	end

	icon.overlay:SetTexture()
end

-- create the icon
function DuffedUIUnitFrames:CreateAuraWatch(frame)
	local Auras = CreateFrame("Frame", nil, frame)
	Auras:SetPoint("TOPLEFT", frame.Health, 2, -2)
	Auras:SetPoint("BOTTOMRIGHT", frame.Health, -2, 2)
	Auras.presentAlpha = 1
	Auras.missingAlpha = 0
	Auras.icons = {}
	Auras.PostCreateIcon = DuffedUIUnitFrames.CreateAuraWatchIcon

	if (not C["raid"].AuraWatchTimers) then
		Auras.hideCooldown = true
	end

	local buffs = {}

	if (DuffedUIUnitFrames.BuffIDs["ALL"]) then
		for key, value in pairs(DuffedUIUnitFrames.BuffIDs["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (DuffedUIUnitFrames.BuffIDs[Class]) then
		for key, value in pairs(DuffedUIUnitFrames.BuffIDs[Class]) do
			tinsert(buffs, value)
		end
	end

	-- Cornerbuffs
	if buffs then
		for key, spell in pairs(buffs) do
			local Icon = CreateFrame("Frame", nil, Auras)
			Icon.spellID = spell[1]
			Icon.anyUnit = spell[4]
			Icon:Width(6)
			Icon:Height(6)
			Icon:SetPoint(spell[2], 0, 0)

			local Texture = Icon:CreateTexture(nil, "OVERLAY")
			Texture:SetAllPoints(Icon)
			Texture:SetTexture(C["medias"].Blank)

			if (spell[3]) then
				Texture:SetVertexColor(unpack(spell[3]))
			else
				Texture:SetVertexColor(0.8, 0.8, 0.8)
			end

			local Count = Icon:CreateFontString(nil, "OVERLAY")
			Count:SetFont(C["medias"].Font, 8, "THINOUTLINE")
			Count:SetPoint("CENTER", unpack(DuffedUIUnitFrames.CountOffsets[spell[2]]))
			Icon.count = Count

			Auras.icons[spell[1]] = Icon
		end
	end

	frame.AuraWatch = Auras
end

function DuffedUIUnitFrames:EclipseDirection()
	if (GetEclipseDirection() == "sun") then
			self.Text:SetText("|cffE5994C"..L.UnitFrames.Starfire.."|r")
	elseif (GetEclipseDirection() == "moon") then
			self.Text:SetText("|cff4478BC"..L.UnitFrames.Wrath.."|r")
	else
			self.Text:SetText("")
	end
end

-- Class buffs { spell ID, position [, {r,g,b,a}][, anyUnit] }
-- It use oUF_AuraWatch lib, for grid indicator
if C["raid"].AuraWatch then
	do
		DuffedUIUnitFrames.BuffIDs = {
			PRIEST = {
				{6788, "TOPRIGHT", {1, 0, 0}, true},	  -- Weakened Soul
				{33076, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},  -- Prayer of Mending
				{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},     -- Renew
				{17, "TOPLEFT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
			},
			DRUID = {
				{774, "TOPLEFT", {0.8, 0.4, 0.8}},      -- Rejuvenation
				{8936, "TOPRIGHT", {0.2, 0.8, 0.2}},    -- Regrowth
				{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
				{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},  -- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0.7, 0.3, 0.7}},	        -- Beacon of Light
				{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true}, 	-- Hand of Protection
				{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	-- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0.93, 0.75, 0}, true},	-- Hand of Salvation
				{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	-- Hand of Sacrifice
				{114163, "TOPLEFT", {0.81, 0.85, 0.1}, true},	-- Eternal Flame
				{20925, "TOPLEFT", {0.81, 0.85, 0.1}, true},	-- Sacred Shield
			},
			SHAMAN = {
				{61295, "TOPLEFT", {0.7, 0.3, 0.7}},       -- Riptide
				{51945, "TOPRIGHT", {0.2, 0.7, 0.2}},      -- Earthliving
				{974, "BOTTOMRIGHT", {0.7, 0.4, 0}, true}, -- Earth Shield
			},
			MONK = {
				{119611, "TOPLEFT", {0.8, 0.4, 0.8}},	 --Renewing Mist
				{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},	 -- Life Cocoon
				{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Enveloping Mist
				{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},  -- Zen Sphere
			},
			ALL = {
				{14253, "RIGHT", {0, 1, 0}}, -- Abolish Poison
			},
		}
	end
end

-- Dispellable & Important Raid Debuffs we want to show on Grid!
-- It use oUF_RaidDebuffs lib for tracking dispellable / important
if C["raid"].DebuffWatch then
	do
		local RaidDebuff = oUF_RaidDebuffs

		if (not RaidDebuff) then
			return
		end

		RaidDebuff.ShowDispelableDebuff = true
		RaidDebuff.FilterDispellableDebuff = true
		RaidDebuff.MatchBySpellName = true
		RaidDebuff.DeepCorruption = true

		local SpellName = function(id)
			local Name = select(1, GetSpellInfo(id))

			return Name
		end

		-- Important Raid Debuffs we want to show on Grid!
		-- Mists of Pandaria debuff list created by prophet
		-- http://www.tukui.org/code/view.php?id=PROPHET170812083424
		DuffedUIUnitFrames.DebuffIDs = {
			-----------------------------------------------------------------
			-- Mogu'shan Vaults
			-----------------------------------------------------------------
			-- The Stone Guard
			SpellName(116281),	-- Cobalt Mine Blast

			-- Feng the Accursed
			SpellName(116784),	-- Wildfire Spark
			SpellName(116417),	-- Arcane Resonance
			SpellName(116942),	-- Flaming Spear

			-- Gara'jal the Spiritbinder
			SpellName(116161),	-- Crossed Over
			SpellName(122151),	-- Voodoo Dolls

			-- The Spirit Kings
			SpellName(117708),	-- Maddening Shout
			SpellName(118303),	-- Fixate
			SpellName(118048),	-- Pillaged
			SpellName(118135),	-- Pinned Down

			-- Elegon
			SpellName(117878),	-- Overcharged
			SpellName(117949),	-- Closed Circuit

			-- Will of the Emperor
			SpellName(116835),	-- Devastating Arc
			SpellName(116778),	-- Focused Defense
			SpellName(116525),	-- Focused Assault

			-----------------------------------------------------------------
			-- Heart of Fear
			-----------------------------------------------------------------
			-- Imperial Vizier Zor'lok
			SpellName(122761),	-- Exhale
			SpellName(122760), -- Exhale
			SpellName(122740),	-- Convert
			SpellName(123812),	-- Pheromones of Zeal

			-- Blade Lord Ta'yak
			SpellName(123180),	-- Wind Step
			SpellName(123474),	-- Overwhelming Assault

			-- Garalon
			SpellName(122835),	-- Pheromones
			SpellName(123081),	-- Pungency

			-- Wind Lord Mel'jarak
			SpellName(122125),	-- Corrosive Resin Pool
			SpellName(121885), 	-- Amber Prison

			-- Amber-Shaper Un'sok
			SpellName(121949),	-- Parasitic Growth

			-----------------------------------------------------------------
			-- Terrace of Endless Spring
			-----------------------------------------------------------------
			-- Protectors of the Endless
			SpellName(117436),	-- Lightning Prison
			SpellName(118091),	-- Defiled Ground
			SpellName(117519),	-- Touch of Sha

			-- Tsulong
			SpellName(122752),	-- Shadow Breath
			SpellName(123011),	-- Terrorize
			SpellName(116161),	-- Crossed Over

			-- Lei Shi
			SpellName(123121),	-- Spray

			-- Sha of Fear
			SpellName(119985),	-- Dread Spray
			SpellName(119086),	-- Penetrating Bolt
			SpellName(119775),	-- Reaching Attack


			-----------------------------------------------------------------
			-- Throne of Thunder
			-----------------------------------------------------------------
			--Trash
			SpellName(138349), -- Static Wound
			SpellName(137371), -- Thundering Throw

			--Horridon
			SpellName(136767), --Triple Puncture

			--Council of Elders
			SpellName(137641), --Soul Fragment
			SpellName(137359), --Shadowed Loa Spirit Fixate
			SpellName(137972), --Twisted Fate

			--Tortos
			SpellName(136753), --Slashing Talons
			SpellName(137633), --Crystal Shell

			--Megaera
			SpellName(137731), --Ignite Flesh

			--Ji-Kun
			SpellName(138309), --Slimed

			--Durumu the Forgotten
			SpellName(133767), --Serious Wound
			SpellName(133768), --Arterial Cut

			--Primordius
			SpellName(136050), --Malformed Blood

			--Dark Animus
			SpellName(138569), --Explosive Slam

			--Iron Qon
			SpellName(134691), --Impale

			--Twin Consorts
			SpellName(137440), --Icy Shadows
			SpellName(137408), --Fan of Flames
			SpellName(137360), --Corrupted Healing

			--Lei Shen
			SpellName(135000), --Decapitate

			-----------------------------------------------------------------
			-- Siege of Orgrimmar
			-----------------------------------------------------------------
			-- Immerseus
			SpellName(143436),	-- Corrosive Blast
			SpellName(143459),	-- Sha Residue

			-- The Fallen Protectors
			SpellName(143198),	-- Garrote
			SpellName(143434),	-- Shadow Word: Bane
			SpellName(147383),	-- Debilitation

			-- Norushen
			SpellName(146124),	-- Self Doubt
			SpellName(144514),	-- Lingering Corruption

			-- Sha of Pride
			SpellName(144358),	-- Wounded Pride
			SpellName(144351),	-- Mark of Arrogance
			SpellName(146594),	-- Gift of the Titans
			SpellName(147207),	-- Weakened Resolve

			-- Galakras
			SpellName(146765),	-- Flame Arrows
			SpellName(146902),	-- Poison-Tipped Blades

			-- Iron Juggernaut
			SpellName(144467),	-- Ignite Armor
			SpellName(144459),	-- Laser Burn

			-- Kor'kron Dark Shaman
			SpellName(144215),	-- Froststorm Strike
			SpellName(144089),	-- Toxic Mist
			SpellName(144330),	-- Iron Prison

			-- General Nazgrim
			SpellName(143494),	-- Sundering Blow
			SpellName(143638),	-- Bonecracker
			SpellName(143431),	-- Magistrike

			-- Malkorok
			SpellName(142990),	-- Fatal Strike
			SpellName(142913),	-- Displaced Energy

			-- Spoils of Pandaria
			SpellName(145218),	-- Harden Flesh
			SpellName(146235),	-- Breath of Fire

			-- Thok the Bloodthirsty
			SpellName(143766),	-- Panic
			SpellName(143780),	-- Acid Breath
			SpellName(143773),	-- Freezing Breath
			SpellName(143800),	-- Icy Blood
			SpellName(143767),	-- Scorching Breath
			SpellName(143791),	-- Corrosive Blood

			-- Siegecrafter Blackfuse
			SpellName(143385),	-- Electrostatic Charge
			SpellName(144236),	-- Pattern Recognition

			-- Paragons of the Klaxxi
			SpellName(142929),	-- Tenderizing Strikes
			SpellName(143275),	-- Hewn
			SpellName(143279),	-- Genetic Alteration
			SpellName(143974),	-- Shield Bash
			SpellName(142948),	-- Aim

			-- Garrosh Hellscream
			SpellName(145183),	-- Gripping Despair
			SpellName(145195),	-- Empowered Gripping Despair
		}

		D.ReverseTimer = {

		},

		RaidDebuff:RegisterDebuffs(DuffedUIUnitFrames.DebuffIDs)
	end
end

function DuffedUIUnitFrames:UpdateBossAltPower(minimum, current, maximum)
	if (not current) or (not maximum) then return end
	
	local r, g, b = D.ColorGradient(current, maximum, 0, .8 ,0 ,.8 ,.8 ,0 ,.8 ,0 ,0)
	self:SetStatusBarColor(r, g, b)
end

function DuffedUIUnitFrames:Update()
	for _, element in ipairs(self.__elements) do
		element(self, "UpdateElement", self.unit)
	end
end

function DuffedUIUnitFrames:GetPartyFramesAttributes()
	local Offset = -46
	if not C["party"].BuffsEnable then Offset = -13 end
	
	return
	"DuffedUIParty",
	nil,
	"custom [@raid6,exists] hide;show", 
	"oUF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"initial-width", D.Scale(162),
	"initial-height", D.Scale(24),
	"showSolo", false, -- uncomment this for coding
	"showParty", true, 
	"showPlayer", true, 
	"showRaid", true,
	"groupFilter", "1,2,3,4,5,6,7,8", 
	"groupingOrder", "1,2,3,4,5,6,7,8", 
	"groupBy", "GROUP", 
	"yOffset", Offset	
end

function DuffedUIUnitFrames:GetRaidFramesAttributes()
	local Properties = C["party"].Enable and "custom [@raid6,exists] show;hide" or "solo, party, raid"
	local pointG = "LEFT"
	local capG = "BOTTOM"
	if C["raid"].GridVertical then
		pointG = "BOTTOM"
		capG = "LEFT"
	end
	
	return
	"DuffedUIRaid", 
	nil, 
	Properties,
	"oUF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"initial-width", D.Scale(C["raid"].FrameWidth * C["raid"].GridScale),
	"initial-height", D.Scale(C["raid"].FrameHeight * C["raid"].GridScale),
	"showParty", false,
	"showRaid", true,
	"showPlayer", true,
	"showSolo", false,
	"xoffset", D.Scale(8),
	"yOffset", D.Scale(1),
	"groupFilter", "1,2,3,4,5,6,7,8",
	"groupingOrder", "1,2,3,4,5,6,7,8",
	"groupBy", "GROUP",
	"maxColumns", 8,
	"unitsPerColumn", 5,
	"columnSpacing", D.Scale(C["raid"].ColumnSpacing),
	"point", pointG,
	"columnAnchorPoint", capG
end

function DuffedUIUnitFrames:GetPetRaidFramesAttributes()
	local pointG = "LEFT"
	local capG = "BOTTOM"
	if C["raid"].GridVertical then
		pointG = "BOTTOM"
		capG = "LEFT"
	end

	return
	"DuffedUIRaidPet", 
	"SecureGroupPetHeaderTemplate", 
	"custom [@raid6,exists] show;hide",
	"showPlayer", true,
	"showParty", false,
	"showRaid", true,
	"showSolo", false,
	"maxColumns", 8,
	"point", pointG,
	"unitsPerColumn", 5,
	"columnSpacing", D.Scale(C["raid"].ColumnSpacing),
	"columnAnchorPoint", capG,
	"yOffset", D.Scale(8),
	"xOffset", D.Scale(1),
	"initial-width", D.Scale(C["raid"].FrameWidth),
	"initial-height", D.Scale(C["raid"].FrameHeight),
	"oUF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]]
end

function DuffedUIUnitFrames:Style(unit)
	if (not unit) then
		return
	end
	
	local Parent = self:GetParent():GetName()

	if (unit == "player") then
		DuffedUIUnitFrames.Player(self)
	elseif (unit == "target") then
		DuffedUIUnitFrames.Target(self)
	elseif (unit == "targettarget") then
		DuffedUIUnitFrames.TargetOfTarget(self)
	elseif (unit == "pet") then
		DuffedUIUnitFrames.Pet(self)
	elseif (unit == "focus") then
		DuffedUIUnitFrames.Focus(self)
	elseif (unit == "focustarget") then
		DuffedUIUnitFrames.FocusTarget(self)
	elseif (unit:find("arena%d")) then
		DuffedUIUnitFrames.Arena(self)
	elseif (unit:find("boss%d")) then
		DuffedUIUnitFrames.Boss(self)
	elseif (unit:find("raid") or unit:find("raidpet")) then
		if Parent:match("Party") then
			DuffedUIUnitFrames.Party(self)
		else
			DuffedUIUnitFrames.Raid(self)
		end
	end

	return self
end

function DuffedUIUnitFrames:CreateUnits()
	local Player = oUF:Spawn("player")
	Player:SetPoint("BOTTOM", UIParent, -300, 250)
	Player:SetParent(Panels.PetBattleHider)
	Player:Size(217, 43)

	local Target = oUF:Spawn("target")
	Target:SetPoint("BOTTOM", UIParent, 300, 250)
	Target:SetParent(Panels.PetBattleHider)
	Target:Size(217, 43)

	local TargetOfTarget = oUF:Spawn("targettarget")
	TargetOfTarget:SetParent(Panels.PetBattleHider)
	if (Layout == 1) then
		TargetOfTarget:SetPoint("TOPRIGHT", Target, "BOTTOMRIGHT", 0, -7)
		TargetOfTarget:Size(129, 36)
	elseif (Layout == 2) then
		TargetOfTarget:SetPoint("TOPLEFT", Target, "BOTTOMLEFT", 0, -16)
		TargetOfTarget:Size(144, 16)
	elseif (Layout == 3) then
		TargetOfTarget:SetPoint("TOPRIGHT", Target, "BOTTOMLEFT", 0, -2)
		TargetOfTarget:Size(129, 36)
	end

	local Pet = oUF:Spawn("pet")
	Pet:SetParent(Panels.PetBattleHider)
	if (Layout == 1) then
		Pet:SetPoint("TOPLEFT", Player, "BOTTOMLEFT", 0, -7)
		Pet:Size(129, 36)
	elseif (Layout == 2) then
		Pet:SetPoint("TOPRIGHT", Player, "BOTTOMRIGHT", 0, -16)
		Pet:Size(144, 16)
	elseif (Layout == 3) then
		Pet:SetPoint("TOPLEFT", Player, "BOTTOMRIGHT", 0, -2)
		Pet:Size(129, 36)
	end

	local Focus = oUF:Spawn("focus")
	Focus:SetPoint("RIGHT", UIParent, -450, 0)
	Focus:SetParent(Panels.PetBattleHider)
	Focus:Size(200, 29)

	local FocusTarget = oUF:Spawn("focustarget")
	FocusTarget:SetPoint("TOPRIGHT", Focus, "BOTTOMLEFT", 0, -2)
	FocusTarget:SetParent(Panels.PetBattleHider)
	FocusTarget:Size(75, 10)
	
	local Arena = {}

	for i = 1, 5 do
		Arena[i] = oUF:Spawn("arena"..i, nil)
		Arena[i]:SetParent(Panels.PetBattleHider)
		if (i == 1) then
			Arena[i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -200, 300)
		else
			Arena[i]:SetPoint("BOTTOM", Arena[i - 1], "TOP", 0, 35)
		end
		Arena[i]:Size(200, 29)
	end
	
	local Boss = {}
	
	for i = 1, BossFrames do
		Boss[i] = oUF:Spawn("boss"..i, nil)
		Boss[i]:SetParent(Panels.PetBattleHider)
		if (i == 1) then
			Boss[i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -200, 300)
		else
			Boss[i]:SetPoint("BOTTOM", Boss[i - 1], "TOP", 0, 35)             
		end
		Boss[i]:Size(200, 29)
	end

	DuffedUIUnitFrames.Units.Player = Player
	DuffedUIUnitFrames.Units.Target = Target
	DuffedUIUnitFrames.Units.TargetOfTarget = TargetOfTarget
	DuffedUIUnitFrames.Units.Pet = Pet
	DuffedUIUnitFrames.Units.Focus = Focus
	DuffedUIUnitFrames.Units.FocusTarget = FocusTarget
	DuffedUIUnitFrames.Units.Arena = Arena
	DuffedUIUnitFrames.Units.Boss = Boss
	
	if C["party"].Enable then
		local Party = oUF:SpawnHeader(DuffedUIUnitFrames:GetPartyFramesAttributes())
		Party:SetParent(Panels.PetBattleHider)
		Party:Point("TOPLEFT", UIParent, "TOPLEFT", 30, -(D.ScreenHeight / 4))
		
		DuffedUIUnitFrames.Headers.Party = Party
	end
	
	if C["raid"].Enable then
		local Raid = oUF:SpawnHeader(DuffedUIUnitFrames:GetRaidFramesAttributes())
		Raid:SetParent(Panels.PetBattleHider)
		if C["chat"].lBackground then
			Raid:Point("BOTTOMLEFT", Panels.LeftChatBackground, "TOPLEFT", 2, 0)
		else
			Raid:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 2, 23)
		end

		if C["raid"].RaidPets then
			local Pet = oUF:SpawnHeader(DuffedUIUnitFrames:GetPetRaidFramesAttributes())
			Pet:SetParent(Panels.PetBattleHider)
			Pet:Point("TOPLEFT", Raid, "TOPRIGHT", 3, 0)
		end
		
		DuffedUIUnitFrames.Headers.Raid = Raid
		DuffedUIUnitFrames.Headers.RaidPet = Pet
	end
end

DuffedUIUnitFrames:RegisterEvent("ADDON_LOADED")
DuffedUIUnitFrames:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then
		return
	end

	oUF:RegisterStyle("DuffedUI", DuffedUIUnitFrames.Style)
	self:DisableBlizzard()
	self:CreateUnits()
end)

D["UnitFrames"] = DuffedUIUnitFrames