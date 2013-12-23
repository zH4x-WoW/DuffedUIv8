local D, C, L = select(2, ...):unpack()

local Panels = {}

local BottomLine = CreateFrame("Frame", nil, UIParent)
BottomLine:SetTemplate()
BottomLine:Size(2)
BottomLine:Point("BOTTOMLEFT", 30, 30)
BottomLine:Point("BOTTOMRIGHT", -30, 30)
BottomLine:SetFrameStrata("BACKGROUND")
BottomLine:SetFrameLevel(0)

local LeftVerticalLine = CreateFrame("Frame", nil, BottomLine)
LeftVerticalLine:SetTemplate()
LeftVerticalLine:Size(2, 130)
LeftVerticalLine:Point("BOTTOMLEFT", 0, 0)
LeftVerticalLine:SetFrameLevel(0)
LeftVerticalLine:SetFrameStrata("BACKGROUND")

local DataTextLeft = CreateFrame("Frame", nil, BottomLine)
DataTextLeft:Size(370, 23)
DataTextLeft:SetPoint("LEFT", 17, -1)
DataTextLeft:SetTemplate()
DataTextLeft:SetFrameLevel(1)

local DataTextRight = CreateFrame("Frame", nil, BottomLine)
DataTextRight:Size(370, 23)
DataTextRight:SetPoint("RIGHT", -17, -1)
DataTextRight:SetTemplate()
DataTextRight:SetFrameLevel(1)

if C["chat"].lBackground then
	local LeftChatBackground = CreateFrame("Frame", nil, UIParent)
	LeftChatBackground:Size(382, 149)
	LeftChatBackground:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, 5)
	LeftChatBackground:SetTemplate("Transparent")
	LeftChatBackground:SetFrameLevel(1)
	LeftChatBackground:SetFrameStrata("BACKGROUND")
	
	local LeftChatTab = CreateFrame("Frame", "LeftChatTab", LeftChatBackground)
	LeftChatTab:Size(330, 20)
	LeftChatTab:SetPoint("TOPLEFT", LeftChatBackground, "TOPLEFT", 4, -4)
	LeftChatTab:SetTemplate()
	LeftChatTab:SetFrameLevel(2)
	LeftChatTab:SetFrameStrata("BACKGROUND")
end

if C["chat"].rBackground then
	local RightChatBackground = CreateFrame("Frame", nil, UIParent)
	RightChatBackground:Size(382, 149)
	RightChatBackground:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 5)
	RightChatBackground:SetTemplate("Transparent")
	RightChatBackground:SetFrameLevel(1)
	RightChatBackground:SetFrameStrata("BACKGROUND")
	
	local RightChatTab = CreateFrame("Frame", nil, RightChatBackground)
	RightChatTab:Size(183, 20)
	RightChatTab:SetPoint("TOPLEFT", RightChatBackground, "TOPLEFT", 4, -4)
	RightChatTab:SetTemplate()
	RightChatTab:SetFrameLevel(2)
	RightChatTab:SetFrameStrata("BACKGROUND")
end

local CubeLeft = CreateFrame("Frame", nil, UIParent)
CubeLeft:SetTemplate()
CubeLeft:Size(20, 20)
if C["chat"].lBackground then CubeLeft:Point("LEFT", LeftChatTab, "RIGHT", 2, 0) else CubeLeft:Point("BOTTOM", LeftVerticalLine, "TOP", 0, 0) end
CubeLeft:EnableMouse(true)
CubeLeft:SetFrameLevel(2)
CubeLeft.text = D.SetFontString(CubeLeft, C["medias"].Font, C["fonts"].Buttons, "THINOUTLINE")
CubeLeft.text:SetPoint("CENTER", 1, 0)
CubeLeft.text:SetText("E") -- D.panelcolor .. 

local Hider = CreateFrame("Frame", nil, UIParent)
Hider:Hide()

local PetBattleHider = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
PetBattleHider:SetAllPoints()
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

Panels.BottomLine = BottomLine
Panels.LeftVerticalLine = LeftVerticalLine
Panels.DataTextLeft = DataTextLeft
Panels.DataTextRight = DataTextRight
Panels.LeftChatBackground = LeftChatBackground
Panels.RightChatBackground = RightChatBackground
Panels.LeftChatTab = LeftChatTab
Panels.RightChatTab = RightChatTab
Panels.CubeLeft = CubeLeft
Panels.Hider = Hider
Panels.PetBattleHider = PetBattleHider

D["Panels"] = Panels