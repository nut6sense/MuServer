--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local MAX_BET = 100			-- �ִ� ���ñݾ�
local RATE_RESULT = 5		-- ��� �ݾ� ����
local MONETARYUNIT = 1000	-- �� ����

local g_Result = 0			-- �ֻ��� ���

-- ���â ���� �ִϸ��̼�
local HIGHLIGHT_NONE = 0
local HIGHLIGHT_INCREASING = 1
local HIGHLIGHT_DECREASING = 2
local MIN_SIZE_HIGHLIGHT = 100000
local MAX_SIZE_HIGHLIGHT = 170000
local SPEED_HIGHLIGHT = 5

local g_Highlight = HIGHLIGHT_NONE
local g_SizeHighlight = MIN_SIZE_HIGHLIGHT

local g_Playing = false -- ���� ����

--[[

public: -- windows

	DiceplayAlphaImage	-- �ֻ�������â �����̹���
	DiceplayBackground	-- ��ü �ֻ�������â
	{
	--	Diceplay_Titlebar			-- Ÿ��Ʋ��(������, ����������)
	--	Diceplay_CloseBtn			-- �ݱ��ư
		
		Diceplay_Number_1~6			-- �ֻ��� �̹���
		Diceplay_Bet_1~6			-- ���ñݾ�
		Diceplay_Result_1~6			-- ����ݾ� �̹��� ���
			Diceplay_Result_1~6_1~15-- ����ݾ� ���� �̹�����
		
		Diceplay_StartButton		-- ���۹�ư
		Diceplay_Zen				-- ��
		
	} -- end of DiceplayBackground


	DiceResultBackground	-- ��ü �ֻ������Ӱ��â
	{
		DiceResult_TitleImage	-- Ÿ��Ʋ�̹���
		DiceResult_Titlebar		-- Ÿ��Ʋ��(������, ����������)
		DiceResult_Label_Number	-- ���̺�(����)
		DiceResult_Label_Bet	-- ���̺�(���ñݾ�)
		DiceResult_Label_Result	-- ���̺�(���)
		DiceResult_FrameBack_1~6-- ������
			DiceResult_FrameImage1_1_6	-- �����̹���
			DiceResult_FrameImage2_1_6	-- ��
				DiceResult_FrameImage3_1_6	-- �����̹���
					DiceResult_FrameImage4_1_6	-- �����̹��� �ִϸ��̼�
			DiceResult_Number_1~6		-- �ֻ��� �̹���
			DiceResult_BetText_1~6		-- �ؽ�Ʈ�� �� ���ñݾ�
			DiceResult_Bet_1~6			-- ���ñݾ� ���
				DiceResult_Bet_1~6_1~15	-- ���ñݾ� �����̹���
		
		DiceResult_Label_Sum	-- ���̺�(��÷�ݾ�)
		DiceResult_BackImage_Sum-- ��÷�ݾ� ���
		DiceResult_Sum			-- ��÷�ݾ�
		
		DiceResult_OKButton		-- Ȯ�ι�ư
		
	} -- end of DiceResultBackground


public: -- functions

	function Diceplay_Show()			-- �ֻ�������â�� ����
	function Diceplay_Close()			-- �ֻ�������â�� �ݴ´�
	function Diceplay_SetVisible( b )	-- �ֻ�������â�� visible�� �����Ѵ�
	function Diceplay_Init()			-- �ʱ�ȭ
	function Diceplay_Render()			-- �����Լ�
	function Diceplay_GetSum()			-- �� ���ñݾ��� �ջ�
		
	function SetImageNumbers( winName, number )	-- �����̹��� �����Լ�

	function DiceResult_Show()			-- �ֻ������Ӱ��â�� ����
	function DiceResult_Close()			-- �ֻ������Ӱ��â�� �ݴ´�
	function DiceResult_SetVisible( b )	-- �ֻ������Ӱ��â�� visible�� �����Ѵ�
	function DiceResult_Init( index, result )	-- ���â �ʱ�ȭ
	function DiceResult_Highlight( b )	-- ���̶���Ʈ
	
	function OnActivated_Bet(args)		-- Editbox Ȱ��ȭ �̺�Ʈ

	function OnClicked_BetBack(args)	-- Editbox �̵� �̺�Ʈ
	function OnTextChanged_Edit(args)	-- Editbox ���� �̺�Ʈ
	function OnEditBoxFull(args)		-- EditBox�� ��á������ �̺�Ʈ
	function OnPressTab_Edit(args)		-- EditBox�鿡�� Tab�� ������ ���� �̺�Ʈ
	function OnClicked_StartDice(args)	-- ���۹�ư
	function OnClicked_OK(args)			-- Ȯ�ι�ư
	
]]--








-- ���� �̹���
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


-- �⺻ ���� ������
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


-- �����̹��� ESCŰ ���
RegistEscEventInfo("DiceplayBackground", "Diceplay_Close")


-- Ÿ��Ʋ��
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Diceplay_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_Diceplay_WIDTH-35, 45)
--winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)


-- �ݱ��ư
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


-- �ֻ����� ����
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


-- ���۹�ư
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

-- ��
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Diceplay_Zen")
mywindow:setTextColor(50,171,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(406, 622)
--mywindow:setText("100,000,232")
mywindow:setSize(40, 18)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DiceplayBackground"):addChildWindow(mywindow)







-- ��ü �ֻ������Ӱ��â
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


-- �����̹��� ESCŰ ���
RegistEscEventInfo("DiceResultBackground", "DiceResult_Close")


-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "DiceResult_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(403, 45)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)

-- ���̺�(����)
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

-- ���̺�(���ñݾ�)
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

-- ���̺�(���)
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

-- �ֻ����� ���ð��
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


-- ���̺�(��÷�ݾ�)
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

-- ��÷�ݾ� ���
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

-- ��÷�ݾ�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "DiceResult_Sum")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 21)
mywindow:setPosition(344, 345)
mywindow:setSize(170, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("DiceResultBackground"):addChildWindow(mywindow)


-- Ȯ�ι�ư
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









-- �ֻ������� â�� ����.
function Diceplay_Show()
	Diceplay_SetVisible(true)
end

-- �ֻ������� â�� �ݴ´�.
function Diceplay_Close()
	Diceplay_SetVisible(false)
end

-- �ֻ�������â�� visible�� �����Ѵ�
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

-- �ʱ�ȭ
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


-- ���� �Լ�
function Diceplay_Render()

	-- â�� Ȱ��ȭ �Ǿ����� ���
	if winMgr:getWindow("DiceplayBackground"):isVisible() == true then
	
		local bAllEmpty = true

		-- ��������
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
			
			-- ��� ��ĭ���� �˻�
			if winMgr:getWindow("Diceplay_Bet_" .. i):getText() ~= "" and IsPlaying() == false then
				winMgr:getWindow("Diceplay_StartButton"):setEnabled(true)
				bAllEmpty = false
			end
		end
		
		if bAllEmpty then
			winMgr:getWindow("Diceplay_StartButton"):setEnabled(false)
		end
		
	-- ���â ���� �ִϸ��̼�
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

-- �����̹��� �����Լ�
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






-- �ֻ������Ӱ�� â�� ����.
function DiceResult_Show()
	DiceResult_SetVisible(true)
end

-- �ֻ������Ӱ�� â�� �ݴ´�.
function DiceResult_Close()
	DiceResult_SetVisible(false)
end

-- �ֻ������Ӱ��â�� visible�� �����Ѵ�
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

-- ���â �ʱ�ȭ
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

-- ���̶���Ʈ
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









-- Editbox Ȱ��ȭ �̺�Ʈ
function OnActivated_Bet(args)

	if g_Playing then
		CEGUI.toWindowEventArgs(args).window:deactivate()
	end
end

-- Editbox �̵� �̺�Ʈ
function OnClicked_BetBack(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	window:deactivate()
	winMgr:getWindow("Diceplay_Bet_" .. index):activate()
end

-- Editbox ���� �̺�Ʈ
function OnTextChanged_Edit(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 17, window:getText())
	
	window:setPosition(33 - textSize, 0)
end

function OnEditBoxFull(args) -- EditBox�� ��á������ �̺�Ʈ
	PlaySound('sound/FullEdit.wav')
end

function OnPressTab_Edit(args) -- EditBox�鿡�� Tab�� ������ ���� �̺�Ʈ

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index == 6 then
		winMgr:getWindow("Diceplay_Bet_1"):activate()
	else
		winMgr:getWindow("Diceplay_Bet_" .. index + 1):activate()
	end
	
end

-- ���۹�ư
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

-- Ȯ�ι�ư
function OnClicked_OK(args)
	DiceResult_SetVisible(false)
end

