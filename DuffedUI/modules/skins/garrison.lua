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
	GarrisonRecruiterFramePickThreatDropDown:SkinDropDownBox()
	GarrisonRecruiterFrame.Pick.ChooseRecruits:StripTextures()
	GarrisonRecruiterFrame.Pick.ChooseRecruits:SkinButton()

	-- Garrison Mission Frame
	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame:SetTemplate("Transparent")
	GarrisonMissionFrame.CloseButton:SkinCloseButton()
	GarrisonMissionFrameMissions.MaterialFrame:StripTextures()
	GarrisonMissionFrameMissions.MaterialFrame:SetTemplate()
	GarrisonMissionFrameMissions.MaterialFrame:ClearAllPoints()
	GarrisonMissionFrameMissions.MaterialFrame:Point("TOPRIGHT", GarrisonMissionFrameMissionsListScrollFrame, "TOPRIGHT", 0, 27)
	GarrisonMissionFrameMissions.MaterialFrame:SetHeight(GarrisonMissionFrameMissions.MaterialFrame:GetHeight() - 20)
	GarrisonMissionFrameMissions.MaterialFrame:SetWidth(GarrisonMissionFrameFollowers:GetWidth())
	GarrisonMissionFrameMissions:StripTextures()
	GarrisonMissionFrame.MissionTab:StripTextures()

	for i = 1, 2 do
		_G["GarrisonMissionFrameMissionsTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameMissionsTab" .. i]:SkinButton()
		_G["GarrisonMissionFrameTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameTab" .. i]:SkinTab()
	end

	GarrisonMissionFrameTab1:ClearAllPoints()
	GarrisonMissionFrameTab1:Point("BOTTOMLEFT", 0, -40)
	GarrisonMissionFrame.MissionTab.MissionPage:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage:SetTemplate()
	GarrisonMissionFrame.MissionTab.MissionPage.Stage:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SkinCloseButton()
	GarrisonMissionFrame.MissionTab.MissionPage.CostFrame:SetTemplate()
	GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()
	GarrisonMissionFrameMissionsListScrollFrameScrollBar:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrameScrollBar:SkinScrollBar()
	GarrisonMissionFrameMissionsListScrollFrame:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrame:SetTemplate()
	GarrisonMissionFrameMissionsListScrollFrameButton8:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrameButton8:SkinButton()

	for i = 1, #GarrisonMissionFrame.MissionTab.MissionList.availableMissions do
		local m = _G["GarrisonMissionFrameMissionsListScrollFrameButton" .. i]
		if m and not m.skinned then
			m:StripTextures()
			m:SetTemplate()
			m:StyleButton()
			m:SetBackdropBorderColor(0, 0, 0, 0)
			m:HideInsets()
			m.LocBG:Hide()
			for i = 1, #m.Rewards do
				local Texture = m.Rewards[i].Icon:GetTexture()

				m.Rewards[i]:StripTextures()
				m.Rewards[i]:StyleButton()
				m.Rewards[i]:CreateBackdrop()
				m.Rewards[i].Icon:SetTexture(Texture)
				m.Rewards[i].backdrop:ClearAllPoints()
				m.Rewards[i].backdrop:SetOutside(m.Rewards[i].Icon)
				m.Rewards[i].Icon:SetTexCoord(unpack(D.IconCoord))
			end
			m.isSkinned = true
		end
	end

	GarrisonMissionFrame.FollowerTab:StripTextures()
	GarrisonMissionFrame.FollowerTab:SetTemplate()
	GarrisonMissionFrame.FollowerTab.XPBar:StripTextures()
	GarrisonMissionFrame.FollowerTab.XPBar:SetStatusBarTexture(C["media"].normTex)
	GarrisonMissionFrame.FollowerTab.XPBar:CreateBackdrop()
	GarrisonMissionFrameFollowers:StripTextures()
	GarrisonMissionFrameFollowers:SetTemplate()	
	GarrisonMissionFrameFollowers.SearchBox:StripTextures()
	GarrisonMissionFrameFollowers.SearchBox:SetTemplate()
	GarrisonMissionFrameFollowers.MaterialFrame:StripTextures()
	GarrisonMissionFrameFollowers.MaterialFrame:SetTemplate()
	GarrisonMissionFrameFollowers.MaterialFrame:ClearAllPoints()
	GarrisonMissionFrameFollowers.MaterialFrame:Point("BOTTOMLEFT", GarrisonMissionFrameMissionsListScrollFrame, -7, -7)
	GarrisonMissionFrameFollowers.MaterialFrame:SetHeight(GarrisonMissionFrameFollowers.MaterialFrame:GetHeight() - 20)
	GarrisonMissionFrameFollowers.MaterialFrame:SetWidth(GarrisonMissionFrameFollowers:GetWidth())
	GarrisonMissionFrameFollowersListScrollFrameScrollBar:StripTextures()
	GarrisonMissionFrameFollowersListScrollFrameScrollBar:SkinScrollBar()
	GarrisonMissionFrame.FollowerTab.ItemWeapon:StripTextures()
	GarrisonMissionFrame.FollowerTab.ItemWeapon.Icon:SetTexCoord(unpack(D.IconCoord))
	GarrisonMissionFrame.FollowerTab.ItemArmor:StripTextures()
	GarrisonMissionFrame.FollowerTab.ItemArmor.Icon:SetTexCoord(unpack(D.IconCoord))
	GarrisonMissionFrameMissions.CompleteDialog:StripTextures()
	GarrisonMissionFrameMissions.CompleteDialog:SetTemplate("Transparent")
	GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.Stage:StripTextures()
	GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:StripTextures()
	GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonMissionFrame.MissionComplete:StripTextures()
	GarrisonMissionFrame.MissionComplete:SetTemplate("Transparent")
	GarrisonMissionFrame.MissionComplete.NextMissionButton:StripTextures()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	-- Garrison Building Frame
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	GarrisonBuildingFrame.CloseButton:StripTextures()
	GarrisonBuildingFrame.CloseButton:SkinCloseButton()
	GarrisonBuildingFrame.BuildingList:StripTextures()
	GarrisonBuildingFrame.BuildingList:SetTemplate()
	GarrisonBuildingFrame.Confirmation:StripTextures()
	GarrisonBuildingFrame.Confirmation:SetTemplate("Transparent")
	GarrisonBuildingFrame.Confirmation.CancelButton:StripTextures()
	GarrisonBuildingFrame.Confirmation.CancelButton:SkinButton()
	GarrisonBuildingFrame.Confirmation.UpgradeButton:StripTextures()
	GarrisonBuildingFrame.Confirmation.UpgradeButton:SkinButton()

	GarrisonBuildingFrame.TownHallBox.UpgradeButton:StripTextures()
	GarrisonBuildingFrame.TownHallBox.UpgradeButton:SkinButton()
	GarrisonBuildingFrame.InfoBox.UpgradeButton:StripTextures()
	GarrisonBuildingFrame.InfoBox.UpgradeButton:SkinButton()

	GarrisonBuildingFrame.BuildingList.MaterialFrame:StripTextures()
	GarrisonBuildingFrame.BuildingList.MaterialFrame:SetTemplate()
	GarrisonBuildingFrame.BuildingList.MaterialFrame:ClearAllPoints()
	GarrisonBuildingFrame.BuildingList.MaterialFrame:Point("BOTTOMLEFT", GarrisonBuildingFrame.BuildingList, 0, -30)
	GarrisonBuildingFrame.BuildingList.MaterialFrame:SetHeight(GarrisonBuildingFrame.BuildingList.MaterialFrame:GetHeight() - 20)
	GarrisonBuildingFrame.BuildingList.MaterialFrame:SetWidth(GarrisonBuildingFrame.BuildingList:GetWidth())
end
D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin