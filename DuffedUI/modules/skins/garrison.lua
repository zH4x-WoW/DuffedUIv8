local D, C, L = unpack(select(2, ...))

local function LoadGarrisonSkin()
	-- Tooltips
	local Tooltips = {
		FloatingGarrisonFollowerTooltip,
		FloatingGarrisonFollowerAbilityTooltip,
		FloatingGarrisonMissionTooltip,
		GarrisonFollowerAbilityTooltip,
		GarrisonBuildingFrame.BuildingLevelTooltip,
		GarrisonFollowerTooltip
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

	-- Garrison Landing Page
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")
	GarrisonLandingPage.CloseButton:StripTextures()
	GarrisonLandingPage.CloseButton:SkinCloseButton()
	GarrisonLandingPageReportListListScrollFrameScrollBar:StripTextures()
	GarrisonLandingPageReportListListScrollFrameScrollBar:SkinScrollBar()

	for i = 1, 2 do
		_G["GarrisonLandingPageTab" .. i]:StripTextures()
		_G["GarrisonLandingPageTab" .. i]:SkinTab()
	end
	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:Point("BOTTOMLEFT", 0, -40)

	GarrisonLandingPage.FollowerTab.AbilitiesFrame:StripTextures()
	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList.SearchBox:StripTextures()
	GarrisonLandingPage.FollowerList.SearchBox:SetTemplate()
	GarrisonLandingPage.FollowerList.SearchBox:ClearAllPoints()
	GarrisonLandingPage.FollowerList.SearchBox:Point("TOPLEFT", GarrisonLandingPageListScrollFrame, 0, 30)
	GarrisonLandingPage.FollowerTab.XPBar:StripTextures()
	GarrisonLandingPage.FollowerTab.XPBar:SetStatusBarTexture(C["media"].normTex)
	GarrisonLandingPage.FollowerTab.XPBar:CreateBackdrop()
	GarrisonLandingPageListScrollFrame:StripTextures()
	GarrisonLandingPageListScrollFrame:SetTemplate()
	GarrisonLandingPageListScrollFrameScrollBar:StripTextures()
	GarrisonLandingPageListScrollFrameScrollBar:SkinScrollBar()

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

	GarrisonRecruitSelectFrame:StripTextures()
	GarrisonRecruitSelectFrame:SetTemplate("Transparent")
	GarrisonRecruitSelectFrame.CloseButton:SkinCloseButton()
	GarrisonRecruitSelectFrame.FollowerList:StripTextures()
	GarrisonRecruitSelectFrame.FollowerList:SetTemplate()
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:StripTextures()
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:SetTemplate()
	GarrisonRecruitSelectFrameListScrollFrame:StripTextures()
	GarrisonRecruitSelectFrameListScrollFrameScrollBar:StripTextures()
	GarrisonRecruitSelectFrameListScrollFrameScrollBar:SkinScrollBar()
	GarrisonRecruitSelectFrame.FollowerSelection:StripTextures()

	local Frame = GarrisonRecruitSelectFrame.FollowerSelection
	for i = 1, 3 do
		local Button = Frame["Recruit" .. i]

		Button.HireRecruits:StripTextures()
		Button.HireRecruits:SkinButton()
	end

	-- Garrison Mission Frame
	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame:SetTemplate("Transparent")
	GarrisonMissionFrame.CloseButton:SkinCloseButton()
	GarrisonMissionFrameMissions.MaterialFrame:StripTextures()
	GarrisonMissionFrameMissions.MaterialFrame:SetTemplate()
	GarrisonMissionFrameMissions.MaterialFrame:ClearAllPoints()
	GarrisonMissionFrameMissions.MaterialFrame:Point("TOPRIGHT", GarrisonMissionFrameMissionsListScrollFrame, "TOPRIGHT", -1, 27)
	GarrisonMissionFrameMissions.MaterialFrame:SetHeight(GarrisonMissionFrameMissions.MaterialFrame:GetHeight() - 20)
	GarrisonMissionFrameMissions.MaterialFrame:SetWidth(GarrisonMissionFrameFollowers:GetWidth())
	GarrisonMissionFrameMissions:StripTextures()
	GarrisonMissionFrame.MissionTab:StripTextures()

	for i = 1, 2 do
		_G["GarrisonMissionFrameMissionsTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameMissionsTab" .. i]:SkinButton()
		_G["GarrisonMissionFrameMissionsTab" .. i]:Height(_G["GarrisonMissionFrameMissionsTab" .. i]:GetHeight() - 10)
		_G["GarrisonMissionFrameTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameTab" .. i]:SkinTab()
	end
	GarrisonMissionFrameMissionsTab1:ClearAllPoints()
	GarrisonMissionFrameMissionsTab1:Point("TOPLEFT", 20, GarrisonMissionFrameMissionsTab1:GetHeight() - 2)
	GarrisonMissionFrameTab1:ClearAllPoints()
	GarrisonMissionFrameTab1:Point("BOTTOMLEFT", 0, -40)

	GarrisonMissionFrame.MissionTab.MissionPage:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.Stage:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SkinCloseButton()
	GarrisonMissionFrame.MissionTab.MissionPage.CostFrame:SetTemplate()
	GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton:StripTextures()
	GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()
	GarrisonMissionFrameMissionsListScrollFrameScrollBar:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrameScrollBar:SkinScrollBar()
	GarrisonMissionFrameMissionsListScrollFrame:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrameButton8:StripTextures()
	GarrisonMissionFrameMissionsListScrollFrameButton8:SkinButton()
	GarrisonMissionFrame.MissionTab.MissionPage.EmptyFollowerModel.Texture:Hide()

	for i, v in ipairs(GarrisonMissionFrame.MissionTab.MissionList.listScroll.buttons) do
		local Button = _G["GarrisonMissionFrameMissionsListScrollFrameButton" .. i]
		if Button and not Button.skinned then
			Button:StripTextures()
			Button:SetTemplate()
			Button:SkinButton()
			Button:SetBackdropBorderColor(0, 0, 0, 0)
			Button:HideInsets()
			Button.LocBG:Hide()
			for i = 1, #Button.Rewards do
				local Texture = Button.Rewards[i].Icon:GetTexture()

				Button.Rewards[i]:StripTextures()
				Button.Rewards[i]:StyleButton()
				Button.Rewards[i]:CreateBackdrop()
				Button.Rewards[i].Icon:SetTexture(Texture)
				Button.Rewards[i].backdrop:ClearAllPoints()
				Button.Rewards[i].backdrop:SetOutside(Button.Rewards[i].Icon)
				Button.Rewards[i].Icon:SetTexCoord(unpack(D.IconCoord))
			end
			Button.isSkinned = true
		end
	end

	local Frame = GarrisonMissionFrame.MissionTab.MissionPage
	for i = 1, 3 do
		local Enemy = Frame["Enemy" .. i]
		local Follower = Frame["Follower" .. i]

		Enemy.PortraitFrame:StripTextures()
		Enemy.PortraitFrame:CreateBackdrop()
		Enemy.PortraitFrame.Portrait:SetTexCoord(unpack(D.IconCoord))
		Follower:StripTextures()
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

	-- Garrison Mission Complete
	GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:StripTextures()
	GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonMissionFrame.MissionComplete:StripTextures()
	GarrisonMissionFrame.MissionComplete:SetTemplate("Transparent")
	GarrisonMissionFrame.MissionComplete.NextMissionButton:StripTextures()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	local Frame = GarrisonMissionFrame.MissionComplete.Stage.FollowersFrame
	for i = 1, 3 do
		local Follower = Frame["Follower" .. i]

		Follower:StripTextures()
		Follower.XP:StripTextures()
		Follower.XP:SetStatusBarTexture(C["media"].normTex)
		Follower.XP:CreateBackdrop()
	end

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

	GarrisonBuildingFrameFollowers:StripTextures()
	GarrisonBuildingFrameFollowers:SetTemplate()
	GarrisonBuildingFrameFollowers:Width(GarrisonBuildingFrameFollowers:GetWidth() - 10)
	GarrisonBuildingFrameFollowers:ClearAllPoints()
	GarrisonBuildingFrameFollowers:Point("LEFT", GarrisonBuildingFrame, 23, -15)
	GarrisonBuildingFrameFollowersListScrollFrame:StripTextures()
	GarrisonBuildingFrameFollowersListScrollFrameScrollBar:SkinScrollBar()
end
D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin

local function LoadGarrisonTooltipSkin()
	-- Tooltips
	local Tooltips = {
		FloatingGarrisonFollowerTooltip,
		FloatingGarrisonFollowerAbilityTooltip,
		FloatingGarrisonMissionTooltip,
		GarrisonFollowerAbilityTooltip,
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
end
tinsert(D.SkinFuncs["DuffedUI"], LoadGarrisonTooltipSkin)