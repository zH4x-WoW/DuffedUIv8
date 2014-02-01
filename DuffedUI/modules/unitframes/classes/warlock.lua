local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARLOCK") then
	return
end

function DuffedUIUnitFrames:AddWarlockFeatures()
	local Bar = CreateFrame("Frame", nil, self)
	
	local Shadow = self.Shadow

	-- Warlock Class Bar
	Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Bar:SetWidth(250)
	Bar:SetHeight(8)
	Bar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	
	Bar:SetBackdropBorderColor(0, 0, 0)	
	
	for i = 1, 4 do
		Bar[i] = CreateFrame("StatusBar", nil, Bar)
		Bar[i]:Height(8)
		Bar[i]:SetStatusBarTexture(C["medias"].Normal)
		
		if i == 1 then
			Bar[i]:Width((250 / 4) - 2)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width((250 / 4) - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end
		
		Bar[i].bg = Bar[i]:CreateTexture(nil, 'ARTWORK')
	end
	
	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)
	
	Bar:SetScript("OnShow", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, 12)
	end)

	Bar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, 4)
	end)
	
	-- Register
	self.WarlockSpecBars = Bar		
end