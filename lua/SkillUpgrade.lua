--------------------------------------------------------------------
-- SkillUpgrade.lua
--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)



local SkillUpgradeResultBackTexX = {['err']=0, [0]=581, 405}
local CheckOnce = false

-- ��ų ���׷��̵� ���� �̹���.
local SkillUpgradeMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeMainBackImage")
SkillUpgradeMainBackWindow:setTexture("Enabled", "UIData/popup003.tga", 0, 415)
SkillUpgradeMainBackWindow:setWideType(6);
SkillUpgradeMainBackWindow:setPosition(30,80)
SkillUpgradeMainBackWindow:setSize(405, 609)
SkillUpgradeMainBackWindow:setVisible(false)
SkillUpgradeMainBackWindow:setAlwaysOnTop(true) 
SkillUpgradeMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(SkillUpgradeMainBackWindow)

RegistEscEventInfo("SkillUpgradeMainBackImage", "SkillUpgradeCloseEvent")

-- ������ �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_DefenseDownItem")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(23, 510)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(100)
mywindow:setScaleHeight(100)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
--------------------------------------------------------------------
-- ��ų ���׷��̵� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillUpgradeMain_CloseButton")
mywindow:setTexture("Normal", "UIData/popup003.tga", 477, 0)
mywindow:setTexture("Hover", "UIData/popup003.tga", 477, 23)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 477, 46)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 477, 46)
mywindow:setPosition(380, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "SkillUpgradeCloseButtonEvent")
SkillUpgradeMainBackWindow:addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeResultBackImage")
mywindow:setTexture("Enabled", "UIData/popup003.tga", SkillUpgradeResultBackTexX[0], 835)
mywindow:setPosition(115,253)
mywindow:setSize(176, 189)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("SkillUpgradeResultImg", "SkillUpgradePossibleEvent", "alpha", "Linear_EaseNone", 255, 50, 5, true, true, 10);
mywindow:addController("SkillUpgradeResultImg", "SkillUpgradePossibleEvent", "alpha", "Linear_EaseNone", 50, 255, 5, true, true, 10)
SkillUpgradeMainBackWindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeResultBackImage2")
mywindow:setTexture("Enabled", "UIData/popup003.tga", 405, 835)
mywindow:setPosition(115,253)
mywindow:setSize(176, 189)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
local UpgradeTick = 14
for i=0, UpgradeTick do
	local tick = UpgradeTick - i - 6
	if tick < 2 then
		tick = 2
	end
	mywindow:addController("SkillUpgradeResultImg", "SkillUpgradeResultEvent", "alpha", "Linear_EaseNone", 255, 0, tick, true, false, 50)
	mywindow:addController("SkillUpgradeResultImg", "SkillUpgradeResultEvent", "alpha", "Linear_EaseNone", 0, 255, tick, true, false, 50)
end
mywindow:subscribeEvent("MotionEventEnd", "SkillUpgradeResultEventEnd");
SkillUpgradeMainBackWindow:addChildWindow(mywindow)





local tUpgradeitemPosX = {['err']=0, [0] = 64, 245, 154}
local tUpgradeitemPosY = {['err']=0, [0] = 102, 102, 301}

for i=0, #tUpgradeitemPosX do
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Upgradeitem_NameText_"..i)
	mywindow:setPosition(tUpgradeitemPosX[i] + 13, tUpgradeitemPosY[i] - 8)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
		
	-- ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_BackImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(tUpgradeitemPosX[i], tUpgradeitemPosY[i])
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
	-- �˸� �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_NotifyImg_"..i)
	local Idx = i
	if	Idx < 2 then 
		Idx = 0
	end
	mywindow:setTexture("Enabled", "UIData/popup003.tga", 405 + Idx * 74, 761)
	mywindow:setPosition(tUpgradeitemPosX[i] + 13, tUpgradeitemPosY[i] + 13)
	mywindow:setSize(74, 74)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
	-- ��ų ���׷��̵� ���� �ݱ��ư
	if i < 2 then
		mywindow = winMgr:createWindow("TaharezLook/Button", "Erase_SkillSlot"..i)
		mywindow:setTexture("Normal", "UIData/my_room3.tga", 234, 912)
		mywindow:setTexture("Hover", "UIData/my_room3.tga", 234, 931)
		mywindow:setTexture("Pushed", "UIData/my_room3.tga", 234, 950)
		mywindow:setTexture("PushedOff", "UIData/my_room3.tga", 234, 950)
		mywindow:setPosition(tUpgradeitemPosX[i] + 80, tUpgradeitemPosY[i])
		mywindow:setSize(19, 19)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setUserString("Index", i)
		mywindow:subscribeEvent("Clicked", "OnClickSkillUpgradeErase")
		SkillUpgradeMainBackWindow:addChildWindow(mywindow)
		--winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	end
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_MainImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(185)
	mywindow:setScaleHeight(185)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	
--	mywindow:addController("ItemImg", "itemRegistr_Event", "xscale", "Sine_EaseIn", 1000, 157, 3, true, false)
--	mywindow:addController("ItemImg", "itemRegistr_Event", "yscale", "Sine_EaseIn", 1000, 157, 3, true, false)
--	mywindow:addController("ItemImg", "itemRegistr_Event", "alpha", "Sine_EaseIn", 100, 255, 3, true, false)
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	
		
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_GradeImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(58, 12)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Upgradeitem_GradeText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(63, 12)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Upgradeitem_CountText_"..i)
	mywindow:setPosition(18, 13)
	mywindow:setSize(70, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)


	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/Button", "Upgradeitem_Tooltip_"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(90, 90)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_SkillUpgradeInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_SkillUpgradeInfo")
	mywindow:subscribeEvent("Clicked", "OnClickSkillUpgradeErase")	
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	
	
	-- ��ų ���� �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Upgradeitem_PromotionImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(15, 60)
	mywindow:setSize(89, 35)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("Upgradeitem_BackImg_"..i):addChildWindow(mywindow)
	
	
	-- ��ų ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Upgradeitem_KindText_"..i)
	mywindow:setPosition(tUpgradeitemPosX[i] + 13, tUpgradeitemPosY[i] + 95)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
		
	-- �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Upgradeitem_PeriodText_"..i)
	mywindow:setPosition(tUpgradeitemPosX[i] + 13, tUpgradeitemPosY[i] + 111)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	SkillUpgradeMainBackWindow:addChildWindow(mywindow)
	
		
end

winMgr:getWindow("Upgradeitem_MainImg_2"):addController("SkillUpgradeIcon", "SkillUpgradeIconEvent", "alpha", "Linear_EaseNone", 0, 255, 10, true, false, 10);
winMgr:getWindow("Upgradeitem_MainImg_2"):setScaleWidth(185)
winMgr:getWindow("Upgradeitem_MainImg_2"):setScaleHeight(185)

--	������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillUpgrade_FeeText")
mywindow:setPosition(172, 456)
mywindow:setSize(110, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
SkillUpgradeMainBackWindow:addChildWindow(mywindow)


-- ��ȭ�ϱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillUpgrade_Btn")
mywindow:setTexture("Normal", "UIData/popup003.tga", 352, 225)
mywindow:setTexture("Hover", "UIData/popup003.tga", 352, 257)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 352, 289)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 352, 289)
mywindow:setTexture("Disabled", "UIData/popup003.tga", 352, 321)
mywindow:setPosition(137, 564)
mywindow:setSize(132, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "SkillUpgrade_BtnEvent")
SkillUpgradeMainBackWindow:addChildWindow(mywindow)


--	��ȣ�� ī��Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillUpgrade_ProtectCountText")
mywindow:setPosition(149, 512)
mywindow:setSize(110, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends("EVENT", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)	
SkillUpgradeMainBackWindow:addChildWindow(mywindow)



-- ��ȣ�� üũ�ڽ�
mywindow = winMgr:createWindow("TaharezLook/Checkbox", "SkillUpgradeProtectStuffCheckBox")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("SelectedNormal", "UIData/popup003.tga", 627, 805)
mywindow:setTexture("SelectedHover", "UIData/popup003.tga", 627, 805)
mywindow:setTexture("SelectedPushed", "UIData/popup003.tga", 627, 805)
mywindow:setTexture("SelectedPushedOff", "UIData/popup003.tga", 627, 805)
mywindow:setPosition(351, 513)
mywindow:setSize(30, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
CEGUI.toCheckbox(mywindow):setSelected(true)
mywindow:subscribeEvent("CheckStateChanged", "SkillUpgradeProtectStuffCheckBoxEvent")
SkillUpgradeMainBackWindow:addChildWindow(mywindow)


-- ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeBoomImage")
mywindow:setTexture("Disabled", "UIData/powerup.tga", 816, 476)
mywindow:setPosition(126,275)
mywindow:setSize(154, 152)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("SkillUpgradeBoomImg", "SkillUpgradeBoomEvent", "alpha", "Linear_EaseNone", 255, 0, 10, true, false, 10);
mywindow:addController("SkillUpgradeBoomImg", "SkillUpgradeBoomEvent", "xscale", "Linear_EaseNone", 650, 2000, 10, true, false, 10)
mywindow:addController("SkillUpgradeBoomImg", "SkillUpgradeBoomEvent", "yscale", "Linear_EaseNone", 650, 2000, 10, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "xscale", "Sine_EaseIn", 0, 1024, 2, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "yscale", "Quintic_EaseIn", 0, 1024, 2, true, false, 10)
mywindow:subscribeEvent("MotionEventEnd", "SkillUpgradeBoomEventEnd");
SkillUpgradeMainBackWindow:addChildWindow(mywindow)



-- ��ȣ�� üũ�ڽ��� �̺�Ʈ�� ���ö�
function SkillUpgradeProtectStuffCheckBoxEvent(args)
	local MyWindow = CEGUI.toWindowEventArgs(args).window;
	SetProtectItemUse(CEGUI.toCheckbox(MyWindow):isSelected())				
end


-- ��ų ���׷��̵� ���� �ϳ��� �����.
function OnClickSkillUpgradeErase(args)
	local localWindow = CEGUI.toWindowEventArgs(args).window
	local Index = localWindow:getUserString("Index")
	
	DebugStr('OnClickSkillUpgradeErase : ' .. Index)
	EraseSkillSlotItem(Index)
	--Upgrade_RefreshItemList()
	--winMgr:getWindow("Upgradeitem_BackImg_"..Index):setVisible(false)
	--CheckCrafting()
end


-- ���콺 �������� �̺�Ʈ
function MouseEnter_SkillUpgradeInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	if index == -1 then
		return
	end
	local itemKind, itemNumber, attributeType = SkillUpgradeTargetTooltipInfo(index)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	if itemNumber <= 0 then
		return
	end
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
	
	if x + 236 + 52 > g_CURRENT_WIN_SIZEX then
		x = x - 295
	end
	if itemKind == ITEMKIND_SKILL then
	GetToolTipBaseInfo(x + 332, y+5, 2, Kind, index, itemNumber)	-- ������ ���� ������ �������ش�.
	else
	GetToolTipBaseInfo(x + 95, y+5, 2, Kind, index, itemNumber)	-- ������ ���� ������ �������ش�.
	end
	SetShowToolTip(true)
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	if Kind ~= KIND_SKILL then
		return
	end
	
	ReadAnimation(itemNumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(SkillUpgradeMainBackWindow)
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
	ShowAnimationWindow(x+95, y+5)
	SettingAnimationRect(y+54, x+104, 217, 164)

end


-- ���콺 �������� �̺�Ʈ
function MouseLeave_SkillUpgradeInfo(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
end

-- ��ų ���׷��̵� �����Ḧ �����Ѵ�.
function SkillUpgrade_FeeText(fee, event)
	local r,g,b = ColorToMoney(fee)
	
	if event then
		winMgr:getWindow("SkillUpgrade_FeeText"):setTextExtends("EVENT", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)	
	else
		winMgr:getWindow("SkillUpgrade_FeeText"):setTextExtends(CommatoMoneyStr(fee), g_STRING_FONT_DODUMCHE, 12, r,g,b,255,   0, 0,0,0,255)	
	end	
end


-- ���׷��̵� ����̺�Ʈ�� ��������.
function SkillUpgradeResultEventEnd(args)
	winMgr:getWindow("SkillUpgradeBoomImage"):setVisible(true)
	winMgr:getWindow("SkillUpgradeBoomImage"):activeMotion("SkillUpgradeBoomEvent")
	winMgr:getWindow("Upgradeitem_MainImg_2"):activeMotion("SkillUpgradeIconEvent")
	PlayWave('sound/SkillUP_Result.wav');
	ShowSkillUpgradeResult()
end




-- ��ų ��ȭ �ش޶�� ��û�Ѵ�.
function SkillUpgrade_BtnEvent()
	RequestSkillUpgrade()	
end

-- ��ų ��ȭ �� UIó��
function	AfterSkillUpgrade()
	local UpgradeSkillMaxCnt = 2
	for i=0, UpgradeSkillMaxCnt do
		EraseSkillSlotItem(i)
	end
end

-- ��ų��ȭ�� ����Ʈ�� ��������ش�.
function SkillUpgradeMotionStart()
	winMgr:getWindow("SkillUpgradeResultBackImage"):setVisible(false)
	winMgr:getWindow("SkillUpgradeResultBackImage"):clearActiveController()
	winMgr:getWindow("SkillUpgradeResultBackImage2"):setVisible(true)
	winMgr:getWindow("SkillUpgradeResultBackImage2"):activeMotion("SkillUpgradeResultEvent")
end




-- ��ų���׷��̵� ����˾��� �ݾ��ش�.
function SkillUpgradeResultPopupClose()
	winMgr:getWindow("SkillUpgradeResultBackImage2"):setVisible(false)
	winMgr:getWindow("SkillUpgradeResultBackImage2"):clearActiveController()
	
	winMgr:getWindow("SkillUpgradeResultBackImage"):setVisible(true)	
end


-- ��ų ���׷��̵尡 ������ ��Ȳ�϶�
function CheckPossibleSkillUpgrade(bEnable)
	if bEnable then		
		winMgr:getWindow("SkillUpgradeResultBackImage"):setVisible(true)
		winMgr:getWindow("SkillUpgradeResultBackImage"):activeMotion("SkillUpgradePossibleEvent")
		winMgr:getWindow("SkillUpgradeResultBackImage"):setTexture("Enabled", "UIData/popup003.tga", SkillUpgradeResultBackTexX[1], 835)
	else
		winMgr:getWindow("SkillUpgradeResultBackImage"):setVisible(true)
		winMgr:getWindow("SkillUpgradeResultBackImage"):clearActiveController()
		winMgr:getWindow("SkillUpgradeResultBackImage"):setTexture("Enabled", "UIData/popup003.tga", SkillUpgradeResultBackTexX[0], 835)
	end
	winMgr:getWindow("SkillUpgrade_Btn"):setEnabled(bEnable)
end



-- ��ų ���׷��̵� ��ư�� ���� �� �ְ����� ���� ����
function CheckSkillUpgrade_Btn(bEnable)
	winMgr:getWindow("SkillUpgrade_Btn"):setEnabled(bEnable)
end



-- ��ų ���׷��̵� ������ �̹����� ������ ���(���â�� ����ش�)
function SkillUpgradeBoomEventEnd()
	if CheckOnce == false then
		CheckOnce = true
		ShowSkillUpgradeResult()	
	end
end




-- ��ų���׷��̵� â�� �����Ѵ�.
function SettingSkillUpgrade(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute, itemCount, kind, kindText, remainTime)
	winMgr:getWindow("Upgradeitem_NotifyImg_"..index):setVisible(false)
	-- ��ų�̸�
	local aa = SummaryString(g_STRING_FONT_GULIMCHE, 11, itemName, 70)
	winMgr:getWindow("Upgradeitem_NameText_"..index):setTextExtends(aa, g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)

	-- ��ų �̹���
	winMgr:getWindow("Upgradeitem_MainImg_"..index):setVisible(true)
	winMgr:getWindow("Upgradeitem_MainImg_"..index):setTexture("Disabled", itemFileName, 0, 0)

	if itemFileName2 == "" then
		winMgr:getWindow("Upgradeitem_MainImg_"..index):setLayered(false)
	else
		winMgr:getWindow("Upgradeitem_MainImg_"..index):setLayered(true)
		winMgr:getWindow("Upgradeitem_MainImg_"..index):setTexture("Layered", itemFileName2, 0, 0)
	end

	-- ��ų���
	if grade > 0 then
		winMgr:getWindow("Upgradeitem_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("Upgradeitem_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("Upgradeitem_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("Upgradeitem_GradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("Upgradeitem_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("Upgradeitem_GradeText_"..index):setText("")
	end

	-- ������ ����	
	if itemCount > 1 then
		winMgr:getWindow("Upgradeitem_CountText_"..index):setTextExtends("x "..itemCount, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	else
		winMgr:getWindow("Upgradeitem_CountText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	end
	
	if kind == ITEMKIND_SKILL then
		-- ��ų���� ������
		winMgr:getWindow("Upgradeitem_PromotionImg_"..index):setVisible(true)
		winMgr:getWindow("Upgradeitem_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
		winMgr:getWindow("Upgradeitem_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	end
	
	local bb = SummaryString(g_STRING_FONT_GULIMCHE, 11, kindText, 70)
	winMgr:getWindow("Upgradeitem_KindText_"..index):setTextExtends(bb, g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)
	winMgr:getWindow("Upgradeitem_PeriodText_"..index):setTextExtends(PreCreateString_1853.." : "..remainTime, g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
		
end

-- ��ų��ȭ�� ���� �������� ������ �ε����� �޾� �ʱ�ȭ �����ش�
function ClearSkillUpgradeWindowIndex(index)
	
	winMgr:getWindow("Upgradeitem_NameText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)
	winMgr:getWindow("Upgradeitem_MainImg_"..index):setVisible(false)
	winMgr:getWindow("Upgradeitem_GradeImg_"..index):setVisible(false)
	winMgr:getWindow("Upgradeitem_GradeText_"..index):setText("")
	winMgr:getWindow("Upgradeitem_CountText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("Upgradeitem_PromotionImg_"..index):setVisible(false)
	winMgr:getWindow("Upgradeitem_KindText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("Upgradeitem_PeriodText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("Upgradeitem_NotifyImg_"..index):setVisible(true)
	
	winMgr:getWindow("SkillUpgrade_FeeText"):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
end


-- ��ų��ȭ�� ���� �������� ������ �� �ʱ�ȭ �����ش�,
function ClearSkillUpgradeWindow()
	for i=0, #tUpgradeitemPosX do
		winMgr:getWindow("Upgradeitem_NameText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)
		winMgr:getWindow("Upgradeitem_MainImg_"..i):setVisible(false)
		winMgr:getWindow("Upgradeitem_GradeImg_"..i):setVisible(false)
		winMgr:getWindow("Upgradeitem_GradeText_"..i):setText("")
		winMgr:getWindow("Upgradeitem_CountText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("Upgradeitem_PromotionImg_"..i):setVisible(false)
		winMgr:getWindow("Upgradeitem_KindText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("Upgradeitem_PeriodText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("Upgradeitem_NotifyImg_"..i):setVisible(true)
	end
	winMgr:getWindow("SkillUpgrade_FeeText"):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
end


-- �������� ��Ͻ�ų��
function ClickedCommonUpgradeFrameBtn(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))

	SkillUpgradeRegistItem(slotIndex)
end


-- ��ų ���׷��̵�â�� ����ش�.
function ShowSkillUpgradeEvent()
	ClearSkillUpgradeWindow()	-- ui�ʱ�ȭ
	ClearSkillUpgradeData()		-- data�ʱ�ȭ
	SetSkillRegisterCancelBt(false, false)
	root:addChildWindow(SkillUpgradeMainBackWindow)
	SkillUpgradeStart()			-- CommonUpgradeŬ������ ��ų ���׷��̵� ������ �˸�
	SkillUpgradeMainBackWindow:setVisible(true)
	winMgr:getWindow("SkillUpgradeResultBackImage"):setVisible(true)
	local tabTable = {['err']=0, [0] = false, true, false, false, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedCommonUpgradeFrameBtn")	-- ������ ����Ʈ �����
	RegisterProtectItem();		-- ��ų��ȭ ��ȣ���� ������ �ڵ����� ����Ѵ�.
	ProtectItemSetting(true)	-- ��ų��ȭ ��ȣ���� ���� ������ �������ش�.
end



-- ��ų��ȭ ��ȣ�������� ������ �������ش�.
function ProtectItemSetting(bFirstShow)
	-- ��ȣ���� �ִ��� ��û	
	local protectItemCount = FindProtectItem()
	winMgr:getWindow("SkillUpgrade_ProtectCountText"):setTextExtends(tostring(protectItemCount), g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)	
	
	-- ��ȣ�� üũ�ڽ�(ó�� ���������� �������ش�.)
	if bFirstShow then
		CEGUI.toCheckbox(winMgr:getWindow("SkillUpgradeProtectStuffCheckBox")):setSelected(false)	
	end
	if protectItemCount > 0 then
		winMgr:getWindow("SkillUpgradeProtectStuffCheckBox"):setEnabled(true)
	else
		winMgr:getWindow("SkillUpgradeProtectStuffCheckBox"):setEnabled(false)
	end
end

function SetSkillRegisterCancelBt(First, Second)
	winMgr:getWindow("Erase_SkillSlot"..0):setVisible(First)
	winMgr:getWindow("Erase_SkillSlot"..0):setEnabled(First)
	winMgr:getWindow("Erase_SkillSlot"..1):setVisible(Second)
	winMgr:getWindow("Erase_SkillSlot"..1):setEnabled(Second)
end




-- ��ų ���׷��̵�â�� �ݴ´�.(EscŰ �Է�)
function SkillUpgradeCloseEvent()
	VirtualImageSetVisible(false)
	SkillUpgradeMainBackWindow:setVisible(false)
	winMgr:getWindow("Upgradeitem_DefenseDownItem"):setTexture("Enabled", "UIData/invisible.tga" , 0, 0)
	SetShowToolTip(false)
	HideAnimationWindow()	
	SkillUpgradeEnd()			-- CommonUpgradeŬ������ ��ų ���׷��̵� ������ �˸�
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
end


-- ��ų ���׷��̵�â�� �ݴ´�.(��ư�̺�Ʈ)
function SkillUpgradeCloseButtonEvent()
	VirtualImageSetVisible(false)
	SkillUpgradeMainBackWindow:setVisible(false)
	SetShowToolTip(false)
	HideAnimationWindow()	
	SkillUpgradeEnd()			-- CommonUpgradeŬ������ ��ų ���׷��̵� ������ �˸�
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���
	winMgr:getWindow("Upgradeitem_DefenseDownItem"):setTexture("Enabled", "UIData/invisible.tga" , 0, 0)
	TownNpcEscBtnClickEvent()	
end





-- ��ų ���׷��̵� ���â
local tResultUiTexX = {['err']=0, [0] = 0, 366, 366, 366, 366, 366}

--------------------------------------------------------------------
-- ��ų��ȭ ��� �˾�â
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeResultBackAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("SkillUpgradeResultBackAlphaImg", "SkillUpgradeResultOKButtonEvent")		-- Esc�̺�Ʈ
RegistEnterEventInfo("SkillUpgradeResultBackAlphaImg", "SkillUpgradeResultOKButtonEvent")		-- Enter�̺�Ʈ


--------------------------------------------------------------------
-- ��ų��ȭ ������� �� �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpgradeResultMainImg")
mywindow:setTexture("Enabled", "UIData/upgrade001.tga", 366, 0)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
mywindow:setSize(350, 446)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("SkillUpgradeResultBackAlphaImg"):addChildWindow(mywindow)







local tUpgradeResultitemPosX = {['err']=0, [0] = 33, 214}
local tUpgradeResultitemPosY = {['err']=0, [0] = 135, 135}

for i=0, #tUpgradeResultitemPosX do
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_NameText_"..i)
	mywindow:setPosition(tUpgradeResultitemPosX[i] + 13, tUpgradeResultitemPosY[i] - 8)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)
	
		
	-- ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResultitem_BackImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(tUpgradeResultitemPosX[i], tUpgradeResultitemPosY[i])
	mywindow:setSize(74, 74)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)

	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResultitem_MainImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(185)
	mywindow:setScaleHeight(185)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResultitem_MainImg_Seal_"..i)
	mywindow:setTexture("Enabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(185)
	mywindow:setScaleHeight(185)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
		
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResultitem_GradeImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(58, 12)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_GradeText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(63, 12)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_CountText_"..i)
	mywindow:setPosition(18, 13)
	mywindow:setSize(70, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)


	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/Button", "UpgradeResultitem_Tooltip_"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
--	mywindow:subscribeEvent("MouseEnter", "MouseEnter_SkillUpgradeInfo")
--	mywindow:subscribeEvent("MouseLeave", "MouseLeave_SkillUpgradeInfo")
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
	
	-- ��ų ���� �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResultitem_PromotionImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(15, 60)
	mywindow:setSize(89, 35)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("UpgradeResultitem_BackImg_"..i):addChildWindow(mywindow)
	
	
	-- ��ų ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_KindText_"..i)
	mywindow:setPosition(tUpgradeResultitemPosX[i] + 13, tUpgradeResultitemPosY[i] + 95)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)
	
		
	-- �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_PeriodText_"..i)
	mywindow:setPosition(tUpgradeResultitemPosX[i] + 13, tUpgradeResultitemPosY[i] + 111)
	mywindow:setSize(74, 20)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)
	
	
	-- PVP ������ �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_PVP_DamageText_"..i)
	mywindow:setTextColor(87,242,9,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(tUpgradeResultitemPosX[i]-10, tUpgradeResultitemPosY[i] + 151)
	mywindow:setSize(100, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)
	
	
	-- Arcade ������ �ؽ�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_Arcade_DamageText_"..i)
	mywindow:setTextColor(87,242,9,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(tUpgradeResultitemPosX[i]-10, tUpgradeResultitemPosY[i] + 184)
	mywindow:setSize(100, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)
			
end



-- ��� �޼���
mywindow = winMgr:createWindow("TaharezLook/StaticText", "UpgradeResultitem_ResultText")
mywindow:setPosition(0, 370)
mywindow:setSize(350, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��ų��ȭ ��� Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillUpgradeResultOKButton")
mywindow:setTexture("Normal", "UIData/upgrade001.tga", 730, 0)
mywindow:setTexture("Hover", "UIData/upgrade001.tga", 730, 32)
mywindow:setTexture("Pushed", "UIData/upgrade001.tga", 730, 64)
mywindow:setTexture("PushedOff", "UIData/upgrade001.tga", 730, 64)
mywindow:setPosition(122, 401)
mywindow:setSize(105, 32)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "SkillUpgradeResultOKButtonEvent")
winMgr:getWindow("SkillUpgradeResultMainImg"):addChildWindow(mywindow)



function SkillUpgradeResultOKButtonEvent()
	CheckOnce = false
	ClearSkillUpgradeResultInfo()
	RegisterProtectItem();		-- ��ų��ȭ ��ȣ���� ������ �ڵ����� ����Ѵ�.
	ProtectItemSetting(false)
	winMgr:getWindow("SkillUpgradeResultBackAlphaImg"):setVisible(false)
	winMgr:getWindow("CommonUpgrade_skill"):setSelected(true)
	AfterSkillUpgrade()
end



function ShowSkillUpgradeResultUi(resultItemState, resultString)	
	root:addChildWindow(winMgr:getWindow("SkillUpgradeResultBackAlphaImg"))
	winMgr:getWindow("SkillUpgradeResultBackAlphaImg"):setVisible(true)
	
	winMgr:getWindow("SkillUpgradeResultMainImg"):setTexture("Enabled", "UIData/upgrade001.tga", tResultUiTexX[resultItemState], 0)
	
	winMgr:getWindow("UpgradeResultitem_ResultText"):setTextExtends(resultString, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	
end



-- ��ų���׷��̵� ���â�� �������ش�.
function SettingSkillUpgradeResultUi(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute
									, itemCount, kind, kindText, remainTime, resultItemState, bSeal)
	
	-- ��ų�̸�
	local aa = SummaryString(g_STRING_FONT_GULIMCHE, 11, itemName, 70)
	winMgr:getWindow("UpgradeResultitem_NameText_"..index):setTextExtends(aa, g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)

	-- ��ų �̹���
	winMgr:getWindow("UpgradeResultitem_MainImg_"..index):setVisible(true)
	winMgr:getWindow("UpgradeResultitem_MainImg_"..index):setTexture("Disabled", itemFileName, 0, 0)

	if itemFileName2 == "" then
		winMgr:getWindow("UpgradeResultitem_MainImg_"..index):setLayered(false)
	else
		winMgr:getWindow("UpgradeResultitem_MainImg_"..index):setLayered(true)
		winMgr:getWindow("UpgradeResultitem_MainImg_"..index):setTexture("Layered", itemFileName2, 0, 0)
	end

	winMgr:getWindow("UpgradeResultitem_MainImg_Seal_"..index):setVisible(bSeal)
	
	-- ��ų���
	if grade > 0 then
		winMgr:getWindow("UpgradeResultitem_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UpgradeResultitem_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("UpgradeResultitem_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UpgradeResultitem_GradeText_"..index):setText("+"..grade)
		
		local String	= string.format(PreCreateString_2155, tGradeferPersent[grade])
		winMgr:getWindow("UpgradeResultitem_PVP_DamageText_"..index):setText("[PvP Mode]\n"..String.."%")
		String	= string.format(PreCreateString_2155, tGradeferPersent[grade] * 10)
		winMgr:getWindow("UpgradeResultitem_Arcade_DamageText_"..index):setText("[Arcade Mode]\n"..String.."%")
		
	else
		winMgr:getWindow("UpgradeResultitem_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("UpgradeResultitem_GradeText_"..index):setText("")
		winMgr:getWindow("UpgradeResultitem_PVP_DamageText_"..index):setText("")
		winMgr:getWindow("UpgradeResultitem_Arcade_DamageText_"..index):setText("")
	end

	-- ������ ����	
	if itemCount > 1 then
		winMgr:getWindow("UpgradeResultitem_CountText_"..index):setTextExtends("x "..itemCount, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	else
		winMgr:getWindow("UpgradeResultitem_CountText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	end
	
	if kind == ITEMKIND_SKILL then
		-- ��ų���� ������
		winMgr:getWindow("UpgradeResultitem_PromotionImg_"..index):setVisible(true)
		winMgr:getWindow("UpgradeResultitem_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
		winMgr:getWindow("UpgradeResultitem_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	end
	
	local bb = SummaryString(g_STRING_FONT_GULIMCHE, 11, kindText, 70)
	winMgr:getWindow("UpgradeResultitem_KindText_"..index):setTextExtends(bb, g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)
	winMgr:getWindow("UpgradeResultitem_PeriodText_"..index):setTextExtends(PreCreateString_1853.." : "..remainTime, g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	
	
end


function ClearSkillUpgradeResultWindow()
	for i=0, #tUpgradeResultitemPosX do
		winMgr:getWindow("UpgradeResultitem_NameText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,200,50,255,   0, 0,0,0,255)
		winMgr:getWindow("UpgradeResultitem_MainImg_"..i):setVisible(false)
		winMgr:getWindow("UpgradeResultitem_GradeImg_"..i):setVisible(false)
		winMgr:getWindow("UpgradeResultitem_GradeText_"..i):setText("")
		winMgr:getWindow("UpgradeResultitem_CountText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("UpgradeResultitem_PromotionImg_"..i):setVisible(false)
		winMgr:getWindow("UpgradeResultitem_KindText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("UpgradeResultitem_PeriodText_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
		winMgr:getWindow("UpgradeResultitem_PVP_DamageText_"..i):setText("")
		winMgr:getWindow("UpgradeResultitem_Arcade_DamageText_"..i):setText("")
		winMgr:getWindow("UpgradeResultitem_MainImg_Seal_"..i):setVisible(false)
		
	end
	winMgr:getWindow("UpgradeResultitem_ResultText"):setTextExtends("", g_STRING_FONT_DODUMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
end

-- ��ȣ�� ������ �̹��� ����
function SetMyDefenceSkillDownItem(fileName)
	winMgr:getWindow("Upgradeitem_DefenseDownItem"):setTexture("Enabled", fileName , 0, 0)
end


--------------------------------------------------------------------
-- ��ȭ�� �ŷ��Ұ� �˸�â ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'UpgradeSkillConfirmAlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("UpgradeSkillConfirmAlphaImage", "UpgradeSkillCancel")
RegistEnterEventInfo("UpgradeSkillConfirmAlphaImage", "UpgradeSkillOk")


--------------------------------------------------------------------
-- ��ȭ�� �ŷ��Ұ� �˸�â ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'UpgradeSkillConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
winMgr:getWindow('UpgradeSkillConfirmAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- ��ȭ�� �ŷ��Ұ� �˸� �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", 'UpgradeSkillConfirmText');
mywindow:setVisible(true);
mywindow:setEnabled(false)
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:clearTextExtends();
mywindow:setViewTextMode(1);
mywindow:setAlign(7);
mywindow:setAlwaysOnTop(true)
mywindow:setLineSpacing(2);
winMgr:getWindow('UpgradeSkillConfirmImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- ��ư (Ȯ��, ���)
--------------------------------------------------------------------
ButtonName	= {['protecterr']=0, "UpgradeSkillOKButton", "UpgradeSkillCancelButton"}
ButtonTexX	= {['protecterr']=0,		693,	858}
ButtonPosX	= {['protecterr']=0,		4,	169}		
ButtonEvent	= {['protecterr']=0, "UpgradeSkillOk", "UpgradeSkillCancel"}

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
	winMgr:getWindow('UpgradeSkillConfirmImage'):addChildWindow(mywindow)
end

function OnCannotTradableItem(NoticeText)
	DebugStr(NoticeText);
	SkillUpgradeMainBackWindow:setAlwaysOnTop(false)
	winMgr:getWindow('UpgradeSkillConfirmAlphaImage'):setAlwaysOnTop(true)
	winMgr:getWindow('UpgradeSkillConfirmText'):setTextExtends(NoticeText, g_STRING_FONT_DODUMCHE, 12, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow('UpgradeSkillConfirmAlphaImage'):setVisible(true)
end

function UpgradeSkillOk()
	SendRequestsSkillUpgradeOK()
	winMgr:getWindow('UpgradeSkillConfirmAlphaImage'):setVisible(false)
end
function UpgradeSkillCancel()
	winMgr:getWindow('UpgradeSkillConfirmAlphaImage'):setVisible(false)
end
