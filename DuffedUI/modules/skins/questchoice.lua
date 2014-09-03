local D, C, L = unpack(select(2, ...))

local function QuestChoiceSkin()
	QuestChoiceFrame:StripTextures()
	QuestChoiceFrame:SetTemplate("Transparent")
	QuestChoiceFrame.CloseButton:SkinCloseButton()

	local _, _, numOptions = GetQuestChoiceInfo()
	local function Options()
		for i = 1, numOptions do
			local optID, buttonText, description, artFile = GetQuestChoiceOptionInfo(i)
			local option = QuestChoiceFrame["Option"..i]

			option.optID = optID
			option.OptionText:SetTextColor(1, 1, 1)
			option.OptionButton:SkinButton()
		end
	end
	hooksecurefunc("QuestChoiceFrame_Update", Options)
end

D.SkinFuncs["Blizzard_QuestChoice"] = QuestChoiceSkin