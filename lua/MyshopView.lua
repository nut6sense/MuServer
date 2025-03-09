--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

g_MyshopViewCurrentPage	= 1;
g_MyshopViewMaxPage		= 1;


g_currentCategory = 0;

-- 스트링
local g_STRING_USING_PERIOD		= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- 사용기간
local g_STRING_UNTIL_DELETE		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- 삭제시까지
local g_STRING_SELLITEM			= PreCreateString_1525	--GetSStringInfo(LAN_CPP_VILLAGE_13)			-- 판매 아이템
local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)			-- 수량
local g_STRING_MYSHOP_CLOSE		= PreCreateString_1510	--GetSStringInfo(LAN_CPP_QUEST_ROOM_3)			-- 마이샵을 닫으시겠습니까?
local g_STRING_MYSHOP_NAME		= PreCreateString_1534	--GetSStringInfo(LAN_CPP_VILLAGE_22)			-- 마이샵
local g_STRING_MYSHOP_BUY_ASK	= PreCreateString_1007	--GetSStringInfo(LAN_LUA_ARCADESHOP_1)			-- 위 아이템을 정말 구입하시겠습니까?
local g_STRING_MYSHOP_START_ASK	= PreCreateString_1493	--GetSStringInfo(LAN_CPP_QUEST_2)				-- 수수료로 %d그랑이 결제됩니다.\n마이샵을 개설하시겠습니까?
local g_STRING_BASIC			= PreCreateString_1229	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_4)			-- 기본
local g_STRING_REFRESH			= PreCreateString_1132	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_5)		-- 마이샵을 다시 설정하시겠습니까?
local g_STRING_RESTART			= PreCreateString_1094	--GetSStringInfo(LAN_LUA_DLG_INVITE_2)			-- 마이샵을 개설하시겠습니까?

----------------------------------------------------------------------
-- 마이샵 뷰어 백판이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBackImage")
mywindow:setTexture("Enabled", "UIData/shop_view.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/shop_view.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(10, 125);
mywindow:setSize(968, 533)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 마이샵 뷰어 검색 백판이미지
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewSearchBackImage")
mywindow:setTexture("Enabled", "UIData/shop_view.tga", 0, 653)
mywindow:setTexture("Disabled", "UIData/shop_view.tga", 0,653)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(10, 10);
mywindow:setSize(519, 132)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


-----------------------------------------------------------------------
-- 마이샵 뷰어 아이템 목록
-----------------------------------------------------------------------
MyshopViewItemRadio =
{ ["protecterr"]=0, "MyshopViewItemRadio_1", "MyshopViewItemRadio_2", "MyshopViewItemRadio_3", "MyshopViewItemRadio_4", "MyshopViewItemRadio_5",
					"MyshopViewItemRadio_6", "MyshopViewItemRadio_7", "MyshopViewItemRadio_8", "MyshopViewItemRadio_9", "MyshopViewItemRadio_10"}


MyshopViewTextName	 = {['err'] = 0,  'ViewName', 'ViewCount', 'ViewPrice','ViewTotalPrice' , 'ViewSaler', 'ViewPlace'}
MyshopViewTextPosX	 = {['err'] = 0,  190, 370 , 450, 540, 650 , 770}
MyshopViewTextString = {['err'] = 0,  "genoside hair", "1" , "5000" , "200000", "yongpal2", "village1"}


for i=1, #MyshopViewItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	MyshopViewItemRadio[i]);	
	mywindow:setTexture("Normal", "UIData/invisible.tga",			296,583 );
	mywindow:setTexture("Hover", "UIData/shop_view.tga",			0, 789);
	mywindow:setTexture("Pushed", "UIData/shop_view.tga",			0, 789);
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",		296,583);	
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	296,583);
	mywindow:setTexture("SelectedHover", "UIData/shop_view.tga",		0, 789);
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	296,583);
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga",296,583);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			296, 583);
	mywindow:setSize(946, 34);
	mywindow:setPosition(10, 103+(i-1)*34);
	mywindow:setVisible(true);
	mywindow:setProperty("GroupID", 7775)
	mywindow:setUserString('Viewindex', tostring(i))
	mywindow:setEnabled(true)
	mywindow:setSubscribeEvent("MouseDoubleClicked", "OnMouseDoubleClickViewRadio")
	winMgr:getWindow('MyshopViewBackImage'):addChildWindow( winMgr:getWindow(MyshopViewItemRadio[i]));
	
		
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewItem_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(3, 1)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(70)
	mywindow:setScaleHeight(70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewItem_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(30, 12)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(mywindow)
	
	
	-- 아이템의 아이콘(Pure OR SelectedVisual) 이미지 ★ 아이콘
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewItem_Avatar_Icon_Type_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	--mywindow:setPosition(3, 103+(i-1)*35)
	mywindow:setPosition(3, 1)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(70)
	mywindow:setScaleHeight(70)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템의 아이콘(Pure OR SelectedVisual) 이미지2 ★ 뒷배경
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewItem_Avatar_Icon_Type2_"..i)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
	mywindow:setPosition(3, 103+(i-1)*35)
	mywindow:setSize(48, 48)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(mywindow)


	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewItem_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(33, 11)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyshopViewItem_Image_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewItem_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("MyshopViewToolIndex", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ViewItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ViewVanishTooltip")
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(mywindow)
	
	for j=1, #MyshopViewTextName do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", MyshopViewItemRadio[i]..MyshopViewTextName[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setTextColor(255,255,255,255)
		child_window:setSize(40, 20)
		child_window:setVisible(true)
		child_window:setPosition(MyshopViewTextPosX[j], 10)
		child_window:setEnabled(false)
		child_window:setText(MyshopViewTextString[j])
		child_window:setViewTextMode(1)
		child_window:setAlign(8)
		winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(child_window);
	end
	
	
	local child_window = winMgr:createWindow("TaharezLook/Button", MyshopViewItemRadio[i]..'ViewBuyMove')
	child_window:setTexture("Normal", "UIData/shop_view.tga", 787, 653)
	child_window:setTexture("Hover", "UIData/shop_view.tga", 787, 687)
	child_window:setTexture("Pushed", "UIData/shop_view.tga", 787, 721)
	child_window:setTexture("PushedOff", "UIData/shop_view.tga", 787, 653)
	child_window:setPosition(810, 0)
	child_window:setSize(114, 34)
	child_window:setVisible(false)
	child_window:setAlwaysOnTop(true)
	child_window:setUserString("ViewIndexNumber", 0);

	child_window:setSubscribeEvent("Clicked", "OnClickMyshopView_BuyMove")
	winMgr:getWindow(MyshopViewItemRadio[i]):addChildWindow(child_window);
end

function OnClickMyshopView_BuyNow(args)
	DebugStr('OnClickMyshopView_BuyNow')
end

function OnClickMyshopView_BuyMove(args)
	DebugStr('OnClickMyshopView_BuyMove')
	local IndexNumber = CEGUI.toWindowEventArgs(args).window:getUserString("ViewIndexNumber")
	MyshopViewBuyPopup(IndexNumber)
end

function OnMouseDoubleClickViewRadio(args)
	DebugStr('OnMouseDoubleClickViewRadio')
	local IndexNumber = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("Viewindex"))
	local ItemName = winMgr:getWindow(MyshopViewItemRadio[IndexNumber]..'ViewName'):getText()
	winMgr:getWindow("MyshopViewSearchEditBox"):setText(ItemName)
end

function ResetMyshopItemList()
	DebugStr("ResetMyshopItemList()")
	
	for i = 1, #MyshopViewItemRadio do
		winMgr:getWindow("MyshopViewItem_Avatar_Icon_Type_"..i):setVisible(false)	-- 클론 관련
		winMgr:getWindow("MyshopViewItem_Avatar_Icon_Type2_"..i):setVisible(false)	-- 클론 관련★
		
		winMgr:getWindow(MyshopViewItemRadio[i]):setEnabled(false)
		winMgr:getWindow("MyshopViewItem_Image_"..i):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("MyshopViewItem_Image_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("MyshopViewItem_Image_"..i):setLayered(false)		
		winMgr:getWindow(MyshopViewItemRadio[i]..'ViewBuyMove'):setVisible(false)
		winMgr:getWindow("MyshopViewItem_SkillLevelText_"..i):setText("")
		winMgr:getWindow("MyshopViewItem_SkillLevelImage_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		
		for j = 1 , #MyshopViewTextName do
			winMgr:getWindow(MyshopViewItemRadio[i]..MyshopViewTextName[j]):clearTextExtends();
			winMgr:getWindow(MyshopViewItemRadio[i]..MyshopViewTextName[j]):setText("")
		end
	end
end
------------------------------------
--- 마이샵 뷰터 아이템 리스트 세팅
------------------------------------
function SettingMyshopItemList(i, fileName , fileName2, itemName , itemUseCount, itemPrice , totalPrice , sellerName , serverName, serverNumber, itemGrade, ItemFirstName, avatarType, attach)
		
	DebugStr('ItemFirstName:'..ItemFirstName)
	winMgr:getWindow("MyshopViewItem_Image_"..i):setTexture("Enabled", fileName, 0, 0)
	winMgr:getWindow("MyshopViewItem_Image_"..i):setTexture("Disabled", fileName, 0, 0)
	if fileName2 == "" then
		winMgr:getWindow("MyshopViewItem_Image_"..i):setLayered(false)
	else
		winMgr:getWindow("MyshopViewItem_Image_"..i):setLayered(true)
		winMgr:getWindow("MyshopViewItem_Image_"..i):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow(MyshopViewItemRadio[i]):setEnabled(true)
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewBuyMove'):setVisible(true)
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewName'):addTextExtends(itemName, g_STRING_FONT_GULIMCHE, 112, 255,200,50,255  ,   0, 255,255,255,255);
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewName'):setText(ItemFirstName)
	local ddd = winMgr:getWindow(MyshopViewItemRadio[i]..'ViewName'):getText()
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewCount'):addTextExtends(itemUseCount, g_STRING_FONT_GULIMCHE, 112, 255,255,255,255,   0, 255,255,255,255);
	
	local granText = CommatoMoneyStr(itemPrice)
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewPrice'):addTextExtends(granText, g_STRING_FONT_GULIMCHE, 112, r,g,b,255,   0, 255,255,255,255);
	
	granText = CommatoMoneyStr(totalPrice)
	r,g,b = GetGranColor(tonumber(totalPrice))
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewTotalPrice'):addTextExtends(granText, g_STRING_FONT_GULIMCHE, 112, r,g,b,255,   0, 255,255,255,255);
	
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewSaler'):addTextExtends(sellerName, g_STRING_FONT_GULIMCHE, 112, 255,255,255,255,   0, 255,255,255,255);
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewPlace'):addTextExtends(serverName, g_STRING_FONT_GULIMCHE, 112, 255,255,255,255,   0, 255,255,255,255);
	winMgr:getWindow(MyshopViewItemRadio[i]..'ViewBuyMove'):setUserString("ViewIndexNumber", i);
	
	if itemGrade > 0 then
		winMgr:getWindow("MyshopViewItem_SkillLevelImage_"..i):setVisible(true)
		winMgr:getWindow("MyshopViewItem_SkillLevelImage_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		winMgr:getWindow("MyshopViewItem_SkillLevelText_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("MyshopViewItem_SkillLevelText_"..i):setText("+"..itemGrade)
	else
		winMgr:getWindow("MyshopViewItem_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("MyshopViewItem_SkillLevelText_"..i):setText("")
	end
	
	if avatarType == -1 then
		SetAvatarIconS("MyshopViewItem_Image_" , "MyshopViewItem_Avatar_Icon_Type2_" , "MyshopViewItem_Avatar_Icon_Type_" , 
						i , avatarType , attach )
	end						
end


------------------------------------
--- 툴팁표시
------------------------------------
function OnMouseEnter_ViewItemListInfo(args)
	
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("MyshopViewToolIndex"))
	index = index-1
	
	local itemKind, itemNumber = GetMyshopViewtipInfo(index , g_MyshopViewCurrentPage)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, -9, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

------------------------------------
--- 툴팁삭제
------------------------------------
function OnMouseLeave_ViewVanishTooltip()
	SetShowToolTip(false)	
end
------------------------------------
---페이지표시텍스트
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopView_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(460, 468)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setTextExtends("1 / 1", g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBackImage'):addChildWindow(mywindow)

------------------------------------
---페이지앞뒤버튼
------------------------------------
local MyshopViewPage_BtnName  = {["err"]=0, "MyshopViewPage_LBtn", "MyshopViewPage_RBtn"}
local MyshopViewPage_BtnTexX  = {["err"]=0, 519, 539}
local MyshopViewPage_BtnPosX  = {["err"]=0, 433, 552}
local MyshopViewPage_BtnEvent = {["err"]=0, "OnClickMyshopView_PrevPage", "OnClickMyshopView_NextPage"}
for i=1, #MyshopViewPage_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyshopViewPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/shop_view.tga", MyshopViewPage_BtnTexX[i], 653)
	mywindow:setTexture("Hover", "UIData/shop_view.tga", MyshopViewPage_BtnTexX[i], 673)
	mywindow:setTexture("Pushed", "UIData/shop_view.tga", MyshopViewPage_BtnTexX[i], 693)
	mywindow:setTexture("PushedOff", "UIData/shop_view.tga", MyshopViewPage_BtnTexX[i], 653)
	mywindow:setPosition(MyshopViewPage_BtnPosX[i], 465)
	mywindow:setSize(20, 20)
	mywindow:setSubscribeEvent("Clicked", MyshopViewPage_BtnEvent[i])
	winMgr:getWindow('MyshopViewBackImage'):addChildWindow(mywindow)
end

function OnClickMyshopView_PrevPage()
	if g_MyshopViewCurrentPage > 1 then
		MyshopViewItemSearchAll(g_MyshopViewCurrentPage-1, g_currentCategory)
	end
end

function OnClickMyshopView_NextPage()
	
	if g_MyshopViewCurrentPage < g_MyshopViewMaxPage then
		MyshopViewItemSearchAll(g_MyshopViewCurrentPage+1, g_currentCategory)
	end
end

-- 마이샵 뷰어 페이지 갱신

function SettingMyshopViewListPage(curPage, maxPage)
	g_MyshopViewCurrentPage = curPage
	g_MyshopViewMaxPage = maxPage
	
	if g_MyshopViewCurrentPage < 1 then
		g_MyshopViewCurrentPage =1
	end
	
	if g_MyshopViewMaxPage < 1 then
		g_MyshopViewMaxPage = 1
	end
	
	
	winMgr:getWindow("MyshopView_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

-----------------------------------------------------------------------
--ALL, 코스튬 , 스킬 , 소비 , 강화 , 캐쉬
-----------------------------------------------------------------------
 
MyshopViewTypeRadio = { ["protecterr"]=0, "View_Item_All", "View_Item_Costume", "View_Item_Skill", "View_Item_Etc" , "View_Item_Up"}
MyshopViewTypePosX	= {['err'] = 0, 50, 120, 190, 250, 320, }
MyshopViewTypeTextPosX	= {['err'] = 0, 0, 100, 200, 300 ,400}
MyshopViewTypeTextPosY	= {['err'] = 0, 533, 563 ,593, 623}
MyshopViewTypeEvent = {["err"]=0, "Select_View_All", "Select_View_Costume","Select_View_Skill","Select_View_Etc" , "Select_View_Up"}

for i=1, #MyshopViewTypeRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	MyshopViewTypeRadio[i]);	
	mywindow:setTexture("Normal", "UIData/shop_view.tga",			MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/shop_view.tga",				MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/shop_view.tga",			MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/shop_view.tga",			MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/shop_view.tga",	MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/shop_view.tga",		MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/shop_view.tga",	MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/shop_view.tga",	MyshopViewTypeTextPosX[i], MyshopViewTypeTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",	190, 706);
	mywindow:setSize(100, 30);	
	mywindow:setPosition((100*i)-88,39);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "Select_View_RadioBtn");
	winMgr:getWindow('MyshopViewBackImage'):addChildWindow( winMgr:getWindow(MyshopViewTypeRadio[i]) );
end


------------------------------------
-- 
------------------------------------
function Select_View_RadioBtn(args)
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local win_name = local_window:getName();
		
		if win_name == "View_Item_All" then
			g_currentCategory = 0
		elseif win_name == "View_Item_Costume" then
			g_currentCategory = 1
		elseif win_name == "View_Item_Skill" then
			g_currentCategory = 2
		elseif win_name == "View_Item_Etc" then
			g_currentCategory = 3
		elseif win_name == "View_Item_Up" then
			g_currentCategory = 4
		else
			g_currentCategory = 0
		end
		g_MyshopViewCurrentPage = 1
		MyshopViewItemSearchAll(g_MyshopViewCurrentPage, g_currentCategory)
	end	
end

----------------------------------------------------------------------
-- 마이샵 뷰어 아이템 리스트 재조회
-----------------------------------------------------------------------
function RefreshItemViewlist()
	g_MyshopViewCurrentPage = 1
	MyshopViewItemSearchAll(g_MyshopViewCurrentPage, g_currentCategory)
end

----------------------------------------------------------------------
-- 마이샵뷰터 검색 에디트 박스
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MyshopViewSearchEditBox");
mywindow:setText("")
mywindow:setPosition(20, 70)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setSize(300, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "OnClickMyshopViewSearch")
CEGUI.toEditbox(winMgr:getWindow('MyshopViewSearchEditBox')):setMaxTextLength(30)
winMgr:getWindow('MyshopViewSearchBackImage'):addChildWindow(mywindow)


----------------------------------------------------------------------
-- 마이샵 검색 확인버튼
-----------------------------------------------------------------------						
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewSearchBtn")
mywindow:setTexture("Normal", "UIData/shop_view.tga", 559, 653)
mywindow:setTexture("Hover", "UIData/shop_view.tga", 559, 687)
mywindow:setTexture("Pushed", "UIData/shop_view.tga", 559, 721)
mywindow:setTexture("PushedOff", "UIData/shop_view.tga", 559, 653)
mywindow:setPosition(280, 65 )
mywindow:setSize(114, 34)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", "OnClickMyshopViewSearch")
winMgr:getWindow('MyshopViewSearchBackImage'):addChildWindow(mywindow)


function OnClickMyshopViewSearch()

	local ItemName = winMgr:getWindow('MyshopViewSearchEditBox'):getText()	
	if ItemName == "" then
		return
	end
	winMgr:getWindow("View_Item_All"):setProperty('Selected', 'true');
	MyshopViewItemSearch(ItemName)
	winMgr:getWindow('MyshopViewSearchEditBox'):setText("")
	
end

----------------------------------------------------------------------
-- 마이샵 모두 보기 버튼
-----------------------------------------------------------------------						
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewSearchAllBtn")
mywindow:setTexture("Normal", "UIData/shop_view.tga", 673, 653)
mywindow:setTexture("Hover", "UIData/shop_view.tga", 673, 687)
mywindow:setTexture("Pushed", "UIData/shop_view.tga", 673, 721)
mywindow:setTexture("PushedOff", "UIData/shop_view.tga", 673, 653)
mywindow:setPosition(395, 65 )
mywindow:setSize(114, 34)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", "OnClickMyshopViewSearchAll")
winMgr:getWindow('MyshopViewSearchBackImage'):addChildWindow(mywindow)

function OnClickMyshopViewSearchAll()
	DebugStr('OnClickMyshopViewSearchAll')
	winMgr:getWindow("View_Item_All"):setProperty('Selected', 'true');
	MyshopViewItemSearch("%")
	--MyshopViewItemSearchAll()
end


----------------------------------------------------------------------
-- 마이샵뷰어 종료
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewCloseBtn");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setPosition(940, 7)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", 'OnclickMyshopViewClose');
winMgr:getWindow('MyshopViewBackImage'):addChildWindow(mywindow)

function OnclickMyshopViewClose()
	winMgr:getWindow('MyshopViewBackImage'):setVisible(false)
	winMgr:getWindow('MyshopViewSearchBackImage'):setVisible(false)
end

RegistEscEventInfo("MyshopViewBackImage", "OnclickMyshopViewClose")


----------------------------------------------------------------
-- 아이템 구매 alpha image
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewAlphaimage")
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
-- 아이템 구매 BackImage
-----------------------------------------------------------------------
-- 입력창 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuyItemBackImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(370, 200)
mywindow:setSize(296, 212)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewAlphaimage'):addChildWindow(mywindow)

--[[
-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewBuyCloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(266, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickMyshopViewBuyClose")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)
--]]

-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_ItemImage")
mywindow:setTexture("Enabled", "UIData/debug_b.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/debug_b.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/debug_b.tga", 0, 0)
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 아이템 백판 이미지(클론 관련) ★
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_CloneBackItemImage")
mywindow:setTexture("Enabled", "UIData/debug_b.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/debug_b.tga", 0, 0)
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 구매 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewBuy_BuyBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 876, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 876, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 876, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 876, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedBuyViewItem")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)


-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyshopViewBuy_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickMyshopViewBuyClose")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 스킬 레벨 테두리 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(33, 67)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_SkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)
--[[
-- 툴팁 이벤트를 위한 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)
--]]
-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 34)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_Num")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 50)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemCount", 0)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 아이템 기간
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 66)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 개당가격 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_OnePriceImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 82)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 82)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 100)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 총가격 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_TotalPriceImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 100)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 100)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 144)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 등록수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_RegistAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 구입수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_BuyAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 136)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 136)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 수량 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyshopViewBuy_InputAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 123)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)

-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MyshopViewBuy_Count_editbox")
mywindow:setPosition(120, 124)
mywindow:setSize(110, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
CEGUI.toEditbox(mywindow):setMaxTextLength(5)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
--CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeViewActive_Count")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)


-- 가격(구매때만 필요)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_granText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(100, 102)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemPrice", 0)
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)


-- 총가격 text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyshopViewBuy_totalPriceText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(100, 146)
mywindow:setSize(276, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "CalMyshopViewTotalPrice")
winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)


function CalMyshopViewTotalPrice()
	
	-- 개당가격 얻는다.
	local priceText = ""
	
	priceText = winMgr:getWindow("MyshopViewBuy_granText"):getUserString("itemPrice")
	
	if priceText == "" then
		priceText = "0"
	end
	local inputOnePrice = tonumber(priceText)
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("MyshopViewBuy_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("MyshopViewBuy_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText(tostring(limitAmount))
	end
	
	local totalPriceText, r, g, b = ConvertStringToMultiple(inputOnePrice, inputAmount)
	winMgr:getWindow("MyshopViewBuy_totalPriceText"):setTextColor(r,g,b,255)
	winMgr:getWindow("MyshopViewBuy_totalPriceText"):setText(totalPriceText)
end


-- 수량 입력 좌우버튼
local MyshopViewBuyLRButtonName  = {["err"]=0, [0]= "MyshopViewBuyCount_LBtn", "MyshopViewBuyCount_RBtn"}
local MyshopViewBuyLRButtonTexX  = {["err"]=0, [0]=889, 905}
local MyshopViewBuyLRButtonPosX  = {["err"]=0, [0]=100, 256}
local MyshopViewBuyLRButtonEvent = {["err"]=0, [0]="MyshopViewChagneInputCount_L", "MyshopViewChagneInputCount_R"}
for i=0, #MyshopViewBuyLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyshopViewBuyLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", MyshopViewBuyLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", MyshopViewBuyLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", MyshopViewBuyLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", MyshopViewBuyLRButtonTexX[i], 172)
	mywindow:setPosition(MyshopViewBuyLRButtonPosX[i], 125)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", MyshopViewBuyLRButtonEvent[i])
	winMgr:getWindow('MyshopViewBuyItemBackImage'):addChildWindow(mywindow)
end


-- 룸리스트를 변경한후 그 페이지의 정보를 셋팅해야 한다.
function MyshopViewChagneInputCount_L()
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("MyshopViewBuy_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	if inputAmount <= 0 then
		inputAmount = 0
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText(tostring(inputAmount))
	end
end


function MyshopViewChagneInputCount_R()

	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("MyshopViewBuy_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("MyshopViewBuy_Num"):getUserString("itemCount"))
	DebugStr('limitAmount:'..limitAmount)
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText(tostring(inputAmount))
	else
		DebugStr('inputAmount:'..inputAmount)
		inputAmount = inputAmount + 1
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText(tostring(inputAmount))
	end
end


RegistEscEventInfo("MyshopViewAlphaimage", "OnClickMyshopViewBuyClose")

-- 닫기버튼 누를때
function OnClickMyshopViewBuyClose()
	winMgr:getWindow("MyshopViewAlphaimage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("MyshopViewAlphaimage"))
end


function MyshopViewBuyPopup(index)
	
	local itemCount, itemName, itemFileName, itemFileName2, itemPrice, itemGrade, avatarType, attach = GetMyshopViewSelectInfo(index-1, 1)
	root:addChildWindow(winMgr:getWindow("MyshopViewAlphaimage"))
	winMgr:getWindow("MyshopViewAlphaimage"):setVisible(true)
	
	
	--아이템 이미지
	winMgr:getWindow("MyshopViewBuy_ItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("MyshopViewBuy_ItemImage"):setLayered(false)
	else
		winMgr:getWindow("MyshopViewBuy_ItemImage"):setLayered(true)
		winMgr:getWindow("MyshopViewBuy_ItemImage"):setTexture("Layered", itemFileName2, 0, 0)
	end
	winMgr:getWindow("MyshopViewBuy_ItemImage"):setScaleWidth(102)
	winMgr:getWindow("MyshopViewBuy_ItemImage"):setScaleHeight(102)
	
	-- 아이템 이름
	winMgr:getWindow("MyshopViewBuy_Name"):setText(itemName)
	winMgr:getWindow("MyshopViewBuy_BuyBtn"):setVisible(true)
	
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		DebugStr("itemGrade:"..itemGrade)
		winMgr:getWindow("MyshopViewBuy_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("MyshopViewBuy_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("MyshopViewBuy_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("MyshopViewBuy_SkillLevelText"):setText("+"..itemGrade)
	else
		winMgr:getWindow("MyshopViewBuy_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("MyshopViewBuy_SkillLevelText"):setText("")
	end
	
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("MyshopViewBuy_Num"):setText(szcount)
	winMgr:getWindow("MyshopViewBuy_Num"):setUserString("itemCount", itemCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("MyshopViewBuy_Period"):setText(period)
	
	-- 그랑 가격
	local granText = CommatoMoneyStr(itemPrice)
	winMgr:getWindow("MyshopViewBuy_granText"):setVisible(true)
	
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow("MyshopViewBuy_granText"):setTextColor(r,g,b,255)
	winMgr:getWindow("MyshopViewBuy_granText"):setText(granText)
	winMgr:getWindow("MyshopViewBuy_granText"):setUserString("itemPrice", itemPrice)
	
	--if itemCount == 1 then
		winMgr:getWindow("MyshopViewBuy_Count_editbox"):setText("1")
	--end
	winMgr:getWindow("MyshopViewBuy_Count_editbox"):activate()
	
	-- 클론 아바타 수량 입력창 부분 ★ ( 인벤토리 -----> 창고 )
	if avatarType == -1 then
		SetAvatarIcon("MyshopViewBuy_ItemImage" , "MyshopViewBuy_CloneBackItemImage" , avatarType , attach, itemFileName)
	else
		winMgr:getWindow("MyshopViewBuy_CloneBackItemImage"):setVisible(false)
	end
end

function OnClickedBuyViewItem()
	-- %s 아이템 %s개를\n%s그랑에 구매하시겠습니까?를 물어본다.
	local inputCount = tonumber(winMgr:getWindow("MyshopViewBuy_Count_editbox"):getText())
	AskPurchaseViewItem(inputCount)
end

-- 구매를 할때
function OnClickMyShopViewBuyOk()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopViewBuyOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 구매 ok
	ClickedRequestPurchaseViewItem()
	OnClickMyshopViewBuyClose()
end

-- 구매를 안할 때
function OnClickMyShopViewBuyCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopViewBuyCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	

	OnClickMyshopViewBuyClose()
end

