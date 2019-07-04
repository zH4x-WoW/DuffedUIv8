-- NazjatarFollowerXP, All fame to the ElvUI team 8)

local _, ns = ...
local oUF = ns.oUF or oUF

function GetNPCID(guid)
	local id = tonumber(strmatch((guid or ""), "%-(%d-)%-%x-$"))
	return id
end

local NPCIDToWidgetIDMap = {
	[154304] = 1940, -- Farseer Ori
	[150202] = 1613, -- Hunter Akana
	[154297] = 1966, -- Bladesman Inowari
	[151300] = 1621, -- Neri Sharpfin
	[151310] = 1622, -- Poen Gillbrack
	[151309] = 1920 -- Vim Brineheart
}

local CampfireNPCIDToWidgetIDMap = {
	[149805] = 1940, -- Farseer Ori
	[149804] = 1613, -- Hunter Akana
	[149803] = 1966, -- Bladesman Inowari
	[149904] = 1621, -- Neri Sharpfin
	[149902] = 1622, -- Poen Gillbrack
	[149906] = 1920 -- Vim Brineheart
}

local function GetBodyguardXP(widgetID)
	local widget = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(widgetID)
	local rank = string.match(widget.overrideBarText, "%d+")
	local cur = widget.barValue - widget.barMin
	local next = widget.barMax - widget.barMin
	local total = widget.barValue
	return rank, cur, next, total
end

local function Update(self, ...)
	local element = self.NazjatarFollowerXP
	local npcID = GetNPCID(UnitGUID(self.unit))
	local shouldDisplay = npcID and (NPCIDToWidgetIDMap[npcID] and self.unit and UnitIsOwnerOrControllerOfUnit("player", self.unit)) or CampfireNPCIDToWidgetIDMap[npcID]
	if (not shouldDisplay) then
		element:Hide()
		if element.progressText then
			element.progressText:Hide()
		end

		return
	end

	if element.PreUpdate then
		element:PreUpdate()
	end

	local widgetID = NPCIDToWidgetIDMap[npcID] or CampfireNPCIDToWidgetIDMap[npcID]
	if not widgetID then
		element:Hide()
		if element.progressText then
			element.progressText:Hide()
		end
		return
	end

	local rank, cur, next, total = GetBodyguardXP(widgetID)
	element:SetMinMaxValues(0, next)
	element:SetValue(cur)

	if element.progressText then
		element.progressText:SetText(format("Lvl %d %d / %d", rank, cur, next))
		element.progressText:Show()
	end

	element:Show()

	if (element.PostUpdate) then
		element:PostUpdate(rank, cur, next, total)
	end
end

local function Path(self, ...)
	return (self.NazjatarFollowerXP.Override or Update)(self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
	local element = self.NazjatarFollowerXP
	if (element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		self:RegisterEvent("UPDATE_UI_WIDGET", Path, true)
		return true
	end
end

local function Disable(self)
	local element = self.NazjatarFollowerXP
	if (element) then
		element:Hide()
		if element.progressText then
			element.progressText:Hide()
		end

		self:UnregisterEvent("UPDATE_UI_WIDGET", Path)
	end
end

oUF:AddElement("NazjatarFollowerXP", Path, Enable, Disable)