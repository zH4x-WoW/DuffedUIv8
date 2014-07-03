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
	["Use24Hour"] = true,
	["UseLocalTime"] = true,
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
	["HideBackdrop"] = false,
	["HideRightBar"] = false,
}

C["auras"] = {
	["Enable"] = true,
	["Consolidate"] = false,
	["Flash"] = true,
	["ClassicTimer"] = true,
	["HideBuffs"] = false,
	["HideDebuffs"] = false,
	["Animation"] = true,
	["BuffNotice"] = true,
	["Warning"] = true,
	["BuffTracker"] = true,
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
	["FlightPoint"] = true,
	["CombatAnimation"] = true,
	["Click2Cast"] = true,
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
	["BuffsEnable"] = false,
	["HealBar"] = true,
}

C["raid"] = {
	["Enable"] = true,
	["RaidPets"] = true,
	["GridVertical"] = false,
	["ColumnSpacing"] = 1,
	["FrameWidth"] = 65,
	["FrameHeight"] = 42,
	["GridScale"] = 1,
	["HealBar"] = true,
	["AuraWatch"] = true,
	["AuraWatchTimers"] = true,
	["DebuffWatch"] = true,
}

C["tooltips"] = {
	["Enable"] = true,
	["HideOnUnitFrames"] = false,
	["EnableCaster"] = true,
}

C["unitframes"] = {
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
	["Layout"] = 3,
	["Percent"] = true,
}

C["castbar"] = {
	["CastBar"] = true,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
}

C["talent"] = {
	["SESEnable"] = true,
	["SESEnableGear"] = true,
	["SESGearSwap"] = true,
	["SESSet1"] = 1,
	["SESSet2"] = 2,
}

C["classtimer"] = {
	["Enable"] = true,
	["TargetDebuffs"] = false,
	["Height"] = 15,
	["Spacing"] = 1,
	["Spark"] = true,
	["Separator"] = true,
	["SeparatorColor"] = { 0, 0, 0, .5 },
	["PlayerColor"] = {.2, .2, .2, 1 },
	["TargetBuffColor"] = { 70/255, 150/255, 70/255, 1 },
	["TargetDebuffColor"] = { 150/255, 30/255, 30/255, 1 },
	["TrinketColor"] = {75/255, 75/255, 75/255, 1 },
}