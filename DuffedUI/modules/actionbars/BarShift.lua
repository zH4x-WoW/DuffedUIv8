local D, C, L = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

local move = D["move"]
local bar = CreateFrame("Frame", "DuffedUIStance", UIParent, "SecureHandlerStateTemplate")
bar:SetPoint("TOPLEFT", 0, -200)
bar:SetWidth((D.petbuttonsize * 4) + (D.petbuttonsize * 3))
bar:SetHeight(15)
bar:SetFrameStrata("MEDIUM")
bar:SetMovable(true)
bar:SetClampedToScreen(true)

local ssmover = CreateFrame("Frame", "DuffedUIStanceHolder", UIParent)
ssmover:SetAllPoints(DuffedUIStance)
move:RegisterFrame(bar)

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show,",
	["PRIEST"] = "show,",
	["HUNTER"] = "show,",
	["WARLOCK"] = "show,",
	["MONK"] = "show,",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		StanceBarFrame.ignoreFramePositionManager = true
		StanceBarFrame:StripTextures()
		StanceBarFrame:SetParent(bar)
		StanceBarFrame:ClearAllPoints()
		StanceBarFrame:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", -7, -25)
		StanceBarFrame:EnableMouse(false)

		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton" .. i]
			button:SetFrameStrata("LOW")
			if i ~= 1 then
				button:ClearAllPoints()
				local previous = _G["StanceButton" .. i - 1]
				if C["actionbar"].verticalshapeshift then button:Point("TOP", previous, "BOTTOM", 0, -D.buttonspacing) else button:Point("LEFT", previous, "RIGHT", D.buttonspacing, 0) end
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then button:Show() else button:Hide() end
		end
		RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle] hide; show")
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		if InCombatLockdown() then return end
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton" .. i]
			local _, name = GetShapeshiftFormInfo(i)
			if name then button:Show() else button:Hide() end
		end
		if C["actionbar"].verticalshapeshift then
			ShapeShiftBorder:Size(((StanceButton1:GetWidth() + D.buttonspacing)) + D.buttonspacing, StanceButton1:GetHeight() * GetNumShapeshiftForms()+ (GetNumShapeshiftForms() + 1) * D.buttonspacing)
		else
			ShapeShiftBorder:Size(((StanceButton1:GetWidth() + D.buttonspacing) * GetNumShapeshiftForms()) + D.buttonspacing, StanceButton1:GetHeight() + 2 * D.buttonspacing)
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		D.ShiftBarUpdate(self)
		D.StyleShift(self)
		if C["actionbar"].verticalshapeshift then
			ShapeShiftBorder:Size(((StanceButton1:GetWidth() + D.buttonspacing)) + D.buttonspacing, StanceButton1:GetHeight() * GetNumShapeshiftForms() + (GetNumShapeshiftForms() + 1) * D.buttonspacing)
		else
			ShapeShiftBorder:Size(((StanceButton1:GetWidth() + D.buttonspacing) * GetNumShapeshiftForms()) + D.buttonspacing, StanceButton1:GetHeight()+ 2 * D.buttonspacing)
		end

		if C["actionbar"].shapeshiftmouseover == true then
			local function mouseover(alpha)
				for i = 1, NUM_STANCE_SLOTS do
					local sb = _G["StanceButton" .. i]
					sb:SetAlpha(alpha)
				end
			end

			for i = 1, NUM_STANCE_SLOTS do
				_G["StanceButton" .. i]:SetAlpha(0)
				_G["StanceButton" .. i .. "Cooldown"]:SetDrawBling(false)
				_G["StanceButton" .. i .. "Cooldown"]:SetSwipeColor(0, 0, 0, 0)
				_G["StanceButton" .. i]:HookScript("OnEnter", function(self) mouseover(1) end)
				_G["StanceButton" .. i]:HookScript("OnLeave", function(self) mouseover(0) end)
			end
			ShapeShiftBorder:EnableMouse(true)
			ShapeShiftBorder:HookScript("OnEnter", function(self) mouseover(1) end)
			ShapeShiftBorder:HookScript("OnLeave", function(self) mouseover(0) end)
		end
	else
		D.ShiftBarUpdate(self)
	end
end)

local ssborder = CreateFrame("Frame", "ShapeShiftBorder", StanceButton1)
if C["actionbar"].shapeshiftborder ~= true then ssborder:SetAlpha(0) else ssborder:SetTemplate("Transparent") end
ssborder:SetFrameLevel(1)
ssborder:SetFrameStrata("BACKGROUND")
if C["actionbar"].verticalshapeshift then ssborder:Point("TOP", 0, D.buttonspacing) else ssborder:Point("LEFT", -D.buttonspacing, 0) end
RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")