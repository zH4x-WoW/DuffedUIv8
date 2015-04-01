local D, C, L = unpack(select(2, ...))

local menuFrame = CreateFrame("Frame", "DuffedUIMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")
D.MicroMenu = {
	{text = CHARACTER_BUTTON, func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON, func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON, func = function() if not PlayerTalentFrame then TalentFrame_LoadUI() end ShowUIPanel(PlayerTalentFrame) end},
	{text = ACHIEVEMENT_BUTTON, func = function() ToggleAchievementFrame() end},
	{text = MOUNTS_AND_PETS, func = function() ToggleCollectionsJournal() end},
	{text = SOCIAL_BUTTON, func = function() ToggleFriendsFrame() end},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE.." / "..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP, func = function() PVEFrame_ToggleFrame() end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function() 
		if IsInGuild() then 
			if not GuildFrame then GuildFrame_LoadUI() end 
			GuildFrame_Toggle() 
		else 
			if not LookingForGuildFrame then LookingForGuildFrame_LoadUI() end 
			LookingForGuildFrame_Toggle() 
		end
	end},
	{text = RAID, func = function() ToggleFriendsFrame(4) end},
	{text = HELP_BUTTON, func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT, func = function() if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle() end},
	{text = ENCOUNTER_JOURNAL, func = function() if not IsAddOnLoaded("Blizzard_EncounterJournal") then EncounterJournal_LoadUI() end ToggleFrame(EncounterJournal) end},
	{text = BLIZZARD_STORE, func = function() StoreMicroButton:Click() end},
	{text = GARRISON_LANDING_PAGE_TITLE, func = function() GarrisonLandingPageMinimapButton_OnClick() end},
	{text = SOCIAL_TWITTER_COMPOSE_NEW_TWEET,
	func = function()
		if not SocialPostFrame then LoadAddOn("Blizzard_SocialUI") end

		local IsTwitterEnabled = C_Social.IsSocialEnabled()
		if IsTwitterEnabled then Social_SetShown(true) else print("|cffC41F3BTwitter is not enabled|r") end
	end},
}

-- need to be opened at least one time before logging in, or big chance of taint later ...
local taint = CreateFrame("Frame")
taint:RegisterEvent("ADDON_LOADED")
taint:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then return end
	ToggleFrame(SpellBookFrame)
	ToggleCollectionsJournal()
end)