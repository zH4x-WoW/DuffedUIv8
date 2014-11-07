local D, C, L = unpack(select(2, ...))
if D.Class ~= "DRUID" then return end

local texture = C["media"].normTex
local layout = C["unitframes"].layout
local font, fonsize, fontflag = C["media"].font, 12, "THINOUTLINE"

Colors = {
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

if not C["unitframes"].attached then D.ConstructEnergy("Energy", 216, 5) end

D.ConstructRessources = function(name, width, height)
	local DruidMana = CreateFrame("StatusBar", name .. "Mana", UIParent)
	DruidMana:Size(width, height)
	DruidMana:SetStatusBarTexture(texture)
	DruidMana:SetStatusBarColor(.30, .52, .90)
	DruidMana:CreateBackdrop()

	DruidMana:SetBackdrop(backdrop)
	DruidMana:SetBackdropColor(0, 0, 0)
	DruidMana:SetBackdropBorderColor(0, 0, 0)

	DruidMana.Background = DruidMana:CreateTexture(nil, "BORDER")
	DruidMana.Background:SetAllPoints()
	DruidMana.Background:SetTexture(.30, .52, .90, .2)

	local EclipseBar = CreateFrame("Frame", name .. "EclipseBar", UIParent)
	EclipseBar:SetFrameStrata("MEDIUM")
	EclipseBar:SetFrameLevel(8)
	EclipseBar:Size(width, height)
	EclipseBar:SetBackdrop(backdrop)
	EclipseBar:SetBackdropColor(0, 0, 0)
	EclipseBar:SetBackdropBorderColor(0, 0, 0, 0)
	EclipseBar:CreateBackdrop()

	EclipseBar.LunarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.LunarBar:SetPoint("LEFT", EclipseBar, "LEFT", 0, 0)
	EclipseBar.LunarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.LunarBar:SetStatusBarTexture(texture)
	EclipseBar.LunarBar:SetStatusBarColor(.50, .52, .70)

	EclipseBar.SolarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.SolarBar:SetPoint("LEFT", EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	EclipseBar.SolarBar:SetSize(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.SolarBar:SetStatusBarTexture(texture)
	EclipseBar.SolarBar:SetStatusBarColor(.80, .82,  .60)

	EclipseBar.Text = EclipseBar:CreateFontString(nil, "OVERLAY")
	if layout == 3 then EclipseBar.Text:SetPoint("TOP", EclipseBar, "BOTTOM", 0, -15) else EclipseBar.Text:SetPoint("BOTTOM", EclipseBar, "TOP", 0, 0) end
	EclipseBar.Text:SetFont(C["media"].font, 12, "THINOUTLINE")
	EclipseBar.PostUpdatePower = D.EclipseDirection

	local WildMushroom = CreateFrame("Frame", name .. "WildMushroom", UIParent)
	WildMushroom:SetSize(width, height)
	WildMushroom:SetBackdrop(backdrop)
	WildMushroom:SetBackdropColor(0, 0, 0)
	WildMushroom:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 3 do
		WildMushroom[i] = CreateFrame("StatusBar", name .. "WildMushroom" .. i, WildMushroom)
		WildMushroom[i]:SetHeight(height)
		WildMushroom[i]:SetStatusBarTexture(texture)
		if i == 1 then
			WildMushroom[i]:SetWidth(width / 3)
			WildMushroom[i]:SetPoint("LEFT", WildMushroom, "LEFT", 0, 0)
		else
			WildMushroom[i]:SetWidth((width / 3) - 1)
			WildMushroom[i]:SetPoint("LEFT", WildMushroom[i - 1], "RIGHT", 1, 0)
		end
		WildMushroom[i].bg = WildMushroom[i]:CreateTexture(nil, 'ARTWORK')
	end
	if layout == 1 or layout == 3 then WildMushroom:CreateBackdrop() end

	local ComboPoints= CreateFrame("Frame", name .. "ComboPoints", UIParent)
	ComboPoints:Size(width, height)
	ComboPoints:CreateBackdrop()
	ComboPoints:SetBackdrop(backdrop)
	ComboPoints:SetBackdropColor(0, 0, 0)
	ComboPoints:SetBackdropBorderColor(0, 0, 0, 0)

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", name .. "ComboPoints" .. i, ComboPoints)
		ComboPoints[i]:Height(height)
		ComboPoints[i]:SetStatusBarTexture(texture)
		ComboPoints[i]:SetStatusBarColor(unpack(Colors[i]))
		ComboPoints[i].bg = ComboPoints[i]:CreateTexture(nil, "BORDER")
		ComboPoints[i].bg:SetTexture(unpack(Colors[i]))
		if i == 1 then
			ComboPoints[i]:SetPoint("LEFT", ComboPoints)
			ComboPoints[i]:Width(44)
			ComboPoints[i].bg:SetAllPoints(ComboPoints[i])
		else
			ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
			ComboPoints[i]:Width(42)
			ComboPoints[i].bg:SetAllPoints(ComboPoints[i])
		end
		ComboPoints[i].bg:SetTexture(texture)
		ComboPoints[i].bg:SetAlpha(.15)
	end

	Visibility = CreateFrame("Frame")
	Visibility:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Visibility:SetScript("OnEvent", function()
		local spec = GetSpecialization()
		local specName = spec and select(2, GetSpecializationInfo(spec)) or "None"
		if specName == "Balance" then
			ComboPoints:Hide()
		elseif specName == "Feral" then
			WildMushroom:Hide()
			EclipseBar:Hide()
		elseif specName == "Restoration" then
			EclipseBar:Hide()
			ComboPoints:Hide()
		elseif specName == "Guardian" then
			EclipseBar:Hide()
			ComboPoints:Hide()
			WildMushroom:Hide()
		end
	end)

	if C["unitframes"].oocHide then
		DruidMana:RegisterEvent("PLAYER_REGEN_DISABLED")
		DruidMana:RegisterEvent("PLAYER_REGEN_ENABLED")
		DruidMana:RegisterEvent("PLAYER_ENTERING_WORLD")
		DruidMana:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then DruidMana:SetAlpha(0) end
			end
		end)

		EclipseBar:RegisterEvent("PLAYER_REGEN_DISABLED")
		EclipseBar:RegisterEvent("PLAYER_REGEN_ENABLED")
		EclipseBar:RegisterEvent("PLAYER_ENTERING_WORLD")
		EclipseBar:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then EclipseBar:SetAlpha(0) end
			end
		end)

		WildMushroom:RegisterEvent("PLAYER_REGEN_DISABLED")
		WildMushroom:RegisterEvent("PLAYER_REGEN_ENABLED")
		WildMushroom:RegisterEvent("PLAYER_ENTERING_WORLD")
		WildMushroom:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then WildMushroom:SetAlpha(0) end
			end
		end)

		ComboPoints:RegisterEvent("PLAYER_REGEN_DISABLED")
		ComboPoints:RegisterEvent("PLAYER_REGEN_ENABLED")
		ComboPoints:RegisterEvent("PLAYER_ENTERING_WORLD")
		ComboPoints:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, (0.3 * (0 + self:GetAlpha())), self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then ComboPoints:SetAlpha(0) end
			end
		end)
	end
end