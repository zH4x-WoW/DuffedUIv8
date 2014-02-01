local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARRIOR") then
	return
end

function DuffedUIUnitFrames:AddWarriorFeatures()
	-- Totem Bar (Demoralizing / Mocking / Skull Banner)
	if C["unitFrames"].TotemBar then
		D["Colors"].totems[1] = { 205/255, 92/255, 92/255 }
		
		local TotemBar = self.Totems
		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end
	end
end