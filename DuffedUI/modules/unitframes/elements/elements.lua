local D, C, L = unpack(select(2, ...))

local texture = C["media"].normTex
local font, fontsize, fontflag = C["media"].font, 11, "THINOUTLINE"
local layout = C["unitframes"].layout
local Color = RAID_CLASS_COLORS[D.Class]

--[[Mover]]--
local cba = CreateFrame("Frame", "CBAnchor", UIParent)
cba:SetTemplate("Default")
cba:Size(250, 15)
if C["raid"].center then cba:Point("BOTTOM", UIParent, "BOTTOM", 0, 200) else cba:Point("BOTTOM", UIParent, "BOTTOM", 0, 325) end
cba:SetClampedToScreen(true)
cba:SetMovable(true)
cba:SetBackdropColor(0, 0, 0)
cba:SetBackdropBorderColor(1, 0, 0)
cba.text = D.SetFontString(cba, font, fontsize)
cba.text:SetPoint("CENTER")
cba.text:SetText(L["move"]["classbar"])
cba:Hide()
tinsert(D.AllowFrameMoving, CBAnchor)

--[[Energybar]]--
D.ConstructEnergy = function(name, width, height)
	local eb = CreateFrame("StatusBar", name, UIParent)
	eb:SetPoint("TOP", CBAnchor, "BOTTOM", 0, 5)
	eb:Size(D.Scale(width), D.Scale(height))
	eb:SetStatusBarTexture(texture)
	eb:SetStatusBarColor(Color.r, Color.g, Color.b)
	eb:SetMinMaxValues(0, 100)
	eb:CreateBackdrop()
	eb:SetParent(DuffedUIPetBattleHider)

	eb.text = eb:CreateFontString(nil, "ARTWORK")
	eb.text:SetFont(font, 16, fontflag)
	eb.text:SetPoint("LEFT", eb, "RIGHT", 4, 1)
	eb.text:SetTextColor(Color.r, Color.g, Color.b)

	eb.TimeSinceLastUpdate = 0
	eb:SetScript("OnUpdate", function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed 

		if self.TimeSinceLastUpdate > 0.07 then
			self:SetMinMaxValues(0, UnitPowerMax("player"))
			local power = UnitPower("player")
			self:SetValue(power)
			if self.text then self.text:SetText(D.ShortValue(power)) end
			self.TimeSinceLastUpdate = 0
		end
	end)

	if C["unitframes"].oocHide then
		eb:RegisterEvent("PLAYER_REGEN_DISABLED")
		eb:RegisterEvent("PLAYER_REGEN_ENABLED")
		eb:RegisterEvent("PLAYER_ENTERING_WORLD")
		eb:SetScript("OnEvent", function(self, event)
			if event == "PLAYER_REGEN_DISABLED" then
				UIFrameFadeIn(self, (0.3 * (1 - self:GetAlpha())), self:GetAlpha(), 1)
			elseif event == "PLAYER_REGEN_ENABLED" then
				UIFrameFadeOut(self, 2, self:GetAlpha(), 0)
			elseif event == "PLAYER_ENTERING_WORLD" then
				if not InCombatLockdown() then eb:SetAlpha(0) end
			end
		end)
	end
end