local D, C, L = select(2, ...):unpack()

if (not C["chat"].Enable and not C["chat"].WhisperSound) then
	return
end

local DuffedUIChat = D["Chat"]

function DuffedUIChat:PlayWhisperSound()
	PlaySoundFile(C["medias"].Whisper)
end

DuffedUIChat.WhisperSound = CreateFrame("Frame")
DuffedUIChat.WhisperSound:RegisterEvent("CHAT_MSG_WHISPER")
DuffedUIChat.WhisperSound:RegisterEvent("CHAT_MSG_BN_WHISPER")
DuffedUIChat.WhisperSound:SetScript("OnEvent", DuffedUIChat.PlayWhisperSound)