local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "SHAMAN" then return end

D["ClassRessource"]["SHAMAN"] = function(self)
	local TotemBar = CreateFrame("Frame", "TotemBar", UIParent)
	TotemBar:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			TotemBar:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			TotemBar:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			TotemBar:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			TotemBar:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		TotemBar:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	TotemBar:SetBackdrop(backdrop)
	TotemBar:SetBackdropColor(0, 0, 0)
	TotemBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		TotemBar[i] = CreateFrame("StatusBar", "TotemBar" .. i, TotemBar)
		TotemBar[i]:SetHeight(5)
		TotemBar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			TotemBar[i]:SetWidth(54)
			TotemBar[i]:Point("LEFT", TotemBar, "LEFT", 0, 0)
		else
			TotemBar[i]:SetWidth(53)
			TotemBar[i]:SetPoint("LEFT", TotemBar[i - 1], "RIGHT", 1, 0)
		end
		TotemBar[i]:SetMinMaxValues(0, 1)
		TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "ARTWORK")
		TotemBar[i].bg:SetAllPoints()
		TotemBar[i].bg:SetTexture(texture)
		TotemBar[i].bg.multiplier = .2
	end
	TotemBar:CreateBackdrop()
	self.TotemBar = TotemBar

	if C["unitframes"]["oocHide"] then D["oocHide"](TotemBar) end
end