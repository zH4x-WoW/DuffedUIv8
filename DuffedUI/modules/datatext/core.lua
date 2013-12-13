local T, C = select(2, ...):unpack()

local pairs = pairs
local unpack = unpack
local CreateFrame = CreateFrame
local TukuiDT = CreateFrame("Frame")
local Panels = T["Panels"]
local DataTextLeft = Panels.DataTextLeft
local DataTextRight = Panels.DataTextRight

local MinimapDataTextOne
local MinimapDataTextTwo

TukuiDT.DefaultNumAnchors = 6
TukuiDT.NumAnchors = TukuiDT.DefaultNumAnchors
TukuiDT.Font = C.Medias.Font
TukuiDT.Size = 12
TukuiDT.Flags = nil
TukuiDT.Texts = {}
TukuiDT.Anchors = {}
TukuiDT.Menu = {}
TukuiDT.NameColor = T.RGBToHex(unpack(C.Medias.PrimaryDataTextColor))
TukuiDT.ValueColor = T.RGBToHex(unpack(C.Medias.SecondaryDataTextColor))

function TukuiDT:AddToMenu(name, data)
	if self["Texts"][name] then
		return
	end
	
	self["Texts"][name] = data
	tinsert(self.Menu, {text = name, notCheckable = true, func = self.Toggle, arg1 = data})
end

local SetData = function(self, object)
	-- Disable the old data text in use
	if self.Data then
		self.Data:Disable()
	end
	
	-- Set the new data text
	self.Data = object
	self.Data:Enable()
	self.Data.Text:Point("RIGHT", self, 0, 0)
	self.Data.Text:Point("LEFT", self, 0, 0)
	self.Data.Text:Point("TOP", self, 0, -1)
	self.Data.Text:Point("BOTTOM", self, 0, -1)
	self.Data.Position = self.Num
	self.Data:SetAllPoints(self.Data.Text)
	
	if self.Data.Position > TukuiDT.DefaultNumAnchors then
		self.Data:SetParent(Panels.PetBattleHider)
	end
end

local RemoveData = function(self)
	if self.Data then
		self.Data.Position = 0
		self.Data:Disable()
	end
	
	self.Data = nil
end

function TukuiDT:CreateAnchors()
	MinimapDataTextOne = Panels.MinimapDataTextOne
	MinimapDataTextTwo = Panels.MinimapDataTextTwo

	if (MinimapDataTextOne and MinimapDataTextTwo) then
		self.NumAnchors = self.NumAnchors + 2
	end

	for i = 1, self.NumAnchors do
		local Frame = CreateFrame("Button", nil, UIParent)
		Frame:Size((DataTextLeft:GetWidth() / 3) - 1, DataTextLeft:GetHeight() - 2)
		Frame:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
		Frame:SetFrameStrata("HIGH")
		Frame:EnableMouse(false)
		Frame.SetData = SetData
		Frame.RemoveData = RemoveData
		Frame.Num = i

		Frame.Tex = Frame:CreateTexture()
		Frame.Tex:SetAllPoints()
		Frame.Tex:SetTexture(0.2, 1, 0.2, 0)
		
		self.Anchors[i] = Frame

		if (i == 1) then
			Frame:Point("LEFT", DataTextLeft, 1, 1)
		elseif (i == 4) then
			Frame:Point("LEFT", DataTextRight, 1, 1)
		elseif (i == 7) then
			Frame:Point("CENTER", MinimapDataTextOne, 0, 0)
			Frame:Size(MinimapDataTextOne:GetWidth() - 2, MinimapDataTextOne:GetHeight() - 2)
		elseif (i == 8) then
			Frame:Point("CENTER", MinimapDataTextTwo, 0, 0)
			Frame:Size(MinimapDataTextTwo:GetWidth() - 2, MinimapDataTextTwo:GetHeight() - 2)
		else
			Frame:Point("LEFT", self.Anchors[i-1], "RIGHT", 1, 0)
		end
	end
end

local GetTooltipAnchor = function(self)
	local Position = self.Position
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = T.Scale(5)
		
	if (Position >= 1 and Position <= 3) then
		Anchor = "ANCHOR_TOPLEFT"
		From = DataTextLeft
	elseif (Position >=4 and Position <= 6) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DataTextRight
	elseif (Position == 7 and MinimapDataTextOne) or (Position == 8 and MinimapDataTextTwo) then
		Anchor = "ANCHOR_BOTTOMLEFT"
		Y = T.Scale(-5)
		
		if (Position == 7) then
			From = MinimapDataTextOne
		elseif (Position == 8) then
			From = MinimapDataTextTwo
		end
	end
	
	return From, Anchor, X, Y
end

function TukuiDT:GetDataText(name)
	return self["Texts"][name]
end

local OnEnable = function(self)
	self:Show()
	self.Enabled = true
end

local OnDisable = function(self)
	self:Hide()
	self.Enabled = false
end

function TukuiDT:Register(name, enable, disable, update)
	local Data = CreateFrame("Frame", nil, UIParent)
	Data:EnableMouse(true)
	Data:SetFrameStrata("MEDIUM")
	Data.Enabled = false
	Data.GetTooltipAnchor = GetTooltipAnchor
	Data.Enable = enable
	Data.Disable = disable
	Data.Update = update
	
	hooksecurefunc(Data, "Enable", OnEnable)
	hooksecurefunc(Data, "Disable", OnDisable)

	self:AddToMenu(name, Data)
end

function TukuiDT:ForceUpdate()
	for _, data in pairs(self.Texts) do
		if data.Enabled then
			data:Update(1)
		end
	end
end

function TukuiDT:ResetGold()
	local Realm = GetRealmName()
	local Name = UnitName("player")

	TukuiData.Gold = {}
	TukuiData.Gold[Realm] = {}
	TukuiData.Gold[Realm][Name] = GetMoney()
end

function TukuiDT:Save()
	if (not TukuiDataPerChar) then
		TukuiDataPerChar = {}
	end
	
	local Data = TukuiDataPerChar
	
	if (not Data.Texts) then
		Data.Texts = {}
	end

	for name, data in pairs(self.Texts) do
		if data.Position then
			Data.Texts[name] = {data.Enabled, data.Position}
		end
	end
	
	Data.DTNameColor = TukuiDT.NameColor
	Data.DTValueColor = TukuiDT.ValueColor
end

function TukuiDT:Reset()
	for _, data in pairs(self.Texts) do
		if data.Enabled then
			data:Disable()
		end
	end
	
	if (TukuiDataPerChar and TukuiDataPerChar.Texts) then
		TukuiDataPerChar.Texts = {}
	end
end

function TukuiDT:Load()
	self:CreateAnchors()
	
	if (not TukuiDataPerChar) then
		TukuiDataPerChar = {}
	end

	if (not TukuiDataPerChar.Texts) then
		-- defaults, Err, Gonna have to localize these.
		TukuiDataPerChar.Texts = {}
		TukuiDataPerChar.Texts["Guild"] = {true, 1}
		TukuiDataPerChar.Texts["Durability"] = {true, 2}
		TukuiDataPerChar.Texts["Friends"] = {true, 3}
		TukuiDataPerChar.Texts["FPS & MS"] = {true, 4}
		TukuiDataPerChar.Texts["Memory"] = {true, 5}
		TukuiDataPerChar.Texts["Gold"] = {true, 6}
		TukuiDataPerChar.Texts["Power"] = {true, 7}
		TukuiDataPerChar.Texts["Time"] = {true, 8}
	end

	if (TukuiDataPerChar and TukuiDataPerChar.Texts) then
		for name, info in pairs(TukuiDataPerChar.Texts) do
			local Enabled, Num = unpack(info)

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(name)
				
				if Object then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					T.Print("DataText '" .. name .. "' not found. Removing from cache.")
					TukuiDataPerChar.Texts[name] = {false, 0}
				end
			end
		end
	end
end

TukuiDT:RegisterEvent("ADDON_LOADED")
TukuiDT:RegisterEvent("PLAYER_LOGOUT")
TukuiDT:SetScript("OnEvent", function(self, event, addon)
	if (addon and addon == "Tukui") then
		self:UnregisterEvent(event)
		self:Load()
	else
		self:Save()
	end
end)

T["DataTexts"] = TukuiDT