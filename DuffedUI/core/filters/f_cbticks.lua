local D, C, L = unpack(select(2, ...))

--if C["castbar"].cbticks ~= true then return end

local function SpellName(id)
	local Name = GetSpellInfo(id)
	return Name
end

D.ChannelTicks = {
	--[SpellName(1120)] = 6, --"Drain Soul"
	[SpellName(689)] = 6, -- "Drain Life"
	[SpellName(108371)] = 6, -- "Harvest Life"
	[SpellName(5740)] = 4, -- "Rain of Fire"
	[SpellName(755)] = 6, -- Health Funnel
	[SpellName(103103)] = 4, --Malefic Grasp
	--[SpellName(44203)] = 4, -- "Tranquility"
	[SpellName(16914)] = 10, -- "Hurricane"
	[SpellName(15407)] = 3, -- "Mind Flay"
	[SpellName(129197)] = 3, -- "Mind Flay (Insanity)"
	[SpellName(48045)] = 5, -- "Mind Sear"
	[SpellName(47540)] = 2, -- "Penance"
	--[SpellName(64901)] = 4, -- Hymn of Hope
	[SpellName(64843)] = 4, -- Divine Hymn
	[SpellName(5143)] = 5, -- "Arcane Missiles"
	[SpellName(10)] = 8, -- "Blizzard"
	[SpellName(12051)] = 4, -- "Evocation"
	[SpellName(115175)] = 9, -- "Smoothing Mist"
}

D.ChannelTicksSize = {
	--[SpellName(1120)] = 2, --"Drain Soul"
	[SpellName(689)] = 1, -- "Drain Life"
	[SpellName(108371)] = 1, -- "Harvest Life"
	[SpellName(103103)] = 1, -- "Malefic Grasp"
}

D.HasteTicks = {
	--[SpellName(64901)] = true, -- Hymn of Hope
	[SpellName(64843)] = true, -- Divine Hymn
}
--[[D.ChannelTicks = {
	[GetSpellInfo(10)] = 8,
	[GetSpellInfo(689)] = 6,
	[GetSpellInfo(755)] = 6,
	[GetSpellInfo(1949)] = 15,
	[GetSpellInfo(5143)] = 5,
	[GetSpellInfo(5740)] = 4,
	[GetSpellInfo(12051)] = 4,
	[GetSpellInfo(15407)] = 3,
	[GetSpellInfo(16914)] = 10,
	[GetSpellInfo(47540)] = 2,
	[GetSpellInfo(48045)] = 5,
	[GetSpellInfo(64843)] = 4,
	[GetSpellInfo(103103)] = 3,
	[GetSpellInfo(106996)] = 10,
	[GetSpellInfo(108371)] = 6,
	[GetSpellInfo(115175)] = 9,
}

D.HasteTicks = {
	[GetSpellInfo(64843)] = true,
}]]