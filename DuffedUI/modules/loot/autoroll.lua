--[[Script taken from Azial - Blackmoore EU and all Credits for this goes to him / her]]--
local D, C, L = unpack(select(2, ...))

--[[this item will always be auto rolled]]--
local neededItemName = GetItemInfo(120945)

local main = CreateFrame("Frame", "AutoRollFrame")
main:RegisterEvent("START_LOOT_ROLL")
main:RegisterEvent("CONFIRM_LOOT_ROLL")
main:SetScript("OnEvent", function(self, event, ...)
	if event == "START_LOOT_ROLL" then
		local id = select(1, ...)
		local texture, name, count, quality, bindOnPickUp, canNeed = GetLootRollItemInfo(id)
		if neededItemName == name then
			for i = 1, 4 do
				local lootFrame = _G["GroupLootFrame"..i]
				if lootFrame:IsVisible() and lootFrame.rollID == id then lootFrame.GreedButton:Click() end
			end
		end
	end
	
	--[[confirm roll automatical]]--
	if event == "CONFIRM_LOOT_ROLL" then
		local id = select(1, ...)
		local roll = select(2, ...)
		ConfirmLootRoll(id, roll)
	end   
end)