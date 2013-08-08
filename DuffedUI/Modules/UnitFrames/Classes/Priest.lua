local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddPriestFeatures()
	local SOBar = CreateFrame("Frame", nil, self)
	local Shadow = self.Shadow
	
	SOBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	SOBar:Size(250, 8)
	SOBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	SOBar:SetBackdropColor(0, 0, 0)
	SOBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 3 do
		SOBar[i] = CreateFrame("StatusBar", nil, SOBar)
		SOBar[i]:Height(8)
		SOBar[i]:SetStatusBarTexture(C.Media.Normal)

		if i == 1 then
			SOBar[i]:Width((250 / 3) - 1)
			SOBar[i]:Point("LEFT", SOBar, "LEFT", 0, 0)
		else
			SOBar[i]:Width((250 / 3))
			SOBar[i]:Point("LEFT", SOBar[i-1], "RIGHT", 1, 0)
		end
	end
	
	-- Shadow Effect Updates
	SOBar:SetScript("OnShow", function(self) 
		TukuiUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	SOBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Register
	self.ShadowOrbsBar = SOBar

	if (C.UnitFrames.WeakBar) then
		-- Weakened Soul Bar
		local WSBar = CreateFrame("StatusBar", nil, Power)
		WSBar:SetAllPoints(Power)
		WSBar:SetStatusBarTexture(C.Media.Normal)
		WSBar:GetStatusBarTexture():SetHorizTile(false)
		WSBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		WSBar:SetBackdropColor(unpack(C.Media.BackdropColor))
		WSBar:SetStatusBarColor(0.75, 0.04, 0.04)
		
		-- Register
		self.WeakenedSoul = WSBar
	end
end