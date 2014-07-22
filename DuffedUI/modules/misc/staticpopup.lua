local D, C, L = select(2, ...):unpack()

local Miscellaneous = D["Miscellaneous"]
local StaticPopups = CreateFrame("Frame")

StaticPopups.Popups = {
	StaticPopup1,
	StaticPopup2,
	StaticPopup3,
	StaticPopup4,
}

function StaticPopups:Skin()
	local Button1, Button2 = _G[self:GetName().."Button1"], _G[self:GetName().."Button2"]

	self:StripTextures()
	self:SetTemplate()
	self:CreateShadow()

	Button1:SkinButton()
	Button2:SkinButton()
end

function StaticPopups:Enable()
	for _, Frame in pairs(StaticPopups.Popups) do
		self.Skin(Frame)
	end
end

Miscellaneous.StaticPopups = StaticPopups