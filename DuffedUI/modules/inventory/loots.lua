local D, C, L = select(2, ...):unpack()
local Inventory = T["Inventory"]
local LootFrame = LootFrame
local LootFrameInset = LootFrameInset
local LootFramePortraitOverlay = LootFramePortraitOverlay
local LootFrameCloseButton = LootFrameCloseButton
local TopFrame = CreateFrame("Frame", nil, LootFrame)
local ItemText = select(19, LootFrame:GetRegions())

function Inventory:SkinLootFrame()
	LootFrame:StripTextures()
	LootFrameInset:StripTextures()
	LootFrameInset:CreateBackdrop("Transparent")
	LootFrameInset.Backdrop:CreateShadow()
	LootFramePortraitOverlay:SetAlpha(0)

	TopFrame:Size(LootFrame:GetWidth() - 6, 23)
	TopFrame:SetFrameLevel(LootFrame:GetFrameLevel())
	TopFrame:Point("TOPLEFT", 2, -33)
	TopFrame:SetTemplate("Transparent")
	TopFrame:CreateShadow()

	LootFrameCloseButton:SkinCloseButton()
	LootFrameCloseButton:ClearAllPoints()
	LootFrameCloseButton:SetPoint("RIGHT", TopFrame, "RIGHT", 8, 0)

	ItemText:ClearAllPoints()
	ItemText:SetPoint("LEFT", TopFrame, "LEFT", 6, 0)
end

function Inventory:SkinLootFrameButtons(i)
	for i = 1, LootFrame.numLootItems do
		local Button = _G["LootButton" .. i]
		if (Button) and (not Button.IsSkinned) then
			local Icon = _G["LootButton" .. i .. "IconTexture"]
			local IconTexture = Icon:GetTexture()
			
			Button:StripTextures()
			Button:CreateBackdrop()
			Button.Backdrop:SetOutside(Icon)
			
			Icon:SetTexture(IconTexture)
			Icon:SetTexCoord(unpack(T.IconCoord))
			Icon:SetInside()
			
			Button.IsSkinned = true
		end
	end
end

function Inventory:AddLootFrameHooks()
	hooksecurefunc("LootFrame_UpdateButton", self.SkinLootFrameButtons)
end