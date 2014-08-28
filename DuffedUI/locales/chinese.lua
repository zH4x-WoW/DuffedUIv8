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

	-- localization for zhCN  by 风吹那啥凉（Popptise @DuffedUI forums)	
	L.chat_INSTANCE_CHAT = "I"
	L.chat_INSTANCE_CHAT_LEADER = "IL"
	L.chat_BN_WHISPER_GET = "密语"
	L.chat_GUILD_GET = "公"
	L.chat_OFFICER_GET = "官"
	L.chat_PARTY_GET = "队"
	L.chat_PARTY_GUIDE_GET = "地下城向导"
	L.chat_PARTY_LEADER_GET = "队长"
	L.chat_RAID_GET = "团"
	L.chat_RAID_LEADER_GET = "团长"
	L.chat_RAID_WARNING_GET = "团队警告"
	L.chat_WHISPER_GET = "密语"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff05e9FF上线了|r"  
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000下线了|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"
	
	-- 请不要缩写下列频道名称 这是用来帮助设置归类频道的
	L.chat_general = "综合"
	L.chat_trade = "交易"
	L.chat_defense = "本地防务"
	L.chat_recrutment = "公会招募"
	L.chat_lfg = "寻求组队"

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

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "欢迎"
	L.install_header_2 = "1. 要点"
	L.install_header_3 = "2. 单位框架"
	L.install_header_4 = "3. 特性"
	L.install_header_5 = "4. 您应该知道的东西"
	L.install_header_6 = "5. 命令"
	L.install_header_7 = "6. 完成"
	L.install_header_8 = "1. 必要的设定"
	L.install_header_9 = "2. 社交"
	L.install_header_10= "3. 框架"
	L.install_header_11= "4. 成功！"

	-- install
	L.install_init_line_1 = "感谢您选择DuffedUI。"
	L.install_init_line_2 = "几个小步骤将引导你安装DuffedUI. 在每一步中， 你可以选择应用或者跳过当前的设定。"
	L.install_init_line_3 = "你也可以选择查看我们提供给您的关于DuffedUI一些特性的小提示。"
	L.install_init_line_4 = "按下教程按键开始查看教程，或者点击安装跳过这一步。"

	-- tutorial 1
	L.tutorial_step_1_line_1 = "这个快速的小教程将给您展示一些DuffedUI的特性。"
	L.tutorial_step_1_line_2 = "首先，将告知你一些使用DuffedUI前该知道的要点。"
	L.tutorial_step_1_line_3 = "安装程序是按照每个角色来设定的。当然一些设定将在整个帐号下适用，您必须要为每一个使用DuffedUI的角色运行一遍安装程序。程序将在您每个角色第一次运行DuffedUI时自动显示。 当然, 高阶用户可以在 /DuffedUI/config/config.lua 中发现这些选项， 新手在游戏中输入/duffedui 也可以找到。"
	L.tutorial_step_1_line_4 = "高阶用户是指相比于普通的用户他们有能力使用一些新的特新(比如编辑LUA脚本)。新手是指没有编程能力的用户。那么我们建议他们使用游戏内设置面板来设定DuffedUI至他们想要的样式。"

	-- tutorial 2
	L.tutorial_step_2_line_1 = "DuffedUI包含了一个由Haste编写的oUF的内建版本. 由它来构建整个屏幕上的各种单位框体，玩家的BUFF/DEBUFF和职业特定的BUFF/DEBUFF."
	L.tutorial_step_2_line_2 = "你可以在Wowinterface上搜索oUF来获取更多关于这个工具的信息。"
	L.tutorial_step_2_line_3 = "如果你是一个治疗者或者团队领袖，那么你可能需要启用治疗框体。 它显示了更多的raid信息(/heal)。DPS和坦克需要一个相对简单的团队框架(/dps)。如果你不想使用它们中的任何一个，你可以在人物选择界面中的插件列表里禁用它们。"
	L.tutorial_step_2_line_4 = "你只需要输入/moveui,，既可以简单的移动单位框架。"

	-- tutorial 3
	L.tutorial_step_3_line_1 = "DuffedUI是一个重新设计过的暴雪用户界面。不多不少，大概所有的原始特性你都可以在DuffedUI中体验到。 有些仅有的原始界面不能实现的功能在屏幕中是看不到的， 比如说当你访问商人的时候自动售卖灰色的物品，又或者自动整理背包内的物品。"
	L.tutorial_step_3_line_2 = "因为并不是所有人都喜欢诸如：伤害统计, 首领模块, 仇恨统计, 等等这些模块, 但我们认为这是非常好的事. DuffedUI是为不同职业，不同口味，不同爱好，不同天赋等等最大化的玩家群体所编写的。 这就是为什么DuffedUI是当前最火的UI。 它满足了每一个人的游戏体验并且完全可供编辑。 它也被设计于为那些想要打造自己特性的UI的初学者们提供了一个很好的开端而无需专注于插件本身的构造。 从2009年开始，许多用户使用DuffedUI作为基本架构来制作他们自己的插件。 你可以到我们的网站上看看那些DuffedUI改版！"
	L.tutorial_step_3_line_3 = "用户们可以到我们官方网站的DuffedUI配套插件区或者访问 www.wowinterface.com 来获取安装更多有额外特性的插件。"
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "想要设置动作条的数目, 移动鼠标至左/右动作条的底部背景框架。可以使用相同的方法设定右边的动作条，点击顶部或底部。 想要从聊天框内复制文字， 鼠标点击在聊天框右上角出现的小按钮即可。"
	L.tutorial_step_4_line_2 = "小地图的边框可以改变颜色。绿色的时候说明你有未读邮件，红色表明你有新的行事历邀请 ，橙色表明你两者都有。"
	L.tutorial_step_4_line_3 = "你可以点击80%的信息栏来打开更多的BLZ面板。 好友和公会信息也具有右键特性。"
	L.tutorial_step_4_line_4 = "这里有一些下拉菜单可以使用。 右键[X] (关闭) 背包按钮 将会显示下拉菜单比如：显示背包，整理背包，显示钥匙扣等等。 鼠标中间点击小地图将会显示宏命令按钮。"

	-- tutorial 5
	L.tutorial_step_5_line_1 = "最后，DuffedUI有一些实用的命令，下面是列表"
	L.tutorial_step_5_line_2 = "/moveui 允许你移动屏幕上的大多数框体至任何地方。 /enable 和 /disable 被用于快速开启或关闭大多数插件。 /rl 重载插件。 /heal 启用治疗团队框架。/dps 启用坦克/输出团队框架。"
	L.tutorial_step_5_line_3 = "/tt 让你M语你的目标 /rc 立即进行团队就绪检查 /rd 解散团队或小队 /bags 通过命令行来显示一些可用信息 /ainv 通过M语你来启用自动邀请 (/ainv off) 关闭自动邀请。"
	L.tutorial_step_5_line_4 = "/gm 打开帮助面板 /install, /reset or /tutorial 载入安装程序 /frame 在聊天框里输入当前鼠标下框体的一些额外的信息。"

	-- tutorial 6
	L.tutorial_step_6_line_1 = "教程结束了。你可以在任何时候输入/tutorial来重新参看教程。"
	L.tutorial_step_6_line_2 = "我建议你仔细的看一下config/config.lua 或者输入 /duffedui 来设置你所需要的属性。"
	L.tutorial_step_6_line_3 = "你可以继续安装，如果安装已经完成你可以重置插件。"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "这些步骤将会为DuffedUI设置正确的环境变量。"
	L.install_step_1_line_2 = "第一步将会应用一些比较重要的设置。"
	L.install_step_1_line_3 = "这一步 |cffff0000推荐|r 所有的用户应用, 除非你只想应用一些特殊的设定。"
	L.install_step_1_line_4 = "点击继续来应用这些设定，或者如果你想要跳过这些步骤点击跳过。"

	-- install step 2
	L.install_step_2_line_0 = "发现另外的聊天插件。我们将略过这一步。请按跳过继续安装。"
	L.install_step_2_line_1 = "第二步应用了正确的聊天设定。"
	L.install_step_2_line_2 = "如果你是一个新用户，那么非常建议你应用这一步。 如果您已经在使用，那么可以跳过这一步。"
	L.install_step_2_line_3 = "由于应用这些设定，聊天字体过大是正常的。 当安装完成之后它会恢复正常。"
	L.install_step_2_line_4 = "点击继续来继续安装，或者点击跳过，如果你想跳过这一步骤。"

	-- install step 3
	L.install_step_3_line_1 = "第三步且是最后一步将会设定原始框体的位置。"
	L.install_step_3_line_2 = "非常 |cffff0000推荐|r 新手应用这一步。"
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "点击继续来继续安装，或者点击跳过，如果你想跳过这一步骤。"

	-- install step 4
	L.install_step_4_line_1 = "安装完成~"
	L.install_step_4_line_2 = "请点击”完成“按钮重载插件。"
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "享受DuffedUI吧! 访问我们： www.duffed.net!"

	-- buttons
	L.install_button_tutorial = "教程"
	L.install_button_install = "安装"
	L.install_button_next = "下一步"
	L.install_button_skip = "跳过"
	L.install_button_continue = "继续"
	L.install_button_finish = "完成"
	L.install_button_close = "关闭"
end