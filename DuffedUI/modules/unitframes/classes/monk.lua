local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddMonkFeatures()
	local TotemBar = self.Totems
	local Shadow = self.Shadow

	-- Totem Colors
	T["Colors"].totems = {
		[1] = { 95/255, 222/255, 95/255 },
	}

	-- Totem Bar (Monk Black Ox / Jade Serpent Statues)
	TotemBar:ClearAllPoints()
	TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)

	TotemBar[1]:ClearAllPoints()
	TotemBar[1]:SetAllPoints()

	for i = 2, MAX_TOTEMS do
		TotemBar[i]:Hide()
	end

	TotemBar:SetScript("OnShow", function(self) 
		TukuiUnitFrames.UpdateShadow(self, "OnShow", -4, 22)
	end)

	TotemBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, "OnHide", -4, 12)
	end)

	-- Harmony Bar
	local Harmony = CreateFrame("Frame", nil, self)
	Harmony:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Harmony:Size(250, 8)
	Harmony:SetBackdrop(TukuiUnitFrames.Backdrop)
	Harmony:SetBackdropColor(0, 0, 0)
	Harmony:SetBackdropBorderColor(0, 0, 0)	

	for i = 1, 5 do
		Harmony[i] = CreateFrame("StatusBar", nil, Harmony)
		Harmony[i]:Height(8)
		Harmony[i]:SetStatusBarTexture(C.Medias.Normal)

		if i == 1 then
			Harmony[i]:Width(250 / 5)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 0, 0)
		else
			Harmony[i]:Width((250 / 5) - 1)
			Harmony[i]:SetPoint("LEFT", Harmony[i-1], "RIGHT", 1, 0)
		end
	end

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	-- Register
	self.HarmonyBar = Harmony
end