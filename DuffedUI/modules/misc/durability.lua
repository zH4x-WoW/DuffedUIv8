local D, C, L = unpack(select(2, ...))

hooksecurefunc(DurabilityFrame, "SetPoint", function(self, _, parent)
	if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		self:ClearAllPoints()
		self:Point("BOTTOM", UIParent, "BOTTOM", 0, 200)
	end
end)