local D, C, L = unpack(select(2, ...))
if D.Class ~= "PRIEST" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

D.ConstructEnergy("Mana", 216, 5)

D.ConstructRessources = function(name, width, height)
	local pb = CreateFrame("Frame", name, UIParent)
	pb:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
	pb:Size(width, height)
	pb:SetBackdrop(backdrop)
	pb:SetBackdropColor(0, 0, 0)
	pb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		pb[i] = CreateFrame("StatusBar", name .. i, pb)
		pb[i]:Height(height)
		pb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			pb[i]:Width(width / 5)
			pb[i]:SetPoint("LEFT", pb, "LEFT", 0, 0)
		else
			pb[i]:Width((width / 5) - 1)
			pb[i]:SetPoint("LEFT", pb[i - 1], "RIGHT", 1, 0)
		end
	end
	pb:CreateBackdrop()
end