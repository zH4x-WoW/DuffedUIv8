-------------------------------------------------------
-- Temporary file to build DuffedUI from a clean UI! --
-------------------------------------------------------

--[[local D, C, L = select(2, ...):unpack()

if 1 == 1 then return end

local Dropdown = CreateFrame("Button", "DropDownMenuX", UIParent, "UIDropDownMenuTemplate")

Dropdown:ClearAllPoints()
Dropdown:SetPoint("CENTER", 0, 0)
Dropdown:Show()

local FontChoices = {
	"DuffedUI",
	"DuffedUI_UF",
	"Pixel",
}

local Fonts = {
	["DuffedUI"] = DuffedUIFont,
	["DuffedUI_UF"] = DuffedUIUFFont,
	["Pixel"] = DuffedUIPixelFont,
}

local OnClick = function(self)
	UIDropDownMenu_SetSelectedID(Dropdown, self:GetID())

	print(self.value, Fonts[self.value])
end

local Initialize = function(self, level)
	local Info = UIDropDownMenu_CreateInfo()

	for k, v in pairs(Fonts) do
		Info = UIDropDownMenu_CreateInfo()
		Info.text = k
		Info.value = k
		Info.func = OnClick
		Info.fontObject = v
		UIDropDownMenu_AddButton(Info, level)
	end
end

UIDropDownMenu_Initialize(Dropdown, Initialize)
UIDropDownMenu_SetWidth(Dropdown, 90)
UIDropDownMenu_SetButtonWidth(Dropdown, 24)
UIDropDownMenu_SetSelectedID(Dropdown, 1)
Dropdown:SkinDropDown(90)]]--