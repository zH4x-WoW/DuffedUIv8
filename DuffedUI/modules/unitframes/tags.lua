local T, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local DuffedUIUnitFrames = T["UnitFrames"]
local DEAD = DEAD
local CHAT_FLAG_AFK = CHAT_FLAG_AFK

oUF.Tags.Events['DuffedUI:GetNameColor'] = 'UNIT_POWER'
oUF.Tags.Methods['DuffedUI:GetNameColor'] = function(unit)
	local Reaction = UnitReaction(unit, 'player')
	
	if (UnitIsPlayer(unit)) then
		return _TAGS['raidcolor'](unit)
	elseif (Reaction) then
		local c = T.Colors.reaction[Reaction]
		return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
	else
		return string.format('|cff%02x%02x%02x', .84 * 255, .75 * 255, .65 * 255)
	end
end

oUF.Tags.Events['DuffedUI:DiffColor'] = 'UNIT_LEVEL'
oUF.Tags.Methods['DuffedUI:DiffColor'] = function(unit)
	local r, g, b
	local Level = UnitLevel(unit)
	
	if (Level < 1) then
		r, g, b = 0.69, 0.31, 0.31
	else
		local DiffColor = UnitLevel('target') - UnitLevel('player')
		if (DiffColor >= 5) then
			r, g, b = 0.69, 0.31, 0.31
		elseif (DiffColor >= 3) then
			r, g, b = 0.71, 0.43, 0.27
		elseif (DiffColor >= -2) then
			r, g, b = 0.84, 0.75, 0.65
		elseif (-DiffColor <= GetQuestGreenRange()) then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end
	
	return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
end

oUF.Tags.Events['DuffedUI:NameShort'] = 'UNIT_NAME_UPDATE PARTY_LEADER_CHANGED GROUP_ROSTER_UPDATE'
oUF.Tags.Methods['DuffedUI:NameShort'] = function(unit)
	local Name = UnitName(unit)
	local IsLeader = UnitIsGroupLeader(unit)
	local IsAssistant = UnitIsGroupAssistant(unit) or UnitIsRaidOfficer(unit)
	local Assist, Lead = IsAssistant and "[A] " or "", IsLeader and "[L] " or ""

	return DuffedUIUnitFrames.UTF8Sub(Lead..Assist..Name, 10, false)
end

oUF.Tags.Events['DuffedUI:NameMedium'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['DuffedUI:NameMedium'] = function(unit)
	local Name = UnitName(unit)
	return DuffedUIUnitFrames.UTF8Sub(Name, 15, true)
end

oUF.Tags.Events['DuffedUI:NameLong'] = 'UNIT_NAME_UPDATE'
oUF.Tags.Methods['DuffedUI:NameLong'] = function(unit)
	local Name = UnitName(unit)
	return DuffedUIUnitFrames.UTF8Sub(Name, 20, true)
end

oUF.Tags.Events['DuffedUI:Dead'] = 'UNIT_HEALTH'
oUF.Tags.Methods['DuffedUI:Dead'] = function(unit)
	if UnitIsDeadOrGhost(unit) then
		return DEAD
	end
end

oUF.Tags.Events['DuffedUI:AFK'] = 'PLAYER_FLAGS_CHANGED'
oUF.Tags.Methods['DuffedUI:AFK'] = function(unit)
	if UnitIsAFK(unit) then
		return CHAT_FLAG_AFK
	end
end

oUF.Tags.Events['DuffedUI:Role'] = 'PLAYER_ROLES_ASSIGNED GROUP_ROSTER_UPDATE'
oUF.Tags.Methods['DuffedUI:Role'] = function(unit)
	local Role = UnitGroupRolesAssigned(unit)
	local String = ""
	
	if Role == "TANK" then
		String = "|cff0099CC" .. TANK .. "|r"
	elseif Role == "HEALER" then
		String = "|cff00FF00" .. HEALER .. "|r"
	end
	
	return String
end

DuffedUIUnitFrames.Tags = oUF.Tags