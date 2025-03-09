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
local MAX_UPGRADE_FRAME_ITEMLIST = 5	-- ������ ����� ���������� ���� �������� �ִ� ����
local ItemList_Total_Page		 = 1	-- ������ ����Ʈ�� ��ü ������
local ItemList_Current_Page		 = 1	-- ������ ����Ʈ�� ���� ������.

CommonUpgradeItemAmount = {['err']=0, 0,0,0,0,0,0,0,0,0,0,0}


--============================= ���������� ��� �˾�â ���� =============================
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


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeList_PageText")
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
CommonUpgradeListWindow:addChildWindow(mywindow)


-- ������ �¿� ��ư
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


-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickCommonUpgrade_PrevPage()
	--SkillUpgradeItemListPageButtonEvent(0)	
	CommonUpgradeItemListPageButtonEvent(0)
end


-- ������ ���ư Ŭ���̺�Ʈ
function OnClickCommonUpgrade_NextPage()
	--SkillUpgradeItemListPageButtonEvent(1)
	CommonUpgradeItemListPageButtonEvent(1)
end


local tMoneyTypeName = {['err']=0, [0]="CommonUpgrade_Gran", "CommonUpgrade_Coin", "CommonUpgrade_Cash"}
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
	CommonUpgradeListWindow:addChildWindow(mywindow)

	-- ���� ���� �׶�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyTypeName[i].."Text")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(44, tMoneyTypePosY[i])
	mywindow:setSize(120, 20)
	mywindow:setZOrderingEnabled(false)
	CommonUpgradeListWindow:addChildWindow(mywindow)
end


-- ���� �������� ���ش�,
function refreshCommonUpgradeMoney(type, value)
	if type == 0 then --�׶�
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_GranText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_GranText"):setText(CommatoMoneyStr(value))
	elseif type == 1 then --ĳ��
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_CashText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_CashText"):setText(CommatoMoneyStr(value))	
	elseif type == 2 then --����
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("CommonUpgrade_CoinText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("CommonUpgrade_CoinText"):setText(CommatoMoneyStr(value))			
	end
end



-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
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

-- ������ �������� �������� �̺�Ʈ
function OnSelect_CommonUpgradeTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetCommonUpgradeItemListTab(tabindex)		
	end
end


-- ������ ����Ʈ �ǸŸ��
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
	
	-- ������ �̹���
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
	mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonUpgradeFrame_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
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
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)

	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Price_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)


	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonUpgradeFrame_Num_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonUpgradeFrame_"..i):addChildWindow(mywindow)

	-- ������ ��Ϲ�ư
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
-- �� ������ ����Ʈ �� =============================================
--------------------------------------------------------------------

-- �����ۿ� ���콺 ��������.
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, index, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
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

-- ���콺 ��������.
function MouseLeave_CommonUpgradeInfo(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
end




-- ������ �����Ѵ�.
function SettingCommonUpgradeFrame(index, slotIndex, useCount, itemName, fileName, fileName2, bSale, grade, gran, coin, cash)
	winMgr:getWindow("CommonUpgradeFrame_"..index):setVisible(true)

	-- ���� ���� ���� �ε��� ����
--	winMgr:getWindow("CommonUpgradeFrame_EventImage_"..index):setUserString("Index", slotIndex)
--	winMgr:getWindow("CommonUpgradeFrame_SellBtn_"..index):setUserString("Index", slotIndex)
		
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setTexture("Enabled", fileName, 0, 0)
	-- ������ �̹���
	if fileName2 == "" then
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setLayered(true)
		winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setScaleWidth(120)
	winMgr:getWindow("CommonUpgradeFrame_Image_"..index):setScaleHeight(120)
	
	-- ������ �̸�
	winMgr:getWindow("CommonUpgradeFrame_Name_"..index):setText(itemName)
	
	-- ������ ����
	CommonUpgradeItemAmount[index] = useCount
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CommonUpgradeFrame_Num_"..index):setText(szCount)
--[[
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
--]]	
	if grade > 0 then
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..index):setText("+"..grade)
	end	

end


-- �������� �������ش�.
function SettingCommonUpgradePageText(currentPage, totalPage)
	winMgr:getWindow("CommonUpgradeList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end

-- �� ����Ʈ�� �����ش�.
function ClearCommonUpgradeList()
	for i=0, MAX_UPGRADE_FRAME_ITEMLIST-1 do
		winMgr:getWindow("CommonUpgradeFrame_"..i):setVisible(false)
--		winMgr:getWindow("CommonUpgradeFrame_EventImage_"..i):setUserString("Index", -1)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("CommonUpgradeFrame_SkillLevelText_"..i):setText("")
		
		
	end
end

--============================= ���������� ��� �˾�â �� =============================



-- ������ ����Ʈ�� ���� �������ش�.
function ItemListTabSettiong()
	


end




-- �� ������ ����Ʈ�� �����ش�.(���ڰ����� TabTable�� �޴´�)
function ShowCommonUpgradeFrame( tItemListTabTable, ButtonEventName)
	--CommonBagFrameRefresh()
	root:addChildWindow(winMgr:getWindow("CommonUpgradeList_BackImage"))
	winMgr:getWindow("CommonUpgradeList_BackImage"):setVisible(true)
	
	-- �ش��ϴ� ���� �������� �������ش�.
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
	
	-- ó���� �ش�Ǵ� ���� �������ش�.
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



-- �ݴ´�.
function CloseCommonUpgradeFrame()
	winMgr:getWindow("CommonUpgradeList_BackImage"):setVisible(false)	

end

-- ��� ��ư Ȱ��ȭ, ��Ȱ��ȭ
function SetRegistButtonEnable(Index, bFlag)
	winMgr:getWindow("CommonUpgradeFrame_SellBtn_"..Index):setEnabled(bFlag)	
end

