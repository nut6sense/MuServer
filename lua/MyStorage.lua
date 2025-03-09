-------------------------------------------------------------
-- �� â�� lua ����
-------------------------------------------------------------
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

--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------


--------------------------------------------------------------------
-- ������ ����
--------------------------------------------------------------------
local MAX_STORAGE_ITEM_X_COUNT = GetMyStorageOnePageMaxItemCount(0)		-- ���������� ���� �������� �ִ밹���� �޾ƿ´�.
local MAX_STORAGE_ITEM_Y_COUNT = GetMyStorageOnePageMaxItemCount(1)		-- ���������� ���� �������� �ִ밹���� �޾ƿ´�.
local Item_first_PointX = 40
local Item_first_PointY = 106
local Item_X_term = 61
local Item_Y_term = 61


-------------------------------------------------------------
-- �� â��
-------------------------------------------------------------
-------------------------------------------------------------
MyStorageWindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_BackImage")
MyStorageWindow:setTexture("Enabled", "UIData/Match002.tga", 715, 532)
MyStorageWindow:setTexture("Disabled", "UIData/Match002.tga", 715, 532)
MyStorageWindow:setWideType(6);
MyStorageWindow:setPosition(50, (g_MAIN_WIN_SIZEY-500)/2)
MyStorageWindow:setSize(309, 437)
MyStorageWindow:setAlwaysOnTop(true)
MyStorageWindow:setVisible(false)
MyStorageWindow:setZOrderingEnabled(true)
root:addChildWindow(MyStorageWindow)


RegistEscEventInfo("MyStorage_BackImage", "HideMyStorage")


--------------------------------------------------------------------
-- �� â�� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyStorage_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(279, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideButtonMyStorage")
MyStorageWindow:addChildWindow(mywindow)



-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
tMyStorageListName  = {["err"]=0, [0]="MyStorage_costume", "MyStorage_skill", "MyStorage_etc", "MyStorage_special", "MyStorage_cashTab"}
tMyStorageListTexX  = {["err"]=0, [0]=41, 97, 153, 209, 265}
tMyStorageListPosX  = {["err"]=0, [0]=12, 12 + 56, 12 + 56*2, 12 + 56*3, 12 + 56*4}

for i=0, #tMyStorageListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyStorageListName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyStorageListTexX[i], 577)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyStorageListTexX[i], 600)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyStorageListTexX[i], 577)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setPosition(tMyStorageListPosX[i], 43)
	mywindow:setProperty("GroupID", 2111)
	mywindow:setSize(56, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyStorageSelectTab")
	if i == 0 then
		mywindow:setProperty("Selected", "true")
	end
	MyStorageWindow:addChildWindow(mywindow)
end


local aaass = 49
-- ������ �ε���(�ִ� 5��)
tMyStorageBagName  = {["err"]=0, [0]="MyStorage_Bag1", "MyStorage_Bag2", "MyStorage_Bag3", "MyStorage_Bag4", "MyStorage_Bag5"}
tMyStorageBagTexX  = {["err"]=0, [0]=	377, 426, 475, 524, 573}
tMyStorageBagPosX  = {["err"]=0, [0]=	31, 31 + aaass, 31 + aaass*2, 31 + aaass*3, 31 + aaass*4}

for i=0, #tMyStorageBagName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyStorageBagName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyStorageBagTexX[i], 646)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyStorageBagTexX[i], 670)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyStorageBagTexX[i], 718)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setPosition(tMyStorageBagPosX[i], 72)
	mywindow:setProperty("GroupID", 2112)
	mywindow:setSize(49, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i + 1)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyStorageSelectBag")
	MyStorageWindow:addChildWindow(mywindow)
end



function MyStorageSelectBag(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local ClickWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(ClickWindow:getUserString("Index"))
		local check = StoragePageButtonEvent(index)
		
		if check then			
			RefreshStorageUiView(index)
		end
	end	
end


-- ������ ����Ʈ �ǸŸ��
for i=0, MAX_STORAGE_ITEM_Y_COUNT-1 do
	for j=0, MAX_STORAGE_ITEM_X_COUNT-1 do
		local Index = i*MAX_STORAGE_ITEM_X_COUNT+j

		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Image_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)
		mywindow:setScaleHeight(118)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Image_Seal_"..Index)
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
		MyStorageWindow:addChildWindow(mywindow)
		
		
		-- �������� ������(Pure OR SelectedVisual) �̹��� ��
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Avatar_Icon_Type_"..Index)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)--118)
		mywindow:setScaleHeight(118)--118)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		
		
		-- ��ų ���� �׵θ� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_SkillLevelImage_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 16, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)

		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyStorage_ItemList_SkillLevelText_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 21, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		

		-- �������� ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Warning_"..Index)
		mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		
		-- �������� ��ư(������ ��ü���� ��ư)
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "MyStorage_ItemList_Button_"..Index)
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
		mywindow:subscribeEvent("MouseDoubleClicked", "MyStorage_ItemdoubleClick")
		mywindow:subscribeEvent("MouseEnter", "MyStorage_ItemMouseEnter")
		mywindow:subscribeEvent("MouseLeave", "MyStorage_ItemMouseLeave")
		MyStorageWindow:addChildWindow(mywindow)
		
		-- ���� ������ ����
		mywindow = winMgr:createWindow("TaharezLook/Button", "MyStorage_DetailIInfoBtn_"..Index)
		mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
		mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
		mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
		mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
		mywindow:setPosition(30, 30)
		mywindow:setSize(20, 20)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setSubscribeEvent("Clicked", "MyStorage_ShowRandomOpenItem")
		winMgr:getWindow("MyStorage_ItemList_Button_"..Index):addChildWindow(mywindow)
		
		
		-- ������ ���� ī��Ʈ
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyStorage_ItemList_Count_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(2, 2)
		mywindow:setSize(45, 20)
		mywindow:setAlign(6)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("MyStorage_ItemList_Button_"..Index):addChildWindow(mywindow)

	end
end


function MyStorage_ShowRandomOpenItem(args)
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
	local itemKind, itemNumber = GetMyStorageTooltipInfo(index)	
	ShowRandomOpenItem(itemNumber, x, y)

end


-- �κ��丮 ������ ����Ŭ�� �̺�Ʈ
function MyStorage_ItemdoubleClick(args)
	-- ������ ���
	local ClickWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(ClickWindow:getUserString("Index"))
	
	SettingStorageInputCountWindow(index)
end



-- �����ۿ� ���콺�� ���ö�,
function MyStorage_ItemMouseEnter(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	if index == -1 then
		return
	end
	local itemKind, itemNumber = GetMyStorageTooltipInfo(index)
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
	
	if x + 283 > g_MAIN_WIN_SIZEX then
		x = x - 283
	end
	
	GetToolTipBaseInfo(x + 47, y, 2, Kind, index, itemNumber , 1)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
end


-- �����ۿ��� ���콺�� ������.
function MyStorage_ItemMouseLeave(args)
	SetShowToolTip(false)

end


-- �κ��丮�� ���� ���õ����� ������ �̺�Ʈ
function MyStorageSelectTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		
		SetStorageTab(tabindex)	-- �κ��丮 �� ����
		local CurrentMaxPage = GetStorageCurrentMaxPage(tabindex)
		SettingStorageMaxPageButton(CurrentMaxPage)
		
		if GetStorageCurrentPage() == 1 then
			local check = StoragePageButtonEvent(1)

			if check then
				RefreshStorageUiView(1)
			end
		end		
		winMgr:getWindow("MyStorage_Bag1"):setProperty("Selected", "true")
	end
end


-- ���� �ǿ� ���� ������ �ִ� �������� ���� ��ư ����
function SettingMaxPageByStorageTab(tabIndex)
	for i=0, #tMyStorageBagName do
		if i < tabIndex then
			winMgr:getWindow(tMyStorageBagName[i]):setVisible(true)
		else
			winMgr:getWindow(tMyStorageBagName[i]):setVisible(false)
		end		
	end
end





-- �κ��丮�� ����ش�(�ʱ�ȭ)
function ClearMyStorage()
	for i=0, MAX_STORAGE_ITEM_X_COUNT-1 do
		for j=0, MAX_STORAGE_ITEM_Y_COUNT-1 do
			local Index = i*(MAX_STORAGE_ITEM_X_COUNT+1)+j
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setLayered(false)
			winMgr:getWindow("MyStorage_ItemList_Image_Seal_"..Index):setVisible(false)					
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Layered", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Avatar_Icon_Type_"..Index):setVisible(false)
			
			-- ��ų ���� �̹��� 
			winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..Index):setVisible(false)
			winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..Index):setText("")
			
			winMgr:getWindow("MyStorage_ItemList_Button_"..Index):setUserString("Index", tostring(-1))
			winMgr:getWindow("MyStorage_ItemList_Count_"..Index):clearTextExtends()

			winMgr:getWindow("MyStorage_ItemList_Warning_"..Index):setVisible(false)
			winMgr:getWindow("MyStorage_ItemList_Warning_"..Index):setTexture("Disabled", "UIData/Match002.tga", 667, 646)
			winMgr:getWindow("MyStorage_DetailIInfoBtn_"..Index):setVisible(false)
		end
	end
end



-- �κ��丮�� ä���ش�.
-- �Ϲ�, ����, ������, ���� ������
local tStatefile = {['err'] = 0, [0]="invisible.tga", "Match002.tga", "Match002.tga", "Match002.tga", "Match002.tga"}
local tStateY = {['err'] = 0,	[0]= 0,					646,			646,		790,				838}

function SettingMyStorage(posIndex, slotIndex, itemNumber, fileName, fileName2, itemcount, state, grade, bSeal , nCloneAvatarType , bTrade , attach)
	winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Enabled", "UIData/"..fileName, 0, 0)
	winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Disabled", "UIData/"..fileName, 0, 0)
	
	if grade > 0 then
		winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..posIndex):setVisible(true)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..posIndex):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..posIndex):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..posIndex):setText("+"..grade)
	end	
	
	if fileName2 == "" then
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setLayered(false)
	else
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setLayered(true)
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Layered", "UIData/"..fileName2, 0, 0)		
	end
	winMgr:getWindow("MyStorage_ItemList_Image_Seal_"..posIndex):setVisible(bSeal)
	
	winMgr:getWindow("MyStorage_ItemList_Button_"..posIndex):setUserString("Index", tostring(slotIndex))
	winMgr:getWindow("MyStorage_ItemList_Count_"..posIndex):clearTextExtends()
	winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setVisible(true)
	winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[state], 667, tStateY[state])
	
	
	-- ��ų ��ȭ 1�̻� , �ŷ������� ������ ������ ���ǥ�á�
	if grade >= GetSealedSkillGrade() then
		if bTrade == true then
			winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setVisible(true)
			winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[3], 667, tStateY[3])
			DebugStr("Ʈ���̵� Ʈ��")
			--winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setTexture("Layered", "UIData/ItemUIData/Insert/Seal.tga", 0, 0)
		end
	end
			
	if itemcount > 1 then
		winMgr:getWindow("MyStorage_ItemList_Count_"..posIndex):addTextExtends("x "..itemcount, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,    0, 0,0,0,255)
	end
	if CheckDetailInfoBtn(itemNumber) then
		winMgr:getWindow("MyStorage_DetailIInfoBtn_"..posIndex):setVisible(true)
	else
		winMgr:getWindow("MyStorage_DetailIInfoBtn_"..posIndex):setVisible(false)
	end	
	
	-- �ڽ�Ƭ �ƹ�Ÿ ������ ��� �Լ� ��
	SetAvatarIconS(	"MyStorage_ItemList_Image_" , "MyStorage_ItemList_Warning_" ,  "MyStorage_ItemList_Avatar_Icon_Type_" , 
					posIndex , nCloneAvatarType , attach )
end


function SettingStorageMaxPageButton(MaxPage)
	for i=0, #tMyStorageBagName do
		if i < MaxPage then
			winMgr:getWindow(tMyStorageBagName[i]):setEnabled(true)
		else
			winMgr:getWindow(tMyStorageBagName[i]):setEnabled(false)
		end		
	end
end


function SettingStorageMaxPageRefresh()
	local TabIndex = GetStorageTab()
	local CurrentMaxPage = GetStorageCurrentMaxPage(TabIndex)
	SettingStorageMaxPageButton(CurrentMaxPage)
end


function ChangeMyStorageTabEvent(tabIndex)
	local changeWindow = winMgr:getWindow(tMyStorageListName[tabIndex])
	if CEGUI.toRadioButton(changeWindow):isSelected() then
		return	
	end
	changeWindow:setProperty("Selected", "true")
end


-- â�� �����ش�
function ShowMyStorage()
	-- â�� --
	SetStorageTab(0)
	local CurrentMaxPage = GetStorageCurrentMaxPage(0)
	SettingStorageMaxPageButton(CurrentMaxPage)
	winMgr:getWindow("MyStorage_costume"):setProperty("Selected", "true")
	winMgr:getWindow("MyStorage_Bag1"):setProperty("Selected", "true")
	
	root:addChildWindow(winMgr:getWindow("MyStorage_BackImage"))
	winMgr:getWindow("MyStorage_BackImage"):setVisible(true)
	SetIsvisibleStorage(true)
		
	ShowMyInventory(true, true)
end



-- �κ��丮�� �����.
function HideMyStorage()
	HideMyInventory()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyStorage_BackImage"):setVisible(false)
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)	
	SetIsvisibleStorage(false)	
end


-- �κ��丮�� �����.
function HideButtonMyStorage()
	HideMyInventory()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyStorage_BackImage"):setVisible(false)
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)
	SetIsvisibleStorage(false)
	TownNpcEscBtnClickEvent()	
end
