local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	local buttons = {
		"defaultsButton",
		"unbindButton",
		"okayButton",
		"cancelButton",
	}

	for _, v in pairs(buttons) do
		KeyBindingFrame[v]:StripTextures()
		KeyBindingFrame[v]:SkinButton()
	end

	KeyBindingFrame:StripTextures()
	KeyBindingFrame:SetTemplate("Transparent")
	KeyBindingFrameScrollFrameScrollBar:SkinScrollBar()
	KeyBindingFrameCategoryList:StripTextures()
	KeyBindingFrameCategoryList:SetTemplate("Default")
	KeyBindingFrame.bindingsContainer:StripTextures()
	KeyBindingFrame.bindingsContainer:SetTemplate("Default")
	KeyBindingFrame.header:StripTextures()
	KeyBindingFrame.characterSpecificButton:SkinCheckBox()
	KeyBindingFrame.header:ClearAllPoints()
	KeyBindingFrame.header:Point("TOP", KeyBindingFrame, "TOP", 0, -4)

	for i = 1, KEY_BINDINGS_DISPLAYED  do
		local button1 = _G["KeyBindingFrameKeyBinding"..i.."Key1Button"]
		local button2 = _G["KeyBindingFrameKeyBinding"..i.."Key2Button"]
		button1:StripTextures(true)
		button1:StyleButton(false)
		button1:SetTemplate("Default", true)
		button2:StripTextures(true)
		button2:StyleButton(false)
		button2:SetTemplate("Default", true)
	end
end

D.SkinFuncs["Blizzard_BindingUI"] = LoadSkin