local D, C, L = unpack(select(2, ...))

local function LoadGarrisonSkin()
	-- Landing Page
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:SetTemplate("Transparent")

	for i = 1, 2 do _G["GarrisonLandingPageTab" .. i]:SkinTab() end

	GarrisonLandingPageTab1:ClearAllPoints()
	GarrisonLandingPageTab1:Point("BOTTOMLEFT", GarrisonLandingPage, 100, -GarrisonLandingPageTab1:GetHeight())
	GarrisonLandingPageTab2:ClearAllPoints()
	GarrisonLandingPageTab2:Point("LEFT", GarrisonLandingPageTab1, "RIGHT", 0, 0)
	GarrisonLandingPage.CloseButton:SkinCloseButton()
	GarrisonLandingPageReportListListScrollFrameScrollBar:SkinScrollBar()

	-- Work Orders
	GarrisonCapacitiveDisplayFrame:StripTextures()
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")
	GarrisonCapacitiveDisplayFramePortrait:Kill()
	GarrisonCapacitiveDisplayFrameInset:StripTextures()
	GarrisonCapacitiveDisplayFrameCloseButton:SkinCloseButton()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:StripTextures()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:ClearAllPoints()
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:Point("BOTTOMRIGHT", GarrisonCapacitiveDisplayFrame, "BOTTOMRIGHT", -9, 4)
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay:StripTextures()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay:SetTemplate()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame:SetTemplate()
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame.Icon:SetTexCoord(.08, .92, .08, .92)
	GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.ShipmentIconFrame.Icon:SetInside()

	for i = 1, #GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.Reagents do
		GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.Reagents[i]:StripTextures()
		GarrisonCapacitiveDisplayFrame.CapacitiveDisplay.Reagents[i].Icon:SetTexCoord(.08, .92, .08, .92)
	end
end
D.SkinFuncs["Blizzard_GarrisonUI"] = LoadGarrisonSkin

