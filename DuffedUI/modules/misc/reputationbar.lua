local D, C, L = select(2, ...):unpack()

if (not C["misc"].ExperienceEnable) then return end

local Miscellaneous = D["Miscellaneous"]
local MaxLevel = MAX_PLAYER_LEVEL
local Reputation = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Panels = D["Panels"]
local Bars = 20
local Colors = FACTION_BAR_COLORS

Reputation.NumBars = 2

function Reputation:SetTooltip()
	if (not GetWatchedFactionInfo()) then
		return
	end
	
	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()
	
	GameTooltip:SetOwner(Minimap, "ANCHOR_BOTTOMLEFT", -14, 0)
	
	GameTooltip:AddLine(string.format("%s (%s)", Name, _G["FACTION_STANDING_LABEL" .. ID]))
	GameTooltip:AddLine(string.format("%d / %d (%d%%)", Value - Min, Max - Min, (Value - Min) / (Max - Min) * 100))
	GameTooltip:Show()
end

function Reputation:Update()
	if (not GetWatchedFactionInfo()) then
		if self.RepBar1:IsVisible() then
			self.RepBar1:Hide()
			self.RepBar2:Hide()
		end
		
		return
	else
		if (not self.RepBar1:IsVisible()) then
			self.RepBar1:Show()
			self.RepBar2:Show()
		end
	end
	
	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()
	
	for i = 1, self.NumBars do
		self["RepBar"..i]:SetMinMaxValues(Min, Max)
		self["RepBar"..i]:SetValue(Value)
		self["RepBar"..i]:SetStatusBarColor(Colors[ID].r, Colors[ID].g, Colors[ID].b)
	end
end

function Reputation:Create()
	if (UnitLevel("player") ~= MaxLevel) then
		return
	end
	
	for i = 1, self.NumBars do
		local RepBar = CreateFrame("StatusBar", nil, UIParent)
		
		RepBar:SetStatusBarTexture(C["medias"].Normal)
		RepBar:EnableMouse()
		RepBar:CreateBackdrop()
		RepBar:SetScript("OnEnter", Reputation.SetTooltip)
		RepBar:SetScript("OnLeave", HideTooltip)
		
		RepBar:SetOrientation("Vertical")
		RepBar:Size(5, Minimap:GetHeight() + 20)
		RepBar:Point("TOPLEFT", Minimap, "TOPLEFT", -10, 0)
		
		self["RepBar"..i] = RepBar
	end
	
	if (not GetWatchedFactionInfo()) then
		self.RepBar1:Hide()
		self.RepBar2:Hide()
	end
	
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	self:SetScript("OnEvent", self.Update)
end

function Reputation:Enable()
	self:Create()
end

function Reputation:Disable()
	self:UnregisterAllEvents()
	
	for i = 1, self.NumBars do
		self["RepBar"..i]:Hide()
	end
end

Miscellaneous.Reputation = Reputation