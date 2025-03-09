-----------------------------------------
-- Script Entry Point
-----------------------------------------

lockChatTabBackground = true;

local guiSystem	= CEGUI.System:getSingleton();
local winMgr	= CEGUI.WindowManager:getSingleton();
local root		= winMgr:getWindow("DefaultWindow");
guiSystem:setGUISheet(root)
root:activate()



-- Button
CHATTYPE_ILLEGAL = 0
CHATTYPE_ALL = 1
CHATTYPE_PARTY = 2
CHATTYPE_PRIVATE = 3
CHATTYPE_TEAM = 4
CHATTYPE_SYSTEM1 = 5
CHATTYPE_SYSTEM2 = 6
CHATTYPE_GANG = 7
CHATTYPE_MEGAPHONE = 8
CHATTYPE_OBSERVER = 9
CHATTYPE_EMOTICON = 10
COUNT_CHATTAB = 10


g_bGetOnVehicle = false;
g_ChatActive = true;
g_continueChat = true		-- 계속 채팅을 이어갈건지
g_SelectedTab = CHATTYPE_ALL;
g_SelectedPopupTab = CHATTYPE_ALL;
g_bChatTabEnable = false

g_chatTabCnt = 0
g_chatTab1 = {0,0,0,0,0,0,0,0} -- 위치 / 버튼종류 인덱스 저장(0은 무효)
g_chatTab2 = {0,0,0,0,0,0,0,0,0,0,0} -- 버튼종류 / 위치 인덱스 저장

g_chatPopupCnt = 0
g_chatPopup1 = {0,0,0,0,0,0} -- 위치 / 팝업종류 인덱스 저장(0은 무효)
g_chatPopup2 = {0,0,0,0,0,0,0,0,0,0,0} -- 팝업종류 / 위치 인덱스 저장

g_bUsePartyAsTeam = false

g_nAlpha = 0		-- 윈도우 알파값
SPEED_ALPHA = 50	-- 알파변화속도


MAX_TABINDEX = 7
MAX_POPUPINDEX = 5

-- 전체(1), 파티(2), 귓속말(3), 팀채팅(4), 시스템(5), 시스템2(6), 갱(7), 메가폰(8), 옵저버(9), 총 9개


local CHAT_WINDOW_SIZEX = 426
local CHAT_DISPLAY_WINDOW_SIZEY = 185


--[[

public: -- windows

	ChatBackground							-- 전체 채팅창
	{
		multichatBackground					-- multiedit의 배경이미지
			multichat_list_1 ~ 10			-- CHATTYPE에 따른 multiedit
				multichat_list_1 ~ 10__auto_vscrollbar__				-- 스크롤바 본체
				multichat_list_1 ~ 10__auto_vscrollbar____auto_incbtn__	-- 스크롤바 아래 버튼
				multichat_list_1 ~ 10__auto_vscrollbar____auto_decbtn__	-- 스크롤바 위 버튼
				multichat_list_1 ~ 10__auto_vscrollbar____auto_thumb__	-- 스크롤바 가운데 버튼
			ChatScrollbar_body				-- 스크롤바 본체 이미지
				ChatScrollbar_decbtn		-- 스크롤바 아래 버튼 이미지
				ChatScrollbar_incbtn		-- 스크롤바 위 버튼 이미지
				ChatScrollbar_thumb			-- 스크롤바 가운데 버튼 이미지
			sj_emoticonTempImage			-- 이모티콘 배경창
				sj_emoticonBtn_1 ~ 20		-- 이모티콘 버튼
					sj_emoticonBtn_FirstNew1 ~ 20
					sj_emoticonBtn_SecondNew1 ~ 20

		chatTabBackground					-- 탭 버튼들을 묶어주기 위한 윈도우
			chat_tab_all ~ emoticon(10개)	-- CHATTYPE에 따른 탭 버튼
		
		chatPopupBackground					-- 팝업 버튼들을 묶어주기 위한 윈도우
			chat_popup_team ~ Public(5개)	-- 팝업버튼 Team, Gang, Private, Party, Public

		doChattingBackground				-- 채팅 입력창 전체
			doChatting						-- 채팅 입력 edit
			PrivateChatting					-- 귓속말 상대 id입력 edit
			ChatLanguage					-- 한/영 키 표시 이미지
			ChatCallPopup					-- 팝업버튼창 호출 버튼
			ChatSelectedPopup				-- 팝업선택창
	}


public: -- functions

	-- 외부에서는 * 표시가 붙은 함수들만을 사용할것을 권장합니다

*	function Chatting_SetChatEnabled( b )	-- 채팅 전체를 활성화/비활성화 시킵니다 visible이 그대로이므로 마우스오버이벤트나 엔터이벤트를 잠시 막고 싶을때 사용합니다
**	function Chatting_InitChat()				-- 윈도우 초기설정을 합니다 채팅창이 필요한곳에서는 반드시 초반에 호출해주어야 합니다
*	function Chatting_SelectTab( index )		-- 원하는 탭을 선택할수 있습니다 마우스로 클릭한것과 같은 효과를 갖습니다
	
	-- 탭을 설정할수 있습니다 CHATTYPE 상수들로 인수를 주십시오 설정시에는 순서를 맞출 필요가 없습니다
*	function Chatting_SetChatTabDefault()
	function Chatting_SetChatTabCnt( cnt )
	function Chatting_SetChatTabIndex( index, num )
*	function Chatting_SetChatTab( ... )
	
	-- 팝업버튼창을 설정할수 있습니다 CHATTYPE 상수들로 인수를 주십시오 설정시에는 순서를 맞출 필요가 없습니다
*	function Chatting_SetChatPopupDefault()
	function Chatting_SetChatPopupCnt( cnt )
	function Chatting_SetChatPopupIndex( index, num )
*	function Chatting_SetChatPopup( ... )
	
*	function Chatting_SetPopupVisible( b )		-- 팝업버튼창의 visible을 조정합니다
*	function Chatting_SetUsePartyAsTeam( b )		-- Party탭을 Team채팅 기능으로 사용할지 여부를 결정합니다
**	function Chatting_SetChatPosition( x, y )	-- 전체 채팅창의 위치를 조정합니다
**	function Chatting_SetChatWideType( type )	-- 전체 채팅창의 WideType을 조정합니다(내부적으로 채팅창의 몇몇 구성 윈도우에 대해 같은 WideType을 설정합니다)
	function SetChatScrollVisible( b )			-- 스크롤바 전체의 visible을 조정합니다
	function OnSelected_Tab(args)				-- 탭선택시 이벤트 함수입니다
	function OnSelected_Popup(args)				-- 팝업선택시 이벤트 함수입니다
	function Chatting_SetChatSelectedPopup(type)	-- 팝업선택윈도우를 조정합니다
*	function ChangeChatPopupTab()				-- 팝업선택윈도우를 다음 팝업으로 변경합니다 키보드탭버튼 이벤트로 사용할것을 권장합니다
	function Chatting_OnTextAccepted_callPopup()	-- 팝업호출버튼의 이벤트 함수입니다
	function ShowChatViewVisible(bVisible)		-- multichat_list 의 visible을 조정합니다
*	function OnRootKeyUpChatting()				-- 엔터키Up 이벤트입니다 village에서 쓰이며 OnTextAccepted1과 함께 사용할것을 권장합니다
	function OnTextAcceptedPrivateChatting()	-- 귓속말 아이디 입력창의 이벤트 함수입니다
	
	-- 채팅입력창의 visible을 조정하는 구버전의 함수입니다 호환성을 위해 남겨뒀으나 Chatting_SetChatEditVisible함수를 사용할것을 권장합니다
	function Offcontroller()					-- 
	function Oncontroller()						-- 
	
*	function Chatting_SetChatEditVisible( b )	-- 채팅 입력창 전체의 visible을 조정합니다
	function OnChatPublicWithName(name, message, chatType, specialType, ...)	-- name과 분리해서 처리하는 채팅 메세지 처리함수입니다 village에서 쓰입니다
**	function OnChatPublic(message, chatType, specialType)						-- 채팅 메세지 처리함수입니다
	function _OnTextAccepted()					-- 채팅 입력창 이벤트 함수들의 공통처리부분입니다
	function Chatting_OnTextAccepted1(args)		-- 채팅 입력창 이벤트 함수 1번입니다 광장의 이벤트입니다
	function Chatting_OnTextAccepted2(args)		-- 채팅 입력창 이벤트 함수 2번입니다 로비, Room의 이벤트입니다
	function Chatting_OnTextAccepted3(args)		-- 채팅 입력창 이벤트 함수 3번입니다 게임의 이벤트입니다
*	function Chatting_SetChatTextAccepted( func )-- 채팅 입력창의 이벤트 함수를 설정합니다 인수로 함수이름을 전달하십시오
**	function Chatting_SetChatEditEvent( index )	-- 채팅 입력창의 이벤트 함수를 설정합니다 인수로 정수 1, 2, 3 중 하나를 전달하십시오
	function Chatting_SetLanguage(mode)			-- 한/영 키 이미지를 조정합니다 WndBase에서 호출해주므로 WndBase를 상속받는 윈도우라면 호출하지 마십시오
	function OnClickedEmoticon(args)			-- 이모티콘 버튼의 이벤트 함수입니다
	function OnAlphaSetting_MouseEnter(args)	-- 알파를 조정하기 위한 마우스엔터 이벤트입니다
	function OnAlphaSetting_MouseLeave(args)	-- 알파를 조정하기 위한 마우스리브 이벤트입니다
	function Util_SettingWinAlpha(winsName, palpha)		-- 윈도우들의 알파를 조정합니다
**	function Chatting_renderChat()				-- render 함수입니다 스크롤바 렌더와 채팅창 전체 알파값을 조정합니다 윈도우 렌더함수 내부에서 호출하여 주십시오

	-- 스크롤바 텍스쳐 변경과 알파 변경 이벤트를 위한 이벤트 함수입니다
	function OnChatScrollUpMouseEnter( args )
	function OnChatScrollUpMouseLeave( args )
	function OnChatScrollDownMouseEnter( args )
	function OnChatScrollDownMouseLeave( args )
	
	-- 이모티콘 렌더 이벤트 함수입니다
	function EndRenderEmoticonTooltip(args)
	function RenderEmoticonTooltip(index, tailPos, px, py, tooltipText)
	
*	function SavePrivateName(PrivateName)		-- 귓속말 상대를 저장합니다
	function GetChattingCharacterName(args)		-- 


]]--




-- 채팅창을 묶어주기위한 기본윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
--mywindow:setWideType(2)
--mywindow:setPosition(3, 462)
mywindow:setSize(CHAT_WINDOW_SIZEX, 240)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("DefaultWindow"):addChildWindow(mywindow)



-- 멀티에디트 박스 배경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "multichatBackground")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 445, 481)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 445, 481)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 33)
mywindow:setSize(CHAT_WINDOW_SIZEX, CHAT_DISPLAY_WINDOW_SIZEY)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
winMgr:getWindow("ChatBackground"):addChildWindow(winMgr:getWindow("multichatBackground"))


-- MultiLineEdit
if IsInitialized() == false then
	for i=1, COUNT_CHATTAB do
		mywindow = winMgr:createWindow("TaharezLook/MultiLineEditbox", "multichat_list_" .. i);
		mywindow:setProperty('ReadOnly', 'true');
		mywindow:setProperty('VertScrollbar', 'true');
		mywindow:setTextColor(255,255,255,255);
		mywindow:setFont(g_STRING_FONT_GULIM, 14);
		mywindow:setPosition(0, 0)
		mywindow:setSize(CHAT_WINDOW_SIZEX, CHAT_DISPLAY_WINDOW_SIZEY)
		mywindow:setVisible(false)
		mywindow:setUserString("index", -1)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		mywindow:setSubscribeEvent("MouseLButtonUp", "CommonChattLButtonUp")
		mywindow:setSubscribeEvent("MouseRButtonUp", "GetReportCharacterName")
		mywindow:setLineSpacing(13)
		mywindow:setClippedByParent(true)
		winMgr:registerCacheWindow("multichat_list_" .. i)
		winMgr:getWindow("multichatBackground"):addChildWindow(mywindow)
	end
end


-- 탭버튼 배경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "chatTabBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 8)
mywindow:setSize(CHAT_WINDOW_SIZEX, 28) -- 여분 + 3
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setUserString("index", -1)
winMgr:getWindow("ChatBackground"):addChildWindow(mywindow)

tChatTabName  = {['protecterr'] = 0, [0]="", "chat_tab_allChat", "chat_tab_partyChat", "chat_tab_privateChat", "chat_tab_team", "chat_tab_system1", "chat_tab_system2", "chat_tab_gang", "chat_tab_megaphone", "chat_tab_observer", "chat_tab_emoticon"}
tChatTabTexX  = {['protecterr'] = 0, [0]=0, 190, 250, 310, 670, 550, 550, 610, 490, 430, 370}
tChatTabTexY  = {['protecterr'] = 0, [0]=0, 381, 381, 381, 381, 381, 381, 381, 381, 381, 381}


for i=1, COUNT_CHATTAB do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tChatTabName[i])
	mywindow:setTexture("Disabled", "UIData/mainbarchat.tga",			tChatTabTexX[i], tChatTabTexY[i]+75)
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga",				tChatTabTexX[i], tChatTabTexY[i])
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga",				tChatTabTexX[i], tChatTabTexY[i]+25)
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga",				tChatTabTexX[i], tChatTabTexY[i]+50)
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga",			tChatTabTexX[i], tChatTabTexY[i])
	mywindow:setTexture("SelectedNormal", "UIData/mainbarchat.tga",		tChatTabTexX[i], tChatTabTexY[i]+50)
	mywindow:setTexture("SelectedHover", "UIData/mainbarchat.tga",		tChatTabTexX[i], tChatTabTexY[i]+50)
	mywindow:setTexture("SelectedPushed", "UIData/mainbarchat.tga",		tChatTabTexX[i], tChatTabTexY[i]+50)
	mywindow:setTexture("SelectedPushedOff", "UIData/mainbarchat.tga",	tChatTabTexX[i], tChatTabTexY[i]+50)
	mywindow:setSize(60, 25)
	mywindow:setPosition((i-1)*61, 0)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelected_Tab")
	winMgr:getWindow("chatTabBackground"):addChildWindow(mywindow)
end


-- 팝업버튼 배경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "chatPopupBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(2, 130)
mywindow:setSize(70, 90)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setVisible(false)
winMgr:getWindow("ChatBackground"):addChildWindow(mywindow)

-- Popup
Chat_PopupButtonName =
{ ["protecterr"]=0, "chat_popup_team", "chat_popup_gang", "chat_popup_private", "chat_popup_party", "chat_popup_public"}
Chat_PopupTexurePosY = {['protecterr']=0, 381, 399, 417, 435, 453}
Chat_PopupTabIndex1 = {['protecterr']=0, 4, 7, 3, 2, 1}
Chat_PopupTabIndex2 = {['protecterr']=0, 5, 4, 3, 1, 5, 5, 2, 5, 5, 5}	-- 나머지는 모두 public이 선택된다
for i=1, #Chat_PopupButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Chat_PopupButtonName[i])
	mywindow:setTexture("Disabled", "UIData/mainbarchat.tga",			0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga",				0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga",			   70, Chat_PopupTexurePosY[i])
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga",				0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga",			0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("SelectedNormal", "UIData/mainbarchat.tga",		0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("SelectedHover", "UIData/mainbarchat.tga",		0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("SelectedPushed", "UIData/mainbarchat.tga",		0, Chat_PopupTexurePosY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/mainbarchat.tga",	0, Chat_PopupTexurePosY[i])
	mywindow:setSize(70, 18)
	mywindow:setPosition(0, (i-1)*18)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelected_Popup")
	winMgr:getWindow("chatPopupBackground"):addChildWindow(mywindow)
end


local START_X = 4
local START_Y = 4
local SPACING_X = 42
local SPACING_Y = 42 + START_Y
local SPACING_Y_01 = 84 + START_Y

tEmoticonPosX = {["err"]=0, [0]=START_X, SPACING_X+START_X, 2*SPACING_X+START_X, 3*SPACING_X+START_X, 4*SPACING_X+START_X, 5*SPACING_X+START_X, 6*SPACING_X+START_X, 7*SPACING_X+START_X, 8*SPACING_X+START_X, 9*SPACING_X+START_X,
								START_X, SPACING_X+START_X, 2*SPACING_X+START_X, 3*SPACING_X+START_X, 4*SPACING_X+START_X, 5*SPACING_X+START_X, 6*SPACING_X+START_X, 7*SPACING_X+START_X, 8*SPACING_X+START_X, 9*SPACING_X+START_X,
								START_X}

tEmoticonPosY = {["err"]=0, [0]=START_Y, START_Y, START_Y, START_Y, START_Y, START_Y, START_Y, START_Y, START_Y, START_Y,
								SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y, SPACING_Y,
								SPACING_Y_01}

if IsInitialized() == false then

	-- 이모티콘을 붙일 이미지(시스템 메세지 창 위에 root로 붙인다)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_emoticonTempImage")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(CHAT_WINDOW_SIZEX, CHAT_DISPLAY_WINDOW_SIZEY)
	mywindow:setWheelEventDisabled(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUserString("index", -1)
	winMgr:registerCacheWindow("sj_emoticonTempImage")

	-- 이모티콘 버튼
	MAX_EMOTICON = 21
	for i=0, MAX_EMOTICON-1 do
		mywindow = winMgr:createWindow("TaharezLook/Button", "sj_emoticonBtn_"..i)
		mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", i*39, 868)
		mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", i*39, 907)
		mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", i*39, 946)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", i*39, 868)
		mywindow:setPosition(tEmoticonPosX[i], tEmoticonPosY[i])
		mywindow:setSize(39, 39)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setUserString("index", i)
		winMgr:registerCacheWindow("sj_emoticonBtn_"..i)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_emoticonBtn_FirstNew"..i)
		mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 858)
		mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 0, 858)
		mywindow:setPosition(2, 2)
		mywindow:setSize(22, 10)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:addController("stateMotion", "EmoticonNewEvent", "alpha", "Sine_EaseInOut", 255, 0, 2, true, true, 10)
		mywindow:addController("stateMotion", "EmoticonNewEvent", "alpha", "Sine_EaseInOut", 0, 255, 2, true, true, 10)
		winMgr:registerCacheWindow("sj_emoticonBtn_FirstNew"..i)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_emoticonBtn_SecondNew"..i)
		mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 22, 858)
		mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 22, 858)
		mywindow:setPosition(2, 2)
		mywindow:setSize(22, 10)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:addController("stateMotion", "EmoticonNewEvent", "alpha", "Sine_EaseInOut", 0, 255, 2, true, true, 10)
		mywindow:addController("stateMotion", "EmoticonNewEvent", "alpha", "Sine_EaseInOut", 255, 0, 2, true, true, 10)
		winMgr:registerCacheWindow("sj_emoticonBtn_SecondNew"..i)
	end
end


-- 이모티콘 붙이기
tEmoticonTooltipVisible = {["err"]=0, }
winMgr:getWindow("multichatBackground"):addChildWindow(winMgr:getWindow("sj_emoticonTempImage"))
for i=0, MAX_EMOTICON-1 do		
	winMgr:getWindow("sj_emoticonTempImage"):addChildWindow(winMgr:getWindow("sj_emoticonBtn_"..i))
	winMgr:getWindow("sj_emoticonBtn_"..i):addChildWindow(winMgr:getWindow("sj_emoticonBtn_FirstNew"..i))
	winMgr:getWindow("sj_emoticonBtn_"..i):addChildWindow(winMgr:getWindow("sj_emoticonBtn_SecondNew"..i))
	winMgr:getWindow("sj_emoticonBtn_"..i):subscribeEvent("Clicked", "OnClickedEmoticon")
	winMgr:getWindow("sj_emoticonBtn_"..i):setSubscribeEvent("EndRender", "EndRenderEmoticonTooltip")
	tEmoticonTooltipVisible[i] = false
end


-- 채팅 입력 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "doChattingBackground")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 218)
mywindow:setSize(CHAT_WINDOW_SIZEX, 22)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setVisible(false);
winMgr:getWindow("ChatBackground"):addChildWindow(mywindow)


function OnTextFullEvent(args)
	PlayWave('sound/FullEdit.wav');
end


mywindow = winMgr:createWindow("TaharezLook/Editbox", "doChatting");
mywindow:setPosition(93, 0);
mywindow:setSize(306, 21);
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setAlwaysOnTop(false);
mywindow:setSubscribeEvent("TextAccepted", "Chatting_OnTextAccepted1");
mywindow:setVisible(false);
winMgr:getWindow('doChattingBackground'):addChildWindow(mywindow);
CEGUI.toEditbox(winMgr:getWindow("doChatting")):setMaxTextLength(64)
CEGUI.toEditbox(winMgr:getWindow("doChatting")):setSubscribeEvent("EditboxFull", "OnTextFullEvent")


--귓속말 대상 에디트박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "PrivateChatting");
mywindow:setPosition(1, 1);
mywindow:setSize(70, 18);
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setAlwaysOnTop(false);
mywindow:setText("")
mywindow:setSubscribeEvent("TextAccepted", "OnTextAcceptedPrivateChatting");
mywindow:setVisible(false);
winMgr:getWindow('doChattingBackground'):addChildWindow(mywindow);
CEGUI.toEditbox(winMgr:getWindow("PrivateChatting")):setMaxTextLength(12)
CEGUI.toEditbox(winMgr:getWindow("PrivateChatting")):setSubscribeEvent("EditboxFull", "OnTextFullEvent")


-- ChatLanguage
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatLanguage")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 174, 381)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(407, 2)
mywindow:setSize(16, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false);
winMgr:getWindow('doChattingBackground'):addChildWindow(mywindow);


-- 채팅 팝업호출버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ChatCallPopup")
mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 141, 381)
mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 141, 398)
mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 141, 415)
mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 141, 415)
mywindow:setPosition(75, 2)
mywindow:setSize(17, 17)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Chatting_OnTextAccepted_callPopup")
winMgr:getWindow('doChattingBackground'):addChildWindow(mywindow);

-- 채팅 팝업 선택 이미지
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ChatSelectedPopup')
mywindow:setTexture('Enabled', 'UIData/mainbarchat.tga',	0, 453)
mywindow:setTexture('Disabled', 'UIData/mainbarchat.tga',	0, 453)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(2, 2)
mywindow:setSize(70, 18)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('doChattingBackground'):addChildWindow(mywindow);



-- 스크롤바 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatScrollbar_body")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 1012, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 1012, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(412, 0)
mywindow:setSize(12, CHAT_DISPLAY_WINDOW_SIZEY)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
winMgr:getWindow("multichatBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatScrollbar_decbtn")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 988, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 988, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
winMgr:getWindow("ChatScrollbar_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatScrollbar_incbtn")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 1000, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 1000, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 168)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
winMgr:getWindow("ChatScrollbar_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChatScrollbar_thumb")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 972, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 972, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(-2, 1)
mywindow:setSize(16, 16)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setClippedByParent(false)
mywindow:moveToFront()
winMgr:getWindow("ChatScrollbar_body"):addChildWindow(mywindow)



for i=1, COUNT_CHATTAB do
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar__'):setSubscribeEvent('MouseEnter', 'OnAlphaSetting_MouseEnter');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar__'):setSubscribeEvent('MouseLeave', 'OnAlphaSetting_MouseLeave');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar__'):setClippedByParent(false)
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_incbtn__'):setSubscribeEvent('MouseEnter', 'OnChatScrollDownMouseEnter');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_incbtn__'):setSubscribeEvent('MouseLeave', 'OnChatScrollDownMouseLeave');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_decbtn__'):setSubscribeEvent('MouseEnter', 'OnChatScrollUpMouseEnter');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_decbtn__'):setSubscribeEvent('MouseLeave', 'OnChatScrollUpMouseLeave');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setSubscribeEvent('MouseEnter', 'OnAlphaSetting_MouseEnter');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setSubscribeEvent('MouseLeave', 'OnAlphaSetting_MouseLeave');
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setClippedByParent(false)
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setAlwaysOnTop(true)

	-- setUserString
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar__'):setUserString("index", -1)
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_incbtn__'):setUserString("index", -1)
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_decbtn__'):setUserString("index", -1)
	winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setUserString("index", -1)
end



-- 마우스오버이벤트 윈도우
tMouseEventWinName = {['protecterr'] = 0,	"multichatBackground", "sj_emoticonTempImage", "chatTabBackground",
"chat_tab_allChat", "chat_tab_partyChat", "chat_tab_privateChat", "chat_tab_team", "chat_tab_system1",
"chat_tab_system2", "chat_tab_gang", "chat_tab_megaphone", "chat_tab_observer", "chat_tab_emoticon",
"ChatScrollbar_body", "ChatScrollbar_decbtn", "ChatScrollbar_incbtn", "ChatScrollbar_thumb",
"multichat_list_1", "multichat_list_2", "multichat_list_3",
"multichat_list_4", "multichat_list_5", "multichat_list_6",
"multichat_list_7", "multichat_list_8", "multichat_list_9", "multichat_list_10"
}

-- 알파값 조정 윈도우
tAlphaSettingWinName = {['protecterr'] = 0,	"multichatBackground", "sj_emoticonTempImage", "chatTabBackground",
"chat_tab_allChat", "chat_tab_partyChat", "chat_tab_privateChat", "chat_tab_team", "chat_tab_system1",
"chat_tab_system2", "chat_tab_gang", "chat_tab_megaphone", "chat_tab_observer", "chat_tab_emoticon",
"ChatScrollbar_body", "ChatScrollbar_decbtn", "ChatScrollbar_incbtn", "ChatScrollbar_thumb"
}


-- 위의 두개 배열에 이모티콘 추가
local CURRENT_MOUSEEVENT_WINDOW_NUM = #tMouseEventWinName+1
for i=CURRENT_MOUSEEVENT_WINDOW_NUM, MAX_EMOTICON+CURRENT_MOUSEEVENT_WINDOW_NUM-1 do	
	tMouseEventWinName[i] = "sj_emoticonBtn_"..(i-CURRENT_MOUSEEVENT_WINDOW_NUM)
end

local CURRENT_ALPHA_WINDOW_NUM = #tAlphaSettingWinName+1
for i=CURRENT_ALPHA_WINDOW_NUM, MAX_EMOTICON+CURRENT_ALPHA_WINDOW_NUM-1 do	
	tAlphaSettingWinName[i] = "sj_emoticonBtn_"..(i-CURRENT_ALPHA_WINDOW_NUM)
end


for i=1, #tMouseEventWinName do
	winMgr:getWindow(tMouseEventWinName[i]):setSubscribeEvent('MouseEnter', 'OnAlphaSetting_MouseEnter');
	winMgr:getWindow(tMouseEventWinName[i]):setSubscribeEvent('MouseLeave', 'OnAlphaSetting_MouseLeave');
end


-- 전체 WideType 조정을 위한 배열
CHAT_WIDETYPE_WINDOWS =
{
	['protecterr'] = 0, [0]="",
	"ChatBackground",
	"multichatBackground",
	"chatTabBackground",
	"chatPopupBackground",
	"doChattingBackground",
}


----------------------------------------------------------------------

-- function

----------------------------------------------------------------------

function Chatting_SetChatEnabled( b )
	
	if b == 1 or b == true then
		b = true
	else
		b = false
	end
	
	winMgr:getWindow('doChatting'):setEnabled( b )
	winMgr:getWindow("ChatCallPopup"):setEnabled( b )
	winMgr:getWindow("ChatSelectedPopup"):setEnabled( b )
	winMgr:getWindow("multichatBackground"):setEnabled( b )

end


function Chatting_InitChat()
	lockChatTabBackground = false
	g_bChatTabEnable = false

	-- 채팅창 활성화
	g_checktextstate = false
	ShowChatViewVisible(false)
	winMgr:getWindow('sj_emoticonTempImage'):setVisible(false)
	winMgr:getWindow('multichat_list_1'):setVisible(true)
	winMgr:getWindow('doChatting'):setText("")
	
	if winMgr:getWindow('doChatting'):isVisible() then
		winMgr:getWindow('doChatting'):activate()
	end
		
	Chatting_SetChatTabDefault()
	Chatting_SetChatPopupDefault()
	
	g_bUsePartyAsTeam = false
	
	winMgr:getWindow("ChatBackground"):setAlwaysOnTop(false)


	-- 스크롤바 초기화
	for i=1, COUNT_CHATTAB do
		winMgr:getWindow("multichatBackground"):removeChildWindow("multichat_list_" .. i)
		winMgr:getWindow("multichatBackground"):addChildWindow("multichat_list_" .. i)
		winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar__'):setSize(14, CHAT_DISPLAY_WINDOW_SIZEY)
		winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_incbtn__'):setSize(14, 17)
		winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_decbtn__'):setSize(14, 17)
		winMgr:getWindow('multichat_list_' .. i .. '__auto_vscrollbar____auto_thumb__'):setSize(14, 19)
	end
	
	if IsInitialized() then
		Util_SettingWinAlpha(tMouseEventWinName, 0) -- multichat_list를 투명하게 하기위해 여기서만 tMouseEventWinName을 알파윈도우 전달리스트로 사용한다
	end
end

function Chatting_SelectTab( index )

	if g_chatTab2[index] ~= 0 then
		
		g_SelectedTab = index;
		winMgr:getWindow(tChatTabName[index]):setProperty('Selected', 'True');
	end
end

function Chatting_SetChatTabDefault()
	Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_PARTY, CHATTYPE_PRIVATE, CHATTYPE_GANG, CHATTYPE_SYSTEM1, CHATTYPE_MEGAPHONE)
end

function Chatting_SetChatTabCnt( cnt )
	if 0 < cnt and cnt <= MAX_TABINDEX then
		g_chatTabCnt = cnt
	end
end

function Chatting_SetChatTabIndex( index, num )

	if index < 1 or g_chatTabCnt < index then
		return
	end
	
	-- 배치하려는 자리에 버튼이 있을경우 setVisible(false)
	if g_chatTab1[index] ~= 0 then
		winMgr:getWindow(tChatTabName[g_chatTab1[index]]):setVisible(false)
		g_chatTab2[g_chatTab1[index]] = 0
	end
	
	g_chatTab1[index] = num
	g_chatTab2[num] = index
	
	mywindow = winMgr:getWindow(tChatTabName[num])
	mywindow:setPosition(((index-1)*61), 0)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
end

function Chatting_SetChatTab( ... )

	local cnt = select('#', ...)
	
	if 0 < cnt and cnt <= MAX_TABINDEX then
	
		g_chatTabCnt = cnt
		g_chatTab1 = {0,0,0,0,0,0,0,0}
		g_chatTab2 = {0,0,0,0,0,0,0,0,0,0,0}
		
		for i = 1, COUNT_CHATTAB do
			winMgr:getWindow(tChatTabName[i]):setVisible(false)
		end
		
		for i = 1, cnt do  
			Chatting_SetChatTabIndex( i, select(i, ...) )
		end		
		
		Chatting_SelectTab( select(1, ...) )
	end
end



function Chatting_SetChatPopupDefault()
	Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PARTY, CHATTYPE_PRIVATE, CHATTYPE_GANG)
end

function Chatting_SetChatPopupCnt( cnt )
	if 0 < cnt and cnt <= MAX_POPUPINDEX then
		g_chatPopupCnt = cnt
	end
end

function Chatting_SetChatPopupIndex( index, num )

	if index < 1 or g_chatPopupCnt < index then
		return
	end
	
	
	-- 배치하려는 자리에 버튼이 있을경우 setVisible(false)
	if g_chatPopup1[index] ~= 0 then
--		winMgr:getWindow(Chat_PopupButtonName[ Chat_PopupTabIndex2[g_chatPopup1[index]] ]):setVisible(false)
		g_chatPopup2[g_chatPopup1[index]] = 0
	end
	
	g_chatPopup1[index] = num
	g_chatPopup2[num] = index
	
	
	mywindow = winMgr:getWindow(Chat_PopupButtonName[Chat_PopupTabIndex2[num]])
	mywindow:setPosition(0, (MAX_POPUPINDEX - index) * 18)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
end

function Chatting_SetChatPopup( ... )

	local cnt = select('#', ...)
	
	if 0 < cnt and cnt <= MAX_POPUPINDEX then
	
		g_chatPopupCnt = cnt
		g_chatPopup1 = {0,0,0,0,0,0}
		g_chatPopup2 = {0,0,0,0,0,0,0,0,0,0,0}
		
		for i = 1, MAX_POPUPINDEX do
			winMgr:getWindow(Chat_PopupButtonName[i]):setVisible(false)
		end
		
		for i = 1, cnt do  
			Chatting_SetChatPopupIndex( i, select(i, ...) )
		end
	end
end

function Chatting_SetPopupVisible( b )

	winMgr:getWindow("chatPopupBackground"):setVisible( b )
	
	if b == true then
		winMgr:getWindow("ChatCallPopup"):setTexture("Normal", "UIData/mainbarchat.tga", 158, 381)
		winMgr:getWindow("ChatCallPopup"):setTexture("Hover", "UIData/mainbarchat.tga", 158, 398)
		winMgr:getWindow("ChatCallPopup"):setTexture("Pushed", "UIData/mainbarchat.tga", 158, 415)
		winMgr:getWindow("ChatCallPopup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 158, 415)		
	else		
		winMgr:getWindow("ChatCallPopup"):setTexture("Normal", "UIData/mainbarchat.tga", 141, 381)
		winMgr:getWindow("ChatCallPopup"):setTexture("Hover", "UIData/mainbarchat.tga", 141, 398)
		winMgr:getWindow("ChatCallPopup"):setTexture("Pushed", "UIData/mainbarchat.tga", 141, 415)
		winMgr:getWindow("ChatCallPopup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 141, 415)
	end
end



function Chatting_SetUsePartyAsTeam( b )
	g_bUsePartyAsTeam = b
end

function Chatting_SetChatPosition( x, y )
	winMgr:getWindow('ChatBackground'):setPosition(x, y)
end

function Chatting_SetChatWideType( type )

	for i=1, #CHAT_WIDETYPE_WINDOWS do
		winMgr:getWindow(CHAT_WIDETYPE_WINDOWS[i]):setWideType(type)
	end
end


-- 스크롤바 visible 설정
function SetChatScrollVisible( b )
	winMgr:getWindow("ChatScrollbar_body"):setVisible(b)
	winMgr:getWindow("ChatScrollbar_decbtn"):setVisible(b)
	winMgr:getWindow("ChatScrollbar_incbtn"):setVisible(b)
	winMgr:getWindow("ChatScrollbar_thumb"):setVisible(b)
end


function OnSelected_Tab(args)
	local window = CEGUI.toWindowEventArgs(args).window;

	if CEGUI.toRadioButton(window):isSelected() == true then
		local index = tonumber(window:getUserString("index"))
		OnSelected_TabByIndex(index)
	end
end


-- 탭 버튼을 눌렀을 경우
function OnSelected_TabByIndex(index)

	-- 이모티콘 탭
	if index == CHATTYPE_EMOTICON and g_bGetOnVehicle == false then
		
		winMgr:getWindow('sj_emoticonTempImage'):setVisible(true)
		for i=0, MAX_EMOTICON-1 do		
			winMgr:getWindow("sj_emoticonBtn_"..i):setVisible(true)
			if tNewEmoticonCheckTable[i] then
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):setVisible(true)
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):activeMotion("EmoticonNewEvent")
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):setVisible(true)
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):activeMotion("EmoticonNewEvent")
			end
		end
		ShowChatViewVisible(false)
		winMgr:getWindow('multichat_list_1'):setVisible(false)
		winMgr:getWindow('doChatting'):setText("")
		if winMgr:getWindow('doChatting'):isVisible() then
			winMgr:getWindow('doChatting'):activate()
		end
	else
		winMgr:getWindow('sj_emoticonTempImage'):setVisible(false)
		ShowChatViewVisible(false)
		
		winMgr:getWindow('multichat_list_' .. index):setVisible(true)
		
		winMgr:getWindow('doChatting'):setText("")
		if winMgr:getWindow('doChatting'):isVisible() then
			winMgr:getWindow('doChatting'):activate()
		end
	end

	g_SelectedTab = index;
			
	
	-- 스크롤바가 필요하면 visible을 true로
	if g_bChatTabEnable == true and winMgr:getWindow("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__"):isVisible() == true then
		SetChatScrollVisible( true )
	else
		SetChatScrollVisible( false )
	end

	-- 팝업 갱신
	Chatting_SetChatSelectedPopup( index )
end


-- 광장 팝업 선택시
function OnSelected_Popup(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		index = tonumber(local_window:getUserString("index"))
		Chatting_SetPopupVisible(false)
		Chatting_SetChatSelectedPopup( Chat_PopupTabIndex1[index] )
	end
end

-- 팝업 ChatSelectedPopup 변경
function Chatting_SetChatSelectedPopup( type )

	local avail = false
	
	for i = 1, g_chatPopupCnt do
		if g_chatPopup1[i] == type then
			avail = true
			break
		end
	end
	
	if avail == false then
		return
	end

	g_SelectedPopupTab = type
	
	if g_SelectedPopupTab ~= CHATTYPE_PRIVATE then
		winMgr:getWindow('ChatSelectedPopup'):setTexture('Enabled', 'UIData/mainbarchat.tga',	0, Chat_PopupTexurePosY[Chat_PopupTabIndex2[type]])
		winMgr:getWindow('ChatSelectedPopup'):setTexture('Disabled', 'UIData/mainbarchat.tga',	0, Chat_PopupTexurePosY[Chat_PopupTabIndex2[type]])
	else
		winMgr:getWindow('ChatSelectedPopup'):setTexture('Enabled', 'UIData/invisible.tga',	0, 0)
		winMgr:getWindow('ChatSelectedPopup'):setTexture('Disabled', 'UIData/invisible.tga',0, 0)
	end

	if winMgr:getWindow('doChatting'):isVisible() then
		if g_SelectedPopupTab ~= CHATTYPE_PRIVATE then
			winMgr:getWindow('PrivateChatting'):setVisible(false)
			winMgr:getWindow('doChatting'):activate()
		else
			winMgr:getWindow('PrivateChatting'):setVisible(true)
			winMgr:getWindow('PrivateChatting'):activate()
		end
	end
end


--탭 컨트롤 사용시
function ChangeChatPopupTab()

	if winMgr:getWindow('doChatting'):isActive() == true or g_bChatTabEnable == true or winMgr:getWindow('PrivateChatting'):isActive() == true then
		
		local index
		
		for i = 1, g_chatPopupCnt do
			if g_SelectedPopupTab == g_chatPopup1[i] then
				index = i
				break;
			end
		end
		
		if index == g_chatPopupCnt then
			index = 1
		else
			index = index + 1
		end
		
		Chatting_SetChatSelectedPopup( g_chatPopup1[index] )

	end
	
end



--채팅 팝업 버튼 클릭시 보이기/감추기
function Chatting_OnTextAccepted_callPopup()
	if winMgr:getWindow('chatPopupBackground'):isVisible() then
		Chatting_SetPopupVisible(false)
	else
	
		Chatting_SetPopupVisible(true)
	end
end


-- 일반 채팅창 visible 설정
function ShowChatViewVisible(bVisible)

	for i = 1, COUNT_CHATTAB do
		winMgr:getWindow('multichat_list_' .. i):setVisible(bVisible)
	end
	
	--root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
	if winMgr:getWindow('pu_btnContainer') ~= nil then
		local root = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow")
		root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	end
end


function OnRootKeyUpChatting()	

	if winMgr:getWindow('doChatting'):isDisabled() == true then
		return
	end
	
	if winMgr:getWindow('doChatting'):isVisible() == false then
		
		if g_editboxByParty then
			g_editboxByParty = false
		else
			if g_EnterEventState == false then
				Chatting_SetChatEditVisible(true)
			else
				g_EnterEventState = false
			end
		end
	else
		if g_editboxByParty then
			g_editboxByParty = false
		else
			if g_continueChat == false and winMgr:getWindow('doChatting'):isActive() then
				Chatting_SetChatEditVisible(false)
			else
				winMgr:getWindow('doChatting'):activate();
			end
		end
	end
	
end

--root:subscribeEvent("KeyUp", "OnRootKeyUp");

function OnTextAcceptedPrivateChatting()
	g_continueChat = true
	winMgr:getWindow("doChatting"):activate()
end


function Offcontroller()
	Chatting_SetPopupVisible(false)
	winMgr:getWindow("ChatCallPopup"):setVisible(false)
	winMgr:getWindow("ChatSelectedPopup"):setVisible(false)
	winMgr:getWindow("doChattingBackground"):setVisible(false)
	winMgr:getWindow("ChatBackground"):setVisible(false)	
end

function Oncontroller()
	winMgr:getWindow("doChattingBackground"):setVisible(true)
	winMgr:getWindow("ChatBackground"):setVisible(true)
end




function Chatting_SetChatEditVisible( b )
	
	if b == true or b == 1 then
		winMgr:getWindow('doChattingBackground'):setVisible(true)
		winMgr:getWindow('doChatting'):setVisible(true)
		winMgr:getWindow("ChatCallPopup"):setVisible(true)
		winMgr:getWindow("ChatSelectedPopup"):setVisible(true)
		winMgr:getWindow("ChatLanguage"):setVisible(true)
		winMgr:getWindow('doChatting'):activate()		
		if g_SelectedPopupTab == CHATTYPE_PRIVATE then
			winMgr:getWindow("PrivateChatting"):setVisible(true)
		end		
	else
		winMgr:getWindow('doChattingBackground'):setVisible(false);
		winMgr:getWindow('doChatting'):setVisible(false);
		winMgr:getWindow("ChatCallPopup"):setVisible(false)
		winMgr:getWindow("ChatSelectedPopup"):setVisible(false)
		winMgr:getWindow("PrivateChatting"):setVisible(false)
		winMgr:getWindow("ChatLanguage"):setVisible(false)
		winMgr:getWindow('doChatting'):deactivate();
		winMgr:getWindow('chatPopupBackground'):setVisible(false)
	end
	
end


-- 광장 이벤트
function OnChatPublicWithName(name, message, chatType, specialType, ...)
	DebugStr('message1:'..message)
	--ShowNotifyOKMessage_Lua(message)
	--ShowNotifyOKMessage_Lua(chatType)
	--ShowNotifyOKMessage_Lua(specialType)

	--ShowNotifyOKMessage_Lua(" mes " .. message .. " ctype " .. chatType .. " stype " .. specialType)

	-- 쏘셜액션일 경우는 채팅창에 나오지 않는다
	local chat = string.find(message, "/")
	if chat == 1 then
		return
	end
	
	local view_name = '';
	if name == '' then -- 이름이 빈칸으로 왔으면
		view_name = '';
	else
		view_name = '['..name..']'..' : ';
	end
	
	-- 1:1 거래중에 귓속말이 올경우
	if winMgr:getWindow('sj_MyDealAlphaImage') ~= nil and winMgr:getWindow('sj_MyDealAlphaImage'):isVisible() and chatType == CHATTYPE_PRIVATE then
		local realName = string.sub(name, 6, string.len(name))
		
		if string.sub(realName, 1, 4) == '<ZM>' then
			realName = string.sub(realName, 5, string.len(realName))
		end

		if string.sub(realName, 1, 8) == '<Sultan>' then
			realName = string.sub(realName, 9, string.len(realName))
		end
		
		if	realName == winMgr:getWindow('sj_MyDealRegistItemList_Name_You'):getText() or string.sub(name, 1, 2) == 'To' then
			OnChatPrivateMyDeal(view_name, message)
			return
		end
	end
	
	-------------------------------
	-- 시스템 메세지 영역
	-------------------------------
	
	local tFontData = {['err']=0, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 0,0,0,255}		-- 기본 폰트 데이터
	local ResultMsg = ""
	
	
	if chatType == 5 then	-- 5:시스템채팅(지정색)
		local system_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_1'));	
		
		local multi_line_text5 = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_5'));
		if multi_line_text5:getLineCount() > 50 then
			multi_line_text5:removeLine(0);
		end	
		
		if select('#', ...) == 0 then  
			
			tFontData = ChatGMFontData
			ResultMsg = view_name..message..'\n'

		else			
			local _chatType = select(1, ...)
			if _chatType == CHATTYPE_ILLEGAL then	-- 0: 불법채팅(빨강)
				tFontData = ChatWarnningFontData
				ResultMsg = message..'\n'
			elseif _chatType == CHATTYPE_ALL then	-- 1:일반채팅(흰색)
				tFontData = ChatNormalFontData
				ResultMsg = view_name..message..'\n'
					
			elseif _chatType == CHATTYPE_PARTY then	-- 2:파티채팅(파란색)
				tFontData = ChatPartyFontData
				ResultMsg = view_name..message..'\n'
				
			elseif _chatType == CHATTYPE_PRIVATE then	-- 3:귓속말(녹색)
				tFontData = ChatWhisperFontData
				ResultMsg = view_name..message..'\n'
							
			elseif _chatType == CHATTYPE_TEAM then	-- 4:팀채팅(파란색)
				if g_bUsePartyAsTeam then
					tFontData = ChatPartyFontData
				else
					tFontData = ChatTeamFontData
				end
				ResultMsg = view_name..message..'\n'
									
			elseif _chatType == CHATTYPE_SYSTEM2 then	-- 6:시스템 메세지2(금색)
				tFontData = ChatSystem2FontData
				ResultMsg = view_name..message..'\n'
									
			elseif _chatType == CHATTYPE_GANG then	-- 7:클럽채팅(연자주색)
				tFontData = ChatGangFontData
				ResultMsg = view_name..message..'\n'

			end
		end
		
		if specialType == 1 then 
			tFontData = ChatSpecialMegaPhoneFontData 
		elseif specialType == 2 then 
			tFontData = SpecialSultanFontData 
		end
		
		--ShowNotifyOKMessage_Lua("R " .. tFontData[3] .. " B " .. tFontData[4] .. " G " .. tFontData[5])

--		system_line_text:addTextExtends(ResultMsg,tFontData[1],tFontData[2], tFontData[3],tFontData[4],
--			tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);

		local multiToken = string.find(ResultMsg, "\n")
		local len = string.len(ResultMsg);
		
		if multiToken ~= len then
			multi_line_text5:addTextExtends(string.sub(ResultMsg, 1, multiToken),tFontData[1],tFontData[2],tFontData[3],tFontData[4],
				tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
			multi_line_text5:addTextExtends(string.sub(ResultMsg, multiToken+1, len),tFontData[1],tFontData[2],tFontData[3],tFontData[4],
				tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
		else
			multi_line_text5:addTextExtends(ResultMsg,tFontData[1],tFontData[2],tFontData[3],tFontData[4],
				tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);			
		end
	end
	
	
	-------------------------------
	-- 일반 채팅영역
	-------------------------------
	local multi_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_1'));	
	if multi_line_text:getLineCount() > 50 then
		multi_line_text:removeLine(0);
	end	
	
	if chatType == -1 then		-- 1: 자신(흰색)
		tFontData = ChatMySelfFontData
		ResultMsg = view_name..message..'\n'
		
		if specialType == 1 then 
			tFontData = ChatSpecialMegaPhoneFontData 
		elseif specialType == 2 then
			tFontData = SpecialSultanFontData
		end
		
		multi_line_text:addTextExtends(ResultMsg,tFontData[1],tFontData[2], 
			tFontData[3],tFontData[4],tFontData[5],tFontData[6], tFontData[7], 
			tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
	else
		if chatType <= #tCommonChatFontData then
			if chatType == CHATTYPE_ILLEGAL then
				ResultMsg = message..'\n'
			else
				ResultMsg = view_name..message..'\n'
			end
			tFontData = tCommonChatFontData[chatType]
			
			if specialType == 1 then
				if chatType == 3 then
					tFontData = SpecialZMFontData 
				else
					tFontData = ChatSpecialMegaPhoneFontData 
				end				
			elseif specialType == 2 then
				tFontData = SpecialSultanFontData
			end
			
			
			local multiToken = string.find(ResultMsg, "\n")
			local len = string.len(ResultMsg);

			--ShowNotifyOKMessage_Lua("2R " .. tFontData[3] .. " B " .. tFontData[4] .. " G " .. tFontData[5])
			
			if multiToken ~= len then
				multi_line_text:addTextExtends(string.sub(ResultMsg, 1, multiToken),tFontData[1],tFontData[2],tFontData[3],tFontData[4],
					tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
				multi_line_text:addTextExtends(string.sub(ResultMsg, multiToken+1, len),tFontData[1],tFontData[2],tFontData[3],tFontData[4],
					tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
			else
				multi_line_text:addTextExtends(ResultMsg,tFontData[1],tFontData[2],tFontData[3],tFontData[4],
					tFontData[5],tFontData[6], tFontData[7], tFontData[8],tFontData[9],tFontData[10],tFontData[11]);			
			end		
		end
	end
	
	
	-----------------------------------------
	-- 파티말 일경우 파티탭에도 글을 쓴다.
	-----------------------------------------
	local eachTextWindow
	

	if chatType == CHATTYPE_PARTY then
		eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_2'));
		tFontData = ChatPartyFontData

	-----------------------------------------
	-- 귓속말 일경우 귓속말탭에도 글을 쓴다.
	-----------------------------------------
	elseif chatType == CHATTYPE_PRIVATE then
		eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_3'));		
		tFontData = ChatWhisperFontData		
		
		if specialType == 1 then
			tFontData = SpecialZMFontData 
		elseif specialType == 2 then
			tFontData = SpecialSultanFontData
		end

	-----------------------------------------
	-- 팀채팅 일경우 팀탭에도 글을 쓴다.
	-----------------------------------------
	elseif chatType == CHATTYPE_PARTY then
		if g_bUsePartyAsTeam then
			eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_2'));
			tFontData = ChatPartyFontData
		else
			eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_4'));
			tFontData = ChatTeamFontData
		end
	
	-----------------------------------------
	-- 갱 탭일 경우 갱에 글을쓴다
	-----------------------------------------		
	elseif chatType == CHATTYPE_GANG then
		eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_7'));		
		tFontData = ChatGangFontData		
		
	-----------------------------------------
	-- 메가폰
	-----------------------------------------		
	elseif chatType == CHATTYPE_MEGAPHONE then --or chatType == CHATTYPE_OBSERVER then
		eachTextWindow = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_8'));		
		if chatType == CHATTYPE_MEGAPHONE then
			tFontData = ChatMegaPhoneFontData			
		else
			tFontData = ChatSpecialMegaPhoneFontData			
		end	
	else
		return
	end
	
	if eachTextWindow:getLineCount() > 50 then
		eachTextWindow:removeLine(0);
	end	
	
	if specialType == 1 then 
		tFontData = ChatSpecialMegaPhoneFontData 
	elseif specialType == 2 then 
		tFontData = SpecialSultanFontData 
	end
	
	eachTextWindow:addTextExtends(view_name..message..'\n',tFontData[1],tFontData[2],
		tFontData[3],tFontData[4],tFontData[5],tFontData[6],tFontData[7], 
		tFontData[8],tFontData[9],tFontData[10],tFontData[11])
end



-- 채팅 테이블에 입력
function OnChatPublic(message, chatType, specialType)
	DebugStr('message2:'..message)

	--ShowNotifyOKMessage_Lua(" mes " .. message .. " ctype " .. chatType .. " stype " .. specialType)

	local multi_line_text = {}
	
	for i=1, COUNT_CHATTAB do
	
		multi_line_text[i] = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_' .. i));
		
		if multi_line_text[i]:getLineCount() > 50 then
			multi_line_text[i]:removeLine(0);
		end
	end
	
	-- 1:1 거래중에 귓속말이 올경우
	-- 광장만 가능
--[[
	if winMgr:getWindow('sj_MyDealAlphaImage'):isVisible() and chatType == CHATTYPE_PRIVATE then
		OnChatPrivateMyDeal2(message)
		return
	end
]]

	if chatType == -1 then		-- -1: 자신(흰색)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatMySelfFontData[1],ChatMySelfFontData[2],
			ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],ChatMySelfFontData[6],
			ChatMySelfFontData[7], 
			ChatMySelfFontData[8],ChatMySelfFontData[9],ChatMySelfFontData[10],ChatMySelfFontData[11]);
	
	elseif chatType == CHATTYPE_ILLEGAL then	-- 0: 불법채팅(빨강)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatWarnningFontData[1],ChatWarnningFontData[2],
			ChatWarnningFontData[3],ChatWarnningFontData[4],ChatWarnningFontData[5],ChatWarnningFontData[6],
			ChatWarnningFontData[7], 
			ChatWarnningFontData[8],ChatWarnningFontData[9],ChatWarnningFontData[10],ChatWarnningFontData[11]);
			
		multi_line_text[CHATTYPE_OBSERVER]:addTextExtends(message..'\n',ChatWarnningFontData[1],ChatWarnningFontData[2],
			ChatWarnningFontData[3],ChatWarnningFontData[4],ChatWarnningFontData[5],ChatWarnningFontData[6],
			ChatWarnningFontData[7], 
			ChatWarnningFontData[8],ChatWarnningFontData[9],ChatWarnningFontData[10],ChatWarnningFontData[11]);
	
	elseif chatType == CHATTYPE_ALL then	-- 1:일반채팅(흰색)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatNormalFontData[1],ChatNormalFontData[2],
			ChatNormalFontData[3],ChatNormalFontData[4],ChatNormalFontData[5],ChatNormalFontData[6],
			ChatNormalFontData[7], 
			ChatNormalFontData[8],ChatNormalFontData[9],ChatNormalFontData[10],ChatNormalFontData[11]);

	elseif chatType == CHATTYPE_PARTY or (g_bUsePartyAsTeam and chatType == CHATTYPE_TEAM) then	-- 2:파티채팅(파란색)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatPartyFontData[1],ChatPartyFontData[2],
			ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],ChatPartyFontData[6],
			ChatPartyFontData[7], 
			ChatPartyFontData[8],ChatPartyFontData[9],ChatPartyFontData[10],ChatPartyFontData[11]);
			
		multi_line_text[CHATTYPE_OBSERVER]:addTextExtends(message..'\n',ChatPartyFontData[1],ChatPartyFontData[2],
			ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],ChatPartyFontData[6],
			ChatPartyFontData[7], 
			ChatPartyFontData[8],ChatPartyFontData[9],ChatPartyFontData[10],ChatPartyFontData[11]);
			
		multi_line_text[CHATTYPE_PARTY]:addTextExtends(message..'\n',ChatPartyFontData[1],ChatPartyFontData[2],
			ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],ChatPartyFontData[6],
			ChatPartyFontData[7], 
			ChatPartyFontData[8],ChatPartyFontData[9],ChatPartyFontData[10],ChatPartyFontData[11]);
		
	elseif chatType == CHATTYPE_PRIVATE then	-- 3:귓속말(녹색)

		local tFontData = ChatWhisperFontData		
		
		if specialType == 1 then
			tFontData = SpecialZMFontData 
		elseif specialType == 2 then
			tFontData = SpecialSultanFontData
		end	
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',tFontData[1],tFontData[2],
			tFontData[3],tFontData[4],tFontData[5],tFontData[6],
			tFontData[7], 
			tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
			
		multi_line_text[CHATTYPE_PRIVATE]:addTextExtends(message..'\n',tFontData[1],tFontData[2],
			tFontData[3],tFontData[4],tFontData[5],tFontData[6],
			tFontData[7], 
			tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
		
	elseif chatType == CHATTYPE_TEAM then	-- 4:팀채팅(보라색) multi_line_text2
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatTeamFontData[1],ChatTeamFontData[2],
			ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],ChatTeamFontData[6],
			ChatTeamFontData[7], 
			ChatTeamFontData[8],ChatTeamFontData[9],ChatTeamFontData[10],ChatTeamFontData[11]);

		multi_line_text[CHATTYPE_OBSERVER]:addTextExtends(message..'\n',ChatTeamFontData[1],ChatTeamFontData[2],
			ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],ChatTeamFontData[6],
			ChatTeamFontData[7],
			ChatTeamFontData[8],ChatTeamFontData[9],ChatTeamFontData[10],ChatTeamFontData[11]);
					
		multi_line_text[CHATTYPE_TEAM]:addTextExtends(message..'\n',ChatTeamFontData[1],ChatTeamFontData[2],
			ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],ChatTeamFontData[6],
			ChatTeamFontData[7],
			ChatTeamFontData[8],ChatTeamFontData[9],ChatTeamFontData[10],ChatTeamFontData[11]);
		
	elseif chatType == CHATTYPE_SYSTEM1 then	-- 5:시스템채팅(지정색)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatSystem2FontData[1],ChatSystem2FontData[2], 
			ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],ChatSystem2FontData[6],
			ChatSystem2FontData[7], 
			ChatSystem2FontData[8],ChatSystem2FontData[9],ChatSystem2FontData[10],ChatSystem2FontData[11])
		
		multi_line_text[CHATTYPE_SYSTEM1]:addTextExtends(message..'\n',ChatSystem2FontData[1],ChatSystem2FontData[2], 
			ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],ChatSystem2FontData[6],
			ChatSystem2FontData[7], 
			ChatSystem2FontData[8],ChatSystem2FontData[9],ChatSystem2FontData[10],ChatSystem2FontData[11])
		
	elseif chatType == CHATTYPE_SYSTEM2 then	-- 6:시스템2채팅(지정색)
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatSystem2FontData[1],ChatSystem2FontData[2], 
			ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],ChatSystem2FontData[6],
			ChatSystem2FontData[7], 
			ChatSystem2FontData[8],ChatSystem2FontData[9],ChatSystem2FontData[10],ChatSystem2FontData[11])
		
		multi_line_text[CHATTYPE_SYSTEM1]:addTextExtends(message..'\n',ChatSystem2FontData[1],ChatSystem2FontData[2], 
			ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],ChatSystem2FontData[6],
			ChatSystem2FontData[7], 
			ChatSystem2FontData[8],ChatSystem2FontData[9],ChatSystem2FontData[10],ChatSystem2FontData[11])
		
	elseif chatType == CHATTYPE_GANG then	-- 7:갱매세지(연보라색) multi_line_text3
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatGangFontData[1],ChatGangFontData[2], 
			ChatGangFontData[3],ChatGangFontData[4],ChatGangFontData[5],ChatGangFontData[6],
			ChatGangFontData[7],   
			ChatGangFontData[8],ChatGangFontData[9],ChatGangFontData[10],ChatGangFontData[11]);
			
		multi_line_text[CHATTYPE_GANG]:addTextExtends(message..'\n',ChatGangFontData[1],ChatGangFontData[2],
			ChatGangFontData[3],ChatGangFontData[4],ChatGangFontData[5],ChatGangFontData[6],
			ChatGangFontData[7], 
			ChatGangFontData[8],ChatGangFontData[9],ChatGangFontData[10],ChatGangFontData[11]);

	elseif chatType == CHATTYPE_MEGAPHONE then	-- 메가폰
		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',ChatMegaPhoneFontData[1],ChatMegaPhoneFontData[2], 
			ChatMegaPhoneFontData[3],ChatMegaPhoneFontData[4],ChatMegaPhoneFontData[5],ChatMegaPhoneFontData[6],
			ChatMegaPhoneFontData[7],
			ChatMegaPhoneFontData[8],ChatMegaPhoneFontData[9],ChatMegaPhoneFontData[10],ChatMegaPhoneFontData[11]);
		
		multi_line_text[CHATTYPE_MEGAPHONE]:addTextExtends(message..'\n',ChatMegaPhoneFontData[1],ChatMegaPhoneFontData[2], 
			ChatMegaPhoneFontData[3],ChatMegaPhoneFontData[4],ChatMegaPhoneFontData[5],ChatMegaPhoneFontData[6],
			ChatMegaPhoneFontData[7],
			ChatMegaPhoneFontData[8],ChatMegaPhoneFontData[9],ChatMegaPhoneFontData[10],ChatMegaPhoneFontData[11]);
		
	elseif chatType == CHATTYPE_OBSERVER then	-- 점령전에서는 관전자 채팅
		multi_line_text[CHATTYPE_OBSERVER]:addTextExtends(message..'\n',ChatObserverFontData[1],ChatObserverFontData[2], 
			ChatObserverFontData[3],ChatObserverFontData[4],ChatObserverFontData[5],ChatObserverFontData[6],
			ChatObserverFontData[7], 
			ChatObserverFontData[8],ChatObserverFontData[9],ChatObserverFontData[10],ChatObserverFontData[11])
			
	elseif chatType == 10 then	-- 스페셜 메가폰

		local tFontData = ChatSpecialMegaPhoneFontData		
		
		if specialType == 1 then
			tFontData = SpecialZMFontData 
		elseif specialType == 2 then
			tFontData = SpecialSultanFontData
		end	

		multi_line_text[CHATTYPE_ALL]:addTextExtends(message..'\n',tFontData[1],tFontData[2], 
		tFontData[3],tFontData[4],tFontData[5],tFontData[6],
		tFontData[7],
		tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
		
		multi_line_text[CHATTYPE_MEGAPHONE]:addTextExtends(message..'\n',tFontData[1],tFontData[2], 
		tFontData[3],tFontData[4],tFontData[5],tFontData[6],
		tFontData[7],
		tFontData[8],tFontData[9],tFontData[10],tFontData[11]);
	end
	
end

-- 공통 부분
function _OnTextAccepted()

	local accept_text = winMgr:getWindow("doChatting"):getText();
	local private_text = winMgr:getWindow("PrivateChatting"):getText();
	
	ChatMsgListSave(accept_text)
	g_MsgCount = 0
	
	if g_chatTab2[CHATTYPE_OBSERVER] ~= 0 and
		(g_myFieldState == STATE_OBSERVER or g_myFieldState == STATE_ENABLE_PLAY) then
		SendObserverChatMsg(accept_text);
		winMgr:getWindow('doChatting'):setText("");
	else
		if g_SelectedPopupTab == CHATTYPE_ALL then
			SendPublicChatMsg(accept_text);
			winMgr:getWindow('doChatting'):setText("");
		
		-- 파티채팅
		elseif g_SelectedPopupTab == CHATTYPE_PARTY then
			if g_bUsePartyAsTeam then
				SendPublicChatMsg("/t "..accept_text);
			else
				SendPartyChat("/p "..accept_text);
			end
			winMgr:getWindow('doChatting'):setText("")
			
		-- 귓속말 채팅
		elseif g_SelectedPopupTab == CHATTYPE_PRIVATE then
			DebugStr("private_text : " .. private_text)
			if private_text ~= "" then
				SendPrivateMsg("/w "..private_text.." "..accept_text);
				winMgr:getWindow('doChatting'):setText("")
			end
		
		-- 클럽(갱) 채팅
		elseif g_SelectedPopupTab == CHATTYPE_GANG then
			SendClubChat("/g "..accept_text);
			winMgr:getWindow('doChatting'):setText("")
		
		-- 팀 채팅
		elseif g_SelectedPopupTab == CHATTYPE_TEAM then
			SendPublicChatMsg("/t "..accept_text);
			winMgr:getWindow('doChatting'):setText("")
		end
	end

	-- 스크롤바가 필요하면 visible을 true로
	if g_bChatTabEnable == true and winMgr:getWindow("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__"):isVisible() == true then
		SetChatScrollVisible( true )
	end

end

-- 광장 엔터
function Chatting_OnTextAccepted1(args)
	
	if winMgr:getWindow("doChatting"):getText() == "" then
		g_continueChat = false
		return
	else
		g_continueChat = true
	end
	
	_OnTextAccepted()
	
	g_ChatActive = false;
	g_UseMaxMap = false;	
end

-- 로비, 배틀룸
function Chatting_OnTextAccepted2(args)
	
	local accept_text = winMgr:getWindow("doChatting"):getText();
	if winMgr:getWindow("doChatting"):getText() == "" then
		winMgr:getWindow("doChatting"):deactivate()
		return
	end
	
	_OnTextAccepted()
	
end

-- 게임
function Chatting_OnTextAccepted3(args)
	
	_OnTextAccepted()
	Chatting_SetChatEditVisible(false)
	
end

function Chatting_SetChatTextAccepted( func )
	winMgr:getWindow('doChatting'):setSubscribeEvent("TextAccepted", func);
end

function Chatting_SetChatEditEvent( index )
	Chatting_SetChatTextAccepted( "Chatting_OnTextAccepted" .. index )
end


-- 현재 한글, 영문모드 인지
function Chatting_SetLanguage(mode)

	if winMgr:getWindow('doChattingBackground'):isVisible() then
		
		-- 한글, 영문 모드
		if mode == true or mode == 1 then
			winMgr:getWindow("ChatLanguage"):setTexture("Enabled", "UIData/mainbarchat.tga", 174, 381)
		else
			winMgr:getWindow("ChatLanguage"):setTexture("Enabled", "UIData/mainbarchat.tga", 174, 398)
		end
	end
end



-- 이모티콘 이벤트
function OnClickedEmoticon(args)	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(local_window:getUserString("index"))
	PlaySocialAction(tEmoticonActionName[index])
end


-- 마우스가 윈도우에 들어왔을 때
function OnAlphaSetting_MouseEnter(args)
	
	window = CEGUI.toWindowEventArgs(args).window
	local IndexString = window:getUserString("index")
	
	-- 이모티콘 말풍선
	if IndexString ~= nil then
	
		s, e = string.find(window:getName(), "sj_emoticonBtn_")
		if s ~= nil then
			local index = tonumber(IndexString)
			if index >= 0 then
				tEmoticonTooltipVisible[index] = true
			end	
		end
	end
	
	g_bChatTabEnable = true
	
	-- 스크롤바를 그려야한다면 그려준다
	if winMgr:getWindow("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__"):isVisible() == true then
		SetChatScrollVisible( true )
	end
	
end

-- 마우스가 윈도우에서 떠났을 때
function OnAlphaSetting_MouseLeave(args)
	if lockChatTabBackground == true then
		return
	end
	
	window = CEGUI.toWindowEventArgs(args).window
	local IndexString = window:getUserString("index")
	
	-- 이모티콘 말풍선
	if IndexString ~= nil then
	
		s, e = string.find(window:getName(), "sj_emoticonBtn_")
		if s ~= nil then
			local index = tonumber(IndexString)
			if index >= 0 then
				tEmoticonTooltipVisible[index] = false
			end	
		end
	end
	
	g_bChatTabEnable = false

	if winMgr:getWindow("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__"):isVisible() == true then
		SetChatScrollVisible( false )
	end
end



-- 채팅창 Alpha 설정
function Util_SettingWinAlpha(winsName, palpha)
	for i=1, #winsName do
		winMgr:getWindow(winsName[i]):setAlpha(palpha)
	end
	if palpha == 0 then
		for i=0, #tNewEmoticonCheckTable do		
			if tNewEmoticonCheckTable[i] then
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):setVisible(false)
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):clearActiveController()
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):setVisible(false)
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):clearActiveController()
			end
		end
	else
		for i=0, #tNewEmoticonCheckTable do		
			if tNewEmoticonCheckTable[i] then
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):setVisible(true)
				winMgr:getWindow("sj_emoticonBtn_FirstNew"..i):activeMotion("EmoticonNewEvent")
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):setVisible(true)
				winMgr:getWindow("sj_emoticonBtn_SecondNew"..i):activeMotion("EmoticonNewEvent")
			end
		end
	end
end


-- 스크롤바 그리기
function Chatting_renderChat()

	-- 채팅창 알파값 서서히 바뀌게 하기
	if g_bChatTabEnable == true and g_nAlpha < 255 then
	
		g_nAlpha = g_nAlpha + SPEED_ALPHA
		if g_nAlpha > 255 then
			g_nAlpha = 255
		end
		
		Util_SettingWinAlpha(tAlphaSettingWinName, g_nAlpha)
		
	elseif g_bChatTabEnable == false and g_nAlpha > 0 then
	
		g_nAlpha = g_nAlpha - SPEED_ALPHA
		if g_nAlpha < 0 then
			g_nAlpha = 0
		end
	
		Util_SettingWinAlpha(tAlphaSettingWinName, g_nAlpha)
	end
	
	scrollWindow = winMgr:getWindow("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__")
	
	if g_bChatTabEnable == true and scrollWindow:isVisible() == true then
	
		top1, bottom1, left1, right1 = GetCEGUIWindowRect("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar____auto_thumb__")
		top2, bottom2, left2, right2 = GetCEGUIWindowRect("multichat_list_" .. g_SelectedTab .. "__auto_vscrollbar__")
		winMgr:getWindow("ChatScrollbar_thumb"):setPosition(-2, top1-top2+1)		
	end
	
end

function OnChatScrollUpMouseEnter( args )
	winMgr:getWindow("ChatScrollbar_decbtn"):setTexture("Enabled", "UIData/mainbarchat.tga", 988, 376)
	winMgr:getWindow("ChatScrollbar_decbtn"):setTexture("Disabled", "UIData/mainbarchat.tga", 988, 376)
	OnAlphaSetting_MouseEnter(args)
end

function OnChatScrollUpMouseLeave( args )
	winMgr:getWindow("ChatScrollbar_decbtn"):setTexture("Enabled", "UIData/mainbarchat.tga", 988, 359)
	winMgr:getWindow("ChatScrollbar_decbtn"):setTexture("Disabled", "UIData/mainbarchat.tga", 988, 359)
	OnAlphaSetting_MouseLeave(args)
end

function OnChatScrollDownMouseEnter( args )
	winMgr:getWindow("ChatScrollbar_incbtn"):setTexture("Enabled", "UIData/mainbarchat.tga", 1000, 376)
	winMgr:getWindow("ChatScrollbar_incbtn"):setTexture("Disabled", "UIData/mainbarchat.tga", 1000, 376)
	OnAlphaSetting_MouseEnter(args)
end

function OnChatScrollDownMouseLeave( args )
	winMgr:getWindow("ChatScrollbar_incbtn"):setTexture("Enabled", "UIData/mainbarchat.tga", 1000, 359)
	winMgr:getWindow("ChatScrollbar_incbtn"):setTexture("Disabled", "UIData/mainbarchat.tga", 1000, 359)
	OnAlphaSetting_MouseLeave(args)
end


------------------------------------------------

-- 소셜액션 이모티콘 말풍선 그리기

------------------------------------------------
function EndRenderEmoticonTooltip(args)
	
	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	local position = window:getPosition()
	local back_window = winMgr:getWindow('multichatBackground')	
	if back_window ~= nil then
		local tempWinPos = winMgr:getWindow('ChatBackground'):getPosition() + winMgr:getWindow('multichatBackground'):getPosition()
		local posX = position.x.offset + parentPos.x.offset + tempWinPos.x.offset + 20
		local posY = position.y.offset + parentPos.y.offset + tempWinPos.y.offset + 34
		RenderEmoticonTooltip(index, 1, posX, posY, tEmoticonActionName[index])
	end
end

function RenderEmoticonTooltip(index, tailPos, px, py, tooltipText)

	if tEmoticonTooltipVisible[index] == false then
		return
	end
	
	local real_str_chat = tooltipText;
	if string.len(real_str_chat) <= 0 then
		return
	end
			
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 12)
	local text_area_x = twidth
	local text_area_y = theight
	local text_area_zoom_x, text_area_zoom_y = GetTextAreaZoomValue(text_area_x, text_area_y, 7)
	
	-- 가운데 정렬 하기
	local ctrl_x = px-(7+7+text_area_x)/2;
	local ctrl_y = py-text_area_y-50;

	local zoom_x = 255
	local zoom_y = 255
	local alpha_value = 200

	drawer = root:getDrawer()
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y, 7, 7, 263, 65, zoom_x, zoom_y, alpha_value, 0, 0);								-- top_left
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y, 7, 7, 309, 65, zoom_x, zoom_y, alpha_value, 0, 0);				-- top_right
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y+7+text_area_y, 7, 7, 263, 87, zoom_x, zoom_y, alpha_value, 0, 0);				-- bottom_left
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y+7+text_area_y, 7, 7, 309, 87, zoom_x, zoom_y, alpha_value, 0, 0);	-- bottom_right
	
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y, 7, 7, 263+7, 65, text_area_zoom_x, zoom_y, alpha_value, 0, 0)					-- top_edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y+7+text_area_y, 7, 7, 263+7, 87, text_area_zoom_x, zoom_y, alpha_value, 0, 0)	-- bottom_edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y+7, 7, 7, 263, 65+7, zoom_x, text_area_zoom_y, alpha_value, 0, 0)					-- left edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y+7, 7, 7, 309, 65+7, zoom_x, text_area_zoom_y, alpha_value, 0, 0)	-- right edge
	
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y+7, 7, 7, 263+7, 65+7, text_area_zoom_x, text_area_zoom_y, alpha_value, 0, 0)	-- center
	
	-- 말풍선 꼬리 그리기
	if tailPos == 0 then		 
		drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7/2+text_area_x/2-4, ctrl_y+7+text_area_y+7-2, 17, 9, 277, 92, zoom_x, zoom_y, alpha_value, 0, 0)
	elseif tailPos == 1 then	
		drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7/2+text_area_x/2-4, ctrl_y+7+text_area_y+7-2, 17, 9, 277, 92, zoom_x, zoom_y, alpha_value, 0, 0)
	elseif tailPos == 2 then
		drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7/2+text_area_x/2-4, ctrl_y+7+text_area_y+7-2, 17, 9, 277, 92, zoom_x, zoom_y, alpha_value, 0, 0)
	end
	
	-- 텍스트 그리기
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(real_str_chat, ctrl_x+7, ctrl_y+7)
end


-- 마지막으로 귓말온 상대 저장
function SavePrivateName(PrivateName)
	if winMgr:getWindow("PrivateChatting"):isVisible() == false then
		winMgr:getWindow("PrivateChatting"):setText(PrivateName)
	end
end


function GetChattingCharacterName(args)
	DebugStr('GetChattingCharacterName')
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
	--[[
	local local_window = CEGUI.toWindowEventArgs(args).window;	
	local CharacterName = CEGUI.toMultiLineEditbox(local_window):getMultiText()
	CharacterName = findTextErase(CharacterName, "<ZM>")

	if CharacterName ~= "" then
		winMgr:getWindow("PrivateChatting"):setText(CharacterName)
		winMgr:getWindow('doChatting'):setVisible(true)
		winMgr:getWindow("ChatCallPopup"):setVisible(true)
		winMgr:getWindow("ChatSelectedPopup"):setVisible(true)
		winMgr:getWindow('chat_popup_private'):setProperty("Selected", "false")
		winMgr:getWindow('chat_popup_private'):setProperty("Selected", "True")
		if winMgr:getWindow('doChatting'):isVisible() then
			winMgr:getWindow('doChatting'):activate()
		end
	end
	--]]
end

local bGetOnVehicle;
function OnSocialActionsOnGetonVehicle()
	g_bGetOnVehicle = true;
	for i=0, MAX_EMOTICON-1 do
		winMgr:getWindow("sj_emoticonBtn_"..i):setVisible(false);
	end
end
function OnSocialActionsOnGetoffVehicle()
	g_bGetOnVehicle = false;
	for i=0, MAX_EMOTICON-1 do
		winMgr:getWindow("sj_emoticonBtn_"..i):setVisible(true);
	end
end


function Chatting_DoLockChatTabBackground()
	lockChatTabBackground = true
	g_bChatTabEnable = true
end
DebugStr("Chatting.lua Excute Success!!!~~~")
