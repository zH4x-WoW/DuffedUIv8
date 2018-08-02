local D, C, L = unpack(select(2, ...))
if not C['datatext']['profession'] or C['datatext']['profession'] == 0 then return end

local Stat = CreateFrame('Frame', 'DuffedUIStatProfession')
Stat:EnableMouse(true)
Stat:SetFrameStrata('BACKGROUND')
Stat:SetFrameLevel(3)

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Text = Stat:CreateFontString('DuffedUIStatProfessionText', 'OVERLAY')
Text:SetFont(f, fs, ff)
D['DataTextPosition'](C['datatext']['profession'], Text)

local format = string.format
local join = string.join

local lastPanel
local profValues = {}
local displayString = ''
local tooltipString = ''

local function GetProfessionName(index)
	local name, _, _, _, _, _, _, _ = GetProfessionInfo(index)
	return name
end

local function Update(self)
	local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
		if prof1 ~= nil then
			local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof1)
			Text:SetFormattedText(D['PanelColor'] .. L['dt']['prof'])
		else
			Text:SetFormattedText(D['PanelColor'] .. L['dt']['profless'])
		end
	self:SetAllPoints(Text)
end

Stat:SetScript('OnEnter', function()
	local anchor, panel, xoff, yoff = D['DataTextTooltipAnchor'](Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(D['PanelColor'] .. D['MyName'] .. 's ' .. L['dt']['prof'])
	GameTooltip:AddLine(' ')
	local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
	local professions = {}
	
	if prof1 ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof1)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if prof2 ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof2)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if archy ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(archy)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if fishing ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(fishing)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if cooking ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(cooking)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if firstAid ~= nil then
		local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(firstAid)
		professions[#professions + 1] = {
			name	= name,
			texture	= ('|T%s:12:12:1:0|t'):format(texture),
			rank	= rank,
			maxRank	= maxRank
		}
	end
	
	if #professions == 0 then return end	
	sort(professions, function(a, b) return a['name'] < b['name'] end)
	
	for i = 1, #professions do GameTooltip:AddDoubleLine(join('', professions[i].texture, '  ', professions[i].name), professions[i].rank .. ' / ' .. professions[i].maxRank,.75,.9,1,.3,1,.3) end
	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['proftooltip'] , .7, .7, 1, .7, .7, 1)
	GameTooltip:Show()
end)
Stat:SetScript('OnUpdate', Update)
Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)

Stat:SetScript('OnMouseDown', function(self, btn)
	if btn == 'LeftButton' then ToggleSpellBook('professions') end
end)