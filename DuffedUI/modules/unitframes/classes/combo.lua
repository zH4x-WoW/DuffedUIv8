local D, C, L = select(2, ...):unpack()

local DuffedUIUnitFrames = D["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "ROGUE") or (Class ~= "DRUID") then return end

function DuffedUIUnitFrames:AddRogueFeatures()
	local colors = {
		[1] = {0.60, 0, 0, 1},
		[2] = {0.60, 0.30, 0, 1},
		[3] = {0.60, 0.60, 0, 1},
		[4] = {0.30, 0.60, 0, 1},
		[5] = {0, 0.60, 0, 1},
	},

	local Combo = CreateFrame("Frame", "Combo", UIParent)
	for i = 1, 5 do
		Combo[i] = CreateFrame("Frame", "Combo"..i, UIParent)
		Combo[i]:Size(D.Scale(40), D.Scale(11))
		Combo[i]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		Combo[i].text = Combo[i]:CreateFontString(nil, "OVERLAY")
		Combo[i].text:SetFont(C["medias"].Font, 12)
		Combo[i].text:SetPoint("CENTER")
		Combo[i].text:SetText(i)
			
		if i == 1 then
			Combo[i]:Point("TOPLEFT", AnchorFrameRessources, "BOTTOMLEFT", 0, -3)
		else
			Combo[i]:Point("LEFT", Combo[i-1], "RIGHT", D.Scale(3), 0)
		end
		
		Combo[i]:SetTemplate("Default")
		Combo[i]:CreateShadow("Default")
		Combo[i]:CreateBackdrop()
		Combo[i]:SetBackdropBorderColor(unpack(colors[i]))
		Combo[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
		Combo[i]:RegisterEvent("UNIT_COMBO_POINTS")
		Combo[i]:RegisterEvent("PLAYER_TARGET_CHANGED")
		Combo[i]:SetScript("OnEvent", function(self, event)
		local points, pt = 0, GetComboPoints("player", "target")
			if pt == points then
				Combo[i]:Hide()
			elseif pt > points then
				for i = points + 1, pt do
					Combo[i]:Show()
				end
			else
				for i = pt + 1, points do
					Combo[i]:Hide()
				end
			end
			points = pt	
		end)
	end

	local PowerBG = CreateFrame("Frame", "PowerBG", oUF_DuffedUITarget)
	PowerBG:Size((D.Scale(40) * 5) + (D.Scale(3) * 5) - D.Scale(3), D.Scale(11))
	PowerBG:SetPoint("TOPLEFT", AnchorFrame, "BOTTOMLEFT", 0, -(D.Scale(11) + 6))
	PowerBG:SetTemplate("Transparent")
	PowerBG:CreateShadow("Default")

	local PowerStatus = CreateFrame("StatusBar", "PowerStatus", DuffedUITarget)
	PowerStatus:SetStatusBarTexture(C["medias"].Normal)
	PowerStatus:SetFrameLevel(6)
	PowerStatus:Point("TOPLEFT", PowerBG, "TOPLEFT", 2, -2)
	PowerStatus:Point("BOTTOMRIGHT", PowerBG, "BOTTOMRIGHT", -2, 2)

	PowerStatus.t = PowerStatus:CreateFontString(nil, "OVERLAY")
	PowerStatus.t:SetPoint("CENTER")
	PowerStatus.t:SetFont(C["medias"].Font, 12, "THINOUTLINE")
	PowerStatus.t:SetShadowOffset(0.5, -0.5)
	PowerStatus.t:SetShadowColor(0,0,0)

	local color = RAID_CLASS_COLORS[D.myclass]
	PowerStatus:SetStatusBarColor(color.r, color.g, color.b)

	local t = 0
	PowerStatus:SetScript("OnUpdate", function(self, elapsed)
	    t = t + elapsed;
	    if (t > 0.07) then
	        PowerStatus:SetMinMaxValues(0, UnitPowerMax("player"))
	        local power = UnitPower("player")
	        PowerStatus:SetValue(power)
			PowerStatus.t:SetText(power)
	    end
	end)

	PowerBG:RegisterEvent("PLAYER_ENTERING_WORLD")
	--PowerBG:RegisterEvent("UNIT_DISPLAYPOWER")
	PowerBG:RegisterEvent("PLAYER_REGEN_ENABLED")
	PowerBG:RegisterEvent("PLAYER_REGEN_DISABLED")
	PowerBG:SetScript("OnEvent", function(self, event)
	local p, _ = UnitPowerType("player")
	    if p == SPELL_POWER_ENERGY then
	        PowerBG:Show()
	        PowerStatus:Show()
	    else
	        PowerBG:Hide()
	        PowerStatus:Hide()
	    end
	end)
end