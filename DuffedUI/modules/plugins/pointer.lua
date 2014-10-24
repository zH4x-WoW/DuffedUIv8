-- Credits go to Gello

local D, C, L = unpack(select(2, ...))
if not C["raid"].pointer then return end

local slowThrottle = .10
local fastThrottle = .01

local sqrt2 = sqrt(2)
local rads45 = .25 * PI
local rads135 = .75 * PI
local rads225 = 1.25 * PI
local cos, sin = math.cos, math.sin
local function corner(r) return .5 + cos(r) / sqrt2, .5 + sin(r) / sqrt2 end

local pointer = CreateFrame("FRAME", "Pointer")
pointer.timer = 0
pointer:SetFrameStrata("FULLSCREEN")
pointer:SetAttribute("unit", "mouseover")
RegisterUnitWatch(pointer)

pointer.arrow = pointer:CreateTexture(nil, "OVERLAY")
pointer.arrow:SetSize(D.Scale(20), D.Scale(20))
pointer.arrow:SetTexture([[Interface\MiniMap\MiniMap-QuestArrow]])

local function UpdateArrow(self)
	local focus = GetMouseFocus()
	if UnitInRange("mouseover") or not focus or not focus:GetAttribute("unit") then
		self:Hide()
		pointer.timer = slowThrottle
		return
	end

	local playerX, playerY = GetPlayerMapPosition("player")
	local unitX, unitY = GetPlayerMapPosition("mouseover")

	if (playerX == 0 and playerY == 0) or (unitX == 0 and unitY == 0) or UnitIsUnit("player", "mouseover") then
		self:Hide()
		pointer.timer = slowThrottle
		return
	end

	pointer.timer = fastThrottle

	local angle = atan2(unitY - playerY, playerX - unitX) * PI / 180 + PI / 2
	if angle < 0 then angle = angle + 2 * PI end
	angle = angle - GetPlayerFacing()

	local ULx,ULy = corner(angle + rads225)
	local LLx,LLy = corner(angle + rads135)
	local URx,URy = corner(angle - rads45)
	local LRx,LRy = corner(angle + rads45)
	self:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)

	local cursorX, cursorY = GetCursorPosition()
	local offsetX = -6
	local offsetY = -7
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cursorX + offsetX, cursorY + offsetY)

	self:Show()
end

pointer:SetScript("OnUpdate", function(self, elapsed)
	self.timer = self.timer - elapsed
	if self.timer < 0 then UpdateArrow(self.arrow) end
end)

pointer:SetScript("OnShow", function(self) UpdateArrow(self.arrow) end)