local D, C, L = select(2, ...):unpack()

----------------------------------
-- Default settings of DuffedUI --
----------------------------------

C["general"] = {
	["AutoScale"] = true,
	["UIScale"] = 0.71,
	["BackdropColor"] = {0.05, 0.05, 0.05},
	["BorderColor"] = {0.125, 0.125, 0.125},
	["InOut"] = true,
	["HideShadow"] = false,
	["Use24Hour"] = true,
	["UseLocalTime"] = true,
	["ClassColor"] = true,
}

C["fonts"] = {
	["Buttons"] = 12,
}

C["actionbars"] = {
	["Enable"] = true,
	["HotKey"] = true,
	["Macro"] = false,
	["ShapeShift"] = true,
	["NormalButtonSize"] = 27,
	["PetButtonSize"] = 25,
	["ButtonSpacing"] = 4,
	["OwnShadowDanceBar"] = false,
	["OwnMetamorphosisBar"] = true,
	["OwnWarriorStanceBar"] = false,
	["HideBackdrop"] = false,
	["RightbarsMouseover"] = false,
	["PetbarAlwaysVisible"] = false,
	["Rightbutton"] = true,
	["HideRightBar"] = false,
	["BorderHighlight"] = false,
	["Font"] = "DuffedUI Outline",
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
	["Font"] = "DuffedUI Outline",
}

C["bags"] = {
	["Enable"] = true,
	["ButtonSize"] = 28,
	["Spacing"] = 4,
	["ItemsPerRow"] = 10,
	["Scale"] = 1,
	["Moveable"] = false,
	["Font"] = "DuffedUI Outline",
	["BagFilter"] = false,
}

C["merchant"] = {
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
	["Font"] = "DuffedUI Outline",
}

C["cooldowns"] = {
	["Enable"] = true,
	["Notification"] = 8,
}

C["datatexts"] = {
	["Battleground"] = true,
	["LocalTime"] = true,
	["Font"] = "DuffedUI",
}

C["misc"] = {
	["ThreatBarEnable"] = true,
	["AltPowerBarEnable"] = true,
	["FlightPoint"] = true,
	["CombatAnimation"] = true,
	["ErrorFilter"] = true,
	["AutoInvite"] = true,
	["ExperienceEnable"] = true,
	["ReputationEnable"] = true,
}

C["nameplates"] = {
	["Enable"] = true,
	["Width"] = 120,
	["Height"] = 8,
	["CastHeight"] = 5,
	["Texture"] = "Blank",
	["Font"] = "DuffedUI Nameplates",
	["ShowDebuffs"] = true,
	["Font_Debuff"] = "DuffedUI NP Debuff",
	["MaxDebuffs"] = 5,
	["ShowComboPoints"] = true,
}

C["party"] = {
	["Enable"] = true,
	["Portrait"] = true,
	["HealBar"] = true,
	["BuffsEnable"] = false,
	["Font"] = "DuffedUI Outline",
	["PowerTexture"] = "Blank",
	["HealthTexture"] = "Blank",
}

C["raid"] = {
	["Enable"] = true,
	["RaidPets"] = false,
	["GridVertical"] = false,
	["ColumnSpacing"] = -2,
	["FrameWidth"] = 66,
	["FrameHeight"] = 45,
	["GridScale"] = 1,
	["HealBar"] = true,
	["AuraWatch"] = true,
	["DebuffWatch"] = true,
	["Aggro"] = true,
	["ShowSymbols"] = true,
	["Font"] = "DuffedUI Outline",
	["PowerTexture"] = "Blank",
	["HealthTexture"] = "Blank",
	["RangeAlpha"] = 0.3,
}

C["tooltips"] = {
	["Enable"] = true,
	["HideOnUnitFrames"] = false,
	["EnableCaster"] = true,
	["ItemLevel"] = true,
	["ID"] = true,
	["PowerTexture"] = "Blank",
	["HealthTexture"] = "Blank",
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
	["ShowTotalHP"] = false,
	["ColorGradient"] = true,
	["Font"] = "DuffedUI Outline",
}

C["castbar"] = {
	["CastBar"] = true,
	["CastBarIcon"] = true,
	["CastBarLatency"] = true,
}

C["talent"] = {
	["Click2Cast"] = true,
	["Click2Cast_Filter"] = true,
	["SESEnable"] = true,
	["SESEnableGear"] = true,
	["SESGearSwap"] = true,
	["SESSet1"] = 1,
	["SESSet2"] = 2,
	["RCDEnable"] = true,
	["RCDRaid"] = true,
	["RCDParty"] = false,
	["RCDArena"] = false,
}

C["classtimer"] = {
	["Enable"] = true,
	["TargetDebuffs"] = false,
	["Height"] = 15,
	["Spacing"] = 1,
	["Spark"] = true,
	["Separator"] = true,
	["SeparatorColor"] = { 0, 0, 0, .5 },
	["PlayerColor"] = { .2, .2, .2, 1 },
	["TargetBuffColor"] = { 70/255, 150/255, 70/255, 1 },
	["TargetDebuffColor"] = { 150/255, 30/255, 30/255, 1 },
	["TrinketColor"] = { 75/255, 75/255, 75/255, 1 },
}

C["plugins"] = {
	["ItemCooldowns"] = true,
	["ItemLevelCharacter"] = true,
	["VendorValue"] = true,
	["FocusButton"] = true,
	["ACMScreen"] = true,
	["Gold"] = true,
	["AFKCamera"] = true,
	["QuestLevel"] = true,
}

C["duffed"] = {
	["DispelAnnouncement"] = false,
	["DrinkAnnouncement"] = false,
	["SayInterrupt"] = true,
	["AnnounceChannel"] = "SAY",
	["SpellAnnounce"] = true,
}

C["scd"] = {
	["Enable"] = false,
	["FSize"] = 12,
	["Size"] = 28,
	["Spacing"] = 10,
	["Fade"] = 0,
	["Direction"] = "HORIZONTAL",
	["Display"] = "STATUSBAR",
}