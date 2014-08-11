-- localization for italian made by Iceky (http://www.duffed.net/forums/profile.php?id=42201)
-- updated version by Namaless (http://www.duffed.net/forums/profile.php?id=151969)
local D, C, L = unpack(select(2, ...))

if D.client == "itIT" then
	L.AFKText_Text1 = "Mouseover minimap shows coords and locations"
	L.AFKText_Text2 = "Middle click the minimap for micromenu"
	L.AFKText_Text3 = "Right click the minimap for gatheringmenu"
	L.AFKText_Text4 = "By right-clicking on a quest or achievment at the objective tracker, you can retrieve the wowhead link."

	L.UI_Outdated = "La tua versione di DuffedUI non è aggiornata. Puoi scaricare l'ultima versione da www.duffed.net"
	L.UI_Talent_Change_Bug = "Un bug della Blizzard sta impedendo il cambio dei talenti, questo succede quando si ispeziona qualcuno. Sfortunatamente non si può fare nulla per sistemare il problema, ricaricate la propria ui e riprovate."
	L.welcome_1 = "Ciao |cffc41f3b".. D.myname.."!|r".."\n".."Grazie per utilizzare |cffc41f3bDuffedUI "..D.version.."|r. Per maggiori informazioni visita |cffc41f3bhttp://www.duffed.net|r."
	
	-- Bufftracker
	L.bufftracker_10ap = "Potenza Attacco +10%"
	L.bufftracker_10as = "Velocità Att. a Distanza e Mischia +10%"
	L.bufftracker_10sp = "Potenza Magica +10%"
	L.bufftracker_5sh = "Celerità Magica +5%"
	L.bufftracker_5csc = "Possibilità di Critico +5%"
	L.bufftracker_3kmr = "Indice Maestria +3000"
	L.bufftracker_5sai = "Forza, Agilità e Intelletto +5%"
	L.bufftracker_10s = "Tempra +10%"
	L.bufftracker_error = "ERRORE"

	-- Click2Cast
	L.click2cast_title = "Associazioni Mouse"
	
	-- worldboss
	L.worldboss_title = "World Boss(s):"
	L.worldboss_galleon = "Galleon"
	L.worldboss_sha = "Sha of Anger"
	L.worldboss_oondasta = "Oondasta"
	L.worldboss_nalak = "Nalak"
	L.worldboss_celestials = "Celestials"
	L.worldboss_ordos = "Ordos"
	L.worldboss_defeated = "Sconfitto"
	L.worldboss_undefeated = "Imbattuto"

	-- specswitcher buttons
	L.sesbutton_reload = "Ricarica l'intera UI"
	L.sesbutton_heal = "Passa al layout guaritore"
	L.sesbutton_dps = "Passa al layout dps"
	L.sesbutton_am = "Apri il gestore di AddOns"
	L.sesbutton_move = "Muovi i frames"
	L.sesbutton_kb = "Associazioni scorciatoie tastiera"

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

	L.disband = "Rimuovere il gruppo?"

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

	L.popup_disableui = "DuffedUI non funziona con questa risoluzione, vuoi disabilitare DuffedUI? (Cancella se vuoi provare un altra risoluzione)"
	L.popup_install = "La prima volta che esegui DuffedUI con questo personaggio. Devi ricaricare la tua UI per settare le barre di azione, le variabili e la chat."
	L.popup_reset = "Attenzione! Questo resetterà DuffedUI alle impostazioni di default. Vuoi procedere?"
	L.popup_2raidactive = "Sono attivi 2 raid layouts, sceglierne uno."
	L.popup_install_yes = "Yeah! (Raccomandato!)"
	L.popup_install_no = "No"
	L.popup_reset_yes = "Yeah baby!"
	L.popup_reset_no = "No"
	L.popup_fix_ab = "C'è qualcosa di sbagliato nelle tue barre di azione. Vuoi ricaricare la UI per sistemare il problema?"

	L.merchant_repairnomoney = "Non hai abbastanza soldi per riparare!"
	L.merchant_repaircost = "I tuoi oggetti sono stati riparati per"
	L.merchant_trashsell = "La tua spazzatura è stata venduta e hai guadagnato"

	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"

	L.error_noerror = "Nessun errore."

	L.unitframes_ouf_offline = "Sconnesso"
	L.unitframes_ouf_dead = "Morto"
	L.unitframes_ouf_ghost = "Fantasma"
	L.unitframes_ouf_lowmana = "MANA BASSO"
	L.unitframes_ouf_threattext = "Minaccia sul target corrente:"
	L.unitframes_ouf_threattext2 = "Threat"
	L.unitframes_ouf_offlinedps = "Sconnesso"
	L.unitframes_ouf_deaddps = "|cffff0000[DEAD]|r"
	L.unitframes_ouf_ghostheal = "FANTASMA"
	L.unitframes_ouf_deadheal = "MORTO"
	L.unitframes_ouf_gohawk = "GO HAWK"
	L.unitframes_ouf_goviper = "GO VIPER"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Wrath"
	L.unitframes_ouf_starfirespell = "Starfire"

	L.tooltip_count = "Count"

	L.bags_noslots = "Impossibile comprare altri slot!"
	L.bags_costs = "Prezzo: %.2f gold"
	L.bags_buyslots = "Compra nuovi slot con /bags purchase yes"
	L.bags_openbank = "Devi aprire la tua banca prima."
	L.bags_sort = "Ordina i tuoi zaini o la tua banca, se aperta."
	L.bags_stack = "Riempie gli slot nei tuoi zaini o nella tua banca, se aperta."
	L.bags_buybankslot = "Compra slot di banca. (Devi avere la banca aperta)"
	L.bags_search = "Cerca"
	L.bags_sortmenu = "Ordina"
	L.bags_sortspecial = "Ordina Speciale"
	L.bags_stackmenu = "Stack"
	L.bags_stackspecial = "Stack Speciale"
	L.bags_showbags = "Visualizza Zaini"
	L.bags_sortingbags = "Ordinamento finito."
	L.bags_nothingsort= "Nulla da ordinare."
	L.bags_bids = "Zaini utilizzati: "
	L.bags_stackend = "Restacking finito."
	L.bags_rightclick_search = "Click tasto destro per cercare."

	L.loot_fish = "Fishy loot"
	L.loot_empty = "slot vuoto"
	L.loot_randomplayer = "Giocatore a Caso"
	L.loot_self = "Self Loot"

	L.chat_invalidtarget = "Bersaglio non valido"

	L.mount_wintergrasp = "Wintergrasp"

	L.core_autoinv_enable = "Autoinvite ON: invite"
	L.core_autoinv_enable_c = "Autoinvite ON: "
	L.core_autoinv_disable = "Autoinvite OFF"
	L.core_wf_unlock = "WatchFrame unlock"
	L.core_wf_lock = "WatchFrame lock"
	L.core_welcome1 = "Benvenuto in |cffC495DDDuffedUI|r, versione "
	L.core_welcome2 = "Digita |cff00FFFF/uihelp|r per maggiori informazione o visita www.duffed.net"

	L.core_uihelp1 = "|cff00ff00Comandi Generali|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - Sblocca e muove gli elementi attorno allo schermo."
	L.core_uihelp3 = "|cffFF0000/rl|r - Ricaricare la UI."
	L.core_uihelp4 = "|cffFF0000/gm|r - Iniva un ticket al GM o visualizza l'help in game."
	L.core_uihelp5 = "|cffFF0000/frame|r - Rileva il nome del frame sul quale il tuo mouse si trova. (Utile per chi edita il lua)"
	L.core_uihelp6 = "|cffFF0000/heal|r - Abilita l'healing raid layout."
	L.core_uihelp7 = "|cffFF0000/dps|r - Abilita il DPS/Tank raid layout."
	L.core_uihelp8 = "|cffFF0000/bags|r - Per ordinare, comprare slot di banca o completare gli stack degli item nei tuoi zaini."
	L.core_uihelp9 = "|cffFF0000/reset|r - Reset DuffedUI alle impostazioni di default."
	L.core_uihelp10 = "|cffFF0000/rd|r - Rimuovere il raid."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Abilita autoinvito via parola su sussurro. Puoi settare la tua propia parola con `/ainv myword`"
	L.core_uihelp100 = "(Scrolla su per maggiori comandi ...)"

	L.symbol_CLEAR = "Pulisci"
	L.symbol_SKULL = "Teschio"
	L.symbol_CROSS = "Croce"
	L.symbol_SQUARE = "Quadrato"
	L.symbol_MOON = "Luna"
	L.symbol_TRIANGLE = "Triangolo"
	L.symbol_DIAMOND = "Diamante"
	L.symbol_CIRCLE = "Cerchio"
	L.symbol_STAR = "Stella"

	L.bind_combat = "Non puoi associare tasti mentre sei in combattimento."
	L.bind_saved = "Tutte le tue associazioni sono state salvate."
	L.bind_discard = "Tutte le nuove associazioni sono state scartate."
	L.bind_instruct = "Posiziona il puntatore del mouse su qualsiasi actionbutton per legarlo. Premere il tasto Esc o fare clic destro per cancellare le attuali associazioni."
	L.bind_save = "Salva associazioni"
	L.bind_discardbind = "Scarta associazioni"

	L.move_tooltip = "Muovi Tooltip"
	L.move_minimap = "Muovi Minimappa"
	L.move_watchframe = "Muovi Quests"
	L.move_gmframe = "Muovi Ticket"
	L.move_buffs = "Muovi Player Buffs"
	L.move_debuffs = "Muovi Player Debuffs"
	L.move_shapeshift = "Muovi Shapeshift/Totem"
	L.move_achievements = "Muovi Achievements"
	L.move_roll = "Muovi Loot Roll Frame"
	L.move_vehicle = "Muovi Vehicle Seat"
	L.move_extrabutton = "Bottone Aggiuntivo"

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