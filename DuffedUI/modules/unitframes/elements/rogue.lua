local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "ROGUE" then return end

D["ClassRessource"]["ROGUE"] = function(self)
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
			AnticipationBar[i].bg = AnticipationBar[i]:CreateTexture(nil, "BORDER")
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
	end
end
