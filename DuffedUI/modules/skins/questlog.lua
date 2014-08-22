local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	QuestLogPopupDetailFrameCloseButton:SkinCloseButton()
	QuestLogPopupDetailFrame:StripTextures()
	QuestLogPopupDetailFrame:SetTemplate("Transparent")
	QuestLogPopupDetailFrame.ShowMapButton:SkinButton()
	QuestLogPopupDetailFrameScrollFrameScrollBar:SkinScrollBar()
	QuestLogPopupDetailFrameScrollFrameTop:SetAlpha(0)
	QuestLogPopupDetailFrameScrollFrameMiddle:SetAlpha(0)
	QuestLogPopupDetailFrameScrollFrameBottom:SetAlpha(0)
	QuestLogPopupDetailFrameInset:SetAlpha(0)

	local buttons = {
		"QuestLogPopupDetailFrameAbandonButton",
		"QuestLogPopupDetailFrameShareButton",
		"QuestLogPopupDetailFrameTrackButton",
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end
	QuestLogPopupDetailFrameShareButton:Point("LEFT", QuestLogPopupDetailFrameAbandonButton, "RIGHT", 2, 0)
	QuestLogPopupDetailFrameShareButton:Point("RIGHT", QuestLogPopupDetailFrameTrackButton, "LEFT", -2, 0)

	local function QuestObjectiveText()
		local numObjectives = GetNumQuestLeaderBoards()
		local objective
		local numVisibleObjectives = 0
		for i = 1, numObjectives do
			local _, type, finished = GetQuestLogLeaderBoard(i)
			if (type ~= "spell") then
				numVisibleObjectives = numVisibleObjectives+1
				objective = _G["QuestInfoObjective"..numVisibleObjectives]
				if finished then objective:SetTextColor(1, 1, 0) else objective:SetTextColor(.6, .6, .6) end
			end
		end
	end

	hooksecurefunc("QuestInfo_ShowRequiredMoney", function()
		local requiredMoney = GetQuestLogRequiredMoney()
		if requiredMoney > 0 then
			if requiredMoney > GetMoney() then QuestInfoRequiredMoneyText:SetTextColor(.6, .6, .6) else QuestInfoRequiredMoneyText:SetTextColor(1, 1, 0) end
		end
	end)

	QuestLogPopupDetailFrame:HookScript("OnShow", function() QuestLogPopupDetailFrameScrollFrame:Height(QuestLogPopupDetailFrameScrollFrame:GetHeight() - 4) end)
	QuestLogPopupDetailFrameInset:StripTextures()
end	
tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)