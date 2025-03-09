function BtnPageMove_BtnPageMove()

--------------------------------------------------------------------
-- ����
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton();
local winMgr = CEGUI.WindowManager:getSingleton();
root = winMgr:getWindow("DefaultWindow");
guiSystem:setGUISheet(root);
guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow2");

--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�(���ö���¡)
--------------------------------------------------------------------
local BPM_String_PartyBan2 = PreCreateString_1017	--GetSStringInfo(LAN_LUA_BTNPAGEMOVE_2)	-- ��ƼŻ�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?

-- ���� üũ ����
CurrentLanguage = GetLanguageType();

--------------------------------------------------------------------
-- ������
--------------------------------------------------------------------
-- ��ư�� ��ġ�� �����ǰų� ���� �߰��� �Ǹ� �ε����� ���� ���󰡾��Ѵ�.
local NONE_BUTTON		= 0
local VILLAGE_BUTTON	= 1
local FIGHT_BUTTON		= 2
local SHOP_BUTTON		= 3
local MYROOM_BUTTON		= 4
local MENU_BUTTON		= 5
local CHANNEL_BUTTON	= 6
local LOGOUT_BUTTON		= 7
local OPTION_BUTTON		= 8
local QUIT_BUTTON		= 9
local CHARACTER_BUTTON	= 10

local BottomButtonIndexTable	= {['err'] = 0, VILLAGE_BUTTON, FIGHT_BUTTON, SHOP_BUTTON, MYROOM_BUTTON, MENU_BUTTON }


local SelectIndex = NONE_BUTTON
MAX_BATTLE_CHANNEL_1PAGE = 9
local FightMotionEndCheck	= false
local curChannelPage		= 1
local maxChannelPage		= 1


-- ����ư ���� ������ �̵��Ҷ�
function SetSelectBattle()
	SelectIndex = FIGHT_BUTTON
end

function SetSelectVillage()
	SelectIndex = VILLAGE_BUTTON
end

function SetSelectMyRoom()
	SelectIndex = MYROOM_BUTTON
end

function SetSelectShop()
	SelectIndex = SHOP_BUTTON
end

--------------------------------------------------------------------
-- ������
--------------------------------------------------------------------
local EventYpos				= 0
local MenuButtonIndexTable	= {['err'] = 0, }
local MenuButtonWinName		= {['err'] = 0, }
local MenuButtonWinTexX		= {['err'] = 0, }

if IsKoreanLanguage() or IsEngLanguage() or IsGSPLanguage() then
	MenuButtonIndexTable	= {['err'] = 0, CHANNEL_BUTTON, CHARACTER_BUTTON, OPTION_BUTTON, QUIT_BUTTON}
	MenuButtonWinName		= {['err'] = 0, "BPM_MenuChannel", "BPM_MenuCharacter", "BPM_MenuOption", "BPM_MenuQuit"}
	MenuButtonWinTexX		= {['err'] = 0,		  258,				 936,					86,				0}
	MenuButtonWinTexY		= {['err'] = 0,		  425,				 868,					425,			425}
	EventYpos				= 569
else
	MenuButtonIndexTable	= {['err'] = 0, CHANNEL_BUTTON, CHARACTER_BUTTON, LOGOUT_BUTTON, OPTION_BUTTON, QUIT_BUTTON}
	MenuButtonWinName		= {['err'] = 0, "BPM_MenuChannel", "BPM_MenuCharacter", "BPM_MenuLogOut", "BPM_MenuOption", "BPM_MenuQuit"}
	MenuButtonWinTexX		= {['err'] = 0,		  258,				 936,					172,				 86,			0}
	MenuButtonWinTexY		= {['err'] = 0,		  425,				 868,					425,				 425,			425}
	EventYpos				= 530
end


--------------------------------------------------------------------
-- �޴���ư �����̳�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BPM_MenuButtonContainer")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(4);
mywindow:setPosition(932, 300)--(2, 569)
mywindow:setSize(86, #MenuButtonWinName * 39)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("BPM_MenuController", "BottomMenuUpEvent", "y", "Sine_EaseInOut", 724 , EventYpos, 3, true, false, 10);
mywindow:addController("BPM_MenuController", "BottomMenuDownEvent", "y", "Sine_EaseInOut", EventYpos , 724, 3, true, false, 10);
--mywindow:addController("BPM_MenuController", "BottomMenuUpEvent", "yoffset", "Quartic_EaseIn", 0, 156, 5, true, false, 10);
--mywindow:addController("BPM_MenuController", "BottomMenuDownEvent", "yoffset", "Quartic_EaseIn", 156, 0, 5, true, false, 10);
mywindow:subscribeEvent("MotionEventEnd", "MenuEventEnd");
root:addChildWindow(mywindow)

RegistEscEventInfo("BPM_MenuButtonContainer", "CloseBottomMenu")


for i = 1, #MenuButtonWinName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MenuButtonWinName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i])
	mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i] +39)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i] +39*2)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i] +39*2)
	mywindow:setTexture("Enabled", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i])
	mywindow:setTexture("Disabled", "UIData/mainBG_Button002.tga", MenuButtonWinTexX[i], MenuButtonWinTexY[i] +39*3)
	mywindow:setPosition(0, (i - 1) * 39)
	mywindow:setSize(86, 39)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("BPMIndex", tostring(MenuButtonIndexTable[i]))
	mywindow:subscribeEvent("Clicked", "OnClickPageMoveBtn")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeaveMoveButton");
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnterMoveButton");
	mywindow:subscribeEvent("MouseButtonDown", "OnMouseButtonDownMoveButton");
	mywindow:subscribeEvent("MouseButtonUp", "OnMouseButtonUpMoveButton");
	winMgr:getWindow("BPM_MenuButtonContainer"):addChildWindow(mywindow);
end




--------------------------------------------------------------------
-- ���ι�ư �����̳�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BPM_ContainerImage")
mywindow:setTexture("Enabled", "UIData/mainBG_Button002.tga", 468, 156)
mywindow:setTexture("Disabled", "UIData/mainBG_Button002.tga", 468, 156)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(4);
mywindow:setPosition(565, 741)
mywindow:setSize(459, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:setEnabled(false)
--root:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �ϴ� �޴���ư
--------------------------------------------------------------------
PageMoveButtonWinName	= {['err'] = 0, "BPM_MoveVillageButton", "BPM_MoveFightButton", "BPM_MoveShopButton", "BPM_MoveMyroomButton", "BPM_MenuButton"}
PageMoveButtonWinTexX	= {['err'] = 0,			812,					554,				 640,					726,					468}

for i = 1, #PageMoveButtonWinName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PageMoveButtonWinName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 39)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 78)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 78)
	mywindow:setTexture("Enabled", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/mainBG_Button002.tga", PageMoveButtonWinTexX[i], 117)
	mywindow:setWideType(4);
	mywindow:setPosition(588 + 86 * (i - 1), 450)
	mywindow:setSize(86, 39)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("BPMIndex", tostring(BottomButtonIndexTable[i]))
	mywindow:subscribeEvent("Clicked", "OnClickPageMoveBtn")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeaveMoveButton");
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnterMoveButton");
	mywindow:subscribeEvent("MouseButtonDown", "OnMouseButtonDownMoveButton");
	mywindow:subscribeEvent("MouseButtonUp", "OnMouseButtonUpMoveButton");
	if CheckfacilityData(FACILITYCODE_MYSHOP) == 0 and i == 3 then
		mywindow:setEnabled(false)
	end
end

local MotionEndCheck	= false
-- �޴��� ����ش�.
function OpenBottomMenu()
	if winMgr:getWindow("BPM_MenuButtonContainer"):isVisible() then

		CloseBottomMenu()
	else
		--root:addChildWindow(winMgr:getWindow("BPM_MenuButtonContainer"));	-- 
		winMgr:getWindow("BPM_MenuButtonContainer"):activeMotion("BottomMenuUpEvent");
		winMgr:getWindow("BPM_MenuButtonContainer"):setVisible(true)
	end
	
end

-- �޴��� �ݾ��ش�.
function CloseBottomMenu()
	--winMgr:getWindow("BPM_MenuButtonContainer"):setVisible(false)
	MotionEndCheck = true
	winMgr:getWindow("BPM_MenuButtonContainer"):activeMotion("BottomMenuDownEvent");
end

-- �޴��� ��Ʈ�ѷ��� �Ϸ�Ǹ�.
function MenuEventEnd()
	if MotionEndCheck then
		winMgr:getWindow("BPM_MenuButtonContainer"):setVisible(false)
		MotionEndCheck = false
	end
end


function CheckMenu()
	if winMgr:getWindow("BPM_MenuButtonContainer"):isVisible() then
		CloseBottomMenu()
	end
end




----------------------------------------------------------------

-- �Լ���

----------------------------------------------------------------
----------------------------------------------------------------
-- �ϴ� �޴����� �Լ���
----------------------------------------------------------------
----------------------------------------------------------------
-- ����ư�� ��������
----------------------------------------------------------------
function OnClickPageMoveBtn(args)
	
	local	local_window = CEGUI.toWindowEventArgs(args).window;
	SelectIndex	= tonumber(local_window:getUserString("BPMIndex"))	-- ���õ� ��ư�� �ε���
	
	-- ��Ƽ���� ��
	if IsPartyPlaying() > 0 then
		if SelectIndex == MENU_BUTTON then			-- �޴�
			OpenBottomMenu()
		
		elseif SelectIndex == FIGHT_BUTTON then
			ShowChannelSelect()
			BtnPageMove_RequestBattleChannel();		-- ������ �ȿ��� �ٽ� üũ �Ѵܴ�.
		
		elseif SelectIndex == OPTION_BUTTON then	-- �ɼ�
			CloseBottomMenu()
			CallPopupOption()
			
		elseif SelectIndex == VILLAGE_BUTTON then	-- ����
		--	ShowVillageChannelSelect()
			BtnPageMove_RequestVillage()
		else
			if IsKoreanLanguage() then
				ShowCommonAlertOkCancelBoxWithFunction("��ƼŻ��", "�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?", "PartyCheckOkButton", "PartyCheckCancelButton")
			else
				ShowCommonAlertOkCancelBoxWithFunction("", BPM_String_PartyBan2, "PartyCheckOkButton", "PartyCheckCancelButton")
			end
		end
	else
		if SelectIndex == MENU_BUTTON then			-- �޴�
			OpenBottomMenu()
			
		elseif SelectIndex == FIGHT_BUTTON then		-- ����
			ShowChannelSelect()
			BtnPageMove_RequestBattleChannel()
			
		elseif SelectIndex == SHOP_BUTTON then		-- ��
			-- ���̷뿡�� �κ��丮 ����
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
			
			BtnPageMove_GoToItemShop()
			
		elseif SelectIndex == MYROOM_BUTTON then	-- ���̷�
			BtnPageMove_GoToMyItem()
			
		elseif SelectIndex == VILLAGE_BUTTON then	-- ����
		--	ShowVillageChannelSelect()
			BtnPageMove_RequestVillage()
			
		elseif SelectIndex == CHANNEL_BUTTON then	-- ä�μ���
			BtnPageMove_GoToWndSelectChannel()
			
		elseif SelectIndex == OPTION_BUTTON then	-- �ɼ�
			CallPopupOption()
			
		elseif SelectIndex == LOGOUT_BUTTON then	-- �α׾ƿ�
			ExitAskPopupSelected(2)
			
		elseif SelectIndex == QUIT_BUTTON then		-- ����
			CallPopupExit(0)
		elseif SelectIndex == CHARACTER_BUTTON then	-- ĳ���� ����
			BtnPageMove_GoToWndSelectCharacter()
		end	
	end
end


----------------------------------------------------------------
-- ��Ƽ���� �� �ٸ������� �̵��� �� ������ �˾� OK ��ư
----------------------------------------------------------------
function PartyCheckOkButton()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "PartyCheckOkButton" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	if SelectIndex == FIGHT_BUTTON then	-- ����
		ShowChannelSelect()
		BtnPageMove_RequestBattleChannel()
		
	elseif SelectIndex == SHOP_BUTTON then		-- ��
		BtnPageMove_GoToItemShop()
		
	elseif SelectIndex == MYROOM_BUTTON then	-- ���̷�
		BtnPageMove_GoToMyItem()
		
	elseif SelectIndex == VILLAGE_BUTTON then	-- ����
	--	ShowVillageChannelSelect()
		BtnPageMove_RequestVillage()
		
	elseif SelectIndex == CHANNEL_BUTTON then	-- ä�μ���
		BtnPageMove_GoToWndSelectChannel()
		
	elseif SelectIndex == LOGOUT_BUTTON then	-- �α׾ƿ�
		ExitAskPopupSelected(2)
		
	elseif SelectIndex == QUIT_BUTTON then		-- ����
		CallPopupExit(0)
	elseif SelectIndex == CHARACTER_BUTTON then	-- ĳ���� ����
		BtnPageMove_GoToWndSelectCharacter()
	end
end

----------------------------------------------------------------
-- ��Ƽ���� �� �ٸ������� �̵��� �� ������ �˾� CANCEL ��ư
----------------------------------------------------------------
function PartyCheckCancelButton()
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "PartyCheckCancelButton" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)	
end





------------------------------------------------------------------------
-- ��Ƽ���� �� ���������� �̵��� ������ �˾�
------------------------------------------------------------------------
function EnterPracticeToParty()	
	if IsKoreanLanguage() then
		ShowCommonAlertOkCancelBoxWithFunction("��ƼŻ��", "�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?", "OkPracticeEnter", "CancelPracticeEnter")
	else
		ShowCommonAlertOkCancelBoxWithFunction("", BPM_String_PartyBan2, "OkPracticeEnter", "CancelPracticeEnter")
	end
end


------------------------------------------------------------------------
-- ��Ƽ���� �� ���������� �̵�ok ��ư
------------------------------------------------------------------------
function OkPracticeEnter()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OkPracticeEnter" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	BtnPageMove_GoToPractice()
end


------------------------------------------------------------------------
-- ��Ƽ���� �� ���������� �̵�cancel ��ư
------------------------------------------------------------------------
function CancelPracticeEnter()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "CancelPracticeEnter" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	SetVillageInputEnable(true)
end
---------------------------------------------------------------------------------------






-----------------------------------------
----------- for Game Designer -----------
-----------------------------------------
--------------------------------------------------------------------
-- ����ư ���콺 �÷�����
--------------------------------------------------------------------
function OnMouseEnterMoveButton(args)
	PlayWave('sound/Quickmenu01.wav');
end

--------------------------------------------------------------------
-- ����ư ���콺 ��������
--------------------------------------------------------------------
function OnMouseButtonDownMoveButton(args)
	PlayWave("sound/button_click.wav");
end

--------------------------------------------------------------------
-- ����ư ���콺 ������
--------------------------------------------------------------------
function OnMouseButtonUpMoveButton(args)
	PlayWave("sound/button_click.wav");
end

--------------------------------------------------------------------
-- ����ư ���콺 ��������
--------------------------------------------------------------------
function OnMouseLeaveMoveButton(args)
--	local local_window = CEGUI.toWindowEventArgs(args).window;
--	local_window:clearActiveController();
--	local_window:activeMotion("NONE_NONE");
end



--------------------------------------------------------------------
-- ä�� �̸�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "New_ServerName_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
mywindow:setWideType(1);
mywindow:setPosition(780, 15)
mywindow:setSize(5, 5)
mywindow:setText("VILLAGE/")
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setEnabled(false)
root:addChildWindow(mywindow)	

--------------------------------------------------------------------
-- ��ġ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "New_ServerNumber_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,90,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
mywindow:setWideType(1);
mywindow:setPosition(840, 15)
mywindow:setSize(5, 5)
mywindow:setText("CHANNEL 1")
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setEnabled(false)
root:addChildWindow(mywindow)	

-- ��ġ���� ����
function SettingNewServerLocationName(ServerName)
	winMgr:getWindow("New_ServerName_Text"):setText(ServerName)
end



mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NewSystemBackImage")
mywindow:setTexture("Enabled", "UIData/menu.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/menu.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(440, 250)
mywindow:setSize(154, 194)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("NewSystemBackImage", "CloseNewSystemMenu")

------------------------------------------------------------
-- �ý��� �ݱ� ��ư
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "NewSystemCloseButton")
mywindow:setTexture("Normal", "UIData/menu.tga", 197, 0)
mywindow:setTexture("Hover", "UIData/menu.tga", 197, 23)
mywindow:setTexture("Pushed", "UIData/menu.tga",197, 46)
mywindow:setTexture("PushedOff", "UIData/menu.tga", 197, 0)
mywindow:setPosition(120, 8)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseNewSystemMenu")
winMgr:getWindow("NewSystemBackImage"):addChildWindow(mywindow)

function CloseNewSystemMenu()
	winMgr:getWindow("NewSystemBackImage"):setVisible(false);	
end

function ShowNewSystemMenu()
	if winMgr:getWindow("NewSystemBackImage"):isVisible() then
		CloseNewSystemMenu()
		return
	end
	root:addChildWindow(winMgr:getWindow("NewSystemBackImage"))
	winMgr:getWindow("NewSystemBackImage"):setVisible(true);	
end



--------------------------------------------------------------------
-- ������
--------------------------------------------------------------------
local NewMenuButtonWinName		= {['err'] = 0, }
local NewMenuButtonWinTexX		= {['err'] = 0, }
local NewMenuButtonIndexTable	= {['err'] = 0, }

if IsKoreanLanguage() or IsEngLanguage() or IsThaiLanguage() or IsGSPLanguage() then
	NewMenuButtonWinName		= {['err'] = 0, "BPM_NewMenuChannel", "BPM_NewMenuCharacter", "BPM_NewMenuOption", "BPM_NewMenuQuit"}
	NewMenuButtonIndexTable		= {['err'] = 0, CHANNEL_BUTTON, CHARACTER_BUTTON, OPTION_BUTTON, QUIT_BUTTON}
	NewMenuButtonWinTexX		= {['err'] = 0,		  220,				 220,					366,				366}
	NewMenuButtonWinTexY		= {['err'] = 0,		  0,				 104,					0,			104}
else
	NewMenuButtonWinName		= {['err'] = 0, "BPM_NewMenuChannel", "BPM_NewMenuCharacter", "BPM_NewMenuLogOut", "BPM_NewMenuOption", "BPM_NewMenuQuit"}
	NewMenuButtonIndexTable		= {['err'] = 0, CHANNEL_BUTTON, CHARACTER_BUTTON, LOGOUT_BUTTON, OPTION_BUTTON, QUIT_BUTTON}
	NewMenuButtonWinTexX		= {['err'] = 0,		 220,				 220,				366,				 366,			366}
	NewMenuButtonWinTexY		= {['err'] = 0,		  0,				 104,				208,				0,				104}
end



for i = 1, #NewMenuButtonWinName do
	mywindow = winMgr:createWindow("TaharezLook/Button", NewMenuButtonWinName[i])
	mywindow:setTexture("Normal", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i])
	mywindow:setTexture("Hover", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i] +26)
	mywindow:setTexture("Pushed", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i] +26*2)
	mywindow:setTexture("PushedOff", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i] +26*2)
	--mywindow:setTexture("Enabled", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i])
	--mywindow:setTexture("Disabled", "UIData/menu.tga", NewMenuButtonWinTexX[i], NewMenuButtonWinTexY[i] +38*3)
	mywindow:setPosition(10, 45+(i - 1) * 28)
	mywindow:setSize(146, 26)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setUserString("BPMIndex", tostring(NewMenuButtonIndexTable[i]))
	mywindow:subscribeEvent("Clicked", "OnClickPageMoveBtn")
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NewSystemBackImage"):addChildWindow(mywindow);
end

--[[
if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then--16.04.21KSG
	winMgr:getWindow("BPM_NewMenuLogOut"):setTexture("Normal", "UIData/menu.tga", 366, 208)
	winMgr:getWindow("BPM_NewMenuLogOut"):setTexture("Hover", "UIData/menu.tga", 366, 234)
	winMgr:getWindow("BPM_NewMenuLogOut"):setTexture("Pushed", "UIData/menu.tga", 366, 260)
	winMgr:getWindow("BPM_NewMenuLogOut"):setTexture("PushedOff", "UIData/menu.tga", 366, 208)
end
--]]




local MAX_CHANNEL_PAGE_COUNT = 10
local MAX_VILLAGE_CHANNEL_PAGE_COUNT = 30
curVillageChannelPage = 1
maxVillageChannelPage = 1
curBattleChannelPage = 1
maxBattleChannelPage = 1


------------------------------------------------------------

-- ä�� ���� �̹���

------------------------------------------------------------
if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then--16.04.21KSG
	DebugStr("�±� ä�μ���â ����")
	
	local scaleX			= 790;
	local scaleY			= 449;
	local commonWindowType	= 1
	
	-- ä�� ���� ��Ʈ ����â
	alphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_channelBackImage_Alpha")
	--alphaWindow:setTexture("Enabled",	"UIData/caretOn.tga", 0, 0)
	--alphaWindow:setTexture("Disabled",	"UIData/caretOn.tga", 0, 0)
	alphaWindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
	alphaWindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
	alphaWindow:setProperty("FrameEnabled",		"False")
	alphaWindow:setProperty("BackgroundEnabled","False")
	alphaWindow:setWideType(5)
	alphaWindow:setPosition(110, 161)
	alphaWindow:setSize(scaleX, scaleY+31)
	alphaWindow:setVisible(false)
	alphaWindow:setAlwaysOnTop(true)
	root:addChildWindow(alphaWindow)
	
	-- Ÿ��Ʋ �� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChannelTitle_Img")
	mywindow:setTexture("Enabled",  "UIData/mainBG_button006.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(212, 0)
	--mywindow:setSize(scaleX, 31)
	mywindow:setSize(169, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	alphaWindow:addChildWindow(mywindow)

	-- Ÿ��Ʋ �� �巡�׿�
	local mywindow = winMgr:createWindow("TaharezLook/Titlebar", "channelBackImage_Title")
	mywindow:setPosition(0, 0)
	mywindow:setSize(scaleX-30, 31)
	mywindow:setEnabled(true)
	alphaWindow:addChildWindow(mywindow)
	


	-- "����" ä�� ����
	loWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_channelBackImage_Back")
	--loWindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
	--loWindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
	loWindow:setTexture("Enabled",	"UIData/frame/frame_005.tga", 0 , 0)
	loWindow:setTexture("Disabled", "UIData/frame/frame_005.tga", 0 , 0)
	loWindow:setframeWindow(true)
	loWindow:setPosition(1, 0)
	loWindow:setSize(544+5, scaleY+30)
	loWindow:setVisible(false)
	loWindow:setAlwaysOnTop(false)
	loWindow:setZOrderingEnabled(false)
	--CreateNewFrameSetWindow(loWindow:getName(), 544+5, scaleY+30, 1)
	alphaWindow:addChildWindow(loWindow:getName())
	
	-- "����" ä�� ���� �̹���
	loWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_channelBackImage")
	--loWindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
	--loWindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
	loWindow:setTexture("Enabled",	"UIData/frame/frame_003.tga", 0 , 0)
	loWindow:setTexture("Disabled", "UIData/frame/frame_003.tga", 0 , 0)
	loWindow:setframeWindow(true)
	loWindow:setPosition(3, 28)
	loWindow:setSize(544, scaleY)
	loWindow:setVisible(false)
	loWindow:setAlwaysOnTop(false)
	loWindow:setZOrderingEnabled(false)
	loWindow:subscribeEvent("EndRender", "EndRenderVillageChannelPageNumber")
	--CreateNewFrameSetWindow(loWindow:getName(), 544, scaleY, 2)
	alphaWindow:addChildWindow(loWindow:getName())
	
	
	
	
	
	
	-- "����" ä�� ����
	loWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battlechannelBackImage_Back")
	--loWindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
	--loWindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
	loWindow:setTexture("Enabled",	"UIData/frame/frame_002.tga", 0 , 0)
	loWindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0 , 0)
	loWindow:setframeWindow(true)
	loWindow:setPosition(548, 0)
	loWindow:setSize(243, scaleY+30)
	loWindow:setVisible(false)
	loWindow:setAlwaysOnTop(false)
	loWindow:setZOrderingEnabled(false)
	--CreateNewFrameSetWindow(loWindow:getName(), 243, scaleY+30, 1)
	alphaWindow:addChildWindow(loWindow:getName())
	
	-- "����" ä�� ���� �̹���
	loWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battlechannelBackImage")
	--loWindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
	--loWindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
	loWindow:setTexture("Enabled",	"UIData/frame/frame_004.tga", 0 , 0)
	loWindow:setTexture("Disabled", "UIData/frame/frame_004.tga", 0 , 0)
	loWindow:setframeWindow(true)
	loWindow:setPosition(552, 28)
	loWindow:setSize(238, scaleY)
	loWindow:setVisible(false)
	loWindow:setAlwaysOnTop(false)
	loWindow:setZOrderingEnabled(false)
	loWindow:subscribeEvent("EndRender", "EndRenderBattleChannelPageNumber")
	--CreateNewFrameSetWindow(loWindow:getName(), 238, scaleY, 3)
	alphaWindow:addChildWindow(loWindow:getName())
	
	
	-- ���� Ÿ��Ʋ �� �̹���1
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChannelTitle_Img_Battle")
	mywindow:setTexture("Enabled",  "UIData/frame/frame_005.tga", 0, 227)
	mywindow:setTexture("Disabled", "UIData/frame/frame_005.tga", 0, 227)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(547, 3)
	--mywindow:setSize(scaleX, 31)
	mywindow:setSize(200, 29)
	mywindow:setScaleWidth(312)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	alphaWindow:addChildWindow(mywindow)
	
	-- ���� Ÿ��Ʋ �� �̹���2 ( ���� ui. �̹��� 3��ø�. �׷��������� order���� )
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChannelTitle_Img_Battle2")
	mywindow:setTexture("Enabled",  "UIData/mainBG_button006.tga", 169, 0)
	mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 169, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(610, 0)
	if IsEngLanguage() or IsGSPLanguage() then 
		mywindow:setPosition(590, 0)
	end
	mywindow:setSize(190, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	alphaWindow:addChildWindow(mywindow)
	
	
	
	
	
else

	DebugStr("�ٸ����� ä�μ���â ����")
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_channelBackImage")
	mywindow:setTexture("Enabled",  "UIData/mainBG_button003.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6)
	mywindow:setPosition(266, 161)
	mywindow:setSize(489, 449)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("EndRender", "EndRenderChannelPageNumber")
	root:addChildWindow(mywindow)
	
	
end

------------------------------------------------------------
-- ä�� ��ư(x ��ư)
------------------------------------------------------------
if IsThaiLanguage() then--16.04.21KSG
	------------------------------------------------------------
	-- ä�� ��ư(x ��ư)
	------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_channelCloseButton")
	mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 214, 245)
	mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 214, 267)
	mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 214, 289)
	mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 214, 311)
	--mywindow:setPosition(456, 10)
	mywindow:setPosition(153, 7)
	mywindow:setSize(22, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "ClosedChannelImage")
	--winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	--winMgr:getWindow("ChannelTitle_Img"):addChildWindow(mywindow)
	winMgr:getWindow("ChannelTitle_Img_Battle2"):addChildWindow(mywindow)
	
	
	-- �������� ä�μ��� �̹��� ESCŰ, ENTERŰ ��� 	
	RegistEscEventInfo("sj_channelBackImage_Alpha", "ClosedChannelImage")
elseif IsEngLanguage() or IsGSPLanguage() then--16.04.21KSG
	------------------------------------------------------------
	-- ä�� ��ư(x ��ư)
	------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_channelCloseButton")
	mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 214, 245)
	mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 214, 267)
	mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 214, 289)
	mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 214, 311)
	--mywindow:setPosition(456, 10)
	mywindow:setPosition(170, 7)
	mywindow:setSize(22, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "ClosedChannelImage")
	--winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	--winMgr:getWindow("ChannelTitle_Img"):addChildWindow(mywindow)
	winMgr:getWindow("ChannelTitle_Img_Battle2"):addChildWindow(mywindow)
	
	
	-- �������� ä�μ��� �̹��� ESCŰ, ENTERŰ ��� 	
	RegistEscEventInfo("sj_channelBackImage_Alpha", "ClosedChannelImage")
else
	------------------------------------------------------------
	-- ä�� ��ư(x ��ư)
	------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_channelCloseButton")
	mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 762, 936)
	mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 762, 958)
	mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 762, 980)
	mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 762, 936)
	mywindow:setPosition(456, 10)
	mywindow:setSize(22, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "ClosedChannelImage")
	winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	
	-- �������� ä�μ��� �̹��� ESCŰ, ENTERŰ ��� 	
	RegistEscEventInfo("sj_channelBackImage", "ClosedChannelImage")
end



if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- ��--16.04.21KSG
	
	function OpenChannelImage() -- ä�� ���� ��ư Ŭ�� rlghd
		DebugStr("New ä�� ���� Ŭ��")
		
		if winMgr:getWindow("sj_channelBackImage"):isVisible() then
			ClosedChannelImage()
			return
		end
		
		root:addChildWindow(winMgr:getWindow("Popup_AlphaBackImg"))
		
		root:addChildWindow(winMgr:getWindow("sj_channelBackImage_Alpha"))
		--root:addChildWindow(winMgr:getWindow("ChannelTitle_Img"))
		--root:addChildWindow(winMgr:getWindow("sj_channelBackImage"))
		--root:addChildWindow(winMgr:getWindow("sj_battlechannelBackImage"))
		root:addChildWindow(winMgr:getWindow("sj_BattleChannelInfo_eventToltip"))
		
		winMgr:getWindow("Popup_AlphaBackImg"):setVisible(true)
		winMgr:getWindow("sj_channelBackImage_Alpha"):setVisible(true)
		winMgr:getWindow("ChannelTitle_Img"):setVisible(true)
		
		winMgr:getWindow("sj_channelBackImage_Back"):setVisible(true)
		winMgr:getWindow("sj_battlechannelBackImage_Back"):setVisible(true)
		
		winMgr:getWindow("sj_channelBackImage"):setVisible(true)
		winMgr:getWindow("sj_battlechannelBackImage"):setVisible(true)
		
		BtnPageMove_RequestChannelInfo()
	end

	function ClosedChannelImage()
		if winMgr:getWindow("Popup_AlphaBackImg") then
			winMgr:getWindow("Popup_AlphaBackImg"):setVisible(false)
		end
		
		if winMgr:getWindow("sj_channelBackImage") then
			winMgr:getWindow("sj_channelBackImage_Alpha"):setVisible(false)
			winMgr:getWindow("ChannelTitle_Img"):setVisible(false)
		
			winMgr:getWindow("sj_channelBackImage_Back"):setVisible(false)
			winMgr:getWindow("sj_battlechannelBackImage_Back"):setVisible(false)
		
			winMgr:getWindow("sj_channelBackImage"):setVisible(false)
			winMgr:getWindow("sj_battlechannelBackImage"):setVisible(false)
		end
		
		BtnPageMove_BattleChannelClose()
		SetVillageInputEnable(true)
	end
	
else
	
	
	function OpenChannelImage() -- ä�� ���� ��ư Ŭ�� rlghd
		DebugStr("ä�� ���� Ŭ��")
		
		if winMgr:getWindow("sj_channelBackImage"):isVisible() then
			ClosedChannelImage()
			return
		end
			
		root:addChildWindow(winMgr:getWindow("Popup_AlphaBackImg"))
		root:addChildWindow(winMgr:getWindow("sj_channelBackImage"))
		root:addChildWindow(winMgr:getWindow("sj_BattleChannelInfo_eventToltip"))
		winMgr:getWindow("Popup_AlphaBackImg"):setVisible(true)
		winMgr:getWindow("sj_channelBackImage"):setVisible(true)
		
		BtnPageMove_RequestChannelInfo()
	end

	function ClosedChannelImage()
		if winMgr:getWindow("Popup_AlphaBackImg") then
			winMgr:getWindow("Popup_AlphaBackImg"):setVisible(false)
		end
		
		if winMgr:getWindow("sj_channelBackImage") then
			winMgr:getWindow("sj_channelBackImage"):setVisible(false)
		end
		BtnPageMove_BattleChannelClose()
		SetVillageInputEnable(true)
	end
end



function EndRenderChannelPageNumber(args)
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	
	curVillageChannelPage = GetCurrentVillageChannelPage()
	curBattleChannelPage = GetCurrentBattleChannelPage()
	
		
	local pageText = tostring(curVillageChannelPage.." / "..maxVillageChannelPage)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, pageText)
	drawer:drawText(pageText, 120-size/2, 416)
	
	local pageText = tostring(curBattleChannelPage.." / "..maxBattleChannelPage)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, pageText)
	drawer:drawText(pageText, 370-size/2, 416)
end



function EndRenderVillageChannelPageNumber(args) -- ����
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	curVillageChannelPage = GetCurrentVillageChannelPage()
	
	local pageText = tostring(curVillageChannelPage.." / "..maxVillageChannelPage)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, pageText)
	drawer:drawText(pageText, 275-size/2, 422)
end

function EndRenderBattleChannelPageNumber(args) -- ��Ʋ ä��
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	curBattleChannelPage = GetCurrentBattleChannelPage()
	
	local pageText = tostring(curBattleChannelPage.." / "..maxBattleChannelPage)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, pageText)
	drawer:drawText(pageText, 120-size/2, 422)
end


------------------------------------------------------------

-- ���� ä��

------------------------------------------------------------
if IsThaiLanguage() or IsGSPLanguage() then--16.04.21KSG
	tVilllageChannelTypeValue = {["err"]=0, [0]=4, 1}	-- 0:��2����, 1:��3����, 2:��4����, 3:��5����, 4:��6����, 5:��Ʋ
	
	tVilllageChannelTypeTexX = {["err"]=0, [0]=0, 86}
	tVilllageChannelTypePosX = {["err"]=0, [0]=4, 89}

	for i=0, #tVilllageChannelTypeValue do	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_villageChannelType") -- �ǹ�ư
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 145)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 170)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setPosition(tVilllageChannelTypePosX[i], 12)
		mywindow:setSize(86, 25)
		mywindow:setProperty("GroupID", 5771)
		mywindow:setUserString("villageChannelType", tVilllageChannelTypeValue[i])
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", "ChangeSelectVilllageChannelType")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		if CheckfacilityData(FACILITYCODE_ZONE2 + tVilllageChannelTypeValue[i]) == 1 then
			mywindow:setEnabled(true)
			mywindow:setVisible(true)
		else
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		end
	end

	function ChangeSelectVilllageChannelType(args)
		local local_window = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			local szVillageChannelType = local_window:getUserString("villageChannelType")
			local villageChannelType = tonumber(szVillageChannelType)
			SetVillageTypeIndex(villageChannelType)
		end
	end
	
	offset = 12
	tNewVillageChannelPosX = { ["err"]=0, [0]=1+offset, 175+offset, 349+offset }
	ChannelPosXIndex = 0;
	ChannelPosYIndex = 0;
	
	for i=0, MAX_VILLAGE_CHANNEL_PAGE_COUNT-1 do
		-- ä�� ���� ��ư
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_VillageChannelInfoBackImage")
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga", 0, 31)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga", 0, 105)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga", 0, 105)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga", 0, 29)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga", 0, 29)
		--mywindow:setPosition(6, 40+(i*34))
		mywindow:setPosition(tNewVillageChannelPosX[ChannelPosXIndex], 40+(ChannelPosYIndex*37))
		
		mywindow:setSize(169, 40)
		mywindow:setProperty("GroupID", 5774)
		mywindow:setVisible(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("MouseDoubleClicked", "CheckGoVillage")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		-- 1. ä�� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_VillageChannelInfo_NameText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
		mywindow:setPosition(10, 4)
		mywindow:setSize(50, 20)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)	
			
		-- 2. ä�� ȥ�� �׷��� rkawk
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyStateBack")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		--mywindow:setSize(134, 10)
		mywindow:setSize(107, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
			
		-- 3. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyState")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		--mywindow:setSize(134, 10)
		mywindow:setSize(107, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
		
		-- 4. �����ư
		mywindow = winMgr:createWindow("TaharezLook/Button", i.."sj_VillageChannelInfo_EnterButton")
		mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 173, 245)
		mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 173, 270)
		mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 173, 320)
		mywindow:setTexture("Enabled",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setTexture("Disabled",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setPosition(122, 6)
		mywindow:setSize(41, 25)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("Clicked", "CheckGoVillage")
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
		
		
		if i == 9 then
			ChannelPosXIndex = ChannelPosXIndex + 1;
			ChannelPosYIndex = 0;
		elseif i == 19 then
			ChannelPosXIndex = ChannelPosXIndex + 1;
			ChannelPosYIndex = 0;
		else
			ChannelPosYIndex = ChannelPosYIndex + 1;
		end
	end
	
elseif IsEngLanguage() then
	tVilllageChannelTypeValue = {["err"]=0, [0]=4 }	-- 0:��2����, 1:��3����, 2:��4����, 3:��5����, 4:��6����, 5:��Ʋ
	
	tVilllageChannelTypeTexX = {["err"]=0, [0]=0, 86}
	tVilllageChannelTypePosX = {["err"]=0, [0]=4, 89}
	for i=0, #tVilllageChannelTypeValue do	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_villageChannelType") -- �ǹ�ư
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 145)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 170)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 195)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga",	tVilllageChannelTypeTexX[i], 220)
		mywindow:setPosition(tVilllageChannelTypePosX[i], 12)
		mywindow:setSize(86, 25)
		mywindow:setProperty("GroupID", 5771)
		mywindow:setUserString("villageChannelType", tVilllageChannelTypeValue[i])
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", "ChangeSelectVilllageChannelType")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		if CheckfacilityData(FACILITYCODE_ZONE2 + tVilllageChannelTypeValue[i]) == 1 then
			mywindow:setEnabled(true)
			mywindow:setVisible(true)
		else
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		end
	end

	function ChangeSelectVilllageChannelType(args)
		local local_window = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			local szVillageChannelType = local_window:getUserString("villageChannelType")
			local villageChannelType = tonumber(szVillageChannelType)
			SetVillageTypeIndex(villageChannelType)
		end
	end
	
	offset = 12
	tNewVillageChannelPosX = { ["err"]=0, [0]=1+offset, 175+offset, 349+offset }
	ChannelPosXIndex = 0;
	ChannelPosYIndex = 0;
	
	for i=0, MAX_VILLAGE_CHANNEL_PAGE_COUNT-1 do
		-- ä�� ���� ��ư
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_VillageChannelInfoBackImage")
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga", 0, 31)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga", 0, 105)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga", 0, 105)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga", 0, 67)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga", 0, 29)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga", 0, 29)
		--mywindow:setPosition(6, 40+(i*34))
		mywindow:setPosition(tNewVillageChannelPosX[ChannelPosXIndex], 40+(ChannelPosYIndex*37))
		
		mywindow:setSize(169, 40)
		mywindow:setProperty("GroupID", 5774)
		mywindow:setVisible(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("MouseDoubleClicked", "CheckGoVillage")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		-- 1. ä�� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_VillageChannelInfo_NameText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
		mywindow:setPosition(10, 4)
		mywindow:setSize(50, 20)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)	
			
		-- 2. ä�� ȥ�� �׷��� rkawk
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyStateBack")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		--mywindow:setSize(134, 10)
		mywindow:setSize(107, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
			
		-- 3. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyState")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		--mywindow:setSize(134, 10)
		mywindow:setSize(107, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
		
		-- 4. �����ư
		mywindow = winMgr:createWindow("TaharezLook/Button", i.."sj_VillageChannelInfo_EnterButton")
		mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 173, 245)
		mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 173, 270)
		mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 173, 320)
		mywindow:setTexture("Enabled",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setTexture("Disabled",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setPosition(122, 6)
		mywindow:setSize(41, 25)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("Clicked", "CheckGoVillage")
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
		
		
		if i == 9 then
			ChannelPosXIndex = ChannelPosXIndex + 1;
			ChannelPosYIndex = 0;
		elseif i == 19 then
			ChannelPosXIndex = ChannelPosXIndex + 1;
			ChannelPosYIndex = 0;
		else
			ChannelPosYIndex = ChannelPosYIndex + 1;
		end
	end

else


	tVilllageChannelTypeValue = {["err"]=0, [0]=4, 1}	-- 0:��2����, 1:��3����, 2:��4����, 3:��5����, 4:��6����, 5:��Ʋ
	tVilllageChannelTypeTexX = {["err"]=0, [0]=0, 55}
	tVilllageChannelTypePosX = {["err"]=0, [0]=12, 68}

	for i=0, #tVilllageChannelTypeValue do	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_villageChannelType") -- �ǹ�ư
		mywindow:setTexture("Normal",			"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 509)
		mywindow:setTexture("Hover",			"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 534)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 559)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 509)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 559)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 509)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button003.tga",	tVilllageChannelTypeTexX[i], 584)
		--mywindow:setPosition(tVilllageChannelTypePosX[i], 10)
		--mywindow:setSize(86, 25)
		mywindow:setPosition(tVilllageChannelTypePosX[i], 39)
		mywindow:setSize(55, 25)
		mywindow:setProperty("GroupID", 5771)
		mywindow:setUserString("villageChannelType", tVilllageChannelTypeValue[i])
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", "ChangeSelectVilllageChannelType")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		if CheckfacilityData(FACILITYCODE_ZONE2 + tVilllageChannelTypeValue[i]) == 1 then
			mywindow:setEnabled(true)
			mywindow:setVisible(true)
		else
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		end
	end

	function ChangeSelectVilllageChannelType(args)
		local local_window = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			local szVillageChannelType = local_window:getUserString("villageChannelType")
			local villageChannelType = tonumber(szVillageChannelType)
			SetVillageTypeIndex(villageChannelType)
		end
	end
	
	
	for i=0, MAX_CHANNEL_PAGE_COUNT-1 do
	
		-- ä�� ���� ��ư
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_VillageChannelInfoBackImage")
		mywindow:setTexture("Normal",			"UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("Hover",			"UIData/mainBG_button003.tga", 214, 644)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button003.tga", 214, 609)
		mywindow:setPosition(20, 68+(i*34))
		mywindow:setSize(209, 35)
		mywindow:setProperty("GroupID", 5774)
		mywindow:setVisible(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("MouseDoubleClicked", "CheckGoVillage")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		-- 1. ä�� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_VillageChannelInfo_NameText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
		mywindow:setPosition(10, 2)
		mywindow:setSize(50, 20)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)	
			
		-- 2. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyStateBack")
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
			
		-- 3. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_VillageChannelInfo_BusyState")
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
		
		-- 4. �����ư
		mywindow = winMgr:createWindow("TaharezLook/Button", i.."sj_VillageChannelInfo_EnterButton")
		mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 173, 609)
		mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 173, 634)
		mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 173, 659)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 173, 659)
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 173, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 173, 684)
		mywindow:setPosition(162, 5)
		mywindow:setSize(41, 25)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("villagechannelNumber", tostring(i))
		mywindow:subscribeEvent("Clicked", "CheckGoVillage")
		winMgr:getWindow(i.."sj_VillageChannelInfoBackImage"):addChildWindow(mywindow)
	end


end -- end of CUrrentLangage





------------------------------------------------------------
-- ������ ��, �� ��ư 
------------------------------------------------------------
if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- ��--16.04.21KSG

	tVillageChannelButtonName  = { ["protecterr"]=0, "sj_villageChannel_LButton", "sj_villageChannel_RButton" }
	tVillageChannelButtonTexX  = { ["protecterr"]=0, 134, 153 }
	tVillageChannelButtonPosX  = { ["protecterr"]=0, 225, 225+82 } -- ������ 82
	tVillageChannelButtonEvent = { ["protecterr"]=0, "ClickedVillageChannel_Left", "ClickedVillageChannel_Right" }
	
	for i=1, #tVillageChannelButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tVillageChannelButtonName[i])
		mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", tVillageChannelButtonTexX[i], 245)
		mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", tVillageChannelButtonTexX[i], 268)
		mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", tVillageChannelButtonTexX[i], 291)
		mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", tVillageChannelButtonTexX[i], 291)
		mywindow:setPosition(tVillageChannelButtonPosX[i], 415)
		mywindow:setSize(19, 23)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", tVillageChannelButtonEvent[i])
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	end

	function ClickedVillageChannel_Left(args)
		curVillageChannelPage = GetCurrentVillageChannelPage()
		if curVillageChannelPage == 1 then
			return
		end
		curVillageChannelPage = curVillageChannelPage - 1
		SetCurrentVillageChannelPage(curVillageChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function ClickedVillageChannel_Right(args)
		curVillageChannelPage = GetCurrentVillageChannelPage()
		if curVillageChannelPage == maxVillageChannelPage then
			return
		end
		curVillageChannelPage = curVillageChannelPage + 1
		SetCurrentVillageChannelPage(curVillageChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function SetVillageMaxChannelPage(maxChannelPage)
		maxVillageChannelPage = maxChannelPage
	end
else
	
	
	tVillageChannelButtonName  = { ["protecterr"]=0, "sj_villageChannel_LButton", "sj_villageChannel_RButton" }
	tVillageChannelButtonTexX  = { ["protecterr"]=0, 134, 153 }
	tVillageChannelButtonPosX  = { ["protecterr"]=0, 70, 152 }
	tVillageChannelButtonEvent = { ["protecterr"]=0, "ClickedVillageChannel_Left", "ClickedVillageChannel_Right" }
	for i=1, #tVillageChannelButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tVillageChannelButtonName[i])
		mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", tVillageChannelButtonTexX[i], 609)
		mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", tVillageChannelButtonTexX[i], 632)
		mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", tVillageChannelButtonTexX[i], 655)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", tVillageChannelButtonTexX[i], 609)
		mywindow:setPosition(tVillageChannelButtonPosX[i], 410)
		mywindow:setSize(19, 23)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", tVillageChannelButtonEvent[i])
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	end


	function ClickedVillageChannel_Left(args)
		curVillageChannelPage = GetCurrentVillageChannelPage()
		if curVillageChannelPage == 1 then
			return
		end
		curVillageChannelPage = curVillageChannelPage - 1
		SetCurrentVillageChannelPage(curVillageChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function ClickedVillageChannel_Right(args)
		curVillageChannelPage = GetCurrentVillageChannelPage()
		if curVillageChannelPage == maxVillageChannelPage then
			return
		end
		curVillageChannelPage = curVillageChannelPage + 1
		SetCurrentVillageChannelPage(curVillageChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function SetVillageMaxChannelPage(maxChannelPage)
		maxVillageChannelPage = maxChannelPage
	end
	
end



function SelectCurrentVillageChannelType(currentChannelType)
	for i=0, #tVilllageChannelTypeValue do
		if tVilllageChannelTypeValue[i] == currentChannelType then
			if CheckfacilityData(FACILITYCODE_ZONE2 + tVilllageChannelTypeValue[i]) == 1 then
				winMgr:getWindow(i.."sj_villageChannelType"):setEnabled(true)
			else
				winMgr:getWindow(i.."sj_villageChannelType"):setEnabled(false)
			end
			CEGUI.toRadioButton(winMgr:getWindow(i.."sj_villageChannelType")):setSelected(true)
		else
			if CheckfacilityData(FACILITYCODE_ZONE2 + tVilllageChannelTypeValue[i]) == 1 then
				winMgr:getWindow(i.."sj_villageChannelType"):setEnabled(true)
			else
				winMgr:getWindow(i.."sj_villageChannelType"):setEnabled(false)
			end
			CEGUI.toRadioButton(winMgr:getWindow(i.."sj_villageChannelType")):setSelected(false)
		end
	end
end

function SelectCurrentVillageChannel(isCurrentBattleChannel)
	if isCurrentBattleChannel >= 0 then
		CEGUI.toRadioButton(winMgr:getWindow(isCurrentBattleChannel.."sj_VillageChannelInfoBackImage")):setSelected(true)
	end
end


------------------------------------------------------------------------
-- ��Ƽ���� �� �������� �̵��� ������ �˾�
------------------------------------------------------------------------
function CheckGoVillage(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	local channelNumber = tonumber(local_window:getUserString("villagechannelNumber"))
	--ClosedChannelImage()
	BtnPageMove_GoToVillage(channelNumber)
	
	-- ���̷뿡�� �κ��丮 ����
	winMgr:getWindow("MainBar_Bag"):setEnabled(true)
end




------------------------------------------------------------

-- ���� ä��

------------------------------------------------------------

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage()  then -- ��--16.04.21KSG
	-- ������ ä�� ���� ��
	
	g_currentBattleChannelClickIndex = -1
	tBattleChannelTypeValue = {["err"]=0, [0]=0, 4, 2, 5}	-- 0:�Ϲ�, 2:Ŭ��, 4:Ÿ��, 5:gm�̺�Ʈ
	tBattleChannelTypeTexX  = {["err"]=0, [0]=172, 227, 282, 337}
	tBattleChannelTypePosX  = {["err"]=0, [0]=255, 311, 367, 423}

	for i=0, #tBattleChannelTypeValue do
		
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_battleChannelType")
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 145)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 170)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 195)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 220)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 195)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 195)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 220)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga", tBattleChannelTypeTexX[i], 220)
		mywindow:setPosition((i*55) + 4 , 12)
		mywindow:setSize(55, 25)
		mywindow:setProperty("GroupID", 5773)
		mywindow:setUserString("battleChannelType", tBattleChannelTypeValue[i])
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", "ChangeSelectBattleChannelType")
		winMgr:getWindow("sj_battlechannelBackImage"):addChildWindow(mywindow)
		
		
		-- 2:Ŭ��
		if tBattleChannelTypeValue[i] == 2 then
			
			if CheckfacilityData(FACILITYCODE_GANG_PVP) == 1 then
				mywindow:setEnabled(true)
			else
				mywindow:setEnabled(false)
			end
			
			mywindow:setVisible(true)

		-- 4:Ÿ��
		elseif tBattleChannelTypeValue[i] == 4 then

			mywindow:setEnabled(true)
			--mywindow:setEnabled(false)
			mywindow:setVisible(true)
		
		-- 5:gm�̺�Ʈ
		elseif tBattleChannelTypeValue[i] == 5 then
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		else
			mywindow:setEnabled(true)
			mywindow:setVisible(true)
		end
	end



	function ChangeSelectBattleChannelType(args)
		local local_window = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			local szBattleChannelType = local_window:getUserString("battleChannelType")
			local battleChannelType = tonumber(szBattleChannelType)

			SetBattleTypeIndex(battleChannelType)
		end
	end


	for i=0, MAX_CHANNEL_PAGE_COUNT-1 do -- ��Ʋ ä��
		-- ä�� ���� ��ư
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_BattleChannelInfoBackImage")
		mywindow:setTexture("Normal",			"UIData/mainBG_button006.tga", 169, 31)
		mywindow:setTexture("Hover",			"UIData/mainBG_button006.tga", 169, 69)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button006.tga", 169, 107)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button006.tga", 169, 69)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button006.tga", 169, 69)
		--mywindow:setPosition(262, 68+(i*34))
		mywindow:setPosition(14, 39+(i*37)) -- 68
		mywindow:setSize(209, 35)
		mywindow:setProperty("GroupID", 5774)
		mywindow:setVisible(false)
		mywindow:setUserString("battlechannelNumber", tostring(i))
		mywindow:setUserString("eventChannelIndex", 0)
		mywindow:subscribeEvent("MouseDoubleClicked", "CheckGoBattle")
		mywindow:subscribeEvent("MouseMove",  "OnMouseMove_BattleChannel")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_BattleChannel")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_BattleChannel")
		winMgr:getWindow("sj_battlechannelBackImage"):addChildWindow(mywindow)
		
		-- 1. ä�� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_NameText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
		mywindow:setPosition(6, 2)
		mywindow:setSize(50, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 2. ä�� ���� ���� ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_LevelText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(150, 150, 150, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(75, 4)
		mywindow:setSize(70, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 3. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_BattleChannelInfo_BusyStateBack")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
			
		-- 4. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_BattleChannelInfo_BusyState")
		mywindow:setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, 245)
		mywindow:setTexture("Disabled", "UIData/mainBG_button006.tga", 0, 245)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
		
		-- 5. Ÿ���� ���� ������
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_CurrentUserText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(150, 150, 150, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(119, 4)
		mywindow:setSize(50, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 6. �����ư
		mywindow = winMgr:createWindow("TaharezLook/Button", i.."sj_BattleChannelInfo_EnterButton")
		mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", 173, 245)
		mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", 173, 270)
		mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", 173, 295)
		mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", 173, 320)
		mywindow:setTexture("Enabled",		"UIData/mainBG_button006.tga", 173, 320)
		mywindow:setTexture("Disabled",		"UIData/mainBG_button006.tga", 173, 320)
		mywindow:setPosition(164, 7)
		mywindow:setSize(41, 25)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("battlechannelNumber", tostring(i))
		mywindow:setUserString("eventChannelIndex", 0)
		mywindow:subscribeEvent("Clicked", "CheckGoBattle")
		mywindow:subscribeEvent("MouseMove",  "OnMouseMove_EnterButton")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_EnterButton")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_EnterButton")
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
	end
else
	-- ���� ä�� ���� �κ�. ��
	
	g_currentBattleChannelClickIndex = -1
	tBattleChannelTypeValue = {["err"]=0, [0]=0, 4, 2, 5}	-- 0:�Ϲ�, 2:Ŭ��, 4:Ÿ��, 5:gm�̺�Ʈ
	tBattleChannelTypeTexX = {["err"]=0, [0]=110, 220, 165, 275}
	tBattleChannelTypePosX = {["err"]=0, [0]=255, 311, 367, 423}

	-- �ѱ���
	tBattleChannelTypeValue_kor = {["err"]=0, [0]=0, 4, 2, 5} --{["err"]=0, [0]=0, 2, 4, 5}	-- 0:�Ϲ�, 2:Ŭ��, 4:Ÿ��, 5:gm�̺�Ʈ
	tBattleChannelTypeTexX_kor = {["err"]=0, [0]=110, 220, 165, 275} --{["err"]=0, [0]=110, 165, 220, 275}
	tBattleChannelTypePosX_kor = {["err"]=0, [0]=255, 311, 367, 423}
	for i=0, #tBattleChannelTypeValue do

		if IsKoreanLanguage() then
			tBattleChannelTypeValue[i] = tBattleChannelTypeValue_kor[i]
			tBattleChannelTypeTexX[i] = tBattleChannelTypeTexX_kor[i]
			tBattleChannelTypePosX[i] = tBattleChannelTypePosX_kor[i]
		end
		
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_battleChannelType")
		mywindow:setTexture("Normal",			"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 509)
		mywindow:setTexture("Hover",			"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 534)
		mywindow:setTexture("Pushed",			"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 559)
		mywindow:setTexture("PushedOff",		"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 509)
		mywindow:setTexture("SelectedNormal",	"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedHover",	"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedPushed",	"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 559)
		mywindow:setTexture("SelectedPushedOff","UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 559)
		mywindow:setTexture("Enabled",			"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 509)
		mywindow:setTexture("Disabled",			"UIData/mainBG_button003.tga", tBattleChannelTypeTexX[i], 584)
		mywindow:setPosition(tBattleChannelTypePosX[i], 39)
		mywindow:setSize(55, 25)
		mywindow:setProperty("GroupID", 5773)
		mywindow:setUserString("battleChannelType", tBattleChannelTypeValue[i])
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", "ChangeSelectBattleChannelType")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		
		-- 2:Ŭ��
		if tBattleChannelTypeValue[i] == 2 then
			
			if CheckfacilityData(FACILITYCODE_GANG_PVP) == 1 then
				mywindow:setEnabled(true)
			else
				mywindow:setEnabled(false)
			end
				
			mywindow:setVisible(true)

		-- 4:Ÿ��
		elseif tBattleChannelTypeValue[i] == 4 then

			if CheckfacilityData(FACILITYCODE_GANG_WAR) == 1 then
				mywindow:setEnabled(true)
			else
				mywindow:setEnabled(false)
			end


			mywindow:setVisible(true)
		
		-- 5:gm�̺�Ʈ
		elseif tBattleChannelTypeValue[i] == 5 then
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		else
			mywindow:setEnabled(true)
			mywindow:setVisible(true)
		end
	end



	function ChangeSelectBattleChannelType(args)
		local local_window = CEGUI.toWindowEventArgs(args).window
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			local szBattleChannelType = local_window:getUserString("battleChannelType")
			local battleChannelType = tonumber(szBattleChannelType)
			
			SetBattleTypeIndex(battleChannelType)
		end
	end


	for i=0, MAX_CHANNEL_PAGE_COUNT-1 do

		-- ä�� ���� ��ư
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_BattleChannelInfoBackImage")
		mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 214, 644)
		mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("SelectedNormal", "UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedHover", "UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedPushed", "UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("SelectedPushedOff", "UIData/mainBG_button003.tga", 214, 679)
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 214, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 214, 609)
		mywindow:setPosition(262, 68+(i*34))
		mywindow:setSize(209, 35)
		mywindow:setProperty("GroupID", 5774)
		mywindow:setVisible(false)
		mywindow:setUserString("battlechannelNumber", tostring(i))
		mywindow:setUserString("eventChannelIndex", 0)
		mywindow:subscribeEvent("MouseDoubleClicked", "CheckGoBattle")
		mywindow:subscribeEvent("MouseMove",  "OnMouseMove_BattleChannel")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_BattleChannel")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_BattleChannel")
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
		
		-- 1. ä�� �̸�
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_NameText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)	
		mywindow:setPosition(6, 2)
		mywindow:setSize(50, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 2. ä�� ���� ���� ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_LevelText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(150, 150, 150, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(75, 4)
		mywindow:setSize(70, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 3. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_BattleChannelInfo_BusyStateBack")
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
			
		-- 4. ä�� ȥ�� �׷���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_BattleChannelInfo_BusyState")
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 0, 609)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(10, 20)
		mywindow:setSize(134, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
		
		-- 5. Ÿ���� ���� ������
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_BattleChannelInfo_CurrentUserText")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(150, 150, 150, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(119, 4)
		mywindow:setSize(50, 20)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)	
		
		-- 6. �����ư
		mywindow = winMgr:createWindow("TaharezLook/Button", i.."sj_BattleChannelInfo_EnterButton")
		mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 173, 609)
		mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 173, 634)
		mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 173, 659)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 173, 659)
		mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 173, 609)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 173, 684)
		mywindow:setPosition(164, 5)
		mywindow:setSize(41, 25)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("battlechannelNumber", tostring(i))
		mywindow:setUserString("eventChannelIndex", 0)
		mywindow:subscribeEvent("Clicked", "CheckGoBattle")
		mywindow:subscribeEvent("MouseMove",  "OnMouseMove_EnterButton")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_EnterButton")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_EnterButton")
		winMgr:getWindow(i.."sj_BattleChannelInfoBackImage"):addChildWindow(mywindow)
	end

end -- end of CurrentLanguage





-- �ѱ��� Ÿ���� ����
--[[
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_BattleChannelInfo_NotifyTowerInfo")
mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 360, 851)
mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 360, 851)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(259, 140)
mywindow:setSize(215, 125)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
--]]

------------------------------------------------------------
-- ������ ��, �� ��ư
------------------------------------------------------------

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then--16.04.21KSG
	
	tBattleChannelButtonName  = { ["protecterr"]=0, "sj_battleChannel_LButton", "sj_battleChannel_RButton" }
	tBattleChannelButtonTexX  = { ["protecterr"]=0, 134, 153 }
	tBattleChannelButtonPosX  = { ["protecterr"]=0, 67, 157 }
	tBattleChannelButtonEvent = { ["protecterr"]=0, "ClickedBattleChannel_Left", "ClickedBattleChannel_Right" }
	for i=1, #tBattleChannelButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tBattleChannelButtonName[i])
		mywindow:setTexture("Normal",		"UIData/mainBG_button006.tga", tBattleChannelButtonTexX[i], 245)
		mywindow:setTexture("Hover",		"UIData/mainBG_button006.tga", tBattleChannelButtonTexX[i], 268)
		mywindow:setTexture("Pushed",		"UIData/mainBG_button006.tga", tBattleChannelButtonTexX[i], 291)
		mywindow:setTexture("PushedOff",	"UIData/mainBG_button006.tga", tBattleChannelButtonTexX[i], 291)
		mywindow:setPosition(tBattleChannelButtonPosX[i], 415)
		mywindow:setSize(19, 23)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", tBattleChannelButtonEvent[i])
		winMgr:getWindow("sj_battlechannelBackImage"):addChildWindow(mywindow)
	end


	function ClickedBattleChannel_Left(args)
		curBattleChannelPage = GetCurrentBattleChannelPage()
		if curBattleChannelPage == 1 then
			return
		end
		curBattleChannelPage = curBattleChannelPage - 1
		SetCurrentBattleChannelPage(curBattleChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function ClickedBattleChannel_Right(args)
		curBattleChannelPage = GetCurrentBattleChannelPage()
		if curBattleChannelPage == maxBattleChannelPage then
			return
		end
		curBattleChannelPage = curBattleChannelPage + 1
		SetCurrentBattleChannelPage(curBattleChannelPage)
		
		BtnPageMove_RequestChannelInfo()
	end
else

	tBattleChannelButtonName  = { ["protecterr"]=0, "sj_battleChannel_LButton", "sj_battleChannel_RButton" }
	tBattleChannelButtonTexX  = { ["protecterr"]=0, 134, 153 }
	tBattleChannelButtonPosX  = { ["protecterr"]=0, 320, 400 }
	tBattleChannelButtonEvent = { ["protecterr"]=0, "ClickedBattleChannel_Left", "ClickedBattleChannel_Right" }
	for i=1, #tBattleChannelButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tBattleChannelButtonName[i])
		mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", tBattleChannelButtonTexX[i], 609)
		mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", tBattleChannelButtonTexX[i], 632)
		mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", tBattleChannelButtonTexX[i], 655)
		mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", tBattleChannelButtonTexX[i], 609)
		mywindow:setPosition(tBattleChannelButtonPosX[i], 410)
		mywindow:setSize(19, 23)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", tBattleChannelButtonEvent[i])
		winMgr:getWindow("sj_channelBackImage"):addChildWindow(mywindow)
	end


	function ClickedBattleChannel_Left(args)
		curBattleChannelPage = GetCurrentBattleChannelPage()
		if curBattleChannelPage == 1 then
			return
		end
		curBattleChannelPage = curBattleChannelPage - 1
		SetCurrentBattleChannelPage(curBattleChannelPage)

		BtnPageMove_RequestChannelInfo()
	end

	function ClickedBattleChannel_Right(args)
		curBattleChannelPage = GetCurrentBattleChannelPage()
		if curBattleChannelPage == maxBattleChannelPage then
			return
		end
		curBattleChannelPage = curBattleChannelPage + 1
		SetCurrentBattleChannelPage(curBattleChannelPage)
		
		BtnPageMove_RequestChannelInfo()
	end
end




function SetBattleMaxChannelPage(maxChannelPage)
	maxBattleChannelPage = maxChannelPage
end


function SelectCurrentBattleChannelType(currentChannelType)
	for i=0, #tBattleChannelTypeValue do
		if tBattleChannelTypeValue[i] == currentChannelType then
			CEGUI.toRadioButton(winMgr:getWindow(i.."sj_battleChannelType")):setSelected(true)
		else
			CEGUI.toRadioButton(winMgr:getWindow(i.."sj_battleChannelType")):setSelected(false)
		end
	end
end

function SelectCurrentVillageChannel(isCurrentBattleChannel)
	if isCurrentBattleChannel >= 0 then
		CEGUI.toRadioButton(winMgr:getWindow(isCurrentBattleChannel.."sj_VillageChannelInfoBackImage")):setSelected(true)
	end
end


function CheckGoBattle(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	g_currentBattleChannelClickIndex = tonumber(local_window:getUserString("battlechannelNumber"))

	if IsPartyPlaying() > 0 then
		if IsKoreanLanguage() then
			ShowCommonAlertOkCancelBoxWithFunction("��ƼŻ��", "�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?", "GoToBattle", "CancelGoBattle")
		else
			ShowCommonAlertOkCancelBoxWithFunction("", BPM_String_PartyBan2, "GoToBattle", "CancelGoBattle")
		end
	else
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "GoToBattle")
		GoToBattle()
	end
end


------------------------------------------------------------------------
-- ��Ƽ���� �� �������� �̵��� ������ ��ҹ�ư �̺�Ʈ
------------------------------------------------------------------------
function CancelGoBattle()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "CancelGoBattle" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	ClosedChannelImage()
end


------------------------------------------------------------------------
-- ��Ƽ���� �� �������� �̵��� ������ Ȯ�ι�ư �̺�Ʈ
------------------------------------------------------------------------
function GoToBattle()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "GoToBattle" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	if g_currentBattleChannelClickIndex >= 0 then
		--ClosedChannelImage()
		BtnPageMove_GoToBattle(g_currentBattleChannelClickIndex)
	end
end



------------------------------------------------------------
-- ����, ��Ʋ ä�� ����
------------------------------------------------------------
function InitVillageChannelInfo()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then--16.04.21KSG
		
		for i=0, MAX_VILLAGE_CHANNEL_PAGE_COUNT-1 do
			winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setEnabled(false)
			winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setVisible(false)
		end
	else
		
		for i=0, MAX_CHANNEL_PAGE_COUNT-1 do
			winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setEnabled(false)
			winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setVisible(false)
		end
	end
	
	
end


------------------------------------------------------------
-- 1. ���� ä�� ���� ��ư ���� !
------------------------------------------------------------
function SetVillageChannelInfo(i, index, userPercent, LevelFrom, LevelTo, name, extreme, limitType)
	-- rhrnak
	winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setEnabled(true)
	winMgr:getWindow(i .. "sj_VillageChannelInfoBackImage"):setVisible(true)
	
	-- 1. ä�� �̸�
	if extreme == BATTLETYPE_NORMAL then
		if limitType == 0 then
			winMgr:getWindow(i .. "sj_VillageChannelInfo_NameText"):setTextColor(255, 255, 255, 255)
		elseif limitType == 1 then
			winMgr:getWindow(i .. "sj_VillageChannelInfo_NameText"):setTextColor(255, 200, 80, 255)
		end
	elseif extreme == BATTLETYPE_EXTREME then
		winMgr:getWindow(i .. "sj_VillageChannelInfo_NameText"):setTextColor(220, 80, 220, 255)
	end
	winMgr:getWindow(i .. "sj_VillageChannelInfo_NameText"):setText(name)
	
	

	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- ��--16.04.21KSG
		-- 3. ä�� ȥ�� �׷���
		local tex_y = 245
		if		0 < userPercent and userPercent <= 3 then	tex_y = 255
		elseif	3 < userPercent and userPercent <= 7 then	tex_y = 265
		else												tex_y = 275
		end
			
		local ONE_PIXEL_TEXSIZE	= 10	-- 1���� ���� �̹��� ũ��
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, tex_y)
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setTexture("Disabled", "UIData/mainBG_button006.tga", 0, tex_y)
		
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+7, 10)
	else
		-- 3. ä�� ȥ�� �׷���
		local tex_y = 619
		if		0 < userPercent and userPercent <= 3 then	tex_y = 619
		elseif	3 < userPercent and userPercent <= 7 then	tex_y = 629
		else												tex_y = 639
		end	
		
		local ONE_PIXEL_TEXSIZE	= 13	-- 1���� ���� �̹��� ũ��
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button003.tga", 0, tex_y)
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setTexture("Disabled", "UIData/mainBG_button003.tga", 0, tex_y)
		winMgr:getWindow(i .. "sj_VillageChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+4, 10)
	end
	
end


function InitBattleChannelInfo()
	for i=0, MAX_CHANNEL_PAGE_COUNT-1 do
		winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setEnabled(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setUserString("eventChannelIndex", 0)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setVisible(false)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setUserString("eventChannelIndex", 0)
	end
end

function SetBattleChannelInfo(i, index, userPercent, LevelFrom, LevelTo, name, battleChannelType, extreme, limitType, currentUser, maxUser)
	
	winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setEnabled(true)
	winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setVisible(true)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setVisible(true)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setPosition(7, 4)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setVisible(true)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setPosition(93, 4) --(75, 4)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setTextColor(150, 150, 150, 255)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setText("")
	winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setVisible(false)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setText("")
	winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setEnabled(true)
	winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setVisible(true)
	
	-- 1. ä�� �̸�
	if extreme == BATTLETYPE_NORMAL then
		if limitType == 0 then
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(255, 255, 255, 255)
		elseif limitType == 1 then
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(255, 200, 80, 255)
		end
	elseif extreme == BATTLETYPE_EXTREME then
		winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(220, 80, 220, 255)
	elseif extreme == BATTLETYPE_FULL_SKILL then
		winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(0, 255, 150, 255)
		winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setUserString("eventChannelIndex", extreme)
		winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setUserString("eventChannelIndex", extreme)
	else
		winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(255, 255, 255, 255)
	end
	winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setText(name)
	
	-- �Ϲ� ����ä��
	if battleChannelType == 0 then
	
		-- 2. ä�� ������ ����
		if limitType == 0 then		-- ����üũ
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setText("[Lv"..LevelFrom.." - Lv"..LevelTo.."]")
		elseif limitType == 1 then	-- ����üũ
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setText("[Ld"..(LevelFrom+1).." - Ld"..(LevelTo+1).."]")
		end
		
		-- 3. ä�� ȥ�� �׷���
		if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage()  then -- ��--16.04.21KSG
			local tex_y = 245
			if		0 < userPercent and userPercent <= 3 then	tex_y = 255
			elseif	3 < userPercent and userPercent <= 7 then	tex_y = 265
			else												tex_y = 275
			end	
			
			local ONE_PIXEL_TEXSIZE	= 12	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+4, 10)
		else
			local tex_y = 619
			if		0 < userPercent and userPercent <= 3 then	tex_y = 619
			elseif	3 < userPercent and userPercent <= 7 then	tex_y = 629
			else												tex_y = 639
			end	

			local ONE_PIXEL_TEXSIZE	= 13	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+4, 10)
		end
		
		
	elseif battleChannelType == 2 then
		winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(255, 255, 255, 255)
		
		-- 3. ä�� ȥ�� �׷���
		if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- ��--16.04.21KSG
			local tex_y = 245
			if		0 < userPercent and userPercent <= 3 then	tex_y = 255
			elseif	3 < userPercent and userPercent <= 7 then	tex_y = 265
			else												tex_y = 275
			end	
			
			local ONE_PIXEL_TEXSIZE	= 12	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+4, 10)
		else
			local tex_y = 619
			if		0 < userPercent and userPercent <= 3 then	tex_y = 619
			elseif	3 < userPercent and userPercent <= 7 then	tex_y = 629
			else												tex_y = 639
			end	

			local ONE_PIXEL_TEXSIZE	= 13	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(userPercent*ONE_PIXEL_TEXSIZE+4, 10)
		end
		
		

	-- Ÿ�� ä��
	elseif battleChannelType == 4 then
		
		local szTower = "Tower Channel "
		if IsKoreanLanguage() then
			szTower = "Ÿ����"
		end

		-- userPercent�� id�Դϴ� ^^;
		if userPercent > 0 then
			winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setEnabled(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setEnabled(true)
			
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(255, 255, 255, 255)
			--winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setText(szTower..(index+1))
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setText(name)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setPosition(6, 4)
			
			if IsKoreanLanguage() then
				local channelName1 = "[Lv"..LevelFrom.."-"..LevelTo.."]"
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setPosition(55, 4)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setTextColor(150,150,150,255)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setText(channelName1)
			else
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setPosition(60, 4)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setText("")
			end

			if currentUser >= 32 then
				winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setTextColor(220, 100, 100, 255)
			else
				winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setTextColor(255, 255, 255, 255)
			end
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setPosition(119, 4)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setText("["..currentUser.."/"..maxUser.."]")
			
			winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setEnabled(true)
		else
			winMgr:getWindow(i .. "sj_BattleChannelInfoBackImage"):setEnabled(false)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setEnabled(false)
			
			
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setTextColor(150,150,150,255)
			--winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setText(szTower..(index+1))
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setText(name)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_NameText"):setPosition(6, 4)
					
			if IsKoreanLanguage() then
				local channelName1 = "[Lv"..LevelFrom.."-"..LevelTo.."]"
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setPosition(55, 4)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setTextColor(150,150,150,255)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setText(channelName1)
			else
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setPosition(60, 4)
				winMgr:getWindow(i .. "sj_BattleChannelInfo_CurrentUserText"):setText("")			
			end
			
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setPosition(119, 4)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setTextColor(150,150,150,255)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_LevelText"):setText("["..currentUser.."/"..maxUser.."]")
			
			winMgr:getWindow(i .. "sj_BattleChannelInfo_EnterButton"):setEnabled(false)
		end
		
		-- 3. ä�� ȥ�� �׷���
		if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- ��--16.04.21KSG
			local tex_y = 245
			if		0 < userPercent and userPercent <= 3 then	tex_y = 255
			elseif	3 < userPercent and userPercent <= 7 then	tex_y = 265
			else												tex_y = 275
			end	
			
			local ONE_PIXEL_TEXSIZE	= 4	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button006.tga", 0, tex_y)
			
			if currentUser >= 32 then
				winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(134, 10)
			else
				winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(currentUser*ONE_PIXEL_TEXSIZE, 10)
			end
		else
			
			local tex_y = 619
			if		 0 < currentUser and currentUser <= 11 then		tex_y = 619
			elseif	11 < currentUser and currentUser <= 22 then		tex_y = 629
			else											tex_y = 639
			end	

			local ONE_PIXEL_TEXSIZE	= 4	-- 1���� ���� �̹��� ũ��
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyStateBack"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setVisible(true)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Enabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setTexture("Disabled",	"UIData/mainBG_button003.tga", 0, tex_y)
			
			if currentUser >= 32 then
				winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(134, 10)
			else
				winMgr:getWindow(i .. "sj_BattleChannelInfo_BusyState"):setSize(currentUser*ONE_PIXEL_TEXSIZE, 10)
			end
		end
		
		
	elseif battleChannelType == 5 then
	end
end



-----------------------------------------
-- �̺�Ʈ ����
-----------------------------------------
toltipwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_BattleChannelInfo_eventToltip")
toltipwindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 214, 749)
toltipwindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 214, 749)
toltipwindow:setProperty("FrameEnabled", "False")
toltipwindow:setProperty("BackgroundEnabled", "False")
toltipwindow:setPosition(0, 0)
toltipwindow:setSize(146, 143)
toltipwindow:setZOrderingEnabled(false)
toltipwindow:setAlwaysOnTop(true)
toltipwindow:setEnabled(false)
toltipwindow:setVisible(false)
root:addChildWindow(toltipwindow)

function OnMouseMove_BattleChannel(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--[[if eventChannelIndex == 3 then
				local posX = CEGUI.toMouseEventArgs(args).position.x - 25
				local posY = CEGUI.toMouseEventArgs(args).position.y - 140
				
				-- ����â x, y�� ����
				if winMgr:getWindow("sj_BattleChannelInfo_eventToltip") then
					if winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):isVisible() then
						winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setPosition(posX, posY)
					end
				end
			end]]
		end
	end
end

function OnMouseEnter_BattleChannel(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--	if eventChannelIndex == 3 then
		--		winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setVisible(true)
		--	end
		end
	end
end

function OnMouseLeave_BattleChannel(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--	if eventChannelIndex == 3 then
		--		winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setVisible(false)
		--	end
		end
	end
end

function OnMouseMove_EnterButton(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--[[if eventChannelIndex == 3 then
				local posX = CEGUI.toMouseEventArgs(args).position.x - 25
				local posY = CEGUI.toMouseEventArgs(args).position.y - 140
				
				-- ����â x, y�� ����
				if winMgr:getWindow("sj_BattleChannelInfo_eventToltip") then
					if winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):isVisible() then
						winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setPosition(posX, posY)
					end
				end
			end]]
		end
	end
end

function OnMouseEnter_EnterButton(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--	if eventChannelIndex == 3 then
		--		winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setVisible(true)
		--	end
		end
	end
end

function OnMouseLeave_EnterButton(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szEventChannelIndex = window:getUserString("eventChannelIndex")
		if szEventChannelIndex ~= "" then
			local eventChannelIndex = tonumber(szEventChannelIndex)
		--	if eventChannelIndex == 3 then
		--		winMgr:getWindow("sj_BattleChannelInfo_eventToltip"):setVisible(false)
		--	end
		end
	end
end


end -- end of function