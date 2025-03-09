
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


-- Ŭ�� �ƹ�Ÿ�� ���¸� ���ϴ� ����
local COSTUME_NORMAL	= 0
local COSTUME_NO_VISUAL	= -1
local COSTUME_SEAL		= -2
local COSTUME_VISAL		= -3	--	����� �ƹ�Ÿ


--------------------------------------------------------------------
-- ������ ����
--------------------------------------------------------------------
local MAX_INVEN_ITEM_X_COUNT = GetOnePageMaxItemCount(0)		-- ���������� ���� �������� �ִ밹���� �޾ƿ´�.
local MAX_INVEN_ITEM_Y_COUNT = GetOnePageMaxItemCount(1)		-- ���������� ���� �������� �ִ밹���� �޾ƿ´�.
local Item_first_PointX = 40
local Item_first_PointY = 106
local Item_X_term = 61
local Item_Y_term = 61
local bUseItem = true

local g_STRING_CLONE_MOVE_TO_STORAGE		= PreCreateString_3560	--GetSStringInfo(LAN_CLONE_MESSAGE_2)	-- ������ ������ �ڽ�Ƭ�� �����Ҽ� �����ϴ�.��
local g_STRING_CLONE_DELETE_TO_INVENTOTY	= PreCreateString_3561	--GetSStringInfo(LAN_CLONE_MESSAGE_3)	-- ������ ������ �ڽ�Ƭ�� �����Ҽ� �����ϴ�.��


--------------------------------------------------------------------
-- ���� �κ��丮
-------------------------------------------------------------
-------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_VirtualBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(1024 - 330, (g_MAIN_WIN_SIZEY-500)/2)
mywindow:setSize(309, 502)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


local MyInvenWindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_BackImage")
MyInvenWindow:setTexture("Enabled", "UIData/Match002.tga", 715, 0)
MyInvenWindow:setTexture("Disabled", "UIData/Match002.tga", 715, 0)
MyInvenWindow:setPosition((g_MAIN_WIN_SIZEX - 310)/2, (g_MAIN_WIN_SIZEY-500)/2)
MyInvenWindow:setSize(309, 532)
MyInvenWindow:setAlwaysOnTop(true)
MyInvenWindow:setVisible(false)
MyInvenWindow:setZOrderingEnabled(true)
root:addChildWindow(MyInvenWindow)


RegistEscEventInfo("MyInven_BackImage", "HideMyInventory")

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "MyInven_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(273, 30)
mywindow:setEnabled(true)
MyInvenWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� �κ��丮 �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(279, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMyInventory")
MyInvenWindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �κ��丮 ���̼� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_MyshopButton")
mywindow:setTexture("Normal",	"UIData/match002.tga", 413, 904)
mywindow:setTexture("Hover",	"UIData/match002.tga", 413, 934)
mywindow:setTexture("Pushed",	"UIData/match002.tga", 413, 964)
mywindow:setTexture("PushedOff","UIData/match002.tga", 413, 994)
mywindow:setTexture("Enabled",	"UIData/match002.tga", 413, 994)
mywindow:setTexture("Disabled", "UIData/match002.tga", 413, 994)
mywindow:setPosition(100, 485)
mywindow:setSize(112, 30)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedMyShopCreated")
MyInvenWindow:addChildWindow(mywindow)

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then
	--winMgr:getWindow("MyInven_MyshopButton"):setEnabled(false)		
end

function ClickedMyShopCreated( args )

	if IsKoreanLanguage() == false then
		CloseSetVisualWindow() -- ����� ����â�� �ݴ´١�
	end
	
	if winMgr:getWindow("MailBackImage"):isVisible() then
		return
	end
	RequestMyShopCreated()
end

-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
tMyInvenListName  = {["err"]=0, [0]="MyInven_costume", "MyInven_skill", "MyInven_etc", "MyInven_special", "MyInven_cashTab"}
tMyInvenListTexX  = {["err"]=0, [0]=377, 433, 489, 545, 601}
tMyInvenListPosX  = {["err"]=0, [0]=13, 13 + 56, 13 + 56*2, 13 + 56*3, 13 + 56*4}
tMyInvenListEvent = {["err"]=0, [0]="Select_Costume_Tab", "Select_Skill_Tab", "Select_Etc_Tab", "Select_Special_Tab", "Select_Cash_Tab"}
for i=0, #tMyInvenListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyInvenListName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyInvenListTexX[i], 577)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyInvenListTexX[i], 600)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyInvenListTexX[i], 623)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyInvenListTexX[i], 577)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyInvenListTexX[i], 623)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyInvenListTexX[i], 623)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyInvenListTexX[i], 623)
	mywindow:setPosition(tMyInvenListPosX[i], 41)
	mywindow:setProperty("GroupID", 2101)
	mywindow:setSize(56, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyInventorySelectTab")--tMyInvenListEvent[i])
	if i == 0 then
		mywindow:setProperty("Selected", "true")
	end
	MyInvenWindow:addChildWindow(mywindow)
end


local aaass = 49
-- ������ �ε���(�ִ� 5��)
tMyInvenBagName  = {["err"]=0, [0]="MyInven_Bag1", "MyInven_Bag2", "MyInven_Bag3", "MyInven_Bag4", "MyInven_Bag5"}
tMyInvenBagTexX  = {["err"]=0, [0]=	377, 426, 475, 524, 573}
tMyInvenBagPosX  = {["err"]=0, [0]=	31, 31 + aaass, 31 + aaass*2, 31 + aaass*3, 31 + aaass*4}
tMyInvenBagEvent = {["err"]=0, [0]="Select_Bag1", "Select_Bag2", "Select_Bag3", "Select_Bag4", "Select_Bag5"}
for i=0, #tMyInvenBagName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyInvenBagName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyInvenBagTexX[i], 646)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyInvenBagTexX[i], 670)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyInvenBagTexX[i], 694)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyInvenBagTexX[i], 718)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyInvenBagTexX[i], 694)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyInvenBagTexX[i], 694)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyInvenBagTexX[i], 694)
	mywindow:setPosition(tMyInvenBagPosX[i], 70)
	mywindow:setProperty("GroupID", 2102)
	mywindow:setSize(49, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i + 1)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyInventorySelectBag")
	MyInvenWindow:addChildWindow(mywindow)
end



function MyInventorySelectBag(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local ClickWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(ClickWindow:getUserString("Index"))
	--	local check = PageButtonEvent(index)
		
	--	if check then			
			RefreshUiView(index)
	--	end
	end
	HideRandomOpenItem();
end


-- ������ ����Ʈ �ǸŸ��
for i=0, MAX_INVEN_ITEM_Y_COUNT-1 do
	for j=0, MAX_INVEN_ITEM_X_COUNT-1 do
		local Index = i*MAX_INVEN_ITEM_X_COUNT+j

		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Image_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX-2 + Item_X_term*j, Item_first_PointY-2 + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(125)
		mywindow:setScaleHeight(125)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		MyInvenWindow:addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Image_Seal_"..Index)
		mywindow:setTexture("Enabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)
		mywindow:setScaleHeight(118)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		MyInvenWindow:addChildWindow(mywindow)
		
				
		-- ��ų ���� �׵θ� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_SkillLevelImage_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 16, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)

		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_ItemList_SkillLevelText_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 21, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)


		-- �������� ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Warning_"..Index)
		mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)
		
		
		-- �������� ������(Pure OR SelectedVisual) �̹��� ��
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Avatar_Icon_Type"..Index)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(122)--118)
		mywindow:setScaleHeight(122)--118)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)
		
		-- �������� ������(Pure OR SelectedVisual) �̹���2 ��
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Avatar_Icon_Type2"..Index)
		mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)
		
		-- ��Ż ��ų Time ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemList_Rental_Skill_"..Index)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(122)--118)
		mywindow:setScaleHeight(122)--118)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyInvenWindow:addChildWindow(mywindow)
		
		
		
		
		-- �������� ��ư(������ ��ü���� ��ư)
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "MyInven_ItemList_Button_"..Index)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/Match002.tga", 667, 694)
		mywindow:setTexture("Pushed", "UIData/Match002.tga", 667, 742)
		mywindow:setTexture("PushedOff", "UIData/Match002.tga", 667, 26)
		mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("SelectedHover", "UIData/Match002.tga", 667, 694)
		mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", 667, 742)
		mywindow:setTexture("SelectedPushedOff", "UIData/Match002.tga", 667, 742)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", tostring(-1))
		mywindow:subscribeEvent("MouseButtonDown", "MyInven_MouseLButtonDown")
		mywindow:subscribeEvent("MouseLButtonUp", "MyInven_MouseLButtonUp")
		mywindow:subscribeEvent("MouseDoubleClicked", "MyInven_ItemdoubleClick")
		mywindow:subscribeEvent("MouseRButtonUp", "MyInven_MouseRButtonUp")
		mywindow:subscribeEvent("MouseEnter", "MyInven_ItemMouseEnter")
		mywindow:subscribeEvent("MouseLeave", "MyInven_ItemMouseLeave")
		MyInvenWindow:addChildWindow(mywindow)
		
		-- ���� ������ ����
		mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_DetailIInfoBtn_"..Index)
		mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
		mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
		mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
		mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
		mywindow:setPosition(30, 30)
		mywindow:setSize(20, 20)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setSubscribeEvent("Clicked", "MyInven_ShowRandomOpenItem")
		winMgr:getWindow("MyInven_ItemList_Button_"..Index):addChildWindow(mywindow)
		
		
		-- ������ ���� ī��Ʈ
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_ItemList_Count_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(2, 2)
		mywindow:setSize(45, 20)
		mywindow:setAlign(6)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("MyInven_ItemList_Button_"..Index):addChildWindow(mywindow)

	end
end



-- �� �����ִ� �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_GranText")
mywindow:setPosition(110, 419)
mywindow:setSize(155, 15)
mywindow:setAlign(6)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
MyInvenWindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_CoinText")
mywindow:setPosition(110, 441)
mywindow:setSize(155, 15)
mywindow:setAlign(6)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
MyInvenWindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_CashText")
mywindow:setPosition(110, 463)
mywindow:setSize(155, 15)
mywindow:setAlign(6)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
MyInvenWindow:addChildWindow(mywindow)
----------------------



-- ������ Ŭ���� ������ ��ư-----------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_functionWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(80, 40)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setUserString("index", tostring(-1))
root:addChildWindow(mywindow)

-- ������ Ŭ���� ������ ��ư-----------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_function2Window")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(80, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setUserString("index", tostring(-1))
--root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_functionEquipBtn2")
mywindow:setTexture("Normal", "UIData/Match002.tga", 590, 497)
mywindow:setTexture("Hover", "UIData/Match002.tga", 590, 517)
mywindow:setTexture("Pushed", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("PushedOff", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("Disabled", "UIData/Match002.tga", 590, 557)
mywindow:setPosition(0, 0)
mywindow:setSize(80, 20)
mywindow:setUserString("index", 1)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "functionEquipBtnEvent2")
winMgr:getWindow('MyInven_function2Window'):addChildWindow(mywindow)


RegistEscEventInfo("MyInven_functionWindow", "HidefunctionWindow")


function HidefunctionWindow()
	winMgr:getWindow('MyInven_functionWindow'):setVisible(false)	
	winMgr:getWindow('MyInven_function2Window'):setVisible(false)	
end


mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_functionEquipBtn")
mywindow:setTexture("Normal", "UIData/Match002.tga", 510, 497)
mywindow:setTexture("Hover", "UIData/Match002.tga", 510, 517)
mywindow:setTexture("Pushed", "UIData/Match002.tga", 510, 537)
mywindow:setTexture("PushedOff", "UIData/Match002.tga", 510, 537)
mywindow:setTexture("Disabled", "UIData/Match002.tga", 510, 557)
mywindow:setPosition(0, 0)
mywindow:setSize(80, 20)
mywindow:setUserString("index", 0)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "functionEquipBtnEvent")
winMgr:getWindow('MyInven_functionWindow'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_functionClearBtn")
mywindow:setTexture("Normal", "UIData/Match002.tga", 590, 497)
mywindow:setTexture("Hover", "UIData/Match002.tga", 590, 517)
mywindow:setTexture("Pushed", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("PushedOff", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("Disabled", "UIData/Match002.tga", 590, 557)
mywindow:setPosition(0, 18)
mywindow:setSize(80, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "functionClearBtnEvent")
winMgr:getWindow('MyInven_functionWindow'):addChildWindow(mywindow)



-- ���� Ȯ��â
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MyInven_DeletePopupAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("MyInven_DeletePopupAlpha", "MyInvenDeletePopupCancelEvent")
RegistEnterEventInfo("MyInven_DeletePopupAlpha", "MyInvenDeletePopupOkEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MyInven_DeletePopupImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MyInven_DeletePopupAlpha'):addChildWindow(mywindow);

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_DeletePopupText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2537, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
winMgr:getWindow('MyInven_DeletePopupImage'):addChildWindow(mywindow);

-- ok��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_DeletePopupOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "MyInvenDeletePopupOkEvent")
winMgr:getWindow('MyInven_DeletePopupImage'):addChildWindow(mywindow)

-- cancel ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_DeletePopupCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "MyInvenDeletePopupCancelEvent")
winMgr:getWindow('MyInven_DeletePopupImage'):addChildWindow(mywindow)


-- ���� ok��ư �̺�Ʈ
function MyInvenDeletePopupOkEvent(args)
	winMgr:getWindow("MyInven_DeletePopupAlpha"):setVisible(false)
	local index = tonumber(winMgr:getWindow("MyInven_functionWindow"):getUserString("index"))
	winMgr:getWindow("MyInven_functionWindow"):setUserString("index", tostring(-1))
	
	MyInvenItemDelete(index)	
end


-- ���� cancel��ư �̺�Ʈ
function MyInvenDeletePopupCancelEvent(args)
	winMgr:getWindow("MyInven_DeletePopupAlpha"):setVisible(false)
	winMgr:getWindow("MyInven_functionWindow"):setUserString("index", tostring(-1))

end



-- ������ ���� �̺�Ʈ
function functionEquipBtnEvent(args)
	DebugStr("functionEquipBtnEvent ����")
	
	local functionIndex = 0
	local index			= tonumber(winMgr:getWindow("MyInven_functionWindow"):getUserString("index"))
	
	winMgr:getWindow("MyInven_functionWindow"):setVisible(false)
	winMgr:getWindow("MyInven_function2Window"):setVisible(false)
	
	if index < 0 then
		return
	end
	
	local tabIndex = GetInventoryTab()	-- �κ��丮 ���� �˾ƿ´�(������ �������� ���� �ٸ� �ڽ���~)
	SetSelectedItemIndex(index)			-- ���� ���õ� �������� �����ε����� �������ش�.
	
	local kind, bwear, itmenumber = GetSelectItemKind(index)
	
	
	-- ��Ÿ ������
	if tabIndex == 2 then
		if CheckUseItemEnable(kind) == false then
			return
		end
		
		if kind == ITEMKIND_CHANGE_EMBLEM then		-- ������ ��ü ������
			if IsKoreanLanguage() then
				ShowChangeAmblemWin(index)
			else
				ShowNotifyOKMessage_Lua(PreCreateString_2336)   -- ���̼������� ����Ҽ� �ֽ��ϴ�.
				return
			end
			
		elseif kind == ITEMKIND_TITLE then
			MyInvenShowPopup2(bwear)
			return
			
		elseif kind == ITEMKIND_RIDE then
			MyInvenShowPopup2(bwear)
			return
			
		elseif kind == ITEMKIND_DETACH_ORB then -- ���Ƚ� ����
			if IsKoreanLanguage() then
				CheckItemVillage(index) return
			else
				  -- ���̼������� ����Ҽ� �ֽ��ϴ�.
				ShowNotifyOKMessage_Lua(PreCreateString_2336) return
			end			
			
		elseif kind == ITEMKIND_MEGA_PHONE then					ShowMegaPhoneMsgInput() return			-- �ް���
		elseif kind == ITEMKIND_CHARACTER_COSTUME_SWITCH then	adapterEvent(index) return				-- �����
		elseif kind == ITEMKIND_CAPSULE then					ShowNotifyOKMessage_Lua(PreCreateString_2336) return -- ĸ��
		elseif kind == ITEMKIND_REGIST_PROFILE_PHOTO then		ShowChangeProfileWin() return 
		elseif kind == ITEMKIND_DIRTYX_CHANGECLASS_VISION then	ShowNotifyOKMessage_Lua(PreCreateString_2336) return -- ĳ�� ���� ������	( ��Ƽ����, ����, ��Ǫ )
		elseif kind == ITEMKIND_RESET_CLASS then				
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false)
			
			if itmenumber ~= 10005005 then	
				if _promotion <= 0 then
					ShowNotifyOKMessage_Lua(PreCreateString_2523)	-- �ʱ�ȭ �� �� ����.
					return
				end
			end
			
			if CheckEnableResetClass() then
				ShowNotifyOKMessage_Lua(PreCreateString_2663, 8, 5, 53, 85)
				return
			end
			
			MyInvenShowPopup(kind, 0)
			return
			
		elseif kind ~= ITEMKIND_TRANSFORM or kind ~= ITEMKIND_CHAT_BUBBLE then -- ���� ������/��ǳ���� �ƴϸ� ����ϰڳĴ� �޼����� ����ش�.
			MyInvenShowPopup(kind, 0)
			return
		end
		
	elseif tabIndex == 3 then -- ��ȭ ������ ���x
		if kind == ITEMKIND_CHARACTER_STAT_PLUS then
			MyInvenShowPopup(kind, 0)
			return
		else
			return
		end
	end
	
	UseMyinvenItem(index, 0)

end




-- ������ ���� �̺�Ʈ
function functionEquipBtnEvent2(args)
	--DebugStr("EquipEvenet2 �� ����")
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local functionIndex = tonumber(winMgr:getWindow("MyInven_functionEquipBtn2"):getUserString("index"))
	
	local index = tonumber(winMgr:getWindow("MyInven_functionWindow"):getUserString("index"))
	winMgr:getWindow("MyInven_functionWindow"):setVisible(false)
	winMgr:getWindow("MyInven_function2Window"):setVisible(false)
	if index < 0 then
		return
	end
	local tabIndex = GetInventoryTab()	-- �κ��丮 ���� �˾ƿ´�(������ �������� ���� �ٸ� �ڽ���~)
	SetSelectedItemIndex(index)			-- ���� ���õ� �������� �����ε����� �������ش�.
	-- ������ �������ϰ��
	local kind, bwear, itemnumber = GetSelectItemKind(index)
	
	if tabIndex == 2 then		-- ��Ÿ ������
		if CheckUseItemEnable(kind) == false then
			return
		end
		if kind == ITEMKIND_CHANGE_EMBLEM then
			if IsKoreanLanguage() then
				ShowChangeAmblemWin(index)
			else
				ShowNotifyOKMessage_Lua(PreCreateString_2336)   -- ���̼������� ����Ҽ� �ֽ��ϴ�.
				return
			end
			
		elseif kind == ITEMKIND_TITLE then						MyInvenShowPopup2(bwear) return 
		elseif kind == ITEMKIND_RIDE then						MyInvenShowPopup2(bwear) return
		elseif kind == ITEMKIND_DETACH_ORB then					--ShowHotfixReleaseWindow(index) return	-- ���Ƚ� ����
			if IsKoreanLanguage() then
				CheckItemVillage(index) return
			else
				ShowNotifyOKMessage_Lua(PreCreateString_2336) return   -- ���̼������� ����Ҽ� �ֽ��ϴ�.
			end			
		elseif kind == ITEMKIND_MEGA_PHONE then					ShowMegaPhoneMsgInput() return			-- �ް���
		elseif kind == ITEMKIND_CHARACTER_COSTUME_SWITCH then	adapterEvent(index) return				-- �����
		elseif kind == ITEMKIND_CAPSULE then					ShowNotifyOKMessage_Lua(PreCreateString_2336) return	-- ĸ��
		elseif kind == ITEMKIND_REGIST_PROFILE_PHOTO then		ShowChangeProfileWin() return 
		elseif kind == ITEMKIND_DIRTYX_CHANGECLASS_VISION then	ShowNotifyOKMessage_Lua(PreCreateString_2336) return	-- ĳ�� ���� ������	( ��Ƽ����, ����, ��Ǫ )
		elseif kind == ITEMKIND_RESET_CLASS then				
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false)
			
			if itemnumber ~= 10005005 then	
				if _promotion <= 0 then
					ShowNotifyOKMessage_Lua(PreCreateString_2523)	-- �ʱ�ȭ �� �� ����.
					return
				end
			end

			if CheckEnableResetClass() then
				ShowNotifyOKMessage_Lua(PreCreateString_2663, 8, 5, 53, 85)
				return
			end
			MyInvenShowPopup(kind, 0)
			return
		elseif kind ~= ITEMKIND_TRANSFORM or kind ~= ITEMKIND_CHAT_BUBBLE then	MyInvenShowPopup(kind, functionIndex) return		-- ���� ������/��ǳ���� �ƴϸ� ����ϰڳĴ� �޼����� ����ش�.
		end
	elseif tabIndex == 3 then	-- ��ȭ ������ ���x
		if kind == ITEMKIND_CHARACTER_STAT_PLUS then
			MyInvenShowPopup(kind, functionIndex)
			return
		else
			return
		end
	end
	
	UseMyinvenItem(index, functionIndex)

end



-- ������ư
function functionClearBtnEvent(args)
	
	local index = tonumber(winMgr:getWindow("MyInven_functionWindow"):getUserString("index"))
	
	if index < 0 then
		return
	end
	
	-- ������� ������ Ŭ�� �ƹ�Ÿ���, ������ �Ұ����ϴ�. �ڡ�
	local tabIndex = GetInventoryTab()	-- �κ��丮 ���� �˾ƿ´�
	
	-- �Ϲ�/ĳ�� �ƹ�Ÿ �ǿ����� üũ ��
	if tabIndex == 0 or tabIndex == 4 then
		local IsFact = IsVisualSelectedCloneAvatar(index)
		if IsFact == 1 then
			ShowNotifyOKMessage_Lua(g_STRING_CLONE_DELETE_TO_INVENTOTY)
			return 
		end
	end
	

	winMgr:getWindow("MyInven_functionWindow"):setVisible(false)
	winMgr:getWindow("MyInven_function2Window"):setVisible(false)
	root:addChildWindow(winMgr:getWindow("MyInven_DeletePopupAlpha"))
	winMgr:getWindow("MyInven_DeletePopupAlpha"):setVisible(true)
end








-- �Է�â ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_BackImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
mywindow:setPosition(370, 200)
mywindow:setSize(296, 212)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEnterEventInfo("StorageInput_BackImage", "StorageInput_RegistBtnEvent")
RegistEscEventInfo("StorageInput_BackImage", "StorageInput_CancelBtnEvent")


-- ��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setPosition(100, 8)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_ItemImage")
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
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- Ŭ�� �ƹ�Ÿ �޹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_ItemBackImage")
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
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ������ ��罽 �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_ItemStealSealImage")
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
winMgr:getWindow("StorageInput_ItemImage"):addChildWindow(mywindow)

-- ��ų ���� �׵θ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(64, 56)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ��ų���� + ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "StorageInput_SkillLevelText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(70, 57)
mywindow:setSize(40, 20)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ���� �̺�Ʈ�� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 55)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "StorageInput_NameText")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 72)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "StorageInput_NumberText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(110, 96)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- ��ϼ��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_RegistImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setPosition(14, 142)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- ���� �Է�ĭ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StorageInput_InputImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setPosition(120, 143)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "StorageInput_Render")
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)

-- ���� �Է� ����Ʈ �ڽ�
mywindow = winMgr:createWindow("TaharezLook/Editbox", "StorageInput_CountEditBox")
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
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- ���� �Է� �¿��ư
local tCountLRButtonName  = {["err"]=0, [0]="StorageInput_LBtn", "StorageInput_RBtn"}
local tCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tCountLRButtonEvent = {["err"]=0, [0]="StorageInput_LBtnEvent", "StorageInput_RBtnEvent"}
for i=0, #tCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tCountLRButtonTexX[i], 172)
	mywindow:setPosition(tCountLRButtonPosX[i], 145)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tCountLRButtonEvent[i])
	winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)
end


-- ��� ��ư(�κ��丮��)
mywindow = winMgr:createWindow("TaharezLook/Button", "StorageInput_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "StorageInput_RegistBtnEvent")
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- ��� ��ư(â����)
mywindow = winMgr:createWindow("TaharezLook/Button", "StorageInput_RegistBtn2")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "StorageInput_RegistBtnEvent")
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)



-- ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "StorageInput_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "StorageInput_CancelBtnEvent")
winMgr:getWindow("StorageInput_BackImage"):addChildWindow(mywindow)


-- �κ����� â���� �̵�
local InputCheckCount = 0
function CountInputWindowSetting(itemName, itemCount, itemFileName, itemFileName2, type, grade, bTrade , layerFileName , nAvatarType , attach)
	
	if nAvatarType > 0 then
		ShowNotifyOKMessage_Lua(g_STRING_CLONE_MOVE_TO_STORAGE)
		return
	end
	
	InputCheckCount = itemCount
	
	-- ������ �̸�
	local Name = SummaryString(g_STRING_FONT_GULIMCHE, 12, itemName, 134)
	winMgr:getWindow("StorageInput_NameText"):setText(Name)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("StorageInput_NumberText"):setText(szcount)
	
	-- 	������ �̹���
	winMgr:getWindow("StorageInput_ItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	
	-- ��ų ���ǥ��	
	if grade > 0 then
		winMgr:getWindow("StorageInput_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("StorageInput_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("StorageInput_SkillLevelText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("StorageInput_SkillLevelText"):setText("+"..grade)
	else
		winMgr:getWindow("StorageInput_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("StorageInput_SkillLevelText"):setText("")
	end	
	
	if itemFileName2 ~= "" then
		if IsKoreanLanguage() then 
			if grade > 0 then
				if bTrade == true then
					winMgr:getWindow("StorageInput_ItemImage"):setTexture("Disabled", itemFileName2, 0, 0)
				end
			end
		end
		winMgr:getWindow("StorageInput_ItemImage"):setTexture("Layered", itemFileName2, 0, 0)
	else
		winMgr:getWindow("StorageInput_ItemImage"):setTexture("Layered", "UIData/invisible", 0, 0)
	end
	
	winMgr:getWindow("StorageInput_CountEditBox"):activate()
	winMgr:getWindow("StorageInput_CountEditBox"):setText(InputCheckCount)
	
	root:addChildWindow(winMgr:getWindow("StorageInput_BackImage"))
	
	
	if IsKoreanLanguage() then 
		if grade > 0 then
			if bTrade == true then
				winMgr:getWindow("StorageInput_ItemImage"):setTexture("Layered", layerFileName, 0, 0)
			else
				winMgr:getWindow("StorageInput_ItemStealSealImage"):setVisible(false)
			end
		end
	end
	
	winMgr:getWindow("StorageInput_BackImage"):setVisible(true)
	if type == 0 then
		winMgr:getWindow("StorageInput_RegistBtn"):setVisible(false)
		winMgr:getWindow("StorageInput_RegistBtn2"):setVisible(true)
	else
		winMgr:getWindow("StorageInput_RegistBtn"):setVisible(true)
		winMgr:getWindow("StorageInput_RegistBtn2"):setVisible(false)
	end
	
	-- Ŭ�� �ƹ�Ÿ ���� �Է�â �κ� �� ( �κ��丮 -----> â�� )
	if nAvatarType ~= -2 then
		SetAvatarIcon("StorageInput_ItemImage" , "StorageInput_ItemBackImage" , nAvatarType , attach, itemFileName)
	else
		winMgr:getWindow("StorageInput_ItemBackImage"):setVisible(false)
	end
end


function StorageInput_Render(args)
	local CountText = winMgr:getWindow("StorageInput_CountEditBox"):getText()

	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	if Count ~= nil then
		if Count > InputCheckCount then
			winMgr:getWindow("StorageInput_CountEditBox"):setText(InputCheckCount)
		elseif Count <= 0 then
			--winMgr:getWindow("StorageInput_CountEditBox"):setText(1)
		end
	end
end


function StorageInput_LBtnEvent(args)
	local CountText = winMgr:getWindow("StorageInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count - 1
	if Count < 0 then
		Count = 0
	end
	winMgr:getWindow("StorageInput_CountEditBox"):setText(Count)
end


function StorageInput_RBtnEvent(args)
	local CountText = winMgr:getWindow("StorageInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local Count = tonumber(CountText)
	Count = Count + 1
	winMgr:getWindow("StorageInput_CountEditBox"):setText(Count)
end


function StorageInput_RegistBtnEvent(args)
	local CountText = winMgr:getWindow("StorageInput_CountEditBox"):getText()
	if CountText == "" then
		CountText = "0"
	end
	local bType = winMgr:getWindow("StorageInput_RegistBtn"):isVisible()
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)	
	local Count = tonumber(CountText)
	if Count == nil then
		return
	end	
	if Count <= 0 then
		return
	end 
	if bType then		-- �κ��丮���� ����������
		--DebugStr("�κ��丮���� ������")
		local slotIndex = GetInvenSlotIndex()
		local tab = GetInventoryTab()
		MovetoInven(Count, 1, slotIndex, tab)	
	else				-- �����Կ��� �κ��丮��
		--DebugStr("�����Կ��� �κ��丮")
		local slotIndex = GetStorageSlotIndex()
		local tab = GetStorageTab()
		MovetoStorage(Count, 0, slotIndex, tab)
	end
	
end



function StorageInput_CancelBtnEvent(args)
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)	
end

function ChangeInvenTabEvent(tabIndex)
	local changeWindow = winMgr:getWindow(tMyInvenListName[tabIndex])
	if CEGUI.toRadioButton(changeWindow):isSelected() then
		return	
	end
	changeWindow:setProperty("Selected", "true")
end

		

--------------------------------------------------------------------
-- �κ��丮���� �������� ���� �˾�â
--------------------------------------------------------------------
--------------------------------------------------------------------
-- ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MyInven_PopupAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("MyInven_PopupAlpha", "MyInvenPopupEscEvent")
RegistEnterEventInfo("MyInven_PopupAlpha", "MyInvenPopupEnterEvent")


--------------------------------------------------------------------
-- ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MyInven_PopupImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MyInven_PopupAlpha'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_PopupText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:clearTextExtends();
mywindow:addTextExtends(PreCreateString_2147, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
winMgr:getWindow('MyInven_PopupImage'):addChildWindow(mywindow);
		

--------------------------------------------------------------------
-- ��ư (Ȯ��, ���)
--------------------------------------------------------------------
local ButtonName	= {['protecterr']=0, "MyInven_PopupOKButton", "MyInven_PopupCancelButton"}
local ButtonTexX	= {['protecterr']=0,			693,					858}
local ButtonPosX	= {['protecterr']=0,			4,						169}		
local ButtonEvent	= {['protecterr']=0, "MyInvenPopupEnterEvent", "MyInvenPopupEscEvent"}

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setPosition(ButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("index", 0)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('MyInven_PopupImage'):addChildWindow(mywindow)
end


-- �κ��丮 �˾�â�� cancel �̺�Ʈ
function MyInvenPopupEscEvent()
	winMgr:getWindow('MyInven_PopupAlpha'):setVisible(false)

end



-- �κ��丮 �˾�â�� enter �̺�Ʈ
function MyInvenPopupEnterEvent()	
	local slotIndex = GetSelectedItemIndex()
	local Kind, bwear, itemnumber = GetSelectItemKind(slotIndex)
	winMgr:getWindow('MyInven_PopupAlpha'):setVisible(false)
	local functionIndex = tonumber(winMgr:getWindow('MyInven_PopupOKButton'):getUserString("index"))
	
	if Kind == ITEMKIND_CHANGE_CHARACTER_NAME then
		root:addChildWindow(winMgr:getWindow('MyInven_ChangeNameAlpha'))
		winMgr:getWindow('MyInven_ChangeNameAlpha'):setVisible(true)
	end
	UseMyinvenItem(slotIndex, functionIndex)
	--DebugStr("UseMyinvenItem SlotIndex : " .. slotIndex .. " functionIndex : " .. functionIndex)
end


-- �κ��丮���� ���Ǵ� �˾�â�� ����ش�.
function MyInvenShowPopup(kind, functionIndex)		
	if kind == -1 then
		return
	end
	winMgr:getWindow('MyInven_PopupOKButton'):setUserString("index", functionIndex)
	
	root:addChildWindow(winMgr:getWindow('MyInven_PopupAlpha'))
	winMgr:getWindow('MyInven_PopupAlpha'):setVisible(true)
	
	--mywindow:setSize(340, 268);
	local x,y = GetWindowSize();
	x = (x/2) - (340/2)
	y = (y/2) - (268/2)
	winMgr:getWindow('MyInven_PopupImage'):setPosition(x,y)
	
	local string = ""
	local slotIndex = GetSelectedItemIndex()
	if kind == ITEMKIND_RESET_PLAY_RECORD then
		string = PreCreateString_2153
	elseif kind == ITEMKIND_ITEM_GENERATE then
		if GetItemGenerateState(slotIndex) then			
			string = PreCreateString_2142				
		else			
			string = PreCreateString_2147				
		end
	elseif kind == ITEMKIND_CHANGE_CHARACTER_COLOR then
		string = PreCreateString_2689	-- �ɸ��� ��Ų�� �����Ͻðڽ��ϱ�?
	elseif kind == ITEMKIND_RESET_CLASS then
		string = PreCreateString_2521	
	elseif kind == ITEMKIND_LEVEL_JUMPING then
		string = PreCreateString_4820	-- ���� 55 ������ ����Ͻðڽ��ϱ�?
	else
		string = PreCreateString_2147	-- �������� ����Ͻðڽ��ϱ�?		
	end		
	
	winMgr:getWindow("MyInven_PopupText"):clearTextExtends()	
	winMgr:getWindow('MyInven_PopupText'):addTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
end


function MyInvenShowPopup2(wear)
	winMgr:getWindow('MyInven_PopupOKButton'):setUserString("index", functionIndex)
	
	root:addChildWindow(winMgr:getWindow('MyInven_PopupAlpha'))
	winMgr:getWindow('MyInven_PopupAlpha'):setVisible(true)
	
	if wear then
		string = PreCreateString_1227	-- �������� ����Ͻðڽ��ϱ�?		
	else
		string = PreCreateString_2147	-- �������� ����Ͻðڽ��ϱ�?		
	end	
	
	winMgr:getWindow('MyInven_PopupText'):clearTextExtends();
	winMgr:getWindow('MyInven_PopupText'):addTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
end

function MyInven_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- �θ� ������
	local index = tonumber(mywindow:getUserString('Index'))
	local x, y = GetBasicRootPoint(local_window)
	y = y - 80
	if x + 245 > g_CURRENT_WIN_SIZEX then
		x = x - 245
	end
	if y + 175 > g_CURRENT_WIN_SIZEY then
		y = y - 175
	end
	local itemKind, itemNumber, attributeType = GetMyInventoryTooltipInfo(index)	
	ShowRandomOpenItem(itemNumber, x, y)
end



function MyInven_MouseLButtonDown(args)
	DebugStr("LButtonDown")
	HideRandomOpenItem();
	Common_ToolTipHide();
	HideAnimationWindow();
--[[	local local_window = CEGUI.toWindowEventArgs(args).window;

	local mywindow	= local_window:getParent()		-- �θ� ������
	local index = tonumber(mywindow:getUserString('Index'))
	
	SetShowToolTip(false)
	
	posIndex, slotIndex, itemNumber, fileName, fileName2, itemcount, state, grade, bSeal , nCloneAvatarType , bTrade , attach, bIsRental = GetItemInfo( index )

	DebugStr("itemNumber  :  " .. itemNumber)
	DebugStr("fileName  :  " .. fileName)
	DebugStr("fileName2  :  " .. fileName2)
	DebugStr("itemcount  :  " .. itemcount)
	DebugStr("state  :  " .. state)
	DebugStr("bTrade  :  " .. bTrade)
	DebugStr("nCloneAvatarType  :  " .. nCloneAvatarType)
	]]--
	
end


function MyInven_MouseLButtonUp(args)
end


-- �κ��丮 ������ ����Ŭ�� �̺�Ʈ ��
function MyInven_ItemdoubleClick(args)
	DebugStr("������ ����Ŭ��! : MyInven_ItemdoubleClick")
	HideRandomOpenItem()
	if (bUseItem == false) then
		return
	end
	
	-- ������ ���
	local ClickWindow	 = CEGUI.toWindowEventArgs(args).window
	local index		 	 = tonumber(ClickWindow:getUserString("Index"))
	
	local testitemKind, testitemNumber, testattributeType = GetMyInventoryTooltipInfo(index)
	local kind, bwear, itemnumber	 = GetSelectItemKind(index)
	local CloneType		 = IsVisualAvatar(testitemNumber , index) -- Ŭ�� �ƹ�Ÿ�ΰ� üũ
	local CurrentWndType = GetCurrentWndType()
	
	
	-- ���� �κ�, ���� �� , �����̵� �κ񿡼��� ������ ��� �Ұ�
	if CurrentWndType == 1 or CurrentWndType == 2 or CurrentWndType == 14 then
		if CloneType == -1 then
			return
		end
	end
	
	-- ��ȭ/�и�/�ѹ� ������ �������
	if CurrentWndType == 1 or CurrentWndType == 2 or CurrentWndType == 14 then
		if kind == 74 or kind == 75 or kind == 76 then
			return 
		end
	end
	
	-- ����� �ƹ�Ÿ ��Ŭ�� ���� ����
	if CloneType == -3 then
		return
	end
	
	if winMgr:getWindow("MyStorage_BackImage") then
		local bStorageMode = winMgr:getWindow("MyStorage_BackImage"):isVisible()		
		if bStorageMode then
			if kind == ITEMKIND_TRANSFORM or kind == ITEMKIND_CHAT_BUBBLE then
				ShowNotifyOKMessage_Lua(PreCreateString_2049)
				return
			end
			SettingInputCountWindow(index)
			return	
		end
	end	
	
	local tabIndex = GetInventoryTab()	-- �κ��丮 ���� �˾ƿ´�(������ �������� ���� �ٸ� �ڽ���~)
	SetSelectedItemIndex(index)			-- ���� ���õ� �������� �����ε����� ����(����)���ش�.
	
	--********************************
	-- ������ �������ϰ��
	--********************************
	if tabIndex == 2 then
		DebugStr("������ ī�ε� : " .. kind)		
		
		if CheckUseItemEnable(kind) == false then
			DebugStr("CheckUseItemEnable")
			return
		end
		
		if kind == ITEMKIND_CHANGE_EMBLEM then	-- ������ ��ü ������ 				
			if IsKoreanLanguage() then
				ShowChangeAmblemWin(index)
			else
				ShowNotifyOKMessage_Lua(PreCreateString_2336) 
				DebugStr("CheckUseItemEnable")
				return
			end
			
		elseif kind == ITEMKIND_LEVEL_JUMPING then -- ���� ����		
			DebugStr("������ �ѹ� : " ..itemnumber)
			if itemnumber == 10009095 then		-- 1~54 ���� ���� ������				
				if LevelJumpingOK() then					
					MyInvenShowPopup(kind, 0)	
				else					
					local STRING_PREPARING = PreCreateString_4821	--GetSStringInfo(LAN_JUMPING_POPUP_02)	
					ShowNotifyOKMessage_Lua(STRING_PREPARING)
				end							
			elseif itemnumber == 10009097 then		-- 30~54 ���� ���� ������(1-29 �� 1, 30-54�� 2, 55�̻��� 3)		
				local levelCheck = LevelJumpingOK2()
				if levelCheck == 1 then						
					local STRING_PREPARING = PreCreateString_4822	--GetSStringInfo(LAN_JUMPING_POPUP_03)	
					ShowNotifyOKMessage_Lua(STRING_PREPARING)						
				elseif levelCheck == 2 then											
					MyInvenShowPopup(kind, 0)					
				else					
					local STRING_PREPARING = PreCreateString_4821	--GetSStringInfo(LAN_JUMPING_POPUP_02)	
					ShowNotifyOKMessage_Lua(STRING_PREPARING)		
				
				end
			end
			
			return			
			
		elseif kind == ITEMKIND_TITLE then
			MyInvenShowPopup2(bwear) 
			return 
		elseif kind == ITEMKIND_RIDE then
			MyInvenShowPopup2(bwear)
			return
		elseif kind == ITEMKIND_DETACH_ORB then
			if IsKoreanLanguage() then
				CheckItemVillage(index) return
			else
				ShowNotifyOKMessage_Lua(PreCreateString_2336) return
			end
		
		elseif kind == ITEMKIND_MEGA_PHONE then -- �ް���
			ShowMegaPhoneMsgInput()
			return
		
		elseif kind == ITEMKIND_CHARACTER_COSTUME_SWITCH then -- �����
			adapterEvent(index)
			return
		
		elseif kind == ITEMKIND_CAPSULE then -- ĸ��
			ShowNotifyOKMessage_Lua(PreCreateString_2336)
			return
		
		elseif kind == ITEMKIND_REGIST_PROFILE_PHOTO then		
			ShowChangeProfileWin() 
			return 
		
		elseif kind == ITEMKIND_DIRTYX_CHANGECLASS_VISION then -- ĳ�� ���� ������	( ��Ƽ����, ����, ��Ǫ )
			ShowNotifyOKMessage_Lua(PreCreateString_2336)  -- ���̼������� ����Ҽ� �ֽ��ϴ�.
			return
		
		elseif kind == ITEMKIND_RESET_CLASS then
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false)
			
			if itemnumber ~= 10005005 then	
				if _promotion <= 0 then
					ShowNotifyOKMessage_Lua(PreCreateString_2523) -- �ʱ�ȭ �� �� ����.
					return
				end
			end
			
			if CheckEnableResetClass() then
				ShowNotifyOKMessage_Lua(PreCreateString_2663, 8, 5, 53, 85)
				return
			end
			
			MyInvenShowPopup(kind, 0)
			return
			
		elseif kind ~= ITEMKIND_TRANSFORM or kind ~= ITEMKIND_CHAT_BUBBLE then -- ���� ������/��ǳ���� �ƴϸ� ����ϰڳĴ� �޼����� ����ش�.
			MyInvenShowPopup(kind, 0) 
			return
		
		elseif kind == ITEMKIND_AVATAR_CLEANUP then -- �ڽ�Ƭ �ƹ�Ÿ "Ŭ����" ������ ���
			ShowNotifyOKMessage_Lua(PreCreateString_2336)  -- ���̼������� ����Ҽ� �ֽ��ϴ�.
			return
		end
	
	
	--********************************
	-- ��ȭ ������ ���x
	--********************************
	elseif tabIndex == 3 then
		if kind == ITEMKIND_CHARACTER_STAT_PLUS then
			MyInvenShowPopup(kind, 0)
			return
		else
			return
		end
	end
		
	UseMyinvenItem(index, 0) -- ù��° ������ "�ε���"�� �ǹ̰� ���� ������ ���� ������ �Ѵ�.
	--DebugStr("usemtinvenitem")
end





-- �κ��丮 ������ ���콺 ������ Ŭ��
function MyInven_MouseRButtonUp(args)
	local ClickWindow	= CEGUI.toWindowEventArgs(args).window
	local index			= tonumber(ClickWindow:getUserString("Index"))
	if index < 0 then
		return
	end
	
	--SaveSelectedItemInfo(index);
	
	local itemKind, itemNumber, attributeType = GetMyInventoryTooltipInfo(index)
	local VisualType	 = IsVisualAvatar(itemNumber, index)
	local PollutionType	 = IsPollutionAvatar(itemNumber, index)
	local CurrentWndType = GetCurrentWndType()
	DebugStr("ITemNUM : " .. itemNumber)
	-- ����� �ƹ�Ÿ�� ������ ���ͼ� �ȵȴ�.. ���ƹ�����
	if IsKoreanLanguage() == false then
		if VisualType == -3 then
			return
		end
		
		-- �������� ������ Ŭ�� �ƹ�Ÿ ���������� �ݴ´�
		if CurrentWndType == 12 then
			if winMgr:getWindow("MyStorage_BackImage"):isVisible() == true then
				return
			end
		end
	end
	
	
	winMgr:getWindow("MyInven_functionWindow"):setUserString("index", tostring(index))
	
	local x, y = GetBasicRootPoint(ClickWindow)
	root:addChildWindow(winMgr:getWindow("MyInven_functionWindow"))
	
	winMgr:getWindow("MyInven_functionWindow"):setVisible(true)	
	winMgr:getWindow("MyInven_functionWindow"):setPosition(x + 20,y + 20)
	
	if IsTestPassport() then
		--root:addChildWindow(winMgr:getWindow("MyInven_function2Window"))
		winMgr:getWindow("MyInven_function2Window"):setVisible(true)	
		winMgr:getWindow("MyInven_function2Window"):setPosition(x + 100,y + 20)
	end
end

-- ������� ���ϴ� �������� ��󳽴�.
function CheckUnableItem(kind)
	local Check = false
	
	if kind == ITEMKIND_RIGHT_REVIVE or
	   kind == ITEMKIND_LIFE or
	   kind == ITEMKIND_SLOT_CHANGER or
	   kind == ITEMKIND_ACADE_TICKET or
	   kind == ITEMKIND_HOTPICKS or
	   kind == ITEMKIND_SKILL_STRENGTHEN or
	   kind == ITEMKIND_SUPER_OWNER or
	   kind == ITEMKIND_PREMIUM_ACADE_TICKET or
	   kind == ITEMKIND_ENEMY_SP_VIEW or
	   kind == ITEMKIND_ENEMY_ITEM_VIEW or
	   kind == ITEMKIND_CHANGE_CHARACTER_NAME_COLOR or
	   kind == ITEMKIND_GAMERESULT_BUFF or
	   kind == ITEMKIND_GAMEPLAY_BUFF or
	   kind == ITEMKIND_EXTEND_BATTLE_TIME or
	   kind == ITEMKIND_SPECIAL_MYSHOP or
	   kind == ITEMKIND_DIG_TOOL or
	   kind == ITEMKIND_SLOT_MACHINE_CHIP or
	   kind == ITEMKIND_COSTUME_MIXING_CUBE or 
	   kind == ITEMKIND_ODDMENTS or
	   kind == ITEMKIND_FIRECRACKER or
	   kind == ITEMKIND_POTION then
	   Check = true
	end   
	return Check
end


-- �����ۿ� ���콺�� ���ö�,
function MyInven_ItemMouseEnter(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	

	if index == -1 then
		return
	end

	LOG("index:"..index)
	
	local itemKind, itemNumber, attributeType	= GetMyInventoryTooltipInfo(index)
	itemKind, itemNumber						= SettingSpecialItemToolTip(itemKind, itemNumber) -- ITEMKIND_COSTUME_RANDOM_BOX ����
	
	local Kind = -1

	LOG("itemKind:"..itemKind)
	LOG("itemNumber:"..itemNumber)
	LOG("attributeType:"..attributeType)
	LOG("itemKind:"..itemKind)



	

	
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	
	if x + 236 + 52 > g_CURRENT_WIN_SIZEX then
		x = x - 295
	end
	
	GetToolTipBaseInfo(x + 52, y, 2, Kind, index, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
	--GetWearedToolTipBaseInfo()
	--SetShowToolTip(true)
	
	-- ���忡���� �����ϰ� ����
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then
		return
	end
	
	if Kind ~= KIND_SKILL then
		return
	end
		
	ReadAnimation(itemNumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(MyInvenWindow)
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


-- �����ۿ��� ���콺�� ������.
function MyInven_ItemMouseLeave(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
end


-- �κ��丮�� ���� ���õ����� ������ �̺�Ʈ
function MyInventorySelectTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		
		SetInventoryTab(tabindex)	-- �κ��丮 �� ����
		local CurrentMaxPage = GetCurrentMaxPage(tabindex)
		SettingMaxPageButton(CurrentMaxPage)
		
		if CEGUI.toRadioButton(winMgr:getWindow("MyInven_Bag1")):isSelected() then
			RefreshUiView(1)
		else
			winMgr:getWindow("MyInven_Bag1"):setProperty("Selected", "true")
		end			
	end
	HideRandomOpenItem();
end


-- ���� �ǿ� ���� ������ �ִ� �������� ���� ��ư ����
function SettingMaxPageByTab(tabIndex)
	for i=0, #tMyInvenBagName do
		if i < tabIndex then
			winMgr:getWindow(tMyInvenBagName[i]):setVisible(true)
		else
			winMgr:getWindow(tMyInvenBagName[i]):setVisible(false)
		end		
	end
end





-- �κ��丮�� ����ش�(�ʱ�ȭ)
function ClearMyInventory()
	for i=0, MAX_INVEN_ITEM_X_COUNT-1 do
		for j=0, MAX_INVEN_ITEM_Y_COUNT-1 do
			local Index = i*(MAX_INVEN_ITEM_X_COUNT+1)+j
			winMgr:getWindow("MyInven_ItemList_Image_Seal_"..Index):setVisible(false)
			winMgr:getWindow("MyInven_ItemList_Image_"..Index):setLayered(false)			
			winMgr:getWindow("MyInven_ItemList_Image_"..Index):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyInven_ItemList_Image_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyInven_ItemList_Image_"..Index):setTexture("Layered", "UIData/invisible.tga", 0, 0)
			-- ��ų ���� �̹��� 
			winMgr:getWindow("MyInven_ItemList_SkillLevelImage_"..Index):setVisible(false)
			winMgr:getWindow("MyInven_ItemList_SkillLevelImage_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyInven_ItemList_SkillLevelText_"..Index):setText("")
			
			winMgr:getWindow("MyInven_ItemList_Button_"..Index):setUserString("Index", tostring(-1))
			winMgr:getWindow("MyInven_ItemList_Count_"..Index):clearTextExtends()

			winMgr:getWindow("MyInven_ItemList_Warning_"..Index):setVisible(false)
			winMgr:getWindow("MyInven_ItemList_Warning_"..Index):setTexture("Disabled", "UIData/Match002.tga", 667, 646)
			
			winMgr:getWindow("MyInven_ItemList_Avatar_Icon_Type"..Index):setVisible(false)
			winMgr:getWindow("MyInven_ItemList_Avatar_Icon_Type2"..Index):setVisible(false)
			
			winMgr:getWindow("MyInven_DetailIInfoBtn_"..Index):setVisible(false)
			
			winMgr:getWindow("MyInven_ItemList_Rental_Skill_"..Index):setVisible(false)
			
			
		end
	end
end



-- �Ϲ�, ����, ������, ���� ������
local tStatefile = {['err'] = 0, [0]="invisible.tga", "Match002.tga", "Match002.tga", "Match002.tga", "Match002.tga"}
local tStateY = {['err'] = 0,	[0]= 0,					646,			646,		790,				838}


-- �κ��丮�� ä���ش�.
function SettingMyInventory(posIndex, slotIndex, itemNumber, fileName, fileName2, itemcount, state, grade, bSeal , nCloneAvatarType , bTrade , attach, bIsRental, bSkill)
	
	-- ������ ������ ����.
	winMgr:getWindow("MyInven_ItemList_Image_"..posIndex):setTexture("Enabled", "UIData/"..fileName, 0, 0)
	winMgr:getWindow("MyInven_ItemList_Image_"..posIndex):setTexture("Disabled", "UIData/"..fileName, 0, 0)
	
	-- ��ȭ ����
	if grade > 0 then
		winMgr:getWindow("MyInven_ItemList_SkillLevelImage_"..posIndex):setVisible(true)
		winMgr:getWindow("MyInven_ItemList_SkillLevelImage_"..posIndex):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("MyInven_ItemList_SkillLevelText_"..posIndex):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("MyInven_ItemList_SkillLevelText_"..posIndex):setText("+"..grade)
	end	
		
	-- 
	if fileName2 == "" then
		winMgr:getWindow("MyInven_ItemList_Image_"..posIndex):setLayered(false)
	else
		winMgr:getWindow("MyInven_ItemList_Image_"..posIndex):setLayered(true)
		winMgr:getWindow("MyInven_ItemList_Image_"..posIndex):setTexture("Layered", "UIData/"..fileName2, 0, 0)		
	end	
	
	-- ��� �̹��� ( �ڹ��� )
	winMgr:getWindow("MyInven_ItemList_Image_Seal_"..posIndex):setVisible(bSeal)
	
	--
	winMgr:getWindow("MyInven_ItemList_Button_"..posIndex):setUserString("Index", tostring(slotIndex))
	winMgr:getWindow("MyInven_ItemList_Count_"..posIndex):clearTextExtends()
	winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setVisible(true)
	winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[state], 667, tStateY[state])
	
	
	-------------------------------------------------------------
	-- ��ų ��ȭ 1�̻� , �ŷ������� ������ ������ ���ǥ�á�
	-------------------------------------------------------------
	--if IsGLanguage() then 
		if bSkill then
			if grade >= GetSealedSkillGrade() then
				if bTrade == true then
					DebugStr("�ŷ������� ������ ������ ���ǥ��")
					winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setVisible(true)
					winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[3], 667, tStateY[3])
				end
			end
		end
	--end
		
	
	-- ������ ����
	if itemcount > 1 then
		winMgr:getWindow("MyInven_ItemList_Count_"..posIndex):addTextExtends("x "..itemcount, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,    0, 0,0,0,255)
	end


	-- �ڼ��� ���� ��ư
	if CheckDetailInfoBtn(itemNumber) then
		winMgr:getWindow("MyInven_DetailIInfoBtn_"..posIndex):setVisible(true)
	else
		winMgr:getWindow("MyInven_DetailIInfoBtn_"..posIndex):setVisible(false)
	end	
	
	
	-- ��Ż��ų
	if CheckfacilityData(FACILITYCODE_RENTALSKILL) == 1 then
		if bIsRental == true then
			winMgr:getWindow("MyInven_ItemList_Rental_Skill_"..posIndex):setVisible(true)
			winMgr:getWindow("MyInven_ItemList_Rental_Skill_"..posIndex):setTexture("Disabled", "UIData/ItemUIData/Insert/Time.tga", 0,0)
		end	
	end
	

	-- Ŭ�� ������ ������ ���� �Լ�
	SetAvatarIconS(	"MyInven_ItemList_Image_" , "MyInven_ItemList_Avatar_Icon_Type2" , "MyInven_ItemList_Avatar_Icon_Type" , 
					posIndex , nCloneAvatarType , attach )

end	-- end of function


function SettingMaxPageButton(MaxPage)
	for i=0, #tMyInvenBagName do
		if i < MaxPage then
			winMgr:getWindow(tMyInvenBagName[i]):setEnabled(true)
		else
			winMgr:getWindow(tMyInvenBagName[i]):setEnabled(false)
		end		
	end
end

function SettingInvenMaxPageRefresh()
	local TabIndex = GetInventoryTab()
	local CurrentMaxPage = GetCurrentMaxPage(TabIndex)
	SettingMaxPageButton(CurrentMaxPage)
end


-- �κ��丮�� �����ش�
function ShowMyInventory(bStorageMode, bEquipAble)
	
	-- ������ �ƴϸ� ���̼� ���� ��ư ��Ȱ��ȭ
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then
		winMgr:getWindow("MyInven_MyshopButton"):setEnabled(false)
	end	
	
	
	SetInventoryTab(0)
	SettingMaxPageButton(GetCurrentMaxPage(0))
	
	if CEGUI.toRadioButton(winMgr:getWindow("MyInven_costume")):isSelected() then
		if CEGUI.toRadioButton(winMgr:getWindow("MyInven_Bag1")):isSelected() then
			RefreshUiView(1)
		else
			winMgr:getWindow("MyInven_Bag1"):setProperty("Selected", "true")
		end		
	else
		winMgr:getWindow("MyInven_costume"):setProperty("Selected", "true")
	end

	SetIsvisibleInven(true)
	
	local gran = GetInvenMyMoney()
	local coin = GetInvenMyCoin()
	local cash = GetInvenMyCash()
	local r,g,b = GetGranColor(gran)
	winMgr:getWindow("MyInven_GranText"):setTextExtends(CommatoMoneyStr64(gran), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
	r,g,b = ColorToMoney(coin)
	winMgr:getWindow("MyInven_CoinText"):setTextExtends(CommatoMoneyStr(coin), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
	r,g,b = ColorToMoney(cash)
	winMgr:getWindow("MyInven_CashText"):setTextExtends(CommatoMoneyStr(cash), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
	
	SettingStorageMode(bStorageMode)
	bUseItem = bEquipAble
	winMgr:getWindow("MyInven_functionEquipBtn"):setEnabled(bEquipAble)
end



function SettingStorageMode(bStorageMode)
	if bStorageMode then
		DebugStr("bStorageMode : TRUE");
		root:addChildWindow(winMgr:getWindow("MyInven_VirtualBackImage"))
		winMgr:getWindow("MyInven_VirtualBackImage"):addChildWindow(winMgr:getWindow("MyInven_BackImage"))
		winMgr:getWindow("MyInven_VirtualBackImage"):setVisible(true)
		winMgr:getWindow("MyInven_BackImage"):setVisible(true)		
		winMgr:getWindow("MyInven_VirtualBackImage"):setPosition(1024 - 330, (g_MAIN_WIN_SIZEY-500)/2)
		winMgr:getWindow("MyInven_BackImage"):setPosition(1,1)
		winMgr:getWindow("MyInven_titlebar"):setEnabled(false)
		winMgr:getWindow("MyInven_CloseButton"):setVisible(false)
	else
		DebugStr("bStorageMode : FALSE");
		root:addChildWindow(winMgr:getWindow("MyInven_BackImage"))
		winMgr:getWindow("MyInven_BackImage"):setVisible(true)
		local PrevPosX = winMgr:getWindow("MyInven_BackImage"):getPosition().x.offset
		local PrevPosY = winMgr:getWindow("MyInven_BackImage"):getPosition().y.offset
		DebugStr("bStorageMode : FALSE X : " .. PrevPosX);
		if PrevPosX == 1 then
			if  PrevPosY == 1  then 
				winMgr:getWindow("MyInven_BackImage"):setPosition((g_MAIN_WIN_SIZEX - 310)/2, (g_MAIN_WIN_SIZEY-500)/2)
			end
		end
				
		--winMgr:getWindow("MyInven_BackImage"):setPosition((g_MAIN_WIN_SIZEX - 310)/2, (g_MAIN_WIN_SIZEY-500)/2)
		winMgr:getWindow("MyInven_titlebar"):setEnabled(true)
		winMgr:getWindow("MyInven_CloseButton"):setVisible(true)
	end
end


function SetInvenMyMoney(money)
	local r,g,b = ColorToMoney(money)
	winMgr:getWindow("MyInven_GranText"):setTextExtends(CommatoMoneyStr(money), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
end

function SetInvenMycoin(coin)
	local r,g,b = ColorToMoney(coin)
	winMgr:getWindow("MyInven_CoinText"):setTextExtends(CommatoMoneyStr(coin), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
end

function SetInvenMycash(cash)
	local r,g,b = ColorToMoney(cash)
	winMgr:getWindow("MyInven_CashText"):setTextExtends(CommatoMoneyStr(cash), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)
end


-- �κ��丮�� �����.
function HideMyInventory()
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	winMgr:getWindow("MyInven_VirtualBackImage"):setVisible(false)
	HidefunctionWindow()
	SetIsvisibleInven(false)
	SetShowToolTip(false)
	HideAnimationWindow()
	HideRandomOpenItem()
end


------------------------------------------------
-- �̸��ٲٱ⿡ ���� �����̹���
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ChangeNameAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("MyInven_ChangeNameAlpha", "MyInven_ChangeNameCancelEvent")
RegistEnterEventInfo("MyInven_ChangeNameAlpha", "MyInven_ChangeNameOkEvent")

------------------------------------------------
---�̸��ٲٱ⿡ ���� �����̹���
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ChangeNameWindow")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 338) / 2, (g_MAIN_WIN_SIZEY - 270) / 2);
mywindow:setSize(338, 270)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MyInven_ChangeNameAlpha'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_NoticeStaticText")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setText(PreCreateString_1657)
mywindow:setSize(220, 20)
mywindow:setPosition(100, 100)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyInven_ChangeNameWindow'):addChildWindow(mywindow)


------------------------------------------------
---�̸��ٲٱ⿡ ���� EDITBOX
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MyInven_ChangeNameEditBox")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setText("")
mywindow:setSize(200, 25)
mywindow:setPosition(70, 150)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
winMgr:getWindow('MyInven_ChangeNameWindow'):addChildWindow(mywindow)


------------------------------------------------
-- �̸��ٲٱ� Ȯ��, ��ҹ�ư
------------------------------------------------
local OkCancel_BtnName  = {["err"]=0, "MyInven_ChangeNameOkBtn", "MyInven_ChangeNameCancelBtn"}
local OkCancel_BtnTexX  = {["err"]=0,		693,	858}
local OkCancel_BtnPosX  = {["err"]=0,		4,		169}
local OkCancel_BtnEvent = {["err"]=0, "MyInven_ChangeNameOkEvent", "MyInven_ChangeNameCancelEvent"}


for i=1, #OkCancel_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", OkCancel_BtnName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", OkCancel_BtnTexX[i], 849);
	mywindow:setTexture("Hover", "UIData/popup001.tga", OkCancel_BtnTexX[i], 878);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", OkCancel_BtnTexX[i], 907);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", OkCancel_BtnTexX[i], 936);
	mywindow:setSize(166, 29);
	mywindow:setPosition(OkCancel_BtnPosX[i], 235);	
	mywindow:subscribeEvent("Clicked", OkCancel_BtnEvent[i])
	winMgr:getWindow('MyInven_ChangeNameWindow'):addChildWindow(mywindow)
	
end


------------------------------------------------
-- �̸��ٲٱ� Ȯ�ι�ư Ŭ��
------------------------------------------------
function MyInven_ChangeNameOkEvent(args)
	winMgr:getWindow('MyInven_ChangeNameAlpha'):setVisible(false)
	local ChageName = winMgr:getWindow('MyInven_ChangeNameEditBox'):getText()
	local slotIndex = GetSelectedItemIndex()
	MyInvenChageNickName(ChageName, slotIndex)

end


------------------------------------------------
---�̸��ٲٱ⿡ ��ҹ�ư Ŭ��
------------------------------------------------
function MyInven_ChangeNameCancelEvent(args)
	winMgr:getWindow('MyInven_ChangeNameAlpha'):setVisible(false)

end



local bMoneyRender = false
local bTwin		   = false
local Money		   = 0;
local MoneyCount   = 0;
local twinIndex	   = -1;


--------------------------------------------------------------------
-- �ڽ�Ƭ �����ڽ� �����˾� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


--------------------------------------------------------------------
-- Esc, EnterŰ ������
--------------------------------------------------------------------
RegistEscEventInfo("MyInven_CostumeRandomAlpha", "MyInven_CMRewardOKButtonEvent")
RegistEnterEventInfo("MyInven_CostumeRandomAlpha", "MyInven_CMRewardOKButtonEvent")


--------------------------------------------------------------------
-- �ڽ�Ƭ �����ڽ� �����˾�(��Ʈ�ѷ��� �־��ֱ� ���ؼ� ����â�� ���ϵ�� ��� ���ߴ�.)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX / 2 - 340 / 2), (g_MAIN_WIN_SIZEY / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("MotionEventEnd", "CostumeRandomMotionEventEnd");	-- ��Ʈ�ѷ� ����� �Ϸ������ ������ �Լ�
mywindow:setAlign(8);
mywindow:addController("MyInven_RandomController", "MyInven_CostumeController", "xscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10)
mywindow:addController("MyInven_RandomController", "MyInven_CostumeController", "yscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10)
mywindow:addController("MyInven_RandomController", "MyInven_CostumeController", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomImage2_Top")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(340, 40)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyInven_CostumeRandomImage"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomImage2_Middle")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 349, 40)
mywindow:setPosition(0, 40)
mywindow:setSize(340, 196)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyInven_CostumeRandomImage"):addChildWindow(mywindow)




mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomImage2")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyInven_CostumeRandomImage"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_CostumeRandomImage2_Bottom")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 235)
mywindow:setPosition(0, 236)
mywindow:setSize(340, 33)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyInven_CostumeRandomImage"):addChildWindow(mywindow)


function CheckTwin()
	if bTwin then
		winMgr:getWindow("MyInven_CostumeRandomImage"):setSize(340, 405)	-- Ʈ��
		winMgr:getWindow("MyInven_CostumeRandomImage2_Middle"):setSize(340, 325)
		winMgr:getWindow("MyInven_CostumeRandomImage2_Bottom"):setPosition(0, 236+129)
		--winMgr:getWindow("MyInven_RewardOkButton"):setPosition(4, 235+129)
		winMgr:getWindow("MyInven_RewardText2"):setPosition(0, 320)		-- ��ġ ����
		
	else
		--mywindow:setSize(340, 268)
		local x,y = GetWindowSize()
		x = (x/2)-(340/2)
		y = (y/2)-200
		winMgr:getWindow("MyInven_CostumeRandomImage"):setPosition(x,y)
		winMgr:getWindow("MyInven_CostumeRandomImage"):setSize(340, 268)	
		winMgr:getWindow("MyInven_CostumeRandomImage2_Middle"):setSize(340, 196)
		winMgr:getWindow("MyInven_CostumeRandomImage2_Bottom"):setPosition(0, 236)
		--winMgr:getWindow("MyInven_RewardOkButton"):setPosition(4, 235)
		winMgr:getWindow("MyInven_RewardText2"):setPosition(0, 200)
		
	end
end

function CostumeRandomMotionEventEnd(args)
	winMgr:getWindow("MyInven_RewardText1"):setVisible(true)
	winMgr:getWindow("MyInven_RewardText2"):setVisible(true)
	if bTwin then
		winMgr:getWindow("MyInven_RewardText3_"..1):setVisible(true)
		winMgr:getWindow("MyInven_RewardText4_"..1):setVisible(true)
		winMgr:getWindow("MyInven_RewardCount_"..1):setVisible(true)
		winMgr:getWindow("MyInven_ItemGradeText_"..1):setVisible(true)
	end
	winMgr:getWindow("MyInven_RewardText3_"..0):setVisible(true)
	winMgr:getWindow("MyInven_RewardText4_"..0):setVisible(true)
	winMgr:getWindow("MyInven_RewardCount_"..0):setVisible(true)
	winMgr:getWindow("MyInven_ItemGradeText_"..0):setVisible(true)
	bMoneyRender = true
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_RewardText1")
mywindow:setPosition(0, 50)
mywindow:setSize(340, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setTextExtends(PreCreateString_1042, g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyInven_CostumeRandomImage2"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_RewardText2")
mywindow:setPosition(0, 200)
mywindow:setSize(340, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setTextExtends(PreCreateString_2334.."\n", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
mywindow:addTextExtends(PreCreateString_2641, g_STRING_FONT_DODUMCHE, 12, 255, 169, 83,255,   0, 0,0,0,255)

mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyInven_CostumeRandomImage2"):addChildWindow(mywindow)




--------------------------------------------------------------------
-- ç���� �̼� �̼Ǻ��� �˾� Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInven_RewardOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 0)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "MyInven_CMRewardOKButtonEvent")
winMgr:getWindow("MyInven_CostumeRandomImage2_Bottom"):addChildWindow(mywindow)




--------------------------------------------------------------------
-- ç���� �̼� ���� ����
--------------------------------------------------------------------
local tRewardBackTexX = {['protecterr']=0, [0] = 0,	266, 0, 266 }
local tRewardBackTexY = {['protecterr']=0, [0] = 210,210, 315, 315 }

for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_RewardBackImage_"..i)
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 315)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
	mywindow:setPosition(37, 80 + i  * 120)
	mywindow:setSize(266, 105)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("EndRender", "RandomMoneyRender")
	winMgr:getWindow("MyInven_CostumeRandomImage2"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_RewardText4_"..i)
	mywindow:setPosition(110, 8)
	mywindow:setSize(160, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("MyInven_RewardBackImage_"..i):addChildWindow(mywindow)


	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_RewardText3_"..i)
	mywindow:setPosition(117, 28)
	mywindow:setSize(160, 80)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	--mywindow:setTextExtends(PreCreateString_2334, g_STRING_FONT_DODUMCHE, 14, 255,255,255,255,   0, 0,0,0,255)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("MyInven_RewardBackImage_"..i):addChildWindow(mywindow)

	--------------------------------------------------------------------
	-- ç���� �̼� ����(�̹���) ����
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_RewardImageBack_"..i)
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setPosition(7, 6)
	mywindow:setSize(105, 98)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyInven_RewardBackImage_"..i):addChildWindow(mywindow)


	--------------------------------------------------------------------
	-- ç���� �̼� ����(�̹���)
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_RewardImage_"..i)
	mywindow:setTexture("Enabled", "UIData/ItemUIData/Item/CASH_Capsule.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/CASH_Capsule.tga", 0, 0)
	mywindow:setPosition(14, 7)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(220)
	mywindow:setScaleHeight(230)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	mywindow:setVisible(true)
	winMgr:getWindow("MyInven_RewardBackImage_"..i):addChildWindow(mywindow)


	-- ������ ī��Ʈ �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_RewardCount_"..i)
	mywindow:setPosition(0, 4)
	mywindow:setSize(87, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("MyInven_RewardImage_"..i):addChildWindow(mywindow)


	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemGradeImage_"..i)
	mywindow:setTexture("Enabled", "UIData/ItemUIData/Item/CASH_Capsule.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Item/CASH_Capsule.tga", 0, 0)
	mywindow:setPosition(70, 3)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	mywindow:setVisible(true)
	winMgr:getWindow("MyInven_RewardImage_"..i):addChildWindow(mywindow)


	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_ItemPromotionImage_"..i)
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 0, 0)
	mywindow:setPosition(40, 70)
	mywindow:setSize(89, 35)
	mywindow:setScaleWidth(200)
	mywindow:setScaleHeight(200)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("MyInven_RewardImage_"..i):addChildWindow(mywindow)



	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInven_ItemGradeText_"..i)
	mywindow:setPosition(63, 5)
	mywindow:setSize(28, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("MyInven_RewardImage_"..i):addChildWindow(mywindow)




	--------------------------------------------------------------------
	-- ç���� �̼� ���̹���
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInven_RewardStarEffect_"..i)
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 420)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 420)
	mywindow:setPosition(-15, -30)
	mywindow:setSize(115, 116)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyInven_RewardBackImage_"..i):addChildWindow(mywindow)
end


function ShowRandomItemBox(twin, type, itemName, ItemFileName, ItemFileName2, Desc, zen, coin, itemgrade, count, kind, promotion, style)
	
	root:addChildWindow(winMgr:getWindow("MyInven_CostumeRandomAlpha"))
	winMgr:getWindow("MyInven_CostumeRandomAlpha"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("MyInven_CostumeRandomImage"))
	winMgr:getWindow("MyInven_CostumeRandomImage"):setVisible(true)	
	if twin == 1 then
		bTwin = true
		winMgr:getWindow("MyInven_RewardBackImage_1"):setVisible(true)
	else
		bTwin = false
		winMgr:getWindow("MyInven_RewardBackImage_1"):setVisible(false)
		
	end
	CheckTwin()
	if type <= 0 then
		winMgr:getWindow("MyInven_CostumeRandomImage"):activeMotion("MyInven_CostumeController");
		Money	   = 0
		MoneyCount = 0
		twinIndex  = -1
	end
	
	winMgr:getWindow("MyInven_RewardText3_"..type):clearTextExtends()
	winMgr:getWindow("MyInven_RewardText4_"..type):clearTextExtends()
	winMgr:getWindow("MyInven_RewardCount_"..type):clearTextExtends()
	winMgr:getWindow("MyInven_ItemGradeText_"..type):clearTextExtends()
	winMgr:getWindow("MyInven_ItemGradeImage_"..type):setVisible(false)
	winMgr:getWindow("MyInven_ItemPromotionImage_"..type):setVisible(false)
	
	if zen > 0 then
		Money = zen
		local Buffer = Money
		while Buffer > 0 do
			MoneyCount = MoneyCount+1
			Buffer	   = Buffer/10
		end
		twinIndex = type
	elseif coin > 0 then
		Money = coin
		local Buffer = Money
		while Buffer > 0 do
			MoneyCount = MoneyCount+1
			Buffer	   = Buffer/10
		end
		twinIndex = type
	else
		local SkillKind = ""
		local string	= ""
		
		if kind == ITEMKIND_SKILL then	-- ���ǥ��
			SkillKind, Desc = Inven_SkillDescDivide(Desc)
			string = AdjustString(g_STRING_FONT_DODUMCHE, 11, Desc, 135)
			string = SkillKind.."\n"..string
			if itemgrade > 0 and itemgrade <= NFREE_MAX_SKILL_UPGRADE_LEVEL then
				winMgr:getWindow("MyInven_ItemGradeImage_"..type):setVisible(true)
				winMgr:getWindow("MyInven_ItemPromotionImage_"..type):setVisible(true)
				winMgr:getWindow("MyInven_ItemGradeImage_"..type):setTexture("Enabled", "UIData/powerup.tga", tGradeTexTable[itemgrade], 486)
				winMgr:getWindow("MyInven_ItemGradeImage_"..type):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemgrade], 486)
				winMgr:getWindow("MyInven_ItemGradeText_"..type):setTextExtends("+"..itemgrade, g_STRING_FONT_DODUMCHE, 11, 
															tGradeTextColorTable[itemgrade][1],
															tGradeTextColorTable[itemgrade][2],
															tGradeTextColorTable[itemgrade][3], 255, 0, 0,0,0,255)
				
				winMgr:getWindow("MyInven_ItemPromotionImage_"..type):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("MyInven_ItemPromotionImage_"..type):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
			end
		else	-- ī��Ʈ ǥ��(2 �̻��϶���)
			if count > 1 then
				winMgr:getWindow("MyInven_RewardCount_"..type):setTextExtends("x "..count, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   1, 0,0,0,255)
			end
			string = AdjustString(g_STRING_FONT_DODUMCHE, 11, Desc, 135)
		end
		winMgr:getWindow("MyInven_RewardText3_"..type):setTextExtends(string, g_STRING_FONT_DODUMCHE, 11, 219,79,255,255,   0, 0,0,0,255)
		winMgr:getWindow("MyInven_RewardText4_"..type):setTextExtends(itemName, g_STRING_FONT_DODUMCHE, 12, 255,183,76,255,   1, 0,0,0,255)	
	end
	winMgr:getWindow("MyInven_RewardImage_"..type):setTexture("Enabled", ItemFileName, 0, 0)
	winMgr:getWindow("MyInven_RewardImage_"..type):setTexture("Disabled", ItemFileName, 0, 0)
	if ItemFileName2 == "" then
		winMgr:getWindow("MyInven_RewardImage_"..type):setLayered(false)
	else
		winMgr:getWindow("MyInven_RewardImage_"..type):setTexture("Layered", ItemFileName2, 0, 0)
		winMgr:getWindow("MyInven_RewardImage_"..type):setLayered(true)
	end
end


function RandomMoneyRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	local index = tonumber(local_window:getUserString("index"))
	if Money == 0 then
		return
	end
	if index == twinIndex then
		if bMoneyRender then
			ImageToNumber(_drawer, Money)
		end	
	end	
end

function ImageToNumber(drawer, ChangeNumber)
	local CuttingNumber = ChangeNumber
	local count = 0
	local TexXTerm = 25
	local PosXTerm = 25
	local firstPosX = 170 + (MoneyCount-1)*13
	
	while CuttingNumber > 0 do
		local number = CuttingNumber%10
		drawer:drawTextureSA("UIData/other001.tga", firstPosX-(count * PosXTerm), 36,   24, 33,   11 + (number*TexXTerm), 683,  255, 255,   255, 0, 0);	-- ����
		count = count+1
		CuttingNumber = CuttingNumber/10		
	end
end
--------------------------------------------------------------------
-- ��ų ��Ʈ�� �ɰ��� �����ش�.
--------------------------------------------------------------------
function Inven_SkillDescDivide(str)
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



function MyInven_CMRewardOKButtonEvent(args)
	bMoneyRender = false
	bTwin = false
	MoneyCount	 = 0
	twinIndex	 = -1
	Money = 0
	for i=0, 1 do
		winMgr:getWindow("MyInven_RewardText1"):setVisible(false)
		winMgr:getWindow("MyInven_RewardText2"):setVisible(false)
		winMgr:getWindow("MyInven_RewardText3_"..i):setVisible(false)
		winMgr:getWindow("MyInven_RewardText4_"..i):setVisible(false)
		winMgr:getWindow("MyInven_RewardCount_"..i):setVisible(false)
		winMgr:getWindow("MyInven_ItemGradeText_"..i):setVisible(false)		
		winMgr:getWindow("MyInven_CostumeRandomAlpha"):setVisible(false)
		winMgr:getWindow("MyInven_CostumeRandomImage"):setVisible(false)
		winMgr:getWindow("MyInven_CostumeRandomImage"):clearActiveController()
	end
	ClearRandomboxInfo()

end


function ShowWrappedSkillPopup()
	ShowCommonAlertOkCancelBoxWithFunction(str_name, PreCreateString_4743, 'WrappedSkillOk', 'WrappedSkillCancel');
end														--GetSStringInfo(LAN_ITEM_UNSEALED)

function WrappedSkillOk(args)
	--DebugStr('1111')
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		--DebugStr('2222')
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "WrappedSkillOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setProperty('Visible', 'False');
		UseWrappedSkill();
	end
end



function WrappedSkillCancel(args)  --Q
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "WrappedSkillCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
	end
end

function CheckItemVillage(index)
	local CurrentPosIndex = GetCurrentWndType()
	if WND_LUA_VILLAGE == CurrentPosIndex then
		ShowOrbDettachEvent(index) return
	else
		ShowCommonAlertOkBoxWithFunction(PreCreateString_3541,'OnClickAlertOkSelfHide')
	end										--GetSStringInfo(LAN_USABLE_ONLY_ZONE6)
end


ResetClasIndexCount = -1

--------------------------------------------------------------------
-- �������� ����
--------------------------------------------------------------------
-- ���� �˾� �����̹���
Resetchangejobbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "Resetchangejobbackimage")
Resetchangejobbackwindow:setTexture("Enabled", "UIData/changedJobs.tga", 0, 0)		
Resetchangejobbackwindow:setTexture("Disabled", "UIData/changedJobs.tga", 0, 0)
Resetchangejobbackwindow:setWideType(6);
Resetchangejobbackwindow:setPosition(230, 30)
Resetchangejobbackwindow:setSize(611, 390)
Resetchangejobbackwindow:setVisible(false)
Resetchangejobbackwindow:setAlwaysOnTop(true)
Resetchangejobbackwindow:setZOrderingEnabled(true)
root:addChildWindow(Resetchangejobbackwindow)

RegistEscEventInfo("Resetchangejobbackimage", "OnClickedResetClassClosed")
local tResetClassName = {["err"]=0,	[0]="Resetclass_TaeKwonDo",	"Resetclass_Boxing", "Resetclass_MuayThai",	"Resetclass_Capoera",
								"Resetclass_ProWrestling",	"Resetclass_Judo",	"Resetclass_Hapgido",	"Resetclass_Sambo"}
								
-- Ŭ���� ����
local g_selectResetClass = -1
local tResetClassPosX = {["err"]=0, [0]=0, 69, 138, 207, 276, 345, 414, 483}
for i=0, #tResetClassName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tResetClassName[i])
	mywindow:setTexture("Normal", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 0)
	mywindow:setTexture("Hover", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 174)
	mywindow:setTexture("Pushed", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 348)
	mywindow:setTexture("PushedOff", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 0)
	mywindow:setTexture("SelectedNormal", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 348)
	mywindow:setTexture("SelectedHover", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 348)
	mywindow:setTexture("SelectedPushed", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 348)
	mywindow:setTexture("SelectedPushedOff", "UIData/Event_ClassImage.tga", tResetClassPosX[i], 348)
	mywindow:setSize(69, 174)
	mywindow:setProperty("GroupID", 7771)
	mywindow:setPosition((i*69)+26, 48)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Resetindex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnClickSelectResetClass");
	--mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ClassInfo")
	--mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ClassInfo")
	Resetchangejobbackwindow:addChildWindow(mywindow)
end

local tResetClassDescPosX = {["err"]=0, [0]=362, 362, 362, 362, 0, 0, 0, 0}
local tResetClassDescPosY = {["err"]=0, [0]=675, 763, 851, 939, 675, 763, 851, 939}
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetclassDescImage")
mywindow:setTexture("Enabled", "UIData/changedJobs.tga", 0, 675)
mywindow:setTexture("Disabled", "UIData/changedJobs.tga", 0, 675)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(150, 232)
mywindow:setSize(362, 88)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Resetchangejobbackwindow:addChildWindow(mywindow)

function OnClickSelectResetClass(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		ResetClasIndexCount = tonumber(local_window:getUserString('Resetindex'))
		winMgr:getWindow("ResetclassDescImage"):setTexture("Enabled", "UIData/changedJobs.tga", tResetClassDescPosX[ResetClasIndexCount], tResetClassDescPosY[ResetClasIndexCount])
		winMgr:getWindow("ResetclassDescImage"):setTexture("Disabled", "UIData/changedJobs.tga", tResetClassDescPosX[ResetClasIndexCount], tResetClassDescPosY[ResetClasIndexCount])
	end
end

mywindow = winMgr:createWindow("TaharezLook/Button", "ResetClassStartBtn");
mywindow:setTexture("Normal",		 "UIData/changedJobs.tga" ,	892 , 896)
mywindow:setTexture("Hover",		 "UIData/changedJobs.tga" ,	892 , 928)
mywindow:setTexture("Pushed",		"UIData/changedJobs.tga" ,	892 , 960)
mywindow:setTexture("PushedOff",	"UIData/changedJobs.tga" ,	892 , 896)
mywindow:setTexture("Disabled",		 "UIData/changedJobs.tga" ,	892 , 896)
mywindow:setPosition(240, 338)
mywindow:setSize(132, 32)
mywindow:setSubscribeEvent("Clicked", "OnClickResetClassStart")
Resetchangejobbackwindow:addChildWindow(mywindow)
	
----------------------------------------------------------------------
-- �������� ����
-----------------------------------------------------------------------
function OnClickResetClassStart()
	if ResetClasIndexCount > 0 then
		
	end
end

-- �������� �ݱ�
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetClassCloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
--mywindow:setPosition(725, 15)
mywindow:setPosition(580, 10)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedResetClassClosed")
Resetchangejobbackwindow:addChildWindow(mywindow)

function OnClickedResetClassClosed()
	Resetchangejobbackwindow:setVisible(false)
	ResetClasIndexCount = -1;
end

function ShowResetClassWindow()
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	for i = 0 , #tResetClassName-1 do
		winMgr:getWindow(tResetClassName[i]):setEnabled(true)
	end
	winMgr:getWindow(tResetClassName[0]):setEnabled(false)
	Resetchangejobbackwindow:setVisible(true)
	ResetClasIndexCount = -1;
end


------------------------------
-- �� ��ȭ ���� 
------------------------------

RegistEscEventInfo("PetHatchSelect_MainWindow", "OnClickPetSelectCancel")

-- �� ���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetHatchSelect_MainWindow")
mywindow:setTexture("Enabled",	"UIData/frame/frame_010.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0 , 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setPosition(360 , 200)
mywindow:setSize(339, 350)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- �� ���� Ÿ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetHatchSelect_TitleWindow")
mywindow:setTexture("Enabled", "UIData/pet_01.tga",  413, 977 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 413, 977 )
mywindow:setPosition(80 , 5)
mywindow:setSize(179, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)


-- �� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetHatchSelect_EnableMate")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 784, 760 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 784, 760 )
mywindow:setPosition(55 , 210)
mywindow:setSize(230, 83)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)


PetSelectColor	= {['protecterr']=0, "PetSelectColor_1", "PetSelectColor_2", "PetSelectColor_3" }
PetSelectColorPosX	= {['protecterr']=0,  7,	7+98,	7+98*2 }
	
for i = 1, #PetSelectColor do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectPetColorBackImage"..i)
	mywindow:setTexture("Enabled", "UIData/pet_03.tga", 0, 0 )
	mywindow:setTexture("Disabled", "UIData/pet_03.tga", 0, 0 )
	mywindow:setPosition((99*i)-80 , 67)
	mywindow:setSize(99, 136)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectPetColorImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 364)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 364)
	mywindow:setPosition((99*i)-80 , 77)
	mywindow:setScaleHeight(200)	
	mywindow:setScaleWidth(200)		
	mywindow:setSize(128, 128)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", PetSelectColor[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/pet_01.tga", 84+(99*1), 535 )
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0+(99*2), 0 )
	mywindow:setTexture("Disabled", "UIData/invisible.tga",  0+(99*2), 0 )
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",  0+(99*3), 0 )
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga",  0+(99*3), 0 )
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",  0+(99*3), 0 )
	mywindow:setPosition((99*i)-80 , 67)
	mywindow:setProperty("GroupID", 15)
	mywindow:setSize(99, 136)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setSubscribeEvent("SelectStateChanged", "SelectedPetRadioColorUi")
	winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)
end

function SelectedPetRadioColorUi(args)
	for i= 1, #PetSelectColor do
		if CEGUI.toRadioButton(winMgr:getWindow(PetSelectColor[i])):isSelected() then
			winMgr:getWindow("SelectPetColorBackImage"..i):setTexture("Enabled", "UIData/pet_01.tga", 84+(99*2), 535 )
		else
			winMgr:getWindow("SelectPetColorBackImage"..i):setTexture("Enabled", "UIData/pet_01.tga", 84, 535 )
		end
	end
	
end


PetSelectButtonName = {['protecterr'] = 0, 'PetSelectOk', 'PetSelectCancel'}
PetSelectTextureX = {['protecterr'] = 0, 693, 858 }
PetSelectTexturePosX = {['protecterr'] = 0, 4, 169}
PetSelectBtnEvent = {["err"]=0, "OnClickPetSelectOk", "OnClickPetSelectCancel"}

for i=1, #PetSelectButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetSelectButtonName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", PetSelectTextureX[i], 849);
	mywindow:setTexture("Hover", "UIData/popup001.tga", PetSelectTextureX[i], 878);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", PetSelectTextureX[i], 907);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", PetSelectTextureX[i], 849);
	mywindow:setSize(166,  29);
	mywindow:setPosition(PetSelectTexturePosX[i], 317);
	mywindow:subscribeEvent("Clicked", PetSelectBtnEvent[i])
	winMgr:getWindow("PetHatchSelect_MainWindow"):addChildWindow(mywindow)
end

function OnClickPetSelectOk()
	local selectPetColor = 0
	for i= 1, #PetSelectColor do
		if CEGUI.toRadioButton(winMgr:getWindow(PetSelectColor[i])):isSelected() then
			selectPetColor = i 
		end
	end
	
	if selectPetColor > 0 and selectPetColor < 4 then
		HactchSelectPetColor(selectPetColor)
		OnClickPetSelectCancel()
		return
	end
end

function OnClickPetSelectCancel()
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(false)
	winMgr:getWindow("PetHatchSelect_MainWindow"):setVisible(false)
end	

-- �κ��丮 �� ��ȭ ������ Ŭ����
function ShowPetHatchSelectColorUi(kind)
	
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	winMgr:getWindow("PetHatchSelect_MainWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("PetHatchSelect_MainWindow"))
	
	for i = 1, #PetSelectColor do
		winMgr:getWindow("SelectPetColorImage"..i):setTexture("Enabled", "UIData/pet/PET_"..kind.."_"..i..".tga", 0, 0)
	end
	
	winMgr:getWindow(PetSelectColor[1]):setProperty("Selected", "true")
	CloseUserInfoWindow()
end

