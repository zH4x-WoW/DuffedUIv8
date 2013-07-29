local D, C, L = select(2, ...):unpack()

if (not C.Chat.Enable) then
	return
end

local NumLines = 3

function FloatingChatFrame_OnMouseScroll(self, delta)
	if (delta < 0) then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			for i = 1, NumLines do
				self:ScrollDown()
			end
		end
	elseif (delta > 0) then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			for i = 1, NumLines do
				self:ScrollUp()
			end
		end
	end
end