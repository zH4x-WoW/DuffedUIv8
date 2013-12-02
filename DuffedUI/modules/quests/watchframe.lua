local T, C, L = select(2, ...):unpack()

local _G = _G
local Quests = T["Quests"]

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
	local ScreenHeight = T.ScreenHeight
	
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
		
		Texture:SetTexCoord(unpack(T.IconCoord))
		Texture:SetInside()
		
		self.IsSkinned = true
	end
end

function Quests:SkinWatchFramePopup(i)
	local Frame = _G["WatchFrameAutoQuestPopUp"..i.."ScrollChild"]
	
	if Frame and not Frame.IsSkinned then
		local Parent = Frame:GetParent()
		Frame:StripTextures()
		Parent:CreateBackdrop("Transparent")
		Parent.Backdrop:ClearAllPoints()
		Parent.Backdrop:SetPoint("TOPLEFT", Frame, 0, 5)
		Parent.Backdrop:SetPoint("BOTTOMRIGHT", Frame, 13, -5)
		Parent.Backdrop:CreateShadow()
		Frame.IsSkinned = true
	end
end

function Quests:AddWatchFrameHooks()
	hooksecurefunc("WatchFrameItem_UpdateCooldown", self.SkinWatchFrameButton)
	hooksecurefunc("WatchFrameAutoQuest_GetOrCreateFrame", self.SkinWatchFramePopup)
end