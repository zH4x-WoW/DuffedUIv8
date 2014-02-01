-- NOTE : Please Fix me, Totem Bar Position, when Arcane Bar Is Show!

local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MAGE") then
	return
end

function DuffedUIUnitFrames:AddMageFeatures()
	local ArcaneChargeBar = CreateFrame("Frame", nil, self)
	
	-- Arcane Charges
	ArcaneChargeBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	ArcaneChargeBar:Size(250, 8)
	ArcaneChargeBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	ArcaneChargeBar:SetBackdropColor(0, 0, 0)
	ArcaneChargeBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneChargeBar[i] = CreateFrame("StatusBar", nil, ArcaneChargeBar)
		ArcaneChargeBar[i]:Height(8)
		ArcaneChargeBar[i]:SetStatusBarTexture(C["medias"].Normal)
		ArcaneChargeBar[i].bg = ArcaneChargeBar[i]:CreateTexture(nil, 'ARTWORK')

		if i == 1 then
			ArcaneChargeBar[i]:Width((250 / 4) - 2)
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar, "LEFT", 0, 0)
		else
			ArcaneChargeBar[i]:Width((250 / 4 - 1))
			ArcaneChargeBar[i]:Point("LEFT", ArcaneChargeBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	-- Shadow Effect Updates
	ArcaneChargeBar:SetScript("OnShow", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	ArcaneChargeBar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Totem Bar (Rune of Power)
	if C["unitframes"].TotemBar then
		D["Colors"].totems = {
			[1] = { 132/255, 112/255, 255/255 },
			[2] = { 132/255, 112/255, 255/255 },
		}

		local TotemBar = self.Totems
		for i = 1, 2 do
			TotemBar[i]:ClearAllPoints()
			TotemBar[i]:Height(8)

			if i == 1 then
				TotemBar[i]:Width((250 / 2) - 1)
				TotemBar[i]:SetPoint("LEFT", TotemBar, "LEFT", 0, 0)
			else
				TotemBar[i]:Width(250 / 2)
				TotemBar[i]:SetPoint("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
			end
		end

		TotemBar[3]:Hide()
		TotemBar[4]:Hide()
	end
	
	-- Register
	self.ArcaneChargeBar = ArcaneChargeBar
end