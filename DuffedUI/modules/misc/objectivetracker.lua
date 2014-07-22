local D, C, L = select(2, ...):unpack()

local Miscellaneous = D["Miscellaneous"]
local ObjectiveTracker = CreateFrame("Frame", nil, UIParent)
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
				ScrollChild.Backdrop:Point("TOPLEFT", ScrollChild, "TOPLEFT", 48, -2)
				ScrollChild.Backdrop:Point("BOTTOMRIGHT", ScrollChild, "BOTTOMRIGHT", -1, 2)
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

function ObjectiveTracker:Enable()
	local Frame = ObjectiveTrackerFrame
	local Header = ObjectiveTrackerFrame.BlocksFrame.QuestHeader
	local Minimize = ObjectiveTrackerFrame.HeaderMenu.MinimizeButton

	ObjectiveTracker:Size(Frame:GetWidth(), 23)
	ObjectiveTracker:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -D.ScreenHeight / 5, -D.ScreenHeight / 4)

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
	
	ObjectiveTracker:AddHooks()
end

Miscellaneous.ObjectiveTracker = ObjectiveTracker