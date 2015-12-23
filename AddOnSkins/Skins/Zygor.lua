local AS = unpack(AddOnSkins)

if not AS:CheckAddOn('ZygorGuidesViewer') then return end

function AS:Zygor()
	AS:StripTextures(ZygorGuidesViewerFrame_Border, true)
	AS:SkinFrame(ZygorGuidesViewerFrame, nil, nil, true)

	for i = 1, 6 do
		AS:SkinBackdropFrame(_G['ZygorGuidesViewerFrame_Step'..i])
	end

	hooksecurefunc(ZygorGuidesViewer.CreatureViewer, 'CreateFrame', function(self)
		if self.Frame then
			AS:SkinFrame(ZygorGuidesViewer_CreatureViewer)
		end
	end)
end

AS:RegisterSkin('Zygor', AS.Zygor)