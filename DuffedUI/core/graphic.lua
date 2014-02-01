local D, C = select(2, ...):unpack()

----------------------------------------------------------------
-- This script will adjust resolution for optimal graphic
----------------------------------------------------------------

-- [[ Auto Scaling ]] --
if C["general"].AutoScale == true then
	C["general"].UIScale = min(2, max(.32, 768/string.match(D.Resolution, "%d+x(%d+)")))
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
	if C["general"].MultiSampleProtection and gxMultisample ~= "1" then
		SetMultisampleFormat(1)
	end

	if format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].UIScale) then
		SetCVar("uiScale", C["general"].UIScale)
	end
	
	-- Allow 4K and WQHD Resolution to have an UIScale lower than 0.64, which is the lowest value of UIParent scale by default
	if C["general"].UIScale < 0.64 then UIParent:SetScale(C["general"].UIScale) end

	if D.TripleMonitors then
		local width = D.TripleMonitors
		local height = D.ScreenHeight
		
		if not C["general"].AutoScale or height > 1200 then
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
