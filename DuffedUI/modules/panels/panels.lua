local D, C, L = select(2, ...):unpack()

local Panels = {}

local DataTextLeft = CreateFrame("Frame", nil, UIParent)
DataTextLeft:Size(370, 20)
DataTextLeft:SetPoint("BOTTOM", -197, 5)
DataTextLeft:SetTemplate()
DataTextLeft:SetFrameLevel(1)

local DataTextRight = CreateFrame("Frame", nil, UIParent)
DataTextRight:Size(370, 20)
DataTextRight:SetPoint("BOTTOM", 197, 5)
DataTextRight:SetTemplate()
DataTextRight:SetFrameLevel(1)

local LeftChatBackground = CreateFrame("Frame", nil, UIParent)
if C["chat"].lBackground then
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

local RightChatBackground = CreateFrame("Frame", nil, UIParent)
if C["chat"].rBackground then
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
if C["chat"].lBackground then CubeLeft:Point("LEFT", LeftChatTab, "RIGHT", 2, 0) else CubeLeft:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 0) end
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