local D, C, L = unpack(select(2, ...))

--[[Modified Objective Tracker from ObbleYeah - All Credits goes to him]]--
local otfheight = 525
local titlesize = 13
local otf = ObjectiveTrackerFrame
local lST = "Wowhead"
local lQ = "http://www.wowhead.com/quest=%d"
local lA = "http://www.wowhead.com/achievement=%d"
local format = string.format

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
otf.SetPoint = D.Dummy
otf:SetMovable(true)
otf:SetUserPlaced(true)
otf:SetHeight(otfheight)

local otfmove = CreateFrame("FRAME", "ObjectivetrackerMover", otf)  
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
	if IsModifiedClick() and button == "LeftButton" then
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

local function CreateQuestTag(level, questTag, frequency)
	local tag = ""
	
	if level == -1 then level = "*" else level = tostring(level) end
	
	if questTag == ELITE then
		tag = "+"
	elseif questTag == QUEST_TAG_GROUP then
		tag = "g"
	elseif questTag == QUEST_TAG_PVP then
		tag = "pvp"
	elseif questTag == QUEST_TAG_DUNGEON then
		tag = "d"
	elseif questTag == QUEST_TAG_HEROIC then
		tag = "hc"
	elseif questTag == QUEST_TAG_RAID then
		tag = "r"
	elseif questTag == QUEST_TAG_RAID10 then
		tag = "r10"
	elseif questTag == QUEST_TAG_RAID25 then
		tag = "r25"
	elseif questTag == QUEST_TAG_SCENARIO then
		tag = "s"
	elseif questTag == QUEST_TAG_ACCOUNT then
		tag = "a"
	elseif questTag == QUEST_TAG_LEGENDARY then
		tag = "leg"
	end
	
	local color = D.RGBToHex(unpack(C["media"].datatextcolor1))
	local col = GetQuestDifficultyColor(level)
	if frequency == 2 then tag = tag.."!" elseif frequency == 3 then tag = tag.."!!" end
	if tag ~= "" then tag = (color.."%s|r"):format(tag) end
	tag = ("[|cff%2x%2x%2x%s|r%s|cff%1$2x%2$2x%3$2x|r] "):format(col.r * 255, col.g * 255, col.b * 255, level, tag) 
	return tag
end

--[[Questtitle]]--
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function(self)
	for i = 1, GetNumQuestLogEntries() do
		local title, level, groupSize, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory = GetQuestLogTitle(i)
		if questID then
			local block = QUEST_TRACKER_MODULE:GetBlock(questID)
			local tagID = GetQuestTagInfo(questID)

			block.HeaderText:SetFont(STANDARD_TEXT_FONT, 11)
			block.HeaderText:SetShadowOffset(.7, -.7)
			block.HeaderText:SetShadowColor(0, 0, 0, 1)
			block.HeaderText:SetWordWrap(true)

			local heightcheck = block.HeaderText:GetNumLines()

			if heightcheck == 2 then
				local height = block:GetHeight()
				block:SetHeight(height + 16)
			end

			local oldBlockHeight = block.height
			local oldHeight = QUEST_TRACKER_MODULE:SetStringText(block.HeaderText, title, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			local newTitle = CreateQuestTag(level, tagID, frequency) .. title
			local newHeight = QUEST_TRACKER_MODULE:SetStringText(block.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
		end
	end
end)

--[[Hide header art & restyle text]]--
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

--[[Dashes to dots]]--
hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block, objectiveKey, _, lineType)
	local line = self:GetLine(block, objectiveKey, lineType)
	if line.Dash and line.Dash:IsShown() then line.Dash:SetText("• ") end
end)

--[[Timer bars]]--
hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", function(self, block, line, duration, startTime)
	local tb = self.usedTimerBars[block] and self.usedTimerBars[block][line]
	if tb and tb:IsShown() and not tb.skinned then
		tb.Bar:SetStatusBarTexture(C["media"].normTex)
		tb.Bar:SetStatusBarColor(255/255, 108/255, 0/255)
		tb.skinned = true
	end
end)

--[[Skinning scenario buttons]]--
local function SkinScenarioButtons()
	local block = ScenarioStageBlock
	local _, currentStage, numStages, flags = C_Scenario.GetInfo()

	block:StripTextures()
	block.NormalBG:SetSize(otf:GetWidth(), 50)
	block.FinalBG:ClearAllPoints()
	block.FinalBG:SetPoint("TOPLEFT", block.NormalBG, 6, -6)
	block.FinalBG:SetPoint("BOTTOMRIGHT", block.NormalBG, -6, 6)
	block.GlowTexture:SetSize(otf:GetWidth(), 50)
end

--[[Skinning proving grounds]]--
local function SkinProvingGroundButtons()
	local block = ScenarioProvingGroundsBlock
	local sb = block.StatusBar
	local anim = ScenarioProvingGroundsBlockAnim

	block:StripTextures()
	block.MedalIcon:SetSize(32, 32)
	block.MedalIcon:ClearAllPoints()
	block.MedalIcon:SetPoint("TOPLEFT", block, 20, -10)

	block.WaveLabel:ClearAllPoints()
	block.WaveLabel:SetPoint("LEFT", block.MedalIcon, "RIGHT", 3, 0)

	block.BG:SetSize(otf:GetWidth(), 50)

	block.GoldCurlies:ClearAllPoints()
	block.GoldCurlies:SetPoint("TOPLEFT", block.BG, 6, -6)
	block.GoldCurlies:SetPoint("BOTTOMRIGHT", block.BG, -6, 6)

	anim.BGAnim:SetSize(otf:GetWidth(), 50)
	anim.BorderAnim:SetSize(otf:GetWidth(), 50)
	anim.BorderAnim:ClearAllPoints()
	anim.BorderAnim:SetPoint("TOPLEFT", block.BG, 8, -8)
	anim.BorderAnim:SetPoint("BOTTOMRIGHT", block.BG, -8, 8)

	sb:SetStatusBarTexture(C["media"].normTex)
	sb:SetStatusBarColor(0/255, 155/255, 90/255)
	sb:ClearAllPoints()
	sb:SetPoint("TOPLEFT", block.MedalIcon, "BOTTOMLEFT", -4, -5)
end

--[[Auto-quest pop ups for 6.0]]--
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
				if popUpType == "COMPLETE" then
					blockframe.QuestIconBg:ClearAllPoints()
					blockframe.QuestIconBg:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.QuestIconBg:SetParent(blockframe.aqf)
					blockframe.QuestIconBg:SetDrawLayer("OVERLAY", 4)
					blockframe.QuestionMark:ClearAllPoints()
					blockframe.QuestionMark:SetPoint("CENTER", blockframe.aqf, "LEFT", 35, -2)
					blockframe.QuestionMark:SetParent(blockframe.aqf)
					blockframe.QuestionMark:SetDrawLayer("OVERLAY", 7)
				elseif popUpType == "OFFER" then
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

--[[Generating WOWHead-Link]]
hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
	local _, b, i, info, questID
	b = self.activeFrame
	questID = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = lST .. "-Link"
	info.func = function(id)
		local inputBox = StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(lQ:format(questID))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = questID
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

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
	info.isNotRadio = true
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

--[[Execution]]--
local ObjFhandler = CreateFrame("Frame")
ObjFhandler:RegisterEvent("PLAYER_ENTERING_WORLD")

ObjFhandler:SetScript("OnEvent", function(self, event, AddOn)
	if AddOn == "Blizzard_ObjectiveTracker" then alterAQButton() end
end)

if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
	hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "Update", SkinScenarioButtons)
	hooksecurefunc("ScenarioBlocksFrame_OnLoad", SkinScenarioButtons)
	hooksecurefunc("Scenario_ProvingGrounds_ShowBlock", SkinProvingGroundButtons)
	hooksecurefunc("AutoQuestPopupTracker_AddPopUp", function(questID, popUpType)
		if AddAutoQuestPopUp(questID, popUpType) then alterAQButton() end
	end)
end