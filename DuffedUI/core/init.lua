local addon, engine = ...
engine[1] = {}
engine[2] = {}
engine[3] = {}
engine[4] = {}

DuffedUI = engine

ERR_NOT_IN_RAID = ""

local UIHider = CreateFrame("Frame", "DuffedUIUIHider", UIParent)
UIHider:Hide()

local PetBattleHider = CreateFrame("Frame", "DuffedUIPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

DuffedUI [1].SetPerCharVariable = function(varName, value)
	-- print("ATTENTION: SPCV called prior to VARIABLES_LOADED event")
	_G [varName] = value
end


--[[

	The code below works around a issue of the WoD Beta Client 6.0.2 b18934
	on OS X 10.10 where data stored in "SavedVariablesPerCharacter" variables
	is not reliably restored after exiting and reentering the game if the
	player's name contains "umlauts".

	The corresponding bug report can be found under:

		http://eu.battle.net/wow/en/forum/topic/12206010700

	To enable this workaround enter the followin commands into the chat window:

		/script DuffedUIData.usePerCharData = true
		/reload

	The code can be removed once the client issue has been fixed. Only the
	"SetPerCharVariable" part above should stay in for compatibility
	(otherwise all uses of the function must be replaced with an
	assignment statement again).

--]]

local DuffedUIOnVarsLoaded = CreateFrame("Frame")
DuffedUIOnVarsLoaded:RegisterEvent("VARIABLES_LOADED")
DuffedUIOnVarsLoaded:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("VARIABLES_LOADED")

	if DuffedUIData == nil then
		-- probably the first load after installation of addon, assume that SVPC works
		DuffedUIData = {}
	end

	if DuffedUIData.usePerCharData then
		local playerName = UnitName("player") .. "@" .. GetRealmName()

		if DuffedUIData.perCharData ~= nil and DuffedUIData.perCharData [playerName] ~= nil then
			local pcd = DuffedUIData.perCharData [playerName]

			if DuffedUIDataPerChar == nil then
				DuffedUIDataPerChar = pcd.DuffedUIDataPerChar
			end
			if ClickCast == nil then
				ClickCast = pcd.ClickCast
			end
			if ImprovedCurrency == nil then
				ImprovedCurrency = pcd.ImprovedCurrency
			end
		end

		local SetPerCharVariable = function(varName, value)
			if DuffedUIData.perCharData == nil then
				-- probably this is the time the addon is loaded after updating it to SVPC support
				DuffedUIData.perCharData = {};
			end

			if DuffedUIData.perCharData [playerName] == nil then
				DuffedUIData.perCharData [playerName] = {};
			end

			local pcd = DuffedUIData.perCharData [playerName]

			_G [varName] = value
			pcd [varName] = value
		end

		-- replace the minimum implementation provided above
		DuffedUI [1].SetPerCharVariable = SetPerCharVariable
	end
end)
