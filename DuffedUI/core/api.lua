----------------------------------------------------------------
-- API of DuffedUI
----------------------------------------------------------------

local D, C, L = select(2, ...):unpack()
local Mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C["general"].UIScale
local Scale = function(x) return Mult*math.floor(x/Mult+.5) end
local InOut = C["general"].InOut
local floor = math.floor
local class = select(2, UnitClass("player"))
local texture = C["medias"].Blank
local Noop = function() return end

D.Scale = Scale
D.Mult = Mult

-- [[ API FUNCTIONS ]] --

local function Size(frame, width, height)
	frame:SetSize(Scale(width), Scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(Scale(width))
end

local function Height(frame, height)
	frame:SetHeight(Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = Scale(arg1) end
	if type(arg2)=="number" then arg2 = Scale(arg2) end
	if type(arg3)=="number" then arg3 = Scale(arg3) end
	if type(arg4)=="number" then arg4 = Scale(arg4) end
	if type(arg5)=="number" then arg5 = Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function SetOutside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or (InOut and 2) or 1
	yOffset = yOffset or (InOut and 2) or 1
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end
	
	obj:Point("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	obj:Point("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or (InOut and 2) or 1
	yOffset = yOffset or (InOut and 2) or 1
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end
	
	obj:Point("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:Point("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

local function SetTemplate(f, t, tex)
	local balpha = 1
	if t == "Transparent" then balpha = 0.8 end
	
	local borderr, borderg, borderb = unpack(C["medias"].BorderColor)
	local backdropr, backdropg, backdropb = unpack(C["medias"].BackdropColor)
	local backdropa = balpha
	
	if tex then 
		texture = C["medias"].Normal 
	else 
		texture = C["medias"].Blank 
	end
		
	f:SetBackdrop({
	  bgFile = texture, 
	  edgeFile = C["medias"].Blank, 
	  tile = false, tileSize = 0, edgeSize = Mult,
	})
	
	if InOut and not f.isInsetDone then
		f.insettop = f:CreateTexture(nil, "BORDER")
		f.insettop:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insettop:Point("TOPRIGHT", f, "TOPRIGHT", 1, -1)
		f.insettop:Height(1)
		f.insettop:SetTexture(0,0,0)	
		f.insettop:SetDrawLayer("BORDER", -7)
		
		f.insetbottom = f:CreateTexture(nil, "BORDER")
		f.insetbottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, -1)
		f.insetbottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
		f.insetbottom:Height(1)
		f.insetbottom:SetTexture(0,0,0)	
		f.insetbottom:SetDrawLayer("BORDER", -7)
		
		f.insetleft = f:CreateTexture(nil, "BORDER")
		f.insetleft:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insetleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, -1)
		f.insetleft:Width(1)
		f.insetleft:SetTexture(0,0,0)
		f.insetleft:SetDrawLayer("BORDER", -7)
		
		f.insetright = f:CreateTexture(nil, "BORDER")
		f.insetright:Point("TOPRIGHT", f, "TOPRIGHT", 1, 1)
		f.insetright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, -1)
		f.insetright:Width(1)
		f.insetright:SetTexture(0,0,0)	
		f.insetright:SetDrawLayer("BORDER", -7)

		f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		f.insetinsidetop:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsidetop:Point("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		f.insetinsidetop:Height(1)
		f.insetinsidetop:SetTexture(0,0,0)	
		f.insetinsidetop:SetDrawLayer("BORDER", -7)
		
		f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		f.insetinsidebottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		f.insetinsidebottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		f.insetinsidebottom:Height(1)
		f.insetinsidebottom:SetTexture(0,0,0)	
		f.insetinsidebottom:SetDrawLayer("BORDER", -7)
		
		f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		f.insetinsideleft:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsideleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		f.insetinsideleft:Width(1)
		f.insetinsideleft:SetTexture(0,0,0)
		f.insetinsideleft:SetDrawLayer("BORDER", -7)
		
		f.insetinsideright = f:CreateTexture(nil, "BORDER")
		f.insetinsideright:Point("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		f.insetinsideright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		f.insetinsideright:Width(1)
		f.insetinsideright:SetTexture(0,0,0)	
		f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end
		
	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local borders = {
	"insettop",
	"insetbottom",
	"insetleft",
	"insetright",
	"insetinsidetop",
	"insetinsidebottom",
	"insetinsideleft",
	"insetinsideright",
}

local function HideInsets(f)
	for i, border in pairs(borders) do
		if f[border] then
			f[border]:SetTexture(0,0,0,0)
		end
	end
end

local function CreateBackdrop(f, t, tex)
	if f.Backdrop then return end
	if not t then t = "Default" end

	local b = CreateFrame("Frame", nil, f)
	b:SetOutside()
	b:SetTemplate(t, tex)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.Backdrop = b
end

local function CreateShadow(f, t)
	if f.Shadow then return end
	
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:Point("TOPLEFT", -3, 3)
	shadow:Point("BOTTOMLEFT", -3, -3)
	shadow:Point("TOPRIGHT", 3, 3)
	shadow:Point("BOTTOMRIGHT", 3, -3)

	if C["general"].HideShadows then
		shadow:SetBackdrop( {
			edgeFile = nil, edgeSize = 0,
			insets = {left = 0, right = 0, top = 0, bottom = 0},
		})
	else
		shadow:SetBackdrop( {
			edgeFile = C["medias"].Glow, edgeSize = Scale(3),
			insets = {left = Scale(5), right = Scale(5), top = Scale(5), bottom = Scale(5)},
		})
	end
	
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.8)
	f.Shadow = shadow
end

local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = Noop
	object:Hide()
end

local function StyleButton(button) 
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture("frame", nil, self)
		hover:SetTexture(1, 1, 1, 0.3)
		hover:SetInside()
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture("frame", nil, self)
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetInside()
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture("frame", nil, self)
		checked:SetTexture(0,1,0,.3)
		checked:SetInside()
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetInside()
	end
end

local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(Mult, -Mult)
	
	if not name then
		parent.Text = fs
	else
		parent[name] = fs
	end
	
	return fs
end

local function HighlightTarget(self, event, unit)
	if self.unit == "target" then return end
	
	if UnitIsUnit("target", self.unit) then
		self.HighlightTarget:Show()
	else
		self.HighlightTarget:Hide()
	end
end

local function CreateOverlay(frame)
	if frame.overlay then return end

	local overlay = frame:CreateTexture(frame:GetName() and frame:GetName() .. "Overlay" or nil, "BORDER", frame)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 2, -2)
	overlay:Point("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C["medias"].Normal)
	overlay:SetVertexColor(0.05, 0.05, 0.05)
	frame.overlay = overlay
end

local function HighlightUnit(f, r, g, b)
	if f.HighlightTarget then return end
	
	local glowBorder = {edgeFile = C["medias"].Blank, edgeSize = 1}
	f.HighlightTarget = CreateFrame("Frame", nil, f)
	f.HighlightTarget:SetOutside()
	f.HighlightTarget:SetBackdrop(glowBorder)
	f.HighlightTarget:SetFrameLevel(f:GetFrameLevel() + 1)
	f.HighlightTarget:SetBackdropBorderColor(r, g, b, 1)
	f.HighlightTarget:Hide()
	f:RegisterEvent("PLAYER_TARGET_CHANGED", HighlightTarget)
end

local function StripTextures(Object, Kill, Text)
	for i=1, Object:GetNumRegions() do
		local Region = select(i, Object:GetRegions())
		if Region:GetObjectType() == "Texture" then
			if Kill then
				Region:Kill()
			else
				Region:SetTexture(nil)
			end
		end
	end		
end

local function SkinButton(Frame, Strip)
	if Frame:GetName() then
		local Left = _G[Frame:GetName().."Left"]
		local Middle = _G[Frame:GetName().."Middle"]
		local Right = _G[Frame:GetName().."Right"]


		if Left then Left:SetAlpha(0) end
		if Middle then Middle:SetAlpha(0) end
		if Right then Right:SetAlpha(0) end
	end

	if Frame.Left then Frame.Left:SetAlpha(0) end
	if Frame.Right then Frame.Right:SetAlpha(0) end	
	if Frame.Middle then Frame.Middle:SetAlpha(0) end
	if Frame.SetNormalTexture then Frame:SetNormalTexture("") end	
	if Frame.SetHighlightTexture then Frame:SetHighlightTexture("") end
	if Frame.SetPushedTexture then Frame:SetPushedTexture("") end	
	if Frame.SetDisabledTexture then Frame:SetDisabledTexture("") end
	
	if Strip then StripTextures(Frame) end
	
	Frame:SetTemplate()
	
	Frame:HookScript("OnEnter", function(self)
		local Color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		
		self:SetBackdropColor(Color.r * .15, Color.g * .15, Color.b * .15)
		self:SetBackdropBorderColor(Color.r, Color.g, Color.b)	
	end)
	
	Frame:HookScript("OnLeave", function(self)
		local Color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
		
		self:SetBackdropColor(C["medias"].BackdropColor[1], C["medias"].BackdropColor[2], C["medias"].BackdropColor[3])
		self:SetBackdropBorderColor(C["medias"].BorderColor[1], C["medias"].BorderColor[2], C["medias"].BorderColor[3])	
	end)
end

local function SkinCloseButton(Frame, Reposition)	
	if Reposition then
		Frame:Point("TOPRIGHT", Reposition, "TOPRIGHT", 2, 2)
	end
	
	Frame:SetNormalTexture("")
	Frame:SetPushedTexture("")
	Frame:SetHighlightTexture("")
	Frame:SetDisabledTexture("")

	Frame.Text = Frame:CreateFontString(nil, "OVERLAY")
	Frame.Text:SetFont(C["medias"].Font, 12, "OUTLINE")
	Frame.Text:SetPoint("CENTER", 0, 1)
	Frame.Text:SetText("X")
	Frame.Text:SetTextColor(.5, .5, .5)
end

local function SkinEditBox(Frame)
	local Left, Middle, Right, Mid = _G[Frame:GetName().."Left"], _G[Frame:GetName().."Middle"], _G[Frame:GetName().."Right"], _G[Frame:GetName().."Mid"]
	
	if Left then Left:Kill() end
	if Middle then Middle:Kill() end
	if Right then Right:Kill() end
	if Mid then Mid:Kill() end
	
	Frame:CreateBackdrop()
	
	if Frame:GetName() and Frame:GetName():find("Silver") or Frame:GetName():find("Copper") then
		Frame.Backdrop:Point("BOTTOMRIGHT", -12, -2)
	end
end

local function SkinArrowButton(Button, Vertical)
	Button:SetTemplate()
	Button:Size(Button:GetWidth() - 7, Button:GetHeight() - 7)
	
	if Vertical then
		Button:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		Button:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		Button:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)	
	else
		Button:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		
		if Button:GetPushedTexture() then
			Button:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		
		if Button:GetDisabledTexture() then
			Button:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end
	
	Button:GetNormalTexture():ClearAllPoints()
	Button:GetNormalTexture():SetInside()

	if Button:GetDisabledTexture() then
		Button:GetDisabledTexture():SetAllPoints(Button:GetNormalTexture())
	end
	
	if Button:GetPushedTexture() then
		Button:GetPushedTexture():SetAllPoints(Button:GetNormalTexture())
	end
	
	Button:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	Button:GetHighlightTexture():SetAllPoints(Button:GetNormalTexture())
end

local function SkinDropDown(Frame, Width)
	local Button = _G[Frame:GetName().."Button"]
	local Text = _G[Frame:GetName().."Text"]

	Frame:StripTextures()
	Frame:Width(Width or 155)
	
	Text:ClearAllPoints()
	Text:Point("RIGHT", Button, "LEFT", -2, 0)
	
	Button:ClearAllPoints()
	Button:Point("RIGHT", Frame, "RIGHT", -10, 3)
	Button.SetPoint = Noop
	
	Button:SkinArrowButton(true)
	
	Frame:CreateBackdrop()
	Frame.Backdrop:Point("TOPLEFT", 20, -2)
	Frame.Backdrop:Point("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 2, -2)
end

local function SkinCheckBox(Frame)
	Frame:StripTextures()
	Frame:CreateBackdrop()
	Frame.Backdrop:SetInside(Frame, 4, 4)

	if Frame.SetCheckedTexture then
		Frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end
	
	if Frame.SetDisabledCheckedTexture then
		Frame:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end
	
	-- why does the disabled texture is always displayed as checked ?
	Frame:HookScript("OnDisable", function(self)
		if not self.SetDisabledTexture then return end
		
		if self:GetChecked() then
			self:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		else
			self:SetDisabledTexture("")
		end
	end)
	
	Frame.SetNormalTexture = Noop
	Frame.SetPushedTexture = Noop
	Frame.SetHighlightTexture = Noop
end

---------------------------------------------------
-- Merge DuffedUI API with WoW API
---------------------------------------------------

local function AddAPI(object)
	local mt = getmetatable(object).__index
	
	if not object.Size then mt.Size = Size end
	if not object.Point then mt.Point = Point end
	if not object.SetOutside then mt.SetOutside = SetOutside end
	if not object.SetInside then mt.SetInside = SetInside end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.CreateShadow then mt.CreateShadow = CreateShadow end
	if not object.Kill then mt.Kill = Kill end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
	if not object.FontString then mt.FontString = FontString end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.HighlightUnit then mt.HighlightUnit = HighlightUnit end
	if not object.HideInsets then mt.HideInsets = HideInsets end
	if not object.SkinEditBox then mt.SkinEditBox = SkinEditBox end
	if not object.SkinButton then mt.SkinButton = SkinButton end
	if not object.SkinCloseButton then mt.SkinCloseButton = SkinCloseButton end
	if not object.SkinArrowButton then mt.SkinArrowButton = SkinArrowButton end
	if not object.SkinDropDown then mt.SkinDropDown = SkinDropDown end
	if not object.SkinCheckBox then mt.SkinCheckBox = SkinCheckBox end
end


local Handled = {["Frame"] = true}

local Object = CreateFrame("Frame")
AddAPI(Object)
AddAPI(Object:CreateTexture())
AddAPI(Object:CreateFontString())

Object = EnumerateFrames()

while Object do
	if (not Handled[Object:GetObjectType()]) then
		AddAPI(Object)
		Handled[Object:GetObjectType()] = true
	end

	Object = EnumerateFrames(Object)
end
