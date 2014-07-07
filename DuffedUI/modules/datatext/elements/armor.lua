local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format

local Update = function(self)
	local Value = select(2, UnitArmor("player"))
	
	self.Text:SetText(format("%s: %s", D.PanelColor .. L.DataText.Armor .. "|r", DataText.ValueColor .. D.Comma(Value) .. "|r"))
end

local Enable = function(self)	
	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register(L.DataText.Armor, Enable, Disable, Update)