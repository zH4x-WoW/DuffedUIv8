local D, C, L = unpack(select(2, ...))

if D.Client == 'deDE' then
	L['move'] = {
		['tooltip'] = 'Bewege Tooltip',
		['minimap'] = 'Bewege Minimap',
		['watchframe'] = 'Shift + Click um die Quests zu bewegen',
		['gmframe'] = 'Bewege Tickets',
		['buffs'] = 'Bewege Stärkungszauber (Spieler)',
		['debuffs'] = 'Bewege Schwächungszauber (Spieler)',
		['shapeshift'] = 'Bewege Haltungsleiste',
		['achievements'] = 'Bewege Erfolge',
		['roll'] = 'Bewege Würfelfenster',
		['vehicle'] = 'Bewege Fahrzeuganzeige',
		['extrabutton'] = 'Bewege Extrabutton',
		['bar1'] = 'Bewege Leiste 1',
		['bar2'] = 'Bewege Leiste 2',
		['bar3'] = 'Bewege Leiste 3',
		['bar4'] = 'Bewege Leiste 4',
		['bar5'] = 'Bewege Leiste 5',
		['bar5_1'] = 'Bewege Leiste 5',
		['pet'] = 'Bewege Begleiterleiste',
		['player'] = 'Bewege Zauberleiste (Spieler)',
		['target'] = 'Bewege Zauberleiste (Ziel)',
		['classbar'] = 'Bewege Klassenleiste',
		['raid'] = 'Bewege RaidUtility',
		['rcd'] = 'Bewege RaidCD',
		['spell'] = 'Bewege SpellCooldowns',
		['xp-bar'] = 'Bewege XP-Leiste',
		['artifact-bar'] = 'Bewege Artefakt-XP-Leiste',
	}

	L['symbol'] = {
		['clear'] = 'Kein Zeichen',
		['skull'] = 'Totenkopf',
		['cross'] = 'Kreuz',
		['square'] = 'Quadrat',
		['moon'] = 'Mond',
		['triangle'] = 'Dreieck',
		['diamond'] = 'Diamant',
		['circle'] = 'Kreis',
		['star'] = 'Stern',
	}

	L['ui'] = {
		['outdated'] = 'Deine Version von DuffedUI ist veraltet. Du kannst die neuste Version auf |cffc41f3http://www.wowinterface.com|r herunter laden.',
		['disableui'] = 'DuffedUI funktioniert mit Deiner Auflösung nicht. Möchtest Du DuffedUI deaktivieren? (Abbrechen, wenn Du es mit einer anderen Auflösung probieren möchtest)',
		['fix_ab'] = 'Etwas stimmt nicht mit den Aktionsleisten. Möchtest Du das UI neu laden um diesen Fehler zu beheben?',
		['combattrue'] = '+ Kampfbeginn',
		['combatfalse'] = '- Kampfende',
	}

	L['install'] = {
		['header01'] = 'Willkommen',
		['header02'] = '1. Grundlegendes',
		['header03'] = '2. Einheitenfenster',
		['header04'] = '3. Features',
		['header05'] = '4. Dinge die man wissen sollte!',
		['header06'] = '5. Chatbefehle',
		['header07'] = '6. Beendet',
		['header08'] = '1. Grundlegende Einstellungen',
		['header09'] = '2. Soziales',
		['header10'] = '3. Fenster',
		['header11'] = '4. Erfolg!',

		['continue_skip'] = "Klicke auf 'Weiter' um die Einstellungen zu übernehmen, oder 'Überspringen', wenn Du diesen Schritt überspringen möchtest.",
		['initline1'] = 'Danke das Du DuffedUI gewählt hast!',
		['initline2'] = 'Du wirst mit einigen wenigen Schritten durch den Installationsprozess begleitet. Bei jedem Schritt kannst Du entscheiden, ob Du die angegebenen Einstellungen übernehmen, oder überspringen möchtest.',
		['initline3'] = 'Du hast ebenfalls die Möglichkeit Dir ein Tutorial anzeigen zu lassen, welches Dir die Features von DuffedUI aufzeigt.',
		['initline4'] = "Drücke auf 'Tutorial' um Dir diese kleine Einleitung anzeigen zu lassen, oder drücke 'Installieren', um diesen Schritt zu überspringen.",

		['step1line1'] = 'Dieser Schritt fügt die korrekten CVar-Einstellungen für DuffedUI hinzu.',
		['step1line2'] = 'Der erste Schritt fügt grundlegende Einstellungen hinzu.',
		['step1line3'] = 'Das wird für alle Benutzer des DuffedUI |cffff0000empfohlen|r, es sei denn Du möchtest nur bestimmte Einstellungen anwenden.',

		['step2line0'] = "Ein anderes Chat-Addon wurde gefunden. Dieser Schritt wird ignoriert! Bitte klicke auf 'Überspringen'.",
		['step2line1'] = 'Der zweite Schritt wendet die korrekten Chateinstellungen an.',
		['step2line2'] = 'Wenn Du ein neuer Benutzer des DuffedUI bist, wird dieser Schritt empfohlen. Bist du bereits Benutzer des DuffedUI, kannst Du auch diesen Schritt überspringen.',
		['step2line3'] = 'Es ist normal, wenn die Schrift im Chat zu groß erscheint, bevor alle Einstellungen übernommen wurden.  Die Schrift kehrt zum normalen Aussehen zurück, sobald die Installation abgeschlossen ist.',

		['step3line1'] = 'Der dritte und letzte Schritt positioniert alle Elemente korrekt.',
		['step3line2'] = 'Dieser Schritt wird für alle neuen Benutzer des DuffedUI |cffff0000empfohlen|r.',
		['step3line3'] = '',

		['step4line1'] = 'Die Installation wurde erfolgreich abgeschlossen.',
		['step4line2'] = "Bitte klicke auf den Button 'Beenden' um das UI neu zu laden.",
		['step4line3'] = '',
		['step4line4'] = 'Geniesse Dein DuffedUI! Und besuche uns doch mal auf |cfff41f3http://www.wowinterface.com|r!',
	}

	L['binds'] = {
		['c2c_title'] = 'Mausbelegung',
		['combat'] = 'Während eines Kampfes kannst Du keine Tasten belegen',
		['saved'] = 'Alle Tastenbelegungen wurden gespeichert',
		['discard'] = 'Alle neuen Tastenbelegungen wurden verworfen.',
		['text'] = 'Bewege die Maus über jeden beliebigen Aktionsbutton um ihn zu belegen. Drücke ESC, oder die rechte Maustaste, um die Belegung zu verwerfen.',
		['save'] = 'Belegung speichern',
		['discardbind'] = 'Belegung verwerfen',
	}

	L['loot'] = {
		['tt_count'] = 'Anzahl',
		['fish'] = 'Schräger Loot',
		['random'] = 'Zufälliger Spieler',
		['self'] = 'Eigene Beute',
		['repairmoney'] = 'Dir fehlt das nötige Kleingeld um alles zu reparieren!',
		['repaircost'] = 'Alle Gegenstände wurden repariert für einen Gesamtpreis von',
		['trash'] = 'Alle grauen Gegenstände wurden verkauft. Deine Einnahmen belaufen sich auf',
	}

	L['buttons'] = {
		['ses_reload'] = 'Das gesamte UI neu laden',
		['ses_move'] = 'Fenster entsperren um sie zu bewegen',
		['ses_kb'] = 'Tastenbelegung einstellen',
		['ses_dfaq'] = 'DuffedUI F.A.Q. aufrufen',
		['ses_switch'] = 'Wechsel zwischen den Raidlayouts',
		['tutorial'] = 'Tutorial',
		['install'] = 'Installieren',
		['next'] = 'Nächste',
		['skip'] = 'Überspringen',
		['continue'] = 'Weiter',
		['finish'] = 'Beenden',
		['close'] = 'Schliessen',
		['treasure'] = 'Zeige Schatztruhen',
	}

	L['errors'] = {
		['noerror'] = 'Derzeit keine Fehler.'
	}

	L['uf'] = {
		['offline'] = 'Offline',
		['dead'] = '|cffff0000[TOT]|r',
		['ghost'] = 'GEIST',
		['lowmana'] = 'Wenig Mana',
		['threat1'] = 'Bedrohung auf aktuellem Ziel:',
		['wrath'] = 'Zorn',
		['starfire'] = 'Sternenfeuer',
	}

	L['group'] = {
		['autoinv_enable'] = 'Automatische Einladung AN',
		['autoinv_enable_custom'] = 'Automatische Einladung: ',
		['autoinv_disable'] = 'Automatische Einladung AUS',
		['disband'] = 'Gruppe auflösen?',
	}

	L['chat'] = {
		['instance_chat'] = 'I',
		['instance_chat_leader'] = 'IL',
		['guild'] = 'G',
		['officer'] = 'O',
		['party'] = 'P',
		['party_leader'] = 'P',
		['raid'] = 'R',
		['raid_leader'] = 'RL',
		['raid_warning'] = 'RW',
		['flag_afk'] = '[AFK]',
		['flag_dnd'] = '[DND]',
		['petbattle'] = 'Haustierkampf',
		['defense'] = 'LokaleVerteidigung',
		['recruitment'] = 'Gildenrekrutierung',
		['lfg'] = 'SucheNachGruppe',
	}

	L['dt'] = {
		['talents'] ='Keine Talente',
		['download'] = 'Download: ',
		['bandwith'] = 'Bandbreite: ',
		['inc'] = 'Eingehend:',
		['out'] = 'Ausgehend:',
		['home'] = 'Heimlatenz:',
		['world'] = 'Serverlatenz:',
		['global'] = 'Globale Latenz:',
		['noguild'] = 'Keine Gilde',
		['earned'] = 'Verdient',
		['spent'] = 'Ausgegeben:',
		['deficit'] = 'Unterschied:',
		['profit'] = 'Gewinn:',
		['timeto'] = 'Zeit bis',
		['sp'] = 'ZM',
		['ap'] = 'AK',
		['session'] = 'Sitzung: ',
		['character'] = 'Charakter: ',
		['server'] = 'Server: ',
		['dr'] = 'Instanzen & Schlachtzüge: ',
		['raid'] = 'SchlachtzugsID(s)',
		['crit'] = ' Krit',
		['avoidance'] = 'Vermeidungsaufschlüsselung',
		['lvl'] = 'lvl',
		['avd'] = 'vdg: ',
		['server_time'] = 'Server Zeit: ',
		['local_time'] = 'Lokale Zeit: ',
		['mitigation'] = 'Milderung durch Level: ',
		['stats'] = 'Werte für ',
		['dmgdone'] = 'Schaden gemacht:',
		['healdone'] = 'Gewirkte Heilung:',
		['basesassaulted'] = 'Basen angegriffen:',
		['basesdefended'] = 'Basen verteidigt:',
		['towersassaulted'] = 'Türme angegriffen:',
		['towersdefended'] = 'Trüme verteidigt:',
		['flagscaptured'] = 'Flaggen eingenommen:',
		['flagsreturned'] = 'Flaggen zurückgebracht:',
		['graveyardsassaulted'] = 'Friedhöfe angegriffen:',
		['graveyardsdefended'] = 'Friedhöfe verteidigt:',
		['demolishersdestroyed'] = 'Verwüster zerstört:',
		['gatesdestroyed'] = 'Tore zerstört:',
		['totalmemusage'] = 'Total benutzter Speicher:',
		['control'] = 'Kontrolliert von:',
		['cta_allunavailable'] = "Kann keine Daten für 'Ruf zu den Waffen' erhalten.",
		['cta_nodungeons'] = "Keine Instanz bietet derzeit eine 'Ruf zu den Waffen' Belohnung an.",
		['carts_controlled'] = 'Wagen kontrolliert:',
		['victory_points'] = 'Siegpunkte:',
		['orb_possessions'] = 'Orbbesitz:',
		['goldbagsopen'] = '|cffC41F3BTaschen: Linksklick|r',
		['goldcurrency'] = '|cffC41F3BWährungsmenü: Rechtsklick|r',
		['goldreset'] = '|cffC41F3BDaten zurücksetzen: Shift halten + Rechtsklick|r',
		['notalents'] = 'Keine Talente',
		['systemleft'] = '|cffC41F3BLinksklick: Öffnet das PvE-Fenster|r',
		['systemright'] = '|cffC41F3BRechtsklick: Speichernutzung bereinigen|r',
		['prof'] = 'Berufe',
		['profless'] = 'Berufslos',
		['proftooltip'] = 'Beliebiger Klick öffnet die Berufsübersicht',
		['specmenu'] = 'Spezialisierungsauswahl',
		['specerror'] = 'Diese Spezialisierung ist bereits aktiv!',
		['specdata'] = 'Spez: ',
		['reward'] = 'Belohnung: ',
		['noorderhallnowo'] = 'Ordenshalle',
		['noorderhallwo'] = 'Ordenshalle+',
		['noorderhall'] = 'Du hast Deine Ordenshalle noch nicht freigeschaltet, nun aber los!',
		['noquickjoin'] = 'Niemand aus deiner Freundesliste sucht momentan nach einer Gruppe.',
		['report'] = 'Mission(en) Report:',
		['missions'] = 'Missionen in Arbeit',
		['nomissions'] = 'Keine Missionen',
		['Rank'] = "Rang",
		['FarseerOri'] = "Scharfseher Ori",
		['HunterAkana'] = "Jäger Akana",
		['BladesmanInowari'] = "Klingenkämpfer Inowari",
		['NeriSharpfin'] = "Neri Sharffinne",
		['PoenGillbrack'] = "Poen Kiembrack",
		['VimBrineheart'] = "Vim Salzherz",
		['NazjatarFollowerXP'] = "Nazjatar Begleiter XP",
	}

	L['Slots'] = {
		[1] = {1, 'Kopf', 1000},
		[2] = {3, 'Schultern', 1000},
		[3] = {5, 'Brust', 1000},
		[4] = {6, 'Gürtel', 1000},
		[5] = {9, 'Handgelenke', 1000},
		[6] = {10, 'Hände', 1000},
		[7] = {7, 'Beine', 1000},
		[8] = {8, 'Füße', 1000},
		[9] = {16, 'Waffenhand', 1000},
		[10] = {17, 'Schildhand', 1000},
		[11] = {18, 'Distanzwaffe', 1000}
	}

	L['xpbar'] = {
		['xptitle'] = 'Erfahrung',
		['xp'] = 'XP: %s/%s (%d%%)',
		['xpremaining'] = 'Benötigt: %s',
		['xprested'] = '|cffb3e1ffAusgeruht: %s (%d%%)',

		['fctitle'] = 'Ansehen: %s',
		['standing'] = 'Stand: |c',
		['fcrep'] = 'Ruf: %s/%s (%d%%)',
		['fcremaining'] = 'Verbleibend: %s',

		['hated'] = 'Hasserfüllt',
		['hostile'] = 'Feindseelig',
		['unfriendly'] = 'Unfreundlich',
		['neutral'] = 'Neutral',
		['friendly'] = 'Freundlich',
		['honored'] = 'Wohlwollend',
		['revered'] = 'Respektvoll',
		['exalted'] = 'Ehrfürchtig',
	}
	
	L['azeriteBar'] = {
		['xptitle'] = 'AM:',
		['xpremaining'] = 'Verbleibend:',
	}
	
	L['tooltip'] = {
		['applied'] = 'Angewandt von ',
		['changelog'] = 'Schließe Changelog',
	}

	L['errortext'] = {
		['LeftSideBar'] = 'Linke Sidebar ist deaktiviert!',
		['RightSideBar'] = 'Rechte Sidebars ist deaktiviert!',
	}

	L['misc'] = {
		['Resolution'] = 'Du hast Auto-Skalierung aktiviert und es wurde ein Wechsel der Auflösung registriert. Möchtest du den Client jetzt neustarten?'
	}
end