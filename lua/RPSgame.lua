--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


-- ���������� ���
local RPS_NONE = 0
local RPS_ROCK = 1
local RPS_PAPER = 2
local RPS_SCISSORS = 3

local g_WinStreak = 0 -- ���� Ƚ��

local g_UserHand = 0	-- ������ ������ �ո��
local g_NPCHand = 0		-- NPC �ո��

local g_OrigNPCHand = 0	-- �������� ���� NPC �ո��


local MAX_ANI_SCENE = 15			-- �ִϸ��̼� ��� ����
local SPEED_ANI = 8				-- ó���ִϸ��̼� �ӵ�
local START_POS_ANI = 100		-- ó�� ���� ��ġ
local g_AniSpeed = SPEED_ANI	-- �ִϸ��̼� �ӵ�
local g_AniPos = START_POS_ANI	-- ���� ��ġ

local g_CurScene = 1		-- ���� �ִϸ��̼� ������
local g_bEnableAni = false	-- �ִϸ��̼� Ȱ��ȭ ����


-- ���� ��� ���
local RESULT_DRAW = 1
local RESULT_LOSE = 2
local RESULT_WIN = 3

local g_GameResult = 0

local g_bEnableTimer1 = false -- ���� ��� ȭ���� ���� Ÿ�̸�	
local g_bEnableTimer2 = false -- ���� ��� ȭ���� ���� Ÿ�̸�	
local g_bEnableTimer3 = false -- ����Ʈ�� ���� Ÿ�̸�
local g_Timer1 = 0			 -- Ÿ�̸� �ð�
local g_Timer2 = 0			 -- Ÿ�̸� �ð�
local g_Timer3 = 0			 -- Ÿ�̸� �ð�


local TIME_RESULT1 = 2000 -- ��� ȭ�� �ð�
local TIME_RESULT2 = 3000 -- ��� ȭ�� �ð�

local TIME_WHITE = 1200 -- ȭ��Ʈ�ƿ� �ð�


local RPS_PRICE = 3000 -- ���� ����


--[[

public: -- windows

	RPSgameAlphaImage	-- ����â �����̹���
	RPSgameBackground	-- ��ü ����â
	{
	--	RPSgame_Titlebar		-- Ÿ��Ʋ��(������, ����������)
		RPSgame_CloseBtn		-- �ݱ��ư
		RPSgame_WinStreak1		-- ���� Ƚ�� ù°�ڸ�
		RPSgame_WinStreak2		-- ���� Ƚ�� ��°�ڸ�
		RPSgame_Hand_User		-- ���� ��
		RPSgame_Hand_NPC_Back	-- NPC ��
		RPSgame_Hand_NPC		-- NPC ��
		RPSgame_HandName_User	-- ���� ���̸�
		RPSgame_HandName_NPC	-- NPC �� �̸�
		RPSgame_UserName		-- �����̸�
		RPSgame_NPCName			-- NPC�̸�
		RPSgame_SelectButton_1~3-- ���������� ���� ��ư
		RPSgame_StartButton		-- ���� ��ư
		
	} -- end of RPSgameBackground
	
	RPSgameWhite				-- ��� ȭ�� �� ��� �÷��� ȭ��
	RPSgameResult_1~3			-- ���� ��� ȭ��

	RPSwinBackground	-- �¸�â
		RPSwin_TitleTextImage	-- Ÿ��Ʋ �ؽ�Ʈ �̹���
		RPSwin_WinStreak1		-- ���� Ƚ�� ù°�ڸ�
		RPSwin_WinStreak2		-- ���� Ƚ�� ��°�ڸ�
		RPSwin_Reward_Back
		RPSwin_Reward_Current	-- ���� ��ǰ
		RPSwin_RewardQuan_Current-- ���� ��ǰ ����
		RPSwin_Reward_Next		-- ���� ��ǰ
		RPSwin_RewardQuan_Next	-- ���� ��ǰ ����
		RPSwin_Button_List		-- ���� ������ ��� ���� ��ư
		RPSwin_Reward_Desc		-- ����
		RPswin_Button_Continue	-- ���� ����ϱ� ��ư
		RPSwin_Button_Stop		-- ���� �׸��ϱ� ��ư
	
	RPSlistBackground	-- ���½� ȹ�� ������ ���â
		RPSlist_TitleTextImage	-- Ÿ��Ʋ �ؽ�Ʈ �̹���
		RPSlist_Number			-- ����Ƚ�� �׸�
		RPSlist_ItemName_1~20	-- ������ �̸�
		RPSlist_ItemBack_1~20	-- ���콺���� �̺�Ʈ�� ���� ���� �̹���
		

public: -- functions

	function RPSgame_Show()					-- ����â�� ����
	function RPSgame_Close()				-- ����â�� �ݴ´�
	function RPSgame_SetVisible( b )		-- ����â�� visible�� �����Ѵ�
	function RPSgame_Init()					-- �ʱ�ȭ
	function RPSgame_Render()				-- �����Լ�
	function RPSgame_GetNPCHand( base, result ) -- ����� ���� NPC �ո���� ���´�
	function RPSgame_SetHand( bUser, hand ) -- ���������� ����� �ٲ۴�
	function RPSgame_SetWinStreak( num )	-- ���� Ƚ��
	function RPSgame_AddWinStreak( num )	-- ���� Ƚ�� + 1ȸ
	function RPSgame_SetButtonEnabled( b )	-- ��ư enable�� �����Ѵ�
	function RPSgame_Start( npcHand )	-- ������ �����Ѵ�
	function RPSgame_StartAni()				-- �ִϸ��̼��� �����Ѵ�
	function RPSgame_SetGameResult( result )-- ���� ��� ȭ���� �����Ѵ�
	function RPSgame_SetAni( pos )			-- �ִϸ��̼� �Լ�
	function RPSgame_InitAniPos()			-- ���� �ִϸ��̼��� �ʱ�ȭ�Ѵ�
	
	function ShowFlash()					-- �÷��� ȿ��
	
	function RPSwin_Show()					-- �¸�â�� ����
	function RPSwin_Close()					-- �¸�â�� �ݴ´�
	function RPSwin_SetVisible( b )			-- �¸�â�� visible�� �����Ѵ�
	function RPSwin_Init()					-- �¸�â ������ �ʱ�ȭ�Ѵ�

	function RPSlist_Show()					-- ���»�ǰ����Ʈâ�� ����
	function RPSlist_Close()				-- ���»�ǰ����Ʈâ�� �ݴ´�
	function RPSlist_SetVisible( b )		-- ���»�ǰ����Ʈâ�� visible�� �����Ѵ�
	function RPSlist_Init()					-- ���»�ǰ����Ʈâ ������ �ʱ�ȭ�Ѵ�

	function OnClicked_SelectButton( args ) -- ���������� ���� ��ư
	
	function OnYes_RPS_Start()				-- ���� Ȯ�� �˾�â Yes Ŭ��
	function OnNo_RPS_Start()				-- ���� Ȯ�� �˾�â No Ŭ��
	function OnClicked_StartButton( args )	-- ���� ��ư
	
	function OnClicked_ShowList( args )		-- ���� ������ ���� ��ư
	function OnClicked_Stop( args )			-- ���� �׸��ϱ� ��ư
	function OnClicked_Continue( args )		-- ���� ����ϱ� ��ư
	
	function OnMouseEnter_Reward( args )	-- ��ǰ ������ �̺�Ʈ
	function OnMouseEnter_RewardList( args )-- ��ǰ ������ �̺�Ʈ
	function OnMouseLeave_Reward( args )	-- ��ǰ ������ �̺�Ʈ
	
	function OnClicked_List_OK( args )		-- ��ǰ����Ʈ Ȯ�ι�ư
	
]]--








-- ���� �̹���
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


-- �⺻ ���� ������
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

-- �����̹��� ESCŰ ���
RegistEscEventInfo("RPSgameBackground", "RPSgame_Close")


-- Ÿ��Ʋ��
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "RPSgame_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_RPSgame_WIDTH-35, 45)
--winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)


-- �ݱ��ư
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

-- ���� Ƚ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_WinStreak1") -- ù°�ڸ�
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setPosition(393, 139)
mywindow:setSize(80, 101)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSgame_WinStreak2") -- ��°�ڸ�
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 944, 0)
mywindow:setPosition(359, 139)
mywindow:setSize(80, 101)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSgameBackground"):addChildWindow(mywindow)

-- ���� �� �̹���
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

-- NPC �� �̹���
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

-- NPC �� �̹���
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


-- ���� �� �̸�
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

-- NPC �� �̸�
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

-- �����̸�
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

-- NPC�̸�
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

-- ���������� ���� ��ư
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


-- ���� ��ư
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



-- ���� ��� ȭ��
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





-- �÷��� ����Ʈ
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





-- �¸�â
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
      
-- �����̹��� ESCŰ ���
--RegistEscEventInfo("RPSwinBackground", "RPSwin_Close")

-- Ÿ��Ʋ �ؽ�Ʈ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_TitleTextImage")
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 659)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 659)
mywindow:setPosition(110, 5)
mywindow:setSize(209, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- ���� Ƚ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_WinStreak1") -- ù°�ڸ�
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 708)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 708)
mywindow:setPosition(114, 7)
mywindow:setSize(11, 20)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSwin_WinStreak2") -- ��°�ڸ�
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 726, 708)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 726, 708)
mywindow:setPosition(103, 10)
mywindow:setSize(11, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSwinBackground"):addChildWindow(mywindow)

-- ��ǰ ���
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

-- ���� ��ǰ
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

-- ���� ��ǰ ����
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

-- ���� ��ǰ
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

-- ���� ��ǰ ����
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

-- ���� ������ ���� ��ư
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


-- ����
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


-- ���� ����ϱ� ��ư
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


-- ���� �׸��ϱ� ��ư
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






-- ���½� ȹ�� ������ ���â
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

-- �����̹��� ESCŰ ���
RegistEscEventInfo("RPSlistBackground", "RPSlist_Close")

-- Ÿ��Ʋ �ؽ�Ʈ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RPSlist_TitleTextImage")
mywindow:setTexture("Enabled", "UIData/WeekendEvent001.tga", 722, 686)
mywindow:setTexture("Disabled", "UIData/WeekendEvent001.tga", 722, 686)
mywindow:setPosition(197, 5)
mywindow:setSize(209, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RPSlistBackground"):addChildWindow(mywindow)

-- ����Ƚ�� �׸�
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
		-- ���� Ƚ��
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

		-- ���� ��ǰ
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

-- Ȯ�� ��ư
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












-- ���� â�� ����.
function RPSgame_Show()
	RPSgame_SetVisible(true)
end

-- ���� â�� �ݴ´�.
function RPSgame_Close()
	if g_WinStreak == 0 then
		RPSgame_SetVisible(false)
	end
end

-- ����â�� visible�� �����Ѵ�
function RPSgame_SetVisible( b )

	-- �ִϸ��̼� ���� ���� ������ �ʴ´�
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

-- �ʱ�ȭ
function RPSgame_Init()
	
	RPSgame_SetWinStreak( 0 )
	
	winMgr:getWindow("RPSgame_UserName"):setTextExtends(GetMyName(), g_STRING_FONT_GULIMCHE, 22, 255,255,255,255,   2, 0,0,0,255)
	
	for i = 1, 3 do
		winMgr:getWindow("RPSgame_SelectButton_" .. i):setProperty("Selected", "False")
		winMgr:getWindow("RPSgame_SelectButton_" .. i):setEnabled(true)
	end
	winMgr:getWindow("RPSgame_SelectButton_1"):setProperty("Selected", "True") -- �ָ�
	
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


-- ���� �Լ�
function RPSgame_Render( currentTime )

	-- â�� Ȱ��ȭ �Ǿ����� ������� ����
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
				-- ���
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
				
				-- �׸� ����
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

function RPSgame_GetNPCHand( base, result ) -- ����� ���� NPC �ո���� ���´�
	
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

function RPSgame_SetHand( bUser, hand ) -- ���������� ����� �ٲ۴�
	
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

function RPSgame_SetWinStreak( num )	-- ���� Ƚ��

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

function RPSgame_AddWinStreak( num )	-- ���� Ƚ�� + 1ȸ
	RPSgame_SetWinStreak(g_WinStreak + 1)
end

function RPSgame_SetButtonEnabled( b )	-- ��ư enable�� �����Ѵ�
	
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

-- ������ �����Ѵ�
function RPSgame_Start( npcHand )
	g_OrigNPCHand = npcHand
	RPSgame_StartAni()
end

-- �ִϸ��̼��� �����Ѵ�
function RPSgame_StartAni()			

	g_bEnableAni = true
	g_AniSpeed = SPEED_ANI
	RPSgame_SetButtonEnabled( false )
	
	winMgr:getWindow("RPSgame_Hand_NPC_Back"):setVisible(false)
end	

-- ���� ��� ȭ���� �����Ѵ�
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

-- �ִϸ��̼� �Լ�
function RPSgame_SetAni( pos )

	g_AniPos = pos
	
	local window = winMgr:getWindow("RPSgame_Hand_NPC")
	
	window:setTexture("Enabled", "UIData/WeekendEvent002.tga", (g_NPCHand*252) + g_AniPos, 0)
	window:setTexture("Disabled", "UIData/WeekendEvent002.tga", (g_NPCHand*252) + g_AniPos, 0)
--	window:setPosition(252 + g_AniPos, 0)
	window:setSize(252 - g_AniPos, 216)
	
end
		
-- ���� �ִϸ��̼��� �ʱ�ȭ�Ѵ�
function RPSgame_InitAniPos()

	local height = {[0] = 0, 298, 380, 216, 462}
	
	RPSgame_SetAni(START_POS_ANI)
	
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Enabled", "UIData/WeekendEvent002.tga", 233, height[g_NPCHand])
	winMgr:getWindow("RPSgame_HandName_NPC"):setTexture("Disabled", "UIData/WeekendEvent002.tga", 233, height[g_NPCHand])
	
end

-- �÷��� ȿ��
function ShowFlash()
	winMgr:getWindow("RPSgameWhite"):moveToFront()
	winMgr:getWindow("RPSgameWhite"):activeMotion("RPSgameWhite_Effect_Show")
end

function HideFlash()
	winMgr:getWindow("RPSgameWhite"):moveToFront()
	winMgr:getWindow("RPSgameWhite"):activeMotion("RPSgameWhite_Effect_Hide")
end







-- �¸�â�� ����.
function RPSwin_Show()
	RPSwin_SetVisible(true)
end

-- �¸�â�� �ݴ´�.
function RPSwin_Close()
	RPSwin_SetVisible(false)
end

-- �¸�â�� visible�� �����Ѵ�
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



-- �¸�â ������ �ʱ�ȭ�Ѵ�
function RPSwin_Init()

	SetRewardImage(g_WinStreak)

	-- ���� ��ǰ ����
	local text = "x " .. GetRewardQuantity( g_WinStreak )
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 15, text)
	local window = winMgr:getWindow("RPSwin_RewardQuan_Current")
	
	window:setText( text )
	window:setPosition(132 - textSize, 63)
	
	
	if g_WinStreak < 20 then
		-- ���� ��ǰ ����
		text = "x " .. GetRewardQuantity( g_WinStreak+1 )
		textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 15, text)
		window = winMgr:getWindow("RPSwin_RewardQuan_Next")
		
		window:setText( text )
		window:setPosition(337 - textSize, 63)
	else
		-- 20�����϶� ���� ��ǰ�� �����
		winMgr:getWindow("RPSwin_RewardQuan_Next"):setText("")
		winMgr:getWindow("RPSwin_Reward_Next"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("RPSwin_Reward_Next"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
end




-- ���»�ǰ����Ʈ â�� ����.
function RPSlist_Show()
	RPSlist_SetVisible(true)
end

-- ���»�ǰ����Ʈ â�� �ݴ´�.
function RPSlist_Close()
	RPSlist_SetVisible(false)
end

-- ���»�ǰ����Ʈâ�� visible�� �����Ѵ�
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

-- �ʱ�ȭ
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












-- ���������� ���� ��ư
function OnClicked_SelectButton( args ) 

	g_UserHand = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("index"))
	
	RPSgame_SetHand( true, g_UserHand )
	
	winMgr:getWindow("RPSgame_StartButton"):setEnabled(true)
end


-- ���� Ȯ�� �˾�â Yes Ŭ��
function OnYes_RPS_Start()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_RPS_Start" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	if g_WinStreak == 0 then
		-- ����
		RequestStart(g_UserHand)
	--	RPSgame_Start( 3 )
	else
		-- �¸�â �ݱ�
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


-- ���� Ȯ�� �˾�â No Ŭ��
function OnNo_RPS_Start()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_RPS_Start" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

-- ���� ��ư
function OnClicked_StartButton( args ) 

--	if GetMyMoney() < RPS_PRICE then
--		local message = GetSStringInfo(LAN_GABABO_CONSUME_002)
--		ShowCommonAlertOkBoxWithFunction(message, "OnClickAlertOkSelfHide")
--	else
		-- ó���̸� �����, �ƴϸ� �ٷ� ����
		if g_WinStreak == 0 and g_GameResult ~= RESULT_DRAW then
			local message = string.format(PreCreateString_4511, RPS_PRICE)	--GetSStringInfo(LAN_GABABO_CONSUME_001)
			ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_RPS_Start", "OnNo_RPS_Start")
		else
			RequestStart(g_UserHand)
		--	RPSgame_Start( 3 )
		end
--	end
end

-- ���� ������ ���� ��ư
function OnClicked_ShowList( args ) 
	RPSlist_Init()
	RPSlist_SetVisible(true)
end

-- ���� �׸��ϱ� ��ư
function OnClicked_Stop( args )

	RequestGetReward()
	RPSgame_SetVisible(false)
end

-- ���� ����ϱ� ��ư
function OnClicked_Continue( args ) 

	if GetMyMoney() < RPS_PRICE then
		local message = PreCreateString_4512	--GetSStringInfo(LAN_GABABO_CONSUME_002)
		ShowCommonAlertOkBoxWithFunction(message, "OnClickAlertOkSelfHide")
	else
		local message = string.format(PreCreateString_4511, RPS_PRICE)	--GetSStringInfo(LAN_GABABO_CONSUME_001)
		ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_RPS_Start", "OnNo_RPS_Start")
	end
end


-- ��ǰ ������ �̺�Ʈ
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
	
	GetToolTipBaseInfo(x + 100, y, 4, Kind, -5, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

-- ��ǰ ������ �̺�Ʈ
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
	
	GetToolTipBaseInfo(x + 150, y+10, 4, Kind, -5, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

-- ��ǰ ������ �̺�Ʈ
function OnMouseLeave_Reward( args ) 
	SetShowToolTip(false)
end

-- ��ǰ ȹ�� Ȯ�� ��ư
function OnClicked_GetOK( args ) 
	RPSget_SetVisible(false) -- ��ü ����
end

-- ��ǰ����Ʈ Ȯ�ι�ư
function OnClicked_List_OK( args )
	RPSlist_SetVisible(false)
end




