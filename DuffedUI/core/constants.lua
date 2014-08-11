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

G.Chat = {}
G.DataText = {}