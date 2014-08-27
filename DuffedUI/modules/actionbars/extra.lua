local D, C, L = unpack(select(2, ...))
if not C["actionbar"].enable then return end

-- create the holder to allow moving extra button
local holder = CreateFrame("Frame", "DuffedUIExtraActionBarFrameHolder", UIParent)
holder:Size(160, 80)
holder:SetPoint("BOTTOM", 0, 250)
holder:SetMovable(true)
holder:SetTemplate("Default")
holder:SetBackdropBorderColor(1, 0, 0)
holder:SetAlpha(0)
holder.text = D.SetFontString(holder, C["media"].font, 11)
holder.text:SetPoint("CENTER")
holder.text:SetText(L["move"]["extrabutton"])
holder.text:Hide()
tinsert(D.AllowFrameMoving, DuffedUIExtraActionBarFrameHolder)

ExtraActionBarFrame:SetParent(UIParent)
ExtraActionBarFrame:ClearAllPoints()
ExtraActionBarFrame:SetPoint("CENTER", holder, "CENTER", 0, 0)
ExtraActionBarFrame.ignoreFramePositionManager = true

-- hook the texture, idea by roth via WoWInterface forums
local button = ExtraActionButton1
local icon = button.icon
local texture = button.style
local disableTexture = function(style, texture)
	if string.sub(texture, 1, 9) == "Interface" or string.sub(texture, 1, 9) == "INTERFACE" then
		style:SetTexture("")
	end
end
button.style:SetTexture("")
hooksecurefunc(texture, "SetTexture", disableTexture)