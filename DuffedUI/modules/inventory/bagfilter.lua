local D, C, L = select(2, ...):unpack()
if (not C["bags"].BagFilter) then return end

local Inventory = D["Inventory"]
local BagFilter = CreateFrame("Frame")
local Count
local Link

BagFilter.Trash = {
	32902, -- Bottled Nethergon Energy
	32905, -- Bottled Nethergon Vapor
	32897, -- Mark of the Illidari
}

function BagFilter:OnEvent()
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			Count = select(2, GetContainerItemInfo(bag, slot))
			Link = select(7, GetContainerItemInfo(bag, slot))

			for i = 1, #self.Trash do
				if (Link and (GetItemInfo(Link) == GetItemInfo(self.Trash[i]))) then
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
				end
			end
		end
	end
end

function BagFilter:Enable()
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:SetScript("OnEvent", self.OnEvent)
end

function BagFilter:Disable()
	self:UnregisterEvent("CHAT_MSG_LOOT")
	self:SetScript("OnEvent", nil)
end

Inventory.BagFilter = BagFilter