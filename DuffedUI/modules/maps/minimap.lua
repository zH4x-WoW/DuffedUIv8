local D, C, L = select(2, ...):unpack()

local _G = _G
local Map = _G["Minimap"]
local Panels = D["Panels"]
local Miscellaneous = D["Miscellaneous"]
local Maps = D["Maps"]
local Elapsed = 0

Maps.ZoneColors = {
	["friendly"] = {.1, 1, .1},
	["sanctuary"] = {.41, .8, .94},
	["arena"] = {1, .1,  .1},
	["hostile"] = {1, .1, .1},
	["contested"] = {1, .7, 0},
}

function Maps:DisableMinimapElements()
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

function Maps:StyleMinimap()
	local Mail = _G["MiniMapMailFrame"]
	local MailBorder = _G["MiniMapMailBorder"]
	local MailIcon = _G["MiniMapMailIcon"]
	
	Map:SetMaskTexture(C["medias"].Blank)
	Map:CreateBackdrop()
	Map.Backdrop:SetOutside()
	Map.Backdrop:SetFrameLevel(Map:GetFrameLevel() + 1)
	Map.Backdrop:SetBackdropColor(0, 0, 0, 0)
	
	Mail:ClearAllPoints()
	Mail:Point("TOPRIGHT", 3, 3)
	Mail:SetFrameLevel(Map:GetFrameLevel() + 2)
	MailBorder:Hide()
	MailIcon:SetTexture(C["medias"].Mail)
	
	Map:SetScript("OnMouseUp", function(self, button)
		if (button == "RightButton") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, Map, 0, D.Scale(-3))
		elseif (button == "MiddleButton") then
			EasyMenu(Miscellaneous.MicroMenu, Miscellaneous.MicroMenuFrame, "cursor", D.Scale(-160), 0, "MENU", 2)
		else
			Minimap_OnClick(self)
		end
	end)
end

function Maps:PositionMinimap()
	Map:SetParent(Panels.PetBattleHider)
	Map:ClearAllPoints()
	if C["auras"].BuffTracker then Map:Point("TOPRIGHT", -37, -5) else Map:Point("TOPRIGHT", -5, -5) end
end

function Maps:AddMinimapDataTexts()
	local MinimapDataTextOne = CreateFrame("Frame", nil, Map)
	MinimapDataTextOne:Size(Map:GetWidth() / 2 + 2, 19)
	MinimapDataTextOne:SetPoint("TOPLEFT", Map, "BOTTOMLEFT", -2, -3)
	MinimapDataTextOne:SetTemplate()
	MinimapDataTextOne:SetFrameStrata("LOW")

	local MinimapDataTextTwo = CreateFrame("Frame", nil, Map)
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

----------------------------------------------------------------------------------------
-- Mouseover map, displaying zone and coords
----------------------------------------------------------------------------------------

function Maps:AddZoneAndCoords()
	local MinimapZone = CreateFrame("Frame", "DuffedUIMinimapZone", Map)
	MinimapZone:SetTemplate("Transparent")
	MinimapZone:Size(Map:GetWidth() + 4, 22)
	MinimapZone:Point("TOP", Map, 0, 2)
	MinimapZone:SetFrameStrata(Minimap:GetFrameStrata())
	MinimapZone:SetAlpha(0)

	MinimapZone.Text = MinimapZone:CreateFontString("DuffedUIMinimapZoneText", "OVERLAY")
	MinimapZone.Text:SetFont(C["medias"].Font, 12)
	MinimapZone.Text:Point("TOP", 0, -1)
	MinimapZone.Text:SetPoint("BOTTOM")
	MinimapZone.Text:Height(12)
	MinimapZone.Text:Width(MinimapZone:GetWidth() - 6)

	local MinimapCoords = CreateFrame("Frame", "DuffedUIMinimapCoord", Map)
	MinimapCoords:SetTemplate("Transparent")
	MinimapCoords:Size(40, 22)
	MinimapCoords:Point("BOTTOMLEFT", Map, "BOTTOMLEFT", -2, -2)
	MinimapCoords:SetFrameStrata(Minimap:GetFrameStrata())

	MinimapCoords:SetAlpha(0)

	MinimapCoords.Text = MinimapCoords:CreateFontString("DuffedUIMinimapCoordText", "OVERLAY")
	MinimapCoords.Text:SetFont(C["medias"].Font, 12)
	MinimapCoords.Text:Point("Center", 0, -1)
	MinimapCoords.Text:SetText("0, 0")

	-- Update zone text
	MinimapZone:RegisterEvent("PLAYER_ENTERING_WORLD")
	MinimapZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	MinimapZone:RegisterEvent("ZONE_CHANGED")
	MinimapZone:RegisterEvent("ZONE_CHANGED_INDOORS")
	MinimapZone:SetScript("OnEvent", Maps.UpdateZone)

	-- Update coordinates
	MinimapCoords:SetScript("OnUpdate", Maps.UpdateCoords)

	Maps.MinimapZone = MinimapZone
	Maps.MinimapCoords = MinimapCoords
end

Minimap:SetScript("OnEnter", function()
	Maps.MinimapZone:Animation("FadeIn", 0.3)
	Maps.MinimapCoords:Animation("FadeIn", 0.3)
end)

Minimap:SetScript("OnLeave", function()
	Maps.MinimapZone:Animation("FadeOut", 0.3)
	Maps.MinimapCoords:Animation("FadeOut", 0.3)
end)

function Maps:UpdateCoords(t)
	Elapsed = Elapsed - t

	if (Elapsed > 0) then
		return
	end

	local x, y = GetPlayerMapPosition("player")
	local xt, yt

	x = math.floor(100 * x)
	y = math.floor(100 * y)

	if (x == 0 and y == 0) then
		Maps.MinimapCoords.Text:SetText("x, x")
	else
		if (x < 10) then
			xt = "0"..x
		else
			xt = x
		end

		if (y < 10) then
			yt = "0"..y
		else
			yt = y
		end

		Maps.MinimapCoords.Text:SetText(xt..", "..yt)
	end

	Elapsed = .2
end

function Maps:UpdateZone()
	local Info = GetZonePVPInfo()

	if Maps.ZoneColors[Info] then
		local Color = Maps.ZoneColors[Info]

		Maps.MinimapZone.Text:SetTextColor(Color[1], Color[2], Color[3])
	else
		Maps.MinimapZone.Text:SetTextColor(1.0, 1.0, 1.0)
	end

	Maps.MinimapZone.Text:SetText(GetMinimapZoneText())
end