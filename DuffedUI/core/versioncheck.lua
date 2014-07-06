local D, C, L = select(2, ...):unpack()

local Version = tonumber(GetAddOnMetadata("DuffedUI", "Version"))
local SendAddonMessage = SendAddonMessage
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local tonumber = tonumber

local Outdated = L.Help.Outdated

local CheckVersion = function(self, eversionent, prefix, message, channel, sender)
	if (eversionent == "CHAT_MSG_ADDON") then
		if (prefix ~= "DuffedUIVersion") or (sender == D.MyName) then
			return
		end

		if (tonumber(message) > Version) then -- We recieversioned a higher versionersion, we're outdated. :(
			print("|cffffff00"..Outdated.."|r")
			self:UnregisterEversionent("CHAT_MSG_ADDON")
		end
	else
		-- Tell eversioneryone what versionersion we use.
		if (not IsInGroup(LE_PARTY_CATEGORY_HOME)) or (not IsInRaid(LE_PARTY_CATEGORY_HOME)) then
			SendAddonMessage("DuffedUIVersion", Version, "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("DuffedUIVersion", Version, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("DuffedUIVersion", Version, "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("DuffedUIVersion", Version, "GUILD")
		end
	end
end

local DuffedUIVersion = CreateFrame("Frame")
DuffedUIVersion:RegisterEvent("PLAYER_ENTERING_WORLD")
DuffedUIVersion:RegisterEvent("GROUP_ROSTER_UPDATE")
DuffedUIVersion:RegisterEvent("CHAT_MSG_ADDON")
DuffedUIVersion:SetScript("OnEvent", CheckVersion)

RegisterAddonMessagePrefix("DuffedUIVersion")

local version = CreateFrame("Button", "DuffedUIVersionFrame", UIParent)
version:SetSize(300, 66)
version:SetPoint("CENTER")
version:SetTemplate("Transparent")
version:CreateShadow("Default")
version:FontString("text", C["medias"].Font, 20)
version:FontString("text2", C["medias"].Font, 12)
version.text:SetPoint("CENTER")
version.text:SetText("|cffC41F3BDuffedUI|r ".. D.Version .." Alpha 1")
version.text2:SetPoint("BOTTOM", 0, 2)
version.text2:SetText("by |cffC41F3BMerith - liquidbase|r, website at |cffC41F3Bwww.tukui.org|r")
version:SetScript("OnClick", function()
	version:Hide()
end)
version:Hide()

local versionicon = CreateFrame("Frame", "DuffedVersion", version)
versionicon:Size(66, 66)
versionicon:SetTemplate()
versionicon:SetPoint("RIGHT", version, "LEFT", -2, 0)
versionicon:SetFrameStrata("HIGH")
versionicon:CreateShadow("Default")

versionicon.bg = versionicon:CreateTexture(nil, "ARTWORK")
versionicon.bg:Point("TOPLEFT", 2, -2)
versionicon.bg:Point("BOTTOMRIGHT", -2, 2)
versionicon.bg:SetTexture(C["medias"].Duffed)

SLASH_VERSION1 = "/version"
SlashCmdList.VERSION = function()
	if version:IsShown() then
		version:Hide()
	else
		version:Show()
	end
end