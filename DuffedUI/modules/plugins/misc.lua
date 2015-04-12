local D, C, L = unpack(select(2, ...))

--[[Quest Rewards]]--
local QuestReward = CreateFrame("Frame")
QuestReward:SetScript("OnEvent", function(self, event, ...) self[event](...) end)

local metatable = {
	__call = function(methods, ...)
		for _, method in next, methods do method(...) end
	end
}

local modifier = false
function QuestReward:Register(event, method, override)
	local newmethod
	local methods = self[event]

	if methods then
		self[event] = setmetatable({methods, newmethod or method}, metatable)
	else
		self[event] = newmethod or method
		self:RegisterEvent(event)
	end
end

local cashRewards = {
	[45724] = 1e5, -- Champion's Purse
	[64491] = 2e6, -- Royal Reward
}

QuestReward:Register("QUEST_COMPLETE", function()
	local choices = GetNumQuestChoices()
	if choices > 1 then
		local bestValue, bestIndex = 0

		for index = 1, choices do
			local link = GetQuestItemLink("choice", index)
			if link then
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)
				value = cashRewards[tonumber(string.match(link, "item:(%d+):"))] or value

				if value > bestValue then bestValue, bestIndex = value, index end
			else
				choiceQueue = "QUEST_COMPLETE"
				return GetQuestItemInfo("choice", index)
			end
		end

		if bestIndex then QuestInfoItem_OnClick(QuestInfoRewardsFrame.RewardButtons[bestIndex]) end
	end
end, true)

--[[Fixes for Blizzard issues]]--
hooksecurefunc("StaticPopup_Show", function(which)
	if which == "DEATH" and not UnitIsDeadOrGhost("player") then StaticPopup_Hide("DEATH") end
end)

local function FixTradeSkillReagents()
	local function TradeSkillReagent_OnClick(self)
		if IsModifiedClick() then
			local link, name = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, self:GetID())
			if not link then
				name, link = GameTooltip:GetItem()
				if name == self.name:GetText() then HandleModifiedItemClick(link) end
			end
		end
	end
	
	for i = 1, 8 do _G["TradeSkillReagent"..i]:HookScript("OnClick", TradeSkillReagent_OnClick) end
end

if TradeSkillReagent1 then
	FixTradeSkillReagents()
else
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(f, e, a)
		if a == "Blizzard_TradeSkillUI" then
			FixTradeSkillReagents()
			f:UnregisterAllEvents()
			f:SetScript("OnEvent", nil)
		end
	end)
end

--[[Blizzard taint fixes for 5.4.1]]--
setfenv(FriendsFrame_OnShow, setmetatable({ UpdateMicroButtons = function() end }, { __index = _G }))

--[[Taintfix for Talents & gylphs]]--
local function hook()
	PlayerTalentFrame_Toggle = function()
	if not PlayerTalentFrame:IsShown() then
		ShowUIPanel(PlayerTalentFrame)
		TalentMicroButtonAlert:Hide()
	else
		PlayerTalentFrame_Close()
	end 
end

for i = 1, 10 do
	local tab = _G["PlayerTalentFrameTab"..i]
	if not tab then break end
		tab:SetScript("PreClick", function()
			for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
				local frame = _G["StaticPopup"..index]
				if not issecurevariable(frame, "which") then
					local info = StaticPopupDialogs[frame.which]
					if (frame:IsShown() and info) and not issecurevariable(info, "OnCancel") then info.OnCancel() end
					frame:Hide()
					frame.which = nil
				end
			end
		end)
	end
end

if IsAddOnLoaded("Blizzard_TalentUI") then
	hook()
else
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event, addon)
		if addon=="Blizzard_TalentUI" then 
			self:UnregisterEvent("ADDON_LOADED")
			hook()
		end
	end)
end

--[[Farmmode]]--
local farm = false
local minisize = 144
local farmsize = 300
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		DuffedUIMinimap:SetSize(farmsize, farmsize)
		Minimap:SetSize(farmsize, farmsize)
		farm = true
		print("Farm Mode : On")
	else
		DuffedUIMinimap:SetSize(minisize, minisize)
		Minimap:SetSize(minisize, minisize)
		farm = false
		print("Farm Mode : Off")
	end

	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"

--[[Automatic achievement screenshot]]--
if C["misc"].acm_screen == true then
	local function TakeScreen(delay, func, ...)
		local waitTable = {}
		local waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate", function (self, elapse)
			local count = #waitTable
			local i = 1
			while (i <= count) do
				local waitRecord = tremove(waitTable, i)
				local d = tremove(waitRecord, 1)
				local f = tremove(waitRecord, 1)
				local p = tremove(waitRecord, 1)
				if d > elapse then
					tinsert(waitTable, i, {d-elapse, f, p})
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
		tinsert(waitTable, {delay, func, {...}})
	end

	local function OnEvent(...) TakeScreen(1, Screenshot) end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ACHIEVEMENT_EARNED")
	frame:SetScript("OnEvent", OnEvent)
end

--[[Dispel Announcement]]--
if C["duffed"].dispelannouncement == true then
	local textcolor = "|cff00ff00"
	font = D.Font(C["font"].datatext)

	local f = CreateFrame("MessageFrame", "dDispelFrame", UIParent)
	f:SetPoint("TOP", 0, -220)
	f:SetSize(200, 100)
	f:SetFontObject(font)
	f:SetShadowOffset(1, -1)
	f:SetShadowColor(0,0,0)
	f:SetTimeVisible(2)
	f:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground"})
	f:SetBackdropColor(0,0,0,0)
	f:SetMovable(true)
	f:SetFrameStrata("HIGH")
	f:SetInsertMode("TOP")
	f:SetJustifyH("CENTER")
	f:SetClampedToScreen(true)
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	f:SetScript("OnEvent", function(self, event, ...)
		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
		if (eventType == "SPELL_DISPEL" or eventType == "SPELL_STOLEN") and sourceName == UnitName("player") then f:AddMessage("- "..textcolor..select(14, ...), 1, 1, 1) end
	end)

	DuffedC = {
		["dispel"] = true,
	}
	local dc = DuffedC
	SLASH_DUFFED1 = "/duffed"
	SlashCmdList["DUFFED"] = function(msg)
		if (msg == "dispel") and C["duffed"].dispelannouncement then
			if dc.dispel then
				dc.dispel = false
				dDispelFrame:AddMessage("- "..textcolor.."around!", 1, 1, 1)
				dDispelFrame:AddMessage("- "..textcolor.."Dispelframe", 1, 1, 1)
				dDispelFrame:AddMessage("- "..textcolor.."Move", 1, 1, 1)
				dDispelFrame:SetTimeVisible(999)
				dDispelFrame:EnableMouse(true)
				dDispelFrame:SetScript("OnMouseDown", function() f:StartMoving() end)
				dDispelFrame:SetScript("OnMouseUp", function() f:StopMovingOrSizing() end)
				dDispelFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
				print("Frame |cffff0000unlocked.")
			else
				dc.dispel = true
				dDispelFrame:SetTimeVisible(2)
				dDispelFrame:EnableMouse(false)
				dDispelFrame:SetBackdropColor(0,0,0,0)
				print("Frame |cff00ff00locked.")
			end
		else
			print(" ")
			print("Duffed Slash commands:")
			if C["duffed"].dispelannouncement then print("   |cffce3a19/duffed dispel|r - unlock/lock Dispel Frame.") end
		end
	end
end

--[[Drink Announcement]]--
if C["duffed"].drinkannouncement == true then
	local function Update(self, event, ...)
		if event == "UNIT_SPELLCAST_SUCCEEDED" then
			local unit, spellName, spellrank, spelline, spellID = ...
			if GetZonePVPInfo() == "arena" then
				if UnitIsEnemy("player", unit) and (spellID == 80167 or spellID == 94468 or spellID == 43183 or spellID == 57073 or spellName == "Trinken") then SendChatMessage(UnitName(unit).." is drinking.", "PARTY") end
			end
		end
	end

	local f = CreateFrame("Frame")
	f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	f:SetScript("OnEvent", Update)
end

--[[Shorten gold display]]--
if C["misc"].gold == true then
	local frame = CreateFrame("FRAME", "DuffedGold")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("MAIL_SHOW")
	frame:RegisterEvent("MAIL_CLOSED")

	local function eventHandler(self, event, ...)
		if event == "MAIL_SHOW" then
			COPPER_AMOUNT = "%d Copper"
			SILVER_AMOUNT = "%d Silver"
			GOLD_AMOUNT = "%d Gold"
		else
			COPPER_AMOUNT = "%d|cFF954F28"..COPPER_AMOUNT_SYMBOL.."|r"
			SILVER_AMOUNT = "%d|cFFC0C0C0"..SILVER_AMOUNT_SYMBOL.."|r"
			GOLD_AMOUNT = "%d|cFFF0D440"..GOLD_AMOUNT_SYMBOL.."|r"
		end
		YOU_LOOT_MONEY = "+%s"
		LOOT_MONEY_SPLIT = "+%s"
	end
	frame:SetScript("OnEvent", eventHandler)
end

--[[Interrupt Announcement]]--
if C["duffed"].sayinterrupt == true then
	local f = CreateFrame("Frame")
	local function Update(self, event, ...)
		if not C["duffed"].sayinterrupt then return end
		
		if event == "COMBAT_LOG_EVENT_UNFILTERED" then
			if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				channel = "INSTANCE_CHAT"
			elseif IsInRaid("player") then
				channel = C["duffed"].announcechannel
			elseif IsInGroup("player") then
				channel = C["duffed"].announcechannel
			else
				channel = "SAY"
			end
			
			local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _, extraskillID, extraSkillName = ...
			if eventType == "SPELL_INTERRUPT" and sourceName == UnitName("player") then SendChatMessage("Interrupted => "..GetSpellLink(extraskillID).."!", channel) end
		end
	end
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	f:SetScript("OnEvent", Update)
end