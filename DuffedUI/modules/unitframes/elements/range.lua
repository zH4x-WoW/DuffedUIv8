local D = unpack(select(2, ...))
local Module = D:NewModule("Range")
local SpellRange = LibStub("SpellRange-1.0")

local _G = _G
local pairs, ipairs = pairs, ipairs

local CheckInteractDistance = _G.CheckInteractDistance
local UnitCanAttack = _G.UnitCanAttack
local UnitInParty = _G.UnitInParty
local UnitInPhase = _G.UnitInPhase
local UnitInRaid = _G.UnitInRaid
local UnitInRange = _G.UnitInRange
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsWarModePhased = _G.UnitIsWarModePhased
local UnitIsUnit = _G.UnitIsUnit

local SpellRangeTable = {}

function Module:CreateRangeIndicator()
		local Range = {
		insideAlpha = 1,
		outsideAlpha = 0.35
	}
	Range.Override = Module.UpdateRange

	SpellRangeTable[D['Class']] = SpellRangeTable[D['Class']] or {}

	return Range
end

local function AddTable(tbl)
	SpellRangeTable[D['Class']][tbl] = {}
end

local function AddSpell(tbl, spellID)
	SpellRangeTable[D['Class']][tbl][#SpellRangeTable[D['Class']][tbl] + 1] = spellID
end

function Module:UpdateRangeCheckSpells()
	for tbl, spells in pairs(D.spellRangeCheck[D['Class']]) do
		AddTable(tbl) --Create the table holding spells, even if it ends up being an empty table
		for spellID in pairs(spells) do
			local enabled = spells[spellID]
			if enabled then --We will allow value to be false to disable this spell from being used
				AddSpell(tbl, spellID, enabled)
			end
		end
	end
end

local function getUnit(unit)
	if not unit:find("party") or not unit:find("raid") then
		for i=1, 4 do
			if UnitIsUnit(unit, "party"..i) then
				return "party"..i
			end
		end

		for i=1, 40 do
			if UnitIsUnit(unit, "raid"..i) then
				return "raid"..i
			end
		end
	else
		return unit
	end
end

local function friendlyIsInRange(unit)
	if (not UnitIsUnit(unit, "player")) and (UnitInParty(unit) or UnitInRaid(unit)) then
		unit = getUnit(unit) -- swap the unit with `raid#` or `party#` when its NOT `player`, UnitIsUnit is true, and its not using `raid#` or `party#` already
	end

	if UnitIsWarModePhased(unit) or not UnitInPhase(unit) then
		return false -- is not in same phase
	end

	local inRange, checkedRange = UnitInRange(unit)
	if checkedRange and not inRange then
		return false -- blizz checked and said the unit is out of range
	end

	if CheckInteractDistance(unit, 1) then
		return true -- within 28 yards (arg2 as 1 is Compare Achievements distance)
	end

	if SpellRangeTable[D['Class']] then
		if SpellRangeTable[D['Class']].resSpells and UnitIsDeadOrGhost(unit) and (#SpellRangeTable[D['Class']].resSpells > 0) then -- dead with rez spells
			for _, spellID in ipairs(SpellRangeTable[D['Class']].resSpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true -- within rez range
				end
			end

			return false -- dead but no spells are in range
		end

		if SpellRangeTable[D['Class']].friendlySpells and (#SpellRangeTable[D['Class']].friendlySpells > 0) then -- you have some healy spell
			for _, spellID in ipairs(SpellRangeTable[D['Class']].friendlySpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true -- within healy spell range
				end
			end
		end
	end

	return false -- not within 28 yards and no spells in range
end

local function petIsInRange(unit)
	if CheckInteractDistance(unit, 2) then
		return true -- within 8 yards (arg2 as 2 is Trade distance)
	end

	if SpellRangeTable[D['Class']] then
		if SpellRangeTable[D['Class']].friendlySpells and (#SpellRangeTable[D['Class']].friendlySpells > 0) then -- you have some healy spell
			for _, spellID in ipairs(SpellRangeTable[D['Class']].friendlySpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true
				end
			end
		end

		if SpellRangeTable[D['Class']].petSpells and (#SpellRangeTable[D['Class']].petSpells > 0) then -- you have some pet spell
			for _, spellID in ipairs(SpellRangeTable[D['Class']].petSpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true
				end
			end
		end
	end

	return false -- not within 8 yards and no spells in range
end

local function enemyIsInRange(unit)
	if CheckInteractDistance(unit, 2) then
		return true -- within 8 yards (arg2 as 2 is Trade distance)
	end

	if SpellRangeTable[D['Class']] then
		if SpellRangeTable[D['Class']].enemySpells and (#SpellRangeTable[D['Class']].enemySpells > 0) then -- you have some damage spell
			for _, spellID in ipairs(SpellRangeTable[D['Class']].enemySpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true
				end
			end
		end
	end

	return false -- not within 8 yards and no spells in range
end

local function enemyIsInLongRange(unit)
	if SpellRangeTable[D['Class']] then
		if SpellRangeTable[D['Class']].longEnemySpells and (#SpellRangeTable[D['Class']].longEnemySpells > 0) then -- you have some 30+ range damage spell
			for _, spellID in ipairs(SpellRangeTable[D['Class']].longEnemySpells) do
				if SpellRange.IsSpellInRange(spellID, unit) == 1 then
					return true
				end
			end
		end
	end

	return false
end

function Module:UpdateRange()
	local range = self.Range
	if not range then return end

	local unit = self.unit

	if self.forceInRange or unit == "player" then
		self:SetAlpha(range.insideAlpha)
	elseif self.forceNotInRange then
		self:SetAlpha(range.outsideAlpha)
	elseif unit then
		if UnitCanAttack("player", unit) then
			if enemyIsInRange(unit) then
				self:SetAlpha(range.insideAlpha)
			elseif enemyIsInLongRange(unit) then
				self:SetAlpha(range.insideAlpha)
			else
				self:SetAlpha(range.outsideAlpha)
			end
		elseif UnitIsUnit(unit, "pet") then
			if petIsInRange(unit) then
				self:SetAlpha(range.insideAlpha)
			else
				self:SetAlpha(range.outsideAlpha)
			end
		else
			if UnitIsConnected(unit) and friendlyIsInRange(unit) then
				self:SetAlpha(range.insideAlpha)
			else
				self:SetAlpha(range.outsideAlpha)
			end
		end
	else
		self:SetAlpha(range.insideAlpha)
	end
end