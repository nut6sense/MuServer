--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local MAX_BET = 100			-- 최대 베팅금액
local RATE_RESULT = 5		-- 결과 금액 비율
local MONETARYUNIT = 1000	-- 돈 단위

local g_Result = 0			-- 주사위 결과

-- 결과창 강조 애니메이션
local HIGHLIGHT_NONE = 0
local HIGHLIGHT_INCREASING = 1
local HIGHLIGHT_DECREASING = 2
local MIN_SIZE_HIGHLIGHT = 100000
local MAX_SIZE_HIGHLIGHT = 170000
local SPEED_HIGHLIGHT = 5

local g_Highlight = HIGHLIGHT_NONE
local g_SizeHighlight = MIN_SIZE_HIGHLIGHT

local g_Playing = false -- 게임 상태

--[[

public: -- windows

	DiceplayAlphaImage	-- 주사위게임창 알파이미지
	DiceplayBackground	-- 전체 주사위게임창
	{
	--	Diceplay_Titlebar			-- 타이틀바(삭제됨, 고정윈도우)
	--	Diceplay_CloseBtn			-- 닫기버튼
		
		Diceplay_Number_1~6			-- 주사위 이미지
		Diceplay_Bet_1~6			-- 베팅금액
		Diceplay_Result_1~6			-- 결과금액 이미지 배경
			Diceplay_Result_1~6_1~15-- 결과금액 숫자 이미지들
		
		Diceplay_StartButton		-- 시작버튼
		Diceplay_Zen				-- 젠
		
	} -- end of DiceplayBackground


	DiceResultBackground	-- 전체 주사위게임결과창
	{
		DiceResult_TitleImage	-- 타이틀이미지
		DiceResult_Titlebar		-- 타이틀바(삭제됨, 고정윈도우)
		DiceResult_Label_Number	-- 레이블(숫자)
		DiceResult_Label_Bet	-- 레이블(베팅금액)
		DiceResult_Label_Result	-- 레이블(결과)
		DiceResult_FrameBack_1~6-- 프레임
			DiceResult_FrameImage1_1_6	-- 실패이미지
			DiceResult_FrameImage2_1_6	-- 블랙
				DiceResult_FrameImage3_1_6	-- 성공이미지
					DiceResult_FrameImage4_1_6	-- 성공이미지 애니메이션
			DiceResult_Number_1~6		-- 주사위 이미지
			DiceResult_BetText_1~6		-- 텍스트로 된 베팅금액
			DiceResult_Bet_1~6			-- 베팅금액 배경
				DiceResult_Bet_1~6_1~15	-- 베팅금액 숫자이미지
		
		DiceResult_Label_Sum	-- 레이블(당첨금액)
		DiceResult_BackImage_Sum-- 당첨금액 배경
		DiceResult_Sum			-- 당첨금액
		
		DiceResult_OKButton		-- 확인버튼
		
	} -- end of DiceResultBackground


public: -- functions

	function Diceplay_Show()			-- 주사위게임창을 연다
	function Diceplay_Close()			-- 주사위게임창을 닫는다
	function Diceplay_SetVisible( b )	-- 주사위게임창의 visible을 조정한다
	function Diceplay_Init()			-- 초기화
	function Diceplay_Render()			-- 렌더함수
	function Diceplay_GetSum()			-- 총 베팅금액의 합산
		
	function SetImageNumbers( winName, number )	-- 숫자이미지 조합함수

	function DiceResult_Show()			-- 주사위게임결과창을 연다
	function DiceResult_Close()			-- 주사위게임결과창을 닫는다
	function DiceResult_SetVisible( b )	-- 주사위게임결과창의 visible을 조정한다
	function DiceResult_Init( index, result )	-- 결과창 초기화
	function DiceResult_Highlight( b )	-- 하이라이트
	
	function OnActivated_Bet(args)		-- Editbox 활성화 이벤트

	function OnClicked_BetBack(args)	-- Editbox 이동 이벤트
	function OnTextChanged_Edit(args)	-- Editbox 수정 이벤트
	function OnEditBoxFull(args)		-- EditBox가 꽉찼을때의 이벤트
	function OnPressTab_Edit(args)		-- EditBox들에서 Tab을 눌렀을 때의 이벤트
	function OnClicked_StartDice(args)	-- 시작버튼
	function OnClicked_OK(args)			-- 확인버튼
	
]]--








-- 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceplayAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 기본 바탕 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceplayBackground")
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 547, 282)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 547, 282)
mywindow:setWideType(6);
mywindow:setPosition(568, 85)
mywindow:setSize(406, 622)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


-- 바탕이미지 ESC키 등록
RegistEscEventInfo("DiceplayBackground", "Diceplay_Close")


-- 타이틀바
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Diceplay_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_Diceplay_WIDTH-35, 45)
--winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)


-- 닫기버튼
--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "Diceplay_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(370, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "Diceplay_Close")
winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)
]]


-- 주사위별 베팅
for i = 1, 6 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Diceplay_BetBack_" .. i)
	mywindow:setEnabled(true)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(110, 134 + ((i-1)*41))
	mywindow:setSize(33, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("index", tostring(i))
	winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)
	mywindow:subscribeEvent("MouseButtonDown", "OnClicked_BetBack")
	
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "Diceplay_Bet_" .. i)
	mywindow:setPosition(33, 0)
	mywindow:setSize(80, 25)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 17)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setVisible(true)
	mywindow:setEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUserString("index", tostring(i))
	winMgr:getWindow("Diceplay_BetBack_" .. i):addChildWindow(mywindow)
	CEGUI.toEditbox(mywindow):setMaxTextLength(3)
	CEGUI.toEditbox(mywindow):setInputOnlyNumber()
	CEGUI.toEditbox(mywindow):subscribeEvent("Activated", "OnActivated_Bet")
	CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Edit")
	CEGUI.toEditbox(mywindow):subscribeEvent("CharacterKey", "OnTextChanged_Edit")


	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Diceplay_Result_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(355, 134 + ((i-1)*41))
	mywindow:setSize(150, 32)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)
	
	for j = 1, 15 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Diceplay_Result_" .. i .. "_" .. j)
		mywindow:setEnabled(false)
		mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 797, 234)
		mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 797, 234)
		mywindow:setPosition(0, 0)
		mywindow:setSize(15, 32)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		winMgr:getWindow("Diceplay_Result_" .. i):addChildWindow(mywindow)
	end
end


-- 시작버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "Diceplay_StartButton")
mywindow:setTexture("Normal",	"UIData/WeekendEvent001.tga", 722, 756)
mywindow:setTexture("Hover",	"UIData/WeekendEvent001.tga", 722, 821)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent001.tga", 722, 886)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 951)
mywindow:setPosition(103, 486)
mywindow:setSize(200, 65)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_StartDice")
winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)

-- 젠
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Diceplay_Zen")
mywindow:setTextColor(50,171,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(406, 622)
--mywindow:setText("100,000,232")
mywindow:setSize(40, 18)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)







-- 전체 주사위게임결과창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResultBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(311, 145)
mywindow:setSize(403, 468)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_TitleImage")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 729)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 729)
mywindow:setPosition(97, 5)
mywindow:setSize(209, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)


-- 바탕이미지 ESC키 등록
RegistEscEventInfo("DiceResultBackground", "DiceResult_Close")


-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "DiceResult_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(403, 45)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 레이블(숫자)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Label_Number")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 879, 930)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 879, 930)
mywindow:setPosition(12, 52)
mywindow:setSize(69, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 레이블(베팅금액)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Label_Bet")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 859, 904)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 859, 904)
mywindow:setPosition(83, 52)
mywindow:setSize(137, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 레이블(결과)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Label_Result")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 879, 956)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 879, 956)
mywindow:setPosition(257, 52)
mywindow:setSize(90, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 주사위별 베팅결과
for i = 1, 6 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_FrameBack_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(16, 81 + ((i-1)*41))
	mywindow:setSize(370, 38)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_FrameImage1_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 489, 904)
	mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 489, 904)
	mywindow:setPosition(0, 0)
	mywindow:setSize(370, 38)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("DiceResult_FrameBack_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_FrameImage2_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/black.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/black.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(370, 38)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("DiceResult_FrameBack_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_FrameImage3_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 489, 942)
	mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 489, 942)
	mywindow:setPosition(-10, -10)
	mywindow:setSize(390, 58)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("DiceResult_FrameImage2_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_FrameImage4_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 489, 942)
	mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 489, 942)
	mywindow:setPosition(0, 0)
	mywindow:setSize(390, 58)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:clearControllerEvent("DiceResult_FrameEffect_" .. i)
	mywindow:clearActiveController()
	mywindow:addController("DiceResult_FrameController_" .. i, "DiceResult_FrameEffect_" .. i, "alpha", "Sine_EaseInOut", 255, 0, 8, true, false, 12)
--	mywindow:setAlphaWithChild(255)
	winMgr:getWindow("DiceResult_FrameImage3_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Number_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 466, 282 + ((i-1)*33))
	mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 466, 282 + ((i-1)*33))
	mywindow:setPosition(13, 4)
	mywindow:setSize(33, 33)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("DiceResult_FrameBack_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "DiceResult_BetText_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(175,175,175,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
	mywindow:setPosition(136, 5)
	mywindow:setSize(170, 25)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("DiceResult_FrameBack_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Bet_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(136, 6)
	mywindow:setSize(150, 32)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("DiceResult_FrameBack_" .. i):addChildWindow(mywindow)
	
	for j = 1, 15 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Bet_" .. i .. "_" .. j)
		mywindow:setEnabled(false)
		mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 797, 234)
		mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 797, 234)
		mywindow:setPosition(0, 0)
		mywindow:setSize(15, 32)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		winMgr:getWindow("DiceResult_Bet_" .. i):addChildWindow(mywindow)
	end
end


-- 레이블(당첨금액)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_Label_Sum")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 472)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 472)
mywindow:setPosition(11, 345)
mywindow:setSize(159, 36)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 당첨금액 배경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DiceResult_BackImage_Sum")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 0, 508)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 0, 508)
mywindow:setPosition(170, 345)
mywindow:setSize(194, 36)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- 당첨금액
mywindow = winMgr:createWindow("TaharezLook/StaticText", "DiceResult_Sum")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 21)
mywindow:setPosition(344, 345)
mywindow:setSize(170, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)


-- 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "DiceResult_OKButton")
mywindow:setTexture("Normal",	"UIData/WeekendEvent002.tga", 234, 898)
mywindow:setTexture("Hover",	"UIData/WeekendEvent002.tga", 234, 928)
mywindow:setTexture("Pushed",	"UIData/WeekendEvent002.tga", 234, 958)
mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 234, 988)
mywindow:setPosition(143, 402)
mywindow:setSize(117, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_OK")
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)









-- 주사위게임 창을 연다.
function Diceplay_Show()
	Diceplay_SetVisible(true)
end

-- 주사위게임 창을 닫는다.
function Diceplay_Close()
	Diceplay_SetVisible(false)
end

-- 주사위게임창의 visible을 조정한다
function Diceplay_SetVisible( b )
	
	if b == 1 or b == true then
		b = true
		Diceplay_Init()
		winMgr:getWindow("DiceplayBackground"):moveToFront()
	else
		b = false
		
		if IsPlaying() == true then
			return
		end
				
		if "village" == GetCurWindowName() then
			VirtualImageSetVisible(false)
		--	TownNpcEscBtnClickEvent()	
			winMgr:getWindow("TownNPC_ServiceListBack"):setVisible(true)
		end
		
		DiceNPCCameraZoomOut()
	end
	
	winMgr:getWindow("DiceplayAlphaImage"):setVisible(b)
	winMgr:getWindow("DiceplayBackground"):setVisible(b)
end

-- 초기화
function Diceplay_Init()
	
	for i = 1, 6 do
		winMgr:getWindow("Diceplay_Bet_" .. i):setText("")
		winMgr:getWindow("Diceplay_Result_" .. i):setText("")
	end
	
	winMgr:getWindow("Diceplay_StartButton"):setEnabled(false)
	
	local granText = CommatoMoneyStr(GetMyCharacterZen())
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
	winMgr:getWindow("Diceplay_Zen"):setPosition(367-textSize, 565)
	winMgr:getWindow("Diceplay_Zen"):setText(granText)

	InitDice3D()
	DiceNPCCameraZoomIn()
end


-- 렌더 함수
function Diceplay_Render()

	-- 창이 활성화 되어있을 경우
	if winMgr:getWindow("DiceplayBackground"):isVisible() == true then
	
		local bAllEmpty = true

		-- 숫자제한
		for i = 1, 6 do
			local window = winMgr:getWindow("Diceplay_Bet_" .. i)
			local text = window:getText()
			local result = tonumber(_extractNumbers(text))
			local check = CommatoMoneyStr(result)
			
			if check == "0" then
				result = ""
			elseif result > MAX_BET then
				result = MAX_BET
			end 
			
			local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 17, result)
			window:setPosition(33 - textSize, 0)
			window:setText(result)

			--	window:setTextExtends(result, g_STRING_FONT_GULIMCHE, 17, 255,255,255,255,   1, 255,255,255,255)

			if result == "" then
				winMgr:getWindow("Diceplay_Result_" .. i):setVisible(false)
			else
				local size = SetImageNumbers("Diceplay_Result_" .. i, result*1000*RATE_RESULT)
				winMgr:getWindow("Diceplay_Result_" .. i):setVisible(true)
				winMgr:getWindow("Diceplay_Result_" .. i):setPosition(355 - size, 134 + ((i-1)*41))
			--	winMgr:getWindow("Diceplay_Result_" .. i):setTextExtends(result*RATE_RESULT, g_STRING_FONT_GULIMCHE, 17, 255,255,255,255,   2, 255,255,255,255)
			end
			
			-- 모두 빈칸인지 검사
			if winMgr:getWindow("Diceplay_Bet_" .. i):getText() ~= "" and IsPlaying() == false then
				winMgr:getWindow("Diceplay_StartButton"):setEnabled(true)
				bAllEmpty = false
			end
		end
		
		if bAllEmpty then
			winMgr:getWindow("Diceplay_StartButton"):setEnabled(false)
		end
		
	-- 결과창 강조 애니메이션
	elseif winMgr:getWindow("DiceResultBackground"):isVisible() == true then
	
		if g_Highlight ~= HIGHLIGHT_NONE then
		
			if g_Highlight == HIGHLIGHT_INCREASING then
			
				local diff = g_SizeHighlight - MIN_SIZE_HIGHLIGHT + 3000
				g_SizeHighlight = g_SizeHighlight + diff/SPEED_HIGHLIGHT
				
				if g_SizeHighlight >= MAX_SIZE_HIGHLIGHT then
					g_Highlight = HIGHLIGHT_NONE
					g_SizeHighlight = MAX_SIZE_HIGHLIGHT
				end
			elseif g_Highlight == HIGHLIGHT_DECREASING then
			
				local diff = MAX_SIZE_HIGHLIGHT - g_SizeHighlight + 1000
				g_SizeHighlight = g_SizeHighlight - diff/SPEED_HIGHLIGHT
				
				if g_SizeHighlight <= MIN_SIZE_HIGHLIGHT then
					g_Highlight = HIGHLIGHT_NONE
					g_SizeHighlight = MIN_SIZE_HIGHLIGHT
				end
			end
			
			SetWindowScale("DiceResult_FrameImage4_" .. g_Result, g_SizeHighlight, 100000, g_SizeHighlight, 100000)
		
			local rate = (g_SizeHighlight/100-1000)
			local width = 390 * rate / 1000
			local height = 58 * rate / 1000
			winMgr:getWindow("DiceResult_FrameImage4_" .. g_Result):setPosition(-width/2, -height/2)
		end
	end
end

function Diceplay_GetSum()
	
	local sum = 0

	for i = 1, 6 do
		local text = winMgr:getWindow("Diceplay_Bet_" .. i):getText()
		if text ~= "" then
			sum = sum + tonumber(text)
		end
	end
	
	return sum
	
end

-- 숫자이미지 조합함수
function SetImageNumbers( winName, number )
	
	local window
	local str = tostring(number)
	local len = string.len(str)
	local cnt = 1
	local x = 0
	
	for i = 1, 15 do
		winMgr:getWindow(winName .. "_" .. i):setVisible(false)
	end
	
	for i = 1, len do
		local num = tonumber(string.sub(str, i, i))
		window = winMgr:getWindow(winName .. "_" .. cnt)
		cnt = cnt + 1
		window:setTexture("Enabled", "UIData/WeekendEvent002.tga", 797 + (num*15), 234)
		window:setTexture("Disabled", "UIData/WeekendEvent002.tga", 797 + (num*15), 234)
		window:setPosition(x, 0)
		window:setVisible(true)
		x = x + 15
	
		if (len - i) % 3 == 0 and len ~= i then
			window = winMgr:getWindow(winName .. "_" .. cnt)
			cnt = cnt + 1
			window:setTexture("Enabled", "UIData/WeekendEvent002.tga", 947, 234)
			window:setTexture("Disabled", "UIData/WeekendEvent002.tga", 947, 234)
			window:setPosition(x, 0)
			window:setVisible(true)
			x = x + 8
		end
	end
	
	winMgr:getWindow(winName):setSize(x, 32)
	
	return x
			
end






-- 주사위게임결과 창을 연다.
function DiceResult_Show()
	DiceResult_SetVisible(true)
end

-- 주사위게임결과 창을 닫는다.
function DiceResult_Close()
	DiceResult_SetVisible(false)
end

-- 주사위게임결과창의 visible을 조정한다
function DiceResult_SetVisible( b )
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("DiceplayBackground"):setVisible(false)
		winMgr:getWindow("DiceResultBackground"):moveToFront()
		DiceResult_Highlight( true )
		g_Playing = false
	else
		b = false
		Diceplay_Init()
		winMgr:getWindow("DiceplayBackground"):setVisible(true)
		DiceResult_Highlight( false )
	end
	
	winMgr:getWindow("DiceResultBackground"):setVisible(b)
end

-- 결과창 초기화
function DiceResult_Init( index, result )

	g_Result = index
	
	for i = 1, 6 do

		local bet = winMgr:getWindow("Diceplay_Bet_" .. i):getText()
		if bet ~= "" then
			bet = bet * 1000
		else
			bet = 0
		end
		
		if i == index then
			winMgr:getWindow("DiceResult_BetText_" .. i):setVisible(false)
			winMgr:getWindow("DiceResult_Bet_" .. i):setVisible(true)
			mywindow = winMgr:getWindow("DiceResult_Number_" .. i)
			mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 466, 282 + ((i-1)*33))
			mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 466, 282 + ((i-1)*33))
			
			local size = SetImageNumbers("DiceResult_Bet_" .. i, bet)
			winMgr:getWindow("DiceResult_Bet_" .. i):setPosition(136 - size/2, 6)
			winMgr:getWindow("DiceResult_FrameImage1_" .. i):setVisible(false)
			winMgr:getWindow("DiceResult_FrameImage2_" .. i):setVisible(true)
			winMgr:getWindow("DiceResult_FrameBack_" .. i):moveToFront()
			
			text = CommatoMoneyStr(result)
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 21, text)
			winMgr:getWindow("DiceResult_Sum"):setText(text)
			winMgr:getWindow("DiceResult_Sum"):setPosition(344 - size, 345)
		else
			winMgr:getWindow("DiceResult_BetText_" .. i):setVisible(true)
			winMgr:getWindow("DiceResult_Bet_" .. i):setVisible(false)
			mywindow = winMgr:getWindow("DiceResult_Number_" .. i)
			mywindow:setTexture("Enabled", "UIData/WeekendEvent002.tga", 499, 282 + ((i-1)*33))
			mywindow:setTexture("Disabled", "UIData/WeekendEvent002.tga", 499, 282 + ((i-1)*33))
			
			local text = CommatoMoneyStr(bet)
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, text)
			winMgr:getWindow("DiceResult_BetText_" .. i):setText(text);
			winMgr:getWindow("DiceResult_BetText_" .. i):setPosition(136 - size/2, 5)
			winMgr:getWindow("DiceResult_FrameImage1_" .. i):setVisible(true)
			winMgr:getWindow("DiceResult_FrameImage2_" .. i):setVisible(false)
		end
	end
	
end

-- 하이라이트
function DiceResult_Highlight( b )	
	
	g_Highlight = HIGHLIGHT_NONE
	g_SizeHighlight = MIN_SIZE_HIGHLIGHT
	SetWindowScale("DiceResult_FrameImage4_" .. g_Result, g_SizeHighlight, 100000, g_SizeHighlight, 100000)
	winMgr:getWindow("DiceResult_FrameImage4_" .. g_Result):setPosition(0, 0)
	winMgr:getWindow("DiceResult_FrameImage4_" .. g_Result):setAlphaWithChild(100)
	
	if b == true then
		g_Highlight = HIGHLIGHT_INCREASING
		winMgr:getWindow("DiceResult_FrameImage4_" .. g_Result):activeMotion("DiceResult_FrameEffect_" .. g_Result)
	end
end









-- Editbox 활성화 이벤트
function OnActivated_Bet(args)

	if g_Playing then
		CEGUI.toWindowEventArgs(args).window:deactivate()
	end
end

-- Editbox 이동 이벤트
function OnClicked_BetBack(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	window:deactivate()
	winMgr:getWindow("Diceplay_Bet_" .. index):activate()
end

-- Editbox 수정 이벤트
function OnTextChanged_Edit(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 17, window:getText())
	
	window:setPosition(33 - textSize, 0)
end

function OnEditBoxFull(args) -- EditBox가 꽉찼을때의 이벤트
	PlaySound('sound/FullEdit.wav')
end

function OnPressTab_Edit(args) -- EditBox들에서 Tab을 눌렀을 때의 이벤트

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index == 6 then
		winMgr:getWindow("Diceplay_Bet_1"):activate()
	else
		winMgr:getWindow("Diceplay_Bet_" .. index + 1):activate()
	end
	
end

-- 시작버튼
function OnClicked_StartDice(args)

	if g_Playing == true then
		return
	end
	
	if GetMyCharacterZen() < Diceplay_GetSum() * MONETARYUNIT then
		local message = PreCreateString_4528	--GetSStringInfo(LAN_OMULTIPLICATION_CONSUME_001)
		ShowCommonAlertOkBoxWithFunction(message, "OnClickAlertOkSelfHide")
	else
		local arr = {}
		for i = 1, 6 do
			arr[i] = tonumber(winMgr:getWindow("Diceplay_Bet_" .. i):getText())
		end
		g_Playing = true
		winMgr:getWindow("Diceplay_StartButton"):setEnabled(false)
		
		RequestStartDice(arr[1], arr[2], arr[3], arr[4], arr[5], arr[6])
	end
end

-- 확인버튼
function OnClicked_OK(args)
	DiceResult_SetVisible(false)
end

