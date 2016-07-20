local D, C, L = unpack(select(2, ...))

local _G = _G
local unpack = unpack
local nameplates = CreateFrame("Frame", nil, WorldFrame)
local noop = function() end

function nameplates:RegisterOptions()
	nameplates.Options = {}

	nameplates.Options.Friendly = {
		displaySelectionHighlight = true,
		displayAggroHighlight = false,
		displayName = true,
		fadeOutOfRange = false,
		--displayStatusText = true,
		displayHealPrediction = false,
		--displayDispelDebuffs = true,
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

	nameplates.Options.castBarColors = {
		StartNormal =  D.UnitColor.power["ENERGY"],
		StartChannel = D.UnitColor.power["MANA"],
		Success = {1, .8, 0},
		NonInterrupt = {.7, 0, 0},
		Failed = {1, 0, 0},
	}
end

local function IsPlayerEffectivelyTank()
	local assignedRole = UnitGroupRolesAssigned("player")

	if assignedRole == "NONE" then
		local spec GetSpecialization()
		return spec and GetSpecializationRole(spec) == "TANK"
	end
	return assignedRole == "TANK"
end

function nameplates:SetName()
    local text = self:GetText()
	local level, elite, mylevel = UnitLevel("target"), UnitClassification("target"), UnitLevel("player")

    if text then
		if (level == -1 or not level) then
			self:SetText("|cffCC0D00" .. ("??") .. "|r " .. "|cffffffff".. text .."|r")
		elseif elite == "elite" then
			local colr = GetQuestDifficultyColor(level)
			self:SetText(D["RGBToHex"](colr.r, colr.g, colr.b) .. level .. (elite and "+")  .. "|r " .. "|cffffffff".. text .."|r")
		elseif not elite and level == mylevel then
			self.SetText("|cffffffff".. text .."|r")
		elseif level then
			local colr = GetQuestDifficultyColor(level)
			self:SetText(D["RGBToHex"](colr.r, colr.g, colr.b) .. level ..  "|r " .. "|cffffffff".. text .."|r")
		end
    end
end

function nameplates:colorHealth()
    if (self:GetName() and string.find(self:GetName(), "NamePlate")) then
        local r, g, b = self.healthBar:GetStatusBarColor()

        for class, color in pairs(RAID_CLASS_COLORS) do
			local r, g, b = floor(r * 100 + .5) / 100, floor(g * 100 + .5) / 100, floor(b * 100 + .5) / 100
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				self.hasClass = true
				self.isFriendly = false
				self.healthBar:SetStatusBarColor(unpack(D.UnitColor.class[class]))
				return
			end
		end

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

		if UnitIsPlayer(self.unit) then
			local Class = select(2, UnitClass(self.unit))
			r, g, b = unpack(colors.class[Class])
		end
        self.healthBar:SetStatusBarColor(r, g, b)
    end
end

function nameplates:UpdateAggronameplates()
	local isTanking, threatStatus = UnitDetailedThreatSituation("player", self.displayedUnit)
	-- (3 = securely tanking, 2 = insecurely tanking, 1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank)

	if IsPlayerEffectivelyTank() then
		if not isTanking then
			nameplates:colorHealth()
		else
			if (threatStatus == 3) then
				self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
			elseif (threatStatus == 2) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
			elseif (threatStatus == 1) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
			elseif (threatStatus == 0) then
				self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
			end
		end
	else
		if isTanking then
			self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
			self:GetParent().playerHasAggro = true
		else
			if (threatStatus == 3) then
				self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
				self:GetParent().playerHasAggro = true
			elseif (threatStatus == 2) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
				self:GetParent().playerHasAggro = true
			elseif (threatStatus == 1) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
				self:GetParent().playerHasAggro = false
			elseif (threatStatus == 0) then
				self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
				self:GetParent().playerHasAggro = false
			else
				nameplates:colorHealth()
			end
		end
	end
end

function nameplates:displayCastIcon()
	local icon = self
	local tex = icon:GetTexture()
	local backdrop = icon:GetParent()

	if tex then
		if not backdrop:IsShown() then backdrop:Show() end
	else
		if backdrop:IsShown() then backdrop:Hide() end
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

	health:SetStatusBarTexture(C["media"].normTex)
	health.background:ClearAllPoints()
	health.background:SetInside(0, 0)
	health.border:SetAlpha(0)

	castBar:SetStatusBarTexture(C["media"].normTex)
	castBar.background:ClearAllPoints()
	castBar.background:SetInside(0, 0)
	if castBar.border then castBar.border:SetAlpha(0) end

	castBar.SetStatusBarTexture = function() end

	castBar.IconBackdrop = CreateFrame("Frame", nil, castBar)
	castBar.IconBackdrop:SetSize(castBar.Icon:GetSize())
	castBar.IconBackdrop:SetPoint("TOPRIGHT", health, "TOPLEFT", -4, 0)
	castBar.IconBackdrop:SetBackdrop({bgFile = C["media"].blank})
	castBar.IconBackdrop:SetBackdropColor(unpack(C["media"].backdropcolor))
	castBar.IconBackdrop:SetFrameLevel(castBar:GetFrameLevel() - 1 or 0)

	castBar.Icon:SetTexCoord(.08, .92, .08, .92)
	castBar.Icon:SetParent(castBar.IconBackdrop)
	castBar.Icon:ClearAllPoints()
	castBar.Icon:SetAllPoints(castBar.IconBackdrop)
	castBar.Icon.ClearAllPoints = noop
	castBar.Icon.SetPoint = noop

	castBar.Text:SetFont(C["media"].font, 8)
	castBar.Text:SetShadowOffset(1.25, -1.25)

	castBar.startCastColor.r, castBar.startCastColor.g, castBar.startCastColor.b = unpack(nameplates.Options.castBarColors.StartNormal)
	castBar.startChannelColor.r, castBar.startChannelColor.g, castBar.startChannelColor.b = unpack(nameplates.Options.castBarColors.StartChannel)
	castBar.failedCastColor.r, castBar.failedCastColor.g, castBar.failedCastColor.b = unpack(nameplates.Options.castBarColors.Failed)
	castBar.nonInterruptibleColor.r, castBar.nonInterruptibleColor.g, castBar.nonInterruptibleColor.b = unpack(nameplates.Options.castBarColors.NonInterrupt)
	castBar.finishedCastColor.r, castBar.finishedCastColor.g, castBar.finishedCastColor.b = unpack(nameplates.Options.castBarColors.Success)

	hooksecurefunc(castBar.Icon, "SetTexture", nameplates.displayCastIcon)

	name:SetFont(C["media"].font, 8)
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
	if not active then return end

	self:RegisterOptions()

	DefaultCompactNamePlateFriendlyFrameOptions = nameplates.Options.Friendly
	DefaultCompactNamePlateEnemyFrameOptions = nameplates.Options.Enemy
	DefaultCompactNamePlatePlayerFrameOptions = nameplates.Options.Player
	DefaultCompactNamePlateFrameSetUpOptions = nameplates.Options.Size
	DefaultCompactNamePlatePlayerFrameSetUpOptions = nameplates.Options.PlayerSize

	if ClassNameplateManaBarFrame then
		ClassNameplateManaBarFrame.Border:SetAlpha(0)
		ClassNameplateManaBarFrame:SetStatusBarTexture(C["media"].normTex)
		ClassNameplateManaBarFrame.ManaCostPredictionBar:SetTexture(C["media"].normTex)
		ClassNameplateManaBarFrame:SetBackdrop({bgFile = C["media"].blank})
		ClassNameplateManaBarFrame:SetBackdropColor(.2, .2, .2)
	end
	self.ClassBar = NamePlateDriverFrame.nameplateBar
	if self.ClassBar then self.ClassBar:SetScale(1.05) end
	hooksecurefunc(NamePlateDriverFrame, "SetClassNameplateBar", self.SetClassNameplateBar)

	hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", self.setupPlate)
	if C["nameplate"]["ethreat"] then
		hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.UpdateAggronameplates)
	else
		hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.colorHealth)
	end

	NamePlateDriverFrame.UpdateNamePlateOptions = function() end
	InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:Hide()
end

nameplates:RegisterEvent("PLAYER_LOGIN")
nameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
nameplates:RegisterEvent("ADDON_LOADED")
nameplates:SetScript("OnEvent", function(self, event, ...)
	nameplates:enable()
end)
