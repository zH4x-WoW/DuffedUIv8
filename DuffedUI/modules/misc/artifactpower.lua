local D, C, L = unpack(select(2, ...))
if not C["misc"].artifact then return end

local barHeight, barWidth = 5, C["misc"].artifactwidth
local barTex, flatTex = C["media"].normTex
local color = RAID_CLASS_COLORS[D.Class]
local move = D["move"]

local backdrop = CreateFrame("Frame", "Artifact_Backdrop", UIParent)
backdrop:SetSize(barWidth, barHeight)
backdrop:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -7, 178)
backdrop:SetBackdropColor(C["general"].backdropcolor)
backdrop:SetBackdropBorderColor(C["general"].backdropcolor)
backdrop:CreateBackdrop("Transparent")
backdrop:SetFrameStrata("LOW")
move:RegisterFrame(backdrop)

local artifactBar = CreateFrame("StatusBar",  "Experience_artifactBar", backdrop, "TextStatusBar")
artifactBar:SetWidth(barWidth)
artifactBar:SetHeight(barHeight)
artifactBar:SetPoint("TOP", backdrop,"TOP", 0, 0)
artifactBar:SetStatusBarTexture(barTex)
artifactBar:SetStatusBarColor(157/255, 138/255, 108/255)

local ArtifactmouseFrame = CreateFrame("Frame", "Artifact_mouseFrame", backdrop)
ArtifactmouseFrame:SetAllPoints(backdrop)
ArtifactmouseFrame:EnableMouse(true)
ArtifactmouseFrame:SetFrameLevel(3)

local function updateStatus()
	local hAE = HasArtifactEquipped()

	if hAE then
		local _, _, _, _, totalxp, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
		local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalxp, artifactTier)

		backdrop:Show()
		artifactBar:SetMinMaxValues(min(0, xp), xpForNextPoint)
		artifactBar:SetValue(xp)
	else
		backdrop:Hide()
	end
	
	ArtifactmouseFrame:SetScript("OnMouseDown", function()
		if not ArtifactFrame then LoadAddOn("Blizzard_ArtifactUI") end
		
		if hAE then
			local frame = ArtifactFrame
			local activeID = C_ArtifactUI.GetArtifactInfo()
			local equippedID = C_ArtifactUI.GetEquippedArtifactInfo()
		
			if frame:IsShown() and activeID == equippedID then
				HideUIPanel(frame)
			else
				SocketInventoryItem(16)
			end
		end
	end)
	
	ArtifactmouseFrame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(ArtifactmouseFrame, "ANCHOR_TOPRIGHT", 2, 5)
		GameTooltip:ClearLines()
		if hAE then
			local _, _, _, _, totalxp, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
			local numPointsAvailableToSpend, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalxp, artifactTier)

			GameTooltip:AddLine(L["artifactBar"]["xptitle"])
			GameTooltip:AddLine(string.format(L["artifactBar"]["xp"], xp, xpForNextPoint, (xp / xpForNextPoint) * 100))
			GameTooltip:AddLine(string.format(L["artifactBar"]["xpremaining"], xpForNextPoint - xp))
			GameTooltip:AddLine(string.format(L["artifactBar"]["traits"], numPointsAvailableToSpend))
		end
		GameTooltip:Show()
	end)
	ArtifactmouseFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("ARTIFACT_XP_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
frame:SetScript("OnEvent", updateStatus)
