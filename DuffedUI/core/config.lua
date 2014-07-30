local D, C, L = select(2, ...):unpack()

if (not DuffedUIConfigNotShared) then DuffedUIConfigNotShared = {} end

local Settings = DuffedUIConfigNotShared

for group, options in pairs(Settings) do
	if C[group] then
		local Count = 0

		for option, value in pairs(options) do
			if (C[group][option] ~= nil) then
				if (C[group][option] == value) then
					Settings[group][option] = nil
				else
					Count = Count + 1
					C[group][option] = value
				end
			end
		end

		if (Count == 0) then Settings[group] = nil end
	else
		Settings[group] = nil
 	end
 end