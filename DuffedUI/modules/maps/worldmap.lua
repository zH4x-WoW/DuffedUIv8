local D, C, L = select(2, ...):unpack()

local _G = _G
local Maps = D["Maps"]
local Noop = function() end
local WorldMapFrame = WorldMapFrame
local WorldMapDetailFrame = WorldMapDetailFrame
local WorldMapLevelDropDown = WorldMapLevelDropDown
local WorldMapShowDropDown = WorldMapShowDropDown
local WorldMapPositioningGuide = WorldMapPositioningGuide
local WorldMapTrackQuest = WorldMapTrackQuest
local WorldMapTrackQuestText = WorldMapTrackQuestText
local WorldMapFrameSizeUpButton = WorldMapFrameSizeUpButton
local WorldMapFrameCloseButton = WorldMapFrameCloseButton
local WorldMapFrameSizeUpButton = WorldMapFrameSizeUpButton

function Maps:WorldMapOnOpen()
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPRIGHT", WorldMapShowDropDown, "BOTTOMRIGHT", 0, 6)
	WorldMapLevelDropDown:SetTemplate()
	
	WorldMapTrackQuest:SkinCheckBox()
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:Point("LEFT", WorldMapFrame.Header, "LEFT", 0, 0)
	WorldMapTrackQuest:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 2)
	
	WorldMapTrackQuestText:ClearAllPoints()
	WorldMapTrackQuestText:Point("LEFT", WorldMapTrackQuest, "RIGHT", 2, 0)
	
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:Point("CENTER", WorldMapFrame.Header, 0, -1)
	
	WorldMapFrameCloseButton:SkinCloseButton()
	WorldMapFrameCloseButton:ClearAllPoints()
	WorldMapFrameCloseButton:Point("LEFT", WorldMapFrame.Header, "RIGHT", -24, -2)
end

function Maps:SkinWorldmap()
	WorldMapFrame:StripTextures()
	WorldMapFrame:CreateBackdrop()
	WorldMapFrame.Backdrop:SetOutside(WorldMapDetailFrame, 2, 2)
	
	WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMapFrame.Header:Size(WorldMapFrame.Backdrop:GetWidth(), 24)
	WorldMapFrame.Header:Point("BOTTOM", WorldMapFrame, "TOP", 1, -18)
	WorldMapFrame.Header:SetFrameLevel(WorldMapFrame:GetFrameLevel())
	WorldMapFrame.Header:SetTemplate("Transparent")
	
	WorldMapShowDropDown:SkinDropDown()
	WorldMapShowDropDown:ClearAllPoints()
	WorldMapShowDropDown:SetPoint("TOPRIGHT", WorldMapFrame.Backdrop, "TOPRIGHT", 0, -6)
	WorldMapShowDropDown:SetFrameLevel(WorldMapLevelDropDown:GetFrameLevel())

	WorldMapLevelDropDown:SkinDropDown()
	
	WorldMapFrameSizeUpButton:Kill()
end

function Maps:SetWorldmap()
	WorldMap_ToggleSizeDown()
	WorldMap_ToggleSizeUp = Noop

	WorldMapFrame:HookScript("OnShow", self.WorldMapOnOpen)
end

