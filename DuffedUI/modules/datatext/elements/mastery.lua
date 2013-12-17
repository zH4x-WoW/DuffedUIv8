local D, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format

local Update = function(self)
	local Value = GetCombatRating(26)
	
	self.Text:SetText(format("%s: %s", DataText.NameColor .. L.DataText.Mastery .. "|r", DataText.ValueColor .. D.Comma(Value) .. "|r" .. "|r"))
end

local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end

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