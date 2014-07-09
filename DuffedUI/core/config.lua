local D, C, L = select(2, ...):unpack()

-- Per-char isn't added yet.
local Realm = GetRealmName()
local Name = UnitName("player")
local Settings = DuffedUIConfigShared

if (Settings) then
	for group, table in pairs(Settings) do
		if (not table) then
			return
		end
		
		for option, value in pairs(table) do
			if (not C[group]) then
				Settings[group] = nil
			end
			
			C[group][option] = value
		end
	end
end