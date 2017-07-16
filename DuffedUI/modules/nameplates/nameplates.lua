local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local f, fs, ff = C["media"].font, 11, "THINOUTLINE"
local nWidth, nHeight = C["nameplate"]["platewidth"], C["nameplate"]["plateheight"]
local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructNameplates"] = function(self)
	-- Initial Elements
	self.colors = D["UnitColor"]

	-- health
	local health = CreateFrame("StatusBar", nil, self)
	health:SetAllPoints()
	health:SetStatusBarTexture(texture)
	health.colorHealth = true
	health.colorTapping = true
	health.colorDisconnected = true
	if C["nameplate"]["classcolor"] then
		health.colorClass = true
	else
		health.colorClass = false
	end

	-- health border
	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:Point("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	-- background
	bg = health:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(.2, .2, .2)

	-- size
	self:SetSize(nWidth, nHeight)
	self:SetPoint("CENTER", 0, 0)

	-- Init
	self.Health = health
end