local D, C, L = select(2, ...):unpack()
if not D.Client == "deDE" then return end

------------------------------------------------
L.DataText = {} -- Data Text Locales
------------------------------------------------

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
L.DataText.AvoidanceShort = "Avd: "
L.DataText.Hit = HIT
L.DataText.Power = ATTACK_POWER
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
L.DataText.Download = "Download: "
L.DataText.Bandwidth = "Bandwidth: "
L.DataText.Guild = "Guild"
L.DataText.NoGuild = "No Guild"
L.DataText.Bags = "Bags: "
L.DataText.Friends = "Friends"
L.DataText.Online = "Online: "
L.DataText.Armor = "Armor"
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Deficit:"
L.DataText.Profit = "Profit:"
L.DataText.TimeTo = "Time to"
L.DataText.FriendsList = "Friends list:"
L.DataText.Spell = "Sp"
L.DataText.AttackPower = "Ap"
L.DataText.Haste = "Haste"
L.DataText.DPS = STAT_DPS_SHORT
L.DataText.HPS = "HPS"
L.DataText.Session = "Session: "
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Total = "Total: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.Currency = "Currency"
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

------------------------------------------------
L.Tooltips = {} -- Tooltips Locales
------------------------------------------------

L.Tooltips.MoveAnchor = "Move Game Tooltip"

------------------------------------------------
L.UnitFrames = {} -- Unit Frames Locales
------------------------------------------------

L.UnitFrames.Ghost = "Ghost"

------------------------------------------------
L.ActionBars = {} -- Action Bars Locales
------------------------------------------------

L.ActionBars.ArrowLeft = "◄"
L.ActionBars.ArrowRight = "►"
L.ActionBars.ArrowUp = "▲ ▲ ▲ ▲ ▲"
L.ActionBars.ArrowDown = "▼ ▼ ▼ ▼ ▼"

------------------------------------------------
L.Install = {} -- Installation of DuffedUI
------------------------------------------------

L.Install.Tutorial = "Tutorial"
L.Install.Install = "Install"
L.Install.InstallStep0 = "Thank you for choosing DuffedUI!|n|nYou will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings. You are also given the possibility to be shown a brief tutorial on some of the features of DuffedUI. Press the 'Tutorial' button to be guided through this small introduction, or press 'Install' to skip this step."
L.Install.InstallStep1 = "The first step applies the essential settings. This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep2 = "The second step applies the correct chat setup. If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep3 = "The third and final step applies the default frame positions. This step is |cffff0000recommended|r for new users.|n|nClick 'Apply' to apply the settings and 'Next' to continue the install process. If you wish to skip this step, just press 'Next'."
L.Install.InstallStep4 = "Installation is complete. Please click the 'Complete' button to reload the UI. Enjoy DuffedUI! Visit us at www.tukui.org!"

------------------------------------------------
L.Help = {} -- /tukui help
------------------------------------------------

L.Help.Title = "DuffedUI Commands:"
L.Help.Datatexts = "'|cff00ff00dt|r' or '|cff00ff00datatext|r' : Enable or disable datatext configuration."
L.Help.Install = "'|cff00ff00install|r' or '|cff00ff00reset|r' : Install or reset DuffedUI to default settings."