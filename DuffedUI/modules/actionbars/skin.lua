local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = D["ActionBars"]
local Font = D.GetFont(C["actionbars"].Font)
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local Replace = string.gsub
local SpellFlyout = SpellFlyout
local FlyoutButtons = 0
local Size = C["actionbars"].NormalButtonSize
local PetSize = C["actionbars"].PetButtonSize
local Spacing = C["actionbars"].ButtonSpacing
local ActionButton_HideOverlayGlow = ActionButton_HideOverlayGlow
local ProcBackdrop = {
	edgeFile = C["medias"].Blank, edgeSize = D.Mult,
	insets = {left = D.Mult, right = D.Mult, top = D.Mult, bottom = D.Mult},
}

function DuffedUIActionBars:SkinButton()
	local Name = self:GetName()
	local Action = self.action
	local Button = self
	local Icon = _G[Name.."Icon"]
	local Count = _G[Name.."Count"]
	local Flash	 = _G[Name.."Flash"]
	local HotKey = _G[Name.."HotKey"]
	local Border  = _G[Name.."Border"]
	local Btname = _G[Name.."Name"]
	local Normal  = _G[Name.."NormalTexture"]
	local BtnBG = _G[Name.."FloatingBG"]
 
	Flash:SetTexture("")
	Button:SetNormalTexture("")
 
	Count:ClearAllPoints()
	Count:Point("BOTTOMRIGHT", 0, 2)
	
	HotKey:ClearAllPoints()
	HotKey:Point("TOPRIGHT", 0, -3)
	
	if (Border and Border:IsShown()) then
		Border:Hide()
		Border = Noop
	end
	
	if (Btname and Normal and C["actionbars"].Macro) then
		local String = GetActionText(Action)
		
		if String then
			local Text = string.sub(String, 1, 5)
			Btname:SetText(Text)
		end
	end
	
	if (Button.isSkinned) then
		return
	end
	
	Count:SetFontObject(Font)
	
	if (Btname) then
		if (C["actionbars"].Macro) then
			Btname:SetFontObject(Font)
			Btname:ClearAllPoints()
			Btname:SetPoint("BOTTOM", 1, 1)
		else
			Btname:SetText("")
			Btname:Kill()
		end
	end
	
	if (BtnBG) then
		BtnBG:Kill()
	end
 
	if (C["actionbars"].HotKey) then
		ActionButton_UpdateHotkeys(self, self.buttonType)
		
		HotKey:SetFontObject(Font)
		HotKey.ClearAllPoints = Noop
		HotKey.SetPoint = Noop
	else
		HotKey:SetText("")
		HotKey:Kill()
	end
	
	if (Name:match("Extra")) then
		Button:SetTemplate()
		Button.Pushed = true
		Icon:SetDrawLayer("ARTWORK")
	else
		Button:CreateBackdrop()
		Button.Backdrop:SetOutside(Button, 0, 0)	
		Button:UnregisterEvent("ACTIONBAR_SHOWGRID")
		Button:UnregisterEvent("ACTIONBAR_HIDEGRID")			
	end
	
	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:SetInside()
	
	if (Normal) then
		Normal:ClearAllPoints()
		Normal:SetPoint("TOPLEFT")
		Normal:SetPoint("BOTTOMRIGHT")
		
		if (Button:GetChecked()) then
			ActionButton_UpdateState(Button)
		end
	end
	
	Button:StyleButton()
	Button.isSkinned = true
end

function DuffedUIActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, Pet)
	if Button.isSkinned then return end
	
	Button:SetWidth(PetSize)
	Button:SetHeight(PetSize)
	Button:CreateBackdrop()
	Button.Backdrop:SetOutside(Button, 0, 0)
	
	Icon:SetTexCoord(unpack(D.IconCoord))
	Icon:ClearAllPoints()
	Icon:SetInside()
	
	if (Pet) then			
		if (PetSize < 30) then
			local AutoCast = _G[Name.."AutoCastable"]
			AutoCast:SetAlpha(0)
		end
		
		local Shine = _G[Name.."Shine"]
		Shine:Size(PetSize)
		Shine:ClearAllPoints()
		Shine:Point("CENTER", Button, 0, 0)
	end
	
	Button:SetNormalTexture("")
	Button.SetNormalTexture = Noop
	
	local Flash	 = _G[Name.."Flash"]
	Flash:SetTexture("")
	
	if Normal then
		Normal:ClearAllPoints()
		Normal:SetPoint("TOPLEFT")
		Normal:SetPoint("BOTTOMRIGHT")
	end
	
	Button:StyleButton()
	Button.isSkinned = true
end

function DuffedUIActionBars:SkinPetButtons()
	for i = 1, NUM_PET_ACTION_SLOTS do
		local Name = "PetActionButton"..i
		local Button  = _G[Name]
		local Icon  = _G[Name.."Icon"]
		local Normal  = _G[Name.."NormalTexture2"] -- ?? 2
		
		DuffedUIActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, true)
	end
end

function DuffedUIActionBars:SkinStanceButtons()
	for i=1, NUM_STANCE_SLOTS do
		local Name = "StanceButton"..i
		local Button  = _G[Name]
		local Icon  = _G[Name.."Icon"]
		local Normal  = _G[Name.."NormalTexture"]
		
		DuffedUIActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, false)
	end
end

function DuffedUIActionBars:SetupFlyoutButton()
	for i = 1, FlyoutButtons do
		local Button = _G["SpellFlyoutButton"..i]
		
		if Button then
			DuffedUIActionBars.SkinButton(Button)
			
			if Button:GetChecked() then
				Button:SetChecked(nil)
			end
		end
	end
end
SpellFlyout:HookScript("OnShow", DuffedUIActionBars.SetupFlyoutButton)

function DuffedUIActionBars:StyleFlyout()
	if not self.FlyoutArrow then return end
	
	local HB = SpellFlyoutHorizontalBackground
	local VB = SpellFlyoutVerticalBackground
	local BE = SpellFlyoutBackgroundEnd
	
	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	HB:SetAlpha(0)
	VB:SetAlpha(0)
	BE:SetAlpha(0)
	
	for i = 1, GetNumFlyouts() do
		local ID = GetFlyoutID(i)
		local _, _, NumSlots, IsKnown = GetFlyoutInfo(ID)
		if IsKnown then
			FlyoutButtons = NumSlots
			break
		end
	end
	
	local arrowDistance
	
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
		arrowDistance = 5
	else
		arrowDistance = 2
	end
	
	if self:GetParent():GetParent():GetName() == "SpellBookSpellIconsFrame" then
		return
	end
	
	if self:GetAttribute("flyoutDirection") ~= nil then
		local point, _, _, _, _ = self:GetParent():GetParent():GetPoint()
		
		if strfind(point, "BOTTOM") then
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
			SetClampedTextureRotation(self.FlyoutArrow, 0)
			if not InCombatLockdown() then
				self:SetAttribute("flyoutDirection", "UP")
			end
		else
			self.FlyoutArrow:ClearAllPoints()
			self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
			SetClampedTextureRotation(self.FlyoutArrow, 270)
			if not InCombatLockdown() then
				self:SetAttribute("flyoutDirection", "LEFT")
			end
		end
	end
end

local ProcBackdrop = {
	edgeFile = C["medias"].Blank, edgeSize = D.Mult,
	insets = {left = D.Mult, right = D.Mult, top = D.Mult, bottom = D.Mult},
}

local ShowOverlayGlow = function(self)
    if self.overlay then
        if (self.overlay.animOut:IsPlaying()) then
            self.overlay.animOut:Stop()
            self.overlay.animIn:Play()
        end
    else
        self.overlay = ActionButton_GetOverlayGlow()
        local frameWidth, frameHeight = self:GetSize()
        self.overlay:SetParent(self)
        self.overlay:ClearAllPoints()
        self.overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4)
        self.overlay:SetPoint("TOPLEFT", self, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2)
        self.overlay:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2)
        self.overlay.animIn:Play()
    end
end
 
local HideOverlayGlow = function(self)
    if self.overlay then
        if self.overlay.animIn:IsPlaying() then
            self.overlay.animIn:Stop()
        end
        if self:IsVisible() then
            self.overlay.animOut:Play()
        else
            ActionButton_OverlayGlowAnimOutFinished(self.overlay.animOut)
        end
    end
end

-- NOTE: Try to find a better animation for this.
function DuffedUIActionBars:StartButtonHighlight()
	if C["actionbars"].BorderHighlight then
		if self.overlay then
			self.overlay:Hide()
			ActionButton_HideOverlayGlow(self)
		end

		if not self.Animation then
			local NewProc = CreateFrame("Frame", nil, self)
			NewProc:SetBackdrop(ProcBackdrop)
			NewProc:SetBackdropBorderColor(1, 1, 0)
			NewProc:SetAllPoints(self)

			self.NewProc = NewProc

			local Animation = self.NewProc:CreateAnimationGroup()
			Animation:SetLooping("BOUNCE")

			local FadeOut = Animation:CreateAnimation("Alpha")
			FadeOut:SetChange(-1)
			FadeOut:SetDuration(0.40)
			FadeOut:SetSmoothing("IN_OUT")

			self.Animation = Animation
		end

		if not self.Animation:IsPlaying() then
			self.Animation:Play()
			self.NewProc:Show()
		end
	else
		if self.overlay then
			if self.NewProc then
				self.NewProc:Hide()
			end
			
			self.overlay:Show()
			ShowOverlayGlow(self)
		else
			HideOverlayGlow(self)
		end
	end
end

function DuffedUIActionBars:StopButtonHighlight()
	if C["actionbars"].BorderHighlight then
		if self.Animation and self.Animation:IsPlaying() then
			self.Animation:Stop()
			self.NewProc:Hide()
		end
	else
		if self.Animation and self.Animation:IsPlaying() then
			self.Animation:Stop()
			self.NewProc:Hide()
		end
	end
end

function DuffedUIActionBars:UpdateHotKey(btype)
	local HotKey = _G[self:GetName() .. "HotKey"]
	local Text = HotKey:GetText()
	local Indicator = _G["RANGE_INDICATOR"]
	
	Text = Replace(Text, "(s%-)", "S")
	Text = Replace(Text, "(a%-)", "A")
	Text = Replace(Text, "(c%-)", "C")
	Text = Replace(Text, "(Mouse Button )", "M")
	Text = Replace(Text, "(Middle Mouse)", "M3")
	Text = Replace(Text, "(Mouse Wheel Up)", "MU")
	Text = Replace(Text, "(Mouse Wheel Down)", "MD")
	Text = Replace(Text, "(Num Pad )", "N")
	Text = Replace(Text, "(Page Up)", "PU")
	Text = Replace(Text, "(Page Down)", "PD")
	Text = Replace(Text, "(Spacebar)", "SpB")
	Text = Replace(Text, "(Insert)", "Ins")
	Text = Replace(Text, "(Home)", "Hm")
	Text = Replace(Text, "(Delete)", "Del")
	
	if HotKey:GetText() == Indicator then
		HotKey:SetText("")
	else
		HotKey:SetText(Text)
	end
end