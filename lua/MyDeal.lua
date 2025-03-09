--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local g_STRING_USING_PERIOD		= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- 사용기간
local g_STRING_UNTIL_DELETE		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- 삭제시까지
local g_STRING_AMOUNT			= PreCreateString_1526	--GetSStringInfo(LAN_CPP_VILLAGE_14)			-- 수량
local g_STRING_COMPLETE			= PreCreateString_2241	--GetSStringInfo(LUA_TRADE_COMPLETE)			-- %s님과의 교환이 완료되었습니다.
local g_STRING_CANCEL_REQUEST	= PreCreateString_2243	--GetSStringInfo(LUA_TRADE_CANCEL_REQUEST)		-- %s님과의 1:1교환을 취소하시겠습니까?
local g_STRING_IMPOSSIBLE1		= PreCreateString_2244	--GetSStringInfo(LUA_TRADE_IMPOSSIBLE1)			-- 파티상태에서는 교환이 불가능합니다.
local g_STRING_IMPOSSIBLE2		= PreCreateString_2245	--GetSStringInfo(LUA_TRADE_IMPOSSIBLE2)			-- %s님이 파티중입니다.\n교환이 불가능합니다.
local g_STRING_IMPOSSIBLE3		= PreCreateString_2246	--GetSStringInfo(LUA_TRADE_IMPOSSIBLE3)			-- 현재 교환이 불가능한 상태입니다.


--local tGradeferPersent	= {['err'] = 0, 1,2,3,5,7,9,14,20,27,35}	-- 스킬 그레이드에따른 추가데미지 테이블


local WINDOW_MYITEM_LIST = 0
local WINDOW_REGIST_LIST_ME  = 1
local WINDOW_REGIST_LIST_YOU = 2
local WINDOW_SELECT_LIST = 3

-- 나의 거래 목록 리스트 종류
local MYDEALLIST_COSTUME	= 0
local MYDEALLIST_ETC		= 1
local MYDEALLIST_SPECIAL	= 2
local MYDEALLIST_SKILL		= 3
local g_currentMyDealList	= GetCurrentMyItemMode()
function SetCurrentMyItemModeToDeal(myItemMode)
	g_currentMyDealList = myItemMode
	
	for i=0, #tMyDealItemListName do
		if winMgr:getWindow(tMyDealItemListName[i]) then
			winMgr:getWindow(tMyDealItemListName[i]):setProperty("Selected", "false")
		end
	end
	
	if winMgr:getWindow(tMyDealItemListName[g_currentMyDealList]) then
		winMgr:getWindow(tMyDealItemListName[g_currentMyDealList]):setProperty("Selected", "true")
	end
end

-- 현재 나의 아이템 목록 페이지
local g_curPage_ItemList = 1
local g_maxPage_ItemList = 1

-- 현재 내가 등록한 목록 페이지
local g_curPage_RegistList_Me = 1
local g_maxPage_RegistList_Me = 1

-- 현재 다른 사람이 등록한 목록 페이지
local g_curPage_RegistList_You = 1
local g_maxPage_RegistList_You = 1

local MAX_DEALITEM_LIST = GetMaxMyItemListNum()			-- 나의 목록 리스트 최대개수
local DEALITEM_LIST_1PAGE_NUM = GetMaxRegistListNum()	-- 나의 등록 리스트 최대개수

local g_myFixedDeal = false	-- 내가 물품확정을 했는지 안했는지
local POSX_ME = 300	-- 차이 294

local g_responseItemTrade = false


function SkillDescDivideToMyDeal(str)
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


-- 거래를 요청한다.
function ClickedRequestItemTrade(userName)
	RequestItemTrade(userName)
end

-- 거래 요청을 받는다(%s님이 1:1교환을 신청하셨습니다.\n수락하시겠습니까?)
local g_tradeUserName = ""
function ResponsedItemTrade(tradeUserName, responseMessage)
	g_tradeUserName = tradeUserName
	g_responseItemTrade = true
	ShowCommonAlertOkCancelBoxWithFunction("", responseMessage, "OnClickTradeRequestOk", "OnClickTradeRequestCancel")
end

-- 거래를 하거나 닫을때 설정한다.
local NORMAL_USER = 0
local MERCHANT_USER = 1
local TOPSPENDER_USER = 2
local GAMEMASTER_USER = 3
function SetItemTrade(bTrade, bResponse)
	root:addChildWindow(winMgr:getWindow("sj_MyDealAlphaImage"))
	winMgr:getWindow("sj_MyDealAlphaImage"):setVisible(bTrade)
	
	if bTrade then
		myLevel, tradeUserLevel, myName, tradeUserName, myImageKey, tradeUserImageKey, myType, tradeUserType = GetMyDealUserInfo()

		-- 내정보 설정
		if myImageKey > 0 then
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setVisible(true)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setTexture("Enabled", "UIData/Profile/"..myImageKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setTexture("Disabled", "UIData/Profile/"..myImageKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setScaleWidth(130)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setScaleHeight(130)
		else
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_Me"):setVisible(false)
		end
		winMgr:getWindow("sj_MyDealRegistItemList_Level_Me"):setText("Lv."..myLevel)
		winMgr:getWindow("sj_MyDealRegistItemList_Name_Me"):setText(myName)
		
		if myType == NORMAL_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		elseif myType == MERCHANT_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Enabled", "UIData/ItemUIData/Costume/Common/I_HairUp/Common_HairUp_100.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Disabled", "UIData/ItemUIData/Costume/Common/I_HairUp/Common_HairUp_100.tga", 0, 0)
		elseif myType == TOPSPENDER_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Enabled", "UIData/ItemUIData/top_spender.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Disabled", "UIData/ItemUIData/top_spender.tga", 0, 0)
		elseif myType == GAMEMASTER_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Enabled", "UIData/ItemUIData/none.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_Me"):setTexture("Disabled", "UIData/ItemUIData/none.tga", 0, 0)
		end
		
		-- 나랑 거래하는 유저 설정
		if tradeUserImageKey > 0 then
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setVisible(true)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setTexture("Enabled", "UIData/Profile/"..tradeUserImageKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setTexture("Disabled", "UIData/Profile/"..tradeUserImageKey..".tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setScaleWidth(130)
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setScaleHeight(130)
		else
			winMgr:getWindow("sj_MyDealRegistItemList_ProfileImage_You"):setVisible(false)
		end
		winMgr:getWindow("sj_MyDealRegistItemList_Level_You"):setText("Lv."..tradeUserLevel)
		winMgr:getWindow("sj_MyDealRegistItemList_Name_You"):setText(tradeUserName)
		
		if tradeUserType == NORMAL_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		elseif tradeUserType == MERCHANT_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Enabled", "UIData/ItemUIData/Costume/Common/I_HairUp/Common_HairUp_100.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Disabled", "UIData/ItemUIData/Costume/Common/I_HairUp/Common_HairUp_100.tga", 0, 0)
		elseif tradeUserType == TOPSPENDER_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Enabled", "UIData/ItemUIData/top_spender.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Disabled", "UIData/ItemUIData/top_spender.tga", 0, 0)
		elseif tradeUserType == GAMEMASTER_USER then
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Enabled", "UIData/ItemUIData/none.tga", 0, 0)
			winMgr:getWindow("sj_MyDealRegistItemList_GMImage_You"):setTexture("Disabled", "UIData/ItemUIData/none.tga", 0, 0)
		end
		
		-- 다른유저가 나한테 교환요청을 했는데 내가 요청한 다른사람하고 교환이 성사될때
		if g_responseItemTrade then
			g_responseItemTrade = false
			
			if winMgr:getWindow('CommonAlertAlphaImg') then
				winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
				winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
				root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
				local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
				winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
				local_window:setVisible(false)
			end
		end
		
		-- 사기 주의 메세지
		OnChatPrivateMyDeal('', PreCreateString_4639, 1)
									--GetSStringInfo(LAN_TRADE_CHAT_001)
		
		if tradeUserType == NORMAL_USER and myType == NORMAL_USER then
			OnChatPrivateMyDeal('', PreCreateString_7262, 3)
		end

		winMgr:getWindow("sj_MyDealChat_editbox"):activate()
	else		
		winMgr:getWindow("sj_MyDealChat_editbox"):deactivate()
		winMgr:getWindow("sj_MyDealChat_chatting"):clearTextExtends()
				
		ClickedSellInputCloseToDeal()
		ClickedGranInputCloseToDeal()
	end
	
	if bResponse then
		ResponseItemTrade(bTrade, "")
	end
end


--------------------------------
-- 거래요청 수락
--------------------------------
function OnClickTradeRequestOk()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickTradeRequestOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 거래요청 OK
	ResponseItemTrade(true, g_tradeUserName)
	g_responseItemTrade = false
	g_tradeUserName = ""
end


--------------------------------
-- 거래요청 취소
--------------------------------
function OnClickTradeRequestCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickTradeRequestCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 거래요청 CANCEL
	SetItemTrade(false, true)
	g_responseItemTrade = false
	g_tradeUserName = ""
end



-------------------------------------------------------------

-- 1. 거래 바탕

-------------------------------------------------------------
-- 메세지 알파 이미지
myDealAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealAlphaImage")
myDealAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealAlphaWindow:setProperty("FrameEnabled", "False")
myDealAlphaWindow:setProperty("BackgroundEnabled", "False")
myDealAlphaWindow:setPosition(0, 0)
myDealAlphaWindow:setSize(1920, 1200)
myDealAlphaWindow:setVisible(false)
myDealAlphaWindow:setAlwaysOnTop(true)
myDealAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(myDealAlphaWindow)

-- 거래 바탕 이미지
myDealBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealBackImage")
myDealBackWindow:setTexture("Enabled", "UIData/messenger2.tga", 0, 0)
myDealBackWindow:setTexture("Disabled", "UIData/messenger2.tga", 0, 0)
myDealBackWindow:setProperty("FrameEnabled", "False")
myDealBackWindow:setProperty("BackgroundEnabled", "False")
myDealBackWindow:setWideType(6);
myDealBackWindow:setPosition(50, 50)
myDealBackWindow:setSize(590, 647)
myDealBackWindow:setAlwaysOnTop(true)
myDealBackWindow:setZOrderingEnabled(false)
myDealAlphaWindow:addChildWindow(myDealBackWindow)

-- 거래 바탕 툴팁
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyDealBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(554, 30)
myDealBackWindow:addChildWindow(mywindow)

-- 거래 닫기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealCloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(560, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedAskMyDealClose")
myDealBackWindow:addChildWindow(mywindow)

function OnClickedAskMyDealClose(args)
	local myTradeUserName = GetMyTradeUserName()
	ShowCommonAlertOkCancelBoxWithFunction("", string.format(g_STRING_CANCEL_REQUEST, myTradeUserName), "OnClickTradeCloseOk", "OnClickTradeCloseCancel")
end

-- ESC등록
RegistEscEventInfo("sj_MyDealAlphaImage", "OnClickedAskMyDealClose")

--------------------------------
-- 거래닫기 수락
--------------------------------
function OnClickTradeCloseOk()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickTradeCloseOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	-- 거래닫기 OK
	SetItemTrade(false, true)	
end


--------------------------------
-- 거래닫기 취소
--------------------------------
function OnClickTradeCloseCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickTradeCloseCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
end



-------------------------------------------------------------

-- 1:1 거래 채팅하기

-------------------------------------------------------------
-- 채팅 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyDealChat_editbox")
mywindow:setPosition(4, 623)
mywindow:setSize(556, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setSubscribeEvent("TextAccepted", "OnTextAcceptedMyDeal");
CEGUI.toEditbox(mywindow):setMaxTextLength(90)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEventToDeal")
myDealBackWindow:addChildWindow(mywindow)

function OnTextAcceptedMyDeal()
	local accept_text = winMgr:getWindow("sj_MyDealChat_editbox"):getText()
	local myTradeUserName = GetMyTradeUserName()
	SendPrivateMsg("/w "..myTradeUserName.." "..accept_text)
	winMgr:getWindow('sj_MyDealChat_editbox'):setText("")
end

mywindow = winMgr:createWindow("TaharezLook/MultiLineEditbox", "sj_MyDealChat_chatting")
mywindow:setProperty("ReadOnly", "true")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(0, 490)
mywindow:setSize(590, 125)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setLineSpacing(12)
mywindow:clearTextExtends()
myDealBackWindow:addChildWindow(mywindow)

function OnChatPrivateMyDeal(name, message, specialType)
	local multi_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow("sj_MyDealChat_chatting"))
	if multi_line_text == null then
		return
	end
	
	if multi_line_text:getLineCount() > 50 then
		multi_line_text:removeLine(0)
	end	
	
	local tFontData = ChatNormalFontData
	if specialType == 1 then
		tFontData = SpecialZMFontData 
	elseif specialType == 2 then
		tFontData = SpecialSultanFontData
	elseif specialType == 3 then
		tFontData = ChatGMFontData
	end

	multi_line_text:addTextExtends(name..message..'\n',tFontData[1],tFontData[2],
			tFontData[3],tFontData[4],tFontData[5],tFontData[6],
			tFontData[7], 
			tFontData[8],tFontData[9],tFontData[10],tFontData[11])
end

function OnChatPrivateMyDeal2(message, specialType)
	local multi_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow("sj_MyDealChat_chatting"))
	if multi_line_text == null then
		return
	end
	
	if multi_line_text:getLineCount() > 50 then
		multi_line_text:removeLine(0)
	end	
	
	local tFontData = ChatNormalFontData
	if specialType == 1 then
		tFontData = SpecialZMFontData 
	elseif specialType == 2 then
		tFontData = SpecialSultanFontData
	elseif specialType == 3 then
		tFontData = ChatGMFontData
	end

	multi_line_text:addTextExtends(message..'\n',tFontData[1],tFontData[2],
			tFontData[3],tFontData[4],tFontData[5],tFontData[6],
			tFontData[7], 
			tFontData[8],tFontData[9],tFontData[10],tFontData[11])
end


-- 채팅 현재 아이콘(한국, 영어, 태국어...)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealChat_languageImage")
mywindow:setTexture("Enabled", "UIData/GameNewImage.tga", 404, 964)
mywindow:setTexture("Disabled", "UIData/GameNewImage.tga", 404, 964)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(568, 624)
mywindow:setSize(16, 17)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 한글, 영문모드인지 아이콘을 보여준다
function OnEndRenderMyDealBackImage(args)
	local hanmode = CurrentHanMode()
	if hanmode == 0 then
		winMgr:getWindow("sj_MyDealChat_languageImage"):setTexture("Enabled", "UIData/GameNewImage.tga", 404, 964)
	else
		winMgr:getWindow("sj_MyDealChat_languageImage"):setTexture("Enabled", "UIData/GameNewImage.tga", 404, 981)
	end
end
winMgr:getWindow("sj_MyDealBackImage"):subscribeEvent("EndRender", "OnEndRenderMyDealBackImage" )





-------------------------------------------------------------

-- 2. 나의 아이템 리스트창

-------------------------------------------------------------
myDealItemListWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemListBackImage")
myDealItemListWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
myDealItemListWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
myDealItemListWindow:setProperty("FrameEnabled", "False")
myDealItemListWindow:setProperty("BackgroundEnabled", "False")
myDealItemListWindow:setWideType(6);
myDealItemListWindow:setPosition(680, 170)
myDealItemListWindow:setSize(296, 438)
myDealItemListWindow:setAlwaysOnTop(true)
myDealItemListWindow:setZOrderingEnabled(false)
myDealAlphaWindow:addChildWindow(myDealItemListWindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyDealItemListBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myDealItemListWindow:addChildWindow(mywindow)

-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_PageText")
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
myDealItemListWindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tMyDealItemList_BtnName  = {["err"]=0, [0]="sj_MyDealItemList_LBtn", "sj_MyDealItemList_RBtn"}
local tMyDealItemList_BtnTexX  = {["err"]=0, [0]=987, 970}
local tMyDealItemList_BtnPosX  = {["err"]=0, [0]=170, 270}
local tMyDealItemList_BtnEvent = {["err"]=0, [0]="OnClickMyDealItemList_PrevPage", "OnClickMyDealItemList_NextPage"}
for i=0, #tMyDealItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyDealItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyDealItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyDealItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyDealItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyDealItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyDealItemList_BtnPosX[i], 370)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyDealItemList_BtnEvent[i])
	myDealItemListWindow:addChildWindow(mywindow)
end


function OnClickMyDealItemList_PrevPage()
	if g_curPage_ItemList > 1 then
		g_curPage_ItemList = g_curPage_ItemList - 1
		ChangedMyDealItemListCurrentPage(g_curPage_ItemList)
	end
end

function OnClickMyDealItemList_NextPage()
	if g_curPage_ItemList < g_maxPage_ItemList then
		g_curPage_ItemList = g_curPage_ItemList + 1
		ChangedMyDealItemListCurrentPage(g_curPage_ItemList)
	end
end


-- 그랑 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_GranImage")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 371)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myDealItemListWindow:addChildWindow(mywindow)

-- 현재 나의 그랑
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(44, 371)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
myDealItemListWindow:addChildWindow(mywindow)


-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
tMyDealItemListName  = {["err"]=0, [0]="sj_MyDealItemList_costume", "sj_MyDealItemList_etc", "sj_MyDealItemList_special", "sj_MyDealItemList_skill"}
tMyDealItemListTexX  = {["err"]=0, [0]=0, 140, 210, 70}
tMyDealItemListPosX  = {["err"]=0, [0]=4, 76, 148, 220}
tMyDealItemListEvent = {["err"]=0, [0]="OnSelect_CostumeToDeal", "OnSelect_EtcToDeal", "OnSelect_SpecialToDeal", "OnSelect_SkillToDeal"}
for i=0, #tMyDealItemListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyDealItemListName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tMyDealItemListTexX[i], 455)
	mywindow:setTexture("Hover", "UIData/deal.tga", tMyDealItemListTexX[i], 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tMyDealItemListTexX[i], 497)
	mywindow:setTexture("Disabled", "UIData/deal.tga", tMyDealItemListTexX[i], 455)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", tMyDealItemListTexX[i], 497)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", tMyDealItemListTexX[i], 497)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", tMyDealItemListTexX[i], 497)
	mywindow:setPosition(tMyDealItemListPosX[i], 39)
	mywindow:setProperty("GroupID", 7019)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("SelectStateChanged", tMyDealItemListEvent[i])
	
	if i == g_currentMyDealList then
		mywindow:setProperty("Selected", "true")
	end
	myDealItemListWindow:addChildWindow(mywindow)
end


-- 1.코스츔을 선택했을 때
function OnSelect_CostumeToDeal(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyDealItemList_costume")):isSelected() then
		g_currentMyDealList = MYDEALLIST_COSTUME
		ChangedMyDealItemList(g_currentMyDealList)
	end
end

-- 2.기타를 선택했을 때
function OnSelect_EtcToDeal(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyDealItemList_etc")):isSelected() then
		g_currentMyDealList = MYDEALLIST_ETC
		ChangedMyDealItemList(g_currentMyDealList)
	end
end

-- 3.강화를 선택했을 때
function OnSelect_SpecialToDeal(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyDealItemList_special")):isSelected() then
		g_currentMyDealList = MYDEALLIST_SPECIAL
		ChangedMyDealItemList(g_currentMyDealList)
	end
end

-- 4.스킬을 선택했을 때
function OnSelect_SkillToDeal(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sj_MyDealItemList_skill")):isSelected() then
		g_currentMyDealList = MYDEALLIST_SKILL
		ChangedMyDealItemList(g_currentMyDealList)
	end
end




-- 아이템 리스트 판매목록
for i=0, MAX_DEALITEM_LIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_MyDealItemList_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+70)
	mywindow:setProperty("GroupID", 7029)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	myDealItemListWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 코스튬 아바타 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_BackImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지 
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_TypeImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_MyItemListInfoToDeal")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltipToDeal")
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealItemList_RegistBtn_"..i)
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
	mywindow:subscribeEvent("Clicked", "OnClickedRegistDealItem")
	winMgr:getWindow("sj_MyDealItemList_"..i):addChildWindow(mywindow)
end


-- 아이템창을 덮는 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealItemListTempImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 30)
mywindow:setSize(296, 400)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
myDealItemListWindow:addChildWindow(mywindow)


-- 이미지에 마우스가 들어오면 툴팁을 보여준다.
function OnMouseEnter_MyItemListInfoToDeal(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
		
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber, attributeType = GetMyDealItemTooltipInfo(WINDOW_MYITEM_LIST, index)
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
	
	-- 코스튬 아바타 관련 툴팁 변경을 위해 
	-- 0이 들어가던 슬롯인덱스를 -8로 고정. 고치면 안됨 ★
	GetToolTipBaseInfo(x + 50, y, 2, Kind, -8, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_VanishTooltipToDeal(args)
	SetShowToolTip(false)	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()
end


-- 아이템 등록 버튼을 누를때
function OnClickedRegistDealItem(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local bEnable = SelectMyDealItemToRegist(tonumber(index))
	
	-- 등록할 아이템 입력창을 호출한다.
	if bEnable then
		CallSellInputPopupToDeal(index, itemCount, itemName, itemFileName)
	end
end



-------------------------------------------------------------------
-- 나의 아이템 리스트에 아이템 목록 설정
-------------------------------------------------------------------
-- 내아이템 목록 초기화
function ClearMyDealItemList()
	for i=0, MAX_DEALITEM_LIST-1 do
		winMgr:getWindow("sj_MyDealItemList_"..i):setVisible(false)
		winMgr:getWindow("sj_MyDealItemList_RegistBtn_"..i):setVisible(false)
	end
end

-- 현재 내아이템 목록에 존재하는 아이템만 설정
function SetupMyDealItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade, avatarType , attach)
	winMgr:getWindow("sj_MyDealItemList_"..i):setVisible(true)
	winMgr:getWindow("sj_MyDealItemList_RegistBtn_"..i):setVisible(true)
	
	if avatarType == -2 then
		winMgr:getWindow("sj_MyDealItemList_RegistBtn_"..i):setEnabled(false)
	else
		winMgr:getWindow("sj_MyDealItemList_RegistBtn_"..i):setEnabled(true)
	end
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyDealItemList_Image_"..i):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyDealItemList_Image_"..i):setScaleWidth(102)
	winMgr:getWindow("sj_MyDealItemList_Image_"..i):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyDealItemList_Image_"..i):setLayered(false)
	else
		winMgr:getWindow("sj_MyDealItemList_Image_"..i):setLayered(true)
		winMgr:getWindow("sj_MyDealItemList_Image_"..i):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	
	winMgr:getWindow("sj_MyDealItemList_TypeImage_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyDealItemList_SkillLevelImage_"..i):setVisible(true)
		winMgr:getWindow("sj_MyDealItemList_SkillLevelImage_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyDealItemList_SkillLevelText_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyDealItemList_SkillLevelText_"..i):setText("+"..itemGrade)
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyDealItemList_TypeImage_"..i):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyDealItemList_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("sj_MyDealItemList_SkillLevelText_"..i):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyDealItemList_Name_"..i):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("sj_MyDealItemList_Num_"..i):setText(szCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("sj_MyDealItemList_Period_"..i):setText(period)
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("sj_MyDealItemList_Image_" , "sj_MyDealItemList_Image_" , "sj_MyDealItemList_BackImage_" , i , avatarType , attach)
end


-- 내아이템 리스트 현재 페이지 / 최대 페이지
function MyDealItemListPage(curPage, maxPage)
	g_curPage_ItemList = curPage
	g_maxPage_ItemList = maxPage
	
	winMgr:getWindow("sj_MyDealItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- 현재 나의 그랑을 보여준다.
function ShowMyCurrentGranToDeal(myCurrentGran)
	if winMgr:getWindow("sj_MyDealItemList_MyGran") then
		local r,g,b = GetGranColor(myCurrentGran)
		local granText = CommatoMoneyStr64(myCurrentGran)
		winMgr:getWindow("sj_MyDealItemList_MyGran"):setTextColor(r,g,b,255)		
		winMgr:getWindow("sj_MyDealItemList_MyGran"):setText(granText)
	end
	
	if winMgr:getWindow("sj_MyDealRegistItemList_MyGran") then
		local r,g,b = GetGranColor(myCurrentGran)
		local granText = CommatoMoneyStr64(myCurrentGran)
		winMgr:getWindow("sj_MyDealRegistItemList_MyGran"):setVisible(true)
		winMgr:getWindow("sj_MyDealRegistItemList_MyGran"):setTextColor(r,g,b,255)
		winMgr:getWindow("sj_MyDealRegistItemList_MyGran"):setText(granText)
		
		if winMgr:getWindow("sj_MyDealRegistItemList_GranImage") then
			winMgr:getWindow("sj_MyDealRegistItemList_GranImage"):setVisible(true)
		end
	end
end





-------------------------------------------------------------

-- 3. 등록창

-------------------------------------------------------------
myDealsellInputAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myDealSellInputAlphaImage")
myDealsellInputAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealsellInputAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealsellInputAlphaWindow:setProperty("FrameEnabled", "False")
myDealsellInputAlphaWindow:setProperty("BackgroundEnabled", "False")
myDealsellInputAlphaWindow:setPosition(0, 0)
myDealsellInputAlphaWindow:setSize(1920, 1200)
myDealsellInputAlphaWindow:setVisible(false)
myDealsellInputAlphaWindow:setAlwaysOnTop(true)
myDealsellInputAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(myDealsellInputAlphaWindow)

-- ESC등록
RegistEscEventInfo("sj_myDealSellInputAlphaImage", "ClickedSellInputCloseToDeal")

-- 입력창 윈도우
myDealSellInputWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInputBackImage")
myDealSellInputWindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
myDealSellInputWindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
myDealSellInputWindow:setProperty("FrameEnabled", "False")
myDealSellInputWindow:setProperty("BackgroundEnabled", "False")
myDealSellInputWindow:setWideType(6);
myDealSellInputWindow:setPosition(370, 200)
myDealSellInputWindow:setSize(296, 212)
myDealSellInputWindow:setAlwaysOnTop(true)
myDealSellInputWindow:setZOrderingEnabled(false)
myDealsellInputAlphaWindow:addChildWindow(myDealSellInputWindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyDealSellInputBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myDealSellInputWindow:addChildWindow(mywindow)

-- 등록 글자 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(100, 8)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_Image")
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
myDealSellInputWindow:addChildWindow(mywindow)

-- 코스튬 아바타 백 아이템 이미지 ★
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_BackImage")
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
myDealSellInputWindow:addChildWindow(mywindow)

-- 아이템 특수 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_TypeImage")
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
myDealSellInputWindow:addChildWindow(mywindow)

-- 스킬 레벨 테두리 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(33, 67)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealSellInput_SkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 툴팁 이벤트를 위한 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfoToDeal")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltipToDeal")
myDealSellInputWindow:addChildWindow(mywindow)

-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealSellInput_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 34)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealSellInput_Num")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 50)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemCount", 0)
myDealSellInputWindow:addChildWindow(mywindow)

-- 아이템 기간
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealSellInput_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 66)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 등록수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_RegistAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 수량 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealSellInput_InputAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 123)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
myDealSellInputWindow:addChildWindow(mywindow)

-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyDealSellInput_Count_editbox")
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
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEventToDeal")
myDealSellInputWindow:addChildWindow(mywindow)

function OnEditboxFullEventToDeal(args)
	PlayWave('sound/FullEdit.wav')
end


-- 수량 입력 좌우버튼
local tInputCountLRButtonName  = {["err"]=0, [0]="sj_MyDealSellInput_InputCount_LBtn", "MyDealSellInput_InputCount_RBtn"}
local tInputCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tInputCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tInputCountLRButtonEvent = {["err"]=0, [0]="TradeChagneInputCount_L", "TradeChagneInputCount_R"}
for i=0, #tInputCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tInputCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tInputCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tInputCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setPosition(tInputCountLRButtonPosX[i], 125)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tInputCountLRButtonEvent[i])
	myDealSellInputWindow:addChildWindow(mywindow)
end


-- 수량을 변경한후 그 페이지의 정보를 셋팅해야 한다.
function TradeChagneInputCount_L()
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	if inputAmount <= 0 then
		inputAmount = 0
		winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end


function TradeChagneInputCount_R()

	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):getText()
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("sj_MyDealSellInput_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount + 1
		winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText(tostring(inputAmount))
	end
end


function TradeChangeActive_Count()
	winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):activate()
end


-- 등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealSellInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedRegistInputSellItemToDeal")
myDealSellInputWindow:addChildWindow(mywindow)

-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealSellInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedSellInputCloseToDeal")
myDealSellInputWindow:addChildWindow(mywindow)

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealSellInputClosedBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(266, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedSellInputCloseToDeal")
myDealSellInputWindow:addChildWindow(mywindow)

-- 닫기버튼 누를때
function ClickedSellInputCloseToDeal()
	winMgr:getWindow("sj_myDealSellInputAlphaImage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("sj_myDealSellInputAlphaImage"))
	
	winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText("")
end


---------------------------------------
-- 수량 입력창 호출
---------------------------------------
function CallSellInputPopupToDeal()
	
	local itemCount, itemName, itemFileName, itemFileName2, enableCount, itemGrade, avatarType , attach = GetSelectItemInfoToDeal()

	root:addChildWindow(winMgr:getWindow("sj_myDealSellInputAlphaImage"))
	winMgr:getWindow("sj_myDealSellInputAlphaImage"):setVisible(true)
	DebugStr('itemFileName:'..itemFileName)
	DebugStr('itemFileName2:'..itemFileName2)
	-- 등록창 이미지(등록)
	winMgr:getWindow("sj_MyDealSellInput_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 0)
	winMgr:getWindow("sj_MyDealSellInput_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 0)
	
	-- 등록, 취소버튼 true
	winMgr:getWindow("sj_MyDealSellInput_RegistBtn"):setVisible(true)
	
	-- 등록수량 글자이미지 true
	winMgr:getWindow("sj_MyDealSellInput_RegistAmountImage"):setVisible(true)
	
	-- 아이템 이미지
	winMgr:getWindow("sj_MyDealSellInput_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyDealSellInput_Image"):setScaleWidth(102)
	winMgr:getWindow("sj_MyDealSellInput_Image"):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyDealSellInput_Image"):setLayered(false)
	else
		winMgr:getWindow("sj_MyDealSellInput_Image"):setLayered(true)
		winMgr:getWindow("sj_MyDealSellInput_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("sj_MyDealSellInput_TypeImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelText"):setText("+"..itemGrade)
		
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyDealSellInput_TypeImage"):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("sj_MyDealSellInput_SkillLevelText"):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyDealSellInput_Name"):setText(itemName)
	
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = g_STRING_AMOUNT.." : "..countText
	winMgr:getWindow("sj_MyDealSellInput_Num"):setText(szcount)
	winMgr:getWindow("sj_MyDealSellInput_Num"):setUserString("itemCount", itemCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("sj_MyDealSellInput_Period"):setText(period)
		
	if itemCount == 1 then
		winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText("1")
	end
	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIcon("sj_MyDealSellInput_Image" , "sj_MyDealSellInput_BackImage" , avatarType , attach)
	
end

-- MyItem에서 -> Regist로 등록할때
function ClickedRegistInputSellItemToDeal()

	if myDealSellInputWindow:isVisible() == false then
		return
	end

	-- 등록하기
	local useCount = tonumber(winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):getText())
	local bSuccess = RequestMyDealItemRegist(useCount)
	if bSuccess then
		ClickedSellInputCloseToDeal()
	end
end


function Error_SellCountToDeal()
	winMgr:getWindow("sj_MyDealSellInput_Count_editbox"):setText("")
end



function OnMouseEnter_SelectItemInfoToDeal(args)
		
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 선택된 윈도우의 정보를 얻는다.
	local itemKind, itemNumber, attributeType = GetMyDealItemTooltipInfo(WINDOW_SELECT_LIST, 0)
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
	
	-- 코스튬 아바타 관련 툴팁 변경을 위해 
	-- 0이 들어가던 슬롯인덱스를 -2로 고정. 고치면 안됨 ★
	GetToolTipBaseInfo(x + 50, y, 2, Kind, -2, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.	
	SetShowToolTip(true)	
end




-------------------------------------------------------------

-- 4. 그랑을 입력하기 위한 창

-------------------------------------------------------------
myDealGranInputAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myDealGranInputAlphaImage")
myDealGranInputAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealGranInputAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
myDealGranInputAlphaWindow:setProperty("FrameEnabled", "False")
myDealGranInputAlphaWindow:setProperty("BackgroundEnabled", "False")
myDealGranInputAlphaWindow:setPosition(0, 0)
myDealGranInputAlphaWindow:setSize(1920, 1200)
myDealGranInputAlphaWindow:setVisible(false)
myDealGranInputAlphaWindow:setAlwaysOnTop(true)
myDealGranInputAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(myDealGranInputAlphaWindow)

-- ESC등록
RegistEscEventInfo("sj_myDealGranInputAlphaImage", "ClickedGranInputCloseToDeal")

-- 입력창 윈도우
myDealGranInputWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealGranInputBackImage")
myDealGranInputWindow:setTexture("Enabled", "UIData/messenger2.tga", 612, 491)
myDealGranInputWindow:setTexture("Disabled", "UIData/messenger2.tga", 612, 491)
myDealGranInputWindow:setProperty("FrameEnabled", "False")
myDealGranInputWindow:setProperty("BackgroundEnabled", "False")
myDealGranInputWindow:setPosition(370, 200)
myDealGranInputWindow:setSize(296, 210)
myDealGranInputWindow:setAlwaysOnTop(true)
myDealGranInputWindow:setZOrderingEnabled(false)
myDealGranInputAlphaWindow:addChildWindow(myDealGranInputWindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_MyDealGranInputBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
myDealGranInputWindow:addChildWindow(mywindow)

-- 보유 그랑 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealGranInput_PossesionGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(124, 73)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealGranInputWindow:addChildWindow(mywindow)

-- 그랑 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_MyDealGranInput_editbox")
mywindow:setPosition(120, 118)
mywindow:setSize(110, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
CEGUI.toEditbox(mywindow):setMaxTextLength(8)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEventToDeal")
myDealGranInputWindow:addChildWindow(mywindow)

function OnEditboxFullEventToDeal(args)
	PlayWave('sound/FullEdit.wav')
end

-- 등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealGranInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 176)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedInputGranToDeal")
myDealGranInputWindow:addChildWindow(mywindow)

-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealGranInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 176)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedGranInputCloseToDeal")
myDealGranInputWindow:addChildWindow(mywindow)

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealGranInputClosedBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(266, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedGranInputCloseToDeal")
myDealGranInputWindow:addChildWindow(mywindow)

function Error_RegistGranToDeal()
	winMgr:getWindow("sj_MyDealGranInput_editbox"):setText("")
end

-- 그랑 입력 버튼 누를때
function ClickedInputGranToDeal()
	local registGran = winMgr:getWindow("sj_MyDealGranInput_editbox"):getText()
	RequestMyDealGranRegist(tonumber(registGran))
	
	ClickedGranInputCloseToDeal()
end


-- 닫기버튼 누를때
function ClickedGranInputCloseToDeal()
	winMgr:getWindow("sj_myDealGranInputAlphaImage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("sj_myDealGranInputAlphaImage"))
	
	winMgr:getWindow("sj_MyDealGranInput_editbox"):deactivate()
	winMgr:getWindow("sj_MyDealGranInput_editbox"):setText("")
	winMgr:getWindow("sj_MyDealGranInput_PossesionGran"):setText("")
end



function CallGranInputWindow()
	root:addChildWindow(winMgr:getWindow("sj_myDealGranInputAlphaImage"))
	winMgr:getWindow("sj_myDealGranInputAlphaImage"):setVisible(true)
	
	local myMoney = GetMyMoney()
	local szMyMoney = GetMyPointString()
	local r, g, b = ColorToMoney(myMoney)
	winMgr:getWindow("sj_MyDealGranInput_PossesionGran"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyDealGranInput_PossesionGran"):setText(szMyMoney)
	
	winMgr:getWindow("sj_MyDealGranInput_editbox"):activate()
end




-------------------------------------------------------------

-- 5. 내가 거래할려고 등록한 창

-------------------------------------------------------------
-- 그랑 입력버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealRegistItemList_InputZenBtn")
mywindow:setTexture("Normal", "UIData/messenger2.tga", 590, 375)
mywindow:setTexture("Hover", "UIData/messenger2.tga", 590, 397)
mywindow:setTexture("Pushed", "UIData/messenger2.tga", 590, 419)
mywindow:setTexture("PushedOff", "UIData/messenger2.tga", 590, 375)
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 590, 375)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 590, 441)
mywindow:setPosition(POSX_ME+251, 69)
mywindow:setSize(22, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedRegistDealZen")
myDealBackWindow:addChildWindow(mywindow)

function OnClickedRegistDealZen(args)
	CallGranInputWindow()
end

-- 나의 거래할 그랑 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegist_Gran_Me")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("0")
mywindow:setPosition(POSX_ME+160, 71)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 나의 프로필 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ProfileImage_Me")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(POSX_ME, 24)
mywindow:setSize(64, 64)
mywindow:setScaleWidth(130)
mywindow:setScaleHeight(130)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 나의 레벨
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_Level_Me")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(POSX_ME+40, 35)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 나의 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_Name_Me")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,80,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(POSX_ME+86, 33)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- DK, 또는 GM 또는 ZM 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_GMImage_Me")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(POSX_ME+50, 150)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(500)
mywindow:setScaleHeight(500)
mywindow:setEnabled(false)
mywindow:setAlpha(180)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 아이템 리스트 판매목록
for i=0, DEALITEM_LIST_1PAGE_NUM-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_MyDealRegistItemList_Me_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(POSX_ME+1, i*60+100)
	mywindow:setProperty("GroupID", 7039)
	mywindow:setSize(282, 52)
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	myDealBackWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_Me_"..i)
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
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 코스튬 아바타 관련 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_Me_BackIMG"..i)
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
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_MeType_"..i)
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
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_SkillLevelImage_Me_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_SkillLevelText_Me_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_EventImage_Me_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RegistItemListInfoToDeal_Me")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltipToDeal")
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemName_Me_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemNum_Me_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemPeriod_Me_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
	
	-- 아이템 취소버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealRegistItemList_CancelBtn_Me_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 970, 459)
	mywindow:setTexture("Hover", "UIData/deal.tga", 970, 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 970, 493)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 970, 459)
	mywindow:setTexture("Enabled", "UIData/deal.tga", 970, 459)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 970, 510)
	mywindow:setPosition(260, 2)
	mywindow:setSize(17, 17)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "OnClickedRegistDealItemCancle_Me")
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):addChildWindow(mywindow)
end

function OnClickedRegistDealItemCancle_Me(args)
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	CancelMyDealRegistItem_Me(tonumber(index))
end


function OnMouseEnter_RegistItemListInfoToDeal_Me(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber, attributeType = GetMyDealItemTooltipInfo(WINDOW_REGIST_LIST_ME, index)
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
	
	-- 코스튬 아바타 관련 툴팁 변경을 위해 
	-- 0이 들어가던 슬롯인덱스를 -2로 고정. 고치면 안됨 ★
	GetToolTipBaseInfo(x + 65, y, 2, Kind, -2, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
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


function ClearMyDealRegistItemList_Me(exchangeMyGran)
	for i=0, DEALITEM_LIST_1PAGE_NUM-1 do
		winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):setVisible(false)
		winMgr:getWindow("sj_MyDealRegistItemList_CancelBtn_Me_"..i):setEnabled(true)
	end
	
	-- 거래할 그랑
	local szMyMoney = CommatoMoneyStr(exchangeMyGran)
	local r,g,b = ColorToMoney(exchangeMyGran)
	winMgr:getWindow("sj_MyDealRegist_Gran_Me"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyDealRegist_Gran_Me"):setText(szMyMoney)
end


function SetupMyDealRegistItemList_Me(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade, avatarType , attach)
	winMgr:getWindow("sj_MyDealRegistItemList_Me_"..i):setVisible(true)

	-- 아이템 이미지
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setScaleWidth(102)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setLayered(false)
	else
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setLayered(true)
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_Me_"..i):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_MeType_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_Me_"..i):setVisible(true)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_Me_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_Me_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_Me_"..i):setText("+"..itemGrade)
		
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_MeType_"..i):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_Me_"..i):setVisible(false)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_Me_"..i):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyDealRegistItemList_ItemName_Me_"..i):setText(itemName)
	
	-- 아이템 수량
	local szCount = CommatoMoneyStr(itemUseCount)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemNum_Me_"..i):setText(szCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("sj_MyDealRegistItemList_ItemPeriod_Me_"..i):setText(period)	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("sj_MyDealRegistItemList_ItemImage_Me_" , "sj_MyDealRegistItemList_ItemImage_Me_" , "sj_MyDealRegistItemList_ItemImage_Me_BackIMG"
					, i , avatarType , attach)
end


-- 내가 물품 확정할 경우 보여주는 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_FixedImage_Me")
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 590, 0)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 590, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(POSX_ME-1, 60)
mywindow:setSize(286, 375)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 물품확정, 확정취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealRegistItemList_FixOrNot_Me")
mywindow:setTexture("Normal", "UIData/messenger2.tga", 876, 0)
mywindow:setTexture("Hover", "UIData/messenger2.tga", 876, 20)
mywindow:setTexture("Pushed", "UIData/messenger2.tga", 876, 40)
mywindow:setTexture("PushedOff", "UIData/messenger2.tga", 876, 0)
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 876, 0)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 876, 60)
mywindow:setPosition(POSX_ME+174, 404)
mywindow:setSize(105, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedRegistItemFixed_Me")
myDealBackWindow:addChildWindow(mywindow)

function OnClickedRegistItemFixed_Me(args)
	
	-- 현재 물품확정일 경우는 cancel메세지를 보낸다.
	if g_myFixedDeal then
		CancelMyDealItemTrade()
	else
		AllowMyDealItemTrade()
	end
end

function FixedMyDealItem(bShow)
	winMgr:getWindow("sj_MyDealRegistItemList_FixedImage_Me"):setVisible(bShow)
	
	g_myFixedDeal = bShow
	if bShow then
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Normal", "UIData/messenger2.tga", 876, 92)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Hover", "UIData/messenger2.tga", 876, 112)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Pushed", "UIData/messenger2.tga", 876, 132)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("PushedOff", "UIData/messenger2.tga", 876, 92)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Enabled", "UIData/messenger2.tga", 876, 92)
	else
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Normal", "UIData/messenger2.tga", 876, 0)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Hover", "UIData/messenger2.tga", 876, 20)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Pushed", "UIData/messenger2.tga", 876, 40)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("PushedOff", "UIData/messenger2.tga", 876, 0)
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Enabled", "UIData/messenger2.tga", 876, 0)
	end
end

-- 둘다 확정을 눌렀을 경우
function SetAllowTradeButton(bFlag)
	winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setVisible(bFlag)
	winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setEnabled(bFlag)
end



-- 교환완료 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_MyDealRegistItemList_FinishedTrade_Me")
mywindow:setTexture("Normal", "UIData/messenger2.tga", 612, 375)
mywindow:setTexture("Hover", "UIData/messenger2.tga", 612, 404)
mywindow:setTexture("Pushed", "UIData/messenger2.tga", 612, 433)
mywindow:setTexture("PushedOff", "UIData/messenger2.tga", 612, 375)
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 612, 375)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 612, 462)
mywindow:setPosition(POSX_ME-1, 436)
mywindow:setSize(286, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedRegistItemFinished_Me")
myDealBackWindow:addChildWindow(mywindow)

-- 교환완료 버튼을 누를경우
function OnClickedRegistItemFinished_Me(args)
	ClickedFinishedMyDealItemTrade()
end

-- 내가 교환완료 버튼을 눌렀을 경우
local bClickedFinishedItemTrade = false
function FinishedMyDealItem(bFlag)
	
	if bFlag then
		bClickedFinishedItemTrade = true
		
		-- 교환완료 버튼을 비활성화로 표시
		winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setVisible(true)
		winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setEnabled(false)
		
		-- 확정취소 버튼, 물품확정 버튼으로 변경후 비활성화
		winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setEnabled(false)
		
		-- 물품등록 취소버튼 비활성화
		for i=0, DEALITEM_LIST_1PAGE_NUM-1 do
			if winMgr:getWindow("sj_MyDealRegistItemList_CancelBtn_Me_"..i):isVisible() then
				winMgr:getWindow("sj_MyDealRegistItemList_CancelBtn_Me_"..i):setEnabled(false)
			end
		end
		
		-- 내 아이템 등록도 불가능하게 하기	
		winMgr:getWindow("sj_MyDealItemListTempImage"):setVisible(true)
		
		-- 그랑 입력도 불가능하게 하기
		winMgr:getWindow("sj_MyDealRegistItemList_InputZenBtn"):setEnabled(false)
	
	else
		if bClickedFinishedItemTrade then
			RefreshMyDealUI()
			bClickedFinishedItemTrade = false
		end
	end
end

function RefreshMyDealUI()

	-- 교환완료 버튼 초기화
	winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setVisible(false)
	winMgr:getWindow("sj_MyDealRegistItemList_FinishedTrade_Me"):setEnabled(true)
	
	-- 확정취소 버튼, 물품확정 초기화
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setEnabled(true)
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Normal", "UIData/messenger2.tga", 876, 0)
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Hover", "UIData/messenger2.tga", 876, 20)
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Pushed", "UIData/messenger2.tga", 876, 40)
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("PushedOff", "UIData/messenger2.tga", 876, 0)
	winMgr:getWindow("sj_MyDealRegistItemList_FixOrNot_Me"):setTexture("Enabled", "UIData/messenger2.tga", 876, 0)
	
	winMgr:getWindow("sj_MyDealRegistItemList_FixedImage_Me"):setVisible(false)
	winMgr:getWindow("sj_MyDealRegistItemList_FixedImage_You"):setVisible(false)
	winMgr:getWindow("sj_MyDealRegistItemList_FixedBtnImage_You"):setVisible(false)
	
	-- 내 아이템 등록 가능하게 하기
	winMgr:getWindow("sj_MyDealItemListTempImage"):setVisible(false)
	
	-- 그랑 입력 초기화
	winMgr:getWindow("sj_MyDealRegistItemList_InputZenBtn"):setEnabled(true)
end

-- 거래를 닫을때마다 초기화 한다.
function SetInitMyDealUI()

	RefreshMyDealUI()
	
	-- 등록된 그랑 초기화
	winMgr:getWindow("sj_MyDealRegist_Gran_Me"):setText("0")
	winMgr:getWindow("sj_MyDealRegist_Gran_You"):setText("0")
end


--[[
-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_PageText_Me")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(482, 368)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tMyDealRegistItemList_BtnName_Me  = {["err"]=0, [0]="sj_MyDealRegistItemList_LBtn_Me", "sj_MyDealRegistItemList_RBtn_Me"}
local tMyDealRegistItemList_BtnTexX_Me  = {["err"]=0, [0]=987, 970}
local tMyDealRegistItemList_BtnPosX_Me  = {["err"]=0, [0]=464, 564}
local tMyDealRegistItemList_BtnEvent_Me = {["err"]=0, [0]="OnClickMyDealRegistItemList_PrevPage_Me", "OnClickMyDealRegistItemList_NextPage_Me"}
for i=0, #tMyDealRegistItemList_BtnName_Me do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyDealRegistItemList_BtnName_Me[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_Me[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_Me[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_Me[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_Me[i], 0)
	mywindow:setPosition(tMyDealRegistItemList_BtnPosX_Me[i], 366)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyDealRegistItemList_BtnEvent_Me[i])
	myDealBackWindow:addChildWindow(mywindow)
end


function OnClickMyDealRegistItemList_PrevPage_Me()
	if g_curPage_RegistList_Me > 1 then
		g_curPage_RegistList_Me = g_curPage_RegistList_Me - 1
	--	ChangedRegistItemListCurrentPage(g_curPage_RegistList_Me)
	end
end

function OnClickMyDealRegistItemList_NextPage_Me()
	if g_curPage_RegistList_Me < g_maxPage_RegistList_Me then
		g_curPage_RegistList_Me = g_curPage_RegistList_Me + 1
	--	ChangedRegistItemListCurrentPage(g_curPage_RegistList_Me)
	end
end

-- 나의 등록된 아이템 리스트 현재 페이지 / 최대 페이지
function MyDealRegistItemListPage_Me(curPage, maxPage)
	g_curPage_RegistList_Me = curPage
	g_maxPage_RegistList_Me = maxPage
	
	winMgr:getWindow("sj_MyDealRegistItemList_PageText_Me"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end
--]]



-------------------------------------------------------------

-- 6. 나와 거래하는 유저가 등록한 창

-------------------------------------------------------------
-- 상대편 프로필 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ProfileImage_You")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 24)
mywindow:setSize(64, 64)
mywindow:setScaleWidth(130)
mywindow:setScaleHeight(130)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 상대편 레벨
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_Level_You")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(47, 35)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 상대편 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_Name_You")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(91, 33)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- DK, 또는 GM 또는 ZM 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_GMImage_You")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(50, 150)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(500)
mywindow:setScaleHeight(500)
mywindow:setEnabled(false)
mywindow:setAlpha(180)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 나의 거래 그랑 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegist_Gran_You")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("0")
mywindow:setPosition(160, 71)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 아이템 리스트 판매목록
for i=0, DEALITEM_LIST_1PAGE_NUM-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_MyDealRegistItemList_You_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+100)
	mywindow:setProperty("GroupID", 7049)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	myDealBackWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_You_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 코슻튬 아바타 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_You_BackIMG"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_ItemImage_YouType_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_SkillLevelImage_You_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_SkillLevelText_You_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_EventImage_You_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RegistItemListInfoToDeal_You")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltipToDeal")
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemName_You_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemNum_You_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_ItemPeriod_You_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):addChildWindow(mywindow)
end


-- 내가 물품 확정할 경우 보여주는 테두리 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_FixedImage_You")
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 590, 0)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 590, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 60)
mywindow:setSize(286, 375)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 교환확정 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_MyDealRegistItemList_FixedBtnImage_You")
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 876, 60)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 876, 60)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(180, 404)
mywindow:setSize(105, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

function FixedYourDealItem(bShow)
	winMgr:getWindow("sj_MyDealRegistItemList_FixedImage_You"):setVisible(bShow)
	winMgr:getWindow("sj_MyDealRegistItemList_FixedBtnImage_You"):setVisible(bShow)
end

function OnMouseEnter_RegistItemListInfoToDeal_You(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber, attributeType = GetMyDealItemTooltipInfo(WINDOW_REGIST_LIST_YOU, index)
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
	
	-- 코스튬 아바타 관련 툴팁 변경을 위해 
	-- 0이 들어가던 슬롯인덱스를 -3로 고정. 고치면 안됨 ★
	GetToolTipBaseInfo(x + 65, y, 2, Kind, -3, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
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
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
	
end


function ClearMyDealRegistItemList_You(exchangeYourGran)
	for i=0, DEALITEM_LIST_1PAGE_NUM-1 do
		winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):setVisible(false)
	end
	
	-- 거래할 그랑
	local szYourMoney = CommatoMoneyStr(exchangeYourGran)
	local r,g,b = ColorToMoney(exchangeYourGran)
	winMgr:getWindow("sj_MyDealRegist_Gran_You"):setTextColor(r,g,b,255)
	winMgr:getWindow("sj_MyDealRegist_Gran_You"):setText(szYourMoney)
end


function SetupMyDealRegistItemList_You(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade, avatarType, attach)
	winMgr:getWindow("sj_MyDealRegistItemList_You_"..i):setVisible(true)

	-- 아이템 이미지
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setScaleWidth(102)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setScaleHeight(102)
	
	if itemFileName2 == "" then
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setLayered(false)
	else
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setLayered(true)
		winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_You_"..i):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_YouType_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	--  스킬레벨 보여주기
	if itemGrade > 0 then
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_You_"..i):setVisible(true)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_You_"..i):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_You_"..i):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_You_"..i):setText("+"..itemGrade)
		
		if IsKoreanLanguage() then
			winMgr:getWindow("sj_MyDealRegistItemList_ItemImage_YouType_"..i):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelImage_You_"..i):setVisible(false)
		winMgr:getWindow("sj_MyDealRegistItemList_SkillLevelText_You_"..i):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("sj_MyDealRegistItemList_ItemName_You_"..i):setText(itemName)
	
	-- 아이템 수량
	local szCount = CommatoMoneyStr(itemUseCount)
	winMgr:getWindow("sj_MyDealRegistItemList_ItemNum_You_"..i):setText(szCount)
	
	-- 아이템 기간
	local period = g_STRING_USING_PERIOD.." : "..g_STRING_UNTIL_DELETE
	winMgr:getWindow("sj_MyDealRegistItemList_ItemPeriod_You_"..i):setText(period)	
	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("sj_MyDealRegistItemList_ItemImage_You_" , "sj_MyDealRegistItemList_ItemImage_You_" , "sj_MyDealRegistItemList_ItemImage_You_BackIMG" ,
					i , avatarType , attach)
end



--[[
-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_MyDealRegistItemList_PageText_You")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(188, 368)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
myDealBackWindow:addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tMyDealRegistItemList_BtnName_You  = {["err"]=0, [0]="sj_MyDealRegistItemList_LBtn_You", "sj_MyDealRegistItemList_RBtn_You"}
local tMyDealRegistItemList_BtnTexX_You  = {["err"]=0, [0]=987, 970}
local tMyDealRegistItemList_BtnPosX_You  = {["err"]=0, [0]=170, 270}
local tMyDealRegistItemList_BtnEvent_You = {["err"]=0, [0]="OnClickMyDealRegistItemList_PrevPage_You", "OnClickMyDealRegistItemList_NextPage_You"}
for i=0, #tMyDealRegistItemList_BtnName_You do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyDealRegistItemList_BtnName_You[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_You[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_You[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_You[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyDealRegistItemList_BtnTexX_You[i], 0)
	mywindow:setPosition(tMyDealRegistItemList_BtnPosX_You[i], 366)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyDealRegistItemList_BtnEvent_You[i])
	myDealBackWindow:addChildWindow(mywindow)
end


function OnClickMyDealRegistItemList_PrevPage_You()
	if g_curPage_RegistList_You > 1 then
		g_curPage_RegistList_You = g_curPage_RegistList_You - 1
	--	ChangedRegistItemListCurrentPage(g_curPage_RegistList_You)
	end
end

function OnClickMyDealRegistItemList_NextPage_You()
	if g_curPage_RegistList_You < g_maxPage_RegistList_You then
		g_curPage_RegistList_You = g_curPage_RegistList_You + 1
	--	ChangedRegistItemListCurrentPage(g_curPage_RegistList_You)
	end
end

-- 나의 등록된 아이템 리스트 현재 페이지 / 최대 페이지
function MyDealRegistItemListPage_You(curPage, maxPage)
	g_curPage_RegistList_You = curPage
	g_maxPage_RegistList_You = maxPage
	
	winMgr:getWindow("sj_MyDealRegistItemList_PageText_Me"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end
--]]






-- 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myDeal_AlphaImg")
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_myDeal_OkBox")
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
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_myDeal_OkBox_Text")
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
winMgr:getWindow("sj_myDeal_OkBox"):addChildWindow(mywindow)

-- 알림창 확인버튼(OK)
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_myDeal_OkBtn_Only")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setSize(331, 29)
mywindow:setPosition(4, 235)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClosemyDealOKBox")
winMgr:getWindow("sj_myDeal_OkBox"):addChildWindow(mywindow)

function CloseNotifyBox()
	winMgr:getWindow('sj_myDeal_OkBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('sj_myDeal_AlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('sj_myDeal_AlphaImg'))
	local local_window = winMgr:getWindow('sj_myDeal_OkBox')
	winMgr:getWindow('sj_myDeal_AlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
end


function ClosemyDealOKBox(args)
	local okFunc = winMgr:getWindow('sj_myDeal_OkBox'):getUserString("okFunction")
	if okFunc ~= "ClosemyDealOKBox" then
		return
	end
	winMgr:getWindow('sj_myDeal_OkBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('sj_myDeal_AlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('sj_myDeal_AlphaImg'))
	local local_window = winMgr:getWindow('sj_myDeal_OkBox')
	winMgr:getWindow('sj_myDeal_AlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
end


function ShowNotifyMessageToDeal(arg)
    local aa = winMgr:getWindow('sj_myDeal_AlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('sj_myDeal_AlphaImg'):getChildAtIdx(0)
		winMgr:getWindow('sj_myDeal_AlphaImg'):removeChildWindow(bb)
	end
	
	root:addChildWindow(winMgr:getWindow('sj_myDeal_AlphaImg'))
	winMgr:getWindow('sj_myDeal_AlphaImg'):setVisible(true)
	local local_window = winMgr:getWindow('sj_myDeal_OkBox')
	local_window:setUserString("okFunction", "ClosemyDealOKBox")
	root:addChildWindow(local_window)
	local local_txt_window = winMgr:getWindow('sj_myDeal_OkBox_Text')
	local_window:setVisible(true)
	local_txt_window:clearTextExtends()
	local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
end


RegistEnterEventInfo("sj_myDeal_AlphaImg", "ClosemyDealOKBox")
RegistEscEventInfo("sj_myDeal_AlphaImg", "ClosemyDealOKBox")