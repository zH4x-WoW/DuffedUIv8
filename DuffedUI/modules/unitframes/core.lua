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

DuffedUIUnitFrames.Units = {}
DuffedUIUnitFrames.Headers = {}
DuffedUIUnitFrames.Framework = DuffedUIUnitFrameFramework
DuffedUIUnitFrames.Backdrop = {
	bgFile = C["medias"].Blank,
	insets = {top = -D.Mult, left = -D.Mult, bottom = -D.Mult, right = -D.Mult},
}

local AnchorFrameRessources = CreateFrame("Frame", "AnchorFrameRessources", UIParent)
AnchorFrameRessources:Size(100, 15)
AnchorFrameRessources:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
AnchorFrameRessources:SetFrameStrata("TOOLTIP")
AnchorFrameRessources:SetFrameLevel(20)
AnchorFrameRessources:SetTemplate("Default")
AnchorFrameRessources:SetBackdropColor(0, 0, 0)
AnchorFrameRessources:SetBackdropBorderColor(1, 0, 0)
AnchorFrameRessources.Text = D.SetFontString(AnchorFrameRessources, C["medias"].Font, 12)
AnchorFrameRessources.Text:SetText(L.Movers.Ressources)
AnchorFrameRessources.Text:SetPoint("CENTER")
AnchorFrameRessources:SetMovable(true)
AnchorFrameRessources:SetUserPlaced(true)
AnchorFrameRessources:SetClampedToScreen(true)
AnchorFrameRessources:Hide()
--tinsert(D.AllowFrameMoving, AnchorFrameRessources)

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

function DuffedUIUnitFrames:UpdateNamePosition()
	if (self.Power.Value:GetText() and UnitIsEnemy("player", "target")) then
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", self.Panel, "CENTER", 0, 0)
	else
		self.Name:ClearAllPoints()
		self.Name:SetPoint("TOPLEFT", self.Health, "TOPLEFT", 4, 17)
	end
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

		if (min ~= max) then
			r, g, b = D.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit == "target" or (unit and strfind(unit, "boss%d"))) then
				self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", DuffedUIUnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and strfind(unit, "arena%d")) or (unit == "focus") or (unit == "focustarget") then
				self.Value:SetText("|cff559655"..DuffedUIUnitFrames.ShortValue(min).."|r")
			else
				self.Value:SetText("|cff559655-"..DuffedUIUnitFrames.ShortValue(max-min).."|r")
			end
		else
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetText("|cff559655"..max.."|r")
			elseif (unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText("|cff559655"..DuffedUIUnitFrames.ShortValue(max).."|r")
			else
				self.Value:SetText(" ")
			end
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

	if (Parent.Name and unit == "target") then
		DuffedUIUnitFrames.UpdateNamePosition(Parent)
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
	button.Remaining:Point("CENTER", 1, 0)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse()
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetInside()

	button.icon:SetInside()
	button.icon:SetTexCoord(unpack(D.IconCoord))
	button.icon:SetDrawLayer('ARTWORK')

	button.count:Point("BOTTOMRIGHT", 3, 3)
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
				button:SetBackdropBorderColor(unpack(C["medias"].BorderColor))
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
	return
	"DuffedUIParty",
	nil,
	"custom [@raid6,exists] hide;show", 
	"oUF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"initial-width", C["party"].Portrait and D.Scale(162) or D.Scale(206),
	"initial-height", C["party"].Portrait and D.Scale(24) or D.Scale(40),
	"showSolo", true, -- uncomment this for coding
	"showParty", true, 
	"showPlayer", true, 
	"showRaid", true,
	"groupFilter", "1,2,3,4,5,6,7,8", 
	"groupingOrder", "1,2,3,4,5,6,7,8", 
	"groupBy", "GROUP", 
	"yOffset", D.Scale(-66)	
end

function DuffedUIUnitFrames:GetRaidFramesAttributes()
	local Properties = C["party"].Enable and "custom [@raid6,exists] hide;show" or "solo, party, raid"
	
	return
	"DuffedUIRaid", 
	nil, 
	Properties,
	"oUF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"initial-width", D.Scale(66),
	"initial-height", D.Scale(50),
	"showParty", false,
	"showRaid", true,
	"showPlayer", true,
	"showSolo", false,
	"xoffset", D.Scale(3),
	"yOffset", D.Scale(-3),
	"point", "TOP",
	"groupFilter", "1,2,3,4,5,6,7,8",
	"groupingOrder", "1,2,3,4,5,6,7,8",
	"groupBy", "GROUP",
	"maxColumns", math.ceil(40/10),
	"unitsPerColumn", 10,
	"columnSpacing", D.Scale(3),
	"columnAnchorPoint", "LEFT"
end

function DuffedUIUnitFrames:GetPetRaidFramesAttributes()
	return
	"DuffedUIRaidPet", 
	"SecureGroupPetHeaderTemplate", 
	"custom [@raid6,exists] show;hide",
	"showPlayer", true,
	"showParty", false,
	"showRaid", true,
	"showSolo", false,
	"maxColumns", math.ceil(40/10),
	"point", "TOP",
	"unitsPerColumn", 10,
	"columnSpacing", D.Scale(4),
	"columnAnchorPoint", "LEFT",
	"yOffset", D.Scale(-4),
	"xOffset", D.Scale(4),
	"initial-width", D.Scale(66),
	"initial-height", D.Scale(50),
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
	elseif (unit:find("raid") or (unit:find("raidpet")) then
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
	Player:SetPoint("BOTTOM", UIParent, -350, 250)
	Player:SetParent(Panels.PetBattleHider)
	Player:Size(217, 43)

	local Target = oUF:Spawn("target")
	Target:SetPoint("BOTTOM", UIParent, 350, 250)
	Target:SetParent(Panels.PetBattleHider)
	Target:Size(217, 43)

	local TargetOfTarget = oUF:Spawn("targettarget")
	TargetOfTarget:SetPoint("TOPRIGHT", Target, "BOTTOMRIGHT", 0, -7)
	TargetOfTarget:SetParent(Panels.PetBattleHider)
	TargetOfTarget:Size(129, 36)

	local Pet = oUF:Spawn("pet")
	Pet:SetParent(Panels.PetBattleHider)
	Pet:SetPoint("TOPLEFT", Player, "BOTTOMLEFT", 0, -7)
	Pet:Size(129, 36)

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
			Arena[i]:SetPoint("BOTTOM", Arena[i-1], "TOP", 0, 35)
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
			Boss[i]:SetPoint("BOTTOM", Boss[i-1], "TOP", 0, 35)             
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
		local Gap = C["party"].Portrait and 74 or 30
		
		local Party = oUF:SpawnHeader(DuffedUIUnitFrames:GetPartyFramesAttributes())
		Party:SetParent(Panels.PetBattleHider)
		Party:Point("TOPLEFT", UIParent, "TOPLEFT", Gap, -(D.ScreenHeight / 4))
		
		DuffedUIUnitFrames.Headers.Party = Party
	end
	
	if C["raid"].Enable then
		local Raid = oUF:SpawnHeader(DuffedUIUnitFrames:GetRaidFramesAttributes())
		Raid:SetParent(Panels.PetBattleHider)
		Raid:Point("TOPLEFT", UIParent, "TOPLEFT", 18, -(D.ScreenHeight / 9))

		local Pet = oUF:SpawnHeader(DuffedUIUnitFrames:GetPetRaidFramesAttributes())
		Pet:SetParent(Panels.PetBattleHider)
		Pet:Point("TOPLEFT", Raid, "TOPRIGHT", 3, 0)
		
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