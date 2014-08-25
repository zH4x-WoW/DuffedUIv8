local D, C, L = unpack(select(2, ...))
if D.Class ~= "DRUID" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

Colors = {
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

if not C["unitframes"].attached then
	D.ConstructEnergy("Energy", 216, 5)
end

D.ConstructRessources = function(name, width, height)
	local DruidMana = CreateFrame("StatusBar", name .. "Mana", UIParent)
	DruidMana:Size(width, 2)
	DruidMana:SetStatusBarTexture(texture)
	DruidMana:SetStatusBarColor(.30, .52, .90)
	DruidMana:CreateBackdrop()

	DruidMana:SetBackdrop(backdrop)
	DruidMana:SetBackdropColor(0, 0, 0)
	DruidMana:SetBackdropBorderColor(0, 0, 0)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(.30, .52, .90, .2)

	local EclipseBar = CreateFrame("Frame", name .. "EclipseBar", UIParent)
	EclipseBar:SetFrameStrata("MEDIUM")
	EclipseBar:SetFrameLevel(8)
	EclipseBar:Size(width, height)
	EclipseBar:SetBackdrop(backdrop)
	EclipseBar:SetBackdropColor(0, 0, 0)
	EclipseBar:SetBackdropBorderColor(0, 0, 0, 0)

	EclipseBar.LunarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.LunarBar:SetPoint("LEFT", EclipseBar, "LEFT", 0, 0)
	EclipseBar.LunarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.LunarBar:SetStatusBarTexture(texture)
	EclipseBar.LunarBar:SetStatusBarColor(.50, .52, .70)

	EclipseBar.SolarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.SolarBar:SetPoint("LEFT", EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	EclipseBar.SolarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.SolarBar:SetStatusBarTexture(texture)
	EclipseBar.SolarBar:SetStatusBarColor(.80, .82,  .60)

	EclipseBar.Text = EclipseBar:CreateFontString(nil, "OVERLAY")
	EclipseBar.Text:SetPoint("BOTTOM", EclipseBar, "TOP", 0, 0)
	EclipseBar.Text:SetFont(C["media"].font, 12, "THINOUTLINE")
	EclipseBar.PostUpdatePower = D.EclipseDirection

	local WildMushroom = CreateFrame("Frame", name .. "WildMushroom", UIParent)
	WildMushroom:SetSize(width, height)
	WildMushroom:SetBackdrop(backdrop)
	WildMushroom:SetBackdropColor(0, 0, 0)
	WildMushroom:SetBackdropBorderColor(0, 0, 0)
	
	for i = 1, 3 do
		WildMushroom[i] = CreateFrame("StatusBar", name .. "WildMushroom" .. i, WildMushroom)
		WildMushroom[i]:SetHeight(height)
		WildMushroom[i]:SetStatusBarTexture(texture)
		if i == 1 then
			WildMushroom[i]:SetWidth(width / 3)
			WildMushroom[i]:SetPoint("LEFT", WildMushroom, "LEFT", 0, 0)
		else
			WildMushroom[i]:SetWidth((width / 3) - 1)
			WildMushroom[i]:SetPoint("LEFT", WildMushroom[i - 1], "RIGHT", 1, 0)
		end
		WildMushroom[i].bg = WildMushroom[i]:CreateTexture(nil, 'ARTWORK')
	end
	WildMushroom:CreateBackdrop()

	local NumPoints = MAX_COMBO_POINTS
	local UnitHasVehicleUI = UnitHasVehicleUI
	local GetComboPoints = GetComboPoints
	local select = select
	local SetComboPoints = function(self)
		local Points = (UnitHasVehicleUI("player") and GetComboPoints("vehicle", "target") or GetComboPoints("player", "target"))

		for i = 1, NumPoints do
			if (i <= Points) then self[i]:SetAlpha(1) else self[i]:SetAlpha(.3) end
		end
	end

	local ComboPoints = CreateFrame("Frame", name .. "ComboPoints", UIParent)
	ComboPoints:CreateBackdrop()
	ComboPoints:SetSize(width, height)
	ComboPoints:RegisterEvent("UNIT_COMBO_POINTS")
	ComboPoints:RegisterEvent("PLAYER_TARGET_CHANGED")
	ComboPoints:SetScript("OnEvent", function(self, event, arg1)
		self[event](self, arg1)
	end)

	ComboPoints["UNIT_COMBO_POINTS"] = function(self) SetComboPoints(self) end
	ComboPoints["PLAYER_TARGET_CHANGED"] = function(self) SetComboPoints(self) end

	for i = 1, NumPoints do
		ComboPoints[i] = CreateFrame("StatusBar", nil, ComboPoints)
		ComboPoints[i]:SetStatusBarTexture(texture)
		ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
		ComboPoints[i]:SetHeight(height)

		if (i == 1) then
			ComboPoints[i]:SetWidth(44)
			ComboPoints[i]:SetPoint("LEFT", ComboPoints, "LEFT", 0, 0)
		else
			ComboPoints[i]:SetWidth(42)
			ComboPoints[i]:SetPoint("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
		end
	end
end