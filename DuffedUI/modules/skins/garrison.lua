local D, C, L = unpack(select(2, ...))

local function LoadGarrisonSkin()
	local function HandleFollowerPage(follower, hasItems)
		local abilities = follower.followerTab.AbilitiesFrame.Abilities
		if follower.numAbilitiesStyled == nil then follower.numAbilitiesStyled = 1 end
		local numAbilitiesStyled = follower.numAbilitiesStyled
		local ability = abilities[numAbilitiesStyled]
		while ability do
			local icon = ability.IconButton.Icon
			icon:StyleButton()
			icon:SetDrawLayer("BORDER", 0)
			numAbilitiesStyled = numAbilitiesStyled + 1
			ability = abilities[numAbilitiesStyled]
		end
		follower.numAbilitiesStyled = numAbilitiesStyled

		if hasItems then
			local weapon = follower.followerTab.ItemWeapon
			local armor = follower.followerTab.ItemArmor
			weapon.Icon:StyleButton()
			weapon.Icon:SetDrawLayer("BORDER", 0)
			armor.Icon:StyleButton()
			armor.Icon:SetDrawLayer("BORDER", 0)
		end
	end

	--[[Building frame]]--
	GarrisonBuildingFrame:StripTextures(true)
	GarrisonBuildingFrame.TitleText:Show()
	GarrisonBuildingFrame:CreateBackdrop("Transparent")
	GarrisonBuildingFrame.CloseButton:SkinCloseButton()
	GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
	GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate('Transparent')

	--[[Capacitive display frame]]--
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame:CreateBackdrop("Transparent")
	GarrisonCapacitiveDisplayFrame.Inset:StripTextures()
	GarrisonCapacitiveDisplayFrame.CloseButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton(true)
	GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton:SkinButton(true)
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	GarrisonCapacitiveDisplayFrame.Count:SkinEditBox()
	GarrisonCapacitiveDisplayFrame.DecrementButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.DecrementButton.t:SetText("-")
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	GarrisonCapacitiveDisplayFrame.Count:SkinEditBox()
	GarrisonCapacitiveDisplayFrame.IncrementButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.IncrementButton.t:SetText("+")
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(unpack(D.IconCoord))
	CapacitiveDisplay.ShipmentIconFrame:SetTemplate("Default", true)
	CapacitiveDisplay.ShipmentIconFrame.Icon:SetInside()
	CapacitiveDisplay.ShipmentIconFrame.Follower:StripTextures()
	CapacitiveDisplay.ShipmentIconFrame.Follower.Portrait:SetTexCoord(unpack(D["IconCoord"]))
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

	--[[Mission UI]]--
	GarrisonMissionFrame:StripTextures(true)
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:CreateBackdrop("Transparent")
	GarrisonMissionFrame.CloseButton:SkinCloseButton()
	for i = 1, 2 do
		_G["GarrisonMissionFrameMissionsTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameMissionsTab" .. i]:SkinButton()
		_G["GarrisonMissionFrameMissionsTab" .. i]:Height(_G["GarrisonMissionFrameMissionsTab" .. i]:GetHeight() - 10)
		_G["GarrisonMissionFrameTab" .. i]:StripTextures()
		_G["GarrisonMissionFrameTab" .. i]:SkinTab()
	end
	
	--[[Handle MasterPlan AddOn]]--
	local function skinMasterPlan()
		GarrisonMissionFrameTab3:SkinTab()
		GarrisonMissionFrameTab4:SkinTab()
		GarrisonShipyardFrameTab3:SkinTab()
		GarrisonLandingPageTab4:SkinTab()
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
	GarrisonShipyardFrame.BorderFrame.CloseButton2:SkinCloseButton()
	GarrisonMissionFrame.GarrCorners.TopLeftGarrCorner:SetTexture(nil)
	GarrisonMissionFrame.GarrCorners.TopRightGarrCorner:SetTexture(nil)
	GarrisonMissionFrame.GarrCorners.BottomLeftGarrCorner:SetTexture(nil)
	GarrisonMissionFrame.GarrCorners.BottomRightGarrCorner:SetTexture(nil)

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
		Follower:StripTextures()
	end

	GarrisonMissionFrameTab1:ClearAllPoints()
	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", 11, -40)

	--[[Follower list]]--
	local FollowerList = GarrisonMissionFrame.FollowerList
	FollowerList:DisableDrawLayer("BORDER")
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
	FollowerList.listScroll.scrollBar:SkinScrollBar()
	hooksecurefunc(FollowerList, "ShowFollower", function(self) HandleFollowerPage(self, true) end)

	--[[Mission list]]--
	local MissionTab = GarrisonMissionFrame.MissionTab
	local MissionList = MissionTab.MissionList
	local MissionPage = MissionTab.MissionPage
	MissionList:DisableDrawLayer("BORDER")
	MissionList.listScroll.scrollBar:SkinScrollBar()
	MissionPage.CloseButton:SkinCloseButton()
	MissionPage.CloseButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	MissionPage.StartMissionButton:SkinButton()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	hooksecurefunc("GarrisonMissionButton_SetRewards", function(self, rewards, numRewards)
		if self.numRewardsStyled == nil then self.numRewardsStyled = 0 end
		while self.numRewardsStyled < numRewards do
			self.numRewardsStyled = self.numRewardsStyled + 1
			local reward = self.Rewards[self.numRewardsStyled]
			local icon = reward.Icon
			reward:GetRegions():Hide()
			if not reward.border then
				reward.border = CreateFrame("Frame", nil, reward)
				reward.Icon:StyleButton()
			end
		end
	end)

	hooksecurefunc("GarrisonMissionPage_SetReward", function(frame, reward)
		frame.BG:SetTexture()
		if not frame.backdrop then frame.Icon:StyleButton() end
		frame.Icon:SetDrawLayer("BORDER", 0)
	end)

	MissionPage.StartMissionButton.Flash:Hide()
	MissionPage.StartMissionButton.Flash.Show = D.Dummy
	MissionPage.StartMissionButton.FlashAnim:Stop()
	MissionPage.StartMissionButton.FlashAnim.Play = D.Dummy


	--[[Landing page]]--
	GarrisonLandingPage:StripTextures(true)
	GarrisonLandingPage:CreateBackdrop("Transparent")
	GarrisonLandingPage.CloseButton:SkinCloseButton()
	GarrisonLandingPageTab1:SkinTab()
	GarrisonLandingPageTab2:SkinTab()
	GarrisonLandingPageTab3:SkinTab()
	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, 2)

	--[[Landing page: Report]]--
	local Report = GarrisonLandingPage.Report
	Report.List:StripTextures(true)
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

	--[[Landing page: Follower list]]--
	local FollowerList = GarrisonLandingPage.FollowerList
	FollowerList.FollowerHeaderBar:Hide()
	FollowerList.SearchBox:SkinEditBox()
	local scrollFrame = FollowerList.listScroll
	scrollFrame.scrollBar:SkinScrollBar()

	hooksecurefunc(FollowerList, "ShowFollower", function(self) HandleFollowerPage(self) end)

	hooksecurefunc("GarrisonFollowerButton_AddAbility", function(self, index)
		local ability = self.Abilities[index]
		if not ability.styled then
			local icon = ability.Icon
			ability.Icon:StyleButton()
			ability.styled = true
		end
	end)

	--[[Landing page: Fleet]]--
	local ShipFollowerList = GarrisonLandingPage.ShipFollowerList
	ShipFollowerList.FollowerHeaderBar:Hide()
	ShipFollowerList.SearchBox:SkinEditBox()
	local scrollFrame = ShipFollowerList.listScroll
	scrollFrame.scrollBar:SkinScrollBar()


	--[[ShipYard]]--
	GarrisonShipyardFrame:StripTextures(true)
	GarrisonShipyardFrame.BorderFrame:StripTextures(true)
	GarrisonShipyardFrame:CreateBackdrop("Transparent")
	GarrisonShipyardFrame.backdrop:SetOutside(GarrisonShipyardFrame.BorderFrame)
	GarrisonShipyardFrame.BorderFrame.CloseButton2:SkinCloseButton()
	GarrisonShipyardFrame.BorderFrame.GarrCorners.TopLeftGarrCorner:SetTexture(nil)
	GarrisonShipyardFrame.BorderFrame.GarrCorners.TopRightGarrCorner:SetTexture(nil)
	GarrisonShipyardFrame.BorderFrame.GarrCorners.BottomLeftGarrCorner:SetTexture(nil)
	GarrisonShipyardFrame.BorderFrame.GarrCorners.BottomRightGarrCorner:SetTexture(nil)
	GarrisonShipyardFrameTab1:SkinTab()
	GarrisonShipyardFrameTab2:SkinTab()

	--[[ShipYard: Naval Map]]--
	local MissionTab = GarrisonShipyardFrame.MissionTab
	local MissionList = MissionTab.MissionList
	MissionList:CreateBackdrop("Transparent")
	MissionList.backdrop:SetOutside(MissionList.MapTexture)
	MissionList.CompleteDialog.BorderFrame:StripTextures()
	MissionList.CompleteDialog.BorderFrame:SetTemplate("Transparent")

	--[[ShipYard: Mission]]--
	local MissionPage = MissionTab.MissionPage
	MissionPage.CloseButton:SkinCloseButton()
	MissionPage.CloseButton:SetFrameLevel(MissionPage.CloseButton:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonShipyardFrame.MissionComplete.NextMissionButton:SkinButton()
	MissionList.CompleteDialog:SetAllPoints(MissionList.MapTexture)
	GarrisonShipyardFrame.MissionCompleteBackground:SetAllPoints(MissionList.MapTexture)
	MissionPage.StartMissionButton:SkinButton()
	MissionPage.StartMissionButton.Flash:Hide()
	MissionPage.StartMissionButton.Flash.Show = D.Dummy
	MissionPage.StartMissionButton.FlashAnim:Stop()
	MissionPage.StartMissionButton.FlashAnim.Play = D.Dummy
	GarrisonMissionFrameHelpBoxButton:SkinButton()

	--[[ShipYard: Follower List]]--
	local FollowerList = GarrisonShipyardFrame.FollowerList
	local scrollFrame = FollowerList.listScroll
	FollowerList:StripTextures()
	scrollFrame.scrollBar:SkinScrollBar()
	FollowerList.SearchBox:SkinEditBox()
	FollowerList.MaterialFrame:StripTextures()
	FollowerList.MaterialFrame.Icon:SetAtlas("ShipMission_CurrencyIcon-Oil", false) --Re-add the material icon

	--[[ShipYard: Mission Tooltip]]--
	local tooltip = GarrisonShipyardMapMissionTooltip
	local reward = tooltip.ItemTooltip
	local bonusReward = tooltip.BonusReward
	local icon = reward.Icon
	local bonusIcon = bonusReward.Icon
	tooltip:SetTemplate("Transparent")
	if icon then
		icon:StyleButton()
		reward.IconBorder:SetTexture(nil)
	end
	if bonusIcon then bonusIcon:StyleButton() end
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

	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetShipyardFollower", function(tooltipFrame)
		--[[Properties]]--
		if tooltipFrame.numPropertiesStyled == nil then tooltipFrame.numPropertiesStyled = 1 end
		local numPropertiesStyled = tooltipFrame.numPropertiesStyled
		local properties = tooltipFrame.Properties
		local property = properties[numPropertiesStyled]
		while property do
			local icon = property.Icon
			icon:SetTexCoord(unpack(D.IconCoord))
			if not property.border then
				property.border = CreateFrame("Frame", nil, property)
				property.Icon:StyleButton()
			end

			numPropertiesStyled = numPropertiesStyled + 1
			property = properties[numPropertiesStyled]
		end
		tooltipFrame.numPropertiesStyled = numPropertiesStyled
	end)
end

D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin
tinsert(D.SkinFuncs["DuffedUI"], LoadGarrisonTooltipSkin)