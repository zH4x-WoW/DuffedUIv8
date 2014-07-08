local D, C, L = select(2, ...):unpack()

local Miscellaneous = D["Miscellaneous"]
local GameMenu = CreateFrame("Frame")
local Menu = GameMenuFrame
local Header = GameMenuFrameHeader

GameMenu.Buttons = {
	"Options",
	"SoundOptions",
	"UIOptions",
	"Keybindings",
	"Macros",
	"Ratings",
	"AddOns",
	"Logout",
	"Quit",
	"Continue",
	"MacOptions",
	"Help",
	"Store",
}

function GameMenu:Enable()
	local menu = GameMenuFrame
	local menuy = menu:GetHeight()
	local quit = GameMenuButtonQuit
	local continue = GameMenuButtonContinue
	local continuex = continue:GetWidth()
	local continuey = continue:GetHeight()
	local interface = GameMenuButtonUIOptions
	local keybinds = GameMenuButtonKeybindings
	local Config = DuffedUIConfig

	menu:SetHeight(menuy + continuey)

	local button = CreateFrame("BUTTON", "GameMenuDuffedUIButtonOptions", menu, "GameMenuButtonTemplate")
	button:SetSize(continuex, continuey)
	button:Point("TOP", interface, "BOTTOM", 0, -1)
	button:SetText("DuffedUI")

	button:SkinButton()

	button:SetScript("OnClick", function(self)
		if (not DuffedUIConfigFrame) then
			Config:CreateConfigWindow()
		end

		if DuffedUIConfigFrame:IsVisible() then
			DuffedUIConfigFrame:Hide()
		else
			DuffedUIConfigFrame:Show()
			HideUIPanel(menu)
		end
	end)
	
	Header:SetTexture("")
	Header:ClearAllPoints()
	Header:SetPoint("TOP", Menu, 0, 7)

	Menu:SetTemplate("Transparent")
	Menu:CreateShadow()

	for i = 1, #self.Buttons do
		local Button = _G["GameMenuButton"..self.Buttons[i]]
		if (Button) then
			Button:SkinButton()
		end
	end
	if GameMenuFrame_UpdateVisibleButtons then
		hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function()
			GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + GameMenuButtonStore:GetHeight() + 25)
		end)
	end
end

Miscellaneous.GameMenu = GameMenu