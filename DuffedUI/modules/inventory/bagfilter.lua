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

function BagFilter:OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		self:AddItemsToDescription()
	else
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
end

function BagFilter:AddItemsToDescription()
	if (not IsAddOnLoaded("DuffedUI_Config")) then return end

	local Locale = GetLocale()
	local Group = DuffedUIConfig[Locale]["Bags"]["BagFilter"]

	if Group then
		local Desc = Group.Desc
		local Items = Desc .. "\n\nTrash List:\n"

		for i = 1, #self.Trash do
			local Name, Link = GetItemInfo(self.Trash[i])

			if (Name and Link) then
				if i == 1 then
					Items = Items .. "" .. Link
				else
					Items = Items .. ", " .. Link
				end
			end
		end
		DuffedUIConfig[Locale]["bags"]["BagFilter"]["Desc"] = Items
	end
end

function BagFilter:Enable()
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", self.OnEvent)
end

function BagFilter:Disable()
	self:UnregisterEvent("CHAT_MSG_LOOT")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", nil)
end

Inventory.BagFilter = BagFilter