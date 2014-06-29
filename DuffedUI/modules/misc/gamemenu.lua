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
end

Miscellaneous.GameMenu = GameMenu