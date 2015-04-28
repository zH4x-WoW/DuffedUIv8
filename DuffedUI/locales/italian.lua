local D, C, L = unpack(select(2, ...))

if D.Client == "itIT" then
	L["move"] = {
		["tooltip"] = "Move Tooltip",
		["minimap"] = "Move Minimap",
		["watchframe"] = "Shift + Click to Move Quests",
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
		["bar3"] = "Move Bar 3",
		["bar4"] = "Move Bar 4",
		["bar5"] = "Move Bar 5",
		["bar5_1"] = "Move\nBar 5",
		["pet"] = "Move\nPet",
		["player"] = "Move Playercastbar",
		["target"] = "Move Targetcastbar",
		["classbar"] = "Move Classbar",
		["raid"] = "Move RaidUtility",
		["rcd"] = "Move RaidCD",
		["spell"] = "Move SpellCooldowns",
		["xp-bar"] = "Move XP-Bar",
	}

	L["afk"] = {
		["text1"] = "Mouseover minimap shows coords and locations.",
		["text2"] = "Middle click the minimap for micromenu.",
		["text3"] = "Right click the minimap for gatheringmenu.",
		["text4"] = "By right-clicking on a quest or achievment at the objective tracker, you can retrieve the wowhead link.",
		["text5"] = "You can type /moveui to move the frames from the Interface.",
		["text6"] = "You can type /uihelp to show a tutorial."
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
		["disableui"] = "DuffedUI doesn't work for this resolution, do you want to disable DuffedUI? (Cancel if you want to try another resolution)",
		["fix_ab"] = "There is something wrong with your action bar. Do you want to reloadui to fix it?",
	}

	L["install"] = {
		["header01"] = "Welcome",
		["header02"] = "1. Essentials",
		["header03"] = "2. Unitframes",
		["header04"] = "3. Features",
		["header05"] = "4. Things you should know!",
		["header06"] = "5. Commands",
		["header07"] = "6. Finished",
		["header08"] = "1. Essential Settings",
		["header09"] = "2. Social",
		["header10"] = "3. Frames",
		["header11"] = "4. Success!",

		["continue_skip"] = "Click 'Continue' to apply the settings, or click 'Skip' if you wish to skip this step.",
		["initline1"] = "Thank you for choosing DuffedUI!",
		["initline2"] = "You will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings.",
		["initline3"] = "You are also given the possibility to be shown a brief tutorial on some of the features of DuffedUI.",
		["initline4"] = "Press the 'Tutorial' button to be guided through this small introduction, or press 'Install' to skip this step.",

		["step1line1"] = "These steps will apply the correct CVar settings for DuffedUI.",
		["step1line2"] = "The first step applies the essential settings.",
		["step1line3"] = "This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.",

		["step2line0"] = "Another chat addon is found.  We will ignore this step.  Please press skip to continue installation.",
		["step2line1"] = "The second step applies the correct chat setup.",
		["step2line2"] = "If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step.",
		["step2line3"] = "It is normal that your chat font will appear too big upon applying these settings.  It will revert back to normal when you finish with the installation.",

		["step3line1"] = "The third and final step applies the default frame positions.",
		["step3line2"] = "This step is |cffff0000recommended|r for new users.",
		["step3line3"] = "",

		["step4line1"] = "Installation is complete.",
		["step4line2"] = "Please click the 'Finish' button to reload the UI.",
		["step4line3"] = "",
		["step4line4"] = "Enjoy DuffedUI! Visit us at www.duffed.net!",
	}

	L["tutorial"] = {
		["step1line1"] = "This quick tutorial will show you some of the features in DuffedUI.",
		["step1line2"] = "First, the essentials that you should know before you can play with this UI.",
		["step1line3"] = "This installer is partially character-specific. While some of the settings that will be applied later on are account-wide, you need to run the install script for each new character running DuffedUI. The script is auto shown on every new character you log in with DuffedUI installed for the first time.  Also, the options can be found in /DuffedUI/config/config.lua for `Power` users or by typing /duffedui in game for `Friendly` users.",
		["step1line4"] = "A power user is a user of a personal computer who has the ability to use advanced features (ex: Lua editing) which are beyond the abilities of normal users.  A friendly user is a normal user and is not necessarily capable of programming.  It's recommended for them to use our in game configuration tool (/duffedui) for settings they want changed in DuffedUI.",

		["step2line1"] = "DuffedUI includes an embedded version of oUF (oUFDuffedUI) created by Haste.  This handles all of the unitframes on the screen, the buffs and debuffs, and the class-specific elements.",
		["step2line2"] = "You can visit wowinterface.com and search for oUF for more information about this tool.",
		["step2line3"] = "To easily change the unitframes positions, just type /moveui.",

		["step3line1"] = "DuffedUI is a redesigned Blizzard UI.  Nothing less, nothing more.  Approxmently all features you see with Default UI is available thought DuffedUI.  The only features not available thought default UI are some automated features not really visible on screen, for example auto selling grays when visiting a vendor or, auto sorting bags.",
		["step3line2"] =  "Not everyone enjoys things like DPS meters, Boss mods, Threat meters, etc, we judge that it's the best thing to do. DuffedUI is made around the idea to work  for all classes, roles, specs, type of gameplay, taste of the users, etc. This why DuffedUI is one of the most popular UI at the moment. It fits everyones play style and is extremly editable. It's also designed to be a good start for everyone that want to make their own custom UI without depending on addons. Since 2010 a lot of users have started using DuffedUI as a base for their own UI. Take a look at the Edited Packages on our website!",
		["step3line3"] = "Users may want to visit our extra mods section on our website or by visiting www.wowinterface.com to install additional features or mods.",

		["step4line1"] = "To set how many bars you want, mouseover on left or right of bottom action bar background.  Do the same on the right, via top and bottom.  To copy text from the chat frame, click the button shown on mouseover in the right corner of chat frames.",
		["step4line2"] = "You can left-click through 80% of datatext to show various panels from Blizzard.  Friend and Guild Datatext have right-click features aswell.",
		["step4line3"] = "There are some dropdown menus available. Right-clicking on the [X] (Close) bag button will show a dropdown menu to show bags.  Middle-clicking thought Minimap will show the micro menu.",

		["step5line1"] = "Lastly, DuffedUI includes useful slash commands.  Below is a list.",
		["step5line2"] = "/moveui allow you to move lots of the frames anywhere on the screen. /rl reloads the UI.",
		["step5line3"] = "/tt lets you whisper your target. /rc initiates a ready check. /rd disbands a party or raid. /ainv enable auto invite by whisper to you. /ainv off to turn it off",
		["step5line4"] = "/install or /tutorial loads this installer. ",

		["step6line1"] = "The tutorial is complete. You can choose to reconsult it at any time by typing /tutorial.",
		["step6line2"] = "I suggest you have a look through config/config.lua or type /duffedui to customize the UI to your needs.",
		["step6line3"] = "You can now continue install the UI if it's not done yet or if you want to reset to default!",
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
		["ses_dfaq"] = "Open DuffedUI F.A.Q.",
		["ses_switch"] = "Switch between Raidlayouts",
		["tutorial"] = "Tutorial",
		["install"] = "Install",
		["next"] = "Next",
		["skip"] = "Skip",
		["continue"] = "Continue",
		["finish"] = "Finish",
		["close"] = "Close",
		["treasure"] = "Show Treasures",
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

	L["chat"] = {
		["instance_chat"] = "I",
		["instance_chat_leader"] = "IL",
		["guild"] = "G",
		["officer"] = "O",
		["party"] = "P",
		["party_leader"] = "P",
		["raid"] = "R",
		["raid_leader"] = "RL",
		["raid_warning"] = "RW",
		["flag_afk"] = "[AFK]",
		["flag_dnd"] = "[DND]",
		["petbattle"] = "Pet Battle",
		["defense"] = "LocalDefense",
		["recruitment"] = "GuildRecruitment",
		["lfg"] = "LookingForGroup",
	}

	L["dt"] = {
		["talents"] ="No Talents",
		["download"] = "Download: ",
		["bandwith"] = "Bandwidth: ",
		["inc"] = "Incoming:",
		["out"] = "Outgoing:",
		["home"] = "Home Latency:",
		["world"] = "World Latency:",
		["global"] = "Global Latency:",
		["noguild"] = "No Guild",
		["earned"] = "Earned:",
		["spent"] = "Spent:",
		["deficit"] = "Deficit:",
		["profit"] = "Profit:",
		["timeto"] = "Time to",
		["sp"] = "SP",
		["ap"] = "AP",
		["session"] = "Session: ",
		["character"] = "Character: ",
		["server"] = "Server: ",
		["dr"] = "Dungeon & Raids: ",
		["raid"] = "Saved Raid(s)",
		["crit"] = " Crit",
		["avoidance"] = "Avoidance Breakdown",
		["lvl"] = "lvl",
		["avd"] = "avd: ",
		["server_time"] = "Server Time: ",
		["local_time"] = "Local Time: ",
		["mitigation"] = "Mitigation By Level: ",
		["stats"] = "Stats for ",
		["dmgdone"] = "Damage Done:",
		["healdone"] = "Healing Done:",
		["basesassaulted"] = "Bases Assaulted:",
		["basesdefended"] = "Bases Defended:",
		["towersassaulted"] = "Towers Assaulted:",
		["towersdefended"] = "Towers Defended:",
		["flagscaptured"] = "Flags Captured:",
		["flagsreturned"] = "Flags Returned:",
		["graveyardsassaulted"] = "Graveyards Assaulted:",
		["graveyardsdefended"] = "Graveyards Defended:",
		["demolishersdestroyed"] = "Demolishers Destroyed:",
		["gatesdestroyed"] = "Gates Destroyed:",
		["totalmemusage"] = "Total Memory Usage:",
		["control"] = "Controlled by:",
		["cta_allunavailable"] = "Could not get Call To Arms information.",
		["cta_nodungeons"] = "No dungeons are currently offering a Call To Arms.",
		["carts_controlled"] = "Carts Controlled:",
		["victory_points"] = "Victory Points:",
		["orb_possessions"] = "Orb Possessions:",
		["goldbagsopen"] = "|cffC41F3BBags: Left Click|r",
		["goldcurrency"] = "|cffC41F3BCurrency Menu: Right Click|r",
		["goldreset"] = "|cffC41F3BReset Data: Hold Shift + Right Click|r",
		["systemleft"] = "|cffC41F3BLeft Click: Open PvE-Frame|r",
		["systemright"] = "|cffC41F3BRight Click: Clean Memoryusage|r",
	}

	L["Slots"] = {
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

	L["xpbar"] = {
		["xptitle"] = "Experience:",
		["xp"] = "XP: %s/%s (%d%%)",
		["xpremaining"] = "Remaining: %s",
		["xprested"] = "|cffb3e1ffRested: %s (%d%%)",

		["fctitle"] = "Reputation: %s",
		["standing"] = "Standing: |c",
		["fcrep"] = "Rep: %s/%s (%d%%)",
		["fcremaining"] = "Remaining: %s",

		["hated"] = "Hated",
		["hostile"] = "Hostile",
		["unfriendly"] = "Unfriendly",
		["neutral"] = "Neutral",
		["friendly"] = "Friendly",
		["honored"] = "Honored",
		["revered"] = "Revered",
		["exalted"] = "Exalted",
	}
end