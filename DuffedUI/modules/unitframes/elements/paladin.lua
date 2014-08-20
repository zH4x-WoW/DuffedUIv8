local D, C, L = unpack(select(2, ...))
if D.Class ~= "PALADIN" then return end

local texture = C["media"].normTex
local font, fontheight, fontflag = C["media"].font, 12, "THINOUTLINE"
local layout = C["unitframes"].layout

D.ConstructEnergy("Mana", 216, 5)

D.ConstructRessources = function(name, width, height)
	local bars = CreateFrame("Frame", name, UIParent)
	bars:Point("BOTTOM", CBAnchor, "TOP", 0, -5)
	bars:Size(width, height)
	bars:SetBackdrop(backdrop)
	bars:SetBackdropColor(0, 0, 0)
	bars:SetBackdropBorderColor(0, 0, 0, 0)

	for i = 1, 5 do
		bars[i]=CreateFrame("StatusBar", name .. "_HolyPower" .. i, bars)
		bars[i]:Height(height)
		bars[i]:SetStatusBarTexture(texture)
		bars[i]:GetStatusBarTexture():SetHorizTile(false)
		bars[i]:SetStatusBarColor(228/255, 225/255, 16/255)
		bars[i].bg = bars[i]:CreateTexture(nil, "BORDER")
		bars[i].bg:SetTexture(228/255, 225/255, 16/255)
		if i == 1 then
			bars[i]:SetPoint("LEFT", bars)
			bars[i]:Width((width / 5) - 3)
			bars[i].bg:SetAllPoints(bars[i])
		else
			bars[i]:Point("LEFT", bars[i-1], "RIGHT", 1, 0)
			bars[i]:Width(width / 5)
			bars[i].bg:SetAllPoints(bars[i])
		end
		bars[i].bg:SetTexture(texture)
		bars[i].bg:SetAlpha(.15)
	end
	bars:CreateBackdrop()
end