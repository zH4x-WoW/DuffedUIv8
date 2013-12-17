local T, C = select(2, ...):unpack()

----------------------------------------------------------------
-- This script will adjust resolution for optimal graphic
----------------------------------------------------------------

-- [[ Auto Scaling ]] --
if C.General.AutoScale == true then
	C.General.UIScale = min(2, max(.64, 768/string.match(D.Resolution, "%d+x(%d+)")))
end

-- [[ ReloadUI need to be done even if we keep aspect ratio ]] --
local function NeedReloadUI()
	local resolution = Graphics_ResolutionDropDown
	local x, y = resolution:getValues()
	local oldratio = D.ScreenWidth / D.ScreenHeight
	local newratio = x / y
	local oldreso = D.Resolution
	local newreso = x.."x"..y
	
	if (oldratio == newratio) and (oldreso ~= newreso) then
		ReloadUI()
	end
end

-- [[ Optimize graphic after we enter world ]] --
local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
	local useUiScale = GetCVar("useUiScale")
	if useUiScale ~= "1" then
		SetCVar("useUiScale", 1)
	end

	local gxMultisample = GetCVar("gxMultisample")
	if C.General.MultiSampleProtection and gxMultisample ~= "1" then
		SetMultisampleFormat(1)
	end

	if C.General.UIScale > 1.1 then C.General.UIScale = 1.1 end
	if C.General.UIScale < 0.64 then C.General.UIScale = 0.64 end

	if format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C.General.UIScale) then
		SetCVar("uiScale", C.General.UIScale)
	end

	if D.TripleMonitors then
		local width = D.TripleMonitors
		local height = D.ScreenHeight
		
		if not C.General.AutoScale or height > 1200 then
			local h = UIParent:GetHeight()
			local ratio = D.ScreenHeight / h
			local w = D.TripleMonitors / ratio
			
			width = w
			height = h			
		end
		
		UIParent:SetSize(width, height)
		UIParent:ClearAllPoints()
		UIParent:SetPoint("CENTER")		
	end

	VideoOptionsFrameOkay:HookScript("OnClick", NeedReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", NeedReloadUI)
	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)
