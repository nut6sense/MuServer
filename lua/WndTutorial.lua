-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

local STRING_SPEAKERMAN		= PreCreateString_1369	--GetSStringInfo(LAN_LUA_WND_VILLAGE_1)		-- ����Ŀ��

-- SpeakerManAI
local SPEAKER_STAND			= 0
local SPEAKER_ATTACK		= 1
local SPEAKER_GRAB			= 2
local SPEAKER_EVADE			= 3
local SPEAKER_BLOWLETH		= 4
local SPEAKER_DOUBLESTAND	= 5

-- �ִ� AI
local JUNI_TEAMGRAB			= 6
local JUNI_TEAMATTACK		= 7
local JUNI_BLOWLETH			= 8

-- Tutorial Stage
local START_STAGE   	= 0
local MOVE_STAGE		= 1
local AUTO_STAGE		= 2
local ATTACK_STAGE		= 3
local GRAB_STAGE		= 4
local EVADE_STAGE		= 5
local EVADEATTACK_STAGE = 6
local COUNT_STAGE		= 7
local COMBO_STAGE		= 8
local BLOW_STAGE		= 9
local TEAMATTACK_STAGE	= 10
local TEAMGRAB_STAGE	= 11
local DOUBLE_STAGE		= 12
local ITEM_STAGE		= 13
local NOITEM_STAGE		= 14

-- ���� Stage
local STAGENUM			= 0

-- ����Ŀ�� ��Ʈ Font ����		   ��Ʈ ũ��, �ܰ���, �ܰ����� R,G,B
local TALK_TEXT_FONT	= { ['err'] = 0, [0] = 14, 1, 0, 0, 0 }
local KEY_MENT_FONT		= { ['err'] = 0, [0] = 13, 1, 0, 0, 0 }

-- ����Ŀ�� ��Ʈ ���̺�
local FIRST_SPEAKER_MANT_TABLE	= {['err']=0, }
local NEXT_SPEAKER_MANT_TABLE	= {['err']=0, }

-- Ʃ�丮�� ���� ����
local SPACE_LIST_NUM		= 0		-- �����̽� ����
local SMALL_VIDEO_FILENAME	= 0		-- 240*180 ���� ���� �̸�
local TUTORIAL_BIGNUM		= 0		-- Ʃ�丮�� �������� ū �з� ��ȣ

-------------------------------------------------
-- Ʃ�丮�� ����
-------------------------------------------------
-- ĳ����,����Ŀ��, ����鸦 ���� ���ش�.
-- Ʃ�丮�� �߰�, ������ �ش� �Լ� ������ ���־�� �Ѵ�.
-- ĳ����	   PosX, PosY, PosZ, Angle, ����Ŀ�� ��� �ִ� ����
-- SetUserInfo(  0,   0,    0,    270,             0)
	
-- ����Ŀ��			 PosX, PosY, PosZ,	Angle, Type,        AI
-- SetSpeakerManInfo(1500, 2000, 0,		-220,   1,	  SPEAKER_ATTACK)


-- text ��� 47 UI ��� 40 Ű ���� ��� 327 2
function TempUISetting()
	winMgr:getWindow("Tutorial_SkillCheck"):setVisible(false)
	
	-- ���� ���� ���
	winMgr:getWindow("Tutorial_SmallVideoImgBG"):setVisible(false)
	
	-- Ű �Է� �˸�â
	winMgr:getWindow("Tutorial_KeyInPutTitle"):setVisible(false)
	
	-- ������ ��ư
	winMgr:getWindow("Tutorial_EscImage"):setVisible(false)
end

function TutorialExit()
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1301, 'FirstTutorialSkipOk', 'FirstTutorialSkipCancel')
end

function SetTutorial(Stage)

	-- Ʃ�丮�� �Ѿ� ���� ���� ���� ���� �ʱ�ȭ
	SPACE_LIST_NUM		 = 0
	SMALL_VIDEO_FILENAME = 0
	
	-- ����Ŀ�� ��Ʈ�� �ʱ�ȭ ���ش�
	for i = 0, #FIRST_SPEAKER_MANT_TABLE do
		FIRST_SPEAKER_MANT_TABLE[i] = nil
	end
	
	-- ����Ŀ�� ��Ʈ�� �ʱ�ȭ ���ش�
	for i = 0, #NEXT_SPEAKER_MANT_TABLE do
		NEXT_SPEAKER_MANT_TABLE[i] = nil
	end
	
	DestoryVideo()	-- ������ �ʱ�ȭ ���ش�.
	
	KeyInPutImageInit()	-- Ű ���� �̹��� �ʱ�ȭ�� ���ش�.
	
	-- �Ϸ� �޽��� �ʱ�ȭ
	winMgr:getWindow('Tutorial_CompleteImage'):setPosition(1920, 0)
	winMgr:getWindow('Tutorial_CompleteImage'):setVisible(true)
	
	-- ���� �������� �̸� �ʱ�ȭ
	for i = 0, 7 do
		StageName("Tutorial_BigVideoImgName"..i, 172, 59, tFalseTexturePosX[i], tFalseTexturePosY[i], 22, 27 + (i * 60))
	end
	
	StageName("Tutorial_BigVideoImgName"..TUTORIAL_BIGNUM, 172, 59, tTrueTexturePosX[TUTORIAL_BIGNUM], 
			tTrueTexturePosY[TUTORIAL_BIGNUM], 22, 27 + (TUTORIAL_BIGNUM * 60))
	
	-- ���� ���������� �����Ѵ�
	STAGENUM = Stage
	
	
	-- �������� �� Setting
	if STAGENUM == START_STAGE then
		
	
	-- �̵� Ʃ�丮�� ����	
	elseif STAGENUM == MOVE_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 0, 0)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, true, true, true, true, true, true, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 0, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 47, 32, 832, 704, 305, 37)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(375, 47)
		SettingSpeakerMentColor(PreCreateString_4173, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4137

		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 1
		
	-- ���� Ÿ���� ����
	elseif STAGENUM == AUTO_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 2)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1600, 2100, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-1000, -1000, 0, 462, 1, SPEAKER_STAND)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(false, true, false, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 26, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 928, 928, 427, 40)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4138
		
		-- �������� �����Ŀ� ����ؾ� �� ��Ʈ
		NEXT_SPEAKER_MANT_TABLE[0] = PreCreateString_4139
	
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
	
	-- ���� ���� ����
	elseif STAGENUM == ATTACK_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 3)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(800, -2500, 0, 300, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, true, false, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 52, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 928, 832, 482, 40)
		TitleName("Tutorial_KeyInPutImg1", 33, 33, 928, 832, 516, 40)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 928, 832, 550, 40)
		TitleName("Tutorial_KeyInPutImg3", 33, 33, 928, 832, 584, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(280, 38)
		SettingSpeakerMentColor(PreCreateString_4174, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setPosition(292, 55)
		SettingSpeakerMentColor(PreCreateString_4175, "Tutorial_KeyInPutTitleText1", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4140
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4141
		FIRST_SPEAKER_MANT_TABLE[2] = PreCreateString_4142
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�

		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 2
		
	elseif STAGENUM == GRAB_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128, 1, SPEAKER_EVADE)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, true, true, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 79, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 832, 976, 440, 40)
		TitleName("Tutorial_KeyInPutImg1", 20, 21, 749, 1003, 490, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 880, 928, 530, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(345, 47)
		SettingSpeakerMentColor(PreCreateString_4177, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4143
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4144
		
		-- �������� �����Ŀ� ����ؾ� �� ��Ʈ
		NEXT_SPEAKER_MANT_TABLE[0] = PreCreateString_4145
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 3
		
	elseif STAGENUM == EVADE_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128, 1, SPEAKER_ATTACK)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, true, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 104, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 832, 928, 510, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(350, 47)
		SettingSpeakerMentColor(PreCreateString_4178, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4146
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
	elseif STAGENUM == EVADEATTACK_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128, 1, SPEAKER_ATTACK)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, true, false, true, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 130, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 832, 928, 320, 40)
		TitleName("Tutorial_KeyInPutImg1", 33, 33, 928, 928, 505, 40)
		TitleName("Tutorial_KeyInPutImg2", 29, 22, 716, 986, 455, 45)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(360, 47)
		SettingSpeakerMentColor(PreCreateString_4179, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setPosition(545, 47)
		SettingSpeakerMentColor(PreCreateString_4180, "Tutorial_KeyInPutTitleText1", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4147
		
		-- �������� �����Ŀ� ����ؾ� �� ��Ʈ
		NEXT_SPEAKER_MANT_TABLE[0] = PreCreateString_4148
		NEXT_SPEAKER_MANT_TABLE[1] = PreCreateString_4149
		NEXT_SPEAKER_MANT_TABLE[2] = PreCreateString_4150
		NEXT_SPEAKER_MANT_TABLE[3] = PreCreateString_4151
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 4

	elseif STAGENUM == COUNT_STAGE then
		-- ���� ����
		SetUserInfo(-8000, 500, 0, 492, 3)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(-7000, 0, 0, 150,   1, SPEAKER_ATTACK)
		SetSpeakerManInfo(-7200, 1200, 0, 120, 1, SPEAKER_ATTACK)
		SetSpeakerManInfo(-7500, -1000, 0, 280, 1, SPEAKER_ATTACK)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, false, true, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 156, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 880, 427, 40)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4152
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4153
		FIRST_SPEAKER_MANT_TABLE[2] = PreCreateString_4154
		
		-- �������� �����Ŀ� ����ؾ� �� ��Ʈ
		NEXT_SPEAKER_MANT_TABLE[0] = PreCreateString_4155
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
	elseif STAGENUM == COMBO_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128, 1, SPEAKER_EVADE)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, false, false, true, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 182, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 928, 880, 427, 40)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4156
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
	elseif STAGENUM == BLOW_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 2)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128,  1, SPEAKER_EVADE)
		SetSpeakerManInfo(2500, 1500, 0, 128,  1, SPEAKER_EVADE)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, false, false, false, true, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 333, 26, 446, 208, 287, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 976, 880, 427, 40)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4157
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4158
		
		-- �������� �����Ŀ� ����ؾ� �� ��Ʈ
		NEXT_SPEAKER_MANT_TABLE[0] = PreCreateString_4159
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 5
		
	elseif STAGENUM == TEAMATTACK_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		SetSpeakerManInfo(2000, 2000, 0, 128, 0, JUNI_TEAMATTACK)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, true, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 234, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 928, 530, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(341, 47)
		SettingSpeakerMentColor(PreCreateString_4175, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4160
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 6
		
	elseif STAGENUM == TEAMGRAB_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		SetSpeakerManInfo(2000, 2000, 0, 128, 0, JUNI_TEAMGRAB)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 234, 327, 4)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(351, 47)
		SettingSpeakerMentColor(PreCreateString_4181, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4161
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
	elseif STAGENUM == DOUBLE_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 2)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(1500, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_DOUBLESTAND)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, true, false, false, false, false, false)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 446, 260, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 928, 540, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(335, 47)
		SettingSpeakerMentColor(PreCreateString_4182, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4162
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4163
		FIRST_SPEAKER_MANT_TABLE[2] = PreCreateString_4164
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
		
		-- Ʃ�丮�� ū �з� �ѹ�
		TUTORIAL_BIGNUM = 7
		
	elseif STAGENUM == ITEM_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(3000, 3500, 0, 128, 1, SPEAKER_STAND)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, false, false, false, false, false, false, true)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 245, 26, 691, 0, 327, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 976, 928, 492, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(382, 47)
		SettingSpeakerMentColor(PreCreateString_4183, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4165
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4166
		FIRST_SPEAKER_MANT_TABLE[2] = PreCreateString_4167
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
	
	elseif STAGENUM == NOITEM_STAGE then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 1)
		
		-- ����Ŀ�� ����
		SetSpeakerManInfo(3000, 3500, 0, 128, 1, SPEAKER_STAND)
		
		--		  ����Ű,  D,	  S,	 A,		Q,	   W,	  E,	F
		KeyControl(true, true, true, false, false, false, false, true)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutTitleName", 285, 26, 446, 286, 310, 4)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 976, 928, 380, 40)
		TitleName("Tutorial_KeyInPutImg1", 33, 33, 928, 928, 480, 40)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 880, 928, 575, 40)
		TitleName("Tutorial_KeyInPutImg3", 4, 38, 745, 986, 425, 37)
		TitleName("Tutorial_KeyInPutImg4", 4, 38, 745, 986, 522, 37)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(295, 47)
		SettingSpeakerMentColor("�ݱ�, ������", "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setPosition(440, 47)
		SettingSpeakerMentColor("Ÿ��", "Tutorial_KeyInPutTitleText1", KEY_MENT_FONT)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText2"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText2"):setPosition(535, 47)
		SettingSpeakerMentColor("���", "Tutorial_KeyInPutTitleText2", KEY_MENT_FONT)
		
		-- ���� �������� ó���� ����ؾ� �� ��Ʈ
		FIRST_SPEAKER_MANT_TABLE[0] = PreCreateString_4168
		FIRST_SPEAKER_MANT_TABLE[1] = PreCreateString_4169
		FIRST_SPEAKER_MANT_TABLE[2] = PreCreateString_4170
		
		SMALL_VIDEO_FILENAME = "TutorialVideo/MoveTutorial/Test1.avi"	-- ���� ���� ���� �̸� �ֱ�
	
	elseif STAGENUM == ITEM_STAGE + 1 then
		-- ���� ����
		SetUserInfo(0, 0, 0, 492, 0)
		
		winMgr:getWindow("Tutorial_SpeakerTalkImage"):setVisible(false)
		winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(false)
		winMgr:getWindow("Tutorial_SmallVideoImgBG"):setVisible(false)
		winMgr:getWindow("Tutorial_KeyInPutTitle"):setVisible(false)
	end
end

-------------------------------------------------
-- ����Ŀ�� ��Ʈ ���� �����Ѵ�.
-------------------------------------------------
function SettingSpeakerMentColor(SpeakerMent, WindowName, FontDataTable)
	
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0
	if TipText ~= "" then
		tbufStringTable = {['err']=0, }
		tbufSpecialTable = {['err']=0, }
		count = 0
		
		tbufStringTable, tbufSpecialTable = cuttingString(SpeakerMent, tbufStringTable, tbufSpecialTable, count)

		winMgr:getWindow(WindowName):clearTextExtends()
		for i=0, #tbufStringTable do
			local colorIndex = tonumber(tbufSpecialTable[i])
			if colorIndex == nil then
				colorIndex = 0
			end
			winMgr:getWindow(WindowName):addTextExtends(tbufStringTable[i], g_STRING_FONT_DODUM, FontDataTable[0], 
						tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   
						FontDataTable[1], FontDataTable[2], FontDataTable[3] , FontDataTable[4] ,255)
		end
	end
end

-------------------------------------------------
-- �ϰ� �ʻ�� ������ �ι�° ���� Setting
-------------------------------------------------
function BlowLethalCharacterSetting()
	-- �Ϸ� �޽��� �ʱ�ȭ
	winMgr:getWindow('Tutorial_CompleteImage'):setPosition(1920, 0)
	winMgr:getWindow('Tutorial_CompleteImage'):setVisible(true)
	
	SetSpeakerManInfo(-1500, 6000, 0, -50, 1, SPEAKER_BLOWLETH)
	SetSpeakerManInfo(-1800, 5800, 0, -50, 0, JUNI_BLOWLETH)
	
	AIStart()
end

-- ���� �������� ���¸� ����
-- ���� ���������� ���ΰ� ���ΰ�?
local FirstStage	= 0
local NextStage		= 1

-------------------------------------------------
-- ������ �� ����Ŀ�� ��Ʈ ����
-------------------------------------------------
function MentAndVideoControl(StageState)

	if StageState == FirstStage then
	
		local SuccessMent =  CEGUI.toGUISheet(winMgr:getWindow("Tutorial_SpeakerTalkText")):isCompleteViewText()

		if SuccessMent == true then
		
			if #FIRST_SPEAKER_MANT_TABLE < SPACE_LIST_NUM then
				winMgr:getWindow("Tutorial_SpeakerTalkImage"):setVisible(false)				-- ����Ŀ�� ��Ʈ ���
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(false)				-- ū ���� ���
				winMgr:getWindow("Tutorial_KeyInPutTitle"):setVisible(true)					-- Ű �Է� Ÿ��Ʋ ���
				winMgr:getWindow("Tutorial_EscImage"):setVisible(true)						-- ������ ��ư
				
				if SMALL_VIDEO_FILENAME ~= 0 then
					DestoryVideo()
					VideoSetUp(SMALL_VIDEO_FILENAME)
					winMgr:getWindow("Tutorial_SmallVideoImgBG"):setVisible(true)
				end
				
				-- ���� ���������� ��� ���� ���� UI�� �����ش�.
				if STAGENUM == ATTACK_STAGE then
					AttackSuccessCheckSetUp()
				end
				
				AllKeyControl(false)		-- ���� ���������� �°� Ű�� �����Ѵ�.
				SpeakerManRender()			-- ����Ŀ�� ĳ���� ����
				AIStart()
			else
				winMgr:getWindow("Tutorial_SmallVideoImgBG"):setVisible(false)		-- ���� ���� ���
				winMgr:getWindow("Tutorial_KeyInPutTitle"):setVisible(false)		-- Ű �Է� �˸�â
				winMgr:getWindow("Tutorial_EscImage"):setVisible(false)				-- ������ ��ư
				winMgr:getWindow("Tutorial_SpeakerTalkImage"):setVisible(true)		-- ����Ŀ�� ��Ʈ ���
				
				-- ���� ���������� �ƴ� ��� �������� �ʴ´�.
				if STAGENUM ~= ATTACK_STAGE then
					AttackSuccessCheckDest()
				end
				
				BigVideoControl(STAGENUM, StageState)
				NextSpeakerManMent(SPACE_LIST_NUM, StageState)
				SPACE_LIST_NUM = SPACE_LIST_NUM + 1
			end
			
		elseif SuccessMent == false then				
			CEGUI.toGUISheet(winMgr:getWindow("Tutorial_SpeakerTalkText")):setCompleteViewText(true)
		end
		
	elseif StageState == NextStage then
		local SuccessMent =  CEGUI.toGUISheet(winMgr:getWindow("Tutorial_SpeakerTalkText")):isCompleteViewText()

		if SuccessMent == true then
			if #NEXT_SPEAKER_MANT_TABLE < SPACE_LIST_NUM then
				StageSuccess(true)
			else
				BigVideoControl(STAGENUM, StageState)
				NextSpeakerManMent(SPACE_LIST_NUM, StageState)
				SPACE_LIST_NUM = SPACE_LIST_NUM + 1
			end
		elseif SuccessMent == false then				
			CEGUI.toGUISheet(winMgr:getWindow("Tutorial_SpeakerTalkText")):setCompleteViewText(true)
		end
	end
end

-------------------------------------------------
-- �������� �����Ŀ� ������ ��Ʈ
-------------------------------------------------
function MentListNumInit(StageState)
	SPACE_LIST_NUM = 0;
	
	BigVideoControl(STAGENUM, StageState)
	NextSpeakerManMent(SPACE_LIST_NUM, StageState)
	SPACE_LIST_NUM = SPACE_LIST_NUM + 1

	winMgr:getWindow("Tutorial_SmallVideoImgBG"):setVisible(false)			-- ���� ���� ���
	winMgr:getWindow("Tutorial_KeyInPutTitle"):setVisible(false)			-- Ű �Է� �˸�â
	winMgr:getWindow("Tutorial_EscImage"):setVisible(false)					-- ������ ��ư
	winMgr:getWindow("Tutorial_SpeakerTalkImage"):setVisible(true)			-- ����Ŀ�� ��Ʈ ���
	
	-- ���� ���������� �ƴ� ��� �������� �ʴ´�.
	if STAGENUM ~= ATTACK_STAGE or STAGENUM == EVADE_STAGE then
		AttackSuccessCheckDest()
	end
end


-------------------------------------------------
-- �������� �� ���� ������ ����
-------------------------------------------------
function BigVideoControl(StageNum, StageState)
	if StageNum == ATTACK_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 1 then
				VideoSetUp("TutorialVideo/AttackTutorial/Attack3_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			elseif SPACE_LIST_NUM == 2 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/AttackTutorial/Attack3_2_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
	
	elseif StageNum == GRAB_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 1 then
				VideoSetUp("TutorialVideo/GrabTutorial/Grab4_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		elseif StageState == NextStage then
			if SPACE_LIST_NUM == 0 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/GrabTutorial/Grab4_2_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == EVADE_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/EvadeTutorial/Evade5_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == EVADEATTACK_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/EvadeAttackTutorial/EvadeAttack6_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end		
		elseif StageState == NextStage then
			if SPACE_LIST_NUM == 2 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/EvadeAttackTutorial/EvadeAttack6_2_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == COUNT_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/CountTutorial/Count7_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			elseif SPACE_LIST_NUM == 1 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/CountTutorial/Count7_2_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end		
		elseif StageState == NextStage then
			if SPACE_LIST_NUM == 0 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/CountTutorial/Count7_3_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == COMBO_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/ComboTutorial/Combo8_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == BLOW_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/BlowLethalTutorial/Blow9_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end		
		elseif StageState == NextStage then
			if SPACE_LIST_NUM == 0 then
				DestoryVideo()
				VideoSetUp("TutorialVideo/BlowLethalTutorial/Blow9_2_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == TEAMATTACK_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/TeamAttackTutorial/TeamAttack10_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == TEAMGRAB_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 0 then
				VideoSetUp("TutorialVideo/TeamGarbTutorial/TeamGrab_11_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == DOUBLE_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 1 then
				VideoSetUp("TutorialVideo/DoubleAttackTutorial/Double_12_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == ITEM_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 1 then
				VideoSetUp("TutorialVideo/ItemTutorial/Item13_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
		
	elseif StageNum == NOITEM_STAGE then
		if StageState == FirstStage then
			if SPACE_LIST_NUM == 1 then
				VideoSetUp("TutorialVideo/NoItemTutorial/NoItem14_1_200k.avi")
				winMgr:getWindow("Tutorial_BigVideoImgBG"):setVisible(true)
			end
		end
	end
end

-------------------------------------------------
-- ���� ����Ŀ�� ��Ʈ�� ��� �Ѵ�.
-------------------------------------------------
function NextSpeakerManMent(TextNum, StageState)
	
	local SpeakerTalkTextWindow = winMgr:getWindow("Tutorial_SpeakerTalkText")
	
	if StageState == FirstStage then
		if FIRST_SPEAKER_MANT_TABLE[TextNum] ~= 0 then
			SpeakerTalkTextWindow:clearTextExtends()
			CEGUI.toGUISheet(SpeakerTalkTextWindow):setTextViewDelayTime(17)
			SettingSpeakerMentColor(FIRST_SPEAKER_MANT_TABLE[TextNum], "Tutorial_SpeakerTalkText", TALK_TEXT_FONT)
		end
		
	elseif StageState == NextStage then
		if NEXT_SPEAKER_MANT_TABLE[TextNum] ~= 0 then
			SpeakerTalkTextWindow:clearTextExtends()
			CEGUI.toGUISheet(SpeakerTalkTextWindow):setTextViewDelayTime(17)
			SettingSpeakerMentColor(NEXT_SPEAKER_MANT_TABLE[TextNum], "Tutorial_SpeakerTalkText", TALK_TEXT_FONT)
		end
	end
end

-------------------------------------------------
-- UI Image�� ���� ���� �ش�.
-------------------------------------------------
function UISetting(WindowName, UIDataFileName)
	winMgr:getWindow(WindowName):setTexture("Enabled", UIDataFileName, 0, 0)
	winMgr:getWindow(WindowName):setTexture("Disabled", UIDataFileName, 0, 0)
end

-------------------------------------------------
-- �������� ���� ���� �Ǵ� �̹��� ����
-------------------------------------------------
function TitleName(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
	winMgr:getWindow(WindowName):setTexture("Enabled", "UIData/NewTutorial_001.tga", TexX, TexY)
	winMgr:getWindow(WindowName):setTexture("Disabled", "UIData/NewTutorial_001.tga", TexX, TexY)
	winMgr:getWindow(WindowName):setSize(SizeX, SizeY)
	winMgr:getWindow(WindowName):setPosition(PosX, PosY)
end

function StageName(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
	winMgr:getWindow(WindowName):setTexture("Enabled", "UIData/NewTutorial_002.tga", TexX, TexY)
	winMgr:getWindow(WindowName):setTexture("Disabled", "UIData/NewTutorial_002.tga", TexX, TexY)
	winMgr:getWindow(WindowName):setSize(SizeX, SizeY)
	winMgr:getWindow(WindowName):setPosition(PosX, PosY)
end

-------------------------------------------------
-- Ű ���� �̹��� �ʱ�ȭ
-------------------------------------------------
function KeyInPutImageInit()
	for i = 0, 6 do
		winMgr:getWindow("Tutorial_KeyInPutImg"..i):setTexture("Enabled", "UIData/NewTutorial_001.tga", 0, 0)
		winMgr:getWindow("Tutorial_KeyInPutImg"..i):setTexture("Disabled", "UIData/NewTutorial_001.tga", 0, 0)
		winMgr:getWindow("Tutorial_KeyInPutImg"..i):setSize(0, 0)
	end
	
	for i = 0, 2 do
		winMgr:getWindow("Tutorial_KeyInPutTitleText"..i):setViewTextMode(2)
		winMgr:getWindow("Tutorial_KeyInPutTitleText"..i):setText(" ")
	end
end

-------------------------------------------------
-- �Ϸ� �� ������ �̺�Ʈ
-------------------------------------------------
function CompleteImageProcess(Start_Time, Now_Time)
	local ImageMoveTime = Now_Time - Start_Time
	
	if ImageMoveTime > 0 and ImageMoveTime < 1000 then
		local ImagePos = Elastic_EaseOut(ImageMoveTime, 1024, -722, 1000, 0, 0);
		winMgr:getWindow('Tutorial_CompleteImage'):setPosition(ImagePos, 200)
		
		-- �Ϸ� �����ִ� �̺�Ʈ�߿� Ű�� �ᱺ��
		if ImageMoveTime >= 400 then
			AllKeyControl(true)
		end
		
	elseif ImageMoveTime > 1400 and ImageMoveTime < 2100 then
		local ImagePos = Back_EaseIn(ImageMoveTime-1400, 302, -920, 700, 0)
		winMgr:getWindow('Tutorial_CompleteImage'):setPosition(ImagePos, 200)
	elseif ImageMoveTime > 2500 then
		winMgr:getWindow('Tutorial_CompleteImage'):setVisible(false)
	end
end

-------------------------------------------------
-- ���� ���� ������ ���� ���� ����
-------------------------------------------------
function AttackStageKeyInPutControl(StageNum)
	KeyInPutImageInit()	-- Ű ���� �̹��� �ʱ�ȭ�� ���ش�.
	AttackSuccessCheckSetUp()
	
	-- �Ϸ� �޽��� �ʱ�ȭ
	winMgr:getWindow('Tutorial_CompleteImage'):setPosition(1920, 0)
	winMgr:getWindow('Tutorial_CompleteImage'):setVisible(true)

	if StageNum == 1 then
		-- Ÿ�� Ʃ�丮�� �� �������� ���� ����Ŀ���� �ٽ� �� �����Ѵ�.
		-- ����Ŀ�� ����
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-1500, -1800, 0, 492, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 832, 736, 380, 40)
		TitleName("Tutorial_KeyInPutImg1", 33, 33, 928, 736, 450, 40)
		TitleName("Tutorial_KeyInPutImg2", 20, 21, 749, 1003, 495, 43)
		TitleName("Tutorial_KeyInPutImg3", 33, 33, 928, 832, 530, 40)
		TitleName("Tutorial_KeyInPutImg4", 33, 33, 928, 832, 565, 40)
		TitleName("Tutorial_KeyInPutImg5", 33, 33, 928, 832, 600, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(267, 47)
		SettingSpeakerMentColor(PreCreateString_4174, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText1"):setPosition(416, 47)
		SettingSpeakerMentColor(PreCreateString_4176, "Tutorial_KeyInPutTitleText1", KEY_MENT_FONT)
	
	elseif StageNum == 2 then
		-- Ÿ�� Ʃ�丮�� �� �������� ���� ����Ŀ���� �ٽ� �� �����Ѵ�.
		-- ����Ŀ�� ����
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-1700, -2000, 0, 492, 1, SPEAKER_STAND)
		SetSpeakerManInfo(1300, -2200, 0, 300, 1, SPEAKER_STAND)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 976, 736, 440, 40)
		TitleName("Tutorial_KeyInPutImg3", 20, 21, 749, 1003, 500, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 928, 832, 550, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(305, 47)
		SettingSpeakerMentColor(PreCreateString_4174, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
	elseif StageNum == 3 then
		-- Ÿ�� Ʃ�丮�� �� �������� ���� ����Ŀ���� �ٽ� �� �����Ѵ�.
		-- ����Ŀ�� ����
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-1500, -1800, 0, 492, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 736, 440, 40)
		TitleName("Tutorial_KeyInPutImg3", 20, 21, 749, 1003, 500, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 928, 832, 550, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(305, 47)
		SettingSpeakerMentColor(PreCreateString_4174, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
		
	elseif StageNum == 4 then
		-- Ÿ�� Ʃ�丮�� �� �������� ���� ����Ŀ���� �ٽ� �� �����Ѵ�.
		-- ����Ŀ�� ����
		SetSpeakerManInfo(2000, 2000, 0, 128, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-1500, -1800, 0, 492, 1, SPEAKER_STAND)
		SetSpeakerManInfo(-800, 3000, 0, -50, 1, SPEAKER_STAND)
		
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 736, 410, 40)
		TitleName("Tutorial_KeyInPutImg1", 20, 21, 749, 1003, 455, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 928, 832, 495, 40)
		TitleName("Tutorial_KeyInPutImg3", 33, 33, 928, 832, 535, 40)
		TitleName("Tutorial_KeyInPutImg4", 33, 33, 928, 832, 575, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(287, 47)
		SettingSpeakerMentColor(PreCreateString_4174, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
	end
end

-------------------------------------------------
-- ���� �� ���� ��� �´�
-------------------------------------------------
function AttackSuccessCheck(CheckNum)
	for i = 1, CheckNum do
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setTexture("Enabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 674)
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setTexture("Enabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 674)
	end
end

-------------------------------------------------
-- �������� UI SetUp
-------------------------------------------------
function AttackSuccessCheckSetUp()
	for i = 1, 3 do
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setTexture("Enabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 705)
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setTexture("Enabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 705)
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setVisible(true)
	end
end

-------------------------------------------------
-- �������� UI Dest
-------------------------------------------------
function AttackSuccessCheckDest()
	for i = 1, 3 do
		winMgr:getWindow("Tutorial_SuccessCheck"..i):setVisible(false)
	end
end

-------------------------------------------------
-- ��� ������ ���� ���� ����
-------------------------------------------------
function GrabStageKeyInPutControl(StageNum)
	KeyInPutImageInit()	-- Ű ���� �̹��� �ʱ�ȭ�� ���ش�.
	
	-- �Ϸ� �޽��� �ʱ�ȭ
	winMgr:getWindow('Tutorial_CompleteImage'):setPosition(1920, 0)
	winMgr:getWindow('Tutorial_CompleteImage'):setVisible(true)

	if StageNum == 1 then
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 928, 976, 440, 40)
		TitleName("Tutorial_KeyInPutImg1", 20, 21, 749, 1003, 490, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 880, 928, 530, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(345, 47)
		SettingSpeakerMentColor(PreCreateString_4177, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
	
	elseif StageNum == 2 then
		-- Ű �Է� �̹��� ����(WindowName, SizeX, SizeY, TexX, TexY, PosX, PosY)
		TitleName("Tutorial_KeyInPutImg0", 33, 33, 880, 976, 440, 40)
		TitleName("Tutorial_KeyInPutImg1", 20, 21, 749, 1003, 490, 43)
		TitleName("Tutorial_KeyInPutImg2", 33, 33, 880, 928, 530, 40)
		
		-- Ű �Է� �ؽ�ó
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setViewTextMode(1)
		winMgr:getWindow("Tutorial_KeyInPutTitleText0"):setPosition(345, 47)
		SettingSpeakerMentColor(PreCreateString_4177, "Tutorial_KeyInPutTitleText0", KEY_MENT_FONT)
	end
end

-------------------------------------------------
-- ����Ŀ�� ��ȭâ �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SpeakerTalkImage")
mywindow:setTexture("Enabled", "UIData/NewTutorial_002.tga", 0, 808)
mywindow:setTexture("Disabled", "UIData/NewTutorial_002.tga", 0, 808)
mywindow:setSize(1024, 216)
mywindow:setWideType(7)
mywindow:setPosition(0, 550)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- Ÿ�� �� ��� ���ݽ� ���� ��ų�� �ùٸ��� �Ǵ� UI
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SkillCheck")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 86, 940)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 86, 940)
mywindow:setSize(86, 84)
mywindow:setWideType(5)
mywindow:setPosition(480, 100)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

tDImgPosXTable		= { ['err'] = 0, [0] = 477, 511, 545, 579 }
tKeyDImgPosXTable	= { ['err'] = 0, [0] = 530, 560, 600 }
tUpDImgPosXTable	= { ['err'] = 0, [0] = 550 }
tDownDImgPosXTable	= { ['err'] = 0, [0] = 550 }

tLeftSImgPosXTable	= { ['err'] = 0, [0] = 477, 511, 545, 579 }
tRightSImgPosXTable	= { ['err'] = 0, [0] = 477, 511, 545, 579 }
tDownSImgPosXTable	= { ['err'] = 0, [0] = 477, 511, 545, 579 }

tSkillDCheckImgTable = { ['err'] = 0, [0] = tDImgPosXTable, tKeyDImgPosXTable, tUpDImgPosXTable,
					tDownDImgPosXTable }

tSkillSCheckImgTable = { ['err'] = 0, [0] = tLeftSImgPosXTable, tRightSImgPosXTable, tDownSImgPosXTable }



function SkillFalseInit(StageNum)
	SkillTrueInit(StageNum)
	winMgr:getWindow("Tutorial_SkillCheck"):setVisible(false)
end

function SkillFalse(StageNum)
	SkillTrueInit(StageNum)
	winMgr:getWindow("Tutorial_SkillCheck"):setVisible(true)
end


function SkillTrueAni(StageNum, TrueNum, Comple)
	if Comple == 0 then
		if TrueNum ~= 0 then
			TitleName("Tutorial_KeyInPutImg"..TrueNum - 1, 33, 33, 928, 928, tSkillDCheckImgTable[StageNum][TrueNum - 1], 40)
		end
		
		TitleName("Tutorial_KeyInPutImg"..TrueNum, 51, 45, 873, 529, tSkillDCheckImgTable[StageNum][TrueNum] - 18, 24)
		
	elseif Comple == 1 then
		TitleName("Tutorial_KeyInPutImg"..TrueNum, 33, 33, 928, 928, tSkillDCheckImgTable[StageNum][TrueNum], 40)
	end
end

function SkillCheckAnimation(FirstTime, NowTime, StageNum, TrueNum)
	local TimeLoop = NowTime - FirstTime
	
	if TimeLoop > 300 and TimeLoop < 500 then
		TitleName("Tutorial_KeyInPutImg"..TrueNum, 33, 33, 928, 928, tSkillDCheckImgTable[StageNum][TrueNum], 40)
	elseif TimeLoop >= 500 then
		SkillTrueInit(StageNum)
	end
end

function SkillTrueInit(StageNum)
	for i = 0, #tSkillDCheckImgTable[StageNum] do
		TitleName("Tutorial_KeyInPutImg"..i, 33, 33, 928, 832, tSkillDCheckImgTable[StageNum][i], 40)
	end
end
-------------------------------------------------
-- ����Ŀ�� ��ȭâ �����̽� �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SpeakerTalkSpace")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 927, 586)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 927, 586)
mywindow:setSize(97, 44)
mywindow:setPosition(900, 165)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
winMgr:getWindow("Tutorial_SpeakerTalkImage"):addChildWindow( winMgr:getWindow("Tutorial_SpeakerTalkSpace") )

-------------------------------------------------
-- ����Ŀ�� ��ȭâ ȭ��ǥ �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SpeakerTalkSpaceArr")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 832, 648)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 832, 648)
mywindow:setSize(47, 56)
mywindow:setScaleHeight(180)
mywindow:setScaleWidth(180)
mywindow:setPosition(930, 123)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
winMgr:getWindow("Tutorial_SpeakerTalkImage"):addChildWindow( winMgr:getWindow("Tutorial_SpeakerTalkSpaceArr") )

function SpaceAniControl(MainLoop)

	if MainLoop < 50 then
		winMgr:getWindow("Tutorial_SpeakerTalkSpace"):setTexture("Enabled", "UIData/NewTutorial_001.tga", 927, 630)
		winMgr:getWindow("Tutorial_SpeakerTalkSpaceArr"):setPosition(930, 128)
	else
		winMgr:getWindow("Tutorial_SpeakerTalkSpace"):setTexture("Enabled", "UIData/NewTutorial_001.tga", 927, 586)
		winMgr:getWindow("Tutorial_SpeakerTalkSpaceArr"):setPosition(930, 123)
	end
end

-------------------------------------------------
-- Complete!! �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_CompleteImage")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 0, 328)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 0, 328)
mywindow:setSize(462, 73)
mywindow:setPosition(1920, 0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- ����Ŀ�� ��ȭ
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Tutorial_SpeakerTalkText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(425, 0)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setAlign(0)
mywindow:setLineSpacing(15)
mywindow:setViewTextMode(2)
mywindow:setPosition(330, 80)
mywindow:setText('')
mywindow:setVisible(true)
winMgr:getWindow("Tutorial_SpeakerTalkImage"):addChildWindow( winMgr:getWindow("Tutorial_SpeakerTalkText") )


-------------------------------------------------
-- ����Ŀ�� ��ȭâ �̸� ���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Tutorial_SpeakerNameTalk")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(425, 0)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(210, 77)
mywindow:setText('')
mywindow:setVisible(true)
mywindow:addTextExtends(STRING_SPEAKERMAN.." :", g_STRING_FONT_DODUM, 17, 255, 255, 0, 255, 3, 0, 0, 0, 255)
winMgr:getWindow("Tutorial_SpeakerTalkImage"):addChildWindow( winMgr:getWindow("Tutorial_SpeakerNameTalk") )

-------------------------------------------------
-- ������ �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_EscImage")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 769, 970)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 769, 970)
mywindow:setSize(63, 55)
mywindow:setPosition(10, 10)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)


-------------------------------------------------
-- Ÿ��Ʋ �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SpeakerMoveTitle")
--mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
--mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 252, 230)
mywindow:setSize(326, 50)
mywindow:setWideType(5)
mywindow:setPosition(348, 5)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- Ű �Է� Ÿ��Ʋ
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_KeyInPutTitle")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 0, 401)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 0, 401)
mywindow:setSize(899, 77)
mywindow:setWideType(5)
mywindow:setPosition(62, 0)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- Ű �Է� ����
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_KeyInPutTitleName")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setSize(0, 0)
mywindow:setPosition(0, 0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
winMgr:getWindow("Tutorial_KeyInPutTitle"):addChildWindow( winMgr:getWindow("Tutorial_KeyInPutTitleName") )

KEY_INPUT_IMG_MAX = 6
-------------------------------------------------
-- Ű �Է� �̹���
-------------------------------------------------
for i = 0, KEY_INPUT_IMG_MAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_KeyInPutImg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setSize(0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	winMgr:getWindow("Tutorial_KeyInPutTitle"):addChildWindow( winMgr:getWindow("Tutorial_KeyInPutImg"..i) )
end

KEY_INPUT_TEXT_MAX = 3
-------------------------------------------------
-- Ű �Է� ����
-------------------------------------------------
for i = 0, KEY_INPUT_TEXT_MAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Tutorial_KeyInPutTitleText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setSize(425, 0)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(12)
	mywindow:setViewTextMode(1)
	mywindow:setPosition(150, 80)
	mywindow:setText('')
	mywindow:setVisible(true)
	winMgr:getWindow("Tutorial_KeyInPutTitle"):addChildWindow( winMgr:getWindow("Tutorial_KeyInPutTitleText"..i) )
end


tSuccessCheckTextX = {['err'] = 0, [0] = 0, 931, 962, 993 }

SUCCESS_CHECK_MAX = 3

-------------------------------------------------
-- ���� �� ���� ���� ���
-------------------------------------------------
for i = 1, SUCCESS_CHECK_MAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SuccessCheck"..i)
	mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 705)
	mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", tSuccessCheckTextX[i], 705)
	mywindow:setSize(31, 31)
	mywindow:setWideType(5)
	mywindow:setPosition(733 + (i*35), 0)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	root:addChildWindow(mywindow)
end

-------------------------------------------------
-- ���� 640*420 ����
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_BigVideoImgBG")
mywindow:setTexture("Enabled", "UIData/NewTutorial_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/NewTutorial_002.tga", 0, 0)
mywindow:setSize(866, 537)
mywindow:setWideType(6)
mywindow:setPosition(79, 10)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- ���� 640*420 �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_BigVideoImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(200, 28)
mywindow:setSize(640, 480)
mywindow:setVisible(true)
mywindow:setEnabled(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Tutorial_BigVideoImgBG"):addChildWindow( winMgr:getWindow("Tutorial_BigVideoImg") )


-------------------------------------------------
-- ���� �������� �̸�
-------------------------------------------------
tFalseTexturePosX = {['err'] = 0, [0] = 0, 172, 344, 516, 688, 0, 172, 344 }
tFalseTexturePosY = {['err'] = 0, [0] = 596, 596, 596, 596, 596, 714, 714, 714}

tTrueTexturePosX = {['err'] = 0, [0] = 0, 172, 344, 516, 688, 0, 172, 344 }
tTrueTexturePosY = {['err'] = 0, [0] = 537, 537, 537, 537, 537, 655, 655, 655}

BIG_VIDEO_IMG_MAX = 7

for i = 0, BIG_VIDEO_IMG_MAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_BigVideoImgName"..i)
	mywindow:setTexture("Enabled", "UIData/NewTutorial_002.tga", tFalseTexturePosX[i], tFalseTexturePosY[i])
	mywindow:setTexture("Disabled", "UIData/NewTutorial_002.tga", tFalseTexturePosX[i], tFalseTexturePosY[i])
	mywindow:setSize(172, 59)
	mywindow:setPosition(22, 27 + (i * 60))
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	winMgr:getWindow("Tutorial_BigVideoImgBG"):addChildWindow( winMgr:getWindow("Tutorial_BigVideoImgName"..i) )
end

-------------------------------------------------
-- ���� 240*180 ����
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SmallVideoImgBG")
mywindow:setTexture("Enabled", "UIData/NewTutorial_001.tga", 0, 697)
mywindow:setTexture("Disabled", "UIData/NewTutorial_001.tga", 0, 697)
mywindow:setSize(250, 190)
mywindow:setWideType(1)
mywindow:setPosition(768, 40)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
root:addChildWindow(mywindow)

-------------------------------------------------
-- ���� 240*180�̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tutorial_SmallVideoImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(5, 5)
mywindow:setSize(240, 180)
mywindow:setVisible(true)
mywindow:setEnabled(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Tutorial_SmallVideoImgBG"):addChildWindow( winMgr:getWindow("Tutorial_SmallVideoImg") )
