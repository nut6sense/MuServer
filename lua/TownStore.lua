--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------


--------------------------------------------------------------------
-- 전역으로 사용할 변수들
--------------------------------------------------------------------
local MAX_SHOP_COUNT = 4		-- 한 화면에 보여줄 아이템목록의 최대 갯수
local MAX_SELL_COST_ITEM = 6	-- 아이템을 사는데 필요한 최대 아이템 갯수

local PURCHASE_ITEM = 0		-- 살 아이템
local PAYMENT_ITEM = 1		-- 지불해야될 아이템

local SavingIndex = -1
local SavingCount = 0
local SavePayValue = 0

local COUNT_INPUT	  = 0	-- 수량 입력
local CONFIRM_MESSAGE = 1	-- 확인 메세지 띄워줌

local tPayTypePosX = {['err'] = 0, [0]=482, 504, 462}		-- 젠, 캐시
local tPurchaseButtonIndex = {['err']=0, [0]=0, 1, 2, 3}	-- 구입버튼 인덱스
local TownStoreitemString = PreCreateString_2497	--GetSStringInfo(LAN_PURCHASE_ITEM_TOWNSTORE)

local tMoneyTable = {['err']=0, [0]=0, 0, 0}
local tPayItemTable = {['err']=0, [0]={['err']=0, }, {['err']=0, }, {['err']=0, }, {['err']=0, }, {['err']=0, }, {['err']=0, }}

for i=0, MAX_SELL_COST_ITEM-1 do
	tPayItemTable[i][0] = ""		-- 아이템 파일 이름
	tPayItemTable[i][1] = ""		-- 아이템 이름
	tPayItemTable[i][2] = 0			-- 아이템 번호
	tPayItemTable[i][3] = 0			-- 아이템 종류
	tPayItemTable[i][4] = 0			-- 아이템 요구 수량
	tPayItemTable[i][5] = 0			-- 아이템 보유 수량
	tPayItemTable[i][6] = ""		-- 아이템 파일 이름2
end

local MONEY_TYPE_ZEN = 0
local MONEY_TYPE_COIN = 1
local MONEY_TYPE_CASH = 2

local TAB_MAX				= 4
local CATEGORY_MAX			= 4

--============================= 보유아이템 목록 팝업창 시작 =============================
-- 메인 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_MainAlpha")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(1920, 1200)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 메인이 되는 뒷판
local TownStoreMainWindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreMainImage")
TownStoreMainWindow:setTexture("Enabled", "UIData/deal2.tga", 0, 0)
TownStoreMainWindow:setWideType(6)
TownStoreMainWindow:setPosition(23, 100)
TownStoreMainWindow:setSize(307, 562)
TownStoreMainWindow:setVisible(false)
TownStoreMainWindow:setAlwaysOnTop(true)
TownStoreMainWindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NPC 상점 BG
--------------------------------------------------------------------
local TownStoreMainWindow = winMgr:createWindow("TaharezLook/StaticImage", "NPCTabStoreBG")
TownStoreMainWindow:setTexture("Enabled",	"UIData/frame/frame_012.tga", 0 , 0)
TownStoreMainWindow:setTexture("Disabled", "UIData/frame/frame_012.tga", 0 , 0)
TownStoreMainWindow:setframeWindow(true)
TownStoreMainWindow:setWideType(6)
TownStoreMainWindow:setPosition(23, 55)
TownStoreMainWindow:setSize(307, 637)
TownStoreMainWindow:setVisible(false)
TownStoreMainWindow:setAlwaysOnTop(true)
TownStoreMainWindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NPC 상점 이름
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPCTabStoreTitle")
mywindow:setTexture("Enabled", "UIData/deal2.tga", 888, 606)
mywindow:setTexture("Disabled", "UIData/deal2.tga", 888, 606)
mywindow:setPosition(91, 9)
mywindow:setSize(126, 23)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("NPCTabStoreBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- CategoryBG
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPCTabStoreCategoryBG")
mywindow:setTexture("Enabled", "UIData/deal2.tga", 596, 606)
mywindow:setTexture("Disabled", "UIData/deal2.tga", 596, 606)
mywindow:setPosition(8, 41)
mywindow:setSize(291, 75)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("NPCTabStoreBG"):addChildWindow(mywindow)

for i = 1, TAB_MAX do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "NPCTabStor_TabButton"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 40)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 80)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 80)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga", 0, 40)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga", 0, 80)
	mywindow:setProperty("GroupID", 1112019)
	mywindow:setPosition(1 + (72 * (i - 1)), 2)
	mywindow:setSize(71, 40)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ClickedTabButton")
	
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	else
		mywindow:setProperty("Selected", "false")
	end
	
	winMgr:getWindow("NPCTabStoreCategoryBG"):addChildWindow(mywindow)
end

function ClickedTabButton(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(local_window:getUserString('TabIndex'))
	
	SettingCurrentTabNum(index)
	CURRENT_CATEGORY_MAX = 0
	
	winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Enabled", "UIData/deal2.tga", 290, 867)
	winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Disabled", "UIData/deal2.tga", 290, 867)

	for i = 0, CATEGORY_MAX - 1 do
		if i == 0 then
			winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "true")
		else
			winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "false")
		end
		
		winMgr:getWindow("NPCTabStor_CategoryButton"..i):setVisible(false)
	end
end

function SettingTabStore(TabIndex, TabTexIndex)
	TabTexIndex = TabTexIndex - 1
	
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("Normal", "UIData/deal4.tga", TabTexIndex * 71, 0)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("Hover", "UIData/deal4.tga", TabTexIndex * 71, 40)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("Pushed", "UIData/deal4.tga", TabTexIndex * 71, 80)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("Disabled", "UIData/deal4.tga", TabTexIndex * 71, 0)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("SelectedNormal", "UIData/deal4.tga", TabTexIndex * 71, 80)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("SelectedHover", "UIData/deal4.tga", TabTexIndex * 71, 40)
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setTexture("SelectedPushed", "UIData/deal4.tga", TabTexIndex * 71, 80)
	
	winMgr:getWindow("NPCTabStor_TabButton"..TabIndex):setVisible(true)
end

RegistEscEventInfo("TownStore_MainAlpha", "CloseTownStore")

--------------------------------------------------------------------
-- NPC 상점 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "TownStore_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(276, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseTownStoreButtonEvent")


local TownStoreItemBackWindow = nil		-- 각각의 아이템을 구성하는 윈도우
local FirstPosY = 41
local YTerm		= 1

-- 각각의 아이템을 구성하는 윈도우.
for i = 0, MAX_SHOP_COUNT-1 do
	-- 뒷판
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreItemBack"..i)
	mywindow:setTexture("Enabled", "UIData/deal2.tga", 307, 0)
	mywindow:setPosition(10, FirstPosY + i * (YTerm + 120))
	mywindow:setSize(287, 120)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)

	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_ItemNameText"..i)
	mywindow:setPosition(0, 6)
	mywindow:setSize(287, 18)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_ItemImg"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(6, 29)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(110)
	mywindow:setScaleHeight(110)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_Item_SkillLevelImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(14, 34)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_Item_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(35, 34)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_Item_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(3, 29)
	mywindow:setSize(47, 47)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_TownStore_Purchase_Item")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_TownStore_Purchase_Item")
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	--beejivelm
	
	-- 아이템 설명
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_Item_DescText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 31)
	mywindow:setSize(226, 40)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(5)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 랜덤 아이템 정보
	mywindow = winMgr:createWindow("TaharezLook/Button", "TownStore_DetailIInfoBtn_"..i)
	mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
	mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
	mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
	mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
	mywindow:setPosition(263, 57)
	mywindow:setSize(20, 20)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:setSubscribeEvent("Clicked", "TownStore_ShowRandomOpenItem")
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 이벤트 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_EventImg"..i)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Insert/Event.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	-- 사는 비용으로 쓰이는 아이템 이미지.	
	for j=0, MAX_SELL_COST_ITEM-1 do
		-- 아이템 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_SellCost_ItemImg_"..i.."_"..j)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(28 + ((j%2) * 62), 77 + (j/2)*22)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(44)
		mywindow:setScaleHeight(44)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_SellCost_ItemImgEmpty_"..i.."_"..j)
		mywindow:setTexture("Disabled", "UIData/deal2.tga", 659, 53)
		mywindow:setPosition(28 +((j%2) * 62), 77 + (j/2)*22)
		mywindow:setSize(19, 19)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)

		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_SellCost_CountBackImg_"..i.."_"..j)
		mywindow:setTexture("Disabled", "UIData/deal2.tga", 646, 72)
		mywindow:setPosition(48 + ((j%2) * 62), 76 + (j/2)*22)
		mywindow:setSize(38, 20)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
		
		-- 
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_SellCost_CountText_"..i.."_"..j)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(4,2)
		mywindow:setSize(34, 20)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStore_SellCost_CountBackImg_"..i.."_"..j):addChildWindow(mywindow)
		
		-- 툴팁 이벤트를 위한 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_SellCost_EventImage_"..i.."_"..j)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(18 + ((j%2) * 62), 76 + (j/2)*22)
		mywindow:setSize(19, 19)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("ParentIndex", i)
		mywindow:setUserString("Index", j)
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_TownStore_Item")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_TownStore_Item")
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
	
	end
	
	-- 아이템 이미지(지불비용 이미지)
	for j=0, 1 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_PayType_ItemImg_"..i.."_"..j)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", tPayTypePosX[j], 788)
		--mywindow:setPosition(170+(j*-115), 77)
		mywindow:setPosition(178+(j*-115), 77)
		mywindow:setSize(19, 19)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_SellCost_MoneyBackImg_"..i.."_"..j)
		mywindow:setTexture("Disabled", "UIData/deal2.tga", 594, 164)
		--mywindow:setPosition(170+20+(j*-115), 75)
		mywindow:setPosition(178+20+(j*-115), 75)
		mywindow:setSize(87, 21)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
		
	
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_SellCost_Money_"..i.."_"..j)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(5,5)
		mywindow:setSize(75, 18)
		mywindow:setViewTextMode(1)
		mywindow:setLineSpacing(2)
		mywindow:setAlign(6)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("TownStore_SellCost_MoneyBackImg_"..i.."_"..j):addChildWindow(mywindow)
	end

	-- 아이템 구입버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "TownStoreItemBuyBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal2.tga", 594, 0)
	mywindow:setTexture("Hover", "UIData/deal2.tga", 594, 18)
	mywindow:setTexture("Pushed", "UIData/deal2.tga", 594, 36)
	mywindow:setTexture("PushedOff", "UIData/deal2.tga", 594, 36)
	mywindow:setTexture("Disabled", "UIData/deal2.tga", 594, 54)
	mywindow:setPosition(220, 98)
	mywindow:setSize(65, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("ButtonIndex", tostring(i))
	mywindow:subscribeEvent("Clicked", "ClickedTownStoreItemBuy")
	winMgr:getWindow("TownStoreItemBack"..i):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/Button", "NPCTabStor_CategoryMainBG")
mywindow:setTexture("Normal", "UIData/deal2.tga", 791, 344)
mywindow:setTexture("Hover", "UIData/deal2.tga", 791, 372)
mywindow:setTexture("Pushed", "UIData/deal2.tga", 791, 400)
mywindow:setTexture("PushedOff", "UIData/deal2.tga", 791, 344)
mywindow:setWideType(6)
mywindow:setPosition(179, 140)
mywindow:setSize(141, 28)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "OpenCategoryButton")
winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPCTabStor_CurrentCategory")
mywindow:setTexture("Enabled", "UIData/deal2.tga", 290, 867)
mywindow:setTexture("Disabled", "UIData/deal2.tga", 290, 867)
mywindow:setPosition(0, 0)
mywindow:setSize(141, 28)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("NPCTabStor_CategoryMainBG"):addChildWindow(mywindow)

for i = 0, CATEGORY_MAX - 1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "NPCTabStor_CategoryButton"..i)
	mywindow:setTexture("Normal", "UIData/deal2.tga", 596, 550)
	mywindow:setTexture("Hover", "UIData/deal2.tga", 596, 578)
	mywindow:setTexture("Pushed", "UIData/deal2.tga", 596, 550)
	mywindow:setTexture("Disabled", "UIData/deal2.tga", 596, 550)
	mywindow:setTexture("SelectedNormal", "UIData/deal2.tga", 596, 578)
	mywindow:setTexture("SelectedHover", "UIData/deal2.tga", 596, 578)
	mywindow:setTexture("SelectedPushed", "UIData/deal2.tga", 596, 550)
	mywindow:setProperty("GroupID", 1110000)
	mywindow:setWideType(6)
	mywindow:setPosition(179, 170 + ( i * 29 ))
	mywindow:setSize(141, 28)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OpenCategoryButton")
	mywindow:setSubscribeEvent("MouseButtonDown",  "SelectStateChangedCategory")

	if i == 0 then
		mywindow:setProperty("Selected", "true")
	else
		mywindow:setProperty("Selected", "false")
	end

	winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPCTabStore_CategoryName"..i)
	mywindow:setTexture("Enabled", "UIData/deal2.tga", 290 + (i*141), 867)
	mywindow:setTexture("Disabled", "UIData/deal2.tga", 290 + (i*141), 867)
	mywindow:setPosition(0, 0)
	mywindow:setSize(141, 28)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("NPCTabStor_CategoryButton"..i):addChildWindow(mywindow)
end

function SelectStateChangedCategory(args)
	OpenCategoryButton()
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(local_window:getUserString('TabIndex'))
	
	winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Enabled", "UIData/deal2.tga", 290 + (index*141), 867)
	winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Disabled", "UIData/deal2.tga", 290 + (index*141), 867)
	
	winMgr:getWindow("NPCTabStor_CategoryButton"..index):setProperty("Selected", "true")
	
	SettingCurrentCategory(index)
end

function OpenCategoryButton()

	if winMgr:getWindow("NPCTabStor_CategoryButton0"):isVisible() == true then
		for i = 0, CATEGORY_MAX -1 do
			winMgr:getWindow("NPCTabStor_CategoryButton"..i):setVisible(false)
		end
	elseif winMgr:getWindow("NPCTabStor_CategoryButton0"):isVisible() == false then
		for i = 0, CATEGORY_MAX -1 do
			winMgr:getWindow("NPCTabStor_CategoryButton"..i):setVisible(true)
		end
	end
	
end

--------------------------------------------------------------------
-- 임시 세일률
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreTempSale")
mywindow:setTexture("Enabled", "UIData/deal.tga", 828, 973)
mywindow:setWideType(6)
mywindow:setPosition(30, 120)
mywindow:setSize(61, 51)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStore_ItemNameText0"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreTempSaleValue")
mywindow:setTexture("Enabled", "UIData/deal.tga", 754, 1001)
mywindow:setWideType(6)
mywindow:setPosition(235, 195)
mywindow:setSize(74, 23)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStore_ItemNameText0"):addChildWindow(mywindow)

function TempSaleVisibleOpen()
	winMgr:getWindow("TownStoreTempSale"):setVisible(true)
	winMgr:getWindow("TownStoreTempSaleValue"):setVisible(true)
end

function TempSaleVisibleEnd()
	winMgr:getWindow("TownStoreTempSale"):setVisible(false)
	winMgr:getWindow("TownStoreTempSaleValue"):setVisible(false)
end


-- 샵 페이지 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_Page")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setPosition(134, 535)
mywindow:setSize(40, 18)
mywindow:setZOrderingEnabled(false)

-- 광장 죄우버튼
local Page_BtnName  = {["err"]=0, [0]="TownStorePage_LBtn", "TownStorePage_RBtn"}
local Page_BtnTexX  = {["err"]=0, [0]= 0, 22}

local Page_BtnPosX  = {["err"]=0, [0]= 100, 186}
local Page_BtnEvent = {["err"]=0, [0]= "TownStorePage_LBtnEvent", "TownStorePage_RBtnEven"}

for i=0, #Page_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Page_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", Page_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", Page_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",Page_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", Page_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", Page_BtnTexX[i], 81)
	mywindow:setPosition(Page_BtnPosX[i], 529)
	mywindow:setSize(22, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", Page_BtnEvent[i])
end


-- 광장 상점 페이지버튼 왼쪽 버튼 클릭
function TownStorePage_LBtnEvent(args)
	local check = TownStorePrevButtonEvent()
	if check then
		local totalPage = GetTownStoreTotalPage()
		local currentPage = GetTownStoreCurrentPage()
		winMgr:getWindow("TownStore_Page"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end

end


-- 광장 상점 페이지버튼 오른쪽 버튼 클릭
function TownStorePage_RBtnEven(args)
	local check = TownStoreNextButtonEvent()
	if check then
		local totalPage = GetTownStoreTotalPage()
		local currentPage = GetTownStoreCurrentPage()
		winMgr:getWindow("TownStore_Page"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end

end

function SetTabNPCEnabled(Enabled)
	if Enabled == 0 then
		winMgr:getWindow("NPCTabStoreBG"):setVisible(false)
		winMgr:getWindow("TownStoreMainImage"):setVisible(true)
		
		winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(winMgr:getWindow("TownStoreMainImage"))
		winMgr:getWindow("TownStoreMainImage"):addChildWindow(winMgr:getWindow("TownStore_CloseButton"))

		for i = 0, MAX_SHOP_COUNT-1 do
		 winMgr:getWindow("TownStoreItemBack"..i):setPosition(10, 41 + (i * 121))
		 winMgr:getWindow("TownStoreMainImage"):addChildWindow(winMgr:getWindow("TownStoreItemBack"..i))
		end
		
		winMgr:getWindow("TownStore_Page"):setPosition(134, 535)
		winMgr:getWindow("TownStoreMainImage"):addChildWindow(winMgr:getWindow("TownStore_Page"))
		
		for i = 0, #Page_BtnName do
			winMgr:getWindow(Page_BtnName[i]):setPosition(Page_BtnPosX[i], 529)
			winMgr:getWindow("TownStoreMainImage"):addChildWindow(winMgr:getWindow(Page_BtnName[i]))
		end
		
		winMgr:getWindow("NPCTabStor_CategoryMainBG"):setVisible(false)
		
		for i = 0, CATEGORY_MAX - 1 do
			winMgr:getWindow("NPCTabStor_CategoryButton"..i):setVisible(false)
			
			if i == 0 then
				winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "true")
			else
				winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "false")
			end
		end
		
	elseif Enabled == 1 then
		winMgr:getWindow("NPCTabStoreBG"):setVisible(true)
		winMgr:getWindow("TownStoreMainImage"):setVisible(false)
		
		winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(winMgr:getWindow("NPCTabStoreBG"))
		winMgr:getWindow("NPCTabStoreBG"):addChildWindow(winMgr:getWindow("TownStore_CloseButton"))

		for i = 0, MAX_SHOP_COUNT-1 do
		 winMgr:getWindow("TownStoreItemBack"..i):setPosition(10, 117 + (i * 121))
		 winMgr:getWindow("NPCTabStoreBG"):addChildWindow(winMgr:getWindow("TownStoreItemBack"..i))
		end
		
		winMgr:getWindow("TownStore_Page"):setPosition(128, 611)
		winMgr:getWindow("NPCTabStoreBG"):addChildWindow(winMgr:getWindow("TownStore_Page"))
		
		for i = 0, #Page_BtnName do
			winMgr:getWindow(Page_BtnName[i]):setPosition(Page_BtnPosX[i] - 5, 605)
			winMgr:getWindow("NPCTabStoreBG"):addChildWindow(winMgr:getWindow(Page_BtnName[i]))
		end
	
		winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(winMgr:getWindow("NPCTabStor_CategoryMainBG"))
		winMgr:getWindow("NPCTabStor_CategoryMainBG"):setAlwaysOnTop(true)
		winMgr:getWindow("NPCTabStor_CategoryMainBG"):setVisible(true)
		
		for i = 0, CATEGORY_MAX - 1 do
			winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(winMgr:getWindow("NPCTabStor_CategoryButton"..i))
			
			if i == 0 then
				winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "true")
			else
				winMgr:getWindow("NPCTabStor_CategoryButton"..i):setProperty("Selected", "false")
			end
		end
		
		winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Enabled", "UIData/deal2.tga", 290, 867)
		winMgr:getWindow("NPCTabStor_CurrentCategory"):setTexture("Disabled", "UIData/deal2.tga", 290, 867)
	end
end


-- 상점의 목록 페이지를 세팅한다.
function SettingTownStorePageText(current, total)
	winMgr:getWindow("TownStore_Page"):setTextExtends(current.." / "..total, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end


-- 랜덤 아이템을 열었을 때 나오는 아이템정보를 띄워주는 버튼
function TownStore_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(local_window:getUserString('Index'))
	local x, y = GetBasicRootPoint(local_window)
	y = y - 80
	if x + 245 > g_CURRENT_WIN_SIZEX then
		x = x - 245
	end
	if y + 175 > g_CURRENT_WIN_SIZEY then
		y = y - 175
	end
	local itemKind, itemNumber = GetTownStoreToolTipInfo(index, 0, PURCHASE_ITEM)
	ShowRandomOpenItem(itemNumber, x, y)

end



-- 살 아이템에 마우스가 들어왔을때
function OnMouseEnter_TownStore_Purchase_Item(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index		  = tonumber(EnterWindow:getUserString("Index"))

	if index == -1 then
		return
	end
	local itemKind, itemNumber = GetTownStoreToolTipInfo(index, 0, PURCHASE_ITEM)
	
	OutputItemImg(x,y,itemNumber,itemKind)	-- 확대된놈 띄워준다.
	
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
	GetToolTipBaseInfo(x + 122, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	DebugStr("ItemNum : " .. itemNumber);
end

-- 나갔을대
function OnMouseLeave_TownStore_Purchase_Item(args)
	SetShowToolTip(false)
	HideZoomInItem()
end



-- 비용으로 사용되는 아이템에 마우스가 들어왔을때
function OnMouseEnter_TownStore_Item(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index		  = tonumber(EnterWindow:getUserString("Index"))
	local ParentIndex = tonumber(EnterWindow:getUserString("ParentIndex"))
	if index == -1 then
		return
	end
	local itemKind, itemNumber = GetTownStoreToolTipInfo(index, ParentIndex, PAYMENT_ITEM)
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
	GetToolTipBaseInfo(x + 20, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

end


-- 살 아이템에 마우스가 나갔을때
function OnMouseLeave_TownStore_Item(args)
	SetShowToolTip(false)

end



-- 상점 아이템 정보들을 초기화 시켜준다
function ClearStoreItemInfo()
	for i = 0, MAX_SHOP_COUNT-1 do
		winMgr:getWindow("TownStore_ItemNameText"..i):clearTextExtends()	-- 아이템 이름 텍스트
		winMgr:getWindow("TownStore_ItemImg"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)	-- 아이템 이미지.
		winMgr:getWindow("TownStore_ItemImg"..i):setLayered(false)
		winMgr:getWindow("TownStore_Item_SkillLevelImage_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)	-- 스킬 레벨 테두리 이미지
		winMgr:getWindow("TownStore_Item_SkillLevelText_"..i):setText("")	-- 스킬레벨 + 글자

		for j=0, MAX_SELL_COST_ITEM-1 do
			winMgr:getWindow("TownStore_SellCost_ItemImg_"..i.."_"..j):setTexture("Disabled", "UIData/invisible.tga", 0, 0)	-- 교환할 아이템 이미지
			winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..i.."_"..j):setVisible(false)	-- 교환할 아이템 이미지
			winMgr:getWindow("TownStore_SellCost_CountBackImg_"..i.."_"..j):setVisible(false)	-- 교환할 아이템 이미지						
			winMgr:getWindow("TownStore_SellCost_EventImage_"..i.."_"..j):setVisible(false)
			winMgr:getWindow("TownStore_SellCost_CountText_"..i.."_"..j):setText("-")	-- 스킬레벨 + 글자
		end
				
		for j=0, 1 do
			winMgr:getWindow("TownStore_PayType_ItemImg_"..i.."_"..j):setTexture("Disabled", "UIData/invisible.tga", 0, 0)	-- 아이템 페이타입 이미지.
			winMgr:getWindow("TownStore_SellCost_MoneyBackImg_"..i.."_"..j):setVisible(false)
			winMgr:getWindow("TownStore_SellCost_Money_"..i.."_"..j):clearTextExtends()	-- 아이템 가격 텍스트
		end
		winMgr:getWindow("TownStore_Item_EventImage_"..i):setVisible(false)
		winMgr:getWindow("TownStoreItemBuyBtn_"..i):setEnabled(false)
--		winMgr:getWindow("TownStore_SellCost_ItemImgBack"..i):setVisible(false)		
		winMgr:getWindow("TownStore_Item_DescText_"..i):setVisible(false)
		winMgr:getWindow("TownStore_DetailIInfoBtn_"..i):setVisible(false)
		winMgr:getWindow("TownStore_EventImg"..i):setVisible(false)		
			
	end
end


-- 전시되어있는 아이템 정보를 세팅해준다
function SetStoreItemInfo(itemName, fileName, fileName2, period, itemNumber, index, bEventCheck)
	local itemNameWindow		= winMgr:getWindow("TownStore_ItemNameText"..index)
	local itemFileNameWindow	= winMgr:getWindow("TownStore_ItemImg"..index)
	local String = SummaryString(g_STRING_FONT_GULIM, 12, itemName..period, 240)
	
	itemNameWindow:setTextExtends(String, g_STRING_FONT_GULIM, 12, 255,198,30,255,   0, 255,255,255,255)
	itemFileNameWindow:setTexture("Disabled", fileName, 0, 0)
	if fileName2 == "" then
		itemFileNameWindow:setLayered(false)
	else
		itemFileNameWindow:setLayered(true)
		itemFileNameWindow:setTexture("Layered", fileName2, 0, 0)
	end
	
	winMgr:getWindow("TownStore_Item_EventImage_"..index):setVisible(true)
	winMgr:getWindow("TownStoreItemBuyBtn_"..index):setEnabled(true)
		
	if CheckDetailInfoBtn(itemNumber) then
		winMgr:getWindow("TownStore_DetailIInfoBtn_"..index):setVisible(true)
	else
		winMgr:getWindow("TownStore_DetailIInfoBtn_"..index):setVisible(false)
	end
	
	if bEventCheck then
		winMgr:getWindow("TownStore_EventImg"..index):setVisible(true)
	else
		winMgr:getWindow("TownStore_EventImg"..index):setVisible(false)
	end	
end


-- 상점의 아이템 살때 지불해야할 아이템을 세팅
function SetStorePayItem(itemNumber, fileName, fileName2, kind, count, parentIndex, index, bCondition)
	local imageWindow	= winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..index)
	local textWindow	= winMgr:getWindow("TownStore_SellCost_CountText_"..parentIndex.."_"..index)
	winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..index):setVisible(true)
	winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..index):setVisible(true)	-- 교환할 아이템 이미지
	winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..index):setVisible(false)	-- 교환할 아이템 이미지
	imageWindow:setTexture("Disabled", fileName, 0, 0)
	if bCondition > 0 then
		textWindow:setTextColor(255,255,255,255)
	else
		textWindow:setTextColor(255,26,40,255)
	end
	textWindow:setText(tostring(count))
--	winMgr:getWindow("TownStore_SellCost_ItemImgBack"..parentIndex):setVisible(true)
end

function SetStorePayItemPos(count, parentIndex)	
	local index = 2	
	if count > 4 then		
		index = 3	
			
		for j=4, count-1 do			
			winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..j):setVisible(true)
			winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..j):setVisible(true)
			winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..j):setVisible(true)
		end
	else
		for j=4, MAX_SELL_COST_ITEM-1 do
			winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..j):setVisible(false)
			winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..j):setVisible(false)
			winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..j):setVisible(false)
			winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..j):setVisible(false)
		end
	end	
	
	for j=0, MAX_SELL_COST_ITEM-1 do
		--winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..j):setPosition(28 + ((j%index) * 62), 77 + (j/index)*22)		
		--winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..j):setPosition(28 +((j%index) * 62), 77 + (j/index)*22)		
		--winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..j):setPosition(48 + ((j%index) * 62), 76 + (j/index)*22)		
		--winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..j):setPosition(28 + ((j%index) * 62), 76 + (j/index)*22)	
		winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..j):setPosition(3 + ((j%index) * 58), 77 + (j/index)*22)		
		winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..j):setPosition(3 +((j%index) * 58), 77 + (j/index)*22)		
		winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..j):setPosition(23 + ((j%index) * 58), 76 + (j/index)*22)		
		winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..j):setPosition(3 + ((j%index) * 58), 76 + (j/index)*22)
	end	
end

function SetEmptySettingItem(parentIndex, index)
	local imageWindow	= winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..index)
	winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..index):setVisible(true)	-- 교환할 아이템 이미지
	imageWindow:setVisible(true)
end	


function EmptySettingItemClear(parentIndex, index)
--	for j=0, MAX_SELL_COST_ITEM-1 do
--		winMgr:getWindow("TownStore_SellCost_ItemImg_"..parentIndex.."_"..j):setTexture("Disabled", "UIData/invisible.tga", 0, 0)	-- 교환할 아이템 이미지
--		winMgr:getWindow("TownStore_SellCost_ItemImgEmpty_"..parentIndex.."_"..j):setVisible(false)	-- 교환할 아이템 이미지			
--		winMgr:getWindow("TownStore_SellCost_EventImage_"..parentIndex.."_"..j):setVisible(false)
--		winMgr:getWindow("TownStore_SellCost_CountBackImg_"..parentIndex.."_"..j):setVisible(false)	
--	end
end	


-- 아이템의 설명을 뿌려준다.
function SetItemDesc(itemDesc, index, specialDesc)
	winMgr:getWindow("TownStore_Item_DescText_"..index):setVisible(true)
	local string = AdjustString(g_STRING_FONT_GULIM, 11, itemDesc, 200)
	string = SummaryString(g_STRING_FONT_GULIM, 11, string, 600)	
	winMgr:getWindow("TownStore_Item_DescText_"..index):setTextExtends(string, g_STRING_FONT_GULIM, 11, 255,255,255,255,   0, 255,255,255,255)		
	if specialDesc ~= 0 then
		DebugStr("GetSStringInfo를 실행하고 있습니다" .. specialDesc)
		winMgr:getWindow("TownStore_Item_DescText_"..index):addTextExtends(GetSStringInfo(specialDesc), g_STRING_FONT_GULIM, 11, 255,10,30,255,   0, 255,255,255,255)
	end	
end


-- 상점의 아이템 살때 지불해야할 가격을 세팅
function SetStorePayPrice(price, parentIndex, payIndex, payType, random, bEventCheck)
	local imageWindow	= winMgr:getWindow("TownStore_PayType_ItemImg_"..parentIndex.."_"..payIndex)
	local textWindow	= winMgr:getWindow("TownStore_SellCost_Money_"..parentIndex.."_"..payIndex)
	winMgr:getWindow("TownStore_SellCost_MoneyBackImg_"..parentIndex.."_"..payIndex):setVisible(true)
	imageWindow:setTexture("Disabled", "UIData/Itemshop001.tga", tPayTypePosX[payType], 788)
	--textWindow:setText(tostring(price))
	if random == 0 then
		local r, g, b	= ColorToMoney(price)
		if bEventCheck then
			textWindow:setTextExtends("300 ▶ ", g_STRING_FONT_GULIMCHE,12, 240, 90, 90, 255,  0,  0,0,0,255);
			textWindow:addTextExtends(CommatoMoneyStr(price), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
		else
			textWindow:setTextExtends(CommatoMoneyStr(price), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
		end
	else
		textWindow:setTextExtends("5000~10000", g_STRING_FONT_GULIMCHE,12, 255, 255, 255,255,  0,  0,0,0,255);
	end
end


-- 아이템의 구입버튼이 눌렸을때 이벤트
function ClickedTownStoreItemBuy(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local buttonIndex = tonumber(eventwindow:getUserString("ButtonIndex"))
	local count = 1	-- 일단 1로
	RequestPurchaseItemCheck(buttonIndex, count, COUNT_INPUT)
end

-- 내 아이템 리스트를 보여준다.
function ShowTownStore()
	TownStoreRefresh()		-- 상점 세팅	
	ShowCommonBagFrame()	-- 가방 세팅
	winMgr:getWindow("TownStore_MainAlpha"):setVisible(true)
end


-- 닫는다.
function CloseTownStore()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TownStore_MainAlpha"):setVisible(false)
	if winMgr:getWindow("randomItemItemListBack"):isVisible() then
		HideRandomOpenItem()
	end
	
	-- 임시 세일률
	TempSaleVisibleEnd()
end


-- 닫는다.
function CloseTownStoreButtonEvent()
	VirtualImageSetVisible(false)
	winMgr:getWindow("TownStore_MainAlpha"):setVisible(false)
	TownNpcEscBtnClickEvent()
	if winMgr:getWindow("randomItemItemListBack"):isVisible() then
		HideRandomOpenItem()
	end
	
	-- 임시 세일률
	TempSaleVisibleEnd()
end





--============================= 수량입력 이미지 시작 =============================
-- 수량입력 이미지 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_InputCountImgAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 수량입력 뒷판
local inputCountWindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_InputCountImg")
inputCountWindow:setTexture("Enabled", "UIData/deal2.tga", 307, 494)
inputCountWindow:setWideType(6);
inputCountWindow:setPosition(370, 120)
inputCountWindow:setSize(289, 184)
inputCountWindow:setVisible(true)
inputCountWindow:setAlwaysOnTop(true)
inputCountWindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStore_InputCountImgAlpha"):addChildWindow(inputCountWindow)

RegistEscEventInfo("TownStore_InputCountImgAlpha", "CloseTownStorePurchase_inputCount")


-- 수량 입력 아이템 이름텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_InputCountItemNameText")
mywindow:setPosition(0, 38)
mywindow:setSize(287, 18)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setZOrderingEnabled(false)
inputCountWindow:addChildWindow(mywindow)


-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_InputCountItemImg")
mywindow:setTexture("Disabled", "UIData/nm0.tga", 0, 0)
mywindow:setPosition(18, 63)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(130)
mywindow:setScaleHeight(130)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
inputCountWindow:addChildWindow(mywindow)


-- 아이템 설명
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_InputCountItemDesc")
mywindow:setFont(g_STRING_FONT_DODUM, 11)
mywindow:setTextColor(255,255,255, 255)
mywindow:setPosition(82, 38)
mywindow:setSize(180, 60)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
inputCountWindow:addChildWindow(mywindow)


-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "TownStore_InputCount_editbox")
mywindow:setPosition(192, 124)
mywindow:setSize(45, 18)
mywindow:setAlphaWithChild(0)
mywindow:setAlwaysOnTop(true)	
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setTextColor(255,255,255,255)
mywindow:setSubscribeEvent("EndRender", "TownItemCountCheck")
CEGUI.toEditbox(mywindow):setMaxTextLength(2)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
inputCountWindow:addChildWindow(mywindow)

function OnEditboxFullEvent(args)
	PlayWave('sound/FullEdit.wav')
end


-- 수량 입력 좌우버튼
local CountInputLRButtonName  = {["err"]=0, [0]="TownStore_InputCount_LBtn", "TownStore_InputCount_RBtn"}
local CountInputLRButtonTexX  = {["err"]=0, [0]=889, 905}
local CountInputLRButtonPosX  = {["err"]=0, [0]=169, 260}
local CountInputLRButtonEvent = {["err"]=0, [0]="TownStore_InputCount_LBtnEvent", "TownStore_InputCount_RBtnEvent"}
for i=0, #CountInputLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", CountInputLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", CountInputLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", CountInputLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", CountInputLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", CountInputLRButtonTexX[i], 172)
	mywindow:setPosition(CountInputLRButtonPosX[i], 125)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", CountInputLRButtonEvent[i])
	inputCountWindow:addChildWindow(mywindow)
end



-- 가격변동값 적어주는 뒷판
-- 수량입력 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_MoneyFluctuationImg")
mywindow:setTexture("Enabled", "UIData/deal2.tga", 0, 676)
mywindow:setWideType(6);
mywindow:setPosition(370, 303)
mywindow:setSize(289, 137)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStore_InputCountImgAlpha"):addChildWindow(mywindow)





-- 교환할 아이템 갯수 적어주는 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_ItemFluctuationImg")
mywindow:setTexture("Enabled", "UIData/deal2.tga", 0, 813)
mywindow:setWideType(6);
mywindow:setPosition(370, 439)
mywindow:setSize(289, 211)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStore_InputCountImgAlpha"):addChildWindow(mywindow)


local Max_Money_Type = 3
for i=0, Max_Money_Type-1 do
	-- 아이템 설명
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_NeedPriceText"..i)
	mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 813)
	mywindow:setFont(g_STRING_FONT_DODUM, 11)
	mywindow:setTextColor(255,255,255, 255)
	mywindow:setPosition(94, 57 + i*24)
	mywindow:setSize(94, 20)
	mywindow:setText("asdasdsa")
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_MoneyFluctuationImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_RemainMoneyText"..i)
	mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 813)
	mywindow:setFont(g_STRING_FONT_DODUM, 11)
	mywindow:setTextColor(255,255,255, 255)
	mywindow:setPosition(190, 57 + i*24)
	mywindow:setSize(90, 20)
	mywindow:setEnabled(false)
	mywindow:setText("asdasdsa")
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_MoneyFluctuationImg"):addChildWindow(mywindow)
	
end

--아이템
local Max_Item_Type = 6
for i=0, Max_Item_Type-1 do
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_NeedCountItemImg"..i)
	mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 0)
	mywindow:setPosition(10, 56 + i*24)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(52)
	mywindow:setScaleHeight(52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_ItemFluctuationImg"):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_NeedCountItemEventImg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(10, 56 + i*24)
	mywindow:setSize(21, 21)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_NeedCountItem")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_NeedCountItem")
	winMgr:getWindow("TownStore_ItemFluctuationImg"):addChildWindow(mywindow)


	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_NeeditemNameText"..i)
	mywindow:setFont(g_STRING_FONT_DODUM, 11)
	mywindow:setTextColor(255,255,255, 255)
	mywindow:setPosition(36, 58 + i*24)
	mywindow:setSize(78, 20)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_ItemFluctuationImg"):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_NeedCountText"..i)
	mywindow:setFont(g_STRING_FONT_DODUM, 11)
	mywindow:setTextColor(255,255,255, 255)
	mywindow:setPosition(120, 58 + i*24)
	mywindow:setSize(78, 20)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_ItemFluctuationImg"):addChildWindow(mywindow)
	
	-- 아이템 남는 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_RemainCountText"..i)
	mywindow:setFont(g_STRING_FONT_DODUM, 11)
	mywindow:setTextColor(255,255,255, 255)
	mywindow:setPosition(202, 58 + i*24)
	mywindow:setSize(78, 20)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TownStore_ItemFluctuationImg"):addChildWindow(mywindow)
end



function OnMouseEnter_NeedCountItem(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index		  = tonumber(EnterWindow:getUserString("Index"))
	
	if index == -1 then
		return
	end						-- 아이템 번호
	local itemKind = tPayItemTable[index][3]			-- 아이템 종류
	
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
	GetToolTipBaseInfo(x + 20, y, 2, Kind, 0, tPayItemTable[index][2]	)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
end


function OnMouseLeave_NeedCountItem(args)
	SetShowToolTip(false)
end








--[[

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStore_InputPayTypeImg")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 788)
mywindow:setPosition(132, 128)
mywindow:setSize(19, 19)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
inputCountWindow:addChildWindow(mywindow)


-- 아이템 수량에따른 가격
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_InputCountPrice")
mywindow:setFont(g_STRING_FONT_DODUM, 11)
mywindow:setTextColor(255,255,255, 255)
mywindow:setPosition(170, 129)
mywindow:setSize(118, 18)
mywindow:setText("973,894,329")
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
inputCountWindow:addChildWindow(mywindow)
--]]

-- 수량입력 좌버튼 이벤트
function TownStore_InputCount_LBtnEvent()
	if SavingCount <= 1 then
		return
	end
	local Check = CheckNumber(SavingCount)
	if Check == false then
		return
	end
	SavingCount = SavingCount - 1
	winMgr:getWindow("TownStore_InputCount_editbox"):setText(SavingCount)	
end


-- 수량입력 우버튼 이벤트
function TownStore_InputCount_RBtnEvent()
	if SavingCount >= 99 then
		return
	end
	local Check = CheckNumber(SavingCount)
	if Check == false then
		return
	end
	SavingCount = SavingCount + 1
	winMgr:getWindow("TownStore_InputCount_editbox"):setText(SavingCount)	
end


-- 랜더로 돌면서 에디트 박스의 카운트를 세어주자.
function TownItemCountCheck(args)
	local CountText = winMgr:getWindow("TownStore_InputCount_editbox"):getText()
	local Check = CheckNumber(SavingCount)
	if Check == false then
		winMgr:getWindow("TownStore_InputCount_editbox"):setText("0")
		--winMgr:getWindow("TownStore_InputCountPrice"):setText("0")
		CountText = 0
	end
	
	local Count	= 0
	if CountText == "" or CountText == 0 then
		Count = 0
	else
		Count = tonumber(CountText)
	end
	SavingCount = Count
	
	local tBufTable = {['err']=0, [0] = SavingCount * tMoneyTable[0], SavingCount * tMoneyTable[1], SavingCount * tMoneyTable[2]}
	SettingInputItemPayMoney(tBufTable)
	
	for i=0, MAX_SELL_COST_ITEM-1 do
		SettingItemPayRender(i, tPayItemTable[i][4] * SavingCount)
	end
	
--	if SavePayValue*SavingCount > 0 then
--		local r, g, b	= ColorToMoney(SavePayValue*SavingCount)
--		winMgr:getWindow("TownStore_InputCountPrice"):setTextColor(r, g, b, 255)
--		winMgr:getWindow("TownStore_InputCountPrice"):setText(CommatoMoneyStr(SavePayValue*SavingCount))
--	end	
end

-- 수량 입력 윈도우 확인 취소버튼
local CountInputButtonName	= {["protecterr"]=0, "TownStore_InputCount_OkBtn", "TownStore_InputCount_CancelBtn" }
local CountInputButtonTexX	= {['protecterr']=0,		813,			732}
local CountInputButtonPosX	= {['protecterr']=0,		116,			202}
local CountInputButtonEvent	= {["protecterr"]=0, "TownStore_InputCount_OK", "TownStore_InputCount_CANCEL" }

for i=1, #CountInputButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", CountInputButtonName[i])
	mywindow:setTexture("Normal", "UIData/Profile001.tga", CountInputButtonTexX[i],  324)
	mywindow:setTexture("Hover", "UIData/Profile001.tga", CountInputButtonTexX[i], 351)
	mywindow:setTexture("Pushed", "UIData/Profile001.tga", CountInputButtonTexX[i], 378)
	mywindow:setTexture("PushedOff", "UIData/Profile001.tga", CountInputButtonTexX[i], 378)
	mywindow:setPosition(CountInputButtonPosX[i], 153)
	mywindow:setSize(81, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", CountInputButtonEvent[i])
	inputCountWindow:addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/Button", "TownStore_InputCount_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(265, 3)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "TownStore_InputCount_CANCEL")
inputCountWindow:addChildWindow(mywindow)

-- 수량 입력확인버튼
function TownStore_InputCount_OK()
	if SavingCount <= 0 then
		ShowNotifyOKMessage_Lua(PreCreateString_2418)	--GetSStringInfo(LAN_INPUT_ITEM_COUNT)
		return
	end
	CloseTownStorePurchase_inputCount()
	RequestPurchaseItemCheck(SavingIndex, SavingCount, CONFIRM_MESSAGE)
end


-- 수량 입력 취소버튼
function TownStore_InputCount_CANCEL()
	CloseTownStorePurchase_inputCount()
end


-- 수량입력 윈도우를 닫아준다.
function CloseTownStorePurchase_inputCount()
	winMgr:getWindow("TownStore_InputCountImgAlpha"):setVisible(false)		
end


-- 수량입력 윈도우를 띄워준다.
function ShowTownStorePurchase_inputCount(itemName, itemFileName, itemFileName2, Desc, index, count, payType, payValue, zen, cash, coin)--buttonIndex)
	winMgr:getWindow("TownStore_InputCount_editbox"):setText("1")
	winMgr:getWindow("TownStore_InputCount_editbox"):activate()
	winMgr:getWindow("TownStore_InputCountImgAlpha"):setVisible(true)
	winMgr:getWindow("TownStore_InputCountItemNameText"):setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 255,198,30,255,   0, 255,255,255,255)		
	winMgr:getWindow("TownStore_InputCountItemImg"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("TownStore_InputCountItemImg"):setLayered(false)
	else
		winMgr:getWindow("TownStore_InputCountItemImg"):setLayered(true)
		winMgr:getWindow("TownStore_InputCountItemImg"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	
	local string = AdjustString(g_STRING_FONT_GULIM, 11, Desc, 185)
	winMgr:getWindow("TownStore_InputCountItemDesc"):setText(string)
	
	-- 아이템 가격(돈) 적용
	if payType == 3 then
		zen = -1
	end
	tMoneyTable = {['err']=0, [0]=zen, coin, cash}
	SettingInputItemPayMoney(tMoneyTable)
	
	
	-- 아이템 가격(아이템) 적용
	for i=0, MAX_SELL_COST_ITEM-1 do
		tPayItemTable[i][0], tPayItemTable[i][1], tPayItemTable[i][2], tPayItemTable[i][3], tPayItemTable[i][4], tPayItemTable[i][6] = GetTownStorePayItemInfo(index, i)
		tPayItemTable[i][5] = GetMoneyorItemValue(1, tPayItemTable[i][2])
		tPayItemTable[i][1] = SummaryString(g_STRING_FONT_DODUM, 11, tPayItemTable[i][1], 45)
		SettingInputItemPayItem(i)
	end
	
	SavePayValue = payValue
	SavingIndex  = index
	SavingCount  = 1
end


-- 수량 입력 윈도우에 돈에 관련한 정보를 세팅해준다.
function SettingInputItemPayMoney(tMoneyTable)--zen, cash, coin)
	for i=0, #tMoneyTable do
		if tMoneyTable[i] > 0 then
			local r, g, b	= ColorToMoney(tMoneyTable[i])
			winMgr:getWindow("TownStore_NeedPriceText"..i):setTextColor(r, g, b, 255)
			winMgr:getWindow("TownStore_NeedPriceText"..i):setText(CommatoMoneyStr(tMoneyTable[i]))
		elseif tMoneyTable[i] == 0 then
			winMgr:getWindow("TownStore_NeedPriceText"..i):setTextColor(255,255,255,255)
			winMgr:getWindow("TownStore_NeedPriceText"..i):setText("-")		
		else
			winMgr:getWindow("TownStore_NeedPriceText"..i):setTextColor(255,255,255,255)
			winMgr:getWindow("TownStore_NeedPriceText"..i):setText("5000~10000")		
		end	
		
		
		if i == 0 then
			local money = GetInvenMyMoneyCalc()
			
			if tMoneyTable[i] > 0 then
				money = GetInvenMyMoneyCalc(-tMoneyTable[i])
			else
				money = GetInvenMyMoney()
			end
			
			local r, g, b	= GetGranColor(money)
			--[[if remainMoney < 0 then
				r = 225
				g = 26
				b = 40
			end]]
			winMgr:getWindow("TownStore_RemainMoneyText"..i):setTextColor(r, g, b, 255)
			winMgr:getWindow("TownStore_RemainMoneyText"..i):setText(CommatoMoneyStr64(money))
		else
			local value = GetMoneyorItemValue(0, i)
			local remainMoney = value
			if tMoneyTable[i] > 0 then
				remainMoney = value - tMoneyTable[i]
			end
			
			local r, g, b	= ColorToMoney(remainMoney)
			if remainMoney < 0 then
				r = 225
				g = 26
				b = 40
			end
			winMgr:getWindow("TownStore_RemainMoneyText"..i):setTextColor(r, g, b, 255)
			winMgr:getWindow("TownStore_RemainMoneyText"..i):setText(CommatoMoneyStr(remainMoney))
		end
	end
end


function SetTownStore_PayItem()
	
	
end

-- 수량 입력 윈도우에 아이템에 관련한 정보를 세팅해준다
function SettingInputItemPayItem(index)--, itemFileName, itemKind, itemNumber, itemValue)
	if tPayItemTable[index][2] > 0 then	-- 아이템 번호가 들어있다(아이템 정보가 들어있다)
		-- 아이템 이미지 축소시킨다.
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setSize(100, 100)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setScaleWidth(52)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setScaleHeight(52)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setTexture("Disabled", tPayItemTable[index][0], 0, 0)	-- 아이템 파일적용	
		
		if tPayItemTable[index][6] == "" then
			winMgr:getWindow("TownStore_NeedCountItemImg"..index):setLayered(false)
		else
			winMgr:getWindow("TownStore_NeedCountItemImg"..index):setLayered(true)
			winMgr:getWindow("TownStore_NeedCountItemImg"..index):setTexture("Layered", tPayItemTable[index][6], 0, 0)	-- 아이템 파일적용	
		end
		
		
		
		winMgr:getWindow("TownStore_NeedCountItemEventImg"..index):setUserString("Index", index)	-- 마우스 이벤트 위해..
		winMgr:getWindow("TownStore_NeeditemNameText"..index):setText(tPayItemTable[index][1])			-- 아이템 이름
		winMgr:getWindow("TownStore_NeedCountText"..index):setText(tPayItemTable[index][4])				-- 아이템 요구 수량
		local r = 255
		local g = 255
		local b = 255
		local remainValue = tPayItemTable[index][5] - tPayItemTable[index][4]
		if remainValue < 0 then
			r = 225
			g = 26
			b = 40
		end
		winMgr:getWindow("TownStore_RemainCountText"..index):setTextColor(r, g, b, 255)
		winMgr:getWindow("TownStore_RemainCountText"..index):setText(CommatoMoneyStr(remainValue))
				
	else
		-- 빈 이미지
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setSize(19, 19)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setScaleWidth(255)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setScaleHeight(255)
		winMgr:getWindow("TownStore_NeedCountItemImg"..index):setTexture("Disabled", "UIData/deal2.tga", 659, 53)
		
		winMgr:getWindow("TownStore_NeedCountItemEventImg"..index):setUserString("Index", tostring(-1))
		winMgr:getWindow("TownStore_NeeditemNameText"..index):setText(" -")
		winMgr:getWindow("TownStore_NeedCountText"..index):setText("-")
		winMgr:getWindow("TownStore_RemainCountText"..index):setTextColor(255, 255, 255, 255)
		winMgr:getWindow("TownStore_RemainCountText"..index):setText("-")
		
	end
end


function SettingItemPayRender(index, value)
	if tPayItemTable[index][2] > 0 then
		local r = 255
		local g = 255
		local b = 255
		local remainValue = tPayItemTable[index][5] - value
		if remainValue < 0 then
			r = 225
			g = 26
			b = 40
		end
		winMgr:getWindow("TownStore_NeedCountText"..index):setText(value)
		winMgr:getWindow("TownStore_RemainCountText"..index):setTextColor(r, g, b, 255)
		winMgr:getWindow("TownStore_RemainCountText"..index):setText(CommatoMoneyStr(tPayItemTable[index][5]))
	else
		winMgr:getWindow("TownStore_NeedCountText"..index):setText("-")
		winMgr:getWindow("TownStore_RemainCountText"..index):setTextColor(255, 255, 255, 255)
		winMgr:getWindow("TownStore_RemainCountText"..index):setText("-")
	end


end



--============================== 수량입력 이미지 끝 ==============================






--============================= 구입확인 이미지 시작 =============================
-- 구입확인 이미지 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStorePurchaseImgAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 구입버튼을 눌렀을때 확인창
local TownStorePurchaseWindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStorePurchaseImg")
TownStorePurchaseWindow:setTexture("Enabled", "UIData/deal2.tga", 307, 276)
TownStorePurchaseWindow:setWideType(6);
TownStorePurchaseWindow:setPosition((1024 - 332)/2, (768 - 218)/2)
TownStorePurchaseWindow:setSize(332, 218)
TownStorePurchaseWindow:setVisible(true)
TownStorePurchaseWindow:setAlwaysOnTop(true)
TownStorePurchaseWindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStorePurchaseImgAlpha"):addChildWindow(TownStorePurchaseWindow)

RegistEscEventInfo("TownStorePurchaseImgAlpha", "TownStorePurchase_CANCEL")


-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStorePurchaseitemName")
mywindow:setPosition(0, 52)
mywindow:setSize(332, 18)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStorePurchaseImg"):addChildWindow(mywindow)

-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStorePurchaseitemImg")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(18, 79)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(130)
mywindow:setScaleHeight(130)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStorePurchaseImg"):addChildWindow(mywindow)


-- 아이템 설명
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStorePurchaseitemDesc")
mywindow:setPosition(80, 75)
mywindow:setSize(226, 60)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(5)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStorePurchaseImg"):addChildWindow(mywindow)


-- 아이템 정말로 구입하시겠습니까?
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStorePurchaseitemDescString")
mywindow:setPosition(0, 160)
mywindow:setSize(332, 40)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStorePurchaseImg"):addChildWindow(mywindow)


local ButtonName	= {["protecterr"]=0, "TownStorePurchase_OkBtn", "TownStorePurchase_CancelBtn" }
local ButtonTexX	= {['protecterr']=0,		813,			732}
local ButtonPosX	= {['protecterr']=0,		150,			236}
local ButtonEvent	= {["protecterr"]=0, "TownStorePurchase_OK", "TownStorePurchase_CANCEL" }

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/Profile001.tga", ButtonTexX[i],  324)
	mywindow:setTexture("Hover", "UIData/Profile001.tga", ButtonTexX[i], 351)
	mywindow:setTexture("Pushed", "UIData/Profile001.tga", ButtonTexX[i], 378)
	mywindow:setTexture("PushedOff", "UIData/Profile001.tga", ButtonTexX[i], 378)
	mywindow:setPosition(ButtonPosX[i], 186)
	mywindow:setSize(81, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow("TownStorePurchaseImg"):addChildWindow(mywindow)
end



function SetPurchaseWindow(itemName, Period, itemFileName, Desc, index, count)
	winMgr:getWindow("TownStorePurchaseImgAlpha"):setVisible(true)
	winMgr:getWindow("TownStorePurchaseitemName"):setTextExtends(itemName..Period, g_STRING_FONT_GULIM, 12, 255,198,30,255,   0, 255,255,255,255)		
	winMgr:getWindow("TownStorePurchaseitemImg"):setTexture("Disabled", itemFileName, 0, 0)
	local string = AdjustString(g_STRING_FONT_GULIM, 11, Desc, 220)
	winMgr:getWindow("TownStorePurchaseitemDesc"):setTextExtends(string, g_STRING_FONT_GULIM, 11, 255,255,255,255,   0, 255,255,255,255)		
	string	= string.format(TownStoreitemString, count)
	winMgr:getWindow("TownStorePurchaseitemDescString"):setTextExtends(string, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)	
	SavingIndex = index
	SavingCount = count
end


-- 구입하기 확인버튼
function TownStorePurchase_OK()
	winMgr:getWindow("TownStorePurchaseImgAlpha"):setVisible(false)
	RequestPurchaseMessage(SavingIndex, SavingCount)
	SavingIndex  = -1
	SavingCount  = 0
	SavePayValue = 0
	
end

-- 창을 닫아준다.
function TownStorePurchase_CANCEL()
	winMgr:getWindow("TownStorePurchaseImgAlpha"):setVisible(false)	
end




-- 구입확인 이미지 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreZoomInItemBackImg")
mywindow:setTexture("Disabled", "UIData/deal2.tga", 639, 276)
mywindow:setPosition(0, 0)
mywindow:setSize(152, 152)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 구입버튼을 눌렀을때 확인창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TownStoreZoomInItemImg")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(4, 7)
mywindow:setSize(100, 100)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setScaleWidth(350)
mywindow:setScaleHeight(350)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TownStoreZoomInItemBackImg"):addChildWindow(mywindow)



function OutputItemImg(x,y,itemNumber,itemKind)	-- 확대된놈 띄워준다.
	local fileName, fileName2 = GetZoomInItemFileName(itemNumber)
	if fileName == "" then
		return
	end
	winMgr:getWindow("TownStoreZoomInItemBackImg"):setPosition(x-30,y)
	winMgr:getWindow("TownStoreZoomInItemBackImg"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("TownStoreZoomInItemBackImg"))
	winMgr:getWindow("TownStoreZoomInItemImg"):setTexture("Disabled", fileName, 0, 0)
	if fileName2 == "" then
		winMgr:getWindow("TownStoreZoomInItemImg"):setLayered(false)
	else
		winMgr:getWindow("TownStoreZoomInItemImg"):setLayered(true)
		winMgr:getWindow("TownStoreZoomInItemImg"):setTexture("Layered", fileName, 0, 0)
	end		
end


function ShowZoomInItem()
	
end


function HideZoomInItem()
	winMgr:getWindow("TownStoreZoomInItemBackImg"):setVisible(false)
end










-- 들어가면 바로 나오는 아이템 구입창






-- 삭제 확인창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'TownStore_DirectPurchaseAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("TownStore_DirectPurchaseAlpha", "TownStorePurchase_DirectCANCEL")
RegistEnterEventInfo("TownStore_DirectPurchaseAlpha", "TownStorePurchase_DirectOk")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'TownStore_DirectPurchaseImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('TownStore_DirectPurchaseAlpha'):addChildWindow(mywindow);

mywindow = winMgr:createWindow("TaharezLook/StaticText", "TownStore_DirectPurchaseText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2537, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
winMgr:getWindow('TownStore_DirectPurchaseImage'):addChildWindow(mywindow);

-- ok버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "TownStore_DirectPurchaseOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "TownStorePurchase_DirectOk")
winMgr:getWindow('TownStore_DirectPurchaseImage'):addChildWindow(mywindow)

-- cancel 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "TownStore_DirectPurchaseCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "TownStorePurchase_DirectCANCEL")
winMgr:getWindow('TownStore_DirectPurchaseImage'):addChildWindow(mywindow)









-- 바로 구입창을 띄워준다.
function ShowTownDirectPurchaseWindow(itemString)

	root:addChildWindow(winMgr:getWindow("TownStore_DirectPurchaseAlpha"))
	winMgr:getWindow("TownStore_DirectPurchaseAlpha"):setVisible(true)
	winMgr:getWindow("TownStore_DirectPurchaseText"):setTextExtends(itemString, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)		

		
end



-- 바로 구입을 한다,
function TownStorePurchase_DirectOk()
	RequestDirectPurchase()
	winMgr:getWindow("TownStore_DirectPurchaseAlpha"):setVisible(false)
	TownNpcEscEventToTownStore()
end


-- 바로 구입을 취소한다,
function TownStorePurchase_DirectCANCEL()
	winMgr:getWindow("TownStore_DirectPurchaseAlpha"):setVisible(false)
	TownNpcEscEventToTownStore()
end











