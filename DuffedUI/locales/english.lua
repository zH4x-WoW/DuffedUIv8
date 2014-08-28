-- localization for enUS and enGB
local D, C, L = unpack(select(2, ...))

L["move"] = {
	["tooltip"] = "Move Tooltip",
	["minimap"] = "Move Minimap",
	["watchframe"] = "Move Quests",
	["gmframe"] = "Move Ticket",
	["buffs"] = "Move Player Buffs",
	["debuffs"] = "Move Player Debuffs",
	["shapeshift"] = "Move Shapeshift/Totem",
	["achievements"] = "Move Achievements",
	["roll"] = "Move Loot Roll Frame",
	["vehicle"] = "Move Vehicle Seat",
	["extrabutton"] = "Extra Button",
	["bar1"] = "Move Bar 1",
	["bar2"] = "Move Bar 2",
	["bar5"] = "Move Bar5",
	["bar5_1"] = "Move\nBar5",
	["pet"] = "Move\nPet",
	["player"] = "Move Playercastbar",
	["target"] = "Move Targetcastbar",
	["classbar"] = "Move Classbar",
	["raid"] = "Move RaidUtility",
	["rcd"] = "Move RaidCD",
	["spell"] = "Move SpellCooldowns",
}

L["afk"] = {
	["text4"] = "Mouseover minimap shows coords and locations",
	["text4"] = "Middle click the minimap for micromenu",
	["text4"] = "Right click the minimap for gatheringmenu",
	["text4"] = "By right-clicking on a quest or achievment at the objective tracker, you can retrieve the wowhead link.",
}

L["symbol"] = {
	["clear"] = "Clear",
	["skull"] = "Skull",
	["cross"] = "Cross",
	["square"] = "Square",
	["moon"] = "Moon",
	["triangle"] = "Triangle",
	["diamond"] = "Diamond",
	["circle"] = "Circle",
	["star"] = "Star",
}

L["ui"] = {
	["outdated"] = "Your version of DuffedUI is out of date. You can download the latest version from www.duffed.net",
	["welcome"] = "Hello |cffc41f3b".. D.myname.."!|r".."\n".."Thank you for using |cffc41f3bDuffedUI "..D.version.."|r. For detailed Information visit |cffc41f3bhttp://www.duffed.net|r.",
	["disableui"] = "DuffedUI doesn't work for this resolution, do you want to disable DuffedUI? (Cancel if you want to try another resolution)",
	["fix_ab"] = "There is something wrong with your action bar. Do you want to reloadui to fix it?",
}

L["bufftracker"] = {
	["10ap"] = "+10% Attack Power",
	["10as"] = "+10% Melee & Ranged Attack Speed",
	["10sp"] = "+10% Spell Power",
	["5sh"] = "+5% Spell Haste",
	["5csc"] = "+5% Critical Strike Chance",
	["3kmr"] = "+3000 Mastery Rating",
	["5sai"] = "+5% Strength, Agility, Intellect",
	["10s"] = "+10% Stamina",
	["error"] = "ERROR",
}

L["binds"] = {
	["c2c_title"] = "Mouse Bindings",
	["combat"] = "You can't bind keys in combat",
	["saved"] = "All keybindings have been saved",
	["discard"] = "All newly set keybindings have been discarded.",
	["text"] = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbuttons keybinding.",
	["save"] = "Save bindings",
	["discardbind"] = "Discard bindings",
}

L["loot"] = {
	["tt_count"] = "Count",
	["fish"] = "Fishy Loot",
	["random"] = "Random Player",
	["self"] = "Self Loot",
	["repairmoney"] = "You don't have enough money to repair!",
	["repaircost"] = "Your items have been repaired for",
	["trash"] = "Your vendor trash has been sold and you earned",
}

L["buttons"] = {
	["ses_reload"] = "Reloads the entire UI",
	["ses_move"] = "Unlock the frames for moving",
	["ses_kb"] = "Set your keybindings",
}

L["errors"] = {
	["noerror"] = "No error yet."
}

L["uf"] = {
	["offline"] = "Offline",
	["dead"] = "|cffff0000[DEAD]|r",
	["ghost"] = "GHOST",
	["lowmana"] = "LOW MANA",
	["threat1"] = "Threat on current target:",
	["wrath"] = "Wrath",
	["starfire"] = "Starfire",
}

L["group"] = {
	["autoinv_enable"] = "Autoinvite ON: invite",
	["autoinv_enable_custom"] = "Autoinvite ON: ",
	["autoinv_disable"] = "Autoinvite OFF",
	["disband"] = "Disbanding group?",
}

L["boss"] = {
	["title"] = "World Boss(s):",
	["galleon"] = "Galleon", 
	["sha"] = "Sha of Anger", 
	["oondasta"] = "Oondasta", 
	["nalak"] = "Nalak",
	["celestials"] = "Celestials", 
	["ordos"] = "Ordos",
	["defeated"] = "Defeated", 
	["undefeated"] = "Undefeated",
}

-- chat
L.chat_INSTANCE_CHAT = "I"
L.chat_INSTANCE_CHAT_LEADER = "IL"
L.chat_BN_WHISPER_GET = "From"
L.chat_GUILD_GET = "G"
L.chat_OFFICER_GET = "O"
L.chat_PARTY_GET = "P"
L.chat_PARTY_GUIDE_GET = "P"
L.chat_PARTY_LEADER_GET = "P"
L.chat_RAID_GET = "R"
L.chat_RAID_LEADER_GET = "R"
L.chat_RAID_WARNING_GET = "W"
L.chat_WHISPER_GET = "From"
L.chat_FLAG_AFK = "[AFK]"
L.chat_FLAG_DND = "[DND]"
L.chat_FLAG_GM = "[GM]"
L.chat_ERR_FRIEND_ONLINE_SS = "is now |cff298F00online|r"
L.chat_ERR_FRIEND_OFFLINE_S = "is now |cffff0000offline|r"
L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"

L.chat_general = "General"
L.chat_trade = "Trade"
L.chat_defense = "LocalDefense"
L.chat_recrutment = "GuildRecruitment"
L.chat_lfg = "LookingForGroup"

L.datatext_notalents ="No Talents"
L.datatext_download = "Download: "
L.datatext_bandwidth = "Bandwidth: "
L.datatext_inc = "Incoming"
L.datatext_out = "Outgoing"
L.datatext_home = "Home Latency:"
L.datatext_world = "World Latency:"
L.datatext_global = "Global Latency:"
L.datatext_guild = "Guild"
L.datatext_noguild = "No Guild"
L.datatext_bags = "Bags: "
L.datatext_friends = "Friends"
L.datatext_online = "Online: "
L.datatext_armor = "Armor"
L.datatext_earned = "Earned:"
L.datatext_spent = "Spent:"
L.datatext_deficit = "Deficit:"
L.datatext_profit = "Profit:"
L.datatext_timeto = "Time to"
L.datatext_friendlist = "Friends list:"
L.datatext_playersp = "sp"
L.datatext_playerap = "ap"
L.datatext_playerhaste = "haste"
L.datatext_dps = "dps"
L.datatext_hps = "hps"
L.datatext_playerarp = "arp"
L.datatext_session = "Session: "
L.datatext_character = "Character: "
L.datatext_server = "Server: "
L.datatext_totalgold = "Total: "
L.gametooltip_gold_a = "Archaeology: "
L.gametooltip_gold_c = "Cooking: "
L.gametooltip_gold_jc = "Jewelcrafting: "
L.gametooltip_gold_dr = "Dungeon & Raids: "
L.currencyWeekly = "Weekly: "
L.datatext_savedraid = "Saved Raid(s)"
L.datatext_currency = "Currency:"
L.datatext_fps = " fps & "
L.datatext_ms = " ms"
L.datatext_playercrit = " crit"
L.datatext_playerheal = " heal"
L.datatext_avoidancebreakdown = "Avoidance Breakdown"
L.datatext_lvl = "lvl"
L.datatext_boss = "Boss"
L.datatext_miss = "Miss"
L.datatext_dodge = "Dodge"
L.datatext_block = "Block"
L.datatext_parry = "Parry"
L.datatext_playeravd = "avd: "
L.datatext_servertime = "Server Time: "
L.datatext_localtime = "Local Time: "
L.datatext_mitigation = "Mitigation By Level: "
L.datatext_healing = "Healing: "
L.datatext_damage = "Damage: "
L.datatext_honor = "Honor: "
L.datatext_killingblows = "Killing Blows: "
L.datatext_ttstatsfor = "Stats for "
L.datatext_ttkillingblows = "Killing Blows:"
L.datatext_tthonorkills = "Honorable Kills:"
L.datatext_ttdeaths = "Deaths:"
L.datatext_tthonorgain = "Honor Gained:"
L.datatext_ttdmgdone = "Damage Done:"
L.datatext_tthealdone = "Healing Done:"
L.datatext_basesassaulted = "Bases Assaulted:"
L.datatext_basesdefended = "Bases Defended:"
L.datatext_towersassaulted = "Towers Assaulted:"
L.datatext_towersdefended = "Towers Defended:"
L.datatext_flagscaptured = "Flags Captured:"
L.datatext_flagsreturned = "Flags Returned:"
L.datatext_graveyardsassaulted = "Graveyards Assaulted:"
L.datatext_graveyardsdefended = "Graveyards Defended:"
L.datatext_demolishersdestroyed = "Demolishers Destroyed:"
L.datatext_gatesdestroyed = "Gates Destroyed:"
L.datatext_totalmemusage = "Total Memory Usage:"
L.datatext_control = "Controlled by:"
L.datatext_cta_allunavailable = "Could not get Call To Arms information."
L.datatext_cta_nodungeons = "No dungeons are currently offering a Call To Arms."
L.datatext_carts_controlled = "Carts Controlled:"
L.datatext_victory_points = "Victory Points:"
L.datatext_orb_possessions = "Orb Possessions:"

L.Slots = {
	[1] = {1, "Head", 1000},
	[2] = {3, "Shoulder", 1000},
	[3] = {5, "Chest", 1000},
	[4] = {6, "Waist", 1000},
	[5] = {9, "Wrist", 1000},
	[6] = {10, "Hands", 1000},
	[7] = {7, "Legs", 1000},
	[8] = {8, "Feet", 1000},
	[9] = {16, "Main Hand", 1000},
	[10] = {17, "Off Hand", 1000},
	[11] = {18, "Ranged", 1000}
}

-------------------------------------------------
-- INSTALLATION
-------------------------------------------------

-- headers
L.install_header_1 = "Welcome"
L.install_header_2 = "1. Essentials"
L.install_header_3 = "2. Unitframes"
L.install_header_4 = "3. Features"
L.install_header_5 = "4. Things you should know!"
L.install_header_6 = "5. Commands"
L.install_header_7 = "6. Finished"
L.install_header_8 = "1. Essential Settings"
L.install_header_9 = "2. Social"
L.install_header_10= "3. Frames"
L.install_header_11= "4. Success!"

-- install
L.install_init_line_1 = "Thank you for choosing DuffedUI!"
L.install_init_line_2 = "You will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings."
L.install_init_line_3 = "You are also given the possibility to be shown a brief tutorial on some of the features of DuffedUI."
L.install_init_line_4 = "Press the 'Tutorial' button to be guided through this small introduction, or press 'Install' to skip this step."

-- tutorial 1
L.tutorial_step_1_line_1 = "This quick tutorial will show you some of the features in DuffedUI."
L.tutorial_step_1_line_2 = "First, the essentials that you should know before you can play with this UI."
L.tutorial_step_1_line_3 = "This installer is partially character-specific. While some of the settings that will be applied later on are account-wide, you need to run the install script for each new character running DuffedUI.  The script is auto shown on every new character you log in with DuffedUI installed for the first time.  Also, the options can be found in /DuffedUI/config/config.lua for `Power` users or by typing /tukui in game for `Friendly` users."
L.tutorial_step_1_line_4 = "A power user is a user of a personal computer who has the ability to use advanced features (ex: Lua editing) which are beyond the abilities of normal users.  A friendly user is a normal user and is not necessarily capable of programming.  It's recommended for them to use our in game configuration tool (/tukui) for settings they want changed in DuffedUI."

-- tutorial 2
L.tutorial_step_2_line_1 = "DuffedUI includes an embedded version of oUF (oUFDuffedUI) created by Haste.  This handles all of the unitframes on the screen, the buffs and debuffs, and the class-specific elements."
L.tutorial_step_2_line_2 = "You can visit wowinterface.com and search for oUF for more information about this tool."
L.tutorial_step_2_line_3 = "To easily change the unitframes positions, just type /moveui."
L.tutorial_step_2_line_4 = ""

-- tutorial 3
L.tutorial_step_3_line_1 = "DuffedUI is a redesigned Blizzard UI.  Nothing less, nothing more.  Approxmently all features you see with Default UI is available thought DuffedUI.  The only features not available thought default UI are some automated features not really visible on screen, for example auto selling grays when visiting a vendor or, auto sorting bags."
L.tutorial_step_3_line_2 =  "Not everyone enjoys things like DPS meters, Boss mods, Threat meters, etc, we judge that it's the best thing to do. DuffedUI is made around the idea to work  for all classes, roles, specs, type of gameplay, taste of the users, etc. This why DuffedUI is one of the most popular UI at the moment. It fits everyones play style and is extremly editable. It's also designed to be a good start for everyone that want to make their own custom UI without depending on addons. Since 2009 a lot of users have started using DuffedUI as a base for their own UI. Take a look at the Edited Packages on our website!"
L.tutorial_step_3_line_3 = "Users may want to visit our extra mods section on our website or by visiting www.wowinterface.com to install additional features or mods."
L.tutorial_step_3_line_4 = ""

-- tutorial 4
L.tutorial_step_4_line_1 = "To set how many bars you want, mouseover on left or right of bottom action bar background.  Do the same on the right, via top and bottom.  To copy text from the chat frame, click the button shown on mouseover in the right corner of chat frames."
L.tutorial_step_4_line_2 = "You can left-click through 80% of datatext to show various panels from Blizzard.  Friend and Guild Datatext have right-click features aswell."
L.tutorial_step_4_line_3 = "There are some dropdown menus available. Right-clicking on the [X] (Close) bag button will show a dropdown menu to show bags, sort items, show keyring, etc.  Middle-clicking thought Minimap will show the micro menu."
L.tutorial_step_4_line_4 = ""

-- tutorial 5
L.tutorial_step_5_line_1 = "Lastly, DuffedUI includes useful slash commands.  Below is a list."
L.tutorial_step_5_line_2 = "/moveui allow you to move lots of the frames anywhere on the screen.  /enable and /disable are used to quickly enable and disable addons.  /rl reloads the UI."
L.tutorial_step_5_line_3 = "/tt lets you whisper your target.  /rc initiates a ready check.  /rd disbands a party or raid.  /bags display some features available thought command line.  /ainv enable auto invite by whisper to you.  (/ainv off) to turn it off"
L.tutorial_step_5_line_4 = "/gm toggles the Help frame.  /install or /tutorial loads this installer. "

-- tutorial 6
L.tutorial_step_6_line_1 = "The tutorial is complete.  You can choose to reconsult it at any time by typing /tutorial."
L.tutorial_step_6_line_2 = "I suggest you have a look through config/config.lua or type /duffedui to customize the UI to your needs."
L.tutorial_step_6_line_3 = "You can now continue install the UI if it's not done yet or if you want to reset to default!"
L.tutorial_step_6_line_4 = ""

-- install step 1
L.install_step_1_line_1 = "These steps will apply the correct CVar settings for DuffedUI."
L.install_step_1_line_2 = "The first step applies the essential settings."
L.install_step_1_line_3 = "This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings."
L.install_step_1_line_4 = "Click 'Continue' to apply the settings, or click 'Skip' if you wish to skip this step."

-- install step 2
L.install_step_2_line_0 = "Another chat addon is found.  We will ignore this step.  Please press skip to continue installation."
L.install_step_2_line_1 = "The second step applies the correct chat setup."
L.install_step_2_line_2 = "If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step."
L.install_step_2_line_3 = "It is normal that your chat font will appear too big upon applying these settings.  It will revert back to normal when you finish with the installation."
L.install_step_2_line_4 = "Click 'Continue' to apply the settings, or click 'Skip' if you wish to skip this step."

-- install step 3
L.install_step_3_line_1 = "The third and final step applies the default frame positions."
L.install_step_3_line_2 = "This step is |cffff0000recommended|r for new users."
L.install_step_3_line_3 = ""
L.install_step_3_line_4 = "Click 'Continue' to apply the settings, or click 'Skip' if you wish to skip this step."

-- install step 4
L.install_step_4_line_1 = "Installation is complete."
L.install_step_4_line_2 = "Please click the 'Finish' button to reload the UI."
L.install_step_4_line_3 = ""
L.install_step_4_line_4 = "Enjoy DuffedUI! Visit us at www.duffed.net!"

-- buttons
L.install_button_tutorial = "Tutorial"
L.install_button_install = "Install"
L.install_button_next = "Next"
L.install_button_skip = "Skip"
L.install_button_continue = "Continue"
L.install_button_finish = "Finish"
L.install_button_close = "Close"