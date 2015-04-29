local D, C, L = unpack(select(2, ...))
if C["cooldown"]["scdenable"] ~= true then return end

local font = D.Font(C["font"]["scd"])
local texture = C["media"]["normTex"]
local size = D.Scale(C["cooldown"]["scdsize"])
local spacing = D.Scale(C["cooldown"]["scdspacing"])
local color = {1, 1, 0, 1}
local fade = C["cooldown"]["scdfade"]
local mode = "HIDE"

if D["Class"] == "WARRIOR" or D["Class"] == "HUNTER" or D["Class"] == "DEATHKNIGHT" or D["Class"] == "ROGUE" then mode = "HIDE" end

spellCooldowns = {
	["DEATHKNIGHT"] = {
		42650, -- Army of the Dead
		43265, -- Death and Decay
		45529, -- Blood Tap
		46584, -- Raise Dead
		47476, -- Strangulate
		47528, -- Mind Freeze
		47568, -- Empower Rune Weapon
		48707, -- Anti-magic shield
		48743, -- Death Pact
		48792, -- Icebound Fortitude
		48982, -- Rune Tap
		49016, -- Hysteria
		49028, -- Dancing Runic Blade
		49039, -- Lichborne
		49203, -- Hungering Cold
		49206, -- Summon Gargoyle
		49222, -- Bone Shield
		49576, -- Death Grip
		49796, -- Deathchill
		51052, -- Anti-magic zone
		51271, -- Unbreakable Armor
		55233, -- Vampiric Blood
		56222, -- Dark Command
		57330, -- Horn of Winter
		77575, -- Outbreak
		77606, -- Dark Simulacrum
		96268, -- Death's Advance
		108194, -- Asphyxiate
		108199, -- Gorefiend's Grasp
		108201, -- Desecreated Ground
		108200, -- Remorseless Winter
		108911, -- Gorefiends Grip
		115989, -- Unholy Blight
		123693, -- Plague Leech
		152279, -- Breath of Sindragosa
		152280, -- Defile
	},
	["DRUID"] = {
		740, -- Tranquility
		1850, -- Dash
		5209, -- Challenging Roar
		5211, -- Mighty Bash
		5217, -- Tiger's Fury
		16689, -- Nature's Grasp
		16979, -- Feral Charge - Bear
		17116, -- Nature's Swiftness
		20484, -- Rebirth
		22812, -- Barksin
		22842, -- Frenzied Regeneration
		29166, -- Innervate
		33831, -- Force of Nature
		33891, -- Incarnation: Tree of Life
		48505, -- Starfall
		49376, -- Feral Charge - Cat
		50334, -- Berserk
		50516, -- Typhoon
		61336, -- Survival Instincts
		77764, -- Stampeding Roar
		102543, -- Incarnation: King of the Jungle
		102558, -- Incarnation: Son of Ursoc
		102560, -- Incarnation: Chosen of Elune
		106952, -- Berserk
		108238, -- Renewal
		110621, -- Mirror Images
		112071, -- Celestial Alignment
		124974, -- Nature's Vigil
		132158, -- Nature's Swiftness
		155835, -- Bristling Fur
	},
	["HUNTER"] = {
		781,    -- Disengage
		1499,   -- Freezing Trap
		1543,   -- Flare
		3045,   -- Rapid Fire
		3674,   -- Black Arrow
		5384,   -- Feign Death
		13795,  -- Immolation Trap
		13809,  -- Ice Trap
		13813,  -- Explosive Trap
		19263,  -- Deterrence
		19386,  -- Wyvern Sting
		19503,  -- Scatter Shot
		19574,  -- Bestial Wrath
		19577,  -- Intimidation
		23989,  -- Readiness
		34026,  -- Kill Command
		34477,  -- Misdirection
		34490,  -- Silencing Shot
		34600,  -- Snake Trap
		51753,  -- Camouflage
		53209,  -- Chimera Shot
		53271,  -- Master's Call
		53301,  -- Explosive Shot
		60192,  -- Freezing Trap Launcher
		77769,  -- Trap Launcher
		82726,  -- Fervor
		82939,  -- Explosive Trap Launcher
		82941,  -- Ice Trap Launcher
		82945,  -- Immolation Trap Launcher
		82948,  -- Snake Trap Launcher
		109248, -- Binding Shot
		109259, -- Powershot
		109304, -- Exhilaration
		117050, -- Glaive Toss
		120360, -- Barrage
		120679, -- Dire Beast
		120697, -- Lynx Rush
		121818, -- Stampede
		130392, -- Blink Strike
		131894, -- A Murder of Crows
	},
	["MAGE"] = {
		66,    -- Invisibility
		120,   -- Cone of Cold
		122,   -- Frost Nova
		543,   -- Magic Protection (Fire/Frost Ward)
		1463,  -- Mana Shield
		1953,  -- Blink
		2139,  -- Counterspell
		11113, -- Blast Wave
		11129, -- Combustion
		11426, -- Ice Barrier
		11958, -- Cold Snap
		12042, -- Arcane Power
		12043, -- Presense of Mind
		12051, -- Evocation
		12472, -- Icy Veins
		31661, -- Dragon Breath
		31687, -- Water Elemental
		33395, -- Freeze (Water Elemental)
		44572, -- Deep Freeze
		45438, -- Ice Block
		55342, -- Mirror Images
		80353, -- Time Warp
		82676, -- Ring of Frost
		82731, -- Flame Orb
		84714, -- Frozen Orb
		108978, -- Alter Time
		110959, -- Greater Invisibility
		115610, -- Temporal Shield
		116257, -- Invoker's Energy
		113724, -- Ring of Frost
		131078, -- Icy Veins
		152087, -- Prismatic Crystal
		157913, -- Evanesce
	},
	["MONK"] = {
		101545, -- Flying Serpent Kick
		101643, -- Transcendence
		107428, -- Rising Sun Kick
		112783, -- Diffuse Magic
		113656, -- Fists of Fury
		115072, -- Expel Harm
		115078, -- Paralysis
		115080, -- Touch of Death
		115098, -- Chi Wave
		115151, -- Renewing Mist
		115176, -- Zen Meditation
		115203, -- Fortifying Brew
		115213, -- Avert Harm
		115288, -- Energizing Brew
		115295, -- Guard
		115308, -- Elusive Brew
		115310, -- Revival
		115313, -- Summon Jade Serpent Statue
		115315, -- Summon Black Ox Statue
		115450, -- Detox
		115546, -- Provoke
		116680, -- Thunder Focus Tea
		116705, -- Spear Hand Strike
		116740, -- Tigereye Brew
		116847, -- Rushing Jade Wind
		116849, -- Life Cocoon
		117368, -- Grapple Weapon
		119381, -- Leg Sweep
		119392, -- Charging Ox Wave
		119996, -- Transcendence: Transfer
		121253, -- Keg Smash
		122057, -- Clash
		122278, -- Dampen Harm
		122470, -- Touch of Karma
		123761, -- Mana Tea (Glyphed)
		122783, -- Diffuse Magic
		123904, -- Invoke Xuen, the White Tiger	
	},
	["PALADIN"] = {
		498,   -- Divine Protection
		633,   -- Lay on Hands
		642,   -- Divine Shield
		853,   -- Hammer of Justice
		1022,  -- Hand of Protection
		1038,  -- Hand of Salvation
		1044,  -- Hand of Freedom
		2812,  -- Holy Wrath
		6940,  -- Hand of Sacrifice
		20066, -- Repentance
		20216, -- Divine Favor
		20473, -- Holy Shock
		26573, -- Consecration
		31821, -- Aura Mastery
		31842, -- Divine Favor
		31850, -- Ardent Defender
		31884, -- Avenging Wrath
		54428, -- Divine Plea /wo Glyph
		82327, -- Holy Radiance
		85222, -- Light of Dawn
		85285, -- Rebuke
		85696, -- Zealotry
		86698, -- Guardian of Ancient Kings
		105809, -- Holy Avenger
		114157, -- Execution Sentence
		114158, -- Light's Hammer
		118730, -- Divine Plea /w Glyph
	},
	["PRIEST"] = {
		17,     -- Power Word: Shield
		527,    -- Purify
		586,    -- Fade
		724,    -- Lightwell
		6346,   -- Fear Ward
		8092,   -- Mind Blast
		8122,   -- Psychic Scream
		10060,  -- Power Infusion
		14914,  -- Holy Fire
		15286,  -- Vampiric Embrace
		15487,  -- Silence
		19236,  -- Desperate Prayer
		32375,  -- Mass Dispel
		32379,  -- Shdow Word: Death
		33076,  -- Prayer of Mending
		33206,  -- Pain Suppression
		34861,  -- Circle of Healing
		47540,  -- Penance
		47585,  -- Dispersion
		47788,  -- Guardian Spirit
		62618,  -- Power Word: Barrier
		64901,  -- Hymm of Hope
		64044,  -- Psychic Horror
		64843,  -- Divine Hymm
		73325,  -- Leap of Faith
		81206,  -- Chakra: Sanctuary
		81209,  -- Chakra: Chastise
		81208,  -- Chakra: Serenity
		81700,  -- Archangel
		88625,  -- Holy Word: Chastise
		89485,  -- Inner Focus
		108920, -- Void Tendrils
		108921, -- Psyfiend
		108968, -- Void Shift
		109964, -- Spirit Shell
		110744, -- Divine Star
		120517, -- Halo
		121135, -- Cascade
		121536, -- Angelic Feather
		129250, -- Power Word: Solace
		132603, -- Shadowfiend
		132604, -- Mindbender
	},
	["ROGUE"] = {
		408,    -- Kidney Shot
		1725,   -- Distract
		1766,   -- Kick
		1776,   -- Gouge
		1784,   -- Stealth
		1856,   -- Vanish
		2094,   -- Blind
		2983,   -- Sprint
		5277,   -- Evasion
		5938,   -- Shiv
		13750,  -- Adrenaline Rush
		13877,  -- Blade Flurry
		14177,  -- Cold Blood
		14183,  -- Premeditation
		14185,  -- Preparation
		31224,  -- Cloak of Shadows
		36554,  -- Shadowstep
		51690,  -- Killing Spree
		51713,  -- Shadow Dance
		51722,  -- Dismantle
		57934,  -- Tricks
		73981,  -- Redirect
		74001,  -- Combat Readiness
		76577,  -- Smoke Bomb
		79140,  -- Vendetta
		114842, -- Shadow Walk
		114018, -- Shroud of Concealment
		121471, -- Shadow Blades
		137619, -- Marked for Death
		152150, -- Death from Above
	},
	["SHAMAN"] = {
		421,    -- Chain Lightning
		2825,   -- Bloodlust
		5394,	-- Healing Stream Totem
		8042,   -- Earth Shock
		8050,   -- Flame Shock
		8056,   -- Frost Shock
		8177,   -- Grounding Totem
		16166,  -- Elemental Mastery
		16188,  -- Ancestral Swiftness
		16190,  -- Mana Tide Totem
		30823,  -- Shamanistic Rage
		32182,  -- Heroism
		51485,  -- Earthgrab Totem
		51490,  -- Thunderstorm
		51505,  -- Lava Burst
		51514,  -- Hex
		51533,  -- Feral Spirit
		55198,  -- Tidal Force
		57994,  -- Wind Shear
		58875,	-- Spirit Walk
		60103,  -- Lava Lash
		61295,  -- Riptide
		73680,  -- Unleash Elements
		73899,  -- Primal Strike
		73920,  -- Healing Rain
		77130,  -- Purify Spirit
		79206,  -- Spiritwalker's Grace
		98008,  -- Spirit Link Totem
		108270, -- Stone Bulwark Totem
		108271, -- Astral Shift
		108273, -- Windwalk Totem
		108280, -- Healing Tide Totem
		108281, -- Ancestral Guidance
		108285, -- Call of Elements
		114050, -- Ascendance
		117014, -- Elemental Blast
		152255, -- Liquid Magma
		165462, -- Unleash Flame
	},
	["WARLOCK"] = {
		5484, -- Howl of Terror
		6229, -- Zwielichtzauberschutz
		6789, -- Death Coil
		17962, -- Conflagrate
		18540, -- Summon Doomguard / Infernal
		18708, -- Fel Domination
		20707, -- Seelenstein
		29858, -- Soulshatter
		30283, -- Shadowfury
		47241, -- Metamorphosis
		47897, -- Shadowflame
		48020, -- Demonic Circle: Teleport
		74434, -- Soul Burn
		77801, -- Demon Soul
		79268, -- Soul Harvest
		80240, -- Havoc
		86121, -- Soul Swap
		104316, -- Wild Imp
		104773, -- Erbarmungslose Entschlossenheit
		108359, -- Finstere Regeneration
		108416, -- Sacrificial Pact
		108482, -- Entfesselter Wille
		108505, -- Archimondes Rache
		113858, -- Dark Soul: Instability
		113860, -- Dark Soul: Misery
		113861, -- Dark Soul: Knowledge
		111397, -- Blutschrecken
		120451, -- Flames of Xoroth
		132409, -- Spell Lock
	},
	["WARRIOR"] = {
		100, -- Charge
		355, -- Taunt
		676, -- Disarm
		871, -- Shield Wall
		1160, -- Demoralisierender Ruf
		1161, -- Challenging Shout
		1719, -- Recklessness
		2565, -- Shield Block
		3411, -- Intervene
		5246, -- Intimidating Shout
		6343, -- Donnerknall
		6544, -- Heroic Leap
		6552, -- Zuschlagen
		12292, -- Death Wish
		12328, -- Sweeping Strikes
		12809, -- Concussion Blow
		12975, -- Last Stand
		18499, -- Berserker Rage
		20252, -- Intercept
		20230, -- Retaliation
		46924, -- Bladestorm
		46968, -- Shockwave
		55694,	-- Wütende Regeneration
		57755, -- Heroic Throw
		60970, -- Heroic Fury
		64382, -- Shattering Throw
		85388, -- Throwdown
		86346, -- Colossus Smash
		97462, -- Anspornender Schrei
		102060, -- Unterbrechender Ruf
		103840,	-- Bevorstehender Sieg
		107566, -- Erschütternder Ruf
		107570,	-- Sturmblitz
		107574, -- Avatar
		114028, -- Mass Spell Reflect
		114029, -- Sicherung
		114030, -- Wachsamkeit
		114192, -- Spottendes banner
		114203, -- Demoralisierendes Banner
		114207, -- Schädelbanner
		118000, -- Drachengebrüll
		118038, -- Durch das Schwert umkommen
	},
	["RACE"] = {
		["Orc"] = {
			33697, -- Orc Blood Fury Shaman
			33702, -- Orc Blood Fury Warlock
			20572, -- Orc Blood Fury AP
		},
		["BloodElf"] = {
			25046, -- Blood Elf Arcane Torrent Rogue
		},
		["Scourge"] = {		
			20577, -- Cannibalize
			7744,   -- Will of the Forsaken
		},
		["Tauren"] = {
			20549, -- War Stomp
		},
		["Troll"] = {
			26297, -- Berserking
		},
		["Goblin"] = {
			69070, -- Rocket Jump and Rocket Barrage
		},
		["Draenei"] = {
			59545, -- Gift of the Naaru DK
			59543, -- GotN Hunter
			59548, -- GotN Mage
			59542, -- GotN Paladin
			59544, -- GotN Priest
			59547, -- GotN Shaman
			28880, -- GotN Warrior
			121093, -- GotN Monk
		},
		["Dwarf"] = {
			20594, -- Stoneform
		},
		["Gnome"] = {
			20589, -- Escape Artist
		},
		["Human"] = {
			59752, -- Every Man for Himself
		},
		["NightElf"] = {
			58984, -- Shadowmeld
		},		
		["Worgen"] = {
			68992, -- Darkflight
			68996, -- Two Forms
		},
		["Pandaren"] = {
			107079, -- Quaking Palm
		}
	},
	["PET"] = {
		-- Warlock
		6360, -- Succubus Whiplash
		7812, -- Voidwalker Sacrifice
		19647, -- Felhunter Spell Lock
		89766, -- Felguard Axe Toss
		89751, -- Felguard Felstorm
		30151, -- Felguard Pursuit
		115770, -- Shivarra Teufelspeitsche
		115781, -- Beobachter Augenstrahl
		-- Hunter
	},
}

trinketCooldowns = {
	81268 -- testtrinket
}

-- Timer update throttle (in seconds). The lower, the more precise. Set it to a really low value and don't blame me for low fps
local throttle = 0.3
local spells = {}
local frames = {}

local GetTime = GetTime
local pairs = pairs
local xSpacing, ySpacing = spacing, 0
local width, height = size, size
local anchorPoint = "TOPRIGHT"
local onUpdate
local move = D["move"]

local scfa = CreateFrame("Frame", "SpellCooldownsMover", UIParent)
scfa:Size(120, 17)
scfa:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 350)
move:RegisterFrame(scfa)

local SpellCooldownFrame = CreateFrame("Frame", "DuffedUISpellCooldowns", UIParent)
SpellCooldownFrame:SetFrameStrata("BACKGROUND")
SpellCooldownFrame:SetHeight(height)
SpellCooldownFrame:SetWidth(width)
SpellCooldownFrame:SetPoint("BOTTOM", scfa, 0, 0)

local function enableCooldown(self)
	self.enabled = true
	if self.StatusBar then
		self.StatusBar:Show()
		self.DurationText:Show()
	end
	if self.Cooldown then self.Cooldown:Show() end
	self:SetScript("OnUpdate", onUpdate)
	onUpdate(self, 1)
	if mode == "HIDE" then
		self:Show()
	else
		self.Icon:SetVertexColor(1, 1, 1, 1)
		self:SetAlpha(1)
	end
end

local function disableCooldown(self)
	self.enabled = false
	if mode == "HIDE" then
		self:Hide()
	else
		self.Icon:SetVertexColor(1, 1, 1, .15)
		self:SetAlpha(.2)
	end
	if self.StatusBar then
		self.StatusBar:Hide()
		self.DurationText:SetText("")
	end
	if self.Cooldown then self.Cooldown:Hide() end
	self:SetScript("OnUpdate", nil)
end

local function positionHide()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D["Class"] == "PRIEST"then
			local start, duration = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D["Class"] == "PRIEST" and frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685 then 
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				frame:ClearAllPoints()
				if index == 0 then frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing) else frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing) end
				if not frame.disabled then enableCooldown(frame) end
				lastFrame = frame
				index = index + 1
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end

local function positionDim()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D["Class"] == "PRIEST" then
			local start, duration, enable = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D["Class"] == "PRIEST" and frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685 then
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				if not frame.enabled then enableCooldown(frame) end
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
		if (index == 0) then frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing) else frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing) end
		lastFrame = frame
		index = index + 1
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end


local function position()
	if mode == "HIDE" then positionHide() else positionDim() end
end

--[[Frames]]--
local function createCooldownFrame(spell)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:CreateBackdrop("Transparent")
	frame:SetHeight(width)
	frame:SetWidth(width)
	frame:SetFrameStrata("MEDIUM")

	local icon = frame:CreateTexture()
	local spellInfo = GetSpellInfo(spell)
	if not spellInfo then return nil end
	local texture = GetSpellTexture(spellInfo)
	icon:SetAllPoints(frame)
	if D["Class"] == "PRIEST" and spell == 88682 or spell == 88684 or spell == 88685 then texture = GetSpellTexture(GetSpellInfo(88625)) end
	if not texture then return nil end
	icon:SetTexture(texture)
	icon:SetTexCoord(.08, .92, .08, .92)
	frame.Icon = icon

	local durationText = frame:CreateFontString(nil, "OVERLAY")
	durationText:SetFontObject(font)
	durationText:SetTextColor(unpack(color))
	durationText:SetText("")
	durationText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2)
	frame.DurationText = durationText

	local statusBar = CreateFrame("StatusBar", nil, frame, "TextStatusBar")
	statusBar:Size(width, 4)
	statusBar:SetStatusBarTexture(texture)
	statusBar:SetStatusBarColor(.77, .12, .23)
	statusBar:SetPoint("TOP", frame,"TOP", 0, 0)
	statusBar:SetMinMaxValues(0, 1)
	statusBar:SetFrameLevel(frame:GetFrameLevel() + 3)
	frame.StatusBar = statusBar

	frame.lastupdate = 0
	frame.spell = spell
	frame.start = GetTime()
	frame.duration = 0

	disableCooldown(frame)
	return frame
end

local function OnEvent(self, event, arg1)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TALENT_UPDATE" then	
		for k, v in pairs(spells) do
			if GetSpellInfo(v) then frames[v] = frames[v] or createCooldownFrame(spells[k]) else frames[v] = createCooldownFrame(spells[k]) end
		end
		position()
	end

	if event == "SPELL_UPDATE_COOLDOWN" then position() end
end

spells = spellCooldowns[select(2, UnitClass("player"))]

local race = spellCooldowns["RACE"]
for i = 1, table.getn(race[select(2, UnitRace("player"))]) do table.insert(spells, race[select(2, UnitRace("player"))][i]) end

local _, pra = UnitRace("player")
if D["Class"] == "WARLOCK" or D["Class"] == "HUNTER" then
	for i = 1, table.getn(spellCooldowns["PET"]) do table.insert(spells, spellCooldowns["PET"][i]) end
end

onUpdate = function (self, elapsed)
	self.lastupdate = self.lastupdate + elapsed
	if self.lastupdate > throttle then
		local start, duration = GetSpellCooldown(self.spell)
		if duration and duration > 1.5 then
			local currentDuration = (start + duration - GetTime())
			local normalized = currentDuration/self.duration
			if self.StatusBar then
				self.StatusBar:SetValue(normalized)
				self.DurationText:SetText(math.floor(currentDuration))
				if fade == 1 then 
					self.StatusBar:GetStatusBarTexture():SetVertexColor(1 - normalized, normalized, 0 / 255)
				elseif fade == 2 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(normalized, 1 - normalized, 0 / 255)
				end
			end
			if (self.Cooldown) then self.Cooldown:SetCooldown(start, duration) end
		else
			if self.enabled then disableCooldown(self) end
			position()
		end
		self.lastupdate = 0
	end
end

SpellCooldownFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
SpellCooldownFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
SpellCooldownFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
SpellCooldownFrame:SetScript("OnEvent", OnEvent)
