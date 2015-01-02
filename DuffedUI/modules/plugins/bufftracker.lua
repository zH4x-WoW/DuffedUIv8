local D, C, L = unpack(select(2, ...))
if C["auras"].bufftracker ~= true then return end

local function SetCasterOnlyBuffs()
	Spell1Buff = { --Stats
		1126, 					-- Mark of the Wild
		115921,					-- Legacy of the Emperor
		116781,					-- Legacy of the White Tiger
		20217,					-- Blessing of Kings
		159988,					-- Bark of the Wild (Hunterpet)
		160017,					-- Blessing of Kongs (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	}
	Spell2Buff = { -- Stamina
		21562,					-- Power Word: Fortitude
		166928,					-- Blood Pact
		469,					-- Commanding Shout
		50256,					-- Invigorating Roar (Hunterpet)
		160014,					-- Sturdiness (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
	}
	Spell3Buff = { -- Attack Power
		57330,					-- Horn of Winter
		19506,					-- Trueshot Aura
		6673,					-- Battle Shout
	}
	Spell4Buff = { -- Spell Power
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		109773,					-- Dark Intent
		128433,					-- Serpent's Cunning (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
		126309,					-- Still Water (Hunterpet)
	}
	Spell5Buff = { -- Mastery
		155522,					-- Power of the Grave
		24907,					-- Moonkin Aura
		19740,					-- Blessing of Might
		116956,					-- Grace of Air
		93435,					-- Roar of Courage (Hunterpet)
		160039,					-- Keen Senses (Hunterpet)
		128997,					-- Spirit Beast Blessing (Hunterpet)
		160073,					-- Plainswalking (Hunterpet)
	}
	Spell6Buff = { -- Haste
		55510,					-- Unholy Aura
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		116956,					-- Grace of Air
		128432,					-- Crackling Howl (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		135678,					-- Energizing Spores (Hunterpet)
		160074,					-- Speed of the Swarm (Hunterpet)
	}
	Spell7Buff = { -- Crit
		17007,					-- Leader of the Pack
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		116781,					-- Legacy of the White Tiger
		90309,					-- Terrifying Roar (Hunterpet)
		126373,					-- Fearless Roar (Hunterpet)
		160052,					-- Strength of the Pack (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		126309,					-- Still Water (Hunterpet)
		24604,					-- Furious Howl (Hunterpet)
	}
	Spell8Buff = { -- Multistrike
		166916,					-- Windflurry
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		109773,					-- Dark Intent
		50519,					-- Sonic Focus (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		58604,					-- Double Bite (Hunterpet)
		34889,					-- Spry Attacks (Hunterpet)
		24844,					-- Breath of Winds (Hunterpet)
	}
	Spell9Buff = { -- Versatility
		55610,					-- Unholy Aura
		1126,					-- Mark of the Wild
		167187,					-- Sanctity Aura
		167188,					-- Inspiring Presence
		159735,					-- Tenacity (Hunterpet)
		35290,					-- Indomitable (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		160045,					-- Defensive Quills (Hunterpet)
		50518,					-- Chitinous Armor (Hunterpet)
		173035,					-- Grace (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	}
end

local function SetBuffs()
	Spell1Buff = { --Stats
		1126, 					-- Mark of the Wild
		115921,					-- Legacy of the Emperor
		116781,					-- Legacy of the White Tiger
		20217,					-- Blessing of Kings
		159988,					-- Bark of the Wild (Hunterpet)
		160017,					-- Blessing of Kongs (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	}
	Spell2Buff = { -- Stamina
		21562,					-- Power Word: Fortitude
		166928,					-- Blood Pact
		469,					-- Commanding Shout
		50256,					-- Invigorating Roar (Hunterpet)
		160014,					-- Sturdiness (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
	}
	Spell3Buff = { -- Attack Power
		57330,					-- Horn of Winter
		19506,					-- Trueshot Aura
		6673,					-- Battle Shout
	}
	Spell4Buff = { -- Spell Power
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		109773,					-- Dark Intent
		128433,					-- Serpent's Cunning (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
		126309,					-- Still Water (Hunterpet)
	}
	Spell5Buff = { -- Mastery
		155522,					-- Power of the Grave
		24907,					-- Moonkin Aura
		19740,					-- Blessing of Might
		116956,					-- Grace of Air
		93435,					-- Roar of Courage (Hunterpet)
		160039,					-- Keen Senses (Hunterpet)
		128997,					-- Spirit Beast Blessing (Hunterpet)
		160073,					-- Plainswalking (Hunterpet)
	}
	Spell6Buff = { -- Haste
		55510,					-- Unholy Aura
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		116956,					-- Grace of Air
		128432,					-- Crackling Howl (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		135678,					-- Energizing Spores (Hunterpet)
		160074,					-- Speed of the Swarm (Hunterpet)
	}
	Spell7Buff = { -- Crit
		17007,					-- Leader of the Pack
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		116781,					-- Legacy of the White Tiger
		90309,					-- Terrifying Roar (Hunterpet)
		126373,					-- Fearless Roar (Hunterpet)
		160052,					-- Strength of the Pack (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		126309,					-- Still Water (Hunterpet)
		24604,					-- Furious Howl (Hunterpet)
	}
	Spell8Buff = { -- Multistrike
		166916,					-- Windflurry
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		109773,					-- Dark Intent
		50519,					-- Sonic Focus (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		58604,					-- Double Bite (Hunterpet)
		34889,					-- Spry Attacks (Hunterpet)
		24844,					-- Breath of Winds (Hunterpet)
	}
	Spell9Buff = { -- Versatility
		55610,					-- Unholy Aura
		1126,					-- Mark of the Wild
		167187,					-- Sanctity Aura
		167188,					-- Inspiring Presence
		159735,					-- Tenacity (Hunterpet)
		35290,					-- Indomitable (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		160045,					-- Defensive Quills (Hunterpet)
		50518,					-- Chitinous Armor (Hunterpet)
		173035,					-- Grace (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	}
end

local function OnAuraChange(self, event, arg1, unit)
	if event == "UNIT_AURA" and arg1 ~= "player" then return end
	if D.Role == "Caster" or D.Role == "Healer" then SetCasterOnlyBuffs() else SetBuffs() end

	for i, Spell1Buff in pairs(Spell1Buff) do
		local spellname = select(1, GetSpellInfo(Spell1Buff))
		if UnitAura("player", spellname) then
			Spell1Frame:SetAlpha(1)
			Spell1Frame.t:SetTexture(select(3, GetSpellInfo(Spell1Buff)))
			Spell1Frame.id = Spell1Buff
			break
		else
			Spell1Frame:SetAlpha(0.2)
			Spell1Frame.t:SetTexture(select(3, GetSpellInfo(Spell1Buff)))
		end
		Spell1Frame.id = Spell1Buff
	end

	for i, Spell2Buff in pairs(Spell2Buff) do
		local spellname = select(1, GetSpellInfo(Spell2Buff))
		if UnitAura("player", spellname) then
			Spell2Frame:SetAlpha(1)
			Spell2Frame.t:SetTexture(select(3, GetSpellInfo(Spell2Buff)))
			Spell2Frame.id = Spell2Buff
			break
		else
			Spell2Frame:SetAlpha(0.2)
			Spell2Frame.t:SetTexture(select(3, GetSpellInfo(Spell2Buff)))
		end
		Spell2Frame.id = Spell2Buff
	end

	for i, Spell3Buff in pairs(Spell3Buff) do
		local spellname = select(1, GetSpellInfo(Spell3Buff))
		if UnitAura("player", spellname) then
			Spell3Frame:SetAlpha(1)
			Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
			Spell3Frame.id = Spell3Buff
			break
		else
			Spell3Frame:SetAlpha(0.2)
			Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
		end
		Spell3Frame.id = Spell3Buff
	end

	for i, Spell4Buff in pairs(Spell4Buff) do
		local spellname = select(1, GetSpellInfo(Spell4Buff))
		if UnitAura("player", spellname) then
			Spell4Frame:SetAlpha(1)
			Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
			Spell4Frame.id = Spell4Buff
			break
		else
			Spell4Frame:SetAlpha(0.2)
			Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
			Spell4Frame.id = Spell4Buff
		end
	end

	for i, Spell5Buff in pairs(Spell5Buff) do
		local spellname = select(1, GetSpellInfo(Spell5Buff))
		if UnitAura("player", spellname) then
			Spell5Frame:SetAlpha(1)
			Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
			Spell5Frame.id = Spell5Buff
			break
		else
			Spell5Frame:SetAlpha(0.2)
			Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
		end
		Spell5Frame.id = Spell5Buff
	end

	for i, Spell6Buff in pairs(Spell6Buff) do
		local spellname = select(1, GetSpellInfo(Spell6Buff))
		if UnitAura("player", spellname) then
			Spell6Frame:SetAlpha(1)
			Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
			Spell6Frame.id = Spell6Buff
			break
		else
			Spell6Frame:SetAlpha(0.2)
			Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
		end
		Spell6Frame.id = Spell6Buff
	end
end

local btWidth = ((DuffedUIMinimap:GetWidth() - 6) / 6) + 4
local btHeight = DuffedUIMinimap:GetWidth() + 10

local bufftracker = CreateFrame("Frame", "BuffTracker", Minimap)
bufftracker:SetTemplate("Transparent")
bufftracker:Width(btWidth + 2)
bufftracker:Height(btHeight)
bufftracker:SetPoint("TOPLEFT", DuffedUIMinimap, "TOPRIGHT", 2, 0)

bufftracker:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
bufftracker:RegisterEvent("UNIT_INVENTORY_CHANGED")
bufftracker:RegisterEvent("UNIT_AURA")
bufftracker:RegisterEvent("PLAYER_REGEN_ENABLED")
bufftracker:RegisterEvent("PLAYER_REGEN_DISABLED")
bufftracker:RegisterEvent("PLAYER_ENTERING_WORLD")
bufftracker:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
bufftracker:RegisterEvent("CHARACTER_POINTS_CHANGED")
bufftracker:RegisterEvent("ZONE_CHANGED_NEW_AREA")
bufftracker:SetScript("OnEvent", OnAuraChange)

local function CreateButton(name, relativeTo, firstbutton, lastbutton)
	local button = CreateFrame("Button", name, BuffTracker)
	button:SetTemplate("Default")
	button:Size(btWidth - 3)
	if firstbutton == true then button:Point("TOP", relativeTo, "TOP", 0, -2) else button:Point("TOP", relativeTo, "BOTTOM", 0, -1) end
	if lastbutton == true then button:Point("BOTTOM", BuffTracker, "BOTTOM", 0, 2) end

	button.t = button:CreateTexture(name .. ".t", "OVERLAY")
	button.t:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.t:Point("TOPLEFT", 2, -2)
	button.t:Point("BOTTOMRIGHT", -2, 2)

	return button
end

CreateButton("Spell1Frame", BuffTracker, true)
CreateButton("Spell2Frame", Spell1Frame, false)
CreateButton("Spell3Frame", Spell2Frame, false)
CreateButton("Spell4Frame", Spell3Frame, false)
CreateButton("Spell5Frame", Spell4Frame, false)
CreateButton("Spell6Frame", Spell5Frame, false, true)

-- Adding in ALL RAID BUFFS
local AllBuffs = {
	["attackpower"] = {
		57330,					-- Horn of Winter
		19506,					-- Trueshot Aura
		6673,					-- Battle Shout
	},
	["haste"] = {
		55510,					-- Unholy Aura
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		116956,					-- Grace of Air
		128432,					-- Crackling Howl (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		135678,					-- Energizing Spores (Hunterpet)
		160074,					-- Speed of the Swarm (Hunterpet)
	},
	["spellpower"] = {
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		109773,					-- Dark Intent
		128433,					-- Serpent's Cunning (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
		126309,					-- Still Water (Hunterpet)
	},
	["crit"] = {
		17007,					-- Leader of the Pack
		1459,					-- Arcane Brilliance
		61316,					-- Dalaran Brilliance
		116781,					-- Legacy of the White Tiger
		90309,					-- Terrifying Roar (Hunterpet)
		126373,					-- Fearless Roar (Hunterpet)
		160052,					-- Strength of the Pack (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		126309,					-- Still Water (Hunterpet)
		24604,					-- Furious Howl (Hunterpet)
	},
	["mastery"] = {
		155522,					-- Power of the Grave
		24907,					-- Moonkin Aura
		19740,					-- Blessing of Might
		116956,					-- Grace of Air
		93435,					-- Roar of Courage (Hunterpet)
		160039,					-- Keen Senses (Hunterpet)
		128997,					-- Spirit Beast Blessing (Hunterpet)
		160073,					-- Plainswalking (Hunterpet)
	},
	["stats"] = {
		1126, 					-- Mark of the Wild
		115921,					-- Legacy of the Emperor
		116781,					-- Legacy of the White Tiger
		20217,					-- Blessing of Kings
		159988,					-- Bark of the Wild (Hunterpet)
		160017,					-- Blessing of Kongs (Hunterpet)
		90363,					-- Embrace of the Shale Spider (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	},
	["stamina"] = {
		21562,					-- Power Word: Fortitude
		166928,					-- Blood Pact
		469,					-- Commanding Shout
		50256,					-- Invigorating Roar (Hunterpet)
		160014,					-- Sturdiness (Hunterpet)
		160003,					-- Savage Vigor (Hunterpet)
		90364,					-- Qiraji Fortitude (Hunterpet)
	},
	["multistrike"] = {
		166916,					-- Windflurry
		49868,					-- Mind Quickening
		113742,					-- Swiftblade's Cunning
		109773,					-- Dark Intent
		50519,					-- Sonic Focus (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		58604,					-- Double Bite (Hunterpet)
		34889,					-- Spry Attacks (Hunterpet)
		24844,					-- Breath of Winds (Hunterpet)
	},
	["versatility"] = {
		55610,					-- Unholy Aura
		1126,					-- Mark of the Wild
		167187,					-- Sanctity Aura
		167188,					-- Inspiring Presence
		159735,					-- Tenacity (Hunterpet)
		35290,					-- Indomitable (Hunterpet)
		57386,					-- Wild Strength (Hunterpet)
		160045,					-- Defensive Quills (Hunterpet)
		50518,					-- Chitinous Armor (Hunterpet)
		173035,					-- Grace (Hunterpet)
		160077,					-- Strength of the Earth (Hunterpet)
	},
}

local function LabelType(bufftype)
	if bufftype == "attackpower" then
		return "+ " .. RAID_BUFF_3
	elseif bufftype == "haste" then
		return "+ " .. RAID_BUFF_4
	elseif bufftype == "spellpower" then
		return "+ " .. RAID_BUFF_5
	elseif bufftype == "crit" then
		return "+ " .. RAID_BUFF_6
	elseif bufftype == "mastery" then
		return "+ " .. RAID_BUFF_7
	elseif bufftype == "stats" then
		return "+ " .. RAID_BUFF_1
	elseif bufftype == "stamina" then
		return "+ " .. RAID_BUFF_2
	elseif bufftype == "multistrike" then
		return "+ " .. RAID_BUFF_8
	elseif bufftype == "versatility" then
		return "+ " .. RAID_BUFF_9
	else
		return "ERROR"
	end
end

-- Buff Check Functions
local function AnotherOnAuraChange(self, event, arg1, unit)
	for key, value in pairs(AllBuffs) do
		for i, v in ipairs(value) do
			local spellname = select(1, GetSpellInfo(v))
			_G[key.."mini"..i].spell = v
			if UnitAura("player", spellname) then _G[key.."mini"..i]:SetAlpha(1) else _G[key.."mini"..i]:SetAlpha(0.2) end
		end

		for i, v in ipairs(value) do
			local spellname = select(1, GetSpellInfo(v))
			_G[key.."Frame"].spell = v
			if UnitAura("player", spellname) then
				_G[key.."Frame"]:SetAlpha(1)
				_G[key.."Frame"].t:SetTexture(select(3, GetSpellInfo(v)))
				break
			else
				_G[key.."Frame"]:SetAlpha(0.2)
				_G[key.."Frame"].t:SetTexture(select(3, GetSpellInfo(v)))
			end
		end
	end
end

local bufftrackersummary = CreateFrame("Frame", "BuffTrackerSummary", UIParent)
BuffTrackerSummary:Size(608, 285)
bufftrackersummary:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
bufftrackersummary:SetTemplate("Transparent")
local close = CreateFrame("Button", "BuffTrackerSummaryCloseButton", BuffTrackerSummary, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", BuffTrackerSummary, "TOPRIGHT")
close:SkinCloseButton()
close:SetScript("OnClick", function() bufftrackersummary:Hide() end)
bufftrackersummary:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
bufftrackersummary:RegisterEvent("UNIT_INVENTORY_CHANGED")
bufftrackersummary:RegisterEvent("UNIT_AURA")
bufftrackersummary:RegisterEvent("PLAYER_REGEN_ENABLED")
bufftrackersummary:RegisterEvent("PLAYER_REGEN_DISABLED")
bufftrackersummary:RegisterEvent("PLAYER_ENTERING_WORLD")
bufftrackersummary:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
bufftrackersummary:RegisterEvent("CHARACTER_POINTS_CHANGED")
bufftrackersummary:RegisterEvent("ZONE_CHANGED_NEW_AREA")
bufftrackersummary:SetScript("OnEvent", AnotherOnAuraChange)

local str = "spell:%s"
local BadTotems = {
	[8076] = 8075,
	[8972] = 8071,
	[5677] = 5675,
}
local SetupTooltip = function(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 0)

	if BadTotems[self.spell] then GameTooltip:SetHyperlink(format(str, BadTotems[self.spell])) else GameTooltip:SetHyperlink(format(str, self.spell)) end
	GameTooltip:Show()
end

local function CreateBuffArea(bufftype, relativeTo, column)
	local bigButton = CreateFrame("Frame", bufftype.."Frame", BuffTrackerSummary)
	if column == 1 then
		bigButton:Size(40, 40)
		bigButton:SetPoint("TOPLEFT", BuffTrackerSummary, "TOPLEFT", 14, -14)
		bigButton:SetTemplate("Default")
	elseif column == 2 then
		bigButton:Size(40, 40)
		bigButton:SetPoint("TOPLEFT", BuffTrackerSummary, "TOPLEFT", 300, -14)
		bigButton:SetTemplate("Default")
	else
		bigButton:Size(40, 40)
		bigButton:SetPoint("TOPLEFT", relativeTo, "BOTTOMLEFT", 0, -16)
		bigButton:SetTemplate("Default")
	end
	bigButton.t = bigButton:CreateTexture(bufftype..".t", "OVERLAY")
	bigButton.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	bigButton.t:Point("TOPLEFT", 2, -2)
	bigButton.t:Point("BOTTOMRIGHT", -2, 2)

	local littlebutton = {}
	for i, v in pairs(AllBuffs[bufftype]) do
		littlebutton[i] = CreateFrame("Frame", bufftype.."mini"..i, bufftrackersummary)
		if i == 1 then
			littlebutton[i]:Size(20, 20)
			littlebutton[i]:SetPoint("BOTTOMLEFT", bigButton, "BOTTOMRIGHT", 3, 0)
			littlebutton[i]:SetTemplate("Default")
		else
			littlebutton[i]:Size(20, 20)
			littlebutton[i]:SetPoint("LEFT", littlebutton[i-1], "RIGHT", 3, 0)
			littlebutton[i]:SetTemplate("Default")
		end
		littlebutton[i].t = littlebutton[i]:CreateTexture(nil, "OVERLAY")
		littlebutton[i].t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		littlebutton[i].t:Point("TOPLEFT", 2, -2)
		littlebutton[i].t:Point("BOTTOMRIGHT", -2, 2)
		littlebutton[i].t:SetTexture(select(3, GetSpellInfo(v)))

		littlebutton[i]:EnableMouse(true)
		littlebutton[i]:SetScript("OnEnter", SetupTooltip)
		littlebutton[i]:SetScript("OnLeave", GameTooltip_Hide)
	end
	bigButton.text = bigButton:CreateFontString(nil, "OVERLAY")
	bigButton.text:SetPoint("TOPLEFT", bigButton, "TOPRIGHT", 3, -1)
	bigButton.text:SetFont(C["media"].font, 13)
	bigButton.text:SetText(LabelType(bufftype))
	bigButton:EnableMouse(true)
	bigButton:SetScript("OnEnter", SetupTooltip)
	bigButton:SetScript("OnLeave", GameTooltip_Hide)
end

--ORDER MATTERS!
CreateBuffArea("attackpower", nil, 1)
CreateBuffArea("haste", "attackpowerFrame", nil)
CreateBuffArea("spellpower", "hasteFrame", nil)
CreateBuffArea("crit", "spellpowerFrame", nil)
CreateBuffArea("mastery", "critFrame", nil)
CreateBuffArea("stats", "critFrame", 2)
CreateBuffArea("stamina", "statsFrame", nil)
CreateBuffArea("multistrike", "staminaFrame", nil)
CreateBuffArea("versatility", "multistrikeFrame", nil)

bufftrackersummary:Hide()

local bufftracker_toggle = CreateFrame("Frame", "BuffTrackerToggle", bufftracker)
bufftracker_toggle:SetPoint("TOP", bufftracker, "BOTTOM", 0, -2)
bufftracker_toggle:SetTemplate("Default")
bufftracker_toggle:Size(bufftracker:GetWidth(), 9)
bufftracker_toggle.text = bufftracker_toggle:CreateFontString(nil, "OVERLAY")
bufftracker_toggle.text:SetFont(C["media"].font, 11, "THINOUTLINE")
bufftracker_toggle.text:SetText("|cff319f1b+|r")
bufftracker_toggle.text:SetPoint("CENTER")

-- Fix design bug for mini-button with 1280/1600 res and uiscale 1.0
if ((D.ScreenWidth == 1280 or D.ScreenWidth == 1600) and C["general"].uiscale == 1) then
	if D.ScreenWidth == 1600 then
		bufftracker_toggle:Size(bufftracker:GetWidth(), 8.5)
		bufftracker_toggle.text:SetPoint("CENTER", bufftracker_toggle, "CENTER", 1, 0.3)
	elseif D.ScreenWidth == 1280 then
		bufftracker_toggle:Size(bufftracker:GetWidth(), 10)
		bufftracker_toggle.text:SetPoint("CENTER", bufftracker_toggle, "CENTER", 1, -1)
	end
end

local function ToggleBuffTracker()
	if bufftrackersummary:IsShown() then
		bufftrackersummary:Hide()
		bufftracker_toggle.text:SetText("|cff319f1b+|r")
	else
		bufftrackersummary:Show()
		bufftracker_toggle.text:SetText("|cff9a1212-|r")
		bufftracker_toggle:SetScript("OnEnter", nil)
		bufftracker_toggle:SetScript("OnLeave", nil)
	end
end
bufftracker_toggle:SetScript("OnMouseDown", ToggleBuffTracker)

--[[Combatrez display]]--
--[[local rebirth = 20484

local f = CreateFrame("Button", "BRButton", UIParent, "ActionButtonTemplate")
f:RegisterEvent("ADDON_LOADED")
f:SetMovable(true)
f:SetScript("OnMouseDown", function(self) self:StartMoving() end)
f:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
f:SetScript("OnLeave", function() GameTooltip:Hide() end)
f:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
	GameTooltip:ClearLines()
	GameTooltip:SetSpellByID(rebirth)
	GameTooltip:Show()
end)

_G[format("%sCooldown", f:GetName())]:SetReverse(true)

function f:Reset()
	self:SetSize(36, 36)
	self:SetPoint("CENTER")
	self:SetAttribute("type", "spell")
	self:SetAttribute("spell", rebirth)
	local spellInfo = {GetSpellInfo(rebirth)}
	_G[format("%sIcon", self:GetName())]:SetTexture(spellInfo[3])
	spellInfo = nil
end

function f:Update()
	local currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(rebirth)
	if not currentCharges then
		self:Hide()
	else
		if(cooldownStart) then CooldownFrame_SetTimer(_G[format("%sCooldown", self:GetName())], cooldownStart, cooldownDuration, 1) else CooldownFrame_SetTimer(_G[format("%sCooldown", self:GetName())], 0, 0, 0) end
		_G[format("%sCount", self:GetName())]:SetText(currentCharges and currentCharges or 0)
		self:Show()
	end
end

f:SetScript("OnEvent", function(self, event, arg1,...)
	if (event=="ADDON_LOADED" and name==arg1) then
		self:UnregisterEvent(event)
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:Reset()
	elseif event=="PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("SPELL_UPDATE_CHARGES")
	elseif event=="PLAYER_REGEN_DISABLED" then
		self:RegisterEvent("SPELL_UPDATE_CHARGES")
	end
	self:Update()
end)]]
