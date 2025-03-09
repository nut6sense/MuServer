--------------------------------------------------------------------
-- ItemListContainer
--------------------------------------------------------------------

-- Script Entry Point
			
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


--------------------------------------------------------------------
-- 전역으로 사용할 변수들
--------------------------------------------------------------------
local MAX_CONTAINER_ITEMLIST = GetOnePageMaxCount()	-- 아이템 목록의 한페이지에 들어가는 아이템의 최대 갯수


--============================= 보유아이템 목록 팝업창 시작 =============================
local ItemListContainerWindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_BackImage")
ItemListContainerWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
ItemListContainerWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
ItemListContainerWindow:setWideType(6);
ItemListContainerWindow:setPosition(700, 170)
ItemListContainerWindow:setSize(296, 438)
ItemListContainerWindow:setAlwaysOnTop(true)
ItemListContainerWindow:setVisible(false)
ItemListContainerWindow:setZOrderingEnabled(false)
root:addChildWindow(ItemListContainerWindow)


-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainer_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
ItemListContainerWindow:addChildWindow(mywindow)


-- 페이지 좌우 버튼
local tItemListContainer_BtnName  = {["err"]=0, [0]="ItemListContainer_LBtn", "ItemListContainer_RBtn"}
local tItemListContainer_BtnTexX  = {["err"]=0, [0]=987, 970}
local tItemListContainer_BtnPosX  = {["err"]=0, [0]=170, 270}
local tItemListContainer_BtnEvent = {["err"]=0, [0]="OnClickItemListContainer_PrevPage", "OnClickItemListContainer_NextPage"}
for i=0, #tItemListContainer_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tItemListContainer_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tItemListContainer_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tItemListContainer_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tItemListContainer_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tItemListContainer_BtnTexX[i], 0)
	mywindow:setPosition(tItemListContainer_BtnPosX[i], 387)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tItemListContainer_BtnEvent[i])
	ItemListContainerWindow:addChildWindow(mywindow)
end

-- 페이지 좌버튼 클릭이벤트
function OnClickItemListContainer_PrevPage()
	local check = ContainerPrevButtonEvent()
	if check then
		local totalPage = GetContainerTotalPage()
		local currentPage = GetContainerCurrentPage()
		winMgr:getWindow("ItemListContainer_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- 페이지 우버튼 클릭이벤트
function OnClickItemListContainer_NextPage()
	local check = ContainerNextButtonEvent()
	if check then
		local totalPage = GetContainerTotalPage()
		local currentPage = GetContainerCurrentPage()
		winMgr:getWindow("ItemListContainer_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

local tMoneyTypeName = {['err']=0, [0]="ItemListContainer_Gran", "ItemListContainer_Coin", "ItemListContainer_Cash"}
local tMoneyTypeTexX = {['err']=0, [0]=	482, 503, 461}
local tMoneyTypePosY = {['err']=0, [0]=	366, 366 + 22, 366 + 44}

for i = 0, #tMoneyTypeName do
	-- 그랑 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMoneyTypeName[i].."Image")
	mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setPosition(16, tMoneyTypePosY[i])
	mywindow:setSize(19, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	ItemListContainerWindow:addChildWindow(mywindow)

	-- 현재 나의 그랑
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyTypeName[i].."Text")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(44, tMoneyTypePosY[i])
	mywindow:setSize(120, 20)
	mywindow:setZOrderingEnabled(false)
	ItemListContainerWindow:addChildWindow(mywindow)
end


-- 돈을 리프레시 해준다,
function refreshItemListContainerMoney(type, value)
	if type == 0 then --그랑
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("ItemListContainer_GranText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("ItemListContainer_GranText"):setText(CommatoMoneyStr(value))
	elseif type == 1 then --캐시
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("ItemListContainer_CashText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("ItemListContainer_CashText"):setText(CommatoMoneyStr(value))	
	elseif type == 2 then --코인
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("ItemListContainer_CoinText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("ItemListContainer_CoinText"):setText(CommatoMoneyStr(value))			
	end
end


-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
local BagTabName  = {["err"]=0, [0]="ItemListContainer_costume", "ItemListContainer_skill", "ItemListContainer_etc", "ItemListContainer_strengthen"}
local BagTabTexX  = {["err"]=0, [0]=0, 954, 140, 140}
local BagTabTexY  = {["err"]=0, [0]=455, 961, 455, 455}
local BagTabPosX  = {["err"]=0, [0]=4, 76, 148, 148}

for i=0, #BagTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", BagTabName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i])
	mywindow:setTexture("Hover", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i] + 21)
	mywindow:setTexture("Pushed", "UIData/deal.tga", BagTabTexX[i],  BagTabTexY[i] + 42)
	mywindow:setTexture("Disabled", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i])
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i] + 42)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i] + 42)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", BagTabTexX[i], BagTabTexY[i] + 42)
	mywindow:setPosition(BagTabPosX[i], 39)
	mywindow:setProperty("GroupID", 2019)
	if i == 2 then
		mywindow:setSize(0, 0)
	else		
		mywindow:setSize(70, 21)
	end
	mywindow:setZOrderingEnabled(false)
	if i == 1 then
		mywindow:setUserString("TabIndex", 4)
	else
		mywindow:setUserString("TabIndex", i)
	end
	
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_ItemListContainerTab")
	ItemListContainerWindow:addChildWindow(mywindow)
end


-- 아이템 종류탭이 눌렸을때 이벤트
function OnSelect_ItemListContainerTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetItemListContainerTab(tabindex)
	end
end


-- 아이템 리스트 판매목록
for i=0, MAX_CONTAINER_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "ItemListContainer_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+70)
	mywindow:setProperty("GroupID", 209)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	ItemListContainerWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(115)
	mywindow:setScaleHeight(115)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
--	mywindow:setEnabled(false)
	mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_Back_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(2, 2)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(110)
	mywindow:setScaleHeight(110)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
--	mywindow:setEnabled(false)
	mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainer_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_ItemListContainerInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_ItemListContainerInfo")
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainer_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)

	-- 아이템 가격
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainer_Price_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)


	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainer_Num_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)

	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "ItemListContainer_RegistBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 889, 952)
	mywindow:setTexture("Hover", "UIData/deal.tga", 889, 970)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 889, 988)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 889, 988)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 1006)
	mywindow:setPosition(210, 30)
	mywindow:setSize(65, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	
	mywindow:subscribeEvent("Clicked", "ClickedItemListContainerRegist")
	winMgr:getWindow("ItemListContainer_"..i):addChildWindow(mywindow)


end

--------------------------------------------------------------------
-- 내 아이템 리스트 끝 =============================================
--------------------------------------------------------------------

-- 아이템에 마우스 들어왔을떄.
function MouseEnter_ItemListContainerInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, slotIndex = GetItemListContainerToolTipInfo(index)
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
	GetToolTipBaseInfo(x + 50, y, 0, Kind, slotIndex, itemnumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

end

-- 마우스 나갔을때.
function MouseLeave_ItemListContainerInfo(args)
	SetShowToolTip(false)
end

-- 등록버튼이 클릭되었을때
function ClickedItemListContainerRegist(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local buttonIndex = tonumber(eventwindow:getUserString("Index"))
	ContainerItemClickEvent(buttonIndex)
	
--	local price = eventwindow:getUserString("price")
--	winMgr:getWindow("ItemListContainerCountInput_BackImage"):setVisible(true)
	-- 팔 아이템의 정보를 세팅해준다.
--	SettingBagFrameInputCountWindow(slotIndex, price)
-- 	RequestSellMsg(slotIndex)--, count)	-- 서버에 아이템을 판다고 보내준다.(아이템의 갯수까지 넘겨줘야함.)
end


-- 가방을 세팅한다.
function SettingItemListContainer(index, useCount, itemName, fileName, fileName2, itemgrade, upgradeCheck, avatarType, attach)
	winMgr:getWindow("ItemListContainer_"..index):setVisible(true)

	winMgr:getWindow("ItemListContainer_Image_"..index):setTexture("Enabled", fileName, 0, 0)
	-- 아이템 이미지
	if fileName2 == "" then
		winMgr:getWindow("ItemListContainer_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("ItemListContainer_Image_"..index):setLayered(true)
		winMgr:getWindow("ItemListContainer_Image_"..index):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow("ItemListContainer_Image_"..index):setScaleWidth(120)
	winMgr:getWindow("ItemListContainer_Image_"..index):setScaleHeight(120)
	
	-- 아이템 이름
	local String = SummaryString(g_STRING_FONT_GULIM, 12, itemName, 180)	
	winMgr:getWindow("ItemListContainer_Name_"..index):setText(String)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("ItemListContainer_Num_"..index):setText(szCount)

	winMgr:getWindow("ItemListContainer_Price_"..index):setText(period)
	
	if upgradeCheck == 1 then
		winMgr:getWindow("ItemListContainer_RegistBtn_"..index):setEnabled(true)		
	else
		winMgr:getWindow("ItemListContainer_RegistBtn_"..index):setEnabled(false)
	end
	
	-- 스킬 등급표시	
	if itemgrade > 0 then
		winMgr:getWindow("ItemListContainer_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("ItemListContainer_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemgrade], 486)
		winMgr:getWindow("ItemListContainer_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[itemgrade][1], tGradeTextColorTable[itemgrade][2], tGradeTextColorTable[itemgrade][3], 255)
		winMgr:getWindow("ItemListContainer_SkillLevelText_"..index):setText("+"..itemgrade)
	else
		winMgr:getWindow("ItemListContainer_SkillLevelImage_"..index):setVisible(false)
		winMgr:getWindow("ItemListContainer_SkillLevelText_"..index):setText("")
	end	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("ItemListContainer_Image_" , "ItemListContainer_Image_", "ItemListContainer_Back_Image_" , index , avatarType , attach)	
end


-- 페이지를 세팅해준다.
function SettingItemListContainerPageText(currentPage, totalPage)
	winMgr:getWindow("ItemListContainer_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end

-- 백 리스트를 지워준다.
function ClearItemListContainerList()
	for i=0, MAX_CONTAINER_ITEMLIST-1 do
		winMgr:getWindow("ItemListContainer_"..i):setVisible(false)
		winMgr:getWindow("ItemListContainer_Image_"..i):setLayered(false)
		winMgr:getWindow("ItemListContainer_Back_Image_"..i):setVisible(false)
		
--		winMgr:getWindow("ItemListContainer_EventImage_"..i):setUserString("Index", -1)
	end
end

--============================= 보유아이템 목록 팝업창 끝 =============================



--=============================== 수량 입력 팝업창 시작 ===============================
local Yterm = 8
-- 입력창 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_BackImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
mywindow:setWideType(6);
mywindow:setPosition(370, 200)
mywindow:setSize(296, 212)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEnterEventInfo("ItemListContainerCountInput_BackImage", "ItemListContainerCountInput_RegistBtnEvent")
RegistEscEventInfo("ItemListContainerCountInput_BackImage", "ItemListContainerCountInput_CancelBtnEvent")


-- 등록 글자 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setPosition(100, 8-Yterm)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_ItemImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55-Yterm)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(200)
mywindow:setScaleHeight(200)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 클론 아바타 뒷배경 이미지 ★
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_BackItemImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55-Yterm)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(200)
mywindow:setScaleHeight(200)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 스킬 레벨 테두리 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(33, 67-Yterm)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainerCountInput_SkillLevelText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67-Yterm)
mywindow:setSize(40, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 툴팁 이벤트를 위한 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55-Yterm)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainerCountInput_NameText")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 62-Yterm)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainerCountInput_PriceText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 86-Yterm)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainerCountInput_NumberText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 110-Yterm)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 등록수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_RegistImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setPosition(14, 132-Yterm)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 수량 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainerCountInput_InputImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setPosition(120, 133-Yterm)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "ItemListContainerCountInput_Render")
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "ItemListContainerCountInput_CountEditBox")
mywindow:setPosition(120, 134-Yterm)
mywindow:setSize(110, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setText("1")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(5)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


-- 수량 입력 좌우버튼
local tCountLRButtonName  = {["err"]=0, [0]="ItemListContainerCountInput_LBtn", "ItemListContainerCountInput_RBtn"}
local tCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tCountLRButtonEvent = {["err"]=0, [0]="ItemListContainerCountInput_LBtnEvent", "ItemListContainerCountInput_RBtnEvent"}
for i=0, #tCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setPosition(tCountLRButtonPosX[i], 135-Yterm)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tCountLRButtonEvent[i])
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)
end


-- 알림메세지
if IsKoreanLanguage() then
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ItemListContainerCountInput_NotifyText")
	mywindow:setTextColor(255, 213, 28,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(18, 155-Yterm)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	local NotifyText = AdjustString(g_STRING_FONT_GULIMCHE, 11, PreCreateString_3448, 255)
	mywindow:setText(NotifyText)
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)
end

-- 등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ItemListContainerCountInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ItemListContainerCountInput_RegistBtnEvent")
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)

-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ItemListContainerCountInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ItemListContainerCountInput_CancelBtnEvent")
winMgr:getWindow("ItemListContainerCountInput_BackImage"):addChildWindow(mywindow)


local InputCheckCount = 0
function CommonBagCountCountInputWindowSetting(itemName, itemCount, itemFileName, itemFileName2, priceText, avatarType , attach)
--	if itemCount == 1 then
--		
--	end
	InputCheckCount = itemCount
	-- 아이템 이름
	local Name = SummaryString(g_STRING_FONT_GULIMCHE, 12, itemName, 134)
	winMgr:getWindow("ItemListContainerCountInput_NameText"):setText(Name)
	
	winMgr:getWindow("ItemListContainerCountInput_PriceText"):setText(priceText)
		
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("ItemListContainerCountInput_NumberText"):setText(szcount)
	
	-- 	아이템 이미지
	winMgr:getWindow("ItemListContainerCountInput_ItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 ~= "" then
		winMgr:getWindow("ItemListContainerCountInput_ItemImage"):setTexture("Layered", itemFileName2, 0, 0)
	else
		winMgr:getWindow("ItemListContainerCountInput_ItemImage"):setTexture("Layered", "UIData/invisible", 0, 0)
	end
	winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):activate()
	winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):setText(InputCheckCount)
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	--SetAvatarIcon("ItemListContainerCountInput_ItemImage" , "ItemListContainerCountInput_BackItemImage", avatarType , attach)
	
	root:addChildWindow(winMgr:getWindow("ItemListContainerCountInput_BackImage"))
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):setVisible(true)

end


function ItemListContainerCountInput_Render(args)
	local CountText = winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):getText()

	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	if Count ~= nil then
		if Count > InputCheckCount then
			winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):setText(InputCheckCount)
		elseif Count <= 0 then
			--winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):setText(1)
		end
	end
end


function ItemListContainerCountInput_LBtnEvent(args)
	local CountText = winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count - 1
	if Count < 0 then
		Count = 0
	end
	winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):setText(Count)
end


function ItemListContainerCountInput_RBtnEvent(args)
	local CountText = winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count + 1
	winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):setText(Count)
end


function ItemListContainerCountInput_RegistBtnEvent(args)
	local CountText = winMgr:getWindow("ItemListContainerCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):setVisible(false)	
	local Count = tonumber(CountText)
	if Count == nil then
		ResetSellingInfo()
		return
	end	
	if Count <= 0 then
		ResetSellingInfo()
		return
	end	
	RequestSellMsg(Count)
end



function ItemListContainerCountInput_CancelBtnEvent(args)
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):setVisible(false)	
	ResetSellingInfo()
end


--================================ 수량 입력 팝업창 끝 ================================



-- 내 아이템 리스트를 보여준다.
function ShowItemListContainer()
	--ItemListContainerRefresh()
	winMgr:getWindow("ItemListContainer_BackImage"):setVisible(true)
	
	if CEGUI.toRadioButton(winMgr:getWindow("ItemListContainer_costume")):isSelected() then
		SetItemListContainerTab(0)
	else
		winMgr:getWindow("ItemListContainer_costume"):setProperty("Selected", "true")
	end
	
	for i = 0, #tMoneyTypeName do
		RefreshContainerMoney(i)
	end
end

-- 닫는다.
function CloseItemListContainer()
	winMgr:getWindow("ItemListContainer_BackImage"):setVisible(false)	
	winMgr:getWindow("ItemListContainerCountInput_BackImage"):setVisible(false)	
end

