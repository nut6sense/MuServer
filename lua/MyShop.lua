--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

-- 나의 마이샵 상태
local MYSHOP_MODE_NONE		= 0		-- 일반
local MYSHOP_MODE_READY		= 1		-- 준비중
local MYSHOP_MODE_MODIFY	= 2		-- 설정 변경중
local MYSHOP_MODE_SELLING	= 3		-- 판매중
local MYSHOP_MODE_VISIT		= 4		-- 상점 구경중
local MYSHOP_MODE_BUYING	= 5		-- 구매중

-- 나의 마이샵 목록 리스트 종류
local MYSHOPLIST_COSTUME	= 0
local MYSHOPLIST_ETC		= 1
local MYSHOPLIST_SPECIAL	= 2
local MYSHOPLIST_SKILL		= 3
local g_currentMyShopList	= GetCurrentMyItemMode()
function SetCurrentMyItemModeToMyShop(myItemMode)
	g_currentMyShopList = myItemMode
	
	for i=0, #tMyShopItemListName do
		if winMgr:getWindow(tMyShopItemListName[i]) then
			winMgr:getWindow(tMyShopItemListName[i]):setProperty("Selected", "false")
		end
	end
	
	if winMgr:getWindow(tMyShopItemListName[g_currentMyShopList]) then
		winMgr:getWindow(tMyShopItemListName[g_currentMyShopList]):setProperty("Selected", "true")
	end
end

local WINDOW_MYITEM_LIST = 0
local WINDOW_REGIST_LIST = 1
local WINDOW_SELECT_LIST = 2


local MYSHOP_TYPE_DEFAULT = 0
local MYSHOP_TYPE_SPECIAL = 1
local MYSHOP_TYPE_PREMIUM = 2
local MYSHOP_TYPE_MEGA = 3

-- 현재 나의 마이샵 목록 페이지
local g_curPage_ItemList = 1
local g_maxPage_ItemList = 1

-- 현재 내가 등록한 목록 페이지
local g_curPage_RegistList = 1
local g_maxPage_RegistList = 1

local g_curPage_SellRecord = 1
local g_maxPage_SellRecord = 1

local MAX_ITEMLIST = GetMaxMyItemListNum()			-- 나의 목록 리스트 최대개수
local MAX_REGIST_ITEMLIST = GetMaxRegistListNumMyShop()	-- 나의 등록 리스트 최대개수
local MAX_SELL_RECORDLIST = GetMaxSellRecord()		-- 판매기록 최대개수

--local tGradeferPersent	= {['err'] = 0, 1,2,3,5,7,9,14,20,27,35}	-- 스킬 그레이드에따른 추가데미지 테이블

function SkillDescDivideToMyShop(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--스킬종류
	local _DetailDesc = "";		--스킬설명
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
	else
		_DetailDesc = str
	end
	
	return _SkillKind, _DetailDesc
end


-- 가격 입력 에디트박스 제한
function LimitGranEditbox()

	local limit = 99999999
	
	if IsSpecialMyShopMode() == MYSHOP_TYPE_MEGA then
		limit = 500000000
	end
	
	local text = CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):getText()
	
	if text ~= "" then
		local price = tonumber(text)
		
		if price > limit then
			winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText(limit)
		end
	end
end

--------------------------------------------
-- 서버에서 마이샵에 관해 업데이트를 받는다.(판매할 때만 설정한다.)
--------------------------------------------
function UpdateMyShopState(currentMyShopState)
	
	-- 1. 일반상태
	if currentMyShopState == MYSHOP_MODE_NONE then
		RequestItemListToMyShop()
	-- 2. 아이템샵 준비중일 때
	elseif currentMyShopState == MYSHOP_MODE_READY or currentMyShopState == MYSHOP_MODE_MODIFY then
		
		-- 아이템 정보를 서버에 요청(내아이템 목록, 인벤토리 아이템 목록)
		RequestItemListToMyShop()
		SetupMyShopWindows(true)
		
		-- 판매를 위해 샵을 열경우 "마이샵"
		winMgr:getWindow("sj_MyShopRegistItemList_shopName"):setTextExtends(PreCreateString_1534, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)

	-- 3. 아이템샵 판매를 시작할 때
	elseif currentMyShopState == MYSHOP_MODE_SELLING then
	
		-- 1. 알파윈도우를 숨긴다.
		winMgr:getWindow("sj_MyShopAlphaImage"):setVisible(false)
		
		-- 2. 나의 목록윈도우를 숨긴다.
		winMgr:getWindow("sj_MyShopItemListBackImage"):setVisible(false)
		
		-- 3. 모든 버튼을 숨긴다.
		for i=0, MAX_REGIST_ITEMLIST-1 do
			winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(false)
		end
		
		-- 4. 셀시작 버튼을 변경버튼으로 바꾼다.
		RequestItemListToMyShop()
		SetMyShopSellStartBtn(true)
	end
end


-- 파티 생성및 NPC 대화때 마이샵 생성버튼이 보일지, 안보일지를 설정
function SetMyShopCreateBtn(bFlag)

	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		--bFlag = false
	end
	if winMgr:getWindow("MyInven_MyshopButton") then
		winMgr:getWindow("MyInven_MyshopButton"):setEnabled(bFlag)
		--winMgr:getWindow("MyInven_MyshopButton"):setVisible(bFlag)
	end
	
	
--[[	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if winMgr:getWindow("MainBar_MyShop") then
			winMgr:getWindow("MainBar_MyShop"):setEnabled(bFlag)
		end
	end	
	
	if IsMasLanguage() then
		if winMgr:getWindow("MainBar_MyShop") then
			winMgr:getWindow("MainBar_MyShop"):setEnabled(bFlag)
		end
	end	]]
end






-----------------------------------------------------------

-- 백그라운드 알파 이미지

-----------------------------------------------------------
-- 메세지 알파 이미지
myShopAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopAlphaImage")
myShopAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
myShopAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
myShopAlphaWindow:setProperty("FrameEnabled", "False")
myShopAlphaWindow:setProperty("BackgroundEnabled", "False")
myShopAlphaWindow:setPosition(0, 0)
myShopAlphaWindow:setSize(1920, 1200)
myShopAlphaWindow:setVisible(false)
myShopAlphaWindow:setAlwaysOnTop(true)
myShopAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(myShopAlphaWindow)


-- 상점 윈도우창 업데이트
function SetupMyShopWindows(bVisible, ...)
	---------------------------
	-- 마이샵을 열때 설정
	---------------------------
	if bVisible then
	
		-- 1. 상점을 내가 팔려고 열경우
		local myShopState = GetMyShopState()
		if myShopState == MYSHOP_MODE_NONE   or myShopState == MYSHOP_MODE_READY   or
		   myShopState == MYSHOP_MODE_MODIFY or myShopState == MYSHOP_MODE_SELLING then
			DebugStr("상점열기")
			
			OnClickWriteClose()  -- 상점을 열경우 메일쓰기함을 닫아준다
			root:addChildWindow(winMgr:getWindow("sj_MyShopAlphaImage"))
			root:addChildWindow(winMgr:getWindow("sj_MyShopItemListBackImage"))
			root:addChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
			root:addChildWindow(winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"))
			root:addChildWindow(winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"))
			winMgr:getWindow("sj_MyShopAlphaImage"):addChildWindow(winMgr:getWindow("sj_ClosedMyShopBtn"))
			--winMgr:getWindow("MyInven_MyshopButton"):setVisible(false)
			winMgr:getWindow("MyInven_MyshopButton"):setEnabled(false)
			--winMgr:getWindow("MainBar_MyShop"):setEnabled(false)
			winMgr:getWindow("sj_MyShopAlphaImage"):setVisible(true)
			winMgr:getWindow("sj_MyShopItemListBackImage"):setVisible(true)
			winMgr:getWindow("sj_RegistMyShopBackImage"):setVisible(true)
			
			-- 판매기록, 도움말 버튼 true
			winMgr:getWindow("sj_RegistMyShopSellRecordBtn"):setVisible(true)
			winMgr:getWindow("sj_RegistMyShopHelpBtn"):setVisible(true)
			winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(true)
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
					
			-- 셀시작 버튼 true
			winMgr:getWindow("sj_MyShopSellStartBtn"):setVisible(true)					

		-- 2. 내가 상점을 방문할 경우
		elseif myShopState == MYSHOP_MODE_VISIT then
			DebugStr("상점열기2")
			root:addChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
			winMgr:getWindow("sj_RegistMyShopBackImage"):setVisible(true)
			
			winMgr:getWindow("sj_MyShopAlphaImage"):addChildWindow(winMgr:getWindow("sj_ClosedMyShopBtn"))
			--winMgr:getWindow("MyInven_MyshopButton"):setVisible(false)
			winMgr:getWindow("MyInven_MyshopButton"):setEnabled(false)
			--winMgr:getWindow("MainBar_MyShop"):setEnabled(false)
			
			-- 판매기록, 도움말 버튼 false
			winMgr:getWindow("sj_RegistMyShopSellRecordBtn"):setVisible(false)
			winMgr:getWindow("sj_RegistMyShopHelpBtn"):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
			
			-- 셀시작 버튼 false
			winMgr:getWindow("sj_MyShopSellStartBtn"):setVisible(false)
			
			-- 팝업 뒤로 넘어가는 문제 수정
			if winMgr:getWindow('sj_myshop_OkBox'):isVisible() then
				root:addChildWindow(winMgr:getWindow('sj_myshop_OkBox'))
			end
		end
	
	----------------------------
	-- 마이샵을 닫을 때 설정
	----------------------------
	else	
		-- 1. 알파 윈도우 닫고, 마이샵 생성버튼을 보이게 한다.
		winMgr:getWindow("sj_MyShopAlphaImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopItemListBackImage"):setVisible(false)
		winMgr:getWindow("sj_RegistMyShopBackImage"):setVisible(false)
		
		for i=0, MAX_REGIST_ITEMLIST-1 do
			winMgr:getWindow("sj_MyShopRegistItemList_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(false)
		end
		
		root:removeChildWindow(winMgr:getWindow("sj_MyShopAlphaImage"))
		root:removeChildWindow(winMgr:getWindow("sj_MyShopItemListBackImage"))
		root:removeChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
		root:removeChildWindow(winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"))
		
		local recordVisible = false
		if select(1, ...) ~= nil then
			recordVisible = select(1, ...)
		end		
		if recordVisible == false then
			root:removeChildWindow(winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"))
		end
		
		ClickedSellInputClose()	
		
		if IsPartyJoined() then
			SetMyShopCreateBtn(false)
		else
			SetMyShopCreateBtn(true)
		end
		
		-- 2. 판매시작 버튼 관련작업(다시 시작했을 때를 위해)
		SetMyShopSellStartBtn(false)
					
		-- 3. 나의 상점 이름 초기화
		winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setText("")
		
		winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText("")
		
		-- 판매기록, 도움말 false
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
		
		if recordVisible == false then
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)	
		end
	
		SetShowToolTip(false)
		HideAnimationWindow()	
	end
end






-------------------------------------------------------------

-- 1. 마이샵에 판매할 아이템 등록창

-------------------------------------------------------------
myShopRegistWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RegistMyShopBackImage")

myShopRegistWindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0 , 0)
myShopRegistWindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0 , 0)
myShopRegistWindow:setframeWindow(true)

myShopRegistWindow:setProperty("FrameEnabled", "False")
myShopRegistWindow:setProperty("BackgroundEnabled", "False")
myShopRegistWindow:setWideType(6)
myShopRegistWindow:setPosition(40, 170)
myShopRegistWindow:setSize(599, 534)
myShopRegistWindow:setAlwaysOnTop(true)
myShopRegistWindow:setVisible(false)
myShopRegistWindow:setZOrderingEnabled(false)
root:addChildWindow(myShopRegistWindow)

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_RegistMyShopBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(564, 30)
myShopRegistWindow:addChildWindow(mywindow)

-- 판매할 때는 마이샵, 구매할 때는 %s님의 마이샵
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_shopName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(200, 12)
mywindow:setSize(230, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 판매 / 판매가능
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_SellInfo")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(20, 20)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 상점 제목 입력창 배경
-- 이미지가 분할되어 있으므로 두개의 윈도우가 필요하다
-- 제목 입력창 배경 1
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_TitleImage1")
mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 0)
mywindow:setPosition(15, 46)
mywindow:setSize(512, 42)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
myShopRegistWindow:addChildWindow(mywindow)

-- 제목 입력창 배경 2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_TitleImage2")
mywindow:setTexture("Enabled", "UIData/deal3.tga", 304, 42)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 304, 42)
mywindow:setPosition(527, 46)
mywindow:setSize(57, 42)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
myShopRegistWindow:addChildWindow(mywindow)

-- 도움말 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_RegistMyShopHelpBtn")

mywindow:setTexture("Normal", "UIData/deal3.tga", 371, 259)
mywindow:setTexture("Hover", "UIData/deal3.tga", 371, 283)
mywindow:setTexture("Pushed", "UIData/deal3.tga", 371, 307)
mywindow:setTexture("PushedOff", "UIData/deal3.tga", 371, 331)

mywindow:setPosition(380, 56)
mywindow:setSize(74, 24)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedShowMyShopHelp")
myShopRegistWindow:addChildWindow(mywindow)


-- 도움말 버튼을 클릭한다.
function ClickedShowMyShopHelp()
	local isHelpImageVisible = winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):isVisible()
	if isHelpImageVisible then
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
	else
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(true)
	end
end

-- 그랑 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_GranImage")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")

mywindow:setPosition(16, 502)

mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 현재 나의 그랑
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)

mywindow:setPosition(44, 502)

mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_RegistMyShopClosedBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(568, 8)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedAskMyShopClose")
myShopRegistWindow:addChildWindow(mywindow)


-- 닫기버튼 클릭(상점중:물어본다, 방문중:그냥 닫는다)
function ClickedAskMyShopClose()

	-- 내가 현재 방문중일 때는 그냥 닫는다.
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_VISIT or myShopState == MYSHOP_MODE_BUYING then
		RequestMyShopClosed()
		SetupMyShopWindows(false)
		
	-- 상점중일때는 마이샵을 닫으시겠습니까? 물어본다.
	else
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1510, 'OnClickClosedRegistMyShopOk', 'OnClickClosedRegistMyShopCancel')
	end
end

-- ESC등록
RegistEscEventInfo("sj_RegistMyShopBackImage", "ClickedAskMyShopClose")


-- 마이샵을 닫는다.
function OnClickClosedRegistMyShopOk(args)
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickClosedRegistMyShopOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 마이샵을 진짜로 닫는다.
	local myShopState = GetMyShopState()
	if myShopState > MYSHOP_MODE_NONE then
		RequestMyShopClosed()
		SetupMyShopWindows(false, false)
	end	
end


-- 마이샵 닫는걸 취소한다.
function OnClickClosedRegistMyShopCancel(args)	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickClosedRegistMyShopCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end




-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(268, 504)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tMyShopRegistItemList_BtnName  = {["err"]=0, [0]="sj_MyShopRegistItemList_LBtn", "sj_MyShopRegistItemList_RBtn"}
local tMyShopRegistItemList_BtnTexX  = {["err"]=0, [0]=987, 970}
local tMyShopRegistItemList_BtnPosX  = {["err"]=0, [0]=250, 350}
local tMyShopRegistItemList_BtnEvent = {["err"]=0, [0]="OnClickMyShopRegistItemList_PrevPage", "OnClickMyShopRegistItemList_NextPage"}
for i=0, #tMyShopRegistItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyShopRegistItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyShopRegistItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyShopRegistItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyShopRegistItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyShopRegistItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyShopRegistItemList_BtnPosX[i], 502)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyShopRegistItemList_BtnEvent[i])
	myShopRegistWindow:addChildWindow(mywindow)
end


function OnClickMyShopRegistItemList_PrevPage()
	if g_curPage_RegistList > 1 then
		g_curPage_RegistList = g_curPage_RegistList - 1
		ChangedRegistItemListCurrentPage(g_curPage_RegistList)
	end
end

function OnClickMyShopRegistItemList_NextPage()
	if g_curPage_RegistList < g_maxPage_RegistList then
		g_curPage_RegistList = g_curPage_RegistList + 1
		ChangedRegistItemListCurrentPage(g_curPage_RegistList)
	end
end

-- 상점 입력이 완료될 경우 보여짐(아래 제목 입력창이라 서로 보이고, 안보이고 한다)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_TitleText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(118, 58)
mywindow:setSize(210, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- 상점 제목 입력창
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyShopRegistItemList_TitleEditbox")
mywindow:setPosition(118, 58)
mywindow:setSize(210, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
CEGUI.toEditbox(mywindow):setMaxTextLength(46)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
myShopRegistWindow:addChildWindow(mywindow)

-- 판매시작
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellStartBtn")

mywindow:setTexture("Normal", "UIData/deal3.tga", 382, 43)
mywindow:setTexture("Hover", "UIData/deal3.tga", 382, 73)
mywindow:setTexture("Pushed", "UIData/deal3.tga", 382, 103)
mywindow:setTexture("PushedOff", "UIData/deal3.tga", 382, 43)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 382, 133)

mywindow:setPosition(460, 494)

mywindow:setSize(130, 30)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedStartMyShop")
myShopRegistWindow:addChildWindow(mywindow)

-- 판매시작 버튼을 눌렀을 때(판매중일 때 누르면 설정변경이 됨)
function ClickedStartMyShop()
	
	-- 준비중일 때는 판매요청을 한다.
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_READY then
	
		local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
		if CheckMyShopTitle(myShopTitle) then
			
			-- 현재 스페샬샵일 경우 "마이샵을 개설하시겠습니까?"
			local myShopType = IsSpecialMyShopMode()
			if myShopType ~= MYSHOP_TYPE_DEFAULT then
				ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1094, 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
			else
				-- 수수료로 %d그랑이 결제됩니다.\n마이샵을 개설하시겠습니까?
				local FEE = GetMyShopFEE()
				ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_1493, FEE), 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
			end		
		end
	
	-- 설정변경중에서 판매시작을 누를경우 "마이샵을 개설하시겠습니까?"
	elseif myShopState == MYSHOP_MODE_MODIFY then
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1094, 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
	
	-- 현재 판매중일 때는 다시 준비중으로 변경한다.
	-- 설정변경을 눌렀을 경우
	elseif myShopState == MYSHOP_MODE_SELLING then
	
		-- 마이샵을 다시 설정하시겠습니까? 
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1132, 'OnClickMyShopRefreshOk', 'OnClickMyShopRefreshCancel')
	end
end

--------------------------------
-- 1. 마이샵을 개설
function OnClickMyShopStartOk()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopStartOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 마이샵을 개설하겠다고 메세지를 보낸다.
	local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
	StartMyShop(myShopTitle)
end

-- 마이샵 개설취소
function OnClickMyShopStartCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopStartCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end



--------------------------------
-- 2.마이샵 설정변경
function OnClickMyShopRefreshOk()
	DebugStr("OnClickMyShopRefreshOkOnClickMyShopRefreshOkOnClickMyShopRefreshOkOnClickMyShopRefreshOk")
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopRefreshOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 설정변경을 ok할경우
	RequestMyShopChanged()	-- 서버에 준비중으로 메세지 보내고
	root:addChildWindow(winMgr:getWindow("sj_MyShopAlphaImage"))
	root:addChildWindow(winMgr:getWindow("sj_MyShopItemListBackImage"))
	root:addChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(true)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(false)
end

-- 마이샵 설정변경 취소
function OnClickMyShopRefreshCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopRefreshCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end



-- 판매시작이 정상적으로 될경우
function UpdateStartMyShop()	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(false)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(true)
	
	local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
	local summaryTitle = SummaryString(g_STRING_FONT_GULIMCHE, 12, myShopTitle, 170)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText(summaryTitle)
	
	-- 도움말을 false한다.
	winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
end

-- 변경 668 (bEnable = false지우고, 아래 주석푼다)
-- 준비중일때는 판매시작, 현재 판매중일때는 설정변경으로 변경한다.
function SetMyShopSellStartBtn(bEnable)
	
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Normal", "UIData/deal3.tga", 382, 43)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Hover", "UIData/deal3.tga", 382, 73)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Pushed", "UIData/deal3.tga", 382, 103)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("PushedOff", "UIData/deal3.tga", 382, 43)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Disabled", "UIData/deal3.tga", 382, 133)
		
	elseif myShopState == MYSHOP_MODE_SELLING then
		bEnable = false
		--[[
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Normal", "UIData/deal.tga", 738, 343)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Hover", "UIData/deal.tga", 738, 372)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Pushed", "UIData/deal.tga", 738, 401)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("PushedOff", "UIData/deal.tga", 738, 343)
		winMgr:getWindow("sj_MyShopSellStartBtn"):setTexture("Disabled", "UIData/deal.tga", 738, 430)
		--]]
	end
	
	winMgr:getWindow("sj_MyShopSellStartBtn"):setEnabled(bEnable)
end


-- 아이템 리스트 슬롯 백판이미지
for i=0, MAX_REGIST_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_BackBoard_"..i)
	mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 42)
	mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 42)
	mywindow:setPosition(11+((i%2)*289), ((i/2)*100)+90)
	mywindow:setSize(287, 98)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	myShopRegistWindow:addChildWindow(mywindow)
end


-- 아이템 리스트 판매목록
for i=0, MAX_REGIST_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_MyShopRegistItemList_"..i)
	mywindow:setTexture("Normal", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("Hover", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("Pushed", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("SelectedNormal", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("SelectedHover", "UIData/deal3.tga", 0, 140)
	mywindow:setTexture("SelectedPushed", "UIData/deal3.tga", 0, 140)
	
	mywindow:setPosition(11+((i%2)*289), ((i/2)*100)+90)
	mywindow:setProperty("GroupID", 2039)
	mywindow:setSize(287, 98)
	mywindow:setZOrderingEnabled(false)
	myShopRegistWindow:addChildWindow(mywindow)
	
	-- 자물쇠 표시
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistLockImage_"..i)
	mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 241)
	mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 241)
	
	mywindow:setPosition(11+((i%2)*289), ((i/2)*100)+110)
	mywindow:setSize(302, 56)
	mywindow:setZOrderingEnabled(false)
	myShopRegistWindow:addChildWindow(mywindow)
		
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, 29)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 클론 아바타 아이템 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_BackImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, 29)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_TypeImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, 29)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(32, 61)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(38, 61)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(6, 20)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RegistItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, 3)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 수량 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_NumImage_"..i)
	mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 64)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 64)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(60, 24)
	mywindow:setSize(78, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 수량 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 26)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 개당가격 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_onePriceImage_"..i)
	mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 82)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 82)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(60, 42)
	mywindow:setSize(78, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 총가격 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_totalPriceImage_"..i)
	mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 100)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 100)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(60, 58)
	mywindow:setSize(78, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 개당가격 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_onePriceText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,255,0,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 42)
	mywindow:setSize(103, 21)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)

	-- 총가격 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_totalPriceText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,255,0,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 58)
	mywindow:setSize(103, 21)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 78)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 판매일때 등록취소
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopRegistItemList_RegistCancelBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 970, 459)
	mywindow:setTexture("Hover", "UIData/deal.tga", 970, 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 970, 493)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 970, 459)
	mywindow:setPosition(265, 4)
	mywindow:setSize(17, 17)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "ClickedRegistItemCancel")
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 판매일때 수정
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopRegistItemList_ModifyBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 136, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 136, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 136, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 136, 518)
	mywindow:setPosition(214, 75)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "ClickedRegistItemModify")
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 구매일때 구매
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopRegistItemList_BuyBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 590)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 608)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 626)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 590)
	mywindow:setPosition(214, 75)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "ClickedRegistItemBuy")
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
end

function OnEditboxFullEvent(args)
	PlayWave('sound/FullEdit.wav')
end


-- 판매등록에서 등록취소버튼 클릭
function ClickedRegistItemCancel(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")
	CancelSellItemRegist(tonumber(index))
end


-- 판매등록에서 수정버튼 클릭
function ClickedRegistItemModify(args)

	-- 설정변경할 아이템을 위해 선택한다.
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")
	SelectRegistItemToModify(tonumber(index))
		
	-- 변경할 아이템창을 호출한다.
	CallModifyInputPopup()
end


-- 구매할때 구매버튼 클릭
function ClickedRegistItemBuy(args)
			
	-- 구매할 아이템창을 선택한다.
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")	
	SelectRegistItemToBuy(tonumber(index))
	
	-- 구매할 아이템창을 호출한다.
	CallBuyPopup()
end



function ClearMyShopRegistItemList()
	for i=0, MAX_REGIST_ITEMLIST-1 do
		winMgr:getWindow("sj_MyShopRegistItemList_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(false)
		--zeustw
		--winMgr:getWindow("sj_MyShopRegistItemList_BackBoard_"..i):setVisible(false)
		--zeustw
	end
end


function SetupMyShopRegistItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemPrice, totalItemPrice, total_r, total_g, total_b, itemGrade, avatarType , attach)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):setVisible(true)
	
	local myShopState = GetMyShopState()	-- 준비중일 때만
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(true)
	elseif myShopState == MYSHOP_MODE_VISIT then
		winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(true)
	end
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setLayered(true)
		winMgr:getWindow("sj_MyShopRegistItemList_Image_"..i):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("sj_MyShopRegistItemList_TypeImage_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelImage_"..i):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelImage_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelText_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelText_"..i):setText("+"..itemGrade)
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyShopRegistItemList_TypeImage_"..i):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_SkillLevelText_"..i):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyShopRegistItemList_Name_"..i):setText(itemName)
	
	-- 아이템 수량
	local szCount = CommatoMoneyStr(itemUseCount)
	winMgr:getWindow("sj_MyShopRegistItemList_Num_"..i):setText(szCount)
		
	-- 개당 가격
	local szItemPrice = CommatoMoneyStr(itemPrice)
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow("sj_MyShopRegistItemList_onePriceText_"..i):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopRegistItemList_onePriceText_"..i):setText(szItemPrice)
	
	-- 총가격
	winMgr:getWindow("sj_MyShopRegistItemList_totalPriceText_"..i):setTextColor(total_r, total_g, total_b,255)
	winMgr:getWindow("sj_MyShopRegistItemList_totalPriceText_"..i):setText(totalItemPrice)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopRegistItemList_Period_"..i):setText(period)
	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("sj_MyShopRegistItemList_Image_" , "sj_MyShopRegistItemList_Image_" , "sj_MyShopRegistItemList_BackImage_" , i , avatarType , attach)
end


-- 나의 등록된 아이템 리스트 현재 페이지 / 최대 페이지
function MyShopRegistItemListPage(curPage, maxPage)
	g_curPage_RegistList = curPage
	g_maxPage_RegistList = maxPage
	
	winMgr:getWindow("sj_MyShopRegistItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- 등록된 아이템 갯수
function MyShopRegistItemListInfo(bSpecialMode, RegistCurrentItemCount, RegistMaxCount)
	
	-- 스페샬 모드가 아닐경우 좌우버튼을 없앤다
	if bSpecialMode == 0 then
		winMgr:getWindow("sj_MyShopRegistItemList_PageText"):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_LBtn"):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_RBtn"):setVisible(false)
	else
		winMgr:getWindow("sj_MyShopRegistItemList_PageText"):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_LBtn"):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_RBtn"):setVisible(true)
	end
	
	if RegistCurrentItemCount >= RegistMaxCount then
		winMgr:getWindow("sj_MyShopRegistItemList_SellInfo"):setTextColor(255,0,255,255)
	else
		winMgr:getWindow("sj_MyShopRegistItemList_SellInfo"):setTextColor(255,255,255,255)
	end
	
	local text = PreCreateString_1525.." : "..RegistCurrentItemCount.." / "..RegistMaxCount
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, text)
	winMgr:getWindow("sj_MyShopRegistItemList_SellInfo"):setText(text)
	
	-- 판매시작 버튼관리(1개라도 등록되면 보이게 한다.)
	local myShopState = GetMyShopState()	-- 준비중일 때만
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		if RegistCurrentItemCount > 0 then
			SetMyShopSellStartBtn(true)
		else
			SetMyShopSellStartBtn(false)
		end
		
	elseif myShopState == MYSHOP_MODE_SELLING then
		SetMyShopSellStartBtn(true)
	end
end



function OnMouseEnter_RegistItemListInfo(args)
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber, attributeType = GetTooltipInfo(WINDOW_REGIST_LIST, index)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
		x = x + 223
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	DebugStr("등록 아이템?")
	
	
	-- slotIndex를 -1을 넣은 이유 ★
	-- : 툴팁에 코스튬 아바타의 아이콘을 넣기 위해서 -1
	-- : 원래는 0값이 들어가고 있었다.
	GetToolTipBaseInfo(x + 65, y, 2, Kind, -1, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	if Kind ~= KIND_SKILL then
		return
	end
	
	ReadAnimation(itemNumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(EnterWindow)
	targetx = targetx + 52
	if targetx < 0 then
		targetx = 0
	end	
	if y + 223 > g_CURRENT_WIN_SIZEY then
		y = g_CURRENT_WIN_SIZEY - 223
	end
	
	if targetx + 470 > g_CURRENT_WIN_SIZEX then
		targetx = g_CURRENT_WIN_SIZEX - 470
	end
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
end



-- lock이미지
function SetLockImage(i, bVisible)
	winMgr:getWindow("sj_MyShopRegistLockImage_"..i):setVisible(bVisible)
end




-------------------------------------------------------------

-- 2. 나의 아이템 리스트

-------------------------------------------------------------
myShopItemListWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemListBackImage")
myShopItemListWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
myShopItemListWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
myShopItemListWindow:setProperty("FrameEnabled", "False")
myShopItemListWindow:setProperty("BackgroundEnabled", "False")
myShopItemListWindow:setWideType(6);
myShopItemListWindow:setPosition(700, 170)
myShopItemListWindow:setSize(296, 438)
myShopItemListWindow:setAlwaysOnTop(true)
myShopItemListWindow:setVisible(false)
myShopItemListWindow:setZOrderingEnabled(false)
root:addChildWindow(myShopItemListWindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyShopItemListBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myShopItemListWindow:addChildWindow(mywindow)

-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(188, 373)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
myShopItemListWindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tMyShopItemList_BtnName  = {["err"]=0, [0]="sj_MyShopItemList_LBtn", "sj_MyShopItemList_RBtn"}
local tMyShopItemList_BtnTexX  = {["err"]=0, [0]=987, 970}
local tMyShopItemList_BtnPosX  = {["err"]=0, [0]=170, 270}
local tMyShopItemList_BtnEvent = {["err"]=0, [0]="OnClickMyShopItemList_PrevPage", "OnClickMyShopItemList_NextPage"}
for i=0, #tMyShopItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyShopItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyShopItemList_BtnPosX[i], 370)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyShopItemList_BtnEvent[i])
	myShopItemListWindow:addChildWindow(mywindow)
end


function OnClickMyShopItemList_PrevPage()
	if g_curPage_ItemList > 1 then
		g_curPage_ItemList = g_curPage_ItemList - 1
		ChangedMyShopItemListCurrentPage(g_curPage_ItemList)
	end
end

function OnClickMyShopItemList_NextPage()
	if g_curPage_ItemList < g_maxPage_ItemList then
		g_curPage_ItemList = g_curPage_ItemList + 1
		ChangedMyShopItemListCurrentPage(g_curPage_ItemList)
	end
end

-- 그랑 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_GranImage")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 371)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopItemListWindow:addChildWindow(mywindow)

-- 현재 나의 그랑
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(44, 371)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopItemListWindow:addChildWindow(mywindow)


-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
tMyShopItemListName  = {["err"]=0, [0]="sj_MyShopItemList_costume", "sj_MyShopItemList_etc", "sj_MyShopItemList_special", "sj_MyShopItemList_skill"}
tMyShopItemListTexX  = {["err"]=0, [0]=0, 140, 210, 70}
tMyShopItemListPosX  = {["err"]=0, [0]=4, 76, 148, 220}
tMyShopItemListEvent = {["err"]=0, [0]="OnSelect_Costume", "OnSelect_Etc", "OnSelect_Special", "OnSelect_Skill"}
for i=0, #tMyShopItemListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyShopItemListName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tMyShopItemListTexX[i], 455)
	mywindow:setTexture("Hover", "UIData/deal.tga", tMyShopItemListTexX[i], 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tMyShopItemListTexX[i], 497)
	mywindow:setTexture("Disabled", "UIData/deal.tga", tMyShopItemListTexX[i], 455)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", tMyShopItemListTexX[i], 497)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", tMyShopItemListTexX[i], 497)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", tMyShopItemListTexX[i], 497)
	mywindow:setPosition(tMyShopItemListPosX[i], 39)
	mywindow:setProperty("GroupID", 2019)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("SelectStateChanged", tMyShopItemListEvent[i])
	
	if i == g_currentMyShopList then
		mywindow:setProperty("Selected", "true")
	end
	myShopItemListWindow:addChildWindow(mywindow)
end


-- 1.코스츔을 선택했을 때
function OnSelect_Costume(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_costume")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_COSTUME
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 2.기타를 선택했을 때
function OnSelect_Etc(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_etc")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_ETC
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 3.강화를 선택했을 때
function OnSelect_Special(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_special")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_SPECIAL
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 4.스킬을 선택했을 때
function OnSelect_Skill(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_skill")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_SKILL
		ChangedMyShopItemList(g_currentMyShopList)
	end
end




-- 아이템 리스트 판매목록
for i=0, MAX_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_MyShopItemList_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+70)
	mywindow:setProperty("GroupID", 2029)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	myShopItemListWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(120)
	mywindow:setScaleHeight(120)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(false)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 코스튬 아바타 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_BackImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(false)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지( 봉인 , 자물쇠등)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_TypeImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(false)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 오염된 아바타 이미지( 녹색 ) ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyMyShopItemList_Warning_"..i)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
	mywindow:setPosition(0,0)
	mywindow:setSize(40, 40)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_MyItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopItemList_RegistBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setPosition(210, 30)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "ClickedRegistSellItem")
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
end


-- 이미지에 마우스가 들어오면 툴팁을 보여준다.
function OnMouseEnter_MyItemListInfo(args)
			
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber = GetTooltipInfo(WINDOW_MYITEM_LIST, index)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
end


-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_VanishTooltip()
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()
end


-- 아이템 등록 버튼을 누를때
function ClickedRegistSellItem(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local bEnable = SelectItemToRegist(tonumber(index))
	
	-- 등록할 아이템 입력창을 호출한다.
	if bEnable then
		CallSellInputPopup(index, itemCount, itemName, itemFileName)
	end
end



-------------------------------------------------------------------
-- 나의 아이템 리스트에 아이템 목록 설정
-------------------------------------------------------------------
-- 내아이템 목록 초기화
function ClearMyShopItemList()
	for i=0, MAX_ITEMLIST-1 do
		winMgr:getWindow("sj_MyShopItemList_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_BackImage_"..i):setVisible(false)
	end
end

-- 현재 내아이템 목록에 존재하는 아이템만 설정
function SetupMyShopItemList(i, itemName, itemFileName, itemFileName2, itemGrade, itemUseCount , avatarType , attach)
	winMgr:getWindow("sj_MyShopItemList_"..i):setVisible(true)
	
	local myShopState = GetMyShopState()	-- 준비중일 때만
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setVisible(true)
	end
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyShopItemList_Image_"..i):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopItemList_Image_"..i):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopItemList_Image_"..i):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopItemList_Image_"..i):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopItemList_Image_"..i):setLayered(true)
		winMgr:getWindow("sj_MyShopItemList_Image_"..i):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("sj_MyShopItemList_TypeImage_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopItemList_SkillLevelImage_"..i):setVisible(true)
		winMgr:getWindow("sj_MyShopItemList_SkillLevelImage_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopItemList_SkillLevelText_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopItemList_SkillLevelText_"..i):setText("+"..itemGrade)
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyShopItemList_TypeImage_"..i):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyShopItemList_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopItemList_SkillLevelText_"..i):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyShopItemList_Name_"..i):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopItemList_Num_"..i):setText(szCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopItemList_Period_"..i):setText(period)
	
	-- 오염된 아바타라면
	if avatarType == -2 then
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setEnabled(false)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setTexture("Normal" , "UIData/deal.tga", 0, 554)
	else
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setEnabled(true)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setTexture("Normal" , "UIData/deal.tga", 0, 518)
	end
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("sj_MyShopItemList_Image_" , "MyMyShopItemList_Warning_" , "sj_MyShopItemList_BackImage_" , i , avatarType , attach)
	
end


-- 내아이템 리스트 현재 페이지 / 최대 페이지
function MyShopItemListPage(curPage, maxPage)
	g_curPage_ItemList = curPage
	g_maxPage_ItemList = maxPage
	
	winMgr:getWindow("sj_MyShopItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- 현재 나의 그랑을 보여준다.
function ShowMyCurrentGran(myCurrentGran)
	if winMgr:getWindow("sj_MyShopItemList_MyGran") then
		local r,g,b = GetGranColor(myCurrentGran)
		local granText = CommatoMoneyStr64(myCurrentGran)
		winMgr:getWindow("sj_MyShopItemList_MyGran"):setTextColor(r,g,b,255)		
		winMgr:getWindow("sj_MyShopItemList_MyGran"):setText(granText)
	end
	
	if winMgr:getWindow("sj_MyShopRegistItemList_MyGran") then
		local r,g,b = GetGranColor(myCurrentGran)
		local granText = CommatoMoneyStr64(myCurrentGran)
		winMgr:getWindow("sj_MyShopRegistItemList_MyGran"):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_MyGran"):setTextColor(r,g,b,255)
		winMgr:getWindow("sj_MyShopRegistItemList_MyGran"):setText(granText)
		
		if winMgr:getWindow("sj_MyShopRegistItemList_GranImage") then
			winMgr:getWindow("sj_MyShopRegistItemList_GranImage"):setVisible(true)
		end
	end
end


function HideMyCurrentGran()
	if winMgr:getWindow("sj_MyShopRegistItemList_MyGran") then
		winMgr:getWindow("sj_MyShopRegistItemList_MyGran"):setVisible(false)
		
		if winMgr:getWindow("sj_MyShopRegistItemList_GranImage") then
			winMgr:getWindow("sj_MyShopRegistItemList_GranImage"):setVisible(false)
		end
	end
end





-------------------------------------------------------------

-- 3. 숫자 입력

-------------------------------------------------------------
sellInputAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SellInputAlphaImage")
sellInputAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
sellInputAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
sellInputAlphaWindow:setProperty("FrameEnabled", "False")
sellInputAlphaWindow:setProperty("BackgroundEnabled", "False")
sellInputAlphaWindow:setPosition(0, 0)
sellInputAlphaWindow:setSize(1920, 1200)
sellInputAlphaWindow:setVisible(false)
sellInputAlphaWindow:setAlwaysOnTop(true)
sellInputAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(sellInputAlphaWindow)

-- ESC등록
RegistEscEventInfo("sj_SellInputAlphaImage", "ClickedSellInputClose")

-- 입력창 윈도우
myShopSellInputWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInputBackImage")
myShopSellInputWindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
myShopSellInputWindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
myShopSellInputWindow:setProperty("FrameEnabled", "False")
myShopSellInputWindow:setProperty("BackgroundEnabled", "False")
myShopSellInputWindow:setWideType(6)
myShopSellInputWindow:setPosition(370, 200)
myShopSellInputWindow:setSize(296, 212)
myShopSellInputWindow:setAlwaysOnTop(true)
myShopSellInputWindow:setZOrderingEnabled(false)
sellInputAlphaWindow:addChildWindow(myShopSellInputWindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyShopSellInputBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myShopSellInputWindow:addChildWindow(mywindow)

-- 등록 글자 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(100, 8)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_Image")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 코스튬 아바타 백 이미지 ★
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_BackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_TypeImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 스킬 레벨 테두리 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(33, 67)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)



-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_SkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 툴팁 이벤트를 위한 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_EventImage")
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
myShopSellInputWindow:addChildWindow(mywindow)

-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 34)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_Num")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 50)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemCount", 0)
myShopSellInputWindow:addChildWindow(mywindow)

-- 아이템 기간
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 66)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 개당가격 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_OnePriceImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 82)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 82)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 100)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 총가격 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_TotalPriceImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 100)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 100)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 144)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 등록수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_RegistAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 구입수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_BuyAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 136)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 136)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 개당가격 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_InputOnePriceImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(100, 99)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 수량 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopSellInput_InputAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 123)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyShopSellInput_Count_editbox")
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
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeActive_Gran")
myShopSellInputWindow:addChildWindow(mywindow)

function ChangeActive_Gran()
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):activate()
end

-- 수량 입력 좌우버튼
local tInputCountLRButtonName  = {["err"]=0, [0]="sj_MyShopSellInput_InputCount_LBtn", "MyShopSellInput_InputCount_RBtn"}
local tInputCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tInputCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tInputCountLRButtonEvent = {["err"]=0, [0]="ChagneInputCount_L", "ChagneInputCount_R"}
for i=0, #tInputCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tInputCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tInputCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tInputCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setPosition(tInputCountLRButtonPosX[i], 125)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tInputCountLRButtonEvent[i])
	myShopSellInputWindow:addChildWindow(mywindow)
end


-- 룸리스트를 변경한후 그 페이지의 정보를 셋팅해야 한다.
function ChagneInputCount_L()
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	if inputAmount <= 0 then
		inputAmount = 0
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end


function ChagneInputCount_R()

	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount + 1
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end



-- 가격(구매때만 필요)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_granText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(100, 102)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemPrice", 0)
myShopSellInputWindow:addChildWindow(mywindow)

	
-- 그랑 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyShopSellInput_Gran_editbox")
mywindow:setPosition(100, 100)
mywindow:setSize(110, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
--mywindow:subscribeEvent("TextAccepted", "ClickedRegistInputSellItem")
CEGUI.toEditbox(mywindow):setMaxTextLength(8)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeActive_Count")
myShopSellInputWindow:addChildWindow(mywindow)

function ChangeActive_Count()
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):activate()
end

-- 총가격 text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_totalPriceText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,255,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(100, 146)
mywindow:setSize(276, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "CalcTotalPrice")
myShopSellInputWindow:addChildWindow(mywindow)

function CalcTotalPrice()
	
	LimitGranEditbox()
	
	-- 개당가격 얻는다.
	local priceText = ""
	local myShopState = GetMyShopState()	-- 준비중일 때만
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		priceText = winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):getText()
	
	elseif myShopState == MYSHOP_MODE_VISIT then
		priceText = winMgr:getWindow("sj_MyShopSellInput_granText"):getUserString("itemPrice")
	end
	
	if priceText == "" then
		priceText = "0"
	end
	local inputOnePrice = tonumber(priceText)
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(limitAmount))
	end
	
	local totalPriceText, r, g, b = ConvertStringToMultiple(inputOnePrice, inputAmount)
	winMgr:getWindow("sj_MyShopSellInput_totalPriceText"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopSellInput_totalPriceText"):setText(totalPriceText)
end


-- 등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedRegistInputSellItem")
myShopSellInputWindow:addChildWindow(mywindow)

-- 수정 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellInput_ModifyBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 876, 684)
mywindow:setTexture("Hover", "UIData/deal.tga", 876, 713)
mywindow:setTexture("Pushed", "UIData/deal.tga", 876, 742)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 876, 684)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedModifyItem")
myShopSellInputWindow:addChildWindow(mywindow)

-- 구매 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellInput_BuyBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 876, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 876, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 876, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 876, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedBuyItem")
myShopSellInputWindow:addChildWindow(mywindow)

-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedSellInputClose")
myShopSellInputWindow:addChildWindow(mywindow)

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopSellInputClosedBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(266, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedSellInputClose")
myShopSellInputWindow:addChildWindow(mywindow)


-- 닫기버튼 누를때
function ClickedSellInputClose()
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("")
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText("")	
end


---------------------------------------
-- 1. 수량 입력창 호출
---------------------------------------
function CallSellInputPopup()
	
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()

	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- 등록창 이미지(등록)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 0)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 0)
	
	-- 등록, 취소버튼 true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(false)
	
	-- 개당가격, 등록수량, 총가격 글자이미지 true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(false)
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  스킬레벨 보여주기
	winMgr:getWindow("sj_MyShopSellInput_TypeImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("+"..itemGrade)
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyShopSellInput_TypeImage"):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", itemCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- 그랑 가격(구매때만 필요)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(false)
	
	-- 개당가격 입력칸, 입력 에디트 박스 true
	winMgr:getWindow("sj_MyShopSellInput_InputOnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setVisible(true)
	
	if IsSpecialMyShopMode() == MYSHOP_TYPE_MEGA then
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(9)
	else
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(8)
	end
	
	if itemCount == 1 then
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("1")
	end
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
		
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):activate()
end

-- MyItem에서 -> Regist로 등록할때
function ClickedRegistInputSellItem()

	if myShopSellInputWindow:isVisible() == false then
		return
	end
	
	LimitGranEditbox()

	-- 등록하기
	local useCount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText())
	local sellGran = tonumber(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):getText())
	
	local bSuccess = RequestSellItemRegist(useCount, sellGran, false)		
	if bSuccess then
		ClickedSellInputClose()
	end
end


function Error_SellCount()
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("")
end

function Error_Gran()
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText("")
end




---------------------------------------
-- 2. 수정 입력창 호출
---------------------------------------
function CallModifyInputPopup()
	
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()
	
	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- 등록창 이미지(수정)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 32)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 32)
	
	-- 수정, 취소버튼 true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(false)
	
	-- 개당가격, 등록수량, 총가격 글자이미지 true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(false)
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("+"..itemGrade)
	else
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- 아이템 수량
	local countText = CommatoMoneyStr(enableCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", enableCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- 그랑 가격(구매때만 필요)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(false)
	
	-- 개당가격 입력칸, 입력 에디트 박스 true
	winMgr:getWindow("sj_MyShopSellInput_InputOnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(itemCount))
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText(tostring(itemPrice))
	
	if IsSpecialMyShopMode() == MYSHOP_TYPE_MEGA then
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(9)
	else
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(8)
	end
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
end


-- Regist아이템을 수정해서 다시 등록할 때
function ClickedModifyItem()
	if myShopSellInputWindow:isVisible() == false then
		return
	end
	
	LimitGranEditbox()

	-- 등록하기
	local useCount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText())
	local sellGran = tonumber(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):getText())
	
	local bSuccess = RequestSellItemRegist(useCount, sellGran, true)
	if bSuccess then
		ClickedSellInputClose()
	end
end



---------------------------------------
-- 3. 구매창 호출
---------------------------------------
function CallBuyPopup()
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()

	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- 등록창 이미지(구입)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 16)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 16)
	
	-- 구매, 취소버튼 true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(true)
	
	-- 개당가격, 등록수량, 총가격 글자이미지 true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(true)
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("+"..itemGrade)
	else
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", itemCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- 그랑 가격(구매때만 필요)
	local granText = CommatoMoneyStr(itemPrice)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(true)
	
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow("sj_MyShopSellInput_granText"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setText(granText)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setUserString("itemPrice", itemPrice)
	
	-- 개당가격 입력칸, 입력 에디트 박스 false
	winMgr:getWindow("sj_MyShopSellInput_InputOnePriceImage"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setVisible(false)	
	
	if itemCount == 1 then
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("1")
	end
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):activate()
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
end


-- 아이템 구매하기위해 물어본다.
function ClickedBuyItem()

	-- %s 아이템 %s개를\n%s그랑에 구매하시겠습니까?를 물어본다.
	local inputCount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText())
	AskPurchaseItem(inputCount)
end


-- 구매를 할때
function OnClickMyShopBuyOk()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopBuyOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 구매 ok
	ClickedRequestPurchaseItem()
	ClickedSellInputClose()
end

-- 구매를 안할 때
function OnClickMyShopBuyCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopBuyCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	

--	ClickedSellInputClose()
end




function OnMouseEnter_SelectItemInfo(args)
		
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 선택된 윈도우의 정보를 얻는다.
	local itemKind, itemNumber = GetTooltipInfo(WINDOW_SELECT_LIST, 0)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

end









-------------------------------------------------------------

-- 4. 상점제목 버튼

-------------------------------------------------------------
function SetMyShopTitleInfo(bVisible, myShopState, characterKey, title, bSpecialMode)
	
	local SHOP_NORMAL_X = 720
	local SHOP_NORMAL_Y = 0
	local SHOP_HOVER_X  = 720
	local SHOP_HOVER_Y  = 56
	if bSpecialMode ~= 0 then
		SHOP_NORMAL_X = 720
		SHOP_NORMAL_Y = 112
		SHOP_HOVER_X  = 720
		SHOP_HOVER_Y  = 168
	end
	
	local windowName = "sj_MyShopTitleBtn_"..characterKey
	if winMgr:getWindow(windowName) == nil then

		if bVisible == false then
			return
		end
		
		local titleSizeX, titleSizeY = GetBooleanTextSize(title, g_STRING_FONT_GULIMCHE, 12)
		
		-- 준비중, 품절일 때
		if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		
			local mywindow = winMgr:createWindow("TaharezLook/Button", windowName)
			mywindow:setTexture("Normal", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("Hover", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("Pushed", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("PushedOff", "UIData/deal.tga", 618, 531)
			mywindow:setSize(120, 37)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setVisible(bVisible)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("title", title)
			mywindow:setUserString("textSizeX", titleSizeX)
			mywindow:setUserString("textSizeY", titleSizeY)
			mywindow:subscribeEvent("Clicked", "ClickedMyShopTitle")
			mywindow:setSubscribeEvent("EndRender", "EndRenderMyShopTitle");
			root:addChildWindow(mywindow)
			
			profilewindow = winMgr:createWindow('TaharezLook/StaticImage', windowName..'Profile')
			profilewindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
			profilewindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
			profilewindow:setProperty('BackgroundEnabled', 'False')
			profilewindow:setProperty('FrameEnabled', 'False')
			profilewindow:setPosition(4, 6)
			profilewindow:setAlwaysOnTop(true)
			profilewindow:setSize(64, 64)
			profilewindow:setScaleWidth(130)
			profilewindow:setScaleHeight(130)
			profilewindow:setEnabled(false)
			profilewindow:setVisible(false)
			profilewindow:setZOrderingEnabled(false)
			mywindow:addChildWindow(profilewindow)
			
		elseif myShopState == MYSHOP_MODE_SELLING or myShopState == MYSHOP_MODE_VISIT or myShopState == MYSHOP_MODE_BUYING then
			
			local mywindow = winMgr:createWindow("TaharezLook/Button", windowName)
			mywindow:setTexture("Normal", "UIData/deal2.tga", SHOP_NORMAL_X, SHOP_NORMAL_Y)
			mywindow:setTexture("Hover", "UIData/deal2.tga", SHOP_HOVER_X, SHOP_HOVER_Y)
			mywindow:setTexture("Pushed", "UIData/deal2.tga", SHOP_HOVER_X, SHOP_HOVER_Y)
			mywindow:setTexture("PushedOff", "UIData/deal2.tga", SHOP_NORMAL_X, SHOP_NORMAL_Y)
			mywindow:setSize(304, 56)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setVisible(bVisible)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("title", title)
			mywindow:setUserString("textSizeX", titleSizeX)
			mywindow:setUserString("textSizeY", titleSizeY)
			mywindow:subscribeEvent("Clicked", "ClickedMyShopTitle")
			mywindow:setSubscribeEvent("EndRender", "EndRenderMyShopTitle");
			root:addChildWindow(mywindow)
			
			--------------------------------------------------------------------
			-- 마이샵 말풍선에 붙는 프로필 사진 이미지
			--------------------------------------------------------------------
			profilewindow = winMgr:createWindow('TaharezLook/StaticImage', windowName..'Profile')
			profilewindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
			profilewindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
			profilewindow:setProperty('BackgroundEnabled', 'False')
			profilewindow:setProperty('FrameEnabled', 'False')
			profilewindow:setPosition(4, 6)
			profilewindow:setAlwaysOnTop(true)
			profilewindow:setSize(64, 64)
			profilewindow:setScaleWidth(130)
			profilewindow:setScaleHeight(130)
			profilewindow:setEnabled(false)
			profilewindow:setVisible(true)
			profilewindow:setZOrderingEnabled(false)
			mywindow:addChildWindow(profilewindow)
		end
	
	else
		local mywindow = winMgr:getWindow(windowName)
		if bVisible == false then
			winMgr:getWindow(windowName..'Profile'):setVisible(false)
			mywindow:removeChildWindow(winMgr:getWindow(windowName..'Profile'))
			winMgr:destroyWindow(winMgr:getWindow(windowName..'Profile'))
			
			mywindow:setVisible(false)
			root:removeChildWindow(mywindow)
			winMgr:destroyWindow(mywindow)
			return
		end
				
		local titleSizeX, titleSizeY = GetBooleanTextSize(title, g_STRING_FONT_GULIMCHE, 12)
		
		-- 준비중, 품절일 때
		if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
			mywindow:setTexture("Normal", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("Hover", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("Pushed", "UIData/deal.tga", 618, 531)
			mywindow:setTexture("PushedOff", "UIData/deal.tga", 618, 531)
			mywindow:setSize(120, 37)
			mywindow:setVisible(bVisible)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("title", title)
			mywindow:setUserString("textSizeX", titleSizeX)
			mywindow:setUserString("textSizeY", titleSizeY)
			
			winMgr:getWindow(windowName..'Profile'):setVisible(false)
		
		-- 판매중일 때
		elseif myShopState == MYSHOP_MODE_SELLING or myShopState == MYSHOP_MODE_VISIT or myShopState == MYSHOP_MODE_BUYING then
			
			mywindow:setTexture("Normal", "UIData/deal2.tga", SHOP_NORMAL_X, SHOP_NORMAL_Y)
			mywindow:setTexture("Hover", "UIData/deal2.tga", SHOP_HOVER_X, SHOP_HOVER_Y)
			mywindow:setTexture("Pushed", "UIData/deal2.tga", SHOP_HOVER_X, SHOP_HOVER_Y)
			mywindow:setTexture("PushedOff", "UIData/deal2.tga", SHOP_NORMAL_X, SHOP_NORMAL_Y)
			mywindow:setSize(304, 56)
			mywindow:setVisible(bVisible)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("title", title)
			mywindow:setUserString("textSizeX", titleSizeX)
			mywindow:setUserString("textSizeY", titleSizeY)
			
			winMgr:getWindow(windowName..'Profile'):setVisible(true)
			
		elseif myShopState == MYSHOP_MODE_NONE then
			mywindow:setVisible(bVisible)
		end
	end
end


function OnDrawCharacterMyShop(ProfileKey, CharacterKey, bSpecialMode)
	if ProfileKey > 0 then
		if winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile") then
			
			local MINIFY_WIDTH = 140
			local MINIFY_HEIGHT = 140
			local POS_X = 3
			local POS_Y = 4
			if bSpecialMode ~= 0 then
				MINIFY_WIDTH = 130
				MINIFY_HEIGHT = 130
				POS_X = 4
				POS_Y = 6
			end
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setVisible(true)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setScaleWidth(MINIFY_WIDTH)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setScaleHeight(MINIFY_HEIGHT)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setTexture('Enabled',  "UIData/Profile/"..ProfileKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setTexture('Disabled',  "UIData/Profile/"..ProfileKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setPosition(POS_X, POS_Y)
		end
	else
		if winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile") then
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setVisible(false)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setTexture('Enabled',  "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("sj_MyShopTitleBtn_"..CharacterKey.."Profile"):setTexture('Disabled',  "UIData/invisible.tga", 0, 0)
		end
	end
end





-- 마이샵 말풍선 클릭
function ClickedMyShopTitle(args)
	
	-- 선택한 상점이 준비중일 때는 선택불가
	local characterKey = CEGUI.toWindowEventArgs(args).window:getUserString("characterKey")
	if GetIsVisitMyShop(characterKey) == false then
		return
	end
	
	-- 내가 판매중일 때는 구매선택 불가
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_READY		or
	   myShopState == MYSHOP_MODE_MODIFY	or
	   myShopState == MYSHOP_MODE_SELLING then
		return
	end
		
	-- 샵방문 메세지 보내기
	ClickedMyShopTitleToVisit(characterKey)
end



-- 마이샵 말풍선을 보여준다  ( 텍스트 위치정보 수정)
function ShowMyShopTitle(bVisible, myShopMode, characterKey, x, y, bSpecialMode)

	local windowName = "sj_MyShopTitleBtn_"..characterKey
	if winMgr:getWindow(windowName) == nil then
		return
	end
	
	if bVisible == false then
		if winMgr:getWindow(windowName) then
			winMgr:getWindow(windowName):setVisible(bVisible)
		end
		return
	end
	
	if winMgr:getWindow(windowName) then
	
		local specialPosY = 0
		if bSpecialMode ~= 0 then
			specialPosY = -30
		end
		local boolPosX = 0	-- 말풍선 위치
		local boolPosY = 0	-- 말풍선 위치
		local textPosX = 0	-- 상점명 위치
		local textPosY = 0	-- 상점명 위치
		if myShopMode == MYSHOP_MODE_READY	or
		   myShopMode == MYSHOP_MODE_MODIFY then
					
			boolPosX = x+6
			boolPosY = y+74 + specialPosY
			textPosX = x+6
			textPosY = y+74 + specialPosY
			winMgr:getWindow(windowName):setVisible(bVisible)
			winMgr:getWindow(windowName):setPosition(boolPosX, boolPosY)
			
		elseif myShopMode == MYSHOP_MODE_SELLING or
			   myShopMode == MYSHOP_MODE_VISIT	 or
			   myShopMode == MYSHOP_MODE_BUYING then
			
			boolPosX = x-80
			boolPosY = y+60 + specialPosY
			textPosX = x+6
			textPosY = y+67 + specialPosY
			winMgr:getWindow(windowName):setVisible(bVisible)
			winMgr:getWindow(windowName):setPosition(boolPosX, boolPosY)
		end
			
		winMgr:getWindow(windowName):setUserString("posX", textPosX)
		winMgr:getWindow(windowName):setUserString("posY", textPosY)
	end
end


-- 상점 말풍선 타이틀 보여주기(버튼에 EndRender로 붙인다)
function EndRenderMyShopTitle(args)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255,255,255,255)
	
	local posX  = CEGUI.toWindowEventArgs(args).window:getUserString("posX")
	local posY  = CEGUI.toWindowEventArgs(args).window:getUserString("posY")
	local title = CEGUI.toWindowEventArgs(args).window:getUserString("title")
	local textSizeX = CEGUI.toWindowEventArgs(args).window:getUserString("textSizeX")
	local textSizeY = CEGUI.toWindowEventArgs(args).window:getUserString("textSizeY")
	
	drawer:drawText(title, posX+60-textSizeX/2, posY+16-textSizeY/2)
end



-------------------------------------------------------------

-- 5. 상점 방문할 경우 설정(판매시작 버튼이, 구매버튼으로 바껴야 한다)

-------------------------------------------------------------
function SetMyShopVisit(myShopName, title)
		
	-- 상점 이름
	winMgr:getWindow("sj_MyShopRegistItemList_shopName"):setTextExtends(myShopName, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
	
	-- 상점 제목
	local summaryTitle = SummaryString(g_STRING_FONT_GULIMCHE, 12, title, 170)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(false)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setText("")	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(true)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText(summaryTitle)
	
	-- 상점 아이템 리스트 보이기
	SetupMyShopWindows(true)
end





-------------------------------------------------------------

-- 6. 도움말

-------------------------------------------------------------
-- 도움말 내용
myhelpwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_HelpImage")
myhelpwindow:setTexture("Enabled", "UIData/deal.tga", 590, 800)
myhelpwindow:setTexture("Disabled", "UIData/deal.tga", 590, 800)
myhelpwindow:setProperty("FrameEnabled", "False")
myhelpwindow:setProperty("BackgroundEnabled", "False")
myhelpwindow:setWideType(6);
myhelpwindow:setPosition(350, 20)
myhelpwindow:setSize(286, 147)
myhelpwindow:setVisible(false)
myhelpwindow:setAlwaysOnTop(true)
myhelpwindow:setZOrderingEnabled(false)
root:addChildWindow(myhelpwindow)

-- 도움말 닫기
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyShopRegistItemList_HelpClosedBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 970, 459)
mywindow:setTexture("Hover", "UIData/deal.tga", 970, 476)
mywindow:setTexture("Pushed", "UIData/deal.tga", 970, 493)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 970, 459)
mywindow:setPosition(260, 6)
mywindow:setSize(17, 17)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedHelpImageClose")
myhelpwindow:addChildWindow(mywindow)

function ClickedHelpImageClose()
	myhelpwindow:setVisible(false)
end




-------------------------------------------------------------

-- 7. 판매기록 보기(나의 판매등록(Regist) 윈도우창에 붙인다

-------------------------------------------------------------
-- 판매기록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_RegistMyShopSellRecordBtn")
mywindow:setTexture("Normal", "UIData/deal3.tga", 371, 163)
mywindow:setTexture("Hover", "UIData/deal3.tga", 371, 187)
mywindow:setTexture("Pushed", "UIData/deal3.tga", 371, 211)
mywindow:setTexture("PushedOff", "UIData/deal3.tga", 371, 235)

mywindow:setPosition(455, 56)
mywindow:setSize(74, 24)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedShowSellRecord")
myShopRegistWindow:addChildWindow(mywindow)

function ClickedShowSellRecord()
	local isVisibleRecord = winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):isVisible()
	if isVisibleRecord then
		winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
	else
		ChangedSellRecordPage(1)
		winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(true)
	end
end


-- 판매기록 바탕이미지
myrecordwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RegistMyShopSellRecord_backImage")
myrecordwindow:setTexture("Enabled", "UIData/deal.tga", 0, 705)
myrecordwindow:setTexture("Disabled", "UIData/deal.tga", 0, 705)
myrecordwindow:setProperty("FrameEnabled", "False")
myrecordwindow:setProperty("BackgroundEnabled", "False")
myrecordwindow:setWideType(6);
myrecordwindow:setPosition(230, 270)
myrecordwindow:setSize(580, 266)
myrecordwindow:setVisible(false)
myrecordwindow:setAlwaysOnTop(true)
myrecordwindow:setZOrderingEnabled(false)
root:addChildWindow(myrecordwindow)

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_RegistMyShopSellRecord_backImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(540, 30)
myrecordwindow:addChildWindow(mywindow)

-- 판매기록 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_RegistMyShopSellRecord_ClosedBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(548, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedSellRecordClose")
myrecordwindow:addChildWindow(mywindow)

function ClickedSellRecordClose()
	winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
end

-- ESC등록
RegistEscEventInfo("sj_RegistMyShopSellRecord_backImage", "ClickedSellRecordClose")


for i=0, MAX_SELL_RECORDLIST-1 do

	-- 투명한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RegistMyShopSellRecord_temp"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, i*17+60)
	mywindow:setSize(566, 16)
	mywindow:setZOrderingEnabled(false)
	myrecordwindow:addChildWindow(mywindow)
	
	-- 1. 구매자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_BuyerName_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(0, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 2. 판매한 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldItem_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(140, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 3. 판매한 수량
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldCount_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(290, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 4. 판매한 가격(수수료 포함)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldPrice_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(390, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 5. 날짜(시간)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_DateSold_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(500, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
end



-- 판매기록 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(188, 242)
mywindow:setSize(80, 20)
mywindow:setText("1 / 1")
mywindow:setZOrderingEnabled(false)
myrecordwindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tSellRecord_BtnName  = {["err"]=0, [0]="sj_RegistMyShopSellRecord_LBtn", "sj_RegistMyShopSellRecord_RBtn"}
local tSellRecord_BtnTexX  = {["err"]=0, [0]=987, 970}
local tSellRecord_BtnPosX  = {["err"]=0, [0]=240, 340}
local tSellRecord_BtnEvent = {["err"]=0, [0]="OnClickRegistMyShopSellRecord_PrevPage", "OnClickRegistMyShopSellRecord_NextPage"}
for i=0, #tSellRecord_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tSellRecord_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tSellRecord_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tSellRecord_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tSellRecord_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tSellRecord_BtnTexX[i], 0)
	mywindow:setPosition(tSellRecord_BtnPosX[i], 237)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tSellRecord_BtnEvent[i])
	myrecordwindow:addChildWindow(mywindow)
end


function OnClickRegistMyShopSellRecord_PrevPage()
	if g_curPage_SellRecord > 1 then
		g_curPage_SellRecord = g_curPage_SellRecord - 1
		ChangedSellRecordPage(g_curPage_SellRecord)
	end
end

function OnClickRegistMyShopSellRecord_NextPage()
	if g_curPage_SellRecord < g_maxPage_SellRecord then
		g_curPage_SellRecord = g_curPage_SellRecord + 1
		ChangedSellRecordPage(g_curPage_SellRecord)
	end
end

function SellRecordPage(curPage, maxPage)
	g_curPage_SellRecord = curPage
	g_maxPage_SellRecord = maxPage
	
	local pageText = curPage.." / "..maxPage
	local pageSize = GetStringSize(g_STRING_FONT_GULIM, 14, pageText)
	winMgr:getWindow("sj_RegistMyShopSellRecord_PageText"):setPosition(300-pageSize/2, 237)
	winMgr:getWindow("sj_RegistMyShopSellRecord_PageText"):setText(pageText)
end



-- 판매기록 초기화
function ClearSellRecord()
	for i=0, MAX_SELL_RECORDLIST-1 do
		winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):setVisible(false)
	end
end

-- 판매기록 설정
function SetupSellRecord(i, buyerName, soldItem, soldCount, soldPrice, dateSold, r, g, b)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):setVisible(true)
	
	-- 1. 구매자
	local size = GetStringSize(g_STRING_FONT_GULIM, 12, buyerName)
	winMgr:getWindow("sj_RegistMyShopSellRecord_BuyerName_"..i):setPosition(64-size/2, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_BuyerName_"..i):setText(buyerName)
	
	--- 2. 판매한 아이템 이름
	local summaryItemName = SummaryString(g_STRING_FONT_GULIMCHE, 12, soldItem, 150)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldItem_"..i):setText(summaryItemName)
	
	-- 3. 판매한 수량
	size = GetStringSize(g_STRING_FONT_GULIM, 12, soldCount)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldCount_"..i):setPosition(346-size/2, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldCount_"..i):setText(soldCount)
	
	-- 4. 판매한 가격(수수료 포함)
	size = GetStringSize(g_STRING_FONT_GULIM, 12, soldPrice)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setPosition(482-size, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setText(soldPrice)
	
	-- 5. 날짜(시간)
	size = GetStringSize(g_STRING_FONT_GULIM, 12, dateSold)
	winMgr:getWindow("sj_RegistMyShopSellRecord_DateSold_"..i):setPosition(556-size, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_DateSold_"..i):setText(dateSold)
end


function SetSellRecordWindow(bVisible)
	if winMgr:getWindow("sj_RegistMyShopSellRecord_backImage") then
		winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(bVisible)
	end
end






-- 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myshop_AlphaImg")
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

--- OK 알림창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myshop_OkBox")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
root:addChildWindow(mywindow)

-- 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_myshop_OkBox_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setPosition(100, 100)
mywindow:setSize(340, 180)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(3, 130)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
winMgr:getWindow("sj_myshop_OkBox"):addChildWindow(mywindow)

-- 알림창 확인버튼(OK)
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_myshop_OkBtn_Only")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setSize(331, 29)
mywindow:setPosition(4, 235)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClosemyshopOKBox")
winMgr:getWindow("sj_myshop_OkBox"):addChildWindow(mywindow)


function ClosemyshopOKBox(args)
	local okFunc = winMgr:getWindow('sj_myshop_OkBox'):getUserString("okFunction")
	if okFunc ~= "ClosemyshopOKBox" then
		return
	end
	winMgr:getWindow('sj_myshop_OkBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('sj_myshop_AlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('sj_myshop_AlphaImg'))
	local local_window = winMgr:getWindow('sj_myshop_OkBox')
	winMgr:getWindow('sj_myshop_AlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end


function ShowBuyItemMessageBox(arg)
	DebugStr("aaaaaaaaaaaa")
    
    local aa = winMgr:getWindow('sj_myshop_AlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('sj_myshop_AlphaImg'):getChildAtIdx(0)
		winMgr:getWindow('sj_myshop_AlphaImg'):removeChildWindow(bb)
	end
	
	root:addChildWindow(winMgr:getWindow('sj_myshop_AlphaImg'))
	winMgr:getWindow('sj_myshop_AlphaImg'):setVisible(true)
	
	local local_window = winMgr:getWindow('sj_myshop_OkBox')
	local_window:setUserString("okFunction", "ClosemyshopOKBox")
	root:addChildWindow(local_window)
	
	local local_txt_window = winMgr:getWindow('sj_myshop_OkBox_Text')
	local_window:setVisible(true)
	
	local_txt_window:clearTextExtends()
	local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
end

function RenderShop()

	if winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):isVisible() == true then
		LimitGranEditbox()
	end
end


RegistEnterEventInfo("sj_myshop_AlphaImg", "ClosemyshopOKBox")
RegistEscEventInfo("sj_myshop_AlphaImg", "ClosemyshopOKBox")

