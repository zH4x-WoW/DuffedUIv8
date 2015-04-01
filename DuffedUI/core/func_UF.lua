local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF
oUFDuffedUI = ns.oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

D.updateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do v(frame, "UpdateElement", frame.unit) end
end

local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

local Flash = function(self, duration)
	if not self.anim then SetUpAnimGroup(self) end

	self.anim.fadein:SetDuration(duration)
	self.anim.fadeout:SetDuration(duration)
	self.anim:Play()
end

local StopFlash = function(self) 
	if self.anim then self.anim:Finish() end
end

local dropdown = CreateFrame("Frame", "oUF_DuffedUIDropDown", UIParent, "UIDropDownMenuTemplate")

D.SpawnMenu = function(self)
	dropdown:SetParent(self)
	return ToggleDropDownMenu(nil, nil, dropdown, "cursor", 0, 0)
end

local initdropdown = function(self)
	local unit = self:GetParent().unit
	local menu, name, id

	if(not unit) then return end
	if(UnitIsPlayer(unit)) then
		id = UnitInRaid(unit)
		if(id) then
			menu = "RAID_PLAYER"
			name = GetRaidRosterInfo(id)
		elseif(UnitInParty(unit)) then
			menu = "PARTY"
		end
	end
	if(menu) then UnitPopup_ShowMenu(self, menu, unit, name, id) end
end

UIDropDownMenu_Initialize(dropdown, initdropdown, "MENU")
UnitPopupMenus["PARTY"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" }
UnitPopupMenus["RAID_PLAYER"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" }
UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "MOVE_PLAYER_FRAME", "MOVE_TARGET_FRAME", "REPORT_PLAYER", "CANCEL" }

--[[Healthupdate for UFs]]--
D.PostUpdateHealth = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["offline"] .. "|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["dead"] .. "|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["ghost"] .. "|r")
		end
	else
		local r, g, b

		if C["unitframes"].ColorGradient == true and C["unitframes"].unicolor == true then
			local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			health:SetStatusBarColor(r, g, b)
		end

		if (C["unitframes"].unicolor ~= true and unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (C["unitframes"].unicolor ~= true and unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local c = D.UnitColor.reaction[UnitReaction(unit, "player")]
			if c then 
				r, g, b = c[1], c[2], c[3]
				health:SetStatusBarColor(r, g, b)
			else
				r, g, b = 75/255,  175/255, 76/255
				health:SetStatusBarColor(r, g, b)
			end
		end

		if min ~= max then
			local r, g, b
			r, g, b = oUF.ColorGradient(min, max, .69, .31, .31, .65, .63, .35, .33, .59, .33) 
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", D.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif unit == "target" or (unit and unit:find("boss%d")) then
				health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", D.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and unit:find("boss%d")) then
				health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", D.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
				health.value:SetText("|cff559655" .. D.ShortValue(min) .. "|r")
			else
				health.value:SetText("|cff559655-" .. D.ShortValue(max-min) .. "|r")
			end
		else
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				health.value:SetText("|cff559655" .. D.ShortValue(max) .. "|r")
			elseif unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and unit:find("arena%d")) then
				health.value:SetText("|cff559655" .. D.ShortValue(max) .. "|r")
			elseif (unit and unit:find("boss%d")) then
				health.value:SetText("")
			else
				health.value:SetText("")
			end
		end
	end
end

--[[Healthupdate for Raidframes]]--
D["PostUpdateHealthRaid"] = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["offline"] .. "|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["dead"] .. "|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5" .. L["uf"]["ghost"] .. "|r")
		end
	else
		if C["unitframes"]["ColorGradient"] and C["unitframes"]["unicolor"] then
			local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			health:SetStatusBarColor(r, g, b)
		end

		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"]["unicolor"] ~= true then
			local c = D.UnitColor.reaction[5]
			local r, g, b = c[1], c[2], c[3]
			health:SetStatusBarColor(r, g, b)
			health.bg:SetTexture(.1, .1, .1)
		end

		if min ~= max then health.value:SetText("|cff559655-" .. D["ShortValue"](max-min) .. "|r") else health.value:SetText("") end
	end
end

D.PostUpdatePetColor = function(health, unit, min, max)
	if C["unitframes"].ColorGradient == true and C["unitframes"].unicolor == true then
		local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
		health:SetStatusBarColor(r, g, b)
	end

	if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"].unicolor ~= true then
		local c = D.UnitColor.reaction[5]
		local r, g, b = c[1], c[2], c[3]

		if health then health:SetStatusBarColor(r, g, b) end
		if health.bg then health.bg:SetTexture(.1, .1, .1) end
	end
end

--[[Powerupdate for UFs]]--
D.PostUpdatePower = function(power, unit, min, max)
	if not power.value then return end

	local Parent = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local colors = D.UnitColor
	local color = colors.power[pToken]

	if color then power.value:SetTextColor(color[1], color[2], color[3]) end
	if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) then
		power.value:SetText()
	elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 then
				if (unit == "target" or (unit and strfind(unit, "boss%d"))) then
					power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), D.ShortValue(max - (max - min)))
				elseif (unit == "player" and Parent:GetAttribute("normalUnit") == "pet" or unit == "pet") then
					power.value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and strfind(unit, "arena%d")) or unit == "focus" or unit == "focustarget" then
					power.value:SetText(D.ShortValue(min))
				else
					power.value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
				end
			else
				power.value:SetText(max - (max - min))
			end
		else
			if (unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and strfind(unit, "arena%d")) or (unit and strfind(unit, "boss%d"))) then power.value:SetText(D.ShortValue(min)) else power.value:SetText(min) end
		end
	end
end

--[[Timer for Buffs & Debuffs]]--
D.FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%d" .. D.PanelColor .. "d", ceil(s / day))
	elseif s >= hour then
		return format("%d" .. D.PanelColor .. "h", ceil(s / hour))
	elseif s >= minute then
		return format("%d" .. D.PanelColor .. "m", ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format("%.1f", s)
end

function updateAuraTrackerTime(self, elapsed)
	if (self.active) then
		self.timeleft = self.timeleft - elapsed

		if (self.timeleft <= 5) then self.text:SetTextColor(1, 0, 0) else self.text:SetTextColor(1, 1, 1) end
		if (self.timeleft <= 0) then
			self.icon:SetTexture("")
			self.text:SetText("")
		end
		self.text:SetFormattedText("%.1f", self.timeleft)
	end
end

local CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= .1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = D.FormatTime(self.timeLeft)
				self.remaining:SetText(time)
				if self.timeLeft <= 5 then self.remaining:SetTextColor(.99, .31, .31) else self.remaining:SetTextColor(1, 1, 1) end
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

D.PostCreateAura = function(self, button)
	button:SetTemplate("Default")

	button.remaining = D.SetFontString(button, C["media"].font, 10, "THINOUTLINE")
	button.remaining:Point("TOPLEFT", 0, -3)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true

	button.cd:SetReverse()
	button.icon:Point("TOPLEFT", 2, -2)
	button.icon:Point("BOTTOMRIGHT", -2, 2)
	button.icon:SetTexCoord(.08, .92, .08, .92)
	button.icon:SetDrawLayer('ARTWORK')

	button.count:Point("BOTTOMRIGHT", 1, 1)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C["media"].font, 9, "THINOUTLINE")
	button.count:SetTextColor(.84, .75, .65)

	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:Point("TOPLEFT", button, "TOPLEFT", 2, -2)
	button.cd:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)

	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:Point("TOPLEFT", button, "TOPLEFT", -3, 3)
	button.Glow:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)
	button.Glow:SetFrameStrata("BACKGROUND")
	button.Glow:SetBackdrop{edgeFile = C["media"].glowTex, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)

	local Animation = button:CreateAnimationGroup()
	Animation:SetLooping("BOUNCE")

	local FadeOut = Animation:CreateAnimation("Alpha")
	FadeOut:SetChange(-.9)
	FadeOut:SetDuration(.6)
	FadeOut:SetSmoothing("IN_OUT")

	button.Animation = Animation
end

D.PostUpdateAura = function(self, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)
	if icon then
		if icon.filter == "HARMFUL" then
			if not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle" then
				icon.icon:SetDesaturated(true)
				icon:SetBackdropBorderColor(unpack(C["media"].bordercolor))
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon.icon:SetDesaturated(false)
				icon:SetBackdropBorderColor(color.r * .8, color.g * .8, color.b * .8)
			end
		else
			if isStealable or ((D.Class == "MAGE" or D.Class == "PRIEST" or D.Class == "SHAMAN") and dtype == "Magic") and not UnitIsFriend("player", unit) then
				if not icon.Animation:IsPlaying() then icon.Animation:Play() end
			else
				if icon.Animation:IsPlaying() then icon.Animation:Stop() end
			end
		end

		if duration and duration > 0 then icon.remaining:Show() else icon.remaining:Hide() end

		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end
end

D.UpdateTargetDebuffsHeader = function(self)
	local numBuffs = self.visibleBuffs
	local perRow = self.numRow
	local s = self.size
	local row = math.ceil((numBuffs / perRow))
	local p = self:GetParent()
	local h = p.Debuffs
	local y = s * row
	local addition = s

	if numBuffs == 0 then addition = 0 end
	h:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -2, y + addition)
end

D.HidePortrait = function(self, unit)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then self.Portrait:SetAlpha(0) else self.Portrait:SetAlpha(1) end
	end
	self.Portrait:SetFrameLevel(4)
end

D.PortraitUpdate = function(self, unit)
	if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then self:SetCamera(1) end
end

local ticks = {}
local HideTicks = function()
	for _, tick in pairs(ticks) do tick:Hide() end
end

local SetCastTicks = function(frame, numTicks)
	HideTicks()
	if numTicks and numTicks > 0  then
		local d = frame:GetWidth() / numTicks
		for i = 1, numTicks do
			if not ticks[i] then
				ticks[i] = frame:CreateTexture(nil, "OVERLAY")
				ticks[i]:SetTexture( C["media"].normTex)

				if C["castbar"].classcolor == true then ticks[i]:SetVertexColor(0, 0, 0) else ticks[i]:SetVertexColor(.84, .75, .65) end
				ticks[i]:SetWidth(2)
				ticks[i]:SetHeight(frame:GetHeight())
			end
			ticks[i]:ClearAllPoints()
			ticks[i]:SetPoint("CENTER", frame, "LEFT", d * i, 0)
			ticks[i]:Show()
		end
	end
end

D.CustomCastTime = function(self, duration) self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max)) end

D.CustomCastDelayText = function(self, duration) self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay)) end

D.CastBar = function(self, unit, name, rank, castid)
	if self.interrupt and unit ~= "player" then
		if UnitCanAttack("player", unit) then self:SetStatusBarColor(1, 0, 0, .5) else self:SetStatusBarColor(1, 0, 0, .5) end
	else
		if C["castbar"].classcolor then self:SetStatusBarColor(unpack(D.UnitColor.class[D.Class])) else self:SetStatusBarColor(unpack(C["castbar"].color)) end
	end

	local color
	self.unit = unit

	if C["castbar"].cbticks == true and unit == "player" then
		local baseTicks = D.ChannelTicks[name]
		if baseTicks and D.HasteTicks[name] then
			local tickIncRate = 1 / baseTicks
			local curHaste = UnitSpellHaste("player") * .01
			local firstTickInc = tickIncRate / 2
			local bonusTicks = 0
			if curHaste >= firstTickInc then bonusTicks = bonusTicks + 1 end

			local x = tonumber(D.Round(firstTickInc + tickIncRate, 2))
			while curHaste >= x do
				x = tonumber(D.Round(firstTickInc + (tickIncRate * bonusTicks), 2))
				if curHaste >= x then bonusTicks = bonusTicks + 1 end
			end

			SetCastTicks(self, baseTicks + bonusTicks)
		elseif baseTicks then
			SetCastTicks(self, baseTicks)
		else
			HideTicks()
		end
	elseif unit == "player" then
		HideTicks()
	end
end

D["EclipseDirection"] = function(self)
	local power = UnitPower("player", SPELL_POWER_ECLIPSE)

	if power < 0 then
		self.Text:SetText("|cffE5994C" .. L["uf"]["starfire"] .. "|r")
	elseif power > 0 then
		self.Text:SetText("|cff4478BC" .. L["uf"]["wrath"] .. "|r")
	else
		self.Text:SetText("")
	end
end

D.MLAnchorUpdate = function (self)
	if self.Leader:IsShown() then self.MasterLooter:SetPoint("TOPLEFT", 14, 8) else self.MasterLooter:SetPoint("TOPLEFT", 0, 8) end
end

local UpdateManaLevelDelay = 0
D.UpdateManaLevel = function(self, elapsed)
	UpdateManaLevelDelay = UpdateManaLevelDelay + elapsed
	if self.parent.unit ~= "player" or UpdateManaLevelDelay < .2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	UpdateManaLevelDelay = 0

	local mana = UnitMana("player")
	local maxmana = UnitManaMax("player")

	if maxmana == 0 then return end

	local percMana = mana / maxmana * 100

	if percMana == 20 then
		self.ManaLevel:SetText("|cffaf5050" .. L["uf"]["lowmana"] .. "|r")
		Flash(self, .3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

D.UpdateThreat = function(self, event, unit)
	if (self.unit ~= unit) or (unit == "target" or unit == "pet" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
	local threat = UnitThreatSituation(self.unit)
	if (threat == 3) then
		if self.panel then self.panel:SetBackdropBorderColor(.69, .31, .31, 1) else self.Name:SetTextColor(1,.1, .1) end
	else
		if self.panel then
			local r, g, b = unpack(C["media"].bordercolor)
			self.panel:SetBackdropBorderColor(r * .7, g * .7, b * .7)
		else
			self.Name:SetTextColor(1, 1, 1)
		end
	end 
end

D.SetGridGroupRole = function(self, role)
	local lfdrole = self.LFDRole
	local role = UnitGroupRolesAssigned(self.unit)

	if role == "TANK" then
		lfdrole:SetTexture(C["media"].tank)
		lfdrole:Show()
	elseif role == "HEALER" then
		lfdrole:SetTexture(C["media"].heal)
		lfdrole:Show()
	elseif role == "DAMAGER" then
		lfdrole:SetTexture(C["media"].dps)
		lfdrole:Show()
	else
		lfdrole:Hide()
	end
end

-- Grid
D.countOffsets = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

D.createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.displayText = true
	auras.icons = {}
	auras.PostCreateIcon = function(self, icon)
		if icon.icon and not icon.hideIcon then
			icon:SetTemplate()
			icon.icon:Point("TOPLEFT", 1, -1)
			icon.icon:Point("BOTTOMRIGHT", -1, 1)
			icon.icon:SetTexCoord(.08, .92, .08, .92)
			icon.icon:SetDrawLayer("ARTWORK")
		end
		if icon.cd then icon.cd:SetReverse() end
		if icon.overlay then icon.overlay:SetTexture() end
	end

	local buffs = {}

	if D.buffids["ALL"] then
		for key, value in pairs(D.buffids["ALL"]) do tinsert(buffs, value) end
	end
	if (D.buffids[D.Class]) then
		for key, value in pairs(D.buffids[D.Class]) do tinsert(buffs, value) end
	end

	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[5]
			icon:Width(6)
			icon:Height(6)
			icon:SetPoint(spell[2], unpack(spell[3]))

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(C["media"].blank)
			if (spell[4]) then tex:SetVertexColor(unpack(spell[4])) else tex:SetVertexColor(.8, .8, .8) end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(C["media"].font, 8, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(D.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	self.AuraWatch = auras
end

--[[Raidbuffs & -debuffs]]--
if C["raid"].raidunitdebuffwatch == true then
	do
		D.buffids = {
			PRIEST = {
				{6788, "TOPRIGHT", {0, 0}, {1, 0, 0}, true}, -- Weakened Soul
				{33076, "BOTTOMRIGHT", {0, 0}, {.2, .7, .2}}, -- Prayer of Mending
				{139, "BOTTOMLEFT", {0, 0}, {.4, .7, .2}}, -- Renew
				{17, "TOPLEFT", {0, 0}, {.81, .85, .1}, true}, -- Power Word: Shield
			},
			DRUID = {
				{774, "TOPLEFT", {0, 0}, {.8, .4, .8}}, -- Rejuvenation
				{162359, "TOPLEFT", {0, 0}, {.1, .3, .8}}, -- Genesis
				{155777, "TOPLEFT", {0, -8}, {.3, .3, .8}}, -- Germination
				{8936, "TOPRIGHT", {0, 0}, {.2, .8, .2}}, -- Regrowth
				{33763, "BOTTOMLEFT", {0, 0}, {.4, .8, .2}}, -- Lifebloom
				{48438, "BOTTOMRIGHT", {0, 0}, {.8, .4, 0}}, -- Wild Growth
			},
			PALADIN = {
				{53563, "TOPRIGHT", {0, 0}, {.7, .3, .7}}, -- Beacon of Light
				{1022, "BOTTOMRIGHT", {0, 0}, {.2, .2, 1}, true}, -- Hand of Protection
				{1044, "BOTTOMRIGHT", {0, 0}, {.89, .45, 0}, true}, -- Hand of Freedom
				{1038, "BOTTOMRIGHT", {0, 0}, {.93, .75, 0}, true}, -- Hand of Salvation
				{6940, "BOTTOMRIGHT", {0, 0}, {.89, .1, .1}, true}, -- Hand of Sacrifice
				{114163, "BOTTOMLEFT", {0, 0}, {.89, .1, .1}, true}, -- Eternal Flame
				{20925, "TOPLEFT", {0, 0}, {.81, .85, .1}, true}, -- Sacred Shield
			},
			SHAMAN = {
				{61295, "TOPLEFT", {0, 0}, {.7, .3, .7}}, -- Riptide 
				{974, "BOTTOMRIGHT", {0, 0}, {.7, .4, 0}}, -- Earth Shield
			},
			MONK = {
				{119611, "TOPLEFT", {0, 0}, {.8, .4, .8}}, --Renewing Mist
				{116849, "TOPRIGHT", {0, 0}, {.2, .8, .2}}, -- Life Cocoon
				{124682, "BOTTOMLEFT", {0, 0}, {.4, .8, .2}}, -- Enveloping Mist
				{124081, "BOTTOMRIGHT", {0, 0}, {.7, .4, 0}}, -- Zen Sphere
			},
			ALL = {
				{14253, "RIGHT", {0, 0}, {0, 1, 0}}, -- Abolish Poison
			},
		}
	end

	do
		local ORD = oUF_RaidDebuffs
		if not ORD then return end

		ORD.ShowDispelableDebuff = true
		ORD.FilterDispellableDebuff = true
		ORD.MatchBySpellName = true
		ORD.DeepCorruption = true

		local function SpellName(id)
			local name = select(1, GetSpellInfo(id))
			return name	
		end

		D.debuffids = {
			-- WoD-Debuffs
			-- Highmaul
			-- The Butcher
			SpellName(156152), -- Gushing Wounds
			-- Kargath Bladefist
			SpellName(159178), -- Open Wounds
			SpellName(159113), -- Impale
			-- Pol & Phemos
			SpellName(155569), -- Injured
			SpellName(167200), -- Arcane Wound
			SpellName(163374), -- Arcane Volatility
			-- Ko'ragh
			SpellName(161242), -- Caustic Energy
			SpellName(163472), -- Dominating Power
			-- Imperator Mar'gok
			SpellName(156238), -- Arcane Wrath
			SpellName(156467), -- Destructive Resonance
			SpellName(158605), -- Mark of Chaos
			SpellName(163988), -- Arcane Wrath: Displacement
			SpellName(164075), -- Destructive Resonance: Displacement
			SpellName(164176), -- Mark of Chaos: Displacement
			SpellName(163989), -- Arcane Wrath: Fortification
			SpellName(164076), -- Destructive Resonance: Fortification
			SpellName(164178), -- Mark of Chaos: Fortification
			SpellName(163990), -- Arcane Wrath: Replication
			SpellName(164077), -- Destructive Resonance: Replication
			SpellName(164191), -- Mark of Chaos: Replication
			-- Blackrock Foundry
			-- Blackhand
			SpellName(156096), -- Marked for Death
			SpellName(156107), -- Impaling Throw
			SpellName(156047), -- Slagged
			SpellName(157000), -- Attach Slag Bombs
			-- Beastlord Darmac
			SpellName(155365), -- Pin Down
			SpellName(155061), -- Rend and Tear
			SpellName(155399), -- Conflagration
			SpellName(155236), -- Crush Armor
			-- Flamebender Ka'graz
			SpellName(154952), -- Fixate
			SpellName(155049), -- Singe
			SpellName(163284), -- Rising Flames
			-- Operator Thogar
			SpellName(155921), -- Enkindle
			SpellName(165195), -- Prototype Pulse Grenade
			SpellName(155701), -- Serrated Slash
			SpellName(156310), -- Lava Shock
			-- The Blast Furnace
			SpellName(175104), -- Melt Armor
			SpellName(158702), -- Fixate
			SpellName(155240), -- Tempered
			SpellName(155242), -- Heat
			-- Franzok & Hans'gar
			SpellName(157139), -- Shattered Vertebrae
			-- Gruul
			SpellName(155080), -- Inferno Slice
			SpellName(155078), -- Overwhelming Blows
			SpellName(165300), -- Flare
			-- Kromog
			SpellName(156766), -- Warped Armor
			-- Admiral Gar'an
			SpellName(156112), -- Convulsive Shadows
			SpellName(170395), -- Sorka's Prey
			SpellName(158702), -- Fixate
			SpellName(158686), -- Expose Armor
		}
		D.ReverseTimer = {
		},
		ORD:RegisterDebuffs(D.debuffids)
	end
end

local TestUI = function(msg)
	if not DuffedUI[2].unitframes.enable then return end

	if msg == "" then 
		print("'|cffc41f3barena|r' or '|cffc41f3ba|r' to show arena frames")
		print("'|cffc41f3bboss|r' or '|cffc41f3bb|r' to show boss frames")
		print("'|cffc41f3bpet|r' or '|cffc41f3bp|r' to show pet frames")
		print("'|cffc41f3bmaintank|r' or '|cffc41f3bmt|r' to show maintank frames")
	elseif msg == "arena" or msg == "a" then
		for i = 1, 3 do
			_G["oUF_Arena"..i]:Show()
			_G["oUF_Arena"..i].Hide = function() end
			_G["oUF_Arena"..i].unit = "player"
			_G["oUF_Arena"..i].Trinket.Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_37")
		end
	elseif msg == "boss" or msg == "b" then
		for i = 1, 3 do
			_G["oUF_Boss"..i]:Show()
			_G["oUF_Boss"..i].Hide = function() end
			_G["oUF_Boss"..i].unit = "player"
		end
	elseif msg == "pet" or msg == "p" then
		oUF_Pet:Show()
		oUF_Pet.Hide = function() end
		oUF_Pet.unit = "player"
	elseif msg == "maintank" or msg == "mt" then
		oUF_MainTank:Show()
		oUF_MainTank.Hide = function() end
		oUF_MainTank.unit = "player"
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"
