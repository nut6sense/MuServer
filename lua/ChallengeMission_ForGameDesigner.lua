
--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
g_String_Normal		= PreCreateString_1027	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_10)		-- 일반
g_String_Playing	= PreCreateString_1030	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_13)		-- 진행중
g_String_Complete	= PreCreateString_1029	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_12)		-- 완료
g_String_NotPlaying	= PreCreateString_1028	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_11)		-- 진행불가
local String_Fight	= PreCreateString_1060	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_3)	-- 대전
local String_Arcade	= PreCreateString_1061	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_4)	-- 아케이드


----------------------------------------------------------

-- 기본 챌린지 미션

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
g_tChapterName[1] = PreCreateString_1058	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_1)	--"챕터1. 체험하라"
g_tChapterName[2] = PreCreateString_1059	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_2)	--"챕터2. 달성하라"


g_tCM_PlaceName = { ["protecterr"]=0, }
g_tCM_PlaceName[1] 	= String_Fight.." /\n"..String_Arcade		-- KO수					0
g_tCM_PlaceName[2] 	= String_Fight.." /\n"..String_Arcade		-- DOWN수				1
g_tCM_PlaceName[3] 	= String_Arcade			-- 아케이드 성공		2
g_tCM_PlaceName[4] 	= String_Arcade			-- 아케이드 파티		3
g_tCM_PlaceName[5] 	= String_Fight				-- 대전 아이템전		4
g_tCM_PlaceName[6] 	= String_Fight				-- 대전 팀전			5
g_tCM_PlaceName[7] 	= String_Fight.." /\n"..String_Arcade		-- 콤보수				6
g_tCM_PlaceName[8] 	= String_Fight.." /\n"..String_Arcade		-- 잡기수				7
g_tCM_PlaceName[9] 	= String_Fight.." /\n"..String_Arcade		-- 회피수				8
g_tCM_PlaceName[10]	= String_Fight.." /\n"..String_Arcade		-- 더블어택수			9
g_tCM_PlaceName[11]	= String_Fight.." /\n"..String_Arcade		-- 팀어택수				10
g_tCM_PlaceName[12]	= String_Fight				-- 승리수				11
g_tCM_PlaceName[13]	= String_Fight				-- mvp					12
g_tCM_PlaceName[14]	= String_Fight				-- 대전 1등				13
g_tCM_PlaceName[15]	= String_Arcade			-- 아케이드 4인파티		14
g_tCM_PlaceName[16]	= String_Arcade			-- 아케이드 어려움 SRank클리어수	15


g_tCM_DescName = { ["protecterr"]=0, }
g_tCM_DescName[1] 	= PreCreateString_1062	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_5)	--"대전 / 아케이드에서 KO를 "
g_tCM_DescName[2] 	= PreCreateString_1063	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_6)	--"대전 / 아케이드에서 DOWN을 "
g_tCM_DescName[3] 	= PreCreateString_1064	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_7)	--"아케이드 성공을 "
g_tCM_DescName[4] 	= PreCreateString_1065	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_8)	--"광장에서 파티를 맺은 후 아케이드를 "
g_tCM_DescName[5] 	= PreCreateString_1066	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_9)	--"대전에서 아이템전을 "
g_tCM_DescName[6] 	= PreCreateString_1067	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_10)	--"대전에서 팀전을 "
g_tCM_DescName[7] 	= PreCreateString_1068	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_11)	--"대전 / 아케이드에서 콤보를 "
g_tCM_DescName[8] 	= PreCreateString_1069	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_12)	--"대전 / 아케이드에서 잡기를 "
g_tCM_DescName[9] 	= PreCreateString_1070	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_13)	--"대전 / 아케이드에서 회피를 "
g_tCM_DescName[10]	= PreCreateString_1071	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_14)	--"대전 / 아케이드에서 더블어택를 "
g_tCM_DescName[11]	= PreCreateString_1072	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_15)	--"대전 / 아케이드에서 팀어택수를 "
g_tCM_DescName[12]	= PreCreateString_1073	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_16)	--"대전에서 승리를 "
g_tCM_DescName[13]	= PreCreateString_1074	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_17)	--"대전에서 MVP를 "
g_tCM_DescName[14]	= PreCreateString_1075	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_18)	--"대전에서 1등을 "
g_tCM_DescName[15]	= PreCreateString_1076	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_19)	--"광장에서 4인 파티를 하신 후 아케이드를 "
g_tCM_DescName[16]	= PreCreateString_1077	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_20)	--"아케이드에서 SRank클리어를 "


local String_Count	= PreCreateString_1078	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_21)	-- "회 하세요"

-- 챌린지 미션 설명을 리턴해준다.
function CM_DescReturn(Index, Count)
	local String = ""
	
	String = g_tCM_DescName[Index]..string.format(String_Count, Count)
	String = AdjustString(g_STRING_FONT_GULIMCHE, 12, String, 380)
	
	return String
end
