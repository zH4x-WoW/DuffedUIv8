local D, C, L = unpack(select(2, ...))
if (IsAddOnLoaded("BossEncounter2")) or IsAddOnLoaded("AddOnSkins") then return end

local f = CreateFrame("Frame", nil, UIParent)
local chatbubblehook = CreateFrame("Frame", nil, UIParent)
local total = 0
local numKids = 0
local noscalemult = D.mult * C["general"].uiscale
local bubbles = {}

if (D.ScreenWidth > 3840) then
	-- hide options, disable bubbles, not compatible eyefinity
	InterfaceOptionsSocialPanelChatBubbles:SetScale(0.00001)
	InterfaceOptionsSocialPanelPartyChat:SetScale(0.00001)
	SetCVar("chatBubbles", 0)
	SetCVar("chatBubblesParty", 0)
end

local function skinbubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		elseif region:GetObjectType() == "FontString" then
			frame.text = region
		end
	end

	frame:SetBackdrop({
		bgFile = C["media"].blank, edgeFile = C["media"].blank, edgeSize = D.noscalemult,
		insets = {left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
	})
	frame:SetBackdropColor(.1, .1, .1, .8)
	frame:SetBackdropBorderColor(unpack(C["media"].bordercolor))
	frame.text:SetFont(C["media"].font, 14)
	frame:SetClampedToScreen(false)
	frame:SetFrameStrata("BACKGROUND")
	
	tinsert(bubbles, frame)
end

f:SetScript("OnUpdate", function(self, elapsed)
	total = total + elapsed
	if total > 0.1 then
		total = 0
		local newNumKids = WorldFrame:GetNumChildren()
		if newNumKids ~= numKids then
			for i = numKids + 1, newNumKids do
				local frame = select(i, WorldFrame:GetChildren())
				local b = frame:GetBackdrop()
				if b and b.bgFile == [[Interface\Tooltips\ChatBubble-Background]] then
					skinbubble(frame)
				end
			end
			numKids = newNumKids
		end
		for i, f in next, bubbles do
			local r, g, b = f.text:GetTextColor()
			f:SetBackdropBorderColor(r, g, b, .8)
			
			-- bubbles is unfortunatly not compatible with eyefinity, we hide it event if they are enabled. :(
			if D.eyefinity then frame:SetScale(0.00001) end
		end
	end
end)