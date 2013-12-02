local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddDruidFeatures()
	local TotemBar = self.Totems

	-- Druid Mana
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)
	DruidMana:Size(250, 8)
	DruidMana:Point("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, 0)
	DruidMana:SetStatusBarTexture(C.Medias.Normal)
	DruidMana:SetStatusBarColor(0.30, 0.52, 0.90)

	DruidMana:SetBackdrop(TukuiUnitFrames.Backdrop)
	DruidMana:SetBackdropColor(0, 0, 0)
	DruidMana:SetBackdropBorderColor(0, 0, 0)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(0.30, 0.52, 0.90, 0.2)

	-- Totem Colors
	T["Colors"].totems = {
		[1] = { 95/255, 222/255, 95/255 },
		[2] = { 95/255, 222/255, 95/255 },
		[3] = { 95/255, 222/255, 95/255 },
	}

	-- Totem Bar (Druid - Wild Mushrooms)
	for i = 1, 3 do
		TotemBar[i]:ClearAllPoints()
		TotemBar[i]:Height(8)

		if i == 1 then
			TotemBar[i]:Width((250 / 3) - 1)
			TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
		else
			TotemBar[i]:Width(250 / 3)
			TotemBar[i]:SetPoint("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
		end
	end

	TotemBar[4]:Hide()

	-- Register
	self.DruidMana = DruidMana
	self.DruidMana.bg = DruidMana.Background
end