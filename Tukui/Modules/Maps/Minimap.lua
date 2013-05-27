local T, C, L = select(2, ...):unpack()

local _G = _G
local Map = _G["Minimap"]
local TukuiMinimap = CreateFrame("Frame")

function TukuiMinimap:DisableElements()
	local North = _G["MinimapNorthTag"]
	local HiddenFrames = {
		"MinimapCluster",
		"MinimapBorder",
		"MinimapBorderTop",
		"MinimapZoomIn",
		"MinimapZoomOut",
		"MiniMapVoiceChatFrame",
		"MinimapNorthTag",
		"MinimapZoneTextButton",
		"MiniMapTracking",
		"GameTimeFrame",
		"MiniMapWorldMapButton",
	}
	
	for i, Frame in pairs(HiddenFrames) do
		local f = _G[Frame]
		f:Hide()
	end
	
	North:SetTexture(nil)
end

function TukuiMinimap:StyleFrame()
	local Mail = _G["MiniMapMailFrame"]
	local MailBorder = _G["MiniMapMailBorder"]
	local MailIcon = _G["MiniMapMailIcon"]
	
	Map:SetMaskTexture(C.Media.Blank)
	Map:CreateBackdrop()
	Map.Backdrop:SetOutside()
	Map.Backdrop:SetFrameLevel(Map:GetFrameLevel() + 1)
	Map.Backdrop:SetBackdropColor(0, 0, 0, 0)
	
	Mail:ClearAllPoints()
	Mail:Point("TOPRIGHT", 3, 3)
	Mail:SetFrameLevel(Map:GetFrameLevel() + 2)
	MailBorder:Hide()
	MailIcon:SetTexture("Interface\\AddOns\\Tukui\\Medias\\Textures\\mail")
end

function TukuiMinimap:PositionFrame()
	Map:SetParent(UIParent)
	Map:ClearAllPoints()
	Map:Point("TOPRIGHT", -30, -30)
end

function TukuiMinimap:AddDataTextPanels()
	local Panels = T["Panels"]
	
	local MinimapDataTextOne = CreateFrame("Frame", "TukuiMinimapDataTextOne", Map)
	MinimapDataTextOne:Size(Map:GetWidth() / 2 + 2, 19)
	MinimapDataTextOne:SetPoint("TOPLEFT", Map, "BOTTOMLEFT", -2, -3)
	MinimapDataTextOne:SetTemplate()
	MinimapDataTextOne:SetFrameStrata("LOW")

	local MinimapDataTextTwo = CreateFrame("Frame", "TukuiMinimapDataTextTwo", Map)
	MinimapDataTextTwo:Size(Map:GetWidth() / 2 + 1, 19)
	MinimapDataTextTwo:SetPoint("TOPRIGHT", Map, "BOTTOMRIGHT", 2, -3)
	MinimapDataTextTwo:SetTemplate()
	MinimapDataTextTwo:SetFrameStrata("LOW")

	Panels.MinimapDataTextOne = MinimapDataTextOne
	Panels.MinimapDataTextTwo = MinimapDataTextTwo
end

function GetMinimapShape() 
	return "SQUARE"
end

TukuiMinimap:RegisterEvent("ADDON_LOADED")
TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TimeManager") then
		local Time = _G["TimeManagerClockButton"]

		Time:Kill()
	elseif (addon == "Tukui") then
		self:DisableElements()
		self:StyleFrame()
		self:PositionFrame()
		self:AddDataTextPanels()
	end
end)

T["Minimap"] = TukuiMinimap