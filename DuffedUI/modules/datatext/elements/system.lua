local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format
local floor = floor
local select = select
local int = 1
local tslu = 1
local Mult = 10^1
local MemoryTable = {}
local KilobyteString = "%d ".. DataText.ValueColor .."kb".."|r"
local MegabyteString = "%.2f ".. DataText.ValueColor .."mb".."|r"
local bandwidthString = "%.2f Mbps"
local percentageString = "%.2f%%"
local GetNetStats = GetNetStats
local GetFramerate = GetFramerate
--local MAINMENUBAR_LATENCY_LABEL = MAINMENUBAR_LATENCY_LABEL


local FormatMemory = function(memory)
	if (memory > 999) then
		local Memory = ((memory/1024) * Mult) / Mult
		return string.format(MegabyteString, Memory)
	else
		local Memory = (memory * Mult) / Mult
		return string.format(KilobyteString, Memory)
	end
end

local UpdateMemory = function()
	-- Update the memory usages of the addons
	UpdateAddOnMemoryUsage()
	local AddOnMem = 0
	local TotalMem = 0
	
	for i = 1, #MemoryTable do
		AddOnMem = GetAddOnMemoryUsage(MemoryTable[i][1])
		MemoryTable[i][3] = AddOnMem
		TotalMem = TotalMem + AddOnMem
	end
	-- Sort the table to put the largest addon on top
	table.sort(MemoryTable, function(a, b)
		if (a and b) then
			return a[3] > b[3]
		end
	end)
	
	return TotalMem
end

local RebuildAddonList = function(self)
	local AddOnCount = GetNumAddOns()
	if (AddOnCount == #MemoryTable) or self.tooltip then
		return
	end

	MemoryTable = {}
	
	for i = 1, AddOnCount do
		MemoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
	end
end

local Update = function(self, t)
	int = int - t
	if (int < 0) then
		RebuildAddonList(self)
		local Total = UpdateMemory()
		int = 10
	end
	
	tslu = tslu - t
	if (tslu > 0) then return end
	local MS = select(3, GetNetStats())
	local Rate = floor(GetFramerate())
	if (MS == 0) then MS = "0" end

	self.Text:SetText(format("%s %s %s %s", DataText.ValueColor .. Rate .. "|r", DataText.NameColor .. L.DataText.FPS .. "|r", DataText.ValueColor .. MS .. "|r", DataText.NameColor .. L.DataText.MS .. "|r"))
	tslu = 1
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		
		local TotalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine(L.DataText.TotalMemory, FormatMemory(TotalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		for i = 1, #MemoryTable do
			if (MemoryTable[i][4]) then
				local Red = MemoryTable[i][3] / TotalMemory
				local Green = 1 - Red
				
				GameTooltip:AddDoubleLine(MemoryTable[i][2], FormatMemory(MemoryTable[i][3]), 1, 1, 1, Red, Green + .5, 0)
			end						
		end
		GameTooltip:AddLine(" ")
		
		local Bandwidth = GetAvailableBandwidth()
		if (Bandwidth ~= 0) then
			GameTooltip:AddDoubleLine(L.DataText.Bandwidth , string.format(bandwidthString, Bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine(L.DataText.Download , string.format(percentageString, GetDownloadedPercentage() * 100), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		end
		GameTooltip:AddLine(" ")
		
		local BW_In, BW_Out, HomeLatency, WorldLatency = GetNetStats()
		local Latency = HomeLatency + WorldLatency
		GameTooltip:AddDoubleLine(L.DataText.Home, HomeLatency .." ".. MILLISECONDS_ABBR, 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine(L.DataText.World, WorldLatency .." ".. MILLISECONDS_ABBR, 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine(L.DataText.Global, Latency .." ".. MILLISECONDS_ABBR, 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L.DataText.Inc, string.format( "%.4f", BW_In ) .. " kb/s", 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine(L.DataText.Out, string.format( "%.4f", BW_Out ) .. " kb/s", 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		
		GameTooltip:Show()
	end
end

local OnLeave = function() GameTooltip:Hide() end

local OnMouseUp = function(self, btn)
	if (btn == "LeftButton") then
		if not PVPUIFrame then
			PVP_LoadUI()
		end
		ToggleFrame(PVPUIFrame)
	else
		collectgarbage("collect")
	end
end

local Enable = function(self)	
	self:SetScript("OnUpdate", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:Update(1)
end

local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)
end
DataText:Register("System", Enable, Disable, Update)