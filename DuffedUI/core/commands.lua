local D, C, L = select(2, ...):unpack()

local strlower = strlower

local Split = function(str)
	if str:find("%s") then
		return strsplit(" ", str)
	else
		return str
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
	end
end

SLASH_TUKUISLASHHANDLER1 = "/tukui"
SlashCmdList["TUKUISLASHHANDLER"] = D.SlashHandler