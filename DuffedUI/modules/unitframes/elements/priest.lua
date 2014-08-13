local D, C, L = unpack(select(2, ...))
if D.Class ~= "PRIEST" then return end

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}
local texture = C["media"].normTex
local layout = C["unitframes"].layout

if C["unitframes"].showstatuebar then
	local bar = CreateFrame("StatusBar", "DuffedUIStatueBar", self)
	bar:Size(5, 29)
	if (layout == 1) or (layout == 3) then
		bar:Point("LEFT", power, "RIGHT", 7, 5)
	elseif layout == 2 then
		bar:Point("LEFT", panel, "RIGHT", 7, 5)
	end
	bar:SetStatusBarTexture(texture)
	bar:SetOrientation("VERTICAL")
	bar.bg = bar:CreateTexture(nil, 'ARTWORK')
	bar.background = CreateFrame("Frame", "DuffedUIStatue", bar)
	bar.background:SetAllPoints()
	bar.background:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar.background:SetBackdrop(backdrop)
	bar.background:SetBackdropColor(0, 0, 0)
	bar.background:SetBackdropBorderColor(0,0,0)
	bar:CreateBackdrop()
	self.Statue = bar
end

if C["unitframes"].classbar then

end