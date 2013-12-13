local D, C, L = select(2, ...):unpack()

local strlower = strlower

local Split = function(cmd)
	if cmd:find("%s") then
		return strsplit(" ", cmd)
	else
		return cmd
	end
end

T.SlashHandler = function(cmd)
	local arg1, arg2 = strlower(Split(cmd))

	if (arg1 == "dt" or arg1 == "datatext") then
		local DataText = T["DataTexts"]
		
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
		local Install = T["Install"]
		
		Install:Launch()
	elseif (arg1 == "help") then
		print(" ")
		print("|cffff0000".. L.Help.Title .."|r")
		print(L.Help.Install)
		print(L.Help.Datatexts)
		print(" ")
	end
end

SLASH_TUKUISLASHHANDLER1 = "/tukui"
SlashCmdList["TUKUISLASHHANDLER"] = T.SlashHandler