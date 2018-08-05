local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['layout']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

if class ~= 'ROGUE' then return end

D['ClassRessource']['ROGUE'] = function(self)
	if not C['unitframes']['attached'] then D['ConstructEnergy']('Energy', 216, 5) end
	
	local ComboPoints = CreateFrame('Frame', 'ComboPoints', UIParent)
	ComboPoints:Size(216, 5)
	if C['unitframes']['attached'] then
		if layout == 1 then
			ComboPoints:Point('TOP', oUF_Player.Power, 'BOTTOM', 0, 0)
		elseif layout == 2 then
			ComboPoints:Point('CENTER', oUF_Player.panel, 'CENTER', 0, 0)
		elseif layout == 3 then
			ComboPoints:Point('CENTER', oUF_Player.panel, 'CENTER', 0, 5)
		elseif layout == 4 then
			ComboPoints:Point('TOP', oUF_Player.Health, 'BOTTOM', 0, -5)
		end
	else
		ComboPoints:Point('BOTTOM', RessourceMover, 'TOP', 0, -5)
	end
	ComboPoints:SetBackdrop(backdrop)
	ComboPoints:SetBackdropColor(0, 0, 0)
	ComboPoints:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 10 do
		ComboPoints[i] = CreateFrame('StatusBar', 'ComboPoints' .. i, ComboPoints)
		ComboPoints[i]:Height(5)
		ComboPoints[i]:SetStatusBarTexture(texture)
		if i == 1 then
			ComboPoints[i]:SetPoint('LEFT', ComboPoints, 'LEFT', 0, 0)
			ComboPoints[i]:Width(216 / 10)
			
			ComboPoints[i].Anticipation = ComboPoints[i]:GetWidth()
			ComboPoints[i].Deeper = 216 / 6
			ComboPoints[i].None = 216 / 5
		else
			ComboPoints[i]:Point('LEFT', ComboPoints[i - 1], 'RIGHT', 1, 0)
			ComboPoints[i]:Width(216 / 10 - 1)
			
			ComboPoints[i].Anticipation = ComboPoints[i]:GetWidth()
			ComboPoints[i].Deeper = 216 / 6 - 1
			ComboPoints[i].None = 216 / 5 - 1
		end
		ComboPoints[i].bg = ComboPoints[i]:CreateTexture(nil, 'ARTWORK')
	end
	ComboPoints:CreateBackdrop()
	self.ComboPointsBar = ComboPoints
	if C['unitframes']['oocHide'] then D['oocHide'](ComboPoints) end
end
