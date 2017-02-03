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
	self.anim.fadein:SetFromAlpha(1)
	self.anim.fadein:SetToAlpha(0)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetFromAlpha(1)
	self.anim.fadeout:SetToAlpha(0)
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

--Healthupdate for UFs
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

--Healthupdate for Raidframes
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
			health.bg:SetColorTexture(.1, .1, .1)
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
		if health.bg then health.bg:SetColorTexture(.1, .1, .1) end
	end
end

--Powerupdate for UFs
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

D.PostUpdateAltMana = function(unit, min, max)
	local parent = self:GetParent()
	local powerText = parent.Power.value
	local powerTextParent = powerText:GetParent()

	local powerTextPosition = db.power.position

	if min ~= max then
		local color = D.UnitColor.power['MANA']
		color = D.RGBToHex(color[1], color[2], color[3])

		self.Text:SetParent(powerTextParent)

		self.Text:ClearAllPoints()
		if powerText:GetText() then
			if find(powerTextPosition, "RIGHT") then
				self.Text:Point("RIGHT", powerText, "LEFT", 3, 0)
				self.Text:SetFormattedText(color.."%d%%|r |cffD7BEA5- |r", floor(min / max * 100))
			elseif find(powerTextPosition, "LEFT") then
				self.Text:Point("LEFT", powerText, "RIGHT", -3, 0)
				self.Text:SetFormattedText("|cffD7BEA5-|r"..color.." %d%%|r", floor(min / max * 100))
			else
				if select(4, powerText:GetPoint()) <= 0 then
					self.Text:Point("LEFT", powerText, "RIGHT", -3, 0)
					self.Text:SetFormattedText("|cffD7BEA5-|r"..color.." %d%%|r", floor(min / max * 100))
				else
					self.Text:Point("RIGHT", powerText, "LEFT", 3, 0)
					self.Text:SetFormattedText(color.."%d%%|r |cffD7BEA5- |r", floor(min / max * 100))
				end
			end
		else
			self.Text:Point(powerText:GetPoint())
			self.Text:SetFormattedText(color.."%d%%|r", floor(min / max * 100))
		end
	else
		self.Text:SetText()
	end
end

--Timer for Buffs & Debuffs
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

	button.Animation = button:CreateAnimationGroup()
    button.Animation:SetLooping("BOUNCE")

    button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
    button.Animation.FadeOut:SetFromAlpha(1)
    button.Animation.FadeOut:SetToAlpha(0)
    button.Animation.FadeOut:SetDuration(.6)
    button.Animation.FadeOut:SetSmoothing("IN_OUT")
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
	--if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then self:SetCamera(1) end
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

function D.PvPUpdate(self, elapsed)
	if (self.elapsed and self.elapsed > 0.2) then
		local unit = self.unit
		local time = GetPVPTimer()

		local min = format("%01.f", floor((time / 1000) / 60))
		local sec = format("%02.f", floor((time / 1000) - min * 60))
		if self.pvptimer then
			local factionGroup = UnitFactionGroup(unit)
			if UnitIspvptimerFreeForAll(unit) then
				if time ~= 301000 and time ~= -1 then
					self.pvptimer:SetText(pvptimer.." ".."("..min..":"..sec..")")
				end
			elseif (factionGroup and UnitIspvptimer(unit)) then
				if time ~= 301000 and time ~= -1 then
					self.pvptimer:SetText(pvptimer.." ".."("..min..":"..sec..")")
				end
			else
				self.pvptimer:SetText("")
			end
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
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
D["countOffsets"] = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

D["createAuraWatch"] = function(self, unit)
	local Class = select(2, UnitClass("player"))

	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = function(self, icon)
		if icon.icon and not icon.hideIcon then
			icon:SetTemplate()
			icon.icon:Point("TOPLEFT", 1, -1)
			icon.icon:Point("BOTTOMRIGHT", -1, 1)
			icon.icon:SetTexCoord(.08, .92, .08, .92)
			icon.icon:SetDrawLayer("ARTWORK")
		end
		if (icon.cd) then
			icon.cd:SetHideCountdownNumbers(true)
			icon.cd:SetReverse(true)
		end
		if icon.overlay then icon.overlay:SetTexture() end
	end
	auras.strictMatching = true

	local buffs = {}

	if (D.Buffids["ALL"]) then
		for key, value in pairs(D.Buffids["ALL"]) do tinsert(buffs, value) end
	end

	if (D.Buffids[D.Class]) then
		for key, value in pairs(D.Buffids[D.Class]) do tinsert(buffs, value) end
	end

	-- Cornerbuffs
	if buffs then
		for key, spell in pairs(buffs) do
			local Icon = CreateFrame("Frame", nil, auras)
			Icon.spellID = spell[1]
			Icon.anyUnit = spell[4]
			Icon:Width(6)
			Icon:Height(6)
			Icon:SetPoint(spell[2], 0, 0)

			local Texture = Icon:CreateTexture(nil, "OVERLAY")
			Texture:SetAllPoints(Icon)
			Texture:SetTexture(C["media"].blank)

			if (spell[3]) then Texture:SetVertexColor(unpack(spell[3])) else Texture:SetVertexColor(0.8, 0.8, 0.8) end

			local Count = Icon:CreateFontString(nil, "OVERLAY")
			Count:SetFont(C["media"].font, 8, "THINOUTLINE")
			Count:SetPoint("CENTER", unpack(D.countOffsets[spell[2]]))
			Icon.count = Count

			auras.icons[spell[1]] = Icon
		end
	end
	self.AuraWatch = auras
end

--Raidbuffs & -debuffs
D.Buffids = {
	PRIEST = {
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}},             -- Prayer of Mending
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}},                -- Renew
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true},            -- Power Word: Shield
	},

	DRUID = {
		{774, "TOPLEFT", {0.8, 0.4, 0.8}},                   -- Rejuvenation
		{155777, "LEFT", {0.8, 0.4, 0.8}},                   -- Germination
		{8936, "TOPRIGHT", {0.2, 0.8, 0.2}},                 -- Regrowth
		{33763, "BOTTOMLEFT", {0.4, 0.8, 0.2}},              -- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}},               -- Wild Growth
	},

	PALADIN = {
		{53563, "TOPLEFT", {0.7, 0.3, 0.7}},	             -- Beacon of Light
		{156910, "TOPRIGHT", {0.7, 0.3, 0.7}},	             -- Beacon of Faith
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true}, 	     -- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true},	     -- Hand of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true},	     -- Hand of Sacrifice
		{114163, "BOTTOMLEFT", {0.81, 0.85, 0.1}, true},	 -- Eternal Flame
	},

	SHAMAN = {
		{61295, "TOPLEFT", {0.7, 0.3, 0.7}},                 -- Riptide
	},

	MONK = {
		{119611, "TOPLEFT", {0.8, 0.4, 0.8}},	             -- Renewing Mist
		{116849, "TOPRIGHT", {0.2, 0.8, 0.2}},	             -- Life Cocoon
		{124682, "BOTTOMLEFT", {0.4, 0.8, 0.2}},             -- Enveloping Mist
		{124081, "BOTTOMRIGHT", {0.7, 0.4, 0}},              -- Zen Sphere
	},

	ALL = {
		{14253, "RIGHT", {0, 1, 0}},                         -- Abolish Poison
	},
}

D.Debuffids = {
	-- Legion Debuffs
	-- The Emerald Nightmare
	-- Nythendra
	[GetSpellInfo(204504)] = 6, -- Infested
	[GetSpellInfo(205043)] = 6, -- Infested mind
	[GetSpellInfo(203096)] = 6, -- Rot
	[GetSpellInfo(204463)] = 6, -- Volatile Rot
	[GetSpellInfo(203045)] = 6, -- Infested Ground
	[GetSpellInfo(203646)] = 6, -- Burst of Corruption
	-- Elerethe Renferal
	[GetSpellInfo(210228)] = 6, -- Dripping Fangs
	[GetSpellInfo(215307)] = 6, -- Web of Pain
	[GetSpellInfo(215300)] = 6, -- Web of Pain
	[GetSpellInfo(215460)] = 6, -- Necrotic Venom
	[GetSpellInfo(213124)] = 6, -- Venomous Pool
	[GetSpellInfo(210850)] = 6, -- Twisting Shadows
	[GetSpellInfo(215489)] = 6, -- Venomous Pool
	-- Il'gynoth, Heart of the Corruption
	[GetSpellInfo(208929)] = 6, -- Spew Corruption
	[GetSpellInfo(210984)] = 6, -- Eye of Fate
	[GetSpellInfo(209469)] = 7, -- Touch of Corruption
	[GetSpellInfo(208697)] = 6, -- Mind Flay
	-- Ursoc
	[GetSpellInfo(198108)] = 6, -- Unbalanced
	[GetSpellInfo(197943)] = 6, -- Overwhelm
	[GetSpellInfo(204859)] = 6, -- Rend Flesh
	[GetSpellInfo(205611)] = 6, -- Miasma
	[GetSpellInfo(198006)] = 6, -- Focused Gaze
	[GetSpellInfo(197980)] = 6, -- Nightmarish Cacophony
	-- Dragons of Nightmare
	[GetSpellInfo(203102)] = 6, -- Mark of Ysondre
	[GetSpellInfo(203121)] = 6, -- Mark of Taerar
	[GetSpellInfo(203125)] = 6, -- Mark of Emeriss
	[GetSpellInfo(203124)] = 6, -- Mark of Lethon
	[GetSpellInfo(204731)] = 7, -- Wasting Dread
	[GetSpellInfo(203110)] = 7, -- Slumbering Nightmare
	[GetSpellInfo(207681)] = 7, -- Nightmare Bloom
	[GetSpellInfo(205341)] = 7, -- Sleeping Fog
	[GetSpellInfo(203770)] = 7, -- Defiled Vines
	[GetSpellInfo(203787)] = 7, -- Volatile Infection
	-- Cenarius
	[GetSpellInfo(210279)] = 5, -- Creeping Nightmares
	[GetSpellInfo(213162)] = 6, -- Nightmare Blast
	[GetSpellInfo(210315)] = 6, -- Nightmare Brambles
	[GetSpellInfo(212681)] = 6, -- Cleansed Ground
	[GetSpellInfo(211507)] = 6, -- Nightmare Javelin
	[GetSpellInfo(211471)] = 6, -- Scorned Touch
	[GetSpellInfo(211612)] = 6, -- Replenishing Roots
	[GetSpellInfo(216516)] = 6, -- Ancient Dream
	-- Xavius
	[GetSpellInfo(206005)] = 5, -- Dream Simulacrum
	[GetSpellInfo(206651)] = 7, -- Darkening Soul
	[GetSpellInfo(209158)] = 7, -- Blackening Soul
	[GetSpellInfo(211802)] = 6, -- Nightmare Blades
	[GetSpellInfo(206109)] = 6, -- Awakening to the Nightmare
	[GetSpellInfo(209034)] = 6, -- Bonds of Terror
	[GetSpellInfo(210451)] = 6, -- Bonds of Terror
	[GetSpellInfo(208431)] = 6, -- Corruption: Descent into Madness
	[GetSpellInfo(207409)] = 6, -- Madness
	[GetSpellInfo(211634)] = 6, -- The Infinite Dark
	[GetSpellInfo(208385)] = 6, -- Tainted Discharge
	-- Trial of Valor (By Anzor)
	-- Odyn
	[GetSpellInfo(228030)] = 6, -- Expel Light (need aura)
	[GetSpellInfo(227807)] = 6, -- Storm of Justice
	[GetSpellInfo(228918)] = 6, -- Stormforged Spear
	[GetSpellInfo(227490)] = 6, -- Branded
	[GetSpellInfo(227491)] = 6, -- Branded
	[GetSpellInfo(227498)] = 6, -- Branded
	[GetSpellInfo(227499)] = 6, -- Branded
	[GetSpellInfo(227500)] = 6, -- Branded
	[GetSpellInfo(231297)] = 6, -- Runic Brand (Mythic Only)
	-- Guarm
	[GetSpellInfo(228228)] = 5, -- Flame Lick
	[GetSpellInfo(228248)] = 7, -- Frost Lick
	[GetSpellInfo(228253)] = 6, -- Shadow Lick
	--[GetSpellInfo(228768)] = 6, -- Salty Spittle
	--[GetSpellInfo(228758)] = 6, -- Fiery Phlegm
	--[GetSpellInfo(228769)] = 6, -- Dark Discharge
	-- Helya
	[GetSpellInfo(228883)] = 6, -- Unholy Reckoning (Trash)
	[GetSpellInfo(228054)] = 7, -- Taint of the Sea
	[GetSpellInfo(229119)] = 6, -- Orb of Corruption
	[GetSpellInfo(228058)] = 6, -- Orb of Corrosion
	[GetSpellInfo(193367)] = 6, -- Fetid Rot
	[GetSpellInfo(227982)] = 6, -- Bilewater Redox
	-- The Nighthold
	--Trash
	[GetSpellInfo(224234)] = 6, -- Ill Fated
	[GetSpellInfo(225412)] = 6, -- Mass Siphon
	[GetSpellInfo(224568)] = 6, -- Mass Supress
	-- Skorpyron
	[GetSpellInfo(204766)] = 6, -- Energy Surge
	[GetSpellInfo(214718)] = 6, -- Acidic Fragments
	[GetSpellInfo(211801)] = 6, -- Volatile Fragments
	[GetSpellInfo(204284)] = 6, -- Broken Shard (Protection)
	[GetSpellInfo(204275)] = 6, -- Arcanoslash (Tank)
	[GetSpellInfo(211659)] = 6, -- Arcane Tether (Tank debuff)
	[GetSpellInfo(204483)] = 6, -- Focused Blast (Stun)
	-- Chronomatic Anomaly
	[GetSpellInfo(206607)] = 6, -- Chronometric Particles (Tank stack debuff)
	[GetSpellInfo(206609)] = 6, -- Time Release (Heal buff/debuff)
	[GetSpellInfo(205653)] = 6, -- Passage of Time
	[GetSpellInfo(206617)] = 6, -- Time Bomb
	[GetSpellInfo(206618)] = 6, -- Time Bomb
	[GetSpellInfo(207871)] = 6, -- Vortex (Mythic)
	[GetSpellInfo(212099)] = 6, -- Temporal Charge
	-- Trilliax
	[GetSpellInfo(206488)] = 6, -- Arcane Seepage
	[GetSpellInfo(206641)] = 6, -- Arcane Spear (Tank)
	[GetSpellInfo(206798)] = 6, -- Toxic Slice
	[GetSpellInfo(214672)] = 6, -- Annihilation
	[GetSpellInfo(214573)] = 6, -- Stuffed
	[GetSpellInfo(214583)] = 6, -- Sterilize
	[GetSpellInfo(208910)] = 6, -- Arcing Bonds
	[GetSpellInfo(206838)] = 6, -- Succulent Feast
	-- Spellblade Aluriel
	[GetSpellInfo(212492)] = 6, -- Annihilate (Tank)
	[GetSpellInfo(212494)] = 6, -- Annihilated (Main Tank debuff)
	[GetSpellInfo(212587)] = 6, -- Mark of Frost
	[GetSpellInfo(212531)] = 6, -- Mark of Frost (marked)
	[GetSpellInfo(212530)] = 6, -- Replicate: Mark of Frost
	[GetSpellInfo(212647)] = 6, -- Frostbitten
	[GetSpellInfo(212736)] = 6, -- Pool of Frost
	[GetSpellInfo(213085)] = 6, -- Frozen Tempest
	[GetSpellInfo(213621)] = 6, -- Entombed in Ice
	[GetSpellInfo(213148)] = 6, -- Searing Brand Chosen
	[GetSpellInfo(213181)] = 6, -- Searing Brand Stunned
	[GetSpellInfo(213166)] = 6, -- Searing Brand
	[GetSpellInfo(213278)] = 6, -- Burning Ground
	[GetSpellInfo(213504)] = 6, -- Arcane Fog
	-- Tichondrius
	[GetSpellInfo(206480)] = 6, -- Carrion Plague
	[GetSpellInfo(215988)] = 6, -- Carrion Nightmare
	[GetSpellInfo(208230)] = 6, -- Feast of Blood
	[GetSpellInfo(212794)] = 6, -- Brand of Argus
	[GetSpellInfo(216685)] = 6, -- Flames of Argus
	[GetSpellInfo(206311)] = 6, -- Illusionary Night
	[GetSpellInfo(206466)] = 6, -- Essence of Night
	[GetSpellInfo(216024)] = 6, -- Volatile Wound
	[GetSpellInfo(216027)] = 6, -- Nether Zone
	[GetSpellInfo(216039)] = 6, -- Fel Storm
	[GetSpellInfo(216726)] = 6, -- Ring of Shadows
	[GetSpellInfo(216040)] = 6, -- Burning Soul
	-- Krosus
	[GetSpellInfo(206677)] = 6, -- Searing Brand
	[GetSpellInfo(205344)] = 6, -- Orb of Destruction
	-- High Botanist Tel'arn
	[GetSpellInfo(218503)] = 6, -- Recursive Strikes (Tank)
	[GetSpellInfo(219235)] = 6, -- Toxic Spores
	[GetSpellInfo(218809)] = 6, -- Call of Night
	[GetSpellInfo(218342)] = 6, -- Parasitic Fixate
	[GetSpellInfo(218304)] = 6, -- Parasitic Fetter
	[GetSpellInfo(218780)] = 6, -- Plasma Explosion
	-- Star Augur Etraeus
	[GetSpellInfo(205984)] = 6, -- Gravitaional Pull
	[GetSpellInfo(214167)] = 6, -- Gravitaional Pull
	[GetSpellInfo(214335)] = 6, -- Gravitaional Pull
	[GetSpellInfo(206936)] = 6, -- Icy Ejection
	[GetSpellInfo(206388)] = 6, -- Felburst
	[GetSpellInfo(206585)] = 6, -- Absolute Zero
	[GetSpellInfo(206398)] = 6, -- Felflame
	[GetSpellInfo(206589)] = 6, -- Chilled
	[GetSpellInfo(205649)] = 6, -- Fel Ejection
	[GetSpellInfo(206965)] = 6, -- Voidburst
	[GetSpellInfo(206464)] = 6, -- Coronal Ejection
	[GetSpellInfo(207143)] = 6, -- Void Ejection
	[GetSpellInfo(206603)] = 6, -- Frozen Solid
	[GetSpellInfo(207720)] = 6, -- Witness the Void
	[GetSpellInfo(216697)] = 6, -- Frigid Pulse
	-- Grand Magistrix Elisande
	[GetSpellInfo(209166)] = 6, -- Fast Time
	[GetSpellInfo(211887)] = 6, -- Ablated
	[GetSpellInfo(209615)] = 6, -- Ablation
	[GetSpellInfo(209244)] = 6, -- Delphuric Beam
	[GetSpellInfo(209165)] = 6, -- Slow Time
	[GetSpellInfo(209598)] = 6, -- Conflexive Burst
	[GetSpellInfo(209433)] = 6, -- Spanning Singularity
	[GetSpellInfo(209973)] = 6, -- Ablating Explosion
	[GetSpellInfo(209549)] = 6, -- Lingering Burn
	[GetSpellInfo(211261)] = 6, -- Permaliative Torment
	[GetSpellInfo(208659)] = 6, -- Arcanetic Ring
	-- Gul'dan
	[GetSpellInfo(210339)] = 6, -- Time Dilation
	[GetSpellInfo(180079)] = 6, -- Felfire Munitions
	[GetSpellInfo(206875)] = 6, -- Fel Obelisk (Tank)
	[GetSpellInfo(206840)] = 6, -- Gaze of Vethriz
	[GetSpellInfo(206896)] = 6, -- Torn Soul
	[GetSpellInfo(206221)] = 6, -- Empowered Bonds of Fel
	[GetSpellInfo(208802)] = 6, -- Soul Corrosion
	[GetSpellInfo(212686)] = 6, -- Flames of Sargeras
}