local D, C, L = unpack(select(2, ...))

local QuestPOIGetIconInfo, GetNumQuestWatches, GetSuperTrackedQuestID, GetDistanceSqToQuest, QuestHasPOIInfo = QuestPOIGetIconInfo, GetNumQuestWatches, GetSuperTrackedQuestID, GetDistanceSqToQuest, QuestHasPOIInfo
local questsDis, orderedIndexes, GetQuestWatchInfo_old = {}, {}, GetQuestWatchInfo
local protectionTime = 0
local data = DuffedUIDataPerChar

local function ComparatorDist(id1, id2)
    local d1, d2 = questsDis[id1], questsDis[id2]
    if d1 < 0 and d2 >= 0 then return false end
    if d2 < 0 and d1 >= 0 then return true end
    return d1 < d2
end

--[[
function QSCalcDistance(questID)
    local _, x, y = QuestPOIGetIconInfo(questID)
    local px, py = GetPlayerMapPosition("player")
    x = x * 10000 y = y * 10000 px = px * 10000 py = py * 10000
    local d1 = ((px-x)*(px-x) + (py-y)*(py-y))
    local qI = GetQuestLogIndexByID(questID)
    local d2 = GetDistanceSqToQuest(qI)
    print(GetQuestLogTitle(qI), d1, d2, x, y, px, py)
end
--]]

local function UpdateQuestsDistance()
    if (QuestMapFrame and QuestMapFrame:IsVisible()) or not data.enabled or GetNumQuestWatches() < 1 then return end

    wipe(questsDis)
    wipe(orderedIndexes)

    --see Blizzard's QuestSuperTracking_ChooseClosestQuest
    for i = 1, GetNumQuestWatches() do
        orderedIndexes[i] = i
        local questID, title, questLogIndex = GetQuestWatchInfo_old(i)
        if ( questID and QuestHasPOIInfo(questID) ) then
            local distSqr, onContinent = GetDistanceSqToQuest(questLogIndex)
            if ( onContinent ) then questsDis[i] = distSqr else questsDis[i] = i - 1000 end
        else
            questsDis[i] = i - 1000 -- < 0 and keep the order
        end
    end

    table.sort(orderedIndexes, ComparatorDist)

    local nearest = questsDis[orderedIndexes[1]]
    -- if the nearest is on the same map
    if nearest and nearest > 0 then
        --select super track, no need to call QuestSuperTracking_ChooseClosestQuest
        local questID, questLogTitle, questLogIndex = GetQuestWatchInfo_old(orderedIndexes[1])
        if (GetTime() > protectionTime and questID ~= GetSuperTrackedQuestID()) then
            --avoid frequent switching
            local currDist = GetDistanceSqToQuest(GetQuestLogIndexByID(GetSuperTrackedQuestID()))
            if currDist and currDist - nearest > nearest * 0.07 + 1000 then
                SetSuperTrackedQuestID(questID)
                PlaySound(31581)
                WorldMapFrame_OnUserChangedSuperTrackedQuest(questID)
            end
        end

        -- force update
        if ObjectiveTrackerFrame and ObjectiveTrackerFrame:IsVisible() then
            ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST)
        end
    end
end

local function GetQuestWatchInfo_new(id)
    if(orderedIndexes and #orderedIndexes > 0) then return GetQuestWatchInfo_old(orderedIndexes[id] or id) else return GetQuestWatchInfo_old(id) end
end

local frame = CreateFrame("Frame", "QuestWatchSortEventFrame")
frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
frame:RegisterEvent("QUEST_AUTOCOMPLETE")
frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("SCENARIO_UPDATE")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("ZONE_CHANGED")
frame:RegisterEvent("QUEST_POI_UPDATE")
frame:RegisterEvent("QUEST_TURNED_IN")
frame:RegisterEvent("VARIABLES_LOADED")

local function EnableOrDisable()
    if data.enabledquestsorting then
        if not frame.hooked then
            frame.hooked = 1
            GetQuestWatchInfo_old = GetQuestWatchInfo
            GetQuestWatchInfo = GetQuestWatchInfo_new
        end
        protectionTime = 0
        frame:Show()
    else
        frame:Hide()
    end
end

frame:SetScript("OnEvent", function(self, event)
    if(event == "VARIABLES_LOADED") then
        data = data or { enabledquestsorting = true }
        QuestWatchSortCheckButton:SetChecked(data.enabledquestsorting)
        EnableOrDisable()
    else
        UpdateQuestsDistance()
    end
end)


local timer = 0
frame:SetScript("OnUpdate", function(self, elapsed)
    timer = timer + elapsed
    if timer > 0.5 then
        timer = 0
        UpdateQuestsDistance()
    end
end)

-- prevent blocking message
if WorldMapFrame.UIElementsFrame and WorldMapFrame.UIElementsFrame.ActionButton then
    local isEventRegistered
    hooksecurefunc(WorldMapFrame.UIElementsFrame.ActionButton, "UnregisterEvent", function(self, event)
        if (event == "UNIT_SPELLCAST_SUCCEEDED" and InCombatLockdown()) then
            local eventFrame = BaudErrorFrame or UIParent
            isEventRegistered = eventFrame:IsEventRegistered("ADDON_ACTION_BLOCKED")
            if isEventRegistered then eventFrame:UnregisterEvent("ADDON_ACTION_BLOCKED") end
        end
    end)

    hooksecurefunc(WorldMapFrame.UIElementsFrame.ActionButton, "IsUsingAction", function(self)
        if isEventRegistered then
            isEventRegistered = nil
            local eventFrame = BaudErrorFrame or UIParent
            eventFrame:RegisterEvent("ADDON_ACTION_BLOCKED")
        end
    end)
end

--If player manually click track button, hold for some time.
hooksecurefunc(ObjectiveTrackerFrame.BlocksFrame, "poiOnCreateFunc", function(button)
    if not button._hooked then
        button._hooked = 1
        button:HookScript("OnClick", function(self)
            local questID = self.questID
            local questLogIndex = GetQuestLogIndexByID(questID)
            if ( not IsShiftKeyDown() ) then protectionTime = GetTime() + 5 end
        end)
    end
end)

--UI
local checkbox = CreateFrame("CheckButton", "QuestWatchSortCheckButton", ObjectiveTrackerFrame, "UICheckButtonTemplate")
checkbox:SetParent(ObjectiveTrackerBlocksFrame.QuestHeader)
checkbox:RegisterForClicks("AnyUp")
checkbox:SetWidth(22)
checkbox:SetHeight(22)
checkbox.text:SetText("")
checkbox:SetPoint("BOTTOMRIGHT", ObjectiveTrackerBlocksFrame.QuestHeader, "BOTTOMLEFT", 5, 2)
checkbox:SetScript("OnClick", function(self, button)
    data.enabled = self:GetChecked()
    EnableOrDisable()
end)

checkbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self)
    GameTooltip:ClearLines()
    GameTooltip:AddLine("Sort Quests")
	GameTooltip:AddLine("Sort quest watches by distance of objectives.", 1, 1, 1, true)
    GameTooltip:Show()
end)
checkbox:SetScript("OnLeave", function() GameTooltip:Hide() end)