local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF
oUFDuffedUI = ns.oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

D.updateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
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
UnitPopupMenus["PARTY"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" };
UnitPopupMenus["RAID_PLAYER"] = { "ADD_FRIEND", "ADD_FRIEND_MENU", "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "PET_BATTLE_PVP_DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "RAF_SUMMON", "RAF_GRANT_LEVEL", "REPORT_PLAYER", "CANCEL" };
UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "VOTE_TO_KICK", "RAID_REMOVE", "MOVE_PLAYER_FRAME", "MOVE_TARGET_FRAME", "REPORT_PLAYER", "CANCEL" };

D.PostUpdateHealth = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_offline .. "|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_dead .. "|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_ghost .. "|r")
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

D.PostUpdateHealthRaid = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_offline .. "|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_dead .. "|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5" .. L.unitframes_ouf_ghost .. "|r")
		end
	else
		if C["unitframes"].ColorGradient == true and C["unitframes"].unicolor == true then
			local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			health:SetStatusBarColor(r, g, b)
		end

		if not UnitIsPlayer(unit) and UnitIsFriend(unit, "player") and C["unitframes"].unicolor ~= true then
			local c = D.UnitColor.reaction[5]
			local r, g, b = c[1], c[2], c[3]
			health:SetStatusBarColor(r, g, b)
			health.bg:SetTexture(.1, .1, .1)
		end

		if min ~= max then health.value:SetText("|cff559655-" .. D.ShortValue(max-min) .. "|r") else health.value:SetText("") end
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

D.PreUpdatePower = function(power, unit)
	local pType = select(2, UnitPowerType(unit))
	
	local color = D.UnitColor.power[pType]
	if color then power:SetStatusBarColor(color[1], color[2], color[3]) end
end

D.PostUpdatePower = function(power, unit, min, max)
	local self = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local color = D.UnitColor.power[pToken]

	if color then power.value:SetTextColor(color[1], color[2], color[3]) end

	if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit) then
		power.value:SetText()
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		power.value:SetText()
	else
		if min ~= max then
			if pType == 0 then
				if unit == "target" then
					power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), D.ShortValue(max - (max - min)))
				elseif unit == "player" and self:GetAttribute("normalUnit") == "pet" or unit == "pet" then
					power.value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and unit:find("arena%d")) or unit == "focus" or unit == "focustarget" then
					power.value:SetText(D.ShortValue(min))
				else
					power.value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
				end
			else
				power.value:SetText(max - (max - min))
			end
		else
			if unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and unit:find("arena%d")) then
				power.value:SetText(D.ShortValue(min))
			else
				power.value:SetText(min)
			end
		end
	end
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

D.PvPUpdate = function(self, elapsed)
	if (self.elapsed and self.elapsed > 0.2) then
		local unit = self.unit
		local time = GetPVPTimer()

		local min = format("%01.f", floor((time / 1000) / 60))
		local sec = format("%02.f", floor((time / 1000) - min * 60))
		if self.PvP then
			local factionGroup = UnitFactionGroup(unit)
			if UnitIsPVPFreeForAll(unit) then
				if time ~= 301000 and time ~= -1 then
					self.PvP:SetText(PVP .. " " .. "(" .. min .. ":" .. sec .. ")")
				else
					self.PvP:SetText(PVP)
				end
			elseif (factionGroup and UnitIsPVP(unit)) then
				if time ~= 301000 and time ~= -1 then
					self.PvP:SetText(PVP .. " " .. "(" .. min .. ":" .. sec .. ")")
				else
					self.PvP:SetText(PVP)
				end
			else
				self.PvP:SetText("")
			end
		end
		self.elapsed = 0
	else
		self.elapsed = (self.elapsed or 0) + elapsed
	end
end

D.FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%d" .. D.panelcolor .. "d", ceil(s / day))
	elseif s >= hour then
		return format("%d" .. D.panelcolor .. "h", ceil(s / hour))
	elseif s >= minute then
		return format("%d" .. D.panelcolor .. "m", ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format("%.1f", s)
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
				if self.timeLeft <= 5 then
					self.remaining:SetTextColor(.99, .31, .31)
				else
					self.remaining:SetTextColor(1, 1, 1)
				end
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
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.Portrait:SetAlpha(0)
		else
			self.Portrait:SetAlpha(1)
		end
	end
	self.Portrait:SetFrameLevel(4)
end

D.PortraitUpdate = function(self, unit)
	if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then
		self:SetCamera(1)
	end
end

local CheckInterrupt = function(self, unit)
	if unit == "vehicle" then unit = "player" end

	if self.interrupt and UnitCanAttack("player", unit) then
		self:SetStatusBarColor(1, 0, 0, .5)
	else
		if C["castbar"].classcolor then
			self:SetStatusBarColor(unpack(D.UnitColor.class[D.Class]))
		else
			self:SetStatusBarColor(unpack(C["castbar"].color))
		end
	end
end

local ticks = {}
local HideTicks = function()
	for _, tick in pairs(ticks) do
		tick:Hide()
	end
end

local SetCastTicks = function(frame, numTicks)
	HideTicks()
	if numTicks and numTicks > 0  then
		local d = frame:GetWidth() / numTicks
		for i = 1, numTicks do
			if not ticks[i] then
				ticks[i] = frame:CreateTexture(nil, "OVERLAY")
				ticks[i]:SetTexture( C["media"].normTex)

				if C["castbar"].classcolor == true then
					ticks[i]:SetVertexColor(0, 0, 0)
				else
					ticks[i]:SetVertexColor(.84, .75, .65)
				end
				ticks[i]:SetWidth(2)
				ticks[i]:SetHeight(frame:GetHeight())
			end
			ticks[i]:ClearAllPoints()
			ticks[i]:SetPoint("CENTER", frame, "LEFT", d * i, 0)
			ticks[i]:Show()
		end
	end
end

D.CustomCastTime = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

D.CustomCastDelayText = function(self, duration)
	self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
end

D.CastBar = function(self, unit, name, rank, castid)
	CheckInterrupt(self, unit)

	local color
	self.unit = unit

	if C["castbar"].cbticks == true and unit == "player" then
		local baseTicks = D.ChannelTicks[name]
		if baseTicks and D.HasteTicks[name] then
			local tickIncRate = 1 / baseTicks
			local curHaste = UnitSpellHaste("player") * 0.01
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

D.EclipseDirection = function(self)
	if GetEclipseDirection() == "sun" then
		self.Text:SetText("|cffE5994C" .. L.unitframes_ouf_starfirespell .. "|r")
	elseif GetEclipseDirection() == "moon" then
		self.Text:SetText("|cff4478BC" .. L.unitframes_ouf_wrathspell .. "|r")
	else
		self.Text:SetText("")
	end
end

D.DruidBarDisplay = function(self, login)
	local eb = self.EclipseBar
	local dm = self.DruidMana
	local bg = self.DruidManaBackground
	local flash = self.FlashInfo

	if login then dm:SetScript("OnUpdate", nil) end

	if dm and dm:IsShown() then 
		bg:SetAlpha(1)
	else
		flash:Show()
		if bg then bg:SetAlpha(0) end
	end

	if (eb and eb:IsShown()) or (dm and dm:IsShown()) then
		if eb and eb:IsShown() then
			local txt = self.EclipseBar.Text
			txt:Show()
			flash:Hide()
		end
		if bg then bg:SetAlpha(1) end
	else
		if eb then
			local txt = self.EclipseBar.Text
			txt:Hide()
		end
		flash:Show()
		if bg then bg:SetAlpha(0) end
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
		self.ManaLevel:SetText("|cffaf5050"..L.unitframes_ouf_lowmana.."|r")
		Flash(self, .3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

D.UpdateDruidManaText = function(self)
	if self.unit ~= "player" then return end

	local num, str = UnitPowerType("player")
	if num ~= 0 then
		local min = UnitPower("player", 0)
		local max = UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= 20 then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050" .. L.unitframes_ouf_lowmana .. "|r")
			Flash(self.FlashInfo, 0.3)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			self.DruidManaText:SetFormattedText("%d%%", floor(min / max * 100))
		else
			self.DruidManaText:SetText()
		end

		self.DruidManaText:SetAlpha(1)
	else
		self.DruidManaText:SetAlpha(0)
	end
end

D.UpdateThreat = function(self, event, unit)
	if (self.unit ~= unit) or (unit == "target" or unit == "pet" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
	local threat = UnitThreatSituation(self.unit)
	if (threat == 3) then
		if self.panel then
			self.panel:SetBackdropBorderColor(.69, .31, .31, 1)
		else
			self.Name:SetTextColor(1,.1, .1)
		end
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
		lfdrole:SetTexture(67/255, 110/255, 238/255, .3)
		lfdrole:Show()
	elseif role == "HEALER" then
		lfdrole:SetTexture(130/255,  255/255, 130/255, .15)
		lfdrole:Show()
	elseif role == "DAMAGER" then
		lfdrole:SetTexture(176/255, 23/255, 31/255, .27)
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

D.CreateAuraWatchIcon = function(self, icon)
	icon:SetTemplate()
	icon.icon:Point("TOPLEFT", 1, -1)
	icon.icon:Point("BOTTOMRIGHT", -1, 1)
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	if icon.cd then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

D.createAuraWatch = function(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.displayText = true
	auras.icons = {}
	auras.PostCreateIcon = D.CreateAuraWatchIcon

	local buffs = {}

	if D.buffids["ALL"] then
		for key, value in pairs(D.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (D.buffids[D.Class]) then
		for key, value in pairs(D.buffids[D.Class]) do
			tinsert(buffs, value)
		end
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
			if (spell[4]) then
				tex:SetVertexColor(unpack(spell[4]))
			else
				tex:SetVertexColor(.8, .8, .8)
			end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(C["media"].font, 8, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(D.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end
	self.AuraWatch = auras
end

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
				{974, "BOTTOMRIGHT", {0, 0}, {.7, .4, 0}, true}, -- Earth Shield
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

		-- Raid Debuffs
		D.debuffids = {
			-- Mogu'shan Vaults
			-- The Stone Guard
			SpellName(116281), -- Cobalt Mine Blast
			-- Feng the Accursed
			SpellName(116784), -- Wildfire Spark
			SpellName(116417), -- Arcane Resonance
			SpellName(116942), -- Flaming Spear
			-- Gara'jal the Spiritbinder
			SpellName(116161), -- Crossed Over
			SpellName(122151), -- Voodoo Dolls
			-- The Spirit Kings
			SpellName(117708), -- Maddening Shout
			SpellName(118303), -- Fixate
			SpellName(118048), -- Pillaged
			SpellName(118135), -- Pinned Down
			-- Elegon
			SpellName(117878), -- Overcharged
			SpellName(117949), -- Closed Circuit
			-- Will of the Emperor
			SpellName(116835), -- Devastating Arc
			SpellName(116778), -- Focused Defense
			SpellName(116525), -- Focused Assault
			-- Heart of Fear
			-- Imperial Vizier Zor'lok
			SpellName(122761), -- Exhale
			SpellName(122760), -- Exhale
			SpellName(122740), -- Convert
			SpellName(123812), -- Pheromones of Zeal
			-- Blade Lord Ta'yak
			SpellName(123180), -- Wind Step
			SpellName(123474), -- Overwhelming Assault
			-- Garalon
			SpellName(122835), -- Pheromones
			SpellName(123081), -- Pungency
			-- Wind Lord Mel'jarak
			SpellName(122125), -- Corrosive Resin Pool
			SpellName(121885), -- Amber Prison
			-- Amber-Shaper Un'sok
			SpellName(121949), -- Parasitic Growth
			-- Terrace of Endless Spring
			-- Protectors of the Endless
			SpellName(117436), -- Lightning Prison
			SpellName(118091), -- Defiled Ground
			SpellName(117519), -- Touch of Sha
			-- Tsulong
			SpellName(122752), -- Shadow Breath
			SpellName(123011), -- Terrorize
			SpellName(116161), -- Crossed Over
			-- Lei Shi
			SpellName(123121), -- Spray
			-- Sha of Fear
			SpellName(119985), -- Dread Spray
			SpellName(119086), -- Penetrating Bolt
			SpellName(119775), -- Reaching Attack
			-- Throne of Thunder
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
			-- Siege of Orgrimmar
			-- Immerseus
			SpellName(143436), -- Corrosive Blast
			SpellName(143459), -- Sha Residue
			SpellName(143579), -- Sha Corruption(Heroic)
			-- The Fallen Protectors
			SpellName(143198), -- Garrote
			SpellName(143434), -- Shadow Word: Bane
			SpellName(147383), -- Debilitation
			-- Norushen
			SpellName(146124), -- Self Doubt
			SpellName(144851), -- Test of Confidence
			SpellName(144514), -- Lingering Corruption
			-- Sha of Pride
			SpellName(144774), -- Reaching Attacks
			SpellName(144358), -- Wounded Pride
			SpellName(144351), -- Mark of Arrogance
			SpellName(146594), -- Gift of the Titans
			SpellName(147207), -- Weakened Resolve
			-- Galakras
			SpellName(146765), -- Flame Arrows
			SpellName(146902), -- Poison-Tipped Blades
			-- Iron Juggernaut
			SpellName(144467), -- Ignite Armor
			SpellName(144459), -- Laser Burn
			SpellName(144918), -- Cutter Laser
			-- Kor'kron Dark Shaman
			SpellName(143990), -- Foul Geyser
			SpellName(144107), -- Toxicity
			SpellName(144215), -- Froststorm Strike
			SpellName(144089), -- Toxic Mist
			SpellName(144330), -- Iron Prison
			-- General Nazgrim
			SpellName(143494), -- Sundering Blow
			SpellName(143638), -- Bonecracker
			SpellName(143431), -- Magistrike
			-- Malkorok
			SpellName(142990), -- Fatal Strike
			SpellName(142913), -- Displaced Energy
			SpellName(143919), -- Languish(Heroic)
			SpellName(142863), -- Weak Ancient Barrier
			SpellName(142864), -- Ancient Barrier
			SpellName(142865), -- Strong Ancient Barrier
			-- Spoils of Pandaria
			SpellName(146213), -- Keg Toss
			SpellName(145218), -- Harden Flesh
			SpellName(146235), -- Breath of Fire
			-- Thok the Bloodthirsty
			SpellName(143766), -- Panic
			SpellName(143780), -- Acid Breath
			SpellName(143773), -- Freezing Breath
			SpellName(143800), -- Icy Blood
			SpellName(143767), -- Scorching Breath
			SpellName(143791), -- Corrosive Blood
			SpellName(146589), -- Skeleton Key
			SpellName(143777), -- Frozen Solid
			SpellName(133042), -- Fixate
			-- Siegecrafter Blackfuse
			SpellName(143385), -- Electrostatic Charge
			SpellName(144236), -- Pattern Recognition
			-- Paragons of the Klaxxi
			SpellName(142929), -- Tenderizing Strikes
			SpellName(143275), -- Hewn
			SpellName(143279), -- Genetic Alteration
			SpellName(143974), -- Shield Bash
			SpellName(142948), -- Aim
			-- Garrosh Hellscream
			SpellName(145183), -- Gripping Despair
			SpellName(145195), -- Empowered Gripping Despair
		}
		D.ReverseTimer = {
		},
		ORD:RegisterDebuffs(D.debuffids)
	end
end