local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format

local Update = function(self)
	local Base, Combat = GetPowerRegen()
	local Value
	
	if InCombatLockdown() then
		Value = floor(Combat * 5)
	else
		Value = floor(Base * 5)
	end
	
	self.Text:SetText(format("%s: %s", DataText.NameColor .. L.DataText.Regen .. "|r", DataText.ValueColor .. D.Comma(Value) .. "|r"))
end

local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end

	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register(L.DataText.Regen, Enable, Disable, Update)