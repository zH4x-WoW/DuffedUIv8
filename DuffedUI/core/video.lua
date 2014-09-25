local D, C, L = unpack(select(2, ...))

if C["general"].autoscale then C["general"].uiscale = min(2, max(0.32, 768 / string.match(D.Resolution, "%d+x(%d+)"))) end

local function NeedReloadUI()
	local ResolutionDropDown = Display_ResolutionDropDown
	local X, Y = ResolutionDropDown:getValues()
	local OldRatio = D.ScreenWidth / D.ScreenHeight
	local NewRatio = X / Y
	local OldReso = D.Resolution
	local NewReso = X.."x"..Y

	if (OldRatio == NewRatio) and (OldReso ~= NewReso) then ReloadUI() end
end

local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
	local Useuiscale = GetCVar("useUiScale")

	if (Useuiscale ~= "1") then SetCVar("useUiScale", 1) end
	if (format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale)) then SetCVar("uiScale", C["general"].uiscale) end

	VideoOptionsFrameOkay:HookScript("OnClick", NeedReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", NeedReloadUI)

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / C["general"].uiscale
local Scale = function(x) return mult * math.floor(x / mult + 0.5) end

D.Scale = function(x) return Scale(x) end
D.mult = mult
D.noscalemult = D.mult * C["general"].uiscale
D.raidscale = 1