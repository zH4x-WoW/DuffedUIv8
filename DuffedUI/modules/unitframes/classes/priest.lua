local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PRIEST") then
	return
end

function DuffedUIUnitFrames:AddPriestFeatures()
	local SOBar = CreateFrame("Frame", nil, self)
	local Shadow = self.Shadow
	
	-- Shadow Orbs Bar
	SOBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	SOBar:Size(250, 8)
	SOBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
	SOBar:SetBackdropColor(0, 0, 0)
	SOBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 3 do
		SOBar[i] = CreateFrame("StatusBar", nil, SOBar)
		SOBar[i]:Height(8)
		SOBar[i]:SetStatusBarTexture(C["medias"].Normal)

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
		DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	SOBar:SetScript("OnHide", function(self)
		DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Register
	self.ShadowOrbsBar = SOBar

	if (C["unitframes"].WeakBar) then
		-- Weakened Soul Bar
		local WSBar = CreateFrame("StatusBar", nil, self.Power)
		WSBar:SetAllPoints(self.Power)
		WSBar:SetStatusBarTexture(C["medias"].Normal)
		WSBar:GetStatusBarTexture():SetHorizTile(false)
		WSBar:SetBackdrop(DuffedUIUnitFrames.Backdrop)
		WSBar:SetBackdropColor(unpack(C["medias"].BackdropColor))
		WSBar:SetStatusBarColor(0.75, 0.04, 0.04)
		
		-- Register
		self.WeakenedSoul = WSBar
	end
	
	-- Totem Bar (Lightwell)
	if C["unitframes"].TotemBar then
		D["Colors"].totems[1] = { 238/255, 221/255,  130/255 }

		local TotemBar = self.Totems
		TotemBar[1]:ClearAllPoints()
		TotemBar[1]:SetAllPoints()

		for i = 2, MAX_TOTEMS do
			TotemBar[i]:Hide()
		end

		TotemBar:SetScript("OnShow", function(self)
			local y = SOBar:IsShown() and 22 or 12
			DuffedUIUnitFrames.UpdateShadow(self, "OnShow", -4, y)
		end)

		TotemBar:SetScript("OnHide", function(self)
			local y = SOBar:IsShown() and 12 or 4
			DuffedUIUnitFrames.UpdateShadow(self, "OnHide", -4, y)
		end)
	end
end