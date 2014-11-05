local D, C, L = unpack(select(2, ...))

if D.Client == "ptBR" then
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
		["welcome"] = "Hello |cffc41f3b".. D.MyName.."!|r".."\n".."Thank you for using |cffc41f3bDuffedUI "..D.Version.."|r. For detailed Information visit |cffc41f3bhttp://www.duffed.net|r.",
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

	L["faq"] = {
		["button01"] = "General",
		["button02"] = "Action Bars",
		["button03"] = "Unit Frames",
		["button04"] = "DuffedUI Chat",
		["button05"] = "UI Commands",
		["button06"] = "Keybindings",
		["button07"] = "Minimap",
		["button08"] = "Bags",
		["button09"] = "Addons & Skins",
		["button10"] = "Bugreports",
		["button11"] = "UI Update",

		["generaltitle"] = "|cffc41f3bDuffedUI - F.A.Q.|r",
		["generaltext1"] = "Hello |cffc41f3b".. D.MyName.."|r. Thank you that you have chose |cffc41f3bDuffedUI "..D.Version.."|r.\n\nUse the menu on the left to learn more about the individual points about it.\n\nEnjoy the game and good loot!",
		["generaltext2"] = "",

		["content1title"] = "|cffc41f3bGeneral|r",
		["content1text1"] = "Duffed UI is a newly designed Blizzard UI. Nothing more, nothing less. All functions can also be found in StandardUI, one has also include DuffedUI. In addition DuffedUI brings some automatic functions that are missing in the StandardUI. (For example, the bag sorting, selling gray goods, etc.).",
		["content1text2"] = "DuffedUI was designed to achieve the best possible gaming experience, no matter what their playing style, class and taste. DuffedUI is individually easily adaptable for everyone. This is also the reason why DuffedUI one of the most popular UIs in the history of World of Warcraft ™ is. In addition, it was designed so that you can immediately get started with a few mouse clicks, without having to even download any other AddOns. Since 2010, many players have due DuffedUI, created their own, based on DuffedUI interface.",

		["content2title"] = "|cffc41f3bActionbars|r",
		["content2text1"] = "The configuration of the action bars is not only  dead easy, it also leaves almost nothing to be desired.\nia the DuffedUI configuration menu that you either open by ESC -> DuffedUI, or via chat command /dc or /duffedui, you will reach tab action bars.\n\nThere, you now have the option of many mischief with the bars to propel. For one, you can 'mouseover' for the right bar and / or activate the petbar, or do you choose for it to be the right vertical bar 'Show, or or or ...\nJust work through the settings and imagine the bars according to your own preference.",
		["content2text2"] = "Furthermore you have the possibility the middle two bars, as well as the pet- and right actionbar, align your ideas.\nUsed for this purpose either the chat command /moveui, or click in the right chat area on the small '+' and then then the appearing 'M'.\n\nAnother special feature are the two bars blocks represent the left and right chat window.\nThese two blocks are not movable!\nHowever, you have the option to either activate the 'mouseover' option in the configuration menu, or by clicking on the small plus sign at the right and left edge Chat, hide the bars across session.",

		["content3title"] = "|cffc41f3bUnitframes|r",
		["content3text1"] = "The unitframes form the core of DuffedUi and can be configured individually, and place your ideas.\nPrefabricated there are three different layouts that you can select via the DuffedUI configuration menu.\nEach of the three layouts can be adapted according to your wishes further.\n\nOpen the DuffedUI configuration menu. Either by ESC -> DuffedUI, or by direct chat input with /dc or /duffedui.\nNow choose the left tab 'Unit Frames' and work your way through the right unfangreiche range of choices.",
		["content3text2"] = "Furthermore you have the possibility to move all unit-strength according to your wishes. Used for this purpose either the chat command /moveui, or click in the right chat area on the small '+' and then on the aufploppende 'M'.",

		["content4title"] = "|cffc41f3bDuffedUI Chat|r",
		["content4text1"] = "There is not much to say to the chat. It is the normal Blizzard chat used and the UI customized in appearance.\nThe loot window is decoupled and firmly anchored in the right chat.\n\nAs with the BlizzardUI You can change the font size by right-clicking on a chat tab (eg, G, S, W).\n\nTo access the emotes, click on the little 'E' at the upper right edge of the left chat frame.\n\nFurthermore, you can the contents of the left and / or right-Chat copy by clicking on the relevant 'small' leaf symbol. The copy function uses you as usual using CTRL + C to copy and paste, the chat messages by pressing CTRL + V.",
		["content4text2"] = "",

		["content5title"] = "|cffc41f3bUI Slashcommands|r",
		["content5text1"] = "The following chat commands are available to you:\n\n|cffc41f3b/install|r or |cffc41f3b/reset|r (Reinstalling)\n|cffc41f3b/rc|r (Readycheck)\n|cffc41f3b/moveui|r (Move the UI elements)\n|cffc41f3b/dc|r or |cffc41f3b/duffedui|r (DuffedUI Configuration)\n|cffc41f3b/rl|r (Reloads the UI)\n|cffc41f3b/dfaq|r (DuffedUI FAQ, You read it just ;))",
		["content5text2"] = "",

		["content6title"] = "|cffc41f3bKeybinding|r",
		["content6text1"] = "To fill the action bars with life, you DuffedUI is in a very easy-to-use help available -> DuffedUI Bind.\nTo enable the setting of the keys, enter either /kb  at chat, or click in the right chat area on the small '+' and then on the aufploppende 'K'. A popup window will appear and you know out that now all Tastatuebelegungen be saved. So go ahead!",
		["content6text2"] = "Point your mouse over the button on the action bar, you want to assign a shortcut and then press your desired combination.\nExample: mouse standing on one action bar, button 1 -> push the button one on the numeric keypad and then you can test your ability with the trigger button one on the Numblock.\n\nWhen you have assigned all buttons with your request combinations, click the popup window 'Apply. Ready!\nVery easy, right?\n\nTip: Also a combination of CTRL and / or ALT + any key is possible.",	

		["content7title"] = "|cffc41f3bMinimap|r",
		["content7text1"] = "The DuffedUi minimap uses the same structure as the standard minimap of Blizzard, but can do more. Query Point your mouse over the minimap to your location, as well as your current location coordinates.\n\nAdditional functions:\nA click with the left mouse button triggers the 'Ping' function.\nA click with the right mouse button opens the Trackingmenü.\nA click with the mouse wheel opens the micro menu.",
		["content7text2"] = "On the right side of the minimap you can find the Raid Buff Overview. Here you can read that all necessary Buffs were cast on you, or what is still missing. To let you display a detailed overview of the Buffs, click the little green '+' under the Raid Buff Overview.",

		["content8title"] = "|cffc41f3bBags|r",
		["content8text1"] = "The bags you are managing easily via the DuffedUI configuration menu. Press the ESC key -> DuffedUI, or open the menu via chat input with |cffc41f3b/dc|r or |cffc41f3b/duffedui|r. About the tab 'bags' in the left pane, you will receive a variety of configuration options for your bags.\n\nTip: Right-clicking on the little 'X' at the top of the bag, you can replace your bag. The button 'Clean' sort your bags. This tip also works with the bank.",
		["content8text2"] = "",

		["content9title"] = "|cffc41f3bAddons & Skins|r",
		["content9text1"] = "The big question is, work with foreign Addon DuffedUI ?!\nYes, of course, but the real question should be, you still need foreign addons?\nDuffedUI delivers all the important functions in one go on your monitor. Check carefully whether you need a third-party addon and INSTALLING it, true to the motto -> Trial & Error.\n\nProvides with all important functions?\nNo, Bossmods as DBM or BigWigs you should also install. Furthermore, you should a damage indicator a la Recount or Skada install. If you evaluate fights like. Everything else is as already written -> A matter of taste.\n\nBut the addons have not then the brilliant appearance of DuffedUI!\nMany addons are supported from home. The extra download, you can find in the forum. The name of the addon is aptly -> Addon Skins.",
		["content9text2"] = "",

		["content10title"] = "|cffc41f3bOMG Errors|r",
		["content10text1"] = "If you get a Lua error unexpectedly and with full force, it would be glad if you report it to us and we can fix it.\nIf you want to report him, but please with all details!\nRemember: No one goes to a garage with his car and only says: Is Busted!",
		["content10text2"] = "How do I report a bug properly:\n- Get a precaution a screenshot (press the 'print')\n- Copy the error message by CTRL + C to clipboard\n- Describe exactly what you did and when the error occurred\n- Add us the copied error message in your report and, if necessary, the screenshot made​​.\n\nWhere do I report a bug?\n- Go to the website of DuffedUI -> http://www.duffed.net\n- Click top right of tickets and create a ticket with all the information.\n\nThanks in advance!",

		["content11title"] = "|cffc41f3bUpdating UI|r",
		["content11text1"] = "Normally, you will be informed via ingame function of new updates.\nYou will see a message a la 'Your version of DuffedUI is outdated ...'.\nThen check out http://www.duffed.net us on the website and download the latest version.",
		["content11text2"] = "Normally about it is a copy of the files from the zip sufficient.\nEnter after updating the files in the chat window '/rl' to reload DuffedUI.\n\nIf no error messages are displayed, you're done with the update and can play on. If errors occur, close the entire game and restart it afterwards.",
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