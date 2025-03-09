--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

local WINDOW_MYITEM_LIST = 0

--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------
local g_STRING_USING_PERIOD		= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- 사용기간
local g_STRING_UNTIL_DELETE		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- 삭제시까지
local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)			-- 수량

local ITEMLIST_COSTUME	= 0
local ITEMLIST_SKILL	= 1
local MAX_RESOLVE_REWARD	= 10
g_curPage_ResolveItemList = 1
g_maxPage_ResolveItemList = 1
ResolveSlotIndex = 0 
SelectBoneIndex = 0
local g_currenItemList	= GetCurrentMailItemMode()
RegistEscEventInfo("ResolveMainImage", "ResolveCancelEvent")

----------------------------------------------------------------------
-- 분해 선택한 아이템 창
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveMainImage")
mywindow:setTexture("Enabled", "UIData/bunhae_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/bunhae_001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(200, 250)
mywindow:setSize(330, 266)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


----------------------------------------------------------------------
-- 분해 톱니바퀴 하얀이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveEffectWhiteImage")
mywindow:setTexture("Enabled", "UIData/bunhae_001.tga", 346, 346)
mywindow:setTexture("Disabled", "UIData/bunhae_001.tga", 346, 346)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(85, 46)
mywindow:setSize(166, 166)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlign(8);
mywindow:addController("WhiteMotion", "WhiteMotion", "angle", "Linear_EaseNone", 0, 1000, 20, false, false, 10)
mywindow:subscribeEvent("MotionEventEnd", "RequestShowReward");
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 분해 톱니바퀴이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveEffectImage")
mywindow:setTexture("Enabled", "UIData/bunhae_001.tga", 346, 180)
mywindow:setTexture("Disabled", "UIData/bunhae_001.tga", 346, 180)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(85, 46)
mywindow:setSize(166, 166)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("ResolveEffectOn", "ResolveEffectOn", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)
mywindow:addController("ResolveEffectOff", "ResolveEffectOff", "alpha", "Linear_EaseNone", 0,255 , 10, true, false, 10)
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
--분해 알파이미지
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveAlphaImage")
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemImageSqure")
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
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)


-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveSelectItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(140, 104)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(138)
mywindow:setScaleHeight(138)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

-- 스킬 레벨 테두리 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveSelectItemSkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(170, 148)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveSelectItemSkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(9, 1)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResolveSelectItemSkillLevelImage"):addChildWindow(mywindow)

-- 툴팁 선택 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveSelectItemToolTipImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(138, 104)
mywindow:setSize(128, 128)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ResolveSelectItemListInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ResolveVanishTooltip")
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

-- 선택 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ResoleveSelectCancelBtn");	
mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 1008, 0)
mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 1008, 16)
mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 1008, 32)
mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 1008, 32)
mywindow:setPosition(185, 97)
mywindow:setSize(16, 16);
mywindow:setVisible(false);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickResolveSelectCancle");
winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)

-- 선택된 아이템 취소
function OnClickResolveSelectCancle()
	ResetResolveSelectItemInfo()
	ClearResolveSelectItem()
end

-- 보상아이템 요청
function RequestShowReward()

	RequestDisassembleItem()
	for i=1, #ResolveItemButtonName do	
		winMgr:getWindow(ResolveItemButtonName[i]):setVisible(true)
	end
end

function OnMouseEnter_ResolveSelectItemListInfo(args)
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



ResolveOkCancelBtn	= {['protecterr']=0, "ResolveOkBtn", "ResolveCancelBtn"}
ResolveOkCancelTexX	= {['protecterr']=0,	330,  411}
ResolveOkCancelPosX	= {['protecterr']=0,	80,	  180}
ResolveOkCancelEvent	= {['protecterr']=0, "ResolveOkBtnEvent", "ResolveCancelBtnEvent"}

-- 분해 취소 버튼
for i = 1, #ResolveOkCancelBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", ResolveOkCancelBtn[i])
	mywindow:setTexture("Normal", "UIData/bunhae_001.tga", ResolveOkCancelTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/bunhae_001.tga", ResolveOkCancelTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/bunhae_001.tga", ResolveOkCancelTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/bunhae_001.tga", ResolveOkCancelTexX[i], 81)
	mywindow:setPosition(ResolveOkCancelPosX[i], 230)
	mywindow:setSize(81, 27)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", ResolveOkCancelEvent[i])
	winMgr:getWindow('ResolveMainImage'):addChildWindow(mywindow)
end

local bSReslove = false
-- 분해시작
function ResolveOkBtnEvent()
	if winMgr:getWindow("ResoleveSelectCancelBtn"):isVisible() == false then
		return
	end
	
	bSReslove = true
	winMgr:getWindow("ResoleveSelectCancelBtn"):setVisible(false)
	winMgr:getWindow("ResolveEffectWhiteImage"):clearActiveController()
	winMgr:getWindow("ResolveEffectWhiteImage"):activeMotion("WhiteMotion")
	PlayWave('sound/gear.wav');
	for i=1, #tResolveItemButton do	
		winMgr:getWindow(tResolveItemButton[i]):setEnabled(false)
	end
	
	for i=1, #ResolveItemButtonName do	
		winMgr:getWindow(ResolveItemButtonName[i]):setVisible(false)
	end
end

--분해취소
function ResolveCancelBtnEvent()

	if bSReslove == true then
		return
	end
	
	VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
	winMgr:getWindow('ResolveMainImage'):setVisible(false)
	winMgr:getWindow('ResolveItemImage'):setVisible(false)
	winMgr:getWindow('ResolveAlphaImage'):setVisible(false)
	
	for i=1, #ResolveItemButtonName do	
		winMgr:getWindow(ResolveItemButtonName[i]):setVisible(true)
	end
	ClearResolveSelectItem()
	ResetResolveSelectItemInfo()
end


--분해취소
function ResolveCancelEvent()
	
	if bSReslove == true then
		return
	end
	VirtualImageSetVisible(false)
	winMgr:getWindow('ResolveMainImage'):setVisible(false)
	winMgr:getWindow('ResolveItemImage'):setVisible(false)
	winMgr:getWindow('ResolveAlphaImage'):setVisible(false)
	
	for i=1, #ResolveItemButtonName do	
		winMgr:getWindow(ResolveItemButtonName[i]):setVisible(true)
	end
	ClearResolveSelectItem()
	ResetResolveSelectItemInfo()
end

----------------------------------------------------------------------
-- 아이템분해 리스트 백판 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemImage")
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
 
ResolveItemButtonName =
{ ["protecterr"]=0, "Resolve_Cos", "Resolve_Skill"}
ResolveItemButtonTextPosX	= {['err'] = 0, 0, 70}
ResolveItemButtonTextPosY	= {['err'] = 0, 455, 476 ,497}
ResolveItemButtonEvent = {["err"]=0, "Select_Resolve_Cos","Select_Resolve_Skill"}

for i=1, #ResolveItemButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	ResolveItemButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/deal.tga",				ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",			ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",		ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga", ResolveItemButtonTextPosX[i], ResolveItemButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",	190, 706);
	mywindow:setSize(70, 21);	
	mywindow:setPosition((72*i)-68,39);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", ResolveItemButtonEvent[i]);
	winMgr:getWindow('ResolveItemImage'):addChildWindow( winMgr:getWindow(ResolveItemButtonName[i]) );
end

------------------------------------
--코스튬선택이벤트------------------
------------------------------------
function Select_Resolve_Cos(args)
	DebugStr('Select_Resolve_Cos');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Resolve_Cos');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_COSTUME
			ChangedResolveItemList(ITEMLIST_COSTUME)
		end	
	end	
end

------------------------------------
--스킬선택이벤트------------------
------------------------------------
function Select_Resolve_Skill(args)
	DebugStr('Select_Resolve_Skill');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Resolve_Skill');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_SKILL
			ChangedResolveItemList(g_currenItemList)
			
		end	
	end	
end
-----------------------------------------------------------------------
-- 아이템분해 목록 창 라디오버튼
-----------------------------------------------------------------------
tResolveItemRadio =
{ ["protecterr"]=0, "ResolveItemList_1", "ResolveItemList_2", "ResolveItemList_3", "ResolveItemList_4", "ResolveItemItemList_5"}


for i=1, #tResolveItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tResolveItemRadio[i]);	
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
	winMgr:getWindow('ResolveItemImage'):addChildWindow( winMgr:getWindow(tResolveItemRadio[i]) );
	
		
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemList_Image_"..i)
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
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
	
	-- 클론 아바타 아이템 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemList_BackImage_"..i)
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
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)


	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ResolveItemList_Image_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("ResolveRadioIndex", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ResolveItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ResolveVanishTooltip")
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
	
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tResolveItemRadio[i]):addChildWindow(mywindow)
end

-----------------------------------------------------------------------
--아이템 리스트 첨부 버튼 5개
-----------------------------------------------------------------------
 
tResolveItemButton =
{ ["protecterr"]=0, "ResolveItemButton_1", "ResolveItemButton_2", "ResolveItemButton_3", "ResolveItemButton_4", "ResolveItemButton_5"}
 

for i=1, #tResolveItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tResolveItemButton[i]);	
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setSize(63,18 );	
	mywindow:setPosition(220,95+(i-1)*54);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false);
	mywindow:setUserString('ResolveIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tResolveItemButtonEvent")
	winMgr:getWindow('ResolveItemImage'):addChildWindow( winMgr:getWindow(tResolveItemButton[i]));
end

function ShowResolveItemList()
	winMgr:getWindow('ResolveAlphaImage'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('ResolveAlphaImage'))
	winMgr:getWindow("ResolveItemImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('ResolveItemImage'))
	winMgr:getWindow("ResolveMainImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('ResolveMainImage'))
	for i=1, #ResolveItemButtonName do	
		winMgr:getWindow(ResolveItemButtonName[i]):setVisible(true)
	end
end

function CloseResolveItemList()
	DebugStr('CloseResolveItemList()')
	winMgr:getWindow("ResolveItemImage"):setVisible(false)
	winMgr:getWindow("ResolveMainImage"):setVisible(false)
	winMgr:getWindow('ResolveAlphaImage'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('ResolveAlphaImage') );
end

-----------------------------------------------------------------------
-- 분해 아이템 이름 파일이름 갯수등을 설정
-----------------------------------------------------------------------
function SetupResolveItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade, avatarType , attach)
    
    local j=i+1
	winMgr:getWindow(tResolveItemRadio[j]):setVisible(true)
	winMgr:getWindow(tResolveItemButton[j]):setVisible(true)
	
	-- 아이템 파일이름
	winMgr:getWindow("ResolveItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("ResolveItemList_Image_"..j):setLayered(false)
	else
		winMgr:getWindow("ResolveItemList_Image_"..j):setLayered(true)
		winMgr:getWindow("ResolveItemList_Image_"..j):setTexture("Layered", itemFileName2, 0, 0)
	end	
	
	winMgr:getWindow("ResolveItemList_Image_"..j):setScaleWidth(102)
	winMgr:getWindow("ResolveItemList_Image_"..j):setScaleHeight(102)
	
	
	if itemGrade > 0 then
		winMgr:getWindow("ResolveItemList_SkillLevelImage_"..j):setVisible(true)
		winMgr:getWindow("ResolveItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		winMgr:getWindow( "ResolveItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow( "ResolveItemList_SkillLevelText_"..j):setText("+"..itemGrade)
	else
		winMgr:getWindow("ResolveItemList_SkillLevelImage_"..j):setVisible(false)
		winMgr:getWindow("ResolveItemList_SkillLevelText_"..j):setText("")
	end
	
	-- 아이템 이름	
	local String = SummaryString(g_STRING_FONT_GULIM, 12, itemName, 180)	
	winMgr:getWindow("ResolveItemList_Name_"..j):setText(String)
	
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("ResolveItemList_Num_"..j):setText(szCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("ResolveItemList_Period_"..j):setText(period)	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★( 아이템 분해 )
	--SetAvatarIconS("ResolveItemList_Image_" , "ResolveItemList_Image_" , "ResolveItemList_BackImage_", j , avatarType , attach)
	
end

------------------------------------
---페이지표시텍스트
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolveItemList_PageText")
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
winMgr:getWindow('ResolveItemImage'):addChildWindow(mywindow)

------------------------------------
---페이지앞뒤버튼
------------------------------------
local tMyResolveItemList_BtnName  = {["err"]=0, [0]="MyResolveItemList_LBtn", "MyResolveItemList_RBtn"}
local tMyResolveItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
local tMyResolveItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
local tMyResolveItemList_BtnEvent = {["err"]=0, [0]= "OnClickResolveItemList_PrevPage", "OnClickResolveItemList_NextPage"}
for i=0, #tMyResolveItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyResolveItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyResolveItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyResolveItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyResolveItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyResolveItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyResolveItemList_BtnPosX[i], 378)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyResolveItemList_BtnEvent[i])
	winMgr:getWindow('ResolveItemImage'):addChildWindow(mywindow)
end
---------------------------------------------------
-- ResolveItemList 현재 페이지 / 최대 페이지
---------------------------------------------------
function ResolveItemListPage(curPage, maxPage)
	g_curPage_ResolveItemList = curPage
	g_maxPage_ResolveItemList = maxPage
	
	winMgr:getWindow("ResolveItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---이전페이지이벤트-------------------
------------------------------------
		 
function  OnClickResolveItemList_PrevPage()
  
	if g_curPage_ResolveItemList > 1 then
		g_curPage_ResolveItemList = g_curPage_ResolveItemList - 1
		ChangedResolveItemListCurrentPage(g_curPage_ResolveItemList)
	end
	
end
------------------------------------
---다음페이지이벤트-----------------
------------------------------------
function OnClickResolveItemList_NextPage()

	if g_curPage_ResolveItemList < g_maxPage_ResolveItemList then
		g_curPage_ResolveItemList = g_curPage_ResolveItemList + 1
		ChangedResolveItemListCurrentPage(g_curPage_ResolveItemList)
	end
	
end
function ClearResolveItemList()
    DebugStr('ClearResolveItemList()')
	for i=1, 5 do
		winMgr:getWindow(tResolveItemRadio[i]):setVisible(false)
		winMgr:getWindow(tResolveItemButton[i]):setVisible(false)
	end
end


function ShowResolveNpc()
	RequestResolveList()
	ShowResolveItemList()
end

-- 아이템 등록
function tResolveItemButtonEvent(args)	

	DebugStr('tMaiItemButtonEvent start');
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("ResolveIndex")
	DebugStr("첨부리스트index:"..index);
	index=index-1
	local bEnable = SelectResolveItem(tonumber(index))
	if bEnable then
		ResolveSelectItem()
		winMgr:getWindow("ResolveEffectImage"):clearActiveController()
		winMgr:getWindow("ResolveEffectImage"):activeMotion("ResolveEffectOn")
		winMgr:getWindow("ResoleveSelectCancelBtn"):setVisible(true)
		PlayWave('sound/ResolveRegist.wav');
	end
end

function ResolveSelectItem()
	
	local itemCount, itemName, itemFileName, itemFileName2, itemskillLevel, avatarType , attach = GetSelectResolveChangeItemInfo()

	-- 아이템 파일이름
	winMgr:getWindow("ResolveSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("ResolveSelectItemImage"):setLayered(false)
	else
		winMgr:getWindow("ResolveSelectItemImage"):setLayered(true)
		winMgr:getWindow("ResolveSelectItemImage"):setTexture("Layered", itemFileName2, 0, 0)	
	end	
	winMgr:getWindow("ResolveSelectItemImage"):setScaleWidth(138)
	winMgr:getWindow("ResolveSelectItemImage"):setScaleHeight(138)
	
	if itemskillLevel > 0 then
		winMgr:getWindow("ResolveSelectItemSkillLevelImage"):setVisible(true)
		winMgr:getWindow("ResolveSelectItemSkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemskillLevel], 486)
		winMgr:getWindow("ResolveSelectItemSkillLevelText"):setTextColor(tGradeTextColorTable[itemskillLevel][1], tGradeTextColorTable[itemskillLevel][2], tGradeTextColorTable[itemskillLevel][3], 255)
		winMgr:getWindow("ResolveSelectItemSkillLevelText"):setText("+"..itemskillLevel)
	else
		winMgr:getWindow("ResolveSelectItemSkillLevelImage"):setVisible(false)
		winMgr:getWindow("ResolveSelectItemSkillLevelText"):setText("")
	end
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	--SetAvatarIcon("ResolveSelectItemImage" , "ResolveSelectItemImage" , avatarType , attach)
	
end

function ClearResolveSelectItem()
	winMgr:getWindow("ResolveSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ResolveSelectItemSkillLevelText"):setText("")
	winMgr:getWindow("ResolveSelectItemSkillLevelImage"):setVisible(false)
	winMgr:getWindow("ResolveEffectImage"):clearActiveController()
	winMgr:getWindow("ResolveEffectImage"):activeMotion("ResolveEffectOff")
	--winMgr:getWindow("ResolveEffectWhiteImage"):clearActiveController()
	winMgr:getWindow("ResoleveSelectCancelBtn"):setVisible(false)
	winMgr:getWindow("ResolveSelectItemImage"):setLayered(false)
end


----------------------------------------------------------------------
-- 아이템 분해 결과창
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveRewardImage")
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
-- 아이템 분해 결과 확인버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "RequestRewardOkBtn")
mywindow:setTexture("Normal", "UIData/bunhae_001.tga", 330, 108)
mywindow:setTexture("Hover", "UIData/bunhae_001.tga", 330, 135)
mywindow:setTexture("Pushed", "UIData/bunhae_001.tga", 411, 108)
mywindow:setTexture("PushedOff", "UIData/bunhae_001.tga", 330, 108)
mywindow:setPosition(220, 360)
mywindow:setSize(81, 27)
mywindow:setVisible(true)
mywindow:setSubscribeEvent("Clicked", "OnClickResolveRewardOk")
winMgr:getWindow("ResolveRewardImage"):addChildWindow(mywindow)

function OnClickResolveRewardOk()
	DebugStr('OnClickResolveRewardOk()')
	ResetResolveReward()
	winMgr:getWindow("ResolveRewardAlphaImage"):setVisible(false)
	winMgr:getWindow("ResolveRewardImage"):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('ResolveRewardAlphaImage') );
	root:removeChildWindow( winMgr:getWindow('ResolveRewardImage') );
end

RegistEscEventInfo("ResolveRewardImage", "OnClickResolveRewardOk")
----------------------------------------------------------------------
--결과 알파이미지
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveRewardAlphaImage")
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

----------------------------------------------------------------------
-- 결과창에 붙는 40개의 아이템 이미지
-----------------------------------------------------------------------
for i = 1, 40 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveRewarditemImage"..i)
	mywindow:setTexture("Enabled", "UIData/ItemUIData/lock.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/lock.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	if i < 9 then
		mywindow:setPosition(48+(57*i)-70 ,75)
	elseif i < 17 then
		mywindow:setPosition(48+(57*i)-70-57*8 ,132)
	elseif i < 25 then
		mywindow:setPosition(48+(57*i)-70-57*16 ,189)
	elseif i < 33 then
		mywindow:setPosition(48+(57*i)-70-57*24 ,247)
	else
		mywindow:setPosition(48+(57*i)-70-57*32 ,304)
	end
	mywindow:setSize(128, 128)
	mywindow:setEnabled(false)
	--mywindow:setVisible(true)
	mywindow:setScaleWidth(80)
	mywindow:setScaleHeight(80)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ResolveRewardImage"):addChildWindow(mywindow)
	
	
	-- 보상 툴팁 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResolveReward_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	if i < 9 then
		mywindow:setPosition(48+(57*i)-70 ,75)
	elseif i < 17 then
		mywindow:setPosition(48+(57*i)-70-57*8 ,132)
	elseif i < 25 then
		mywindow:setPosition(48+(57*i)-70-57*16 ,189)
	elseif i < 33 then
		mywindow:setPosition(48+(57*i)-70-57*24 ,247)
	else
		mywindow:setPosition(48+(57*i)-70-57*32 ,304)
	end
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("ResolveRewardIndex", 0)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ResolveRewardListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ResolveVanishTooltip")
	winMgr:getWindow("ResolveRewardImage"):addChildWindow(mywindow)
	
end

function ResetResolveReward()
	for i = 1, 40 do
		winMgr:getWindow("ResolveRewarditemImage"..i):setTexture("Disabled", "UIData/ItemUIData/lock.tga", 0, 0)
	end
	
	for i = 1, 40 do
		winMgr:getWindow("ResolveReward_EventImage_"..i):setUserString("ResolveRewardIndex", 0)
	end
	
	for i=1, #tResolveItemButton do	
		winMgr:getWindow(tResolveItemButton[i]):setEnabled(true)
	end
end

function ShowResolveReward()
	root:addChildWindow(winMgr:getWindow("ResolveRewardAlphaImage"))
	root:addChildWindow(winMgr:getWindow("ResolveRewardImage"))
	winMgr:getWindow("ResolveRewardAlphaImage"):setVisible(true)
	winMgr:getWindow("ResolveRewardImage"):setVisible(true)
	PlayWave("sound/Item_Upgrade_Success.wav");
	bSReslove = false
end

function ShowErrorReward()
	bSReslove = false
	ResetResolveSelectItemInfo()
end

function UpdateResolveReward(index, itemFileName, itemNumber)
	--DebugStr('itemFileName:'..itemFileName)
	--DebugStr('itemNumber:'..itemNumber)
	winMgr:getWindow("ResolveRewarditemImage"..index):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("ResolveRewarditemImage"..index):setScaleWidth(80)
	winMgr:getWindow("ResolveRewarditemImage"..index):setScaleHeight(80)
	winMgr:getWindow("ResolveReward_EventImage_"..index):setUserString("ResolveRewardIndex", itemNumber)
	ResetResolveSelectItemInfo()
end


function OnMouseEnter_ResolveItemListInfo(args)
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("ResolveRadioIndex"))
	index = index-1
	
	local itemKind, itemNumber = GetResolveTooltipInfo(WINDOW_MYITEM_LIST, index)
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

function OnMouseEnter_ResolveRewardListInfo(args)
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	local itemNumber = tonumber(EnterWindow:getUserString("ResolveRewardIndex"))
	
	if itemNumber == 0 then
		return
	end
	
	local itemKind   = GetItemKind(itemNumber)
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


-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_ResolveVanishTooltip()
	SetShowToolTip(false)	
end


function RequestResolveItemList()
	ShowResolveNpc()
end