local addon, engine = ...
engine[1] = {}
engine[2] = {}
engine[3] = {}
engine[4] = {}

DuffedUI = engine

local D, C, L, G = unpack(select(2, ...))

D.dummy = function() return end
D.myname = select(1, UnitName("player"))
D.Class = select(2, UnitClass("player"))
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

G.ActionBars = {}
G.Auras = {}
G.Chat = {}
G.DataText = {}
G.Loot = {}
G.Maps = {}
G.Misc = {}
G.NamePlates = {}
G.Panels = {}
G.Skins = {}
G.Tooltips = {}
G.UnitFrames = {}
G.Install = {}

local UIHider = CreateFrame("Frame", "DuffedUIUIHider", UIParent)
UIHider:Hide()

local PetBattleHider = CreateFrame("Frame", "DuffedUIPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

D.Credits = {
	"Azilroka",
	"Caith",
	"Ishtara",
	"Hungtar",
	"Tulla",
	"P3lim",
	"Alza",
	"Roth",
	"Tekkub",
	"Shestak",
	"Caellian",
	"Haleth",
	"Nightcracker",
	"Haste",
	"Hydra",
	"Elv",
	"Tukz",
}

D.DuffedCredits = {
	"Shaney",
	"Juhawny",
	"Rav",
	"loki",
	"Sinaris",
	"Digawen",
	"Zenglao",
	"devel1988",
}

ERR_NOT_IN_RAID = "";