local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARRIOR") then return end

DuffedUIUnitFrames.AddClassFeatures["WARRIOR"] = function(self)
	-- Totem Bar (Demoralizing / Mocking / Skull Banner)
	local bar = CreateFrame("StatusBar", "DuffedUIStatueBar", self)
	bar:SetWidth(5)
	bar:SetHeight(28)
	bar:Point("BOTTOMLEFT", oUF_DuffedUIPlayer, "BOTTOMRIGHT", 6, -1)
	bar:SetStatusBarTexture(Texture)
	bar:SetOrientation("VERTICAL")
	bar.bg = bar:CreateTexture(nil, 'ARTWORK')
	
	bar.background = CreateFrame("Frame", "DuffedUIStatue", bar)
	bar.background:SetAllPoints()
	bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar.background:SetBackdrop(backdrop)
	bar.background:SetBackdropColor(0, 0, 0)
	bar.background:SetBackdropBorderColor(0,0,0)
	bar:CreateBackdrop()

	-- Register
	self.Statue = bar
end