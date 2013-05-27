local T, C, L = select(2, ...):unpack()

if (not C.Auras.Enable) then
	return
end

local TukuiAuras = CreateFrame("Frame")
local unpack = unpack
local GetTime = GetTime
local DebuffTypeColor = DebuffTypeColor
local NumberFontNormal = NumberFontNormal
local BuffFrame = BuffFrame
local TemporaryEnchantFrame = TemporaryEnchantFrame
local ConsolidatedBuffs = ConsolidatedBuffs
local InterfaceOptionsFrameCategoriesButton12 = InterfaceOptionsFrameCategoriesButton12
local InterfaceOptionsFrameCategoriesButton12 = InterfaceOptionsFrameCategoriesButton12

TukuiAuras.Headers = {}
TukuiAuras.Filter = C.Auras.Consolidate
TukuiAuras.Flash = C.Auras.Flash
TukuiAuras.FlashTimer = 30
TukuiAuras.ClassicTimer = C.Auras.ClassicTimer
TukuiAuras.ProxyIcon = "Interface\\Icons\\misc_arrowdown"

function TukuiAuras:DisableBlizzardAuras()
	BuffFrame:Kill()
	TemporaryEnchantFrame:Kill()
	ConsolidatedBuffs:Kill()
	InterfaceOptionsFrameCategoriesButton12:SetScale(0.00001)
	InterfaceOptionsFrameCategoriesButton12:SetAlpha(0)
end

function TukuiAuras:StartOrStopFlash(timeleft)
	if(timeleft < TukuiAuras.FlashTimer) then
		if(not self:IsPlaying()) then
			self:Play()
		end
	elseif(self:IsPlaying()) then
		self:Stop()
	end
end

function TukuiAuras:OnUpdate(elapsed)
	local TimeLeft

	if(self.Enchant) then
		local Expiration = select(self.Enchant, GetWeaponEnchantInfo())
		
		if(Expiration) then
			TimeLeft = Expiration / 1e3
		else
			TimeLeft = 0
		end
	else
		TimeLeft = self.TimeLeft - elapsed		
	end
	
	self.TimeLeft = TimeLeft

	if(TimeLeft <= 0) then
		self.TimeLeft = nil
		self.Duration:SetText("")
		
		return self:SetScript("OnUpdate", nil)
	else
		local Text = T.FormatTime(TimeLeft)
		local r, g, b = T.ColorGradient(self.TimeLeft, self.Dur, 0.8, 0, 0, 0.8, 0.8, 0, 0, 0.8, 0)

		self.Bar:SetValue(self.TimeLeft)
		self.Bar:SetStatusBarColor(r, g, b)
		
		if(TimeLeft < 60.5) then
			if TukuiAuras.Flash then
				TukuiAuras.StartOrStopFlash(self.Animation, TimeLeft)
			end
			
			if(TimeLeft < 5) then
				self.Duration:SetTextColor(255/255, 20/255, 20/255)	
			else
				self.Duration:SetTextColor(255/255, 165/255, 0/255)
			end
		else
			if self.Animation and self.Animation:IsPlaying() then
				self.Animation:Stop()
			end
			
			self.Duration:SetTextColor(.9, .9, .9)
		end
		
		self.Duration:SetText(Text)
	end
end

function TukuiAuras:UpdateAura(index)
	local Name, Rank, Texture, Count, DType, Duration, ExpirationTime, Caster, IsStealable, ShouldConsolidate, SpellID, CanApplyAura, IsBossDebuff = UnitAura(self:GetParent():GetAttribute("unit"), index, self.Filter)
	
	if (Name) then
		if (not TukuiAuras.Filter) then
			ShouldConsolidate = false
		end
		
		if (ShouldConsolidate or TukuiAuras.ClassicTimer) then
			self.Holder:Hide()
		else
			self.Duration:Hide()
		end
		
		if (Duration > 0 and ExpirationTime and not ShouldConsolidate) then
			local TimeLeft = ExpirationTime - GetTime()
			if (not self.TimeLeft) then
				self.TimeLeft = TimeLeft
				self:SetScript("OnUpdate", TukuiAuras.OnUpdate)
			else
				self.TimeLeft = TimeLeft
			end
			
			self.Dur = Duration

			if TukuiAuras.Flash then
				TukuiAuras.StartOrStopFlash(self.Animation, TimeLeft)
			end
			
			self.Bar:SetMinMaxValues(0, Duration)
			
			if not TukuiAuras.ClassicTimer then
				self.Holder:Show()
			end
		else
			if TukuiAuras.Flash then
				self.Animation:Stop()
			end
			
			self.TimeLeft = nil
			self.Duration:SetText("")
			self:SetScript("OnUpdate", nil)
			
			local min, max  = self.Bar:GetMinMaxValues()
			
			self.Bar:SetValue(max)
			self.Bar:SetStatusBarColor(0, 0.8, 0)
			
			if not TukuiAuras.ClassicTimer then
				self.Holder:Hide()
			end
		end

		if(Count > 1) then
			self.Count:SetText(Count)
		else
			self.Count:SetText("")
		end

		if(self.Filter == "HARMFUL") then
			local Color = DebuffTypeColor[DType or "none"]
			self:SetBackdropBorderColor(Color.r * 3/5, Color.g * 3/5, Color.b * 3/5)
			self.Holder:SetBackdropBorderColor(Color.r * 3/5, Color.g * 3/5, Color.b * 3/5)
		end

		self.Icon:SetTexture(Texture)
	end
end

function TukuiAuras:UpdateTempEnchant(slot)
	local Enchant = (slot == 16 and 2) or 5
	local Expiration = select(Enchant, GetWeaponEnchantInfo())
	
	if (TukuiAuras.ClassicTimer) then
		self.Holder:Hide()
	else
		self.Duration:Hide()
	end
	
	if (Expiration) then
		self.Dur = 3600
		self.Enchant = Enchant
		self:SetScript("OnUpdate", TukuiAuras.OnUpdate)
	else
		self.Enchant = nil
		self.TimeLeft = nil
		self:SetScript("OnUpdate", nil)
	end
	
	self.Icon:SetTexture(GetInventoryItemTexture("player", slot))
end

function TukuiAuras:OnAttributeChanged(attribute, value)
	if (attribute == "index") then
		return TukuiAuras.UpdateAura(self, value)
	elseif(attribute == "target-slot") then
		self.Bar:SetMinMaxValues(0, 3600)
		
		return TukuiAuras.UpdateTempEnchant(self, value)
	end
end

function TukuiAuras:Skin()
	local Proxy = self.IsProxy
	
	local Icon = self:CreateTexture(nil, "BORDER")
	Icon:SetTexCoord(.07, .93, .07, .93)
	Icon:SetInside()
	
	local Count = self:CreateFontString(nil, "OVERLAY")
	Count:SetFontObject(NumberFontNormal)
	Count:SetPoint("TOP", self, 1, -4)

	if (not Proxy) then
		local Holder = CreateFrame("Frame", nil, self)
		Holder:Size(self:GetWidth(), 7)
		Holder:SetPoint("TOP", self, "BOTTOM", 0, -1)
		Holder:SetTemplate("Transparent")
		
		local Bar = CreateFrame("StatusBar", nil, Holder)
		Bar:SetInside()
		Bar:SetStatusBarTexture(C.Media.Blank)
		Bar:SetStatusBarColor(0, 0.8, 0)
		
		local Duration = self:CreateFontString(nil, "OVERLAY")
		Duration:SetFont(C.Media.Font, 12, "OUTLINE")
		Duration:SetPoint("BOTTOM", 0, -17)

		if TukuiAuras.Flash then
			local Animation = self:CreateAnimationGroup()
			Animation:SetLooping("BOUNCE")

			local FadeOut = Animation:CreateAnimation("Alpha")
			FadeOut:SetChange(-0.5)
			FadeOut:SetDuration(0.4)
			FadeOut:SetSmoothing("IN_OUT")

			self.Animation = Animation
		end

		if (not self.AuraGrowth) then
			local AuraGrowth = self:CreateAnimationGroup()
		
			local Grow = AuraGrowth:CreateAnimation("Scale")
			Grow:SetOrder(1)
			Grow:SetDuration(0.2)
			Grow:SetScale(1.25, 1.25)
			
			local Shrink = AuraGrowth:CreateAnimation("Scale")
			Shrink:SetOrder(2)
			Shrink:SetDuration(0.2)
			Shrink:SetScale(0.75, 0.75)
			
			self.AuraGrowth = AuraGrowth
			
			self:SetScript("OnShow", function(self)
				self.Count:SetParent(UIParent) -- Janky fix for font scaling issue. (It distorts and shifts position)
				self.Duration:SetParent(UIParent)
			
				if self.AuraGrowth then
					self.AuraGrowth:Play()
				end
			end)
			
			AuraGrowth:SetScript("OnFinished", function()
				self.Count:SetParent(self)
				self.Duration:SetParent(self)
			end)
		end
		
		self.Duration = Duration
		self.Bar = Bar
		self.Holder = Holder
		self.Filter = self:GetParent():GetAttribute("filter")
		
		self:SetScript("OnAttributeChanged", TukuiAuras.OnAttributeChanged)
	else
		local x = self:GetWidth()
		local y = self:GetHeight()
		
		local Overlay = self:CreateTexture(nil, "OVERLAY")
		Overlay:SetTexture(TukuiAuras.ProxyIcon)
		Overlay:SetInside()
		Overlay:SetTexCoord(unpack(T.IconCoord))
		
		self.Overlay = Overlay
	end
	
	self.Icon = Icon
	self.Count = Count
	self:SetTemplate("Default")
end

function TukuiAuras:OnEnterWorld()
	for _, Header in next, TukuiAuras.Headers do
		local Child = Header:GetAttribute("child1")
		local i = 1
		while(Child) do
			TukuiAuras.UpdateAura(Child, Child:GetID())

			i = i + 1
			Child = Header:GetAttribute("child" .. i)
		end
	end
end

function TukuiAuras:LoadVariables() -- to be completed
	local Headers = TukuiAuras.Headers
	local Buffs = Headers[1]
	local Debuffs = Headers[2]
	local Position = Buffs:GetPoint()
	
	if Position:match("LEFT") then
		Buffs:SetAttribute("xOffset", 35)
		Buffs:SetAttribute("point", Position)
		Debuffs:SetAttribute("xOffset", 35)
		Debuffs:SetAttribute("point", Position)
	end
end

TukuiAuras:RegisterEvent("PLAYER_ENTERING_WORLD")
--TukuiAuras:RegisterEvent("VARIABLES_LOADED")
TukuiAuras:RegisterEvent("ADDON_LOADED")
TukuiAuras:SetScript("OnEvent", function(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		self.OnEnterWorld()
	elseif (event == "VARIABLES_LOADED") then
		
	else
		local addon = ...

		if (addon ~= "Tukui") then
			return
		end
		
		self.DisableBlizzardAuras()
		self.CreateHeaders()
	end
end)

T["Auras"] = TukuiAuras