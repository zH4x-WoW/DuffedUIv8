local D, C, L = unpack(select(2, ...))

local UniqueCache = {}
local Postmaster = {
	-- Lost item guy
	["Thaumaturge Vashreen"] = true,

	-- The Postmaster
	["The Postmaster"] = true,
	["Der Postmeister"] = true,
	["El Jefe de correos"] = true,
	["Le maître de poste"] = true,
	["Il Postino"] = true,
	["O Chefe do Correio"] = true,
	["Почтальон"] = true,
}

local ITEM_UNIQUE_MULTIPLE, ITEM_UNIQUE = ITEM_UNIQUE_MULTIPLE:gsub("%(%%d%)", "%%((%d+)%%)"), ITEM_UNIQUE
local ScanTip = CreateFrame("GameTooltip", "PostmasterTooltip", nil, "GameTooltipTemplate")
local function GetUnique(itemLink)
	if itemLink then
		if UniqueCache[itemLink] then return UniqueCache[itemLink] end
		ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
		ScanTip:SetHyperlink(itemLink)
		local numLines = ScanTip:NumLines()
		for i = 1, numLines do
			local line = _G["PostmasterTooltipTextLeft" .. i]
			if line then
				local text = line:GetText() or ""
				local quantity = text:match(ITEM_UNIQUE_MULTIPLE)
				if text == ITEM_UNIQUE or quantity then
					UniqueCache[itemLink] = (quantity or 1) + 0
					return UniqueCache[itemLink]
				end
			end
		end
		if numLines > 0 then UniqueCache[itemLink] = false end
	end
end

local function HasSpaceFor(itemLink, itemCount)
	if GetUnique(itemLink) then return false end

	if not itemCount then itemCount = 1 end
	local stackSize = select(8, GetItemInfo(itemLink))
	if itemCount < stackSize then
		for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				local texture, containerCount, locked, quality, readable, lootable, containerLink = GetContainerItemInfo(bag, slot)
				if not locked and containerLink == itemLink and containerCount + itemCount <= stackSize then return true end
			end
		end
	end

	local itemFamily = GetItemFamily(itemLink)
	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local freeSlots, bagFamily = GetContainerNumFreeSlots(i)
		if (bagFamily == 0 or ( itemFamily and bit.band(itemFamily, bagFamily) > 0 )) and freeSlots > 0 then return true end
	end
	return false
end

local f = CreateFrame("Frame")
f:Hide()

local timesince = 0
f:SetScript("OnUpdate", function(self, elapsed)
	timesince = timesince + elapsed
	if timesince >= .1 then
		for i = GetInboxNumItems(), 1, -1 do
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i)
			if Postmaster[sender] then
				if money and money > 0 then TakeInboxMoney(i) end

				if hasItem then
					for j = 1, ATTACHMENTS_MAX_RECEIVE do
						local name, texture, count, quality, canUse = GetInboxItem(i, j)
						local itemLink = GetInboxItemLink(i, j)
						if itemLink and HasSpaceFor(itemLink, count) then TakeInboxItem(i, j) end
					end
				elseif InboxItemCanDelete(i) then
					DeleteInboxItem(i)
				end
			end
		end
		timesince = 0
	end
end)

f:SetScript("OnEvent", function(self, event, ...) self:SetShown(event == "MAIL_SHOW") end)
f:RegisterEvent("MAIL_SHOW")
f:RegisterEvent("MAIL_CLOSED")