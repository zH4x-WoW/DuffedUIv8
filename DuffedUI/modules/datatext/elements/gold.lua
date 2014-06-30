local D, C, L = select(2, ...):unpack()

local DataText = D["DataTexts"]
local format = format
local floor = floor
local abs = abs
local mod = mod

local Profit = 0
local Spent = 0
local MyRealm = GetRealmName()
local MyName = UnitName("player")

ImprovedCurrency = {}

local FormatMoney = function(money)
	local Gold = floor(abs(money) / 10000)
	local Silver = mod(floor(abs(money) / 100), 100)
	local Copper = mod(floor(abs(money)), 100)
	
	if (Gold ~= 0) then
		return format(DataText.NameColor.."%s|r"..L.DataText.GoldShort..DataText.NameColor.." %s|r"..L.DataText.SilverShort..DataText.NameColor.." %s|r"..L.DataText.CopperShort, Gold, Silver, Copper)
	elseif (Silver ~= 0) then
		return format(DataText.NameColor.."%s|r"..L.DataText.SilverShort..DataText.NameColor.." %s|r"..L.DataText.CopperShort, Silver, Copper)
	else
		return format(DataText.NameColor.."%s|r"..L.DataText.CopperShort, Copper)
	end
end

local FormatTooltipMoney = function(money)
	local Gold, Silver, Copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	local Money = format("%.2d"..L.DataText.GoldShort.." %.2d"..L.DataText.SilverShort.." %.2d"..L.DataText.CopperShort, Gold, Silver, Copper)		
	return Money
end

local function Currency(id, weekly, capped)
	local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)
	
	local r, g, b = 1, 1, 1
	for i = 1, GetNumWatchedTokens() do
		local _, _, _, itemID = GetBackpackCurrencyInfo( i )
		if id == itemID then r, g, b = .77, .12, .23 end
	end

	if (amount == 0 and not ImprovedCurrency["Zero"] and r == 1) then return end

	if weekly then
		if discovered then
			if id == 390 then
				GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, "Current: " .. amount .. " - " .. L.DataText.currencyWeekly .. week .. " / " .. weekmax, r, g, b, r, g, b)
			else
				GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, "Current: " .. amount .. " / " .. maxed .. " - " .. L.DataText.currencyWeekly .. week .. " / " .. weekmax, r, g, b, r, g, b)
			end
		end
	elseif capped  then
		if id == 392 or id == 395 then maxed = 4000 end
		if id == 396 then maxed = 3000 end
		if discovered then
			if id == 396 then
				GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, "Current: " .. amount .. " / " .. maxed .. " - " .. L.DataText.currencyWeekly .. week .. " / 1000", r, g, b, r, g, b)
			else
				GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount .. " / " .. maxed, r, g, b, r, g, b)
			end
		end
	else
		if discovered then
			GameTooltip:AddDoubleLine("\124T" .. tex .. ":12\124t " .. name, amount, r, g, b, r, g, b)
		end
	end
end	

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		if ImprovedCurrency["Archaeology"] == nil then ImprovedCurrency["Archaeology"] = true end
		if ImprovedCurrency["Cooking"] == nil then ImprovedCurrency["Cooking"] = true end
		if ImprovedCurrency["Jewelcrafting"] == nil then ImprovedCurrency["Jewelcrafting"] = true end
		if ImprovedCurrency["Miscellaneous"] == nil then ImprovedCurrency["Miscellaneous"] = true end
		if ImprovedCurrency["PvP"] == nil then ImprovedCurrency["PvP"] = true end
		if ImprovedCurrency["Raid"] == nil then ImprovedCurrency["Raid"] = true end
		if ImprovedCurrency["Zero"] == nil then ImprovedCurrency["Zero"] = true end
		
		local prof1, prof2, archaeology, _, cooking = GetProfessions()
		
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		GameTooltip:AddLine(L.DataText.Session)
		GameTooltip:AddDoubleLine(L.DataText.Earned, FormatMoney(Profit), 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L.DataText.Spent, FormatMoney(Spent), 1, 1, 1, 1, 1, 1)
		
		if (Profit < Spent) then
			GameTooltip:AddDoubleLine(L.DataText.Deficit, FormatMoney(Profit-Spent), 1, 0, 0, 1, 1, 1)
		elseif ((Profit-Spent) > 0) then
			GameTooltip:AddDoubleLine(L.DataText.Profit, FormatMoney(Profit-Spent), 0, 1, 0, 1, 1, 1)
		end
		
		GameTooltip:AddLine(" ")							
		
		local TotalGold = 0				
		GameTooltip:AddLine(L.DataText.Character)			

		for key, value in pairs(DuffedUIData.Gold[MyRealm]) do
			GameTooltip:AddDoubleLine(key, FormatTooltipMoney(value), 1, 1, 1, 1, 1, 1)
			TotalGold = TotalGold + value
		end
		
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L.DataText.Server)
		GameTooltip:AddDoubleLine(L.DataText.TotalGold, FormatTooltipMoney(TotalGold), 1, 1, 1, 1, 1, 1)
		
		if archaeology and ImprovedCurrency["Archaeology"] then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L.Tooltips.gold_a)
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
		end

		if cooking and ImprovedCurrency["Cooking"] then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L.Tooltips.gold_c)
			Currency(81)
			Currency(402)
		end

		if (prof1 == 9 or prof2 == 9) and ImprovedCurrency["Jewelcrafting"] then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L.Tooltips.gold_jc)
			Currency(61)
			Currency(361)
			Currency(698)
		end

		if ImprovedCurrency["Raid"] then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L.Tooltips.gold_dr)
			Currency(776, false, true)
			Currency(752, false, true)
			Currency(697, false, true)
			Currency(738)
			Currency(615)
			Currency(614)
			Currency(395, false, true)
			Currency(396, false, true)
		end

		if ImprovedCurrency["PvP"] then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(PVP_FLAG)
			Currency(390, true)
			Currency(392, false, true)
			Currency(391)
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
		GameTooltip:AddLine("|cffC41F3BReset Data: Hold Shift + Right Click|r")
		
		GameTooltip:Show()
	end
end

local OnLeave = function() GameTooltip:Hide() end

local RightClickMenu = {
	{ text = "DuffedUI Improved Currency Options", isTitle = true , notCheckable = true },
	{ text = "Show Archaeology Fragments", checked = function() return ImprovedCurrency["Archaeology"] end, func = function()
		if ImprovedCurrency["Archaeology"] then
			ImprovedCurrency["Archaeology"] = false
		else
			ImprovedCurrency["Archaeology"] = true
		end
	end	},
	{ text = "Show Jewelcrafting Tokens", checked = function() return ImprovedCurrency["Jewelcrafting"] end, func = function()
		if ImprovedCurrency["Jewelcrafting"] then
			ImprovedCurrency["Jewelcrafting"] = false
		else
			ImprovedCurrency["Jewelcrafting"] = true
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
	{ text = "Show Zero Currency", checked = function() return ImprovedCurrency["Zero"] end, func = function()
		if ImprovedCurrency["Zero"] then
			ImprovedCurrency["Zero"] = false
		else
			ImprovedCurrency["Zero"] = true
		end
	end	},
}
local DuffedUIImprovedCurrencyDropDown = CreateFrame("Frame", "DuffedUIImprovedCurrencyDropDown", UIParent, "UIDropDownMenuTemplate")

local Update = function(self, event)
	if (not IsLoggedIn()) then return end

	local NewMoney = GetMoney()

	DuffedUIData = DuffedUIData or { }
	DuffedUIData["Gold"] = DuffedUIData["Gold"] or {}
	DuffedUIData["Gold"][MyRealm] = DuffedUIData["Gold"][MyRealm] or {}
	DuffedUIData["Gold"][MyRealm][MyName] = DuffedUIData["Gold"][MyRealm][MyName] or NewMoney

	local OldMoney = DuffedUIData["Gold"][MyRealm][MyName] or NewMoney

	local Change = NewMoney - OldMoney
	if (OldMoney > NewMoney) then
		Spent = Spent - Change
	else
		Profit = Profit + Change
	end

	self.Text:SetText(FormatMoney(NewMoney))

	DuffedUIData["Gold"][MyRealm][MyName] = NewMoney
end

local OnMouseDown = function(self, btn)
	if btn == "RightButton" and IsShiftKeyDown() then
		DuffedUIData = {}
		DuffedUIData["Gold"] = {}
		DuffedUIData["Gold"][MyRealm] = {}
		DuffedUIData["Gold"][MyRealm][MyName] = GetMoney()
	else
		EasyMenu(RightClickMenu, DuffedUIImprovedCurrencyDropDown, "cursor", 0, 0, "MENU", 2)
	end
end

local Enable = function(self)
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
	self:RegisterEvent("SEND_MAIL_COD_CHANGED")
	self:RegisterEvent("PLAYER_TRADE_MONEY")
	self:RegisterEvent("TRADE_MONEY_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnEvent", Update)
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:Update()
end

DataText:Register("Gold", Enable, Disable, Update) -- Localize me