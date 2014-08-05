local D, C, L, G = unpack(select(2, ...))

if C["tooltip"].enable ~= true or C["tooltip"].ilvl ~= true then return end

--- Variables ---
local currentUNIT, currentGUID
local GearDB, SpecDB = {}, {}

local nextInspectRequest = 0
lastInspectRequest = 0

local prefixColor = "|cffffeeaa"
local detailColor = "|cffffffff"

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL..": "
local specPrefix = SPECIALIZATION..": "

--- Create Frame ---
local f = CreateFrame("Frame", "UnitInfo")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("INSPECT_READY")

--- Set Unit Info ---
local function SetUnitInfo(gear, spec)
	if (not gear) and (not spec) then return end

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine, specLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft"..i]
		local text = line:GetText()

		if text and strfind(text, gearPrefix) then
			gearLine = line
		elseif text and strfind(text, specPrefix) then
			specLine = line
		end
	end

	if gear then
		gear = prefixColor..gearPrefix..detailColor..gear

		if gearLine then
			gearLine:SetText(gear)
		else
			GameTooltip:AddLine(gear)
		end
	end

	if spec then
		spec = prefixColor..specPrefix..detailColor..spec

		if specLine then
			specLine:SetText(spec)
		else
			GameTooltip:AddLine(spec)
		end
	end

	GameTooltip:Show()
end

--- Upgraded Item Bonus ---
local UGBonus = {
	[001] =  8, [373] =  4, [374] =  8, [375] =  4,
	[376] =  4, [377] =  4, [379] =  4, [380] =  4,
	[445] =  0, [446] =  4, [447] =  8,	[451] =  0,
	[452] =  8, [453] =  0, [454] =  4, [455] =  8,
	[456] =  0, [457] =  8,	[458] =  0, [459] =  4,
	[460] =  8, [461] = 12, [462] = 16,	[465] =  0,
	[466] =  4, [467] =  8, [469] =  4, [470] =  8,
	[471] = 12, [472] = 16, [476] =  0, [477] =  4,
	[478] =  8, [479] =  0, [480] =  8, [491] =  0,
	[492] =  4, [493] =  8, [494] = 12, [495] =  4,
	[496] =  8, [497] = 12, [498] = 16, [504] = 12,
	[505] = 16, [506] = 20, [507] = 24,
}

--- Old BOA List ---
local boa_cache = {
	[80] = {
		44102, 42944, 44096, 42943, 42950, 48677, 42946, 42948, 42947, 42992, 50255, 44103,
		44107, 44095, 44098, 44097, 44105, 42951, 48683, 48685, 42949, 48687, 42984, 44100,
		44101, 44092, 48718, 44091, 42952, 48689, 44099, 42991, 42985, 48691, 44094, 44093,
		42945, 48716
	},
	["sooflex"] = {105679, 105673, 105677, 105672, 105678, 105671, 105675, 105670, 105674, 105680},
	["soonormal"] = {104405, 104403, 104406, 104404, 104401, 104400, 104402, 104399, 104409, 104407},
	["sooheroic"] = {105692, 105686, 105690, 105685, 105691, 105684, 105688, 105683, 105687, 105693},
}
		
function boaILVL(level, itemLink)
	local returnValue
	if level > 80 then
		local _, _, _, _, itemId = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
		itemId = tonumber(itemId)
		
		-- Downgrade it to 80 if found
		for k, iid in pairs(boa_cache[80]) do
			if iid == itemId then
				level = 80
			end
		end
		
		-- Check Garrosh BOA item
		for k, iid in pairs(boa_cache["sooflex"]) do
			if iid == itemId then
				return 556
			end
		end			
		for k, iid in pairs(boa_cache["soonormal"]) do
			if iid == itemId then
				return 569
			end
		end			
		for k, iid in pairs(boa_cache["sooheroic"]) do
			if iid == itemId then
				return 582
			end
		end			
	end
	
	if level > 80 then
		returnValue = (( level - 80) * 26.6) + 200
	elseif level > 70 then
		returnValue = (( level - 70) * 10) + 100
	elseif level > 60 then
		returnValue = (( level - 60) * 4) + 60
	else
		returnValue = level
	end
	return returnValue
end

--- PVP Item Detect ---
local function IsPVPItem(link)
	local itemStats = GetItemStats(link)

	for stat in pairs(itemStats) do
		if (stat == "ITEM_MOD_RESILIENCE_RATING_SHORT") or (stat == "ITEM_MOD_PVP_POWER_SHORT") then
			return true
		end
	end

	return false
end

--- Unit Gear Info ---
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local ulvl = UnitLevel(unit)
	local class = select(2, UnitClass(unit))

	local ilvl, boa, pvp = 0, 0, 0
	local total, count, delay = 0, 16, nil
	local mainhand, offhand, twohand = 1, 1, 0

	for i = 1, 17 do
		if (i ~= 4) then
			local itemTexture = GetInventoryItemTexture(unit, i)

			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)

				if (not itemLink) then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 7) then
							boa = boa + 1
							total = total + boaILVL(ulvl, itemLink)
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end

							if (level >= 458) then
								local uid = tonumber(strmatch(itemLink, '.+:(%d+)'))
								if UGBonus[uid] then
									level = level + UGBonus[uid]
								end
							end

							total = total + level
						end

						if (i >= 16) then
							if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (class == "HUNTER")) then
								twohand = twohand + 1
							end
						end
					end
				end
			else
				if (i == 16) then
					mainhand = 0
				elseif (i == 17) then
					offhand = 0
				end
			end
		end
	end

	if (mainhand == 0) and (offhand == 0) or (twohand == 1) then
		count = count - 1
	end

	if (not delay) then
		if (unit == "player") and (GetAverageItemLevel() > 0) then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / count
		end

		if (ilvl > 0) then ilvl = string.format('%.1f', ilvl) end
		if (boa > 0) then ilvl = ilvl.." |cffe6cc80"..boa.." BOA" end
		if (pvp > 0) then ilvl = ilvl.." |cffa335ee"..pvp.." PVP" end
	else
		ilvl = nil
	end

	return ilvl
end

--- Unit Specialization ---
local function UnitSpec(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local specName

	if (unit == "player") then
		local specIndex = GetSpecialization()

		if specIndex then
			_, specName = GetSpecializationInfo(specIndex)
		else
			specName = NONE
		end
	else
		local specID = GetInspectSpecialization(unit)

		if specID and (specID > 0) then
			_, specName = GetSpecializationInfoByID(specID)
		elseif (specID == 0) then
			specName = NONE
		end
	end

	return specName
end

--- Scan Current Unit ---
local function ScanUnit(unit, forced)
	local cachedGear, cachedSpec

	if UnitIsUnit(unit, "player") then
		cachedGear = UnitGear("player")
		cachedSpec = UnitSpec("player")

		SetUnitInfo(cachedGear or CONTINUED, cachedSpec or CONTINUED)
	else
		if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

		cachedGear = GearDB[currentGUID]
		cachedSpec = SpecDB[currentGUID]

		if cachedGear or forced then
			SetUnitInfo(cachedGear or CONTINUED, cachedSpec)
		end

		if not (IsShiftKeyDown() or forced) then
			if cachedGear and cachedSpec then return end
			if UnitAffectingCombat("player") then return end
		end

		if (not UnitIsVisible(unit)) then return end
		if UnitIsDeadOrGhost("player") or UnitOnTaxi("player") then return end
		if InspectFrame and InspectFrame:IsShown() then return end

		SetUnitInfo(CONTINUED, cachedSpec or CONTINUED)

		local timeSinceLastInspect = GetTime() - lastInspectRequest
		if (timeSinceLastInspect >= 1.5) then
			nextInspectRequest = 0
		else
			nextInspectRequest = 1.5 - timeSinceLastInspect
		end
		f:Show()
	end
end

--- Character Info Sheet ---
hooksecurefunc("PaperDollFrame_SetItemLevel", function(self, unit)
	if (unit ~= 'player') then return end

	local total, equip = GetAverageItemLevel()
	if (total > 0) then total = string.format('%.1f', total) end
	if (equip > 0) then equip = string.format('%.1f', equip) end

	local ilvl = equip
	if (equip ~= total) then
		ilvl = equip.." / "..total
	end

	local ilvlLine = _G[self:GetName().."StatText"]
	ilvlLine:SetText(ilvl)

	self.tooltip = detailColor..STAT_AVERAGE_ITEM_LEVEL.." "..ilvl
end)

--- Handle Events ---
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "UNIT_INVENTORY_CHANGED") then
		local unit = ...
		if (UnitGUID(unit) == currentGUID) then
			ScanUnit(unit, true)
		end
	elseif (event == "INSPECT_READY") then
		local guid = ...
		if (guid ~= currentGUID) then return end

		local gear = UnitGear(currentUNIT)
		GearDB[currentGUID] = gear

		local spec = UnitSpec(currentUNIT)
		SpecDB[currentGUID] = spec

		if (not gear) or (not spec) then
			ScanUnit(currentUNIT, true)
		else
			SetUnitInfo(gear, spec)
		end
	end
end)

f:SetScript("OnUpdate", function(self, elapsed)
	nextInspectRequest = nextInspectRequest - elapsed
	if (nextInspectRequest > 0) then return end

	self:Hide()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		lastInspectRequest = GetTime()
		NotifyInspect(currentUNIT)
	end
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local _, unit = self:GetUnit()

	if (not unit) or (not CanInspect(unit)) then return end
	if (UnitLevel(unit) > 0) and (UnitLevel(unit) < 10) then return end

	currentUNIT, currentGUID = unit, UnitGUID(unit)
	ScanUnit(unit)
end)