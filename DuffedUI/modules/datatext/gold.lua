local D, C, L = unpack(select(2, ...)) 

if not C['datatext']['gold'] or C['datatext']['gold'] == 0 then return end
D['SetPerCharVariable']('ImprovedCurrency', {})

local Stat = CreateFrame('Frame', 'DuffedUIDataInfoGold')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)

Stat.Option = C['datatext']['gold']
Stat.Color1 = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
Stat.Color2 = D['RGBToHex'](unpack(C['media']['datatextcolor2']))

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text = Stat:CreateFontString('DuffedUIDataInfoGoldText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['gold'], Text)

local Profit = 0
local Spent = 0
local OldMoney = 0
local myPlayerRealm = D['MyRealm']

local function formatMoney(money)
	local gold = floor(math.abs(money) / 10000)
	local silver = mod(floor(math.abs(money) / 100), 100)
	local copper = mod(floor(math.abs(money)), 100)

	if gold ~= 0 then
		return format(Stat.Color2..'%s|r' .. '|cffffd700g|r' .. Stat.Color2..' %s|r' .. '|cffc7c7cfs|r' .. Stat.Color2..' %s|r' .. '|cffeda55fc|r', gold, silver, copper)
	elseif silver ~= 0 then
		return format(Stat.Color2..'%s|r' .. '|cffc7c7cfs|r' .. Stat.Color2..' %s|r' .. '|cffeda55fc|r', silver, copper)
	else
		return format(Stat.Color2..'%s|r' .. '|cffeda55fc|r', copper)
	end
end

local function FormatTooltipMoney(money)
	local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	local cash = ''

	cash = format('%.2d' .. '|cffffd700g|r' .. ' %.2d' .. '|cffc7c7cfs|r' .. ' %.2d' .. '|cffeda55fc|r', gold, silver, copper)
	return cash
end	

local function OnEvent(self, event)
	if event == 'PLAYER_ENTERING_WORLD' then OldMoney = GetMoney() end

	local NewMoney	= GetMoney()
	local Change = NewMoney - OldMoney

	if OldMoney>NewMoney then Spent = Spent - Change else Profit = Profit + Change end
	Text:SetText(formatMoney(NewMoney))
	self:SetAllPoints(Text)

	local myPlayerName  = UnitName('player')
	if DuffedUIData == nil then DuffedUIData = {} end
	if DuffedUIData['gold'] == nil then DuffedUIData['gold'] = {} end
	if DuffedUIData['gold'][myPlayerRealm] == nil then DuffedUIData['gold'][myPlayerRealm] = {} end
	DuffedUIData['gold'][myPlayerRealm][myPlayerName] = GetMoney()
	OldMoney = NewMoney
end

Stat:RegisterEvent('PLAYER_MONEY')
Stat:RegisterEvent('SEND_MAIL_MONEY_CHANGED')
Stat:RegisterEvent('SEND_MAIL_COD_CHANGED')
Stat:RegisterEvent('PLAYER_TRADE_MONEY')
Stat:RegisterEvent('TRADE_MONEY_CHANGED')
Stat:RegisterEvent('PLAYER_ENTERING_WORLD')

Stat:SetScript('OnEvent', OnEvent)
Stat:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	if ImprovedCurrency['Archaeology'] == nil then ImprovedCurrency['Archaeology'] = true end
	if ImprovedCurrency['Cooking'] == nil then ImprovedCurrency['Cooking'] = true end
	if ImprovedCurrency['Professions'] == nil then ImprovedCurrency['Professions'] = true end
	if ImprovedCurrency['Garrison'] == nil then ImprovedCurrency['Garrison'] = true end
	if ImprovedCurrency['Miscellaneous'] == nil then ImprovedCurrency['Miscellaneous'] = true end
	if ImprovedCurrency['PvP'] == nil then ImprovedCurrency['PvP'] = true end
	if ImprovedCurrency['Raid'] == nil then ImprovedCurrency['Raid'] = true end

	local prof1, prof2, archaeology, _, cooking = GetProfessions()

	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L['dt']['session'])
	GameTooltip:AddDoubleLine(L['dt']['earned'], formatMoney(Profit), 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(L['dt']['spent'], formatMoney(Spent), 1, 1, 1, 1, 1, 1)

	if Profit < Spent then
		GameTooltip:AddDoubleLine(L['dt']['deficit'], formatMoney(Profit - Spent), 1, 0, 0, 1, 1, 1)
	elseif (Profit-Spent) > 0 then
		GameTooltip:AddDoubleLine(L['dt']['profit'], formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
	end

	GameTooltip:AddLine(' ')

	local totalGold = 0
	local myGold = {}
	GameTooltip:AddLine(L['dt']['character'])

	local thisRealmList = DuffedUIData.gold[myPlayerRealm]
	for k,_ in pairs(thisRealmList) do
		if thisRealmList[k] then
			tinsert (myGold,
				{
					name = k,
					amount = thisRealmList[k],
					amountText = FormatTooltipMoney(thisRealmList[k]),
					1, 1, 1, 1, 1, 1,
				}
			)
		end
		totalGold = totalGold + thisRealmList[k]
		end

		for i = 1, #myGold do
			local g = myGold[i]
			GameTooltip:AddDoubleLine(g.name == D['MyName'] and g.name..' |TInterface\\COMMON\\Indicator-Green:14|t' or g.name, g.amountText, g.r, g.g, g.b, 1, 1, 1)
		end

	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['server'])
	GameTooltip:AddDoubleLine(FROM_TOTAL .. ' ', FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

	if archaeology and ImprovedCurrency['Archaeology'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(PROFESSIONS_ARCHAEOLOGY .. ': ')
		D['Currency'](384) -- Dwarf
		D['Currency'](385) -- Troll
		D['Currency'](393) -- Fossil
		D['Currency'](394) -- Night Elf
		D['Currency'](397) -- Orc
		D['Currency'](398) -- Draenei
		D['Currency'](399) -- Vyrkul
		D['Currency'](400) -- Nerubian
		D['Currency'](401) -- Tol'vir
		D['Currency'](676) -- Pandaren
		D['Currency'](677) -- Mogu
		D['Currency'](754) -- Mantid
		D['Currency'](821) -- Draenor Clans
		D['Currency'](828) -- Ogre
		D['Currency'](829) -- Arakkoa
		D['Currency'](1172) -- Highborne
		D['Currency'](1173) -- Highmountain
		D['Currency'](1174) -- Demonic
	end

	if cooking and ImprovedCurrency['Cooking'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(PROFESSIONS_COOKING .. ': ')
		D['Currency'](81)
		D['Currency'](402)
	end

	if ImprovedCurrency['Professions'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine('Profession Token')
		D['Currency'](61)
		D['Currency'](361)
		D['Currency'](910)
		D['Currency'](980)
		D['Currency'](999)
		D['Currency'](1008)
		D['Currency'](1017)
		D['Currency'](1020)
	end

	if ImprovedCurrency['Garrison'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine('Garrison')
		D['Currency'](824)
		D['Currency'](1101)
		D['Currency'](1220)
		D['Currency'](1342, false, true)
		D['Currency'](1560)
	end

	if ImprovedCurrency['Raid'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(L['dt']['dr'])
		D['Currency'](1191, false, true)
		D['Currency'](1129, false, true)
		D['Currency'](994, false, true)
		D['Currency'](776, false, true)
		D['Currency'](752, false, true)
		D['Currency'](697, false, true)
		D['Currency'](738)
		D['Currency'](615)
		D['Currency'](614)
		D['Currency'](823)
		D['Currency'](1166)
		D['Currency'](1155, false, true)
		D['Currency'](1226)
		D['Currency'](1273, false, true)
		D['Currency'](1501)
		D['Currency'](1508, false, true)
		D['Currency'](1533)
		D['Currency'](1710)
		D['Currency'](1580, false, true)
		D['Currency'](1716)
		D['Currency'](1717)
		D['Currency'](1718)
	end

	if ImprovedCurrency['PvP'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(PVP_FLAG)
		D['Currency'](390, true)
		D['Currency'](391)
		D['Currency'](392, false, true)
		D['Currency'](944)
		D['Currency'](1268)
		D['Currency'](1356)
	end

	if ImprovedCurrency['Miscellaneous'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(MISCELLANEOUS)
		D['Currency'](241)
		D['Currency'](416)
		D['Currency'](515)
		D['Currency'](777)
		D['Currency'](1149, false, true)
		D['Currency'](1154, false, true)
		D['Currency'](1275)
		D['Currency'](1721) -- Patch 8.2
	end

	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['goldbagsopen'])
	GameTooltip:AddLine(L['dt']['goldcurrency'])
	GameTooltip:AddLine(L['dt']['goldreset'])

	GameTooltip:Show()
	GameTooltip:SetTemplate('Transparent')
end)

Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)

local RightClickMenu = {
	{ text = 'DuffedUI Improved Currency Options', isTitle = true , notCheckable = true },
	{ text = 'Show Archaeology Fragments', checked = function() return ImprovedCurrency['Archaeology'] end, func = function()
		if ImprovedCurrency['Archaeology'] then ImprovedCurrency['Archaeology'] = false else ImprovedCurrency['Archaeology'] = true end
	end	},
	{ text = 'Show Profession Tokens', checked = function() return ImprovedCurrency['Professions'] end, func = function()
		if ImprovedCurrency['Professions'] then ImprovedCurrency['Professions'] = false else ImprovedCurrency['Professions'] = true end
	end	},
	{ text = 'Show Garrison Tokens', checked = function() return ImprovedCurrency['Garrison'] end, func = function()
		if ImprovedCurrency['Garrison'] then ImprovedCurrency['Garrison'] = false else ImprovedCurrency['Garrison'] = true end
	end	},
	{ text = 'Show Player vs Player Currency', checked = function() return ImprovedCurrency['PvP'] end, func = function()
		if ImprovedCurrency['PvP'] then ImprovedCurrency['PvP'] = false else ImprovedCurrency['PvP'] = true end
	end	},
	{ text = 'Show Dungeon and Raid Currency', checked = function() return ImprovedCurrency['Raid'] end, func = function()
		if ImprovedCurrency['Raid'] then ImprovedCurrency['Raid'] = false else ImprovedCurrency['Raid'] = true end
	end	},
	{ text = 'Show Cooking Awards', checked = function() return ImprovedCurrency['Cooking'] end, func = function()
		if ImprovedCurrency['Cooking'] then ImprovedCurrency['Cooking'] = false else ImprovedCurrency['Cooking'] = true end
	end	},
	{ text = 'Show Miscellaneous Currency', checked = function() return ImprovedCurrency['Miscellaneous'] end, func = function()
		if ImprovedCurrency['Miscellaneous'] then ImprovedCurrency['Miscellaneous'] = false else ImprovedCurrency['Miscellaneous'] = true end
	end	},
}

local DuffedUIImprovedCurrencyDropDown = CreateFrame('Frame', 'DuffedUIImprovedCurrencyDropDown', UIParent, 'UIDropDownMenuTemplate')
DuffedUIImprovedCurrencyDropDown:SetTemplate('Transparent')

local function RESETGOLD()
	local myPlayerRealm = D['MyRealm']
	local myPlayerName  = UnitName('player')

	DuffedUIData['gold'] = {}
	DuffedUIData['gold'][myPlayerRealm] = {}
	DuffedUIData['gold'][myPlayerRealm][myPlayerName] = GetMoney()
end
SLASH_RESETGOLD1 = '/resetgold'
SlashCmdList['RESETGOLD'] = RESETGOLD

Stat:SetScript('OnMouseDown', function(self, btn)
	if btn == 'RightButton' and IsShiftKeyDown() then
		local myPlayerRealm = D['MyRealm']
		local myPlayerName  = UnitName('player')
	
		DuffedUIData['gold'] = {}
		DuffedUIData['gold'][myPlayerRealm] = {}
		DuffedUIData['gold'][myPlayerRealm][myPlayerName] = GetMoney()
	elseif btn == 'LeftButton' then
		ToggleAllBags()
	else
		Lib_EasyMenu(RightClickMenu, DuffedUIImprovedCurrencyDropDown, 'cursor', 0, 0, 'MENU', 2)
	end
end)