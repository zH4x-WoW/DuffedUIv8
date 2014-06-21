local D, C, L = select(2, ...):unpack()

----------------------------------------------------------------
-- Default settings of DuffedUI
----------------------------------------------------------------

C["general"] = {
	["AutoScale"] = true,
	["MultiSampleProtection"] = true,
	["UIScale"] = 0.71,
	["BackdropColor"] = {0.05, 0.05, 0.05},
	["BorderColor"] = {0.125, 0.125, 0.125},
	["InOut"] = true,
	["HideShadow"] = false,
}

C["fonts"] = {
	["Buttons"] = 12,
}

C["actionbars"] = {
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
	["RightbarsMouseover"] = false,
	["PetbarAlwaysVisible"] = false,
	["Rightbutton"] = true,
}

C["auras"] = {
	["Enable"] = true,
	["Consolidate"] = false,
	["Flash"] = true,
	["ClassicTimer"] = false,
	["HideBuffs"] = false,
	["HideDebuffs"] = false,
	["Animation"] = true,
}

C["bags"] = {
	["Enable"] = true,
	["ButtonSize"] = 28,
	["Spacing"] = 4,
	["ItemsPerRow"] = 11,
	["Scale"] = 1,
	["Moveable"] = false,
}

C["merchant"] = {
	["vendorlist"] = true,
	["AutoSellGrays"] = true,
	["AutoRepair"] = true,
	["SellMisc"] = true,
	["UseGuildRepair"] = true,
}

C["chat"] = {
	["Enable"] = true,
	["WhisperSound"] = true,
	["LinkColor"] = {.08, 1, .36},
	["LinkBrackets"] = true,
	["lBackground"] = true,
	["rBackground"] = true,
	["Fade"] = true,
	["JustifyLoot"] = true,
}

C["cooldowns"] = {
	["Enable"] = true,
	["Notification"] = 8,
}

C["misc"] = {
	["ThreatBarEnable"] = true,
	["AltPowerBarEnable"] = true,
}

C["nameplates"] = {
	["Enable"] = true,
	["Width"] = 120,
	["Height"] = 8,
	["CastHeight"] = 5,
	["Spacing"] = 4,
	["NontargetAlpha"] = 1,
}

C["party"] = {
	["Enable"] = true,
	["Portrait"] = true,
}

C["raid"] = {
	["Enable"] = true,
}

C["tooltips"] = {
	["Enable"] = true,
	["HideOnUnitFrames"] = false,
}

C["unitframes"] = {
	["Layout"] = 2,
	["Enable"] = true,
	["Smooth"] = true,
	["CombatLog"] = true,
	["WeakBar"] = true,
	["HealBar"] = true,
	["TotemBar"] = true,
	["OnlySelfDebuffs"] = false,
	["UniColor"] = true,
	["HealthBarColor"] = {.125, .125, .125},
	["HealthBGColor"] = {0, 0, 0},
	["CharPortrait"] = true,
}

C["castbar"] = {
	["CastBar"] = true,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
}