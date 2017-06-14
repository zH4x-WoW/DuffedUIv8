local AS = unpack(AddOnSkins)

function AS:Blizzard_Others()
	local function SkinNavBarButtons(self)
		local navButton = self.navList[#self.navList]
		if navButton and not navButton.isSkinned then
			AS:SkinButton(navButton, true)
			if navButton.MenuArrowButton then
				AS:SkinNextPrevButton(navButton.MenuArrowButton, true)
			end

			navButton.isSkinned = true
		end
	end
	hooksecurefunc("NavBar_AddButton", SkinNavBarButtons)

	--LFD Role Picker frame
	AS:StripTextures(LFDRoleCheckPopup)
	AS:SetTemplate(LFDRoleCheckPopup, 'Default')
	AS:SkinButton(LFDRoleCheckPopupAcceptButton)
	AS:SkinButton(LFDRoleCheckPopupDeclineButton)
	AS:SkinCheckBox(LFDRoleCheckPopupRoleButtonTank:GetChildren())
	AS:SkinCheckBox(LFDRoleCheckPopupRoleButtonDPS:GetChildren())
	AS:SkinCheckBox(LFDRoleCheckPopupRoleButtonHealer:GetChildren())
	LFDRoleCheckPopupRoleButtonTank:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonTank:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonDPS:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonDPS:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonHealer:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonHealer:GetChildren():GetFrameLevel() + 1)

	-- Cinematic Popup
	AS:SetTemplate(CinematicFrameCloseDialog)
	CinematicFrameCloseDialog:SetScale(UIParent:GetScale())
	AS:SkinButton(CinematicFrameCloseDialogConfirmButton)
	AS:SkinButton(CinematicFrameCloseDialogResumeButton)

	-- Movie Frame Popup
	AS:SetTemplate(MovieFrame.CloseDialog)
	MovieFrame.CloseDialog:SetScale(UIParent:GetScale())
	AS:SkinButton(MovieFrame.CloseDialog.ConfirmButton)
	AS:SkinButton(MovieFrame.CloseDialog.ResumeButton)

	-- Report Cheats
	AS:StripTextures(ReportCheatingDialog)
	AS:SetTemplate(ReportCheatingDialog)
	AS:SkinButton(ReportCheatingDialogReportButton)
	AS:SkinButton(ReportCheatingDialogCancelButton)
	AS:StripTextures(ReportCheatingDialogCommentFrame)
	AS:SkinEditBox(ReportCheatingDialogCommentFrameEditBox)
	
	-- Report Name
	AS:StripTextures(ReportPlayerNameDialog)
	AS:SetTemplate(ReportPlayerNameDialog)
	AS:SkinButton(ReportPlayerNameDialogReportButton)
	AS:SkinButton(ReportPlayerNameDialogCancelButton)
	AS:StripTextures(ReportPlayerNameDialogCommentFrame)
	AS:SkinEditBox(ReportPlayerNameDialogCommentFrameEditBox)
	
	AS:SetTemplate(_G["GeneralDockManagerOverflowButtonList"])

	AS:SetTemplate(RolePollPopup, 'Default')
	AS:SkinCloseButton(RolePollPopupCloseButton)
	
	--[[AS:StripTextures(BasicScriptErrors)
	AS:SetTemplate(BasicScriptErrors)
	AS:SkinButton(BasicScriptErrorsButton)
	BasicScriptErrors:SetScale(AS.UIScale)]]--
end

AS:RegisterSkin('Blizzard_Others', AS.Blizzard_Others)