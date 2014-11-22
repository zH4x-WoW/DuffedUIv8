local D, C, L = unpack(select(2, ...)) 

if not C["datatext"].battleground then return end

--Map IDs
local WSG = 443
local TP = 626
local AV = 401
local SOTA = 512
local IOC = 540
local EOTS = 482
local TBFG = 736
local AB = 461
local TOK = 856
local SSM = 860
local ASH = 978

local bgframe = DuffedUIInfoLeftBattleGround
bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
	for i = 1, numScores do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
		if ( name ) then
			if ( name == UnitName("player") ) then
				local curmapid = GetCurrentMapAreaID()
				local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
				local classcolor = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
				SetMapToCurrentZone()
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, D.Scale(4))
				GameTooltip:ClearLines()
				GameTooltip:Point("BOTTOM", self, "TOP", 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(L["dt"]["stats"], classcolor .. name .. "|r")
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(KILLING_BLOWS .. ":", killingBlows, 1, 1, 1)
				GameTooltip:AddDoubleLine(HONORABLE_KILLS .. ":", honorableKills, 1, 1, 1)
				GameTooltip:AddDoubleLine(DEATHS .. ":", deaths,1,1,1)
				GameTooltip:AddDoubleLine(HONOR_GAINED .. ":", format('%d', honorGained), 1, 1, 1)
				GameTooltip:AddDoubleLine(L["dt"]["dmgdone"], damageDone, 1, 1, 1)
				GameTooltip:AddDoubleLine(L["dt"]["healdone"], healingDone, 1, 1, 1)
				--Add extra statistics to watch based on what BG you are in.
				if curmapid == WSG or curmapid == TP then 
					GameTooltip:AddDoubleLine(L["dt"]["flagscaptured"],GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["flagsreturned"],GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif curmapid == EOTS then
					GameTooltip:AddDoubleLine(L["dt"]["flagscaptured"],GetBattlefieldStatData(i, 1), 1, 1, 1)
				elseif curmapid == AV then
					GameTooltip:AddDoubleLine(L["dt"]["graveyardsassaulted"],GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["graveyardsdefended"],GetBattlefieldStatData(i, 2), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["towerassaulted"],GetBattlefieldStatData(i, 3), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["towerdefended"],GetBattlefieldStatData(i, 4), 1, 1, 1)
				elseif curmapid == SOTA then
					GameTooltip:AddDoubleLine(L["dt"]["demolishersdestroyed"],GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["gatesdestroyed"],GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif curmapid == IOC or curmapid == TBFG or curmapid == AB or curmapid == ASH then
					GameTooltip:AddDoubleLine(L["dt"]["basesassaulted"],GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["basesdefended"],GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif CurrentMapID == TOK then
					GameTooltip:AddDoubleLine(L["dt"]["orb_possessions"], GetBattlefieldStatData(i, 1), 1, 1, 1)
					GameTooltip:AddDoubleLine(L["dt"]["victory_points"], GetBattlefieldStatData(i, 2), 1, 1, 1)
				elseif CurrentMapID == SSM then
					GameTooltip:AddDoubleLine(L["dt"]["carts_controlled"], GetBattlefieldStatData(i, 1), 1, 1, 1)
				end
				GameTooltip:Show()
			end
		end
	end
end) 
bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

local font = D.Font(C["font"].datatext)
local Stat = CreateFrame("Frame", "DuffedUIStatBattleGround", UIParent)
Stat:EnableMouse(true)
Stat.Option = C["datatext"].battleground
Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))

local Text1  = DuffedUIInfoLeftBattleGround:CreateFontString("DuffedUIStatBattleGroundText1", "OVERLAY")
Text1:SetFontObject(font)
Text1:SetPoint("LEFT", 30, .5)
Text1:SetHeight(DuffedUIInfoLeft:GetHeight())

local Text2  = DuffedUIInfoLeftBattleGround:CreateFontString("DuffedUIStatBattleGroundText2", "OVERLAY")
Text2:SetFontObject(font)
Text2:SetPoint("CENTER", 0, .5)
Text2:SetHeight(DuffedUIInfoLeft:GetHeight())

local Text3  = DuffedUIInfoLeftBattleGround:CreateFontString("DuffedUIStatBattleGroundText3", "OVERLAY")
Text3:SetFontObject(font)
Text3:SetPoint("RIGHT", -30, .5)
Text3:SetHeight(DuffedUIInfoLeft:GetHeight())

local int = 2
local function Update(self, t)
	int = int - t
	if int < 0 then
		local dmgtxt
		RequestBattlefieldScoreData()
		local numScores = GetNumBattlefieldScores()
		for i = 1, numScores do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if healingDone > damageDone then
				dmgtxt = (Stat.Color1 .. SHOW_COMBAT_HEALING .. ": " .. "|r" .. Stat.Color2 .. healingDone .. "|r")
			else
				dmgtxt = (Stat.Color1 .. DAMAGE .. ": " .. "|r" .. Stat.Color2 .. damageDone .. "|r")
			end
			if name then
				if name == D.MyName then
					Text2:SetText(Stat.Color1..HONOR..": ".."|r"..Stat.Color2..format('%d', honorGained).."|r")
					Text1:SetText(dmgtxt)
					Text3:SetText(Stat.Color1..KILLING_BLOWS..": ".."|r"..Stat.Color2..killingBlows.."|r")
				end   
			end
		end 
		int  = 2
	end
end

--hide text when not in an bg
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "pvp") then
			bgframe:Show()
		else
			Text1:SetText("")
			Text2:SetText("")
			Text3:SetText("")
			bgframe:Hide()
		end
	end
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:SetScript("OnEvent", OnEvent)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 2)