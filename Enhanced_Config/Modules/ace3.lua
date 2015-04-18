if not (Tukui or AsphyxiaUI or DuffedUI) then return end
local EC = unpack(select(2,...))
local AceGUI = LibStub("AceGUI-3.0", true)

function EC:SkinAce3()
	local AceGUI = LibStub("AceGUI-3.0", true)
	if not AceGUI then return end
	local oldRegisterAsWidget = AceGUI.RegisterAsWidget
	AceGUI.RegisterAsWidget = function(self, widget)
		local TYPE = widget.type
		if TYPE == 'MultiLineEditBox' then
			widget.scrollBG:SetTemplate('Default')
			widget.button:SkinButton()
			widget.scrollBar:SkinScrollBar()
			widget.scrollBar:SetPoint("RIGHT", widget.frame, "RIGHT", 0 -4)
			widget.scrollBG:SetPoint("TOPRIGHT", widget.scrollBar, "TOPLEFT", -2, 19)
			widget.scrollBG:SetPoint("BOTTOMLEFT", widget.button, "TOPLEFT")
			widget.scrollFrame:SetPoint("BOTTOMRIGHT", widget.scrollBG, "BOTTOMRIGHT", -4, 8)
		elseif TYPE == "CheckBox" then
			widget.checkbg:Kill()
			widget.highlight:Kill()
			print(widget.image:GetTexture())
			if not widget.skinnedCheckBG then
				widget.skinnedCheckBG = CreateFrame('Frame', nil, widget.frame)
				widget.skinnedCheckBG:SetTemplate('Default')
				widget.skinnedCheckBG:SetOutside(widget.frame, 4, 4)
			end

			widget.check:SetParent(widget.skinnedCheckBG)
		elseif TYPE == "Dropdown" then
			local frame = widget.dropdown
			local button = widget.button
			local text = widget.text
			frame:StripTextures()

			button:ClearAllPoints()
			button:Point("RIGHT", frame, "RIGHT", -20, 0)

			SkinNextPrevButton(button, true)

			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				frame.backdrop:Point("TOPLEFT", 20, -2)
				frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
			end
			button:SetParent(frame.backdrop)
			text:SetParent(frame.backdrop)
			button:HookScript('OnClick', function(this)
				local self = this.obj
				self.pullout.frame:SetTemplate('Default', true)
			end)
		elseif TYPE == "LSM30_Font" or TYPE == "LSM30_Sound" or TYPE == "LSM30_Border" or TYPE == "LSM30_Background" or TYPE == "LSM30_Statusbar" then
			local frame = widget.frame
			local button = frame.dropButton
			local text = frame.text
			frame:StripTextures()

			button:SkinNextPrevButton(true)
			frame.text:ClearAllPoints()
			frame.text:Point('RIGHT', button, 'LEFT', -2, 0)

			button:ClearAllPoints()
			button:Point("RIGHT", frame, "RIGHT", -10, -6)

			if not frame.backdrop then
				frame:CreateBackdrop("Default")
				if TYPE == "LSM30_Font" then
					frame.backdrop:Point("TOPLEFT", 20, -17)
				elseif TYPE == "LSM30_Sound" then
					frame.backdrop:Point("TOPLEFT", 20, -17)
					widget.soundbutton:SetParent(frame.backdrop)
					widget.soundbutton:ClearAllPoints()
					widget.soundbutton:Point('LEFT', frame.backdrop, 'LEFT', 2, 0)
				elseif TYPE == "LSM30_Statusbar" then
					frame.backdrop:Point("TOPLEFT", 20, -17)
					widget.bar:SetParent(frame.backdrop)
					widget.bar:SetInside()
				elseif TYPE == "LSM30_Border" or TYPE == "LSM30_Background" then
					frame.backdrop:Point("TOPLEFT", 42, -16)
				end

				frame.backdrop:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
			end
			button:SetParent(frame.backdrop)
			text:SetParent(frame.backdrop)
			button:HookScript('OnClick', function(this, button)
				local self = this.obj
				if self.dropdown then
					self.dropdown:SetTemplate('Default', true)
				end
			end)
		elseif TYPE == "EditBox" then
			local frame = widget.editbox
			local button = widget.button
			_G[frame:GetName()..'Left']:Kill()
			_G[frame:GetName()..'Middle']:Kill()
			_G[frame:GetName()..'Right']:Kill()
			frame:Height(17)
			frame:CreateBackdrop('Default')
			frame.backdrop:Point('TOPLEFT', -2, 0)
			frame.backdrop:Point('BOTTOMRIGHT', 2, 0)		
			frame.backdrop:SetParent(widget.frame)
			frame:SetParent(frame.backdrop)
			button:SkinButton()
		elseif TYPE == "Button" then
			local frame = widget.frame
			frame:SkinButton()
			frame:StripTextures()
			frame:CreateBackdrop('Default', true)
			frame.backdrop:SetInside()
			widget.text:SetParent(frame.backdrop)
		elseif TYPE == "Slider" then
			local frame = widget.slider
			local editbox = widget.editbox
			local lowtext = widget.lowtext
			local hightext = widget.hightext
			local HEIGHT = 12

			frame:StripTextures()
			frame:SetTemplate('Default')
			frame:Height(HEIGHT)
			frame:SetThumbTexture('Interface\\ChatFrame\\ChatFrameBackground')
			frame:GetThumbTexture():SetVertexColor(0.3, 0.3, 0.3)
			frame:GetThumbTexture():Size(HEIGHT-2,HEIGHT+2)

			editbox:SetTemplate('Default')
			editbox:Height(15)
			editbox:Point("TOP", frame, "BOTTOM", 0, -1)

			lowtext:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -2)
			hightext:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -2, -2)

		--[[elseif TYPE == "ColorPicker" then
			local frame = widget.frame
			local colorSwatch = widget.colorSwatch
		]]
		end
		return oldRegisterAsWidget(self, widget)
	end

	local oldRegisterAsContainer = AceGUI.RegisterAsContainer

	AceGUI.RegisterAsContainer = function(self, widget)
		local TYPE = widget.type

		if TYPE == "ScrollFrame" then
			local frame = widget.scrollbar
			frame:SkinScrollBar()
		elseif TYPE == "InlineGroup" or TYPE == "TreeGroup" or TYPE == "TabGroup" or TYPE == "SimpleGroup" or TYPE == "Frame" or TYPE == "DropdownGroup" then
			local frame = widget.content:GetParent()
			if TYPE == "Frame" then
				frame:StripTextures()
				for i=1, frame:GetNumChildren() do
					local child = select(i, frame:GetChildren())
					if child:GetObjectType() == "Button" and child:GetText() then
						child:SkinButton()
					else
						child:StripTextures()
					end
				end
			end
			frame:SetTemplate('Transparent')

			if widget.treeframe then
				widget.treeframe:SetTemplate('Transparent')
				frame:Point("TOPLEFT", widget.treeframe, "TOPRIGHT", 1, 0)

				local oldCreateButton = widget.CreateButton
				widget.CreateButton = function(self)
					local button = oldCreateButton(self)
					button.toggle:StripTextures()
					button.toggle.SetNormalTexture = EC.Noop
					button.toggle.SetPushedTexture = EC.Noop
					button.toggleText = button.toggle:CreateFontString(nil, 'OVERLAY')
					button.toggleText:SetFont(EC.Font, 19)
					button.toggleText:SetPoint('CENTER')
					button.toggleText:SetText('+')
					return button
				end

				local oldRefreshTree = widget.RefreshTree
				widget.RefreshTree = function(self, scrollToSelection)		
					oldRefreshTree(self, scrollToSelection)
					if not self.tree then return end
					local status = self.status or self.localstatus
					local groupstatus = status.groups		
					local lines = self.lines
					local buttons = self.buttons

					for i, line in pairs(lines) do
						local button = buttons[i]
						if groupstatus[line.uniquevalue] and button then
							button.toggleText:SetText('-')
						elseif button then
							button.toggleText:SetText('+')
						end						
					end			
				end
			end

			if TYPE == "TabGroup" then
				local oldCreateTab = widget.CreateTab
				widget.CreateTab = function(self, id)
					local tab = oldCreateTab(self, id)
					tab:StripTextures()			
					return tab
				end
			end

			if widget.scrollbar then
				widget.scrollbar:SkinScrollBar()
			end
		end

		return oldRegisterAsContainer(self, widget)
	end
end