local D, C, L = unpack(select(2, ...))

local function OFSkin()
	ObliterumForgeFrame:SetTemplate("Transparent")
	ObliterumForgeFramePortrait:Hide()
	ObliterumForgeFramePortraitFrame:Hide()
	ObliterumForgeFrameBg:Hide()

	ObliterumForgeFrameCloseButton:SkinCloseButton()
	ObliterumForgeFrame.ObliterateButton:SkinButton()
end

D.SkinFuncs["Blizzard_ObliterumUI"] = OFSkin