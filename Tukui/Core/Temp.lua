----------------------------------------------------
-- Temporary file to build Tukui from a clean UI! --
----------------------------------------------------

local function HideBlizz()
	-- hide everything visible on UI on first loading
	WatchFrame:Hide()
	PlayerFrame:Hide()
	TargetFrame:Hide()
	TargetFrame.Show = function() end
end

local Init = CreateFrame("Frame")
Init:RegisterEvent("PLAYER_ENTERING_WORLD")
Init:SetScript("OnEvent", HideBlizz)

-- Collect garbage while player is AFK. (hooray for free memory!) This is here for now, but i'll move it later.
local CollectGarbage = CreateFrame("Frame")
CollectGarbage:RegisterEvent("PLAYER_FLAGS_CHANGED")
CollectGarbage:SetScript("OnEvent", function(self, event, unit)
	if (unit ~= "player") then
		return
	end
	
	if UnitIsAFK(unit) then
		collectgarbage("collect")
	end
end)