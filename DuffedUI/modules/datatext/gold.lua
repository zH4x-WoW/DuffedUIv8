local D, C, L = unpack(select(2, ...)) 

if not C["datatext"].gold or C["datatext"].gold == 0 then return end
D.SetPerCharVariable("ImprovedCurrency", {})

local Stat = CreateFrame("Frame", "DuffedUIDataInfoGold")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

Stat.Option = C["datatext"]["gold"]
Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

local font = D.Font(C["font"].datatext)
local Text = Stat:CreateFontString("DuffedUIDataInfoGoldText", "OVERLAY")
Text:SetFontObject(font)
D.DataTextPosition(C["datatext"].gold, Text)

local Profit = 0
local Spent = 0
local OldMoney = 0
local myPlayerRealm = D.MyRealm

local function formatMoney(money)
	local gold = floor(math.abs(money) / 10000)
	local silver = mod(floor(math.abs(money) / 100), 100)
	local copper = mod(floor(math.abs(money)), 100)

	if gold ~= 0 then
		return format(Stat.Color2.."%s|r" .. "|cffffd700g|r" .. Stat.Color2.." %s|r" .. "|cffc7c7cfs|r" .. Stat.Color2.." %s|r" .. "|cffeda55fc|r", gold, silver, copper)
	elseif silver ~= 0 then
		return format(Stat.Color2.."%s|r" .. "|cffc7c7cfs|r" .. Stat.Color2.." %s|r" .. "|cffeda55fc|r", silver, copper)
	else
		return format(Stat.Color2.."%s|r" .. "|cffeda55fc|r", copper)
	end
end

local function FormatTooltipMoney(money)
	local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	local cash = ""

	cash = format("%.2d" .. "|cffffd700g|r" .. " %.2d" .. "|cffc7c7cfs|r" .. " %.2d" .. "|cffeda55fc|r", gold, silver, copper)
	return cash
end	

local function Currency(id, weekly, capped)
	local name, amount, tex, week, weekmax, maxed, discovered, _ = GetCurrencyInfo(id)

	local r, g, b = 1, 1, 1
	for i = 1, GetNumWatchedTokens() do
		local _, _, _, itemID = GetBackpackCurrencyInfo(i)
		if id == itemID then r, g, b = .77, .12, .23 end
	end

	if (amount == 0 and r == 1) then return end
	if weekly then
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, "Current: " .. amount .. " - " .. WEEKLY .. ": " .. week .. " / " .. weekmax, r, g, b, r, g, b) end
	elseif capped  then
		if id == 392 then maxed = 4000 end
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount .. " / " .. maxed, r, g, b, r, g, b) end
	else
		if discovered then GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount, r, g, b, r, g, b) end
	end
end

local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then OldMoney = GetMoney() end

	local NewMoney	= GetMoney()
	local Change = NewMoney - OldMoney

	if OldMoney>NewMoney then Spent = Spent - Change else Profit = Profit + Change end
	Text:SetText(formatMoney(NewMoney))
	self:SetAllPoints(Text)

	local myPlayerName  = UnitName("player")
	if DuffedUIData == nil then DuffedUIData = {} end
	if DuffedUIData.gold == nil then DuffedUIData.gold = {} end
	if DuffedUIData.gold[myPlayerRealm] == nil then DuffedUIData.gold[myPlayerRealm] = {} end
	DuffedUIData.gold[myPlayerRealm][myPlayerName] = GetMoney()
	OldMoney = NewMoney
end

Stat:RegisterEvent("PLAYER_MONEY")
Stat:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
Stat:RegisterEvent("SEND_MAIL_COD_CHANGED")
Stat:RegisterEvent("PLAYER_TRADE_MONEY")
Stat:RegisterEvent("TRADE_MONEY_CHANGED")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")

Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnEnter", function(self)
	if not C["datatext"].ShowInCombat then
		if InCombatLockdown() then return end
	end

	if ImprovedCurrency["Archaeology"] == nil then ImprovedCurrency["Archaeology"] = true end
	if ImprovedCurrency["Cooking"] == nil then ImprovedCurrency["Cooking"] = true end
	if ImprovedCurrency["Professions"] == nil then ImprovedCurrency["Professions"] = true end
	if ImprovedCurrency["Miscellaneous"] == nil then ImprovedCurrency["Miscellaneous"] = true end
	if ImprovedCurrency["PvP"] == nil then ImprovedCurrency["PvP"] = true end
	if ImprovedCurrency["Raid"] == nil then ImprovedCurrency["Raid"] = true end

	local prof1, prof2, archaeology, _, cooking = GetProfessions()

	local anchor, panel, xoff, yoff = D.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L["dt"]["session"])
	GameTooltip:AddDoubleLine(L["dt"]["earned"], formatMoney(Profit), 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(L["dt"]["spent"], formatMoney(Spent), 1, 1, 1, 1, 1, 1)

	if Profit < Spent then
		GameTooltip:AddDoubleLine(L["dt"]["deficit"], formatMoney(Profit - Spent), 1, 0, 0, 1, 1, 1)
	elseif (Profit-Spent) > 0 then
		GameTooltip:AddDoubleLine(L["dt"]["profit"], formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
	end

	GameTooltip:AddLine(" ")

	local totalGold = 0
	GameTooltip:AddLine(L["dt"]["character"])

	local thisRealmList = DuffedUIData.gold[myPlayerRealm]
	for k, v in pairs(thisRealmList) do
		GameTooltip:AddDoubleLine(k, FormatTooltipMoney(v), 1, 1, 1, 1, 1, 1)
		totalGold = totalGold + v
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L["dt"]["server"])
	GameTooltip:AddDoubleLine(FROM_TOTAL .. " ", FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

	if archaeology and ImprovedCurrency["Archaeology"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PROFESSIONS_ARCHAEOLOGY .. ": ")
		Currency(398)
		Currency(384)
		Currency(393)
		Currency(677)
		Currency(400)
		Currency(394)
		Currency(397)
		Currency(676)
		Currency(401)
		Currency(385)
		Currency(399)
		Currency(829)
		Currency(944)
		Currency(810)
		Currency(821)
		Currency(754)
		Currency(677)
		Currency(676)
		Currency(828)
	end

	if cooking and ImprovedCurrency["Cooking"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PROFESSIONS_COOKING .. ": ")
		Currency(81)
		Currency(402)
	end

	if ImprovedCurrency["Professions"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Profession Token & Garrison")
		Currency(61)
		Currency(361)
		Currency(824)
		Currency(980)
	end

	if ImprovedCurrency["Raid"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["dt"]["dr"])
		Currency(994, false, true)
		Currency(776, false, true)
		Currency(752, false, true)
		Currency(697, false, true)
		Currency(738)
		Currency(615)
		Currency(614)
		Currency(823)
	end

	if ImprovedCurrency["PvP"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(PVP_FLAG)
		Currency(390, true)
		Currency(392, false, true)
		Currency(391)
		Currency(944)
	end

	if ImprovedCurrency["Miscellaneous"] then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(MISCELLANEOUS)
		Currency(241)
		Currency(416)
		Currency(515)
		Currency(777)
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L["dt"]["goldbagsopen"])
	GameTooltip:AddLine(L["dt"]["goldcurrency"])
	GameTooltip:AddLine(L["dt"]["goldreset"])

	GameTooltip:Show()
	GameTooltip:SetTemplate("Transparent")
end)

Stat:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)

local RightClickMenu = {
	{ text = "DuffedUI Improved Currency Options", isTitle = true , notCheckable = true },
	{ text = "Show Archaeology Fragments", checked = function() return ImprovedCurrency["Archaeology"] end, func = function()
		if ImprovedCurrency["Archaeology"] then
			ImprovedCurrency["Archaeology"] = false
		else
			ImprovedCurrency["Archaeology"] = true
		end
	end	},
	{ text = "Show Profession Tokens", checked = function() return ImprovedCurrency["Professions"] end, func = function()
		if ImprovedCurrency["Professions"] then
			ImprovedCurrency["Professions"] = false
		else
			ImprovedCurrency["Professions"] = true
		end
	end	},
	{ text = "Show Player vs Player Currency", checked = function() return ImprovedCurrency["PvP"] end, func = function()
		if ImprovedCurrency["PvP"] then 
			ImprovedCurrency["PvP"] = false
		else
			ImprovedCurrency["PvP"] = true
		end
	end	},
	{ text = "Show Dungeon and Raid Currency", checked = function() return ImprovedCurrency["Raid"] end, func = function()
		if ImprovedCurrency["Raid"] then
			ImprovedCurrency["Raid"] = false
		else
			ImprovedCurrency["Raid"] = true
		end
	end	},
	{ text = "Show Cooking Awards", checked = function() return ImprovedCurrency["Cooking"] end, func = function()
		if ImprovedCurrency["Cooking"] then
			ImprovedCurrency["Cooking"] = false
		else
			ImprovedCurrency["Cooking"] = true
		end
	end	},
	{ text = "Show Miscellaneous Currency", checked = function() return ImprovedCurrency["Miscellaneous"] end, func = function()
		if ImprovedCurrency["Miscellaneous"] then
			ImprovedCurrency["Miscellaneous"] = false
		else
			ImprovedCurrency["Miscellaneous"] = true
		end
	end	},
}

local DuffedUIImprovedCurrencyDropDown = CreateFrame("Frame", "DuffedUIImprovedCurrencyDropDown", UIParent, "UIDropDownMenuTemplate")
DuffedUIImprovedCurrencyDropDown:SetTemplate("Transparent")

local function RESETGOLD()
	local myPlayerRealm = D.MyRealm
	local myPlayerName  = UnitName("player")

	DuffedUIData.gold = {}
	DuffedUIData.gold[myPlayerRealm] = {}
	DuffedUIData.gold[myPlayerRealm][myPlayerName] = GetMoney()
end
SLASH_RESETGOLD1 = "/resetgold"
SlashCmdList["RESETGOLD"] = RESETGOLD

Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == "RightButton" and IsShiftKeyDown() then
		local myPlayerRealm = D.MyRealm
		local myPlayerName  = UnitName("player")
	
		DuffedUIData.gold = {}
		DuffedUIData.gold[myPlayerRealm] = {}
		DuffedUIData.gold[myPlayerRealm][myPlayerName] = GetMoney()
	elseif btn == "LeftButton" then
		ToggleAllBags()
	else
		EasyMenu(RightClickMenu, DuffedUIImprovedCurrencyDropDown, "cursor", 0, 0, "MENU", 2)
	end
end)