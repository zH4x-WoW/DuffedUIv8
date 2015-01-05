local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "DRUID" then return end

D["ClassRessource"]["DRUID"] = function(self)
	--[[Druid Mana]]--
	if C["unitframes"]["DruidMana"] then
		local DruidMana = CreateFrame("StatusBar", nil, self.Health)
		DruidMana:Size(216, 5)
		if C["unitframes"]["attached"] then
			if layout == 1 then
				DruidMana:Point("TOP", self.Power, "BOTTOM", 0, -10)
			elseif layout == 2 then
				DruidMana:Point("BOTTOM", self.Health, "TOP", 0, -5)
				DruidMana:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			elseif layout == 3 then
				DruidMana:Point("CENTER", self.panel, "CENTER", 0, -3)
			elseif layout == 4 then
				DruidMana:Point("TOP", self.Health, "BOTTOM", 0, -10)
			end
		else
			DruidMana:Point("TOP", RessourceMover, "BOTTOM", 0, -5)
		end
		DruidMana:SetStatusBarTexture(texture)
		DruidMana:SetStatusBarColor(.30, .52, .90)
		DruidMana:SetFrameLevel(self.Health:GetFrameLevel() + 3)
		DruidMana:CreateBackdrop()

		DruidMana:SetBackdrop(backdrop)
		DruidMana:SetBackdropColor(0, 0, 0)
		DruidMana:SetBackdropBorderColor(0, 0, 0)

		DruidMana.bg = DruidMana:CreateTexture(nil, "BORDER")
		DruidMana.bg:SetAllPoints(DruidMana)
		DruidMana.bg:SetTexture(.30, .52, .90, .2)

		self.DruidMana = DruidMana
		self.DruidMana.bg = DruidMana.bg
		if C["unitframes"]["oocHide"] then D["oocHide"](DruidMana) end
	end

	--[[Wild Mushrooms]]--
	local Mushroom = CreateFrame("Frame", "Mushroom", UIParent)
	Mushroom:SetSize(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			Mushroom:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			Mushroom:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			Mushroom:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			Mushroom:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		Mushroom:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	Mushroom:SetBackdrop(backdrop)
	Mushroom:SetBackdropColor(0, 0, 0)
	Mushroom:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 3 do
		Mushroom[i] = CreateFrame("StatusBar", "Mushroom" .. i, Mushroom)
		Mushroom[i]:SetHeight(5)
		Mushroom[i]:SetStatusBarTexture(texture)
		if i == 1 then
			Mushroom[i]:SetWidth(216 / 3)
			Mushroom[i]:SetPoint("LEFT", Mushroom, "LEFT", 0, 0)
		else
			Mushroom[i]:SetWidth((216 / 3) - 1)
			Mushroom[i]:SetPoint("LEFT", Mushroom[i - 1], "RIGHT", 1, 0)
		end
		Mushroom[i].bg = Mushroom[i]:CreateTexture(nil, 'ARTWORK')
	end
	Mushroom:CreateBackdrop()
	if C["unitframes"]["oocHide"] then D["oocHide"](Mushroom) end
	self.WildMushroom = Mushroom

	--[[Eclipse Bar]]--
	local EclipseBar = CreateFrame("Frame", nil, self)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			EclipseBar:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			EclipseBar:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			EclipseBar:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			EclipseBar:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		EclipseBar:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	EclipseBar:Size(216, 5)
	EclipseBar:CreateBackdrop()

	EclipseBar:SetBackdrop(backdrop)
	EclipseBar:SetBackdropColor(0, 0, 0)
	EclipseBar:SetBackdropBorderColor(0,0,0,0)
	EclipseBar:Hide()

	EclipseBar.LunarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.LunarBar:SetPoint("LEFT", EclipseBar, "LEFT", 0, 0)
	EclipseBar.LunarBar:Size(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.LunarBar:SetStatusBarTexture(texture)
	EclipseBar.LunarBar:SetStatusBarColor(.50, .52, .70)
	EclipseBar.LunarBar:SetFrameLevel(self.Health:GetFrameLevel())

	EclipseBar.SolarBar = CreateFrame("StatusBar", nil, EclipseBar)
	EclipseBar.SolarBar:SetPoint("LEFT", EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT", 0, 0)
	EclipseBar.SolarBar:Size(EclipseBar:GetWidth(), EclipseBar:GetHeight())
	EclipseBar.SolarBar:SetStatusBarTexture(texture)
	EclipseBar.SolarBar:SetStatusBarColor(.80, .82, .60)
	EclipseBar.SolarBar:SetFrameLevel(self.Health:GetFrameLevel())

	EclipseBar.Text = EclipseBar:CreateFontString(nil, "OVERLAY")
	EclipseBar.Text:SetPoint("CENTER", self.Health, "CENTER", 0, 0)
	EclipseBar.Text:SetFontObject(font)

	EclipseBar.PostUpdatePower = D["EclipseDirection"]
	if C["unitframes"]["oocHide"] then D["oocHide"](EclipseBar) end
	self.EclipseBar = EclipseBar

	--[[ComboPoints]]--
	local ComboPoints = CreateFrame("Frame", "ComboPoints", UIParent)
	ComboPoints:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			ComboPoints:Point("TOP", oUF_Player.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			ComboPoints:Point("CENTER", oUF_Player.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			ComboPoints:Point("CENTER", oUF_Player.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			ComboPoints:Point("TOP", oUF_Player.Health, "BOTTOM", 0, -5)
		end
	else
		ComboPoints:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Energy", 216, 5)
	end
	ComboPoints:SetBackdrop(backdrop)
	ComboPoints:SetBackdropColor(0, 0, 0)
	ComboPoints:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", "ComboPoints" .. i, ComboPoints)
		ComboPoints[i]:Height(5)
		ComboPoints[i]:SetStatusBarTexture(texture)
		if i == 1 then
			ComboPoints[i]:Width(44)
			ComboPoints[i]:SetPoint("LEFT", ComboPoints)
		else
			ComboPoints[i]:Width(42)
			ComboPoints[i]:Point("LEFT", ComboPoints[i - 1], "RIGHT", 1, 0)
		end
		ComboPoints[i].bg = ComboPoints[i]:CreateTexture(nil, "ARTWORK")
	end
	ComboPoints:CreateBackdrop()
	self.ComboPointsBar = ComboPoints
	if C["unitframes"]["oocHide"] then D["oocHide"](ComboPoints) end

	--[[Visibility]]--
	Visibility = CreateFrame("Frame")
	Visibility:RegisterEvent("PLAYER_ENTERING_WORLD")
	Visibility:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	Visibility:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Visibility:SetScript("OnEvent", function()
		local spec = GetSpecialization()
		--local specName = spec and select(2, GetSpecializationInfo(spec)) or "None"
		local form = GetShapeshiftFormID()
		if spec == 1 then
			if not form == 1 then ComboPoints:Hide() end
			if not C["unitframes"]["attached"] then
				Mushroom:ClearAllPoints()
				Mushroom:Point("TOP", RessourceMover, "BOTTOM", 0, -5)
			else
				Mushroom:ClearAllPoints()
				Mushroom:Point("TOP", EclipseBar, "BOTTOM", 0, -7)
			end
		elseif spec == 2 then
			Mushroom:Hide()
			EclipseBar:Hide()
		elseif spec == 4 then
			EclipseBar:Hide()
			if not form == 1 then ComboPoints:Hide() end
			Mushroom[1]:SetWidth(Mushroom:GetWidth())
			Mushroom[2]:Hide()
			Mushroom[3]:Hide()
		elseif spec == 3 then
			EclipseBar:Hide()
			if not form == 1 then ComboPoints:Hide() end
			Mushroom:Hide()
		else
			EclipseBar:Hide()
			ComboPoints:Hide()
			Mushroom:Hide()
		end
	end)
end