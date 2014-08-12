local D, C, L = unpack(select(2, ...))

local ObjectiveTracker = CreateFrame("Frame", "ObjectiveTracker", UIParent)
local Noop = function() end

function ObjectiveTracker:SetQuestItemButton(block)
	local Button = block.itemButton

	if (Button and not Button.IsSkinned) then
		local Icon = Button.icon

		Button:SkinButton()
		Button:StyleButton()

		Icon:SetTexCoord(.1,.9,.1,.9)
		Icon:SetInside()

		Button.isSkinned = true
	end
end

function ObjectiveTracker:UpdatePopup()
	for i = 1, GetNumAutoQuestPopUps() do
		local questID, popUpType = GetAutoQuestPopUp(i);
		local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, _ = GetQuestLogTitle(GetQuestLogIndexByID(questID));

		if ( questTitle and questTitle ~= "" ) then
			local Block = AUTO_QUEST_POPUP_TRACKER_MODULE:GetBlock(questID)
			local ScrollChild = Block.ScrollChild

			if not ScrollChild.IsSkinned then
				ScrollChild:StripTextures()
				ScrollChild:CreateBackdrop("Transparent")
				ScrollChild.backdrop:Point("TOPLEFT", ScrollChild, "TOPLEFT", 48, -2)
				ScrollChild.backdrop:Point("BOTTOMRIGHT", ScrollChild, "BOTTOMRIGHT", -1, 2)
				ScrollChild.FlashFrame.IconFlash:Kill()
				ScrollChild.IsSkinned = true
			end
		end
	end
end

function ObjectiveTracker:AddHooks()
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", self.SetQuestItemButton)
	hooksecurefunc(AUTO_QUEST_POPUP_TRACKER_MODULE, "Update", self.UpdatePopup)
end

function ObjectiveTracker:WOWHead()
	-- Quest / achievement link URLs
	local lST = "Wowhead"
	local lQ = "http://www.wowhead.com/quest=%d"
	local lA = "http://www.wowhead.com/achievement=%d"
	
	_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
		text = lST .. " link",
		button1 = OKAY,
		timeout = 0,
		whileDead = true,
		hasEditBox = true,
		editBoxWidth = 350,
		OnShow = function(self, ...) self.editBox:SetFocus() end,
		EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	}
	
	hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
		--if self.type == "QUEST" then
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
		--[[elseif self.type == "ACHIEVMENT" then
			local _, b, info, ID
			b = self.activeFrame
			ID, _, _, _, _, _, _, _, _, _ = GetAchievementInfo(block.id)
			info = UIDropDownMenu_CreateInfo()
			info.text = lST .. "-Link"
			info.func = function(ID)
				local inputBox = StaticPopup_Show("WATCHFRAME_URL")
				inputBox.editBox:SetText(lA:format(ID))
				inputBox.editBox:HighlightText()
			end
			info.arg1 = ID
			info.noClickSound = 1
			info.checked = false
			UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
		end]]--
	end)
end

function ObjectiveTracker:Enable()
	local Frame = ObjectiveTrackerFrame
	local Header = ObjectiveTrackerFrame.BlocksFrame.QuestHeader
	local Minimize = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton

	ObjectiveTracker:Size(Frame:GetWidth(), 23)
	ObjectiveTracker:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -D.screenheight / 5, -D.screenheight / 4)

	Frame:SetParent(ObjectiveTracker)
	Frame:SetPoint("TOPRIGHT")
	Frame.ClearAllPoints = Noop
	Frame.SetPoint = Noop

	for i = 1, 5 do
		local Module = ObjectiveTrackerFrame.MODULES[i]

		if Module then
			local Header = Module.Header

			Header:StripTextures()
			Header:Show()
		end
	end
	ObjectiveTracker:WOWHead()
	ObjectiveTracker:AddHooks()
end

ObjectiveTracker:RegisterEvent("PLAYER_ENTERING_WORLD")
ObjectiveTracker:SetScript("OnEvent", function(self, event, ...)
	D.Delay(1, function()
		ObjectiveTracker:Enable()
	end)
end)