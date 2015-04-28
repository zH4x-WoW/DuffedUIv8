local D, C, L = unpack(select(2, ...))

local move = D["move"]
local DuffedUIMinimap = CreateFrame("Frame", "DuffedUIMinimap", DuffedUIPetBattleHider)
DuffedUIMinimap:SetTemplate()
DuffedUIMinimap:RegisterEvent("ADDON_LOADED")
if C["auras"].bufftracker then DuffedUIMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -35, -5) else DuffedUIMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -5, -5) end
DuffedUIMinimap:Size(144)
move:RegisterFrame(DuffedUIMinimap)

MinimapCluster:Kill()
Minimap:SetParent(DuffedUIMinimap)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", 2, -2)
Minimap:Point("BOTTOMRIGHT", -2, 2)
GarrisonLandingPageMinimapButton:Kill()
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MiniMapVoiceChatFrame:Hide()
MinimapNorthTag:SetTexture(nil)
MinimapZoneTextButton:Hide()
MiniMapTracking:Hide()
GameTimeFrame:Hide()

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("TOPRIGHT", Minimap, 3, 3)
MiniMapMailFrame:SetFrameLevel(Minimap:GetFrameLevel() + 1)
MiniMapMailFrame:SetFrameStrata(Minimap:GetFrameStrata())
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\DuffedUI\\medias\\textures\\mail")

local DuffedUITicket = CreateFrame("Frame", "DuffedUITicket", DuffedUIMinimap)
DuffedUITicket:SetTemplate()
DuffedUITicket:Size(DuffedUIMinimap:GetWidth() - 4, 24)
DuffedUITicket:SetFrameLevel(Minimap:GetFrameLevel() + 4)
DuffedUITicket:SetFrameStrata(Minimap:GetFrameStrata())
DuffedUITicket:Point("TOP", 0, -2)
DuffedUITicket:FontString("Text", C["media"].font, 11)
DuffedUITicket.Text:SetPoint("CENTER")
DuffedUITicket.Text:SetText(HELP_TICKET_EDIT)
DuffedUITicket:SetBackdropBorderColor(255/255, 243/255,  82/255)
DuffedUITicket.Text:SetTextColor(255/255, 243/255,  82/255)
DuffedUITicket:SetAlpha(0)

HelpOpenTicketButton:SetParent(DuffedUITicket)
HelpOpenTicketButton:SetFrameLevel(DuffedUITicket:GetFrameLevel() + 1)
HelpOpenTicketButton:SetFrameStrata(DuffedUITicket:GetFrameStrata())
HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:SetAllPoints()
HelpOpenTicketButton:SetHighlightTexture(nil)
HelpOpenTicketButton:SetAlpha(0)
HelpOpenTicketButton:HookScript("OnShow", function(self) DuffedUITicket:SetAlpha(1) end)
HelpOpenTicketButton:HookScript("OnHide", function(self) DuffedUITicket:SetAlpha(0) end)

MiniMapWorldMapButton:Hide()
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", 0, 0)
QueueStatusMinimapButtonBorder:Kill()
QueueStatusFrame:StripTextures()
QueueStatusFrame:SetTemplate("Transparent")
QueueStatusFrame:SetFrameStrata("HIGH")

local function UpdateLFGTooltip()
	local position = DuffedUIMinimap:GetPoint()
	QueueStatusFrame:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		QueueStatusFrame:SetPoint("BOTTOMRIGHT", QueueStatusMinimapButton, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		QueueStatusFrame:SetPoint("BOTTOMLEFT", QueueStatusMinimapButton, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then
		QueueStatusFrame:SetPoint("TOPLEFT", QueueStatusMinimapButton, "TOPRIGHT", 4, 0)
	else
		QueueStatusFrame:SetPoint("TOPRIGHT", QueueStatusMinimapButton, "TOPLEFT", 0, 0)
	end
end
QueueStatusFrame:HookScript("OnShow", UpdateLFGTooltip)

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then _G.MinimapZoomIn:Click() elseif d < 0 then _G.MinimapZoomOut:Click() end
end)

Minimap:SetMaskTexture(C["media"].blank)
function GetMinimapShape() return "SQUARE" end
DuffedUIMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then TimeManagerClockButton:Kill() end
end)

Minimap:SetScript("OnMouseUp", function(self, btn)
	local xoff = 0
	local position = DuffedUIMinimap:GetPoint()

	if btn == "MiddleButton" or (IsShiftKeyDown() and btn == "RightButton") then
		if not DuffedUIMicroButtonsDropDown then return end
		if position:match("RIGHT") then xoff = D.Scale(-160) end
		EasyMenu(D.MicroMenu, DuffedUIMicroButtonsDropDown, "cursor", xoff, 0, "MENU", 2)
	elseif btn == "RightButton" then
		if position:match("RIGHT") then xoff = D.Scale(-8) end
		ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, DuffedUIMinimap, xoff, D.Scale(-2))
	else
		Minimap_OnClick(self)
	end
end)

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then MinimapZoomIn:Click() elseif delta < 0 then MinimapZoomOut:Click() end
end)

local m_zone = CreateFrame("Frame", "DuffedUIMinimapZone", DuffedUIMinimap)
m_zone:SetTemplate("Transparent")
m_zone:Size(0,20)
m_zone:Point("TOPLEFT", DuffedUIMinimap, "TOPLEFT", 2,-2)
m_zone:SetFrameLevel(Minimap:GetFrameLevel() + 3)
m_zone:SetFrameStrata(Minimap:GetFrameStrata())
m_zone:Point("TOPRIGHT",DuffedUIMinimap,-2,-2)
m_zone:SetAlpha(0)

local m_zone_text = m_zone:CreateFontString("DuffedUIMinimapZoneText", "Overlay")
m_zone_text:SetFont(C["media"].font, 11)
m_zone_text:Point("TOP", 0, -1)
m_zone_text:SetPoint("BOTTOM")
m_zone_text:Height(12)
m_zone_text:Width(m_zone:GetWidth()-6)
m_zone_text:SetAlpha(0)

local m_coord = CreateFrame("Frame", "DuffedUIMinimapCoord", DuffedUIMinimap)
m_coord:SetTemplate("Transparent")
m_coord:Size(40,20)
m_coord:Point("BOTTOMLEFT", DuffedUIMinimap, "BOTTOMLEFT", 2,2)
m_coord:SetFrameLevel(Minimap:GetFrameLevel() + 3)
m_coord:SetFrameStrata(Minimap:GetFrameStrata())
m_coord:SetAlpha(0)

local m_coord_text = m_coord:CreateFontString("DuffedUIMinimapCoordText", "Overlay")
m_coord_text:SetFont(C["media"].font, 11)
m_coord_text:Point("Center", -1, 0)
m_coord_text:SetAlpha(0)
m_coord_text:SetText("00,00")

local int = 0
m_coord:HookScript("OnUpdate", function(self, elapsed)
	int = int + 1
	if int >= 3 then
		local inInstance, _ = IsInInstance()
		local x, y = GetPlayerMapPosition("player")
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then m_coord_text:SetText(x .. " - " .. y) else m_coord_text:SetText("x - x") end
		int = 0
	end
end)

Minimap:SetScript("OnEnter", function()
	m_zone:SetAlpha(1)
	m_zone_text:SetAlpha(1)
	m_coord:SetAlpha(1)
	m_coord_text:SetAlpha(1)
end)

Minimap:SetScript("OnLeave", function()
	m_zone:SetAlpha(0)
	m_zone_text:SetAlpha(0)
	m_coord:SetAlpha(0)
	m_coord_text:SetAlpha(0)
end)
 
local zone_Update = function()
	local pvp = GetZonePVPInfo()
	m_zone_text:SetText(GetMinimapZoneText())
	if pvp == "friendly" then
		m_zone_text:SetTextColor(.1, 1, .1)
	elseif pvp == "sanctuary" then
		m_zone_text:SetTextColor(.41, .8, .94)
	elseif pvp == "arena" or pvp == "hostile" then
		m_zone_text:SetTextColor(1, .1, .1)
	elseif pvp == "contested" then
		m_zone_text:SetTextColor(1, .7, 0)
	else
		m_zone_text:SetTextColor(1, 1, 1)
	end
end
 
m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")
m_zone:SetScript("OnEvent", zone_Update)