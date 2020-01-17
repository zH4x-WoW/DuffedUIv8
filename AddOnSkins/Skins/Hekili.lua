local AS = unpack(AddOnSkins)

if not AS:CheckAddOn('Hekili') then return end

function AS:Hekili()
	for i = 1, 10 do
		if _G["Hekili_Primary_B"..i] then
			local Button = _G["Hekili_Primary_B"..i]
			AS:CreateBackdrop(Button)
			AS:SkinTexture(Button.Texture)
			_G["Hekili_Primary_B"..i]:SetScale(0.85)
		end
		if _G["Hekili_AOE_B"..i] then
			local Button = _G["Hekili_AOE_B"..i]
			AS:CreateBackdrop(Button)
			AS:SkinTexture(Button.Texture)
			_G["Hekili_AOE_B"..i]:SetScale(0.85)
		end
	end
end

AS:RegisterSkin('Hekili', AS.Hekili)