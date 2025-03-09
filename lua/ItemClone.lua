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
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------
local g_STRING_USING_PERIOD		= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- 사용기간
local g_STRING_UNTIL_DELETE		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- 삭제시까지
local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)			-- 수량

--------------------------------------------------------------------
-- 클론 코스튬 관련 스트링
--------------------------------------------------------------------
local g_STRING_USE_CLONE_AVATAR =		PreCreateString_3566	--GetSStringInfo(LAN_CLONE_MESSAGE_5)					-- 클론 코스튬을 다른 코스튬과 합성하면, 다시 분리할 때 캐시아이템이 필요합니다. 그래도 진행하시겠습니까? 
local g_STRING_QUESTION_CLEANUP_USE	 =	PreCreateString_3548	--GetSStringInfo(LAN_CLONE_POLLUTION_MESSAGE_1)	-- 정화템을 사용하시겠습니까?
local g_STRING_QUESTION_ROLLBACK_USE =	PreCreateString_3554	--GetSStringInfo(LAN_CLONE_ROLLBACK_1)				-- 일반 아바타로 변환 하시겠습니까?
local g_STRING_QUESTION_SEPARATE_USE =	PreCreateString_3551	--GetSStringInfo(LAN_CLONE_SEPARATE_MESSAGE_1)		-- 비쥬얼 아바타를 떼어내시게[ㅆ습니까?


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
--================================== 코스튬 아바타 관련 시작 ===================================================
--============================================================================================================== 3000 LINE End
local CostumeAvatarCreateFlag = 1
	if CostumeAvatarCreateFlag == 1 then
		
		----------------------------------------------------------------------
		-- 툴팁에 아이템이 설정 되었는지 체크
		----------------------------------------------------------------------
		g_bNowItemIsSelected  = false
		
		-- 클론 아바타 변환을 하시겠습니까? 버튼을 누른경우엔 값이 1로 변경 ... 플래그
		g_ItemCloneAttach = -1
		
		-- 전역 슬롯 인덱스 / 클론 아바타 툴팁 때문에
		g_ItemSlot = 0
		
		----------------------------------------------------------------------
		-- 현재 윈도우를 기준으로 list창의 내용을 구분하는 플래그
		----------------------------------------------------------------------
		MODE_CHANGE_COSTUME = 0
		MODE_SELECT_VISUAL	= 1
		MODE_USE_CLEANUP	= 2
		MODE_USE_SEPARATE	= 3
		MODE_USE_ROOLBACK	= 4
		
		g_nNowSelectedCostumeMode = MODE_CHANGE_COSTUME

		----------------------------------------------------------------------
		-- 클린업 아이템 종류 (캐시 , Zen)
		----------------------------------------------------------------------
		MODE_ZEN_CLEAN_UP	= 3
		MODE_CASH_CLEAN_UP	= 4
		
		g_nCleanUpItemType = -1
		
		g_nCleanUpMode	   = -1

		----------------------------------------------------------------------
		-- 정화하기 위해 선택된 코스튬 아바타
		----------------------------------------------------------------------
		g_nSelectedCleanupAvatar = 0

		----------------------------------------------------------------------
		-- 클론 아바타 관련 ESC, Enter 이벤트 등록★
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
		
		-- 클린업 창
		RegistEscEventInfo("CloneAvatarCleanUpMainImg"	,	"CleanUpWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarCleanUpMainImg",	"SendCleanupAvatarIndex")
		
		-- 분리 창
		RegistEscEventInfo("CloneAvatarSeparate_MainImg",	"SeparateWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarSeparate_MainImg", "UseSeparateItem")
		
		-- 롤백 창
		RegistEscEventInfo("CloneAvatarRollBack_MainImg",	"RollBackWndCloseEvent")
		RegistEnterEventInfo("CloneAvatarRollBack_MainImg", "UseRollBackItem")
		
		--------------------------------------------------------------------
		-- 애니메이션 틱
		--------------------------------------------------------------------
		g_AnimationTick = 0
				
		--------------------------------------------------------------------
		-- 애니메이션 폭파 이미지 포지션 pt
		--------------------------------------------------------------------
		g_BoomEffect_PosX = 166
		g_BoomEffect_PosY = 138
		
		--------------------------------------------------------------------
		-- 애니메이션 스핀 효과
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
			-- 1. 애니메이션 리셋
			ResetAnimation(1)
			
			-- 2. 애니 시작을 명시
			SetAnimationStart(1 , 1) -- arg1 -> 1 : 회전 / 2 : 폭팔
									 -- arg2 -> 0 , 1 트루 펄스

			-- 3. 사운드
			--PlayAnimationSound(1)
			PlayWave('sound/Clone_Spin.wav');
			
			winMgr:getWindow("Clone_Make_Effect"):setVisible(true)
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("Clone_Make_Effect")
		end
		
		function CloseSpinEffect()
			-- 1. 애니 시작을 명시
			SetAnimationStart(1 , 0) -- arg1 -> 1 : 회전 / 2 : 폭팔
									 -- arg2 -> 0 , 1 트루 펄스
			-- 2. 애니메이션 리셋
			ResetAnimation(1)
			
			winMgr:getWindow("Clone_Make_Effect"):setVisible(false)
			root:addChildWindow("Clone_Make_Effect")
		end
		
		
		--------------------------------------------------------------------
		-- 애니메이션 폭팔 효과
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
			-- 1. 애니메이션 리셋
			ResetAnimation(2)
			
			-- 2. 애니 시작을 명시
			SetAnimationStart(2 , 1) -- arg1 -> 1 : 회전		/ 2 : 폭팔
									 -- arg2 -> 0 : 애니 종료	/ 1 : 애니 시작
			-- 3. 사운드
			--PlayAnimationSound(2)
			
			-- 4. 상황에 맞게 성공 이펙트 위치 이동
			winMgr:getWindow("Clone_Make_Effect2"):setVisible(true)
			if type == 0 then -- 성공
				g_BoomEffect_PosX = 167
				g_BoomEffect_PosY = 139
				winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow("Clone_Make_Effect2")
				PlayWave('sound/Clone_Success.wav');
			elseif type == 1 then -- 실패
				g_BoomEffect_PosX = 166
				g_BoomEffect_PosY = 108
				winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow("Clone_Make_Effect2")
				PlayWave('sound/Clone_Fail.wav');
			elseif type == 2 then -- 변화없음
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
			-- 1. 애니 시작을 명시
			SetAnimationStart(2 , 0) -- arg1 -> 1 : 회전		/ 2 : 폭팔
									 -- arg2 -> 0 : 애니 종료	/ 1 : 애니 시작
			-- 2. 애니메이션 리셋
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
		-- 알파. ★
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
		-- 아이템 리스트 백판 (리스트의 위치이동을 위해 만듦) : 만들기
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
		-- 아이템 리스트 백판 ★ (리스트의 위치이동을 위해 만듦) : 비쥬얼 선택
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
		-- 아이템 리스트 백판 ★ (리스트의 위치이동을 위해 만듦) : 클린업
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
		-- 아이템 리스트 백판 ★ 리스트만 붙임 ( 아이템 사용시 : 분리 , 롤백 , 정화 )
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
		-- 코스튬 알파이미지
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
		-- [코스튬 아바타 만들기] 메인 윈도우
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
		-- OK 버튼 (최초 OK버튼)
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

		-- 코스튬 아바타 변환 함수
		function CostumeChangeConfirmButtonEvent()
			if g_bNowItemIsSelected == true then 
				QuestionAvatarChange() 
				DebugStr("코스튬 변환 승인")
			end
		end	


		----------------------------------------------------------------------
		-- [코스튬 아바타 만들기] 확인 공지창
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
		-- 종료 확인, 취소 "버튼" ★
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
		-- [코스튬 아바타 만들기] 성공 윈도우
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
		-- [코스튬 아바타 만들기] 성공 버튼 ( 마지막 단계 )
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
		-- [코스튬 아바타 만들기] 요청
		------------------------------------------------------------------------
		function SetChangeCostumeAvatarSucceess()
			-- 서버로 패킷 전송전에 애니메이션을 돌린다
			-- 애니메이션이 끝나면 서버 처리
			StartSpinEffect()
			
			-- 확인 / 취소 버튼 비활성화
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(false)
			
			--[[
			-- 1. 서버로 필요패킷 전송
			RequestCreateCostumeAvatar()
			
			-- 2. 공지창을 종료
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
			]]--
		end
		
		-- 클론 아바타 변환 결과
		function ShowNotifyMakeCloneAvatar()
			-- 1. 서버로 필요패킷 전송
			RequestCreateCostumeAvatar()
			
			-- 2. 공지창을 종료
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
		end

		------------------------------------------------------------------------
		-- [코스튬 아바타 만들기] 거부
		------------------------------------------------------------------------
		function SetChangeCostumeAvatarFailed()
			-- @ 팝업창만 끄면 된다
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(false)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(false)
			
			-- 등록 버튼 활성화
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			-- @ 비활성화 된 버튼들을 활성
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			SetUselessBtnEnable(true)
		end



		------------------------------------------------------------------------
		-- 코스튬 아바타 변환 성공 (ClientCallBack.cpp)
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarSuccess()
			-- 성공창 설정
			root:addChildWindow(winMgr:getWindow("Costume_Change_SuccessWIndow"))
			winMgr:getWindow("Costume_Change_SuccessWIndow"):setVisible(true)		-- 성공창 띄우기
			
			-- 확인 버튼 설정
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- 성공창에 확인버튼 링크
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)		-- 확인 버튼
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(124, 222)	-- 확인버튼 위치 설정
			
			-- 툴팁의 부모설정
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- 툴팁 아이콘 이미지
			winMgr:getWindow("Costume_Change_SuccessWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- 툴팁 정보
			
			-- 툴팁 위치를 재설정
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 111)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 111)
			
			
			-- 클론 아바타 모양으로 아이콘을 변경 ★
			SetAvatarIcon("CostumeSelectItemImage2" , "CostumeSelectItemImage2" , -1 , g_ItemCloneAttach)
			
			DebugStr("클론 아바타로 변환 성공!")
			
			g_NoChangeMessageNext = 0
			
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end
		------------------------------------------------------------------------
		-- 코스튬 아바타 변환 실패 (ClientCallBack.cpp)
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarFailed()
			-- 실패창 설정
			root:addChildWindow(winMgr:getWindow("Costume_Change_FailedWIndow"))
			winMgr:getWindow("Costume_Change_FailedWIndow"):setVisible(true)		-- 실패창 띄우기
			
			-- 확인 버튼 설정
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- 실패창에 확인버튼 링크
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)			-- 확인 버튼
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(130, 325)		-- 확인버튼 위치 설정
				
			-- 툴팁의 부모설정
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- 툴팁 아이콘 이미지
			winMgr:getWindow("Costume_Change_FailedWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- 툴팁 정보
			
			-- 툴팁 위치를 재설정
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 81)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 81)
			
			g_NoChangeMessageNext = 0
			
			DebugStr("클론 아바타로 변환 실패!")
			
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end
		
		g_NoChangeMessageNext = 0
		
		------------------------------------------------------------------------
		-- 코스튬 아바타 변환 실패 아무변화없음 ★ 
		------------------------------------------------------------------------
		function NotifyCreateCostumeAvatarNoChange()
			-- 실패창 설정
			root:addChildWindow(winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"))
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):setVisible(true)		-- 실패창 띄우기
			
			-- 확인 버튼 설정
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("Costume_Change_SuccessOKButton") ) -- 실패창에 확인버튼 링크
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(true)			-- 확인 버튼
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setPosition(125, 220)		-- 확인버튼 위치 설정
				
			-- 툴팁의 부모설정
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemImage2") )			-- 툴팁 아이콘 이미지
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):addChildWindow( winMgr:getWindow("CostumeSelectItemToolTipImage2") )	-- 툴팁 정보
			
			-- 툴팁 위치를 재설정
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138, 110)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 110)
			
			DebugStr("클론 아바타로 변환 실패! 하지만 변화없음")
						
			g_NoChangeMessageNext = 1 -- 메시지를 봤음을 명시★
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
		end

		function ConfirmBtnEnable(flag)
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(flag)
		end
		
		-- 하드코딩함 나중에 수정하겠음...
		function RadioButtonEnable()
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
		end

		----------------------------------------------------------------------
		-- [코스튬 아바타 만들기] 마지막 함수
		----------------------------------------------------------------------
		function CreateCostumeAvatarDone()
			-- @ 리스트의 탭 (Zen 기본 Select)
			--winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			local MyZen = GetMyMoney()
			DebugStr("MyZen : " .. MyZen)
			local r,g,b = GetGranColor(MyZen)
			local granText = CommatoMoneyStr(MyZen)
			textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
			winMgr:getWindow("Costume_My_Money_Text"):setTextColor(r,g,b,255)	
			winMgr:getWindow("Costume_My_Money_Text"):setPosition(115 - textSize, 407)
			winMgr:getWindow("Costume_My_Money_Text"):setText(granText)
			
					
			-- @ 공지창을 끈다.
			winMgr:getWindow('Costume_AlphaImage'):setVisible(false)
			winMgr:getWindow("Costume_Change_SuccessWIndow"):setVisible(false)	-- 성공창
			winMgr:getWindow("Costume_Change_FailedWIndow"):setVisible(false)	-- 실패창
			winMgr:getWindow("Costume_Change_FailedNoChangeWIndow"):setVisible(false)	-- 아무변화없음창
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(false)
			
			-- @ 툴팁을 리셋시켜줘야 한다.
			--OnCostumeClickSelectCancle()
			
			-- @ 확인 버튼을 회색으로 비활성화 해준다.
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)	-- 글자 비활성화
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			
			
			
			-- @ 툴팁의 뒤에 있는 UI의 선택을 잠근다
			SetUselessBtnEnable(true)
			
			-- @ 툴팁2의 '위치'와 '부모'를 재설정 해준다
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(136 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(136 , 124)
			
			g_currenItemList = ITEMLIST_ZEN
			ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			
			-- 등록 버튼 활성화
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			if g_NoChangeMessageNext == 1 then
				ConfirmBtnEnable(true)
			end
			
			
			
			-- Old Code : BackUP
			if	winMgr:getWindow("CloneAvatar_Zen") ~= nil and
				winMgr:getWindow("CloneAvatar_Cash") ~= nil then
				-- 마지막에 선택한 탭을 그대로 이어간다.
				if winMgr:getWindow("CloneAvatar_Zen"):isSelected() == true then
					-- 젠 탭 설정
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "false")
					
					g_currenItemList = ITEMLIST_ZEN
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				else
					-- 캐시 탭 설정
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "false")
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
					
					g_currenItemList = ITEMLIST_CASH
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				end
			else
				-- 에러가 났어도 확인버튼은 활성화 시켜준다.
				-- 확인 / 취소 버튼 비활성화
				winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
				winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
				return
			end -- ~=nil then
			
			
			--[[
			if	winMgr:getWindow("MergeList_Zen") ~= nil and
				winMgr:getWindow("MergeList_Cash") ~= nil then
				-- 마지막에 선택한 탭을 그대로 이어간다.
				if winMgr:getWindow("MergeList_Zen"):isSelected() == true then
					-- 젠 탭 설정
					winMgr:getWindow("MergeList_Zen"):setProperty("Selected" , "true")
					winMgr:getWindow("MergeList_Cash"):setProperty("Selected" , "false")
					
					g_currenItemList = ITEMLIST_ZEN
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				else
					-- 캐시 탭 설정
					winMgr:getWindow("MergeList_Zen"):setProperty("Selected" , "false")
					winMgr:getWindow("MergeList_Cash"):setProperty("Selected" , "true")
					
					g_currenItemList = ITEMLIST_CASH
					ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				end
			else
				-- 에러가 났어도 확인버튼은 활성화 시켜준다.
				-- 확인 / 취소 버튼 비활성화
				winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
				winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
				return
			end -- ~=nil then
			]]--
			
			-- 확인 / 취소 버튼 비활성화
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
		end


		----------------------------------------------------------------------
		-- [코스튬 아바타 만들기] 실패 창
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
		-- [코스튬 아바타 만들기] 실패 창 (아무변화 없음) ★★
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
		-- [코스튬 아바타] 닫기 버튼 "X버튼"
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
		-- [아바타 코스튬]에 관련된 모든창을 닫기
		----------------------------------------------------------------------
		function CostumeCloseEvent()
			VirtualImageSetVisible(false)
			
			winMgr:getWindow("Costume_My_Money_Text"):setVisible(false)
			winMgr:getWindow("Costume_My_Zen_Icon"):setVisible(false)
			
			--CloseCommonItemList()
			
			local CurrentWndType = GetCurrentWndType()
			if CurrentWndType == 12 then
				--DebugStr("빌리지")
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
			
			
			-- @ 툴팁2의 '위치'와 '부모'를 재설정 해준다
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(140 , 124)
			
			
			winMgr:getWindow('Visual_SelectedToolTip'):setVisible(false)
			winMgr:getWindow('Visual_SelectedToolTipImage'):setVisible(false)
			
			for i=1, #CostumeItemButtonName do	
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(true)
			end
			
			-- 등록 버튼 활성화
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end			
			
			-- @ 뒷배경의 버튼들을 활성화
			SetUselessBtnEnable(true)
			DebugStr("OnCostumeClickSelectCancle() 호출됨1")
			OnCostumeClickSelectCancle()
			
			-- 확인 / 취소 버튼 비활성화
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
				--DebugStr("빌리지")
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
			
			
			-- @ 툴팁2의 '위치'와 '부모'를 재설정 해준다
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemToolTipImage2")
			winMgr:getWindow("Costume_Change_NoticeWindow"):addChildWindow("CostumeSelectItemImage2")
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138 , 124)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(140 , 124)
			
			
			-- 등록 버튼 활성화
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(true)
			end
			
			winMgr:getWindow('Visual_SelectedToolTip'):setVisible(false)
			winMgr:getWindow('Visual_SelectedToolTipImage'):setVisible(false)
			
			for i=1, #CostumeItemButtonName do	
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(true)
			end
			
			-- 확인 / 취소 버튼 비활성화
			winMgr:getWindow("Costume_Change_OKButtone"):setEnabled(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setEnabled(true)
			
			-- @ 뒷배경의 버튼들을 활성화
			SetUselessBtnEnable(true)
			DebugStr("OnCostumeClickSelectCancle() 호출됨22")
			OnCostumeClickSelectCancle()
		end


		----------------------------------------------------------------------
		-- [코스튬 아바타] 아이템 리스트 ★
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
		
		-- 리스트창에 젠아이콘
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
		
		-- 리스트창에 내 소지금 텍스트
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
		-- [코스튬 아바타 비쥬얼] 선택 메인창
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
		-- [코스튬 아바타 비쥬얼] 확인 버튼
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
		-- [코스튬 아바타 비쥬얼] 선택 --> 데이터 처리
		--------------------------------------------------------------------
		function SetCostumeVisual()
			-- @ Visual아바타 인덱스를 저장
			SaveVisualAvatarIndex()
			
			-- @ 변환창과 버튼 클로즈
			winMgr:getWindow("Costume_Visual_Main"):setVisible(false)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setVisible(false)
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			
			-- @ 알파 이미지 Off
			winMgr:getWindow("Costume_AlphaImage"):setVisible(false)
			
			-- @ 모든 툴팁 리셋
			DebugStr("OnCostumeClickSelectCancle() 호출됨3")
			OnCostumeClickSelectCancle()
				
			-- @ 클론,비쥬얼 아바타 인덱스를 서버에 전송
			RequestSetVisualCostumeAvatar()
			
			-- @ 툴팁 재설정
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setVisible(false)
			winMgr:getWindow("CostumeSelectItemImage3"):setVisible(false)
			
			-- @ 리스트창 아이템이 선택X
			g_bNowItemIsSelected = false
			
			-- @ 리스트 모두 닫기
			CostumeCloseEvent()	
		end


		-- 스킬 레벨 테두리 
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


		-- 스킬레벨 + 글자
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


		-- 선택 취소 버튼
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


		-- 선택된 아이템 취소
		function OnCostumeClickSelectCancle()
			--winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			ResetCloneSelectItemInfo()
			ClearCostumeSelectItem()
		end


		-- 아이템 잠금 이미지
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
		-- 툴팁 아이템 이미지 ★
		-- 고정 툴팁 전용
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
		-- 툴팁 설명창 ★
		-- 고정 툴팁 전용
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
		-- 툴팁 아이템 이미지2 ★ 
		-- [코스튬 아바타 만들기]에서 사용.
		-- [CostumeSelectItemImage]와 모든 내용이 일치해야한다
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
		-- 툴팁 설명창2 ★
		-- [코스튬 아바타 만들기]에서 사용.
		-- [CostumeSelectItemToolTipImage]와 모든 내용이 일치해야한다
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
		-- 툴팁 설명창2 ★
		-- [코스튬 아바타 만들기]에서 사용.
		-- 뒷배경 까는데 사용함.
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
		-- 툴팁 아이템 이미지3 ★ [LEFT]
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
		-- 툴팁 설명창3 ★
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
		-- 툴팁 아이템 이미지4 ★ [RIGHT]
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
		-- 툴팁 설명창4 ★
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
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectedCostumeAvatar") -- 4번만의 함수를 만들어서 처리.
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CostumeVanishTooltip")
		winMgr:getWindow('Costume_Visual_Main'):addChildWindow(mywindow)



		-- 툴팁4에서만 사용하는 고유함수
		-- Visual_SelectedToolTip
		function OnMouseEnter_SelectedCostumeAvatar(args)
			-- 툴팁 띄워준다.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			--DebugStr("현재 윈도우 모드 : " .. g_nNowSelectedCostumeMode)
			local itemKind, itemNumber = GetVisualModeRightToolTipInfo()
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- 아이템이 설정 되어 있지 않다 ★
				DebugStr("선택된 툴팁 이미지 리턴당함")
				return
			end
			
			g_bNowItemIsSelected = true			-- 아이템이 설정 되어 있다.★

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
			
			GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
			SetShowToolTip(true)

		end



		-- 클론 아바타 툴팁 설정 
		function OnMouseEnter_CostumeAvatarItemInfo(args)
			-- 툴팁 띄워준다.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			-- 현재 선택된 윈도우를 찾는다.
			local index = tonumber(EnterWindow:getUserString("CostumeRadioIndex"))
			index = index - 1
			
			local itemKind, itemNumber = GetCostumeTooltipInfo(WINDOW_MYITEM_LIST , index)
			itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- 아이템이 설정 되어 있지 않다 ★
				DebugStr("리턴")
				return
			end
			
			g_bNowItemIsSelected = true			-- 아이템이 설정 되어 있다.★

				
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
			
			--GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
			--DebugStr("g_ItemSlot : " .. g_ItemSlot)
			GetToolTipBaseInfo(x + 50, y, 2, Kind, g_ItemSlot, itemNumber, 2)	-- 툴팁에 괜한 정보를 세팅해준다.
			SetShowToolTip(true)
		end



		function OnMouseEnter_CostumeSelectItemListInfo(args)
			-- 툴팁 띄워준다.
			local EnterWindow = CEGUI.toWindowEventArgs(args).window
			local x, y = GetBasicRootPoint(EnterWindow)
			
			--DebugStr("현재 윈도우 모드 : " .. g_nNowSelectedCostumeMode)
			local itemKind, itemNumber = GetSelectCostumeAvatarTooltipInfo(g_nNowSelectedCostumeMode)
			
			if itemNumber == 0 then
				g_bNowItemIsSelected = false	-- 아이템이 설정 되어 있지 않다 ★
				DebugStr("선택된 툴팁 이미지 리턴당함")
				return
			end
			
			g_bNowItemIsSelected = true			-- 아이템이 설정 되어 있다.★

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
			
			GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
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
		-- 클론 아바타 변환을 다시 한번 마지막으로 물어봄
		----------------------------------------------------------------------
		function QuestionAvatarChange()
			local MyMoney = GetMyMoney()
			if MyMoney < 50000 then
				ShowNotifyOKMessage_Lua(PreCreateString_9)	--GetSStringInfo(LAN_SHORT_MONEY)
				CreateCostumeAvatarDone()
				return				
			end
			
			
			-- 등록 버튼 비활성화
			for i = 1 , 5 do
				winMgr:getWindow("CostumeItemButton_" .. i):setEnabled(false)
			end
			
			-- 메인창 재설정
			winMgr:getWindow("Costume_Make_Root"):setAlwaysOnTop(false)

			-- @ 툴팁2 위치 재설정
			winMgr:getWindow("CostumeSelectItemImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage2"):setPosition(138 , 123)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage2"):setPosition(138, 123)
			
			-- @ 아바타 변환을 물어보는 공지창
			root:addChildWindow(winMgr:getWindow("Costume_Change_NoticeWindow"))
			winMgr:getWindow("Costume_Change_NoticeWindow"):setAlwaysOnTop(true)	
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(true)
			
			-- @ YES , NO 버튼 띄우기
			winMgr:getWindow("Costume_Change_OKButtone"):setVisible(true)
			winMgr:getWindow("Costume_Change_NOButtone"):setVisible(true)
			
			-- @ 사용하지 않는 버튼은 모두 잠근다
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			SetUselessBtnEnable(false)	-- 리스트창 및 기타 버튼들을 비활성화
		end


		----------------------------------------------------------------------
		-- ChageCloneDisagree() - 사용하는곳이 없다. 확인해봐야암.. ★★ -
		-- 클론 아바타 최종 결정때 Cancel버튼 클릭시 호출 함수
		----------------------------------------------------------------------
		function ChageCloneDisagree()
			winMgr:getWindow("Costume_Change_NoticeWindow"):setVisible(false)
			winMgr:getWindow("Costume_Change_ConfirmButton"):setVisible(false)
			winMgr:getWindow("ChangeCloneCancelBtn"):setVisible(false)
			winMgr:getWindow("Costume_Change_SuccessOKButton"):setVisible(false)
		end


		----------------------------------------------------------------------
		-- CloneCancelBtnEvent()
		-- 아바타를 클론 아바타로 변환 시작 함수
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
		--코스튬 , 스킬 , 기타  , 스폐셜
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
		--장비 , 아바타 ( 아바타 코스튬 ★ )
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
		--젠코스튬선택------------------
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
						if g_nCleanUpMode == 1 then	-- 정화
							g_currenItemList = ITEMLIST_POLLUTION_ZEN_AVATAR -- 4
							ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode) -- 2
						end
						if g_nCleanUpMode == 2 then -- 분리
							g_currenItemList = ITEMLIST_POLLUTION_ZEN_AVATAR	-- 4
							ChangedCostumeItemList(g_currenItemList , 3)		-- 3
						end
					end	-- end of if
				end	-- end of if
			end	-- end of if
		end	-- end of function
		


		------------------------------------
		--캐쉬코스튬아이템선택------------------
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
						if g_nCleanUpMode == 1 then	-- 정화
							g_currenItemList = ITEMLIST_POLLUTION_CASH_AVATAR -- 5
							ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode) -- 2
						end
						
						if g_nCleanUpMode == 2 then -- 분리
							g_currenItemList = ITEMLIST_POLLUTION_CASH_AVATAR	-- 5
							ChangedCostumeItemList(g_currenItemList , 3)		-- 3
						end
					end	-- end of if
				end	
			end	
		end




		-----------------------------------------------------------------------
		-- 아이템클론 목록 창 라디오버튼
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
			
			-- 아이템 이미지
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
			
			-- 비쥬얼 아바타가 올라갈 이미지 ★
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
			
					
			-- 아이템 잠금 이미지
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
			
			-- 오염된 아바타의 녹색 이미지 ★
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

			-- 스킬 레벨 테두리 이미지
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


			-- 스킬레벨 + 글자
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeItemList_SkillLevelText_"..i)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setTextColor(255,255,255,255)
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
			mywindow:setPosition(31, 32)
			mywindow:setSize(40, 20)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow("CostumeItemList_Image_"..i):addChildWindow(mywindow)
			

			-- 툴팁 이벤트를 위한 이미지
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
				
			
			-- 아이템 이름
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
			
			-- 아이템 갯수
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
			
			-- 아이템 기간
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
		--아이템 리스트 첨부 버튼 5개
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


		function ShowSelectCostumeAvatarList()	-- 클론 아바타 외형 설정 ☆		
			-- CostumeItemList : 아바타 리스트창
			winMgr:getWindow("CostumeItemList"):setVisible(true)
		
			for i=1, #CostumeItemButtonName do
				winMgr:getWindow(CostumeItemButtonName[i]):setVisible(false)
			end
			
			
			if ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART then				-- 비쥬얼 선택하는 부분
				DebugStr("비쥬얼 선택하는 부분");
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(true)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(true)
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_MAKE then		-- 아바타 만드는 부분
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(true)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(true)
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_CLEANUP then
				if g_nCleanUpMode == 1 then			-- 정화 아이템 사용
					winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
					DebugStr("정화 아이템 쓰는곳 들어옴")
				elseif g_nCleanUpMode == 2 then	-- 분리 아이템 사용
					winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
					winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
					DebugStr("분리 아이템 쓰는곳 들어옴")
				end
			
			elseif ITEM_TYPE_CURRENT == ITEM_TYPE_ITEMAVART_ROOL_BACK then
				winMgr:getWindow("CloneAvatar_Zen"):setVisible(false)
				winMgr:getWindow("CloneAvatar_Cash"):setVisible(false)
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
				DebugStr("롤백 아이템 쓰는곳 들어옴")
			end
			
			-- 아이템 다시 불러오기
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
		-- 클론 아이템 이름 파일이름 갯수등을 설정
		-----------------------------------------------------------------------
		function SetupCostumeItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade , avatarTypeValue , attach)
			local j=i+1
			
			winMgr:getWindow(tCostumeItemRadio[j]):setVisible(true)
			winMgr:getWindow(tCostumeItemButton[j]):setVisible(true)
			winMgr:getWindow("CostumeSealItemImage_"..j):setVisible(false)
			winMgr:getWindow("CostumeItemList_Pollution_Image_" .. j):setVisible(false)
			
			if avatarTypeValue > 0 then			-- 비쥬얼 설정된 클론 아바타<- 분리
				-- 아이콘 변경
				SetItemListAvatarIconS("CostumeItemList_Image_" ,"CostumeItemList_Visual_Avatar_Image_" ,
										j , avatarTypeValue , attach )
				
				-- 툴팁에 들어갈 슬롯 인덱스값 변경
				g_ItemSlot = -6
			elseif avatarTypeValue == -1 then	-- pure 클론 아바타			<- 롤백
				-- 아이콘 변경
				SetItemListAvatarIconS("CostumeItemList_Image_" ,"CostumeItemList_Image_" ,
										j , avatarTypeValue , attach )
				-- 툴팁에 들어갈 슬롯 인덱스값 변경
				g_ItemSlot = -7
			elseif avatarTypeValue == -2 then	-- 오염된 아바타			<- 정화
				winMgr:getWindow("CostumeItemList_Pollution_Image_" .. j):setVisible(true)
				
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleWidth(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleHeight(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
			else -- 일반 아바타
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleWidth(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setScaleHeight(120)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
				
				g_ItemSlot = 0
			end
	
			
			-- 캐시 아바타 황금 테두리
			if itemFileName2 == "" then
				winMgr:getWindow("CostumeItemList_Image_"..j):setLayered(false)
			else
				winMgr:getWindow("CostumeItemList_Image_"..j):setLayered(true)
				winMgr:getWindow("CostumeItemList_Image_"..j):setTexture("Layered", itemFileName2, 0, 0)
			end	
			
			-- 아이템 잠김 체크
			if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
				winMgr:getWindow("CostumeSealItemImage_"..j):setVisible(true)
			end
			
			-- 아이템 등급
			if itemGrade > 0 then
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setVisible(true)
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
				winMgr:getWindow( "CostumeItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
				winMgr:getWindow( "CostumeItemList_SkillLevelText_"..j):setText("+"..itemGrade)
			else
				winMgr:getWindow("CostumeItemList_SkillLevelImage_"..j):setVisible(false)
				winMgr:getWindow("CostumeItemList_SkillLevelText_"..j):setText("")
			end
			
			-- 아이템 이름
			winMgr:getWindow("CostumeItemList_Name_"..j):setText(itemName)
			
			-- 아이템 갯수
			local countText = CommatoMoneyStr(itemUseCount)
			local szCount = g_STRING_AMOUNT.." : "..countText
			winMgr:getWindow("CostumeItemList_Num_"..j):setText(szCount)
			
			-- 아이템 기간
			local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
			winMgr:getWindow("CostumeItemList_Period_"..j):setText(period)		
		end




		------------------------------------
		---페이지표시텍스트
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
		---페이지앞뒤버튼
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
		-- CloneItemList 현재 페이지 / 최대 페이지
		---------------------------------------------------
		function CostumeItemListPage(curPage, maxPage)
			g_curPage_CloneItemList = curPage
			g_maxPage_CloneItemList = maxPage
			
			winMgr:getWindow("CostumeItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
			--winMgr:getWindow("MergeItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
		end

		------------------------------------
		---이전페이지이벤트-------------------
		------------------------------------
		function  OnClickCostumeItemList_PrevPage()
			--DebugStr("11")
			if g_curPage_CloneItemList > 1 then
				g_curPage_CloneItemList = g_curPage_CloneItemList - 1
				ChangedCostumeItemListCurrentPage(g_curPage_CloneItemList , g_nNowSelectedCostumeMode)
			end
			
		end

		------------------------------------
		---다음페이지이벤트-----------------
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
		-- 등록 버튼
		--------------------------
		function tCostumeItemButtonEvent(args)	
			-- '확인'버튼 색상 정상적으로 변경 ★ [코스튬 아바타 만들기]
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(true)
			
			-- 확인버튼 활성화 및 색상 변경 [코스튬 아바타 외형 설정하기]
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setEnabled(true)
			
			-- 아이템 인덱스 받아오기
			local index = CEGUI.toWindowEventArgs(args).window:getUserString("CostumeIndex")
			--local index = CEGUI.toWindowEventArgs(args).window:getUserString("RegBtnIndex")
			index = index - 1
			
			
			-- 선택한 목록의 아이템 슬롯 인덱스 전송
			local bEnable = SelectCostumeItem(index , g_nNowSelectedCostumeMode)
						
			if bEnable then
				g_bNowItemIsSelected = true;	-- 아이템이 선택 되었음
				SelectCostumeToolTipImage()		-- 툴팁의 이미지를 설정한다
				winMgr:getWindow("CostumeSelectCancelBtn"):setVisible(true)
			end
			
				
			-- 툴팁의 행동을 변경
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
				DebugStr("클린업 라디오버튼")
				OpenCleanUpMainWindow()
				--OpenCleanUpPopup()
			elseif g_nNowSelectedCostumeMode == MODE_USE_ROOLBACK then
				DebugStr("롤백 라디오버튼")
				OpenRollBackMainWindow()
				--OpenRollBackPopup()
			elseif g_nNowSelectedCostumeMode == MODE_USE_SEPARATE then
				DebugStr("분리하기 라디오버튼")
				OpenSeparateMainWindow()
				--OpenSeparatePopup()				
			end
		
		end


		--------------------------------------------------------------------------
		-- SelectCostumeToolTipImage()
		-- 툴팁 이미지 설정 함수
		--------------------------------------------------------------------------
		function SelectCostumeToolTipImage()
			-- 아바타 변환 or 비쥬얼을 선택하는 부분이 아니라면 리턴 ★
			if g_nNowSelectedCostumeMode == MODE_USE_CLEANUP or g_nNowSelectedCostumeMode == MODE_USE_SEPARATE or g_nNowSelectedCostumeMode == MODE_USE_ROOLBACK then
				DebugStr("셀렉트코스튬툴팁이미지에서 리턴 : " .. g_nNowSelectedCostumeMode)
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
							
				g_ItemCloneAttach = attach -- ★
							
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
		-- 선택된 코스튬 아바타 툴팁 이미지를 설정
		--------------------------------------------------------------------------
		function SetCostumeAvatarToolTip()
			local itemName, itemFileName, itemFileName2 = GetSelectedCostumeItemInfo()
			
			--DebugStr("아이템 네임 : " .. itemName)
			--DebugStr("파일 이름1 : " .. itemFileName)
			--DebugStr("파일 이름2 : " .. itemFileName2)
			
			-- 아이템 파일이름
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

		-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
		function OnMouseLeave_CostumeVanishTooltip()
			SetShowToolTip(false)	
		end


		---------------------------------------------------------------------------------------------------------------------------------------------
		--- 클론 아바타 만들기 ★ 1
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UseCreateCloneAvatarItem()
			--==========================================
			-- X버튼 달기
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(310 , 10)
							
			
			--==========================================
			-- 인벤토리 강제 종료 , 버튼 비활성화
			--==========================================
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			--==========================================
			-- 리스트 업데이트를 위한 플래그 설정
			--==========================================
			g_nNowSelectedCostumeMode	= MODE_CHANGE_COSTUME
			g_nCleanUpItemType			= MODE_CHANGE_COSTUME
			
			
			--==========================================	
			-- 리스트 '부모'를 재설정
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
			
						
			-- 공통 아이템 리스트창 불러오기
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
			-- 리스트의 탭 (ZEN으로 기본설정)
			--==========================================
			winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(110 , 380)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(93 , 378)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(192 , 378)
				

			--==========================================
			-- 아이템 미 선택시 확인버튼 비활성화
			--==========================================
			winMgr:getWindow("Costume_Change_ConfirmButton"):setEnabled(false)
			
			
			--==========================================
			-- 툴팁의 재설정
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow(winMgr:getWindow("CostumeSelectItemImage"))
			winMgr:getWindow("Costume_Change_MainWindow"):addChildWindow(winMgr:getWindow("CostumeSelectItemToolTipImage"))
			winMgr:getWindow("CostumeSelectItemImage"):setPosition(140 , 82)
			winMgr:getWindow("CostumeSelectItemToolTipImage"):setPosition(140, 82)	
			
			
			--==========================================
			-- 리스트창 관련 설정
			--==========================================
			SetCurrentClonetemMode(ITEMLIST_ZEN)		-- 아이템 '모드' 설정
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)	-- 아이템 '타이프' 설정
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_MAKE -- 탭 때문에 어쩔수 없다 -_-
			
			
			--==========================================
			-- 리스트창 업데이트
			--==========================================
			g_currenItemList = ITEMLIST_ZEN
			ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			ShowSelectCostumeAvatarList()	-- 리스트창 보여주기
		end

		---------------------------------------------------------------------------------------------------------------------------------------------
		--- 클론 아바타 Visual 설정하기 ☆ -> 2
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserSelectCloneAvatarLooks(IsCash)
			--winMgr:getWindow("Costume_AlphaImage"):setVisible(true)
			
			-- 마이룸에서 인벤토리를 열고 사용을 방지 ★
			local CurrentWndType = GetCurrentWndType()
			if CurrentWndType == 3 then -- (3 == MyRoom)
				if	winMgr:getWindow("MyRoom_Title"):isVisible() == true and 
					winMgr:getWindow("MyInven_BackImage"):isVisible() == true then
					
					ShowNotifyOKMessage_Lua("Inventory Use No")
					DebugStr("외형 리턴")
					return
				end
			end
			
			--==========================================
			-- 인벤토리 강제 종료 , 버튼 비활성화
			--==========================================
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			--==========================================
			-- 사용하지 않는 메인윈도우 닫기
			--==========================================
			winMgr:getWindow("Costume_Change_MainWindow"):setVisible(false)
			
			
			--==========================================
			-- 리스트 업데이트를 위한 플래그 설정
			--==========================================
			--g_nNowSelectedCostumeMode = MODE_SELECT_VISUAL
			--ChangedCostumeItemList(ITEMLIST_ZEN , g_nNowSelectedCostumeMode)
			
			g_nCleanUpItemType = MODE_SELECT_VISUAL
			
			
			--==========================================
			-- 아이템 미 선택시 확인버튼 비활성화
			--==========================================
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setEnabled(false)
			
			--[[
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Normal",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Hover",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("Pushed",		"UIData/popup002.tga", 339, 307)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setTexture("PushedOff",	"UIData/popup002.tga", 339, 307)
			]]--
			
			--==========================================
			-- 툴팁을 설정(비쥬얼 설정 전용 툴팁)
			--==========================================
			SetCostumeAvatarToolTip()
			
			
			--==========================================
			-- X버튼 달아주기
			--==========================================
			winMgr:getWindow("Costume_Visual_Main"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(268 , 8)


			--==========================================
			-- 메인 윈도우 , 확인버튼 보이기
			--==========================================
			winMgr:getWindow("Costume_Visual_Main"):setVisible(true)
			winMgr:getWindow("Costume_Visual_SelectOKButton"):setVisible(true)
			
			
			--==========================================	
			-- 리스트 '부모'를 재설정
			--==========================================
			winMgr:getWindow("Costume_Visual_Root"):addChildWindow('Costume_Visual_Main')
			winMgr:getWindow("Costume_Visual_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Visual_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 631)/2 )
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 191)
			
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Visual_Root"):setVisible(true)
			winMgr:getWindow("Costume_Visual_Main"):setVisible(true)
			
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)


			--==========================================			
			-- 코스튬 아바타의 툴팁과 아이콘 이미지 시각화
			--==========================================
			winMgr:getWindow("CostumeSelectItemImage3"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemImage3"):setPosition(49,94)
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setVisible(true)
			winMgr:getWindow("CostumeSelectItemToolTipImage3"):setPosition(49,94)
			
			
			--==========================================
			-- 리스트창 관련 설정
			--==========================================
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)	-- 아이템 타이프 설정
			
			
			--==========================================
			-- 리스트창 업데이트
			--==========================================
			--g_currenItemList = ITEMLIST_ZEN
			--ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
			
			--==========================================
			-- 리스트의 탭 (ZEN으로 기본설정)
			--==========================================
			if IsCash == true then
				SetCurrentClonetemMode(ITEMLIST_CASH)		-- 아이템 모드 설정
				
				g_currenItemList			= ITEMLIST_CASH
				g_nNowSelectedCostumeMode	= MODE_SELECT_VISUAL
				ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
				ShowSelectCostumeAvatarList()	-- 리스트창 보여주기
			else
				SetCurrentClonetemMode(ITEMLIST_ZEN)		-- 아이템 모드 설정
				
				g_currenItemList			 = ITEMLIST_ZEN
				g_nNowSelectedCostumeMode	 = MODE_SELECT_VISUAL
				ChangedCostumeItemList(g_currenItemList , g_nNowSelectedCostumeMode)
				
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
				ShowSelectCostumeAvatarList()	-- 리스트창 보여주기
			end
			
			
		end


		-- 텍스트 메세지 위치 조정용
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
		-- 정화하기 배경 이미지
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
		-- 정화하기 YES 버튼
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
		-- 정화하기 NO 버튼
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
		
		-- 아이템을 사용할것인가를 물어보는 텍스트 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_CleanItem_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)		
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarCleanUpMainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- 정화하기 Main 윈도우 Open
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
		-- 정화할 아바타 인덱스 , 정화템 인덱스 전송
		------------------------------------------------------------
		function SendCleanupAvatarIndex()
			RequestCleanUpCostumeAvatar()
			
			winMgr:getWindow("CloneAvatarCleanUpMainImg"):setVisible(false)
			winMgr:getWindow("CostumeItemList"):setVisible(false)
			winMgr:getWindow("Costume_AlphaImage"):setVisible(false)
		end
		
		function ReloadCloneAvatarList(useMode , itemType)
			g_nNowSelectedCostumeMode = useMode -- 2 , (ITEMLIST_POLLUTION_CASH_AVATAR)5 - 클린
			ChangedCostumeItemList(itemType , g_nNowSelectedCostumeMode)
		end
		
		
		----------------------------------------------------------------------
		-- 되돌리기 배경 이미지
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
		-- 되돌리기 YES 버튼
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
		-- 되돌리기 NO 버튼
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
		
		-- 아이템을 사용할것인가를 물어보는 텍스트 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_RollBack_Use_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarRollBack_MainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- 일반으로 되돌리기 Main 윈도우 Open
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
			RequestRollBackCostumeAvatar()	-- 인덱스 서버로 전송
			CostumeCloseEvent()
		end
		
		
		
		----------------------------------------------------------------------
		-- 분리하기 배경 이미지
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
		-- 분리하기 YES 버튼
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
		-- 분리하기 NO 버튼
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
		
		-- 아이템을 사용할것인가를 물어보는 텍스트 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Costume_Separate_Use_Text")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CloneAvatarSeparate_MainImg"):addChildWindow(mywindow)
		
		
		------------------------------------------------------------
		-- 분리하기 Main 윈도우 Open
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
			RequestSeparateCostumeAvatar()	-- 인덱스 서버로 전송
			
			winMgr:getWindow("CloneAvatarSeparate_MainImg"):setVisible(false)
			--CostumeCloseEvent()
		end
		
		

		
		
		
		------------------------------------------------------------
		-- (정말 비쥬얼을 설정하시겠습니까? 팝업 띄우기
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
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end
		
		
		------------------------------------------------------------
		-- 정화하기 팝업 띄우기
		------------------------------------------------------------
		function OpenCleanUpPopup()
			ShowCommonAlertOkCancelBoxWithFunction("Clean","\nUse?" , "UseCleanItem", "NoUseCleanItem")
		end
		
		function UseCleanItem()
			RequestCleanUpCostumeAvatar()	-- 인덱스 서버로 전송
		end
		function NoUseCleanItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseCleanItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end

		------------------------------------------------------------
		-- 분리하기 팝업 띄우기
		------------------------------------------------------------
		function OpenSeparatePopup()
			ShowCommonAlertOkCancelBoxWithFunction("Separate","\nUse?" , "UseSeparateItem", "NoUseSeparateItem")
		end
		
		--[[
		function UseSeparateItem()
			RequestSeparateCostumeAvatar()	-- 인덱스 서버로 전송
			DebugStr("UseSeparateItem")
		end
		]]--
		function NoUseSeparateItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseSeparateItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
			DebugStr("NoUseSeparateItem")
		end
		
		
		------------------------------------------------------------
		-- 롤백하기(기본아바타로 변환) 팝업 띄우기
		------------------------------------------------------------
		function OpenRollBackPopup()
			ShowCommonAlertOkCancelBoxWithFunction("RollBack","Are you SURE?" , "UseRollBackItem", "NoUseRollBackItem")
		end
		
		--[[
		function UseRollBackItem()
			RequestRollBackCostumeAvatar() -- 인덱스 서버로 전송
		end
		]]--
		
		function NoUseRollBackItem()
			local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
			if nofunc ~= "NoUseRollBackItem" then
				return
			end
			winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
			
			winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
			root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
			local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
			winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
			local_window:setVisible(false)	
		end

		

		


		---------------------------------------------------------------------------------------------------------------------------------------------
		--- 코스튬 아바타 (젠) 비쥬얼 아바타 분리 시키기 ★
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserSeparateCostumeAvatar()
			SeparateCostumeAvatar(ITEMLIST_POLLUTION_ZEN_AVATAR) -- 4
		end
		
		-- 코스튬 아바타 분리 시키기 ★
		function SeparateCostumeAvatar(CleanUP_Mode)
			-- @ X버튼 달아주기
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ 인벤토리가 열려있다면 , 강제로 닫아버린다
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ 인벤토리 버튼 비활성화
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ 클린업 아이템 종류 설정하기
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			
			
			-- # 리스트창의 위치를 재조정
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ 리스트의 탭 (Zen 기본 Select)
			winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 2;	-- 클린업 모드 구별 ★
			
			-- # 리스트 박스 설정
			SetCurrentClonetemMode(CleanUP_Mode)	-- 리스트 박스의 탭 설정 (g_ItemClone.m_currentMyItemMode)
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_CLEANUP				--	 3번
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ 리스트 업데이트를 위한 플래그 설정
			g_nNowSelectedCostumeMode = MODE_USE_SEPARATE						-- 3번
			ChangedCostumeItemList(CleanUP_Mode , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() 호출
			ShowSelectCostumeAvatarList()										-- 리스트 창을 불러온다
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		

		---------------------------------------------------------------------------------------------------------------------------------------------
		--- 코스튬 아바타 (캐시) 클린업하기 ★
		---------------------------------------------------------------------------------------------------------------------------------------------
		function UserCleanUpCashAvatar()
			SetAvatarCleanUpInfo(ITEMLIST_POLLUTION_CASH_AVATAR)
		end

		-- 코스튬 아바타 클린업 '모드' 설정 함수
		function SetAvatarCleanUpInfo(CleanUP_Mode)
			--winMgr:getWindow("Costume_AlphaImage"):setVisible(true)
			
			-- 부모 설정
			--winMgr:getWindow("Costume_UseItem_Root"):addChildWindow("CostumeItemList")
			
			
			-- @ X버튼 달아주기
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ 인벤토리가 열려있다면 , 강제로 닫아버린다
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ 인벤토리 버튼 비활성화
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ 클린업 아이템 종류 설정하기
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
						
			-- # 리스트창의 위치를 재조정
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ 리스트의 탭 (Zen 기본 Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- 클린업 모드 구별 ★
			
			
			-- # 리스트 박스 설정
			SetCurrentClonetemMode(CleanUP_Mode)	-- 리스트 박스의 탭 설정 (g_ItemClone.m_currentMyItemMode)
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_CLEANUP				--	 3번
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ 리스트 업데이트를 위한 플래그 설정
			g_nNowSelectedCostumeMode = MODE_USE_CLEANUP						-- 2번
			ChangedCostumeItemList(CleanUP_Mode , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() 호출
			ShowSelectCostumeAvatarList()										-- 리스트 창을 불러온다
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		
		
		-- 코스튬 아바타 일반 아바타로 변환하기 ★
		function SetRoolBackAvatar()
			-- @ X버튼 달아주기
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ 인벤토리가 열려있다면 , 강제로 닫아버린다
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ 인벤토리 버튼 비활성화
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ 클린업 아이템 종류 설정하기
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			]]--
			
			
			-- # 리스트창의 위치를 재조정
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ 리스트의 탭 (Zen 기본 Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- 클린업 모드 구별 ★
			
			
			-- # 리스트 박스 설정
			SetCurrentClonetemMode(ITEMLIST_ROOL_BACK)	-- 리스트 박스의 탭 설정 (g_ItemClone.m_currentMyItemMode) -- 7
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_ROOL_BACK			--	 5번
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ 리스트 업데이트를 위한 플래그 설정
			g_nNowSelectedCostumeMode = MODE_USE_ROOLBACK						-- 4번
			ChangedCostumeItemList(ITEMLIST_ROOL_BACK , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() 호출	-- 7 , 4
			ShowSelectCostumeAvatarList()										-- 리스트 창을 불러온다
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		-- 코스튬 아바타 분리 시키기 ★
		function SetSeparateAvatar()
			-- @ X버튼 달아주기
			winMgr:getWindow("CostumeItemList"):addChildWindow("Costume_WindowClose")
			winMgr:getWindow("Costume_WindowClose"):setPosition(265 , 7)
			
			--==========================================
			-- 페이지 이동버튼 / 텍스트 위치이동
			--==========================================
			winMgr:getWindow("CostumeItemList_PageText"):setPosition(188 , 370)
			winMgr:getWindow("MyCostumeItemList_LBtn"):setPosition(171 , 368)
			winMgr:getWindow("MyCostumeItemList_RBtn"):setPosition(270 , 368)

			
			-- @ 인벤토리가 열려있다면 , 강제로 닫아버린다
			winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			-- @ 인벤토리 버튼 비활성화
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Enabled",	"UIData/Avata.tga", 0, 0)
			winMgr:getWindow("Costume_Change_MainWindow"):setTexture("Disabled","UIData/Avata.tga", 0, 0)
			
			
			-- @ 클린업 아이템 종류 설정하기
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				g_nCleanUpItemType = MODE_ZEN_CLEAN_UP
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				g_nCleanUpItemType = MODE_CASH_CLEAN_UP
			end
			]]--
			
			
			-- # 리스트창의 위치를 재조정
			winMgr:getWindow("Costume_Clean_Root"):addChildWindow('CostumeItemList')
			winMgr:getWindow("Costume_Clean_Root"):setPosition( (g_MAIN_WIN_SIZEX - 296)/2 , (g_MAIN_WIN_SIZEY - 438)/2 )
			
			winMgr:getWindow("CostumeItemList"):setPosition(0 , 0)
			winMgr:getWindow("CostumeItemList"):setVisible(true)
			winMgr:getWindow("Costume_Clean_Root"):setVisible(true)
			
				
			-- @ 리스트의 탭 (Zen 기본 Select)
			--[[
			if CleanUP_Mode == ITEMLIST_POLLUTION_ZEN_AVATAR then
				winMgr:getWindow("CloneAvatar_Zen"):setProperty("Selected" , "true")
			elseif CleanUP_Mode == ITEMLIST_POLLUTION_CASH_AVATAR then
				winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			end
			]]--
			winMgr:getWindow("CloneAvatar_Cash"):setProperty("Selected" , "true")
			
			
			g_nCleanUpMode = 1;	-- 클린업 모드 구별 ★
			
			
			-- # 리스트 박스 설정
			SetCurrentClonetemMode(ITEMLIST_ROOL_BACK)	-- 리스트 박스의 탭 설정 (g_ItemClone.m_currentMyItemMode) -- 7
			ITEM_TYPE_CURRENT = ITEM_TYPE_ITEMAVART_ROOL_BACK			--	 5번
			SetCurrentCloneItemType(ITEM_TYPE_CURRENT)					--	 (g_ItemClone.m_currentItemType)
			
			
			-- @ 리스트 업데이트를 위한 플래그 설정
			g_nNowSelectedCostumeMode = MODE_USE_ROOLBACK						-- 4번
			ChangedCostumeItemList(ITEMLIST_ROOL_BACK , g_nNowSelectedCostumeMode)	-- UpdateMyCostumeItemList() 호출	-- 7 , 4
			ShowSelectCostumeAvatarList()										-- 리스트 창을 불러온다
		end	-- end of function (SetAvatarCleanUpInfo)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		-------------------------------------------------------------
		-- 코스튬 아바타 관련 아이콘 변경★
		-------------------------------------------------------------
		function SetAvatarIconS(FileName , FileName2 , FileName3 , index , avatarType , attach)
			if avatarType ~= 0 then
				-- 오염된 아바타 == -2
				if avatarType == -2 then
					winMgr:getWindow(FileName2..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setTexture("Disabled", "UIData/Match002.tga", 667, 886)
					return
					
				-- 비쥬얼 아바타 = -3
				elseif avatarType == -3 then
					winMgr:getWindow(FileName2..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setTexture("Disabled", "UIData/Match002.tga", 667, 934)	-- 이부분의 y값을 바꿔준다
					return
										
				-- 1. Pure Avatar 설정 ★
				elseif avatarType == -1 then
					-- 백판을 설정
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 부위에 맞는 이미지를 불러온다.
					if attach == 32 then		-- 머리 (캐시)
						--DebugStr("캐시 머리 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- 가슴 (캐시)
						--DebugStr("캐시 가슴 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- 다리 (캐시)
						--DebugStr("캐시 다리 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- 얼굴 (캐시)
						--DebugStr("캐시 얼굴 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- 손	(캐시)
						--DebugStr("캐시 손 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- 발	(캐시)
						--DebugStr("캐시 발 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- 세트
						--DebugStr("캐시 세트 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- 등
						--DebugStr("캐시 등 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- 모자(왕관)
						--DebugStr("캐시 왕관 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- 반지
						--DebugStr("캐시 반지 어탯치")
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					winMgr:getWindow(FileName3..index):setVisible(true)
					
					return
					
				-- 2. Selected Visual Avatar 설정 ★
				elseif avatarType > 0 then
					-- 백판을 설정
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 비쥬얼 아바타의 아이템넘버로 비쥬얼압타의 아이템 이름을 받아낸다.
					-- 창고로 옮기면 인벤토리에는 아이템이 없으므로 , 스트링이 나오질 않지..
					-- 창고에서 검색하는 예외처리를 해줘야함. ★
					local string = GetVisualAvatarName(avatarType)
					--DebugStr("avatarType : " .. avatarType)
					--DebugStr("string : " .. string)
					
					if string ~= "" then
						-- 비쥬얼 아바타의 아이콘을 설정 
						local test = "UIData/ItemUIData/" .. string
						--DebugStr("test : " .. test)
						winMgr:getWindow(FileName3..index):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName3..index):setTexture("Disabled",	test, 0, 0)
					else
						-- 올바른 비쥬얼이 설정 되지 않았다. failed
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
			-- 코스튬 아바타 관련 아이콘 변경★
			-------------------------------------------------------------
			if avatarType ~= 0 then
				-- 오염된 아바타라면 다른 이미지를 선택하고 리턴★
				if avatarType == -2 then
					-- 배경 깔고
					winMgr:getWindow(FileName):setTexture("Enabled", itemFileName, 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled", itemFileName, 0, 0)
					return
				
				-- 클론 아바타 이미지 설정 ★
				-- pure 아바타
				elseif avatarType == -1 then
					-- 백판을 설정
					winMgr:getWindow(FileName):setTexture("Enabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 부위에 맞는 이미지를 불러온다.
					if attach == 32 then		-- 머리 (캐시)
						--DebugStr("캐시 머리 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- 가슴 (캐시)
						--DebugStr("캐시 가슴 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- 다리 (캐시)
						--DebugStr("캐시 다리 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- 얼굴 (캐시)
						--DebugStr("캐시 얼굴 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- 손	(캐시)
						--DebugStr("캐시 손 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- 발	(캐시)
						--DebugStr("캐시 발 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- 세트
						--DebugStr("캐시 세트 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- 등
						--DebugStr("캐시 등 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- 모자(왕관)
						--DebugStr("캐시 왕관 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- 반지
						--DebugStr("캐시 반지 어탯치")
						winMgr:getWindow(FileName2):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					
					winMgr:getWindow(FileName2):setVisible(true)
					winMgr:getWindow(FileName):setVisible(true)
					
					return
				elseif avatarType > 0 then
					-- 백판을 설정
					winMgr:getWindow(FileName):setTexture("Enabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 비쥬얼 아바타의 아이템넘버로 비쥬얼압타의 아이템 이름을 받아낸다.
					local string = GetVisualAvatarName(avatarType)
					
					if string ~= "" then
						-- 비쥬얼 아바타의 아이콘을 설정 
						local test = "UIData/ItemUIData/" .. string
						--DebugStr("test : " .. test)
						winMgr:getWindow(FileName2):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName2):setTexture("Disabled",	test, 0, 0)
					else
						-- 올바른 비쥬얼이 설정 되지 않았다. failed
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
			-- 1. pure 아바타 설정
			if avatarType == -1 then
				-- 배경을 랜더
				Draw:drawTexture("UIData/ItemUIData/Item/C1.tga", 8, 42, 100, 100, 0, 0)
				
				-- 배경위에 알맞는 부위를 랜더
				if attach == 32 then			-- 머리 (캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/hair.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 1 then		-- 가슴 (캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/top.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 2 then		-- 다리 (캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/bottoms.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 16 then	-- 얼굴 (캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/face.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 4 then		-- 손	(캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/hand.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 8 then		-- 발	(캐시)
					Draw:drawTexture("UIData/ItemUIData/Item/foot.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 63 or attach == 43 or attach == 11 then	-- 세트
					Draw:drawTexture("UIData/ItemUIData/Item/set_0001.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 64 then	-- 등
					Draw:drawTexture("UIData/ItemUIData/Item/bag.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 128 then	-- 모자(왕관)
					Draw:drawTexture("UIData/ItemUIData/Item/hat.tga", 8, 42, 100, 100, 0, 0)
				elseif attach == 256 then	-- 반지
					Draw:drawTexture("UIData/ItemUIData/Item/ring.tga", 8, 42, 100, 100, 0, 0)
				end
				return
				
			-- 2. 오염된 아바타
			elseif avatarType == -2 then
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
				Draw:drawTextureWithScale_Angle_Offset("UIData/Match002.tga" , 60, 90, 48, 48, 667, 886,   500, 500, 255, 0, 8, 100,100)
															--			실제포지션 ,사이즈, 좌표,          	 스케일,스케일,알파,각도,?,?
				return
			
			-- 3. 비쥬얼 아바타
			elseif avatarType == -3 then
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
				Draw:drawTextureWithScale_Angle_Offset("UIData/Match002.tga" , 60, 90, 48, 48, 667, 934,   500, 500, 255, 0, 8, 100,100)
															--			실제포지션 ,사이즈, 좌표,          	 스케일,스케일,알파,각도,?,?
				return
			
			-- 4. Visual이 선택된 클론 아바타
			elseif avatarType > 0 then
				-- 배경을 랜더
				Draw:drawTexture("UIData/ItemUIData/Item/C1.tga", 8, 42, 100, 100, 0, 0)
				
				-- 비쥬얼 아바타의 아이템넘버로 비쥬얼압타의 아이템 이름을 받아낸다.
				local string = GetVisualAvatarName(avatarType)
				
				if string ~= "" then
					-- 비쥬얼 아바타의 아이콘을 설정 
					local test = "UIData/ItemUIData/" .. string
					--DebugStr("test : " .. test)
					Draw:drawTexture(test, 8, 42, 100, 100, 0, 0)
				else
					-- 올바른 비쥬얼이 설정 되지 않았다. failed
					Draw:drawTexture("UIData/ItemUIData/none.tga", 8, 42, 100, 100, 0, 0)
				end
				return
			
			-- 5. 일반 아이템 이미지★
			else
				Draw:drawTexture(FileName, 8, 42, 100, 100, 0, 0)
			end
			
		end -- end of  function (SetAvatarIconS())
		
		
		function DrawORB_CostumeAvatarIcons(Draw , FileName , avatarType , attach)
			-- 1. pure 아바타 설정
			if avatarType == -1 then
				-- 배경을 랜더
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/C1.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				
				-- 배경위에 알맞는 부위를 랜더
				if attach == 32 then			-- 머리 (캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hair.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 1 then		-- 가슴 (캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/top.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 2 then		-- 다리 (캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/bottoms.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 16 then	-- 얼굴 (캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/face.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 4 then		-- 손	(캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hand.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 8 then		-- 발	(캐시)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/foot.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 63 or attach == 43 or attach == 11 then	-- 세트
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/set_0001.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 64 then	-- 등
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/bag.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 128 then	-- 모자(왕관)
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/hat.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				elseif attach == 256 then	-- 반지
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/ring.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				end
				return
			
			-- 2. Visual이 선택된 아바타
			elseif avatarType > 0 then
				-- 배경을 랜더
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/C1.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				
				-- 비쥬얼 아바타의 아이템넘버로 비쥬얼압타의 아이템 이름을 받아낸다.
				local string = GetVisualAvatarName(avatarType)
				--DebugStr("avatarType : " .. avatarType)
				--DebugStr("string : " .. string)
				
				if string ~= "" then
					-- 비쥬얼 아바타의 아이콘을 설정 
					local test = "UIData/ItemUIData/" .. string
					--DebugStr("test : " .. test)
					Draw:drawTextureWithScale_Angle_Offset(test , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				else
					-- 올바른 비쥬얼이 설정 되지 않았다. failed
					Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/none.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
				end
				return
			elseif avatarType == -2 then
				Draw:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/Item/Infection_001.tga" , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
			else
				Draw:drawTextureWithScale_Angle_Offset(FileName , 63, 88, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
			end
				
		end -- end of  function (SetAvatarIconS())
		
		
		-- ItemClone에서 독자적으로 사용함
		function SetItemListAvatarIconS(FileName , FileName2 , index , avatarType , attach)
			if avatarType ~= 0 then
				-- 1. Pure Avatar 설정 ★
				if avatarType == -1 then
					-- 백판을 설정
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 부위에 맞는 이미지를 불러온다.
					if attach == 32 then		-- 머리 (캐시)
						--DebugStr("캐시 머리 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hair.tga", 0, 0)
					elseif attach == 1 then		-- 가슴 (캐시)
						--DebugStr("캐시 가슴 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/top.tga", 0, 0)
					elseif attach == 2 then		-- 다리 (캐시)
						--DebugStr("캐시 다리 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bottoms.tga", 0, 0)
					elseif attach == 16 then	-- 얼굴 (캐시)
						--DebugStr("캐시 얼굴 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/face.tga", 0, 0)
					elseif attach == 4 then		-- 손	(캐시)
						--DebugStr("캐시 손 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hand.tga", 0, 0)
					elseif attach == 8 then		-- 발	(캐시)
						--DebugStr("캐시 발 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/foot.tga", 0, 0)
					elseif attach == 63 or attach == 43 or attach == 11 then	-- 세트
						--DebugStr("캐시 세트 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/set_0001.tga", 0, 0)
					elseif attach == 64 then	-- 등
						--DebugStr("캐시 등 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/bag.tga", 0, 0)
					elseif attach == 128 then	-- 모자(왕관)
						--DebugStr("캐시 왕관 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/hat.tga", 0, 0)
					elseif attach == 256 then	-- 반지
						--DebugStr("캐시 반지 어탯치")
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	"UIData/ItemUIData/Item/ring.tga", 0, 0)
					end -- end of attach
					winMgr:getWindow(FileName..index):setVisible(true)
					winMgr:getWindow(FileName2..index):setVisible(true)
					return
					
				-- 2. Selected Visual Avatar 설정 ★
				elseif avatarType > 0 then
					-- 백판을 설정
					winMgr:getWindow(FileName..index):setTexture("Enabled",		"UIData/ItemUIData/Item/C1.tga", 0, 0)
					winMgr:getWindow(FileName..index):setTexture("Disabled",	"UIData/ItemUIData/Item/C1.tga", 0, 0)
					
					-- 비쥬얼 아바타의 아이템넘버로 비쥬얼압타의 아이템 이름을 받아낸다.
					-- 창고로 옮기면 인벤토리에는 아이템이 없으므로 , 스트링이 나오지 않는다
					-- 창고에서 검색하는 예외처리를 해줘야함
					local string = GetVisualAvatarName(avatarType)
					
					if string ~= "" then
						-- 비쥬얼 아바타의 아이콘을 설정 
						local test = "UIData/ItemUIData/" .. string
						winMgr:getWindow(FileName2..index):setTexture("Enabled",	test, 0, 0)
						winMgr:getWindow(FileName2..index):setTexture("Disabled",	test, 0, 0)
					else
						-- 올바른 비쥬얼이 설정 되지 않았다. failed
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
		
		
		-- 비쥬얼 선택창을 강제종료 시킨다.
		function CloseSetVisualWindow()
			winMgr:getWindow("Costume_Visual_Root"):setVisible(false)
			winMgr:getWindow("Costume_Visual_Main"):setVisible(false)
			
			--winMgr:getWindow("MyInven_BackImage"):setVisible(false)
			--winMgr:getWindow("MainBar_Bag"):setEnabled(false)
		end

	end -- end of Flag == 1?

--end	-- end of Now Thai?



--==============================================================================================================
--================================== 코스튬 아바타 관련 종료 ===================================================
--==============================================================================================================






















----------------------------------------------------------------------
-- 클론 선택한 아이템 창
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
--클론 알파이미지
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

-- 아이템 사각백판
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


-- 아이템 이미지
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

-- 아이템 잠금 이미지
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


-- 스킬 레벨 테두리 
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

-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneSelectItemSkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(9, 1)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CloneSelectItemSkillLevelImage"):addChildWindow(mywindow)





-- 툴팁 선택 이미지
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

-- 선택 취소 버튼
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

-- 선택된 아이템 취소
function OnClickSelectCancle()
	ResetCloneSelectItemInfo()
	ClearCloneSelectItem()
end

-- 보상아이템 요청
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
-- 아이템클론 리스트 백판 
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
--코스튬 , 스킬 , 기타  , 스폐셜
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
--젠코스튬선택------------------
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
--캐쉬코스튬아이템선택------------------
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
--스킬아이템선택------------------
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
-- 아이템클론 목록 창 라디오버튼
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
	
		
	-- 아이템 이미지
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
	
	-- 아이템 잠금 이미지
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

	-- 스킬 레벨 테두리 이미지
	
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


	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CloneItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CloneItemList_Image_"..i):addChildWindow(mywindow)
	

	-- 툴팁 이벤트를 위한 이미지	
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
	
	
	-- 아이템 이름
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
	
	-- 아이템 갯수
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
	
	-- 아이템 기간
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
--아이템 리스트 첨부 버튼 5개
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
	
	-- 스킬 봉인해제 아이템
	if ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLITEM then
		--winMgr:getWindow("Clone_Skill"):setVisible(true)
	-- 스킬 거래해제 아이템
	elseif ITEM_TYPE_CURRENT == ITEM_TYPE_UNSEALSKILLTRADEITEM then
	
	-- 아바타 클론 아이템
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
-- 클론 아이템 이름 파일이름 갯수등을 설정
-----------------------------------------------------------------------
function SetupCloneItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade)
    
    local j=i+1
	winMgr:getWindow(tCloneItemRadio[j]):setVisible(true)
	winMgr:getWindow(tCloneItemButton[j]):setVisible(true)
	winMgr:getWindow("CloneSealItemImage_"..j):setVisible(false)
	-- 아이템 파일이름
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
	
	-- 아이템 이름
	winMgr:getWindow("CloneItemList_Name_"..j):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("CloneItemList_Num_"..j):setText(szCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("CloneItemList_Period_"..j):setText(period)		
end

------------------------------------
---페이지표시텍스트
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
---페이지앞뒤버튼
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
-- CloneItemList 현재 페이지 / 최대 페이지
---------------------------------------------------
function CloneItemListPage(curPage, maxPage)
	g_curPage_CloneItemList = curPage
	g_maxPage_CloneItemList = maxPage
	
	winMgr:getWindow("CloneItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---이전페이지이벤트-------------------
------------------------------------
		 
function  OnClickCloneItemList_PrevPage()
  
	if g_curPage_CloneItemList > 1 then
		g_curPage_CloneItemList = g_curPage_CloneItemList - 1
		ChangedCloneItemListCurrentPage(g_curPage_CloneItemList)
	end
	
end
------------------------------------
---다음페이지이벤트-----------------
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



-- 아이템 등록
function tCloneItemButtonEvent(args)	
	DebugStr('tCloneItemButtonEvent start');
	
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("CloneIndex")
	
	
	index = index - 1
	DebugStr("첨부리스트 index: " .. index)
	
	local bEnable = SelectCloneItem(tonumber(index))
	
	if bEnable then
		CloneSelectItem()
		winMgr:getWindow("CloneSelectCancelBtn"):setVisible(true)
		--PlayWave('sound/countDown.wav');
	end
end


function CloneSelectItem()
	
	local itemCount, itemName, itemFileName, itemFileName2, itemskillLevel = GetSelectCloneChangeItemInfo()

	-- 아이템 파일이름
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
-- 아이템 클론 결과창
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
-- 아이템 클론 결과 확인버튼
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
--결과 알파이미지
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


-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_CloneVanishTooltip()
	SetShowToolTip(false)	
end

-- 스킬 거래제한관련 툴팁
function OnMouseEnter_CloneItemListInfo(args)
	DebugStr("고구마감자")
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- 현재 선택된 윈도우를 찾는다.
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
	
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

function OnMouseEnter_CloneSelectItemListInfo(args)
	DebugStr("OnMouseEnter_CloneSelectItemListInfo@@@@@@@@@@@@@")
	-- 툴팁 띄워준다.
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

------------------------------------
--- 스킬 사용불가 해제 아이템 사용
------------------------------------
function UseUnsealSkillItem()
	winMgr:getWindow("CloneMainImage"):setTexture("Enabled", "UIData/popup002.tga", 0, 247)
	winMgr:getWindow("CloneMainImage"):setTexture("Disabled", "UIData/popup002.tga", 0, 247)
	-- Default로 스킬탭을 가져온다
	SetCurrentClonetemMode(ITEMLIST_SKILL)
	SetCurrentCloneItemType()
	ITEM_TYPE_CURRENT = ITEM_TYPE_UNSEALSKILLITEM
	SetCurrentCloneItemType(ITEM_TYPE_CURRENT)
	RequestCloneList()
	ShowCloneItemList()
end

------------------------------------
--- 스킬 거래불가 해제 아이템 사용
------------------------------------
function UseUnsealSkillTradeItem()
	
	winMgr:getWindow("CloneMainImage"):setTexture("Enabled", "UIData/popup004.tga", 0, 247)
	winMgr:getWindow("CloneMainImage"):setTexture("Disabled", "UIData/popup004.tga", 0, 247)
	-- Default로 스킬탭을 가져온다
	SetCurrentClonetemMode(ITEMLIST_SKILL)
	ITEM_TYPE_CURRENT = ITEM_TYPE_UNSEALSKILLTRADEITEM
	SetCurrentCloneItemType(ITEM_TYPE_CURRENT)
	RequestCloneList()
	ShowCloneItemList()
end