local D, C, L = unpack(select(2, ...))

local FONT_TITLE = { C["media"]["font"], 14, "THINOUTLINE" }
local FONT_HEADLINE = { C["media"]["font"], 13, "THINOUTLINE" }
local FONT_TEXT = { C["media"]["font"], 11, "THINOUTLINE" }

--------------------------------------------------
-- Main Frame
--------------------------------------------------
local FAQFrame = CreateFrame( "Frame", nil, UIParent )
FAQFrame:Point( "CENTER", UIParent, "CENTER", 0, 0 )
FAQFrame:Size( 650, 350 )
FAQFrame:SetTemplate( "Transparent" )
FAQFrame:SetFrameLevel( 10 )
FAQFrame:SetFrameStrata( "BACKGROUND" )
FAQFrame:Hide()
FAQFrame:EnableMouse(true)
FAQFrame:SetMovable(true)
FAQFrame:SetClampedToScreen(true)
FAQFrame:SetScript("OnMouseDown", function() FAQFrame:ClearAllPoints() FAQFrame:StartMoving() end)
FAQFrame:SetScript("OnMouseUp", function() FAQFrame:StopMovingOrSizing() end)

local FAQFrameRightIcon = CreateFrame( "Frame", nil, FAQFrame )
FAQFrameRightIcon:Point( "BOTTOMRIGHT", FAQFrame, "TOPRIGHT", 0, 3 )
FAQFrameRightIcon:Size( 30 )
FAQFrameRightIcon:SetTemplate( "Transparent" )

FAQFrameRightIcon.Texture = FAQFrameRightIcon:CreateTexture( nil, "ARTWORK" )
FAQFrameRightIcon.Texture:SetInside()
FAQFrameRightIcon.Texture:SetTexture( C["media"]["duffed"] )

local FAQFrameTitle = CreateFrame( "Frame", nil, FAQFrame )
FAQFrameTitle:Point( "BOTTOM", FAQFrame, "TOP", 0, 3 )
FAQFrameTitle:Size( FAQFrame:GetWidth() -1, 30 ) -- -122, 30
FAQFrameTitle:SetTemplate( "Transparent" )

FAQFrameTitle.Text = FAQFrameTitle:CreateFontString( nil, "OVERLAY" )
FAQFrameTitle.Text:Point( "CENTER", FAQFrameTitle, "CENTER", 0, 0 )
FAQFrameTitle.Text:SetFont( unpack( FONT_TITLE ) )
FAQFrameTitle.Text:SetText( "|cffc41f3bDuffedUI " .. GetAddOnMetadata( "DuffedUI", "Version" ) .. " - |cffc41f3bF.A.Q.|r" )

local FAQFrameNavigation = CreateFrame( "Frame", nil, FAQFrame )
FAQFrameNavigation:Point( "LEFT", 4, 0 )
FAQFrameNavigation:Size( 180, 342 )
FAQFrameNavigation:SetTemplate( "Transparent" )

local FAQFrameContent = CreateFrame( "Frame", nil, FAQFrame )
FAQFrameContent:Point( "RIGHT", -4, 0 )
FAQFrameContent:Size( 458, 342 )
FAQFrameContent:SetTemplate( "Transparent" )

local FAQFrameContentScrollFrame = CreateFrame( "ScrollFrame", "FAQFrameContentScrollFrame", FAQFrameContent, "UIPanelScrollFrameTemplate" )
FAQFrameContentScrollFrame:Point( "TOPLEFT", FAQFrameContent, "TOPLEFT", 4, -4 )
FAQFrameContentScrollFrame:Point( "BOTTOMRIGHT", FAQFrameContent, "BOTTOMRIGHT", -27, 4 )

local FAQFrameContentScrollFrameBackground = CreateFrame( "Frame", "FAQMainFrameContentScrollFrameBackground", FAQFrameContentScrollFrame )
FAQFrameContentScrollFrameBackground:Point( "TOPLEFT" )
FAQFrameContentScrollFrameBackground:Width( FAQFrameContentScrollFrame:GetWidth() )
FAQFrameContentScrollFrameBackground:Height( FAQFrameContentScrollFrame:GetHeight() )
FAQFrameContentScrollFrame:SetScrollChild( FAQFrameContentScrollFrameBackground )

local FAQButtonsAttributes = {
	[1] = { "/dfaq 1" },
	[2] = { "/dfaq 2" },
	[3] = { "/dfaq 3" },
	[4] = { "/dfaq 4" },
	[5] = { "/dfaq 5" },
	[6] = { "/dfaq 6" },
	[7] = { "/dfaq 7" },
	[8] = { "/dfaq 8" },
	[9] = { "/dfaq 9" },
	[10] = { "/dfaq 10" },
	[11] = { "/dfaq 11" },
}

local FAQButtonsTexts = {
	[1] = { L["faq"]["button01"] },
	[2] = { L["faq"]["button02"] },
	[3] = { L["faq"]["button03"] },
	[4] = { L["faq"]["button04"] },
	[5] = { L["faq"]["button05"] },
	[6] = { L["faq"]["button06"] },
	[7] = { L["faq"]["button07"] },
	[8] = { L["faq"]["button08"] },
	[9] = { L["faq"]["button09"] },
	[10] = { L["faq"]["button10"] },
	[11] = { L["faq"]["button11"] },
}

local FAQMainFrameNavigationButton = CreateFrame( "Button", nil, FAQFrameNavigation )
for i = 1, 11 do
	FAQMainFrameNavigationButton[i] = CreateFrame( "Button", "RavUIFAQMainFrameNavigationButton" .. i, FAQFrameNavigation, "SecureActionButtonTemplate" )
	FAQMainFrameNavigationButton[i]:Size( FAQFrameNavigation:GetWidth() - 8, 24 )
	FAQMainFrameNavigationButton[i]:SetTemplate( "Transparent" )

	FAQMainFrameNavigationButton[i].Text = D.SetFontString( FAQMainFrameNavigationButton[i], C["media"].font, 11 )
	FAQMainFrameNavigationButton[i]:SetFrameLevel( FAQFrameNavigation:GetFrameLevel() + 1 )
	FAQMainFrameNavigationButton[i].Text:Point( "CENTER", FAQMainFrameNavigationButton[i], "CENTER", 0, 0 )
	FAQMainFrameNavigationButton[i].Text:SetText( unpack( FAQButtonsTexts[i] ) )

	if( i == 1 ) then
		FAQMainFrameNavigationButton[i]:Point( "TOP", FAQFrameNavigation, "TOP", 0, -5 )
	else
		FAQMainFrameNavigationButton[i]:Point( "TOP", FAQMainFrameNavigationButton[i - 1], "BOTTOM", 0, -3 )
	end
	FAQMainFrameNavigationButton[i]:SetAttribute( "type", "macro" )
	FAQMainFrameNavigationButton[i]:SetAttribute( "macrotext", unpack( FAQButtonsAttributes[i] ) )
	FAQMainFrameNavigationButton[i]:SetScript("OnEnter", function(self)
			FAQMainFrameNavigationButton[i]:SkinButton()
		end)
	FAQMainFrameNavigationButton[i]:SetScript("OnLeave", function(self)
			FAQMainFrameNavigationButton[i]:SetTemplate( "Transparent" )
		end)
end

local FAQMainFrameCloseButton = CreateFrame( "Button", nil, FAQFrameContentScrollFrameBackground, "UIPanelCloseButton" )
FAQMainFrameCloseButton:Point( "TOPRIGHT", FAQFrameContentScrollFrameBackground, "TOPRIGHT" )
FAQMainFrameCloseButton:SetScript( "OnClick", function()
	FAQFrame:Hide()
end )
FAQMainFrameCloseButton:SkinCloseButton()

local FAQMainFrameContentTitle = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentTitle:SetFont( unpack( FONT_TITLE ) )
FAQMainFrameContentTitle:Point( "TOP", FAQFrameContentScrollFrameBackground, "TOP", 0, -10 )

local FAQMainFrameContentText1 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText1:SetJustifyH( "LEFT" )
FAQMainFrameContentText1:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText1:SetWidth( FAQFrameContentScrollFrameBackground:GetWidth() - 20 )
FAQMainFrameContentText1:SetPoint( "TOPLEFT", FAQFrameContentScrollFrameBackground, "TOPLEFT", 10, -45 )

local FAQMainFrameContentText2 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText2:SetJustifyH( "LEFT" )
FAQMainFrameContentText2:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText2:Width( FAQFrameContentScrollFrameBackground:GetWidth() - 30 )
FAQMainFrameContentText2:Point( "TOPLEFT", FAQMainFrameContentText1, "BOTTOMLEFT", 0, -20 )

local FAQMainFrameContentText3 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText3:SetJustifyH( "LEFT" )
FAQMainFrameContentText3:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText3:Width( FAQFrameContentScrollFrameBackground:GetWidth() - 30 )
FAQMainFrameContentText3:Point( "TOPLEFT", FAQMainFrameContentText2, "BOTTOMLEFT", 0, -20 )

local FAQMainFrameContentText4 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText4:SetJustifyH( "LEFT" )
FAQMainFrameContentText4:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText4:Width( FAQFrameContentScrollFrameBackground:GetWidth() - 30 )
FAQMainFrameContentText4:Point( "TOPLEFT", FAQMainFrameContentText3, "BOTTOMLEFT", 0, -20 )

local FAQMainFrameContentText5 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText5:SetJustifyH( "LEFT" )
FAQMainFrameContentText5:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText5:Width( FAQFrameContentScrollFrameBackground:GetWidth() - 30 )
FAQMainFrameContentText5:Point( "TOPLEFT", FAQMainFrameContentText4, "BOTTOMLEFT", 0, -20 )

local FAQMainFrameContentText6 = FAQFrameContentScrollFrameBackground:CreateFontString( nil, "OVERLAY" )
FAQMainFrameContentText6:SetJustifyH( "LEFT" )
FAQMainFrameContentText6:SetFont( unpack( FONT_TEXT ) )
FAQMainFrameContentText6:Width( FAQFrameContentScrollFrameBackground:GetWidth() - 30 )
FAQMainFrameContentText6:Point( "TOPLEFT", FAQMainFrameContentText5, "BOTTOMLEFT", 0, -20 )

FAQFrameContentScrollFrameScrollBar:SkinScrollBar()

local function FAQMainFrameBuildDefault()
	FAQMainFrameContentTitle:SetText(L["faq"]["generaltitle"])
	FAQMainFrameContentText1:SetText(L["faq"]["generaltext1"])
	FAQMainFrameContentText2:SetText(L["faq"]["generaltext2"])	
end

local function FAQMainFrameContent1()
	FAQMainFrameContentTitle:SetText(L["faq"]["content1title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content1text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content1text2"])	
end

local function FAQMainFrameContent2()
	FAQMainFrameContentTitle:SetText(L["faq"]["content2title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content2text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content2text2"])	
end

local function FAQMainFrameContent3()
	FAQMainFrameContentTitle:SetText(L["faq"]["content3title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content3text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content3text2"])	
end

local function FAQMainFrameContent4()
	FAQMainFrameContentTitle:SetText(L["faq"]["content4title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content4text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content4text2"])	
end

local function FAQMainFrameContent5()
	FAQMainFrameContentTitle:SetText(L["faq"]["content5title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content5text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content5text2"])	
end

local function FAQMainFrameContent6()
	FAQMainFrameContentTitle:SetText(L["faq"]["content6title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content6text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content6text2"])	
end

local function FAQMainFrameContent7()
	FAQMainFrameContentTitle:SetText(L["faq"]["content7title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content7text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content7text2"])	
end

local function FAQMainFrameContent8()
	FAQMainFrameContentTitle:SetText(L["faq"]["content8title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content8text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content8text2"])	
end

local function FAQMainFrameContent9()
	FAQMainFrameContentTitle:SetText(L["faq"]["content9title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content9text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content9text2"])	
end

local function FAQMainFrameContent10()
	FAQMainFrameContentTitle:SetText(L["faq"]["content10title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content10text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content10text2"])	
end

local function FAQMainFrameContent11()
	FAQMainFrameContentTitle:SetText(L["faq"]["content11title"])
	FAQMainFrameContentText1:SetText(L["faq"]["content11text1"])
	FAQMainFrameContentText2:SetText(L["faq"]["content11text2"])	
end

local dfaq = FAQMainFrameSlashcommand or function() end
FAQMainFrameSlashcommand = function( msg )
	if( InCombatLockdown() ) then print( ERR_NOT_IN_COMBAT ) return end

	if( msg == "1" ) then
		FAQMainFrameContent1()
	elseif( msg == "2" ) then
		FAQMainFrameContent2()
	elseif( msg == "3" ) then
		FAQMainFrameContent3()
	elseif( msg == "4" ) then
		FAQMainFrameContent4()
	elseif( msg == "5" ) then
		FAQMainFrameContent5()
	elseif( msg == "6" ) then
		FAQMainFrameContent6()
	elseif( msg == "7" ) then
		FAQMainFrameContent7()
	elseif( msg == "8" ) then
		FAQMainFrameContent8()
	elseif( msg == "9" ) then
		FAQMainFrameContent9()
	elseif( msg == "10" ) then
		FAQMainFrameContent10()
	elseif( msg == "11" ) then
		FAQMainFrameContent11()		
	else
		if( FAQFrame:IsVisible() ) then
			FAQFrame:Hide()
		else
			FAQFrame:Show()
			FAQMainFrameBuildDefault()
		end
	end
end

SlashCmdList.FAQMainFrameSlashcommand = FAQMainFrameSlashcommand
SLASH_FAQMainFrameSlashcommand1 = "/dfaq"