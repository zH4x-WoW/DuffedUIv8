local T, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local Panels = T["Panels"]
local Colors = T["Colors"]
local TukuiUnitFrames = CreateFrame("Frame")

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

TukuiUnitFrames.Units = {}
TukuiUnitFrames.Backdrop = {
	bgFile = C.Media.Blank,
	insets = {top = -T.Mult, left = -T.Mult, bottom = -T.Mult, right = -T.Mult},
}

function TukuiUnitFrames:ShortValue()
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

function TukuiUnitFrames:UTF8Sub(i, dots)
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

function TukuiUnitFrames:MouseOnPlayer()
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

function TukuiUnitFrames:UpdateClassBar(script, x, y)
	local Frame = self:GetParent()
	local Shadow = Frame.Shadow
	
	if (script == "OnShow") then
		if (Shadow) then
			Shadow:Point("TOPLEFT", -4, 12)
		end
	else
		if (Shadow) then
			Shadow:Point("TOPLEFT", -4, 4)
		end
	end
end

function TukuiUnitFrames:CustomCastTimeText(duration)
	local Value = format("%.1f / %.1f", self.channeling and duration or self.max - duration, self.max)

	self.Time:SetText(Value)
end

function TukuiUnitFrames:CustomCastDelayText(duration)
	local Value = format("%.1f |cffaf5050%s %.1f|r", self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay)

	self.Time:SetText(Value)
end

function TukuiUnitFrames:CheckInterrupt(unit)
	if (unit == "vehicle") then
		unit = "player"
	end

	if (self.interrupt and UnitCanAttack("player", unit)) then
		self:SetStatusBarColor(1, 0, 0, 0.5)	
	else
		self:SetStatusBarColor(0.31, 0.45, 0.63, 0.5)		
	end
end

function TukuiUnitFrames:CheckCast(unit, name, rank, castid)
	TukuiUnitFrames.CheckInterrupt(self, unit)
end

-- check if we can interrupt on channel cast
function TukuiUnitFrames:CheckChannel(unit, name, rank)
	TukuiUnitFrames.CheckInterrupt(self, unit)
end

function TukuiUnitFrames:UpdateNamePosition()
	if (self.Power.Value:GetText() and UnitIsEnemy("player", "target")) then
		self.Name:ClearAllPoints()
		self.Name:SetPoint("CENTER", self.Panel, "CENTER", 0, 0)
	else
		self.Name:ClearAllPoints()
		self.Power.Value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.Panel, "LEFT", 4, 0)
	end
end

function TukuiUnitFrames:PostUpdateHealth(unit, min, max)
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

		if (unit == "target" and UnitIsEnemy(unit, "player") and UnitIsPlayer(unit)) or (unit == "target" and not UnitIsPlayer(unit) and UnitIsFriend(unit, "player")) then
			local Color = Colors.reaction[UnitReaction(unit, "player")]
			if (Color) then 
				r, g, b = Color[1], Color[2], Color[3]
				self:SetStatusBarColor(r, g, b)
			else
				r, g, b = 75/255,  175/255, 76/255
				self:SetStatusBarColor(r, g, b)
			end					
		end

		if (min ~= max) then
			r, g, b = T.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit == "target" or (unit and strfind(unit, "boss%d"))) then
				self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", TukuiUnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
			elseif (unit and strfind(unit, "arena%d")) or (unit == "focus") or (unit == "focustarget") then
				self.Value:SetText("|cff559655"..TukuiUnitFrames.ShortValue(min).."|r")
			else
				self.Value:SetText("|cff559655-"..TukuiUnitFrames.ShortValue(max-min).."|r")
			end
		else
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				self.Value:SetText("|cff559655"..max.."|r")
			elseif (unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText("|cff559655"..TukuiUnitFrames.ShortValue(max).."|r")
			else
				self.Value:SetText(" ")
			end
		end
	end
end

function TukuiUnitFrames:PostUpdatePower(unit, min, max)
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
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), TukuiUnitFrames.ShortValue(max - (max - min)))
				elseif (unit == "player" and Parent:GetAttribute("normalUnit") == "pet" or unit == "pet") then
					self.Value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and strfind(unit, "arena%d")) or unit == "focus" or unit == "focustarget" then
					self.Value:SetText(TukuiUnitFrames.ShortValue(min))
				else
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
				end
			else
				self.Value:SetText(max - (max - min))
			end
		else
			if (unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and strfind(unit, "arena%d"))) then
				self.Value:SetText(TukuiUnitFrames.ShortValue(min))
			else
				self.Value:SetText(min)
			end
		end
	end
	
	if (Parent.Name and unit == "target") then
		TukuiUnitFrames.UpdateNamePosition(Parent)
	end
end

function TukuiUnitFrames:CreateAuraTimer(elapsed)
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
				local Time = T.FormatTime(self.TimeLeft)
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

function TukuiUnitFrames:PostCreateAura(button)
	button:SetTemplate("Default")
	
	button.Remaining = button:CreateFontString(nil, "OVERLAY")
	button.Remaining:SetFont(C.Media.Font, 12, "THINOUTLINE")
	button.Remaining:Point("CENTER", 1, 0)
	
	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse()
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetInside()
	
	button.icon:SetInside()
	button.icon:SetTexCoord(unpack(T.IconCoord))
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:Point("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.Media.Font, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)
	
	button.OverlayFrame = CreateFrame("Frame", nil, button, nil)
	button.OverlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)	
	button.overlay:SetParent(button.OverlayFrame)
	button.count:SetParent(button.OverlayFrame)
	button.Remaining:SetParent(button.OverlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetOutside()
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile = C.Media.Glow, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
	
	button.Animation = button:CreateAnimationGroup()
	button.Animation:SetLooping("BOUNCE")
	button.Animation.FadeOut = Animation:CreateAnimation("Alpha")
	button.Animation.FadeOut:SetChange(-.9)
	button.Animation.FadeOut:SetDuration(.6)
	button.Animation.FadeOut:SetSmoothing("IN_OUT")
end

function TukuiUnitFrames:PostUpdateAura(unit, button, index, offset, filter, isDebuff, duration, timeLeft)
	local _, _, _, _, DType, Duration, ExpirationTime, UnitCaster, IsStealable = UnitAura(unit, index, button.filter)
	
	if button then
		if(button.filter == "HARMFUL") then
			if(not UnitIsFriend("player", unit) and button.owner ~= "player" and button.owner ~= "vehicle") then
				button.icon:SetDesaturated(true)
				button:SetBackdropBorderColor(unpack(C.media.bordercolor))
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				button.icon:SetDesaturated(false)
				button:SetBackdropBorderColor(color.r * 0.8, color.g * 0.8, color.b * 0.8)
			end
		else
			if (IsStealable or dtype == "Magic") and not UnitIsFriend("player", unit) and not button.Animation.Playing then
				button.Animation:Play()
				button.Animation.Playing = true
			else
				button.Animation:Stop()
				button.Animation.Playing = false
			end
		end
		
		if Duration and Duration > 0 then
			icon.Remaining:Show()
		else
			icon.Remaining:Hide()
		end
	 
		icon.Duration = duration
		icon.TimeLeft = expirationTime
		icon.First = true
		icon:SetScript("OnUpdate", TukuiUnitFrames.CreateAuraTimer)
	end
end

function TukuiUnitFrames:Update()
	for _, element in ipairs(self.__elements) do
		element(self, "UpdateElement", self.unit)
	end
end

function TukuiUnitFrames:Style(unit)
	if unit == "player" then
		TukuiUnitFrames.Player(self)
	elseif unit == "target" then
		TukuiUnitFrames.Target(self)
	elseif unit == "targettarget" then
		TukuiUnitFrames.TargetOfTarget(self)
	elseif unit == "pet" then
		TukuiUnitFrames.Pet(self)
	end
	
	return self
end

function TukuiUnitFrames:CreateAnchor()
	local Anchor = CreateFrame("Frame", nil, UIParent)
	Anchor:SetPoint("TOPLEFT", Panels.ActionBar2)
	Anchor:SetPoint("BOTTOMRIGHT", Panels.ActionBar3)
	
	TukuiUnitFrames.Anchor = Anchor
end

function TukuiUnitFrames:CreateUnits()
	local Player = oUF:Spawn("player")
	Player:SetPoint("BOTTOMLEFT", TukuiUnitFrames.Anchor, "TOPLEFT", 0, 8)
	Player:SetParent(Panels.PetBattleHider)
	Player:Size(250, 57)
	
	local Target = oUF:Spawn("target")
	Target:SetPoint("BOTTOMRIGHT", TukuiUnitFrames.Anchor, "TOPRIGHT", 0, 8)
	Target:SetParent(Panels.PetBattleHider)
	Target:Size(250, 57)

	local TargetOfTarget = oUF:Spawn("targettarget")
	TargetOfTarget:SetPoint("BOTTOM", TukuiUnitFrames.Anchor, "TOP", 0, 8)
	TargetOfTarget:SetParent(Panels.PetBattleHider)
	TargetOfTarget:Size(129, 36)
	
	local Pet = oUF:Spawn("pet")
	Pet:SetParent(Panels.PetBattleHider)
	Pet:SetPoint("BOTTOM", TukuiUnitFrames.Anchor, "TOP", 0, 49)
	Pet:Size(129, 36)
	
	TukuiUnitFrames.Units.Player = Player
	TukuiUnitFrames.Units.Target = Target
	TukuiUnitFrames.Units.TargetOfTarget = TargetOfTarget
	TukuiUnitFrames.Units.Pet = Pet
end

TukuiUnitFrames:RegisterEvent("ADDON_LOADED")
TukuiUnitFrames:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Tukui" then
		return
	end
	
	oUF:RegisterStyle("Tukui", TukuiUnitFrames.Style)
	self:CreateAnchor()
	self:CreateUnits()
end)

T["UnitFrames"] = TukuiUnitFrames