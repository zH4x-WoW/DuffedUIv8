local D, C, L = unpack(select(2, ...))

-- GhostFrame at top
GhostFrame:SetTemplate("Default")
GhostFrame:SetBackdropColor(0, 0, 0, 0)
GhostFrame:SetBackdropBorderColor(0, 0, 0, 0)
GhostFrame.SetBackdropColor = D.Dummy
GhostFrame.SetBackdropBorderColor = D.Dummy
GhostFrameContentsFrame:SetTemplate("Default")
GhostFrameContentsFrameIcon:SetTexture(nil)
GhostFrameContentsFrame:Width(148)
GhostFrameContentsFrame:ClearAllPoints()
GhostFrameContentsFrame:SetPoint("CENTER")
GhostFrameContentsFrame.SetPoint = D.Dummy
GhostFrame:SetFrameStrata("LOW")
GhostFrame:SetFrameLevel(5)
GhostFrame:ClearAllPoints()
GhostFrame:Point("TOP", UIParent, 0, 26)
GhostFrameContentsFrameText:ClearAllPoints()
GhostFrameContentsFrameText:Point("BOTTOM", 0, 5)