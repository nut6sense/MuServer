--------------------------------------------------------------------
-- ItemUpgrade.lua
--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


local isAnimation = false		-- �ִϸ��̼��� ���ư��������� üũ


-- �ڽ�Ƭ ���׷��̵� ���� �̹���.
local ItemUpgradeMainBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemUpgradeMainBackImage")
ItemUpgradeMainBackWindow:setTexture("Enabled", "UIData/Itemshop001.tga", 0, 0)
ItemUpgradeMainBackWindow:setWideType(6);
ItemUpgradeMainBackWindow:setPosition(50,50)
ItemUpgradeMainBackWindow:setSize(332, 628)
ItemUpgradeMainBackWindow:setAlwaysOnTop(true)
ItemUpgradeMainBackWindow:setVisible(false)
ItemUpgradeMainBackWindow:setZOrderingEnabled(false)
root:addChildWindow(ItemUpgradeMainBackWindow)

RegistEscEventInfo("ItemUpgradeMainBackImage", "CloseItemUpgradeEvent")


-- �ڽ�Ƭ ���׷��̵� �ݱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ItemUpgrade_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(300, 7)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseItemUpgradeButtonEvent")
ItemUpgradeMainBackWindow:addChildWindow(mywindow)


-- �ڽ�Ƭ ���׷��̵� ���׷��̵� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ItemUpgrade_UpgradeButton")
mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 0, 628)
mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 0, 655)
mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 0, 682)
mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 0, 682)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 0, 709)
mywindow:setPosition(75, 280)
mywindow:setSize(81, 27)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "StartItemUpgradeEvent")
ItemUpgradeMainBackWindow:addChildWindow(mywindow)


-- �ڽ�Ƭ ���׷��̵� ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ItemUpgrade_CancelButton")
mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 81, 628)
mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 81, 655)
mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 81, 682)
mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 81, 682)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 81, 709)
mywindow:setPosition(175, 280)
mywindow:setSize(81, 27)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseItemUpgradeButtonEvent")
ItemUpgradeMainBackWindow:addChildWindow(mywindow)



local tItemKindTable = {[0]="ItemUpgrade_Item", "ItemUpgrade_Stuff", "ItemUpgrade_Result"}
local tItemKindPosX	 = {[0]=		38,				233,				135}
local tItemKindPosY	 = {[0]=		63,				63,					182}

local tEmptyTexX	 = {[0]=		861,			921,				861}
local tEmptyTexY	 = {[0]=		0,				0,					60}


for i=0, #tItemKindTable do
	-- �� ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemKindTable[i].."_EmptyImg")
	mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", tEmptyTexX[i], tEmptyTexY[i])
	mywindow:setPosition(tItemKindPosX[i] + 1, tItemKindPosY[i] + 1)
	mywindow:setSize(60, 60)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	ItemUpgradeMainBackWindow:addChildWindow(mywindow)
	
	-- ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemKindTable[i].."_BackImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 912)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 912)
	mywindow:setPosition(tItemKindPosX[i]-4, tItemKindPosY[i]-4)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setAlign(8)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	mywindow:addController("ItemUpgradeController", tItemKindTable[i].."_Event", "y", "Back_EaseIn", tItemKindPosY[i]-4 , 202-20, 6, true, false, 10)
	mywindow:addController("ItemUpgradeController", tItemKindTable[i].."_Event", "x", "Linear_EaseNone", tItemKindPosX[i]-4 , 155-20, 6, true, false, 10)
	mywindow:addController("ItemUpgradeController", tItemKindTable[i].."_Event", "xscale", "Linear_EaseNone", 255, 80, 5, true, false, 10)
	mywindow:addController("ItemUpgradeController", tItemKindTable[i].."_Event", "yscale", "Linear_EaseNone", 255, 80, 5, true, false, 10)
--	mywindow:addController("ItemUpgradeController", tItemKindTable[i].."_Event", "angle", "Linear_EaseNone", 0, 2000, 5, true, false, 10)
	mywindow:setSubscribeEvent("MotionEventEnd", "MotionEndUpgradeController");
	ItemUpgradeMainBackWindow:addChildWindow(mywindow)
	-- Back_EaseInOut
	-- Back_EaseIn
	-- Quintic_EaseInOut
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemKindTable[i].."_MainImg")
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(4,4)
	mywindow:setSize(100, 100)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setScaleWidth(157)
	mywindow:setScaleHeight(157)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow(tItemKindTable[i].."_BackImg"):addChildWindow(mywindow)
	
	

	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemKindTable[i].."_GradeImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(3, 3)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tItemKindTable[i].."_BackImg"):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tItemKindTable[i].."_GradeText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(8, 3)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tItemKindTable[i].."_BackImg"):addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tItemKindTable[i].."_CountText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(8, 4)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tItemKindTable[i].."_BackImg"):addChildWindow(mywindow)

	
	if i == 2 then
		break
	end	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/Button", tItemKindTable[i].."_Tooltip")
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_MyUpgradeItemInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_MyUpgradeItemInfo")
	winMgr:getWindow(tItemKindTable[i].."_BackImg"):addChildWindow(mywindow)
	

	-- ���� �ڽ�Ƭ ù��° �ݱ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", tItemKindTable[i].."_CloseBtn")
	mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 1008, 0)
	mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 1008, 16)
	mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 1008, 32)
	mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 1008, 32)
	mywindow:setPosition(tItemKindPosX[i] + 46, tItemKindPosY[i])
	mywindow:setSize(16, 16)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "OnClickUpgradeItemErase")
	ItemUpgradeMainBackWindow:addChildWindow(mywindow)
end

-- Ŭ�� �ƹ�Ÿ ���� �� �̹��� ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemUpgrade_BackImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(4,4)
mywindow:setSize(100, 100)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setLayered(true)
mywindow:setEnabled(false)
mywindow:setScaleWidth(157)
mywindow:setScaleHeight(157)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
winMgr:getWindow(tItemKindTable[0].."_BackImg"):addChildWindow(mywindow)



-- ������ �̹���.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Result2DEffectImg")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 861, 120)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 861, 120)
mywindow:setPosition(135-44, 182-44)
mywindow:setSize(150, 150)
mywindow:setAlwaysOnTop(true)
mywindow:setAlign(8)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "y", "Quintic_EaseInOut", tItemKindPosY[i]-4 , 202-20, 4, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "x", "Linear_EaseNone", tItemKindPosX[i]-4 , 155-20, 4, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 0, 0, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 0, 190, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 190, 0, 3, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Sine_EaseIn", 0, 0, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 0, 220, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 220, 0, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Linear_EaseNone", 0, 255, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Quintic_EaseIn", 255, 0, 10, true, false, 10)

mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 255, 255, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 255, 9, true, false, 10)

--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Sine_EaseIn", 0, 255, 4, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "alpha", "Sine_EaseIn", 255, 0, 8, true, false, 10)
--[[
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 255, 255, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 255, 355, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 355, 355, 3, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 355, 455, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 455, 455, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 455, 1000, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 1000, 255, 10, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "xscale", "Linear_EaseNone", 255, 2000, 8, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 255, 15, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 255, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 355, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 355, 355, 3, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 355, 455, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 455, 455, 5, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 1000, 1, true, false, 10)
mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 1000, 255, 10, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "yscale", "Linear_EaseNone", 255, 2000, 8, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "angle", "Linear_EaseNone", 0, 0, 16, true, false, 10)
--mywindow:addController("ItemUpgradeController", "Result2DEffect_Event", "angle", "Linear_EaseNone", 0, 4000, 10, true, false, 10)
--]]
mywindow:setSubscribeEvent("MotionEventEnd", "aaaa");
ItemUpgradeMainBackWindow:addChildWindow(mywindow)


--mywindow:activeMotion("Result2DEffect_Event")


-- �̺�Ʈ�� �Ϸ�
local b2DEffectEnd = false
local EffectCount = 0
function aaaa()
	if EffectCount < 2 then
		PlayWave('sound/Item_Upgrade.wav')
		EffectCount = EffectCount + 1
		return
	end
	if b2DEffectEnd == false then
		EffectCount = 0
		b2DEffectEnd = true
		upgradeResultBack:activeMotion("UpgradeResult_Event")	-- ���â ��� �̺�Ʈ
		root:addChildWindow(winMgr:getWindow("UpgradeResult_Alpha"))
		winMgr:getWindow("UpgradeResult_Alpha"):setVisible(true)
		winMgr:getWindow("ItemUpgrade_Item_BackImg"):setVisible(false)
		winMgr:getWindow("ItemUpgrade_Stuff_BackImg"):setVisible(false)
		PlayWave('sound/SkillUP_Result.wav')
	end		
end


function Result2DEffectImgfunction()
	

end

local aaa = false
local MotionEnd = false

function EffectStart()
	
--		root:addChildWindow(winMgr:getWindow("UpgradeResult_Alpha"))
--		winMgr:getWindow("UpgradeResult_Alpha"):setVisible(true)
--		upgradeResultBack:activeMotion("UpgradeResult_Event")	-- ���â ��� �̺�Ʈ

		winMgr:getWindow("ItemUpgrade_Item_BackImg"):activeMotion("ItemUpgrade_Item_Event")


		winMgr:getWindow("Result2DEffectImg"):activeMotion("Result2DEffect_Event")
		winMgr:getWindow("Result2DEffectImg"):setVisible(true)

end

function ResultEffectClear()
	winMgr:getWindow("ItemUpgrade_Item_BackImg"):clearActiveController()
	winMgr:getWindow("ItemUpgrade_Stuff_BackImg"):clearActiveController()
	winMgr:getWindow("Result2DEffectImg"):clearActiveController()
	winMgr:getWindow("Result2DEffectImg"):setVisible(false)
	winMgr:getWindow("ItemUpgrade_Item_BackImg"):setVisible(true)
	winMgr:getWindow("ItemUpgrade_Stuff_BackImg"):setVisible(true)
	MotionEnd = false
end

function MotionEndUpgradeController(args)
	if MotionEnd == false then
		winMgr:getWindow("ItemUpgrade_Stuff_BackImg"):activeMotion("ItemUpgrade_Stuff_Event")
		MotionEnd = true
	end
end


-- �ؽ�Ʈ 
local tUpgradeInfoKind = {[0]= "KindText_Upgrade", "KindText_Upgrade_Stat", "KindText_SuccessPercent", "KindText_DestructionPercent"
							, "KindText_DegradePercent", "KindText_Degrade", "KindText_Degrade_Stat"}
for i=0, #tUpgradeInfoKind do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tUpgradeInfoKind[i])
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
	mywindow:setPosition(215, 375 + i*30)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	ItemUpgradeMainBackWindow:addChildWindow(mywindow)
end


-- 
function MouseEnter_MyUpgradeItemInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, itemslot = GetUpgradeToolTipInfo(index)
	if itemnumber == 0 then
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
	GetToolTipBaseInfo(x + 70, y+3, 0, Kind, itemslot, itemnumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)

end

function MouseLeave_MyUpgradeItemInfo(args)
	SetShowToolTip(false)

end


function OnClickUpgradeItemErase(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(eventwindow:getUserString("Index"))
	ItemEraseEvent(index)
	
	winMgr:getWindow("ItemUpgrade_BackImage"):setVisible(false)
	
end


function ClearUpgradeAllInfo()
	for i=0, 1 do
		ItemEraseEvent(i)
	end
end



function ClearUpgradeInfoText()
	winMgr:getWindow("KindText_Upgrade"):setText("")
	winMgr:getWindow("KindText_Upgrade_Stat"):setText("")
	winMgr:getWindow("KindText_SuccessPercent"):setText("")
	winMgr:getWindow("KindText_DestructionPercent"):setText("")
	winMgr:getWindow("KindText_DegradePercent"):setText("")
	winMgr:getWindow("KindText_Degrade"):setText("")
	winMgr:getWindow("KindText_Degrade_Stat"):setText("")
end

function UpgradeInfoText(upGrade, addAbility, successProb, destroyProb, degradeProb, degrade, MiAbility)
	winMgr:getWindow("KindText_Upgrade"):setText(upGrade)
	winMgr:getWindow("KindText_Upgrade_Stat"):setText(addAbility)
	winMgr:getWindow("KindText_SuccessPercent"):setText(successProb.."%")
	winMgr:getWindow("KindText_DestructionPercent"):setText(destroyProb.."%")
	winMgr:getWindow("KindText_DegradePercent"):setText(degradeProb.."%")
	winMgr:getWindow("KindText_Degrade"):setText(degrade)
	winMgr:getWindow("KindText_Degrade_Stat"):setText(MiAbility)
end


-- ItemType == 0 �ڽ�Ƭ, ItemType == 1 �ֹ���
function UpdateUpgradeItemImg(empty, ItemType, itemFileName, ItemFileName2, itemGrade, itemCount, avatarType, attach)
	if empty == 1 then	-- �� �̹����� �ƴҶ�
		winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setPosition(tItemKindPosX[ItemType]-4, tItemKindPosY[ItemType]-4)
		winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setSize(70, 70)
		winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setScaleWidth(255)
		winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setScaleHeight(255)
		winMgr:getWindow(tItemKindTable[ItemType].."_EmptyImg"):setVisible(false)	-- 
		winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setVisible(true)
		-- 	������ �̹���
		winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setTexture("Disabled", itemFileName, 0, 0)
		if ItemFileName2 ~= "" then
			winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setLayered(true)		
			winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setTexture("Layered", ItemFileName2, 0, 0)
		else
			winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setLayered(false)
			winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setTexture("Layered", "UIData/invisible", 0, 0)
		end
		
		-- ��ų ���ǥ��	
		if itemGrade > 0 then
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(true)
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setText("+"..itemGrade)
		else
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(false)
			winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setText("")
		end
		if itemCount > 1 then
			winMgr:getWindow(tItemKindTable[ItemType].."_CountText"):setText("x "..itemCount)
		else
			winMgr:getWindow(tItemKindTable[ItemType].."_CountText"):setText("")
		end
		
	
	-- �ڽ�Ƭ �ƹ�Ÿ ���� ������ ���� �ڡ�
	if ItemType == 0 then
		if avatarType ~= 0 then
			SetAvatarIcon(tItemKindTable[ItemType].."_MainImg" , "ItemUpgrade_BackImage" , avatarType , attach)
		else
			winMgr:getWindow("ItemUpgrade_BackImage"):setVisible(false)
		end
	end
		
	else
		winMgr:getWindow(tItemKindTable[ItemType].."_EmptyImg"):setVisible(true)
		winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setVisible(false)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(false)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setText("")
		winMgr:getWindow(tItemKindTable[ItemType].."_CountText"):setText("")
		
	end
end


function EnableCheckUpgradeBtn(Enabled)
	if Enabled == 0 then
		winMgr:getWindow("ItemUpgrade_UpgradeButton"):setEnabled(false)
	else
		winMgr:getWindow("ItemUpgrade_UpgradeButton"):setEnabled(true)
		isAnimation = false		-- ����� �����ٰ� �˷��ش�,
	end
end


function forecastItem(empty, itemFileName, ItemFileName2, itemGrade)
	if empty == 1 then	-- �� �̹����� �ƴҶ�
--[[
		-- 	������ �̹���
		winMgr:getWindow("ItemUpgrade_Result_EmptyImg"):setVisible(false)
		winMgr:getWindow("ItemUpgrade_Result_MainImg"):setVisible(true)
		winMgr:getWindow("ItemUpgrade_Result_MainImg"):setTexture("Disabled", itemFileName, 0, 0)
		if ItemFileName2 ~= "" then
			winMgr:getWindow("ItemUpgrade_Result_MainImg"):setTexture("Layered", ItemFileName2, 0, 0)
		else
			winMgr:getWindow("ItemUpgrade_Result_MainImg"):setTexture("Layered", "UIData/invisible", 0, 0)
		end
		
		-- ��ų ���ǥ��	
		if itemGrade > 0 then
			winMgr:getWindow("ItemUpgrade_Result_GradeImg"):setVisible(true)
			winMgr:getWindow("ItemUpgrade_Result_GradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
			winMgr:getWindow("ItemUpgrade_Result_GradeText"):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
			winMgr:getWindow("ItemUpgrade_Result_GradeText"):setText("+"..itemGrade)
		else
			winMgr:getWindow("ItemUpgrade_Result_GradeImg"):setVisible(false)
			winMgr:getWindow("ItemUpgrade_Result_GradeText"):setText("")
		end
--]]
	else
		winMgr:getWindow("ItemUpgrade_Result_EmptyImg"):setVisible(true)
		winMgr:getWindow("ItemUpgrade_Result_MainImg"):setVisible(false)
		winMgr:getWindow("ItemUpgrade_Result_GradeImg"):setVisible(false)
		winMgr:getWindow("ItemUpgrade_Result_GradeText"):setText("")
	end	
end


-- �������� ������ �ʱ�ȭ �����ش�.
function clearItemImage(type)
	winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setTexture("Disabled", "UIData/invisible", 0, 0)
	winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setLayered(false)
	winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(true)
	winMgr:getWindow("ItemUpgrade_BackImage"):setVisible(false)
	
end




-- �ڽ�Ƭ ���׷��̵� ���� �̺�Ʈ
function StartItemUpgradeEvent(args)
	isAnimation = true
	RequestMsgUpgrade()
	
	local max = GetOnePageMaxCount()
	for i = 0 , max-1 do
		winMgr:getWindow("ItemListContainer_RegistBtn_"..i):setEnabled(false)
	end
	
	-- ���׷��̵� �����ҋ� ��ư�� ��Ȱ��ȭ ��Ų�� ��
	winMgr:getWindow("ItemUpgrade_Item_CloseBtn"):setTexture("Enabled", "UIData/Itemshop001.tga", 1008, 32)
	winMgr:getWindow("ItemUpgrade_Stuff_CloseBtn"):setTexture("Enabled", "UIData/Itemshop001.tga", 1008, 32)
	
	winMgr:getWindow("ItemUpgrade_Item_CloseBtn"):setEnabled(false)
	winMgr:getWindow("ItemUpgrade_Stuff_CloseBtn"):setEnabled(false)
end

function UpgradeEnableCheckError()
	isAnimation = false
end


-- �ڽ�Ƭ ���׷��̵� �ݱ� ��ư �̺�Ʈ
function CloseItemUpgradeEvent()
	if isAnimation then
		return
	end
	VirtualImageSetVisible(false)
	CloseItemListContainer()
	ItemUpgradeMainBackWindow:setVisible(false)
	ClearUpgradeAllInfo()
end


-- �ڽ�Ƭ ���׷��̵� �ݱ� ��ư �̺�Ʈ
function CloseItemUpgradeButtonEvent()
	if isAnimation then
		return
	end
	VirtualImageSetVisible(false)
	TownNpcEscBtnClickEvent()
	CloseItemListContainer()
	ItemUpgradeMainBackWindow:setVisible(false)
	ClearUpgradeAllInfo()
end


-- ������ ���׷��̵带 �����ش�.
function ShowItemUpgradeWindow()
	ShowItemListContainer()
	root:addChildWindow(ItemUpgradeMainBackWindow)
	ItemUpgradeMainBackWindow:setVisible(true)
	CreateItemUpgradeInfo()
	ShowUpgrade_ItemListContainer()
	EnableCheckUpgradeBtn(1)		-- ���׷�
end







-- ���׷��̵� ���â
local UPGRADE_SUCCESS = 0
local UPGRADE_DEGRADE = 1
local UPGRADE_DESTROY = 2
local tResultBackTexX = {[0]=571, 571, 332, 332}
local tResultBackTexY = {[0]=300, 407, 407, 300}
local ttitleTexY = {[0]=628, 718, 673, 583}	-- �ƹ��� ��ȭ�� ���°� �ӽ÷�


-- �����̹��� --
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResult_Alpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("UpgradeResult_Alpha", "HideUpgradeResult")

-- ����
upgradeResultBack = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResult_Back")
upgradeResultBack:setTexture("Enabled", "UIData/Itemshop001.tga", 332, 0)
upgradeResultBack:setWideType(6)
upgradeResultBack:setPosition(230, 190)
upgradeResultBack:setSize(529, 266)
upgradeResultBack:setVisible(true)
upgradeResultBack:setAlign(8)
upgradeResultBack:setAlwaysOnTop(true)
upgradeResultBack:setZOrderingEnabled(false)
upgradeResultBack:setUseEventController(false)
--[[
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Sine_EaseIn", 70 , -50, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Bounce_EaseOut", -50, 200, 6, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Linear_EaseNone", 200, 200, 1, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 0 , 80, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 80 , 245, 6, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 245 , 245, 1, true, false, 10)
--]]
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "angle", "Linear_EaseNone", 0, 4000, 9, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "angle", "Linear_EaseNone", 0, 0, 1, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "xscale", "Linear_EaseNone", 50, 30, 9, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "xscale", "Linear_EaseNone", 30, 255, 1, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "yscale", "Linear_EaseNone", 50, 30, 9, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "yscale", "Linear_EaseNone", 30, 255, 1, true, false, 10)


--[[
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Linear_EaseNone", 250 , 0, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Linear_EaseNone", 0 , 250, 3, true, false, 10)
--upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Linear_EaseNone", 300 , 600, 3, true, false, 10)
--upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "y", "Linear_EaseNone", 600 , 300, 4, true, false, 10)

upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 0 , 240, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 240 , 480, 3, true, false, 10)
--upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 700 , 350, 4, true, false, 10)
--upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "x", "Linear_EaseNone", 350 , 0, 3, true, false, 10)

upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "xscale", "Linear_EaseNone", 30, 30, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "xscale", "Linear_EaseNone", 30, 30, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "yscale", "Linear_EaseNone", 30, 30, 3, true, false, 10)
upgradeResultBack:addController("UpgradeResultController", "UpgradeResult_Event", "yscale", "Linear_EaseNone", 30, 30, 3, true, false, 10)
--]]


upgradeResultBack:setSubscribeEvent("MotionEventEnd", "MotionEndUpgradeResult");	
winMgr:getWindow("UpgradeResult_Alpha"):addChildWindow(upgradeResultBack)


-- ���׷��̵� ��� Ÿ��Ʋ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UpgradeResult_Title")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 332, 628)
mywindow:setPosition(87, 43)
mywindow:setSize(355, 45)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
upgradeResultBack:addChildWindow(mywindow)

local tresultWndKind = {[0]="UpgradeResult_Base", "UpgradeResult_Result"}
local tresultWndTexX = {[0]=332, 571}
local tresultWndPosX = {[0]=8, 282}
local tStat = {[0]= 0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local MAX_STAT_SHOW = 2

for i=0, #tresultWndKind do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tresultWndKind[i])
	mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", tresultWndTexX[i], 300)
	mywindow:setPosition(tresultWndPosX[i], 95)
	mywindow:setSize(239, 107)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	upgradeResultBack:addChildWindow(mywindow)
	
	-- �⺻â ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tresultWndKind[i].."_Name")
	mywindow:setPosition(8, 8)
	mywindow:setSize(223, 20)
	mywindow:setAlign(8)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tresultWndKind[i]):addChildWindow(mywindow)
	
	-- Ŭ�� �ƹ�Ÿ ���� �� �̹��� ��
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tresultWndKind[i].."_Back")
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(4,4)
	mywindow:setSize(100, 100)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setScaleWidth(157)
	mywindow:setScaleHeight(157)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow(tItemKindTable[0].."_BackImg"):addChildWindow(mywindow)

	-- �⺻â ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tresultWndKind[i].."_Img")
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(12,35)
	mywindow:setSize(100, 100)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setScaleWidth(153)
	mywindow:setScaleHeight(153)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow(tresultWndKind[i]):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tresultWndKind[i].."_GradeImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(14,36)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tresultWndKind[i]):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tresultWndKind[i].."_GradeText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(18,36)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tresultWndKind[i]):addChildWindow(mywindow)
	
	for j=0, MAX_STAT_SHOW-1 do
		-- �⺻â ������ �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", tresultWndKind[i].."_Stat_"..j)
		--mywindow:setTexture("Disabled", "UIData/nm0.tga", 0, 0)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(85, 42 + j*19)
		mywindow:setSize(140, 18)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow(tresultWndKind[i]):addChildWindow(mywindow)
	end
end




-- ���׷��̵� ��� �ݱ�â
mywindow = winMgr:createWindow("TaharezLook/Button", "UpgradeResult_CloseButton")
mywindow:setTexture("Normal", "UIData/Itemshop001.tga", 162, 628)
mywindow:setTexture("Hover", "UIData/Itemshop001.tga", 162, 655)
mywindow:setTexture("Pushed", "UIData/Itemshop001.tga", 162, 682)
mywindow:setTexture("PushedOff", "UIData/Itemshop001.tga", 162, 682)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 162, 709)
mywindow:setPosition(223, 224)
mywindow:setSize(81, 27)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideUpgradeResult")
upgradeResultBack:addChildWindow(mywindow)



--function 





local bResultMotion = false		-- ���׷��̵� ���â�� 

-- ���׷��̵� ���â ��� �Ϸ� �̺�Ʈ
function MotionEndUpgradeResult(args)
	b2DEffectEnd = false
	if bResultMotion == false then
--		isAnimation = false		-- ����� �����ٰ� �˷��ش�,
		ShowResult()
		bResultMotion = true
		SwitchResultText(true)	-- ����˾�â�� �ؽ�Ʈ�� �����ش�.
	end	
end



function ResultStatSetting(atkValue, defValue, atkstr, atkgra, cri, hp,sp, defstr, defgra, atkteam, atkdouble
						, atkspecial, defteam, defdouble, defspecial, cridamage)
	
	tStat = {[0]= atkstr, atkgra, cri, hp,sp, defstr, defgra, atkteam, atkdouble
						, atkspecial, defteam, defdouble, defspecial, cridamage}

	for i=0, #tStat do
		
		
		
	end				
end




-- ������� ����Ʈ�� ���⶧���� �ؽ�Ʈ �������� �̺�Ʈ�� ���������� ��������Ѵ�.
function SwitchResultText(bCheck)
	-- �� bool ������ �ٷ� ���� ������ �ȵɱ�.............................?
	if bCheck == true then
		for i=0, #tresultWndKind do
			winMgr:getWindow(tresultWndKind[i].."_Name"):setVisible(true)
			winMgr:getWindow(tresultWndKind[i].."_GradeText"):setVisible(true)
			for j=0, MAX_STAT_SHOW-1 do
				-- �⺻â ������ �̸�
				winMgr:getWindow(tresultWndKind[i].."_Stat_"..j):setVisible(true)
			end
		end
	else
		for i=0, #tresultWndKind do
			winMgr:getWindow(tresultWndKind[i].."_Name"):setVisible(false)
			winMgr:getWindow(tresultWndKind[i].."_GradeText"):setVisible(false)
			for j=0, MAX_STAT_SHOW-1 do
				-- �⺻â ������ �̸�
				winMgr:getWindow(tresultWndKind[i].."_Stat_"..j):setVisible(false)
			end
		end
	end
end



-- ������ ���׷��̵� ���â�� �����ش�.
function ShowUpgradeResult(resultType, itemName, fileName, fileName2, oldgrade, grade, oldatkValue, olddefValue, atkValue, defValue, avatarType, attach)
	
	winMgr:getWindow("UpgradeResult_Title"):setTexture("Enabled", "UIData/Itemshop001.tga", 332, ttitleTexY[resultType])
	winMgr:getWindow("UpgradeResult_Result"):setTexture("Enabled", "UIData/Itemshop001.tga", tResultBackTexX[resultType], tResultBackTexY[resultType])
	
	for i=0, #tresultWndKind do
		for j=0, MAX_STAT_SHOW-1 do
			winMgr:getWindow(tresultWndKind[i].."_Stat_"..j):setText("")
		end
	end
	
	--winMgr:getWindow("UpgradeResult_Result"):setVisible(true)
	
	if resultType == 0 then			-- ����
		winMgr:getWindow("UpgradeResult_Result_Name"):setTextExtends(itemName ,g_STRING_FONT_GULIM, 12, 255,200,50,255,  0,  20,20,20,255);
	elseif resultType == 1 then		-- ��׷��̵�
		winMgr:getWindow("UpgradeResult_Result_Name"):setTextExtends(itemName ,g_STRING_FONT_GULIM, 12, 255,200,50,255,  0,  20,20,20,255);
	elseif resultType == 2 then		-- �ı�
		winMgr:getWindow("UpgradeResult_Result_Name"):clearTextExtends()
		winMgr:getWindow("UpgradeResult_Result_Img"):setTexture("Disabled", "UIData/invisible", 0, 0)
		winMgr:getWindow("UpgradeResult_Result_Img"):setTexture("Layered", "UIData/invisible", 0, 0)
		winMgr:getWindow("UpgradeResult_Result_GradeImg"):setVisible(false)
		winMgr:getWindow("UpgradeResult_Result_GradeText"):setText("")
	--	for i=0, MAX_STAT_SHOW-1 do
	--		winMgr:getWindow("UpgradeResult_Result_Stat_"..i):setText("")
	--	end
		--return
	elseif resultType == 3 then		-- �ƹ��� ��ȭ�� ����.
		winMgr:getWindow("UpgradeResult_Result_Name"):setTextExtends(itemName ,g_STRING_FONT_GULIM, 12, 255,200,50,255,  0,  20,20,20,255);
	else							-- ����
	
	end
	winMgr:getWindow("UpgradeResult_Base_Name"):setTextExtends(itemName ,g_STRING_FONT_GULIM, 12, 255,200,50,255,  0,  20,20,20,255);
	
	local tgrade = {[0]=oldgrade, grade}
	local toldvalue = {[0]=oldatkValue, olddefValue}
	local tcurrentvalue = {[0]=atkValue, defValue}
	local tValueSection = {[0]=toldvalue, tcurrentvalue}
	
	for i=0, #tresultWndKind do
		if i == 1 and resultType == 2 then
			return
		end
		
		--DebugStr("���׷��̵� �����̸� :  " .. fileName)
		winMgr:getWindow(tresultWndKind[i].."_Img"):setTexture("Disabled", fileName, 0, 0)
		
		
		if fileName2 ~= "" then
			winMgr:getWindow(tresultWndKind[i].."_Img"):setTexture("Layered", fileName2, 0, 0)
		else
			winMgr:getWindow(tresultWndKind[i].."_Img"):setTexture("Layered", "UIData/invisible", 0, 0)
		end	
		
		
		-- ��ų ���ǥ��	
		if tgrade[i] > 0 then
			winMgr:getWindow(tresultWndKind[i].."_GradeImg"):setVisible(true)
			winMgr:getWindow(tresultWndKind[i].."_GradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[tgrade[i]], 486)
			winMgr:getWindow(tresultWndKind[i].."_GradeText"):setTextColor(tGradeTextColorTable[tgrade[i]][1], tGradeTextColorTable[tgrade[i]][2], tGradeTextColorTable[tgrade[i]][3], 255)
			winMgr:getWindow(tresultWndKind[i].."_GradeText"):setText("+"..tgrade[i])
		else
			winMgr:getWindow(tresultWndKind[i].."_GradeImg"):setVisible(false)
			winMgr:getWindow(tresultWndKind[i].."_GradeText"):setText("")
		end
		
		
		-- Ŭ�� �ƹ�Ÿ ���� ������ ���� �۾� �ڡ�
		-- �Ϸ�â Ŭ�� �ƹ�Ÿ ������!!
		if avatarType ~= 0 then
			SetAvatarIcon(tresultWndKind[i].."_Img" , tresultWndKind[i].."_Img" , avatarType , attach)
		else
			--winMgr:getWindow(tresultWndKind[i].."_Back"):setVisible(false)
		end
		
		
		local count = 0
		for j=0, MAX_STAT_SHOW-1 do
			if tValueSection[i][j] ~= "" then
				winMgr:getWindow(tresultWndKind[i].."_Stat_"..count):setText(tValueSection[i][j])
				count = count + 1
			else
				winMgr:getWindow(tresultWndKind[i].."_Stat_"..count):setText("")
			end
		end
	end
end


-- ������ ���׷��̵� ���â�� �ݴ´�.
function HideUpgradeResult()
	if isAnimation then
		return
	end
	winMgr:getWindow("UpgradeResult_Alpha"):setVisible(false)
	upgradeResultBack:clearActiveController()
	bResultMotion = false
	ResultEffectClear() -- �ʱ�ȭ
	SwitchResultText(false)	-- ����˾�â�� �ؽ�Ʈ�� �����
--	isAnimation = false		-- ����� �����ٰ� �˷��ش�,
	
	
	
	-- ���׷��̵尡 ����Ǹ� ��� Ȱ��ȭ ��Ų��
	local max = GetOnePageMaxCount()
	for i = 0 , max-1 do
		winMgr:getWindow("ItemListContainer_RegistBtn_"..i):setEnabled(true)
	end
	
	winMgr:getWindow("ItemUpgrade_Item_CloseBtn"):setTexture("Enabled", "UIData/Itemshop001.tga", 1008, 0)
	winMgr:getWindow("ItemUpgrade_Stuff_CloseBtn"):setTexture("Enabled", "UIData/Itemshop001.tga", 1008, 0)
	
	winMgr:getWindow("ItemUpgrade_Item_CloseBtn"):setEnabled(true)
	winMgr:getWindow("ItemUpgrade_Stuff_CloseBtn"):setEnabled(true)	
	

end


