--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)		-- ����
local g_STRING_REWARD_DESC2		= PreCreateString_2229	--GetSStringInfo(LAN_GET_ATTEND_ITEM)		-- �����Կ� ������ ���޵Ǿ����ϴ�.
local g_STRING_RECOMMEND_1		= PreCreateString_2719	--GetSStringInfo(LAN_RECOMMEND_FRIEND_3 )	-- %s���� ��õ�Ͻðڽ��ϱ�?
local g_STRING_RECOMMEND_2		= PreCreateString_2720	--GetSStringInfo(LAN_RECOMMEND_FRIEND_4)	-- %s���� ��õ�Ͽ����ϴ�.

local g_MAX_EVENT_ICON_COUNT = GetMaxEventCount()
g_animationIconIndex = -1
g_animationIconTime = 0
local g_MAX_EVENT_COUNT = 7
--local g_MAX_EVENT_COUNT = 4

-- @ �ӽ� �׽�Ʈ�� ����
g_1stPageData	= 0		-- ù��° ������ CircleȽ�� ���� ����
g_2ndPageData	= 0		-- �ι�° ������ CircleȽ�� ���� ����
g_LimitOverlapEntry = 3 -- ī�װ��� ���� ��ư �ߺ� Ŭ���� ���� ���� �÷���


-- �̺�Ʈâ ������ ������
local tEventKind_BtnImg		   = {["err"]=0, }
local tEventKind_BtnTexX	   = {["err"]=0, }
local tEventKind_BtnTexY	   = {["err"]=0, }
local tEventKind_BtnPosX	   = {["err"]=0, }
local tEventKind_BtnPosY	   = {["err"]=0, }
local tEventKind_BtnSizeX	   = {["err"]=0, }
local tEventKind_BtnSizeY	   = {["err"]=0, }
local tEventKind_RadioBtnTexX  = {["err"]=0, }
local tEventKind_RadioBtnTexY  = {["err"]=0, }
local tEventKind_NewImg		   = {["err"]=0, }
local tEventKind_RadioBtnImg	= "event005.tga"
local tEventKind_RadioBtnSizeY = 45
local loginIndex = -1
local IntegrateEvent = -1
local ZackPotEvent = -1
local OpenURLEvent = -1

-- New Event Function for Vip & BattlePass in Event Panal
local Vip = -1
local BattlePass = -1

local comebackIndex = -1
local recommendFriendIndex = -1
local IconPosx = 29
local IconPosy = 17
local thanksGivingDayIndex = -1
-- Ŭ�� ��ʸ�Ʈ
local clubTournamentIndex = -1
-- ����
local zombieHardIndex = -1
-- ũ�������� ���� ������
local christMasIndex = -1
local GiftCardIndex = -1

local christMasImgTable = {['err']=0, [0]= "Event004.tga", "Event004.tga"}
local christMasTexXTable = {['err']=0, [0]= 0,	0}
local christMasTexYTable = {['err']=0, [0]= 0,	416}

-- Oldpvp
local OldPVPIndex = -1
local  PVP_LINE_IMAGE =  "Event014.tga";
local  PVP_LINE_IMAGE_U = 0;
local  PVP_LINE_IMAGE_V = 0;
local pvpImgTable = {['err']=0,	 [0]= "Event014.tga",	"Event014.tga", "Event012.tga", "Event012.tga", "Event015.tga"}
local pvpTexXTable = {['err']=0, [0]= 0,				0,				0,				0,			    0}
local pvpTexYTable = {['err']=0, [0]= 0,				356,			0,				356,			0}

-- NewPVP
local NewPVPIndex = -1


local PvPItemList = {["err"]=0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, 
				[9] = 0, [10] = 0, [11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0 }

local PvPCount						= 0
local MAX_PVE_EVENT_ITEM_LIST_MAX	= 15
local g_StartAinmation				= {["err"]=0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, 
									[9] = 0, [10] = 0, [11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0 }
									
local PvPEventAnimationY			= {["err"]=0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, 
									[9] = 0, [10] = 0, [11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0 }
									
									
DebugStr("Load My Evnet Lua !!!! " .. 1)									
-- Play Time
local PlayTimeIndex = -1

-- ����
local LoikrathongIndex = -1

-- ���� ��
local ChristMasEventIndex = -1

function EventSetUp(Index, TexName, TexX, TexY, PosX, PosY, SizeX, SizeY,
						RadioTexX, RadioTexY, isNew)
	table.insert(tEventKind_BtnImg, Index, TexName)
	table.insert(tEventKind_BtnTexX, Index, TexX)
	table.insert(tEventKind_BtnTexY, Index, TexY)
	table.insert(tEventKind_BtnPosX, Index, PosX)
	table.insert(tEventKind_BtnPosY, Index, PosY)
	table.insert(tEventKind_BtnSizeX, Index, SizeX)
	table.insert(tEventKind_BtnSizeY, Index, SizeY)
	table.insert(tEventKind_RadioBtnTexX, Index, RadioTexX)
	table.insert(tEventKind_RadioBtnTexY, Index, RadioTexY)
	table.insert(tEventKind_NewImg, Index, isNew)
end

-- AS ��
if IsEngLanguage() then
	--			Index,	TexName,					TexX,	TexY,	PosX,	PosY,	SizeX,	SizeY,	RadioTexX,	RadioTexY	Attach New Image	
	EventSetUp(	0,		"event015.tga",		0,		0,		145,	32,		606,	417,		240,		135 * 1,			1	)		-- Ŭ������
	EventSetUp(	1,		"event004.tga",		0,		0,		145,	32,		606,	417,		0,			135 * 2,			0	)		-- �÷���Ÿ��
	EventSetUp(	2,		"event018.tga",		0,		0,		145,	32,		606,	416,		240,		135 * 2,			0	)		-- Daily �̺�Ʈ
	EventSetUp(	3,		"event013.tga",		0,		417,	145,	32,		606,	417,		240,		135 * 0,			0	)		-- �α� ��ý
	EventSetUp(  4,		"event001.tga",		543,	420,	145,	32,		606,	416,		360,		135 * 0,			0	)		-- ������
	EventSetUp(	5,		"event006.tga",		0,		0,		145,	32,		606,	416,		  0,		135 * 1,			0	)		-- ������Ʈ��
	EventSetUp(  6,		"event007.tga",		0,		0,		145,	32,		606,	416,		120,		135 * 1,			0	)		-- Daily Weekly Quest ����
	EventSetUp(	7,		"event007.tga",		0,		0,		145,	32,		606,	416,		120,		135 * 0,			0	)		-- URL  Page
	
	christMasIndex = 1;
	PlayTimeIndex			= 2	-- Play Time �̺�Ʈ
	loginIndex				= 4	-- �⼮üũ ��ġ
	OpenURLEvent			= 8	-- URL BT

-- �� �� ��
elseif IsKoreanLanguage() then
	
	--		Index, TexName,		TexX, TexY, PosX, PosY, SizeX, SizeY, RadioTexX, RadioTexY
	
	EventSetUp(0, "event008.tga", 0, 416,	145, 32,	606, 416,	240, 0)		-- ���� ���� �̺�Ʈ
	EventSetUp(1, "event012.tga", 0, 0,		145, 32,	606, 416,	0, 135)		-- ���� ���潺
	EventSetUp(2, "event004.tga", 0, 522,	145, 32,	606, 416,	360, 0)		-- ���� ���潺2
	
	--�⼮üũ ��ġ
	loginIndex = -1
	
	-- �����ϵ�
	zombieHardIndex = 2
	
	--comebackIndex = 6
	--GiftCardIndex = 2
	

-- �����̽þ� ��
elseif IsMasLanguage() then

	EventSetUp(0, "event004.tga", 0, 0,	145, 32, 606, 416,	120, 135)		-- ����Ʈ ��ŷ
	EventSetUp(1, "event010.tga", 0, 0,	145, 32, 606, 416,	0, 0)			-- �⼮üũ �̺�Ʈ
	
		-- �⼮üũ ��ġ
	loginIndex = 2
	
	-- �����ϵ�
--	zombieHardIndex = 1
	
-- �ε��׽þ� ��
elseif IsIdnLanguage() then

	EventSetUp(0, "event010.tga", 0,	 0,	145, 32,	606, 416,	0, 0)			-- �⼮üũ �̺�Ʈ
	
		-- �⼮üũ ��ġ
	loginIndex = 1
	
	-- �����ϵ�
--	zombieHardIndex = 1

-- GSP ��
elseif IsGSPLanguage() then
	--			Index,	TexName,					TexX,	TexY,	PosX,	PosY,	SizeX,	SizeY,	RadioTexX,	RadioTexY	Attach New Image	
	EventSetUp(	0,		"event004.tga",		0,		0,		145,	32,		606,	417,		0,			135 * 2,			0	)		-- �÷���Ÿ��
	EventSetUp(	1,		"event018.tga",		0,		0,		145,	32,		606,	416,		240,		135 * 2,			0	)		-- Daily �̺�Ʈ
	EventSetUp(	2,		"event013.tga",		0,		417,	145,	32,		606,	417,		240,		135 * 0,			0	)		-- �α� ��ý
	EventSetUp(	3,		"event001.tga",		543,	420,	145,	32,		606,	416,		360,		135 * 0,			0	)		-- ������
	EventSetUp(	4,		"event006.tga",		0,		0,		145,	32,		606,	416,		  0,		135 * 1,			0	)		-- ������Ʈ��
	EventSetUp(  5,		"event007.tga",		0,		0,		145,	32,		606,	416,		120,		135 * 1,			0	)		-- Daily Weekly Quest ����
	
	--OldPVPIndex				= 1
	--PVP_LINE_IMAGE = "event019.tga";
	--PVP_LINE_IMAGE_U = 605;
	--PVP_LINE_IMAGE_V = 37;
	
	loginIndex				= 3	-- �⼮üũ ��ġ
	PlayTimeIndex			= 1	-- Play Time �̺�Ʈ
	--OpenURLEvent			= 8	-- URL BT

-- �� �� ��
elseif IsThaiLanguage() then	
	--			Index,	TexName,			TexX,	TexY,	PosX,	PosY,	SizeX,	SizeY,	RadioTexX,	RadioTexY	Attach New Image	

	--EventSetUp(	0,		"event011.tga",		0,		0,		145,	32,		606,	416,	240,			135 * 1,	1	)		-- Cristmas
	--EventSetUp(	0,		"event019.tga",			0,		0,		145,	32,		606,	416,	120,			135 * 0,	1	)		-- Vacation PVP
	--EventSetUp(	1,		"event020.tga",			0,		0,		145,	32,		606,	416,	0	,			135 * 0,	1	)		-- Vacation Arcade
	--EventSetUp(	2,		"event015.tga",			0,		0,		145,	32,		606,	416,	360	,		135 * 2,	1	)		-- ��ũ��
	EventSetUp(	0,		"event004.tga",			0,		0,		145,	32,		606,	416,	0,				135 * 2,	0	)		-- �÷��� Ÿ�� �̺�Ʈ
	EventSetUp(	1,		"event017.tga",			0,		0,		145,	32,		606,	416,	360,			135 * 1,	0	)		-- Ŭ�� ��ʸ�Ʈ
	EventSetUp(  2,		"event013.tga",			0,		0,		145,	32,		606,	416,	240,			135 * 0,	0	)		-- Login �̺�Ʈ
	EventSetUp(	3,		"event008.tga",			0,		0,		145,	32,		606,	416,	360,			135 * 0,	0	)		-- Alwas Event
	EventSetUp(	4,		"event011.tga",			0,		0,		145,	32,		606,	416,	0,			135 * 1,	0	)		-- Alwas Event
	
	-- New Button
	EventSetUp(	5,		"WndMainPanalBackground.png",			0,		0,		145,	32,		606,	416,	259,		17,	0	)	
	EventSetUp(	6,		"WndMainPanalBackground.png",			0,		0,		145,	32,		606,	416,	259,		66,	0	)	

	--OldPVPIndex				= 2
	--PVP_LINE_IMAGE = "event020.tga";
	--PVP_LINE_IMAGE_U = 605;
	--PVP_LINE_IMAGE_V = 37;
	
	PlayTimeIndex			= 1	-- Play Time �̺�Ʈ
	clubTournamentIndex		= 2	
	loginIndex				= 3	-- �⼮üũ ��ġ
	IntegrateEvent			= 4

	Vip = 6
	BattlePass = 7
else
	EventSetUp(1, "event001.tga", 0,	0,		145, 32,	606, 416,	0,	 0)			-- �⼮üũ �̺�Ʈ
	-- �⼮üũ ��ġ
	loginIndex = 1
end

-- �⼮üũ �̺�Ʈ ����
if loginIndex > 0 then
	RequestLoginEventInfo()
end

-- Play Time Event
if PlayTimeIndex > 0 then
	GetPlayTimeEvent() 
end
DebugStr("Load My Evnet Lua !!!! " .. 2)									

-- �̺�Ʈ â�� �����ش�.
function ShowMyEventPopup()
	if winMgr:getWindow("sj_eventPopupBackImage"):isVisible() then
		OnClickedEventPopupClosed()
		return
	end
	
	-- Play Time Event
	if PlayTimeIndex > 0 then
		GetPlayTimeEvent() 
	end
	
	-- PvP �̺�Ʈ ����
	if OldPVPIndex > 0 then
		PvPEventCountCall()
	end
	
	Mainbar_ClearEffect(BAR_BUTTONTYPE_EVENT)
	
	root:addChildWindow(winMgr:getWindow("sj_eventPopupBackImage"))
	winMgr:getWindow("sj_eventPopupBackImage"):setVisible(true)
end

local tAnimationTexX = {["err"]=0, [0]=627, 701, 775, 849, 923, 627, 701, 775, 849, 923, 627, 701, 775, 849, 923, 923, 923, 923, 923, 923}
local tAnimationTexY = {["err"]=0, [0]=0, 0, 0, 0, 0, 74, 74, 74, 74, 74, 148, 148, 148, 148, 148, 148, 148, 148, 148, 148}

function UpdateEvent(deltaTime)
	if g_animationIconIndex >= 0 then
		local window = winMgr:getWindow("sj_eventPopupIcon_"..g_animationIconIndex)
		if window then
			g_animationIconTime = g_animationIconTime + deltaTime
			local aniIndex = g_animationIconTime / 50
			if aniIndex >= #tAnimationTexX then
				aniIndex = #tAnimationTexX
				if winMgr:getWindow("sj_eventPopupGetItemBtn_"..g_animationIconIndex) then
				--	winMgr:getWindow("sj_eventPopupGetItemBtn_"..g_animationIconIndex):clearActiveController()					
				--	winMgr:getWindow("sj_eventPopupGetItemBtn_"..g_animationIconIndex):activeMotion("GetEvent")
					winMgr:getWindow("sj_eventPopupGetItemBtn_"..g_animationIconIndex):setVisible(true)
				end
				g_animationIconIndex = -1
			end

			window:setVisible(true)
			window:setTexture("Enabled", "UIData/event001.tga", tAnimationTexX[aniIndex], tAnimationTexY[aniIndex])
			window:setTexture("Disabled", "UIData/event001.tga", tAnimationTexX[aniIndex], tAnimationTexY[aniIndex])
		end
	end
end


function SetEventIcon(lastCompleteCount, isTodayComplete)
	
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		winMgr:getWindow("sj_eventPopupDisable_"..i):setVisible(true)
		winMgr:getWindow("sj_eventPopupIcon_"..i):setVisible(false)		
	end
	winMgr:getWindow("sj_eventPopupTimeText"):clearTextExtends()
	-- ���� �̺�Ʈ�� �޴� ���
	if isTodayComplete == 1 then
		for i=0, lastCompleteCount-1 do
			winMgr:getWindow("sj_eventPopupDisable_"..i):setVisible(false)
			winMgr:getWindow("sj_eventPopupIcon_"..i):setVisible(true)
		end
		g_animationIconIndex = lastCompleteCount
		g_animationIconTime  = 0
		
	-- �̺�Ʈ�� �� �������
	else
		for i=0, lastCompleteCount do
			winMgr:getWindow("sj_eventPopupDisable_"..i):setVisible(false)
			winMgr:getWindow("sj_eventPopupIcon_"..i):setVisible(true)
		end
		local lastIndex = lastCompleteCount + 1
		local Count = g_MAX_EVENT_ICON_COUNT - 1 - lastCompleteCount
		if Count > 0 then
			winMgr:getWindow("sj_eventPopupTimeText"):setPosition((lastIndex%7)*78 + IconPosx+1, (lastIndex/7)*78+176 + IconPosy)
		end
	end	
end



function ClearEventGetButton()
	DebugStr("ClearEventGetButton")
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		winMgr:getWindow("sj_eventPopupGetItemBtn_"..i):setVisible(false)
	end
end



function SetEventGetButton(presentIndex, lastCompleteCount, isTodayComplete)
	DebugStr("presentIndex : " .. presentIndex .. "lastCompleteCount : " .. lastCompleteCount .. "isTodayComplete" .. isTodayComplete)
	-- ���� �̺�Ʈ�� �޴� ���
	if isTodayComplete == 1 then
		if presentIndex == lastCompleteCount then
			DebugStr("presentIndex == lastCompleteCount")
			winMgr:getWindow("sj_eventPopupGetItemBtn_"..presentIndex):setVisible(false)
		else
			DebugStr("presentIndex != lastCompleteCount")
			winMgr:getWindow("sj_eventPopupGetItemBtn_"..presentIndex):setVisible(true)
		end
	
	-- �̺�Ʈ�� �� �������
	else
		winMgr:getWindow("sj_eventPopupGetItemBtn_"..presentIndex):setVisible(true)
	end
end




function ActiveEventMotion()
	Mainbar_ActiveEffect(BAR_BUTTONTYPE_EVENT)
end


--[[
-- �̺�Ʈ �˾���ư(�⼮üũ �̺�Ʈ��...)
mywindow = winMgr:createWindow("TaharezLook/Button", "pu_btn(event)")
mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", 977, 664)
mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", 977, 711)
mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", 977, 758)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", 977, 664)
mywindow:setTexture("Enabled", "UIData/mainBG_Button002.tga", 977, 664)
mywindow:setTexture("Disabled", "UIData/mainBG_Button002.tga", 977, 805)
mywindow:setWideType(1);
mywindow:setPosition(688, 5)
mywindow:setSize(47, 47)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "RequestEventPopup")
mywindow:subscribeEvent("MouseEnter", "OnEventButtonMouseEnterSound");
mywindow:subscribeEvent("MouseButtonUp", "OnEventButtonMouseBtnUpSound");
root:addChildWindow(mywindow)
--]]


function OnEventButtonMouseEnterSound(args)
	PlayWave('sound/Quickmenu01.wav')
end



function OnEventButtonMouseBtnUpSound(args)
	PlayWave('sound/Top_popmenu.wav')
end



function SetPostionEventPopup(bVillage)
	--[[
	if winMgr:getWindow("pu_btn(event)") then
		if bVillage then
			winMgr:getWindow("pu_btn(event)"):setPosition(688, 5)
		else
			winMgr:getWindow("pu_btn(event)"):setPosition(688, 5)
		end
	end
	--]]
end


-- �̺�Ʈ �˾�â�� ����ش�.
function RequestEventPopup()
	ShowMyEventPopup()
	winMgr:getWindow("sj_EventKind_1stBtn"):setProperty("Selected", "true")
	
	--[[
	if IsThaiLanguage() or IsEngLanguage()then
		LoiKrathongBtnInit()
	end
	]]
end



-- ó�� ����ÿ� �ѹ� ����ش�.
function RequestEventPopupOneTime()
	ShowMyEventPopup()
	winMgr:getWindow("sj_EventKind_1stBtn"):setProperty("Selected", "true")
	--winMgr:getWindow("sj_EventKind_1stBtn"):setProperty("Selected", "true")
end


--------------------------------------------------------------------

-- �̺�Ʈ ���� ������

--------------------------------------------------------------------
-- �̺�Ʈ �˾� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventPopupAlphaImage")
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

-- �̺�Ʈ �˾� ���ȭ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventPopupBackImage")
mywindow:setTexture("Enabled", "UIData/event002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/event002.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setVisible(false)
mywindow:setPosition((g_MAIN_WIN_SIZEX-764)/2, (g_MAIN_WIN_SIZEY-463)/2)
mywindow:setSize(764, 463)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--RegistEscEventInfo("sj_eventPopupAlphaImage", "OnClickedEventPopupClosed")
RegistEscEventInfo("sj_eventPopupBackImage", "OnClickedEventPopupClosed")
--[[
local tEventKind_BtnImg	  = {["err"]=0, [0]="event001.tga", "event001.tga", "event002.tga", "event002.tga"}
local tEventKind_BtnTexX  = {["err"]=0, [0]=	0,		543,	0,		518}
local tEventKind_BtnTexY  = {["err"]=0, [0]=	420,	420,	463,	463}
local tEventKind_BtnPosX  = {["err"]=0, [0]=	176,	205,	195,	195}
local tEventKind_BtnPosY  = {["err"]=0, [0]=	50,		44,		35,		47}
local tEventKind_BtnSizeX = {["err"]=0, [0]=	543,	475,	516,	506}
local tEventKind_BtnSizeY = {["err"]=0, [0]=	391,	401,	410,	381}
--]]
for i=0, #tEventKind_BtnImg do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_"..(i+1).."st_eventPopupImage")
	mywindow:setTexture("Enabled", "UIData/"..tEventKind_BtnImg[i], tEventKind_BtnTexX[i], tEventKind_BtnTexY[i])
	mywindow:setTexture("Disabled", "UIData/"..tEventKind_BtnImg[i], tEventKind_BtnTexX[i], tEventKind_BtnTexY[i])
	mywindow:setPosition(tEventKind_BtnPosX[i], tEventKind_BtnPosY[i])
	mywindow:setSize(tEventKind_BtnSizeX[i], tEventKind_BtnSizeY[i])
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(mywindow)
	
	if thanksGivingDayIndex == i+1 then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_TGDEventCountText");
		mywindow:setPosition(476, 213)
		mywindow:setSize(74, 20)
		mywindow:setAlign(8)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:addTextExtends("", g_STRING_FONT_DODUM, 12, 255,255,255,255, 0, 255,255,255, 255)--0,0,0,255, 1, 255,255,255,255)
		winMgr:getWindow("sj_"..(i+1).."st_eventPopupImage"):addChildWindow(mywindow)
	end
	if christMasIndex == i+1 then
		--for j=0, 1 do
		--	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "eventPageBtn_"..j)
		--	mywindow:setTexture("Normal",			"UIData/Event005.tga", 44, 406 + j*22)
		--	mywindow:setTexture("Hover",			"UIData/Event005.tga", 22, 406 + j*22)
		--	mywindow:setTexture("Pushed",			"UIData/Event005.tga", 44, 406 + j*22)
		--	mywindow:setTexture("Disabled",			"UIData/Event005.tga", 66, 406 + j*22)
		--	mywindow:setTexture("SelectedNormal",	"UIData/Event005.tga", 0, 406 + j*22)
		--	mywindow:setTexture("SelectedHover",	"UIData/Event005.tga", 0, 406 + j*22)
		--	mywindow:setTexture("SelectedPushed",	"UIData/Event005.tga", 0, 406 + j*22)
		--	mywindow:setPosition(535 + j*23, 37)
		--	mywindow:setProperty("GroupID", 2112)
		--	mywindow:setSize(22, 22)
		--	mywindow:setUserString("index", j)
		--	mywindow:setZOrderingEnabled(false)
		--	mywindow:setSubscribeEvent("SelectStateChanged", "ChristMasBtnEvent")
		--	if j == 0 then
		--		mywindow:setProperty("Selected", "true")
		--	end
		--	winMgr:getWindow("sj_"..(i+1).."st_eventPopupImage"):addChildWindow(mywindow)
		--end
	end
	
	if GiftCardIndex == i+1 then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_GiftCardEventCountText");
		mywindow:setPosition(500, 108)
		mywindow:setSize(62, 20)
		mywindow:setAlign(7)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:addTextExtends("", g_STRING_FONT_DODUM, 12, 255,255,255,255, 0, 255,255,255, 255)--0,0,0,255, 1, 255,255,255,255)
		winMgr:getWindow("sj_"..(i+1).."st_eventPopupImage"):addChildWindow(mywindow)
	end
end

-- ����ũ���� ��ư
--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "LoiKrathongEventBtn1")
mywindow:setTexture("Normal",	"UIData/Event005.tga", 0, 0)
mywindow:setTexture("Hover",	"UIData/Event005.tga", 22, 0)
mywindow:setTexture("Pushed",	"UIData/Event005.tga", 44, 0)
mywindow:setTexture("PushedOff","UIData/Event005.tga", 66, 0)
mywindow:setPosition(531, 74)
mywindow:setSize(22, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "LoiKrathongBtnEvent1")
winMgr:getWindow("sj_1st_eventPopupImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "LoiKrathongEventBtn2")
mywindow:setTexture("Normal",	"UIData/Event005.tga", 0, 0)
mywindow:setTexture("Hover",	"UIData/Event005.tga", 22, 0)
mywindow:setTexture("Pushed",	"UIData/Event005.tga", 44, 0)
mywindow:setTexture("PushedOff","UIData/Event005.tga", 66, 0)
mywindow:setPosition(556, 74)
mywindow:setSize(22, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "LoiKrathongBtnEvent2")
winMgr:getWindow("sj_1st_eventPopupImage"):addChildWindow(mywindow)

function LoiKrathongBtnInit()
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Enabled", "UIData/"..tEventKind_BtnImg[0], tEventKind_BtnTexX[0], tEventKind_BtnTexY[0])
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Disabled", "UIData/"..tEventKind_BtnImg[0], tEventKind_BtnTexX[0], tEventKind_BtnTexY[0])
	
	winMgr:getWindow("LoiKrathongEventBtn1"):setVisible(true)
	winMgr:getWindow("LoiKrathongEventBtn2"):setVisible(true)
end

function LoiKrathongBtnEvent1(arg)
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Enabled", "UIData/"..tEventKind_BtnImg[0], tEventKind_BtnTexX[0], tEventKind_BtnTexY[0])
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Disabled", "UIData/"..tEventKind_BtnImg[0], tEventKind_BtnTexX[0], tEventKind_BtnTexY[0])
end

function LoiKrathongBtnEvent2(arg)
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Enabled", "UIData/event014.tga", 0, 416)
	winMgr:getWindow("sj_1st_eventPopupImage"):setTexture("Disabled", "UIData/event014.tga", 0, 416)
end
]]

-- ���� ���潺 ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ZombieEventBtn")
mywindow:setPosition(472, 207)
mywindow:setSize(95, 45)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ZombieDefencePosInfo")

if zombieHardIndex ~= -1 then
	mywindow:setTexture("Normal",	"UIData/Event003.tga", 701, 0)
	mywindow:setTexture("Hover",	"UIData/Event003.tga", 701, 45)
	mywindow:setTexture("Pushed",	"UIData/Event003.tga", 701, 90)
	mywindow:setTexture("PushedOff","UIData/Event003.tga", 701, 0)
	winMgr:getWindow("sj_" .. zombieHardIndex .. "st_eventPopupImage"):addChildWindow(mywindow)
end


-- Ŭ�� ��ʸ�Ʈ �̱� �±�
local EventImagePath = "UIData/event017.tga";
if IsEngLanguage() or IsGSPLanguage() then
	EventImagePath = "UIData/event011.tga";
end

if clubTournamentIndex > 0 then
	mywindow = winMgr:createWindow("TaharezLook/Button", "ClubTournamentBtn")
	mywindow:setPosition(466, 374)
	mywindow:setSize(100, 21)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClubTournamentBtn")
	mywindow:setTexture("Normal",		EventImagePath, 606, 0)
	mywindow:setTexture("Hover",		EventImagePath, 606, 21)
	mywindow:setTexture("Pushed",		EventImagePath, 606, 42)
	mywindow:setTexture("PushedOff",	EventImagePath, 606, 0)
	winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):addChildWindow(mywindow)
end

if clubTournamentIndex > 0 then
	function ClubTournamentBtn(args)
		winMgr:getWindow("ClubTournamentBtn"):setVisible(false)
	
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Enabled", EventImagePath, 0, 416)
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Disabled", EventImagePath, 0, 416)
	end
end

if clubTournamentIndex > 0 then
	function ClubTournamentBtnInit()
		winMgr:getWindow("ClubTournamentBtn"):setVisible(true)
	
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Enabled", EventImagePath, 0, 0)
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Disabled", EventImagePath, 0, 0)
	end
end

function ResetTournamentPage()
		winMgr:getWindow("ClubTournamentBtn"):setVisible(true)
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Enabled", EventImagePath, 0, 0)
		winMgr:getWindow("sj_" .. clubTournamentIndex .. "st_eventPopupImage"):setTexture("Disabled", EventImagePath, 0, 0)
end


function ZombieDefencePosInfo(args)
	winMgr:getWindow("ZombieEventBtn"):setVisible(false)
	
	if zombieHardIndex ~= -1 then
		winMgr:getWindow("sj_" .. zombieHardIndex .. "st_eventPopupImage"):setTexture("Enabled", "UIData/event003.tga", 0, 416)
		winMgr:getWindow("sj_" .. zombieHardIndex .. "st_eventPopupImage"):setTexture("Disabled", "UIData/event003.tga", 0, 416)
	end
end

function ZombieEventBtnInit()
	-- ���� �̺�Ʈ ����
	winMgr:getWindow("ZombieEventBtn"):setVisible(true)
	
	window = winMgr:getWindow("sj_" .. zombieHardIndex .. "st_eventPopupImage")
	if zombieHardIndex ~= -1 then
		window:setTexture("Enabled", "UIData/"..tEventKind_BtnImg[zombieHardIndex-1], tEventKind_BtnTexX[zombieHardIndex-1], tEventKind_BtnTexY[zombieHardIndex-1])
		window:setTexture("Disabled", "UIData/"..tEventKind_BtnImg[zombieHardIndex-1], tEventKind_BtnTexX[zombieHardIndex-1], tEventKind_BtnTexY[zombieHardIndex-1])
	end
	
end



-- �̺�Ʈ �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_1st_eventPopupCloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(725, 22)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedEventPopupClosed")
winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(mywindow)


function OnClickedEventPopupClosed(args)
	--winMgr:getWindow("sj_eventPopupAlphaImage"):setVisible(false)
	winMgr:getWindow("sj_eventPopupBackImage"):setVisible(false)
	
	if CEGUI.toRadioButton(winMgr:getWindow("sj_EventKind_1stBtn")):isSelected() then
		winMgr:getWindow("sj_EventKind_1stBtn"):setProperty("Selected", "false")
	end	
	
	if zombieHardIndex ~= -1 then
		ZombieEventBtnInit()
	end
	
	ClosedEventPopup()
	SetAttendEventMsg(false)
end


-- �̺�Ʈ ���� ���� ��ư
for i=0, #tEventKind_BtnImg do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_EventKind_"..(i+1).."stBtn")
	mywindow:setTexture("Normal",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i])
	mywindow:setTexture("Hover",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY)
	mywindow:setTexture("Pushed",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY * 2)
	mywindow:setTexture("Disabled",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY * 2)
	mywindow:setTexture("SelectedNormal",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY * 2)
	mywindow:setTexture("SelectedHover",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY * 2)
	mywindow:setTexture("SelectedPushed",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i] + tEventKind_RadioBtnSizeY * 2)
	mywindow:setPosition(17, 32 + i*(tEventKind_RadioBtnSizeY +2))
	mywindow:setProperty("GroupID", 2151)
	mywindow:setSize(120, tEventKind_RadioBtnSizeY)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("btnIndex", tostring(i+1))
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelectedEventKind")--tMyInvenListEvent[i])
	winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(mywindow)
	
	
	if tEventKind_NewImg[i] == 1 then
		newwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_"..(i+1).."st_eventNewImage")
		newwindow:setTexture("Enabled", "UIData/"..tEventKind_RadioBtnImg, 192, 452)
		newwindow:setTexture("Disabled", "UIData/"..tEventKind_RadioBtnImg, 192, 452)
		newwindow:setSize(120 + 15, tEventKind_RadioBtnSizeY + 15)
		newwindow:setPosition(17 - 15, 32 + i*(tEventKind_RadioBtnSizeY +2) - 15 )
		newwindow:setVisible(true)
		newwindow:setEnabled(false);
		newwindow:setAlwaysOnTop(true)
		newwindow:setZOrderingEnabled(false)
		newwindow:addController("NewEventImg", "NewEventImg", "alpha", "Linear_EaseNone", 255, 50, 10, true, true, 10);
		newwindow:addController("NewEventImg", "NewEventImg", "alpha", "Linear_EaseNone", 50, 255, 10, true, true, 10)	
		winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(newwindow)
		newwindow:activeMotion("NewEventImg")
	end	

	-- Maxion 's BattlePass and Vip Event Setting
	
	if i == 5 or i == 6 then
		tEventKind_RadioBtnImg = "EventVipandBP.png"
		ButtonRadio = winMgr:getWindow("sj_EventKind_"..(i+1).."stBtn")
		-- 														path 							x							y
		ButtonRadio:setTexture("Normal",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("Hover",				"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i] - 124 ,tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("Pushed",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i] - 248 ,tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("Disabled",			"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i],tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("SelectedNormal",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i] - 248 ,tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("SelectedHover",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i] - 248  ,tEventKind_RadioBtnTexY[i])
		ButtonRadio:setTexture("SelectedPushed",	"UIData/"..tEventKind_RadioBtnImg, tEventKind_RadioBtnTexX[i] - 248 ,tEventKind_RadioBtnTexY[i])
		ButtonRadio:setSize(118, 43)
		winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(ButtonRadio)
	end	
end


-- �̺�Ʈ ���� ���� �̺�Ʈ,
function OnSelectedEventKind(args)
	local currentWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(currentWindow):isSelected() then		
		local buttonIndex = tonumber(currentWindow:getUserString("btnIndex"))
		winMgr:getWindow("sj_"..buttonIndex.."st_eventPopupImage"):setVisible(true)
		
		-- ��õ �̺�Ʈ ���� ��õ���� ����Ʈâ �ݱ�
		if winMgr:getWindow("sj_recommendFriendListBackImage") then
			winMgr:getWindow("sj_recommendFriendListBackImage"):setVisible(false)
		end
		-- ���� �̺�Ʈ ȣ��
		if buttonIndex == loginIndex then
			RequestLoginEventInfo()
			SetAttendEventMsg(true)
			return
		-- �Ĺ� �̺�Ʈ ȣ��
		elseif buttonIndex == comebackIndex then
			RequestComebackEventInfo()
		elseif buttonIndex == recommendFriendIndex then
			GetRecommendFriend()
		elseif buttonIndex == thanksGivingDayIndex then
			RequestTGDEventCount()
		elseif buttonIndex == christMasIndex then
			--ChristmasClickEvent()
		elseif buttonIndex == GiftCardIndex then
			RequestOBTEventCount()
		elseif buttonIndex == clubTournamentIndex then
			ResetTournamentPage()
		elseif buttonIndex == ZackPotEvent then
			ResetZackPotInfos()
		elseif buttonIndex == Vip then
			LOG("TestFunctionEventVIP")
			DrawWebbox("https://translate.google.com/")			
		elseif buttonIndex == BattlePass then
			LOG("TestFunctionEventBattlePass")
			DrawWebbox("https://quillbot.com/")
		end
		SetAttendEventMsg(false)
	else
		local buttonIndex = currentWindow:getUserString("btnIndex")
		winMgr:getWindow("sj_"..buttonIndex.."st_eventPopupImage"):setVisible(false)		
	end
end

-- SummerEventBtn
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SummerEventBtn")
mywindow:setTexture("Enabled", "UIData/event005.tga", 436, 474)
mywindow:setTexture("Disabled", "UIData/event005.tga", 436, 474)
mywindow:setPosition(-5, 29)
mywindow:setSize(76, 38)
if IsKoreanLanguage() then
	mywindow:setVisible(false)
else
	mywindow:setVisible(false)
end
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventPopupBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------

-- �Ĺ� �̺�Ʈ

--------------------------------------------------------------------
local tComebackTexY = {["err"]=0, [0]=414, 436}
local tComebackPosX = {["err"]=0, [0]=50, 74}
--local tComebackPosX = {["err"]=0, [0]=250, 274}

if comebackIndex >= 0 then
	
	-- ���� ������ ��� ��ư
	for i=0, #tComebackTexY do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_comebackEventCategoryBtn_"..i)
		mywindow:setTexture("Normal",			"UIData/event011.tga", 562, tComebackTexY[i])
		mywindow:setTexture("Hover",			"UIData/event011.tga", 540, tComebackTexY[i])
		mywindow:setTexture("Pushed",			"UIData/event011.tga", 518, tComebackTexY[i])
		mywindow:setTexture("PushedOff",		"UIData/event011.tga", 562, tComebackTexY[i])
		mywindow:setTexture("SelectedNormal",	"UIData/event011.tga", 518, tComebackTexY[i])
		mywindow:setTexture("SelectedHover",	"UIData/event011.tga", 518, tComebackTexY[i])
		mywindow:setTexture("SelectedPushed",	"UIData/event011.tga", 518, tComebackTexY[i])
		mywindow:setTexture("SelectedPushedOff","UIData/event011.tga", 518, tComebackTexY[i])
		mywindow:setTexture("Enabled",			"UIData/event011.tga", 562, tComebackTexY[i])
		mywindow:setTexture("Disabled",			"UIData/event011.tga", 584, tComebackTexY[i])
		mywindow:setPosition(tComebackPosX[i], 140) -- 168
		mywindow:setSize(22, 22)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("index", i)
		mywindow:subscribeEvent("SelectStateChanged", "OnClickedCategoryChange")
		winMgr:getWindow("sj_"..comebackIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	end
	--winMgr:getWindow("sj_comebackEventCategoryBtn_0"):setProperty("Selected", "true")
	
	-- ���׶�� �̹��� (��������� ����)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_comebackEventCircleImg")
	mywindow:setTexture("Enabled",	"UIData/event011.tga", 606, 414)
	mywindow:setTexture("Disabled", "UIData/event011.tga", 606, 414)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(513, 216)
	mywindow:setSize(22 , 22)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_1st_eventPopupImage"):addChildWindow(mywindow)
	
	
	-- ���� ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_comebackEventCategoryImage")
	mywindow:setTexture("Enabled",	"UIData/event011.tga", 0, 414)
	mywindow:setTexture("Disabled", "UIData/event011.tga", 0, 414)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(48, 168)
	mywindow:setSize(518, 203)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..comebackIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	-- ���� ���� �Ĺ��̺�Ʈ�� ��������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_comebackEventNotEnableImage")
	mywindow:setTexture("Enabled",	"UIData/event011.tga", 519, 498)
	mywindow:setTexture("Disabled", "UIData/event011.tga", 519, 498)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(30, 46)
	mywindow:setSize(215, 19)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..comebackIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	-- ������� �÷��̼�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_comebackEventPlayCountText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
	mywindow:setPosition(393, 95)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(1)
	mywindow:setSize(237, 42)
	mywindow:setEnabled(false)
	mywindow:clearTextExtends()
	mywindow:setTextExtends("-", g_STRING_FONT_GULIMCHE, 16, 255,220,144,255,  2, 255,200,76,255)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..comebackIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	-- ���׶�� �̹��� (��������� ����)
	local	index = 1
	
	for i = 0 , 15 do
		local Offset_Y = 21
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_comebackEventCircleImg" .. i)
		mywindow:setTexture("Enabled",	"UIData/event011.tga", 606, 414)
		mywindow:setTexture("Disabled", "UIData/event011.tga", 606, 414)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		
		if i == 0 or i == 8 then
			if i == 0 then
				mywindow:setPosition(513 , 190)
			elseif i == 8 then
				mywindow:setPosition(465 , 22)
			end
		
		elseif i > 8 and i <= 15 then
			mywindow:setPosition(465 , 22 + (Offset_Y * index))
			index = index + 1
		else
			mywindow:setPosition(513 , 190 + (Offset_Y * i))
		end
		
		mywindow:setSize(22 , 22)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		
		if i == 0 or i <= 7 then
			winMgr:getWindow("sj_1st_eventPopupImage"):addChildWindow(mywindow)
			
		elseif i == 8 or i <= 15 then
			winMgr:getWindow("sj_comebackEventCategoryImage"):addChildWindow(mywindow)
			
		end
		
	end
	
	
	function OnClickedCategoryChange(args)
		DebugStr("OnClickedCategoryChange")
		
		if winMgr:getWindow("sj_comebackEventCategoryImage") then
			local currentWindow = CEGUI.toWindowEventArgs(args).window
			if CEGUI.toRadioButton(currentWindow):isSelected() then
				local index = tonumber(currentWindow:getUserString("index"))
				
				if index == 1 then	-- 2�� ������ Open...
					if g_LimitOverlapEntry == 1 then
						DebugStr("1������ ƨ�ܳ�")
						return
					end
					
					winMgr:getWindow("sj_comebackEventCategoryImage"):setVisible(true)
									
					for i = 0 , 7 do
						if winMgr:getWindow("sj_comebackEventCircleImg"..i):isVisible() == true then
							g_1stPageData = g_1stPageData + 1
							winMgr:getWindow("sj_comebackEventCircleImg"..i):setVisible(false)
						end
					end	-- end of for
					
					SetCircleImgPostion(g_2ndPageData)
					g_2ndPageData = 0
					
					g_LimitOverlapEntry = 1
					
				else	-- 1�� ������ Open...
					
					if g_LimitOverlapEntry == 2 then
						DebugStr("2������ ƨ�ܳ�")
						return
					end
					
					winMgr:getWindow("sj_comebackEventCategoryImage"):setVisible(false)
										
					for i = 7 , 15 do
						if winMgr:getWindow("sj_comebackEventCircleImg"..i):isVisible() == true then
							g_2ndPageData = g_2ndPageData + 1
							winMgr:getWindow("sj_comebackEventCircleImg"..i):setVisible(false)
						end
					end	-- end of for
					
					SetCircleImgPostion(g_1stPageData)
					g_1stPageData = 0
					g_LimitOverlapEntry = 2
				end	-- end of if
			end	-- end of if
		end	-- end of if
	
	end	-- end of function
	
	--[[
	for i=0, #tComebackTexY do
		if i == 0 then
			winMgr:getWindow("sj_comebackEventCategoryBtn_"..i):setProperty("Selected", "true")
		else
			winMgr:getWindow("sj_comebackEventCategoryBtn_"..i):setProperty("Selected", "false")
		end
	end
	]]--
end


function GetComebackEventPlayCount(playCount)
	-- @ ī�װ��� ���� ��ư�� ���� �÷��� Ƚ���� ���� �����Ѵ�
	--	 ( 180�� ���� ----> 1������ , 180�� �̻� ----> 2������ )

	-- @ ������� ������ �� "Ƚ��" text ����
	if winMgr:getWindow("sj_comebackEventPlayCountText") then
		if playCount <= 0 then
			winMgr:getWindow("sj_comebackEventPlayCountText"):setTextExtends("-", g_STRING_FONT_GULIMCHE, 16, 255,220,144,255,  2, 255,200,76,255)
		else
			winMgr:getWindow("sj_comebackEventPlayCountText"):setTextExtends(playCount, g_STRING_FONT_GULIMCHE, 16, 255,220,144,255,  2, 255,200,76,255)
		end
	end
	
	
	-- @ ���׶�� PlayCount�� ���缭 ǥ��
	if playCount < 10 then	return end
	
	if     playCount == 10 or playCount <= 29	then	SetCircleImgPostion(1)
	elseif playCount == 30 or playCount <= 49	then	SetCircleImgPostion(2)		DebugStr("SetCircleImgPostion(2)")
	elseif playCount == 50 or playCount <= 79	then	SetCircleImgPostion(3)		DebugStr("SetCircleImgPostion(3)")
	elseif playCount == 80 or playCount <= 119	then	SetCircleImgPostion(4)
	elseif playCount == 120 or playCount <= 149 then	SetCircleImgPostion(5)
	elseif playCount == 150 or playCount <= 179 then	SetCircleImgPostion(6)
	elseif playCount == 180 or playCount <= 219 then	SetCircleImgPostion(7)
	elseif playCount == 220 or playCount <= 249 then	SetCircleImgPostion(8) 
	
	elseif playCount == 250 or playCount <= 279 then	SetCircleImgPostion(9)	
	elseif playCount == 280 or playCount <= 319 then	SetCircleImgPostion(10)
	elseif playCount == 320 or playCount <= 349 then	SetCircleImgPostion(11)
	elseif playCount == 350 or playCount <= 379 then	SetCircleImgPostion(12)
	elseif playCount == 380 or playCount <= 419 then	SetCircleImgPostion(13)
	elseif playCount == 420 or playCount <= 449 then	SetCircleImgPostion(14)
	elseif playCount == 450 or playCount <= 499 then	SetCircleImgPostion(15)		DebugStr("SetCircleImgPostion(15)")
	elseif playCount == 500	or playCount >  500	then	SetCircleImgPostion(16)		DebugStr("SetCircleImgPostion(16)")
	end	-- end of if

end	-- end of function


-- �Ĺ� �̺�Ʈ ���׶�� ��ġ��� �Լ�
function SetCircleImgPostion(count)
	for i = 0 , count-1 do
		winMgr:getWindow("sj_comebackEventCircleImg"..i):setVisible(true)
	end
end


-- �Ĺ� �̺�Ʈ ������ ��� �Ұ��� �̹��� �����
function SetComebackEventToEnable(bEnabled)
	if winMgr:getWindow("sj_comebackEventNotEnableImage") then
		if bEnabled == 1 then
			winMgr:getWindow("sj_comebackEventNotEnableImage"):setVisible(false)
			winMgr:getWindow("sj_comebackEventCategoryBtn_0"):setProperty("Selected" , "true")
		else
			winMgr:getWindow("sj_comebackEventNotEnableImage"):setVisible(true)
		end
	end
end

--------------------------------------------------------------------

-- ģ����õ �̺�Ʈ(�����ʿ�)

--------------------------------------------------------------------
local MAX_USER_PAGE = GetMaxRecommendFriendPage()
if recommendFriendIndex > 0 then

	-- ���� ��õ�� ���� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_recommendUserLevel")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,80,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("-")
	mywindow:setPosition(70, 376)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..recommendFriendIndex.."st_eventPopupImage"):addChildWindow(mywindow)

	-- ���� ��õ�� ���� �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_recommendUserName")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,80,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("-")
	mywindow:setPosition(190, 377)
	mywindow:setSize(200, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..recommendFriendIndex.."st_eventPopupImage"):addChildWindow(mywindow)

	-- ���� ��õ�� ���� ��Ϻ��� ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_recommendFriendListButton")
	mywindow:setTexture("Normal", "UIData/event012.tga", 611, 0)
	mywindow:setTexture("Hover", "UIData/event012.tga", 611, 31)
	mywindow:setTexture("Pushed", "UIData/event012.tga", 611, 62)
	mywindow:setTexture("PushedOff", "UIData/event012.tga", 611, 0)
	mywindow:setPosition(396, 371)
	mywindow:setSize(109, 31)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClickedShowRecommendFriendList")
	winMgr:getWindow("sj_"..recommendFriendIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	function ClickedShowRecommendFriendList(args)
		RequestRecommendFriend(0)
	end
	
	-- ���� ��õ�� ���� ���
	recommendwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_recommendFriendListBackImage")
	recommendwindow:setTexture("Enabled", "UIData/event012.tga", 720, 0)
	recommendwindow:setTexture("Disabled", "UIData/event012.tga", 720, 0)
	recommendwindow:setProperty("FrameEnabled", "False")
	recommendwindow:setProperty("BackgroundEnabled", "False")
	recommendwindow:setPosition(308, 0)
	recommendwindow:setSize(284, 421)
	recommendwindow:setVisible(false)
	recommendwindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..recommendFriendIndex.."st_eventPopupImage"):addChildWindow(recommendwindow)

	for i=0, MAX_USER_PAGE-1 do

		-- 1. ���� ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_recommendFriendList_level_"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setText("-")
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(5, 78+(i*32))
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)	-- �����ص� �ٸ��͵��� ���õǰ�
		recommendwindow:addChildWindow(mywindow)

		-- 2. ���� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_recommendFriendList_name_"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setText("-")
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(52, 78+(i*32))
		mywindow:setSize(40, 20)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		recommendwindow:addChildWindow(mywindow)
	end
	
	-- ���� ���� / �ִ� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_recommendFriendListPageInfo")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
	mywindow:setText("1")
	mywindow:setPosition(146, 354)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	recommendwindow:addChildWindow(mywindow)
	
	-- ���� ����Ʈ ���� ��, �� ��ư
	local tRFListLRButtonName  = {["err"]=0, [0]="sj_recommendFriendList_LBtn", "sj_recommendFriendList_RBtn"}
	local tRFListLRButtonTexX  = {["err"]=0, [0]=684, 702}
	local tRFListLRButtonPosX  = {["err"]=0, [0]=100, 182}
	local tRFListLRButtonEvent = {["err"]=0, [0]="ChangeRecommendFriendList_L", "ChangeRecommendFriendList_R"}
	for i=0, #tRFListLRButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tRFListLRButtonName[i])
		mywindow:setTexture("Normal", "UIData/event012.tga", tRFListLRButtonTexX[i], 356)
		mywindow:setTexture("Hover", "UIData/event012.tga", tRFListLRButtonTexX[i], 378)
		mywindow:setTexture("Pushed", "UIData/event012.tga", tRFListLRButtonTexX[i], 400)
		mywindow:setTexture("PushedOff", "UIData/event012.tga", tRFListLRButtonTexX[i], 356)
		mywindow:setPosition(tRFListLRButtonPosX[i], 354)
		mywindow:setSize(18, 22)
		mywindow:setSubscribeEvent("Clicked", tRFListLRButtonEvent[i])
		recommendwindow:addChildWindow(mywindow)
	end


	-- �븮��Ʈ�� �������� �� �������� ������ �����ؾ� �Ѵ�.
	function ChangeRecommendFriendList_L()
		local currPage = GetCurrentPageIndex()
		if currPage > 0 then
			currPage = currPage - 1
			RequestRecommendFriend(tonumber(currPage))
		end
	end


	function ChangeRecommendFriendList_R()
		local currPage = GetCurrentPageIndex()
		currPage = currPage + 1
		RequestRecommendFriend(tonumber(currPage))
	end
	
	-- ���� ��õ�� ����Ʈ Ȯ�ι�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_recommendFriendListOKButton")
	mywindow:setTexture("Normal", "UIData/event012.tga", 611, 124)
	mywindow:setTexture("Hover", "UIData/event012.tga", 611, 153)
	mywindow:setTexture("Pushed", "UIData/event012.tga", 611, 182)
	mywindow:setTexture("PushedOff", "UIData/event012.tga", 611, 124)
	mywindow:setPosition(100, 382)
	mywindow:setSize(100, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CloseRecommendFriendListWindow")
	recommendwindow:addChildWindow(mywindow)
	
	
	-------------------------------------------------
	-- NPC ���� ģ����õ
	-------------------------------------------------
	recommendSendwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_recommendFriendSendBackImage")
	recommendSendwindow:setTexture("Enabled", "UIData/event012.tga", 0, 414)
	recommendSendwindow:setTexture("Disabled", "UIData/event012.tga", 0, 414)
	recommendSendwindow:setProperty("FrameEnabled", "False")
	recommendSendwindow:setProperty("BackgroundEnabled", "False")
	recommendSendwindow:setPosition(640, 170)
	recommendSendwindow:setSize(352, 334)
	recommendSendwindow:setVisible(false)
	recommendSendwindow:setZOrderingEnabled(false)
	root:addChildWindow(recommendSendwindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_recommendFriendSendNameImage")
	mywindow:setTexture("Enabled", "UIData/event012.tga", 352, 414)
	mywindow:setTexture("Disabled", "UIData/event012.tga", 352, 414)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(16, 90)
	mywindow:setSize(320, 134)
	mywindow:setZOrderingEnabled(false)
	recommendSendwindow:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_recommendFriendSendNameText")
	mywindow:setPosition(76, 160)
	mywindow:setSize(200, 26)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:subscribeEvent("TextAccepted", "CheckRecommendFriendEnable")
	recommendSendwindow:addChildWindow(mywindow)
	CEGUI.toEditbox(winMgr:getWindow("sj_recommendFriendSendNameText")):setMaxTextLength(12)
	CEGUI.toEditbox(winMgr:getWindow("sj_recommendFriendSendNameText")):subscribeEvent("EditboxFull", "OnEditBoxFull")
	
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_recommendFriendSendNameOKButton")
	mywindow:setTexture("Normal", "UIData/event012.tga", 611, 124)
	mywindow:setTexture("Hover", "UIData/event012.tga", 611, 153)
	mywindow:setTexture("Pushed", "UIData/event012.tga", 611, 182)
	mywindow:setTexture("PushedOff", "UIData/event012.tga", 611, 124)
	mywindow:setPosition(70, 270)
	mywindow:setSize(100, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CheckRecommendFriendEnable")
	recommendSendwindow:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_recommendFriendSendNameCANCELButton")
	mywindow:setTexture("Normal", "UIData/event012.tga", 611, 240)
	mywindow:setTexture("Hover", "UIData/event012.tga", 611, 269)
	mywindow:setTexture("Pushed", "UIData/event012.tga", 611, 298)
	mywindow:setTexture("PushedOff", "UIData/event012.tga", 611, 240)
	mywindow:setPosition(190, 270)
	mywindow:setSize(100, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CloseRecommendFriendSendWindow")
	recommendSendwindow:addChildWindow(mywindow)
end

function OnEditBoxFull(args)
	PlayWave('sound/FullEdit.wav')
end

function ShowRecommendFriendListWindow()
	if winMgr:getWindow("sj_recommendFriendListBackImage") then
		winMgr:getWindow("sj_recommendFriendListBackImage"):setVisible(true)
	end
end

function CloseRecommendFriendListWindow()
	if winMgr:getWindow("sj_recommendFriendListBackImage") then
		winMgr:getWindow("sj_recommendFriendListBackImage"):setVisible(false)
	end
end


function SetRecommendFriendInfo(level, name)
	if winMgr:getWindow("sj_recommendUserLevel") and winMgr:getWindow("sj_recommendUserName") then
		winMgr:getWindow("sj_recommendUserLevel"):setText(tostring(level))
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
		winMgr:getWindow("sj_recommendUserName"):setText(name)
		winMgr:getWindow("sj_recommendUserName"):setPosition(190-nameSize/2, 377)
	end
end


function SetRecommendListPageInfo(curUser)
	if winMgr:getWindow("sj_recommendFriendListPageInfo") then
		local userText = tostring(curUser+1)
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, userText)	
		winMgr:getWindow("sj_recommendFriendListPageInfo"):setText(userText)
		winMgr:getWindow("sj_recommendFriendListPageInfo"):setPosition(150-size/2, 354)
	end
end


-- ������ ������
function RecommendFriend_ClearUserList()
	for i=0, MAX_USER_PAGE-1 do
		if winMgr:getWindow("sj_recommendFriendList_level_"..i) and winMgr:getWindow("sj_recommendFriendList_name_"..i) then
			winMgr:getWindow("sj_recommendFriendList_level_"..i):setVisible(false)
			winMgr:getWindow("sj_recommendFriendList_name_"..i):setVisible(false)
		end
	end
end


-- ������ ������
function RecommendFriend_ExistUserSet(i, level, userName)

	if winMgr:getWindow("sj_recommendFriendList_level_"..i) and winMgr:getWindow("sj_recommendFriendList_name_"..i) then
	
		winMgr:getWindow("sj_recommendFriendList_level_"..i):setVisible(true)
		winMgr:getWindow("sj_recommendFriendList_name_"..i):setVisible(true)
		
		-- 1. ���� ����
		local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))
		winMgr:getWindow("sj_recommendFriendList_level_"..i):setText(tostring(level))
		winMgr:getWindow("sj_recommendFriendList_level_"..i):setPosition(46-levelSize/2, 36+(i*33))
		
		-- 2. ���� �̸�
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, userName)
		winMgr:getWindow("sj_recommendFriendList_name_"..i):setText(userName)
		winMgr:getWindow("sj_recommendFriendList_name_"..i):setPosition(182-nameSize/2, 36+(i*33))
	end
end

-- NPC���� ģ����õ ������
function ShowRecommendFriendSendWindow()
	if winMgr:getWindow("sj_recommendFriendSendBackImage") then
		winMgr:getWindow("sj_recommendFriendSendBackImage"):setVisible(true)
	end
	
	if winMgr:getWindow("sj_recommendFriendSendNameText") then
		winMgr:getWindow("sj_recommendFriendSendNameText"):activate()
	end
end

-- ��ư���� ���
function CloseRecommendFriendSendWindow()

	VirtualImageSetVisible(false)
	CloseRecommendFriendWindow()
	TownNpcEscBtnClickEvent()winMgr:getWindow("sj_comebackEventCategoryBtn_0"):setProperty("Selected" , "true")
end

-- ESCŰ�� ������ ��
function CloseRecommendFriendSendWindowEsc()

	VirtualImageSetVisible(false)	
	CloseRecommendFriendWindow()
end

function CloseRecommendFriendWindow()
	if winMgr:getWindow("sj_recommendFriendSendBackImage") then
		winMgr:getWindow("sj_recommendFriendSendBackImage"):setVisible(false)
	end
	
	if winMgr:getWindow("sj_recommendFriendSendNameText") then
		winMgr:getWindow("sj_recommendFriendSendNameText"):setText("")
	end
	
	if winMgr:getWindow("doChatting") then
		if winMgr:getWindow('doChatting'):isVisible() then
			winMgr:getWindow('doChatting'):activate()
		end
	end
end

RegistEscEventInfo("sj_recommendFriendSendBackImage", "CloseRecommendFriendSendWindowEsc")


------------------------------------------------------------------------
-- ģ����õ ��ư�� ������ ���
------------------------------------------------------------------------
function CheckRecommendFriendEnable()
	if winMgr:getWindow("sj_recommendFriendSendNameText") then
		local name = winMgr:getWindow("sj_recommendFriendSendNameText"):getText()
		if CheckEnableCharacterName(name) then
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(g_STRING_RECOMMEND_1, name), "RecommendFriendOKFunction", "RecommendFriendCANCELFunction")
		else
			winMgr:getWindow("sj_recommendFriendSendNameText"):setText("")
			winMgr:getWindow("sj_recommendFriendSendNameText"):activate()
		end
	end	
end

function RecommendFriendOKFunction(args)
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "RecommendFriendOKFunction" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	SendRecommendFriendName()
end

function RecommendFriendCANCELFunction(args)
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "RecommendFriendCANCELFunction" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	if winMgr:getWindow("sj_recommendFriendSendNameText") then
		winMgr:getWindow("sj_recommendFriendSendNameText"):activate()
	end
end
	

function SendRecommendFriendName()
	if winMgr:getWindow("sj_recommendFriendSendNameText") then
		local name = winMgr:getWindow("sj_recommendFriendSendNameText"):getText()
		winMgr:getWindow("sj_recommendFriendSendNameText"):setText("")
		RequestRecommendFriendName(name)
	end
	
--	if winMgr:getWindow("sj_recommendFriendSendNameText") then
--		winMgr:getWindow("sj_recommendFriendSendNameText"):activate()
--	end
end


function ChristmasClickEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("eventPageBtn_0")):isSelected() then
		winMgr:getWindow("sj_"..christMasIndex.."st_eventPopupImage"):setTexture("Enabled",		"UIData/"..christMasImgTable[0], christMasTexXTable[0], christMasTexYTable[0])
		winMgr:getWindow("sj_"..christMasIndex.."st_eventPopupImage"):setTexture("Disabled",	"UIData/"..christMasImgTable[0], christMasTexXTable[0], christMasTexYTable[0])
	else
		winMgr:getWindow("eventPageBtn_0"):setProperty("Selected", "true") 
	end	
end


-- ũ�������� �̺�Ʈ ��������ư �̺�Ʈ
function ChristMasBtnEvent(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(currentWindow:getUserString("index"))

		winMgr:getWindow("sj_"..christMasIndex.."st_eventPopupImage"):setTexture("Enabled", "UIData/"..christMasImgTable[index], christMasTexXTable[index], christMasTexYTable[index])
		winMgr:getWindow("sj_"..christMasIndex.."st_eventPopupImage"):setTexture("Disabled", "UIData/"..christMasImgTable[index], christMasTexXTable[index], christMasTexYTable[index])
	end
end
--------------------------------------------------------------------

-- �̺�Ʈ ���� �޴� ������

--------------------------------------------------------------------
-- �̺�Ʈ ���� �����̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventRewardPopupAlphaImage")
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

-- �̺�Ʈ ���� ��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventRewardPopupBackImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition((1024 / 2 - 340 / 2), (768 / 2 - 134))
mywindow:setSize(340, 268)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupAlphaImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� Ÿ��Ʋ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventRewardPopupTitleImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 610)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 610)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, -2)
mywindow:setSize(340, 40)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_eventRewardPopupOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedEventRewardOK")
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� �޴� ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventRewardItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 50)
mywindow:setSize(98, 90)
mywindow:setLayered(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� �޴� ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_eventRewardItemNameText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 24)
mywindow:setPosition(124, 64)
mywindow:setSize(200, 20)
mywindow:setAlign(7)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(8)
mywindow:clearTextExtends()
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� �޴� ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_eventRewardItemCountText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(124, 100)
mywindow:setSize(200, 20)
mywindow:setAlign(8)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(8)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

-- �̺�Ʈ ���� �޴°�(�����Կ� ������ ���޵Ǿ����ϴ�.)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_eventRewardItemDesc2Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(70, 210)
mywindow:setSize(200, 20)
mywindow:setAlign(7)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(8)
mywindow:clearTextExtends()
mywindow:setTextExtends(g_STRING_REWARD_DESC2, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,   0, 255,255,255,255)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_eventRewardPopupBackImage"):addChildWindow(mywindow)

function ClickedEventRewardOK()
	winMgr:getWindow("sj_eventRewardPopupAlphaImage"):setVisible(false)
end

function CallAttendEventItemGetPopup(isMoney, itemImageFileName, itemImageFileName2, itemName, itemCount, eventGetIndex)
	root:addChildWindow(winMgr:getWindow("sj_eventRewardPopupAlphaImage"))
	winMgr:getWindow("sj_eventRewardPopupAlphaImage"):setVisible(true)	
	
	if isMoney == true then
		winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Enabled", itemImageFileName, 392, 838)
		winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Disabled", itemImageFileName, 392, 838)
		if itemImageFileName2 == "" then
			winMgr:getWindow("sj_eventRewardItemImage"):setLayered(false)
		else
			winMgr:getWindow("sj_eventRewardItemImage"):setLayered(true)
			winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Layered", itemImageFileName2, 392, 838)
		end
		
		winMgr:getWindow("sj_eventRewardItemNameText"):setPosition(118, 84)
		winMgr:getWindow("sj_eventRewardItemNameText"):setTextExtends(itemName, g_STRING_FONT_GULIMCHE, 24, 255,255,255,255,   0, 255,255,255,255)
		
		winMgr:getWindow("sj_eventRewardItemCountText"):setVisible(false)
		winMgr:getWindow("sj_eventRewardItemCountText"):setTextExtends("", g_STRING_FONT_GULIMCHE, 16, 255,255,255,255,   0, 255,255,255,255)
	else
		winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Enabled", itemImageFileName, 0, 0)
		winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Disabled", itemImageFileName, 0, 0)
		if itemImageFileName2 == "" then
			winMgr:getWindow("sj_eventRewardItemImage"):setLayered(false)
		else
			winMgr:getWindow("sj_eventRewardItemImage"):setLayered(true)
			winMgr:getWindow("sj_eventRewardItemImage"):setTexture("Layered", itemImageFileName2, 392, 838)
		end
		winMgr:getWindow("sj_eventRewardItemNameText"):setPosition(124, 64)
		winMgr:getWindow("sj_eventRewardItemNameText"):setTextExtends(itemName, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,   0, 255,255,255,255)
		
		local countText = CommatoMoneyStr(itemCount)
		local szCount = g_STRING_AMOUNT.." : "..countText
		winMgr:getWindow("sj_eventRewardItemCountText"):setVisible(true)
		winMgr:getWindow("sj_eventRewardItemCountText"):setTextExtends(szCount, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,   0, 255,255,255,255)
	end
	
	-- ������ �����Ŀ� ��ư�� ��Ȱ�� ��Ų��
	if winMgr:getWindow("sj_eventPopupGetItemBtn_"..eventGetIndex) then
		winMgr:getWindow("sj_eventPopupGetItemBtn_"..eventGetIndex):setVisible(false)
	end
end


--------------------------------------------------------------------

-- �̺�Ʈ �˸�

--------------------------------------------------------------------
-- �̺�Ʈ �˸� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventNotifyImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(5);
mywindow:setPosition(0, 120)
mywindow:setSize(1024, 138)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function ShowComebackEvent(fileName, texX, texY, sizeX, sizeY)
	DebugStr('ShowComebackEvent')
	DebugStr('fileName: ' .. fileName)
	DebugStr('�ؽ���X: ' .. texX)
	DebugStr('�ؽ���Y: ' .. texY)
	
	root:addChildWindow(winMgr:getWindow("sj_eventNotifyImage"))
	--winMgr:getWindow("sj_eventNotifyImage"):clearActiveController()
	winMgr:getWindow("sj_eventNotifyImage"):clearControllerEvent("notifyEvent")

	winMgr:getWindow("sj_eventNotifyImage"):setTexture("Enabled", fileName, texX, texY)
	winMgr:getWindow("sj_eventNotifyImage"):setTexture("Disabled", fileName, texX, texY)
	winMgr:getWindow("sj_eventNotifyImage"):setSize(sizeX, sizeY)
	winMgr:getWindow("sj_eventNotifyImage"):setVisible(true)
	winMgr:getWindow("sj_eventNotifyImage"):addController("notifyEvent", "notifyEvent", "alpha", "Sine_EaseInOut", 0, 255, 10, false, false, 10)
	winMgr:getWindow("sj_eventNotifyImage"):addController("notifyEvent", "notifyEvent", "alpha", "Sine_EaseInOut", 255, 255, 20, false, false, 10)
	winMgr:getWindow("sj_eventNotifyImage"):addController("notifyEvent", "notifyEvent", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
	winMgr:getWindow("sj_eventNotifyImage"):activeMotion("notifyEvent")
end


function SettingThanksGivingDayLimitCount(count)
	if winMgr:getWindow("sj_TGDEventCountText") then
		winMgr:getWindow("sj_TGDEventCountText"):setTextExtends(count, g_STRING_FONT_DODUM, 14, 255,255,255,255, 0, 255,255,255, 255)
	end
end


function SettingGiftCardCount(count)
	if winMgr:getWindow("sj_GiftCardEventCountText") then
		winMgr:getWindow("sj_GiftCardEventCountText"):setTextExtends(count.." ��", g_STRING_FONT_DODUM, 14, 255,255,255,255, 0, 255,255,255, 255)
	end
end


function UpdateEventRemainTime(time, bCheck)
	if bCheck then
		winMgr:getWindow("sj_eventPopupTimeText"):setTextExtends(time, g_STRING_FONT_DODUM, 12, 255, 0, 114,255, 1, 255,255,255,255)
	end
end


--------------------------------------------------------------------
-- PvP �̺�Ʈ
--------------------------------------------------------------------
if OldPVPIndex > 0 then

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "pvpRewardImage")
	mywindow:setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled",  "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(27	, 28)
	mywindow:setSize(550, 356)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..OldPVPIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	
	function OnClickedPVPBtn(args)
		
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(currentWindow):isSelected() then
			local index = tonumber(currentWindow:getUserString("index"))
			
			if index == 0 then
				winMgr:getWindow("pvpRewardImage"):setVisible(true)
				winMgr:getWindow("pvpImage"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
				winMgr:getWindow("pvpImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			else
				winMgr:getWindow("pvpRewardImage"):setVisible(false)
				winMgr:getWindow("pvpImage"):setTexture("Enabled", "UIData/" .. pvpImgTable[index], pvpTexXTable[index], pvpTexYTable[index])
				winMgr:getWindow("pvpImage"):setTexture("Disabled", "UIData/" .. pvpImgTable[index], pvpTexXTable[index], pvpTexYTable[index])
			end
			
		end	-- end of if
	
	end	-- end of function

	
	
	local PvP_Enevt_ItemMAX = 9
	local PvP_Event_Ani_Start = -1


	function SetPvPEventBtn(nIndex, bGetItem)
		if bGetItem == 1 then
			winMgr:getWindow("PvP_Event_Item_Btn"..nIndex):setVisible(false)
			winMgr:getWindow("PvP_Event_Item"..nIndex):setVisible(true)
			winMgr:getWindow("PvP_Event_Item_Get"..nIndex):setVisible(true)
			
			winMgr:getWindow("PvP_Event_Item_Get"..nIndex):setTexture("Enabled", "UIData/event001.tga", 923, 148)
			winMgr:getWindow("PvP_Event_Item_Get"..nIndex):setTexture("Disabled", "UIData/event001.tga", 923, 148)
			
		elseif bGetItem == 0 then
			winMgr:getWindow("PvP_Event_Item"..nIndex):setVisible(false)
			winMgr:getWindow("PvP_Event_Item_Btn"..nIndex):setVisible(true)
		end
	end

	local RowCount = 4;
	for i = 0, PvP_Enevt_ItemMAX do
		
		
		--PVP_LINE_IMAGE = "event019.tga";
		--PVP_LINE_IMAGE_U = 605;
		--PVP_LINE_IMAGE_V = 37;
	
		-- ������ �����ִ� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PvP_Event_Item"..i)
		mywindow:setTexture("Enabled", "UIData/" .. PVP_LINE_IMAGE, PVP_LINE_IMAGE_U, PVP_LINE_IMAGE_V)
		mywindow:setTexture("Disabled", "UIData/" .. PVP_LINE_IMAGE, PVP_LINE_IMAGE_U, PVP_LINE_IMAGE_V)
		
		if i > RowCount then
			mywindow:setPosition(9 + ((i - RowCount - 1) * 67), 270)
		else
			mywindow:setPosition(9 + (i * 67), 203)
		end
		
		mywindow:setSize(63, 64)
		mywindow:setEnabled(false)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("pvpRewardImage"):addChildWindow(mywindow)
		
		-- ������ ���� �� �ִ� ��ư
		mywindow = winMgr:createWindow("TaharezLook/Button", "PvP_Event_Item_Btn"..i)
		mywindow:setTexture("Normal", "UIData/event001.tga", 963, 293)
		mywindow:setTexture("Hover", "UIData/event001.tga", 963, 311)
		mywindow:setTexture("Pushed", "UIData/event001.tga", 963, 329)
		mywindow:setTexture("PushedOff", "UIData/event001.tga", 963, 347)
		
		if i > RowCount then
			mywindow:setPosition(13 + ((i - RowCount - 1) * 67), 292)
		else
			mywindow:setPosition(13 + (i * 67), 225)
		end
		
		mywindow:setSize(55, 18)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("btnIndex", tostring(i))
		mywindow:subscribeEvent("Clicked", "ClickedPvPEventRewardOK")
		winMgr:getWindow("pvpRewardImage"):addChildWindow(mywindow)
		
		-- ���� ������ ǥ��
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PvP_Event_Item_Get"..i)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
		
		if i > RowCount then
			mywindow:setPosition(11 + ((i - RowCount - 1) * 67), 273)
		else
			mywindow:setPosition(11 + (i * 67), 205)
		end
		
		mywindow:setSize(74, 74)
		mywindow:setScaleWidth(200)
		mywindow:setScaleHeight(200)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("pvpRewardImage"):addChildWindow(mywindow)
	end

end


function UpdatePvPEvent()

	if OldPVPIndex <= 0 then
		return
	end

	local PvPEventCount, GetItem10, GetItem30, GetItem50, GetItem80, GetItem120, GetItem150, GetItem180, GetItem220,
		GetItem250, GetItem280, GetItem320, GetItem350, GetItem380, GetItem420, GetItem450, GetItem500 = PvPEventInfo()
	--[[
	PvPEventCount = 150
	GetItem10 = 0
	GetItem30 = 0
	GetItem50 = 0
	GetItem80 = 0
	]]
	if PvPEventCount > 500 then
		PvPEventCount = 500
	end
		
	local Hundred = PvPEventCount / 100
	local Ten	  = ( PvPEventCount - ( Hundred * 100 ) ) / 10
	local One	  = PvPEventCount % 10
	
	winMgr:getWindow("PvP_Event_Img_Hundred"):setTexture("Enabled", "UIData/" .. pvpImgTable[0], 550 + ( Hundred * 28 ), 112)
	winMgr:getWindow("PvP_Event_Img_Hundred"):setTexture("Disabled", "UIData/" .. pvpImgTable[0], 550 + ( Hundred * 28 ), 112)
	
	winMgr:getWindow("PvP_Event_Img_Ten"):setTexture("Enabled", "UIData/" .. pvpImgTable[0], 550 + ( Ten * 28 ), 112)
	winMgr:getWindow("PvP_Event_Img_Ten"):setTexture("Disabled", "UIData/" .. pvpImgTable[0], 550 + ( Ten * 28 ), 112)
	
	winMgr:getWindow("PvP_Event_Img_One"):setTexture("Enabled", "UIData/" .. pvpImgTable[0], 550 + ( One * 28 ), 112)
	winMgr:getWindow("PvP_Event_Img_One"):setTexture("Disabled", "UIData/" .. pvpImgTable[0], 550 + ( One * 28 ), 112)
	
	if PvPEventCount >= 10  then	SetPvPEventBtn(0,  GetItem10)	end
	if PvPEventCount >= 30  then	SetPvPEventBtn(1,  GetItem30)	end	
	if PvPEventCount >= 50  then	SetPvPEventBtn(2,  GetItem50)	end	
	if PvPEventCount >= 80  then	SetPvPEventBtn(3,  GetItem80)	end
	if PvPEventCount >= 120 then	SetPvPEventBtn(4,  GetItem120)	end
	if PvPEventCount >= 150 then	SetPvPEventBtn(5,  GetItem150)	end
	if PvPEventCount >= 180 then	SetPvPEventBtn(6,  GetItem180)	end
	if PvPEventCount >= 220 then	SetPvPEventBtn(7,  GetItem220)	end
	
	if PvPEventCount >= 250 then	SetPvPEventBtn(8,  GetItem250)	end
	if PvPEventCount >= 280 then	SetPvPEventBtn(9,  GetItem280)	end
	if PvPEventCount >= 320 then	SetPvPEventBtn(10, GetItem320)	end
	if PvPEventCount >= 350 then	SetPvPEventBtn(11, GetItem350)	end
	if PvPEventCount >= 380 then	SetPvPEventBtn(12, GetItem380)	end
	if PvPEventCount >= 420	then	SetPvPEventBtn(13, GetItem420)	end
	if PvPEventCount >= 450 then	SetPvPEventBtn(14, GetItem450)	end
	if PvPEventCount >= 500 then	SetPvPEventBtn(15, GetItem500)	end
end

function ClickedPvPEventRewardOK(args)
	local currentWindow = CEGUI.toWindowEventArgs(args).window
	local buttonIndex	= tonumber(currentWindow:getUserString("btnIndex"))
	
	PvPEventItemCall(buttonIndex)
	PvP_Event_Ani_Start = buttonIndex
	winMgr:getWindow("PvP_Event_Item_Btn"..buttonIndex):setVisible(false)
	
	winMgr:getWindow("PvP_Event_Item_Get"..buttonIndex):setVisible(true)
	winMgr:getWindow("PvP_Event_Item_Get"..buttonIndex):setTexture("Enabled", "UIData/event001.tga", 923, 148)
	winMgr:getWindow("PvP_Event_Item_Get"..buttonIndex):setTexture("Disabled", "UIData/event001.tga", 923, 148)
end


function UpdateNewPvPEvent()

	DebugStr("UpdateNewPvPEvent");
	--if NewPVPIndex <= 0 then--0 ~
	--	return
	--end

	local PvPEventCount, GetItem10, GetItem30, GetItem50, GetItem80, GetItem120, GetItem150, GetItem180, GetItem220,
		GetItem250, GetItem280 = PvPEventInfo()
	DebugStr("UpdateNewPvPEvent : " .. PvPEventCount .. " > 10 ");	
	if PvPEventCount > 10 then
		PvPEventCount = 10;
	end
		

	if PvPEventCount >= 1	then	SetPvPEventBtn(0,  GetItem10)	end
	if PvPEventCount >= 2	then	SetPvPEventBtn(1,  GetItem30)	end	
	if PvPEventCount >= 3	then	SetPvPEventBtn(2,  GetItem50)	end	
	if PvPEventCount >= 4	then	SetPvPEventBtn(3,  GetItem80)	end
	if PvPEventCount >= 5	then	SetPvPEventBtn(4,  GetItem120)	end
	if PvPEventCount >= 6	then	SetPvPEventBtn(5,  GetItem150)	end
	if PvPEventCount >= 7	then	SetPvPEventBtn(6,  GetItem180)	end
	if PvPEventCount >= 8	then	SetPvPEventBtn(7,  GetItem220)	end
	if PvPEventCount >= 9	then	SetPvPEventBtn(8,  GetItem250)	end
	if PvPEventCount >= 10	then	SetPvPEventBtn(9,  GetItem280)	end
end



PlayTimeMaxCount = 5
CountImagePos	 = 0

-- Play Time Event
if PlayTimeIndex > -1 then

--[[
	if PlayTimeIndex == 1 then
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeNewImg")
		mywindow:setTexture("Enabled", "UIData/event005.tga", 192, 452)
		mywindow:setTexture("Disabled","UIData/event005.tga", 192, 452)
		mywindow:setPosition(-15, -15)
		mywindow:setSize(136, 60)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_EventKind_"..PlayTimeIndex.."stBtn"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeAlarmImg")
		mywindow:setTexture("Enabled", "UIData/event005.tga", 328, 466)
		mywindow:setTexture("Disabled","UIData/event005.tga", 328, 466)
		mywindow:setPosition(37, -38)
		mywindow:setSize(108, 46)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_EventKind_"..PlayTimeIndex.."stBtn"):addChildWindow(mywindow)
	end
]]--
	for i = 0, PlayTimeMaxCount - 1 do
		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeImage"..i)
		mywindow:setTexture("Enabled", "UIData/event004.tga", 900, 44)
		mywindow:setTexture("Disabled","UIData/event004.tga", 900, 44)
		mywindow:setPosition(24 + (i * 115), 190)
		mywindow:setSize(102, 126)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
		
		-- ������ ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/Button", "PlayTimeEvent_Item_Btn"..i)
		mywindow:setTexture("Normal", "UIData/event004.tga", 606, 137)
		mywindow:setTexture("Hover", "UIData/event004.tga", 606, 75)
		mywindow:setTexture("Pushed", "UIData/event004.tga", 606, 106)
		mywindow:setTexture("PushedOff", "UIData/event004.tga", 606, 44)
		mywindow:setPosition(30 + (i * 115), 276)
		mywindow:setSize(90, 31)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		mywindow:setUserString("btnIndex", tostring(i))
		mywindow:subscribeEvent("Clicked", "ClickedGetPlayTimeItem")
		winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	end
	
	-- ȹ�� ���� ���� �ð�
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCountTenHourText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 22)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 22)
	mywindow:setPosition(283, 112)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCountOneHourText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 22)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 22)
	mywindow:setPosition(296, 112)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCountTenMinuteText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 22)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 22)
	mywindow:setPosition(317, 112)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCountOneMinuteText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 22)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 22)
	mywindow:setPosition(330, 112)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCountTimeText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 766, 22)
	mywindow:setTexture("Disabled","UIData/event004.tga", 766, 22)
	mywindow:setPosition(70, 230)
	mywindow:setSize(7, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)

	-- ���� ���� �ð�
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeAccrueTenHourText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 0)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 0)
	mywindow:setPosition(42, 230)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeAccrueOneHourText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 0)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 0)
	mywindow:setPosition(55, 230)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeAccrueTenMinuteText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 0)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 0)
	mywindow:setPosition(74, 230)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeAccrueOneMinuteText")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 606, 0)
	mywindow:setTexture("Disabled","UIData/event004.tga", 606, 0)
	mywindow:setPosition(87, 230)
	mywindow:setSize(16, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeCompleteImg")
	mywindow:setTexture("Enabled", "UIData/event004.tga", 773, 0)
	mywindow:setTexture("Disabled","UIData/event004.tga", 773, 0)
	mywindow:setPosition(180, 105)
	mywindow:setSize(232, 34)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..PlayTimeIndex.."st_eventPopupImage"):addChildWindow(mywindow)
end

function PlayTimeGetItemAlarm(Visible)
	if PlayTimeIndex > 1 then
		return
	end
--[[	
	if Visible == 1 then
		winMgr:getWindow("PlayTimeAlarmImg"):setVisible(true)
	else
		winMgr:getWindow("PlayTimeAlarmImg"):setVisible(false)
	end]]
end

function ClickedGetPlayTimeItem(args)
	local currentWindow = CEGUI.toWindowEventArgs(args).window
	local buttonIndex	= tonumber(currentWindow:getUserString("btnIndex"))
	
	GetPlayTimeItem(buttonIndex + 1)
	
	winMgr:getWindow("PlayTimeImage"..buttonIndex):setTexture("Enabled", "UIData/event004.tga", 696, 44)
	winMgr:getWindow("PlayTimeImage"..buttonIndex):setTexture("Disabled", "UIData/event004.tga", 696, 44)
	
	winMgr:getWindow("PlayTimeEvent_Item_Btn"..buttonIndex):setVisible(false)
	
	Mainbar_ClearEffect(BAR_BUTTONTYPE_EVENT)
end

function OpenPlayTimeItem(Count)
	if Count == 0 then
		return
	end
	
	for i = 0, Count - 1 do
		winMgr:getWindow("PlayTimeImage"..i):setTexture("Enabled", "UIData/event004.tga", 798, 44)
		winMgr:getWindow("PlayTimeImage"..i):setTexture("Disabled", "UIData/event004.tga", 798, 44)
		
		winMgr:getWindow("PlayTimeEvent_Item_Btn"..i):setTexture("Normal", "UIData/event004.tga", 606, 44)
		winMgr:getWindow("PlayTimeEvent_Item_Btn"..i):setEnabled(true)
		winMgr:getWindow("PlayTimeEvent_Item_Btn"..i):setVisible(true)
	end
	
	if Count == 5 then
		winMgr:getWindow("PlayTimeAccrueTenHourText"):setVisible(false)
		winMgr:getWindow("PlayTimeAccrueOneHourText"):setVisible(false)
		winMgr:getWindow("PlayTimeCountTimeText"):setVisible(false)
		winMgr:getWindow("PlayTimeAccrueTenMinuteText"):setVisible(false)
		winMgr:getWindow("PlayTimeAccrueOneMinuteText"):setVisible(false)
		winMgr:getWindow("PlayTimeCompleteImg"):setVisible(true)
	else
		winMgr:getWindow("PlayTimeAccrueTenHourText"):setPosition(42 + (Count * 118), 230)
		winMgr:getWindow("PlayTimeAccrueOneHourText"):setPosition(55 + (Count * 118), 230)
		winMgr:getWindow("PlayTimeCountTimeText"):setPosition(70 + (Count * 118), 230)
		winMgr:getWindow("PlayTimeAccrueTenMinuteText"):setPosition(74 + (Count * 118), 230)
		winMgr:getWindow("PlayTimeAccrueOneMinuteText"):setPosition(87 + (Count * 118), 230)
	end
end

function SetPlayTimeItemInfo(Index, Complete)
	if Complete == 1 then
		winMgr:getWindow("PlayTimeImage"..Index):setTexture("Enabled", "UIData/event004.tga", 696, 44)
		winMgr:getWindow("PlayTimeImage"..Index):setTexture("Disabled", "UIData/event004.tga", 696, 44)
		winMgr:getWindow("PlayTimeEvent_Item_Btn"..Index):setVisible(false)
	end
end

function SetCountTheHours(CountHour, CountMinute, AccrueHour, AccrueMinute)
	local CountHourTen = AccrueHour / 10
	local CountHourOne = AccrueHour % 10
	
	winMgr:getWindow("PlayTimeCountTenHourText"):setTexture("Enabled", "UIData/event004.tga", 606 + (CountHourTen * 16), 0)
	winMgr:getWindow("PlayTimeCountTenHourText"):setTexture("Disabled", "UIData/event004.tga", 606 + (CountHourTen * 16), 0)
	
	winMgr:getWindow("PlayTimeCountOneHourText"):setTexture("Enabled", "UIData/event004.tga", 606 + (CountHourOne * 16), 0)
	winMgr:getWindow("PlayTimeCountOneHourText"):setTexture("Disabled", "UIData/event004.tga", 606 + (CountHourOne * 16), 0)
	
	local CountMinuteTen = AccrueMinute / 10
	local CountMinuteOne = AccrueMinute % 10
	
	winMgr:getWindow("PlayTimeCountTenMinuteText"):setTexture("Enabled", "UIData/event004.tga", 606 + (CountMinuteTen * 16), 0)
	winMgr:getWindow("PlayTimeCountTenMinuteText"):setTexture("Disabled", "UIData/event004.tga", 606 + (CountMinuteTen * 16), 0)
	
	winMgr:getWindow("PlayTimeCountOneMinuteText"):setTexture("Enabled", "UIData/event004.tga", 606 + (CountMinuteOne * 16), 0)
	winMgr:getWindow("PlayTimeCountOneMinuteText"):setTexture("Disabled", "UIData/event004.tga", 606 + (CountMinuteOne * 16), 0)
	
	local AccrueHourTen = CountHour / 10
	local AccrueHourOne = CountHour % 10
	
	winMgr:getWindow("PlayTimeAccrueTenHourText"):setTexture("Enabled", "UIData/event004.tga", 606 + (AccrueHourTen * 16), 22)
	winMgr:getWindow("PlayTimeAccrueTenHourText"):setTexture("Disabled", "UIData/event004.tga", 606 + (AccrueHourTen * 16), 22)
	
	winMgr:getWindow("PlayTimeAccrueOneHourText"):setTexture("Enabled", "UIData/event004.tga", 606 + (AccrueHourOne * 16), 22)
	winMgr:getWindow("PlayTimeAccrueOneHourText"):setTexture("Disabled", "UIData/event004.tga", 606 + (AccrueHourOne * 16), 22)
	
	local AccrueMinuteTen = CountMinute / 10
	local AccrueMinuteOne = CountMinute % 10
	
	winMgr:getWindow("PlayTimeAccrueTenMinuteText"):setTexture("Enabled", "UIData/event004.tga", 606 + (AccrueMinuteTen * 16), 22)
	winMgr:getWindow("PlayTimeAccrueTenMinuteText"):setTexture("Disabled", "UIData/event004.tga", 606 + (AccrueMinuteTen * 16), 22)
	
	winMgr:getWindow("PlayTimeAccrueOneMinuteText"):setTexture("Enabled", "UIData/event004.tga", 606 + (AccrueMinuteOne * 16), 22)
	winMgr:getWindow("PlayTimeAccrueOneMinuteText"):setTexture("Disabled", "UIData/event004.tga", 606 + (AccrueMinuteOne * 16), 22)
end

--------------------------------------------------------------------
-- ��� Alpha
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeEventResultAlpha")
mywindow:setTexture("Enabled", "UIData/Black.dds", 0, 0)
mywindow:setTexture("Disabled", "UIData/Black.dds", 0, 0)
mywindow:setAlpha(170)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

local EVENT_WIDTH, EVENT_HEIGHT = EventGetWindowSize()

--------------------------------------------------------------------
-- ��� Main Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeEventResultMainImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 0, 330)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 0, 330)
mywindow:setPosition((EVENT_WIDTH / 2) - (339 / 2), (EVENT_HEIGHT / 2) - (265 / 2))
mywindow:setSize(339, 265)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PlayTimeEventResultAlpha"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��� Item Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PlayTimeEventResultImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(135, 80)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(150)
mywindow:setScaleHeight(150)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PlayTimeEventResultMainImg"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "PlayTimeEventResultText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 112)
mywindow:setText("[������ �̸�]�� ȹ�� �Ͽ����ϴ�.")
mywindow:setPosition(60, 150)
mywindow:setSize(250, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("PlayTimeEventResultMainImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ��� Ok Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "PlayTimeEventResultOKButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 89, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 89, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 89, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 89, 774)
mywindow:setPosition(120, 210)
mywindow:setSize(89, 32)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ClosePlayTimeResultPopUp")
winMgr:getWindow("PlayTimeEventResultMainImg"):addChildWindow(mywindow)

function OpenPlayTimeResultPopUp()
	root:addChildWindow(winMgr:getWindow("PlayTimeEventResultAlpha"))
	winMgr:getWindow("PlayTimeEventResultAlpha"):setVisible(true)
end

function ClosePlayTimeResultPopUp()
	winMgr:getWindow("PlayTimeEventResultAlpha"):setVisible(false)
end
DebugStr("Load My Evnet Lua !!!! " .. 3)									

function GetItemPopUp(ItemUIFileName, Count)
	local len = string.len(Count)
	
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Enabled", ItemUIFileName, 0,0)
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Disabled", ItemUIFileName, 0,0)
	
	winMgr:getWindow("PlayTimeEventResultText"):setPosition((250 / 2) - (len/2), 150)
	winMgr:getWindow("PlayTimeEventResultText"):setText(Count)
end

function GetZenPopUp(ZenCount)
	local len = string.len(ZenCount)
	
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Enabled", "UIData/ItemUIData/Item/Zen.tga", 0,0)
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Disabled", "UIData/ItemUIData/Item/Zen.tga", 0,0)
	
	winMgr:getWindow("PlayTimeEventResultText"):setPosition((230 / 2) - (len/2), 150)
	winMgr:getWindow("PlayTimeEventResultText"):setText(ZenCount)
end

function GetExpPopUp(ExpCount)
	local len = string.len(ExpCount)
	
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Enabled", "UIData/ItemUIData/Item/exp.tga", 0,0)
	winMgr:getWindow("PlayTimeEventResultImg"):setTexture("Disabled", "UIData/ItemUIData/Item/exp.tga", 0,0)
	
	winMgr:getWindow("PlayTimeEventResultText"):setPosition((250 / 2) - (len/2), 150)
	winMgr:getWindow("PlayTimeEventResultText"):setText(ExpCount)
end

if LoikrathongIndex > 0 then
	mywindow = winMgr:createWindow("TaharezLook/Button", "LoiOneButton")
	mywindow:setTexture("Normal", "UIData/event005.tga", 0, 406)
	mywindow:setTexture("Hover", "UIData/event005.tga", 22, 406)
	mywindow:setTexture("Pushed", "UIData/event005.tga", 44, 406)
	mywindow:setTexture("PushedOff", "UIData/event005.tga", 66, 406)
	mywindow:setPosition(530, 32)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "LoiOneButtonEvent")
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "LoiTwoButton")
	mywindow:setTexture("Normal", "UIData/event005.tga", 0, 428)
	mywindow:setTexture("Hover", "UIData/event005.tga", 22, 428)
	mywindow:setTexture("Pushed", "UIData/event005.tga", 44, 428)
	mywindow:setTexture("PushedOff", "UIData/event005.tga", 66, 428)
	mywindow:setPosition(559, 32)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "LoiTwoButtonEvent")
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):addChildWindow(mywindow)
end

function LoiOneButtonEvent()
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):setTexture("Enabled", "UIData/event012.tga", 0, 0)
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):setTexture("Disabled", "UIData/event012.tga", 0, 0)
end

function LoiTwoButtonEvent()
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):setTexture("Enabled", "UIData/event012.tga", 0, 416)
	winMgr:getWindow("sj_"..LoikrathongIndex.."st_eventPopupImage"):setTexture("Disabled", "UIData/event012.tga", 0, 416)
end

if ChristMasEventIndex > 0 then
	mywindow = winMgr:createWindow("TaharezLook/Button", "ChristMasOneButton")
	mywindow:setTexture("Normal", "UIData/event005.tga", 0, 406)
	mywindow:setTexture("Hover", "UIData/event005.tga", 22, 406)
	mywindow:setTexture("Pushed", "UIData/event005.tga", 44, 406)
	mywindow:setTexture("PushedOff", "UIData/event005.tga", 66, 406)
	mywindow:setPosition(530, 32)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "LoiOneButtonEvent")
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "ChristMasTwoButton")
	mywindow:setTexture("Normal", "UIData/event005.tga", 0, 428)
	mywindow:setTexture("Hover", "UIData/event005.tga", 22, 428)
	mywindow:setTexture("Pushed", "UIData/event005.tga", 44, 428)
	mywindow:setTexture("PushedOff", "UIData/event005.tga", 66, 428)
	mywindow:setPosition(559, 32)
	mywindow:setSize(22, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "LoiTwoButtonEvent")
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):addChildWindow(mywindow)
end

function LoiOneButtonEvent()
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):setTexture("Enabled", "UIData/event010.tga", 0, 0)
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):setTexture("Disabled", "UIData/event010.tga", 0, 0)
end

function LoiTwoButtonEvent()
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):setTexture("Enabled", "UIData/event010.tga", 0, 416)
	winMgr:getWindow("sj_"..ChristMasEventIndex.."st_eventPopupImage"):setTexture("Disabled", "UIData/event010.tga", 0, 416)
end

--------------------------------------------------------------------------------------------------
------------�⼮ üũ �̺�Ʈ ����
--------------------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NormalAttendEventBG")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 100)
mywindow:setSize(650, 285)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/RadioButton", "ShowNormalAttendEventBT")
mywindow:setTexture("Normal", "UIData/event013.tga", 609, 34 * 0)
mywindow:setTexture("Hover", "UIData/event013.tga", 609, 34 * 1)
mywindow:setTexture("Pushed", "UIData/event013.tga", 609, 34 * 2)
mywindow:setTexture("SelectedNormal",	"UIData/event013.tga",		609, 34 * 2);
mywindow:setTexture("SelectedHover",	"UIData/event013.tga",		609, 34 * 2);
mywindow:setTexture("SelectedPushed",	"UIData/event013.tga",		609, 34 * 2);
mywindow:setPosition(30, 73)
mywindow:setSize(95, 34)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
CEGUI.toRadioButton(mywindow):setSelected(true)
mywindow:subscribeEvent("SelectStateChanged", "OnClickedShowNormalAttendEventBT")
winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PremiumAttendEventBG")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
--mywindow:setTexture("Enabled", "UIData/black.tga", 0, 0)
--mywindow:setTexture("Disabled", "UIData/black.tga", 0, 0)
mywindow:setPosition(0, 70)
mywindow:setSize(650, 285)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/RadioButton", "ShowPremiumAttendEventBT")
mywindow:setTexture("Normal", "UIData/event013.tga", 609 + 95 + 1,	34 * 0)
mywindow:setTexture("Hover", "UIData/event013.tga", 609 + 95 + 1,	34 * 1)
mywindow:setTexture("Pushed", "UIData/event013.tga", 609 + 95 + 1,	34 * 2)
mywindow:setTexture("Enable", "UIData/event013.tga", 609 + 95 + 1,	34 * 3)
mywindow:setTexture("SelectedNormal",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
mywindow:setTexture("SelectedHover",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
mywindow:setTexture("SelectedPushed",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
mywindow:setPosition(127, 73)
mywindow:setSize(95, 34)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("SelectStateChanged", "OnClickedShowPremiumAttendEventBT")
winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "BuyPremiumAttendBT")
mywindow:setTexture("Normal", "UIData/event013.tga", 801 ,	2)
mywindow:setTexture("Hover",  "UIData/event013.tga", 801 ,	23)
mywindow:setTexture("Pushed", "UIData/event013.tga", 801 ,	44)
mywindow:setPosition(210, 64)
mywindow:setSize(21, 20)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "OnClickedBuyPremiumAttendBT")
winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage"):addChildWindow(mywindow)

function OnClickedShowNormalAttendEventBT()
	DebugStr("OnClickedShowNormalAttendEventBT")
	mywindow = winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage")
	mywindow:setTexture("Enabled", "UIData/Event013.tga", 0, 417)
	winMgr:getWindow("NormalAttendEventBG"):setVisible(true)
	winMgr:getWindow("PremiumAttendEventBG"):setVisible(false)
end


function OnClickedShowPremiumAttendEventBT()
	DebugStr("OnClickedShowPremiumAttendEventBT")
	mywindow = winMgr:getWindow("sj_"..loginIndex.."st_eventPopupImage")
	mywindow:setTexture("Enabled", "UIData/Event013.tga", 0, 0)
	winMgr:getWindow("NormalAttendEventBG"):setVisible(false)
	winMgr:getWindow("PremiumAttendEventBG"):setVisible(true)
end

function OnClickedBuyPremiumAttendBT()
	winMgr:getWindow("sj_eventPopupBackImage"):setAlwaysOnTop(false)
	winMgr:getWindow("PremiumCheck_PopupImage"):setAlwaysOnTop(true)
	winMgr:getWindow("PremiumCheck_PopupAlpha"):setAlwaysOnTop(true)
	
	winMgr:getWindow("PremiumCheck_PopupText"):clearTextExtends()
    local String = GetBuyPremiumEventConfirmString()
    local String1 = AdjustString(g_STRING_FONT_GULIM, 11, String, 220)
    winMgr:getWindow("PremiumCheck_PopupText"):addTextExtends(String1, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);   
	
	winMgr:getWindow("PremiumCheck_PopupAlpha"):setVisible(true)
end

function OnSuccessBuyPremiumAttendItem()
	DebugStr("OnSuccessBuyPremiumAttendItem")
	RequestLoginEventInfo()
	SetAttendEventMsg(true)
end

function OnCheckOpenCashChargePage()
	winMgr:getWindow("PremiumCheck_PopupAlpha"):setVisible(false)
	winMgr:getWindow("CashCharge_PopupImage"):setAlwaysOnTop(true)
	--winMgr:getWindow("CashCharge_PopupAlpha"):setAlwaysOnTop(true)
	--winMgr:getWindow("CashCharge_PopupAlpha"):setVisible(true)	
	ShowNotifyOKMessage_Lua(PreCreateString_5303)
end

function OnShowNotiCannotPurchaseAttendEvent()
	winMgr:getWindow("PremiumCheck_PopupAlpha"):setVisible(false)
end

--------------------------------------------------------------------------------------------------
------------Normal �⼮ üũ �̺�Ʈ ------ Normal NormalAttendEventBG
--------------------------------------------------------------------------------------------------
if loginIndex ~= -1 then
	-- �⼮üũ �̺�Ʈ �����ܵ�
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventPopupDisable_"..i)
		mywindow:setTexture("Enabled", "UIData/event001.tga", 650, 285)
		mywindow:setTexture("Disabled", "UIData/event001.tga", 650, 285)
		mywindow:setPosition((i%7)*78 + IconPosx, (i/7)*78-53 + 50 + IconPosy)
		mywindow:setSize(73, 73)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventPopupIcon_"..i)
		mywindow:setTexture("Enabled", "UIData/event001.tga", 923, 148)
		mywindow:setTexture("Disabled", "UIData/event001.tga", 923, 148)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition((i%7)*78 + IconPosx, (i/7)*78- 53 + 50 + IconPosy)
		mywindow:setSize(74, 74)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "sj_eventPopupGetItemBtn_"..i)
		mywindow:setTexture("Normal", "UIData/event001.tga", 963, 293)
		mywindow:setTexture("Hover", "UIData/event001.tga", 963, 311)
		mywindow:setTexture("Pushed", "UIData/event001.tga", 963, 329)
		mywindow:setTexture("PushedOff", "UIData/event001.tga", 963, 329)
		mywindow:setPosition((i%7)*78+9 + IconPosx, (i/7)*78 - 30 + 50 + IconPosy)
		mywindow:setSize(55, 18)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("index", i)
	--	mywindow:addController("Controler", "GetEvent", "alpha", "Sine_EaseInOut", 0, 255, 8, true, false, 10)
		mywindow:subscribeEvent("Clicked", "OnClickedEventPopupGetItem")
		winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)
	end
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_eventPopupTimeText");
	mywindow:setPosition(IconPosx, 176 + IconPosy)
	mywindow:setSize(74, 20)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)	
end


-- �⼮üũ �̺�Ʈ ���� ������ ����
function SetUIAttendEvent(index, filePath, Quantity, money)
	if winMgr:getWindow("sj_eventRewardIcon_"..index) then
		return
	end
	if loginIndex == -1 then
		return
	end
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_eventRewardIcon_"..index)
	mywindow:setTexture("Disabled", filePath, 0, 0)
	mywindow:setPosition(6 + (index%7)*78 + IconPosx, (index/7)*78-3 + IconPosy)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_eventRewardValue_"..index);
	mywindow:setPosition(2 + (index%7)*78 + IconPosx, (index/7)*78+2  + 50+ IconPosy)
	mywindow:setSize(74, 20)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	if money == 0 then
		mywindow:addTextExtends(tostring(Quantity).." EA", g_STRING_FONT_DODUM, 12, 255,255,255,255, 1, 0,0,0,255)--0,0,0,255, 1, 255,255,255,255)
	else
		mywindow:addTextExtends(money, g_STRING_FONT_DODUM, 12,255,255,255,255, 1, 0,0,0,255)
	end
	winMgr:getWindow("NormalAttendEventBG"):addChildWindow(mywindow)
	
end


function OnClickedEventPopupGetItem(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window then
		local index = tonumber(window:getUserString("index"))
		RequestEventItemGet(index)
	end
end


--------------------------------------------------------------------------------------------------
------------Premium �⼮ üũ �̺�Ʈ ------ Premium NormalAttendEventBG
--------------------------------------------------------------------------------------------------
if loginIndex ~= -1 then
	-- �⼮üũ �̺�Ʈ �����ܵ�
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Premium_eventPopupDisable_"..i)
		mywindow:setTexture("Enabled", "UIData/event001.tga", 650, 285)
		mywindow:setTexture("Disabled", "UIData/event001.tga", 650, 285)
		mywindow:setPosition((i%7)*78 + IconPosx, (i/7)*78-53 + IconPosy + 80)
		mywindow:setSize(73, 73)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Premium_eventPopupIcon_"..i)
		mywindow:setTexture("Enabled", "UIData/event001.tga", 923, 148)
		mywindow:setTexture("Disabled", "UIData/event001.tga", 923, 148)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition((i%7)*78 + IconPosx, (i/7)*78-53 + IconPosy + 80)
		mywindow:setSize(74, 74)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Premium_eventPopupGetItemBtn_"..i)
		mywindow:setTexture("Normal", "UIData/event001.tga", 963, 293)
		mywindow:setTexture("Hover", "UIData/event001.tga", 963, 311)
		mywindow:setTexture("Pushed", "UIData/event001.tga", 963, 329)
		mywindow:setTexture("PushedOff", "UIData/event001.tga", 963, 329)
		mywindow:setPosition((i%7)*78+9 + IconPosx, (i/7)*78 - 30 + IconPosy + 80)
		mywindow:setSize(55, 18)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("index", i)
	--	mywindow:addController("Controler", "GetEvent", "alpha", "Sine_EaseInOut", 0, 255, 8, true, false, 10)
		mywindow:subscribeEvent("Clicked", "OnClickedEventPopupGetPremiumItem")
		winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)
		
	end
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_Premium_eventPopupTimeText");
	mywindow:setPosition(495, 12)
	mywindow:setSize(74, 20)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setVisible(true)
	mywindow:setEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)	
end


-- �⼮üũ �̺�Ʈ ���� ������ ����(��ý �� ������ �׸��� �۷� ��Ÿ���� �κ�)
function SetUIPremiumAttendEvent(index, filePath, Quantity, money)
	if winMgr:getWindow("sj_Premium_eventRewardIcon_"..index) then
		return
	end
	if loginIndex == -1 then
		return
	end
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Premium_eventRewardIcon_"..index)
	mywindow:setTexture("Disabled", filePath, 0, 0)
	mywindow:setPosition(6 + (index%7)*78 + IconPosx, (index/7)*78 - 53 + IconPosy + 80)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_Premium_eventRewardValue_"..index);
	mywindow:setPosition(2 + (index%7)*78 + IconPosx, (index/7)*78+2 + IconPosy + 80)
	mywindow:setSize(74, 20)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	if money == 0 then
		mywindow:addTextExtends(tostring(Quantity).." EA", g_STRING_FONT_DODUM, 12, 255,255,255,255, 1, 0,0,0,255)--0,0,0,255, 1, 255,255,255,255)
	else
		mywindow:addTextExtends(money, g_STRING_FONT_DODUM, 12,255,255,255,255, 1, 0,0,0,255)
	end
	winMgr:getWindow("PremiumAttendEventBG"):addChildWindow(mywindow)
	
end

function SetNoUsingPremiumEventIcon()
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		if winMgr:getWindow("sj_Premium_eventPopupDisable_"..i) ~= nil then
			winMgr:getWindow("sj_Premium_eventPopupDisable_"..i):setVisible(true)
		end
		if winMgr:getWindow("sj_Premium_eventPopupIcon_"..i) ~= nil then 
			winMgr:getWindow("sj_Premium_eventPopupIcon_"..i):setVisible(false)
		end	
	end
end

function MonthToString(Month)
 if Month == 1 then
	return  "Jan"
 elseif Month == 2 then
	return  "Feb"
 elseif Month == 3 then
	return  "Mar"
 elseif Month == 4 then
	return  "Apr"
 elseif Month == 5 then
	return  "May"
 elseif Month == 6 then
	return  "Jun"
 elseif Month == 7 then
	return  "Jul"
 elseif Month == 8 then
	return  "Aug"
 elseif Month == 9 then
	return  "Sep"
 elseif Month == 10 then
	return  "Oct"
 elseif Month == 11 then
	return  "Nov"
 elseif Month == 12 then
	return  "Dec"
 end
end
function SetPremiumEventIcon(lastCompleteCount, isTodayComplete, isCompleteDate)
	for i=0, g_MAX_EVENT_ICON_COUNT-1 do
		winMgr:getWindow("sj_Premium_eventPopupDisable_"..i):setVisible(true)
		winMgr:getWindow("sj_Premium_eventPopupIcon_"..i):setVisible(false)		
	end
	local year = isCompleteDate / 10000
	local MD = isCompleteDate % 10000;
	local Month = MD / 100;
	local MonthString = MonthToString(Month)
	local Day = MD % 100;	
	DebugStr("Year : " .. PreCreateString_5343)-- .. "MM : " .. String .. " Day : " .. Day - 1
	
	winMgr:getWindow("sj_Premium_eventPopupTimeText"):clearTextExtends()
	winMgr:getWindow("sj_Premium_eventPopupTimeText"):addTextExtends(PreCreateString_5343 .. " : " .. Day .. " - " .. MonthString, g_STRING_FONT_DODUM, 13, 255,255,255,255, 1, 0,0,0,255)
	-- ���� �̺�Ʈ�� ���� ���� ���
	if isTodayComplete == 0 then
		for i=0, lastCompleteCount do
			winMgr:getWindow("sj_Premium_eventPopupDisable_"..i):setVisible(false)
			winMgr:getWindow("sj_Premium_eventPopupIcon_"..i):setVisible(true)
		end
		mywindow = winMgr:getWindow("sj_Premium_eventPopupIcon_"..lastCompleteCount)
		mywindow:addController("PremiumEvent", "PremiumEvent", "alpha", "Linear_EaseNone", 255, 50, 10, true, true, 10)
		mywindow:addController("PremiumEvent", "PremiumEvent", "alpha", "Linear_EaseNone", 50, 255, 10, true, true, 10)
		mywindow:activeMotion('PremiumEvent');
	-- �̺�Ʈ�� �� �������
	else
		for i=0, lastCompleteCount -1  do
			winMgr:getWindow("sj_Premium_eventPopupDisable_"..i):setVisible(false)
			winMgr:getWindow("sj_Premium_eventPopupIcon_"..i):setVisible(true)
		end
	end	
end

function SetPremiumEventGetButton(presentIndex, isComplete)

end

function OnClickedEventPopupGetPremiumItem(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window then
		local index = tonumber(window:getUserString("index"))
		RequestEventPremiumItemGet(index)
	end
end

function NoUsingPremiumAttendEvent()
	DebugStr("NoUsingPremiumAttendEvent")
	local window = winMgr:getWindow("ShowPremiumAttendEventBT")
	if window ~= nil then
		window:setTexture("Normal", "UIData/event013.tga", 609 + 95 + 1,	34 * 3)
		window:setTexture("Hover",	"UIData/event013.tga", 609 + 95 + 1,	34 * 4)
		window:setTexture("Pushed", "UIData/event013.tga", 609 + 95 + 1,	34 * 5)
		window:setTexture("Enable", "UIData/event013.tga", 609 + 95 + 1,	34 * 3)
		window:setTexture("SelectedNormal",	"UIData/event013.tga",		609 + 95 + 1, 34 * 5);
		window:setTexture("SelectedHover",	"UIData/event013.tga",		609 + 95 + 1, 34 * 5);
		window:setTexture("SelectedPushed",	"UIData/event013.tga",		609 + 95 + 1, 34 * 5);
		window:setVisible(true)
		window:setEnabled(true)
		
		local windowBT = winMgr:getWindow("BuyPremiumAttendBT")
		windowBT:setVisible(true)
		windowBT:setEnabled(true)
	end
end
function UsingPremiumAttendEvent()
	DebugStr("UsingPremiumAttendEvent1")
	local window = winMgr:getWindow("ShowPremiumAttendEventBT")
	if window ~= nil then
		DebugStr("UsingPremiumAttendEvent")
		window:setTexture("Normal", "UIData/event013.tga", 609 + 95 + 1,	34 * 0)
		window:setTexture("Hover",	"UIData/event013.tga", 609 + 95 + 1,	34 * 1)
		window:setTexture("Pushed", "UIData/event013.tga", 609 + 95 + 1,	34 * 2)
		window:setTexture("Enable", "UIData/event013.tga", 609 + 95 + 1,	34 * 0)
		window:setTexture("SelectedNormal",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
		window:setTexture("SelectedHover",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
		window:setTexture("SelectedPushed",	"UIData/event013.tga",		609 + 95 + 1, 34 * 2);
		window:setVisible(true)
		window:setEnabled(true)
		
		local windowBT = winMgr:getWindow("BuyPremiumAttendBT")
		windowBT:setVisible(false)
		windowBT:setEnabled(false)
	end
end

--------------------------------------------------------------------
-- Premium Attacd Check Event ���� Thai���� �߰��Ѵ�~~~~~
--------------------------------------------------------------------
function CreatePremiumCheckMessageBox ()
	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PremiumCheck_PopupAlpha');
	mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setPosition(0,0);
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow);

	RegistEscEventInfo("PremiumCheck_PopupAlpha", "PremiumCheckPopupEscEvent")
	RegistEnterEventInfo("PremiumCheck_PopupAlpha", "PremiumCheckPopupEnterEvent")

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'PremiumCheck_PopupImage');
	mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setWideType(6)
	mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 268) / 2);
	mywindow:setSize(340, 268);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('PremiumCheck_PopupAlpha'):addChildWindow(mywindow);

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm �ؽ�Ʈ
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PremiumCheck_PopupText");
	mywindow:setPosition(3, 45);
	mywindow:setSize(340, 180);
	mywindow:setAlign(7);
	mywindow:setLineSpacing(2);
	mywindow:setViewTextMode(1);
	mywindow:setEnabled(false)
	mywindow:clearTextExtends();
	local String = GetSStringInfo(LAN_Premium_Login_Notice_01)
	mywindow:addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	winMgr:getWindow('PremiumCheck_PopupImage'):addChildWindow(mywindow);
			

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ��ư (Ȯ��, ���)
	--------------------------------------------------------------------
	local ButtonName	= {['protecterr']=0, "PremiumCheck_PopupOKButton", "PremiumCheck_PopupCancelButton"}
	local ButtonTexX	= {['protecterr']=0,			693,					858}
	local ButtonPosX	= {['protecterr']=0,			4,						169}		
	local ButtonEvent	= {['protecterr']=0, "PremiumCheckPopupEnterEvent", "PremiumCheckPopupEscEvent"}

	for i=1, #ButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
		mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
		mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setPosition(ButtonPosX[i], 235)
		mywindow:setSize(166, 29)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUserString("index", 0)
		mywindow:subscribeEvent("Clicked", ButtonEvent[i])
		winMgr:getWindow('PremiumCheck_PopupImage'):addChildWindow(mywindow)
	end


	-- �����̾� ���� ������ cancel �̺�Ʈ
	function PremiumCheckPopupEscEvent()
		winMgr:getWindow("PremiumCheck_PopupAlpha"):setVisible(false)
	end



	-- �����̾� ���� ������ enter �̺�Ʈ
	function PremiumCheckPopupEnterEvent()
		winMgr:getWindow("PremiumCheck_PopupAlpha"):setVisible(false)
		BuyPremiumAttendence();
	end
end
				

function CreateMoveCashChargeMessageBox ()
	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CashCharge_PopupAlpha');
	mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setPosition(0,0);
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow);

	RegistEscEventInfo("CashCharge_PopupAlpha", "CashChargePopupEscEvent")
	RegistEnterEventInfo("CashCharge_PopupAlpha", "CashChargePopupEnterEvent")

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CashCharge_PopupImage');
	mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setWideType(6)
	mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 268) / 2);
	mywindow:setSize(340, 268);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('CashCharge_PopupAlpha'):addChildWindow(mywindow);

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm �ؽ�Ʈ
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CashCharge_PopupText");
	mywindow:setPosition(3, 45);
	mywindow:setSize(340, 180);
	mywindow:setAlign(7);
	mywindow:setLineSpacing(2);
	mywindow:setViewTextMode(1);
	mywindow:setEnabled(false)
	mywindow:clearTextExtends();
	local String = GetSStringInfo(LAN_Premium_Login_Notice_03)
	mywindow:addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	winMgr:getWindow('CashCharge_PopupImage'):addChildWindow(mywindow);
			

	--------------------------------------------------------------------
	-- BuyPremiumAttend Confirm ��ư (Ȯ��, ���)
	--------------------------------------------------------------------
	local ButtonName	= {['protecterr']=0, "CashCharge_PopupOKButton", "CashCharge_PopupCancelButton"}
	local ButtonTexX	= {['protecterr']=0,			693,					858}
	local ButtonPosX	= {['protecterr']=0,			4,						169}		
	local ButtonEvent	= {['protecterr']=0, "CashChargePopupEnterEvent", "CashChargePopupEscEvent"}

	for i=1, #ButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
		mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
		mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setPosition(ButtonPosX[i], 235)
		mywindow:setSize(166, 29)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUserString("index", 0)
		mywindow:subscribeEvent("Clicked", ButtonEvent[i])
		winMgr:getWindow('CashCharge_PopupImage'):addChildWindow(mywindow)
	end


	-- �����̾� ���� ������ cancel �̺�Ʈ
	function CashChargePopupEscEvent()
		winMgr:getWindow("CashCharge_PopupAlpha"):setVisible(false)
	end



	-- �����̾� ���� ������ enter �̺�Ʈ
	function CashChargePopupEnterEvent()
		winMgr:getWindow("CashCharge_PopupAlpha"):setVisible(false)
		ClickCashCharge()
	end
	DebugStr("TTTTTTTTTTTTTTTTTTTTTTest TTTEST !!!!")
end

CreatePremiumCheckMessageBox();
CreateMoveCashChargeMessageBox();
--------------------------------------------------------------------------------------------------
------------���� �̺�Ʈ ���
--------------------------------------------------------------------------------------------------

local SubEventBanners	= {['protecterr']=0, "ShowGoFightWin", "ShowDailyEvent", "ShowArcade", "ShowLevelUp",}
local BannerTexFileNames = {['protecterr']=0, "event008.tga", "event008.tga", "event009.tga", "event009.tga"}
local BannerPosXInTex = {['protecterr']=0, 0, 100, 200, 300}
local BannerPosYInTex = {['protecterr']=0, 0, 100, 200, 300}
local BannerSizeX= {['protecterr']=0, 100, 100, 100, 100}
local BannerSizeY= {['protecterr']=0, 100, 100, 100, 100}
local ShowButtonTexFileNames = {['protecterr']=0, "UIData/event008.tga", "UIData/event008.tga", "UIData/event009.tga", "UIData/event009.tga"}
local ShowButtonPosXInTex = {['protecterr']=0, 609, 609, 609, 609}
local ShowButtonPosYInTex = {['protecterr']=0, 0, 34 * 3, 0, 34 * 3}
local ShowButtonSizeX= {['protecterr']=0, 95, 95, 95, 95}
local ShowButtonSizeY= {['protecterr']=0, 34, 34, 34, 34}

local TEX_NORMAL = 0;
local TEX_HOVER = 1;
local TEX_PUSHED = 2;
function OnClickedFirstBT()
	DebugStr("Excute Function OnClickedFirstBT")
	winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):setTexture("Enabled", "UIData/event008.tga", 0, 0)
end
function OnClickedSecondBT()
	DebugStr("Excute Function OnClickedSecondBT")
	winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):setTexture("Enabled", "UIData/event008.tga", 0, 416)
end
function OnClickedThirdBT()
	winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):setTexture("Enabled", "UIData/event009.tga", 0, 0)
	DebugStr("Excute Function OnClickedThirdBT")
end
function OnClickedFourthBT()
	winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):setTexture("Enabled", "UIData/event009.tga", 0, 416)
	DebugStr("Excute Function OnClickedFourthBT")
end
local OnSelectedCallbackName= {['protecterr']=0, OnClickedFirstBT, OnClickedSecondBT, OnClickedThirdBT, OnClickedFourthBT}
function CreateEventUIs()
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "IntegrateEventBG")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 100)
	mywindow:setSize(650, 285)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):addChildWindow(mywindow)
end		
function CreateSubEventUI()
	for i= 1 ,	#SubEventBanners do
		DebugStr("CreateSubEventUI >>>>>>>>>>>>>>" .. i)
		local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BG_IntergragtedEventBanner" .. i)
		local mywindow = winMgr:createWindow("TaharezLook/RadioButton", "BT_ShowIntergratedEvent" .. i)
	end
end

function InitSubEventsUI()
	for i= 1 ,	#SubEventBanners do
		mywindow = winMgr:getWindow("BT_ShowIntergratedEvent" .. i)
		mywindow:setTexture("Normal", ShowButtonTexFileNames[i], ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_NORMAL + ShowButtonPosYInTex[i])
		mywindow:setTexture("Hover", ShowButtonTexFileNames[i], ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_HOVER + ShowButtonPosYInTex[i])
		mywindow:setTexture("Pushed", ShowButtonTexFileNames[i], ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_PUSHED + ShowButtonPosYInTex[i])
		mywindow:setTexture("SelectedNormal",	ShowButtonTexFileNames[i],		ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_PUSHED + ShowButtonPosYInTex[i]);
		mywindow:setTexture("SelectedHover",	ShowButtonTexFileNames[i],		ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_PUSHED + ShowButtonPosYInTex[i]);
		mywindow:setTexture("SelectedPushed",	ShowButtonTexFileNames[i],		ShowButtonPosXInTex[i], ShowButtonSizeY[i] * TEX_PUSHED + ShowButtonPosYInTex[i]);
		mywindow:setPosition(30 + BannerSizeX[i] * (i - 1) , 73 )
		mywindow:setSize(ShowButtonSizeX[i], ShowButtonSizeY[i])
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		local Name = OnSelectedCallbackName[i];
		mywindow:subscribeEvent("SelectStateChanged",  Name)
		winMgr:getWindow("sj_"..IntegrateEvent.."st_eventPopupImage"):addChildWindow(mywindow)
	end
	--winMgr:getWindow("BT_ShowIntergratedEvent" .. 1):setSelected(true)
	mywindow = winMgr:getWindow("BT_ShowIntergratedEvent" .. 1)
	if mywindow ~= nil then
		CEGUI.toRadioButton(winMgr:getWindow("BT_ShowIntergratedEvent" .. 1)):setSelected(true)
	end
end



function CreateIntergrateEventViewer()
	CreateEventUIs();
	CreateSubEventUI();
	InitSubEventsUI();
end

if IntegrateEvent >= 0 then
	CreateIntergrateEventViewer();
end


--------------------------------------------------------------------------------------------------
------------���� ���
--------------------------------------------------------------------------------------------------
local MAX_ORDER = 8
local MIN_ACCUM_ZEN = 0;
local MAX_ACCUM_ZEN = 999999999;

function ResetZackPotInfos()
	local AccumulateZen = 90909099
	if AccumulateZen < MIN_ACCUM_ZEN or AccumulateZen > MAX_ACCUM_ZEN then
		AccumulateZen = 0
	end
	SetJackPotInfo(AccumulateZen)
	
	--SetWinnreInfo(Rank, Name, Zen, Year, Month, Date)
	SetWinnreInfo(0, 0, 0, 0, 0, 0)
end

function SetJackPotInfo(AccumulatedZen)
	for i=1, MAX_ORDER do
		--DebugStr("AccumulatedZen : " .. AccumulatedZen )
		--DebugStr("i : " .. i )
		--DebugStr("Devine AccumulatedZen : " .. AccumulatedZen / math.pow (10, i ) )
		DrawAccumulateZenNum(AccumulatedZen / math.pow (10, i ), i)
	end
	DrawAccumulateZenNum(AccumulatedZen % 1000000, 0)
end

function DrawAccumulateZenNum(Zen,  Order)
	CreateAccumulateZenImage(Order, Zen);
	SetAccumulateZenImage(Order, Zen);
end

function CreateAccumulateZenImage(Order, AccumulateZen)
	if winMgr:getWindow("ZackPotNumber" .. Order) == nil then
		DebugStr("CreateAccumulateZenImage : " .. Order)
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZackPotNumber" .. Order)
		mywindow:setSize(34, 48)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_"..ZackPotEvent.."st_eventPopupImage"):addChildWindow(mywindow)
	end
end


local START_ZEN_POS_X = 82;
local START_ZEN_POS_Y = 141;
local INTERVAL_ACCUM_ZEN = 49

function SetAccumulateZenImage(Order, AccumulateZen)
	mywindow = winMgr:getWindow("ZackPotNumber" .. Order)
	if mywindow == nil then
		return
	end
	if AccumulateZen == 0 then
		mywindow:setTexture("Enabled", "UIData/slot.tga", 547, 817)
		mywindow:setTexture("Disabled", "UIData/slot.tga", 547, 817)
	else
		local RemainZen = AccumulateZen;
		if RemainZen > 100000 then
			RemainZen = RemainZen % 10000
		end	
		RemainZen = RemainZen % 10
		mywindow:setTexture("Enabled", "UIData/slot.tga", 601 + RemainZen * 34, 769)
		mywindow:setTexture("Disabled", "UIData/slot.tga", 601 + RemainZen * 34, 769)
	end
	mywindow:setPosition(START_ZEN_POS_X + (MAX_ORDER - Order) * INTERVAL_ACCUM_ZEN, START_ZEN_POS_Y)
end

function SetWinnreInfo(Rank, Name, Zen, Year, Month, Date)
	CreateWinnreInfoUI(Rank)
end

local START_WINNER_INFO_POS_X = 80;
local START_WINNER_INFO_POS_Y = 250;
local WINNER_INFO_FONT_SIZE = 15;
function CreateWinnreInfoUI(Rank)
	if winMgr:getWindow("WinnreInfoBG" .. Rank) == nil then
		DebugStr("CreateWinnreInfoUI : " .. Rank)
		
		local WinnreInfoBG = winMgr:createWindow("TaharezLook/StaticImage", "WinnreInfoBG" .. Rank)
		WinnreInfoBG:setSize(350, 48)
		WinnreInfoBG:setVisible(true)
		WinnreInfoBG:setAlwaysOnTop(true)
		WinnreInfoBG:setZOrderingEnabled(false)
		winMgr:getWindow("sj_"..ZackPotEvent.."st_eventPopupImage"):addChildWindow(WinnreInfoBG)

		mywindow = winMgr:createWindow("TaharezLook/StaticText", "WinnreInfoName" .. Rank)
		mywindow:setSize(150, 48)
		mywindow:setPosition(START_WINNER_INFO_POS_X + 150,  START_WINNER_INFO_POS_Y - 3)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, WINNER_INFO_FONT_SIZE)
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setText("WinnreInfoName" .. Rank)
		WinnreInfoBG:addChildWindow(mywindow)

		mywindow = winMgr:createWindow("TaharezLook/StaticText", "WinnreInfoDate" .. Rank)
		mywindow:setSize(150, 48)
		mywindow:setPosition(START_WINNER_INFO_POS_X + 0 ,  START_WINNER_INFO_POS_Y + 0)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, WINNER_INFO_FONT_SIZE)
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setText("WinnreInfoDate" .. Rank)
		WinnreInfoBG:addChildWindow(mywindow)

		mywindow = winMgr:createWindow("TaharezLook/StaticText", "TakenZen" .. Rank)
		mywindow:setSize(150, 48)
		mywindow:setPosition(START_WINNER_INFO_POS_X + 300,  START_WINNER_INFO_POS_Y + 0)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, WINNER_INFO_FONT_SIZE)
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setText("TakenZen" .. Rank)
		WinnreInfoBG:addChildWindow(mywindow)
	end
end

function OnClickedOpenEventWebBrowser()
	OpenEventWebbrowser()
end