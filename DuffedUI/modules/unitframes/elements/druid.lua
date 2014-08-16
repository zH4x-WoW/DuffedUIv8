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

D.ConstructEnergy("Energy", 216, 5)

D.ConstructRessources = function(name, width, height)
	local DruidMana = CreateFrame("StatusBar", name .. "ManaDisplay", UIParent)
	DruidMana:Size(width, height)
	DruidMana:Point("TOP", CBAnchor, "BOTTOM", 0, -5)
	DruidMana:SetStatusBarTexture(texture)
	DruidMana:SetStatusBarColor(.30, .52, .90)
	DruidMana:CreateBackdrop()

	local ComboPoints = CreateFrame("Frame", "ComboPoints", UIParent)
	ComboPoints:SetPoint("BOTTOM", CBAnchor, "TOP", 0, -5)
	ComboPoints:SetSize((43 * 5) + 1, height)
	ComboPoints:CreateBackdrop()

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", name .. "ComboPoints"..i, ComboPoints)
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

	self.DruidMana = DruidMana
end