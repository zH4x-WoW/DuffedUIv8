local D, C, L = unpack(select(2, ...))

if D.client == "deDE" then
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
	L.chat_BN_WHISPER_GET = "Von"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "Von"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "ist jetzt |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "ist jetzt |cffff0000offline|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Haustierkampf"
	
	L.chat_general = "Allgemein"
	L.chat_trade = "Handel"
	L.chat_defense = "LokaleVerteidigung"
	L.chat_recrutment = "Gildenrekrutierung"
	L.chat_lfg = "SucheNachGruppe"
	
	L.datatext_notalents ="Keine Spezalisierung"  --changed
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Bandbreite: "
	L.datatext_inc = "Eingehend"
	L.datatext_out = "Ausgehend"
	L.datatext_home = "Heimlatenz:"
	L.datatext_world = "Weltlatenz:"
	L.datatext_global = "Globale Latenz:"
	L.datatext_guild = "Gilde"
	L.datatext_noguild = "Keine Gilde"
	L.datatext_bags = "Tasche: "
	L.datatext_friends = "Freunde"
	L.datatext_online = "Online: "
	L.datatext_armor = "Rüstung"
	L.datatext_earned = "Erhalten:"
	L.datatext_spent = "Ausgegeben:"
	L.datatext_deficit = "Differenz:"
	L.datatext_profit = "Gewinn:"
	L.datatext_timeto = "Zeit bis"
	L.datatext_friendlist = "Freundesliste:"
	L.datatext_playersp = "sp"
	L.datatext_playerap = "ap"
	L.datatext_playerhaste = "haste"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "arp"
	L.datatext_session = "Sitzung: "  
	L.datatext_character = "Charakter: "
	L.datatext_server = "Server: "
	L.datatext_totalgold = "Gesamt: "
	L.gametooltip_gold_a = "Archaeology: "
	L.gametooltip_gold_c = "Kochen: "
	L.gametooltip_gold_jc = "Juwelenschleifen: "
	L.gametooltip_gold_dr = "Instanzen & Schlachtzug: "
	L.currencyWeekly = "Wöchentlich: "
	L.datatext_savedraid = "Instanz ID(s)"
	L.datatext_currency = "Währung:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " crit"
	L.datatext_playerheal = " heal"
	L.datatext_avoidancebreakdown = "Vermeidungsübersicht" 
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Boss"
	L.datatext_miss = "Verfehlen" 
	L.datatext_dodge = "Ausweichen"  
	L.datatext_block = "Blocken" 
	L.datatext_parry = "Parieren" 
	L.datatext_playeravd = "avd: "
	L.datatext_servertime = "Serverzeit: "
	L.datatext_localtime = "Ortszeit: "
	L.datatext_mitigation = "Schadensverringerung nach Level: " 
	L.datatext_healing = "Heilung : "
	L.datatext_damage = "Schaden : "
	L.datatext_honor = "Ehre : "
	L.datatext_killingblows = "Todesstöße : "
	L.datatext_ttstatsfor = "Stats für "
	L.datatext_ttkillingblows = "Todesstöße:"
	L.datatext_tthonorkills = "Ehrenhafte Siege:"
	L.datatext_ttdeaths = "Tode:"
	L.datatext_tthonorgain = "Ehre erhalten:"
	L.datatext_ttdmgdone = "Schaden verursacht:"
	L.datatext_tthealdone = "Heilung verursacht:"
	L.datatext_basesassaulted = "Basen angegriffen:"
	L.datatext_basesdefended = "Basen verteidigt:"
	L.datatext_towersassaulted = "Türme angegriffen:"
	L.datatext_towersdefended = "Türme verteidigt:"
	L.datatext_flagscaptured = "Flaggen eingenommen:"
	L.datatext_flagsreturned = "Flaggen zurückgebracht:"
	L.datatext_graveyardsassaulted = "Friedhöfe angegriffen:"
	L.datatext_graveyardsdefended = "Friedhöfe verteidigt:"
	L.datatext_demolishersdestroyed = "Verwüster zerstört:"
	L.datatext_gatesdestroyed = "Tore zerstört:"
	L.datatext_totalmemusage = "Gesamte Speichernutzung:"
	L.datatext_control = "Kontrolliert von:"
	L.datatext_cta_allunavailable = "Could not get Call To Arms information."
	L.datatext_cta_nodungeons = "No dungeons are currently offering a Call To Arms."
	L.datatext_carts_controlled = "Kontrollierte Loren:"
	L.datatext_victory_points = "Siegespunkte:"
	L.datatext_orb_possessions = "Gehaltene Kugeln:"
 
	L.Slots = {
		[1] = {1, "Kopf", 1000},
		[2] = {3, "Schultern", 1000},
		[3] = {5, "Brust", 1000},
		[4] = {6, "Gürtel", 1000},
		[5] = {9, "Handgelenke", 1000},
		[6] = {10, "Hände", 1000},
		[7] = {7, "Beine", 1000},
		[8] = {8, "Füße", 1000},
		[9] = {16, "Waffenhand", 1000},
		[10] = {17, "Schildhand", 1000},
		[11] = {18, "Distanzwaffe", 1000}
	}
 
	-- tuto/install
	L.install_header_1 = "Willkommen"
    L.install_header_2 = "1. Grundlegendes"
    L.install_header_3 = "2. Einheitenfenster"
    L.install_header_4 = "3. Funktionen"
    L.install_header_5 = "4. Das solltest Du wissen!"
    L.install_header_6 = "5. Kommandos"
    L.install_header_7 = "6. Abgeschlossen"
    L.install_header_8 = "1. Grundeinstellungen"
    L.install_header_9 = "2. Chat"
    L.install_header_10= "3. Frames"
    L.install_header_11= "4. Abschluss!"

    L.install_init_line_1 = "Danke, dass Du Dich für DuffedUI entschieden hast!"
    L.install_init_line_2 = "Du wirst mit einigen einfachen Schritten durch die Installation geführt. Bei jedem Schritt kannst Du entscheiden, ob Du die Standardeinstellungen übernehmen oder überspringen möchtest."
    L.install_init_line_3 = "Du hast auch die Möglichkeit, eine Einführung in einige der Funktionen von DuffedUI zu erhalten."
    L.install_init_line_4 = "Klicke auf 'Tutorial' um eine kleine Einleitung zu erhalten, oder klicke auf 'Installation' um diesen Schritt zu überspringen."

    L.tutorial_step_1_line_1 = "Dieses kurze Tutorial wird Dir einige Funktionen von DuffedUI zeigen."
    L.tutorial_step_1_line_2 = "Zuerst das Wichtigste, das Du wissen solltest, bevor Du mit diesem UI spielst."
    L.tutorial_step_1_line_3 = "Diese Installation ist teilweise charakterbezogen. Während einige Einstellungen, die später angewandt werden, accountweit sind, musst Du die Installation für jeden neuen Charakter starten der DuffedUI nutzt. Dieses Script wird automatisch beim ersten Einloggen eines Charakters mit DuffedUI gezeigt. Die Optionen können benutzerfreundlich mit dem Befehl /duffedui angepasst werden. Erfahrene Benutzer können die Optionen auch unter /DuffedUI/config/config.lua anpassen."
    L.tutorial_step_1_line_4 = "Das Bearbeiten der Config.lua benötigt unter anderem Erfahrung in der Programmierung von Lua. Es wird empfohlen, die Konfiguration im Spiel per /duffedui zu ändern, sollten diese Kenntnisse nicht vorhanden sein."

    L.tutorial_step_2_line_1 = "DuffedUI verwendet eine eingebettete Version von oUF, programmiert von Trond (Haste) A Ekseth. Es kümmert sich um alle Einheitenfenster, Buffs und Debuffs und alle klassenspezifischen Elemente."
    L.tutorial_step_2_line_2 = "Du kannst auf wowinterface.com nach oUF suchen, um mehr über dieses Werkzeug zu erfahren."
    L.tutorial_step_2_line_3 = "Falls Du einen Heiler oder Schlachtzugsleiter spielst, möchtest Du vielleicht die Heiler-Einheitenfenster aktivieren. Diese zeigen Dir mehr Informationen über Deinen Schlachtzug an. (/heal) Als DPS-Klasse oder als Tank solltest Du die schlanke Raidansicht auswählen. (/dps) Falls Du keine der beiden Ansichten oder etwas anderes benutzen möchtest, kannst Du im Addon-Manager in der Charakterübersicht diese deaktivieren."
    L.tutorial_step_2_line_4 = "Um die Positionen der Einheitenfenster zu verschieben, tippe einfach /moveui ein."

    L.tutorial_step_3_line_1 = "DuffedUI ist ein neudesigntes Blizzard Interface. Nicht mehr, nicht weniger. Nahezu alle Funktionen des normalen Interfaces sind auch in DuffedUI verfügbar. Die einzigen Funktionen, die nicht im Standard-Interface verfügbar sind, sind automatisierte Prozesse, die nicht auf dem Bildschirm sichtbar sind. Zum Beispiel automatisches Verkaufen von grauen Gegenständen beim Händlerbesuch. Oder, ein weiteres Beispiel, automatisches Sortieren der Gegenstände in den Taschen."
    L.tutorial_step_3_line_2 = "Weil nicht jeder Sachen wie DPS-Meter, Boss Mods, Aggro-Meter und ähnliches mag, haben wir uns entschieden, dass dies die beste Möglichkeit ist. DuffedUI wurde mit der Idee entwickelt, auf alle Klassen, Rollen, Talente, Spielstile, Vorlieben der Benutzer etc. zu passen. Deswegen ist DuffedUI momentan eines der populärsten Interfaces. Es passt zum Spielstil jedes Einzelnen und ist extrem anpassbar. Es ist auch so entwickelt worden, jedem einen sehr guten Start für sein eigenes Interface zu bieten, ohne dabei auf weitere Addons angewiesen zu sein. Unzählige Spieler nutzen DuffedUI seit 2009 als Basis für ihre eigenen Interfaces. Wirf doch mal einen Blick auf die angepassten Pakete auf unserer Webseite!"
    L.tutorial_step_3_line_3 = "Für weitere Modifikationen und Funktionen kann die entsprechende Mods-Sektion auf unserer Webseite oder http://www.wowinterface.com besucht werden."
    L.tutorial_step_3_line_4 = ""

    L.tutorial_step_4_line_1 = "Um festzulegen, wie viele Aktionsleisten Du möchtest, bewege Deine Maus an den linken oder rechten Rand der untersten Aktionsleiste. Mache das Gleiche auf der rechten Seite über dem unteren und oberen Rand. Um Text aus dem Chat zu kopieren, klicke den Knopf, der beim Überfahren des Chatfensters mit der Maus in der rechten Ecke auftaucht."
    L.tutorial_step_4_line_2 = "Die Miniaturkarte ändert die Randfarbe. Sie ist Grün, wenn Du neue Post hast. Rot, wenn Du eine neue Kalendereinladung hast, und Orange bei beidem."
    L.tutorial_step_4_line_3 = "Du kannst 80% der Datenfelder linksklicken, um verschiedene Fenster von Blizzard zu öffnen. Die Datenfelder `Freunde` und `Gilde` haben auch eine Funktion bei Rechtsklick."
    L.tutorial_step_4_line_4 = "Hier sind einige Aufklappmenüs verfügbar. Bei Rechtsklick auf [X] (Schliessen) der Tasche wird ein Aufklappmenü erscheinen, um die Taschen anzuzeigen, Gegenstände zu sortieren, den Schlüsselbund anzuzeigen, etc. Ein Klicken mit dem Mausrad auf die Miniaturkarte öffnet das Mikromenü."

    L.tutorial_step_5_line_1 = "Zu guter Letzt beinhaltet DuffedUI eine Reihe nützlicher Kommandos."
    L.tutorial_step_5_line_2 = "/moveui erlaubt Dir das Bewegen vieler Fenster überall auf dem Bildschirm. /enable und /disable sind nützlich um schnell Addons ein- oder auszuschalten. /rl lädt das Interface neu. /heal aktiviert das Heiler-Raidinterface und /dps aktiviert das Tank/DPS-Raidinterface."
    L.tutorial_step_5_line_3 = "/tt erlaubt es dir, dein Ziel anzuflüstern. /rc startet einen Bereitschaftscheck. /rd löst Deine Gruppe oder Raid auf. /bags zeigt einige Funktionen, die über die Kommandozeile verfügbar sind. /ainv aktiviert automatisches Einladen per anflüstern. (/ainv off) deaktiviert dies wieder."
    L.tutorial_step_5_line_4 = "/gm öffnet das Hilfe-Fenster. /install, /reset oder /tutorial lädt dieses Installationsprogramm. /frame zeigt den Namen des Fensters unter deinem Mauszeiger und dem des übergeordneten Fensters mit einigen anderen Informationen an."

    L.tutorial_step_6_line_1 = "Die Einführung ist abgeschlossen. Du kannst sie jeder Zeit wieder starten, indem Du /tutorial eingibst."
    L.tutorial_step_6_line_2 = "Ich schlage vor, Du wirfst mal einen Blick auf die Datei DuffedUI/config/config.lua oder gibst /tukui ein, um das Interface deinen Bedürfnissen anzupassen."
    L.tutorial_step_6_line_3 = "Du kannst nun mit der Installation des Interface fortfahren, wenn diese noch nicht abgeschlossen ist oder Du das Interface auf die Standardeinstellungen zurücksetzen willst."
    L.tutorial_step_6_line_4 = ""

    L.install_step_1_line_1 = "Diese Schritte setzen die richtigen CVar Einstellungen für DuffedUI."
    L.install_step_1_line_2 = "Der erste Schritt setzt grundlegende Einstellungen."
    L.install_step_1_line_3 = "Dieser Schritt wird jedem Benutzer empfohlen, es sei denn, Du willst nur spezielle Teile der Einstellungen aktivieren."
    L.install_step_1_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_2_line_0 = "Ein weiteres Chataddon wurde gefunden. Wir überspringen diesen Schritt. Bitte drücke 'Überspringen', um mit der Installation fortzufahren."
    L.install_step_2_line_1 = "Der zweite Schritt aktiviert die richtigen Chateinstellungen."
    L.install_step_2_line_2 = "Wenn Du ein neuer Nutzer bist, ist dieser Schritt empfohlen. Wenn Du DuffedUI bereits benutzt, möchtest Du diesen Schritt vielleicht überspringen."
    L.install_step_2_line_3 = "Es ist normal, dass Deine Schriftgröße während der Aktivierung der Einstellungen etwas zu groß wirkt, dies wird am Ende der Installation wieder zurückgesetzt."
    L.install_step_2_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_3_line_1 = "Der dritte und letzte Schritt übernimmt die standardmässige Position der Frames."
    L.install_step_3_line_2 = "Dieser Schritt ist für jeden neuen Charakter empfohlen ."
    L.install_step_3_line_3 = ""
    L.install_step_3_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_4_line_1 = "Installation abgeschlossen."
    L.install_step_4_line_2 = "Bitte klicke auf 'Abschließen', um das Interface neu zu laden."
    L.install_step_4_line_3 = ""
    L.install_step_4_line_4 = "Viel Spass mit DuffedUI! Besuche uns auf http://www.duffed.net!"

    L.install_button_tutorial = "Tutorial"
    L.install_button_install = "Installation"
    L.install_button_next = "Weiter"
    L.install_button_skip = "Überspringen"
    L.install_button_continue = "Weiter"
    L.install_button_finish = "Abschließen"
    L.install_button_close = "Schließen" 
end