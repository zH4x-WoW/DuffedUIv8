local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format
local displayFloat = string.join("", "%s", "%.2f%%|r") -- D.PanelColor,
local displayChance = string.join("", "%.2f|r (%.2f + |cff00ff00%.2f|r)") -- D.PanelColor,
local displayRating = string.join("", "%d (|cff00ff00+%.2f|r)")

local Update = function(self, t)
	local Value = GetBlockChance()
	
	self.Text:SetText(format(displayFloat, STAT_BLOCK..": ", Value))
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		
		local rating = GetCombatRating(CR_BLOCK)
		local ratingChance = GetCombatRatingBonus(CR_BLOCK)
		local baseChance = GetBlockChance() - ratingChance

		GameTooltip:AddDoubleLine(STAT_BLOCK, format(displayChance, GetBlockChance(), baseChance, ratingChance), 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(ITEM_MOD_BLOCK_RATING_SHORT, format(displayRating, rating, ratingChance), 1, 1, 1, 1, 1, 1)
		
		GameTooltip:Show()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local Enable = function(self)	
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(L.DataText.Block, Enable, Disable, Update)