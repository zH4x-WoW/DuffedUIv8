local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format

local Update = function(self)
	local Value = GetCombatRating(26)
	
	self.Text:SetText(format("%s: %s", D.PanelColor .. L.DataText.Mastery .. "|r", DataText.ValueColor .. D.Comma(Value) .. "|r" .. "|r"))
end

local Enable = function(self)	
	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register(L.DataText.Mastery, Enable, Disable, Update)