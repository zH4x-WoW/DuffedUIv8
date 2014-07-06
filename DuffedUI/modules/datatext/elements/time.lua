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
local Use24Hour = C["general"].Use24Hour
local UseLocalTime = C["general"].UseLocalTime

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
		self.Text:SetText(format(EuropeString, DataText.ValueColor, Hour, DataText.ValueColor, Minute))
	else
		self.Text:SetText(format(UKString, DataText.ValueColor, Hour, DataText.ValueColor, Minute, DataText.NameColor, AMPM[AmPm]))
	end
	
	CurrentHour = Hour
	CurrentMin = Minute
	
	tslu = 1
end

local OnEnter = function(self)
	if (InCombatLockdown()) then return end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	local pvp = GetNumWorldPVPAreas()
	for i = 1, pvp do
		local timeleft = select(5, GetWorldPVPAreaInfo(i))
		local name = select(2, GetWorldPVPAreaInfo(i))
		local inprogress = select(3, GetWorldPVPAreaInfo(i))
		local inInstance, instanceType = IsInInstance()
		if not ( instanceType == "none" ) then
			timeleft = QUEUE_TIME_UNAVAILABLE
		elseif inprogress then
			timeleft = WINTERGRASP_IN_PROGRESS
		else
			local hour = tonumber(format("%01.f", floor(timeleft / 3600)))
			local min = format(hour > 0 and "%02.f" or "%01.f", floor(timeleft / 60 - (hour * 60)))
			local sec = format("%02.f", floor(timeleft - hour * 3600 - min * 60)) 
			timeleft = (hour > 0 and hour..":" or "")..min..":"..sec
		end
		GameTooltip:AddDoubleLine(L.DataText.TimeTo.." "..name, timeleft)
	end
	GameTooltip:AddLine(" ")
		
	if C["general"].UseLocalTime then
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = "0"..Min end
		if C["general"].Use24Hour then         
			GameTooltip:AddDoubleLine(L.DataText.ServerTime, Hr .. ":" .. Min);
		else             
			if Hr >= 12 then
			Hr = Hr - 12
			if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L.DataText.ServerTime, Hr .. ":" .. Min.." PM");
			else
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L.DataText.ServerTime, Hr .. ":" .. Min.." AM");
			end
		end
	else
		Hr24 = tonumber(date("%H"))
		Hr = tonumber(date("%I"))
		Min = date("%M")
		if C["general"].Use24Hour then
			GameTooltip:AddDoubleLine(L.DataText.LocalTime, Hr24 .. ":" .. Min);
		else
			if Hr24 >= 12 then
				GameTooltip:AddDoubleLine(L.DataText.LocalTime, Hr24 .. ":" .. Min.." PM");
			else
				GameTooltip:AddDoubleLine(L.DataText.LocalTime, Hr24 .. ":" .. Min.." AM");
			end
		end
	end  
		
	local oneraid
	for i = 1, GetNumSavedInstances() do
		local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers = GetSavedInstanceInfo(i)
		if isRaid and (locked or extended) then
			local tr, tg, tb, diff
			if not oneraid then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L.DataText.SavedRaid)
				oneraid = true
			end

			local function fmttime(sec, table)
			local table = table or {}
			local d, h, m, s = ChatFrame_TimeBreakDown(floor(sec))
			local string = gsub(gsub(format(" %dd %dh %dm "..((d == 0 and h == 0) and "%ds" or ""), d, h, m, s)," 0[dhms]"," "),"%s+"," ")
			local string = strtrim(gsub(string, "([dhms])", {d = table.days or "d", h = table.hours or "h", m = table.minutes or "m", s = table.seconds or "s"})," ")
			return strmatch(string,"^%s*$") and "0"..(table.seconds or L"s") or string
		end
		if extended then tr, tg, tb = 0.3, 1, 0.3 else tr, tg, tb = 1, 1, 1 end
		if difficulty == 3 or difficulty == 4 then diff = "H" else diff = "N" end
		GameTooltip:AddDoubleLine(name, fmttime(reset),1 ,1, 1, tr, tg, tb)
		end
	end

	local startTimer = GetTime()
	local actualtime = GetTime()
	played = actualtime - startTimer
	if played > 60 then
		GameTooltip:AddDoubleLine(TIME_PLAYED_MSG..": ", D.FormatTime(played))
	end

	GameTooltip:AddDoubleLine(" ", " ")

	GameTooltip:AddDoubleLine(L.Worldboss.title)
	if UnitLevel("player") == 90 then
		local Sha = IsQuestFlaggedCompleted(32099)
		local Galleon = IsQuestFlaggedCompleted(32098)
		local Oondasta = IsQuestFlaggedCompleted(32519)
		local Nalak = IsQuestFlaggedCompleted(32518)
		local Celestials = IsQuestFlaggedCompleted(33117)
		local Ordos = IsQuestFlaggedCompleted(33118)

		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Sha.."|r: ", Sha and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Galleon.."|r: ", Galleon and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Oondasta.."|r: ", Oondasta and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Nalak.."|r: ", Nalak and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Celestials.."|r: ", Celestials and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L.Worldboss.Ordos.."|r: ", Ordos and "|cff00ff00"..L.Worldboss.Defeated.."|r" or "|cffff0000"..L.Worldboss.Undefeated.."|r")
	end
	GameTooltip:Show()
end

local OnLeave = function() GameTooltip:Hide() end

local OnMouseUp = function(self, btn)
	if btn == "RightButton" then
		ToggleTimeManager()
	else
		GameTimeFrame:Click()
	end
end

local Enable = function(self)	
	self:SetScript("OnUpdate", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:Update(1)
end

local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)
end

DataText:Register("Time", Enable, Disable, Update)