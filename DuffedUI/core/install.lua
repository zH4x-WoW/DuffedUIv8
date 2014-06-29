local D, C, L = select(2, ...):unpack()

local Install = CreateFrame("Frame", nil, UIParent)
Install.MaxStepNumber = 4
Install.CurrentStep = 0
Install.Width = 500
Install.Height = 150

function Install:Requirement()
	local ActionBars = C["actionbars"].Enable
	local Chat = D["Chat"]
	local IsInstalled = DuffedUIDataPerChar.InstallDone

	if ActionBars then
		SetActionBarToggles(1, 1, 1, 1)
	end
	
	if not IsInstalled and Chat then
		Chat:SetDefaultChatFramesPositions()
	end
end

function Install:Step1()
	-- CVars
	SetCVar("buffDurations", 1)
	SetCVar("consolidateBuffs", 0)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("bloatthreat", 0)
	SetCVar("bloattest", 0)
	SetCVar("showArenaEnemyFrames", 0)
	SetCVar("alwaysShowActionBars", 1)
	SetCVar("autoOpenLootHistory", 0)
	SetCVar("spamFilter", 0)
	SetCVar("violenceLevel", 5)
end

function Install:Step2()
	local Chat = D["Chat"]
	
	if (not Chat) then return end
	Chat:Install()
end

function Install:Step3()

end

function Install:Step4()

end

function Install:PrintStep(number)
	local ExecuteScript = self["Step" .. number]
	local Text = L.Install["InstallStep" .. number]
	local r, g, b = D.ColorGradient(number, self.MaxStepNumber, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
	
	if (not Text) then
		self:Hide()
		
		if (number > self.MaxStepNumber) then
			DuffedUIDataPerChar.InstallDone = true
			ReloadUI()
		end
		
		return
	end
	
	self.CurrentStep = number
	
	if (number == 0) then
		self.LeftButton.Text:SetText(L.Install.Tutorial)
		self.LeftButton:SetScript("OnClick", function() print("tuto") end)
		self.RightButton.Text:SetText(L.Install.Install)
		self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
		self.CloseButton:Show()
	else
		self.LeftButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep - 1) end)
		self.LeftButton.Text:SetText(PREVIOUS)
		self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
		
		if (number == Install.MaxStepNumber) then
			self.RightButton.Text:SetText(COMPLETE)
			self.CloseButton:Hide()
		else
			self.RightButton.Text:SetText(NEXT)
			self.CloseButton:Show()
		end
	end
	
	self.Text:SetText(Text)

	if (ExecuteScript and number < self.MaxStepNumber) then
		self.MiddleButton:Show()
		self.MiddleButton:SetScript("OnClick", ExecuteScript)
	else
		self.MiddleButton:Hide()
		self.MiddleButton:SetScript("OnClick", nil)
	end
	
	self.StatusBar:SetValue(number)
	self.StatusBar:SetStatusBarColor(r, g, b)
	self.StatusBar.Background:SetTexture(r, g, b)
end

local StyleClick = function(self)
	self.Text:SetTextColor(0, 1, 0)
	
	D.GradientFrame(self.Text, "Text", 0, 0.5, 1, 1, 1)
end

function Install:Launch()
	if (self.Description) then
		self:Show()
		return
	end
	
	local r, g, b = D.ColorGradient(0, self.MaxStepNumber, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
	
	self.Description = CreateFrame("Frame", nil, self)
	self.Description:Size(self.Width, self.Height)
	self.Description:Point("CENTER", self, "CENTER")
	self.Description:SetTemplate("Transparent")
	self.Description:CreateShadow()

	self.StatusBar = CreateFrame("StatusBar", nil, self)
	self.StatusBar:SetStatusBarTexture(C["medias"].Normal)
	self.StatusBar:Point("BOTTOM", self.Description, "TOP", 0, 8)
	self.StatusBar:Height(20)
	self.StatusBar:Width(self.Description:GetWidth() - 4)
	self.StatusBar:CreateBackdrop()
	self.StatusBar.Backdrop:CreateShadow()
	self.StatusBar:SetStatusBarColor(r, g, b)
	self.StatusBar:SetMinMaxValues(0, self.MaxStepNumber)
	self.StatusBar:SetValue(0)
	self.StatusBar.Background = self.StatusBar:CreateTexture(nil, "ARTWORK")
	self.StatusBar.Background:SetAllPoints()
	self.StatusBar.Background:SetAlpha(.15)
	self.StatusBar.Background:SetTexture(r, g, b)
	
	self.Logo = self.StatusBar:CreateTexture(nil, "OVERLAY")
	self.Logo:Size(256, 128)
	self.Logo:SetTexture(C["medias"].Logo)
	self.Logo:Point("TOP", self.Description, "TOP", -8, 88)

	self.LeftButton = CreateFrame("Button", nil, self)
	self.LeftButton:Point("TOPLEFT", self.Description, "BOTTOMLEFT", 0, -6)
	self.LeftButton:Size(128, 25)
	self.LeftButton:SetTemplate("Transparent")
	self.LeftButton:CreateShadow()
	self.LeftButton:FontString("Text", C["medias"].Font, 12)
	self.LeftButton.Text:SetPoint("CENTER")
	self.LeftButton.Text:SetText(L.Install.Tutorial)
	self.LeftButton:SetScript("OnClick", function() print("tuto") end)

	self.RightButton = CreateFrame("Button", nil, self)
	self.RightButton:Point("TOPRIGHT", self.Description, "BOTTOMRIGHT", 0, -6)
	self.RightButton:Size(128, 25)
	self.RightButton:SetTemplate("Transparent")
	self.RightButton:CreateShadow()
	self.RightButton:FontString("Text", C["medias"].Font, 12)
	self.RightButton.Text:SetPoint("CENTER")
	self.RightButton.Text:SetText(L.Install.Install)
	self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
	
	self.MiddleButton = CreateFrame("Button", nil, self)
	self.MiddleButton:Point("TOPLEFT", self.LeftButton, "TOPRIGHT", 4, 0)
	self.MiddleButton:Point("BOTTOMRIGHT", self.RightButton, "BOTTOMLEFT", -4, 0)
	self.MiddleButton:SetTemplate("Transparent")
	self.MiddleButton:CreateShadow()
	self.MiddleButton:FontString("Text", C["medias"].Font, 12)
	self.MiddleButton.Text:SetPoint("CENTER")
	self.MiddleButton.Text:SetText(APPLY)
	self.MiddleButton:Hide()
	
	self.MiddleButton:SetScript("OnMouseUp", StyleClick)
	
	self.CloseButton = CreateFrame("Button", nil, self)
	self.CloseButton:Point("TOPRIGHT", self.Description, "TOPRIGHT", -6, -12)
	self.CloseButton:Size(12)
	self.CloseButton:FontString("Text", C["medias"].Font, 12)
	self.CloseButton.Text:SetPoint("CENTER")
	self.CloseButton.Text:SetText("X")
	self.CloseButton:SetScript("OnClick", function() self:Hide() end)

	self.Text = self.Description:CreateFontString(nil, "OVERLAY")
	self.Text:Size(self.Description:GetWidth() - 40, self.Description:GetHeight() - 60)
	self.Text:SetJustifyH("LEFT")
	self.Text:SetJustifyV("TOP")
	self.Text:SetFont(C["medias"].Font, 12)
	self.Text:SetPoint("TOPLEFT", 20, -40)
	self.Text:SetText(L.Install.InstallStep0)
	
	self:SetAllPoints(UIParent)
	self:Requirement() 
end

Install:RegisterEvent("ADDON_LOADED")
Install:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then
		return
	end

	if (not DuffedUIDataPerChar) then
		DuffedUIDataPerChar = {}
	end
	
	local IsInstalled = DuffedUIDataPerChar.InstallDone
	
	if (not IsInstalled) then
		self:Launch()
	end
	
	self:UnregisterAllEvents()
end)

D["Install"] = Install