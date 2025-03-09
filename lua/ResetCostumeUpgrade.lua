--------------------------------------------------------------------
-- �������� �ʱ�ȭ ������
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")




local MAX_ITEMLIST = 5

----------------------------------------------------------------------
-- ���� ���� �ڽ� ����
----------------------------------------------------------------------
local mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ResetCostumeUpgradeAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("ResetCostumeUpgradeAlpha", "HideResetCostumeUpgradeWindow")


----------------------------------------------------------------------
-- ���� ���� �ڽ� ����
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeListMain")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0,0)
mywindow:setPosition(600, (768-438)/2)
mywindow:setSize(296, 438)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeAlpha"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ���� �κ��丮 �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeList_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(270, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideResetCostumeUpgradeWindow")
winMgr:getWindow("ResetCostumeUpgradeListMain"):addChildWindow(mywindow)

mywindow =  winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeListWindow")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0,497)
mywindow:setPosition(4, 39)
mywindow:setSize(70, 21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeListMain"):addChildWindow(mywindow)


for i=0, MAX_ITEMLIST-1 do	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeList_"..i);	
	mywindow:setTexture("Enabled", "UIData/Randombox_001.tga", 0,438)
	mywindow:setSize(284, 55);
	mywindow:setPosition(6, 65 + i * 59);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString('index', tostring(i))
	winMgr:getWindow("ResetCostumeUpgradeListMain"):addChildWindow(mywindow);
	
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeList_ItemImage_"..i)
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
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeList_gradeImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgradeList_gradeText_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setTextColor(255,255,255,255)	
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeList_EventImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ResetCostumeUpgrade")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ResetCostumeUpgrade")
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgradeList_ItemName_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255,200,50,255)	
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
	-- ������ ��Ϲ�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeList_SelectBtn_"..i)
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
	mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeSelectBtnEvent")
	winMgr:getWindow("ResetCostumeUpgradeList_"..i):addChildWindow(mywindow)
	
end


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgradeList_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeListMain"):addChildWindow(mywindow)



-- ������ �¿� ��ư
local ResetCostumeUpgrade_BtnName  = {["err"]=0, [0]="ResetCostumeUpgradeList_LBtn", "ResetCostumeUpgradeList_RBtn"}
local ResetCostumeUpgrade_BtnTexX  = {["err"]=0, [0]=438, 457}
local ResetCostumeUpgrade_BtnPosX  = {["err"]=0, [0]=170, 270}
local ResetCostumeUpgrade_BtnEvent = {["err"]=0, [0]="OnClickResetCostumeUpgrade_PrevPage", "OnClickResetCostumeUpgrade_NextPage"}
for i=0, #ResetCostumeUpgrade_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ResetCostumeUpgrade_BtnName[i])
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", ResetCostumeUpgrade_BtnTexX[i], 1)
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", ResetCostumeUpgrade_BtnTexX[i], 26)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", ResetCostumeUpgrade_BtnTexX[i], 51)
	mywindow:setTexture("PushedOff", "UIData/Randombox_001.tga", ResetCostumeUpgrade_BtnTexX[i], 51)
	mywindow:setPosition(ResetCostumeUpgrade_BtnPosX[i], 387)
	mywindow:setSize(19, 25)
	mywindow:setSubscribeEvent("Clicked", ResetCostumeUpgrade_BtnEvent[i])
	winMgr:getWindow("ResetCostumeUpgradeListMain"):addChildWindow(mywindow)
end


-- �����ۿ� ���콺 ������ �� �̺�Ʈ
function OnMouseEnter_ResetCostumeUpgrade(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("index"))
	local slotIndex, itemnumber = GetResetCostumeUpgradeListToolTipInfo(index, 0)
	local Kind = KIND_COSTUM
	GetToolTipBaseInfo(x + 60, y, 0, KIND_COSTUM, slotIndex, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end


-- �����ۿ��� ���콺 ������ �� �̺�Ʈ
function OnMouseLeave_ResetCostumeUpgrade(args)
	SetShowToolTip(false)

end
	

-- ����Ʈ ������ ������ư Ŭ���� �̺�Ʈ
function OnClickResetCostumeUpgrade_PrevPage(args)
	ResetCostumeUpgradeListPageEvent(0)
	
end


-- ����Ʈ ������ ������ư Ŭ���� �̺�Ʈ
function OnClickResetCostumeUpgrade_NextPage(args)
	ResetCostumeUpgradeListPageEvent(1)
end



-- ������ ��Ϲ�ư Ŭ�� ���� �� �̺�Ʈ
function ResetCostumeUpgradeSelectBtnEvent(args)
	local currentWindow = CEGUI.toWindowEventArgs(args).window
	local index = currentWindow:getUserString("index")	-- ���õ� ��ư �ε���
	
	SettingSelectIndex(index)
	
	-- ������ �ʱ�ȭ �Ͻðڽ��ϱ�? �� ����ش�.
	
end



-- �ڽ�Ƭ ���׷��̵� ���� �����츦 �����ش�.
function ShowResetCostumeUpgradeWindow()
	ShowResetCostumeUpgradeList(1)
	root:addChildWindow(winMgr:getWindow("ResetCostumeUpgradeAlpha"))
	winMgr:getWindow("ResetCostumeUpgradeAlpha"):setVisible(true)	
end


-- �ڽ�Ƭ ���׷��̵� ���� �����츦 �ݴ´�.
function HideResetCostumeUpgradeWindow()
	winMgr:getWindow("ResetCostumeUpgradeAlpha"):setVisible(false)	
end


-- ����Ʈ�� �������� �������ش�.
function SettingCostumeUpgradeList(current, total)
	winMgr:getWindow("ResetCostumeUpgradeList_PageText"):setTextExtends(current.." / "..total, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)	
end


-- ���� �ڽ��� �����۸���Ʈ�� �������ش�.
function SettingResetCostumeUpgradeList(ListIndex, index, itemName, filePath, filePath2, grade)
	
	winMgr:getWindow("ResetCostumeUpgradeList_"..index):setVisible(true)
	-- ������ �̹���
	winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setVisible(true)
	winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setTexture("Disabled", filePath, 0, 0)
	if filePath2 == "" then
		winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setLayered(false)
	else
		winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setLayered(true)
		winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setTexture("Layered", filePath2, 0, 0)
	end
	winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setScaleWidth(112)
	winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..index):setScaleHeight(112)

	if grade > 0 then
		winMgr:getWindow("ResetCostumeUpgradeList_gradeImage_"..index):setVisible(true)
		winMgr:getWindow("ResetCostumeUpgradeList_gradeImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("ResetCostumeUpgradeList_gradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("ResetCostumeUpgradeList_gradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("ResetCostumeUpgradeList_gradeImage_"..index):setVisible(false)
		winMgr:getWindow("ResetCostumeUpgradeList_gradeText_"..index):setText("")
	end
	-- ���� �̺�Ʈ�� ���� �̹���
	winMgr:getWindow("ResetCostumeUpgradeList_EventImg_"..index):setVisible(true)
	-- ������ �̸�
	winMgr:getWindow("ResetCostumeUpgradeList_ItemName_"..index):setText(itemName)
	-- ������ ��Ϲ�ư
	winMgr:getWindow("ResetCostumeUpgradeList_SelectBtn_"..index):setVisible(true)
	
end


-- �ڽ�Ƭ ���׷��̵� ����Ʈ�� Ŭ���� ���ش�
function ClearResetCostumeUpgradeList()
	for i=0, MAX_ITEMLIST-1 do	
		winMgr:getWindow("ResetCostumeUpgradeList_"..i):setVisible(false)
		-- ������ �̹���
		winMgr:getWindow("ResetCostumeUpgradeList_ItemImage_"..i):setVisible(false)
		-- ��ų ���� �׵θ� �̹���
		winMgr:getWindow("ResetCostumeUpgradeList_gradeImage_"..i):setVisible(false)
		-- ��ų���� + ����
		winMgr:getWindow("ResetCostumeUpgradeList_gradeText_"..i):setText("")
		-- ���� �̺�Ʈ�� ���� �̹���
		winMgr:getWindow("ResetCostumeUpgradeList_EventImg_"..i):setVisible(false)
		-- ������ �̸�
		winMgr:getWindow("ResetCostumeUpgradeList_ItemName_"..i):setText("")
		-- ������ ��Ϲ�ư
		winMgr:getWindow("ResetCostumeUpgradeList_SelectBtn_"..i):setVisible(false)
	end
end




----------------------------------------------------------------------
-- ���� ���� �ڽ� ����
----------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ResetCostumeUpgradeMain');
mywindow:setTexture('Enabled', 'UIData/Skill_up.tga', 654,700)
mywindow:setPosition(200, (768-269)/2)
mywindow:setSize(340, 269);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ResetCostumeUpgradeAlpha'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ResetCostumeUpgradeFileImg');
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Layered', 'UIData/invisible.tga', 0, 0)
mywindow:setPosition(139, 81)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(153)
mywindow:setScaleHeight(153)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ResetCostumeUpgradeMain'):addChildWindow(mywindow)


-- ��ų ���� �׵θ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgrade_gradeImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(168, 83)
mywindow:setSize(29, 16)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeMain"):addChildWindow(mywindow)

-- ��ų���� + ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgrade_gradeText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setTextColor(255,255,255,255)	
mywindow:setPosition(174, 83)
mywindow:setSize(40, 20)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeMain"):addChildWindow(mywindow)

-- ���� �̺�Ʈ�� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgrade_EventImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(139, 81)
mywindow:setSize(60, 60)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ResetSelectCostumeUpgrade")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ResetSelectCostumeUpgrade")
winMgr:getWindow("ResetCostumeUpgradeMain"):addChildWindow(mywindow)
	

-- ok��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeOkEvent")
winMgr:getWindow('ResetCostumeUpgradeMain'):addChildWindow(mywindow)

-- cancel ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeCancelEvent")
winMgr:getWindow('ResetCostumeUpgradeMain'):addChildWindow(mywindow)


function OnMouseEnter_ResetSelectCostumeUpgrade(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local slotIndex, itemnumber = GetResetCostumeUpgradeListToolTipInfo(0, 1)
	local Kind = KIND_COSTUM
	
	GetToolTipBaseInfo(x + 70, y, 0, KIND_COSTUM, slotIndex, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)

end


function OnMouseLeave_ResetSelectCostumeUpgrade(args)
	SetShowToolTip(false)

end


function ResetCostumeUpgradeOkEvent(args)
	local slotIndex = GetSelectCostumeIndex()
	if slotIndex >= 0 then
		root:addChildWindow(winMgr:getWindow("ResetCostumeUpgradeConfirmAlpha"))
		winMgr:getWindow("ResetCostumeUpgradeConfirmAlpha"):setVisible(true)	
	end
end


function ResetCostumeUpgradeCancelEvent(args)
	SettingSelectIndex(-1)
end


-- ���õ� �ڽ����� �������ش�.
function SettingSelectResetCostume(filePath, filePath2, grade)
	winMgr:getWindow("ResetCostumeUpgradeFileImg"):setTexture("Disabled", filePath, 0, 0)
	if filePath2 == "" then
		winMgr:getWindow("ResetCostumeUpgradeFileImg"):setLayered(false)
	else
		winMgr:getWindow("ResetCostumeUpgradeFileImg"):setLayered(true)
		winMgr:getWindow("ResetCostumeUpgradeFileImg"):setTexture("Layered", filePath2, 0, 0)
	end
	if grade > 0 then
		winMgr:getWindow("ResetCostumeUpgrade_gradeImage"):setVisible(true)
		winMgr:getWindow("ResetCostumeUpgrade_gradeImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("ResetCostumeUpgrade_gradeText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("ResetCostumeUpgrade_gradeText"):setText("+"..grade)
	else
		winMgr:getWindow("ResetCostumeUpgrade_gradeImage"):setVisible(false)
		winMgr:getWindow("ResetCostumeUpgrade_gradeText"):setText("")
	end
end


-- ���õ� �ڽ�Ƭ�� �������� �ʱ�ȭ �����ش�.
function ClearSelectResetCostume()
	winMgr:getWindow("ResetCostumeUpgradeFileImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ResetCostumeUpgradeFileImg"):setLayered(false)
	winMgr:getWindow("ResetCostumeUpgrade_gradeImage"):setVisible(false)
	winMgr:getWindow("ResetCostumeUpgrade_gradeText"):setText("")
end





-- �ٽ� �ѹ� ���� ������(�ڽ�Ƭ ������ �ʱ�ȭ �Ͻðڽ��ϱ�?)
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ResetCostumeUpgradeConfirmAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("ResetCostumeUpgradeConfirmAlpha", "ResetCostumeUpgradeConfirmCancelEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ResetCostumeUpgradeConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('ResetCostumeUpgradeConfirmAlpha'):addChildWindow(mywindow);

mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgradeConfirmText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2773, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255)	
winMgr:getWindow('ResetCostumeUpgradeConfirmImage'):addChildWindow(mywindow);

-- ok��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeConfirmOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeConfirmOkEvent")
winMgr:getWindow('ResetCostumeUpgradeConfirmImage'):addChildWindow(mywindow)

-- cancel ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeConfirmCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeConfirmCancelEvent")
winMgr:getWindow('ResetCostumeUpgradeConfirmImage'):addChildWindow(mywindow)


-- Ok��ư �̺�Ʈ
function ResetCostumeUpgradeConfirmOkEvent(args)
	winMgr:getWindow("ResetCostumeUpgradeConfirmAlpha"):setVisible(false)
	root:addChildWindow(winMgr:getWindow("ResetCostumeUpgradeConfirmAlpha"))
	RequestResetCostume()
end


-- cancel��ư �̺�Ʈ
function ResetCostumeUpgradeConfirmCancelEvent(args)
	winMgr:getWindow("ResetCostumeUpgradeConfirmAlpha"):setVisible(false)
	SettingSelectIndex(-1)
end




-- �ڽ�Ƭ ���׷��̵� �ʱ�ȭ������ ���â ����

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeResultAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- Esc, EnterŰ ������
RegistEscEventInfo("ResetCostumeUpgradeResultAlpha", "ResetCostumeUpgradeResultEscEvent")



-- ������ ���� ����â�˾�(��Ʈ�ѷ��� �־��ֱ� ���ؼ� ����â�� ���ϵ�� ��� ���ߴ�.)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeResultImagePopup")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX / 2 - 340 / 2), (g_MAIN_WIN_SIZEY / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeResultAlpha"):addChildWindow(mywindow)

-- Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ResetCostumeUpgradeResultOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "ResetCostumeUpgradeResultEscEvent")
winMgr:getWindow("ResetCostumeUpgradeResultImagePopup"):addChildWindow(mywindow)


-- ���� �̹��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeResultImageBack")
mywindow:setTexture("Enabled", "UIData/my_room3.tga", 545, 848)
mywindow:setTexture("Disabled", "UIData/my_room3.tga", 545, 848)
mywindow:setPosition(38, 62)
mywindow:setSize(269, 176)
mywindow:setVisible(true)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeResultImagePopup"):addChildWindow(mywindow)

-- ����(�̹���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResetCostumeUpgradeResultImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(124, 87)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(220)
mywindow:setScaleHeight(230)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ResetCostumeUpgradeResultImagePopup"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResetCostumeUpgradeResultText")
mywindow:setPosition(38, 203)
mywindow:setSize(269, 30)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("ResetCostumeUpgradeResultImagePopup"):addChildWindow(mywindow)



function ShowResetCostumeUpgradeResultWnd(fileName, fileName2)
	root:addChildWindow(winMgr:getWindow("ResetCostumeUpgradeResultAlpha"))
	winMgr:getWindow("ResetCostumeUpgradeResultAlpha"):setVisible(true)
		
	winMgr:getWindow("ResetCostumeUpgradeResultImage"):setTexture("Disabled", fileName, 0, 0)
	if fileName2 == "" then
		winMgr:getWindow("ResetCostumeUpgradeResultImage"):setLayered(false)
	else
		winMgr:getWindow("ResetCostumeUpgradeResultImage"):setLayered(true)
		winMgr:getWindow("ResetCostumeUpgradeResultImage"):setTexture("Layered", fileName2, 0, 0)
	end
	winMgr:getWindow("ResetCostumeUpgradeResultText"):setTextExtends(PreCreateString_2774, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)		
		
end



function ResetCostumeUpgradeResultEscEvent()
	winMgr:getWindow("ResetCostumeUpgradeResultAlpha"):setVisible(false)
end
