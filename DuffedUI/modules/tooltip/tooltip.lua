--[[Modified Script from Tukui T16 Credits goes to Tukz & Hydra]]--
local D, C, L = unpack(select(2, ...))
if not C["tooltip"].enable then return end

local _G = _G
local unpack = unpack
local Colors = D.UnitColor
local RaidColors = RAID_CLASS_COLORS
local DuffedUITooltips = CreateFrame("Frame")
local gsub, find, format = string.gsub, string.find, string.format
local HealthBar = GameTooltipStatusBar
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
local PVP_ENABLED = PVP_ENABLED
local move = D["move"]

DuffedUITooltips.ItemRefTooltip = ItemRefTooltip

DuffedUITooltips.Tooltips = {
	GameTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	ItemRefTooltip,
}

DuffedUITooltips.Classification = {
	worldboss = "|cffAF5050Boss|r",
	rareelite = "|cffAF5050+ Rare|r",
	elite = "|cffAF5050+|r",
	rare = "|cffAF5050Rare|r",
}

local Anchor = CreateFrame("Frame", "DuffedUITooltipMover", UIParent)
Anchor:SetSize(200, DuffedUIInfoRight:GetHeight())
Anchor:SetFrameStrata("TOOLTIP")
Anchor:SetFrameLevel(20)
if C["chat"].rbackground and DuffedUIChatBackgroundRight then
	Anchor:SetPoint("BOTTOMRIGHT", DuffedUIChatBackgroundRight, "TOPRIGHT", 0, -DuffedUIInfoRight:GetHeight())
else
	Anchor:SetPoint("BOTTOMRIGHT", UIParent, 0, 110)
end
move:RegisterFrame(Anchor)

function DuffedUITooltips:SetTooltipDefaultAnchor()
	local Anchor = DuffedUITooltipMover

	self:SetOwner(Anchor)
	if C["tooltip"].Mouse then self:SetAnchorType("ANCHOR_CURSOR", 0, 5) else self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 5) end
	if (self:GetOwner() ~= UIParent and InCombatLockdown() and C["tooltip"].hidecombat) then
		self:Hide()
		return
	end
end

function DuffedUITooltips:GetColor(unit)
	if (not unit) then return end

	if (UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local Class = select(2, UnitClass(unit))
		local Color = RaidColors[Class]

		if (not Color) then return end
		return "|c"..Color.colorStr, Color.r, Color.g, Color.b
	else
		local Reaction = UnitReaction(unit, "player")
		local Color = Colors.reaction[Reaction]

		if not Color then return end
		local Hex = D.RGBToHex(unpack(Color))
		return Hex, Color.r, Color.g, Color.b
	end
end

function DuffedUITooltips:OnTooltipSetUnit()
	local NumLines = self:NumLines()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))

	if (not Unit) and (UnitExists("mouseover")) then Unit = "mouseover" end
	if (not Unit) then self:Hide() return end
	if (self:GetOwner() ~= UIParent and C["tooltip"].hideuf) then
		self:Hide()
		return
	end
	if (UnitIsUnit(Unit, "mouseover")) then Unit = "mouseover" end

	local Line1 = GameTooltipTextLeft1
	local Line2 = GameTooltipTextLeft2
	local Race = UnitRace(Unit)
	local Class = UnitClass(Unit)
	local Level = UnitLevel(Unit)
	local Guild = GetGuildInfo(Unit)
	local Name, Realm = UnitName(Unit)
	local CreatureType = UnitCreatureType(Unit)
	local Classification = UnitClassification(Unit)
	local Title = UnitPVPName(Unit)
	local R, G, B = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b
	local Color = DuffedUITooltips:GetColor(Unit)

	if not Color then Color = "|CFFFFFFFF" end
	if Title or Name then
		if Realm then
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), Realm and Realm ~= "" and " - ".. Realm .."|r" or "|r")
		else
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), "|r")
		end
	end

	if UnitIsPlayer(Unit) then
		if (UnitIsAFK(Unit)) then self:AppendText((" %s"):format(CHAT_FLAG_AFK)) elseif UnitIsDND(Unit) then  self:AppendText((" %s"):format(CHAT_FLAG_DND)) end

		local Offset = 2
		if Guild then
			local guildName, guildRankName, guildRankIndex = GetGuildInfo(Unit)
			Line2:SetFormattedText("%s [%s]", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r", "|cffFFD700"..guildRankName.."|r") 
			Offset = Offset + 1
		end

		for i = Offset, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if Line:GetText():find("^" .. LEVEL) then
				if Race then
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Race, Color, Class .."|r")
				else
					Line:SetFormattedText("|cff%02x%02x%02x%s|r %s%s", R * 255, G * 255, B * 255, Level > 0 and Level or "??", Color, Class .."|r")
				end
				break
			end
		end
	else
		for i = 2, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if Line:GetText():find("^" .. LEVEL) or (CreatureType and Line:GetText():find("^" .. CreatureType)) then
				if Level == -1 and Classification == "elite" then Classification = "worldboss" end
				Line:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", R * 255, G * 255, B * 255, Classification ~= "worldboss" and Level ~= 0 and Level or "", DuffedUITooltips.Classification[Classification] or "", CreatureType or "")
				break
			end
		end
	end

	for i = 1, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		if Line:GetText() and Text == PVP_ENABLED then
			_G["GameTooltipTextLeft"..i]:SetText()
			break
		end
	end

	if (UnitExists(Unit .. "target") and Unit ~= "player") then
		local Hex, R, G, B = DuffedUITooltips:GetColor(Unit .. "target")

		if (not R) and (not G) and (not B) then R, G, B = 1, 1, 1 end
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end
	self.fadeOut = nil
end

function DuffedUITooltips:SetColor()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))

	if (not Unit) and (UnitExists("mouseover")) then Unit = "mouseover" end

	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Tapped = Unit and UnitIsTapped(Unit)
	local PlayerTapped = Unit and UnitIsTappedByPlayer(Unit)
	local QuestMOB = Unit and UnitIsTappedByAllThreatList(Unit)
	local Connected = Unit and UnitIsConnected(Unit)
	local Dead = Unit and UnitIsDead(Unit)
	local R, G, B

	self:SetBackdropBorderColor(unpack(C["general"].bordercolor))
	if Player then
		local Class = select(2, UnitClass(Unit))
		local Color = Colors.class[Class]
		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.backdrop:SetBackdropBorderColor(R, G, B)
		self:SetTemplate("Transparent")
		self:SetBackdropBorderColor(R, G, B)
	elseif Reaction then
		local Color = Colors.reaction[Reaction]
		R, G, B = Color[1], Color[2], Color[3]
		HealthBar:SetStatusBarColor(R, G, B)
		HealthBar.backdrop:SetBackdropBorderColor(R, G, B)
		self:SetTemplate("Transparent")
		self:SetBackdropBorderColor(R, G, B)
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))
		if (Quality and Quality >= 2) then 
			R, G, B = GetItemQualityColor(Quality)
			self:SetTemplate("Transparent")
			self:SetBackdropBorderColor(R, G, B)
		else
			HealthBar:SetStatusBarColor(unpack(C["general"].bordercolor))
			self:SetTemplate("Transparent")
		end
	end
end

function DuffedUITooltips:OnUpdate(elapsed)
	local Owner = self:GetOwner()
	if not Owner then return end
	if Owner:IsForbidden() then return end

	local Red, Green, Blue = self:GetBackdropColor()
	local Owner = self:GetOwner():GetName()
	local Anchor = self:GetAnchorType()

	if (Owner == "UIParent" and Anchor == "ANCHOR_CURSOR") and (Red ~= BackdropColor[1] or Green ~= BackdropColor[2] or Blue ~= BackdropColor[3]) then
		BackdropColor[1] = Red
		BackdropColor[2] = Green
		BackdropColor[3] = Blue
		self:SetBackdropColor(unpack(C["general"].backdropcolor))
		self:SetBackdropBorderColor(unpack(C["General"].bordercolor))
	end
end

function DuffedUITooltips:Skin()
	if not self.IsSkinned then
		self:SetTemplate("Transparent")
		self.IsSkinned = true
	end
	DuffedUITooltips.SetColor(self)
end

function DuffedUITooltips:OnValueChanged(value)
	if not value then return end
	local min, max = self:GetMinMaxValues()

	if (value < min) or (value > max) then return end
	local _, unit = GameTooltip:GetUnit()

	if not unit then
		local GMF = GetMouseFocus()
		unit = GMF and GMF:GetAttribute("unit")
	end

	if not self.text then
		self.text = self:CreateFontString(nil, "OVERLAY")
		local position = DuffedUITooltipMover:GetPoint()
		if position:match("TOP") then self.text:Point("CENTER", GameTooltipStatusBar, 0, -6) else self.text:Point("CENTER", GameTooltipStatusBar, 0, 6) end

		self.text:SetFont(C["media"].font, 12, "THINOUTLINE")
		self.text:Show()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			local hp = D.ShortValue(min) .. " / " .. D.ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText(L["uf"]["ghost"])
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText(L["uf"]["dead"])
			else
				self.text:SetText(hp)
			end
		end
	else
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			self.text:Show()
			local hp = D.ShortValue(min) .. " / " .. D.ShortValue(max)
			if UnitIsGhost(unit) then
				self.text:SetText(L["uf"]["ghost"])
			elseif min == 0 or UnitIsDead(unit) or UnitIsGhost(unit) then
				self.text:SetText(L["uf"]["dead"])
			else
				self.text:SetText(hp)
			end
		else
			self.text:Hide()
		end
	end
	return
end

local hex = function(color) return (color.r and format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)) or "|cffFFFFFF" end

local nilcolor = {1, 1, 1}
local tapped = {.6, .6, .6}

local function unitColor(unit)
	if (not unit) then unit = "mouseover" end

	local color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = RAID_CLASS_COLORS[class]
	elseif (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) and not UnitIsTappedByAllThreatList(Unit) then
		color = tapped
	else
		local reaction = UnitReaction(unit, "player")
		if reaction then color = FACTION_BAR_COLORS[reaction] end
	end
	return (color or nilcolor)
end

local function addAuraInfo(self, caster, spellID)
	if (C["tooltip"].enablecaster and caster) then
		local color = unitColor(caster)
		if color then color = hex(color) else color = "" end
		GameTooltip:AddLine("Applied by "..color..UnitName(caster))
		GameTooltip:Show()
	end
end

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local _, _, _, _, _, _, _, caster, _, _, spellID = UnitAura(...)
	addAuraInfo(self, caster, spellID)
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local _, _, _, _, _, _, _, caster, _, _, spellID = UnitBuff(...)
	addAuraInfo(self, caster, spellID)
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local _, _, _, _, _, _, _, caster, _, _, spellID = UnitDebuff(...)
	addAuraInfo(self, caster, spellID)
end)

DuffedUITooltips:RegisterEvent("PLAYER_ENTERING_WORLD")
DuffedUITooltips:RegisterEvent("ADDON_LOADED")
DuffedUITooltips:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_ENTERING_WORLD" then
		hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)
		ItemRefCloseButton:SkinCloseButton()

		for _, Tooltip in pairs(DuffedUITooltips.Tooltips) do Tooltip:HookScript("OnShow", self.Skin) end

		if C["tooltip"].hidebuttons == true then
			local CombatHideActionButtonsTooltip = function(self)
				if not IsShiftKeyDown() then self:Hide() end
			end
			hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
			hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
			hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
		end
		if FriendsTooltip then FriendsTooltip:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end) end

		HealthBar:SetStatusBarTexture(C["media"].normTex)
		HealthBar:CreateBackdrop()
		HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
		HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
		HealthBar.Text:SetFont(C["media"].font, 11, "THINOULINE")
		HealthBar.Text:SetShadowColor(0, 0, 0)
		HealthBar.Text:SetShadowOffset(1.25, -1.25)
		HealthBar.Text:Point("CENTER", HealthBar, 0, 6)
		HealthBar:ClearAllPoints()
		HealthBar:Point("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 2, 5)
		HealthBar:Point("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", -2, 5)

		for _, Tooltip in pairs(DuffedUITooltips.Tooltips) do
			DuffedUITooltips:UnregisterEvent("PLAYER_ENTERING_WORLD")
			if Tooltip == GameTooltip then Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit) end
		end
	else
		if addon ~= "Blizzard_DebugTools" then return end
		if FrameStackTooltip then
			FrameStackTooltip:SetScale(C["general"].uiscale)
			FrameStackTooltip:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end)
		end

		if EventTraceTooltip then EventTraceTooltip:HookScript("OnShow", function(self) self:SetTemplate("Transparent") end) end
	end
end)