local D, C, L = select(2, ...):unpack()

local Settings = DuffedUIConfigNotShared

if (Settings) then
	for group, table in pairs(Settings) do
		if (not table) then
			return
		end
		
		for option, value in pairs(table) do
			if (not C[group]) then
				Settings[group] = nil
			else
				C[group][option] = value
			end
		end
	end
end