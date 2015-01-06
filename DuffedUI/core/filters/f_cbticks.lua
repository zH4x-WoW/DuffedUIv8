local D, C, L = unpack(select(2, ...))

if C["castbar"].cbticks ~= true then return end

local function SpellName(id)
	local Name = GetSpellInfo(id)
	return Name
end

D.ChannelTicks = {
	[SpellName(10)] = 8,
	[SpellName(689)] = 6,
	[SpellName(755)] = 6,
	[SpellName(1949)] = 15,
	[SpellName(5143)] = 5,
	[SpellName(5740)] = 4,
	[SpellName(12051)] = 4,
	[SpellName(15407)] = 3,
	[SpellName(16914)] = 10,
	[SpellName(47540)] = 2,
	[SpellName(48045)] = 5,
	[SpellName(64843)] = 4,
	[SpellName(103103)] = 3,
	[SpellName(106996)] = 10,
	[SpellName(108371)] = 6,
	[SpellName(115175)] = 9,
	[SpellName(139139)] = 3,
}

D.HasteTicks = {
	[SpellName(64843)] = true,
}