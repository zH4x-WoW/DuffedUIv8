local D, C, L = unpack(select(2, ...))

local ChangeLog = CreateFrame("frame")
local ChangeLogData = {
	"Changes:",
		"• Update SpellID's",
		"• Update AddOnSkins",
		"• Fixed a issue with flash info for low mana",
		"• Fixed a issue with corner buffs and Prayer of Mending",
		"• Attempt to fix arena preperation frame",
		"• Functions are removed which no longer needed",
		"• Raid-Debuffs from WoD removed (no longer needed)",
		"• Added Bugreport-button to changelog and specswitcher buttons",
		--"• ",
	" ",
	"Notes:",
		"• New Bagscript isn't finished yet.",
		"• LAST UPDATE BEFORE LEVELPHASE, ONLY GAMEBREAKING ISSUES WILL BE FIXED\n DURING LEVELPHASE!"
}

local function ModifiedString(string)
	local count = string.find(string, ":")
	local newString = string
	
	if count then
		local prefix = string.sub(string, 0, count)
		local suffix = string.sub(string, count + 1)
		local subHeader = string.find(string, "•")
		
		if subHeader then newString = tostring("|cFFFFFF00".. prefix .. "|r" .. suffix) else newString = tostring("|cffC41F3B" .. prefix .. "|r" .. suffix) end
	end

	for pattern in gmatch(string, "('.*')") do newString = newString:gsub(pattern, "|cFFFF8800" .. pattern:gsub("'", "") .. "|r") end
	return newString
end

local function GetChangeLogInfo(i)
	for line, info in pairs(ChangeLogData) do
		if line == i then return info end
	end
end

_G.StaticPopupDialogs["BUGREPORT"] = {
	text = "Bugreporting for DuffedUI",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("http://www.wowinterface.com/portal.php?id=826&a=listbugs")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

function ChangeLog:CreateChangelog()
	local frame = CreateFrame("Frame", "DuffedUIChangeLog", UIParent)
	frame:SetPoint("CENTER")
	frame:SetSize(445, 245)
	frame:SetTemplate("Transparent")
	
	local icon = CreateFrame("Frame", nil, frame)
	icon:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 3)
	icon:SetSize(20, 20)
	icon:SetTemplate("Transparent")
	icon.bg = icon:CreateTexture(nil, "ARTWORK")
	icon.bg:Point("TOPLEFT", 2, -2)
	icon.bg:Point("BOTTOMRIGHT", -2, 2)
	icon.bg:SetTexture(C["media"].duffed)
	
	local title = CreateFrame("Frame", nil, frame)
	title:SetPoint("LEFT", icon, "RIGHT", 3, 0)
	title:SetSize(422, 20)
	title:SetTemplate("Transparent")
	title.text = title:CreateFontString(nil, "OVERLAY")
	title.text:SetPoint("CENTER", title, 0, -1)
	title.text:SetFont(C["media"]["font"], 15)
	title.text:SetText("|cffC41F3BDuffedUI|r - ChangeLog " .. D["Version"])
	
	D["CreateBtn"]("close", frame, 65, 19, L["tooltip"]["changelog"], L["buttons"]["close"])
	close:SetPoint("BOTTOMRIGHT", frame, -5, 5)
	close:SetScript("OnClick", function(self) frame:Hide() end)
	
	D["CreateBtn"]("bReport", frame, 65, 19, "Bugreport", "Bugreport")
	bReport:SetPoint("BOTTOMLEFT", frame, 5, 5)
	bReport:SetScript("OnClick", function(self) StaticPopup_Show("BUGREPORT") end)
	
	local offset = 4
	for i = 1, #ChangeLogData do
		local button = CreateFrame("Frame", "Button"..i, frame)
		button:SetSize(375, 16)
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -offset)
		
		if i <= #ChangeLogData then
			local string = ModifiedString(GetChangeLogInfo(i))
			
			button.Text = button:CreateFontString(nil, "OVERLAY")
			button.Text:SetFont(C["media"]["font"], 11)
			button.Text:SetText(string)
			button.Text:SetPoint("LEFT", 0, 0)
		end
		offset = offset + 16
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