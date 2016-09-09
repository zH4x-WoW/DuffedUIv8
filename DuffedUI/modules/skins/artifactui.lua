local D, C, L = unpack(select(2, ...))

local function ArtifactSkin()
	ArtifactFrame:StripTextures()
	ArtifactFrame:SetTemplate("Transparent")
	ArtifactFrame:CreateBackdrop()
	ArtifactFrame.CloseButton:SkinCloseButton()
	
	ArtifactFrame.BorderFrame:StripTextures()

	for i = 1, 2 do
		_G["ArtifactFrameTab" .. i]:SkinTab()
	end
	ArtifactFrameTab1:ClearAllPoints()
	ArtifactFrameTab1:SetPoint("TOPLEFT", ArtifactFrame, "BOTTOMLEFT", 0, -2)

	--[[Link ArtifactSpells to Chat =>Shift + Click]]--
	local oldOnClick = ArtifactPowerButtonMixin.OnClick
	function ArtifactPowerButtonMixin:OnClick(button)
		if IsModifiedClick("CHATLINK") then ChatEdit_InsertLink(GetSpellLink(self.spellID)) else oldOnClick(self, button) end
	end
end

D.SkinFuncs["Blizzard_ArtifactUI"] = ArtifactSkin