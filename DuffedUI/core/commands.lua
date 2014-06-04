local D, C, L = select(2, ...):unpack()

local strlower = strlower

local Split = function(cmd)
	if cmd:find("%s") then
		return strsplit(" ", cmd)
	else
		return cmd
	end
end

D.SlashHandler = function(cmd)
	local arg1, arg2 = strlower(Split(cmd))

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
		print("|cffff0000".. L.Help.Title .."|r")
		print(L.Help.Install)
		print(L.Help.Datatexts)
		print(" ")
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