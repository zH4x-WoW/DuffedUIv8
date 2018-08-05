local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded('AddOnSkins') then return end

local function LoadSkin()
	local buttons = {
		'BarberShopFrameOkayButton',
		'BarberShopFrameCancelButton',
		'BarberShopFrameResetButton'
	}
	BarberShopFrameOkayButton:Point('RIGHT', BarberShopFrameSelector4, 'BOTTOM', 2, -50)

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	for i = 1, 5 do
		local f = _G['BarberShopFrame'..i]
		if f then f:StripTextures() end
	end

	BarberShopFrameResetButton:ClearAllPoints()
	BarberShopFrameResetButton:Point('BOTTOM', 0, 12)

	BarberShopFrame:StripTextures()
	BarberShopFrame:SetTemplate('Transparent')
	BarberShopFrame:Size(BarberShopFrame:GetWidth() - 30, BarberShopFrame:GetHeight() - 56)

	BarberShopFrameMoneyFrame:StripTextures()
	BarberShopFrameMoneyFrame:CreateBackdrop('Overlay')

	BarberShopBannerFrameBGTexture:Kill()
	BarberShopBannerFrame:Kill()
	
	BarberShopBannerFrameCaption:ClearAllPoints()
	BarberShopBannerFrameCaption:Point('TOP', BarberShopFrame, 0, 0)
	BarberShopBannerFrameCaption:SetParent(BarberShopFrame)
	
	BarberShopAltFormFrameBorder:StripTextures()
	BarberShopAltFormFrame:Point('BOTTOM', BarberShopFrame, 'TOP', 0, 5)
	BarberShopAltFormFrame:StripTextures()
	BarberShopAltFormFrame:CreateBackdrop('Default')
end
D['SkinFuncs']['Blizzard_BarbershopUI'] = LoadSkin