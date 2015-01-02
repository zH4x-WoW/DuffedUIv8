local D, C, L = unpack(select(2, ...))

D.Dummy = function() return end
D.MyName = select(1, UnitName("player"))
D.Class = select(2, UnitClass("player"))
D.MyRace = select(2, UnitRace("player"))
D.Level = UnitLevel("player")
D.MyRealm = GetRealmName()
D.Client = GetLocale() 
D.Resolution = GetCVar("gxResolution")
D.ScreenHeight = tonumber(string.match(D.Resolution, "%d+x(%d+)"))
D.ScreenWidth = tonumber(string.match(D.Resolution, "(%d+)x+%d"))
D.Version = GetAddOnMetadata("DuffedUI", "Version")
D.VersionNumber = tonumber(D.Version)
D.Patch, D.BuildText, D.ReleaseDate, D.Toc = GetBuildInfo()
D.build = tonumber(D.BuildText)
D.InfoLeftRightWidth = 370
D.IconCoord = {.08, .92, .08, .92}

D.Credits = {
	"Tukz",
	"Hydra",
	"Elv",
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
	"humfras aka Shinizu",
	"Hizuro",
	"Duugu",
	"Phanx",
	"ObbleYeah",
}

D.DuffedCredits = {
	"Shaney",
	"Juhawny",
	"Rav",
	"loki",
	"Shariza",
	"Dahgoth",
	"Sandoras",
	"Sinaris",
	"Digawen",
	"Zenglao",
	"devel1988",
	"Grimbeorn",
	"Ginji",
	"Floppiflappsi",
	"Slideroh",
	"McTrap",
	"HackManiac",
	"Yascha",
	"DarKleFou",
}