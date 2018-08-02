local D, C, L = unpack(select(2, ...))
-- As long as blizzard doesn't go back to dual spec, this should work forever, even with new classes with no changes.

if not C['datatext']['talent'] or C['datatext']['talent'] == 0 then return end

local LeftClickMenu = { }
LeftClickMenu[1] = { text = L['dt']['specmenu'], isTitle = true, notCheckable = true}

-- Setting up the menu for later for each spec regardless of class, thanks to Simca for helping out with the function.
local DuffedUISpecSwap = CreateFrame('Frame', 'DuffedUISpecSwap', UIParent, 'UIDropDownMenuTemplate')
DuffedUISpecSwap:SetTemplate('Transparent')
DuffedUISpecSwap:RegisterEvent('PLAYER_LOGIN')
DuffedUISpecSwap:SetScript('OnEvent', function(...)
	local specIndex
	for specIndex = 1, GetNumSpecializations() do
		LeftClickMenu[specIndex + 1] = {
			text = tostring(select(2, GetSpecializationInfo(specIndex))),
			notCheckable = true,
			func = (function()
				local getSpec = GetSpecialization()
				if getSpec and getSpec == specIndex then
					UIErrorsFrame:AddMessage(L['dt']['specerror'], 1, 0, 0, 53, 5);
					return
				end
				SetSpecialization(specIndex)
			end)
		}
	end
end)

local Stat = CreateFrame('Frame', 'DuffedUIStatTalent')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)
Stat.Option = C['datatext']['talent']
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text = Stat:CreateFontString('DuffedUIStatTalentText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['talent'], Text)

local function Update(self)
	if not GetSpecialization() then
		Text:SetText(L['dt']['talent']) 
	else
		local tree = GetSpecialization()
		local spec = select(2,GetSpecializationInfo(tree)) or ''
		Text:SetText(Stat.Color1.. L['dt']['specdata']..'|r' ..Stat.Color2..spec..'|r')
	end
	self:SetAllPoints(Text)
end

Stat:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
Stat:RegisterEvent('CONFIRM_TALENT_WIPE')
Stat:RegisterEvent('PLAYER_TALENT_UPDATE')
Stat:SetScript('OnEvent', Update)
Stat:SetScript('OnMouseDown', function(self, btn)
	if btn == 'LeftButton' then Lib_EasyMenu(LeftClickMenu, DuffedUISpecSwap, 'cursor', 0, 0, 'MENU', 2) end
end)