local D, C, L = unpack(select(2, ...))

if D.client == "zhCN" then
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

	L["chat"] = {
		["instance_chat"] = "I,"
		["instance_chat_leader"] = "IL",
		["guild"] = "G",
		["officer"] = "O",
		["party"] = "P",
		["party_leader"] "P",
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

	L.datatext_download = "下载： "
	L.datatext_bandwidth = "带宽："
	L.datatext_inc = "接收"
	L.datatext_out = "发送"
	L.datatext_home = "本地延迟:"
	L.datatext_world = "世界延迟:"
	L.datatext_global = "全局延迟:"
	L.datatext_guild = "公会"
	L.datatext_noguild = "没有公会"
	L.datatext_bags = "背包 "
	L.datatext_friends = "好友"
	L.datatext_online = "在线："
	L.datatext_armor = "耐久度"
	L.datatext_earned = "赚取："
	L.datatext_spent = "花费："
	L.datatext_deficit = "赤字："
	L.datatext_profit = "利润："
	L.datatext_timeto = "时间至："
	L.datatext_friendlist = "好友列表："
	L.datatext_playersp = "法伤"
	L.datatext_playerap = "攻强"
	L.datatext_playerhaste = "急速"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "护甲穿透"
	L.datatext_session = "本次概况："
	L.datatext_character = "角色："
	L.datatext_server = "服务器："
	L.datatext_totalgold = "总共："
	L.gametooltip_gold_a = "考古学: "
	L.gametooltip_gold_c = "烹饪: "
	L.gametooltip_gold_jc = "珠宝: "
	L.gametooltip_gold_dr = "地城 & 团队: "
	L.currencyWeekly = "每周: "
	L.datatext_savedraid = "已保存进度的团队副本"
	L.datatext_currency = "兑换通货："
	L.datatext_fps = " 帧数 & "
	L.datatext_ms = " 延时"
	L.datatext_playercrit = " 爆击"
	L.datatext_playerheal = " 治疗"
	L.datatext_avoidancebreakdown = "伤害减免"
	L.datatext_lvl = "等级"
	L.datatext_boss = "首领"
	L.datatext_miss = "未命中"
	L.datatext_dodge = "躲闪"
	L.datatext_block = "格挡"
	L.datatext_parry = "招架"
	L.datatext_playeravd = "免伤： "
	L.datatext_servertime = "服务器时间： "
	L.datatext_localtime = "本地时间： "
	L.datatext_mitigation = "等级缓和： "
	L.datatext_healing = "治疗： "
	L.datatext_damage = "伤害： "
	L.datatext_honor = "荣誉： "
	L.datatext_killingblows = "击杀： "
	L.datatext_ttstatsfor = "状态 "
	L.datatext_ttkillingblows = "击杀："
	L.datatext_tthonorkills = "荣誉击杀"
	L.datatext_ttdeaths = "死亡："
	L.datatext_tthonorgain = "获得荣誉："
	L.datatext_ttdmgdone = "伤害输出："
	L.datatext_tthealdone = "治疗输出："
	L.datatext_basesassaulted = "突袭基地："
	L.datatext_basesdefended = "防守基地："
	L.datatext_towersassaulted = "突袭哨塔："
	L.datatext_towersdefended = "防守哨塔："
	L.datatext_flagscaptured = "夺取旗帜："
	L.datatext_flagsreturned = "交换旗帜："
	L.datatext_graveyardsassaulted = "突袭墓地："
	L.datatext_graveyardsdefended = "防守墓地："
	L.datatext_demolishersdestroyed = "摧毁投石车："
	L.datatext_gatesdestroyed = "摧毁大门："
	L.datatext_totalmemusage = "总内存占用："
	L.datatext_control = "控制方："
	L.datatext_cta_allunavailable = "无法获取战斗的召唤信息."
	L.datatext_cta_nodungeons = "目前没有可用的战斗的召唤地下城."
	L.datatext_carts_controlled = "矿车控制:"
	L.datatext_victory_points = "胜利点数:"
	L.datatext_orb_possessions = "能量宝珠点数:"

	L.Slots = {
		[1] = {1, "头部", 1000},
		[2] = {3, "肩部", 1000},
		[3] = {5, "胸部", 1000},
		[4] = {6, "腰部", 1000},
		[5] = {9, "手腕", 1000},
		[6] = {10, "手", 1000},
		[7] = {7, "腿部", 1000},
		[8] = {8, "脚", 1000},
		[9] = {16, "主手", 1000},
		[10] = {17, "副手", 1000},
		[11] = {18, "远程", 1000}
	}
end