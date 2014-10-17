local D, C, L = unpack(select(2, ...))

--[[Modified Objective Tracker from ObbleYeah - All Credits goes to him]]--
local otfheight = 450
local otfwidth = 188
local titlesize = 13
local otf = ObjectiveTrackerFrame
local lST = "Wowhead"
local lQ = "http://www.wowhead.com/quest=%d"
local lA = "http://www.wowhead.com/achievement=%d"

_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
	text = lST .. " link",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

--[[Make the tracker moveable]]--
otf:SetClampedToScreen(true)
otf:ClearAllPoints()
otf.ClearAllPoints = D.Dummy
otf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -D.ScreenHeight / 5, -D.ScreenHeight / 4) 
otf.SetPoint = function() end
otf:SetMovable(true)
otf:SetUserPlaced(true)
otf:SetHeight(otfheight)
otf:SetWidth(otfwidth)

local otfmove = CreateFrame("FRAME", nil, otf)  
otfmove:SetHeight(21)
otfmove:SetPoint("TOPLEFT", otf, -11, -1)
otfmove:SetPoint("TOPRIGHT", otf)
otfmove:EnableMouse(true)
otfmove:RegisterForDrag("LeftButton")
otfmove:SetHitRectInsets(-5, -5, -5, -5)

local function OTFM_Tooltip(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP")
	GameTooltip:AddLine(L["move"]["watchframe"], 1, 1, 1)
	GameTooltip:Show()
end

otfmove:SetScript("OnDragStart", function(self, button)
	if IsModifiedClick() and button=="LeftButton" then
		local f = self:GetParent()
		f:StartMoving()
	end
end)

otfmove:SetScript("OnDragStop", function(self, button)
	local f = self:GetParent()
	f:StopMovingOrSizing()
end)

otfmove:SetScript("OnEnter", function(s) OTFM_Tooltip(s) end)
otfmove:SetScript("OnLeave", function(s) GameTooltip:Hide() end)
otf.HeaderMenu.MinimizeButton:SkinCloseButton()

--[[collapse the watchframe if in a bossfight, arena of world state capture bar is showing https://github.com/haste/oWatchFrameToggler/blob/master/auto.lua]]--
local otfboss = CreateFrame("Frame", nil)
otfboss:RegisterEvent("PLAYER_ENTERING_WORLD")
otfboss:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
otfboss:RegisterEvent("UNIT_TARGETABLE_CHANGED")
otfboss:RegisterEvent("PLAYER_REGEN_ENABLED")
otfboss:RegisterEvent("UPDATE_WORLD_STATES")

local function bossexists()
	for i = 1, MAX_BOSS_FRAMES do
		if UnitExists("boss" .. i) then return true end
	end
end

otfboss:SetScript("OnEvent", function(self, event)
	local _, instanceType = IsInInstance()
	local bar = _G["WorldStateCaptureBar1"]
	local mapcheck = GetMapInfo(mapFileName)

	if bossexists() then
		if not otf.collapsed then ObjectiveTracker_Collapse() end
	elseif instanceType == "arena" or instanceType == "pvp" then
		if not otf.collapsed then ObjectiveTracker_Collapse() end
	elseif bar and bar:IsVisible() then
		if not otf.collapsed then ObjectiveTracker_Collapse() end
	elseif otf.collapsed and instanceType == "raid" and not InCombatLockdown() then
		ObjectiveTracker_Expand()
	elseif otf.collapsed and mapcheck == "Ashran" and not InCombatLockdown() then
		ObjectiveTracker_Expand()
	end
end)

--[[quest item buttons moving and skinning]]--
local function moveQuestObjectiveItems(self)
	local a = {self:GetPoint()}
	self:ClearAllPoints()
	self:SetPoint("TOPRIGHT", a[2], "TOPLEFT", -13, -7)
	self:SetFrameLevel(0)

	local Icon = self.icon
	self:SkinButton()
	self:StyleButton()
	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:SetInside()
end

local qitime = 0
local qiinterval = 1
hooksecurefunc("QuestObjectiveItem_OnUpdate", function(self, elapsed)
	qitime = qitime + elapsed

	if qitime > qiinterval then
		moveQuestObjectiveItems(self)
		qitime = 0
	end
end)

--[[questtitle]]--
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function(self)
	for i = 1, GetNumQuestWatches() do
		local questID = GetQuestWatchInfo(i)
		if not questID then break end
		local block = QUEST_TRACKER_MODULE:GetBlock(questID)

		block.HeaderText:SetFont(STANDARD_TEXT_FONT, 13)
		block.HeaderText:SetShadowOffset(.7, -.7)
		block.HeaderText:SetShadowColor(0, 0, 0, 1)
		block.HeaderText:SetWidth(otfwidth)
		block.HeaderText:SetWordWrap(true)

		local heightcheck = block.HeaderText:GetNumLines()

		if heightcheck == 2 then
			local height = block:GetHeight()
			block:SetHeight(height + 16)
		end
	end
end)

--[[hide header art & restyle text]]--
if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
	hooksecurefunc("ObjectiveTracker_Update", function(reason, id)
		if otf.MODULES then
			for i = 1, #otf.MODULES do
				otf.MODULES[i].Header.Background:SetAtlas(nil)
				otf.MODULES[i].Header.Text:SetFont(STANDARD_TEXT_FONT, 15)
				otf.MODULES[i].Header.Text:ClearAllPoints()
				otf.MODULES[i].Header.Text:SetPoint("RIGHT", otf.MODULES[i].Header, -62, 0)
				otf.MODULES[i].Header.Text:SetJustifyH("LEFT")
			end
		end
	end)
end

--[[dashes to dots]]--
hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block, objectiveKey, _, lineType)
	local line = self:GetLine(block, objectiveKey, lineType)
	if line.Dash and line.Dash:IsShown() then line.Dash:SetText("• ") end
end)

--[[timer bars]]--
hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", function(self, block, line, duration, startTime)
	local tb = self.usedTimerBars[block] and self.usedTimerBars[block][line]
	if tb and tb:IsShown() and not tb.skinned then
		tb.Bar:SetStatusBarTexture(C["media"].normTex)
		tb.Bar:SetStatusBarColor(255/255, 108/255, 0/255)
		tb.skinned = true
	end
end)

--[[scenario buttons]]--
local function SkinScenarioButtons()
	local block = ScenarioStageBlock
	local _, currentStage, numStages, flags = C_Scenario.GetInfo()
	local inChallengeMode = C_Scenario.IsChallengeMode()

	block.NormalBG:SetSize(otfwidth + 21, 75)
	block.FinalBG:ClearAllPoints()
	block.FinalBG:SetPoint("TOPLEFT", block.NormalBG, 6, -6)
	block.FinalBG:SetPoint("BOTTOMRIGHT", block.NormalBG, -6, 6)
	block.GlowTexture:SetSize(otfwidth + 20, 75)
end

--[[proving grounds]]--
local function SkinProvingGroundButtons()
	local block = ScenarioProvingGroundsBlock
	local sb = block.StatusBar
	local anim = ScenarioProvingGroundsBlockAnim

	block.MedalIcon:SetSize(32, 32)
	block.MedalIcon:ClearAllPoints()
	block.MedalIcon:SetPoint("TOPLEFT", block, 20, -10)

	block.WaveLabel:ClearAllPoints()
	block.WaveLabel:SetPoint("LEFT", block.MedalIcon, "RIGHT", 3, 0)

	block.BG:SetSize(otfwidth + 21, 75)

	block.GoldCurlies:ClearAllPoints()
	block.GoldCurlies:SetPoint("TOPLEFT", block.BG, 6, -6)
	block.GoldCurlies:SetPoint("BOTTOMRIGHT", block.BG, -6, 6)

	anim.BGAnim:SetSize(otfwidth + 21, 75)
	anim.BorderAnim:SetSize(otfwidth + 21, 75)
	anim.BorderAnim:ClearAllPoints()
	anim.BorderAnim:SetPoint("TOPLEFT", block.BG, 8, -8)
	anim.BorderAnim:SetPoint("BOTTOMRIGHT", block.BG, -8, 8)

	sb:SetStatusBarTexture(C["media"].normTex)
	sb:SetStatusBarColor(0/255, 155/255, 90/255)
	sb:ClearAllPoints()
	sb:SetPoint("TOPLEFT", block.MedalIcon, "BOTTOMLEFT", -4, -5)
end

--[[auto-quest pop ups for 6.0]]--
local function alterAQButton()
	local pop = GetNumAutoQuestPopUps()
	for i = 1, pop do
		local questID, popUpType = GetAutoQuestPopUp(i)
		local questTitle = GetQuestLogTitle(GetQuestLogIndexByID(questID))

		if questTitle and questTitle~="" then
			local block = AUTO_QUEST_POPUP_TRACKER_MODULE:GetBlock(questID)
			if block then
				local blockframe = block.ScrollChild

				local aqf = CreateFrame("Frame", nil, blockframe)
				aqf:SetPoint("TOPLEFT", blockframe, -1, 1)
				aqf:SetPoint("BOTTOMRIGHT", blockframe, -1, 1)
				aqf:SetFrameStrata("DIALOG")
				blockframe.aqf = aqf
				if popUpType=="COMPLETE" then
					blockframe.QuestIconBg:ClearAllPoints()
					blockframe.QuestIconBg:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.QuestIconBg:SetParent(blockframe.aqf)
					blockframe.QuestIconBg:SetDrawLayer("OVERLAY", 4)
					blockframe.QuestionMark:ClearAllPoints()
					blockframe.QuestionMark:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.QuestionMark:SetParent(blockframe.aqf)
					blockframe.QuestionMark:SetDrawLayer("OVERLAY", 7)
				elseif popUpType=="OFFER" then
					blockframe.QuestIconBg:ClearAllPoints()
					blockframe.QuestIconBg:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.QuestIconBg:SetParent(blockframe.aqf)
					blockframe.QuestIconBg:SetDrawLayer("OVERLAY", 4)
					blockframe.Exclamation:ClearAllPoints()
					blockframe.Exclamation:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.Exclamation:SetParent(blockframe.aqf)
					blockframe.Exclamation:SetDrawLayer("OVERLAY", 7)
				end
			end
		end
	end
end

--function otf:WOWHead_Quest()
	hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
		local _, b, i, info, questID
		b = self.activeFrame
		i = b.questLogIndex
		_, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
		info = UIDropDownMenu_CreateInfo()
		info.text = lST .. "-Link"
		info.func = function(id)
			local inputBox = StaticPopup_Show("WATCHFRAME_URL")
			inputBox.editBox:SetText(lQ:format(questID))
			inputBox.editBox:HighlightText()
		end
		info.arg1 = questID
		info.noClickSound = 1
		info.checked = false
		UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
	end)
--end

--function otf:WOWHead_Achievement()
	hooksecurefunc("AchievementObjectiveTracker_OnOpenDropDown", function(self)
		local _, b, i, info
		b = self.activeFrame
		i = b.id
		info = UIDropDownMenu_CreateInfo()
		info.text = lST .. "-Link"
		info.func = function(_, i)
			local inputBox = StaticPopup_Show("WATCHFRAME_URL")
			inputBox.editBox:SetText(lA:format(i))
			inputBox.editBox:HighlightText()
		end
		info.arg1 = i
		info.noClickSound = 1
		info.checked = false
		UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
	end)
--end

--[[execution]]--
local ObjFhandler = CreateFrame("Frame")
ObjFhandler:RegisterEvent("ADDON_LOADED")
ObjFhandler:RegisterEvent("PLAYER_ENTERING_WORLD")
ObjFhandler:RegisterEvent("QUEST_AUTOCOMPLETE")
ObjFhandler:RegisterEvent("QUEST_LOG_UPDATE")

ObjFhandler:SetScript("OnEvent", function(self, event, AddOn)
	if AddOn=="Blizzard_ObjectiveTracker" then alterAQButton() end
end)

if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
	hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "Update", SkinScenarioButtons)
	hooksecurefunc("ScenarioBlocksFrame_OnLoad", SkinScenarioButtons)
	hooksecurefunc("Scenario_ProvingGrounds_ShowBlock", SkinProvingGroundButtons)
	hooksecurefunc("AutoQuestPopupTracker_AddPopUp", function(questID, popUpType)
		if AddAutoQuestPopUp(questID, popUpType) then alterAQButton() end
	end)     
	hooksecurefunc(AUTO_QUEST_POPUP_TRACKER_MODULE, "Update", alterAQButton)
end