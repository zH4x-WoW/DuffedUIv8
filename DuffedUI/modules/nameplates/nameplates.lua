local D, C, L = unpack(select(2, ...))
if C["nameplate"].active ~= true then return end

local Plates = CreateFrame("Frame", "Plates", UIParent)

local Font = C["media"].font
local _G = _G
local UnitGUID = UnitGUID
local GetTime = GetTime
local GetSpellInfo = GetSpellInfo
local GetRaidTargetIndex = GetRaidTargetIndex
local UnitPlayerControlled = UnitPlayerControlled
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local UnitDebuff = UnitDebuff
local UnitExists = UnitExists
local UnitIsFriend = UnitIsFriend
local UnitIsUnit = UnitIsUnit
local UnitName = UnitName
local UnitPlayerControlled = UnitPlayerControlled
local UnitLevel = UnitLevel
local GetCVar = GetCVar
local SetCVar = SetCVar
local band = bit.band
local strsplit = strsplit
local match = string.match
local wipe = table.wipe
local tonumber = tonumber
local tostring = tostring
local GetNumGroupMembers = GetNumGroupMembers
local GetNumBattlefieldScores = GetNumBattlefieldScores
local GetSpellTexture = GetSpellTexture
local IsInInstance = IsInInstance
local select = select
local nop = function() end

local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local FACTION_BAR_COLORS = FACTION_BAR_COLORS

local playerFaction = select(1, UnitFactionGroup("player")) == "Horde" and 1 or 0
local playerGUID = UnitGUID("player")
local mult = 768/match(GetCVar("gxResolution"), "%d+x(%d+)")
local noscalemult = D.mult * C["general"].uiscale

local ScheduleFrame = CreateFrame("Frame", "ScheduleFrame", UIParent)
local ScheduleFrameActive = false
local timeToUpdate = 0

local fadeIn = function(obj) if obj == nil then return end UIFrameFadeIn(obj, .2, obj:GetAlpha(), 1) end
local fadeOut = function(obj) if obj == nil then return end UIFrameFadeIn(obj, .2, obj:GetAlpha(), 0) end

local fixvalue = function(val)
	if(val >= 1e6) then
		return ("%.2f"..SECOND_NUMBER_CAP):format(val / 1e6):gsub("%.?0+(["..FIRST_NUMBER_CAP..SECOND_NUMBER_CAP.."])$", "%1")
	elseif(val >= 1e4) then
		return ("%.1f"..FIRST_NUMBER_CAP):format(val / 1e3):gsub("%.?0+(["..FIRST_NUMBER_CAP..SECOND_NUMBER_CAP.."])$", "%1")
	else
		return val
	end
end

local FilterSpellsCashe = {}
local NamePlateList = {}
local GroupMembersList = {}
local AuraDurationsCache = {}
local DebuffCache = {}
local GroupTargetList = {}
local RaidIconGUID = {}
local NameClasses = {}
local NameGUID = {}
local AuraList = {}
local Aura_Spellid = {}
local Aura_Expiration = {}
local Aura_Stacks = {}
local Aura_Caster = {}
local Aura_Duration = {}
local Aura_Texture = {}
local IconFrameList = {}
local GUIDIgnoreCast = {}

local RaidIconCoordinates = {
	[0] = {[0] = "STAR", [.25] = "MOON",},
	[.25] = {[0] = "CIRCLE", [.25] = "SQUARE",},
	[.5] = {[0] = "DIAMOND", [.25] = "CROSS",},
	[.75] = {[0] = "TRIANGLE", [.25] = "SKULL",}, 
}

local RaidTargetMask = {STAR = 0x00000001, CIRCLE = 0x00000002, DIAMOND = 0x00000004, TRIANGLE = 0x00000008, MOON = 0x00000010, SQUARE = 0x00000020, CROSS = 0x00000040, SKULL = 0x00000080,}
local RaidIconIndex = {"STAR", "CIRCLE", "DIAMOND", "TRIANGLE", "MOON", "SQUARE", "CROSS", "SKULL",}

local ScheduleHide = function(frame, elapsed)
	if elapsed == 0 then 
		frame:Hide()
		IconFrameList[frame] = nil
	else
		IconFrameList[frame] = elapsed
		frame:Show()
		if not ScheduleFrameActive then 
			if ScheduleFrame.onupdate == nil then
				ScheduleFrame.onupdate = function(self)
					local curTime = GetTime()
					if curTime < timeToUpdate then return end
					local framecount = 0
					timeToUpdate = curTime + 1
					for frame, elapsed in pairs(IconFrameList) do
						if elapsed < curTime then 
							Plates:UpdateAuraWidget(frame:GetParent(), frame:GetParent().guid)
							frame:Hide() 
							IconFrameList[frame] = nil
						else 
							if frame.Poll then frame.Poll(frame, elapsed) end
							framecount = framecount + 1 
						end
					end
					if framecount == 0 then ScheduleFrame:SetScript("OnUpdate", nil) ScheduleFrameActive = false end
				end
			end
			ScheduleFrame:SetScript("OnUpdate", ScheduleFrame.onupdate)
			ScheduleFrameActive = true
		end
	end
end

local function CreateVirtualFrame(parent, point)
	if point == nil then point = parent end
	if point.backdrop then return end

	parent.backdrop = parent:CreateTexture(nil, "BORDER")
	parent.backdrop:SetDrawLayer("BORDER", -8)
	parent.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 3, noscalemult * 3)
	parent.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult * 3, -noscalemult * 3)
	parent.backdrop:SetTexture(unpack(C["media"]["backdropcolor"]))

	parent.bordertop = parent:CreateTexture(nil, "BORDER")
	parent.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 2, noscalemult * 2)
	parent.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult * 2, noscalemult * 2)
	parent.bordertop:SetHeight(noscalemult)
	parent.bordertop:SetTexture(unpack(C["media"].bordercolor))
	parent.bordertop:SetDrawLayer("BORDER", -7)

	parent.borderbottom = parent:CreateTexture(nil, "BORDER")
	parent.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -noscalemult * 2, -noscalemult * 2)
	parent.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", noscalemult * 2, -noscalemult * 2)
	parent.borderbottom:SetHeight(noscalemult)
	parent.borderbottom:SetTexture(unpack(C["media"].bordercolor))
	parent.borderbottom:SetDrawLayer("BORDER", -7)

	parent.borderleft = parent:CreateTexture(nil, "BORDER")
	parent.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -noscalemult * 2, noscalemult * 2)
	parent.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", noscalemult * 2, -noscalemult * 2)
	parent.borderleft:SetWidth(noscalemult)
	parent.borderleft:SetTexture(unpack(C["media"].bordercolor))
	parent.borderleft:SetDrawLayer("BORDER", -7)

	parent.borderright = parent:CreateTexture(nil, "BORDER")
	parent.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", noscalemult * 2, noscalemult * 2)
	parent.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -noscalemult * 2, -noscalemult * 2)
	parent.borderright:SetWidth(noscalemult)
	parent.borderright:SetTexture(unpack(C["media"].bordercolor))
	parent.borderright:SetDrawLayer("BORDER", -7)
end

local GetTargetNameplate = function()
	if not UnitExists("target") then return end
	for frame, _ in pairs(NamePlateList) do
		if frame.guid == UnitGUID("target") then return frame end
	end
end

local UpdateLevel = function(self)
	if self.oldlevel == nil then return end
	if self.oldelite == nil then return end
	if self.oldboss == nil then return end
	if self.health == nil then return end
	if self.health.name == nil then return end

	local level, elite, mylevel = tonumber(self.oldlevel:GetText()), self.oldelite:IsShown(), UnitLevel("player")
	self.rare:SetTextColor(self.oldlevel:GetTextColor())

	if self.oldboss:IsShown() then
		self.health.name:SetText("|cffCC0D00" .. ("??") .. "|r " .. self.oldname:GetText())
		self.rare:Show()
	elseif elite then
		local colr = GetQuestDifficultyColor(level)
		self.health.name:SetText(D.RGBToHex(colr.r, colr.g, colr.b) .. level .. (elite and "+") .. "|r " .. self.oldname:GetText())
		self.rare:Show()
	elseif not elite and level == mylevel then
		self.rare:Hide()
		return
	elseif level then
		self.rare:Hide()
		local colr = GetQuestDifficultyColor(level)
		self.health.name:SetText(D.RGBToHex(colr.r, colr.g, colr.b) .. level .. (elite and "+" or "") .. "|r " .. self.oldname:GetText())
	end	
end

local UpdateCastbarColor = function(self)
	if self.castbar == nil then return end
	if self.castbar.shield == nil then return end
	if self.castbar.shield:IsShown() then self.castbar:SetStatusBarColor(.78, .25, .25, 1) else self.castbar:SetStatusBarColor(1, .82, 0) end
end

local UpdateColor = function(self)
	if self.oldhealth == nil then return end
	local r, g, b = self.oldhealth:GetStatusBarColor()

	for class, color in pairs(RAID_CLASS_COLORS) do
		local r, g, b = floor(r * 100 + .5) / 100, floor(g * 100 + .5) / 100, floor(b * 100 + .5) / 100
		if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
			self.hasClass = true
			self.isFriendly = false
			self.health:SetStatusBarColor(unpack(oUFDuffedUI.colors.class[class]))
			return
		end
	end

	if g + b == 0 then
		r, g, b = .87, .37, .37
		self.isFriendly = false
	elseif r + b == 0 then
		r, g, b = .31, .45, .63
		self.isFriendly = true
	elseif r + g > 1.95 then
		r, g, b = .86, .77, .36
		self.isFriendly = false
	elseif r + g == 0 then
		r, g, b = .29,  .69, .3
		self.isFriendly = true
	else
		self.isFriendly = false
	end
	self.hasClass = false
	self.health:SetStatusBarColor(r, g, b)
end

local UpdateIcon = function(self, texture, expiration, stacks)
	if self and texture and expiration then
		self.icon:SetTexture(texture)
		if stacks > 1 then self.stack:SetText(stacks) else self.stack:SetText("") end
		local timeleft = ceil(expiration - GetTime())
		if timeleft > 60 then self.expired:SetText(ceil(timeleft / 60) .. "m") else self.expired:SetText(ceil(timeleft)) end
		self:Show()
		ScheduleHide(self, expiration)
	else
		ScheduleHide(self, 0)
	end
end

function Plates:UpdateAuraWidget(self, guid)
	local widget = self.AuraWidget
	if not widget then return end
	local AuraIconFrames = widget.AuraIconFrames
	local AurasOnUnit = AuraList[guid]
	local AuraSlotIndex = 1
	local instanceid

	DebuffCache = wipe(DebuffCache)
	local debuffCount = 0
	if AurasOnUnit then
		widget:Show()
		for instanceid in pairs(AurasOnUnit) do
			local aura = {}
			local aura_instance_id = guid..instanceid
			aura.spellid, aura.expiration, aura.stacks, aura.caster, aura.duration, aura.texture, aura.type, aura.target = Aura_Spellid[aura_instance_id], Aura_Expiration[aura_instance_id], Aura_Stacks[aura_instance_id], Aura_Caster[aura_instance_id], Aura_Duration[aura_instance_id], Aura_Texture[aura_instance_id]
			if tonumber(aura.spellid) then
				aura.name = GetSpellInfo(tonumber(aura.spellid))
				aura.unit = self.unit
				if aura.expiration > GetTime() then
					debuffCount = debuffCount + 1
					DebuffCache[debuffCount] = aura
				end
			end
		end
	end

	if debuffCount > 0 then 
		for index = 1, #DebuffCache do
			local cachedaura = DebuffCache[index]
			if cachedaura.spellid and cachedaura.expiration then 
				UpdateIcon(AuraIconFrames[AuraSlotIndex], cachedaura.texture, cachedaura.expiration, cachedaura.stacks) 
				AuraSlotIndex = AuraSlotIndex + 1
			end
			if AuraSlotIndex > C["nameplate"].MaxDebuffs then break end
		end
	end
	for AuraSlotIndex = AuraSlotIndex, C["nameplate"].MaxDebuffs do UpdateIcon(AuraIconFrames[AuraSlotIndex]) end
	DebuffCache = wipe(DebuffCache)
end

local CreateAuraIcon = function(parent)
	local button = CreateFrame("Frame", nil, parent)
	button:Hide()

	button:SetSize(C["nameplate"].auraswidth, C["nameplate"].aurasheight)
	button:SetScript("OnHide", function() if parent.guid then Plates:UpdateAuraWidget(parent, parent.guid) end end)

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetTexture(unpack(C["media"].backdropcolor))
	button.bg:SetAllPoints(button)

	button:SetTemplate()

	button.icon = button:CreateTexture(nil, "BORDER")
	button.icon:SetTexCoord(unpack(D.IconCoord))
	button.icon:SetSize(C["nameplate"].auraswidth - mult * 4, C["nameplate"].aurasheight - mult * 4)
	button.icon:SetPoint("CENTER")

	button.expired = button:CreateFontString(nil, "OVERLAY")
	button.expired:SetFont(Font, 9, "THINOUTLINE")
	button.expired:SetTextColor(.85, .89, .25)
	button.expired:SetJustifyH("CENTER")
	button.expired:SetPoint("TOP", 1, 3)

	button.stack = button:CreateFontString(nil, "OVERLAY")
	button.stack:SetFont(Font, 9, "THINOUTLINE")
	button.stack:SetTextColor(.85, .89, .25)
	button.stack:SetJustifyH("CENTER")
	button.stack:SetPoint("BOTTOM", button, "BOTTOM", 1, -3)

	button.Poll = parent.PollFunction
	return button
end

local VirtualSetAura = function(guid, spellid, expiration, stacks, caster, duration, texture)
	local filter = false
	if (caster == playerGUID) then filter = true end
	if #FilterSpellsCashe > 0 then filter = FilterSpellsCashe[spellid] ~= nil end
	if filter ~= true then return end

	if guid and spellid and caster and texture then
		local aura_id = spellid .. (tostring(caster or "UNKNOWN_CASTER"))
		local aura_instance_id = guid..aura_id
		AuraList[guid] = AuraList[guid] or {}
		AuraList[guid][aura_id] = aura_instance_id
		Aura_Spellid[aura_instance_id] = spellid
		Aura_Expiration[aura_instance_id] = expiration
		Aura_Stacks[aura_instance_id] = stacks
		Aura_Caster[aura_instance_id] = caster
		Aura_Duration[aura_instance_id] = duration
		Aura_Texture[aura_instance_id] = texture
	end
end

local SearchNameplate = function(guid, raidIcon, sourceName, raidIconFlags, castStart)
	local frame
	if raidIconFlags and type(raidIconFlags) == "number" then
		local UnitIcon
		for iconname, bitmask in pairs(RaidTargetMask) do if band(raidIconFlags, bitmask) > 0  then UnitIcon = iconname break end end
		for frame, _ in pairs(NamePlateList) do
			if frame and frame:IsShown() and frame.isMarked and (frame.raidIconType == UnitIcon) then return frame end
		end
	end

	if raidIcon then
		for frame, _ in pairs(NamePlateList) do 
			if frame and frame:IsShown() and frame.isMarked and (frame.raidIconType == raidIcon) then return frame end 
		end
	end

	if guid then
		for frame, _ in pairs(NamePlateList) do 
			if frame and frame:IsShown() and frame.guid == guid then return frame end 
		end
	end

	if sourceName then
		local SearchFor = strsplit("-", sourceName)
		for frame, _ in pairs(NamePlateList) do 
			if frame and frame:IsShown() and frame.oldname and frame.plateName == SearchFor and frame.hasClass then return frame end
		end
	end

	if castStart then
		for frame, _ in pairs(NamePlateList) do
			if frame and frame:IsShown() and frame.old_castbar and frame.old_castbar:IsShown() and frame.old_castbar:GetValue() == 0 then return frame end
		end
	end
end

local UpdateDebuffs = function(self)
	local guid = self.guid
	if not guid then
		if self.hasClass then guid = NameGUID[self.plateName] elseif self.isMarked then guid = RaidIconGUID[self.raidIconType] end
		if guid then self.guid = guid end
	end
	Plates:UpdateAuraWidget(self, guid)
end

local UpdateAurasByUnit = function(unit)
	if UnitIsFriend("player", unit) then return end
	local guid = UnitGUID(unit)

	if guid and AuraList[guid] then
		local unit_aura_list = AuraList[guid]
		for aura_id, aura_instance_id in pairs(unit_aura_list) do
			Aura_Spellid[aura_instance_id] = nil
			Aura_Expiration[aura_instance_id] = nil
			Aura_Stacks[aura_instance_id] = nil
			Aura_Caster[aura_instance_id] = nil
			Aura_Duration[aura_instance_id] = nil
			Aura_Texture[aura_instance_id] = nil
			unit_aura_list[aura_id] = nil
		end
	end

	for index = 1, 40 do
		local name , _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid, _, isBossDebuff = UnitDebuff(unit, index)
		if not name then break end
		AuraDurationsCache[spellid] = duration
		VirtualSetAura(guid, spellid, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture)
	end

	local raidicon, name
	if UnitPlayerControlled(unit) then name = select(1, UnitName(unit)) end
	raidicon = RaidIconIndex[GetRaidTargetIndex(unit) or ""]
	if raidicon then RaidIconGUID[raidicon] = guid end
	local frame = SearchNameplate(guid, raidicon, name)
	if frame then UpdateDebuffs(frame) end
end

local UpdateAuraByLookup = function(guid)
	local IsArena = (select(2, IsInInstance()) == "arena")

	if guid == UnitGUID("target") and UnitIsEnemy("target", "player") then
		UpdateAurasByUnit("target")
	elseif guid == UnitGUID("mouseover") and UnitIsEnemy("mouseover", "player") then
		UpdateAurasByUnit("mouseover")
	elseif guid == UnitGUID("focus") and UnitIsEnemy("focus", "player") then
		UpdateAurasByUnit("focus")
	elseif GroupTargetList[guid] then
		local unit = GroupTargetList[guid]
		if unit then
			local unittarget = UnitGUID(unit.."target")
			if guid == unittarget and UnitIsEnemy(unittarget, "player") then UpdateAurasByUnit(unittarget) end
		end
	elseif IsArena then
		for i = 1, 5 do
			if UnitGUID("arena" .. i) == guid then
				UpdateAurasByUnit("arena" .. i)
				return
			end
		end
	end
end

local Schedule = function(self, object)
	if self.queue == nil then self.queue = {} end
	self.queue[object] = true
	if object.OldTexture then object:SetTexture(object.OldTexture) end
end

local GetFilter = function(self, ...)
	if self.oldname == nil then return end
	if self.highlight == nil then return end
	self.health:Show()
	self.highlight:SetTexture(1, 1, 1, .15)
end

local ForEachFrame = function(...)
	local tbl = {...}
	for _, func in pairs(tbl) do
		for frame, _ in pairs(NamePlateList) do
			if frame and frame:IsShown() then func(frame) end
		end
	end
end

local GetRaidIcon = function(self)
	if self.raidicon == nil then return end
	self.isMarked = self.raidicon:IsShown() or false
	if self.isMarked then
		local x, y = self.raidicon:GetTexCoord()
		self.raidIconType = RaidIconCoordinates[x][y]
	else
		self.isMarked = nil
		self.raidIconType = nil
	end
end

local GetGUID = function(self)
	if self.oldname == nil then return end
	if UnitExists("target") and self:GetAlpha() == 1 and UnitName("target") == self.plateName then
		self.guid = UnitGUID("target")
		NameGUID[self.plateName] = self.guid
		self.unit = "target"
		UpdateAurasByUnit("target")
		if UnitIsPlayer("target") then NameClasses[self.plateName] = select(2, UnitClass("target")) end
	elseif self.highlight and self.highlight:IsShown() and UnitExists("mouseover") and UnitName("mouseover") == self.plateName then
		self.guid = UnitGUID("mouseover")
		self.unit = "mouseover"
		UpdateAurasByUnit("mouseover")
		NameGUID[self.plateName] = self.guid
		if UnitIsPlayer("mouseover") then NameClasses[self.plateName] = select(2, UnitClass("mouseover")) end
	else
		self.unit = nil
	end
end

local goodR, goodG, goodB = unpack(C["nameplate"].threat_goodcolor)
local badR, badG, badB = unpack(C["nameplate"].threat_badcolor)
local transitionR, transitionG, transitionB = unpack(C["nameplate"].threat_transitioncolor)
local UpdateThreat = function(self)
	local arena = (select(2, IsInInstance()) == "arena")
	local bg = (select(2, IsInInstance()) == "pvp")
	local ash = (select(1, GetCurrentMapAreaID()) == 978)

	if self.health == nil then return end
	if self.hasClass or self.isTagged then return end

	--[[Enhanced Threat feature]]--
	if C["nameplate"].threat then
		if not self.old_threat:IsShown() then
			if InCombatLockdown() and self.isFriendly ~= true then
				if D.Role == "Tank" then
					self.health:SetStatusBarColor(badR, badG, badB)
					self.health.bg:SetTexture(unpack(C["media"].backdropcolor))
				else
					self.health:SetStatusBarColor(goodR, goodG, goodB)
					self.health.bg:SetTexture(unpack(C["media"].backdropcolor))
				end
			else
				UpdateColor(self)
			end
		else
			local r, g, b = self.old_threat:GetVertexColor()
			if g + b == 0 then
				if D.Role == "Tank" then
					self.health:SetStatusBarColor(goodR, goodG, goodB)
					self.health.bg:SetTexture(unpack(C["media"].backdropcolor))
				else
					self.health:SetStatusBarColor(badR, badG, badB)
					self.health.bg:SetTexture(unpack(C["media"].backdropcolor))
				end
			else
				self.health:SetStatusBarColor(transitionR, transitionG, transitionB)
				self.health.bg:SetTexture(unpack(C["media"].backdropcolor))
			end
		end
	else
		if self.old_threat:IsShown() then
			local _, val = self.old_threat:GetVertexColor()
			if val > .7 then self.threat:SetVertexColor(transitionR, transitionG, transitionB) else self.threat:SetVertexColor(badR, badG, badB) end
		else
			self.threat:SetVertexColor(unpack(C["media"].backdropcolor))
		end
	end

	--[[Highlight current target]]--
	if self.unit == "target" then
		self.health.name:SetTextColor(1, 1, 0)
		self.health:SetAlpha(1)
	else
		self.health.name:SetTextColor(1, 1, 1)
		self.health:SetAlpha(C["nameplate"].NonTargetAlpha)
	end
end

local HideQueque = function(self)
	local objectType
	for object in pairs(self.queue) do
		objectType = object:GetObjectType()  
		if objectType == "Texture" then
			object.OldTexture = object:GetTexture()
			object:SetTexture("")
			object:SetTexCoord(0, 0, 0, 0)
		elseif objectType == "FontString" then
			object:SetTextHeight(.001)
		elseif objectType == "StatusBar" then
			object:SetStatusBarTexture("")
		else
			object:Hide()
		end
	end
end

local HealthBar_OnValue = function(self, value) 
	local health = self.parent.health
	health:SetMinMaxValues(self:GetMinMaxValues())
	health:SetValue(self:GetValue())
	if C["nameplate"].Percent then
		local _, mx = health:GetMinMaxValues()
		health.perc:SetText(string.format("%d%%", math.min(math.ceil((value or 0)/((mx or 0) / 100)), 100)))
	end
end

local CastBar_OnValue = function(self, value) 
	local castbar = self.parent.castbar
	castbar:SetMinMaxValues(self:GetMinMaxValues())  
	castbar:SetValue(value) 
	if castbar.shield:IsShown() then castbar:SetStatusBarColor(.78, .25, .25, 1) else castbar:SetStatusBarColor(1, .82, 0) end
end

local CastBar_OnShow = function(self)
	self = self.parent
	self.castbar.icon:SetTexture(self.oldcbicon:GetTexture())
	self.castbar.name:SetText(self.oldcbname:GetText())

	if self.castbar.shield:IsShown() then self.castbar:SetStatusBarColor(.78, .25, .25, 1) else self.castbar:SetStatusBarColor(1, .82, 0) end
	self.castbar.icon:SetSize(5 + mult * 7 + C["nameplate"].plateheight, 5 + mult * 7 + C["nameplate"].plateheight)
	self.castbar:Hide()
	HideQueque(self)
	self.castbar:Show()
end

local HealthBar_OnShow = function(self)
	self.plateName = gsub(self.oldname:GetText(), "%s%(%*%)","")
	self.health:SetMinMaxValues(self.oldhealth:GetMinMaxValues())
	self.health:SetValue(self.oldhealth:GetValue())

	if C["nameplate"].Percent then
		local _, mx = self.health:GetMinMaxValues()
		self.health.perc:SetText(string.format("%d%%", math.min(math.ceil((self.oldhealth:GetValue() or 0) / ((mx or 0) / 100)), 100)))
	end
	self.hasClass = nil
	self.health.name:SetText(self.oldname:GetText())

	fadeIn(self.plate)
	HideQueque(self)
end

local RepositePlate = function(self)
	if self.plate and self.health then
		self.plate:Hide()
		self.plate:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", self:GetCenter())
		self.plate:Show()
	end
end

local StylePlate = function(self)
	local f1, f2 = self:GetChildren()
	local old_health, old_castbar = f1:GetChildren()
	local old_name = f2:GetRegions()
	local old_threat, hpborder, highlight, old_level, old_bossicon, raidicon, old_elite = f1:GetRegions()
	local cbtexture, cbborder, old_cbshield, old_cbicon, old_cbname, cbnameshadow = old_castbar:GetRegions()

	self.old_castbar = old_castbar
	self.oldhealth = old_health
	self.oldlevel = old_level
	self.oldelite = old_elite
	self.oldboss = old_bossicon
	self.oldname = old_name
	self.oldcbicon = old_cbicon
	self.oldcbname = old_cbname
	self.old_threat = old_threat

	self.plateName = gsub(self.oldname:GetText(), "%s%(%*%)","")

	if self.plate == nil then
		self.plate = CreateFrame("Frame", nil, WorldFrame)
		self.plate:SetFrameStrata("BACKGROUND")
		self.plate:Hide()
		self.plate:SetSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
		self.plate.parent = self
	end

	if self.health == nil then
		self.health = CreateFrame("StatusBar", nil, self.plate)
		self.health:SetStatusBarTexture(C["media"].normTex)
		self.health:GetStatusBarTexture():SetHorizTile(true)
		self.health:SetSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
		self.health:SetPoint("BOTTOM", self, "BOTTOM", 0, 5)
		CreateVirtualFrame(self.health)

		self.health.bg = self.health:CreateTexture(nil, "BORDER")
		self.health.bg:SetTexture(.1, .1, .1)
		self.health.bg:SetAllPoints()
		self.health:GetStatusBarTexture():SetDrawLayer("BORDER", 0)
		self.health.bg:SetDrawLayer("BORDER", -1)
	end

	if self.border == nil then
		self.border = self.health:CreateTexture(nil, "BORDER")
		self.border:SetPoint("TOPLEFT", -mult, mult)
		self.border:SetPoint("BOTTOMRIGHT", mult, -mult)
		self.border:SetTexture(unpack(C["media"].bordercolor))
		self.border:SetDrawLayer("BORDER", -2)
	end

	if not C["nameplate"].threat then
		if self.threat == nil then
			self.threat = self.health:CreateTexture(nil, "BORDER")
			self.threat:SetPoint("TOPLEFT", -mult * 2, mult * 2)
			self.threat:SetPoint("BOTTOMRIGHT", mult * 2, -mult * 2)
			self.threat:SetTexture(1, 1, 1)
			self.threat:SetDrawLayer("BORDER", -3)
		end
	end

	if self.rare == nil then
		self.rare = self.health:CreateFontString(nil, "OVERLAY")
		self.rare:SetFont(C["media"].font, 10, "THINOUTLINE")
	end

	if self.health.name == nil then
		self.health.name = self.health:CreateFontString("$parentHealth", "OVERLAY")
		self.health.name:SetFont(Font, 10, "THINOUTLINE")
		self.health.name:SetPoint("BOTTOMLEFT", self.health, "TOPLEFT", 0, 5)
		self.health.name:SetSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
	end

	if C["nameplate"].Percent then
		if self.health.perc == nil then
			self.health.perc = self.health:CreateFontString("$parentHealthPercent", "OVERLAY")
			self.health.perc:SetFont(Font, 10, "THINOUTLINE")
			self.health.perc:SetPoint("LEFT", self.health, "RIGHT", 4, 0)
		end
	end

	if self.castbar == nil then
		self.castbar = CreateFrame("Statusbar", nil, self.plate)
		self.castbar:SetFrameLevel(self.old_castbar:GetFrameLevel())
		self.castbar:SetFrameStrata(self.old_castbar:GetFrameStrata())

		self.castbar:SetSize(C["nameplate"].platewidth, 5)
		self.castbar:SetPoint("TOP", self.health, "BOTTOM", 0, -5)
		self.castbar:SetStatusBarTexture(C["media"].normTex)
		self.castbar:GetStatusBarTexture():SetHorizTile(true)
		CreateVirtualFrame(self.castbar)
		self.castbar:Hide()
	end

	if self.castbar.icon == nil then
		self.castbar.icon = self.castbar:CreateTexture("$parentIcon", "OVERLAY")
		self.castbar.icon:SetPoint("TOPRIGHT", self.health, "TOPLEFT", -5, 0)
		self.castbar.icon:SetTexCoord(unpack(D.IconCoord))
		CreateVirtualFrame(self.castbar, self.castbar.icon)
		self.castbar.shield = old_cbshield
		self.castbar.shield:Hide()
	end

	if self.castbar.name == nil then
		self.castbar.name = self.castbar:CreateFontString(nil, "OVERLAY")
		self.castbar.name:SetFont(Font, 11, "THINOUTLINE")
		self.castbar.name:SetPoint("TOP", self.castbar, "BOTTOM", -3, 0)
	end

	if self.raidicon == nil then
		raidicon:ClearAllPoints()
		raidicon:SetPoint("BOTTOM", self.health, "TOP", 0, 16)
		raidicon:SetSize(25, 25)
		raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		self.raidicon = raidicon
	end

	if C["nameplate"].debuffs then
		if self.AuraWidget == nil then
			self.AuraWidget = CreateFrame("Frame", nil, self.plate)
			self.AuraWidget:SetHeight(32) 
			self.AuraWidget:Show()
			self.AuraWidget:SetSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
			self.AuraWidget:SetPoint("BOTTOM", self.health, "TOP", 0, 20)

			self.AuraWidget.PollFunction = function(self, elapsed)
				local timeleft = ceil(elapsed-GetTime())
				if timeleft > 60 then self.expired:SetText(ceil(timeleft / 60) .. "m") else self.expired:SetText(ceil(timeleft)) end
			end
			self.AuraWidget.AuraIconFrames = {}
			local AuraIconFrames = self.AuraWidget.AuraIconFrames
			for index = 1, C["nameplate"].MaxDebuffs do AuraIconFrames[index] = CreateAuraIcon(self.AuraWidget) end
			local FirstRowCount = min(C["nameplate"].MaxDebuffs / 2)

			AuraIconFrames[1]:SetPoint("RIGHT", self.AuraWidget, -1, 0)
			for index = 2, C["nameplate"].MaxDebuffs do AuraIconFrames[index]:SetPoint("RIGHT", AuraIconFrames[index - 1], "LEFT", -3, 0) end

			self.AuraWidget._Hide = self.AuraWidget.Hide
			self.AuraWidget.Hide = function() if self.AuraWidget.guidcache then self.AuraWidget.unit = nil end self.AuraWidget:_Hide() end
			self.AuraWidget:SetScript("OnHide", function() 
				for index = 1, C["nameplate"].MaxDebuffs do ScheduleHide(AuraIconFrames[index], 0) end 
			end)
		end
	end

	Schedule(self, self.oldhealth)
	Schedule(self, hpborder)
	Schedule(self, self.oldlevel)
	Schedule(self, old_threat)
	Schedule(self, self.oldcbicon)
	Schedule(self, self.old_castbar)
	Schedule(self, old_cbname)
	Schedule(self, cbnameshadow)
	Schedule(self, old_cbshield)
	Schedule(self, cbtexture)
	Schedule(self, cbborder)
	Schedule(self, old_bossicon)
	Schedule(self, old_elite)
	Schedule(self, old_name)

	HealthBar_OnShow(self)
	self:HookScript("OnShow", HealthBar_OnShow)
	self:HookScript("OnHide", function(self)
		if not self.health then return end
		self.plate:Hide()
		self.castbar:Hide()
		self.unit = nil
		self.isMarked = nil
		self.raidIconType = nil
		self.guid = nil
		local index = 0
		NameClasses[self.plateName] = nil
		self.plateName = nil
		self.hasClass = nil
		if self.icons then for _,icon in ipairs(self.icons) do icon:Hide() end end
	end)

	self.oldhealth.parent = self
	self.old_castbar.parent = self
	self.oldhealth:HookScript("OnValueChanged", HealthBar_OnValue)
	self.old_castbar:HookScript("OnShow", CastBar_OnShow)
	self.old_castbar:HookScript("OnHide", function(self) self.parent.castbar:Hide() end)
	self.old_castbar:HookScript("OnValueChanged", CastBar_OnValue)
	fadeIn(self.plate)
	NamePlateList[self] = true
end

Plates.updateAll = function(self)
	playerFaction = select(1, UnitFactionGroup("player")) == "Horde" and 1 or 0
	playerGUID = UnitGUID("player")

	for _, v in pairs({NamePlateList, GroupMembersList, AuraDurationsCache, DebuffCache, GroupTargetList, RaidIconGUID, NameGUID,
	AuraList, Aura_Spellid, Aura_Expiration, Aura_Stacks, Aura_Caster, Aura_Duration, Aura_Texture, IconFrameList, GUIDIgnoreCast, NameClasses}) do v = {} end

	timeToUpdate = 0
	self.numChildren = -1
	ScheduleFrameActive = false

	if self.onupdate == nil then
		self.onupdate = function(self, elapsed)
			if self.numChildren == nil then self.numChildren = -1 end
			if WorldFrame:GetNumChildren() ~= self.numChildren then
				self.numChildren = WorldFrame:GetNumChildren()
				for index = 1, select("#", WorldFrame:GetChildren()) do
					local frame = select(index, WorldFrame:GetChildren())
					if not NamePlateList[frame] and (frame:GetName() and frame:GetName():find("NamePlate%d")) then
						if frame:IsShown() then
							StylePlate(frame)
							RepositePlate(frame)
						end
					end
				end
			end

			ForEachFrame(function(self) 
				self.plate:SetFrameLevel(self:GetFrameLevel()) 
				self.health.name:SetAlpha(self:GetAlpha())
				GetGUID(self)
				GetFilter(self)
				UpdateThreat(self)
				GetRaidIcon(self)
				if not C["nameplate"].threat then UpdateColor(self) end
				UpdateCastbarColor(self)
				UpdateLevel(self)
			end)
		end
	end
	self:SetScript("OnUpdate", self.onupdate)

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("UNIT_TARGET")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end

Plates:SetScript("OnEvent", function(self, event, ...)
	local foundPlate = nil

	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _, subEvent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellid, spellName, _, auraType, stackCount  = ...
		if band(sourceFlags, COMBATLOG_OBJECT_FOCUS) then
			foundPlate = SearchNameplate(_,_,sourceName)
			if foundPlate and foundPlate:IsShown() and foundPlate.unit ~= "target" then foundPlate.unit = "focus" end
		end
		if band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then 
			if sourceGUID and sourceName then
				local _, class, _, _, _, name = GetPlayerInfoByGUID(sourceGUID)
				if class and name then
					NameClasses[name] = class
				else
					if NameClasses[name] then NameClasses[name] = nil end
				end
			end
		end

		if event == "SPELL_AURA_APPLIED" or event == "SPELL_HEAL" or event == "SPELL_DAMAGE" or event == "SPELL_MISS" then GUIDIgnoreCast[sourceGUID] = spellName end
		if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH" then
			local duration = AuraDurationsCache[spellid]
			local texture = GetSpellTexture(spellid)
			VirtualSetAura(destGUID, spellid, GetTime() + (duration or 0), 1, sourceGUID, duration, texture)
		elseif subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REMOVED_DOSE" then
			local duration = AuraDurationsCache[spellid]
			local texture = GetSpellTexture(spellid)
			VirtualSetAura(destGUID, spellid, GetTime() + (duration or 0), stackCount, sourceGUID, duration, texture)
		elseif subEvent == "SPELL_AURA_BROKEN" or subEvent == "SPELL_AURA_BROKEN_SPELL" or subEvent == "SPELL_AURA_REMOVED" then
			if destGUID and spellid and AuraList[destGUID] then
				local aura_instance_id = tostring(destGUID) .. tostring(spellid) .. (tostring(caster or "UNKNOWN_CASTER"))
				local aura_id = spellid .. (tostring(caster or "UNKNOWN_CASTER"))
				if AuraList[destGUID][aura_id] then
					Aura_Spellid[aura_instance_id] = nil
					Aura_Expiration[aura_instance_id] = nil
					Aura_Stacks[aura_instance_id] = nil
					Aura_Caster[aura_instance_id] = nil
					Aura_Duration[aura_instance_id] = nil
					Aura_Texture[aura_instance_id] = nil
					AuraList[destGUID][aura_id] = nil
				end
			end
		elseif subEvent == "SPELL_CAST_START" then
			local spell, _, icon, castTime, _, _ = GetSpellInfo(spellid)
			if not (castTime > 0) then return end
			foundPlate = SearchNameplate(_, _, _, _, true)
		else
			if band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then 
				if band(sourceFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then 
					foundPlate = SearchNameplate(_, _, sourceName)
				elseif band(sourceFlags, COMBATLOG_OBJECT_CONTROL_NPC) > 0 then 
					foundPlate = SearchNameplate(_, _, _, sourceRaidFlags)
				else
					return
				end
			else 
				return 
			end
			if foundPlate and foundPlate:IsShown() and foundPlate.unit ~= "target" then foundPlate.guid = sourceGUID end
		end

		if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_REFRESH" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REMOVED_DOSE" or subEvent == "SPELL_AURA_BROKEN" or subEvent == "SPELL_AURA_BROKEN_SPELL" or subEvent == "SPELL_AURA_REMOVED" then
			if (band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) and auraType == "DEBUFF" then
				UpdateAuraByLookup(destGUID)
				local name, raidicon

				if band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then 
					local rawName = strsplit("-", destName or " ")
					NameGUID[rawName] = destGUID
					name = rawName
				end

				for iconname, bitmask in pairs(RaidTargetMask) do
					if band(destRaidFlags, bitmask) > 0  then
						RaidIconGUID[iconname] = destGUID
						raidicon = iconname
						break
					end
				end

				local frame = SearchNameplate(destGUID, raidicon, name)	
				if frame then UpdateDebuffs(frame) end
			end
		end

	elseif event == "PLAYER_ENTERING_WORLD" then
		SetCVar("bloatthreat", 0)
		SetCVar("bloattest", 0)
		--SetCVar("showVKeyCastbar", 1)
		SetCVar("ShowClassColorInNameplate", 1)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowFriends", 0)

		Plates.updateAll(self)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "UNIT_TARGET" then
		GroupTargetList = wipe(GroupTargetList)
		for name, unitid in pairs(GroupMembersList) do if UnitExists(unitid .. "target") then GroupTargetList[UnitGUID(unitid .. "target")] = unitid .. "target" end end
	elseif event == "UNIT_AURA" then
		local unit = ...
		if unit == "target" or unit == "focus" then UpdateAurasByUnit(unit) end
	end
end)

Plates:RegisterEvent("PLAYER_LOGIN")
Plates:RegisterEvent("PLAYER_ENTERING_WORLD")
Plates.updateAll(Plates)