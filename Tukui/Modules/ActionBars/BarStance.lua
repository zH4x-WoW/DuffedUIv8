local T, C, L = select(2, ...):unpack()

if (not C.ActionBars.Enable) then
	return
end

local _G = _G
local TukuiActionBars = T["ActionBars"]
local Panels = T["Panels"]
local Size = C.ActionBars.NormalButtonSize
local Spacing = C.ActionBars.ButtonSpacing