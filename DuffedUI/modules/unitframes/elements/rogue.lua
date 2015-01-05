local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}
local Colors = { 
	[1] = {.70, .30, .30},
	[2] = {.70, .40, .30},
	[3] = {.60, .60, .30},
	[4] = {.40, .70, .30},
	[5] = {.30, .70, .30},
}

if class ~= "ROGUE" then return end

D["ClassRessource"]["ROGUE"] = function(self)
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
	ComboPoints:CreateBackdrop()

	for i = 1, 5 do
		ComboPoints[i] = CreateFrame("StatusBar", "ComboPoints" .. i, ComboPoints)
		ComboPoints[i]:Height(5)
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
	self.ComboPointsBar = ComboPoints
	if C["unitframes"]["oocHide"] then D["oocHide"](ComboPoints) end

	--[[Anticipation Bar]]--
	if C["unitframes"]["AnticipationBar"] then
		local AnticipationBar = CreateFrame("Frame", "AnticipationBar", UIParent)
		AnticipationBar:Size(216, 5)
		if C["unitframes"]["attached"] then
			if layout == 1 then
				AnticipationBar:Point("TOP", ComboPoints, "BOTTOM", 0, -3)
			elseif layout == 2 then
				AnticipationBar:Point("BOTTOM", self.Health, "TOP", 0, -5)
				AnticipationBar:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			elseif layout == 3 then
				AnticipationBar:Point("CENTER", self.panel, "CENTER", 0, -3)
			elseif layout == 4 then
				AnticipationBar:Point("TOP", ComboPoints, "BOTTOM", 0, -5)
			end
		else
			AnticipationBar:Point("TOP", RessourceMover, "BOTTOM", 0, -5)
		end
		AnticipationBar:CreateBackdrop()

		for i = 1, 5 do
			AnticipationBar[i] = CreateFrame("StatusBar", "AnticipationBar" .. i, AnticipationBar)
			AnticipationBar[i]:Height(5)
			AnticipationBar[i]:SetStatusBarTexture(texture)
			AnticipationBar[i]:SetStatusBarColor(unpack(Colors[i]))
			AnticipationBar[i].bg = AnticipationBar[i]:CreateTexture(nil, "BORDER")
			AnticipationBar[i].bg:SetTexture(unpack(Colors[i]))
			if i == 1 then
				AnticipationBar[i]:Point("LEFT", AnticipationBar, "LEFT", 0, 0)
				AnticipationBar[i]:Width(44)
				AnticipationBar[i].bg:SetAllPoints(AnticipationBar[i])
			else
				AnticipationBar[i]:Point("LEFT", AnticipationBar[i-1], "RIGHT", 1, 0)
				AnticipationBar[i]:Width(42)
				AnticipationBar[i].bg:SetAllPoints(AnticipationBar[i])
			end
			AnticipationBar[i].bg:SetTexture(texture)
			AnticipationBar[i].bg:SetAlpha(.15)
		end
		self.AnticipationBar = AnticipationBar

		local Anticipation = GetSpellInfo(115189)
		local name = select(1, UnitAura("player", Anticipation))
		if name then
			if C["unitframes"]["oocHide"] then D["oocHide"](AnticipationBar) end
		end
	end
end