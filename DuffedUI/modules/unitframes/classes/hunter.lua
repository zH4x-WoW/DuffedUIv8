local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "HUNTER") then return end

function DuffedUIUnitFrames:AddHunterFeatures()

end