local D, C, L = unpack(select(2, ...))

local ChangeLog = CreateFrame("frame")
local ChangeLogData = {
	"Changes:",
		"• Changelog added",
		"• Several Bugfixes",
		"• Update for AddOnSkins",
	"Notes:",
		"• Some skins works not properly",
		"• AddOnSkins not completly finished",
}

local ModifiedString = function(string)
	local count = string.find(string, ":")
	local newString = string
	
	if count then
		local prefix = string.sub(string, 0, count)
		local suffix = string.sub(string, count + 1)
		local subHeader = string.find(string, "•")
		
		if subHeader then newString = tostring("|cFFFFFF00".. prefix .. "|r" .. suffix) else newString = tostring("|cFF66FF00" .. prefix .. "|r" .. suffix) end
	end

	for pattern in gmatch(string, "('.*')") do newString = newString:gsub(pattern, "|cFFFF8800" .. pattern:gsub("'", "") .. "|r") end
	return newString
end

local GetChangeLogInfo = function(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

function ChangeLog:CreateChangelog()
	local frame = CreateFrame("Frame", "DuffedUIChangeLog", UIParent)
	frame:SetPoint("CENTER")
	frame:SetSize(400, 300)
	frame:SetTemplate("Transparent")
	
	local title = CreateFrame("Frame", nil, frame)
	title:SetPoint("BOTTOM", frame, "TOP", 0, 3)
	title:SetSize(400, 20)
	title:SetTemplate("Transparent")
	title.text = title:CreateFontString(nil, "OVERLAY")
	title.text:SetPoint("CENTER", title, 0, -1)
	title.text:SetFont(C["media"]["font"], 15)
	title.text:SetText("|cffC41F3BDuffedUI|r - ChangeLog " .. D["Version"])
	
	D["CreateBtn"]("close", frame, 40, 19, "Close ChangeLog", "Close")
	close:SetPoint("BOTTOMRIGHT", frame, -5, 5)
	close:SetScript("OnClick", function(self) frame:Hide() end)
	
	local textoffset = 0
	local buttonoffset = 5
	for i = 1, #ChangeLogData do
		local button = CreateFrame("Frame", "Button"..i, frame)
		button:SetSize(375, 16)
		button:SetPoint("TOPLEFT", frame, 5, -buttonoffset)
		local idx = textoffset + i
		
		if idx <= #ChangeLogData then
			local string = ModifiedString(GetChangeLogInfo(idx))
			
			button.Text = button:CreateFontString(nil, "OVERLAY")
			button.Text:SetFont(C["media"]["font"], 11)
			button.Text:SetText(string)
		end
		buttonoffset = buttonoffset + 20
	end
end

function DuffedUI_ToggleChangeLog()
	ChangeLog:CreateChangelog()
end

function ChangeLog:OnCheckVersion(self)
	if not DuffedUIData["Version"] or (DuffedUIData["Version"] and DuffedUIData["Version"] ~= D["Version"]) then
		DuffedUIData["Version"] = D["Version"]
		ChangeLog:CreateChangelog()
	end
end

ChangeLog:RegisterEvent("ADDON_LOADED")
ChangeLog:RegisterEvent("PLAYER_ENTERING_WORLD")
ChangeLog:SetScript("OnEvent", function(self, event, ...)
	ChangeLog:OnCheckVersion()
end)