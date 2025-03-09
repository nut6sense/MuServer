--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

MyClubGrade = 5

local CLUBWAR_MAXCOUNT = 16
local CHAMPIONSHIP_MAXCOUNT = 16
local ChampionshipTeamCount = 2



----------------------------------------------------------------------
-- NPC UI 호출 버튼 ( NPC한테 말걸어서 버튼누를시)
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowNpcUiBtn")
mywindow:setTexture("Normal", "UIData/fightclub_003.tga", 495, 724)
mywindow:setTexture("Hover", "UIData/fightclub_003.tga", 495, 749)
mywindow:setTexture("Pushed", "UIData/fightclub_003.tga", 495, 774)
mywindow:setTexture("PushedOff", "UIData/fightclub_003.tga", 495, 799)
mywindow:setPosition(260, 10)
mywindow:setSize(157, 25)
mywindow:setVisible(false)
mywindow:setSubscribeEvent("Clicked", "OnClickShowNpcUiBtn")
root:addChildWindow(mywindow)

function OnClickShowNpcUiBtn()
	TalkToClubWarNpc()
end

----------------------------------------------------------------------
-- 구역점령전 상태
----------------------------------------------------------------------
function ChangeClubWarState(ClubWarState, ClubJoin)
	
	if CheckNpcModeforLua() == false then	-- 클럽워 NPC랑 대화중일시
		
		if ClubWarState > 1 and IsPartyJoined() == false then  -- 클럽워가 진행중이거나 파티가 없을시 토너먼트 UI 표시
			
			if CheckfacilityData(FACILITYCODE_GANG_WAR) == 1 then
				winMgr:getWindow('ShowTourBoardBtn'):setVisible(true)
			end
			
			if ClubJoin == 1 then  -- 클럽에 가입되었을시만
				winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
			end
		else
			winMgr:getWindow('ShowTourBoardBtn'):setVisible(false)
			winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
		end	
	end
end
----------------------------------------------------------------------
-- 점령전 NPC와 대화할때 나오는 팝업창 종류 설정
----------------------------------------------------------------------
function TalkToClubWarNpc()
	
	local ClubGrade, ClubWarState = OccupationGetNpcInfo()
    winMgr:getWindow('ClubWarNpcBackImage1'):setVisible(false)
    winMgr:getWindow('ClubWarNpcBackImage2'):setVisible(false)
    winMgr:getWindow('ClubWarNpcBackImage3'):setVisible(false)
    winMgr:getWindow("ClubWarTourBoardImage"):setVisible(false)	
    
    if ClubWarState == 0 then  -- 클럽워 없을시
    
		OccupationGetGuildList()
		root:addChildWindow(winMgr:getWindow('ClubWarNpcBackImage1'))
		winMgr:getWindow('ClubWarNpcBackImage1'):setVisible(true)
			
	elseif ClubWarState ==1 then  -- 클럽 신청기간일때
		
		OccupationGetGuildList()
		root:addChildWindow(winMgr:getWindow('ClubWarNpcBackImage1'))
		winMgr:getWindow('ClubWarNpcBackImage1'):setVisible(true)
			
		if ClubGrade < 6 then  
			OccupationGetRegistedMyGuild()
			CheckMyClubMoney()
			root:addChildWindow(winMgr:getWindow('ClubWarNpcBackImage2'))
			winMgr:getWindow('ClubWarNpcBackImage2'):setVisible(true)
			winMgr:getWindow('ClubWarNpcBackImage3'):setVisible(true)
		end
			
	else -- 클럽워 진행중
		OnClickShowTourBoard()
		winMgr:getWindow('ClubWarTourBoardImage'):setVisible(true)
		
	end

end

----------------------------------------------------------------------
-- 광장 포탈로 들어갈때
----------------------------------------------------------------------
function CheckClubZone()
	if winMgr:getWindow('ShowTourBoardBtn'):isVisible() == true then
		OnClickShowTourBoard()
		root:addChildWindow(winMgr:getWindow('ClubWarNpcBackImage3'))
		winMgr:getWindow('ClubWarTourBoardImage'):setVisible(true)
	else
		local STRING_PREPARING = PreCreateString_1478	--GetSStringInfo(LAN_CPP_LOBBY_5) 
		ShowNotifyOKMessage_Lua(STRING_PREPARING)
		SetInputEnable(true)
	end
end

function ShowClubWarUiButton(bShow)
	
	if CheckfacilityData(FACILITYCODE_GANG_WAR) == 0 then
		winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
		winMgr:getWindow('ShowTourBoardBtn'):setVisible(false)
		return
	end
	if bShow == true then
		OccupationGetInfo()
	else
		winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
		winMgr:getWindow('ShowTourBoardBtn'):setVisible(false)
	end
end

-- 필드에서 사용할때 위치를 변경해준다
function ShowFieldEntryUiButton(bShow)
	MyClubGrade = CheckMyClubGrade()
	if bShow == true then
		if MyClubGrade == 0 then
			winMgr:getWindow('ShowTourEntryFieldSettingBtn'):setVisible(false)
		else
			winMgr:getWindow('ShowTourEntryFieldSettingBtn'):setVisible(false)
		end
	else
		winMgr:getWindow('ShowTourEntryFieldSettingBtn'):setVisible(false)
	end
end

---------------------------------------------------------------------
--ClubWar NPC 백판1 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage1")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 578, 22)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 578, 22)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(60,110);
mywindow:setSize(334, 471)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
---------------------------------------------------------------------
--ClubWar NPC 백판2 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage2")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 692, 493)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 692, 493)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(650, 110);
mywindow:setSize(332, 251)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

---------------------------------------------------------------------
--ClubWar NPC 백판3
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage3")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 804, 745)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 804, 745)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(650,390);
mywindow:setSize(220,197)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

------------------------------------------------------------------
-- ClubWar NPC 백판 닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseClubWarNPCBtn");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(300, 6)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseClubWarNPC");
winMgr:getWindow("ClubWarNpcBackImage1"):addChildWindow(mywindow)

function OnClickCloseClubWarNPC() -- NPC UI 종료시
	VirtualImageSetVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage1"):setVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage2"):setVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage3"):setVisible(false)
	winMgr:getWindow("ClubWarTourBoardImage"):setVisible(false)
	TownNpcEscBtnClickEvent()
end

function CloseClubWarNPC() -- NPC UI 종료시
	VirtualImageSetVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage1"):setVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage2"):setVisible(false)
	winMgr:getWindow("ClubWarNpcBackImage3"):setVisible(false)
	winMgr:getWindow("ClubWarTourBoardImage"):setVisible(false)	
end
RegistEscEventInfo("ClubWarNpcBackImage1", "CloseClubWarNPC")

---------------------------------------------------------------------
-- 토너먼트 대진표
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarTourBoardImage")
mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(100,100)
mywindow:setSize(811,491)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
--토너먼트 대진표 갱신버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowTourBoardBtn")
mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 172, 588)
mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 172, 616)
mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 172, 644)
mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 172, 588)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 172, 672)
--mywindow:setWideType(4)
--mywindow:setPosition(934, 583)
mywindow:setSize(86, 28)
mywindow:setVisible(false)
mywindow:setSubscribeEvent("Clicked", "OnClickShowTourBoard")
root:addChildWindow(mywindow)

function OnClickShowTourBoard()
	root:addChildWindow(winMgr:getWindow('ClubWarTourBoardImage'))
	winMgr:getWindow('ClubWarTourBoardImage'):setVisible(true)
	OccupationGetBattleSchedule()
end


RegistEscEventInfo("ClubWarTourBoardImage", "CloseTourBoard")

------------------------------------------------------------------
-- 토너먼트 대진표 닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseTourBoardBtn");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(775, 9)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseTourBoard");
winMgr:getWindow("ClubWarTourBoardImage"):addChildWindow(mywindow)

function OnClickCloseTourBoard()
	if CheckNpcModeforLua() then	
		VirtualImageSetVisible(false)
		TownNpcEscBtnClickEvent()
	else
		SetInputEnable(true)
	end
	winMgr:getWindow("ClubWarTourBoardImage"):setVisible(false)
end

function CloseTourBoard()
	winMgr:getWindow("ClubWarTourBoardImage"):setVisible(false)
	SetInputEnable(true)
	if CheckNpcModeforLua() then	
		VirtualImageSetVisible(false)		
	end
end

----- 클럽 토너먼트 신청한 길드 --------------------------------------------------------------------------------------------------
														   
ClubWarAppList_Text	= {['err'] = 0, 'ClubName', 'ClubMoney'}
ClubWarAppList_TextPosX =  { ["protecterr"]=0, 100 , 250}
ClubWarAppList_TextPosY =  { ["protecterr"]=0, 3 , 3 }
for i=1 , CLUBWAR_MAXCOUNT do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarAppList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 818, 676)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 818, 676)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition( 11 , 52+(i*19));
	mywindow:setSize(310, 18)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubWarNpcBackImage1'):addChildWindow(mywindow)
	
	for j=1, #ClubWarAppList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarAppList_image_"..i..ClubWarAppList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(ClubWarAppList_TextPosX[j], ClubWarAppList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
end


--------------------------------------------------------------------
-- 내클럽 현황 Text
--------------------------------------------------------------------
ClubWarNpcInfo_Text =	{ ["protecterr"]=0, "ClubWarNpcInfo_Name", "ClubWarNpcInfo_Money", "ClubWarWinnerMoney1" , "ClubWarWinnerMoney2" ,
											"ClubWarWinnerMoney3"}
											
ClubWarNpcInfo_PosX  =    { ["protecterr"]=0, 110, 260, 230, 230, 230}
ClubWarNpcInfo_PosY  =    { ["protecterr"]=0, 60, 60, 110, 130, 150 }
ClubWarNpcInfo_SetText =  {['err'] = 0, 'ClubName', '10000', '10000000','50000', '1000'}

for i=1 , #ClubWarNpcInfo_Text do

	mywindow = winMgr:createWindow("TaharezLook/StaticText", ClubWarNpcInfo_Text[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setSize(5, 5)
	mywindow:setVisible(true)
	mywindow:setPosition(ClubWarNpcInfo_PosX[i], ClubWarNpcInfo_PosY[i])
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	winMgr:getWindow('ClubWarNpcBackImage2'):addChildWindow(mywindow)
end


----------------------------------------------------------------------
-- 클럽은화 등록
----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Editbox", "ClubWarMoneyEditbox")
mywindow:setText("")
mywindow:setPosition(90, 130)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(110, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(winMgr:getWindow("ClubWarMoneyEditbox")):setMaxTextLength(10)
mywindow:setSubscribeEvent("TextAccepted", "OnClickInputClubWarMoney")
winMgr:getWindow('ClubWarNpcBackImage3'):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ClubWarMoneyCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(5, 5)
mywindow:setPosition(120, 85)
mywindow:setViewTextMode(1)	
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
mywindow:setTextExtends('0', g_STRING_FONT_GULIMCHE, 123,    255,255,255,255,     0,     0,0,0,255)
winMgr:getWindow('ClubWarNpcBackImage3'):addChildWindow(mywindow)
----------------------------------------------------------------------
-- 클럽은화 등록 버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ClubWarMoneyInputBtn")
mywindow:setTexture("Normal", "UIData/fightclub_003.tga", 495, 724)
mywindow:setTexture("Hover", "UIData/fightclub_003.tga", 495, 749)
mywindow:setTexture("Pushed", "UIData/fightclub_003.tga", 495, 774)
mywindow:setTexture("PushedOff", "UIData/fightclub_003.tga", 495, 799)
mywindow:setPosition(35, 160)
mywindow:setSize(157, 25)
mywindow:setSubscribeEvent("Clicked", "OnClickInputClubWarMoney")
winMgr:getWindow('ClubWarNpcBackImage3'):addChildWindow(mywindow)

function OnClickInputClubWarMoney()
	CheckRegistMoney = winMgr:getWindow("ClubWarMoneyEditbox"):getText()
	if CheckRegistMoney == "" then
		return
	end
	RegistFightMoney = tonumber(winMgr:getWindow("ClubWarMoneyEditbox"):getText())
	RegistMaxMoney = tonumber(winMgr:getWindow("ClubWarMoneyCount"):getText())

	if RegistFightMoney < 1 then
	    ShowCommonAlertOkBoxWithFunction(PreCreateString_2170, 'OnClickAlertOkSelfHide');--GetSStringInfo(LAN_INPUT_COUNT)
	    winMgr:getWindow("ClubWarMoneyEditbox"):setText("")
		return
	end
	
	if RegistFightMoney > RegistMaxMoney then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_1541, 'OnClickAlertOkSelfHide');--GetSStringInfo(LAN_CPP_VILLAGE_29)
		winMgr:getWindow("ClubWarMoneyEditbox"):setText("")
		return
	end
	OccupationRegistGuild(RegistFightMoney)
	winMgr:getWindow("ClubWarMoneyEditbox"):setText("")
end

----------------------------------------------------------------------
-- 추천서 등록한 클럽리스트 리셋
----------------------------------------------------------------------
function ResetOccupationGuildList()
	for i=1, CLUBWAR_MAXCOUNT do
		winMgr:getWindow("ClubWarAppList_image_"..i..ClubWarAppList_Text[1]):clearTextExtends()
		winMgr:getWindow("ClubWarAppList_image_"..i..ClubWarAppList_Text[2]):clearTextExtends()
	end
end

----------------------------------------------------------------------
-- 추천서 등록한 클럽리스트 업데이트
----------------------------------------------------------------------
function UpdateOccupationRegistedGuildList(index , ClubName, ClubMoney)
	winMgr:getWindow("ClubWarAppList_image_"..index..ClubWarAppList_Text[1]):setTextExtends(ClubName, g_STRING_FONT_GULIMCHE, 112,  230,230,230,255, 0,   0,0,0,255)
	local ClubMoneyCom = CommatoMoneyStr(ClubMoney)
	winMgr:getWindow("ClubWarAppList_image_"..index..ClubWarAppList_Text[2]):setTextExtends(ClubMoneyCom, g_STRING_FONT_GULIMCHE, 112,  230,230,230,255, 0,  0,0,0,255)
end

----------------------------------------------------------------------
-- 내 클럽 토너먼트 현황 ( 클럽은화 등록상태)
----------------------------------------------------------------------
function UpdateOccupationRegistedMyGuild(ClubName, ClubMoney, Reward1, Reward2, Reward3)
	winMgr:getWindow('ClubWarNpcInfo_Name'):setTextExtends(ClubName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	local ClubMoneyCom = CommatoMoneyStr(ClubMoney)
	winMgr:getWindow('ClubWarNpcInfo_Money'):setTextExtends(ClubMoneyCom, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	
	local RewardCom1 = CommatoMoneyStr(Reward1)
	local RewardCom2 = CommatoMoneyStr(Reward2)
	local RewardCom3= CommatoMoneyStr(Reward3)
	winMgr:getWindow('ClubWarWinnerMoney1'):setTextExtends(RewardCom1, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarWinnerMoney2'):setTextExtends(RewardCom2, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarWinnerMoney3'):setTextExtends(RewardCom3, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
end






--[[
----- 클럽 토너먼트 대진표 --------------------------------------------------------------------------------------------------
ClubTourBoard_Text	= {['err'] = 0, '8Left', '8Right', '9Left', '9Right' , '10Left', '10Right', '11Left', '11Right', '12Left', '12Right', 
								'13Left', '13Right' , '14Left', '14Right', '15Left', '15Right' , -- 첫째줄
								'4Left', '4Right' , '5Left', '5Right' ,'6Left', '6Right' , '7Left', '7Right', --둘째줄
								'2Left', '2Right' , '3Left', '3Right' ,'1Left', '1Right' ,'LastWinner'}  --셋째 넷째

--]]

----- 클럽 토너먼트 대진표 --------------------------------------------------------------------------------------------------
for i= 1,  15 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BoardPieceLeft"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 811, 103)
	mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 811, 76)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setEnabled(false)
	mywindow:setProperty("BackgroundEnabled", "False")
	if i > 7 and i < CLUBWAR_MAXCOUNT then
		mywindow:setPosition(20, 43+ (i-8)* 54)
	elseif i > 3 and i < 8 then
		mywindow:setPosition(177, 57+ (i-4)* 108)
	elseif i > 1 and i < 4 then
		mywindow:setPosition(334, 84+ (i-2)* 214)
	else
		mywindow:setPosition(491, 137)
	end
	mywindow:setSize(134, 27)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubWarTourBoardImage'):addChildWindow(mywindow)
	
	child_window = winMgr:createWindow("TaharezLook/StaticText", i..'Left')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(65, 7)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BoardPieceRight"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 811, 103)
	mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 811, 76)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setEnabled(false)
	mywindow:setProperty("BackgroundEnabled", "False")
	if i > 7 and i < CLUBWAR_MAXCOUNT then
		mywindow:setPosition(20, 70+ (i-8)* 54)
	elseif  i > 3 and i < 8 then
		mywindow:setPosition(177, 110+ (i-4)* 108)
	elseif  i > 1 and i < 4 then
		mywindow:setPosition(334, 190+ (i-2)* 214)
	else
		mywindow:setPosition(491, 351)
	end
	mywindow:setSize(134, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubWarTourBoardImage'):addChildWindow(mywindow)
	
	child_window = winMgr:createWindow("TaharezLook/StaticText", i..'Right')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(65, 7)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
	
	----------------------------------------------------------------------------
	--- 관전 버튼
	-----------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "ClubWarObserverBtn"..i)
	mywindow:setTexture("Normal", "UIData/fightclub_007.tga", 937, 0)
	mywindow:setTexture("Hover", "UIData/fightclub_007.tga", 937, 19)
	mywindow:setTexture("Pushed", "UIData/fightclub_007.tga", 937, 38)
	mywindow:setTexture("PushedOff", "UIData/fightclub_007.tga", 937, 19)
	mywindow:setPosition(290, i*20)
	mywindow:setSize(83, 19)
	mywindow:setAlwaysOnTop(true)
	if i > 7 and i < CLUBWAR_MAXCOUNT then
		mywindow:setPosition(205, 82+ (i-8)* 54)
	elseif  i > 3 and i < 8 then
		mywindow:setPosition(370, 109+ (i-4)* 107)
	elseif  i > 1 and i < 4 then
		mywindow:setPosition(524, 163+ (i-2)* 214)
	else
		mywindow:setPosition(680, 269)
	end
	mywindow:setUserString("ObserverIndex", 0)
	mywindow:setVisible(false)
	mywindow:setSubscribeEvent("Clicked", "OnClickClubWarObserver")
	winMgr:getWindow('ClubWarTourBoardImage'):addChildWindow(mywindow)
	
	----------------------------------------------------------------------------
	--- 관전중 이미지
	-----------------------------------------------------------------------------
	Subwindow = winMgr:createWindow("TaharezLook/StaticImage", "TourMathingImage"..i)
	Subwindow:setTexture("Enabled", "UIData/fightclub_007.tga", 811, 0)
	Subwindow:setTexture("Disabled", "UIData/fightclub_007.tga", 811, 0)
	Subwindow:setProperty("FrameEnabled", "False")
	Subwindow:setProperty("BackgroundEnabled", "False")
	Subwindow:setPosition(0, -20)
	Subwindow:setSize(70, 16)
	Subwindow:setAlwaysOnTop(true)
	Subwindow:setVisible(true)
	mywindow:addChildWindow(Subwindow)
	
	
	
end

function OnClickClubWarObserver(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;	
	local win_name = local_window:getName();
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("ObserverIndex"))
	MoveServerOccupation(index)
end
------------------------------------
-- 우승만 따로 해준다---
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BoardPieceWinner")
mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 811, 103)
mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 811, 76)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(650, 244)
mywindow:setSize(134, 27)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow('ClubWarTourBoardImage'):addChildWindow(mywindow)

child_window = winMgr:createWindow("TaharezLook/StaticText", 'LastWinner')	
child_window:setProperty("FrameEnabled", "false")
child_window:setProperty("BackgroundEnabled", "false")
child_window:setSize(5, 5)
child_window:setVisible(true)
child_window:setPosition(60, 7)
child_window:setViewTextMode(1)	
child_window:setAlign(8)
child_window:setLineSpacing(1)
mywindow:addChildWindow(child_window)

------------------------------------
-- 우승상금
------------------------------------
for i = 1, 3 do
	child_window = winMgr:createWindow("TaharezLook/StaticText", 'TourBoardReward'..i)	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(700, 401+i*19)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	child_window:setTextExtends('aaaaaaaaaa', g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarTourBoardImage'):addChildWindow(child_window)
end


----------------------------------------------------------------------
-- 클럽토너먼트  대진표 업데이트 
----------------------------------------------------------------------
function ResetOccupationGetBattleSchedule()
	for i = 1, 15 do
		winMgr:getWindow("BoardPieceRight"..i):setEnabled(false)
		winMgr:getWindow("BoardPieceLeft"..i):setEnabled(false)
	end
end
----------------------------------------------------------------------
-- 대진표 상금 갱신
----------------------------------------------------------------------
function UpdateBattleReward(Reward1, Reward2, Reward3)
	local Reward1Com = CommatoMoneyStr(Reward1)
	local r1,g1,b1 = GetGranColor(Reward1)
	winMgr:getWindow('TourBoardReward1'):setTextExtends(Reward1Com, g_STRING_FONT_GULIMCHE, 112,    r1,g1,b1,255,     0,     0,0,0,255)
	
	local Reward2Com = CommatoMoneyStr(Reward2)
	local r2,g2,b2 = GetGranColor(Reward2)
	winMgr:getWindow('TourBoardReward2'):setTextExtends(Reward2Com, g_STRING_FONT_GULIMCHE, 112,    r2,g2,b2,255,     0,     0,0,0,255)
	
	local Reward3Com = CommatoMoneyStr(Reward3)
	local r3,g3,b3 = GetGranColor(Reward3)
	winMgr:getWindow('TourBoardReward3'):setTextExtends(Reward3Com, g_STRING_FONT_GULIMCHE, 112,    r3,g3,b3,255,     0,     0,0,0,255)
end

function UpdateOccupationGetBattleSchedule(Index, LeftName, RightName, Winnername, FieldNumber , PlayResult)

	
	winMgr:getWindow("ClubWarObserverBtn"..Index):setUserString("ObserverIndex", FieldNumber)
	
	winMgr:getWindow(Index..'Left'):setTextExtends(LeftName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow(Index..'Right'):setTextExtends(RightName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	
	if Winnername == RightName  and Winnername ~= "" then
		winMgr:getWindow(Index..'Right'):setTextExtends(RightName, g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		winMgr:getWindow("BoardPieceRight"..Index):setEnabled(true)
	end
	
	if Winnername == LeftName and Winnername ~= "" then
		winMgr:getWindow(Index..'Left'):setTextExtends(LeftName, g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		winMgr:getWindow("BoardPieceLeft"..Index):setEnabled(true)
	end
	
	if FieldNumber < 1 then
		winMgr:getWindow("ClubWarObserverBtn"..Index):setVisible(false)
	else
		winMgr:getWindow("ClubWarObserverBtn"..Index):setVisible(true)
	end
	
	if Index == 1 then
		winMgr:getWindow('LastWinner'):setTextExtends(Winnername, g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,     0,0,0,255)
		if Winnername ~= "" then
			winMgr:getWindow('BoardPieceWinner'):setEnabled(true)
		else
			winMgr:getWindow('BoardPieceWinner'):setEnabled(false)
		end
	end
end


function SettingMyClubMoney(ClubMoney)
	local ClubMoneyCom = CommatoMoneyStr(ClubMoney)
	winMgr:getWindow('ClubWarMoneyCount'):setTextExtends(ClubMoneyCom, g_STRING_FONT_GULIMCHE, 123,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarMoneyCount'):setText(ClubMoney)
end

----------------------------------------------------------------------
--토너먼트 엔트리 설정버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowTourEntrySettingBtn")
mywindow:setTexture("Normal", "UIData/fightclub_007.tga", 0, 601)
mywindow:setTexture("Hover", "UIData/fightclub_007.tga", 0, 641)
mywindow:setTexture("Pushed", "UIData/fightclub_007.tga", 0, 681)
mywindow:setTexture("PushedOff", "UIData/fightclub_007.tga", 0, 681)
mywindow:setPosition(13, 100)
mywindow:setSize(140, 40)
mywindow:setVisible(false)
mywindow:setSubscribeEvent("Clicked", "OnClickShowEntrySetting")
root:addChildWindow(mywindow)

function OnClickShowEntrySetting()
	root:addChildWindow(winMgr:getWindow('ClubWarEntrySetupBackImage'))
	winMgr:getWindow('ClubWarEntrySetupBackImage'):setVisible(true)
	g_TourEntryInviteListPage = 1
	OccupationEntryGet() -- 엔트리 요청
	--RefreshTourEntryInviteList()
end


----------------------------------------------------------------------
--토너먼트 엔트리 설정버튼( 필드용)
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowTourEntryFieldSettingBtn")
mywindow:setTexture("Normal", "UIData/fightclub_007.tga", 0, 601)
mywindow:setTexture("Hover", "UIData/fightclub_007.tga", 0, 641)
mywindow:setTexture("Pushed", "UIData/fightclub_007.tga", 0, 681)
mywindow:setTexture("PushedOff", "UIData/fightclub_007.tga", 0, 681)
mywindow:setPosition(5, 240)
mywindow:setSize(140, 40)
mywindow:setVisible(false)
mywindow:setSubscribeEvent("Clicked", "OnClickShowEntrySetting")
root:addChildWindow(mywindow)


---------------------------------------------------------------------
-- 토너먼트 참가자 설정 백판
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarEntrySetupBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 462, 601)
mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 462, 601)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(200,115);
mywindow:setAlwaysOnTop(true)
mywindow:setSize(562, 418)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-----  토너먼트 참가자 리스트 --------------------------------------------------------------------------------------------------
														   
ClubWarEntryList_PosX  =    { ["protecterr"]=0, 5, 175 , 5, 175, 5, 175 , 5, 175 , 5, 175 , 5, 175, 5, 175 , 5, 175}
ClubWarEntryList_PosY  =    { ["protecterr"]=0, 135, 135 , 170, 170, 205, 205, 240, 240, 275, 275, 310, 310, 345, 345 ,380, 380}
ClubWarEntryList_Text	= {['err'] = 0, 'UserName', 'Lv.1'}
ClubWarEntryList_TextPosX =  { ["protecterr"]=0, 85 , 18}
ClubWarEntryList_TextPosY =  { ["protecterr"]=0, 10 , 10 }


for i=1 , CHAMPIONSHIP_MAXCOUNT do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarEntry_image_"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_007.tga", 297, 601)
	mywindow:setTexture("Disabled", "UIData/fightclub_007.tga", 297, 631)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setPosition(ClubWarEntryList_PosX[i]+10 , ClubWarEntryList_PosY[i]-74);
	if i < 9 then
		mywindow:setPosition(16, (34*i)+30);
	else
		mywindow:setPosition(185 , (34*i)-242);
	end
	mywindow:setSize(165, 30)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubWarEntrySetupBackImage'):addChildWindow(mywindow)
	
	
	for j=1, #ClubWarEntryList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarEntryList_image_"..i..ClubWarEntryList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(ClubWarEntryList_TextPosX[j], ClubWarEntryList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(ClubWarEntryList_Text[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", "ClubWarEntryList_image_"..i.."CancelBtn")
	child_window:setTexture("Normal", "UIData/fightclub_007.tga", 1006, 419)
	child_window:setTexture("Hover", "UIData/fightclub_007.tga", 1006, 437)
	child_window:setTexture("Pushed", "UIData/fightclub_007.tga", 1006, 455)
	child_window:setTexture("PushedOff", "UIData/fightclub_007.tga", 1006, 419)
	child_window:setTexture("Disabled", "UIData/fightclub_007.tga", 1006, 473)
	child_window:setPosition(145, 7)
	child_window:setSize(18, 18)
	child_window:setVisible(false)
	child_window:setUserString('EntryIndex', tostring(i))
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnRemoveEntryMember")
	mywindow:addChildWindow(child_window)	
end

-- 엔트리에서 제거
function OnRemoveEntryMember(args)
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("EntryIndex"))
	MemberName = winMgr:getWindow("ClubWarEntryList_image_"..index..ClubWarEntryList_Text[1]):getText()
	OccupationEntryRemove(MemberName)
end


------------------------------------------------------------------
-- 엔트리 리셋 (엔트리 리셋)
------------------------------------------------------------------
function ResetTourEntryList()
	for i=1 , CHAMPIONSHIP_MAXCOUNT do
		winMgr:getWindow("ClubWarEntry_image_"..i):setEnabled(false)
		winMgr:getWindow("ClubWarEntryList_image_"..i.."CancelBtn"):setVisible(false)
		winMgr:getWindow("ClubWarEntryList_image_"..i..ClubWarEntryList_Text[1]):clearTextExtends()
		winMgr:getWindow("ClubWarEntryList_image_"..i..ClubWarEntryList_Text[2]):clearTextExtends()
	end
end
------------------------------------------------------------------
-- 엔트리 갱신하기 (엔트리 세팅)
------------------------------------------------------------------
function SettingTourEntryList(EntryIndex, UserName, UserLevel)
	
	MyClubGrade = CheckMyClubGrade()
	winMgr:getWindow("ClubWarEntry_image_"..EntryIndex):setEnabled(true)
	if MyClubGrade < 1 then
		winMgr:getWindow("ClubWarEntryList_image_"..EntryIndex.."CancelBtn"):setVisible(true)
	end
	winMgr:getWindow("ClubWarEntryList_image_"..EntryIndex..ClubWarEntryList_Text[1]):setTextExtends(UserName, g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow("ClubWarEntryList_image_"..EntryIndex..ClubWarEntryList_Text[1]):setText(UserName)
	winMgr:getWindow("ClubWarEntryList_image_"..EntryIndex..ClubWarEntryList_Text[2]):setTextExtends('Lv.'..UserLevel, g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


g_TourEntryInviteListPage = 1
g_TourEntryInviteListMaxPage = 1

------------------------------------------------------------------
-- 토너먼트 엔트리  닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseInviteList");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(535, 10)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseInviteList");
winMgr:getWindow("ClubWarEntrySetupBackImage"):addChildWindow(mywindow)

RegistEscEventInfo("ClubWarEntrySetupBackImage", "OnClickCloseInviteList")

function ShowTourEntryInviteList()
	--root:addChildWindow(winMgr:getWindow("TourEntryInviteListBackImage"))
	--winMgr:getWindow("ClubWarEntrySetupBackImage"):setVisible(true)
	--RefreshTourEntryInviteList()
	--OccupationEntryGet() -- 엔트리 요청
end

function OnClickCloseInviteList()
	winMgr:getWindow("ClubWarEntrySetupBackImage"):setVisible(false)
	
end


------------------------------------------------------------------
-- 클럽원 온라인 현황 (엔트리 설정위해)
------------------------------------------------------------------
TourEntryInviteList_Radio = 
{ ["protecterr"]=0, "TourEntryInviteList_Radio1", "TourEntryInviteList_Radio2", "TourEntryInviteList_Radio3" , "TourEntryInviteList_Radio4", "TourEntryInviteList_Radio5",
					"TourEntryInviteList_Radio6", "TourEntryInviteList_Radio7"} 
	
	
TourEntryInviteList_Text	= {['err'] = 0, 'MyClubMemberLevel', 'MyClubMemberName'}
								
TourEntryInviteList_PosX		= {['err'] = 0, 20, 95}
TourEntryInviteList_PosY		= {['err'] = 0, 3, 3 }
TourEntryInviteList_SizeX	= {['err'] = 0, 5, 5 }
TourEntryInviteList_SizeY	= {['err'] = 0, 5, 5 }
TourEntryInviteList_SetText		= {['err'] = 0, 'Level', 'Name'}



for i=1, #TourEntryInviteList_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	TourEntryInviteList_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		0, 822)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		0, 822)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		0, 844)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	0, 844)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 0, 844)
	mywindow:setSize(165, 21)
	mywindow:setPosition(380, 70+33*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubWarEntrySetupBackImage'):addChildWindow(mywindow)
	
	--  레벨 , 이름
	for j=1, #TourEntryInviteList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", TourEntryInviteList_Radio[i]..TourEntryInviteList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(TourEntryInviteList_SizeX[j], TourEntryInviteList_SizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(TourEntryInviteList_PosX[j], TourEntryInviteList_PosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", TourEntryInviteList_Radio[i]..'InviteMember')
	child_window:setTexture("Normal", "UIData/fightclub_007.tga", 988, 419)
	child_window:setTexture("Hover", "UIData/fightclub_007.tga", 988, 437)
	child_window:setTexture("Pushed", "UIData/fightclub_007.tga", 988, 455)
	child_window:setTexture("PushedOff", "UIData/fightclub_007.tga", 988, 419)
	child_window:setTexture("Disabled", "UIData/fightclub_007.tga", 988, 473) 
	child_window:setPosition(146, 1)
	child_window:setSize(18, 18)
	child_window:setVisible(true)
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnClickInsertEntryMember")
	child_window:setUserString("InsertIndex",tostring(i))
	mywindow:addChildWindow(child_window)	
end

-- 엔트리 추가
function OnClickInsertEntryMember(args)
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("InsertIndex"))
	MemberName = winMgr:getWindow(TourEntryInviteList_Radio[index]..'MyClubMemberName'):getText()
	MemberLevel = winMgr:getWindow(TourEntryInviteList_Radio[index]..'MyClubMemberLevel'):getText()
	OccupationEntryInsert(MemberName, MemberLevel)
end

---------------------------------------
---초대가능 리스트 앞뒤버튼
---------------------------------------
local TourEntryInviteListPage_BtnName  = {["err"]=0, [0]="TourEntryInviteListPage_LBtn", "TourEntryInviteListPage_RBtn"}
local TourEntryInviteListPage_BtnTexX  = {["err"]=0, [0]= 0, 22}

local TourEntryInviteListPage_BtnPosX  = {["err"]=0, [0]= 413, 498}
local TourEntryInviteListPage_BtnEvent = {["err"]=0, [0]= "TourEntryInviteListPage_PrevPage", "TourEntryInviteListPage_NextPage"}
for i=0, #TourEntryInviteListPage_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", TourEntryInviteListPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", TourEntryInviteListPage_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", TourEntryInviteListPage_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",TourEntryInviteListPage_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", TourEntryInviteListPage_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", TourEntryInviteListPage_BtnTexX[i], 81)
	mywindow:setPosition(TourEntryInviteListPage_BtnPosX[i], 301)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", TourEntryInviteListPage_BtnEvent[i])
	winMgr:getWindow('ClubWarEntrySetupBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "TourEntryInviteListPage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(426, 307)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(tostring(g_TourEntryInviteListPage)..' / '..tostring(g_TourEntryInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ClubWarEntrySetupBackImage'):addChildWindow(mywindow)


---------------------------------------
---초대가능 리스트 이전페이지 버튼--
---------------------------------------
function TourEntryInviteListPage_PrevPage()
	
	if g_TourEntryInviteListPage  > 1 then
		g_TourEntryInviteListPage = g_TourEntryInviteListPage - 1
		RefreshTourEntryInviteList()
	end
end

---------------------------------------
---초대가능 리스트 다음페이지 버튼--
---------------------------------------
function TourEntryInviteListPage_NextPage()

	if g_TourEntryInviteListPage < g_TourEntryInviteListMaxPage then
		g_TourEntryInviteListPage = g_TourEntryInviteListPage + 1
		RefreshTourEntryInviteList()
	end
end
---------------------------------------
---초대가능 리스트 페이지 설정--
---------------------------------------
function SettingTourEntryInviteListPage(CurrentPage)
	g_TourEntryInviteListPage = CurrentPage
	winMgr:getWindow('TourEntryInviteListPage_PageText'):setTextExtends(tostring(g_TourEntryInviteListPage)..' / '..tostring(g_TourEntryInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


--------------------------------------------------
--- 토너먼트 엔트리 초대 리스트 갱신하기----------
--------------------------------------------------
function RefreshTourEntryInviteList()

	g_TourEntryInviteListMaxPage = GetTotalGuildPage(7)
	if g_TourEntryInviteListMaxPage < 1 then
		g_TourEntryInviteListMaxPage = 1
	end
	MyClubGrade = CheckMyClubGrade()
	winMgr:getWindow('TourEntryInviteListPage_PageText'):setTextExtends(tostring(g_TourEntryInviteListPage)..' / '..tostring(g_TourEntryInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	for i=1, 7 do
		local level, name, state = GetEntryGuildList(i, g_TourEntryInviteListPage, 7)
		bEntry	= CheckEntryMember(name)
		if name ~= 'none' then
			
			if MyClubGrade == 0 then
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'InviteMember'):setVisible(true)	
			else
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'InviteMember'):setVisible(false)	
			end
			
			if bEntry == 1 then
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'InviteMember'):setEnabled(false)
			else
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'InviteMember'):setEnabled(true)
			end
			
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberLevel'):setVisible(true)
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberName'):setVisible(true)
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberLevel'):setText(level)
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberName'):setText(name)
			
			if state == 'offline' then	
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberLevel'):setTextExtends('Lv.'..level, g_STRING_FONT_GULIM, 14, 180,180,180,255,   0, 255,255,255,255)	
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberName'):setTextExtends(name, g_STRING_FONT_GULIM, 14, 180,180,180,255,   0, 255,255,255,255)			
			else
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberLevel'):setTextExtends('Lv.'..level, g_STRING_FONT_GULIM, 14, 15,255,9,255,   0, 255,255,255,255)
				winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberName'):setTextExtends(name, g_STRING_FONT_GULIM, 14, 15,255,9,255,   0, 255,255,255,255)
			end
			
		else
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'InviteMember'):setVisible(false)	
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberLevel'):clearTextExtends()
			winMgr:getWindow(TourEntryInviteList_Radio[i]..'MyClubMemberName'):clearTextExtends()
		end
	end
end



---------------------------------------------------------------------
--ClubWar 명예의 전당 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarRankingBoard")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(350,200);
mywindow:setSize(332, 313)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarRankingBoardCount")	
child_window:setProperty("FrameEnabled", "false")
child_window:setProperty("BackgroundEnabled", "false")
child_window:setSize(5, 5)
child_window:setVisible(true)
child_window:setPosition(222, 11)
child_window:setViewTextMode(1)	
child_window:setAlign(8)
child_window:setLineSpacing(1)
mywindow:addChildWindow(child_window)

ClubWarRankingEmblemPosX = {['err'] = 0, 36, 82, 82,82}
ClubWarRankingEmblemPosY = {['err'] = 0, 112, 155, 203,242}
ClubWarRankingNamePosX = {['err'] = 0, 190, 205, 205, 205}
ClubWarRankingNamePosY = {['err'] = 0, 89, 154, 202,241}
ClubWarRankingRewardPosX = {['err'] = 0, 190, 205, 205, 205}
ClubWarRankingRewardPosY = {['err'] = 0, 115, 169, 217,256}
---------------------------------------------------------------------
-- 명예의 전당 클럽마크 4개 (우승 준우승 3,4위팀)
-----------------------------------------------------------------------
--
for i=1, 4 do
	local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarRankingBoardEmblem"..i)	
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(ClubWarRankingEmblemPosX[i], ClubWarRankingEmblemPosY[i])
	child_window:setScaleWidth(185)
	child_window:setScaleHeight(185)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
end
---------------------------------------------------------------------
-- 명예의 전당 우승팀 이름
-----------------------------------------------------------------------
for i=1, 4 do
	local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarRankingBoardClubName"..i)	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(ClubWarRankingNamePosX[i], ClubWarRankingNamePosY[i])
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setTextExtends('WinnerGang'..i, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end

---------------------------------------------------------------------
-- 명예의 전당 우승 상금
-----------------------------------------------------------------------
for i=1, 4 do
	local child_window = winMgr:createWindow("TaharezLook/StaticText", "ClubWarRankingBoardReward"..i)	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(ClubWarRankingRewardPosX[i], ClubWarRankingRewardPosY[i])
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end

------------------------------------------------------------------
-- 명예의 전당 닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseClubWarRankingBoard");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(300, 6)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseClubWarRankingBoard");
winMgr:getWindow("ClubWarRankingBoard"):addChildWindow(mywindow)


RegistEscEventInfo("ClubWarRankingBoard", "OnClickCloseClubWarRankingBoard")

function OnClickCloseClubWarRankingBoard()
	SetInputEnable(true)
	winMgr:getWindow('ClubWarRankingBoard'):setVisible(false)
end

------------------------------------------------------------------
-- 명예의 전당 호출
------------------------------------------------------------------
function ShowClubWarRankingBoard()
	root:addChildWindow(winMgr:getWindow('ClubWarRankingBoard'))
	winMgr:getWindow('ClubWarRankingBoard'):setVisible(true)
	g_ClubWarRankingBoardPage = 1
	OccupationGetWinnerList(g_ClubWarRankingBoardPage)
end
------------------------------------------------------------------
-- 명예의 전당 리셋
------------------------------------------------------------------
function ResetTourWinnerHistory()
	for i=1, 4 do
		winMgr:getWindow('ClubWarRankingBoardClubName'..i):clearTextExtends()
		winMgr:getWindow('ClubWarRankingBoardReward'..i):clearTextExtends()
		winMgr:getWindow('ClubWarRankingBoardEmblem'..i):setTexture('Enabled', "UIData/invisible.tga", 0, 0)
		winMgr:getWindow('ClubWarRankingBoardEmblem'..i):setTexture('Disabled', "UIData/invisible.tga", 0, 0)
	end
	winMgr:getWindow('ClubWarRankingBoardCount'):clearTextExtends()
end

------------------------------------------------------------------
-- 명예의 전당 세팅
------------------------------------------------------------------
function SettingTourWinnerHistory(Clubname1, Clubname2 ,Clubname3, Clubname4, EmblemKey1, EmblemKey2, EmblemKey3, EmblemKey4, Reward1, Reward2, Reward3, WarCount)

	winMgr:getWindow('ClubWarRankingBoardClubName1'):setTextExtends(Clubname1, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarRankingBoardClubName2'):setTextExtends(Clubname2, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarRankingBoardClubName3'):setTextExtends(Clubname3, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarRankingBoardClubName4'):setTextExtends(Clubname4, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubWarRankingBoardCount'):setTextExtends(WarCount, g_STRING_FONT_GULIMCHE, 113,    255,255,255,255,     0,     0,0,0,255)
	
	-- 보상은 0이상일 경우에만 세팅
	if Reward1 > 0 then
		local ClubMoneyCom1 = CommatoMoneyStr(Reward1)
		local r,g,b = GetGranColor(Reward1)
		winMgr:getWindow('ClubWarRankingBoardReward1'):setTextExtends(ClubMoneyCom1, g_STRING_FONT_GULIMCHE, 113,    r,g,b,255,     0,     0,0,0,255)
	end
	
	if Reward1 > 0 then
		local ClubMoneyCom2 = CommatoMoneyStr(Reward2)
		local r,g,b = GetGranColor(Reward2)
		winMgr:getWindow('ClubWarRankingBoardReward2'):setTextExtends(ClubMoneyCom2, g_STRING_FONT_GULIMCHE, 112,    r,g,b,255,     0,     0,0,0,255)
	end
	
	if Reward3 > 0 then
		local ClubMoneyCom3 = CommatoMoneyStr(Reward3)
		local r,g,b = GetGranColor(Reward3)
		winMgr:getWindow('ClubWarRankingBoardReward3'):setTextExtends(ClubMoneyCom3, g_STRING_FONT_GULIMCHE, 112,   r,g,b,255,     0,     0,0,0,255)
		winMgr:getWindow('ClubWarRankingBoardReward4'):setTextExtends(ClubMoneyCom3, g_STRING_FONT_GULIMCHE, 112,    r,g,b,255,     0,     0,0,0,255)
	end
	
	
	if EmblemKey1 > 0 then
		winMgr:getWindow("ClubWarRankingBoardEmblem1"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey1..".tga", 0, 0)
		winMgr:getWindow("ClubWarRankingBoardEmblem1"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey1..".tga", 0, 0)
	end
	
	if EmblemKey2 > 0 then
		winMgr:getWindow("ClubWarRankingBoardEmblem2"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey2..".tga", 0, 0)
		winMgr:getWindow("ClubWarRankingBoardEmblem2"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey2..".tga", 0, 0)
	end
	
	if EmblemKey3 > 0 then
		winMgr:getWindow("ClubWarRankingBoardEmblem3"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey3..".tga", 0, 0)
		winMgr:getWindow("ClubWarRankingBoardEmblem3"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey3..".tga", 0, 0)
	end
	
	if EmblemKey4 > 0 then
		winMgr:getWindow("ClubWarRankingBoardEmblem4"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey4..".tga", 0, 0)
		winMgr:getWindow("ClubWarRankingBoardEmblem4"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey4..".tga", 0, 0)
	end
	
	
end

g_ClubWarRankingBoardPage = 1
g_ClubWarRankingBoardMaxPage = 1


---------------------------------------
---명예의 전당 앞뒤버튼
---------------------------------------
local ClubWarRankingBoardPage_BtnName  = {["err"]=0, [0]="ClubWarRankingBoardPage_LBtn", "ClubWarRankingBoardPage_RBtn"}
local ClubWarRankingBoardPage_BtnTexX  = {["err"]=0, [0]= 0, 22}
local ClubWarRankingBoardPage_BtnPosX  = {["err"]=0, [0]= 108, 213}
local ClubWarRankingBoardPage_BtnEvent = {["err"]=0, [0]= "ClubWarRankingBoardPage_PrevPage", "ClubWarRankingBoardPage_NextPage"}
for i=0, #ClubWarRankingBoardPage_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", ClubWarRankingBoardPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", ClubWarRankingBoardPage_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", ClubWarRankingBoardPage_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",ClubWarRankingBoardPage_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", ClubWarRankingBoardPage_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", ClubWarRankingBoardPage_BtnTexX[i], 81)
	mywindow:setPosition(ClubWarRankingBoardPage_BtnPosX[i], 279)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ClubWarRankingBoardPage_BtnEvent[i])
	winMgr:getWindow('ClubWarRankingBoard'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ClubWarRankingBoardPage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(131, 284)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(tostring(g_ClubWarRankingBoardPage)..' / '..tostring(g_ClubWarRankingBoardMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ClubWarRankingBoard'):addChildWindow(mywindow)


---------------------------------------
---명예의 전당 이전페이지 버튼--
---------------------------------------
function ClubWarRankingBoardPage_PrevPage()
	
	if g_ClubWarRankingBoardPage  > 1 then
		g_ClubWarRankingBoardPage = g_ClubWarRankingBoardPage - 1
		OccupationGetWinnerList(g_ClubWarRankingBoardPage)
	end
end

---------------------------------------
---명예의 전당 다음페이지 버튼--
---------------------------------------
function ClubWarRankingBoardPage_NextPage()

	if g_ClubWarRankingBoardPage < g_ClubWarRankingBoardMaxPage then
		g_ClubWarRankingBoardPage = g_ClubWarRankingBoardPage + 1
		OccupationGetWinnerList(g_ClubWarRankingBoardPage)
	end
end
---------------------------------------
---명예의 전당 리스트 페이지 설정--
---------------------------------------
function SettingClubWarRankingBoardPage(RankingMaxPage)
	g_ClubWarRankingBoardMaxPage = RankingMaxPage
	if RankingMaxPage == 0 then
		g_ClubWarRankingBoardMaxPage = 1;
	end
	winMgr:getWindow('ClubWarRankingBoardPage_PageText'):setTextExtends(tostring(g_ClubWarRankingBoardPage)..' / '..tostring(g_ClubWarRankingBoardMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end





---------------------------------------------------------------------
-- 토너먼트 공지사항 (기본)
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNoticeDefaultImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 673, 942)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 673, 942)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(1);
mywindow:setPosition(780,190);
mywindow:setSize(351, 64)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


---------------------------------------------------------------------
-- 토너먼트 타이틀 이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNoticeTitleImage")
mywindow:setTexture("Enabled", "UIData/messenger.tga", 529, 315)
mywindow:setTexture("Disabled", "UIData/messenger.tga", 529, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0,0);
mywindow:setSize(111, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubWarNoticeDefaultImage'):addChildWindow(mywindow)

---------------------------------------------------------------------
-- 토너먼트 공지사항
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ClubWarNoticeText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(5, 25)
mywindow:setSize(160, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(0)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubWarNoticeDefaultImage'):addChildWindow(mywindow)


function SettingClubWarNotice(noticeMsg)
    if CheckNpcModeforLua() == false then
		winMgr:getWindow('ClubWarNoticeDefaultImage'):setVisible(true)
		winMgr:getWindow('ClubWarNoticeTitleImage'):setVisible(true)
	end
	winMgr:getWindow('ClubWarNoticeText'):setTextExtends(noticeMsg, g_STRING_FONT_GULIMCHE, 113,    255,198,0,255,     1,     0,0,0,255)
end

--------------------------------------------------------- War Mode 이동------------------------------------------------------

----------------------------------------------------------------------
-- War Mode 호출 버튼 
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TourTestMoveBtn")
mywindow:setTexture("Normal", "UIData/fightclub_006.tga", 362, 0)
mywindow:setTexture("Hover", "UIData/fightclub_006.tga", 362, 40)
mywindow:setTexture("Pushed", "UIData/fightclub_006.tga", 362, 80)
mywindow:setTexture("PushedOff", "UIData/fightclub_006.tga", 362, 0)
mywindow:setPosition(13, 57)
mywindow:setAlwaysOnTop(true)
mywindow:setSize(140, 40)
if CheckfacilityData(FACILITYCODE_GANG_WAR) == 0 then
	mywindow:setVisible(false)
end
mywindow:setVisible(false)

mywindow:setSubscribeEvent("Clicked", "OnClickTourTestMove")
root:addChildWindow(mywindow)

function OnClickTourTestMove()
	RequestPortalOccupation()
	root:addChildWindow(winMgr:getWindow('TourTestMoveBackImage'))
	winMgr:getWindow('TourTestMoveBackImage'):setVisible(true)
end

---------------------------------------------------------------------
-- War Mode 백판이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourTestMoveBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 314)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 314)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(320,150);
mywindow:setSize(451, 356)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEscEventInfo("TourTestMoveBackImage", "OnClickCloseTestMove")
--------------------------------------------------------------------
-- War Mode 이동 버튼 16개
--------------------------------------------------------------------
ClubWarEnterPotal =	{ ["protecterr"]=0, "ClubWarEnterPotal_1", "ClubWarEnterPotal_2", "ClubWarEnterPotal_3" , "ClubWarEnterPotal_4",
										"ClubWarEnterPotal_5", "ClubWarEnterPotal_6", "ClubWarEnterPotal_7" , "ClubWarEnterPotal_8",
										"ClubWarEnterPotal_9", "ClubWarEnterPotal_10", "ClubWarEnterPotal_11" , "ClubWarEnterPotal_12",
										"ClubWarEnterPotal_13", "ClubWarEnterPotal_14", "ClubWarEnterPotal_15" , "ClubWarEnterPotal_16"}
									
for i=1 , #ClubWarEnterPotal do

	mywindow = winMgr:createWindow("TaharezLook/Button", ClubWarEnterPotal[i])
	mywindow:setTexture("Normal", "UIData/fightclub_006.tga", 502, 0)
	mywindow:setTexture("Hover", "UIData/fightclub_006.tga", 502, 35)
	mywindow:setTexture("Pushed", "UIData/fightclub_006.tga", 502, 70)
	mywindow:setTexture("PushedOff", "UIData/fightclub_006.tga", 502, 0)
	mywindow:setTexture("Disabled",	"UIData/fightclub_006.tga",	502, 105)
	if i < 9 then
		mywindow:setPosition(25, (i*39))
	else
		mywindow:setPosition(225, (i-8)*39)
	end
	
	mywindow:setSize(190, 35)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setUserString("PortalIndex", i)
	mywindow:setSubscribeEvent("Clicked", "OnClickClubWarEnterPotal")
	winMgr:getWindow('TourTestMoveBackImage'):addChildWindow(mywindow)
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ClubWarEnterPotal[i]..'ChannelNumber')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 7)
	child_window:setVisible(true)
	child_window:setPosition(90, 12)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	child_window:setTextExtends('WAR CHANNNEL'..i, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	mywindow:addChildWindow(child_window)
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ClubWarEnterPotal[i]..'Time')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 7)
	child_window:setVisible(true)
	child_window:setPosition(220, 12)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end
--------------------------------------------------------------------
-- War Mode 입장버튼 On, Off
--------------------------------------------------------------------
function UpdatepacketOccupationPortalShow(index, idnumber , min, sec, userCount)
	
	if idnumber > 0 then
		winMgr:getWindow(ClubWarEnterPotal[index]):setEnabled(true)
	else
		winMgr:getWindow(ClubWarEnterPotal[index]):setEnabled(false)
	end
	
	winMgr:getWindow(ClubWarEnterPotal[index]..'ChannelNumber'):setTextExtends('WAR CHANNEL '..index..' ('..userCount..'/32)', g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
end


function OnClickClubWarEnterPotal(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;	
	local win_name = local_window:getName();
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("PortalIndex"))
	if index > 0 then
		MoveServerOccupation(index)
	end
end

------------------------------------------------------------------
-- 갱모드 닫기 버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseTestMoveBtn");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(410, 6)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseTestMove");
winMgr:getWindow("TourTestMoveBackImage"):addChildWindow(mywindow)

function OnClickCloseTestMove()
	winMgr:getWindow('TourTestMoveBackImage'):setVisible(false)
end

function ShowTourTestMoveBtn(bShow)
	winMgr:getWindow('TourTestMoveBtn'):setVisible(false)
end


--------------------------------------------------------------------
-- 자동매치 관련 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "AutoMatch_MenuBtn")
mywindow:setTexture("Normal", "UIData/automatch.tga", 0, 852)
mywindow:setTexture("Hover", "UIData/automatch.tga", 0, 895)
mywindow:setTexture("Pushed", "UIData/automatch.tga", 0, 938)
mywindow:setTexture("PushedOff", "UIData/automatch.tga", 0, 852)
mywindow:setWideType(2);
mywindow:setPosition(425, 723)
mywindow:setSize(166, 43)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "OnClickAutoMatchMenu")
root:addChildWindow(mywindow)

function OnClickAutoMatchMenu()
	if winMgr:getWindow('AutoMatchSearchBackImage'):isVisible() then
		return
	end
	AutoMatchNormal()
end

---------------------------------------------------------------------
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchSearchBackImage")
mywindow:setTexture("Enabled", "UIData/automatch2.tga", 684, 0)
mywindow:setTexture("Disabled", "UIData/automatch2.tga", 684, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(340, 80);
mywindow:setSize(340, 141)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-------------------------------------------------------------------
-- 자동매치 관련 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "AutoMatch_CancelBtn")
mywindow:setTexture("Normal", "UIData/automatch2.tga", 619, 0)
mywindow:setTexture("Hover", "UIData/automatch2.tga", 619, 25)
mywindow:setTexture("Pushed", "UIData/automatch2.tga", 619, 50)
mywindow:setTexture("PushedOff", "UIData/automatch2.tga", 619, 0)
mywindow:setPosition(140, 102)
mywindow:setSize(65, 25)
mywindow:subscribeEvent("Clicked", "CancelAutoMatch")
winMgr:getWindow('AutoMatchSearchBackImage'):addChildWindow(mywindow)


local MatchEffectNumber = 0

function ShowAutoMatchSearch()
	
	root:addChildWindow(winMgr:getWindow('AutoMatchSearchBackImage'))
	winMgr:getWindow('AutoMatchSearchBackImage'):setVisible(true)
	MatchEffectNumber = 0
end

function CancelMatchSearch()
	MatchEffectNumber = 0
	winMgr:getWindow('AutoMatchSearchBackImage'):setVisible(false)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchSearchEffectImage")
mywindow:setTexture("Enabled", "UIData/automatch2.tga", 304, 612)
mywindow:setTexture("Disabled", "UIData/automatch2.tga", 304, 612)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(157 , 57);
mywindow:setSize(60, 60)
mywindow:setEnabled(false)
mywindow:setScaleWidth(130)
mywindow:setScaleHeight(130)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('AutoMatchSearchBackImage'):addChildWindow(mywindow)

local MatchEffectNumber = 0
function SettingAutoMatchEffect()
	
	if winMgr:getWindow('AutoMatchSearchBackImage'):isVisible() == false then
		return
	end
	
	MatchEffectNumber = MatchEffectNumber + 1
	if MatchEffectNumber > 11 then
		MatchEffectNumber = 0 
	end
	winMgr:getWindow('AutoMatchSearchEffectImage'):setTexture("Disabled", "UIData/automatch2.tga", 304+(60*MatchEffectNumber), 612)
end






--********************************************************************************************************************--
--------------------------------------팀전 토너먼트----------------------------------------------------------------------
--********************************************************************************************************************--


-------------------------------------------------------------------
-- 팀전 토너먼트 신청 배경이미지
-------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipJoinBackImage")
mywindow:setTexture("Enabled", "UIData/Tournament002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Tournament002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(287 , 157);
mywindow:setSize(469, 358)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipJoinBackImage", "CloseTeamChampionshipRequestImage")
-------------------------------------------------------------------
-- 팀 토너먼트 신청 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipJoinBtn")
mywindow:setTexture("Normal", "UIData/Tournament002.tga", 0, 358)
mywindow:setTexture("Hover", "UIData/Tournament002.tga", 0, 390)
mywindow:setTexture("Pushed", "UIData/Tournament002.tga", 0, 422)
mywindow:setTexture("PushedOff", "UIData/Tournament002.tga", 0, 358)
mywindow:setPosition(190, 308)
mywindow:setSize(89, 32)
mywindow:subscribeEvent("Clicked", "OnclickTeamChampionshipRequest")
winMgr:getWindow('TeamChampionshipJoinBackImage'):addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀 토너먼트 대기상태 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipJoinCloseBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(425, 10)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "CloseTeamChampionshipRequestImage")
winMgr:getWindow("TeamChampionshipJoinBackImage"):addChildWindow(mywindow)


-- 팀 이름 
mywindow = winMgr:createWindow("TaharezLook/Editbox", "TeamChampionship_TeamNameEdixBox")
mywindow:setText("")
mywindow:setPosition(88, 118)
mywindow:setSize(210, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "TeamChampionship_NextInput")
winMgr:getWindow('TeamChampionshipJoinBackImage'):addChildWindow(mywindow)

-- 친구 이름
mywindow = winMgr:createWindow("TaharezLook/Editbox", "TeamChampionship_FriendNameEdixBox")
mywindow:setText("")
mywindow:setPosition(88, 230)
mywindow:setSize(210, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "TeamChampionship_NextInput")
winMgr:getWindow('TeamChampionshipJoinBackImage'):addChildWindow(mywindow)

function TeamChampionship_NextInput()
	if winMgr:getWindow('TeamChampionship_TeamNameEdixBox'):isActive() then
		winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):deactivate()
		winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):activate()
	else
		winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):deactivate()
		winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):activate()
	end
end

-- 팀 토너먼트 신청버튼 클릭시
function OnclickTeamChampionshipRequest()
	TeamName = winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):getText()
	if TeamName == "" then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4197, 'OnClickAlertOkSelfHide');
		return
	end
	
	FriendName = winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):getText()
	if FriendName == "" then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4198, 'OnClickAlertOkSelfHide');
		return
	end
	
	bResult = RequestChampionshipApplicant(TeamName, FriendName)
	
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):setText("")
end

-- 팀 토너먼트 신청 보여주기
function ShowTeamChampionshipRequestImage()
	--ShowTeamChampionshipADImage()  -- 임시광고이미지
	--
	root:addChildWindow(winMgr:getWindow("TeamChampionshipJoinBackImage"))
	winMgr:getWindow("TeamChampionshipJoinBackImage"):setVisible(true)
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):activate()
	--
end

-- 팀 토너먼트 신청 닫기
function CloseTeamChampionshipRequestImage()
	--VirtualImageSetVisible(false)
	winMgr:getWindow("TeamChampionshipJoinBackImage"):setVisible(false)
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):deactivate()
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):deactivate()
	--TownNpcEscBtnClickEvent()
end

-- 팀 토너먼트 신청 리턴 처리
function CloseTeamChampionshipReturn()
	--VirtualImageSetVisible(false)
	winMgr:getWindow("TeamChampionshipJoinBackImage"):setVisible(false)
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):setText("")
	winMgr:getWindow("TeamChampionship_TeamNameEdixBox"):deactivate()
	winMgr:getWindow("TeamChampionship_FriendNameEdixBox"):deactivate()
	--TownNpcEscBtnClickEvent()
end

-------------------------------------------------------------------
-- 팀전 토너먼트 대기 배경이미지
-------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipWaitBackImage")
mywindow:setTexture("Enabled", "UIData/Tournament002.tga", 469, 0)
mywindow:setTexture("Disabled", "UIData/Tournament002.tga", 469, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(287 , 157);
mywindow:setSize(469, 358)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipWaitBackImage", "CloseTeamChampionshipWaitImage")

-------------------------------------------------------------------
-- 팀 토너먼트 대기상태 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipWaitBackCloseBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(425, 10)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "CloseTeamChampionshipWaitImage")
winMgr:getWindow("TeamChampionshipWaitBackImage"):addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀전 토너먼트 신청수락 이미지
-------------------------------------------------------------------
for i = 1, 4 do		
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipAgreeImage"..i)			
	mywindow:setTexture("Enabled", "UIData/Tournament002.tga", 724, 358)
	mywindow:setTexture("Disabled", "UIData/Tournament002.tga", 724, 358)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(187 , 167+(i*22));
	mywindow:setSize(215, 21)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('TeamChampionshipWaitBackImage'):addChildWindow(mywindow);
end

for i = 2, ChampionshipTeamCount do
	winMgr:getWindow("TeamChampionshipAgreeImage"..i):setVisible(true)
end
-------------------------------------------------------------------
-- 팀 토너먼트 대기 정보 텍스트
--------------------------------------------------------------------
TeamChampionshipWaitTextX    = {['err'] = 0, 200, 200, 200, 200, 200 } 
TeamChampionshipWaitTextY    = {['err'] = 0, 165, 205, 225, 400, 500 } 

TeamChampionshipWaitTextName = { ["protecterr"]=0, "TeamChampionshipWait_TeamName", "TeamChampionshipWait_CharName0", 
								"TeamChampionshipWait_CharName1", "TeamChampionshipWait_CharName2", "TeamChampionshipWait_CharName3"}
			
for i = 1, #TeamChampionshipWaitTextName do					
	mywindow = winMgr:createWindow("TaharezLook/StaticText", TeamChampionshipWaitTextName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12);
	mywindow:setTextColor(255, 255, 255, 255);
	mywindow:setPosition(TeamChampionshipWaitTextX[i], TeamChampionshipWaitTextY[i]-7);
	mywindow:setSize(5, 5);
	mywindow:setText('TeamName');
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	winMgr:getWindow('TeamChampionshipWaitBackImage'):addChildWindow(mywindow);
end


-------------------------------------------------------------------
-- 팀 토너먼트 동의 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipAgreeBtn")
mywindow:setTexture("Normal", "UIData/Tournament002.tga", 89, 358)
mywindow:setTexture("Hover", "UIData/Tournament002.tga", 89, 390)
mywindow:setTexture("Pushed", "UIData/Tournament002.tga", 89, 422)
mywindow:setTexture("PushedOff", "UIData/Tournament002.tga", 89, 358)
mywindow:setVisible(false)
mywindow:setPosition(130, 315)
mywindow:setSize(89, 32)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipAgree")
winMgr:getWindow('TeamChampionshipWaitBackImage'):addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀 토너먼트 거절 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipRefuseBtn")
mywindow:setTexture("Normal", "UIData/Tournament002.tga", 178, 358)
mywindow:setTexture("Hover", "UIData/Tournament002.tga", 178, 390)
mywindow:setTexture("Pushed", "UIData/Tournament002.tga", 178, 422)
mywindow:setTexture("PushedOff", "UIData/Tournament002.tga", 178, 358)
mywindow:setVisible(false)
mywindow:setPosition(250, 315)
mywindow:setSize(89, 32)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipRefuse")
winMgr:getWindow('TeamChampionshipWaitBackImage'):addChildWindow(mywindow)

-- 동의
function OnClickTeamChampionshipAgree()
	ChampionshipApplicantAgree(1)
end

-- 거절
function OnClickTeamChampionshipRefuse()
	ChampionshipApplicantAgree(0)
end


-- 팀 토너먼트 신청중 보여주기
function ShowTeamChampionshipWaitImage(type, TeamName, CharacterName0, CharacterName1, CharacterName2, CharacterName3, type1, type2, type3, type4)
	DebugStr('팀신청상황보기')
	
	for i = 1, #TeamChampionshipWaitTextName do		
		winMgr:getWindow(TeamChampionshipWaitTextName[i]):setText("")
	end
	
	winMgr:getWindow(TeamChampionshipWaitTextName[1]):setText(TeamName)
	winMgr:getWindow(TeamChampionshipWaitTextName[2]):setText(CharacterName0)
	winMgr:getWindow(TeamChampionshipWaitTextName[3]):setText(CharacterName1)
	--winMgr:getWindow(TeamChampionshipWaitTextName[4]):setText(TeamName)
	--winMgr:getWindow(TeamChampionshipWaitTextName[5]):setText(TeamName)
	
	root:addChildWindow(winMgr:getWindow("TeamChampionshipWaitBackImage"))
	winMgr:getWindow("TeamChampionshipWaitBackImage"):setVisible(true)
	if type == false then
		winMgr:getWindow("TeamChampionshipRefuseBtn"):setVisible(true)
		winMgr:getWindow("TeamChampionshipAgreeBtn"):setVisible(true)
	else
		winMgr:getWindow("TeamChampionshipRefuseBtn"):setVisible(false)
		winMgr:getWindow("TeamChampionshipAgreeBtn"):setVisible(false)
	end
	
	if type2 == false then 
		winMgr:getWindow("TeamChampionshipAgreeImage2"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 358)
	else
		winMgr:getWindow("TeamChampionshipAgreeImage2"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 379)
	end
	
	if type3 == false then 
		winMgr:getWindow("TeamChampionshipAgreeImage3"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 358)
	else
		winMgr:getWindow("TeamChampionshipAgreeImage3"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 379)
	end
	
	if type4 == false then 
		winMgr:getWindow("TeamChampionshipAgreeImage4"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 358)
	else
		winMgr:getWindow("TeamChampionshipAgreeImage4"):setTexture("Enabled", "UIData/Tournament002.tga", 724, 379)
	end
end

-- 팀 토너먼트 신청중 닫기
function CloseTeamChampionshipWaitImage()
	winMgr:getWindow("TeamChampionshipRefuseBtn"):setVisible(false)
	winMgr:getWindow("TeamChampionshipAgreeBtn"):setVisible(false)
	winMgr:getWindow("TeamChampionshipWaitBackImage"):setVisible(false)
end


-- 팀 토너먼트 신청 리턴으로 닫기
function CloseTeamChampionshipWaitImageReturn()
	winMgr:getWindow("TeamChampionshipRefuseBtn"):setVisible(false)
	winMgr:getWindow("TeamChampionshipAgreeBtn"):setVisible(false)
	winMgr:getWindow("TeamChampionshipWaitBackImage"):setVisible(false)
end


-------------------------------------------------------------------
-- 팀전 토너먼트 임시 광고 이미지
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipADImage")
mywindow:setTexture("Enabled", "UIData/Tournament003.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Tournament003.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(267 , 236);
mywindow:setSize(472, 456)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipADImage", "CloseTeamChampionshipADImage")

function CloseTeamChampionshipADImage()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TeamChampionshipADImage"):setVisible(false)
end


function ShowTeamChampionshipADImage()
	winMgr:getWindow("TeamChampionshipADImage"):setVisible(true)
end













-- 대진표

--local MAX_CHAMPIONSHIP_COUNT = 16
-------------------------------------------------------------------
-- 팀전 토너먼트 대진표
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipMatchList")
mywindow:setTexture("Enabled", "UIData/championship.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/championship.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0 , 10);
mywindow:setSize(1024, 632)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipMatchList", "OnClickTeamChampionshipMatchListClose")


TeamChampionship_BoardLeftX =  { ["protecterr"]=0, 0,	339, 275 , 636,	150, 150,   761, 761,		21,  21,  21,  21, 890, 890, 890, 890}
TeamChampionship_BoardLeftY =  { ["protecterr"]=0, 0,	308, 175 , 175,	109, 379,   109, 379,		81, 216, 351, 483, 81,  216, 351, 483}
TeamChampionship_BoardRightX =  { ["protecterr"]=0, 0,	572 , 275,  636, 150, 150,  761, 761,	   21,  21,  21, 21, 890, 890, 890, 890}
TeamChampionship_BoardRightY =  { ["protecterr"]=0, 0,  308 , 443,	443, 244, 510,  244, 510,	   137, 272, 407, 539, 137, 272, 407, 539}


TeamChampionship_BoardWinLineX		= { ["protecterr"]=0, 0,	453,383 , 619,	257, 257, 743, 743,  133,  133,  133,  133, 873, 873, 873, 873}
TeamChampionship_BoardWinLineY		= { ["protecterr"]=0, 0,	180,192 , 192,	129, 398, 129, 398,  101,  236,  371,  503, 101, 236, 371, 503}

TeamChampionship_BoardWinTexX		= { ["protecterr"]=0, 0,	238, 73  , 119,	19,   19,  165,165,    0,   0,    0,   0, 219, 219, 219, 219}
TeamChampionship_BoardWinTexY		=  { ["protecterr"]=0, 0,	686,686 , 686,	686, 686, 686, 686,  686, 686,  686, 686, 686, 686, 686, 686}

TeamChampionship_BoardWinTexX2		= { ["protecterr"]=0, 0,	358, 96  , 142,	46,   46,  192,192,    0,   0,    0,   0, 219, 219, 219, 219}
TeamChampionship_BoardWinTexY2		=  { ["protecterr"]=0, 0,	686, 687 , 686,	686, 686, 686, 686,  748,748,  748,  748, 748,748,  748,  748}

TeamChampionship_BoardWinTexSizeX	=  { ["protecterr"]=0, 0,	120, 23  , 23,	27,	 27,  27,  27,   19,  19,  19,  19, 19,  19,  19,  19}
TeamChampionship_BoardWinTexSizeY	=  { ["protecterr"]=0, 0,	157, 279 , 279,	142, 142, 142, 142,  62,  62,  62,  62, 62,  62,  62,  62}

TeamChampionship_RootNumberPiece	=  { ["protecterr"]=0, 0,	"ChampionshipWinnerText2", "ChampionshipPieceLeft2", "ChampionshipPieceRight2" , "ChampionshipPieceLeft3", "ChampionshipPieceRight3",	"ChampionshipPieceLeft4", "ChampionshipPieceRight4"
																, "ChampionshipPieceLeft5", "ChampionshipPieceRight5", "ChampionshipPieceLeft6",  "ChampionshipPieceRight6"
																, "ChampionshipPieceLeft7", "ChampionshipPieceRight7", "ChampionshipPieceLeft8",  "ChampionshipPieceRight8"}
																
TeamChampionship_RootNumberText		= { ["protecterr"]=0, 0,	"ChampionshipWinnerText2", "2ChampionshipLeft", "2ChampionshipRight" , "3ChampionshipLeft", "3ChampionshipRight",	"4ChampionshipLeft", "4ChampionshipRight"
																, "5ChampionshipLeft", "5ChampionshipRight", "6ChampionshipLeft",  "6ChampionshipRight"
																, "7ChampionshipLeft", "7ChampionshipRight", "8ChampionshipLeft",  "8ChampionshipRight"}
																
for i= 2, CHAMPIONSHIP_MAXCOUNT do
	
	-- 라인 그리기 (승자표시)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampionshipWinnerLine"..i)
	mywindow:setTexture("Enabled", "UIData/championship.tga", TeamChampionship_BoardWinTexX[i], TeamChampionship_BoardWinTexY[i])
	mywindow:setTexture("Disabled", "UIData/championship.tga", TeamChampionship_BoardWinTexX[i], TeamChampionship_BoardWinTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setEnabled(false)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(TeamChampionship_BoardWinLineX[i], TeamChampionship_BoardWinLineY[i])
	mywindow:setSize(TeamChampionship_BoardWinTexSizeX[i], TeamChampionship_BoardWinTexSizeY[i])
	winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)
	
	
	-- 대진표 윗쪽
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampionshipPieceLeft"..i)
	mywindow:setTexture("Enabled", "UIData/championship.tga", 0, 635)
	mywindow:setTexture("Disabled", "UIData/championship.tga", 0, 635)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlwaysOnTop(true)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(TeamChampionship_BoardLeftX[i], TeamChampionship_BoardLeftY[i])
	mywindow:setSize(114, 48)
	mywindow:setUserString('ChampIndex', tostring(i))
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowChampLeftTooltipInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HideChampTooltipInfo")
	winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)
	
	child_window = winMgr:createWindow("TaharezLook/StaticText", i..'ChampionshipLeft')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setPosition(55, 20)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
	
	--대진표 아래쪽
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampionshipPieceRight"..i)
	mywindow:setTexture("Enabled", "UIData/championship.tga", 0, 635)
	mywindow:setTexture("Disabled", "UIData/championship.tga", 0, 635)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlwaysOnTop(true)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(TeamChampionship_BoardRightX[i], TeamChampionship_BoardRightY[i])
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowChampRightTooltipInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HideChampTooltipInfo")
	mywindow:setUserString('ChampIndex', tostring(i))
	mywindow:setSize(114, 48)
	winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)
	
	child_window = winMgr:createWindow("TaharezLook/StaticText", i..'ChampionshipRight')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setPosition(55, 20)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
	
	-- 툴팁용 저장하기 위해서
	for j = 1, 4 do 
		child_window = winMgr:createWindow("TaharezLook/StaticText", i..'ChampionshipLeftCharacterName'..j)	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setPosition(55, 20)
	end
	
	for j = 1, 4 do 
		child_window = winMgr:createWindow("TaharezLook/StaticText", i..'ChampionshipRightCharacterName'..j)	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setPosition(55, 20)
	end
end


-- 우승자 
mywindow = winMgr:createWindow("TaharezLook/StaticText", 'ChampionshipWinnerText')	
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(5, 5)
mywindow:setPosition(510, 145)
mywindow:setViewTextMode(1)	
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)

-- 우승자 
mywindow = winMgr:createWindow("TaharezLook/StaticText", 'ChampionshipWinnerText2')	
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(5, 5)
mywindow:setPosition(510, 145)
mywindow:setViewTextMode(1)	
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
--winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)

-- 몇회차 표시
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampionshipOpenCount")
mywindow:setTexture("Enabled", "UIData/Championship_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Championship_001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setEnabled(false)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(415, 20)
mywindow:setSize(31, 22)
winMgr:getWindow('TeamChampionshipMatchList'):addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀 토너먼트 대진표 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipMatchListBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(984, 54)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipMatchListClose")
winMgr:getWindow("TeamChampionshipMatchList"):addChildWindow(mywindow)

function OnClickTeamChampionshipMatchListClose()
	winMgr:getWindow('TeamChampionshipMatchList'):setVisible(false)
end

function SettingChampionshipResetList()
	root:addChildWindow(winMgr:getWindow('TeamChampionshipMatchList'))
	winMgr:getWindow('TeamChampionshipMatchList'):setVisible(true)
	
	for i= 2, CHAMPIONSHIP_MAXCOUNT do
		winMgr:getWindow("ChampionshipWinnerLine"..i):setVisible(false)
		winMgr:getWindow(i..'ChampionshipLeft'):clearTextExtends()
		winMgr:getWindow("ChampionshipPieceLeft"..i):setTexture("Enabled", "UIData/championship.tga", 0, 635)
		winMgr:getWindow("ChampionshipPieceLeft"..i):setEnabled(false)
		winMgr:getWindow(i..'ChampionshipRight'):clearTextExtends()
		winMgr:getWindow("ChampionshipPieceRight"..i):setTexture("Enabled", "UIData/championship.tga", 0, 635)
		winMgr:getWindow("ChampionshipPieceRight"..i):setEnabled(false)
	end
	
	winMgr:getWindow("ChampionshipWinnerText"):clearTextExtends()
end

function SettingChampionshipOpenCount(number)
	if number < 17 then
		TexPosY = 0
		TexPosX = number
	elseif number <33 then
		TexPosY = 1
		TexPosX = number - 16
	elseif number < 49 then
		TexPosY = 2
		TexPosX = number - 32
	elseif number < 65 then
		TexPosY = 3
		TexPosX = number - 48
	end
	
	winMgr:getWindow("ChampionshipOpenCount"):setTexture("Disabled", "UIData/Championship_001.tga", TexPosX*31-31, TexPosY*22)
end
-------------------------------------------------------------------
-- 팀전 토너먼트 대진표 세팅
-------------------------------------------------------------------
function SettingChampionshipList(i, leftTeamName, RightTeamName, leftTeamIndex, RightTeamIndex,  WinnderIndex, CheckleftLose, CheckLightLose,
		leftCharacterName1, leftCharacterName2, leftCharacterName3, leftCharacterName4, RightCharacterName1, RightCharacterName2, RightCharacterName3, RightCharacterName4)
	
	if i < 2 then
		return
	end
	
	-- 승리한 쪽이 있다면
	if WinnderIndex > 0 then
		winMgr:getWindow("ChampionshipWinnerLine"..i):setVisible(true)
		
		if i == 2 then  -- 우승일 경우만
			if WinnderIndex == leftTeamIndex then
				winMgr:getWindow("ChampionshipWinnerText"):setTextExtends(leftTeamName, g_STRING_FONT_GULIMCHE, 117,    255,255,255,255,     0,     0,0,0,255)
			elseif WinnderIndex == RightTeamIndex then
				winMgr:getWindow("ChampionshipWinnerText"):setTextExtends(RightTeamName, g_STRING_FONT_GULIMCHE, 117,    255,255,255,255,     0,     0,0,0,255)
			end
		end
		
		if WinnderIndex == leftTeamIndex then
			winMgr:getWindow("ChampionshipPieceLeft"..i):setTexture("Enabled", "UIData/championship.tga", 114, 635)
			winMgr:getWindow("ChampionshipPieceRight"..i):setTexture("Enabled", "UIData/championship.tga", 228, 635)
			winMgr:getWindow("ChampionshipWinnerLine"..i):setTexture("Disabled", "UIData/championship.tga", TeamChampionship_BoardWinTexX[i], TeamChampionship_BoardWinTexY[i])	
			if CheckleftLose == 1 then
				winMgr:getWindow(TeamChampionship_RootNumberText[i]):setTextExtends(leftTeamName, g_STRING_FONT_GULIMCHE, 112,   180,180,180,255,     0,     0,0,0,255)
			else
				winMgr:getWindow(TeamChampionship_RootNumberText[i]):setTextExtends(leftTeamName, g_STRING_FONT_GULIMCHE, 112,   255,255,255,255,     0,     0,0,0,255)
			end
		end
	
		if WinnderIndex == RightTeamIndex then
			winMgr:getWindow("ChampionshipPieceLeft"..i):setTexture("Enabled", "UIData/championship.tga", 228, 635)
			winMgr:getWindow("ChampionshipPieceRight"..i):setTexture("Enabled", "UIData/championship.tga", 114, 635)
			winMgr:getWindow("ChampionshipWinnerLine"..i):setTexture("Disabled", "UIData/championship.tga", TeamChampionship_BoardWinTexX2[i], TeamChampionship_BoardWinTexY2[i])
			if CheckLightLose == 1 then
				winMgr:getWindow(TeamChampionship_RootNumberText[i]):setTextExtends(RightTeamName, g_STRING_FONT_GULIMCHE, 112,   180,180,180,255,     0,     0,0,0,255)
			else
				winMgr:getWindow(TeamChampionship_RootNumberText[i]):setTextExtends(RightTeamName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
			end
		end
	end
	
	--  조 이름이 있으면 세팅
	if leftTeamName ~= "" then
		winMgr:getWindow("ChampionshipPieceLeft"..i):setEnabled(true)
		if CheckleftLose == 0 then
			winMgr:getWindow(i..'ChampionshipLeft'):setTextExtends(leftTeamName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
			winMgr:getWindow("ChampionshipPieceLeft"..i):setVisible(true)
		else
			winMgr:getWindow("ChampionshipPieceLeft"..i):setTexture("Enabled", "UIData/championship.tga", 228, 635)
			winMgr:getWindow(i..'ChampionshipLeft'):setTextExtends(leftTeamName, g_STRING_FONT_GULIMCHE, 112,    180,180,180,255,     0,     0,0,0,255)
		end
	end
	
	if RightTeamName ~= "" then
		winMgr:getWindow("ChampionshipPieceRight"..i):setEnabled(true)
		if CheckLightLose == 0 then
			winMgr:getWindow(i..'ChampionshipRight'):setTextExtends(RightTeamName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
			winMgr:getWindow("ChampionshipPieceRight"..i):setVisible(true)
		else
			winMgr:getWindow("ChampionshipPieceRight"..i):setTexture("Enabled", "UIData/championship.tga", 228, 635)
			winMgr:getWindow(i..'ChampionshipRight'):setTextExtends(RightTeamName, g_STRING_FONT_GULIMCHE, 112,    180,180,180,255,     0,     0,0,0,255)
		end

	end
	
	if CheckleftLose == 1 then
		winMgr:getWindow("ChampionshipPieceLeft"..i):setTexture("Enabled", "UIData/championship.tga", 228+114, 635)
	end
	
	if CheckLightLose == 1 then
		winMgr:getWindow("ChampionshipPieceRight"..i):setTexture("Enabled", "UIData/championship.tga", 228+114, 635)
	end
	
	-- 양쪽이 다 패배한 조는 승리선을 안보이게 한다
	if CheckleftLose == 1 and CheckLightLose == 1 then
		winMgr:getWindow("ChampionshipWinnerLine"..i):setVisible(false)
	end
	
	
	-- 툴팁을 위해 캐릭터명을 저장
	winMgr:getWindow(i..'ChampionshipLeftCharacterName'..1):setText(leftCharacterName1)
	winMgr:getWindow(i..'ChampionshipLeftCharacterName'..2):setText(leftCharacterName2)
	winMgr:getWindow(i..'ChampionshipLeftCharacterName'..3):setText(leftCharacterName3)
	winMgr:getWindow(i..'ChampionshipLeftCharacterName'..4):setText(leftCharacterName4)
	winMgr:getWindow(i..'ChampionshipRightCharacterName'..1):setText(RightCharacterName1)
	winMgr:getWindow(i..'ChampionshipRightCharacterName'..2):setText(RightCharacterName2)
	winMgr:getWindow(i..'ChampionshipRightCharacterName'..3):setText(RightCharacterName3)
	winMgr:getWindow(i..'ChampionshipRightCharacterName'..4):setText(RightCharacterName4)
end


------------------------------------------------------------------------------------
----- 토너먼트 팀 툴팁 백판 
------------------------------------------------------------------------------------
for i= 1, 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Championship_ToolTipImage"..i)
	mywindow:setTexture("Enabled", "UIData/championship.tga", 904, 630)
	mywindow:setTexture("Disabled", "UIData/championship.tga", 904, 630)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, i*21);
	mywindow:setSize(120, 21)
	mywindow:setEnabled(true)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
end

-- 토너먼트 팀 툴팁 정보 텍스트
ChampTeamInfoText		=   { ["protecterr"]=0, "ChampCharacterName1", "ChampCharacterName2" ,"ChampCharacterName3", "ChampCharacterName4"}																   
ChampTeamInfoPosX		=   { ["protecterr"]=0, 166, 174 , 403 , 418 }
ChampTeamInfoPosY		=   { ["protecterr"]=0, 36,  57 , 36, 57 }
ChampTeamInfoSetText	=	{['err'] = 0, '1번말', '2번말', '3번말', '4번말' }

for i=1 , #ChampTeamInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", ChampTeamInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(50, 4)
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)	
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setVisible(true)
	winMgr:getWindow('Championship_ToolTipImage'..i):addChildWindow(mywindow);
end



function OnMouseEnter_ShowChampLeftTooltipInfo(args)
	
	
	for i = 1, ChampionshipTeamCount do 
		root:addChildWindow(winMgr:getWindow("Championship_ToolTipImage"..i))
		winMgr:getWindow("Championship_ToolTipImage"..i):setVisible(true)
	end
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("ChampIndex"))
	
	for i = 1, ChampionshipTeamCount do 
		winMgr:getWindow("Championship_ToolTipImage"..i):setPosition(x+100, y+(i*21))
	end
	
	if index > 12 then
		for i = 1, ChampionshipTeamCount do 
			winMgr:getWindow("Championship_ToolTipImage"..i):setPosition(x-100, y+(i*21))
		end
	end

	winMgr:getWindow("ChampCharacterName1"):setTextExtends(winMgr:getWindow(index..'ChampionshipLeftCharacterName'..1):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName2"):setTextExtends(winMgr:getWindow(index..'ChampionshipLeftCharacterName'..2):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName3"):setTextExtends(winMgr:getWindow(index..'ChampionshipLeftCharacterName'..3):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName4"):setTextExtends(winMgr:getWindow(index..'ChampionshipLeftCharacterName'..4):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
end

function OnMouseEnter_ShowChampRightTooltipInfo(args)
	
	for i = 1, ChampionshipTeamCount do 
		root:addChildWindow(winMgr:getWindow("Championship_ToolTipImage"..i))
		winMgr:getWindow("Championship_ToolTipImage"..i):setVisible(true)
	end
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("ChampIndex"))
	DebugStr('index:'..index)
	
	for i = 1, ChampionshipTeamCount do 
		winMgr:getWindow("Championship_ToolTipImage"..i):setPosition(x+100, y+(i*21))
	end
	
	if index > 12 then
		for i = 1, ChampionshipTeamCount do 
			winMgr:getWindow("Championship_ToolTipImage"..i):setPosition(x-100, y+(i*21))
		end
	end

	winMgr:getWindow("ChampCharacterName1"):setTextExtends(winMgr:getWindow(index..'ChampionshipRightCharacterName'..1):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName2"):setTextExtends(winMgr:getWindow(index..'ChampionshipRightCharacterName'..2):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName3"):setTextExtends(winMgr:getWindow(index..'ChampionshipRightCharacterName'..3):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
	winMgr:getWindow("ChampCharacterName4"):setTextExtends(winMgr:getWindow(index..'ChampionshipRightCharacterName'..4):getText(), g_STRING_FONT_GULIMCHE, 112,    255,200,0,255,     1,     0,0,0,255)
end

function OnMouseLeave_HideChampTooltipInfo()
	for i = 1, 4 do 
		winMgr:getWindow("Championship_ToolTipImage"..i):setVisible(false)
	end
	
	return
end



-------------------------------------------------------------------
-- 연습버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionship1111")
mywindow:setTexture("Normal", "UIData/Tournament002.tga", 178, 358)
mywindow:setTexture("Hover", "UIData/Tournament002.tga", 178, 390)
mywindow:setTexture("Pushed", "UIData/Tournament002.tga", 178, 422)
mywindow:setTexture("PushedOff", "UIData/Tournament002.tga", 178, 358)
mywindow:setWideType(4)
mywindow:setPosition(800, 600)
mywindow:setSize(32, 32)
mywindow:subscribeEvent("Clicked", "ShowTeamChampionshipNotice")
--root:addChildWindow(mywindow)



-------------------------------------------------------------------
-- 팀전 토너먼트 알림판
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipNoticeBackImage")
mywindow:setTexture("Enabled", "UIData/tournament_popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/tournament_popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0 , 0);
mywindow:setSize(1024, 645)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipNoticeBackImage", "TeamChampionshipNoticeClose")

-------------------------------------------------------------------
-- 팀전 토너먼트 현재 진행상태 알리기
-------------------------------------------------------------------
TeamChampionship_CurrentStateImage =  { ["protecterr"]=0, "TeamChampionship_StateJoin", "TeamChampionship_StateJoinEnd", "TeamChampionship_StateStart"}
TeamChampionship_CurrentStateTexY =  { ["protecterr"]=0, 793, 825, 857}
TeamChampionship_CurrentStatePosX =  { ["protecterr"]=0, 324, 471, 618}

for i=1, #TeamChampionship_CurrentStateImage do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", TeamChampionship_CurrentStateImage[i])
	mywindow:setTexture("Enabled", "UIData/tournament_popup001.tga", 795, TeamChampionship_CurrentStateTexY[i])
	mywindow:setTexture("Disabled", "UIData/tournament_popup001.tga", 795, TeamChampionship_CurrentStateTexY[i])
	mywindow:setPosition(TeamChampionship_CurrentStatePosX[i], 303)
	mywindow:setVisible(false)
	mywindow:setSize(105, 32)
	winMgr:getWindow("TeamChampionshipNoticeBackImage"):addChildWindow(mywindow)
	mywindow:addController("ChampController", "ChampEffect", "visible", "Sine_EaseIn", 1, 1, 8, true, true, 10)
	mywindow:addController("ChampController", "ChampEffect", "visible", "Sine_EaseIn", 0, 0, 8, true, true, 10)
end

-- 챔피언쉽 노티스 보여주기
function ShowTeamChampionshipNotice()
	DebugStr('STATE리턴')
	--DebugStr('ShowTeamChampionshipNotice')
	if CheckNpcModeforLua() then
		DebugStr('npc랑 대화중')
		root:addChildWindow(winMgr:getWindow("TeamChampionshipNoticeBackImage"))
		winMgr:getWindow("TeamChampionshipNoticeBackImage"):setVisible(true)
		
		CurrentChampionshipState = GetChampionshipState()
		DebugStr('CurrentChampionshipState:'..CurrentChampionshipState)
		
		for i=1, #TeamChampionship_CurrentStateImage do
			winMgr:getWindow(TeamChampionship_CurrentStateImage[i]):clearActiveController();
			winMgr:getWindow(TeamChampionship_CurrentStateImage[i]):setVisible(false)
		end
		
		if CurrentChampionshipState == 1 then
			winMgr:getWindow("TeamChampionship_StateJoin"):activeMotion("ChampEffect")
			winMgr:getWindow("TeamChampionship_StateJoin"):setVisible(true)
		elseif CurrentChampionshipState == 2 then
			winMgr:getWindow("TeamChampionship_StateJoinEnd"):activeMotion("ChampEffect")
			winMgr:getWindow("TeamChampionship_StateJoinEnd"):setVisible(true)
		elseif CurrentChampionshipState == 3 or CurrentChampionshipState == 4 then
			winMgr:getWindow("TeamChampionship_StateStart"):activeMotion("ChampEffect")
			winMgr:getWindow("TeamChampionship_StateStart"):setVisible(true)
		end
	end
end

-------------------------------------------------------------------
-- 팀전 토너먼트 알림판 3개의 버튼
-------------------------------------------------------------------
TeamChampionship_NoticeBtn =  { ["protecterr"]=0, "TeamChampionship_NoticeBtn1", "TeamChampionship_NoticeBtn2", "TeamChampionship_NoticeBtn3"}
TeamChampionship_NoticeBtnTexX =  { ["protecterr"]=0, 0, 265, 530}
TeamChampionship_NoticeBtnPosX =  { ["protecterr"]=0, 83, 375, 675}
TeamChampionship_NoticeBtnEvent =  { ["protecterr"]=0, "OnClickTeamChampionshipNotice", "RequestChampionshipInfo", "OnClickTeamChampionshipMathchList"}

for i=1, #TeamChampionship_NoticeBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", TeamChampionship_NoticeBtn[i])
	mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", TeamChampionship_NoticeBtnTexX[i], 645)
	mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", TeamChampionship_NoticeBtnTexX[i], 726)
	mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", TeamChampionship_NoticeBtnTexX[i], 807)
	mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", TeamChampionship_NoticeBtnTexX[i], 645)
	mywindow:setPosition(TeamChampionship_NoticeBtnPosX[i], 346)
	mywindow:setSize(265, 81)
	mywindow:subscribeEvent("Clicked", TeamChampionship_NoticeBtnEvent[i])
	winMgr:getWindow("TeamChampionshipNoticeBackImage"):addChildWindow(mywindow)
end

-------------------------------------------------------------------
-- 팀 토너먼트 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipNoticeCloseBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(984, 74)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipNoticeClose")
winMgr:getWindow("TeamChampionshipNoticeBackImage"):addChildWindow(mywindow)

function OnClickTeamChampionshipNoticeClose()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TeamChampionshipNoticeBackImage"):setVisible(false)
	TownNpcEscBtnClickEvent()
	for i=1, #TeamChampionship_CurrentStateImage do
		winMgr:getWindow(TeamChampionship_CurrentStateImage[i]):clearActiveController();
	end
end

function TeamChampionshipNoticeClose()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TeamChampionshipNoticeBackImage"):setVisible(false)
	for i=1, #TeamChampionship_CurrentStateImage do
		winMgr:getWindow(TeamChampionship_CurrentStateImage[i]):clearActiveController();
	end
end

-------------------------------------------------------------------
-- 팀전 토너먼트 참여 리스트 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipNoticeAgreeListBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 795, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 795, 682)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 795, 719)
mywindow:setTexture("Disabled", "UIData/tournament_popup001.tga", 795, 756)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 795, 645)
mywindow:setPosition(278, 581)
--mywindow:setEnabled(false)
mywindow:setSize(164, 37)
mywindow:subscribeEvent("Clicked", "GetChampionshipAgreeList")
winMgr:getWindow("TeamChampionshipNoticeBackImage"):addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀전 토너먼트 우승자 리스트 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipWinnerListBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 861, 890)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 861, 928)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 861, 966)
mywindow:setTexture("Disabled", "UIData/tournament_popup001.tga", 861, 890)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 861, 890)
mywindow:setPosition(575, 581)
--mywindow:setEnabled(false)
mywindow:setSize(164, 37)
mywindow:subscribeEvent("Clicked", "OnClickGetChampionshipWinnerList")
winMgr:getWindow("TeamChampionshipNoticeBackImage"):addChildWindow(mywindow)

function OnClickGetChampionshipWinnerList()
	g_TeamChampionshipWinnerListPage = 1
	GetChampionshipWinnerList(g_TeamChampionshipWinnerListPage)
end

-------------------------------------------------------------------
-- 팀전 토너먼트 알림내용이미지
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipNoticeSubImage")
mywindow:setTexture("Enabled", "UIData/tournament_popup002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/tournament_popup002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(100 , 100);
mywindow:setSize(808, 499)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-------------------------------------------------------------------
-- 팀 토너먼트 알림 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipNoticeSubCloseBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(750, 34)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipNoticeSubImageClose")
winMgr:getWindow("TeamChampionshipNoticeSubImage"):addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipNoticeSubImage", "OnClickTeamChampionshipNoticeSubImageClose")

function OnClickTeamChampionshipNotice()
	root:addChildWindow(winMgr:getWindow("TeamChampionshipNoticeSubImage"))
	winMgr:getWindow("TeamChampionshipNoticeSubImage"):setVisible(true)
	winMgr:getWindow("TeamChampionshipNoticeSubImage"):setTexture("Enabled", "UIData/tournament_popup002.tga", 0, 0)
end

function OnClickTeamChampionshipHowTo()
	root:addChildWindow(winMgr:getWindow("TeamChampionshipNoticeSubImage"))
	winMgr:getWindow("TeamChampionshipNoticeSubImage"):setVisible(true)
	winMgr:getWindow("TeamChampionshipNoticeSubImage"):setTexture("Enabled", "UIData/tournament_popup002.tga", 0, 499)
end

function OnClickTeamChampionshipNoticeSubImageClose()
	winMgr:getWindow("TeamChampionshipNoticeSubImage"):setVisible(false)
end

function OnClickTeamChampionshipMathchList()
	ChampionshipGetListofMatch()
end


-------------------------------------------------------------------
-- 팀전 토너먼트 참여 리스트
-------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipNoticeAgreeListImg")
mywindow:setTexture("Enabled", "UIData/tournament002.tga", 0, 486)
mywindow:setTexture("Disabled", "UIData/tournament002.tga", 0, 486)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(360 , 150);
mywindow:setSize(290, 362)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("TeamChampionshipNoticeAgreeListImg", "TeamChampionshipNoticeAgreeListClose")

function TeamChampionshipNoticeAgreeListClose()
	winMgr:getWindow("TeamChampionshipNoticeAgreeListImg"):setVisible(false)
end


-------------------------------------------------------------------
-- 팀 토너먼트 참여리스트 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TeamChampionshipAgreeListCloseBtn")
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(260, 7)
mywindow:setSize(22, 22)
mywindow:subscribeEvent("Clicked", "TeamChampionshipNoticeAgreeListClose")
winMgr:getWindow("TeamChampionshipNoticeAgreeListImg"):addChildWindow(mywindow)


g_TeamChampionshipAgreeListPage = 1
g_TeamChampionshipAgreeListMaxPage = 1

-------------------------------------------------------------------
-- 팀 토너먼트 참여 리스트 텍스트
--------------------------------------------------------------------
TeamChampionshipAgreeListTextX    = {['err'] = 0, 10, 150, 150, 200, 200 } 
TeamChampionshipAgreeListTextY    = {['err'] = 0, 20, 8, 32, 400, 500 } 

TeamChampionshipAgreeListTextName = { ["protecterr"]=0, "TeamChampionshipAgreeList_TeamName", "TeamChampionshipAgreeList_CharName0", 
								"TeamChampionshipAgreeList_CharName1", "TeamChampionshipAgreeList_CharName2", "TeamChampionshipAgreeList_CharName3"}
								
TeamChampionshipAgreeListSetText = { ["protecterr"]=0, "TeamName", "CharName0", 
								"CharName1", "CharName2", "CharName3"}

for i=1 , 5 do		
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipAgreeList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 818, 676)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 818, 676)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition( 5 , 81+(i*48)-48);
	mywindow:setSize(280, 46)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('TeamChampionshipNoticeAgreeListImg'):addChildWindow(mywindow)
	
	for j = 1, #TeamChampionshipAgreeListTextName do					
		mywindow = winMgr:createWindow("TaharezLook/StaticText", TeamChampionshipAgreeListTextName[j]..i);
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
		mywindow:setPosition(TeamChampionshipAgreeListTextX[j], TeamChampionshipAgreeListTextY[j]);
		mywindow:setSize(80, 20)
		mywindow:setViewTextMode(1)
		mywindow:setAlign(8)
		mywindow:setLineSpacing(2)
		mywindow:clearTextExtends()
		mywindow:setZOrderingEnabled(false)
	
		mywindow:setVisible(true);
		winMgr:getWindow("TeamChampionshipAgreeList_image_"..i):addChildWindow(mywindow);
	end	
end


function ResetChampionshipAgreeList(CurrentPage, MaxPage)
	
	root:addChildWindow(winMgr:getWindow("TeamChampionshipNoticeAgreeListImg"))
	winMgr:getWindow("TeamChampionshipNoticeAgreeListImg"):setVisible(true)
	
	for i=1 , 5 do
		for j = 1, #TeamChampionshipAgreeListTextName do	
			winMgr:getWindow(TeamChampionshipAgreeListTextName[j]..i):clearTextExtends()	
		end
	end
	
	g_TeamChampionshipAgreeListPage = CurrentPage
	g_TeamChampionshipAgreeListMaxPage = MaxPage
	winMgr:getWindow("TeamChampionshipAgreeList_PageText"):setTextExtends(tostring(g_TeamChampionshipAgreeListPage)..' / '..tostring(g_TeamChampionshipAgreeListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end

function SettingChampionshipAgreeList(index, TeamName, Character1, Character2, Character3, Character4)
	
	winMgr:getWindow(TeamChampionshipAgreeListTextName[1]..index):setTextExtends(TeamName, g_STRING_FONT_GULIMCHE, 112,    53,255,134,255,     0,     0,0,0,255)
	winMgr:getWindow(TeamChampionshipAgreeListTextName[2]..index):setTextExtends(Character1, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(TeamChampionshipAgreeListTextName[3]..index):setTextExtends(Character2, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
	if IsKoreanLanguage() == false then
		winMgr:getWindow(TeamChampionshipAgreeListTextName[4]..index):setText(Character3)
		winMgr:getWindow(TeamChampionshipAgreeListTextName[5]..index):setText(Character4)
	end
end


---------------------------------------
--- 팀전 토너먼트 신청 리스트 앞뒤버튼
---------------------------------------
local TeamChampionshipAgreeList_BtnName  = {["err"]=0, [0]="TeamChampionshipAgreeList_LBtn", "TeamChampionshipAgreeList_RBtn"}
local TeamChampionshipAgreeList_BtnTexX  = {["err"]=0, [0]= 0, 22}

local TeamChampionshipAgreeList_BtnPosX  = {["err"]=0, [0]= 93, 188}
local TeamChampionshipAgreeList_BtnEvent = {["err"]=0, [0]= "TeamChampionshipAgreeList_BtnTexX_PrevPage", "TeamChampionshipAgreeList_BtnTexX_NextPage"}
for i=0, #TeamChampionshipAgreeList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", TeamChampionshipAgreeList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", TeamChampionshipAgreeList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", TeamChampionshipAgreeList_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",TeamChampionshipAgreeList_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", TeamChampionshipAgreeList_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", TeamChampionshipAgreeList_BtnTexX[i], 81)
	mywindow:setPosition(TeamChampionshipAgreeList_BtnPosX[i], 323)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", TeamChampionshipAgreeList_BtnEvent[i])
	winMgr:getWindow('TeamChampionshipNoticeAgreeListImg'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "TeamChampionshipAgreeList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(110, 328)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(tostring(g_TeamChampionshipAgreeListPage)..' / '..tostring(g_TeamChampionshipAgreeListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('TeamChampionshipNoticeAgreeListImg'):addChildWindow(mywindow)

function TeamChampionshipAgreeList_BtnTexX_NextPage()
	if g_TeamChampionshipAgreeListPage < g_TeamChampionshipAgreeListMaxPage then
		GetChampionshipAgreeListPage(g_TeamChampionshipAgreeListPage+1, g_TeamChampionshipAgreeListMaxPage)
	end
end

function TeamChampionshipAgreeList_BtnTexX_PrevPage()
	if g_TeamChampionshipAgreeListPage > 1 then
		GetChampionshipAgreeListPage(g_TeamChampionshipAgreeListPage-1 , g_TamChampionshipAgreeListMaxPage)
	end
end





---------------------------------------------------------------------
--팀토너먼트  명예의 전당 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipWinnerBoard")
mywindow:setTexture("Enabled", "UIData/tournament002.tga", 522, 484)
mywindow:setTexture("Disabled", "UIData/tournament002.tga", 522, 484)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(272,100);
mywindow:setSize(502, 540)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

---------------------------------------------------------------------
--팀토너먼트 몇회인지 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipinning1")
mywindow:setTexture("Enabled", "UIData/tournament002.tga", 14, 1004)
mywindow:setTexture("Disabled", "UIData/tournament002.tga", 14, 1004)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(385,15);
mywindow:setSize(14, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TeamChampionshipWinnerBoard"):addChildWindow(mywindow)

---------------------------------------------------------------------
--팀토너먼트 몇회인지 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TeamChampionshipinning2")
mywindow:setTexture("Enabled", "UIData/tournament002.tga", 0, 1004)
mywindow:setTexture("Disabled", "UIData/tournament002.tga", 0, 1004)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(372,15);
mywindow:setSize(14, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TeamChampionshipWinnerBoard"):addChildWindow(mywindow)


TeamChampionshipNamePosX = {['err'] = 0, 300, 300,  300, 300,  300, 300, 300, 300}
TeamChampionshipNamePosY = {['err'] = 0, 120, 150,	255, 290,  362, 382, 407, 427}

---------------------------------------------------------------------
--팀토너먼트 명예의 전당 우승팀 이름
-----------------------------------------------------------------------
for i=1, 8 do
	local child_window = winMgr:createWindow("TaharezLook/StaticText", "TeamChampionshipWinnerName"..i)	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(TeamChampionshipNamePosX[i], TeamChampionshipNamePosY[i])
	child_window:setViewTextMode(1)	
	child_window:setAlign(7)
	child_window:setTextExtends('WinnerGang'..i, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
	child_window:setLineSpacing(1)
	winMgr:getWindow("TeamChampionshipWinnerBoard"):addChildWindow(child_window)
end


TeamChampionshipRewardPosX = {['err'] = 0, 300, 300, 300}
TeamChampionshipRewardPosY = {['err'] = 0, 182, 315, 450}
---------------------------------------------------------------------
-- 팀토너먼트 명예의 전당 우승 상금
-----------------------------------------------------------------------
for i=1, 3 do
	local child_window = winMgr:createWindow("TaharezLook/StaticText", "TeamChampionshipBoardReward"..i)	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(TeamChampionshipRewardPosX[i], TeamChampionshipRewardPosY[i])
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	winMgr:getWindow("TeamChampionshipWinnerBoard"):addChildWindow(child_window)
end

------------------------------------------------------------------
-- 팀토너먼트 명예의 전당 닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseTeamChampionshipWinnerBoard");	
mywindow:setTexture("Normal", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setTexture("Hover", "UIData/tournament_popup001.tga", 1002, 667)
mywindow:setTexture("Pushed", "UIData/tournament_popup001.tga", 1002, 689)
mywindow:setTexture("PushedOff", "UIData/tournament_popup001.tga", 1002, 645)
mywindow:setPosition(470, 6)
mywindow:setSize(22, 22)
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseTeamChampionshipWinnerBoard");
winMgr:getWindow("TeamChampionshipWinnerBoard"):addChildWindow(mywindow)


RegistEscEventInfo("TeamChampionshipWinnerBoard", "OnClickCloseTeamChampionshipWinnerBoard")

function OnClickCloseTeamChampionshipWinnerBoard()
	winMgr:getWindow('TeamChampionshipWinnerBoard'):setVisible(false)
end




------------------------------------------------------------------
-- 명예의 전당 리셋
------------------------------------------------------------------
function ResetTeamTourWinnerHistory()
	for i=1, 8 do
		winMgr:getWindow('TeamChampionshipWinnerName'..i):clearTextExtends()
	end
	
	for i=1, 3 do
		winMgr:getWindow('TeamChampionshipBoardReward'..i):clearTextExtends()
	end
end

------------------------------------------------------------------
-- 명예의 전당 세팅
------------------------------------------------------------------
function SettingTeamTourWinnerHistory(charname1, charname2 ,charname3, charname4, charname5, charname6, charname7, charname8, inning, reward1, reward2, reward3)
	winMgr:getWindow("TeamChampionshipWinnerBoard"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("TeamChampionshipWinnerBoard"))
	
	local ten = (inning/10)
	local one = (inning%10)
	winMgr:getWindow("TeamChampionshipinning1"):setTexture("Enabled", "UIData/tournament002.tga", one*14, 1004)
	winMgr:getWindow("TeamChampionshipinning1"):setTexture("Disabled", "UIData/tournament002.tga", one*14, 1004)
	winMgr:getWindow("TeamChampionshipinning2"):setTexture("Enabled", "UIData/tournament002.tga", ten*14, 1004)
	winMgr:getWindow("TeamChampionshipinning2"):setTexture("Disabled", "UIData/tournament002.tga", ten*14, 1004)

	winMgr:getWindow("TeamChampionshipWinnerName1"):setTextExtends(charname1, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName2"):setTextExtends(charname2, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName3"):setTextExtends(charname3, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName4"):setTextExtends(charname4, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName5"):setTextExtends(charname5, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName6"):setTextExtends(charname6, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName7"):setTextExtends(charname7, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	winMgr:getWindow("TeamChampionshipWinnerName8"):setTextExtends(charname8, g_STRING_FONT_GULIMCHE, 115,    255,255,255,255,     0,     0,0,0,255)
	
	-- 보상은 0이상일 경우에만 세팅
	if reward1 > 0 then
		local MoneyCom1 = CommatoMoneyStr(reward1)
		local r,g,b = GetGranColor(reward1)
		winMgr:getWindow('TeamChampionshipBoardReward1'):setTextExtends(MoneyCom1, g_STRING_FONT_GULIMCHE, 113,    r,g,b,255,     0,     0,0,0,255)
	end
	
	if reward2 > 0 then
		local MoneyCom2 = CommatoMoneyStr(reward2)
		local r,g,b = GetGranColor(reward2)
		winMgr:getWindow('TeamChampionshipBoardReward2'):setTextExtends(MoneyCom2, g_STRING_FONT_GULIMCHE, 113,    r,g,b,255,     0,     0,0,0,255)
	end
	
	if reward3 > 0 then
		local MoneyCom3 = CommatoMoneyStr(reward3)
		local r,g,b = GetGranColor(reward3)
		winMgr:getWindow('TeamChampionshipBoardReward3'):setTextExtends(MoneyCom3, g_STRING_FONT_GULIMCHE, 113,   r,g,b,255,     0,     0,0,0,255)
	end
end

g_TeamChampionshipWinnerListPage = 1
g_TamChampionshipWinnerListMaxPage = 1
---------------------------------------
--- 팀전 토너먼트 신청 리스트 앞뒤버튼
---------------------------------------
local TeamChampionshipWinnerList_BtnName  = {["err"]=0, [0]="TeamChampionshipWinnerList_LBtn", "TeamChampionshipWinnerList_RBtn"}
local TeamChampionshipWinnerList_BtnTexX  = {["err"]=0, [0]= 0, 22}

local TeamChampionshipWinnerList_BtnPosX  = {["err"]=0, [0]= 193, 288}
local TeamChampionshipWinnerList_BtnEvent = {["err"]=0, [0]= "TeamChampionshipWinnerList_BtnTexX_PrevPage", "TeamChampionshipWinnerList_BtnTexX_NextPage"}
for i=0, #TeamChampionshipWinnerList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", TeamChampionshipWinnerList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", TeamChampionshipWinnerList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", TeamChampionshipWinnerList_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",TeamChampionshipWinnerList_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", TeamChampionshipWinnerList_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", TeamChampionshipWinnerList_BtnTexX[i], 81)
	mywindow:setPosition(TeamChampionshipWinnerList_BtnPosX[i], 502)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", TeamChampionshipWinnerList_BtnEvent[i])
	winMgr:getWindow('TeamChampionshipWinnerBoard'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "TeamChampionshipWinnerList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(210, 507)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(tostring(g_TeamChampionshipWinnerListPage)..' / '..tostring(g_TamChampionshipWinnerListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('TeamChampionshipWinnerBoard'):addChildWindow(mywindow)

function TeamChampionshipWinnerList_BtnTexX_NextPage()
	if g_TeamChampionshipWinnerListPage < g_TamChampionshipWinnerListMaxPage then
		g_TeamChampionshipWinnerListPage = g_TeamChampionshipWinnerListPage + 1
		GetChampionshipWinnerList(g_TeamChampionshipWinnerListPage)
	end
end

function TeamChampionshipWinnerList_BtnTexX_PrevPage()
	if g_TeamChampionshipWinnerListPage > 1 then
		g_TeamChampionshipWinnerListPage = g_TeamChampionshipWinnerListPage -1
		GetChampionshipWinnerList(g_TeamChampionshipWinnerListPage)
	end
end

function SettingTeamChampionshipPage(MaxPage)
	g_TamChampionshipWinnerListMaxPage = MaxPage
	winMgr:getWindow("TeamChampionshipWinnerList_PageText"):setTextExtends(tostring(g_TeamChampionshipWinnerListPage)..' / '..tostring(g_TamChampionshipWinnerListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end
