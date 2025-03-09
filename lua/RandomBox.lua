----------------------------------------------------------------------
-- ���� �����ڽ�
----------------------------------------------------------------------
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


 
local MaxCount_OnePage = 5		-- ���������� ���� ������ ����
local TownStoreitemString = PreCreateString_2692	--GetSStringInfo(LAN_SELECT_RANDOMI_TEM)	-- %s �����Ͻðڽ��ϱ�?

local tNormalPosition = {["err"]=0, [0]= (1024-298)/2 , (768-438)/2 }
local tRentalPosition = {["err"]=0, [0]= 120 , 58 }
local g_ClassTabIndex = -1 -- Ŭ���� �ε���


----------------------------------------------------------------------
-- ���� ���� �ڽ� ����
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectRandomboxMain")
mywindow:setTexture("Enabled", "UIData/Randombox_001.tga", 0,0)
mywindow:setWideType(6)
mywindow:setPosition((1024-298)/2, (768-438)/2)
mywindow:setSize(298, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("SelectRandomboxMain", "HideSelectRandomBoxSelectWindow")

mywindow = winMgr:createWindow("TaharezLook/Button", "SelectRandombox_CloseButton")
mywindow:setTexture("Normal",		"UIData/Randombox_001.tga", 476, 1)
mywindow:setTexture("Hover",		"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("Pushed",		"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("PushedOff",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setPosition(269, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideSelectRandomBoxSelectWindow")
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)


-- ������ ����Ʈ ����
local RandomSelectBoxTabName  = {["err"]=0, [0]="RandomSelectBox_Strike", "RandomSelectBox_Grab", "RandomSelectBox_Special", "RandomSelectBox_TeamDouble"}
local RandomSelectBoxTabTexX  = {["err"]=0, [0]=298, 368, 298, 368}
local RandomSelectBoxTabTexY  = {["err"]=0, [0]=1, 1, 64, 64}
local RandomSelectBoxTabPosX  = {["err"]=0, [0]=4, 76, 148, 220}

for i=0, #RandomSelectBoxTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RandomSelectBoxTabName[i])
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i])
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedNormal", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedHover", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedPushed", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setPosition(RandomSelectBoxTabPosX[i] + 2, 39)
	mywindow:setProperty("GroupID", 2029)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RandomSelectBoxTab")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end


-- ������ ����Ʈ ����(�ڽ���, ��ų, ��Ÿ, ��ȭ)
--local BoneTypeTabName  = {["err"]=0, [0]="RandomSelectBox_Strike", "RandomSelectBox_Grab", "RandomSelectBox_Special", "RandomSelectBox_TeamDouble"}
local BoneTypeTabTexX  = {["err"]=0, [0]=368, 368, 368, 438, 438, 438}
local BoneTypeTabTexY  = {["err"]=0, [0]=127, 190, 253, 127, 190, 253}
local BoneTypeTabPosX  = {["err"]=0, [0]=4, 76, 148, 4, 76, 148}
local BoneTypeTabPosY  = {["err"]=0, [0]=39, 39, 39, 65, 65, 65}

for i=0, #BoneTypeTabTexX do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "BoneTypeTabName_"..i)
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i])
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedNormal", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedHover", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedPushed", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setPosition(BoneTypeTabPosX[i]+40, BoneTypeTabPosY[i])
	mywindow:setProperty("GroupID", 2030)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RandomSelectBoxTab")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end



for i=0, MaxCount_OnePage-1 do	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_"..i);	
	mywindow:setTexture("Enabled", "UIData/Randombox_001.tga", 0,438)
	mywindow:setSize(284, 55);
	mywindow:setPosition(6, 65 + i * 59);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString('index', tostring(i))
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow);
	
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_ItemImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(2, 2)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(112)
	mywindow:setScaleHeight(112)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)		
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_gradeImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_gradeText_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setTextColor(255,255,255,255)	
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_EventImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RandomSelectBox")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_RandomSelectBox")
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_ItemName_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255,200,50,255)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:setPosition(60, 8)
	mywindow:setSize(220, 40)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_ItemCount_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(150,150,150,255)	
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)

	-- ������ ��Ϲ�ư( ��Ϲ�ư )
	mywindow = winMgr:createWindow("TaharezLook/Button", "RandomSelectBox_SelectBtn_"..i)
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", 298, 191)
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", 298, 214)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", 298, 237)
	mywindow:setTexture("PushedOff", "UIData/Randombox_001.tga", 298, 237)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", 298, 260)
	mywindow:setPosition(213, 27)
	mywindow:setSize(69, 23)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "RandomSelectBoxSelectBtnEvent")
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
end


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)


-- ������ �¿� ��ư
local RandomSelectBox_BtnName  = {["err"]=0, [0]="RandomSelectBox_LBtn", "RandomSelectBox_RBtn"}
local RandomSelectBox_BtnTexX  = {["err"]=0, [0]=438, 457}
local RandomSelectBox_BtnPosX  = {["err"]=0, [0]=170, 270}
local RandomSelectBox_BtnEvent = {["err"]=0, [0]="OnClickRandomSelectBox_PrevPage", "OnClickRandomSelectBox_NextPage"}
for i=0, #RandomSelectBox_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", RandomSelectBox_BtnName[i])
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 1)
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 26)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 51)
	mywindow:setTexture("PushedOff", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 51)
	mywindow:setPosition(RandomSelectBox_BtnPosX[i], 387)
	mywindow:setSize(19, 25)
	mywindow:setSubscribeEvent("Clicked", RandomSelectBox_BtnEvent[i])
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end

-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickRandomSelectBox_PrevPage()
	local check = RandomSelectBoxPrevButtonEvent()
	if check then
		local totalPage = GetRandomSelectBoxTotalPage()
		local currentPage = GetRandomSelectBoxCurrentPage()
		winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- ������ ���ư Ŭ���̺�Ʈ
function OnClickRandomSelectBox_NextPage()
	local check = RandomSelectBoxNextButtonEvent()
	if check then
		local totalPage = GetRandomSelectBoxTotalPage()
		local currentPage = GetRandomSelectBoxCurrentPage()
		winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end


-- �������� �������ش�.
function SettingRandomSelectBoxPageText(currentPage, totalPage)
	winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end


-- ������ ��Ϲ�ư �̺�Ʈ
function RandomSelectBoxSelectBtnEvent(args)
	local eventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(eventWindow:getUserString("index"))
	
	local itemName, nMatch, bIsRental   = SelectItemEvent(Index) -- g_ClassTabIndex
	local String						= string.format(TownStoreitemString, itemName)
	local IsUseable						= GetCharacterLevel(Index)

	-- Rental ��ų�϶���, ������, Ŭ������ ������ �д�
	if bIsRental == true then
		
		-- �ڽ��� Ŭ������ ���� �ʴ� �������� ������ ����
		if nMatch == false then
			ShowNotifyOKMessage(PreCreateString_1089)	--GetSStringInfo(LAN_LUA_COMMON_AB_1)
			return
		end
		
		-- ĳ������ ������ ���Ƽ� ����Ҽ� ����
		if IsUseable == 0 then
			ShowNotifyOKMessage(PreCreateString_4194)	--GetSStringInfo(LAN_LEVEL_NOT_001)
			return
		end
	end
	
	
	ShowRandomBoxSelectPopup(String)
end


-- �����ۿ� ���콺 ��������
function OnMouseEnter_RandomSelectBox(args)
	DebugStr("���콺����")
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
	local index			= tonumber(EnterWindow:getUserString("Index"))
	local Kind			= -1
	local itemKind, itemnumber, attributeType = GetRandomBoxInsideListToolTipInfo(index)
	
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	if Kind ~= KIND_SKILL then
		return
	end
	ReadAnimation(itemnumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(winMgr:getWindow("SelectRandomboxMain"))
	
	targetx = targetx - 236
	if targetx < 0 then
		targetx = 0
	end	
	
	targety = targety - 69
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
end


-- �����ۿ��� ���콺 ��������
function OnMouseLeave_RandomSelectBox(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
	
end


-- ���÷��� �ڽ��� ����ui�� �����ش�.
function ShowSelectRandomBoxSelectWindow(propValue)
	
	root:addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setVisible(true)
	--DebugStr("propValue : " .. propValue)
	
	local startPosY = 65
	if propValue == 1 then
		if CEGUI.toRadioButton(winMgr:getWindow("RandomSelectBox_Strike")):isSelected() then
			SetTabIndex(0)
		else
			winMgr:getWindow("RandomSelectBox_Strike"):setProperty("Selected", "true")
		end	
	elseif propValue == 2 then
		--startPosY = 90
		if CEGUI.toRadioButton(winMgr:getWindow("BoneTypeTabName_0")):isSelected() then
			SetTabIndex(0)
		else
			winMgr:getWindow("BoneTypeTabName_0"):setProperty("Selected", "true")
		end	
	elseif propValue == 3 then
		SetTabIndex(0)
	elseif propValue == 4 then
		SetTabIndex(0)
	else
		SetTabIndex(0)
	end
	
	for i=0, MaxCount_OnePage-1 do
		winMgr:getWindow("RandomSelectBox_"..i):setPosition(6, startPosY + i * 59);
	end
	
	
	
end


-- ���÷��� �ڽ��� ����ui�� �����ش�.
function HideSelectRandomBoxSelectWindow()
	winMgr:getWindow("SelectRandomboxMain"):setVisible(false)
		
	-- ��Ż ��ų ���� ���� �Լ�
	CloseRentalSkillPopup()
end


-- ���� �ڽ��� �����۸���Ʈ�� �ʱ�ȭ ���ش�.
function ClearRandomboxItemList()
	for i=0, MaxCount_OnePage-1 do
		winMgr:getWindow("RandomSelectBox_"..i):setVisible(false)
	end
end



function OnSelect_RandomSelectBoxTab(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local tabIndex = tonumber(EnterWindow:getUserString("TabIndex"))
		SetTabIndex(tabIndex)
	end	
end
-- 

-- ���� �ڽ��� �����۸���Ʈ�� �������ش�.
function SettingRandomboxItemList(ListIndex, index, itemName, filePath, filePath2, grade, itemCount, bPossession)
	winMgr:getWindow("RandomSelectBox_SelectBtn_"..index):setUserString("index", ListIndex)		-- ��ư�� ���� �ε����� �����Ѵ�.
	winMgr:getWindow("RandomSelectBox_EventImg_"..index):setUserString("Index", ListIndex)		-- ��ư�� ���� �ε����� �����Ѵ�.
	
	winMgr:getWindow("RandomSelectBox_"..index):setVisible(true)		
	winMgr:getWindow("RandomSelectBox_ItemName_"..index):setTextExtends(itemName, g_STRING_FONT_DODUMCHE, 12, 255,200,50,255,   0, 0,0,0,255)
	
	if bPossession == 1 then
		winMgr:getWindow("RandomSelectBox_ItemName_"..index):addTextExtends(" ["..PreCreateString_2924.."]", g_STRING_FONT_DODUMCHE, 12, 16, 240, 64,255,   0, 0,0,0,255)
	end
	
	if itemCount > 1 then
		winMgr:getWindow("RandomSelectBox_ItemCount_"..index):setText("x"..itemCount)	
	else
		winMgr:getWindow("RandomSelectBox_ItemCount_"..index):setText("")	
	end
	winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setTexture("Disabled", filePath, 0, 0)
	if filePath2 == "" then
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setLayered(false)
	else
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setLayered(true)
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setTexture("Layered", filePath2, 0, 0)
	end
	if grade > 0 then
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setVisible(true)
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setVisible(false)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setText("")
	end
end


function SectionRandomSelectBox(index)
	--DebugStr("[!]index : " .. index)
	local bTabVisible = false
	local bTabVisible2 = false
	
	if index == 1 then		-- 
		bTabVisible = true	-- ���� �����ش�.
	elseif index == 2 then
		bTabVisible = false	-- ���� �����ش�.
		--bTabVisible2 = true
	elseif index == 3 then
		bTabVisible = false	-- ���� �����ش�.
	elseif index == 4 then
		bTabVisible = false	-- ���� �����ش�.
	end	
	
	for i=0, #RandomSelectBoxTabName do
		winMgr:getWindow(RandomSelectBoxTabName[i]):setVisible(bTabVisible)
	end	
	for i=0, #BoneTypeTabTexX do
		winMgr:getWindow("BoneTypeTabName_"..i):setVisible(bTabVisible2)
	end	
end



--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'RandomBoxSelect_AlphaImage')
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("RandomBoxSelect_AlphaImage", "HideRandomBoxSelectPopup")

--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'RandomBoxSelect_MainImage')
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0)
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2)
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('RandomBoxSelect_AlphaImage'):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomBoxSelect_Text")
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setPosition(3, 45)
mywindow:setSize(340, 180)
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
winMgr:getWindow('RandomBoxSelect_MainImage'):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ��ư (Ȯ��, ���)
--------------------------------------------------------------------
local ButtonName	= {['protecterr']=0, "RandomBoxSelect_Reform", "RandomBoxSelect_Cancel"}
local ButtonTexX	= {['protecterr']=0,		693,			858}
local ButtonPosX	= {['protecterr']=0,		4,				169}		
local ButtonEvent	= {['protecterr']=0, "RandomBoxSelect_ReformEvent", "RandomBoxSelect_CancelEvent"}

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
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('RandomBoxSelect_MainImage'):addChildWindow(mywindow)
end


function RandomBoxSelect_ReformEvent(args)
	DebugStr("RandomBoxSelect_ReformEvent")
	
	HideSelectRandomBoxSelectWindow() 
	
	-- ��
	if GetAutoTakeFlag() == true then
		RequestAutoTakeRentalSkill(); -- ���ο� Take All ��Ż��ų
	else
		RequestSkillRandomBox(); -- ������ ��Ż��ų
	end
	
	HideRandomBoxSelectPopup()
end



function RandomBoxSelect_CancelEvent(args)
	HideRandomBoxSelectPopup()
end


-- 
function ShowRandomBoxSelectPopup(string)
	root:addChildWindow(winMgr:getWindow('RandomBoxSelect_AlphaImage'))

	local x,y = GetWindowSize()
	x = (x/2) - (340/2)
	y = (y/2) - (268/2)
	winMgr:getWindow('RandomBoxSelect_MainImage'):setPosition(x,y)
	
	winMgr:getWindow('RandomBoxSelect_AlphaImage'):setVisible(true)
	winMgr:getWindow('RandomBoxSelect_Text'):setTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255, 2, 0,0,0,255)
end


-- 
function HideRandomBoxSelectPopup()
	winMgr:getWindow('RandomBoxSelect_AlphaImage'):setVisible(false)
end







--***************************************************************************************************************************
--											��Ż ��ų ( �Ϸ� �Ⱓ�� +9�� ��ų )
--***************************************************************************************************************************
RegistEscEventInfo("RentalSkill_Main_Alpha", "HideSelectRandomBoxSelectWindow")


















----------------------------------------------------------------------
-- ��Ż ��ų ���� ����
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkill_Main_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setWideType(6)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2) - 425/2 , (g_MAIN_WIN_SIZEY / 2) - 503/2 )
mywindow:setSize(425, 510)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- ��Ż ��ų ����
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkill_Main")
mywindow:setTexture("Enabled",	"UIData/Randombox_002.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/Randombox_002.tga", 0,0)
mywindow:setPosition(0,0)
mywindow:setSize(425, 510)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- Ÿ��Ʋ��
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/Titlebar", "RentalSkill_Title")
mywindow:setPosition(0, 0)
mywindow:setSize(390, 45)
mywindow:setEnabled(true)
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- ��Ż ��ų �ݱ� ��ư
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "RentalSkill_Close_Btn")
mywindow:setTexture("Normal",	"UIData/Randombox_001.tga", 476, 1)
mywindow:setTexture("Hover",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("Pushed",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("PushedOff","UIData/Randombox_001.tga", 476, 24)
mywindow:setPosition(390, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideSelectRandomBoxSelectWindow")
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)


----------------------------------------------------------------------
-- 0 = [��Ż ��ų ����â] , 1 = [+7 �̺�Ʈ ��ų ����â] ,  rkawk
----------------------------------------------------------------------

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Rental_BoxSkill_Level")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198, 7)
mywindow:setSize(26, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)

function SetBoxName()
	DebugStr("SetBoxName() ����")
	
	-- Exception handling --
	local propIndex4 = GetPropIndex4();
	if propIndex4 == -1 then
		DebugStr("propIndex4�� -1�̶� ���� : ����")
		return
	end
	DebugStr("propIndex4 : " .. propIndex4)
	
	-- Setting --
	if propIndex4 == -10 then		--> +9 ��Ż ��ų.
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Enabled",		"UIData/Randombox_002.tga", 425, 176)
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Disabled",	"UIData/Randombox_002.tga", 425, 176)
	elseif propIndex4 == -11 then	--> +7 �̺�Ʈ ��ų.
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Enabled",		"UIData/Randombox_002.tga", 425, 132)
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Disabled",	"UIData/Randombox_002.tga", 425, 132)
	end
	
end


----------------------------------------------------------------------
-- ��Ż ��ų ������ ��ư
----------------------------------------------------------------------
local RentalSkillBtnName  = { ["err"]=0, [0] = "RentalSkill_TaeKwonDo_Btn", "RentalSkill_Boxing_Btn", "RentalSkill_Muta_Btn",   "RentalSkill_Capo_Btn",-- ��Ʈ��Ʈ
											   "RentalSkill_Pro_Btn",		"RentalSkill_Judo_Btn",   "RentalSkill_Hapgido_Btn","RentalSkill_Sambo_Btn", -- ����
											   "RentalSkill_DirtyX_Btn",	"RentalSkill_Sumo_Btn",	  "RentalSkill_KungPu",		"RentalSkill_Ninja" }

local RentalSkillTexX	  = { ["err"]=0, [0] = 0  , 110 , 220 , 330 ,
											   0  , 110 , 220 , 330 ,
											   0  , 110 , 220,  330 }
											   
local RentalSkillTexY	  = { ["err"]=0, [0] = 0   , 0   , 0   , 0   ,
											   156 , 156 , 156 , 156 ,
											   312 , 312 , 312,  312 }
											   											   
local RentalSkillPosY	  = { ["err"]=0, [0] = 72, 111, 150, 189,
											   228, 267, 306, 345,
											   384, 423, 462, 462 }

local RentalItemIndex	  = { ["err"]=0, [0] = 3 , 5 , 17 , 9,
											   18, 4 , 10 , 6 ,
											   35, 67, 131, 259}			-- ��ų�������� promotion ���� style ���� ������ ��

--------------------------------------------------------------------------------
-- zeustw {
-- ĳ���Ϳ� �´� RentalItemIndex�� ���̱� ���� ĳ������ ���� ���п����� �߰�.
-- ���Ƿ� ĳ������ style * 100 + promotion �� �Ͽ� �ѹ��� ��.
-- common.lua �� ĳ���� ��ȣ�� �ִ� �̰��� �̿��� �� �ִ��� Ȯ������.
-- c�Լ� GetMyCharacterClass() �� ���� ��ȣ�� �޾ƿ´�.
local ClassIndex		  = { ["err"]=0, [0] =
							  001, 002, 004, 003, -- �±ǵ�, ����, ����Ÿ��, ī������
							  102, 101, 103, 104, -- ���η�����, ����, �ձ⵵, �ﺸ
							  005, 006, 007, 008 }     -- ��Ƽ����, ����, ��Ǫ
-- zeustw }
--------------------------------------------------------------------------------
							  
-- ������ ��ư ����ϱ�
for i=0, #RentalSkillBtnName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RentalSkillBtnName[i])
	mywindow:setTexture("Normal",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+117)
	mywindow:setTexture("Hover",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+39)
	mywindow:setTexture("Pushed",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+78)
	mywindow:setTexture("Disabled",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+117)
	mywindow:setTexture("SelectedNormal",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	mywindow:setTexture("SelectedHover",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	mywindow:setTexture("SelectedPushed",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	--mywindow:setPosition(10 , RentalSkillPosY[i])
	mywindow:setPosition(10 , (40*i)+72)
	mywindow:setSize(110, 39)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Rental_Index", RentalItemIndex[i])
	mywindow:setUserString("Rental_Index_Line", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RentalBoxTab")
	winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)
	
	
	-- Ŭ���� ���� ��ư �׵θ�
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", RentalSkillBtnName[i] .. "_YellowLine")
	mywindow:setTexture("Enabled", "UIData/Randombox_003.tga", 0,468)
	mywindow:setPosition(5 , (40*i)+68)
	mywindow:setSize(116, 44)
	mywindow:setScaleWidth(265)
	mywindow:setScaleHeight(265)
	
	if i == 0 then
		mywindow:setVisible(true)
	else
		mywindow:setVisible(false)
	end
	
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Rental_Index", RentalItemIndex[i])
	winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)
end

------------------------------------------------
-- Ŭ���� ��ư Ŭ�� �̺�Ʈ �Լ�
------------------------------------------------
function OnSelect_RentalBoxTab(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local tabIndex	= tonumber(EnterWindow:getUserString("Rental_Index"));
		local LineIndex = tonumber(EnterWindow:getUserString("Rental_Index_Line"));
		
		g_ClassTabIndex = tabIndex;
		
		-- zeustw
		--[[
		--+============================================================+
		-- ** Ŭ���� ��ư ��� �׵θ� �缳��
		for i = 0 , #RentalSkillBtnName do
			winMgr:getWindow(RentalSkillBtnName[i] .. "_YellowLine"):setVisible(false)
		end
		winMgr:getWindow(RentalSkillBtnName[LineIndex] .. "_YellowLine"):setVisible(true)
		--+============================================================+
		--]]
		-- zeustw
		
		
		DebugStr("tabIndex : " .. tabIndex)
		InitRentalSkillPopup()		-- ��Ż ��ų �ʱ�ȭ
		ChangeClassImage(tabIndex)	-- Ŭ���� ������ �̹��� �缳��
		RequestRentalSkillIndex(tabIndex)
		
		SelectFirstCategory()
	end
end


----------------------------------------------------------------------
-- ��Ż ��ų ������ "ī�װ�" ��ư
----------------------------------------------------------------------
local RentalCategoryName = { ["err"]=0, [0] = "RentalCategory_Attack", "RentalCategory_Grap", "RentalCategory_Special", "RentalCategory_TeamAttack" }

local RentalCategortTexY = { ["err"]=0, [0] = 92, 191, 389, 290 } -- Texture Postion Y
local RentalCategortPosX = { ["err"]=0, [0] = 10, 79, 148, 217}	  -- Game Postion X

-- ������ ��ư ����ϱ�
for i=0, #RentalCategoryName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RentalCategoryName[i])
	mywindow:setTexture("Normal",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i])
	mywindow:setTexture("Hover",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+33)
	mywindow:setTexture("Pushed",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("Disabled",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+33)
	mywindow:setTexture("SelectedNormal",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("SelectedHover",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("SelectedPushed",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setPosition(RentalCategortPosX[i] , 25)
	mywindow:setSize(67, 33)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setUserString("RentalCategory_Index", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RentalCategory")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end

function OnSelect_RentalCategory(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local index = tonumber(EnterWindow:getUserString("RentalCategory_Index"))
		
		SelectCategory(index) -- �ε��� �ѱ�. ī�װ� �з� ó��
	end
end

-- Ŭ���� ��� ��ü�� �ҷ����� �ڵ带 �� �����Ͽ� �ڽ��� Ŭ������ �´� �͸�
-- ǥ�����ش�. �� ����� Ȯ���Ǹ� ������ ��� ��ü�� ǥ���ϴ� ��İ� ������
-- �ڵ� �������� �ȴ�.
function ActivateOnlyMyCharacterClass()
	classTabIndex = GetMyCharacterClass()
	
	for i=0, #RentalItemIndex do
		winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
	end
	
	for i=0, #RentalItemIndex do
		if ClassIndex[i] == classTabIndex then
			winMgr:getWindow(RentalSkillBtnName[i]):setPosition(10 , RentalSkillPosY[0])
			winMgr:getWindow(RentalSkillBtnName[i]):setVisible(true)
			winMgr:getWindow(RentalSkillBtnName[i]):setProperty("Selected", "true")
			break
		end
	end
end

-- ���� Ȱ��ȭ�� ī�װ� �� ù��° ī�װ��� �����Ѵ�
function SelectFirstCategory()
	-- class �� category �� �������� ������ ���� ���� ��� invisible�Ǵ� ��찡
	-- �ֱ� ������ category�� ù��°�� visible �Ǿ��ִ� category�� �⺻ �������ش�
	for i=0, #RentalCategoryName do
		if winMgr:getWindow(RentalCategoryName[i]):isVisible() == true then
			winMgr:getWindow(RentalCategoryName[i]):setProperty("Selected", "true")
			
			SelectCategory(i)
			
			break
		end
	end
end







-- ��Ż ��ų �˾�â �ʱ�ȭ
function InitRentalSkillPopup()
	-- �ݱ� ��ư ����
	winMgr:getWindow("SelectRandombox_CloseButton"):setVisible(false)
	
	-- �κ� ����
	winMgr:getWindow("MainBar_Bag"):setEnabled(false)
	
	-- ī�װ� ��ư ���ֱ�
	if g_ClassTabIndex ~= -1 then
		local visibleCount = 0 -- visible �Ǵ� category ������ ���� ��ư ��ġ�� �������� �����ϱ� ����
		for i=0 , #RentalCategoryName do
			local itemCount = RequestRentalSkillIndexCount(g_ClassTabIndex, i);
			
			if itemCount > 0 then
				winMgr:getWindow(RentalCategoryName[i]):setVisible(true)
				winMgr:getWindow(RentalCategoryName[i]):setPosition(RentalCategortPosX[visibleCount], 25)
				visibleCount = visibleCount + 1
			else
				winMgr:getWindow(RentalCategoryName[i]):setVisible(false)
			end
		end
	end
	
	-- ����Ʈâ�� �θ� ����
	winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setTexture("Enabled", "UIData/invisible.tga", 0,0)
	winMgr:getWindow("SelectRandomboxMain"):setWideType(0)
	winMgr:getWindow("SelectRandomboxMain"):setPosition(tRentalPosition[0] , tRentalPosition[1])
	winMgr:getWindow("SelectRandomboxMain"):setVisible(true)
end






-- ��Ż ��ų �˾�â ����
function CloseRentalSkillPopup()
	-- �ݱ� ��ư �����ֱ�
	winMgr:getWindow("SelectRandombox_CloseButton"):setVisible(true)
	
	-- �κ� ���� ����
	winMgr:getWindow("MainBar_Bag"):setEnabled(true)
	
	-- ī�װ� ��ư ����
	for i=0 , #RentalCategoryName do
		winMgr:getWindow(RentalCategoryName[i]):setVisible(false)
	end
	
	
	-- ����Ʈâ�� �θ� �ٽ� �ǵ���
	root:addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setTexture("Enabled", "UIData/Randombox_001.tga", 0,0)
	winMgr:getWindow("SelectRandomboxMain"):setWideType(6)
	winMgr:getWindow("SelectRandomboxMain"):setPosition(tNormalPosition[0] , tNormalPosition[1])
	winMgr:getWindow("SelectRandomboxMain"):setVisible(false)
	
	-- â�ݱ�
	winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(false)
	winMgr:getWindow("RentalSkill_Main"):setVisible(false)
	
	
	-- AutoTake��� ��
	DebugStr("AutoTake��� ��")
	SetAutoTakeFlag(false);
	
end






--*********************************************************
-- function  : RentalSkill_On()
-- Desc      : ��Ż ��ų UI �ѱ� ��
--*********************************************************
function RentalSkill_On()
	DebugStr("RentalSkill_On");
	
	-- �κ��丮 off
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	
	-- �ڽ� �̸� ����( ��Ż, �̺�Ʈ )
	SetBoxName();
	
	-- Ŭ���� ��ư �ʱ�ȭ ( �̼��� ���·�.. )
	for i=0 , #RentalSkillBtnName do
		winMgr:getWindow(RentalSkillBtnName[i]):setProperty("Selected" , "false")
	end
	
	-- ��ų ����â ����
	if winMgr:getWindow("RentalSkill_Main_Alpha"):isVisible() == true then
		winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(false)
		winMgr:getWindow("RentalSkill_Main"):setVisible(false)
		
		for i=0 , #RentalSkillBtnName do
			winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
		end
				
	else
		winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(true)
		winMgr:getWindow("RentalSkill_Main"):setVisible(true)
		
		-- �� ��Ǫ ��ư �ӽ������� ���� ��
		for i=0 , #RentalSkillBtnName do
		--	if i ~= 10 then
				winMgr:getWindow(RentalSkillBtnName[i]):setVisible(true)
		--	else
		--		winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
		--	end
		end
		
		
		InitRentalSkillPopup()			-- UIâ �ʱ�ȭ
		RequestRentalSkillIndex(3,0)	-- Ŭ���� �±ǵ�, ī�װ� Ÿ������ ���� ����
		winMgr:getWindow("RentalCategory_Attack"):setProperty( "Selected" , "true" )	 -- ī�װ� : Ÿ������ ����
		winMgr:getWindow("RentalSkill_TaeKwonDo_Btn"):setProperty( "Selected" , "true" ) -- Ŭ���� : �±ǵ��� ����
	end
	
	ActivateOnlyMyCharacterClass()
	
	
	-------------------------------------------
	-- ** bISAutoTakeMode
	-- 1. �׳� �Ϲ� ��Ż��ųâ?
	-- 2. ���� ����ũ ��Ż��ųâ?
	-------------------------------------------
	local bISAutoTakeMode = GetAutoTakeFlag();
	SetRentalSkillButton(bISAutoTakeMode);
end









----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- Auto Take ��Ż ��ų ����
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

-- ��ư �ɼ� ����
function SetRentalSkillButton(TakeMode)
	-- 1. ������ ���ù�ư ���� ============ ���ιޱ� ��ư ����
	-- 2. ���� ������ �����
	-- 3. ������ �̵� ��ư �̵�
	
	RadioFlag = true;
	
	if TakeMode == true then
		RadioFlag = false;
	end

	
	-- [�ѹ��� �ޱ� ��ư] ����
	winMgr:getWindow("RandomSelectBox_AutoTakeBtn"):setVisible(TakeMode)

	
	-- [������ �̵� ��ư] ����
	if TakeMode == true then
		
		for i = 0 , #RandomSelectBox_BtnName do
			winMgr:getWindow(RandomSelectBox_BtnName[i]):setPosition(RandomSelectBox_BtnPosX[i] - 80 , 375)
		end
		winMgr:getWindow("RandomSelectBox_PageText"):setPosition(188 - 80, 380) -- ������ �ѹ�
		
	else
		
		for i = 0 , #RandomSelectBox_BtnName do
			winMgr:getWindow(RandomSelectBox_BtnName[i]):setPosition(RandomSelectBox_BtnPosX[i], 405)
		end
		winMgr:getWindow("RandomSelectBox_PageText"):setPosition(188, 410) -- ������ �ѹ�
	end
	
	
	-- [���� ���� ��ư] �����
	for j = 0 , MaxCount_OnePage - 1 do
		winMgr:getWindow("RandomSelectBox_SelectBtn_" .. j):setVisible(RadioFlag);
	end
	
	
end






-- �ѹ��� �޾ƿ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "RandomSelectBox_AutoTakeBtn")
mywindow:setTexture("Normal",		"UIData/Randombox_001.tga", 298, 317)
mywindow:setTexture("Hover",		"UIData/Randombox_001.tga", 298, 349)
mywindow:setTexture("Pushed",		"UIData/Randombox_001.tga", 298, 381)
mywindow:setTexture("PushedOff",	"UIData/Randombox_001.tga", 298, 381)
mywindow:setTexture("Disabled",		"UIData/Randombox_001.tga", 298, 381)
mywindow:setPosition(145, 405)
mywindow:setSize(139, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "AutoTakeBtnEvent")
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)

function AutoTakeBtnEvent()
	DebugStr("AutoTakeBtnEvent")
	
	local bClassMatch, bIsRental, bIsLowLevel = GetItemInfo();
	

	-- Rental ��ų�϶���, ������, Ŭ������ ������ �д�
	if bIsRental == true then
		
		-- �ڽ��� Ŭ������ ���� �ʴ� �������� ������ ����
		if bClassMatch == false then
			DebugStr("Ŭ������ ��������")
			ShowNotifyOKMessage(PreCreateString_1089)	--GetSStringInfo(LAN_LUA_COMMON_AB_1)
			return
		end
		
		-- ( Take All�� ������ ���� )
		-- ĳ������ ������ ���Ƽ� ����Ҽ� ����
		--if bIsLowLevel == true then
			--DebugStr("������ ��������")
			--ShowNotifyOKMessage(PreCreateString_4194)	--GetSStringInfo(LAN_LEVEL_NOT_001)
			--return
		--end
		
	end
	
	local sstring = GetClassName(g_ClassTabIndex)
	ShowCommonAlertOkCancelBoxWithFunction("", sstring , "AutoTakeOKEvent", "AutoTakeNoEvent")
end

function AutoTakeOKEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "AutoTakeOKEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	HideSelectRandomBoxSelectWindow() 
	
	RequestAutoTakeRentalSkill(); -- ���ο� Take All ��Ż��ų
	
	HideRandomBoxSelectPopup()
	
end


function AutoTakeNoEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "AutoTakeNoEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end




-- Ŭ���� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkillClassImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
mywindow:setPosition(30 , 405)
mywindow:setSize(89,35)
mywindow:setLayered(true)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)

function ChangeClassImage( tabindex )
	-- �ڵ� �� �ޱ� ��尡 �ƴϸ� �������� �ʴ´�.
	local IsAutoTakeMode = GetAutoTakeFlag();
	if IsAutoTakeMode == false then
		winMgr:getWindow("RentalSkillClassImage"):setVisible(false)
		DebugStr("ChangeClassImage Return")
		return
	end
	
	--local style			= 0 -- 0 : ��Ʈ��Ʈ , 1 : ����
	--local promotion		= 6 -- ���� 1 ~ 4 (5,6 : ��Ƽ,����)��
	--local attribute		= 0 -- 0 : �Ķ�, 0 : ����, 2 : �׸� , 3 : ���
	local style, promotion, attribute = GetClassInfo(tabindex);
	
	
	winMgr:getWindow("RentalSkillClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", 
						tAttributeImgTexXTable[style][attribute],  tAttributeImgTexYTable[style][attribute])	-- �޹��
	winMgr:getWindow("RentalSkillClassImage"):setTexture("Layered",	 "UIData/Skill_up2.tga", 
						promotionImgTexXTable[style],				promotionImgTexYTable[promotion])			-- Ŭ���� �۾�
	
	
	winMgr:getWindow("RentalSkillClassImage"):setScaleWidth(255)
	winMgr:getWindow("RentalSkillClassImage"):setScaleHeight(200)
	winMgr:getWindow("RentalSkillClassImage"):setVisible(true)
end

function RequestAutoTakeReturn(class)
	local sstring = GetClassName2(g_ClassTabIndex)
	ShowNotifyOKMessage(sstring)
end

