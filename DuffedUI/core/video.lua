local D, C, L = unpack(select(2, ...))

local RequireRestart = false
local Adjust = (D['ScreenHeight'] / 10000) / 2
local UIScale = min(2, max(0.01, 768 / string.match(D['Resolution'], "%d+x(%d+)")))

if C['general']['autoscale'] then
	if D['ScreenHeight'] >= 1600 then
		UIScale = UIScale + (Adjust * 1.82222)
	else
		UIScale = UIScale
	end
	C['general']['uiscale'] = UIScale
end

D['CreatePopup']['CLIENT_RESTART'] = {
	Question = L['misc']['Resolution'],
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		RequireRestart = false
		ForceQuit()
	end,
	Function2 = function(self)
		RequireRestart = false
	end,
}

local Graphic = CreateFrame('Frame')
Graphic:RegisterEvent('PLAYER_ENTERING_WORLD')
Graphic:SetScript('OnEvent', function(self, event)
	if (event == 'DISPLAY_SIZE_CHANGED') then
		if C['general']['autoscale'] and not RequireRestart then D['ShowPopup']('CLIENT_RESTART') end
		RequireRestart = true
	else
		local UseUIScale = GetCVar('useUiScale')

		if (UseUIScale ~= '1') then SetCVar('useUiScale', 1) end
		if (format('%.2f', GetCVar('uiScale')) ~= format('%.2f', C['general']['uiscale'])) then SetCVar('uiScale', C['general']['uiscale']) end

		--[[Allow 4K and WQHD Resolution with UIScale lower than 0.64]]--
		if (C['general']['uiscale'] < 0.64) then UIParent:SetScale(C['general']['uiscale']) end

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		self:RegisterEvent('DISPLAY_SIZE_CHANGED')
	end
end)
