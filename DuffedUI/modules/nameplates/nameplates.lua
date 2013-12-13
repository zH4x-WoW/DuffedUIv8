local D, C, L = select(2, ...):unpack()

if not C.NamePlates.Enable then
	return
end

local _G = _G
local unpack = unpack
local find, match = find, match
local Hider = T["Panels"].Hider
local WorldFrame = WorldFrame
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local Colors = T["Colors"]
local Convert = T.RGBToHex
local Scale = T.Scale
local FrameNumber = 0

local Plates = CreateFrame("Frame", nil, WorldFrame)

function Plates:GetColor()
	local Red, Green, Blue = self.Health:GetStatusBarColor()
	
	for Class, Color in pairs(RAID_CLASS_COLORS) do
		local r, g, b = floor(Red * 100 + .5) / 100, floor(Green * 100 + .5) / 100, floor(Blue * 100 + .5) / 100
		
		if RAID_CLASS_COLORS[Class].r == r and RAID_CLASS_COLORS[Class].g == g and RAID_CLASS_COLORS[Class].b == b then
			Red, Green, Blue = unpack(Colors.class[Class])
			
			self.IsClass = true
			self.IsFriend = false
			self.Class = Class
			
			return Red, Green, Blue
		end
	end
	
	if (Green + Blue == 0) then
		-- Hostile Health
		Red, Green, Blue = unpack(Colors.reaction[2])
		self.IsFriend = false
	elseif (Red + Blue) == 0 then
		-- Friendly NPC
		Red, Green, Blue = unpack(Colors.reaction[5])
		self.IsFriend  = true
	elseif (Red + Green) > 1.95 then
		-- Neutral NPC
		Red, Green, Blue = unpack(Colors.reaction[4])
		self.IsFriend  = false
	elseif (Red + Green) == 0 then
		-- Friendly Player
		Red, Green, Blue = unpack(Colors.reaction[5])
		self.IsFriend  = true
	else
		self.IsFriend = false
	end
	
	self.IsClass = false
	self.Class = nil
	
	return Red, Green, Blue
end

function Plates:CastOnShow()
	local NewPlate = self:GetParent()
	local Height = Plates.PlateCastHeight
	local Red, Blue, Green = self:GetStatusBarColor()

	self:ClearAllPoints()
	self:SetPoint("TOP", NewPlate, 0, -Plates.PlateSpacing - Plates.PlateHeight)
	self:SetPoint("LEFT", NewPlate)
	self:SetPoint("RIGHT", NewPlate)
	self:SetHeight(Height)
	
	self.Background:SetTexture(Red * .15, Blue * .15, Green * .15)

	self.Icon:ClearAllPoints()
	self.Icon:SetPoint("RIGHT", NewPlate, "LEFT", -Plates.PlateSpacing, 0)
end

function Plates:OnShow()
	local Name = self.Name:GetText() or "Unknown"
	local Level = self.Level:GetText() or ""
	local Red, Green, Blue = Plates.GetColor(self)
	local LevelRed, LevelGreen, LevelBlue = self.Level:GetTextColor()
	local Hex = Convert(LevelRed, LevelGreen, LevelBlue)
	local Boss, Dragon = self.Boss, self.Dragon
	local Threat = self.Threat
	
	self.Health:ClearAllPoints()
	self.Health:SetPoint("TOP", self.NewPlate)
	self.Health:SetPoint("LEFT", self.NewPlate)
	self.Health:SetPoint("RIGHT", self.NewPlate)
	self.Health:SetHeight(Plates.PlateHeight)
	self.Health.NewTexture:SetVertexColor(Red, Green, Blue)
	self.Health.Background:SetTexture(Red * .15, Green * .15, Blue * .15)
	
	if Boss:IsShown() then
		Level = "??"
	elseif Dragon:IsShown() then
		Level = Level .. "+"
	end
	
	if Threat:IsShown() then
		-- need a good looking idea, was thinking about Shadow:SetBackdropBorderColor(x, x, x) but it doesn't look good. :X 
	else
		-- need a good looking idea, was thinking about Shadow:SetBackdropBorderColor(x, x, x) but it doesn't look good. :X
	end
	
	self.NewName:SetText(Hex .. Level .. "|r " .. Name)
	self.NewLevel = Hex .. Level .. "|r"
end

function Plates:Skin(obj)
	local Plate = obj

	Plate.Bar, Plate.Frame = Plate:GetChildren()

	Plate.Health, Plate.Cast = Plate.Bar:GetChildren()
	Plate.Threat, Plate.Border, Plate.Highlight, Plate.Level, Plate.Boss, Plate.Raid, Plate.Dragon = Plate.Bar:GetRegions()
	Plate.Name = Plate.Frame:GetRegions()
	Plate.Health.Texture = Plate.Health:GetRegions()
	Plate.Cast.Texture, Plate.Cast.Border, Plate.Cast.Shield, Plate.Cast.Icon, Plate.Cast.Name, Plate.Cast.NameShadow = Plate.Cast:GetRegions()
	Plate.Cast.Icon.Layer, Plate.Cast.Icon.Level = Plate.Cast.Icon:GetDrawLayer()

	-- Create the Name Plate ...
	self.Container[Plate] = CreateFrame("Frame", nil, self)

	local NewPlate = self.Container[Plate]
	NewPlate:Size(self.PlateWidth, self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)

	-- Reference
	NewPlate.BlizzardPlate = Plate
	Plate.NewPlate = NewPlate

	Plate.Frame:SetParent(Hider)

	-- Original Health
	Plate.Health:SetParent(NewPlate)
	Plate.Health.Texture = Plate.Health:GetStatusBarTexture()
	Plate.Health.Texture:SetTexture(nil)

	-- New Health
	Plate.Health.NewTexture = Plate.Health:CreateTexture(nil, "ARTWORK", nil, -6)
	Plate.Health.NewTexture:SetAllPoints(Plate.Health.Texture)
	Plate.Health.NewTexture:SetTexture(C.Medias.Normal)
	Plate.Health.NewTexture:SetVertexColor(0, 1, 0)

	-- Health Backdrop
	Plate.Health.Background = Plate.Health:CreateTexture(nil, "BACKGROUND")
	Plate.Health.Background:SetAllPoints()
	Plate.Health:CreateShadow()

	-- Threat
	Plate.Threat:SetParent(Hider)

	-- Texture
	Plate.Border:SetTexture(nil)
	Plate.Highlight:SetTexture(nil)
	Plate.Boss:SetTexture(nil)
	Plate.Dragon:SetTexture(nil)

	-- Casting
	Plate.Cast:SetParent(NewPlate)
	Plate.Cast:SetStatusBarTexture(C.Medias.Normal)
	Plate.Cast:CreateShadow()
	
	Plate.Cast.Background = Plate.Cast:CreateTexture(nil, "BACKGROUND")
	Plate.Cast.Background:SetAllPoints()

	Plate.Cast.Border:SetTexture(nil)

	Plate.Cast.Icon:SetTexCoord(unpack(T.IconCoord))
	Plate.Cast.Icon:Size(self.PlateHeight + self.PlateCastHeight + self.PlateSpacing)
	
	Plate.Cast.Icon.Backdrop = CreateFrame("Frame", nil, Plate.Cast)
	Plate.Cast.Icon.Backdrop:SetFrameLevel(Plate.Cast:GetFrameLevel() - 1)
	Plate.Cast.Icon.Backdrop:SetAllPoints(Plate.Cast.Icon)
	Plate.Cast.Icon.Backdrop:SetBackdrop(self.Backdrop)
	Plate.Cast.Icon.Backdrop:SetBackdropColor(0, 0, 0, 1)
	Plate.Cast.Icon.Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
	Plate.Cast.Icon.Backdrop:CreateShadow()

	Plate.Cast.Name:ClearAllPoints()
	Plate.Cast.Name:Point("BOTTOM", Plate.Cast, 0, -7)
	Plate.Cast.Name:Point("LEFT", Plate.Cast, 7, 0)
	Plate.Cast.Name:Point("RIGHT", Plate.Cast, -7, 0)
	Plate.Cast.Name:SetFont(C.Medias.Font, 8, "THINOUTLINE")
	Plate.Cast.Name:SetShadowColor(0,0,0,0)

	-- Level
	Plate.Level:SetParent(Hider)
	Plate.Level:Hide()
	
	-- Name
	Plate.NewName = NewPlate:CreateFontString(nil, "BORDER")
	Plate.NewName:SetPoint("BOTTOM", NewPlate, "TOP", 0, 2)
	Plate.NewName:SetPoint("LEFT", NewPlate, -2, 0)
	Plate.NewName:SetPoint("RIGHT", NewPlate, 2, 0)
	Plate.NewName:SetFont(C.Medias.Font, 10, "THINOUTLINE")
	
	-- OnShow Execution
	Plate:HookScript("OnShow", self.OnShow)
	Plate.Cast:HookScript("OnShow", self.CastOnShow)
	self.OnShow(Plate)

	-- Tell DuffedUI that X nameplate is Skinned
	Plate.IsSkinned = true
end

function Plates:IsNamePlate(obj)
	local Object = obj
	local Name = Object:GetName()

	if Name and Name:match("NamePlate") then
		return true
	else
		return false
	end
end

function Plates:Search()
	local CurrentFrameNumber = WorldFrame:GetNumChildren()
	
	if FrameNumber == CurrentFrameNumber then
		return
	end

	for _, Object in pairs({WorldFrame:GetChildren()}) do
		local IsPlate = self.IsNamePlate(self, Object)
		
		if (not Object.IsSkinned and IsPlate) then
			self:Skin(Object)
		end
	end
	
	FrameNumber = CurrentFrameNumber
end

function Plates:Position()
	self:Hide()

	for Plate, NewPlate in pairs(self.Container) do
		NewPlate:Hide()
		if Plate:IsShown() then
			NewPlate:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", Plate:GetCenter())
			NewPlate:SetAlpha(C.NamePlates.UntargetAlpha)
			NewPlate:Show()
		end
	end

	self:Show()
end

function Plates:OnUpdate(elapsed)
	self:Position()
	self:Search()
end

Plates:RegisterEvent("ADDON_LOADED")
Plates:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "DuffedUI" then
		return
	end
	
	SetCVar("bloatnameplates",0)
	SetCVar("bloatthreat",0)

	self:SetAllPoints()
	self.Container = {}
	self:SetScript("OnUpdate", self.OnUpdate)
	self.PlateWidth = C.NamePlates.Width
	self.PlateHeight = C.NamePlates.Height
	self.PlateCastHeight = C.NamePlates.CastHeight
	self.PlateSpacing = C.NamePlates.Spacing
	self.Backdrop = {
		bgFile = C.Medias.Blank,
		insets = {top = -T.Mult, left = -T.Mult, bottom = -T.Mult, right = -T.Mult},
	}
end)

T["NamePlates"] = Plates