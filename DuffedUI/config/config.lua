local T, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of Tukui
----------------------------------------------------------------

C["General"] = {
	["AutoScale"] = true,
	["MultiSampleProtection"] = true,
	["UIScale"] = 0.71,
	["BackdropColor"] = {0.1, 0.1, 0.1},
	["BorderColor"] = {0.6, 0.6, 0.6},
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
	["LootFrame"] = true,
}

C["Cooldowns"] = {
	["Enable"] = true,
	["Notification"] = 8,
}

C["Misc"] = {
	["ThreatBarEnable"] = true,
	["AltPowerBarEnable"] = true,
}

C["NamePlates"] = {
	["Enable"] = true,
	["Width"] = 120,
	["Height"] = 8,
	["CastHeight"] = 5,
	["Spacing"] = 4,
	["UntargetAlpha"] = 1,
}

C["Party"] = {
	["Enable"] = true,
	["Portrait"] = true,
}

C["Raid"] = {
	["Enable"] = true,
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
	["TotemBar"] = true,
	["OnlySelfDebuffs"] = false,
}