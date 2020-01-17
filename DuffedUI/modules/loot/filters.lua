local D, C = unpack(select(2, ...))
local Module = D:GetModule("Bags")

local _G = _G

local C_AzeriteEmpoweredItem_IsAzeriteEmpoweredItemByID = _G.C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID
local EJ_LOOT_SLOT_FILTER_ARTIFACT_RELIC = _G.EJ_LOOT_SLOT_FILTER_ARTIFACT_RELIC
local LE_ITEM_CLASS_ARMOR = _G.LE_ITEM_CLASS_ARMOR
local LE_ITEM_CLASS_CONSUMABLE = _G.LE_ITEM_CLASS_CONSUMABLE
local LE_ITEM_CLASS_ITEM_ENHANCEMENT = _G.LE_ITEM_CLASS_ITEM_ENHANCEMENT
local LE_ITEM_CLASS_MISCELLANEOUS = _G.LE_ITEM_CLASS_MISCELLANEOUS
local LE_ITEM_CLASS_QUESTITEM = _G.LE_ITEM_CLASS_QUESTITEM
local LE_ITEM_CLASS_TRADEGOODS = _G.LE_ITEM_CLASS_TRADEGOODS
local LE_ITEM_CLASS_WEAPON = _G.LE_ITEM_CLASS_WEAPON
local LE_ITEM_MISCELLANEOUS_COMPANION_PET = _G.LE_ITEM_MISCELLANEOUS_COMPANION_PET
local LE_ITEM_MISCELLANEOUS_MOUNT = _G.LE_ITEM_MISCELLANEOUS_MOUNT
local LE_ITEM_QUALITY_COMMON = _G.LE_ITEM_QUALITY_COMMON
local LE_ITEM_QUALITY_LEGENDARY = _G.LE_ITEM_QUALITY_LEGENDARY
local LE_ITEM_QUALITY_POOR = _G.LE_ITEM_QUALITY_POOR

-- Custom filter
local CustomFilterList = {
	[37863] = false,
	[141333] = true,
	[141446] = true,
	[153646] = true,
	[153647] = true,
	[161053] = true,
}

local function isCustomFilter(item)
	if not C["bags"].ItemFilter then
		return
	end

	return CustomFilterList[item.id]
end

-- Default filter
local function isItemInBag(item)
	return item.bagID >= 0 and item.bagID <= 4
end

local function isItemInBank(item)
	return item.bagID == -1 or item.bagID >= 5 and item.bagID <= 11
end

local function isItemJunk(item)
	if not C["bags"].ItemFilter then
		return
	end

	return item.rarity == LE_ITEM_QUALITY_POOR and item.sellPrice > 0
end

local function isAzeriteArmor(item)
	if not C["bags"].ItemFilter then
		return
	end

	if not item.link then
		return
	end

	return C_AzeriteEmpoweredItem_IsAzeriteEmpoweredItemByID(item.link) and not (C["bags"].ItemFilter and item.isInSet)
end

local function isItemEquipment(item)
	if not C["bags"].ItemFilter then
		return
	end

	if C["bags"].ItemSetFilter then
		return item.isInSet
	else
		return item.level and item.rarity > LE_ITEM_QUALITY_COMMON and (item.subType == EJ_LOOT_SLOT_FILTER_ARTIFACT_RELIC or item.classID == LE_ITEM_CLASS_WEAPON or item.classID == LE_ITEM_CLASS_ARMOR)
	end
end

local function isItemConsumble(item)
	if not C["bags"].ItemFilter then
		return
	end

	if isCustomFilter(item) == false then
		return
	end

	return isCustomFilter(item) or (item.classID and (item.classID == LE_ITEM_CLASS_CONSUMABLE or item.classID == LE_ITEM_CLASS_ITEM_ENHANCEMENT))
end

local function isItemLegendary(item)
	if not C["bags"].ItemFilter then
		return
	end

	return item.rarity == LE_ITEM_QUALITY_LEGENDARY
end

local function isMountAndPet(item)
	if not C["bags"].ItemFilter then
		return
	end

	return item.classID == LE_ITEM_CLASS_MISCELLANEOUS and (item.subClassID == LE_ITEM_MISCELLANEOUS_MOUNT or item.subClassID == LE_ITEM_MISCELLANEOUS_COMPANION_PET)
end

local function isItemTrade(item)
	if not C["bags"].ItemFilter then
		return
	end

	if not C["bags"].TradeGoodsFilter then
		return
	end

	return item.classID == LE_ITEM_CLASS_TRADEGOODS
end

local function isItemQuest(item)
	if not C["bags"].ItemFilter then
		return
	end

	if not C["bags"].QuestItemFilter then
		return
	end

	return item.classID == LE_ITEM_CLASS_QUESTITEM
end

local function isItemFavourite(item)
	if not C["bags"].ItemFilter then
		return
	end

	return item.id and DuffedUIData.FavouriteItems[item.id]
end

local function isEmptySlot(item)
	if not C["bags"].GatherEmpty then
		return
	end

	return Module.initComplete and not item.texture and not Module.SpecialBags[item.bagID]
end

function Module:GetFilters()
	local onlyBags = function(item)
		return isItemInBag(item) and not isItemEquipment(item) and not isItemConsumble(item) and not isItemTrade(item) and not isItemQuest(item) and not isAzeriteArmor(item) and not isItemJunk(item) and not isMountAndPet(item) and not isItemFavourite(item) and not isEmptySlot(item)
	end

	local bagAzeriteItem = function(item)
		return isItemInBag(item) and isAzeriteArmor(item)
	end

	local bagEquipment = function(item)
		return isItemInBag(item) and isItemEquipment(item)
	end

	local bagConsumble = function(item)
		return isItemInBag(item) and isItemConsumble(item)
	end

	local bagTradeGoods = function(item)
		return isItemInBag(item) and isItemTrade(item)
	end

	local bagQuestItem = function(item)
		return isItemInBag(item) and isItemQuest(item)
	end

	local bagsJunk = function(item)
		return isItemInBag(item) and isItemJunk(item)
	end

	local onlyBank = function(item)
		return isItemInBank(item) and not isItemEquipment(item) and not isItemLegendary(item) and not isItemConsumble(item) and not isAzeriteArmor(item) and not isMountAndPet(item) and not isItemFavourite(item) and not isEmptySlot(item)
	end

	local bankAzeriteItem = function(item)
		return isItemInBank(item) and isAzeriteArmor(item)
	end

	local bankLegendary = function(item)
		return isItemInBank(item) and isItemLegendary(item)
	end

	local bankEquipment = function(item)
		return isItemInBank(item) and isItemEquipment(item)
	end

	local bankConsumble = function(item)
		return isItemInBank(item) and isItemConsumble(item)
	end

	local onlyReagent = function(item)
		return item.bagID == -3 and not isEmptySlot(item)
	end

	local bagMountPet = function(item)
		return isItemInBag(item) and isMountAndPet(item)
	end

	local bankMountPet = function(item)
		return isItemInBank(item) and isMountAndPet(item)
	end

	local bagFavourite = function(item)
		return isItemInBag(item) and isItemFavourite(item)
	end

	local bankFavourite = function(item)
		return isItemInBank(item) and isItemFavourite(item)
	end

	return onlyBags, bagAzeriteItem, bagEquipment, bagConsumble, bagTradeGoods, bagQuestItem, bagsJunk, onlyBank, bankAzeriteItem, bankLegendary, bankEquipment, bankConsumble, onlyReagent, bagMountPet, bankMountPet, bagFavourite, bankFavourite
end