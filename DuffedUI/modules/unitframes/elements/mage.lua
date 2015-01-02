local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "MAGE" then return end

D["ClassRessource"]["MAGE"] = function(self)
	local ArcaneCharge = CreateFrame("Frame", "ArcaneChargeBar", UIParent)
	ArcaneCharge:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			ArcaneCharge:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			ArcaneCharge:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			ArcaneCharge:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			ArcaneCharge:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		ArcaneCharge:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	ArcaneCharge:SetBackdrop(backdrop)
	ArcaneCharge:SetBackdropColor(0, 0, 0)
	ArcaneCharge:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneCharge[i] = CreateFrame("StatusBar", "ArcaneChargeBar" .. i, ArcaneCharge)
		ArcaneCharge[i]:Height(5)
		ArcaneCharge[i]:SetStatusBarTexture(texture)
		if i == 1 then
			ArcaneCharge[i]:Width(54)
			ArcaneCharge[i]:SetPoint("LEFT", ArcaneCharge, "LEFT", 0, 0)
		else
			ArcaneCharge[i]:Width(53)
			ArcaneCharge[i]:SetPoint("LEFT", ArcaneCharge[i - 1], "RIGHT", 1, 0)
		end
		ArcaneCharge[i].bg = ArcaneCharge[i]:CreateTexture(nil, 'ARTWORK')
	end
	ArcaneCharge:CreateBackdrop()
	self.ArcaneChargeBar = ArcaneCharge

	if C["unitframes"]["oocHide"] then D["oocHide"](ArcaneCharge) end

	if C["unitframes"]["runeofpower"] then
		local RunePower = CreateFrame("Frame", "RuneOfPower", UIParent)
		RunePower:Size(216, 5)
		if C["unitframes"]["attached"] then
			if layout == 1 then
				RunePower:Point("TOP", ArcaneCharge, "BOTTOM", 0, -3)
			elseif layout == 2 then
				RunePower:Point("BOTTOM", self.Health, "TOP", 0, -5)
				RunePower:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			elseif layout == 3 then
				RunePower:Point("CENTER", self.panel, "CENTER", 0, -3)
			elseif layout == 4 then
				RunePower:Point("TOP", ArcaneCharge, "BOTTOM", 0, -5)
			end
		else
			RunePower:Point("TOP", RessourceMover, "BOTTOM", 0, -5)
		end
		RunePower:SetBackdrop(backdrop)
		RunePower:SetBackdropColor(0, 0, 0)
		RunePower:SetBackdropBorderColor(0, 0, 0)

		for i = 1, 2 do
			RunePower[i] = CreateFrame("StatusBar", "RuneOfPower" .. i, RunePower)
			RunePower[i]:Height(5)
			RunePower[i]:SetStatusBarTexture(texture)
			if i == 1 then
				RunePower[i]:Width(108)
				RunePower[i]:SetPoint("LEFT", RunePower, "LEFT", 0, 0)
			else
				RunePower[i]:Width(107)
				RunePower[i]:SetPoint("LEFT", RunePower[i - 1], "RIGHT", 1, 0)
			end
			if layout == 1 or layout == 3 or layout == 4 then RunePower[i].bg = RunePower[i]:CreateTexture(nil, 'ARTWORK') end
		end
		RunePower:CreateBackdrop()
		self.RunePower = RunePower

		if C["unitframes"]["oocHide"] then D["oocHide"](RunePower) end
	end
end