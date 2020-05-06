local D, C, L = unpack(select(2, ...))

local format = string.format
local GetCombatRating = GetCombatRating

local DataText = D.DataTexts
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local function Update(self)
	local Value = GetCombatRating(17)

	self.Text:SetFormattedText('%s: %s', NameColor .. ITEM_MOD_CR_LIFESTEAL_SHORT .. '|r', ValueColor .. D['CommaValue'](Value) .. '|r')
end

local function Enable(self)
	self:RegisterEvent('UNIT_STATS')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', Update)
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', nil)
end

DataText:Register(ITEM_MOD_CR_LIFESTEAL_SHORT, Enable, Disable, Update)