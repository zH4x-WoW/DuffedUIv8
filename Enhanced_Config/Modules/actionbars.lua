if not (Tukui or AsphyxiaUI or DuffedUI) then return end
local E, L, V, P, G = unpack(ElvUI)
local AB = E:NewModule('ActionBars', 'AceHook-3.0', 'AceEvent-3.0');

function AB:StyleButton(self, noBackdrop)	
	self:SkinIconButton()
end

ElvUI[1]:RegisterModule(AB:GetName())