local D, C, L = unpack(select(2, ...))

local _G = _G
local select = select

local function LoadAzeriteUISkin()
    AzeriteEmpoweredItemUI:StripTextures()
    AzeriteEmpoweredItemUI:SetTemplate('Transparent')
	AzeriteEmpoweredItemUI.BorderFrame:StripTextures()
	AzeriteEmpoweredItemUIPortrait:Hide()
	AzeriteEmpoweredItemUIPortraitFrame:Hide()
	AzeriteEmpoweredItemUITopBorder:Hide()
	AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame.Bg:Hide()
	AzeriteEmpoweredItemUI.ClipFrame.BackgroundFrame.KeyOverlay.Shadow:Hide()

	AzeriteEmpoweredItemUICloseButton:SkinCloseButton()
end

local function SkinEtheralFrame(frame)
	frame.CornerTL:Hide()
	frame.CornerTR:Hide()
	frame.CornerBL:Hide()
	frame.CornerBR:Hide()

	local name = frame:GetName()
	_G[name..'LeftEdge']:Hide()
	_G[name..'RightEdge']:Hide()
	_G[name..'TopEdge']:Hide()
	_G[name..'BottomEdge']:Hide()

	local bg = select(23, frame:GetRegions())
	bg:ClearAllPoints()
	bg:SetPoint('TOPLEFT', -50, 25)
	bg:SetPoint('BOTTOMRIGHT')
	bg:SetTexture([[Interface\Transmogrify\EtherealLines]], true, true)
	bg:SetHorizTile(true)
	bg:SetVertTile(true)
	bg:SetAlpha(0.5)
end

local function LoadAzeriteRespecSkin()
	local AzeriteRespecFrame = _G['AzeriteRespecFrame']
	AzeriteRespecFrame:SetClipsChildren(true)
	AzeriteRespecFrame.Background:Hide()
	SkinEtheralFrame(AzeriteRespecFrame)

	AzeriteRespecFramePortraitFrame:Hide()
	AzeriteRespecFramePortrait:Hide()
	AzeriteRespecFrameTitleBg:Hide()
	AzeriteRespecFrameTopBorder:Hide()
	AzeriteRespecFrameTopRightCorner:Hide()
	AzeriteRespecFrameRightBorder:Hide()
	AzeriteRespecFrameLeftBorder:Hide()
	AzeriteRespecFrameBottomBorder:Hide()
	AzeriteRespecFrameBotRightCorner:Hide()
	AzeriteRespecFrameBotLeftCorner:Hide()
	AzeriteRespecFrameBg:Hide()

	local ItemSlot = AzeriteRespecFrame.ItemSlot
	ItemSlot:SetSize(64, 64)
	ItemSlot:SetPoint('CENTER', AzeriteRespecFrame)
	ItemSlot.Icon:ClearAllPoints()
	ItemSlot.Icon:SetPoint('TOPLEFT', 1, -1)
	ItemSlot.Icon:SetPoint('BOTTOMRIGHT', -1, 1)
	ItemSlot.GlowOverlay:SetAlpha(0)

	AzeriteRespecFrame.ItemSlot:CreateBackdrop('Transparent')
	AzeriteRespecFrame.ItemSlot.backdrop:SetBackdropColor(153/255, 0/255, 153/255, 0.5)
	AzeriteRespecFrame.ItemSlot.Icon:SkinCropIcon()

	local ButtonFrame = AzeriteRespecFrame.ButtonFrame
	ButtonFrame:GetRegions():Hide()
	ButtonFrame.ButtonBorder:Hide()
	ButtonFrame.ButtonBottomBorder:Hide()

	ButtonFrame.MoneyFrameEdge:Hide()
	ButtonFrame.MoneyFrame:ClearAllPoints()
	ButtonFrame.MoneyFrame:SetPoint('BOTTOMRIGHT', ButtonFrame.MoneyFrameEdge, 7, 5)

	AzeriteRespecFrame:CreateBackdrop('Transparent')
	AzeriteRespecFrame.backdrop:SetAllPoints()

	AzeriteRespecFrame.ButtonFrame.AzeriteRespecButton:SkinButton()
	AzeriteRespecFrameCloseButton:SkinCloseButton()
end

D['SkinFuncs']['Blizzard_AzeriteUI'] = LoadAzeriteUISkin
D['SkinFuncs']['Blizzard_AzeriteRespecUI'] = LoadAzeriteRespecSkin