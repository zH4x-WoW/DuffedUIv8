--[[local D, C, L = select(2, ...):unpack()

SLASH_MOVING2 = "/moveui"
SlashCmdList["MOVING"] = function()
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	D.MoveUIElements()
	
	if D.MoveUnitFrames then
		D.MoveUnitFrames()
	end
end

local protection = CreateFrame("Frame")
protection:RegisterEvent("PLAYER_REGEN_DISABLED")
protection:SetScript("OnEvent", function(self, event)
	if enable then return end
	print(ERR_NOT_IN_COMBAT)
	enable = false
	D.MoveUIElements()
end)]]--