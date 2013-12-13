local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddWarlockFeatures()
	local Shadow = self.Shadow
	local Bar = CreateFrame("Frame", nil, self)
	
	Shadow:Point("TOPLEFT", -4, 12)
	
	Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Bar:SetWidth(250)
	Bar:SetHeight(8)
	Bar:SetBackdrop(TukuiUnitFrames.Backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	Bar:SetBackdropBorderColor(0, 0, 0)	
	
	for i = 1, 4 do
		Bar[i] = CreateFrame("StatusBar", nil, Bar)
		Bar[i]:Height(8)
		Bar[i]:SetStatusBarTexture(C.Medias.Normal)
		
		if i == 1 then
			Bar[i]:Width((250 / 4) - 2)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width((250 / 4) - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end
		
		Bar[i].bg = Bar[i]:CreateTexture(nil, 'ARTWORK')
	end
	
	Bar:SetScript("OnShow", function(self) 
		TukuiUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	Bar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	self.WarlockSpecBars = Bar		
end