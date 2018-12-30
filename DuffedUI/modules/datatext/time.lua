local D, C, L = unpack(select(2, ...))
if not C['datatext']['wowtime'] or C['datatext']['wowtime'] == 0 then return end

local Stat = CreateFrame('Frame')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text  = DuffedUIInfoLeft:CreateFontString(nil, 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['wowtime'], Text)

-- Check Invasion Status
local invIndex = {
	[1] = {title = "Legion Invasion", duration = 66600, maps = {630, 641, 650, 634}, timeTable = {4, 3, 2, 1, 4, 2, 3, 1, 2, 4, 1, 3}, baseTime = 1517274000}, -- 1/30 9:00 [1]
	[2] = {title = "Battle for Azeroth Invasion", duration = 68400, maps = {862, 863, 864, 896, 942, 895}, timeTable = {4, 1, 6, 2, 5, 3}, baseTime = 1544691600}, -- 12/13 17:00 [1]
}

local mapAreaPoiIDs = {
	[630] = 5175,
	[641] = 5210,
	[650] = 5177,
	[634] = 5178,
	[862] = 5973,
	[863] = 5969,
	[864] = 5970,
	[896] = 5964,
	[942] = 5966,
	[895] = 5896,
}

local function GetInvasionTimeInfo(mapID)
	local areaPoiID = mapAreaPoiIDs[mapID]
	local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	return seconds, mapInfo.name
end

local function CheckInvasion(index)
	for _, mapID in pairs(invIndex[index].maps) do
		local timeLeft, name = GetInvasionTimeInfo(mapID)
		if timeLeft and timeLeft > 0 then
			return timeLeft, name
		end
	end
end

local function GetNextTime(baseTime, index)
	local currentTime = time()
	local duration = invIndex[index].duration
	local elapsed = mod(currentTime - baseTime, duration)
	return duration - elapsed + currentTime
end

local function GetNextLocation(nextTime, index)
	local inv = invIndex[index]
	local count = #inv.timeTable
	local elapsed = nextTime - inv.baseTime
	local round = mod(floor(elapsed / inv.duration) + 1, count)

	if round == 0 then
		round = count
	end

	return C_Map.GetMapInfo(inv.maps[inv.timeTable[round]]).name
end

local title
local function addTitle(text)
	if not title then
		GameTooltip:AddLine(' ')
		--GameTooltip:AddLine(text..":", .6,.8,1)
		GameTooltip:AddLine(text..":")
		title = true
	end
end

local int = 1
local function Update(self, t)
	local pendingCalendarInvites = C_Calendar.GetNumPendingInvites()
	int = int - t
	if int < 0 then
		if C['datatext']['localtime'] then
			Hr24 = tonumber(date('%H'))
			Hr = tonumber(date('%I'))
			Min = date('%M')
			if C['datatext']['time24'] then
				if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr24..':'..Min) else Text:SetText(Hr24..':'..Min)
			end
		else
			if Hr24 >= 12 then
				if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr..':'..Min..' |cffffffffpm|r') else Text:SetText(Hr..':'..Min..' |cffffffffpm|r') end
			else
				if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr..':'..Min..' |cffffffffam|r') else Text:SetText(Hr..':'..Min..' |cffffffffam|r') end
			end
		end
	else
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = '0'..Min end
		if C['datatext']['time24'] then
			if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr..':'..Min..' |cffffffff|r') else Text:SetText(Hr..':'..Min..' |cffffffff|r') end
		else
			if Hr >= 12 then
				if Hr > 12 then Hr = Hr - 12 end
				if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr..':'..Min..' |cffffffffpm|r') else Text:SetText(Hr..':'..Min..' |cffffffffpm|r') end
			else
				if Hr == 0 then Hr = 12 end
				if pendingCalendarInvites > 0 then Text:SetText('|cffFF0000'..Hr..':'..Min..' |cffffffffam|r') else Text:SetText(Hr..':'..Min..' |cffffffffam|r') end
			end
		end
	end
	self:SetAllPoints(Text)
	int = 1
	end
end

Stat:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	OnLoad = function(self) RequestRaidInfo() end
	if panel == DuffedUIMinimapStatsLeft or panel == DuffedUIMinimapStatsRight then
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	else
		GameTooltip:SetOwner(self, anchor, xoff, yoff)
	end
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	local pvp = GetNumWorldPVPAreas()
	local r, g, b = 1, 1, 1
	for i = 1, pvp do
		local timeleft = select(5, GetWorldPVPAreaInfo(i))
		local name = select(2, GetWorldPVPAreaInfo(i))
		local inprogress = select(3, GetWorldPVPAreaInfo(i))
		local inInstance, instanceType = IsInInstance()
		if not ( instanceType == 'none' ) then
			timeleft = QUEUE_TIME_UNAVAILABLE
		elseif inprogress then
			timeleft = WINTERGRASP_IN_PROGRESS
		else
			local hour = tonumber(format('%01.f', floor(timeleft / 3600)))
			local min = format(hour>0 and '%02.f' or '%01.f', floor(timeleft / 60 - (hour * 60)))
			local sec = format('%02.f', floor(timeleft - hour * 3600 - min * 60)) 
			timeleft = (hour>0 and hour..':' or '')..min..':'..sec
		end
		GameTooltip:AddDoubleLine(L['dt']['timeto'] .. ' ' .. name, timeleft)
	end
	GameTooltip:AddLine(' ')

	if C['datatext']['localtime'] then
		local Hr, Min = GetGameTime()
		if Min < 10 then Min = '0'..Min end
		if C['datatext']['time24'] then
			GameTooltip:AddDoubleLine(L['dt']['server_time'], Hr .. ':' .. Min)
		else
			if Hr >= 12 then
				Hr = Hr - 12
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L['dt']['server_time'], Hr .. ':' .. Min..' PM')
			else
				if Hr == 0 then Hr = 12 end
				GameTooltip:AddDoubleLine(L['dt']['server_time'], Hr .. ':' .. Min..' AM')
			end
		end
	else
		Hr24 = tonumber(date('%H'))
		Hr = tonumber(date('%I'))
		Min = date('%M')
		if C['datatext']['time24'] then
			GameTooltip:AddDoubleLine(L['dt']['local_time'], Hr24 .. ':' .. Min)
		else
			if Hr24 >= 12 then
				GameTooltip:AddDoubleLine(L['dt']['local_time'], Hr .. ':' .. Min..' PM')
			else
				GameTooltip:AddDoubleLine(L['dt']['local_time'], Hr .. ':' .. Min..' AM')
			end
		end
	end  

	local oneraid
	for i = 1, GetNumSavedInstances() do
		local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers = GetSavedInstanceInfo(i)
		if isRaid and (locked or extended) then
			local tr, tg, tb, diff
			if not oneraid then
				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(L['dt']['raid'])
				oneraid = true
			end

			local function fmttime(sec, table)
			local table = table or {}
			local d, h, m, s = ChatFrame_TimeBreakDown(floor(sec))
			local string = gsub(gsub(format(' %dd %dh %dm ' .. ((d == 0 and h == 0) and '%ds' or ''), d, h, m, s), ' 0[dhms]', ' '), '%s+', ' ')
			local string = strtrim(gsub(string, '([dhms])', {d = table.days or 'd', h = table.hours or 'h', m = table.minutes or 'm', s = table.seconds or 's'}), ' ')
			return strmatch(string, '^%s*$') and '0' .. (table.seconds or L's') or string
		end
		if extended then tr, tg, tb = .3, 1, .3 else tr, tg, tb = 1, 1, 1 end
		if difficulty == 3 or difficulty == 4 then diff = 'H' else diff = 'N' end
		GameTooltip:AddDoubleLine(name, fmttime(reset), 1, 1, 1, 1, 0, 0)
		end
	end

	local Worldboss = GetNumSavedWorldBosses()
	if Worldboss > 0 then
		GameTooltip:AddLine(' ')
		GameTooltip:AddDoubleLine(RAID_INFO_WORLD_BOSS..'(s)')
		for i = 1, Worldboss do
			name, _, reset = GetSavedWorldBossInfo(i)
			if name and reset then GameTooltip:AddDoubleLine(name, SecondsToTime(reset), 1, 1, 1, 1, 0, 0) end
		end
	end

	for index, value in ipairs(invIndex) do
		title = false
		addTitle(value.title)
		local timeLeft, zoneName = CheckInvasion(index)
		local nextTime = GetNextTime(value.baseTime, index)
		if timeLeft then
			timeLeft = timeLeft / 60
			if timeLeft < 60 then
				r,g,b = 1, 0, 0
			else
				r,g,b = 0, 1, 0
			end
			GameTooltip:AddDoubleLine('Current Invasion '..zoneName, string.format('%.2d:%.2d', timeLeft / 60, timeLeft % 60), 1, 1, 1, r, g, b)
		end
		if C['datatext']['time24'] then
			GameTooltip:AddDoubleLine("Next Invasion "..GetNextLocation(nextTime, index), date("%d.%m / %H:%M", nextTime), 1, 1, 1, 1, 1, 1)
		else
			GameTooltip:AddDoubleLine('Next Invasion '..GetNextLocation(nextTime, index), date('%m/%d %H:%M', nextTime), 1, 1, 1, 1, 1, 1)
		end
	end

	GameTooltip:Show()
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
Stat:RegisterEvent('CALENDAR_UPDATE_PENDING_INVITES')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:RegisterEvent('TIME_PLAYED_MSG')
Stat:SetScript('OnUpdate', Update)
Stat:RegisterEvent('UPDATE_INSTANCE_INFO')
Stat:SetScript('OnMouseDown', function(self, btn)
	if btn == 'RightButton'  then ToggleTimeManager() else GameTimeFrame:Click() end
end)
Update(Stat, 10)