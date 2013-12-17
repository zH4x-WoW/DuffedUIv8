local D, C, L = select(2, ...):unpack()

if (not C.Chat.Enable) then
	return
end

local DuffedUIChat = T["Chat"]
local gsub = gsub
local strsub = strsub
local Color = D.RGBToHex(unpack(C.Chat.LinkColor)) or "FFFF00"
local UseBracket = C.Chat.LinkBrackets
local UseColor = true

function DuffedUIChat:PrintURL(url)
	if UseColor then
		if UseBracket then
			url = Color.."|Hurl:"..url.."|h["..url.."]|h|r "
		else
			url = Color.."|Hurl:"..url.."|h"..url.."|h|r "
		end
	else
		if UseBracket then
			url = "|Hurl:"..url.."|h["..url.."]|h "
		else
			url = "|Hurl:"..url.."|h"..url.."|h "
		end
	end
	
	return url
end

function DuffedUIChat:FindURL(event, msg, ...)
	local NewMsg, Found = gsub(msg, "(%a+)://(%S+)%s?", DuffedUIChat:PrintURL("%1://%2"))
	
	if (Found > 0) then
		return false, NewMsg, ...
	end
	
	NewMsg, Found = gsub(msg, "www%.([_A-Za-z0-9-]+)%.(%S+)%s?", DuffedUIChat:PrintURL("www.%1.%2"))
	
	if (Found > 0) then
		return false, NewMsg, ...
	end

	NewMsg, Found = gsub(msg, "([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", DuffedUIChat:PrintURL("%1@%2%3%4"))
	
	if (Found > 0) then
		return false, NewMsg, ...
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", DuffedUIChat.FindURL)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_CONVERSATION", DuffedUIChat.FindURL)

local CurrentLink = nil
local ChatFrame_OnHyperlinkShow_Original = ChatFrame_OnHyperlinkShow

ChatFrame_OnHyperlinkShow = function(self, link, ...)
	if (strsub(link, 1, 3) == "url") then
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		
		CurrentLink = (link):sub(5)
		
		if (not ChatFrameEditBox:IsShown()) then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end
		
		ChatFrameEditBox:Insert(CurrentLink)
		ChatFrameEditBox:HighlightText()
		CurrentLink = nil
		return
	end
	
	ChatFrame_OnHyperlinkShow_Original(self, link, ...)
end