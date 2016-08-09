local D, C, L = unpack(select(2, ...))
if C["misc"].sesenable ~= true then return end

local hoverovercolor = {.4, .4, .4}
local cp = "|cff319f1b"
local cm = "|cff9a1212"
local dr, dg, db = unpack({ .4, .4, .4 })
local f, fs, ff = C["media"].font, 11, "THINOUTLINE"

local Enablegear = C["misc"].sesenablegear
local Autogearswap = C["misc"].sesgearswap
local set1 = C["misc"].sesset1
local set2 = C["misc"].sesset2
local set3 = C["misc"].sesset3
local set4 = C["misc"].sesset4

local function ActiveTalents()
	local Tree = GetSpecialization(false, false, GetActiveSpecGroup())
	return Tree
end	

local LeftClickMenu = { }
LeftClickMenu[1] = { text = L["dt"]["specmenu"], isTitle = true, notCheckable = true}

--Setting up the menu for later for each spec regardless of class, thanks to Simca for helping out with the function.
local DuffedUISpecSwap = CreateFrame("Frame", "DuffedUISpecSwap", UIParent, "UIDropDownMenuTemplate")
DuffedUISpecSwap:SetTemplate("Transparent")
DuffedUISpecSwap:RegisterEvent("PLAYER_LOGIN")
DuffedUISpecSwap:SetScript("OnEvent", function(...)
	local specIndex
	for specIndex = 1, GetNumSpecializations() do
		LeftClickMenu[specIndex + 1] = {
			text = tostring(select(2, GetSpecializationInfo(specIndex))),
			notCheckable = true,
			func = (function()
				local getSpec = GetSpecialization()
				if getSpec and getSpec == specIndex then
					UIErrorsFrame:AddMessage(L["dt"]["specerror"], 1.0, 0.0, 0.0, 53, 5);
					return
				end
				SetSpecialization(specIndex)
			end)
		}
	end
end)

local function AutoGear(set1, set2, set3, set4)
	local name1 = GetEquipmentSetInfo(set1)
	local name2 = GetEquipmentSetInfo(set2)
	local name3 = GetEquipmentSetInfo(set3)
	local name4 = GetEquipmentSetInfo(set4)

	if GetSpecialization() == 1 then
		if name1 then UseEquipmentSet(name1) end
	elseif GetSpecialization() == 2 then
		if name2 then UseEquipmentSet(name2) end
	elseif GetSpecialization() == 3 then
		if name3 then UseEquipmentSet(name3) end
	else
		if name4 then UseEquipmentSet(name4) end
	end
end

local spec = CreateFrame("Button", "DuffedUI_Spechelper", DuffedUIInfoLeft)
spec:SetTemplate("Default")
if C["chat"].rbackground then
	spec:SetPoint("LEFT", DuffedUITabsRightBackground, "RIGHT", 2, 0)
	spec:Size(DuffedUIMinimap:GetWidth() + 3, 20)
else
	spec:SetPoint("TOPLEFT", DuffedUIMinimapStatsLeft, "BOTTOMLEFT", 0, -2)
	spec:Size(DuffedUIMinimap:GetWidth() - 22, 20)
	spec:SetParent(oUF_PetBattleFrameHider)
end
spec.t = spec:CreateFontString(spec, "OVERLAY")
spec.t:SetPoint("CENTER")
spec.t:SetFont(f, fs, ff)

local int = 1
local function Update(self, t)
	int = int - t
	if int > 0 then return end
	if not GetSpecialization() then spec.t:SetText(L["dt"]["talents"]) return end

	local Tree = ActiveTalents()
	local name = select(2, GetSpecializationInfo(Tree))

	spec.t:SetText(name)

	int = 1
	self:SetScript("OnUpdate", nil)
end

local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then self:UnregisterEvent("PLAYER_ENTERING_WORLD") else self:SetScript("OnUpdate", Update) end
end

spec:RegisterEvent("PLAYER_TALENT_UPDATE")
spec:RegisterEvent("PLAYER_ENTERING_WORLD")
spec:RegisterEvent("CHARACTER_POINTS_CHANGED")
spec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
spec:SetScript("OnEvent", OnEvent) 

spec:SetScript("OnClick", function(self) 
	local i = GetActiveSpecGroup()
	if IsModifierKeyDown() then ToggleTalentFrame() else Lib_EasyMenu(LeftClickMenu, DuffedUISpecSwap, "cursor", 0, 0, "MENU", 2) end
end)

D.CreateBtn("MB_reload", DuffedUIMinimap, 19, 19, L["buttons"]["ses_reload"], "R")
MB_reload:Point("TOPLEFT", spec, "BOTTOMLEFT", 0, -2)
MB_reload:SetAttribute("macrotext1", "/rl")
MB_reload:Hide()

D.CreateBtn("MB_mui", MB_reload, 19, 19, L["buttons"]["ses_move"], "M")
MB_mui:Point("LEFT", MB_reload, "RIGHT", 2, 0)
MB_mui:SetAttribute("macrotext1", "/moveui")

D.CreateBtn("MB_binds", MB_reload, 19, 19, L["buttons"]["ses_kb"], "K")
MB_binds:Point("LEFT", MB_mui, "RIGHT", 2, 0)
MB_binds:SetAttribute("macrotext1", "/kb")

D.CreateBtn("MB_switch", MB_reload, 19, 19, L["buttons"]["ses_switch"], "S")
MB_switch:Point("LEFT", MB_binds, "RIGHT", 2, 0)
MB_switch:SetAttribute("macrotext1", "/switch")

if Enablegear == true then
	local gearSets = CreateFrame("Frame", nil, MB_reload)
	for i = 1, 10 do
		gearSets[i] = CreateFrame("Button", nil, MB_reload)
		gearSets[i]:Size(19, 19)
		gearSets[i]:SetPoint("CENTER", MB_reload, "CENTER", 0, 0)
		gearSets[i]:SetTemplate("Default")

		if i == 1 then gearSets[i]:Point("TOPRIGHT", MB_reload, "BOTTOMRIGHT", 0, -2) else gearSets[i]:SetPoint("BOTTOMLEFT", gearSets[i-1], "BOTTOMRIGHT", 2, 0) end
		gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
		gearSets[i].texture:SetTexCoord(.08, .92, .08, .92)
		gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
		gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
		gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))
		gearSets[i]:Hide()

		gearSets[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
		gearSets[i]:RegisterEvent("EQUIPMENT_SETS_CHANGED")
		gearSets[i]:SetScript("OnEvent", function(self, event)
			local points, pt = 0, GetNumEquipmentSets()
			local frames = {gearSets[1]:IsShown(), gearSets[2]:IsShown(), gearSets[3]:IsShown(), gearSets[4]:IsShown(), 
							gearSets[5]:IsShown(), gearSets[6]:IsShown(), gearSets[7]:IsShown(), gearSets[8]:IsShown(),
							gearSets[9]:IsShown(), gearSets[10]:IsShown()}
			if pt > points then 
				for i = points + 1, pt do gearSets[i]:Show() end 
			end
			if frames[pt + 1] == 1 then gearSets[pt + 1]:Hide() end

			gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
			gearSets[i].texture:SetTexCoord(.08, .92, .08, .92)
			gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
			gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
			gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))

			gearSets[i]:SetScript("OnClick", function(self) UseEquipmentSet(GetEquipmentSetInfo(i)) end)
			gearSets[i]:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
			gearSets[i]:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C["media"].bordercolor)) end)

			if Autogearswap == true then
				gearSets[1]:SetBackdropBorderColor(0, 1, 0)
				gearSets[2]:SetBackdropBorderColor(1, 0, 0)
				gearSets[1]:SetScript("OnEnter", nil)
				gearSets[1]:SetScript("OnLeave", nil)
				gearSets[2]:SetScript("OnEnter", nil)
				gearSets[2]:SetScript("OnLeave", nil)
			end
		end)
	end	

	if Autogearswap == true then
		gearsetfunc = CreateFrame("Frame", "gearSetfunc", UIParent)
		local function OnEvent(self, event)
			if event == "PLAYER_ENTERING_WORLD" then self:UnregisterEvent("PLAYER_ENTERING_WORLD") else AutoGear(set1, set2, set3, set4)  end
		end
		gearsetfunc:RegisterEvent("PLAYER_ENTERING_WORLD")
		gearsetfunc:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		gearsetfunc:SetScript("OnEvent", OnEvent)
	end
end

-- toggle button
local toggle = CreateFrame("Button", nil, spec)
toggle:SetTemplate("Default")
toggle:Size(20, 20)
toggle:Point("LEFT", spec, "RIGHT", 2, 0)
toggle:EnableMouse(true)
toggle:RegisterForClicks("AnyUp")
toggle.t = toggle:CreateFontString(nil, "OVERLAY")
toggle.t:SetPoint("CENTER", 0, 0)
toggle.t:SetFont(f, fs, ff)
toggle.t:SetText(cp .. "+|r")
toggle:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
toggle:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C["media"].bordercolor)) end)

toggle:SetScript("OnMouseDown", function(self)
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end

	if MB_reload:IsShown() then	
		MB_reload:Hide()
		toggle.t:SetText(cp .. "+|r")
	else
		MB_reload:Show()
		toggle.t:SetText(cm .. "-|r")
	end
end)