local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:AddMonkFeatures()
	local Shadow = self.Shadow
	Shadow:Point("TOPLEFT", -4, 12)

	-- Statue Bar Update
	local Statue = self.Statue
	Statue:ClearAllPoints()
	Statue:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)

	Statue:SetScript("OnShow", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 21)
	end)

	Statue:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 12)
	end)

	-- Harmony Statue
	local Harmony = CreateFrame("Frame", nil, self)
	Harmony:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Harmony:SetWidth(250)
	Harmony:SetHeight(8)
	Harmony:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	Harmony:SetBackdropColor(0, 0, 0)
	Harmony:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		Harmony[i] = CreateFrame("StatusBar", nil, Harmony)
		Harmony[i]:Height(8)
		Harmony[i]:SetStatusBarTexture(C["Media"].Normal)

		if i == 1 then
			Harmony[i]:Width(250 / 5)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 0, 0)
		else
			Harmony[i]:Width((250 / 5) - 1)
			Harmony[i]:SetPoint("LEFT", Harmony[i-1], "RIGHT", 1, 0)
		end
	end

	self.HarmonyBar = Harmony
end