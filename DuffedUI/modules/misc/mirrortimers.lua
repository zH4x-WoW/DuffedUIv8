local D, C, L = select(2, ...):unpack()

local Panels = D["Panels"]
local Total = MIRRORTIMER_NUMTIMERS

local MirrorTimers = CreateFrame("Frame")

function MirrorTimers:Update()
	for i = 1, Total, 1 do
		local Bar = _G["MirrorTimer"..i]
		if not Bar.isSkinned then
			Bar:SetTemplate()

			local Status = _G[Bar:GetName().."StatusBar"]
			local Border = _G[Bar:GetName().."Border"]
			local Text = _G[Bar:GetName().."Text"]

			Status:ClearAllPoints()
			Status:Point("TOPLEFT", Bar, 2, -2)
			Status:Point("BOTTOMRIGHT", Bar, -2, 2)
			Status:SetStatusBarTexture(C["medias"].Normal)

			Text:ClearAllPoints()
			Text:SetPoint("CENTER", Bar)

			Border:SetTexture(nil)

			Bar.isSkinned = true
		end
	end
end

function MirrorTimers:Create() hooksecurefunc("MirrorTimer_Show", MirrorTimers.Update) end

Panels.MirrorTimers = MirrorTimers