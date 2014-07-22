local D, C = select(2, ...):unpack()

----------------------------------------------------------------
-- This script will adjust resolution for optimal graphic
----------------------------------------------------------------

-- Auto Scaling
if (C["general"].AutoScale == true) then
	C["general"].UIScale = min(2, max(.32, 768/string.match(D.Resolution, "%d+x(%d+)")))
end

-- ReloadUI need to be done even if we keep aspect ratio
local function NeedReloadUI()
	local ResolutionDropDown = Display_ResolutionDropDown
	local X, Y = ResolutionDropDown:getValues()
	local OldRatio = D.ScreenWidth / D.ScreenHeight
	local NewRatio = X / Y
	local OldReso = D.Resolution
	local NewReso = X.."x"..Y
	
	if (OldRatio == NewRatio) and (OldReso ~= NewReso) then
		ReloadUI()
	end
end

-- Optimize graphic after we enter world
local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
	local UseUiScale = GetCVar("useUiScale")
	if (UseUiScale ~= "1") then
		SetCVar("useUiScale", 1)
	end

	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].UIScale)) then
		SetCVar("uiScale", C["general"].UIScale)
	end
	
	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is
	-- the lowest value of UIParent scale by default
	if (C["general"].UIScale < 0.64) then
		UIParent:SetScale(C["general"].UIScale)	
	end

	VideoOptionsFrameOkay:HookScript("OnClick", NeedReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", NeedReloadUI)
	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)
