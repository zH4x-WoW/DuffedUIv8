----------------------------------------------------------------
-- Initiation of DuffedUI engine
----------------------------------------------------------------

-- [[ Build the engine ]] --
local addon, engine = ...
engine[1] = {}
engine[2] = {}
engine[3] = {}

function engine:unpack()
	return self[1], self[2], self[3]
end

engine[1].Resolution = GetCVar("gxResolution")
engine[1].ScreenHeight = tonumber(string.match(engine[1].Resolution, "%d+x(%d+)"))
engine[1].ScreenWidth = tonumber(string.match(engine[1].Resolution, "(%d+)x+%d"))
engine[1].MyClass = select(2, UnitClass("player"))
engine[1].MyLevel = UnitLevel("player")

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

DuffedUI = engine