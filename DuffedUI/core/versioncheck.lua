local D, C, L = select(2, ...):unpack()

local Version = tonumber(GetAddOnMetadata("DuffedUI", "Version"))
local SendAddonMessage = SendAddonMessage
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local tonumber = tonumber

local Outdated = L.Help.Outdated

local CheckVersion = function(self, event, prefix, message, channel, sender)
	if (event == "CHAT_MSG_ADDON") then
		if (prefix ~= "DuffedUIVersion") or (sender == D.MyName) then
			return
		end

		if (tonumber(message) > Version) then -- We recieved a higher version, we're outdated. :(
			print("|cffffff00"..Outdated.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		-- Tell everyone what version we use.
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