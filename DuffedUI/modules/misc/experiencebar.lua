local D, C, L = select(2, ...):unpack()

if (not C["misc"].ExperienceEnable) then return end

local Miscellaneous = D["Miscellaneous"]
local MaxLevel = MAX_PLAYER_LEVEL
local Experience = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Panels = D["Panels"]
local Bars = 20

Experience.NumBars = 2
Experience.XPColor = {75/255, 175/255, 76/255}
Experience.RestedColor = {0/255, 144/255, 255/255}

function Experience:SetTooltip()
	local Current, Max = Experience:GetExperience()
	local Rested = GetXPExhaustion()
	
	GameTooltip:SetOwner(Minimap, "ANCHOR_BOTTOMLEFT", -14, 0)
	
	GameTooltip:AddLine(string.format("|cff4BAF4C"..XP..": %d / %d (%d%% - %d/%d)|r", Current, Max, Current / Max * 100, Bars - (Bars * (Max - Current) / Max), Bars))
	
	if Rested then
		GameTooltip:AddLine(string.format("|cff0090FF"..TUTORIAL_TITLE26..": +%d (%d%%)|r", Rested, Rested / Max * 100))
	end
	
	GameTooltip:Show()
end

function Experience:GetExperience()
	return UnitXP("player"), UnitXPMax("player")
end

function Experience:Update(event, owner)
	if (UnitLevel("player") == MaxLevel) then
		self:Disable()
		return
	end
	
	local Current, Max = self:GetExperience()
	local Rested = GetXPExhaustion()
	
	for i = 1, self.NumBars do
		self["XPBar"..i]:SetMinMaxValues(0, Max)
		self["XPBar"..i]:SetValue(Current)
		
		if Rested then
			self["RestedBar"..i]:SetMinMaxValues(0, Max)
			self["RestedBar"..i]:SetValue(Rested + Current)
		end
	end
end

function Experience:Create()
	if (UnitLevel("player") == MaxLevel) then
		return
	end
	
	for i = 1, self.NumBars do
		local XPBar = CreateFrame("StatusBar", nil, UIParent)
		local RestedBar = CreateFrame("StatusBar", nil, UIParent)
		
		XPBar:SetStatusBarTexture(C["medias"].Normal)
		XPBar:SetStatusBarColor(unpack(self.XPColor))
		XPBar:EnableMouse()
		XPBar:CreateBackdrop()
		XPBar:SetScript("OnEnter", Experience.SetTooltip)
		XPBar:SetScript("OnLeave", HideTooltip)
		
		RestedBar:SetStatusBarTexture(C["medias"].Normal)
		RestedBar:SetStatusBarColor(unpack(self.RestedColor))
		RestedBar:SetAllPoints(XPBar)
		RestedBar:SetOrientation("Vertical")
		RestedBar:SetFrameLevel(XPBar:GetFrameLevel() - 1)
		RestedBar:SetAlpha(.5)
		
		XPBar:SetOrientation("Vertical")
		XPBar:Size(5, Minimap:GetHeight() + 20)
		XPBar:Point("TOPLEFT", Minimap, "TOPLEFT", -10, 0)
		
		self["XPBar"..i] = XPBar
		self["RestedBar"..i] = RestedBar
	end
	
	self:RegisterEvent("PLAYER_XP_UPDATE")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("UPDATE_EXHAUSTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	self:SetScript("OnEvent", self.Update)
end

function Experience:Enable()
	self:Create()
end

function Experience:Disable()
	self:UnregisterAllEvents()
	
	for i = 1, self.NumBars do
		self["XPBar"..i]:Hide()
		self["RestedBar"..i]:Hide()
	end
end

Miscellaneous.Experience = Experience