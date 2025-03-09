
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")




-------------------------------------------------------

--	파티관련 정보들

-------------------------------------------------------
PM_String_InviteUserSelect				= PreCreateString_1100	--GetSStringInfo(LAN_LUA_PARTY_MATCH_1)		-- 초대할 유저를 선택해 주세요.
PM_String_PartyJoinUser					= PreCreateString_1101	--GetSStringInfo(LAN_LUA_PARTY_MATCH_2)		-- %s님이 파티에 합류하였습니다.
PM_String_PartyLeaveUser				= PreCreateString_1102	--GetSStringInfo(LAN_LUA_PARTY_MATCH_3)		-- %s님이 파티에서 탈퇴 하였습니다.
PM_String_AlreadyPartyInclude			= PreCreateString_1103	--GetSStringInfo(LAN_LUA_PARTY_MATCH_4)		-- 이미 파티에 속해 있습니다.
PM_String_Send_PartyInviteMsg			= PreCreateString_1104	--GetSStringInfo(LAN_LUA_PARTY_MATCH_5)		-- %s님께 파티신청 메세지를 보냈습니다.
PM_String_Send_PartyInviteMsg_forChat	= PreCreateString_2700	--GetSStringInfo(LAN_LUA_PARTY_MATCH_55)	-- %s님께 파티신청 메세지를 보냈습니다.
PM_String_Refuse_PartyInvite			= PreCreateString_1105	--GetSStringInfo(LAN_LUA_PARTY_MATCH_6)		-- %s님의 파티초대를 거절 하였습니다.
PM_String_PartyInviteMsgOk				= PreCreateString_1106	--GetSStringInfo(LAN_LUA_PARTY_MATCH_7)		-- %s님이\n파티에 초대하셨습니다.\n수락하시겠습니까?
PM_String_Receive_PartyInviteMsg		= PreCreateString_1107	--GetSStringInfo(LAN_LUA_PARTY_MATCH_8)		-- %s님에게서 파티초대 요청을 받았습니다.
PM_String_Refuse_User_PartyInvite		= PreCreateString_1108	--GetSStringInfo(LAN_LUA_PARTY_MATCH_9)		-- %s님이\n파티초대를 거절하였습니다.
PM_String_Refuse_User_PartyInvite2		= PreCreateString_1109	--GetSStringInfo(LAN_LUA_PARTY_MATCH_10)	-- %s님이 파티초대를 거절하였습니다.
PM_String_User_PartyJoinOKMsg			= PreCreateString_1110	--GetSStringInfo(LAN_LUA_PARTY_MATCH_11)	-- %s님이\n파티참가를 희망합니다.\n수락하시겠습니까?
PM_String_User_PartyJoinRequest			= PreCreateString_1111	--GetSStringInfo(LAN_LUA_PARTY_MATCH_12)	-- %s님이 파티참가를 요청하였습니다.
PM_String_Refuse_PartyRequest			= PreCreateString_1112	--GetSStringInfo(LAN_LUA_PARTY_MATCH_13)	-- 파티신청을 거절하였습니다.
PM_String_Refused_PartyRequest			= PreCreateString_1113	--GetSStringInfo(LAN_LUA_PARTY_MATCH_14)	-- 파티신청이 거절당하였습니다.
PM_String_Ban_Party						= PreCreateString_1114	--GetSStringInfo(LAN_LUA_PARTY_MATCH_15)	-- 방장에 의해 강퇴 당하셨습니다.
PM_String_None_User_Square				= PreCreateString_1115	--GetSStringInfo(LAN_LUA_PARTY_MATCH_16)	-- 광장에 없는 유저입니다.
PM_String_AlreadyPartyUser				= PreCreateString_1116	--GetSStringInfo(LAN_LUA_PARTY_MATCH_17)	-- 이미 파티중인 유저입니다.
PM_String_Full_PartyMember				= PreCreateString_1117	--GetSStringInfo(LAN_LUA_PARTY_MATCH_18)	-- 파티정원이 초과하였습니다.
PM_String_Master_InviteParty			= PreCreateString_1118	--GetSStringInfo(LAN_LUA_PARTY_MATCH_19)	-- 방장만 초대할 수 있습니다.
PM_String_Join_UserParty				= PreCreateString_1830	--GetSStringInfo(LAN_LUA_PARTY_MATCH_20)	-- %s님의 파티에 합류하였습니다.
PM_String_Refuse_PartyRequest_User		= PreCreateString_1831	--GetSStringInfo(LAN_LUA_PARTY_MATCH_21)	-- %s님의 파티신청을 거절하였습니다.
PM_String_Send_PartyInviteMsg_User		= PreCreateString_1832	--GetSStringInfo(LAN_LUA_PARTY_MATCH_22)	-- %s님께 파티초대 메세지를 보냈습니다.
PM_String_Input_Create_PartyName		= PreCreateString_1833	--GetSStringInfo(LAN_LUA_PARTY_MATCH_23)	-- 생성할 파티이름을 입력해주세요.
PM_String_PartyChangeOwner				= PreCreateString_1083	--GetSStringInfo(LAN_LUA_CHANGEJOB_5)		-- %s님으로\n파티장이 변경되었습니다.
PM_String_PartyChangeType				= PreCreateString_1084	--GetSStringInfo(LAN_LUA_CHANGEJOB_6)		-- %s(으)로\n파티구분이 변경되었습니다.
PM_String_LevelUpEvent					= PreCreateString_2230	--GetSStringInfo(LAN_CONGRATULATION_LEVEL_UP)		-- 레벨업을 축하합니다


g_PARTY_TYPE_PREPARING		= PreCreateString_1878	--GetSStringInfo(LAN_LUA_PARTY_1)						-- 준비중
g_PARTY_TYPE_BATTLE			= PreCreateString_1060	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_3)	-- 대전
g_PARTY_TYPE_PARK			= PreCreateString_1501	--GetSStringInfo(LAN_CPP_QUEST_RESULT_3)				-- 공원
g_PARTY_TYPE_HOTEL			= PreCreateString_1500	--GetSStringInfo(LAN_CPP_QUEST_RESULT_2)				-- 호텔
g_PARTY_TYPE_HALEM			= PreCreateString_1502	--GetSStringInfo(LAN_CPP_QUEST_RESULT_4)				-- 할렘
g_PARTY_TYPE_HROAED			= PreCreateString_1879	--GetSStringInfo(LAN_LUA_PARTY_2)						-- H.로드
g_PARTY_TYPE_SUBWAY			= PreCreateString_2328	--GetSStringInfo(LAN_LUA_PARTY_3)						-- 서브웨이
g_PARTY_TYPE_PRACTICE		= PreCreateString_2632	--GetSStringInfo(LAN_LUA_PARTY_PRACTICE )	            -- 사냥터
g_PARTY_TYPE_CENTER			= PreCreateString_2633	--GetSStringInfo(LAN_LUA_PARTY_BY_CENTER )	            -- 사냥터
g_PARTY_TYPE_FIGHT			= PreCreateString_2634	--GetSStringInfo(LAN_LUA_PARTY_FIGHT )					-- 사냥터
g_PARTY_TYPE_AGIT			= PreCreateString_2635	--GetSStringInfo(LAN_LUA_PARTY_AGIT )					-- 사냥터
g_PARTY_TYPE_CLOSESUBWAY	= PreCreateString_2636	--GetSStringInfo(LAN_LUA_PARTY_HUNTINGSUBWAY )	        -- 사냥터
g_PARTY_TYPE_ARCADETEMPLE	= PreCreateString_2701	--GetSStringInfo(LAN_LUA_PARTY_ARCADE_TEMPLE )	        -- 차이나 아케이드 템플
g_PARTY_TYPE_HUNTINGTEMPLE	= PreCreateString_2702	--GetSStringInfo(LAN_LUA_PARTY_HUNTING_TEMPLE  )		-- 차이나 사냥터 템플
g_PARTY_TYPE_HUNTINGFIELD	= PreCreateString_2538	--GetSStringInfo(LAN_LUA_PARTY_HUNTING )				-- 사냥터 
g_PARTY_TYPE_ARCADE			= PreCreateString_1061	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_4 )	-- 아케이드
g_PARTY_TYPE_NOT_DIVISION		 = PreCreateString_3063	--GetSStringInfo(LAN_PARTY_NOT_DIVISION )			-- 분배안함
g_PARTY_TYPE_EQUALITY_DIVISION   = PreCreateString_3064	--GetSStringInfo(LAN_PARTY_EQUALITY_DIVISION )		-- 균등분배
g_PARTY_TYPE_ORDER_DIVISION		 = PreCreateString_3065	--GetSStringInfo(LAN_PARTY_ORDER_DIVISION )		-- 순차획득
g_PARTY_TYPE_RANDOM_DIVISION     = PreCreateString_3066	--GetSStringInfo(LAN_PARTY_RANDOM_DIVISION)		-- 랜덤획득
g_PARTY_TYPE_HARD_ARCADE		= PreCreateString_5336	--GetSStringInfo(LAN_LUA_PARTY_HARD)		-- 랜덤획득
		
		
-- 위치목록
tStringByPartyTypePos = {['err']=0, 
[0]=g_PARTY_TYPE_ARCADE,
[1]=g_PARTY_TYPE_HUNTINGFIELD,
[2]=g_PARTY_TYPE_HARD_ARCADE
}

-- 아이템 분배
tStringByPartyItemType = {['err']=0, 
[0]=g_PARTY_TYPE_NOT_DIVISION,
[1]=g_PARTY_TYPE_ORDER_DIVISION,
[2]=g_PARTY_TYPE_RANDOM_DIVISION
}

-- 경험치 분배
tStringByPartyExpType = {['err']=0, 
[0]=g_PARTY_TYPE_NOT_DIVISION,
[1]=g_PARTY_TYPE_EQUALITY_DIVISION
}

-- 파티목록(파티구분에서 보여질 이름, 아케이드 번호순) : 준비중, 대전, 호텔, 공원, 할렘, H.로드, 서브웨이
tStringByPartyType = {['err']=0, 
[0]=g_PARTY_TYPE_PREPARING, 
[1]=g_PARTY_TYPE_BATTLE, 
[2]=g_PARTY_TYPE_PARK,
[3]=g_PARTY_TYPE_HOTEL, 
[4]=g_PARTY_TYPE_HALEM, 
[5]=g_PARTY_TYPE_HROAED,
[6]=g_PARTY_TYPE_SUBWAY,
[7]=g_PARTY_TYPE_PRACTICE,
[8]=g_PARTY_TYPE_CENTER,
[9]=g_PARTY_TYPE_FIGHT,
[10]=g_PARTY_TYPE_AGIT,
[11]=g_PARTY_TYPE_CLOSESUBWAY,
[12]=g_PARTY_TYPE_ARCADETEMPLE,
[13]=g_PARTY_TYPE_HUNTINGTEMPLE
}


-- 파티목록(파티구분에서 보여질 색상) : 준비중, 대전, 호텔, 공원, 할렘, H.로드, 서브웨이
tColorOfPartyType = {["err"]=0,  
[0]={["err"]=0, 255,255,255},	
[1]={["err"]=0,   7,170,193}, 
[2]={["err"]=0, 197, 16,218}, 
[3]={["err"]=0,  40,192,  0},
[4]={["err"]=0, 232,208,  0},
[5]={["err"]=0, 255,135,  0},
[6]={["err"]=0, 50,	50,	255},
[7]={["err"]=0, 50,	150,255},
[8]={["err"]=0, 50,	150,255},
[9]={["err"]=0, 50,	150,255},
[10]={["err"]=0, 50, 150,255},
[11]={["err"]=0, 50, 150,255},
[12]={["err"]=0, 197, 16,218},
[13]={["err"]=0, 50, 150, 255}
}

tColorOfPartyPosType = {["err"]=0,  
[0]={["err"]=0, 255,187,0},	
[1]={["err"]=0,   7,170,193}, 
[2]={["err"]=0,   209,6,6}, 
}


-------------------------------------------------------

--	파티 왼쪽 나의 정보

-------------------------------------------------------

-- 파티 뉴 수정
-- 파티 나의 얼굴 배경창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfo')
mywindow:setPosition(4, 4)
mywindow:setSize(244, 86)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 0, 426)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(true)
winMgr:registerCacheWindow('PartyMyInfo')

-- 파티 나의 얼굴 이미지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'BigCharAbata')
mywindow:setPosition(5, 5)
mywindow:setSize(78, 96)
mywindow:setScaleWidth(200)
mywindow:setScaleHeight(200)
mywindow:setTexture('Enabled', 'UIData/GameImage.tga', 0, 0)
mywindow:setTexture('Disabled', 'UIData/GameImage.tga', 0, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('BigCharAbata')

-- 파티 나의 게이지 배경창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoGage')
mywindow:setPosition(98, 4)
mywindow:setSize(180, 54)
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 94, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyMyInfoGage')

-- 파티 나의 HP 게이지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoGageHP')
mywindow:setPosition(73, 4)
mywindow:setSize(167, 9)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 244, 431)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyMyInfoGageHP')

-- 파티 나의 SP 게이지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoGageSP')
mywindow:setPosition(72, 21)
mywindow:setSize(167, 9)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 244, 441)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyMyInfoGageSP')


-- 파티 나의 Q/W/E 이미지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoQWE')
mywindow:setPosition(70, 35)
mywindow:setSize(62, 18)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 426, 243)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyMyInfoQWE')


-- 파티 나의 마스터 그림
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoMaster')
mywindow:setPosition(1, 82)
mywindow:setSize(75, 24)
mywindow:setTexture('Enabled', 'UIData/battleroom001.tga', 136, 837)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow('PartyMyInfoMaster')

-- 파티 나의 이름
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyMyInfoName')
mywindow:setPosition(3, 86);
mywindow:setSize(89, 22);
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,200,80,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setUserString("characterName", 0)
winMgr:registerCacheWindow('PartyMyInfoName')

-- 파티 분배방식
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyMyInfoDistribute')
mywindow:setPosition(75, 55)
mywindow:setSize(174, 29)
mywindow:setTexture('Enabled', 'UIData/mainBG_button004.tga', 0, 302)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow('PartyMyInfoDistribute')

-- 파티 아이템 분배방식
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyMyInfoDistributeItem')
mywindow:setPosition(25, 150);
mywindow:setSize(89, 22);
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,200,80,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyMyInfoDistributeItem')

-- 파티 경험치 분배방식
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyMyInfoDistributeExp')
mywindow:setPosition(110, 150);
mywindow:setSize(89, 22);
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,200,80,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyMyInfoDistributeExp')

-------------------------------------------------------

--	1번째 파티원 정보

-------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo1')
mywindow:setPosition(3, 110)
mywindow:setSize(145, 60)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 0, 366)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
mywindow:setUserString("lifeNum", 0)
winMgr:registerCacheWindow('PartyInfo1')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo1SmallCharAbata')
mywindow:setPosition(4, 6)
mywindow:setSize(46, 46)
mywindow:setTexture('Enabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setTexture('Disabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo1SmallCharAbata')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo1HPGage')
mywindow:setPosition(54, 19)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 362)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo1HPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo1SPGage')
mywindow:setPosition(54, 30)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 378)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo1SPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo1Master')
mywindow:setPosition(5, 45)
mywindow:setSize(46, 17)
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 967, 66)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo1Master')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo1Level')
mywindow:setPosition(13, 10)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo1Level')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo1Name')
mywindow:setPosition(65, 8)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setUserString("characterName", 0)
winMgr:registerCacheWindow('PartyInfo1Name')

-- 10. 유저 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo1ArcadeTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 590, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",590, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(54, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo1ArcadeTicketImage')

-- 11. 유저 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo1ArcadeTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(75, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo1ArcadeTicketCount')

-- 12. 유저 Hard 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo1ArcadeHardTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 609, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",609, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(84, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo1ArcadeHardTicketImage')

-- 12. 유저 Hard 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo1ArcadeHardTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(132, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo1ArcadeHardTicketCount')

-------------------------------------------------------

--	2번째 파티원 정보

-------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo2')
mywindow:setPosition(3, 170)
mywindow:setSize(146, 57)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 0, 366)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
mywindow:setUserString("lifeNum", 0)
winMgr:registerCacheWindow('PartyInfo2')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo2SmallCharAbata')
mywindow:setPosition(4, 6)
mywindow:setSize(46, 46)
mywindow:setTexture('Enabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setTexture('Disabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo2SmallCharAbata')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo2HPGage')
mywindow:setPosition(54, 19)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 362)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo2HPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo2SPGage')
mywindow:setPosition(54, 30)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 378)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo2SPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo2Master')
mywindow:setPosition(5, 45)
mywindow:setSize(46, 17)
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 967, 66)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo2Master')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo2Level')
mywindow:setPosition(13, 10)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo2Level')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo2Name')
mywindow:setPosition(65, 8)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setUserString("characterName", 0)
winMgr:registerCacheWindow('PartyInfo2Name')

-- 10. 유저 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo2ArcadeTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 590, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",590, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(54, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo2ArcadeTicketImage')

-- 11. 유저 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo2ArcadeTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(75, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo2ArcadeTicketCount')

-- 10. 유저 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo2ArcadeHardTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 609, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",609, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(84, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo2ArcadeHardTicketImage')

-- 12. 유저 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo2ArcadeHardTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(132, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo2ArcadeHardTicketCount')

-------------------------------------------------------

--	3번째 파티원 정보

-------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo3')
mywindow:setPosition(3, 230)
mywindow:setSize(146, 57)
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 0, 366)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
mywindow:setUserString("lifeNum", 0)
winMgr:registerCacheWindow('PartyInfo3')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo3SmallCharAbata')
mywindow:setPosition(4, 6)
mywindow:setSize(46, 46)
mywindow:setTexture('Enabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setTexture('Disabled', 'UIData/GameImage.tga', 0, 594)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo3SmallCharAbata')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo3HPGage')
mywindow:setPosition(54, 19)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 362)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo3HPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo3SPGage')
mywindow:setPosition(54, 30)
mywindow:setSize(83, 8)
mywindow:setTexture('Enabled',  'UIData/mainBG_Button004.tga', 145, 378)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo3SPGage')

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PartyInfo3Master')
mywindow:setPosition(5, 45)
mywindow:setSize(46, 17)
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 967, 66)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setVisible(false)
winMgr:registerCacheWindow('PartyInfo3Master')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo3Level')
mywindow:setPosition(13, 10)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
winMgr:registerCacheWindow('PartyInfo3Level')

mywindow = winMgr:createWindow('TaharezLook/StaticText', 'PartyInfo3Name')
mywindow:setPosition(65, 8)
mywindow:setSize(5, 5)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setUserString("characterName", 0)
winMgr:registerCacheWindow('PartyInfo3Name')

-- 10. 유저 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo3ArcadeTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 590, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",590, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(54, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo3ArcadeTicketImage')

-- 11. 유저 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo3ArcadeTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(75, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo3ArcadeTicketCount')


-- 10. 유저 티켓 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PartyInfo3ArcadeHardTicketImage")
mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 609, 702)
mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",609, 702)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")

mywindow:setPosition(84, 40)
mywindow:setSize(19, 17)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('PartyInfo3ArcadeHardTicketImage')

-- 12. 유저 티켓 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PartyInfo3ArcadeHardTicketCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setPosition(132, 32)
mywindow:setSize(170, 36)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('PartyInfo3ArcadeHardTicketCount')

-------------------------------------------------------

--	파티타입을 변경하는 창(마스터일 경우만 가능)

-------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Avarta_BackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(6, 130)
--mywindow:setAlwaysOnTop(true)
mywindow:setSize(90, 420)
mywindow:setVisible(false)
winMgr:registerCacheWindow("sjParty_Avarta_BackImage")

-- (파티구분 창)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Avarta_TypeWindow")
mywindow:setTexture("Enabled", "UIData/party001.tga", 934, 105)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(90, 31)
winMgr:registerCacheWindow("sjParty_Avarta_TypeWindow")

-- (파티구분 창 화살표)
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Avarta_TypeWindow_btn")
mywindow:setTexture("Normal", "UIData/party001.tga", 92, 585)
mywindow:setTexture("Hover", "UIData/party001.tga", 92, 603)
mywindow:setTexture("Pushed", "UIData/party001.tga", 92, 621)
mywindow:setTexture("PushedOff", "UIData/party001.tga", 92, 585)
mywindow:setPosition(70, 5)
mywindow:setSize(18, 18)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyTypeForSelect_Avarta")
winMgr:registerCacheWindow("sjParty_Avarta_TypeWindow_btn")

-- (파티구분 선택된 내용)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_Avarta_TypeWindow_SelectText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(16, 8)
mywindow:setSize(40, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
winMgr:registerCacheWindow("sjParty_Avarta_TypeWindow_SelectText")

-- (파티구분 세부사항을 넣기위한 투명공간)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Avarta_TypeWindow_tempImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 31)
mywindow:setSize(90, 420)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("sjParty_Avarta_TypeWindow_tempImage")

--[[
-- 파티구분에서 선택할 내용들
tSelectRadioBtName_avarta	= {['err']=0, [0]="sjParty_Avarta_Type_ready", "sjParty_Avarta_Type_battle", "sjParty_Avarta_Type_park", 
											  "sjParty_Avarta_Type_hotel", "sjParty_Avarta_Type_halem", "sjParty_Avarta_Type_HRoad",
											  "sjParty_Avarta_Type_Subway" ,"sjParty_Avarta_Type_Practice", "sjParty_Avarta_Type_Center",
											  "sjParty_Avarta_Type_Fight", "sjParty_Avarta_Type_Agit" , "sjParty_Avarta_Type_CloseSubway",
											  "sjParty_Avarta_Type_ArcadeTemple", "sjParty_Avarta_Type_HuntingKupu"}
											  
tSelectRadioTexY_avarta		= {['err']=0, [0]=136, 136, 136, 136, 136, 136, 136, 136, 136, 136,136, 136, 136, 167}	-- 항상 마지막이 167이므로 추가는 이전에 한다.
for i=0, #tSelectRadioBtName_avarta do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tSelectRadioBtName_avarta[i])
	mywindow:setTexture("Normal", "UIData/party001.tga", 934, tSelectRadioTexY_avarta[i])
	mywindow:setTexture("Hover", "UIData/party001.tga", 934, 198)
	mywindow:setTexture("Pushed", "UIData/party001.tga", 934, 198)
	mywindow:setTexture("Disabled", "UIData/party001.tga", 934, tSelectRadioTexY_avarta[i])
	mywindow:setPosition(0, i*31)
	mywindow:setProperty("GroupID", 7211)
	mywindow:setSize(90, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectPartyType_Avarta")
	winMgr:registerCacheWindow(tSelectRadioBtName_avarta[i])
	
	-- 파티구분 내용들
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tSelectRadioBtName_avarta[i].."text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(22, 8)
	mywindow:setSize(40, 31)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	
	if i > 6 then
		mywindow:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 11, 
		tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,   0, 255,255,255,255)
	end
	winMgr:registerCacheWindow(tSelectRadioBtName_avarta[i].."text")
end

--]]



--------------------------------------------------------------------

-- 팝업창

--------------------------------------------------------------------
tPopupContainerName  = {["err"]=0, "pu_btnContainer", "pu_TopImage", "pu_BottomImage"}
tPopupContainerTexName = {["err"]=0, "invisible", "messenger", "messenger"}
tPopupContainerTexX	 = {['err'] = 0, 394, 0, 0}
tPopupContainerTexY	 = {['err'] = 0, 0, 311, 311}
tPopupContainerPosX	 = {['err'] = 0, 0, 0, 0}
tPopupContainerPosY	 = {['err'] = 0, 0, 0, 250}
tPopupContainerSizeX = {['err'] = 0, 94, 94, 94}
tPopupContainerSizeY = {['err'] = 0, 280, 2, 2}

for i=1, #tPopupContainerName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tPopupContainerName[i])
	mywindow:setTexture("Enabled", "UIData/"..tPopupContainerTexName[i]..".tga",	tPopupContainerTexX[i], tPopupContainerTexY[i])
	mywindow:setTexture("Disabled", "UIData/"..tPopupContainerTexName[i]..".tga", tPopupContainerTexX[i], tPopupContainerTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tPopupContainerPosX[i], tPopupContainerPosY[i])
	mywindow:setSize(tPopupContainerSizeX[i], tPopupContainerSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:registerCacheWindow(tPopupContainerName[i]);
end



mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'pu_windowName');
mywindow:setPosition(773, 32);
mywindow:setSize(94, 22);
mywindow:setTexture('Enabled', 'UIData/messenger.tga', 530, 406);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
winMgr:registerCacheWindow('pu_windowName');


mywindow = winMgr:createWindow('TaharezLook/StaticText', 'pu_name_text');
mywindow:setPosition(0, 0);
mywindow:setSize(94, 22);
mywindow:setAlign(7);
mywindow:setViewTextMode(1);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setProperty('Text', 'test3');
winMgr:registerCacheWindow('pu_name_text');

		
tPopupButtonName =
{ ["protecterr"]=0, "pu_showInfo", "pu_inviteParty", "pu_addFriend", "pu_deleteFriend", "pu_myInfo", 
					"pu_privatChat", "pu_deal", "pu_raising", "pu_profile", "pu_clubUserBan", 
					"pu_vanishParty", "pu_chatToUser", "pu_partySecession", "pu_partyCommission", 
					"pu_watchEquipment" , "pu_createParty", "pu_reportuser", "pu_singleMatch", "pu_battleObserve", "pu_blockUser", "pu_unBlockUser"}
					
--nOffsetY = 22

for i=1, #tPopupButtonName do
	--local DevideX = i / 15
	--local DevideY = (i-1) % 15
	
	local UiPosX  = 0
	local UiCount = i
	
	if i >= 15 then
		UiPosX	= 376
		UiCount = UiCount - 14
	end
	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",		tPopupButtonName[i])
	mywindow:setTexture("Disabled",			"UIData/messenger.tga",	UiPosX+282, 22*(UiCount)-22)
	mywindow:setTexture("Normal",			"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("Hover",			"UIData/messenger.tga",	UiPosX+94,	22*(UiCount)-22)
	mywindow:setTexture("Pushed",			"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("PushedOff",		"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("SelectedNormal",	"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("SelectedHover",	"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("SelectedPushed",	"UIData/messenger.tga",	UiPosX,		22*(UiCount)-22)
	mywindow:setTexture("SelectedPushedOff","UIData/messenger.tga", UiPosX,		22*(UiCount)-22)
	mywindow:setSize(94, 22)
	mywindow:setPosition(0, 0)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedUserPopup")
	winMgr:registerCacheWindow(tPopupButtonName[i])
	
	--[[
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tPopupButtonName[i])
	mywindow:setTexture("Disabled", "UIData/messenger.tga",		282 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("Normal", "UIData/messenger.tga",		0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("Hover", "UIData/messenger.tga",		94 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("Pushed", "UIData/messenger.tga",		0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("PushedOff", "UIData/messenger.tga",	0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("SelectedNormal", "UIData/messenger.tga",	 0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("SelectedHover", "UIData/messenger.tga",	 0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("SelectedPushed", "UIData/messenger.tga",	 0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setTexture("SelectedPushedOff", "UIData/messenger.tga", 0 + (DevideX * 376), nOffsetY*DevideY)
	mywindow:setSize(94, 22)
	mywindow:setPosition(0, nOffsetY*DevideY)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedUserPopup")
	winMgr:registerCacheWindow(tPopupButtonName[i])
	--]]
end





--------------------------------------------------------------------

-- 메신져 관련 윈도우

--------------------------------------------------------------------


--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_messenger_titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(330, 26)
--winMgr:registerCacheWindow('sj_messenger_titlebar')

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_messengerBackWindow")
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(377, 149)
mywindow:setSize(271, 404)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow('sj_messengerBackWindow')

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "bj_messengerBackWindow")
mywindow:setTexture("Enabled", "UIData/messenger4.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/messenger4.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setPosition(377, 149)
mywindow:setPosition(0, 0)
mywindow:setSize(375, 502)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
--mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow('bj_messengerBackWindow')

mywindow = winMgr:createWindow("TaharezLook/StaticText", 'FriendListNumText');
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setPosition(160, 65)
mywindow:setSize(53, 20);
mywindow:setVisible(true);
winMgr:registerCacheWindow('FriendListNumText')

mywindow = winMgr:createWindow("TaharezLook/StaticText", 'BestFriendListNumText');
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setPosition(300, 65)
mywindow:setSize(53, 20);	
mywindow:setVisible(true);
winMgr:registerCacheWindow('BestFriendListNumText')


--메신저 친구목록 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_messenger_listWindow")
mywindow:setTexture("Enabled",	"UIData/messenger4.tga", 358, 0)
mywindow:setTexture("Disabled", "UIData/messenger4.tga", 358, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(14, 133)
--mywindow:setSize(338, 258)
mywindow:setSize(338, 380)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('sj_messenger_listWindow')



-- 대화 백판.
mywindow = winMgr:createWindow( "TaharezLook/StaticImage", 'sj_messenger_chatBackWindow_1' )
mywindow:setTexture("Enabled", "UIData/messenger4.tga", 0, 438)
mywindow:setTexture("Disabled", "UIData/messenger4.tga", 0, 438)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(13, 123)
mywindow:setSize(340, 360)  --크기수정
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('sj_messenger_chatBackWindow_1')


local g_LeftPos = 7

--메신저 제목바 쓰이지 않을 것
tWinName = {['err'] = 0,		    "sj_allDesc", "sj_clucDesc", "sj_ladderGradeDesc" }
tTextureX = {['err'] = 0,		   692,        847,       899 }
tTextureY = {['err'] = 0,		   820,	       791,	      791 }
tTextureSizeX = {['err'] = 0,	   252,         43,        43 }
tTextureSizeY = {['err'] = 0,		17,	        23,	       23 }
tPosX = {['err'] = 0,		 g_LeftPos,        227,       227 }
tPosY = {['err'] = 0,			    8,	         0,	        0 }
for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i])
	mywindow:setTexture("Enabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Disabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setSize(tTextureSizeX[i], tTextureSizeY[i])
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow(tWinName[i])
end


--------------------------------------------------------------------------------------------------------------------------------
-- 친구 클럽 대화창 탭
--------------------------------------------------------------------------------------------------------------------------------
--tWinName		= {['err'] = 0,	"sj_tab_friend", "chat_tab_best_friend","sj_tab_club", "sj_tab_chat"}
tWinName		= {['err'] = 0,	"sj_tab_friend","sj_tab_club", "sj_tab_chat"}
tTextureX		= {['err'] = 0,	612, 729, 846}
tEventHandler	= {['err'] = 0, "OnSelected_FriendTap", "OnSelected_GuildTab", "OnSelected_ChatTab"}
tMessengerPosX	= {["err"] = 0, 10, 125, 240}

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinName[i])
	mywindow:setTexture("Normal",				"UIData/messenger4.tga", tTextureX[i], 469)
	mywindow:setTexture("Hover",				"UIData/messenger4.tga", tTextureX[i], 438)
	mywindow:setTexture("Pushed",				"UIData/messenger4.tga", tTextureX[i], 500)
	mywindow:setTexture("PushedOff",			"UIData/messenger4.tga", tTextureX[i], 531)
	
	mywindow:setTexture("SelectedNormal",		"UIData/messenger4.tga", tTextureX[i], 438)
	mywindow:setTexture("SelectedHover",		"UIData/messenger4.tga", tTextureX[i], 438)
	mywindow:setTexture("SelectedPushed",		"UIData/messenger4.tga", tTextureX[i], 438)
	mywindow:setTexture("SelectedPushedOff",	"UIData/messenger4.tga", tTextureX[i], 438)
	mywindow:setTexture("Disabled",				"UIData/messenger4.tga", tTextureX[i], 531)
	mywindow:setSize(114, 31)
	mywindow:setPosition(tMessengerPosX[i], 89)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("SelectStateChanged", tEventHandler[i])
	winMgr:registerCacheWindow(tWinName[i])
	
	if i == 2 then
		if IsEngLanguage() or IsKoreanLanguage() or IsGSPLanguage() then
		
		else
			mywindow:setEnabled(false)
		end
		
	end
	
end





--------------------------------------------------------------------------------------------------------------------------------
-- 친구 리스트 "라디오 버튼"
--------------------------------------------------------------------------------------------------------------------------------
tUserButtonName =
{ ["protecterr"]=0, "sj_friendListBtn_1", "sj_friendListBtn_2", "sj_friendListBtn_3", "sj_friendListBtn_4", "sj_friendListBtn_5", 
					"sj_friendListBtn_6", "sj_friendListBtn_7", "sj_friendListBtn_8", "sj_friendListBtn_9", "sj_friendListBtn_10" }

--(레벨, 캐릭터명  위치)
tUserInfoTextName	= {['err'] = 0, 'PosText', 'LevelText', 'CharNameText' }
tUserInfoTextPosX	= {['err'] = 0, 23, 80, 190}
tUserInfoTextPosY	= {['err'] = 0, 5, 5, 5}
tUserInfoSizeX		= {['err'] = 0, 5, 5, 5}
tUserInfoSizeY		= {['err'] = 0, 5, 5, 5}
tUserInfoTestText	= {['err'] = 0, '', '', ''}

for i=1, #tUserButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",		tUserButtonName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",			0, 0)    --오버이미지 준비중
	mywindow:setTexture("Hover", "UIData/messenger4.tga",			566, 282)
	mywindow:setTexture("Pushed", "UIData/messenger4.tga",			566, 306)
	mywindow:setTexture("PushedOff", "UIData/messenger4.tga",		566, 306)
	mywindow:setTexture("SelectedNormal", "UIData/messenger4.tga",	566, 306)
	mywindow:setTexture("SelectedHover", "UIData/messenger4.tga",	566, 306)
	mywindow:setTexture("SelectedPushed", "UIData/messenger4.tga",	566, 306)
	mywindow:setTexture("SelectedPushedOff", "UIData/messenger4.tga",566, 306)
	mywindow:setSize(340, 24)
	mywindow:setPosition(1, 26*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged",	"OnSelectedUserList")
	mywindow:subscribeEvent("MouseRButtonUp",		"OnUserListMouseRButtonUp")
	mywindow:subscribeEvent("MouseDoubleClicked",	"OnUserListDoubleClicked")
	mywindow:subscribeEvent("MouseButtonDown",		"OnUserListMouseDown")
	winMgr:registerCacheWindow(tUserButtonName[i])
	
	-- 레벨, 닉네임, 클래스, 위치		Old
	-- 접속상태, 레벨, 캐릭터명			New
	for j=1, #tUserInfoTextName do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", tUserButtonName[i]..tUserInfoTextName[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(tUserInfoSizeX[j], tUserInfoSizeY[j])
		child_window:clearTextExtends()
		child_window:addTextExtends(tUserInfoTestText[j], g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		child_window:setVisible(true)
		child_window:setPosition(tUserInfoTextPosX[j], tUserInfoTextPosY[j])
		child_window:setViewTextMode(1)
		child_window:setAlign(8)
		child_window:setLineSpacing(1)		
		winMgr:registerCacheWindow(tUserButtonName[i]..tUserInfoTextName[j])
	end

--[[
	-- 정보보기 버튼
	local child_window3 = winMgr:createWindow("TaharezLook/Button", tUserButtonName[i].."InfoBtn")
	child_window3:setTexture("Normal",		"UIData/messenger4.tga",	582, 694)
	child_window3:setTexture("Hover",		"UIData/messenger4.tga",	582, 694)
	child_window3:setTexture("Pushed",		"UIData/messenger4.tga",	582, 694)
	child_window3:setTexture("PushedOff",	"UIData/messenger4.tga",	582, 694)
	child_window3:setTexture("Disabled",	"UIData/messenger4.tga",	600, 694)
	child_window3:setSize(18, 18)
	child_window3:setVisible(true);
	child_window3:setPosition(283, 2)
	child_window3:subscribeEvent("Clicked", "CallUserInfo")
	winMgr:registerCacheWindow(tUserButtonName[i].."InfoBtn")
]]--
	
	-- 절친 마크
	local child_window3 = winMgr:createWindow("TaharezLook/StaticImage", tUserButtonName[i].."InfoBtn")
	child_window3:setTexture("Enabled",	"UIData/messenger4.tga", 977, 0)
	child_window3:setTexture("Disabled","UIData/messenger4.tga", 977, 0)
	child_window3:setSize(29, 18)
	child_window3:setVisible(true);
	child_window3:setPosition(283, 2)
	winMgr:registerCacheWindow(tUserButtonName[i].."InfoBtn")
	
	-- 접속상태 마크
	local child_window4 = winMgr:createWindow("TaharezLook/StaticImage", tUserButtonName[i].."ConnectStateBtn")
	child_window4:setTexture("Enabled",	"UIData/messenger4.tga", 1006, 0)
	child_window4:setTexture("Disabled","UIData/messenger4.tga", 1006, 18)
	child_window4:setSize(18, 18)
	child_window4:setVisible(false);
	child_window4:setPosition(21, 2)
	winMgr:registerCacheWindow(tUserButtonName[i].."ConnectStateBtn")
end



--------------------------------------------------------------------------------------------------------------------------------
-- 절친 리스트 "라디오 버튼"
--------------------------------------------------------------------------------------------------------------------------------
tBestFriendButtonName =
{ ["protecterr"]=0, "sj_bestfriendListBtn_1", "sj_bestfriendListBtn_2", "sj_bestfriendListBtn_3", 
					"sj_bestfriendListBtn_4", "sj_bestfriendListBtn_5", "sj_bestfriendListBtn_6" }

--(접속상태, 레벨, 아이디)
tBestFriendInfoTextName	= {['err'] = 0, 'PosText','LevelText','CharNameText' }
tBestFriendInfoTextPosX	= {['err'] = 0, 23,20, 150} -- 23,70, 150
tBestFriendInfoTextPosY	= {['err'] = 0, 5,5, 5}
tBestFriendInfoSizeX	= {['err'] = 0, 5,5, 5}
tBestFriendInfoSizeY	= {['err'] = 0, 5,5, 5}
tBestFriendInfoTestText	= {['err'] = 0, '','', ''}

for i=1, #tBestFriendButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",			tBestFriendButtonName[i])
	mywindow:setTexture("Normal",			"UIData/invisible.tga",		0, 0)    --오버이미지 준비중
	mywindow:setTexture("Hover",			"UIData/messenger4.tga",	566, 330)
	mywindow:setTexture("Pushed",			"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("PushedOff",		"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedNormal",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedHover",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedPushed",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedPushedOff","UIData/messenger4.tga",	566, 354)
	mywindow:setSize(200, 24)
	mywindow:setPosition(1, 26*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged",	"OnSelectedUserList")
	mywindow:subscribeEvent("MouseRButtonUp",		"OnUserListMouseRButtonUp")
	mywindow:subscribeEvent("MouseDoubleClicked",	"OnUserListDoubleClicked")
	mywindow:subscribeEvent("MouseButtonDown",		"OnBestFriendListMouseDown")
	winMgr:registerCacheWindow(tBestFriendButtonName[i])
	
	-- 접속상태 마크
	local connectImage = winMgr:createWindow("TaharezLook/StaticImage", tBestFriendButtonName[i] .. 'ConnectStateBtn')
	connectImage:setTexture("Enabled",	"UIData/messenger4.tga", 1006, 0)
	connectImage:setTexture("Disabled",	"UIData/messenger4.tga", 1006, 18)
	connectImage:setSize(18, 18)
	connectImage:setVisible(true);
	connectImage:setPosition(1 , 1)
	winMgr:registerCacheWindow(tBestFriendButtonName[i] .. 'ConnectStateBtn')
	
	
	-- 접속상태, 레벨, 캐릭터명	 New
	for j=1, #tBestFriendInfoTextName do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", tBestFriendButtonName[i]..tBestFriendInfoTextName[j])	
		child_window:setProperty("FrameEnabled",		"false")
		child_window:setProperty("BackgroundEnabled",	"false")
		child_window:setSize(tBestFriendInfoSizeX[j], tBestFriendInfoSizeY[j])
		child_window:clearTextExtends()
		child_window:addTextExtends(tBestFriendInfoTestText[j], g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		child_window:setVisible(true)
		child_window:setPosition(tBestFriendInfoTextPosX[j], tBestFriendInfoTextPosY[j])
		child_window:setViewTextMode(1)
		child_window:setAlign(8)
		child_window:setLineSpacing(1)		
		winMgr:registerCacheWindow(tBestFriendButtonName[i]..tBestFriendInfoTextName[j])
	end
end



--------------------------------------------------------------------------------------------------------------------------------
-- 블랙 리스트 "라디오 버튼"
--------------------------------------------------------------------------------------------------------------------------------
tBlackListButtonName =
{ ["protecterr"]=0, "sj_blackfriendListBtn_1", "sj_blackfriendListBtn_2", "sj_blackfriendListBtn_3", "sj_blackfriendListBtn_4", 
					"sj_blackfriendListBtn_5", "sj_blackfriendListBtn_6", "sj_blackfriendListBtn_7", "sj_blackfriendListBtn_8" }

--(접속상태, 레벨, 아이디)
tBlackListInfoTextName	= {['err'] = 0, 'PosText','LevelText','CharNameText' }
tBlackListInfoTextPosX	= {['err'] = 0, 23, 70, 150}
tBlackListInfoTextPosY	= {['err'] = 0, 5, 5, 5}
tBlackListInfoSizeX		= {['err'] = 0, 5, 5, 5}
tBlackListInfoSizeY		= {['err'] = 0, 5, 5, 5}
tBlackListInfoTestText	= {['err'] = 0, '', '', ''}

for i=1, #tBlackListButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",			tBlackListButtonName[i])
	mywindow:setTexture("Normal",			"UIData/invisible.tga",		0, 0)    --오버이미지 준비중
	mywindow:setTexture("Hover",			"UIData/messenger4.tga",	566, 330)
	mywindow:setTexture("Pushed",			"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("PushedOff",		"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedNormal",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedHover",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedPushed",	"UIData/messenger4.tga",	566, 354)
	mywindow:setTexture("SelectedPushedOff","UIData/messenger4.tga",	566, 354)
	mywindow:setSize(200, 24)
	mywindow:setPosition(1, 26*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged",	"OnSelectedUserList")
	mywindow:subscribeEvent("MouseRButtonUp",		"OnBlackListMouseRButtonUp")
	--mywindow:subscribeEvent("MouseDoubleClicked",	"OnUserListDoubleClicked")
	mywindow:subscribeEvent("MouseButtonDown",		"OnBlackListMouseDown")
	winMgr:registerCacheWindow(tBlackListButtonName[i])
	
	-- 접속상태 마크
	local connectImage = winMgr:createWindow("TaharezLook/StaticImage", tBlackListButtonName[i] .. 'ConnectStateBtn')
	connectImage:setTexture("Enabled",	"UIData/messenger4.tga", 1006, 0)
	connectImage:setTexture("Disabled",	"UIData/messenger4.tga", 1006, 18)
	connectImage:setSize(18, 18)
	connectImage:setVisible(true);
	connectImage:setPosition(20, 1)
	winMgr:registerCacheWindow(tBlackListButtonName[i] .. 'ConnectStateBtn')
	
	-- 접속상태, 레벨, 캐릭터명			New
	for j=1, #tBlackListInfoTextName do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", tBlackListButtonName[i]..tBlackListInfoTextName[j])	
		child_window:setProperty("FrameEnabled",		"false")
		child_window:setProperty("BackgroundEnabled",	"false")
		child_window:setSize(tBlackListInfoSizeX[j], tBlackListInfoSizeY[j])
		child_window:clearTextExtends()
		child_window:addTextExtends(tBlackListInfoTestText[j], g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		child_window:setVisible(true)
		child_window:setPosition(tBlackListInfoTextPosX[j], tBlackListInfoTextPosY[j])
		child_window:setViewTextMode(1)
		child_window:setAlign(8)
		child_window:setLineSpacing(1)		
		winMgr:registerCacheWindow(tBlackListButtonName[i]..tBlackListInfoTextName[j])
	end

end

































-- 메신져 하단 버튼 ( 대화하기, 친구추가, 절친등록, 친구삭제, 절친삭제, 닫기버튼 )
tMessengerButtonName  = {["err"]=0, "sj_messenger_chatBtn", "sj_messenger_addFriendBtn", "sj_messenger_addBestFriendBtn", "sj_messenger_deleteFriendBtn", "sj_messenger_deleteBestFriendBtn", "sj_messenger_closeBtn"}
tMessengerButtonTexX  = {["err"]=0, 340, 425, 510, 595, 85, 916}
tMessengerButtonPosX  = {["err"]=0, 15, 102, 189, 276, 276 , 338} -- x버튼 : 338
tMessengerButtonEvent = {["err"]=0, "OnClickFriendChat", "OnClickFriendAdd", "OnClickBestFriendAdd", "OnClickFriendDelete", "OnClickBestFriendDelete",  "OnClickClose"}

for i=1, 4 do --  대화하기, 친구추가, 절친등록, 친구삭제
	mywindow = winMgr:createWindow("TaharezLook/Button", tMessengerButtonName[i])
	mywindow:setTexture("Normal",		"UIData/messenger4.tga",	tMessengerButtonTexX[i], 659)
	mywindow:setTexture("Hover",		"UIData/messenger4.tga",	tMessengerButtonTexX[i], 691)
	mywindow:setTexture("Pushed",		"UIData/messenger4.tga",	tMessengerButtonTexX[i], 723)
	mywindow:setTexture("PushedOff",	"UIData/messenger4.tga",	tMessengerButtonTexX[i], 755)
	mywindow:setTexture("Disabled",		"UIData/messenger4.tga",	tMessengerButtonTexX[i], 755)
	mywindow:setPosition(tMessengerButtonPosX[i], 480) -- y = 455
	mywindow:setSize(85, 32)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tMessengerButtonEvent[i])
	winMgr:registerCacheWindow(tMessengerButtonName[i])
end

-- 절친해제 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", tMessengerButtonName[5])
mywindow:setTexture("Normal",		"UIData/messenger4.tga",	tMessengerButtonTexX[5], 798)
mywindow:setTexture("Hover",		"UIData/messenger4.tga",	tMessengerButtonTexX[5], 830)
mywindow:setTexture("Pushed",		"UIData/messenger4.tga",	tMessengerButtonTexX[5], 862)
mywindow:setTexture("PushedOff",	"UIData/messenger4.tga",	tMessengerButtonTexX[5], 894)
mywindow:setTexture("Disabled",		"UIData/messenger4.tga",	tMessengerButtonTexX[5], 894)
mywindow:setPosition(tMessengerButtonPosX[5], 480)
mywindow:setSize(85, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", tMessengerButtonEvent[5])
winMgr:registerCacheWindow(tMessengerButtonName[5])


-- x창 닫기 
mywindow = winMgr:createWindow("TaharezLook/Button", tMessengerButtonName[6])
mywindow:setTexture("Normal",		"UIData/messenger4.tga",	916, 0)
mywindow:setTexture("Hover",		"UIData/messenger4.tga",	916, 23)
mywindow:setTexture("Pushed",		"UIData/messenger4.tga",	916, 46)
mywindow:setTexture("PushedOff",	"UIData/messenger4.tga",	916, 0)
mywindow:setTexture("Disabled",		"UIData/messenger4.tga",	916, 0)
mywindow:setPosition(tMessengerButtonPosX[6], 5)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", tMessengerButtonEvent[6])
winMgr:registerCacheWindow(tMessengerButtonName[6])






-- 페이지 앞뒤 버튼
tPageLRButtonName  = {["err"]=0, "sj_messenger_prevBtn", "sj_messenger_nextBtn"}
--tPageLRButtonTexX  = {["err"]=0, 939, 958}
tPageLRButtonTexX  = {["err"]=0, 374, 392}
tPageLRButtonPosX  = {["err"]=0, 113, 207}
tPageLRButtonEvent = {["err"]=0, "OnClickPrevPage", "OnClickNextPage"}
for i=1, #tPageLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPageLRButtonName[i])
	mywindow:setTexture("Normal",	"UIData/fightclub_004.tga", tPageLRButtonTexX[i], 679)
	mywindow:setTexture("Hover",	"UIData/fightclub_004.tga", tPageLRButtonTexX[i], 697)
	mywindow:setTexture("Pushed",	"UIData/fightclub_004.tga", tPageLRButtonTexX[i], 715)
	mywindow:setTexture("PushedOff","UIData/fightclub_004.tga", tPageLRButtonTexX[i], 679)
	mywindow:setPosition(tPageLRButtonPosX[i], 400)
	mywindow:setSize(18, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", tPageLRButtonEvent[i])
	winMgr:registerCacheWindow(tPageLRButtonName[i])
end

-- 페이저 넘버
mywindow = winMgr:createWindow("TaharezLook/StaticText", 'PageInfoText');
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setPosition(143, 310)
mywindow:setSize(53, 20);
mywindow:clearTextExtends()
mywindow:addTextExtends(tostring(g_CurFriendListPage)..' / '..tostring(g_TotalFriendListPage) , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
mywindow:setVisible(true);
mywindow:setViewTextMode(1);
mywindow:setAlign(8);
mywindow:setLineSpacing(1);
winMgr:registerCacheWindow('PageInfoText');




--메신저 채팅 직접입력하는 부분 
mywindow = winMgr:createWindow("TaharezLook/Editbox", "doChattingAtMessenger")
mywindow:setText("")
mywindow:setPosition(26, 3)
mywindow:setSize(270, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:activate()
mywindow:subscribeEvent("TextAccepted", "OnMessengerChatAccepted")
CEGUI.toEditbox(winMgr:getWindow("doChattingAtMessenger")):setMaxTextLength(50)
CEGUI.toEditbox(winMgr:getWindow("doChattingAtMessenger")):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
winMgr:registerCacheWindow('doChattingAtMessenger');


--sj_chat_backimage 채팅입력창 테두리
tWinName		= {['err'] = 0,	"sj_chat_BackImage", "sj_chat_english", "sj_chat_korean", "sj_chat_TopImage", "sj_chat_ViewImage" }
tTextureX		= {['err'] = 0,	0,		428,	428,	0,		49}
tTextureY		= {['err'] = 0,	621,	972,	1000,	620,	347}
--tTextureY		= {['err'] = 0,	621,	972,	1000,	647,	347}
tTextureSizeX	= {['err'] = 0,	310,	22,		22,		250,	203}
tTextureSizeY	= {['err'] = 0,	26,		21,		21,     19,		250}
tPosX			= {['err'] = 0,	10,		2,		2,      8,		12}
tPosY			= {['err'] = 0,	310,	3,	    3,      25,		50}

for i=1, #tWinName do
	my_window = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i])
	if  i == 5 then
		my_window:setTexture("Enabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
		my_window:setTexture("Disabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
	elseif i==1 or i== 4 then
	     my_window:setTexture("Enabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
	     my_window:setTexture("Disabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
	     
	else
		my_window:setTexture("Enabled", "UIData/GameNewImage.tga", tTextureX[i], tTextureY[i])
		my_window:setTexture("Disabled", "UIData/invisible.tga", tTextureX[i], tTextureY[i])
		my_window:setAlwaysOnTop(true)
	end
	my_window:setProperty("FrameEnabled", "False")
	my_window:setProperty("BackgroundEnabled", "False")
	my_window:setPosition(tPosX[i], tPosY[i])
	my_window:setSize(tTextureSizeX[i], tTextureSizeY[i])
	my_window:setVisible(true)
	my_window:setZOrderingEnabled(false)
	winMgr:registerCacheWindow(tWinName[i]);
end

-- 메신져 채팅창
tWhiteMultiLineEditBox = 
{ 
	["protecterr"]=0,
	"sj_multichat_1", "sj_multichat_2", "sj_multichat_3", "sj_multichat_4", "sj_multichat_5",
	"sj_multichat_6", "sj_multichat_7", "sj_multichat_8", "sj_multichat_9", "sj_multichat_10" 
}


-- 실질적인 채팅창
for i=1, #tWhiteMultiLineEditBox do
	mywindow = winMgr:createWindow("TaharezLook/WhiteMultiLineEditbox", tWhiteMultiLineEditBox[i]);
	mywindow:setProperty('ReadOnly', 'true');
	mywindow:setTextColor(255,255,255, 255);
	mywindow:setFont(g_STRING_FONT_GULIM, 12);
	mywindow:setPosition(1, 0);
	mywindow:setSize(172, 250);
	mywindow:setVisible(false);
	mywindow:setUserString('UserName', "");
	winMgr:registerCacheWindow(tWhiteMultiLineEditBox[i]);
end

-- 현재 채팅중인 사람 채팅창에 표시
mywindow = winMgr:createWindow("TaharezLook/StaticText", 'sj_chatuser_Text');
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112);	
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setPosition(7, 1);
mywindow:setSize(217, 24);
mywindow:clearTextExtends()
mywindow:addTextExtends( '...' , g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255);
mywindow:setVisible(true);
mywindow:setViewTextMode(1);
mywindow:setAlign(1);
mywindow:setLineSpacing(1);
winMgr:registerCacheWindow('sj_chatuser_Text');



mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MsgAlertBalloon');
mywindow:setPosition(834, 52);
mywindow:setSize(94, 67);
mywindow:setTexture('Enabled', 'UIData/mainBG_Button001.tga', 362, 952);
mywindow:setTexture('Disabled', 'UIData/mainBG_Button001.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setVisible(false);
winMgr:registerCacheWindow('MsgAlertBalloon');



mywindow = winMgr:createWindow('TaharezLook/StaticText', 'MsgAlertBalloonText');
mywindow:setPosition(0, 24);
mywindow:setSize(94, 35);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setProperty('Text', 'Msg Rece');
mywindow:setProperty('VertFormatting', 'TopAligned');
winMgr:registerCacheWindow('MsgAlertBalloonText');


-- 채팅창 x버튼
tCloseChatButtonName = {["err"]=0, "sj_chat_closeBtn"}
for i=1, #tCloseChatButtonName do
   
	mywindow = winMgr:createWindow("TaharezLook/Button", tCloseChatButtonName[i]);
	mywindow:setTexture("Normal", "UIData/messenger4.tga", 897, 0);
	mywindow:setTexture("Hover", "UIData/messenger4.tga", 897, 19);
	mywindow:setTexture("Pushed", "UIData/messenger4.tga", 897, 38);
	mywindow:setTexture("PushedOff", "UIData/messenger4.tga", 897, 38);
	mywindow:setPosition(173, 0)
	mywindow:setSize(19, 19);
	mywindow:setZOrderingEnabled(false);
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "OnClickCloseChatButton");
	winMgr:registerCacheWindow(tCloseChatButtonName[i]);
end


tChatUserRadio =
{ 
	["protecterr"]=0, 
	"sj_chat_userList_1", "sj_chat_userList_2", "sj_chat_userList_3", "sj_chat_userList_4", "sj_chat_userList_5", 
	"sj_chat_userList_6", "sj_chat_userList_7", "sj_chat_userList_8", "sj_chat_userList_9",	"sj_chat_userList_10" 
}
for i=1, #tChatUserRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tChatUserRadio[i]);	
	mywindow:setTexture("Normal",			"UIData/invisible.tga",	 190, 190);
	mywindow:setTexture("Hover",			"UIData/messenger4.tga", 696, 0);
	mywindow:setTexture("Pushed",			"UIData/messenger4.tga", 696, 0);
	mywindow:setTexture("PushedOff",		"UIData/messenger4.tga", 696, 30);	
	mywindow:setTexture("SelectedNormal",	"UIData/messenger4.tga", 696, 30);
	mywindow:setTexture("SelectedHover",	"UIData/messenger4.tga", 696, 30);
	mywindow:setTexture("SelectedPushed",	"UIData/messenger4.tga", 696, 30);
	mywindow:setTexture("SelectedPushedOff","UIData/messenger4.tga", 696, 30);
	mywindow:setTexture("Disabled",			"UIData/invisible.tga",	 190, 30);
	mywindow:setSize(110, 30);
	--mywindow:setPosition(215, 23+(i-1)*30);
	mywindow:setPosition(225, (i-1)*30);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setUserString('Index', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedChatUserRadio");
	winMgr:registerCacheWindow(tChatUserRadio[i]);
	
	-- 네임 스태틱 텍스트 만들기
	local child_window = winMgr:createWindow("TaharezLook/StaticText", tChatUserRadio[i]..'NameText');
	child_window:setProperty("FrameEnabled", "false");
	child_window:setProperty("BackgroundEnabled", "false");
	child_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	child_window:setTextColor(255, 200, 86, 255);
	child_window:setPosition(22, 10);
	child_window:setSize(76, 28);
	child_window:clearTextExtends()
	child_window:setText('none');
	child_window:setVisible(true);
	child_window:setViewTextMode(1);
	child_window:setAlign(8);
	child_window:setLineSpacing(1);
	child_window:setEnabled(false)
	winMgr:registerCacheWindow(tChatUserRadio[i]..'NameText');	
end

----------------------------------------------------------------------
-- 귓속말 알리는 창
----------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'WhisperChatContainer');
mywindow:setPosition(20, 683);
mywindow:setSize(423, 80);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setVisible(false);
winMgr:registerCacheWindow( 'WhisperChatContainer' );

mywindow = winMgr:createWindow('TaharezLook/MultiLineEditbox', 'WhisperChatView');
mywindow:setPosition(1, 0);
mywindow:setSize(421, 54);
mywindow:setProperty('MaxTextLength', '320');
mywindow:setProperty('Text', '');
winMgr:registerCacheWindow( 'WhisperChatView' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'WhisperChatInputContainer');
mywindow:setPosition(1, 55);
mywindow:setSize(421, 25);
mywindow:setTexture("Enabled", "UIData/GameNewImage.tga", 1, 998)
mywindow:setTexture("Disabled", "UIData/GameNewImage.tga", 1, 998)
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
winMgr:registerCacheWindow( 'WhisperChatInputContainer' );

mywindow = winMgr:createWindow('TaharezLook/Editbox', 'WhisperChatInput');
mywindow:setPosition(26, 2);
mywindow:setSize(330, 21);
mywindow:setProperty('MaxTextLength', '60');
mywindow:subscribeEvent("TextAccepted", "OnWhisperChatAccepted");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112);
mywindow:setTextColor(255, 255, 255, 255);
winMgr:registerCacheWindow( 'WhisperChatInput' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'HanTextImage');
mywindow:setPosition(1, 2);
mywindow:setSize(23, 21);
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 428, 1000);
mywindow:setTexture('Disabled', 'UIData/GameNewImage.tga', 428, 1000);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setProperty('FrameEnabled', 'False');
winMgr:registerCacheWindow( 'HanTextImage' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'EngTextImage');
mywindow:setPosition(2, 2);
mywindow:setSize(23, 21);
mywindow:setTexture('Enabled', 'UIData/GameNewImage.tga', 428, 972);
mywindow:setTexture('Disabled', 'UIData/GameNewImage.tga', 428, 972);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setProperty('FrameEnabled', 'False');
winMgr:registerCacheWindow( 'EngTextImage' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'MessengerPartyInviteBtn');
mywindow:setPosition(17, 490);
mywindow:setSize(87, 34);
mywindow:setTexture('Normal', 'UIData/messenger.tga', 637, 435);
mywindow:setTexture('Hover', 'UIData/messenger.tga', 637, 469);
mywindow:setTexture('Pushed', 'UIData/messenger.tga', 637, 503);
mywindow:setTexture('PushedOff', 'UIData/messenger.tga', 637, 435);
winMgr:registerCacheWindow( 'MessengerPartyInviteBtn' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'MessengerPartyLeaveBtn');
mywindow:setPosition(109, 490);
mywindow:setSize(87, 34);
mywindow:setTexture('Normal', 'UIData/messenger.tga', 533, 435);
mywindow:setTexture('Hover', 'UIData/messenger.tga', 533, 469);
mywindow:setTexture('Pushed', 'UIData/messenger.tga', 533, 503);
mywindow:setTexture('PushedOff', 'UIData/messenger.tga', 533, 435);
winMgr:registerCacheWindow( 'MessengerPartyLeaveBtn' );


--------------------------------------------------------------------
-- 광장 미니맵 관련
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MiniMapContainer');
mywindow:setWideType(1);
mywindow:setPosition(789, 38);
mywindow:setSize(240, 138);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow( 'MiniMapContainer' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MiniMapMiddleBG');
mywindow:setPosition(15, 15);
--mywindow:setSize(231, 135);
mywindow:setSize(214, 128);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:addController("BottomBGUpMotion0", "MiniMapUpMotion", "yoffset", "Quartic_EaseIn", 135, 0, 2, true, false, 10)
mywindow:addController("BottomBGUpMotion0", "MiniMapDownMotion", "yoffset", "Quartic_EaseIn", 0, 135, 2, true, false, 10)
winMgr:registerCacheWindow( 'MiniMapMiddleBG' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MiniMapBottomBG');
mywindow:setTexture('Enabled', 'UIData/mainBG_Button002.tga', 235, 137);
mywindow:setPosition(0, 137);
mywindow:setSize(233, 22);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:addController("BottomBGUpMotion0", "MiniMapUpMotion", "y", "Quartic_EaseIn", 0, 1, 2, true, false, 10)
mywindow:addController("BottomBGUpMotion0", "MiniMapDownMotion", "y", "Quartic_EaseIn", 1, 137, 2, true, false, 10)
winMgr:registerCacheWindow( 'MiniMapBottomBG' );


mywindow = winMgr:createWindow('TaharezLook/Button', 'MiniMapCloseButton');
mywindow:setPosition(9, 8);
mywindow:setSize(17, 9);
mywindow:setTexture('Normal', 'UIData/mainBG_Button001.tga', 90, 954);
mywindow:setTexture('Hover', 'UIData/mainBG_Button001.tga', 90, 967);
mywindow:setTexture('Pushed', 'UIData/mainBG_Button001.tga', 90, 980);
mywindow:setTexture('PushedOff', 'UIData/mainBG_Button001.tga', 90, 980);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
winMgr:registerCacheWindow( 'MiniMapCloseButton' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'MiniMapOpenButton');
mywindow:setPosition(9, 8);
mywindow:setSize(17, 9);
mywindow:setTexture('Normal', 'UIData/mainBG_Button001.tga', 111, 954);
mywindow:setTexture('Hover', 'UIData/mainBG_Button001.tga', 111, 967);
mywindow:setTexture('Pushed', 'UIData/mainBG_Button001.tga', 111, 980);
mywindow:setTexture('PushedOff', 'UIData/mainBG_Button001.tga', 111, 980);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow( 'MiniMapOpenButton' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MiniMapTopBG');
mywindow:setTexture('Enabled', 'UIData/mainBG_Button002.tga', 235, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition(20, 0);
--mywindow:setSize(233, 137);
mywindow:setSize(214, 128);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:addController("BottomBGUpMotion0", "MiniMapUpMotion", "yoffset", "Quartic_EaseIn", 137, 1, 2, true, false, 10)
mywindow:addController("BottomBGUpMotion0", "MiniMapDownMotion", "yoffset", "Quartic_EaseIn", 1, 137, 2, true, false, 10)
winMgr:registerCacheWindow( 'MiniMapTopBG' );

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MiniMapLineBG');
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 288, 277);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition(10, 0);
mywindow:setSize(224, 138);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow( 'MiniMapLineBG' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'MiniMapZoomInButton');
mywindow:setPosition(5, 44);
mywindow:setSize(18, 18);
mywindow:setTexture('Normal', 'UIData/mainBG_Button004.tga', 232, 277);
mywindow:setTexture('Hover', 'UIData/mainBG_Button004.tga', 232, 295);
mywindow:setTexture('Pushed', 'UIData/mainBG_Button004.tga', 232, 313);
mywindow:setTexture('PushedOff', 'UIData/mainBG_Button004.tga', 232, 277);
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow( 'MiniMapZoomInButton' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'MiniMapZoomOutButton');
mywindow:setPosition(5, 64);
mywindow:setSize(18, 18);
mywindow:setTexture('Normal', 'UIData/mainBG_Button004.tga', 250, 277);
mywindow:setTexture('Hover', 'UIData/mainBG_Button004.tga', 250, 295);
mywindow:setTexture('Pushed', 'UIData/mainBG_Button004.tga', 250, 313);
mywindow:setTexture('PushedOff', 'UIData/mainBG_Button004.tga', 250, 277);
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow( 'MiniMapZoomOutButton' );

mywindow = winMgr:createWindow('TaharezLook/Button', 'FacebookButton');
mywindow:setPosition(4, 83);
mywindow:setSize(20, 20);
mywindow:setTexture('Normal', 'UIData/mainBG_Button004.tga', 105, 277);
mywindow:setTexture('Hover', 'UIData/mainBG_Button004.tga', 125, 277);
mywindow:setTexture('Pushed', 'UIData/mainBG_Button004.tga', 145, 277);
mywindow:setTexture('PushedOff', 'UIData/mainBG_Button004.tga', 105, 277);
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow( 'FacebookButton' );


-------------------------------------------------------------------
-- 이벤트 팝업관련
-------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Button", "pu_btn(menu)");
mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", 531, 79);
mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 531 + 40, 79);
mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 531 + 80, 79);
mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 531 + 120, 79);
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 531, 79);
mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 531 + 120, 79);
mywindow:setPosition(770, 10);
mywindow:setSize(39, 40);
mywindow:setZOrderingEnabled(false);
mywindow:setSubscribeEvent("Clicked", "CallPopupMenu");
winMgr:registerCacheWindow("pu_btn(menu)");


-------------------------------------------------------------------
-- 팝업 메뉴 컨테이너
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PopupMenuContainer")
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 937, 359)
mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 937, 359)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(87, 112)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("PopupMenuContainer");


local tPopupMenuName	= {['protecterr']=0, "Menu_Myinfo", "Menu_CM_Mission", "Menu_Inventory", "Menu_MyClub"}
local tPopupMenuEvent	= {['protecterr']=0, "Menu_MyinfoClick", "Menu_CM_MissionClick", "Menu_InventoryClick", "Menu_MyClubClick"}

for i = 1, #tPopupMenuName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPopupMenuName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 941, 516)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 941, 516)
	mywindow:setPosition(4, 3 + (i - 1) * 26)
	mywindow:setSize(79, 26)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tPopupMenuEvent[i])
	winMgr:registerCacheWindow(tPopupMenuName[i]);
end



------------------------------ 팝업 이펙트 모음----------------------------------------

-- 메신져 왔을시 채팅버튼 효과주는것
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'sj_chat_effect');
mywindow:setTexture('Enabled', 'UIData/messenger4.tga', 846, 562);
mywindow:setTexture('Disabled', 'UIData/messenger4.tga', 846, 562);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(false)
mywindow:setPosition(0,0);
mywindow:setSize(114, 31);
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('sj_chat_effect');


------------------------------------------------------------------------

-- 클럽 관련

------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_club_createWindow")
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(480, 117)
mywindow:setSize(469, 358)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
winMgr:registerCacheWindow("sj_club_createWindow")

--파티 타이틀바(마우스 따라 움직이게 하기)
mywindow = winMgr:createWindow('TaharezLook/Titlebar', 'sj_club_titlebar');
mywindow:setPosition(4, 1);
mywindow:setSize(430, 40);
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow('sj_club_titlebar');


-----------------------------------------------------------
-- 클럽 생성 관련 윈도우(Button)
-----------------------------------------------------------
-- 클럽 생성창 닫기버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_createWindow_closeBtn')
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setSize(23, 23)
mywindow:setPosition(430, 9)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "CloseFightClubInfo")
winMgr:getWindow("sj_club_createWindow"):addChildWindow("sj_club_createWindow_closeBtn")
--winMgr:registerCacheWindow('sj_club_createWindow_closeBtn')


-- 클럽이름 중복확인 버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_name_duplicateBtn')
mywindow:setTexture('Normal', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture('Hover', 'UIData/fightClub_001.tga', 0, 492)
mywindow:setTexture('Pushed', 'UIData/fightClub_001.tga', 0, 513)
mywindow:setTexture('PushedOff', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 471)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 534)
mywindow:setPosition(329, 65)
mywindow:setSize(111, 21)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("clubInfo", 0)
mywindow:setSubscribeEvent("Clicked", "ConfirmDuplicatusClubInfos")
winMgr:registerCacheWindow('sj_club_name_duplicateBtn')


-- 클럽URL 중복확인 버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_url_duplicateBtn')
mywindow:setTexture('Normal', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture('Hover', 'UIData/fightClub_001.tga', 0, 492)
mywindow:setTexture('Pushed', 'UIData/fightClub_001.tga', 0, 513)
mywindow:setTexture('PushedOff', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 471)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 534)
mywindow:setPosition(329, 129)
mywindow:setSize(111, 21)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("clubInfo", 1)
mywindow:setSubscribeEvent("Clicked", "ConfirmDuplicatusClubInfos")
winMgr:registerCacheWindow('sj_club_url_duplicateBtn')


-- 클럽마크 불러오기 버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_loadClubEmblemBtn')
mywindow:setTexture('Normal', 'UIData/fightClub_001.tga', 111, 471)
mywindow:setTexture('Hover', 'UIData/fightClub_001.tga', 111, 492)
mywindow:setTexture('Pushed', 'UIData/fightClub_001.tga', 111, 513)
mywindow:setTexture('PushedOff', 'UIData/fightClub_001.tga', 111, 471)
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 111,471)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 111, 534)
mywindow:setPosition(329, 160)
mywindow:setSize(111, 21)
--mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "LoadClubMark")
winMgr:registerCacheWindow('sj_club_loadClubEmblemBtn')


-- 클럽칭호 중복확인 버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_title_duplicateBtn')
mywindow:setTexture('Normal', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture('Hover', 'UIData/fightClub_001.tga', 0, 492)
mywindow:setTexture('Pushed', 'UIData/fightClub_001.tga', 0, 513)
mywindow:setTexture('PushedOff', 'UIData/fightClub_001.tga', 0, 471)
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 471)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 534)
mywindow:setPosition(329, 307)
mywindow:setSize(111, 21)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("clubInfo", 2)
mywindow:setSubscribeEvent("Clicked", "ConfirmDuplicatusClubInfos")
winMgr:registerCacheWindow('sj_club_title_duplicateBtn')


-- 클럽생성 확인 버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'sj_club_createConfirmBtn')
mywindow:setTexture('Normal', 'UIData/fightClub_001.tga', 0, 358)
mywindow:setTexture('Hover', 'UIData/fightClub_001.tga', 0, 386)
mywindow:setTexture('Pushed', 'UIData/fightClub_001.tga', 0, 414)
mywindow:setTexture('PushedOff', 'UIData/fightClub_001.tga', 0, 200)
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 200)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 442)
mywindow:setPosition(145, 315)
mywindow:setSize(200, 28)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "ConfirmIsCreateFightClub")
winMgr:registerCacheWindow('sj_club_createConfirmBtn')


-----------------------------------------------------------
-- 클럽 생성 관련 윈도우(Editbox)
-----------------------------------------------------------
-- 클럽이름 text
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_club_clubName_editbox")
mywindow:setText("")
mywindow:setPosition(110, 53)
mywindow:setSize(200, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)

CEGUI.toEditbox(mywindow):setMaxTextLength(14)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ClubInputChinho")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "ClubInputChinho")
winMgr:registerCacheWindow("sj_club_clubName_editbox")

-- 클럽URL text
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_club_clubUrl_editbox")
mywindow:setText("")
mywindow:setPosition(113, 128)
mywindow:setSize(210, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(64)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
winMgr:registerCacheWindow("sj_club_clubUrl_editbox")

-- 클럽마크 text
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_club_clubEmblemName_editbox")
mywindow:setText("basic.tga")
mywindow:setPosition(147, 190)
mywindow:setSize(180, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setEnabled(true)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(128)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ClubInputName")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "ClubInputName")
winMgr:registerCacheWindow("sj_club_clubEmblemName_editbox")

-- 클럽칭호 text
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_club_clubTitle_editbox")
mywindow:setText("")
mywindow:setPosition(110, 256)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(210, 75)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)

CEGUI.toEditbox(mywindow):setMaxTextLength(14)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ClubInputMark")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "ClubInputMark") 
winMgr:registerCacheWindow("sj_club_clubTitle_editbox")



-----------------------------------------------------------
-- 클럽 생성 관련 윈도우(StaticImage)
-----------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'sj_club_clubEmblemImage')
mywindow:setTexture('Enabled', 'UIData/blackFadeIn.tga', 0, 0)
mywindow:setTexture('Disabled', 'UIData/blackFadeIn.tga', 0, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(115, 202)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setSize(32, 32)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('sj_club_clubEmblemImage')





------------------------------------------------------------------
-- 툴팁 사용하려면 사용되는 lua에 
-- root:addChildWindow("CommonTooltip")
-- winMgr:getWindow("CommonTooltipRenderImg"):subscribeEvent('EndRender', "함수로 사용할 이름")
-- 등록시켜준다.
------------------------------------------------------------------
-- 공통으로 사용할 툴팁창.(기본바탕 이미지)
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonTooltip")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)		-- 테스트때문에..
mywindow:setSize(248, 206)		-- 기본사이즈.		--> 나중에 늘려준다. spawn할때.
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setEnabled(false)
winMgr:registerCacheWindow('CommonTooltip')


------------------------------------------------------------------
-- 위에부분(이름, 설명 공간.)
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonTooltipTop")
mywindow:setTexture("Enabled", "UIData/skillItem001.tga", 756, 60)
mywindow:setTexture("Disabled", "UIData/skillItem001.tga", 756, 60)
mywindow:setPosition(0, 0)
mywindow:setSize(248, 50)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('CommonTooltipTop')


------------------------------------------------------------------
-- 중간에 들어가는 이미지(이건 늘려서 사용할 수 있도록 만들어야한다.)
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonTooltipMiddle")
mywindow:setTexture("Enabled", "UIData/skillItem001.tga", 756, 110)
mywindow:setTexture("Disabled", "UIData/skillItem001.tga", 756, 110)
mywindow:setPosition(0, 50)
mywindow:setSize(248, 1)
mywindow:setScaleHeight(255 * 148)	-- 기본 이미지의 사이즈가 90.. --> 9배를 해준다.
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('CommonTooltipMiddle')

------------------------------------------------------------------
-- 아래부분.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonTooltipBottom")
mywindow:setTexture("Enabled", "UIData/skillItem001.tga", 756, 258)
mywindow:setTexture("Disabled", "UIData/skillItem001.tga", 756, 258)
mywindow:setPosition(0, 198)
mywindow:setSize(248, 8)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('CommonTooltipBottom')

	

------------------------------------------------------------------
-- 전체 조각으로 붙여논 툴팁을 전체적으로 덮는 투명한 이미지.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonTooltipRenderImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(248, 206)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('CommonTooltipRenderImg')

winMgr:getWindow("CommonTooltip"):addChildWindow("CommonTooltipTop")
winMgr:getWindow("CommonTooltip"):addChildWindow("CommonTooltipMiddle")
winMgr:getWindow("CommonTooltip"):addChildWindow("CommonTooltipBottom")
winMgr:getWindow("CommonTooltip"):addChildWindow("CommonTooltipRenderImg")








--------------------------------------------------------------------
-- 이벤트 보조팝업 알파
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('LevelUpEventAlpha')


--------------------------------------------------------------------
-- Esc, Enter키 먹히게
--------------------------------------------------------------------


--------------------------------------------------------------------
-- 이벤트 보조팝업
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventMain")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 400) / 2)
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('LevelUpEventAlpha')



--------------------------------------------------------------------
-- 이벤트 보조팝업 타이틀
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventTitle")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 363)
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow('LevelUpEventTitle')


mywindow = winMgr:createWindow("TaharezLook/StaticText", "LevelUpEventMsg")
mywindow:setPosition(20, 60)
mywindow:setSize(300, 20)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)	
mywindow:setTextExtends(PM_String_LevelUpEvent, g_STRING_FONT_DODUMCHE,15, 255,198,30,255, 2, 0,0,0,255);
winMgr:registerCacheWindow('LevelUpEventMsg')


--------------------------------------------------------------------
-- 이벤트 보조팝업 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "LevelUpEventButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "LevelUpEventButtonEvent")
winMgr:registerCacheWindow('LevelUpEventButton')



--------------------------------------------------------------------
-- 이벤트 보조팝업 보상 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventRewardBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setPosition(27, 90)
mywindow:setSize(266, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("LevelUpEvent", 0)
mywindow:subscribeEvent("EndRender", "LevelUpEventRender");
winMgr:registerCacheWindow('LevelUpEventRewardBack')


--------------------------------------------------------------------
-- 이벤트 보조팝업 아이템 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventRewardItemBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setPosition(7, 6)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('LevelUpEventRewardItemBack')


--------------------------------------------------------------------
-- 이벤트 보조팝업 보상 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelUpEventRewardItemImg")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 392, 843)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 392, 843)
mywindow:setPosition(0, 0)
mywindow:setSize(98, 90)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('LevelUpEventRewardItemImg')



winMgr:getWindow("LevelUpEventAlpha"):addChildWindow(winMgr:getWindow("LevelUpEventMain"))
winMgr:getWindow("LevelUpEventMain"):addChildWindow(winMgr:getWindow("LevelUpEventTitle"))
winMgr:getWindow("LevelUpEventMain"):addChildWindow(winMgr:getWindow("LevelUpEventMsg"))
winMgr:getWindow("LevelUpEventMain"):addChildWindow(winMgr:getWindow("LevelUpEventButton"))
winMgr:getWindow("LevelUpEventMain"):addChildWindow(winMgr:getWindow("LevelUpEventRewardBack"))
winMgr:getWindow("LevelUpEventRewardBack"):addChildWindow(winMgr:getWindow("LevelUpEventRewardItemBack"))
winMgr:getWindow("LevelUpEventRewardItemBack"):addChildWindow(winMgr:getWindow("LevelUpEventRewardItemImg"))



--------------------------------------------------------------------
-- 광장 채널 정보 백판
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ChannelPositionBG');
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 792, 939);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 792, 939);
mywindow:setWideType(1);
mywindow:setPosition(800, 2);
mywindow:setSize(222, 36);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:registerCacheWindow( 'ChannelPositionBG' );

--------------------------------------------------------------------
-- 광장 채널 정보 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'ChannelPositionText');
mywindow:setPosition(50, 10);
mywindow:setSize(20, 22);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
--mywindow:setAlign(8);
mywindow:setViewTextMode(1);
mywindow:clearTextExtends()
winMgr:registerCacheWindow('ChannelPositionText');

--------------------------------------------------------------------
-- 대전/광장 이동 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "NewMoveServerBtn")
mywindow:setTexture("Normal", "UIData/mainBG_Button003.tga", 802, 436)
mywindow:setTexture("Hover", "UIData/mainBG_Button003.tga", 802, 472)
mywindow:setTexture("Pushed", "UIData/mainBG_Button003.tga", 802, 508)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button003.tga", 802, 436)
mywindow:setTexture("Enabled", "UIData/mainBG_Button003.tga", 802, 436)
mywindow:setTexture("Disabled", "UIData/mainBG_Button003.tga", 802, 436)
mywindow:setPosition(0, 1)
mywindow:setSize(222, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:subscribeEvent("MouseButtonDown", "OnMouseButtonDownPopupButton");
--mywindow:subscribeEvent("MouseEnter", "OnMouseEnterPopupButton");
mywindow:subscribeEvent("Clicked", "OpenChannelImage")
winMgr:registerCacheWindow('NewMoveServerBtn');


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'pu_btn(Channel)_effect');
mywindow:setTexture('Enabled', 'UIData/mainBG_Button003.tga', 802, 580);
mywindow:setTexture('Disabled', 'UIData/mainBG_Button003.tga', 802, 580);
mywindow:setEnabled(false)
mywindow:setPosition(0, 0);
mywindow:setSize(222, 36);
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("ChannelController", "ChannelEffect", "visible", "Sine_EaseIn", 1, 1, 16, true, true, 10)
mywindow:addController("ChannelController", "ChannelEffect", "visible", "Sine_EaseIn", 0, 0, 16, true, true, 10)
winMgr:registerCacheWindow('pu_btn(Channel)_effect');
winMgr:getWindow('NewMoveServerBtn'):addChildWindow(winMgr:getWindow('pu_btn(Channel)_effect'));

--------------------------------------------------------------------
-- 나가기 공용 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "NewMoveExitBtn")
mywindow:setTexture("Normal", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Hover", "UIData/mainBG_Button003.tga", 802, 652)
mywindow:setTexture("Pushed", "UIData/mainBG_Button003.tga", 802, 688)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Enabled", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Disabled", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setPosition(0, 1)
mywindow:setSize(222, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnclickOutNewBtn")
winMgr:registerCacheWindow('NewMoveExitBtn');

-- winMgr:getWindow('CharacterInfoBackWindow'):addChildWindow(winMgr:getWindow("CharacterInfoLadderImage"));


--------------------------------------------------------------------
-- 게임 팁 팝업 관련 Image
--------------------------------------------------------------------
-- GameTipPopUp BackImage
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TipPopUpBackImage")
mywindow:setTexture("Enabled", "UIData/mainBG_button005.tga", 0, 74)
mywindow:setTexture("Disabled", "UIData/mainBG_button005.tga", 0, 74)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setVisible(true)
mywindow:setPosition(0, 0)
mywindow:setSize(764, 463)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("TipPopUpBackImage")


-- GameTipPopUp CancelButton
mywindow = winMgr:createWindow("TaharezLook/Button", "TipPopUpCancelButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(730, 13)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "GameTipPopUpCancel")
winMgr:registerCacheWindow("TipPopUpCancelButton")


-- GameTipPopUp RadioButton
mywindow = winMgr:createWindow("TaharezLook/Button", "TipPopUpRadioButton")
mywindow:setTexture("Normal", "UIData/mainBG_button005.tga", 911, 0)
mywindow:setTexture("Hover", "UIData/mainBG_button005.tga", 911, 45)
mywindow:setTexture("Pushed", "UIData/mainBG_button005.tga", 911, 90)
mywindow:setTexture("PushedOff", "UIData/mainBG_button005.tga", 911, 135)
mywindow:setPosition(17, 60)
mywindow:setSize(113, 45)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:subscribeEvent("Clicked", "GameTipClosed")
winMgr:registerCacheWindow("TipPopUpRadioButton")


-- GameTipPopUp PrevButton
mywindow = winMgr:createWindow("TaharezLook/Button", "TipPopUpPrevButton")
mywindow:setTexture("Normal", "UIData/mainBG_button005.tga", 478, 0)
mywindow:setTexture("Hover", "UIData/mainBG_button005.tga", 478, 23)
mywindow:setTexture("Pushed", "UIData/mainBG_button005.tga", 478, 46)
mywindow:setTexture("PushedOff", "UIData/mainBG_button005.tga", 478, 0)
mywindow:setPosition(390, 418)
mywindow:setSize(19, 23)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "PrevTipList")
winMgr:registerCacheWindow("TipPopUpPrevButton")


-- GameTipPopUp NextButton
mywindow = winMgr:createWindow("TaharezLook/Button", "TipPopUpNextButton")
mywindow:setTexture("Normal", "UIData/mainBG_button005.tga", 497, 0)
mywindow:setTexture("Hover", "UIData/mainBG_button005.tga", 497, 23)
mywindow:setTexture("Pushed", "UIData/mainBG_button005.tga", 497, 46)
mywindow:setTexture("PushedOff", "UIData/mainBG_button005.tga", 497, 0)
mywindow:setPosition(460, 418)
mywindow:setSize(19, 23)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "NestTipList")
winMgr:registerCacheWindow("TipPopUpNextButton")

--[[
for i = 0, TIPTEXTLISTMAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TipPopUpSortImage"..i)
	mywindow:setTexture("Enabled", "UIData/mainBG_button005.tga", 549, 0)
	mywindow:setTexture("Disabled", "UIData/mainBG_button005.tga", 549, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setVisible(true)
	mywindow:setPosition(180, 59 + (25 * i)
	mywindow:setSize(18, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("TipPopUpSortImage"..i)
end
]]--

mywindow = winMgr:createWindow("TaharezLook/StaticText", "TipPopUpPageText")
mywindow:setPosition(420, 415)
mywindow:setSize(30, 25)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255,200,80,255)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
winMgr:registerCacheWindow("TipPopUpPageText")

-- GameTipPopUp BackImage
for i = 0, TIPTEXTLISTMAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TipPopUpText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setSize(425, 0)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setPosition(205, 59 + (25 * i))
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("TipPopUpText"..i)
end


--------------------------------------------------------------------
-- 게임 팁(광장, 헌팅필드, 아케이드, 배틀룸) 관련 Image
--------------------------------------------------------------------

-- GameTip AllButton
mywindow = winMgr:createWindow("TaharezLook/Button", "TipAllButton")
mywindow:setTexture("Normal", "UIData/mainBG_button005.tga", 745, 0)
mywindow:setTexture("Hover", "UIData/mainBG_button005.tga", 745, 19)
mywindow:setTexture("Pushed", "UIData/mainBG_button005.tga", 745, 38)
mywindow:setTexture("PushedOff", "UIData/mainBG_button005.tga", 745, 57)
mywindow:setPosition(392, 25)
mywindow:setSize(29, 19)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:subscribeEvent("Clicked", "GameTipPopUpOpne")
winMgr:registerCacheWindow("TipAllButton")


----------------------------------------------------------------------
-- 공통 알파이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonPreAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
--mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("CommonPreAlphaImage")
