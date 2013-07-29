local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = D["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local Replace = string.gsub
local SpellFlyout = SpellFlyout
local FlyoutButtons = 0
local Size = C["ActionBars"].NormalButtonSize
local PetSize = C["ActionBars"].PetButtonSize
local Spacing = C["ActionBars"].ButtonSpacing
local ActionButton_HideOverlayGlow = ActionButton_HideOverlayGlow
local ProcBackdrop = {
	edgeFile = C["Media"].Blank, edgeSize = D.Mult,
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
	
	if (Btname and Normal and C["ActionBars"].Macro) then
		local String = GetActionText(Action)
		
		if String then
			local Text = string.sub(String, 1, 5)
			Btname:SetText(Text)
		end
	end
	
	if (Button.isSkinned) then
		return
	end
	
	Count:SetFont(C["Media"].Font, 12, "OUTLINE")
	
	if (Btname) then
		if (C["ActionBars"].Macro) then
			Btname:SetFont(C["Media"].Font, 10)
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
 
	if (C["ActionBars"].HotKey) then
		HotKey:SetFont(C["Media"].Font, 10, "OUTLINE")
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
		local Normal  = _G[Name.."NormalTexture2"]
		
		DuffedUIActionBars:SkinPetAndShiftButton(Normal, Button, Icon, Name, true)
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

-- NOTE: Try to find a better animation for this.
function DuffedUIActionBars:StartButtonHighlight()
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
end

function DuffedUIActionBars:StopButtonHighlight()
	if self.Animation and self.Animation:IsPlaying() then
		self.Animation:Stop()
		self.NewProc:Hide()
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

hooksecurefunc("ActionButton_Update", DuffedUIActionBars.SkinButton)
hooksecurefunc("ActionButton_UpdateFlyout", DuffedUIActionBars.StyleFlyout)
hooksecurefunc("ActionButton_ShowOverlayGlow", DuffedUIActionBars.StartButtonHighlight)
hooksecurefunc("ActionButton_HideOverlayGlow", DuffedUIActionBars.StopButtonHighlight)
hooksecurefunc("ActionButton_UpdateHotkeys", DuffedUIActionBars.UpdateHotKey)