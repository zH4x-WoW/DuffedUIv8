local T, C = select(2, ...):unpack()

local pairs = pairs
local unpack = unpack
local CreateFrame = CreateFrame
local DuffedUIDT = CreateFrame("Frame")
local Panels = D["Panels"]
local DataTextLeft = Panels.DataTextLeft
local DataTextRight = Panels.DataTextRight

local MinimapDataTextOne
local MinimapDataTextTwo

DuffedUIDD.DefaultNumAnchors = 6
DuffedUIDD.NumAnchors = DuffedUIDD.DefaultNumAnchors
DuffedUIDD.Font = C.Medias.Font
DuffedUIDD.Size = 12
DuffedUIDD.Flags = nil
DuffedUIDD.Texts = {}
DuffedUIDD.Anchors = {}
DuffedUIDD.Menu = {}
DuffedUIDD.NameColor = D.RGBToHex(unpack(C.Medias.PrimaryDataTextColor))
DuffedUIDD.ValueColor = D.RGBToHex(unpack(C.Medias.SecondaryDataTextColor))

function DuffedUIDT:AddToMenu(name, data)
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
	
	if self.Data.Position > DuffedUIDD.DefaultNumAnchors then
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

function DuffedUIDT:CreateAnchors()
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
	local Y = D.Scale(5)
		
	if (Position >= 1 and Position <= 3) then
		Anchor = "ANCHOR_TOPLEFT"
		From = DataTextLeft
	elseif (Position >=4 and Position <= 6) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DataTextRight
	elseif (Position == 7 and MinimapDataTextOne) or (Position == 8 and MinimapDataTextTwo) then
		Anchor = "ANCHOR_BOTTOMLEFT"
		Y = D.Scale(-5)
		
		if (Position == 7) then
			From = MinimapDataTextOne
		elseif (Position == 8) then
			From = MinimapDataTextTwo
		end
	end
	
	return From, Anchor, X, Y
end

function DuffedUIDT:GetDataText(name)
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

function DuffedUIDT:Register(name, enable, disable, update)
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

function DuffedUIDT:ForceUpdate()
	for _, data in pairs(self.Texts) do
		if data.Enabled then
			data:Update(1)
		end
	end
end

function DuffedUIDT:ResetGold()
	local Realm = GetRealmName()
	local Name = UnitName("player")

	DuffedUIData.Gold = {}
	DuffedUIData.Gold[Realm] = {}
	DuffedUIData.Gold[Realm][Name] = GetMoney()
end

function DuffedUIDT:Save()
	if (not DuffedUIDataPerChar) then
		DuffedUIDataPerChar = {}
	end
	
	local Data = DuffedUIDataPerChar
	
	if (not Data.Texts) then
		Data.Texts = {}
	end

	for name, data in pairs(self.Texts) do
		if data.Position then
			Data.Texts[name] = {data.Enabled, data.Position}
		end
	end
end

function DuffedUIDT:Reset()
	for _, data in pairs(self.Texts) do
		if data.Enabled then
			data:Disable()
		end
	end
	
	if (DuffedUIDataPerChar and DuffedUIDataPerChar.Texts) then
		DuffedUIDataPerChar.Texts = {}
	end
end

function DuffedUIDT:Load()
	self:CreateAnchors()
	
	if (not DuffedUIDataPerChar) then
		DuffedUIDataPerChar = {}
	end

	if (not DuffedUIDataPerChar.Texts) then
		-- defaults, Err, Gonna have to localize these.
		DuffedUIDataPerChar.Texts = {}
		DuffedUIDataPerChar.Texts["Guild"] = {true, 1}
		DuffedUIDataPerChar.Texts["Durability"] = {true, 2}
		DuffedUIDataPerChar.Texts["Friends"] = {true, 3}
		DuffedUIDataPerChar.Texts["FPS & MS"] = {true, 4}
		DuffedUIDataPerChar.Texts["Memory"] = {true, 5}
		DuffedUIDataPerChar.Texts["Gold"] = {true, 6}
		DuffedUIDataPerChar.Texts["Power"] = {true, 7}
		DuffedUIDataPerChar.Texts["Time"] = {true, 8}
	end

	if (DuffedUIDataPerChar and DuffedUIDataPerChar.Texts) then
		for name, info in pairs(DuffedUIDataPerChar.Texts) do
			local Enabled, Num = unpack(info)

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(name)
				
				if Object then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					D.Print("DataText '" .. name .. "' not found. Removing from cache.")
					DuffedUIDataPerChar.Texts[name] = {false, 0}
				end
			end
		end
	end
end

DuffedUIDT:RegisterEvent("ADDON_LOADED")
DuffedUIDT:RegisterEvent("PLAYER_LOGOUT")
DuffedUIDT:SetScript("OnEvent", function(self, event, addon)
	if (addon and addon == "DuffedUI") then
		self:UnregisterEvent(event)
		self:Load()
	else
		self:Save()
	end
end)

D["DataTexts"] = DuffedUIDT