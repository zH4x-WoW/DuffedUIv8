local D, C, L = select(2, ...):unpack()

local Panels = {}

local BottomPanel = CreateFrame("Frame", nil, UIParent)
BottomPanel:SetPoint("BOTTOM", 0, 3)
BottomPanel:Size(500, 20)
BottomPanel:SetTemplate()
BottomPanel:SetFrameLevel(1)

local ChatCube = CreateFrame("Frame", nil, BottomPanel) -- temp position
ChatCube:SetPoint("CENTER", BottomPanel, "CENTER", 0, 0) -- temp position
ChatCube:Size(20)
ChatCube:EnableMouse(true)
ChatCube.Text = ChatCube:CreateFontString(nil, "OVERLAY")
ChatCube.Text:SetFont(C["medias"].Font, 12, "THINOUTLINE")
ChatCube.Text:SetPoint("CENTER", ChatCube, "CENTER", 1, -1)
ChatCube.Text:SetText("E")

local DataTextLeft = CreateFrame("Frame", nil, UIParent)
DataTextLeft:Size(370, 23)
DataTextLeft:SetPoint("BOTTOMLEFT", 5, 3)
DataTextLeft:SetTemplate()
DataTextLeft:SetFrameLevel(1)

local DataTextRight = CreateFrame("Frame", nil, UIParent)
DataTextRight:Size(370, 23)
DataTextRight:SetPoint("BOTTOMRIGHT", -5, 3)
DataTextRight:SetTemplate()
DataTextRight:SetFrameLevel(1)

if C["chat"].LeftBackground then
	local LeftChatBackground = CreateFrame("Frame", nil, DataTextLeft)
	LeftChatBackground:Size(370, 142)
	LeftChatBackground:SetPoint("BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 3)
	LeftChatBackground:SetTemplate("Transparent")
	LeftChatBackground:SetFrameStrata("BACKGROUND")
	LeftChatBackground:SetFrameLevel(1)
	
	local LeftChatTab = CreateFrame("Frame", nil, LeftChatBackground)
	LeftChatTab:Size(340, 20)
	LeftChatTab:SetPoint("TOPLEFT", LeftChatBackground, "TOPLEFT", 4, -4)
	LeftChatTab:SetTemplate()
end

if C["chat"].RightBackground then
	local RightChatBackground = CreateFrame("Frame", nil, DataTextRight)
	RightChatBackground:Size(370, 142)
	RightChatBackground:SetPoint("BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, 3)
	RightChatBackground:SetTemplate("Transparent")
	RightChatBackground:SetFrameStrata("BACKGROUND")
	RightChatBackground:SetFrameLevel(1)
	
	local RightChatTab = CreateFrame("Frame", nil, RightChatBackground)
	RightChatTab:Size(362, 20)
	RightChatTab:SetPoint("TOPLEFT", RightChatBackground, "TOPLEFT", 4, -4)
	RightChatTab:SetTemplate()
end

local Hider = CreateFrame("Frame", nil, UIParent)
Hider:Hide()

local PetBattleHider = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
PetBattleHider:SetAllPoints()
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

Panels.BottomPanel = BottomPanel
Panels.ChatCube = ChatCube
Panels.DataTextLeft = DataTextLeft
Panels.DataTextRight = DataTextRight
Panels.LeftChatBackground = LeftChatBackground
Panels.RightChatBackground = RightChatBackground
Panels.LeftChatTab = LeftChatTab
Panels.RightChatTab = RightChatTab
Panels.Hider = Hider
Panels.PetBattleHider = PetBattleHider

D["Panels"] = Panels