
function WndVillage_ForGameDesigner_WndVillage_ForGameDesigner()

-----------------------------------------
-- �ʱ� ī�޶� ��ġ ����
-----------------------------------------
-- �ޱ�, Ÿ����ġ���� �Ÿ�, ī�޶��� ����, ī�޶� Ÿ���� ����
--SetCameraOption(150, 2000, 30, 100);	-- SceneDesign.dat���� ����

-----------------------------------------
-- ���� ĳ���� �ӵ� �� �ȴ� �ִϸ��̼�
-----------------------------------------
SetMoveVelocity(70, 80);
--SetMoveAniFile("AVM_���ȱ�.kf", "AVW_���ȱ�.kf");
SetMoveAniFile("A_�̵�Changed-move.kf", "A_�̵�����Changed-move.kf");
SetLightDir(250, -190, 250);



-----------------------------------------
-- ä�� �� �۾� �� ����
-----------------------------------------
--[[
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_0'):setTextColor(255, 200, 80, 255);
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_0'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_1'):setTextColor(0, 0, 0, 255);
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_1'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_1'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_1'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_2'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_2'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_3'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_3'):setTextOutLineColor(0, 0, 0, 255);
--]]
-----------------------------------------
-- ä�� ó�� ����
-----------------------------------------
local VGD_String_Action = {["protecterr"]=0, }
VGD_String_Action[0]	= PreCreateString_2536	--GetSStringInfo(LAN_WATER_GUN)		-- /���� watergun
VGD_String_Action[1]	= PreCreateString_1695	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_41)		-- /��1
VGD_String_Action[2]	= PreCreateString_1712	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_58)		-- /��2
VGD_String_Action[3]	= PreCreateString_2382	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_100)		-- /��3
VGD_String_Action[4]	= PreCreateString_2383	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_101)		-- /��4
VGD_String_Action[5]	= PreCreateString_1711	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_57)		-- /����
VGD_String_Action[6]	= PreCreateString_1696	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_42)		-- /����
VGD_String_Action[7]	= PreCreateString_1697	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_43)		-- /���
VGD_String_Action[8]	= PreCreateString_1698	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_44)		-- /���
VGD_String_Action[9]	= PreCreateString_1699	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_45)		-- /����
VGD_String_Action[10]	= PreCreateString_1700	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_46)		-- /����� --GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_47)		-- /���λ�
VGD_String_Action[11]	= PreCreateString_1702	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_48)		-- /����
VGD_String_Action[12]	= PreCreateString_1703	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_49)		-- /������
VGD_String_Action[13]	= PreCreateString_1704	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_50)		-- /����
VGD_String_Action[14]	= PreCreateString_1705	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_51)		-- /���͸±�
VGD_String_Action[15]	= PreCreateString_1706	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_52)		-- /����
VGD_String_Action[16]	= PreCreateString_1707	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_53)		-- /��
VGD_String_Action[17]	= PreCreateString_1708	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_54)		-- /�غ�
VGD_String_Action[18]	= PreCreateString_1709	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_55)		-- /����
VGD_String_Action[19]	= PreCreateString_1710	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_56)		-- /�±�
VGD_String_Action[20]	= PreCreateString_4744	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_113)		-- /��5

-- �̸�Ƽ�� New ���̺�
tNewEmoticonCheckTable = {['err']=0, }
tNewEmoticonCheckTable[0]	= false
tNewEmoticonCheckTable[1]	= false
tNewEmoticonCheckTable[2]	= false
tNewEmoticonCheckTable[3]	= false
tNewEmoticonCheckTable[4]	= false
tNewEmoticonCheckTable[5]	= false
tNewEmoticonCheckTable[6]	= false
tNewEmoticonCheckTable[7]	= false
tNewEmoticonCheckTable[8]	= false
tNewEmoticonCheckTable[9]	= false
tNewEmoticonCheckTable[10]	= false
tNewEmoticonCheckTable[11]	= false
tNewEmoticonCheckTable[12]	= false
tNewEmoticonCheckTable[13]	= false
tNewEmoticonCheckTable[14]	= false
tNewEmoticonCheckTable[15]	= false
tNewEmoticonCheckTable[16]	= false
tNewEmoticonCheckTable[17]	= false
tNewEmoticonCheckTable[18]	= false
tNewEmoticonCheckTable[19]	= false
tNewEmoticonCheckTable[20]	= false


--[[
local String_ActionList = ""
local String_ActionListNum = table.getn(VGD_String_Action)

for i = 1, String_ActionListNum do
	if i == String_ActionListNum then
		String_ActionList = String_ActionList.."/"..VGD_String_Action[i]
	else
		String_ActionList = String_ActionList.."/"..VGD_String_Action[i].." "
	end
end
--]]

-- �ҼȾ׼� �̸����
tEmoticonActionName = {["err"]=0, }
for i=0, #VGD_String_Action do
	tEmoticonActionName[i] = "/"..VGD_String_Action[i]
end

STAND = 0
MOVE = 1
LAY	= 2

-- �߰� �ҼȾ׼�
-- ��
AddSocial(STAND, "\/"..VGD_String_Action[0].."1"	, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[1].."1"	, STAND, 'AVM_dance01.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[2].."1"	, STAND, 'AVM_dance02.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[3].."1"	, STAND, 'AVM_dance03.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[4].."1"	, STAND, 'AVM_dance04.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[5].."1"	, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[6].."1"	, STAND, 'AVM_���Ͷ����Ⳳ��.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[7].."1"	, STAND, 'AVM_���ڿ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[8].."1"	, STAND, 'AVM_���ڴ����ֱ�.kf'			, 0, 100)		-- ������ 0�� �����ǹ�
AddSocial(STAND, "\/"..VGD_String_Action[9].."1"	, STAND, 'AVM_��������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[10].."1"	, STAND, 'AVM_�������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[11].."1"	, STAND, 'AVM_���ڿ���.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[12].."1"	, STAND, 'AVM_���ζ�����.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[13].."1"	, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[14].."1"	, STAND, 'AVM_���͸±Ⳳ��.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[15].."1"	, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[16].."1"	, STAND, 'AVM_���ϱ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[17].."1"	, STAND, 'AVM_��Ǯ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[18].."1"	, STAND, 'AVM_�������_���ӳ׹�.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[19].."1"	, STAND, 'AVM_���θ±�.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[20].."1"	, STAND, 'AVM_dance05.kf'				, 0, 100)
AddSocial(STAND, '\/��1'							, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, '\/����1'							, STAND, 'AVM_����.kf'					, 0, 100)
AddSocial(STAND, '\/�ƴ�1'							, STAND, 'AVM_����.kf'					, 0, 100)


-- ��
AddSocial(STAND, "\/"..VGD_String_Action[0].."2"	, STAND, 'AVW_����.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[1].."2"	, STAND, 'AVW_dance01.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[2].."2"	, STAND, 'AVW_dance02.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[3].."2"	, STAND, 'AVW_dance03.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[4].."2"	, STAND, 'AVW_dance04.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[5].."2"	, STAND, 'AVW_������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[6].."2"	, STAND, 'AVW_���Ͷ����⿩��.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[7].."2"	, STAND, 'AVW_���ڿ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[8].."2"	, STAND, 'AVW_���ڴ����ֱ�.kf'			, 0, 100)		-- ������ 0�� �����ǹ�
AddSocial(STAND, "\/"..VGD_String_Action[9].."2"	, STAND, 'AVW_��������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[10].."2"	, STAND, 'AVW_���ڻ������.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[11].."2"	, STAND, 'AVW_���ڿ���.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[12].."2"	, STAND, 'AVW_�����ζ�����.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[13].."2"	, STAND, 'AVW_������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[14].."2"	, STAND, 'AVW_���͸±⿩��.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[15].."2"	, STAND, 'AVW_������.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[16].."2"	, STAND, 'AVW_���ϱ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[17].."2"	, STAND, 'AVW_��Ǯ��.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[18].."2"	, STAND, 'AVW_���ڻ������_���ӳ׹�.kf'	, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[19].."2"	, STAND, 'AVW_�����θ±�.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[20].."2"	, STAND, 'AVW_dance05.kf'				, 0, 100)
AddSocial(STAND, '\/��2'							, STAND, 'AVW_������.kf'				, 0, 100)
AddSocial(STAND, '\/����2'							, STAND, 'AVW_������.kf'				, 0, 100)
AddSocial(STAND, '\/�ƴ�2'							, STAND, 'AVW_������.kf'				, 0, 100)


-- ���� ��� ������ ����Ŵ� ���ȣ
-- 1000
g_Zone1_RoomNumber = 1000;
-- 1001 ���� ��ŷ�ʿ� ����
g_Zone2_RoomNumber = 1001;
-- 1002 �ǳθ� ����
g_Zone3_RoomNumber = 1002;
-- 1003 �ǳθ� ������
g_Zone4_RoomNumber = 1003;


-- ����� ���� �κ�

tHelperString = {['protecterr'] = 0,}
tHelperString[1] = PreCreateString_1387	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_7)--'[�׶�/����ġ]������ �����̵忡��\n�׶��� ����ġ�� ȹ���� �� �ֽ��ϴ�.'-- 7
tHelperString[2] = PreCreateString_1399	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_19)--'[����]���� �ϴ� �������⸦\nŬ���ϸ� ������ �� �� �ֽ��ϴ�.'--19
tHelperString[3] = PreCreateString_1385	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_5)--'[����]������ �����̵带\n���� ȹ�� �� �� �ֽ��ϴ�.'--5
tHelperString[4] = PreCreateString_1391	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_11)--'[����]���忡�� MŰ�� ������\n��ü���� Ȱ��ȭ �˴ϴ�.'--11
tHelperString[5] = PreCreateString_1397	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_17)--'[����]����10�� �Ǹ� ������\n������Ʈ�� ���� ������ �մϴ�.'--17
tHelperString[6] = PreCreateString_1713	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_59)--'[���̵�]���� �߾ӿ� �ִ�\n��Ű���� �����ø� ���� �̾߱⸦\n���� �� �ֽ��ϴ�.'--59
tHelperString[7] = PreCreateString_1398	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_18)--'[ç�����̼�]���忡 ����Ŀ����\nã�ư��� ç���� �̼ǿ� ����\n������ ������ �� �ֽ��ϴ�.'--18
tHelperString[8] = PreCreateString_1388	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_8)--'[ç�����̼�]é�͸� ��� �Ϸ��ϸ�\n���� é�ͷ� �Ѿ�ϴ�.'--8
tHelperString[9] = PreCreateString_1389	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_9)--'[ç�����̼�]�¸�/�й� ����\nç���� �̼��� ��������\n������ �� �ֽ��ϴ�.'--9
tHelperString[10] = PreCreateString_1390	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_10)--'[ç�����̼�]ç���� �̼���\n�����̵�� �������� �����Ͽ�\n�Ϸ��� �� �ֽ��ϴ�.'--10
tHelperString[11] = PreCreateString_1400	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_20)--'[�����̵�]�����̵带 ����\n���� �� ü�轺ų��\nȹ���Ͻ� �� �ֽ��ϴ�.'--20
tHelperString[12] = PreCreateString_1401	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_21)--'[�����̵�]�����̵带 �߰���\n�����ϸ� ������ ç���� �̼ǵ���\n�������� �ʽ��ϴ�.'--21
tHelperString[13] = PreCreateString_1386	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_6)--'[������]�������� �����Ϸ���\n���� �м��뿡 ��Ű�� ã�ư�����.'--6
tHelperString[14] = PreCreateString_1394	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_14)--'[������]Īȣ, ĳ���� ������\nȹ���ϸ� ���� ��� �����Կ���\nȮ���� �����մϴ�.'--14
tHelperString[15] = PreCreateString_1396	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_16)--'[������]������, �ڽ�Ƭ, ��ų��\n���콺 ���� Ŭ������\n������ �����մϴ�.'--16
tHelperString[16] = PreCreateString_1393	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_13)--'[������]���� ��ܿ� ��������\nŬ���� �� �������� ����Ŭ���ϸ�\n������ ���� �� �ֽ��ϴ�.'--13
tHelperString[17] = PreCreateString_1395	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_15)--'[ü�轺ų]ü�轺ų�� �����Կ���\n������ ���� �ϴ� �� ��ų����\nȮ���� �����մϴ�.'--15
tHelperString[18] = PreCreateString_1392	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_12)--'[ä�ø�ũ��]���� ��ܿ� �ɼ���\nŬ���� �� ���� �ǿ���\n��ũ�θ� Ȯ���� �� �ֽ��ϴ�.'--12


-- ç���� �̼� ���Ǿ� ��ȭ(0)
--'���� ���� ������ �����̱���~\n�̷��� 6������ �����Ѵٴϱ� ������'
tChallengeMissionString = {['err'] = 0, }
tChallengeMissionString[1] = PreCreateString_1402	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_22)

-- ���α�ȯ ���Ǿ� ��ȭ(1)
--'�ȳ��ϼ���!\n��6�������� �������� �Ǹ��ϰ� �ִ� ��Ű��� �ؿ�.\n�����ۿ� �����ؼ� �ñ��� ���� ������ ������ �������.'
tWelcomeMentString = {['err'] = 0, PreCreateString_1403} --GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_23)

--��� ���Ǿ� ��ȭ(2)
--"�� ���� ���������� ã�ƿ��̳׿�.\n����Ʈ Ŭ������ �繫���� ���� ����ϴ� �����̶�� �ؿ�.\n����Ʈ��ȸ�� ���λ������� ���� ����Ʈ Ŭ�� ����� ���� �Ұ����ؿ�."
tGuildNpcString = {['err'] = 0, PreCreateString_1404}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_24) 

-- ��Ƽ��Ī1 NPC ��ȭ
-- ���~ �ȳ��ϼ���!\n��Ƽ ��Ī ������ ������ �����̿���.\n���� ��� ���� �� �����ôٱ���??\n����..�¾ƿ�. ���� �ֵ��� ����Դϴ�.\n�Ƹ��� �� ������ ���� �� ���׿�. ������ 6���� ���� ���ʿ� �־��.
tParty1Ment = {['err'] = 0, PreCreateString_1891}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_79) 

-- ��Ƽ��Ī2 NPC ��ȭ
-- ���~ �ȳ��ϼ���!\n��Ƽ ��Ī ������ ���� �����̿���.\n���� ��� ���� �� �����ôٱ���??\n����..�¾ƿ�. ���� �ֵ��� �����Դϴ�.\n�Ƹ��� �� ��ϸ� ���� �� ���׿�. ��ϴ� 6���� ���� ���ʿ� �־��.
tParty2Ment = {['err'] = 0, PreCreateString_1892}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_80)

--�������Ǿ� ��Ʈ(3)
tChangeJobString = {['err'] = 0,}
tChangeJobString[1] = PreCreateString_1405	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_25)--"����ð�!\n�����ϴ� ���� �������μ��� �����Ѱ� ����.\n���� 10�� �Ǹ� ���� ã�ƿ��� ������ ������ �����ΰ��� �˷��ְڳ�!"
tChangeJobString[2] = PreCreateString_1406	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_26)--"��! ���� ������ �������� ���� ��� �ڼ��� �Ȱ� ����.\n� ������ ����ϴ� �������� �ǰ� ������ �����غ���.\n�� ������Ʈ���� ���� ������ ������ �ְڳ�!"
tChangeJobString[3] = PreCreateString_1407	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_27)--"�Դ°�! ��������!\n���� 20�� �Ǽ� ������ ���� �� �ٸ� ������ ���踦 ���� �� �ְ� ���ְڳ�!\n���� ��밡 ũ��!"

-- ���� ���Ǿ� ó����ȭ
tCostumeCraftingString = {['err'] = 0, PreCreateString_2361}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_91)


-- Npc���丮 �ڸ�
tNpcStoryTelling	 = { ["err"]=0, [0]={["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }}
tNpcStoryTellingName = { ["err"]=0, [0]={["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }}

-- ç���� �̼� NPC
tNpcStoryTelling[0]["size"] = 3
tNpcStoryTelling[0][1] = PreCreateString_1408	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_28)--"ç���� �̼��� ����Ʈ ��ȸ���� �������� ������ ���� ���� ���õ� ���α׷��̿���.\n�������� ������ �ϰų� �����̵忡�� ���̿��� �ϴ��� ����ġ�� ��� ������ ����Ͽ�\n���� ������ �Ѿ�� ������ �����ϸ� ������ �帮�� �ִ�ϴ�.\nç���� �̼��� �ڵ����� ����Ǹ� ������ �ٷιٷ� ���޵ȴ�ϴ�."
tNpcStoryTelling[0][2] = PreCreateString_1409	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_29)--"���̿����� �����Ͽ� ������� ��ü����.\n����ƾ Jr ����� Mr.����� ��Ģ�� ������������ �츮�� �ر�����.\n������ �츮 ����Ʈ ��ȸ�� �ٽ� ��Ȱ�ϰ� �־��.\n�������� ������ �ϻ�� ���̿����� �ݵ�� ó���� �ſ���."
tNpcStoryTelling[0][3] = PreCreateString_1410	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_30)--"��..���� ��ü�� �ñ��Ͻôٱ���?\n�� ���� �������� ���͵帮�� ���� ���̿���.\n������ �־ ���� ����� �־��.\n�Ƹ���.. �������� ���� ���� �� �� �ִ� ���� �������� �ְ���.."

-- ç���� �̼� ��ȭ ��ư �̸�
tNpcStoryTellingName[0][1] = PreCreateString_1723	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_62)--"ç�����̼��̶�?"
tNpcStoryTellingName[0][2] = PreCreateString_1724	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_63)--"����Ʈ��ȸ��?"
tNpcStoryTellingName[0][3] = PreCreateString_1725	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_64)--"����Ŀ���� ��ü"


-- ��Ƽ��Ī1 NPC
tNpcStoryTelling[1]["size"] = 4
tNpcStoryTelling[1][1] = PreCreateString_1897	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_85)--��Ƽ�� ������ ���ϴ� ����鳢�� ���̴� �����̿���.\n"�����嵵 �µ�� ����"��� ���� �ֵ��� ���� ���� ������\n����� ���� ���� �ذ� �� �� �־��.\n� ���� ��Ƽ�� �ؼ� ���� ��� ���̿����� �̰��ּ���.\n��Ƽ�� ���õ� ����� �� ���� �˾�â���� �Ͻ� �� �־��.
tNpcStoryTelling[1][2] = PreCreateString_1898	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_86)--���ݵ� ��𼱰� ���̿��� �ϴ���� ����Ʈ ��ȸ�� �븮�� �־��.\n���̿��� �Ǵ���� �����ļ� ����Ʈ ��ȸ�� ��Ű�� ��4������ Żȯ���ּ���.\n�����̵忡���� �������� ��ų�� ��ȭ �� �� �ִ� ��ų ��ȭ���� ȹ�� �� �� �־��.\n�����̵� ������ ���� ������� �ʿ��� ���� ���� ������.\n������� ������ �÷����ϸ� �����ϰ� ���Ϳ�.
tNpcStoryTelling[1][3] = PreCreateString_1899	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_87)--���� �ȿ��� ���ڰ� �ִ� ���� ������ ����������.\nȥ�ڼ� �ϴ� ������ �ܷο�ϱ�, ��Ƽ�� �ؼ� ��������.\n���������� �����̵� ������� ������ ���� ���� ������� ȹ���غ�����.
tNpcStoryTelling[1][4] = PreCreateString_1900	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_88)--�غ��� ��Ƽ�� ��Ƽ�� �������ϴ� ��Ƽ�Դϴ�.\n��Ƽ�� �⺻ ������ �׻� �غ������� �Ǿ� ������, ���ϴ� ��Ƽ�� ���� ������\n��Ƽ�� ������ �ٲ��ּ���.


-- ��Ƽ��Ī1 ��ȭ��ư �̸�
tNpcStoryTellingName[1][1] = PreCreateString_1893	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_81)--��Ƽ��?
tNpcStoryTellingName[1][2] = PreCreateString_1894	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_82)--�����̵� ��Ƽ
tNpcStoryTellingName[1][3] = PreCreateString_1895	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_83)--���� ��Ƽ
tNpcStoryTellingName[1][4] = PreCreateString_1896	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_84)--�غ��� ��Ƽ


-- ��Ƽ��Ī2 NPC(��Ƽ1�� ����)
tNpcStoryTelling[2]["size"] = 4
tNpcStoryTelling[2][1] = PreCreateString_1897	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_85)--��Ƽ�� ������ ���ϴ� ����鳢�� ���̴� �����̿���.\n"�����嵵 �µ�� ����"��� ���� �ֵ��� ���� ���� ������\n����� ���� ���� �ذ� �� �� �־��.\n� ���� ��Ƽ�� �ؼ� ���� ��� ���̿����� �̰��ּ���.\n��Ƽ�� ���õ� ����� �� ���� �˾�â���� �Ͻ� �� �־��.
tNpcStoryTelling[2][2] = PreCreateString_1898	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_86)--���ݵ� ��𼱰� ���̿��� �ϴ���� ����Ʈ ��ȸ�� �븮�� �־��.\n���̿��� �Ǵ���� �����ļ� ����Ʈ ��ȸ�� ��Ű�� ��4������ Żȯ���ּ���.\n�����̵忡���� �������� ��ų�� ��ȭ �� �� �ִ� ��ų ��ȭ���� ȹ�� �� �� �־��.\n�����̵� ������ ���� ������� �ʿ��� ���� ���� ������.\n������� ������ �÷����ϸ� �����ϰ� ���Ϳ�.
tNpcStoryTelling[2][3] = PreCreateString_1899	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_87)--���� �ȿ��� ���ڰ� �ִ� ���� ������ ����������.\nȥ�ڼ� �ϴ� ������ �ܷο�ϱ�, ��Ƽ�� �ؼ� ��������.\n���������� �����̵� ������� ������ ���� ���� ������� ȹ���غ�����.
tNpcStoryTelling[2][4] = PreCreateString_1900	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_88)--�غ��� ��Ƽ�� ��Ƽ�� �������ϴ� ��Ƽ�Դϴ�.\n��Ƽ�� �⺻ ������ �׻� �غ������� �Ǿ� ������, ���ϴ� ��Ƽ�� ���� ������\n��Ƽ�� ������ �ٲ��ּ���.


-- ��Ƽ��Ī2 ��ȭ��ư �̸�(��Ƽ1�� ����)
tNpcStoryTellingName[2][1] = PreCreateString_1893	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_81)--��Ƽ��?
tNpcStoryTellingName[2][2] = PreCreateString_1894	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_82)--�����̵� ��Ƽ
tNpcStoryTellingName[2][3] = PreCreateString_1895	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_83)--���� ��Ƽ
tNpcStoryTellingName[2][4] = PreCreateString_1896	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_84)--�غ��� ��Ƽ


-- ��� NPC
tNpcStoryTelling[3]["size"]	= 3
tNpcStoryTelling[3][1] = PreCreateString_1416	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_36)--"������ �´� ���������� �𿩼� ���� ������ ����Ʈ Ŭ���̶�� �ؿ�.\n�߼��ô뿡�� ����� �ҷȴ� ������.\n����Ʈ Ŭ�� ���� ������ �������� ����Ʈ ��ȸ�� �����ϰ� �־��.\n��ŵ� ����Ʈ Ŭ���� �Ҽӵǽø� �Ƿ��� �������� ���� ���� �� �����ſ���."
tNpcStoryTelling[3][2] = PreCreateString_1417	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_37)--"���ο� ����Ʈ Ŭ���� ����Ͻðڴٱ���?\n���� 10�� �ǰ� �� �� �����۾��� �ϼ���.\n����Ʈ��ȸ ���� ��� 1�� �׶��� �����Ͻø� Ŭ���� ����� �� �־��.\n���� ����Ʈ ��ȸ�� Ŭ�� ���� �μ��� ��ġ���� �ʾ� ����� �Ұ����ؿ�."
tNpcStoryTelling[3][3] = PreCreateString_1418	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_38)--"Ŭ�� ��� �� Ŭ�� �̸�, Ŭ�� ��ũ, Ŭ�� Īȣ�� �����Ϸ���\nĳ�ð� �Ҹ�Ǵ� �����ϼ���.\nŬ�� URL�� ��� �� ������ �Ұ����մϴ�."

-- ��� ��ȭ ��ư �̸�
tNpcStoryTellingName[3][1] = PreCreateString_1729	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_68)--"����Ʈ Ŭ��"
tNpcStoryTellingName[3][2] = PreCreateString_1730	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_69)--"����Ʈ Ŭ�� ���"
tNpcStoryTellingName[3][3] = PreCreateString_1731	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_70)--"��Ͻ� ������"


-- ���� NPC--------------------------------------------------
tNpcStoryTelling[4]["size"]	= 2
tNpcStoryTelling[4][1] = PreCreateString_1714	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_60)--"Ŭ������ �ڽ��� ���� ������ ����ϴ� ���̶��.\n�켱 ó�� ������ ��Ʈ��Ʈ(Ÿ�ݰ迭)�� ����(���迭)�� �����Ѵٳ�.\n���߿��� ���� �������μ� ���ο� ������ ��� �� ����."
tNpcStoryTelling[4][2] = PreCreateString_1716	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_61)--"������ ��Ʈ��Ʈ(Ÿ�ݰ迭)�� ����(���迭)����\n���� �������� ��� �� �ִ� �ڰ��� �ɻ��ϴ� ���̶��.\n���� 10�� ������ �����ϸ� ��Ʈ��Ʈ�� �±ǵ�, ����, ����Ÿ�̷�\n������ ���η�����, ����, �ձ⵵�� ������ ��������.\n���� �P������ ���� ������ �������� ���߿� ���� ���� �ִٳ�."


-- ���� ��ȭ��ư �̸�
tNpcStoryTellingName[4][1] = PreCreateString_1733	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_71)--"Ŭ������"
tNpcStoryTellingName[4][2] = PreCreateString_1734	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_72)--"�����̶�"


-- ���α�ȯ NPC
tNpcStoryTelling[5]["size"] = 5
tNpcStoryTelling[5][1] = PreCreateString_1411	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_31)--"[�׶�]�� �������̳� �ڽ�Ƭ, ��ų�� ������ �� �ַ� ������.\n������ �ϰų� �����̵忡�� ���̿��� �ϴ��� ��ġ��� �׶��� ȹ���� �� �־��.\n\n[����]�� ���� �������ڸ� ������ �� ����ؿ�.\n�����̵忡�� ���̿��� �ϴ��� ��ġ��� ������ ȹ���� �� �־��."
tNpcStoryTelling[5][2] = PreCreateString_1412	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_32)--"���� �ȿ��� ���ڰ� �ִ� ���� ������ ����������.\n������ �ϸ� �Ҽ��� ������ �������� �����ϰ� �ִ� �ڽ��� Ȯ���� �� ���� �ſ���.\n������ �ϸ� ���� �׶��� ����ġ�� ���޵ǰ� �־��."
tNpcStoryTelling[5][3] = PreCreateString_1413	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_33)--"���ݵ� ��𼱰� ���̿��� �ϴ���� ����Ʈ��ȸ�� �븮�� �־��.\n���̿��� �Ǵ���� �����ļ� ����Ʈ��ȸ�� ��Ű�� ��4������ Żȯ�ϵ��� �ؿ�!\n�����̵忡�� ���̿����� ����ġ�� ���ΰ� ü�轺ų�� ȹ���� �� �־��.\n�����̵� ��ġ�� ���忡�� MŰ�� ������ Ȯ���ϼ���."
tNpcStoryTelling[5][4] = PreCreateString_1414	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_34)--"���� ���ڿ����� �پ��� �������� ���Ϳ�.\n���� �������ڴ� �׶��� ���� �������� ������ �־��.\n�׶� �������ڿ����� ���ΰ� �����̵� �������� ������ �־��."
tNpcStoryTelling[5][5] = PreCreateString_1415	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_35)--"���и� ��������!\n�����̵忡�� KO�� ������ �� ����ϸ� �ѹ� �� ��ȸ�� ���� �� �־��.\n¡��¡���� ���̿����鿡�� �����ϰ� �ʹٸ� �׻� ������ �־�� �� ����������."

-- ���α�ȯ ��ȭ��ư �̸�
tNpcStoryTellingName[5][1] = PreCreateString_1726	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_65)--"�׶��� ����"
tNpcStoryTellingName[5][2] = PreCreateString_1060	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_3)--"�� ��"
tNpcStoryTellingName[5][3] = PreCreateString_1061	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_4)--"�����̵�"
tNpcStoryTellingName[5][4] = PreCreateString_1727	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_66)--"�������ڶ�?"
tNpcStoryTellingName[5][5] = PreCreateString_1728	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_67)--"��������?"

-- ������ NPC (�ӽ÷�)
tNpcStoryTelling[6]["size"]	= 3
tNpcStoryTelling[6][1] = PreCreateString_1416	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_36)--"������ �´� ���������� �𿩼� ���� ������ ����Ʈ Ŭ���̶�� �ؿ�.\n�߼��ô뿡�� ����� �ҷȴ� ������.\n����Ʈ Ŭ�� ���� ������ �������� ����Ʈ ��ȸ�� �����ϰ� �־��.\n��ŵ� ����Ʈ Ŭ���� �Ҽӵǽø� �Ƿ��� �������� ���� ���� �� �����ſ���."
tNpcStoryTelling[6][2] = PreCreateString_1417	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_37)--"���ο� ����Ʈ Ŭ���� ����Ͻðڴٱ���?\n���� 10�� �ǰ� �� �� �����۾��� �ϼ���.\n����Ʈ��ȸ ���� ��� 1�� �׶��� �����Ͻø� Ŭ���� ����� �� �־��.\n���� ����Ʈ ��ȸ�� Ŭ�� ���� �μ��� ��ġ���� �ʾ� ����� �Ұ����ؿ�."
tNpcStoryTelling[6][3] = PreCreateString_1418	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_38)--"Ŭ�� ��� �� Ŭ�� �̸�, Ŭ�� ��ũ, Ŭ�� Īȣ�� �����Ϸ���\nĳ�ð� �Ҹ�Ǵ� �����ϼ���.\nŬ�� URL�� ��� �� ������ �Ұ����մϴ�."

-- ������ NPC ��ư �̸�(�ӽ÷�)
tNpcStoryTellingName[6][1] = PreCreateString_1729	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_68)--"����Ʈ Ŭ��"
tNpcStoryTellingName[6][2] = PreCreateString_1730	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_69)--"����Ʈ Ŭ�� ���"
tNpcStoryTellingName[6][3] = PreCreateString_1731	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_70)--"��Ͻ� ������"


-- �ڽ�Ƭ ���� ���Ǿ�
tNpcStoryTelling[7]["size"] = 4
tNpcStoryTelling[7][1] = PreCreateString_2362	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_92)--"�ڽ�Ƭ �����̶�..��.. �����ϰ� �������ڸ�..\n2���� ����� �ڽ�Ƭ�� �����Ͽ� 1���� ������ �ڽ�Ƭ�� ���� ���� �����Դϴ�!!\n�� ��������??����.. "
tNpcStoryTelling[7][2] = PreCreateString_2363	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_93)--"�ڽ�Ƭ�� �����ϱ� ���ؼ��� 2���� �ڽ�Ƭ�� 1���� �ڽ�Ƭ ť���� ��ᰡ �ʿ��մϴ�.\n�ڽ�Ƭ ť��� ����NPC ��Ű�� ���ؼ� ���� �Ͻ� �� �ֽ��ϴ�."
tNpcStoryTelling[7][3] = PreCreateString_2364	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_94)--"�ڽ�Ƭ�� �����ϴ� ����� ���� �����մϴ�.\nù ��°, ���� �� �ڽ�Ƭ 2���� �ڽ�Ƭ ť�� 1���� ��� ��ư�� ������ ������ּ���.\n�� ��°, ���� ��ư�� ������ �ڽ�Ƭ�� �����մϴ�.\n���������� �ڽ�Ƭ ���� ����� Ȯ���ϸ� �˴ϴ�. ��������?\n�����ؾ� �� ������...\n�ڽ�Ƭ ���տ� �����ϸ� 1���� �ڽ�Ƭ�� �ı��˴ϴ�.\n�ڽ�Ƭ ������ ���� Ȯ���� ������ �����ϰ� ����ϼž� �մϴ�. "
tNpcStoryTelling[7][4] = PreCreateString_2365	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_95)--"�ڽ�Ƭ ���տ� �����ϰ� �Ǹ� ������ ����� �ڽ�Ƭ�� ȹ���ϰ� �˴ϴ�.\n������ ����� �ڽ�Ƭ�� ���� �ְ��� ������ �ڶ��մϴ�!!\n��� ����Ʈ ��ȸ �Ҽ� �����ͺе��� ������ �ڽ�Ƭ�� ���� �Ǹ� ���ڳ׿�.\n���� ����Ʈ ��ȸ �����Ұ� ������ ���� ��ȸ ���� �ְ��� �ڽ�Ƭ�Դϴ�. "


-- �ڽ�Ƭ ���� ���Ǿ� ��ȭ��ư �̸�
tNpcStoryTellingName[7][1] = PreCreateString_2366	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_96)--"�ڽ�Ƭ �����̶�?"
tNpcStoryTellingName[7][2] = PreCreateString_2367	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_97)--"�ڽ�Ƭ ť���?"
tNpcStoryTellingName[7][3] = PreCreateString_2368	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_98)--"���� ���"
tNpcStoryTellingName[7][4] = PreCreateString_2369	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_99)--"������ �ڽ�Ƭ"




-- ���� �������� ����Ŀ�� ��Ʈ
tFirstEnterText = {['protecterr'] = 0, }
tFirstEnterText[1] = PreCreateString_1419	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_39)--"���� �ּ���! ��4�������� ������ ����̾�?\n�װ��� 4���� ���̿��� �ϴ��� ����Ʈ�� ���Ƴ���\n������ ����õ���� �� ���� ������ ���̶�...\n���� ���� ��6�������� ���� �̸��� �˸��°� ������?"
tFirstEnterText[2] = PreCreateString_1420	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_40)--'���� ��6���������� ����� ����Ʈ ȸ������ ���� ���� �����ž�\n�׷� � �Ƿ°����� �ִ��� ���� "�����Ϸ� ����"�� �����°� ���ڴ�.\n�� ���󿡴� ���� ��6������ ���������� ������?'



-- ���� NPC�� ���� ������ ���� �ٸ� ������ ����.
tChangeJobMissionString = {['protecterr'] = 0, }
--"���ϴ� Ŭ������ �����ϼ���."
tChangeJobMissionString[1] = PreCreateString_1047	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_30)--"�±ǵ�"
tChangeJobMissionString[2] = PreCreateString_1048	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_31)--"����"
tChangeJobMissionString[3] = PreCreateString_1050	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_33)--"����Ÿ��"
tChangeJobMissionString[4] = PreCreateString_1049	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_32)--"ī������"
tChangeJobMissionString[5] = PreCreateString_1053	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_36)--"���η�����"
tChangeJobMissionString[6] = PreCreateString_1052	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_35)--"����"
tChangeJobMissionString[7] = PreCreateString_1054	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_37)--"�ձ⵵"
tChangeJobMissionString[8] = PreCreateString_1055	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_38)--"�ﺸ"
tChangeJobMissionString[9] = "����"

-- �����ϴ� ���������� �޶����� ��Ʈ
tChangeJobMissionMentString = {['protecterr'] = 0, {["protecterr"]=0, }, {["protecterr"]=0, }}

-- �±ǵ�
tChangeJobMissionMentString[1][1] = PreCreateString_1735	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_73)--"ȣ! �±ǵ��� �����߱�~ ����!\n������ ���ϸ� ���� �޺��� �ְ��ڰ� �� �� �ִٴ� �±ǵ�...\n������ �����Ͻð�!"	
-- ����
tChangeJobMissionMentString[1][2] = PreCreateString_1736	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_74)--"ȣ! ������ �����߱�~ ġĩ! ����!\n��� Ŭ���� �� �ָ��� ���� ������ ����! �� �ָԿ� �������� ������...\n���� ��� �ϱ� �ȴٳ�~"
-- ī������
tChangeJobMissionMentString[1][3] = PreCreateString_2052	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_89)--"ȣ! ī������ �����߱�~ ����!\n���� �ߴ� ���� ������ ���ݵ��۰� ���������� Ư¡����...\n������ �����Ͽ� ī������ �����Ͱ� �ǰԳ�!"
-- ����Ÿ��
tChangeJobMissionMentString[1][4] = PreCreateString_1737	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_75)--"ȣ! ����Ÿ�̸� �����߱�~ ����͵���!\n���� �ÿ��ÿ��ϰ� ������ �������� �� �׷��� ����...\n������ �غ��Գ�!"
-- ����
tChangeJobMissionMentString[2][1] = PreCreateString_1738	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_76)--"��! ������ �����Ѱǰ�~ ����!\n������ �׶��� ��� ������� ������ �ŷ�������!\n�� ���� �ٸ� ����鵵 �ŷ����̶��~"
-- ���η�����
tChangeJobMissionMentString[2][2] = PreCreateString_1739	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_77)--"��! �������� �����Ѱǰ�~ ����!\n�������� ����� ����� �ְ��ڿ� �����Ѵٴ� ������ �ִٴµ�...\n��������� ���� �𸥴ٳ�!"
-- �ձ⵵
tChangeJobMissionMentString[2][3] = PreCreateString_1740	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_78)--"��! �ձ⵵�� �����Ѱǰ�~ ����!\n��� Ŭ���� �� Ÿ�� ����� ���� �����ϴٰ� �˷��� ���� ...\n���� �غ��� �˰� �� �Ŷ��!"
-- �ﺸ
tChangeJobMissionMentString[2][4] = PreCreateString_2053	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_90)--"��! �ﺸ�� �����߱�~ ����!\n�������� ��� ������� Ư¡����! �޺��� ����Ǵ� ���̺� ��� �����\n���ϸ� ...�������ص� �����ϱ�!"
-- ����
tChangeJobMissionMentString[1][5] = "��! ���� �����߱�~ ����!\n ¯�̻�"

------------------------------------------
-- ��׾����� �s�� ��ġ
------------------------------------------
-- �帱
local tDrillAniPos_BM = {['err'] = 0, 32, -10, -107, 0, -70, 6}
local tDrillAniPos_MM = {['err'] = 0, 26, -10, -105, 0, -70, 6}
local tDrillAniPos_SM = {['err'] = 0, 21,  -8, -105, 0, -65, 6}
local tDrillAniPos_BW = {['err'] = 0, 24, -10, -109, 0, -70, 6}
local tDrillAniPos_MW = {['err'] = 0, 25, -10, -105, 0, -58, 6}
local tDrillAniPos_SW = {['err'] = 0, 24,  -8, -105, 0, -53, 6}
local tDrillAniPostable = {['err'] = 0, [0]=tDrillAniPos_BM, tDrillAniPos_MM, tDrillAniPos_SM, tDrillAniPos_BW, tDrillAniPos_MW, tDrillAniPos_SW} 

-- ���
local tAxeAniPos_BM = {['err'] = 0, -5, 13, 0, 0, -224, 5}--12, 8, -40, -195, 3}
local tAxeAniPos_MM = {['err'] = 0, -5, 10, 0, 0, -218, 5}
local tAxeAniPos_SM = {['err'] = 0, -5, 10, 0, 0, -210, 4}	--
local tAxeAniPos_BW = {['err'] = 0, -5, 10, 0, -15, -204, 4}
local tAxeAniPos_MW = {['err'] = 0, -5, 8, 0, -16, -202, 4}
local tAxeAniPos_SW = {['err'] = 0, -5, 10, 0, -20, -195, 4}
local tAxeAniPostable = {['err'] = 0, [0]=tAxeAniPos_BM, tAxeAniPos_MM, tAxeAniPos_SM, tAxeAniPos_BW, tAxeAniPos_MW, tAxeAniPos_SW} 


-- ���۵帱
local tSuperDrillAniPos_BM	 = {['err'] = 0, 18, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_MM	 = {['err'] = 0, 10, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_SM	 = {['err'] = 0, 8,  -10, -120, 0, -65, 6}
local tSuperDrillAniPos_BW	 = {['err'] = 0, 15, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_MW	 = {['err'] = 0, 10, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_SW	 = {['err'] = 0, 10,  -10, -120, 0, -70, 6}
local tSuperDrillAniPostable = {['err'] = 0, [0]=tSuperDrillAniPos_BM, tSuperDrillAniPos_MM, tSuperDrillAniPos_SM, tSuperDrillAniPos_BW, tSuperDrillAniPos_MW, tSuperDrillAniPos_SW} 

-- ����
DigAniTable = {['err'] = 0, [0]=tAxeAniPostable, tDrillAniPostable, tDrillAniPostable, tDrillAniPostable , tSuperDrillAniPostable, tSuperDrillAniPostable, tSuperDrillAniPostable, tSuperDrillAniPostable }





-- ���󺰷� �и�
-- ���� ���� ī�װ��̸� �ε���
local tEngName = {[0] =	0, 1, 1, 1, 1, 1} 
local tKorName = {[0] = 0, 1, 1, 1, 1, 1} 
local tThaiName = {[0]= 0, 1, 1, 1, 1, 1} 

tStoreCategoryName = {[0]= tEngName, tKorName, tThaiName } -- 0
	
------
	




end




