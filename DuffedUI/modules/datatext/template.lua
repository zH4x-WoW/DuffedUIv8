local D, C, L = select(2, ...):unpack()

-- Standard local values
local DataText = D["DataTexts"]
local format = format

-- This function updates the text values.
-- Note: This function is called via handlers, or when data text color is changed.
local Update = function(self)
	local Value = 1
	
	self.Text:SetText(format("%s: %s", "Data Name", Value))
end

-- This function creates the text object if it doesn't already exist, registers events/handlers, and calls an update immediately to set text value.
-- Note: This function is called when the data text is chosen to be placed in the UI.
local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end

	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:Update()
end

-- This function clears the text, and unregisters events/handlers.
-- Note: This function is called when the data text is removed from or replaced by the UI.
local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnEvent", nil)
	self:UnregisterAllEvents()
end

-- Here we register the new data text with the core, "Name" is the name that will show in the menu in game,
-- Followed by the Enable, Disable, and Update function. These are not optional.
DataText:Register("Template", Enable, Disable, Update)