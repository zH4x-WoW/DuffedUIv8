local T, C, L = select(2, ...):unpack()

if (not C.Chat.Enable and not C.Chat.WhisperSound) then
	return
end

local TukuiChat = T["Chat"]

function TukuiChat:PlayWhisperSound()
	PlaySoundFile(C.Medias.Whisper)
end

TukuiChat.WhisperSound = CreateFrame("Frame")
TukuiChat.WhisperSound:RegisterEvent("CHAT_MSG_WHISPER")
TukuiChat.WhisperSound:RegisterEvent("CHAT_MSG_BN_WHISPER")
TukuiChat.WhisperSound:SetScript("OnEvent", TukuiChat.PlayWhisperSound)