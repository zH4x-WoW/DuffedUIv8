local D, C, L = unpack(select(2, ...))

local _G = _G
local unpack = unpack
local nameplates = CreateFrame("Frame", nil, WorldFrame)
local noop = function() end
local texture = C["media"].normTex
local blank = C["media"].blank
local font = C["media"].font
local ClassColor = C["nameplate"]["ClassColor"]
local ethreat = C["nameplate"]["ethreat"]

function nameplates:RegisterOptions()
	nameplates.Options = {}

	nameplates.Options.Friendly = {
		displaySelectionHighlight = true,
		displayAggroHighlight = false,
		displayName = true,
		fadeOutOfRange = false,
		displayHealPrediction = false,
		colorNameBySelection = true,
		colorNameWithExtendedColors = true,
		colorHealthWithExtendedColors = true,
		colorHealthBySelection = true,
		considerSelectionInCombatAsHostile = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = true,
		displayNameByPlayerNameRules = true,

		selectedBorderColor = CreateColor(1, 1, 1, .35),
		tankBorderColor = CreateColor(1, 1, 0, .6),
		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	nameplates.Options.Enemy = {
		displaySelectionHighlight = true,
		displayAggroHighlight = false,
		playLoseAggroHighlight = false,
		displayName = true,
		fadeOutOfRange = false,
		displayHealPrediction = false,
		colorNameBySelection = true,
		colorHealthBySelection = true,
		considerSelectionInCombatAsHostile = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = true,
		displayNameByPlayerNameRules = true,
		greyOutWhenTapDenied = true,
		selectedBorderColor = CreateColor(1, 1, 1, .55),
		tankBorderColor = CreateColor(1, 1, 0, .6),
		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	nameplates.Options.Player = {
		displaySelectionHighlight = false,
		displayAggroHighlight = false,
		displayName = false,
		fadeOutOfRange = false,
		displayHealPrediction = false,
		colorNameBySelection = true,
		smoothHealthUpdates = false,
		displayNameWhenSelected = false,
		hideCastbar = true,
		healthBarColorOverride = CreateColor(0, 1, 0),
		defaultBorderColor = CreateColor(0, 0, 0, 1),
	}

	nameplates.Options.Size = {
		healthBarHeight = C["nameplate"].plateheight,
		healthBarAlpha = 1,
		castBarHeight = 5,
		castBarFontHeight = 9,
		useLargeNameFont = false,
		castBarShieldWidth = 10,
		castBarShieldHeight = 12,
		castIconWidth = C["nameplate"].plateheight + 7,
		castIconHeight = C["nameplate"].plateheight + 7,
	}

	nameplates.Options.PlayerSize = {
		healthBarHeight = C["nameplate"].plateheight,
		healthBarAlpha = 1,
		castBarHeight = 5,
		castBarFontHeight = 10,
		useLargeNameFont = false,
		castBarShieldWidth = 10,
		castBarShieldHeight = 12,
		castIconWidth = 10,
		castIconHeight = 10,
	}
end

function nameplates:GetClassification(unit)
	local cc = UnitClassification(unit)
	local String = ""

	if cc == "elite" then
		String = "+"
	elseif cc == "rare" then
		String = "r"
	elseif cc == "rareelite" then
		String = "r+"
	elseif cc == "worldboss" then
		String = "b"
	end

	return String
end

function nameplates:SetName()
	local Text = self:GetText()

	if Text then
		local Unit = self:GetParent().unit
		local Class = select(2, UnitClass(Unit))
		local Level = UnitLevel(Unit)
		local LevelColor = GetQuestDifficultyColor(Level)
		local LevelHexColor = D.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
		local IsFriend = UnitIsFriend("player", Unit)
		local NameColor = IsFriend and D.UnitColor.reaction[5] or D.UnitColor.reaction[1]
		local NameHexColor = D.RGBToHex(NameColor[1], NameColor[2], NameColor[3])
		local Elite = nameplates:GetClassification(Unit)
		local EliteColor = D.RGBToHex(unpack(C["media"].datatextcolor1))

		if Level < 0 then Level = "|cffba9b03??|r" else Level = Level end
		self:SetText("|cffba9b03[|r" .. LevelHexColor .. Level .."|r" .. EliteColor .. Elite .."|r" .. "|cffba9b03]|r " ..NameHexColor.. Text .."|r")
	end
end

function nameplates:colorHealth()
	if (self:GetName() and string.find(self:GetName(), "NamePlate")) then
        local r, g, b = self.healthBar:GetStatusBarColor()

		if g + b == 0 then
			r, g, b = .78, .25, .25 -- hostile
			self.isFriendly = false
		elseif r + b == 0 then
			r, g, b = .31, .45, .63 -- player
			self.isFriendly = true
		elseif r + g > 1.95 then
			r, g, b = .86, .77, .36 -- neutral
			self.isFriendly = false
		elseif r + g == 0 then
			r, g, b = .29,  .69, .3 -- good
			self.isFriendly = true
		else
			self.isFriendly = false
		end

		if ClassColor then
			if UnitIsPlayer(self.unit) then
				local Class = select(2, UnitClass(self.unit))
				r, g, b = unpack(D.UnitColor.class[Class])
			end
		end
		self.healthBar:SetStatusBarColor(r, g, b)
    end
	
	-- (3 = securely tanking, 2 = insecurely tanking, 1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank)
	local isTanking, threatStatus = UnitDetailedThreatSituation("player", self.displayedUnit)
	if ethreat then
		if D.Role == "Tank" then
			if isTanking and threatStatus then
				if (threatStatus and threatStatus == 3) then
					self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
				elseif (threatStatus and threatStatus == 2) then
					self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
				elseif (threatStatus and threatStatus == 1) then
					self.healthBar.barTexture:SetVertexColor(.5, 0, .5) -- offtank
				elseif (threatStatus and threatStatus == 0) then
					self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
				end
			end
		else
			if isTanking and threatStatus then
				self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
				self:GetParent().playerHasAggro = true
			else
				if (threatStatus and threatStatus == 3) then
					self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
					self:GetParent().playerHasAggro = true
				elseif (threatStatus and threatStatus == 2) then
					self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
					self:GetParent().playerHasAggro = true
				elseif (threatStatus and threatStatus == 1) then
					self.healthBar.barTexture:SetVertexColor(.5, 0, .5) -- transition
					self:GetParent().playerHasAggro = false
				elseif (threatStatus and threatStatus == 0) then
					self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
					self:GetParent().playerHasAggro = false
				end
			end
		end
	end
end

function nameplates:displayCastIcon()
	local Icon = self.Icon
	local Texture = Icon:GetTexture()
	local Backdrop = self.IconBackdrop
	local IconTexture = self.IconTexture

	if Texture then
		Backdrop:SetAlpha(1)
		IconTexture:SetTexture(Texture)
	else
		Backdrop:SetAlpha(0)
		Icon:SetTexture(nil)
	end
end

function nameplates:setupPlate(options)
	if self.IsEdited then return end

	local health = self.healthBar
	local highlight = self.selectionHighlight
	local aggro = self.aggroHighlight
	local castBar = self.castBar
	local castBarIcon = self.castBar.Icon
	local shield = self.castBar.BorderShield
	local flash = self.castBar.Flash
	local spark = self.castBar.Spark
	local name = self.name

	health:SetStatusBarTexture(texture)
	health.background:ClearAllPoints()
	health.background:SetInside(0, 0)
	health.border:SetAlpha(0)

	castBar:SetStatusBarTexture(texture)
	castBar.background:ClearAllPoints()
	castBar.background:SetInside(0, 0)
	if castBar.border then castBar.border:SetAlpha(0) end

	castBar.SetStatusBarTexture = function() end

	castBar.IconBackdrop = CreateFrame("Frame", nil, castBar)
	castBar.IconBackdrop:SetSize(castBar.Icon:GetSize())
	castBar.IconBackdrop:SetPoint("TOPRIGHT", health, "TOPLEFT", -4, 0)
	castBar.IconBackdrop:SetBackdrop({bgFile = blank})
	castBar.IconBackdrop:SetBackdropColor(.05, .05, .05)
	castBar.IconBackdrop:SetFrameLevel(castBar:GetFrameLevel() - 1 or 0)

	castBar.Icon:SetParent(DuffedUIUIHider)

	castBar.IconTexture = castBar:CreateTexture(nil, "OVERLAY")
	castBar.IconTexture:SetTexCoord(.08, .92, .08, .92)
	castBar.IconTexture:SetParent(castBar.IconBackdrop)
	castBar.IconTexture:SetAllPoints(castBar.IconBackdrop)

	castBar.Text:SetFont(font, 8)
	castBar.Text:SetShadowOffset(1.25, -1.25)

	castBar.startCastColor.r, castBar.startCastColor.g, castBar.startCastColor.b = .65, .63, .35
	castBar.startChannelColor.r, castBar.startChannelColor.g, castBar.startChannelColor.b = .31, .45, .63
	castBar.failedCastColor.r, castBar.failedCastColor.g, castBar.failedCastColor.b = 1, 0, 0
	castBar.nonInterruptibleColor.r, castBar.nonInterruptibleColor.g, castBar.nonInterruptibleColor.b = .8, 0, 0
	castBar.finishedCastColor.r, castBar.finishedCastColor.g, castBar.finishedCastColor.b = 1, .8, 0
	castBar:HookScript("OnShow", nameplates.displayCastIcon)

	name:SetFont(font, 8)
	name:SetShadowOffset(1.25, -1.25)
	hooksecurefunc(name, "Show", nameplates.SetName)

	highlight:Kill()
	shield:Kill()
	aggro:Kill()
	flash:Kill()
	spark:Kill()

	self.IsEdited = true
end

function nameplates:SetClassNameplateBar(frame)
	self.ClassBar = frame
	if frame then frame:SetScale(1.05) end
end

function nameplates:enable()
	local active = C["nameplate"].active
	local npwidth = C["nameplate"]["platewidth"]
	local hooked = {}
	local ref = tostring(CompactUnitFrame_UpdateHealthColor)
	local ref2 = tostring(DefaultCompactNamePlateFrameSetupInternal)
	if not active then return end

	self:RegisterOptions()

	DefaultCompactNamePlateFriendlyFrameOptions = nameplates.Options.Friendly
	DefaultCompactNamePlateEnemyFrameOptions = nameplates.Options.Enemy
	DefaultCompactNamePlatePlayerFrameOptions = nameplates.Options.Player
	DefaultCompactNamePlateFrameSetUpOptions = nameplates.Options.Size
	DefaultCompactNamePlatePlayerFrameSetUpOptions = nameplates.Options.PlayerSize

	if ClassNameplateManaBarFrame then
		ClassNameplateManaBarFrame.Border:SetAlpha(0)
		ClassNameplateManaBarFrame:SetStatusBarTexture(texture)
		ClassNameplateManaBarFrame.ManaCostPredictionBar:SetTexture(texture)
		ClassNameplateManaBarFrame:SetBackdrop({bgFile = blank})
		ClassNameplateManaBarFrame:SetBackdropColor(.2, .2, .2)
	end
	self.ClassBar = NamePlateDriverFrame.nameplateBar
	if self.ClassBar then self.ClassBar:SetScale(1.05) end
	hooksecurefunc(NamePlateDriverFrame, "SetClassNameplateBar", self.SetClassNameplateBar)

	if not hooked[ref] and not hooked[ref2] then
		hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.colorHealth)
		hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", self.setupPlate)
		hooked[ref] = true
		hooked[ref2] = true
	end

	NamePlateDriverFrame.UpdateNamePlateOptions = function() end
	InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:Hide()
	--C_NamePlate.SetNamePlateOtherSize(npwidth, 45)
end

nameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
nameplates:SetScript("OnEvent", function(self, event, ...)
	nameplates:enable()
	nameplates:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)