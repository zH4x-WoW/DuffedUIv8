local D, C, L = select(2, ...):unpack()
local Miscellaneous = D["Miscellaneous"]
local MenuFrame = CreateFrame("Frame", "DuffedUIMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")

local MicroMenu = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function()
		if (not PlayerTalentFrame) then
			TalentFrame_LoadUI()
		end

		ShowUIPanel(PlayerTalentFrame)
	end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = MOUNTS_AND_PETS,
	func = function() TogglePetJournal() end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE,
	func = function() PVEFrame_ToggleFrame() end},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
	func = function()
		if (not PVPUIFrame) then
			PVP_LoadUI()
		end

		PVPUIFrame_ToggleFrame()
	end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function()
		if IsInGuild() then
			if (not GuildFrame) then
				GuildFrame_LoadUI()
			end

			GuildFrame_Toggle()
		else
			if (not LookingForGuildFrame) then
				LookingForGuildFrame_LoadUI()
			end

			LookingForGuildFrame_Toggle()
		end
	end},
	{text = RAID, func = function() ToggleFriendsFrame(4) end},
	{text = HELP_BUTTON, func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT,
	func = function()
		if (not CalendarFrame) then
			LoadAddOn("Blizzard_Calendar")
		end

		Calendar_Toggle()
	end},
	{text = ENCOUNTER_JOURNAL, func = function() ToggleEncounterJournal() end},
}

local TaintFix = CreateFrame("Frame")
TaintFix:RegisterEvent("ADDON_LOADED")
TaintFix:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then return end

	ToggleFrame(SpellBookFrame)
	PetJournal_LoadUI()
end)

Miscellaneous.MicroMenu = MicroMenu
Miscellaneous.MicroMenuFrame = MenuFrame