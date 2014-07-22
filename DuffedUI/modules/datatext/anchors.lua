local D, C = select(2, ...):unpack()

-- Local values
local MenuFrame = CreateFrame("Frame", "DataTextToggleDropDown", UIParent, "UIDropDownMenuTemplate")
local DuffedUIDT = D["DataTexts"]
local Anchors = DuffedUIDT.Anchors
local Menu = DuffedUIDT.Menu
local Active = false
local CurrentFrame

DuffedUIDT.Toggle = function(self, object)
	CurrentFrame:SetData(object)
end

DuffedUIDT.Remove = function()
	CurrentFrame:RemoveData()
end

local OnMouseDown = function(self)
	CurrentFrame = self
	EasyMenu(Menu, DataTextToggleDropDown, "cursor", 0, 5, "MENU", 2)
end

function DuffedUIDT:ToggleDataPositions()
	if Active then
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]
			
			Frame:EnableMouse(false)
			Frame.Tex:SetTexture(0.2, 1, 0.2, 0)
		end
		
		Active = false
	else
		for i = 1, self.NumAnchors do
			local Frame = Anchors[i]
			
			Frame:EnableMouse(true)
			Frame.Tex:SetTexture(0.2, 1, 0.2, 0.2)
			Frame:SetScript("OnMouseDown", OnMouseDown)
		end
		
		Active = true
	end
end

function DuffedUIDT:AddRemove()	-- Add a remove button
	tinsert(Menu, {text = "", notCheckable = true})
end