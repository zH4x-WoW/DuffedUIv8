local D, C, L = select(2, ...):unpack()

-- Hydra note: Since this file is going to be doing a lot of math/formatting, lets use locals for speed/cpu usage
-- This means no calling functions as methods :P ("string"):format(...) or ("string"):gsub(...) should be format("string", ...) and gsub("string", ...) etc.

local reverse = string.reverse
local match = string.match
local modf = math.modf
local select = select
local format = format
local floor = floor
local gsub = gsub
local ceil = ceil

D.Client = GetLocale() 

D.Print = function(...)
	print("|cffC495DDDuffedUI|r:", ...)
end

-- Create our font strings
D.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

-- Want HEX color instead of RGB?
D.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	
	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- Return short value of a number!
D.ShortValue = function(v)
	if (v >= 1e6) then
		return gsub(format("%.1fm", v / 1e6), "%.?0+([km])$", "%1")
	elseif (v >= 1e3 or v <= -1e3) then
		return gsub(format("%.1fk", v / 1e3), "%.?0+([km])$", "%1")
	else
		return v
	end
end

-- Add comma's to a number
D.Comma = function(num)
	local Left, Number, Right = match(num, "^([^%d]*%d)(%d*)(.-)$")
	
	return 	Left .. reverse(gsub(reverse(Number), "(%d%d%d)", "%1,")) .. Right
end

D.Round = function(number, decimals)
	if (not decimals) then
		decimals = 0
	end

	return format(format("%%.%df", decimals), number)
end

-- Format seconds to min/hour/day
D.FormatTime = function(s)
	local Day, Hour, Minute = 86400, 3600, 60
	
	if (s >= Day) then
		return format("%dd", ceil(s / Day))
	elseif (s >= Hour) then
		return format("%dh", ceil(s / Hour))
	elseif (s >= Minute) then
		return format("%dm", ceil(s / Minute))
	elseif (s >= Minute / 12) then
		return floor(s)
	end
	
	return format("%.1f", s)
end

-- Icon coordinates template
D.IconCoord = {0.08, 0.92, 0.08, 0.92}

-- Color Gradient
D.ColorGradient = function(a, b, ...)
	local Percent
	
	if(b == 0) then
		Percent = 0
	else
		Percent = a / b
	end

	if (Percent >= 1) then
		local R, G, B = select(select('#', ...) - 2, ...)
		
		return R, G, B
	elseif (Percent <= 0) then
		local R, G, B = ...
		
		return R, G, B
	end

	local Num = (select('#', ...) / 3)
	local Segment, RelPercent = modf(Percent * (Num - 1))
	local R1, G1, B1, R2, G2, B2 = select((Segment * 3) + 1, ...)

	return R1 + (R2 - R1) * RelPercent, G1 + (G2 - G1) * RelPercent, B1 + (B2 - B1) * RelPercent
end

local WaitTable = {}
local WaitFrame
D.Delay = function(delay, func, ...)
	if (type(delay) ~= "number" or type(func) ~= "function") then
		return false
	end
	
	if (WaitFrame == nil) then
		WaitFrame = CreateFrame("Frame", nil, UIParent)
		WaitFrame:SetScript("OnUpdate",function(self, elapse)
			local Count = #WaitTable
			local i = 1
			
			while(i<=Count) do
				local WaitRecord = tremove(WaitTable, i)
				local d = tremove(WaitRecord, 1)
				local f = tremove(WaitRecord, 1)
				local p = tremove(WaitRecord, 1)
				if (d > elapse) then
				  tinsert(WaitTable, i, {d - elapse, f, p})
				  i = i + 1
				else
				  Count = Count - 1
				  f(unpack(p))
				end
			end
		end)
	end
	
	tinsert(WaitTable, {delay,func,{...}})
	return true
end

D.CreateBtn = function(name, parent, w, h, tt_txt, txt)
	local b = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	b:Width(w)
	b:Height(h)
	b:SetTemplate("Default")

	b:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:AddLine(tt_txt, 1, 1, 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	b:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	b.text = D.SetFontString(b, C["medias"].Font, 10, "THINOUTLINE")
	b.text:SetText(txt) --D.panelcolor..
	b.text:SetPoint("CENTER", b, "CENTER", 1, 0)
	b.text:SetJustifyH("CENTER")
	
	b:SetAttribute("type1", "macro")
end

function D.SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[D.MyClass]
	self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

function D.SetOriginalBackdrop(self)
	self:SetTemplate("Default")
end