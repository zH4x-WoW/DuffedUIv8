--[[brokenneeds rework]]--
--[[local D, C, L = unpack(select(2, ...))
if not C['misc']['artifact'] then return end

local LAP = LibStub("LibArtifactPower-1.0")
local barHeight, barWidth = C['misc']['artifactheight'], C['misc']['artifactwidth']
local barTex, flatTex = C['media']['normTex']
local color = RAID_CLASS_COLORS[D.Class]
local move = D['move']

local backdrop = CreateFrame('Frame', 'Artifact_Backdrop', UIParent)
backdrop:SetSize(barWidth, barHeight)
backdrop:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -392, 5)
backdrop:SetBackdropColor(C['general']['backdropcolor'])
backdrop:SetBackdropBorderColor(C['general']['backdropcolor'])
backdrop:CreateBackdrop('Transparent')
backdrop:SetFrameStrata('LOW')
move:RegisterFrame(backdrop)

local artifactBar = CreateFrame('StatusBar',  'Experience_artifactBar', backdrop, 'TextStatusBar')
artifactBar:SetWidth(barWidth)
artifactBar:SetHeight(barHeight)
artifactBar:SetPoint('TOP', backdrop, 'TOP', 0, 0)
artifactBar:SetStatusBarTexture(barTex)
artifactBar:SetStatusBarColor(157/255, 138/255, 108/255)
artifactBar:SetFrameLevel(backdrop:GetFrameLevel() + 2)

local artifactBarBag = CreateFrame('StatusBar',  'Experience_artifactBarBag', backdrop, 'TextStatusBar')
artifactBarBag:SetWidth(barWidth)
artifactBarBag:SetHeight(barHeight)
artifactBarBag:SetPoint('TOP', backdrop, 'TOP', 0, 0)
artifactBarBag:SetStatusBarTexture(barTex)
artifactBarBag:SetStatusBarColor(color.r, color.g, color.b)
artifactBarBag:SetFrameLevel(backdrop:GetFrameLevel() + 1)

local ArtifactmouseFrame = CreateFrame('Frame', 'Artifact_mouseFrame', backdrop)
ArtifactmouseFrame:SetAllPoints(backdrop)
ArtifactmouseFrame:EnableMouse(true)
ArtifactmouseFrame:SetFrameLevel(backdrop:GetFrameLevel() + 3)

local function GetKnowledgeLevelFromItemLink(itemLink)
	local upgradeID = select(15, string.split(":", itemLink))
	local knowledgeLevel = tonumber(upgradeID) - 1
	return knowledgeLevel
end

local apItemCache = {}
local function GetAPForItem(itemLink)
	if (apItemCache[itemLink] ~= nil) then return apItemCache[itemLink] end

	if (LAP:DoesItemGrantArtifactPower(itemLink)) then
		local knowledgeLevel = GetKnowledgeLevelFromItemLink(itemLink)
		local apValue = LAP:GetArtifactPowerGrantedByItem(itemLink, knowledgeLevel)

		apItemCache[itemLink] = apValue
		return apValue
	end
	return 0
end

local function GetArtifactPowerInBags()
	BagArtifactPower = 0
	local itemLink, AP
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = select(7, GetContainerItemInfo(bag, slot))

			if (itemLink) then
				AP = GetAPForItem(itemLink)
				BagArtifactPower = BagArtifactPower + AP
			end
		end
	end
	return BagArtifactPower
end

function updateStatus()
	local hAE = HasArtifactEquipped()

	if hAE then
		local _, _, _, _, totalxp, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
		local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalxp, artifactTier)
		local apInBags = GetArtifactPowerInBags()

		backdrop:Show()
		artifactBar:SetMinMaxValues(min(0, xp), xpForNextPoint)
		artifactBar:SetValue(xp)
		artifactBar:SetOrientation('VERTICAL')
		if (apInBags and apInBags > 0) then
			artifactBarBag:SetMinMaxValues(0, xpForNextPoint)
			artifactBarBag:SetValue(xp + apInBags)
			artifactBarBag:SetOrientation('VERTICAL')
		else
			artifactBarBag:SetMinMaxValues(0, 1)
			artifactBarBag:SetValue(0)
			artifactBarBag:SetOrientation('VERTICAL')
		end
	else
		backdrop:Hide()
	end
	
	ArtifactmouseFrame:SetScript('OnMouseDown', function()
		if not ArtifactFrame then LoadAddOn('Blizzard_ArtifactUI') end
		
		if hAE then
			local frame = ArtifactFrame
			local activeID = C_ArtifactUI.GetArtifactInfo()
			local equippedID = C_ArtifactUI.GetEquippedArtifactInfo()
		
			if frame:IsShown() and activeID == equippedID then HideUIPanel(frame) else SocketInventoryItem(16) end
		end
	end)
	
	ArtifactmouseFrame:SetScript('OnEnter', function()
		GameTooltip:SetOwner(ArtifactmouseFrame, 'ANCHOR_TOPRIGHT', 2, 5)
		GameTooltip:ClearLines()
		if hAE then
			local _, _, _, _, totalxp, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
			local numPointsAvailableToSpend, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalxp, artifactTier)
			local apInBags = GetArtifactPowerInBags()

			GameTooltip:AddLine(L['artifactBar']['xptitle'])
			GameTooltip:AddDoubleLine(L['artifactBar']['xp'], string.format(' %s / %s (%d%%)', D['ShortValue'](xp), D['ShortValue'](xpForNextPoint), xp/xpForNextPoint * 100), 1, 1, 1)
			GameTooltip:AddDoubleLine(L['artifactBar']['xpremaining'],string.format(' %s (%d%%)', D['ShortValue'](xpForNextPoint - xp), (xpForNextPoint - xp) / xpForNextPoint * 100), 1, 1, 1)
			GameTooltip:AddDoubleLine(L['artifactBar']['bags'], string.format(' %s (%d%%)',D['ShortValue'](apInBags), apInBags / xpForNextPoint * 100), 1, 1, 1)
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(L['artifactBar']['click'])
		end
		GameTooltip:Show()
	end)
	ArtifactmouseFrame:SetScript('OnLeave', function() GameTooltip:Hide() end)
end

local frame = CreateFrame('Frame',nil,UIParent)
frame:RegisterEvent('ARTIFACT_XP_UPDATE')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:RegisterEvent('UNIT_INVENTORY_CHANGED')
frame:SetScript('OnEvent', updateStatus)]]--