local D, C, L = unpack(select(2, ...))

local function LoadGarrisonSkin()
	--[[Garrison Building Frame]]--
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	GarrisonBuildingFrame.CloseButton:StripTextures()
	GarrisonBuildingFrame.CloseButton:SkinCloseButton()
	GarrisonBuildingFrame.BuildingList:StripTextures()
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
	GarrisonBuildingFrame.BuildingList.MaterialFrame:SetHeight(GarrisonBuildingFrame.BuildingList.MaterialFrame:GetHeight() - 20)
	GarrisonBuildingFrame.BuildingList.MaterialFrame:SetWidth(GarrisonBuildingFrame.BuildingList:GetWidth())

	GarrisonBuildingFrameFollowers:StripTextures()
	GarrisonBuildingFrameFollowers:Width(GarrisonBuildingFrameFollowers:GetWidth() - 10)
	GarrisonBuildingFrameFollowers:ClearAllPoints()
	GarrisonBuildingFrameFollowers:Point("LEFT", GarrisonBuildingFrame, 23, -15)
	GarrisonBuildingFrameFollowersListScrollFrame:StripTextures()
	GarrisonBuildingFrameFollowersListScrollFrameScrollBar:SkinScrollBar()
	GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
	GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate("Transparent")

	--[[Capacitive display frame]]--
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame:CreateBackdrop("Transparent")
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	GarrisonCapacitiveDisplayFrame.CloseButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton:SkinButton(true)
	GarrisonCapacitiveDisplayFrame.DecrementButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.DecrementButton.t:SetText("-")
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	GarrisonCapacitiveDisplayFrame.Count:SkinEditBox()
	GarrisonCapacitiveDisplayFrame.IncrementButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.IncrementButton.t:SetText("+")
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton(true)
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(unpack(D.IconCoord))
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default", true)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetInside()
	GarrisonCapacitiveDisplayFrame:SetFrameStrata("MEDIUM")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(45)

	local reagentIndex = 1
	hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", function(self)
		local reagents = CapacitiveDisplay.Reagents
		local reagent = reagents[reagentIndex]
		while reagent do
			reagent.NameFrame:SetTexture()
			reagent.Icon:SetTexCoord(unpack(D.IconCoord))
			reagent.Icon:SetDrawLayer("BORDER")

			if not reagent.border then
				reagent.border = CreateFrame("Frame", nil, reagent)
				reagent.Icon:StyleButton()
				reagent.Count:SetParent(reagent.border)
			end

			if not reagent.backdrop then reagent:CreateBackdrop("Default", true) end
			reagentIndex = reagentIndex + 1
			reagent = reagents[reagentIndex]
		end
	end)

	--[[Follower Recruiting]]--
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

	--[[Recruiter Unavailable frame]]--
	local UnavailableFrame = GarrisonRecruiterFrame.UnavailableFrame
	UnavailableFrame:GetChildren():SkinButton()

	--[[ Garrison Mission Frame]]--
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

	--[[Handle MasterPlan AddOn]]--
	local function skinMasterPlan()
		GarrisonMissionFrameTab3:SkinTab()
		GarrisonMissionFrameTab4:SkinTab()
		local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
		MissionPage.MinimizeButton:SkinCloseButton()
		MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	end

	if IsAddOnLoaded("MasterPlan") then skinMasterPlan() else
		local f = CreateFrame("Frame")
		f:RegisterEvent("ADDON_LOADED")
		f:SetScript("OnEvent", function(self, event, addon)
			if addon == "MasterPlan" then
				skinMasterPlan()
				self:UnregisterEvent("ADDON_LOADED")
			end
		end)
	end

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
	GarrisonMissionFrameFollowers.SearchBox:SkinEditBox()
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

	--[[Garrison Mission Complete]]--
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

	--[[Landing page]]--
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:CreateBackdrop("Transparent")
	GarrisonLandingPage.CloseButton:SkinCloseButton()
	GarrisonLandingPageTab1:SkinTab()
	GarrisonLandingPageTab2:SkinTab()
	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)

	--[[Landing Page Report]]--
	local Report = GarrisonLandingPage.Report
	Report.List:StripTextures()
	local scrollFrame = Report.List.listScroll
	scrollFrame.scrollBar:SkinScrollBar()
	local buttons = scrollFrame.buttons
	for i = 1, #buttons do
		local button = buttons[i]
		for _, reward in pairs(button.Rewards) do
			reward.Icon:SetTexCoord(unpack(D.IconCoord))
			if not reward.border then
				reward.border = CreateFrame("Frame", nil, reward)
				reward.Icon:StyleButton()
				reward.Quantity:SetParent(reward.border)
			end
		end
	end

	--[[Landing Page Follower list]]--
	local FollowerList = GarrisonLandingPage.FollowerList
	select(2, FollowerList:GetRegions()):Hide()
	FollowerList.FollowerHeaderBar:Hide()
	FollowerList.SearchBox:SkinEditBox()
	local scrollFrame = FollowerList.listScroll
	scrollFrame.scrollBar:SkinScrollBar()

	hooksecurefunc("GarrisonFollowerButton_AddAbility", function(self, index)
		local ability = self.Abilities[index]
		if not ability.styled then
			local icon = ability.Icon
			ability.Icon:StyleButton()
			ability.styled = true
		end
	end)
end

local function LoadGarrisonTooltipSkin()
	local function restyleGarrisonFollowerTooltipTemplate(frame)
		for i = 1, 9 do select(i, frame:GetRegions()):Hide() end
		frame:SetTemplate("Transparent")
	end

	local function restyleGarrisonFollowerAbilityTooltipTemplate(frame)
		for i = 1, 9 do select(i, frame:GetRegions()):Hide() end
		local icon = frame.Icon
		icon:SetTexCoord(unpack(D.IconCoord))
		if not frame.border then
			frame.border = CreateFrame("Frame", nil, frame)
			frame.Icon:StyleButton()
		end
		frame:SetTemplate("Transparent")
	end

	restyleGarrisonFollowerTooltipTemplate(GarrisonFollowerTooltip)
	restyleGarrisonFollowerAbilityTooltipTemplate(GarrisonFollowerAbilityTooltip)
	restyleGarrisonFollowerTooltipTemplate(FloatingGarrisonFollowerTooltip)
	FloatingGarrisonFollowerTooltip.CloseButton:SkinCloseButton()
	restyleGarrisonFollowerAbilityTooltipTemplate(FloatingGarrisonFollowerAbilityTooltip)
	FloatingGarrisonFollowerAbilityTooltip.CloseButton:SkinCloseButton()

	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", function(tooltipFrame)
		--[[Abilities]]--
		if tooltipFrame.numAbilitiesStyled == nil then tooltipFrame.numAbilitiesStyled = 1 end
		local numAbilitiesStyled = tooltipFrame.numAbilitiesStyled
		local abilities = tooltipFrame.Abilities
		local ability = abilities[numAbilitiesStyled]
		while ability do
			local icon = ability.Icon
			icon:SetTexCoord(unpack(D.IconCoord))
			if not ability.border then
				ability.border = CreateFrame("Frame", nil, ability)
				ability.Icon:StyleButton()
			end

			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end
		tooltipFrame.numAbilitiesStyled = numAbilitiesStyled

		--[[Traits]]--
		if tooltipFrame.numTraitsStyled == nil then tooltipFrame.numTraitsStyled = 1 end
		local numTraitsStyled = tooltipFrame.numTraitsStyled
		local traits = tooltipFrame.Traits
		local trait = traits[numTraitsStyled]
		while trait do
			local icon = trait.Icon
			icon:SetTexCoord(unpack(D.IconCoord))
			if not trait.border then
				trait.border = CreateFrame("Frame", nil, trait)
				trait.Icon:StyleButton()
			end

			numTraitsStyled = numTraitsStyled + 1
			trait = traits[numTraitsStyled]
		end
		tooltipFrame.numTraitsStyled = numTraitsStyled
	end)
end
--[[local function LoadSkin()
	local function HandleFollowerPage(follower, hasItems)
		local abilities = follower.followerTab.AbilitiesFrame.Abilities
		if follower.numAbilitiesStyled == nil then follower.numAbilitiesStyled = 1 end
		local numAbilitiesStyled = follower.numAbilitiesStyled
		local ability = abilities[numAbilitiesStyled]
		while ability do
			local icon = ability.IconButton.Icon
			S:HandleIcon(icon, ability.IconButton)
			icon:SetDrawLayer("BORDER", 0)
			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end
		follower.numAbilitiesStyled = numAbilitiesStyled

		if hasItems then
			local weapon = follower.followerTab.ItemWeapon
			local armor = follower.followerTab.ItemArmor
			if not weapon.backdrop then
				S:HandleIcon(weapon.Icon, weapon)
				weapon.Border:SetTexture(nil)
				weapon.backdrop:SetFrameLevel(weapon:GetFrameLevel())
			end
			if not armor.backdrop then
				S:HandleIcon(armor.Icon, armor)
				armor.Border:SetTexture(nil)
				armor.backdrop:SetFrameLevel(armor:GetFrameLevel())
			end
		end
	end

	local function HandleShipFollowerPage(followerTab)
		local traits = followerTab.Traits
		for i = 1, #traits do
			local icon = traits[i].Portrait
			local border = traits[i].Border
			-- border:SetTexture(nil) -- I think the default border looks nice, not sure if we want to replace that
			--The landing page icons display inner borders
			if followerTab.isLandingPage then
				icon:SetTexCoord(unpack(E.TexCoords))
			end
		end

		local equipment = followerTab.EquipmentFrame.Equipment
		for i = 1, #equipment do
			local icon = equipment[i].Icon
			local border = equipment[i].Border
			border:SetAtlas("ShipMission_ShipFollower-TypeFrame") -- This border is ugly though, use the traits border instead
			--The landing page icons display inner borders
			if followerTab.isLandingPage then
				icon:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end

	-- Building frame
	GarrisonBuildingFrame:StripTextures(true)
	GarrisonBuildingFrame.TitleText:Show()
	GarrisonBuildingFrame:CreateBackdrop("Transparent")
	S:HandleCloseButton(GarrisonBuildingFrame.CloseButton, GarrisonBuildingFrame.backdrop)
	GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
	GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate('Transparent')

	-- Capacitive display frame
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame:CreateBackdrop("Transparent")
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	S:HandleCloseButton(GarrisonCapacitiveDisplayFrame.CloseButton, GarrisonCapacitiveDisplayFrame.backdrop)
	S:HandleButton(GarrisonCapacitiveDisplayFrame.StartWorkOrderButton, true)
	S:HandleButton(GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton, true)
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	S:HandleEditBox(GarrisonCapacitiveDisplayFrame.Count)
	S:HandleNextPrevButton(GarrisonCapacitiveDisplayFrame.DecrementButton)
	SquareButton_SetIcon(GarrisonCapacitiveDisplayFrame.DecrementButton, 'LEFT')
	S:HandleNextPrevButton(GarrisonCapacitiveDisplayFrame.IncrementButton)
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(unpack(E.TexCoords))
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default", true)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetInside()
	--Fix unitframes appearing above work orders
	GarrisonCapacitiveDisplayFrame:SetFrameStrata("MEDIUM")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(45)

	do
		local reagentIndex = 1
		hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", function(self)
			local reagents = CapacitiveDisplay.Reagents
			local reagent = reagents[reagentIndex]
			while reagent do
				reagent.NameFrame:SetTexture()
				reagent.Icon:SetTexCoord(unpack(E.TexCoords))
				reagent.Icon:SetDrawLayer("BORDER")

				if not reagent.border then
					reagent.border = CreateFrame("Frame", nil, reagent)
					S:HandleIcon(reagent.Icon, reagent.border)
					reagent.Count:SetParent(reagent.border)
				end

				if not reagent.backdrop then
					reagent:CreateBackdrop("Default", true)
				end

				reagentIndex = reagentIndex + 1
				reagent = reagents[reagentIndex]
			end
		end)
	end

	-- Recruiter frame
	GarrisonRecruiterFrame:StripTextures(true)
	GarrisonRecruiterFrame:CreateBackdrop("Transparent")
	GarrisonRecruiterFrame.Inset:StripTextures()
	S:HandleCloseButton(GarrisonRecruiterFrame.CloseButton, GarrisonRecruiterFrame.backdrop)

	-- Recruiter Unavailable frame
	local UnavailableFrame = GarrisonRecruiterFrame.UnavailableFrame
	S:HandleButton(UnavailableFrame:GetChildren())

	-- Mission UI
	GarrisonMissionFrame:StripTextures(true)
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:CreateBackdrop("Transparent")
	S:HandleCloseButton(GarrisonMissionFrame.CloseButton, GarrisonMissionFrame.backdrop)
	for i=1,2 do
		S:HandleTab(_G["GarrisonMissionFrameTab"..i])
	end

	GarrisonMissionFrameTab1:ClearAllPoints()
	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", 11, -40)

	-- Follower list
	local FollowerList = GarrisonMissionFrame.FollowerList
	FollowerList:DisableDrawLayer("BORDER")
	FollowerList.MaterialFrame:StripTextures()
	S:HandleEditBox(FollowerList.SearchBox)
	S:HandleScrollBar(FollowerList.listScroll.scrollBar)
	hooksecurefunc(FollowerList, "ShowFollower", function(self)
		HandleFollowerPage(self, true)
	end)

	-- Mission list
	local MissionTab = GarrisonMissionFrame.MissionTab
	local MissionList = MissionTab.MissionList
	local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
	MissionList:DisableDrawLayer("BORDER")
	S:HandleScrollBar(MissionList.listScroll.scrollBar)
	S:HandleCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	S:HandleButton(MissionList.CompleteDialog.BorderFrame.ViewButton)
	S:HandleButton(MissionPage.StartMissionButton)
	S:HandleButton(GarrisonMissionFrame.MissionComplete.NextMissionButton)

	hooksecurefunc("GarrisonMissionButton_SetRewards", function(self, rewards, numRewards)
		if self.numRewardsStyled == nil then
			self.numRewardsStyled = 0
		end
		while self.numRewardsStyled < numRewards do
			self.numRewardsStyled = self.numRewardsStyled + 1
			local reward = self.Rewards[self.numRewardsStyled]
			local icon = reward.Icon
			reward:GetRegions():Hide()
			if not reward.border then
				reward.border = CreateFrame("Frame", nil, reward)
				S:HandleIcon(reward.Icon, reward.border)
			end
		end
	end)

	hooksecurefunc("GarrisonMissionPage_SetReward", function(frame, reward)
		frame.BG:SetTexture()
		if not frame.backdrop then
			S:HandleIcon(frame.Icon)
		end
		frame.Icon:SetDrawLayer("BORDER", 0)
	end)

	MissionPage.StartMissionButton.Flash:Hide()
	MissionPage.StartMissionButton.Flash.Show = E.noop
	MissionPage.StartMissionButton.FlashAnim:Stop()
	MissionPage.StartMissionButton.FlashAnim.Play = E.noop


	-- Landing page
	-- GarrisonLandingPage:StripTextures(true) -- I actually like the look of this texture. Not sure if we want to remove it.
	GarrisonLandingPage:CreateBackdrop("Transparent")
	S:HandleCloseButton(GarrisonLandingPage.CloseButton, GarrisonLandingPage.backdrop)
	S:HandleTab(GarrisonLandingPageTab1)
	S:HandleTab(GarrisonLandingPageTab2)
	S:HandleTab(GarrisonLandingPageTab3)
	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)

	-- Landing page: Report
	local Report = GarrisonLandingPage.Report
	Report.List:StripTextures(true)
	local scrollFrame = Report.List.listScroll
	S:HandleScrollBar(scrollFrame.scrollBar)
	local buttons = scrollFrame.buttons
	for i = 1, #buttons do
		local button = buttons[i]
		for _, reward in pairs(button.Rewards) do
			reward.Icon:SetTexCoord(unpack(E.TexCoords))
			if not reward.border then
				reward.border = CreateFrame("Frame", nil, reward)
				S:HandleIcon(reward.Icon, reward.border)
				reward.Quantity:SetParent(reward.border)
			end
		end
	end

	-- Landing page: Follower list
	local FollowerList = GarrisonLandingPage.FollowerList
	FollowerList.FollowerHeaderBar:Hide()
	S:HandleEditBox(FollowerList.SearchBox)
	local scrollFrame = FollowerList.listScroll
	S:HandleScrollBar(scrollFrame.scrollBar)

	hooksecurefunc(FollowerList, "ShowFollower", function(self)
		HandleFollowerPage(self)
	end)

	hooksecurefunc("GarrisonFollowerButton_AddAbility", function(self, index)
		local ability = self.Abilities[index]
		if not ability.styled then
			local icon = ability.Icon
			S:HandleIcon(ability.Icon, ability)
			ability.styled = true
		end
	end)

	-- Landing page: Fleet
	local ShipFollowerList = GarrisonLandingPage.ShipFollowerList
	ShipFollowerList.FollowerHeaderBar:Hide()
	S:HandleEditBox(ShipFollowerList.SearchBox)
	local scrollFrame = ShipFollowerList.listScroll
	S:HandleScrollBar(scrollFrame.scrollBar)
	HandleShipFollowerPage(ShipFollowerList.followerTab)


	-- ShipYard
	GarrisonShipyardFrame:StripTextures(true)
	GarrisonShipyardFrame.BorderFrame:StripTextures(true)
	GarrisonShipyardFrame:CreateBackdrop("Transparent")
	GarrisonShipyardFrame.backdrop:SetOutside(GarrisonShipyardFrame.BorderFrame)
	S:HandleCloseButton(GarrisonShipyardFrame.BorderFrame.CloseButton2)
	S:HandleTab(GarrisonShipyardFrameTab1)
	S:HandleTab(GarrisonShipyardFrameTab2)

	-- ShipYard: Naval Map
	local MissionTab = GarrisonShipyardFrame.MissionTab
	local MissionList = MissionTab.MissionList
	MissionList:CreateBackdrop("Transparent")
	MissionList.backdrop:SetOutside(MissionList.MapTexture)
	MissionList.CompleteDialog.BorderFrame:StripTextures()
	MissionList.CompleteDialog.BorderFrame:SetTemplate("Transparent")

	-- ShipYard: Mission
	local MissionPage = MissionTab.MissionPage
	S:HandleCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage.CloseButton:GetFrameLevel() + 2)
	S:HandleButton(MissionList.CompleteDialog.BorderFrame.ViewButton)
	S:HandleButton(GarrisonShipyardFrame.MissionComplete.NextMissionButton)
	MissionList.CompleteDialog:SetAllPoints(MissionList.MapTexture)
	GarrisonShipyardFrame.MissionCompleteBackground:SetAllPoints(MissionList.MapTexture)
	S:HandleButton(MissionPage.StartMissionButton)
	MissionPage.StartMissionButton.Flash:Hide()
	MissionPage.StartMissionButton.Flash.Show = E.noop
	MissionPage.StartMissionButton.FlashAnim:Stop()
	MissionPage.StartMissionButton.FlashAnim.Play = E.noop
	S:HandleButton(GarrisonMissionFrameHelpBoxButton)

	-- ShipYard: Follower List
	local FollowerList = GarrisonShipyardFrame.FollowerList
	local scrollFrame = FollowerList.listScroll
	FollowerList:StripTextures()
	S:HandleScrollBar(scrollFrame.scrollBar)
	S:HandleEditBox(FollowerList.SearchBox)
	FollowerList.MaterialFrame:StripTextures()
	FollowerList.MaterialFrame.Icon:SetAtlas("ShipMission_CurrencyIcon-Oil", false) --Re-add the material icon
	HandleShipFollowerPage(FollowerList.followerTab)

	-- ShipYard: Mission Tooltip
	local tooltip = GarrisonShipyardMapMissionTooltip
	local reward = tooltip.ItemTooltip
	local bonusReward = tooltip.BonusReward
	local icon = reward.Icon
	local bonusIcon = bonusReward.Icon
	tooltip:SetTemplate("Transparent")
	if icon then
		S:HandleIcon(icon)
		reward.IconBorder:SetTexture(nil)
	end
	if bonusIcon then
		S:HandleIcon(bonusIcon) --TODO: Check how this actually looks
	end


	-- Threat Counter Tooltips
	-- The tooltip starts using blue backdrop and white border unless we re-set the template.
	-- We should check if there is a better way of doing this.
	S:HookScript(GarrisonMissionMechanicFollowerCounterTooltip, "OnShow", function(self)
		self:SetTemplate("Transparent")
	end)
	S:HookScript(GarrisonMissionMechanicTooltip, "OnShow", function(self)
		self:SetTemplate("Transparent")
	end)
end

local function SkinTooltip()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.garrison ~= true then return end

	local function restyleGarrisonFollowerTooltipTemplate(frame)
		for i = 1, 9 do
			select(i, frame:GetRegions()):Hide()
		end
		frame:SetTemplate("Transparent")
	end

	local function restyleGarrisonFollowerAbilityTooltipTemplate(frame)
		for i = 1, 9 do
			select(i, frame:GetRegions()):Hide()
		end
		local icon = frame.Icon
		icon:SetTexCoord(unpack(E.TexCoords))
		if not frame.border then
			frame.border = CreateFrame("Frame", nil, frame)
			S:HandleIcon(frame.Icon, frame.border)
		end
		frame:SetTemplate("Transparent")
	end

	restyleGarrisonFollowerTooltipTemplate(GarrisonFollowerTooltip)
	restyleGarrisonFollowerAbilityTooltipTemplate(GarrisonFollowerAbilityTooltip)
	restyleGarrisonFollowerTooltipTemplate(FloatingGarrisonFollowerTooltip)
	S:HandleCloseButton(FloatingGarrisonFollowerTooltip.CloseButton)
	restyleGarrisonFollowerAbilityTooltipTemplate(FloatingGarrisonFollowerAbilityTooltip)
	S:HandleCloseButton(FloatingGarrisonFollowerAbilityTooltip.CloseButton)
	restyleGarrisonFollowerTooltipTemplate(FloatingGarrisonMissionTooltip)
	S:HandleCloseButton(FloatingGarrisonMissionTooltip.CloseButton)
	restyleGarrisonFollowerTooltipTemplate(FloatingGarrisonShipyardFollowerTooltip)
	S:HandleCloseButton(FloatingGarrisonShipyardFollowerTooltip.CloseButton)
	restyleGarrisonFollowerTooltipTemplate(GarrisonShipyardFollowerTooltip)

	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", function(tooltipFrame)
		-- Abilities
		if tooltipFrame.numAbilitiesStyled == nil then
			tooltipFrame.numAbilitiesStyled = 1
		end
		local numAbilitiesStyled = tooltipFrame.numAbilitiesStyled
		local abilities = tooltipFrame.Abilities
		local ability = abilities[numAbilitiesStyled]
		while ability do
			local icon = ability.Icon
			icon:SetTexCoord(unpack(E.TexCoords))
			if not ability.border then
				ability.border = CreateFrame("Frame", nil, ability)
				S:HandleIcon(ability.Icon, ability.border)
			end

			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end
		tooltipFrame.numAbilitiesStyled = numAbilitiesStyled

		-- Traits
		if tooltipFrame.numTraitsStyled == nil then
			tooltipFrame.numTraitsStyled = 1
		end
		local numTraitsStyled = tooltipFrame.numTraitsStyled
		local traits = tooltipFrame.Traits
		local trait = traits[numTraitsStyled]
		while trait do
			local icon = trait.Icon
			icon:SetTexCoord(unpack(E.TexCoords))
			if not trait.border then
				trait.border = CreateFrame("Frame", nil, trait)
				S:HandleIcon(trait.Icon, trait.border)
			end

			numTraitsStyled = numTraitsStyled + 1
			trait = traits[numTraitsStyled]
		end
		tooltipFrame.numTraitsStyled = numTraitsStyled
	end)

	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetShipyardFollower", function(tooltipFrame)
		-- Properties
		if tooltipFrame.numPropertiesStyled == nil then
			tooltipFrame.numPropertiesStyled = 1
		end
		local numPropertiesStyled = tooltipFrame.numPropertiesStyled
		local properties = tooltipFrame.Properties
		local property = properties[numPropertiesStyled]
		while property do
			local icon = property.Icon
			icon:SetTexCoord(unpack(E.TexCoords))
			if not property.border then
				property.border = CreateFrame("Frame", nil, property)
				S:HandleIcon(property.Icon, property.border)
			end

			numPropertiesStyled = numPropertiesStyled + 1
			property = properties[numPropertiesStyled]
		end
		tooltipFrame.numPropertiesStyled = numPropertiesStyled
	end)
end]]

D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin
tinsert(D.SkinFuncs["DuffedUI"], LoadGarrisonTooltipSkin)