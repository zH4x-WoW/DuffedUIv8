local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF
oUFDuffedUI = ns.oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

D['updateAllElements'] = function(frame)
	for _, v in ipairs(frame.__elements) do v(frame, 'UpdateElement', frame.unit) end
end

local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup('Flash')
	self.anim.fadein = self.anim:CreateAnimation('ALPHA', 'FadeIn')
	self.anim.fadein:SetFromAlpha(1)
	self.anim.fadein:SetToAlpha(0)

	self.anim.fadeout = self.anim:CreateAnimation('ALPHA', 'FadeOut')
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

-- Healthupdate for UFs
D['PostUpdateHealth'] = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['offline'] .. '|r')
		elseif UnitIsDead(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['dead'] .. '|r')
		elseif UnitIsGhost(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['ghost'] .. '|r')
		end
	else
		local r, g, b

		if C['unitframes']['ColorGradient'] and C['unitframes']['unicolor'] then
			local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			health:SetStatusBarColor(r, g, b)
		end

		if (C['unitframes']['unicolor'] ~= true and unit == 'target' and UnitIsEnemy(unit, 'player') and UnitIsPlayer(unit)) or (C['unitframes']['unicolor'] ~= true and unit == 'target' and not UnitIsPlayer(unit) and UnitIsFriend(unit, 'player')) then
			local c = D['UnitColor']['reaction'][UnitReaction(unit, 'player')]
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
			if unit == 'player' and health:GetAttribute('normalUnit') ~= 'pet' then
				health.value:SetFormattedText('|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r', D['ShortValue'](min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif unit == 'target' or (unit and unit:find('boss%d')) then
				health.value:SetFormattedText('|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r', D['ShortValue'](min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and unit:find('boss%d')) then
				health.value:SetFormattedText('|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r', D['ShortValue'](min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and unit:find('arena%d')) or unit == 'focus' or unit == 'focustarget' then
				health.value:SetText('|cff559655' .. D['ShortValue'](min) .. '|r')
			else
				health.value:SetText('|cff559655-' .. D['ShortValue'](max-min) .. '|r')
			end
		else
			if unit == 'player' and health:GetAttribute('normalUnit') ~= 'pet' then
				health.value:SetText('|cff559655' .. D['ShortValue'](max) .. '|r')
			elseif unit == 'target' or unit == 'focus'  or unit == 'focustarget' or (unit and unit:find('arena%d')) then
				health.value:SetText('|cff559655' .. D['ShortValue'](max) .. '|r')
			elseif (unit and unit:find('boss%d')) then
				health.value:SetText('')
			else
				health.value:SetText('')
			end
		end
	end
end

-- Healthupdate for Raidframes
D['PostUpdateHealthRaid'] = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['offline'] .. '|r')
		elseif UnitIsDead(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['dead'] .. '|r')
		elseif UnitIsGhost(unit) then
			health.value:SetText('|cffD7BEA5' .. L['uf']['ghost'] .. '|r')
		end
	else
		if C['unitframes']['ColorGradient'] and C['unitframes']['unicolor'] then
			local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
			health:SetStatusBarColor(r, g, b)
		end

		if not UnitIsPlayer(unit) and UnitIsFriend(unit, 'player') and C['unitframes']['unicolor'] ~= true then
			local c = D['UnitColor']['reaction'][5]
			local r, g, b = c[1], c[2], c[3]
			health:SetStatusBarColor(r, g, b)
			health.bg:SetColorTexture(.1, .1, .1)
		end

		if min ~= max then health.value:SetText('|cff559655-' .. D['ShortValue'](max-min) .. '|r') else health.value:SetText('') end
	end
end

D['PostUpdatePetColor'] = function(health, unit, min, max)
	if C['unitframes']['ColorGradient'] and C['unitframes']['unicolor'] then
		local r, g, b = oUFDuffedUI.ColorGradient(min, max, 0, 0, 0, .6, .2, .2, .125, .125, .125)
		health:SetStatusBarColor(r, g, b)
	end

	if not UnitIsPlayer(unit) and UnitIsFriend(unit, 'player') and C['unitframes']['unicolor'] ~= true then
		local c = D['UnitColor']['reaction'][5]
		local r, g, b = c[1], c[2], c[3]

		if health then health:SetStatusBarColor(r, g, b) end
		if health.bg then health.bg:SetColorTexture(.1, .1, .1) end
	end
end

-- Powerupdate for UFs
D['PostUpdatePower'] = function(power, unit, min)
	if not power.value then return end

	local Parent = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local colors = D['UnitColor']
	local color = colors.power[pToken]
	local max = UnitPowerMax(unit)

	if color then power.value:SetTextColor(color[1], color[2], color[3]) end
	if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) then
		power.value:SetText()
	elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
		power.value:SetText()
	else
		if (min ~= max) then
			if (pType == 0) then
				if (unit == 'target' or (unit and strfind(unit, 'boss%d'))) then
					power.value:SetFormattedText('%d%% |cffD7BEA5-|r %s', floor(min / max * 100), D['ShortValue'](max - (max - min)))
				elseif (unit == 'player' and Parent:GetAttribute('normalUnit') == 'pet' or unit == 'pet') then
					power.value:SetFormattedText('%d%%', floor(min / max * 100))
				elseif (unit and strfind(unit, 'arena%d')) or unit == 'focus' or unit == 'focustarget' then
					power.value:SetText(D['ShortValue'](min))
				else
					power.value:SetFormattedText('%d%% |cffD7BEA5-|r %d', floor(min / max * 100), max - (max - min))
				end
			else
				power.value:SetText(max - (max - min))
			end
		else
			if (unit == 'pet' or unit == 'target' or unit == 'focus' or unit == 'focustarget' or (unit and strfind(unit, 'arena%d')) or (unit and strfind(unit, 'boss%d'))) then
				power.value:SetText(D['ShortValue'](min))
			else
				power.value:SetText(min)
			end
		end
	end
end

D['PostUpdateAltMana'] = function(unit, min, max)
	local parent = self:GetParent()
	local powerText = parent.Power.value
	local powerTextParent = powerText:GetParent()

	local powerTextPosition = db.power.position

	if min ~= max then
		local color = D['UnitColor']['power']['MANA']
		color = D['RGBToHex'](color[1], color[2], color[3])

		self.Text:SetParent(powerTextParent)

		self.Text:ClearAllPoints()
		if powerText:GetText() then
			if find(powerTextPosition, 'RIGHT') then
				self.Text:Point('RIGHT', powerText, 'LEFT', 3, 0)
				self.Text:SetFormattedText(color..'%d%%|r |cffD7BEA5- |r', floor(min / max * 100))
			elseif find(powerTextPosition, 'LEFT') then
				self.Text:Point('LEFT', powerText, 'RIGHT', -3, 0)
				self.Text:SetFormattedText('|cffD7BEA5-|r'..color..' %d%%|r', floor(min / max * 100))
			else
				if select(4, powerText:GetPoint()) <= 0 then
					self.Text:Point('LEFT', powerText, 'RIGHT', -3, 0)
					self.Text:SetFormattedText('|cffD7BEA5-|r'..color..' %d%%|r', floor(min / max * 100))
				else
					self.Text:Point('RIGHT', powerText, 'LEFT', 3, 0)
					self.Text:SetFormattedText(color..'%d%%|r |cffD7BEA5- |r', floor(min / max * 100))
				end
			end
		else
			self.Text:Point(powerText:GetPoint())
			self.Text:SetFormattedText(color..'%d%%|r', floor(min / max * 100))
		end
	else
		self.Text:SetText()
	end
end

-- Timer for Buffs & Debuffs
D['FormatTime'] = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format('%d' .. D['PanelColor'] .. 'd', ceil(s / day))
	elseif s >= hour then
		return format('%d' .. D['PanelColor'] .. 'h', ceil(s / hour))
	elseif s >= minute then
		return format('%d' .. D['PanelColor'] .. 'm', ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format('%.1f', s)
end

function updateAuraTrackerTime(self, elapsed)
	if (self.active) then
		self.timeleft = self.timeleft - elapsed

		if (self.timeleft <= 5) then self.text:SetTextColor(1, 0, 0) else self.text:SetTextColor(1, 1, 1) end
		if (self.timeleft <= 0) then
			self.icon:SetTexture('')
			self.text:SetText('')
		end
		self.text:SetFormattedText('%.1f', self.timeleft)
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
				local time = D['FormatTime'](self.timeLeft)
				self.remaining:SetText(time)
				if self.timeLeft <= 5 then self.remaining:SetTextColor(.99, .31, .31) else self.remaining:SetTextColor(1, 1, 1) end
			else
				self.remaining:Hide()
				self:SetScript('OnUpdate', nil)
			end
			self.elapsed = 0
		end
	end
end

D['PostCreateAura'] = function(self, button)
	button:SetTemplate('Transparent')

	button.remaining = D['SetFontString'](button, C['media']['font'], 8, 'THINOUTLINE')
	button.remaining:Point('TOPLEFT', 1, -3)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true

	button.cd:SetReverse()
	button.icon:Point('TOPLEFT', 2, -2)
	button.icon:Point('BOTTOMRIGHT', -2, 2)
	button.icon:SetTexCoord(.08, .92, .08, .92)
	button.icon:SetDrawLayer('ARTWORK')

	button.count:Point('BOTTOMRIGHT', 1, 1)
	button.count:SetJustifyH('RIGHT')
	button.count:SetFont(C['media']['font'], 9, 'THINOUTLINE')
	button.count:SetTextColor(.84, .75, .65)

	button.overlayFrame = CreateFrame('frame', nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:Point('TOPLEFT', button, 'TOPLEFT', 2, -2)
	button.cd:Point('BOTTOMRIGHT', button, 'BOTTOMRIGHT', -2, 2)
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)

	button.Glow = CreateFrame('Frame', nil, button)
	button.Glow:Point('TOPLEFT', button, 'TOPLEFT', -3, 3)
	button.Glow:Point('BOTTOMRIGHT', button, 'BOTTOMRIGHT', 3, -3)
	button.Glow:SetFrameStrata('BACKGROUND')
	button.Glow:SetBackdrop{edgeFile = C['media']['glowTex'], edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)

	button.Animation = button:CreateAnimationGroup()
    button.Animation:SetLooping('BOUNCE')

    button.Animation.FadeOut = button.Animation:CreateAnimation('Alpha')
    button.Animation.FadeOut:SetFromAlpha(1)
    button.Animation.FadeOut:SetToAlpha(0)
    button.Animation.FadeOut:SetDuration(.6)
    button.Animation.FadeOut:SetSmoothing('IN_OUT')
end

D['PostUpdateAura'] = function(self, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)
	if icon then
		if icon.filter == 'HARMFUL' then
			if not UnitIsFriend('player', unit) and icon.owner ~= 'player' and icon.owner ~= 'vehicle' then
				icon.icon:SetDesaturated(true)
				icon:SetBackdropBorderColor(unpack(C['media']['bordercolor']))
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				icon.icon:SetDesaturated(false)
				icon:SetBackdropBorderColor(color.r * .8, color.g * .8, color.b * .8)
			end
		else
			if isStealable or ((D['Class'] == 'MAGE' or D['Class'] == 'PRIEST' or D['Class'] == 'SHAMAN') and dtype == 'Magic') and not UnitIsFriend('player', unit) then
				if not icon.Animation:IsPlaying() then icon.Animation:Play() end
			else
				if icon.Animation:IsPlaying() then icon.Animation:Stop() end
			end
		end

		if duration and duration > 0 then icon.remaining:Show() else icon.remaining:Hide() end

		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		icon:SetScript('OnUpdate', CreateAuraTimer)
	end
end

D['UpdateTargetDebuffsHeader'] = function(self)
	local numBuffs = self.visibleBuffs
	local perRow = self.numRow
	local s = self.size
	local row = math.ceil((numBuffs / perRow))
	local p = self:GetParent()
	local h = p.Debuffs
	local y = s * row
	local addition = s

	if numBuffs == 0 then addition = 0 end
	h:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', -2, y + addition)
end

D['HidePortrait'] = function(self, unit)
	if self.unit == 'target' then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then self.Portrait:SetAlpha(0) else self.Portrait:SetAlpha(1) end
	end
	self.Portrait:SetFrameLevel(4)
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
				ticks[i] = frame:CreateTexture(nil, 'OVERLAY')
				ticks[i]:SetTexture( C['media']['normTex'])

				if C['castbar']['classcolor'] then ticks[i]:SetVertexColor(0, 0, 0) else ticks[i]:SetVertexColor(.84, .75, .65) end
				ticks[i]:SetWidth(2)
				ticks[i]:SetHeight(frame:GetHeight())
			end
			ticks[i]:ClearAllPoints()
			ticks[i]:SetPoint('CENTER', frame, 'LEFT', d * i, 0)
			ticks[i]:Show()
		end
	end
end

D['CustomCastTime'] = function(self, duration)
	self.Time:SetText(('%.1f / %.1f'):format(self.channeling and duration or self.max - duration, self.max))
end

D['CustomCastDelayText'] = function(self, duration)
	self.Time:SetText(('%.1f |cffaf5050%s %.1f|r'):format(self.channeling and duration or self.max - duration, self.channeling and '- ' or '+', self.delay))
end

D['CastBar'] = function(self, unit, name, rank, castid)
	local color
	self.unit = unit

	if C['castbar']['cbticks'] and unit == 'player' then
		local baseTicks = D['ChannelTicks'][name]
		if baseTicks and D['HasteTicks'][name] then
			local tickIncRate = 1 / baseTicks
			local curHaste = UnitSpellHaste('player') * .01
			local firstTickInc = tickIncRate / 2
			local bonusTicks = 0
			if curHaste >= firstTickInc then bonusTicks = bonusTicks + 1 end

			local x = tonumber(D['Round'](firstTickInc + tickIncRate, 2))
			while curHaste >= x do
				x = tonumber(D['Round'](firstTickInc + (tickIncRate * bonusTicks), 2))
				if curHaste >= x then bonusTicks = bonusTicks + 1 end
			end

			SetCastTicks(self, baseTicks + bonusTicks)
		elseif baseTicks then
			SetCastTicks(self, baseTicks)
		else
			HideTicks()
		end
	elseif unit == 'player' then
		HideTicks()
	end
end

D['EclipseDirection'] = function(self)
	local power = UnitPower('player', SPELL_POWER_ECLIPSE)

	if power < 0 then
		self.Text:SetText('|cffE5994C' .. L['uf']['starfire'] .. '|r')
	elseif power > 0 then
		self.Text:SetText('|cff4478BC' .. L['uf']['wrath'] .. '|r')
	else
		self.Text:SetText('')
	end
end

D['MLAnchorUpdate'] = function (self)
	if self.LeaderIndicator:IsShown() then
		self.MasterLooterIndicator:SetPoint('TOPLEFT', 14, 8)
	else
		self.MasterLooterIndicator:SetPoint('TOPLEFT', 0, 8)
	end
end

local UpdateManaLevelDelay = 0
D['UpdateManaLevel'] = function(self, elapsed)
	UpdateManaLevelDelay = UpdateManaLevelDelay + elapsed
	if self.parent.unit ~= 'player' or UpdateManaLevelDelay < .2 or UnitIsDeadOrGhost('player') then return end
	UpdateManaLevelDelay = 0

	local mana = UnitPower('player', SPELL_POWER_MANA)
	local maxmana = UnitPowerMax('player', SPELL_POWER_MANA)

	if maxmana == 0 then return end

	local percMana = mana / maxmana * 100

	if percMana == 20 then
		self.ManaLevel:SetText('|cffaf5050' .. L['uf']['lowmana'] .. '|r')
		Flash(self, .3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

D['UpdateThreat'] = function(self, event, unit)
	if (self.unit ~= unit) or (unit == 'target' or unit == 'pet' or unit == 'focus' or unit == 'focustarget' or unit == 'targettarget') then return end
	local threat = UnitThreatSituation(self.unit)
	if (threat == 3) then
		if self.panel then
			self.panel:SetBackdropBorderColor(.69, .31, .31, 1)
		else
			self.Name:SetTextColor(1,.1, .1)
		end
	else
		if self.panel then
			local r, g, b = unpack(C['media']['bordercolor'])
			self.panel:SetBackdropBorderColor(r * .7, g * .7, b * .7)
		else
			self.Name:SetTextColor(1, 1, 1)
		end
	end
end

D['SetGridGroupRole'] = function(self, role)
	local lfdrole = self.GroupRoleIndicator
	local role = UnitGroupRolesAssigned(self.unit)

	if role == 'TANK' then
		lfdrole:SetTexture(C['media'].tank)
		lfdrole:Show()
	elseif role == 'HEALER' then
		lfdrole:SetTexture(C['media'].heal)
		lfdrole:Show()
	elseif role == 'DAMAGER' then
		lfdrole:SetTexture(C['media'].dps)
		lfdrole:Show()
	else
		lfdrole:Hide()
	end
end

-- Grid
D['countOffsets'] = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

D['createAuraWatch'] = function(self, unit)
	local Class = select(2, UnitClass('player'))

	local auras = CreateFrame('Frame', nil, self)
	auras:SetPoint('TOPLEFT', self.Health, 2, -2)
	auras:SetPoint('BOTTOMRIGHT', self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = function(self, icon)
		if icon.icon and not icon.hideIcon then
			icon:SetTemplate()
			icon.icon:Point('TOPLEFT', 1, -1)
			icon.icon:Point('BOTTOMRIGHT', -1, 1)
			icon.icon:SetTexCoord(.08, .92, .08, .92)
			icon.icon:SetDrawLayer('ARTWORK')
		end
		if (icon.cd) then
			icon.cd:SetHideCountdownNumbers(true)
			icon.cd:SetReverse(true)
		end
		if icon.overlay then icon.overlay:SetTexture() end
	end
	auras.strictMatching = true

	local buffs = {}

	if (D['Buffids']['ALL']) then
		for key, value in pairs(D['Buffids']['ALL']) do tinsert(buffs, value) end
	end

	if (D['Buffids'][D['Class']]) then
		for key, value in pairs(D['Buffids'][D['Class']]) do tinsert(buffs, value) end
	end

	-- Cornerbuffs
	if buffs then
		for key, spell in pairs(buffs) do
			local Icon = CreateFrame('Frame', nil, auras)
			Icon.spellID = spell[1]
			Icon.anyUnit = spell[4]
			Icon:Width(6)
			Icon:Height(6)
			Icon:SetPoint(spell[2], 0, 0)

			local Texture = Icon:CreateTexture(nil, 'OVERLAY')
			Texture:SetAllPoints(Icon)
			Texture:SetTexture(C['media']['blank'])

			if (spell[3]) then Texture:SetVertexColor(unpack(spell[3])) else Texture:SetVertexColor(0.8, 0.8, 0.8) end

			local Count = Icon:CreateFontString(nil, 'OVERLAY')
			Count:SetFont(C['media']['font'], 8, 'THINOUTLINE')
			Count:SetPoint('CENTER', unpack(D['countOffsets'][spell[2]]))
			Icon.count = Count

			auras.icons[spell[1]] = Icon
		end
	end
	self.AuraWatch = auras
end

--Raidbuffs & -debuffs
D['Buffids'] = {
	PRIEST = {
		{194384, "BOTTOMRIGHT", {1, 0, 0.75}}, -- Atonement
		{214206, "BOTTOMRIGHT", {1, 0, 0.75}}, -- Atonement PvP
		{41635, "BOTTOMRIGHT", {0.2, 0.7, 0.2}}, -- Prayer of Mending
		{193065, "BOTTOMRIGHT", {0.54, 0.21, 0.78}}, -- Masochism
		{139, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
		{6788, "BOTTOMLEFT", {0.89, 0.1, 0.1}}, -- Weakened Soul
		{17, "TOPLEFT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
		{47788, "LEFT", {221 / 255, 117 / 255, 0}, true}, -- Guardian Spirit
		{33206, "LEFT", {227 / 255, 23 / 255, 13 / 255}, true} -- Pain Suppression
	},

	DRUID = {
		{774, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
		{155777, "RIGHT", {0.8, 0.4, 0.8}}, -- Germination
		{8936, "BOTTOMLEFT", {0.2, 0.8, 0.2}}, -- Regrowth
		{33763, "TOPLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
		{48438, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
		{207386, "TOP", {0.4, 0.2, 0.8}}, -- Spring Blossoms
		{102351, "LEFT", {0.2, 0.8, 0.8}}, -- Cenarion Ward (Initial Buff)
		{102352, "LEFT", {0.2, 0.8, 0.8}}, -- Cenarion Ward (HoT)
		{200389, "BOTTOM", {1, 1, 0.4}} -- Cultivation
	},

	PALADIN = {
		{53563, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Light
		{156910, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Faith
		{200025, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Virtue
		{1022, "BOTTOMRIGHT", {0.2, 0.2, 1}, true}, -- Hand of Protection
		{1044, "BOTTOMRIGHT", {0.89, 0.45, 0}, true}, -- Hand of Freedom
		{6940, "BOTTOMRIGHT", {0.89, 0.1, 0.1}, true}, -- Hand of Sacrifice
		{223306, "BOTTOMLEFT", {0.7, 0.7, 0.3}, true}, -- Bestow Faith
	},

	SHAMAN = {
		{61295, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide
		{974, "BOTTOMRIGHT", {0.2, 0.2, 1}}  -- Earth Shield
	},

	MONK = {
		{119611, 'TOPLEFT', {0.8, 0.4, 0.8}},	             -- Renewing Mist
		{116849, 'RIGHT', {0.2, 0.8, 0.2}},	             	 -- Life Cocoon
		{124682, 'BOTTOMLEFT', {0.4, 0.8, 0.2}},             -- Enveloping Mist
		{124081, 'BOTTOMRIGHT', {0.7, 0.4, 0}},              -- Zen Sphere
	},
	
	ROGUE = {
		{57934, "TOPLEFT", {227 / 255, 23 / 255, 13 / 255}} -- Tricks of the Trade
	},

	WARRIOR = {
		{114030, "TOPLEFT", {0.2, 0.2, 1}}, -- Vigilance
		{147833, "RIGHT", {227 / 255, 23 / 255, 13 / 255}} -- Intervene
	},
	
	PET = {
		-- Warlock Pets
		{193396, "TOPLEFT", {0.6, 0.2, 0.8}, true}, -- Demonic Empowerment
		-- Hunter Pets
		{19615, "TOPLEFT", {227 / 255, 23 / 255, 13 / 255}, true}, -- Frenzy
		{136, "LEFT", {0.2, 0.8, 0.2}, true} -- Mend Pet
	},

	ALL = {
		{14253, 'RIGHT', {0, 1, 0}},                         -- Abolish Poison
	},
}

D['Debuffids'] = {
	-- Battle for Azeroth
	-- Mythic+ Dungeons
	[GetSpellInfo(196376)] = 3, -- Grievous Tear
	[GetSpellInfo(209858)] = 3, -- Necrotic
	[GetSpellInfo(226512)] = 3, -- Sanguine
	[GetSpellInfo(240443)] = 3, -- Bursting
	[GetSpellInfo(240559)] = 3, -- Grievous
	[GetSpellInfo(277242)] = 3, -- Symbiote of G'huun (Infested)
	[GetSpellInfo(288388)] = 3, -- Reap Soul
	[GetSpellInfo(288694)] = 3, -- Shadow Smash

	-- Dungeons
	-- Freehold
	[GetSpellInfo(258323)] = 3, -- Infected Wound
	[GetSpellInfo(257775)] = 3, -- Plague Step
	[GetSpellInfo(257908)] = 3, -- Oiled Blade
	[GetSpellInfo(257436)] = 3, -- Poisoning Strike
	[GetSpellInfo(274389)] = 3, -- Rat Traps
	[GetSpellInfo(274555)] = 3, -- Scabrous Bites
	[GetSpellInfo(258875)] = 3, -- Blackout Barrel
	[GetSpellInfo(256363)] = 3, -- Ripper Punch

	-- Shrine of the Storm
	[GetSpellInfo(264560)] = 3, -- Choking Brine
	[GetSpellInfo(268233)] = 3, -- Electrifying Shock
	[GetSpellInfo(268322)] = 3, -- Touch of the Drowned
	[GetSpellInfo(268896)] = 3, -- Mind Rend
	[GetSpellInfo(268104)] = 3, -- Explosive Void
	[GetSpellInfo(267034)] = 3, -- Whispers of Power
	[GetSpellInfo(276268)] = 3, -- Heaving Blow
	[GetSpellInfo(264166)] = 3, -- Undertow
	[GetSpellInfo(264526)] = 3, -- Grasp of the Depths
	[GetSpellInfo(274633)] = 3, -- Sundering Blow
	[GetSpellInfo(268214)] = 3, -- Carving Flesh
	[GetSpellInfo(267818)] = 3, -- Slicing Blast
	[GetSpellInfo(268309)] = 3, -- Unending Darkness
	[GetSpellInfo(268317)] = 3, -- Rip Mind
	[GetSpellInfo(268391)] = 3, -- Mental Assault
	[GetSpellInfo(274720)] = 3, -- Abyssal Strike

	-- Siege of Boralus
	[GetSpellInfo(257168)] = 3, -- Cursed Slash
	[GetSpellInfo(272588)] = 3, -- Rotting Wounds
	[GetSpellInfo(272571)] = 3, -- Choking Waters
	[GetSpellInfo(274991)] = 3, -- Putrid Waters
	[GetSpellInfo(275835)] = 3, -- Stinging Venom Coating
	[GetSpellInfo(273930)] = 3, -- Hindering Cut
	[GetSpellInfo(257292)] = 3, -- Heavy Slash
	[GetSpellInfo(261428)] = 3, -- Hangman"s Noose
	[GetSpellInfo(256897)] = 3, -- Clamping Jaws
	[GetSpellInfo(272874)] = 3, -- Trample
	[GetSpellInfo(273470)] = 3, -- Gut Shot
	[GetSpellInfo(272834)] = 3, -- Viscous Slobber
	[GetSpellInfo(257169)] = 3, -- Terrifying Roar
	[GetSpellInfo(272713)] = 3, -- Crushing Slam

	-- Tol Dagor
	[GetSpellInfo(258128)] = 3, -- Debilitating Shout
	[GetSpellInfo(265889)] = 3, -- Torch Strike
	[GetSpellInfo(257791)] = 3, -- Howling Fear
	[GetSpellInfo(258864)] = 3, -- Suppression Fire
	[GetSpellInfo(257028)] = 3, -- Fuselighter
	[GetSpellInfo(258917)] = 3, -- Righteous Flames
	[GetSpellInfo(257777)] = 3, -- Crippling Shiv
	[GetSpellInfo(258079)] = 3, -- Massive Chomp
	[GetSpellInfo(258058)] = 3, -- Squeeze
	[GetSpellInfo(260016)] = 3, -- Itchy Bite
	[GetSpellInfo(257119)] = 3, -- Sand Trap
	[GetSpellInfo(260067)] = 3, -- Vicious Mauling
	[GetSpellInfo(258313)] = 3, -- Handcuff
	[GetSpellInfo(259711)] = 3, -- Lockdown
	[GetSpellInfo(256198)] = 3, -- Azerite Rounds: Incendiary
	[GetSpellInfo(256101)] = 3, -- Explosive Burst
	[GetSpellInfo(256044)] = 3, -- Deadeye
	[GetSpellInfo(256474)] = 3, -- Heartstopper Venom

	-- Waycrest Manor
	[GetSpellInfo(260703)] = 3, -- Unstable Runic Mark
	[GetSpellInfo(263905)] = 3, -- Marking Cleave
	[GetSpellInfo(265880)] = 3, -- Dread Mark
	[GetSpellInfo(265882)] = 3, -- Lingering Dread
	[GetSpellInfo(264105)] = 3, -- Runic Mark
	[GetSpellInfo(264050)] = 3, -- Infected Thorn
	[GetSpellInfo(261440)] = 3, -- Virulent Pathogen
	[GetSpellInfo(263891)] = 3, -- Grasping Thorns
	[GetSpellInfo(264378)] = 3, -- Fragment Soul
	[GetSpellInfo(266035)] = 3, -- Bone Splinter
	[GetSpellInfo(266036)] = 3, -- Drain Essence
	[GetSpellInfo(260907)] = 3, -- Soul Manipulation
	[GetSpellInfo(260741)] = 3, -- Jagged Nettles
	[GetSpellInfo(264556)] = 3, -- Tearing Strike
	[GetSpellInfo(265760)] = 3, -- Thorned Barrage
	[GetSpellInfo(260551)] = 3, -- Soul Thorns
	[GetSpellInfo(263943)] = 3, -- Etch
	[GetSpellInfo(265881)] = 3, -- Decaying Touch
	[GetSpellInfo(261438)] = 3, -- Wasting Strike
	[GetSpellInfo(268202)] = 3, -- Death Lens
	[GetSpellInfo(278456)] = 3, -- Infest

	-- Atal"Dazar
	[GetSpellInfo(252781)] = 3, -- Unstable Hex
	[GetSpellInfo(250096)] = 3, -- Wracking Pain
	[GetSpellInfo(250371)] = 3, -- Lingering Nausea
	[GetSpellInfo(253562)] = 3, -- Wildfire
	[GetSpellInfo(255582)] = 3, -- Molten Gold
	[GetSpellInfo(255041)] = 3, -- Terrifying Screech
	[GetSpellInfo(255371)] = 3, -- Terrifying Visage
	[GetSpellInfo(252687)] = 3, -- Venomfang Strike
	[GetSpellInfo(254959)] = 3, -- Soulburn
	[GetSpellInfo(255814)] = 3, -- Rending Maul
	[GetSpellInfo(255421)] = 3, -- Devour
	[GetSpellInfo(255434)] = 3, -- Serrated Teeth
	[GetSpellInfo(256577)] = 3, -- Soulfeast

	-- King's Rest
	[GetSpellInfo(270492)] = 3, -- Hex
	[GetSpellInfo(267763)] = 3, -- Wretched Discharge
	[GetSpellInfo(276031)] = 3, -- Pit of Despair
	[GetSpellInfo(265773)] = 3, -- Spit Gold
	[GetSpellInfo(270920)] = 3, -- Seduction
	[GetSpellInfo(270865)] = 3, -- Hidden Blade
	[GetSpellInfo(271564)] = 3, -- Embalming Fluid
	[GetSpellInfo(270507)] = 3, -- Poison Barrage
	[GetSpellInfo(267273)] = 3, -- Poison Nova
	[GetSpellInfo(270003)] = 3, -- Suppression Slam
	[GetSpellInfo(270084)] = 3, -- Axe Barrage
	[GetSpellInfo(267618)] = 3, -- Drain Fluids
	[GetSpellInfo(267626)] = 3, -- Dessication
	[GetSpellInfo(270487)] = 3, -- Severing Blade
	[GetSpellInfo(266238)] = 3, -- Shattered Defenses
	[GetSpellInfo(266231)] = 3, -- Severing Axe
	[GetSpellInfo(266191)] = 3, -- Whirling Axes
	[GetSpellInfo(272388)] = 3, -- Shadow Barrage
	[GetSpellInfo(271640)] = 3, -- Dark Revelation
	[GetSpellInfo(268796)] = 3, -- Impaling Spear

	-- Motherlode
	[GetSpellInfo(263074)] = 3, -- Festering Bite
	[GetSpellInfo(280605)] = 3, -- Brain Freeze
	[GetSpellInfo(257337)] = 3, -- Shocking Claw
	[GetSpellInfo(270882)] = 3, -- Blazing Azerite
	[GetSpellInfo(268797)] = 3, -- Transmute: Enemy to Goo
	[GetSpellInfo(259856)] = 3, -- Chemical Burn
	[GetSpellInfo(269302)] = 3, -- Toxic Blades
	[GetSpellInfo(280604)] = 3, -- Iced Spritzer
	[GetSpellInfo(257371)] = 3, -- Tear Gas
	[GetSpellInfo(257544)] = 3, -- Jagged Cut
	[GetSpellInfo(268846)] = 3, -- Echo Blade
	[GetSpellInfo(262794)] = 3, -- Energy Lash
	[GetSpellInfo(262513)] = 3, -- Azerite Heartseeker
	[GetSpellInfo(260829)] = 3, -- Homing Missle (travelling)
	[GetSpellInfo(260838)] = 3, -- Homing Missle (exploded)
	[GetSpellInfo(263637)] = 3, -- Clothesline

	-- Temple of Sethraliss
	[GetSpellInfo(269686)] = 3, -- Plague
	[GetSpellInfo(268013)] = 3, -- Flame Shock
	[GetSpellInfo(268008)] = 3, -- Snake Charm
	[GetSpellInfo(273563)] = 3, -- Neurotoxin
	[GetSpellInfo(272657)] = 3, -- Noxious Breath
	[GetSpellInfo(267027)] = 3, -- Cytotoxin
	[GetSpellInfo(272699)] = 3, -- Venomous Spit
	[GetSpellInfo(263371)] = 3, -- Conduction
	[GetSpellInfo(272655)] = 3, -- Scouring Sand
	[GetSpellInfo(263914)] = 3, -- Blinding Sand
	[GetSpellInfo(263958)] = 3, -- A Knot of Snakes
	[GetSpellInfo(266923)] = 3, -- Galvanize
	[GetSpellInfo(268007)] = 3, -- Heart Attack

	-- Underrot
	[GetSpellInfo(265468)] = 3, -- Withering Curse
	[GetSpellInfo(278961)] = 3, -- Decaying Mind
	[GetSpellInfo(259714)] = 3, -- Decaying Spores
	[GetSpellInfo(272180)] = 3, -- Death Bolt
	[GetSpellInfo(272609)] = 3, -- Maddening Gaze
	[GetSpellInfo(269301)] = 3, -- Putrid Blood
	[GetSpellInfo(265533)] = 3, -- Blood Maw
	[GetSpellInfo(265019)] = 3, -- Savage Cleave
	[GetSpellInfo(265377)] = 3, -- Hooked Snare
	[GetSpellInfo(265625)] = 3, -- Dark Omen
	[GetSpellInfo(260685)] = 3, -- Taint of G"huun
	[GetSpellInfo(266107)] = 3, -- Thirst for Blood
	[GetSpellInfo(260455)] = 3, -- Serrated Fangs

	-- Raids
	-- Uldir
	-- MOTHER
	[GetSpellInfo(268277)] = 3, -- Purifying Flame
	[GetSpellInfo(268253)] = 3, -- Surgical Beam
	[GetSpellInfo(268095)] = 3, -- Cleansing Purge
	[GetSpellInfo(267787)] = 3, -- Sundering Scalpel
	[GetSpellInfo(268198)] = 3, -- Clinging Corruption
	[GetSpellInfo(267821)] = 3, -- Defense Grid

	-- Vectis
	[GetSpellInfo(265127)] = 3, -- Lingering Infection
	[GetSpellInfo(265178)] = 3, -- Mutagenic Pathogen
	[GetSpellInfo(265206)] = 3, -- Immunosuppression
	[GetSpellInfo(265212)] = 3, -- Gestate
	[GetSpellInfo(265129)] = 3, -- Omega Vector
	[GetSpellInfo(267160)] = 3, -- Omega Vector
	[GetSpellInfo(267161)] = 3, -- Omega Vector
	[GetSpellInfo(267162)] = 3, -- Omega Vector
	[GetSpellInfo(267163)] = 3, -- Omega Vector
	[GetSpellInfo(267164)] = 3, -- Omega Vector

	-- Mythrax
	--[GetSpellInfo(272146)] = 3, -- Annihilation
	[GetSpellInfo(272536)] = 3, -- Imminent Ruin
	[GetSpellInfo(274693)] = 3, -- Essence Shear
	[GetSpellInfo(272407)] = 3, -- Oblivion Sphere

	-- Fetid Devourer
	[GetSpellInfo(262313)] = 3, -- Malodorous Miasma
	[GetSpellInfo(262292)] = 3, -- Rotting Regurgitation
	[GetSpellInfo(262314)] = 3, -- Deadly Disease

	-- Taloc
	[GetSpellInfo(270290)] = 3, -- Blood Storm
	[GetSpellInfo(275270)] = 3, -- Fixate
	[GetSpellInfo(271224)] = 3, -- Plasma Discharge
	[GetSpellInfo(271225)] = 3, -- Plasma Discharge

	-- Zul
	[GetSpellInfo(273365)] = 3, -- Dark Revelation
	[GetSpellInfo(273434)] = 3, -- Pit of Despair
	[GetSpellInfo(274195)] = 3, -- Corrupted Blood
	[GetSpellInfo(272018)] = 3, -- Absorbed in Darkness

	-- Zek'voz, Herald of N'zoth
	[GetSpellInfo(265237)] = 3, -- Shatter
	[GetSpellInfo(265264)] = 3, -- Void Lash
	[GetSpellInfo(265360)] = 3, -- Roiling Deceit
	[GetSpellInfo(265662)] = 3, -- Corruptor's Pact
	[GetSpellInfo(265646)] = 3, -- Will of the Corruptor

	-- G'huun
	[GetSpellInfo(263436)] = 3, -- Imperfect Physiology
	[GetSpellInfo(263227)] = 3, -- Putrid Blood
	[GetSpellInfo(263372)] = 3, -- Power Matrix
	[GetSpellInfo(272506)] = 3, -- Explosive Corruption
	[GetSpellInfo(267409)] = 3, -- Dark Bargain
	[GetSpellInfo(267430)] = 3, -- Torment
	[GetSpellInfo(263235)] = 3, -- Blood Feast
	[GetSpellInfo(270287)] = 3, -- Blighted Ground

	-- Siege of Zuldazar
	-- Ra'wani Kanae/Frida Ironbellows
	[GetSpellInfo(283573)] = 3, -- Sacred Blade
	[GetSpellInfo(283617)] = 3, -- Wave of Light
	[GetSpellInfo(283651)] = 3, -- Blinding Faith
	[GetSpellInfo(284595)] = 3, -- Penance
	[GetSpellInfo(283582)] = 3, -- Consecration

	-- Grong
	[GetSpellInfo(285998)] = 3, -- Ferocious Roar
	[GetSpellInfo(283069)] = 3, -- Megatomic Fire
	[GetSpellInfo(285671)] = 3, -- Crushed
	[GetSpellInfo(285875)] = 3, -- Rending Bite
	--[GetSpellInfo(282010)] = 3, -- Shaken

	-- Jaina
	[GetSpellInfo(285253)] = 3, -- Ice Shard
	[GetSpellInfo(287993)] = 3, -- Chilling Touch
	[GetSpellInfo(287365)] = 3, -- Searing Pitch
	[GetSpellInfo(288038)] = 3, -- Marked Target
	[GetSpellInfo(285254)] = 3, -- Avalanche
	[GetSpellInfo(287626)] = 3, -- Grasp of Frost
	[GetSpellInfo(287490)] = 3, -- Frozen Solid
	[GetSpellInfo(287199)] = 3, -- Ring of Ice
	[GetSpellInfo(288392)] = 3, -- Vengeful Seas

	-- Stormwall Blockade
	[GetSpellInfo(284369)] = 3, -- Sea Storm
	[GetSpellInfo(284410)] = 3, -- Tempting Song
	[GetSpellInfo(284405)] = 3, -- Tempting Song
	[GetSpellInfo(284121)] = 3, -- Thunderous Boom
	[GetSpellInfo(286680)] = 3, -- Roiling Tides

	-- Opulence
	[GetSpellInfo(286501)] = 3, -- Creeping Blaze
	[GetSpellInfo(283610)] = 3, -- Crush
	[GetSpellInfo(289383)] = 3, -- Chaotic Displacement
	[GetSpellInfo(285479)] = 3, -- Flame Jet
	[GetSpellInfo(283063)] = 3, -- Flames of Punishment
	[GetSpellInfo(283507)] = 3, -- Volatile Charge

	-- King Rastakhan
	[GetSpellInfo(284995)] = 3, -- Zombie Dust
	[GetSpellInfo(285349)] = 3, -- Plague of Fire
	[GetSpellInfo(285044)] = 3, -- Toad Toxin
	[GetSpellInfo(284831)] = 3, -- Scorching Detonation
	[GetSpellInfo(289858)] = 3, -- Crushed
	[GetSpellInfo(284662)] = 3, -- Seal of Purification
	[GetSpellInfo(284676)] = 3, -- Seal of Purification
	[GetSpellInfo(285178)] = 3, -- Serpent's Breath
	[GetSpellInfo(285010)] = 3, -- Poison Toad Slime

	-- Jadefire Masters
	[GetSpellInfo(282037)] = 3, -- Rising Flames
	[GetSpellInfo(284374)] = 3, -- Magma Trap
	[GetSpellInfo(285632)] = 3, -- Stalking
	[GetSpellInfo(288151)] = 3, -- Tested
	[GetSpellInfo(284089)] = 3, -- Successful Defense
	[GetSpellInfo(286988)] = 3, -- Searing Embers

	-- Mekkatorque
	[GetSpellInfo(288806)] = 3, -- Gigavolt Blast
	[GetSpellInfo(289023)] = 3, -- Enormous
	[GetSpellInfo(286646)] = 3, -- Gigavolt Charge
	[GetSpellInfo(288939)] = 3, -- Gigavolt Radiation
	[GetSpellInfo(284168)] = 3, -- Shrunk
	[GetSpellInfo(286516)] = 3, -- Anti-Tampering Shock
	[GetSpellInfo(286480)] = 3, -- Anti-Tampering Shock
	[GetSpellInfo(284214)] = 3, -- Trample

	-- Conclave of the Chosen
	[GetSpellInfo(284663)] = 3, -- Bwonsamdi's Wrath
	[GetSpellInfo(282444)] = 3, -- Lacerating Claws
	[GetSpellInfo(282592)] = 3, -- Bleeding Wounds
	[GetSpellInfo(282209)] = 3, -- Mark of Prey
	[GetSpellInfo(285879)] = 3, -- Mind Wipe
	[GetSpellInfo(282135)] = 3, -- Crawling Hex
	[GetSpellInfo(286060)] = 3, -- Cry of the Fallen
	[GetSpellInfo(282447)] = 3, -- Kimbul's Wrath
	[GetSpellInfo(282834)] = 3, -- Kimbul's Wrath
	[GetSpellInfo(286811)] = 3, -- Akunda's Wrath
	[GetSpellInfo(286838)] = 3, -- Static Orb

	-- Legion Raids
	-- Antorus, the Burning Throne
	-- Garothi Worldbreaker
	[GetSpellInfo(244590)] = 3, -- Molten Hot Fel
	[GetSpellInfo(244761)] = 3, -- Annihilation
	[GetSpellInfo(246920)] = 3, -- Haywire Decimation
	[GetSpellInfo(246369)] = 3, -- Searing Barrage
	[GetSpellInfo(246848)] = 3, -- Luring Destruction
	[GetSpellInfo(246220)] = 3, -- Fel Bombardment
	[GetSpellInfo(247159)] = 3, -- Luring Destruction
	[GetSpellInfo(244122)] = 3, -- Carnage
	[GetSpellInfo(244410)] = 3, -- Decimation
	[GetSpellInfo(245294)] = 3, -- Empowered Decimation
	[GetSpellInfo(246368)] = 3, -- Searing Barrage

	-- Felhounds of Sargeras
	[GetSpellInfo(245022)] = 3, -- Burning Remnant
	[GetSpellInfo(251445)] = 3, -- Smouldering
	[GetSpellInfo(251448)] = 3, -- Burning Maw
	[GetSpellInfo(244086)] = 5, -- Molten Touch
	[GetSpellInfo(244091)] = 3, -- Singed
	[GetSpellInfo(244768)] = 3, -- Desolate Gaze
	[GetSpellInfo(244767)] = 3, -- Desolate Path
	[GetSpellInfo(244471)] = 4, -- Enflame Corruption
	[GetSpellInfo(248815)] = 4, -- Enflamed
	[GetSpellInfo(244517)] = 3, -- Lingering Flames
	[GetSpellInfo(245098)] = 3, -- Decay
	[GetSpellInfo(251447)] = 3, -- Corrupting Maw
	[GetSpellInfo(244131)] = 3, -- Consuming Sphere
	[GetSpellInfo(245024)] = 3, -- Consumed
	[GetSpellInfo(244071)] = 3, -- Weight of Darkness
	[GetSpellInfo(244578)] = 3, -- Siphon Corruption
	[GetSpellInfo(248819)] = 3, -- Siphoned
	[GetSpellInfo(254429)] = 3, -- Weight of Darkness
	[GetSpellInfo(244072)] = 3, -- Molten Touch

	-- Antoran High Command
	[GetSpellInfo(245121)] = 3, -- Entropic Blast
	[GetSpellInfo(244748)] = 3, -- Shocked
	[GetSpellInfo(244824)] = 3, -- Warp Field
	[GetSpellInfo(244892)] = 3, -- Exploit Weakness
	[GetSpellInfo(244172)] = 3, -- Psychic Assault
	[GetSpellInfo(244388)] = 3, -- Psychic Scarring
	[GetSpellInfo(244420)] = 3, -- Chaos Pulse
	[GetSpellInfo(254771)] = 3, -- Disruption Field
	[GetSpellInfo(257974)] = 5, -- Chaos Pulse
	[GetSpellInfo(244910)] = 3, -- Felshield
	[GetSpellInfo(244737)] = 6, -- Shock Grenade

	-- Portal Keeper Hasabel
	[GetSpellInfo(244016)] = 3, -- Reality Tear
	[GetSpellInfo(245157)] = 3, -- Everburning Light
	[GetSpellInfo(245075)] = 3, -- Hungering Gloom
	[GetSpellInfo(245240)] = 3, -- Oppressive Gloom
	[GetSpellInfo(244709)] = 3, -- Fiery Detonation
	[GetSpellInfo(246208)] = 3, -- Acidic Web
	[GetSpellInfo(246075)] = 3, -- Catastrophic Implosion
	[GetSpellInfo(244826)] = 3, -- Fel Miasma
	[GetSpellInfo(246316)] = 3, -- Poison Essence
	[GetSpellInfo(244849)] = 3, -- Caustic Slime
	[GetSpellInfo(245118)] = 3, -- Cloying Shadows
	[GetSpellInfo(245050)] = 3, -- Delusions
	[GetSpellInfo(245040)] = 3, -- Corrupt
	[GetSpellInfo(244607)] = 3, -- Flames of Xoroth
	[GetSpellInfo(244915)] = 3, -- Leech Essence
	[GetSpellInfo(244926)] = 3, -- Felsilk Wrap
	[GetSpellInfo(244949)] = 3, -- Felsilk Wrap
	[GetSpellInfo(244613)] = 3, -- Everburning Flames

	-- Eonar the Life-Binder
	[GetSpellInfo(248326)] = 3, -- Rain of Fel
	[GetSpellInfo(248861)] = 5, -- Spear of Doom
	[GetSpellInfo(249016)] = 3, -- Feedback - Targeted
	[GetSpellInfo(249015)] = 3, -- Feedback - Burning Embers
	[GetSpellInfo(249014)] = 3, -- Feedback - Foul Steps
	[GetSpellInfo(249017)] = 3, -- Feedback - Arcane Singularity
	[GetSpellInfo(250693)] = 3, -- Arcane Buildup
	[GetSpellInfo(250691)] = 3, -- Burning Embers
	[GetSpellInfo(248795)] = 3, -- Fel Wake
	[GetSpellInfo(248332)] = 4, -- Rain of Fel
	[GetSpellInfo(250140)] = 3, -- Foul Steps

	-- Imonar the Soulhunter
	[GetSpellInfo(248424)] = 3, -- Gathering Power
	[GetSpellInfo(247552)] = 5, -- Sleep Canister
	[GetSpellInfo(247565)] = 5, -- Slumber Gas
	[GetSpellInfo(250224)] = 3, -- Shocked
	[GetSpellInfo(248252)] = 3, -- Infernal Rockets
	[GetSpellInfo(247687)] = 3, -- Sever
	[GetSpellInfo(247716)] = 3, -- Charged Blasts
	[GetSpellInfo(247367)] = 4, -- Shock Lance
	[GetSpellInfo(250255)] = 3, -- Empowered Shock Lance
	[GetSpellInfo(247641)] = 4, -- Stasis Trap
	[GetSpellInfo(255029)] = 5, -- Sleep Canister
	[GetSpellInfo(248321)] = 3, -- Conflagration
	[GetSpellInfo(247932)] = 3, -- Shrapnel Blast
	[GetSpellInfo(248070)] = 3, -- Empowered Shrapnel Blast
	[GetSpellInfo(254183)] = 5, -- Seared Skin

	-- Kin'garoth
	[GetSpellInfo(233062)] = 3, -- Infernal Burning
	[GetSpellInfo(230345)] = 3, -- Crashing Comet
	[GetSpellInfo(244312)] = 5, -- Forging Strike
	[GetSpellInfo(246840)] = 3, -- Ruiner
	[GetSpellInfo(248061)] = 3, -- Purging Protocol
	[GetSpellInfo(249686)] = 3, -- Reverberating Decimation
	[GetSpellInfo(246706)] = 6, -- Demolish
	[GetSpellInfo(246698)] = 6, -- Demolish
	[GetSpellInfo(245919)] = 3, -- Meteor Swarm
	[GetSpellInfo(245770)] = 3, -- Decimation

	-- Varimathras
	[GetSpellInfo(244042)] = 5, -- Marked Prey
	[GetSpellInfo(243961)] = 5, -- Misery
	[GetSpellInfo(248732)] = 3, -- Echoes of Doom
	[GetSpellInfo(243973)] = 3, -- Torment of Shadows
	[GetSpellInfo(244005)] = 3, -- Dark Fissure
	[GetSpellInfo(244093)] = 6, -- Necrotic Embrace
	[GetSpellInfo(244094)] = 6, -- Necrotic Embrace

	-- The Coven of Shivarra
	[GetSpellInfo(244899)] = 4, -- Fiery Strike
	[GetSpellInfo(245518)] = 4, -- Flashfreeze
	[GetSpellInfo(245586)] = 5, -- Chilled Blood
	[GetSpellInfo(246763)] = 3, -- Fury of Golganneth
	[GetSpellInfo(245674)] = 3, -- Flames of Khaz'goroth
	[GetSpellInfo(245671)] = 3, -- Flames of Khaz'goroth
	[GetSpellInfo(245910)] = 3, -- Spectral Army of Norgannon
	[GetSpellInfo(253520)] = 3, -- Fulminating Pulse
	[GetSpellInfo(245634)] = 3, -- Whirling Saber
	[GetSpellInfo(253020)] = 3, -- Storm of Darkness
	[GetSpellInfo(245921)] = 3, -- Spectral Army of Norgannon
	[GetSpellInfo(250757)] = 3, -- Cosmic Glare

	-- Aggramar
	[GetSpellInfo(244291)] = 3, -- Foe Breaker
	[GetSpellInfo(255060)] = 3, -- Empowered Foe Breaker
	[GetSpellInfo(245995)] = 4, -- Scorching Blaze
	[GetSpellInfo(246014)] = 3, -- Searing Tempest
	[GetSpellInfo(244912)] = 3, -- Blazing Eruption
	[GetSpellInfo(247135)] = 3, -- Scorched Earth
	[GetSpellInfo(247091)] = 3, -- Catalyzed
	[GetSpellInfo(245631)] = 3, -- Unchecked Flame
	[GetSpellInfo(245916)] = 3, -- Molten Remnants
	[GetSpellInfo(245990)] = 4, -- Taeshalach's Reach
	[GetSpellInfo(254452)] = 3, -- Ravenous Blaze
	[GetSpellInfo(244736)] = 3, -- Wake of Flame
	[GetSpellInfo(247079)] = 3, -- Empowered Flame Rend

	-- Argus the Unmaker
	[GetSpellInfo(251815)] = 3, -- Edge of Obliteration
	[GetSpellInfo(248499)] = 4, -- Sweeping Scythe
	[GetSpellInfo(250669)] = 5, -- Soulburst
	[GetSpellInfo(251570)] = 6, -- Soulbomb
	[GetSpellInfo(248396)] = 6, -- Soulblight
	[GetSpellInfo(258039)] = 3, -- Deadly Scythe
	[GetSpellInfo(252729)] = 3, -- Cosmic Ray
	[GetSpellInfo(256899)] = 4, -- Soul Detonation
	[GetSpellInfo(252634)] = 4, -- Cosmic Smash
	[GetSpellInfo(252616)] = 4, -- Cosmic Beacon
	[GetSpellInfo(255200)] = 3, -- Aggramar's Boon
	[GetSpellInfo(255199)] = 4, -- Avatar of Aggramar
	[GetSpellInfo(258647)] = 3, -- Gift of the Sea
	[GetSpellInfo(253901)] = 3, -- Strength of the Sea
	[GetSpellInfo(257299)] = 4, -- Ember of Rage
	[GetSpellInfo(248167)] = 3, -- Death Fog
	[GetSpellInfo(258646)] = 3, -- Gift of the Sky
	[GetSpellInfo(253903)] = 3, -- Strength of the Sky

	-- Legion Dungeon
	-- Mythic+ Affixes
	[GetSpellInfo(221772)] = 5, -- Overflowing
	[GetSpellInfo(209858)] = 5, -- Necrotic
	[GetSpellInfo(226512)] = 5, -- Sanguine
	-- Black Rook Hold
	-- Trash Mobs
	[GetSpellInfo(194969)] = 3, -- Soul Echoes
	[GetSpellInfo(225962)] = 3, -- Bloodthirsty Leap
	[GetSpellInfo(200261)] = 3, -- Bonebreaking Strike
	[GetSpellInfo(222397)] = 3, -- Boulder Crush
	[GetSpellInfo(214001)] = 3, -- Raven's Dive
	-- Illysanna Ravencrest
	[GetSpellInfo(197546)] = 3, -- Brutal Glaive
	[GetSpellInfo(197484)] = 3, -- Dark Rush
	[GetSpellInfo(197687)] = 4, -- Eye Beams
	-- Smashspite
	[GetSpellInfo(198446)] = 3, -- Fel Vomit
	[GetSpellInfo(198245)] = 3, -- Brutal Haymaker
	-- Lord Ravencrest
	[GetSpellInfo(201733)] = 3, -- Stinging Swarm
	-- Court of Stars
	-- Trash Mobs
	[GetSpellInfo(209413)] = 3, -- Suppress
	[GetSpellInfo(209512)] = 3, -- Disrupting Energy
	[GetSpellInfo(211473)] = 3, -- Shadow Slash
	[GetSpellInfo(211464)] = 3, -- Fel Detonation
	[GetSpellInfo(207980)] = 3, -- Disintegration Beam
	[GetSpellInfo(207979)] = 3, -- Shockwave
	-- Advisor Melandrus
	[GetSpellInfo(209602)] = 3, -- Blade Surge
	[GetSpellInfo(224333)] = 4, -- Enveloping Winds
	-- Darkheart Thicket
	-- Trash Mobs
	[GetSpellInfo(200620)] = 3, -- Frantic Rip
	[GetSpellInfo(225484)] = 3, -- Grievous Rip
	[GetSpellInfo(200631)] = 4, -- Unnerving Screech
	[GetSpellInfo(201400)] = 3, -- Dread Inferno
	[GetSpellInfo(201361)] = 4, -- Darksoul Bite
	-- Archdruid Glaidalis
	[GetSpellInfo(198408)] = 4, -- Nightfall
	[GetSpellInfo(196376)] = 3, -- Grievous Tear
	-- Shade of Xavius
	[GetSpellInfo(200289)] = 4, -- Growing Paranoia
	[GetSpellInfo(200329)] = 4, -- Overwhelming Terror
	[GetSpellInfo(200238)] = 3, -- Feed on the Weak
	-- Eye of Azshara
	-- Trash Mobs
	[GetSpellInfo(196111)] = 4, -- Jagged Claws
	[GetSpellInfo(195561)] = 3, -- Blinding Peck
	-- Warlord Parjesh
	[GetSpellInfo(192094)] = 3, -- Impaling Spear
	-- Serpentrix
	[GetSpellInfo(191855)] = 3, -- Toxic Wound
	[GetSpellInfo(191858)] = 4, -- Toxic Puddle
	-- King Deepbeard
	[GetSpellInfo(193018)] = 3, -- Gaseous Bubbles
	-- Wrath of Azshara
	[GetSpellInfo(197365)] = 4, -- Crushing Depths
	[GetSpellInfo(192706)] = 3, -- Arcane Bomb
	-- Halls of Valor
	-- Trash Mobs
	[GetSpellInfo(198605)] = 3, -- Thunderstrike
	[GetSpellInfo(199805)] = 3, -- Crackle
	[GetSpellInfo(199050)] = 3, -- Mortal Hew
	[GetSpellInfo(199341)] = 3, -- Bear Trap
	[GetSpellInfo(196194)] = 3, -- Raven's Dive
	[GetSpellInfo(199674)] = 3, -- Wicked Dagger
	-- Hymdall
	[GetSpellInfo(193092)] = 3, -- Bloodletting Sweep
	-- Hyrja
	[GetSpellInfo(192048)] = 3, -- Expel Light
	-- Fenryr
	[GetSpellInfo(197556)] = 4, -- Ravenous Leap
	[GetSpellInfo(196838)] = 3, -- Scent of Blood
	[GetSpellInfo(196497)] = 4, -- Ravenous Leap
	-- Odyn
	[GetSpellInfo(198088)] = 4, -- Glowing Fragment
	-- Maw of Souls
	-- Trash Mobs
	[GetSpellInfo(201566)] = 3, -- Swirling Muck
	[GetSpellInfo(191960)] = 5, -- Barbed Spear
	[GetSpellInfo(199061)] = 4, -- Hew Soul
	[GetSpellInfo(222397)] = 4, -- Breach Armor
	[GetSpellInfo(201397)] = 4, -- Brackwater Blast
	[GetSpellInfo(194102)] = 4, -- Poisonous Sludge
	-- Harbaron
	[GetSpellInfo(194325)] = 3, -- Fragment
	[GetSpellInfo(194235)] = 4, -- Nether Rip
	-- Helya
	[GetSpellInfo(185539)] = 3, -- Rapid Rupture
	-- Neltharion's Lair
	-- Trash Mobs
	[GetSpellInfo(226296)] = 3, -- Piercing Shards
	[GetSpellInfo(193639)] = 4, -- Bone Chomp
	[GetSpellInfo(202181)] = 3, -- Stone Gaze
	[GetSpellInfo(186616)] = 3, -- Petrified
	[GetSpellInfo(202231)] = 3, -- Leech
	[GetSpellInfo(200154)] = 4, -- Burning Hatred
	[GetSpellInfo(193585)] = 3, -- Bound
	-- Rokmora
	[GetSpellInfo(192799)] = 3, -- Choking Dust
	-- Naraxas
	[GetSpellInfo(205549)] = 3, -- Rancid Maw
	-- The Arcway
	-- Trash Mobs
	[GetSpellInfo(202156)] = 4, -- Corrosion
	[GetSpellInfo(202223)] = 4, -- Consume
	[GetSpellInfo(194006)] = 4, -- Ooze Puddle
	[GetSpellInfo(210688)] = 3, -- Collapsing Rift
	[GetSpellInfo(226269)] = 3, -- Torment
	[GetSpellInfo(211756)] = 3, -- Searing Wound
	[GetSpellInfo(211217)] = 3, -- Arcane Slicer
	[GetSpellInfo(211543)] = 3, -- Devour
	-- Corstilax
	[GetSpellInfo(195791)] = 3, -- Quarantine
	-- Ivanyr
	[GetSpellInfo(196804)] = 3, -- Nether Link
	[GetSpellInfo(196562)] = 3, -- Volatile Magic
	-- Nal'tira
	[GetSpellInfo(200040)] = 4, -- Nether Venom
	[GetSpellInfo(200227)] = 3, -- Tangled Web
	-- Advisor Vandros
	[GetSpellInfo(220871)] = 3, -- Unstable Mana
	-- Vault of the Wardens
	-- Trash Mobs
	[GetSpellInfo(191735)] = 3, -- Deafening Screech
	[GetSpellInfo(210202)] = 4, -- Foul Stench
	[GetSpellInfo(202658)] = 3, -- Drain
	[GetSpellInfo(193164)] = 3, -- Gift of the Doomsayer
	[GetSpellInfo(202615)] = 3, -- Torment
	[GetSpellInfo(193969)] = 3, -- Razors
	-- Inquisitor Tormentorum
	[GetSpellInfo(201488)] = 3, -- Frightening Shout
	[GetSpellInfo(225416)] = 3, -- Intercept
	[GetSpellInfo(214804)] = 3, -- Seed of Corruption
	[GetSpellInfo(201488)] = 3, -- Frightening Shout
	-- Glazer
	[GetSpellInfo(194945)] = 3, -- Lingering Gaze
	-- Ash'Golm
	[GetSpellInfo(192519)] = 3, -- Lava
	-- Cordana Felsong
	[GetSpellInfo(197541)] = 3, -- Detonation
	[GetSpellInfo(213583)] = 4, -- Deepening Shadows
	-- Violet Hold
	-- Trash Mobs
	[GetSpellInfo(204608)] = 3, -- Fel Prison
	[GetSpellInfo(204901)] = 3, -- Carrion Swarm
	[GetSpellInfo(205097)] = 3, -- Fel Blind
	[GetSpellInfo(205096)] = 3, -- Fel Poison
	-- Anub'esset
	[GetSpellInfo(202217)] = 3, -- Mandible Strike
	-- Blood-Princess Thal'ena
	[GetSpellInfo(202779)] = 3, -- Essence of the Blood Princess
	-- Millificent Manastorm
	[GetSpellInfo(201159)] = 3, -- Delta Finger Laser X-treme
	-- Mindflayer Kaahrj
	[GetSpellInfo(197783)] = 3, -- Shadow Crash
	-- Shivermaw
	[GetSpellInfo(201960)] = 3, -- Ice Bomb
	[GetSpellInfo(202062)] = 3, -- Frigid Winds
	-- Lord Malgath
	[GetSpellInfo(204962)] = 3, -- Shadow Bomb
	-- Return to Karazhan
	[GetSpellInfo(227404)] = 3, -- Intangible Presence
	-- Other
	[GetSpellInfo(87023)] = 4, -- Cauterize
	[GetSpellInfo(94794)] = 4, -- Rocket Fuel Leak
	[GetSpellInfo(116888)] = 4, -- Shroud of Purgatory
	[GetSpellInfo(121175)] = 2, -- Orb of Power
}
