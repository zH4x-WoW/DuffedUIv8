local D, C, L = select(2, ...):unpack()

local Panels = {}

--[[local BottomLine = CreateFrame("Frame", nil, UIParent)
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

local RightVerticalLine = CreateFrame("Frame", nil, BottomLine)
RightVerticalLine:SetTemplate()
RightVerticalLine:Size(2, 130)
RightVerticalLine:Point("BOTTOMRIGHT", 0, 0)
RightVerticalLine:SetFrameLevel(0)
RightVerticalLine:SetFrameStrata("BACKGROUND")

local CubeLeft = CreateFrame("Frame", nil, LeftVerticalLine)
CubeLeft:SetTemplate()
CubeLeft:Size(10)
CubeLeft:Point("BOTTOM", LeftVerticalLine, "TOP", 0, 0)
CubeLeft:EnableMouse(true)
CubeLeft:SetFrameLevel(0)

local CubeRight = CreateFrame("Frame", nil, RightVerticalLine)
CubeRight:SetTemplate()
CubeRight:Size(10)
CubeRight:Point("BOTTOM", RightVerticalLine, "TOP", 0, 0)
CubeRight:EnableMouse(true)
CubeRight:SetFrameLevel(0)]]--

local DataTextLeft = CreateFrame("Frame", nil, UIParent)
DataTextLeft:Size(355, 20)
DataTextLeft:SetPoint("BOTTOM", -187, 5)
DataTextLeft:SetTemplate()
DataTextLeft:SetFrameLevel(1)

local DataTextRight = CreateFrame("Frame", nil, UIParent)
DataTextRight:Size(355, 20)
DataTextRight:SetPoint("BOTTOM", 187, 5)
DataTextRight:SetTemplate()
DataTextRight:SetFrameLevel(1)

local Hider = CreateFrame("Frame", nil, UIParent)
Hider:Hide()

local PetBattleHider = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
PetBattleHider:SetAllPoints()
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

Panels.BottomLine = BottomLine
Panels.LeftVerticalLine = LeftVerticalLine
Panels.RightVerticalLine = RightVerticalLine
Panels.CubeLeft = CubeLeft
Panels.CubeRight = CubeRight
Panels.DataTextLeft = DataTextLeft
Panels.DataTextRight = DataTextRight
Panels.Hider = Hider
Panels.PetBattleHider = PetBattleHider

D["Panels"] = Panels