local D, C, L, G = unpack(select(2, ...))

D.UIScale = function()
	if C["general"].autoscale == true then
		C["general"].uiscale = min(2, max(0.64, 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)")))
	end
end
D.UIScale()

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
local Scale = function(x)
	return mult * math.floor(x / mult + 0.5)
end

D.Scale = function(x) return Scale(x) end
D.mult = mult
D.noscalemult = D.mult * C["general"].uiscale
D.raidscale = 1

C["datatext"].fontsize = C["datatext"].fontsize * mult