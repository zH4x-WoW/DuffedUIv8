local D, C, L = select(2, ...):unpack()

local Popups = D["Popups"]

local Split = function(cmd)
	if cmd:find("%s") then
		return strsplit(" ", strlower(cmd))
	else
		return cmd
	end
end

D.SlashHandler = function(cmd)
	local arg1, arg2 = Split(cmd)

	if (arg1 == "dt" or arg1 == "datatext") then
		local DataText = D["DataTexts"]
		
		if arg2 then
			if (arg2 == "reset") then
				DataText:Reset()
			elseif (arg2 == "resetgold") then
				DataText:ResetGold()
			end
		else
			DataText:ToggleDataPositions()
		end
	elseif (arg1 == "install" or arg1 == "reset") then
		local Install = D["Install"]
		
		Install:Launch()
	elseif (arg1 == "" or arg1 == "help") then
		print(" ")
		print("|cffC41F3B".. L.Help.Title .."|r")
		print(L.Help.Install)
		print(L.Help.Datatexts)
		print(L.Help.Config)
		print(" ")
	elseif (arg1 == "config") then
		local Config = DuffedUIConfig
		
		if (not DuffedUIConfig) then
			D.Print(L.Help.Config)
		end
		
		if (not DuffedUIConfigFrame) then
			Config:CreateConfigWindow()
		end

		if DuffedUIConfigFrame:IsVisible() then
			DuffedUIConfigFrame:Hide()
		else
			DuffedUIConfigFrame:Show()
		end
	end
end

SLASH_DUFFEDSLASHHANDLER1 = "/duffed"
SlashCmdList["DUFFEDSLASHHANDLER"] = D.SlashHandler

local TestUI = function(msg)
	if not DuffedUI[2].unitframes.Enable then return end
	if msg == "" then msg = "all" end
	
    if msg == "all" or msg == "arena" or msg == "a" then
		for i = 1, 3 do
			_G["oUF_DuffedUIArena"..i]:Show(); _G["oUF_DuffedUIArena"..i].Hide = function() end; _G["oUF_DuffedUIArena"..i].unit = "player"
			_G["oUF_DuffedUIArena"..i].Trinket.Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_37")
		end
	end
	
    if msg == "all" or msg == "boss" or msg == "b" then
		for i = 1, 3 do
			_G["oUF_DuffedUIBoss"..i]:Show(); _G["oUF_DuffedUIBoss"..i].Hide = function() end; _G["oUF_DuffedUIBoss"..i].unit = "player"
		end
	end
	
	if msg == "all" or msg == "pet" or msg == "p" then
		oUF_DuffedUIPet:Show(); oUF_DuffedUIPet.Hide = function() end; oUF_DuffedUIPet.unit = "player"
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

-- disband party/raid
local function DisbandRaidGroup()
	if InCombatLockdown() then return end
	
	if UnitInRaid("player") then
		SendChatMessage(ERR_GROUP_DISBANDED, "RAID")
		for i = 1, GetNumGroupMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= D.myname then
				UninviteUnit(name)
			end
		end
	else
		SendChatMessage(ERR_GROUP_DISBANDED, "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if GetNumGroupMembers(i) then
				UninviteUnit(UnitName("party"..i))
			end
		end
	end
	LeaveParty()
end

Popups.Popup["DUFFEDUIDISBAND_RAID"] = {
	question = L.Disband.Text,
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = DisbandRaidGroup,
}