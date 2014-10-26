local D, C, L = unpack(select(2, ...))
--[[Slash Commands]]--
local Split = function(cmd)
	if cmd:find("%s") then
		return strsplit(" ", strlower(cmd))
	else
		return cmd
	end
end

--[[ReloadUI]]--
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

--[[Disband Party / Raid]]--
local function DisbandRaidGroup()
	if InCombatLockdown() then return end

	if UnitInRaid("player") then
		SendChatMessage(ERR_GROUP_DISBANDED, "RAID")
		for i = 1, GetNumGroupMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= D.MyName then UninviteUnit(name) end
		end
	else
		SendChatMessage(ERR_GROUP_DISBANDED, "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetNumGroupMembers(i) then UninviteUnit(UnitName("party"..i)) end
		end
	end
	LeaveParty()
end

D.CreatePopup["DUFFEDUIDISBAND_RAID"] = {
	question = L["group"]["disband"],
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = DisbandRaidGroup,
}

SlashCmdList["GROUPDISBAND"] = function()
	local instanceType = select(2, IsInInstance())

	if instanceType == "pvp" or instanceType == "arena" then return end
	if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then D.ShowPopup("DUFFEDUIDISBAND_RAID") end
end
SLASH_GROUPDISBAND1 = "/gd"
SLASH_GROUPDISBAND2 = "/rd"

--[[Layout-Switch]]--
local myPlayerName = D.MyName
local myPlayerRealm = D.MyRealm
local function SetValue(group, option, value)
	local mergesettings
	if DuffedUIConfigPrivate == DuffedUIConfigPublic then mergesettings = true else mergesettings = false end

	if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then
		if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
		if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
		DuffedUIConfigPrivate[group][option] = value
	else
		if mergesettings == true then
			if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
			if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
			DuffedUIConfigPrivate[group][option] = value
		end
		if not DuffedUIConfigPublic then DuffedUIConfigPublic = {} end
		if not DuffedUIConfigPublic[group] then DuffedUIConfigPublic[group] = {} end
		DuffedUIConfigPublic[group][option] = value
	end
end

local function RaidLayout(cmd)
	if InCombatLockdown() then return end
	local arg1 = Split(cmd)

	if C["raid"].layout == "dps" then
		SetValue("raid", "layout", "heal")
		ReloadUI()
	else
		SetValue("raid", "layout", "dps")
		ReloadUI()
	end
end
SLASH_RAIDLAYOUT1 = "/switch"
SlashCmdList["RAIDLAYOUT"] = RaidLayout