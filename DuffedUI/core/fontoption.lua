local D, C, L = unpack(select(2, ...))

--[[local FO = CreateFrame("Frame")

local standard = CreateFont("Standard")
standard:SetFont(C["media"].font, 11, "THINOUTLINE")

local alternative = CreateFont("Alternative")
alternative:SetFont(C["media"].font2, 12, "THINOUTLINE")

local pixelfont = CreateFont("Pixel")
pixelfont:SetFont(C["media"].pixelfont, 11, "MONOCHROMEOUTLINE")

local ft = {
	["DuffedUI"] = "Standard",
	["DuffedUI Alternative"] = "Alternative",
	["DuffedUI Pixel"] = "Pixel",
}

D.Font = function(font)
	if ft[font] then
		return ft[font]
	else
		return ft["DuffedUI"]
	end
end

function FO:RegisterFont(name, path)
	if not ft[name] then ft[name] = path end
end

D["FontOption"] = FO
D.Font = ft]]