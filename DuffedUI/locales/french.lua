local D, C, L = unpack(select(2, ...))

if D.client == "frFR" then
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
	L.chat_BN_WHISPER_GET = "De"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "G"
	L.chat_PARTY_GUIDE_GET = "G"
	L.chat_PARTY_LEADER_GET = "G"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "De"
	L.chat_FLAG_AFK = "[ABS]"
	L.chat_FLAG_DND = "[NPD]"
	L.chat_FLAG_GM = "[MJ]"
	L.chat_ERR_FRIEND_ONLINE_SS = "s'est |cff298F00connecté|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "s'est |cffff0000déconnecté|r"
	L.chat_PET_BATTLE_COMBAT_LOG = "Pet Battle"
	
	L.chat_general = "Général"
	L.chat_trade = "Commerce"
	L.chat_defense = "DéfenseLocale"
	L.chat_recrutment = "RecrutementDeGuilde"
	L.chat_lfg = "RechercheDeGroupe"

	L.datatext_notalents ="Aucun talents"
	L.datatext_download = "Téléchargement : "
	L.datatext_bandwidth = "Bande passante : "
	L.datatext_inc = "Incoming"
	L.datatext_out = "Outgoing"
	L.datatext_home = "Home Latency:"
	L.datatext_world = "World Latency:"
	L.datatext_global = "Global Latency:"
	L.datatext_guild = "Guilde"
	L.datatext_noguild = "Pas de Guilde"
	L.datatext_bags = "Sacs : "
	L.datatext_friends = "Amis"
	L.datatext_online = "En ligne : "
	L.datatext_armor = "Armure"
	L.datatext_earned = "Gagné : "
	L.datatext_spent = "Dépensé : "
	L.datatext_deficit = "Déficit : "
	L.datatext_profit = "Profit : "
	L.datatext_timeto = "Temps restant"
	L.datatext_friendlist = "Liste d'amis : "
	L.datatext_playersp = "sp"
	L.datatext_playerap = "ap"
	L.datatext_playerhaste = "hâte"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "arp"
	L.datatext_session = "Session : "
	L.datatext_character = "Personnage : "
	L.datatext_server = "Serveur : "
	L.datatext_totalgold = "Total : "
	L.gametooltip_gold_a = "Archaeology: "
	L.gametooltip_gold_c = "Cooking: "
	L.gametooltip_gold_jc = "Jewelcrafting: "
	L.gametooltip_gold_dr = "Dungeon & Raids: "
	L.currencyWeekly = "Hebdomadaire: "
	L.datatext_savedraid = "Raid(s) enregistré(s)"
	L.datatext_currency = "Monnaie : "
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " crit"
	L.datatext_playerheal = " heal"
	L.datatext_avoidancebreakdown = "Évitement"
	L.datatext_lvl = "lvl"
	L.datatext_boss = "boss"
	L.datatext_miss = "Coup raté"
	L.datatext_dodge = "Esquive"
	L.datatext_block = "Bloquer"
	L.datatext_parry = "Parade"
	L.datatext_playeravd = "avd : "
	L.datatext_servertime = "Heure Serveur : "
	L.datatext_localtime = "Heure Locale : "
	L.datatext_mitigation = "Mitigation par Level : "
	L.datatext_healing = "Soins : "
	L.datatext_damage = "Dégâts : "
	L.datatext_honor = "Honneur : "
	L.datatext_killingblows = "Coups fatals : "
	L.datatext_ttstatsfor = "Statistiques pour "
	L.datatext_ttkillingblows = "Coups fatals : "
	L.datatext_tthonorkills = "Victoires honorables : "
	L.datatext_ttdeaths = "Morts : "
	L.datatext_tthonorgain = "Points d'honneur gagnés : "
	L.datatext_ttdmgdone = "Dégâts effectués : "
	L.datatext_tthealdone = "Soins prodigués : "
	L.datatext_basesassaulted = "Bases Attaquées : "
	L.datatext_basesdefended = "Bases Défendues : "
	L.datatext_towersassaulted = "Tours Attaquées : "
	L.datatext_towersdefended = "Tours Défendues : "
	L.datatext_flagscaptured = "Drapeaux Capturés : "
	L.datatext_flagsreturned = "Drapeaux Récupérés : "
	L.datatext_graveyardsassaulted = "Cimetières Attaqués : "
	L.datatext_graveyardsdefended = "Cimetières Défendus : "
	L.datatext_demolishersdestroyed = "Démolisseurs Détruits : "
	L.datatext_gatesdestroyed = "Portes Détruites : "
	L.datatext_totalmemusage = "Utilisation Totale de la Mémoire : "
	L.datatext_control = "Controlé par : "
	L.datatext_cta_allunavailable = "Impossible de récupérer les informations d'appel aux armes."
	L.datatext_cta_nodungeons = "Aucun donjon offre actuellement d'appel aux armes."
	L.datatext_carts_controlled = "Chariots contrôlée:"
	L.datatext_victory_points = "Points de Victoire:"
	L.datatext_orb_possessions = "Orbes en possession:"

	L.Slots = {
	  [1] = {1, "Tête", 1000},
	  [2] = {3, "Épaule", 1000},
	  [3] = {5, "Plastron", 1000},
	  [4] = {6, "Ceinture", 1000},
	  [5] = {9, "Poignets", 1000},
	  [6] = {10, "Mains", 1000},
	  [7] = {7, "Jambes", 1000},
	  [8] = {8, "Bottes", 1000},
	  [9] = {16, "Main droite", 1000},
	  [10] = {17, "Main gauche", 1000},
	  [11] = {18, "À Distance", 1000}
	}

	-- tuto/install
	L.install_header_1 = "Bienvenue"
	L.install_header_2 = "1. Principal"
	L.install_header_3 = "2. Unitframes"
	L.install_header_4 = "3. Caractéristiques"
	L.install_header_5 = "4. Ce que vous devez savoir !"
	L.install_header_6 = "5. Commandes"
	L.install_header_7 = "6. Terminé"
	L.install_header_8 = "1. Options Principales"
	L.install_header_9 = "2. Social"
	L.install_header_10= "3. Cadres"
	L.install_header_11= "4. Succès !"

	L.install_init_line_1 = "Merci d'avoir choisi DuffedUI !"
	L.install_init_line_2 = "Vous serez guidé au travers du processus d'installation par quelques étapes simples. A chaque étape, vous pouvez décider d'appliquer ou non les paramètres présentés."
	L.install_init_line_3 = "Vous avez également la possibilité de voir un bref tutoriel sur les différentes caractéristiques de DuffedUI."
	L.install_init_line_4 = "Appuyez sur le bouton 'Tutoriel' pour être guidé au travers de cette petite introduction, ou appuyez sur 'Installation' pour passer cette étape."

	L.tutorial_step_1_line_1 = "Ce bref tutoriel vous montrera quelques caractéristiques de DuffedUI."
	L.tutorial_step_1_line_2 = "Tout d'abord, l'essentiel de ce que vous devez savoir avant de pouvoir jouer avec cette interface."
	L.tutorial_step_1_line_3 = "Cette installation est partiellement spécifique par personnage. Bien que certains paramètres qui seront appliqués plus tard sont pour tout votre compte, vous devez lancer le script d'installation pour chaque nouveau personnage utilisant DuffedUI. Le script est montré automatiquement au chargement de chaque nouveau personnage la première fois. En outre, les options peuvent être trouvées dans /DuffedUI/config/config.lua pour les utilisateurs confirmés ou en tapant /duffedui en jeu pour les autres."
	L.tutorial_step_1_line_4 = "Un utilisateur confirmé est un utilisateur d'ordinateur qui est capable d'utiliser des fonctions avancées (ex: édition Lua ) lesquelles ne sont pas à portée d'un utilisateur normal. Un utilisateur de base est un utilisateur normal et qui n'est forcément capable de programmer. Il leur est recommandé d'utiliser l'outil de configuration en jeu (/duffedui) pour paramétrer ce qu'ils veulent afficher sur DuffedUI."

	L.tutorial_step_2_line_1 = "DuffedUI comprend une version embarquée de oUF créé par Trond (Haste) A Ekseth. Ceci manipule beaucoup de Unitframe sur l'écran, les buffs et debuffs, et les éléments spécifiques à une classe."
	L.tutorial_step_2_line_2 = "Vous pouvez vous rendre sur wowinterface.com et cherchez après oUF pour plus d'information sur cet outil."
	L.tutorial_step_2_line_3 = "Si vous jouez comme soigneur ou leader de raid, vous pouvez activer l'interface de soigneur. Elle affiche beaucoup plus d'informations sur le raid. (/heal) Un dps ou tank utilisera l'affichage simple du raid. (/dps) Si vous ne voulez afficher aucun d'eux et utiliser un autre addon, vous pouvez les désactiver via le gestionnaire d'addon au chargement des personnages."
	L.tutorial_step_2_line_4 = "Vous avez juste à taper /moveui pour bouger les Unitframes facilement."

	L.tutorial_step_3_line_1 = "DuffedUI est une interface refaite de Blizzard. Ni plus, ni moins. A peu près toutes les caractéristiques que vous pouvez voir sur l'interface de base sont disponibles par DuffedUI. Les seules caractéristiques non disponible sur l'interface par défaut sont quelques caractéristiques automatiques non réellement visibles à l'écran, par exemple vente auto des objets gris chez un marchand ou trier les objets dans les sacs."
	L.tutorial_step_3_line_2 = "Parce que tout le monde n'apprécie pas des addons comme les DPS meters, Boss mods, gestion des menaces, etc, nous jugeons que c'est la meilleure chose à faire. DuffedUI est réalisé dans l'idée de s'adapter au maximum de classes, rôles, spécialisation, type de jeu, goûts des joueurs, etc. C'est pourquoi DuffedUI est l'une des interfaces les plus populaires du moment. Cela convient à tout style de jeu et est éditable à souhait. C'est aussi présenté afin d'être un bon départ pour celui qui veut faire sa propre interface personnalisée sans dépendre d'autres addons. Des tonnes d'utilisateurs depuis 2009 utilisent désormais DuffedUI comme une base pour leur propre interface. Allez faire un tour dans notre section 'Edited Packages' sur notre site !"
	L.tutorial_step_3_line_3 = "Les utilisateurs peuvent visiter notre section 'extra mods' sur notre site ou visiter WoWInterface."
	L.tutorial_step_3_line_4 = ""

	L.tutorial_step_4_line_1 = "Pour définir le nombre de barres que vous voulez, placez votre souris sur la gauche, droite ou le dessous du cadre de fond de la barre d'action. Faites la même chose sur la droite de l'écran, en haut ou en bas du cadre. Pour copier le texte de la fenêtre de dialogue, cliquez sur le bouton vu en passant la souris sur le coin droit de la fenêtre de discussion."
	L.tutorial_step_4_line_2 = "Les bords de la mini carte changent de couleur. C'est vert lorsque vous avez du courrier, rouge lorsque vous avez une nouvelle invitation calendrier, orange lorsque ce sont les deux."
	L.tutorial_step_4_line_3 = "Vous pouvez faire un clic gauche sur 80% des données textes pour afficher divers panneaux de Blizzard. Les données textes Amis et Guilde ont des caractéristiques via clic droit aussi."
	L.tutorial_step_4_line_4 = "Il y a quelques menus contextuels disponibles. Clic droit sur [X] (Fermer) de la fenêtre des sacs vous montrera un menu qui permet de montrer les sacs, les trier, montrer les clés, etc. Clic du milieu sur la mini carte permet d'afficher le micro menu."

	L.tutorial_step_5_line_1 = "Enfin, DuffedUI comprend des commandes utiles. Voici la liste ci-dessous."
	L.tutorial_step_5_line_2 = "/moveui vous permet de bouger beaucoup de cadres n'importe où à l'écran. /enable et /disable sont utilisés pour (dés)activer des addons. /rl recharge l'interface. /heal active l'interface de raid pour soigneur et /dps active l'interface raid pour dps/tank."
	L.tutorial_step_5_line_3 = "/tt vous permet du chuchoter à votre cible. /rc permet de demander si tout le monde est prêt. /rd dissoud un groupe ou raid. /bags affiche quelques options disponibles par ligne de commande. /ainv active l'auto-invitation en vous chuchotant. (/ainv off) pour le désactiver"
	L.tutorial_step_5_line_4 = "/gm affiche la fenêtre d'aide. Les commandes /install, /reset ou /tutorial lancent cette installation. /frame affiche le nom et parent du cadre sous le curseur avec des informations supplémentaires."

	L.tutorial_step_6_line_1 = "Le tutoriel est terminé. Vous pouvez le reconsulter à tout moment en tapant /tutorial."
	L.tutorial_step_6_line_2 = "Je vous suggère de regarder le fichier /config/config.lua ou en tapant /duffedui pour customiser l'interface selon vos besoins."
	L.tutorial_step_6_line_3 = "Vous pouvez maintenant continuer l'installation de l'interface si ce n'est pas encore fait ou si vous voulez remettre le tout par défaut !"
	L.tutorial_step_6_line_4 = ""

	L.install_step_1_line_1 = "Ces étapes appliqueront les paramètres CVar corrects pour DuffedUI."
	L.install_step_1_line_2 = "La première étape applique les paramètres essentiels."
	L.install_step_1_line_3 = "C'est |cffff0000recommandé|r pour tout utilisateur, à moins que vous ne vouliez appliquer qu'une partie spécifique des paramètres."
	L.install_step_1_line_4 = "Cliquez sur 'Continuer' pour appliquer les paramètres, ou cliquez sur 'Passer' si vous voulez passer cette étape."

	L.install_step_2_line_0 = "Un autre addon de discussion a été trouvé. Nous allons ignorer cette étape. Appuyez sur 'Passer' pour continuer l'installation."
	L.install_step_2_line_1 = "La seconde étape applique les paramètres corrects des fenêtres de discussion."
	L.install_step_2_line_2 = "Si vous êtes un nouvel utilisateur, cette étape est recommandée. Si vous êtes un utilisateur habitué, vous pouvez passer cette étape."
	L.install_step_2_line_3 = "Il est normal que la police de discussion apparaisse trop grande lors de l'application de ces paramètres. Cela redeviendra normal une fois l'installation terminée."
	L.install_step_2_line_4 = "Cliquez sur 'Continuer' pour appliquer les paramètres, ou cliquez sur 'Passer' si vous voulez passer cette étape."

	L.install_step_3_line_1 = "La troisième et dernière étape applique le positionnement des cadres par défaut."
	L.install_step_3_line_2 = "Cette étape est |cffff0000recommandée|r pour tout nouvel utilisateur."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Cliquez sur 'Continuer' pour appliquer les paramètres, ou cliquez sur 'Passer' si vous voulez passer cette étape."

	L.install_step_4_line_1 = "Installation terminée."
	L.install_step_4_line_2 = "Appuyez sur le bouton 'Terminer' pour recharger l'interface."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Bon Jeu avec DuffedUI ! Et venez visiter http://www.duffed.net pour les MàJ et les informations sur votre interface DuffedUI !"

	L.install_button_tutorial = "Tutoriel"
	L.install_button_install = "Installation"
	L.install_button_next = "Suivant"
	L.install_button_skip = "Passer"
	L.install_button_continue = "Continuer"
	L.install_button_finish = "Terminer"
	L.install_button_close = "Fermer"
end
