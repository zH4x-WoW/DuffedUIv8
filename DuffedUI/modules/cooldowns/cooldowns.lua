local T, C, L = select(2, ...):unpack()

local _G = _G
local TukuiCooldowns = CreateFrame("Frame")
local UIParent = UIParent
local IconSize = 36
local Day, Hour, Minute = 86400, 3600, 60
local Dayish, Hourish, Minuteish = 3600 * 23.5, 60 * 59.5, 59.5
local HalfDayish, HalfHourish, HalfMinuteish = Day/2 + 0.5, Hour/2 + 0.5, Minute/2 + 0.5
local Font = C.Medias.Font
local FontSize = 20
local MinScale = 0.5
local MinimumDuration = 2.5
local Notification = C.Cooldowns.Notification
local ExpireFormat = T.RGBToHex(1, 0, 0).."%.1f|r"
local SecondsFormat = T.RGBToHex(1, 1, 0).."%d|r"
local MinutesFormat = T.RGBToHex(1, 1, 1).."%dm|r"
local HoursFormat = T.RGBToHex(0.4, 1, 1).."%dh|r"
local DaysFormat = T.RGBToHex(0.4, 0.4, 1).."%dh|r"
local Active = {}
local Hooked = {}
local floor = math.floor
local min = math.min
local GetTime = GetTime
local GetActionCharges = GetActionCharges
local GetActionCooldown = GetActionCooldown
local ActionBarButtonEventsFrame = ActionBarButtonEventsFrame

function TukuiCooldowns:OnShow()
	Active[self] = true
end

function TukuiCooldowns:OnHide()
	Active[self] = nil
end

function TukuiCooldowns:Register()
	local Cooldown = self.cooldown
	if not Hooked[Cooldown] then
		Cooldown:HookScript("OnShow", TukuiCooldowns.OnShow)
		Cooldown:HookScript("OnHide", TukuiCooldowns.OnHide)
		Hooked[Cooldown] = true
	end
end

if ActionBarButtonEventsFrame.frames then
	for i, Frame in pairs(ActionBarButtonEventsFrame.frames) do
		TukuiCooldowns.Register(Frame)
	end
end

function TukuiCooldowns:GetTimeText()
	if self < Minuteish then
		local Seconds = tonumber(T.Round(self))
		if Seconds > Notification then
			return SecondsFormat, Seconds, self - (Seconds - 0.51)
		else
			return ExpireFormat, self, 0.051
		end
	elseif self < Hourish then
		local Minutes = tonumber(T.Round(self / Minute))
		return MinutesFormat, Minutes, Minutes > 1 and (self - (Minutes * Minute - HalfMinuteish)) or (self - Minuteish)
	elseif self < Dayish then
		local Hours = tonumber(T.Round(self / Hour))
		return HoursFormat, Hours, Hours > 1 and (self - (Hours * Hour - HalfDayish)) or (self - Hourish)
	else
		local Day = tonumber(T.Round(self / Day))
		return DaysFormat, Days,  Days > 1 and (self - (Days * Day - HalfDayish)) or (self - Dayish)
	end
end

function TukuiCooldowns:StopTimer()
	self.Enabled = nil
	self:Hide()
end

function TukuiCooldowns:ForceTimerUpdate()
	self.NextUpdate = 0
	self:Show()
end

function TukuiCooldowns:OnSizeChanged(width, height)
	local FontScale = T.Round(width) / IconSize

	if FontScale == self.FontScale then
		return
	end

	self.FontScale = FontScale

	if FontScale < MinScale then
		self:Hide()
	else
		self.Text:SetFont(Font, FontScale * FontSize, "OUTLINE")
		self.Text:SetShadowColor(0, 0, 0, 0.5)
		self.Text:SetShadowOffset(2, -2)
		if self.Enabled then
			TukuiCooldowns.ForceTimerUpdate(self)
		end
	end
end

function TukuiCooldowns:OnUpdate(elapsed)
	if self.NextUpdate > 0 then
		self.NextUpdate = self.NextUpdate - elapsed
	else
		local Remain = self.Duration - (GetTime() - self.Start)
		if tonumber(T.Round(Remain)) > 0 then
			if (self.FontScale * self:GetEffectiveScale() / UIParent:GetScale()) < MinScale then
				self.Text:SetText("")
				self.NextUpdate  = 1
			else
				local FormatStr, Time, NextUpdate = TukuiCooldowns.GetTimeText(Remain)
				self.Text:SetFormattedText(FormatStr, Time)
				self.NextUpdate = NextUpdate
			end
		else
			TukuiCooldowns.StopTimer(self)
		end
	end
end

function TukuiCooldowns:CreateTimer()
	local Scaler = CreateFrame("Frame", nil, self)
	Scaler:SetAllPoints(self)

	local Timer = CreateFrame("Frame", nil, Scaler)
	Timer:Hide()
	Timer:SetAllPoints(Scaler)
	Timer:SetScript("OnUpdate", TukuiCooldowns.OnUpdate)
	self.Timer = Timer

	local Text = Timer:CreateFontString(nil, "OVERLAY")
	Text:Point("CENTER", 2, 0)
	Text:SetJustifyH("CENTER")
	Timer.Text = Text

	TukuiCooldowns.OnSizeChanged(Timer, Scaler:GetSize())
	Scaler:SetScript("OnSizeChanged", function(self, ...)
		TukuiCooldowns.OnSizeChanged(Timer, ...)
	end)

	return Timer
end

function TukuiCooldowns:TimerStart(start, duration, charges, maxcharges)
	if self.noOCC then
		return
	end

	if start > 0 and duration > MinimumDuration then
		local Timer = self.Timer or TukuiCooldowns.CreateTimer(self)
		local Num = charges or 0

		Timer.Start = start
		Timer.Duration = duration
		Timer.Charges = Num
		Timer.MaxCharges = maxcharges
		Timer.Enabled = true
		Timer.NextUpdate = 0

		if Timer.FontScale >= MinScale and Num < 1 then
			Timer:Show()
		end
	else
		local Timer = self.Timer
		if Timer then
			TukuiCooldowns.StopTimer(Timer)
		end
	end
end

function TukuiCooldowns:UpdateCooldown()
	local Button = self:GetParent()
	local Start, Duration, Enable = GetActionCooldown(Button.action)
	local Charges, MaxCharges, ChargeStart, ChargeDuration = GetActionCharges(Button.action)

	TukuiCooldowns.TimerStart(self, Start, Duration, Charges, MaxCharges)
end

TukuiCooldowns:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
TukuiCooldowns:SetScript("OnEvent", function(self, event)
	for Cooldown in pairs(Active) do
		TukuiCooldowns.UpdateCooldown(Cooldown)
	end
end)

hooksecurefunc(getmetatable(_G["ActionButton1Cooldown"]).__index, "SetCooldown", TukuiCooldowns.TimerStart)
hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", TukuiCooldowns.Register)

T["Cooldowns"] = TukuiCooldowns