local D, C, L = unpack(select(2, ...))
if C["misc"].AFKCamera ~= true then return end

local PName = UnitName("player")
local PLevel = UnitLevel("player")
local PClass = UnitClass("player")
local PRace = UnitRace("player")
local PFaction = UnitFactionGroup("player")
local color = RAID_CLASS_COLORS[D.Class]
local Version = tonumber(GetAddOnMetadata("DuffedUI", "Version"))

local PGuild
if(IsInGuild()) then PGuild = select(1, GetGuildInfo("player")) else PGuild = " " end

D.AFK_LIST = {
	L["afk"]["text1"],
	L["afk"]["text2"],
	L["afk"]["text3"],
	L["afk"]["text4"],
	L["afk"]["text5"],
	L["afk"]["text6"],
}

local DuffedUIAFKPanel = CreateFrame("Frame", "DuffedUIAFKPanel", nil)
DuffedUIAFKPanel:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -2, -2)
DuffedUIAFKPanel:SetPoint("TOPRIGHT", UIParent, "BOTTOMRIGHT", 2, 150)
DuffedUIAFKPanel:SetTemplate("Transparent")
DuffedUIAFKPanel:Hide()

local DuffedUIAFKPanelTop = CreateFrame("Frame", "DuffedUIAFKPanelTop", nil)
DuffedUIAFKPanelTop:SetPoint("TOPLEFT", UIParent, "TOPLEFT",-2, 2)
DuffedUIAFKPanelTop:SetPoint("BOTTOMRIGHT", UIParent, "TOPRIGHT", 2, -80)
DuffedUIAFKPanelTop:SetTemplate("Transparent")
DuffedUIAFKPanelTop:SetFrameStrata("FULLSCREEN")
DuffedUIAFKPanelTop:Hide()

local DuffedUIAFKPanelTopIcon = CreateFrame("Frame", "DuffedUIAFKPanelTopIcon", DuffedUIAFKPanelTop)
DuffedUIAFKPanelTopIcon:Size(48)
DuffedUIAFKPanelTopIcon:Point("CENTER", DuffedUIAFKPanelTop, "BOTTOM", 0, 0)
DuffedUIAFKPanelTopIcon:SetTemplate("Default")

DuffedUIAFKPanelTopIcon.Texture = DuffedUIAFKPanelTopIcon:CreateTexture(nil, "ARTWORK")
DuffedUIAFKPanelTopIcon.Texture:Point("TOPLEFT", 2, -2)
DuffedUIAFKPanelTopIcon.Texture:Point("BOTTOMRIGHT", -2, 2)
DuffedUIAFKPanelTopIcon.Texture:SetTexture(C["media"].duffed)

DuffedUIAFKPanelTop.DuffedUIText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.DuffedUIText:SetPoint("CENTER", DuffedUIAFKPanelTop, "CENTER", 0, 0)
DuffedUIAFKPanelTop.DuffedUIText:SetFont(C["media"].font, 40, "OUTLINE")
DuffedUIAFKPanelTop.DuffedUIText:SetText("|cffc41f3bDuffedUI " .. Version)

DuffedUIAFKPanelTop.DateText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.DateText:SetPoint("BOTTOMLEFT", DuffedUIAFKPanelTop, "BOTTOMRIGHT", -100, 44)
DuffedUIAFKPanelTop.DateText:SetFont(C["media"].font, 15, "OUTLINE")

DuffedUIAFKPanelTop.ClockText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.ClockText:SetPoint("BOTTOMLEFT", DuffedUIAFKPanelTop, "BOTTOMRIGHT", -100, 20)
DuffedUIAFKPanelTop.ClockText:SetFont(C["media"].font, 20, "OUTLINE")

DuffedUIAFKPanelTop.PlayerNameText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.PlayerNameText:SetPoint("LEFT", DuffedUIAFKPanelTop, "LEFT", 25, 15)
DuffedUIAFKPanelTop.PlayerNameText:SetFont(C["media"].font, 28, "OUTLINE")
DuffedUIAFKPanelTop.PlayerNameText:SetText(PName)
DuffedUIAFKPanelTop.PlayerNameText:SetTextColor(color.r, color.g, color.b)

DuffedUIAFKPanelTop.GuildText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.GuildText:SetPoint("LEFT", DuffedUIAFKPanelTop, "LEFT", 25, -3)
DuffedUIAFKPanelTop.GuildText:SetFont(C["media"].font, 15, "OUTLINE")
DuffedUIAFKPanelTop.GuildText:SetText("|cffc41f3b" .. PGuild .. "|r")

DuffedUIAFKPanelTop.PlayerInfoText = DuffedUIAFKPanelTop:CreateFontString(nil, "OVERLAY")
DuffedUIAFKPanelTop.PlayerInfoText:SetPoint("LEFT", DuffedUIAFKPanelTop, "LEFT", 25, -20)
DuffedUIAFKPanelTop.PlayerInfoText:SetFont(C["media"].font, 15, "OUTLINE")
DuffedUIAFKPanelTop.PlayerInfoText:SetText(LEVEL .. " " .. PLevel .. " " .. PFaction .. " " .. PClass)

local interval = 0
DuffedUIAFKPanelTop:SetScript("OnUpdate", function(self, elapsed)
	interval = interval - elapsed
	if interval <= 0 then
		DuffedUIAFKPanelTop.ClockText:SetText(format("%s", date("%H|cffc41f3b:|r%M|cffc41f3b:|r%S")))
		DuffedUIAFKPanelTop.DateText:SetText(format("%s", date("|cffc41f3b%a|r %b/%d")))
		interval = 0.5
	end
end)

local OnEvent = function(self, event, unit)
	if InCombatLockdown() then return end

	if event == "PLAYER_FLAGS_CHANGED" then
		if unit == "player" then
			if UnitIsAFK(unit) and not UnitIsDead(unit) then
				SpinStart()
				DuffedUIAFKPanel:Show()
				DuffedUIAFKPanelTop:Show()
				Minimap:Hide()
			else
				SpinStop()
				DuffedUIAFKPanel:Hide()
				DuffedUIAFKPanelTop:Hide()
				Minimap:Show()
			end
		end
	elseif event == "PLAYER_DEAD" then
		if UnitIsAFK("player") then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			DuffedUIAFKPanelTop:Hide()
			Minimap:Show()
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		if UnitIsAFK("player") then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			DuffedUIAFKPanelTop:Hide()
			Minimap:Show()
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		SpinStop()
	end
end

DuffedUIAFKPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
DuffedUIAFKPanel:RegisterEvent("PLAYER_LEAVING_WORLD")
DuffedUIAFKPanel:RegisterEvent("PLAYER_FLAGS_CHANGED")
DuffedUIAFKPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
DuffedUIAFKPanel:RegisterEvent("PLAYER_DEAD")
DuffedUIAFKPanel:SetScript("OnEvent", OnEvent)

local texts = D.AFK_LIST
local interval = #texts

local DuffedUIAFKScrollFrame = CreateFrame("ScrollingMessageFrame", "DuffedUIAFKScrollFrame", DuffedUIAFKPanel)
DuffedUIAFKScrollFrame:SetSize(DuffedUIAFKPanel:GetWidth(), DuffedUIAFKPanel:GetHeight())
DuffedUIAFKScrollFrame:SetPoint("CENTER", DuffedUIAFKPanel, "CENTER", 0, 60)
DuffedUIAFKScrollFrame:SetFont(C["media"].font, 20, "OUTLINE")
DuffedUIAFKScrollFrame:SetShadowColor(0, 0, 0, 0)
DuffedUIAFKScrollFrame:SetFading(false)
DuffedUIAFKScrollFrame:SetFadeDuration(0)
DuffedUIAFKScrollFrame:SetTimeVisible(1)
DuffedUIAFKScrollFrame:SetMaxLines(1)
DuffedUIAFKScrollFrame:SetSpacing(2)
DuffedUIAFKScrollFrame:SetScript("OnUpdate", function(self, time)
	interval = interval - (time / 30)
	for index, name in pairs(D.AFK_LIST) do
		if interval < index then
			DuffedUIAFKScrollFrame:AddMessage(D.AFK_LIST[index], 1, 1, 1)
			tremove(texts, index)
		end
	end

	if interval < 0 then self:SetScript("OnUpdate", nil) end
end)

DuffedUIAFKPanel:SetScript("OnShow", function(self) UIFrameFadeIn(UIParent, .5, 1, 0) end)
DuffedUIAFKPanel:SetScript("OnHide", function(self) UIFrameFadeOut(UIParent, .5, 0, 1) end)

function SpinStart()
	spinning = true
	MoveViewRightStart(.1)
end

function SpinStop()
	if(not spinning) then return end
	spinning = nil
	MoveViewRightStop()
end