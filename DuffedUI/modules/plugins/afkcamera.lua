local D, C, L = unpack(select(2, ...))
if C['misc'].AFKCamera ~= true then return end

local PName = UnitName('player')
local PLevel = UnitLevel('player')
local PClass = UnitClass('player')
local PRace = UnitRace('player')
local PFaction = UnitFactionGroup('player')
local color = D['RGBToHex'](unpack(C['media'].datatextcolor1))
local Version = D['Version']

--[[Guild]]--
local function GuildText()
	if IsInGuild() then
		local guildName = GetGuildInfo('player')
		DuffedUIAFKPanel.GuildText:SetText(color .. guildName .. '|r')
	else
		DuffedUIAFKPanel.GuildText:SetText(' ')
	end
end

--[[AFK-Timer]]--
local function UpdateTimer()
	local time = GetTime() - startTime
	DuffedUIAFKPanel.AFKTimer:SetText(format('%02d' .. color ..':|r%02d', floor(time/60), time % 60))
end

--[[Playermodel]]--
local function Model()
	DuffedUIAFKPanel.modelHolder = CreateFrame('Frame', 'AFKPlayerModelHolder', DuffedUIAFKPanel)
	DuffedUIAFKPanel.modelHolder:SetSize(150, 150)
	if GetScreenWidth() >= 1921 then
		DuffedUIAFKPanel.modelHolder:SetPoint('BOTTOMRIGHT', DuffedUIAFKPanel, 'TOPRIGHT', -450, 115)
	else
		DuffedUIAFKPanel.modelHolder:SetPoint('BOTTOMRIGHT', DuffedUIAFKPanel, 'TOPRIGHT', -150, 120)
	end

	DuffedUIAFKPanel.model = CreateFrame('PlayerModel', 'AFKPlayerModel', DuffedUIAFKPanel.modelHolder)
	DuffedUIAFKPanel.model:SetPoint('CENTER', DuffedUIAFKPanel.modelHolder, 'CENTER')
	DuffedUIAFKPanel.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
	if GetScreenWidth() >= 1921 then
		DuffedUIAFKPanel.model:SetCamDistanceScale(8)
	else
		DuffedUIAFKPanel.model:SetCamDistanceScale(6)
	end
	DuffedUIAFKPanel.model:SetFacing(6)
	DuffedUIAFKPanel.model:SetUnit('player')
	DuffedUIAFKPanel.model:SetAnimation(0)
	DuffedUIAFKPanel.model:SetRotation(math.rad(-15))
end

--[[Spin function]]--
function SpinStart()
	spinning = true
	MoveViewRightStart(.1)
end

function SpinStop()
	if(not spinning) then return end
	spinning = nil
	MoveViewRightStop()
end

--[[Frames]]--
local DuffedUIAFKPanel = CreateFrame('Frame', 'DuffedUIAFKPanel', nil)
DuffedUIAFKPanel:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 100)
DuffedUIAFKPanel:SetSize((D['ScreenWidth'] * C['general']['uiscale']), 80)
DuffedUIAFKPanel:SetTemplate('Transparent')
DuffedUIAFKPanel:SetFrameStrata('FULLSCREEN')
DuffedUIAFKPanel:Hide()

local DuffedUIAFKPanelIcon = CreateFrame('Frame', 'DuffedUIAFKPanelIcon', DuffedUIAFKPanel)
DuffedUIAFKPanelIcon:Size(48)
DuffedUIAFKPanelIcon:Point('CENTER', DuffedUIAFKPanel, 'TOP', 0, 0)
DuffedUIAFKPanelIcon:SetTemplate('Default')

DuffedUIAFKPanelIcon.Texture = DuffedUIAFKPanelIcon:CreateTexture(nil, 'ARTWORK')
DuffedUIAFKPanelIcon.Texture:Point('TOPLEFT', 2, -2)
DuffedUIAFKPanelIcon.Texture:Point('BOTTOMRIGHT', -2, 2)
DuffedUIAFKPanelIcon.Texture:SetTexture(C['media'].duffed)

DuffedUIAFKPanel.DuffedUIText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.DuffedUIText:SetPoint('CENTER', DuffedUIAFKPanel, 'CENTER', 0, -10)
DuffedUIAFKPanel.DuffedUIText:SetFont(C['media']['font'], 40, 'OUTLINE')
DuffedUIAFKPanel.DuffedUIText:SetText('|cffc41f3bDuffedUI ' .. Version)

DuffedUIAFKPanel.DateText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.DateText:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -475, 54)
else	
	DuffedUIAFKPanel.DateText:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -100, 54)
end
DuffedUIAFKPanel.DateText:SetFont(C['media']['font'], 15, 'OUTLINE')

DuffedUIAFKPanel.ClockText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.ClockText:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -475, 30)
else
	DuffedUIAFKPanel.ClockText:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -100, 30)
end
DuffedUIAFKPanel.ClockText:SetFont(C['media']['font'], 20, 'OUTLINE')

DuffedUIAFKPanel.AFKTimer = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.AFKTimer:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -475, 6)
else
	DuffedUIAFKPanel.AFKTimer:SetPoint('BOTTOMLEFT', DuffedUIAFKPanel, 'BOTTOMRIGHT', -100, 6)
end
DuffedUIAFKPanel.AFKTimer:SetFont(C['media']['font'], 20, 'OUTLINE')

DuffedUIAFKPanel.PlayerNameText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.PlayerNameText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 395, 15)
else
	DuffedUIAFKPanel.PlayerNameText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 25, 15)
end
DuffedUIAFKPanel.PlayerNameText:SetFont(C['media']['font'], 28, 'OUTLINE')
DuffedUIAFKPanel.PlayerNameText:SetText(color .. PName .. '|r')

DuffedUIAFKPanel.GuildText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.GuildText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 395, -3)
else
	DuffedUIAFKPanel.GuildText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 25, -3)
end
DuffedUIAFKPanel.GuildText:SetFont(C['media']['font'], 15, 'OUTLINE')

DuffedUIAFKPanel.PlayerInfoText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
if GetScreenWidth() >= 1921 then
	DuffedUIAFKPanel.PlayerInfoText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 395, -20)
else
	DuffedUIAFKPanel.PlayerInfoText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 25, -20)
end
DuffedUIAFKPanel.PlayerInfoText:SetFont(C['media']['font'], 15, 'OUTLINE')
DuffedUIAFKPanel.PlayerInfoText:SetText(LEVEL .. ' ' .. PLevel .. ' ' .. PFaction .. ' ' .. color .. PClass .. '|r')

--[[Dynamic time & date]]--
local interval = 0
DuffedUIAFKPanel:SetScript('OnUpdate', function(self, elapsed)
	interval = interval - elapsed
	if interval <= 0 then
		DuffedUIAFKPanel.ClockText:SetText(format('%s', date('%H' .. color .. ':|r%M' .. color .. ':|r%S')))
		DuffedUIAFKPanel.DateText:SetText(format('%s', date(color .. '%a|r %b' .. color .. '/|r%d')))
		UpdateTimer()
		interval = 0.5
	end
end)

--[[Register events, script to start]]--
DuffedUIAFKPanel:RegisterEvent('PLAYER_FLAGS_CHANGED')
DuffedUIAFKPanel:RegisterEvent('PLAYER_REGEN_DISABLED')
DuffedUIAFKPanel:RegisterEvent('PLAYER_DEAD')
DuffedUIAFKPanel:SetScript('OnEvent', function(self, event, unit)
	if InCombatLockdown() then return end

	if event == 'PLAYER_FLAGS_CHANGED' then
		startTime = GetTime()
		if unit == 'player' then
			if UnitIsAFK(unit) and not UnitIsDead(unit) then
				SpinStart()
				DuffedUIAFKPanel:Show()
				GuildText()
				if not AFKPlayerModel then Model() end
				Minimap:Hide()
			else
				SpinStop()
				DuffedUIAFKPanel:Hide()
				Minimap:Show()
			end
		end
	elseif event == 'PLAYER_DEAD' then
		if UnitIsAFK('player') then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			Minimap:Show()
		end
	elseif event == 'PLAYER_REGEN_DISABLED' then
		if UnitIsAFK('player') then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			Minimap:Show()
		end
	end
end)

--[[Fade in & out]]--
DuffedUIAFKPanel:SetScript('OnShow', function(self) UIFrameFadeIn(UIParent, .5, 1, 0) end)
DuffedUIAFKPanel:SetScript('OnHide', function(self) UIFrameFadeOut(UIParent, .5, 0, 1) end)