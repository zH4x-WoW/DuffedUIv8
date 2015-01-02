local D, C, L = unpack(select(2, ...))

if not C["auras"].player then return end

local frame = DuffedUIAuras
local content = DuffedUIAuras.content
local move = D["move"]

for _, frame in next, {
	"DuffedUIAurasPlayerBuffs",
	"DuffedUIAurasPlayerDebuffs",
	"DuffedUIAurasPlayerConsolidate",
} do
	local header
	local wrap
	wrap = C["auras"].wrap

	if frame == "DuffedUIAurasPlayerConsolidate" then
		header = CreateFrame("Frame", frame, DuffedUIPetBattleHider, "SecureFrameTemplate")
		header:SetAttribute("wrapAfter", 1)
		header:SetAttribute("wrapYOffset", -35)
	else
		header = CreateFrame("Frame", frame, DuffedUIPetBattleHider, "SecureAuraHeaderTemplate")
		header:SetClampedToScreen(true)
		header:SetMovable(true)
		header:SetAttribute("minHeight", 30)
		header:SetAttribute("wrapAfter", wrap)
		header:SetAttribute("wrapYOffset", -50)
		header:SetAttribute("xOffset", -35)
		header:CreateBackdrop()
		header.backdrop:SetBackdropBorderColor(1, 0, 0)
		header.backdrop:FontString("text", C["media"].font, 11)
		header.backdrop.text:SetPoint("CENTER")
		header.backdrop.text:SetText(L["move"]["buffs"])
		header.backdrop:SetAlpha(0)
	end
	header:SetAttribute("minWidth", wrap * 35)
	header:SetAttribute("template", "DuffedUIAurasAuraTemplate")
	header:SetAttribute("weaponTemplate", "DuffedUIAurasAuraTemplate")
	header:SetSize(30, 30)

	RegisterAttributeDriver(header, "unit", "[vehicleui] vehicle; player")
	table.insert(content, header)
end

local buffs = DuffedUIAurasPlayerBuffs
local debuffs = DuffedUIAurasPlayerDebuffs
local consolidate = DuffedUIAurasPlayerConsolidate

local filter = 0
if C["auras"].consolidate then filter = 1 end

buffs:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -7, 2)
buffs:SetAttribute("filter", "HELPFUL")
buffs:SetAttribute("consolidateProxy", CreateFrame("Frame", buffs:GetName() .. "ProxyButton", buffs, "DuffedUIAurasProxyTemplate"))
buffs:SetAttribute("consolidateHeader", consolidate)
buffs:SetAttribute("consolidateTo", filter)
buffs:SetAttribute("includeWeapons", 1)
buffs:SetAttribute("consolidateDuration", -1)
buffs:Show()
move:RegisterFrame(buffs)

local proxy = buffs:GetAttribute("consolidateProxy")
proxy:HookScript("OnShow", function(self) if consolidate:IsShown() then consolidate:Hide() end end)

local dropdown = CreateFrame("BUTTON", "DuffedUIAurasPlayerConsolidateDropdownButton", proxy, "SecureHandlerClickTemplate")
dropdown:SetAllPoints()
dropdown:RegisterForClicks("AnyUp")
dropdown:SetAttribute("_onclick", [=[
	local header = self:GetParent():GetFrameRef"header"

	local numChild = 0
	repeat
		numChild = numChild + 1
		local child = header:GetFrameRef("child" .. numChild)
	until not child or not child:IsShown()

	numChild = numChild - 1

	local x, y = self:GetWidth(), self:GetHeight()
	header:SetWidth(x)
	header:SetHeight(y)
	
	if header:IsShown() then header:Hide() else header:Show() end
]=]);

consolidate:SetAttribute("point", "RIGHT")
consolidate:SetAttribute("minHeight", nil)
consolidate:SetAttribute("minWidth", nil)
consolidate:SetParent(proxy)
consolidate:ClearAllPoints()
consolidate:SetPoint("CENTER", proxy, "CENTER", 0, -35)
consolidate:Hide()
SecureHandlerSetFrameRef(proxy, "header", consolidate)

debuffs:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -7, -5)
debuffs:SetAttribute("filter", "HARMFUL")
debuffs:Show()
move:RegisterFrame(debuffs)