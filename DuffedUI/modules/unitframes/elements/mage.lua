local D, C, L = unpack(select(2, ...))
if D.Class ~= "MAGE" then return end

local texture = C["media"].normTex
local font, fontheight, fontflag = C["media"].font, 12, "THINOUTLINE"

if not C["unitframes"].attached then
	D.ConstructEnergy("Mana", 216, 5)
end

D.ConstructRessources = function(name, name2, width, height)
	local mb = CreateFrame("Frame", name, UIParent)
	mb:Size(width, height)
	mb:SetBackdrop(backdrop)
	mb:SetBackdropColor(0, 0, 0)
	mb:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		mb[i] = CreateFrame("StatusBar", name .. i, mb)
		mb[i]:Height(height)
		mb[i]:SetStatusBarTexture(texture)
		if i == 1 then
			mb[i]:Width(width / 4)
			mb[i]:SetPoint("LEFT", mb, "LEFT", 0, 0)
		else
			mb[i]:Width((width / 4) - 1)
			mb[i]:SetPoint("LEFT", mb[i - 1], "RIGHT", 1, 0)
		end
		mb[i].bg = mb[i]:CreateTexture(nil, 'ARTWORK')
	end
	mb:CreateBackdrop()

	if C["unitframes"].runeofpower then
		local rp = CreateFrame("Frame", name2, UIParent)
		rp:Size(width, height)
		rp:SetBackdrop(backdrop)
		rp:SetBackdropColor(0, 0, 0)
		rp:SetBackdropBorderColor(0, 0, 0)
		for i = 1, 2 do
			rp[i] = CreateFrame("StatusBar", "DuffedUIRunePower"..i, rp)
			rp[i]:Height(5)
			rp[i]:SetStatusBarTexture(texture)
			if i == 1 then
				rp[i]:Width(width / 2)
				rp[i]:SetPoint("LEFT", rp, "LEFT", 0, 0)
			else
				rp[i]:Width(width / 2)
				rp[i]:SetPoint("LEFT", rp[i - 1], "RIGHT", 1, 0)
			end
			rp[i].bg = rp[i]:CreateTexture(nil, 'ARTWORK')
		end
		rp:CreateBackdrop()
	end
end