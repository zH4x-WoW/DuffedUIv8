local D, C, L = select(2, ...):unpack()

local DuffedUIActionBars = D["ActionBars"]

function DuffedUIActionBars:SetUpExtraActionButton()
	local Holder = CreateFrame("Frame", "DuffedUIExtraActionBarFrameHolder", UIParent)
	Holder:Size(160, 80)
	Holder:SetPoint("BOTTOM", 0, 240)
	Holder:SetMovable(true)
	Holder:SetTemplate("Default")
	Holder:SetBackdropBorderColor(1,0,0)
	Holder:SetAlpha(0)

	Holder.Text = Holder:CreateFontString(nil, "OVERLAY")
	Holder.Text:SetFont(C["medias"].Font, 12)
	Holder.Text:SetPoint("CENTER")
	Holder.Text:SetText(L.Movers.Extrabutton)
	Holder.Text:Hide()

	ExtraActionBarFrame:SetParent(UIParent)
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("CENTER", Holder, "CENTER", 0, 0)
	ExtraActionBarFrame.ignoreFramePositionManager = true

	ExtraActionButton1.style:SetTexture(nil)
	ExtraActionButton1.style.SetTexture = function() end
end

DuffedUIActionBars:SetUpExtraActionButton()