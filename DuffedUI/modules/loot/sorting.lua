_G.JPackLocale = {}

local L = JPackLocale
L.TYPE_BAG = INVTYPE_BAG
L.TYPE_MISC = MISCELLANEOUS
JPACK_DRAW = {"#"..BATTLE_PET_SOURCE_2}
if (GetLocale() == "enUS" or GetLocale() == "enGB") then
	L.TYPE_FISHWEAPON = "Fishing Poles"
	JPACK_ORDER = {"Hearthstone","##Mounts","Mining Pick","Skinning Knife","Fishing Pole","#Fishing Poles","#Weapon","#Armor","#Weapon##Other","#Armor##Other","#Recipe","#Quest","##Elemental","##Metal & Stone","##Herb","#Gem","##Jewelcrafting","#Consumable","##Cloth","#Trade Goods","##Meat","#","Fish Oil","Soul Shard","#Miscellaneous"}
	JPACK_DEPOSIT = {"##Elemental","##Metal & Stone","##Herb","#Jewelcrafting","#Container"}
elseif (GetLocale() == "zhCN") then 
	L.TYPE_FISHWEAPON = "鱼竿"
	JPACK_ORDER = {"炉石","要塞炉石","虚灵之门","##工程","##坐骑","矿工锄","剥皮小刀","鱼竿","#鱼竿","#武器","#护甲","#武器##其它","#护甲##其它","#配方","#任务","##元素","##金属和矿石","##草药","#材料","##珠宝","#消耗品","##布料","#商品","##肉类","#","鱼油","灵魂碎片","#其它"}
	JPACK_DEPOSIT = {"##元素","##金属和矿石","#材料","##草药","#珠宝","#容器"}
elseif (GetLocale() == "zhTW") then
	L.TYPE_FISHWEAPON = "魚竿"
	JPACK_ORDER = {"爐石","##坐騎","採礦鎬","剝皮小刀","寶石匠的工具箱","簡單的磨粉機","魚竿","#魚竿","#武器","#護甲","#武器##其它","#護甲##其它","#配方","#任務","##元素材料","##金屬與石頭","##草藥","#材料","##珠宝","#消耗品","##布料","#商人","##肉類","#","魚油","灵魂碎片","#其它"}
	JPACK_DEPOSIT = {"#商人","#材料","##草藥","##肉類","#珠寶","#容器"}
elseif (GetLocale() == "deDE") then
	L.TYPE_FISHWEAPON = "Angelruten"
	JPACK_ORDER = {"Ruhestein","##Reittiere","Spitzhacke","Kürschnermesser","Angelrute","##Angelruten","#Waffe","#Rüstung","#Waffe##Verschiedenes","#Rüstung##Verschiedenes","#Rezept","#Quest","##Elementar","##Metall & Stein","##Kräuter","#Edelstein","##Juwelenschleifen",	"#Verbrauchbar","##Stoff","#Handwerkswaren","##Fleisch","#","Fischöl","Seelenstein","#Verschiedenes"}
	JPACK_DEPOSIT = {"##Elementar","##Metall & Stein","##Kräuter","#Juwelenschleifen","#Behälter"}
elseif (GetLocale() == "koKR") then
	L.TYPE_FISHWEAPON = "낚싯대"
	JPACK_ORDER = {"귀환석","##탈것","채광용 곡괭이","무두용 칼","낚싯대","#낚싯대","#무기","#방어구","#무기##기타","#방어구##기타","#문양","#제조법","#퀘스트","##원소","##광물","##약초","#보석","##보석세공","#소비용품","#직업용품##천","#직업용품","##고기","#","#기타##재료","영혼의 조각","#기타"}
	JPACK_DEPOSIT = {"##원소","##광물","##약초","#보석세공","#가방"}
elseif (GetLocale() == "ruRU") then
	L.TYPE_FISHWEAPON = "Удочки"
	JPACK_ORDER = {"Камень возвращения","##Верховые животные","Шахтерская кирка","Нож для снятия шкур","Удочка","#Удочки","#Оружие","#Броня","#Оружие##Разное","#Доспехи##Разное","#Рецепты","#Задания","##Стихи","##Металл и камень","##Трава","#Самоцветы","##Ювелирное дело","#Расходуемые","##Cloth","#Хозяйственные товары","##Мясо","#","Рыбий жир","Осколок души","#Разное"}
	JPACK_DEPOSIT = {"##Стихии","##Металл и камень","##Трава","#Ювелирное дело","#Сумки"}
end

--[[Local]]--
local JPackDB = {}
JPack = CreateFrame("Frame")
JPack.bankOpened = false
JPack.deposit = false
JPack.draw = false
JPack.bagGroups = {}
JPack.packingGroupIndex = 1
JPack.packingBags = {}
JPack.updatePeriod = .1
JPackDB.asc = false

local RegisterEvent = JPack.RegisterEvent
local UnregisterEvent = JPack.UnregisterEvent
local event_table = {}

function JPack:RegisterEvent(event, func)
	if not func then func = self[event] end
	if type(func) ~= "function" then return end

	local curr = event_table[event]
	if curr then
		if type(curr)  ==  "function" then
			event_table[event] = {curr, func}
		else
			for k, v in pairs(curr) do
				if v  ==  func then return end
			end
			tinsert(curr, func)
		end
	else
		event_table[event] = func
		RegisterEvent(self,event)
	end
end

function JPack:UnregisterEvent(event, func)
	if not func then func = self[event] end
	if type(func) ~= "function" then return end

	local curr = event_table[event]
	if type(curr)  ==  "function" then
		event_table[event] = nil
		UnregisterEvent(self, event)
	else
		for k,v in pairs(curr) do
			if v  ==  func then
				tremove(curr, k)
				return
			end
		end
	end
end

JPack:SetScript("OnEvent", function(self, event, ...)
	local handler = event_table[event]
	if type(handler) == "function" then
		handler(self, event, ...)
	else
		for k, func in pairs(handler) do func(self, event, ...) end
	end
end)

local bagSize = 0
local packingBags = {}
local JPACK_MAXMOVE_ONCE = 3
local current, to, lockedSlots, currentGBTab

local JPACK_STEP = 0
local JPACK_STARTED = 1
local JPACK_DEPOSITING = 2
local JPACK_DRAWING = 3
local JPACK_STACKING = 4
local JPACK_STACK_OVER = 5
local JPACK_SORTING = 6
local JPACK_PACKING = 7
local JPACK_START_PACK = 8
local JPACK_GUILDBANK_STACKING = 9
local JPACK_GUILDBANK_SORTING = 10
local JPACK_GUILDBANK_COMPLETE = 11
local JPACK_SPEC_BAG_OVER = 12
local JPACK_STOPPED = 0

--[[lib]]--
local function CheckCursor()
	ClearCursor()
	if GetCursorInfo() then return true end
end

local function IndexOfTable(t,v)
	for i = 1, table.getn(t) do
		if (v == t[i]) then return i end
	end
	return 0
end

local function getJPackItem(bag, slot, isGB)
	local link = isGB and GetGuildBankItemLink(bag, slot) or GetContainerItemLink(bag, slot) 
	if not link then return end
	local item = {}
	item.slotId = c
	item.name, item.link, item.rarity, 
	item.level, item.minLevel, item.type, item.subType, item.stackCount,
	item.equipLoc, item.texture = GetItemInfo(link)
	item.itemid = tonumber(link:match("item:(%d+):"))
	return item
end

local function CanGoInBag(frombag,fromslot, tobag)
	local item = GetContainerItemLink(frombag, fromslot)
	if not item then return false end
	local itemFamily = GetItemFamily(item)
	local bagFamily = select(2, GetContainerNumFreeSlots(tobag))
	return bagFamily == 0 or bit.band(itemFamily, bagFamily) > 0
end

local function isBagReady(bag)
	for i = 1, GetContainerNumSlots(bag) do
		local _, _, locked = GetContainerItemInfo(bag, i)
		if (locked) then return false end
	end
	return true
end

local function isGBReady(tab)
	for i = 1, 98 do
		local _, _, locked = GetGuildBankItemInfo(tab or currentGBTab, i)
		if locked then return end
	end
	return true
end

local function isAllBagReady()
	for i = 1, table.getn(JPack.bagGroups) do
		for j = 1, table.getn(JPack.bagGroups[i]) do
			if (not isBagReady(JPack.bagGroups[i][j])) then return false end
		end
	end
	return true
end

local function getPerffix(item)
	if not item then return end
	if item.subType == nil and item.type == nil then item.subType = "PET" item.type = "PET"end
	local i=IndexOfTable(JPACK_ORDER,item.name)
	if (i <= 0) then i = IndexOfTable(JPACK_ORDER, "#" .. item.type .. "##" .. item.subType) else return "1".. string.format("%3d",999 - i) end
	if (i <= 0) then i = IndexOfTable(JPACK_ORDER, "##" .. item.subType) end
	if (i <= 0) then i = IndexOfTable(JPACK_ORDER, "#" .. item.type) end
	if (i <= 0) then i = IndexOfTable(JPACK_ORDER, "#") end
	if (i <= 0) then i = 999 end

	local s = string.format("%3d", 999 - i)
	if (item.rarity == 0) then
		return "00" .. s
	elseif (IsEquippableItem(item.name) and item.type ~= L.TYPE_BAG and item.subType ~= L.TYPE_FISHWEAPON) and item.subType ~= L.TYPE_MISC then 
		if (item.rarity <= 1 ) then return "01" .. s end
	end
	return "1" .. s
end

local function shouldSaveToBank(bag, slot)
	local item = getJPackItem(bag, slot)
	return item ~= nil and ((IndexOfTable(JPACK_DEPOSIT, "#"..item.type.."##"..item.subType) > 0) or (IndexOfTable(JPACK_DEPOSIT, "#"..item.type) > 0) or (IndexOfTable(JPACK_DEPOSIT, "##"..item.subType) > 0) or (IndexOfTable(JPACK_DEPOSIT, item.name) > 0))
end

local function shouldLoadFromBank(bag, slot)
	local item = getJPackItem(bag, slot)
	return item ~= nil and ((IndexOfTable(JPACK_DRAW, "#"..item.type.."##"..item.subType) > 0) or (IndexOfTable(JPACK_DRAW, "#"..item.type) > 0) or (IndexOfTable(JPACK_DRAW, "##"..item.subType) > 0) or (IndexOfTable(JPACK_DRAW,item.name) > 0))
end

local function getPrevSlot(bags, bag, slot)
	if (slot > 1) then
		slot = slot - 1
	elseif (bag > 1) then
		bag = bag - 1
		slot = GetContainerNumSlots(bags[bag])
	else
		bag = -1
	end
	return bag,slot
end

local function getCompareStr(item)
	if (not item) then
		return nil
	elseif (not item.compareStr) then
		if item.texture == nil then
			return getPerffix(item).." ".."1"..item.type.." "..item.subType.." ".."pet".." "..string.format("%2d", item.minLevel).." "..string.format("%2d", item.level).." ".."00".."PET" 
		end
		local _, _, textureType, textureIndex = string.find(item.texture, "\\.*\\([^_]+_?[^_]*_?[^_]*)_?(%d*)")
		if (not item.rarity) then item.rarity = "1" end
		item.compareStr = getPerffix(item).." "..item.rarity..item.type.." "..item.subType.." "..textureType.." "..string.format("%2d", item.minLevel).." "..string.format("%2d", item.level).." "..(textureIndex or "00")..item.name
	end
	return item.compareStr
end

local function compare(a, b)
	local ret = 0
	if (a == b) then
		ret = 0
	elseif (a == nil) then
		ret = -1
	elseif (b == nil) then
		ret = 1
	elseif (a.name == b.name) then
		ret = 0
	else
		local sa = getCompareStr(a)
		local sb = getCompareStr(b)
		if (sa > sb) then ret = 1 elseif (sa < sb) then ret = -1 end
	end
	return ret
end

local function swap(items, i, j)
	local y = items[i]
	items[i] = items[j]
	items[j] = y
end

local function qsort(items, from, to)
	local i, j = from, to
	local ix = items[i]
	local x = i
	while (i<j) do
		while (j>x) do
			if (compare(items[j], ix) == 1) then
				swap(items, j, x)
				x = j
			else
				j = j - 1
			end
		end
		while (i < x)do
			if (compare(items[i], ix) == -1) then
				swap(items, i, x)
				x = i
			else
				i = i + 1
			end
		end
	end
	if (x - 1 > from) then qsort(items, from, x - 1) end
	if (x + 1 < to) then qsort(items, x + 1, to) end
end

local function jsort(items)
	local clone = {}
	for i = 1, bagSize do clone[i] = items[i] end
	qsort(clone,1,bagSize)
	return clone
end

local function sortTo(_current, _to)
	current = _current
	to = _to
	lockedSlots = {}
	JPACK_STEP = JPACK_PACKING
end

--[[Main Processing]]--
local function moveToSpecialBag(flag)
	local bagTypes = nil
	if flag == 0 then
		bagTypes = JPack.bagSlotTypes
	elseif flag == 1 then
		bagTypes = JPack.bankSlotTypes
		if (not JPack.bankOpened) then return end
	end

	local fromBags = bagTypes[L.TYPE_BAG]
	for k,v in pairs(bagTypes) do
		if k ~= L.TYPE_BAG then 
			local toBags = v
			local frombagIndex, tobagIndex = table.getn(fromBags), table.getn(toBags)
			local frombag, tobag = fromBags[frombagIndex], toBags[tobagIndex]
			local fromslot, toslot = GetContainerNumSlots(frombag), GetContainerNumSlots(tobag)
			local c = 0
			while (true) do
				c = c + 1
				if (c > 300) then 
					break 
				end

				while(tobagIndex > 0 and GetContainerItemLink(tobag, toslot)) do
					tobagIndex,toslot=getPrevSlot(toBags, tobagIndex, toslot)
					tobag = toBags[tobagIndex]
				end

				while(tobagIndex > 0 and frombagIndex > 0 and (not CanGoInBag(frombag, fromslot, tobag))) do
					frombagIndex,fromslot=getPrevSlot(fromBags,frombagIndex,fromslot)
					frombag = fromBags[frombagIndex]
				end

				if (frombagIndex <= 0 or tobagIndex <= 0 or fromslot <= 0 or toslot <= 0) then 
					break
				end

				PickupContainerItem(frombag, fromslot)
				PickupContainerItem(tobag, toslot)
				frombagIndex, fromslot = getPrevSlot(fromBags, frombagIndex, fromslot)
				tobagIndex, toslot = getPrevSlot(toBags, tobagIndex, toslot)
			end
		end
	end
end

local function saveToBank()
	if (not JPack.bankOpened) then return end
	for k,v in pairs(JPack.bankSlotTypes) do
		local bkTypes, bagTypes = JPack.bankSlotTypes[k], JPack.bagSlotTypes[k]
		local bkBag, bag = table.getn(bkTypes), table.getn(bagTypes)
		local bkSlot, slot = GetContainerNumSlots(bkTypes[bkBag]), GetContainerNumSlots(bagTypes[bag])
		while (true) do
			while (bkBag > 0 and GetContainerItemLink(bkTypes[bkBag], bkSlot)) do bkBag, bkSlot = getPrevSlot(bkTypes, bkBag, bkSlot) end
			while (bag > 0 and (not shouldSaveToBank(bagTypes[bag], slot))) do bag, slot = getPrevSlot(bagTypes, bag, slot) end
			if (bkBag <= 0 or bag <= 0 or bkSlot <= 0 or slot <= 0) then break end

			PickupContainerItem(bagTypes[bag], slot)
			PickupContainerItem(bkTypes[bkBag], bkSlot)
			bkBag, bkSlot = getPrevSlot(bkTypes, bkBag, bkSlot)
			bag, slot = getPrevSlot(bagTypes, bag, slot)
		end
	end
end

local function loadFromBank()
	if (not JPack.bankOpened) then return end
	for k,v in pairs(JPack.bankSlotTypes) do
		local bkTypes, bagTypes = JPack.bankSlotTypes[k], JPack.bagSlotTypes[k]
		local bkBag, bag = table.getn(bkTypes), table.getn(bagTypes)
		local bkSlot, slot = GetContainerNumSlots(bkTypes[bkBag]), GetContainerNumSlots(bagTypes[bag])
		while (true) do
			while (bag > 0 and GetContainerItemLink(bagTypes[bag], slot)) do bag, slot = getPrevSlot(bagTypes, bag, slot) end
			while (bkBag > 0 and (not shouldLoadFromBank(bkTypes[bkBag], bkSlot))) do bkBag, bkSlot = getPrevSlot(bkTypes, bkBag, bkSlot) end
			if (bkBag <= 0 or bag <= 0 or bkSlot <= 0 or slot <= 0) then break end

			PickupContainerItem(bkTypes[bkBag], bkSlot)
			PickupContainerItem(bagTypes[bag], slot)
			bkBag, bkSlot = getPrevSlot(bkTypes, bkBag, bkSlot)
			bag, slot = getPrevSlot(bagTypes, bag, slot)
		end
	end
end

local function groupBags()
	local bagTypes = {}
	bagTypes[L.TYPE_BAG] = {}
	bagTypes[L.TYPE_BAG][1] = 0
	for i = 1, 4 do
		local name = GetBagName(i)
		if (name) then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, subType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(name)
			if (bagTypes[subType] == nil) then bagTypes[subType] = {} end
			local t = bagTypes[subType]
			t[table.getn(t) + 1] = i
		end
	end

	local bankSlotTypes = {}
	if (JPack.bankOpened) then
		bankSlotTypes[L.TYPE_BAG] = {}
		bankSlotTypes[L.TYPE_BAG][1]=-1
		for i = 5, 11 do
			local name=GetBagName(i)
			if (name) then
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, subType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(name)
				if (bankSlotTypes[subType] == nil) then bankSlotTypes[subType] = {} end
				local t = bankSlotTypes[subType]
				t[table.getn(t) + 1] = i
			end
		end
	end
	JPack.bagSlotTypes = bagTypes
	JPack.bankSlotTypes = bankSlotTypes
	local j = 1
	for k, v in pairs(bankSlotTypes) do
		JPack.bagGroups[j] = v
		j = j + 1
	end
	for k,v in pairs(bagTypes) do
		JPack.bagGroups[j] = v
		j = j + 1
	end
end

local function getPackingItems()
	local c = 1
	local items = {}
	if JPackDB.asc then
		for i = 1, table.getn(JPack.packingBags) do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			for j = 1, num do
				items[c] = getJPackItem(JPack.packingBags[i], j)
				c = c + 1
			end
		end
	else
		for i = table.getn(JPack.packingBags), 1, -1 do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			for j = num, 1, -1 do
				items[c] = getJPackItem(JPack.packingBags[i], j)
				c = c + 1
			end
		end
	end
	return items, c - 1
end

local function startPack()
	local items, count = getPackingItems()
	bagSize = count
	local sorted = jsort(items)
	sortTo(items, sorted)
end

local function getSlotId(packIndex)
	local slot = packIndex
	if JPackDB.asc then
		for i = 1, table.getn(JPack.packingBags) do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			if (slot <= num) then return JPack.packingBags[i], slot end
			slot = slot - num
		end
	else
		for i = table.getn(JPack.packingBags), 1, -1 do
			local num = GetContainerNumSlots(JPack.packingBags[i]) 
			if (slot <= num) then return JPack.packingBags[i], 1 + num - slot end
			slot = slot - num
		end
	end
	return -1, -1
end

local function moveTo(oldIndex,newIndex)
	PickupContainerItem(getSlotId(oldIndex))
	PickupContainerItem(getSlotId(newIndex))
end

local function isLocked(index)
	local il = IndexOfTable(lockedSlots, index)
	local texture, itemCount, locked, quality, readable = GetContainerItemInfo(getSlotId(index))
	if (texture == nil) then locked = il > 0 elseif (il > 0) then table.remove(lockedSlots, il) end
	return locked
end

local function GetLastItemIndex(items,key)
	local i = bagSize
	while (i > 0) do
		if (items[i] ~= nil and not isLocked(i) and items[i].name  ==  key) then return i end
		i = i - 1
	end
	return -1
end

local function moveOnce()
	local working = false
	local i = 1
	local lockCount = 0
	while to[i] do
		local locked = isLocked(i)
		if (locked == nil) then locked = false end
		if (locked) then lockCount = lockCount + 1 end
		if (lockCount > JPACK_MAXMOVE_ONCE) then return true end
		if (current[i]  ==  nil or to[i].name ~= current[i].name) then
			working = true
			if (not locked) then
				local slot = GetLastItemIndex(current, to[i].name)
				if (slot ~= -1) then
					moveTo(slot, i)
					local x = current[slot]
					current[slot] = current[i]
					current[i] = x
					if (current[slot] == nil) then lockedSlots[table.getn(lockedSlots) + 1] = i end
				end
			end
		end
		i = i + 1
	end
	return working or lockCount > 0
end

local function stackOnce()
	local bags,bag,item,slotInfo
	if (JPack.bankOpened) then bags = {11, 10, 9, 8, 7, 6, 5, -1, 4, 3, 2, 1, 0} else bags = {4, 3, 2, 1, 0} end
	local pendingStack = {}
	local complet=true
	for i = 1,#bags do
		bag = bags[i]
		for slot = GetContainerNumSlots(bag), 1, -1 do
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
			item = getJPackItem(bag, slot)
			if (item) then
				if (not locked) then
					if item.stackCount == nil then item.stackCount = 1 end
					if (item.stackCount ~= 1) and (itemCount < item.stackCount) then
						slotInfo = pendingStack[item.itemid]
						if (slotInfo) then
							PickupContainerItem(bag, slot)
							PickupContainerItem(slotInfo[1], slotInfo[2])
							pendingStack[item.itemid] = nil
							complet = false
						else
							pendingStack[item.itemid] = {bag, slot}
						end
					end
				else
					complet = false
				end
			end
		end
	end
	return complet
end

--[[Events/slash..etc..]]--
local function stopPacking()
	if JPack:GetScript("OnUpdate") then JPack:SetScript("OnUpdate", nil) end
end

JPack.OnLoad = {}
function JPack:BANKFRAME_OPENED() JPack.bankOpened = true end

function JPack:BANKFRAME_CLOSED()
	JPack.bankOpened = false
	stopPacking()
end

JPack:RegisterEvent("ADDON_LOADED")
JPack:RegisterEvent("BANKFRAME_OPENED")
JPack:RegisterEvent("BANKFRAME_CLOSED")

--[[bag/bank packup, onupdate script to move items]]--
local elapsed = 0
function JPack.OnUpdate(self, el)
	elapsed = elapsed + el
	if elapsed < self.updatePeriod then return end
	elapsed = 0
	if JPACK_STEP == JPACK_STARTED then
		if stackOnce() then JPACK_STEP=JPACK_STACK_OVER end
	elseif (JPACK_STEP == JPACK_STACK_OVER) then
		if (isAllBagReady()) then
			moveToSpecialBag(1)
			moveToSpecialBag(0)
			JPACK_STEP = JPACK_SPEC_BAG_OVER
		end
	elseif (JPACK_STEP == JPACK_SPEC_BAG_OVER) then
		if (isAllBagReady()) then
			if (JPack.deposit) then saveToBank() end
			JPACK_STEP=JPACK_DEPOSITING
		end
	elseif (JPACK_STEP == JPACK_DEPOSITING) then
		if (isAllBagReady()) then
			if (JPack.draw) then loadFromBank() end
			JPACK_STEP=JPACK_START_PACK
		end
	elseif (JPACK_STEP == JPACK_START_PACK) then
		if (isAllBagReady()) then
			JPack.packingGroupIndex = 1
			JPack.packingBags=JPack.bagGroups[1]
			startPack()
			JPACK_STEP = JPACK_PACKING
		end
	elseif (JPACK_STEP == JPACK_PACKING) then
		if not moveOnce() then
			JPack.packingGroupIndex=JPack.packingGroupIndex + 1
			JPack.packingBags = JPack.bagGroups[JPack.packingGroupIndex]
			if (JPack.packingBags  ==  nil) then
				JPACK_STEP=JPACK_STOPPED
				JPack.bagGroups = {}
				JPack:SetScript("OnUpdate",nil)
				current = nil
				to = nil
			else
				startPack()
			end
		end
	end
end

local function pack()
	JPACK_STEP=JPACK_STARTED
	groupBags()
	elapsed = 1
	JPack:SetScript("OnUpdate", JPack.OnUpdate)
end

--[[API - JPack:Pack(access, order)
access: 1 => save, 2 => load, nil => just pack the bag (and bank)
order: 1 => asc, 2 => desc, nil => last-time-order]]--
function JPack:Pack(access, order)
	JPack.deposit = false
	JPack.draw = false
	if access == 1 then JPack.deposit = true elseif access == 2 then JPack.draw = true end
	if order == 1 then JPackDB.asc = true elseif order == 2 then JPackDB.asc = false end
	pack()
end