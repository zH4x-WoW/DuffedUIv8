local D, C, L = unpack(select(2, ...)) 

-- GUILD ROSTER

if not C['datatext']['guild'] or C['datatext']['guild'] == 0 then return end

local C_GuildInfo_GuildRoster = C_GuildInfo.GuildRoster

local Stat = CreateFrame('Frame', 'DuffedUIStatGuild')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext']['guild']
Stat.update = false
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local tthead, ttsubh, ttoff = {r = .4, g = .78, b = 1}, {r = .75, g = .9, b = 1}, {r = .3, g = 1, b = .3}
local activezone, inactivezone = {r = .3, g = .0, b = .3}, {r = .65, g = .65, b = .65}
local displayString = string.join('', Stat.Color1..'%s: |r', Stat.Color2, '%d|r')
local guildInfoString = '%s [%d]'
local guildInfoString2 = '%s: %d/%d'
local guildMotDString = '  %s |cffaaaaaa- |cffffffff%s'
local levelNameString = '|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s'
local levelNameStatusString = '|cff%02x%02x%02x%d|r %s %s'
local nameRankString = '%s |cff999999-|cffffffff %s'
local noteString = '  "%s"'
local officerNoteString = '  o: "%s"'

local guildTable, guildXP, guildMotD = {}, {}, ''
local totalOnline = 0

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text = Stat:CreateFontString('DuffedUIStatGuildText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['guild'], Text)

local function BuildGuildTable()
	totalOnline = 0
	wipe(guildTable)
	local _, name, rank, level, zone, note, officernote, connected, status, class, isMobile
	for i = 1, GetNumGuildMembers() do
		name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, isMobile = GetGuildRosterInfo(i)

		name = string.gsub(name, '-.*', '')

		if status == 1 then
			status = '|cffff0000['..AFK..']|r'
		elseif status == 2 then
			status = '|cffff0000['..DND..']|r' 
		else
			status = ''
		end

		guildTable[i] = { name, rank, level, zone, note, officernote, connected, status, class, isMobile }
		if connected then totalOnline = totalOnline + 1 end
	end
	table.sort(guildTable, function(a, b)
		if a and b then return a[1] < b[1] end
	end)
end

local function UpdateGuildXP()
	local currentXP, remainingXP = UnitGetGuildXP('player')
	local nextLevelXP = currentXP + remainingXP

	if nextLevelXP == 0 or maxDailyXP == 0 then return end

	local percentTotal = tostring(math.ceil((currentXP / nextLevelXP) * 100))
	guildXP[0] = { currentXP, nextLevelXP, percentTotal }
end

local function UpdateGuildMessage() guildMotD = GetGuildRosterMOTD() end

local function Update(self, event, ...)
	if event == 'PLAYER_ENTERING_WORLD' then
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		if IsInGuild() and not GuildFrame then LoadAddOn('Blizzard_GuildUI') end
	end

	if IsInGuild() then
		C_GuildInfo_GuildRoster()
		totalOnline = select(3, GetNumGuildMembers())
		Text:SetFormattedText(displayString, GUILD, totalOnline)
	else
		Text:SetText(L['dt']['noguild'])
	end
	self:SetAllPoints(Text)
end

local menuFrame = CreateFrame('Frame', 'DuffedUIGuildRightClickMenu', UIParent, 'UIDropDownMenuTemplate')
local menuList = {
	{text = OPTIONS_MENU, isTitle = true, notCheckable = true,},
	{text = INVITE, hasArrow = true, notCheckable = true,},
	{text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true,}
}

local function inviteClick(self, arg1, arg2, checked)
	menuFrame:Hide()
	InviteUnit(arg1)
end

local function whisperClick(self,arg1,arg2,checked)
	menuFrame:Hide()
	SetItemRef( 'player:'..arg1, ('|Hplayer:%1$s|h[%1$s]|h'):format(arg1), 'LeftButton' )
end

local function ToggleGuildFrame()
	if IsInGuild() then 
		if not GuildFrame then GuildFrame_LoadUI() end 
		GuildFrame_Toggle()
	else 
		if not LookingForGuildFrame then LookingForGuildFrame_LoadUI() end
		if LookingForGuildFrame then LookingForGuildFrame_Toggle() end
	end
end

Stat:SetScript('OnMouseUp', function(self, btn)
	if btn ~= 'RightButton' or not IsInGuild() then return end
	GameTooltip:Hide()

	local classc, levelc, grouped
	local menuCountWhispers = 0
	local menuCountInvites = 0

	menuList[2].menuList = {}
	menuList[3].menuList = {}

	for i = 1, #guildTable do
		if (guildTable[i][7] and guildTable[i][1] ~= D['MyName']) then
			local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])

			if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
				grouped = '|cffaaaaaa*|r'
			else
				grouped = ''
				if not guildTable[i][10] then
					menuCountInvites = menuCountInvites + 1
					menuList[2].menuList[menuCountInvites] = {text = string.format(levelNameString, levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, guildTable[i][1], ''), arg1 = guildTable[i][1], notCheckable=true, func = inviteClick}
				end
			end
			menuCountWhispers = menuCountWhispers + 1
			menuList[3].menuList[menuCountWhispers] = {text = string.format(levelNameString, levelc.r * 255, levelc.g * 255, levelc.b * 255, guildTable[i][3], classc.r * 255, classc.g * 255, classc.b * 255, guildTable[i][1], grouped), arg1 = guildTable[i][1], notCheckable=true, func = whisperClick}
		end
	end
	Lib_EasyMenu(menuList, menuFrame, 'cursor', 0, 0, 'MENU', 2)
end)

Stat:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	if not IsInGuild() then return end

	C_GuildInfo_GuildRoster()
	UpdateGuildMessage()
	BuildGuildTable()

	local name, rank, level, zone, note, officernote, connected, status, class, isMobile
	local zonec, classc, levelc
	local online = totalOnline
	local GuildInfo, GuildRank, GuildLevel = GetGuildInfo('player')

	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	if GuildInfo then
		GameTooltip:AddDoubleLine(string.format(guildInfoString, GuildInfo, GuildLevel), string.format(guildInfoString2, GUILD, online, #guildTable), tthead.r, tthead.g, tthead.b, tthead.r, tthead.g, tthead.b)
	end
	if guildMotD ~= '' then
		GameTooltip:AddLine(' ') GameTooltip:AddLine(string.format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1)
	end

	local col = D['RGBToHex'](ttsubh.r, ttsubh.g, ttsubh.b)
	GameTooltip:AddLine(' ')

	local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
	if standingID ~= 8 then -- Not Max Rep
		barMax = barMax - barMin
		barValue = barValue - barMin
		barMin = 0
		GameTooltip:AddLine(string.format('%s:|r |cFFFFFFFF%s/%s (%s%%)',col..COMBAT_FACTION_CHANGE, D['ShortValue'](barValue), D['ShortValue'](barMax), math.ceil((barValue / barMax) * 100)))
	end

	if online > 1 then
		GameTooltip:AddLine(' ')
		for i = 1, #guildTable do
			if online <= 1 then
				if online > 1 then GameTooltip:AddLine(format('+ %d More...', online - modules.Guild.maxguild), ttsubh.r, ttsubh.g, ttsubh.b) end
				break
			end

			name, rank, level, zone, note, officernote, connected, status, class, isMobile = unpack(guildTable[i])
			if connected and name ~= D['MyName'] then
				if GetRealZoneText() == zone then zonec = activezone else zonec = inactivezone end
				classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)

				if isMobile then zone = '' end
				if IsShiftKeyDown() then
					GameTooltip:AddDoubleLine(string.format(nameRankString, name, rank), zone, classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
					if note ~= '' then GameTooltip:AddLine(string.format(noteString, note), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					if officernote ~= '' then GameTooltip:AddLine(string.format(officerNoteString, officernote), ttoff.r, ttoff.g, ttoff.b ,1) end
				else
					GameTooltip:AddDoubleLine(string.format(levelNameStatusString, levelc.r * 255, levelc.g * 255, levelc.b * 255, level, name, status), zone, classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
				end
			end
		end
	end
	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['dt']['guildleft'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON2..':', L['dt']['guildright'], 1, 1, 1)
	GameTooltip:Show()
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
Stat:SetScript('OnMouseDown', function(self, btn)
	if btn ~= 'LeftButton' then return end
	if C['datatext']['ogf'] then
		ToggleGuildFrame()
	else
		ToggleCommunitiesFrame()
	end
end)

Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:RegisterEvent('GUILD_ROSTER_UPDATE')
Stat:RegisterEvent('PLAYER_GUILD_UPDATE')
Stat:SetScript('OnEvent', Update)