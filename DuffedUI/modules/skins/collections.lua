local D, C, L = unpack(select(2, ...))

if not IsAddOnLoaded("AddOnSkins") then
	local function LoadSkin()
		-- [[Global]]--
		CollectionsJournal:StripTextures()
		CollectionsJournal:SetTemplate("Transparent")
		CollectionsJournalPortrait:Hide()
		CollectionsJournalTab1:SkinTab()
		CollectionsJournalTab2:SkinTab()
		CollectionsJournalTab3:SkinTab()
		CollectionsJournalTab4:SkinTab()
		CollectionsJournalCloseButton:SkinCloseButton()

		--[[Tab 1 - Mounts]]--
		MountJournal:StripTextures()
		MountJournal.LeftInset:StripTextures()
		MountJournal.RightInset:StripTextures()
		MountJournal.MountDisplay:StripTextures()
		MountJournal.MountDisplay.ShadowOverlay:StripTextures()
		MountJournal.MountCount:StripTextures()
		MountJournalMountButton:SkinButton(true)
		MountJournalListScrollFrameScrollBar:SkinScrollBar()
		MountJournal.MountDisplay.ModelFrame.RotateLeftButton:SkinCloseButton()
		MountJournal.MountDisplay.ModelFrame.RotateRightButton:SkinCloseButton()
		MountJournal.MountDisplay.ModelFrame.RotateLeftButton.t:SetText("<")
		MountJournal.MountDisplay.ModelFrame.RotateRightButton.t:SetText(">")
		MountJournalSearchBox:SkinEditBox()
		MountJournalFilterButton:StripTextures(true)
		MountJournalFilterButton:SkinButton()
		MountJournalFilterButton:ClearAllPoints()
		MountJournalFilterButton:Point("LEFT", MountJournalSearchBox, "RIGHT", 5, 0)

		for i = 1, #MountJournal.ListScrollFrame.buttons do
			local b = _G["MountJournalListScrollFrameButton" .. i]
			local z = _G["PetJournalListScrollFrameButton" .. i .. "LevelBG"]
			if not b.isSkinned then
				b:StripTextures()
				b:SetTemplate()
				b:StyleButton()
				b:SetBackdropBorderColor(0, 0, 0, 0)
				b:HideInsets()
				b.icon:SetTexCoord(.08, .92, .08, .92)
				b.DragButton:StyleButton()
				b.DragButton.hover:SetAllPoints(b.DragButton)
				b.DragButton.ActiveTexture:SetAlpha(0)
				b.favorite:SetTexture("Interface\\COMMON\\FavoritesIcon")
				b.favorite:SetPoint("TOPLEFT",b.DragButton,"TOPLEFT", -4, 4)
				b.favorite:SetSize(32, 32)

				b:CreateBackdrop("Default")
				b.backdrop:Point("TOPLEFT", b.icon, -2, 2)
				b.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)
				b.backdrop:SetBackdropColor(0, 0, 0, 0)

				z:SetTexture(nil)
				b.isSkinned = true
			end
		end

		--[[Color selected Mount]]--
		local function ColorSelectedMount()
			for i = 1, #MountJournal.ListScrollFrame.buttons do
				local b = _G["MountJournalListScrollFrameButton" .. i]
				local t = _G["MountJournalListScrollFrameButton" .. i .. "name"]
				if b.DragButton.ActiveTexture:IsShown() then
					b.backdrop:SetBackdropBorderColor(1, 1, 0)
				else
					b.backdrop:SetBackdropBorderColor(unpack(C["media"]["bordercolor"]))
				end
			end
		end
		hooksecurefunc("MountJournal_UpdateMountList", ColorSelectedMount)

		MountJournalSummonRandomFavoriteButton:StripTextures()
		MountJournalSummonRandomFavoriteButton:CreateBackdrop()
		MountJournalSummonRandomFavoriteButton:StyleButton()
		MountJournalSummonRandomFavoriteButton.texture:SetTexture([[Interface/ICONS/ACHIEVEMENT_GUILDPERK_MOUNTUP]])
		MountJournalSummonRandomFavoriteButton.texture:SetTexCoord(.08, .88, .08, .88)

		--[[Bugfix for scrolling mount list]]--
		MountJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedMount)
		MountJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedMount)

		--[[Tab 2 - Pets]]--
		PetJournalSummonButton:StripTextures()
		PetJournalFindBattle:StripTextures()
		PetJournalSummonButton:SkinButton()
		PetJournalFindBattle:SkinButton()
		PetJournalRightInset:StripTextures()
		PetJournalLeftInset:StripTextures()

		PetJournal.PetCount:StripTextures()
		PetJournalSearchBox:SkinEditBox()
		PetJournalFilterButton:StripTextures(true)
		PetJournalFilterButton:SkinButton()
		PetJournalFilterButton:ClearAllPoints()
		PetJournalFilterButton:Point("LEFT", PetJournalSearchBox, "RIGHT", 5, 0)
		PetJournalListScrollFrame:StripTextures()
		PetJournalListScrollFrameScrollBar:SkinScrollBar()

		for i = 1, #PetJournal.listScroll.buttons do
			local b = _G["PetJournalListScrollFrameButton" .. i]
			if not b.isSkinned then
				b:StripTextures()
				b:SetTemplate()
				b:StyleButton()
				b:SetBackdropBorderColor(0, 0, 0, 0)
				b:HideInsets()
				b.icon:SetTexCoord(.08, .92, .08, .92)
				b.dragButton:StyleButton()
				b.dragButton.hover:SetAllPoints(b.dragButton)
				b.dragButton.ActiveTexture:SetAlpha(0)

				b:CreateBackdrop("Default")
				b.backdrop:Point("TOPLEFT", b.icon, -2, 2)
				b.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)
				b.backdrop:SetBackdropColor(0, 0, 0, 0)

				b.isSkinned = true
			end
		end

		local function UpdatePetCardQuality()
			if PetJournalPetCard.petID  then
				local speciesID, customName, level, xp, maxXp, displayID, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoByPetID(PetJournalPetCard.petID)
				if canBattle then
					local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(PetJournalPetCard.petID)
					PetJournalPetCard.QualityFrame.quality:SetText(_G["BATTLE_PET_BREED_QUALITY" .. rarity])
					local color = ITEM_QUALITY_COLORS[rarity - 1]
					PetJournalPetCard.QualityFrame.quality:SetVertexColor(color.r, color.g, color.b)
					PetJournalPetCard.QualityFrame:Show()
				else
					PetJournalPetCard.QualityFrame:Hide()
				end
			end
		end
		hooksecurefunc("PetJournal_UpdatePetCard", UpdatePetCardQuality)

		local function ColorSelectedPet()
			local petButtons = PetJournal.listScroll.buttons
			if petButtons then
				for i = 1, #petButtons do
					local index = petButtons[i].index
					if index then
						local b = _G["PetJournalListScrollFrameButton" .. i]
						local t = _G["PetJournalListScrollFrameButton" .. i .. "Name"]
						local petID, speciesID, isOwned, customName, level, favorite, isRevoked, name, icon, petType, creatureID, sourceText, description, isWildPet, canBattle = C_PetJournal.GetPetInfoByIndex(index)

						if petID then
							local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petID)

							if b.dragButton.ActiveTexture:IsShown() then t:SetTextColor(1, 1, 0) else t:SetTextColor(1, 1, 1) end

							if rarity then
								local color = ITEM_QUALITY_COLORS[rarity - 1]
								b.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
							else
								b.backdrop:SetBackdropBorderColor(1, 1, 0)
							end
						end
					end
				end
			end
		end
		hooksecurefunc("PetJournal_UpdatePetList", ColorSelectedPet)
		PetJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedPet)
		PetJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedPet)

		PetJournalAchievementStatus:DisableDrawLayer("BACKGROUND")

		PetJournalHealPetButton:StripTextures()
		PetJournalHealPetButton:CreateBackdrop()
		PetJournalHealPetButton:StyleButton()
		PetJournalHealPetButton.texture:SetTexture([[Interface\Icons\spell_magic_polymorphrabbit]])
		PetJournalHealPetButton.texture:SetTexCoord(.08, .88, .08, .88)
		PetJournalLoadoutBorder:StripTextures()
		for i = 1, 3 do
			_G["PetJournalLoadoutPet" .. i .. "HelpFrame"]:StripTextures()
			_G["PetJournalLoadoutPet" .. i]:StripTextures()
			_G["PetJournalLoadoutPet" .. i]:CreateBackdrop()
			_G["PetJournalLoadoutPet" .. i].backdrop:SetAllPoints()
			_G["PetJournalLoadoutPet" .. i].petTypeIcon:SetPoint("BOTTOMLEFT", 2, 2)
			_G["PetJournalLoadoutPet" .. i]:StyleButton()

			_G["PetJournalLoadoutPet" .. i].dragButton:StyleButton()
			_G["PetJournalLoadoutPet" .. i].dragButton:SetOutside(_G["PetJournalLoadoutPet" .. i .. "Icon"])
			_G["PetJournalLoadoutPet" .. i].dragButton:SetFrameLevel(_G["PetJournalLoadoutPet" .. i].dragButton:GetFrameLevel() + 1)
			_G["PetJournalLoadoutPet" .. i]:SkinIconButton()
			_G["PetJournalLoadoutPet" .. i].backdrop:SetFrameLevel(_G["PetJournalLoadoutPet" .. i].backdrop:GetFrameLevel() + 1)

			_G["PetJournalLoadoutPet" .. i].setButton:StripTextures()
			_G["PetJournalLoadoutPet" .. i .. "HealthFrame"].healthBar:StripTextures()
			_G["PetJournalLoadoutPet" .. i .. "HealthFrame"].healthBar:CreateBackdrop("Default")
			_G["PetJournalLoadoutPet" .. i .. "HealthFrame"].healthBar:SetStatusBarTexture(C["media"]["normTex"])
			_G["PetJournalLoadoutPet" .. i .. "XPBar"]:StripTextures()
			_G["PetJournalLoadoutPet" .. i .. "XPBar"]:CreateBackdrop("Default")
			_G["PetJournalLoadoutPet" .. i .. "XPBar"]:SetStatusBarTexture(C["media"]["normTex"])
			_G["PetJournalLoadoutPet" .. i .. "XPBar"]:SetFrameLevel(_G["PetJournalLoadoutPet" .. i .. "XPBar"]:GetFrameLevel() + 2)

			for index = 1, 3 do
				local f = _G["PetJournalLoadoutPet" .. i .. "Spell" .. index]
				f:SkinIconButton()
				f.FlyoutArrow:SetTexture([[Interface\Buttons\ActionBarFlyoutButton]])
				_G["PetJournalLoadoutPet" .. i .. "Spell" .. index .. "Icon"]:SetInside(f)
			end
		end

		PetJournalSpellSelect:StripTextures()
		for i = 1, 2 do
			local btn = _G["PetJournalSpellSelectSpell"..i]
			btn:SkinButton()
			_G["PetJournalSpellSelectSpell" .. i .. "Icon"]:SetInside(btn)
			_G["PetJournalSpellSelectSpell" .. i .. "Icon"]:SetDrawLayer("BORDER")
		end

		PetJournalPetCard:StripTextures()
		PetJournalPetCardInset:StripTextures()

		PetJournalTutorialButton.Ring:SetAlpha(0)
		PetJournalTutorialButton:ClearAllPoints()
		PetJournalTutorialButton:SetPoint("TOPLEFT", CollectionsJournal, 0, 0)

		PetJournalPetCardPetInfo.levelBG:SetTexture(nil)
		PetJournalPetCardPetInfoIcon:SetTexCoord(.1, .9, .1, .9)
		PetJournalPetCardPetInfo:CreateBackdrop()
		PetJournalPetCardPetInfo.backdrop:SetOutside(PetJournalPetCardPetInfoIcon)
		PetJournalPetCardPetInfoIcon:SetParent(PetJournalPetCardPetInfo.backdrop)
		PetJournalPetCardPetInfo.backdrop:SetFrameLevel(PetJournalPetCardPetInfo.backdrop:GetFrameLevel() + 2)
		PetJournalPetCardPetInfo.level:SetParent(PetJournalPetCardPetInfo.backdrop)

		local tt = PetJournalPrimaryAbilityTooltip
		tt.Background:SetTexture(nil)
		if tt.Delimiter1 then
			tt.Delimiter1:SetTexture(nil)
			tt.Delimiter2:SetTexture(nil)
		end
		tt.BorderTop:SetTexture(nil)
		tt.BorderTopLeft:SetTexture(nil)
		tt.BorderTopRight:SetTexture(nil)
		tt.BorderLeft:SetTexture(nil)
		tt.BorderRight:SetTexture(nil)
		tt.BorderBottom:SetTexture(nil)
		tt.BorderBottomRight:SetTexture(nil)
		tt.BorderBottomLeft:SetTexture(nil)
		tt:SetTemplate("Transparent")

		for i = 1, 6 do
			local frame = _G["PetJournalPetCardSpell" .. i]
			frame:SetFrameLevel(frame:GetFrameLevel() + 2)
			frame:DisableDrawLayer("BACKGROUND")
			frame:CreateBackdrop("Default")
			frame.backdrop:SetAllPoints()
			frame.icon:SetTexCoord(.1, .9, .1, .9)
			frame.icon:SetInside(frame.backdrop)
		end

		PetJournalPetCardHealthFrame.healthBar:StripTextures()
		PetJournalPetCardHealthFrame.healthBar:CreateBackdrop("Default")
		PetJournalPetCardHealthFrame.healthBar:SetStatusBarTexture(C["media"]["normTex"])
		PetJournalPetCardXPBar:StripTextures()
		PetJournalPetCardXPBar:CreateBackdrop("Default")
		PetJournalPetCardXPBar:SetStatusBarTexture(C["media"]["normTex"])
		PetJournalLoadoutBorder:Height(350)

		--[[Tab 3 - Toybox]]--
		ToyBox.progressBar:StripTextures()
		ToyBox.progressBar:SetStatusBarTexture(C["media"]["normTex"])
		ToyBox.progressBar:CreateBackdrop()
		ToyBox.searchBox:SkinEditBox()
		ToyBox.iconsFrame:StripTextures()
		ToyBoxFilterButton:StripTextures(true)
		ToyBoxFilterButton:SkinButton()
		ToyBoxFilterButton:ClearAllPoints()
		ToyBoxFilterButton:Point("LEFT", ToyBoxSearchBox, "RIGHT", 5, 0)

		for i = 1, 18 do
			ToyBox.iconsFrame["spellButton" .. i]:StripTextures()
			ToyBox.iconsFrame["spellButton" .. i]:SkinButton()
			ToyBox.iconsFrame["spellButton" .. i].iconTexture:SetTexCoord(.1, .9, .1, .9)
			ToyBox.iconsFrame["spellButton" .. i].iconTexture:SetInside()
			ToyBox.iconsFrame["spellButton" .. i].iconTextureUncollected:SetTexCoord(.1, .9, .1, .9)
			ToyBox.iconsFrame["spellButton" .. i].iconTextureUncollected:SetInside(ToyBox.iconsFrame["spellButton" .. i])
			ToyBox.iconsFrame["spellButton" .. i].cooldown:SetAllPoints(ToyBox.iconsFrame["spellButton" .. i].iconTexture)
		end

		hooksecurefunc("ToySpellButton_UpdateButton", function(self)
			if (PlayerHasToy(self.itemID)) then
				self.name:SetTextColor(1, 1, 1)
				self.new:SetTextColor(1, 1, 1)
			else
				self.name:SetTextColor(.6, .6, .6)
				self.new:SetTextColor(.6, .6, .6)
			end
			self.updateFunction = ToySpellButton_UpdateButton
		end)

		ToyBox.navigationFrame.prevPageButton:SkinCloseButton()
		ToyBox.navigationFrame.nextPageButton:SkinCloseButton()
		ToyBox.navigationFrame.prevPageButton.t:SetText("<")
		ToyBox.navigationFrame.nextPageButton.t:SetText(">")

		--[[Tab 4 - Heirlooms]]--
		HeirloomsJournalFilterButton:StripTextures()
		HeirloomsJournalFilterButton:SkinButton()
		HeirloomsJournalFilterButton:ClearAllPoints()
		HeirloomsJournalFilterButton:Point("LEFT", HeirloomsJournalSearchBox, "RIGHT", 5, 0)

		HeirloomsJournal.SearchBox:SkinEditBox()
		HeirloomsJournal.iconsFrame:StripTextures()
		HeirloomsJournal.navigationFrame.prevPageButton:SkinCloseButton()
		HeirloomsJournal.navigationFrame.nextPageButton:SkinCloseButton()
		HeirloomsJournal.navigationFrame.prevPageButton.t:SetText("<")
		HeirloomsJournal.navigationFrame.nextPageButton.t:SetText(">")
		HeirloomsJournal.progressBar:StripTextures()
		HeirloomsJournal.progressBar:SetStatusBarTexture(C["media"]["normTex"])
		HeirloomsJournal.progressBar:CreateBackdrop()
		HeirloomsJournalClassDropDown:SkinDropDownBox()
		hooksecurefunc(HeirloomsJournal, "LayoutCurrentPage", function()
			for i = 1, #HeirloomsJournal.heirloomHeaderFrames do
				local header = HeirloomsJournal.heirloomHeaderFrames[i]
				header.text:SetTextColor(1, 1, 0)
			end

			for i = 1, #HeirloomsJournal.heirloomEntryFrames do
				local button = HeirloomsJournal.heirloomEntryFrames[i]
				if not button.skinned then
					button.skinned = true
					button:StripTextures()
					button:SkinButton()
					button.iconTextureUncollected:SetTexCoord(.1, .9, .1, .9)
					button.iconTextureUncollected:SetInside(button)
					button.iconTextureUncollected:SetTexture(button.iconTexture:GetTexture())
					HeirloomsJournal:UpdateButton(button)
				end

				if C_Heirloom.PlayerHasHeirloom(button.itemID) then button.name:SetTextColor(1, 1, 1) else button.name:SetTextColor(.6, .6, .6) end
			end
		end)

		hooksecurefunc(HeirloomsJournal, "UpdateButton", function(self, button)
			button.iconTextureUncollected:SetTexture(button.iconTexture:GetTexture())
			if C_Heirloom.PlayerHasHeirloom(button.itemID) then button.name:SetTextColor(1, 1, 1) else button.name:SetTextColor(.6, .6, .6) end
		end)
	end

	if CollectionsJournal then tinsert(D.SkinFuncs["DuffedUI"], LoadSkin) else D.SkinFuncs["Blizzard_Collections"] = LoadSkin end
end

local function LoadPetStableSkin()
	PetStableFrame:StripTextures()
	PetStableFrame:SetTemplate()
	PetStableFrameInset:StripTextures()
	PetStableLeftInset:StripTextures()
	PetStableBottomInset:StripTextures()
	PetStableFrameCloseButton:SkinCloseButton()
	PetStablePrevPageButton:SkinNextPrevButton()
	PetStableNextPageButton:SkinNextPrevButton()
	
	for i = 1, 5 do
		local b = _G["PetStableActivePet" .. i]
		b.Border:Hide()
		b.Background:Hide()
		b:SkinButton()
	end
	
	for i = 1, 10 do
		local b = _G["PetStableStabledPet" .. i]
		b.Background:Hide()
		b:SkinButton()
		b:StyleButton()
	end
end
tinsert(D.SkinFuncs["DuffedUI"], LoadPetStableSkin)