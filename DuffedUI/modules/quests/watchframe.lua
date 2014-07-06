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
	
	-- Quest / achievement link URLs
	local lST = "Wowhead"
	local lQ = "http://www.wowhead.com/quest=%d"
	local lA = "http://www.wowhead.com/achievement=%d"
	
	_G.StaticPopupDialogs["WATCHFRAME_URL"] = {
		text = lST .. " link",
		button1 = OKAY,
		timeout = 0,
		whileDead = true,
		hasEditBox = true,
		editBoxWidth = 350,
		OnShow = function(self, ...) self.editBox:SetFocus() end,
		EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	}
	
	local tblDropDown = {}
	hooksecurefunc("WatchFrameDropDown_Initialize", function(self)
		if self.type == "QUEST" then
			tblDropDown = {
				text = lST .. " link",
				notCheckable = true,
				arg1 = self.index,
				func = function(_, watchId)
					local logId = GetQuestIndexForWatch(watchId)
					local _, _, _, _, _, _, _, _, questId = GetQuestLogTitle(logId)
					local inputBox = StaticPopup_Show("WATCHFRAME_URL")
					inputBox.editBox:SetText(lQ:format(questId))
					inputBox.editBox:HighlightText()
				end
			}
			UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
		elseif self.type == "ACHIEVEMENT" then
			tblDropDown = {
				text = lST .. " link",
				notCheckable = true,
				arg1 = self.index,
				func = function(_, id)
					local inputBox = StaticPopup_Show("WATCHFRAME_URL")
					inputBox.editBox:SetText(lA:format(id))
					inputBox.editBox:HighlightText()
				end
			}
			UIDropDownMenu_AddButton(tblDropDown, UIDROPDOWN_MENU_LEVEL)
		end
	end)
	UIDropDownMenu_Initialize(WatchFrameDropDown, WatchFrameDropDown_Initialize, "MENU")
	
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