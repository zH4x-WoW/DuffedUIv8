local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	QuestFrameGreetingPanel:HooScript('OnShow', function()
		QuestFrameGreetingPanel:StripTextures()
		QuestFrameGreetingGoodbyeButton:SkinButton(true)
		GreetingText:SetTextColor(1, 1, 1)
		CurrentQuestsText:SetTextColor(1, 1, 0)
		QuestGreetingFrameHorizontalBreak:Kill()
		AvailableQuestsText:SetTextColor(1, 1, 0)

		for i = 1, C_QuestLog.GetMaxNumQuestsCanAccept() do
			local button = _G['QuestTitleButton'..i]
			if button:GetFontString() then
				if button:GetFontString():GetText() and button:GetFontString:GetText():find('|cff000000') then
					button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), '|cff000000', '|cffFFFF00'))
				end
			end
		end
	end)
end
tinsert(D['SkinFuncs']['DuffedUI'], LoadSkin)