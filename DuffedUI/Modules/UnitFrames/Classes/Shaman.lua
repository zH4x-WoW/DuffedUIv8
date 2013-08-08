local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:AddShamanFeatures()
	local TotemBar = {}
	local Shadow = self.Shadow
	
	-- Totem Bar
	local TotemBar = CreateFrame("Frame", nil, self)
	TotemBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	TotemBar:Size(250, 8)
	TotemBar:SetBackdrop(TukuiUnitFrames.Backdrop)
	TotemBar:SetBackdropColor(0, 0, 0)
	TotemBar:SetBackdropBorderColor(0, 0, 0)
	TotemBar.Destroy = true

	for i = 1, 4 do
		TotemBar[i] = CreateFrame("StatusBar", nil, TotemBar)
		TotemBar[i]:Height(8)
		TotemBar[i]:SetStatusBarTexture(C.Media.Normal)

		if i == 1 then
			TotemBar[i]:Width((250 / 4) - 2)
			TotemBar[i]:Point("LEFT", TotemBar, "LEFT", 0, 0)
		else
			TotemBar[i]:Width((250 / 4 - 1))
			TotemBar[i]:Point("LEFT", TotemBar[i-1], "RIGHT", 1, 0)
		end

		TotemBar[i]:SetBackdrop(backdrop)
		TotemBar[i]:SetBackdropColor(0, 0, 0)
		TotemBar[i]:SetMinMaxValues(0, 1)

		TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
		TotemBar[i].bg:SetAllPoints(TotemBar[i])
		TotemBar[i].bg:SetTexture(C.Media.Normal)
		TotemBar[i].bg.multiplier = 0.3
	end
	
	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)
	
	TotemBar:SetScript("OnShow", function(self) 
		TukuiUnitFrames.UpdateShadow(self, "OnShow", -4, 12)
	end)

	TotemBar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, "OnHide", -4, 4)
	end)
	
	-- Register
	self.TotemBar = TotemBar
end