local D, C, L = unpack(select(2, ...))

C["general"] = {
	["autoscale"] = true,
	["uiscale"] = 0.71,
	["backdropcolor"] = { .05, .05, .05 },
	["bordercolor"] = { .125, .125, .125 },
	["classcolor"] = true,
}

C["font"] = {
	["actionbars"] = "DuffedUI",
	["auras"] = "DuffedUI",
	["classtimer"] = "DuffedUI",
	["ses"] = "DuffedUI",
	["datatext"] = "DuffedUI",
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
	["attached"] = false,
	["oocHide"] = true,
	["playermodel"] = "Model",
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
	["cblatency"] = true,
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
	["sidebars"] = false,
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
}

C["classtimer"] = {
	["enable"] = true,
	["targetdebuffs"] = false,
	["playercolor"] = {.2, .2, .2, 1 },
	["targetbuffcolor"] = { 70/255, 150/255, 70/255, 1 },
	["targetdebuffcolor"] = { 150/255, 30/255, 30/255, 1 },
	["trinketcolor"] = {75/255, 75/255, 75/255, 1 },
	["height"] = 15,
	["spacing"] = 1,
	["separator"] = true,
	["separatorcolor"] = { 0, 0, 0, .5 },
	["targetdebuffsenable"] = true,
}

C["auras"] = {
	["player"] = true,
	["consolidate"] = false,
	["flash"] = false,
	["classictimer"] = true,
	["bufftracker"] = true,
	["buffnotice"] = true,
	["warning"] = true,
	["wrap"] = 18,
}

C["bags"] = {
	["enable"] = true,
	["bpr"] = 10,
	["movable"] = true,
	["scale"] = 1,
	["buttonsize"] = 28,
	["spacing"] = 4,
}

C["misc"] = {
	["gold"] = true,
	["sesenable"] = true,
	["sesenablegear"] = true,
	["sesgearswap"] = true,
	["sesset1"] = 1,
	["sesset2"] = 2,
	["combatanimation"] = true,
	["flightpoint"] = true,
	["ilvlcharacter"] = true,
	["loc"] = true,
	["acm_screen"] = true,
	["clickcast"] = true,
	["Click2Cast_Filter"] = true,
	["AFKCamera"] = true,
}

C["duffed"] = {
	["dispelannouncement"] = false,
	["drinkannouncement"] = false,
	["sayinterrupt"] = true,
	["bossicons"] = true,
	["announcechannel"] = "SAY",
	["spellannounce"] = true,
}

C["loot"] = {
	["lootframe"] = true,
	["rolllootframe"] = true,
}

C["tooltip"] = {
	["enable"] = true,
	["hidecombat"] = false,
	["hidebuttons"] = false,
	["hideuf"] = false,
	["ilvl"] = true,
	["ids"] = true,
	["enablecaster"] = true,
}

C["merchant"] = {
	["sellgrays"] = true,
	["autorepair"] = true,
	["sellmisc"] = true,
	["autoguildrepair"] = true,
}

C["error"] = {
	["enable"] = true,
	filter = {
		[INVENTORY_FULL] = true,
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
	["autoaccept"] = true,
}