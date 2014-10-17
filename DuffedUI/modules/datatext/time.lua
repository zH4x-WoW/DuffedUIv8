local D, C, L = unpack(select(2, ...))

-- TIME
if not C["datatext"].wowtime and C["datatext"].wowtime == 0 then return end

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

local font = D.Font(C["font"].datatext)
local Text  = DuffedUIInfoLeft:CreateFontString(nil, "OVERLAY")
Text:SetFontObject(font)
D.DataTextPosition(C["datatext"].wowtime, Text)

local int = 1
local function Update(self, t)
	local pendingCalendarInvites = CalendarGetNumPendingInvites()
	int = int - t
	if int < 0 then
		if C["datatext"].localtime == true then
			Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = date("%M")
			if C["datatext"].time24 == true then
				if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr24..":"..Min) else Text:SetText(Hr24..":"..Min)
			end
		else
			if Hr24 >= 12 then
				if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r") else Text:SetText(Hr..":"..Min.." |cffffffffpm|r") end
			else
				if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r") else Text:SetText(Hr..":"..Min.." |cffffffffam|r") end
			end
		end
	else
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = "0"..Min end
		if C["datatext"].time24 == true then
			if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffff|r") else Text:SetText(Hr..":"..Min.." |cffffffff|r") end
		else
			if Hr >= 12 then
				if Hr > 12 then Hr = Hr - 12 end
				if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r") else Text:SetText(Hr..":"..Min.." |cffffffffpm|r") end
			else
				if Hr == 0 then Hr = 12 end
				if pendingCalendarInvites > 0 then Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r") else Text:SetText(Hr..":"..Min.." |cffffffffam|r") end
			end
		end
	end
	self:SetAllPoints(Text)
	int = 1
	end
end

Stat:SetScript("OnEnter", function(self)
	if not C["datatext"].ShowInCombat then
		if InCombatLockdown() then return end
	end

	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	OnLoad = function(self) RequestRaidInfo() end
	if panel == DuffedUIMinimapStatsLeft or panel == DuffedUIMinimapStatsRight then GameTooltip:SetOwner(panel, anchor, xoff, yoff) else GameTooltip:SetOwner(self, anchor, xoff, yoff) end
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
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
			local min = format(hour>0 and "%02.f" or "%01.f", floor(timeleft / 60 - (hour * 60)))
			local sec = format("%02.f", floor(timeleft - hour * 3600 - min * 60)) 
			timeleft = (hour>0 and hour..":" or "")..min..":"..sec
		end
		GameTooltip:AddDoubleLine(L["dt"]["timeto"] .. " " .. name, timeleft)
	end
	GameTooltip:AddLine(" ")

	if C["datatext"].localtime == true then
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = "0"..Min end
		if C["datatext"].time24 == true then
			GameTooltip:AddDoubleLine(L["dt"]["server_time"], Hr .. ":" .. Min)
		else
			if Hr >= 12 then
				Hr = Hr - 12
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L["dt"]["server_time"], Hr .. ":" .. Min.." PM")
			else
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L["dt"]["server_time"], Hr .. ":" .. Min.." AM")
			end
		end
	else
		Hr24 = tonumber(date("%H"))
		Hr = tonumber(date("%I"))
		Min = date("%M")
		if C["datatext"].time24 == true then
			GameTooltip:AddDoubleLine(L["dt"]["local_time"], Hr24 .. ":" .. Min)
		else
			if Hr24 >= 12 then GameTooltip:AddDoubleLine(L["dt"]["local_time"], Hr .. ":" .. Min.." PM") else GameTooltip:AddDoubleLine(L["dt"]["local_time"], Hr .. ":" .. Min.." AM") end
		end
	end  

	local oneraid
	for i = 1, GetNumSavedInstances() do
		local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers = GetSavedInstanceInfo(i)
		if isRaid and (locked or extended) then
			local tr, tg, tb, diff
			if not oneraid then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L["dt"]["raid"])
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

	if UnitLevel("player") >= 91 then
		for i = 1, GetNumSavedWorldBosses() do
			name, instanceID, reset = GetWorldBossInfo(i)
			if reset then
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(RAID_INFO_WORLD_BOSS.."(s)")
				GameTooltip:AddDoubleLine(name, SecondsToTime(reset), 1, 1, 1, .8, .8, .8)
			end
		end
	end

	if UnitLevel("player") == 90 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(RAID_INFO_WORLD_BOSS.."(s)")
		local Sha = IsQuestFlaggedCompleted(32099)
		local Galleon = IsQuestFlaggedCompleted(32098)
		local Oondasta = IsQuestFlaggedCompleted(32519)
		local Nalak = IsQuestFlaggedCompleted(32518)
		local Celestials = IsQuestFlaggedCompleted(33117)
		local Ordos = IsQuestFlaggedCompleted(33118)

		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["sha"].."|r: ", Sha and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["galleon"].."|r: ", Galleon and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["oondasta"].."|r: ", Oondasta and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["nalak"].."|r: ", Nalak and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["celestials"].."|r: ", Celestials and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
		GameTooltip:AddDoubleLine("|cffffffff"..L["boss"]["ordos"].."|r: ", Ordos and "|cff00ff00"..L["boss"]["defeated"].."|r" or "|cffff0000"..L["boss"]["undefeated"].."|r")
	end
	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("TIME_PLAYED_MSG")
Stat:SetScript("OnUpdate", Update)
Stat:RegisterEvent("UPDATE_INSTANCE_INFO")
Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == 'RightButton'  then ToggleTimeManager() else GameTimeFrame:Click() end
end)
Update(Stat, 10)