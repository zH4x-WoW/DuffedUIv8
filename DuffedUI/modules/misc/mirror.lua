local D, C, L = unpack(select(2, ...)) 
local total = MIRRORTIMER_NUMTIMERS

local function Skin(timer, value, maxvalue, scale, paused, label)
	for i = 1, total, 1 do
		local frame = _G["MirrorTimer"..i]
		if not frame.isSkinned then
			frame:SetTemplate("Default")

			local statusbar = _G[frame:GetName().."StatusBar"]
			local border = _G[frame:GetName().."Border"]
			local text = _G[frame:GetName().."Text"]

			statusbar:ClearAllPoints()
			statusbar:Point("TOPLEFT", frame, 2, -2)
			statusbar:Point("BOTTOMRIGHT", frame, -2, 2)
			text:ClearAllPoints()
			text:SetPoint("CENTER", frame)
			statusbar:SetStatusBarTexture(C.media.normTex)
			border:SetTexture(nil)
			frame.isSkinned = true
		end
	end
end

hooksecurefunc("MirrorTimer_Show", Skin)