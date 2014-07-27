local D, C, L = select(2, ...):unpack()

if (not C["auras"].Enable) then return end

local DuffedUIAuras = D["Auras"]
local DuffedUIPanels = D["Panels"]
local Headers = DuffedUIAuras.Headers
local Parent = DuffedUIPanels.PetBattleHider
local Insert = table.insert
local SecureHandlerSetFrameRef = SecureHandlerSetFrameRef

DuffedUIAuras.Wraps = 18

function DuffedUIAuras:CreateHeaders()
	for i = 1, 3 do
		local Header
		
		if (i == 3) then
			Header = CreateFrame("Frame", nil, Parent, "SecureFrameTemplate")
			Header:SetAttribute("wrapAfter", 1)
			Header:SetAttribute("wrapYOffset", -35)
		else
			Header = CreateFrame("Frame", nil, Parent, "SecureAuraHeaderTemplate")
			Header:SetClampedToScreen(true)
			Header:SetMovable(true)
			Header:SetAttribute("minHeight", 30)
			Header:SetAttribute("wrapAfter", DuffedUIAuras.Wraps)
			Header:SetAttribute("wrapYOffset", -55)
			Header:SetAttribute("xOffset", -35)
			Header:CreateBackdrop()
			Header.Backdrop:SetBackdropBorderColor(1, 0, 0)
			Header.Backdrop:Hide()
		end
		
		Header:SetAttribute("minWidth", DuffedUIAuras.Wraps * 35)
		Header:SetAttribute("template", "DuffedUIAurasTemplate")
		Header:SetAttribute("weaponTemplate", "DuffedUIAurasTemplate")
		Header:SetSize(30, 30)

		RegisterAttributeDriver(Header, "unit", "[vehicleui] vehicle; player")

		Insert(Headers, Header)
	end
	
	local Buffs = Headers[1]
	local Debuffs = Headers[2]
	local Consolidate = Headers[3]
	local Filter = (C["auras"].Consolidate and 1) or 0
	local Proxy = CreateFrame("Frame", nil, Buffs, "DuffedUIAurasProxyTemplate")
	local DropDown = CreateFrame("BUTTON", nil, Proxy, "SecureHandlerClickTemplate")
	
	Buffs:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -17, 2)
	Buffs:SetAttribute("filter", "HELPFUL")
	Buffs:SetAttribute("consolidateProxy", Proxy)
	Buffs:SetAttribute("consolidateHeader", Consolidate)
	Buffs:SetAttribute("consolidateTo", Filter)
	Buffs:SetAttribute("includeWeapons", 1)
	Buffs:SetAttribute("consolidateDuration", -1)
	Buffs:Show()
	
	Proxy = Buffs:GetAttribute("consolidateProxy")
	Proxy:HookScript("OnShow", function(self)
		if Consolidate:IsShown() then
			Consolidate:Hide()
		end
	end)

	DropDown:SetAllPoints()
	DropDown:RegisterForClicks("AnyUp")
	DropDown:SetAttribute("_onclick", [=[
		local Header = self:GetParent():GetFrameRef("header")
		local NumChild = 0
		
		repeat
			NumChild = NumChild + 1
			local child = Header:GetFrameRef("child" .. NumChild)
			until not child or not child:IsShown()

		NumChild = NumChild - 1

		local x, y = self:GetWidth(), self:GetHeight()
		Header:SetWidth(x)
		Header:SetHeight(y)
		
		if Header:IsShown() then
			Header:Hide()
		else
			Header:Show()
		end
	]=])	
	
	Consolidate:SetAttribute("point", "RIGHT")
	Consolidate:SetAttribute("minHeight", nil)
	Consolidate:SetAttribute("minWidth", nil)
	Consolidate:SetParent(Proxy)
	Consolidate:ClearAllPoints()
	Consolidate:SetPoint("CENTER", Proxy, "CENTER", 0, -35)
	Consolidate:Hide()
	SecureHandlerSetFrameRef(Proxy, "header", Consolidate)
	
	Debuffs:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -17, -15)
	Debuffs:SetAttribute("filter", "HARMFUL")
	Debuffs:Show()
	
	Buffs.Proxy = Proxy
	Buffs.DropDown = DropDown
end