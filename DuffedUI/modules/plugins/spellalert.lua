local D, C, L = unpack(select(2, ...))
if C["duffed"].spellannounce ~= true then return end

D.Spells = {
	-- Death Knight
	[48792] = true, -- Icebound Fortitude
	[48707] = true, -- Anti-Magic-Shell
	[55233] = true, -- Vampric Blood
	[61999] = true, -- Raise Ally

	-- Druid
	[61336] = true, -- Survival Insticts
	[106922] = true, -- Might of Ursoc

	-- Monk
	[115203] = true, -- Fortifying Brew
	[115213] = true, -- Avert Harm

	-- Paladin
	[498] = true, -- Divine Protection
	[642] = true, -- Divine Shield
	[31850] = true, -- Ardent Defender

	-- Priest
	[33206] = true, -- Pain Supression
	[47788] = true, -- Guardian Spirit
	[62618] = true, -- PW: Barrier
	[109964] = true, -- Spirit Shell

	-- Shaman
	[16190] = true, -- Mana Tide Totem
	[98008] = true, -- Spirit Link Totem
	[108280] = true, -- Healing Tide Totem
	[120668] = true, -- Stormlash Totem

	-- Warlock
	[20707] = true, -- Soulstone

	-- Warrior
	[871] = true, -- Shield Wall
	[12975] = true, -- Last Stand
	[97462] = true, -- Rallying Cry
	[114192] = true, -- Mocking Banner
	[114203] = true, -- Demoralizing Banner
	[114207] = true, -- Skull Banner
}

local PlayerGUID
local Name = UnitName("player")
local WaitTable = {}
local OnEvent = function(self, event, ...)
	local Time, Type, HideCaster, SourceGUID, SourceName, SourceFlags, SourceRaidFlags, DestGUID, DestName, DestFlags, DestRaidFlags, SpellID, SpellName = ...

	if (SourceGUID ~= PlayerGUID) then return end

	if (D.Spells[SpellID] and Type == "SPELL_CAST_SUCCESS") then
		if (not DestName) then DestName = SourceName end

		local Duration = select(6, UnitAura(DestName, SpellName)) or 10
		local SpellString = "\124cff71d5ff\124Hspell:" .. SpellID .. "\124h[" .. SpellName .. "]\124h\124r"
		local AnnounceTo = C["duffed"].announcechannel

		if (DestName ~= Name) then
			if (Duration == nil) then
				SendChatMessage("++ ".. SpellString .. " on " .. DestName .. "!", AnnounceTo)
			else
				SendChatMessage("++ ".. SpellString .. " on " .. DestName .. " for " .. Duration .. " s", AnnounceTo)
			end
		else
			SendChatMessage("++ ".. SpellString .. " for " .. Duration .. " s", AnnounceTo)
		end
		D.Delay(Duration, SendChatMessage, "-- ".. SpellString, AnnounceTo)
	end
end

local AnnounceFrame = CreateFrame("Frame")
AnnounceFrame:RegisterEvent("PLAYER_LOGIN")
AnnounceFrame:SetScript("OnEvent", function(self, event)
    PlayerGUID = UnitGUID("player")
    self:UnregisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:SetScript("OnEvent", OnEvent)
end)