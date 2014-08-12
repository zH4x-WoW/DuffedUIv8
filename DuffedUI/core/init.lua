local addon, engine = ...
engine[1] = {}
engine[2] = {}
engine[3] = {}
engine[4] = {}

DuffedUI = engine

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

ERR_NOT_IN_RAID = ""

local UIHider = CreateFrame("Frame", "DuffedUIUIHider", UIParent)
UIHider:Hide()

local PetBattleHider = CreateFrame("Frame", "DuffedUIPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")