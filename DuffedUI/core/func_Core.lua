local D, C, L = unpack(select(2, ...))

-- Default Actionbutton size
D['buttonsize'] = D['Scale'](C['actionbar']['buttonsize'])
D['SidebarButtonsize'] = D['Scale'](C['actionbar']['SidebarButtonsize'])
D['buttonspacing'] = D['Scale'](C['actionbar']['buttonspacing'])
D['petbuttonsize'] = D['Scale'](C['actionbar']['petbuttonsize'])
D['petbuttonspacing'] = D['Scale'](C['actionbar']['buttonspacing'])

-- Hover tooltip
local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}

local function OnHyperlinkEnter(frame, link, ...)
	local linktype = link:match('^([^:]+)')
	if linktype and linktypes[linktype] then
		GameTooltip:SetOwner(frame, 'ANCHOR_TOP', 0, 32)
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	if orig1[frame] then return orig1[frame](frame, link, ...) end
end

local function OnHyperlinkLeave(frame, ...)
	GameTooltip:Hide()
	if orig2[frame] then return orig2[frame](frame, ...) end
end

D['HyperlinkMouseover'] = function()
	local _G = getfenv(0)
	for i = 1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local frame = _G['ChatFrame'..i]
			orig1[frame] = frame:GetScript('OnHyperlinkEnter')
			frame:SetScript('OnHyperlinkEnter', OnHyperlinkEnter)

			orig2[frame] = frame:GetScript('OnHyperlinkLeave')
			frame:SetScript('OnHyperlinkLeave', OnHyperlinkLeave)
		end
	end
end
D['HyperlinkMouseover']()

-- Currencys
local GetCurrencyInfo = GetCurrencyInfo
D['Currency'] = function(id, weekly, capped)
	local name, amount, tex, week, weekmax, maxed, discovered = GetCurrencyInfo(id)

	local r, g, b = 1, 1, 1
	for i = 1, GetNumWatchedTokens() do
		local _, _, _, itemID = GetBackpackCurrencyInfo(i)
		if id == itemID then r, g, b = .77, .12, .23 end
	end

	if (amount == 0 and r == 1) then return end
	if weekly then
		if id == 390 then week = floor(math.abs(week) / 100) end
		if discovered then GameTooltip:AddDoubleLine('\124T' .. tex .. ':12\124t ' .. name, 'Current: ' .. amount .. ' - ' .. WEEKLY .. ': ' .. week .. ' / ' .. weekmax, r, g, b, r, g, b) end
	elseif capped  then
		if id == 392 then maxed = 4000 end
		if discovered then GameTooltip:AddDoubleLine('\124T' .. tex .. ':12\124t ' .. name, amount .. ' / ' .. maxed, r, g, b, r, g, b) end
	else
		if discovered then GameTooltip:AddDoubleLine('\124T' .. tex .. ':12\124t ' .. name, amount, r, g, b, r, g, b) end
	end
end

-- Button mouseover
D['ButtonMO'] = function(frame)
	frame:SetAlpha(0)
	frame:SetScript('OnEnter', function() frame:SetAlpha(1) end)
	frame:SetScript('OnLeave', function() frame:SetAlpha(0) end)
end

-- Shorten comma values
D['CommaValue'] = function(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
		if (k == 0) then break end
	end
	return formatted
end

-- Set fontstring
D['SetFontString'] = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH('LEFT')
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

-- DataText positions
D['DataTextPosition'] = function(p, obj)
	local left = DuffedUIInfoLeft
	local right = DuffedUIInfoRight
	local center = DuffedUIInfoCenter

	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('LEFT', left, 30, -1)
		obj:SetPoint('TOP', left, 0, -1)
		obj:SetPoint('BOTTOM', left, 0, -1)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left, 0, -1)
		obj:SetPoint('BOTTOM', left, 0, -1)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('RIGHT', left, -30, -1)
		obj:SetPoint('TOP', left, 0, -1)
		obj:SetPoint('BOTTOM', left, 0, -1)
	elseif p == 4 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('LEFT', right, 30, -1)
		obj:SetPoint('TOP', right, 0, -1)
		obj:SetPoint('BOTTOM', right, 0, -1)
	elseif p == 5 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right, 0, -1)
		obj:SetPoint('BOTTOM', right, 0, -1)
	elseif p == 6 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('RIGHT', right, -30, -1)
		obj:SetPoint('TOP', right, 0, -1)
		obj:SetPoint('BOTTOM', right, 0, -1)
	elseif p == 7 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('LEFT', center, 30, -1)
		obj:SetPoint('TOP', center, 0, -1)
		obj:SetPoint('BOTTOM', center, 0, -1)
	elseif p == 8 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('RIGHT', center, -30, -1)
		obj:SetPoint('TOP', center, 0, -1)
		obj:SetPoint('BOTTOM', center, 0, -1)
	end
end

D['DataTextTooltipAnchor'] = function(self)
	local panel = self:GetParent()
	local anchor = 'ANCHOR_TOP'
	local xoff = 0
	local yoff = D['Scale'](5)

	if panel == DuffedUIInfoLeft then
		anchor = 'ANCHOR_TOPLEFT'
	elseif panel == DuffedUIInfoRight then
		anchor = 'ANCHOR_TOPRIGHT'
	elseif panel == DuffedUIInfoCenter then
		anchor = 'ANCHOR_TOPRIGHT'
	end

	return anchor, panel, xoff, yoff
end

D['Round'] = function(number, decimals)
	if not decimals then decimals = 0 end
	return (('%%.%df'):format(decimals)):format(number)
end

D['RGBToHex'] = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format('|cff%02x%02x%02x', r*255, g*255, b*255)
end

if C['general']['classcolor'] then C['media']['datatextcolor1'] = D['UnitColor']['class'][D.Class] end
D['PanelColor'] = D['RGBToHex'](unpack(C['media']['datatextcolor1']))

D['ShortValue'] = function(v)
	if v >= 1e9 then
		return ('%.1fb'):format(v / 1e9):gsub('%.?0+([km])$', '%1')
	elseif v >= 1e6 then
		return ('%.1fm'):format(v / 1e6):gsub('%.?0+([km])$', '%1')
	elseif v >= 1e3 or v <= -1e3 then
		return ('%.1fk'):format(v / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return v
	end
end

local function CheckRole(self, event, unit)
	local tree = GetSpecialization()
	local role = tree and select(6, GetSpecializationInfo(tree))
	if role == 'TANK' then
		D['Role'] = 'Tank'
	elseif role == 'HEALER' then
		D['Role'] = 'Healer'
	elseif role == 'DAMAGER' then
		local playerint = select(2, UnitStat('player', 4))
		local playeragi = select(2, UnitStat('player', 2))
		local base, posBuff, negBuff = UnitAttackPower('player')
		local playerap = base + posBuff + negBuff
		if (playerap > playerint) or (playeragi > playerint) then D['Role'] = 'Melee' else D['Role'] = 'Caster' end
	end
end
local RoleUpdater = CreateFrame('Frame')
RoleUpdater:RegisterEvent('PLAYER_ENTERING_WORLD')
RoleUpdater:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
RoleUpdater:RegisterEvent('PLAYER_TALENT_UPDATE')
RoleUpdater:RegisterEvent('CHARACTER_POINTS_CHANGED')
RoleUpdater:RegisterEvent('UNIT_INVENTORY_CHANGED')
RoleUpdater:RegisterEvent('UPDATE_BONUS_ACTIONBAR')
RoleUpdater:SetScript('OnEvent', CheckRole)

local myPlayerName = D['MyName']
local myPlayerRealm = D['MyRealm']
D['SetValue'] = function(group, option, value)
	local mergesettings
	if DuffedUIConfigPrivate == DuffedUIConfigPublic then mergesettings = true else mergesettings = false end

	if DuffedUIConfigAll[myPlayerRealm][myPlayerName] == true then
		if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
		if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
		DuffedUIConfigPrivate[group][option] = value
	else
		if mergesettings == true then
			if not DuffedUIConfigPrivate then DuffedUIConfigPrivate = {} end
			if not DuffedUIConfigPrivate[group] then DuffedUIConfigPrivate[group] = {} end
			DuffedUIConfigPrivate[group][option] = value
		end
		if not DuffedUIConfigPublic then DuffedUIConfigPublic = {} end
		if not DuffedUIConfigPublic[group] then DuffedUIConfigPublic[group] = {} end
		DuffedUIConfigPublic[group][option] = value
	end
end

local waitTable = {}
local waitFrame
D['Delay'] = function(delay, func, ...)
	if (type(delay) ~= 'number') or (type(func) ~= 'function') then return false end
	if waitFrame == nil then
		waitFrame = CreateFrame('Frame', 'WaitFrame', UIParent)
		waitFrame:SetScript('onUpdate', function(self, elapse)
			local count = #waitTable
			local i = 1
			while i <= count do
				local waitRecord = tremove(waitTable, i)
				local d = tremove(waitRecord, 1)
				local f = tremove(waitRecord, 1)
				local p = tremove(waitRecord, 1)
				if d > elapse then
					tinsert(waitTable, i, {d - elapse, f, p})
					i = i + 1
				else
					count = count - 1
					f(unpack(p))
				end
			end
		end)
	end
	tinsert(waitTable, {delay, func, {...}})
	return true
end

D['CreateBtn'] = function(name, parent, w, h, tt_txt, txt)
	local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
	local b = CreateFrame('Button', name, parent, 'SecureActionButtonTemplate')
	b:Width(w)
	b:Height(h)
	b:SetTemplate('Default')
	b:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
		GameTooltip:AddLine(tt_txt, 1, 1, 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	b:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

	b.text = b:CreateFontString(nil, 'OVERLAY')
	b.text:SetFont(f, fs, ff)
	b.text:SetText(D['PanelColor'] .. txt)
	b.text:SetPoint('CENTER', b, 'CENTER', 1, -1)
	b.text:SetJustifyH('CENTER')
	b:SetAttribute('type1', 'macro')
end


-- Tooltip code ripped from StatBlockCore by Funkydude
function D.GetAnchors(frame)
	local x, y = frame:GetCenter()

	if not x or not y then return "CENTER" end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"

	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end

function D.HideTooltip()
	if GameTooltip:IsForbidden() then
		return
	end

	GameTooltip:Hide()
end

local function tooltipOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(D.GetAnchors(self))
	GameTooltip:ClearLines()
	if self.title then
		GameTooltip:AddLine(self.title)
	end
	if tonumber(self.text) then
		GameTooltip:SetSpellByID(self.text)
	elseif self.text then
		local r, g, b = 1, 1, 1
		if self.color == "class" then
			r, g, b = D.Color.r, D.Color.g, D.Color.b
		elseif self.color == "system" then
			r, g, b = 1, .8, 0
		elseif self.color == "info" then
			r, g, b = .6, .8, 1
		end
		GameTooltip:AddLine(self.text, r, g, b, 1)
	end
	GameTooltip:Show()
end

function D.AddTooltip(self, anchor, text, color)
	self.anchor = anchor
	self.text = text
	self.color = color

	self:SetScript("OnEnter", tooltipOnEnter)
	self:SetScript("OnLeave", D.HideTooltip)
end

-- Itemlevel
local iLvlDB = {}
local itemLevelString = gsub(ITEM_LEVEL, "%%d", "")
local enchantString = gsub(ENCHANTED_TOOLTIP_LINE, "%%s", "(.+)")
local essenceTextureID = 2975691
local essenceDescription = GetSpellDescription(277253)
local ITEM_SPELL_TRIGGER_ONEQUIP = ITEM_SPELL_TRIGGER_ONEQUIP
local tip = CreateFrame("GameTooltip", "DuffedUI_iLvlTooltip", nil, "GameTooltipTemplate")

function D:InspectItemTextures()
	if not tip.gems then
		tip.gems = {}
	else
		wipe(tip.gems)
	end

	if not tip.essences then
		tip.essences = {}
	else
		for _, essences in pairs(tip.essences) do
			wipe(essences)
		end
	end

	local step = 1
	for i = 1, 10 do
		local tex = _G[tip:GetName().."Texture"..i]
		local texture = tex and tex:IsShown() and tex:GetTexture()
		if texture then
			if texture == essenceTextureID then
				local selected = (tip.gems[i-1] ~= essenceTextureID and tip.gems[i-1]) or nil
				if not tip.essences[step] then tip.essences[step] = {} end
				tip.essences[step][1] = selected		--essence texture if selected or nil
				tip.essences[step][2] = tex:GetAtlas()	--atlas place 'tooltip-heartofazerothessence-major' or 'tooltip-heartofazerothessence-minor'
				tip.essences[step][3] = texture			--border texture placed by the atlas

				step = step + 1
				if selected then tip.gems[i-1] = nil end
			else
				tip.gems[i] = texture
			end
		end
	end

	return tip.gems, tip.essences
end

function D:InspectItemInfo(text, slotInfo)
	local itemLevel = strfind(text, itemLevelString) and strmatch(text, "(%d+)%)?$")
	if itemLevel then
		slotInfo.iLvl = tonumber(itemLevel)
	end

	local enchant = strmatch(text, enchantString)
	if enchant then
		slotInfo.enchantText = enchant
	end
end

function D:CollectEssenceInfo(index, lineText, slotInfo)
	local step = 1
	local essence = slotInfo.essences[step]
	if essence and next(essence) and (strfind(lineText, ITEM_SPELL_TRIGGER_ONEQUIP, nil, true) and strfind(lineText, essenceDescription, nil, true)) then
		for i = 5, 2, -1 do
			local line = _G[tip:GetName().."TextLeft"..index-i]
			local text = line and line:GetText()

			if text and (not strmatch(text, "^[ +]")) and essence and next(essence) then
				local r, g, b = line:GetTextColor()
				essence[4] = r
				essence[5] = g
				essence[6] = b

				step = step + 1
				essence = slotInfo.essences[step]
			end
		end
	end
end

function D.GetItemLevel(link, arg1, arg2, fullScan)
	if fullScan then
		tip:SetOwner(UIParent, "ANCHOR_NONE")
		tip:SetInventoryItem(arg1, arg2)

		if not tip.slotInfo then tip.slotInfo = {} else wipe(tip.slotInfo) end

		local slotInfo = tip.slotInfo
		slotInfo.gems, slotInfo.essences = D:InspectItemTextures()

		for i = 1, tip:NumLines() do
			local line = _G[tip:GetName().."TextLeft"..i]
			if line then
				local text = line:GetText() or ""
				D:InspectItemInfo(text, slotInfo)
				D:CollectEssenceInfo(i, text, slotInfo)
			end
		end

		return slotInfo
	else
		if iLvlDB[link] then return iLvlDB[link] end

		tip:SetOwner(UIParent, "ANCHOR_NONE")
		if arg1 and type(arg1) == "string" then
			tip:SetInventoryItem(arg1, arg2)
		elseif arg1 and type(arg1) == "number" then
			tip:SetBagItem(arg1, arg2)
		else
			tip:SetHyperlink(link)
		end

		for i = 2, 5 do
			local line = _G[tip:GetName().."TextLeft"..i]
			if line then
				local text = line:GetText() or ""
				local found = strfind(text, itemLevelString)
				if found then
					local level = strmatch(text, "(%d+)%)?$")
					iLvlDB[link] = tonumber(level)
					break
				end
			end
		end

		return iLvlDB[link]
	end
end

function D.CreateFontString(self, size, text, textstyle, classcolor, anchor, x, y)
	local fs = self:CreateFontString(nil, "OVERLAY")

	if textstyle == " " or textstyle == "" or textstyle == nil then
		fs:SetFont(C['media']['font'], size, "")
		fs:SetShadowOffset(1, -1 / 2)
	else
		fs:SetFont(C['media']['font'], size, "OUTLINE")
		fs:SetShadowOffset(0, 0)
	end
	fs:SetText(text)
	fs:SetWordWrap(false)

	if classcolor and type(classcolor) == "boolean" then
		fs:SetTextColor(D.r, D.g, D.b)
	elseif classcolor == "system" then
		fs:SetTextColor(1, .8, 0)
	end

	if anchor and x and y then
		fs:SetPoint(anchor, x, y)
	else
		fs:SetPoint("CENTER", 1, 0)
	end

	return fs
end