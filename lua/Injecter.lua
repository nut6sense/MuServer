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
-- ESC / ENTER �̺�Ʈ ���
--=====================================================================
RegistEscEventInfo("Injecter_PopUp" , "CloseInjecterEffect")
RegistEnterEventInfo("Injecter_Reward_Popup_Alpha","CloseInjectEvent")

--=====================================================================
-- ������
--=====================================================================
-- Modify by Jiyuu
--local MAX_LEVEL			= 50	-- �ѱ� 40 , �̱�,�±� = 50
-- Jiyuu : ��������
local MAX_LEVEL			= 60	-- �ѱ� 40 , �̱�,�±� = 50
local SMALL_NEED_EXP	= 10000
local MEDIUM_NEED_EXP	= 30000
local LARGE_NEED_EXP	= 50000
local XLARGE_NEED_EXP	= 100000

--=====================================================================
-- ��������
--=====================================================================
local g_NowInjecterType		= -1	-- ���õ� ������ type
local g_InjectEffectTick	= 0		-- ������ ����Ʈ ƽ
local g_LightEffect			= 0		-- ��½�̴� ����Ʈ

--=====================================================================
-- ��Ʈ�� �ε�
--=====================================================================
local g_STRING_NOT_ENOUGH_EXP	 = PreCreateString_4190	--GetSStringInfo(LAN_INJECTOR_001)	-- ������ ����ġ�� �����մϴ�
local g_STRING_ALREADY_MAX_LEVEL = PreCreateString_4193	--GetSStringInfo(LAN_INJECTOR_004)	-- ����ġ�� �� �̻� ȹ���� �� �����ϴ�.


--------------------------------------------------------------------
-- �޹��(������) ���� ������
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
-- �ֻ�� ����â ����
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
-- �ֻ�� ����â
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
-- �ֻ�� 1 ~ 4 ���� ������
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
-- �ֻ�� ȸ�� ����Ʈ
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
		DebugStr("Injecter_Spin() ī��Ʈ ���� : " .. count)
		return
	end
	
	-- ���� ���
	if count == 1 then
		PlayWave('sound/Clone_Success.wav');
	end
	
	winMgr:getWindow("Injecter_Spin_Effect_" .. count):setVisible(true)
	
	if count == 8 then
		for i=1 , #tSpinAnimationX do
			winMgr:getWindow("Injecter_Spin_Effect_" .. i):setVisible(false)
		end
		
		-- ���� ����
		SetBoomFlag(true)
	end
end

----------------------------------------------------------------------
-- �ֻ�� ���� ����Ʈ
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
		DebugStr("Injecter_Boom() ī��Ʈ ���� : " .. count)
		return
	end
	
	winMgr:getWindow("Injecter_Boom_Effect_" .. count):setVisible(true)
	--DebugStr("���� : " .. count)
	
	if count == 8 then
		for i=1 , #tSpinAnimationX do
			winMgr:getWindow("Injecter_Boom_Effect_" .. i):setVisible(false)
		end
		
		-- �� �׷��ֱ�
		SetBottleIcon()
		
		-- ������ ����� ��û
		RequestUseInject()
	end
end

-- ������ ���� ù ȣ��Ǵ� �Լ�
-- �κ��丮���� ������ ��� ---> ������ Ÿ�� ���� -> SetLightOn() �Լ� ȣ��....
function SetLightOn()
	DebugStr("SetLightOn() ȣ��")
	
	-- �޹�� ���
	root:addChildWindow("Injecter_Root_Alpha")
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(true)
	
	-- ����â ��ġ �� ����
	local x, y = GetWindowSize()
	x = (x/2) - (274/2)
	y = (y/2) - (200)
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setPosition(x,y)
	
	-- ����ó�� : ������ ������ �ѹ��� �ùٸ���
	if GetUseNumber() == -1 then
		ShowNotifyOKMessage_Lua("Injecter Num is -1 : error")
		CloseInjectEvent()
		return
	end
	
	-- ĳ���� ���� ������
	local CurrentLevel , CurrentExp , MaxExp , NeedExp = GetMyCharacterData()
	
	-- ������ ����ġ�� ������� üũ
	if CurrentExp < NeedExp then
		ShowNotifyOKMessage_Lua(g_STRING_NOT_ENOUGH_EXP)
		CloseInjectEvent()
		return
	end
	
	-- ���� ���
	PlayWave('sound/Injecter_Use.wav');
		
	-- Ű �Է� / ���콺 �Է��� ���´�
	SetKeyInputControl()
	
	-- ���� ������ ON
	root:addChildWindow(winMgr:getWindow("Injecter_MainWnd_Alpha"))
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setVisible(true)
	
	-- ���� �������� ����� ������ �������� ����
	SetInjecterIcon()
	
	-- Ÿ�Կ� �°Բ� ������ ���ش�
	SetInjecterRamp()
end

-- ���� ��Ű�� �Լ�
function SetRampOn(count)
	if count <= 0 or count > 4 then
		DebugStr("������ ī��Ʈ �Է� ���� : " .. count)
		return
	end
	
	winMgr:getWindow("Injecter_Light_Button_" .. count):setVisible(true)
end

----------------------------------------------------------------------
-- ����� �ܰ躰 �ֻ�� ������
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
-- ������ �ܰ躰 EXP ��
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
-- �ֻ�� ��� �Ϸ� ���� �˾�â
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
-- �ֻ�� ��� �Ϸ� �˾�â
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
-- �ֻ�� ��� �Ϸ� �˾� Ȯ�ι�ư
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
	-- ����â ����
	winMgr:getWindow("Injecter_MainWnd_Alpha"):setVisible(false)
	
	-- �ֻ��/EXP���� �����ܵ� ����
	winMgr:getWindow("Injecter_Make_Bottle"):setVisible(false)
	winMgr:getWindow("Injecter_Use_Icon"):setVisible(false)
	winMgr:getWindow("Injecter_Complate_Bottle"):setVisible(false)

	-- ������ ����
	for i=1 , 4 do
		winMgr:getWindow("Injecter_Light_Button_" .. i):setVisible(false)
	end

	-- ���� ���� �˾� ����
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)

	-- ����â ����
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(false)
end

----------------------------------------------------------------------
-- �Ϸ� â�� ��� EXP ��
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
	--DebugStr("���õ� EXP�� FileName : " .. FileName)
	
	winMgr:getWindow("Injecter_Complate_Bottle"):setTexture("Enabled" , FileName , 0, 0)
	winMgr:getWindow("Injecter_Complate_Bottle"):setTexture("Disabled", FileName , 0, 0)
	winMgr:getWindow("Injecter_Complate_Bottle"):setScaleWidth(180)
	winMgr:getWindow("Injecter_Complate_Bottle"):setScaleHeight(180)
	
	winMgr:getWindow("Injecter_Complate_Bottle"):setVisible(true)
end

----------------------------------------------------------------------
-- Name : function Use_ItemExpBottle(expType)
-- Desc : Exp�� ���
----------------------------------------------------------------------
function Use_ItemExpBottle(expType)
	local CurrentLevel , CurrentExp , NextLvUpTable = GetExpBottleData()
	
	-- �����̸鼭 ����ġ�� 99%�� ���¸� ���´�.
	-- ���̻� �Ծ���� �ǹ̰� �����Ƿ�.......
	local RemainEXP = NextLvUpTable - CurrentExp
	
	if CurrentLevel == MAX_LEVEL and RemainEXP == 1 then
		ShowNotifyOKMessage_Lua(g_STRING_ALREADY_MAX_LEVEL)
		return
	end
	
	-- 2. ���� and EXP99%���¶�� EXP �� ����� ���´�
	RequestExpBottle()
end


----------------------------------------------------------------------
-- Name : function ShowRewardNotifyMessage()
-- Desc : �����˾�â ������
----------------------------------------------------------------------
function ShowRewardNotifyMessage()
	-- ����â ��ġ �� ����
	local x, y = GetWindowSize()
	x = (x/2) - (338/2)
	y = (y/2) - (70)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setPosition(x,y)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):activeMotion("Injecter_Controller");
	root:addChildWindow(winMgr:getWindow("Injecter_Reward_Popup_Alpha"))
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(true)
	
	-- ����â�� EXP�� �׸���
	DrawComplateBottleIcon()
end


----------------------------------------------------------------------
-- Name : function AnswerUseExpBottleSuccess(nExpString)
-- Desc : EXP�� ��� ����
----------------------------------------------------------------------
function AnswerUseExpBottleSuccess(nExpString)
	root:addChildWindow(winMgr:getWindow("NM_NotifyConfirmMain"))
	
	ShowNotifyOKMessage(nExpString)	-- %d�� ����ġ�� ������ϴ�.
end

-- EXP�� ��� ����
function AnswerUseExpBottleFaild()
	root:addChildWindow(winMgr:getWindow("NM_NotifyConfirmMain"))
	ShowNotifyOKMessage("ExpBottle Use Failed")
end





















--[[
--========================================================================

-- Old Injecter 
-- ���� �����. �� ���ƾ����� -_-..............

--========================================================================
----------------------------------------------------------------------
-- �ֻ�� ������â ����
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
-- �ֻ�� ������â ����
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
-- �ֻ�� ������â ����
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
-- �ֻ�� ������â ���Ծ�
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
-- �Ӹ��� �ֻ�� ����Ʈ ����
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
-- �Ӹ��� �ֻ�� ����Ʈ
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
-- ��� ���� ������ ����â
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
	-- ���� ������ ����
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

	-- end of 1���	--



--========================================================================

-- 2��° ��� : Ŀ�ٶ� �ֻ��

--========================================================================
----------------------------------------------------------------------
-- �ֻ�� �ֻ��� ����
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
-- �ֻ�� ��ü
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
-- �ֻ�� �� (���)
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
-- �ֻ�� ��ü ��Ʈ�Ӹ�
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
-- �ֻ�� �� ���Ա�
-----------------------------------------------------------------------
g_SolutionPushX = 42	-- ���Ա� ������X
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
-- �ֻ�� ����
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
-- �ֻ�� ��¦�� ȿ��
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






-- â ��� �ݱ�
function CloseInjecterEffect()
	-- ����Ʈ ������� ��� : ƽ�� ���� ���ϰ� ����
	SetEffectControl(0)
	
	-- �ֻ�� �̹���
	winMgr:getWindow("Injecter_Alpha"):setVisible(false)
	
	-- ���� ��� ���� �̹���
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(false)
	
	-- �ֻ�⸦ ��� �Ͻðڽ��ϱ�?
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_PopUp"):setVisible(false)
	
	-- EXP�� �������� �˾�â
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):clearActiveController()
	
	-- ����Ʈ ���� ���� �ʱ�ȭ
	g_SolutionPushX = 42
	g_SolutionX = 0
end

-- �ֻ�� �ִϸ��̼� ����ÿ��� ����ϴ� Close�Լ�
function CloseInjecterBody()
	-- ����Ʈ ������� ��� : ƽ�� ���� ���ϰ� ����
	SetEffectControl(0)
	
	-- �ֻ�� �̹���
	winMgr:getWindow("Injecter_Alpha"):setVisible(false)
	
	-- �ֻ�⸦ ��� �Ͻðڽ��ϱ�?
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_PopUp"):setVisible(false)
	
	-- EXP�� �������� �˾�â
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):setVisible(false)
	winMgr:getWindow("Injecter_Reward_Popup_Alpha"):clearActiveController()
	
	-- ����Ʈ ���� ���� �ʱ�ȭ
	g_SolutionPushX = 42
	g_SolutionX = 0
end

--------------------------------------------------------------------
-- �������� ����Ͻðڽ��ϱ�? ����
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
-- �������� ����Ͻðڽ��ϱ�? �˾�
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
-- ������ ��� YES ��ư
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
-- ������ ��� NO ��ư
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
-- �������� ����Ұ��ΰ��� ����� �ؽ�Ʈ 
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
-- Desc : 1. �˾�â ���� (MyInventory.cpp���� �����)
----------------------------------------------------------------------
function OpenInjecterPopup(expType)
	-- ������ ��� ����
	DebugStr("expType : " .. expType)
	g_NowInjecterType = expType
	
	-- ����â ���ֱ�
	root:addChildWindow("Injecter_Popup_Alpha")
	winMgr:getWindow("Injecter_Popup_Alpha"):setVisible(true)
	winMgr:getWindow("Injecter_Popup_Alpha"):setEnabled(true)
	
	-- �˾�â ����
	root:addChildWindow("Injecter_PopUp")
	winMgr:getWindow("Injecter_PopUp"):setVisible(true)
	winMgr:getWindow("Injecter_PopUp_Ok"):setVisible(true)
	winMgr:getWindow("Injecter_PopUp_No"):setVisible(true)
	
	-- ��Ʈ�� ���� ���ֱ�
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
-- Desc : - �ֻ�� ��� - 
-- ����Ͻðڽ��ϱ�? OK��ư Ŭ���� ȣ��
----------------------------------------------------------------------
function Use_ItemInjecter()
	-- ������ �˾��� ��� �ݴ´�
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
	
	-- 1. ĳ���� ���� ������ ( MaxExp ���� ��� ���� )
	local CurrentLevel , CurrentExp , MaxExp = GetMyCharacterData()
	
	-- 2. ����ó��
	if CheckLvExp(CurrentLevel , CurrentExp , NeedExp) == false then
		--CloseInjecterEffect() -- â�ݱ�
		DebugStr("Enable������ ���ͼ� ���ϵ�")	
		--return
	end
	
	-- 3. ��� ����ó���� �ִϸ��̼� ����
	local AnimationEnd = StartInjecterEffect()
end

----------------------------------------------------------------------
-- Name : StartInjecterEffect()
-- Desc : �ֻ�� ���� �ִϸ��̼� ó��
----------------------------------------------------------------------
function StartInjecterEffect()
	-- ���� ���� ������
	root:addChildWindow("Injecter_Root_Alpha")
	winMgr:getWindow("Injecter_Root_Alpha"):setVisible(true)
	
	-- �κ��丮 �ݱ�
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	
	-- �ֻ�� ��ü ����
	root:addChildWindow("Injecter_Alpha")
	winMgr:getWindow("Injecter_Alpha"):setVisible(true)
	
	-- 1. ���� ���� ����
	EffectReset()
	
	-- 2. ����Ʈ ����
	-- Desc :	C���� return �н� ����
	--			GetAnimationTick(time)�Լ��� ȣ��Ǳ� �����Ѵ�
	SetEffectControl(1) 
end

----------------------------------------------------------------------
-- Name : GetAnimationTick()
-- Desc : �ִϸ��̼ǿ� ����� TIck�޾ƿ���
----------------------------------------------------------------------
function GetAnimationTick(time, LightEffect)
	-- ���� ���� : ƽ ����
	g_InjectEffectTick	= time
	g_LightEffect		= LightEffect
	
	--DebugStr("[tick]g_InjectEffectTick : " .. g_InjectEffectTick)
	--DebugStr("[tick]g_LightEffect : " .. g_LightEffect)
	
	
	-- ���� ���� : ���� �ֻ�� �뷮
	local SolutionSize = -1
	
	
	-- �ֻ�� ���� �뷮 ���� ��
	if g_NowInjecterType == 0 then
		SolutionSize = 10
	elseif g_NowInjecterType == 1 then
		SolutionSize = 13
	elseif g_NowInjecterType == 2 then
		SolutionSize = 16
	elseif g_NowInjecterType == 3 then
		SolutionSize = 19
	end
	
	
	-- ������
	if g_InjectEffectTick < SolutionSize then
		RenderInjectEffect()
	else
		DebugStr("������ ��볡")
		
		-- 1. ����Ʈ�� ���õ� ������ �ʱ�ȭ
		EffectReset()
		
		-- 2. ����Ʈ �� : C���� tick�� ���� ���ϰ� ���� ��Ų��
		SetEffectControl(0)
		
		-- 3. ������ ��Ŷ ����
		RequestUseInject(0) -- ���� = ����ġ Ÿ�� : �����ؾ��� ������ �׳� ��������.. 
		
		-- 4. ȭ�� Ŭ����
		--CloseInjecterBody()
	end
end

----------------------------------------------------------------------
-- Name : RenderInjectEffect()
-- Desc : �ִϸ��̼� ������
----------------------------------------------------------------------
function RenderInjectEffect()
	if g_InjectEffectTick > 0 then
		if g_SolutionPushX >= 257 then
			DebugStr("X��ǥ�� 200�̻��̶� ����")
			SetEffectControl(2)	-- ����Ʈ ��
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
-- Desc : �ֻ�⸦ ����Ҽ� �ִ��� ������ ����ġ�� üũ�Ѵ�
----------------------------------------------------------------------
function CheckLvExp(MyCurrLevel , MyCurrExp , NeedExp)
	-- 1. �������� üũ
	if MyCurrLevel >= MAX_LEVEL then
		ShowNotifyOKMessage_Lua("NOW MAX LEVEL")
		return false
	end
	
	-- 2. ���� ����ġ�� ����Ѱ�
	if MyCurrExp < NeedExp then
		ShowNotifyOKMessage_Lua("not enough exp")
		return false
	end
	
	return true
end

		-- end of 2���	--


]]--

