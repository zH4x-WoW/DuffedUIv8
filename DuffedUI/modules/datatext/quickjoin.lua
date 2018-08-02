local D, C, L = unpack(select(2, ...)) 
if not C['datatext']['quickjoin'] or C['datatext']['quickjoin'] == 0 then return end

-- Credits to Elv, Simpy and Merathilis

-- Variables
local UNKNOWN = UNKNOWN
local QUICK_JOIN = QUICK_JOIN
local next, pairs, select, type = next, pairs, select, type
local twipe = table.wipe
local format, join = string.format, string.join
local C_LFGList = C_LFGList
local C_SocialQueue = C_SocialQueue
local SocialQueueUtil_GetNameAndColor = SocialQueueUtil_GetNameAndColor
local SocialQueueUtil_GetQueueName = SocialQueueUtil_GetQueueName
local SocialQueueUtil_SortGroupMembers = SocialQueueUtil_SortGroupMembers
local ToggleQuickJoinPanel = ToggleQuickJoinPanel
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'

local Stat = CreateFrame('Frame', 'DuffedUIStatquickjoin')
Stat:RegisterEvent('SOCIAL_QUEUE_UPDATE')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext']['orderhall']
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local Text  = Stat:CreateFontString('DuffedUIStatquickjoinText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['quickjoin'], Text)

local quickJoinGroups, quickJoin = nil, {}

function SocialQueueIsLeader(playerName, leaderName)
	if leaderName == playerName then
		return true
	end

	local numGameAccounts, accountName, isOnline, gameCharacterName, gameClient, realmName, _
	for i = 1, BNGetNumFriends() do
		_, accountName, _, _, _, _, _, isOnline = BNGetFriendInfo(i);
		if isOnline then
			numGameAccounts = BNGetNumFriendGameAccounts(i);
			if numGameAccounts > 0 then
				for y = 1, numGameAccounts do
					_, gameCharacterName, gameClient, realmName = BNGetFriendGameAccountInfo(i, y);
					if (gameClient == BNET_CLIENT_WOW) and (accountName == playerName) then
						playerName = gameCharacterName
						if realmName ~= D['MyRealm'] then
							playerName = format('%s-%s', playerName, gsub(realmName,'[%s%-]',''))
						end
						if leaderName == playerName then
							return true
						end
					end
				end
			end
		end
	end
end

local function Update(self, event)
	twipe(quickJoin)
	quickJoinGroups = C_SocialQueue.GetAllGroups()

	local coloredName, players, members, playerName, nameColor, firstMember, numMembers, extraCount, isLFGList, firstQueue, queues, numQueues, activityID, activityName, comment, leaderName, isLeader, activityFullName, activity, output, outputCount, queueCount, queueName, _

	for _, guid in pairs(quickJoinGroups) do
		coloredName, players = UNKNOWN, C_SocialQueue.GetGroupMembers(guid)
		members = players and SocialQueueUtil_SortGroupMembers(players)
		playerName, nameColor = '', ''
		if members then
			firstMember, numMembers, extraCount = members[1], #members, ''
			playerName, nameColor = SocialQueueUtil_GetNameAndColor(firstMember)
			if numMembers > 1 then
				extraCount = format('[+%s]', numMembers - 1)
			end
			if playerName then
				coloredName = format('%s%s|r%s', nameColor, playerName, extraCount)
			else
				coloredName = format('{%s%s}', UNKNOWN, extraCount)
			end
		end

		queues = C_SocialQueue.GetGroupQueues(guid)
		firstQueue, numQueues = queues and queues[1], queues and #queues or 0
		isLFGList = firstQueue and firstQueue.queueData and firstQueue.queueData.queueType == 'lfglist'

		if isLFGList and firstQueue and firstQueue.eligible then

			if firstQueue.queueData.lfgListID then
				_, activityID, activityName, comment, _, _, _, _, _, _, _, _, leaderName = C_LFGList.GetSearchResultInfo(firstQueue.queueData.lfgListID)
				isLeader = SocialQueueIsLeader(playerName, leaderName)
			end

			if isLeader then
				coloredName = format('|TInterface\\GroupFrame\\UI-Group-LeaderIcon:16:16|t%s', coloredName)
			end

			activity = activityName or UNKNOWN
			if numQueues > 1 then
				activity = format('[+%s]%s', numQueues - 1, activity)
			end
		elseif firstQueue then
			output, outputCount, queueCount = '', '', 0
			for _, queue in pairs(queues) do
				if type(queue) == 'table' and queue.eligible then
					queueName = (queue.queueData and SocialQueueUtil_GetQueueName(queue.queueData)) or ''
					if queueName ~= '' then
						if output == '' then
							output = queueName:gsub('\n.+','')
							queueCount = queueCount + select(2, queueName:gsub('\n',''))
						else
							queueCount = queueCount + 1 + select(2, queueName:gsub('\n',''))
						end
					end
				end
			end
			if output ~= '' then
				if queueCount > 0 then
					activity = format('%s[+%s]', output, queueCount)
				else
					activity = output
				end
			end
		end

		quickJoin[coloredName] = activity
	end
	if next(quickJoin) then
		Text:SetText(Stat.Color1 .. QUICK_JOIN, #quickJoinGroups)
	else
		Text:SetText(Stat.Color2 .. QUICK_JOIN)
	end
	self:SetAllPoints(Text)
end

Stat:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	
	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	
	GameTooltip_SetDefaultAnchor(GameTooltip, self)
	GameTooltip:ClearLines()

	if not next(quickJoin) then
		GameTooltip:AddLine(L['dt']['noquickjoin'], 1, 1, 1, 1)
		GameTooltip:Show() return
	end

	GameTooltip:AddLine(QUICK_JOIN, nil, nil, nil, true);
	GameTooltip:AddLine(' ')
	for name, activity in pairs(quickJoin) do
		GameTooltip:AddDoubleLine(name, activity, nil, nil, nil, 1, 1, 1);
	end
	GameTooltip:Show()
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)	
Stat:SetScript('OnEvent', Update)
Stat:SetScript('OnMouseDown', function() 
	ToggleQuickJoinPanel()
end)