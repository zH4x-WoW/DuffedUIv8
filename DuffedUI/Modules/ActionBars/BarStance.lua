local D, C, L = select(2, ...):unpack()

if (not C["ActionBars"].Enable) then
	return
end

local _G = _G
local DuffedUIActionBars = D["ActionBars"]
local Panels = D["Panels"]
local Size = C["ActionBars"].NormalButtonSize
local Spacing = C["ActionBars"].ButtonSpacing