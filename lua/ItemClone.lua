--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
local WINDOW_MYITEM_LIST = 0

--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------
local g_STRING_USING_PERIOD		= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- ���Ⱓ
local g_STRING_UNTIL_DELETE		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- �����ñ���
local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)			-- ����

--------------------------------------------------------------------
-- Ŭ�� �ڽ�Ƭ ���� ��Ʈ��
--------------------------------------------------------------------
local g_STRING_USE_CLONE_AVATAR =		PreCreateString_3566	--GetSStringInfo(LAN_CLONE_MESSAGE_5)					-- Ŭ�� �ڽ�Ƭ�� �ٸ� �ڽ�Ƭ�� �ռ��ϸ�, �ٽ� �и��� �� ĳ�þ������� �ʿ��մϴ�. �׷��� �����Ͻðڽ��ϱ�? 
local g_STRING_QUESTION_CLEANUP_USE	 =	PreCreateString_3548	--GetSStringInfo(LAN_CLONE_POLLUTION_MESSAGE_1)	-- ��ȭ���� ����Ͻðڽ��ϱ�?
local g_STRING_QUESTION_ROLLBACK_USE =	PreCreateString_3554	--GetSStringInfo(LAN_CLONE_ROLLBACK_1)				-- �Ϲ� �ƹ�Ÿ�� ��ȯ �Ͻðڽ��ϱ�?
local g_STRING_QUESTION_SEPARATE_USE =	PreCreateString_3551	--GetSStringInfo(LAN_CLONE_SEPARATE_MESSAGE_1)		-- ����� �ƹ�Ÿ�� ����ð�[�����ϱ�?


local ITEMLIST_ZEN						= 0
local ITEMLIST_CASH						= 1
local ITEMLIST_SKILL					= 2
local ITEMLIST_COSTUME					= 3
local ITEMLIST_POLLUTION_ZEN_AVATAR		= 4
local ITEMLIST_POLLUTION_CASH_AVATAR	= 5
local ITEMLIST_SEPARATE_AVATAR			= 6
local ITEMLIST_ROOL_BACK				= 7
local MAX_CLONE_REWARD					= 10

local ITEM_TYPE_UNSEALSKILLITEM			= 0
local ITEM_TYPE_UNSEALSKILLTRADEITEM	= 1
local ITEM_TYPE_ITEMAVART				= 2
local ITEM_TYPE_ITEMAVART_CLEANUP		= 3
local ITEM_TYPE_ITEMAVART_MAKE			= 4
local ITEM_TYPE_ITEMAVART_ROOL_BACK		= 5
local ITEM_TYPE_CURRENT					= ITEM_TYPE_UNSEALSKILLITEM

g_curPage_CloneItemList		= 1
g_maxPage_CloneItemList		= 1
CloneSlotIndex				= 0 
SelectBoneIndex				= 0
local g_currenItemList		= ITEMLIST_SKILL

RegistEscEventInfo("CloneMainImage"	, "CloneCancelEvent")

--==============================================================================================================
--================================== �ڽ�Ƭ �ƹ�Ÿ ���� ���� ===================================================
--============================================================================================================== 3000 LINE End
local CostumeAvatarCreateFlag = 1
	if CostumeAvatarCreateFlag == 1 then
		
		----------------------------------------------------------------------
		-- ������ �������� ���� �Ǿ����� üũ
		----------------------------------------------------------------------
		g_bNowItemIsSelected  = false
		
		-- Ŭ�� �ƹ�Ÿ ��ȯ�� �Ͻðڽ��ϱ�? ��ư�� ������쿣 ���� 1�� ���� ... �÷���
		g_ItemCloneAttach = -1
		
		-- ���� ���� �ε��� / Ŭ�� �ƹ�Ÿ ���� ������
		g_ItemSlot = 0
		
		----------------------------------------------------------------------
		-- ���� �����츦 �������� listâ�� ������ �����ϴ� �÷���
		----------------------------------------------------------------------
		MODE_CHANGE_COSTUME = 0
		MODE_SELECT_VISUAL	= 1
		MODE_USE_CLEANUP	= 2
		MODE_USE_SEPARATE	= 3
		MODE_USE_ROOLBACK	= 4
		
		g_nNowSelectedCostumeMode = MODE_CHANGE_COSTUME

		----------------------------------------------------------------------
		-- Ŭ���� ������ ���� (ĳ�� , Zen)
		----------------------------------------------------------------------
		MODE_ZEN_CLEAN_UP	= 3
		MODE_CASH_CLEAN_UP	= 4
		
		g_nCleanUpItemType = -1
		
		g_nCleanUpMode	   = -1

		----------------------------------------------------------------------
		-- ��ȭ�ϱ� ���� ���õ� �ڽ�Ƭ �ƹ�Ÿ
		----------------------------------------------------------------------
		g_nSelectedCleanupAvatar = 0

		----------------------------------------------------------------------
		-- Ŭ�� �ƹ�Ÿ ���� ESC, Enter �̺�Ʈ ��ϡ�
		----------------------------------------------------------------------
		RegistEscEventInfo("Costume_Make_Root"			, "CostumeEscClose")
		RegistEscEventInfo("Costume_Visual_Root"		, "CostumeCloseEvent")
		RegistEscEventInfo("Costume_Clean_Root"			, "CostumeCloseEvent")
		RegistEscEventInfo("Costume_Change_MainWindow"	, "CostumeCloseEvent")
		RegistEscEventInfo("Costume_Visual_Main"		, "CostumeCloseEvent")
		
		RegistEnterEventInfo("Costume_Change_NoticeWindow",			"SetChangeCostumeAvatarSucceess")
		RegistEnterEventInfo("Costume_Change_SuccessWIndow",		"CreateCostumeAvatarDone")
		RegistEnterEventInfo("Costume_Change_FailedNoChangeWIndow",	"CreateCostumeAvatarDone")
		RegistEnterEventInfo("Costume_Change_FailedWIndow",			"CreateCostumeAvatarDone")
		
		-- Ŭ���� â
		RegistEscEventInfo("CloneAvatarCleanUpMainImg"	,	"CleanUpWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarCleanUpMainImg",	"SendCleanupAvatarIndex")
		
		-- �и� â
		RegistEscEventInfo("CloneAvatarSeparate_MainImg",	"SeparateWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarSeparate_MainImg", "UseSeparateItem")
		
		-- �ѹ� â
		RegistEscEventInfo("CloneAvatarRollBack_MainImg",	"RollBackWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarRollBack_MainImg", "UseRollBackItem")
		
		--------------------------------------------------------------------
		-- �ִϸ��̼� ƽ
		--------------------------------------------------------------------
		g_AnimationTick = 0
				
		--------------------------------------------------------------------
		-- �ִϸ��̼� ���� �̹��� ������ pt
		--------------------------------------------------------------------
		g_BoomEffect_PosX = 166
		g_BoomEffect_PosY = 138
		
		--------------------------------------------------------------------
		-- �ִϸ��̼� ���� ȿ��
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Clone_Make_Effect")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("EndRender", "SpinEffectRender")
		root:addChildWindow(mywindow)
		function SpinEffectRender(args)
			local local_window		= CEGUI.toWindowEventArgs(args).window
			local _drawer			= local_window:getDrawer()
			--local Tick = g_AnimationTick % 8 + 1
			
			local tSpinAnimationX = { ['err'] = 0 , 184 , 289 , 394 , 499 , 604 , 709 , 814 , 919 }	
			
			--DebugStr("SpinDraw -> g_AnimationTick : " .. g_AnimationTick)
			if g_AnimationTick > 0 then
				_drawer:drawTextureWithScale_Angle_Offset("UIData/Avata.tga" , 167, 150, 105, 105, tSpinAnimationX[g_AnimationTick], 814,   300, 300, 255, 0, 8, 0,0)
			end
		end	-- end of function
		
		function StartSpinEffect()
			-- 1. �ִϸ��̼� ����
			ResetAnimation(1)
			
			-- 2. �ִ� ������ ���
			SetAnimationStart(1 , 1) -- arg1 -> 1 : ȸ�� / 2 : ����
									 -- arg2 -> 0 , 1 Ʈ�� �޽�

			-- 3. ����
			--PlayAnimationSound(1)
			PlayWave('sound/Clone_Spin.wav');
			
			winMgr:getWindow("Clone_Make_Effect"):setVisible(true)
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("Clone_Make_Effect")
		end
		
		function CloseSpinEffect()
			-- 1. �ִ� ������ ���
			SetAnimationStart(1 , 0) -- arg1 -> 1 : ȸ�� / 2 : ����
									 -- arg2 -> 0 , 1 Ʈ�� �޽�
			-- 2. �ִϸ��̼� ����
			ResetAnimation(1)
			
			winMgr:getWindow("Clone_Make_Effect"):setVisible(false)
			root:addChildWindow("Clone_Make_Effect")
		end
		
		
		--------------------------------------------------------------------
		-- �ִϸ��̼� ���� ȿ��
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Clone_Make_Effect2")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("EndRender", "BoomEffectRender")
		root:addChildWindow(mywindow)
		
		function BoomEffectRender(args)
			local local_window		= CEGUI.toWindowEventArgs(args).window
			local _drawer			= local_window:getDrawer()
			local Tick = g_AnimationTick % 8 + 1
			
			--DebugStr("BOOM_Tick : " .. g_AnimationTick)
			local tSpinAnimationX = { ['err'] = 0 , 184, 289 , 394 , 499 , 604 , 709 , 814 , 919 }
			
			if g_AnimationTick > 0 then
				_drawer:drawTextureWithScale_Angle_Offset("UIData/Avata.tga" , g_BoomEffect_PosX, g_BoomEffect_PosY, 105, 105, tSpinAnimationX[g_AnimationTick], 919,   300, 300, 255, 0, 8, 0,0)
			end
		end
		
		function StartBoomEffect(type)
			-- 1. �ִϸ��̼� ����
			ResetAnimation(2)
			
			-- 2. �ִ� ������ ���
			SetAnimationStart(2 , 1) -- arg1 -> 1 : ȸ��		/ 2 : ����
									 -- arg2 -> 0 : �ִ� ����	/ 1 : �ִ� ����
			-- 3. ����
			--PlayAnimationSound(2)
			
			-- 4. ��Ȳ�� �°� ���� ����Ʈ ��ġ �̵�
			winMgr:getWindow("Clone_Make_Effect2"):setVisible(true)
			if type == 0 then -- ����
				g_BoomEffect_PosX = 167
				g_BoomEffect_PosY = 139
				winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow("Clone_Make_Effect2")
				PlayWave('sound/Clone_Success.wav');
			elseif type == 1 then -- ����
				g_BoomEffect_PosX = 166
				g_BoomEffect_PosY = 108
				winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow("Clone_Make_Effect2")
				PlayWave('sound/Clone_Fail.wav');
			elseif type == 2 then -- ��ȭ����
				g_BoomEffect_PosX = 166
				g_BoomEffect_PosY = 138
				winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow("Clone_Make_Effect2")
				PlayWave('sound/Clone_NoChange1.wav');
				
				--[[
				local randNumber = GetRandNumber(2)
				if randNumber == 1 then
					PlayWave('sound/Clone_NoChange1.wav');
				elseif randNumber == 2 then
					PlayWave('sound/Clone_NoChange2.wav');
				end
				]]--
			end
		end
		
		function CloseBoomEffect()
			-- 1. �ִ� ������ ���
			SetAnimationStart(2 , 0) -- arg1 -> 1 : ȸ��		/ 2 : ����
									 -- arg2 -> 0 : �ִ� ����	/ 1 : �ִ� ����
			-- 2. �ִϸ��̼� ����
			ResetAnimation(2)
			
			winMgr:getWindow("Clone_Make_Effect"):setVisible(false)
			root:addChildWindow("Clone_Make_Effect")
		end
		
		function GetTick(time)
			--g_AnimationTick = g_AnimationTick + 1
			g_AnimationTick = time
			--DebugStr("GetTick -> g_AnimationTick : " .. g_AnimationTick)
		end
		
		
		
		
		--------------------------------------------------------------------
		-- ����. ��
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Costume_PopupAlpha');
		mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
		mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
		mywindow:setPosition(0,0);
		mywindow:setSize(1920, 1200)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow);

		----------------------------------------------------------------------
		-- ������ ����Ʈ ���� (����Ʈ�� ��ġ�̵��� ���� ����) : �����
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Make_Root")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition( (g_MAIN_WIN_SIZEX - 900)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
		mywindow:setSize(900 , 631)
		--mywindow:setSize(300 , 631)		
		mywindow:setWideType(6)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)


		----------------------------------------------------------------------
		-- ������ ����Ʈ ���� �� (����Ʈ�� ��ġ�̵��� ���� ����) : ����� ����
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Visual_Root")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
		mywindow:setSize(296 , 631)
		mywindow:setWideType(6)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)


		----------------------------------------------------------------------
		-- ������ ����Ʈ ���� �� (����Ʈ�� ��ġ�̵��� ���� ����) : Ŭ����
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Clean_Root")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
		mywindow:setSize(300, 450)
		mywindow:setWideType(6)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)
		
		----------------------------------------------------------------------
		-- ������ ����Ʈ ���� �� ����Ʈ�� ���� ( ������ ���� : �и� , �ѹ� , ��ȭ )
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_UseItem_Root")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
		mywindow:setSize(296 , 631)
		mywindow:setWideType(6)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)


		----------------------------------------------------------------------
		-- �ڽ�Ƭ �����̹���
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_AlphaImage")
		mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(0, 0)
		mywindow:setSize(1920, 1200)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		root:addChildWindow(mywindow)


		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� ������
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Change_MainWindow")
		mywindow:setTexture("Enabled",	"UIData/popup002.tga", 0, 247)
		mywindow:setTexture("Disabled",	"UIData/popup002.tga", 0, 247)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		--mywindow:setWideType(6);
		--mywindow:setPosition(100, 200)
		mywindow:setPosition(0, 0)
		mywindow:setSize(339 , 268)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		root:addChildWindow(mywindow)
		--winMgr:getWindow("Costume_Make_Root"):addChildWindow(mywindow)
		

		------------------------------------------------------------
		-- OK ��ư (���� OK��ư)
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Costume_Change_ConfirmButton")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 685, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 685, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 685, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 685, 560)
		
		mywindow:setTexture("Enabled",	"UIData/Avata.tga", 685, 560)
		mywindow:setTexture("Disabled", "UIData/Avata.tga", 685, 560)
		
		mywindow:setSize(89, 30)
		mywindow:setPosition(124, 220)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "CostumeChangeConfirmButtonEvent")
		winMgr:getWindow('Costume_Change_MainWindow'):addChildWindow(mywindow)

		-- �ڽ�Ƭ �ƹ�Ÿ ��ȯ �Լ�
		function CostumeChangeConfirmButtonEvent()
			if g_bNowItemIsSelected == true then 
				QuestionAvatarChange() 
				DebugStr("�ڽ�Ƭ ��ȯ ����")
			end
		end	


		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] Ȯ�� ����â
		-----------------------------------------------------------------------
		clonemessagewindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Change_NoticeWindow")
		clonemessagewindow:setTexture("Enabled",	"UIData/Avata.tga", 0, 268)
		clonemessagewindow:setTexture("Disabled",	"UIData/Avata.tga", 0, 268)
		clonemessagewindow:setWideType(6)
		clonemessagewindow:setPosition(380, 200)
		clonemessagewindow:setSize(339, 268)
		clonemessagewindow:setVisible(false)
		clonemessagewindow:setAlwaysOnTop(true)
		clonemessagewindow:setZOrderingEnabled(false)
		root:addChildWindow(clonemessagewindow)
		
		--------------------------------------------------------------------
		-- ���� Ȯ��, ��� "��ư" ��
		--------------------------------------------------------------------
		local tCostumePopupExitName  = {["protecterr"]=0, "Costume_Change_OKButtone", "Costume_Change_NOButtone" }
		local tCostumePopupExitTexX  = {['protecterr']=0,		774,			863}
		local tCostumePopupExitTexY  = {['protecterr']=0,		464,			464}
		local tCostumePopupExitPosX  = {['protecterr']=0,		63,				187}
		local tCostumePopupExitEvent = {["protecterr"]=0, "SetChangeCostumeAvatarSucceess", "SetChangeCostumeAvatarFailed" }

		for i=1, #tCostumePopupExitName do
			mywindow = winMgr:createWindow("TaharezLook/Button", tCostumePopupExitName[i])
			mywindow:setTexture("Normal",		"UIData/Avata.tga", tCostumePopupExitTexX[i] , tCostumePopupExitTexY[i])
			mywindow:setTexture("Hover",		"UIData/Avata.tga", tCostumePopupExitTexX[i] , tCostumePopupExitTexY[i] + 32)
			mywindow:setTexture("Pushed",		"UIData/Avata.tga", tCostumePopupExitTexX[i] , tCostumePopupExitTexY[i] + (32 * 2) )
			mywindow:setTexture("PushedOff",	"UIData/Avata.tga", tCostumePopupExitTexX[i] , tCostumePopupExitTexY[i] + (32 * 3) )
			
			mywindow:setTexture("Enabled",		"UIData/Avata.tga", tCostumePopupExitTexX[i] , 560 )
			mywindow:setTexture("Disabled",		"UIData/Avata.tga", tCostumePopupExitTexX[i] , 560 )
			
			mywindow:setPosition(tCostumePopupExitPosX[i], 222)
			mywindow:setSize(89, 32)
			mywindow:setVisible(true)
			
			if i == 1 then
				mywindow:setUserString("wndType", -1)
			end
			
			mywindow:setAlwaysOnTop(true)
			mywindow:setZOrderingEnabled(false)
			mywindow:subscribeEvent("Clicked", tCostumePopupExitEvent[i])
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow(mywindow)
		end
		
		

		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� ������
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Change_SuccessWIndow")
		mywindow:setTexture("Enabled",	"UIData/Avata.tga", 0 , 536)
		mywindow:setTexture("Disabled",	"UIData/Avata.tga", 0 , 536)
		mywindow:setWideType(6)
		mywindow:setPosition(380, 200)
		mywindow:setSize(339 , 268)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)

		--------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� ��ư ( ������ �ܰ� )
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Costume_Change_SuccessOKButton")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 685, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 685, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 685, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 685, 560)
		mywindow:setSize(89, 32)
		mywindow:setPosition(124, 0)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:subscribeEvent("Clicked", "CreateCostumeAvatarDone")
		winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow(mywindow)

		------------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ��û
		------------------------------------------------------------------------
		function SetChangeCostumeAvatarSucceess()
			-- ������ ��Ŷ �������� �ִϸ��̼��� ������
			-- �ִϸ��̼��� ������ ���� ó��
			StartSpinEffect()
			
			-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(false)
			
			--[[
			-- 1. ������ �ʿ���Ŷ ����
			RequestCreateCostumeAvatar()
			
			-- 2. ����â�� ����
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
			]]--
		end
		
		-- Ŭ�� �ƹ�Ÿ ��ȯ ���
		function ShowNotifyMakeCloneAvatar()
			-- 1. ������ �ʿ���Ŷ ����
			RequestCreateCostumeAvatar()
			
			-- 2. ����â�� ����
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
		end

		------------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] �ź�
		------------------------------------------------------------------------
		function SetChangeCostumeAvatarFailed()
			-- @ �˾�â�� ���� �ȴ�
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
			
			-- ��� ��ư Ȱ��ȭ
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			-- @ ��Ȱ��ȭ �� ��ư���� Ȱ��
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			SetUselessBtnEnable(true)
		end



		------------------------------------------------------------------------
		-- �ڽ�Ƭ �ƹ�Ÿ ��ȯ ���� (ClientCallBack.cpp)
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarSuccess()
			-- ����â ����
			root:addChildWindow(winMgr:getWindow("Costume_Change_SuccessWIndow"))
			winMgr:getWindow("Costume_Change_SuccessWIndow"):setVisible(true)		-- ����â ����
			
			-- Ȯ�� ��ư ����
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- ����â�� Ȯ�ι�ư ��ũ
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)		-- Ȯ�� ��ư
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(124, 222)	-- Ȯ�ι�ư ��ġ ����
			
			-- ������ �θ���
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- ���� ������ �̹���
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- ���� ����
			
			-- ���� ��ġ�� �缳��
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 111)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 111)
			
			
			-- Ŭ�� �ƹ�Ÿ ������� �������� ���� ��
			SetAvatarIcon("CostumeSelectItemImage2" , "CostumeSelectItemImage2" , -1 , g_ItemCloneAttach)
			
			DebugStr("Ŭ�� �ƹ�Ÿ�� ��ȯ ����!")
			
			g_NoChangeMessageNext = 0
			
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end
		------------------------------------------------------------------------
		-- �ڽ�Ƭ �ƹ�Ÿ ��ȯ ���� (ClientCallBack.cpp)
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarFailed()
			-- ����â ����
			root:addChildWindow(winMgr:getWindow("Costume_Change_FailedWIndow"))
			winMgr:getWindow("Costume_Change_FailedWIndow"):setVisible(true)		-- ����â ����
			
			-- Ȯ�� ��ư ����
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- ����â�� Ȯ�ι�ư ��ũ
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)			-- Ȯ�� ��ư
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(130, 325)		-- Ȯ�ι�ư ��ġ ����
				
			-- ������ �θ���
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- ���� ������ �̹���
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- ���� ����
			
			-- ���� ��ġ�� �缳��
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 81)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 81)
			
			g_NoChangeMessageNext = 0
			
			DebugStr("Ŭ�� �ƹ�Ÿ�� ��ȯ ����!")
			
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end
		
		g_NoChangeMessageNext = 0
		
		------------------------------------------------------------------------
		-- �ڽ�Ƭ �ƹ�Ÿ ��ȯ ���� �ƹ���ȭ���� �� 
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarNoChange()
			-- ����â ����
			root:addChildWindow(winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"))
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):setVisible(true)		-- ����â ����
			
			-- Ȯ�� ��ư ����
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- ����â�� Ȯ�ι�ư ��ũ
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)			-- Ȯ�� ��ư
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(125, 220)		-- Ȯ�ι�ư ��ġ ����
				
			-- ������ �θ���
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- ���� ������ �̹���
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- ���� ����
			
			-- ���� ��ġ�� �缳��
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 110)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 110)
			
			DebugStr("Ŭ�� �ƹ�Ÿ�� ��ȯ ����! ������ ��ȭ����")
						
			g_NoChangeMessageNext = 1 -- �޽����� ������ ��á�
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end

		function ConfirmBtnEnable(flag)
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(flag)
		end
		
		-- �ϵ��ڵ��� ���߿� �����ϰ���...
		function RadioButtonEnable()
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
		end

		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ������ �Լ�
		----------------------------------------------------------------------
		function CreateCostumeAvatarDone()
			-- @ ����Ʈ�� �� (Zen �⺻ Select)
			--winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			local MyZen = GetMyMoney()
			DebugStr("MyZen : " .. MyZen)
			local r,g,b = GetGranColor(MyZen)
			local granText = CommatoMoneyStr(MyZen)
			textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
			winMgr:getWindow("Costume_My_Money_Text"):setTextColor(r,g,b,255)	
			winMgr:getWindow("Costume_My_Money_Text"):setPosition(115 - textSize, 407)
			winMgr:getWindow("Costume_My_Money_Text"):setText(granText)
			
					
			-- @ ����â�� ����.
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			winMgr:getWindow("Costume_Change_SuccessWIndow"):setVisible(false)	-- ����â
			winMgr:getWindow("Costume_Change_FailedWIndow"):setVisible(false)	-- ����â
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):setVisible(false)	-- �ƹ���ȭ����â
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(false)
			
			-- @ ������ ���½������ �Ѵ�.
			--OnCostumeClickSelectCancle()
			
			-- @ Ȯ�� ��ư�� ȸ������ ��Ȱ��ȭ ���ش�.
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)	-- ���� ��Ȱ��ȭ
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			
			
			
			-- @ ������ �ڿ� �ִ� UI�� ������ ��ٴ�
			SetUselessBtnEnable(true)
			
			-- @ ����2�� '��ġ'�� '�θ�'�� �缳�� ���ش�
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(136 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(136 , 124)
			
			g_currenItemList = ITEMLIST_ZEN
			ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			
			-- ��� ��ư Ȱ��ȭ
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			if g_NoChangeMessageNext == 1 then
				ConfirmBtnEnable(true)
			end
			
			
			
			-- Old Code : BackUP
			if	winMgr:getWindow("CloneAvatar_Zen") ~= nil and
				winMgr:getWindow("CloneAvatar_Cash") ~= nil then
				-- �������� ������ ���� �״�� �̾��.
				if winMgr:getWindow("CloneAvatar_Zen"):isSelected() == true then
					-- �� �� ����
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "false")
					
					g_currenItemList = ITEMLIST_ZEN
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				else
					-- ĳ�� �� ����
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "false")
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
					
					g_currenItemList = ITEMLIST_CASH
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				end
			else
				-- ������ ��� Ȯ�ι�ư�� Ȱ��ȭ �����ش�.
				-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
				winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
				winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
				return
			end -- ~=nil then
			
			
			--[[
			if	winMgr:getWindow("MergeList_Zen") ~= nil and
				winMgr:getWindow("MergeList_Cash") ~= nil then
				-- �������� ������ ���� �״�� �̾��.
				if winMgr:getWindow("MergeList_Zen"):isSelected() == true then
					-- �� �� ����
					winMgr:getWindow("MergeList_Zen"):setProperty("Selected" , "true")
					winMgr:getWindow("MergeList_Cash"):setProperty("Selected" , "false")
					
					g_currenItemList = ITEMLIST_ZEN
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				else
					-- ĳ�� �� ����
					winMgr:getWindow("MergeList_Zen"):setProperty("Selected" , "false")
					winMgr:getWindow("MergeList_Cash"):setProperty("Selected" , "true")
					
					g_currenItemList = ITEMLIST_CASH
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				end
			else
				-- ������ ��� Ȯ�ι�ư�� Ȱ��ȭ �����ش�.
				-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
				winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
				winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
				return
			end -- ~=nil then
			]]--
			
			-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
		end


		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� â
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Change_FailedWIndow")
		mywindow:setTexture("Enabled",	"UIData/Avata.tga", 339 , 247)
		mywindow:setTexture("Disabled",	"UIData/Avata.tga", 339 , 247)
		mywindow:setWideType(6)
		mywindow:setPosition(380, 200)
		mywindow:setSize(339 , 461)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)
		
		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� â (�ƹ���ȭ ����) �ڡ�
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Change_FailedNoChangeWIndow")
		mywindow:setTexture("Enabled",	"UIData/Avata.tga", 685 , 196)
		mywindow:setTexture("Disabled",	"UIData/Avata.tga", 685 , 196)
		mywindow:setWideType(6)
		mywindow:setPosition(380, 200)
		mywindow:setSize(340 , 265)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		root:addChildWindow(mywindow)


		------------------------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ] �ݱ� ��ư "X��ư"
		------------------------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Costume_WindowClose")
		mywindow:setTexture("Normal",	"UIData/menu.tga",	197, 0)
		mywindow:setTexture("Hover",	"UIData/menu.tga",	197, 23)
		mywindow:setTexture("Pushed",	"UIData/menu.tga",	197, 46)
		mywindow:setTexture("PushedOff","UIData/menu.tga",	197, 0)
		mywindow:setSize(23, 23)
		mywindow:setPosition(310 , 10)
		mywindow:setEnabled(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "CostumeCloseEvent")
		winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow(mywindow)


		----------------------------------------------------------------------
		-- CostumeCloseEvent()
		-- [�ƹ�Ÿ �ڽ�Ƭ]�� ���õ� ���â�� �ݱ�
		----------------------------------------------------------------------
		function CostumeCloseEvent()
			VirtualImageSetVisible(false)
			
			winMgr:getWindow("Costume_My_Money_Text"):setVisible(false)
			winMgr:getWindow("Costume_My_Zen_Icon"):setVisible(false)
			
			--CloseCommonItemList()
			
			local CurrentWndType = GetCurrentWndType()
			if CurrentWndType == 12 then
				--DebugStr("������")
				winMgr:getWindow('MainBar_Bag'):setEnabled(true)
			end
			
			
			
			winMgr:getWindow('Popup_AlphaBackImg'):setVisible(false)
			
			winMgr:getWindow('Costume_Change_MainWindow'):setVisible(false)
			winMgr:getWindow('CostumeItemList'):setVisible(false)
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			winMgr:getWindow('Costume_Change_SuccessWIndow'):setVisible(false)
			winMgr:getWindow('Costume_Visual_Main'):setVisible(false)
			winMgr:getWindow('Costume_Change_NoticeWindow'):setVisible(false)
			winMgr:getWindow('Costume_Change_FailedWIndow'):setVisible(false)
			winMgr:getWindow('Costume_Change_FailedNoChangeWIndow'):setVisible(false)
			
			
			winMgr:getWindow('CloneAvatarCleanUpMainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarCleanUpOK'):setVisible(false)
			winMgr:getWindow('CloneAvatarCleanUpCancel'):setVisible(false)
			
			winMgr:getWindow('CloneAvatarRollBack_MainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarRollBack_OK'):setVisible(false)
			winMgr:getWindow('CloneAvatarRollBack_Cancel'):setVisible(false)
			
			winMgr:getWindow('CloneAvatarSeparate_MainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarSeparate_OK'):setVisible(false)
			winMgr:getWindow('CloneAvatarSeparate_Cancel'):setVisible(false)
			
			
			
			winMgr:getWindow('CloneAvatarCleanUpMainImg'):setVisible(false)
			winMgr:getWindow('Costume_Visual_SelectOKButton'):setVisible(false)
			
			
			winMgr:getWindow('Costume_Make_Root'):setVisible(false)
			winMgr:getWindow('Costume_Visual_Root'):setVisible(false)
			winMgr:getWindow('Costume_Clean_Root'):setVisible(false)
			winMgr:getWindow("Costume_UseItem_Root"):setVisible(false)
			
			
			-- @ ����2�� '��ġ'�� '�θ�'�� �缳�� ���ش�
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(140 , 124)
			
			
			winMgr:getWindow('Visual_SelectedToolTip'):setVisible(false)
			winMgr:getWindow('Visual_SelectedToolTipImage'):setVisible(false)
			
			for i=1, #CostumeItemButtonName do	
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(true)
			end
			
			-- ��� ��ư Ȱ��ȭ
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end			
			
			-- @ �޹���� ��ư���� Ȱ��ȭ
			SetUselessBtnEnable(true)
			DebugStr("OnCostumeClickSelectCancle() ȣ���1")
			OnCostumeClickSelectCancle()
			
			-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
			
			TownNpcEscBtnClickEvent()
		end
		
		function CostumeEscClose()
			VirtualImageSetVisible(false)
			
			winMgr:getWindow("Costume_My_Money_Text"):setVisible(false)
			winMgr:getWindow("Costume_My_Zen_Icon"):setVisible(false)
			
			
			--CloseCommonItemList()
			
			
			local CurrentWndType = GetCurrentWndType()
			if CurrentWndType == 12 then
				winMgr:getWindow('MainBar_Bag'):setEnabled(true)
				--DebugStr("������")
			end
			
			winMgr:getWindow('Popup_AlphaBackImg'):setVisible(false)
			
			winMgr:getWindow('Costume_Change_MainWindow'):setVisible(false)
			winMgr:getWindow('CostumeItemList'):setVisible(false)
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			winMgr:getWindow('Costume_Change_SuccessWIndow'):setVisible(false)
			winMgr:getWindow('Costume_Visual_Main'):setVisible(false)
			winMgr:getWindow('Costume_Change_NoticeWindow'):setVisible(false)
			winMgr:getWindow('Costume_Change_FailedWIndow'):setVisible(false)
			winMgr:getWindow('Costume_Change_FailedNoChangeWIndow'):setVisible(false)
			
			
			winMgr:getWindow('CloneAvatarCleanUpMainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarCleanUpOK'):setVisible(false)
			winMgr:getWindow('CloneAvatarCleanUpCancel'):setVisible(false)
			
			winMgr:getWindow('CloneAvatarRollBack_MainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarRollBack_OK'):setVisible(false)
			winMgr:getWindow('CloneAvatarRollBack_Cancel'):setVisible(false)
			
			
			winMgr:getWindow('CloneAvatarSeparate_MainImg'):setVisible(false)
			winMgr:getWindow('CloneAvatarSeparate_OK'):setVisible(false)
			winMgr:getWindow('CloneAvatarSeparate_Cancel'):setVisible(false)
			
			
			winMgr:getWindow('CloneAvatarCleanUpMainImg'):setVisible(false)
			winMgr:getWindow('Costume_Visual_SelectOKButton'):setVisible(false)
			
			
			winMgr:getWindow('Costume_Make_Root'):setVisible(false)
			winMgr:getWindow('Costume_Visual_Root'):setVisible(false)
			winMgr:getWindow('Costume_Clean_Root'):setVisible(false)
			winMgr:getWindow("Costume_UseItem_Root"):setVisible(false)
			
			
			-- @ ����2�� '��ġ'�� '�θ�'�� �缳�� ���ش�
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(140 , 124)
			
			
			-- ��� ��ư Ȱ��ȭ
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			winMgr:getWindow('Visual_SelectedToolTip'):setVisible(false)
			winMgr:getWindow('Visual_SelectedToolTipImage'):setVisible(false)
			
			for i=1, #CostumeItemButtonName do	
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(true)
			end
			
			-- Ȯ�� / ��� ��ư ��Ȱ��ȭ
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
			
			-- @ �޹���� ��ư���� Ȱ��ȭ
			SetUselessBtnEnable(true)
			DebugStr("OnCostumeClickSelectCancle() ȣ���22")
			OnCostumeClickSelectCancle()
		end


		----------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ] ������ ����Ʈ ��
		-----------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList")
		mywindow:setTexture("Enabled",	"UIData/deal.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(0 , 180);
		mywindow:setSize(296, 438)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		root:addChildWindow(mywindow)
		
		-- ����Ʈâ�� ��������
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_My_Zen_Icon")
		mywindow:setTexture("Enabled",	"UIData/mainBG_Button004.tga", 309 , 233)
		mywindow:setTexture("Disabled", "UIData/mainBG_Button004.tga", 309 , 233)
		mywindow:setPosition(10 , 405)
		mywindow:setSize(20 , 20)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		--root:addChildWindow(mywindow)
		winMgr:getWindow("CostumeItemList"):addChildWindow(mywindow)
		--winMgr:getWindow("CommonItemList"):addChildWindow(mywindow)
		
		-- ����Ʈâ�� �� ������ �ؽ�Ʈ
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_My_Money_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(40 , 407)
		mywindow:setAlign(8)
		mywindow:setSize(40, 20)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		--winMgr:getWindow("CommonItemList"):addChildWindow(mywindow)
		winMgr:getWindow("CostumeItemList"):addChildWindow(mywindow)
		root:addChildWindow(mywindow)


		------------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� ����â
		------------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Costume_Visual_Main")
		mywindow:setTexture("Enabled", "UIData/Avata.tga", 728 , 0)
		mywindow:setPosition(0 , 0)
		mywindow:setSize(296 , 193)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		root:addChildWindow(mywindow)



		--------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] Ȯ�� ��ư
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Costume_Visual_SelectOKButton")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 685, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 685, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 685, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 685, 560)
		mywindow:setTexture("Enabled",	"UIData/Avata.tga", 685, 560)
		mywindow:setTexture("Disabled", "UIData/Avata.tga", 685, 560)
		mywindow:setPosition(108, 400)
		mywindow:setSize(87, 30)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		--mywindow:subscribeEvent("Clicked", "SetCostumeVisual")
		mywindow:subscribeEvent("Clicked", "LastQuestionSetVisualAvatar")
		winMgr:getWindow("CostumeItemList"):addChildWindow(mywindow)


		--------------------------------------------------------------------
		-- [�ڽ�Ƭ �ƹ�Ÿ �����] ���� --> ������ ó��
		--------------------------------------------------------------------
		function SetCostumeVisual()
			-- @ Visual�ƹ�Ÿ �ε����� ����
			SaveVisualAvatarIndex()
			
			-- @ ��ȯâ�� ��ư Ŭ����
			winMgr:getWindow("Costume_Visual_Main"):setVisible(false)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setVisible(false)
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			
			-- @ ���� �̹��� Off
			winMgr:getWindow("Costume_AlphaImage"):setVisible(false)
			
			-- @ ��� ���� ����
			DebugStr("OnCostumeClickSelectCancle() ȣ���3")
			OnCostumeClickSelectCancle()
				
			-- @ Ŭ��,����� �ƹ�Ÿ �ε����� ������ ����
			RequestSetVisualCostumeAvatar()
			
			-- @ ���� �缳��
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setVisible(false)
			winMgr:getWindow("CostumeSelectItemImage3"):setVisible(false)
			
			-- @ ����Ʈâ �������� ����X
			g_bNowItemIsSelected = false
			
			-- @ ����Ʈ ��� �ݱ�
			CostumeCloseEvent()	
		end


		-- ��ų ���� �׵θ� 
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemSkillLevelImage")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(170, 168)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Change_MainWindow'):addChildWindow(mywindow)


		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeSelectItemSkillLevelText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(9, 1)
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		winMgr:getWindow("CostumeSelectItemSkillLevelImage"):addChildWindow(mywindow)


		-- ���� ��� ��ư
		mywindow = winMgr:createWindow("TaharezLook/Button", "CostumeSelectCancelBtn");	
		mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 1008, 0)
		mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 1008, 16)
		mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 1008, 32)
		mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 1008, 32)
		mywindow:setPosition(185, 117)
		mywindow:setSize(16, 16);
		mywindow:setVisible(false);
		mywindow:setZOrderingEnabled(false);
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "OnCostumeClickSelectCancle");


		-- ���õ� ������ ���
		function OnCostumeClickSelectCancle()
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			ResetCloneSelectItemInfo()
			ClearCostumeSelectItem()
		end


		-- ������ ��� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSealItemImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(140, 124)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Change_MainWindow'):addChildWindow(mywindow)





		--=======================================
		-- ���� ������ �̹��� ��
		-- ���� ���� ����
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(140, 124)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Change_MainWindow'):addChildWindow(mywindow)
		--=======================================
		-- ���� ����â ��
		-- ���� ���� ����
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemToolTipImage")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(138, 124)
		mywindow:setSize(64, 64)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CostumeSelectItemListInfo")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
		winMgr:getWindow('Costume_Change_MainWindow'):addChildWindow(mywindow)
		--===================================================
		-- ���� ������ �̹���2 �� 
		-- [�ڽ�Ƭ �ƹ�Ÿ �����]���� ���.
		-- [CostumeSelectItemImage]�� ��� ������ ��ġ�ؾ��Ѵ�
		--===================================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemImage2")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
		mywindow:setPosition(140, 124)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Change_NoticeWindow'):addChildWindow(mywindow)
		--===================================================
		-- ���� ����â2 ��
		-- [�ڽ�Ƭ �ƹ�Ÿ �����]���� ���.
		-- [CostumeSelectItemToolTipImage]�� ��� ������ ��ġ�ؾ��Ѵ�
		--===================================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemToolTipImage2")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(138, 124)
		mywindow:setSize(64, 64)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CostumeSelectItemListInfo")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
		--===================================================
		-- ���� ����â2 ��
		-- [�ڽ�Ƭ �ƹ�Ÿ �����]���� ���.
		-- �޹�� ��µ� �����.
		--===================================================
		winMgr:getWindow('Costume_Change_NoticeWindow'):addChildWindow(mywindow)
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemImage2_Back")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
		mywindow:setPosition(140, 124)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Change_NoticeWindow'):addChildWindow(mywindow)





		--=======================================
		-- ���� ������ �̹���3 �� [LEFT]
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemImage3")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
		mywindow:setPosition(40, 100)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Visual_Main'):addChildWindow(mywindow)
		--=======================================
		-- ���� ����â3 ��
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSelectItemToolTipImage3")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(0, 100)
		mywindow:setVisible(false)
		mywindow:setSize(64, 64)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CostumeSelectItemListInfo")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
		winMgr:getWindow('Costume_Visual_Main'):addChildWindow(mywindow)
		--=======================================
		-- ���� ������ �̹���4 �� [RIGHT]
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Visual_SelectedToolTipImage")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
		mywindow:setPosition(195,100)
		mywindow:setSize(128, 128)
		mywindow:setScaleWidth(138)
		mywindow:setScaleHeight(138)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('Costume_Visual_Main'):addChildWindow(mywindow)
		--=======================================
		-- ���� ����â4 ��
		--=======================================
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Visual_SelectedToolTip")
		mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(195,100)
		mywindow:setVisible(false)
		mywindow:setSize(64, 64)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectedCostumeAvatar") -- 4������ �Լ��� ���� ó��.
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
		winMgr:getWindow('Costume_Visual_Main'):addChildWindow(mywindow)



		-- ����4������ ����ϴ� �����Լ�
		-- Visual_SelectedToolTip
		function OnMouseEnter_SelectedCostumeAvatar(args)
			-- ���� ����ش�.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			--DebugStr("���� ������ ��� : " .. g_nNowSelectedCostumeMode)
			local itemKind, itemNumber = GetVisualModeRightToolTipInfo()
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- �������� ���� �Ǿ� ���� �ʴ� ��
				DebugStr("���õ� ���� �̹��� ���ϴ���")
				return
			end
			
			g_bNowItemIsSelected = true			-- �������� ���� �Ǿ� �ִ�.��

			itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
			
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
			
			GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
			SetShowToolTip(true)

		end



		-- Ŭ�� �ƹ�Ÿ ���� ���� 
		function OnMouseEnter_CostumeAvatarItemInfo(args)
			-- ���� ����ش�.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			-- ���� ���õ� �����츦 ã�´�.
			local index = tonumber(EnterWindow:getUserString("CostumeRadioIndex"))
			index = index - 1
			
			local itemKind, itemNumber = GetCostumeTooltipInfo(WINDOW_MYITEM_LIST , index)
			itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- �������� ���� �Ǿ� ���� �ʴ� ��
				DebugStr("����")
				return
			end
			
			g_bNowItemIsSelected = true			-- �������� ���� �Ǿ� �ִ�.��

				
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
			
			--GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
			--DebugStr("g_ItemSlot : " .. g_ItemSlot)
			GetToolTipBaseInfo(x + 50, y, 2, Kind, g_ItemSlot, itemNumber, 2)	-- ������ ���� ������ �������ش�.
			SetShowToolTip(true)
		end



		function OnMouseEnter_CostumeSelectItemListInfo(args)
			-- ���� ����ش�.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			--DebugStr("���� ������ ��� : " .. g_nNowSelectedCostumeMode)
			local itemKind, itemNumber = GetSelectCostumeAvatarTooltipInfo(g_nNowSelectedCostumeMode)
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- �������� ���� �Ǿ� ���� �ʴ� ��
				DebugStr("���õ� ���� �̹��� ���ϴ���")
				return
			end
			
			g_bNowItemIsSelected = true			-- �������� ���� �Ǿ� �ִ�.��

			itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
			
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
			
			GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
			SetShowToolTip(true)
		end



		function SetUselessBtnEnable(bFlag)
			for i=1 , 5 do
				winMgr:getWindow("CloneItemButton_" .. i):setEnabled(bFlag)
			end
			
			winMgr:getWindow("Costume_WindowClose"):setEnabled(bFlag)
			winMgr:getWindow("Costume_Zen"):setEnabled(bFlag)
			winMgr:getWindow("Costume_Cash"):setEnabled(bFlag)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setEnabled(bFlag)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setEnabled(bFlag)
		end



		----------------------------------------------------------------------
		-- QuestionAvatarChange()
		-- Ŭ�� �ƹ�Ÿ ��ȯ�� �ٽ� �ѹ� ���������� ���
		----------------------------------------------------------------------
		function QuestionAvatarChange()
			local MyMoney = GetMyMoney()
			if MyMoney < 50000 then
				ShowNotifyOKMessage_Lua(PreCreateString_9)	--GetSStringInfo(LAN_SHORT_MONEY)
				CreateCostumeAvatarDone()
				return				
			end
			
			
			-- ��� ��ư ��Ȱ��ȭ
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(false)
			end
			
			-- ����â �缳��
			winMgr:getWindow("Costume_Make_Root"):setAlwaysOnTop(false)

			-- @ ����2 ��ġ �缳��
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138 , 123)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 123)
			
			-- @ �ƹ�Ÿ ��ȯ�� ����� ����â
			root:addChildWindow(winMgr:getWindow("Costume_Change_NoticeWindow"))
			winMgr:getWindow("Costume_Change_NoticeWindow"):setAlwaysOnTop(true)	
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(true)
			
			-- @ YES , NO ��ư ����
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(true)
			
			-- @ ������� �ʴ� ��ư�� ��� ��ٴ�
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			SetUselessBtnEnable(false)	-- ����Ʈâ �� ��Ÿ ��ư���� ��Ȱ��ȭ
		end


		----------------------------------------------------------------------
		-- ChageCloneDisagree() - ����ϴ°��� ����. Ȯ���غ��߾�.. �ڡ� -
		-- Ŭ�� �ƹ�Ÿ ���� ������ Cancel��ư Ŭ���� ȣ�� �Լ�
		----------------------------------------------------------------------
		function ChageCloneDisagree()
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_ConfirmButton"):setVisible(false)
			winMgr:getWindow("ChangeCloneCancelBtn"):setVisible(false)
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(false)
		end


		----------------------------------------------------------------------
		-- CloneCancelBtnEvent()
		-- �ƹ�Ÿ�� Ŭ�� �ƹ�Ÿ�� ��ȯ ���� �Լ�
		----------------------------------------------------------------------
		function CloneCancelBtnEvent()
			winMgr:getWindow('Costume_Change_MainWindow'):setVisible(false)
			winMgr:getWindow('CostumeItemList'):setVisible(false)
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			
			for i=1, #CostumeItemButtonName do	
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(true)
			end
			
			OnCostumeClickSelectCancle()
			--ClearCostumeSelectItem()
			--ResetCloneSelectItemInfo()
		end

		-----------------------------------------------------------------------
		--�ڽ�Ƭ , ��ų , ��Ÿ  , �����
		-----------------------------------------------------------------------
		CostumeItemButtonName		= {["protecterr"]=0, "Costume_Zen", "Costume_Cash" }
		CostumeItemButtonTextPosX	= {['err'] = 0, 0, 70 }
		CostumeItemButtonTextPosY	= {['err'] = 0, 455, 476, 497}
		CostumeItemButtonEvent		= {["err"]=0, "Select_CostumeAvatar_Zen","Select_CostumeAvatar_Cash" }

		for i=1, #CostumeItemButtonName do	
			mywindow = winMgr:createWindow("TaharezLook/RadioButton",	CostumeItemButtonName[i]);	
			
			mywindow:setTexture("Normal",			"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[1]);
			mywindow:setTexture("Hover",			"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[2]);
			mywindow:setTexture("Pushed",			"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);
			mywindow:setTexture("PushedOff",		"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);	
			mywindow:setTexture("SelectedNormal",	"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);
			mywindow:setTexture("SelectedHover",	"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);
			mywindow:setTexture("SelectedPushed",	"UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);
			mywindow:setTexture("SelectedPushedOff","UIData/deal.tga",	CostumeItemButtonTextPosX[i], CostumeItemButtonTextPosY[3]);
			mywindow:setTexture("Disabled",			"UIData/invisible.tga",	190, 706);
			mywindow:setSize(70, 21);	
			mywindow:setPosition((72*i)-68,39);
			mywindow:setAlwaysOnTop(true)
			mywindow:setVisible(true);
			mywindow:setEnabled(true)
			mywindow:subscribeEvent("SelectStateChanged", CostumeItemButtonEvent[i]);
			winMgr:getWindow('CostumeItemList'):addChildWindow( winMgr:getWindow(CostumeItemButtonName[i]) );
		end


		-----------------------------------------------------------------------
		--��� , �ƹ�Ÿ ( �ƹ�Ÿ �ڽ�Ƭ �� )
		-----------------------------------------------------------------------
		CostumeAvatarButtonName		= {["protecterr"] = 0 , "CloneAvatar_Zen" , "CloneAvatar_Cash" }
		CostumeAvatarButtonTexPosX	= {['err'] = 0, 377 , 601 }
		CostumeAvatarButtonPosX		= {['err'] = 0, 5 , 5+63 }
		CostumeAvatarButtonEvent	= {["err"] = 0, "Select_CostumeAvatar_Zen" , "Select_CostumeAvatar_Cash" }

		for i=1, #CostumeAvatarButtonName do	
			mywindow = winMgr:createWindow("TaharezLook/RadioButton",	CostumeAvatarButtonName[i]);	
			mywindow:setTexture("Normal",			"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 577);
			mywindow:setTexture("Hover",			"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 600);
			mywindow:setTexture("Pushed",			"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 623);
			mywindow:setTexture("PushedOff",		"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 577);	
			mywindow:setTexture("SelectedNormal",	"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 623);
			mywindow:setTexture("SelectedHover",	"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 623);
			mywindow:setTexture("SelectedPushed",	"UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 623);
			mywindow:setTexture("SelectedPushedOff","UIData/Match002.tga",	CostumeAvatarButtonTexPosX[i], 623);
			mywindow:setTexture("Disabled",			"UIData/invisible.tga",	190, 706);
			mywindow:setSize(56, 23);	
			mywindow:setPosition(CostumeAvatarButtonPosX[i] , 35);
			mywindow:setAlwaysOnTop(true)
			mywindow:setVisible(false);
			mywindow:setEnabled(true)
			mywindow:subscribeEvent("SelectStateChanged", CostumeAvatarButtonEvent[i]);
			winMgr:getWindow('CostumeItemList'):addChildWindow( winMgr:getWindow(CostumeAvatarButtonName[i]) );
		end



		------------------------------------
		--���ڽ�Ƭ����------------------
		------------------------------------
		function Select_CostumeAvatar_Zen(args)
			local local_window = CEGUI.toWindowEventArgs(args).window;
			
			if CEGUI.toRadioButton(local_window):isSelected() then
				local find_window = winMgr:getWindow('Costume_Zen');
				if find_window ~= nil then
					if g_nNowSelectedCostumeMode == MODE_CHANGE_COSTUME then
						g_currenItemList = ITEMLIST_ZEN
						ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
					elseif g_nNowSelectedCostumeMode == MODE_SELECT_VISUAL then
						g_currenItemList = ITEMLIST_ZEN
						ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
					elseif g_nNowSelectedCostumeMode == MODE_USE_CLEANUP then
						if g_nCleanUpMode == 1 then	-- ��ȭ
							g_currenItemList = ITEMLIST_POLLUTION_ZEN_AVATAR -- 4
							ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode) -- 2
						end
						if g_nCleanUpMode == 2 then -- �и�
							g_currenItemList = ITEMLIST_POLLUTION_ZEN_AVATAR	-- 4
							ChangedCostumeItemList(g_currenItemList , 3)		-- 3
						end
					end	-- end of if
				end	-- end of if
			end	-- end of if
		end	-- end of function
		


		------------------------------------
		--ĳ���ڽ�Ƭ�����ۼ���------------------
		------------------------------------
		function Select_CostumeAvatar_Cash(args)
			local local_window = CEGUI.toWindowEventArgs(args).window;
			
			if CEGUI.toRadioButton(local_window):isSelected() then
				local find_window = winMgr:getWindow('Costume_Cash');
				if find_window ~= nil then
					if g_nNowSelectedCostumeMode == MODE_CHANGE_COSTUME then
						g_currenItemList = ITEMLIST_CASH
						ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
					
					elseif g_nNowSelectedCostumeMode == MODE_SELECT_VISUAL then
						g_currenItemList = ITEMLIST_CASH
						ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
					elseif g_nNowSelectedCostumeMode == MODE_USE_CLEANUP then
						if g_nCleanUpMode == 1 then	-- ��ȭ
							g_currenItemList = ITEMLIST_POLLUTION_CASH_AVATAR -- 5
							ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode) -- 2
						end
						
						if g_nCleanUpMode == 2 then -- �и�
							g_currenItemList = ITEMLIST_POLLUTION_CASH_AVATAR	-- 5
							ChangedCostumeItemList(g_currenItemList , 3)		-- 3
						end
					end	-- end of if
				end	
			end	
		end




		-----------------------------------------------------------------------
		-- ������Ŭ�� ��� â ������ư
		-----------------------------------------------------------------------
		tCostumeItemRadio =
		{ ["protecterr"]=0, "CostumeItemList_1", "CostumeItemList_2", "CostumeItemList_3", "CostumeItemList_4", "CostumeItemItemList_5"}

		for i=1, #tCostumeItemRadio do	
			mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tCostumeItemRadio[i]);	
			mywindow:setTexture("Normal",			"UIData/deal.tga",		296,583 );
			mywindow:setTexture("Hover",			"UIData/deal.tga",		296,583);
			mywindow:setTexture("Pushed",			"UIData/deal.tga",		296,583);
			mywindow:setTexture("PushedOff",		"UIData/deal.tga",		296,583);	
			mywindow:setTexture("SelectedNormal",	"UIData/deal.tga",		296,583);
			mywindow:setTexture("SelectedHover",	"UIData/deal.tga",		296,583);
			mywindow:setTexture("SelectedPushed",	"UIData/deal.tga",		296,583);
			mywindow:setTexture("SelectedPushedOff","UIData/deal.tga",		296,583);
			mywindow:setTexture("Disabled",			"UIData/deal.tga",		296,583);
			mywindow:setSize(282, 52);
			mywindow:setPosition(7, 65+(i-1)*55);
			mywindow:setVisible(true);
			mywindow:setUserString('index', tostring(i))
			mywindow:setEnabled(true)
			winMgr:getWindow('CostumeItemList'):addChildWindow( winMgr:getWindow(tCostumeItemRadio[i]) );
			
			-- ������ �̹���
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList_Image_"..i)
			mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
			mywindow:setPosition(0, 0)
			mywindow:setSize(128, 128)
			mywindow:setScaleWidth(120)
			mywindow:setScaleHeight(120)
			mywindow:setAlwaysOnTop(true)
			mywindow:setEnabled(false)
			mywindow:setLayered(false)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
			
			-- ����� �ƹ�Ÿ�� �ö� �̹��� ��
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList_Visual_Avatar_Image_"..i)
			mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setPosition(3, 3)
			mywindow:setSize(128, 128)
			mywindow:setScaleWidth(102)
			mywindow:setScaleHeight(102)
			mywindow:setAlwaysOnTop(true)
			mywindow:setEnabled(false)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
			
					
			-- ������ ��� �̹���
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeSealItemImage_"..i)
			mywindow:setTexture("Enabled",	"UIData/ItemUIData/Skill_Lock.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
			mywindow:setTexture("Layered",	"UIData/ItemUIData/Skill_Lock.tga", 0, 0)
			mywindow:setPosition(0, 0)
			mywindow:setSize(128, 128)
			mywindow:setScaleWidth(102)
			mywindow:setScaleHeight(102)
			mywindow:setAlwaysOnTop(true)
			mywindow:setEnabled(false)
			mywindow:setLayered(false)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
			
			-- ������ �ƹ�Ÿ�� ��� �̹��� ��
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList_Pollution_Image_"..i)
			mywindow:setTexture("Enabled",	"UIData/Match002.tga", 667, 886)
			mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 886)
			mywindow:setPosition(2, 2)
			mywindow:setSize(48, 48)
			mywindow:setScaleHeight(230)
			mywindow:setScaleWidth(230)
			mywindow:setAlwaysOnTop(true)
			mywindow:setEnabled(false)
			mywindow:setLayered(false)
			mywindow:setVisible(false)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)

			-- ��ų ���� �׵θ� �̹���
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList_SkillLevelImage_"..i)
			mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setProperty("FrameEnabled", "False")
			mywindow:setProperty("BackgroundEnabled", "False")
			mywindow:setPosition(25, 32)
			mywindow:setSize(29, 16)
			mywindow:setAlwaysOnTop(true)
			mywindow:setEnabled(false)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)


			-- ��ų���� + ����
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_SkillLevelText_"..i)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setTextColor(255,255,255,255)
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
			mywindow:setPosition(31, 32)
			mywindow:setSize(40, 20)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow("CostumeItemList_Image_"..i):addChildWindow(mywindow)
			

			-- ���� �̺�Ʈ�� ���� �̹���
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeItemList_EventImage_"..i)
			mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setProperty("FrameEnabled", "False")
			mywindow:setProperty("BackgroundEnabled", "False")
			mywindow:setPosition(0, 0)
			mywindow:setSize(52, 52)
			mywindow:setAlwaysOnTop(true)
			mywindow:setZOrderingEnabled(false)
			--mywindow:setUserString("CloneRadioIndex", i)
			mywindow:setUserString("CostumeRadioIndex", i)
			mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CostumeAvatarItemInfo")
			mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
				
			
			-- ������ �̸�
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_Name_"..i)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setTextColor(255,200,50,255)
			mywindow:setText("")
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setPosition(60, 2)
			mywindow:setSize(220, 20)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
			
			-- ������ ����
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_Num_"..i)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setTextColor(150,150,150,255)
			mywindow:setText("")
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setPosition(60, 17)
			mywindow:setSize(220, 20)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
			
			-- ������ �Ⱓ
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_Period_"..i)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setTextColor(150,150,150,255)
			mywindow:setText("")
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setPosition(60, 32)
			mywindow:setSize(220, 20)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow(tCostumeItemRadio[i]):addChildWindow(mywindow)
		end

		----------------------------------------------------------------------
		--������ ����Ʈ ÷�� ��ư 5��
		-----------------------------------------------------------------------
		tCostumeItemButton =
		{ ["protecterr"]=0, "CostumeItemButton_1", "CostumeItemButton_2", "CostumeItemButton_3", "CostumeItemButton_4", "CostumeItemButton_5"}

		for i=1, #tCostumeItemButton do	
			mywindow = winMgr:createWindow("TaharezLook/Button",	tCostumeItemButton[i]);	
			mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
			mywindow:setTexture("Normal",	"UIData/deal.tga", 0, 518)
			mywindow:setTexture("Hover",	"UIData/deal.tga", 0, 536)
			mywindow:setTexture("Pushed",	"UIData/deal.tga", 0, 554)
			mywindow:setTexture("PushedOff","UIData/deal.tga", 0, 518)
			
			mywindow:setTexture("Enabled",	"UIData/deal.tga", 0, 572)
			mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 572)
			
			mywindow:setSize(63,18 );	
			mywindow:setPosition(220,95+(i-1)*54);
			mywindow:setAlwaysOnTop(true)
			mywindow:setVisible(false);
			mywindow:setUserString('CostumeIndex', tostring(i));
			mywindow:setEnabled(true)
			mywindow:subscribeEvent("Clicked", "tCostumeItemButtonEvent")
			winMgr:getWindow('CostumeItemList'):addChildWindow( winMgr:getWindow(tCostumeItemButton[i]));
		end


		function ShowSelectCostumeAvatarList()	-- Ŭ�� �ƹ�Ÿ ���� ���� ��		
			-- CostumeItemList : �ƹ�Ÿ ����Ʈâ
			winMgr:getWindow("CostumeItemList"):setVisible(true)
		
			for i=1, #CostumeItemButtonName do
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(false)
			end
			
			
			if ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART then				-- ����� �����ϴ� �κ�
				DebugStr("����� �����ϴ� �κ�");
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(true)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(true)
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_MAKE then		-- �ƹ�Ÿ ����� �κ�
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(true)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(true)
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_CLEANUP then
				if g_nCleanUpMode == 1 then			-- ��ȭ ������ ���
					winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
					DebugStr("��ȭ ������ ���°� ����")
				elseif g_nCleanUpMode == 2 then	-- �и� ������ ���
					winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
					DebugStr("�и� ������ ���°� ����")
				end
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_ROOL_BACK then
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
				DebugStr("�ѹ� ������ ���°� ����")
			end
			
			-- ������ �ٽ� �ҷ�����
			ReloadCostumeAvatar()
		end


		function CloseCostumeItemList()
			DebugStr('CloseCostumeItemList()')
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setVisible(false)
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('Costume_AlphaImage') );
		end


		-----------------------------------------------------------------------
		-- Ŭ�� ������ �̸� �����̸� �������� ����
		-----------------------------------------------------------------------
		function SetupCostumeItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade , avatarTypeValue , attach)
			local j=i+1
			
			winMgr:getWindow(tCostumeItemRadio[j]):setVisible(true)
			winMgr:getWindow(tCostumeItemButton[j]):setVisible(true)
			winMgr:getWindow("CostumeSealItemImage_"..j):setVisible(false)
			winMgr:getWindow("CostumeItemList_Pollution_Image_" .. j):setVisible(false)
			
			if avatarTypeValue > 0 then			-- ����� ������ Ŭ�� �ƹ�Ÿ<- �и�
				-- ������ ����
				SetItemListAvatarIconS("CostumeItemList_Image_" ,"CostumeItemList_Visual_Avatar_Image_" ,
										j , avatarTypeValue , attach )
				
				-- ������ �� ���� �ε����� ����
				g_ItemSlot = -6
			elseif avatarTypeValue == -1 then	-- pure Ŭ�� �ƹ�Ÿ			<- �ѹ�
				-- ������ ����
				SetItemListAvatarIconS("CostumeItemList_Image_" ,"CostumeItemList_Image_" ,
										j , avatarTypeValue , attach )
				-- ������ �� ���� �ε����� ����
				g_ItemSlot = -7
			elseif avatarTypeValue == -2 then	-- ������ �ƹ�Ÿ			<- ��ȭ
				winMgr:getWindow("CostumeItemList_Pollution_Image_" .. j):setVisible(true)
				
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleWidth(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleHeight(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
			else -- �Ϲ� �ƹ�Ÿ
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleWidth(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleHeight(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
				
				g_ItemSlot = 0
			end
	
			
			-- ĳ�� �ƹ�Ÿ Ȳ�� �׵θ�
			if itemFileName2 == "" then
				winMgr:getWindow("CostumeItemList_Image_"..j):setLayered(false)
			else
				winMgr:getWindow("CostumeItemList_Image_"..j):setLayered(true)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Layered", itemFileName2, 0, 0)
			end	
			
			-- ������ ��� üũ
			if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
				winMgr:getWindow("CostumeSealItemImage_"..j):setVisible(true)
			end
			
			-- ������ ���
			if itemGrade > 0 then
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setVisible(true)
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
				winMgr:getWindow( "CostumeItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
				winMgr:getWindow( "CostumeItemList_SkillLevelText_"..j):setText("+"..itemGrade)
			else
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setVisible(false)
				winMgr:getWindow("CostumeItemList_SkillLevelText_"..j):setText("")
			end
			
			-- ������ �̸�
			winMgr:getWindow("CostumeItemList_Name_"..j):setText(itemName)
			
			-- ������ ����
			local countText = CommatoMoneyStr(itemUseCount)
			local szCount = g_STRING_AMOUNT.." : "..countText
			winMgr:getWindow("CostumeItemList_Num_"..j):setText(szCount)
			
			-- ������ �Ⱓ
			local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
			winMgr:getWindow("CostumeItemList_Period_"..j):setText(period)		
		end




		------------------------------------
		---������ǥ���ؽ�Ʈ
		------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_PageText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
		mywindow:setPosition(110, 380)
		mywindow:setSize(80, 20)
		mywindow:setViewTextMode(1)
		mywindow:setAlign(8)
		mywindow:setLineSpacing(2)
		mywindow:clearTextExtends()
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('CostumeItemList'):addChildWindow(mywindow)


		------------------------------------
		---�������յڹ�ư
		------------------------------------
		local tMyCostumeItemList_BtnName  = {["err"]=0, [0]="MyCostumeItemList_LBtn", "MyCostumeItemList_RBtn"}
		local tMyCostumeItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
		local tMyCostumeItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
		local tMyCostumeItemList_BtnEvent = {["err"]=0, [0]= "OnClickCostumeItemList_PrevPage", "OnClickCostumeItemList_NextPage"}
		for i=0, #tMyCostumeItemList_BtnName do
			mywindow = winMgr:createWindow("TaharezLook/Button",	tMyCostumeItemList_BtnName[i])
			mywindow:setTexture("Normal",	"UIData/myinfo.tga",	tMyCostumeItemList_BtnTexX[i], 0)
			mywindow:setTexture("Hover",	"UIData/myinfo.tga",	tMyCostumeItemList_BtnTexX[i], 22)
			mywindow:setTexture("Pushed",	"UIData/myinfo.tga",	tMyCostumeItemList_BtnTexX[i], 44)
			mywindow:setTexture("PushedOff","UIData/myinfo.tga",	tMyCostumeItemList_BtnTexX[i], 0)
			mywindow:setPosition(tMyCostumeItemList_BtnPosX[i], 378)
			mywindow:setSize(17, 22)
			mywindow:setSubscribeEvent("Clicked", tMyCostumeItemList_BtnEvent[i])
			winMgr:getWindow('CostumeItemList'):addChildWindow(mywindow)
		end
		---------------------------------------------------
		-- CloneItemList ���� ������ / �ִ� ������
		---------------------------------------------------
		function CostumeItemListPage(curPage, maxPage)
			g_curPage_CloneItemList = curPage
			g_maxPage_CloneItemList = maxPage
			
			winMgr:getWindow("CostumeItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
			--winMgr:getWindow("MergeItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
		end

		------------------------------------
		---�����������̺�Ʈ-------------------
		------------------------------------
		function  OnClickCostumeItemList_PrevPage()
			--DebugStr("11")
			if g_curPage_CloneItemList > 1 then
				g_curPage_CloneItemList = g_curPage_CloneItemList - 1
				ChangedCostumeItemListCurrentPage(g_curPage_CloneItemList , g_nNowSelectedCostumeMode)
			end
			
		end

		------------------------------------
		---�����������̺�Ʈ-----------------
		------------------------------------
		function OnClickCostumeItemList_NextPage()
			DebugStr("22")
			if g_curPage_CloneItemList < g_maxPage_CloneItemList then
				g_curPage_CloneItemList = g_curPage_CloneItemList + 1
				ChangedCostumeItemListCurrentPage(g_curPage_CloneItemList , g_nNowSelectedCostumeMode)
			end
			
		end


		function ClearCostumeItemList()
			DebugStr('ClearCostumeItemList()')
		    
			for i=1, 5 do
				winMgr:getWindow(tCostumeItemRadio[i]):setVisible(false)
				winMgr:getWindow(tCostumeItemButton[i]):setVisible(false)
				winMgr:getWindow("CostumeItemList_Pollution_Image_" .. i):setVisible(false)
				winMgr:getWindow("CostumeItemList_Visual_Avatar_Image_" .. i):setVisible(false)
				
			end
		end

		
		--------------------------
		-- ��� ��ư
		--------------------------
		function tCostumeItemButtonEvent(args)	
			-- 'Ȯ��'��ư ���� ���������� ���� �� [�ڽ�Ƭ �ƹ�Ÿ �����]
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			
			-- Ȯ�ι�ư Ȱ��ȭ �� ���� ���� [�ڽ�Ƭ �ƹ�Ÿ ���� �����ϱ�]
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setEnabled(true)
			
			-- ������ �ε��� �޾ƿ���
			local index = CEGUI.toWindowEventArgs(args).window:getUserString("CostumeIndex")
			--local index = CEGUI.toWindowEventArgs(args).window:getUserString("RegBtnIndex")
			index = index - 1
			
			
			-- ������ ����� ������ ���� �ε��� ����
			local bEnable = SelectCostumeItem(index , g_nNowSelectedCostumeMode)
						
			if bEnable then
				g_bNowItemIsSelected = true;	-- �������� ���� �Ǿ���
				SelectCostumeToolTipImage()		-- ������ �̹����� �����Ѵ�
				winMgr:getWindow("CostumeSelectCancelBtn"):setVisible(true)
			end
			
				
			-- ������ �ൿ�� ����
			if g_nNowSelectedCostumeMode == MODE_CHANGE_COSTUME then
				winMgr:getWindow("CostumeSelectItemImage"):setVisible(true)
				winMgr:getWindow("CostumeSelectItemToolTipImage"):setVisible(true)
				winMgr:getWindow("CostumeSelectItemImage"):setPosition(138 , 82)
				winMgr:getWindow("CostumeSelectItemToolTipImage"):setPosition(138, 82)
			
			elseif g_nNowSelectedCostumeMode == MODE_SELECT_VISUAL then
				winMgr:getWindow("Visual_SelectedToolTip"):setVisible(true)
				winMgr:getWindow("Visual_SelectedToolTipImage"):setVisible(true)
				winMgr:getWindow("Visual_SelectedToolTip"):setPosition(191,94)
				winMgr:getWindow("Visual_SelectedToolTipImage"):setPosition(191,94)
			elseif g_nNowSelectedCostumeMode == MODE_USE_CLEANUP then
				DebugStr("Ŭ���� ������ư")
				OpenCleanUpMainWindow()
				--OpenCleanUpPopup()
			elseif g_nNowSelectedCostumeMode == MODE_USE_ROOLBACK then
				DebugStr("�ѹ� ������ư")
				OpenRollBackMainWindow()
				--OpenRollBackPopup()
			elseif g_nNowSelectedCostumeMode == MODE_USE_SEPARATE then
				DebugStr("�и��ϱ� ������ư")
				OpenSeparateMainWindow()
				--OpenSeparatePopup()				
			end
		
		end


		--------------------------------------------------------------------------
		-- SelectCostumeToolTipImage()
		-- ���� �̹��� ���� �Լ�
		--------------------------------------------------------------------------
		function SelectCostumeToolTipImage()
			-- �ƹ�Ÿ ��ȯ or ������� �����ϴ� �κ��� �ƴ϶�� ���� ��
			if g_nNowSelectedCostumeMode == MODE_USE_CLEANUP or g_nNowSelectedCostumeMode == MODE_USE_SEPARATE or g_nNowSelectedCostumeMode == MODE_USE_ROOLBACK then
				DebugStr("����Ʈ�ڽ�Ƭ�����̹������� ���� : " .. g_nNowSelectedCostumeMode)
				return 
			end
			
			local itemCount, itemName, itemFileName, itemFileName2, itemskillLevel, avatarType, attach = GetSelectCostumeChangeItemInfo(g_nNowSelectedCostumeMode)

			if g_nNowSelectedCostumeMode == MODE_CHANGE_COSTUME then
				winMgr:getWindow("CostumeSelectItemImage"):setTexture("Disabled",	itemFileName, 0, 0)
				winMgr:getWindow("CostumeSelectItemImage2"):setTexture("Disabled",	itemFileName, 0, 0)
				
				if itemFileName2 == "" then
					winMgr:getWindow("CostumeSelectItemImage"):setLayered(false)
					winMgr:getWindow("CostumeSelectItemImage2"):setLayered(false)
				else
					winMgr:getWindow("CostumeSelectItemImage"):setLayered(true)
					winMgr:getWindow("CostumeSelectItemImage"):setTexture("Layered", itemFileName2, 0, 0)	
					
					winMgr:getWindow("CostumeSelectItemImage2"):setLayered(true)
					winMgr:getWindow("CostumeSelectItemImage2"):setTexture("Layered", itemFileName2, 0, 0)	
				end
							
				g_ItemCloneAttach = attach -- ��
							
				winMgr:getWindow("CostumeSelectItemImage"):setScaleWidth(160)
				winMgr:getWindow("CostumeSelectItemImage"):setScaleHeight(160)
				
				winMgr:getWindow("CostumeSelectItemImage2"):setScaleWidth(160)
				winMgr:getWindow("CostumeSelectItemImage2"):setScaleHeight(160)
				
			elseif g_nNowSelectedCostumeMode == MODE_SELECT_VISUAL then
				winMgr:getWindow("Visual_SelectedToolTipImage"):setTexture("Disabled",	itemFileName, 0, 0)
				
				if itemFileName2 == "" then
					winMgr:getWindow("Visual_SelectedToolTipImage"):setLayered(false)
				else
					winMgr:getWindow("Visual_SelectedToolTipImage"):setTexture("Layered", itemFileName2, 0, 0)
					winMgr:getWindow("Visual_SelectedToolTipImage"):setTexture("Layered", itemFileName2, 0, 0)
				end	
				
				winMgr:getWindow("Visual_SelectedToolTipImage"):setScaleWidth(160)
				winMgr:getWindow("Visual_SelectedToolTipImage"):setScaleHeight(160)
			end
						
			winMgr:getWindow("CostumeSealItemImage"):setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
			
			if itemskillLevel > 0 then
				--[[
				winMgr:getWindow("CostumeSelectItemSkillLevelImage"):setVisible(true)
				winMgr:getWindow("CostumeSelectItemSkillLevelImage"):setPosition(100,10)
				winMgr:getWindow("CostumeSelectItemSkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemskillLevel], 486)
				winMgr:getWindow("CostumeSelectItemSkillLevelText"):setTextColor(tGradeTextColorTable[itemskillLevel][1], tGradeTextColorTable[itemskillLevel][2], tGradeTextColorTable[itemskillLevel][3], 255)
				winMgr:getWindow("CostumeSelectItemSkillLevelText"):setText("+"..itemskillLevel)
				]]--
			else
				winMgr:getWindow("CostumeSelectItemSkillLevelImage"):setVisible(false)
				winMgr:getWindow("CostumeSelectItemSkillLevelText"):setText("")
			end
		end

		--------------------------------------------------------------------------
		-- Selected Costume Avatar Set
		-- ���õ� �ڽ�Ƭ �ƹ�Ÿ ���� �̹����� ����
		--------------------------------------------------------------------------
		function SetCostumeAvatarToolTip()
			local itemName, itemFileName, itemFileName2 = GetSelectedCostumeItemInfo()
			
			--DebugStr("������ ���� : " .. itemName)
			--DebugStr("���� �̸�1 : " .. itemFileName)
			--DebugStr("���� �̸�2 : " .. itemFileName2)
			
			-- ������ �����̸�
			winMgr:getWindow("CostumeSelectItemImage3"):setTexture("Disabled" , itemFileName, 0, 0)
			
			if itemFileName2 == "" then
				winMgr:getWindow("CostumeSelectItemImage3"):setLayered(false)
			else
				winMgr:getWindow("CostumeSelectItemImage3"):setLayered(true)
				winMgr:getWindow("CostumeSelectItemImage3"):setTexture("Layered" , itemFileName2, 0, 0)
			end	
			
			winMgr:getWindow("CostumeSelectItemImage3"):setScaleWidth(160)
			winMgr:getWindow("CostumeSelectItemImage3"):setScaleHeight(160)
		end


		function ClearCostumeSelectItem()
			DebugStr('ClearCostumeSelectItem')
			winMgr:getWindow("CostumeSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("CostumeSelectItemImage"):setTexture("Layered", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("CostumeSealItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("CostumeSealItemImage"):setTexture("Layered", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("CostumeSelectItemSkillLevelText"):setText("")
			winMgr:getWindow("CostumeSelectItemSkillLevelImage"):setVisible(false)
			winMgr:getWindow("CostumeSelectCancelBtn"):setVisible(false)
		end

		-- �̹����� ���콺�� ����� ������ �����Ѵ�.
		function OnMouseLeave_CostumeVanishTooltip()
			SetShowToolTip(false)	
		end


		---------------------------------------------------------------------------------------------------------------------------------------------
		--- Ŭ�� �ƹ�Ÿ ����� �� 1
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UseCreateCloneAvatarItem()
			--==========================================
			-- X��ư �ޱ�
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(310 , 10)
							
			
			--==========================================
			-- �κ��丮 ���� ���� , ��ư ��Ȱ��ȭ
			--==========================================
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			--==========================================
			-- ����Ʈ ������Ʈ�� ���� �÷��� ����
			--==========================================
			g_nNowSelectedCostumeMode	= MODE_CHANGE_COSTUME
			g_nCleanUpItemType			= MODE_CHANGE_COSTUME
			
			
			--==========================================	
			-- ����Ʈ '�θ�'�� �缳��
			--==========================================
			winMgr:getWindow("Costume_Make_Root"):addChildWindow('Costume_Change_MainWindow')
			winMgr:getWindow("Costume_Make_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Make_Root"):addChildWindow('Costume_My_Money_Text')
			winMgr:getWindow("Costume_Make_Root"):addChildWindow('Costume_My_Zen_Icon')
			winMgr:getWindow("Costume_Make_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
			winMgr:getWindow("CostumeItemList"):setPosition(600 , 100)
			winMgr:getWindow("Costume_Change_MainWindow"):setPosition(0 , 120)
			
			winMgr:getWindow("CostumeItemList"):addChildWindow('Costume_My_Money_Text')
			winMgr:getWindow("CostumeItemList"):addChildWindow('Costume_My_Zen_Icon')
			
			winMgr:getWindow("Costume_My_Money_Text"):setVisible(true)
			winMgr:getWindow("Costume_My_Zen_Icon"):setVisible(true)
			
						
			-- ���� ������ ����Ʈâ �ҷ�����
			--SetTabFunction("Select_CostumeAvatar_Zen" ,		ITEM_TAP_ZEN , 1 , true)
			--SetTabFunction("Select_CostumeAvatar_Cash" ,	ITEM_TAP_CASH , 2 , false)
			--SetPageBtnFunction("OnClickCostumeItemList_PrevPage" , "OnClickCostumeItemList_NextPage")
			--SetRegistBtnFunction("tCostumeItemButtonEvent")
			--ShowCommonItemList()
		
			
			local MyZen = GetMyMoney()
			local r,g,b = GetGranColor(MyZen)
			local granText = CommatoMoneyStr(MyZen)
			textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
			DebugStr("textSize : " .. textSize)
			winMgr:getWindow("Costume_My_Money_Text"):setTextColor(r,g,b,255)	
			winMgr:getWindow("Costume_My_Money_Text"):setPosition(115 - textSize, 407)
			winMgr:getWindow("Costume_My_Money_Text"):setText(granText)
			
									
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			winMgr:getWindow("Costume_Make_Root"):setVisible(true)
			winMgr:getWindow("Costume_Change_MainWindow"):setVisible(true)
					
			
			--==========================================
			-- ����Ʈ�� �� (ZEN���� �⺻����)
			--==========================================
			winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(110 , 380)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(93 , 378)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(192 , 378)
				

			--==========================================
			-- ������ �� ���ý� Ȯ�ι�ư ��Ȱ��ȭ
			--==========================================
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			
			
			--==========================================
			-- ������ �缳��
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow(winMgr:getWindow("CostumeSelectItemImage"))
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow(winMgr:getWindow("CostumeSelectItemToolTipImage"))
			winMgr:getWindow("CostumeSelectItemImage"):setPosition(140 , 82)
			winMgr:getWindow("CostumeSelectItemToolTipImage"):setPosition(140, 82)	
			
			
			--==========================================
			-- ����Ʈâ ���� ����
			--==========================================
			SetCurrentClonetemMode(ITEMLIST_ZEN)		-- ������ '���' ����
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)	-- ������ 'Ÿ����' ����
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_MAKE -- �� ������ ��¿�� ���� -_-
			
			
			--==========================================
			-- ����Ʈâ ������Ʈ
			--==========================================
			g_currenItemList = ITEMLIST_ZEN
			ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			ShowSelectCostumeAvatarList()	-- ����Ʈâ �����ֱ�
		end

		---------------------------------------------------------------------------------------------------------------------------------------------
		--- Ŭ�� �ƹ�Ÿ Visual �����ϱ� �� -> 2
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserSelectCloneAvatarLooks(IsCash)
			--winMgr:getWindow("Costume_AlphaImage"):setVisible(true)
			
			-- ���̷뿡�� �κ��丮�� ���� ����� ���� ��
			local CurrentWndType = GetCurrentWndType()
			if CurrentWndType == 3 then -- (3 == MyRoom)
				if	winMgr:getWindow("MyRoom_Title"):isVisible() == true and 
					winMgr:getWindow("MyInven_BackImage"):isVisible() == true then
					
					ShowNotifyOKMessage_Lua("Inventory Use No")
					DebugStr("���� ����")
					return
				end
			end
			
			--==========================================
			-- �κ��丮 ���� ���� , ��ư ��Ȱ��ȭ
			--==========================================
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			--==========================================
			-- ������� �ʴ� ���������� �ݱ�
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):setVisible(false)
			
			
			--==========================================
			-- ����Ʈ ������Ʈ�� ���� �÷��� ����
			--==========================================
			--g_nNowSelectedCostumeMode = MODE_SELECT_VISUAL
			--ChangedCostumeItemList(ITEMLIST_ZEN , g_nNowSelectedCostumeMode)
			
			g_nCleanUpItemType = MODE_SELECT_VISUAL
			
			
			--==========================================
			-- ������ �� ���ý� Ȯ�ι�ư ��Ȱ��ȭ
			--==========================================
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setEnabled(false)
			
			--[[
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Normal",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Hover",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Pushed",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("PushedOff",	"UIData/popup002.tga", 339, 307)
			]]--
			
			--==========================================
			-- ������ ����(����� ���� ���� ����)
			--==========================================
			SetCostumeAvatarToolTip()
			
			
			--==========================================
			-- X��ư �޾��ֱ�
			--==========================================
			winMgr:getWindow("Costume_Visual_Main"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(268 , 8)


			--==========================================
			-- ���� ������ , Ȯ�ι�ư ���̱�
			--==========================================
			winMgr:getWindow("Costume_Visual_Main"):setVisible(true)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setVisible(true)
			
			
			--==========================================	
			-- ����Ʈ '�θ�'�� �缳��
			--==========================================
			winMgr:getWindow("Costume_Visual_Root"):addChildWindow('Costume_Visual_Main')
			winMgr:getWindow("Costume_Visual_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Visual_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 191)
			
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Visual_Root"):setVisible(true)
			winMgr:getWindow("Costume_Visual_Main"):setVisible(true)
			
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)


			--==========================================			
			-- �ڽ�Ƭ �ƹ�Ÿ�� ������ ������ �̹��� �ð�ȭ
			--==========================================
			winMgr:getWindow("CostumeSelectItemImage3"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage3"):setPosition(49,94)
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setPosition(49,94)
			
			
			--==========================================
			-- ����Ʈâ ���� ����
			--==========================================
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)	-- ������ Ÿ���� ����
			
			
			--==========================================
			-- ����Ʈâ ������Ʈ
			--==========================================
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			
			--==========================================
			-- ����Ʈ�� �� (ZEN���� �⺻����)
			--==========================================
			if IsCash == true then
				SetCurrentClonetemMode(ITEMLIST_CASH)		-- ������ ��� ����
				
				g_currenItemList			= ITEMLIST_CASH
				g_nNowSelectedCostumeMode	= MODE_SELECT_VISUAL
				ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
				ShowSelectCostumeAvatarList()	-- ����Ʈâ �����ֱ�
			else
				SetCurrentClonetemMode(ITEMLIST_ZEN)		-- ������ ��� ����
				
				g_currenItemList			 = ITEMLIST_ZEN
				g_nNowSelectedCostumeMode	 = MODE_SELECT_VISUAL
				ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
				ShowSelectCostumeAvatarList()	-- ����Ʈâ �����ֱ�
			end
			
			
		end


		-- �ؽ�Ʈ �޼��� ��ġ ������
		function GetStringSquareSize( font, size, text ) -- return x, y
		
			local max = 0
			local index = 0
			local cnt = 1
			local num = 0
			
			for i = 1, string.len(text) do
			
				local c = string.sub( text, i, i )
				
				if 	c == "\n" then
				
					num = GetStringSize(font, size, string.sub( text, index+1, i-1 ))
					if max < num then
						max = num
					end
					
					index = i
					cnt = cnt + 1
				end
			end
			
			num = GetStringSize(font, size, string.sub( text, index+1, string.len(text) ))
			if max < num then
				max = num
			end
			
			return max, cnt
		end

		----------------------------------------------------------------------
		-- ��ȭ�ϱ� ��� �̹���
		-----------------------------------------------------------------------
		window = winMgr:createWindow("TaharezLook/StaticImage", "CloneAvatarCleanUpMainImg")
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
		-- ��ȭ�ϱ� YES ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarCleanUpOK")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 774, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 774, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 774, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 774, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(70 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "SendCleanupAvatarIndex")
		winMgr:getWindow('CloneAvatarCleanUpMainImg'):addChildWindow(mywindow)

		------------------------------------------------------------
		-- ��ȭ�ϱ� NO ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarCleanUpCancel")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 863, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 863, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 863, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 863, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(180 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "CleanUpWndCloseEvent")
		winMgr:getWindow('CloneAvatarCleanUpMainImg'):addChildWindow(mywindow)
		
		-- �������� ����Ұ��ΰ��� ����� �ؽ�Ʈ 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_CleanItem_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)		
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarCleanUpMainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- ��ȭ�ϱ� Main ������ Open
		------------------------------------------------------------
		function OpenCleanUpMainWindow()
			winMgr:getWindow("CloneAvatarCleanUpMainImg"):setVisible(true)
			winMgr:getWindow("CloneAvatarCleanUpOK"):setVisible(true)
			winMgr:getWindow("CloneAvatarCleanUpCancel"):setVisible(true)
			
					
			local sizeX, sizeY = GetStringSquareSize(g_STRING_FONT_GULIMCHE, 14, g_STRING_QUESTION_CLEANUP_USE)
			
			winMgr:getWindow("Costume_CleanItem_Text"):setText(g_STRING_QUESTION_CLEANUP_USE)
			winMgr:getWindow("Costume_CleanItem_Text"):setPosition(170 - sizeX/2, 110 - ((sizeY-1)*10))

		end

		function CleanUpWndCloseEvent()
			winMgr:getWindow("CloneAvatarCleanUpMainImg"):setVisible(false)
			--CostumeCloseEvent()
		end
		
		------------------------------------------------------------
		-- ��ȭ�� �ƹ�Ÿ �ε��� , ��ȭ�� �ε��� ����
		------------------------------------------------------------
		function SendCleanupAvatarIndex()
			RequestCleanUpCostumeAvatar()
			
			winMgr:getWindow("CloneAvatarCleanUpMainImg"):setVisible(false)
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			winMgr:getWindow("Costume_AlphaImage"):setVisible(false)
		end
		
		function ReloadCloneAvatarList(useMode , itemType)
			g_nNowSelectedCostumeMode = useMode -- 2 , (ITEMLIST_POLLUTION_CASH_AVATAR)5 - Ŭ��
			ChangedCostumeItemList(itemType , g_nNowSelectedCostumeMode)
		end
		
		
		----------------------------------------------------------------------
		-- �ǵ����� ��� �̹���
		-----------------------------------------------------------------------
		window = winMgr:createWindow("TaharezLook/StaticImage", "CloneAvatarRollBack_MainImg")
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
		-- �ǵ����� YES ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarRollBack_OK")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 774, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 774, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 774, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 774, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(70 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "UseRollBackItem")
		winMgr:getWindow('CloneAvatarRollBack_MainImg'):addChildWindow(mywindow)

		------------------------------------------------------------
		-- �ǵ����� NO ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarRollBack_Cancel")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 863, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 863, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 863, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 863, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(180 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "RollBackWndCloseEvent")
		winMgr:getWindow('CloneAvatarRollBack_MainImg'):addChildWindow(mywindow)
		
		-- �������� ����Ұ��ΰ��� ����� �ؽ�Ʈ 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_RollBack_Use_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarRollBack_MainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- �Ϲ����� �ǵ����� Main ������ Open
		------------------------------------------------------------
		function OpenRollBackMainWindow()
			winMgr:getWindow("CloneAvatarRollBack_MainImg"):setVisible(true)
			winMgr:getWindow("CloneAvatarRollBack_OK"):setVisible(true)
			winMgr:getWindow("CloneAvatarRollBack_Cancel"):setVisible(true)
			
			local sizeX, sizeY = GetStringSquareSize(g_STRING_FONT_GULIMCHE, 14, g_STRING_QUESTION_ROLLBACK_USE)
			
			winMgr:getWindow("Costume_RollBack_Use_Text"):setText(g_STRING_QUESTION_ROLLBACK_USE)
			winMgr:getWindow("Costume_RollBack_Use_Text"):setPosition(170 - sizeX/2, 110 - ((sizeY-1)*10))
		end
		
		function RollBackWndCloseEvent()
			winMgr:getWindow("CloneAvatarRollBack_MainImg"):setVisible(false)
			--CostumeCloseEvent()
		end
		
		function UseRollBackItem()
			RequestRollBackCostumeAvatar()	-- �ε��� ������ ����
			CostumeCloseEvent()
		end
		
		
		
		----------------------------------------------------------------------
		-- �и��ϱ� ��� �̹���
		-----------------------------------------------------------------------
		window = winMgr:createWindow("TaharezLook/StaticImage", "CloneAvatarSeparate_MainImg")
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
		-- �и��ϱ� YES ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarSeparate_OK")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 774, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 774, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 774, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 774, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(70 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "UseSeparateItem")
		winMgr:getWindow('CloneAvatarSeparate_MainImg'):addChildWindow(mywindow)

		------------------------------------------------------------
		-- �и��ϱ� NO ��ư
		------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "CloneAvatarSeparate_Cancel")
		mywindow:setTexture("Normal",	"UIData/Avata.tga", 863, 464)
		mywindow:setTexture("Hover",	"UIData/Avata.tga", 863, 496)
		mywindow:setTexture("Pushed",	"UIData/Avata.tga", 863, 528)
		mywindow:setTexture("PushedOff","UIData/Avata.tga", 863, 560)
		mywindow:setSize(89, 30)
		mywindow:setPosition(180 , 195)
		mywindow:setEnabled(true)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:subscribeEvent("Clicked", "SeparateWndCloseEvent")
		winMgr:getWindow('CloneAvatarSeparate_MainImg'):addChildWindow(mywindow)
		
		-- �������� ����Ұ��ΰ��� ����� �ؽ�Ʈ 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_Separate_Use_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarSeparate_MainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- �и��ϱ� Main ������ Open
		------------------------------------------------------------
		function OpenSeparateMainWindow()
			winMgr:getWindow("CloneAvatarSeparate_MainImg"):setVisible(true)
			winMgr:getWindow("CloneAvatarSeparate_OK"):setVisible(true)
			winMgr:getWindow("CloneAvatarSeparate_Cancel"):setVisible(true)
			
			local sizeX, sizeY = GetStringSquareSize(g_STRING_FONT_GULIMCHE, 14, g_STRING_QUESTION_SEPARATE_USE)
			
			winMgr:getWindow("Costume_Separate_Use_Text"):setText(g_STRING_QUESTION_SEPARATE_USE)
			winMgr:getWindow("Costume_Separate_Use_Text"):setPosition(170 - sizeX/2, 110 - ((sizeY-1)*10))
		end
		
		function SeparateWndCloseEvent()
			winMgr:getWindow("CloneAvatarSeparate_MainImg"):setVisible(false)
			--CostumeCloseEvent()
		end
		
		function UseSeparateItem()
			RequestSeparateCostumeAvatar()	-- �ε��� ������ ����
			
			winMgr:getWindow("CloneAvatarSeparate_MainImg"):setVisible(false)
			--CostumeCloseEvent()
		end
		
		

		
		
		
		------------------------------------------------------------
		-- (���� ������� �����Ͻðڽ��ϱ�? �˾� ����
		------------------------------------------------------------
		function LastQuestionSetVisualAvatar()
			--ShowCommonAlertOkCancelBoxWithFunction("SetVisual","\OK?" , "LastSetViusalAvatar", "NotSetViusalAvatar")
			ShowCommonAlertOkCancelBoxWithFunction(g_STRING_USE_CLONE_AVATAR, "" , "LastSetViusalAvatar", "NotSetViusalAvatar")
			
		end
		
		function LastSetViusalAvatar()
			SetCostumeVisual()
		end
		function NotSetViusalAvatar()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NotSetViusalAvatar" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end
		
		
		------------------------------------------------------------
		-- ��ȭ�ϱ� �˾� ����
		------------------------------------------------------------
		function OpenCleanUpPopup()
			ShowCommonAlertOkCancelBoxWithFunction("Clean","\nUse?" , "UseCleanItem", "NoUseCleanItem")
		end
		
		function UseCleanItem()
			RequestCleanUpCostumeAvatar()	-- �ε��� ������ ����
		end
		function NoUseCleanItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseCleanItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end

		------------------------------------------------------------
		-- �и��ϱ� �˾� ����
		------------------------------------------------------------
		function OpenSeparatePopup()
			ShowCommonAlertOkCancelBoxWithFunction("Separate","\nUse?" , "UseSeparateItem", "NoUseSeparateItem")
		end
		
		--[[
		function UseSeparateItem()
			RequestSeparateCostumeAvatar()	-- �ε��� ������ ����
			DebugStr("UseSeparateItem")
		end
		]]--
		function NoUseSeparateItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseSeparateItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
			DebugStr("NoUseSeparateItem")
		end
		
		
		------------------------------------------------------------
		-- �ѹ��ϱ�(�⺻�ƹ�Ÿ�� ��ȯ) �˾� ����
		------------------------------------------------------------
		function OpenRollBackPopup()
			ShowCommonAlertOkCancelBoxWithFunction("RollBack","Are you SURE?" , "UseRollBackItem", "NoUseRollBackItem")
		end
		
		--[[
		function UseRollBackItem()
			RequestRollBackCostumeAvatar() -- �ε��� ������ ����
		end
		]]--
		
		function NoUseRollBackItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseRollBackItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end

		

		


		---------------------------------------------------------------------------------------------------------------------------------------------
		--- �ڽ�Ƭ �ƹ�Ÿ (��) ����� �ƹ�Ÿ �и� ��Ű�� ��
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserSeparateCostumeAvatar()
			SeparateCostumeAvatar(ITEMLIST_POLLUTION_ZEN_AVATAR) -- 4
		end
		
		-- �ڽ�Ƭ �ƹ�Ÿ �и� ��Ű�� ��
		function SeparateCostumeAvatar(CleanUP_Mode)
			-- @ X��ư �޾��ֱ�
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ �κ��丮�� �����ִٸ� , ������ �ݾƹ�����
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ �κ��丮 ��ư ��Ȱ��ȭ
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ Ŭ���� ������ ���� �����ϱ�
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			
			
			-- # ����Ʈâ�� ��ġ�� ������
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ ����Ʈ�� �� (Zen �⺻ Select)
			winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 2;	-- Ŭ���� ��� ���� ��
			
			-- # ����Ʈ �ڽ� ����
			SetCurrentClonetemMode(CleanUP_Mode)	-- ����Ʈ �ڽ��� �� ���� (g_ItemClone.m_currentMyItemMode)
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_CLEANUP				--	 3��
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ ����Ʈ ������Ʈ�� ���� �÷��� ����
			g_nNowSelectedCostumeMode = MODE_USE_SEPARATE						-- 3��
			ChangedCostumeItemList(CleanUP_Mode , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() ȣ��
			ShowSelectCostumeAvatarList()										-- ����Ʈ â�� �ҷ��´�
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		

		---------------------------------------------------------------------------------------------------------------------------------------------
		--- �ڽ�Ƭ �ƹ�Ÿ (ĳ��) Ŭ�����ϱ� ��
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserCleanUpCashAvatar()
			SetAvatarCleanUpInfo(ITEMLIST_POLLUTION_CASH_AVATAR)
		end

		-- �ڽ�Ƭ �ƹ�Ÿ Ŭ���� '���' ���� �Լ�
		function SetAvatarCleanUpInfo(CleanUP_Mode)
			--winMgr:getWindow("Costume_AlphaImage"):setVisible(true)
			
			-- �θ� ����
			--winMgr:getWindow("Costume_UseItem_Root"):addChildWindow("CostumeItemList")
			
			
			-- @ X��ư �޾��ֱ�
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ �κ��丮�� �����ִٸ� , ������ �ݾƹ�����
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ �κ��丮 ��ư ��Ȱ��ȭ
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ Ŭ���� ������ ���� �����ϱ�
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
						
			-- # ����Ʈâ�� ��ġ�� ������
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ ����Ʈ�� �� (Zen �⺻ Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- Ŭ���� ��� ���� ��
			
			
			-- # ����Ʈ �ڽ� ����
			SetCurrentClonetemMode(CleanUP_Mode)	-- ����Ʈ �ڽ��� �� ���� (g_ItemClone.m_currentMyItemMode)
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_CLEANUP				--	 3��
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ ����Ʈ ������Ʈ�� ���� �÷��� ����
			g_nNowSelectedCostumeMode = MODE_USE_CLEANUP						-- 2��
			ChangedCostumeItemList(CleanUP_Mode , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() ȣ��
			ShowSelectCostumeAvatarList()										-- ����Ʈ â�� �ҷ��´�
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		
		
		-- �ڽ�Ƭ �ƹ�Ÿ �Ϲ� �ƹ�Ÿ�� ��ȯ�ϱ� ��
		function SetRoolBackAvatar()
			-- @ X��ư �޾��ֱ�
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ �κ��丮�� �����ִٸ� , ������ �ݾƹ�����
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ �κ��丮 ��ư ��Ȱ��ȭ
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ Ŭ���� ������ ���� �����ϱ�
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			]]--
			
			
			-- # ����Ʈâ�� ��ġ�� ������
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ ����Ʈ�� �� (Zen �⺻ Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- Ŭ���� ��� ���� ��
			
			
			-- # ����Ʈ �ڽ� ����
			SetCurrentClonetemMode(ITEMLIST_ROOL_BACK)	-- ����Ʈ �ڽ��� �� ���� (g_ItemClone.m_currentMyItemMode) -- 7
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_ROOL_BACK			--	 5��
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ ����Ʈ ������Ʈ�� ���� �÷��� ����
			g_nNowSelectedCostumeMode = MODE_USE_ROOLBACK						-- 4��
			ChangedCostumeItemList(ITEMLIST_ROOL_BACK , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() ȣ��	-- 7 , 4
			ShowSelectCostumeAvatarList()										-- ����Ʈ â�� �ҷ��´�
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		-- �ڽ�Ƭ �ƹ�Ÿ �и� ��Ű�� ��
		function SetSeparateAvatar()
			-- @ X��ư �޾��ֱ�
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- ������ �̵���ư / �ؽ�Ʈ ��ġ�̵�
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ �κ��丮�� �����ִٸ� , ������ �ݾƹ�����
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ �κ��丮 ��ư ��Ȱ��ȭ
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ Ŭ���� ������ ���� �����ϱ�
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			]]--
			
			
			-- # ����Ʈâ�� ��ġ�� ������
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ ����Ʈ�� �� (Zen �⺻ Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- Ŭ���� ��� ���� ��
			
			
			-- # ����Ʈ �ڽ� ����
			SetCurrentClonetemMode(ITEMLIST_ROOL_BACK)	-- ����Ʈ �ڽ��� �� ���� (g_ItemClone.m_currentMyItemMode) -- 7
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_ROOL_BACK			--	 5��
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ ����Ʈ ������Ʈ�� ���� �÷��� ����
			g_nNowSelectedCostumeMode = MODE_USE_ROOLBACK						-- 4��
			ChangedCostumeItemList(ITEMLIST_ROOL_BACK , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() ȣ��	-- 7 , 4
			ShowSelectCostumeAvatarList()										-- ����Ʈ â�� �ҷ��´�
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		-------------------------------------------------------------
		-- �ڽ�Ƭ �ƹ�Ÿ ���� ������ �����
		-------------------------------------------------------------
		function SetAvatarIconS(FileName , FileName2 , FileName3 , index , avatarType , attach)
			if avatarType ~= 0 then
				-- ������ �ƹ�Ÿ == -2
				if avatarType == -2 then
					winMgr:getWindow(FileName2..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setTexture("Disabled", "UIData/Match002.tga", 667, 886)
					return
					
				-- ����� �ƹ�Ÿ = -3
				elseif avatarType == -3 then
					winMgr:getWindow(FileName2..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setTexture("Disabled", "UIData/Match002.tga", 667, 934)	-- �̺κ��� y���� �ٲ��ش�
					return
										
				-- 1. Pure Avatar ���� ��
				elseif avatarType == -1 then
					-- ������ ����
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ������ �´� �̹����� �ҷ��´�.
					if attach == 32 then		-- �Ӹ� (ĳ��)
						--DebugStr("ĳ�� �Ӹ� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- ���� (ĳ��)
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- �ٸ� (ĳ��)
						--DebugStr("ĳ�� �ٸ� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- �� (ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- ��Ʈ
						--DebugStr("ĳ�� ��Ʈ ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- ��
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- ����(�հ�)
						--DebugStr("ĳ�� �հ� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- ����
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					winMgr:getWindow(FileName3..index):setVisible(true)
					
					return
					
				-- 2. Selected Visual Avatar ���� ��
				elseif avatarType > 0 then
					-- ������ ����
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ����� �ƹ�Ÿ�� �����۳ѹ��� ������Ÿ�� ������ �̸��� �޾Ƴ���.
					-- â��� �ű�� �κ��丮���� �������� �����Ƿ� , ��Ʈ���� ������ ����..
					-- â���� �˻��ϴ� ����ó���� �������. ��
					local string = GetVisualAvatarName(avatarType)
					--DebugStr("avatarType : " .. avatarType)
					--DebugStr("string : " .. string)
					
					if string ~= "" then
						-- ����� �ƹ�Ÿ�� �������� ���� 
						local test = "UIData/ItemUIData/" .. string
						--DebugStr("test : " .. test)
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	test, 0, 0)
					else
						-- �ùٸ� ������� ���� ���� �ʾҴ�. failed
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/none.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/none.tga", 0, 0	)
					end
					winMgr:getWindow(FileName3..index):setVisible(true)
					return
				end -- end of if avatarType
			else
				winMgr:getWindow(FileName3..index):setVisible(false)
			end -- end of if avatarType
	
		end -- end of  function (SetAvatarIconS())
		
		
		function SetAvatarIcon(FileName , FileName2, avatarType , attach, itemFileName)
			-------------------------------------------------------------
			-- �ڽ�Ƭ �ƹ�Ÿ ���� ������ �����
			-------------------------------------------------------------
			if avatarType ~= 0 then
				-- ������ �ƹ�Ÿ��� �ٸ� �̹����� �����ϰ� ���ϡ�
				if avatarType == -2 then
					-- ��� ���
					winMgr:getWindow(FileName):setTexture("Enabled", itemFileName, 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled", itemFileName, 0, 0)
					return
				
				-- Ŭ�� �ƹ�Ÿ �̹��� ���� ��
				-- pure �ƹ�Ÿ
				elseif avatarType == -1 then
					-- ������ ����
					winMgr:getWindow(FileName):setTexture("Enabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ������ �´� �̹����� �ҷ��´�.
					if attach == 32 then		-- �Ӹ� (ĳ��)
						--DebugStr("ĳ�� �Ӹ� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- ���� (ĳ��)
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- �ٸ� (ĳ��)
						--DebugStr("ĳ�� �ٸ� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- �� (ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- ��Ʈ
						--DebugStr("ĳ�� ��Ʈ ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- ��
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- ����(�հ�)
						--DebugStr("ĳ�� �հ� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- ����
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					
					winMgr:getWindow(FileName2):setVisible(true)
					winMgr:getWindow(FileName):setVisible(true)
					
					return
				elseif avatarType > 0 then
					-- ������ ����
					winMgr:getWindow(FileName):setTexture("Enabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ����� �ƹ�Ÿ�� �����۳ѹ��� ������Ÿ�� ������ �̸��� �޾Ƴ���.
					local string = GetVisualAvatarName(avatarType)
					
					if string ~= "" then
						-- ����� �ƹ�Ÿ�� �������� ���� 
						local test = "UIData/ItemUIData/" .. string
						--DebugStr("test : " .. test)
						winMgr:getWindow(FileName2):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	test, 0, 0)
					else
						-- �ùٸ� ������� ���� ���� �ʾҴ�. failed
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/none.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/none.tga", 0, 0	)
					end
					winMgr:getWindow(FileName2):setVisible(true)
					winMgr:getWindow(FileName):setVisible(true)
					return
				end -- end of if avatarType
			else
				winMgr:getWindow(FileName2):setVisible(false)
			end -- end of if avatarType
	
		end -- end of  function (SetAvatarIcon())
		

		function DrawCostumeAvatarIcons(Draw , FileName , avatarType , attach)
			-- 1. pure �ƹ�Ÿ ����
			if avatarType == -1 then
				-- ����� ����
				Draw:drawTexture("UIData/ItemUIData/Item/C1.tga", 8, 42, 100, 100, 0, 0)
				
				-- ������� �˸´� ������ ����
				if attach == 32 then			-- �Ӹ� (ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/hair.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 1 then		-- ���� (ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/top.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 2 then		-- �ٸ� (ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/bottoms.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 16 then	-- �� (ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/face.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 4 then		-- ��	(ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/hand.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 8 then		-- ��	(ĳ��)
					Draw:drawTexture("UIData/ItemUIData/Item/foot.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 63 or attach == 43 or attach == 11 then	-- ��Ʈ
					Draw:drawTexture("UIData/ItemUIData/Item/set_0001.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 64 then	-- ��
					Draw:drawTexture("UIData/ItemUIData/Item/bag.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 128 then	-- ����(�հ�)
					Draw:drawTexture("UIData/ItemUIData/Item/hat.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 256 then	-- ����
					Draw:drawTexture("UIData/ItemUIData/Item/ring.tga", 8, 42, 100, 100, 0, 0)
				end
				return
				
			-- 2. ������ �ƹ�Ÿ
			elseif avatarType == -2 then
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
				Draw:drawTextureWithScale_Angle_Offset("UIData/Match002.tga" , 60, 90, 48, 48, 667, 886,   500, 500, 255, 0, 8, 100,100)
															--			���������� ,������, ��ǥ,          	 ������,������,����,����,?,?
				return
			
			-- 3. ����� �ƹ�Ÿ
			elseif avatarType == -3 then
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
				Draw:drawTextureWithScale_Angle_Offset("UIData/Match002.tga" , 60, 90, 48, 48, 667, 934,   500, 500, 255, 0, 8, 100,100)
															--			���������� ,������, ��ǥ,          	 ������,������,����,����,?,?
				return
			
			-- 4. Visual�� ���õ� Ŭ�� �ƹ�Ÿ
			elseif avatarType > 0 then
				-- ����� ����
				Draw:drawTexture("UIData/ItemUIData/Item/C1.tga", 8, 42, 100, 100, 0, 0)
				
				-- ����� �ƹ�Ÿ�� �����۳ѹ��� ������Ÿ�� ������ �̸��� �޾Ƴ���.
				local string = GetVisualAvatarName(avatarType)
				
				if string ~= "" then
					-- ����� �ƹ�Ÿ�� �������� ���� 
					local test = "UIData/ItemUIData/" .. string
					--DebugStr("test : " .. test)
					Draw:drawTexture(test, 8, 42, 100, 100, 0, 0)
				else
					-- �ùٸ� ������� ���� ���� �ʾҴ�. failed
					Draw:drawTexture("UIData/ItemUIData/none.tga", 8, 42, 100, 100, 0, 0)
				end
				return
			
			-- 5. �Ϲ� ������ �̹�����
			else
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
			end
			
		end -- end of  function (SetAvatarIconS())
		
		
		function DrawORB_CostumeAvatarIcons(Draw , FileName , avatarType , attach)
			-- 1. pure �ƹ�Ÿ ����
			if avatarType == -1 then
				-- ����� ����
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/C1.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				
				-- ������� �˸´� ������ ����
				if attach == 32 then			-- �Ӹ� (ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hair.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 1 then		-- ���� (ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/top.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 2 then		-- �ٸ� (ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/bottoms.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 16 then	-- �� (ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/face.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 4 then		-- ��	(ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hand.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 8 then		-- ��	(ĳ��)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/foot.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 63 or attach == 43 or attach == 11 then	-- ��Ʈ
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/set_0001.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 64 then	-- ��
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/bag.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 128 then	-- ����(�հ�)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hat.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 256 then	-- ����
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/ring.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				end
				return
			
			-- 2. Visual�� ���õ� �ƹ�Ÿ
			elseif avatarType > 0 then
				-- ����� ����
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/C1.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				
				-- ����� �ƹ�Ÿ�� �����۳ѹ��� ������Ÿ�� ������ �̸��� �޾Ƴ���.
				local string = GetVisualAvatarName(avatarType)
				--DebugStr("avatarType : " .. avatarType)
				--DebugStr("string : " .. string)
				
				if string ~= "" then
					-- ����� �ƹ�Ÿ�� �������� ���� 
					local test = "UIData/ItemUIData/" .. string
					--DebugStr("test : " .. test)
					Draw:drawTextureWithScale_Angle_Offset(test , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				else
					-- �ùٸ� ������� ���� ���� �ʾҴ�. failed
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/none.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				end
				return
			elseif avatarType == -2 then
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/Infection_001.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
			else
				Draw:drawTextureWithScale_Angle_Offset(FileName , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
			end
				
		end -- end of  function (SetAvatarIconS())
		
		
		-- ItemClone���� ���������� �����
		function SetItemListAvatarIconS(FileName , FileName2 , index , avatarType , attach)
			if avatarType ~= 0 then
				-- 1. Pure Avatar ���� ��
				if avatarType == -1 then
					-- ������ ����
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ������ �´� �̹����� �ҷ��´�.
					if attach == 32 then		-- �Ӹ� (ĳ��)
						--DebugStr("ĳ�� �Ӹ� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- ���� (ĳ��)
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- �ٸ� (ĳ��)
						--DebugStr("ĳ�� �ٸ� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- �� (ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- ��	(ĳ��)
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- ��Ʈ
						--DebugStr("ĳ�� ��Ʈ ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- ��
						--DebugStr("ĳ�� �� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- ����(�հ�)
						--DebugStr("ĳ�� �հ� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- ����
						--DebugStr("ĳ�� ���� ����ġ")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					winMgr:getWindow(FileName..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setVisible(true)
					return
					
				-- 2. Selected Visual Avatar ���� ��
				elseif avatarType > 0 then
					-- ������ ����
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- ����� �ƹ�Ÿ�� �����۳ѹ��� ������Ÿ�� ������ �̸��� �޾Ƴ���.
					-- â��� �ű�� �κ��丮���� �������� �����Ƿ� , ��Ʈ���� ������ �ʴ´�
					-- â���� �˻��ϴ� ����ó���� �������
					local string = GetVisualAvatarName(avatarType)
					
					if string ~= "" then
						-- ����� �ƹ�Ÿ�� �������� ���� 
						local test = "UIData/ItemUIData/" .. string
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	test, 0, 0)
					else
						-- �ùٸ� ������� ���� ���� �ʾҴ�. failed
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/none.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/none.tga", 0, 0	)
					end
					
					winMgr:getWindow(FileName..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setVisible(true)
					return
				end -- end of if avatarType
			else
				winMgr:getWindow(FileName..index):setVisible(false)
				winMgr:getWindow(FileName2..index):setVisible(false)
			end -- end of if avatarType
		end -- end of  function (SetItemListAvatarIconS())
		
		
		-- ����� ����â�� �������� ��Ų��.
		function CloseSetVisualWindow()
			winMgr:getWindow("Costume_Visual_Root"):setVisible(false)
			winMgr:getWindow("Costume_Visual_Main"):setVisible(false)
			
			--winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			--winMgr:getWindow("MainBar_Bag"):setEnabled(false)
		end

	end -- end of Flag == 1?

--end	-- end of Now Thai?



--==============================================================================================================
--================================== �ڽ�Ƭ �ƹ�Ÿ ���� ���� ===================================================
--==============================================================================================================






















----------------------------------------------------------------------
-- Ŭ�� ������ ������ â
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneMainImage")
mywindow:setTexture("Enabled", "UIData/popup002.tga", 0, 247)
mywindow:setTexture("Disabled", "UIData/popup002.tga", 0, 247)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(200, 250)
mywindow:setSize(338, 265)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


----------------------------------------------------------------------
--Ŭ�� �����̹���
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- ������ �簢����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneItemImageSqure")
mywindow:setTexture("Enabled", "UIData/bunhae_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/bunhae_002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(126, 88)
mywindow:setSize(83, 83)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setEnabled(true)
mywindow:setZOrderingEnabled(false)
--winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)


-- ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneSelectItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(140, 124)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(138)
mywindow:setScaleHeight(138)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)

-- ������ ��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneSealItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(140, 124)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(138)
mywindow:setScaleHeight(138)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)


-- ��ų ���� �׵θ� 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneSelectItemSkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(170, 168)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)

-- ��ų���� + ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneSelectItemSkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(9, 1)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CloneSelectItemSkillLevelImage"):addChildWindow(mywindow)





-- ���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneSelectItemToolTipImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(138, 124)
mywindow:setSize(128, 128)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CloneSelectItemListInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CloneVanishTooltip")
winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)

-- ���� ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "CloneSelectCancelBtn");	
mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 1008, 0)
mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 1008, 16)
mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 1008, 32)
mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 1008, 32)
mywindow:setPosition(185, 117)
mywindow:setSize(16, 16);
mywindow:setVisible(false);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickSelectCancle");
--winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)

-- ���õ� ������ ���
function OnClickSelectCancle()
	ResetCloneSelectItemInfo()
	ClearCloneSelectItem()
end

-- ��������� ��û
--[[
function RequestShowReward()

	RequestDisassembleItem()
	for i=1, #CloneItemButtonName do	
		winMgr:getWindow(CloneItemButtonName[i]):setVisible(true)
	end
end
--]]


mywindow = winMgr:createWindow("TaharezLook/Button", "CloneOkBtn")
mywindow:setTexture("Normal", "UIData/popup002.tga", 339, 247)
mywindow:setTexture("Hover", "UIData/popup002.tga", 339, 277)
mywindow:setTexture("Pushed", "UIData/popup002.tga", 339, 307)
mywindow:setTexture("PushedOff", "UIData/popup002.tga", 339, 247)
mywindow:setPosition(127, 220)
mywindow:setSize(87, 30)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "CloneOkBtnEvent")
winMgr:getWindow('CloneMainImage'):addChildWindow(mywindow)


--local bSReslove = false


function CloneOkBtnEvent()
	if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
		RequestUnsealSkillItem() 
	elseif ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLTRADEITEM then
		RequestUnsealSkillTradeItem() 
	end
end

function CloneCancelBtnEvent()
	winMgr:getWindow('CloneMainImage'):setVisible(false)
	winMgr:getWindow('CloneItemImage'):setVisible(false)
	winMgr:getWindow('CloneAlphaImage'):setVisible(false)
	
	for i=1, #CloneItemButtonName do	
		winMgr:getWindow(CloneItemButtonName[i]):setVisible(true)
	end
	ClearCloneSelectItem()
	ResetCloneSelectItemInfo()
end


function CloneCancelEvent()
	
	winMgr:getWindow('CloneMainImage'):setVisible(false)
	winMgr:getWindow('CloneItemImage'):setVisible(false)
	winMgr:getWindow('CloneAlphaImage'):setVisible(false)
	
	for i=1, #CloneItemButtonName do	
		winMgr:getWindow(CloneItemButtonName[i]):setVisible(true)
	end
	ClearCloneSelectItem()
	ResetCloneSelectItemInfo()
end

----------------------------------------------------------------------
-- ������Ŭ�� ����Ʈ ���� 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneItemImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(650,180);
mywindow:setSize(296, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)



-----------------------------------------------------------------------
--�ڽ�Ƭ , ��ų , ��Ÿ  , �����
-----------------------------------------------------------------------
 
CloneItemButtonName =
{ ["protecterr"]=0, "Clone_Zen", "Clone_Cash", "Clone_Skill"}
CloneItemButtonTextPosX	= {['err'] = 0, 0, 70, 140}
CloneItemButtonTextPosY	= {['err'] = 0, 455, 476 ,497}
CloneItemButtonEvent = {["err"]=0, "Select_Clone_Zen","Select_Clone_Cash", "Select_Clone_Skill"}

for i=1, #CloneItemButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	CloneItemButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/deal.tga",				CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",			CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",		CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga", CloneItemButtonTextPosX[i], CloneItemButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",	190, 706);
	mywindow:setSize(70, 21);	
	mywindow:setPosition((72*i)-68,39);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", CloneItemButtonEvent[i]);
	winMgr:getWindow('CloneItemImage'):addChildWindow( winMgr:getWindow(CloneItemButtonName[i]) );
end

------------------------------------
--���ڽ�Ƭ����------------------
------------------------------------
function Select_Clone_Zen(args)
	DebugStr('Select_Clone_Zen');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Clone_Zen');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_ZEN
			ChangedCloneItemList(ITEMLIST_ZEN)
		end	
	end	
end

------------------------------------
--ĳ���ڽ�Ƭ�����ۼ���------------------
------------------------------------
function Select_Clone_Cash(args)
	DebugStr('Select_Clone_Cash');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Clone_Cash');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_CASH
			ChangedCloneItemList(g_currenItemList)
			
		end	
	end	
end

------------------------------------
--��ų�����ۼ���------------------
------------------------------------
function Select_Clone_Skill(args)
	DebugStr('Select_Clone_Skill');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Clone_Skill');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_SKILL
			ChangedCloneItemList(g_currenItemList)
		end	
	end	
end
-----------------------------------------------------------------------
-- ������Ŭ�� ��� â ������ư
-----------------------------------------------------------------------
tCloneItemRadio =
{ ["protecterr"]=0, "CloneItemList_1", "CloneItemList_2", "CloneItemList_3", "CloneItemList_4", "CloneItemItemList_5"}


for i=1, #tCloneItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tCloneItemRadio[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			296,583 );
	mywindow:setTexture("Hover", "UIData/deal.tga",			296,583);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			296,583);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",		296,583);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",296,583);
	mywindow:setTexture("Disabled", "UIData/deal.tga",			296, 583);
	mywindow:setSize(282, 52);
	mywindow:setPosition(7, 65+(i-1)*55);
	mywindow:setVisible(true);
	mywindow:setUserString('index', tostring(i))
	mywindow:setEnabled(true)
	winMgr:getWindow('CloneItemImage'):addChildWindow( winMgr:getWindow(tCloneItemRadio[i]) );
	
		
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ ��� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneSealItemImage_"..i)
	mywindow:setTexture("Enabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)

	-- ��ų ���� �׵θ� �̹���
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)


	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CloneItemList_Image_"..i):addChildWindow(mywindow)
	

	-- ���� �̺�Ʈ�� ���� �̹���	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("CloneRadioIndex", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CloneItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CloneVanishTooltip")
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)
	
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tCloneItemRadio[i]):addChildWindow(mywindow)
end

-----------------------------------------------------------------------
--������ ����Ʈ ÷�� ��ư 5��
-----------------------------------------------------------------------
 
tCloneItemButton =
{ ["protecterr"]=0, "CloneItemButton_1", "CloneItemButton_2", "CloneItemButton_3", "CloneItemButton_4", "CloneItemButton_5"}
 

for i=1, #tCloneItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tCloneItemButton[i]);	
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setSize(63,18 );	
	mywindow:setPosition(220,95+(i-1)*54);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false);
	mywindow:setUserString('CloneIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tCloneItemButtonEvent")
	winMgr:getWindow('CloneItemImage'):addChildWindow( winMgr:getWindow(tCloneItemButton[i]));
end

function ShowCloneItemList()
	winMgr:getWindow('CloneAlphaImage'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CloneAlphaImage'))
	winMgr:getWindow("CloneItemImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CloneItemImage'))
	winMgr:getWindow("CloneMainImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CloneMainImage'))
	
	for i=1, #CloneItemButtonName do	
		winMgr:getWindow(CloneItemButtonName[i]):setVisible(false)
	end
	
	-- ��ų �������� ������
	if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
		--winMgr:getWindow("Clone_Skill"):setVisible(true)
	-- ��ų �ŷ����� ������
	elseif ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLTRADEITEM then
	
	-- �ƹ�Ÿ Ŭ�� ������
	elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART then
		winMgr:getWindow("Clone_Zen"):setVisible(true)
		winMgr:getWindow("Clone_Cash"):setVisible(true)
	end

end

function CloseCloneItemList()
	DebugStr('CloseCloneItemList()')
	winMgr:getWindow("CloneItemImage"):setVisible(false)
	winMgr:getWindow("CloneMainImage"):setVisible(false)
	winMgr:getWindow('CloneAlphaImage'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CloneAlphaImage') );
end

-----------------------------------------------------------------------
-- Ŭ�� ������ �̸� �����̸� �������� ����
-----------------------------------------------------------------------
function SetupCloneItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade)
    
    local j=i+1
	winMgr:getWindow(tCloneItemRadio[j]):setVisible(true)
	winMgr:getWindow(tCloneItemButton[j]):setVisible(true)
	winMgr:getWindow("CloneSealItemImage_"..j):setVisible(false)
	-- ������ �����̸�
	winMgr:getWindow("CloneItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("CloneItemList_Image_"..j):setLayered(false)
	else
		winMgr:getWindow("CloneItemList_Image_"..j):setLayered(true)
		winMgr:getWindow("CloneItemList_Image_"..j):setTexture("Layered", itemFileName2, 0, 0)
	end	
	
	if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
		winMgr:getWindow("CloneSealItemImage_"..j):setVisible(true)
	end
	
	winMgr:getWindow("CloneItemList_Image_"..j):setScaleWidth(102)
	winMgr:getWindow("CloneItemList_Image_"..j):setScaleHeight(102)
	
	
	if itemGrade > 0 then
		winMgr:getWindow("CloneItemList_SkillLevelImage_"..j):setVisible(true)
		winMgr:getWindow("CloneItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		winMgr:getWindow( "CloneItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow( "CloneItemList_SkillLevelText_"..j):setText("+"..itemGrade)
	else
		winMgr:getWindow("CloneItemList_SkillLevelImage_"..j):setVisible(false)
		winMgr:getWindow("CloneItemList_SkillLevelText_"..j):setText("")
	end
	
	-- ������ �̸�
	winMgr:getWindow("CloneItemList_Name_"..j):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("CloneItemList_Num_"..j):setText(szCount)
	
	-- ������ �Ⱓ
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("CloneItemList_Period_"..j):setText(period)		
end

------------------------------------
---������ǥ���ؽ�Ʈ
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(110, 380)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CloneItemImage'):addChildWindow(mywindow)

------------------------------------
---�������յڹ�ư
------------------------------------
local tMyCloneItemList_BtnName  = {["err"]=0, [0]="MyCloneItemList_LBtn", "MyCloneItemList_RBtn"}
local tMyCloneItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
local tMyCloneItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
local tMyCloneItemList_BtnEvent = {["err"]=0, [0]= "OnClickCloneItemList_PrevPage", "OnClickCloneItemList_NextPage"}
for i=0, #tMyCloneItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyCloneItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyCloneItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyCloneItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyCloneItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyCloneItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyCloneItemList_BtnPosX[i], 378)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyCloneItemList_BtnEvent[i])
	winMgr:getWindow('CloneItemImage'):addChildWindow(mywindow)
end
---------------------------------------------------
-- CloneItemList ���� ������ / �ִ� ������
---------------------------------------------------
function CloneItemListPage(curPage, maxPage)
	g_curPage_CloneItemList = curPage
	g_maxPage_CloneItemList = maxPage
	
	winMgr:getWindow("CloneItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---�����������̺�Ʈ-------------------
------------------------------------
		 
function  OnClickCloneItemList_PrevPage()
  
	if g_curPage_CloneItemList > 1 then
		g_curPage_CloneItemList = g_curPage_CloneItemList - 1
		ChangedCloneItemListCurrentPage(g_curPage_CloneItemList)
	end
	
end
------------------------------------
---�����������̺�Ʈ-----------------
------------------------------------
function OnClickCloneItemList_NextPage()

	if g_curPage_CloneItemList < g_maxPage_CloneItemList then
		g_curPage_CloneItemList = g_curPage_CloneItemList + 1
		ChangedCloneItemListCurrentPage(g_curPage_CloneItemList)
	end
	
end
function ClearCloneItemList()
    DebugStr('ClearCloneItemList()')
	
	for i=1, 5 do
		winMgr:getWindow(tCloneItemRadio[i]):setVisible(false)
		winMgr:getWindow(tCloneItemButton[i]):setVisible(false)
		winMgr:getWindow("CostumeItemList_Pollution_Image_" .. i):setVisible(false)
		winMgr:getWindow("CostumeItemList_Visual_Avatar_Image_" .. i):setVisible(false)
		
	end
end



-- ������ ���
function tCloneItemButtonEvent(args)	
	DebugStr('tCloneItemButtonEvent start');
	
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("CloneIndex")
	
	
	index = index - 1
	DebugStr("÷�θ���Ʈ index: " .. index)
	
	local bEnable = SelectCloneItem(tonumber(index))
	
	if bEnable then
		CloneSelectItem()
		winMgr:getWindow("CloneSelectCancelBtn"):setVisible(true)
		--PlayWave('sound/countDown.wav');
	end
end


function CloneSelectItem()
	
	local itemCount, itemName, itemFileName, itemFileName2, itemskillLevel = GetSelectCloneChangeItemInfo()

	-- ������ �����̸�
	winMgr:getWindow("CloneSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("CloneSealItemImage"):setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	
	if itemFileName2 == "" then
		winMgr:getWindow("CloneSelectItemImage"):setLayered(false)
	else
		winMgr:getWindow("CloneSelectItemImage"):setLayered(true)
		winMgr:getWindow("CloneSelectItemImage"):setTexture("Layered", itemFileName2, 0, 0)	
	end	
	winMgr:getWindow("CloneSelectItemImage"):setScaleWidth(138)
	winMgr:getWindow("CloneSelectItemImage"):setScaleHeight(138)
	
	if ITEM_TYPE_CURRENT ~= ITEM_TYPE_UNSEALSKILLITEM then
		winMgr:getWindow("CloneSealItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
	
	if itemskillLevel > 0 then
		winMgr:getWindow("CloneSelectItemSkillLevelImage"):setVisible(true)
		winMgr:getWindow("CloneSelectItemSkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemskillLevel], 486)
		winMgr:getWindow("CloneSelectItemSkillLevelText"):setTextColor(tGradeTextColorTable[itemskillLevel][1], tGradeTextColorTable[itemskillLevel][2], tGradeTextColorTable[itemskillLevel][3], 255)
		winMgr:getWindow("CloneSelectItemSkillLevelText"):setText("+"..itemskillLevel)
	else
		winMgr:getWindow("CloneSelectItemSkillLevelImage"):setVisible(false)
		winMgr:getWindow("CloneSelectItemSkillLevelText"):setText("")
	end
end

function ClearCloneSelectItem()
	DebugStr('ClearCloneSelectItem')
	winMgr:getWindow("CloneSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("CloneSelectItemImage"):setTexture("Layered", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("CloneSealItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("CloneSealItemImage"):setTexture("Layered", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("CloneSelectItemSkillLevelText"):setText("")
	winMgr:getWindow("CloneSelectItemSkillLevelImage"):setVisible(false)
	winMgr:getWindow("CloneSelectCancelBtn"):setVisible(false)
end


----------------------------------------------------------------------
-- ������ Ŭ�� ���â
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneRewardImage")
mywindow:setTexture("Enabled", "UIData/bunhae_003.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/bunhae_003.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(250, 180)
mywindow:setSize(505, 402)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- ������ Ŭ�� ��� Ȯ�ι�ư
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloneRewardOkBtn")
mywindow:setTexture("Normal", "UIData/bunhae_001.tga", 330, 108)
mywindow:setTexture("Hover", "UIData/bunhae_001.tga", 330, 135)
mywindow:setTexture("Pushed", "UIData/bunhae_001.tga", 411, 108)
mywindow:setTexture("PushedOff", "UIData/bunhae_001.tga", 330, 108)
mywindow:setPosition(220, 360)
mywindow:setSize(81, 27)
mywindow:setVisible(true)
mywindow:setSubscribeEvent("Clicked", "OnClickCloneRewardOk")
winMgr:getWindow("CloneRewardImage"):addChildWindow(mywindow)

function OnClickCloneRewardOk()
	DebugStr('OnClickCloneRewardOk()')
	winMgr:getWindow("CloneRewardAlphaImage"):setVisible(false)
	winMgr:getWindow("CloneRewardImage"):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CloneRewardAlphaImage') );
	root:removeChildWindow( winMgr:getWindow('CloneRewardImage') );
end

RegistEscEventInfo("CloneRewardImage", "OnClickCloneRewardOk")

----------------------------------------------------------------------
--��� �����̹���
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CloneRewardAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- �̹����� ���콺�� ����� ������ �����Ѵ�.
function OnMouseLeave_CloneVanishTooltip()
	SetShowToolTip(false)	
end

-- ��ų �ŷ����Ѱ��� ����
function OnMouseEnter_CloneItemListInfo(args)
	DebugStr("��������")
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- ���� ���õ� �����츦 ã�´�.
	local index = tonumber(EnterWindow:getUserString("CloneRadioIndex"))
	index = index-1
	
	local itemKind, itemNumber = GetCloneTooltipInfo(WINDOW_MYITEM_LIST, index)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	
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
	
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

function OnMouseEnter_CloneSelectItemListInfo(args)
	DebugStr("OnMouseEnter_CloneSelectItemListInfo@@@@@@@@@@@@@")
	-- ���� ����ش�.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	index = 1
	local itemKind, itemNumber = GetSelectTooltipInfo()
	
	if itemNumber == 0 then
		return
	end
	
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

------------------------------------
--- ��ų ���Ұ� ���� ������ ���
------------------------------------
function UseUnsealSkillItem()
	winMgr:getWindow("CloneMainImage"):setTexture("Enabled", "UIData/popup002.tga", 0, 247)
	winMgr:getWindow("CloneMainImage"):setTexture("Disabled", "UIData/popup002.tga", 0, 247)
	-- Default�� ��ų���� �����´�
	SetCurrentClonetemMode(ITEMLIST_SKILL)
	SetCurrentCloneItemType()
	ITEM_TYPE_CURRENT = ITEM_TYPE_UNSEALSKILLITEM
	SetCurrentCloneItemType(ITEM_TYPE_CURRENT)
	RequestCloneList()
	ShowCloneItemList()
end

------------------------------------
--- ��ų �ŷ��Ұ� ���� ������ ���
------------------------------------
function UseUnsealSkillTradeItem()
	
	winMgr:getWindow("CloneMainImage"):setTexture("Enabled", "UIData/popup004.tga", 0, 247)
	winMgr:getWindow("CloneMainImage"):setTexture("Disabled", "UIData/popup004.tga", 0, 247)
	-- Default�� ��ų���� �����´�
	SetCurrentClonetemMode(ITEMLIST_SKILL)
	ITEM_TYPE_CURRENT = ITEM_TYPE_UNSEALSKILLTRADEITEM
	SetCurrentCloneItemType(ITEM_TYPE_CURRENT)
	RequestCloneList()
	ShowCloneItemList()
end