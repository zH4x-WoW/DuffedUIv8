local D, C, L = select(2, ...):unpack()

local Miscellaneous = D["Miscellaneous"]
local GameMenu = CreateFrame("Frame")
local Menu = GameMenuFrame
local Header = GameMenuFrameHeader
local Logout = GameMenuButtonLogout
local Addons = GameMenuButtonAddons

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
	"WhatsNew",
	"Addons"
}

function GameMenu:AddHooks()
	Menu:HookScript("OnShow", function(self)
		self:SetHeight(self:GetHeight() + Addons:GetHeight() - 4)
	end)
end

function GameMenu:EnableDuffedUIConfig()
	local DuffedUI = CreateFrame("Button", nil, Menu, "GameMenuButtonTemplate")
	DuffedUI:Size(Logout:GetWidth(), Logout:GetHeight())
	DuffedUI:SkinButton()
	DuffedUI:Point("TOPLEFT", GameMenuButtonAddons, "BOTTOMLEFT", 0, -2)
	DuffedUI:SetText("DuffedUI")
	DuffedUI:SetScript("OnClick", function(self)
		if (not DuffedUIConfigFrame) then
			DuffedUIConfig:CreateConfigWindow()
		end

		if DuffedUIConfigFrame:IsVisible() then
			DuffedUIConfigFrame:Hide()
		else
			DuffedUIConfigFrame:Show()
		end

		HideUIPanel(Menu)
	end)

	Logout:ClearAllPoints()
	Logout:Point("TOPLEFT", DuffedUI, "BOTTOMLEFT", 0, -2)

	self:AddHooks()
	self.DuffedUI = DuffedUI
end

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

	if DuffedUIConfig then
		self:EnableDuffedUIConfig()
	end
end

Miscellaneous.GameMenu = GameMenu