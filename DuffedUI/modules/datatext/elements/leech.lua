local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format

local Update = function(self)
	local Value = GetCombatRating(17)
	local Leech = "Leech" -- Temp!

	self.Text:SetText(format("%s: %s", DataText.NameColor .. Leech .. "|r", DataText.ValueColor .. D.Comma(Value) .. "|r"))
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

DataText:Register("Leech", Enable, Disable, Update)