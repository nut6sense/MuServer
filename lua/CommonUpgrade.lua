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
local MAX_UPGRADE_FRAME_ITEMLIST = 5	-- 아이템 목록의 한페이지에 들어가는 아이템의 최대 갯수
local ItemList_Total_Page		 = 1	-- 아이템 리스트의 전체 페이지
local ItemList_Current_Page		 = 1	-- 아이템 리스트의 현재 페이지.

CommonUpgradeItemAmount = {['err']=0, 0,0,0,0,0,0,0,0,0,0,0}


--============================= 보유아이템 목록 팝업창 시작 =============================
local CommonUpgradeListWindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonUpgradeList_BackImage")
CommonUpgradeListWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
CommonUpgradeListWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
CommonUpgradeListWindow:setWideType(6);
CommonUpgradeListWindow:setPosition(700, 170)
CommonUpgradeListWindow:setSize(296, 438)
CommonUpgradeListWindow:setAlwaysOnTop(true)
CommonUpgradeListWindow:setVisible(false)
CommonUpgradeListWindow:setZOrderingEnabled(false)
root:addChildWindow(CommonUpgradeListWindow)


-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeList_PageText")
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
CommonUpgradeListWindow:addChildWindow(mywindow)


-- 페이지 좌우 버튼
local tBtnName  = {["err"]=0, [0]="CommonUpgrade_LBtn", "CommonUpgrade_RBtn"}
local tBtnTexX  = {["err"]=0, [0]=			987,			970}
local tBtnPosX  = {["err"]=0, [0]=			170,			270}
local tBtnEvent = {["err"]=0, [0]="OnClickCommonUpgrade_PrevPage", "OnClickCommonUpgrade_NextPage"}
for i=0, #tBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tBtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tBtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tBtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tBtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tBtnTexX[i], 0)
	mywindow:setPosition(tBtnPosX[i], 387)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tBtnEvent[i])
	CommonUpgradeListWindow:addChildWindow(mywindow)
end


-- 페이지 좌버튼 클릭이벤트
function OnClickCommonUpgrade_PrevPage()
	--SkillUpgradeItemListPageButtonEvent(0)	
	CommonUpgradeItemListPageButtonEvent(0)
end


-- 페이지 우버튼 클릭이벤트
function OnClickCommonUpgrade_NextPage()
	--SkillUpgradeItemListPageButtonEvent(1)
	CommonUpgradeItemListPageButtonEvent(1)
end


local tMoneyTypeName = {['err']=0, [0]="CommonUpgrade_Gran", "CommonUpgrade_Coin", "CommonUpgrade_Cash"}
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
	CommonUpgradeListWindow:addChildWindow(mywindow)

	-- 현재 나의 그랑
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyTypeName[i].."Text")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(44, tMoneyTypePosY[i])
	mywindow:setSize(120, 20)
	mywindow:setZOrderingEnabled(false)
	CommonUpgradeListWindow:addChildWindow(mywindow)
end


-- 돈을 리프레시 해준다,
function refreshCommonUpgradeMoney(type, value)
	if type == 0 then --그랑
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_GranText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_GranText"):setText(CommatoMoneyStr(value))
	elseif type == 1 then --캐시
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_CashText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_CashText"):setText(CommatoMoneyStr(value))	
	elseif type == 2 then --코인
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_CoinText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_CoinText"):setText(CommatoMoneyStr(value))			
	end
end



-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
local BagTabName  = {["err"]=0, [0]="CommonUpgrade_costume", "CommonUpgrade_skill", "CommonUpgrade_etc", "CommonUpgrade_strengthen", "CommonUpgrade_cash"}
local BagTabTexX  = {["err"]=0, [0]=0, 70, 140, 210, 280}
--local BagTabPosX  = {["err"]=0, [0]=4, 76, 148, 220, 292}
local BagTabPosX  = {["err"]=0, [0]=4, 4, 148, 76, 292}

for i=0, #BagTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", BagTabName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", BagTabTexX[i], 455)
	mywindow:setTexture("Hover", "UIData/deal.tga", BagTabTexX[i], 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("Disabled", "UIData/deal.tga", BagTabTexX[i], 455)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setPosition(BagTabPosX[i], 39)
	mywindow:setProperty("GroupID", 2019)
	mywindow:setSize(70, 21)
	if i == 1 or i == 3 then
		mywindow:setVisible(true)
	else
		mywindow:setVisible(false)
	end
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_CommonUpgradeTab")
	CommonUpgradeListWindow:addChildWindow(mywindow)
end

function DecoUpgradeMyItemListInit()
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("Normal", "UIData/Deco.tga", 342, 178)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("Hover", "UIData/Deco.tga", 342, 199)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("Pushed", "UIData/Deco.tga", 342, 220)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("Disabled", "UIData/Deco.tga", 342, 178)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("SelectedNormal", "UIData/Deco.tga", 342, 220)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("SelectedHover", "UIData/Deco.tga", 342, 220)
	winMgr:getWindow("CommonUpgrade_costume"):setTexture("SelectedPushed", "UIData/Deco.tga", 342, 220)
	
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("Normal", "UIData/Deco.tga", 412, 178)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("Hover", "UIData/Deco.tga", 412, 199)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("Pushed", "UIData/Deco.tga", 412, 220)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("Disabled", "UIData/Deco.tga", 412, 178)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("SelectedNormal", "UIData/Deco.tga", 412, 220)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("SelectedHover", "UIData/Deco.tga", 412, 220)
	winMgr:getWindow("CommonUpgrade_etc"):setTexture("SelectedPushed", "UIData/Deco.tga", 412, 220)
	
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("Normal", "UIData/Deco.tga", 482, 178)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("Hover", "UIData/Deco.tga", 482, 199)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("Pushed", "UIData/Deco.tga", 482, 220)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("Disabled", "UIData/Deco.tga", 482, 178)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("SelectedNormal", "UIData/Deco.tga", 482, 220)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("SelectedHover", "UIData/Deco.tga", 482, 220)
	winMgr:getWindow("CommonUpgrade_strengthen"):setTexture("SelectedPushed", "UIData/Deco.tga", 482, 220)
end

function DecoUpgradeMyItemListEndInit()
	for i=0, #BagTabName do
		winMgr:getWindow(BagTabName[i]):setTexture("Normal", "UIData/deal.tga", BagTabTexX[i], 455)
		winMgr:getWindow(BagTabName[i]):setTexture("Hover", "UIData/deal.tga", BagTabTexX[i], 476)
		winMgr:getWindow(BagTabName[i]):setTexture("Pushed", "UIData/deal.tga", BagTabTexX[i], 497)
		winMgr:getWindow(BagTabName[i]):setTexture("Disabled", "UIData/deal.tga", BagTabTexX[i], 455)
		winMgr:getWindow(BagTabName[i]):setTexture("SelectedNormal", "UIData/deal.tga", BagTabTexX[i], 497)
		winMgr:getWindow(BagTabName[i]):setTexture("SelectedHover", "UIData/deal.tga", BagTabTexX[i], 497)
		winMgr:getWindow(BagTabName[i]):setTexture("SelectedPushed", "UIData/deal.tga", BagTabTexX[i], 497)
	end
end

--function OnSelect_PushStrengthTab()
	--winMgr:getWindow("CommonUpgrade_strengthen"):setSelected(true)
--end

-- 아이템 종류탭이 눌렸을때 이벤트
function OnSelect_CommonUpgradeTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetCommonUpgradeItemListTab(tabindex)		
	end
end


-- 아이템 리스트 판매목록
for i=0, MAX_UPGRADE_FRAME_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "CommonUpgradeFrame_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+70)
	mywindow:setProperty("GroupID", 211)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	CommonUpgradeListWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonUpgradeFrame_Image_"..i)
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
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonUpgradeFrame_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonUpgradeFrame_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_CommonUpgradeInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_CommonUpgradeInfo")
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)

	-- 아이템 가격
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Price_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)


	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Num_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)

	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "CommonUpgradeFrame_SellBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 889, 952)
	mywindow:setTexture("Hover", "UIData/deal.tga", 889, 970)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 889, 988)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 889, 988)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 1006)
	mywindow:setPosition(210, 30)
	mywindow:setSize(65, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	--mywindow:subscribeEvent("Clicked", "ClickedCommonUpgradeFrameBtn")
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)


end

--------------------------------------------------------------------
-- 내 아이템 리스트 끝 =============================================
--------------------------------------------------------------------

-- 아이템에 마우스 들어왔을떄.
function MouseEnter_CommonUpgradeInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, attribute = CommonUpgradeTooltipInfo(index)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, index, itemnumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	if Kind ~= KIND_SKILL then
		return
	end
	
	ReadAnimation(itemnumber, attribute)
	
	local targetx, targety = GetBasicRootPoint(CommonUpgradeListWindow)
	if x < targetx then
		targetx = x + 52
	end
	targetx = targetx - 236
	if targetx < 0 then
		targetx = 0
	end	
	if y + 223 > g_CURRENT_WIN_SIZEY then
		y = g_CURRENT_WIN_SIZEY - 223
	end
	targety = targety - 69
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
	

end

-- 마우스 나갔을때.
function MouseLeave_CommonUpgradeInfo(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()
end




-- 가방을 세팅한다.
function SettingCommonUpgradeFrame(index, slotIndex, useCount, itemName, fileName, fileName2, bSale, grade, gran, coin, cash)
	winMgr:getWindow("CommonUpgradeFrame_"..index):setVisible(true)

	-- 툴팁 위해 슬롯 인덱스 저장
--	winMgr:getWindow("CommonUpgradeFrame_EventImage_"..index):setUserString("Index", slotIndex)
--	winMgr:getWindow("CommonUpgradeFrame_SellBtn_"..index):setUserString("Index", slotIndex)
		
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setTexture("Enabled", fileName, 0, 0)
	-- 아이템 이미지
	if fileName2 == "" then
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setLayered(true)
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setScaleWidth(120)
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setScaleHeight(120)
	
	-- 아이템 이름
	winMgr:getWindow("CommonUpgradeFrame_Name_"..index):setText(itemName)
	
	-- 아이템 갯수
	CommonUpgradeItemAmount[index] = useCount
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CommonUpgradeFrame_Num_"..index):setText(szCount)
--[[
	-- 아이템 기간
	local period = ""
			
	if bSale == 1 then	-- 팔 수 있는 물건이면
		period = PreCreateString_2041.." :"--..PreCreateString_200
		if gran ~= 0 then
			period = period.." "..CommatoMoneyStr(gran).." "..PreCreateString_200
		end
		if coin ~= 0 then
			period = period.." "..CommatoMoneyStr(coin).." "..PreCreateString_1523
		end
		if cash ~= 0 then
			period = period.." "..CommatoMoneyStr(cash).." "..PreCreateString_1955
		end
		winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setEnabled(true)
	else				-- 팔 수 없다면
		period = PreCreateString_2421
		winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setEnabled(false)
	end
	winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setUserString("price", period)
	winMgr:getWindow("CommonBagFrame_Price_"..index):setText(period)
--]]	
	if grade > 0 then
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..index):setText("+"..grade)
	end	

end


-- 페이지를 세팅해준다.
function SettingCommonUpgradePageText(currentPage, totalPage)
	winMgr:getWindow("CommonUpgradeList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end

-- 백 리스트를 지워준다.
function ClearCommonUpgradeList()
	for i=0, MAX_UPGRADE_FRAME_ITEMLIST-1 do
		winMgr:getWindow("CommonUpgradeFrame_"..i):setVisible(false)
--		winMgr:getWindow("CommonUpgradeFrame_EventImage_"..i):setUserString("Index", -1)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..i):setText("")
		
		
	end
end

--============================= 보유아이템 목록 팝업창 끝 =============================



-- 아이템 리스트의 탭을 세팅해준다.
function ItemListTabSettiong()
	


end




-- 내 아이템 리스트를 보여준다.(인자값으로 TabTable을 받는다)
function ShowCommonUpgradeFrame( tItemListTabTable, ButtonEventName)
	--CommonBagFrameRefresh()
	root:addChildWindow(winMgr:getWindow("CommonUpgradeList_BackImage"))
	winMgr:getWindow("CommonUpgradeList_BackImage"):setVisible(true)
	
	-- 해당하는 탭이 나오도록 세팅해준다.
	local selectTabIndex = -1
	local visibleCount = 0
	for i=0, CommonTAB_COUNT-1 do
		winMgr:getWindow(BagTabName[i]):setVisible(tItemListTabTable[i])
		winMgr:getWindow(BagTabName[i]):setPosition(4 + (visibleCount*72), 39)
		if tItemListTabTable[i] then
			visibleCount = visibleCount + 1			
			if selectTabIndex == -1 then
				selectTabIndex = i
			end
		end

	end
	
	if selectTabIndex == -1 then
		selectTabIndex = 0
	end
	
	-- 처음에 해당되는 탭을 선택해준다.
	if CEGUI.toRadioButton(winMgr:getWindow(BagTabName[selectTabIndex])):isSelected() then
		SetCommonUpgradeItemListTab(selectTabIndex)
	else
		CEGUI.toRadioButton(winMgr:getWindow(BagTabName[selectTabIndex])):setSelected(true)
	end	
	
	for i = 0, #tMoneyTypeName do
		RefreshCommonUpgradeMoney(i)
	end
	
	
	for i=0, MAX_UPGRADE_FRAME_ITEMLIST-1 do
		winMgr:getWindow("CommonUpgradeFrame_SellBtn_"..i):subscribeEvent("Clicked", ButtonEventName)
	end
end



-- 닫는다.
function CloseCommonUpgradeFrame()
	winMgr:getWindow("CommonUpgradeList_BackImage"):setVisible(false)	

end

-- 등록 버튼 활성화, 비활성화
function SetRegistButtonEnable(Index, bFlag)
	winMgr:getWindow("CommonUpgradeFrame_SellBtn_"..Index):setEnabled(bFlag)	
end

