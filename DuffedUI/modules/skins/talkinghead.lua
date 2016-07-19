local D, C, L = unpack(select(2, ...))

--[[moving the frame]]--
local skin = CreateFrame("Frame")

function skin:OnEvent(event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_TalkingHeadUI" then
			local move = D["move"]
			local thf = TalkingHeadFrame

			thf.ignoreFramePositionManager = true
			move:RegisterFrame(thf)

			if DuffedUIDataPerChar.Move["TalkingHeadFrame"] then
				local Anchor1, Parent, Anchor2, X, Y = unpack(DuffedUIDataPerChar.Move["TalkingHeadFrame"])
				thf:ClearAllPoints()
				thf:SetPoint(Anchor1, Parent, Anchor2, X, Y)
			end

			thf:SetScale(.75)
		end
	end
end

skin:RegisterEvent("ADDON_LOADED")
skin:SetScript("OnEvent", skin.OnEvent)

--[[skin the frame]]--
local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:SetTemplate("Transparent")
	TalkingHeadFrame.MainFrame.CloseButton:SkinCloseButton()

	TalkingHeadFrame.MainFrame:StripTextures()

	TalkingHeadFrame.PortraitFrame:StripTextures()
end

D.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin