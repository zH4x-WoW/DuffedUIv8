local D, C, L = unpack(select(2, ...))

C["general"] = {
	["autoscale"] = true,
	["uiscale"] = 0.71,
	["backdropcolor"] = { .05, .05, .05 },
	["bordercolor"] = { .125, .125, .125 },
	["classcolor"] = true,
}

C["unitframes"] = {
	["enable"] = true,
	["layout"] = 1,
	["fader"] = false,
	["minalpha"] = 0.1,
	["percent"] = true,
	["showsmooth"] = true,
	["unicolor"] = true,
	["healthbarcolor"] = {.125, .125, .125, 1},
	["deficitcolor"] = {0, 0, 0},
	["ColorGradient"] = true,
	["charportrait"] = true,
	["weakenedsoulbar"] = true,
	["showstatuebar"] = true,
	["classbar"] = true,
	["runeofpower"] = true,
	["targetauras"] = true,
	["onlyselfdebuffs"] = false,
	["combatfeedback"] = true,
	["healcomm"] = true,
	["playeraggro"] = true,
	["totdebuffs"] = false,
	["totdbsize"] = 15,
	["focusdebuffs"] = true,
	["focusbutton"] = true,
	["showtotalhpmp"] = false,
	["attached"] = false,
	["oocHide"] = true,
}

C["chat"] = {
	["enable"] = true,
	["whispersound"] = true,
	["lbackground"] = true,
	["rbackground"] = true,
	["textright"] = true,
	["fading"] = true,
}

C["castbar"] = {
	["enable"] = true,
	["petenable"] = true,
	["cblatency"] = false,
	["cbicons"] = true,
	["spark"] = true,
	["classcolor"] = false,
	["color"] = {.31, .45, .63, .5},
	["cbticks"] = true,
	["playerwidth"] = 376,
}

C["nameplate"] = {
	["enable"] = true,
	["debuffs"] = true,
	["width"] = 110,
	["height"] = 7,
	["auraswidth"] = 20,
	["aurasheight"] = 15,
	["MaxDebuffs"] = 5,
	["CastHeight"] = 5,
	["ShowComboPoints"] = true,
}

C["actionbar"] = {
	["enable"] = true,
	["rightbarvertical"] = false,
	["rightbarsmouseover"] = false,
	["petbarhorizontal"] = false,
	["petbaralwaysvisible"] = true,
	["verticalshapeshift"] = true,
	["hotkey"] = true,
	["macro"] = false,
	["buttonsize"] = 27,
	["petbuttonsize"] = 29,
	["buttonspacing"] = 4,
	["shapeshiftborder"] = true,
	["shapeshiftmouseover"] = false,
	["borderhighlight"] = false,
	--["font"] = "DuffedUI",
}

C["raid"] = {
	["enable"] = true,
	["showboss"] = true,
	["arena"] = true,
	["maintank"] = true,
	["mainassist"] = false,
	["showrange"] = true,
	["raidalphaoor"] = 0.3,
	["showsymbols"] = true,
	["aggro"] = true,
	["raidunitdebuffwatch"] = true,
	["showraidpets"] = false,
	["showplayerinparty"] = true,
	["framewidth"] = 68,
	["frameheight"] = 45,
	["pointer"] = false,
}

C["datatext"] = {
	["armor"] = 0,
	["avd"] = 0,
	["bags"] = 5,
	["battleground"] = true,
	["block"] = 0,
	["bonusarmor"] = 0,
	["calltoarms"] = 0,
	["crit"] = 0,
	["dodge"] = 0,
	["dur"] = 2,
	["friends"] = 3,
	["gold"] = 6,
	["guild"] = 1,
	["haste"] = 0,
	["honor"] = 0,
	["honorablekills"] = 0,
	["leech"] = 0,
	["mastery"] = 0,
	["micromenu"] = 0,
	["multistrike"] = 0,
	["parry"] = 0,
	["power"] = 7,
	["profession"] = 0,
	["smf"] = 4,
	["talent"] = 0,
	["versatility"] = 0,
	["wowtime"] = 8,

	["time24"] = true,
	["localtime"] = false,
	["fontsize"] = 11,
}

C["skins"] = {
	["blizzardreskin"] = true,
	["calendarevent"] = false,
}

C["cooldown"] = {
	["enable"] = true,
	["treshold"] = 8,
	["icdenable"] = true,
	["rcdenable"] = true,
	["rcdraid"] = true,
	["rcdparty"] = false,
	["rcdarena"] = false,
	["scdenable"] = true,
	["scdfsize"] = 12,
	["scdsize"] = 28,
	["scdspacing"] = 10,
	["scdfade"] = 0,
	["scddirection"] = "HORIZONTAL", -- needs update
	["scddisplay"] = "STATUSBAR",
}

C["classtimer"] = {
	["enable"] = true,											-- enable classtimer
	["targetdebuffs"] = false,									-- target debuffs above target (looks crappy imo)
	["playercolor"] = {.2, .2, .2, 1 },							-- playerbarcolor
	["targetbuffcolor"] = { 70/255, 150/255, 70/255, 1 },		-- targetbarcolor (buff)
	["targetdebuffcolor"] = { 150/255, 30/255, 30/255, 1 },		-- targetbarcolor (debuff)
	["trinketcolor"] = {75/255, 75/255, 75/255, 1 },			-- trinketbarcolor
	["height"] = 15,											-- height of classtimer bar
	["spacing"] = 1,											-- spacing of classtimer bars
	["separator"] = true,										-- enable cast separator
	["separatorcolor"] = { 0, 0, 0, .5 },						-- color of separator
	["targetdebuffsenable"] = true,								-- enable debuffbars
}

C["auras"] = {
	["player"] = true,                                  		-- enable tukui buffs/debuffs
	["consolidate"] = false,                            		-- enable downpdown menu with consolidate buff
	["flash"] = false,                                  		-- flash warning for buff with time < 30 sec
	["classictimer"] = true,                            		-- Display classic timer on player auras.
	["bufftracker"] = true,										-- enable bufftracker
	["buffnotice"] = true,										-- enable buffnotice
	["warning"] = true,											-- enable warning sound
	["wrap"] = 18,												-- set wrap of buffs
}

C["bags"] = {
	["enable"] = true,
	["bpr"] = 10,
	--["moveable"] = false,
	["scale"] = 1,
	["buttonsize"] = 28,
	["spacing"] = 4,
}

C["misc"] = {
	["gold"] = true,											-- enable shorten golddisplay
	["sesenable"] = true,										-- enable specswitcher
	["sesenablegear"] = true,									-- enable gearslots
	["sesgearswap"] = true,										-- enable automatic geearswap
	["sesset1"] = 1,											-- set 1st set (1 - 10)
	["sesset2"] = 2,											-- set 2nd set (1 - 10)
	["combatanimation"] = true,									-- enable combat animation
	["flightpoint"] = true,										-- enable flightpoint list
	["ilvlcharacter"] = true,									-- enable itemlevel display on charscreen
	["loc"] = true,												-- disable loss of control
	["acm_screen"] = true,										-- enable Achievment-screenshot
	["clickcast"] = false,										-- enable click2cast-plugin
	["Click2Cast_Filter"] = true,
	["AFKCamera"] = true,
}

C["duffed"] = {
	["dispelannouncement"] = false,								-- enable dispel announcement
	["drinkannouncement"] = false,								-- enable drink announcement
	["sayinterrupt"] = true,									-- enable interrupt announcement
	["bossicons"] = true,										-- enable alternative bossicons
	["announcechannel"] = "SAY",
	["spellannounce"] = true,									-- enable aura announcement
}

C["loot"] = {
	["lootframe"] = true,                               		-- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           		-- reskin the roll frame to fit tukui
}

C["tooltip"] = {
	["enable"] = true,                                  		-- true to enable this mod, false to disable
	["hidecombat"] = false,                             		-- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,                            		-- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 		-- hide tooltip on unitframes
	["cursor"] = false,                                 		-- tooltip via cursor only
	["ilvl"] = true,											-- enable itemlevel display for tooltip
	["ids"] = true,												-- enable spellids
	["enablecaster"] = true,									-- enable display for caster on buffs / debuffs
}

C["merchant"] = {
	["sellgrays"] = true,                               		-- automaticly sell grays?
	["autorepair"] = true,                              		-- automaticly repair?
	["sellmisc"] = true,                                		-- sell defined items automatically
	["autoguildrepair"] = true,									-- enables autoguildrepair
}

C["error"] = {
	["enable"] = true,                                  		-- true to enable this mod, false to disable
	filter = {                                          		-- what messages to not hide
		[INVENTORY_FULL] = true,                        		-- inventory is full will not be hidden by default
		[ERR_PARTY_LFG_BOOT_COOLDOWN_S] = true,
		[ERR_PARTY_LFG_BOOT_LIMIT] = true,
		[ERR_PETBATTLE_NOT_HERE] = true,
		[ERR_PETBATTLE_NOT_WHILE_IN_COMBAT] = true,
		[ERR_CANT_USE_ITEM] = true,
		[CANT_USE_ITEM] = true,
		[SPELL_FAILED_NOT_FISHABLE] = true,
	},
}

C["invite"] = { 
	["autoaccept"] = true,                              		-- auto-accept invite from guildmate and friends.
}