local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "ROGUE") then
	return
end

function DuffedUIUnitFrames:AddRogueFeatures()

end