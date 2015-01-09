local D, C, L = unpack(select(2, ...))
if C["auras"]["buffnotice"] ~= true then return end

local WarningSound = C["media"]["warning"]

local BuffReminder1 = {
	["DEATHKNIGHT"] = {
		6673, -- Battle Shout
		57330, -- Horn of Winter
		93435, -- Roar of Courage (Hunter Pet)
	},
	["DRUID"] = {
		1126, -- Mark of the Wild
		20217, -- Blessing of Kings
		90363, -- Embrace of the Shale Spider
		115921, -- Legacy of the Emperor
	},
	["MAGE"] = {
		1459, -- Arcane Brilliance
		61316, -- Dalaran Brilliance
		109773, -- Dark Intent
	},
	["MONK"] = {
		1126, -- Mark of the Wild
		20217, -- Blessing of Kings
		90363, -- Embrace of the Shale Spider
		116781, -- Legacy of the White Tiger
		115921, -- Legacy of the Emperor
	},
	["PALADIN"] = {
		1126, -- Mark of the Wild
		19740, -- Blessing of Might
		20217, -- Blessing of Kings
		90363, -- Embrace of the Shale Spider
		115921, -- Legacy of the Emperor
	},
	["PRIEST"] = {
		469, -- Commanding Shout
		21562, -- PW: Fortitude
		109773, -- Dark Intent
	},
	["ROGUE"] = {
		2823, -- Deadly Poison
		3408, -- Crippling Poison
		8679, -- Wound Poison
		108211, -- Leeching Poison
	},
	["SHAMAN"] = {
		324, -- Lightning Shield
		52127, -- Water Shield
	},
	["WARLOCK"] = {
		469, -- Commanding Shout
		21562, -- PW: Fortitude
		109773, -- Dark Intent
	},
	["WARRIOR"] = {
		469, -- Commanding Shout
		6673, -- Battle Shout
		93435, -- Roar of Courage (Hunter Pet)
		57330, -- Horn of Winter
	},
	["HUNTER"] = {},
}

local BuffReminder2 = {
	["DEATHKNIGHT"] = {
		48263, -- Blood Presence
		48265, -- Unholy Presence
		48266, -- Frost Presence
	},
}

local pairs, select = pairs, select
local IsSpellKnown, GetSpellInfo, GetSpellTexture, UnitAffectingCombat, UnitInVehicle, UnitBuff, PlaySoundFile = IsSpellKnown, GetSpellInfo, GetSpellTexture, UnitAffectingCombat, UnitInVehicle, UnitBuff, PlaySoundFile
local GetSpecialization, UnitLevel, GetInventorySlotInfo, GetWeaponEnchantInfo, GetInventoryItemID = GetSpecialization, UnitLevel, GetInventorySlotInfo, GetWeaponEnchantInfo, GetInventoryItemID
local PlaySound = true

local function AddEvents(self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:RegisterEvent("SPELLS_CHANGED")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterUnitEvent("UNIT_AURA", "player")
	self:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	self:RegisterUnitEvent("UNIT_ENTERING_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_EXITING_VEHICLE", "player")
	self:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
end

local function PositionFrames(self, event)
	BuffsWarning1:ClearAllPoints()
	BuffsWarning2:ClearAllPoints()
	local Width = 40
	BuffsWarning1:SetPoint("LEFT", BuffsWarningFrame, "LEFT", 0, 0)
	BuffsWarning2:SetPoint("LEFT", BuffsWarningFrame, "LEFT", BuffsWarning1:IsShown() and 48 or 0, 0)
	BuffsWarningFrame:SetWidth(Width)
	BuffsWarningFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
end

local function OnEvent(self, event)
	if event == "PLAYER_LOGIN" then AddEvents(self) end
	if event == "PLAYER_LOGIN" or event == "SPELLS_CHANGED" then
		for key, buff in pairs(self.Buffs) do
			if IsSpellKnown(buff) then
				self.Icon:SetTexture(GetSpellTexture(GetSpellInfo(buff)))
				break
			end
		end
	end
	if self.Icon:GetTexture() == nil then return end
	if UnitAffectingCombat("player") and not UnitInVehicle("player") then
		for key, buff in pairs(self.Buffs) do
			if UnitBuff("player", GetSpellInfo(buff)) then
				self:Hide()
				return
			end
		end
		self:Show()
		if C["auras"]["warning"] and PlaySound == true then
			PlaySound = false
			PlaySoundFile(WarningSound)
		end
	else
		self:Hide()
	end
	PositionFrames()
end

local function CreateWarningFrame(Name)
	local Frame = CreateFrame("Frame", Name, BuffsWarningFrame)
	Frame:Hide()
	Frame:SetSize(40, 40)
	Frame.Icon = Frame:CreateTexture(nil, "ARTWORK")
	Frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Frame:SetTemplate()
	Frame.Icon:SetInside()
	Frame:RegisterEvent("PLAYER_LOGIN")

	return Frame
end

local ThrottleTime, TimeStart = 30, 0
local function SoundThrottle(self, elapsed)
	TimeStart = TimeStart + elapsed
	if TimeStart > ThrottleTime then
		if PlaySound == false then PlaySound = true end
		TimeStart = 0
	end
end

local BuffsWarning1 = CreateWarningFrame("BuffsWarning1")
BuffsWarning1.Buffs = BuffReminder1[D["Class"]] or {}
BuffsWarning1:SetScript("OnEvent", OnEvent)

local BuffsWarning2 = CreateWarningFrame("BuffsWarning2")
BuffsWarning2.Buffs = BuffReminder2[D["Class"]] or {}
BuffsWarning2:SetScript("OnEvent", OnEvent)

local BuffsWarningFrame = CreateFrame("Frame", "BuffsWarningFrame", UIParent)
BuffsWarningFrame:SetSize(40, 40)
BuffsWarningFrame:SetScript("OnUpdate", SoundThrottle)
