local D, C, L = unpack(select(2, ...))
if D.Class ~= "WARLOCK" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

D.ConstructEnergy("Energy", 216, 5)

D.ConstructRessources = function(name, width, height)
	local wb = CreateFrame("Frame", name, UIParent)
	wb:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
	wb:Size(width, height)
	wb:SetBackdrop(backdrop)
	wb:SetBackdropColor(0, 0, 0)
	wb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		wb[i] = CreateFrame("StatusBar", name..i, wb)
		wb[i]:Height(height)
		wb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			wb[i]:Width(width / 4)
			wb[i]:SetPoint("LEFT", wb, "LEFT", 0, 0)
		else
			wb[i]:Width(width / 4)
			wb[i]:SetPoint("LEFT", wb[i - 1], "RIGHT", 1, 0)
		end
		wb[i].bg = wb[i]:CreateTexture(nil, 'ARTWORK')
	end
	wb:CreateBackdrop()
end