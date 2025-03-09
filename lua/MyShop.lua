--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

-- ���� ���̼� ����
local MYSHOP_MODE_NONE		= 0		-- �Ϲ�
local MYSHOP_MODE_READY		= 1		-- �غ���
local MYSHOP_MODE_MODIFY	= 2		-- ���� ������
local MYSHOP_MODE_SELLING	= 3		-- �Ǹ���
local MYSHOP_MODE_VISIT		= 4		-- ���� ������
local MYSHOP_MODE_BUYING	= 5		-- ������

-- ���� ���̼� ��� ����Ʈ ����
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

-- ���� ���� ���̼� ��� ������
local g_curPage_ItemList = 1
local g_maxPage_ItemList = 1

-- ���� ���� ����� ��� ������
local g_curPage_RegistList = 1
local g_maxPage_RegistList = 1

local g_curPage_SellRecord = 1
local g_maxPage_SellRecord = 1

local MAX_ITEMLIST = GetMaxMyItemListNum()			-- ���� ��� ����Ʈ �ִ밳��
local MAX_REGIST_ITEMLIST = GetMaxRegistListNumMyShop()	-- ���� ��� ����Ʈ �ִ밳��
local MAX_SELL_RECORDLIST = GetMaxSellRecord()		-- �Ǹű�� �ִ밳��

--local tGradeferPersent	= {['err'] = 0, 1,2,3,5,7,9,14,20,27,35}	-- ��ų �׷��̵忡���� �߰������� ���̺�

function SkillDescDivideToMyShop(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--��ų����
	local _DetailDesc = "";		--��ų����
	
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


-- ���� �Է� ����Ʈ�ڽ� ����
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
-- �������� ���̼��� ���� ������Ʈ�� �޴´�.(�Ǹ��� ���� �����Ѵ�.)
--------------------------------------------
function UpdateMyShopState(currentMyShopState)
	
	-- 1. �Ϲݻ���
	if currentMyShopState == MYSHOP_MODE_NONE then
		RequestItemListToMyShop()
	-- 2. �����ۼ� �غ����� ��
	elseif currentMyShopState == MYSHOP_MODE_READY or currentMyShopState == MYSHOP_MODE_MODIFY then
		
		-- ������ ������ ������ ��û(�������� ���, �κ��丮 ������ ���)
		RequestItemListToMyShop()
		SetupMyShopWindows(true)
		
		-- �ǸŸ� ���� ���� ����� "���̼�"
		winMgr:getWindow("sj_MyShopRegistItemList_shopName"):setTextExtends(PreCreateString_1534, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)

	-- 3. �����ۼ� �ǸŸ� ������ ��
	elseif currentMyShopState == MYSHOP_MODE_SELLING then
	
		-- 1. ���������츦 �����.
		winMgr:getWindow("sj_MyShopAlphaImage"):setVisible(false)
		
		-- 2. ���� ��������츦 �����.
		winMgr:getWindow("sj_MyShopItemListBackImage"):setVisible(false)
		
		-- 3. ��� ��ư�� �����.
		for i=0, MAX_REGIST_ITEMLIST-1 do
			winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(false)
		end
		
		-- 4. ������ ��ư�� �����ư���� �ٲ۴�.
		RequestItemListToMyShop()
		SetMyShopSellStartBtn(true)
	end
end


-- ��Ƽ ������ NPC ��ȭ�� ���̼� ������ư�� ������, �Ⱥ������� ����
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

-- ��׶��� ���� �̹���

-----------------------------------------------------------
-- �޼��� ���� �̹���
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


-- ���� ������â ������Ʈ
function SetupMyShopWindows(bVisible, ...)
	---------------------------
	-- ���̼��� ���� ����
	---------------------------
	if bVisible then
	
		-- 1. ������ ���� �ȷ��� �����
		local myShopState = GetMyShopState()
		if myShopState == MYSHOP_MODE_NONE   or myShopState == MYSHOP_MODE_READY   or
		   myShopState == MYSHOP_MODE_MODIFY or myShopState == MYSHOP_MODE_SELLING then
			DebugStr("��������")
			
			OnClickWriteClose()  -- ������ ����� ���Ͼ������� �ݾ��ش�
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
			
			-- �Ǹű��, ���� ��ư true
			winMgr:getWindow("sj_RegistMyShopSellRecordBtn"):setVisible(true)
			winMgr:getWindow("sj_RegistMyShopHelpBtn"):setVisible(true)
			winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(true)
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
					
			-- ������ ��ư true
			winMgr:getWindow("sj_MyShopSellStartBtn"):setVisible(true)					

		-- 2. ���� ������ �湮�� ���
		elseif myShopState == MYSHOP_MODE_VISIT then
			DebugStr("��������2")
			root:addChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
			winMgr:getWindow("sj_RegistMyShopBackImage"):setVisible(true)
			
			winMgr:getWindow("sj_MyShopAlphaImage"):addChildWindow(winMgr:getWindow("sj_ClosedMyShopBtn"))
			--winMgr:getWindow("MyInven_MyshopButton"):setVisible(false)
			winMgr:getWindow("MyInven_MyshopButton"):setEnabled(false)
			--winMgr:getWindow("MainBar_MyShop"):setEnabled(false)
			
			-- �Ǹű��, ���� ��ư false
			winMgr:getWindow("sj_RegistMyShopSellRecordBtn"):setVisible(false)
			winMgr:getWindow("sj_RegistMyShopHelpBtn"):setVisible(false)
			winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)
			
			-- ������ ��ư false
			winMgr:getWindow("sj_MyShopSellStartBtn"):setVisible(false)
			
			-- �˾� �ڷ� �Ѿ�� ���� ����
			if winMgr:getWindow('sj_myshop_OkBox'):isVisible() then
				root:addChildWindow(winMgr:getWindow('sj_myshop_OkBox'))
			end
		end
	
	----------------------------
	-- ���̼��� ���� �� ����
	----------------------------
	else	
		-- 1. ���� ������ �ݰ�, ���̼� ������ư�� ���̰� �Ѵ�.
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
		
		-- 2. �ǸŽ��� ��ư �����۾�(�ٽ� �������� ���� ����)
		SetMyShopSellStartBtn(false)
					
		-- 3. ���� ���� �̸� �ʱ�ȭ
		winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setText("")
		
		winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText("")
		
		-- �Ǹű��, ���� false
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
		
		if recordVisible == false then
			winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(false)	
		end
	
		SetShowToolTip(false)
		HideAnimationWindow()	
	end
end






-------------------------------------------------------------

-- 1. ���̼��� �Ǹ��� ������ ���â

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

-- �Ǹ��� ���� ���̼�, ������ ���� %s���� ���̼�
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

-- �Ǹ� / �ǸŰ���
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_SellInfo")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(20, 20)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- ���� ���� �Է�â ���
-- �̹����� ���ҵǾ� �����Ƿ� �ΰ��� �����찡 �ʿ��ϴ�
-- ���� �Է�â ��� 1
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_TitleImage1")
mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 0)
mywindow:setPosition(15, 46)
mywindow:setSize(512, 42)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
myShopRegistWindow:addChildWindow(mywindow)

-- ���� �Է�â ��� 2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistItemList_TitleImage2")
mywindow:setTexture("Enabled", "UIData/deal3.tga", 304, 42)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 304, 42)
mywindow:setPosition(527, 46)
mywindow:setSize(57, 42)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
myShopRegistWindow:addChildWindow(mywindow)

-- ���� ��ư
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


-- ���� ��ư�� Ŭ���Ѵ�.
function ClickedShowMyShopHelp()
	local isHelpImageVisible = winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):isVisible()
	if isHelpImageVisible then
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
	else
		winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(true)
	end
end

-- �׶� �̹���
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

-- ���� ���� �׶�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)

mywindow:setPosition(44, 502)

mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopRegistWindow:addChildWindow(mywindow)

-- �ݱ��ư
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


-- �ݱ��ư Ŭ��(������:�����, �湮��:�׳� �ݴ´�)
function ClickedAskMyShopClose()

	-- ���� ���� �湮���� ���� �׳� �ݴ´�.
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_VISIT or myShopState == MYSHOP_MODE_BUYING then
		RequestMyShopClosed()
		SetupMyShopWindows(false)
		
	-- �������϶��� ���̼��� �����ðڽ��ϱ�? �����.
	else
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1510, 'OnClickClosedRegistMyShopOk', 'OnClickClosedRegistMyShopCancel')
	end
end

-- ESC���
RegistEscEventInfo("sj_RegistMyShopBackImage", "ClickedAskMyShopClose")


-- ���̼��� �ݴ´�.
function OnClickClosedRegistMyShopOk(args)
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickClosedRegistMyShopOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- ���̼��� ��¥�� �ݴ´�.
	local myShopState = GetMyShopState()
	if myShopState > MYSHOP_MODE_NONE then
		RequestMyShopClosed()
		SetupMyShopWindows(false, false)
	end	
end


-- ���̼� �ݴ°� ����Ѵ�.
function OnClickClosedRegistMyShopCancel(args)	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickClosedRegistMyShopCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end




-- ���� ������ / �ִ� ������
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

-- ������ �¿� ��ư
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

-- ���� �Է��� �Ϸ�� ��� ������(�Ʒ� ���� �Է�â�̶� ���� ���̰�, �Ⱥ��̰� �Ѵ�)
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

-- ���� ���� �Է�â
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

-- �ǸŽ���
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

-- �ǸŽ��� ��ư�� ������ ��(�Ǹ����� �� ������ ���������� ��)
function ClickedStartMyShop()
	
	-- �غ����� ���� �Ǹſ�û�� �Ѵ�.
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_READY then
	
		local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
		if CheckMyShopTitle(myShopTitle) then
			
			-- ���� ���伣���� ��� "���̼��� �����Ͻðڽ��ϱ�?"
			local myShopType = IsSpecialMyShopMode()
			if myShopType ~= MYSHOP_TYPE_DEFAULT then
				ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1094, 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
			else
				-- ������� %d�׶��� �����˴ϴ�.\n���̼��� �����Ͻðڽ��ϱ�?
				local FEE = GetMyShopFEE()
				ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_1493, FEE), 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
			end		
		end
	
	-- ���������߿��� �ǸŽ����� ������� "���̼��� �����Ͻðڽ��ϱ�?"
	elseif myShopState == MYSHOP_MODE_MODIFY then
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1094, 'OnClickMyShopStartOk', 'OnClickMyShopStartCancel')
	
	-- ���� �Ǹ����� ���� �ٽ� �غ������� �����Ѵ�.
	-- ���������� ������ ���
	elseif myShopState == MYSHOP_MODE_SELLING then
	
		-- ���̼��� �ٽ� �����Ͻðڽ��ϱ�? 
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_1132, 'OnClickMyShopRefreshOk', 'OnClickMyShopRefreshCancel')
	end
end

--------------------------------
-- 1. ���̼��� ����
function OnClickMyShopStartOk()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopStartOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- ���̼��� �����ϰڴٰ� �޼����� ������.
	local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
	StartMyShop(myShopTitle)
end

-- ���̼� �������
function OnClickMyShopStartCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopStartCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end



--------------------------------
-- 2.���̼� ��������
function OnClickMyShopRefreshOk()
	DebugStr("OnClickMyShopRefreshOkOnClickMyShopRefreshOkOnClickMyShopRefreshOkOnClickMyShopRefreshOk")
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopRefreshOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- ���������� ok�Ұ��
	RequestMyShopChanged()	-- ������ �غ������� �޼��� ������
	root:addChildWindow(winMgr:getWindow("sj_MyShopAlphaImage"))
	root:addChildWindow(winMgr:getWindow("sj_MyShopItemListBackImage"))
	root:addChildWindow(winMgr:getWindow("sj_RegistMyShopBackImage"))
	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(true)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(false)
end

-- ���̼� �������� ���
function OnClickMyShopRefreshCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopRefreshCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end



-- �ǸŽ����� ���������� �ɰ��
function UpdateStartMyShop()	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(false)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(true)
	
	local myShopTitle = winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):getText()
	local summaryTitle = SummaryString(g_STRING_FONT_GULIMCHE, 12, myShopTitle, 170)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText(summaryTitle)
	
	-- ������ false�Ѵ�.
	winMgr:getWindow("sj_MyShopRegistItemList_HelpImage"):setVisible(false)
end

-- ���� 668 (bEnable = false�����, �Ʒ� �ּ�Ǭ��)
-- �غ����϶��� �ǸŽ���, ���� �Ǹ����϶��� ������������ �����Ѵ�.
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


-- ������ ����Ʈ ���� �����̹���
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


-- ������ ����Ʈ �ǸŸ��
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
	
	-- �ڹ��� ǥ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyShopRegistLockImage_"..i)
	mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 241)
	mywindow:setTexture("Disabled", "UIData/deal3.tga", 0, 241)
	
	mywindow:setPosition(11+((i%2)*289), ((i/2)*100)+110)
	mywindow:setSize(302, 56)
	mywindow:setZOrderingEnabled(false)
	myShopRegistWindow:addChildWindow(mywindow)
		
	-- ������ �̹���
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
	
	-- Ŭ�� �ƹ�Ÿ ������ �� �̹��� ��
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
	
	-- ������ �̹���
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
	
	-- ��ų ���� �׵θ� �̹���
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
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(38, 61)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
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
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, 3)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- ������ ���� �̹���
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
	
	-- ������ ���� �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 26)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- ���簡�� �̹���
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
	
	-- �Ѱ��� �̹���
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
	
	-- ���簡�� �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_onePriceText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,255,0,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 42)
	mywindow:setSize(103, 21)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)

	-- �Ѱ��� �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_totalPriceText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,255,0,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(142, 58)
	mywindow:setSize(103, 21)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopRegistItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 78)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopRegistItemList_"..i):addChildWindow(mywindow)
	
	-- �Ǹ��϶� ������
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
	
	-- �Ǹ��϶� ����
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
	
	-- �����϶� ����
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


-- �Ǹŵ�Ͽ��� �����ҹ�ư Ŭ��
function ClickedRegistItemCancel(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")
	CancelSellItemRegist(tonumber(index))
end


-- �Ǹŵ�Ͽ��� ������ư Ŭ��
function ClickedRegistItemModify(args)

	-- ���������� �������� ���� �����Ѵ�.
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")
	SelectRegistItemToModify(tonumber(index))
		
	-- ������ ������â�� ȣ���Ѵ�.
	CallModifyInputPopup()
end


-- �����Ҷ� ���Ź�ư Ŭ��
function ClickedRegistItemBuy(args)
			
	-- ������ ������â�� �����Ѵ�.
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")	
	SelectRegistItemToBuy(tonumber(index))
	
	-- ������ ������â�� ȣ���Ѵ�.
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
	
	local myShopState = GetMyShopState()	-- �غ����� ����
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		winMgr:getWindow("sj_MyShopRegistItemList_RegistCancelBtn_"..i):setVisible(true)
		winMgr:getWindow("sj_MyShopRegistItemList_ModifyBtn_"..i):setVisible(true)
	elseif myShopState == MYSHOP_MODE_VISIT then
		winMgr:getWindow("sj_MyShopRegistItemList_BuyBtn_"..i):setVisible(true)
	end
	
	-- ������ �̹���
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
	
	--  ��ų���� �����ֱ�
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
	
	-- ������ �̸�
	winMgr:getWindow("sj_MyShopRegistItemList_Name_"..i):setText(itemName)
	
	-- ������ ����
	local szCount = CommatoMoneyStr(itemUseCount)
	winMgr:getWindow("sj_MyShopRegistItemList_Num_"..i):setText(szCount)
		
	-- ���� ����
	local szItemPrice = CommatoMoneyStr(itemPrice)
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow("sj_MyShopRegistItemList_onePriceText_"..i):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopRegistItemList_onePriceText_"..i):setText(szItemPrice)
	
	-- �Ѱ���
	winMgr:getWindow("sj_MyShopRegistItemList_totalPriceText_"..i):setTextColor(total_r, total_g, total_b,255)
	winMgr:getWindow("sj_MyShopRegistItemList_totalPriceText_"..i):setText(totalItemPrice)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopRegistItemList_Period_"..i):setText(period)
	
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIconS("sj_MyShopRegistItemList_Image_" , "sj_MyShopRegistItemList_Image_" , "sj_MyShopRegistItemList_BackImage_" , i , avatarType , attach)
end


-- ���� ��ϵ� ������ ����Ʈ ���� ������ / �ִ� ������
function MyShopRegistItemListPage(curPage, maxPage)
	g_curPage_RegistList = curPage
	g_maxPage_RegistList = maxPage
	
	winMgr:getWindow("sj_MyShopRegistItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- ��ϵ� ������ ����
function MyShopRegistItemListInfo(bSpecialMode, RegistCurrentItemCount, RegistMaxCount)
	
	-- ���伣 ��尡 �ƴҰ�� �¿��ư�� ���ش�
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
	
	-- �ǸŽ��� ��ư����(1���� ��ϵǸ� ���̰� �Ѵ�.)
	local myShopState = GetMyShopState()	-- �غ����� ����
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
	
	-- ���� ���õ� �����츦 ã�´�.
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
	DebugStr("��� ������?")
	
	
	-- slotIndex�� -1�� ���� ���� ��
	-- : ������ �ڽ�Ƭ �ƹ�Ÿ�� �������� �ֱ� ���ؼ� -1
	-- : ������ 0���� ���� �־���.
	GetToolTipBaseInfo(x + 65, y, 2, Kind, -1, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
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



-- lock�̹���
function SetLockImage(i, bVisible)
	winMgr:getWindow("sj_MyShopRegistLockImage_"..i):setVisible(bVisible)
end




-------------------------------------------------------------

-- 2. ���� ������ ����Ʈ

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

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyShopItemListBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myShopItemListWindow:addChildWindow(mywindow)

-- ���� ������ / �ִ� ������
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

-- ������ �¿� ��ư
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

-- �׶� �̹���
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

-- ���� ���� �׶�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(44, 371)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myShopItemListWindow:addChildWindow(mywindow)


-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
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


-- 1.�ڽ����� �������� ��
function OnSelect_Costume(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_costume")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_COSTUME
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 2.��Ÿ�� �������� ��
function OnSelect_Etc(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_etc")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_ETC
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 3.��ȭ�� �������� ��
function OnSelect_Special(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_special")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_SPECIAL
		ChangedMyShopItemList(g_currentMyShopList)
	end
end

-- 4.��ų�� �������� ��
function OnSelect_Skill(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyShopItemList_skill")):isSelected() then
		g_currentMyShopList = MYSHOPLIST_SKILL
		ChangedMyShopItemList(g_currentMyShopList)
	end
end




-- ������ ����Ʈ �ǸŸ��
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
	
	-- ������ �̹���
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
	
	-- �ڽ�Ƭ �ƹ�Ÿ �� �̹��� ��
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
	
	-- ������ Ư�� �̹���( ���� , �ڹ����)
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
	
	-- ������ �ƹ�Ÿ �̹���( ��� ) ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyMyShopItemList_Warning_"..i)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
	mywindow:setPosition(0,0)
	mywindow:setSize(40, 40)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
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
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
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
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyShopItemList_"..i):addChildWindow(mywindow)
	
	-- ������ ��Ϲ�ư
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


-- �̹����� ���콺�� ������ ������ �����ش�.
function OnMouseEnter_MyItemListInfo(args)
			
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- ���� ���õ� �����츦 ã�´�.
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end


-- �̹����� ���콺�� ����� ������ �����Ѵ�.
function OnMouseLeave_VanishTooltip()
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
end


-- ������ ��� ��ư�� ������
function ClickedRegistSellItem(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local bEnable = SelectItemToRegist(tonumber(index))
	
	-- ����� ������ �Է�â�� ȣ���Ѵ�.
	if bEnable then
		CallSellInputPopup(index, itemCount, itemName, itemFileName)
	end
end



-------------------------------------------------------------------
-- ���� ������ ����Ʈ�� ������ ��� ����
-------------------------------------------------------------------
-- �������� ��� �ʱ�ȭ
function ClearMyShopItemList()
	for i=0, MAX_ITEMLIST-1 do
		winMgr:getWindow("sj_MyShopItemList_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setVisible(false)
		winMgr:getWindow("sj_MyShopRegistItemList_BackImage_"..i):setVisible(false)
	end
end

-- ���� �������� ��Ͽ� �����ϴ� �����۸� ����
function SetupMyShopItemList(i, itemName, itemFileName, itemFileName2, itemGrade, itemUseCount , avatarType , attach)
	winMgr:getWindow("sj_MyShopItemList_"..i):setVisible(true)
	
	local myShopState = GetMyShopState()	-- �غ����� ����
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setVisible(true)
	end
	
	-- ������ �̹���
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
	
	--  ��ų���� �����ֱ�
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
	
	-- ������ �̸�
	winMgr:getWindow("sj_MyShopItemList_Name_"..i):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopItemList_Num_"..i):setText(szCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopItemList_Period_"..i):setText(period)
	
	-- ������ �ƹ�Ÿ���
	if avatarType == -2 then
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setEnabled(false)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setTexture("Normal" , "UIData/deal.tga", 0, 554)
	else
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setEnabled(true)
		winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setTexture("Normal" , "UIData/deal.tga", 0, 518)
	end
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIconS("sj_MyShopItemList_Image_" , "MyMyShopItemList_Warning_" , "sj_MyShopItemList_BackImage_" , i , avatarType , attach)
	
end


-- �������� ����Ʈ ���� ������ / �ִ� ������
function MyShopItemListPage(curPage, maxPage)
	g_curPage_ItemList = curPage
	g_maxPage_ItemList = maxPage
	
	winMgr:getWindow("sj_MyShopItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- ���� ���� �׶��� �����ش�.
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

-- 3. ���� �Է�

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

-- ESC���
RegistEscEventInfo("sj_SellInputAlphaImage", "ClickedSellInputClose")

-- �Է�â ������
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

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyShopSellInputBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myShopSellInputWindow:addChildWindow(mywindow)

-- ��� ���� �̹���
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

-- ������ �̹���
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

-- �ڽ�Ƭ �ƹ�Ÿ �� �̹��� ��
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

-- ������ �̹���
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

-- ��ų ���� �׵θ� �̹���
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



-- ��ų���� + ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_SkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- ���� �̺�Ʈ�� ���� �̹���
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

-- ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 34)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- ������ ����
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

-- ������ �Ⱓ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyShopSellInput_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 66)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myShopSellInputWindow:addChildWindow(mywindow)

-- ���簡�� �̹���
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

-- �Ѱ��� �̹���
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

-- ��ϼ��� �̹���
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

-- ���Լ��� �̹���
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

-- ���簡�� �Է�ĭ
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

-- ���� �Է�ĭ
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

-- ���� �Է� ����Ʈ �ڽ�
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

-- ���� �Է� �¿��ư
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


-- �븮��Ʈ�� �������� �� �������� ������ �����ؾ� �Ѵ�.
function ChagneInputCount_L()
	
	-- ������ ��´�.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- ���� ������ ������ ���ؼ� ���Ѵ�.
	if inputAmount <= 0 then
		inputAmount = 0
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end


function ChagneInputCount_R()

	-- ������ ��´�.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- ���� ������ ������ ���ؼ� ���Ѵ�.
	local limitAmount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount + 1
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end



-- ����(���Ŷ��� �ʿ�)
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

	
-- �׶� �Է� ����Ʈ �ڽ�
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

-- �Ѱ��� text
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
	
	-- ���簡�� ��´�.
	local priceText = ""
	local myShopState = GetMyShopState()	-- �غ����� ����
	if myShopState == MYSHOP_MODE_READY or myShopState == MYSHOP_MODE_MODIFY then
		priceText = winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):getText()
	
	elseif myShopState == MYSHOP_MODE_VISIT then
		priceText = winMgr:getWindow("sj_MyShopSellInput_granText"):getUserString("itemPrice")
	end
	
	if priceText == "" then
		priceText = "0"
	end
	local inputOnePrice = tonumber(priceText)
	
	-- ������ ��´�.
	local amountText = winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- ���� ������ ������ ���ؼ� ���Ѵ�.
	local limitAmount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(limitAmount))
	end
	
	local totalPriceText, r, g, b = ConvertStringToMultiple(inputOnePrice, inputAmount)
	winMgr:getWindow("sj_MyShopSellInput_totalPriceText"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopSellInput_totalPriceText"):setText(totalPriceText)
end


-- ��� ��ư
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

-- ���� ��ư
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

-- ���� ��ư
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

-- ��� ��ư
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

-- �ݱ��ư
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


-- �ݱ��ư ������
function ClickedSellInputClose()
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("")
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText("")	
end


---------------------------------------
-- 1. ���� �Է�â ȣ��
---------------------------------------
function CallSellInputPopup()
	
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()

	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- ���â �̹���(���)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 0)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 0)
	
	-- ���, ��ҹ�ư true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(false)
	
	-- ���簡��, ��ϼ���, �Ѱ��� �����̹��� true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(false)
	
	-- ������ �̹���
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  ��ų���� �����ֱ�
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
	
	-- ������ �̸�
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", itemCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- �׶� ����(���Ŷ��� �ʿ�)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(false)
	
	-- ���簡�� �Է�ĭ, �Է� ����Ʈ �ڽ� true
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
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
		
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):activate()
end

-- MyItem���� -> Regist�� ����Ҷ�
function ClickedRegistInputSellItem()

	if myShopSellInputWindow:isVisible() == false then
		return
	end
	
	LimitGranEditbox()

	-- ����ϱ�
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
-- 2. ���� �Է�â ȣ��
---------------------------------------
function CallModifyInputPopup()
	
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()
	
	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- ���â �̹���(����)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 32)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 32)
	
	-- ����, ��ҹ�ư true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(false)
	
	-- ���簡��, ��ϼ���, �Ѱ��� �����̹��� true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(false)
	
	-- ������ �̹���
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  ��ų���� �����ֱ�
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("+"..itemGrade)
	else
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("")
	end
	
	-- ������ �̸�
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(enableCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", enableCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- �׶� ����(���Ŷ��� �ʿ�)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(false)
	
	-- ���簡�� �Է�ĭ, �Է� ����Ʈ �ڽ� true
	winMgr:getWindow("sj_MyShopSellInput_InputOnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText(tostring(itemCount))
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setText(tostring(itemPrice))
	
	if IsSpecialMyShopMode() == MYSHOP_TYPE_MEGA then
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(9)
	else
		CEGUI.toEditbox(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox")):setMaxTextLength(8)
	end
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
end


-- Regist�������� �����ؼ� �ٽ� ����� ��
function ClickedModifyItem()
	if myShopSellInputWindow:isVisible() == false then
		return
	end
	
	LimitGranEditbox()

	-- ����ϱ�
	local useCount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText())
	local sellGran = tonumber(winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):getText())
	
	local bSuccess = RequestSellItemRegist(useCount, sellGran, true)
	if bSuccess then
		ClickedSellInputClose()
	end
end



---------------------------------------
-- 3. ����â ȣ��
---------------------------------------
function CallBuyPopup()
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemPrice, itemGrade, avatarType , attach = GetSelectItemInfo()

	root:addChildWindow(winMgr:getWindow("sj_SellInputAlphaImage"))
	winMgr:getWindow("sj_SellInputAlphaImage"):setVisible(true)
	
	-- ���â �̹���(����)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 16)
	winMgr:getWindow("sj_MyShopSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 16)
	
	-- ����, ��ҹ�ư true
	winMgr:getWindow("sj_MyShopSellInput_RegistBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_ModifyBtn"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyBtn"):setVisible(true)
	
	-- ���簡��, ��ϼ���, �Ѱ��� �����̹��� true
	winMgr:getWindow("sj_MyShopSellInput_OnePriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_TotalPriceImage"):setVisible(true)
	winMgr:getWindow("sj_MyShopSellInput_RegistAmountImage"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_BuyAmountImage"):setVisible(true)
	
	-- ������ �̹���
	winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyShopSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyShopSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyShopSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	--  ��ų���� �����ֱ�
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("+"..itemGrade)
	else
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyShopSellInput_SkillLevelText"):setText("")
	end
	
	-- ������ �̸�
	winMgr:getWindow("sj_MyShopSellInput_Name"):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("sj_MyShopSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyShopSellInput_Num"):setUserString("itemCount", itemCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("sj_MyShopSellInput_Period"):setText(period)
	
	-- �׶� ����(���Ŷ��� �ʿ�)
	local granText = CommatoMoneyStr(itemPrice)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setVisible(true)
	
	local r,g,b = GetGranColor(tonumber(itemPrice))
	winMgr:getWindow("sj_MyShopSellInput_granText"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setText(granText)
	winMgr:getWindow("sj_MyShopSellInput_granText"):setUserString("itemPrice", itemPrice)
	
	-- ���簡�� �Է�ĭ, �Է� ����Ʈ �ڽ� false
	winMgr:getWindow("sj_MyShopSellInput_InputOnePriceImage"):setVisible(false)
	winMgr:getWindow("sj_MyShopSellInput_Gran_editbox"):setVisible(false)	
	
	if itemCount == 1 then
		winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):setText("1")
	end
	winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):activate()
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIcon("sj_MyShopSellInput_Image" , "sj_MyShopSellInput_BackImage" , avatarType , attach)
end


-- ������ �����ϱ����� �����.
function ClickedBuyItem()

	-- %s ������ %s����\n%s�׶��� �����Ͻðڽ��ϱ�?�� �����.
	local inputCount = tonumber(winMgr:getWindow("sj_MyShopSellInput_Count_editbox"):getText())
	AskPurchaseItem(inputCount)
end


-- ���Ÿ� �Ҷ�
function OnClickMyShopBuyOk()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMyShopBuyOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- ���� ok
	ClickedRequestPurchaseItem()
	ClickedSellInputClose()
end

-- ���Ÿ� ���� ��
function OnClickMyShopBuyCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickMyShopBuyCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
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
	
	-- ���õ� �������� ������ ��´�.
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)

end









-------------------------------------------------------------

-- 4. �������� ��ư

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
		
		-- �غ���, ǰ���� ��
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
			-- ���̼� ��ǳ���� �ٴ� ������ ���� �̹���
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
		
		-- �غ���, ǰ���� ��
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
		
		-- �Ǹ����� ��
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





-- ���̼� ��ǳ�� Ŭ��
function ClickedMyShopTitle(args)
	
	-- ������ ������ �غ����� ���� ���úҰ�
	local characterKey = CEGUI.toWindowEventArgs(args).window:getUserString("characterKey")
	if GetIsVisitMyShop(characterKey) == false then
		return
	end
	
	-- ���� �Ǹ����� ���� ���ż��� �Ұ�
	local myShopState = GetMyShopState()
	if myShopState == MYSHOP_MODE_READY		or
	   myShopState == MYSHOP_MODE_MODIFY	or
	   myShopState == MYSHOP_MODE_SELLING then
		return
	end
		
	-- ���湮 �޼��� ������
	ClickedMyShopTitleToVisit(characterKey)
end



-- ���̼� ��ǳ���� �����ش�  ( �ؽ�Ʈ ��ġ���� ����)
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
		local boolPosX = 0	-- ��ǳ�� ��ġ
		local boolPosY = 0	-- ��ǳ�� ��ġ
		local textPosX = 0	-- ������ ��ġ
		local textPosY = 0	-- ������ ��ġ
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


-- ���� ��ǳ�� Ÿ��Ʋ �����ֱ�(��ư�� EndRender�� ���δ�)
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

-- 5. ���� �湮�� ��� ����(�ǸŽ��� ��ư��, ���Ź�ư���� �ٲ��� �Ѵ�)

-------------------------------------------------------------
function SetMyShopVisit(myShopName, title)
		
	-- ���� �̸�
	winMgr:getWindow("sj_MyShopRegistItemList_shopName"):setTextExtends(myShopName, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
	
	-- ���� ����
	local summaryTitle = SummaryString(g_STRING_FONT_GULIMCHE, 12, title, 170)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setVisible(false)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleEditbox"):setText("")	
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setVisible(true)
	winMgr:getWindow("sj_MyShopRegistItemList_TitleText"):setText(summaryTitle)
	
	-- ���� ������ ����Ʈ ���̱�
	SetupMyShopWindows(true)
end





-------------------------------------------------------------

-- 6. ����

-------------------------------------------------------------
-- ���� ����
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

-- ���� �ݱ�
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

-- 7. �Ǹű�� ����(���� �Ǹŵ��(Regist) ������â�� ���δ�

-------------------------------------------------------------
-- �Ǹű�� ��ư
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


-- �Ǹű�� �����̹���
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

-- �Ǹű�� �ݱ��ư
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

-- ESC���
RegistEscEventInfo("sj_RegistMyShopSellRecord_backImage", "ClickedSellRecordClose")


for i=0, MAX_SELL_RECORDLIST-1 do

	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RegistMyShopSellRecord_temp"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, i*17+60)
	mywindow:setSize(566, 16)
	mywindow:setZOrderingEnabled(false)
	myrecordwindow:addChildWindow(mywindow)
	
	-- 1. ������
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_BuyerName_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(0, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 2. �Ǹ��� ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldItem_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(140, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 3. �Ǹ��� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldCount_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(290, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 4. �Ǹ��� ����(������ ����)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RegistMyShopSellRecord_SoldPrice_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(390, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):addChildWindow(mywindow)
	
	-- 5. ��¥(�ð�)
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



-- �Ǹű�� ���� ������ / �ִ� ������
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

-- ������ �¿� ��ư
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



-- �Ǹű�� �ʱ�ȭ
function ClearSellRecord()
	for i=0, MAX_SELL_RECORDLIST-1 do
		winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):setVisible(false)
	end
end

-- �Ǹű�� ����
function SetupSellRecord(i, buyerName, soldItem, soldCount, soldPrice, dateSold, r, g, b)
	winMgr:getWindow("sj_RegistMyShopSellRecord_temp"..i):setVisible(true)
	
	-- 1. ������
	local size = GetStringSize(g_STRING_FONT_GULIM, 12, buyerName)
	winMgr:getWindow("sj_RegistMyShopSellRecord_BuyerName_"..i):setPosition(64-size/2, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_BuyerName_"..i):setText(buyerName)
	
	--- 2. �Ǹ��� ������ �̸�
	local summaryItemName = SummaryString(g_STRING_FONT_GULIMCHE, 12, soldItem, 150)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldItem_"..i):setText(summaryItemName)
	
	-- 3. �Ǹ��� ����
	size = GetStringSize(g_STRING_FONT_GULIM, 12, soldCount)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldCount_"..i):setPosition(346-size/2, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldCount_"..i):setText(soldCount)
	
	-- 4. �Ǹ��� ����(������ ����)
	size = GetStringSize(g_STRING_FONT_GULIM, 12, soldPrice)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setPosition(482-size, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_RegistMyShopSellRecord_SoldPrice_"..i):setText(soldPrice)
	
	-- 5. ��¥(�ð�)
	size = GetStringSize(g_STRING_FONT_GULIM, 12, dateSold)
	winMgr:getWindow("sj_RegistMyShopSellRecord_DateSold_"..i):setPosition(556-size, 0)
	winMgr:getWindow("sj_RegistMyShopSellRecord_DateSold_"..i):setText(dateSold)
end


function SetSellRecordWindow(bVisible)
	if winMgr:getWindow("sj_RegistMyShopSellRecord_backImage") then
		winMgr:getWindow("sj_RegistMyShopSellRecord_backImage"):setVisible(bVisible)
	end
end






-- ����â
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

--- OK �˸�â
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

-- �ؽ�Ʈ
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

-- �˸�â Ȯ�ι�ư(OK)
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
	winMgr:getWindow('sj_myshop_OkBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
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

