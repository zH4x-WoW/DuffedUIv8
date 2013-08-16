----------------------------------------------------
-- Temporary file to build DuffedUI from a clean UI! --
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