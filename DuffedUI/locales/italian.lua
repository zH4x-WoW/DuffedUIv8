-- localization for italian made by Iceky (http://www.duffed.net/forums/profile.php?id=42201)
-- updated version by Namaless (http://www.duffed.net/forums/profile.php?id=151969)
local D, C, L = unpack(select(2, ...))

if D.client == "itIT" then
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
	L.chat_BN_WHISPER_GET = "Da"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "Da"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "è |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "è |cffff0000offline|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Battaglia Mascotte"

	L.chat_general = "Generale"
	L.chat_trade = "Commercio"
	L.chat_defense = "Difesa Locale"
	L.chat_recrutment = "Cerca Gilda"
	L.chat_lfg = "Cerca Gruppo"

	L.datatext_notalents ="Nessun talento"
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Banda: "
	L.datatext_inc = "In Arrivo"
	L.datatext_out = "In Uscita"
	L.datatext_home = "Latenza Home:"
	L.datatext_world = "Latenza Mondo:"
	L.datatext_global = "Latenza Globale:"
	L.datatext_guild = "Gilda"
	L.datatext_noguild = "Nessuna Gilda"
	L.datatext_bags = "Zaino: "
	L.datatext_friends = "Amici"
	L.datatext_online = "Connesso: "
	L.datatext_armor = "Armatura"
	L.datatext_earned = "Guadagnato:"
	L.datatext_spent = "Speso:"
	L.datatext_deficit = "Deficit:"
	L.datatext_profit = "Profitto:"
	L.datatext_timeto = "Time to"
	L.datatext_friendlist = "Lista amici:"
	L.datatext_playersp = "SP"
	L.datatext_playerap = "AP"
	L.datatext_playerhaste = "Celerità"
	L.datatext_dps = "DPS"
	L.datatext_hps = "HPS"
	L.datatext_playerarp = "ARP"
	L.datatext_session = "Sessione: "
	L.datatext_character = "Personaggio: "
	L.datatext_server = "Server: "
	L.datatext_totalgold = "Totale: "
	L.gametooltip_gold_a = "Archeologia: "
	L.gametooltip_gold_c = "Cucina: "
	L.gametooltip_gold_jc = "Craft Gioielliere: "
	L.gametooltip_gold_dr = "Dungeon & Raids: "
	L.currencyWeekly = "Settimanale: "
	L.datatext_savedraid = "Incursioni Salvate"
	L.datatext_currency = "Valuta:"
	L.datatext_fps = " FPS & "
	L.datatext_ms = " MS"
	L.datatext_playercrit = " Crit"
	L.datatext_playerheal = " Cure"
	L.datatext_avoidancebreakdown = "Prevenzione Ripartizione"
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Boss"
	L.datatext_miss = "Mancato"
	L.datatext_dodge = "Schivato"
	L.datatext_block = "Bloccato"
	L.datatext_parry = "Parato"
	L.datatext_playeravd = "AVD: "
	L.datatext_servertime = "Ora Server: "
	L.datatext_localtime = "Ora Locale: "
	L.datatext_mitigation = "Mitigazione livello: "
	L.datatext_healing = "Cure: "
	L.datatext_damage = "Danno: "
	L.datatext_honor = "Onore: "
	L.datatext_killingblows = "Uccisioni: "
	L.datatext_ttstatsfor = "Statistiche Per "
	L.datatext_ttkillingblows = "Uccisioni:"
	L.datatext_tthonorkills = "Uccisioni Onorevoli:"
	L.datatext_ttdeaths = "Morti:"
	L.datatext_tthonorgain = "Onore Guadagnato:"
	L.datatext_ttdmgdone = "Danno:"
	L.datatext_tthealdone = "Cure:"
	L.datatext_basesassaulted = "Basi Assaltate:"
	L.datatext_basesdefended = "Basi Difese:"
	L.datatext_towersassaulted = "Torri Assaltate:"
	L.datatext_towersdefended = "Torri Difese:"
	L.datatext_flagscaptured = "Bandiere Catturate:"
	L.datatext_flagsreturned = "Bandiere Riportate:"
	L.datatext_graveyardsassaulted = "Cimiteri Assaltati:"
	L.datatext_graveyardsdefended = "Cimireti Difesi:"
	L.datatext_demolishersdestroyed = "Catapulte Distrutte:"
	L.datatext_gatesdestroyed = "Gates Distrutti:"
	L.datatext_totalmemusage = "Utilizzo Memoria Totale:"
	L.datatext_control = "Controllato a:"
	L.datatext_cta_allunavailable = "Impossibile avere informazione sul Call To Arms."
	L.datatext_cta_nodungeons = "Nessun dungeon sta offrendo il Call To Arms."
	L.datatext_carts_controlled = "Carrelli Controllati:"
	L.datatext_victory_points = "Punti Vittoria:"
	L.datatext_orb_possessions = "Orb Posseduti:"

	L.Slots = {
		[1] = {1, "Testa", 1000},
		[2] = {3, "Spalle", 1000},
		[3] = {5, "Torso", 1000},
		[4] = {6, "Fianchi", 1000},
		[5] = {9, "Polsi", 1000},
		[6] = {10, "Mani", 1000},
		[7] = {7, "Gambe", 1000},
		[8] = {8, "Piedi", 1000},
		[9] = {16, "Mano Primaria", 1000},
		[10] = {17, "Mano Secondaria", 1000},
		[11] = {18, "Ranged", 1000}
	}

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "Benveuto"
	L.install_header_2 = "1. Essenziali"
	L.install_header_3 = "2. Unitframes"
	L.install_header_4 = "3. Caratteristiche"
	L.install_header_5 = "4. Cose che devi sapere!"
	L.install_header_6 = "5. Comandi"
	L.install_header_7 = "6. Finito"
	L.install_header_8 = "1. Impostazioni essenziali"
	L.install_header_9 = "2. Sociale"
	L.install_header_10= "3. Frames"
	L.install_header_11= "4. Successo!"

	-- install
	L.install_init_line_1 = "Grazie per aver scelto DuffedUI!"
	L.install_init_line_2 = "Sarai guidato attraverso l'installazione in pochi semplici passi. Ad ogni passo, puoi decidere cosa applicare e cosa no oppure saltare il passo."
	L.install_init_line_3 = "Si è data la possibilità di vedere un breve tutorial su alcune delle caratteristiche di DuffedUI."
	L.install_init_line_4 = "Premi 'Tutorial' per essere guidato attraverso questa piccola introduzione, oppure premi 'Installa' per saltare questo passo."

	-- tutorial 1
	L.tutorial_step_1_line_1 = "Questo breve tutorial ti mostrerà alcune delle caratteristiche di DuffedUI."
	L.tutorial_step_1_line_2 = "Primo, le cose essenziali che devi sapere prima che tu possa giocare con questa UI."
	L.tutorial_step_1_line_3 = "Questa installazione è parzialmente specifica per il singolo personaggio. Mentre alcune impostazioni che verranno applicate in seguito saranno associate all'account, devi avviare lo script di installazione per ogni nuovo personaggio che esegue DuffedUI. Lo script si esegue in automatico su ogni nuovo personaggio al primo caricamento. Inoltre le opzioni si possono trovare in /DuffedUI/config/config.lua per gli utenti `Esperti` oppure digitando /duffedui in gioco per i `Nuovi` giocatori"
	L.tutorial_step_1_line_4 = "Un utente esperto è un utente che ha le abilità per utilizzare caratteristiche avanzate (ex: Lua editing) che non sono alla portata dei normali utenti. Un nuovo utente è un normale utente che necessariamente non è capace di programmare. E' consigliato per questi utilizzare lo strumento di configurazione in gioco (/duffedui) per le impostazioni che vogliono cambiare in DuffedUI."

	-- tutorial 2
	L.tutorial_step_2_line_1 = "DuffedUI include una versione di oUF (oUFDuffedUI) creata da Haste. Questa controlla tutte le unitframe dello schermo, buffs and debuffs, e gli elementi specifici della classe."
	L.tutorial_step_2_line_2 = "Puoi visitare wowinterface.com e cercare oUF per maggiori informazioni."
	L.tutorial_step_2_line_3 = "Per cambiare facilmente la posizione delle unitframe digitate /moveui."
	L.tutorial_step_2_line_4 = ""

	-- tutorial 3
	L.tutorial_step_3_line_1 = "DuffedUI ridisegna l'UI della Blizzard. Nulla di meno, nulla di più. Approssimatamente tutte le caratteristiche che vedete nella Default UI sono disponibili in DuffedUI. Le uniche caratteristiche non disponibili tramite la default UI sono quelle caratteristiche automatiche che non sono visibili a schermo, per esempio la vendita automatica delle cianfrusaglie o l'ordinamento automatico negli zaini."
	L.tutorial_step_3_line_2 = "Non a tutti piacciono cose come DPS, Boss mods, Threat meters, ecc, quindi abbiamo deciso di non includerli e secondo noi era la scelta migliore. DuffedUI è creato attorno ad una idea che vada bene per tutte le classi, ruoli e specializzazioni. Per questo DuffedUI è uno dei più popolari UI in questo momento. Si adatta a tutti gli stili di gioco ed è estremamente modificabile. E' disegnato anche per esssere un buon inizio per tutti quelli che vogliono iniziare a costruire una propia UI senza dipendere dagli addon. Dal 2009 molti utenti hanno iniziato ad usare DuffedUI come base per la loro UI. Date una occhiata alla sezione Edited Packages sul nostro sito!"
	L.tutorial_step_3_line_3 = "Gli utenti potranno visitare la nostra sezione per le mod sul nostro sito o visitando www.wowinterface.com per installare caratteristiche aggiuntive."
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "Puoi impostare quante barre vuoi, posizionati sopra con il mouse a sinistra o destra della barra azione. Fate lo stasso sulla destra. Per copiare il testo dalla chat, premete il bottone nella parte destra della chat."
	L.tutorial_step_4_line_2 = "Puoi fare tasto-sinistro sull'80% dei datatext per visualizzare i pannelli Blizzard. Amici e Gilda datatext hanno la caratteristica tastro-destro."
	L.tutorial_step_4_line_3 = "Ci sono alcuni menu a tendina disponibili. Tasto-destro su [X] (Chiudi) per gli zaini visualizzerà gli zaini, ordinamento oggetti, visualizzerà il portachiavi, ecc. Tasto-Centrale sulla minimappa visualizzerà un micro menu."
	L.tutorial_step_4_line_4 = ""

	-- tutorial 5
	L.tutorial_step_5_line_1 = "Ultima cossa, DuffedUI include una lista di comandi utili. "
	L.tutorial_step_5_line_2 = "/moveui permette di muovere i Frame per lo schermo.  /enable e /disable abilita/disabilita addons.  /rl ricarica UI."
	L.tutorial_step_5_line_3 = "/tt sussurra al target.  /rc inizia il ready check.  /rd rimuove il  party o il raid.  /bags visualizza alcune caratteristiche attraverso la command line  /ainv abilita auto invito attraverso sussurro.  (/ainv off) lo rende disabilitato"
	L.tutorial_step_5_line_4 = "/gm visualizza l'help.  /install o /tutorial carica questo installer. "

	-- tutorial 6
	L.tutorial_step_6_line_1 = "Il tutorial è completo. Lo puoi consultare in ogni momento digitando /tutorial"
	L.tutorial_step_6_line_2 = "Ti suggeriamo di dare un'occhiata a config/config.lua o digitare /duffedui per personalizzare la UI come vuoi."
	L.tutorial_step_6_line_3 = "Puoi continuare con l'installazione della UI se non è stata ancora fatta oppure puoi reimpostarla!"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "Questi passaggi applicheranno le corrette impostazioni CVar per DuffedUI."
	L.install_step_1_line_2 = "Il primo passaggio applica le impostazioni  essenziali."
	L.install_step_1_line_3 = "Questo è |cffff0000raccomandato|r per qualsiasi utente, a meno che tu voglia applicare solo parti specifiche delle impostazioni."
	L.install_step_1_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 2
	L.install_step_2_line_0 = "Un'altro addon per chat è stato trovato. Ignoreremo questo passaggio. Premete 'Salta' per continuare l'installazione."
	L.install_step_2_line_1 = "Il secondo passaggio applica le impostazioni per la chat."
	L.install_step_2_line_2 = "Se sei un nuovo utente queste impostazioni sono raccomandate. Se invece se un utente già esistente puoi saltare questo passaggio."
	L.install_step_2_line_3 = "E' normale che il carattere della chat sembri più grande dopo aver applicato queste impostazioni. Tornerà normale dopo aver completato l'installazione."
	L.install_step_2_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 3
	L.install_step_3_line_1 = "Il terzo e ultimo passaggio applica la posizione di default dei frame."
	L.install_step_3_line_2 = "Questo passaggio è |cffff0000raccomandato|r per i nuovi utenti."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Premete 'Continua' per applicare le impostazioni, oppure premete 'Salta' se volete saltare il passaggio."

	-- install step 4
	L.install_step_4_line_1 = "L'installazione è completata."
	L.install_step_4_line_2 = "Premete su 'Finito' per ricaricare la UI."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Goditi DuffedUI! Visita www.duffed.net!"

	-- buttons
	L.install_button_tutorial = "Tutorial"
	L.install_button_install = "Installa"
	L.install_button_next = "Successivo"
	L.install_button_skip = "Salta"
	L.install_button_continue = "Continua"
	L.install_button_finish = "Finito"
	L.install_button_close = "Chiudi"
end