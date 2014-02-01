local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "DRUID") then
	return
end

function DuffedUIUnitFrames:AddDruidFeatures()
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)

	-- Druid Mana
	DruidMana:Size(250, 8)
	DruidMana:Point("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, 0)
	DruidMana:SetStatusBarTexture(C["medias"].Normal)
	DruidMana:SetStatusBarColor(0.30, 0.52, 0.90)

	DruidMana:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	DruidMana:SetBackdropColor(0, 0, 0)
	DruidMana:SetBackdropBorderColor(0, 0, 0)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(0.30, 0.52, 0.90, 0.2)

	-- Totem Bar (Wild Mushrooms)
	if C["unitframes"].TotemBar) then
		D["Colors"].totems = {
			[1] = { 95/255, 222/255, 95/255 },
			[2] = { 95/255, 222/255, 95/255 },
			[3] = { 95/255, 222/255, 95/255 },
		}

		local TotemBar = self.Totems
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
	end

	-- Register
	self.DruidMana = DruidMana
	self.DruidMana.bg = DruidMana.Background
end