local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local texture = C["media"]["normTex"]
local f, fs, ff = C["media"]["font"], 11, "THINOUTLINE"
local layout = C["unitframes"]["layout"]
local move = D["move"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

local settings = {}
--settings["<cvar>"]
D["NamePlateCVars"] = settings

D["ConstructNP"] = function(self)

end