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
	["movableclassbar"] = false,
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
}

C["raid"] = {
	["enable"] = true,
	["showboss"] = true,
	["arena"] = true,
	["maintank"] = true,
	["mainassist"] = false,
	["showrange"] = true,                               		-- show range opacity on raidframes
	["raidalphaoor"] = 0.3,                             		-- alpha of unitframes when unit is out of range
	["showsymbols"] = true,	                            		-- show symbol.
	["aggro"] = true,                                   		-- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,                     		-- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,                    			-- enable vertical grow on health bar for grid mode.
	["gridscale"] = 1,                                  		-- set the healing grid scaling
	["gridvertical"] = false,                            		-- grid group displayed vertically
	["showraidpets"] = true,                            		-- show pets in raid unit frames
	["showgroupresurrect"] = false,                     		-- show ressurect icon on raid frames
	["showplayerinparty"] = false,								-- show player in party
	
	
	["framewidth"] = 65,										-- framewidth for raidframe
	["frameheight"] = 42,										-- frameheight for raidframe
	["columnSpacing"] = 1,
	["pointer"] = true,
}

C["skins"] = {
	["blizzardreskin"] = true,									-- enable blizzardskins
	["calendarevent"] = false,									-- disable calendar event textures
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

C["castbar"] = {
	["enable"] = true,											-- enable castbar
	["petenable"] = true,										-- enable petcastbar
	["cblatency"] = false,                              		-- enable castbar latency
	["cbicons"] = true,                                 		-- enable icons on castbar
	["spark"] = true,											-- enable spark
	["classcolor"] = false,										-- enable classcolor for castbar
	["color"] = { .31, .45, .63, .5 },							-- castbar color
	["cbticks"] = true,											-- enable castbar ticks
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

C["actionbar"] = {
	["enable"] = true,
	["hidebackdrop"] = false,
	["hotkey"] = true,                                  		-- enable hotkey display because it was a lot requested
	["macro"] = false,                                  		-- enable macro display because it was a lot requested
	["hideshapeshift"] = false,                         		-- hide shapeshift or totembar because it was a lot requested.
	["buttonsize"] = 27,                                		-- normal buttons size
	["petbuttonsize"] = 29,                             		-- pet & stance buttons size
	["buttonspacing"] = 4,                              		-- buttons spacing
	["ownshdbar"] = false,                              		-- use a complete new stance bar for shadow dance (rogue only)
	["ownmetabar"] = true,                              		-- use a complete new stance bar for metamorphosis (warlock only)
	["ownwarstancebar"] = false,                        		-- use a different bar for every warrior stance like it was in previous xpac (warrior only)
	["button2"] = false,										-- hiding button between datatetxt
	["petbaralwaysvisible"] = true,								-- visiblity petbar
	["rightbarsmouseover"] = false,								-- rightbars on mouseover
	["petbarhorizontal"] = false,								-- horizontal petbar
	["shapeshiftborder"] = true,								-- enable stancebarborder
	["verticalshapeshift"] = false,								-- enable vertical stancebar
	["shapeshiftmouseover"] = false,							-- enable mouseover on stancebar
	["borderhighlight"] = false,								-- enable prochighlight on iconborder
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
	["announcechannel"] = "PARTY",								-- set announcechannel
	["spellannounce"] = true,									-- enable aura announcement
}

C["loot"] = {
	["lootframe"] = true,                               		-- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           		-- reskin the roll frame to fit tukui
}

C["cooldown"] = {
	["enable"] = true,                                  		-- do i really need to explain this?
	["treshold"] = 8,                                   		-- show decimal under X seconds and text turn red
}

C["rcd"] = {
	["enable"] = true,											-- enable raidcooldowns
	["raid"] = true,											-- raidannounce raidcooldowns
	["party"] = false,											-- partyannounce raidcooldowns
	["arena"] = false,											-- arenaannounce raidccooldowns
}

C["scd"] = {
	["enable"] = true,											-- enable spellcooldowns
	["fsize"] = 12,												-- fonsize spellcooldowns
	["size"] = 36,												-- iconsize spellcooldowns
	["spacing"] = 10,											-- spacing spellcooldowns
	["fade"] = 0,												-- fading spellcooldowns
	["direction"] = "HORIZONTAL",								-- direction spellcooldowns
	["display"] = "STATUSBAR",									-- statusbar spellcooldowns
}

C["icd"] = {
	["enable"] = true,
}

C["datatext"] = {
	["dodge"] = 0,												-- show dodge on panels
	["honor"] = 0,												-- show honor on panels
	["honorablekills"] = 0,										-- show honorablekills on panels
	["parry"] = 0,												-- show parry on panels
	["profession"] = 0,											-- show profession on panels
	["smf"] = 4,												-- show system on panels
	["block"] = 0,												-- show block on panels
	["bags"] = 5,                                       		-- show space used in bags on panels
	["gold"] = 6,                                       		-- show your current gold on panels
	["wowtime"] = 8,                                    		-- show time on panels
	["guild"] = 1,                                     			-- show number on guildmate connected on panels
	["dur"] = 2,                                        		-- show your equipment durability on panels.
	["friends"] = 3,                                    		-- show number of friends connected.
	["power"] = 7,                                      		-- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                                      		-- show your haste rating on panels.
	["crit"] = 0,                                       		-- show your crit rating on panels.
	["avd"] = 0,                                        		-- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                                      		-- show your armor value against the level mob you are currently targeting
	["hit"] = 0,                                        		-- show hit rating
	["mastery"] = 0,                                    		-- show mastery rating
	["micromenu"] = 0,                                  		-- add a micro menu thought datatext
	["talent"] = 0,                                     		-- show talent
	["calltoarms"] = 0,                                 		-- show dungeon and call to arms

	["battleground"] = true,                            		-- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = true,                                  		-- set time to 24h format.
	["localtime"] = false,                              		-- set time to local time instead of server time.
	["fontsize"] = 12,                                  		-- font size for panels.
}

C["chat"] = {
	["enable"] = true,                                  		-- blah
	["whispersound"] = true,                            		-- play a sound when receiving whisper
	["lbackground"] = true,										-- enable left chatbackground
	["rbackground"] = true,										-- enable right chatbackground
	["textright"] = true,										-- set textjustify to right
	["fading"] = true,											-- enables fading
}


C["nameplate"] = {
	["enable"] = true,
	["showhealth"] = false,
	["enhancethreat"] = false,
	["combat"] = false,
	["goodcolor"] = {75/255,  175/255, 76/255},
	["badcolor"] = {0.78, 0.25, 0.25},
	["transitioncolor"] = {218/255, 197/255, 92/255},
	["debuffs"] = true,
	["width"] = 110,
	["height"] = 7,
	["nameabbrev"] = false,
	["auraswidth"] = 20,
	["aurasheight"] = 15,
	["showcastbarname"] = false,
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