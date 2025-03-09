--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
--PN_IME == protect Number IME


local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local PASSWORD_NOT_SELECT	= -1
local PASSWORD_ONE			= 1
local PASSWORD_TWO			= 2
local PASSWORD_THREE		= 3
local PASSWORD_FOUR			= 4

------------------------------------------------------
-- [보안 번호] 화면 전체적으로 덮는 알파 윈도우
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PNIME_AlphaWindow")
mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0 , 0) 
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------
-- [보안 번호] 메인 윈도우 부모 알파
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PNIME_ROOT_AlphaWindow")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2) - 165, (g_MAIN_WIN_SIZEY / 2) - 165)
mywindow:setSize(328, 347)
mywindow:setVisible(false)
mywindow:setAlpha(150)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------
-- [보안 번호] 메인 윈도우
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PNIME_MainWindow")
mywindow:setTexture("Enabled",	"UIData/Login002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Login002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setWideType(6)
mywindow:setPosition(0, 0)
mywindow:setSize(328, 347)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PNIME_ROOT_AlphaWindow"):addChildWindow(mywindow)

------------------------------------------------------------------------------------------
-- [보안 번호] 보안 번호를 입력하세요
------------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PNIME_Input_1stImage")
mywindow:setTexture("Enabled",	"UIData/Login002.tga", 512, 0)
mywindow:setTexture("Disabled", "UIData/Login002.tga", 512, 0)
mywindow:setPosition(12 , 45) 
mywindow:setSize(298, 48)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PNIME_MainWindow"):addChildWindow(mywindow)

------------------------------------------------------
-- [2차 비밀번호] 메인 윈도우 "확인"버튼
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "PNIME_MainWindow_OKButton")
mywindow:setTexture("Normal",	"UIData/Login002.tga", 334, 0)
mywindow:setTexture("Hover",	"UIData/Login002.tga", 334, 32)
mywindow:setTexture("Pushed",	"UIData/Login002.tga", 334, 64)
mywindow:setTexture("PushedOff","UIData/Login002.tga", 334, 64)
mywindow:setSize(89, 32)
mywindow:setEnabled(true)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setAlpha(10)
mywindow:setPosition(120, 305)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "RequestSubmitPN")
winMgr:getWindow("PNIME_MainWindow"):addChildWindow(mywindow)

-----------------------------------------------------
-- RequestSubmitProtectNumber()
-- OK버튼 클릭시 이벤트
------------------------------------------------------
function RequestSubmitPN()
	SendProtectNum();	
end


------------------------------------------------------
-- AllCloseSecondPassWord()
-- 첫번째 비밀번호 설정후 확인버튼 클릭시 함수
------------------------------------------------------
function AllCloseSecondPassWord()
	winMgr:getWindow("PNIME_ROOT_AlphaWindow"):setVisible(false)
	winMgr:getWindow("PNIME_MainWindow"):setVisible(false)
	winMgr:getWindow("PNIME_AlphaWindow"):setVisible(false)
end


------------------------------------------------------
-- 보안 번호 (숫자)
------------------------------------------------------
local nButtonSize = 3
local nCntX = 0
local nCntY = 0

for i=0, nButtonSize do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"PN_" .. i)
	mywindow:setTexture("Normal",		"UIData/Login002.tga",	( 30 * (i-1) ), 362)
	mywindow:setPosition( (50 * i) + 63 - 48, 103 - 35 )
	mywindow:setSize(32, 32)
	mywindow:setVisible(true)
	mywindow:setUserString("SecondButton", i)
	winMgr:getWindow('PNIME_MainWindow'):addChildWindow(mywindow)
end

------------------------------------------------------
-- 키패드 버튼 (숫자)
------------------------------------------------------
local nButtonSize = 10
local nCntX = 0
local nCntY = 0

for i=1, nButtonSize do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"Second_PN_" .. i)
	mywindow:setTexture("Normal",		"UIData/Login002.tga",	( 70 * (i-1) ), 362)
	mywindow:setTexture("Hover",		"UIData/Login002.tga",	( 70 * (i-1) ), 387)
	mywindow:setTexture("Pushed",		"UIData/Login002.tga",	( 70 * (i-1) ), 412)
	mywindow:setTexture("PushedOff",	"UIData/Login002.tga",	( 70 * (i-1) ), 362)	
	
	if i ~= 10 then
		-- 1 ~ 9 까지
		mywindow:setPosition( (70 * nCntX) + 63 , (25 * nCntY) + 203 )
	else
		-- 0 버튼만 따로 설정
		mywindow:setPosition( (70 * 1) + 63 , (25 * nCntY) + 203 )
	end
	
	-- X Count 설정
	if nCntX >= 2 then
		nCntX = 0
	else
		nCntX = nCntX + 1
	end
	
	-- Y Count 설정
	if i % 3 == 0 then
		nCntY = nCntY + 1
	end	
	

	mywindow:setSize(70, 25)
	mywindow:setVisible(false)
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "OnClickedPN_BT")
	mywindow:setUserString("SecondButton", i)
	winMgr:getWindow('PNIME_MainWindow'):addChildWindow(mywindow)
end


------------------------------------------------------
-- tProtectNumButtonClickEvent()
-- 첫번째 비밀번호 설정후 확인버튼 클릭시 함수
------------------------------------------------------ rkatk
function OnClickedPN_BT(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("SecondButton"))
	
	g_bPassWordFullSelected = InputPN(index)
	
	if g_bPassWordFullSelected then
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setEnabled(true)
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 0)
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 32)
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 64)
		winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 64)
		DebugStr("첫번째 비밀번호 설정후 확인버튼 클릭시 함수_________true")
	end
end

------------------------------------------------------
-- 지우기 ,  섞기 버튼
------------------------------------------------------
tModeButtonTexPosX = { ['err'] = 0,		700,	770 }
for j=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"Second_PN_Mode_" .. j)
	mywindow:setTexture("Normal",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 362)
	mywindow:setTexture("Hover",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 387)
	mywindow:setTexture("Pushed",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 412)
	mywindow:setTexture("PushedOff","UIData/Login002.tga",	tModeButtonTexPosX[j] , 362)	
	
	if j == 1 then			-- 1번 버튼
		mywindow:setPosition( 60, 230 )
	elseif j == 2 then		-- 2번 버튼
		mywindow:setPosition( 200 , 230 )
	end
	
	mywindow:setSize(70, 25)
	--mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setEnabled(true)

	mywindow:subscribeEvent("Clicked", "tSecondPassWordClickModeEvent")
	mywindow:setUserString("SecondModeButton", j)
	winMgr:getWindow('PNIME_MainWindow'):addChildWindow(mywindow)
end

------------------------------------------------------
-- tSecondPassWordClickModeEvent()
-- 지우기 , 섞기 이벤트
------------------------------------------------------
function tSecondPassWordClickModeEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("SecondModeButton"))
	
	ClearPN(index)
	
	-- 확인버튼 비활성화
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setEnabled(false)
		DebugStr("PNIME_MainWindow_OKButton_________false")	
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login002.tga", 334, 96)
end


------------------------------------------------------
-- MakeNumberTable()
-- 배열을 받아서 테이블을 생성시킨다
------------------------------------------------------
g_tNumberBuff = {}

function MakeNTable(index , number)
	-- index의	시작은	1
	--			끝은	10
	
	g_tNumberBuff[index] = number
end

------------------------------------------------------
-- MakeProtectNumTable()
-- 배열을 받아서 테이블을 생성시킨다
------------------------------------------------------
g_tProtectNumberBuff = {}

function MakePNTable(index , number)
	DebugStr("MakePNTable2")
	g_tProtectNumberBuff[index] = number
	DebugStr("MakePNTable3")
end


------------------------------------------------------
-- SetRandomNumberPosition()
-- 버튼 포지션 랜덤하게 설정
------------------------------------------------------
function SetRandomNumPosition()
	DebugStr("SetRandomNumPosition")
	local nCntX = 0
	local nCntY = 0
	
	for i = 1 , 10 do
		if i ~= 10 then
			-- 1 ~ 9 버튼 설정
			winMgr:getWindow("Second_PN_" .. g_tNumberBuff[i]):setPosition( (70 * nCntX) + 60 , (25 * nCntY) + 155 )
		else
			-- 0 버튼만 따로 설정
			winMgr:getWindow("Second_PN_" .. g_tNumberBuff[i]):setPosition( (70 * 1) + 60 , (25 * nCntY) + 155 )
		end
		
		-- X Count 설정
		if nCntX >= 2 then
			nCntX = 0
		else
			nCntX = nCntX + 1
		end
		
		-- Y Count 설정
		if i % 3 == 0 then
			nCntY = nCntY + 1
		end
		DebugStr("SetRandomNumPosition : " .. i)
	end	-- end of for
	
end	-- end of function

---------------------------------------------------------------------
-- SetProtectNumberImage()
-- 보안 숫자를 표시하는 숫자 이미지의 숫자를 설정 및 표시 위치를 설정
---------------------------------------------------------------------
function SetPNImage()
	
	local nCntX = 0
	local nCntY = 0
	for i = 0 , 3 do
		winMgr:getWindow("PN_" .. i):setTexture("Normal",		"UIData/Login002.tga",	( 32 * (g_tProtectNumberBuff[i] - 1) ), 439)
		winMgr:getWindow("PN_" .. i):setPosition( (50 * (i + 1 )) + 20, 90 )
	end
end


------------------------------------------------------
-- SetPassWordStarVisible()
-- 암호화 *모양 버튼 설정함수
------------------------------------------------------
function SetPNStarVisible(StarNumber)
	DebugStr("SetPNStarVisible !!!!!! StarNumber = " .. StarNumber)

	if StarNumber == PASSWORD_NOT_SELECT then -- (-1)
		DebugStr("PASSWORD_NOT_SELECT")
		for i = 1 , 4 do
			winMgr:getWindow("Second_PN_SecretStar_" .. i):setVisible(false)
		end
	elseif StarNumber == 0 then -- 1
		DebugStr("PASSWORD_NOT_SELE- ==== 0")
		for i = 1 , 4 do
			winMgr:getWindow("Second_PN_SecretStar_" .. i):setVisible(false)
		end
	elseif StarNumber == PASSWORD_ONE then -- 1
		DebugStr("스타넘버 1")
		winMgr:getWindow("Second_PN_SecretStar_1"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_2"):setVisible(false)
		winMgr:getWindow("Second_PN_SecretStar_3"):setVisible(false)
		winMgr:getWindow("Second_PN_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_TWO then -- 2
		DebugStr("스타넘버 2")
		winMgr:getWindow("Second_PN_SecretStar_1"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_2"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_3"):setVisible(false)
		winMgr:getWindow("Second_PN_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_THREE then -- 3
		--DebugStr("스타넘버 3")
		winMgr:getWindow("Second_PN_SecretStar_1"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_2"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_3"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_FOUR then -- 4
		--DebugStr("스타넘버 4")	
		winMgr:getWindow("Second_PN_SecretStar_1"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_2"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_3"):setVisible(true)
		winMgr:getWindow("Second_PN_SecretStar_4"):setVisible(true)
	end
	
end

------------------------------------------------------
-- [2차 비밀번호] 별 모양 이미지
------------------------------------------------------
for i=1 , 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Second_PN_SecretStar_" .. i)
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 334, 256)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 334, 256)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(95 + (22*i) , 265)
	mywindow:setSize(22, 22)
	mywindow:setUserString("StarNumber_" .. i , -1)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PNIME_MainWindow"):addChildWindow(mywindow)
end









------------------------------------------------------
-- ● 비밀번호 최상위 함수 ●
------------------------------------------------------
function SecondPassWordRootFunc()
	SecondPassWordRootFunction()
end


-- 2차 비밀번호 활성화 셋팅 함수
function SetModeButtonEnable(bFirst , bSecond)
	
	winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(bFirst)
	if bFirst then
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 0)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 37)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 74)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 74)
	elseif bFirst == false then
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 111)
	end
	
	
	winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(bSecond)
	if bSecond then
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 148)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 185)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 222)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 222)
	elseif bSecond == false then
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 259)
	end
	
end

function ShowIME(ProtectNum)
	DebugStr("CheckSecondPassWord 체크1" .. ProtectNum)
	-- 시작할때 한번 리셋을 시켜준다
	AllCloseSecondPassWord()
	
	root:addChildWindow(winMgr:getWindow("PNIME_AlphaWindow"))
	winMgr:getWindow("PNIME_AlphaWindow"):setVisible(true)
	DebugStr("CheckSecondPassWord 체크2")
	
	--초기화
	ClearPN(0)
	
	-- 상황에 맞는 안내문구 넣기
	winMgr:getWindow("PNIME_Input_1stImage"):setVisible(true)
	
	-- 확인버튼 비활성화
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setEnabled(false)
	DebugStr("확인버튼 비활성화_________false")		
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login002.tga", 334, 96)
	DebugStr("CheckSecondPassWord 체크3")

	winMgr:getWindow("PNIME_ROOT_AlphaWindow"):setVisible(true)
	winMgr:getWindow("PNIME_MainWindow"):setVisible(true)
	winMgr:getWindow("PNIME_MainWindow"):setAlwaysOnTop(true)
	winMgr:getWindow("PNIME_MainWindow_OKButton"):setVisible(true)
	DebugStr("CheckSecondPassWord 체크4")
	for i = 1 , 10 do
		winMgr:getWindow("Second_PN_" .. i):setVisible(true)
	end
	
	for j = 1 , 2 do
		winMgr:getWindow("Second_PN_Mode_" .. j):setVisible(true)
	end
	
	DebugStr("CheckSecondPassWord 체크5")
end

function HideIME()
	root:addChildWindow(winMgr:getWindow("PNIME_AlphaWindow"))
	winMgr:getWindow("PNIME_AlphaWindow"):setVisible(false)
	winMgr:getWindow("PNIME_ROOT_AlphaWindow"):setVisible(false)
end






