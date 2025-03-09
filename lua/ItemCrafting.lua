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
local MAX_CRAFT_ITEMLIST = 5	-- ������ ����� ���������� ���� �������� �ִ� ����
local ItemList_Total_Page = 1	-- ������ ����Ʈ�� ��ü ������
local ItemList_Current_Page = 1	-- ������ ����Ʈ�� ���� ������.
local bCraftingItemEventEnd		= false	-- ���յǴ� �������� ����� ������(�ѹ��� ��������)
local bReceiveMessagetoServer	= false -- �������� ���� ���Դ���.
local bRewardWindowMotionEnd	= false	-- ���� �˾�â�� �̺�Ʈ�� �Ϸ�Ǿ���.
local tCraftingRewardInfoTable	= {['err']=0, [0]="", "", -1, -1}	-- ����â�� ���� ����.



local CraftingMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingMainBackImage")
CraftingMainBackWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CraftingMainBackWindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
CraftingMainBackWindow:setPosition(0,0)
CraftingMainBackWindow:setSize(1920, 1200)
CraftingMainBackWindow:setAlwaysOnTop(true)
CraftingMainBackWindow:setVisible(false)
CraftingMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(CraftingMainBackWindow)


--------------------------------------------------------------------
-- �ڽ�Ƭ ����â ����===============================================
--------------------------------------------------------------------
-- ����â ����.
local CraftingWindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingPopupImage")
CraftingWindow:setTexture("Enabled", "UIData/Crafting.tga", 0, 0)
CraftingWindow:setTexture("Disabled", "UIData/Crafting.tga", 0, 0)
CraftingWindow:setWideType(6);
CraftingWindow:setPosition(30, 60)
CraftingWindow:setSize(342, 390)
CraftingWindow:setAlwaysOnTop(true)
CraftingWindow:setVisible(true)
CraftingWindow:setZOrderingEnabled(false)
CraftingMainBackWindow:addChildWindow(CraftingWindow)

RegistEscEventInfo("CraftingMainBackImage", "CloseItemCrafting")

-- �ڽ�Ƭ ����â �ݱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Crafting_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(310, 10)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseItemCraftingButtonEvent")
winMgr:getWindow("CraftingPopupImage"):addChildWindow(mywindow)


-- ť�� ������ �̹���1 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingPopupEffectImg1")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 346, 614)	--580, 614)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 346, 614)
mywindow:setPosition(60, 48)
mywindow:setSize(234, 234)
mywindow:setAlwaysOnTop(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("CubeEventController", "CubeCheckEvent", "alpha", "Sine_EaseIn", 255, 0, 6, true, true, 10)
mywindow:addController("CubeEventController", "CubeCheckEvent", "alpha", "Sine_EaseIn", 0, 255, 6, true, true, 10)
CraftingWindow:addChildWindow(mywindow)


-- ť�� ������ �̹���2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingPopupEffectImg2")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 580, 614)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 580, 614)
mywindow:setWideType(6)
mywindow:setPosition(90, 108)
mywindow:setSize(234, 234)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setAlign(8)
mywindow:setZOrderingEnabled(true)
mywindow:setUseEventController(false)
mywindow:addController("CubeEventController", "CubeEvent", "xscale", "Sine_EaseIn", 255, 2000, 8, true, false, 10)
mywindow:addController("CubeEventController", "CubeEvent", "yscale", "Sine_EaseIn", 255, 2000, 8, true, false, 10)
mywindow:addController("CubeEventController", "CubeEvent", "alpha", "Sine_EaseIn", 255, 0, 8, true, false, 10)
root:addChildWindow(mywindow)


-- ť�忡 ���� �����۵��� ��ü ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemBackImgDisable")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 346, 848)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 346, 848)
mywindow:setPosition(73, 78)
mywindow:setSize(199, 182)
mywindow:setAlign(8)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
mywindow:setUseEventController(false)
CraftingWindow:addChildWindow(mywindow)



-- ť�忡 ���� �����۵��� ��ü ����
local CraftingItemBack = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemBackImg")
CraftingItemBack:setTexture("Enabled", "UIData/invisible.tga", 346, 848)
CraftingItemBack:setTexture("Disabled", "UIData/invisible.tga", 346, 848)
CraftingItemBack:setPosition(73, 78)
CraftingItemBack:setSize(199, 182)
CraftingItemBack:setAlign(8)
CraftingItemBack:setAlwaysOnTop(true)
CraftingItemBack:setVisible(true)
CraftingItemBack:setZOrderingEnabled(true)
CraftingItemBack:setUseEventController(false)
CraftingItemBack:subscribeEvent("MotionEventEnd", "CubeItemBackEventEnd");
CraftingItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "angle", "Sine_EaseIn", 0, 3000, 8, true, false, 10)
CraftingItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "xscale", "Linear_EaseNone", 255, 0, 8, true, false, 10)
CraftingItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "yscale", "Linear_EaseNone", 255, 0, 8, true, false, 10)
CraftingWindow:addChildWindow(CraftingItemBack)


-- �����۸���� �Ϸ�Ǿ�����.
function CubeItemBackEventEnd(args)
	if bCraftingItemEventEnd == false then
		bCraftingItemEventEnd = true
		CheckCompleteMessage()
	end
end


-- �ڽ�Ƭ ���� ���ϰ��� �������� �޾ƿԴ���.
function CheckCompleteMessage()
	if bCraftingItemEventEnd and bReceiveMessagetoServer then	-- �������� ������� ����� ������ ���������� ���� ���Դٸ�
		ShowCraftingReward()
	end
end

-- ������ �޼����� �޾Ҵ�.
function SetReceiveMessagetoServer()
	bReceiveMessagetoServer	= true
end


local CraftingItemTablePosX = {['err']=0, 1, 128}

for i=1, #CraftingItemTablePosX do
	-- ���� �ڽ�Ƭ ����.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingCostumeBackImg"..i)
	mywindow:setTexture("Enabled", "UIData/my_room3.tga", 0, 912)
	mywindow:setTexture("Disabled", "UIData/my_room3.tga", 0, 912)
	mywindow:setPosition(CraftingItemTablePosX[i], 1)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	CraftingItemBack:addChildWindow(mywindow)
	
	-- ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingCostumeImg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(6, 5)
	mywindow:setSize(125, 125)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setScaleWidth(150)
	mywindow:setScaleHeight(150)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("CraftingCostumeBackImg"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/Button", "CraftingMouseEventBtn"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_MyCraftItemInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_MyCraftItemInfo")
	winMgr:getWindow("CraftingCostumeBackImg"..i):addChildWindow(mywindow)
	
	
	-- ���� �ڽ�Ƭ ù��° �ݱ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "Erase_CraftingCostume"..i)
	mywindow:setTexture("Normal", "UIData/my_room3.tga", 234, 912)
	mywindow:setTexture("Hover", "UIData/my_room3.tga", 234, 931)
	mywindow:setTexture("Pushed", "UIData/my_room3.tga", 234, 950)
	mywindow:setTexture("PushedOff", "UIData/my_room3.tga", 234, 950)
	mywindow:setPosition(50, 1)
	mywindow:setSize(19, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "OnClickCraftingCostumeErase")
	winMgr:getWindow("CraftingCostumeBackImg"..i):addChildWindow(mywindow)

end


-- ���� ť�� ���� �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingCostumeImg3")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 70, 912)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 70, 912)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(65, 105)
mywindow:setSize(70, 70)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setLayered(true)
mywindow:setZOrderingEnabled(false)
CraftingItemBack:addChildWindow(mywindow)

-- ���� �̺�Ʈ�� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/Button", "CraftingMouseEventBtn3")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(70, 70)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("Index", 3)
mywindow:subscribeEvent("MouseEnter", "MouseEnter_MyCraftItemInfo")
mywindow:subscribeEvent("MouseLeave", "MouseLeave_MyCraftItemInfo")
winMgr:getWindow("CraftingCostumeImg3"):addChildWindow(mywindow)


-- ����â�� �ִ� �����۵��� ���콺 �����̺�Ʈ
function MouseEnter_MyCraftItemInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, itemslot = GetCraftItemToolTipInfo(index)
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
	GetToolTipBaseInfo(x + 70, y+3, 0, Kind, itemslot, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end


function MouseLeave_MyCraftItemInfo(args)
	SetShowToolTip(false)
end


-- ť�� ����



-- �����ϱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "CraftingItemButton")
mywindow:setTexture("Normal", "UIData/my_room3.tga", 300, 934)
mywindow:setTexture("Hover", "UIData/my_room3.tga", 300, 956)
mywindow:setTexture("Pushed", "UIData/my_room3.tga", 300, 978)
mywindow:setTexture("PushedOff", "UIData/my_room3.tga", 300, 978)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 300, 912)
mywindow:setPosition(76, 60)
mywindow:setSize(46, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickCraftingItemButton")
CraftingItemBack:addChildWindow(mywindow)



-- �ڽ�Ƭ ��ϵȰ��� �ϳ��� �����.
function OnClickCraftingCostumeErase(args)
	local localWindow = CEGUI.toWindowEventArgs(args).window
	local Index = localWindow:getUserString("Index")
	
	EraseCraftingItem(Index)
	Upgrade_RefreshItemList()
	winMgr:getWindow("CraftingCostumeBackImg"..Index):setVisible(false)
	CheckCrafting()
end


function AutoErase(index)
	if index > 2 then
		winMgr:getWindow("CraftingCostumeImg3"):setVisible(false)
	else
		winMgr:getWindow("CraftingCostumeBackImg"..index):setVisible(false)
	end	
	CheckCrafting()
end


-- ��� �������� ���Դ��� Ȯ���Ѵ�.
function CheckCrafting()
	if CheckforReadytCrafting() then
		winMgr:getWindow("CraftingPopupEffectImg1"):setVisible(true)
		winMgr:getWindow("CraftingPopupEffectImg1"):activeMotion("CubeCheckEvent")
		winMgr:getWindow("CraftingItemButton"):setEnabled(true)
	else
		winMgr:getWindow("CraftingPopupEffectImg1"):setVisible(false)
		winMgr:getWindow("CraftingPopupEffectImg1"):clearActiveController()	
		winMgr:getWindow("CraftingItemButton"):setEnabled(false)
	end
end


-- ������ ���� �Ѵٰ� �����ش�.
function OnClickCraftingItemButton()
	CostumeCraftingStarttoServer()
	
	-- �����۵��� ������ ���� �̺�Ʈ
	winMgr:getWindow("CraftingItemBackImg"):activeMotion("CubeItemBackEvent")
	
	ClearCraftingItemInfo()
end



-- ����â�� ������
function ItemCraftingResetEvent()
	
	bCraftingItemEventEnd	= false	-- ���յǴ� �������� ����� ������(�ѹ��� ��������)
	bReceiveMessagetoServer	= false	-- �������� ����޼����� ���Դ���.
	bRewardWindowMotionEnd	= false
	tCraftingRewardInfoTable	= {['err']=0, [0]="", "", -1, -1}	-- ����â�� ���� ����.
	
	winMgr:getWindow("CraftingPopupEffectImg2"):setVisible(false)
	winMgr:getWindow("CraftingPopupEffectImg2"):clearActiveController()
	winMgr:getWindow("CraftingItemBackImg"):clearActiveController()
	winMgr:getWindow("CraftingItemBackImg"):setVisible(true)
	CraftingItemBack:setScaleWidth(255)
	CraftingItemBack:setScaleHeight(255)

	for i=1, #CraftingItemTablePosX do
		winMgr:getWindow("CraftingCostumeBackImg"..i):setVisible(false)
	end

	winMgr:getWindow("CraftingCostumeImg3"):setVisible(false)

	local slot = GetCubeSlotIndex()
	if slot ~= -1 then
		SetCraftingItem(slot, 1)
	end
	CheckCrafting()
	Upgrade_RefreshItemList()
end


--------------------------------------------------------------------
-- �ڽ�Ƭ ����â ��=================================================
--------------------------------------------------------------------





--------------------------------------------------------------------
-- �� ������ ����Ʈ ����============================================
--------------------------------------------------------------------
-- �����۸���Ʈ ����
local CraftingItemListWindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemListBackImage")
CraftingItemListWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
CraftingItemListWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
CraftingItemListWindow:setWideType(6);
CraftingItemListWindow:setPosition(720, 60)
CraftingItemListWindow:setSize(296, 438)
CraftingItemListWindow:setAlwaysOnTop(true)
CraftingItemListWindow:setVisible(true)
CraftingItemListWindow:setZOrderingEnabled(false)
CraftingMainBackWindow:addChildWindow(CraftingItemListWindow)


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_PageText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(188, 373)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
CraftingItemListWindow:addChildWindow(mywindow)


-- ������ �¿� ��ư
local tMyShopItemList_BtnName  = {["err"]=0, [0]="CraftingItemList_LBtn", "CraftingItemList_RBtn"}
local tMyShopItemList_BtnTexX  = {["err"]=0, [0]=987, 970}
local tMyShopItemList_BtnPosX  = {["err"]=0, [0]=170, 270}
local tMyShopItemList_BtnEvent = {["err"]=0, [0]="OnClickCraftingItemList_PrevPage", "OnClickCraftingItemList_NextPage"}
for i=0, #tMyShopItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyShopItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyShopItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyShopItemList_BtnPosX[i], 370)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyShopItemList_BtnEvent[i])
	CraftingItemListWindow:addChildWindow(mywindow)
end

-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickCraftingItemList_PrevPage()
	local check = CraftingPrevButtonEvent()
	if check then
		local totalPage = GetCraftingTotalPage()
		local currentPage = GetCraftingCurrentPage()
		winMgr:getWindow("CraftingItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- ������ ���ư Ŭ���̺�Ʈ
function OnClickCraftingItemList_NextPage()
	local check = CraftingNextButtonEvent()
	if check then
		local totalPage = GetCraftingTotalPage()
		local currentPage = GetCraftingCurrentPage()
		winMgr:getWindow("CraftingItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end


--[[
-- �׶� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemList_GranImage")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setPosition(16, 371)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CraftingItemListWindow:addChildWindow(mywindow)

-- ���� ���� �׶�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_MyGran")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(44, 371)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
CraftingItemListWindow:addChildWindow(mywindow)
--]]

-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
local ItemListName  = {["err"]=0, [0]="CraftingItemList_costume", "CraftingItemList_etc"}
local ItemListTexX  = {["err"]=0, [0]=0, 140}
local ItemListPosX  = {["err"]=0, [0]=4, 76}

for i=0, #ItemListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", ItemListName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", ItemListTexX[i], 455)
	mywindow:setTexture("Hover", "UIData/deal.tga", ItemListTexX[i], 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", ItemListTexX[i], 497)
	mywindow:setTexture("Disabled", "UIData/deal.tga", ItemListTexX[i], 455)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", ItemListTexX[i], 497)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", ItemListTexX[i], 497)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", ItemListTexX[i], 497)
	mywindow:setPosition(ItemListPosX[i], 39)
	mywindow:setProperty("GroupID", 2019)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_CraftingItemListTab")
--	mywindow:setProperty("Selected", "true")
	CraftingItemListWindow:addChildWindow(mywindow)
end


function OnSelect_CraftingItemListTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetItemCraftingTab(tabindex)		
	end
end


-- ������ ����Ʈ �ǸŸ��
for i=0, MAX_CRAFT_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "CraftingItemList_"..i)
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
	CraftingItemListWindow:addChildWindow(mywindow)
	
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CraftingItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_MyCraftItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_MyCraftItemListInfo")
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_Num_"..i)
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CraftingItemList_Period_"..i)
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
	
	-- ������ ��Ϲ�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "CraftingItemList_RegistBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setPosition(210, 30)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "ClickedCraftItemRegist")
	winMgr:getWindow("CraftingItemList_"..i):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- �� ������ ����Ʈ �� =============================================
--------------------------------------------------------------------


--------------------------------------------------------------------
-- ������ ���� ����â ���� =========================================
--------------------------------------------------------------------

-- ������ ���� ����â ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- Esc, EnterŰ ������
RegistEscEventInfo("Crafting_RewardAlpha", "Crafting_RewardOKButtonEvent")
RegistEnterEventInfo("Crafting_RewardAlpha", "Crafting_RewardOKButtonEvent")


-- ������ ���� ����â�˾�(��Ʈ�ѷ��� �־��ֱ� ���ؼ� ����â�� ���ϵ�� ��� ���ߴ�.)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardImagePopup")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition((g_MAIN_WIN_SIZEX / 2 - 340 / 2), (g_MAIN_WIN_SIZEY / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--mywindow:subscribeEvent("EndRender", "MyInven_CostumeRandomEndRender")			-- ����
mywindow:subscribeEvent("MotionEventEnd", "Crafting_RewardMotionEventEnd");	-- ��Ʈ�ѷ� ����� �Ϸ������ ������ �Լ�
mywindow:setAlign(8);
mywindow:addController("Controller", "CraftingRewardController", "xscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("Controller", "CraftingRewardController", "yscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("Controller", "CraftingRewardController", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10);
root:addChildWindow(mywindow)

-- Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Crafting_RewardOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "Crafting_RewardOKButtonEvent")
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


-- ���� �̹��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardImageBack")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 545, 848)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 545, 848)
mywindow:setPosition(38, 62)
mywindow:setSize(269, 176)
mywindow:setVisible(true)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


-- ���� ���� �̹���
tResultStringImage = {['err']=0, 948, 977}

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_ResultStringImage")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 814, 948)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 814, 948)
mywindow:setPosition(118, 47)
mywindow:setSize(100, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


-- ����(�̹���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardImage")
mywindow:setTexture("Enabled", "UIData/ItemUIData/Costume/M_M/C_Upper/M_M_Upper_020.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/CASH_Capsule.tga", 0, 0)
mywindow:setPosition(124, 87)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(220)
mywindow:setScaleHeight(230)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "Crafting_RewardText2")
mywindow:setPosition(38, 203)
mywindow:setSize(269, 30)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


--[[
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Crafting_RewardText1")
mywindow:setPosition(0, 60)
mywindow:setSize(340, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "Crafting_RewardText2")
mywindow:setPosition(150, 112)
mywindow:setSize(160, 80)
mywindow:setViewTextMode(1)
mywindow:setAlign(1)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "Crafting_RewardText3")
mywindow:setPosition(150, 148)
mywindow:setSize(160, 80)
mywindow:setViewTextMode(1)
mywindow:setAlign(1)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


-- ���� �̹��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardImageBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setPosition(44, 96)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Crafting_RewardImagePopup"):addChildWindow(mywindow)


--]]

function Crafting_RewardMotionEventEnd(args)
	if bRewardWindowMotionEnd == false then
		bRewardWindowMotionEnd = true
--		winMgr:getWindow("Crafting_RewardText1"):setVisible(true)
		winMgr:getWindow("Crafting_RewardText2"):setVisible(true)
--		winMgr:getWindow("Crafting_RewardText3"):setVisible(true)		
	end
end

-- ������ ���â�� �����ش�.
function ShowCraftingReward()
	-- ���� ���������� ������ �����Ÿ��� �̺�Ʈ �����ش�.
	winMgr:getWindow("CraftingPopupEffectImg1"):clearActiveController()	
	winMgr:getWindow("CraftingPopupEffectImg1"):setVisible(false)
	
	-- Ǫ���� ť�갡 Ŀ���鼭 ������ ������ �̺�Ʈ
	winMgr:getWindow("CraftingPopupEffectImg2"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CraftingPopupEffectImg2"))
	winMgr:getWindow("CraftingPopupEffectImg2"):activeMotion("CubeEvent")
	
	
	local String1 = PreCreateString_2351
	local String2 = PreCreateString_2334
	
	if tCraftingRewardInfoTable[2] == 1 then	-- ���� ����
		-- ���� �˾�â ����ְ�
		root:addChildWindow(winMgr:getWindow("Crafting_RewardAlpha2"))
		winMgr:getWindow("Crafting_RewardAlpha2"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("Crafting_RewardImagePopup2"))
		winMgr:getWindow("Crafting_RewardImagePopup2"):setVisible(true)	
		
		-- �����˾�â �̺�Ʈ �߻������ش�.
		winMgr:getWindow("Crafting_RewardImagePopup2"):activeMotion("CraftingRewardController2")
		winMgr:getWindow("Crafting_RewardTextFail"):setTextExtends(PreCreateString_2371, g_STRING_FONT_DODUMCHE, 15, 255,255,255,255,   0, 0,0,0,255)
		return
	elseif tCraftingRewardInfoTable[2] == 0 then	-- ���� ����
	
	else
		local string = AdjustString(g_STRING_FONT_DODUMCHE, 15, GetSStringInfo(tCraftingRewardInfoTable[2]), 200)
		
		winMgr:getWindow("Crafting_RewardTextFail"):setTextExtends(string, g_STRING_FONT_DODUMCHE, 15, 255,255,255,255,   0, 0,0,0,255)
		-- ���� �˾�â ����ְ�
		root:addChildWindow(winMgr:getWindow("Crafting_RewardAlpha2"))
		winMgr:getWindow("Crafting_RewardAlpha2"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("Crafting_RewardImagePopup2"))
		winMgr:getWindow("Crafting_RewardImagePopup2"):setVisible(true)	
		
		-- �����˾�â �̺�Ʈ �߻������ش�.
		winMgr:getWindow("Crafting_RewardImagePopup2"):activeMotion("CraftingRewardController2")
		return
	end
	-- ���� �˾�â ����ְ�
	root:addChildWindow(winMgr:getWindow("Crafting_RewardAlpha"))
	winMgr:getWindow("Crafting_RewardAlpha"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("Crafting_RewardImagePopup"))
	winMgr:getWindow("Crafting_RewardImagePopup"):setVisible(true)	
	
	-- �����˾�â �̺�Ʈ �߻������ش�.
	winMgr:getWindow("Crafting_RewardImagePopup"):activeMotion("CraftingRewardController")
		
--	winMgr:getWindow("Crafting_RewardText1"):setTextExtends(String1, g_STRING_FONT_DODUMCHE, 15, 255,255,255,255,   0, 0,0,0,255)
	local itemNameString = SummaryString(g_STRING_FONT_DODUMCHE, 15, tCraftingRewardInfoTable[1], 320)
	winMgr:getWindow("Crafting_RewardText2"):setTextExtends(itemNameString, g_STRING_FONT_DODUMCHE, 15, 255,255,255,255,   0, 0,0,0,255)
--	winMgr:getWindow("Crafting_RewardText3"):setTextExtends(String2, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("Crafting_RewardImage"):setTexture("Enabled", "UIData/ItemUIData/"..tCraftingRewardInfoTable[0], 0, 0)
	winMgr:getWindow("Crafting_RewardImage"):setTexture("Disabled", "UIData/ItemUIData/"..tCraftingRewardInfoTable[0], 0, 0)
	
	if tCraftingRewardInfoTable[3] == 0 then	-- ���� �ڽ�
		winMgr:getWindow("Crafting_RewardImage"):setPosition(117, 87)
	else
		winMgr:getWindow("Crafting_RewardImage"):setPosition(124, 87)
	end	
end


function Crafting_RewardOKButtonEvent()
	winMgr:getWindow("Crafting_RewardAlpha"):setVisible(false)
	winMgr:getWindow("Crafting_RewardImagePopup"):setVisible(false)
	winMgr:getWindow("Crafting_RewardImagePopup"):clearActiveController()	
	
	winMgr:getWindow("Crafting_RewardAlpha2"):setVisible(false)
	winMgr:getWindow("Crafting_RewardImagePopup2"):setVisible(false)
	winMgr:getWindow("Crafting_RewardImagePopup2"):clearActiveController()	
--	winMgr:getWindow("Crafting_RewardText1"):setVisible(false)
	winMgr:getWindow("Crafting_RewardText2"):setVisible(false)
	winMgr:getWindow("Crafting_RewardTextFail"):setVisible(false)
--	winMgr:getWindow("Crafting_RewardText3"):setVisible(false)		
	ItemCraftingResetEvent()	-- �ڽ�Ƭ ����â ���� �ʱ�ȭ
	
end



--------------------------------------------------------------------
-- ������ ���� ����â �� ===========================================
--------------------------------------------------------------------


-- ������ ���� ����â ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardAlpha2")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- Esc, EnterŰ ������
RegistEscEventInfo("Crafting_RewardAlpha2", "Crafting_RewardOKButtonEvent")
RegistEnterEventInfo("Crafting_RewardAlpha2", "Crafting_RewardOKButtonEvent")



-- ������ ���� ����â�˾�(��Ʈ�ѷ��� �־��ֱ� ���ؼ� ����â�� ���ϵ�� ��� ���ߴ�.)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Crafting_RewardImagePopup2")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition((g_MAIN_WIN_SIZEX / 2 - 340 / 2), (g_MAIN_WIN_SIZEY / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--mywindow:subscribeEvent("EndRender", "MyInven_CostumeRandomEndRender")			-- ����
mywindow:subscribeEvent("MotionEventEnd", "Crafting_RewardMotionEventEnd2");	-- ��Ʈ�ѷ� ����� �Ϸ������ ������ �Լ�
mywindow:addController("Controller", "CraftingRewardController2", "visible", "Sine_EaseIn", 0, 1, 7, true, false, 10)
root:addChildWindow(mywindow)


-- Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Crafting_RewardOkButton2")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "Crafting_RewardOKButtonEvent")
winMgr:getWindow("Crafting_RewardImagePopup2"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/StaticText", "Crafting_RewardTextFail")
mywindow:setPosition(0, 130)
mywindow:setSize(340, 180)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("Crafting_RewardImagePopup2"):addChildWindow(mywindow)


function Crafting_RewardMotionEventEnd2(args)
	winMgr:getWindow("Crafting_RewardTextFail"):setVisible(true)
end





-- �������� ��� �ʱ�ȭ
function ClearCraftItemList()
	for i=0, MAX_CRAFT_ITEMLIST-1 do
		winMgr:getWindow("CraftingItemList_"..i):setVisible(false)
		winMgr:getWindow("CraftingItemList_EventImage_"..i):setUserString("Index", -1)
		--winMgr:getWindow("sj_MyShopItemList_RegistBtn_"..i):setVisible(false)
	end
end

-- �� ������ ��� ����
function SettingCraftItemList(index, slotIndex, useCount, itemName, fileName, fileName2, avatarType, attach)
	winMgr:getWindow("CraftingItemList_"..index):setVisible(true)

	-- ���� ���� ���� �ε��� ����
	winMgr:getWindow("CraftingItemList_EventImage_"..index):setUserString("Index", slotIndex)
	winMgr:getWindow("CraftingItemList_RegistBtn_"..index):setUserString("Index", slotIndex)
	
	-- ������ �̹���
	winMgr:getWindow("CraftingItemList_Image_"..index):setTexture("Disabled", fileName, 0, 0)
	if fileName2 == "" then
		winMgr:getWindow("CraftingItemList_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("CraftingItemList_Image_"..index):setLayered(true)
		winMgr:getWindow("CraftingItemList_Image_"..index):setTexture("Layered", fileName2, 0, 0)	
	end
	
	winMgr:getWindow("CraftingItemList_Image_"..index):setScaleWidth(102)
	winMgr:getWindow("CraftingItemList_Image_"..index):setScaleHeight(102)
	
	-- ������ �̸�
	winMgr:getWindow("CraftingItemList_Name_"..index):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CraftingItemList_Num_"..index):setText(szCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("CraftingItemList_Period_"..index):setText(period)
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	-- �ƹ�Ÿ ���պκ�!!
	--SetAvatarIconS("CraftingItemList_Image_" , "CraftingItemList_Image_" , "CraftingItemList_Image_" , index , avatarType , attach)
end	

-- �� ������ ��� ������ ����
function SettingCraftPageText(currentpage, totalpage)
	winMgr:getWindow("CraftingItemList_PageText"):setTextExtends(currentpage.." / "..totalpage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end


-- ������ ���� �޴� ���콺 ���� �̺�Ʈ
function MouseEnter_MyCraftItemListInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber = GetCraftMyItemListToolTipInfo(index)
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


-- ������ ���� �޴� ���콺 ���� �̺�Ʈ
function MouseLeave_MyCraftItemListInfo(args)
	SetShowToolTip(false)
end


-- ��Ϲ�ư Ŭ����.
function ClickedCraftItemRegist(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local slotindex = tonumber(EnterWindow:getUserString("Index"))
	SetCraftingItem(slotindex, 0)
	CheckCrafting()

end


-- ������ �������� �˾�â�� ����ش�.
function SettingCraftingPopup(popupSlotIndex, itemSlotIndex, itemNumber, itemKind, itemCount, itemFileName, itemFileName2, avatarType, attach)
	local Index = popupSlotIndex
	
	if itemKind == ITEMKIND_COSTUM then		-- �������϶�.
		winMgr:getWindow("CraftingCostumeImg"..Index):setTexture("Enabled", itemFileName, 0, 0)
		winMgr:getWindow("CraftingCostumeImg"..Index):setTexture("Disabled", itemFileName, 0, 0)
		if itemFileName2 == "" then
			winMgr:getWindow("CraftingCostumeImg"..Index):setLayered(false)
		else
			winMgr:getWindow("CraftingCostumeImg"..Index):setLayered(true)
			winMgr:getWindow("CraftingCostumeImg"..Index):setTexture("Layered", itemFileName2, 0, 0)
		end		
		winMgr:getWindow("CraftingCostumeBackImg"..Index):setVisible(true)
		
		-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
		-- �� �ڽ�Ƭ �ƹ�Ÿ�� ���ذ� ���� �ʴ´�. ���� ������ ���� �ʿ����. ( ���� 3��° �Ű����� �ùٸ��� ���� )
		--SetAvatarIconS("CraftingCostumeImg" , "CraftingCostumeImg" , "CraftingCostumeImg" , Index , avatarType , attach)
	else
		winMgr:getWindow("CraftingCostumeImg"..Index):setVisible(true)
	end	
end


function SetRewardItemInfo(itemfileName, itemName, bSuccess, bcostume)
	tCraftingRewardInfoTable[0] = itemfileName
	tCraftingRewardInfoTable[1] = itemName
	tCraftingRewardInfoTable[2] = bSuccess
	tCraftingRewardInfoTable[3] = bcostume
	--tCraftingRewardInfoTable

	
end


-- ������ ������ �����ش�.
function ShowItemCrafting()
	if CEGUI.toRadioButton(winMgr:getWindow("CraftingItemList_costume")):isSelected() then
		SetItemCraftingTab(0)	-- ���õ� �����϶��� �̺�Ʈ�� ȣ��ȵǱ⶧����
	else
		winMgr:getWindow("CraftingItemList_costume"):setProperty("Selected", "true") -- �� �������ش�.
	end
	local totalPage = GetCraftingTotalPage()
	local currentPage = GetCraftingCurrentPage()

	winMgr:getWindow("CraftingItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	root:addChildWindow(CraftingMainBackWindow)
	CraftingMainBackWindow:setVisible(true)
	CheckCrafting()	-- �������� �� ���ִ��� Ȯ��(ȿ��������)
end


function CloseItemCrafting()
	VirtualImageSetVisible(false)
	CraftingMainBackWindow:setVisible(false)
	winMgr:getWindow("CraftingCostumeBackImg1"):setVisible(false)
	winMgr:getWindow("CraftingCostumeBackImg2"):setVisible(false)
	winMgr:getWindow("CraftingCostumeImg3"):setVisible(false)
	ClearCraftingItemInfo()
end

-- �ݴ´�.
function CloseItemCraftingButtonEvent()
	VirtualImageSetVisible(false)
	CraftingMainBackWindow:setVisible(false)
	winMgr:getWindow("CraftingCostumeBackImg1"):setVisible(false)
	winMgr:getWindow("CraftingCostumeBackImg2"):setVisible(false)
	winMgr:getWindow("CraftingCostumeImg3"):setVisible(false)
	ClearCraftingItemInfo()
	TownNpcEscBtnClickEvent()
end
