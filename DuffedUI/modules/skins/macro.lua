local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	MacroFrameCloseButton:SkinCloseButton()
	MacroButtonScrollFrameScrollBar:SkinScrollBar()
	MacroFrameScrollFrameScrollBar:SkinScrollBar()
	MacroPopupScrollFrameScrollBar:SkinScrollBar()
	MacroFrame:Width(360)

	local buttons = {
		"MacroSaveButton",
		"MacroCancelButton",
		"MacroDeleteButton",
		"MacroNewButton",
		"MacroExitButton",
		"MacroEditButton",
		"MacroFrameTab1",
		"MacroFrameTab2",
		"MacroPopupOkayButton",
		"MacroPopupCancelButton",
	}
	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end
	
	local frames = {
		"MacroButtonScrollFrameMiddle",
		"MacroButtonScrollFrameTop",
		"MacroButtonScrollFrameBottom",
		"MacroPopupScrollFrameMiddle",
		"MacroPopupScrollFrameTop",
		"MacroPopupScrollFrameBottom",
	}
	for i = 1, #frames do _G[frames[i]]:SetTexture(nil) end

	for i = 1, 2 do
		local tab = _G[format("MacroFrameTab%s", i)]
		tab:Height(22)
	end

	MacroFrameTab1:Point("TOPLEFT", MacroFrame, "TOPLEFT", 85, -39)
	MacroFrameTab2:Point("LEFT", MacroFrameTab1, "RIGHT", 4, 0)

	-- General
	MacroFrame:StripTextures()
	MacroFrame:SetTemplate("Transparent")
	MacroFrameTextBackground:StripTextures()
	MacroFrameTextBackground:SetTemplate('Default')
	MacroPopupEditBox:SkinEditBox()
	MacroPopupNameLeft:SetTexture(nil)
	MacroPopupNameMiddle:SetTexture(nil)
	MacroPopupNameRight:SetTexture(nil)
	MacroFrameInset:Kill()

	--Reposition edit button
	MacroEditButton:ClearAllPoints()
	MacroEditButton:Point("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)

	-- Big icon
	MacroFrameSelectedMacroButton:StripTextures()
	MacroFrameSelectedMacroButton:StyleButton(true)
	MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
	MacroFrameSelectedMacroButton:SetTemplate("Default")
	MacroFrameSelectedMacroButtonIcon:SetTexCoord(unpack(D["IconCoord"]))
	MacroFrameSelectedMacroButtonIcon:SetInside()

	-- temporarily moving this text
	MacroFrameCharLimitText:ClearAllPoints()
	MacroFrameCharLimitText:Point("BOTTOM", MacroFrameTextBackground, 0, -15)

	-- Skin all buttons
	for i = 1, MAX_ACCOUNT_MACROS do
		local b = _G["MacroButton"..i]
		local t = _G["MacroButton"..i.."Icon"]
		if b then
			b:StripTextures()
			b:StyleButton(true)
			b:SetTemplate("Default", true)
		end
		if t then
			t:SetTexCoord(unpack(D["IconCoord"]))
			t:SetInside()
		end
	end

	--Icon selection frame
	ShowUIPanel(MacroFrame)
	HideUIPanel(MacroFrame)
	MacroPopupFrame:Show()
	MacroPopupFrame:Hide()
	SkinIconSelectionFrame(MacroPopupFrame, NUM_MACRO_ICONS_SHOWN, "MacroPopupButton", "MacroPopup")
	MacroPopupFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:Point("TOPLEFT", MacroFrame, "TOPRIGHT", 2, 0)
	end)
end

D.SkinFuncs["Blizzard_MacroUI"] = LoadSkin