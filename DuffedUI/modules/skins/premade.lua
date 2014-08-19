local D, C, L = unpack(select(2, ...))

local function LoadPremadeSkin()
	-- global
	LFGListFrame.CategorySelection.Inset:StripTextures()
	LFGListFrame.CategorySelection.StartGroupButton:StripTextures()
	LFGListFrame.CategorySelection.StartGroupButton:SkinButton()
	LFGListFrame.CategorySelection.FindGroupButton:StripTextures()
	LFGListFrame.CategorySelection.FindGroupButton:SkinButton()

	-- create
	LFGListFrame.EntryCreation.Inset:StripTextures()
	LFGListEntryCreationCategoryDropDown:SkinDropDownBoxLong()
	LFGListEntryCreationGroupDropDown:SkinDropDownBox()
	LFGListEntryCreationActivityDropDown:SkinDropDownBox()
	LFGListFrame.EntryCreation.ItemLevel.CheckButton:SkinCheckBox()
	LFGListFrame.EntryCreation.VoiceChat.CheckButton:SkinCheckBox()
	LFGListEntryCreationDescription:StripTextures()
	LFGListEntryCreationDescription:SkinEditBox()
	LFGListFrame.EntryCreation.CancelButton:StripTextures()
	LFGListFrame.EntryCreation.CancelButton:SkinButton()
	LFGListFrame.EntryCreation.ListGroupButton:StripTextures()
	LFGListFrame.EntryCreation.ListGroupButton:SkinButton()

	-- search
	LFGListFrame.SearchPanel.ResultsInset:StripTextures()
	LFGListFrame.SearchPanel.ResultsInset:SetTemplate()
	LFGListFrame.SearchPanel.RefreshButton:SkinButton()
	LFGListSearchPanelScrollFrame:StripTextures()
	LFGListSearchPanelScrollFrameScrollBar:SkinScrollBar()
	LFGListFrame.SearchPanel.BackButton:StripTextures()
	LFGListFrame.SearchPanel.BackButton:SkinButton()
	LFGListFrame.SearchPanel.BackButton:ClearAllPoints()
	LFGListFrame.SearchPanel.BackButton:Point("TOPLEFT", LFGListFrame.SearchPanel.ResultsInset, "BOTTOMLEFT", 0, -2)
	LFGListFrame.SearchPanel.SignUpButton:StripTextures()
	LFGListFrame.SearchPanel.SignUpButton:SkinButton()
	LFGListFrame.SearchPanel.SignUpButton:ClearAllPoints()
	LFGListFrame.SearchPanel.SignUpButton:Point("TOPRIGHT", LFGListFrame.SearchPanel.ResultsInset, "BOTTOMRIGHT", 0, -2)
end

tinsert(D.SkinFuncs["DuffedUI"], LoadPremadeSkin)