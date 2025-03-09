--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


-- 가위바위보 상수
local RPS_NONE = 0
local RPS_ROCK = 1
local RPS_PAPER = 2
local RPS_SCISSORS = 3

local g_WinStreak = 0 -- 연승 횟수

local g_UserHand = 0	-- 유저가 선택한 손모양
local g_NPCHand = 0		-- NPC 손모양

local g_OrigNPCHand = 0	-- 서버에서 받은 NPC 손모양


local MAX_ANI_SCENE = 15			-- 애니메이션 장면 갯수
local SPEED_ANI = 8				-- 처음애니메이션 속도
local START_POS_ANI = 100		-- 처음 손의 위치
local g_AniSpeed = SPEED_ANI	-- 애니메이션 속도
local g_AniPos = START_POS_ANI	-- 손의 위치

local g_CurScene = 1		-- 현재 애니메이션 프레임
local g_bEnableAni = false	-- 애니메이션 활성화 여부


-- 게임 결과 상수
local RESULT_DRAW = 1
local RESULT_LOSE = 2
local RESULT_WIN = 3

local g_GameResult = 0

local g_bEnableTimer1 = false -- 게임 결과 화면을 위한 타이머	
local g_bEnableTimer2 = false -- 게임 결과 화면을 위한 타이머	
local g_bEnableTimer3 = false -- 이펙트를 위한 타이머
local g_Timer1 = 0			 -- 타이머 시간
local g_Timer2 = 0			 -- 타이머 시간
local g_Timer3 = 0			 -- 타이머 시간


local TIME_RESULT1 = 2000 -- 결과 화면 시간
local TIME_RESULT2 = 3000 -- 결과 화면 시간

local TIME_WHITE = 1200 -- 화이트아웃 시간


local RPS_PRICE = 3000 -- 게임 가격


--[[

public: -- windows

	RPSgameAlphaImage	-- 게임창 알파이미지
	RPSgameBackground	-- 전체 게임창
	{
	--	RPSgame_Titlebar		-- 타이틀바(삭제됨, 고정윈도우)
		RPSgame_CloseBtn		-- 닫기버튼
		RPSgame_WinStreak1		-- 연승 횟수 첫째자리
		RPSgame_WinStreak2		-- 연승 횟수 둘째자리
		RPSgame_Hand_User		-- 유저 손
		RPSgame_Hand_NPC_Back	-- NPC 얼굴
		RPSgame_Hand_NPC		-- NPC 손
		RPSgame_HandName_User	-- 유저 손이름
		RPSgame_HandName_NPC	-- NPC 손 이름
		RPSgame_UserName		-- 유저이름
		RPSgame_NPCName			-- NPC이름
		RPSgame_SelectButton_1~3-- 가위바위보 선택 버튼
		RPSgame_StartButton		-- 시작 버튼
		
	} -- end of RPSgameBackground
	
	RPSgameWhite				-- 결과 화면 전 흰색 플래시 화면
	RPSgameResult_1~3			-- 게임 결과 화면

	RPSwinBackground	-- 승리창
		RPSwin_TitleTextImage	-- 타이틀 텍스트 이미지
		RPSwin_WinStreak1		-- 연승 횟수 첫째자리
		RPSwin_WinStreak2		-- 연승 횟수 둘째자리
		RPSwin_Reward_Back
		RPSwin_Reward_Current	-- 현재 상품
		RPSwin_RewardQuan_Current-- 현재 상품 갯수
		RPSwin_Reward_Next		-- 다음 상품
		RPSwin_RewardQuan_Next	-- 다음 상품 갯수
		RPSwin_Button_List		-- 연승 아이템 목록 보기 버튼
		RPSwin_Reward_Desc		-- 설명
		RPswin_Button_Continue	-- 게임 계속하기 버튼
		RPSwin_Button_Stop		-- 게임 그만하기 버튼
	
	RPSlistBackground	-- 연승시 획득 아이템 목록창
		RPSlist_TitleTextImage	-- 타이틀 텍스트 이미지
		RPSlist_Number			-- 연승횟수 그림
		RPSlist_ItemName_1~20	-- 아이템 이름
		RPSlist_ItemBack_1~20	-- 마우스오버 이벤트를 위한 투명 이미지
		

public: -- functions

	function RPSgame_Show()					-- 게임창을 연다
	function RPSgame_Close()				-- 게임창을 닫는다
	function RPSgame_SetVisible( b )		-- 게임창의 visible을 조정한다
	function RPSgame_Init()					-- 초기화
	function RPSgame_Render()				-- 렌더함수
	function RPSgame_GetNPCHand( base, result ) -- 결과에 따른 NPC 손모양을 얻어온다
	function RPSgame_SetHand( bUser, hand ) -- 가위바위보 모양을 바꾼다
	function RPSgame_SetWinStreak( num )	-- 연승 횟수
	function RPSgame_AddWinStreak( num )	-- 연승 횟수 + 1회
	function RPSgame_SetButtonEnabled( b )	-- 버튼 enable을 조정한다
	function RPSgame_Start( npcHand )	-- 게임을 시작한다
	function RPSgame_StartAni()				-- 애니메이션을 시작한다
	function RPSgame_SetGameResult( result )-- 게임 결과 화면을 설정한다
	function RPSgame_SetAni( pos )			-- 애니메이션 함수
	function RPSgame_InitAniPos()			-- 손의 애니메이션을 초기화한다
	
	function ShowFlash()					-- 플래시 효과
	
	function RPSwin_Show()					-- 승리창을 연다
	function RPSwin_Close()					-- 승리창을 닫는다
	function RPSwin_SetVisible( b )			-- 승리창의 visible을 조정한다
	function RPSwin_Init()					-- 승리창 내용을 초기화한다

	function RPSlist_Show()					-- 연승상품리스트창을 연다
	function RPSlist_Close()				-- 연승상품리스트창을 닫는다
	function RPSlist_SetVisible( b )		-- 연승상품리스트창의 visible을 조정한다
	function RPSlist_Init()					-- 연승상품리스트창 내용을 초기화한다

	function OnClicked_SelectButton( args ) -- 가위바위보 선택 버튼
	
	function OnYes_RPS_Start()				-- 시작 확인 팝업창 Yes 클릭
	function OnNo_RPS_Start()				-- 시작 확인 팝업창 No 클릭
	function OnClicked_StartButton( args )	-- 시작 버튼
	
	function OnClicked_ShowList( args )		-- 연승 아이템 보기 버튼
	function OnClicked_Stop( args )			-- 게임 그만하기 버튼
	function OnClicked_Continue( args )		-- 게임 계속하기 버튼
	
	function OnMouseEnter_Reward( args )	-- 상품 아이템 이벤트
	function OnMouseEnter_RewardList( args )-- 상품 아이템 이벤트
	function OnMouseLeave_Reward( args )	-- 상품 아이템 이벤트
	
	function OnClicked_List_OK( args )		-- 상품리스트 확인버튼
	
]]--








-- 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:moveToFront()


-- 기본 바탕 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameBackground")
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition(72, 68)
mywindow:setSize(880, 632)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:moveToFront()

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("RPSgameBackground", "RPSgame_Close")


-- 타이틀바
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "RPSgame_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_RPSgame_WIDTH-35, 45)
--winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)


-- 닫기버튼
--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "RPSgame_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(370, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "RPSgame_Close")
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
]]

-- 연승 횟수
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_WinStreak1") -- 첫째자리
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setPosition(393, 139)
mywindow:setSize(80, 101)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_WinStreak2") -- 둘째자리
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setPosition(359, 139)
mywindow:setSize(80, 101)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

-- 유저 손 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_Hand_User")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 252, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 252, 0)
mywindow:setPosition(81, 148)
mywindow:setSize(252, 216)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

-- NPC 얼굴 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_Hand_NPC_Back")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 0)
mywindow:setPosition(545, 148)
mywindow:setSize(252, 216)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:setClippedByParent(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

-- NPC 손 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_Hand_NPC")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(797, 148)
mywindow:setSize(252, 216)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:setClippedByParent(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

SetWindowScale("RPSgame_Hand_NPC", 1, -1, 1, 1)


-- 유저 손 이름
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_HandName_User")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 216)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 216)
mywindow:setPosition(127, 282)
mywindow:setSize(233, 82)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
mywindow:moveToFront()

-- NPC 손 이름
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_HandName_NPC")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, 216)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, 216)
mywindow:setPosition(518, 282)
mywindow:setSize(233, 82)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
mywindow:moveToFront()

-- 유저이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RPSgame_UserName")
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 22)
mywindow:setPosition(90, 156)
mywindow:setSize(198, 22)
mywindow:setZOrderingEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setViewTextMode(1)
mywindow:clearTextExtends()
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
mywindow:moveToFront()

-- NPC이름
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_NPCName")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 632)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 632)
mywindow:setPosition(716, 155)
mywindow:setSize(91, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
mywindow:moveToFront()

-- 가위바위보 선택 버튼
for i = 1, 3 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "RPSgame_SelectButton_" .. i)
	mywindow:setTexture("Normal",			"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 632)
	mywindow:setTexture("Hover",			"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 688)
	mywindow:setTexture("Pushed",			"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 744)
	mywindow:setTexture("PushedOff",		"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 632)
	mywindow:setTexture("SelectedNormal",	"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 744)
	mywindow:setTexture("SelectedHover",	"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 744)
	mywindow:setTexture("SelectedPushed",	"UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 744)
	mywindow:setTexture("SelectedPushedOff","UIData/WeekendEvent001.tga", 281 + ((i-1)*147), 744)
	mywindow:setSize(147, 56)
	mywindow:setProperty("GroupID", 8151)
	mywindow:setPosition(220 + ((i-1)*147), 401)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnClicked_SelectButton")
	winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)
end


-- 시작 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RPSgame_StartButton")
mywindow:setTexture("Normal",	"UIData/WeekendEvent001.tga", 0, 632)
mywindow:setTexture("Hover",	"UIData/WeekendEvent001.tga", 0, 729)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent001.tga", 0, 826)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 0, 923)
mywindow:setPosition(299, 475)
mywindow:setSize(281, 97)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_StartButton")
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)



-- 게임 결과 화면
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameResult_1") -- Draw
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 0, 525)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 0, 525)
mywindow:setWideType(6)
mywindow:setPosition(297, 329)
mywindow:setSize(429, 110)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameResult_2") -- Lose
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/ResultNewImage_2.tga", 600, 667)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_2.tga", 600, 667)
mywindow:setWideType(6)
mywindow:setPosition(307, 327)
mywindow:setSize(410, 114)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameResult_3") -- Win
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/ResultNewImage_2.tga", 325, 667)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_2.tga", 325, 667)
mywindow:setWideType(6)
mywindow:setPosition(376, 327)
mywindow:setSize(271, 114)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)





-- 플래시 이펙트
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgameWhite")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/blwhite.tga", 0, 0)
mywindow:setTexture('Disabled', "UIData/blwhite.tga", 0, 0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setPosition(0, 0);
mywindow:setSize(1920, 1200);
mywindow:setZOrderingEnabled(true)
mywindow:setUseEventController(false)
mywindow:clearControllerEvent("RPSgameWhite_Effect_Show")
mywindow:clearControllerEvent("RPSgameWhite_Effect_Hide")
mywindow:clearActiveController()
mywindow:addController("RPSgameWhite_Controller_Show", "RPSgameWhite_Effect_Show", "alpha", "Sine_EaseInOut", 0, 255, 8, true, false, 34)
mywindow:addController("RPSgameWhite_Controller_Hide", "RPSgameWhite_Effect_Hide", "alpha", "Sine_EaseInOut", 255, 0, 8, true, false, 34)
mywindow:setAlphaWithChild(0)
root:addChildWindow(mywindow)





-- 승리창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwinBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(323, 180)
mywindow:setSize(379, 409)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
      
-- 바탕이미지 ESC키 등록
--RegistEscEventInfo("RPSwinBackground", "RPSwin_Close")

-- 타이틀 텍스트 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_TitleTextImage")
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 659)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 659)
mywindow:setPosition(110, 5)
mywindow:setSize(209, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- 연승 횟수
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_WinStreak1") -- 첫째자리
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 708)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 708)
mywindow:setPosition(114, 7)
mywindow:setSize(11, 20)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_WinStreak2") -- 둘째자리
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 726, 708)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 726, 708)
mywindow:setPosition(103, 10)
mywindow:setSize(11, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- 상품 배경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_Reward_Back")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 281, 800)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 281, 800)
mywindow:setPosition(4, 38)
mywindow:setSize(371, 207)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- 현재 상품
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_Reward_Current")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(43, 75)
mywindow:setSize(100, 100)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_Reward")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_Reward")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)
SetWindowScale("RPSwin_Reward_Current", 9, 10, 9, 10)

-- 현재 상품 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RPSwin_RewardQuan_Current")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setPosition(100, 100)
mywindow:setSize(50, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("x 1")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- 다음 상품
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_Reward_Next")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(248, 75)
mywindow:setSize(100, 100)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_Reward")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_Reward")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)
SetWindowScale("RPSwin_Reward_Next", 9, 10, 9, 10)

-- 다음 상품 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RPSwin_RewardQuan_Next")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setPosition(100, 100)
mywindow:setSize(50, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("x 1")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- 연승 아이템 보기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RPSwin_Button_List")
mywindow:setTexture("Normal",	"UIData/WeekendEvent002.tga", 351, 898)
mywindow:setTexture("Hover",	"UIData/WeekendEvent002.tga", 351, 925)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent002.tga", 351, 952)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 351, 979)
mywindow:setPosition(121, 204)
mywindow:setSize(138, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_ShowList")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)


-- 설명
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_Reward_Desc")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 466, 216)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 466, 216)
mywindow:setPosition(24, 263)
mywindow:setSize(331, 66)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)


-- 게임 계속하기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RPswin_Button_Continue")
mywindow:setTexture("Normal",	"UIData/WeekendEvent002.tga", 0, 898)
mywindow:setTexture("Hover",	"UIData/WeekendEvent002.tga", 0, 928)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent002.tga", 0, 958)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 988)
mywindow:setPosition(65, 342)
mywindow:setSize(117, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Continue")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)


-- 게임 그만하기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RPSwin_Button_Stop")
mywindow:setTexture("Normal",	"UIData/WeekendEvent002.tga", 117, 898)
mywindow:setTexture("Hover",	"UIData/WeekendEvent002.tga", 117, 928)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent002.tga", 117, 958)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 117, 988)
mywindow:setPosition(197, 342)
mywindow:setSize(117, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Stop")
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)






-- 연승시 획득 아이템 목록창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSlistBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(211, 145)
mywindow:setSize(603, 478)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("RPSlistBackground", "RPSlist_Close")

-- 타이틀 텍스트 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSlist_TitleTextImage")
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 686)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 686)
mywindow:setPosition(197, 5)
mywindow:setSize(209, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)

-- 연승횟수 그림
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSlist_Number")
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 544)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 544)
mywindow:setPosition(28, 50)
mywindow:setSize(547, 354)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)


for i = 1, 2 do
	for j = 1, 10 do
		-- 연승 횟수
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "RPSlist_ItemName_" .. ((i-1)*10) + j)
		mywindow:setEnabled(false)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
		mywindow:setPosition(180 + ((i-1)*280), 74 + ((j-1)*34))
		mywindow:setSize(50, 25)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setText(g_WinStreak)
		winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)

		-- 현재 상품
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSlist_ItemBack_" .. ((i-1)*10) + j)
		mywindow:setEnabled(true)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(90 + ((i-1)*280), 59 + ((j-1)*34))
		mywindow:setSize(180, 30)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RewardList")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_Reward")
		mywindow:setUserString("index", tostring(((i-1)*10) + j))
		winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)
	end
end

-- 확인 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RPSlist_Button_OK")
mywindow:setTexture("Normal",	"UIData/WeekendEvent002.tga", 234, 898)
mywindow:setTexture("Hover",	"UIData/WeekendEvent002.tga", 234, 928)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent002.tga", 234, 958)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 234, 988)
mywindow:setPosition(243, 417)
mywindow:setSize(117, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_List_OK")
winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)












-- 게임 창을 연다.
function RPSgame_Show()
	RPSgame_SetVisible(true)
end

-- 게임 창을 닫는다.
function RPSgame_Close()
	if g_WinStreak == 0 then
		RPSgame_SetVisible(false)
	end
end

-- 게임창의 visible을 조정한다
function RPSgame_SetVisible( b )

	-- 애니메이션 중일 때는 닫히지 않는다
	if g_bEnableAni or g_bEnableTimer1 == true or g_bEnableTimer2 == true then
		return
	end
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("RPSgameBackground"):moveToFront()
		RPSgame_Init()
	else
		b = false
		RPSwin_SetVisible(false)
		
		if "village" == GetCurWindowName() then
			VirtualImageSetVisible(false)
		--	TownNpcEscBtnClickEvent()	
			winMgr:getWindow("TownNPC_ServiceListBack"):setVisible(true)
		end
	end
	
	winMgr:getWindow("RPSgameAlphaImage"):setVisible(b)
	winMgr:getWindow("RPSgameBackground"):setVisible(b)
end

-- 초기화
function RPSgame_Init()
	
	RPSgame_SetWinStreak( 0 )
	
	winMgr:getWindow("RPSgame_UserName"):setTextExtends(GetMyName(), g_STRING_FONT_GULIMCHE, 22, 255,255,255,255,   2, 0,0,0,255)
	
	for i = 1, 3 do
		winMgr:getWindow("RPSgame_SelectButton_" .. i):setProperty("Selected", "False")
		winMgr:getWindow("RPSgame_SelectButton_" .. i):setEnabled(true)
	end
	winMgr:getWindow("RPSgame_SelectButton_1"):setProperty("Selected", "True") -- 주먹
	
	g_CurTick = 0
	g_CurScene = 1
	g_GameResult = 0
	g_bEnableTimer1 = false
	g_bEnableTimer2 = false
	g_bEnableAni = false
	g_Timer1 = 0
	g_Timer2 = 0
	g_AniSpeed = SPEED_ANI
	g_AniPos = START_POS_ANI
	
	RPSgame_SetHand(true, RPS_ROCK)
	RPSgame_SetHand(false, 4)
	g_NPCHand = RPS_ROCK
	
	winMgr:getWindow("RPSgame_Hand_NPC_Back"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 0)
	winMgr:getWindow("RPSgame_Hand_NPC_Back"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 0)
	winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, 462)
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, 462)
	
end


-- 렌더 함수
function RPSgame_Render( currentTime )

	-- 창이 활성화 되어있지 않을경우 종료
	if winMgr:getWindow("RPSgameBackground"):isVisible() == false then
		return
	end
	
	if g_bEnableTimer1 == true then
	
		local tick = currentTime - g_Timer1
		if tick > TIME_RESULT1 then
		
			winMgr:getWindow("RPSgameResult_" .. g_GameResult):setVisible(true)
			
			g_bEnableTimer1 = false
			
			g_bEnableTimer2 = true
			g_Timer2 = currentTime
			
			if g_GameResult == RESULT_WIN then
				ShowFireSpark()
			end
		end	
	end
	
	if g_bEnableTimer2 == true then
	
		local tick = currentTime - g_Timer2
		if tick > TIME_RESULT2 then
		
			winMgr:getWindow("RPSgameResult_" .. g_GameResult):setVisible(false)
			
			winMgr:getWindow("RPSgame_Hand_NPC_Back"):setVisible(true)
			
			winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			
			g_bEnableTimer2 = false
			
			if g_GameResult == RESULT_DRAW then
				RPSgame_SetButtonEnabled(true)
			
			elseif g_GameResult == RESULT_LOSE then
				RPSgame_SetVisible(false)
				return
			elseif g_GameResult == RESULT_WIN then
				RPSwin_Init()
				RPSwin_SetVisible(true)
			end
		end
	end
	
	if g_bEnableTimer3 == true then
	
		local tick = currentTime - g_Timer3
		
		if tick > TIME_WHITE then
			g_bEnableTimer3 = false
			HideFlash()
		end
				
	end
	
	if g_bEnableAni then
	
		g_AniPos = g_AniPos - g_AniSpeed
		
		if g_AniPos > 0 then
			RPSgame_SetAni( g_AniPos )
		else
			RPSgame_SetAni( 0 )
			
			if g_CurScene == MAX_ANI_SCENE - 6 then
			
				ShowFlash()
				
				g_bEnableTimer3 = true
				g_Timer3 = currentTime
				
				g_bEnableTimer1 = true
				g_Timer1 = currentTime
			
				g_CurScene = g_CurScene + 1
				
			elseif g_CurScene == MAX_ANI_SCENE then
				-- 결과
				g_CurScene = 0
				g_bEnableAni = false
				
				RPSgame_SetHand(false, g_OrigNPCHand)
				RPSgame_SetGameResult( g_UserHand, g_NPCHand )
				
				if g_GameResult == RESULT_WIN then
					RPSgame_AddWinStreak()
				end
			else
				g_CurScene = g_CurScene + 1
				
				if g_CurScene >= 3 then
					g_AniSpeed = g_AniSpeed + 3
				end
				
				-- 그림 변경
				if g_NPCHand == RPS_ROCK then
					g_NPCHand = RPS_PAPER
				elseif g_NPCHand == RPS_PAPER then
					g_NPCHand = RPS_SCISSORS
				elseif g_NPCHand == RPS_SCISSORS then
					g_NPCHand = RPS_ROCK
				end
				
				RPSgame_InitAniPos()
			end
		end
	end
	
end

function RPSgame_GetNPCHand( base, result ) -- 결과에 따른 NPC 손모양을 얻어온다
	
	if result == RESULT_DRAW then
		return base
	elseif result == RESULT_LOSE then
		if base == RPS_ROCK then
			return RPS_PAPER
		elseif base == RPS_PAPER then
			return RPS_SCISSORS
		elseif base == RPS_SCISSORS then
			return RPS_ROCK
		end
	elseif result == RESULT_WIN then
		if base == RPS_ROCK then
			return RPS_SCISSORS
		elseif base == RPS_SCISSORS then
			return RPS_PAPER
		elseif base == RPS_PAPER then
			return RPS_ROCK
		end
	end
end

function RPSgame_SetHand( bUser, hand ) -- 가위바위보 모양을 바꾼다
	
	local height = {[0] = 0, 298, 380, 216, 462}
	
	if bUser then
		g_UserHand = hand
		winMgr:getWindow("RPSgame_Hand_User"):setTexture("Enabled", "UIData/WeekendEvent002.tga", hand*252, 0)
		winMgr:getWindow("RPSgame_Hand_User"):setTexture("Disabled", "UIData/WeekendEvent002.tga", hand*252, 0)
		winMgr:getWindow("RPSgame_HandName_User"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, height[hand])
		winMgr:getWindow("RPSgame_HandName_User"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, height[hand])
	else
		g_NPCHand = hand
		winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", hand*252, 0)
		winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", hand*252, 0)
		winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, height[hand])
		winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, height[hand])
	end
	
end

function RPSgame_SetWinStreak( num )	-- 연승 횟수

	g_WinStreak = num


	-- Game
	local window1 = winMgr:getWindow("RPSgame_WinStreak1")
	local window2 = winMgr:getWindow("RPSgame_WinStreak2")

	window1:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, (g_WinStreak % 10) * 101)
	window1:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, (g_WinStreak % 10) * 101)
	
	if g_WinStreak < 10 then
		window2:setVisible(false)
		window1:setPosition(393, 139)
	else
		window2:setVisible(true)
		window1:setPosition(431, 139)
		
		window2:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, (g_WinStreak / 10) * 101)
		window2:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, (g_WinStreak / 10) * 101)
	end
	
	
	-- Win
	window1 = winMgr:getWindow("RPSwin_WinStreak1")
	window2 = winMgr:getWindow("RPSwin_WinStreak2")
	
	window1:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722 + ((g_WinStreak % 10) * 11), 708)
	window1:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722 + ((g_WinStreak % 10) * 11), 708)
	
	if g_WinStreak < 10 then
		window2:setVisible(false)
	else
		window2:setVisible(true)
		
		window2:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722 + ((g_WinStreak / 10) * 11), 708)
		window2:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722 + ((g_WinStreak / 10) * 11), 708)
	end
	
end

function RPSgame_AddWinStreak( num )	-- 연승 횟수 + 1회
	RPSgame_SetWinStreak(g_WinStreak + 1)
end

function RPSgame_SetButtonEnabled( b )	-- 버튼 enable을 조정한다
	
	if b == 1 or b == true then
		b = true
	else
		b = false
	end
	
	for i = 1, 3 do
		winMgr:getWindow("RPSgame_SelectButton_" .. i):setEnabled( b )
	end
	
	winMgr:getWindow("RPSgame_StartButton"):setEnabled( b )
	
end

-- 게임을 시작한다
function RPSgame_Start( npcHand )
	g_OrigNPCHand = npcHand
	RPSgame_StartAni()
end

-- 애니메이션을 시작한다
function RPSgame_StartAni()			

	g_bEnableAni = true
	g_AniSpeed = SPEED_ANI
	RPSgame_SetButtonEnabled( false )
	
	winMgr:getWindow("RPSgame_Hand_NPC_Back"):setVisible(false)
end	

-- 게임 결과 화면을 설정한다
function RPSgame_SetGameResult( userHand, npcHand )

	if userHand == npcHand then
		g_GameResult = RESULT_DRAW
	elseif	(userHand == RPS_ROCK		and npcHand == RPS_SCISSORS) or
			(userHand == RPS_SCISSORS	and npcHand == RPS_PAPER) or
			(userHand == RPS_PAPER		and npcHand == RPS_ROCK) then
		g_GameResult = RESULT_WIN
	else
		g_GameResult = RESULT_LOSE
	end	
	
--	winMgr:getWindow("RPSgameResult"):setVisible(true)
	winMgr:getWindow("RPSgameResult_" .. g_GameResult):moveToFront()
end

-- 애니메이션 함수
function RPSgame_SetAni( pos )

	g_AniPos = pos
	
	local window = winMgr:getWindow("RPSgame_Hand_NPC")
	
	window:setTexture("Enabled", "UIData/WeekendEvent002.tga", (g_NPCHand*252) + g_AniPos, 0)
	window:setTexture("Disabled", "UIData/WeekendEvent002.tga", (g_NPCHand*252) + g_AniPos, 0)
--	window:setPosition(252 + g_AniPos, 0)
	window:setSize(252 - g_AniPos, 216)
	
end
		
-- 손의 애니메이션을 초기화한다
function RPSgame_InitAniPos()

	local height = {[0] = 0, 298, 380, 216, 462}
	
	RPSgame_SetAni(START_POS_ANI)
	
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, height[g_NPCHand])
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, height[g_NPCHand])
	
end

-- 플래시 효과
function ShowFlash()
	winMgr:getWindow("RPSgameWhite"):moveToFront()
	winMgr:getWindow("RPSgameWhite"):activeMotion("RPSgameWhite_Effect_Show")
end

function HideFlash()
	winMgr:getWindow("RPSgameWhite"):moveToFront()
	winMgr:getWindow("RPSgameWhite"):activeMotion("RPSgameWhite_Effect_Hide")
end







-- 승리창을 연다.
function RPSwin_Show()
	RPSwin_SetVisible(true)
end

-- 승리창을 닫는다.
function RPSwin_Close()
	RPSwin_SetVisible(false)
end

-- 승리창의 visible을 조정한다
function RPSwin_SetVisible( b )
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("RPSgameBackground"):setVisible(false)
		winMgr:getWindow("RPSwinBackground"):moveToFront()
	else
		b = false
	end
	
	winMgr:getWindow("RPSwinBackground"):setVisible(b)
end



-- 승리창 내용을 초기화한다
function RPSwin_Init()

	SetRewardImage(g_WinStreak)

	-- 현재 상품 갯수
	local text = "x " .. GetRewardQuantity( g_WinStreak )
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 15, text)
	local window = winMgr:getWindow("RPSwin_RewardQuan_Current")
	
	window:setText( text )
	window:setPosition(132 - textSize, 63)
	
	
	if g_WinStreak < 20 then
		-- 다음 상품 갯수
		text = "x " .. GetRewardQuantity( g_WinStreak+1 )
		textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 15, text)
		window = winMgr:getWindow("RPSwin_RewardQuan_Next")
		
		window:setText( text )
		window:setPosition(337 - textSize, 63)
	else
		-- 20연승일땐 다음 상품을 감춘다
		winMgr:getWindow("RPSwin_RewardQuan_Next"):setText("")
		winMgr:getWindow("RPSwin_Reward_Next"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("RPSwin_Reward_Next"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
end




-- 연승상품리스트 창을 연다.
function RPSlist_Show()
	RPSlist_SetVisible(true)
end

-- 연승상품리스트 창을 닫는다.
function RPSlist_Close()
	RPSlist_SetVisible(false)
end

-- 연승상품리스트창의 visible을 조정한다
function RPSlist_SetVisible( b )

	if b == 1 or b == true then
		b = true
		RPSwin_SetVisible(false)
		winMgr:getWindow("RPSlistBackground"):moveToFront()
	else
		b = false
		RPSwin_SetVisible(true)
	end
	
	winMgr:getWindow("RPSlistBackground"):setVisible(b)
end

-- 초기화
function RPSlist_Init()

	for i = 1, 20 do
	
		local text = GetRewardItemName(i) .. " x " .. GetRewardQuantity(i)
		local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 15, text)
		local window = winMgr:getWindow("RPSlist_ItemName_" .. i)
		
		window:setText( text )
		
		local x = (i-1) / 10
		local y = (i-1) % 10
		window:setPosition(180 + (x*280) - textSize/2, 60 + (y*34))
	end
	
end












-- 가위바위보 선택 버튼
function OnClicked_SelectButton( args ) 

	g_UserHand = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("index"))
	
	RPSgame_SetHand( true, g_UserHand )
	
	winMgr:getWindow("RPSgame_StartButton"):setEnabled(true)
end


-- 시작 확인 팝업창 Yes 클릭
function OnYes_RPS_Start()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_RPS_Start" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	if g_WinStreak == 0 then
		-- 시작
		RequestStart(g_UserHand)
	--	RPSgame_Start( 3 )
	else
		-- 승리창 닫기
		RPSwin_SetVisible(false)
			
		winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("RPSgame_Hand_NPC"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, 462)
		winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, 462)
		winMgr:getWindow("RPSgameBackground"):setVisible(true)
		
		RPSgame_SetHand(true, RPS_ROCK)
		
		RPSgame_SetButtonEnabled(true)
	end
end


-- 시작 확인 팝업창 No 클릭
function OnNo_RPS_Start()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_RPS_Start" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

-- 시작 버튼
function OnClicked_StartButton( args ) 

--	if GetMyMoney() < RPS_PRICE then
--		local message = GetSStringInfo(LAN_GABABO_CONSUME_002)
--		ShowCommonAlertOkBoxWithFunction(message, "OnClickAlertOkSelfHide")
--	else
		-- 처음이면 물어보고, 아니면 바로 시작
		if g_WinStreak == 0 and g_GameResult ~= RESULT_DRAW then
			local message = string.format(PreCreateString_4511, RPS_PRICE)	--GetSStringInfo(LAN_GABABO_CONSUME_001)
			ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_RPS_Start", "OnNo_RPS_Start")
		else
			RequestStart(g_UserHand)
		--	RPSgame_Start( 3 )
		end
--	end
end

-- 연승 아이템 보기 버튼
function OnClicked_ShowList( args ) 
	RPSlist_Init()
	RPSlist_SetVisible(true)
end

-- 게임 그만하기 버튼
function OnClicked_Stop( args )

	RequestGetReward()
	RPSgame_SetVisible(false)
end

-- 게임 계속하기 버튼
function OnClicked_Continue( args ) 

	if GetMyMoney() < RPS_PRICE then
		local message = PreCreateString_4512	--GetSStringInfo(LAN_GABABO_CONSUME_002)
		ShowCommonAlertOkBoxWithFunction(message, "OnClickAlertOkSelfHide")
	else
		local message = string.format(PreCreateString_4511, RPS_PRICE)	--GetSStringInfo(LAN_GABABO_CONSUME_001)
		ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_RPS_Start", "OnNo_RPS_Start")
	end
end


-- 상품 아이템 이벤트
function OnMouseEnter_Reward( args ) 

	local window = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(window)
	
	local winStreak
	if window:getName() == "RPSwin_Reward_Current" then
		winStreak = g_WinStreak
	else
		winStreak = g_WinStreak+1
	end
	
	if winStreak > 20 then
		return
	end
	
	local itemNumber
	local itemKind
	local quantity
	
	itemNumber, quantity, itemKind = GetRewardInfo(winStreak)
	
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end	
	
	GetToolTipBaseInfo(x + 100, y, 4, Kind, -5, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 상품 아이템 이벤트
function OnMouseEnter_RewardList( args ) 

	local window = CEGUI.toWindowEventArgs(args).window
	local index  = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("index"))
	
	local x, y = GetBasicRootPoint(window)
	
	local itemNumber
	local itemKind
	local quantity
	
	itemNumber, quantity, itemKind = GetRewardInfo(index)
	
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end	
	
	GetToolTipBaseInfo(x + 150, y+10, 4, Kind, -5, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 상품 아이템 이벤트
function OnMouseLeave_Reward( args ) 
	SetShowToolTip(false)
end

-- 상품 획득 확인 버튼
function OnClicked_GetOK( args ) 
	RPSget_SetVisible(false) -- 전체 종료
end

-- 상품리스트 확인버튼
function OnClicked_List_OK( args )
	RPSlist_SetVisible(false)
end




