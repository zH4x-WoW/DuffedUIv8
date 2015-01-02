local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "PRIEST" then return end

D["ClassRessource"]["PRIEST"] = function(self)
	local ShadowOrb = CreateFrame("Frame", "ShadowOrbsBar", UIParent)
	ShadowOrb:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			ShadowOrb:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			ShadowOrb:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			ShadowOrb:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			ShadowOrb:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		ShadowOrb:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	ShadowOrb:SetBackdrop(backdrop)
	ShadowOrb:SetBackdropColor(0, 0, 0)
	ShadowOrb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		ShadowOrb[i] = CreateFrame("StatusBar", "ShadowOrbsBar" .. i, ShadowOrb)
		ShadowOrb[i]:Height(5)
		ShadowOrb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			ShadowOrb[i]:Width((216 / 5) - 3)
			ShadowOrb[i]:SetPoint("LEFT", ShadowOrb, "LEFT", 0, 0)
		else
			ShadowOrb[i]:Width(216 / 5)
			ShadowOrb[i]:SetPoint("LEFT", ShadowOrb[i - 1], "RIGHT", 1, 0)
		end
		ShadowOrb[i].bg = ShadowOrb[i]:CreateTexture(nil, "ARTWORK")
	end
	ShadowOrb:CreateBackdrop()
	self.ShadowOrbsBar = ShadowOrb

	if C["unitframes"]["oocHide"] then D["oocHide"](ShadowOrb) end
end