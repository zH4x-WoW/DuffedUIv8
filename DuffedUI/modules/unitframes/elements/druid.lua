local D, C, L = unpack(select(2, ...))
if D.Class ~= "DRUID" then return end

local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

-- ComboPoints
local ComboPoints = CreateFrame("Frame", "ComboPoints", UIParent)
for i = 1, 5 do
	ComboPoints[i] = CreateFrame("Frame", "ComboPoints" .. i, UIParent)
	ComboPoints[i]:SetHeight(5)
	ComboPoints[i]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	if i == 1 then
		ComboPoints[i]:SetWidth(44)
		ComboPoints[i]:Point("BOTTOMLEFT", CBAnchor, "TOPLEFT", 2, 8)
	else
		ComboPoints[i]:SetWidth(42)
		ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 3, 0)
	end
	ComboPoints[i]:SetTemplate("Default")
	ComboPoints[i]:CreateBackdrop()
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