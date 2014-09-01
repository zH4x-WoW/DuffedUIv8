local D, C, L = unpack(select(2, ..))

_G.StaticPopupDialogs["OUTDATED"] = {
	text = "http://www.duffed.net/downloads",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 350,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

local SendAddonMessage = SendAddonMessage
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local tonumber = tonumber

local version = function(self, event, prefix, message, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "DuffedUI Version" or sender == D.MyName then return end
		
		if tonumber(message > D.Version) then
			print(L["ui"]["outdated"])
			StaticPopup_Show("OUTDATED")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if (not IsInGroup(LE_PARTY_CATEGORY_HOME)) or (not IsInRaid(LE_PARTY_CATEGORY_HOME)) then
			SendAddonMessage("DuffedUI Version", Version, "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("DuffedUI Version", Version, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("DuffedUI Version", Version, "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("DuffedUI Version", Version, "GUILD")
		end
	end
end

local cversion = CreateFrame("Frame")
cversion:RegisterEvent("PLAYER_ENTERING_WORLD")
cversion:RegisterEvent("GROUP_ROSTER_UPDATE")
cversion:RegisterEvent("CHAT_MSG_ADDON")
cversion:SetScript("OnEvent", CheckVersion)

RegisterAddonMessagePrefix("DuffedUI Version")