local T, C, L = select(2, ...):unpack()

if not C.Tooltips.Enable then
	return
end

local _G = _G
local unpack = unpack
local Colors = T.Colors
local DuffedUITooltips = CreateFrame("Frame")
local gsub, find, format = string.gsub, string.find, string.format
local Noop = function() end
local Panels = T["Panels"]
local HealthBar = GameTooltipStatusBar
local CHAT_FLAG_AFK = CHAT_FLAG_AFK
local CHAT_FLAG_DND = CHAT_FLAG_DND
local LEVEL = LEVEL
local PVP_ENABLED = PVP_ENABLED
local Insets = C.General.InOut
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
}

DuffedUITooltips.Classification = {
	WorldBoss = "|cffAF5050Boss|r",
	RareElite = "|cffAF5050+ Rare|r",
	Elite = "|cffAF5050+|r",
	Rare = "|cffAF5050Rare|r",
}

function DuffedUITooltips:CreateAnchor()
	local DataTextRight = Panels.DataTextRight
	
	self.Anchor = CreateFrame("Frame", nil, UIParent)
	self.Anchor:Size(200, DataTextRight:GetHeight() - 4)
	self.Anchor:SetFrameStrata("TOOLTIP")
	self.Anchor:SetFrameLevel(20)
	self.Anchor:SetClampedToScreen(true)
	self.Anchor:SetPoint("BOTTOMRIGHT", DataTextRight, 0, 2)
	self.Anchor:SetMovable(true)
	self.Anchor:CreateBackdrop()
	self.Anchor.Backdrop:SetBackdropBorderColor(1, 0, 0, 1)
	self.Anchor.Backdrop:FontString("Text", C.Medias.AltFont, 12)
	self.Anchor.Backdrop.Text:SetPoint("CENTER")
	self.Anchor.Backdrop.Text:SetText(L.Tooltips.MoveAnchor)
	self.Anchor.Backdrop:Hide()
end

function DuffedUITooltips:SetTooltipDefaultAnchor()
	local Anchor = DuffedUITooltips.Anchor
	
	self:SetOwner(Anchor)
	self:SetAnchorType("ANCHOR_TOPRIGHT", 0, 20)
end


function DuffedUITooltips:GetColor()
	if not self then
		return
	end

	if (UnitIsPlayer(self) and not UnitHasVehicleUI(self)) then
		local Class = select(2, UnitClass(self))
		local Color = Colors.class[Class]
		
		if not Color then
			return
		end
		
		local Hex = T.RGBToHex(unpack(Color))
		
		return Hex, Color.r, Color.g, Color.b	
	else
		local Reaction = UnitReaction(self, "player")
		local Color = Colors.reaction[Reaction]
		
		if not Color then
			return
		end
		
		local Hex = T.RGBToHex(unpack(Color))
		
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
	
	if (self:GetOwner() ~= UIParent and C.Tooltips.HideOnUnitFrames) then
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
	local r, g, b = GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b
	local Color = DuffedUITooltips.GetColor(Unit)	
	
	if not Color then
		Color = "|CFFFFFFFF"
	end
	
	if Title or Name then
		Line1:SetFormattedText("%s%s%s", Color, Title or Name, Realm and Realm ~= "" and " - ".. Realm .."|r" or "|r")
	end

	if (UnitIsPlayer(Unit)) then
		if (UnitIsAFK(Unit)) then
			self:AppendText((" %s"):format(CHAT_FLAG_AFK))
		elseif UnitIsDND(Unit) then 
			self:AppendText((" %s"):format(CHAT_FLAG_DND))
		end

		local Offset = 2
		if Guild then
			Line2:SetFormattedText("%s", IsInGuild() and GetGuildInfo("player") == Guild and "|cff0090ff".. Guild .."|r" or "|cff00ff10".. Guild .."|r")
			Offset = Offset + 1
		end

		for i = Offset, NumLines do
			local Line = _G["GameTooltipTextLeft"..i]
			if (Line:GetText():find("^" .. LEVEL)) then
				Line:SetFormattedText("|cff%02x%02x%02x%s|r %s %s%s", r*255, g*255, b*255, Level > 0 and Level or "??", Race, Color, Class .."|r")
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
				
				Line:SetFormattedText("|cff%02x%02x%02x%s|r%s %s", r*255, g*255, b*255, Classification ~= "worldboss" and Level ~= 0 and Level or "", DuffedUITooltips.Classification[Classification] or "", CreatureType or "")
				break
			end
		end
	end

	for i = 1, NumLines do
		local Line = _G["GameTooltipTextLeft"..i]
		local Text = Line:GetText()
		if Text and Text == PVP_ENABLED then
			Line:SetText()
			break
		end
	end

	if (UnitExists(Unit .. "target") and Unit ~= "player") then
		local hex, r, g, b = DuffedUITooltips.GetColor(Unit)
		
		if (not r) and (not g) and (not b) then
			r, g, b = 1, 1, 1
		end
		
		GameTooltip:AddLine(UnitName(Unit .. "target"), r, g, b)
	end
	
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
	local r, g, b
	
	self:SetBackdropColor(unpack(C.Medias.BackdropColor))
	self:SetBackdropBorderColor(0, 0, 0)
	
	if Player then
		local Class = select(2, UnitClass(Unit))
		local Color = Colors.class[Class]
		r, g, b = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(r, g, b)

		if (Insets) then
			self:SetBackdropBorderColor(r, g, b)
			HealthBar.Backdrop:SetBackdropBorderColor(r, g, b)
		end
	elseif Reaction then
		local Color = Colors.reaction[Reaction]
		r, g, b = Color[1], Color[2], Color[3]
		
		HealthBar:SetStatusBarColor(r, g, b)
		
		if (Insets) then
			self:SetBackdropBorderColor(r, g, b)
			HealthBar.Backdrop:SetBackdropBorderColor(r, g, b)
		end
	else
		local Link = select(2, self:GetItem())
		local Quality = Link and select(3, GetItemInfo(Link))
		if Quality and Quality >= 2 then
			r, g, b = GetItemQualityColor(Quality)
			
			if (Insets) then
				self:SetBackdropBorderColor(r, g, b)
			end
		else
			HealthBar:SetStatusBarColor(unpack(C.Medias.BorderColor))
			
			if (Insets) then
				self:SetBackdropBorderColor(unpack(C.Medias.BorderColor))
				HealthBar.Backdrop:SetBackdropBorderColor(unpack(C.Medias.BorderColor))
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
		self:SetBackdropColor(unpack(C.Medias.BackdropColor))
		self:SetBackdropBorderColor(unpack(C.Medias.BorderColor))
	end
end

function DuffedUITooltips:Skin()
	if not self.IsSkinned then
		self:SetTemplate()
		self.IsSkinned = true
	end

	DuffedUITooltips.SetColor(self)
end

function DuffedUITooltips:OnTooltipSetItem()
	if (IsShiftKeyDown() or IsAltKeyDown()) then
		local Item, Link = self:GetItem()
		local ItemCount = GetItemCount(Link)
		local ID = "|cFFCA3C3CID|r "..Link:match(":(%w+)")
		local Count = "|cFFCA3C3C"..TOTAL.."|r "..ItemCount
				
		self:AddLine(" ")
		self:AddDoubleLine(Link and Link ~= nil and ID, ItemCount and ItemCount > 1 and Count)
	end
end

function DuffedUITooltips:OnValueChanged()
	return
end

DuffedUITooltips:RegisterEvent("ADDON_LOADED")
DuffedUITooltips:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then
		return
	end
	
	self:CreateAnchor()
	hooksecurefunc("GameTooltip_SetDefaultAnchor", self.SetTooltipDefaultAnchor)

	for _, Tooltip in pairs(DuffedUITooltips.Tooltips) do
		if Tooltip == GameTooltip then
			Tooltip:HookScript("OnTooltipSetUnit", self.OnTooltipSetUnit)
			Tooltip:HookScript("OnUpdate", self.OnUpdate)
			Tooltip:HookScript("OnTooltipSetItem", self.OnTooltipSetItem)
		end
		
		Tooltip:HookScript("OnShow", self.Skin)
	end
	
	HealthBar:SetStatusBarTexture(C.Medias.Normal)
	HealthBar:CreateBackdrop()
	HealthBar:SetScript("OnValueChanged", self.OnValueChanged)
end)

T["Tooltips"] = DuffedUITooltips