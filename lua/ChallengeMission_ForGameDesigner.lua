
--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�(���ö���¡)
--------------------------------------------------------------------
g_String_Normal		= PreCreateString_1027	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_10)		-- �Ϲ�
g_String_Playing	= PreCreateString_1030	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_13)		-- ������
g_String_Complete	= PreCreateString_1029	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_12)		-- �Ϸ�
g_String_NotPlaying	= PreCreateString_1028	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_11)		-- ����Ұ�
local String_Fight	= PreCreateString_1060	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_3)	-- ����
local String_Arcade	= PreCreateString_1061	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_4)	-- �����̵�


----------------------------------------------------------

-- �⺻ ç���� �̼�

----------------------------------------------------------
g_CM_tFontColor	= {['protecterr']=0, {['protecterr']=0, }, {['protecterr']=0, }, {['protecterr']=0, }}


g_CM_tFontColor[1][g_String_Normal] = 180
g_CM_tFontColor[2][g_String_Normal] = 180
g_CM_tFontColor[3][g_String_Normal] = 180

g_CM_tFontColor[1][g_String_Playing] = 245
g_CM_tFontColor[2][g_String_Playing] = 255
g_CM_tFontColor[3][g_String_Playing] = 14

g_CM_tFontColor[1][g_String_Complete] = 87
g_CM_tFontColor[2][g_String_Complete] = 242
g_CM_tFontColor[3][g_String_Complete] = 9

g_CM_tFontColor[1][g_String_NotPlaying] = 255 
g_CM_tFontColor[2][g_String_NotPlaying] = 63
g_CM_tFontColor[3][g_String_NotPlaying] = 16



g_tChapterName = { ["protecterr"]=0, }
g_tChapterName[1] = PreCreateString_1058	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_1)	--"é��1. ü���϶�"
g_tChapterName[2] = PreCreateString_1059	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_2)	--"é��2. �޼��϶�"


g_tCM_PlaceName = { ["protecterr"]=0, }
g_tCM_PlaceName[1] 	= String_Fight.." /\n"..String_Arcade		-- KO��					0
g_tCM_PlaceName[2] 	= String_Fight.." /\n"..String_Arcade		-- DOWN��				1
g_tCM_PlaceName[3] 	= String_Arcade			-- �����̵� ����		2
g_tCM_PlaceName[4] 	= String_Arcade			-- �����̵� ��Ƽ		3
g_tCM_PlaceName[5] 	= String_Fight				-- ���� ��������		4
g_tCM_PlaceName[6] 	= String_Fight				-- ���� ����			5
g_tCM_PlaceName[7] 	= String_Fight.." /\n"..String_Arcade		-- �޺���				6
g_tCM_PlaceName[8] 	= String_Fight.." /\n"..String_Arcade		-- ����				7
g_tCM_PlaceName[9] 	= String_Fight.." /\n"..String_Arcade		-- ȸ�Ǽ�				8
g_tCM_PlaceName[10]	= String_Fight.." /\n"..String_Arcade		-- ������ü�			9
g_tCM_PlaceName[11]	= String_Fight.." /\n"..String_Arcade		-- �����ü�				10
g_tCM_PlaceName[12]	= String_Fight				-- �¸���				11
g_tCM_PlaceName[13]	= String_Fight				-- mvp					12
g_tCM_PlaceName[14]	= String_Fight				-- ���� 1��				13
g_tCM_PlaceName[15]	= String_Arcade			-- �����̵� 4����Ƽ		14
g_tCM_PlaceName[16]	= String_Arcade			-- �����̵� ����� SRankŬ�����	15


g_tCM_DescName = { ["protecterr"]=0, }
g_tCM_DescName[1] 	= PreCreateString_1062	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_5)	--"���� / �����̵忡�� KO�� "
g_tCM_DescName[2] 	= PreCreateString_1063	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_6)	--"���� / �����̵忡�� DOWN�� "
g_tCM_DescName[3] 	= PreCreateString_1064	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_7)	--"�����̵� ������ "
g_tCM_DescName[4] 	= PreCreateString_1065	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_8)	--"���忡�� ��Ƽ�� ���� �� �����̵带 "
g_tCM_DescName[5] 	= PreCreateString_1066	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_9)	--"�������� ���������� "
g_tCM_DescName[6] 	= PreCreateString_1067	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_10)	--"�������� ������ "
g_tCM_DescName[7] 	= PreCreateString_1068	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_11)	--"���� / �����̵忡�� �޺��� "
g_tCM_DescName[8] 	= PreCreateString_1069	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_12)	--"���� / �����̵忡�� ��⸦ "
g_tCM_DescName[9] 	= PreCreateString_1070	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_13)	--"���� / �����̵忡�� ȸ�Ǹ� "
g_tCM_DescName[10]	= PreCreateString_1071	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_14)	--"���� / �����̵忡�� ������ø� "
g_tCM_DescName[11]	= PreCreateString_1072	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_15)	--"���� / �����̵忡�� �����ü��� "
g_tCM_DescName[12]	= PreCreateString_1073	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_16)	--"�������� �¸��� "
g_tCM_DescName[13]	= PreCreateString_1074	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_17)	--"�������� MVP�� "
g_tCM_DescName[14]	= PreCreateString_1075	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_18)	--"�������� 1���� "
g_tCM_DescName[15]	= PreCreateString_1076	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_19)	--"���忡�� 4�� ��Ƽ�� �Ͻ� �� �����̵带 "
g_tCM_DescName[16]	= PreCreateString_1077	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_20)	--"�����̵忡�� SRankŬ��� "


local String_Count	= PreCreateString_1078	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_21)	-- "ȸ �ϼ���"

-- ç���� �̼� ������ �������ش�.
function CM_DescReturn(Index, Count)
	local String = ""
	
	String = g_tCM_DescName[Index]..string.format(String_Count, Count)
	String = AdjustString(g_STRING_FONT_GULIMCHE, 12, String, 380)
	
	return String
end
