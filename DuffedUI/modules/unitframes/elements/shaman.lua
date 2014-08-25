local D, C, L = unpack(select(2, ...))
if D.Class ~= "SHAMAN" then return end

local texture = C["media"].normTex
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

if not C["unitframes"].attached then
	D.ConstructEnergy("Energy", 216, 5)
end

D.ConstructRessources = function(name, width, height)
	local TotemBar = CreateFrame("Frame", name, UIParent)
	TotemBar:Size(width, height)
	TotemBar:SetBackdrop(backdrop)
	TotemBar:SetBackdropColor(0, 0, 0)
	TotemBar:SetBackdropBorderColor(0, 0, 0)
	
	for i = 1, 4 do
		TotemBar[i] = CreateFrame("StatusBar", name ..i, TotemBar)
		TotemBar[i]:SetHeight(height)
		TotemBar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			TotemBar[i]:SetWidth(width / 4)
			TotemBar[i]:Point("LEFT", TotemBar, "LEFT", 0, 0)
		else
			TotemBar[i]:SetWidth((width / 4) - 1)
			TotemBar[i]:SetPoint("LEFT", TotemBar[i - 1], "RIGHT", 1, 0)
		end
		TotemBar[i]:SetMinMaxValues(0, 1)
		TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "ARTWORK")
		TotemBar[i].bg:SetAllPoints()
		TotemBar[i].bg:SetTexture(texture)
		TotemBar[i].bg.multiplier = .2
	end
	TotemBar:CreateBackdrop()
end