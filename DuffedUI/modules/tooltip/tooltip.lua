local D, C, L = select(2, ...):unpack()
if not C["tooltips"].Enable then return end

local _G = _G
local unpack = unpack
local Colors = D.Colors
local RaidColors = RAID_CLASS_COLORS
local DuffedUITooltips = CreateFrame("Frame")
local gsub, find, format = string.gsub, string.find, string.format
local Noop = function() end
local Panels = D["Panels"]
local HealthBar = GameTooltipStatusBar
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
local PVP_ENABLED = PVP_ENABLED
local Insets = C["general"].InOut
local BackdropColor = {0, 0, 0}

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
	WorldBoss = "|cffAF5050Boss|r",
	RareElite = "|cffAF5050+ Rare|r",
	Elite = "|cffAF5050+|r",
	Rare = "|cffAF5050Rare|r",
}

function DuffedUITooltips:CreateAnchor()
	local DataTextRight = Panels.DataTextRight
	local RightChatBackground = Panels.RightChatBackground
	
	self.Anchor = CreateFrame("Frame", nil, UIParent)
	self.Anchor:Size(200, DataTextRight:GetHeight() - 4)
	self.Anchor:SetFrameStrata("TOOLTIP")
	self.Anchor:SetFrameLevel(20)
	self.Anchor:SetClampedToScreen(true)
	if C["chat"].rBackground then self.Anchor:SetPoint("TOPRIGHT", RightChatBackground, 0, -15) else self.Anchor:SetPoint("BOTTOMRIGHT", DataTextRight, 0, 2) end
	self.Anchor:SetMovable(true)
	self.Anchor:CreateBackdrop()
	self.Anchor.Backdrop:SetBackdropBorderColor(1, 0, 0, 1)
	self.Anchor.Backdrop:FontString("Text", C["medias"].AltFont, 12)
	self.Anchor.Backdrop.Text:SetPoint("CENTER")
	self.Anchor.Backdrop.Text:SetText(L.Tooltips.MoveAnchor)
	self.Anchor.Backdrop:Hide()
end

function DuffedUITooltips:SetTooltipDefaultAnchor()
	local Anchor = DuffedUITooltips.Anchor
	
	self:SetOwner(Anchor)
	self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 20)
end

function DuffedUITooltips:GetColor(unit)
	if (not unit) then
		return
	end

	if (UnitIsPlayer(unit) and not UnitHasVehicleUI(unit)) then
		local Class = select(2, UnitClass(unit))
		local Color = RaidColors[Class]
		
		if (not Color) then
			return
		end
		
		return "|c"..Color.colorStr, Color.r, Color.g, Color.b	
	else
		local Reaction = UnitReaction(unit, "player")
		local Color = Colors.reaction[Reaction]
		
		if not Color then
			return
		end
		
		local Hex = D.RGBToHex(unpack(Color))
		
		return Hex, Color.r, Color.g, Color.b		
	end
end

function DuffedUITooltips:OnTooltipSetUnit()
	local NumLines = self:NumLines()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))
	
	if (not Unit) and (UnitExists("mouseover")) then
		Unit = "mouseover"
	end
	
	if (not Unit) then 
		self:Hide() 
		return
	end
	
	if (self:GetOwner() ~= UIParent and C["tooltips"].HideOnUnitFrames) then
		self:Hide()
		return
	end
	
	if (UnitIsUnit(Unit, "mouseover")) then
		Unit = "mouseover"
	end

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
	local Health = UnitHealth(Unit)
	local MaxHealth = UnitHealth(Unit)
	
	if (not Color) then
		Color = "|CFFFFFFFF"
	end
	
	if (Title or Name) then
		if Realm then
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), Realm and Realm ~= "" and " - ".. Realm .."|r" or "|r")
		else
			Line1:SetFormattedText("%s%s%s", Color, (Title or Name), "|r")
		end
	end

	if (UnitIsPlayer(Unit)) then
		if (UnitIsAFK(Unit)) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(Unit) then 
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end

		local Offset = 2
		if Guild then
			local guildName, guildRankName, guildRankIndex = GetGuildInfo(Unit)
			Line2:SetFormattedText("%s [%s]", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r", "|cffFFD700"..guildRankName.."|r") 
			Offset = Offset + 1
		end

		for i = Offset, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if (Line:GetText():find("^" .. LEVEL)) then
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
			if ((Line:GetText():find("^" .. LEVEL)) or (CreatureType and Line:GetText():find("^" .. CreatureType))) then
				if Level == -1 and Classification == "elite" then
					Classification = "worldboss"
				end
				
				Line:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", R * 255, G * 255, B * 255, Classification ~= "worldboss" and Level ~= 0 and Level or "", DuffedUITooltips.Classification[Classification] or "", CreatureType or "")
				break
			end
		end
	end

	for i = 1, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		local Text = Line:GetText()
		if (Text and Text == PVP_ENABLED) then
			Line:SetText()
			break
		end
	end

	if (UnitExists(Unit .. "target") and Unit ~= "player") then
		local hex, R, G, B = DuffedUITooltips:GetColor(Unit)
		
		if (not R) and (not G) and (not B) then
			R, G, B = 1, 1, 1
		end
		
		GameTooltip:AddLine(UnitName(Unit .. "target"), R, G, B)
	end
	
	HealthBar.Text:SetText(D.ShortValue(Health) .. " / " .. D.ShortValue(MaxHealth))
	
	self.fadeOut = nil
end

function DuffedUITooltips:SetColor()
	local GetMouseFocus = GetMouseFocus()
	local Unit = (select(2, self:GetUnit())) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))
	local Reaction = Unit and UnitReaction(Unit, "player")
	local Player = Unit and UnitIsPlayer(Unit)
	local Tapped = Unit and UnitIsTapped(Unit)
	local PlayerTapped = Unit and UnitIsTappedByPlayer(Unit)
	local Connected = Unit and UnitIsConnected(Unit)
	local Dead = Unit and UnitIsDead(Unit)
	local R, G, B
	
	self:SetBackdropColor(unpack(C["general"].BackdropColor))
	self:SetBackdropBorderColor(0, 0, 0)
	
	if Player then
		local Class = select(2, UnitClass(Unit))
		local Color = Colors.class[Class]
		R, G, B = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(R, G, B)

		if (Insets) then
			self:SetBackdropBorderColor(R, G, B)
			HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
		end
	elseif Reaction then
		local Color = Colors.reaction[Reaction]
		R, G, B = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(R, G, B)
		
		if (Insets) then
			self:SetBackdropBorderColor(R, G, B)
			HealthBar.Backdrop:SetBackdropBorderColor(R, G, B)
		end
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))
		if (Quality and Quality >= 2) then
			R, G, B = GetItemQualityColor(Quality)
			
			if Insets then
				self:SetBackdropBorderColor(R, G, B)
			end
		else
			HealthBar:SetStatusBarColor(unpack(C["general"].BorderColor))
			
			if Insets then
				self:SetBackdropBorderColor(unpack(C["general"].BorderColor))
				HealthBar.Backdrop:SetBackdropBorderColor(unpack(C["general"].BorderColor))
			end
		end
	end
end

function DuffedUITooltips:OnUpdate(elapsed)
	local Red, Green, Blue = self:GetBackdropColor()
	local Owner = self:GetOwner():GetName()
	local Anchor = self:GetAnchorType()

	-- This ensures that default anchored world frame tips have the proper color.
	if (Owner == "UIParent" and Anchor == "ANCHOR_CURSOR") and (Red ~= BackdropColor[1] or Green ~= BackdropColor[2] or Blue ~= BackdropColor[3]) then
		BackdropColor[1] = Red
		BackdropColor[2] = Green
		BackdropColor[3] = Blue
		self:SetBackdropColor(unpack(C["general"].BackdropColor))
		self:SetBackdropBorderColor(unpack(C["general"].BorderColor))
	end
end

function DuffedUITooltips:Skin()
	if not self.IsSkinned then
		self:SetTemplate("Transparent")
		self.IsSkinned = true
	end

	DuffedUITooltips.SetColor(self)
end

function DuffedUITooltips:OnValueChanged()
	local _, max = HealthBar:GetMinMaxValues()
	local value = HealthBar:GetValue()

	self.Text:SetText(D.ShortValue(value) .. " / " .. D.ShortValue(max))

	return
end

local hex = function(color)
	return (color.r and format('|cff%02x%02x%02x', color.r * 255, color.g * 255, color.b * 255)) or "|cffFFFFFF"
end

local nilcolor = { r=1, g=1, b=1 }
local tapped = { r=.6, g=.6, b=.6 }

local function unitColor(unit)
	if (not unit) then unit = "mouseover" end

	local color
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		color = RAID_CLASS_COLORS[class]
	elseif (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
		color = tapped
	else
		local reaction = UnitReaction(unit, "player")
		if reaction then
			color = FACTION_BAR_COLORS[reaction]
		end
	end

	return (color or nilcolor)
end

local function addAuraInfo(self, caster, spellID)
	if (C["tooltips"].EnableCaster and caster) then
		local color = unitColor(caster)
		if color then
			color = hex(color)
		else
			color = ""
		end

		GameTooltip:AddLine("Applied by "..color..UnitName(caster))
		GameTooltip:Show()
	end
end

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local _,_,_,_,_,_,_, caster,_,_, spellID = UnitAura(...)
	addAuraInfo(self, caster, spellID)
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local _,_,_,_,_,_,_, caster,_,_, spellID = UnitBuff(...)
	addAuraInfo(self, caster, spellID)
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local _,_,_,_,_,_,_, caster,_,_, spellID = UnitDebuff(...)
	addAuraInfo(self, caster, spellID)
end)

DuffedUITooltips:RegisterEvent("ADDON_LOADED")
DuffedUITooltips:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "DuffedUI") then return end
	
	self:CreateAnchor()
	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)

	for _, Tooltip in pairs(DuffedUITooltips.Tooltips) do
		if Tooltip == GameTooltip then
			Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
			Tooltip:HookScript("OnUpdate", self.OnUpdate)
		end
		
		Tooltip:HookScript("OnShow", self.Skin)
	end
	
	HealthBar:SetStatusBarTexture(C["medias"].Normal)
	HealthBar:CreateBackdrop()
	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
	HealthBar.Text = HealthBar:CreateFontString(nil, "OVERLAY")
	HealthBar.Text:SetFont(C["medias"].Font, 12, "THINOULINE")
	HealthBar.Text:SetShadowColor(0, 0, 0)
	HealthBar.Text:SetShadowOffset(1.25, -1.25)
	HealthBar.Text:Point("CENTER", HealthBar, 0, 6)
	HealthBar:ClearAllPoints()
	HealthBar:Point("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 2, 5)
	HealthBar:Point("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", -2, 5)
end)

D["Tooltips"] = DuffedUITooltips