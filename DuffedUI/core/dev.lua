local D, C, L = unpack(select(2, ...))

--[[local LA = LibStub:GetLibrary("LegionArtifacts-1.0")
for i,artifact in pairs(LA:GetArtifacts()) do
   local _,link = GetItemInfo(artifact)
   print(link)
   for j,power in pairs(LA:GetPowers(artifact)) do
      local x = LA:GetPowerInfo(power,artifact)
      local id,_,curRank = unpack(x)
      print(GetSpellLink(id),id,'Rank: ' .. curRank)
   end
end]]