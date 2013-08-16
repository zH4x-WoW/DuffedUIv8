local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local tonumber = tonumber
local format = format
local date = date

local GetGameTime = GetGameTime
local EuropeString = "%s%02d|r:%s%02d|r"
local UKString = "%s%d|r:%s%02d|r %s%s|r"
local CurrentHour
local CurrentMin
local tslu = 1

local AMPM = {
	TIMEMANAGER_PM,
	TIMEMANAGER_AM,
}

-- Temp! Config me later :)
local Use24Hour = false
local UseLocalTime = true

local GetFormattedTime = function()
	local Hour, Minute, AmPm

	if UseLocalTime then -- Local Time
		local Hour24 = tonumber(date("%H"))
		Hour = tonumber(date("%I"))
		Minute = tonumber(date("%M"))
		
		if Use24Hour then
			return Hour24, Minute, -1
		else
			if (Hour24 >= 12) then
				AmPm = 1
			else
				AmPm = 2
			end
			
			return Hour, Minute, AmPm
		end
	else -- Server Time
		Hour, Minute = GetGameTime()
		
		if Use24Hour then
			return Hour, Minute, -1
		else
			if (Hour >= 12) then
				if (Hour > 12) then
					Hour = Hour - 12
				end
				
				AmPm = 1
			else
				if (Hour == 0) then
					Hour = 12
				end
				
				AmPm = 2
			end
			
			return Hour, Minute, AmPm
		end
	end
end

local Update = function(self, t)
	tslu = tslu - t
	
	if (tslu > 0) then
		return
	end
	
	local Hour, Minute, AmPm = GetFormattedTime()
	
	if (CurrentHour == Hour and CurrentMin == Minute) then
		return
	end
	
	if (AmPm == -1) then
		self.Text:SetText(format(EuropeString, DataText.NameColor, Hour, DataText.NameColor, Minute))
	else
		self.Text:SetText(format(UKString, DataText.NameColor, Hour, DataText.NameColor, Minute, DataText.ValueColor, AMPM[AmPm]))
	end
	
	CurrentHour = Hour
	CurrentMin = Minute
	
	tslu = 1
end

local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end
	
	self:SetScript("OnUpdate", Update)
	self:Update(1)
end

local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnUpdate", nil)
end

DataText:Register("Time", Enable, Disable, Update)