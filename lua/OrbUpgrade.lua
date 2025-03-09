--------------------------------------------------------------------
-- OrbUpgrade.h
--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
--------------------------------------------------------------------
-- orb���׷��̵� 
--------------------------------------------------------------------




local Max_OrbUpgradeCount = 5	-- orb���׷��̵�� ���� orb����


--------------------------------------------------------------------
-- ORB ���׷��̵� ���� �̹���.
--------------------------------------------------------------------
local ORBUpgradeMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "ORBUpgradeMainBackImage")
ORBUpgradeMainBackWindow:setTexture("Enabled", "UIData/popup003.tga", 674, 0)
ORBUpgradeMainBackWindow:setWideType(6)
ORBUpgradeMainBackWindow:setPosition(30,180)
ORBUpgradeMainBackWindow:setSize(350, 407)
ORBUpgradeMainBackWindow:setVisible(false)
ORBUpgradeMainBackWindow:setAlwaysOnTop(true)
ORBUpgradeMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(ORBUpgradeMainBackWindow)

RegistEscEventInfo("ORBUpgradeMainBackImage", "ORBUpgradeCloseEvent")


--------------------------------------------------------------------
-- orb ���׷��̵� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbUpgrade_CloseButton")
mywindow:setTexture("Normal", "UIData/popup003.tga", 477, 0)
mywindow:setTexture("Hover", "UIData/popup003.tga", 477, 23)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 477, 46)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 477, 46)
mywindow:setPosition(320, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OrbUpgradeCloseButtonEvent")
ORBUpgradeMainBackWindow:addChildWindow(mywindow)



--------------------------------------------------------------------
-- orb���׷��̵� �Ҹ�ŭ �����츦 ������ش�.
--------------------------------------------------------------------
for i=0, Max_OrbUpgradeCount-1 do

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgrade_ConditionImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(-5 + 65*i, 79)
	mywindow:setSize(100, 100)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(130)
	mywindow:setScaleHeight(130)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	ORBUpgradeMainBackWindow:addChildWindow(mywindow)

end

--------------------------------------------------------------------
-- ORB effect 
--------------------------------------------------------------------
local ORBUpgradeEffectBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "ORBUpgradeEffectBackImage")
ORBUpgradeEffectBackWindow:setTexture("Enabled", "UIData/invisible.tga", 674, 0)
ORBUpgradeEffectBackWindow:setWideType(6)
ORBUpgradeEffectBackWindow:setPosition(30,180)
ORBUpgradeEffectBackWindow:setSize(350, 300)
ORBUpgradeEffectBackWindow:setVisible(false)
ORBUpgradeEffectBackWindow:setAlwaysOnTop(true)
ORBUpgradeEffectBackWindow:setZOrderingEnabled(false)
--root:addChildWindow(ORBUpgradeEffectBackWindow)


--------------------------------------------------------------------
-- orb effect
--------------------------------------------------------------------
for i=0, Max_OrbUpgradeCount-1 do

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgrade_effect_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(65*i+10, 79)
	mywindow:setSize(100, 100)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(170)
	mywindow:setScaleHeight(170)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("OrbEffect2", "OrbEffect2", "x", "Linear_EaseNone", -5 + 65*i, -5 + 65*2, 5, true, false, 10)
	ORBUpgradeEffectBackWindow:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgrade_ItemEffect_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Disabled", "UIData/debug_B.tga", 0,0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:addController("OrbEffect", "OrbEffect", "y", "Linear_EaseNone", 0, 178, 5, true, false, 10)
	if i == 4 then
		mywindow:subscribeEvent("MotionEventEnd", "OrbEffectEnd");
	end
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("OrbUpgrade_effect_"..i):addChildWindow(mywindow)
	

end

function StartOrbEffect(FileName)
	root:addChildWindow(ORBUpgradeEffectBackWindow)
	ORBUpgradeEffectBackWindow:setVisible(true)
	PlayWave('sound/ORB_Move.wav');
	for i=0, Max_OrbUpgradeCount-1 do
		winMgr:getWindow("OrbUpgrade_ItemEffect_"..i):setTexture("Disabled", FileName, 0,0)
		winMgr:getWindow("OrbUpgrade_effect_"..i):clearActiveController();
		winMgr:getWindow("OrbUpgrade_ItemEffect_"..i):clearActiveController();
		winMgr:getWindow("OrbUpgrade_effect_"..i):activeMotion('OrbEffect2')	
		winMgr:getWindow("OrbUpgrade_ItemEffect_"..i):activeMotion('OrbEffect')	
	end
end

-- orb���׷��̵尡 �Ϸ������ ����ش�
function OrbEffectEnd()
	winMgr:getWindow("OrbUpgradeResultAlpha"):setVisible(true)
end

--------------------------------------------------------------------
-- orb���׷��̵�� ������ ����� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgrade_ResultImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(126, 195)
mywindow:setSize(100, 100)
mywindow:setAlign(8)
mywindow:setScaleWidth(140)
mywindow:setScaleHeight(140)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:addController("SkillUpgradeResultImg", "SkillUpgradePossibleEvent", "alpha", "Linear_EaseNone", 255, 50, 5, true, true, 10);
--mywindow:addController("SkillUpgradeResultImg", "SkillUpgradePossibleEvent", "alpha", "Linear_EaseNone", 50, 255, 5, true, true, 10)
ORBUpgradeMainBackWindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- orb ���׷��̵� ��ȭ ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbUpgrade_ActionButton")
mywindow:setTexture("Normal", "UIData/popup003.tga", 352, 0)
mywindow:setTexture("Hover", "UIData/popup003.tga", 352, 30)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 352, 60)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 352, 60)
mywindow:setTexture("Disabled", "UIData/popup003.tga", 352, 90)
mywindow:setPosition(126, 360)
mywindow:setSize(100, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OrbUpgradeActionButtonEvent")
ORBUpgradeMainBackWindow:addChildWindow(mywindow)




--------------------------------------------------------------------
-- orb ���׷��̵� ��ȭ��ư �̺�Ʈ
--------------------------------------------------------------------
function OrbUpgradeActionButtonEvent(args)
	UpgradeOrbStart()
	--StartOrbEffect()
	for i=0, Max_OrbUpgradeCount-1 do
		ClearOrbUpgradeInfo()
	end
end




--------------------------------------------------------------------
-- orb���׷��̵� �̹����� �������ش�.
--------------------------------------------------------------------
function SettingOrbUpgradeImg(itemName, itemFileName, itemFileName2)
	
	for i=0, Max_OrbUpgradeCount-1 do
		winMgr:getWindow("OrbUpgrade_ConditionImg_"..i):setTexture("Disabled", itemFileName, 0,0)
	end

	winMgr:getWindow("OrbUpgrade_ResultImg"):setVisible(true)
	local tabTable = {['err']=0, [0] = false, false, false, true, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbUpgradeFrameBtn")	-- ������ ���â�� ����ش�.
end



-- ��ų ���׷��̵尡 ������ ��Ȳ�϶�
function CheckPossibleOrbUpgrade(bEnable)

end


--------------------------------------------------------------------
-- �������� ��Ͻ�ų��
--------------------------------------------------------------------
function ClickedOrbUpgradeFrameBtn(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))
	UpgradeOrbRegist(slotIndex)	-- �������� ������ش�.
end


--------------------------------------------------------------------
-- orb���׷��̵� ������ �ʱ�ȭ���ش�.
--------------------------------------------------------------------
function ClearOrbUpgradeInfo()
	for i=0, Max_OrbUpgradeCount-1 do
		winMgr:getWindow("OrbUpgrade_ConditionImg_"..i):setTexture("Disabled","UIData/invisible.tga" , 0,0)
	end
end




--------------------------------------------------------------------
-- orb ���׷��̵�â�� ����ش�.
--------------------------------------------------------------------
function ShowOrbUpgradeEvent()

	ORBUpgradeMainBackWindow:setVisible(true)
	-- ������ ����Ʈ �����
	local tabTable = {['err']=0, [0] = false, false, false, true, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbUpgradeFrameBtn")	-- ������ ���â�� ����ش�.
end


--------------------------------------------------------------------
-- orb���׷��̵�â�� �����ش�.
--------------------------------------------------------------------
function ORBUpgradeCloseEvent()
	VirtualImageSetVisible(false)
	CancelOrbUpgrade()
	ORBUpgradeEffectBackWindow:setVisible(false)
	ORBUpgradeMainBackWindow:setVisible(false)
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
end



--------------------------------------------------------------------
-- orb���׷��̵�â�� �����ش�.(��ư Ŭ���� �߻��Ѵ�.)
--------------------------------------------------------------------
function OrbUpgradeCloseButtonEvent()
	VirtualImageSetVisible(false)
	CancelOrbUpgrade()
	ORBUpgradeEffectBackWindow:setVisible(false)
	ORBUpgradeMainBackWindow:setVisible(false)
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
	TownNpcEscBtnClickEvent()
end






--------------------------------------------------------------------
-- ORB �ڽ�Ƭ��ȭ ���� �̹���.
--------------------------------------------------------------------
local ORBEquipMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "ORBEquipMainBackImage")
ORBEquipMainBackWindow:setTexture("Enabled", "UIData/popup003.tga", 0, 0)
ORBEquipMainBackWindow:setWideType(6)
ORBEquipMainBackWindow:setPosition(30,180)
ORBEquipMainBackWindow:setSize(352, 410)
ORBEquipMainBackWindow:setVisible(false)
ORBEquipMainBackWindow:setAlwaysOnTop(true)
ORBEquipMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(ORBEquipMainBackWindow)

RegistEscEventInfo("ORBEquipMainBackImage", "ORBEquipCloseEvent")

--------------------------------------------------------------------
-- orb �ڽ�Ƭ��ȭ Orb����̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbEquip_ConditionImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(142, 210)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(170)
mywindow:setScaleHeight(170)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
ORBEquipMainBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- orb �ڽ�Ƭ��� ����̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbEquipCostume_ConditionImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(39, 99)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(128)
mywindow:setScaleHeight(128)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
ORBEquipMainBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- orb �ڽ�Ƭ��ȭ �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbEquip_CloseButton")
mywindow:setTexture("Normal", "UIData/popup003.tga", 477, 0)
mywindow:setTexture("Hover", "UIData/popup003.tga", 477, 23)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 477, 46)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 477, 46)
mywindow:setPosition(320, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OrbEquipCloseButtonEvent")
ORBEquipMainBackWindow:addChildWindow(mywindow)
	
--------------------------------------------------------------------
-- orb ���׷��̵� ��ȭ ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbEquip_ActionButton")
mywindow:setTexture("Normal", "UIData/popup003.tga", 352, 0)
mywindow:setTexture("Hover", "UIData/popup003.tga", 352, 30)
mywindow:setTexture("Pushed", "UIData/popup003.tga", 352, 60)
mywindow:setTexture("PushedOff", "UIData/popup003.tga", 352, 60)
mywindow:setTexture("Disabled", "UIData/popup003.tga", 352, 90)
mywindow:setPosition(126, 365)
mywindow:setSize(100, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OrbEquipActionButtonEvent")
ORBEquipMainBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- orb ���� ��ư �̺�Ʈ
--------------------------------------------------------------------
function OrbEquipActionButtonEvent(args)
	EquipOrbStart()
end

--------------------------------------------------------------------
-- orb �ڽ�Ƭ��ȭâ�� �����ش�.
--------------------------------------------------------------------
function ORBEquipCloseEvent()
	VirtualImageSetVisible(false)
	ORBEquipMainBackWindow:setVisible(false)
	CancelOrbEquip()
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
	--TownNpcEscBtnClickEvent()
end


--------------------------------------------------------------------
-- orb �ڽ�Ƭ��ȭâ �����ش�.(��ư Ŭ���� �߻��Ѵ�.)
--------------------------------------------------------------------
function OrbEquipCloseButtonEvent()
	VirtualImageSetVisible(false)
	ORBEquipMainBackWindow:setVisible(false)
	CancelOrbEquip()
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
	TownNpcEscBtnClickEvent()
end

--------------------------------------------------------------------
-- orb �ڽ�Ƭ��ȭâ�� ����ش�.
--------------------------------------------------------------------
function ShowOrbEquipEvent()

	ORBEquipMainBackWindow:setVisible(true)
	-- ������ ����Ʈ �����
	local tabTable = {['err']=0, [0] = true, false, false, true, true}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbEquipFrameBtn")	-- ������ ���â�� ����ش�.
end

--------------------------------------------------------------------
-- �������� ��Ͻ�ų��
--------------------------------------------------------------------
function ClickedOrbEquipFrameBtn(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))
	DebugStr('slotIndex:'..slotIndex)
	EquipOrbRegist(slotIndex)	-- �������� ������ش�.
end


--------------------------------------------------------------------
-- orb���� �̹����� �������ش�.
--------------------------------------------------------------------
function SettingOrbEquipImg(itemName, itemFileName, itemFileName2)
	winMgr:getWindow("OrbEquip_ConditionImg"):setTexture("Enabled", itemFileName, 0,0)
	local tabTable = {['err']=0, [0] = true, false, false, true, true}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbEquipFrameBtn")	-- ������ ���â�� ����ش�.
end

--------------------------------------------------------------------
-- orb���� �̹����� �������ش�.
--------------------------------------------------------------------
function SettingCostumeEquipImg(itemName, itemFileName, itemFileName2)
	winMgr:getWindow("OrbEquipCostume_ConditionImg"):setTexture("Enabled", itemFileName, 0,0)
	local tabTable = {['err']=0, [0] = true, false, false, true, true}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbEquipFrameBtn")	-- ������ ���â�� ����ش�.
end


-- ����, ������ �̸�, �̹������, �ڽ�Ƭ ����, �Ⱓ,
local tCostumEquipResultInfo	= {['err'] = 0, -1, "", "", -1, ""}			-- �ڽ�Ƭ ���׷��̵� ����� ������ ����
local tCostumEquipResultStat	= {['err'] = 0, -1, -1, -1, -1, -1, -1, -1}	-- �ڽ�Ƭ ���׷��̵� ����� ������ ����


--------------------------------------------------------------------
-- orb���׷��̵� ������ �ʱ�ȭ���ش�.
--------------------------------------------------------------------
function ClearOrbEquipInfo()
	winMgr:getWindow("OrbEquip_ConditionImg"):setTexture("Enabled","UIData/invisible.tga" , 0,0)
	winMgr:getWindow("OrbEquipCostume_ConditionImg"):setTexture("Enabled","UIData/invisible.tga" , 0,0)
	winMgr:getWindow("OrbDettachItemImg"):setTexture("Enabled", "UIData/invisible.tga" , 0,0)
	winMgr:getWindow("OrbDettachItemImg"):setTexture("Disabled", "UIData/invisible.tga" , 0,0)
end

function ClearOrbEquipCostumeInfo()
	winMgr:getWindow("OrbEquipCostume_ConditionImg"):setTexture("Enabled","UIData/invisible.tga" , 0,0)
end

--------------------------------------------------------------------
-- �ڽ�Ƭ��ȭ ��� �˾�â
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbEquipCostumUpBackAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("OrbEquipCostumUpBackAlphaImg", "OrbEquipCostumUpResultOKButtonEvent")		-- Esc�̺�Ʈ
RegistEnterEventInfo("OrbEquipCostumUpBackAlphaImg", "OrbEquipCostumUpResultOKButtonEvent")		-- Enter�̺�Ʈ

-- ��ų��ȭ ���� �� �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbEquipCostumUpResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 0, 182)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 0, 182)
mywindow:setWideType(6)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 296) / 2, (g_MAIN_WIN_SIZEY - 300) / 2)
mywindow:setSize(296, 283)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "OrbEquipCostumUpgradeResultRender")
winMgr:getWindow("OrbEquipCostumUpBackAlphaImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "OrbEquipCostumUpResultOKButton")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 684)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 713)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 742)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 742)
mywindow:setPosition(5, 249)
mywindow:setSize(286, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "OrbEquipCostumUpResultOKButtonEvent")
winMgr:getWindow("OrbEquipCostumUpResultMainImg"):addChildWindow(mywindow)


function OrbEquipCostumUpResultOKButtonEvent(args)
	winMgr:getWindow("OrbEquipCostumUpBackAlphaImg"):setVisible(false)
end


-- �ڽ�Ƭ orb���� ��� ������ ���� �޾ƿ´�.
function CostumEquipResult(level, name, filename, kind, time, stat1, stat2, stat3, stat4, stat5, stat6, stat7)

	tCostumEquipResultInfo[1]	= level	-- ������ ����
	tCostumEquipResultInfo[2]	= name	-- ������ �̸�
	tCostumEquipResultInfo[3]	= filename	-- ������ ���� ���
	tCostumEquipResultInfo[4]	= kind	-- ������ �ڽ�Ƭ ���� �ε���
	tCostumEquipResultInfo[5]	= time	-- ������ ���Ⱓ.
	
	-- ���� ���� ����
	tCostumEquipResultStat[1]	= stat1	-- ������ ���Ⱓ.
	tCostumEquipResultStat[2]	= stat2	-- ������ ���Ⱓ.
	tCostumEquipResultStat[3]	= stat3	-- ������ ���Ⱓ.
	tCostumEquipResultStat[4]	= stat4	-- ������ ���Ⱓ.
	tCostumEquipResultStat[5]	= stat5	-- ������ ���Ⱓ.
	tCostumEquipResultStat[6]	= stat6	-- ������ ���Ⱓ.
	tCostumEquipResultStat[7]	= stat7	-- ������ ���Ⱓ.
	
	winMgr:getWindow("OrbEquipCostumUpBackAlphaImg"):setVisible(true)
end


													--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------
ORBMR_String_1		= PreCreateString_1841	--GetSStringInfo(LAN_LUA_MYROOM_1)		-- ����
ORBMR_String_2		= PreCreateString_1842	--GetSStringInfo(LAN_LUA_MYROOM_2)		-- ����
ORBMR_String_3		= PreCreateString_1843	--GetSStringInfo(LAN_LUA_MYROOM_3)		-- �尩
ORBMR_String_4		= PreCreateString_1844	--GetSStringInfo(LAN_LUA_MYROOM_4)		-- �Ź�
ORBMR_String_5		= PreCreateString_1845	--GetSStringInfo(LAN_LUA_MYROOM_5)		-- ��
ORBMR_String_6		= PreCreateString_1846	--GetSStringInfo(LAN_LUA_MYROOM_6)		-- ���
ORBMR_String_7		= PreCreateString_1847	--GetSStringInfo(LAN_LUA_MYROOM_7)		-- ��
ORBMR_String_8		= PreCreateString_1848	--GetSStringInfo(LAN_LUA_MYROOM_8)		-- ���
ORBMR_String_9		= PreCreateString_1849	--GetSStringInfo(LAN_LUA_MYROOM_9)		-- ����
ORBMR_String_10		= PreCreateString_1850	--GetSStringInfo(LAN_LUA_MYROOM_10)		-- ��Ʈ
ORBMR_String_11		= PreCreateString_1852	--GetSStringInfo(LAN_LUA_MYROOM_11)		-- �ڽ�Ƭ ����
ORBMR_String_12		= PreCreateString_1853	--GetSStringInfo(LAN_LUA_MYROOM_12)		-- �Ⱓ
ORBMR_String_71		= PreCreateString_2080	--GetSStringInfo(LAN_ENABLE_REFORM_COUNT)			-- ���� ����Ƚ��
ORBMR_String_72		= PreCreateString_2114	--GetSStringInfo(LAN_COMPLETE_COSTUM_REFORM)	-- �ڽ�Ƭ ������ �Ϸ�Ǿ����ϴ�.
ORBMR_String_73		= PreCreateString_2117	--GetSStringInfo(LAN_COSTUM_REFORM_WARNING)			-- ���� ����Ƚ��

--"����", "����", "�尩", "�Ź�", "��", "���", "��", "���", "����"}
local	tCostumKind = {['protecterr'] = 0, PreCreateString_1841, ORBMR_String_2, ORBMR_String_3, ORBMR_String_4, ORBMR_String_5,
													ORBMR_String_6, ORBMR_String_7, ORBMR_String_8, ORBMR_String_9, ORBMR_String_10}

--------------------------------------------------------------------
-- �ڽ�Ƭ ���� ��Ʈ������
--------------------------------------------------------------------
function CostumKindStringOrb(KindIndex)
	local CostumString	= ""
	if 1 <= KindIndex and KindIndex <= 10 then
		CostumString = tCostumKind[KindIndex]
	else
		CostumString = ""
	end
	
	return ORBMR_String_11.." : "..CostumString
end



-- �ڽ�Ƭ ���׷��̵� ��� �����κ�
function OrbEquipCostumUpgradeResultRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	_drawer:drawText("Lv."..tCostumEquipResultInfo[1], 22, 61)		-- ����

	local Size = GetStringSize(g_STRING_FONT_GULIM, 11, tCostumEquipResultInfo[2])
	_drawer:drawText(tCostumEquipResultInfo[2], 70 - Size / 2, 80)		-- ������ �̸�
	
	_drawer:drawTexture("UIData/ItemUIData/"..tCostumEquipResultInfo[3], 21, 96, 100, 100, 0, 0)		-- ������ �̹���
	
	-- ������ ����
	local CostumkindStr	= CostumKindStringOrb(tCostumEquipResultInfo[4])
	_drawer:setFont(g_STRING_FONT_GULIM, 10)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 10, CostumkindStr)	
	_drawer:drawText(CostumkindStr, 67 - (Size / 2) + 4, 202)	
	
	-- �Ⱓ
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	Size = GetStringSize(g_STRING_FONT_GULIM, 11, ORBMR_String_12.." : "..tCostumEquipResultInfo[5])	
	_drawer:drawText(ORBMR_String_12.." : "..tCostumEquipResultInfo[5], 66 - (Size / 2) + 4, 220)	


	-- ����

	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	_drawer:drawText(ORBMR_String_72, 143, 60)		-- �������� ��������
	
	
	local Stat_count	= 0
	local String		= ""
	
	local Stat1	= ""
	local	aa	= 0
	local	bb	= 0
	
	_drawer:setTextColor(87,242,14,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	
	for i = 1, #tCostumEquipResultStat do
		if tCostumEquipResultStat[i] ~= 0 then
			if i == 3 then
				aa	= tCostumEquipResultStat[i] / 10
				bb	= tCostumEquipResultStat[i] % 10
				Stat1 = tostring(aa).."."..bb				
			else				
				Stat1 = tostring(tCostumEquipResultStat[i])				
			end
			
			local SignString = ""
			if tCostumEquipResultStat[i] > 0 then
				SignString = "+"
				String = tStatNameText[i]..SignString..Stat1
			else
				String = tStatNameText[i]..SignString..Stat1
			end
			
			_drawer:drawText(String, 143, 130 + (Stat_count - 1) * 20)
			
			Stat_count	= Stat_count + 1
		end
	end
end


--------------------------------------------------------------------
-- ���Ƚ� ���׷��̵� ��� �˾�â
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgradeResultAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("OrbUpgradeResultAlpha", "CloseOrbUpgradeResultAlpha")		-- Esc�̺�Ʈ
RegistEnterEventInfo("OrbUpgradeResultAlpha", "CloseOrbUpgradeResultAlpha")		-- Enter�̺�Ʈ


-- ���Ƚ� ���׷��̵� ���â ����������.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgradeResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 474, 455)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 474, 455)
mywindow:setWideType(6)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 296) / 2, (g_MAIN_WIN_SIZEY - 300) / 2)
mywindow:setSize(342, 283)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "OrbUpgradeResultRender")
winMgr:getWindow("OrbUpgradeResultAlpha"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "OrbUpgradeResultOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(5, 249)
mywindow:setSize(331, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CloseOrbUpgradeResultAlpha")
winMgr:getWindow("OrbUpgradeResultMainImg"):addChildWindow(mywindow)

for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgradeResultImg"..i)
	mywindow:setTexture("Enabled", "UIData/powerup.tga", 738, 298)
	mywindow:setTexture("Disabled", "UIData/powerup.tga", 738, 298)
	mywindow:setPosition(25 + (i - 1) * 190, 115)
	mywindow:setSize(103, 99)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("OrbUpgradeResultMainImg"):addChildWindow(mywindow)
end

-- ���Ƚ� ���׷��̵� ���â ȭ��ǥ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgradeResultArrow")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 738, 397)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 738, 397)
mywindow:setPosition(120, 134)
mywindow:setSize(103, 57)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("OrbUpgradeResultMainImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbUpgradeResultMsg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 531, 382)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 531, 402)
mywindow:setPosition(132, 56)
mywindow:setSize(70, 20)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setScaleWidth(300)
mywindow:setScaleHeight(300)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("OrbUpgradeResultMainImg"):addChildWindow(mywindow)

tOrbResultWindow = {['err'] = 0, "", "", "", ""}
--
function ShowOrbResult(BeforeName ,Name, FileName, Index)
	if Index == 1 then	-- ����
		-- ȭ��ǥ
		winMgr:getWindow("OrbUpgradeResultArrow"):setTexture("Enabled", "UIData/powerup.tga", 841, 397)
		winMgr:getWindow("OrbUpgradeResultArrow"):setTexture("Disabled", "UIData/powerup.tga", 841, 397)
		-- �޼���
		winMgr:getWindow("OrbUpgradeResultMsg"):setTexture("Enabled", "UIData/powerup.tga", 531, 382)
		winMgr:getWindow("OrbUpgradeResultMsg"):setTexture("Disabled", "UIData/powerup.tga", 531, 382)
		
		
	elseif Index == 0 then	-- ����
		-- ȭ��ǥ
		winMgr:getWindow("OrbUpgradeResultArrow"):setTexture("Enabled", "UIData/powerup.tga", 738, 397)
		winMgr:getWindow("OrbUpgradeResultArrow"):setTexture("Disabled", "UIData/powerup.tga", 738, 397)
		-- �޼���
		winMgr:getWindow("OrbUpgradeResultMsg"):setTexture("Enabled", "UIData/powerup.tga", 531, 402)
		winMgr:getWindow("OrbUpgradeResultMsg"):setTexture("Disabled", "UIData/powerup.tga", 531, 402)
	end
	tOrbResultWindow[1] = BeforeName
	tOrbResultWindow[3] = Name
	tOrbResultWindow[4] = FileName	
	
	StartOrbEffect(FileName)
	--winMgr:getWindow("OrbUpgradeResultAlpha"):setVisible(true)
end


function OrbUpgradeResultRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	
	-- ��
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 12, tOrbResultWindow[1])
	_drawer:drawText(tOrbResultWindow[1], 76 - Size / 2, 97)		-- ����
	
	_drawer:setTextColor(255,255,255,255)
	_drawer:drawText("x 5", 104, 120)		-- ����

	_drawer:drawTexture(tOrbResultWindow[4], 28, 115, 100, 100, 0, 0)		-- ������ �̹���

	-- ��
	_drawer:setTextColor(255,198,30,255)
	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tOrbResultWindow[3])
	_drawer:drawText(tOrbResultWindow[3], 265 - Size / 2, 97)		-- ����

	_drawer:setTextColor(255,255,255,255)
	_drawer:drawText("x 1", 295, 120)		-- ����
	
	_drawer:drawTexture(tOrbResultWindow[4], 217, 115, 100, 100, 0, 0)		-- ������ �̹���

end


-- �ݱ�
function CloseOrbUpgradeResultAlpha()
	winMgr:getWindow("OrbUpgradeResultAlpha"):setVisible(false)
	ORBUpgradeEffectBackWindow:setVisible(false)
end





----------------------------------------------------------------
----------ORB ���� ����-----------------------------------------
----------------------------------------------------------------


------------------------------
-- ���Ƚ� ���� ����â.
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbDettachAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------
-- ���Ƚ� ���� ���� �̹���
------------------------------
local ORBDettachMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbDettachMainImg")
ORBDettachMainBackWindow:setTexture("Enabled", "UIData/skillitem001.tga", 176, 666)
ORBDettachMainBackWindow:setTexture("Disabled", "UIData/skillitem001.tga", 176, 666)
ORBDettachMainBackWindow:setPosition((g_MAIN_WIN_SIZEX - 341) / 2, (g_MAIN_WIN_SIZEY - 358) / 2)
ORBDettachMainBackWindow:setSize(341, 358)
ORBDettachMainBackWindow:setVisible(false)
ORBDettachMainBackWindow:setAlwaysOnTop(true)
ORBDettachMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(ORBDettachMainBackWindow)

RegistEscEventInfo("OrbDettachMainImg", "OrbDettachCloseEvent")


------------------------------
-- ���Ƚ� ������ �������̹���
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbDettachItemImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 444, 570)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 444, 570)
mywindow:setPosition(25, 76)
mywindow:setSize(96, 96)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
ORBDettachMainBackWindow:addChildWindow(mywindow)


-------------------------------------------------------------
-- ���Ƚ� ������ ���Ƚ� �̸�
-------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbDettach_Name")
mywindow:setFont(g_STRING_FONT_DODUMCHE, 15)
mywindow:setTextColor(255, 178, 100, 255)
mywindow:setPosition(150, 100)
mywindow:setSize(200, 20)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setText("")
mywindow:setZOrderingEnabled(false)
ORBDettachMainBackWindow:addChildWindow(mywindow)



local OrbDettachItemSlotIndex = -1
--------------------------------------------------------------------
-- orb �ڽ�Ƭ����â�� ����ش�.
--------------------------------------------------------------------
function ShowOrbDettachEvent(index)
	SettingCommonUpgradeItemListEnable(100)
	OrbDettachItemSlotIndex = index
	winMgr:getWindow("OrbDettachAlphaImg"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("OrbDettachAlphaImg"))
	root:addChildWindow(ORBDettachMainBackWindow)
	ORBDettachMainBackWindow:setVisible(true)
	-- ������ ����Ʈ �����
	local tabTable = {['err']=0, [0] = true, false, false, false, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbDettachFrameBtn")	-- ������ ���â�� ����ش�.
end

--------------------------------------------------------------------
-- �������� ��Ͻ�ų��
--------------------------------------------------------------------
function ClickedOrbDettachFrameBtn(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))
	DebugStr('slotIndex:'..slotIndex)
	DettachOrbRegist(slotIndex)	-- �������� ������ش�.
end


--------------------------------------------------------------------
-- orb dettachâ�� �����ش�.
--------------------------------------------------------------------
function OrbDettachCloseEvent()
	winMgr:getWindow("OrbDettachAlphaImg"):setVisible(false)
	ORBDettachMainBackWindow:setVisible(false)
	CancelOrbEquip()
	winMgr:getWindow("OrbDettachItemImg"):setTexture("Disabled", "UIData/invisible.tga", 0,0)
	winMgr:getWindow("OrbDettach_Name"):setText("")
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
end


------------------------------
-- Orb ���� �ڽ�Ƭ ��Ϲ�ư
------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbDettachStartBtn")
mywindow:setTexture("Normal", "UIData/skillitem001.tga", 302, 68)
mywindow:setTexture("Hover", "UIData/skillitem001.tga", 302, 100)
mywindow:setTexture("Pushed", "UIData/skillitem001.tga", 302, 132)
mywindow:setTexture("PushedOff", "UIData/skillitem001.tga", 302, 68)
mywindow:setPosition(105, 187)
mywindow:setSize(134, 34)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "OrbDettachStartBtnEvent")
winMgr:getWindow("OrbDettachMainImg"):addChildWindow(mywindow)

function OrbDettachStartBtnEvent()
	OrbDettachStart(OrbDettachItemSlotIndex)
end
------------------------------
-- Orb �ڽ�Ƭ ���� �̹��� ���
------------------------------
function SettingCostumeDettachImg(itemName, itemFileName, itemFileName2, itemFileName3)
	DebugStr('itemFileName3:'..itemFileName3)
	winMgr:getWindow("OrbDettachItemImg"):setTexture("Enabled", itemFileName, 0,0)
	winMgr:getWindow("OrbDettachItemImg"):setTexture("Disabled", itemFileName, 0,0)
	winMgr:getWindow("OrbDettach_Name"):setText(itemFileName3)
	local tabTable = {['err']=0, [0] = true, false, false, false, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedOrbDettachFrameBtn")	-- ������ ���â�� ����ش�.
end







------------------------------
-- �� ��ȭ ���� �̹���
------------------------------
local PetHatchMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "PetHatchMainImg")
PetHatchMainBackWindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 0)
PetHatchMainBackWindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 0)
PetHatchMainBackWindow:setPosition((g_MAIN_WIN_SIZEX - 341) / 2, (g_MAIN_WIN_SIZEY - 308) / 2)
PetHatchMainBackWindow:setSize(316, 376)
PetHatchMainBackWindow:setVisible(false)
PetHatchMainBackWindow:setAlwaysOnTop(true)
PetHatchMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(PetHatchMainBackWindow)

RegistEscEventInfo("PetHatchMainImg", "PetHacthCloseEvent")


------------------------------
-- �� ��ȭ ������ �̹���
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetHatchMainGageImg")
mywindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 376)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 376)
mywindow:setPosition(27, 299)
mywindow:setSize(262, 7)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PetHatchMainImg"):addChildWindow(mywindow)


------------------------------
-- �� ��ȭ ���� ��ư
------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "PetHatchStarBtn")
mywindow:setTexture("Normal", "UIData/pet_02.tga", 316, 0)
mywindow:setTexture("Hover", "UIData/pet_02.tga", 316, 29)
mywindow:setTexture("Pushed", "UIData/pet_02.tga", 316, 58)
mywindow:setTexture("PushedOff", "UIData/pet_02.tga", 316, 0)
mywindow:setPosition(108, 321)
mywindow:setSize(101, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "OnClickPetHatchStart")
winMgr:getWindow("PetHatchMainImg"):addChildWindow(mywindow)

function OnClickPetHatchStart()
	RequestPetHatchStart()
end

function OnClickPetHatchSelect(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local slotIndex = tonumber(eventwindow:getUserString("Index"))
	DebugStr('slotIndex:'..slotIndex)
	HatchEggRegist(slotIndex)
end
--------------------------------------------------------------------
--  ���ȭâ ����
--------------------------------------------------------------------
function ShowPetHacthEvent()

	-- ������ ����Ʈ �����
	PetHatchMainBackWindow:setVisible(true)
	local tabTable = {['err']=0, [0] = false, false, true, false, false}
	ShowCommonUpgradeFrame(tabTable, "OnClickPetHatchSelect")	-- ������ ���â�� ����ش�.
end


--------------------------------------------------------------------
-- ���ȭâ �ݱ�
--------------------------------------------------------------------
function PetHacthCloseEvent()
	VirtualImageSetVisible(false)
	--CancelOrbUpgrade()
	PetHatchMainBackWindow:setVisible(false)
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
end



--------------------------------------------------------------------
-- ���ȭâ ��ư���� �ݱ�
--------------------------------------------------------------------
function PetHacthCloseButtonEvent()
	VirtualImageSetVisible(false)
	--CancelOrbUpgrade()
	PetHatchMainBackWindow:setVisible(false)
	CloseCommonUpgradeFrame()	-- ������ ����Ʈ �ݾ���	
	TownNpcEscBtnClickEvent()
end


--------------------------------------------------------------------
--  �� �̹����� �������ش�.
--------------------------------------------------------------------
function SettingPetHatchImg(itemName, itemFileName, itemFileName2)
	DebugStr('itemName:'..itemName)
end
