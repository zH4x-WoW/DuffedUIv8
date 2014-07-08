local D, C, L = select(2, ...):unpack()

-- Per-char isn't added yet.
local Realm = GetRealmName()
local Name = UnitName("player")
local Settings = DuffedUIConfigShared

if (Settings) then
	for group, table in pairs(Settings) do
		for option, value in pairs(table) do
			C[group][option] = value
		end
	end
end