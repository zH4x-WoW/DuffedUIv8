local T, C, L = select(2, ...):unpack()
local Battle = CreateFrame("Frame")
local PetBattleFrame = PetBattleFrame

Battle:RegisterEvent("ADDON_LOADED")
Battle:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then
		return
	end
	
	PetBattleFrame:StripTextures()
	
	self:SkinUnitFrames()
	self:AddUnitFramesHooks()
	self:SkinTooltips()
	self:AddTooltipsHooks()
	self:SkinPetSelection()
	self:AddActionBar()
	self:SkinActionBar()
	self:AddActionBarHooks()
end)

T["PetBattles"] = Battle