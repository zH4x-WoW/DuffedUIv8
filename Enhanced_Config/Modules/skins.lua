if not (Tukui or AsphyxiaUI or DuffedUI) then return end
local E, L, V, P, G = unpack(ElvUI)
local S = E:NewModule('Skins', 'AceTimer-3.0', 'AceHook-3.0', 'AceEvent-3.0')

function S:HandleButton(self, strip)
	self:SkinButton(strip)
end

function S:HandleScrollBar(self, thumbTrim)
	self:SkinScrollBar()
end

function S:HandleTab(self)
	self:SkinTab()
end

function S:HandleNextPrevButton(self, horizonal)
	self:SkinNextPrevButton(horizonal)
end

function S:HandleRotateButton(self)
	self:SkinRotateButton()
end

function S:HandleEditBox(self)
	self:SkinEditBox()
end

function S:HandleDropDownBox(self, width)
	self:SkinDropDownBox(width)
end

function S:HandleCheckBox(self)
	self:SkinCheckBox()
end

function S:HandleItemButton(self, shrinkIcon)
	self:SkinIconButton(shrinkIcon)
end

function S:HandleCloseButton(self, point, text)
	self:SkinCloseButton()
end

function S:HandleSliderFrame(self)
	self:SkinSlideBar(12)
end

ElvUI[1]:RegisterModule(S:GetName())