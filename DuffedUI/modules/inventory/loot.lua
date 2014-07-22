local D, C, L = select(2, ...):unpack()

local Inventory = D["Inventory"]
local Loot = CreateFrame("Frame")
local LootFrame = LootFrame
local LootFrameInset = LootFrameInset
local LootFramePortraitOverlay = LootFramePortraitOverlay
local LootFrameCloseButton = LootFrameCloseButton
local TopFrame = CreateFrame("Frame", nil, LootFrame)
local ItemText = select(19, LootFrame:GetRegions())

function Loot:SkinLootFrame()
	LootFrame:StripTextures()
	LootFrameInset:StripTextures()
	LootFrameInset:CreateBackdrop("Transparent")
	LootFrameInset.Backdrop:CreateShadow()
	LootFramePortraitOverlay:SetAlpha(0)
	
	LootFrameDownButton:StripTextures()
	LootFrameDownButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameDownButton:SkinButton()
	LootFrameDownButton:FontString("Text", C["medias"].Font, 12)
	LootFrameDownButton.Text:SetPoint("CENTER")
	LootFrameDownButton.Text:SetText(NEXT)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:Point("TOP", LootFrame, "BOTTOM", -1, -1)
	LootFrameDownButton:CreateShadow()
	LootFrameNext:SetAlpha(0)

	LootFrameUpButton:StripTextures()
	LootFrameUpButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameUpButton:SkinButton()
	LootFrameUpButton:FontString("Text", C["medias"].Font, 12)
	LootFrameUpButton.Text:SetPoint("CENTER")
	LootFrameUpButton.Text:SetText(PREV)
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:Point("TOP", LootFrameDownButton, "BOTTOM", 0, -2)
	LootFrameUpButton:CreateShadow()
	LootFramePrev:SetAlpha(0)

	TopFrame:Size(LootFrame:GetWidth() - 6, 23)
	TopFrame:SetFrameLevel(LootFrame:GetFrameLevel())
	TopFrame:Point("TOPLEFT", 2, -32)
	TopFrame:SetTemplate("Transparent")
	TopFrame:CreateShadow()

	LootFrameCloseButton:SkinCloseButton()
	LootFrameCloseButton:ClearAllPoints()
	LootFrameCloseButton:SetPoint("RIGHT", TopFrame, "RIGHT", 8, 0)

	ItemText:ClearAllPoints()
	ItemText:SetPoint("LEFT", TopFrame, "LEFT", 6, 0)
end

function Loot:SkinLootFrameButtons(i)
	for i = 1, LootFrame.numLootItems do
		local Button = _G["LootButton" .. i]
		if (Button) and (not Button.IsSkinned) then
			local Icon = _G["LootButton" .. i .. "IconTexture"]
			local Quest = _G["LootButton" .. i .. "IconQuestTexture"]
			local IconTexture = Icon:GetTexture()
			
			Button:StripTextures()
			Button:CreateBackdrop()
			Button.Backdrop:SetOutside(Icon)
			
			Icon:SetTexture(IconTexture)
			Icon:SetTexCoord(unpack(D.IconCoord))
			Icon:SetInside()
			
			Quest:SetAlpha(0) -- NOTE : RECOLOR BORDER WHEN SHOW WITH YELLOW QUEST COLOR
			
			Button.IsSkinned = true
		end
	end
end

function Loot:AddHooks()
	hooksecurefunc("LootFrame_UpdateButton", self.SkinLootFrameButtons)
end

function Loot:Enable()
	self:SkinLootFrame()
	self:AddHooks()
end

Inventory.Loot = Loot