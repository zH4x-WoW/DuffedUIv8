-- Initiation of DuffedUI engine
local addon, engine = ...
engine[1] = {}
engine[2] = {}
engine[3] = {}
engine[4] = {}

DuffedUI = engine

-- We need this as soon we begin loading DuffedUI
local D, C, L, G = unpack(select(2, ...))

-- functions, constants, variables
D.dummy = function() return end
D.myname = select(1, UnitName("player"))
D.myclass = select(2, UnitClass("player"))
D.myrace = select(2, UnitRace("player"))
D.myfaction = UnitFactionGroup("player")
D.client = GetLocale() 
D.resolution = GetCVar("gxResolution")
D.screenheight = tonumber(string.match(D.resolution, "%d+x(%d+)"))
D.screenwidth = tonumber(string.match(D.resolution, "(%d+)x+%d"))
D.version = GetAddOnMetadata("DuffedUI", "Version")
D.versionnumber = tonumber(D.version)
D.incombat = UnitAffectingCombat("player")
D.patch, D.buildtext, D.releasedate, D.toc = GetBuildInfo()
D.build = tonumber(D.buildtext)
D.level = UnitLevel("player")
D.myrealm = GetRealmName()
D.InfoLeftRightWidth = 370

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

-- Modules
G.ActionBars = {}
G.Auras = {}
G.Chat = {}
G.DataText = {}
G.Loot = {}
G.Maps = {}
G.Misc = {}
G.Skins = {}
G.Tooltips = {}
G.UnitFrames = {}

-- Hider
local UIHider = CreateFrame("Frame", "DuffedUIUIHider", UIParent)
UIHider:Hide()

-- Hider Secure (mostly used to hide stuff while in pet battle)
local PetBattleHider = CreateFrame("Frame", "DuffedUIPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

ERR_NOT_IN_RAID = "";