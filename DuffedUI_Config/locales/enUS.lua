local Locale = GetLocale()
if (Locale ~= "enUS") then return end

-- Some options aren't CPU friendly, like smooth bars and animations, let the users know.
local Performance = "\n|cffFF0000Disabling this may increase performance|r"
local PerformanceSlight = "\n|cffFF0000Disabling this may slightly increase performance|r"
local RestoreDefault = "\n|cffFFFF00Right-click to restore to default|r" -- For color pickers, Not yet implemented

DuffedUIConfig["enUS"] = {
	["general"] = {
		["AutoScale"] = { --
			["Name"] = "Auto Scale",
			["Desc"] = "Automatically detect the best scale for your resolution",
		},
		["UIScale"] = { --
			["Name"] = "UI Scale",
			["Desc"] = "Set a custom UI scale",
		},
		["BackdropColor"] = { --
			["Name"] = "Backdrop Color",
			["Desc"] = "Set the backdrop color for all DuffedUI frames"..RestoreDefault,
		},
		["BorderColor"] = { --
			["Name"] = "Border Color",
			["Desc"] = "Set the border color for all DuffedUI frames"..RestoreDefault,
		},
		["InOut"] = { --
			["Name"] = "Border Style",
			["Desc"] = "Use the standard border on DuffedUI frames, or 1 pixel style",
		},
		["HideShadow"] = { 
			["Name"] = "Hide Shadows",
			["Desc"] = "Display or hide shadows on certain DuffedUI frames",
		},
		["Use24Hour"] = { --
			["Name"] = "Time Format",
			["Desc"] = "Switch between 24-Hour- and 12-Hour-Format",
		},
		["UseLocalTime"] = { --
			["Name"] = "Local Time",
			["Desc"] = "Switch between local and server time",
		},
		["ClassColor"] = {
			["Name"] = "Enable ClassColor",
			["Desc"] = "Enable classcolor for text elements"
		},
	},
	
	["fonts"] = {
		["Buttons"] = {
			["Name"] = "Set fontsize for buttons",
			["Desc"] = "needs description",
		},
	},
	
	["actionbars"] = {
		["Enable"] = {
			["Name"] = "Enable action bars",
			["Desc"] = "Derp",
		},
		["HotKey"] = {
			["Name"] = "Hotkeys",
			["Desc"] = "Display Hotkey text on buttons",
		},
		["Macro"] = {
			["Name"] = "Macro keys",
			["Desc"] = "DIsplay macro text on buttons",
		},
		["ShapeShift"] = {
			["Name"] = "ShapeShift",
			["Desc"] = "Enable DuffedUI style ShapeShift bar",
		},
		["NormalButtonSize"] = {
			["Name"] = "Button Size",
			["Desc"] = "Set a size for action bar buttons",
		},
		["PetButtonSize"] = {
			["Name"] = "Pet Button Size",
			["Desc"] = "Set a size for pet action bar buttons",
		},
		["ButtonSpacing"] = {
			["Name"] = "Button Spacing",
			["Desc"] = "Set the spacing between action bar buttons",
		},
		["OwnShadowDanceBar"] = {
			["Name"] = "Shadow Dance bar",
			["Desc"] = "Use a special bar while in Shadow Dance",
		},
		["OwnMetamorphosisBar"] = {
			["Name"] = "Metamorphosis Bar",
			["Desc"] = "Use a special bar while in Metamorphosis",
		},
		["OwnWarriorStanceBar"] = {
			["Name"] = "Warrior Stance Bar",
			["Desc"] = "Use a special bar while in Warrior stances",
		},
		["HideBackdrop"] = {
			["Name"] = "Hide Backdrop",
			["Desc"] = "Disable the backdrop on action bars",
		},
		["RightbarsMouseover"] = {
			["Name"] = "Mouseover for Rightbar",
			["Desc"] = "needs description",
		},
		["PetbarAlwaysVisible"] = {
			["Name"] = "Petbar Visibility",
			["Desc"] = "needs description",
		},
		["Rightbutton"] = {
			["Name"] = "Mouseover for Right Button",
			["Desc"] = "needs description",
		},
		["HideRightBar"] = {
			["Name"] = "Rightbar Visibility",
			["Desc"] = "needs description",
		},
		["BorderHighlight"] = {
			["Name"] = "Enable Prochighlight",
			["Desc"] = "Enables a small border instead of the Blizzard ProcHighlight"
		},
		["Font"] = {
			["Name"] = "Actionbar font",
			["Desc"] = "Set a font for the actionbar",
		},
	},
	
	["auras"] = {
		["Enable"] = {
			["Name"] = "Enable Auras",
			["Desc"] = "Derp",
		},
		["Consolidate"] = {
			["Name"] = "Consolidate Auras",
			["Desc"] = "Enable consolidated auras",
		},
		["Flash"] = {
			["Name"] = "Flash Auras",
			["Desc"] = "Flash auras when their duration is low"..PerformanceSlight,
		},
		["ClassicTimer"] = {
			["Name"] = "Classic Timer",
			["Desc"] = "Use the text timer beneath auras",
		},
		["HideBuffs"] = {
			["Name"] = "Hide Buffs",
			["Desc"] = "Disable buff display",
		},
		["HideDebuffs"] = {
			["Name"] = "Hide Debuffs",
			["Desc"] = "Disable debuff display",
		},
		["Animation"] = {
			["Name"] = "Animation",
			["Desc"] = "Show a 'pop in' animation on auras"..PerformanceSlight,
		},
		["BuffNotice"] = {
			["Name"] = "BuffNotice",
			["Desc"] = "needs description",
		},
		["Warning"] = {
			["Name"] = "Warning Sound",
			["Desc"] = "needs description",
		},
		["BuffTracker"] = {
			["Name"] = "BuffTracker",
			["Desc"] = "needs description",
		},
		["Font"] = {
			["Name"] = "Aura font",
			["Desc"] = "Set a font for auras",
		},
	},
	
	["bags"] = {
		["Enable"] = {
			["Name"] = "Enable Bags",
			["Desc"] = "Derp",
		},
		["ButtonSize"] = {
			["Name"] = "Slot Size",
			["Desc"] = "Set a size for bag slots",
		},
		["Spacing"] = {
			["Name"] = "Spacing",
			["Desc"] = "Set the spacing between bag slots",
		},
		["ItemsPerRow"] = {
			["Name"] = "Items Per Row",
			["Desc"] = "Set how many slots are on each row of the bags",
		},
		["Scale"] = {
			["Name"] = "Scale",
			["Desc"] = "Set a scale for the bags",
		},
		["Moveable"] = {
			["Name"] = "Moving Bags",
			["Desc"] = "needs description",
		},
		["Font"] = {
			["Name"] = "Bag font",
			["Desc"] = "Set a font for bags",
		},
		["BagFilter"] = {
			["Name"] = "Enable Bag filter",
			["Desc"] = "Automatically deletes useless items from your bags when looted",
			["Default"] = "Automatically deletes useless items from your bags when looted",
		},
	},
	
	["chat"] = {
		["Enable"] = {
			["Name"] = "Enable Chat",
			["Desc"] = "Derp",
		},
		["WhisperSound"] = {
			["Name"] = "Whisper Sound",
			["Desc"] = "Play a sound when receiving a whisper",
		},
		["LinkColor"] = {
			["Name"] = "Link Color",
			["Desc"] = "Set a color to display links in"..RestoreDefault,
		},
		["LinkBrackets"] = {
			["Name"] = "Link Brackets",
			["Desc"] = "Display links wrapped in brackets",
		},
		["lBackground"] = {
			["Name"] = "Left Chatbackground",
			["Desc"] = "needs description",
		},
		["rBackground"] = {
			["Name"] = "Right Chatbackground",
			["Desc"] = "needs description",
		},
		["Fade"] = {
			["Name"] = "Chat Fading",
			["Desc"] = "needs description",
		},
		["JustifyLoot"] = {
			["Name"] = "Text justify",
			["Desc"] = "needs description",
		},
		["TabFont"] = {
			["Name"] = "Chat Tab Font",
			["Desc"] = "Set a font to be used by chat tabs",
		},
	},
	
	["cooldowns"] = {
		["Enable"] = {
			["Name"] = "Enable Cooldowns",
			["Desc"] = "Derp",
		},
		["Notification"] = {
			["Name"] = "Notification",
			["Desc"] = "Display cooldown time in red below 8 seconds.",
		},
	},
	
	["datatexts"] = {
		["Battleground"] = {
			["Name"] = "Enable Battleground",
			["Desc"] = "Enable data texts displaying battleground information",
		},

		["LocalTime"] = {
			["Name"] = "Local Time",
			["Desc"] = "Use local time in the Time data text, rather than realm time",
		},

		["NameColor"] = {
			["Name"] = "Label Color",
			["Desc"] = "Set a color for the label of a data text, usually the name"..RestoreDefault,
		},

		["ValueColor"] = {
			["Name"] = "Value Color",
			["Desc"] = "Set a color for the value of a data text, usually a number"..RestoreDefault,
 		},
		["Font"] = {
			["Name"] = "Data Text Font",
			["Desc"] = "Set a font to be used by the data texts",
		},
 	},
	
	["merchant"] = {
		["AutoSellGrays"] = {
			["Name"] = "Auto Sell Grays",
			["Desc"] = "When visiting a vendor, automatically sell gray quality items",
		},
		["SellMisc"] = {
			["Name"] = "Sell Misc. Items",
			["Desc"] = "Automatically sells useless items that are not gray quality",
		},
		["AutoRepair"] = {
			["Name"] = "Auto Repair",
			["Desc"] = "When visiting a repair merchant, automatically repair our gear",
		},
		["UseGuildRepair"] = {
			["Name"] = "Use Guild Repair",
			["Desc"] = "When using 'Auto Repair', use funds from the Guild bank",
		},
	},
	
	["misc"] = {
		["ThreatBarEnable"] = {
			["Name"] = "Enable Threat Bar",
			["Desc"] = "Derp",
		},
		["AltPowerBarEnable"] = {
			["Name"] = "Enable Alt-Power Bar",
			["Desc"] = "Derp",
		},
		["FlightPoint"] = {
			["Name"] = "Flight Point List",
			["Desc"] = "needs description",
		},
		["CombatAnimation"] = {
			["Name"] = "Combat Animation",
			["Desc"] = "needs description",
		},
		["ErrorFilter"] = {
			["Name"] = "Enable ErrorFilter",
			["Desc"] = "Disable the red error message on the top of the screen",
		},
		["AutoInvite"] = {
			["Name"] = "Enables AutoInvite",
			["Desc"] = "Allows to accept invites automatically from guild, friendslist and BattleNet-Friends",
		},
	},
	
	["nameplates"] = {
		["Enable"] = {
			["Name"] = "Enable NamePlates",
			["Desc"] = "Derp"..PerformanceSlight,
		},
		["Width"] = {
			["Name"] = "Set Width",
			["Desc"] = "Set the width of NamePlates",
		},
		["Height"] = {
			["Name"] = "Set Height",
			["Desc"] = "Set the height of NamePlates",
		},
		["CastHeight"] = {
			["Name"] = "Cast Bar Height",
			["Desc"] = "Set the height of the cast bar on NamePlates",
		},
		["Spacing"] = {
			["Name"] = "Spacing",
			["Desc"] = "Set the spacing between NamePlates and cast bar",
		},
		["NontargetAlpha"] = {
			["Name"] = "Non-Target Alpha",
			["Desc"] = "The alpha of NamePlates that we're not targetting",
		},
		["Texture"] = {
			["Name"] = "NamePlates Texture",
			["Desc"] = "Set a texture for nameplates",
		},
	},
	
	["party"] = {
		["Enable"] = {
			["Name"] = "Enable Party Frames",
			["Desc"] = "Derp",
		},
		["Portrait"] = {
			["Name"] = "Portrait",
			["Desc"] = "Display portrait on party frames",
		},
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		["BuffsEnable"] = {
			["Name"] = "Enable Buffs",
			["Desc"] = "needs description",
		},
		["Font"] = {
			["Name"] = "Party Frame Font",
			["Desc"] = "Set a font for the party frame",
		},
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
	},
	
	["raid"] = {
		["Enable"] = { --
			["Name"] = "Enable Raid Frames",
			["Desc"] = "Derp",
		},
		["HealBar"] = { --
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		["RaidPets"] = { --
			["Name"] = "Enable Raid Pets",
			["Desc"] = "needs description",
		},
		["AuraWatch"] = { --
			["Name"] = "Aura Watch",
			["Desc"] = "Display timers for class specific buffs in the corners of the raid frames",
		},
		["GridVertical"] = { --
			["Name"] = "Gridalignment",
			["Desc"] = "needs description",
		},
		["DebuffWatch"] = { --
			["Name"] = "Debuff Watch",
			["Desc"] = "Display a big icon on the raid frames when a player has an important debuff",
		},
		["ColumnSpacing"] = { --
			["Name"] = "Spacing between columns",
			["Desc"] = "needs description",
		},
		["FrameWidth"] = { --
			["Name"] = "Framewidth",
			["Desc"] = "needs description",
		},
		["FrameHeight"] = { --
			["Name"] = "Frameheight",
			["Desc"] = "needs description",
		},
		["GridScale"] = { --
			["Name"] = "Scaling of Grid",
			["Desc"] = "needs description",
		},
		["Aggro"] = { --
			["Name"] = "Aggrodisplay",
			["Desc"] = "needs description",
		},
		["ShowSymbols"] = { --
			["Name"] = "Enable Raidsymbols",
			["Desc"] = "needs description",
		},
		["Font"] = {
			["Name"] = "Raid Frame Font",
			["Desc"] = "Set a font for the raid frame",
		},
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
		["RangeAlpha"] = {
			["Name"] = "Out Of Range Alpha",
			["Desc"] = "Set the transparency of units that are out of range",
		},
	},
	
	["tooltips"] = {
		["Enable"] = {
			["Name"] = "Enable Tooltips",
			["Desc"] = "Derp",
		},
		["HideOnUnitFrames"] = {
			["Name"] = "Hide on Unit Frames",
			["Desc"] = "Don't display Tooltips on unit frames",
		},
		["UnitHealthText"] = {
			["Name"] = "Display health text",
			["Desc"] = "Display health text on the tooltip health bar",
		},
		["EnableCaster"] = {
			["Name"] = "Display Caster",
			["Desc"] = "needs description",
		},
		["ItemLevel"] = {
			["Name"] = "Display Itemlevel",
			["Desc"] = "needs description",
		},
		["ID"] = {
			["Name"] = "Enable Spell-ID",
			["Desc"] = "needs description",
		},
	},
	
	["unitframes"] = {
		["Enable"] = {
			["Name"] = "Enable Unit Frames",
			["Desc"] = "Derp",
		},
		["Smooth"] = {
			["Name"] = "Smooth Bars",
			["Desc"] = "Smooth out the updating of the health bars"..Performance,
		},
		["CombatLog"] = {
			["Name"] = "Combat Feedback",
			["Desc"] = "Display incoming heals and damage on the player unit frame",
		},
		["WeakBar"] = {
			["Name"] = "Weakened Soul Bar",
			["Desc"] = "Display a bar to show the Weakened Soul debuff",
		},
		["HealBar"] = {
			["Name"] = "HealComm",
			["Desc"] = "Display a bar showing incoming heals & absorbs",
		},
		["TotemBar"] = {
			["Name"] = "Totem Bar",
			["Desc"] = "Create a tukui style totem bar",
		},
		["OnlySelfDebuffs"] = {
			["Name"] = "Display My Debuffs Only",
			["Desc"] = "Only display our debuffs on the target frame",
		},
		["UniColor"] = {
			["Name"] = "Enable UniColor-Theme",
			["Desc"] = "needs description",
		},
		["HealthBarColor"] = {
			["Name"] = "Color of Healthbar",
			["Desc"] = "needs description",
		},
		["HealthBGColor"] = {
			["Name"] = "Color of Healthbarbackground",
			["Desc"] = "needs description",
		},
		["CharPortrait"] = {
			["Name"] = "Characterportrait",
			["Desc"] = "needs description",
		},
		["Layout"] = {
			["Name"] = "Choose UF-Layout",
			["Desc"] = "needs description",
		},
		["Percent"] = {
			["Name"] = "Percentdisplay",
			["Desc"] = "needs description",
		},
		["ShowTotalHP"] = {
			["Name"] = "Show total HP",
			["Desc"] = "needs description",
		},
		["ColorGradient"] = {
			["Name"] = "Enable ColorGradient",
			["Desc"] = "needs description",
		},
		["Font"] = {
			["Name"] = "Unit Frame Font",
			["Desc"] = "Set a font for unit frames",
		},
		["PowerTexture"] = {
			["Name"] = "Power Bar Texture",
			["Desc"] = "Set a texture for power bars",
		},
		["HealthTexture"] = {
			["Name"] = "Health Bar Texture",
			["Desc"] = "Set a texture for health bars",
		},
	},
	
	["castbar"] = {
		["CastBar"] = {
			["Name"] = "Cast Bar",
			["Desc"] = "Enable cast bar for unit frames",
		},
		["CastBarIcon"] = {
			["Name"] = "Cast Bar Icon",
			["Desc"] = "Create an icon beside the cast bar",
		},
		["CastBarLatency"] = {
			["Name"] = "Cast Bar Latency",
			["Desc"] = "Display your latency on the cast bar",
		},
	},
	
	["talent"] = {
		["Click2Cast"] = {
			["Name"] = "Enable Click2Cast",
			["Desc"] = "needs description",
		},
		["Click2Cast_Filter"] = {
			["Name"] = "Enable Click2Cast Filter",
			["Desc"] = "needs description",
		},
		["SESEnable"] = {
			["Name"] = "Enable SpecSwitcher",
			["Desc"] = "needs description",
		},
		["SESEnableGear"] = {
			["Name"] = "Enable SpecSwitcher Gear",
			["Desc"] = "needs description",
		},
		["SESGearSwap"] = {
			["Name"] = "Enable SpecSwitcher Gearswap",
			["Desc"] = "needs description",
		},
		["SESSet1"] = {
			["Name"] = "Set SpecSwitcher Set 1",
			["Desc"] = "needs description",
		},
		["SESSet2"] = {
			["Name"] = "Set SpecSwitcher Set 2",
			["Desc"] = "needs description",
		},
		["RCDEnable"] = {
			["Name"] = "Enable RaidCooldowns",
			["Desc"] = "needs description",
		},
		["RCDRaid"] = {
			["Name"] = "RaidCooldowns Raids",
			["Desc"] = "needs description",
		},
		["RCDParty"] = {
			["Name"] = "RaidCooldowns Party",
			["Desc"] = "needs description",
		},
		["RCDArena"] = {
			["Name"] = "RaidCooldowns Arena",
			["Desc"] = "needs description",
		},
	},
	
	["classtimer"] = {
		["Enable"] = {
			["Name"] = "Enable ClassTimer",
			["Desc"] = "needs description",
		},
		["TargetDebuffs"] = {
			["Name"] = "Enable TargetDebuffs",
			["Desc"] = "needs description",
		},
		["Height"] = {
			["Name"] = "Set Height",
			["Desc"] = "needs description",
		},
		["Spacing"] = {
			["Name"] = "Set Spacing",
			["Desc"] = "needs description",
		},
		["Spark"] = {
			["Name"] = "Enable Spark",
			["Desc"] = "needs description",
		},
		["Separator"] = {
			["Name"] = "Enable Separator",
			["Desc"] = "needs description",
		},
		["SeparatorColor"] = {
			["Name"] = "Set SeparatorColor",
			["Desc"] = "needs description",
		},
		["PlayerColor"] = {
			["Name"] = "Set PlayerColor",
			["Desc"] = "needs description",
		},
		["TargetBuffColor"] = {
			["Name"] = "Set TargetBuffColor",
			["Desc"] = "needs description",
		},
		["TargetDebuffColor"] = {
			["Name"] = "Set TargetDebuffColor",
			["Desc"] = "needs description",
		},
		["TrinketColor"] = {
			["Name"] = "Set TrinketColor",
			["Desc"] = "needs description",
		},
	},
	
	["plugins"] = {
		["ItemCooldowns"] = { --
			["Name"] = "Enable ItemCooldowns",
			["Desc"] = "needs description",
		},
		["ItemLevelCharacter"] = { --
			["Name"] = "Enable ItemLevel",
			["Desc"] = "needs description",
		},
		["VendorValue"] = { --
			["Name"] = "Enable VendorValue",
			["Desc"] = "needs description",
		},
		["FocusButton"] = { --
			["Name"] = "Enable FocusButton",
			["Desc"] = "needs description",
		},
		["ACMScreen"] = { --
			["Name"] = "Enable AchievmentScreenshot",
			["Desc"] = "needs description",
		},
		["Gold"] = {
			["Name"] = "Enable shorter Gold",
			["Desc"] = "needs description",
		},
		["AFKCamera"] = { --
			["Name"] = "Enable AFK Camera",
			["Desc"] = "needs description",
		},
		["QuestLevel"] = { --
			["Name"] = "Enable Questlevel",
			["Desc"] = "needs description",
		},
	},
	
	["duffed"] = {
		["DispelAnnouncement"] = {
			["Name"] = "Enable Dispel Announcement",
			["Desc"] = "needs description",
		},
		["DrinkAnnouncement"] = {
			["Name"] = "Enable Drink Announcement",
			["Desc"] = "needs description",
		},
		["SayInterrupt"] = {
			["Name"] = "Enable Interrupt",
			["Desc"] = "needs description",
		},
		["AnnounceChannel"] = {
			["Name"] = "Set Announce Channel",
			["Desc"] = "Values: SAY, PARTY or RAID",
		},
		["SpellAnnounce"] = {
			["Name"] = "Enable Spell Announce",
			["Desc"] = "needs description",
		},
	},
	
	["scd"] = {
		["Enable"] = {
			["Name"] = "Enable SpellCooldowns",
			["Desc"] = "Enable the SpellCooldown-Plugin",
		},
		["FSize"] = {
			["Name"] = "Set Fontsize",
			["Desc"] = "Size for timer",
		},
		["Size"] = {
			["Name"] = "Set ButtonSize",
			["Desc"] = "Size of the Cooldownbuttons (default = 28)",
		},
		["Spacing"] = {
			["Name"] = "Set Spacing",
			["Desc"] = "Spacing between buttons (default = 10)",
		},
		["Fade"] = {
			["Name"] = "Set Fading",
			["Desc"] = "Values: 0 one color, 1 green to red, 2 red to green",
		},
		["Direction"] = {
			["Name"] = "Set Direction",
			["Desc"] = "Values: HORIZONTAL or VERTICAL, default = HORIZONTAL",
		},
		["Display"] = {
			["Name"] = "Set Display",
			["Desc"] = "Values: SPIRAL or STATUSBAR, default = STATUSBAR",
		},
	},
}