local D, C, L = unpack(select(2, ...))

local move = D['move']

local ileft = CreateFrame('Frame', 'DuffedUIInfoLeft', UIParent)
ileft:SetTemplate('Default')
ileft:Size(D['Scale'](D['InfoLeftRightWidth'] - 9), 19)
ileft:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 5, 3)
ileft:SetFrameLevel(2)
ileft:SetFrameStrata('BACKGROUND')

local iright = CreateFrame('Frame', 'DuffedUIInfoRight', UIParent)
iright:SetTemplate('Default')
iright:Size(D['Scale'](D['InfoLeftRightWidth'] - 9), 19)
iright:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -5, 3)
iright:SetFrameLevel(2)
iright:SetFrameStrata('BACKGROUND')

local icenter = CreateFrame('Frame', 'DuffedUIInfoCenter', UIParent)
icenter:SetTemplate('Default')
icenter:Size(378, 19)
icenter:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 3)
icenter:SetFrameLevel(2)
icenter:SetFrameStrata('BACKGROUND')
move:RegisterFrame(DuffedUIInfoCenter)
move:RegisterFrame(LossOfControlFrame)

local m_zone_text = icenter:CreateFontString('DuffedUIZoneText', 'Overlay')
m_zone_text:SetFont(C['media']['font'], C['datatext']['fontsize'])
m_zone_text:Point('CENTER', 0, 0)
m_zone_text:Height(11)
m_zone_text:Width(icenter:GetWidth() - 6)

local zone_Update = function()
	local pvp = GetZonePVPInfo()
	m_zone_text:SetText(GetMinimapZoneText())
	if pvp == 'friendly' then
		m_zone_text:SetTextColor(0.05, 0.85, 0.03)
	elseif pvp == 'sanctuary' then
		m_zone_text:SetTextColor(0.035, 0.58, 0.84)
	elseif pvp == 'arena' or pvp == 'hostile' then
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	elseif pvp == 'contested' then
		m_zone_text:SetTextColor(0.9, 0.85, 0.05)
	elseif pvp == 'combat' then
		m_zone_text:SetTextColor(0.84, 0.03, 0.03)
	else
		m_zone_text:SetTextColor(0.9, 0.85, 0.05)
	end
end
 
 local OnMouseDown = function(self, btn)
	if (btn ~= "LeftButton") then
		return
	end

	ToggleWorldMap()
end
 
icenter:RegisterEvent('PLAYER_ENTERING_WORLD')
icenter:RegisterEvent('ZONE_CHANGED_NEW_AREA')
icenter:RegisterEvent('ZONE_CHANGED')
icenter:RegisterEvent('ZONE_CHANGED_INDOORS')
icenter:SetScript('OnEvent', zone_Update)
icenter:SetScript('OnMouseDown', OnMouseDown)

if C['chat']['lbackground'] then
	local chatleftbg = CreateFrame('Frame', 'DuffedUIChatBackgroundLeft', DuffedUIInfoLeft)
	chatleftbg:SetTemplate('Transparent')
	--chatleftbg:Size(D['InfoLeftRightWidth'] + 12, 149)
	chatleftbg:SetSize(D['InfoLeftRightWidth'] + 12, 145)
	chatleftbg:Point('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 5, 24)
	chatleftbg:SetFrameLevel(1)

	local tabsbgleft = CreateFrame('Frame', 'DuffedUITabsLeftBackground', UIParent)
	tabsbgleft:SetTemplate()
	tabsbgleft:Size((D['InfoLeftRightWidth'] - 62), 20)
	tabsbgleft:Point('TOPLEFT', chatleftbg, 'TOPLEFT', 4, -4)
	tabsbgleft:SetFrameLevel(2)
	tabsbgleft:SetFrameStrata('BACKGROUND')
end

if C['chat']['rbackground'] then
	local chatrightbg = CreateFrame('Frame', 'DuffedUIChatBackgroundRight', DuffedUIInfoRight)
	chatrightbg:SetTemplate('Transparent')
	--chatrightbg:Size(D['InfoLeftRightWidth'] + 12, 149)
	chatrightbg:Size(D['InfoLeftRightWidth'] + 12, 145)
	chatrightbg:Point('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -5, 24)
	chatrightbg:SetFrameLevel(1)

	local tabsbgright = CreateFrame('Frame', 'DuffedUITabsRightBackground', UIParent)
	tabsbgright:SetTemplate()
	tabsbgright:Size((D['InfoLeftRightWidth'] - 189), 20)
	tabsbgright:Point('TOPLEFT', chatrightbg, 'TOPLEFT', 4, -4)
	tabsbgright:SetFrameLevel(2)
	tabsbgright:SetFrameStrata('BACKGROUND')
end

if C['actionbar']['enable'] then
	DuffedUIBar1Mover = CreateFrame('Frame', 'DuffedUIBar1Mover', UIParent)
	DuffedUIBar1Mover:SetSize((D['buttonsize'] * 12) + (D['buttonspacing'] * 13), (D['buttonsize'] * 1) + (D['buttonspacing'] * 2))
	if C['actionbar']['rightbarvertical'] then
		DuffedUIBar1Mover:SetPoint('BOTTOM', icenter, 'TOP', 0, 88)
	else
		DuffedUIBar1Mover:SetPoint('BOTTOM', icenter, 'TOP', 0, 39)
	end
	DuffedUIBar1Mover:SetFrameLevel(6)
	move:RegisterFrame(DuffedUIBar1Mover)

	local DuffedUIBar1 = CreateFrame('Frame', 'DuffedUIBar1', UIParent, 'SecureHandlerStateTemplate')
	if not C['actionbar']['hidepanels'] then DuffedUIBar1:SetTemplate('Transparent') end
	DuffedUIBar1:SetAllPoints(DuffedUIBar1Mover)
	DuffedUIBar1:SetFrameStrata('BACKGROUND')
	DuffedUIBar1:SetFrameLevel(1)
	

	local DuffedUIBar2 = CreateFrame('Frame', 'DuffedUIBar2', UIParent, 'SecureHandlerStateTemplate')
	if not C['actionbar']['hidepanels'] then DuffedUIBar2:SetTemplate('Transparent') end
	if C['actionbar']['rightbarvertical'] then
		DuffedUIBar2:SetPoint('BOTTOM', icenter, 'TOP', 0, 49)
	else
		DuffedUIBar2:SetPoint('BOTTOM', icenter, 'TOP', 0, 2)
	end
	DuffedUIBar2:SetSize((D['buttonsize'] * 12) + (D['buttonspacing'] * 13), (D['buttonsize'] * 1) + (D['buttonspacing'] * 2))
	DuffedUIBar2:SetFrameStrata('BACKGROUND')
	DuffedUIBar2:SetFrameLevel(1)
	move:RegisterFrame(DuffedUIBar2)

	if (not C['actionbar']['LeftSideBarDisable']) then
		local DuffedUIBar3 = CreateFrame('Frame', 'DuffedUIBar3', UIParent, 'SecureHandlerStateTemplate')
		if not C['actionbar']['hidepanels'] then DuffedUIBar3:SetTemplate('Transparent') end
		if C['misc']['XPBar'] then
			DuffedUIBar3:Point('BOTTOMLEFT', DuffedUIInfoLeft, 'BOTTOMRIGHT', 37, 0)
		else
			DuffedUIBar3:Point('BOTTOMLEFT', DuffedUIInfoLeft, 'BOTTOMRIGHT', 23, 0)
		end
		if C['actionbar']['LeftSideBar'] then
			DuffedUIBar3:SetSize((D['buttonsize'] * 12) + (D['buttonspacing'] * 13), (D['buttonsize'] * 1) + (D['buttonspacing'] * 2))
		else
			DuffedUIBar3:SetSize((D['SidebarButtonsize'] * 2) + (D['buttonspacing'] * 3), (D['SidebarButtonsize'] * 6) + (D['buttonspacing'] * 7))
		end
		DuffedUIBar3:SetFrameStrata('BACKGROUND')
		DuffedUIBar3:SetFrameLevel(3)
		move:RegisterFrame(DuffedUIBar3)
	end

	if (not C['actionbar']['RightSideBarDisable']) then
		local DuffedUIBar4 = CreateFrame('Frame', 'DuffedUIBar4', UIParent, 'SecureHandlerStateTemplate')
		if not C['actionbar']['hidepanels'] then DuffedUIBar4:SetTemplate('Transparent') end
		if C['misc']['azerite'] then 
			DuffedUIBar4:SetPoint('BOTTOMRIGHT', DuffedUIInfoRight, 'BOTTOMLEFT', -37, 0)
		else
			DuffedUIBar4:SetPoint('BOTTOMRIGHT', DuffedUIInfoRight, 'BOTTOMLEFT', -23, 0)
		end
		if C['actionbar']['RightSideBar'] then
			DuffedUIBar4:SetSize((D['buttonsize'] * 12) + (D['buttonspacing'] * 13), (D['buttonsize'] * 1) + (D['buttonspacing'] * 2))
		else
			DuffedUIBar4:SetSize((D['SidebarButtonsize'] * 2) + (D['buttonspacing'] * 3), (D['SidebarButtonsize'] * 6) + (D['buttonspacing'] * 7))
		end
		DuffedUIBar4:SetFrameStrata('BACKGROUND')
		DuffedUIBar4:SetFrameLevel(3)
		move:RegisterFrame(DuffedUIBar4)
	end

	if (not C['actionbar']['rightbarDisable']) then
		local DuffedUIBar5 = CreateFrame('Frame', 'DuffedUIBar5', UIParent, 'SecureHandlerStateTemplate')
		if not C['actionbar']['hidepanels'] then DuffedUIBar5:SetTemplate('Transparent') end
		if C['actionbar']['rightbarvertical'] then
			DuffedUIBar5:SetSize((D['buttonsize'] * 12) + (D['buttonspacing'] * 13), (D['buttonsize'] * 1) + (D['buttonspacing'] * 2))
			DuffedUIBar5:SetPoint('BOTTOM', icenter, 'TOP', 0, 2)
		else
			DuffedUIBar5:SetSize((D['buttonsize'] * 1) + (D['buttonspacing'] * 2), (D['buttonsize'] * 12) + (D['buttonspacing'] * 13))
			DuffedUIBar5:SetPoint('RIGHT', UIParent, 'RIGHT', -13, -14)
		end
		DuffedUIBar5:SetFrameStrata('BACKGROUND')
		DuffedUIBar5:SetFrameLevel(3)
		move:RegisterFrame(DuffedUIBar5)
	end

	DuffedUIPetBarMover = CreateFrame('Frame', 'DuffedUIPetMover', UIParent)
	if C['actionbar']['petbarhorizontal'] ~= true and C['actionbar']['rightbarvertical'] ~= true then
		DuffedUIPetBarMover:SetSize(D['petbuttonsize'] + (D['petbuttonspacing'] * 2), (D['petbuttonsize'] * 10) + (D['petbuttonspacing'] * 11))
		DuffedUIPetBarMover:SetPoint('RIGHT', DuffedUIBar5, 'LEFT', -6, 0)
	elseif C['actionbar']['petbarhorizontal'] ~= true and (C['actionbar']['rightbarvertical'] or C['actionbar']['rightbarDisable']) then
		DuffedUIPetBarMover:SetSize(D['petbuttonsize'] + (D['petbuttonspacing'] * 2), (D['petbuttonsize'] * 10) + (D['petbuttonspacing'] * 11))
		DuffedUIPetBarMover:SetPoint('RIGHT', UIParent, 'RIGHT', -13, -14)
	else
		DuffedUIPetBarMover:SetSize((D['petbuttonsize'] * 10) + (D['petbuttonspacing'] * 11), D['petbuttonsize'] + (D['petbuttonspacing'] * 2))
		if C['chat']['rbackground'] then DuffedUIPetBarMover:SetPoint('BOTTOMRIGHT', DuffedUIChatBackgroundRight, 'TOPRIGHT', 0, 3) else DuffedUIPetBarMover:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -5, 176) end
	end
	DuffedUIPetBarMover:SetFrameLevel(6)
	move:RegisterFrame(DuffedUIPetBarMover)

	local petbg = CreateFrame('Frame', 'DuffedUIPetBar', UIParent, 'SecureHandlerStateTemplate')
	if not C['actionbar']['hidepanels'] then petbg:SetTemplate('Transparent') end
	petbg:SetAllPoints(DuffedUIPetBarMover)
end

local chatmenu = CreateFrame('Frame', 'DuffedUIChatMenu', UIParent)
chatmenu:SetTemplate('Default')
chatmenu:Size(20)
if C['chat']['lbackground'] then
	chatmenu:Point('LEFT', DuffedUITabsLeftBackground, 'RIGHT', 2, 0)
else
	chatmenu:Point('TOPRIGHT', ChatFrame1, 'TOPRIGHT', -11, 25)
	chatmenu:SetAlpha(0)
	chatmenu:SetScript('OnEnter', function() chatmenu:SetAlpha(1) end)
	chatmenu:SetScript('OnLeave', function() chatmenu:SetAlpha(0) end)
end
chatmenu:SetFrameLevel(3)
chatmenu.text = D['SetFontString'](chatmenu, C['media']['font'], 11, 'THINOUTLINE')
chatmenu.text:SetPoint('CENTER', 1, -1)
chatmenu.text:SetText(D['PanelColor'] .. 'E')
chatmenu:SetScript('OnMouseDown', function(self, btn)
	if btn == 'LeftButton' then ToggleFrame(ChatMenu) end
end)
chatmenu:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	local anchor, _, xoff, yoff = "ANCHOR_TOPLEFT", self:GetParent(), 10, 5
	GameTooltip:SetOwner(self, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine("Emotions")
	GameTooltip:Show()
end)
chatmenu:SetScript('OnLeave', function() GameTooltip:Hide() end)


local chatchannel = CreateFrame('Frame', 'DuffedUIChatChannels', UIParent)
chatchannel:SetTemplate('Default')
chatchannel:Size(20)
chatchannel:Point('LEFT', chatmenu, 'RIGHT', 2, 0)
chatchannel:SetFrameLevel(3)
chatchannel.text = D['SetFontString'](chatchannel, C['media']['font'], 11, 'THINOUTLINE')
chatchannel.text:SetPoint('CENTER', 1, -1)
chatchannel.text:SetText(D['PanelColor'] .. 'C')
chatchannel:SetScript('OnMouseDown', function(self, btn)
	if btn == 'LeftButton' then ToggleFrame(ChannelFrame) end
end)
chatchannel:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	local anchor, _, xoff, yoff = "ANCHOR_TOPLEFT", self:GetParent(), 10, 5
	GameTooltip:SetOwner(self, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine("Chatchannels")
	GameTooltip:Show()
end)
chatchannel:SetScript('OnLeave', function() GameTooltip:Hide() end)

if C['datatext']['battleground'] then
	local bgframe = CreateFrame('Frame', 'DuffedUIInfoLeftBattleGround', UIParent)
	bgframe:SetTemplate()
	bgframe:SetAllPoints(icenter)
	bgframe:SetFrameStrata('HIGH')
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end