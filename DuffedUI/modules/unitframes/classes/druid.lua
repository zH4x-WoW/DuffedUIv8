local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:AddDruidFeatures()
	local Health = self.Health
	local DruidMana = CreateFrame("StatusBar", nil, self.Health)
	local Background = DruidMana:CreateTexture(nil, 'BACKGROUND')
	local Backdrop = DruidMana:CreateTexture(nil, 'BACKGROUND')
	local Mushrooms = CreateFrame("Frame", nil, self)
	
	-- Druid Mana
	DruidMana:Size(250, 8)
	DruidMana:Point("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, 0)
	DruidMana:SetStatusBarTexture(C["medias"].Normal)
	DruidMana:SetStatusBarColor(.30, .52, .90)

	Background:SetAllPoints(DruidMana)
	Background:SetTexture(.30, .52, .90, .2)
	
	Backdrop:Point("TOPLEFT", 0, 1)
	Backdrop:Point("BOTTOMRIGHT", 0, -1)
	Backdrop:SetTexture(0, 0, 0, 1)
	
	-- Mushrooms
	Mushrooms:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Mushrooms:SetWidth(250)
	Mushrooms:SetHeight(8)
	Mushrooms:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	Mushrooms:SetBackdropColor(0, 0, 0)
	Mushrooms:SetBackdropBorderColor(0, 0, 0)
	
	for i = 1, 3 do
		Mushrooms[i] = CreateFrame("StatusBar", nil, Mushrooms)
		Mushrooms[i]:Height(8)
		Mushrooms[i]:SetStatusBarTexture(C["medias"].Normal)
		
		if i == 1 then
			Mushrooms[i]:Width((250 / 3) - 1)
			Mushrooms[i]:SetPoint("LEFT", Mushrooms, "LEFT", 0, 0)
		else
			Mushrooms[i]:Width((250 / 3))
			Mushrooms[i]:SetPoint("LEFT", Mushrooms[i-1], "RIGHT", 1, 0)
		end
		
		Mushrooms[i].bg = Mushrooms[i]:CreateTexture(nil, 'ARTWORK')
	end
	
	Mushrooms:SetScript("OnShow", function(self) 
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	Mushrooms:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	self.DruidMana = DruidMana
	self.DruidMana.bg = Background
	self.DruidMana.bd = Backdrop
	self.WildMushroom = Mushrooms
end