local D, C, L = unpack(select(2, ...))
--[[ Configuration functions - DO NOT TOUCH
	id - spell id
	castByAnyone - show if aura wasn't created by player
	color - bar color (nil for default color)
	unitType - 0 all, 1 friendly, 2 enemy
	castSpellId - fill only if you want to see line on bar that indicates if its safe to start casting spell and not clip the last tick, also note that this can be different from aura id 
]]--

local CreateSpellEntry = function(id, castByAnyone, color, unitType, castSpellId)
	return { id = id, castByAnyone = castByAnyone, color = color, unitType = unitType or 0, castSpellId = castSpellId }
end

--[[Configuration starts here]]--
local BAR_HEIGHT = C["classtimer"]["height"]
local BAR_SPACING = C["classtimer"]["spacing"]
local SPARK = C["classtimer"]["spark"]
local CAST_SEPARATOR = C["classtimer"]["separator"]
local CAST_SEPARATOR_COLOR = C["classtimer"]["separatorcolor"]
local TEXT_MARGIN = 5
local PERMANENT_AURA_VALUE = 1
local PLAYER_BAR_COLOR = C["classtimer"]["playercolor"]
local PLAYER_DEBUFF_COLOR = nil
local TARGET_BAR_COLOR = C["classtimer"]["targetbuffcolor"]
local TARGET_DEBUFF_COLOR = C["classtimer"]["targetdebuffcolor"]
local TRINKET_BAR_COLOR = C["classtimer"]["trinketcolor"]
local font = D.Font(C["font"]["classtimer"])
local layout = C["unitframes"]["layout"]
local move = D["move"]

local SORT_DIRECTION = true
local TENTHS_TRESHOLD = 1

local TRINKET_FILTER = {
	--[[Proccs & Racials]]--
	CreateSpellEntry(2825, true), CreateSpellEntry(32182, true), CreateSpellEntry(80353, true), -- Bloodlust/Heroism/Timewarp
	CreateSpellEntry(90355, true), -- Ancient Hysteria, bloodlust from hunters pet
	CreateSpellEntry(26297), -- Berserking (troll racial)
	CreateSpellEntry(33702), CreateSpellEntry(33697), CreateSpellEntry(20572), -- Blood Fury (orc racial)
	CreateSpellEntry(57933), -- Tricks of Trade (15% dmg buff)
	CreateSpellEntry(121279), -- Lifeblood
	CreateSpellEntry(96230), -- Synapse Springs
	CreateSpellEntry(45861), -- Nitro Boost (Engeneering)
	CreateSpellEntry(68992), -- Darkflight (Worgen Sprint Racial)

	--[[Weaponenchants & Stuff]]--
	CreateSpellEntry(104510, true), -- Windsong
	CreateSpellEntry(125487, true), -- Lightweave
	CreateSpellEntry(120032, true), -- Dancing Steel
	CreateSpellEntry(104993, true), -- Jade Spirit
	CreateSpellEntry(116660, true), -- River's Song
	CreateSpellEntry(159676, true), -- Mark of the Frostwolf
	CreateSpellEntry(159675, true), -- Mark of Warsong
	CreateSpellEntry(159234, true), -- Mark of the Thunderlord
	CreateSpellEntry(159678, true), -- Mark of Shadowmoon
	CreateSpellEntry(159679, true), -- Mark of Blackrock
	CreateSpellEntry(173322, true), -- Mark of Bleeding Hollow
	CreateSpellEntry(159238, true), -- Shattered Bleed
	CreateSpellEntry(156060, true), -- Megawatt Filament
	CreateSpellEntry(156055, true), -- Oglethorpe's Missile Splitter
	CreateSpellEntry(173288, true), -- Hemet's Heartseeker

	--[[Darkmoon-Trinkets]]--
	CreateSpellEntry(162915), -- Spirit of the Warlords (Skull of War)
	CreateSpellEntry(162913), -- Visions of the Future (Winged Hourglass)
	CreateSpellEntry(162919), -- Nightmare Fire (Sandman's Pouch)
	CreateSpellEntry(162917), -- Strength of Steel (Knight's Badge)

	--[[T16]]--
	CreateSpellEntry(145164), -- Warlock T16 4pieces
	CreateSpellEntry(144901), -- Deathknight T16 2pieces
	CreateSpellEntry(145336), -- Priest T16 4pieces

	--[[T17]]--
	CreateSpellEntry(165475), -- Mage Arcane 2pieces
	CreateSpellEntry(166868), -- Mage Fire 4pieces
	CreateSpellEntry(170408), -- Mage Frost 4pieces
	CreateSpellEntry(165447), -- Paladin Protection 2pieces
	CreateSpellEntry(167742), -- Paladin Protection 4pieces
	CreateSpellEntry(165404), -- Monk Mistweaver 2pieces
	CreateSpellEntry(167717), -- Monk Mistweaver 4pieces
	CreateSpellEntry(166587), -- Warrior Arms 4pieces
	CreateSpellEntry(165350), -- Warrior Fury 4pieces
	CreateSpellEntry(166639), -- Druid Feral 4pieces
	CreateSpellEntry(165423), -- Druid Guardian 4pieces
	CreateSpellEntry(167655), -- Deathknight Frost 4pieces
	CreateSpellEntry(165509), -- Rogue Subtlety 2pieces
	CreateSpellEntry(170186), -- Hunter Markmanship 4pieces

	--[[Legendary Rings]]--
	CreateSpellEntry(177159), -- Archmage's Incandescence (Intellect)
	CreateSpellEntry(177160), -- Archmage's Incandescence (Strength)
	CreateSpellEntry(177161), -- Archmage's Incandescence (Agility)
	CreateSpellEntry(177172), -- Archmage's Incandescence (Agility)
	CreateSpellEntry(177175), -- Archmage's Incandescence (Strength)
	CreateSpellEntry(177176), -- Archmage's Incandescence (Agility)

	--[[Blackrock Foundry]]--
	CreateSpellEntry(177063), -- Elementalist's Shielding Talisman (Elemental Shield)
	CreateSpellEntry(177056), -- Blast Furnace Door (Blast Furnace)
	CreateSpellEntry(176873), -- Tablet of Turnbuckle Teamwork (Turnbuckle Terror)
	CreateSpellEntry(176878), -- Beating Heart of the Mountain (Lub-Dub)
	CreateSpellEntry(177051), -- Darmac's Unstable Talisman (Instability)
	CreateSpellEntry(176874), -- Vial of Convulsive Shadows (Convulsive Shadows)
	CreateSpellEntry(177096), -- Forgemaster's Insignia (Forgemaster's Vigor)
	CreateSpellEntry(177081), -- Blackiron Micro Crucible (Molten Metal)
	CreateSpellEntry(177067), -- Humming Blackiron Trigger (Detonation)
	CreateSpellEntry(177086), -- Auto-Repairing Autoclave (Sanitizing)
	CreateSpellEntry(177102), -- Battering Talisman (Battering)
	CreateSpellEntry(177042), -- Horn of Screaming Spirits (Screaming Spirits)
	CreateSpellEntry(177060), -- Ironspike Chew Toy (Squeak Squeak)
	CreateSpellEntry(177035), -- Meaty Dragonspine Trophy (Meaty Dragonspine Trophy)

	--[[Highmaul]]--
	CreateSpellEntry(177038), -- Scales of Doom (Balanced Fate)
	CreateSpellEntry(176876), -- Pol's Blinded Eye (Vision of the Cyclops)
	CreateSpellEntry(176875), -- Shards of Nothing (Void Shards)
	CreateSpellEntry(176879), -- Emblem of Caustic Healing (Caustic Healing)
	CreateSpellEntry(177053), -- Evergaze Arcane Eidolon (Gazing Eye)
	CreateSpellEntry(177040), -- Tectus' Beating Heart (Tectus' Heartbeat)
}

local CLASS_FILTERS = {
	DEATHKNIGHT = { 
		target = {
			CreateSpellEntry(55095), -- Frost Fever
			CreateSpellEntry(55078), -- Blood Plague
			CreateSpellEntry(81130), -- Scarlet Fever
			CreateSpellEntry(108194), -- Asphyxiate
			CreateSpellEntry(114866), -- Soul Reaper (Blood)
			CreateSpellEntry(130735), -- Soul Reaper (Frost)
			CreateSpellEntry(130736), -- Soul Reaper (Unholy)
			CreateSpellEntry(155159), -- Necrotic Plague
		},
		player = {
			CreateSpellEntry(48707), -- Anti-Magic Shell
			CreateSpellEntry(48792), -- Ice Bound Fortitude
			CreateSpellEntry(49016), -- Unholy Frenzy
			CreateSpellEntry(49028), -- Dancing Rune Weapon
			CreateSpellEntry(49039), -- Lichborne
			CreateSpellEntry(49222), -- Bone Shield
			CreateSpellEntry(51124), -- Killing Machine
			CreateSpellEntry(51271), -- Pillar of Frost
			CreateSpellEntry(51460), -- Runic Corruption
			CreateSpellEntry(55233), -- Vampiric Blood
			CreateSpellEntry(57330), -- Horn of Winter
			CreateSpellEntry(59052), -- Freezing Fog
			CreateSpellEntry(91342), -- Shadow Infusion
			CreateSpellEntry(108200), -- Remorseless Winter
			CreateSpellEntry(114851), -- Blood Charge
			CreateSpellEntry(115989), -- Unholy Blight
			CreateSpellEntry(171049), -- Rune Tap
			CreateSpellEntry(63560), -- Dark Transformation
		},
		procs = {
			CreateSpellEntry(50421), -- Scent of Blood
			CreateSpellEntry(53365), -- Unholy Strength
			CreateSpellEntry(77535), -- Blood Shield
			CreateSpellEntry(81340), -- Sudden Doom
			CreateSpellEntry(164047), -- Shadow of Death
		}
	},
	DRUID = { 
		target = { 
			CreateSpellEntry(339), -- Entangling Roots
			CreateSpellEntry(770, true), -- Farie Fire
			CreateSpellEntry(774), -- Rejuvenation
			CreateSpellEntry(1079), -- Rip
			CreateSpellEntry(1822), CreateSpellEntry(155722), -- Rake
			CreateSpellEntry(2637), -- Hibernate
			CreateSpellEntry(6795), -- Growl
			CreateSpellEntry(8936, false, nil, nil, 8936), -- Regrowth
			CreateSpellEntry(9005), -- Pounce stun
			CreateSpellEntry(9007), -- Pounce bleed
			CreateSpellEntry(22570), -- Maim
			CreateSpellEntry(33745), -- Lacerate
			CreateSpellEntry(33763), -- Lifebloom
			CreateSpellEntry(33786), -- Cyclone
			CreateSpellEntry(33878, true), -- Mangle (Bear)
			CreateSpellEntry(48438), -- Wild Growth
			CreateSpellEntry(58180), -- Infected Wounds
			CreateSpellEntry(78675), -- Solar Beam
			CreateSpellEntry(82365), -- Skull Bash (Bear)
			CreateSpellEntry(93402), -- Sunfire
			CreateSpellEntry(102355), -- Faerie Swarm
			CreateSpellEntry(106830), -- Thrash
			CreateSpellEntry(113746), -- Weakened Armor
			CreateSpellEntry(115798), -- Weakened Blows
			CreateSpellEntry(155777), -- Germination
			CreateSpellEntry(162359), -- Genesis
			CreateSpellEntry(164812), -- Moonfire
			CreateSpellEntry(164815), -- Sunfire
		},
		player = {
			CreateSpellEntry(774), -- Rejuvenation
			CreateSpellEntry(1850), -- Dash
			CreateSpellEntry(5215), -- Prowl
			CreateSpellEntry(5217), -- Tiger's Fury
			CreateSpellEntry(5229), -- Enrage
			CreateSpellEntry(8936, false, nil, nil, 8936), -- Regrowth
			CreateSpellEntry(16689), -- Nature's Grasp
			CreateSpellEntry(16870), -- Clearcasting
			CreateSpellEntry(22812), -- Barkskin
			CreateSpellEntry(29166), -- Innervate
			CreateSpellEntry(33763), -- Lifebloom
			CreateSpellEntry(48438), -- Wild Growth
			CreateSpellEntry(48505), -- Starfall
			CreateSpellEntry(52610), -- Savage Roar
			CreateSpellEntry(61336), -- Survival Instincts
			CreateSpellEntry(77761), -- Stampeding Roar Bear
			CreateSpellEntry(77764), -- Stampeding Roar Cat
			CreateSpellEntry(100977), -- Harmony
			CreateSpellEntry(106922), -- Might of Ursoc
			CreateSpellEntry(106951), -- Berserk (Cat)
			CreateSpellEntry(106952), -- Berserk (Bear)
			CreateSpellEntry(112071), -- Celestial Alignment
			CreateSpellEntry(124769), -- Frenzied Regeneration
			CreateSpellEntry(124974), -- Nature's Vigil
			CreateSpellEntry(127538), -- Savage Roar
			CreateSpellEntry(132402, true), -- Savage Defense
			CreateSpellEntry(145152), CreateSpellEntry(145162), -- Dream of Cenarius / Bloodtalons
			CreateSpellEntry(155777), -- Germination
			CreateSpellEntry(158792), -- Pulverize
			CreateSpellEntry(162359), -- Genesis
		},
		procs = {
			CreateSpellEntry(16886), -- Nature's Grace
			CreateSpellEntry(48517), -- Eclipse Solar
			CreateSpellEntry(48518), -- Eclipse Lunar
			CreateSpellEntry(69369), -- Predator's Swiftness
			CreateSpellEntry(81006), CreateSpellEntry(81191), CreateSpellEntry(81192), -- Lunar Shower Rank 1/2/3
			CreateSpellEntry(93400), -- Shooting Stars
			CreateSpellEntry(104993), -- Jade Spirit
			CreateSpellEntry(144865), -- Feral Fury (New)
			CreateSpellEntry(146874), -- Feral Rage (New)
		},
	},
	HUNTER = { 
		target = { 
			CreateSpellEntry(1130, true), -- Hunters mark
			CreateSpellEntry(3674), -- Black Arrow
			CreateSpellEntry(5116), -- Concussive Shot
			CreateSpellEntry(19503), -- Scatter Shot
			CreateSpellEntry(34490), -- Silencing Shot
			CreateSpellEntry(53301), -- Explosive Shot
			CreateSpellEntry(63468), -- Piercing Shots
			CreateSpellEntry(82654), -- Widow Venom
			CreateSpellEntry(118253), -- Serpent Sting
			CreateSpellEntry(131894), -- A Murder of Crows
		},
		player = {
			CreateSpellEntry(3045), -- Rapid Fire
			CreateSpellEntry(34471), -- The beast within
			CreateSpellEntry(34720), -- Thrill of the Hunt
			CreateSpellEntry(51753), -- Camouflage
			CreateSpellEntry(53434), -- Call of the wild
			CreateSpellEntry(148469), -- Deterrence
			CreateSpellEntry(155228), -- Lone Wolf
			CreateSpellEntry(168811), -- Sniper Training
			CreateSpellEntry(172106), -- Aspect of the Fox
			CreateSpellEntry(168980), -- Lock and Load
		},
		procs = {
			CreateSpellEntry(56453), -- Lock and Load
			CreateSpellEntry(82692), --Focus Fire
			CreateSpellEntry(53220), -- Improved Steadyshot
			CreateSpellEntry(82925), --Ready, Set, Aim
			CreateSpellEntry(82926), --Fire
		},
	},
	MAGE = {
		target = { 
			CreateSpellEntry(44457), -- Living Bomb
			CreateSpellEntry(118), -- Polymorph
			CreateSpellEntry(28271), -- Polymorph Turtle
			CreateSpellEntry(31589), -- Slow
			CreateSpellEntry(116), -- Frostbolt
			CreateSpellEntry(120), -- Cone of Cold
			CreateSpellEntry(122), -- Frost Nova
			CreateSpellEntry(44614), -- Frostfire Bolt
			CreateSpellEntry(11366), -- Pyroblastdebuff
			CreateSpellEntry(12654), -- Ignite
			CreateSpellEntry(83853), -- Combustion
			CreateSpellEntry(31661), -- Dragon's Breath
			CreateSpellEntry(44572), -- Deep Freeze
			CreateSpellEntry(82691), -- Ring of Frost
			CreateSpellEntry(118271), -- Impact
			CreateSpellEntry(114923), -- Nether Tempest
		},
		player = {
			CreateSpellEntry(36032), -- Arcane Blast
			CreateSpellEntry(12042), -- Arcane Power
			CreateSpellEntry(32612), -- Invisibility
			CreateSpellEntry(1463), -- Mana Shield
			CreateSpellEntry(11426), -- Ice Barrier
			CreateSpellEntry(45438), -- Ice Block
			CreateSpellEntry(12472), -- Icy Veins
			CreateSpellEntry(130), -- Slow Fall
			CreateSpellEntry(57761), -- Brain Freeze
			CreateSpellEntry(12536), -- Clearcasting
			CreateSpellEntry(48108), -- Pyroblast!
			CreateSpellEntry(115610), -- Temporal Shield
			CreateSpellEntry(116257), -- Invocation
		},
		procs = {
			CreateSpellEntry(44544), -- Fingers of Frost
			CreateSpellEntry(79683), -- Arcane Missiles!
			CreateSpellEntry(48107), -- Heating Up!
		},
	},
	MONK = { 
		target = {
			CreateSpellEntry(130320), -- Risin Sun Kick
			CreateSpellEntry(123727), -- Dizzying Haze
			CreateSpellEntry(123725), -- Breath of Fire
			CreateSpellEntry(115804), -- Mortal Wounds
			CreateSpellEntry(119611), -- Renewing Mists
			CreateSpellEntry(132120), -- Envolpeing Mists
			CreateSpellEntry(116849), -- Life Cocoon
			CreateSpellEntry(115175), -- Soothing Mist
			CreateSpellEntry(116095), -- Disable
			CreateSpellEntry(115078), -- Paralysis
		},
		player = {
			CreateSpellEntry(124081), -- Zensphere
			CreateSpellEntry(125195), -- Tigereye Brew
			CreateSpellEntry(125359), -- Tiger Power
			CreateSpellEntry(115307), -- Shuffle
			CreateSpellEntry(118636), -- Power Guard 
			CreateSpellEntry(115295), -- Guard 
			CreateSpellEntry(128939), -- Elusive Brew
			CreateSpellEntry(118674), -- Vital Mists
			CreateSpellEntry(127722), -- Serpent's Zeal
			CreateSpellEntry(116680), -- Thunder Focus Tea
			CreateSpellEntry(120954), -- Fortifying Brew
			CreateSpellEntry(107270), -- Spinning Crane Kick
			CreateSpellEntry(115176), -- Zen Meditation
			CreateSpellEntry(119085), -- Momentum
			CreateSpellEntry(115867), -- Mana Tea
			CreateSpellEntry(124275), -- Light Stagger
			CreateSpellEntry(116740), -- Tigereye Brew
		},
		procs = {
			CreateSpellEntry(116768), -- Combobreaker: Blackout-Kick
			CreateSpellEntry(120273), -- Tiger Strikes
			CreateSpellEntry(118864), -- Combobreaker: Tigerpalm
			CreateSpellEntry(104993), -- Jade Spirit
		}
	},
	PALADIN = { 
		target = {
			CreateSpellEntry(31803), -- Censure --
			CreateSpellEntry(20066), -- Repentance --
			CreateSpellEntry(853), -- Hammer of Justice --
			CreateSpellEntry(31935), -- Avenger's Shield --
			CreateSpellEntry(20170), -- Seal of Justice --
		},
		player = {
			CreateSpellEntry(642), -- Divine Shield
			CreateSpellEntry(31850), -- Ardent Defender
			CreateSpellEntry(498), -- Divine Protection
			CreateSpellEntry(31884), -- Avenging Wrath
			CreateSpellEntry(25771), -- Debuff: Forbearance
			CreateSpellEntry(1044), -- Hand of Freedom
			CreateSpellEntry(1022), -- Hand of Protection
			CreateSpellEntry(1038), -- Hand of Salvation
			CreateSpellEntry(53563), -- Beacon of Light
			CreateSpellEntry(156910), -- Beacon of Faith
			CreateSpellEntry(31821), -- Aura Mastery
			CreateSpellEntry(54428), -- Divine Plea
			CreateSpellEntry(31482), -- Divine Favor
			CreateSpellEntry(6940), -- Hand of Sacrifice
			CreateSpellEntry(84963), -- Inquisition
			CreateSpellEntry(20925), -- Inquisition
			CreateSpellEntry(105809), -- Holy Avenger
			CreateSpellEntry(86659), -- Guardian of Ancient Kings
			CreateSpellEntry(85499), -- Speed of Light
			CreateSpellEntry(90174), -- Devine Purpose
			CreateSpellEntry(114250), -- Selfless Healer
		},
		procs = {
			CreateSpellEntry(53672), CreateSpellEntry(54149), -- Infusion of Light (Rank1/Rank2)
			CreateSpellEntry(85496), -- Speed of Light
			CreateSpellEntry(88819), -- Daybreak
			CreateSpellEntry(85416), -- Grand Crusader
			CreateSpellEntry(20053), -- Conviction (Rank1/Rank2/Rank3)
			CreateSpellEntry(104993), -- Jade Spirit
			CreateSpellEntry(128985), -- Relic of Yu'lon
		},
	},
	PRIEST = { 
		target = { 
			CreateSpellEntry(17), -- Power Word: Shield
			CreateSpellEntry(6788, true, nil, 1), -- Weakened Soul
			CreateSpellEntry(139), -- Renew
			CreateSpellEntry(33076), -- Prayer of Mending
			CreateSpellEntry(33206), -- Pain Suppression
			CreateSpellEntry(34914, false, nil, nil, 34914), -- Vampiric Touch
			CreateSpellEntry(589), -- Shadow Word: Pain
			CreateSpellEntry(158831), -- Devouring Plague
			CreateSpellEntry(47788), -- Guardian Spirit
			CreateSpellEntry(155361), -- Void Entropy
		},
		player = {
			CreateSpellEntry(139), -- Renew
			CreateSpellEntry(10060), -- Power Infusion
			CreateSpellEntry(47585), -- Dispersion
			CreateSpellEntry(63735), -- Serendipity
			CreateSpellEntry(81700), -- Archangel
			CreateSpellEntry(81206), -- Chakra Heal
			CreateSpellEntry(81208), -- Chakra Renew
			CreateSpellEntry(81209), -- Chakra Smite
		},
		procs = {
			CreateSpellEntry(88690), -- Surge of Light
			CreateSpellEntry(81661), -- Evangelism
			CreateSpellEntry(59888), -- Borrowed Time
			CreateSpellEntry(104993), -- Jade Spirit
			CreateSpellEntry(128985), -- Relic of Yu'lon
		},
	},
	ROGUE = { 
		target = { 
			CreateSpellEntry(408), -- Kidney Shot
			CreateSpellEntry(703), -- Garrote
			CreateSpellEntry(1776), -- Gouge
			CreateSpellEntry(1833), -- Cheap Shot
			CreateSpellEntry(1943), -- Rupture
			CreateSpellEntry(2094), -- Blind
			CreateSpellEntry(2818), -- Deadly Poison
			CreateSpellEntry(3409),  -- Crippling Poison 
			CreateSpellEntry(5760), -- Mind-Numbing Poison
			CreateSpellEntry(6770), -- Sap
			CreateSpellEntry(16511), -- Hemorrhage
			CreateSpellEntry(79140), -- vendetta
			CreateSpellEntry(84617), -- Revealing Strike
			CreateSpellEntry(89775), -- Hemorrhage
			CreateSpellEntry(91021), -- Find Weakness
			CreateSpellEntry(122233), -- Crimson Tempest
		},
		player = {
			CreateSpellEntry(1776), -- Gouge
			CreateSpellEntry(1966), -- Feint
			CreateSpellEntry(2983), -- Sprint
			CreateSpellEntry(5171), -- Slice and Dice
			CreateSpellEntry(5277), -- Evasion
			CreateSpellEntry(13750), -- Adrenaline Rush
			CreateSpellEntry(31665), -- Master of Subtlety
			CreateSpellEntry(32645), -- Envenom
			CreateSpellEntry(51713), -- Shadow Dance
			CreateSpellEntry(73651), -- Recuperate
			CreateSpellEntry(74001), -- Combat Readiness
			CreateSpellEntry(84745), -- Shallow Insight 
			CreateSpellEntry(84746), -- Moderate Insight 
			CreateSpellEntry(84747), -- Deep Insight 
			CreateSpellEntry(115189), -- Anticipation
			CreateSpellEntry(121471), -- Shadow Blades
		},
		procs = {
			CreateSpellEntry(13877), -- Blade Flurry
			CreateSpellEntry(121152), -- Blindside
		},
	},
	SHAMAN = {
		target = {
			CreateSpellEntry(974), -- Earth Shield
			CreateSpellEntry(8050), -- Flame Shock
			CreateSpellEntry(8056), -- Frost Shock
			CreateSpellEntry(61295), -- Riptide
			CreateSpellEntry(51945), -- Earthliving
			CreateSpellEntry(77657), -- Searing Flames
			CreateSpellEntry(16166), -- Elemental Mastery
			CreateSpellEntry(77661), -- Searing Flame
		},
		player = {
			CreateSpellEntry(324), -- Lightning Shield
			CreateSpellEntry(52127), -- Water Shield
			CreateSpellEntry(974), -- Earth Shield
			CreateSpellEntry(30823), -- Shamanistic Rage
			CreateSpellEntry(61295), -- Riptide
			CreateSpellEntry(53390), -- Tidal Waves Rank 1/2/3
			CreateSpellEntry(79206), -- Spiritwalker's Grace
			CreateSpellEntry(114050), CreateSpellEntry(114051), CreateSpellEntry(114052), -- Ascendance
			CreateSpellEntry(118473), -- Unleashed Fury
			CreateSpellEntry(73685), -- Unleash Live
		},
		procs = {
			CreateSpellEntry(53817), -- Maelstrom Weapon
			CreateSpellEntry(16246), -- Clearcasting
			CreateSpellEntry(104993), -- Jade Spirit
			CreateSpellEntry(128985), -- Relic of Yu'lon
		},
	},
	WARLOCK = {
		target = {
			CreateSpellEntry(980), -- Bane of Agony
			CreateSpellEntry(603), -- Bane of Doom
			CreateSpellEntry(80240), -- Bane of Havoc
			CreateSpellEntry(1490), -- Curse of the Elements
			CreateSpellEntry(18223), -- Curse of Exhaustion
			CreateSpellEntry(1714), -- Curse of Tongue
			CreateSpellEntry(109466), -- Curse of Enfeeblement
			CreateSpellEntry(172), -- Corruption
			CreateSpellEntry(27243, false, nil, nil, 27243), -- Seed of Corruption
			CreateSpellEntry(48181, false, nil, nil, 48181), -- Haunt
			CreateSpellEntry(30108, false, nil, nil, 30108), -- Unstable Affliction
			CreateSpellEntry(348, false, nil, nil, 348), -- Immolate
			CreateSpellEntry(5782), -- Fear
			CreateSpellEntry(710), -- Banish
			CreateSpellEntry(5484), -- Howl of Terror
			CreateSpellEntry(74434), -- Soulburn
			CreateSpellEntry(17962), -- Conflagrate
			CreateSpellEntry(108686), -- Immolate (Area)
			CreateSpellEntry(87389), -- Seed of Corruption via Soulburn
			CreateSpellEntry(47960), -- Shadowflame
			CreateSpellEntry(146739), -- Corruption 5.4
			CreateSpellEntry(157736), -- Immolate
		},
		player = {
			CreateSpellEntry(17941), -- Shadow Trance
			CreateSpellEntry(64371), -- Eradication
			CreateSpellEntry(85383), -- Improved Soul Fire
			CreateSpellEntry(79459),  CreateSpellEntry(79463),  CreateSpellEntry(79460),  CreateSpellEntry(79462),  CreateSpellEntry(79464), -- Demon Soul
			CreateSpellEntry(103103), -- Malefic Grasp
			CreateSpellEntry(113860), -- Dark Soul: Misery
			CreateSpellEntry(113858), -- Dark Soul: Instability
			CreateSpellEntry(104773), -- Unending Resolve
			CreateSpellEntry(108359), -- Dark Regeneration
			CreateSpellEntry(34936), -- Backlash
		},
		procs = {
			CreateSpellEntry(86121), CreateSpellEntry(86211), -- Soul Swap
			CreateSpellEntry(117828),-- Backdraft rank 1/2/3
			CreateSpellEntry(122355), -- Molten Core
			CreateSpellEntry(63167), -- Decimation
			CreateSpellEntry(47283), -- Empowered Imp
			CreateSpellEntry(108559), -- Demonic Rebirth
		},
	},
	WARRIOR = { 
		target = {
			CreateSpellEntry(1160), -- Demoralizing Shout
			CreateSpellEntry(64382), -- Shattering Throw
			CreateSpellEntry(58567), -- Sunder Armor
			CreateSpellEntry(86346), -- Colossus Smash
			CreateSpellEntry(7922), -- Charge (stun)
			CreateSpellEntry(1715), -- Hamstring
			CreateSpellEntry(676), -- Disarm
			CreateSpellEntry(18498), -- Gag Order
			CreateSpellEntry(6343), -- Thunderclap
			CreateSpellEntry(115767), -- Deep Wounds
			CreateSpellEntry(113746), -- Weakend Armor
		},
		player = {
			CreateSpellEntry(469), -- Commanding Shout
			CreateSpellEntry(6673), -- Battle Shout
			CreateSpellEntry(55694), -- Enraged Regeneration
			CreateSpellEntry(23920), -- Spell Reflection
			CreateSpellEntry(871), -- Shield Wall
			CreateSpellEntry(1719), -- Recklessness
			CreateSpellEntry(12975), -- Last Stand
			CreateSpellEntry(32216), -- Victorious (Victory Rush enabled)
			CreateSpellEntry(85738), CreateSpellEntry(85739), -- Meat Cleaver Rank 1 and 2
			CreateSpellEntry(86662), CreateSpellEntry(86663), -- Rude interruption rank 1 and 2
			CreateSpellEntry(23885), -- Blood Thirst
			CreateSpellEntry(86663), CreateSpellEntry(84585), CreateSpellEntry(84586), -- Slaughter
			CreateSpellEntry(60503), -- Taste for Blood
			CreateSpellEntry(112048), -- Shield Barrier
			CreateSpellEntry(132404), -- Shield Block
			CreateSpellEntry(122510), -- Ultimatum
			CreateSpellEntry(169686), -- Unyielding Strikes
			CreateSpellEntry(13046), -- Enrage
			CreateSpellEntry(12880),
			CreateSpellEntry(12292), -- Bloodbath
			CreateSpellEntry(107574), -- Avatar
		},
		procs = {
			CreateSpellEntry(46916), -- Bloodsurge Slam (Free & Instant)
		},
	},
}

D["ClassTimer"] = function(self)
	local CreateUnitAuraDataSource
	do
		local auraTypes = { "HELPFUL", "HARMFUL" }

		--[[private]]--
		local CheckFilter = function(self, id, caster, filter)
			if (filter == nil) then return false end
			local byPlayer = caster == "player" or caster == "pet" or caster == "vehicle"
			for _, v in ipairs(filter) do 
				if (v.id == id and (v.castByAnyone or byPlayer)) then return v end
			end
			return false
		end

		local CheckUnit = function(self, unit, filter, result)
			if (not UnitExists(unit)) then return 0 end
			local unitIsFriend = UnitIsFriend("player", unit)
			for _, auraType in ipairs(auraTypes) do
				local isDebuff = auraType == "HARMFUL"

				for index = 1, 40 do
					local name, _, texture, stacks, _, duration, expirationTime, caster, _, _, spellId = UnitAura(unit, index, auraType)
					if (name == nil) then break end
					local filterInfo = CheckFilter(self, spellId, caster, filter)
					if (filterInfo and (filterInfo.unitType ~= 1 or unitIsFriend) and (filterInfo.unitType ~= 2 or not unitIsFriend)) then
						filterInfo.name = name
						filterInfo.texture = texture
						filterInfo.duration = duration
						filterInfo.expirationTime = expirationTime
						filterInfo.stacks = stacks
						filterInfo.unit = unit
						filterInfo.isDebuff = isDebuff
						table.insert(result, filterInfo)
					end
				end
			end
		end

		--[[public]]--
		local Update = function(self)
			local result = self.table
			for index = 1, #result do table.remove(result) end
			CheckUnit(self, self.unit, self.filter, result)
			if (self.includePlayer) then CheckUnit(self, "player", self.playerFilter, result) end
			self.table = result
		end

		local SetSortDirection = function(self, descending) self.sortDirection = descending end
		local GetSortDirection = function(self) return self.sortDirection end

		local Sort = function(self)
			local direction = self.sortDirection
			local time = GetTime()
			local sorted
			repeat
				sorted = true
				for key, value in pairs(self.table) do
					local nextKey = key + 1
					local nextValue = self.table[ nextKey ]
					if (nextValue == nil) then break end
					local currentRemaining = value.expirationTime == 0 and 4294967295 or math.max(value.expirationTime - time, 0)
					local nextRemaining = nextValue.expirationTime == 0 and 4294967295 or math.max(nextValue.expirationTime - time, 0)
					if ((direction and currentRemaining < nextRemaining) or (not direction and currentRemaining > nextRemaining)) then
						self.table[ key ] = nextValue
						self.table[ nextKey ] = value
						sorted = false
					end
				end
			until (sorted == true)
		end

		local Get = function(self) return self.table end
		local Count = function(self) return #self.table end

		local AddFilter = function(self, filter, defaultColor, debuffColor)
			if (filter == nil) then return end
			for _, v in pairs(filter) do
				local clone = { }
				clone.id = v.id
				clone.castByAnyone = v.castByAnyone
				clone.color = v.color
				clone.unitType = v.unitType
				clone.castSpellId = v.castSpellId
				clone.defaultColor = defaultColor
				clone.debuffColor = debuffColor
				table.insert(self.filter, clone)
			end
		end

		local AddPlayerFilter = function(self, filter, defaultColor, debuffColor)
			if (filter == nil) then return end
			for _, v in pairs(filter) do
				local clone = { }
				clone.id = v.id
				clone.castByAnyone = v.castByAnyone
				clone.color = v.color
				clone.unitType = v.unitType
				clone.castSpellId = v.castSpellId
				clone.defaultColor = defaultColor
				clone.debuffColor = debuffColor
				table.insert(self.playerFilter, clone)
			end
		end

		local GetUnit = function(self) return self.unit end
		local GetIncludePlayer = function(self) return self.includePlayer end
		local SetIncludePlayer = function(self, value) self.includePlayer = value end

		--[[constructor]]--
		CreateUnitAuraDataSource = function(unit)
			local result = {}
			result.Sort = Sort
			result.Update = Update
			result.Get = Get
			result.Count = Count
			result.SetSortDirection = SetSortDirection
			result.GetSortDirection = GetSortDirection
			result.AddFilter = AddFilter
			result.AddPlayerFilter = AddPlayerFilter
			result.GetUnit = GetUnit 
			result.SetIncludePlayer = SetIncludePlayer 
			result.GetIncludePlayer = GetIncludePlayer 
			result.unit = unit
			result.includePlayer = false
			result.filter = {}
			result.playerFilter = {}
			result.table = {}
			return result
		end
	end

	local CreateFramedTexture
	do
		--[[public]]--
		local SetTexture = function(self, ...) return self.texture:SetTexture(...) end
		local GetTexture = function(self) return self.texture:GetTexture() end
		local GetTexCoord = function(self) return self.texture:GetTexCoord() end
		local SetTexCoord = function(self, ...) return self.texture:SetTexCoord(...) end
		local SetBorderColor = function(self, ...) return self.border:SetVertexColor(...) end

		--[[constructor]]--
		CreateFramedTexture = function(parent)
			local result = parent:CreateTexture(nil, "BACKGROUND", nil)
			local texture = parent:CreateTexture(nil, "OVERLAY", nil)
			texture:Point("TOPLEFT", result, "TOPLEFT", 3, -3)
			texture:Point("BOTTOMRIGHT", result, "BOTTOMRIGHT", -3, 3)
			result.texture = texture
			result.SetTexture = SetTexture
			result.GetTexture = GetTexture
			result.SetTexCoord = SetTexCoord
			result.GetTexCoord = GetTexCoord
			return result
		end
	end

	local CreateAuraBarFrame
	do
		--[[classes]]--
		local CreateAuraBar
		do
			--[[private]]--
			local OnUpdate = function(self, elapsed)
				local time = GetTime()
				if (time > self.expirationTime) then
					self.bar:SetScript("OnUpdate", nil)
					self.bar:SetValue(0)
					self.time:SetText("")
					local spark = self.spark
					if (spark) then spark:Hide() end
				else
					local remaining = self.expirationTime - time
					self.bar:SetValue(remaining)
					local timeText = ""
					if (remaining >= 3600) then
						timeText = tostring(math.floor(remaining / 3600)) .. D.PanelColor .. "h"
					elseif (remaining >= 60) then
						timeText = tostring(math.floor(remaining / 60)) .. D.PanelColor .. "m"
					elseif (remaining > TENTHS_TRESHOLD) then
						timeText = tostring(math.floor(remaining)) .. D.PanelColor .. "s"
					elseif (remaining > 0) then
						timeText = tostring(math.floor(remaining * 10) / 10) .. D.PanelColor .. "s"
					end
					self.time:SetText(timeText)
					local barWidth = self.bar:GetWidth()
					local spark = self.spark
					if (spark) then spark:Point("CENTER", self.bar, "LEFT", barWidth * remaining / self.duration, 0) end

					local castSeparator = self.castSeparator
					if (castSeparator and self.castSpellId) then
						local _, _, _, castTime, _, _ = GetSpellInfo(self.castSpellId)
						castTime = castTime / 1000
						if (castTime and remaining > castTime) then castSeparator:Point("CENTER", self.bar, "LEFT", barWidth * (remaining - castTime) / self.duration, 0) else castSeparator:Hide() end
					end
				end
			end

			--[[public]]--
			local SetIcon = function(self, icon)
				if (not self.icon) then return end
				self.icon:SetTexture(icon)
			end

			local SetTime = function(self, expirationTime, duration)
				self.expirationTime = expirationTime
				self.duration = duration
				if (expirationTime > 0 and duration > 0) then
					self.bar:SetMinMaxValues(0, duration)
					OnUpdate(self, 0)
					local spark = self.spark
					if (spark) then spark:Show() end
					self:SetScript("OnUpdate", OnUpdate)
				else
					self.bar:SetMinMaxValues(0, 1)
					self.bar:SetValue(PERMANENT_AURA_VALUE)
					self.time:SetText("")
					local spark = self.spark
					if (spark) then spark:Hide() end
					self:SetScript("OnUpdate", nil)
				end
			end

			local SetName = function(self, name) self.name:SetText(name) end
			local SetStacks = function(self, stacks)
				if (not self.stacks) then
					if (stacks ~= nil and stacks > 1) then
						local name = self.name
						name:SetText(tostring(stacks) .. "  " .. name:GetText())
					end
				else
					if (stacks ~= nil and stacks > 1) then self.stacks:SetText(stacks) else self.stacks:SetText("") end
				end
			end

			local SetColor = function(self, color) self.bar:SetStatusBarColor(unpack(color)) end
			local SetCastSpellId = function(self, id)
				self.castSpellId = id
				local castSeparator = self.castSeparator
				if (castSeparator) then
					if (id) then self.castSeparator:Show() else self.castSeparator:Hide() end
				end
			end

			local SetAuraInfo = function(self, auraInfo)
				self:SetName(auraInfo.name)
				self:SetIcon(auraInfo.texture)
				self:SetTime(auraInfo.expirationTime, auraInfo.duration)
				self:SetStacks(auraInfo.stacks)
				self:SetCastSpellId(auraInfo.castSpellId)
			end

			--[[constructor]]--
			CreateAuraBar = function(parent)
				local result = CreateFrame("Frame", nil, parent, nil)
				local icon = CreateFramedTexture(result, "ARTWORK")
				icon:SetTexCoord(.15, .85, .15, .85)

				local iconAnchor1
				local iconAnchor2
				local iconOffset
				iconAnchor1 = "TOPRIGHT"
				iconAnchor2 = "TOPLEFT"
				iconOffset = -1
				icon:Point(iconAnchor1, result, iconAnchor2, iconOffset * -5, 3)
				icon:SetWidth(BAR_HEIGHT + 6)
				icon:SetHeight(BAR_HEIGHT + 6)
				result.icon = icon

				local stacks = result:CreateFontString(nil, "OVERLAY", nil)
				stacks:SetFontObject(font)
				stacks:SetShadowColor(0, 0, 0)
				stacks:SetShadowOffset(1.25, -1.25)
				stacks:SetJustifyH("RIGHT")
				stacks:SetJustifyV("BOTTOM")
				stacks:Point("TOPLEFT", icon, "TOPLEFT", 0, 0)
				stacks:Point("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, 3)
				result.stacks = stacks

				local bar = CreateFrame("StatusBar", nil, result, nil)
				bar:SetStatusBarTexture(C["media"].normTex)
				bar:Point("TOPLEFT", result, "TOPLEFT", 9, 0)
				bar:Point("BOTTOMRIGHT", result, "BOTTOMRIGHT", 0, 0)
				result.bar = bar

				if (SPARK) then
					local spark = bar:CreateTexture(nil, "OVERLAY", nil)
					spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
					spark:SetWidth(12)
					spark:SetBlendMode("ADD")
					spark:Show()
					result.spark = spark
				end

				if (CAST_SEPARATOR) then
					local castSeparator = bar:CreateTexture(nil, "OVERLAY", nil)
					castSeparator:SetTexture(unpack(CAST_SEPARATOR_COLOR))
					castSeparator:SetWidth(1)
					castSeparator:SetHeight(BAR_HEIGHT)
					castSeparator:Show()
					result.castSeparator = castSeparator
				end

				local name = bar:CreateFontString(nil, "OVERLAY", nil)
				name:SetFontObject(font)
				name:SetShadowColor(0, 0, 0)
				name:SetShadowOffset(1.25, -1.25)
				name:SetJustifyH("LEFT")
				name:Point("TOPLEFT", bar, "TOPLEFT", TEXT_MARGIN, 0)
				name:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -45, 0)
				result.name = name

				local time = bar:CreateFontString(nil, "OVERLAY", nil)
				time:SetFontObject(font)
				time:SetJustifyH("RIGHT")
				time:Point("LEFT", name, "RIGHT", 0, 0)
				time:Point("RIGHT", bar, "RIGHT", -TEXT_MARGIN, 0)
				result.time = time

				result.SetIcon = SetIcon
				result.SetTime = SetTime
				result.SetName = SetName
				result.SetStacks = SetStacks
				result.SetAuraInfo = SetAuraInfo
				result.SetColor = SetColor
				result.SetCastSpellId = SetCastSpellId
				return result
			end
		end

		--[[private]]--
		local SetAuraBar = function(self, index, auraInfo)
			local line = self.lines[ index ]
			if (line == nil) then
				line = CreateAuraBar(self)
				if (index == 1) then
					line:Point("TOPLEFT", self, "BOTTOMLEFT", 13, BAR_HEIGHT)
					line:Point("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
				else
					local anchor = self.lines[ index - 1 ]
					line:Point("TOPLEFT", anchor, "TOPLEFT", 0, BAR_HEIGHT + BAR_SPACING)
					line:Point("BOTTOMRIGHT", anchor, "TOPRIGHT", 0, BAR_SPACING)
				end
				tinsert(self.lines, index, line)
			end
			line:SetAuraInfo(auraInfo)
			if (auraInfo.color) then
				line:SetColor(auraInfo.color)
			elseif (auraInfo.debuffColor and auraInfo.isDebuff) then
				line:SetColor(auraInfo.debuffColor)
			elseif (auraInfo.defaultColor) then
				line:SetColor(auraInfo.defaultColor)
			end
			line:Show()
		end

		local function OnUnitAura(self, unit)
			if (unit ~= self.unit and (self.dataSource:GetIncludePlayer() == false or unit ~= "player")) then return end
			self:Render()
		end

		local function OnPlayerTargetChanged(self, method) self:Render() end
		local function OnPlayerEnteringWorld(self) self:Render() end
		local function OnEvent(self, event, ...)
			if (event == "UNIT_AURA") then
				OnUnitAura(self, ...)
			elseif (event == "PLAYER_TARGET_CHANGED") then
				OnPlayerTargetChanged(self, ...)
			elseif (event == "PLAYER_ENTERING_WORLD") then
				OnPlayerEnteringWorld(self)
			else
				error("Unhandled event " .. event)
			end
		end

		--[[public]]--
		local function Render(self)
			local dataSource = self.dataSource

			dataSource:Update()
			dataSource:Sort()
			local count = dataSource:Count()
			for index, auraInfo in ipairs(dataSource:Get()) do SetAuraBar(self, index, auraInfo) end
			for index = count + 1, 80 do
				local line = self.lines[ index ]
				if (line == nil or not line:IsShown()) then break end
				line:Hide()
			end
			if (count > 0) then
				self:SetHeight((BAR_HEIGHT + BAR_SPACING) * count - BAR_SPACING)
				self:Show()
			else
				self:Hide()
				self:SetHeight(self.hiddenHeight or 1)
			end
		end

		--[[constructor]]--
		CreateAuraBarFrame = function(dataSource, parent)
			local result = CreateFrame("Frame", nil, parent, nil)
			local unit = dataSource:GetUnit()

			result.unit = unit
			result.lines = {}
			result.dataSource = dataSource

			local background = CreateFrame("Frame", nil, result, nil)
			background:SetFrameStrata("BACKGROUND")
			background:Point("TOPLEFT", result, "TOPLEFT", 20, 2)
			background:Point("BOTTOMRIGHT", result, "BOTTOMRIGHT", 2, -2)
			background:SetTemplate("Transparent")
			result.background = background

			local border = CreateFrame("Frame", nil, result, nil)
			border:SetFrameStrata("BACKGROUND")
			border:Point("TOPLEFT", result, "TOPLEFT", 21, 1)
			border:Point("BOTTOMRIGHT", result, "BOTTOMRIGHT", 1, -1)
			border:SetBackdrop {
				edgeFile = C["media"].blank, edgeSize = 1,
				insets = {left = 0, right = 0, top = 0, bottom = 0}
			}
			border:SetBackdropColor(0, 0, 0, 0)
			border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
			result.border = border

			iconborder = CreateFrame("Frame", nil, result)
			iconborder:SetTemplate("Default")
			iconborder:Size(1, 1)
			iconborder:Point("TOPLEFT", result, "TOPLEFT", -2, 2)
			iconborder:Point("BOTTOMRIGHT", result, "BOTTOMLEFT", BAR_HEIGHT + 2, -2)

			result:RegisterEvent("PLAYER_ENTERING_WORLD")
			result:RegisterEvent("UNIT_AURA")
			if (unit == "target") then result:RegisterEvent("PLAYER_TARGET_CHANGED") end
			result:SetScript("OnEvent", OnEvent)
			result.Render = Render
			return result
		end
	end

	local _, playerClass = UnitClass("player")
	local classFilter = CLASS_FILTERS[ playerClass ]

	local targetDataSource = CreateUnitAuraDataSource("target")
	local playerDataSource = CreateUnitAuraDataSource("player")
	local trinketDataSource = CreateUnitAuraDataSource("player")

	targetDataSource:SetSortDirection(SORT_DIRECTION)
	playerDataSource:SetSortDirection(SORT_DIRECTION)
	trinketDataSource:SetSortDirection(SORT_DIRECTION)

	if classFilter then
		targetDataSource:AddFilter(classFilter.target, TARGET_BAR_COLOR, TARGET_DEBUFF_COLOR)
		playerDataSource:AddFilter(classFilter.player, PLAYER_BAR_COLOR, PLAYER_DEBUFF_COLOR)
		trinketDataSource:AddFilter(classFilter.procs, TRINKET_BAR_COLOR)
	end
	trinketDataSource:AddFilter(TRINKET_FILTER, TRINKET_BAR_COLOR)

	local playerFrame = CreateAuraBarFrame(playerDataSource, self.Health)
	if layout == 3 then
		playerFrame:Point("BOTTOMLEFT", self.Health, "TOPLEFT", 0, 25)
		playerFrame:Point("BOTTOMRIGHT", self.Health, "TOPRIGHT", 0, 25)
	else
		playerFrame:Point("BOTTOMLEFT", self.Health, "TOPLEFT", 0, 7)
		playerFrame:Point("BOTTOMRIGHT", self.Health, "TOPRIGHT", 0, 7)
	end

	local trinketFrame = CreateAuraBarFrame(trinketDataSource, self.Health)
	trinketFrame:Point("BOTTOMLEFT", playerFrame, "TOPLEFT", 0, 5)
	trinketFrame:Point("BOTTOMRIGHT", playerFrame, "TOPRIGHT", 0, 5)

	if C["classtimer"]["debuffsenable"] then
		local targetFrame = CreateAuraBarFrame(targetDataSource, self.Health)
		if C["classtimer"]["targetdebuff"] then
			local debuffMover = CreateFrame("Frame", "DebuffMover", UIParent)
			debuffMover:SetSize(218, 15)
			debuffMover:SetPoint("BOTTOM", UIParent, "BOTTOM", 340, 380)
			move:RegisterFrame(debuffMover)

			targetFrame:Point("BOTTOMLEFT", DebuffMover, "TOPLEFT", 0, 5)
			targetFrame:Point("BOTTOMRIGHT", DebuffMover, "TOPRIGHT", 0, 5)
		else
			targetFrame:Point("BOTTOMLEFT", trinketFrame, "TOPLEFT", 0, 5)
			targetFrame:Point("BOTTOMRIGHT", trinketFrame, "TOPRIGHT", 0, 5)
		end
	end
end