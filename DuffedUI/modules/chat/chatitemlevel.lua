local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('ChatItemLevel', 'AceEvent-3.0', 'AceHook-3.0')

local _G = _G
local pairs = _G.pairs
local string_find = _G.string.find
local string_gsub = _G.string.gsub
local string_match = _G.string.match

local GetItemInfo = _G.GetItemInfo
local GetItemStats = _G.GetItemStats

local itemCache = {}

local function isItemHasLevel(link)
	local name, _, rarity, level, _, _, _, _, _, _, _, classID = GetItemInfo(link)
	if name and level and rarity > 1 and (classID == LE_ITEM_CLASS_WEAPON or classID == LE_ITEM_CLASS_ARMOR) then
		local itemLevel = D.GetItemLevel(link)
		return name, itemLevel
	end
end

local function isItemHasGem(link)
	local stats = GetItemStats(link)
	for index in pairs(stats) do
		if string_find(index, 'EMPTY_SOCKET_') then
			return '|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Prismatic:0|t'
		end
	end

	return ''
end

local function isItemCorrupted(link)
	return IsCorruptedItem(link) and '|T3004126:0:0:0:0:64:64:5:59:5:59|t' or ''
end

local function convertItemLevel(link)
	if itemCache[link] then
		return itemCache[link]
	end

	local itemLink = string_match(link, '|Hitem:.-|h')
	if itemLink then
		local name, itemLevel = isItemHasLevel(itemLink)
		if name and itemLevel then
			link = string_gsub(link, '|h%[(.-)%]|h', '|h['..name..'('..itemLevel..')]|h'..isItemCorrupted(itemLink)..isItemHasGem(itemLink))
			itemCache[link] = link
		end
	end

	return link
end

function Module:UpdateChatItemLevel(_, msg, ...)
	msg = string_gsub(msg, '(|Hitem:%d+:.-|h.-|h)', convertItemLevel)

	return false, msg, ...
end

function Module:OnEnable()
	if C['chat'].chatitemlevel then
		ChatFrame_AddMessageEventFilter('CHAT_MSG_LOOT', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_SAY', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_YELL', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_WHISPER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_WHISPER_INFORM', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_RAID', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_RAID_LEADER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_PARTY', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_PARTY_LEADER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_GUILD', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_BATTLEGROUND', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_INSTANCE_CHAT', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_INSTANCE_CHAT_LEADER', self.UpdateChatItemLevel)
	end
end 