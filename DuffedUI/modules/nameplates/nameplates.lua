local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local f, fs, ff = C["media"]["font"], 8, "THINOUTLINE"
local nWidth, nHeight = C["nameplate"]["platewidth"], C["nameplate"]["plateheight"]
local pScale = C["nameplate"]["platescale"]
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
	health.colorTapping = true
	health.colorReaction = true
	health.frequentUpdates = true
	if C["nameplate"]["classcolor"] then
		health.colorClass = true
	else
		health.colorClass = false
	end

	-- health border
	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:Point("TOPLEFT", health, "TOPLEFT", -1, 1)
	HealthBorder:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", 1, -1)
	HealthBorder:SetTemplate("Transparent")
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	-- background
	bg = health:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(.2, .2, .2)

	-- name
	name = health:CreateFontString(nil, "OVERLAY")
	name:Point("LEFT", health, "LEFT", 0, 10)
	name:SetJustifyH("LEFT")
	name:SetFont(f, fs, ff)
	name:SetShadowOffset(1.25, -1.25)
	self:Tag(name, "[difficulty][level][shortclassification] [DuffedUI:getnamecolor][DuffedUI:namelong]")

	-- size
	self:SetSize(nWidth, nHeight)
	self:SetPoint("CENTER", 0, 0)
	self:SetScale(pScale * UIParent:GetScale())

	-- Init
	self.Health = health
	self.Name = name
end