------------------------------------------------------------------------

-- ������ �˾� ����

------->>���⼭ ���� �Ʒ� �κ��� �����մϴ�<<-----------------------------------------
local VillagePopupCnt = 1;

tPopupTextureNames = {['err']='Error', 
"EventVillagePopup011.tga"
}
------->>������� �� �κ��� �����մϴ�<<-----------------------------------------
function GetPopupCnt()
	local MaxPopupCnt = 5;
	if VillagePopupCnt <= MaxPopupCnt then
		SetPopupCnt(VillagePopupCnt);
	end
end

function GetPopupTextureName(idx)
	if idx <= #tPopupTextureNames then
		SetPopupTextureName(tPopupTextureNames[idx]);
	end
end
------------------------------------------------------------------------
