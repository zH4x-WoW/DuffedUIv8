local D, C, L = select(2, ...):unpack()

local _G = _G
local Quests = D["Quests"]

function Quests:CreateWatchFrameAnchor()
	local WatchFrame = CreateFrame("Frame", nil, UIParent)
	local WatchFrameCollapseExpandButton = WatchFrameCollapseExpandButton
	local WatchFrameTitle = WatchFrameTitle
	local WatchFrameLines = WatchFrameLines
	
	WatchFrame:SetFrameStrata("HIGH")
	WatchFrame:SetFrameLevel(20)
	WatchFrame:SetHeight(20)
	WatchFrame:SetWidth(250)
	WatchFrame:SetClampedToScreen(true)
	WatchFrame:SetMovable(true)
	WatchFrame:EnableMouse(false)
	WatchFrame:Point("TOPRIGHT", UIParent, -210, -220)
	
	WatchFrameCollapseExpandButton:SetNormalTexture("")
	WatchFrameCollapseExpandButton:SetPushedTexture("")
	WatchFrameCollapseExpandButton:SetHighlightTexture("")
	WatchFrameCollapseExpandButton:SkinCloseButton()
	WatchFrameCollapseExpandButton:HookScript("OnClick", function(self)
		local Collapsed = _G["WatchFrame"].collapsed
		
		if Collapsed then 
			self.Text:SetText("V") 
		else 
			self.Text:SetText("X")
		end 
	end)
	
	WatchFrameTitle:Kill()
	WatchFrameLines:StripTextures()
	
	self.WatchFrame = WatchFrame
end

function Quests:PositionWatchFrame()
	local ScreenHeight = D.ScreenHeight
	WatchFrame:Show()
	WatchFrame:SetParent(self.WatchFrame)
	WatchFrame:SetHeight(ScreenHeight / 1.6)
	WatchFrame:ClearAllPoints()
	WatchFrame:SetPoint("TOP", self.WatchFrame)
end

function Quests:SkinWatchFrameButton()
	if not self.IsSkinned then
		local Texture = _G[self:GetName().."IconTexture"]
		
		self:SkinButton()
		self:StyleButton()
		
		Texture:SetTexCoord(unpack(D.IconCoord))
		Texture:SetInside()
		
		self.IsSkinned = true
	end
end

function Quests:SkinWatchFramePopup(i)
	local frame = _G["WatchFrameAutoQuestPopUp"..i.."ScrollChild"]
	if frame and not frame.isSkinned then
		local parent = frame:GetParent()
		frame:StripTextures()
		parent:CreateBackdrop("Transparent")
		parent.Backdrop:ClearAllPoints()
		parent.Backdrop:SetPoint("TOPLEFT", frame, 0, 5)
		parent.Backdrop:SetPoint("BOTTOMRIGHT", frame, 13, -5)
		parent.Backdrop:CreateShadow()
		frame.isSkinned = true
	end
end

function Quests:AddWatchFrameHooks()
	hooksecurefunc("WatchFrameItem_UpdateCooldown", self.SkinWatchFrameButton)
	hooksecurefunc("WatchFrameAutoQuest_GetOrCreateFrame", self.SkinWatchFramePopup)
end