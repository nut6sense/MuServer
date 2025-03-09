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

g_ProfilePage = 1
g_ProfileMaxPage = 1
g_ProfileBlackPage = 1
g_ProfileBlackMaxPage = 1
g_ProfileHistory1Page = 1
g_ProfileHistory2Page = 1
g_ProfileHistory3Page = 1
ReplyIndex = 1
IsMyProfile = 0
					
local String_Secret	= PreCreateString_2394	--GetSStringInfo(LAN_PROFILE_SECRET)
function ShowProfileRequest(RequestName)
	g_ProfilePage = 1
	GetProfileInfo(RequestName)
end

----------------------------------------------------------------------
--프로필 백그라운드 윈도우 생성
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ProfileBackImage")
mywindow:setTexture("Enabled", "UIData/Profile001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Profile001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(200, 67);
mywindow:setSize(513, 656)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Profile_titlebar")
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(3, 1)
mywindow:setSize(490, 20)
winMgr:getWindow("ProfileBackImage"):addChildWindow(mywindow)

RegistEscEventInfo("ProfileBackImage", "OnClickProfileClose")


----------------------------------------------------------------------
-- 홈버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyProfileHomeBtn")
mywindow:setTexture("Normal", "UIData/profile001.tga", 702, 280)
mywindow:setTexture("Hover", "UIData/profile001.tga", 728, 280)
mywindow:setTexture("Pushed", "UIData/profile001.tga", 754, 280)
mywindow:setTexture("PushedOff", "UIData/profile001.tga", 702, 280)
mywindow:setPosition(10, 8)
mywindow:setSize(26, 26)
mywindow:setSubscribeEvent("Clicked", "ShowMyProfile")
winMgr:getWindow("ProfileBackImage"):addChildWindow(mywindow)

function ShowMyProfile()
	Mainbar_ClearEffect(BAR_BUTTONTYPE_PROFILE)
	
	ClearGuestBook()
	GotoMyProfile()
	
	DebugStr("ShowMyProfile()")
end

function ShowProfileUi()	
	DebugStr("ShowProfileUi")
	
	if winMgr:getWindow("ProfileBackImage"):isVisible() then
		DebugStr("끄기")
		winMgr:getWindow("ProfileBackImage"):setVisible(false)
		winMgr:getWindow("ProfileHistoryBack"):setVisible(false)
	else
		DebugStr("켜기")
		ShowMyProfile()
	end
end

--------------------------------------------------------------------
-- 프로필 기본정보 텍스트
--------------------------------------------------------------------
Profile_Secret_Text =	{ ["protecterr"]=0, "Profile_Secret_Name", "Profile_Secret_Age", "Profile_Secret_Sex" , "Profile_Secret_PhoneNumber" ,
											"Profile_Secret_Messeager" , "Profile_Secret_Home" , "Profile_Character_Name" , "Profile_TodayCount", "Profile_TotalCount"}
											
Profile_Secret_PosX  =    { ["protecterr"]=0, 130, 340, 446, 130, 305, 130, 45 , 45, 130}
Profile_Secret_PosY  =    { ["protecterr"]=0, 85, 85, 85, 110, 110, 135 , 8 , 52, 52 }	
for i=1 , #Profile_Secret_Text do

	mywindow = winMgr:createWindow("TaharezLook/StaticText", Profile_Secret_Text[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(230,230,230, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	if i == 7 then
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
		mywindow:setTextColor(255,198,0,255)
	end
	mywindow:setEnabled(false)
	mywindow:setPosition(Profile_Secret_PosX[i], Profile_Secret_PosY[i])
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ProfileBackImage"):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 프로필 사진 이미지
--------------------------------------------------------------------

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ProfileInfoEmblem')
mywindow:setTexture('Enabled', 'UIData/itemUidata/item/invisible.tga', 0, 0)
mywindow:setTexture('Disabled', 'UIData/itemUidata/item/invisible.tga', 0, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(14, 85)
mywindow:setSize(64, 64)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
--프로필 자기소개 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Profile_Indroduce");
mywindow:setPosition(40, 165);
mywindow:setSize(380, 143);
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(true)
mywindow:setViewTextMode(1)
mywindow:setAlign(1)
mywindow:setVisible(true);
mywindow:setLineSpacing(7)
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 방명록 리프레쉬 버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "GuestBookRefreshBtn")
mywindow:setTexture("Normal", "UIData/profile001.tga", 702, 256)
mywindow:setTexture("Hover", "UIData/profile001.tga", 726, 256)
mywindow:setTexture("Pushed", "UIData/profile001.tga", 750, 256)
mywindow:setTexture("PushedOff", "UIData/profile001.tga", 774, 256)
mywindow:setPosition(110, 226)
mywindow:setSize(24, 24)
mywindow:setSubscribeEvent("Clicked", "OnGuestRefresh")
winMgr:getWindow("ProfileBackImage"):addChildWindow(mywindow)

function OnGuestRefresh()
	GetProfileGuestBook(1)
end

function OnGuestAddMessageRefresh()
	GetProfileGuestBook(g_ProfilePage)
end
----------------------------------------------------------------------
-- 방명록 입력 에디트박스
----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Editbox", "InputGuestBook")
mywindow:setText("")
mywindow:setPosition(30, 260)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(380, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("InputGuestBook")):setMaxTextLength(210)
mywindow:setSubscribeEvent("TextAccepted", "OnClickInputGuestBook")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 방명록 등록 버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "InputGuestBookBtn")
mywindow:setTexture("Normal", "UIData/Profile001.tga", 513, 344)
mywindow:setTexture("Hover", "UIData/Profile001.tga", 513, 366)
mywindow:setTexture("Pushed", "UIData/Profile001.tga", 513, 388)
mywindow:setTexture("PushedOff", "UIData/Profile001.tga", 513, 410)
mywindow:setPosition(415, 260)
mywindow:setSize(69, 22)
mywindow:setSubscribeEvent("Clicked", "OnClickInputGuestBook")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 방명록 등록버튼 호출
----------------------------------------------------------------------
function OnClickInputGuestBook()

	GuestBookMsg = winMgr:getWindow('InputGuestBook'):getText()
	if GuestBookMsg == "" then
		return
	end
	winMgr:getWindow('InputGuestBook'):setText("")
	WriteGuestBook(GuestBookMsg)
	
end
	

------------------------------------------------------------------------------------
-- 방명록 라디오버튼
------------------------------------------------------------------------------------
GuestBook_Radio = 
{ ["protecterr"]=0, "GuestBook_Radio1", "GuestBook_Radio2", "GuestBook_Radio3" , "GuestBook_Radio4", "GuestBook_Radio5"}
	
GuestBookText	= {['err'] = 0, 'GuestName', 'GeuestInputDay', 'GuestRemainDay', 'GuestMsg' , 'GuestAddMsg' , 'BookIndex'}
								
GuestBookTextPosX		= {['err'] = 0, 110, 270, 380 , 35 , 35, 0 }
GuestBookTextPosY		= {['err'] = 0, 5, 5, 5 , 23 , 43 , 0}
GuestBookSizeX			= {['err'] = 0, 5, 5, 5 ,5 , 5 ,5}
GuestBookSizeY			= {['err'] = 0, 5, 5, 5 ,5 , 5 ,5}


for i=1, #GuestBook_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	GuestBook_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		522, 415)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		522, 443)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	522, 443)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedHover", "UIData/invisible4.tga",	 522, 443)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 522, 443)
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			522, 471);
	mywindow:setSize(468, 59)
	mywindow:setPosition(22, 292+63*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)
	
	--  댓글용 백판
	Addmywindow = winMgr:createWindow("TaharezLook/StaticImage", GuestBook_Radio[i]..'AddMsgBackImage')
	Addmywindow:setTexture("Enabled", "UIData/Profile001.tga", 513, 547)
	Addmywindow:setTexture("Disabled", "UIData/Profile001.tga", 513, 547)
	Addmywindow:setProperty("FrameEnabled", "False")
	Addmywindow:setProperty("BackgroundEnabled", "False")
	Addmywindow:setPosition(12, 37);
	Addmywindow:setSize(435, 22)
	Addmywindow:setVisible(false)
	Addmywindow:setEnabled(false)
	Addmywindow:setZOrderingEnabled(true)
	mywindow:addChildWindow(Addmywindow)

	for j=1, #GuestBookText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", GuestBook_Radio[i]..GuestBookText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(GuestBookSizeX[j], GuestBookSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(GuestBookTextPosX[j], GuestBookTextPosY[j])
		child_window:setViewTextMode(1)	
		if j < 4 then
			child_window:setAlign(8)
		else
			child_window:setAlign(0)
		end
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end

	--  방명록 프로필 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', GuestBook_Radio[i]..'ProfileImage')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(0, 3)
	child_window:setScaleWidth(130)
	child_window:setScaleHeight(130)
	child_window:setSize(64, 64)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	-- 방명록 프로필로 답글하기 버튼
	child_Rep = winMgr:createWindow("TaharezLook/Button", GuestBook_Radio[i]..'ProfileRepBtn')
    child_Rep:setTexture("Normal",		"UIData/Profile001.tga",	651, 256)	
	child_Rep:setTexture("Hover",		"UIData/Profile001.tga",	651, 273)
	child_Rep:setTexture("Pushed",		"UIData/Profile001.tga",	651, 290)
	child_Rep:setTexture("PushedOff",	"UIData/Profile001.tga",	651, 256)
	child_Rep:setTexture("Disabled",	"UIData/Profile001.tga",	651, 307)
	child_Rep:setPosition(408, 2)
	child_Rep:setSize(17, 17)
	child_Rep:setVisible(false)
	child_Rep:setUserString("AddIndex", i )
	child_Rep:setSubscribeEvent("Clicked", "OnClickProfileRep")
	mywindow:addChildWindow(child_Rep)
	
	-- 방명록 프로필 이동 버튼
	child_Move = winMgr:createWindow("TaharezLook/Button", GuestBook_Radio[i]..'ProfileMoveBtn')
    child_Move:setTexture("Normal",		"UIData/Profile001.tga",	668, 256)	
	child_Move:setTexture("Hover",		"UIData/Profile001.tga",	668, 273)
	child_Move:setTexture("Pushed",		"UIData/Profile001.tga",	668, 290)
	child_Move:setTexture("PushedOff",	"UIData/Profile001.tga",	668, 256)
	child_Move:setTexture("Disabled",	"UIData/Profile001.tga",	668, 307)
	child_Move:setPosition(428, 2)
	child_Move:setSize(17, 17)
	child_Rep:setVisible(false)
	child_Move:setUserString("BookMoveIndex", i )
	child_Move:setSubscribeEvent("Clicked", "OnClickProfileMove")
	mywindow:addChildWindow(child_Move)
	
	-- 방명록 프로필 삭제
	child_Del = winMgr:createWindow("TaharezLook/Button", GuestBook_Radio[i]..'ProfileDelBtn')
    child_Del:setTexture("Normal",		"UIData/Profile001.tga",	685, 256)	
	child_Del:setTexture("Hover",		"UIData/Profile001.tga",	685, 273)
	child_Del:setTexture("Pushed",		"UIData/Profile001.tga",	685, 290)
	child_Del:setTexture("PushedOff",	"UIData/Profile001.tga",	685, 256)
	child_Del:setTexture("Disabled",	"UIData/Profile001.tga",	685, 307)
	child_Del:setPosition(448, 2)
	child_Del:setSize(17, 17)
	child_Del:setVisible(false)
	child_Del:setUserString("BookDelIndex", i )
	child_Del:setSubscribeEvent("Clicked", "OnClickProfileDel")
	mywindow:addChildWindow(child_Del)
	
	-- 방명록 댓글 삭제
	child_SubDel = winMgr:createWindow("TaharezLook/Button", GuestBook_Radio[i]..'ProfileSubDelBtn')
    child_SubDel:setTexture("Normal",		"UIData/Profile001.tga",	685, 256)	
	child_SubDel:setTexture("Hover",		"UIData/Profile001.tga",	685, 273)
	child_SubDel:setTexture("Pushed",		"UIData/Profile001.tga",	685, 290)
	child_SubDel:setTexture("PushedOff",	"UIData/Profile001.tga",	685, 256)
	child_SubDel:setTexture("Disabled",		"UIData/Profile001.tga",	685, 307)
	child_SubDel:setPosition(448, 40)
	child_SubDel:setSize(17,17)
	child_SubDel:setVisible(false)
	child_SubDel:setUserString("BookSubDelIndex", i )
	child_SubDel:setSubscribeEvent("Clicked", "OnClickProfileSubDel")
	mywindow:addChildWindow(child_SubDel)
end
----------------------------------------------------------------------
-- 댓글달기 호출버튼
-----------------------------------------------------------------------
function OnClickProfileRep(args)
	DebugStr('OnClickProfileRep()');
	 local local_window = CEGUI.toWindowEventArgs(args).window;	
	 local win_name = local_window:getName();
	 local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("AddIndex"))
	 ReplyIndex = winMgr:getWindow(GuestBook_Radio[index]..'BookIndex'):getText()
	 root:addChildWindow(winMgr:getWindow('GuestBookReplyImage'))
	 winMgr:getWindow('GuestBookReplyImage'):setVisible(true)
	 winMgr:getWindow('GuestBookReplyEditBox'):activate()
end

----------------------------------------------------------------------
-- 선택한글 지우기
-----------------------------------------------------------------------
function OnClickProfileDel(args)
	DebugStr('OnClickProfileDel()');
	 local local_window = CEGUI.toWindowEventArgs(args).window;	
	 local win_name = local_window:getName();
	 local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("BookDelIndex"))
	 local BookIndex = winMgr:getWindow(GuestBook_Radio[index]..'BookIndex'):getText()
	 DebugStr('BookIndex : '..BookIndex);
	 DeleteGuestBook(0, BookIndex, g_ProfilePage)
	 
end

----------------------------------------------------------------------
-- 댓글 지우기
-----------------------------------------------------------------------
function OnClickProfileSubDel(args)
	DebugStr('OnClickProfileSubDel()');
	 local local_window = CEGUI.toWindowEventArgs(args).window;	
	 local win_name = local_window:getName();
	 local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("BookSubDelIndex"))
	 local BookIndex = winMgr:getWindow(GuestBook_Radio[index]..'BookIndex'):getText()
	 local SubMsg = winMgr:getWindow(GuestBook_Radio[index]..'GuestAddMsg'):getText()
	 if SubMsg == "" then
		return
	 end
	 DeleteGuestBook(1, BookIndex, g_ProfilePage)
end
----------------------------------------------------------------------
-- 방명록 이동
-----------------------------------------------------------------------
function OnClickProfileMove(args)
	 DebugStr('OnClickProfileMove');
	 local local_window = CEGUI.toWindowEventArgs(args).window;	
	 local win_name = local_window:getName();
	 local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("BookMoveIndex"))
	 local GuestBookName = winMgr:getWindow(GuestBook_Radio[index]..'GuestName'):getText()
	 if GuestBookName == "" then
		return
	 end
	 ClearGuestBook()
	 winMgr:getWindow('ProfileRepairImage'):setVisible(false)
	 GetProfileInfo(GuestBookName) 
end
----------------------------------------------------------------------
-- 방명록 댓글 팝업 윈도우
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GuestBookReplyImage")
mywindow:setTexture("Enabled", "UIData/Profile001.tga", 513, 432)
mywindow:setTexture("Disabled", "UIData/Profile001.tga", 513, 432)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(300, 200);
mywindow:setSize(406, 115)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("GuestBookReplyImage", "OnClickGuestBookReplyCancel")
----------------------------------------------------------------------
-- 방명록 답글 에디트박스
----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Editbox", "GuestBookReplyEditBox")
mywindow:setText("")
mywindow:setPosition(30, 48)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(335, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("GuestBookReplyEditBox")):setMaxTextLength(200)
mywindow:setSubscribeEvent("TextAccepted", "OnClickGuestBookReplyOk")
winMgr:getWindow('GuestBookReplyImage'):addChildWindow(mywindow)



----------------------------------------------------------------------
-- 방명록 댓글 입력 확인 취소 버튼
-----------------------------------------------------------------------
GuestBookReplyBtn =  { ["protecterr"]=0, "GuestBookReplyOk", "GuestBookReplyCancel"}							
GuestBookReplyTexX = {['err'] = 0, 651 , 732  }
GuestBookReplyPosX = {['err'] = 0, 120,  205}
GuestBookReply_BtnEvent = {["err"]=0,  "OnClickGuestBookReplyOk", "OnClickGuestBookReplyCancel"}
for i=1, #GuestBookReplyBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", GuestBookReplyBtn[i])
	mywindow:setTexture("Normal", "UIData/Profile001.tga", GuestBookReplyTexX[i], 324)
	mywindow:setTexture("Hover", "UIData/Profile001.tga", GuestBookReplyTexX[i], 351)
	mywindow:setTexture("Pushed", "UIData/Profile001.tga", GuestBookReplyTexX[i], 378)
	mywindow:setTexture("PushedOff", "UIData/Profile001.tga", GuestBookReplyTexX[i], 324)
	mywindow:setPosition(GuestBookReplyPosX[i],80 )
	mywindow:setSize(81, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", GuestBookReply_BtnEvent[i])
	winMgr:getWindow('GuestBookReplyImage'):addChildWindow(mywindow)
end

function OnClickGuestBookReplyOk()
	local ReplyMsg = winMgr:getWindow('GuestBookReplyEditBox'):getText()
	if ReplyMsg == "" then
		winMgr:getWindow('GuestBookReplyEditBox'):setText("")
		winMgr:getWindow('GuestBookReplyImage'):setVisible(false)
		return
	end
	WriteAddGuestBook(ReplyIndex, ReplyMsg)
	winMgr:getWindow('GuestBookReplyEditBox'):setText("")
	winMgr:getWindow('GuestBookReplyImage'):setVisible(false)
end

function OnClickGuestBookReplyCancel()
	winMgr:getWindow('GuestBookReplyEditBox'):setText("")
	winMgr:getWindow('GuestBookReplyImage'):setVisible(false)
end

----------------------------------------------------------------------
-- 친구추가 및 방명록 설정 버튼
-----------------------------------------------------------------------
ProfileChangeBtn =  { ["protecterr"]=0, "ProfileChangeAddFriend", "ProfileChangeSetting"}							
ProfileChangeTexX = {['err'] = 0, 513 , 595  }
ProfileChange_BtnEvent = {["err"]=0,  "OnClickProfileAddFriend", "OnClickProfileSettingInfo"}
for i=1, #ProfileChangeBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileChangeBtn[i])
	mywindow:setTexture("Normal", "UIData/Profile001.tga", ProfileChangeTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/Profile001.tga", ProfileChangeTexX[i], 64)
	mywindow:setTexture("Pushed", "UIData/Profile001.tga", ProfileChangeTexX[i], 64)
	mywindow:setTexture("PushedOff", "UIData/Profile001.tga", ProfileChangeTexX[i], 0)
	mywindow:setPosition(420, 156)
	mywindow:setSize(82, 64)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfileChange_BtnEvent[i])
	winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)
end
-- 프로필세팅
function OnClickProfileSettingInfo()
	root:addChildWindow(winMgr:getWindow('ProfileRepairImage'))
	winMgr:getWindow('ProfileRepairImage'):setVisible(true)
	winMgr:getWindow('ProfileRepairMenu_1'):setProperty("Selected", "true")
end
-- 친구추가
function OnClickProfileAddFriend()
	local AddFriendName = winMgr:getWindow('Profile_Character_Name'):getText()
	RequestNewFriend(AddFriendName);
	OnRequestFriendOK(AddFriendName)
end



----------------------------------------------------------------------
--프로필 종료 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ProfileCloseBtn")
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setPosition(480, 10)
mywindow:setSize(23, 23)
mywindow:setSubscribeEvent("Clicked", "OnClickProfileClose")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
--프로필 종료 버튼 함수
-----------------------------------------------------------------------
function OnClickProfileClose()
	winMgr:getWindow('ProfileBackImage'):setVisible(false)
	winMgr:getWindow('GuestBookReplyImage'):setVisible(false)
	winMgr:getWindow('ProfileHistoryBack'):setVisible(false)
end


---------------------------------------
---프로필 페이지 앞뒤버튼--
---------------------------------------
local ProfilePage_BtnName  = {["err"]=0, [0]="ProfilePage_LBtn", "ProfilePage_RBtn"}
local ProfilePage_BtnTexX  = {["err"]=0, [0]= 545, 582}
local ProfilePage_BtnPosX  = {["err"]=0, [0]= 195, 282}
local ProfilePage_BtnEvent = {["err"]=0, [0]= "ProfilePage_PrevPage", "ProfilePage_NextPage"}
for i=0, #ProfilePage_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfilePage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", ProfilePage_BtnTexX[i], 72)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", ProfilePage_BtnTexX[i], 96)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga",ProfilePage_BtnTexX[i], 120)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", ProfilePage_BtnTexX[i], 72)
	mywindow:setPosition(ProfilePage_BtnPosX[i], 625)
	mywindow:setSize(37, 24)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfilePage_BtnEvent[i])
	winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProfilePage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(217, 630)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_ProfilePage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)


---------------------------------------
---방명록 이전페이지 버튼--
---------------------------------------
function ProfilePage_PrevPage()
	DebugStr('ProfilePage_PrevPage()')
	if	g_ProfilePage  > 1 then
		GetProfileGuestBook(g_ProfilePage - 1)
	end
end

---------------------------------------
---방명록 다음페이지 버튼--
---------------------------------------
function ProfilePage_NextPage()
	DebugStr('ProfilePage_NextPage()')
	GetProfileGuestBook(g_ProfilePage + 1)
end
---------------------------------------
---방명록 페이지 설정--
---------------------------------------pbjn
function SettingGuestBookPage(GuestBookPage)
	--DebugStr('SettingGuestBookPage()')
	g_ProfilePage =	GuestBookPage
	--DebugStr('g_ProfilePage:'..g_ProfilePage)
	winMgr:getWindow('ProfilePage_PageText'):clearTextExtends()
	winMgr:getWindow('ProfilePage_PageText'):addTextExtends(tostring(g_ProfilePage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end

----------------------------------------------------------------------
-- 방명록 검색 에디트박스
----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Editbox", "SearchGuestBook")
mywindow:setText("")
mywindow:setPosition(205, 10)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(140, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("SearchGuestBook")):setMaxTextLength(15)
mywindow:setSubscribeEvent("TextAccepted", "OnClickSearchGuestBook")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
--방명록 검색 확인 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "SearchGuestBtn")
mywindow:setTexture("Normal",		"UIData/profile001.tga",	513, 256)
mywindow:setTexture("Hover",		"UIData/profile001.tga",	513, 278)
mywindow:setTexture("Pushed",		"UIData/profile001.tga",	513, 300)
mywindow:setTexture("PushedOff",	"UIData/profile001.tga",	513, 256)
mywindow:setTexture("Disabled",		"UIData/profile001.tga",	513, 322)
mywindow:setPosition(340, 10)
mywindow:setSize(69, 22)
mywindow:setSubscribeEvent("Clicked", "OnClickSearchGuestBook")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)


function OnClickSearchGuestBook()
	local SearchName = winMgr:getWindow('SearchGuestBook'):getText()
	if SearchName == "" then
		return
	end
	ClearGuestBook()
	winMgr:getWindow('ProfileRepairImage'):setVisible(false)
	GetProfileInfo(SearchName)
	winMgr:getWindow('SearchGuestBook'):setText("")
end

----------------------------------------------------------------------
--방명록 랜덤검색 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "RandomSearchGuestBtn")
mywindow:setTexture("Normal",		"UIData/profile001.tga",	582, 256)
mywindow:setTexture("Hover",		"UIData/profile001.tga",	582, 278)
mywindow:setTexture("Pushed",		"UIData/profile001.tga",	582, 300)
mywindow:setTexture("PushedOff",	"UIData/profile001.tga",	582, 256)
mywindow:setTexture("Disabled",		"UIData/profile001.tga",	582, 322)
mywindow:setPosition(410, 10)
mywindow:setSize(69, 22)
mywindow:setSubscribeEvent("Clicked", "OnClickRandomGuestBook")
winMgr:getWindow('ProfileBackImage'):addChildWindow(mywindow)

function OnClickRandomGuestBook()
	--DebugStr('OnClickRandomGuestBook()')
	ClearGuestBook()
	winMgr:getWindow('ProfileRepairImage'):setVisible(false)
	GetRandomProfileInfo()
end
----------------------------------------------------------------------
--프로필 수정 백그라운드 윈도우 생성
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ProfileRepairImage")
mywindow:setTexture("Enabled", "UIData/Profile002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Profile002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(300, 190);
mywindow:setSize(429, 442)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "ProfileRepair_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(400, 26)
winMgr:getWindow("ProfileRepairImage"):addChildWindow(mywindow)
RegistEscEventInfo("ProfileRepairImage", "OnClickProfileRepairClose")
----------------------------------------------------------------------
--프로필 수정 종료 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ProfileRepairCloseBtn")
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setPosition(400, 8)
mywindow:setSize(23, 23)
mywindow:setSubscribeEvent("Clicked", "OnClickProfileRepairClose")
winMgr:getWindow('ProfileRepairImage'):addChildWindow(mywindow)


----------------------------------------------------------------------
--프로필 수정 종료 버튼 함수
-----------------------------------------------------------------------
function OnClickProfileRepairClose()
	winMgr:getWindow('ProfileRepairImage'):setVisible(false)
end


----------------------------------------------------------------------
--프로필 수정 메뉴 라디오버튼
-----------------------------------------------------------------------
ProfileRepairMenuRadio =
{ ["protecterr"]=0, "ProfileRepairMenu_1", "ProfileRepairMenu_2", "ProfileRepairMenu_3"}

ProfileRepairMenuTexX	= {['err'] = 0, 429, 519, 429 }
ProfileRepairMenuTexY	= {['err'] = 0, 0, 0, 96 }
ProfileRepairMenuPosX   = {['err'] = 0, 11, 103, 195}  
  
for i=1, #ProfileRepairMenuRadio-1 do	 -- -1 이유 : 프로필에서 차단하기가 사라졌기때문에.
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",				ProfileRepairMenuRadio[i]);	
	mywindow:setTexture("Normal", "UIData/Profile002.tga",				ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]);
	mywindow:setTexture("Hover", "UIData/Profile002.tga",				ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+24);
	mywindow:setTexture("Pushed", "UIData/Profile002.tga",				ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+48);
	mywindow:setTexture("PushedOff", "UIData/Profile002.tga",			ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]);	
	mywindow:setTexture("SelectedNormal", "UIData/Profile002.tga",		ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+48);
	mywindow:setTexture("SelectedHover", "UIData/Profile002.tga",		ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+48);
	mywindow:setTexture("SelectedPushed", "UIData/Profile002.tga",		ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+48);
	mywindow:setTexture("SelectedPushedOff", "UIData/Profile002.tga",	ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+48);
	mywindow:setTexture("Disabled", "UIData/Profile002.tga",				ProfileRepairMenuTexX[i], ProfileRepairMenuTexY[i]+72);
	mywindow:setSize(90, 24);
	mywindow:setProperty("GroupID", 0512)
	mywindow:setPosition(ProfileRepairMenuPosX[i] , 44);
	mywindow:setUserString('ProfileMenuIndex', tostring(i))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "ProfileClickInfo");
	winMgr:getWindow('ProfileRepairImage'):addChildWindow(mywindow);
end


function ProfileClickInfo(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		
		local IndexCount = tonumber(local_window:getUserString('ProfileMenuIndex'))
		for i=1, #ProfileRepair_SubImage do
			winMgr:getWindow(ProfileRepair_SubImage[i]):setVisible(false)
		end
		DebugStr('IndexCount:'..IndexCount)
		winMgr:getWindow(ProfileRepair_SubImage[IndexCount]):setVisible(true)
		if IndexCount == 1 then -- 인포 호출
			CurrentProfileName = winMgr:getWindow('Profile_Character_Name'):getText()
			if CurrentProfileName ~= "" then
				GetProfileInfo(CurrentProfileName)
				winMgr:getWindow("ProfileRepair_Name"):activate()
				
			end
		elseif IndexCount == 2 then -- 시크릿 호출
			GetProfileOption()
		else  -- 블랙리스트 호출
			DebugStr("블랙리스트 탭 클릭")
			GetProfileBlackList(1) -- 인자 : 현재 페이지
		end
	end	
end
----------------------------------------------------------------------
--프로필 수정 Sub 윈도우 생성
-----------------------------------------------------------------------
ProfileRepair_SubImage  = {["err"]=0, "ProfileRepair_SubInfo", "ProfileRepair_SubSecret", "ProfileRepair_SubBlackList" }
ProfileRepair_SubImageTextY = {["err"]=0, 0, 328, 656}

for i=1, #ProfileRepair_SubImage do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", ProfileRepair_SubImage[i])
	mywindow:setTexture("Enabled", "UIData/profile002.tga", 615, ProfileRepair_SubImageTextY[i])
	mywindow:setTexture("Disabled", "UIData/profile002.tga", 615, ProfileRepair_SubImageTextY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, 70);
	mywindow:setSize(409, 328)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow)
	winMgr:getWindow('ProfileRepairImage'):addChildWindow(mywindow)
end


--------------------------------------------------------------------------------------------
--프로필 수정 에디트 박스
--------------------------------------------------------------------------------------------
ProfileRepair_EditBox  = {["err"]=0, "ProfileRepair_Name", "ProfileRepair_Age", "ProfileRepair_PhoneNumber" , "ProfileRepair_Messenger", "ProfileRepair_Home"}  
ProfileRepair_PosY	   = {["err"]=0, 55, 82, 141, 169, 198 }
ProfileRepair_MaxText  = {["err"]=0, 15, 3, 13, 20, 40}
ProfileRepair_Size     = {["err"]=0, 200, 200, 200, 200, 280 }
ProfileRepair_TabEvent = {['protecterr'] = 0, "NextRepair_Age", "NextRepair_PhoneNumber", "NextRepair_Messenger", "NextRepair_Home", 
										"NextRepair_Intro"}
for i=1, #ProfileRepair_EditBox do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", ProfileRepair_EditBox[i])
	mywindow:setText("")
	mywindow:setPosition( 93, ProfileRepair_PosY[i]-40)
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(ProfileRepair_Size[i], 23)
	if i == 2 then
		CEGUI.toEditbox(mywindow):setInputOnlyNumber()
	end
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	CEGUI.toEditbox(winMgr:getWindow(ProfileRepair_EditBox[i])):setMaxTextLength(ProfileRepair_MaxText[i])
	mywindow:setSubscribeEvent("TextAcceptedOnlyTab", ProfileRepair_TabEvent[i])
	winMgr:getWindow('ProfileRepair_SubInfo'):addChildWindow(mywindow)
end
--- TAB EVENT-----
function NextRepair_Age()
	winMgr:getWindow('ProfileRepair_Age'):activate()
end

function NextRepair_PhoneNumber()
	winMgr:getWindow('ProfileRepair_PhoneNumber'):activate()
end

function NextRepair_Messenger()
	winMgr:getWindow('ProfileRepair_Messenger'):activate()
end

function NextRepair_Home()
	winMgr:getWindow('ProfileRepair_Home'):activate()
end

function NextRepair_Intro()
	ProfileEditBoxClick()
end

--------------------------------------------------------------------------------------------
--프로필 수정 ( 남자 , 여자 선택)
--------------------------------------------------------------------------------------------
ProfileSexSelectbox = { ["protecterr"]=0, "SexSelectMan", "SexSelectWoman"}
ProfileSexSelectPosX = {["err"]=0, 90, 160 }


for i=1, #ProfileSexSelectbox do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", ProfileSexSelectbox[i])
	mywindow:setTexture("Normal", "UIData/Profile002.tga", 1002, 984)
	mywindow:setTexture("Hover", "UIData/Profile002.tga", 1002, 984)
	mywindow:setTexture("Pushed", "UIData/Profile002.tga", 980, 984)
	mywindow:setTexture("PushedOff", "UIData/Profile002.tga", 980, 984)
	
	mywindow:setTexture("SelectedNormal", "UIData/Profile002.tga", 980, 984)
	mywindow:setTexture("SelectedHover", "UIData/Profile002.tga", 980, 984)
	mywindow:setTexture("SelectedPushed", "UIData/Profile002.tga", 980, 984)
	mywindow:setTexture("SelectedPushedOff", "UIData/Profile002.tga", 980, 984)
	
	mywindow:setPosition(ProfileSexSelectPosX[i], 74)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("SelectStateChanged", "OnGoto_PhoneNumber");
	winMgr:getWindow('ProfileRepair_SubInfo'):addChildWindow( mywindow);
end

function OnGoto_PhoneNumber()
	winMgr:getWindow('ProfileRepair_PhoneNumber'):activate()
end

--------------------------------------------------------------------------------------------
--프로필 체크박스
--------------------------------------------------------------------------------------------
ProfileRepairCheck =
{ ["protecterr"]=0, "ProfileRepairNameCheck_1",	 		"ProfileRepairNameCheck_2",			"ProfileRepairNameCheck_3" ,
					"ProfileRepairAgeCheck_1",			"ProfileRepairAgeCheck_2",			"ProfileRepairAgeCheck_3"	,
					"ProfileRepairSexCheck_1",			"ProfileRepairSexCheck_2",			"ProfileRepairSexCheck_3"	,
					"ProfileRepairPhoneCheck_1",		"ProfileRepairPhoneCheck_2",		"ProfileRepairPhoneCheck_3" ,
					"ProfileRepairMessengerCheck_1",	"ProfileRepairMessengerCheck_2",	"ProfileRepairMessengerCheck_3" ,
					"ProfileRepairHomeCheck_1",			"ProfileRepairHomeCheck_2",			"ProfileRepairHomeCheck_3" ,
					"ProfileRepairInputCheck_1",		"ProfileRepairInputCheck_2",		"ProfileRepairInputCheck_3" ,
					"ProfileRepairShowCheck_1",			"ProfileRepairShowCheck_2",			"ProfileRepairShowCheck_3" 
}
ProfileRepairPosX = {["err"]=0, 140, 230, 330, 140, 230, 330, 140, 230, 330, 140, 230, 330, 140, 230, 330, 140, 230, 330 , 140,230, 330 , 140, 230, 330}
ProfileRepairPosY = {["err"]=0, 47, 47, 47,  75,  75,  75,  103,  103,  103,  131,  131,  131,  159,  159, 159 , 187, 187, 187 , 215, 215, 215 , 241, 241, 241}

for i=1, #ProfileRepairCheck do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", ProfileRepairCheck[i])
	mywindow:setTexture("Normal", "UIData/profile002.tga", 1002, 984)
	mywindow:setTexture("Hover", "UIData/profile002.tga", 1002, 984)
	mywindow:setTexture("Pushed", "UIData/profile002.tga", 980,984)
	mywindow:setTexture("PushedOff", "UIDataprofile002.tga", 980,984)
	
	mywindow:setTexture("SelectedNormal", "UIData/profile002.tga", 980,984)
	mywindow:setTexture("SelectedHover", "UIData/profile002.tga", 980,984)
	mywindow:setTexture("SelectedPushed", "UIData/profile002.tga", 980,984)
	mywindow:setTexture("SelectedPushedOff", "UIData/profile002.tga", 980,984)
	
	mywindow:setPosition(ProfileRepairPosX[i]-40, ProfileRepairPosY[i]-30)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	
	if i < 4  then
		mywindow:setProperty("GroupID", 4911)
	elseif i < 7 then
		mywindow:setProperty("GroupID", 4912)
	elseif i < 10 then
		mywindow:setProperty("GroupID", 4913)
	elseif i < 13 then
		mywindow:setProperty("GroupID", 4914)
	elseif i < 16 then
		mywindow:setProperty("GroupID", 4915)
	elseif i < 19 then
		mywindow:setProperty("GroupID", 4916)
	elseif i < 22 then
		mywindow:setProperty("GroupID", 4917)
	else
		mywindow:setProperty("GroupID", 4918)
	end
	
	winMgr:getWindow('ProfileRepair_SubSecret'):addChildWindow( mywindow);
	
end



--------------------------------------------------------------------
-- 프로필 자기소개 입력 에디트 박스
--------------------------------------------------------------------

ProfileWriteBox =
{ ["protecterr"]=0, "ProfileWrite_1", "ProfileWrite_2", "ProfileWrite_3"}

ProfileEditEvent= 
{['protecterr'] = 0, "NextProfileEdit1", "NextProfileEdit2", "NextProfileEdit3"}

ProfileWriteBoxPosX	= {['err'] = 0, 20,20,20}
ProfileWriteBoxPosY	= {['err'] = 0, 242, 263,284}
ProfileWriteSizeX     = {['err'] = 0, 360, 360 ,360}
ProfileWriteSizeY     = {['err'] = 0, 23, 23, 23}
ProfileSetMatText     = {['err'] = 0, 160, 160, 170 }
for i=1 , #ProfileWriteBox do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", ProfileWriteBox[i])
	mywindow:setText("")
	mywindow:setPosition(ProfileWriteBoxPosX[i], ProfileWriteBoxPosY[i]-30)
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(ProfileWriteSizeX[i], ProfileWriteSizeY[i])
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("MouseButtonDown", "ProfileEditBoxClick")
	CEGUI.toEditbox(winMgr:getWindow(ProfileWriteBox[i])):setMaxTextLength(ProfileSetMatText[i])
	CEGUI.toEditbox(winMgr:getWindow(ProfileWriteBox[i])):subscribeEvent("EditboxFull", "ProfileEditFull")
	CEGUI.toEditbox(winMgr:getWindow(ProfileWriteBox[i])):subscribeEvent("TextAccepted", ProfileEditEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(ProfileWriteBox[i])):subscribeEvent("TextAcceptedBack", "ProfileEditEventBack")
	mywindow:setSubscribeEvent("TextAcceptedOnlyTab", "GotoRepiar_Name")
	winMgr:getWindow('ProfileRepair_SubInfo'):addChildWindow(mywindow)
end
    winMgr:getWindow("ProfileWrite_1"):activate()
   
 function GotoRepiar_Name()
	winMgr:getWindow('ProfileRepair_Name'):activate()
 end
--------------------------------------------
-- 자기 소개 줄바꾸기
--------------------------------------------
function ProfileEditFull(args)

	for i = 1, 2 do
		if winMgr:getWindow(ProfileWriteBox[i]):isActive() then
			winMgr:getWindow(ProfileWriteBox[i]):deactivate();
			winMgr:getWindow(ProfileWriteBox[i + 1]):activate();
			winMgr:getWindow(ProfileWriteBox[i + 1]):setText("")
			return;
		end
	end
end   

function ProfileEditBoxClick()
	DebugStr('ProfileEditBoxClick()')
	for i=1 , #ProfileWriteBox do
	   if winMgr:getWindow(ProfileWriteBox[4-i]):getText() ~= ""  then
			winMgr:getWindow(ProfileWriteBox[4-i]):activate();
			return
	   end	   
	end
	winMgr:getWindow(ProfileWriteBox[1]):activate();
end

--------------------------------------------
-- 자기 소개 지울때
--------------------------------------------
function ProfileEditEventBack(args)

	for i = 2, 3 do
	    local Debugwritebox =winMgr:getWindow(ProfileWriteBox[i]):getText()
	    DebugStr('Debugwritebox:'..Debugwritebox..i)
		if winMgr:getWindow(ProfileWriteBox[i]):isActive() and winMgr:getWindow(ProfileWriteBox[i]):getText()==""  then
			    winMgr:getWindow(ProfileWriteBox[i]):setEnabled(false);
			    winMgr:getWindow(ProfileWriteBox[i-1]):setEnabled(true);
				winMgr:getWindow(ProfileWriteBox[i-1]):activate();
				winMgr:getWindow(ProfileWriteBox[i]):deactivate();
				return;
		end
	end
end   

------------------------------------
--자기소개 엔터 이벤트
------------------------------------

function NextProfileEdit1()
	winMgr:getWindow("ProfileWrite_1"):setEnabled(false);
	winMgr:getWindow("ProfileWrite_1"):deactivate();
	winMgr:getWindow("ProfileWrite_2"):setEnabled(true);
	winMgr:getWindow("ProfileWrite_2"):setText("")
	winMgr:getWindow("ProfileWrite_2"):activate()
end

function NextProfileEdit2()
	winMgr:getWindow("ProfileWrite_2"):setEnabled(false);
	winMgr:getWindow("ProfileWrite_2"):deactivate();
	winMgr:getWindow("ProfileWrite_3"):setEnabled(true);
	winMgr:getWindow("ProfileWrite_3"):setText("")
	winMgr:getWindow("ProfileWrite_3"):activate()
end

function NextProfileEdit3()
	winMgr:getWindow("ProfileWrite_3"):activate()
end
-------------------------------------------------------------------------------------
-- 방명록 블랙리스트 라디오버튼
-------------------------------------------------------------------------------------
BlackList_Radio = 
{ ["protecterr"]=0, "BlackList_Radio1", "BlackList_Radio2", "BlackList_Radio3" , "BlackList_Radio4", "BlackList_Radio5",
					"BlackList_Radio6", "BlackList_Radio7", "BlackList_Radio8" , "BlackList_Radio9", "BlackList_Radio10"}
	

for i=1, #BlackList_Radio do
	mywindow = winMgr:createWindow("TaharezLook/Button",	BlackList_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		522, 415)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		522, 443)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	522, 443)
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			522, 471);
	mywindow:subscribeEvent("Clicked", "OnSelectedBlackList");
	mywindow:setSize(170, 23)
	mywindow:setPosition(220, 43+23*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ProfileRepair_SubBlackList'):addChildWindow(mywindow)
	
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", BlackList_Radio[i]..'BlackListText')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(85, 2)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setEnabled(false)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end
-------------------------------------------------------------------------------------
-- 블랙리스트 라디오 클릭시 ( 왼편의 에디트박스에 아이디를 적어준다 )
-------------------------------------------------------------------------------------
function OnSelectedBlackList(args)
	DebugStr('OnSelectedBlackList') 
	local local_window = CEGUI.toWindowEventArgs(args).window;
		local win_name = local_window:getName();
		local ListName = winMgr:getWindow(win_name..'BlackListText'):getText()
		if ListName ~= "" then
			winMgr:getWindow('AddBlackListEditBox'):setText(ListName)
		end
	
end

-------------------------------------------------------------------------------------
-- 방명록 블랙리스트 추가 입력에디트 박스
-------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "AddBlackListEditBox")
mywindow:setText("")
mywindow:setPosition(23, 83)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(170, 23)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(true)
CEGUI.toEditbox(winMgr:getWindow('AddBlackListEditBox')):setMaxTextLength(12)
winMgr:getWindow('ProfileRepair_SubBlackList'):addChildWindow(mywindow)


-------------------------------------------------------------------------------------
-- 방명록 블랙리스트 추가 등록 및 삭제
-------------------------------------------------------------------------------------
BlackListAddDeleteBtn	 = {["err"]=0, "BlackListAddBtn", "BlackListDeleteBtn" }
BlackListAddDeleteEvent  = {["err"]=0, "OnClickBlackListAdd" ,	"OnClickBlackListDelete"}					 
BlackListAddDelete_ButtonTexX   = {["err"]=0, 429, 500 }
BlackListAddDelete_ButtonPosX   = {["err"]=0, 30, 105 }

for i=1, #BlackListAddDeleteBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", BlackListAddDeleteBtn[i])
	mywindow:setTexture("Normal", "UIData/Profile002.tga", BlackListAddDelete_ButtonTexX[i], 216)
	mywindow:setTexture("Hover", "UIData/Profile002.tga", BlackListAddDelete_ButtonTexX[i], 240)
	mywindow:setTexture("Pushed", "UIData/Profile002.tga", BlackListAddDelete_ButtonTexX[i], 264)
	mywindow:setTexture("PushedOff", "UIData/Profile002.tga", BlackListAddDelete_ButtonTexX[i], 216)
	mywindow:setPosition(BlackListAddDelete_ButtonPosX[i], 110)
	mywindow:setSize(71, 24)
	mywindow:setSubscribeEvent("Clicked", BlackListAddDeleteEvent[i])
	winMgr:getWindow('ProfileRepair_SubBlackList'):addChildWindow(mywindow)
end
-------------------------------------------------------------------------------------
-- 방명록 블랙리스트 추가 등록
-------------------------------------------------------------------------------------
function OnClickBlackListAdd()
	local BlackListName = winMgr:getWindow('AddBlackListEditBox'):getText()
	if BlackListName ~= "" then
		SetProfileBlackList(BlackListName)
		winMgr:getWindow('AddBlackListEditBox'):setText("")
	end
end
-------------------------------------------------------------------------------------
-- 방명록 블랙리스트 삭제
-------------------------------------------------------------------------------------
function OnClickBlackListDelete()
	local BlackListName = winMgr:getWindow('AddBlackListEditBox'):getText()
	if BlackListName ~= "" then
		DeleteProfileBlackList(BlackListName, g_ProfileBlackPage )
		winMgr:getWindow('AddBlackListEditBox'):setText("")
	end
end
---------------------------------------
---블랙리스트 페이지 앞뒤버튼--
---------------------------------------
local ProfileBlackPage_BtnName  = {["err"]=0, [0]="ProfileBlackPage_LBtn", "ProfileBlackPage_RBtn"}
local ProfileBlackPage_BtnTexX  = {["err"]=0, [0]= 374, 392}
local ProfileBlackPage_BtnPosX  = {["err"]=0, [0]= 255, 340}
local ProfileBlackPage_BtnEvent = {["err"]=0, [0]= "ProfileBlackPage_PrevPage", "ProfileBlackPage_NextPage"}
for i=0, #ProfileBlackPage_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileBlackPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", ProfileBlackPage_BtnTexX[i], 679)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", ProfileBlackPage_BtnTexX[i], 697)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",ProfileBlackPage_BtnTexX[i], 715)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", ProfileBlackPage_BtnTexX[i], 679)
	mywindow:setPosition(ProfileBlackPage_BtnPosX[i],283)
	mywindow:setSize(18, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfileBlackPage_BtnEvent[i])
	winMgr:getWindow('ProfileRepair_SubBlackList'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProfileBlackPage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(265, 285)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_ProfileBlackPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ProfileRepair_SubBlackList'):addChildWindow(mywindow)


---------------------------------------
---블랙리스트 이전페이지 버튼--
---------------------------------------
function ProfileBlackPage_PrevPage()
	DebugStr('ProfileBlackPage_PrevPage()')
	if	g_ProfileBlackPage  > 1 then
		GetProfileBlackList(g_ProfileBlackPage-1)
	end
end

---------------------------------------
---블랙리스트 다음페이지 버튼--
---------------------------------------
function ProfileBlackPage_NextPage()
	DebugStr('ProfileBlackPage_NextPage()')
	GetProfileBlackList(g_ProfileBlackPage+1)
end
---------------------------------------
---블랙리스트 페이지 세팅--
---------------------------------------
function SettingBlackListPage(BlackListPage)
	g_ProfileBlackPage = BlackListPage
	winMgr:getWindow('ProfileBlackPage_PageText'):clearTextExtends()
	winMgr:getWindow('ProfileBlackPage_PageText'):addTextExtends(tostring(g_ProfileBlackPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end

------------------------------------------------------------------------------------
-- 방명록 수정사항 적용버튼 3개
------------------------------------------------------------------------------------
ProfileRepair_Accept = { ["protecterr"]=0, "ProfileRepair_AcceptInfo", "ProfileRepair_AcceptSecret"}
ProfileAccept_BtnEvent = {["err"]=0,  "OnclickAcceptInfo", "OnclickAcceptSecret"}

for i=1 , #ProfileRepair_Accept do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileRepair_Accept[i])
	mywindow:setTexture("Normal", "UIData/Profile002.tga", 429, 312)
	mywindow:setTexture("Hover", "UIData/Profile002.tga", 429, 344)
	mywindow:setTexture("Pushed", "UIData/Profile002.tga", 429, 376)
	mywindow:setTexture("PushedOff", "UIData/Profile002.tga",429, 312)
	mywindow:setPosition(160, 285)
	mywindow:setSize(81, 32)
	mywindow:setSubscribeEvent("Clicked", ProfileAccept_BtnEvent[i])
end

winMgr:getWindow('ProfileRepair_SubInfo'):addChildWindow(winMgr:getWindow('ProfileRepair_AcceptInfo'))
winMgr:getWindow('ProfileRepair_SubSecret'):addChildWindow(winMgr:getWindow('ProfileRepair_AcceptSecret'))


------------------------------------------------------------------------------------
-- 개인정보 수정하기 호출
------------------------------------------------------------------------------------
function OnclickAcceptInfo()
	
	local InfoName = winMgr:getWindow('ProfileRepair_Name'):getText()
	local InfoAge = winMgr:getWindow('ProfileRepair_Age'):getText()
	local InfoPhoneNumber = winMgr:getWindow('ProfileRepair_PhoneNumber'):getText()
	local InfoMessenger = winMgr:getWindow('ProfileRepair_Messenger'):getText()
	local InfoHome = winMgr:getWindow('ProfileRepair_Home'):getText()
	local InfoSex = 0
	if CEGUI.toRadioButton(winMgr:getWindow('SexSelectWoman')):isSelected() then
		InfoSex = 1
	end

	local InfoIntroduce1 = winMgr:getWindow('ProfileWrite_1'):getText()	
	local InfoIntroduce2 = winMgr:getWindow('ProfileWrite_2'):getText()
	local InfoIntroduce3 = winMgr:getWindow('ProfileWrite_3'):getText()
	local InfoIntroduce = InfoIntroduce1.."\\n"..InfoIntroduce2.."\\n"..InfoIntroduce3
	
	RegistProfileInfo(InfoName, InfoAge, InfoPhoneNumber, InfoMessenger, InfoHome, InfoSex, InfoIntroduce1, InfoIntroduce2, InfoIntroduce3 )
	
end

InfoCheckTable = {["err"]=0,  0,0,0,0,0,0,0,0}

------------------------------------------------------------------------------------
-- 공개 친구공개 비공개 수정사항 설정
------------------------------------------------------------------------------------
function OnclickAcceptSecret()
   local CheckTableindex = 1
   for i = 1 , #ProfileRepairCheck do
		if CEGUI.toRadioButton(winMgr:getWindow(ProfileRepairCheck[i])):isSelected() then
			local value = (i-1) % 3
			InfoCheckTable[CheckTableindex] = value
			DebugStr('CheckTableindex:'..InfoCheckTable[CheckTableindex])
			CheckTableindex = CheckTableindex + 1
		end
   end
   
   SetProfileOption(InfoCheckTable[1], InfoCheckTable[2], InfoCheckTable[3] , InfoCheckTable[4] , InfoCheckTable[5], InfoCheckTable[6], InfoCheckTable[7], InfoCheckTable[8])
end

------------------------------------------------------------------------------------
-- 프로파일 업데이트
------------------------------------------------------------------------------------
function Update_ProfileInfo(InfoName, InfoAge, InfoPhone, InfoMessenger, InfoHome, 
							InfoSex, InfoIndroduce1,InfoIndroduce2, InfoIndroduce3, InfoImageKey, InfoCharacterName , InfoIsMyCharacter, TodayCount, TotalCount)
	
	---- 내 방명록일시 (삭제, 댓글, 댓글삭제를 표시해준다)
	
	winMgr:getWindow("ProfileBackImage"):setVisible(true)
	--DebugStr('Update_ProfileInfo')
	--DebugStr('InfoCharacterName:'..InfoCharacterName)
	--DebugStr('InfoName:'..InfoName)
	IsMyProfile = InfoIsMyCharacter
	winMgr:getWindow('ProfileHistoryBack'):setVisible(true)
	GetProfileVisitedList(g_ProfileHistory1Page)
	GetProfileVisitList(g_ProfileHistory2Page)
	GetProfileLatestGuestBookList(g_ProfileHistory3Page)
	if InfoIsMyCharacter == 1 then
		winMgr:getWindow('ProfileChangeAddFriend'):setVisible(false)
		winMgr:getWindow('ProfileChangeSetting'):setVisible(true)
	else
		winMgr:getWindow('ProfileChangeSetting'):setVisible(false)
		winMgr:getWindow('ProfileChangeAddFriend'):setVisible(true)
	end
	
	---- 기본 정보 업데이트
	winMgr:getWindow('Profile_Character_Name'):setText(InfoCharacterName)
	winMgr:getWindow('Profile_Secret_Name'):setText(InfoName)

	winMgr:getWindow('Profile_TodayCount'):setText("Today: "..TodayCount)
	winMgr:getWindow('Profile_TotalCount'):setText("Total: "..TotalCount)
	
	if InfoAge < 1000 then
		winMgr:getWindow('Profile_Secret_Age'):setText(InfoAge)
	else
		winMgr:getWindow('Profile_Secret_Age'):setText(String_Secret)
	end
	
	if InfoSex == 0 then
		winMgr:getWindow('Profile_Secret_Sex'):setText(PreCreateString_2404)	--GetSStringInfo(LUA_PROFILE_MAN)
		winMgr:getWindow('SexSelectMan'):setProperty('Selected', 'True');
	elseif InfoSex == 1 then
		winMgr:getWindow('Profile_Secret_Sex'):setText(PreCreateString_2405)	--GetSStringInfo(LAN_PROFILE_WOMAN)
	else
		winMgr:getWindow('Profile_Secret_Sex'):setText(String_Secret)
	end
	
	winMgr:getWindow('Profile_Secret_PhoneNumber'):setText(InfoPhone)
	winMgr:getWindow('Profile_Secret_Messeager'):setText(InfoMessenger)
	winMgr:getWindow('Profile_Secret_Home'):setText(InfoHome)
	winMgr:getWindow('Profile_Indroduce'):clearTextExtends()
	winMgr:getWindow('Profile_Indroduce'):addTextExtends(InfoIndroduce1..'\n', g_STRING_FONT_GULIMCHE, 11,    255,255,255,255,     0,     0,0,0,255);
	winMgr:getWindow('Profile_Indroduce'):addTextExtends(InfoIndroduce2..'\n', g_STRING_FONT_GULIMCHE, 11,    255,255,255,255,     0,     0,0,0,255);
	winMgr:getWindow('Profile_Indroduce'):addTextExtends(InfoIndroduce3, g_STRING_FONT_GULIMCHE, 11,    255,255,255,255,     0,     0,0,0,255);
	
	-----  프로필 이미지 업데이트
	if InfoImageKey > 0 then
		winMgr:getWindow('ProfileInfoEmblem'):setTexture('Enabled',  "UIData/Profile/"..InfoImageKey..".tga", 0, 0)
		winMgr:getWindow('ProfileInfoEmblem'):setTexture('Disabled', "UIData/Profile/"..InfoImageKey..".tga", 0, 0)
	else
		winMgr:getWindow('ProfileInfoEmblem'):setTexture('Enabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
		winMgr:getWindow('ProfileInfoEmblem'):setTexture('Disabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
	end
	
	--------개인정보 수정창이 켜있을시 ------
	if winMgr:getWindow('ProfileRepairImage'):isVisible() then
		winMgr:getWindow('ProfileRepair_Name'):setText(InfoName)
		winMgr:getWindow('ProfileRepair_Age'):setText(InfoAge)
		winMgr:getWindow('ProfileRepair_PhoneNumber'):setText(InfoPhone)
		winMgr:getWindow('ProfileRepair_Messenger'):setText(InfoMessenger)
		winMgr:getWindow('ProfileRepair_Home'):setText(InfoHome)
		if InfoSex == 0 then
			winMgr:getWindow('SexSelectMan'):setProperty('Selected', 'True');
		else
			winMgr:getWindow('SexSelectWoman'):setProperty('Selected', 'True');
		end
		winMgr:getWindow('ProfileWrite_1'):setText(InfoIndroduce1)
		winMgr:getWindow('ProfileWrite_2'):setText(InfoIndroduce2)
		winMgr:getWindow('ProfileWrite_3'):setText(InfoIndroduce3)
		--winMgr:getWindow('ProfileRepair_Name'):activate()
		return
	end
	root:addChildWindow(winMgr:getWindow("ProfileBackImage"))
	root:addChildWindow(winMgr:getWindow("ProfileHistoryBack"))
	g_ProfilePage = 1
	GetProfileGuestBook(g_ProfilePage)
	--DebugStr('Update_ProfileInfo_End')
end

------------------------------------------------------------------------------------
-- 방명록 공개, 비공개 설정
------------------------------------------------------------------------------------
function Update_ProfileOption(NameCheck, AgeCheck, SexCheck, PhoneCheck, MessengerCheck, HomeCheck, InputCheck, ShowCheck)
	--DebugStr('SexCheck:'..SexCheck)
	winMgr:getWindow(ProfileRepairCheck[NameCheck+1]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[AgeCheck+4]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[SexCheck+7]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[PhoneCheck+10]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[MessengerCheck+13]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[HomeCheck+16]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[InputCheck+19]):setProperty('Selected', 'True');
	winMgr:getWindow(ProfileRepairCheck[ShowCheck+22]):setProperty('Selected', 'True');
end

------------------------------------------------------------------------------------
-- 방명록 업데이트
------------------------------------------------------------------------------------
function Update_ProfileGuestBook(Index , BookIndex, GuestName, GuestMsg, AddMsg, BookTime, ImageKey)

	winMgr:getWindow(GuestBook_Radio[Index+1]):setEnabled(true)
	winMgr:getWindow(GuestBook_Radio[Index+1]):setVisible(true)
	
	for i=1, #GuestBookText do	
		winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[i]):clearTextExtends()	
	end
	
	if AddMsg ~= "" then
		winMgr:getWindow(GuestBook_Radio[Index+1]..'AddMsgBackImage'):setVisible(true)
	end
	winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileMoveBtn'):setVisible(true)
	if IsMyProfile == 1 then
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileDelBtn'):setVisible(true)
		if AddMsg ~= "" then
			winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileSubDelBtn'):setVisible(true)
		end
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileRepBtn'):setVisible(true)
	else
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileDelBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileSubDelBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileRepBtn'):setVisible(false)
	end
	
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[1]):addTextExtends(GuestName, g_STRING_FONT_GULIMCHE, 112,    255,198,0,255,     0,     0,0,0,255)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[1]):setText(GuestName)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[2]):addTextExtends(BookTime, g_STRING_FONT_GULIMCHE, 112,    255,198,0,255,     0,     0,0,0,255)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[4]):addTextExtends(GuestMsg, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[5]):addTextExtends(AddMsg, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[5]):setText(AddMsg)
	winMgr:getWindow(GuestBook_Radio[Index+1]..GuestBookText[6]):setText(BookIndex)
	
	if ImageKey > 0 then
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileImage'):setTexture('Enabled',  "UIData/Profile/"..ImageKey..".tga", 0, 0)
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileImage'):setTexture('Disabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
	else
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileImage'):setTexture('Enabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
		winMgr:getWindow(GuestBook_Radio[Index+1]..'ProfileImage'):setTexture('Disabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
	end
end

function Update_ProfileBlackList(Index, BlacklistName)
	winMgr:getWindow(BlackList_Radio[Index+1]..'BlackListText'):setEnabled(true)
	winMgr:getWindow(BlackList_Radio[Index+1]..'BlackListText'):setText(BlacklistName)
	winMgr:getWindow(BlackList_Radio[Index+1]..'BlackListText'):clearTextExtends()
	winMgr:getWindow(BlackList_Radio[Index+1]..'BlackListText'):addTextExtends(BlacklistName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
end
------------------------------------------------------------------------------------
-- 방명록 리셋
------------------------------------------------------------------------------------
function ClearGuestBook()
	
	for i= 1, #GuestBook_Radio do
		for j=1, #GuestBookText do	
			winMgr:getWindow(GuestBook_Radio[i]..GuestBookText[j]):clearTextExtends()	
			winMgr:getWindow(GuestBook_Radio[i]..GuestBookText[j]):setText("")
		end
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileDelBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileSubDelBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[i]..'AddMsgBackImage'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileRepBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[i]..'ProfileMoveBtn'):setVisible(false)
		winMgr:getWindow(GuestBook_Radio[i]):setEnabled(false)
		winMgr:getWindow(GuestBook_Radio[i]):setVisible(false)
		
	end
end

------------------------------------------------------------------------------------
-- 프로필 리셋
------------------------------------------------------------------------------------
function ClearProfile()
	winMgr:getWindow('Profile_Character_Name'):setText("")
	winMgr:getWindow('Profile_Secret_Name'):setText("")
	winMgr:getWindow('Profile_Secret_Age'):setText("")
	winMgr:getWindow('Profile_Secret_Sex'):setText("")
	winMgr:getWindow('Profile_Secret_PhoneNumber'):setText("")
	winMgr:getWindow('Profile_Secret_Messeager'):setText("")
	winMgr:getWindow('Profile_Secret_Home'):setText("")
	winMgr:getWindow('Profile_TodayCount'):setText("")
	winMgr:getWindow('Profile_TotalCount'):setText("")
	winMgr:getWindow('Profile_Indroduce'):clearTextExtends()
	winMgr:getWindow('ProfileInfoEmblem'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	winMgr:getWindow('ProfileInfoEmblem'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
end
------------------------------------------------------------------------------------
-- 블랙리스트 리셋
------------------------------------------------------------------------------------
function ClearBlackList()
	for i= 1, #BlackList_Radio do
		winMgr:getWindow(BlackList_Radio[i]..'BlackListText'):clearTextExtends()	
		winMgr:getWindow(BlackList_Radio[i]..'BlackListText'):setEnabled(false)
		winMgr:getWindow(BlackList_Radio[i]..'BlackListText'):setText("")
	end
end


------------------------------------------------
-- 프로필 등록 아이템 
------------------------------------------------
local CheckProfileInCheck = false

-- 프로필 등록 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeProfileAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


--  프로필 등록 메인이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeProfileMain")
mywindow:setTexture("Enabled", "UIData/profile001.tga", 677, 0)
mywindow:setTexture("Disabled", "UIData/profile001.tga", 677, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 153) / 2)
mywindow:setSize(340, 153)
mywindow:setVisible(true)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChangeProfileAlpha"):addChildWindow(mywindow)


--  프로필 등록 사진이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeProfileImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(20, 52)
mywindow:setSize(64, 64)
mywindow:setEnabled(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChangeProfileMain"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/Editbox", "ChangeProfileEdit")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText("basic.tga")
mywindow:setPosition(100, 51)
mywindow:setSize(180, 25)
mywindow:setAlphaWithChild(0)
mywindow:setEnabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(20)
winMgr:getWindow("ChangeProfileMain"):addChildWindow(mywindow)



-- 불러오기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ChangeProfileButton")
mywindow:setTexture("Normal", "UIData/profile001.tga", 677, 168)
mywindow:setTexture("Hover", "UIData/profile001.tga", 677, 190)
mywindow:setTexture("Pushed", "UIData/profile001.tga", 677, 212)
mywindow:setTexture("Disabled", "UIData/profile001.tga", 677, 234)
mywindow:setPosition(265, 50)
mywindow:setSize(69, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ChangeProfileButtonEvent")
winMgr:getWindow("ChangeProfileMain"):addChildWindow(mywindow)


-- 바꾸기 버튼
tProfileButtonName  = {['err'] = 0, "ChangeProfileRegistButton", "ChangeProfileCancelButton"}
tProfileButtonEvent = {['err'] = 0, "ChangeProfileRegistEvent",  "ChangeProfileCancelEvent"}

for i = 1, #tProfileButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tProfileButtonName[i])
	mywindow:setTexture("Normal", "UIData/profile001.tga", 651 + (i-1)*81, 324)
	mywindow:setTexture("Hover", "UIData/profile001.tga", 651 + (i-1)*81, 351)
	mywindow:setTexture("Pushed", "UIData/profile001.tga", 651 + (i-1)*81, 378)
	mywindow:setTexture("Disabled", "UIData/profile001.tga", 651 + (i-1)*81, 405)
	mywindow:setPosition(165 + (i-1)*85, 123)
	mywindow:setSize(81, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tProfileButtonEvent[i])
	winMgr:getWindow("ChangeProfileMain"):addChildWindow(mywindow)
end


-- 엠블럼 바꾸는 창을 띄워준다.
function ShowChangeProfileWin()
	root:addChildWindow(winMgr:getWindow("ChangeProfileAlpha"))
	winMgr:getWindow("ChangeProfileAlpha"):setVisible(true)
	winMgr:getWindow("ChangeProfileImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeProfileImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeProfileEdit"):setText("")
	CheckProfileInCheck = false
end


-- 프로필 아이템 사용 이벤트
function ChangeProfileRegistEvent(args)
	if CheckProfileInCheck == false then
		ShowNotifyOKMessage_Lua(PreCreateString_2400)	--GetSStringInfo(LAN_REGIST_PROFILE_IMAGE)
		return
	end
	
	winMgr:getWindow("ChangeProfileImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeProfileImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeProfileAlpha"):setVisible(false)
	local ListIndex	 =  GetSelectedItemIndex()
	RegistProfileImage(ListIndex)
	
	--[[
	local	PAGE_MAXITEM			= 8	
	for i = 1, PAGE_MAXITEM do 
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			local ListIndex		= 	tonumber(winMgr:getWindow("MyRoom_Item"..i):getUserString('ListIndex'))
			RegistProfileImage(ListIndex)
			break
		end
	end
	--]]
	

end

-- 취소 버튼 이벤트
function ChangeProfileCancelEvent(arge)
	winMgr:getWindow("ChangeProfileImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeProfileAlpha"):setVisible(false)
end


-- 찾아보기 버튼 이벤트
function ChangeProfileButtonEvent(args)
	
	local Edit = winMgr:getWindow("ChangeProfileEdit"):getText()
	ProfileChangeImage(Edit)
	
end


-- 엠블럼이미지를 셋팅한다.
function SetProfileImage(ImageName)
	CheckProfileInCheck = true
	winMgr:getWindow("ChangeProfileImg"):setTexture("Enabled", ImageName, 0, 0)
	winMgr:getWindow("ChangeProfileImg"):setTexture("Disabled", ImageName, 0, 0)
end


function OnProfileEffect()
	Mainbar_ActiveEffect(BAR_BUTTONTYPE_PROFILE)
end


------------------------------------------------------------------------------------
--  Profile History BackImage ( 방문기록 백판)
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ProfileHistoryBack');
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setPosition(715, 72);
mywindow:setSize(218, 582);
--mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Titlebar", "ProfileHistory_titlebar")
mywindow:setAlwaysOnTop(true)
mywindow:setPosition(3, 1)
mywindow:setSize(215, 20)
winMgr:getWindow("ProfileHistoryBack"):addChildWindow(mywindow)



------------------------------------------------------------------------------------
--  Profile History Visitor ( 내프로필에 방문한 사람기록)
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ProfileHistory1');
mywindow:setTexture('Enabled', 'UIData/profile001.tga', 513, 569);
mywindow:setTexture('Disabled', 'UIData/profile001.tga', 513, 569);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setPosition(0, 0);
mywindow:setSize(218, 194);
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ProfileHistoryBack'):addChildWindow(mywindow)

------------------------------------------------------------------------------------
--  Profile History  ( 내가 방문했던 기록)
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ProfileHistory2');
mywindow:setTexture('Enabled', 'UIData/profile001.tga', 513, 569);
mywindow:setTexture('Disabled', 'UIData/profile001.tga', 513, 569);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setPosition(0, 192);
mywindow:setSize(218, 194);
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ProfileHistoryBack'):addChildWindow(mywindow)

------------------------------------------------------------------------------------
--  Profile History reply ( 방문기록 3)
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ProfileHistory3');
mywindow:setTexture('Enabled', 'UIData/profile001.tga', 513, 569);
mywindow:setTexture('Disabled', 'UIData/profile001.tga', 513, 569);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setPosition(0, 384);
mywindow:setSize(218, 194);
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ProfileHistoryBack'):addChildWindow(mywindow)

------------------------------------------------------------------------------------
--  Profile History Title 
------------------------------------------------------------------------------------
ProfileHistoryTitle = 
{ ["protecterr"]=0, "ProfileHistoryTitle1", "ProfileHistoryTitle2", "ProfileHistoryTitle3"}
local ProfileHistoryTitle_TexY  = {["err"]=0,  324, 342, 360}


for i =1 , #ProfileHistoryTitle do
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', ProfileHistoryTitle[i]);
	mywindow:setTexture('Enabled', 'UIData/profile001.tga',  894, ProfileHistoryTitle_TexY[i]);
	mywindow:setTexture('Disabled', 'UIData/profile001.tga', 894, ProfileHistoryTitle_TexY[i]);
	mywindow:setProperty('BackgroundEnabled', 'False');
	mywindow:setProperty('FrameEnabled', 'False');
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setPosition(40, 10);
	mywindow:setSize(130, 18);
	mywindow:setZOrderingEnabled(false)
end
winMgr:getWindow('ProfileHistory1'):addChildWindow(winMgr:getWindow('ProfileHistoryTitle1'))
winMgr:getWindow('ProfileHistory2'):addChildWindow(winMgr:getWindow('ProfileHistoryTitle2'))
winMgr:getWindow('ProfileHistory3'):addChildWindow(winMgr:getWindow('ProfileHistoryTitle3'))

-------------------------------------------------------------------------------------
-- 프로파일 히스토리 버튼 1
-------------------------------------------------------------------------------------
ProfileHistoryVisitorBtn = 
{ ["protecterr"]=0, "ProfileHistoryVisitor1", "ProfileHistoryVisitor2", "ProfileHistoryVisitor3" , 
					"ProfileHistoryVisitor4", "ProfileHistoryVisitor5"}
	

for i=1, #ProfileHistoryVisitorBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button",	ProfileHistoryVisitorBtn[i])
	mywindow:setTexture("Normal", "UIData/profile001.tga",		513, 763)    
	mywindow:setTexture("Hover", "UIData/profile001.tga",		513, 786)
	mywindow:setTexture("Pushed", "UIData/profile001.tga",		513, 809)
	mywindow:setTexture("PushedOff", "UIData/profile001.tga",	513, 763)
	mywindow:setTexture("Disabled", "UIData/profile001.tga",		513, 763);
	mywindow:subscribeEvent("Clicked", "OnClickHistoryVisitorName");
	mywindow:setSize(195, 23)
	mywindow:setPosition(12, 35+24*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	winMgr:getWindow('ProfileHistory1'):addChildWindow(mywindow)
	
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ProfileHistoryVisitorBtn[i]..'VisitorName')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setEnabled(false)
	child_window:setPosition(95, 5)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end

function OnClickHistoryVisitorName(args)
	--DebugStr('OnClickHistoryVisitorName()') 
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	local VisitName = winMgr:getWindow(win_name..'VisitorName'):getText()
	if VisitName ~= "" then
		GetProfileInfo(VisitName)
	end
end

function ClearProfileHistoryVisitor()
	for i= 1, #ProfileHistoryVisitorBtn do
		winMgr:getWindow(ProfileHistoryVisitorBtn[i]..'VisitorName'):clearTextExtends()	
		winMgr:getWindow(ProfileHistoryVisitorBtn[i]):setEnabled(false)
		winMgr:getWindow(ProfileHistoryVisitorBtn[i]..'VisitorName'):setText("")
	end
end

function Update_ProfileVisitedList(Index , VisitedName)
	winMgr:getWindow(ProfileHistoryVisitorBtn[Index+1]):setEnabled(true)
	winMgr:getWindow(ProfileHistoryVisitorBtn[Index+1]..'VisitorName'):setText(VisitedName)
	winMgr:getWindow(ProfileHistoryVisitorBtn[Index+1]..'VisitorName'):clearTextExtends()
	winMgr:getWindow(ProfileHistoryVisitorBtn[Index+1]..'VisitorName'):addTextExtends(VisitedName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
end


---------------------------------------
---프로파일 히스토리1 앞뒤버튼
---------------------------------------
local ProfileHistory1Page_BtnName  = {["err"]=0, [0]="ProfileHistory1Page_LBtn", "ProfileHistory1Page_RBtn"}
local ProfileHistory1Page_BtnTexX  = {["err"]=0, [0]= 0, 22}

local ProfileHistory1Page_BtnPosX  = {["err"]=0, [0]= 58, 143}
local ProfileHistory1Page_BtnEvent = {["err"]=0, [0]= "ProfileHistory1Page_PrevPage", "ProfileHistory1Page_NextPage"}
for i=0, #ProfileHistory1Page_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileHistory1Page_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", ProfileHistory1Page_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", ProfileHistory1Page_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",ProfileHistory1Page_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", ProfileHistory1Page_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", ProfileHistory1Page_BtnTexX[i], 81)
	mywindow:setPosition(ProfileHistory1Page_BtnPosX[i], 165)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfileHistory1Page_BtnEvent[i])
	winMgr:getWindow('ProfileHistory1'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProfileHistory1Page_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(71, 170)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_ProfileHistory1Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ProfileHistory1'):addChildWindow(mywindow)


---------------------------------------
---프로파일 히스토리1 이전페이지 버튼--
---------------------------------------
function ProfileHistory1Page_PrevPage()
	DebugStr('ProfileHistory1Page_PrevPage()')
	if	g_ProfileHistory1Page  > 1 then
		GetProfileVisitedList(g_ProfileHistory1Page - 1)
	end
end

---------------------------------------
---프로파일 히스토리1 다음페이지 버튼--
---------------------------------------
function ProfileHistory1Page_NextPage()
	DebugStr('ProfileHistory1Page_NextPage()')
	GetProfileVisitedList(g_ProfileHistory1Page + 1)
end
---------------------------------------
---프로파일 히스토리1 페이지 설정--
---------------------------------------
function SettingProfileHistory1Page(CurrentPage)
	g_ProfileHistory1Page =	CurrentPage
	winMgr:getWindow('ProfileHistory1Page_PageText'):clearTextExtends()
	winMgr:getWindow('ProfileHistory1Page_PageText'):addTextExtends(tostring(g_ProfileHistory1Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end



-------------------------------------------------------------------------------------
-- 프로파일 히스토리 버튼 2 ( 내가방문한기록)
-------------------------------------------------------------------------------------
ProfileHistoryVisitBtn = 
{ ["protecterr"]=0, "ProfileHistoryVisit1", "ProfileHistoryVisit2", "ProfileHistoryVisit3" , 
					"ProfileHistoryVisit4", "ProfileHistoryVisit5"}
	

for i=1, #ProfileHistoryVisitBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button",	ProfileHistoryVisitBtn[i])
	mywindow:setTexture("Normal", "UIData/profile001.tga",		513, 763)    
	mywindow:setTexture("Hover", "UIData/profile001.tga",		513, 786)
	mywindow:setTexture("Pushed", "UIData/profile001.tga",		513, 809)
	mywindow:setTexture("PushedOff", "UIData/profile001.tga",	513, 763)
	mywindow:setTexture("Disabled", "UIData/profile001.tga",		513, 763);
	mywindow:subscribeEvent("Clicked", "OnClickHistoryVisitName");
	mywindow:setSize(195, 23)
	mywindow:setPosition(12, 35+24*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	winMgr:getWindow('ProfileHistory2'):addChildWindow(mywindow)
	
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ProfileHistoryVisitBtn[i]..'VisitOwnerName')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(95, 5)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setEnabled(false)
	--child_window:addTextExtends("charactername", g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
end

function OnClickHistoryVisitName(args)
	DebugStr('OnClickHistoryVisitName') 
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	local VisitName = winMgr:getWindow(win_name..'VisitOwnerName'):getText()
	if VisitName ~= "" then
		GetProfileInfo(VisitName)
	end
end

function ClearProfileHistoryVisit()
	for i= 1, #ProfileHistoryVisitBtn do
		winMgr:getWindow(ProfileHistoryVisitBtn[i]..'VisitOwnerName'):clearTextExtends()	
		winMgr:getWindow(ProfileHistoryVisitBtn[i]):setEnabled(false)
		winMgr:getWindow(ProfileHistoryVisitBtn[i]..'VisitOwnerName'):setText("")
	end
end

function Update_ProfileVisitList(Index , VisitOwnerName)
	winMgr:getWindow(ProfileHistoryVisitBtn[Index+1]):setEnabled(true)
	winMgr:getWindow(ProfileHistoryVisitBtn[Index+1]..'VisitOwnerName'):setText(VisitOwnerName)
	winMgr:getWindow(ProfileHistoryVisitBtn[Index+1]..'VisitOwnerName'):clearTextExtends()
	winMgr:getWindow(ProfileHistoryVisitBtn[Index+1]..'VisitOwnerName'):addTextExtends(VisitOwnerName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
end


---------------------------------------
---프로파일 히스토리2 앞뒤버튼
---------------------------------------
local ProfileHistory2Page_BtnName  = {["err"]=0, [0]="ProfileHistory2Page_LBtn", "ProfileHistory2Page_RBtn"}
local ProfileHistory2Page_BtnTexX  = {["err"]=0, [0]= 0, 22}

local ProfileHistory2Page_BtnPosX  = {["err"]=0, [0]= 58, 143}
local ProfileHistory2Page_BtnEvent = {["err"]=0, [0]= "ProfileHistory2Page_PrevPage", "ProfileHistory2Page_NextPage"}
for i=0, #ProfileHistory2Page_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileHistory2Page_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", ProfileHistory2Page_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", ProfileHistory2Page_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",ProfileHistory2Page_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", ProfileHistory2Page_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", ProfileHistory2Page_BtnTexX[i], 81)
	mywindow:setPosition(ProfileHistory2Page_BtnPosX[i], 165)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfileHistory2Page_BtnEvent[i])
	winMgr:getWindow('ProfileHistory2'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProfileHistory2Page_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(71, 170)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_ProfileHistory2Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ProfileHistory2'):addChildWindow(mywindow)


---------------------------------------
---프로파일 히스토리2 이전페이지 버튼--
---------------------------------------
function ProfileHistory2Page_PrevPage()
	DebugStr('ProfileHistory2Page_PrevPage()')
	if	g_ProfileHistory2Page  > 1 then
		GetProfileVisitList(g_ProfileHistory2Page - 1)
	end
end

---------------------------------------
---프로파일 히스토리2 다음페이지 버튼--
---------------------------------------
function ProfileHistory2Page_NextPage()
	DebugStr('ProfileHistory2Page_NextPage()')
	DebugStr('g_ProfileHistory2Page')
	if g_ProfileHistory2Page < 4 then 
		GetProfileVisitList(g_ProfileHistory2Page + 1)
	end
end
---------------------------------------
---프로파일 히스토리2 페이지 설정--
---------------------------------------
function SettingProfileHistory2Page(CurrentPage)
	g_ProfileHistory2Page =	CurrentPage
	winMgr:getWindow('ProfileHistory2Page_PageText'):clearTextExtends()
	winMgr:getWindow('ProfileHistory2Page_PageText'):addTextExtends(tostring(g_ProfileHistory2Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end



-------------------------------------------------------------------------------------
-- 프로파일 히스토리 버튼 3
-------------------------------------------------------------------------------------
ProfileHistroyReplyBtn = 
{ ["protecterr"]=0, "ProfileHistroyReply1", "ProfileHistroyReply2", "ProfileHistroyReply3" , 
					"ProfileHistroyReply4", "ProfileHistroyReply5"}
	

for i=1, #ProfileHistroyReplyBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button",	ProfileHistroyReplyBtn[i])
	mywindow:setTexture("Normal", "UIData/profile001.tga",		513, 763)    
	mywindow:setTexture("Hover", "UIData/profile001.tga",		513, 786)
	mywindow:setTexture("Pushed", "UIData/profile001.tga",		513, 809)
	mywindow:setTexture("PushedOff", "UIData/profile001.tga",	513, 763)
	mywindow:setTexture("Disabled", "UIData/profile001.tga",			513, 763);
	mywindow:subscribeEvent("Clicked", "OnClickHistoryReplyName");
	mywindow:setSize(195, 23)
	mywindow:setPosition(12, 35+24*(i-1))
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowReplyMsg")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HideReplyMsg")
	mywindow:setUserString('ReplyMsgIndex', tostring(i))
	--mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	winMgr:getWindow('ProfileHistory3'):addChildWindow(mywindow)
	
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ProfileHistroyReplyBtn[i]..'ReplyName')	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setEnabled(false)
	child_window:setPosition(95, 5)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
	mywindow:addChildWindow(child_window)
	
	local child_window2 = winMgr:createWindow("TaharezLook/StaticText", ProfileHistroyReplyBtn[i]..'WriteMsg')	
	child_window2:setProperty("FrameEnabled", "false")
	child_window2:setProperty("BackgroundEnabled", "false")
	child_window2:setSize(5, 5)
	child_window2:setVisible(true)
	child_window2:setEnabled(false)
	child_window2:setPosition(0, 0)
	child_window2:setViewTextMode(1)	
	child_window2:setAlign(8)
	child_window2:setLineSpacing(1)
	mywindow:addChildWindow(child_window2)
	
	local child_window3 = winMgr:createWindow("TaharezLook/StaticText", ProfileHistroyReplyBtn[i]..'ReplyMsg')	
	child_window3:setProperty("FrameEnabled", "false")
	child_window3:setProperty("BackgroundEnabled", "false")
	child_window3:setSize(5, 5)
	child_window3:setVisible(true)
	child_window3:setEnabled(false)
	child_window3:setPosition(0, 0)
	child_window3:setViewTextMode(1)	
	child_window3:setAlign(8)
	child_window3:setLineSpacing(1)
	mywindow:addChildWindow(child_window3)
end

function OnClickHistoryReplyName(args)
	DebugStr('OnClickHistoryReplyName()') 
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	local ReplyName = winMgr:getWindow(win_name..'ReplyName'):getText()
	if ReplyName ~= "" then
		GetProfileInfo(ReplyName)
	end
end

function ClearProfileHistroyReply()
	DebugStr('ClearProfileHistroyReply()')
	--for i= 1, #ProfileHistroyReplyBtn do
	for i= 1, 5 do
		DebugStr('ClearProfileHistroyReply:'..i)
		winMgr:getWindow(ProfileHistroyReplyBtn[i]..'ReplyName'):clearTextExtends()	
		winMgr:getWindow(ProfileHistroyReplyBtn[i]):setEnabled(false)
		winMgr:getWindow(ProfileHistroyReplyBtn[i]..'ReplyName'):setText("")
		winMgr:getWindow(ProfileHistroyReplyBtn[i]..'WriteMsg'):setText("")
		winMgr:getWindow(ProfileHistroyReplyBtn[i]..'ReplyMsg'):setText("")
	end
end

function Update_ProfileReplyList(Index , ReplyName , WriteMsg, ReplyMsg)
	DebugStr('Update_ProfileReplyList()')
	DebugStr('Index:'..Index)
	DebugStr('ReplyName:'..ReplyName)
	DebugStr('WriteMsg:'..WriteMsg)
	DebugStr('ReplyMsg:'..ReplyMsg)
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]):setEnabled(true)
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]..'ReplyName'):setText(ReplyName)
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]..'ReplyName'):clearTextExtends()
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]..'ReplyName'):addTextExtends(ReplyName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]..'WriteMsg'):setText(WriteMsg)
	winMgr:getWindow(ProfileHistroyReplyBtn[Index+1]..'ReplyMsg'):setText(ReplyMsg)
end


---------------------------------------
---프로파일 히스토리3 앞뒤버튼
---------------------------------------
local ProfileHistory3Page_BtnName  = {["err"]=0, [0]="ProfileHistory3Page_LBtn", "ProfileHistory3Page_RBtn"}
local ProfileHistory3Page_BtnTexX  = {["err"]=0, [0]= 0, 22}

local ProfileHistory3Page_BtnPosX  = {["err"]=0, [0]= 58, 143}
local ProfileHistory3Page_BtnEvent = {["err"]=0, [0]= "ProfileHistory3Page_PrevPage", "ProfileHistory3Page_NextPage"}
for i=0, #ProfileHistory3Page_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", ProfileHistory3Page_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", ProfileHistory3Page_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", ProfileHistory3Page_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",ProfileHistory3Page_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", ProfileHistory3Page_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", ProfileHistory3Page_BtnTexX[i], 81)
	mywindow:setPosition(ProfileHistory3Page_BtnPosX[i], 165)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", ProfileHistory3Page_BtnEvent[i])
	winMgr:getWindow('ProfileHistory3'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProfileHistory3Page_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(71, 170)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_ProfileHistory3Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ProfileHistory3'):addChildWindow(mywindow)


---------------------------------------
---프로파일 히스토리3 이전페이지 버튼--
---------------------------------------
function ProfileHistory3Page_PrevPage()
	DebugStr('ProfileHistory3Page_PrevPage()')
	if	g_ProfileHistory3Page  > 1 then
		GetProfileLatestGuestBookList(g_ProfileHistory3Page - 1)
	end
end

---------------------------------------
---프로파일 히스토리3 다음페이지 버튼--
---------------------------------------
function ProfileHistory3Page_NextPage()
	DebugStr('ProfileHistory3Page_NextPage()')
	GetProfileLatestGuestBookList(g_ProfileHistory3Page + 1)
end
---------------------------------------
---프로파일 히스토리3 페이지 설정--
---------------------------------------
function SettingProfileHistory3Page(CurrentPage)
	DebugStr('CurrentPage:'..CurrentPage)
	DebugStr('g_ProfileHistory3Page:'..g_ProfileHistory3Page)
	g_ProfileHistory3Page =	CurrentPage
	winMgr:getWindow('ProfileHistory3Page_PageText'):clearTextExtends()
	winMgr:getWindow('ProfileHistory3Page_PageText'):addTextExtends(tostring(g_ProfileHistory3Page), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


------------------------------------------------------------------------------------
-----  히스토리 툴팁 백판
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ProfileHistoryTooltipBack")
mywindow:setTexture("Enabled", "UIData/Profile001.tga", 0, 658)
mywindow:setTexture("Disabled", "UIData/Profile001.tga",0, 658)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(475 ,490);
mywindow:setSize(437, 59)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 팀 세부 정보 텍스트
HistoryTooltipText =   { ["protecterr"]=0, "HistoryTooltipText_WriteMsg", "HistoryTooltipText_ReplyMsg" }
								   
HistoryTooltipTextPosX  =    { ["protecterr"]=0, 10, 27 }
HistoryTooltipTextPosY  =    { ["protecterr"]=0, 7,  32 }


for i=1 , #HistoryTooltipText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", HistoryTooltipText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(HistoryTooltipTextPosX[i],HistoryTooltipTextPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	if i == 1 then
		mywindow:setTextColor(255, 255, 255, 255)
	else
		mywindow:setTextColor(255,198,0,255)
	end
	mywindow:setVisible(true)
	winMgr:getWindow('ProfileHistoryTooltipBack'):addChildWindow( winMgr:getWindow(HistoryTooltipText[i]) );
end

function OnMouseEnter_ShowReplyMsg(args)
	root:addChildWindow(winMgr:getWindow('ProfileHistoryBack'))
	winMgr:getWindow('ProfileHistoryTooltipBack'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('ProfileHistoryTooltipBack'))
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("ReplyMsgIndex"))
	winMgr:getWindow('ProfileHistoryTooltipBack'):setPosition(x-150, y+25)
	
	local WriteMsg  = winMgr:getWindow(ProfileHistroyReplyBtn[index]..'WriteMsg'):getText()
	local ReplyMsg   = winMgr:getWindow(ProfileHistroyReplyBtn[index]..'ReplyMsg'):getText()
	
	winMgr:getWindow(HistoryTooltipText[1]):setText(WriteMsg)
	winMgr:getWindow(HistoryTooltipText[2]):setText(ReplyMsg)
end

function OnMouseLeave_HideReplyMsg()
	winMgr:getWindow('ProfileHistoryTooltipBack'):setVisible(false)
end
