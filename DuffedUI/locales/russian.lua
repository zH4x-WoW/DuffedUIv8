local D, C, L = unpack(select(2, ...))

if D.client == "ruRU" then
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
	L.chat_BN_WHISPER_GET = "От"
	L.chat_GUILD_GET = "Г"
	L.chat_OFFICER_GET = "О"
	L.chat_PARTY_GET = "Гр"
	L.chat_PARTY_GUIDE_GET = "Гр"
	L.chat_PARTY_LEADER_GET = "Лгр"
	L.chat_RAID_GET = "Р"
	L.chat_RAID_LEADER_GET = "ЛР"
	L.chat_RAID_WARNING_GET = "ОР"
	L.chat_WHISPER_GET = "От"
	L.chat_FLAG_AFK = "[АФК]"
	L.chat_FLAG_DND = "[ДНД]"
	L.chat_FLAG_GM = "[ГМ]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff298F00входит|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000выходит|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"
	
	L.chat_general = "Общий"
	L.chat_trade = "Торговля"
	L.chat_defense = "ОборонаЛокальный"
	L.chat_recrutment = "Гильдии"
	L.chat_lfg = "ПоискСпутников"
 
	L.datatext_notalents ="Нет талантов"
	L.datatext_download = "Загрузка: "
	L.datatext_bandwidth = "Скорость: "
	L.datatext_inc = "Incoming"
	L.datatext_out = "Outgoing"
	L.datatext_home = "Home Latency:"
	L.datatext_world = "World Latency:"
	L.datatext_global = "Global Latency:"
	L.datatext_guild = "Гильдия"
	L.datatext_noguild = "Не в Гильдии"
	L.datatext_bags = "Сумки: "
	L.datatext_friends = "Друзья"
	L.datatext_online = "В игре: "
	L.datatext_armor = "Броня"
	L.datatext_earned = "Получено:"
	L.datatext_spent = "Потрачено:"
	L.datatext_deficit = "Убыток:"
	L.datatext_profit = "Прибыль:"
	L.datatext_timeto = "Времени до"
	L.datatext_friendlist = "Список друзей:"
	L.datatext_playersp = "sp"
	L.datatext_playerap = "ap"
	L.datatext_playerhaste = "скорость"
	L.datatext_dps = "дпс"
	L.datatext_hps = "хпс"
	L.datatext_playerarp = "арп"
	L.datatext_session = "Сеанс: "
	L.datatext_character = "Персонаж: "
	L.datatext_server = "Сервер: "
	L.datatext_totalgold = "Всего: "
	L.gametooltip_gold_a = "Archaeology: "
	L.gametooltip_gold_c = "Cooking: "
	L.gametooltip_gold_jc = "Jewelcrafting: "
	L.gametooltip_gold_dr = "Dungeon & Raids: "
	L.currencyWeekly = "еженедельно: "
	L.datatext_savedraid = "Сохранения:"
	L.datatext_currency = "Валюта:"
	L.datatext_fps = " к/с & "
	L.datatext_ms = " мс"
	L.datatext_playercrit = " crit"
	L.datatext_playerheal = " heal"
	L.datatext_avoidancebreakdown = "Распределение"
	L.datatext_lvl = "ур"
	L.datatext_boss = "Босс"
	L.datatext_miss = "Промах"
	L.datatext_dodge = "Уклонение"
	L.datatext_block = "Блок"
	L.datatext_parry = "Парирование"
	L.datatext_playeravd = "avd: "
	L.datatext_servertime = "Серверное время: "
	L.datatext_localtime = "Местное время: "
	L.datatext_mitigation = "Уменьшение по уровню: "
	L.datatext_healing = "Исцеление : "
	L.datatext_damage = "Урон : "
	L.datatext_honor = "Очки чести : "
	L.datatext_killingblows = "Смерт. удары : "
	L.datatext_ttstatsfor = "Статистика по "
	L.datatext_ttkillingblows = "Смерт. удары:"
	L.datatext_tthonorkills = "Почетные победы:"
	L.datatext_ttdeaths = "Смерти:"
	L.datatext_tthonorgain = "Получено чести:"
	L.datatext_ttdmgdone = "Нанесено урона:"
	L.datatext_tthealdone = "Исцелено урона:"
	L.datatext_basesassaulted = "Штурмы баз:"
	L.datatext_basesdefended = "Оборона баз:"
	L.datatext_towersassaulted = "Штурмы башен:"
	L.datatext_towersdefended = "Оборона башен:"
	L.datatext_flagscaptured = "Захваты флага:"
	L.datatext_flagsreturned = "Возвраты флага:"
	L.datatext_graveyardsassaulted = "Штурмы кладбищ:"
	L.datatext_graveyardsdefended = "Оборона кладбищ:"
	L.datatext_demolishersdestroyed = "Разрушителей уничтожено:"
	L.datatext_gatesdestroyed = "Врат разрушено:"
	L.datatext_totalmemusage = "Общее использование памяти:"
	L.datatext_control = "Под контролем:"
	L.datatext_cta_allunavailable = "Не могу получить информацию Призыва к Оружию."
	L.datatext_cta_nodungeons = "Призыва к Оружию на данный момент нет."
	L.datatext_carts_controlled = "Захваты вагонеток:"
	L.datatext_victory_points = "Очки победы:"
	L.datatext_orb_possessions = "Захваты сферы:"
 
	L.Slots = {
	  [1] = {1, "Голова", 1000},
	  [2] = {3, "Плечо", 1000},
	  [3] = {5, "Грудь", 1000},
	  [4] = {6, "Пояс", 1000},
	  [5] = {9, "Запястья", 1000},
	  [6] = {10, "Кисти рук", 1000},
	  [7] = {7, "Ноги", 1000},
	  [8] = {8, "Ступни", 1000},
	  [9] = {16, "Правая рука", 1000},
	  [10] = {17, "Левая рука", 1000},
	  [11] = {18, "Оружие дальнего боя", 1000}
	}
 
	-- tuto/install
	L.install_header_1 = "Добро пожаловать!"
	L.install_header_2 = "1. Необходимые элементы"
	L.install_header_3 = "2. Рамки портретов"
	L.install_header_4 = "3. Особенности"
	L.install_header_5 = "4. Что нужно знать!"
	L.install_header_6 = "5. Команды"
	L.install_header_7 = "6. Завершено"
	L.install_header_8 = "1. Основные настройки"
	L.install_header_9 = "2. Панель общения"
	L.install_header_10= "3. Портреты"
	L.install_header_11= "4. Готово!"

	L.install_init_line_1 = "Спасибо за использование DuffedUI!"
	L.install_init_line_2 = "Мы Вам поможем с процессом установки с помощью всего нескольких простых шагов. На каждом шагу, Вы можете выбрать, хотите ли Вы применить выбранные настройки или пропустить этот шаг."
	L.install_init_line_3 = "Также у Вас есть возможность просмотреть введение, которое расскажет о некоторых особенностях DuffedUI."
	L.install_init_line_4 = "Нажмите `Введение` для перехода или нажмите `Установить` для пропуска данного шага."

	L.tutorial_step_1_line_1 = "Это быстрое введение расскажет Вам об особенностях TukUI"
	L.tutorial_step_1_line_2 = "Во-первых, важная информация, которую Вы должны знать перед тем, как приступить к игре, используя TukUI."
	L.tutorial_step_1_line_3 = "Данный установщик отчасти индивидуален для каждого персонажа. Одни настройки будут применены для всех персонажей Вашего аккаунта, некоторые же другие настройки Вам будет необходимо устанавливать для каждого персонажа отдельно, для чего будет использовано диалоговое окно. Дbfлоговое окно будет показано каждый раз, когда Вы входите в игру новым персонажем, первый раз использующим TukUI. Также, для продвинутых пользователей предусмотрена возможность редактирования настроек через изменение файла конфигурации, который находится по пути /DuffedUI/config/config.lua. Интуитивно понятный интерфейс по изменению настроек для обычных пользователей вызывается командой /duffedui"
	L.tutorial_step_1_line_4 = "Продвинутый пользователь - это пользователь компьютера, который обладает определенными навыками (например, LUA-кодировкой). Обычный пользователь - пользователь, не обладающий навыками программирования. Для них рекомендуется использование команды /duffedui для отображения настроек"

	L.tutorial_step_2_line_1 = "DuffedUI включает в себя встроенную версию oUF, созданную Trond'ом (Haste) A Ekseth'ом. Данная встроенная версия oUF отвечает за все рамки портретов, эффекты и ауры, а также за уникальные для каждого класса элементы"
	L.tutorial_step_2_line_2 = "Вы можете посетить wowinterface.com и поискать oUF для более полной информации"
	L.tutorial_step_2_line_3 = "Если вы играете хилером (лекарем) или лидером рейда, возможно, Вы захотите включить специально разработанные панели для хилеров (лекарей). Они отображают более детальную информацию о членах вашей группы/рейда. Включается командой /heal. ДПСерам (ДДшникам) и танкам рекомендуется использовать простой интерфейс для рейда. Включается командой /dps. Если Вы не хотите использовать ни один из предложенных вариантов или желаете использовать что-то другое, Вы можете отключить эту функцию через панель модификаций на странице выбора персонажа"
	L.tutorial_step_2_line_4 = "Для легкого изменения позиции рамки портрета просто наберите /moveui"

	L.tutorial_step_3_line_1 = "TukUI - это модифицированный вариант оригинального интерфейса от Близзард. Ни больше, ни меньше. Практически ве функции, которые Вы можете встретить в оригинальном интерфейсе, присутствуют и в TukUI, кроме, например, таких уникальных для TukUI функций, как продажа серых вещей автоматически при посещении вендора (торговца) или авто-сортировка вещей в сумках."
	L.tutorial_step_3_line_2 = "Хотя не все игроки любят использовать такие вещи, как ДПС метры, моды для боссов, аггро (угроза) метры и прочее, мы считаем, что лучше их использовать. TukUI создан именно для того, чтобы любой игрок любого класса, с любым вкусом и видом геймплея, мог использовать TukUI, как ему нравится, так как данный интерфейс легко редактируемый. Также TukUI может служить наглядным пособием для тех, кто хочет создать свой интерфейс без помощи посторонних аддонов (модификаций). Именно поэтому TukUI так популярен! С 2009 года множество игроков использовали TukUI, чтоьы создать свой уникальный интерфейс! Чтобы убедиться, зайдите в раздел Edited packages на нашей сайте!"
	L.tutorial_step_3_line_3 = "Пользователи могут захотеть посетить страничку с дополнительными модификациями на нашей сайте или же посетить wowinterface.com"
	L.tutorial_step_3_line_4 = ""

	L.tutorial_step_4_line_1 = "Чтобы выбрать, сколько панелей команд Вы хотите, наведите курсор мыши слева или справа от нижней панели команд. Тем же путем вы можете выбрать количество панелей справа, наведя курсором соответственно снизу или сверху панели команд. Чтобы скопировать текст из окошка общения, нажмите на кнопку в правом углу окошка общения."
	L.tutorial_step_4_line_2 = "Окантовка мини-карты меняет цвет. Она зеленая, когда у вас новое письмо, красная, когда у вас новое приглашение в игровом календаре, оранжевая, когда и то, и то в одно время..."
	L.tutorial_step_4_line_3 = "Вы можете нажать левой кнопкой мыши почти на каждый дата-текст внизу экрана и под мини-картой для открытия соответствующий окошек (гильдия/друзья/календарь/прочее). Также дата-текст гильдии (там, где отображается количество членов гильдии онлайн) имеет некторые функции при нажатии правой кнопкой мыши на дата-текст."
	L.tutorial_step_4_line_4 = "К тому же, имеются некоторые выпадающие меню. Нажмите правой кнопкой мыши на [Х] (Закрыть) кнопке окошка сумок для отображения меню, при помощи которого можно автоматически сортировать вещи в сумках, показать, какие у вас сумки, ключи и прочее. Щелчок колесиком по мини-карте вызовет мини-меню.."

	L.tutorial_step_5_line_1 = "Напоследок, TukUI имеет широкий набор консольных команд (слэш-команды). Ниже приведен список некоторых из них. "
	L.tutorial_step_5_line_2 = "/moveui позволяет вам двигать почти все элементы интерфейса на любую точку. /enable and /disable используются для быстрого включения и отключения аддонов (модификаций). /rl перезагружает интерфейс. /heal включает интерфейс хилера (лекаря), а /dps включает интерфейс для ДДшников (ДПСеров) и танков."
	L.tutorial_step_5_line_3 = "/tt позволяет Вам послать сообщение вашей цели. /rc производить проверку готовности вашей группы/рейда (рэди-чек). /rd распускает группу или рейд. /bags отображает некоторые особенности команд, используемых через командную строку.. /ainv включает автоматическое приглашение в группу (инвайт) через посылку Вам сообщения. /ainv off отключает эту функцию"
	L.tutorial_step_5_line_4 = "/gm открывает окно помощи. /install, /reset или /tutorial загружает данный установщик. /frame показывает вам имя и дополнительную информацию об элементе интерфейса, на который Вы навели курсор."

	L.tutorial_step_6_line_1 = "Введение завершено. Вы можете повторить его в любое время, просто напечатав /tutorial."
	L.tutorial_step_6_line_2 = "Рекомендую Вам взглянуть на файл конфигурации, который находится по пути config/config.lua, или же просто напечатайте /duffedui для настройки интерфейса, как Вам нравится."
	L.tutorial_step_6_line_3 = "Сейчас Вы можете продолжить установку данного интерфейса, если вы еще не закончили, или же сбросить все настройки на настройки по умолчанию!"
	L.tutorial_step_6_line_4 = ""

	L.install_step_1_line_1 = "Данные шаги применят правильные CVar настройки для DuffedUI."
	L.install_step_1_line_2 = "Первый шаг применяет основные настройки."
	L.install_step_1_line_3 = "|cffff0000Рекомендуется|r для любого пользователя, если Вы не собираетесь применить только определенные параметры."
	L.install_step_1_line_4 = "Нажмите «Продолжить», чтобы сохранить настройки, или нажмите «Пропустить», если вы хотите пропустить данный шаг."

	L.install_step_2_line_0 = "Найдена другая модификация чата. Мы пропустим этот шаг. Пожалуйста, нажмите «Пропустить» для продолжения установки."
	L.install_step_2_line_1 = "Второй шаг применит настройки для чата."
	L.install_step_2_line_2 = "Если вы новый пользователь, этот шаг рекомендуется. Если Вы уже пользовались этим интерфейсом, возможно, Вы захотите пропустить данный шаг."
	L.install_step_2_line_3 = "Это нормально, если размер шрифта будет слишком большим, пока Вы не применили настройки. Шрифт будет нормальным, когда Вы закончите установку. "
	L.install_step_2_line_4 = "Нажмите «Продолжить» для сохранения настроек или нажмите «Пропустить», чтобы пропустить данный шаг."

	L.install_step_3_line_1 = "Третий и последний шаг применит настройки положения рамок портретов и элементов интерфейса"
	L.install_step_3_line_2 = "Этот шаг |cffff0000рекомендуется|r для любого пользователя."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = " Нажмите «Продолжить» для сохранения настроек или нажмите «Пропустить», чтобы пропустить данный шаг. "

	L.install_step_4_line_1 = "Установка завершена."
	L.install_step_4_line_2 = "Пожалуйста, нажмите «Завершить» для перезагрузки интерфейса."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Наслаждайтесь DuffedUI! Посетите нас на http://www.duffed.net!"

	L.install_button_tutorial = "Введение"
	L.install_button_install = "Установка"
	L.install_button_next = "Далее"
	L.install_button_skip = "Пропустить"
	L.install_button_continue = "Продолжить"
	L.install_button_finish = "Завершить"
	L.install_button_close = "Закрыть"
end