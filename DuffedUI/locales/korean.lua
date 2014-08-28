local D, C, L = unpack(select(2, ...))

if D.client == "koKR" then
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
	L.chat_BN_WHISPER_GET = "FR"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "FR"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff298F00접속|r했습니다"
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000접속종료|r했습니다"
	L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"
 
	L.chat_general = "일반"
	L.chat_trade = "거래"
	L.chat_defense = "수비"
	L.chat_recrutment = "길드모집"
	L.chat_lfg = "파티찾기"
 
	L.datatext_notalents ="특성 없음"
	L.datatext_download = "다운로드: "
	L.datatext_bandwidth = "대역폭: "
	L.datatext_inc = "Incoming"
	L.datatext_out = "Outgoing"
	L.datatext_home = "Home Latency:"
	L.datatext_world = "World Latency:"
	L.datatext_global = "Global Latency:"
	L.datatext_guild = "길드"
	L.datatext_noguild = "길드 없음"
	L.datatext_bags = "소지품: "
	L.datatext_friends = "친구"
	L.datatext_online = "온라인: "
	L.datatext_armor = "방어구"
	L.datatext_earned = "수입:"
	L.datatext_spent = "지출:"
	L.datatext_deficit = "적자:"
	L.datatext_profit = "흑자:"
	L.datatext_timeto = "전투 시간"
	L.datatext_friendlist = "친구 목록:"
	L.datatext_playersp = "주문력"
	L.datatext_playerap = "전투력"
	L.datatext_playerhaste = "가속도"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "방관"
	L.datatext_session = "세션: "
	L.datatext_character = "캐릭터: "
	L.datatext_server = "서버: "
	L.datatext_totalgold = "전체: "
	L.gametooltip_gold_a = "Archaeology: "
	L.gametooltip_gold_c = "Cooking: "
	L.gametooltip_gold_jc = "Jewelcrafting: "
	L.gametooltip_gold_dr = "Dungeon & Raids: "
	L.currencyWeekly = "주간: "
	L.datatext_savedraid = "귀속된 던전"
	L.datatext_currency = "화폐:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " 치명타율"
	L.datatext_playerheal = " 극대화율"
	L.datatext_avoidancebreakdown = "완방 수치"
	L.datatext_lvl = "레벨"
	L.datatext_boss = "우두머리"
	L.datatext_miss = "빗맞힘"
	L.datatext_dodge = "회피율"
	L.datatext_block = "방패 막기"
	L.datatext_parry = "무기 막기"
	L.datatext_playeravd = "완방: "
	L.datatext_servertime = "서버 시간: "
	L.datatext_localtime = "지역 시간: "
	L.datatext_mitigation = "레벨에 따른 경감수준: "
	L.datatext_healing = "치유량 : "
	L.datatext_damage = "피해량 : "
	L.datatext_honor = "명예 점수 : "
	L.datatext_killingblows = "결정타 : "
	L.datatext_ttstatsfor = "점수 : "
	L.datatext_ttkillingblows = "결정타:"
	L.datatext_tthonorkills = "명예 승수:"
	L.datatext_ttdeaths = "죽은 수:"
	L.datatext_tthonorgain = "획득한 명예:"
	L.datatext_ttdmgdone = "피해량:"
	L.datatext_tthealdone = "치유량:"
	L.datatext_basesassaulted = "거점 공격:"
	L.datatext_basesdefended = "거점 방어:"
	L.datatext_towersassaulted = "경비탑 점령:"
	L.datatext_towersdefended = "경비탑 방어:"
	L.datatext_flagscaptured = "깃발 쟁탈:"
	L.datatext_flagsreturned = "깃발 반환:"
	L.datatext_graveyardsassaulted = "무덤 점령:"
	L.datatext_graveyardsdefended = "무덤 방어:"
	L.datatext_demolishersdestroyed = "파괴한 파괴전차:"
	L.datatext_gatesdestroyed = "파괴한 관문:"
	L.datatext_totalmemusage = "총 메모리 사용량:"
	L.datatext_control = "현재 진영:"
	L.datatext_cta_allunavailable = "Could not get Call To Arms information."
	L.datatext_cta_nodungeons = "No dungeons are currently offering a Call To Arms."
	L.datatext_carts_controlled = "Carts Controlled:"
	L.datatext_victory_points = "Victory Points:"
	L.datatext_orb_possessions = "Orb Possessions:"
 
	L.bg_warsong = "전쟁노래 협곡"
	L.bg_arathi = "아라시 분지"
	L.bg_eye = "폭풍의 눈"
	L.bg_alterac = "알터랙 계곡"
	L.bg_strand = "고대의 해안"
	L.bg_isle = "정복의 섬"
 
	L.Slots = {
	  [1] = {1, "머리", 1000},
	  [2] = {3, "어깨", 1000},
	  [3] = {5, "가슴", 1000},
	  [4] = {6, "허리", 1000},
	  [5] = {9, "손목", 1000},
	  [6] = {10, "손", 1000},
	  [7] = {7, "다리", 1000},
	  [8] = {8, "발", 1000},
	  [9] = {16, "주장비", 1000},
	  [10] = {17, "보조장비", 1000},
	  [11] = {18, "원거리", 1000}
	}
 
	-- tuto/install
	L.install_header_1 = "환영합니다"
	L.install_header_2 = "1. 필수사항"
	L.install_header_3 = "2. 유닛프레임"
	L.install_header_4 = "3. 기능"
	L.install_header_5 = "4. 알아야할 사항!"
	L.install_header_6 = "5. 명령어"
	L.install_header_7 = "6. 완료"
	L.install_header_8 = "1. 필수 설치"
	L.install_header_9 = "2. 친목"
	L.install_header_10= "3. 프레임"
	L.install_header_11= "4. 성공!"

	L.install_init_line_1 = "DuffedUI를 사용해 주셔서 감사합니다.!"
	L.install_init_line_2 = "몇차례 간단한 설치 단계를 통해서 안내될것입니다. 각 단계에서 현 설치를 적용시킬지 아닐지를 결정하실수 있습니다."
	L.install_init_line_3 = "간단한 지침서를 볼수있는 몇가지 DuffedUI 기능들 또한 주어집니다."
	L.install_init_line_4 = "이 간단한 지침을 안내받고 싶으시면 '지침서' 버튼을 누르십시요., 이 단계를 넘기시고 싶으시면 '설치'를 누르시면 됩니다."

	L.tutorial_step_1_line_1 = "이 짧은 지침서는 몇가지 DuffedUI의 기능들을 보여줄것입니다."
	L.tutorial_step_1_line_2 = "먼저, 이 UI로 플레이 하기 전 알셔야할 필수사항들입니다."
	L.tutorial_step_1_line_3 = "이 설치기는 부분적으로 특정 캐릭터에 해당됩니다. 반면, 몇몇 설정들은 전캐릭터에 추후 적용됩니다. 각 새로운 캐릭터에 DuffedUI를 실행시키기 위해 설치 스크립트를 실행시켜야 합니다. 스크립트는 최초 DuffedUI 사용시 매 새로운 캐릭터 로그인할때 마다 자동으로 보여집니다. 또한, 파워사용자는 /DuffedUI/config/config.lua에서 옵션 설정을 하시면 됩니다. 친근사용자는 게임내에 /duffedui 입력을 통해 옵션설정이 가능합니다."
	L.tutorial_step_1_line_4 = "파워 사용자는 보통 사용자들의 능력을 넘어서 고급 기능 (예를들면 Lua 수정)을 사용할 능력을 지닌 개인컴퓨터 사용자를 일컸습니다. 친근 사용자는 보통 사용자를 일컫으며 프로그래밍 능력이 꼭 필요한것은 아닙니다. 이들에게는 DuffedUI 사용자 설정을 위해 (/duffedui)를 통해 게임내 설정도구 사용을 추천합니다."

	L.tutorial_step_2_line_1 = "DuffedUI는 Trond (Haste) A Ekseth에 의해 고안된 oUF의 버전을 포함하고 있습니다. 이는 화면상에 모든 유닛프레임, 버프 및 디버프, 직업 특정 요소들을 다룹니다."
	L.tutorial_step_2_line_2 = "이 도구에 대해 oUF에 대한 좀더 자세한 정보를 원하시면 wowinterface.com 방문하셔서 찾아보시기 바랍니다."
	L.tutorial_step_2_line_3 = "만약 힐러나 공대장으로 플레이하시는 분이라면, 힐러 유닛 프레임을 선호하실 겁니다. 이는 공격대에서 좀더 자세한 정보를 보여줍니다. (/heal) 딜러나 탱커는 심플한 레이드 표시기를 사용하시면 됩니다.(/dps) 어떤것도 사용하길 원치 않으시는 분이나 다른 애드온을 사용하시는 분은, 로그인시 캐릭터 선택 화면 애드온 설정에서 사용안함으로 하시면 됩니다."
	L.tutorial_step_2_line_4 = "간단한 유닛프레임 위치 이동을 원하시면, /moveui를 입력하시기 바랍니다."

	L.tutorial_step_3_line_1 = "DuffedUI는 블리자드 UI를 새롭게 디자인한 것입니다. 더도덜도 없습니다. 기본 UI에서 볼수있는 거의 모든 기능들은 DuffedUI를 통해 가능합니다. 기본 UI의 오직 불가능한 기능은 실제적으로 화면상에선 볼수 없는 몇몇 자동 기능들뿐입니다. 상점에서 회색템 자동 판매와 가방 아이템 자동 정리를 예를 들수 있습니다."
	L.tutorial_step_3_line_2 = "모든 이가 데미지미터기, 보스 경보 모드, 위협수준미터기등 같은것을 선호하는게 아니기 때문에, 최선의 방법이라 판단합니다. DuffedUI는 모든 직업, 역할, 사양, 게임스타일, 사용자의 취향등에 최대한 맞추기 위해 고안되었습니다. 그래서 DuffedUI는 현재 가장 선호하는 UI중에 하나입니다. 모든이의 게임스타일에 맞고 최대한 수정가능합니다. 또한 애드온에 의존없이 자신만의 맞춤 UI를 만들기 원하는 모든이를 위한 매우 좋은 개시로 디자인되었습니다. 현재 2009년부터 많은 사용자들이 자신만의 UI를 토대로 DuffedUI를 사용중입니다. DuffedUI 웹사이트에 Edited Packages를 한번 살펴보세요.!"
	L.tutorial_step_3_line_3 = "DuffedUI 웹사이트에 extra mods 부분을 방문해 보시기 바랍니다. 또는 추가 기능 및 양식 설치를 원하시는 분들은 http://www.wowinterface.com 방문하시기 바랍니다."
	L.tutorial_step_3_line_4 = ""

	L.tutorial_step_4_line_1 = "액션바 갯수 설정은 하단 액션바 배경의 왼쪽 혹은 오른쪽에 마우스를 대십시요. 오른쪽 액션바도 마찬가지로 배경 위와 아래쪽에 마우스를 대시면 됩니다. 채팅창에서 텍스트 복사는 채팅창 오른쪽 코너에 마우스를 대시면 나타나는 버튼을 클릭하시면 됩니다."
	L.tutorial_step_4_line_2 = "미니맵 테두리 색상변경. 새 메일을 받으면 녹색으로, 달력 초대를 받으면 빨강색으로, 새 메일과 달력초대가 동시에 있으면 오렌지 색상으로 변경됩니다."
	L.tutorial_step_4_line_3 = "블리자드의 다양한 판넬을 보려면 데이타텍스트의 80%는 마우스 왼쪽 클릭하시면 됩니다. 친구와 길드 데이타텍스트도 물론 마우스 오른쪽 클릭으로 기능을 살펴보실수 있습니다."
	L.tutorial_step_4_line_4 = "몇가지 사용가능한 드롭다운 메뉴가 있습니다. 가방 닫기 버튼을 오른쪽 클릭하시면 드롭다운 메뉴가 보여지며 이는 가방보이기, 아이템 정리, 열쇠가방등이 나타납니다. 마우스 중앙 버튼을 미니맵에 누르시면 micro 메뉴가 나타납니다."

	L.tutorial_step_5_line_1 = "마지막으로, DuffedUI는 유용한 슬래시 명령어를 포함하고 있습니다. 하기 리스트를 참고하세요."
	L.tutorial_step_5_line_2 = "/moveui는 화면 어디든 많은 프레임 이동을 가능하게 합니다. /enable과 /disable은 빠르게 애드온 적용과 미적용에 사용됩니다. /rl은 UI를 다시 불러올때. /heal은 힐러 레이드 유닛프레임을 사용 /dps는 딜러/탱커 레이드 유닛프레임을 사용."
	L.tutorial_step_5_line_3 = "/tt는 대상타겟에게 귓속말을 보낼때. /rc는 전투준비 체크. /rd 파티나 레이드 해체. /bags 명령어 라인으로 가능한 몇가지 기능을 보여줍니다. /ainv 귓속말 대상 자동초대를 가능하게 합니다. (/ainv off) 자동초대 기능 끄기"
	L.tutorial_step_5_line_4 = "/gm 지엠창 끄기 켜기. /install, /reset 또는 /tutorial은 설치를 불러옵니다. /frame 커서가 위치한 프레임의 이름과 추가정보를 보여줍니다."

	L.tutorial_step_6_line_1 = "지침서가 완료되었습니다. 재조정을 원하시면 언제든지 /tutorial 입력하시면 됩니다."
	L.tutorial_step_6_line_2 = "config/config.lua 파일을 살펴보시기 바랍니다. 혹은 /duffedui 입력을 통해 원하시는대로 UI 구성을 하시면 됩니다."
	L.tutorial_step_6_line_3 = "아직 완료전이거나 기본으로 리셋을 원하시면 UI 설치를 계속하실수 있습니다.!"
	L.tutorial_step_6_line_4 = ""

	L.install_step_1_line_1 = "이번 단계들은 DuffedUI의 정확한 CVar 설치를 적용시킬것입니다."
	L.install_step_1_line_2 = "1단계는 필수 설치에 적용됩니다."
	L.install_step_1_line_3 = "특정 부분설치에만 적용시키길 원하지 않는 한, 모든 사용자는 |cffff0000recommended|r 이 적용됩니다."
	L.install_step_1_line_4 = "이 설치를 적용시키려면 '계속' 버튼을 눌러주세요., 이 단계를 넘기시려면 '무시' 버튼을 누르시면 됩니다."

	L.install_step_2_line_0 = "다른 채팅 애드온이 발견되면 이 단계는 무시될것입니다. 계속 설치를 위해 '무시' 버튼을 눌러주세요."
	L.install_step_2_line_1 = "2단계는 옳바른 채팅 구성이 적용됩니다."
	L.install_step_2_line_2 = "이 단계는 처음이신 사용자분에게 추천합니다. 기존 사용자분들은 이 단계는 넘기셔도 됩니다."
	L.install_step_2_line_3 = "이 설치를 기반으로 적용시키면 채팅 폰트는 크게 보여집니다. 설치를 마치면 다시 정상적으로 나타납니다."
	L.install_step_2_line_4 = "이 설치를 적용시키려면 '계속' 버튼을 눌러주세요., 이 단계를 넘기시려면 '무시' 버튼을 누르시면 됩니다."

	L.install_step_3_line_1 = "3단계와 마지막 단계는 기본 프레임 위치 적용입니다."
	L.install_step_3_line_2 = "이 단계 |cffff0000recommended|r 는 처음이신 사용자를 위한것입니다."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "이 설치를 적용시키려면 '계속' 버튼을 눌러주세요., 이 단계를 넘기시려면 '무시' 버튼을 누르시면 됩니다."

	L.install_step_4_line_1 = "설치가 완료되었습니다."
	L.install_step_4_line_2 = "UI를 다시 불러오시려면 '마침' 버튼을 눌러주세요."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "DuffedUI를 즐기세요! http://www.duffed.net를 통해 방문하실수 있습니다.!"

	L.install_button_tutorial = "지침서"
	L.install_button_install = "설치"
	L.install_button_next = "다음"
	L.install_button_skip = "무시"
	L.install_button_continue = "계속"
	L.install_button_finish = "마침"
	L.install_button_close = "종료"
end
