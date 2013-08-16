local T = select(2, ...):unpack()

-- Collect garbage while player is AFK. (hooray for free memory!)
local CollectGarbage = CreateFrame("Frame")
CollectGarbage:RegisterEvent("PLAYER_FLAGS_CHANGED")
CollectGarbage:RegisterEvent("PLAYER_ENTERING_WORLD")
CollectGarbage:SetScript("OnEvent", function(self, event, unit)
	if (event == "PLAYER_ENTERING_WORLD") then
		collectgarbage("collect")

		-- Just verifying that this clears the memory out :)
		local Memory = D["DataTexts"]:GetDataText("Memory")
		
		if (Memory and Memory.Enabled) then
			Memory:Update(10)
		end
		
		self:UnregisterEvent(event)
	else
		if (unit ~= "player") then
			return
		end
		
		if UnitIsAFK(unit) then
			collectgarbage("collect")
		end
	end
end)