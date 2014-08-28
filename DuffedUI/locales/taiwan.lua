local D, C, L = unpack(select(2, ...))

if D.client == "zhTW" then
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
	L.chat_BN_WHISPER_GET = "密語"
	L.chat_GUILD_GET = "公"
	L.chat_OFFICER_GET = "官"
	L.chat_PARTY_GET = "隊"
	L.chat_PARTY_GUIDE_GET = "地下城向導"
	L.chat_PARTY_LEADER_GET = "隊長"
	L.chat_RAID_GET = "團"
	L.chat_RAID_LEADER_GET = "團長"
	L.chat_RAID_WARNING_GET = "團長警告"
	L.chat_WHISPER_GET = "密語"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff05e9FF上線了|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000下線了|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"
	
	L.chat_general = "綜合"
	L.chat_trade = "交易"
	L.chat_defense = "本地防務"
	L.chat_recrutment = "公會招募"
	L.chat_lfg = "尋求組隊"
	
	L.datatext_notalents ="無天賦"
	L.datatext_download = "下載: "
	L.datatext_bandwidth = "寬頻: "
	L.datatext_inc = "接收"
	L.datatext_out = "發送"
	L.datatext_home = "本地延遲:"
	L.datatext_world = "世界延遲:"
	L.datatext_global = "全局延遲:"
	L.datatext_guild = "公會"
	L.datatext_noguild = "沒有公會"
	L.datatext_bags = "背包: "
	L.datatext_friends = "好友"
	L.datatext_online = "線上: "
	L.datatext_armor = "耐久度"
	L.datatext_earned = "賺取:"
	L.datatext_spent = "花費:"
	L.datatext_deficit = "赤字:"
	L.datatext_profit = "利潤:"
	L.datatext_timeto = "時間直到"
	L.datatext_friendlist = "好友名單:"
	L.datatext_playersp = "法傷"
	L.datatext_playerap = "強度"
	L.datatext_playerhaste = "加速"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "護甲穿透"
	L.datatext_session = "本次概況: "
	L.datatext_character = "角色: "
	L.datatext_server = "伺服器: "
	L.datatext_totalgold = "總額: "
	L.gametooltip_gold_a = "考古學: "
	L.gametooltip_gold_c = "烹飪: "
	L.gametooltip_gold_jc = "珠寶: "
	L.gametooltip_gold_dr = "地城 & 團隊: "
	L.currencyWeekly = "每周: "
	L.datatext_savedraid = "已有進度的團隊副本"
	L.datatext_currency = "兌換通貨:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = "% 致命"
	L.datatext_playerheal = " 治療"
	L.datatext_avoidancebreakdown = "免傷分析"
	L.datatext_lvl = "等級"
	L.datatext_boss = "首領"
	L.datatext_miss = "未擊中"
	L.datatext_dodge = "閃躲"
	L.datatext_block = "格檔"
	L.datatext_parry = "招架"
	L.datatext_playeravd = "免傷: "
	L.datatext_servertime = "伺服器時間: "
	L.datatext_localtime = "本地時間: "
	L.datatext_mitigation = "等級緩和: "
	L.datatext_healing = "治療: "
	L.datatext_damage = "傷害: "
	L.datatext_honor = "榮譽: "
	L.datatext_killingblows = "擊殺 : "
	L.datatext_ttstatsfor = "狀態 "
	L.datatext_ttkillingblows = "擊殺:"
	L.datatext_tthonorkills = "榮譽擊殺:"
	L.datatext_ttdeaths = "死亡:"
	L.datatext_tthonorgain = "獲得榮譽:"
	L.datatext_ttdmgdone = "傷害輸出:"
	L.datatext_tthealdone = "治療輸出:"
	L.datatext_basesassaulted = "基地突襲:"
	L.datatext_basesdefended = "基地防禦:"
	L.datatext_towersassaulted = "哨塔突襲:"
	L.datatext_towersdefended = "哨塔防禦:"
	L.datatext_flagscaptured = "佔領旗幟:"
	L.datatext_flagsreturned = "交還旗幟:"
	L.datatext_graveyardsassaulted = "墓地突襲:"
	L.datatext_graveyardsdefended = "墓地防守:"
	L.datatext_demolishersdestroyed = "石毀車摧毀:"
	L.datatext_gatesdestroyed = "大門摧毀:"
	L.datatext_totalmemusage = "總共記憶體使用:"
	L.datatext_control = "控制方:"
	L.datatext_cta_allunavailable = "無法獲取戰鬥的召喚信息."
	L.datatext_cta_nodungeons = "目前沒有可用的戰鬥的召喚地下城."
	L.datatext_carts_controlled = "礦車控制:"
	L.datatext_victory_points = "勝利點數:"
	L.datatext_orb_possessions = "能量寶珠點數:"
 
	L.Slots = {
		[1] = {1, "頭部", 1000},
		[2] = {3, "肩部", 1000},
		[3] = {5, "胸部", 1000},
		[4] = {6, "腰部", 1000},
		[5] = {9, "手腕", 1000},
		[6] = {10, "手", 1000},
		[7] = {7, "腿部", 1000},
		[8] = {8, "腳", 1000},
		[9] = {16, "主手", 1000},
		[10] = {17, "副手", 1000},
		[11] = {18, "遠程", 1000}
	}
 
	-- tuto/install
	L.install_header_1 = "歡迎"
	L.install_header_2 = "1. 基本要素"
	L.install_header_3 = "2. 單位框架"
	L.install_header_4 = "3. 特點"
	L.install_header_5 = "4. 您應該知道的事!"
	L.install_header_6 = "5. 指令"
	L.install_header_7 = "6. 完成"
	L.install_header_8 = "1. 必要的設定"
	L.install_header_9 = "2. 社交"
	L.install_header_10= "3. 框架"
	L.install_header_11= "4. 成功!"

	L.install_init_line_1 = "感謝您選擇DuffedUI!"
	L.install_init_line_2 = "透過幾個簡單的步驟，將會引導您通過整個安裝過程。每個步驟您都可以決定是否套用或略過所呈現的設定。"
	L.install_init_line_3 = "您也可以選擇顯示關於DuffedUI功能的簡短指南。"
	L.install_init_line_4 = "點選'指南'來獲得簡介，或者點選'安裝'以略過這步驟。"

	L.tutorial_step_1_line_1 = "這個快速指南將向您展示一些DuffedUI的特點及功能。"
	L.tutorial_step_1_line_2 = "首先，基本要素將會告訴您使用這個UI前該知道的事項。"
	L.tutorial_step_1_line_3 = "這個安裝程序部分是角色特定，一些設定將會全帳號套用，您必須為每一個有使用DuffedUI的新角色執行安裝程序。程序將會在新角色第一次登入DuffedUI時自動顯示。同時，進階使用者可以在/DuffedUI/config/config.lua中找到選項，友善使用者可以在遊戲中輸入/duffedui。"
	L.tutorial_step_1_line_4 = "進階使用者是指有能力會使用一般使用者所不會的進階功能(如：編輯lua)的個人電腦使用者。友善使用者為一般使用者，並不需要編寫程式的能力，推薦他們使用我們的遊戲內設定工具(/duffedui)來設定DuffedUI上想呈現的功能。"

	L.tutorial_step_2_line_1 = "DuffedUI包含一個內建版本的oUF，由Trond (Haste) A Ekseth創造，處理畫面中所有的單位框架，增/減益狀態及職業特色元素。"
	L.tutorial_step_2_line_2 = "您可以拜訪 http://www.wowinterface.com 蒐尋oUF以獲得更多這項工具的資訊。"
	L.tutorial_step_2_line_3 = "假如您是治療者或是團隊領隊，您可能想啟用治療者團隊框架，它們提供更多團隊資訊(/heal)。傷害輸出玩家或是坦克應該使用簡潔的團隊框架(/dps)。如果不想顯示任一團隊框架或是其他東西，您可以在角色選單的插件管理中關閉它。"
	L.tutorial_step_2_line_4 = "鍵入/moveui可以簡單地改變單位框架的位置。"

	L.tutorial_step_3_line_1 = "DuffedUI是一個重新設計過的Blizzard UI，不多也不少。大部分你可以在預設UI上看到的都是DuffedUI，只有一些自動化功能是畫面中看不到的，如：拜訪商人時自動販賣灰色物品，或是自動分類背包中的物品。"
	L.tutorial_step_3_line_2 = "並不是每個人都滿意傷害輸出統計、首領模組，仇恨監控等等，但我們認為這是最好的事情。DuffedUI是在符合所有職業、角色、天賦、玩法、玩家品味...等等的概念下產生，這就是為什麼DuffedUI是現今最受歡迎的UI之一，它適合每個人的玩法且可任意地調整。它也設計成可讓任何想做客製化UI卻沒有關聯插件的人有一個好的開始。自2009年後，許多玩家使用DuffedUI為基礎來創作自己的UI，可以到我們網站的Edited Packages論壇專區看看!"
	L.tutorial_step_3_line_3 = "使用者可能有興趣到我們網站的額外模組專區看看，或是拜訪 http://www.wowinterface.com 來獲得額外的功能或模組。"
	L.tutorial_step_3_line_4 = ""

	L.tutorial_step_4_line_1 = "將滑鼠移至在底部快捷列背景的最左/右邊，可設定底部快捷列的數目，畫面右邊的快捷列同樣可藉由上方或底部調整。點擊對話框的右上角游標懸停顯示的按鈕即可複製聊天文字。"
	L.tutorial_step_4_line_2 = "小地圖邊框將會改變顏色，收到新郵件時為綠色，受到新的行事曆邀請時為紅色，兩項皆有時為橘色。"
	L.tutorial_step_4_line_3 = "您可以左鍵點擊80%的資訊欄位來顯示各種Blizzard的面板，好友資訊及公會資訊同時擁有右鍵點擊功能。"
	L.tutorial_step_4_line_4 = "這裡有一些下拉式選單可供使用。右鍵點擊背包的[X](關閉)按鈕將會顯示功能選單以顯示背包、排列物品、顯示鑰匙圈等等。中鍵點擊小地圖可顯示微型選單。"

	L.tutorial_step_5_line_1 = "最近，DuffedUI有許多實用的指令，以下列表。"
	L.tutorial_step_5_line_2 = "/moveui 允許你移動畫面上大部分的框架。 /enable 及 /disable 快速啟用或關閉插件。 /rl 重新載入UI。 /heal 啟用治療者團隊框架。 /dps 啟用傷害輸出/坦克團隊框架。"
	L.tutorial_step_5_line_3 = "/tt 密語目標。 /rc 發起團隊確認。 /rd 解散隊伍或團隊。 /bags 顯示可用的背包指令。 /ainv 啟用自動密語邀請。(/ainv off 關閉功能)"
	L.tutorial_step_5_line_4 = "/gm 開啟尋求幫助選單。 /install, /reset 或 /tutorial 載入安裝程序。 /frame 列出滑鼠游標下的框架名稱及額外資訊。"

	L.tutorial_step_6_line_1 = "指南到此結束，您可藉由輸入/tutorial 以再次諮詢。"
	L.tutorial_step_6_line_2 = "建議您開啟config/config.lua或鍵入/duffedui來自訂符合您需求的UI。"
	L.tutorial_step_6_line_3 = "如果安裝程序未完成，您現在可繼續安裝此UI。或者您想重置至預設值!"
	L.tutorial_step_6_line_4 = ""

	L.install_step_1_line_1 = "這些步驟將為DuffedUI套用正確的CVar設定。"
	L.install_step_1_line_2 = "第一個步驟套用必要的設定。"
	L.install_step_1_line_3 = "這個步驟|cffff0000建議|r給任何一位新使用者，除非您只想套用這些設定的特定部分。"
	L.install_step_1_line_4 = "點選'繼續'以套用設定，如果您希望跳過這個步驟請點選'略過'。"

	L.install_step_2_line_0 = "發現到其他的聊天插件。我們將會忽略這個步驟，請點擊略過以繼續安裝。"
	L.install_step_2_line_1 = "第二個步驟將會套用正確的聊天設定。"
	L.install_step_2_line_2 = "如果您是一位新使用者，我們建議這個步驟。如果是現有使用者，您可能想略過這個步驟。"
	L.install_step_2_line_3 = "經由這些設定，您的聊天字體顯示過大是正常的，當安裝完成後將會還原。"
	L.install_step_2_line_4 = "點選'繼續'以套用設定，如果您希望跳過這個步驟請點選'略過'。"

	L.install_step_3_line_1 = "第三和最後的步驟將套用預設框架位置。"
	L.install_step_3_line_2 = "我們|cffff0000建議|r這個步驟給任何一位新使用者。"
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "點選'繼續'以套用這些設定，如果您希望跳過這個步驟請點選'略過'。"

	L.install_step_4_line_1 = "安裝完成。"
	L.install_step_4_line_2 = "請點擊'完成'以重新載入UI。"
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "享受DuffedUI吧! 拜訪我們 http://www.duffed.net!"

	L.install_button_tutorial = "指南"
	L.install_button_install = "安裝"
	L.install_button_next = "下一步"
	L.install_button_skip = "略過"
	L.install_button_continue = "繼續"
	L.install_button_finish = "完成"
	L.install_button_close = "關閉"
end