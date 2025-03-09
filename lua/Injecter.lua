--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

--=====================================================================
-- ESC / ENTER 이벤트 등록
--=====================================================================
RegistEscEventInfo("Injecter_PopUp" , "CloseInjecterEffect")
RegistEnterEventInfo("Injecter_Reward_Popup_Alpha","CloseInjectEvent")

--=====================================================================
-- 디파인
--=====================================================================
-- Modify by Jiyuu
--local MAX_LEVEL			= 50	-- 한국 40 , 미국,태국 = 50
-- Jiyuu : 레벨수정
local MAX_LEVEL			= 60	-- 한국 40 , 미국,태국 = 50
local SMALL_NEED_EXP	= 10000
local MEDIUM_NEED_EXP	= 30000
local LARGE_NEED_EXP	= 50000
local XLARGE_NEED_EXP	= 100000

--=====================================================================
-- 전역변수
--=====================================================================
local g_NowInjecterType		= -1	-- 선택된 인젝터 type
local g_InjectEffectTick	= 0		-- 인젝터 이펙트 틱
local g_LightEffect			= 0		-- 번쩍이는 이펙트

--=====================================================================
-- 스트링 로드
--=====================================================================
local g_STRING_NOT_ENOUGH_EXP	 = PreCreateString_4190	--GetSStringInfo(LAN_INJECTOR_001)	-- 보유한 경험치가 부족합니다
local g_STRING_ALREADY_MAX_LEVEL = PreCreateString_4193	--GetSStringInfo(LAN_INJECTOR_004)	-- 경험치를 더 이상 획득할 수 없습니다.


--------------------------------------------------------------------
-- 뒷배경(검은색) 알파 윈도우
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Injecter_Root_Alpha');
mywindow:setTexture('Enabled',	'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);

----------------------------------------------------------------------
-- 주사기 메인창 알파
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_MainWnd_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2)-(274/2) , (g_MAIN_WIN_SIZEY / 2)-(200) )
mywindow:setSize(274 , 103)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 메인창
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_MainWnd")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 338, 283)
mywindow:setTexture("Disabled", "UIData/injection.tga", 338, 283)
mywindow:setPosition(0,0)
mywindow:setSize(274 , 103)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)
winMgr:getWindow("Injecter_MainWnd_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 1 ~ 4 램프 게이지
-----------------------------------------------------------------------
local tRampPosition = {["err"] = 0 , 78 , 107 , 137 , 167 }
for i=1 , 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Light_Button_" .. i)
	mywindow:setTexture("Enabled",	"UIData/injection.tga", 612 , 283)
	mywindow:setTexture("Disabled", "UIData/injection.tga", 612 , 283)
	mywindow:setPosition(tRampPosition[i] , 47)
	mywindow:setSize(28 , 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Injecter_MainWnd"):addChildWindow(mywindow)
end

----------------------------------------------------------------------
-- 주사기 회전 이펙트
-----------------------------------------------------------------------
local tSpinAnimationX = { ['err'] = 0 , 184 , 289 , 394 , 499 , 604 , 709 , 814 , 919 }	
for i=1 , #tSpinAnimationX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Spin_Effect_" .. i)
	mywindow:setTexture("Enabled",	"UIData/Avata.tga", tSpinAnimationX[i] , 814)
	mywindow:setTexture("Disabled", "UIData/Avata.tga", tSpinAnimationX[i] , 814)
	mywindow:setPosition(180 , 9)
	mywindow:setSize(105 , 105)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Injecter_MainWnd"):addChildWindow(mywindow)
end

function Injecter_Spin(count)
	if count >= 9 then
		DebugStr("Injecter_Spin() 카운트 에러 : " .. count)
		return
	end
	
	-- 사운드 출력
	if count == 1 then
		PlayWave('sound/Clone_Success.wav');
	end
	
	winMgr:getWindow("Injecter_Spin_Effect_" .. count):setVisible(true)
	
	if count == 8 then
		for i=1 , #tSpinAnimationX do
			winMgr:getWindow("Injecter_Spin_Effect_" .. i):setVisible(false)
		end
		
		-- 폭파 시작
		SetBoomFlag(true)
	end
end

----------------------------------------------------------------------
-- 주사기 폭팔 이펙트
-----------------------------------------------------------------------
for i=1 , #tSpinAnimationX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Boom_Effect_" .. i)
	mywindow:setTexture("Enabled",	"UIData/Avata.tga", tSpinAnimationX[i] , 919)
	mywindow:setTexture("Disabled", "UIData/Avata.tga", tSpinAnimationX[i] , 919)
	mywindow:setPosition(180 , 9)
	mywindow:setSize(105 , 105)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Injecter_MainWnd"):addChildWindow(mywindow)
end

function Injecter_Boom(count)
	if count >= 9 then
		DebugStr("Injecter_Boom() 카운트 에러 : " .. count)
		return
	end
	
	winMgr:getWindow("Injecter_Boom_Effect_" .. count):setVisible(true)
	--DebugStr("켜짐 : " .. count)
	
	if count == 8 then
		for i=1 , #tSpinAnimationX do
			winMgr:getWindow("Injecter_Boom_Effect_" .. i):setVisible(false)
		end
		
		-- 병 그려주기
		SetBottleIcon()
		
		-- 서버에 사용을 요청
		RequestUseInject()
	end
end

-- 아이템 사용시 첫 호출되는 함수
-- 인벤토리에서 아이템 사용 ---> 아이템 타입 저장 -> SetLightOn() 함수 호출....
function SetLightOn()
	DebugStr("SetLightOn() 호출")
	
	-- 뒷배경 깔기
	root:addChildWindow("Injecter_Root_Alpha")
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(true)
	
	-- 메인창 위치 재 설정
	local x, y = GetWindowSize()
	x = (x/2) - (274/2)
	y = (y/2) - (200)
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setPosition(x,y)
	
	-- 예외처리 : 인젝터 아이템 넘버가 올바른가
	if GetUseNumber() == -1 then
		ShowNotifyOKMessage_Lua("Injecter Num is -1 : error")
		CloseInjectEvent()
		return
	end
	
	-- 캐릭터 정보 얻어오기
	local CurrentLevel , CurrentExp , MaxExp , NeedExp = GetMyCharacterData()
	
	-- 보유한 경험치가 충분한지 체크
	if CurrentExp < NeedExp then
		ShowNotifyOKMessage_Lua(g_STRING_NOT_ENOUGH_EXP)
		CloseInjectEvent()
		return
	end
	
	-- 사운드 재생
	PlayWave('sound/Injecter_Use.wav');
		
	-- 키 입력 / 마우스 입력을 막는다
	SetKeyInputControl()
	
	-- 메인 윈도우 ON
	root:addChildWindow(winMgr:getWindow("Injecter_MainWnd_Alpha"))
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setVisible(true)
	
	-- 메인 윈도우의 사용한 인젝터 아이콘을 설정
	SetInjecterIcon()
	
	-- 타입에 맞게끔 램프를 켜준다
	SetInjecterRamp()
end

-- 램프 불키는 함수
function SetRampOn(count)
	if count <= 0 or count > 4 then
		DebugStr("램프의 카운트 입력 에러 : " .. count)
		return
	end
	
	winMgr:getWindow("Injecter_Light_Button_" .. count):setVisible(true)
end

----------------------------------------------------------------------
-- 사용한 단계별 주사기 아이콘
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Use_Icon")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(5 , 26)
mywindow:setSize(105, 105)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Injecter_MainWnd"):addChildWindow(mywindow)
function DrawInjecterIcon(FileName)
	winMgr:getWindow("Injecter_Use_Icon"):setTexture("Enabled" , FileName , 0, 0)
	winMgr:getWindow("Injecter_Use_Icon"):setTexture("Disabled", FileName , 0, 0)
	winMgr:getWindow("Injecter_Use_Icon"):setVisible(true)
	
	winMgr:getWindow("Injecter_Use_Icon"):setScaleWidth(180)
	winMgr:getWindow("Injecter_Use_Icon"):setScaleHeight(180)
end

----------------------------------------------------------------------
-- 생성된 단계별 EXP 병
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Make_Bottle")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198 , 26)
mywindow:setSize(105, 105)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Injecter_MainWnd"):addChildWindow(mywindow)
function DrawExpBottleIcon(FileName)
	winMgr:getWindow("Injecter_Make_Bottle"):setTexture("Enabled" , FileName , 0, 0)
	winMgr:getWindow("Injecter_Make_Bottle"):setTexture("Disabled", FileName , 0, 0)
	winMgr:getWindow("Injecter_Make_Bottle"):setScaleWidth(180)
	winMgr:getWindow("Injecter_Make_Bottle"):setScaleHeight(180)
	
	winMgr:getWindow("Injecter_Make_Bottle"):setVisible(true)
end

----------------------------------------------------------------------
-- 주사기 사용 완료 알파 팝업창
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Reward_Popup_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2)-(338/2), (g_MAIN_WIN_SIZEY / 2) - 70 )
mywindow:setSize(338 , 266)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setWideType(6)
mywindow:setAlign(8)
mywindow:addController("Injecter_RewardController", "Injecter_Controller", "xscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10)
mywindow:addController("Injecter_RewardController", "Injecter_Controller", "yscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10)
mywindow:addController("Injecter_RewardController", "Injecter_Controller", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10)
root:addChildWindow(mywindow)
----------------------------------------------------------------------
-- 주사기 사용 완료 팝업창
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Reward_Popup")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 0, 155)
mywindow:setTexture("Disabled", "UIData/injection.tga", 0, 155)
mywindow:setPosition(0,0)
mywindow:setSize(338 , 266)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Injecter_Reward_Popup_Alpha"):addChildWindow(mywindow)
--------------------------------------------------------------------
-- 주사기 사용 완료 팝업 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Injecter_RewardOkButton")
mywindow:setTexture("Normal",	"UIData/injection.tga", 338, 155)
mywindow:setTexture("Hover",	"UIData/injection.tga", 338, 187)
mywindow:setTexture("Pushed",	"UIData/injection.tga", 338, 219)
mywindow:setTexture("PushedOff","UIData/injection.tga", 338, 251)
mywindow:setTexture("Enabled",	"UIData/injection.tga", 338, 251)
mywindow:setTexture("Disabled",	"UIData/injection.tga", 338, 251)
mywindow:setPosition(125, 220)
mywindow:setSize(89, 32)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseInjectEvent")
winMgr:getWindow("Injecter_Reward_Popup_Alpha"):addChildWindow(mywindow)
function CloseInjectEvent()
	-- 메인창 끄기
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setVisible(false)
	
	-- 주사기/EXP병들 아이콘들 끄기
	winMgr:getWindow("Injecter_Make_Bottle"):setVisible(false)
	winMgr:getWindow("Injecter_Use_Icon"):setVisible(false)
	winMgr:getWindow("Injecter_Complate_Bottle"):setVisible(false)

	-- 게이지 끄기
	for i=1 , 4 do
		winMgr:getWindow("Injecter_Light_Button_" .. i):setVisible(false)
	end

	-- 생성 성공 팝업 끄기
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)

	-- 알파창 끄기
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(false)
end

----------------------------------------------------------------------
-- 완료 창에 띄울 EXP 병
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Complate_Bottle")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(135 , 106)
mywindow:setSize(105, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Injecter_Reward_Popup_Alpha"):addChildWindow(mywindow)
function DrawComplateBottleIcon()
	local FileName = GetMakeBottleName()
	--DebugStr("선택된 EXP병 FileName : " .. FileName)
	
	winMgr:getWindow("Injecter_Complate_Bottle"):setTexture("Enabled" , FileName , 0, 0)
	winMgr:getWindow("Injecter_Complate_Bottle"):setTexture("Disabled", FileName , 0, 0)
	winMgr:getWindow("Injecter_Complate_Bottle"):setScaleWidth(180)
	winMgr:getWindow("Injecter_Complate_Bottle"):setScaleHeight(180)
	
	winMgr:getWindow("Injecter_Complate_Bottle"):setVisible(true)
end

----------------------------------------------------------------------
-- Name : function Use_ItemExpBottle(expType)
-- Desc : Exp병 사용
----------------------------------------------------------------------
function Use_ItemExpBottle(expType)
	local CurrentLevel , CurrentExp , NextLvUpTable = GetExpBottleData()
	
	-- 만렙이면서 경험치가 99%인 상태면 막는다.
	-- 더이상 먹어봤자 의미가 없으므로.......
	local RemainEXP = NextLvUpTable - CurrentExp
	
	if CurrentLevel == MAX_LEVEL and RemainEXP == 1 then
		ShowNotifyOKMessage_Lua(g_STRING_ALREADY_MAX_LEVEL)
		return
	end
	
	-- 2. 만렙 and EXP99%상태라면 EXP 병 사용을 막는다
	RequestExpBottle()
end


----------------------------------------------------------------------
-- Name : function ShowRewardNotifyMessage()
-- Desc : 성공팝업창 보여줌
----------------------------------------------------------------------
function ShowRewardNotifyMessage()
	-- 메인창 위치 재 설정
	local x, y = GetWindowSize()
	x = (x/2) - (338/2)
	y = (y/2) - (70)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setPosition(x,y)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):activeMotion("Injecter_Controller");
	root:addChildWindow(winMgr:getWindow("Injecter_Reward_Popup_Alpha"))
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(true)
	
	-- 성공창에 EXP병 그리기
	DrawComplateBottleIcon()
end


----------------------------------------------------------------------
-- Name : function AnswerUseExpBottleSuccess(nExpString)
-- Desc : EXP병 사용 성공
----------------------------------------------------------------------
function AnswerUseExpBottleSuccess(nExpString)
	root:addChildWindow(winMgr:getWindow("NM_NotifyConfirmMain"))
	
	ShowNotifyOKMessage(nExpString)	-- %d의 경험치를 얻었습니다.
end

-- EXP병 사용 실패
function AnswerUseExpBottleFaild()
	root:addChildWindow(winMgr:getWindow("NM_NotifyConfirmMain"))
	ShowNotifyOKMessage("ExpBottle Use Failed")
end





















--[[
--========================================================================

-- Old Injecter 
-- 전에 만든거. 싹 갈아엎었다 -_-..............

--========================================================================
----------------------------------------------------------------------
-- 주사기 게이지창 알파
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Gauge_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2)-(95/2) , (g_MAIN_WIN_SIZEY / 2)-(200) )
mywindow:setSize(95 , 28)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 게이지창 백판
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Gauge_Body_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 929, 164)
mywindow:setTexture("Disabled", "UIData/injection.tga", 929, 164)
mywindow:setPosition(0,0)
mywindow:setSize(95 , 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Injecter_Gauge_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 게이지창 눈금
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Gauge_Ruler_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 739, 164)
mywindow:setTexture("Disabled", "UIData/injection.tga", 739, 164)
mywindow:setPosition(0,0)
mywindow:setSize(95 , 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Injecter_Gauge_Body_Img"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 게이지창 주입액
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Gauge_Solution_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 843, 167)
mywindow:setTexture("Disabled", "UIData/injection.tga", 843, 167)
mywindow:setPosition(8 , 4)
mywindow:setSize(78 , 21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
--mywindow:subscribeEvent("MotionEventEnd", "EndEffect");
mywindow:addController("GaugeController", "GaugeEvent", "xscale", "Sine_EaseIn", 0, 255, 5, true, false, 5)
winMgr:getWindow("Injecter_Gauge_Body_Img"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 머리위 주사기 이펙트 알파
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Effect_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX / 2)-(200) , (g_MAIN_WIN_SIZEY / 2)-(200))
mywindow:setSize(75 , 75)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
----------------------------------------------------------------------
-- 머리위 주사기 이펙트
-----------------------------------------------------------------------
for i=1 , 7 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Effect_Body_" .. i)
	mywindow:setTexture("Enabled",	"UIData/injection.tga", 949, 89)
	mywindow:setTexture("Disabled", "UIData/injection.tga", 949, 89)
	mywindow:setPosition(42 , 19)
	mywindow:setSize(75 , 75)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("Injecter_Effect_Alpha"):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 배경 검은 투명한 알파창
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Injecter_Root_Alpha1');
mywindow:setTexture('Enabled',	'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);

function StartEffect()
	-- 검은 반투명 알파
	root:addChildWindow(winMgr:getWindow("Injecter_Root_Alpha1"))
	winMgr:getWindow("Injecter_Root_Alpha1"):setVisible(true)
	
	winMgr:getWindow("Injecter_Gauge_Solution_Img"):clearActiveController()
	winMgr:getWindow("Injecter_Gauge_Solution_Img"):activeMotion("GaugeEvent")
	
	root:addChildWindow(winMgr:getWindow("Injecter_Gauge_Alpha"))
	winMgr:getWindow("Injecter_Gauge_Alpha"):setVisible(true)
	
	root:addChildWindow(winMgr:getWindow("Injecter_Effect_Alpha"))
	winMgr:getWindow("Injecter_Effect_Alpha"):setVisible(true)
end	

function EndEffect()
	winMgr:getWindow("Injecter_Root_Alpha1"):setVisible(false)
	
	winMgr:getWindow("Injecter_Gauge_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_Effect_Alpha"):setVisible(false)
end

	-- end of 1방안	--



--========================================================================

-- 2번째 방안 : 커다란 주사기

--========================================================================
----------------------------------------------------------------------
-- 주사기 최상위 알파
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2)-(257/2) , (g_MAIN_WIN_SIZEY / 2)-(73/2) )
mywindow:setSize(257 , 73)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 본체
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Body_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/injection.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0,0)
mywindow:setSize(257 , 73)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Injecter_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 액 (녹색)
-----------------------------------------------------------------------
g_SolutionX = 0 --162
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Solution_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 0, 80)
mywindow:setTexture("Disabled", "UIData/injection.tga", 0, 80)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(42 , 19)
mywindow:setSize(g_SolutionX , 37)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
--root:addChildWindow(mywindow)
winMgr:getWindow("Injecter_Body_Img"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 본체 끝트머리
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Body_End_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 248, 81)
mywindow:setTexture("Disabled", "UIData/injection.tga", 248, 81)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(248 , 0)
mywindow:setSize(9 , 73)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--root:addChildWindow(mywindow)
winMgr:getWindow("Injecter_Body_Img"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 액 주입기
-----------------------------------------------------------------------
g_SolutionPushX = 42	-- 주입기 포지션X
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_SolutionPush_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 267, 0)
mywindow:setTexture("Disabled", "UIData/injection.tga", 267, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(g_SolutionPushX , 9)
mywindow:setSize(234 , 58)
--mywindow:setWideType(6)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Injecter_Body_Img"):addChildWindow(mywindow)
--root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 주사기 눈금
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Ruler_Img")
mywindow:setTexture("Enabled",	"UIData/injection.tga", 0, 118)
mywindow:setTexture("Disabled", "UIData/injection.tga", 0, 118)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(42 , 22)
mywindow:setSize(190 , 35)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
--root:addChildWindow(mywindow)
winMgr:getWindow("Injecter_Body_Img"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 주사기 반짝임 효과
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Effect_Img")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(16, 52)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "Push_Light_EffectRender")
winMgr:getWindow("Injecter_SolutionPush_Img"):addChildWindow(mywindow)
function Push_Light_EffectRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	
	local tEffectPosX = { ['err'] = 0, [0] = 267, 283, 299, 331, 363, 395, 427 }
	
	if g_LightEffect > 0 then
		_drawer:drawTextureWithScale_Angle_Offset("UIData/injection.tga" , 0, 30, 105, 105, tEffectPosX[g_LightEffect], 58,   300, 300, 255, 0, 8, 0,0)
	end
end	-- end of function






-- 창 모두 닫기
function CloseInjecterEffect()
	-- 이펙트 종료됨을 명시 : 틱을 받지 못하게 리턴
	SetEffectControl(0)
	
	-- 주사기 이미지
	winMgr:getWindow("Injecter_Alpha"):setVisible(false)
	
	-- 검은 배경 알파 이미지
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(false)
	
	-- 주사기를 사용 하시겠습니까?
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_PopUp"):setVisible(false)
	
	-- EXP병 생성성공 팝업창
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):clearActiveController()
	
	-- 이펙트 관련 변수 초기화
	g_SolutionPushX = 42
	g_SolutionX = 0
end

-- 주사기 애니메이션 종료시에만 사용하는 Close함수
function CloseInjecterBody()
	-- 이펙트 종료됨을 명시 : 틱을 받지 못하게 리턴
	SetEffectControl(0)
	
	-- 주사기 이미지
	winMgr:getWindow("Injecter_Alpha"):setVisible(false)
	
	-- 주사기를 사용 하시겠습니까?
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_PopUp"):setVisible(false)
	
	-- EXP병 생성성공 팝업창
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):clearActiveController()
	
	-- 이펙트 관련 변수 초기화
	g_SolutionPushX = 42
	g_SolutionX = 0
end

--------------------------------------------------------------------
-- 아이템을 사용하시겠습니까? 알파
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_Popup_Alpha");
mywindow:setTexture('Enabled',	'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);
----------------------------------------------------------------------
-- 아이템을 사용하시겠습니까? 팝업
-----------------------------------------------------------------------
window = winMgr:createWindow("TaharezLook/StaticImage", "Injecter_PopUp")
window:setTexture("Enabled",	"UIData/Avata.tga", 339, 0)
window:setTexture("Disabled",	"UIData/Avata.tga", 339, 0)
window:setWideType(6)
window:setPosition(345, 200)
window:setSize(339 , 247)
window:setVisible(false)
window:setAlwaysOnTop(true)
window:setZOrderingEnabled(false)
root:addChildWindow(window)
------------------------------------------------------------
-- 아이템 사용 YES 버튼
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Injecter_PopUp_Ok")
mywindow:setTexture("Normal",	"UIData/Avata.tga", 774, 464)
mywindow:setTexture("Hover",	"UIData/Avata.tga", 774, 496)
mywindow:setTexture("Pushed",	"UIData/Avata.tga", 774, 528)
mywindow:setTexture("PushedOff","UIData/Avata.tga", 774, 560)
mywindow:setTexture("Enabled",	"UIData/Avata.tga", 774, 560)
mywindow:setTexture("Disabled",	"UIData/Avata.tga", 774, 560)
mywindow:setSize(89, 30)
mywindow:setPosition(70 , 195)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "Use_ItemInjecter")
--mywindow:subscribeEvent("Clicked", "ShowRewardNotifyMessage")
winMgr:getWindow('Injecter_PopUp'):addChildWindow(mywindow)
------------------------------------------------------------
-- 아이템 사용 NO 버튼
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Injecter_PopUp_No")
mywindow:setTexture("Normal",	"UIData/Avata.tga", 863, 464)
mywindow:setTexture("Hover",	"UIData/Avata.tga", 863, 496)
mywindow:setTexture("Pushed",	"UIData/Avata.tga", 863, 528)
mywindow:setTexture("PushedOff","UIData/Avata.tga", 863, 560)
mywindow:setTexture("Enabled",	"UIData/Avata.tga", 863, 560)
mywindow:setTexture("Disabled",	"UIData/Avata.tga", 863, 560)
mywindow:setSize(89, 30)
mywindow:setPosition(180 , 195)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "CloseInjecterEffect")
winMgr:getWindow('Injecter_PopUp'):addChildWindow(mywindow)
------------------------------------------------------------
-- 아이템을 사용할것인가를 물어보는 텍스트 
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Injecter_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 18)
mywindow:setPosition(100, 95)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setText("")
winMgr:getWindow("Injecter_PopUp"):addChildWindow(mywindow)


----------------------------------------------------------------------
-- Name : OpenInjecterPopup(expType)
-- Desc : 1. 팝업창 열기 (MyInventory.cpp에서 사용함)
----------------------------------------------------------------------
function OpenInjecterPopup(expType)
	-- 인젝터 모드 설정
	DebugStr("expType : " .. expType)
	g_NowInjecterType = expType
	
	-- 알파창 켜주기
	root:addChildWindow("Injecter_Popup_Alpha")
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(true)
	winMgr:getWindow("Injecter_Popup_Alpha"):setEnabled(true)
	
	-- 팝업창 열기
	root:addChildWindow("Injecter_PopUp")
	winMgr:getWindow("Injecter_PopUp"):setVisible(true)
	winMgr:getWindow("Injecter_PopUp_Ok"):setVisible(true)
	winMgr:getWindow("Injecter_PopUp_No"):setVisible(true)
	
	-- 스트링 설정 해주기
	local String = "" 
	
	if expType == 0 then
		String = g_STRING_SMALL_INJECTER
	elseif expType == 1 then
		String = g_STRING_MEDIUM_INJECTER
	elseif expType == 2 then
		String = g_STRING_LARGE_INJECTER
	elseif expType == 3 then
		String = g_STRING_X_LARGE_INJECTER
	end
	
	winMgr:getWindow("Injecter_Text"):setText(String)
end

----------------------------------------------------------------------
-- Name : function Use_ItemInjecter()
-- Desc : - 주사기 사용 - 
-- 사용하시겠습니까? OK버튼 클릭시 호출
----------------------------------------------------------------------
function Use_ItemInjecter()
	-- 인젝터 팝업을 모두 닫는다
	CloseInjecterEffect()
	
	local NeedExp = 0
	
	if g_NowInjecterType == 0 then
		NeedExp = SMALL_NEED_EXP
	elseif g_NowInjecterType == 1 then
		NeedExp = MEDIUM_NEED_EXP
	elseif g_NowInjecterType == 2 then
		NeedExp = LARGE_NEED_EXP
	elseif g_NowInjecterType == 3 then
		NeedExp = XLARGE_NEED_EXP
	end
	
	-- 1. 캐릭터 정보 얻어오기 ( MaxExp 아직 사용 안함 )
	local CurrentLevel , CurrentExp , MaxExp = GetMyCharacterData()
	
	-- 2. 예외처리
	if CheckLvExp(CurrentLevel , CurrentExp , NeedExp) == false then
		--CloseInjecterEffect() -- 창닫기
		DebugStr("Enable안으로 들어와서 리턴됨")	
		--return
	end
	
	-- 3. 모든 예외처리후 애니메이션 실행
	local AnimationEnd = StartInjecterEffect()
end

----------------------------------------------------------------------
-- Name : StartInjecterEffect()
-- Desc : 주사기 사용시 애니메이션 처리
----------------------------------------------------------------------
function StartInjecterEffect()
	-- 알파 열기 검은색
	root:addChildWindow("Injecter_Root_Alpha")
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(true)
	
	-- 인벤토리 닫기
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	
	-- 주사기 본체 열기
	root:addChildWindow("Injecter_Alpha")
	winMgr:getWindow("Injecter_Alpha"):setVisible(true)
	
	-- 1. 관련 변수 리셋
	EffectReset()
	
	-- 2. 이펙트 시작
	-- Desc :	C에서 return 패스 설정
	--			GetAnimationTick(time)함수가 호출되기 시작한다
	SetEffectControl(1) 
end

----------------------------------------------------------------------
-- Name : GetAnimationTick()
-- Desc : 애니메이션에 사용할 TIck받아오기
----------------------------------------------------------------------
function GetAnimationTick(time, LightEffect)
	-- 전역 변수 : 틱 저장
	g_InjectEffectTick	= time
	g_LightEffect		= LightEffect
	
	--DebugStr("[tick]g_InjectEffectTick : " .. g_InjectEffectTick)
	--DebugStr("[tick]g_LightEffect : " .. g_LightEffect)
	
	
	-- 전역 변수 : 현재 주사기 용량
	local SolutionSize = -1
	
	
	-- 주사액 차는 용량 설정 ★
	if g_NowInjecterType == 0 then
		SolutionSize = 10
	elseif g_NowInjecterType == 1 then
		SolutionSize = 13
	elseif g_NowInjecterType == 2 then
		SolutionSize = 16
	elseif g_NowInjecterType == 3 then
		SolutionSize = 19
	end
	
	
	-- 랜더링
	if g_InjectEffectTick < SolutionSize then
		RenderInjectEffect()
	else
		DebugStr("아이템 사용끝")
		
		-- 1. 이펙트에 관련된 변수들 초기화
		EffectReset()
		
		-- 2. 이펙트 끝 : C에서 tick을 받지 못하게 리턴 시킨다
		SetEffectControl(0)
		
		-- 3. 서버에 패킷 전송
		RequestUseInject(0) -- 인자 = 경험치 타입 : 수정해야함 지금은 그냥 고정값만.. 
		
		-- 4. 화면 클리어
		--CloseInjecterBody()
	end
end

----------------------------------------------------------------------
-- Name : RenderInjectEffect()
-- Desc : 애니메이션 랜더링
----------------------------------------------------------------------
function RenderInjectEffect()
	if g_InjectEffectTick > 0 then
		if g_SolutionPushX >= 257 then
			DebugStr("X좌표가 200이상이라 리턴")
			SetEffectControl(2)	-- 이펙트 끝
			g_SolutionPushX = 42
			g_SolutionX = 0
			return
		end
		
		g_SolutionPushX = g_SolutionPushX + g_InjectEffectTick
		g_SolutionX		= (g_SolutionX + g_InjectEffectTick) - 1
		
		winMgr:getWindow("Injecter_SolutionPush_Img"):setPosition(g_SolutionPushX , 9)
		winMgr:getWindow("Injecter_Solution_Img"):setSize(g_SolutionX , 37)
		
		winMgr:getWindow("Injecter_Effect_Img"):setVisible(true)
	end
end

----------------------------------------------------------------------
-- Name : CheckLvExp(level , exp, NeedExp)
-- Desc : 주사기를 사용할수 있는지 레벨과 경험치를 체크한다
----------------------------------------------------------------------
function CheckLvExp(MyCurrLevel , MyCurrExp , NeedExp)
	-- 1. 만렙인지 체크
	if MyCurrLevel >= MAX_LEVEL then
		ShowNotifyOKMessage_Lua("NOW MAX LEVEL")
		return false
	end
	
	-- 2. 현재 경험치가 충분한가
	if MyCurrExp < NeedExp then
		ShowNotifyOKMessage_Lua("not enough exp")
		return false
	end
	
	return true
end

		-- end of 2방안	--


]]--

