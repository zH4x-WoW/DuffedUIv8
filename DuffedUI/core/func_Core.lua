local D, C, L = unpack(select(2, ...))

--[[Default Actionbutton size]]--
D["buttonsize"] = D["Scale"](C["actionbar"]["buttonsize"])
D["SidebarButtonsize"] = D["Scale"](C["actionbar"]["SidebarButtonsize"])
D["buttonspacing"] = D["Scale"](C["actionbar"]["buttonspacing"])
D["petbuttonsize"] = D["Scale"](C["actionbar"]["petbuttonsize"])
D["petbuttonspacing"] = D["Scale"](C["actionbar"]["buttonspacing"])

--[[Hover tooltip]]--
local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip
local linktypes = {item = true, enchant = true, spell = true, quest = true, unit = true, talent = true, achievement = true, glyph = true}

local function OnHyperlinkEnter(frame, link, ...)
	local linktype = link:match("^([^:]+)")
	if linktype and linktypes[linktype] then
		GameTooltip:SetOwner(frame, "ANCHOR_TOP", 0, 32)
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	if orig1[frame] then return orig1[frame](frame, link, ...) end
end

local function OnHyperlinkLeave(frame, ...)
	GameTooltip:Hide()
	if orig2[frame] then return orig2[frame](frame, ...) end
end

function D.HyperlinkMouseover()
	local _G = getfenv(0)
	for i=1, NUM_CHAT_WINDOWS do
		if ( i ~= 2 ) then
			local frame = _G["ChatFrame"..i]
			orig1[frame] = frame:GetScript("OnHyperlinkEnter")
			frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)

			orig2[frame] = frame:GetScript("OnHyperlinkLeave")
			frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
		end
	end
end
D.HyperlinkMouseover()

--[[Button mouseover]]--
D["ButtonMO"] = function(frame)
	frame:SetAlpha(0)
	frame:SetScript("OnEnter", function() frame:SetAlpha(1) end)
	frame:SetScript("OnLeave", function() frame:SetAlpha(0) end)
end

--[[Shorten comma values]]--
D.CommaValue = function(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k == 0) then break end
	end
	return formatted
end

--[[Set fontstring]]--
D.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

--[[DataText positions]]--
D.DataTextPosition = function(p, obj)
	local left = DuffedUIInfoLeft
	local right = DuffedUIInfoRight
	local mapleft = DuffedUIMinimapStatsLeft
	local mapright = DuffedUIMinimapStatsRight

	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("LEFT", left, 30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("RIGHT", left, -30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 4 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("LEFT", right, 30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 5 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 6 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("RIGHT", right, -30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	end

	if DuffedUIMinimap then
		if p == 7 then
			obj:SetParent(mapleft)
			obj:SetHeight(mapleft:GetHeight())
			obj:SetPoint('TOP', mapleft)
			obj:SetPoint('BOTTOM', mapleft)
		elseif p == 8 then
			obj:SetParent(mapright)
			obj:SetHeight(mapright:GetHeight())
			obj:SetPoint('TOP', mapright)
			obj:SetPoint('BOTTOM', mapright)
		end
	end
end

D.DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_TOP"
	local xoff = 0
	local yoff = D["Scale"](5)

	if panel == DuffedUIInfoLeft then
		anchor = "ANCHOR_TOPLEFT"
	elseif panel == DuffedUIInfoRight then
		anchor = "ANCHOR_TOPRIGHT"
	elseif panel == DuffedUIMinimapStatsLeft or panel == DuffedUIMinimapStatsRight then
		local position = DuffedUIMinimap:GetPoint()
		if position:match("LEFT") then
			anchor = "ANCHOR_BOTTOMRIGHT"
			yoff = D["Scale"](-6)
			xoff = 0 - DuffedUIMinimapStatsRight:GetWidth()
		elseif position:match("RIGHT") then
			anchor = "ANCHOR_BOTTOMLEFT"
			yoff = D["Scale"](-6)
			xoff = DuffedUIMinimapStatsRight:GetWidth()
		else
			anchor = "ANCHOR_BOTTOM"
			yoff = D["Scale"](-6)
		end
	end

	return anchor, panel, xoff, yoff
end

D.ShiftBarUpdate = function(self)
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_STANCE_SLOTS do
		buttonName = "StanceButton"..i
		button = _G[buttonName]
		icon = _G[buttonName.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)

			if not icon then return end
			icon:SetTexture(texture)
			cooldown = _G[buttonName.."Cooldown"]
			if texture then cooldown:SetAlpha(1) else cooldown:SetAlpha(0) end

			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)

			if isActive then
				StanceBarFrame.lastSelected = button:GetID()
				button:GetCheckedTexture():SetTexture(0, 1, 0, .3)
			else
				button:SetCheckedTexture(0, 0, 0, 0)
			end

			if isCastable then icon:SetVertexColor(1, 1, 1) else icon:SetVertexColor(.4, .4, .4) end
		end
	end
end

D.PetBarUpdate = function(...)
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		local petActionButton = _G[buttonName]
		local petActionIcon = _G[buttonName.."Icon"]
		local petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		local petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)

		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end

		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:GetCheckedTexture():SetTexture(0, 1, 0, .3)
			if IsPetAttackAction(i) then PetActionButton_StartFlash(petActionButton) end
		else
			petActionButton:SetCheckedTexture(0, 0, 0, 0)
			if IsPetAttackAction(i) then PetActionButton_StopFlash(petActionButton) end
		end

		if autoCastAllowed then petAutoCastableTexture:Show() else petAutoCastableTexture:Hide() end
		if autoCastEnabled then AutoCastShine_AutoCastStart(petAutoCastShine) else AutoCastShine_AutoCastStop(petAutoCastShine) end

		if texture then
			if GetPetActionSlotUsable(i) then SetDesaturation(petActionIcon, nil) else SetDesaturation(petActionIcon, 1) end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end

		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetCheckedTexture(0, 0, 0, 0)
		end
	end
end

D.Round = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

D.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

if C["general"].classcolor then C["media"].datatextcolor1 = D.UnitColor.class[D.Class] end
D.PanelColor = D.RGBToHex(unpack(C["media"].datatextcolor1))

D.ShortValue = function(v)
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

local function CheckRole(self, event, unit)
	local tree = GetSpecialization()
	local role = tree and select(6, GetSpecializationInfo(tree))
	if role == "TANK" then
		D.Role = "Tank"
	elseif role == "HEALER" then
		D.Role = "Healer"
	elseif role == "DAMAGER" then
		local playerint = select(2, UnitStat("player", 4))
		local playeragi = select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player")
		local playerap = base + posBuff + negBuff
		if (playerap > playerint) or (playeragi > playerint) then D.Role = "Melee" else D.Role = "Caster" end
	end
end
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", CheckRole)

local myPlayerName = D.MyName
local myPlayerRealm = D.MyRealm
D.SetValue = function(group, option, value)
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
D.Delay = function(delay, func, ...)
	if (type(delay) ~= "number") or (type(func) ~= "function") then return false end
	if waitFrame == nil then
		waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
		waitFrame:SetScript("onUpdate", function(self, elapse)
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

D.CreateBtn = function(name, parent, w, h, tt_txt, txt)
	local font = D.Font(C["font"].ses)
	local b = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	b:Width(w)
	b:Height(h)
	b:SetTemplate("Default")
	b:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:AddLine(tt_txt, 1, 1, 1, 1, 1, 1)
		GameTooltip:Show()
	end)

	b:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	b.text = b:CreateFontString(nil, "OVERLAY")
	b.text:SetFontObject(font)
	b.text:SetText(D.PanelColor..txt)
	b.text:SetPoint("CENTER", b, "CENTER", 1, -1)
	b.text:SetJustifyH("CENTER")
	b:SetAttribute("type1", "macro")
end
