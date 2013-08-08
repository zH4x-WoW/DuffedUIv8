local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format
local Class = select(2, UnitClass("player"))

local Update = function(self)
	local Value, Spell
	local Base, PosBuff, NegBuff = UnitAttackPower("player")
	local Effective = Base + PosBuff + NegBuff
	local RangedBase, RangedPosBuff, RangedNegBuff = UnitRangedAttackPower("player")
	local RangedEffective = RangedBase + RangedPosBuff + RangedNegBuff

	HealPower = GetSpellBonusHealing()
	SpellPower = GetSpellBonusDamage(7)
	AttackPower = Effective

	if (HealPower > SpellPower) then
		Spell = HealPower
	else
		Spell = SpellPower
	end

	if (AttackPower > Spell and Class ~= "HUNTER") then
		Value = AttackPower
	elseif (Class == "HUNTER") then
		Value = RangedEffective
	else
		Value = Spell
	end
	
	self.Text:SetText(format(DataText.ValueColor .. D.Comma(Value) .. "|r")) -- "%s: %s", 
end

local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end

	self:RegisterEvent("UNIT_AURA")
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

DataText:Register(L.DataText.Power, Enable, Disable, Update)