local D, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of DuffedUI
----------------------------------------------------------------

C["General"] = {
	["AutoScale"] = true,
	["MultiSampleProtection"] = true,
	["UIScale"] = 0.71,
	["BackdropColor"] = {.05, .05, .05},
	["BorderColor"] = {.125, .125, .125},
	["InOut"] = true,
}

C["ActionBars"] = {
	["Enable"] = true,
	["HotKey"] = true,
	["Macro"] = false,
	["ShapeShift"] = false,
	["NormalButtonSize"] = 27,
	["PetButtonSize"] = 25,
	["ButtonSpacing"] = 4,
	["OwnShadowDanceBar"] = false,
	["OwnMetamorphosisBar"] = true,
	["OwnWarriorStanceBar"] = false,
	["HideBackdrop"] = false,
}

C["Auras"] = {
	["Enable"] = true,
	["Consolidate"] = true,
	["Flash"] = true,
	["ClassicTimer"] = false,
	["HideBuffs"] = false,
	["HideDebuffs"] = false,
}

C["Bags"] = {
	["Enable"] = true,
	["ButtonSize"] = 28,
	["Spacing"] = 4,
	["ItemsPerRow"] = 11,
	["Scale"] = 1,
}

C["Chat"] = {
	["Enable"] = true,
	["WhisperSound"] = true,
	["LinkColor"] = {0.08, 1, 0.36},
	["LinkBrackets"] = true,
}

C["Cooldowns"] = {
	["Enable"] = true,
	["Notification"] = 8,
}

C["Tooltips"] = {
	["Enable"] = true,
	["HideOnUnitFrames"] = false,
}

C["UnitFrames"] = {
	["Enable"] = true,
	["CastBar"] = true,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
	["Smooth"] = true,
	["CombatLog"] = true,
	["WeakBar"] = true,
	["HealBar"] = true,
	["StatueBar"] = true,
	["OnlySelfDebuffs"] = false,
}