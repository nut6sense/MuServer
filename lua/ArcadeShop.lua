--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

--------------------------------------------------------------------
-- 전역으로 사용할 변수
--------------------------------------------------------------------
local ARCADELIST_MAXCOUNT		= 6									-- 상점 한페이지당 최대 갯수
local ARCADE_CURRENT_LIST_COUNT	= 6									-- 현재 목록 리스트 갯수
local Current_State_Rewa		= 0
local tBackImageTexX	= { ["err"]=0, [0]=363, 693, 363, 693, 693}		-- 애니메이션을 돌릴 이미지
local tBackImageTexY	= { ["err"]=0, [0]=668, 668, 846, 846, 846}
local ControlCount		= 0											-- 컨트롤러 카운트(컨트롤이 3개 달려있어서 3번후에 랜더해준다.)
local RenderOK			= false										-- 랜더할 시점을 설정해준다.
local tRewardTable		= {['protecterr']=0, -1, 0, "", "", "", -1}		-- itemType, ItemValue. ItemName, ItemFileName, ItemDesc, paytype
local RewardReturnOK	= false
local TextAlpha			= 0;
local LifeCount			= 1
local HotfixBundleTable = { ["err"]=0, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }
										, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }, { ["err"]=0, }  } -- 핫픽스 묶음으로 살때

local HotfixBundlePosTable = { ["err"]=0, { ["err"]=0, 48, 6}, { ["err"]=0, 17, 26}, { ["err"]=0, 78, 26}, { ["err"]=0, 25, 67}, { ["err"]=0, 70, 67}
										, { ["err"]=0, 37, 25}, { ["err"]=0, 58, 25}, { ["err"]=0, 30, 47}, { ["err"]=0, 65, 47}, { ["err"]=0, 48, 57}  } -- 핫픽스 묶음으로 살때

local tLifePurchaseInfo = {['err']=0, 0, 0, 0, 0}	-- 라이프 카운트, 개당가격, 현재 나의 그랑, 라이프갯수
local MaxLifeCount = 99


local tArcadeShopInfo = {['err']=0, {['err']=0,0,"","",0,""}, {['err']=0,0,"","",0,""}, {['err']=0,0,"","",0,""}, 
								{['err']=0,0,"","",0,""}, {['err']=0,0,"","",0,""}, {['err']=0,0,"","",0,""}}
local info_BuyType	= 1
local info_itemName = 2
local info_itemDesc = 3
local info_itemPrice= 4
local info_FileName = 5

local RewardType_Coin		 = 0
local RewardType_SlotChanger = 1
local RewardType_Life		 = 2
local RewardType_Skill		 = 3
local RewardType_ExchangeSkill = 4
local RewardType_Item		 = 5
local RewardType_Orb		 = 6
local RewardType_Orb_Bundle	 = 7

--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
local AS_String_PurchaseConfirm		= PreCreateString_1007	--GetSStringInfo(LAN_LUA_ARCADESHOP_1)	-- 위 아이템을 정말 구입하시겠습니까? 
local AS_String_LifeGet				= PreCreateString_1008	--GetSStringInfo(LAN_LUA_ARCADESHOP_2)	-- 아케이드 라이프를 %d개 획득하였습니다 
local AS_String_SelectItem			= PreCreateString_1010  --GetSStringInfo(LAN_LUA_ARCADESHOP_4)	-- 아이템을 선택해주세요 
local AS_String_NotEnoughCoin		= PreCreateString_1011	--GetSStringInfo(LAN_LUA_ARCADESHOP_5)	-- 코인이 부족합니다. 
local AS_String_NotEnoughGran		= PreCreateString_1012	--GetSStringInfo(LAN_LUA_ARCADESHOP_6)	-- 그랑이 부족합니다.
local AS_String_GetGran				= PreCreateString_1013	--GetSStringInfo(LAN_LUA_ARCADESHOP_7)	-- 그랑을 획득하였습니다. 
local AS_String_TranslateItem		= PreCreateString_1014	--GetSStringInfo(LAN_LUA_ARCADESHOP_8)	-- 변신 아이템 
local AS_String_GetTranslateItem	= PreCreateString_1015	--GetSStringInfo(LAN_LUA_ARCADESHOP_9)	-- 변신아이템을 획득하였습니다
local AS_String_Coin				= PreCreateString_1523	--GetSStringInfo(LAN_CPP_VILLAGE_11)	-- 코인
local AS_String_Gran				= PreCreateString_1522	--GetSStringInfo(LAN_CPP_VILLAGE_10)	-- 그랑
local AS_String_AfterExchange		= PreCreateString_1009	--GetSStringInfo(LAN_LUA_ARCADESHOP_3)	-- 교환후
local AS_String_BeforeExchange		= PreCreateString_1815	--GetSStringInfo(LAN_LUA_ARCADESHOP_10)	-- 교환전
local AS_String_GetCoin				= PreCreateString_1817	--GetSStringInfo(LAN_LUA_ARCADESHOP_11)	-- %d 코인을 획득하였습니다.
local AS_String_GetSlotChanger		= PreCreateString_1818	--GetSStringInfo(LAN_LUA_ARCADESHOP_12)	-- 슬롯체인저 %d 개를 획득하였습니다.
local AS_String_GetLifeUp			= PreCreateString_1819	--GetSStringInfo(LAN_LUA_ARCADESHOP_13)	-- 아케이드 라이프 %d 개를 획득하였습니다.
local AS_String_SlotChanger			= PreCreateString_1809	--GetSStringInfo(LAN_LUA_WND_MYINFO_38)	-- 슬롯체인저
local AS_String_LifeUp				= PreCreateString_1808	--GetSStringInfo(LAN_LUA_WND_MYINFO_37)	-- 아케이드 라이프
local AS_String_GetSkill			= PreCreateString_1839	--GetSStringInfo(LAN_LUA_ARCADESHOP_14)	-- 체험스킬을 획득하셨습니다.

local Get_Upgrade_Item				= PreCreateString_2039	--GetSStringInfo(LAN_GET_UPGRADE_ITEM)	-- %s 강화아이템을 획득하셨습니다
local Get_Upgrade_Items				= PreCreateString_2223	--GetSStringInfo(LAN_GOT_UPGRADE_ITEM)	-- %s 강화아이템을 획득하셨습니다
local AS_String_CubeGet				= PreCreateString_2373	--GetSStringInfo(LAN_GET_COSTUME_CUBE)	-- 코스튬큐브를 %d개 획득하였습니다 

--------------------------------------------------------------------

--	아케이드 상점에 관련된 윈도우

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 아케이드 샵 바탕 이미지.
--------------------------------------------------------------------
AS_mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_BackImage")

AS_mainwindow:setTexture("Enabled", "UIData/option.tga", 335, 456)
AS_mainwindow:setTexture("Disabled", "UIData/option.tga", 335, 456)
AS_mainwindow:setProperty("FrameEnabled", "False")
AS_mainwindow:setProperty("BackgroundEnabled", "False")
AS_mainwindow:setPosition(464, 65)
AS_mainwindow:setSize(556, 470)
AS_mainwindow:setVisible(false)
AS_mainwindow:setAlwaysOnTop(false)
AS_mainwindow:setZOrderingEnabled(false)
root:addChildWindow(AS_mainwindow)

--RegistEscEventInfo("AS_BackImage", "CloseArcadeShop")
--RegistEnterEventInfo("AS_BackImage", "CMRewardOKButtonEvent")


--------------------------------------------------------------------
-- 아케이드 샵 라디오버튼(아이템이 들어가야할 윈도우). / EmptyButton
--------------------------------------------------------------------
local tRButtonPosX		= {['protecterr'] = 0, 6,	4+276,	6,		4+276,	6,			4+276 }
local tRButtonPosY		= {['protecterr'] = 0, 41,	41,		41+112, 41+112, 41+112*2,	41+112*2}

for i=1, ARCADELIST_MAXCOUNT do
	-- 아이템 정보들을 담을 투명한 뒷판
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', "AS_ItemInfoSaveImg"..i)
	mywindow:setTexture('Enabled', "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setSize(270, 110)
	mywindow:setPosition(tRButtonPosX[i], tRButtonPosY[i]);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false);
	mywindow:setEnabled(false)
	AS_mainwindow:addChildWindow(mywindow)
		
	
	-- 아이템 이미지를 보여준다
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', "AS_ItemImg"..i)
	mywindow:setTexture('Enabled', "UIData/ItemUIData/Item/Ranbox01.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
	mywindow:setSize(114, 97)
	if i == 2 or i == 6 then					-- 라이프 이미지
		mywindow:setPosition(3, 6);
		mywindow:setScaleHeight(250)
		mywindow:setScaleWidth(262)	
	else
		mywindow:setPosition(12, 2);
		mywindow:setScaleHeight(255)
		mywindow:setScaleWidth(255)
	end
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false);
	mywindow:setEnabled(false)
	winMgr:getWindow("AS_ItemInfoSaveImg"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수가 들어갈 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AS_ItemCountText"..i)
	mywindow:setPosition(0, 10)
	mywindow:setSize(102, 16)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("AS_ItemImg"..i):addChildWindow(mywindow)
	
	
	-- 아이템의 가격을 적어줄 뒷판
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', "AS_ItemPriceBack"..i)
	mywindow:setTexture('Enabled', "UIData/Itemshop001.tga", 280, 859)
	mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 280, 859)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setSize(116, 16)
	mywindow:setPosition(5, 86);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false);
	mywindow:setEnabled(false)
	winMgr:getWindow("AS_ItemInfoSaveImg"..i):addChildWindow(mywindow)
	
	-- 아이템 가격이 들어갈 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AS_ItemPriceText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 5)
	mywindow:setSize(116, 16)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("AS_ItemPriceBack"..i):addChildWindow(mywindow)
	

	-- 아이템 이름이 들어갈 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AS_ItemNameText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(128, 13)
	mywindow:setSize(130, 20)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("AS_ItemInfoSaveImg"..i):addChildWindow(mywindow)
	
	
	-- 아이템 설명이 들어갈 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AS_ItemDescText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(128, 37)
	mywindow:setSize(135, 70)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(1)
	winMgr:getWindow("AS_ItemInfoSaveImg"..i):addChildWindow(mywindow)
	
	
	-- 아케이드 샵 라디오버튼
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "AS_List"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)		
	mywindow:setTexture("Hover", "UIData/skillitem001.tga", 0, 24)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("SelectedNormal", "UIData/skillitem001.tga", 0, 24+110)
	mywindow:setTexture("SelectedHover", "UIData/skillitem001.tga", 0, 24+110)
	mywindow:setTexture("SelectedPushed", "UIData/skillitem001.tga", 0, 24+110)
	mywindow:setTexture("SelectedPushedOff", "UIData/skillitem001.tga", 0, 24+110)
	mywindow:setPosition(tRButtonPosX[i], tRButtonPosY[i]);
	mywindow:setSize(270, 110)
	mywindow:setProperty('GroupID', 10)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false);
	mywindow:subscribeEvent("SelectStateChanged", "AS_SelectItem")
	mywindow:subscribeEvent("MouseDoubleClicked", "AS_ExchangeButton")
--	mywindow:setSubscribeEvent('MouseLeave', 'OnCoinMouseLeave');
--	mywindow:setSubscribeEvent('MouseEnter', 'OnCoinMouseMove');
	AS_mainwindow:addChildWindow(mywindow)	
	
	-- EmptyImage 생성해준다.
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', "AS_EmptyImage"..i)
	mywindow:setTexture('Enabled', "UIData/ItemShop001.tga", 0, 765)
	mywindow:setTexture("Disabled", "UIData/ItemShop001.tga", 0, 765)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setSize(270, 110)
	mywindow:setPosition(tRButtonPosX[i], tRButtonPosY[i]);
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false);

	if i > ARCADE_CURRENT_LIST_COUNT then	-- 현재 보여줄 목록 갯수를 정해준다.
		mywindow:setVisible(true)
	else
		mywindow:setVisible(false)
	end
	AS_mainwindow:addChildWindow(mywindow)	
end	



----------------------------------------------------------------------------------
-- 페이지 좌, 우 버튼
----------------------------------------------------------------------------------
local tAS_PageButtonName = {['protecterr']=0, "AS_Left", "AS_Right" }
local tAS_PageButtonPosX = {['protecterr']=0, 220, 318 }
local tAS_PageButtonTexX = {['protecterr']=0, 987,	970}
local tAS_PageButtonEvent = {['protecterr']=0, "AS_LeftButtonClick", "AS_RightButtonClick" }

for i = 1, #tAS_PageButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAS_PageButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tAS_PageButtonTexX[i] , 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga",  tAS_PageButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga",  tAS_PageButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tAS_PageButtonTexX[i], 44)
	mywindow:setPosition(tAS_PageButtonPosX[i], 390)
	mywindow:setSize(17, 22)
	mywindow:subscribeEvent("Clicked", tAS_PageButtonEvent[i])
	AS_mainwindow:addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 페이지 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', "AS_PageText");
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(227, 392);
mywindow:setSize(101, 37);
mywindow:setZOrderingEnabled(true)	
mywindow:setEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
AS_mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 그랑 / 코인 텍스트 표시
--------------------------------------------------------------------
local tAS_PointAndGranName = {['protecterr']=0, "AS_CoinText", "AS_GranText" }
local tAS_PointAndGranPosX = {['protecterr']=0,		70,  260}


for i = 1, #tAS_PointAndGranName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tAS_PointAndGranName[i]);
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tAS_PointAndGranPosX[i], 438);
	mywindow:setSize(80, 20);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	AS_mainwindow:addChildWindow(mywindow)
end




--------------------------------------------------------------------
-- 교환하기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "AS_PurchaseButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 692, 485)
mywindow:setTexture("Hover", "UIData/popup001.tga", 692, 519)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 692, 553)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 692, 485)
mywindow:setPosition(440, 429)
mywindow:setSize(83, 34)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "AS_ExchangeButton")
AS_mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 알파 뒷판 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_PopupBackAlphaImg")
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


--------------------------------------------------------------------
-- 뒷판이미지 위에 붙는 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_RandumBackWindow")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition((1024 - 339) / 2, (768 - 267) / 2)
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("AS_RandumBackWindow", "PopupWindowCancelEvent")
RegistEnterEventInfo("AS_RandumBackWindow", "PopupWindowOKEvent")

--------------------------------------------------------------------
-- 타이틀 윈도우 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_ExchangeTitleImg")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 322)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 322)	-- 0, 363 -->축하합니다
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(339, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 교환하기 팝업에 들어가는 선물상자 정보들 담아줄 이미지
--------------------------------------------------------------------
AS_ExchangePresentInfoBack = winMgr:createWindow("TaharezLook/StaticImage", "AS_ExchangePresentInfoBack")
AS_ExchangePresentInfoBack:setTexture("Enabled", "UIData/invisible.tga", 0, 635)
AS_ExchangePresentInfoBack:setTexture("Disabled", "UIData/invisible.tga", 0, 635)
AS_ExchangePresentInfoBack:setProperty("FrameEnabled", "False")
AS_ExchangePresentInfoBack:setProperty("BackgroundEnabled", "False")
AS_ExchangePresentInfoBack:setPosition(5, 41)
AS_ExchangePresentInfoBack:setSize(330, 178)
AS_ExchangePresentInfoBack:setVisible(true)
AS_ExchangePresentInfoBack:setAlwaysOnTop(false)
AS_ExchangePresentInfoBack:setZOrderingEnabled(false)
winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(AS_ExchangePresentInfoBack)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_ExchangevisibleBack")
mywindow:setTexture("Enabled", "UIData/option.tga", 0, 635)
mywindow:setTexture("Disabled", "UIData/option.tga", 0, 635)
mywindow:setPosition(0, 0)
mywindow:setSize(330, 178)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
AS_ExchangePresentInfoBack:addChildWindow(mywindow)

-- 아이템 이미지를 보여준다
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "AS_ExchangePresentImg")
mywindow:setTexture('Enabled', "UIData/ItemUIData/Item/Ranbox01.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setSize(100, 100)
mywindow:setPosition(20, 17);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false);
winMgr:getWindow("AS_ExchangevisibleBack"):addChildWindow(mywindow)


-- 아이템 갯수가 들어갈 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "AS_ExchangeItemCountText")
mywindow:setPosition(0, 2)
mywindow:setSize(102, 16)
mywindow:setViewTextMode(1)
mywindow:setAlign(6)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("AS_ExchangePresentImg"):addChildWindow(mywindow)
	
	

--------------------------------------------------------------------
-- 교환하기 팝업에 들어가는 아이템 텍스트
--------------------------------------------------------------------
local tAS_PopExchangeTextName = {['protecterr']=0, "AS_ExchangeNameText", "AS_ExchangeDescText", "AS_CurrentStringText", "AS_AfterStringText", "AS_CurrentCoinText", "AS_AfterCoinText" }
local tAS_PopExchangeTextPosX = {['protecterr']=0,	140,	140,	15,		15,		150, 150}
local tAS_PopExchangeTextPosY = {['protecterr']=0,	13,		37,		133,	158,	133, 158}
local tAS_PopExchangeTextSizeX = {['protecterr']=0,	170,	170,	170,	170,	95, 95}
local tAS_PopExchangeTextSizeY = {['protecterr']=0,	20,		80,		20,		20,		20,	20}

for i = 1, #tAS_PopExchangeTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tAS_PopExchangeTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tAS_PopExchangeTextPosX[i], tAS_PopExchangeTextPosY[i])
	mywindow:setSize(tAS_PopExchangeTextSizeX[i], tAS_PopExchangeTextSizeY[i])
	mywindow:setZOrderingEnabled(true)
	mywindow:setViewTextMode(1)
	if i == 1 then
		mywindow:setAlign(8)
	else
		mywindow:setAlign(1)
	end
	mywindow:setLineSpacing(2)
	winMgr:getWindow("AS_ExchangevisibleBack"):addChildWindow(mywindow)

end


--------------------------------------------------------------------
-- 교환하기 팝업 확인 취소 버튼
--------------------------------------------------------------------
tAS_PopButtonName	= {['protecterr']=0, "AS_ExchangeOkBtn", "AS_ExchangeCancelBtn"}
tAS_PopButtonTexX	= {['protecterr']=0,			693,			858}
tAS_PopButtonPosX	= {['protecterr']=0,			4,				169}
tAS_PopButtonEvent	= {['protecterr']=0, "AS_ExchangeOkBtnEvent", "AS_ExchangeCancelBtnEvent"}

for i = 1, #tAS_PopButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAS_PopButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tAS_PopButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tAS_PopButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tAS_PopButtonTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tAS_PopButtonTexX[i], 849)
	mywindow:setPosition(tAS_PopButtonPosX[i], 234)
	mywindow:setSize(166, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tAS_PopButtonEvent[i])
	winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/Button", "AS_ExchangeLastOkBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setSize(331, 29)
mywindow:setPosition(4, 234)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "AS_ExchangeLastOkBtnEvent")
winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(mywindow)




--------------------------------------------------------------------
-- 보상으로 받은 아이템 정보를 담을 바탕 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_ReceiveItemInfoImg0")
mywindow:setTexture("Enabled", "UIData/option.tga", 0, 635)
mywindow:setTexture("Disabled", "UIData/option.tga", 0, 635)
mywindow:setPosition(4, 54)
mywindow:setSize(330, 123)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlign(8);
mywindow:subscribeEvent("EndRender", "RandomboxRender");
winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(mywindow)


-- 보상 아이템을 덮어쓰는 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_ReceiveItemInfoImg1")
mywindow:setTexture("Enabled", "UIData/other001.tga", 0, 901)
mywindow:setTexture("Disabled", "UIData/other001.tga", 0, 901)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(9, 54)
mywindow:setSize(321, 123)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlign(8);
mywindow:subscribeEvent("MotionEventEnd", "PresentEventMotionEnd");
winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(mywindow)






----------------------------------------------------------------------------------
-- 라이프 관련 팝업 윈도우들


----------------------------------------------------------------------------------
-- 아케이드 라이프 구매 기본 이미지
----------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifePopupMainImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 684, 666)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 684, 666)
mywindow:setPosition(342, 205)
mywindow:setSize(340, 358)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifePopupMainImgBack")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 684, 666)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 684, 666)
mywindow:setPosition(0, 0)
mywindow:setSize(340, 358)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifePopupMainImgBack2")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 684, 989)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 684, 989)
mywindow:setPosition(0, 260)
mywindow:setSize(340, 35)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifeResultImage")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 359, 912)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 359, 912)
mywindow:setPosition(9, 195)
mywindow:setSize(325, 112)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)



RegistEscEventInfo("AS_LifePopupMainImg", "AS_LifePopupCancelBtnEvent")
RegistEnterEventInfo("AS_LifePopupMainImg", "AS_LifePopupOKBtnEvent")


--------------------------------------------------------------------
-- 아케이드 라이프 구매 확인 취소 버튼
--------------------------------------------------------------------
tAS_LifePopButtonName	= {['protecterr']=0, "AS_LifePopupOK", "AS_LifePopupCancel"}
tAS_LifePopButtonTexX	= {['protecterr']=0,			693,			858}
tAS_LifePopButtonPosX	= {['protecterr']=0,			4,				169}
tAS_LifePopButtonEvent	= {['protecterr']=0, "AS_LifePopupOKBtnEvent", "AS_LifePopupCancelBtnEvent"}

for i = 1, #tAS_LifePopButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAS_LifePopButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tAS_LifePopButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga",  tAS_LifePopButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga",  tAS_LifePopButtonTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tAS_LifePopButtonTexX[i], 849)
	mywindow:setPosition(tAS_LifePopButtonPosX[i], 322)
	mywindow:setSize(166, 29)
	mywindow:subscribeEvent("Clicked", tAS_LifePopButtonEvent[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 아케이드 라이프 팝업에 들어가는 라이프 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifeImg")
mywindow:setTexture("Enabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
mywindow:setPosition(18, 51)
mywindow:setSize(114, 97)
mywindow:setScaleHeight(290)
mywindow:setScaleWidth(260)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 아케이드 라이프 수량 카운트 시켜주는 버튼
--------------------------------------------------------------------
tLifeCountButtonName	= {['protecterr']=0, "AS_LeftfCountButton", "AS_RightCountButton" }
tLifeCountButtonPosX	= {['protecterr']=0,		253,				299}
tLifeCountButtonTexX	= {['protecterr']=0,		0,					15}
tLifeCountButtonEvent	= {['protecterr']=0, "AS_LeftCountButtonEvent",	"AS_RightCountButtonEvent"}

for i = 1, #tLifeCountButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLifeCountButtonName[i])
	mywindow:setTexture("Normal", "UIData/ranking.tga", tLifeCountButtonTexX[i], 911)
	mywindow:setTexture("Hover", "UIData/ranking.tga",  tLifeCountButtonTexX[i], 926)
	mywindow:setTexture("Pushed", "UIData/ranking.tga",  tLifeCountButtonTexX[i], 941)
	mywindow:setTexture("PushedOff", "UIData/ranking.tga", tLifeCountButtonTexX[i], 941)
	mywindow:setPosition(tLifeCountButtonPosX[i], 142)
	mywindow:setSize(15,15)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLifeCountButtonEvent[i])
	winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)
end

-- 에디트박스같이 보이는 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_EditImage")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 995, 647)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 995, 647)
mywindow:setPosition(269, 140)
mywindow:setSize(29, 19)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)


tLifePopupTextName	= {['protecterr']=0, "AS_LifeNameText", "AS_LifeDescText", "AS_LifeCountPriceText",
								"AS_LifeBeforeGranText", "AS_BeforeLifeCountText", "AS_LifeAfterGranText", "AS_AfterLifeCountText"}
tLifePopupTextPosX	= {['protecterr']=0, 143,	147,	210,	180,	180,	180,	180,	180}
tLifePopupTextPosY	= {['protecterr']=0, 59,	86,		173,	204,	230,	260,	287,	312}
tLifePopupTextSizeX	= {['protecterr']=0, 179,	171,	100,	90,		90,		90,		90,		90}
tLifePopupTextSizeY	= {['protecterr']=0, 23,	72,		19,		20,		20,		20,		20,		20}

for i = 1, #tLifePopupTextName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tLifePopupTextName[i]);
	mywindow:setPosition(tLifePopupTextPosX[i], tLifePopupTextPosY[i]);
	mywindow:setSize(tLifePopupTextSizeX[i], tLifePopupTextSizeY[i]);
	if i == 2 then
		mywindow:setEnabled(false)
	elseif i == 3 then
		mywindow:setSubscribeEvent("EndRender", "LifePriceCheck")
	end
	mywindow:setViewTextMode(1)
	if i > 2 then
		mywindow:setAlign(6)
	else
		mywindow:setAlign(1)
	end
	
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow)
end


-- 아케이드 라이프 카운트를 적는 에디트박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "AS_LifeCountEditbox")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setPosition(271, 140)
mywindow:setSize(29, 19)
mywindow:setAlign(8)
mywindow:setAlphaWithChild(0)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(2)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
winMgr:getWindow("AS_LifePopupMainImg"):addChildWindow(mywindow);



function LifePriceCheck(args)
	local CountText = winMgr:getWindow("AS_LifeCountEditbox"):getText()
	local Check = CheckNumber(LifeCount)
	if Check == false then
		winMgr:getWindow("AS_LifeCountEditbox"):setText("0")
		CountText = 0
	end
	
	local Count	= 0
	if CountText == "" or CountText == 0 then
		Count = 0
	else
		Count = tonumber(CountText)
	end
	
	local Price = 0

	if Count > 0 then
		Price = Count * tLifePurchaseInfo[2]		
	end
	LifeCount = Count
	tLifePurchaseInfo[1] = LifeCount
	
	
	winMgr:getWindow("AS_LifeCountPriceText"):clearTextExtends()
	local r,g,b = GetGranColor(Price)
	local String		= CommatoMoneyStr(tostring(Price))
	winMgr:getWindow("AS_LifeCountPriceText"):addTextExtends(String, g_STRING_FONT_GULIM,12, r,g,b,255, 1, 0,0,0,255);
	winMgr:getWindow("AS_LifeCountPriceText"):addTextExtends("  "..AS_String_Gran, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);
		
	-- 구매후 그랑 텍스트
	winMgr:getWindow("AS_LifeAfterGranText"):clearTextExtends()
	String		= CommatoMoneyStr(tostring(tLifePurchaseInfo[3] - (tLifePurchaseInfo[2] * tLifePurchaseInfo[1])))
	winMgr:getWindow("AS_LifeAfterGranText"):addTextExtends(String, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);

	-- 구매후 라이프수 텍스트
	winMgr:getWindow("AS_AfterLifeCountText"):clearTextExtends()
	String		= CommatoMoneyStr(tostring(tLifePurchaseInfo[4] + tLifePurchaseInfo[1]))
	winMgr:getWindow("AS_AfterLifeCountText"):addTextExtends(String, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);
	
end

--------------------------------------------------------------------
-- 아케이드 라이프 구입하기확인창 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'AS_LifePopupConfirmImg');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disnabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("AS_LifePopupConfirmImg", "AS_LifePopupConfirmCancelEvent")
RegistEnterEventInfo("AS_LifePopupConfirmImg", "AS_LifePopupConfirmOKEvent")

--------------------------------------------------------------------
-- 아케이드 라이프 구입하기 제목 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'AS_LifePopupConfirmTitleImg');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 855);
mywindow:setTexture('Disnabled', 'UIData/popup001.tga', 0, 855);
mywindow:setPosition(0, 0);
mywindow:setSize(340, 41);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('AS_LifePopupConfirmImg'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 아케이드 라이프 구입하기 아이템 정보뿌려주는 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifePopupConfirmItemInfoImg")
mywindow:setTexture("Enabled", "UIData/option.tga", 0, 636)
mywindow:setTexture("Disabled", "UIData/option.tga", 0, 636)
mywindow:setPosition(4, 54)
mywindow:setSize(330, 123)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('AS_LifePopupConfirmImg'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 아케이드 라이프 팝업에 들어가는 라이프 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AS_LifeConfirmImg")
mywindow:setTexture("Enabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
mywindow:setPosition(14, 6)
mywindow:setSize(114, 97)
mywindow:setScaleHeight(290)
mywindow:setScaleWidth(260)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setEnabled(false)
winMgr:getWindow("AS_LifePopupConfirmItemInfoImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 아케이드 라이프 팝업에 들어가는 라이프 이름 / 설명 덱스트
--------------------------------------------------------------------
tLifeConfirmPopupTextName	= {['protecterr']=0, "AS_LifeConfirmNameText", "AS_LifeConfirmDescText"}
tLifeConfirmPopupTextPosY	= {['protecterr']=0, 14,	41}
tLifeConfirmPopupTextSizeY	= {['protecterr']=0, 20,	72}

for i = 1, #tLifeConfirmPopupTextName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tLifeConfirmPopupTextName[i]);
	mywindow:setPosition(143, tLifeConfirmPopupTextPosY[i]);
	mywindow:setSize(177, tLifeConfirmPopupTextSizeY[i]);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("AS_LifePopupConfirmItemInfoImg"):addChildWindow(mywindow)
end



--------------------------------------------------------------------
-- 아케이드 라이프 구입하기 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', "AS_LifePopupConfirmOKString");
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(0, 195);
mywindow:setSize(340, 20);
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow('AS_LifePopupConfirmImg'):addChildWindow( mywindow );

winMgr:getWindow("AS_LifePopupConfirmOKString"):clearTextExtends()
winMgr:getWindow("AS_LifePopupConfirmOKString"):addTextExtends(AS_String_PurchaseConfirm, g_STRING_FONT_GULIMCHE,12, 255,205,86,255, 1, 0,0,0,255);


--------------------------------------------------------------------
-- 버튼 (확인, 취소)
--------------------------------------------------------------------
local tLifeConfirmButtonName	= {['protecterr']=0, "AS_LifePopupConfirmOK", "AS_LifePopupConfirmCancel"}
local tLifeConfirmButtonTexX	= {['protecterr']=0,		693,		858}
local tLifeConfirmButtonPosX	= {['protecterr']=0,		4,			169}
local tLifeConfirmButtonEvent	= {['protecterr']=0, "AS_LifePopupConfirmOKEvent", "AS_LifePopupConfirmCancelEvent"}

for i=1, #tLifeConfirmButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLifeConfirmButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tLifeConfirmButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tLifeConfirmButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tLifeConfirmButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", tLifeConfirmButtonTexX[i], 849)
	mywindow:setPosition(tLifeConfirmButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", tLifeConfirmButtonEvent[i])
	winMgr:getWindow('AS_LifePopupConfirmImg'):addChildWindow(mywindow)
end





--------------------------------------------------------------------

--	아케이드 상점에 관련된 함수들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 아케이드 상점에있는 목록들의 정보를 알아온다.
--------------------------------------------------------------------
--[[
function ArcadeShopItemSetting()
	local tItemList	= {['protecterr'] = 0, 350001, 350002, 350003, 350004, 350005, 350006 }
	
	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		ArcadeShopSettingToC(tItemList[i])
	end
end
--]]
--------------------------------------------------------------------
-- 아케이드 샵을 초기화 해준다
--------------------------------------------------------------------
function ArcadeShopSetting(Index, Name, Description, BuySystem, PricePoint, ItemFileName)
	
	tArcadeShopInfo[Index][info_BuyType]	= BuySystem
	tArcadeShopInfo[Index][info_itemName]	= Name
	tArcadeShopInfo[Index][info_itemDesc]	= Description
	tArcadeShopInfo[Index][info_itemPrice]  = PricePoint
	tArcadeShopInfo[Index][info_FileName]	= ItemFileName
	
end
--------------------------------------------------------------------
-- 아케이드 샵내용을 보여준다(Open해줄때)
--------------------------------------------------------------------
function SetUpArcadeShop()
	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		local BuySystem		= tArcadeShopInfo[i][info_BuyType]	
		local PricePoint	= tArcadeShopInfo[i][info_itemPrice]	
		local Name			= tArcadeShopInfo[i][info_itemName]	
		local Description	= tArcadeShopInfo[i][info_itemDesc]  
		local ItemFileName	= tArcadeShopInfo[i][info_FileName]	
		local BuySystemName	= ""
		
		if BuySystem == 1 then		-- 코인
			BuySystemName = AS_String_Coin
		elseif BuySystem == 2 then	-- 그랑
			BuySystemName = AS_String_Gran
		elseif BuySystem == 3 then	-- 캐쉬
			BuySystemName = "Cash"
		end
		local PricePointStr	= CommatoMoneyStr(tostring(PricePoint))
		
		local MyCoin	= CommatoMoneyStr(tostring(GetMyDungeonCoin()))
		local MyGran	= CommatoMoneyStr(tostring(GetMyMoney()))
		
		local r1,g1,b1		= GetGranColor(GetMyDungeonCoin())
		local r2,g2,b2		= GetGranColor(GetMyMoney())
		
		-- 이미지 설정 
		winMgr:getWindow("AS_ItemImg"..i):setTexture('Enabled', ItemFileName, 0, 0)
		winMgr:getWindow("AS_ItemImg"..i):setTexture('Disabled', ItemFileName, 0, 0)
		
		winMgr:getWindow("AS_ItemCountText"..i):clearTextExtends()
		if i == 5 then	-- 10개짜리
			winMgr:getWindow("AS_ItemCountText"..i):addTextExtends("x10", g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 0,0,0,255);
		end
		-- 가격 설정
		winMgr:getWindow("AS_ItemPriceText"..i):clearTextExtends()
		winMgr:getWindow("AS_ItemPriceText"..i):addTextExtends(PricePointStr.." "..BuySystemName, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);
		-- 이름 설정
		winMgr:getWindow("AS_ItemNameText"..i):clearTextExtends()
		winMgr:getWindow("AS_ItemNameText"..i):addTextExtends(Name, g_STRING_FONT_GULIMCHE,12, 255,205,86,255, 1, 30,30,30,255);
		-- 아이템 설명 설정
		Description = AdjustString(g_STRING_FONT_DODUMCHE, 112, Description, 120)
		winMgr:getWindow("AS_ItemDescText"..i):clearTextExtends()
		winMgr:getWindow("AS_ItemDescText"..i):addTextExtends(Description, g_STRING_FONT_DODUMCHE,112, 255, 255, 255,255, 0, 0,0,0,255);
		
		-- 페이지 텍스트 일단 1/1로 해놓는다.나중에 목록 많아지면 목록별로 하도록 바꿔줘야함
		winMgr:getWindow("AS_PageText"):clearTextExtends()
		winMgr:getWindow("AS_PageText"):addTextExtends("1  /  1", g_STRING_FONT_GULIMCHE, 16, 255,255,255,255, 0, 0,0,0,255);
		
		
		winMgr:getWindow("AS_CoinText"):clearTextExtends()
		local StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyCoin)
		winMgr:getWindow("AS_CoinText"):setPosition(150 - StringSize, 438)
		winMgr:getWindow("AS_CoinText"):addTextExtends(MyCoin, g_STRING_FONT_GULIMCHE, 14, r1,g1,b1,255, 0, 0,0,0,255);
	
		
		winMgr:getWindow("AS_GranText"):clearTextExtends()
		StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyGran)
		winMgr:getWindow("AS_GranText"):setPosition(340 - StringSize, 438)
		winMgr:getWindow("AS_GranText"):addTextExtends(MyGran, g_STRING_FONT_GULIMCHE, 14, r2,g2,b2,255, 0, 0,0,0,255);

	end
end

--Gameloft사의 Gangster : West Coast Hustle(GTA!)

--------------------------------------------------------------------
-- 아케이드 샵에서 선택된 이벤트 발생
--------------------------------------------------------------------
function AS_SelectItem(args)
	


end



function AS_LeftButtonClick()

end


function AS_RightButtonClick()

end


--------------------------------------------------------------------
-- 교환하기 버튼이 눌렸다
--------------------------------------------------------------------
function AS_ExchangeButton(args)
	local	bSelectItem = false
	local	MyWindow	= ""
	local	Index		= 0
	
	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		if CEGUI.toRadioButton(winMgr:getWindow("AS_List"..i)):isSelected() == true then	-- Select 안될때도 호출 되기 때문에 해야 한다.
			bSelectItem = true
			Index		= i
			local BuySystem		= tArcadeShopInfo[Index][info_BuyType]
			local PricePoint	= tArcadeShopInfo[Index][info_itemPrice]
			local MyCoin		= GetMyDungeonCoin()
			local MyGran		= GetMyMoney()
			if BuySystem == 1 then		-- 코인
				if MyCoin - PricePoint < 0  then
					ShowNotifyOKMessage_Lua(AS_String_NotEnoughCoin)
					return
				end
			elseif BuySystem == 2 then	-- 그랑ㄴ
				if MyGran - PricePoint < 0  then
					ShowNotifyOKMessage_Lua(AS_String_NotEnoughGran)
					return
				end
			end
			break
		end
	end
	if bSelectItem == false then
		ShowNotifyOKMessage_Lua(AS_String_SelectItem)
		return;
	end
	root:addChildWindow(winMgr:getWindow("AS_PopupBackAlphaImg"))
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(true)
	
	KindofExchange(Index)		-- 상점 목록중 눌린 인덱스의 품목에 대한 정보를 띄워준다
end


--------------------------------------------------------------------
-- 아이템의 종류에 따라 다른 팝업창을 띄워주기위해서 만들어준 함수
--------------------------------------------------------------------
function KindofExchange(Index)
	if Index == 1 or Index == 3 or Index == 4 or Index == 5 then
		-- 교환하기 뒷배경 원래 이미지로 되돌려줌
		winMgr:getWindow("AS_ExchangePresentInfoBack"):setTexture("Enabled", "UIData/option.tga", 0, 635)
		winMgr:getWindow("AS_ExchangePresentInfoBack"):setTexture("Disabled", "UIData/option.tga", 0, 635)
		winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
		winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(true)
		winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Enabled", "UIData/popup001.tga", 0, 322)	-- 교환하기
		winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Disabled", "UIData/popup001.tga", 0, 322)	-- 0, 363 -->축하합니다
		winMgr:getWindow("AS_ExchangevisibleBack"):setVisible(true)
		winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(false)		-- 마지막 확인버튼 안보이게 해준다.
		winMgr:getWindow("AS_ExchangeOkBtn"):setVisible(true)			-- 버튼은 안보이게 감춘다.
		winMgr:getWindow("AS_ExchangeCancelBtn"):setVisible(true)
		
		for i = 0, 1 do
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearControllerEvent("PresentEvent");
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearActiveController()
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):setVisible(false)		-- 컨트롤 달린 이미지 없애줌
			
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "xscale", "Quintic_EaseIn", 30, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "yscale", "Quintic_EaseIn", 70, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54 , -253, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", -253, 54, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 15, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 15, 54, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 45, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 45, 54, 1, true, false, 10);
			if i == 1 then
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 255, 8, true, false, 10);
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 0, 12, true, false, 10);
			end
		end

		local BuySystem		= tArcadeShopInfo[Index][info_BuyType]	
		local PricePoint	= tArcadeShopInfo[Index][info_itemPrice]	
		local Name			= tArcadeShopInfo[Index][info_itemName]
		local Description	= tArcadeShopInfo[Index][info_itemDesc]  
		local ItemFileName	= tArcadeShopInfo[Index][info_FileName]
		
		-- 교환하기창의 아이템 이미지
		winMgr:getWindow("AS_ExchangePresentImg"):setTexture("Enabled", ItemFileName, 0, 0)
		winMgr:getWindow("AS_ExchangePresentImg"):setTexture("Disabled", ItemFileName, 0, 0)
		
		winMgr:getWindow("AS_ExchangeItemCountText"):clearTextExtends()
		if Index == 5 then	-- 10개짜리
			winMgr:getWindow("AS_ExchangeItemCountText"):addTextExtends("x10", g_STRING_FONT_GULIM,13, 255,255,255,255, 0, 0,0,0,255);
		end
		
		
		-- 아이템 이름
		winMgr:getWindow("AS_ExchangeNameText"):clearTextExtends()
		winMgr:getWindow("AS_ExchangeNameText"):setAlign(8)
		winMgr:getWindow("AS_ExchangeNameText"):addTextExtends(Name, g_STRING_FONT_GULIM,12, 102,204,102,255, 1, 0,0,0,255);
		-- 아이템 설명
		
		
		winMgr:getWindow("AS_ExchangeDescText"):clearTextExtends()
		Description = AdjustString(g_STRING_FONT_DODUMCHE, 112, Description, 160)
		winMgr:getWindow("AS_ExchangeDescText"):addTextExtends(Description, g_STRING_FONT_GULIM,112, 255,255,255,255, 0, 0,0,0,255);
		
		
		winMgr:getWindow("AS_CurrentStringText"):clearTextExtends()
		winMgr:getWindow("AS_AfterStringText"):clearTextExtends()
		
		local TextName				= ""
		local PricePointStr			= ""
		local AfterPricePointStr	= ""
		
		local r1, g1, b1 = 0
		local r2, g2, b2 = 0
		if Index == 1 then
			TextName			= AS_String_Coin
			PricePointStr		= CommatoMoneyStr(tostring(GetMyDungeonCoin()))
			AfterPricePointStr	= CommatoMoneyStr(tostring(GetMyDungeonCoin() - PricePoint))
			
			r1, g1, b1 = GetGranColor(GetMyDungeonCoin())
			r2, g2, b2 = GetGranColor(GetMyDungeonCoin() - PricePoint)
			
		elseif Index == 3 or Index == 4 or Index == 5 then
			TextName			= AS_String_Gran
			PricePointStr		= CommatoMoneyStr(tostring(GetMyMoney()))
			AfterPricePointStr	= CommatoMoneyStr(tostring(GetMyMoney() - PricePoint))
			
			r1, g1, b1 = GetGranColor(GetMyMoney())
			r2, g2, b2 = GetGranColor(GetMyMoney() - PricePoint)
		end
		winMgr:getWindow("AS_CurrentStringText"):addTextExtends(AS_String_BeforeExchange.." "..TextName, g_STRING_FONT_GULIM,12, 255,255,255,255, 1, 0,0,0,255);
		winMgr:getWindow("AS_AfterStringText"):addTextExtends(AS_String_AfterExchange.." "..TextName, g_STRING_FONT_GULIM,12, 255,255,255,255, 1, 0,0,0,255);
		
		-- 교환전 그랑(현재 보유하고 있는 코인)
		winMgr:getWindow("AS_CurrentCoinText"):clearTextExtends()
		local size		= GetStringSize(g_STRING_FONT_GULIM, 12, PricePointStr)
		winMgr:getWindow("AS_CurrentCoinText"):setPosition(250 - size, 133)
		winMgr:getWindow("AS_CurrentCoinText"):addTextExtends(PricePointStr, g_STRING_FONT_GULIM,12, r1,g1,b1,255, 1, 0,0,0,255);
		winMgr:getWindow("AS_CurrentCoinText"):addTextExtends("  "..TextName, g_STRING_FONT_GULIM,12, 255,255,255,255, 1, 0,0,0,255);

		
		-- 교환후 그랑(현재 보유하고 있는 코인)
		winMgr:getWindow("AS_AfterCoinText"):clearTextExtends()
		size = GetStringSize(g_STRING_FONT_GULIM, 12, AfterPricePointStr)
		winMgr:getWindow("AS_AfterCoinText"):setPosition(250 - size, 158)
		winMgr:getWindow("AS_AfterCoinText"):addTextExtends(AfterPricePointStr, g_STRING_FONT_GULIM,12, r2,g2,b2,255, 1, 0,0,0,255);
		winMgr:getWindow("AS_AfterCoinText"):addTextExtends("  "..TextName, g_STRING_FONT_GULIM,12, 255,255,255,255, 1, 0,0,0,255);

	elseif Index == 2 or Index == 6 then		-- 라이프 구입 팝업
		PurchaseEtc(Index)
		winMgr:getWindow("AS_LifePopupMainImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("AS_LifePopupMainImg"))
		
		local PricePoint	= tArcadeShopInfo[Index][info_itemPrice]	
		local Name			= tArcadeShopInfo[Index][info_itemName]
		local Description	= tArcadeShopInfo[Index][info_itemDesc]  
		local MyMoney		= GetMyMoney()
		local MyLife		= GetMyLife()
		LifeCount	= 1
		
		winMgr:getWindow("AS_LifeCountEditbox"):setText(tostring(LifeCount))
		winMgr:getWindow("AS_LifeCountEditbox"):activate()
		
		tLifePurchaseInfo[1] = LifeCount
		tLifePurchaseInfo[2] = PricePoint
		tLifePurchaseInfo[3] = MyMoney
		tLifePurchaseInfo[4] = MyLife
		
		-- 아이템 이름
		winMgr:getWindow("AS_LifeNameText"):clearTextExtends()
		winMgr:getWindow("AS_LifeNameText"):setAlign(8)
		winMgr:getWindow("AS_LifeNameText"):addTextExtends(Name, g_STRING_FONT_GULIM,12, 102,204,102,255, 1, 0,0,0,255);
		
		-- 아이템 설명
		winMgr:getWindow("AS_LifeDescText"):clearTextExtends()
		Description = AdjustString(g_STRING_FONT_DODUMCHE, 112, Description, 160)
		winMgr:getWindow("AS_LifeDescText"):addTextExtends(Description, g_STRING_FONT_GULIM,112, 255,255,255,255, 0, 0,0,0,255);
		
		-- 아이템 수량에 따른 가격
		winMgr:getWindow("AS_LifeCountPriceText"):clearTextExtends()
		local r,g,b = GetGranColor(PricePoint * LifeCount)
		local String		= CommatoMoneyStr(tostring(PricePoint * LifeCount))
		winMgr:getWindow("AS_LifeCountPriceText"):addTextExtends(tostring(String), g_STRING_FONT_GULIM,12, r,g,b,255, 1, 0,0,0,255);
		winMgr:getWindow("AS_LifeCountPriceText"):addTextExtends("  "..AS_String_Gran, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);
		--198,	232,	258,	287,	312}
		-- 현재 보유그랑
		winMgr:getWindow("AS_LifeBeforeGranText"):clearTextExtends()
		local r1,g1,b1 = GetGranColor(MyMoney)
		String		= CommatoMoneyStr(tostring(MyMoney))
		winMgr:getWindow("AS_LifeBeforeGranText"):addTextExtends(String, g_STRING_FONT_GULIM,12, r1,g1,b1,255, 1, 0,0,0,255);
		
		-- 현재 보유 라이프 수
		winMgr:getWindow("AS_BeforeLifeCountText"):clearTextExtends()
		String		= CommatoMoneyStr(tostring(MyLife))
		winMgr:getWindow("AS_BeforeLifeCountText"):addTextExtends(String, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);
		
		-- 구입후 보유 그랑
		winMgr:getWindow("AS_LifeAfterGranText"):clearTextExtends()
		local r2,g2,b2 = GetGranColor(MyMoney - (PricePoint * LifeCount))
		String		= CommatoMoneyStr(tostring(MyMoney - (PricePoint * LifeCount)))
		winMgr:getWindow("AS_LifeAfterGranText"):addTextExtends(String, g_STRING_FONT_GULIM,12, r2,g2,b2,255, 1, 0,0,0,255);
		
		-- 구입후 보유 라이프 수
		winMgr:getWindow("AS_AfterLifeCountText"):clearTextExtends()
		String		= CommatoMoneyStr(tostring(MyLife + LifeCount))
		winMgr:getWindow("AS_AfterLifeCountText"):addTextExtends(String, g_STRING_FONT_GULIM,12, 255,198,30,255, 1, 0,0,0,255);

	end
end

function PurchaseEtc(index)
	if index == 2 then
		winMgr:getWindow("AS_LifeResultImage"):setTexture("Disabled", "UIData/ranking.tga", 359, 912)
		winMgr:getWindow("AS_LifeResultImage"):setSize(325, 112)
		winMgr:getWindow("AS_BeforeLifeCountText"):setVisible(true)	-- 현재 보유 라이프 수
		winMgr:getWindow("AS_AfterLifeCountText"):setVisible(true)	-- 구입후 보유 라이프 수
		winMgr:getWindow("AS_LifeAfterGranText"):setPosition(180, 260)
		winMgr:getWindow("AS_LifePopupMainImgBack"):setSize(340, 358)
		winMgr:getWindow("AS_LifePopupMainImgBack2"):setVisible(false)
		for i = 1, #tAS_LifePopButtonName do
			winMgr:getWindow(tAS_LifePopButtonName[i]):setPosition(tAS_LifePopButtonPosX[i], 322)
		end
		winMgr:getWindow("AS_LifeImg"):setTexture("Disabled", "UIData/ItemUIData/Item/lifeup.tga", 0, 0)
		
	elseif index == 6 then
		winMgr:getWindow("AS_LifeResultImage"):setTexture("Disabled", "UIData/ranking.tga", 359, 856)
		winMgr:getWindow("AS_LifeResultImage"):setSize(325, 56)
		winMgr:getWindow("AS_BeforeLifeCountText"):setVisible(false)
		winMgr:getWindow("AS_AfterLifeCountText"):setVisible(false)	-- 구입후 보유 라이프 수
		winMgr:getWindow("AS_LifeAfterGranText"):setPosition(180, 231)
		winMgr:getWindow("AS_LifePopupMainImgBack"):setSize(340, 260)
		winMgr:getWindow("AS_LifePopupMainImgBack2"):setVisible(true)
		for i = 1, #tAS_LifePopButtonName do
			winMgr:getWindow(tAS_LifePopButtonName[i]):setPosition(tAS_LifePopButtonPosX[i], 261)
		end
		winMgr:getWindow("AS_LifeImg"):setTexture("Disabled", "UIData/ItemUIData/Item/CASH_Cube.tga", 0, 0)
	end
end



--------------------------------------------------------------------
-- 왼쪽 카운트 버튼 이벤트
--------------------------------------------------------------------
function AS_LeftCountButtonEvent(args)
	if LifeCount == 1 then
		LifeCount = 1
		winMgr:getWindow("AS_LifeCountEditbox"):setText(tostring(LifeCount))
	else
		local Check = CheckNumber(LifeCount)
		if Check == false then
			return
		end
		
		local PricePoint	= tArcadeShopInfo[2][info_itemPrice]
		local MyMoney		= GetMyMoney()
		local MyLife		= GetMyLife()
				
		LifeCount = LifeCount - 1
		
		winMgr:getWindow("AS_LifeCountEditbox"):setText(tostring(LifeCount))
	end
end


--------------------------------------------------------------------
-- 오른쪽 카운트 버튼 이벤트
--------------------------------------------------------------------
function AS_RightCountButtonEvent(args)
	if LifeCount == 99 then
		LifeCount = 99
		winMgr:getWindow("AS_LifeCountEditbox"):setText(tostring(LifeCount))
	else
		local Check = CheckNumber(LifeCount)
		if Check == false then
			return
		end
		local PricePoint	= tArcadeShopInfo[2][info_itemPrice]
		local MyMoney		= GetMyMoney()
		local MyLife		= GetMyLife()
		LifeCount = LifeCount + 1
		winMgr:getWindow("AS_LifeCountEditbox"):setText(tostring(LifeCount))	
	end
end


--------------------------------------------------------------------
-- 교환하기 확인 버튼 이벤트
--------------------------------------------------------------------
function AS_ExchangeOkBtnEvent(args)
	-- 
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
	
	-- 타이틀 이미지 설정
	winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(true)
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 322)	-- 알림 이미지
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 322)	-- 0, 363 -->축하합니다
	
	-- 버튼들
	winMgr:getWindow("AS_ExchangeOkBtn"):setVisible(false)			-- 버튼은 안보이게 감춘다.
	winMgr:getWindow("AS_ExchangeCancelBtn"):setVisible(false)
	winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(false)

	
	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		if CEGUI.toRadioButton(winMgr:getWindow("AS_List"..i)):isSelected() == true then	-- Select 안될때도 호출 되기 때문에 해야 한다.
			if i == 1 then		-- 코인 랜덤박스
				Coin3DimageTrue(0, 0)
			elseif i == 3 then	-- 그랑 랜덤박스
				Coin3DimageTrue(0, 1)
			elseif i == 4 or Index == 5 then	-- 핫픽스 박스
				Coin3DimageTrue(0, 1)
			end
			
			SendExchangeItem(i, LifeCount);	-- 서버로 아이템 교환하기 버튼이 눌러졌다고 보내준다.
			break	
		end
	end
	
end


function AS_ExchangeReturn()
	-- 아이템정보 백판
	winMgr:getWindow("AS_ExchangevisibleBack"):setVisible(false)	-- 아이템 정보를 담은 윈도우는 안보이게 감춘다.,
end


-- 써버에서 정보 못받아올때
function AS_ClearPopup()
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(false)
end
	
--------------------------------------------------------------------
-- 2D 애니메이션(교환창 선물상자 효과)
--------------------------------------------------------------------
function AS_2DImageAnimation(tick)
	winMgr:getWindow('AS_ExchangePresentInfoBack'):setTexture("Enabled", "UIData/other001.tga", tBackImageTexX[tick], tBackImageTexY[tick])
	winMgr:getWindow('AS_ExchangePresentInfoBack'):setTexture("Disabled", "UIData/other001.tga", tBackImageTexX[tick], tBackImageTexY[tick])
end




--------------------------------------------------------------------
-- 교환하기 마지막 씬
--------------------------------------------------------------------
function AS_LastScenePopup()
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
	winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(true)
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Enabled", "UIData/popup001.tga", 0, 363)	-- 알림 이미지
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Disabled", "UIData/popup001.tga", 0, 363)	-- 0, 363 -->축하합니다
	winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(true)
	
	local MyCoin	= CommatoMoneyStr(tostring(GetMyDungeonCoin()))
	local MyGran	= CommatoMoneyStr(tostring(GetMyMoney()))
	
	local r1,g1,b1		= GetGranColor(GetMyDungeonCoin())
	local r2,g2,b2		= GetGranColor(GetMyMoney())
		
	-- 그랑,  코인 업데이트 시켜준다.
	winMgr:getWindow("AS_CoinText"):clearTextExtends()
	local StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyCoin)
	winMgr:getWindow("AS_CoinText"):setPosition(150 - StringSize, 438)
	winMgr:getWindow("AS_CoinText"):addTextExtends(MyCoin, g_STRING_FONT_GULIMCHE, 14, r1,g1,b1,255, 0, 0,0,0,255);

	
	winMgr:getWindow("AS_GranText"):clearTextExtends()
	StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyGran)
	winMgr:getWindow("AS_GranText"):setPosition(340 - StringSize, 438)
	winMgr:getWindow("AS_GranText"):addTextExtends(MyGran, g_STRING_FONT_GULIMCHE, 14, r2,g2,b2,255, 0, 0,0,0,255);
	
end


--------------------------------------------------------------------
-- 선물상자 나온후 컨트롤 이벤트 해줌
--------------------------------------------------------------------
function AS_PresentEventFunction()
	
	winMgr:getWindow("AS_ReceiveItemInfoImg1"):activeMotion("PresentEvent");
	winMgr:getWindow("AS_ReceiveItemInfoImg0"):activeMotion("PresentEvent");
	winMgr:getWindow("AS_ReceiveItemInfoImg0"):setVisible(true)
	winMgr:getWindow("AS_ReceiveItemInfoImg1"):setVisible(true)
end
--------------------------------------------------------------------
-- 교환하기 취소 버튼 이벤트,
--------------------------------------------------------------------
function AS_ExchangeCancelBtnEvent(args)
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(false)
end



--------------------------------------------------------------------
-- 교환하기 마지막장면(축하합니다)확인버튼 이벤트
--------------------------------------------------------------------
function AS_ExchangeLastOkBtnEvent()
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(false)
	winMgr:getWindow("AS_ReceiveItemInfoImg1"):setVisible(false)
	
	Coin3DimageTrue(0, 0)
	-- 초기화
	RenderOK		= false
	RewardReturnOK	= false	-- 
	ControlCount	= 0
	TextAlpha		= 0
end



--------------------------------------------------------------------
-- 팝업창 키가 먹히게 하기위해만들어둔 엔터 이벤트 함수
--------------------------------------------------------------------
function PopupWindowOKEvent()
	if winMgr:getWindow("AS_ExchangeOkBtn"):isVisible() then
		winMgr:getWindow("AS_ExchangeOkBtn"):setVisible(false)
		AS_ExchangeOkBtnEvent()
		
	elseif winMgr:getWindow("AS_ExchangeLastOkBtn"):isVisible() then
		winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(false)
		AS_ExchangeLastOkBtnEvent()
	end
end


--------------------------------------------------------------------
-- 팝업창 키가 먹히게 하기위해만들어둔 ESC 이벤트 함수
--------------------------------------------------------------------
function PopupWindowCancelEvent()
	if winMgr:getWindow("AS_ExchangeCancelBtn"):isVisible() then
		AS_ExchangeCancelBtnEvent()
	end	
end


--------------------------------------------------------------------
-- 보상으로 받은 아이템 정보
--------------------------------------------------------------------
function AS_RandumboxResultItemInfo(itemType, ItemValue, ItemName, ItemFileName, ItemDesc, PayType)
	RewardReturnOK = true
	tRewardTable[1] = itemType;
	tRewardTable[2] = ItemValue;
	tRewardTable[3] = ItemName;
	tRewardTable[4] = ItemFileName;
	local _DescStart, _DescEnd = string.find(ItemDesc, "%$");
	local _ItemSkillKind = "";		--스킬종류
	local _ItemSkillDamage = "";	--스킬데미지
	local _ItemDetailDesc = "";		--스킬설명
	
	if _DescStart ~= nil then
		_ItemSkillKind = string.sub(ItemDesc, 1, _DescStart - 1);
		_ItemDetailDesc = string.sub(ItemDesc, _DescEnd + 1);
	
		_DescStart, _DescEnd = string.find(_ItemDetailDesc, "%$");
		if _DescStart ~= nil then
			_ItemSkillDamage = string.sub(_ItemDetailDesc, 1, _DescStart - 1);
			_ItemDetailDesc = string.sub(_ItemDetailDesc, _DescEnd + 1);
		end
		tRewardTable[5] = AdjustString(g_STRING_FONT_GULIMCHE, 12, _ItemDetailDesc, 180)
	else
		tRewardTable[5] = AdjustString(g_STRING_FONT_GULIMCHE, 12, ItemDesc, 180)
	end
	tRewardTable[6] = PayType
	
	if PayType == 0 then
		if itemType == 2 then
			local String = string.format(AS_String_LifeGet, LifeCount)
			ShowNotifyOKMessage_Lua(String)		-- 
		elseif itemType == 8 then
			local String = string.format(AS_String_CubeGet, ItemValue)
			ShowNotifyOKMessage_Lua(String)		-- 
		end
		
		local MyCoin	= CommatoMoneyStr(tostring(GetMyDungeonCoin()))
		local MyGran	= CommatoMoneyStr(tostring(GetMyMoney()))
		
		local r1,g1,b1		= GetGranColor(GetMyDungeonCoin())
		local r2,g2,b2		= GetGranColor(GetMyMoney())
	
		-- 그랑,  코인 업데이트 시켜준다.
		winMgr:getWindow("AS_CoinText"):clearTextExtends()
		local StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyCoin)
		winMgr:getWindow("AS_CoinText"):setPosition(150 - StringSize, 438)
		winMgr:getWindow("AS_CoinText"):addTextExtends(MyCoin, g_STRING_FONT_GULIMCHE, 14, r1,g1,b1,255, 0, 0,0,0,255);

		
		winMgr:getWindow("AS_GranText"):clearTextExtends()
		StringSize	= GetStringSize(g_STRING_FONT_GULIM, 14, MyGran)
		winMgr:getWindow("AS_GranText"):setPosition(340 - StringSize, 438)
		winMgr:getWindow("AS_GranText"):addTextExtends(MyGran, g_STRING_FONT_GULIMCHE, 14, r2,g2,b2,255, 0, 0,0,0,255);
	end
end


-- 묶음단위로 들어오는 핫픽스를 세팅해준다.
function SettingHotfixBundle(Index, FileName, ItemName, posx, posy)
	HotfixBundleTable[Index][1] = ItemName
	HotfixBundleTable[Index][2] = FileName
--	HotfixBundlePosTable[Index][1] = posx
--	HotfixBundlePosTable[Index][2] = posy
end

--------------------------------------------------------------------
-- 랜덤박스 랜더부분
--------------------------------------------------------------------
function RandomboxRender(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	if RenderOK and tRewardTable[6] == 0 then
		-- 코인 랜덤박스에대한 이벤트
		CoinRandomBoxEvent(drawer)		
	elseif RenderOK and tRewardTable[6] == 1 then
		-- 그랑 랜덤박스에대한 이벤트
		GranRandomBoxEvent(drawer)
	elseif CM_RenderOK then
		-- 챌린지 미션에서 나오는 이벤트
		CM_RandomboxRender(drawer)
	else

	end
end

--------------------------------------------------------------------
-- 그랑 랜덤박스이벤트
--------------------------------------------------------------------
function GranRandomBoxEvent(drawer)
	TextAlpha = TextAlpha + 5
	if TextAlpha >= 255 then
		TextAlpha = 255
	end
	
-------------------
-- 코인
-------------------
	if tRewardTable[1] == RewardType_Coin then			-- 코인
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		local granGainText	= AS_String_Coin
		local sCoinTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, granGainText)
		common_DrawOutlineText1(drawer, AS_String_Coin, 230 - sCoinTextSize/2, 14, 0,0,0,255, 255,205,86,255)		
		drawer:drawTextureSA("UIData/GameSlotItem001.tga", 15, 6, 98, 91, 490, 842, 303, 312, 255, 0, 0);
		
		-- 코인을 얼마나 받았는지
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);	
		granGainText = string.format(AS_String_GetCoin, tRewardTable[2])--"%d 코인을 획득하였습니다."
		sCoinTextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, granGainText)
		common_DrawOutlineText1(drawer, granGainText, 170 - sCoinTextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		-- 코인 이미지
		if tRewardTable[2] < 100000 then
			local _left = DrawEachNumberA("UIData/other001.tga", tRewardTable[2], 8, 226, 55, 11, 725, 24, 33, 25, 255, drawer)
			drawer:drawTextureA("UIData/other001.tga", _left-30, 55+2, 30, 29, 266, 727, 255)
		end
		
-------------------
-- 슬롯체인저
-------------------			
	elseif tRewardTable[1] == RewardType_SlotChanger then			-- 슬롯체인저
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		local granGainText	= AS_String_SlotChanger
		local sCoinTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, granGainText)
		common_DrawOutlineText1(drawer, AS_String_SlotChanger, 230 - sCoinTextSize/2, 14, 0,0,0,255, 255,205,86,255)		
		drawer:drawTextureSA("UIData/GameSlotItem001.tga", 15, 6, 98, 91, 882, 842, 303, 312, 255, 0, 0);
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		GainText = string.format(AS_String_GetSlotChanger, tRewardTable[2])--슬롯체인저 %d 개를 획득하였습니다.
		sCoinTextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, GainText)
		common_DrawOutlineText1(drawer, GainText, 170 - sCoinTextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)

		-- 
		if tRewardTable[2] < 100000 then
			local _left = DrawEachNumberA("UIData/other001.tga", tRewardTable[2], 8, 226, 55, 11, 641, 24, 33, 25, 255, drawer)
			drawer:drawTextureA("UIData/other001.tga", _left-30, 55+2, 30, 29, 266, 643, 255)
		end
	
--------------------
-- 아케이드 라이프
--------------------			
	elseif tRewardTable[1] == RewardType_Life then			-- 아케이드 라이프
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		local granGainText	= AS_String_LifeUp
		local sCoinTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, granGainText)
		common_DrawOutlineText1(drawer, AS_String_LifeUp, 230 - sCoinTextSize/2, 14, 0,0,0,255, 255,205,86,255)	
		drawer:drawTextureSA("UIData/GameSlotItem001.tga", 15, 6, 98, 91, 686, 842, 303, 312, 255, 0, 0);	
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		GainText = string.format(AS_String_GetLifeUp, tRewardTable[2])--"아케이드 Life Up "..tRewardTable[2].." 개를 획득하였습니다."
		sCoinTextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, GainText)
		common_DrawOutlineText1(drawer, GainText, 170 - sCoinTextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		-- 라이프 이미지
		if tRewardTable[2] < 100000 then
			local _left = DrawEachNumberA("UIData/other001.tga", tRewardTable[2], 8, 226, 55, 11, 641, 24, 33, 25, 255, drawer)
			drawer:drawTextureA("UIData/other001.tga", _left-30, 55+2, 30, 29, 266, 643, 255)
		end
-------------------
-- 체험스킬
-------------------
	elseif tRewardTable[1] == RewardType_Skill then			-- 체험스킬
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		-- 스킬 이름
		local NameTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tRewardTable[3])
		common_DrawOutlineText1(drawer, tRewardTable[3], 230 - NameTextSize/2, 14, 0,0,0,255, 255,205,86,255)	
		-- 이미지
		drawer:drawTextureSA("UIData/SkillUIData/"..tRewardTable[4], 15, 6, 98, 91, 0, 0, 255, 255, 255, 0, 0);	
		
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		local TextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, AS_String_GetSkill)
		common_DrawOutlineText1(drawer, AS_String_GetSkill, 170 - TextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		drawer:setTextColor(255, 0, 0, 255)
		drawer:drawText(tRewardTable[5], 140, 42)		-- desc

-------------------
-- 아이템
-------------------
	elseif tRewardTable[1] == RewardType_Item then			-- 아이템
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		-- 아이템 이름
		local NameTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tRewardTable[3])
		common_DrawOutlineText1(drawer, tRewardTable[3], 230 - NameTextSize/2, 14, 0,0,0,255, 255,205,86,255)	
		-- 이미지
		drawer:drawTextureSA("UIData/ItemUIData/"..tRewardTable[4], 15, 6, 98, 91, 0, 0, 255, 255, 255, 0, 0);	
		
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		local TextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, PreCreateString_2334)
		common_DrawOutlineText1(drawer, PreCreateString_2334, 170 - TextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		drawer:setTextColor(255, 0, 0, 255)
		drawer:drawText(tRewardTable[5], 140, 42)		-- desc
-------------------
-- 핫픽스
-------------------
	elseif tRewardTable[1] == RewardType_Orb then		-- 핫픽스
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		-- 스킬 이름
		local NameTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tRewardTable[3])
		common_DrawOutlineText1(drawer, tRewardTable[3], 230 - NameTextSize/2, 14, 0,0,0,255, 255,205,86,255)	
		-- 이미지
		drawer:drawTextureSA("UIData/ItemUIData/"..tRewardTable[4], 22, 13, 98, 91, 0, 0, 255, 255, 255, 0, 0);	
		
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		local DescText	= string.format(Get_Upgrade_Item, tRewardTable[3])
		local TextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, DescText)
		common_DrawOutlineText1(drawer, DescText, 170 - TextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		drawer:setTextColor(255, 0, 0, 255)
		drawer:drawText(tRewardTable[5], 140, 42)		-- desc
	
-------------------
-- 핫픽스 번들
-------------------	
	elseif tRewardTable[1] == RewardType_Orb_Bundle then
		-- 핫픽스
		drawer:setFont(g_STRING_FONT_GULIMCHE, 13);
		-- 스킬 이름
		local NameTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "orb list")
		common_DrawOutlineText1(drawer, "orb list", 230 - NameTextSize/2, 14, 0,0,0,255, 255,205,86,255)	
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		for i = 1, #HotfixBundleTable do
			-- 이미지
			drawer:drawTextureSA("UIData/ItemUIData/"..HotfixBundleTable[i][2], HotfixBundlePosTable[i][1], HotfixBundlePosTable[i][2], 98, 91, 0, 0, 130, 130, 230, 0, 0);	
			
			common_DrawOutlineText1(drawer, HotfixBundleTable[i][1], 134 + ((i-1) / 5) * 98, 40 + ((i-1)%5) * 16, 40,40,40,255, 235,255,137,255)	
		end
			
		drawer:setFont(g_STRING_FONT_DODUMCHE, 13);
		local TextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 13, Get_Upgrade_Items)
		common_DrawOutlineText1(drawer, Get_Upgrade_Items, 170 - TextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)

	end	
end


--------------------------------------------------------------------
-- 코인 랜덤박스 이벤트
--------------------------------------------------------------------
function CoinRandomBoxEvent(drawer)
	TextAlpha = TextAlpha + 5
	if TextAlpha >= 255 then
		TextAlpha = 255
	end
	
	if tRewardTable[1] == 0 then			-- 그랑
		-- 그랑 글자, 이미지
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14);
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, AS_String_Gran)
		common_DrawOutlineText1(drawer, AS_String_Gran, 230-size/2, 13, 0,0,0,255, 255,205,86,255)		
		drawer:drawTextureSA("UIData/GameSlotItem001.tga", 15, 6, 98, 91, 392, 842, 303, 312, 255, 0, 0);
		
		-- 그랑을 얼마나 받았는지
		local granGainText = tostring(tRewardTable[2]).." "..AS_String_GetGran
		local sCoinTextSize = GetStringSize(g_STRING_FONT_DODUMCHE, 14, granGainText)
		common_DrawOutlineText1(drawer, granGainText, 170 - sCoinTextSize/2, 140, 0,0,0,255, 255,255,255,TextAlpha)
		
		-- 그랑 이미지
		if tRewardTable[2] < 100000 then
			local _left = DrawEachNumberA("UIData/other001.tga", tRewardTable[2], 8, 226, 55, 11, 683, 24, 33, 25, 255, drawer)
			drawer:drawTextureA("UIData/other001.tga", _left-30, 55+2, 30, 29, 266, 685, 255)
		end
		
	elseif tRewardTable[1] == 1 then		-- 아이템
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14);
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, AS_String_TranslateItem)
		common_DrawOutlineText1(drawer, AS_String_TranslateItem, 230-size/2, 12, 0,0,0,255, 255,205,86,255)	--아이템 이름
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
		drawer:setTextColor(255, 0, 0, 255)
		drawer:drawText(tRewardTable[5], 140, 42)
		--common_DrawOutlineText1(drawer, tRewardTable[5], 160, 55, 0,0,0,255, 255,205,86,255)	--아이템 설명
		drawer:drawTextureSA("UIData/ItemUIData/"..tRewardTable[4], 15, 6, 243, 108, 0, 0, 255, 280, 255, 0, 0);
		
		drawer:setFont(g_STRING_FONT_DODUMCHE, 14);
		size = GetStringSize(g_STRING_FONT_DODUMCHE, 14, AS_String_GetTranslateItem)
		common_DrawOutlineText1(drawer, AS_String_GetTranslateItem, 170-size/2, 140, 0,0,0,255, 255,255,255,TextAlpha)	--아이템 설명
	end

end

----------------------------------------------------------------------------------
-- 컨트롤 완료되면 들어오게되는 함수
----------------------------------------------------------------------------------
function PresentEventMotionEnd()

	if ControlCount == 3 then
		winMgr:getWindow("AS_ReceiveItemInfoImg1"):setVisible(false)
	elseif ControlCount == 2 then
		RenderOK = true
	end
	ControlCount = ControlCount + 1	

end



--------------------------------------------------------------------
-- 아케이드 라이프 구매 재확인 ok 버튼 이벤트
--------------------------------------------------------------------
function AS_LifePopupConfirmOKEvent()		-- 써버로 라이프 구매했다고 보내준다.

	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		if CEGUI.toRadioButton(winMgr:getWindow("AS_List"..i)):isSelected() == true then	-- Select 안될때도 호출 되기 때문에 해야 한다.
			SendExchangeItem(i, LifeCount);	-- 서버로 아이템 교환하기 버튼이 눌러졌다고 보내준다.
			break	
		end
	end
	--윈도우 창들 없애준다.
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_LifePopupConfirmImg"):setVisible(false)

end


--------------------------------------------------------------------
-- 아케이드 라이프 구매 재확인 Cancel 버튼 이벤트
--------------------------------------------------------------------
function AS_LifePopupConfirmCancelEvent()


	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_LifePopupConfirmImg"):setVisible(false)

end




--------------------------------------------------------------------
-- 아케이드 라이프 구매 확인버튼 이벤트
--------------------------------------------------------------------
function AS_LifePopupOKBtnEvent()
	local SelectIndex = 0
	
	for i = 1, ARCADE_CURRENT_LIST_COUNT do
		if CEGUI.toRadioButton(winMgr:getWindow("AS_List"..i)):isSelected() == true then	-- Select 안될때도 호출 되기 때문에 해야 한다.
			SelectIndex = i
			break	
		end
	end
	if LifeCount <= 0 then
		if SelectIndex == 2 then
			ShowNotifyOKMessage_Lua(PreCreateString_2324)--GetSStringInfo(LAN_INPUT_LIFE_COUNT)
		elseif SelectIndex == 6 then
			ShowNotifyOKMessage_Lua(PreCreateString_2372)--GetSStringInfo(LAN_INPUT_CUBE_COUNT)
		end
		return
	end
	winMgr:getWindow("AS_LifePopupMainImg"):setVisible(false)
	-- 확인 팝업창 띄워준다.
	root:addChildWindow(winMgr:getWindow("AS_LifePopupConfirmImg"))
	winMgr:getWindow("AS_LifePopupConfirmImg"):setVisible(true)
	
	local Name			= tArcadeShopInfo[SelectIndex][info_itemName]	
	local Description	= tArcadeShopInfo[SelectIndex][info_itemDesc]  
	local ItemFileName	= tArcadeShopInfo[SelectIndex][info_FileName]	

	-- 아이템 이름
	winMgr:getWindow("AS_LifeConfirmNameText"):clearTextExtends()
	winMgr:getWindow("AS_LifeConfirmNameText"):setAlign(8)
	winMgr:getWindow("AS_LifeConfirmNameText"):addTextExtends(Name, g_STRING_FONT_GULIM,12, 102,204,102,255, 1, 0,0,0,255);
	
	-- 아이템 설명
	winMgr:getWindow("AS_LifeConfirmDescText"):clearTextExtends()
	Description = AdjustString(g_STRING_FONT_DODUMCHE, 112, Description, 160)
	winMgr:getWindow("AS_LifeConfirmDescText"):addTextExtends(Description, g_STRING_FONT_GULIM,112, 255,255,255,255, 0, 0,0,0,255);
	
	winMgr:getWindow("AS_LifeConfirmImg"):setTexture("Enabled", ItemFileName, 0, 0)
	winMgr:getWindow("AS_LifeConfirmImg"):setTexture("Disabled", ItemFileName, 0, 0)
end



--------------------------------------------------------------------
-- 아케이드 라이프 구매 취소 버튼 이벤트
--------------------------------------------------------------------
function AS_LifePopupCancelBtnEvent()
	winMgr:getWindow("AS_PopupBackAlphaImg"):setVisible(false)
	winMgr:getWindow("AS_LifePopupMainImg"):setVisible(false)
end



--------------------------------------------------------------------
-- 아케이드 샵을 보여준다.
--------------------------------------------------------------------
function OpenArcadeShop()

	AS_mainwindow:setVisible(true)
	SetUpArcadeShop()
	
end



--------------------------------------------------------------------
-- 아케이드 샵을 닫아준다.
--------------------------------------------------------------------
function CloseArcadeShop()

	AS_mainwindow:setVisible(false)

end



