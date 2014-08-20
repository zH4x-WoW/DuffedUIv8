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
	[6] = {0, 0, 1},
}

--D.ConstructEnergy("Energy", 216, 5)

D.ConstructRessources = function(width, height)
	local eclipseBar = CreateFrame('Frame', nil, UIParent)
	eclipseBar:Point("LEFT", DruidManaBackground, "LEFT", 0, 0)
	eclipseBar:Size(width, height)
	eclipseBar:SetFrameStrata("MEDIUM")
	eclipseBar:SetFrameLevel(8)
	eclipseBar:SetBackdropBorderColor(0,0,0,0)

	local lunarBar = CreateFrame("StatusBar", nil, eclipseBar)
	lunarBar:SetPoint('LEFT', eclipseBar, 'LEFT', 0, 0)
	lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
	lunarBar:SetStatusBarTexture(normTex)
	lunarBar:SetStatusBarColor(.30, .52, .90)
	eclipseBar.LunarBar = lunarBar

	local solarBar = CreateFrame("StatusBar", nil, eclipseBar)
	solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT', 0, 0)
	solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
	solarBar:SetStatusBarTexture(normTex)
	solarBar:SetStatusBarColor(.80, .82,  .60)
	eclipseBar.SolarBar = solarBar

	local eclipseBarText = eclipseBar:CreateFontString(nil, 'OVERLAY')
	eclipseBarText:SetPoint('TOP', eclipseBar, 0, 25)
	eclipseBarText:SetPoint('BOTTOM', eclipseBar)
	eclipseBarText:SetFont(C["media"].font, 12, "THINOUTLINE")
	eclipseBarText:SetShadowOffset(D.mult, -D.mult)
	eclipseBarText:SetShadowColor(0, 0, 0, 0.4)
	eclipseBar.PostUpdatePower = D.EclipseDirection

	if eclipseBar and eclipseBar:IsShown() then FlashInfo.ManaLevel:SetAlpha(0) end
	EclipseBar = eclipseBar
	EclipseBar.Text = eclipseBarText
	eclipseBar.FrameBackdrop = CreateFrame("Frame", nil, eclipseBar)
	eclipseBar.FrameBackdrop:SetTemplate("Default")
	eclipseBar.FrameBackdrop:SetPoint("TOPLEFT", D.Scale(-2), D.Scale(2))
	eclipseBar.FrameBackdrop:SetPoint("BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	eclipseBar.FrameBackdrop:SetFrameLevel(eclipseBar:GetFrameLevel() - 1)

	local ComboPoints = CreateFrame("Frame", "ComboPoints", UIParent)
	ComboPoints:SetPoint("BOTTOM", CBAnchor, "TOP", 0, -5)
	ComboPoints:SetSize((43 * 5) + 1, height)
	ComboPoints:CreateBackdrop()

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", "ComboPoints"..i, ComboPoints)
		ComboPoints[i]:SetHeight(height)
		ComboPoints[i]:SetStatusBarTexture(normTex)
		ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
		if i == 1 then
			ComboPoints[i]:SetWidth(40)
			ComboPoints[i]:Point("LEFT", ComboPoints, "LEFT", 0, 0)
		else
			ComboPoints[i]:SetWidth(43)
			ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
		end
		ComboPoints[i]:SetBackdropColor(unpack(Colors[i]))
		ComboPoints[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
		ComboPoints[i]:RegisterEvent("UNIT_COMBO_POINTS")
		ComboPoints[i]:RegisterEvent("PLAYER_TARGET_CHANGED")
		ComboPoints[i]:SetScript("OnEvent", function(self, event)
			local points, pt = 0, GetComboPoints("player", "target")
			if pt == points then
				ComboPoints[i]:Hide()
			elseif pt > points then
				for i = points + 1, pt do
					ComboPoints[i]:Show()
				end
			else
				for i = pt + 1, points do
					ComboPoints[i]:Hide()
				end
			end
			points = pt
		end)
	end
end