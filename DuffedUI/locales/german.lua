local D, C, L = select(2, ...):unpack()
if not D.Client == "deDE" then return end

------------------
L.DataText = {} --
------------------

-- There's globalstrings for most of these datatexts btw, We shouldn't need to localize most of them
-- Something we could do is a "Global" locale file, for stuff we don't need localized by users. Just an idea.

L.DataText.AvoidanceBreakdown = "Avoidance Breakdown"
L.DataText.Level = LEVEL_ABBR
L.DataText.Boss = BOSS
L.DataText.Miss = COMBAT_TEXT_MISS
L.DataText.Dodge = DODGE
L.DataText.Block = BLOCK
L.DataText.Parry = PARRY
L.DataText.Avoidance = "Avoidance"
L.DataText.AvoidanceShort = "avd: "
L.DataText.Hit = HIT
L.DataText.Power = "Power"
L.DataText.Mastery = ITEM_MOD_MASTERY_RATING_SHORT
L.DataText.Crit = COMBAT_RATING_NAME10
L.DataText.Regen = MANA_REGEN_ABBR
L.DataText.Session = "Session: "
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Deficit:"
L.DataText.Profit = "Profit:"
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.TotalGold = "Total: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = TALENTS
L.DataText.NoTalent = "No Talents"
L.DataText.Inc = "Incoming:"
L.DataText.Out = "Outgoing:"
L.DataText.Home = "Home Latency:"
L.DataText.World = "World Latency:"
L.DataText.Global = "Global Latency:"
L.DataText.Download = "Download: "
L.DataText.Bandwidth = "Bandwidth: "
L.DataText.Guild = "guild"
L.DataText.NoGuild = "no guild"
L.DataText.Bags = "bags: "
L.DataText.Friends = "friends"
L.DataText.Online = "Online: "
L.DataText.Armor = "armor"
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Deficit:"
L.DataText.Profit = "Profit:"
L.DataText.TimeTo = "Time to"
L.DataText.FriendsList = "Friends list:"
L.DataText.Spell = "sp"
L.DataText.AttackPower = "ap"
L.DataText.Haste = "haste"
L.DataText.Session = "Session: "
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Total = "Total: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.currencyWeekly = "Weekly: "
L.DataText.FPS = " fps & "
L.DataText.MS = " ms"
L.DataText.Critical = " crit"
L.DataText.Heal = " heal"
L.DataText.ServerTime = "Server Time: "
L.DataText.LocalTime = "Local Time: "
L.DataText.Mitigation = "Mitigation By Level: "
L.DataText.Healing = "Healing: "
L.DataText.Damage = "Damage: "
L.DataText.Honor = "Honor: "
L.DataText.KillingBlow = "Killing Blows: "
L.DataText.StatsFor = "Stats for "
L.DataText.HonorableKill = "Honorable Kills:"
L.DataText.Death = "Deaths:"
L.DataText.HonorGained = "Honor Gained:"
L.DataText.DamageDone = "Damage Done:"
L.DataText.HealingDone = "Healing Done:"
L.DataText.BaseAssault = "Bases Assaulted:"
L.DataText.BaseDefend = "Bases Defended:"
L.DataText.TowerAssault = "Towers Assaulted:"
L.DataText.TowerDefend = "Towers Defended:"
L.DataText.FlagCapture = "Flags Captured:"
L.DataText.FlagReturn = "Flags Returned:"
L.DataText.GraveyardAssault = "Graveyards Assaulted:"
L.DataText.GraveyardDefend = "Graveyards Defended:"
L.DataText.DemolisherDestroy = "Demolishers Destroyed:"
L.DataText.GateDestroy = "Gates Destroyed:"
L.DataText.TotalMemory = "Total Memory Usage:"
L.DataText.ControlBy = "Controlled by:"
L.DataText.CallToArms = BATTLEGROUND_HOLIDAY 
L.DataText.ArmError = "Could not get Call To Arms information."
L.DataText.NoDungeonArm = "No dungeons are currently offering a Call To Arms."
L.DataText.CartControl = "Carts Controlled:"
L.DataText.VictoryPts = "Victory Points:"
L.DataText.OrbPossession = "Orb Possessions:"
L.DataText.Slots = {
	[1] = {1, "Head", 1000},
	[2] = {3, "Shoulder", 1000},
	[3] = {5, "Chest", 1000},
	[4] = {6, "Waist", 1000},
	[5] = {9, "Wrist", 1000},
	[6] = {10, "Hands", 1000},
	[7] = {7, "Legs", 1000},
	[8] = {8, "Feet", 1000},
	[9] = {16, "Main Hand", 1000},
	[10] = {17, "Off Hand", 1000},
	[11] = {18, "Ranged", 1000}
}

--------------------
L.ActionBars = {} --
--------------------

L.ActionBars.ActionButton1 = "Main Bar: Bottom Center BottomRow Action Button 1"
L.ActionBars.ActionButton2 = "Main Bar: Bottom Center BottomRow Action Button 2"
L.ActionBars.ActionButton3 = "Main Bar: Bottom Center BottomRow Action Button 3"
L.ActionBars.ActionButton4 = "Main Bar: Bottom Center BottomRow Action Button 4"
L.ActionBars.ActionButton5 = "Main Bar: Bottom Center BottomRow Action Button 5"
L.ActionBars.ActionButton6 = "Main Bar: Bottom Center BottomRow Action Button 6"
L.ActionBars.ActionButton7 = "Main Bar: Bottom Center BottomRow Action Button 7"
L.ActionBars.ActionButton8 = "Main Bar: Bottom Center BottomRow Action Button 8"
L.ActionBars.ActionButton9 = "Main Bar: Bottom Center BottomRow Action Button 9"
L.ActionBars.ActionButton10 = "Main Bar: Bottom Center BottomRow Action Button 10"
L.ActionBars.ActionButton11 = "Main Bar: Bottom Center BottomRow Action Button 11"
L.ActionBars.ActionButton12 = "Main Bar: Bottom Center BottomRow Action Button 12"
L.ActionBars.MultiActionBar1Button1 = "BottomLeft BottomRow Action Button 6"
L.ActionBars.MultiActionBar1Button2 = "BottomLeft BottomRow Action Button 5"
L.ActionBars.MultiActionBar1Button3 = "BottomLeft BottomRow Action Button 4"
L.ActionBars.MultiActionBar1Button4 = "BottomLeft BottomRow Action Button 3"
L.ActionBars.MultiActionBar1Button5 = "BottomLeft BottomRow Action Button 2"
L.ActionBars.MultiActionBar1Button6 = "BottomLeft BottomRow Action Button 1"
L.ActionBars.MultiActionBar1Button7 = "BottomLeft TopRow Action Button 6"
L.ActionBars.MultiActionBar1Button8 = "BottomLeft TopRow Action Button 5"
L.ActionBars.MultiActionBar1Button9 = "BottomLeft TopRow Action Button 4"
L.ActionBars.MultiActionBar1Button10 = "BottomLeft TopRow Action Button 3"
L.ActionBars.MultiActionBar1Button11 = "BottomLeft TopRow Action Button 2"
L.ActionBars.MultiActionBar1Button12 = "BottomLeft TopRow Action Button 1"
L.ActionBars.MultiActionBar2Button1 = "BottomRight BottomRow Action Button 1"
L.ActionBars.MultiActionBar2Button2 = "BottomRight BottomRow Action Button 2"
L.ActionBars.MultiActionBar2Button3 = "BottomRight BottomRow Action Button 3"
L.ActionBars.MultiActionBar2Button4 = "BottomRight BottomRow Action Button 4"
L.ActionBars.MultiActionBar2Button5 = "BottomRight BottomRow Action Button 5"
L.ActionBars.MultiActionBar2Button6 = "BottomRight BottomRow Action Button 6"
L.ActionBars.MultiActionBar2Button7 = "BottomRight TopRow Action Button 1"
L.ActionBars.MultiActionBar2Button8 = "BottomRight TopRow Action Button 2"
L.ActionBars.MultiActionBar2Button9 = "BottomRight TopRow Action Button 3"
L.ActionBars.MultiActionBar2Button10 = "BottomRight TopRow Action Button 4"
L.ActionBars.MultiActionBar2Button11 = "BottomRight TopRow Action Button 5"
L.ActionBars.MultiActionBar2Button12 = "BottomRight TopRow Action Button 6"
L.ActionBars.MultiActionBar4Button1 = "Bottom Center TopRow Action Button 1"
L.ActionBars.MultiActionBar4Button2 = "Bottom Center TopRow Action Button 2"
L.ActionBars.MultiActionBar4Button3 = "Bottom Center TopRow Action Button 3"
L.ActionBars.MultiActionBar4Button4 = "Bottom Center TopRow Action Button 4"
L.ActionBars.MultiActionBar4Button5 = "Bottom Center TopRow Action Button 5"
L.ActionBars.MultiActionBar4Button6 = "Bottom Center TopRow Action Button 6"
L.ActionBars.MultiActionBar4Button7 = "Bottom Center TopRow Action Button 7"
L.ActionBars.MultiActionBar4Button8 = "Bottom Center TopRow Action Button 8"
L.ActionBars.MultiActionBar4Button9 = "Bottom Center TopRow Action Button 9"
L.ActionBars.MultiActionBar4Button10 = "Bottom Center TopRow Action Button 10"
L.ActionBars.MultiActionBar4Button11 = "Bottom Center TopRow Action Button 11"
L.ActionBars.MultiActionBar4Button12 = "Bottom Center TopRow Action Button 12"

-------------------
L.Worldboss = {} --
-------------------

L.Worldboss.Title = "World Boss(s):"
L.Worldboss.Galleon = "Galleon"
L.Worldboss.Sha = "Sha of Anger"
L.Worldboss.Oondasta = "Oondasta"
L.Worldboss.Nalak = "Nalak"
L.Worldboss.Celestials = "Celestials"
L.Worldboss.Ordos = "Ordos"
L.Worldboss.Defeated = "Defeated"
L.Worldboss.Undefeated = "Undefeated"

-----------------
L.Welcome = {} --
-----------------

L.Welcome.Message = "Hello |cffc41f3b".. D.MyName.."!|r".."\n".."Thank you for using |cffc41f3bDuffedUI "..D.Version.."|r. For detailed Information visit |cffc41f3bhttp://www.duffed.net|r."

-----------------
L.Disband = {} --
-----------------

L.Disband.Text = "Disbanding group ?"

-----------------
L.AFKText = {} --
-----------------

L.AFKText.Text1 = "Mouseover minimap shows coords and locations"
L.AFKText.Text2 = "Middle click the minimap for micromenu"
L.AFKText.Text3 = "Right click the minimap for gatheringmenu"
L.AFKText.Text4 = "By right-clicking on a quest or achievment at the objective tracker, you can retrieve the wowhead link."

---------------------
L.BuffTracker = {} --
---------------------

L.BuffTracker.ap = "+10% Attack Power"
L.BuffTracker.as = "+10% Melee & Ranged Attack Speed"
L.BuffTracker.sp = "+10% Spell Power"
L.BuffTracker.sh = "+5% Spell Haste"
L.BuffTracker.csc = "+5% Critical Strike Chance"
L.BuffTracker.kmr = "+3000 Mastery Rating"
L.BuffTracker.sai = "+5% Strength, Agility, Intellect"
L.BuffTracker.st = "+10% Stamina"
L.BuffTracker.error = "ERROR"

-----------------
L.Plugins = {} --
-----------------

L.Plugins.Click2CastTitle = "Mouse Bindings"

--------------
L.Bind = {} --
--------------

L.Bind.Combat = "You can't bind keys in combat."
L.Bind.Instruct = "Hover your mouse over any actionbutton to bind it. Press the escape key or right click to clear the current actionbuttons keybinding."
L.Bind.Save = "Save bindings"
L.Bind.DiscardBind = "Discard bindings"
L.Bind.Saved = "All keybindings have been saved."
L.Bind.Discard = "All newly set keybindings have been discarded."

------------------
L.Tooltips = {} --
------------------

L.Tooltips.MoveAnchor = "Move Game Tooltip"
L.Tooltips.gold_a = "Archaeology: "
L.Tooltips.gold_c = "Cooking: "
L.Tooltips.gold_jc = "Jewelcrafting: "
L.Tooltips.gold_dr = "Dungeon & Raids: "
L.Tooltips.Count = "Count"

--------------------
L.UnitFrames = {} --
--------------------

L.UnitFrames.Ghost = "Ghost"
L.UnitFrames.Wrath = "Wrath"
L.UnitFrames.Starfire = "Starfire"

----------------
L.Movers = {} --
----------------

L.Movers.Extrabutton = "Move Extrabutton"
L.Movers.Ressources = "Move Ressourcebar"
L.Movers.ClassTimer = "Move ClassTimer"
L.Movers.ClassTimerDebuff = "Move Target Debuffs"
L.Movers.BattleNet = "Move BattleNetFrame"
L.Movers.Vehicle = "Move Vehicleindicator"
L.Movers.Watchframe = "Move Objective Tracker"

-----------------
L.Install = {} --
-----------------

L.Install.Tutorial = "Tutorial"
L.Install.Install = "Install"
L.Install.InstallStep0 = "Thank you for choosing DuffedUI!|n|nYou will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings. You are also given the possibility to be shown a brief tutorial on some of the features of DuffedUI. Press the 'Tutorial' button to be guided through this small introduction, or press 'Install' to skip this step.|n|n|cffff0000ATTENTION! By clicking 'Install / Reset', it will immediately erase all your settings!|r"L.Install.InstallStep1 = "The first step applies the essential settings. This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep1 = "The first step applies the essential settings. This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep2 = "The second step applies the correct chat setup. If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep3 = "The third and final step applies the default frame positions. This step is |cffff0000recommended|r for new users.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep4 = "Installation is complete. Please click the 'Complete' button to reload the UI. Enjoy DuffedUI! Visit us at www.duffed.net!"

--------------
L.Help = {} --
--------------

L.Help.Title = "DuffedUI Commands:"
L.Help.Datatexts = "'|cffC41F3Bdt|r' or '|cffC41F3Bdatatext|r' : Enable or disable datatext configuration."
L.Help.Install = "'|cffC41F3Binstall|r' or '|cffC41F3Breset|r' : Install or reset DuffedUI to default settings."
L.Help.Config = "'|cff00ff00config|r' : Display in-game configuration window."
L.Help.Outdated = "Your version of DuffedUI is out of date. You can download the latest version from www.duffed.net"
L.Help.NoError = "No error yet."
L.Help.AutoInviteEnable = "Autoinvite ON: invite"
L.Help.AutoInviteDisable = "Autoinvite OFF"
L.Help.AutoInviteAlt = "Autoinvite ON: "
L.Help.Config = "Config not loaded."

------------------
L.Merchant = {} --
------------------

L.Merchant.NotEnoughMoney = "You don't have enough money to repair!"
L.Merchant.RepairCost = "Your items have been repaired for"
L.Merchant.SoldTrash = "Your vendor trash has been sold and you earned"