local D, C, L = unpack(select(2, ...))

local function LoadGarrisonSkin()
	-- Tooltips
	local Tooltips = {
		FloatingGarrisonFollowerTooltip,
		FloatingGarrisonFollowerAbilityTooltip,
		FloatingGarrisonMissionTooltip,
		GarrisonFollowerAbilityTooltip,
		GarrisonBuildingFrame.BuildingLevelTooltip,
	}
	for i, tt in pairs(Tooltips) do
		tt.Background:SetTexture(nil)
		tt.BorderTop:SetTexture(nil)
		tt.BorderTopLeft:SetTexture(nil)
		tt.BorderTopRight:SetTexture(nil)
		tt.BorderLeft:SetTexture(nil)
		tt.BorderRight:SetTexture(nil)
		tt.BorderBottom:SetTexture(nil)
		tt.BorderBottomRight:SetTexture(nil)
		tt.BorderBottomLeft:SetTexture(nil)
		tt:SetTemplate("Transparent")

		if tt.Portrait then tt.Portrait:StripTextures() end
		if tt.CloseButton then tt.CloseButton:SkinCloseButton() end
		if tt.Icon then tt.Icon:SetTexCoord(unpack(D.IconCoord)) end
	end

	-- Work Orders
	GarrisonCapacitiveDisplayFrame:StripTextures()
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")
	GarrisonCapacitiveDisplayFramePortrait:Kill()
	GarrisonCapacitiveDisplayFrameInset:StripTextures()
	GarrisonCapacitiveDisplayFrameCloseButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:StripTextures()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:ClearAllPoints()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:Point("BOTTOMRIGHT", GarrisonCapacitiveDisplayFrame, "BOTTOMRIGHT", -9, 4)
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay:StripTextures()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay:SetTemplate()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame:SetTemplate()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(unpack(D.IconCoord))
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame.Icon:SetInside()

	local function Reagents()
		for i, v in ipairs(GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.Reagents) do
			local Texture = v.Icon:GetTexture()

			v:StripTextures()
			v:StyleButton()
			v:CreateBackdrop()
			v.Icon:SetTexture(Texture)
			v.backdrop:ClearAllPoints()
			v.backdrop:SetOutside(v.Icon)
			v.Icon:SetTexCoord(unpack(D.IconCoord))
			v.NameFrame:Hide()
		end
	end
	hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", Reagents)

	-- Follower Recruiting
	GarrisonRecruiterFrame:StripTextures()
	GarrisonRecruiterFrame:SetTemplate("Transparent")
	GarrisonRecruiterFramePortrait:Kill()
	GarrisonRecruiterFrameInset:StripTextures()
	GarrisonRecruiterFrameInset:SetTemplate()
	GarrisonRecruiterFrameCloseButton:SkinCloseButton()
end
D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin