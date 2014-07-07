local D, C, L = select(2, ...):unpack()
local Quests = CreateFrame("Frame")

Quests:RegisterEvent("PLAYER_ENTERING_WORLD")
Quests:SetScript("OnEvent", function(self, event)
	self:CreateWatchFrameAnchor()
	self:AddWatchFrameHooks()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:WOWHead()

	D.Delay(1, function()
		self:PositionWatchFrame()
	end)
end)

D["Quests"] = Quests