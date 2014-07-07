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

local Class = {
	["DEATHKNIGHT"] = { 196/255,  30/255,  60/255 },
	["DRUID"]       = { 255/255, 125/255,  10/255 },
	["HUNTER"]      = { 171/255, 214/255, 116/255 },
	["MAGE"]        = { 104/255, 205/255, 255/255 },
	["PALADIN"]     = { 245/255, 140/255, 186/255 },
	["PRIEST"]      = { 212/255, 212/255, 212/255 },
	["ROGUE"]       = { 255/255, 243/255,  82/255 },
	["SHAMAN"]      = {  41/255,  79/255, 155/255 },
	["WARLOCK"]     = { 148/255, 130/255, 201/255 },
	["WARRIOR"]     = { 199/255, 156/255, 110/255 },
	["MONK"]        = { 0/255, 255/255, 150/255   },
}

D.Client = GetLocale() 

D.Print = function(...)
	print("|cffC41F3BDuffedUI|r:", ...)
end

local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip

local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}

local function OnHyperlinkEnter(frame, link, ...)
	local linktype = link:match("^([^:]+)")
	if linktype and linktypes[linktype] then
		GameTooltip:SetOwner(frame, "ANCHOR_TOP", 0, 32)
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	if orig1[frame] then return orig1[frame](frame, link, ...) end
end

local function OnHyperlinkLeave(frame, ...)
	GameTooltip:Hide()
	if orig2[frame] then return orig2[frame](frame, ...) end
end

function D.HyperlinkMouseover()
	local _G = getfenv(0)
	for i=1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local frame = _G["ChatFrame"..i]
			orig1[frame] = frame:GetScript("OnHyperlinkEnter")
			frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)

			orig2[frame] = frame:GetScript("OnHyperlinkLeave")
			frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
		end
	end
end
D.HyperlinkMouseover()

D.UpdateThreat = function(self, event, unit)
	if (self.unit ~= unit) or (unit == "target" or unit == "pet" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
	local threat = UnitThreatSituation(self.unit)
	if (threat == 3) then
		if self.HealthBorder then
			self.HealthBorder:SetBackdropBorderColor(.69, .31, .31, 1)
		else
			self.Name:SetTextColor(1,.1, .1)
		end
	else
		if self.HealthBorder then
			local r, g, b = unpack(C["medias"].BorderColor)
			self.HealthBorder:SetBackdropBorderColor(r * .7, g * .7, b * .7)
		else
			self.Name:SetTextColor(1, 1, 1)
		end
	end 
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

if C["general"].ClassColor then
	C["medias"].PrimaryDataTextColor = Class[select(2, UnitClass("player"))]
end
D.PanelColor = D.RGBToHex(unpack(C["medias"].PrimaryDataTextColor))

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

D.UTF = function(string, i, dots)
	if not string then return end

	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = string:byte(pos)

			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end

		if len == i and pos <= bytes then
			return string:sub(1, pos - 1) .. (dots and "..." or "")
		else
			return string
		end
	end
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