local D, C, L = unpack(select(2, ...))

local _G = _G
local unpack = unpack
local BAG_ITEM_QUALITY_COLORS = BAG_ITEM_QUALITY_COLORS
local hooksecurefunc = hooksecurefunc

local function LoadScrapUISkin()
	local MachineFrame = _G['ScrappingMachineFrame']
    MachineFrame:StripTextures()
    MachineFrame:SetTemplate('Transparent')
	ScrappingMachineFrameInset:Hide()
	MachineFrame.ScrapButton.LeftSeparator:Hide()
	MachineFrame.ScrapButton.RightSeparator:Hide()
	ScrappingMachineFrameCloseButton:SkinCloseButton()
	MachineFrame.ScrapButton:SkinButton()

	local function refreshIcon(self)
		local quality = 1
        if self.itemLocation and not self.item:IsItemEmpty() and self.item:GetItemName() then quality = self.item:GetItemQuality() end
        
		local color = BAG_ITEM_QUALITY_COLORS[quality]
		if color and self.itemLocation and not self.item:IsItemEmpty() and self.item:GetItemName() then self.backdrop:SetBackdropBorderColor(color.r, color.g, color.b) else self.backdrop:SetBackdropBorderColor(nil) end
	end

	local ItemSlots = MachineFrame.ItemSlots
	ItemSlots:StripTextures()

	for button in pairs(ItemSlots.scrapButtons.activeObjects) do
		if not button.styled then
			button:CreateBackdrop('Default')
			button.Icon:SetTexCoord(unpack(D['IconCoord']))
			button.IconBorder:SetAlpha(0)
			hooksecurefunc(button, 'RefreshIcon', refreshIcon)

			button.styled = true
		end
	end
end
D['SkinFuncs']['Blizzard_ScrappingMachineUI'] = LoadScrapUISkin