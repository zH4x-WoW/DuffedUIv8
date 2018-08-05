local D, C, L = unpack(select(2, ...))

if not IsAddOnLoaded('AddOnSkins') then
	local function LoadSkin()
		-- Global
		CollectionsJournal:StripTextures()
		CollectionsJournal:SetTemplate('Transparent')
		CollectionsJournalPortrait:Hide()
		for i = 1, 5 do _G['CollectionsJournalTab' .. i]:SkinTab() end
		CollectionsJournalCloseButton:SkinCloseButton()

		-- Tab 1 - Mounts
		MountJournal:StripTextures()
		MountJournal.LeftInset:StripTextures()
		MountJournal.RightInset:StripTextures()
		MountJournal.MountDisplay:StripTextures()
		MountJournal.MountDisplay.ShadowOverlay:StripTextures()
		MountJournal.MountCount:StripTextures()
		MountJournalMountButton:SkinButton(true)
		MountJournalListScrollFrameScrollBar:SkinScrollBar()
		MountJournal.MountDisplay.ModelScene.RotateLeftButton:SkinCloseButton()
		MountJournal.MountDisplay.ModelScene.RotateRightButton:SkinCloseButton()
		MountJournal.MountDisplay.ModelScene.RotateLeftButton.t:SetText('<')
		MountJournal.MountDisplay.ModelScene.RotateRightButton.t:SetText('>')
		MountJournalSearchBox:SkinEditBox()
		MountJournalFilterButton:StripTextures(true)
		MountJournalFilterButton:SkinButton()
		MountJournalFilterButton:ClearAllPoints()
		MountJournalFilterButton:Point('LEFT', MountJournalSearchBox, 'RIGHT', 5, 0)

		for i = 1, #MountJournal.ListScrollFrame.buttons do
			local b = _G['MountJournalListScrollFrameButton' .. i]
			local z = _G['PetJournalListScrollFrameButton' .. i .. 'LevelBG']
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
				b.favorite:SetTexture('Interface\\COMMON\\FavoritesIcon')
				b.favorite:SetPoint('TOPLEFT',b.DragButton,'TOPLEFT', -4, 4)
				b.favorite:SetSize(32, 32)

				b:CreateBackdrop('Default')
				b.backdrop:Point('TOPLEFT', b.icon, -2, 2)
				b.backdrop:Point('BOTTOMRIGHT', b.icon, 2, -2)
				b.backdrop:SetBackdropColor(0, 0, 0, 0)

				z:SetTexture(nil)
				b.isSkinned = true
			end
		end

		-- Color selected Mount
		local function ColorSelectedMount()
			for i = 1, #MountJournal.ListScrollFrame.buttons do
				local b = _G['MountJournalListScrollFrameButton' .. i]
				local t = _G['MountJournalListScrollFrameButton' .. i .. 'name']
				if b.DragButton.ActiveTexture:IsShown() then
					b.backdrop:SetBackdropBorderColor(1, 1, 0)
				else
					b.backdrop:SetBackdropBorderColor(unpack(C['media']['bordercolor']))
				end
			end
		end
		hooksecurefunc('MountJournal_UpdateMountList', ColorSelectedMount)
		MountJournalSummonRandomFavoriteButton:SkinIconButton()

		-- Bugfix for scrolling mount list
		MountJournalListScrollFrame:HookScript('OnVerticalScroll', ColorSelectedMount)
		MountJournalListScrollFrame:HookScript('OnMouseWheel', ColorSelectedMount)

		-- Tab 2 - Pets
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
		PetJournalFilterButton:Point('LEFT', PetJournalSearchBox, 'RIGHT', 5, 0)
		PetJournalListScrollFrameScrollBar:SkinScrollBar()
		PetJournalSummonRandomFavoritePetButton:SkinIconButton()

		for i = 1, #PetJournal.listScroll.buttons do
			local b = _G['PetJournalListScrollFrameButton' .. i]
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

				b:CreateBackdrop('Default')
				b.backdrop:Point('TOPLEFT', b.icon, -2, 2)
				b.backdrop:Point('BOTTOMRIGHT', b.icon, 2, -2)
				b.backdrop:SetBackdropColor(0, 0, 0, 0)

				b.isSkinned = true
			end
		end

		local function UpdatePetCardQuality()
			if PetJournalPetCard.petID  then
				local speciesID, customName, level, xp, maxXp, displayID, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable = C_PetJournal.GetPetInfoByPetID(PetJournalPetCard.petID)
				if canBattle then
					local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(PetJournalPetCard.petID)
					PetJournalPetCard.QualityFrame.quality:SetText(_G['BATTLE_PET_BREED_QUALITY' .. rarity])
					local color = ITEM_QUALITY_COLORS[rarity - 1]
					PetJournalPetCard.QualityFrame.quality:SetVertexColor(color.r, color.g, color.b)
					PetJournalPetCard.QualityFrame:Show()
				else
					PetJournalPetCard.QualityFrame:Hide()
				end
			end
		end
		hooksecurefunc('PetJournal_UpdatePetCard', UpdatePetCardQuality)

		local function ColorSelectedPet()
			local petButtons = PetJournal.listScroll.buttons
			if petButtons then
				for i = 1, #petButtons do
					local index = petButtons[i].index
					if index then
						local b = _G['PetJournalListScrollFrameButton' .. i]
						local t = _G['PetJournalListScrollFrameButton' .. i .. 'Name']
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
		hooksecurefunc('PetJournal_UpdatePetList', ColorSelectedPet)

		PetJournalListScrollFrame:HookScript('OnVerticalScroll', ColorSelectedPet)
		PetJournalListScrollFrame:HookScript('OnMouseWheel', ColorSelectedPet)
		PetJournalAchievementStatus:DisableDrawLayer('BACKGROUND')
		PetJournalHealPetButton:StripTextures()
		PetJournalHealPetButton:CreateBackdrop()
		PetJournalHealPetButton:StyleButton()
		PetJournalHealPetButton.texture:SetTexture([[Interface\Icons\spell_magic_polymorphrabbit]])
		PetJournalHealPetButton.texture:SetTexCoord(.08, .88, .08, .88)
		PetJournalLoadoutBorder:StripTextures()
		
		for i = 1, 3 do
			local Pet = _G['PetJournalLoadoutPet'..i]
			Pet.helpFrame:StripTextures()
			Pet:StripTextures()
			Pet:SetTemplate()
			Pet.petTypeIcon:SetPoint('BOTTOMLEFT', 2, 2)

			Pet.icon:SetTexCoord(.08, .88, .08, .88)
			Pet.dragButton:StyleButton()
			Pet.dragButton:CreateBackdrop()
			Pet.dragButton.backdrop:SetOutside(Pet.icon)

			Pet.setButton:StripTextures()
			Pet.healthFrame.healthBar:SkinStatusBar()
			Pet.xpBar:SkinStatusBar()

			hooksecurefunc(Pet.qualityBorder, 'SetVertexColor', function(self, r, g, b)
				Pet.dragButton.backdrop:SetBackdropBorderColor(r, g, b)
			end)

			for index = 1, 3 do
				local Spell = _G['PetJournalLoadoutPet'..i..'Spell'..index]
				Spell:SkinIconButton()
				Spell.FlyoutArrow:SetTexture([[Interface\Buttons\ActionBarFlyoutButton]])
				_G['PetJournalLoadoutPet'..i..'Spell'..index..'Icon']:SetInside(Spell)
			end
		end

		PetJournalSpellSelect:StripTextures()
		for i = 1, 2 do
			local btn = _G['PetJournalSpellSelectSpell'..i]
			btn:SkinButton()
			_G['PetJournalSpellSelectSpell' .. i .. 'Icon']:SetInside(btn)
			_G['PetJournalSpellSelectSpell' .. i .. 'Icon']:SetDrawLayer('BORDER')
		end

		PetJournalPetCard:StripTextures()
		PetJournalPetCardInset:StripTextures()
		PetJournalTutorialButton.Ring:SetAlpha(0)
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
		tt:SetTemplate('Transparent')

		for i = 1, 6 do
			local frame = _G['PetJournalPetCardSpell' .. i]
			frame:SetFrameLevel(frame:GetFrameLevel() + 2)
			frame:DisableDrawLayer('BACKGROUND')
			frame:CreateBackdrop('Default')
			frame.backdrop:SetAllPoints()
			frame.icon:SetTexCoord(.1, .9, .1, .9)
			frame.icon:SetInside(frame.backdrop)
		end

		PetJournalPetCardHealthFrame.healthBar:StripTextures()
		PetJournalPetCardHealthFrame.healthBar:CreateBackdrop('Default')
		PetJournalPetCardHealthFrame.healthBar:SetStatusBarTexture(C['media']['normTex'])
		PetJournalPetCardXPBar:StripTextures()
		PetJournalPetCardXPBar:CreateBackdrop('Default')
		PetJournalPetCardXPBar:SetStatusBarTexture(C['media']['normTex'])
		PetJournalLoadoutBorder:Height(350)

		-- Tab 3 - Toybox
		ToyBox.progressBar:StripTextures()
		ToyBox.progressBar:SetStatusBarTexture(C['media']['normTex'])
		ToyBox.progressBar:CreateBackdrop()
		ToyBox.searchBox:SkinEditBox()
		ToyBox.iconsFrame:StripTextures()
		ToyBoxFilterButton:StripTextures(true)
		ToyBoxFilterButton:SkinButton()
		ToyBoxFilterButton:ClearAllPoints()
		ToyBoxFilterButton:Point('LEFT', ToyBoxSearchBox, 'RIGHT', 5, 0)

		for i = 1, 18 do
			ToyBox.iconsFrame['spellButton' .. i]:StripTextures()
			ToyBox.iconsFrame['spellButton' .. i]:SkinButton()
			ToyBox.iconsFrame['spellButton' .. i].iconTexture:SetTexCoord(.1, .9, .1, .9)
			ToyBox.iconsFrame['spellButton' .. i].iconTexture:SetInside()
			ToyBox.iconsFrame['spellButton' .. i].iconTextureUncollected:SetTexCoord(.1, .9, .1, .9)
			ToyBox.iconsFrame['spellButton' .. i].iconTextureUncollected:SetInside(ToyBox.iconsFrame['spellButton' .. i])
			ToyBox.iconsFrame['spellButton' .. i].cooldown:SetAllPoints(ToyBox.iconsFrame['spellButton' .. i].iconTexture)
		end

		hooksecurefunc('ToySpellButton_UpdateButton', function(self)
			if (PlayerHasToy(self.itemID)) then
				self.name:SetTextColor(1, 1, 1)
				self.new:SetTextColor(1, 1, 1)
			else
				self.name:SetTextColor(.6, .6, .6)
				self.new:SetTextColor(.6, .6, .6)
			end
			self.updateFunction = ToySpellButton_UpdateButton
		end)

		ToyBox.PagingFrame.PrevPageButton:SkinCloseButton()
		ToyBox.PagingFrame.NextPageButton:SkinCloseButton()
		ToyBox.PagingFrame.PrevPageButton.t:SetText('<')
		ToyBox.PagingFrame.NextPageButton.t:SetText('>')

		-- Tab 4 - Heirlooms
		HeirloomsJournalFilterButton:StripTextures()
		HeirloomsJournalFilterButton:SkinButton()
		HeirloomsJournalFilterButton:ClearAllPoints()
		HeirloomsJournalFilterButton:Point('LEFT', HeirloomsJournalSearchBox, 'RIGHT', 5, 0)

		HeirloomsJournal.SearchBox:SkinEditBox()
		HeirloomsJournal.iconsFrame:StripTextures()
		HeirloomsJournal.PagingFrame.PrevPageButton:SkinCloseButton()
		HeirloomsJournal.PagingFrame.NextPageButton:SkinCloseButton()
		HeirloomsJournal.PagingFrame.PrevPageButton.t:SetText('<')
		HeirloomsJournal.PagingFrame.NextPageButton.t:SetText('>')
		HeirloomsJournal.progressBar:StripTextures()
		HeirloomsJournal.progressBar:SetStatusBarTexture(C['media']['normTex'])
		HeirloomsJournal.progressBar:CreateBackdrop()
		HeirloomsJournalClassDropDown:SkinDropDownBox()
		HeirloomsJournalFilterButton:StripTextures(true)
		HeirloomsJournalFilterButton:SkinButton()
		hooksecurefunc(HeirloomsJournal, 'LayoutCurrentPage', function()
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

		hooksecurefunc(HeirloomsJournal, 'UpdateButton', function(self, button)
			button.iconTextureUncollected:SetTexture(button.iconTexture:GetTexture())
			if C_Heirloom.PlayerHasHeirloom(button.itemID) then button.name:SetTextColor(1, 1, 1) else button.name:SetTextColor(.6, .6, .6) end
		end)

		-- Tab 5 - Transmog (Collection)
		WardrobeCollectionFrame.progressBar:StripTextures()
		WardrobeCollectionFrame.progressBar:SetStatusBarTexture(C['media']['normTex'])
		WardrobeCollectionFrame.progressBar:CreateBackdrop()
		WardrobeCollectionFrameSearchBox:SkinEditBox()
		WardrobeCollectionFrame.FilterButton:SkinButton()
		WardrobeCollectionFrame.FilterButton:SetWidth(80)
		WardrobeCollectionFrame.ItemsCollectionFrame:StripTextures()
		WardrobeCollectionFrameWeaponDropDown:SkinDropDownBox()
		WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PrevPageButton:SkinCloseButton()
		WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.NextPageButton:SkinCloseButton()
		WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.PrevPageButton.t:SetText('<')
		WardrobeCollectionFrame.ItemsCollectionFrame.PagingFrame.NextPageButton.t:SetText('>')
		WardrobeCollectionFrame.FilterButton:StripTextures(true)
		WardrobeCollectionFrame.FilterButton:SkinButton()
		
		for i = 1, 3 do
			for j = 1, 6 do
				WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..i..'C'..j]:StripTextures()
				WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..i..'C'..j]:SetFrameLevel(WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..i..'C'..j]:GetFrameLevel() + 2)
				WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..i..'C'..j]:CreateBackdrop()
				WardrobeCollectionFrame.ItemsCollectionFrame['ModelR'..i..'C'..j].Border:Kill()
			end
		end

		WardrobeCollectionFrameTab1:SkinTab()
		WardrobeCollectionFrameTab2:SkinTab()
		WardrobeCollectionFrame.SetsCollectionFrame:StripTextures()
		WardrobeCollectionFrame.SetsCollectionFrame.LeftInset:StripTextures()
		WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame:StripTextures()
		WardrobeCollectionFrame.SetsCollectionFrame.RightInset:StripTextures()
		WardrobeCollectionFrameScrollFrameScrollBar:SkinScrollBar()
		WardrobeSetsCollectionVariantSetsButton:SkinButton()

		-- Tab 5 - Transmog (NPC)
		WardrobeFrame:StripTextures()
		WardrobeFrame:SetTemplate('Transparent')
		WardrobeFrameCloseButton:SkinCloseButton()
		WardrobeOutfitDropDown:SkinDropDownBox()
		WardrobeOutfitDropDown:SetSize(200, 32)
		WardrobeOutfitDropDownText:ClearAllPoints()
		WardrobeOutfitDropDownText:SetPoint('CENTER', WardrobeOutfitDropDown, 10, 2)
		WardrobeOutfitDropDown.SaveButton:SkinButton()
		WardrobeOutfitDropDown.SaveButton:ClearAllPoints()
		WardrobeOutfitDropDown.SaveButton:SetPoint('LEFT', WardrobeOutfitDropDown, 'RIGHT', 1, 4)
		WardrobeOutfitFrame:StripTextures()
		WardrobeOutfitFrame:SetTemplate('Transparent')
		
		WardrobeTransmogFrame:StripTextures()
		WardrobeTransmogFrame.Inset:StripTextures()
		
		for i = 1, #WardrobeTransmogFrame.Model.SlotButtons do
			WardrobeTransmogFrame.Model.SlotButtons[i]:StripTextures()
			WardrobeTransmogFrame.Model.SlotButtons[i].Icon:SetTexCoord(unpack(D['IconCoord']))
			WardrobeTransmogFrame.Model.SlotButtons[i]:SetFrameLevel(WardrobeTransmogFrame.Model.SlotButtons[i]:GetFrameLevel() + 2)
			WardrobeTransmogFrame.Model.SlotButtons[i]:CreateBackdrop('Default')
			WardrobeTransmogFrame.Model.SlotButtons[i].Border:Kill()
		end
		
		local function OnEnter_Button(self) self:SkinButton() end
		WardrobeTransmogFrame.SpecButton:SkinButton()
		WardrobeTransmogFrame.SpecButton:SetScript('OnEnter', OnEnter_Button)
		WardrobeTransmogFrame.SpecButton:SetScript('OnLeave', OnEnter_Button)
		WardrobeTransmogFrame.SpecButton:ClearAllPoints()
		WardrobeTransmogFrame.SpecButton:SetPoint('RIGHT', WardrobeTransmogFrame.ApplyButton, 'LEFT', -2, 0)
		WardrobeTransmogFrame.ApplyButton:SkinButton()

		WardrobeCollectionFrame.SetsTransmogFrame:StripTextures()
		WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.PrevPageButton:SkinCloseButton()
		WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.NextPageButton:SkinCloseButton()
		WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.PrevPageButton.t:SetText('<')
		WardrobeCollectionFrame.SetsTransmogFrame.PagingFrame.NextPageButton.t:SetText('>')

		for i = 1, 2 do
			for j = 1, 4 do
				WardrobeCollectionFrame.SetsTransmogFrame['ModelR'..i..'C'..j]:StripTextures()
				WardrobeCollectionFrame.SetsTransmogFrame['ModelR'..i..'C'..j]:CreateBackdrop('Default')
			end
		end
	end

	if CollectionsJournal then tinsert(D['SkinFuncs']['DuffedUI'], LoadSkin) else D['SkinFuncs']['Blizzard_Collections'] = LoadSkin end
end

local function LoadPetStableSkin()
	PetStableFrame:StripTextures()
	PetStableFrame:SetTemplate('Transparent')
	PetStableFrameInset:StripTextures()
	PetStableLeftInset:StripTextures()
	PetStableBottomInset:StripTextures()
	PetStableFrameCloseButton:SkinCloseButton()
	PetStablePrevPageButton:SkinNextPrevButton()
	PetStableNextPageButton:SkinNextPrevButton()

	for i = 1, 5 do
		local b = _G['PetStableActivePet' .. i]
		b.Border:Hide()
		b.Background:Hide()
		b:SkinButton()
	end

	for i = 1, 10 do
		local b = _G['PetStableStabledPet' .. i]
		b.Background:Hide()
		b:SkinButton()
		b:StyleButton()
	end
end
tinsert(D['SkinFuncs']['DuffedUI'], LoadPetStableSkin)
