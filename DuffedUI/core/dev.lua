local D, C, L = unpack(select(2, ...))

--[[local frame = CreateFrame ("Frame", "MyPVPFlagTimer", UIParent)
frame:SetPoint("CENTER")
frame:SetWidth(47)
frame:SetHeight(17)
frame:SetAlpha(0.8)
frame:Hide()

frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame:SetUserPlaced(true)
frame:EnableMouse(true)
frame:RegisterForDrag("RightButton")
frame:SetScript("OnDragStart", function(self, button)
	if button == "RightButton" then
		self:StartMoving()
	end
end)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetScript("OnHide", frame.StopMovingOrSizing)

frame:SetBackdrop({
	bgFile = "Interface\\Buttons\\WHITE8x8", tile = true, tileSize = 0,
	edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 5,
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
frame:SetBackdropColor(0,0,0,1)
frame:SetBackdropBorderColor(0,0,0,0.8)

local text = frame:CreateFontString(nil, "OVERLAY")
text:SetPoint("CENTER", 2, 0)
text:SetFont(C["media"]["font"], 11, "THINOUTLINE") -- Change "MyAddon" to the name of your addon's folder, and move the font file.
do
	local _, class = UnitClass("player")
	local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
	text:SetTextColor(color.r, color.g, color.b)
end

local UPDATE_INTERVAL, updateTime = 1, 1

local function OnUpdate(self, elapsed)
	updateTime = updateTime - elapsed
	if updateTime < 0 then
		local t = floor(GetPVPTimer() / 1000)
		if t > 60 then
			text:SetFormattedText("%d:%d", floor(t / 60), t % 60)
		else
			text:SetText(t)
		end
		updateTime = UPDATE_INTERVAL
	end
end

frame:RegisterUnitEvent("UNIT_FACTION", "player")
frame:SetScript("OnEvent", function(self, event, unit)
	if UnitIsPVPFreeForAll("player") or UnitIsPVP("player") then
		local t = GetPVPTimer()
		if t > 0 and t < 301000 then
			updateTime = UPDATE_INTERVAL
			self:SetScript("OnUpdate", OnUpdate)
		else
			self:SetScript("OnUpdate", nil)
			text:SetText("PVP")
		end
		self:Show()
	else
		self:Hide()
	end
end)]]