guiSystem = CEGUI.System:getSingleton();
winMgr = CEGUI.WindowManager:getSingleton();
root = winMgr:getWindow("DefaultWindow");
root_drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()



-----------------------------------------------------------------------

--	���ڿ� �ε�

-----------------------------------------------------------------------
local STRING_TUTORIAL_1		= PreCreateString_1274		--GetSStringInfo(LAN_LUA_WND_PRACTICE_1)	-- �����մϴ�
local STRING_TUTORIAL_2		= PreCreateString_1275		--GetSStringInfo(LAN_LUA_WND_PRACTICE_2)	-- �뽬�ϱ�
local STRING_TUTORIAL_3		= PreCreateString_1276		--GetSStringInfo(LAN_LUA_WND_PRACTICE_3)	-- 2.����Ű�� ��ǥ �������� �뽬�ϱ�
local STRING_TUTORIAL_4		= PreCreateString_1277		--GetSStringInfo(LAN_LUA_WND_PRACTICE_4)	-- Ʃ�丮��
local STRING_TUTORIAL_5		= PreCreateString_1278		--GetSStringInfo(LAN_LUA_WND_PRACTICE_5)	-- é��
local STRING_TUTORIAL_6		= PreCreateString_1279		--GetSStringInfo(LAN_LUA_WND_PRACTICE_6)	-- �⺻ ����
local STRING_TUTORIAL_7		= PreCreateString_1280		--GetSStringInfo(LAN_LUA_WND_PRACTICE_7)	-- �⺻ Ÿ��
local STRING_TUTORIAL_8		= PreCreateString_1281		--GetSStringInfo(LAN_LUA_WND_PRACTICE_8)	-- �⺻ ���
local STRING_TUTORIAL_9		= PreCreateString_1282		--GetSStringInfo(LAN_LUA_WND_PRACTICE_9)	-- ȸ��
local STRING_TUTORIAL_10	= PreCreateString_1283		--GetSStringInfo(LAN_LUA_WND_PRACTICE_10)	-- �ʻ� ����
local STRING_TUTORIAL_11	= PreCreateString_1284		--GetSStringInfo(LAN_LUA_WND_PRACTICE_11)	-- ���� ����
local STRING_TUTORIAL_12	= PreCreateString_1285		--GetSStringInfo(LAN_LUA_WND_PRACTICE_12)	-- �� ����
local STRING_TUTORIAL_13	= PreCreateString_1286		--GetSStringInfo(LAN_LUA_WND_PRACTICE_13)	-- �̵��ϱ�
local STRING_TUTORIAL_14	= PreCreateString_1287		--GetSStringInfo(LAN_LUA_WND_PRACTICE_14)	-- Ÿ�ݰ���
local STRING_TUTORIAL_15	= PreCreateString_1288		--GetSStringInfo(LAN_LUA_WND_PRACTICE_15)	-- ������
local STRING_TUTORIAL_16	= PreCreateString_1289		--GetSStringInfo(LAN_LUA_WND_PRACTICE_16)	-- ȸ���ϱ�
local STRING_TUTORIAL_17	= PreCreateString_1290		--GetSStringInfo(LAN_LUA_WND_PRACTICE_17)	-- �ʻ��
local STRING_TUTORIAL_18	= PreCreateString_1291		--GetSStringInfo(LAN_LUA_WND_PRACTICE_18)	-- �������
local STRING_TUTORIAL_19	= PreCreateString_1292		--GetSStringInfo(LAN_LUA_WND_PRACTICE_19)	-- ������
local STRING_TUTORIAL_20	= PreCreateString_1293		--GetSStringInfo(LAN_LUA_WND_PRACTICE_20)	-- 1.����Ű�� ��ǥ �������� �̵��ϱ�
local STRING_TUTORIAL_21	= PreCreateString_1294		--GetSStringInfo(LAN_LUA_WND_PRACTICE_21)	-- 1.Ÿ�ݰ����� �̿��� ���� Ʈ����!!
local STRING_TUTORIAL_22	= PreCreateString_1295		--GetSStringInfo(LAN_LUA_WND_PRACTICE_22)	-- 1.�������� �̿��� ���� Ʈ����!!
local STRING_TUTORIAL_23	= PreCreateString_1296		--GetSStringInfo(LAN_LUA_WND_PRACTICE_23)	-- 1.����Ŀ���� ������ ���Ͻÿ�!
local STRING_TUTORIAL_24	= PreCreateString_1297		--GetSStringInfo(LAN_LUA_WND_PRACTICE_24)	-- 1.�ʻ�⸦ ����� �ٿ���Ѷ�!
local STRING_TUTORIAL_25	= PreCreateString_1298		--GetSStringInfo(LAN_LUA_WND_PRACTICE_25)	-- 1.��������� ������Ű�ÿ�!
local STRING_TUTORIAL_26	= PreCreateString_1299		--GetSStringInfo(LAN_LUA_WND_PRACTICE_26)	-- 1.�������� ������Ű�ÿ�!
local STRING_TUTORIAL_27	= PreCreateString_1300		--GetSStringInfo(LAN_LUA_WND_PRACTICE_27)	-- 2.����Ű�� ��ǥ �������� �뽬�ϱ�
local STRING_TUTORIAL_28	= PreCreateString_1301		--GetSStringInfo(LAN_LUA_WND_PRACTICE_28)	-- Ʃ�丮���� �����Ͻðڽ��ϱ�?
local STRING_TUTORIAL_29	= PreCreateString_1302		--GetSStringInfo(LAN_LUA_WND_PRACTICE_29)	-- ������带 �����Ͻðڽ��ϱ�?
local STRING_TUTORIAL_30	= PreCreateString_1303		--GetSStringInfo(LAN_LUA_WND_PRACTICE_30)	-- �������� ������ ���
local STRING_TUTORIAL_31	= PreCreateString_1304		--GetSStringInfo(LAN_LUA_WND_PRACTICE_31)	-- ������ ���� ���
local STRING_TUTORIAL_32	= PreCreateString_1305		--GetSStringInfo(LAN_LUA_WND_PRACTICE_32)	-- �������� ������ ����
local STRING_TUTORIAL_33	= PreCreateString_1306		--GetSStringInfo(LAN_LUA_WND_PRACTICE_33)	-- ������ ���� ����
local STRING_TUTORIAL_34	= PreCreateString_1307		--GetSStringInfo(LAN_LUA_WND_PRACTICE_34)	-- 1.�������� ȹ���� �� ����϶�!
local STRING_TUTORIAL_35	= PreCreateString_1308		--GetSStringInfo(LAN_LUA_WND_PRACTICE_35)	-- 1.������ �ֿ� �� ����϶�!

local STRING_SPEAKERMAN		= PreCreateString_1369		--GetSStringInfo(LAN_LUA_WND_VILLAGE_1)		-- ����Ŀ��


g_IsFirstTutorial = IsTutorialFirst();

g_MainFrame = 0;	-- ��� �ʿ� ���µ� ÷�� ������ �߸�¥�� �ʿ��ϰ� ��
g_Time		= 0;

g_ApplyFrame1 = 0;
g_ApplyFrame2 = 0;

g_ApplyTime1 = 0;
g_ApplyTime2 = 0;
g_OnView = false;
g_StateTime = 0;

g_EnableKey = true;

-- ���� Ʃ�丮�� �� ����
SCN_NONE			= 0;
SCN_MAIN_MENU		= 1;
SCN_TUTORIAL_MODE	= 2;
SCN_MISSION_MODE	= 3;
SCN_PRACTICE_MODE	= 4;
SCN_START_TUTORIAL	= 5;
g_ScnState = SCN_START_TUTORIAL;
CurrentScene(g_ScnState)

local g_EndMotion = false
local g_MissionExp = 0
local g_MissionGran = 0

tWinName	= {['err'] = 0, 'sj_practice_back1', 'sj_practice_back2' }
tPosX		= {['err'] = 0,		48,				194 }

for i=1, #tWinName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", 'UIData/GameSlotItem001.tga', 0, 652);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setAlwaysOnTop(true)
	mywindow:setPosition(tPosX[i], 72);
	mywindow:setSize(105, 98)
	mywindow:setZOrderingEnabled(false);
	winMgr:getWindow('CommonAlertOkBox'):addChildWindow(mywindow)
end



tWinName	= {['err'] = 0, 'sj_practice_reward_exp', 'sj_practice_reward_gran', 'sj_practice_reward_congratulation', 'sj_practice_reward_numberImage'}
tTexName	= {['err'] = 0, 'UIData/GameSlotItem001.tga', 'UIData/GameSlotItem001.tga', 'UIData/popup001.tga','UIData/invisible.tga' }
tTextureX	= {['err'] = 0,  588,  392,  49, 0 }
tTextureY	= {['err'] = 0,  842,  842,  365, 0 }
tSizeX		= {['err'] = 0,   98,   98,  202, 349 }
tSizeY		= {['err'] = 0,   91,   91,  33,	 50 }
tPosX		= {['err'] = 0,   0,	0,  55, 0 }
tPosY		= {['err'] = 0,   0,	0,  2,	 172 }

for i=1, #tWinName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	if i == 4 then
		mywindow:subscribeEvent("EndRender", "CountRender")
	end
	if i == 1 or i == 2 then
		winMgr:getWindow('sj_practice_back'..tostring(i)):addChildWindow(mywindow)
	else
		winMgr:getWindow('CommonAlertOkBox'):addChildWindow(mywindow)
	end
end



function CountRender(args)
	if g_EndMotion then
		local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
		local _left = DrawEachNumber("UIData/other001.tga", g_MissionExp, 8, 92, 5, 11, 641, 24, 33, 25 , drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 5, 30, 29, 266, 643)
		
		local _left = DrawEachNumber("UIData/other001.tga", g_MissionGran, 8, 236, 5, 11, 683, 24, 33, 25, drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 5, 30, 29, 266, 685)
	end
end

function OnMotionEventEnd(args)
	g_EndMotion = true
end

winMgr:getWindow('CommonAlertOkBox'):setAlign(8);
winMgr:getWindow('CommonAlertOkBox'):addController("CommonAlertOkBoxCtrl0", "Shown", "xscale", "Quintic_EaseIn", 3, 255, 7, true, false, 10)
winMgr:getWindow('CommonAlertOkBox'):addController("CommonAlertOkBoxCtrl0", "Shown", "yscale", "Quintic_EaseIn", 3, 255, 7, true, false, 10)
winMgr:getWindow('CommonAlertOkBox'):addController("CommonAlertOkBoxCtrl0", "Shown", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10)
winMgr:getWindow('CommonAlertOkBox'):subscribeEvent("MotionEventEnd", "OnMotionEventEnd");

-- ������� ����
root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg'));
winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(winMgr:getWindow('CommonAlertOkBox'));

-- �����˾� �����ֱ�
g_OneTimeExcute = false;
function ShowCommonAlertOkBoxWithBG(point, exp)
	if g_OneTimeExcute == true then		
		return;
	end

	g_MissionExp = exp
	g_MissionGran = point
	g_OneTimeExcute = true;
	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg'));
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(winMgr:getWindow('CommonAlertOkBox'));
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	winMgr:getWindow('CommonAlertOkBox'):setVisible(true)
	PlayWave('sound/TutorialReward01.wav');
end

-- �����˾� OK��ư ������
function OnClickedCommonAlertOk(args)
	g_OneTimeExcute = false;
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false);
	winMgr:getWindow('CommonAlertOkBox'):setVisible(false);
	g_EndMotion = false;
	WndPractice_ClearCompensition();
end
winMgr:getWindow('CommonAlertOk'):subscribeEvent('Clicked', 'OnClickedCommonAlertOk');



function EnableKey(arg)
	Wnd_EnableKey(arg);
	g_EnableKey = arg;
end

g_SpaceAni = false;
g_SpaceTime = 0;
g_bShowAniSpace = false;
function MainLoop(delta)
	g_Time = g_Time + delta;
	g_SpaceTime = g_SpaceTime + delta;
	g_StateTime = g_StateTime + delta;
	
	g_ApplyTime1 = g_ApplyTime1 + delta;
	g_ApplyTime2 = g_ApplyTime2 + delta;
	
	if g_ApplyTime1 > 600 then
		g_ApplyTime1 = 600;
	end
	if g_ApplyTime2 > 600 then
		g_ApplyTime2 = 600;
	end
	
	local local_position0 = Linear_EaseNone(g_ApplyTime1, -400, 410, 600);
	local local_position1 = Linear_EaseNone(g_ApplyTime2, 767, -250, 600);
	winMgr:getWindow('sj_practice_speakermanImage'):setPosition(local_position0, 84);
	winMgr:getWindow('sj_practice_speakermanTalkWindow'):setPosition(0, local_position1);
	
	if g_Time > 800 then
		if g_OnView == false then
			if g_IsFirstTutorial == false then
				winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(true)
				g_OnView = true;
			else
				g_bShowAniSpace = true;
--				winMgr:getWindow('Click->'):setProperty('Visible', 'true');
				g_OnView = true;
			end
		end
	end
	
	if g_Time > 100000000 then
		g_Time = 10000000;
	end
	
	if g_StateTime > 100000000 then
		g_StateTime = 0;
	end
	
	-- �ִϸ��̼� �����̽��� �̹��� 
	AniSpaceImage(g_bShowAniSpace);
end




function OnEnterThisLua()
	g_MissionAllClear = false;
end

tPlayerInfoPosX = {['protecterr'] = 0,0,3500, 300 }
tPlayerInfoPosY = {['protecterr'] = 0,0,3500, 500 }

tCollisionPosX	= {['protecterr'] = 0,0,2300, 2300, -2300, -2300 }
tCollisionPosY	= {['protecterr'] = 0,0,2300, -2300, 2300, -2300 }

SetPlayerPos( 0, tPlayerInfoPosX[1], tPlayerInfoPosY[1], 0 );
SetPlayerPos( 1, tPlayerInfoPosX[2], tPlayerInfoPosY[2], 0 );
--SetPlayerPos( 2, tPlayerInfoPosX[3], tPlayerInfoPosY[3], 0 );


function HidePlayer(idx)
	SetPlayerPos( idx, 30000, 0, 0 );
end

g_MissionAllClear = false;
g_Player1MaxHP = 50;
g_IsMissionCompleteView = false;

--HidePlayer(1);

TUTORIAL_SEQ_WELCOME							= 1;	-- ����Ŀ ���� ȯ�� ���ش�.

TUTORIAL_SEQ_FIRST_DESC							= 2;
TUTORIAL_SEQ_CHAPTER1_DESC						= 3;	-- é��1�� �����ؼ� �����̴� ����� ����ϴ� ����� ���� ���ش�.
TUTORIAL_SEQ_CHAPTER1_MOVE						= 4;
TUTORIAL_SEQ_CHAPTER1_MOVE_SUCCESS				= 5;	-- ���� �̷��� ���� �� �ʿ�� ������ �����ϰ� �����.
TUTORIAL_SEQ_CHAPTER1_DASH						= 6;
TUTORIAL_SEQ_CHAPTER1_DASH_SUCCESS				= 7;

TUTORIAL_SEQ_CHAPTER2_DEFAULT_ATTACK_DESC		= 8;
TUTORIAL_SEQ_CHAPTER2_DEFAULT_ATTACK			= 9;
TUTORIAL_SEQ_CHAPTER2_DEFAULT_ATTACK_SUCCESS	= 10;

TUTORIAL_SEQ_CHAPTER3_DEFAULT_GRAB_DESC			= 11;
TUTORIAL_SEQ_CHAPTER3_DEFAULT_GRAB				= 12;
TUTORIAL_SEQ_CHAPTER3_DEFAULT_GRAB_SUCCESS		= 13;

TUTORIAL_SEQ_CHAPTER4_DEFAULT_EVADE_DESC		= 14;
TUTORIAL_SEQ_CHAPTER4_DEFAULT_EVADE				= 15;
TUTORIAL_SEQ_CHAPTER4_DEFAULT_EVADE_SUCCESS		= 16;

TUTORIAL_SEQ_CHAPTER4_DEFAULT_SPECIAL_DESC		= 17;
TUTORIAL_SEQ_CHAPTER4_DEFAULT_SPECIAL			= 18;
TUTORIAL_SEQ_CHAPTER4_DEFAULT_SPECAIL_SUCCESS	= 19;

TUTORIAL_SEQ_ALL_COMPLETE						= 20;


-- �̷������� �������� �޸𸮰� ���� �Ǵ��� ���� ����� �������� ������ ¥�°� ���� �� �Ѵ�. �޸� �Ƴ����ٰ� ���α׷��� ����� ����������..
TALK_SEQ_WELCOME			= 1;	-- Ʃ�丮�� ȯ��
TALK_SEQ_TUTORIAL_DESC		= 2;	-- Ʃ�丮�� ����
TALK_SEQ_CHAPTER1			= 3;	-- �̵��ϱ�
TALK_SEQ_CHAPTER2			= 4;	-- �뽬�ϱ�
TALK_SEQ_CHAPTER3			= 5;	-- Ÿ��
TALK_SEQ_CHAPTER4			= 6;	-- ���
TALK_SEQ_CHAPTER5			= 7;	-- ȸ��
TALK_SEQ_CHAPTER6			= 8;	-- �ʻ��
TALK_SEQ_CHAPTER7			= 9;	-- �������
TALK_SEQ_CHAPTER8			= 10;	-- ������
TALK_SEQ_CHAPTER9			= 11;	-- (�߰�) �������� ������ ����
TALK_SEQ_TUTORIAL_COMPLETE	= 12;	-- (�߰�) ������ ���� ����
TALK_SEQ_TUTORIAL_EXIT_GO	= 13;

g_TalkSeq = TALK_SEQ_WELCOME;
g_SubTalkSeq = 1;


----------------------------------------------------------------------

-- �Ϸᶧ �����ִ� �̺�Ʈ

----------------------------------------------------------------------
function OnCompleteViewText(args)
	local _window = winMgr:getWindow('AdditionHelp');
	local _visible = _window:isVisible()
	if _visible == true then
		winMgr:getWindow('AdditionHelp'):activeMotion("VisibleFire");
	end
end


----------------------------------------------------------------------

-- ��Ʈ�� �����ش�.

----------------------------------------------------------------------
function ShowAdditionMent(ment)
	winMgr:getWindow('AdditionHelp'):setVisible(true);
	CEGUI.toGUISheet(winMgr:getWindow('AdditionHelp')):setTextViewDelayTime(g_MiddleMentAppearSpeed);
	winMgr:getWindow('AdditionHelp'):clearTextExtends();
	winMgr:getWindow('AdditionHelp'):addTextExtends(ment,  tSpkMiddleMentFontData[1],tSpkMiddleMentFontData[2], 
														   tSpkMiddleMentFontData[3],tSpkMiddleMentFontData[4],tSpkMiddleMentFontData[5],tSpkMiddleMentFontData[6],   
														   tSpkMiddleMentFontData[7], 
														   tSpkMiddleMentFontData[8],tSpkMiddleMentFontData[9],tSpkMiddleMentFontData[10],tSpkMiddleMentFontData[11]);
end




----------------------------------------------------

--	Ʃ�丮�� �����Ȳ

----------------------------------------------------
function NextSequenceProcess()

	g_SubTalkSeq = g_SubTalkSeq + 1;
	g_EndMotion = false
	if g_SubTalkSeq <= #g_tCurMentString then
		local spk_ment_window = winMgr:getWindow('sj_practice_mentText');
		spk_ment_window:clearTextExtends();
		CEGUI.toGUISheet(spk_ment_window):setTextViewDelayTime(16);
		
		local tbufStringTable = {['err']=0, }
		local tbufSpecialTable = {['err']=0, }
		local count = 0

		tbufStringTable, tbufSpecialTable = cuttingString(g_tCurMentString[g_SubTalkSeq], tbufStringTable, tbufSpecialTable, count)
		
		for i=0, #tbufStringTable do
			local colorIndex = tonumber(tbufSpecialTable[i])
			if colorIndex == nil then
				colorIndex = 0
			end
			spk_ment_window:addTextExtends(tbufStringTable[i], tSpkMentFontData[1],tSpkMentFontData[2], 
																		tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2]
																		,tSpkMentFontData[6], tSpkMentFontData[7], 
																		tSpkMentFontData[8],tSpkMentFontData[9],tSpkMentFontData[10],tSpkMentFontData[11]);
		end
	end
	
	if g_SubTalkSeq > #g_tCurMentString then --���� ��Ʈ �迭�δ� ũ�ٸ� ���� é�ͷ� �Ѿ��.
		g_SubTalkSeq = 1;
		
		-----------------------------------------
		-- ��� Ʃ�丮���� ����.
		-----------------------------------------
		if IsKoreanLanguage() then
			if g_TalkSeq == TALK_SEQ_CHAPTER1 then
				g_TalkSeq = TALK_SEQ_CHAPTER3
			elseif g_TalkSeq == TALK_SEQ_CHAPTER6 then
				g_TalkSeq = TALK_SEQ_CHAPTER9
			elseif g_TalkSeq == TALK_SEQ_CHAPTER9 then
				g_TalkSeq = TALK_SEQ_TUTORIAL_EXIT_GO
			else
				g_TalkSeq = g_TalkSeq + 1;
			end
		else
			g_TalkSeq = g_TalkSeq + 1;
		end
		
		
		g_tCurMentString = g_tTalkTable[g_TalkSeq];
		
		CurrentTutorialState(g_TalkSeq)
				
		local spk_ment_window = winMgr:getWindow('sj_practice_mentText');
		spk_ment_window:setVisible(true);
		DestroyAllParticle()
		
		-- 2. ���Ŀ��� Ʃ�丮��� ���ϴ� ����
		if g_TalkSeq == TALK_SEQ_TUTORIAL_DESC then 
			ShowChapterTitle(1);
			
		-- 3. ��� ������� �ϰ� �̵��ϱ� Ʃ�丮���� ���� �ȴ�.
		elseif g_TalkSeq == TALK_SEQ_CHAPTER1 then
			SettingMissionStr(1);
			HideTutorialAllParents();
			ClickHelpProcess()
			
			winMgr:getWindow('sj_practice_explain_TutorialMission'):setVisible(true)
			winMgr:getWindow('sj_practice_helperDoc'):setVisible(true)
			winMgr:getWindow('sj_practice_wentout'):setVisible(true)
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, false, false, false);	-- Ű����
			ShowChapterTitle(-1);
			EnableKey(true);			
			ShowAdditionMent(g_tMiddleTalkTable[1]);
			
		-- 4. ����ϱ� Ʃ�丮���� ���� �ȴ�.
		elseif g_TalkSeq == TALK_SEQ_CHAPTER2 then			
			SettingMissionStr(1);
			HideTutorialAllParents();
			ClickHelpProcess()
			
			winMgr:getWindow('sj_practice_explain_TutorialMission'):setVisible(true)
			winMgr:getWindow('sj_practice_helperDoc'):setVisible(true)
			winMgr:getWindow('sj_practice_wentout'):setVisible(true)
			tCurChapterMissionStr[2] = STRING_TUTORIAL_2
			tCurChapterMissionStr[3] = STRING_TUTORIAL_3
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, false, false, false);
			ShowChapterTitle(-1);
			EnableKey(true);			
			ShowAdditionMent(g_tMiddleTalkTable[2]);
			
		-- 5. Ÿ�ݰ���
		elseif g_TalkSeq == TALK_SEQ_CHAPTER3 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(2);
			ChangeState(0, "AttackCheck");			
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, false, true, false);
			ShowChapterTitle(-1);
			ShowAdditionMent(g_tMiddleTalkTable[3]);
			
		-- 6. ������
		elseif g_TalkSeq == TALK_SEQ_CHAPTER4 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(3);
			ChangeState(0, "GrabCheck");
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, true, false, false);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[4]);
			
		-- 7.ȸ��
		elseif g_TalkSeq == TALK_SEQ_CHAPTER5 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(4);
			ChangeState(0, "EvadeCheck");
			ChangeState(1, "Round");
			ChangeAIPlayerType(1, AI_TYPE_ATTACKER);
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   true, false, false, false);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[5]);
			
		-- 8. �ʻ��
		elseif g_TalkSeq == TALK_SEQ_CHAPTER6 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(5);
			ChangeState(0, "SpecialCheck");
			ChangeState(1, "Round");
			ChangeAIPlayerType(1, AI_TYPE_ATTACKER);	-- �� Ÿ���� ���߿� ������ �־�� �Ѵ�.
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(true, true, true,   false, false, false, false);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[6]);
			
		-- 9. �������
		elseif g_TalkSeq == TALK_SEQ_CHAPTER7 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(6);
			ChangeState(0, "PlayerDoubleAttackCheck");
			ChangeState(1, "OnlyStand");
			ChangeState(2, "OnlyStand");
			ChangeAIPlayerType(1, AI_TYPE_DEFAULT);	-- �� Ÿ���� ���߿� ������ �־�� �Ѵ�.
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, true, false, false);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[7]);
			
		-- 10. ������
		elseif g_TalkSeq == TALK_SEQ_CHAPTER8 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(7);
			ChangeState(0, "TeamAttackCheck");
			ChangeState(1, "TeamAttackAssist");
			ChangeState(2, "TeamAttackStruck");
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, true, false, false);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[8]);			
			
		-- 11. �������� ������ ����
		elseif g_TalkSeq == TALK_SEQ_CHAPTER9 then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(8);
			ChangeState(0, "ItemUseCheck");
			ChangeAIPlayerType(1, AI_TYPE_DEFAULT);	-- �� Ÿ���� ���߿� ������ �־�� �Ѵ�.
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, false, false, true);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[9]);
			ShowBoxItem()
			
		-- 12. ������ ���� ����
		elseif g_TalkSeq == TALK_SEQ_TUTORIAL_COMPLETE then
			HideTutorialAllParents();
			ClickHelpProcess()
			ShowMissionRunUI();
			SettingMissionStr(9);
			ChangeState(0, "NoItemWeaponUseCheck");
			EnableKey(true);
			
			-- Q,W,E     A,S,D,F
			SettingKeysEnable(false, false, false,   false, true, true, true);
			ShowChapterTitle(-1);			
			ShowAdditionMent(g_tMiddleTalkTable[10]);
			
		-- 13. Ʃ�丮�� ��
		elseif g_TalkSeq == TALK_SEQ_TUTORIAL_EXIT_GO then
			
			DestroyAllCharacter();	-- �ƿ� ĳ���͵� ������� ���巯�� �Ѵ�.
			
			HideTutorialAllParents();
			ClickHelpProcess()
			g_MissionAllClear = true;
			
			-- ���� �޴��� ����
			ShowTutorialMainMenu();
			
			EnableKey(false);
			ShowChapterTitle(-1);
			
			g_SubTalkSeq = 1;
			g_TalkSeq = 1;
			g_tCurMentString = g_tTalkTable[g_TalkSeq];
			
			if g_IsFirstTutorial == true then
				BtnPageMove_GoToVillageFromPractive();
			end
		end
	end
end



----------------------------------------------------------------------

-- �����͸� ��ũâ���� ȭ�� ��ư �������� �̺�Ʈ

----------------------------------------------------------------------
function OnClickArrow(args)
	
	local isTalkComplete = CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):isCompleteViewText();	
	if g_ScnState == SCN_START_TUTORIAL and g_IsFirstTutorial == true then
		
		if isTalkComplete == true then
			StartTutorial();
		else
			CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):setCompleteViewText(true);			
		end				
		return;
	end
	
	if g_ScnState == SCN_TUTORIAL_MODE then
		
		if isTalkComplete == true then
			NextSequenceProcess();
		else
			CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):setCompleteViewText(true);
		end
		
		return;
	end
end




----------------------------------------------------------------------

-- �����̽�Ű ������

----------------------------------------------------------------------
function OnSpaceKeyArrow()
	if g_bVisibleTalkBG == true then
	else
		return;
	end
	NextSequenceProcess();
end



----------------------------------------------------------------------

-- Ʃ�丮�󿡼� �ɸ��� ����, �����ϱ�

----------------------------------------------------------------------
function SettingTutorialCharacter(arg, bWeapon, HP)
	StartCreateCharacter();
	if arg == 1 then
		CreateCharacter(0, 'strike', 0, 0, 0, -220, HP);
		CreateCharacter(1, 'strike', 1, tTutorialPlayerPosX, tTutorialPlayerPosY, 120, HP);
	elseif arg == 2 then		
		CreateCharacter(0, 'strike', 0, g_TeamAttackPosX[1], g_TeamAttackPosY[1], g_TeamAttackAngle[1], HP);
		CreateCharacter(1, 'strike', 0, g_TeamAttackPosX[2], g_TeamAttackPosY[2], g_TeamAttackAngle[2], HP); -- NPC�� ������������ �����.
		CreateCharacter(2, 'strike', 1, g_TeamAttackPosX[3], g_TeamAttackPosY[3], g_TeamAttackAngle[3], HP);
	elseif arg == 3 then
		CreateCharacter(0, 'strike', 0, g_TeamAttackPosX[1], g_TeamAttackPosY[1], g_TeamAttackAngle[1], HP);
		CreateCharacter(1, 'strike', 1, g_TeamAttackPosX[2], g_TeamAttackPosY[2], g_TeamAttackAngle[2], HP); -- NPC�� ������������ �����.
		CreateCharacter(2, 'strike', 1, g_TeamAttackPosX[3], g_TeamAttackPosY[3], g_TeamAttackAngle[3], HP);
	end
	EndCreateCharacter(bWeapon);
end
     
-- Ÿ��Ʋ ����
tTitleDesc = {['protecterr'] = 0, 
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."1: ", STRING_TUTORIAL_6,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."2: ", STRING_TUTORIAL_7,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."3: ", STRING_TUTORIAL_8,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."4: ", STRING_TUTORIAL_9,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."5: ", STRING_TUTORIAL_10,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."6: ", STRING_TUTORIAL_11,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."7: ", STRING_TUTORIAL_12,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."8: ", STRING_TUTORIAL_30,
STRING_TUTORIAL_4..STRING_TUTORIAL_5.."9: ", STRING_TUTORIAL_31
}

g_IsMissionComplete = false;
g_TitleSeq = 1;
g_TalkSeq = TALK_SEQ_WELCOME;

MAX_TUTORIAL_COUNT = 9


tChapterMissionStrTable = {['protecterr'] = 0, 
STRING_TUTORIAL_5.."1:", STRING_TUTORIAL_13, STRING_TUTORIAL_20,	-- 1, 2, 3
STRING_TUTORIAL_5.."2:", STRING_TUTORIAL_14, STRING_TUTORIAL_21,	-- 4, 5, 6
STRING_TUTORIAL_5.."3:", STRING_TUTORIAL_15, STRING_TUTORIAL_22,	-- 7, 8, 9
STRING_TUTORIAL_5.."4:", STRING_TUTORIAL_16, STRING_TUTORIAL_23,	-- 10, 11, 12
STRING_TUTORIAL_5.."5:", STRING_TUTORIAL_17, STRING_TUTORIAL_24,	-- 13, 14, 15
STRING_TUTORIAL_5.."6:", STRING_TUTORIAL_18, STRING_TUTORIAL_25,	-- 16, 17, 18
STRING_TUTORIAL_5.."7:", STRING_TUTORIAL_19, STRING_TUTORIAL_26,	-- 19, 20, 21
STRING_TUTORIAL_5.."8:", STRING_TUTORIAL_32, STRING_TUTORIAL_34,	-- 22, 23, 24
STRING_TUTORIAL_5.."9:", STRING_TUTORIAL_33, STRING_TUTORIAL_35		-- 25, 26, 27
}

-- �ѱ��� é�� 8�� 6���� ����
if IsKoreanLanguage() then
	tTitleDesc[15] = STRING_TUTORIAL_4..STRING_TUTORIAL_5.."6: ";
	tChapterMissionStrTable[22] = STRING_TUTORIAL_5.."6:";
end

tTutorialPlayerPosX = 3500;
tTutorialPlayerPosY = 3500;

tPlayerForceMovePosX = 0;
tPlayerForceMovePosY = 0;

tCurChapterMissionStr = {['err'] = 0, STRING_TUTORIAL_5.."1:", STRING_TUTORIAL_13, STRING_TUTORIAL_20 }
tCurChapterMissionStrPosX = {['err'] = 0, 150, 180, 17}
tCurChapterMissionStrPosY = {['err'] = 0, 12, 12, 48}

tChapterMissionStrPosX	= {['err'] = 0,
150, 180, 17,					-- 1,2,3		é��1
150, 180, 17,					-- 4,5,6		é��2
150, 180, 17,					-- 7,8,9		é��3
150, 180, 17,					-- 10,11,12		é��4
150, 180, 17,					-- 13,14,15		é��5
150, 180, 17,					-- 16,17,18		é��6
150, 180, 17,					-- 19,20,21		é��7
150, 166, 17,					-- 22,23,24		é��8
150, 166, 17					-- 25,26,27		é��9
}

tChapterMissionStrPosY	= {['err'] = 0,
14, 14, 48,						-- 1,2,3		é��1
14, 14, 48,						-- 4,5,6		é��2
14, 14, 48,						-- 7,8,9		é��3
14, 14, 48,						-- 10,11,12		é��4
14, 14, 48,						-- 13,14,15		é��5
14, 14, 48,						-- 16,17,18		é��6
14, 14, 48,						-- 19,20,21		é��7
14, 14, 48,						-- 22,23,24		é��8
14, 14, 48						-- 25,26,27		é��9
}

function SettingMissionStr(args)
	local sidx = (args-1)*3;
	tCurChapterMissionStr[1] = tChapterMissionStrTable[sidx+1];
	tCurChapterMissionStr[2] = tChapterMissionStrTable[sidx+2];
	tCurChapterMissionStr[3] = tChapterMissionStrTable[sidx+3];
	tCurChapterMissionStrPosX[1] = tChapterMissionStrPosX[sidx+1];
	tCurChapterMissionStrPosX[2] = tChapterMissionStrPosX[sidx+2];
	tCurChapterMissionStrPosX[3] = tChapterMissionStrPosX[sidx+3];
	tCurChapterMissionStrPosY[1] = tChapterMissionStrPosY[sidx+1];
	tCurChapterMissionStrPosY[2] = tChapterMissionStrPosY[sidx+2];
	tCurChapterMissionStrPosY[3] = tChapterMissionStrPosY[sidx+3];
end



----------------------------------------------------------------------

-- ���θ޴� �̵���

----------------------------------------------------------------------
function GotoMainMenu()
	HideTutorialAllParents();
	ShowSpeakerMan();
	winMgr:getWindow('sj_practice_speakermanTalkWindow'):setVisible(false)
	ShowPracticeModeUI(false);
	ShowChapterTitle(-1);
	winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(true)
	winMgr:getWindow('Click->'):setVisible(false)
	
	-- ��Ŭ�� ���ְ�
	SetbCollisionCircle(0, true);
	SetbCollisionCircle(1, true);
	SetbCollisionCircle(2, true);
	SetbCollisionCircle(3, true);
	
	-- Q,W,E     A,S,D,F
	SettingKeysEnable(true, true, true,   true, true, true, true);	-- Ű����
	DestroyAllCharacter();
	ShowPracticeHelp(-1);
	
	-- ĳ���͸� �����Ѵ�.
	g_SubTalkSeq = 1;
	g_TalkSeq = 1;
	g_tCurMentString = g_tTalkTable[g_TalkSeq];
	
	RemoveCircle(0);
	RemoveCircle(1);
	RemoveCircle(2);
	RemoveCircle(3);
	g_StateTime = 0;
	g_IsMissionComplete = false;
	g_IsMissionCompleteView = false;
	winMgr:getWindow('sj_practice_missionSuccessTitle'):setPosition(-500, 200);
	
	ChangeAIPlayerType(0, AI_TYPE_DEFAULT);
	ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
	ChangeAIPlayerType(2, AI_TYPE_DEFAULT);
	
	g_IsMissionComplete = false;
	
	winMgr:getWindow('AdditionHelp'):clearTextExtends();
	winMgr:getWindow('AdditionHelp'):clearActiveController();
	winMgr:getWindow('AdditionHelp'):setVisible(false);

	g_ScnState = SCN_MAIN_MENU;
	CurrentScene(g_ScnState)
end



----------------------------------------------------------------------

-- Ʃ�丮�� ���� �Ⱥ��̰� �ϱ�

----------------------------------------------------------------------
function HideTutorialAllParents()
	winMgr:getWindow('sj_practice_speakermanImage'):setVisible(false)
	winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(false)
	winMgr:getWindow('sj_practice_speakermanTalkWindow'):setVisible(false)
	
	ShowChapterTitle(-1);
	winMgr:getWindow('sj_practice_explain_TutorialMission'):setVisible(false)
	
	winMgr:getWindow('sj_practice_keyDesc_move'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_attack'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_grab'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_evade'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_special'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_doubleAtk'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_teamAtk'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_itemDesc'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_noItemDesc'):setVisible(false)
	
	winMgr:getWindow('Click->'):setVisible(false)
	winMgr:getWindow('sj_practice_helperDoc'):setVisible(false)
	winMgr:getWindow('sj_practice_wentout'):setVisible(false)
	g_bVisibleTalkBG = false;
end



----------------------------------------------------------------------

-- F1Ű�� ���� ���� ���̰� �ϱ�(�⺻ F1 ���̰� ����)

----------------------------------------------------------------------
g_bKeyDescVisible = true
function ClickHelpProcess()
	winMgr:getWindow('sj_practice_keyDesc_move'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_attack'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_grab'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_evade'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_special'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_doubleAtk'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_teamAtk'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_itemDesc'):setVisible(false)
	winMgr:getWindow('sj_practice_keyDesc_noItemDesc'):setVisible(false)
	
	if g_bKeyDescVisible == true then	--���� �ȳ�Ÿ ���ٸ� �ش� ���׸� �������� �Ѵ�.
		if g_TalkSeq == TALK_SEQ_CHAPTER1 then	--3
			winMgr:getWindow('sj_practice_keyDesc_move'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER2 then	--4
			winMgr:getWindow('sj_practice_keyDesc_move'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER3 then	--5
			winMgr:getWindow('sj_practice_keyDesc_attack'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER4 then	--6
			winMgr:getWindow('sj_practice_keyDesc_grab'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER5 then	--7
			winMgr:getWindow('sj_practice_keyDesc_evade'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER6 then	--8
			winMgr:getWindow('sj_practice_keyDesc_special'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER7 then	--8
			winMgr:getWindow('sj_practice_keyDesc_doubleAtk'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER8 then	--9
			winMgr:getWindow('sj_practice_keyDesc_teamAtk'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_CHAPTER9 then	--10
			winMgr:getWindow('sj_practice_keyDesc_itemDesc'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_TUTORIAL_COMPLETE then	--11
			winMgr:getWindow('sj_practice_keyDesc_noItemDesc'):setVisible(true)
			
		elseif g_TalkSeq == TALK_SEQ_TUTORIAL_EXIT_GO then	--12
		end
	end	
end


----------------------------------------------------------------------

-- �̵�, ����� ������ ���̱�

----------------------------------------------------------------------
function ShowCollisionCircle(args)
	local bshow = true;
	if args then
		bshow = false;
	end
	for i=1, #bMoveCircleSlot do
		bMoveCircleSlot[i] = bshow;
		SetbCollisionCircle( (i-1), bshow );
	end
end



----------------------------------------------------------------------

-- ����Ŀ�� ���̱�

----------------------------------------------------------------------
function ShowSpeakerMan()
	winMgr:getWindow('sj_practice_speakermanImage'):setVisible(true)
	winMgr:getWindow('sj_practice_speakermanTalkWindow'):setVisible(true)
	g_bShowAniSpace = true;
end


function ShowMissionRunUI()
	winMgr:getWindow('sj_practice_explain_TutorialMission'):setVisible(true)
	winMgr:getWindow('sj_practice_helperDoc'):setVisible(true)
	winMgr:getWindow('sj_practice_wentout'):setVisible(true)
end


function ShowTutorialMainMenu()
	winMgr:getWindow('sj_practice_speakermanImage'):setVisible(true)
	winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(true)
end


function OnClickNoActiveTutorial(args)	-- ��Ȱ�� ��ư ������ �翬�� �ƹ� ���� ���� �����.
end



----------------------------------------------------------------------

-- Ʃ�丮�� ����

----------------------------------------------------------------------
function StartTutorial()
	g_OneTimeExcute = false;	-- ����â�� �ѹ��� ���� ���ؼ�..
	
	ShowCollisionCircle(true);
	
	-- ó������ �����ߴٰ� ������ �Ʒ����� �ּ��� Ǯ����.
	StartCreateCharacter();
	local HP = 3000
	CreateCharacter(0, 'strike', 0, 0, -220, 0, HP);	
	EndCreateCharacter(false);	
	ChangeState(0, 'MoveCheck');
	
	g_PracticeScnState	= SCN_TUTORIAL_MODE;		-- Ʃ�丮�� ȭ������ �̵�
	g_TotorialSeq		= TUTORIAL_SEQ_FIRST_DESC;	-- ���߿� Ʃ�丮�� ���� �� �� �ְԲ� �Ѵ�.
	
	g_SubTalkSeq = 1;
	g_TalkSeq = 2;
	g_tCurMentString = g_tTalkTable[g_TalkSeq];
	
	local spk_ment_window = winMgr:getWindow('sj_practice_mentText');
	spk_ment_window:clearTextExtends();
	CEGUI.toGUISheet(spk_ment_window):setTextViewDelayTime(16);
	
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0

	tbufStringTable, tbufSpecialTable = cuttingString(g_tCurMentString[g_SubTalkSeq], tbufStringTable, tbufSpecialTable, count)
	
	for i=0, #tbufStringTable do
		local colorIndex = tonumber(tbufSpecialTable[i])
		if colorIndex == nil then
			colorIndex = 0
		end
		spk_ment_window:addTextExtends(tbufStringTable[i], tSpkMentFontData[1],tSpkMentFontData[2], 
																	   tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2]
																	   ,tSpkMentFontData[6], tSpkMentFontData[7], 
																	   tSpkMentFontData[8],tSpkMentFontData[9],tSpkMentFontData[10],tSpkMentFontData[11]);
	end
	winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(false) -- ���� �޴��� ������� �ϰ�
	g_bShowAniSpace = true;
--	winMgr:getWindow('Click->'):setProperty('Visible', 'true');		-- Ŭ�� ��ư�� ��Ÿ���� �Ѵ�.
	ShowSpeakerMan();
	g_bVisibleTalkBG = true;
	g_MissionAllClear = false;
	g_IsMissionComplete = false;
	
	EnableKey(false);
	g_ScnState = SCN_TUTORIAL_MODE;
	CurrentScene(g_ScnState)
end


----------------------------------------------------------------------

-- Ʃ�丮�� ��ư �̺�Ʈ

----------------------------------------------------------------------
function OnClickTutorial(args)
	StartTutorial();
end


----------------------------------------------------------------------

-- �̼Ǹ�� ��ư �̺�Ʈ

----------------------------------------------------------------------
function OnClickMissionMode(args)
	g_PracticeScnState = SCN_MISSION_MODE;
end



----------------------------------------------------------------------

-- ������ ��ư �̺�Ʈ
----------------------------------------------------------------------
function OnClickQuit(args)
	BtnPageMove_GoToVillageFromPractive();
end


----------------------------------------------------------------------

-- ������ Ŭ��������

----------------------------------------------------------------------
function OnClickHelp(args)	
	local _spk_visible = winMgr:getWindow('sj_practice_speakermanTalkWindow'):isVisible()
	if _spk_visible == false then
		if g_bKeyDescVisible then
			g_bKeyDescVisible = false
		else
			g_bKeyDescVisible = true
		end
		ClickHelpProcess();
	end
end


----------------------------------------------------------------------

-- �����⸦ Ŭ��������

----------------------------------------------------------------------
function OnClickExit(args)
	if g_IsFirstTutorial == true then
		ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_28, "FirstTutorialSkipOk", "FirstTutorialSkipCancel")
	else
		ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_28, "OnClickedCommonAlertQuestOk", "OnClickedCommonAlertQuestCancel")
	end		
end


----------------------------------------------------------------------

-- ����Ŀ�� ��ũ �׸���

----------------------------------------------------------------------
function renderSpeekerTalkText(args)
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setFont(g_STRING_FONT_DODUMCHE, 20);
	common_DrawOutlineText2(drawer, STRING_SPEAKERMAN..' :', tMentPosX, tMentPosY, 0,0,0,255, 255,255,0,255)
end


----------------------------------------------------------------------

-- é�� Ÿ��Ʋ �׸���

----------------------------------------------------------------------
--[[
function renderTutorialTitle(args)
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setFont(g_STRING_FONT_DODUMCHE, 18);
	local pos_x = 20;
	local pos_y = 14;
	if g_TitleSeq < MAX_TUTORIAL_COUNT then
		common_DrawOutlineText2(drawer, tTitleDesc[(g_TitleSeq-1)*2+1], pos_x+0, pos_y+0, 0,0,0,255, 255,255,255,255)
		common_DrawOutlineText2(drawer, tTitleDesc[(g_TitleSeq-1)*2+2], pos_x+180, pos_y+0, 0,0,0,255, 243,174,50,255)
	elseif g_TitleSeq == MAX_TUTORIAL_COUNT then
		common_DrawOutlineText2(drawer, "Ʃ�丮�� �Ϸ�", pos_x+45, pos_y+0, 0,0,0,255, 255,255,255,255)
	end
end
--]]

----------------------------------------------------------------------

-- �����ʿ� �ִ� �̼� ���� â

----------------------------------------------------------------------
function renderTutorialMissionDesc(args)
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setFont(g_STRING_FONT_DODUMCHE, 15);
	
	local titleSize = GetStringSize(g_STRING_FONT_DODUMCHE, 15, tCurChapterMissionStr[1])
	common_DrawOutlineText2(drawer, tCurChapterMissionStr[1], 162-titleSize,				tCurChapterMissionStrPosY[1], 0,0,0,255, 255,255,255,255)
	common_DrawOutlineText2(drawer, tCurChapterMissionStr[2], tCurChapterMissionStrPosX[2], tCurChapterMissionStrPosY[2], 0,0,0,255, 255,255,0,255)
	common_DrawOutlineText2(drawer, tCurChapterMissionStr[3], tCurChapterMissionStrPosX[3], tCurChapterMissionStrPosY[3], 0,0,0,255, 255,255,255,255)
	
	if g_TalkSeq == TALK_SEQ_CHAPTER1 then
		drawer:drawTexture("UIData/tutorial003.tga", 44, 70, 269, 83, 712, 0);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER2 then
		drawer:drawTexture("UIData/tutorial003.tga", 44, 70, 269, 83, 712, 0);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER3 then
		drawer:drawTexture("UIData/tutorial003.tga", 10, 70, 340, 88, 367, 934);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER4 then
		drawer:drawTexture("UIData/tutorial003.tga", 10, 65, 340, 100, 10, 914);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER5 then
		drawer:drawTexture("UIData/tutorial003.tga", 44, 90, 269, 60, 720, 101);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER6 then
		drawer:drawTexture("UIData/tutorial003.tga", 50, 90, 269, 60, 720, 162);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER7 then
		drawer:drawTexture("UIData/tutorial003.tga", 152, 90, 45, 45, 160, 910);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER8 then
		drawer:drawTexture("UIData/tutorial003.tga", 44, 70, 269, 83, 712, 0);
		
	elseif g_TalkSeq == TALK_SEQ_CHAPTER9 then
		drawer:drawTexture("UIData/tutorial003.tga", 156, 90, 39, 39, 712, 850);
		
	elseif g_TalkSeq == TALK_SEQ_TUTORIAL_COMPLETE then
		drawer:drawTexture("UIData/tutorial005.tga", 14, 62, 288, 106, 369, 345)
	end
	
end



----------------------------------------------------------------------

-- �ɸ��� ������ �׸���

----------------------------------------------------------------------
function renderMiniGage(char_idx, screenX, screenY, curHP, maxHP, curSP, playerX, playerY, level, name)
	
	if screenX > 1920 or screenX < 0 then
		return;
	end
	
	--local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
	local offsetX = 0;
	if char_idx == 0 then
		screenX = screenX + offsetX+20;--screenX - offsetX-35;
	else
		screenX = screenX + offsetX;
	end
	
	g_PlayerX[char_idx+1] = playerX;
	g_PlayerY[char_idx+1] = playerY;
	
	root_drawer:setFont(g_STRING_FONT_GODIC, 20);
	if char_idx == 0 then
		root_drawer:setTextColor(255, 255, 255, 255)
	else
		root_drawer:setTextColor(0, 255, 0, 255)
	end

	if char_idx > -1 and char_idx < 10 then
		local realwidth = 82
		local offset_x = -60;
		local offset_y = -15;
	
		--�̴� ������ ����
		if char_idx == 0 then
			root_drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+offset_x, 0 + screenY+offset_y, realwidth+4, 14, 603, 699)
		else
			root_drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+offset_x, 0 + screenY+offset_y, realwidth+4, 7, 603, 699)
		end
		
		-- ��ȭ�ϴ� �̴� ������
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+offset_x, 1 + screenY+offset_y, curHP, 8, 605, 729)
		
		--���� �̴� ������
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+offset_x, 1 + screenY+offset_y, curHP, 8, 605, 721)
		if char_idx == 0 then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+offset_x, 8 + screenY+offset_y, curSP, 8, 605, 769)
		end
		
		if char_idx == 0 then
			root_drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
			root_drawer:setTextColor(0,0, 0, 255);
			local id_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)+38)/2;
			common_DrawOutlineText1(root_drawer, 'Lv.' ..tostring(level),  screenX+62-id_width-82,  screenY+offset_y-20, 0,0,0,255, 255,180,0,255);
			common_DrawOutlineText1(root_drawer, name, screenX+96-id_width-78, screenY+offset_y-20, 0,0,0,255, 102,204,102,255);
		else
			if g_ScnState == SCN_PRACTICE_MODE then
				root_drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
				root_drawer:setTextColor(255,255,255,255);
				local id_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)+38)/2;
				root_drawer:drawText(name, screenX-20-id_width/2, screenY+offset_y-20)
			end
		end		
	end	
end





-------------------------------------------------

-- �����ǿ��� ���̴� ����ƽ �̹���

-------------------------------------------------
tWinName	= {['protecterr'] = 0, 'sj_practice_speakermanImage', 'sj_practice_mainMenu_backImage', 'sj_practice_speakermanTalkWindow', 
'sj_practice_title_tutorial', 'sj_practice_explain_TutorialMission', 'sj_practice_missionSuccessTitle', 'sj_practice_tutorialStaticImage'}

tTexName	= {['protecterr'] = 0, 'UIData/tutorial002.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 
'UIData/tutorial001.tga', 'UIData/tutorial003.tga', 'UIData/tutorial001.tga', 'UIData/tutorial003.tga' }
tTextureX	= {['protecterr'] = 0,    0,    3,    0,    0, 356,    0,  728 }
tTextureY	= {['protecterr'] = 0,    0,  232,    0,  591, 568,  593,  504 }
tSizeX		= {['protecterr'] = 0,  494,  243,  1024,  328, 356,  420,  120 }
tSizeY		= {['protecterr'] = 0,  685,  274,  229,   52, 165,   64,   34 }
tPosX		= {['protecterr'] = 0,   10,  396,   0,  348, 658, 1920,	 7 }
tPosY		= {['protecterr'] = 0,   84,  172,  526,   24,  10,    0,    7 }

for i=1, #tWinName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	
	if i == 1 then
		mywindow:setWideType(7);
	elseif i ==2 then
		mywindow:setWideType(5);
	elseif i ==3 then
		mywindow:setWideType(7); 
	elseif i ==4 then
		mywindow:setWideType(5);
	elseif i == 5 then
		mywindow:setWideType(1); -- Ű�Է�ȭ��
	elseif i == 6 then
		--mywindow:setWideType(5);
	else
		--mywindow:setWideType(1);
	end
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setZOrderingEnabled(false);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	root:addChildWindow(mywindow)
end

winMgr:getWindow('sj_practice_speakermanTalkWindow'):subscribeEvent('EndRender', 'renderSpeekerTalkText');
winMgr:getWindow('sj_practice_title_tutorial'):setVisible(false)
winMgr:getWindow('sj_practice_explain_TutorialMission'):subscribeEvent('EndRender', 'renderTutorialMissionDesc');
winMgr:getWindow('sj_practice_explain_TutorialMission'):setVisible(false)
winMgr:getWindow('sj_practice_mainMenu_backImage'):setVisible(false)
winMgr:getWindow('sj_practice_explain_TutorialMission'):addChildWindow( winMgr:getWindow('sj_practice_tutorialStaticImage') );



-------------------------------------------------

-- Ű���� ����ƽ �̹���

-------------------------------------------------
tWinName	= {['protecterr'] = 0, 'sj_practice_keyDesc_move', 'sj_practice_keyDesc_attack', 'sj_practice_keyDesc_grab', 'sj_practice_keyDesc_evade', 
	'sj_practice_keyDesc_special', 'sj_practice_keyDesc_doubleAtk', 'sj_practice_keyDesc_teamAtk', 'sj_practice_keyDesc_itemDesc', 'sj_practice_keyDesc_noItemDesc'}
tTexName	= {['protecterr'] = 0, 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 
				'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 'UIData/tutorial004.tga', 'UIData/tutorial004.tga' }
tTextureX	= {['protecterr'] = 0,  356,  356,    0,    0,   0, 356, 0,		0,		394 }
tTextureY	= {['protecterr'] = 0,  402,    0,    0,  388, 561, 738, 738,	854,	854 }
tSizeX		= {['protecterr'] = 0,  356,  356,  356,  356, 356, 356, 356 ,	353,	353}
tSizeY		= {['protecterr'] = 0,  165,  180,  180,  172, 176, 154, 154,	161,	149 }
tPosX		= {['protecterr'] = 0,  658,  658,  658,  658, 658, 658, 658,	658,	658 }
tPosY		= {['protecterr'] = 0,  186,  186,  186,  186, 186, 186, 186,	186,	186 }

-- 402 -> 180 ���� �̹��� �Ʒ��� ����
-- 387 -> 180 ��� �̹��� �Ʒ��� ����

for i=1, #tWinName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setWideType(1);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setZOrderingEnabled(false);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
end

winMgr:getWindow('sj_practice_keyDesc_move'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_attack'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_grab'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_evade'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_special'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_doubleAtk'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_teamAtk'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_itemDesc'):setVisible(false)
winMgr:getWindow('sj_practice_keyDesc_noItemDesc'):setVisible(false)

-- f1 �������� ���ʿ� Add�� ���δ�.
root:addChildWindow(winMgr:getWindow('sj_practice_missionSuccessTitle'))


----------------------------------------------------------------------

-- ������ ���� �޴� ��ư ����� 'Ʃ�丮��', '�̼Ǹ��', '�������', '������'

----------------------------------------------------------------------
tWinMainMenuButtonName = {['protecterr'] = 0, 'sj_practice_tutorialImage', 'sj_practice_missionModeImage', 'sj_practice_practiceModeImage', 'sj_practice_exitImage', 
					'Click->', 'sj_practice_helperDoc', 'sj_practice_wentout', 'sj_practice_tutorialImage_disabled', 'sj_practice_missionModeImage_disabled' }

tTextureX = {['protecterr'] = 0,	         57,    48+244,		  545,		789, 896,      730,       730+110,		  48,    48+244 }
tTextureY = {['protecterr'] = 0,            740,       736,       740,      740, 379,      233,			  233,	736+72*3,  736+72*3 }		
tTextureHoverX = {['protecterr'] = 0,        57,    48+244,  	  545,		789, 896,      730,		  730+110,		  48,    48+244 }
tTextureHoverY = {['protecterr'] = 0,    740+72,    736+72,    740+72,   740+72, 470,   233+85,		   233+85,	736+72*3,  736+72*3 }
tTexturePushedX = {['protecterr'] = 0,       57,    48+244,       545,		789, 896   ,   730,		  730+110,		  48,    48+244 }
tTexturePushedY = {['protecterr'] = 0, 740+72*2,  736+72*2,  740+72*2, 740+72*2, 558, 233+85*2,		  233+85*2,	736+72*3,  736+72*3 }

nSizeX = {['protecterr'] = 0,               226,       226,       226,      226, 118, 110, 110, 244, 244 }
nSizeY = {['protecterr'] = 0,                64,        64,        64,       64,  75,  85,  85,  72,  72 }

tPosX = {['protecterr'] = 0, 9,    9,      9,      9,		828, 20, 5+120, 18, 18 }
tPosY = {['protecterr'] = 0, 51, 51+71*5, 51+71, 51+71*2,	138, 668, 668,     23, 23+80 }
tTextureName = {['protecterr'] = 0 , 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 
		'UIData/tutorial001.tga', 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga' }
-- ���� ���� ����
-- TutorialScene
-- OnClickTutorial
MainMenuClickedEventName = {['protecterr'] = 0 , 'OnClickTutorial', 'OnClickMissionMode', 'OnClickPracticeMode', 'OnClickQuit', 
		'OnClickArrow', 'OnClickHelp', 'OnClickExit', 'OnClickNoActiveTutorial', 'OnClickNoActiveTutorial' }
parentWindow = winMgr:getWindow('sj_practice_mainMenu_backImage');

for i=1, #tWinMainMenuButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinMainMenuButtonName[i]);
	mywindow:setTexture("Normal", tTextureName[i], tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", tTextureName[i], tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", tTextureName[i], tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", tTextureName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX[i], nSizeY[i]);
	if i == 6 or i == 7 then
		mywindow:setWideType(2);
	end
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:subscribeEvent("Clicked", MainMenuClickedEventName[i]);
	parentWindow:addChildWindow(mywindow)
end


winMgr:getWindow('Click->'):setSubscribeEvent('MouseLeave', 'SpaceBtImgLeave');
winMgr:getWindow('sj_practice_speakermanTalkWindow'):addChildWindow(winMgr:getWindow('Click->'));
winMgr:getWindow('Click->'):setVisible(false)
winMgr:getWindow('sj_practice_missionModeImage'):setVisible(false)
root:addChildWindow(winMgr:getWindow('sj_practice_helperDoc'));
root:addChildWindow(winMgr:getWindow('sj_practice_wentout'));
winMgr:getWindow('sj_practice_helperDoc'):setVisible(false)
winMgr:getWindow('sj_practice_wentout'):setVisible(false)
winMgr:getWindow('sj_practice_missionModeImage_disabled'):setVisible(false)
winMgr:getWindow('sj_practice_tutorialImage_disabled'):setVisible(false)




----------------------------------------------------------------------

--  c++���� ������ �Լ�

----------------------------------------------------------------------
-- InputKey(int index, __int64 tick, bool down, int keyCode, int keyState )
-- GetDistanceFromCircle(from_idx,to_idx) --from ���� to ������ �Ÿ� from �� �ַ� �÷��̾�� ���δ�.



----------------------------------------------------------------------

-- ���� ���� ������

----------------------------------------------------------------------
PLAYER_DIR_NONE			= 0;
PLAYER_DIR_LEFT_UP		= 5;
PLAYER_DIR_LEFT_DOWN	= 9;
PLAYER_DIR_RIGHT_UP		= 6;
PLAYER_DIR_RIGHT_DOWN	= 10;
PLAYER_DIR_LEFT			= 1;
PLAYER_DIR_RIGHT		= 2;
PLAYER_DIR_UP			= 4;
PLAYER_DIR_DOWN			= 8;



----------------------------------------------------------------------

-- ���� ��� ���� ������

----------------------------------------------------------------------
STATE_STAND			= 0;	-- ��������, �ɾ�ٴҶ�
STATE_LAND			= 1;	-- ���� ������
STATE_AIR			= 2;	-- ���߿� ��������
STATE_DASH			= 3;	-- �پ�ٴҶ�
STATE_COUNT			= 4;
STATE_DEFAULT		= 5;


STATE_NORMAL		= 0;	-- �Ϲݻ���
STATE_SPECIAL		= 1;	-- �ʻ�� �� 3�����
STATE_EVADE			= 2;	-- ȸ�Ǳ���
STATE_EVADE_NORMAL	= 3;	-- �ٸ� ȸ�Ǳ���
STATE_ATTACK		= 4;	-- �Ϲ� Ÿ�����϶�
STATE_GRAB			= 5;	-- ��� �������϶�
STATE_GRABED		= 6;	-- ��������
STATE_SPECIALGRAB	= 7;
STATE_DAMAGED		= 8;	-- �°�������
STATE_COUNT			= 9;
STATE_DEFAULT		= 10;


-- ex) CheckMotion(0, STATE_STAND)
-- ex) CheckBehavior(0, STATE_EVADE)
function CheckMotion(idx, arg)		-- ���� ����� arg�� ������ �Ǵ� ex) CheckMotion(0, STATE_STAND)
	if GetPlayerMotion(idx) == arg then
		return true;
	end
	return false;
end


function CheckBehavior(idx, arg)	-- ���� �ൿ�� arg�� ������ �Ǵ� ex) CheckBehavior(0, STATE_EVADE) 
	if GetPlayerBehavior(idx) == arg then
		return true;
	end
	return false;
end


g_StrMotionTable = {['protecterr'] = 0,    'stand', 'land', 'air', 'dash', 'count', 'default' }


function GetCurMotionStr(idx)
	local local_motion = GetPlayerMotion(idx)+1;
	if local_motion > 0 and local_motion < (#g_StrMotionTable+1) then
		return g_StrMotionTable[local_motion];
	end
	return 'none';
end


g_StrBehaviorTable = {['protecterr'] = 0,    'normal', 'special', 'evade', 'evade_normal', 'attack', 'grab', 'grabed', 'specialgrab', 'demaged', 'count', 'default' }

function GetCurBehaviorStr(idx)
	local local_behavior = GetPlayerBehavior(idx)+1;
	if local_behavior > 0 and local_behavior < (#g_StrBehaviorTable+1) then
		return g_StrBehaviorTable[local_behavior];
	end
	return 'none';
end


function CheckActionName(char_idx, args)
	if GetCurrentActionName(char_idx) == args then
		return true;
	end
	return false;
end



----------------------------------------------------------------------

-- ���� ��� ���� Util �Լ�

----------------------------------------------------------------------
-- �׳� �ش�Ű ª�� �����ִ� ������ �Ѵ�.
function Input(idx, key)
	local tick = 2
	InputA(idx, tick, key);
end



-- �׳� �ش� ����Ű ª�� �����ִ� ������ �Ѵ�.
function InputDirKey(idx, key)
	local tick = 1;
	InputD(idx, tick, key);
end


-- ���� ����� arg�� ������ �Ǵ� ex) CheckMotion(0, STATE_STAND)
function CheckMotion(idx, arg)
	if GetPlayerMotion(idx) == arg then
		return true;
	end
	return false;
end


-- ���� �ൿ�� arg�� ������ �Ǵ� ex) CheckBehavior(0, STATE_EVADE) 
function CheckBehavior(idx, arg)
	if GetPlayerBehavior(idx) == arg then
		return true;
	end
	return false;
end


function CheckMissionComplete(args)
	for i=1, #bMoveCircleSlot do
		if bMoveCircleSlot[i] == false then
			return false;
		end
	end
	return true;
end




function OnChangeHPSP(characterA1, characterD1, atkPercent, deltaSPA, deltaSPD)	
end



----------------------------------------------------------------------

-- �̼��� �������� ��(Complete ���� ������ ���� �̺�Ʈ)

----------------------------------------------------------------------
g_IsPlayMissionSound = false;
function MissionCompleteMoveProcess(start_time)

	if g_StateTime > start_time then
		local apply_time = g_StateTime - start_time;
		if g_StateTime-start_time < 1000 then
			local local_cpos = Elastic_EaseOut(apply_time, 1024, -512-210, 1000, 0, 0);	-- ��� ���� ��� ���
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setPosition(local_cpos, 200);
		end
		
		if apply_time > 100 then
			if g_IsPlayMissionSound == true then
				PlayWave('sound/Tutorial_Success.wav');
				g_IsPlayMissionSound = false;
			end
		end
		
		if apply_time > 999 and g_StateTime < 1400 then
		end
		
		if apply_time > 1399 and apply_time < 2101 then
			local local_cpos = Back_EaseIn(apply_time-1399, 1024-512-210, 0-920, 700, 0);
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setPosition(local_cpos, 200);
		end
	end
end





--------------------------------------------------------------------

-- �÷��̾� ���� ����

--------------------------------------------------------------------

--------------------------------------
-- GlobalPlayer ���� ��� ����
--------------------------------------
function CGlobalPlayerState_OnEnter(idx)
	--InputKey(idx, 1, true, 'NOKEY', 0);	-- �̷��� �ؾ� �ƹ��͵� �ȴ����� ���°� �ȴ�.
end

function CGlobalPlayerState_Update(idx)
	--InputKey(idx, 1, true, 'NOKEY', 0);	-- �̷��� �ؾ� �ƹ��͵� �ȴ����� ���°� �ȴ�.
end

function CGlobalPlayerState_OnExit(idx)
end



tPlayerForceMovePosX = 0;
tPlayerForceMovePosY = 0;
--------------------------------------
-- ForceMove ���� ��� ����
--------------------------------------
-- �� ���´� Ʃ�丮�󿡼� �� ���� �� �ִ�.
function CForceMoveState_OnEnter(idx)
	--InputKey(idx, 1, true, 'NOKEY', 0);
end

function CForceMoveState_Update(idx)
	if GetTargetPosDistance(idx, tPlayerForceMovePosX, tPlayerForceMovePosY) < 750 then	-- Ÿ�ٿ� �ٴٸ���
		local cur_my_dir = GetCurPlayerDir(idx);
		local mytarget_dir = GetTargetPosDir(idx, tTutorialPlayerPosX, tTutorialPlayerPosY)
		if cur_my_dir == mytarget_dir then
			InputPlayerKey( false, 'NOKEY', 0);
			ChangeState(idx, "GlobalPlayer");
			g_bVisibleTalkBG = true;
		else
			InputPlayerKey( true, 'NOKEY', mytarget_dir);
		end
		
	else	-- Ÿ�ٿ� ������ ���� ������ �ش� �������� �̵�
		InputPlayerKey(true, 'NOKEY', GetTargetPosDir(idx, tPlayerForceMovePosX, tPlayerForceMovePosY));
	end
end


function CForceMoveState_OnExit(idx)
	--InputKey(idx, 1, true, 'NOKEY', 0);
end




------------------------------------------

----- 1��° ���� Ʃ�丮��

------------------------------------------
bMoveCircleSlot = {['protecterr'] = 0 , false, false, false, false }
function CMoveCheckState_OnEnter(idx)
	g_StateTime = 0;
	ResetCircle();
end

function CMoveCheckState_Update(idx)
	for i=1, #bMoveCircleSlot do
		if IsKoreanLanguage() == false then
			if g_IsMissionComplete == false and CheckMotion(idx, STATE_STAND) then
				if bMoveCircleSlot[i] == false then
					if GetDistanceFromCircle(idx,(i-1)) < 700 then
						bMoveCircleSlot[i] = true;
						SetbCollisionCircle( (i-1), true );
						RemoveCircle(i-1);
						PlaySound('sound/KillCountUp.wav');
					end
				end
			end
		else
			-- �ѱ��� �뽬�� ����
			if g_IsMissionComplete == false then
				if CheckMotion(idx, STATE_DASH) or CheckMotion(idx, STATE_STAND) then
					if bMoveCircleSlot[i] == false then
						if GetDistanceFromCircle(idx,(i-1)) < 700 then
							bMoveCircleSlot[i] = true;
							SetbCollisionCircle( (i-1), true );
							RemoveCircle(i-1);
							PlaySound('sound/KillCountUp.wav');
						end
					end
				end
			end
		end
	end
	
	if g_IsMissionComplete == false then
		if CheckMissionComplete() then			
			g_IsMissionComplete = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
			bMoveCircleSlot[1] = false;
			bMoveCircleSlot[2] = false;
			bMoveCircleSlot[3] = false;
			bMoveCircleSlot[4] = false;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			EnableKey(false);
			InputPlayerKey(false, 0, 0);
		end
	end
	
	-- 2��° �޸��� Ʃ�丮�� ���� ����
	if g_IsMissionComplete then
		g_IsMissionCompleteView = true;		
		
		if g_StateTime > 2300 then
			
			SendTutorialComplete(1)
			
			if IsKoreanLanguage() == false then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
			
				SetbCollisionCircle(0, false);
				SetbCollisionCircle(1, false);
				SetbCollisionCircle(2, false);
				SetbCollisionCircle(3, false);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				g_StateTime = 0;
				
				tCurChapterMissionStr[3] = STRING_TUTORIAL_3
				HideTutorialAllParents();
				ShowSpeakerMan();
				ShowChapterTitle(1);
				g_bVisibleTalkBG = true;
				
				ChangeState(idx, "DashCheck");		
				ShowSpeekerManMent()
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);	
			else
			
				-- ������ Ÿ�� Ʃ�丮��� ����			
				if WndPractice_IsCompensitionRemained() == 0 then
					winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
					
					SetbCollisionCircle(0, false);
					SetbCollisionCircle(1, false);
					SetbCollisionCircle(2, false);
					SetbCollisionCircle(3, false);
					g_IsMissionComplete = false;
					g_IsMissionCompleteView = false;
					g_StateTime = 0;
					
					SettingTutorialCharacter(1, false, 1000);
					
					g_TitleSeq = 2;
					HideTutorialAllParents();
					ShowSpeakerMan();
					ShowChapterTitle(g_TitleSeq);
					g_bVisibleTalkBG = true;
					ChangeState(idx, "GlobalPlayer");
					ChangeState(1, "Round");
					
					ShowSpeekerManMent();
					winMgr:getWindow('AdditionHelp'):clearActiveController();
					winMgr:getWindow('AdditionHelp'):setVisible(false);
				end
			end
		end
		
		MissionCompleteMoveProcess(0);		
	end
end


function CMoveCheckState_OnExit(idx)
end





--------------------------------------

-- 2��° �޸��� Ʃ�丮��

--------------------------------------
function CDashCheckState_OnEnter(idx)
	ResetCircle();
end

function CDashCheckState_Update(idx)
	if CheckMotion(idx, STATE_DASH) then	-- ���� ���°� ���� �ִ��� Ȯ�� �Ѵ�.
			for i=1, #bMoveCircleSlot do
			if g_IsMissionComplete == false then
				if bMoveCircleSlot[i] == false then
					if GetDistanceFromCircle(idx,(i-1)) < 700 then
						SetbCollisionCircle( (i-1), true );
						RemoveCircle(i-1);
						bMoveCircleSlot[i] = true;
						PlaySound('sound/KillCountUp.wav');
					end
				end
			end
		end
	end
	
	if g_IsMissionComplete == false then
		if CheckMissionComplete() then
		
			bMoveCircleSlot[1] = false;
			bMoveCircleSlot[2] = false;
			bMoveCircleSlot[3] = false;
			bMoveCircleSlot[4] = false;
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			EnableKey(false);
			InputPlayerKey(false, 0, 0)
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	-- 3��° Ÿ�� Ʃ�丮�� ���� �̸� ����
	if g_IsMissionComplete then		
		g_IsMissionCompleteView = true;		
		if g_StateTime > 2300 then
			SendTutorialComplete(1)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				SettingTutorialCharacter(1, false, 1000);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				g_TitleSeq = 2;
				HideTutorialAllParents();
				ShowSpeakerMan();
				ShowChapterTitle(g_TitleSeq);
				g_bVisibleTalkBG = true;
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "Round");
				
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end
		end		
		MissionCompleteMoveProcess(0); -- �̼� ����ƽ �̹��� ������ 		
	end
end

function CDashCheckState_OnExit(idx)
end





-------------------------------------------

-- 3��° Ÿ�� Ʃ�丮��

-------------------------------------------
function CAttackCheckState_OnEnter(idx)
	SetAtkPercent(250);
end

function CAttackCheckState_Update(idx)
	
	if g_IsMissionComplete == false then
		if GetPlayerHP(1) == 0 then
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	
	-- 4��° ��� Ʃ�丮�� ���� �̸�����
	if g_IsMissionComplete then
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		g_IsMissionCompleteView = true;
		
		if g_StateTime > 3400 then
			SendTutorialComplete(2)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				SettingTutorialCharacter(1, false, 1000);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				g_TitleSeq = 3;
				HideTutorialAllParents();
				ShowSpeakerMan();
				ShowChapterTitle(g_TitleSeq);
				g_bVisibleTalkBG = true;
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "Round");
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end
		end		
		MissionCompleteMoveProcess(1000);
		
	end
end

function CAttackCheckState_OnExit(idx)
	SetAtkPercent(100);
end





--------------------------------------

-- 4��° ��� Ʃ�丮��

--------------------------------------
function CGrabCheckState_OnEnter(idx)
	SetAtkPercent(230);
end

function CGrabCheckState_Update(idx)
	if CheckActionName(0, 'C_�������ֱ�_������') 
	   or CheckActionName(0, 'C_�������ֱ�_������1') 
	   or CheckActionName(0, 'C_�������ֱ�_������2') 
	   or CheckActionName(0, 'C_�������ֱ�_������3')
	   
	   or CheckActionName(0, 'grip_attk_griping') 
	   or CheckActionName(0, 'grip_attk_griping1') 
	   or CheckActionName(0, 'grip_attk_griping2') 
	   or CheckActionName(0, 'grip_attk_griping3') then
		SettingKeysEnable(false, false, false,   false, true, true, false);
	else
		SettingKeysEnable(false, false, false,   false, true, false, false);
	end
	if g_IsMissionComplete == false then
		if GetPlayerHP(1) == 0 then
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	-- 5��° ȸ�� Ʃ�丮�� ���� �̸� ����
	if g_IsMissionComplete then
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		g_IsMissionCompleteView = true;
		
		if g_StateTime > 3400 then
			SendTutorialComplete(3)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				SettingTutorialCharacter(1, false, 3000);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				g_TitleSeq = 4;
				HideTutorialAllParents();
				ShowSpeakerMan();
				ShowChapterTitle(g_TitleSeq);
				g_bVisibleTalkBG = true;
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "Round");
				SetAtkPercent(100);
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end			
		end
		
		MissionCompleteMoveProcess(1000);
	end
end

function CGrabCheckState_OnExit(idx)
	SetAtkPercent(100);
end





--------------------------------------

-- 5��° ȸ�� Ʃ�丮��

--------------------------------------
function CEvadeCheckState_OnEnter(idx)
	SetEvadeCount(0);
end


g_FrameCount = 0;
g_EvadeSuccess = false;
g_EvadeCount = 0;
function CEvadeCheckState_Update(idx)

	if CheckActionName(0, 'evade_roll') or CheckActionName(0, 'evade_back') then
		g_EvadeSuccess = true;
	end	
	
	g_EvadeCount = GetEvadeCount();
	
	if g_EvadeSuccess then
		if CheckBehavior(0, STATE_SPECIAL) or CheckBehavior(0, STATE_GRAB) then	-- ���� ��� ȸ�� ��������(�� ������ üũ�ϹǷ�)					
		else	-- �ѹ� ����	ȸ�� ���°� ��������
			g_EvadeCount = g_EvadeCount + 1;
			g_EvadeSuccess = false;
		end
	end
	
	
	if g_IsMissionComplete == false then
		if g_EvadeCount >= 2 then
			g_IsMissionComplete = true;
			g_EvadeSuccess = false;
			g_EvadeCount = 0;
			ChangeState(1, "Round");
			ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	-- 6��° �ʻ�� Ʃ�丮���� �̸� ����
	if g_IsMissionComplete then
		g_IsMissionCompleteView = true;
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		
		if g_StateTime > 3400 then
			SendTutorialComplete(4)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				SettingTutorialCharacter(1, false, 10000);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				g_TitleSeq = 5;
				HideTutorialAllParents();
				ShowSpeakerMan();
				ShowChapterTitle(g_TitleSeq);
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "Round");
				ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
				g_bVisibleTalkBG = true;
				g_EvadeSuccess = false;
				g_EvadeCount = 0;
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end
		end
		
		MissionCompleteMoveProcess(1000);
	end
end

function CEvadeCheckState_OnExit(idx)
end




---------------------------------------

-- 6��° �ʻ�� Ʃ�丮��

---------------------------------------
function CSpecialCheckState_OnEnter(idx)
end

function CSpecialCheckState_Update(idx)
	RecoverSP(idx);
	if g_IsMissionComplete == false then
		if GetPlayerHP(1) == 0 then
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	-- 7��° ������� Ʃ�丮���� �̸�����
	if IsKoreanLanguage() == false then
		if g_IsMissionComplete then
			EnableKey(false);
			InputPlayerKey(false, 0, 0);
			g_IsMissionCompleteView = true;
			
			if g_StateTime > 3400 then		
				SendTutorialComplete(5)
				if WndPractice_IsCompensitionRemained() == 0 then
					winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
					SettingTutorialCharacter(3, false, 1000);
					g_IsMissionComplete = false;
					g_IsMissionCompleteView = false;
					
					HideTutorialAllParents();
					ShowSpeakerMan();
					g_TitleSeq = 6;
					ChangeState(idx, "GlobalPlayer");
					ChangeState(1, "OnlyStand");
					ChangeState(2, "OnlyStand");
					ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
					g_bVisibleTalkBG = true;
					ShowChapterTitle(g_TitleSeq);
					ShowSpeekerManMent();
					winMgr:getWindow('AdditionHelp'):clearActiveController();
					winMgr:getWindow('AdditionHelp'):setVisible(false);
				end
			end		
			MissionCompleteMoveProcess(1000);
		end
	else
		-- 9��° �������� ������ ������ �̸�����
		if g_IsMissionComplete then
			EnableKey(false);
			InputPlayerKey(false, 0, 0);
			g_IsMissionCompleteView = true;
			
			if g_StateTime > 3400 then
				SendTutorialComplete(7)
				if WndPractice_IsCompensitionRemained() == 0 then
					winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
					g_IsMissionComplete = false;
					g_IsMissionCompleteView = false;
					
					HideTutorialAllParents();
					ShowSpeakerMan();
					g_TitleSeq = 8;
					SettingTutorialCharacter(1, false, 1000);
					ChangeState(idx, "GlobalPlayer");
					ChangeState(1, "OnlyStand");
					ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
					g_bVisibleTalkBG = true;
					ShowChapterTitle(g_TitleSeq);
					
					g_tCurMentString = g_tTalkTable[10];
					ShowSpeekerManMent();
					winMgr:getWindow('AdditionHelp'):clearActiveController();
					winMgr:getWindow('AdditionHelp'):setVisible(false);
				end
			end
			
			MissionCompleteMoveProcess(1000);
		end
	end
	
end

function CSpecialCheckState_OnExit(idx)
end






--------------------------------------------------

-- 7��° ������� Ʃ�丮��

--------------------------------------------------
function CPlayerDoubleAttackCheckState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'DoubleAttackCheck';
	g_DoubleAttackCheckStart = true;
	SetAtkPercent(400);
end

function CPlayerDoubleAttackCheckState_Update(idx)
	
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	if CheckMotion(1, STATE_LAND) or CheckMotion(2, STATE_LAND) then
		g_DoubleAttackCheckStart = true;
		CharOn(1);	CharOn(2);
	end
	
	if g_DoubleAttackCheckStart then
		if  CheckMotion(0, STATE_STAND) and CheckMotion(1, STATE_STAND) and 
			CheckMotion(2, STATE_STAND) and CheckActionName(0, 'stand') and 
			CheckActionName(1, 'stand') and CheckActionName(2, 'stand') then
			
			g_DoubleAttackCheckStart = false;			
			g_AttackPosSeq = g_AttackPosSeq % 4;
			SettingDoubleAttackPosition(g_AttackPosSeq+1);
			g_AttackPosSeq = g_AttackPosSeq + 1;
		end
	end
	
	if g_IsMissionComplete == false then
		
		if GetPlayerHP(1) <= 0 or GetPlayerHP(2) <= 0 then
			if IsDoubleAttack() then
				g_IsMissionComplete = true;
				g_StateTime = 0;
				g_IsPlayMissionSound = true;				
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
			else
				g_AttackPosSeq = (g_AttackPosSeq%4 + 1);
				g_DoubleAttackCheckStart = false;
			end
		end
	end
	
	-- 8��° ������ Ʃ�丮���� �̸�����
	if g_IsMissionComplete then
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		g_IsMissionCompleteView = true;
		
		if g_StateTime > 3400 then
			SendTutorialComplete(6)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				SettingTutorialCharacter(2, false, 1000);	
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				HideTutorialAllParents();
				ShowSpeakerMan();
				g_TitleSeq = 7;
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "OnlyStand");
				ChangeState(2, "OnlyStand");
				ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
				g_bVisibleTalkBG = true;
				ShowChapterTitle(g_TitleSeq);
				
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end			
		end
		
		MissionCompleteMoveProcess(1000);
	end
end

function CPlayerDoubleAttackCheckState_OnExit(idx)
end





------------------------------------------

-- 8��° ������ Ʃ�丮��

------------------------------------------
function CTeamAttackCheckState_OnEnter(idx)
	SetAtkPercent(100);
end

function CTeamAttackCheckState_Update(idx)
	if g_IsMissionComplete == false then
		
		if GetPlayerHP(1) <= 0 or GetPlayerHP(2) <= 0 then
			if IsTeamAttack() then
				g_IsMissionComplete = true;
				g_StateTime = 0;
				g_IsPlayMissionSound = true;
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
			else
				g_DoubleAttackCheckStart = false
			end
		end
	end
	
	-- 9��° �������� ������ ������ �̸�����
	if g_IsMissionComplete then
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		g_IsMissionCompleteView = true;
		
		if g_StateTime > 3400 then
			SendTutorialComplete(7)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				HideTutorialAllParents();
				ShowSpeakerMan();
				g_TitleSeq = 8;
				SettingTutorialCharacter(1, false, 1000);
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "OnlyStand");
				g_bVisibleTalkBG = true;
				ShowChapterTitle(g_TitleSeq);
				
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
			end
		end
		
		MissionCompleteMoveProcess(1000);
	end
end

function CTeamAttackCheckState_OnExit(idx)
end




------------------------------------------

-- 9��° �������� ������ ����

------------------------------------------
function CItemUseCheckState_OnEnter(idx)
	SetAtkPercent(100);
end

function CItemUseCheckState_Update(idx)
	if g_IsMissionComplete == false then
		if GetPlayerHP(1) == 0 then
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	if IsKoreanLanguage() == false then
		
		-- 10��° ������ ���� ������ �̸�����
		if g_IsMissionComplete then
			EnableKey(false);
			InputPlayerKey(false, 0, 0);
			g_IsMissionCompleteView = true;
			
			if g_StateTime > 3400 then
				SendTutorialComplete(8)
				if WndPractice_IsCompensitionRemained() == 0 then
					winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
					g_IsMissionComplete = false;
					g_IsMissionCompleteView = false;
					
					g_TitleSeq = 9;
					HideTutorialAllParents();
					ShowSpeakerMan();
					ShowChapterTitle(g_TitleSeq);
					g_bVisibleTalkBG = true;
					SettingTutorialCharacter(1, true, 2000);	-- ������ ���� ������ �����ϴ� ���̹Ƿ� true
					ChangeState(idx, "GlobalPlayer");
					ChangeState(1, "Round");
					ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
					
					ShowSpeekerManMent();
					winMgr:getWindow('AdditionHelp'):clearActiveController();
					winMgr:getWindow('AdditionHelp'):setVisible(false);
				end		
			end		
			MissionCompleteMoveProcess(1000);
		end
	else
		if g_IsMissionComplete then
			EnableKey(false);
			InputPlayerKey(false, 0, 0);
			g_IsMissionCompleteView = true;
			
			-- ���̻� ������ϰ� ����
			if g_StateTime > 3400 then
				SendTutorialComplete(9)
				if WndPractice_IsCompensitionRemained() == 0 then
					winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
					g_IsMissionComplete = false;
					g_IsMissionCompleteView = false;
					
					HideTutorialAllParents();
					ShowSpeakerMan();
					g_MissionAllClear = true;
					g_bVisibleTalkBG = true;
					SettingTutorialCharacter(1, false, 1500);
					ChangeState(idx, "GlobalPlayer");
					ChangeState(1, "OnlyStand");
					ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
					
					g_tCurMentString = g_tTalkTable[12];
					ShowSpeekerManMent();
					winMgr:getWindow('AdditionHelp'):clearActiveController();
					winMgr:getWindow('AdditionHelp'):setVisible(false);
					
					DestroyAllWeapon()		-- ������ ���ش�.
				end
			end		
			MissionCompleteMoveProcess(1000);
		end
	end
end

function CItemUseCheckState_OnExit(idx)
end




------------------------------------------

-- 10��° ������ ���� ����

------------------------------------------
function CNoItemWeaponUseCheckState_OnEnter(idx)
	SetAtkPercent(100);
end

function CNoItemWeaponUseCheckState_Update(idx)
	if g_IsMissionComplete == false then
		if GetPlayerHP(1) == 0 then
			g_IsMissionComplete = true;
			g_StateTime = 0;
			g_IsPlayMissionSound = true;
			winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(true);
		end
	end
	
	if g_IsMissionComplete then
		EnableKey(false);
		InputPlayerKey(false, 0, 0);
		g_IsMissionCompleteView = true;
		
		-- ���̻� ������ϰ� ����
		if g_StateTime > 3400 then
			SendTutorialComplete(9)
			if WndPractice_IsCompensitionRemained() == 0 then
				winMgr:getWindow('sj_practice_missionSuccessTitle'):setVisible(false);
				g_IsMissionComplete = false;
				g_IsMissionCompleteView = false;
				
				HideTutorialAllParents();
				ShowSpeakerMan();
				g_MissionAllClear = true;
				g_bVisibleTalkBG = true;
				SettingTutorialCharacter(1, false, 1500);
				ChangeState(idx, "GlobalPlayer");
				ChangeState(1, "OnlyStand");
				ShowSpeekerManMent();
				winMgr:getWindow('AdditionHelp'):clearActiveController();
				winMgr:getWindow('AdditionHelp'):setVisible(false);
				
				DestroyAllWeapon()		-- ������ ���ش�.
			end
		end		
		MissionCompleteMoveProcess(1000);
	end
end

function CNoItemWeaponUseCheckState_OnExit(idx)
end





--------------------------------------------------------------------

-- �ΰ����� ���� ����

--------------------------------------------------------------------
g_PlayerRadius = 870+380+280;
tPlayerType = {['protecterr'] = 0, 0, 0, 0, 0}
AI_TYPE_DEFAULT		= 0;
AI_TYPE_ATTACKER	= 1;	-- ��� �Ͼ� �ٴϸ鼭 ������ ������ ��⳪ ������ �Ѵ�. ��⸦ �ξ� ���� �Ѵ�.

function GetPlayerType(idx)
	return tPlayerType[idx+1];
end

function ChangeAIPlayerType(idx, type)
	tPlayerType[idx+1] = type;
end

function GetPlayerX(idx)
	return g_PlayerX[idx+1];
end

function GetPlayerY(idx)
	return g_PlayerY[idx+1];
end

g_PlayerX		= { ['protecterr'] = 0,    0, 0, 0, 0 }
g_PlayerY		= { ['protecterr'] = 0,    0, 0, 0, 0 }
g_StateFrame	= { ['protecterr'] = 0,    0, 0, 0, 0 }
g_PChaseCount	= { ['protecterr'] = 0,    0, 0, 0, 0 }
g_StateStr		= { ['protecterr'] = 0,    'none', 'none', 'none', 'none' }


--------------------------------------
-- CRoundState ���� ��� ����
--------------------------------------
function CRoundState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'Round';
	local type = GetPlayerType(idx);
	if type == AI_TYPE_DEFAULT then
		--InputKey(idx, 1, true, 'NOKEY', 0);	-- �̷��� �ؾ� �ƹ��͵� �ȴ����� ���°� �ȴ�.
	elseif type == AI_TYPE_ATTACKER then
		--InputKey(idx, 1, true, 'NOKEY', 0);	-- �̷��� �ؾ� �ƹ��͵� �ȴ����� ���°� �ȴ�.
	end
end


function CRoundState_Update(idx)	
	local type = GetPlayerType(idx);
	local cur_my_dir = GetCurPlayerDir(idx);
	local mytarget_dir = GetPlayerDir(idx, 0); -- from - to Dir�� ���Ѵ�.
	
	if cur_my_dir == mytarget_dir then
		InputKey(idx, 1, true, 'NOKEY', 0);
	else
		InputKey(idx, 1, true, 'NOKEY', mytarget_dir);
	end
	
	
	if type == AI_TYPE_DEFAULT then		
		if CheckMotion(idx, STATE_LAND) then	-- ���� ���°� ���� �ִ��� Ȯ�� �Ѵ�.
			Input(idx, "KEY_D");
		end
	elseif type == AI_TYPE_ATTACKER then
		if GetPlayerDistance(idx, 0) > g_PlayerRadius then	-- �浹 ������ ���� ũ�� �Ͼ� ����.
			ChangeState(idx, "Chase");
		else	-- ������ ������ ���� �Ѵ�.
			ChangeState(idx, "Attack");
		end
	end	
end


function CRoundState_OnExit(idx)
	local type = GetPlayerType(idx);
	if type == AI_TYPE_DEFAULT then
	elseif type == AI_TYPE_ATTACKER then
	end
end


--------------------------------------
-- CChaseState ���� ��� ����
--------------------------------------
function CChaseState_OnEnter(idx)
	local type = GetPlayerType(idx);
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'Chase';
	if type == AI_TYPE_DEFAULT then
	elseif type == AI_TYPE_ATTACKER then
	end
end


function CChaseState_Update(idx)
	local dir = GetPlayerDir(idx, 0);
	local type = GetPlayerType(idx);
	if type == AI_TYPE_DEFAULT then
	elseif type == AI_TYPE_ATTACKER then
		if GetPlayerDistance(idx, 0) > g_PlayerRadius then
			InputDirKey(idx, dir); -- ��� �÷��̾ �Ͼư��� �ٶ󺸰� �����.
		else
			ChangeState(idx, 'Attack');
			InputKey(idx, 1, true, 'NOKEY', 0);	-- �̷��� �ؾ� �ƹ��͵� �ȴ����� ���°� �ȴ�.
			--ChangeState(idx, "Round");
		end
	end
end

function CChaseState_OnExit(idx)
end



--------------------------------------
-- Attack ���� ��� ����
--------------------------------------
g_AttackCount = 0;

function CAttackState_OnEnter(idx)
	local type = GetPlayerType(idx);
	if type == AI_TYPE_DEFAULT then
	elseif type == AI_TYPE_ATTACKER then
	end
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'Attack';
	g_AttackCount = 0;
end


function CAttackState_Update(idx)
	local type = GetPlayerType(idx);
	if type == AI_TYPE_DEFAULT then
		
	elseif type == AI_TYPE_ATTACKER then
		InputKey(idx, 20, true, 'KEY_D', 0);
	end
end


function CAttackState_OnExit(idx)
local type = GetPlayerType(idx);
end



--------------------------------------
-- OnlyMove ���� ��� ����
--------------------------------------
function SetOnlyMovePos(idx, xx, yy)
	g_OnlyMoveTargetPosX[idx+1] = xx;	g_OnlyMoveTargetPosY[idx+1] = yy;
end

g_OnlyMoveTargetPosX = {['protecterr']=0, 0, 0, 0, 0, 0}
g_OnlyMoveTargetPosY = {['protecterr']=0, 0, 0, 0, 0, 0}

function COnlyMoveState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'OnlyMove';
	CharOn(1);	CharOn(2);
end

function COnlyMoveState_Update(idx)
	if GetTargetPosDistance(idx, g_OnlyMoveTargetPosX[idx+1], g_OnlyMoveTargetPosY[idx+1]) < 500 then
		InputKey(idx, 1, true, 'NOKEY', 0);
		ChangeState(idx, "Round");
	else
		InputKey( idx, 1, true, 'NOKEY', GetTargetPosDir(idx, g_OnlyMoveTargetPosX[idx+1], g_OnlyMoveTargetPosY[idx+1]) );
	end
end

function COnlyMoveState_OnExit(idx)
	CharOff(1);
	CharOff(2);
end

---------------------------------------
-- OnlyStand ���� ��� ����
---------------------------------------
function COnlyStandState_OnEnter(idx)
end

function COnlyStandState_Update(idx)
end

function COnlyStandState_OnExit(idx)
end


----------------------------------------------
-- TeamAttackAssist ���� ��� ����
----------------------------------------------
function CTeamAttackAssistState_OnEnter(idx)
end

function CTeamAttackAssistState_Update(idx)	
	if CheckBehavior(2, STATE_GRABED) then		
	else
		if GetPlayerDistance(idx, 2) < g_PlayerRadius then
			--if CheckMotion(2, STATE_STAND) and CheckBehavior(2, STATE_NORMAL) and CheckActionName(2, 'stand') then
			if CheckMotion(2, STATE_STAND) and CheckActionName(2, 'stand') then
				InputKey(idx, 1, true, 'KEY_S', 0);
			else
				InputKey(idx, 1, false, 'NOKEY', 0);
			end
		else	-- �ָ������� �Ͼư���.
			local cur_my_dir = GetCurPlayerDir(idx);
			local mytarget_dir = GetPlayerDir(idx, 2); -- from - to Dir�� ���Ѵ�.
			InputKey(idx, 1, true, 'NOKEY', mytarget_dir);
		end
	end
end

function CTeamAttackAssistState_OnExit(idx)
end


----------------------------------------------
-- TeamAttackStruck ���� ��� ����
----------------------------------------------
function CTeamAttackStruckState_OnEnter(idx)
end

function CTeamAttackStruckState_Update(idx)
	if CheckMotion(idx, STATE_LAND) then	-- ���� ���°� ���� �ִ��� Ȯ�� �Ѵ�.
		Input(idx, "KEY_D");
	end
end

function CTeamAttackStruckState_OnExit(idx)
end



function GetDirString(dir)
	local rstr = 'PLAYER_DIR_NONE';
	if dir == PLAYER_DIR_NONE then
		rstr = 'PLAYER_DIR_NONE';
	elseif dir == PLAYER_DIR_LEFT_UP then
		rstr = 'PLAYER_DIR_LEFT_UP';
	elseif dir == PLAYER_DIR_LEFT_DOWN then
		rstr = 'PLAYER_DIR_LEFT_DOWN';
	elseif dir == PLAYER_DIR_RIGHT_UP then
		rstr = 'PLAYER_DIR_RIGHT_UP';
	elseif dir == PLAYER_DIR_RIGHT_DOWN then
		rstr = 'PLAYER_DIR_RIGHT_DOWN';
	elseif dir == PLAYER_DIR_LEFT then
		rstr = 'PLAYER_DIR_LEFT';
	elseif dir == PLAYER_DIR_RIGHT then
		rstr = 'PLAYER_DIR_RIGHT';
	elseif dir == PLAYER_DIR_UP then
		rstr = 'PLAYER_DIR_UP';
	elseif dir == PLAYER_DIR_DOWN then
		rstr = 'PLAYER_DIR_DOWN';
	end	
	return rstr;
end


function RecoverSP(idx)
	local sp = GetPlayerSP(idx);
	local max_sp = GetPlayerMaxSP(idx);
	if sp < max_sp then
		if sp+20 > max_sp then
			SetPlayerSP(idx, max_sp);
		else
			SetPlayerSP(idx, sp+20);
		end
	end
end







------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---										   ���� ���	    							     ---
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------



--------------------------------------
-- PPlayer ���� ��� ����
--------------------------------------
function CPPlayerState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PPlayer';
	SetAtkPercent(100);
end

function CPPlayerState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	RecoverSP(idx);
end

function CPPlayerState_OnExit(idx)
end


--------------------------------------
-- PStand ���� ��� ����
--------------------------------------
function CPStandState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_PChaseCount[idx+1] = 0;
	g_StateStr[idx+1] = 'PStand';
	InputKey(idx, 1, false, 'NOKEY', 0);
end

function CPStandState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	if CheckMotion(idx, STATE_LAND) then	-- ���� ���°� ���� �ִ��� Ȯ�� �Ѵ�.
		Input(idx, "KEY_D");
	end
	
	local type = GetPlayerType(idx);
	local cur_my_dir = GetCurPlayerDir(idx);
	local mytarget_dir = GetPlayerDir(idx, 0); -- from - to Dir�� ���Ѵ�.
	
	if cur_my_dir == mytarget_dir then
		InputKey(idx, 1, true, 'NOKEY', 0);
	else
		--[[
		if g_StateFrame[idx+1]%58 == 1 then
			if g_PChaseCount[idx+1] < 3 then
				InputKey(idx, 1, true, 'NOKEY', mytarget_dir); -- 3�� �̻� ���ϰ� �Ѵ�.
				
			end
			g_PChaseCount[idx+1] = g_PChaseCount[idx+1] + 1;
		else
			InputKey(idx, 1, true, 'NOKEY', 0);
		end
		]]--
	end
	
	-- off�� ������ �Ǿ� ������
	if g_Appointment_1Off then
		if CheckMotion(1, STATE_STAND) and CheckBehavior(1, STATE_NORMAL) and CheckActionName(1, 'stand') and CheckActionName(0, 'stand') then
			g_Appointment_1Off = false;
			InputKey(idx, 1, false, 'NOKEY', 0);
			CharOff(1);	-- ������ ��Ų��.
			-- UI�� ��Ȱ��ȭ ��Ų��.
			winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'false');	
			winMgr:getWindow('sj_practice_practiceMode_speakerman1_evade'):setProperty('Selected', 'false');
			winMgr:getWindow('sj_practice_practiceMode_speakerman1_grab'):setProperty('Selected', 'false');	
			winMgr:getWindow('sj_practice_practiceMode_speakerman1_attack'):setProperty('Selected', 'false');
		end
	end
	
	if g_Appointment_2Off then
		if CheckMotion(2, STATE_STAND) and CheckBehavior(2, STATE_NORMAL) and CheckActionName(2, 'stand') then
			g_Appointment_2Off = false;
			InputKey(idx, 2, false, 'NOKEY', 0);
			CharOff(2);	-- ������ ��Ų��.
			-- UI�� ��Ȱ��ȭ ��Ų��.
			winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'false');
			winMgr:getWindow('sj_practice_practiceMode_speakerman2_evade'):setProperty('Selected', 'false');
			winMgr:getWindow('sj_practice_practiceMode_speakerman2_grab'):setProperty('Selected', 'false');
			winMgr:getWindow('sj_practice_practiceMode_speakerman2_attack'):setProperty('Selected', 'false');
		end
	end
end


function CPStandState_OnExit(idx)
end



--------------------------------------
-- PEvade ���� ��� ����
--------------------------------------
function CPEvadeState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PEvade';
end

function CPEvadeState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	--InputKey(idx, 2, true, 'KEY_A', GetPlayerDir(idx, 0));
	InputKey(idx, 2, true, 'KEY_A', GetRandomDir());
end

function CPEvadeState_OnExit(idx)
	InputKey(idx, 2, false, 'NOKEY', 0);
end


--------------------------------------
-- PGrab ���� ��� ����
--------------------------------------
function CPGrabState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PGrab';
end

function CPGrabState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	InputKey(idx, 2, true, 'KEY_S', 0); --GetPlayerDir(idx, 0));
end

function CPGrabState_OnExit(idx)
	InputKey(idx, 2, false, 'NOKEY', 0);
end


--------------------------------------
-- PAttack ���� ��� ����
--------------------------------------
function CPAttackState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PAttack';
end

function CPAttackState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	InputKey(idx, 2, true, 'KEY_D', 0);
end

function CPAttackState_OnExit(idx)
	InputKey(idx, 2, false, 'NOKEY', 0);
end




---------------------- �׽�Ʈ�� ����Ŀ��2 �ΰ����� ------------------------
----------------------------------------
-- PP2Global ���� ��� ����
----------------------------------------
function CPP2GlobalState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PP2Global';
end

function CPP2GlobalState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	InputKey(idx, 2, true, 'KEY_D', 0);
end

function CPP2GlobalState_OnExit(idx)
	InputKey(idx, 2, false, 'NOKEY', 0);
end



--------------------------------------
-- PP2Chase ���� ��� ����
--------------------------------------
function CPP2ChaseState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PP2Chase';
end


function CPP2ChaseState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	
	local cur_my_dir = GetCurPlayerDir(idx);
	local mytarget_dir = GetPlayerDir(idx, 0);
	
	if g_SelectedType_S2 == SELECTED_STAND then
	elseif g_SelectedType_S2 == SELECTED_EVADE then
		InputDirKey(idx, mytarget_dir); -- ��� �÷��̾ �Ͼư��� �ٶ󺸰� �����.
		if GetPlayerDistance(idx, 0) < g_PlayerRadius then
			ChangeState(idx, 'PP2Attack');
		end
	elseif g_SelectedType_S2 == SELECTED_GRAB then
		InputDirKey(idx, mytarget_dir); -- ��� �÷��̾ �Ͼư��� �ٶ󺸰� �����.
		if GetPlayerDistance(idx, 0) < g_PlayerRadius then
			ChangeState(idx, 'PP2Attack');
		end
	elseif g_SelectedType_S2 == SELECTED_ATTACK then
		InputDirKey(idx, mytarget_dir); -- ��� �÷��̾ �Ͼư��� �ٶ󺸰� �����.
		if GetPlayerDistance(idx, 0) < g_PlayerRadius then
			ChangeState(idx, 'PP2Attack');
		end
	end
end

function CPP2ChaseState_OnExit(idx)
	--InputKey(idx, 2, false, 'NOKEY', 0);
end


---------------------------------------
-- PP2Attack ���� ��� ����
---------------------------------------
function CPP2AttackState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PP2Attack';
end


function CPP2AttackState_Update(idx)	
	if g_StateFrame[idx+1] < 3 then	-- �ι游 ������.
		if g_SelectedType_S2 == SELECTED_STAND then
		elseif g_SelectedType_S2 == SELECTED_EVADE then
			InputKey(idx, 1, true, 'KEY_A', GetRandomDir());
		elseif g_SelectedType_S2 == SELECTED_GRAB then
			if CheckMotion(0, STATE_LAND) then
				--InputKey(idx, 1, false, 'NOKEY', 0);
			else
				InputKey(idx, 1, true, 'KEY_S', GetRandomDir());
			end
		elseif g_SelectedType_S2 == SELECTED_ATTACK then
			InputKey(idx, 1, true, 'KEY_D', 0);
		end
		
		--g_AttackCount = g_AttackCount + 1;
	else  -- �ι� ������ ���� �÷��̾��� ������ ��ȸ�Ѵ�.
		if g_SelectedType_S2 == SELECTED_GRAB then
			if CheckActionName(0, 'lie_down') or CheckMotion(0, STATE_LAND) then
				InputKey(idx, 1, false, 'NOKEY', 0);
			else
				ChangeState(idx, 'PP2RandomRound');	
			end
		else
			ChangeState(idx, 'PP2RandomRound');
		end
	end
	
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	
	--[[
	if g_AttackCount < 3 then			
	else
		local cur_my_dir = GetCurPlayerDir(idx);
		local mytarget_dir = GetPlayerDir(idx, 0); -- from - to Dir�� ���Ѵ�.
		if cur_my_dir == mytarget_dir then	-- ���� �ٶ󺸴� ��ġ�� �÷��̾ �ٶ󺸰� �ִٸ� ������ �ִ´�.
			InputKey(idx, 20, true, 'NOKEY', 0);
		else	-- ���� �ٶ󺸴� ��ġ�� �÷��̾ �ٶ󺸰� ���� �ʴٸ� �ٶ󺸰� �Ѵ�.
			if g_AttackCount%5 == 0 then
				--InputKey(idx, 1, true, 'NOKEY', mytarget_dir);
			end
		end
	end
	if g_AttackCount > 60 then
		g_AttackCount = 0;
	end
		
	g_AttackCount = g_AttackCount + 1;
	else
		if GetPlayerDistance(idx, 0) > (g_PlayerRadius+300) then
			ChangeState(idx, 'Chase');
		end
	end
	]]--
end


function CPP2AttackState_OnExit(idx)
end



---------------------------------------------
-- PP2RandomRound ���� ��� ����
---------------------------------------------
g_PlayerRandomDir = 0;	-- AI�� �þ�� �迭�� ����� �ش�.

function CPP2RandomRoundState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PP2RandomRound';
	-- �÷��̾� ���� �������� �����Ѵ�.
	g_PlayerRandomDir = GetPlayerForwardRandomDir(idx,0); --GetPlayerDir(idx, 0);
end

function CPP2RandomRoundState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
	
	local local_x = GetPlayerX(idx);
	local local_y = GetPlayerY(idx);
	
	if local_x < 625 and local_x > -625 and local_y < 625 and local_y > -625 then
		if g_SelectedType_S2 == SELECTED_EVADE then
			local cur_my_dir = GetCurPlayerDir(idx);
			local mytarget_dir = GetPlayerDir(idx, 0); -- from - to Dir�� ���Ѵ�.
			if cur_my_dir == mytarget_dir then	-- ���� �ٶ󺸴� ��ġ�� �÷��̾ �ٶ󺸰� �ִٸ� ������ �ִ´�.
				--InputKey(idx, 1, false, 'NOKEY', 0);
				ChangeState(idx, 'PP2Chase');
			else	-- ���� �ٶ󺸴� ��ġ�� �÷��̾ �ٶ󺸰� ���� �ʴٸ� �ٶ󺸰� �Ѵ�.
				InputKey(idx, 1, true, 'NOKEY', mytarget_dir);
			end
		else
			if GetPlayerDistance(idx, 0) > (g_PlayerRadius-350) then
				ChangeState(idx, 'PP2Chase');
			else -- ���� �������� ��� ���� �Ѵ�.
				InputKey(idx, 1, true, 'NOKEY', g_PlayerRandomDir);
			end
		end
	else
		ChangeState(idx, 'PP2Chase');
	end
end

function CPP2RandomRoundState_OnExit(idx)
	--InputKey(idx, 1, false, 'NOKEY', 0);
end



------------------------------------------------
-- PP1TeamAssist ���� ��� ����
------------------------------------------------
function CPP1TeamAssistState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'PP1TeamAssist';
end

function CPP1TeamAssistState_Update(idx)
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;	
	if CheckBehavior(2, STATE_GRABED) then
		
	else
		if GetPlayerDistance(idx, 2) < g_PlayerRadius then
			if CheckMotion(2, STATE_STAND) and CheckBehavior(2, STATE_EVADE) and CheckActionName(2, 'stand') then
				InputKey(idx, 1, true, 'KEY_S', 0);
			else
				InputKey(idx, 1, false, 'NOKEY', 0);
			end
		else	-- �ָ������� �Ͼư���.
			local cur_my_dir = GetCurPlayerDir(idx);
			local mytarget_dir = GetPlayerDir(idx, 2); -- from - to Dir�� ���Ѵ�.
			InputKey(idx, 1, true, 'NOKEY', mytarget_dir);
		end
	end
end

function CPP1TeamAssistState_OnExit(idx)
end




g_DoubleAttackCheckStart = false;
------------------------------------------------
-- DoubleAttackCheck ���� ��� ����
------------------------------------------------
local g_delay_time = 0;

function CDoubleAttackCheckState_OnEnter(idx)
	g_StateFrame[idx+1] = 0;
	g_StateStr[idx+1] = 'DoubleAttackCheck';
	SetAtkPercent(500);
	g_delay_time = 2000;
	g_DoubleAttackCheckStart = false;
end

function CDoubleAttackCheckState_Update(idx)
	RecoverSP(idx);
	g_StateFrame[idx+1] = g_StateFrame[idx+1] + 1;
		
	-- �Ѵ� HP�� 0�̸� �ٽ� �����Ѵ�.
	if g_DoubleAttackCheckStart == false then
		local max_hp1 = GetPlayerMaxHP(1);
		local hp1 = GetPlayerHP(1);
		local max_hp2 = GetPlayerMaxHP(2);
		local hp2 = GetPlayerHP(2);
		
		if GetPlayerHP(1) == 0 or GetPlayerHP(2) == 0 then
			g_DoubleAttackCheckStart = true;
			g_StateTime = 0;
			delay_time = 2200;
			CharOn(1);	CharOn(2);
		elseif hp1 < max_hp1 or hp2 < max_hp2 then
			g_DoubleAttackCheckStart = true;
			g_StateTime = 0;
			delay_time = 2600;
			CharOn(1);	CharOn(2);
		end
		
		if CheckActionName(0, 'grip_attk_griping') then
			g_DoubleAttackCheckStart = true;
			g_StateTime = 0;
			delay_time = 2900;
			CharOn(1);	CharOn(2);
		end
	end
		
	if g_DoubleAttackCheckStart then -- ������� �ð� ���������� ������ �� �ְԲ��Ѵ�.
		if g_StateTime > delay_time then
			g_AttackPosSeq = (g_AttackPosSeq%4 + 1);
			GotoPracticeMode(3);
			g_DoubleAttackCheckStart = false;
			g_StateTime = 0;
		end
	end
end

function CDoubleAttackCheckState_OnExit(idx)
end


function SettingDoubleAttackPosition(dir)
	SetOnlyMovePos(1, g_DoubleAttackPosX[dir][2], g_DoubleAttackPosY[dir][2]);
	SetOnlyMovePos(2, g_DoubleAttackPosX[dir][3], g_DoubleAttackPosY[dir][3]);
	ChangeState(1, 'OnlyMove');
	ChangeState(2, 'OnlyMove');
end



g_AttackPosSeq = 1;

g_PlayerPracticeModePosX  = { ['protecterr'] = 0,    0,  2200,  4800,   0 }
g_PlayerPracticeModePosY  = { ['protecterr'] = 0,    0,  4000,  1800,   0 }
g_PlayerPracticeModeAngle = { ['protecterr'] = 0, -220,   120,   120,   0 }

g_PlayerPracticeComboPosX  = { ['protecterr'] = 0,    0,  2200,  4800,   0 }
g_PlayerPracticeComboPosY  = { ['protecterr'] = 0,    0,  4000,  1800,   0 }
g_PlayerPracticeComboAngle = { ['protecterr'] = 0, -220,   120,   120,   0 }


g_TeamAttackPosX  = { ['protecterr'] = 0,    0,  2000,  1700,   0 }
g_TeamAttackPosY  = { ['protecterr'] = 0,    0,  2500,  1100,   0 }
g_TeamAttackAngle = { ['protecterr'] = 0, -220,    50,   100,   0 }

g_DoubleAttackPosX  = { ['protecterr'] = 0, {['protecterr'] = 0,    0, -2800, -2800,   0}, {['protecterr'] = 0,    0,  -650,   720,   0}, {['protecterr'] = 0,    0,  2800,  2800,   0}, {['protecterr'] = 0,    0,  -630,   720,   0} }
g_DoubleAttackPosY  = { ['protecterr'] = 0, {['protecterr'] = 0,    0,  -430,   430,   0}, {['protecterr'] = 0,    0,  2800,  2800,   0}, {['protecterr'] = 0,    0,  -430,   430,   0}, {['protecterr'] = 0,    0, -2800, -2800,   0} }
g_DoubleAttackAngle = { ['protecterr'] = 0, {['protecterr'] = 0, -220,  -180,  -180,   0}, {['protecterr'] = 0, -220,     0,     0,   0}, {['protecterr'] = 0, -220,   180,   180,   0}, {['protecterr'] = 0, -220,     0,     0,   0} }


----------------------------------------------------------------------

-- !!!!!! ������� ��ư �̺�Ʈ !!!!!!

----------------------------------------------------------------------
function OnClickPracticeMode(args)
	
	EnableKey(true);
	g_PracticeScnState	= SCN_PRACTICE_MODE;
	
	HideTutorialAllParents();
	
	ShowPracticeModeUI(true);
	
	StartCreateCharacter();
	local HP = 6000
	--[[
	CreateCharacter(0, 'strike', 0, g_PlayerPracticeModePosX[1], g_PlayerPracticeModePosY[1], g_PlayerPracticeModeAngle[1], HP);
	CreateCharacter(1, 'strike', 1, g_PlayerPracticeModePosX[2], g_PlayerPracticeModePosY[2], g_PlayerPracticeModeAngle[2], HP);
	CreateCharacter(2, 'grab', 1, g_PlayerPracticeModePosX[3], g_PlayerPracticeModePosY[3], g_PlayerPracticeModeAngle[3], HP);
	--]]
	CreateCharacter(0, 'strike', 0, g_PlayerPracticeModePosX[1], g_PlayerPracticeModePosY[1], g_PlayerPracticeModeAngle[1], HP);
	CreateCharacter(1, 'strike', 1, g_PlayerPracticeModePosX[2], g_PlayerPracticeModePosY[2], g_PlayerPracticeModeAngle[2], HP);
	CreateCharacter(2, 'grab', 1, g_PlayerPracticeModePosX[3], g_PlayerPracticeModePosY[3], g_PlayerPracticeModeAngle[3], HP);
	EndCreateCharacter(false);
	
	ShowCollisionCircle(false);
	winMgr:getWindow('sj_practice_actionKey_backImage'):setVisible(false)	-- ó���� ���� �ȴ����ش�. ������ �������� �����ش�.
	ShowPracticeHelp(-1);
	winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(true)
	winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(true)
	winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(false)
	winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(false)
	winMgr:getWindow('sj_practice_basic_radioBtn'):setProperty('Selected', 'true');
	winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'true');
	winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'true');
	
	SettingKeysEnable(true, true, true,  true, true, true, true);
	
	
	-- �÷��̾�� NPC ���� �������ֱ�
	ChangeState(0, 'PPlayer');
	ChangeState(1, 'PStand');
	ChangeState(2, 'PStand');
	g_GogoProcess = true;

	g_ScnState = SCN_PRACTICE_MODE;
	CurrentScene(g_ScnState)
	
	--TestChangeState(bossGlobalState);
end



function GotoPracticeMode(args)
	if args == 1 then -- ǥ��
		StartCreateCharacter();
		local HP = 12000
		CreateCharacter(0, 'strike', 0, g_PlayerPracticeModePosX[1], g_PlayerPracticeModePosY[1], g_PlayerPracticeModeAngle[1], HP);
		CreateCharacter(1, 'strike', 1, g_PlayerPracticeModePosX[2], g_PlayerPracticeModePosY[2], g_PlayerPracticeModeAngle[2], HP);
		CreateCharacter(2, 'grab', 1, g_PlayerPracticeModePosX[3], g_PlayerPracticeModePosY[3], g_PlayerPracticeModeAngle[3], HP);
		--CreateCharacter(3, 'grab', 1, g_PlayerPracticeModePosX[3], g_PlayerPracticeModePosY[3], g_PlayerPracticeModeAngle[3]);
		EndCreateCharacter(false);
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(false)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(false)
		
		winMgr:getWindow('sj_practice_speakermanStyle_backImage1'):setVisible(true)
		winMgr:getWindow('sj_practice_speakermanStyle_backImage2'):setVisible(true)
		
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'true');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'true');
		ChangeState(0, 'PPlayer');
		
	elseif args == 2 then -- ������
		StartCreateCharacter();	
		local HP = 12000
		CreateCharacter(0, 'strike', 0, g_TeamAttackPosX[1], g_TeamAttackPosY[1], g_TeamAttackAngle[1], HP);
		CreateCharacter(1, 'strike', 0, g_TeamAttackPosX[2], g_TeamAttackPosY[2], g_TeamAttackAngle[2], HP); -- NPC�� ������������ �����.
		CreateCharacter(2, 'strike', 1, g_TeamAttackPosX[3], g_TeamAttackPosY[3], g_TeamAttackAngle[3], HP);
		EndCreateCharacter(false);
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(false)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(false)
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(true)
		
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'false');
		
		winMgr:getWindow('sj_practice_speakermanStyle_backImage1'):setVisible(false)
		winMgr:getWindow('sj_practice_speakermanStyle_backImage2'):setVisible(false)
		
		ChangeState(0, 'PPlayer');
		ChangeState(1, 'P1TeamAssist');		-- �÷��̾� �����
		
		CharOff(1);
		CharOff(2);
		
	elseif args == 3 then	-- �������
		StartCreateCharacter();
		local HP = 12000
		CreateCharacter(0, 'strike', 0, g_DoubleAttackPosX[g_AttackPosSeq][1], g_DoubleAttackPosY[g_AttackPosSeq][1], g_DoubleAttackAngle[g_AttackPosSeq][1], HP);
		CreateCharacter(1, 'strike', 1, g_DoubleAttackPosX[g_AttackPosSeq][2], g_DoubleAttackPosY[g_AttackPosSeq][2], g_DoubleAttackAngle[g_AttackPosSeq][2], HP);
		CreateCharacter(2, 'grab', 1, g_DoubleAttackPosX[g_AttackPosSeq][3], g_DoubleAttackPosY[g_AttackPosSeq][3], g_DoubleAttackAngle[g_AttackPosSeq][3], HP);
		EndCreateCharacter(false);
		--SettingDoubleAttackPosition(1);
		
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(false)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(false)
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(true)
		
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'false');
		
		winMgr:getWindow('sj_practice_speakermanStyle_backImage1'):setVisible(false)
		winMgr:getWindow('sj_practice_speakermanStyle_backImage2'):setVisible(false)
		ChangeState(0, 'DoubleAttackCheck');
		ChangeAIPlayerType(1, AI_TYPE_DEFAULT);
		CharOff(1);
		CharOff(2);
	end
end


----------------------------------------------------------------------

-- �̺�Ʈ - ���� Ÿ��(ǥ��, ������, �������) ���̿� ��ư

----------------------------------------------------------------------
g_FirstSelectEnter = true;
function OnSelectedChangePracticeType(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local local_index = local_window:getUserString('index');		
		if g_FirstSelectEnter == false then			
			if local_index == '1' then		-- ǥ�ؾ����� �������� ��
				GotoPracticeMode(1);
			elseif local_index == '2' then	-- �������� �������� ��
				GotoPracticeMode(2);
			elseif local_index == '3' then	-- ��������� �������� ��
				g_AttackPosSeq = 1;
				GotoPracticeMode(3);
			end
		end
	end
	
	g_FirstSelectEnter = false;	
end






----------------------------------------------------------------------

-- ������忡�� ���� ��ư ��������

----------------------------------------------------------------------
function OnClickPracticeModeHelp(args)
	if g_IsViewPracticeHelp then
		ShowPracticeHelp(-1);
		
	else
		ShowPracticeHelp(1);
	end
end


----------------------------------------------------------------------

-- ������忡�� ������ ��������

----------------------------------------------------------------------
function OnClickPracticeModeExit(args)
	ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_29, "OnClickedCommonAlertQuestOk", "OnClickedCommonAlertQuestCancel")
end


----------------------------------------------------------------------

-- ����Ŀ��1�� ��ư ��������

----------------------------------------------------------------------
function OnClickSpeacker1_On(args)
	winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(false)
	winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(true)
	ChangeState(1, 'PStand');
	--g_Appointment_1Off = true;
	for i=1, 4 do
		winMgr:getWindow(tWinSpeackerTypeName[i]):setProperty('Selected', 'false');
	end
	CharOn(1); -- ������ư�� ������ �·� �ٲٴϱ� ������
end


----------------------------------------------------------------------

-- ����Ŀ��1���� ��ư ��������

----------------------------------------------------------------------
function OnClickSpeacker1_Off(args)
	--if g_Appointment_1Off == false then 
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_off'):setVisible(false)
		--g_Appointment_1Off = false;		
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'true');
	--end
	CharOff(1);
end


----------------------------------------------------------------------

-- ����Ŀ��2�� ��ư ��������

----------------------------------------------------------------------
function OnClickSpeacker2_On(args)
	winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(false)
	winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(true)
	ChangeState(2, 'PStand');
	--g_Appointment_2Off = true;
	for i=5, 8 do
		winMgr:getWindow(tWinSpeackerTypeName[i]):setProperty('Selected', 'false');
	end
	CharOn(2);
end


----------------------------------------------------------------------

-- ����Ŀ��2���� ��ư ��������

----------------------------------------------------------------------
function OnClickSpeacker2_Off(args)
	--if g_Appointment_1Off == false then 
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):setVisible(true)
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_off'):setVisible(false)
		--g_Appointment_2Off = false;
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'true');
		CharOff(2);
	--end
end




g_SelectedType_S1 = 0;
g_SelectedType_S2 = 0;

g_Appointment_1Off = false;
g_Appointment_2Off = false;

SELECTED_STAND  = 1;
SELECTED_EVADE  = 2;
SELECTED_GRAB   = 3;
SELECTED_ATTACK = 4;

function OnSelectedChange_S1Type(args)
	if winMgr:getWindow('sj_practice_practiceMode_speakerman1_on'):isVisible() then
		local local_window = CEGUI.toWindowEventArgs(args).window;	
		local local_index = local_window:getUserString('index');
		if local_index == '0' then
			local_index = '4';
		end
		if CEGUI.toRadioButton(local_window):isSelected() then
			g_SelectedType_S1 = tonumber(local_index);
			if local_index == '1' then		-- ���ֱ⸦ ����������
				ChangeState(1, 'PStand');
			elseif local_index == '2' then	-- ȸ�Ǹ� ����������
				ChangeState(1, 'PEvade');
			elseif local_index == '3' then	-- ��⸦ ����������
				ChangeState(1, 'PGrab');
			elseif local_index == '4' then	-- ������ ����������
				ChangeState(1, 'PAttack');
			end
		end
	else
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_evade'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_grab'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman1_attack'):setProperty('Selected', 'false');
	end
		
end




function OnSelectedChange_S2Type(args)
	if winMgr:getWindow('sj_practice_practiceMode_speakerman2_on'):isVisible() then
		local local_window = CEGUI.toWindowEventArgs(args).window;
		local local_index = local_window:getUserString('index');
		if local_index == '0' then
			local_index = '4';
		end
			
		if CEGUI.toRadioButton(local_window):isSelected() then
			g_SelectedType_S2 = tonumber(local_index);
			if local_index == '1' then		-- ���ֱ⸦ ����������
				ChangeState(2, 'PStand');
			elseif local_index == '2' then	-- ȸ�Ǹ� ����������
				ChangeState(2, 'PP2Chase');
			elseif local_index == '3' then	-- ��⸦ ����������
				ChangeState(2, 'PP2Chase');
			elseif local_index == '4' then	-- ������ ����������
				ChangeState(2, 'PP2Chase');
			end
		end
	else
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_evade'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_grab'):setProperty('Selected', 'false');
		winMgr:getWindow('sj_practice_practiceMode_speakerman2_attack'):setProperty('Selected', 'false');
	end
end



-- ��ü�� ���̰ų� ������� �����.
function ShowPracticeModeUI(bVisible)
	
	for i=1, #tWinStaticName do
		winMgr:getWindow(tWinStaticName[i]):setVisible(bVisible)
	end
	for i=1, #tWinPracticeTypeName do
		winMgr:getWindow(tWinPracticeTypeName[i]):setVisible(bVisible)
	end
	for i=1, #tWinSpeackerTypeName do
		winMgr:getWindow(tWinSpeackerTypeName[i]):setVisible(bVisible)
	end
	for i=1, #tNpcName do
		winMgr:getWindow(tNpcName[i]):setVisible(bVisible)
	end
	for i=1, #tWinPracticeModeButton do
		winMgr:getWindow(tWinPracticeModeButton[i]):setVisible(bVisible)
	end	
end

ShowCollisionCircle(false);




----------------------------------------------------------------------

-- ������忡�� ���̴� ����ƽ �̹���

----------------------------------------------------------------------
tWinStaticName	= {['err'] = 0, 'sj_practice_practiceType_backImage', 'sj_practice_speakermanStyle_backImage1', 'sj_practice_speakermanStyle_backImage2', 
									'sj_practice_actionKey_backImage', 'sj_practice_practiceMode_panel'}
tTexName	= {['err'] = 0, 'UIData/tutorial002.tga', 'UIData/tutorial002.tga', 'UIData/tutorial002.tga', 'UIData/invisible.tga', 'UIData/tutorial001.tga' }
tTextureX	= {['err'] = 0,  696,  838,  838, 494, 252 }
tTextureY	= {['err'] = 0,  762,  697,  697,   0, 229+52*5 }
tSizeX		= {['err'] = 0,  142,  186,  186, 356, 328 }
tSizeY		= {['err'] = 0,  126,  190,  190, 441,  52 }
tPosX		= {['err'] = 0,  0,  4,  194, 660, 360 }
tPosY		= {['err'] = 0,   0,  545, 545, 218,  25 }

for i=1, #tWinStaticName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinStaticName[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	if i == 1 then
	elseif i == 2 then
		mywindow:setWideType(2);
	elseif i == 3 then
		mywindow:setWideType(2);
	elseif i == 4 then
	else
		mywindow:setWideType(5);
	end
	
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setZOrderingEnabled(false);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	root:addChildWindow(mywindow);
end


-- ��������
--winMgr:getWindow('sj_practice_practiceMode_panel'):setTexture("Enable", 'UIData/tutorial001.tga', 282, 229+52*5);

-- Test �� --
--winMgr:getWindow('sj_practice_practiceType_backImage'):setPosition(0,0);
--winMgr:getWindow('sj_practice_speakermanStyle_backImage1'):setPosition(20,545);
--winMgr:getWindow('sj_practice_speakermanStyle_backImage2'):setPosition(210,545);



----------------------------------------------------------------------

-- ��� �ִ� Ÿ��Ʋ ����ƽ �̹���

----------------------------------------------------------------------
tWinStaticTitleName	= {['err'] = 0, 'sj_practice_title_chapter1', 'sj_practice_title_chapter2', 'sj_practice_title_chapter3', 
		'sj_practice_title_chapter4', 'sj_practice_title_chapter5', 'sj_practice_title_chapter6', 'sj_practice_title_chapter7', 
		'sj_practice_title_chapter8', 'sj_practice_title_chapter9', 'sj_practice_practiceMode_panel_disable', 'sj_practice_missionMode_panel' }
tTexName = {['err'] = 0, 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 
		'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga', 'UIData/tutorial001.tga',
		'UIData/tutorial001.tga', 'UIData/tutorial001.tga' }
tTextureX	= {['err'] = 0,  252,  252,  252, 252, 252, 430, 430, 585, 585, 252, 252 }
tTextureY	= {['err'] = 0,  230,  230+52,  230+52*2, 230+52*3, 230+52*4, 593, 646, 230, 282, 230, 230 }
tSizeX		= {['err'] = 0,  326,  326,  326, 326, 326, 326, 326, 382, 350, 326, 326 }
tSizeY		= {['err'] = 0,   50,   50,   50,  50,  50,  50,  50, 50, 50, 50,  50 }
tPosX		= {['err'] = 0,  348,  348,  348, 348, 348, 348, 348, 348, 348, 348, 348 }
tPosY		= {['err'] = 0,   25,   25,   25,  25,  25,  25,  25, 25, 25, 25,  25 }

for i=1, #tWinStaticTitleName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinStaticTitleName[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setWideType(5);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setZOrderingEnabled(false);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(false)
	root:addChildWindow(mywindow);
end

function ShowChapterTitle(arg)
	for i=1, #tWinStaticTitleName do
		if arg == i then
			winMgr:getWindow(tWinStaticTitleName[i]):setVisible(true)
		else
			winMgr:getWindow(tWinStaticTitleName[i]):setVisible(false)
		end
	end
end



----------------------------------------------------------------------

-- ������� ���� ����ƽ �̹���

----------------------------------------------------------------------
tWinPracticeHelp = {['protecterr'] = 0, 'sj_practice_practiceMode_helper_move', 'sj_practice_practiceMode_helper_attack', 
					'sj_practice_practiceMode_helper_grab', 'sj_practice_practiceMode_helper_evade', 'sj_practice_practiceMode_helper_special'}
tTexName	= {['protecterr'] = 0, 'UIData/tutorial004.tga', 'UIData/tutorial004.tga', 'UIData/tutorial004.tga', 
					'UIData/tutorial004.tga', 'UIData/tutorial005.tga'}
tTextureX	= {['protecterr'] = 0,    0,  393,    0, 393,   0}
tTextureY	= {['protecterr'] = 0,    0,    0,  427, 427,   19}
tSizeX		= {['protecterr'] = 0,  368,  368,  368, 368, 368}
tSizeY		= {['protecterr'] = 0,  426,  426,  426, 426, 426}
tPosX		= 622;
tPosY		= 175;

for i=1, #tWinPracticeHelp do
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinPracticeHelp[i]);
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setPosition(tPosX, tPosY);
	mywindow:setZOrderingEnabled(false);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(true)
	root:addChildWindow(mywindow);
end

function ShowPracticeHelp(arg)
	for i=1, #tWinPracticeHelp do
		if i == arg then
			winMgr:getWindow(tWinPracticeHelp[i]):setVisible(true)
		else
			winMgr:getWindow(tWinPracticeHelp[i]):setVisible(false)
		end
	end
	if arg == -1 then
		g_IsViewPracticeHelp = false;
		winMgr:getWindow('sj_practice_left_arrow'):setVisible(false)
		winMgr:getWindow('sj_practice_right_arrow'):setVisible(false)
	else
		g_IsViewPracticeHelp = true;
		winMgr:getWindow('sj_practice_left_arrow'):setVisible(true)
		winMgr:getWindow('sj_practice_right_arrow'):setVisible(true)
	end
end

g_IsViewPracticeHelp = false;



----------------------------------------------------------------------

-- ������� ���� ���ʿ����� ��ư

----------------------------------------------------------------------
g_CurrHelpPage = 1;
function OnClickArrowLeft()
	if g_CurrHelpPage > 1 then
		g_CurrHelpPage = g_CurrHelpPage - 1;
		ShowPracticeHelp(g_CurrHelpPage);
	end
end

function OnClickArrowRight()
	if g_CurrHelpPage < #tWinPracticeHelp then
		g_CurrHelpPage = g_CurrHelpPage + 1;
		ShowPracticeHelp(g_CurrHelpPage);
	end
end

function renderPageNumber(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	drawer = local_window:getDrawer()
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 24)
	drawer:drawText( tostring(g_CurrHelpPage)..' / 5', 44, 2 )
end



----------------------------------------------------------------------

-- ������ �ѱ�

----------------------------------------------------------------------
tPracticeLRButtonName  = { ["protecterr"]=0, "sj_practice_left_arrow", "sj_practice_right_arrow" }
tPracticeLRButtonTexX  = { ["protecterr"]=0, 44, 61 }
tPracticeLRButtonPosX  = { ["protecterr"]=0, 730, 860 }
tPracticeLRButtonEvent = { ["protecterr"]=0, "OnClickArrowLeft", "OnClickArrowRight" }

for i=1, #tPracticeLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPracticeLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", tPracticeLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", tPracticeLRButtonTexX[i], 30)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga", tPracticeLRButtonTexX[i], 60)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", tPracticeLRButtonTexX[i], 0)
	mywindow:setPosition(tPracticeLRButtonPosX[i], 556)
	mywindow:setSize(17, 30)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tPracticeLRButtonEvent[i])
	root:addChildWindow(mywindow)
end
winMgr:getWindow('sj_practice_left_arrow'):subscribeEvent('EndRender', 'renderPageNumber');
winMgr:getWindow('sj_practice_left_arrow'):setVisible(false)
winMgr:getWindow('sj_practice_right_arrow'):setVisible(false)

ShowPracticeHelp(-1);



----------------------------------------------------------------------

-- ���� Ÿ��(ǥ��, ������, �������) ���̿� ��ư

----------------------------------------------------------------------
tWinPracticeTypeName = {['protecterr'] = 0, 'sj_practice_basic_radioBtn', 'sj_practice_teamAtk_radioBtn', 'sj_practice_doubleAtk_radioBtn'}
tTextureX = {['protecterr'] = 0,   0, 126, 126*2}
tTextureY = {['protecterr'] = 0, 960, 960,   960}
tTextureHoverX = {['protecterr'] = 0,   0, 126, 126*2}
tTextureHoverY = {['protecterr'] = 0, 960, 960,   960}
tTexturePushedX = {['protecterr'] = 0,   0, 126, 126*2}
tTexturePushedY = {['protecterr'] = 0, 960+32, 960+32,  960+32}
nSizeX = 126
nSizeY = 32
--nPosX = 491
--nPosY = 69
nPosX = 9
nPosY = 14
nOffsetX = 0
nOffsetY = 34

--- �ܼ� �ǻ� ���̿� ��ư ��� �����̳�
for i=1, #tWinPracticeTypeName do
	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinPracticeTypeName[i])
	mywindow:setTexture("Normal", "UIData/tutorial002.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/tutorial002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/tutorial002.tga", tTextureX[i], tTextureY[i])

	mywindow:setTexture("SelectedNormal", "UIData/tutorial002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedHover", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i]+nSizeY)
	mywindow:setTexture("SelectedPushed", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i]+nSizeY)
	mywindow:setTexture("SelectedPushedOff", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX, nPosY+nOffsetY*(i-1))
	mywindow:setProperty("GroupID", 10)
	mywindow:setUserString("SubItemName", tWinPracticeTypeName[i])
	mywindow:setUserString('index', tostring(i));
	mywindow:subscribeEvent('SelectStateChanged', "OnSelectedChangePracticeType");
	winMgr:getWindow('sj_practice_practiceType_backImage'):addChildWindow(mywindow);
end



----------------------------------------------------------------------

-- ����Ŀ�� ���� ��Ÿ��(���ֱ�, ȸ��, ���, ����) ���̿� ��ư

----------------------------------------------------------------------
tWinSpeackerTypeName = {['err'] = 0, 'sj_practice_practiceMode_speakerman1_stand', 'sj_practice_practiceMode_speakerman1_evade',
						'sj_practice_practiceMode_speakerman1_grab', 'sj_practice_practiceMode_speakerman1_attack', 
						'sj_practice_practiceMode_speakerman2_stand', 'sj_practice_practiceMode_speakerman2_evade', 
						'sj_practice_practiceMode_speakerman2_grab', 'sj_practice_practiceMode_speakerman2_attack'}
tTextureX = {['err'] = 0,        378, 378+159*1, 378+159*2, 378+159*3, 378, 378+159*1, 378+159*2, 378+159*3 }
tTextureY = {['err'] = 0,          960,   960,   960,   960,   960,   960,   960,   960 }
tTextureHoverX = {['err'] = 0,   378, 378+159*1, 378+159*2, 378+159*3, 378, 378+159*1, 378+159*2, 378+159*3 }
tTextureHoverY = {['err'] = 0,     960,   960,   960,   960,   960,   960,   960,   960 }
tTexturePushedX = {['err'] = 0,  378, 378+159*1, 378+159*2, 378+159*3, 378, 378+159*1, 378+159*2, 378+159*3 }
tTexturePushedY = {['err'] = 0, 960+32,960+32,960+32,960+32,960+32,960+32,960+32,960+32 }
nSizeX = 159
nSizeY = 32
--nPosX = 491
--nPosY = 69
nPosX = {['err'] = 0,	14,    14,      14,      14,    14,      14,      14,      14 }
nPosY = {['err'] = 0,	40, 40+35, 40+35*2, 40+35*3,    40,   40+35, 40+35*2, 40+35*3 }
nOffsetX = 0
nOffsetY = 34
tEventSpeackerTypeName = {['err'] = 0 , 'OnSelectedChange_S1Type', 'OnSelectedChange_S1Type', 'OnSelectedChange_S1Type', 'OnSelectedChange_S1Type', 
										'OnSelectedChange_S2Type', 'OnSelectedChange_S2Type', 'OnSelectedChange_S2Type', 'OnSelectedChange_S2Type' }

--- �ܼ� �ǻ� ���̿� ��ư ��� �����̳�
for i=1, #tWinSpeackerTypeName do
	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinSpeackerTypeName[i])
	mywindow:setTexture("Normal", "UIData/tutorial002.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/tutorial002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/tutorial002.tga", tTextureX[i], tTextureY[i])

	mywindow:setTexture("SelectedNormal", "UIData/tutorial002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedHover", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i]+nSizeY)
	mywindow:setTexture("SelectedPushed", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i]+nSizeY)
	mywindow:setTexture("SelectedPushedOff", "UIData/tutorial002.tga", tTextureHoverX[i], tTextureHoverY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX[i], nPosY[i])
	mywindow:setUserString('index', tostring(i%4));
	mywindow:subscribeEvent('SelectStateChanged', tEventSpeackerTypeName[i]);
end

tNpcName = {["err"]=0, "sj_practice_npc1", "sj_practice_npc2"}
for i=1, 2 do
	_window = winMgr:createWindow("TaharezLook/StaticText", tNpcName[i])
	_window:setProperty("FrameEnabled", "false")
	_window:setProperty("BackgroundEnabled", "false")
	_window:setFont(g_STRING_FONT_GULIMCHE, 14)
	_window:setTextColor(255, 255, 255, 255)
	_window:setPosition(50, 10)
	_window:setSize(100, 30)
	_window:setAlign(8)
	_window:setText(STRING_SPEAKERMAN.." "..i)
	_window:clearTextExtends()
	_window:setTextExtends(STRING_SPEAKERMAN.." "..i, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    1, 0,0,0,255);
	_window:setEnabled(false)
end
winMgr:getWindow('sj_practice_speakermanStyle_backImage1'):addChildWindow(winMgr:getWindow(tNpcName[1]))
winMgr:getWindow('sj_practice_speakermanStyle_backImage2'):addChildWindow(winMgr:getWindow(tNpcName[2]))



----------------------------------------------------------------------

-- ���� ��� ����, ������

----------------------------------------------------------------------
tWinPracticeModeButton = {['err'] = 0, 'sj_practice_practiceMode_helper', 'sj_practice_practiceMode_wentout', 
			'sj_practice_practiceMode_speakerman1_on', 'sj_practice_practiceMode_speakerman1_off', 
			'sj_practice_practiceMode_speakerman2_on', 'sj_practice_practiceMode_speakerman2_off' }

tTextureX = {['err'] = 0,            730,  730+110,      850+76,   850,      850+76,   850  }
tTextureY = {['err'] = 0,            233,      233,      129,      129,      129,      129  }	
tTextureHoverX = {['err'] = 0,       730,  730+110,      850+76,   850,      850+76,   850  }
tTextureHoverY = {['err'] = 0,    233+85,   233+85,   129+29,   129+29,   129+29,   129+29  }
tTexturePushedX = {['err'] = 0,      730,  730+110,      850+76,   850,      850+76,   850  }
tTexturePushedY = {['err'] = 0, 233+85*2, 233+85*2, 129+29*2, 129+29*2, 129+29*2, 129+29*2  }

nSizeX = {['err'] = 0, 110, 110, 76, 76, 76, 76 }
nSizeY = {['err'] = 0,  85,  85, 29, 29, 29, 29 }

tPosX = {['err'] = 0, -4, -4+90, 100, 100, 100, 100 }
tPosY = {['err'] = 0, 180,     180,   5,   5,   5,   5 }
tTextureName = {['err'] = 0, 'UIData/tutorial003.tga', 'UIData/tutorial003.tga', 
						'UIData/tutorial002.tga', 'UIData/tutorial002.tga', 'UIData/tutorial002.tga', 'UIData/tutorial002.tga' }

MainMenuClickedEventName = {['err'] = 0, 'OnClickPracticeModeHelp', 'OnClickPracticeModeExit', 
						'OnClickSpeacker1_On', 'OnClickSpeacker1_Off', 'OnClickSpeacker2_On', 'OnClickSpeacker2_Off' }

for i=1, #tWinPracticeModeButton do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinPracticeModeButton[i]);
	mywindow:setTexture("Normal", tTextureName[i], tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", tTextureName[i], tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", tTextureName[i], tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", tTextureName[i], tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX[i], nSizeY[i]);
	if i < 3 then
		mywindow:setWideType(0);
	else
		mywindow:setWideType(4);
	end
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:subscribeEvent("Clicked", MainMenuClickedEventName[i]);
	
	if i < 3 then
		root:addChildWindow(mywindow);
	end
end


for i=1, 4 do
	local local_window = winMgr:getWindow(tWinSpeackerTypeName[i]);
	local parent_window = winMgr:getWindow('sj_practice_speakermanStyle_backImage1');
	local_window:setProperty('GroupID', 11);
	parent_window:addChildWindow(local_window);
end

for i=5, 8 do
	local local_window = winMgr:getWindow(tWinSpeackerTypeName[i]);
	local parent_window = winMgr:getWindow('sj_practice_speakermanStyle_backImage2');
	local_window:setProperty('GroupID', 12);
	parent_window:addChildWindow(local_window);
end


winMgr:getWindow('sj_practice_practiceMode_speakerman1_stand'):setProperty('Selected', 'true');
winMgr:getWindow('sj_practice_practiceMode_speakerman2_stand'):setProperty('Selected', 'true');

winMgr:getWindow('sj_practice_actionKey_backImage'):setVisible(false)

ShowPracticeModeUI(false);



-- ����Ŀ�� ��Ʈ
function ShowSpeekerManMent()
	local spk_ment_window = winMgr:getWindow('sj_practice_mentText');
	CEGUI.toGUISheet(spk_ment_window):setTextViewDelayTime(17);
	spk_ment_window:setVisible(true);
	spk_ment_window:clearTextExtends();
		
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0

	tbufStringTable, tbufSpecialTable = cuttingString(g_tCurMentString[g_SubTalkSeq], tbufStringTable, tbufSpecialTable, count)
	
	for i=0, #tbufStringTable do
		local colorIndex = tonumber(tbufSpecialTable[i])
		if colorIndex == nil then
			colorIndex = 0
		end
		spk_ment_window:addTextExtends(tbufStringTable[i], tSpkMentFontData[1],tSpkMentFontData[2], 
																	   tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2]
																	   ,tSpkMentFontData[6], tSpkMentFontData[7], 
																	   tSpkMentFontData[8],tSpkMentFontData[9],tSpkMentFontData[10],tSpkMentFontData[11]);
	end
end



tWinName = {['protecterr'] = 0,'sj_practice_mentText', 'AdditionHelp' }
tWinText = {['protecterr'] = 0,'', 'AdditionHelp' }

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(120+135, 58);
	_window:setSize(700, 153);
	_window:setAlign(0);	
	_window:setViewTextMode(2);
	_window:setLineSpacing(5);
	_window:setText(tWinText[i]);
	_window:setEnabled(false)
	_window:setVisible(true);	
end

winMgr:getWindow('sj_practice_speakermanTalkWindow'):addChildWindow( winMgr:getWindow('sj_practice_mentText') );
g_spk_ment_window = winMgr:getWindow('sj_practice_mentText');

winMgr:getWindow('AdditionHelp'):setPosition(30, 15);
root:addChildWindow( winMgr:getWindow('AdditionHelp') );
CEGUI.toGUISheet(winMgr:getWindow('AdditionHelp')):setTextViewDelayTime(16);




-----------------------------------------------------------------

--	Ʃ�丮�� Ű�Է� �κ�

-----------------------------------------------------------------
function RootKeyUp(args)

	local keyEvent = CEGUI.toKeyEventArgs(args);
	local _spk_visible = winMgr:getWindow('sj_practice_speakermanTalkWindow'):isVisible()
	local _pay_visible = winMgr:getWindow('CommonAlertAlphaImg'):isVisible()
	local _box_visible = winMgr:getWindow('CommonAlertOkCancelBox'):isVisible()
	local _angle = winMgr:getWindow('CommonAlertOkBox'):getAngle();
	
	local isTalkComplete = CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):isCompleteViewText();
	
	--------------
	-- ESC Ű
	--------------
	if keyEvent.scancode == 27 then
		
		-- 1. Ʃ�丮�� ���
		if g_ScnState == SCN_TUTORIAL_MODE then
			if g_IsFirstTutorial == true then
				if _pay_visible then
					FirstTutorialSkipCancel()
				else
					ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_28, 'FirstTutorialSkipOk', 'FirstTutorialSkipCancel')
				end
			else
				if _pay_visible then
					OnClickedCommonAlertQuestCancel()
				else
					ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_28, "OnClickedCommonAlertQuestOk", "OnClickedCommonAlertQuestCancel")
				end
			end
		
		-- 2. ���� ���
		elseif g_ScnState == SCN_PRACTICE_MODE then
			if _pay_visible then
				OnClickedCommonAlertQuestCancel()
			else
				ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_29, "OnClickedCommonAlertQuestOk", "OnClickedCommonAlertQuestCancel")
			end
			
		-- 3. ���θ޴� ȭ��
		elseif g_ScnState == SCN_MAIN_MENU then
		
			-- �������� ������ '���尡��' ��ư�� ������ Select�̹����� �����Ѵ�
			winMgr:getWindow('sj_practice_exitImage'):setTexture("Normal", "UIData/tutorial001.tga", 789, 740+72*2);
			BtnPageMove_GoToVillageFromPractive()
			
		-- 4. Ʃ�丮�� �������
		elseif g_ScnState == SCN_START_TUTORIAL then
			if g_IsFirstTutorial == true then
				if _pay_visible then
					FirstTutorialSkipCancel()
				else
					ShowCommonAlertOkCancelBoxWithFunction("", STRING_TUTORIAL_28, 'FirstTutorialSkipOk', 'FirstTutorialSkipCancel')
				end
			else
				-- �������� ������ '���尡��' ��ư�� ������ Select�̹����� �����Ѵ�
				winMgr:getWindow('sj_practice_exitImage'):setTexture("Normal", "UIData/tutorial001.tga", 789, 740+72*2);
				BtnPageMove_GoToVillageFromPractive();
			end
		end

	
	
	--------------
	-- ENTER Ű
	--------------
	elseif keyEvent.scancode == 13 then

		-- 1. Ʃ�丮�� ���
		if g_ScnState == SCN_TUTORIAL_MODE then
			if g_IsFirstTutorial == true then
				if _pay_visible and g_OneTimeExcute == false then
					FirstTutorialSkipOk()
				end
			else
				if _pay_visible and g_OneTimeExcute == false then
					OnClickedCommonAlertQuestOk()
				end
			end
		
		-- 2. ���� ���
		elseif g_ScnState == SCN_PRACTICE_MODE then
			if _pay_visible and g_OneTimeExcute == false then
				OnClickedCommonAlertQuestOk()
			end
			
		-- 3. ���θ޴� ȭ��
		elseif g_ScnState == SCN_MAIN_MENU then
			
		-- 4. Ʃ�丮�� �������
		elseif g_ScnState == SCN_START_TUTORIAL then
			if g_IsFirstTutorial == true then
				if _pay_visible and g_OneTimeExcute == false then
					FirstTutorialSkipOk()
				end
			end
		end
		
		if _pay_visible then  -- ����â�� ���� ���
			if _angle == 1000 or _angle == 0 then
				g_OneTimeExcute = false;
				g_EndMotion = false;
				winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false);
				winMgr:getWindow('CommonAlertOkBox'):setVisible(false);
				WndPractice_ClearCompensition();
				winMgr:getWindow('CommonAlertOkBox'):setAngle(0);
				return;
			end
		end
	
	
	--------------
	-- SPACE Ű
	--------------
	elseif keyEvent.scancode == 32 then
		if _spk_visible then
			if g_ScnState == SCN_START_TUTORIAL and g_IsFirstTutorial == true then
				if isTalkComplete == true then
					StartTutorial();
				else
					CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):setCompleteViewText(true);
				end				
				return;
			end
			
			if g_ScnState == SCN_TUTORIAL_MODE then
				
				if isTalkComplete == true then
					NextSequenceProcess();
				else
					CEGUI.toGUISheet(winMgr:getWindow('sj_practice_mentText')):setCompleteViewText(true);
				end				
				return;
			end
		end
		
		if _pay_visible then  -- ����â�� ���� ���
			if _angle == 1000 or _angle == 0 then
				g_OneTimeExcute = false;
				g_EndMotion = false;
				winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false);
				winMgr:getWindow('CommonAlertOkBox'):setVisible(false);
				WndPractice_ClearCompensition();
				winMgr:getWindow('CommonAlertOkBox'):setAngle(0);
				return;
			end
		end
	
	
	--------------
	-- K Ű
	--------------
	elseif keyEvent.scancode == 75 then
		if g_EnableKey == true then
			--g_IsMissionComplete = true;
			--g_SubTalkSeq = 1;
		end
	
	
	--------------
	-- F1 Ű
	--------------
	elseif keyEvent.scancode == 112 then
		if g_ScnState == SCN_TUTORIAL_MODE then
			if _spk_visible == false then
				if g_bKeyDescVisible then
					g_bKeyDescVisible = false
				else
					g_bKeyDescVisible = true
				end
				ClickHelpProcess();
			end
		elseif g_ScnState == SCN_PRACTICE_MODE then
			if _spk_visible == false then
				if g_IsViewPracticeHelp then
					ShowPracticeHelp(-1);
				else
					ShowPracticeHelp(g_CurrHelpPage);
				end
			end
		elseif g_ScnState == SCN_MAIN_MENU then
		
		end
		
	
	elseif keyEvent.scancode == 229 then
		if g_ScnState == SCN_PRACTICE_MODE then
		end
	end
end
root:subscribeEvent("KeyUp", "RootKeyUp");


----------------------------------------------------------------------

-- Ʃ�丮�� �Ϸ� ���� ���¿��� ��ŵ OK�� Ŭ�� �� ���

----------------------------------------------------------------------
g_IsMissionComplete = false;
function FirstTutorialSkipOk(args)	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "FirstTutorialSkipOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	g_OneTimeExcute = false
	BtnPageMove_GoToVillageFromPractive();
end


----------------------------------------------------------------------

-- ĵ��

----------------------------------------------------------------------
function FirstTutorialSkipCancel(args)
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "FirstTutorialSkipCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	g_OneTimeExcute = false
end
root:addChildWindow(winMgr:getWindow('CommonAlertOkCancelBox'))	-- ���̴� �� ���߿� ���δ�. �׽�Ʈ �Ҷ� �ٿ�������~




----------------------------------------------------------------------

-- Ʃ�丮��, ������带 �����ðڽ��ϱ�? OK��ư

----------------------------------------------------------------------
function OnClickedCommonAlertQuestOk(args)
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickedCommonAlertQuestOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	g_GogoProcess = false;
	GotoMainMenu();
	g_CurState = nil;
	g_GogoProcess = false;
	CurrentTutorialState(1)	-- ������ ������ ���߱� ����
	g_OneTimeExcute = false
end



----------------------------------------------------------------------

-- Ʃ�丮��, ������带 �����ðڽ��ϱ�? ��ҹ�ư

----------------------------------------------------------------------
function OnClickedCommonAlertQuestCancel(args)
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickedCommonAlertQuestCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	g_OneTimeExcute = false
end

winMgr:getWindow('CommonAlertQuestOk'):subscribeEvent('Clicked', 'OnClickedCommonAlertQuestOk');
winMgr:getWindow('CommonAlertQuestCancel'):subscribeEvent('Clicked', 'OnClickedCommonAlertQuestCancel');



----------------------------------------------------------------------

-- �����忡�� ������ & �޺�

----------------------------------------------------------------------
function WndPractice_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
				teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end



----------------------------------------------------------------------

-- ���� �ݱ�

----------------------------------------------------------------------
function WndPractice_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	if weaponIndex >= 0 then
		drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-80, 84, 62, 474, 883)
	end
end


----------------------------------------------------------------------

-- �����̽��� �ִϸ��̼� �̹��� 

----------------------------------------------------------------------
tAniSpaceImgName = {['protecterr'] = 0,	"Space1", "Space2"}
tAniSpaceImgTexX = {['protecterr'] = 0, 896, 742}

for i=1, #tAniSpaceImgName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tAniSpaceImgName[i]);
	mywindow:setTexture("Enabled", "UIData/tutorial001.tga", tAniSpaceImgTexX[i], 379);
	mywindow:setTexture("Disabled", "UIData/tutorial001.tga", tAniSpaceImgTexX[i], 379);
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setSize(118,75);
	mywindow:setPosition(828, 138);
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setSubscribeEvent('MouseLeave', 'AniSpaceMouseLeave');
	mywindow:setSubscribeEvent('MouseEnter', 'AniSpaceMouseEnter');
	winMgr:getWindow('sj_practice_speakermanTalkWindow'):addChildWindow(mywindow)
end

function AniSpaceMouseEnter(args)
	g_bShowAniSpace = false;
	winMgr:getWindow('Click->'):setVisible(true)
end


function AniSpaceMouseLeave(args)
--	winMgr:getWindow("Space1"):setVisible(true)
--	winMgr:getWindow("Space2"):setVisible(true)
end



----------------------------------------------------------------------

-- �����̽� �ִ� �̹��� ��������� ���� ������
----------------------------------------------------------------------
function AniSpaceImage(bShow)
	if bShow then
		if g_SpaceTime > 250 then
			if g_SpaceAni then
				winMgr:getWindow("Space1"):setVisible(true)
				winMgr:getWindow("Space2"):setVisible(false)
				g_SpaceAni = false;
			else
				winMgr:getWindow("Space1"):setVisible(false)
				winMgr:getWindow("Space2"):setVisible(true)
				g_SpaceAni = true;
			end
			g_SpaceTime = 0;
		end
	else
		winMgr:getWindow("Space1"):setVisible(false)
		winMgr:getWindow("Space2"):setVisible(false)	
	end
end



function SpaceBtImgLeave(args)
	g_bShowAniSpace = true;
	winMgr:getWindow('Click->'):setVisible(false)
end





----------------------------------------------------

-- ������

----------------------------------------------------

-- ������ ���� �����̹��� �׸���
local g_itemSlotX_0 = 270--136
local g_itemScale_0 = 315
local g_itemSlotY	= 180--96

-- ������ ���� �׸���
function WndPractice_RenderStartItemSlot()
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 49, 51, 550, 104, 
													g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
end


-- ������ �׸���
function WndPractice_RenderItem(itemType_0)
	
	-- ������ �׸���
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_0, g_itemSlotY, 43, 44, itemType_0*47, 0,
													g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
end



-- ������ �Ծ��� �� ȿ�� �׸���
function WndPractice_RenderEffectGetItem(state)
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 41, 45, 554+(state*46), 162,
													g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
end


-- ��Ҷ�, ���Ժ����� �Ϸ�Ǿ��� ��� ��ġ �ʱ�ȭ
function WndPractice_InitEffectGetItem()
end



-- ������ ���� �̹���(����� 0������ �׵θ�)
function WndPractice_RenderEndItemSlot()
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 57, 59, 658, 100,
														330, 330, 255, 0, 8, 100, 0)
end



-- �������� ������� �� �����ֱ�
function WndPractice_ItemUseEffect(type, tick)

	local alpha = 0
	if 0 <= tick and tick <= 60 then
		alpha = 255
	elseif 60 < tick and tick < 89 then
		alpha = 255 - ((tick-60)*8)
	elseif tick <= 90 then
		alpha = 0
	end
	
	local y = 200
	
	
	-- ����� �� �ֺ�ȿ�� �׸���
	if tick <= 20 then
		local _tick = tick/5
		if _tick == 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 47, 49, 60, 139, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 1 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 71, 73, 110, 127, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 2 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 519, y, 107, 109, 179, 109, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 3 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 39, 41, 296, 141, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		end
	end
	
	-- ���Ǵ� ������ �׸���
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 43, 44, type*47, 0,
														350, 350, alpha, 0, 8, 100, 0, WIDETYPE_6)
	
	-- ���Ǵ� ������ �̸�
	drawer:drawTextureA("UIData/GameSlotItem.tga", 450, y+30, 128, 19, 399, 142+(type*19), alpha, WIDETYPE_6)
end

