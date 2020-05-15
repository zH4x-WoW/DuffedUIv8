local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('Welcome Animation', 'AceEvent-3.0', 'AceHook-3.0')

-- Sourced: NDui (Siweia)

local soundID = SOUNDKIT.UI_LEGENDARY_LOOT_TOAST
local PlaySound = PlaySound

local needAnimation

function Module:Logo_PlayAnimation()
	if needAnimation then
		Module.logoFrame:Show()
		D:UnregisterEvent(self, Module.Logo_PlayAnimation)
		needAnimation = false
	end
end

function Module:Logo_CheckStatus(isInitialLogin)
	if isInitialLogin and not (IsInInstance() and InCombatLockdown()) then
		needAnimation = true
		Module:Logo_Create()
		D:RegisterEvent('PLAYER_STARTED_MOVING', Module.Logo_PlayAnimation)
	end
	D:UnregisterEvent(self, Module.Logo_CheckStatus)
end

function Module:Logo_Create()
	local frame = CreateFrame('Frame', nil, UIParent)
	frame:SetSize(300, 150)
	frame:SetPoint('CENTER', UIParent, 'BOTTOM', -500, GetScreenHeight()*.618)
	frame:SetFrameStrata('HIGH')
	frame:SetAlpha(0)
	frame:Hide()

	local tex = frame:CreateTexture()
	tex:SetAllPoints()
	tex:SetTexture(C['media']['duffed_logo'])
	
	local welcome = frame:CreateFontString(nil, 'OVERLAY')
	welcome:SetFont(C['media']['font'], 20, 'OUTLINE')
	welcome:SetText(L['welcome']['welcome_1'])
	welcome:SetPoint('TOP', frame, 'BOTTOM', 0, 24)
	
	local welcome2 = frame:CreateFontString(nil, 'OVERLAY')
	welcome2:SetFont(C['media']['font'], 20, 'OUTLINE')
	welcome2:SetText(L['welcome']['welcome_2'])
	welcome2:SetPoint('TOP', frame, 'BOTTOM', 0, 2)

	local delayTime = .2
	local timer1 = .5
	local timer2 = 3.5
	local timer3 = .2

	local anim = frame:CreateAnimationGroup()

	anim.move1 = anim:CreateAnimation('Translation')
	anim.move1:SetOffset(480, 0)
	anim.move1:SetDuration(timer1)
	anim.move1:SetStartDelay(delayTime)

	anim.fadeIn = anim:CreateAnimation('Alpha')
	anim.fadeIn:SetFromAlpha(0)
	anim.fadeIn:SetToAlpha(1)
	anim.fadeIn:SetDuration(timer1)
	anim.fadeIn:SetSmoothing('IN')
	anim.fadeIn:SetStartDelay(delayTime)

	delayTime = delayTime + timer1

	anim.move2 = anim:CreateAnimation('Translation')
	anim.move2:SetOffset(80, 0)
	anim.move2:SetDuration(timer2)
	anim.move2:SetStartDelay(delayTime)

	delayTime = delayTime + timer2

	anim.move3 = anim:CreateAnimation('Translation')
	anim.move3:SetOffset(-40, 0)
	anim.move3:SetDuration(timer3)
	anim.move3:SetStartDelay(delayTime)

	delayTime = delayTime + timer3

	anim.move4 = anim:CreateAnimation('Translation')
	anim.move4:SetOffset(480, 0)
	anim.move4:SetDuration(timer1)
	anim.move4:SetStartDelay(delayTime)

	anim.fadeOut = anim:CreateAnimation('Alpha')
	anim.fadeOut:SetFromAlpha(1)
	anim.fadeOut:SetToAlpha(0)
	anim.fadeOut:SetDuration(timer1)
	anim.fadeOut:SetSmoothing('OUT')
	anim.fadeOut:SetStartDelay(delayTime)

	frame:SetScript('OnShow', function()
		anim:Play()
	end)
	anim:SetScript('OnFinished', function()
		frame:Hide()
	end)
	anim.fadeIn:SetScript('OnFinished', function()
		PlaySound(soundID, 'master')
	end)

	Module.logoFrame = frame
end

function Module:LoginAnimation()
	D:RegisterEvent('PLAYER_ENTERING_WORLD', Module.Logo_CheckStatus)

	function PlayDuffedUILogo()
		if not Module.logoFrame then
			Module:Logo_Create()
		end
		Module.logoFrame:Show()
	end
end

function Module:OnEnable()
	if not C['general'].welcome then return end
	self:LoginAnimation()
end	