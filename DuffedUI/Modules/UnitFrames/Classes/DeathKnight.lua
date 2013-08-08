local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

function DuffedUIUnitFrames:AddDeathKnightFeatures()
	local RunesBar = CreateFrame("Frame", nil, self)
	local StatueBar = self.Statue
	local Shadow = self.Shadow

	-- Runes
	RunesBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	RunesBar:Size(250, 8)
	RunesBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	RunesBar:SetBackdropColor(0, 0, 0)
	RunesBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		RunesBar[i] = CreateFrame("StatusBar", nil, RunesBar)
		RunesBar[i]:Height(8)
		RunesBar[i]:SetStatusBarTexture(C.Media.Normal)

		if i == 1 then
			RunesBar[i]:Width(40)
			RunesBar[i]:Point("LEFT", RunesBar, "LEFT", 0, 0)
		else
			RunesBar[i]:Width(41)
			RunesBar[i]:Point("LEFT", RunesBar[i-1], "RIGHT", 1, 0)
		end
	end

	RunesBar:SetScript("OnShow", function(self) 
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	RunesBar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Statue Bar New Position
	StatueBar:ClearAllPoints()
	StatueBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 10)
	
	-- Update Shadow Effect
	Shadow:Point("TOPLEFT", -4, 12)
	
	StatueBar:SetScript("OnShow", function(self) 
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 22)
	end)

	StatueBar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 12)
	end)
	
	-- Register
	self.Runes = RunesBar
end