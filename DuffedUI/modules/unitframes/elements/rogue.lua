local D, C, L = unpack(select(2, ...))
if D.Class ~= "ROGUE" then return end

-- Credits go to Hydra
-- nice and clean way to display ComboPoints
local Color = RAID_CLASS_COLORS[D.Class]
local NumPoints = MAX_COMBO_POINTS
local Texture = C["media"].normTex
local Font = C["media"].font

local UnitHasVehicleUI = UnitHasVehicleUI
local GetComboPoints = GetComboPoints
local UIFrameFade = UIFrameFade
local UnitPowerMax = UnitPowerMax
local UnitPower = UnitPower
local GetSpellInfo = GetSpellInfo
local UnitAura = UnitAura
local select = select

local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

D.ConstructEnergy("Energy", 216, 5)

local GetAnticipation = function()
	local Name = GetSpellInfo(115189)
	local Count = select(4, UnitAura("player", Name))

	if (Count and Count > 0) then return Count end
end

local SetComboPoints = function(self)
	local Points = (UnitHasVehicleUI("player") and GetComboPoints("vehicle", "target") or GetComboPoints("player", "target"))

	for i = 1, NumPoints do
		if (i <= Points) then self[i]:SetAlpha(1) else self[i]:SetAlpha(.3) end
	end
end

local ComboPoints = CreateFrame("Frame", "ComboPoints", UIParent)
ComboPoints:CreateBackdrop()
ComboPoints:SetSize(216, 5)
ComboPoints:SetPoint("BOTTOM", CBAnchor, "TOP", 0, -5)
ComboPoints:RegisterEvent("UNIT_COMBO_POINTS")
ComboPoints:RegisterEvent("PLAYER_TARGET_CHANGED")
ComboPoints:RegisterEvent("PLAYER_ENTERING_WORLD")
ComboPoints:RegisterEvent("PLAYER_REGEN_DISABLED")
ComboPoints:RegisterEvent("PLAYER_REGEN_ENABLED")
ComboPoints:RegisterEvent("UNIT_AURA")
ComboPoints:SetScript("OnEvent", function(self, event, arg1)
	self[event](self, arg1)
end)

ComboPoints["UNIT_AURA"] = function(self, unit)
	if (unit ~= "player") then return end
	local Count = GetAnticipation()
	self.Anticipation:SetText(Count and Count or "")
end
ComboPoints["UNIT_COMBO_POINTS"] = function(self) SetComboPoints(self) end
ComboPoints["PLAYER_TARGET_CHANGED"] = function(self) SetComboPoints(self) end
ComboPoints["PLAYER_ENTERING_WORLD"] = function(self)
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

ComboPoints.Anticipation = ComboPoints:CreateFontString(nil, "OVERLAY")
ComboPoints.Anticipation:SetFont(Font, 16)
ComboPoints.Anticipation:SetPoint("RIGHT", ComboPoints, "LEFT", -3, -3)
ComboPoints.Anticipation:SetTextColor(unpack(Colors[5]))
ComboPoints.Anticipation:SetShadowColor(0, 0, 0)
ComboPoints.Anticipation:SetShadowOffset(1.25, -1.25)

for i = 1, NumPoints do
	ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
	ComboPoints[i]:SetStatusBarTexture(Texture)
	ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
	ComboPoints[i]:SetHeight(5)

	if (i == 1) then
		ComboPoints[i]:SetWidth(44)
		ComboPoints[i]:SetPoint("LEFT", ComboPoints, "LEFT", 0, 0)
	else
		ComboPoints[i]:SetWidth(42)
		ComboPoints[i]:SetPoint("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
	end
end
