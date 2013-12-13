local T, C, L = select(2, ...):unpack()

if (not C.Chat.Enable and not C.Chat.WhisperSound) then
	return
end

local DuffedUIChat = T["Chat"]

function DuffedUIChat:PlayWhisperSound()
	PlaySoundFile(C.Medias.Whisper)
end

DuffedUIChat.WhisperSound = CreateFrame("Frame")
DuffedUIChat.WhisperSound:RegisterEvent("CHAT_MSG_WHISPER")
DuffedUIChat.WhisperSound:RegisterEvent("CHAT_MSG_BN_WHISPER")
DuffedUIChat.WhisperSound:SetScript("OnEvent", DuffedUIChat.PlayWhisperSound)