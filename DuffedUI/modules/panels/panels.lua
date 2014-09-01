local D, C, L = unpack(select(2, ...)) 

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "DuffedUIInfoLeft", UIParent)
ileft:SetTemplate("Default")
ileft:Size(D.Scale(D.InfoLeftRightWidth - 9), 19)
ileft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, 3)
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "DuffedUIInfoRight", UIParent)
iright:SetTemplate("Default")
iright:Size(D.Scale(D.InfoLeftRightWidth - 9), 19)
iright:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 3)
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")

if C["chat"].lbackground then
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "DuffedUIChatBackgroundLeft", DuffedUIInfoLeft)
	chatleftbg:SetTemplate("Transparent")
	chatleftbg:Size(D.InfoLeftRightWidth + 12, 149)
	chatleftbg:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, 24)
	chatleftbg:SetFrameLevel(1)

	-- LEFT TAB PANEL
	local tabsbgleft = CreateFrame("Frame", "DuffedUITabsLeftBackground", UIParent)
	tabsbgleft:SetTemplate()
	tabsbgleft:Size((D.InfoLeftRightWidth - 40), 20)
	tabsbgleft:Point("TOPLEFT", chatleftbg, "TOPLEFT", 4, -4)
	tabsbgleft:SetFrameLevel(2)
	tabsbgleft:SetFrameStrata("BACKGROUND")
end

if C["chat"].rbackground then
	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "DuffedUIChatBackgroundRight", DuffedUIInfoRight)
	chatrightbg:SetTemplate("Transparent")
	chatrightbg:Size(D.InfoLeftRightWidth + 12, 149)
	chatrightbg:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 24)
	chatrightbg:SetFrameLevel(1)
		
	-- RIGHT TAB PANEL
	local tabsbgright = CreateFrame("Frame", "DuffedUITabsRightBackground", UIParent)
	tabsbgright:SetTemplate()
	tabsbgright:Size((D.InfoLeftRightWidth - 187), 20)
	tabsbgright:Point("TOPLEFT", chatrightbg, "TOPLEFT", 4, -4)
	tabsbgright:SetFrameLevel(2)
	tabsbgright:SetFrameStrata("BACKGROUND")
end

if not C["actionbar"].enable ~= true then
	DuffedUIBar1Mover = CreateFrame("Frame", "DuffedUIBar1Mover", UIParent)
	DuffedUIBar1Mover:SetTemplate("Transparent")
	DuffedUIBar1Mover:SetSize((D.buttonsize * 12) + (D.buttonspacing * 13), (D.buttonsize * 1) + (D.buttonspacing * 2))
	DuffedUIBar1Mover:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 130)
	DuffedUIBar1Mover:SetFrameLevel(6)
	DuffedUIBar1Mover:SetClampedToScreen(true)
	DuffedUIBar1Mover:SetMovable(true)
	DuffedUIBar1Mover.text = D.SetFontString(DuffedUIBar1Mover, C["media"].font, 11)
	DuffedUIBar1Mover.text:SetPoint("CENTER")
	DuffedUIBar1Mover.text:SetText(L["move"]["bar1"])
	DuffedUIBar1Mover:SetBackdropBorderColor(1, 0, 0, 1)
	DuffedUIBar1Mover:Hide()
	tinsert(D.AllowFrameMoving, DuffedUIBar1Mover)

	local DuffedUIBar1 = CreateFrame("Frame", "DuffedUIBar1", UIParent, "SecureHandlerStateTemplate")
	DuffedUIBar1:SetTemplate("Transparent")
	DuffedUIBar1:SetAllPoints(DuffedUIBar1Mover)
	DuffedUIBar1:SetFrameStrata("BACKGROUND")
	DuffedUIBar1:SetFrameLevel(1)

	local DuffedUIBar2 = CreateFrame("Frame", "DuffedUIBar2", UIParent, "SecureHandlerStateTemplate")
	DuffedUIBar2:SetTemplate("Transparent")
	DuffedUIBar2:Point("BOTTOM", UIParent, "BOTTOM", 0, 93)
	DuffedUIBar2:SetSize((D.buttonsize * 12) + (D.buttonspacing * 13), (D.buttonsize * 1) + (D.buttonspacing * 2))
	DuffedUIBar2:SetFrameStrata("BACKGROUND")
	DuffedUIBar2:SetFrameLevel(3)
	DuffedUIBar2:SetClampedToScreen(true)
	DuffedUIBar2:SetMovable(true)
	tinsert(D.AllowFrameMoving, DuffedUIBar2)

	local DuffedUIBar3 = CreateFrame("Frame", "DuffedUIBar3", UIParent, "SecureHandlerStateTemplate")
	DuffedUIBar3:SetTemplate("Transparent")
	DuffedUIBar3:Point("BOTTOMLEFT", DuffedUIInfoLeft, "BOTTOMRIGHT", 23, 0)
	DuffedUIBar3:SetSize(((D.buttonsize - 4) * 2) + (D.buttonspacing * 3), ((D.buttonsize - 4) * 6) + (D.buttonspacing * 7))
	DuffedUIBar3:SetFrameStrata("BACKGROUND")
	DuffedUIBar3:SetFrameLevel(3)

	local DuffedUIBar4 = CreateFrame("Frame", "DuffedUIBar4", UIParent, "SecureHandlerStateTemplate")
	DuffedUIBar4:SetTemplate("Transparent")
	DuffedUIBar4:Point("BOTTOMRIGHT", DuffedUIInfoRight, "BOTTOMLEFT", -23, 0)
	DuffedUIBar4:SetSize(((D.buttonsize - 4) * 2) + (D.buttonspacing * 3), ((D.buttonsize - 4) * 6) + (D.buttonspacing * 7))
	DuffedUIBar4:SetFrameStrata("BACKGROUND")
	DuffedUIBar4:SetFrameLevel(3)

	local DuffedUIBar5 = CreateFrame("Frame", "DuffedUIBar5", UIParent, "SecureHandlerStateTemplate")
	DuffedUIBar5:SetTemplate("Transparent")
	if C["actionbar"].rightbarvertical then
		DuffedUIBar5:SetSize((D.buttonsize * 12) + (D.buttonspacing * 13), (D.buttonsize * 1) + (D.buttonspacing * 2))
		DuffedUIBar5:Point("BOTTOM", UIParent, "BOTTOM", 0, 56)
	else
		DuffedUIBar5:SetSize((D.buttonsize * 1) + (D.buttonspacing * 2), (D.buttonsize * 12) + (D.buttonspacing * 13))
		DuffedUIBar5:Point("RIGHT", UIParent, "RIGHT", -13, -14)
	end
	DuffedUIBar5:SetFrameStrata("BACKGROUND")
	DuffedUIBar5:SetFrameLevel(3)
	DuffedUIBar5:SetClampedToScreen(true)
	DuffedUIBar5:SetMovable(true)
	--DuffedUIBar5.text = D.SetFontString(DuffedUIBar5, C["media"].font, 11)
	--DuffedUIBar5.text:SetPoint("CENTER")
	--if C["actionbar"].rightbarvertical then DuffedUIBar5.text:SetText(L["move"]["bar5"]) else DuffedUIBar5.text:SetText(L["move"]["bar5_1"]) end
	tinsert(D.AllowFrameMoving, DuffedUIBar5)

	DuffedUIPetBarMover = CreateFrame("Frame", "DuffedUIPetBarMover", UIParent)
	DuffedUIPetBarMover:SetTemplate("Transparent")
	if C["actionbar"].petbarhorizontal ~= true then
		DuffedUIPetBarMover:SetSize(D.petbuttonsize + (D.petbuttonspacing * 2), (D.petbuttonsize * 10) + (D.petbuttonspacing * 11))
		DuffedUIPetBarMover:SetPoint("RIGHT", DuffedUIBar5, "LEFT", -6, 0)
	else
		DuffedUIPetBarMover:SetSize((D.petbuttonsize * 10) + (D.petbuttonspacing * 11), D.petbuttonsize + (D.petbuttonspacing * 2))
		if C["chat"].rbackground then
			DuffedUIPetBarMover:SetPoint("BOTTOMRIGHT", DuffedUIChatBackgroundRight, "TOPRIGHT", 0, 3)
		else
			DuffedUIPetBarMover:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 176)
		end
	end
	DuffedUIPetBarMover:SetFrameLevel(6)
	DuffedUIPetBarMover:SetClampedToScreen(true)
	DuffedUIPetBarMover:SetMovable(true)
	DuffedUIPetBarMover.text = D.SetFontString(DuffedUIPetBarMover, C["media"].font, 11)
	DuffedUIPetBarMover.text:SetPoint("CENTER")
	DuffedUIPetBarMover.text:SetText(L["move"]["pet"])
	DuffedUIPetBarMover:SetBackdropBorderColor(1, 0, 0, 1)
	DuffedUIPetBarMover:Hide()
	tinsert(D.AllowFrameMoving, DuffedUIPetBarMover)

	local petbg = CreateFrame("Frame", "DuffedUIPetBar", UIParent, "SecureHandlerStateTemplate")
	petbg:SetTemplate("Transparent")
	petbg:SetAllPoints(DuffedUIPetBarMover)
end

local chatmenu = CreateFrame("Frame", "DuffedUIChatMenu", UIParent)
chatmenu:SetTemplate("Default")
chatmenu:Size(20)
if C["chat"].lbackground then chatmenu:Point("LEFT", DuffedUITabsLeftBackground, "RIGHT", 2, 0) else chatmenu:Point("TOPRIGHT", ChatFrame1, "TOPRIGHT", -11, 25) end
chatmenu:SetFrameLevel(3)
chatmenu.text = D.SetFontString(chatmenu, C["media"].font, 11, "THINOUTLINE")
chatmenu.text:SetPoint("CENTER", 1, -1)
chatmenu.text:SetText(D.panelcolor .. "E")
chatmenu:SetScript("OnMouseDown", function(self, btn)
	if btn == "LeftButton" then	
		ToggleFrame(ChatMenu)
	end
end)

if DuffedUIMinimap then
	local minimapstatsleft = CreateFrame("Frame", "DuffedUIMinimapStatsLeft", DuffedUIMinimap)
	minimapstatsleft:SetTemplate()
	minimapstatsleft:Size(((DuffedUIMinimap:GetWidth() + 4) / 2) -3, 19)
	minimapstatsleft:Point("TOPLEFT", DuffedUIMinimap, "BOTTOMLEFT", 0, -2)

	local minimapstatsright = CreateFrame("Frame", "DuffedUIMinimapStatsRight", DuffedUIMinimap)
	minimapstatsright:SetTemplate()
	minimapstatsright:Size(((DuffedUIMinimap:GetWidth() + 4) / 2) -3, 19)
	minimapstatsright:Point("TOPRIGHT", DuffedUIMinimap, "BOTTOMRIGHT", 0, -2)
end

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "DuffedUIInfoLeftBattleGround", UIParent)
	bgframe:SetTemplate()
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end

local bnet = CreateFrame("Frame", "DuffedUIBnetHolder", UIParent)
bnet:SetTemplate("Default")
bnet:Size(BNToastFrame:GetWidth(), BNToastFrame:GetHeight())
bnet:Point("TOPLEFT", UIParent, "TOPLEFT", 3, -3)
bnet:SetClampedToScreen(true)
bnet:SetMovable(true)
bnet:SetBackdropBorderColor(1, 0, 0)
bnet.text = D.SetFontString(bnet, C["media"].font, 11)
bnet.text:SetPoint("CENTER")
bnet.text:SetText("Move BnetFrame")
bnet:Hide()
tinsert(D.AllowFrameMoving, bnet)