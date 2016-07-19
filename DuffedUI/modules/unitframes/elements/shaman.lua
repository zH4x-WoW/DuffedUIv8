local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "SHAMAN" then return end

D["ClassRessource"]["SHAMAN"] = function(self)
	--[[Energy]]--
	if not C["unitframes"]["attached"] then D["ConstructEnergy"]("Energy", 216, 5) end
	
	--[[Totems]]--
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
	end
	--TotemBar:SetTemplate("Default")

	for i = 1, MAX_TOTEMS do
		TotemBar[i] = CreateFrame("StatusBar", "TotemBar" .. i, TotemBar)
		TotemBar[i]:SetHeight(5)
		TotemBar[i]:EnableMouse(true)
		TotemBar[i].Icon = TotemBar[i]:CreateTexture(nil, "BORDER")
		TotemBar[i].Icon:SetAllPoints()
		TotemBar[i].Icon:SetAlpha(1)
		TotemBar[i].Icon:Size(TotemBar[i]:GetWidth(), 5)
		TotemBar[i].Icon:SetTexCoord(0.05, 0.95, 0.5, 0.7)
		if i == 1 then
			TotemBar[i]:SetWidth(216 / 4)
			TotemBar[i]:Point("LEFT", TotemBar, "LEFT", 0, 0)
		else
			TotemBar[i]:SetWidth(216 / 4 - 1)
			TotemBar[i]:SetPoint("LEFT", TotemBar[i - 1], "RIGHT", 1, 0)
		end
		TotemBar[i]:SetMinMaxValues(0, 1)
	end
	TotemBar:CreateBackdrop()
	self.Totems = TotemBar
	if C["unitframes"]["oocHide"] then D["oocHide"](TotemBar) end
	
	--[[ShamanMana]]--
	local SMB = CreateFrame("StatusBar", "ShamanManaBar", self.Health)
	SMB:Size(216, 5)
	if layout == 1 then
		SMB:Point("TOP", self.Power, "BOTTOM", 0, -25)
	elseif layout == 2 then
		SMB:Point("BOTTOM", self.Health, "TOP", 0, -5)
		SMB:SetFrameLevel(self.Health:GetFrameLevel() + 2)
	elseif layout == 3 then
		SMB:Point("CENTER", self.panel, "CENTER", 0, -3)
	elseif layout == 4 then
		SMB:Point("TOP", self.Health, "BOTTOM", 0, -10)
	end
	SMB:SetStatusBarTexture(texture)
	SMB:SetStatusBarColor(.30, .52, .90)
	SMB:SetFrameLevel(self.Health:GetFrameLevel() + 3)
	SMB.PostUpdatePower = D.PostUpdateAltMana
	SMB:CreateBackdrop()

	SMB:SetBackdrop(backdrop)
	SMB:SetBackdropColor(0, 0, 0)
	SMB:SetBackdropBorderColor(0, 0, 0)

	SMB.bg = SMB:CreateTexture(nil, "BORDER")
	SMB.bg:SetAllPoints(SMB)
	SMB.bg:SetTexture(.30, .52, .90, .2)

	self.DruidMana = SMB
	self.DruidMana.bg = SMB.bg
end