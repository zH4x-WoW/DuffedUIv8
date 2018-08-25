local D, C, L = unpack(select(2, ...))

local _G = _G

local function LoadIslandQueueUISkin()
    local IslandsFrame = _G['IslandsQueueFrame']
    IslandsFrame:StripTextures()
    IslandsFrame:SetTemplate('Transparent')
    IslandsQueueFrame.ArtOverlayFrame.PortraitFrame:SetAlpha(0)
    IslandsQueueFrame.ArtOverlayFrame.portrait:SetAlpha(0)
    IslandsQueueFrame.portrait:Hide()
    IslandsQueueFrameCloseButton:SkinCloseButton()
    IslandsFrame.DifficultySelectorFrame:StripTextures()
    IslandsFrame.DifficultySelectorFrame.QueueButton:SkinButton()

    local WeeklyQuest = IslandsFrame.WeeklyQuest
    local StatusBar = WeeklyQuest.StatusBar
    WeeklyQuest.OverlayFrame:StripTextures()

    StatusBar:SetStatusBarTexture(C['media']['normTex'])
    StatusBar:CreateBackdrop('Default')
    StatusBar:SetStatusBarColor(unpack(D['UnitColor']['class'][D.Class]))
    WeeklyQuest.QuestReward.Icon:SetTexCoord(unpack(D['IconCoord']))

    local TutorialFrame = IslandsFrame.TutorialFrame
    TutorialFrame.Leave:SkinButton()
    TutorialFrame.CloseButton:SkinCloseButton()
end
D['SkinFuncs']['Blizzard_IslandsQueueUI'] = LoadIslandQueueUISkin

local function LoadIslandPoseSkin()
	local IslandsPartyPoseFrame = _G['IslandsPartyPoseFrame']
	IslandsPartyPoseFrame:StripTextures()
	IslandsPartyPoseFrame:CreateBackdrop('Transparent')
	IslandsPartyPoseFrame.LeaveButton:SkinButton()
end
D['SkinFuncs']['Blizzard_IslandsPartyPoseUI'] = LoadIslandPoseSkin