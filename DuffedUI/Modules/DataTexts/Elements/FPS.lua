local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local GetNetStats = GetNetStats
local GetFramerate = GetFramerate
local format = format
local floor = floor
local select = select
local tslu = 1
local MAINMENUBAR_LATENCY_LABEL = MAINMENUBAR_LATENCY_LABEL

local Update = function(self, t)
	tslu = tslu - t
	
	if (tslu > 0) then
		return
	end
	
	local MS = select(3, GetNetStats())
	local Rate = floor(GetFramerate())
	
	if (MS == 0) then
		MS = "0"
	end

	self.Text:SetText(format("%s %s %s %s", DataText.ValueColor .. Rate .. "|r", DataText.NameColor .. L.DataText.FPS .. "|r", DataText.ValueColor .. MS .. "|r", DataText.NameColor .. L.DataText.MS .. "|r"))
	tslu = 1
end

local OnEnter = function(self)
	if InCombatLockdown() then return end
	
	local _, _, latencyHome, latencyWorld = GetNetStats()
	local latency = format(MAINMENUBAR_LATENCY_LABEL, latencyHome, latencyWorld)
	local panel, anchor, xoff, yoff = self:GetTooltipAnchor()
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(latency)
	GameTooltip:Show()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local Enable = function(self)	
	if (not self.Text) then
		local Text = self:CreateFontString(nil, "OVERLAY")
		Text:SetFont(DataText.Font, DataText.Size, DataText.Flags)
		
		self.Text = Text
	end

	self:SetScript("OnUpdate", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:Update(1)
end

local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register("FPS & MS", Enable, Disable, Update)