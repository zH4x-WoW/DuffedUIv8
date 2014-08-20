local D, C, L = unpack(select(2, ...))
if D.Class ~= "MONK" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

--[[D.ConstructEnergy("Energy", 216, 5)

D.ConstructRessources = function(name, width, height)
	local Bar = CreateFrame("Frame", name, health)
	Bar:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
	Bar:Size(width, height)
	Bar:SetBackdrop(backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	Bar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		Bar[i] = CreateFrame("StatusBar", name .. i, Bar)
		Bar[i]:Height(5)
		Bar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			Bar[i]:Width(width / 6)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width(width / 6)
			Bar[i]:SetPoint("LEFT", Bar[i - 1], "RIGHT", 1, 0)
		end
	end

	Bar:CreateBackdrop()
end]]