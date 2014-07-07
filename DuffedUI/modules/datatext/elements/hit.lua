local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format
local Class = select(2, UnitClass("player"))

local Update = function(self)
	local Base, PosBuff, NegBuff = UnitAttackPower("player")
	local AttackPower = Base + PosBuff + NegBuff
	local SpellPower = GetSpellBonusDamage(7)
	local SpellMod = GetSpellHitModifier() or 0
	local Mod = GetHitModifier() or 0
	local Value
	
	if (AttackPower > SpellPower and Class ~= "HUNTER") then
		Value = GetCombatRatingBonus(6) + Mod
	elseif (Class == "HUNTER") then
		Value = GetCombatRatingBonus(7) + Mod
	else
		Value = GetCombatRatingBonus(8) + SpellMod
	end

	self.Text:SetText(format("%s: %s%.2f%%%s", D.PanelColor .. L.DataText.Hit .. "|r", DataText.ValueColor, Value, "|r"))
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

DataText:Register(L.DataText.Hit, Enable, Disable, Update)