local D, C, L = select(2, ...):unpack()

if (not C["actionbars"].Enable) then
	return
end

local DuffedUIActionBars = D["ActionBars"]

function DuffedUIActionBars:SetUpExtraActionButton()
	local Holder = CreateFrame("Frame", "DuffedUIExtraActionBarFrameHolder", UIParent)
	Holder:Size(160, 80)
	Holder:SetPoint("BOTTOM", 0, 250)
	Holder:SetMovable(true)
	Holder:SetTemplate("Default")
	Holder:SetBackdropBorderColor(1,0,0)
	Holder:SetAlpha(0)

	Holder.Text = Holder:CreateFontString(nil, "OVERLAY")
	Holder.Text:SetFont(C["medias"].Font, 12)
	Holder.Text:SetPoint("CENTER")
	Holder.Text:SetText(L.ActionBars.Extrabutton)
	Holder.Text:Hide()

	ExtraActionBarFrame:SetParent(UIParent)
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("CENTER", Holder, "CENTER", 0, 0)
	ExtraActionBarFrame.ignoreFramePositionManager = true
end

local Button = ExtraActionButton1
local Texture = Button.style
Texture:SetTexture("")

local DisableTexture = function(style, texture)
	if (string.sub(texture, 1, 9) == "Interface" or string.sub(texture, 1, 9) == "INTERFACE") then
		style:SetTexture("")
	end
end

hooksecurefunc(Texture, "SetTexture", DisableTexture)

DuffedUIActionBars:SetUpExtraActionButton()