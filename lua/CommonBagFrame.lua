--------------------------------------------------------------------

-- Script Entry Point
			
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

--------------------------------------------------------------------
-- �������� ����� ������
--------------------------------------------------------------------
local MAX_BAGFRAME_ITEMLIST = 5	-- ������ ����� ���������� ���� �������� �ִ� ����
local ItemList_Total_Page = 1	-- ������ ����Ʈ�� ��ü ������
local ItemList_Current_Page = 1	-- ������ ����Ʈ�� ���� ������.


--============================= ���������� ��� �˾�â ���� =============================
local CommonBagFrameWindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_BackImage")
CommonBagFrameWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
CommonBagFrameWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
CommonBagFrameWindow:setWideType(6);
CommonBagFrameWindow:setPosition(700, 170)
CommonBagFrameWindow:setSize(296, 438)
CommonBagFrameWindow:setAlwaysOnTop(true)
CommonBagFrameWindow:setVisible(false)
CommonBagFrameWindow:setZOrderingEnabled(false)
root:addChildWindow(CommonBagFrameWindow)


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagFrame_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
CommonBagFrameWindow:addChildWindow(mywindow)


-- ������ �¿� ��ư
local tCommonBagFrame_BtnName  = {["err"]=0, [0]="CommonBagFrame_LBtn", "CommonBagFrame_RBtn"}
local tCommonBagFrame_BtnTexX  = {["err"]=0, [0]=987, 970}
local tCommonBagFrame_BtnPosX  = {["err"]=0, [0]=170, 270}
local tCommonBagFrame_BtnEvent = {["err"]=0, [0]="OnClickCommonBagFrame_PrevPage", "OnClickCommonBagFrame_NextPage"}
for i=0, #tCommonBagFrame_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tCommonBagFrame_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tCommonBagFrame_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tCommonBagFrame_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tCommonBagFrame_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tCommonBagFrame_BtnTexX[i], 0)
	mywindow:setPosition(tCommonBagFrame_BtnPosX[i], 387)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tCommonBagFrame_BtnEvent[i])
	CommonBagFrameWindow:addChildWindow(mywindow)
end

-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickCommonBagFrame_PrevPage()
	local check = CommonBagPrevButtonEvent()
	if check then
		local totalPage = GetCommonBagTotalPage()
		local currentPage = GetCommonBagCurrentPage()
		winMgr:getWindow("CommonBagFrame_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- ������ ���ư Ŭ���̺�Ʈ
function OnClickCommonBagFrame_NextPage()
	local check = CommonBagNextButtonEvent()
	if check then
		local totalPage = GetCommonBagTotalPage()
		local currentPage = GetCommonBagCurrentPage()
		winMgr:getWindow("CommonBagFrame_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

local tMoneyTypeName = {['err']=0, [0]="CommonBagFrame_Gran", "CommonBagFrame_Coin", "CommonBagFrame_Cash"}
local tMoneyTypeTexX = {['err']=0, [0]=	482, 503, 461}
local tMoneyTypePosY = {['err']=0, [0]=	366, 366 + 22, 366 + 44}

for i = 0, #tMoneyTypeName do
	-- �׶� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMoneyTypeName[i].."Image")
	mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setPosition(16, tMoneyTypePosY[i])
	mywindow:setSize(19, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	CommonBagFrameWindow:addChildWindow(mywindow)

	-- ���� ���� �׶�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyTypeName[i].."Text")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(44, tMoneyTypePosY[i])
	mywindow:setSize(120, 20)
	mywindow:setZOrderingEnabled(false)
	CommonBagFrameWindow:addChildWindow(mywindow)
end


-- ���� �������� ���ش�,
function refreshMoney(type, value)
	if type == 0 then --�׶�
		local r, g, b	= GetGranColor(value)
		winMgr:getWindow("CommonBagFrame_GranText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonBagFrame_GranText"):setText(CommatoMoneyStr64(value))
	elseif type == 1 then --ĳ��
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonBagFrame_CashText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonBagFrame_CashText"):setText(CommatoMoneyStr(value))	
	elseif type == 2 then --����
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonBagFrame_CoinText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonBagFrame_CoinText"):setText(CommatoMoneyStr(value))			
	end
end


-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
local BagTabName  = {["err"]=0, [0]="CommonBagFrame_costume", "CommonBagFrame_skill", "CommonBagFrame_etc", "CommonBagFrame_strengthen"}
local BagTabTexX  = {["err"]=0, [0]=0, 70, 140, 210}
local BagTabPosX  = {["err"]=0, [0]=4, 76, 148, 220}

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
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_CommonBagFrameTab")
	CommonBagFrameWindow:addChildWindow(mywindow)
end


-- ������ �������� �������� �̺�Ʈ
function OnSelect_CommonBagFrameTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetItemCommonBagTab(tabindex)		
	end
end


-- ������ ����Ʈ �ǸŸ��
for i=0, MAX_BAGFRAME_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "CommonBagFrame_"..i)
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
	CommonBagFrameWindow:addChildWindow(mywindow)
	
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(115)
	mywindow:setScaleHeight(115)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
--	mywindow:setEnabled(false)
	mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	
	-- �ڽ�Ƭ �ƹ�Ÿ ���̹��� ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_Image_Back_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(115)
	mywindow:setScaleHeight(115)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
--	mywindow:setEnabled(false)
	mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	
	--[[
	-- �ڽ�Ƭ �ƹ�Ÿ ��� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_Warning_"..i)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
	mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
	mywindow:setSize(48, 48)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	]]--
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagFrame_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagFrame_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_CommonBagFrameInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_CommonBagFrameInfo")
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagFrame_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)

	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagFrame_Price_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)


	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagFrame_Num_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)

	-- ������ ��Ϲ�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "CommonBagFrame_SellBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal2.tga", 594, 92)
	mywindow:setTexture("Hover", "UIData/deal2.tga", 594, 110)
	mywindow:setTexture("Pushed", "UIData/deal2.tga", 594, 128)
	mywindow:setTexture("PushedOff", "UIData/deal2.tga", 594, 128)
	mywindow:setTexture("Disabled", "UIData/deal2.tga", 594, 146)
	mywindow:setPosition(210, 30)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:setUserString("price", "")
	
	mywindow:subscribeEvent("Clicked", "ClickedCommonBagFrameSell")
	winMgr:getWindow("CommonBagFrame_"..i):addChildWindow(mywindow)


end

--------------------------------------------------------------------
-- �� ������ ����Ʈ �� =============================================
--------------------------------------------------------------------

-- �����ۿ� ���콺 ��������.
function MouseEnter_CommonBagFrameInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber = GetCommonBagToolTipInfo(index)
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
	GetToolTipBaseInfo(x + 50, y, 0, Kind, index, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)

end

-- ���콺 ��������.
function MouseLeave_CommonBagFrameInfo(args)
	SetShowToolTip(false)
end

-- ������ �ǸŹ�ư�� Ŭ���Ǿ�����
function ClickedCommonBagFrameSell(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))
	local price = eventwindow:getUserString("price")

	-- �� �������� ������ �������ش�.
	SettingBagFrameInputCountWindow(slotIndex, price)
	
-- 	RequestSellMsg(slotIndex)--, count)	-- ������ �������� �Ǵٰ� �����ش�.(�������� �������� �Ѱ������.)

end


-- ������ �����Ѵ�.
function SettingCommonBag(index, slotIndex, useCount, itemName, fileName, fileName2, bSale, grade, gran, coin, cash, avatarType , attach)
	winMgr:getWindow("CommonBagFrame_"..index):setVisible(true)
	-- ���� ���� ���� �ε��� ����
	winMgr:getWindow("CommonBagFrame_EventImage_"..index):setUserString("Index", slotIndex)
	winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setUserString("Index", slotIndex)
		
	winMgr:getWindow("CommonBagFrame_Image_"..index):setTexture("Enabled", fileName, 0, 0)
	-- ������ �̹���
	if fileName2 == "" then
		winMgr:getWindow("CommonBagFrame_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("CommonBagFrame_Image_"..index):setLayered(true)		
		winMgr:getWindow("CommonBagFrame_Image_"..index):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow("CommonBagFrame_Image_"..index):setScaleWidth(120)
	winMgr:getWindow("CommonBagFrame_Image_"..index):setScaleHeight(120)
	
	-- ������ �̸�
	local String = SummaryString(g_STRING_FONT_GULIM, 12, itemName, 180)	
	winMgr:getWindow("CommonBagFrame_Name_"..index):setText(String)
	
	-- ������ ����
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CommonBagFrame_Num_"..index):setText(szCount)

	-- ������ �Ⱓ
	local period = ""
			
	if bSale == 1 then	-- �� �� �ִ� �����̸�
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
	else				-- �� �� ���ٸ�
		period = PreCreateString_2421
		winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setEnabled(false)
	end
	winMgr:getWindow("CommonBagFrame_SellBtn_"..index):setUserString("price", period)
	winMgr:getWindow("CommonBagFrame_Price_"..index):setText(period)
	
	if grade > 0 then
		winMgr:getWindow("CommonBagFrame_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("CommonBagFrame_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("CommonBagFrame_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("CommonBagFrame_SkillLevelText_"..index):setText("+"..grade)
	end	
	
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIconS("CommonBagFrame_Image_" , "CommonBagFrame_Image_" , "CommonBagFrame_Image_Back_" ,index , avatarType , attach)

end


-- �������� �������ش�.
function SettingCommonBagPageText(currentPage, totalPage)
	winMgr:getWindow("CommonBagFrame_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end

-- �� ����Ʈ�� �����ش�.
function ClearCommonBagList()
	for i=0, MAX_BAGFRAME_ITEMLIST-1 do
		winMgr:getWindow("CommonBagFrame_"..i):setVisible(false)
		winMgr:getWindow("CommonBagFrame_Image_Back_"..i):setVisible(false)
		winMgr:getWindow("CommonBagFrame_EventImage_"..i):setUserString("Index", -1)
		winMgr:getWindow("CommonBagFrame_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("CommonBagFrame_SkillLevelText_"..i):setText("")
		
		
	end
end

--============================= ���������� ��� �˾�â �� =============================



--=============================== ���� �Է� �˾�â ���� ===============================
-- �Է�â ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_BackImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
mywindow:setPosition(370, 200)
mywindow:setSize(296, 212)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEnterEventInfo("CommonBagCountInput_BackImage", "CommonBagCountInput_RegistBtnEvent")
RegistEscEventInfo("CommonBagCountInput_BackImage", "CommonBagCountInput_CancelBtnEvent")


-- ��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setPosition(100, 8)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_ItemImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(200)
mywindow:setScaleHeight(200)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ��ų ���� �׵θ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(33, 67)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ��ų���� + ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagCountInput_SkillLevelText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 67)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ���� �̺�Ʈ�� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagCountInput_NameText")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 62)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagCountInput_PriceText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 86)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonBagCountInput_NumberText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 110)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ��ϼ��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_RegistImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setPosition(14, 142)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ���� �Է�ĭ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonBagCountInput_InputImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setPosition(120, 143)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "CommonBagCountInput_Render")
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ���� �Է� ����Ʈ �ڽ�
mywindow = winMgr:createWindow("TaharezLook/Editbox", "CommonBagCountInput_CountEditBox")
mywindow:setPosition(120, 144)
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
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


-- ���� �Է� �¿��ư
local tCountLRButtonName  = {["err"]=0, [0]="CommonBagCountInput_LBtn", "CommonBagCountInput_RBtn"}
local tCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tCountLRButtonEvent = {["err"]=0, [0]="CommonBagCountInput_LBtnEvent", "CommonBagCountInput_RBtnEvent"}
for i=0, #tCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setPosition(tCountLRButtonPosX[i], 145)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tCountLRButtonEvent[i])
	winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)
end


-- ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "CommonBagCountInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CommonBagCountInput_RegistBtnEvent")
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)

-- ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "CommonBagCountInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CommonBagCountInput_CancelBtnEvent")
winMgr:getWindow("CommonBagCountInput_BackImage"):addChildWindow(mywindow)


local InputCheckCount = 0
function CommonBagCountCountInputWindowSetting(itemName, itemCount, itemFileName, itemFileName2, priceText)
--	if itemCount == 1 then
--		
--	end
	InputCheckCount = itemCount
	-- ������ �̸�
	local Name = SummaryString(g_STRING_FONT_GULIMCHE, 12, itemName, 134)
	winMgr:getWindow("CommonBagCountInput_NameText"):setText(Name)
	
	winMgr:getWindow("CommonBagCountInput_PriceText"):setText(priceText)
		
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CommonBagCountInput_NumberText"):setText(szcount)
	
	-- 	������ �̹���
	winMgr:getWindow("CommonBagCountInput_ItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 ~= "" then
		winMgr:getWindow("CommonBagCountInput_ItemImage"):setTexture("Layered", itemFileName2, 0, 0)
	else
		winMgr:getWindow("CommonBagCountInput_ItemImage"):setTexture("Layered", "UIData/invisible", 0, 0)
	end
	winMgr:getWindow("CommonBagCountInput_CountEditBox"):activate()
	winMgr:getWindow("CommonBagCountInput_CountEditBox"):setText(InputCheckCount)
	
	root:addChildWindow(winMgr:getWindow("CommonBagCountInput_BackImage"))
	winMgr:getWindow("CommonBagCountInput_BackImage"):setVisible(true)

end


function CommonBagCountInput_Render(args)
	local CountText = winMgr:getWindow("CommonBagCountInput_CountEditBox"):getText()

	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	if Count ~= nil then
		if Count > InputCheckCount then
			winMgr:getWindow("CommonBagCountInput_CountEditBox"):setText(InputCheckCount)
		elseif Count <= 0 then
			--winMgr:getWindow("CommonBagCountInput_CountEditBox"):setText(1)
		end
	end
end


function CommonBagCountInput_LBtnEvent(args)
	local CountText = winMgr:getWindow("CommonBagCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count - 1
	if Count < 0 then
		Count = 0
	end
	winMgr:getWindow("CommonBagCountInput_CountEditBox"):setText(Count)
end


function CommonBagCountInput_RBtnEvent(args)
	local CountText = winMgr:getWindow("CommonBagCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count + 1
	winMgr:getWindow("CommonBagCountInput_CountEditBox"):setText(Count)
end


function CommonBagCountInput_RegistBtnEvent(args)
	local CountText = winMgr:getWindow("CommonBagCountInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	winMgr:getWindow("CommonBagCountInput_BackImage"):setVisible(false)	
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



function CommonBagCountInput_CancelBtnEvent(args)
	winMgr:getWindow("CommonBagCountInput_BackImage"):setVisible(false)	
	ResetSellingInfo()
end


--================================ ���� �Է� �˾�â �� ================================



-- �� ������ ����Ʈ�� �����ش�.
function ShowCommonBagFrame()
	--CommonBagFrameRefresh()
	winMgr:getWindow("TownStore_MainAlpha"):addChildWindow(winMgr:getWindow("CommonBagFrame_BackImage"))
	winMgr:getWindow("CommonBagFrame_BackImage"):setVisible(true)
	
	if CEGUI.toRadioButton(winMgr:getWindow("CommonBagFrame_costume")):isSelected() then
		SetItemCommonBagTab(0)
	else
		winMgr:getWindow("CommonBagFrame_costume"):setProperty("Selected", "true")
	end	
	
	for i = 0, #tMoneyTypeName do
		RefreshCommonBagMoney(i)
	end
end

-- �ݴ´�.
function CloseCommonBagFrame()
	
	winMgr:getWindow("CommonBagFrame_BackImage"):setVisible(false)	
	winMgr:getWindow("CommonBagCountInput_BackImage"):setVisible(false)	
	ResetSellingInfo()
end

