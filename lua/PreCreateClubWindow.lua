
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")




------------------------------------------------------------------------------------------------------------------------------------------------
-- 클럽 백그라운드 이미지

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FightClub_ClubNameWindow")
mywindow:setTexture("Enabled", "UIData/fightClub_003.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_003.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(400 ,80);
mywindow:setSize(578, 468)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("FightClub_ClubNameWindow")

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "ClubName_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(540, 26)
winMgr:registerCacheWindow("ClubName_titlebar")


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubCreateNotice")
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga",553, 359)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 553, 359)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(480, 117)
mywindow:setSize(469, 378)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("ClubCreateNotice")

-- 클럽 생성 불가 알림창 닫기버튼
mywindow = winMgr:createWindow('TaharezLook/Button', 'ClubCreateNotice_closeBtn')
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setSize(23, 23)
mywindow:setPosition(430, 9)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "CloseClubCreateNotice")
--winMgr:registerCacheWindow('ClubCreateNotice_closeBtn')
winMgr:getWindow("ClubCreateNotice"):addChildWindow("ClubCreateNotice_closeBtn")

RegistEscEventInfo("ClubCreateNotice_closeBtn", "CloseClubCreateNotice")

 -----------------------------------------------------------------------
--클럽 네임 라디오 박스
-----------------------------------------------------------------------
 
FightClubNameRadio =
{ ["protecterr"]=0, "ClubName_1", "ClubName_2", "ClubName_3", "ClubName_4", "ClubName_5"}


ClubEventHandler	= {['err'] = 0, "Club_Info", "Club_Member" ,"Club_Stats" ,"Club_Board" ,"Club_Manager"}
ClubNameTextPosX	= {['err'] = 0, 0, 110, 440, 220, 330}
ClubNamePositionx    = {['err'] = 0, 4, 119, 464, 234, 349}  
for i=1, #FightClubNameRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",				FightClubNameRadio[i]);	
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga",				ClubNameTextPosX[i], 467);
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",				ClubNameTextPosX[i], 496);
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",				ClubNameTextPosX[i], 525);
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",			ClubNameTextPosX[i], 525);	
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",		ClubNameTextPosX[i], 525);
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",		ClubNameTextPosX[i], 525);
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",		ClubNameTextPosX[i], 525);
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga",	ClubNameTextPosX[i], 525);
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga",				ClubNameTextPosX[i], 554);
	mywindow:setSize(110, 29);
	mywindow:setProperty("GroupID", 0511)
	mywindow:setPosition(ClubNamePositionx[i],44);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", ClubEventHandler[i]);
	winMgr:registerCacheWindow(FightClubNameRadio[i])
	--winMgr:getWindow('FightClub_ClubNameWindow'):addChildWindow( winMgr:getWindow(FightClubNameRadio[i]) );
end
	winMgr:getWindow("ClubName_3"):setVisible(false)
-----------------------------------------------------------------------------
--클럽정보, 클럽원, 클럽전적, 게시판, 클럽관리에 사용될 백판
-----------------------------------------------------------------------------
Club_Menu_BackImage =
{ ["protecterr"]=0, "Club_Info_BackImage", "Club_Member_BackImage", "Club_Stats_BackImage", "Club_Board_BackImage", "Club_Manage_BackImage"}

for i=1, #Club_Menu_BackImage do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_Menu_BackImage[i])
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10 , 85);
	mywindow:setSize(550, 400)
	mywindow:setEnabled(true)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:registerCacheWindow(Club_Menu_BackImage[i])		
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Info_BackImageTop")
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 0, 556)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 0, 556)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5 ,0);
mywindow:setSize(547, 368 )
mywindow:setEnabled(false)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("Club_Info_BackImageTop")


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Manage_BackImageTop")
mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 0, 583)
mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 0, 583)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0 , 0);
mywindow:setSize(554, 239)
mywindow:setEnabled(false)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("Club_Manage_BackImageTop")

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Member_BackImageTop")
mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 0, 124)
mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 0, 124)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0 , 0);
mywindow:setSize(554, 342)
mywindow:setEnabled(false)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("Club_Member_BackImageTop")

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Manage_BackImageBottom")
mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 556, 472)
mywindow:setTexture("Disabled", "UIData/fightClub_002.tga",556, 472)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0 , 270);
mywindow:setSize(357, 101)
mywindow:setEnabled(false)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("Club_Manage_BackImageBottom")



-----------------------------------------------------------------------------
--클럽네임 ( 모든 백판에 공통적으로 보여짐)
-----------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Main_ClubName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setViewTextMode(1)	
--mywindow:setAlign(8)
mywindow:setLineSpacing(1)
mywindow:setPosition(60, 12)
mywindow:setSize(5, 5)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("Main_ClubName")

-----------------------------------------------------------------------------
--클럽정보 ( 클럽 마스터, 클럽칭호 , 클럽레벨 , 클럽인투루)
-----------------------------------------------------------------------------
Club_Info_Text =	{ ["protecterr"]=0,  "Club_Info_Master", "Club_Info_ChinHo", "Club_Info_Level", "Club_Info_Introduce" ,"Club_Info_Member" 
					, "Club_Info_Stats" , "Club_Info_Rank", "Club_Info_Exp"}
Club_Info_Text_PosX  =    { ["protecterr"]=0,  70, 70, 62, 20 , 408 , 391 , 391 ,151}
Club_Info_Text_PosY  =    { ["protecterr"]=0,  28, 100, 73 , 153 , 38 , 55 , 70 , 55}	
for i=1 , #Club_Info_Text do

	mywindow = winMgr:createWindow("TaharezLook/StaticText", Club_Info_Text[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setLineSpacing(1)
	if i == 8 then
		mywindow:setAlign(8)
	end
	mywindow:setPosition(Club_Info_Text_PosX[i], Club_Info_Text_PosY[i])
	mywindow:setSize(150, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow(Club_Info_Text[i])
end

------------------------------------------------------------------------------
--클럽경험치바 버튼
------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Info_EXPBar")
mywindow:setTexture("Enabled", "UIData/fightClub_001.tga", 389, 534)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga",389, 534)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(104, 58 )
mywindow:setSize(5, 20)  --143
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
--mywindow:setScaleWidth(530)
--mywindow:setScaleHeight(420)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("Club_Info_EXPBar")
------------------------------------------------------------------------------
--클럽탈퇴 버튼
------------------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Button", "ClubOutBtn")
mywindow:setTexture("Normal", "UIData/fightClub_001.tga", 222, 471)
mywindow:setTexture("Hover", "UIData/fightClub_001.tga", 222, 492)
mywindow:setTexture("Pushed", "UIData/fightClub_001.tga", 222, 513)
mywindow:setTexture("PushedOff", "UIData/fightClub_001.tga", 222, 534)
mywindow:setPosition(385, 202)
mywindow:setSize(167, 21)
mywindow:setSubscribeEvent("Clicked", "OnClickClubOutEvent")
winMgr:registerCacheWindow("ClubOutBtn")

------------------------------------------------------------------------------
--클럽목록보기  버튼
------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ClubListShowBtn")
mywindow:setTexture("Normal", "UIData/fightClub_001.tga", 0, 924)
mywindow:setTexture("Hover", "UIData/fightClub_001.tga",0, 945)
mywindow:setTexture("Pushed", "UIData/fightClub_001.tga", 0, 966)
mywindow:setTexture("PushedOff", "UIData/fightClub_001.tga", 0, 987)
mywindow:setPosition(385, 100)
mywindow:setSize(167, 21)
mywindow:setSubscribeEvent("Clicked", "ShowClubListInfo")
winMgr:registerCacheWindow("ClubListShowBtn")

------------------------------------------------------------------------------
--클럽원 (라디오버튼 레벨 레더 닉네임 클래스 직위 공헌도 접속일 위치)
------------------------------------------------------------------------------
Club_Member_Radio = 
{ ["protecterr"]=0, "Club_Member_Radio1", "Club_Member_Radio2", "Club_Member_Radio3" , "Club_Member_Radio4", "Club_Member_Radio5",
					"Club_Member_Radio6", "Club_Member_Radio7", "Club_Member_Radio8" , "Club_Member_Radio9", "Club_Member_Radio10",
					"Club_Member_Radio11", "Club_Member_Radio12", "Club_Member_Radio13" , "Club_Member_Radio14", "Club_Member_Radio15"}
	
ClubMemberText	= {['err'] = 0, 'MemberLevelText', 'MemberLadderText', 'MemberNickText',    'MemberClassText',
								'MemberGradeText', 'MemberhelpText'  , 'MemberLastLogText', 'MemberPositionText'}
								
ClubMemberTextPosX		= {['err'] = 0, 12, 22, 140 , 240 , 350 , 460, 520 , 510}
ClubMemberTextPosY		= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubMemberSizeX			= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubMemberSizeY			= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubMemberSetText		= {['err'] = 0, 'Level', 'Ladder', 'NickName', 'Class', 'Grade', 'HelpPoint', 'LastLog', 'Position'}



for i=1, #Club_Member_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Club_Member_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		0, 822)    
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",		0, 822)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",		0, 844)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",	0, 844)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga", 0, 844)
	mywindow:setSize(553, 21)
	mywindow:setPosition(0, 23+21*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:subscribeEvent("MouseRButtonUp", "OnClubMemberMouseRButtonUp")
	--mywindow:setUserString('Index', tostring(i))
	--mywindow:subscribeEvent("SelectStateChanged", "OnSelectedUserList")
	--mywindow:subscribeEvent("MouseRButtonUp", "OnUserListMouseRButtonUp")
	--mywindow:subscribeEvent("MouseDoubleClicked", "OnUserListDoubleClicked")
	--mywindow:subscribeEvent("MouseButtonDown", "OnUserListMouseDown")
	winMgr:registerCacheWindow(Club_Member_Radio[i])
	
	--  레벨 레더 닉네임 클래스 직위 공헌도 접속일 위치
	for j=1, #ClubMemberText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Club_Member_Radio[i]..ClubMemberText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(ClubMemberSizeX[j], ClubMemberSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(ClubMemberTextPosX[j], ClubMemberTextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(ClubMemberSetText[j], g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
		winMgr:registerCacheWindow(Club_Member_Radio[i]..ClubMemberText[j])
	end
	
	
	--  클럽 레더 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_Member_Radio[i].."ClubMemberLadderImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga",113, 600)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(30, 1)
		mywindow:setSize(47, 21)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:registerCacheWindow(Club_Member_Radio[i].."ClubMemberLadderImage")
		
	--  클럽 클래스  이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_Member_Radio[i].."ClubMemberClassImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga",113, 600)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)		
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(227, 0)
		mywindow:setSize(89, 35)
		mywindow:setLayered(true)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setScaleWidth(160)
		mywindow:setScaleHeight(160)
		winMgr:registerCacheWindow(Club_Member_Radio[i].."ClubMemberClassImage")
	
	
	
end

	


-----------------------------------------------------
--클럽 멤버 리스트에 사용되는 페이지앞뒤버튼
-----------------------------------------------------
Club_MemberList_BtnName  = {["err"]=0, "Club_MemberList_LBtn", "Club_MemberList_RBtn"}
Club_MemberList_BtnTexX  = {["err"]=0, 987, 970}
Club_MemberList_BtnPosX  = {["err"]=0, 220, 322}
Club_MemberList_BtnEvent = {["err"]=0, "OnClickClubMemberList_PrevPage", "OnClickClubMemberList_NextPage"}
for i=1, #Club_MemberList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_MemberList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", Club_MemberList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", Club_MemberList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", Club_MemberList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", Club_MemberList_BtnTexX[i], 0)
	mywindow:setPosition(Club_MemberList_BtnPosX[i], 350)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", Club_MemberList_BtnEvent[i])
	winMgr:registerCacheWindow(Club_MemberList_BtnName[i])
end

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_MemberList_PageText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setPosition(275, 355)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("Club_MemberList_PageText")

------------------------------------------------------------------------------
--클럽전적 (랭킹, 전적 , 클럽전 정보 , 라이벌 클럽 , 공헌도)
------------------------------------------------------------------------------

Club_Stats_Text =	{ ["protecterr"]=0, "Club_Stats_Ranking", "Club_Stats_Stat", "Club_Stats_RivalName", "Club_Stats_RivalStat"}
Club_Stats_Text_PosX  =    { ["protecterr"]=0, 50, 200, 50, 70 }
Club_Stats_Text_PosY  =    { ["protecterr"]=0, 30, 30, 250 , 280}	
for i=1 , #Club_Stats_Text do

	mywindow = winMgr:createWindow("TaharezLook/StaticText", Club_Stats_Text[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText(Club_Stats_Text[i])
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(Club_Stats_Text_PosX[i], Club_Stats_Text_PosY[i])
	mywindow:setSize(150, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow(Club_Stats_Text[i])
end





------------------------------------------------------------------------------
--클럽게시판
------------------------------------------------------------------------------
Club_Board_Radio = 
{ ["protecterr"]=0, "Club_Board_Radio1", "Club_Board_Radio2", "Club_Board_Radio3" , "Club_Board_Radio4", "Club_Board_Radio5",
					"Club_Board_Radio6", "Club_Board_Radio7", "Club_Board_Radio8" , "Club_Board_Radio9", "Club_Board_Radio10"}


ClubBoardText	= {['err'] = 0, 'BoardName', 'BoardMsg', 'BoardDay'}								
ClubBoardTextPosX		= {['err'] = 0, 60, 120, 460 }


for i=1, #Club_Board_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Club_Board_Radio[i])
	mywindow:setTexture("Normal", "UIData/fightClub_003.tga",0, 927)    
	mywindow:setTexture("Hover",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("Pushed",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("PushedOff",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("SelectedNormal",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("SelectedHover",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("SelectedPushed",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setTexture("SelectedPushedOff",  "UIData/fightClub_003.tga",0, 927)
	mywindow:setPosition(0, 9+(30*i))
	mywindow:setSize(557, 28)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	--mywindow:setEnabled(false)
	winMgr:registerCacheWindow(Club_Board_Radio[i])
	
	--  이름 내용 날짜
	for j=1, #ClubBoardText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Club_Board_Radio[i]..ClubBoardText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(ClubBoardTextPosX[j], 8)
		child_window:setViewTextMode(1)	
		if j==1 then
			child_window:setAlign(8)
		end
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(ClubMemberSetText[j], g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
		winMgr:registerCacheWindow(Club_Board_Radio[i]..ClubBoardText[j])
	end
	
		mywindow = winMgr:createWindow("TaharezLook/Button", Club_Board_Radio[i].."Club_Board_Delete")
		mywindow:setTexture("Normal", "UIData/fightClub_003.tga", 495, 708)
		mywindow:setTexture("Hover", "UIData/fightClub_003.tga", 511, 708)
		mywindow:setTexture("Pushed", "UIData/fightClub_003.tga", 527, 708)
		mywindow:setTexture("PushedOff", "UIData/fightClub_003.tga", 543, 708)
		mywindow:setPosition(530, 7)
		mywindow:setSize(16, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "OnClickBoardDelete")
		winMgr:registerCacheWindow(Club_Board_Radio[i].."Club_Board_Delete")
	
end

mywindow = winMgr:createWindow("TaharezLook/Button", "Club_Board_Button")
mywindow:setTexture("Normal", "UIData/fightClub_003.tga", 495, 636)
mywindow:setTexture("Hover", "UIData/fightClub_003.tga", 495, 654)
mywindow:setTexture("Pushed", "UIData/fightClub_003.tga", 495, 672)
mywindow:setTexture("PushedOff", "UIData/fightClub_003.tga", 495, 690)
mywindow:setPosition(460, 12)
mywindow:setSize(77, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickInsertBoard")
winMgr:registerCacheWindow("Club_Board_Button")

mywindow = winMgr:createWindow("TaharezLook/Editbox", "Club_Board_EditBox")
mywindow:setText("")
mywindow:setPosition(75, 10)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(400, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("Club_Board_EditBox")):setMaxTextLength(170)
mywindow:setSubscribeEvent("TextAccepted", "OnClickInsertBoard")
winMgr:registerCacheWindow("Club_Board_EditBox")
 
	
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Board_InputImage")
mywindow:setTexture("Enabled", "UIData/fightClub_003.tga",578, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_003.tga",578 , 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 10)
mywindow:setSize(446, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("Club_Board_InputImage")
	
-----------------------------------------------------
--클럽 게시판 리스트에 사용되는 페이지앞뒤버튼
-----------------------------------------------------

Club_BoardList_BtnName  = {["err"]=0, "Club_BoardList_LBtn", "Club_BoardList_RBtn"}
Club_BoardList_BtnTexX  = {["err"]=0, 987, 970}
Club_BoardList_BtnPosX  = {["err"]=0, 220, 322}
Club_BoardList_BtnEvent = {["err"]=0, "OnClickClubBoardList_PrevPage", "OnClickClubBoardList_NextPage"}
for i=1, #Club_BoardList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_BoardList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", Club_BoardList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", Club_BoardList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", Club_BoardList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", Club_BoardList_BtnTexX[i], 0)
	mywindow:setPosition(Club_BoardList_BtnPosX[i], 350)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", Club_BoardList_BtnEvent[i])
	winMgr:registerCacheWindow(Club_BoardList_BtnName[i])
end

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_BoardList_PageText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setPosition(275, 355)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("Club_BoardList_PageText")

 ---------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------
--클럽관리 (이름, 내용, 날짜 ,소개, 초대하기,직위설정, 클럽양도, 클럽폐쇄)
------------------------------------------------------------------------------

Club_Manage_Radio = 
{ ["protecterr"]=0, "Club_Manage_Radio1", "Club_Manage_Radio2", "Club_Manage_Radio3" , "Club_Manage_Radio4", "Club_Manage_Radio5",
					"Club_Manage_Radio6", "Club_Manage_Radio7", "Club_Manage_Radio8" , "Club_Manage_Radio9", "Club_Manage_Radio10"}


ClubManageText	= {['err'] = 0, 'ManageLevelText', 'ManageLadderText', 'ManageNickText',    'ManageClassText',
								'ManageGradeText', 'ManagehelpText'  , 'ManageLastLogText', 'ManagePositionText'}
								
ClubManageTextPosX	= {['err'] = 0, 12, 22, 140 , 240 , 350 , 460, 520 , 510}
ClubManageTextPosY	= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubManageSizeX		= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubManageSizeY		= {['err'] = 0, 5, 5, 5 ,5 , 5, 5 ,5 ,5}
ClubManageSetText	= {['err'] = 0, 'Level', 'Ladder', 'NickName', 'Class', 'Grade', 'HelpPoint', 'LastLog', 'Position'}

for i=1, #Club_Manage_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Club_Manage_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		0, 822)    
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",		0, 822)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",		0, 844)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",	0, 844)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",	 0, 844)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga", 0, 844)
	mywindow:setSize(553, 21)
	mywindow:setPosition(0, 23+21*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	--mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedClubMember")
	mywindow:subscribeEvent("MouseRButtonUp", "OnClubManageMouseRButtonUp")
	--mywindow:subscribeEvent("MouseDoubleClicked", "OnUserListDoubleClicked")
	--mywindow:subscribeEvent("MouseButtonDown", "OnUserListMouseDown")
	winMgr:registerCacheWindow(Club_Manage_Radio[i])
	
	--  레벨 레더 닉네임 클래스 직위 공헌도 접속일 위치
	for j=1, #ClubManageText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Club_Manage_Radio[i]..ClubManageText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(ClubManageSizeX[j], ClubManageSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(ClubManageTextPosX[j], ClubManageTextPosY[j])
		--child_window:setText("Text")
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(ClubManageSetText[j], g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
		winMgr:registerCacheWindow(Club_Manage_Radio[i]..ClubManageText[j])
	end
	
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_Manage_Radio[i].."ClubManageLadderImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga",113, 600)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(30, 1)
		mywindow:setSize(47, 21)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:registerCacheWindow(Club_Manage_Radio[i].."ClubManageLadderImage")
		
		--  클럽관리 클래스  이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_Manage_Radio[i].."ClubManageClassImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga",113, 600)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)		
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(227, 0)
		mywindow:setSize(89, 35)
		mywindow:setLayered(true)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setScaleWidth(160)
		mywindow:setScaleHeight(160)
		winMgr:registerCacheWindow(Club_Manage_Radio[i].."ClubManageClassImage")
		
end

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_Manage_Introduce")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:addTextExtends("Introduce", g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
	mywindow:setPosition(35, 300)
	mywindow:setSize(150, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("Club_Manage_Introduce")
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubIntroImage")
	mywindow:setTexture("Enabled", "UIData/fightClub_002.tga",871, 54)
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 871, 54)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 250)
	mywindow:setSize(76, 21)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("ClubIntroImage")
------------------------------------------------------------------------------
--클럽 관리(Manage) 모두삭제 변경완료 초대하기 직위설정 클럽양도 클럽폐쇄 버튼
------------------------------------------------------------------------------
Club_Manage_Button	     = {["err"]=0, "Club_Manage_Button_Delete", "Club_Manage_Button_Save", "Club_Manage_Button_Invite", 
								        "Club_Manage_Button_SetGrade" ,"Club_Manage_Button_Trans" , "Club_Manage_Button_Close"}
Club_Manage_ButtonEvent  = {["err"]=0, "Club_Manage_Delete_Event" ,	"Club_Manage_Save_Event", "Club_Manage_Invite_Event", 
										"Club_Manage_SetGrade_Event", "Club_Manage_Trans_Event", "Club_Manage_Close_Event"}					 
Club_Manage_ButtonTexX   = {["err"]=0, 912, 912 , 560 , 648 , 736,  824}
Club_Manage_ButtonPosX   = {["err"]=0, 200, 275 , 361, 454 ,361 ,454}
Club_Manage_ButtonPosY   = {["err"]=0, 350, 350 , 270, 270, 310, 310}


for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_Manage_Button[i])
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 75+(i*72)-72)
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 93+(i*72)-72)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 111+(i*72)-72)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 111+(i*72)-72)
	mywindow:setPosition(Club_Manage_ButtonPosX[i], Club_Manage_ButtonPosY[i])
	mywindow:setSize(77, 18)
	mywindow:setSubscribeEvent("Clicked", Club_Manage_ButtonEvent[i])
	winMgr:registerCacheWindow(Club_Manage_Button[i])
end

for i=3, 6 do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_Manage_Button[i])
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 75)
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 111)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 147)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga", Club_Manage_ButtonTexX[i], 75)
	mywindow:setPosition(Club_Manage_ButtonPosX[i], Club_Manage_ButtonPosY[i])
	mywindow:setSize(88, 36)
	mywindow:setSubscribeEvent("Clicked", Club_Manage_ButtonEvent[i])
	winMgr:registerCacheWindow(Club_Manage_Button[i])
end




-----------------------------------------------------
--클럽 관리(Manage) 리스트에 사용되는 페이지앞뒤버튼
-----------------------------------------------------
Club_ManageList_BtnName  = {["err"]=0, "Club_ManageList_LBtn", "Club_ManageList_RBtn"}
Club_ManageList_BtnTexX  = {["err"]=0, 987, 970}
Club_ManageList_BtnPosX  = {["err"]=0, 220, 322}
Club_ManageList_BtnEvent = {["err"]=0, "OnClickClubManageList_PrevPage", "OnClickClubManageList_NextPage"}
for i=1, #Club_MemberList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_ManageList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", Club_ManageList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", Club_ManageList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", Club_ManageList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", Club_ManageList_BtnTexX[i], 0)
	mywindow:setPosition(Club_ManageList_BtnPosX[i], 245)
	mywindow:setSize(17, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", Club_ManageList_BtnEvent[i])
	winMgr:registerCacheWindow(Club_ManageList_BtnName[i])
end

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_ManageList_PageText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setPosition(275, 250)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("Club_ManageList_PageText")





-------------------------------------------------------------------------------------------
--클럽 매니저 라디오 버튼에 사용되는 팝업 윈도우들 
-------------------------------------------------------------------------------------------

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Club_PopupWindow');
mywindow:setPosition(773, 32);
mywindow:setSize(94, 100);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 530, 406);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
winMgr:registerCacheWindow('Club_PopupWindow');


Club_PopupLine  = {["err"]=0,  "pu_Topline", "pu_Bottomline"}
Club_PopupLineTexX	 = {['err'] = 0,  0, 0}
Club_PopupLineTexY	 = {['err'] = 0, 311, 311}
Club_PopupLinePosX	 = {['err'] = 0,  0, 0}
Club_PopupLinePosY	 = {['err'] = 0,  0, 250}
Club_PopupLineSizeX = {['err'] = 0,  94, 94}
Club_PopupLineSizeY = {['err'] = 0,  2, 2}

for i=1, #Club_PopupLine do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_PopupLine[i])
	mywindow:setTexture("Enabled", "UIData/messenger.tga",	Club_PopupLineTexX[i], Club_PopupLineTexY[i])
	mywindow:setTexture("Disabled", "UIData/messenger.tga", Club_PopupLineTexX[i], Club_PopupLineTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(Club_PopupLinePosX[i], Club_PopupLinePosY[i])
	mywindow:setSize(Club_PopupLineSizeX[i], Club_PopupLineSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:registerCacheWindow(Club_PopupLine[i]);
end

-------------------------------------------------------------------------
--서브용
------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Club_PopupSubWindow');
mywindow:setPosition(773, 32);
mywindow:setSize(94, 100);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 530, 406);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
winMgr:registerCacheWindow('Club_PopupSubWindow');


Club_SubPopupLine  = {["err"]=0,  "pu_SubTopline", "pu_SubBottomline"}
Club_SubPopupLineTexX	 = {['err'] = 0,  0, 0}
Club_SubPopupLineTexY	 = {['err'] = 0, 311, 311}
Club_SubPopupLinePosX	 = {['err'] = 0,  0, 0}
Club_SubPopupLinePosY	 = {['err'] = 0,  0, 250}
Club_SubPopupLineSizeX = {['err'] = 0,  94, 94}
Club_SubPopupLineSizeY = {['err'] = 0,  2, 2}

for i=1, #Club_SubPopupLine do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", Club_SubPopupLine[i])
	mywindow:setTexture("Enabled", "UIData/messenger.tga",	Club_SubPopupLineTexX[i], Club_SubPopupLineTexY[i])
	mywindow:setTexture("Disabled", "UIData/messenger.tga", Club_SubPopupLineTexX[i], Club_SubPopupLineTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(Club_SubPopupLinePosX[i], Club_SubPopupLinePosY[i])
	mywindow:setSize(Club_SubPopupLineSizeX[i], Club_SubPopupLineSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:registerCacheWindow(Club_SubPopupLine[i]);
end


--------------------------------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'Club_Popuptext');
mywindow:setPosition(0, 0);
mywindow:setSize(94, 22);
mywindow:setAlign(7);
mywindow:setViewTextMode(1);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setEnabled(false)
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setProperty('Text', 'test3');
winMgr:registerCacheWindow('Club_Popuptext');


Club_PopupButtonName =
{ ["protecterr"]=0, "Club_Popup_agreeJoin", "Club_Popup_refuseJoin", "Club_Popup_AdMin", "Club_Popup_Info", "Club_Popup_AddFriend", 
					"Club_Popup_out", "Club_Popup_grade1", "Club_Popup_grade2", "Club_Popup_grade3", "Club_Popup_grade4", 
					"Club_Popup_grade5", "Club_Popup_chatToUser", "Club_Popup_partySecession", "Club_Popup_partyCommission" }
nPositionY = 22

for i=1, #Club_PopupButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Club_PopupButtonName[i])
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga",		842, 221+nPositionY*(i-1))
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga",		560, 221+nPositionY*(i-1))
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",		654, 221+nPositionY*(i-1))
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",		748, 221+nPositionY*(i-1))
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",	748, 221+nPositionY*(i-1))
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1))
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1))
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1))
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga", 748, 221+nPositionY*(i-1))
	mywindow:setSize(94, 22)
	mywindow:setPosition(0, nPositionY*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	--mywindow:setSubscribeEvent('MouseLeave', 'OnPopupMouseLeave');
	if i < 7 then 
	mywindow:setSubscribeEvent('MouseEnter', 'OnPopupMouseMove');
	
	end
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelectedClubPopup")
	winMgr:registerCacheWindow(Club_PopupButtonName[i])
	
	if i > 6 then
	local child_window = winMgr:createWindow("TaharezLook/StaticText", Club_PopupButtonName[i].."ClubPopupText")	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(40,3)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	--child_window:addTextExtends("Grade", g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
	winMgr:registerCacheWindow(Club_PopupButtonName[i].."ClubPopupText")
	end
	
end


--------------------------------------------------------------------------------------------
--클럽 리스트-- (클랜이 없는사람들한테 보여지는 창)
--------------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FightClub_ClubListWindow")
mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 555, 573)
mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 555, 573)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(50 ,200);
mywindow:setSize(469,427)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("FightClub_ClubListWindow")

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "ClubList_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(430, 26)
winMgr:registerCacheWindow("ClubList_titlebar")



--------------------------------------------------------------------------------------------
--클럽 리스트에 사용되는 라디오 버튼-- (클랜 랭킹, 레벨, 클럽명, 클럽원)
--------------------------------------------------------------------------------------------

Club_List_Radio = 
{ ["protecterr"]=0, "Club_List_Radio1", "Club_List_Radio2", "Club_List_Radio3" , "Club_List_Radio4", "Club_List_Radio5",
					"Club_List_Radio6", "Club_List_Radio7", "Club_List_Radio8" , "Club_List_Radio9", "Club_List_Radio10"}


ClubListText	= {['err'] = 0, 'ListRanKingText', 'ListLevelText', 'ListClubName', 'ListMemberText',
								'ListMasterText', 'ListChinghoText', 'ListIntroText' , 'ListClubEmblemKey' , 'ListClubKey' , 'ListClubStats'}
								
ClubListTextPosX	= {['err'] = 0, 25, 70, 140 , 285 , 380, 0, 5 ,0 ,0 , 225 }
ClubListTextPosY	= {['err'] = 0, 2, 2, 2 ,2 ,2 ,2, 2 ,2,	2 ,2 }
ClubListSizeX		= {['err'] = 0, 5, 5, 5 ,5 ,5 ,5 ,5 , 5, 5 ,5}
ClubListSizeY		= {['err'] = 0, 5, 5, 5 ,5 ,5 ,5 ,5 , 5, 5 , 5}
ClubListSetText	= {['err'] = 0, 'RanKing', 'Level', 'ClubName','Member', 'Master', 'ChinHo', 'Intro' ,'Stats'}

for i=1, #Club_List_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Club_List_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		367, 487)    --오버이미지 준비중
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",		0, 866)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",		0, 883)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",	0, 883)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",	 0, 883)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",	0, 883)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",	 0, 883)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga", 0, 883)
	mywindow:setSize(447, 17)
	mywindow:setPosition(10, 111+17*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedClubList")
	winMgr:registerCacheWindow(Club_List_Radio[i])
	
	--랭킹 레벨 클럽이름 멤버수 마스터 전적
	for j=1, #ClubListText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Club_List_Radio[i]..ClubListText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(ClubListSizeX[j], ClubListSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(ClubListTextPosX[j], ClubListTextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(ClubListSetText[j], g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
		winMgr:registerCacheWindow(Club_List_Radio[i]..ClubListText[j])
	end
		
end

----------------------------------------------------------------
--이미 가입신청한 클럽 이름을 보여준다
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_List_ProposeName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setViewTextMode(1)	
mywindow:setLineSpacing(1)
mywindow:setPosition(160, 400)
--mywindow:addTextExtends('proposeclub', g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
mywindow:setSize(5, 5)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow("Club_List_ProposeName")

---------------------------------------------------------------
--클럽리스트에서 선택한 클럽의 클럽마크를 표시해주는 이미지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Club_List_Emble')
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(19, 9)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setSize(32, 32)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('Club_List_Emble')
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------
--클럽 리스트에 사용되는 페이지앞뒤버튼
-----------------------------------------------------
Club_List_BtnName  = {["err"]=0, "Club_List_LBtn", "Club_List_RBtn"}
Club_List_BtnTexX  = {["err"]=0, 969, 987}
Club_List_BtnPosX  = {["err"]=0, 188, 292}
Club_List_BtnEvent = {["err"]=0, "OnClickClubList_PrevPage", "OnClickClubList_NextPage"}
for i=1, #Club_List_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_List_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", Club_List_BtnTexX[i], 66)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", Club_List_BtnTexX[i], 88)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", Club_List_BtnTexX[i], 110)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", Club_List_BtnTexX[i], 66)
	mywindow:setPosition(Club_List_BtnPosX[i], 290)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", Club_List_BtnEvent[i])
	winMgr:registerCacheWindow(Club_List_BtnName[i])
end

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Club_List_PageText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setPosition(245, 295)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow("Club_List_PageText")
	
-----------------------------------------------------
--클럽 리스트에 사용되는 페이지앞뒤버튼(10개씩)
-----------------------------------------------------
Club_List_10BtnName  = {["err"]=0, "Club_List_10LBtn", "Club_List_10RBtn"}
Club_List_10BtnTexX  = {["err"]=0, 964, 987}
Club_List_10BtnPosX  = {["err"]=0, 166, 307}
Club_List_10BtnEvent = {["err"]=0, "OnClickClubList_10PrevPage", "OnClickClubList_10NextPage"}
for i=1, #Club_List_10BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_List_10BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", Club_List_10BtnTexX[i], 132)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", Club_List_10BtnTexX[i], 154)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", Club_List_10BtnTexX[i], 176)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", Club_List_10BtnTexX[i], 132)
	mywindow:setPosition(Club_List_10BtnPosX[i], 290)
	mywindow:setSize(22, 22)
	mywindow:setSubscribeEvent("Clicked", Club_List_10BtnEvent[i])
	winMgr:registerCacheWindow(Club_List_10BtnName[i])
end
	
-----------------------------------------------------
--클럽리스트, 클럽네임, 클럽초대창, 클럽양도창에 사용되는 종료버튼
-----------------------------------------------------
Club_Close_BtnName  = {["err"]=0, "Club_Close_List", "Club_Close_Name" , "Club_Close_Invite" , "Club_Close_Give" ,"Club_Close_GradeName"}
Club_Close_BtnPosX  = {["err"]=0, 438, 538 , 255, 255 , 460}
Club_Close_BtnEvent = {["err"]=0, "OnClickClubList_Close", "OnClickClubName_Close" , "OnClickClubInvite_Close", "OnClickClubGive_Close" , "OnClickClubGradeName_Close"}
for i=1, #Club_Close_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Club_Close_BtnName[i])
	mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
	mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setPosition(Club_Close_BtnPosX[i], 8)
	mywindow:setSize(23, 23)
	
	mywindow:setSubscribeEvent("Clicked", Club_Close_BtnEvent[i])
	winMgr:registerCacheWindow(Club_Close_BtnName[i])
end

-----------------------------------------------------
--클럽 리스트의 클럽 클릭시 나오는 정보창
-----------------------------------------------------
Club_List_ClickInfo  = {["err"]=0, "Club_ClickInfo_Name", "Club_ClickInfo_Level","Club_ClickInfo_Master","Club_ClickInfo_ChingHo",
								   "Club_ClickInfo_Member","Club_ClickInfo_Ranking","Club_ClickInfo_Introduce"}
Club_ClickInfo_PosX  = {["err"]=0, 330, 400, 370, 370, 370, 370, 18}
Club_ClickInfo_PosY  = {["err"]=0, 90, 90, 125, 165, 200, 235, 325}
Club_ClickInfo_Text  = {["err"]=0, "ClubName", "Level", "", "", "Member", "Ranking", ""}

for i=1, #Club_List_ClickInfo do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", Club_List_ClickInfo[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setViewTextMode(1)	
	--mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	--mywindow:addTextExtends(Club_ClickInfo_Text[i], g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
	mywindow:setPosition(Club_ClickInfo_PosX[i], Club_ClickInfo_PosY[i])
	mywindow:setSize(150, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:registerCacheWindow(Club_List_ClickInfo[i])
end

-----------------------------------------------------
--클럽 리스트의 가입신청 버튼
-----------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "Club_Join_Want")
	mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 937, 293)
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 937, 398)
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga", 937, 293)
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga", 937, 328)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga", 937, 363)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga", 937, 398)
	mywindow:setPosition(375, 320)
	mywindow:setSize(84, 35)
	mywindow:setSubscribeEvent("Clicked", "OnClickClubJoinWant")
	winMgr:registerCacheWindow("Club_Join_Want")
	

-----------------------------------------------------
--클럽 리스트의 가입취소 버튼
-----------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "Club_Join_Cancel")
	mywindow:setTexture("Enabled", "UIData/fightClub_002.tga", 937, 433)
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga", 937, 538)
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga", 937,433)
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga", 937, 468)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga", 937, 503)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga", 937, 538)
	mywindow:setPosition(375, 355)
	mywindow:setSize(84, 35)
	mywindow:setSubscribeEvent("Clicked", "OnClickClubJoinCancel")
	winMgr:registerCacheWindow("Club_Join_Cancel")

-----------------------------------------------------
--클럽 리스트의 검색에디트 박스
-----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Club_List_EditBox")
mywindow:setText("")
mywindow:setPosition(112, 56)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(200, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("Club_List_EditBox")):setMaxTextLength(14)
mywindow:setSubscribeEvent("TextAccepted", "OnClickSearchClub")
winMgr:registerCacheWindow("Club_List_EditBox")
 -----------------------------------------------------
--클럽 리스트의 검색확인 버튼
-----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Club_Search_Button")
mywindow:setTexture("Normal", "UIData/fightClub_002.tga", 936, 221)
mywindow:setTexture("Hover", "UIData/fightClub_002.tga", 936, 239)
mywindow:setTexture("Pushed", "UIData/fightClub_002.tga", 936, 257)
mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga", 936, 275)
mywindow:setPosition(330, 56)
mywindow:setSize(77, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickSearchClub")
winMgr:registerCacheWindow("Club_Search_Button")









--------------------------------------------------------------------------------------------
--클럽초대하기, 양도하기  백판
--------------------------------------------------------------------------------------------
ClubManage_Image  = {["err"]=0, "ClubManage_InviteImage", "ClubManage_TransImage"}

for i=1, #ClubManage_Image do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", ClubManage_Image[i])
	mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(30 ,200);
	mywindow:setSize(296, 220)
	mywindow:setEnabled(true)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:registerCacheWindow(ClubManage_Image[i])
end

ClubManage_Text  = {["err"]=0, "ClubManage_InviteText", "ClubManage_TransText"}


for i=1, #ClubManage_Text do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', ClubManage_Text[i])
	mywindow:setPosition(105, 70);
	mywindow:setSize(89, 22);
	--mywindow:setFont(g_STRING_FONT_DODUM, 115)
	--mywindow:setTextColor(255,230,230,255)
	mywindow:setVisible(true);
	mywindow:setViewTextMode(1);
	mywindow:setAlign(8);
	mywindow:setLineSpacing(1);
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	winMgr:registerCacheWindow(ClubManage_Text[i])
end
--------------------------------------------------------------------------------------------
--클럽초대하기, 클럽양도하기 EDITBOX
--------------------------------------------------------------------------------------------
ClubManage_EditBox  = {["err"]=0, "ClubManage_InviteEditbox", "ClubManage_TransEditbox"}
ClubManage_BtnEvent  = {["err"]=0, "OnClickInviteMember",  "OnClickIGive"}
for i=1, #ClubManage_EditBox do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", ClubManage_EditBox[i])
	mywindow:setText("")
	mywindow:setPosition(80, 120)
	--mywindow:setAlphaWithChild(0)
	--mywindow:setUseEventController(false)
	mywindow:setSize(140, 23)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	CEGUI.toEditbox(winMgr:getWindow(ClubManage_EditBox[i])):setMaxTextLength(35)
	winMgr:getWindow(ClubManage_EditBox[i]):setSubscribeEvent("TextAccepted", ClubManage_BtnEvent[i])
	winMgr:registerCacheWindow(ClubManage_EditBox[i])
end

-----------------------------------------------------
--클럽 초대하기 입력 버튼,  클럽양도(검색하기, 양도하기)
-----------------------------------------------------
ClubManage_Btn  = {["err"]=0, "Club_Invite_Btn",  "Club_Give_Btn"}
--ClubManage_BtnEvent  = {["err"]=0, "OnClickInviteMember",  "OnClickIGive"}

--ClubManage_BtnTexX  = {["err"]=0, 987, 970}
ClubManage_BtnPosX  = {["err"]=0, 5, 5}
ClubManage_BtnPosY  = {["err"]=0, 178, 178}

for i=1, #ClubManage_Btn do
	mywindow = winMgr:createWindow("TaharezLook/Button", ClubManage_Btn[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", 590, 684)
	mywindow:setTexture("Hover", "UIData/deal.tga", 590, 713)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 742)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 771)
	mywindow:setPosition(ClubManage_BtnPosX[i], ClubManage_BtnPosY[i])
	mywindow:setSize(286, 29)
	mywindow:setSubscribeEvent("Clicked", ClubManage_BtnEvent[i])
	winMgr:registerCacheWindow(ClubManage_Btn[i])
end




--------------------------------------------------------------------
--클럽소개 작성용 에디트 박스
--------------------------------------------------------------------

ClubIntroWrite =
{ ["protecterr"]=0, "ClubIntroWrite_1", "ClubIntroWrite_2", "ClubIntroWrite_3"}

tClubIntroEditEvent= 
{['protecterr'] = 0,  "NextClubIntroEdit1", "NextClubIntroEdit2", "NextClubIntroEdit3" }

tClubIntroWriteBoxPosX	= {['err'] = 0, 0,0,0}
tClubIntroWriteBoxPosY	= {['err'] = 0, 270,290,310}
tClubIntroWriteSizeX     = {['err'] = 0, 360,360,360}
tClubIntroWriteSizeY     = {['err'] = 0, 23,23,23}
tClubIntroSetMatText     = {['err'] = 0, 160,160,170}
for i=1 , 3 do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", ClubIntroWrite[i])
	mywindow:setText("")
	mywindow:setPosition(tClubIntroWriteBoxPosX[i], tClubIntroWriteBoxPosY[i])
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(tClubIntroWriteSizeX[i], tClubIntroWriteSizeY[i])
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	CEGUI.toEditbox(winMgr:getWindow(ClubIntroWrite[i])):setMaxTextLength(tClubIntroSetMatText[i])
	CEGUI.toEditbox(winMgr:getWindow(ClubIntroWrite[i])):subscribeEvent("EditboxFull", "ClubIntroEditFull")
	CEGUI.toEditbox(winMgr:getWindow(ClubIntroWrite[i])):subscribeEvent("TextAccepted", tClubIntroEditEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(ClubIntroWrite[i])):subscribeEvent("TextAcceptedBack", "ClubIntroEditEventBack")
	winMgr:registerCacheWindow(ClubIntroWrite[i])
end


winMgr:getWindow("ClubIntroWrite_1"):setEnabled(true)
winMgr:getWindow("ClubIntroWrite_1"):activate()



--------------------------------------------------------------------
--클럽직위설정 관련 백판
--------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubManage_SetGradeNameWindow")
mywindow:setTexture("Enabled", "UIData/fightClub_003.tga", 0, 656)
mywindow:setTexture("Disabled", "UIData/fightClub_003.tga", 0, 656)  
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(300 ,150);
mywindow:setSize(493,266)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:registerCacheWindow("ClubManage_SetGradeNameWindow")



--------------------------------------------------------------------
--클럽직위관련 에디트박스
--------------------------------------------------------------------

ClubManage_SetGradeEditBox  = {["err"]=0, "ClubManage_SetGradeEditBox1", "ClubManage_SetGradeEditBox2" ,"ClubManage_SetGradeEditBox3",
										  "ClubManage_SetGradeEditBox4", "ClubManage_SetGradeEditBox5" , "ClubManage_SetGradeEditBox6"}


ClubManage_SetGradeEvent= 
{['protecterr'] = 0, "NextGradeEdit2", "NextGradeEdit3", "NextGradeEdit4", "NextGradeEdit5", "NextGradeEdit6" ,"NextGradeEdit1"}


CMSetGradeEditBoxPosX	= {['err'] = 0, 20, 20, 20, 20, 20, 20}
CMSetGradeEditBoxPosY	= {['err'] = 0, 80, 117, 147, 167, 187, 207}


for i=1, #ClubManage_SetGradeEditBox do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", ClubManage_SetGradeEditBox[i])
	mywindow:setText("aaa")
	mywindow:setPosition(CMSetGradeEditBoxPosX[i], CMSetGradeEditBoxPosY[i])
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(120, 23)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	CEGUI.toEditbox(winMgr:getWindow(ClubManage_SetGradeEditBox[i])):subscribeEvent("TextAcceptedOnlyTab", ClubManage_SetGradeEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(ClubManage_SetGradeEditBox[i])):subscribeEvent("TextAccepted", ClubManage_SetGradeEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(ClubManage_SetGradeEditBox[i])):setMaxTextLength(10)
	winMgr:registerCacheWindow(ClubManage_SetGradeEditBox[i])
end


--------------------------------------------------------------------
--클럽직위관련 입력확인 버튼
--------------------------------------------------------------------


mywindow = winMgr:createWindow("TaharezLook/Button", "ClubManage_SetGradeBtn")
mywindow:setTexture("Normal", "UIData/fightClub_003.tga", 495, 724)
mywindow:setTexture("Hover", "UIData/fightClub_003.tga", 495, 749)
mywindow:setTexture("Pushed", "UIData/fightClub_003.tga", 495, 774)
mywindow:setTexture("PushedOff", "UIData/fightClub_003.tga", 495, 799)
mywindow:setPosition(185, 233)
mywindow:setSize(157, 25)
mywindow:setSubscribeEvent("Clicked", "OnClickSetGrade")
winMgr:registerCacheWindow("ClubManage_SetGradeBtn")



---------------------------------------
--클럽마크
----------------------------------------------------------

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Club_clubEmbleImage')
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(19, 9)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setSize(32, 32)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('Club_clubEmbleImage')


-------------------------------------------------------------
--클럽 가입대기자 알림말풍선
-------------------------------------------------------------


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Club_Notice_baloon")
mywindow:setTexture("Enabled", "UIData/fightClub_003.tga", 572, 663)
mywindow:setTexture("Disabled", "UIData/fightClub_003.tga", 572, 663)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setEnabled(false)
mywindow:setPosition(0, 42)
mywindow:setSize(84, 61)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:registerCacheWindow('Club_Notice_baloon');

