local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:AddWarriorFeatures()
	local TotemBar = self.Totems
	D["Colors"].totems[1] = { 205/255, 92/255, 92/255 }
	
	TotemBar[1]:ClearAllPoints()
	TotemBar[1]:SetAllPoints()

	for i = 2, MAX_TOTEMS do
		TotemBar[i]:Hide()
	end
end