local D, C, L = unpack(select(2, ...)) 
if C["chat"].enable ~= true then return end

local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreateCopyFrame()
	frame = CreateFrame("Frame", "DuffedUIChatCopyFrame", UIParent)
	frame:SetTemplate("Transparent")
	frame:Width(600)
	frame:Height(700)
	frame:SetScale(1)
	frame:Point("BOTTOM", UIParent, "BOTTOM", 0, 10)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "DuffedUIChatCopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:Point("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "DuffedUIChatCopyEditBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:Width((DuffedUIBar1:GetWidth() * 2) + 20)
	editBox:Height(250)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	close:SkinCloseButton()
	DuffedUIChatCopyScrollScrollBar:SkinScrollBar()
	isf = true
end

local function GetLines(...)
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, .01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreateCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

for i = 1, NUM_CHAT_WINDOWS do
	local cf = _G[format("ChatFrame%d",  i)]
	local button = CreateFrame("Button", format("DuffedUIButtonCF%d", i), cf)
	button:Height(20)
	button:Width(20)
	button:SetNormalTexture(C["media"].copyicon)
	button:SetTemplate("Default")

	button:SetScript("OnMouseUp", function(self) Copy(cf) end)
end

if C["chat"].lbackground then
	DuffedUIButtonCF1:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
	DuffedUIButtonCF2:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
	DuffedUIButtonCF3:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
else
	DuffedUIButtonCF1:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
	DuffedUIButtonCF2:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
	DuffedUIButtonCF3:SetPoint("LEFT", DuffedUIChatMenu, "RIGHT", 2, 0)
	D["ButtonMO"](DuffedUIButtonCF1)
	D["ButtonMO"](DuffedUIButtonCF2)
	D["ButtonMO"](DuffedUIButtonCF3)
end

if C["chat"].rbackground then
	DuffedUIButtonCF4:SetPoint("TOPRIGHT", DuffedUIChatBackgroundRight, "TOPRIGHT", -4, -4)
else
	DuffedUIButtonCF4:SetPoint("TOPRIGHT", ChatFrame4, "TOPRIGHT", -4, 20)
	D["ButtonMO"](DuffedUIButtonCF4)
end

for i = 1, NUM_CHAT_WINDOWS do
	local editbox = _G["ChatFrame"..i.."EditBox"]
	editbox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		local new, found = gsub(text, "|Kf(%S+)|k(%S+)%s(%S+)k:%s", "%2 %3: ")

		if found > 0 then
			new = new:gsub('|', '')
			self:SetText(new)
		end
	end)
end