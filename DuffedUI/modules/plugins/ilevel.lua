local D, C, L = unpack(select(2, ...))
if C["tooltip"].enable ~= true or C["tooltip"].ilvl ~= true then return end

local ILevel, TalentSpec, LastUpdate = 0, "", 30
local InspectDelay = 0.2
local InspectFreq = 2
local ilvlspectooltip = CreateFrame("Frame")
local format = string.format
local LibItemUpgrade = LibStub('LibItemUpgradeInfo-1.0')

ilvlspectooltip.Cache = {}
ilvlspectooltip.LastInspectRequest = 0
SlotNames = {
	"Head",
	"Neck",
	"Shoulder",
	"Back",
	"Chest",
	"Wrist",
	"Hands",
	"Waist",
	"Legs",
	"Feet",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"MainHand",
	"SecondaryHand"
}

function GetItemLevel(unit)
	local Total, Item = 0, 0
	
	for i = 1, #SlotNames do
		local Slot = GetInventoryItemLink(unit, GetInventorySlotInfo(("%sSlot"):format(SlotNames[i])))
		
		if (Slot) then
			local ILVL = LibItemUpgrade:GetUpgradedItemLevel(Slot)
			if (ILVL) then
				Item = Item + 1
				Total = Total + ILVL
			end
		end
	end
	
	if (Total < 1) then return "..." end
	return floor(Total / Item)
end

function GetTalentSpec(unit)
	local Spec
	if not unit then Spec = GetSpecialization() else Spec = GetInspectSpecialization(unit) end
	
	if(Spec and Spec > 0) then
		if (unit) then 
			local Role = GetSpecializationRoleByID(Spec)
			
			if (Role) then
				local Name = select(2, GetSpecializationInfoByID(Spec))
				return Name
			end
		else
			local Name = select(2, GetSpecializationInfo(Spec))
			return Name
		end
	end
end

ilvlspectooltip:SetScript("OnUpdate", function(self, elapsed)
	self.NextUpdate = (self.NextUpdate or 0) - elapsed
	if (self.NextUpdate) <= 0 then
		self:Hide()
		local GUID = UnitGUID("mouseover")
		
		if not GUID then return end
		if (GUID == self.CurrentGUID) and (not (InspectFrame and InspectFrame:IsShown())) then
			self.LastGUID = self.CurrentGUID
			self.LastInspectRequest = GetTime()
			self:RegisterEvent("INSPECT_READY")
			NotifyInspect(self.CurrentUnit)
		end
	end
end)

ilvlspectooltip:SetScript("OnEvent", function(self, event, GUID)
	if GUID ~= self.LastGUID or (InspectFrame and InspectFrame:IsShown()) then
		self:UnregisterEvent("INSPECT_READY")
		return
	end
	
	local ILVL = GetItemLevel("mouseover")
	local TalentSpec = GetTalentSpec("mouseover")
	local CurrentTime = GetTime()
	local MatchFound

	for i, Cache in ipairs(self.Cache) do
		if Cache.GUID == GUID then
			Cache.ItemLevel = ILVL
			Cache.TalentSpec = TalentSpec
			Cache.LastUpdate = floor(CurrentTime)	
			MatchFound = true
			break
		end
	end

	if (not MatchFound) then
		local GUIDInfo = {
			["GUID"] = GUID,
			["ItemLevel"] = ILVL,
			["TalentSpec"] = TalentSpec,
			["LastUpdate"] = floor(CurrentTime)
		}
		self.Cache[#self.Cache + 1] = GUIDInfo
	end
	
	if (#self.Cache > 50) then table.remove(self.Cache, 1) end

	GameTooltip:SetUnit("mouseover")
	ClearInspectPlayer()
	self:UnregisterEvent("INSPECT_READY")
end)

function OnTooltipSetUnit()
	local GetMouseFocus = GetMouseFocus()
	local Unit = select(2, GameTooltip:GetUnit()) or (GetMouseFocus and GetMouseFocus:GetAttribute("unit"))
	
	if (not Unit) and UnitExists("mouseover") then Unit = "mouseover" end
	
	if (not Unit) then 
		ilvlspectooltip:Hide() 
		return
	end
	
	if (UnitIsUnit(Unit, "mouseover")) then Unit = "mouseover" end
	
	if (UnitIsPlayer(Unit) and UnitIsFriend("player", Unit)) then
		local Talent = GetTalentSpec(Unit)
		
		ILevel = "..."
		TalentSpec = "..."
		
		if (Unit ~= "player") then
			ilvlspectooltip.CurrentGUID = UnitGUID(Unit)
			ilvlspectooltip.CurrentUnit = Unit
		
			for i, _ in pairs(ilvlspectooltip.Cache) do
				local Cache = ilvlspectooltip.Cache[i]

				if Cache.GUID == ilvlspectooltip.CurrentGUID then
					ILevel = Cache.ItemLevel or "..."
					TalentSpec = Cache.TalentSpec or "..."
					LastUpdate = Cache.LastUpdate and abs(Cache.LastUpdate - floor(GetTime())) or 30
				end
			end	
		
			if (Unit and (CanInspect(Unit))) and (not (InspectFrame and InspectFrame:IsShown())) then
				local LastInspectTime = GetTime() - ilvlspectooltip.LastInspectRequest
				ilvlspectooltip.NextUpdate = (LastInspectTime > InspectFreq) and InspectDelay or (InspectFreq - LastInspectTime + InspectDelay)
				ilvlspectooltip:Show()
			end
		else
			ILevel = GetItemLevel("player") or UNKNOWN
			TalentSpec = GetTalentSpec() or NONE
		end
	end
	if (UnitIsPlayer(Unit) and UnitIsFriend("player", Unit)) then
		GameTooltip:AddLine(STAT_AVERAGE_ITEM_LEVEL..": |cff00BFFF"..ILevel.."|r")
		GameTooltip:AddLine(SPECIALIZATION..": |cff00BFFF"..TalentSpec.."|r")
	end	
	GameTooltip.fadeOut = nil
end
GameTooltip:HookScript('OnTooltipSetUnit', OnTooltipSetUnit)