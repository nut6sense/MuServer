--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

local WINDOW_MYITEM_LIST = 0

--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------
local CurrentPosIndex = MP_GetMPCurrentPos()
DebugStr('CurrentPosIndex:'..CurrentPosIndex)
-- ����, �κ�, Ŭ���κ�, ������, �����̵��, ����, �����̵�, ��, ���̷�
local tMP_OutputPosX		= {['err']=0, 0, 595, 10, 598, 585, 590, 590, 590, 590, 0, 0, 0}--512
local tMP_OutputPosY		= {['err']=0, 391, 685, 520, 544, 613, 687, 687, 655, 680, 0, 0, 0}
local tMP_OutputSizeX		= {['err']=0, 426, 426, 426, 426, 426, 426, 426, 426, 426, 0, 0, 0}
local tMP_OutputStringWidth = {['err']=0, 380, 380, 380, 380, 380, 380, 380, 380, 380, 0, 0, 0}
local tMP_FunctionName		= {['err']=0, ""}
local tMP_WideType			= {['err']=0, WIDETYPE_2, WIDETYPE_6, WIDETYPE_6,  WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_4, WIDETYPE_4, WIDETYPE_4, WIDETYPE_4}

g_curPage_AdapterItemList = 1
g_maxPage_AdapterItemList = 1
AdapterSlotIndex = 0 
SelectBoneIndex = 0

RegistEscEventInfo("ApdaterMainImage", "AdapterCancelBtnEvent")


--------------------------------------------------------------------
-- �ް��� ����ϴ� ��ư ǥ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MP_UseIconButton");
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 693, 743)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 693, 773)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 693, 803)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 693, 803)
mywindow:setWideType(4);
mywindow:setPosition(938, 600)
mywindow:setPosition(10, 65)
mywindow:setSize(79, 30)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "ShowMegaPhoneMsgInput")
root:addChildWindow(mywindow)
--winMgr:getWindow("Wide_funtion_BackImage"):addChildWindow(mywindow)


------------------------------------------------------------
-- �ް��� ��Ʈ�� ���� �˾�â ����
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MegaPhoneAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent("EndRender", "MPRequestTime")
root:addChildWindow(mywindow)

RegistEscEventInfo("MegaPhoneAlpha", "MegaPhoneMsgInputCancel")
RegistEnterEventInfo("MegaPhoneAlpha", "MegaPhoneMsgInputOk")

------------------------------------------------------------
-- �ް��� ��Ʈ�� ���� �˾�â
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MegaPhoneMsgInputWindow")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 302, 332)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 302, 332)
mywindow:setWideType(6);
mywindow:setPosition((g_MAIN_WIN_SIZEX - 420) / 2, (g_MAIN_WIN_SIZEY - 238) / 2)
mywindow:setSize(420, 238)
winMgr:getWindow("MegaPhoneAlpha"):addChildWindow(mywindow)

------------------------------------------------------------
-- Megaphone string editbox
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MegaPhoneMsgEditBox")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setSize(370, 25)
mywindow:setPosition(25, 120)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(46)
winMgr:getWindow('MegaPhoneMsgInputWindow'):addChildWindow(mywindow)


------------------------------------------------------------
-- Megaphone info(Count) text
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MegaPhoneCountText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,198,30,255)
mywindow:setPosition(25, 155)
mywindow:setSize(300, 16)
mywindow:setZOrderingEnabled(true)	
winMgr:getWindow('MegaPhoneMsgInputWindow'):addChildWindow(mywindow)


------------------------------------------------------------
-- Megaphone info(Time) text
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MegaPhoneTimeText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(33, 203, 255, 255)
mywindow:setPosition(25, 175)
mywindow:setSize(300, 16)
mywindow:setZOrderingEnabled(true)	
winMgr:getWindow('MegaPhoneMsgInputWindow'):addChildWindow(mywindow)


------------------------------------------------------------
-- Megaphone message input Ok, Cancel Button
------------------------------------------------------------
local MegaPhoneMsgInputName  = {["err"]=0, "MegaPhoneMsgInputOkBtn", "MegaPhoneMsgInputCancelBtn" }
local MegaPhoneMsgInputTexX	= {['err']=0,		0,			302}
local MegaPhoneMsgInputTexY	= {['err']=0,		775,			196}
local MegaPhoneMsgInputPosX	= {['err']=0,		35,				231}
local MegaPhoneMsgInputEvent = {["err"]=0, "MegaPhoneMsgInputOk", "MegaPhoneMsgInputCancel" }

for i=1, #MegaPhoneMsgInputName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MegaPhoneMsgInputName[i])
	mywindow:setTexture("Normal", "UIData/skillitem001.tga", MegaPhoneMsgInputTexX[i],  MegaPhoneMsgInputTexY[i])
	mywindow:setTexture("Hover", "UIData/skillitem001.tga", MegaPhoneMsgInputTexX[i], MegaPhoneMsgInputTexY[i]+34)
	mywindow:setTexture("Pushed", "UIData/skillitem001.tga", MegaPhoneMsgInputTexX[i], MegaPhoneMsgInputTexY[i]+68)
	mywindow:setTexture("PushedOff", "UIData/skillitem001.tga", MegaPhoneMsgInputTexX[i], MegaPhoneMsgInputTexY[i]+68)
	mywindow:setPosition(MegaPhoneMsgInputPosX[i], 195)
	mywindow:setSize(154, 34)
	mywindow:subscribeEvent("Clicked", MegaPhoneMsgInputEvent[i])
	winMgr:getWindow('MegaPhoneMsgInputWindow'):addChildWindow(mywindow)
end


------------------------------------------------------------
-- MegaPhone message Input window show function
------------------------------------------------------------
function ShowMegaPhoneMsgInput()
	local bCheck = CheckUseMegaphoneLevel()
	if bCheck == false then
		local STRING_PREPARING = PreCreateString_4211	--GetSStringInfo(LAN_USE_MEGAPHONE_01) -- �ް����� ���� 20���� ����Ҽ� �ֽ��ϴ�
		ShowNotifyOKMessage_Lua(STRING_PREPARING)
		return
	end
	MP_RequestMegaphoneStackMsg()					-- �ް��� �޼��� � �׿��ִ��� ��û
	root:addChildWindow(winMgr:getWindow("MegaPhoneAlpha"))
	winMgr:getWindow("MegaPhoneAlpha"):setVisible(true)		
	winMgr:getWindow("MegaPhoneMsgEditBox"):setText("")		-- ����Ʈ �ڽ� �ʱ�ȭ	
	winMgr:getWindow("MegaPhoneMsgEditBox"):activate()
end


------------------------------------------------------------
-- Refresh megaPhone message output time(Receive Hour, minute, second)
------------------------------------------------------------
function RefreshMegaphoneOutputTime(count, timeString)
	local Countstring = string.format(PreCreateString_2298, count)
	local String = PreCreateString_2297.." ( "..Countstring.." )"

	winMgr:getWindow("MegaPhoneCountText"):setText(String)
	winMgr:getWindow("MegaPhoneTimeText"):setText(timeString)
	
end


------------------------------------------------------------
-- Megaphone message input OK
------------------------------------------------------------
function MegaPhoneMsgInputOk()
	local MegaphoneMsg = winMgr:getWindow("MegaPhoneMsgEditBox"):getText()
	local NewString, Check = MP_MegaphoneMsgfilter(MegaphoneMsg)
	
	if Check == false then
		ShowMPStringCheck(NewString)		
		return
	elseif MegaphoneMsg == "" then
		ShowMPStringCheck("")
		return
	end
	winMgr:getWindow("MegaPhoneAlpha"):setVisible(false)
	MP_MegaphoneInputComplete()	-- ������ �Է¸޼��� �Ϸ��ߴٰ� �����ش�.
	ShowConfirmWindow()			-- �������� ����ϰڳİ� �����.
end


------------------------------------------------------------
-- �ް��� �޼��� �Է� ���
------------------------------------------------------------
function MegaPhoneMsgInputCancel()
	winMgr:getWindow("MegaPhoneAlpha"):setVisible(false)
	MP_MegaphoneInputComplete()
end



function MPRequestTime()
	MP_MPMsgCountCheck()
end



--------------------------------------------------------------------
-- ��Ӿ� ���� üũ ���� �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MP_StringCheckAlphaImage')
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("MP_StringCheckAlphaImage", "OnMPStringCheckOk")
RegistEnterEventInfo("MP_StringCheckAlphaImage", "OnMPStringCheckOk")


--------------------------------------------------------------------
-- ��Ӿ� ���� üũ ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MP_StringCheckImage')
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MP_StringCheckAlphaImage'):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ��Ӿ� ���� üũ ���� �ؽ�Ʈ.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MP_StringCheckText")
mywindow:setPosition(3, 100)
mywindow:setSize(340, 30)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2189, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  0,0,0,255)
winMgr:getWindow('MP_StringCheckImage'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��Ӿ� ���� üũ ��Ӿ� ��Ʈ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MP_StringCheckText2")
mywindow:setPosition(3, 135)
mywindow:setSize(340, 60)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
winMgr:getWindow('MP_StringCheckImage'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MP_StringCheckButton");
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:subscribeEvent("Clicked", "OnMPStringCheckOk")
winMgr:getWindow('MP_StringCheckImage'):addChildWindow(mywindow)


-- �˾�â�� �����ش�.
function ShowMPStringCheck(msg)
	-- �˾�â ����ش�
	root:addChildWindow(winMgr:getWindow('MP_StringCheckAlphaImage'))
	winMgr:getWindow('MP_StringCheckAlphaImage'):setVisible(true)
	if msg == "" then
		winMgr:getWindow('MP_StringCheckText2'):clearTextExtends()
		winMgr:getWindow('MP_StringCheckText'):setPosition(3, 120)
		winMgr:getWindow('MP_StringCheckText'):setTextExtends(PreCreateString_4, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  0,0,0,255)		
		return
	end
	winMgr:getWindow('MP_StringCheckText'):setPosition(3, 100)
	winMgr:getWindow('MP_StringCheckText'):setTextExtends(PreCreateString_2189, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  0,0,0,255)
	local String = AdjustString(g_STRING_FONT_GULIM, 14, msg, 210)
	winMgr:getWindow('MP_StringCheckText2'):setTextExtends(String, g_STRING_FONT_GULIMCHE,14, 255,198,30, 255,  0,  0,0,0,255)	
end


-- �˾�â�� �����ش�.
function OnMPStringCheckOk()
	winMgr:getWindow('MP_StringCheckAlphaImage'):setVisible(false)	
end





--------------------------------------------------------------------
-- �ް��� ������ ���Ȯ�� ������ ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MP_ConfirmAlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("MP_ConfirmAlphaImage", "OnMPConfirmCancel")
RegistEnterEventInfo("MP_ConfirmAlphaImage", "OnMPConfirmOk")


--------------------------------------------------------------------
-- �ް��� ������ ���Ȯ�� ������ �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MP_ConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MP_ConfirmAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- �ް��� ������ ���Ȯ�� ������ �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MP_ConfirmText");
mywindow:setPosition(3, 45)
mywindow:setSize(340, 180)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2300, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  0,0,0,255)
winMgr:getWindow('MP_ConfirmImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- ��ư (Ȯ��, ���)
--------------------------------------------------------------------
local ButtonName	= {['protecterr']=0, "MP_ConfirmOKButton", "MP_ConfirmCancelButton"}
local ButtonTexX	= {['protecterr']=0,		693,			858}
local ButtonPosX	= {['protecterr']=0,		4,				169}		
local ButtonEvent	= {['protecterr']=0, "OnMPConfirmOk", "OnMPConfirmCancel"}

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
	winMgr:getWindow('MP_ConfirmImage'):addChildWindow(mywindow)
end


-- Ȯ�� �����츦 �����ش�,
function ShowConfirmWindow()
	root:addChildWindow(winMgr:getWindow('MP_ConfirmAlphaImage'))
	winMgr:getWindow('MP_ConfirmAlphaImage'):setVisible(true)
end


-- �ް����� ���ڴٰ� Ȯ����.
function OnMPConfirmOk()
	winMgr:getWindow('MP_ConfirmAlphaImage'):setVisible(false)
	MP_MegaphoneMsgSendToServer()
end


-- �ް��� ���°� ���.
function OnMPConfirmCancel()
	winMgr:getWindow('MP_ConfirmAlphaImage'):setVisible(false)
end


--=======================================================================================================
-- ��ް����� �޼��� ����ϴºκ�


-- ��ް��� �޼����� �ѷ��ִºκ�
--=======================================================================================================


------------------------------------------------------------------
-- �ް��� ��׶���� ����� �̹���.
------------------------------------------------------------------

function SetMegaphonePos()

	local x, y

	-- ä��â ��ġ�� ����
	if winMgr:getWindow("ChatBackground") then
		local top, bottom, left, right = GetCEGUIWindowRect("ChatBackground")
		x = left
		y = top
	else
		x = 3
		y = 736
	end

	winMgr:getWindow("MegaphoneBackground"):setPosition(x, y)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MegaphoneBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 604, 967)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 604, 967)

if winMgr:getWindow("ChatBackground") == nil then 
	mywindow:setWideType(tMP_WideType[CurrentPosIndex]);
else
	mywindow:setWideType(0);
end

SetMegaphonePos()

--mywindow:setPosition(tMP_OutputPosX[CurrentPosIndex], tMP_OutputPosY[CurrentPosIndex])
mywindow:setSize(426, 31)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:addController("MegaphoneBack", "MegaphoneBackEvent", "alpha", "Sine_EaseIn", 255, 0, 8, true, false, 10)
--mywindow:setSubscribeEvent("MotionEventEnd", "MegaphoneBackEventEnd");
root:addChildWindow(mywindow)

------------------------------------------------------------------
-- �ް��� ��׶���� ����� �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MegaphoneBackground1")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 481)
mywindow:setPosition(0,0)
mywindow:setSize(426, 31)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("MPMotion", "MPMotionEvent1", "visible", "Sine_EaseInOut", 1, 1, 1, true, true, 10)
mywindow:addController("MPMotion", "MPMotionEvent1", "visible", "Sine_EaseInOut", 0, 0, 1, true, true, 10)
winMgr:getWindow('MegaphoneBackground'):addChildWindow(mywindow)


------------------------------------------------------------------
-- �ް��� ��׶���� ����� �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MegaphoneBackground2")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 481)
mywindow:setPosition(0,0)
mywindow:setSize(426, 31)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("MPMotion", "MPMotionEvent2", "visible", "Sine_EaseInOut", 0, 0, 1, true, true, 10)
mywindow:addController("MPMotion", "MPMotionEvent2", "visible", "Sine_EaseInOut", 1, 1, 1, true, true, 10)
winMgr:getWindow('MegaphoneBackground'):addChildWindow(mywindow)



------------------------------------------------------------------
-- �ް��� ��׶���� ����� �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MPRenderImage")
mywindow:setTexture("Enabled", "UIData/Invisible.tga", 604, 967)
mywindow:setTexture("Disabled", "UIData/Invisible.tga", 604, 967)
mywindow:setPosition(0, 0)
mywindow:setSize(1, 1)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "MPRenderForTime")
winMgr:getWindow('MegaphoneBackground'):addChildWindow(mywindow)


------------------------------------------------------------------
-- �ް��� �̸� �ؽ�Ʈ
------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'MegaphoneNameString')
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(36,180,255,255)
mywindow:setPosition(25, 1);
mywindow:setSize(395, 31);
mywindow:setAlign(5)
mywindow:setLineSpacing(0)
mywindow:setViewTextMode(1)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('MegaphoneBackground'):addChildWindow(mywindow)


------------------------------------------------------------------
-- �ް��� ���� �ؽ�Ʈ
------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'MegaphoneString')
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(36,180,255,255)
mywindow:setPosition(25, 1);
mywindow:setSize(395, 35);
mywindow:setAlign(5)
mywindow:setLineSpacing(0)
mywindow:setViewTextMode(1)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('MegaphoneBackground'):addChildWindow(mywindow)


-- ���忡���� ����� �� �ֵ��� ��ư�� �ѷ��ش�.
function UpdateMegaphoneCheck(count, Check, digItem)	-- digItem == -2 ������
	--[[
	if Check == 1 then
		winMgr:getWindow('MP_UseIconButton'):setVisible(true)
	else
		winMgr:getWindow('MP_UseIconButton'):setVisible(false)
	end
	--]]
end


function ShowMegaphoneWindow()
	root:addChildWindow(winMgr:getWindow("MegaphoneBackground"))
	winMgr:getWindow("MegaphoneBackground"):setVisible(true)
	winMgr:getWindow("MegaphoneBackground1"):activeMotion("MPMotionEvent1")
	winMgr:getWindow("MegaphoneBackground2"):activeMotion("MPMotionEvent2")
end

local tBlue		= {['err']=0, [0]=112,255,253}
local tYellow	= {['err']=0, [0]=255, 255, 0}
local tGold	= {['err']=0, [0]=255,204,0}
local tMegaphoneColor = {['err']=0, [0]=tBlue, tYellow, tGold}
function ShowMegaphoneMsg(Name, Msg, type)
	if winMgr:getWindow("MegaphoneBackground"):isVisible() == false then
		ShowMegaphoneWindow()
	end
	
	SetMegaphonePos()
	
	if type == 0 then
		winMgr:getWindow("MegaphoneBackground1"):setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
		winMgr:getWindow("MegaphoneBackground2"):setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
	else
		winMgr:getWindow("MegaphoneBackground1"):setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
		winMgr:getWindow("MegaphoneBackground2"):setTexture("Enabled", "UIData/mainbarchat.tga", 0, 481)
	end
	
	local NameString = "["..Name.."] : "
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 13, NameString)
	local Message = MP_MegaphoneAdjust(g_STRING_FONT_GULIM, 13, Msg, 380 - Size)	

	local color = tMegaphoneColor[type]
	winMgr:getWindow("MegaphoneString"):clearTextExtends()
	winMgr:getWindow("MegaphoneString"):addTextExtends(NameString, g_STRING_FONT_GULIMCHE, 13, 255,194,64,255,    1, 0,0,0,255);
	winMgr:getWindow("MegaphoneString"):addTextExtends(Message, g_STRING_FONT_GULIMCHE, 13, color[0],color[1],color[2],255,    1, 0,0,0,255);

end


function MPRenderForTime()
	MP_MPMsgVisibleCheck()
end


function HideMegaPhoneMsg()
	--winMgr:getWindow("MegaphoneBackground"):activeMotion("MegaphoneBackEvent");	
	winMgr:getWindow("MegaphoneBackground"):setVisible(false)
	winMgr:getWindow("MegaphoneBackground1"):clearActiveController()
	winMgr:getWindow("MegaphoneBackground2"):clearActiveController()
	winMgr:getWindow("MegaphoneString"):setTextExtends("", g_STRING_FONT_GULIMCHE, 14, 255,255,0,255,    1, 0,0,0,255);
end

function MegaphoneBackEventEnd()
	winMgr:getWindow("MegaphoneBackground"):setVisible(false)
	winMgr:getWindow("MegaphoneBackground"):clearActiveController()
	winMgr:getWindow("MegaphoneString"):setTextExtends("", g_STRING_FONT_GULIMCHE, 14, 255,255,0,255,    1, 0,0,0,255);	
end









----------------------------------------------------------------------
--����� ������ ����Ʈ ���� ����(������)
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ApdaterMainImage")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(tMP_WideType[CurrentPosIndex]);
--mywindow:setWideType(6)
mywindow:setPosition(200, 250)
mywindow:setSize(349, 269)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
--����� �����̹���
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ApdaterAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- ��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterTitle")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 518, 0)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 518, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(95, 10)
mywindow:setSize(159, 19)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)


-- ��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterExplain")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 518, 19)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 518, 19)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 180)
mywindow:setSize(307, 44)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)

-- ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterSelectItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20, 65)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)

-- �ڽ�Ƭ �ƹ�Ÿ ���� �� �̹��� ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterSelectItemImage_Back")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20, 65)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)

-- ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterSelectItemName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 60)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)
	
-- ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterSelectItemCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 75)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)
	
-- ������ �Ⱓ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterSelectItemPeriod")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 90)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)


AdapterOkCancelBtn	= {['protecterr']=0, "AdapterOkBtn", "AdapterCancelBtn"}
AdapterOkCancelTexX	= {['protecterr']=0,	693,  858}
AdapterOkCancelPosX	= {['protecterr']=0,	4,	  170}
AdapterOkCancelEvent	= {['protecterr']=0, "AdapterOkBtnEvent", "AdapterCancelBtnEvent"}

-- Ȯ�� ��� ��ư
for i = 1, #AdapterOkCancelBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", AdapterOkCancelBtn[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", AdapterOkCancelTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", AdapterOkCancelTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", AdapterOkCancelTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", AdapterOkCancelTexX[i], 849)
	mywindow:setPosition(AdapterOkCancelPosX[i], 237)
	mywindow:setSize(166, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", AdapterOkCancelEvent[i])
	winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)
end


-- ĳ���� ���� �̹���
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Adapter_Selected_Popup')
mywindow:setTexture('Enabled', 'UIData/my_room.tga',	340, 0)
mywindow:setTexture('Disabled', 'UIData/my_room.tga',	340, 0)
mywindow:setProperty('BackgroundEnabled', 'False')
mywindow:setProperty('FrameEnabled', 'False')
mywindow:setPosition(185, 115)
mywindow:setSize(89, 19)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)

-- ĳ���� �� �˾�ȣ���ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Adapter_Chat_popup")
mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 158, 381)
mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 158, 398)
mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 158, 415)
mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 158, 415)
mywindow:setPosition(255, 117)
mywindow:setSize(17, 17)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnTextAccepted_Adapter_popup")
winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)

Adapter_CharacterButtonName =
{ ["protecterr"]=0, "Adapter_Wells", "Adapter_Ray", "Adapter_Joony" , "Adapter_Lilru" , "Adapter_Nicky" , "Adapter_Sera"}
Adapter_PopupButtonPos = {['protecterr']=0, 133 , 152 , 171 , 190, 209, 228}
Adapter_PopupTexurePosY = {['protecterr']=0, 19, 38, 57, 76, 95 ,114}

for i=1, #Adapter_CharacterButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Adapter_CharacterButtonName[i])
	mywindow:setTexture("Disabled", "UIData/my_room.tga",		340+89, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("Normal", "UIData/my_room.tga",		340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("Hover", "UIData/my_room.tga",		340, Adapter_PopupTexurePosY[i]+114)
	mywindow:setTexture("Pushed", "UIData/my_room.tga",		340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("PushedOff", "UIData/my_room.tga",	340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga",	340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga",	 340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga",	 340, Adapter_PopupTexurePosY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/my_room.tga", 340, Adapter_PopupTexurePosY[i])
	mywindow:setSize(89, 19)
	mywindow:setPosition(185, Adapter_PopupButtonPos[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setUserString('Index', tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", 'Adapter_PopupEvent')
	winMgr:getWindow('ApdaterMainImage'):addChildWindow(mywindow)
end

function OnTextAccepted_Adapter_popup()

	if winMgr:getWindow('Adapter_Wells'):isVisible() then
		for i=1 , #Adapter_CharacterButtonName do
			winMgr:getWindow(Adapter_CharacterButtonName[i]):setVisible(false);
		end
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Normal", "UIData/mainbarchat.tga", 158, 381)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Hover", "UIData/mainbarchat.tga", 158, 398)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Pushed", "UIData/mainbarchat.tga", 158, 415)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 158, 415)
	else
		for i=1 , #Adapter_CharacterButtonName do
			winMgr:getWindow(Adapter_CharacterButtonName[i]):setVisible(true);
			winMgr:getWindow(Adapter_CharacterButtonName[i]):setProperty("Selected", "false")
		end
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Normal", "UIData/mainbarchat.tga", 141, 381)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Hover", "UIData/mainbarchat.tga", 141, 398)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Pushed", "UIData/mainbarchat.tga", 141, 415)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 141, 415)
	end
end


function Adapter_PopupEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local IndexCount = tonumber(local_window:getUserString('Index'))
		for i=1 , #Adapter_CharacterButtonName do
			winMgr:getWindow(Adapter_CharacterButtonName[i]):setVisible(false);
		end
		if IndexCount == 1 then
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 19)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 19)
			SelectBoneIndex = 1
		elseif IndexCount == 2 then
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 38)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 38)
			SelectBoneIndex = 2
		elseif IndexCount == 3 then
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 57)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 57)
			SelectBoneIndex = 3
		elseif IndexCount == 4 then
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 76)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 76)
			SelectBoneIndex = 4
		elseif IndexCount == 5 then
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 95)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 95)
			SelectBoneIndex = 5
		else
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 114)
			winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 114)
			SelectBoneIndex = 6
		end
		
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Normal", "UIData/mainbarchat.tga", 158, 381)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Hover", "UIData/mainbarchat.tga", 158, 398)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("Pushed", "UIData/mainbarchat.tga", 158, 415)
		winMgr:getWindow("Adapter_Chat_popup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 158, 415)
	end
end


function AdapterOkBtnEvent()

	itemName = winMgr:getWindow("AdapterSelectItemName"):getText()
	
	if itemName == "" then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2331,'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_ADAPTER_REGISTITEM )
		--��ü�� �������� �������ּ���
		return
	end
	
	if SelectBoneIndex == 0 then
		--��ü�� ĳ���͸� �������ּ���
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2330,'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_ADAPTER_SELECTCHARACTER)
		return
	end 

	AcceptApdaterItem(AdapterSlotIndex , SelectBoneIndex)
end

function AdapterCancelBtnEvent()
	AdapterSlotIndex = 0
	SelectBoneIndex = 0
	CloseApdaterItemList()
end

----------------------------------------------------------------------
--����� ������ ����Ʈ ���� 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterItemImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(550,180);
mywindow:setSize(296, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


-----------------------------------------------------------------------
-- ����� ������ ��� â ������ư
-----------------------------------------------------------------------
tAdapterItemRadio =
{ ["protecterr"]=0, "AdapterItemList_1", "AdapterItemList_2", "AdapterItemList_3", "AdapterItemList_4", "AdapterItemItemList_5"}


for i=1, #tAdapterItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tAdapterItemRadio[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			296,583 );
	mywindow:setTexture("Hover", "UIData/deal.tga",			296,583);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			296,583);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",		296,583);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",296,583);
	mywindow:setTexture("Disabled", "UIData/deal.tga",			296, 583);
	mywindow:setSize(282, 52);
	mywindow:setPosition(7, 65+(i-1)*55);
	mywindow:setVisible(true);
	mywindow:setUserString('index', tostring(i))
	mywindow:setEnabled(true)
	winMgr:getWindow('AdapterItemImage'):addChildWindow( winMgr:getWindow(tAdapterItemRadio[i]) );
	
		
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	-- Ŭ�� ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterItemList_Clone_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("AdapterItemList_Image_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AdapterItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("AdapterRadioIndex", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_AdapterItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_AdapterVanishTooltip")
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tAdapterItemRadio[i]):addChildWindow(mywindow)
end

-----------------------------------------------------------------------
--������ ����Ʈ ÷�� ��ư 5��
-----------------------------------------------------------------------
 
tAdapterItemButton =
{ ["protecterr"]=0, "AdapterItemButton_1", "AdapterItemButton_2", "AdapterItemButton_3", "AdapterItemButton_4", "AdapterItemButton_5"}
 

for i=1, #tAdapterItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tAdapterItemButton[i]);	
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setSize(63,18 );	
	mywindow:setPosition(220,95+(i-1)*54);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false);
	mywindow:setUserString('AdapterIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tAdapterItemButtonEvent")
	winMgr:getWindow('AdapterItemImage'):addChildWindow( winMgr:getWindow(tAdapterItemButton[i]));
end

function ShowApdaterItemList()
	winMgr:getWindow('ApdaterAlphaImage'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('ApdaterAlphaImage'))
	winMgr:getWindow("AdapterItemImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('AdapterItemImage'))
	winMgr:getWindow("ApdaterMainImage"):setVisible(true)
	root:addChildWindow( winMgr:getWindow('ApdaterMainImage'))
end

function CloseApdaterItemList()
	
	ItemChangeRegisterReset()
	winMgr:getWindow("AdapterItemImage"):setVisible(false)
	winMgr:getWindow("ApdaterMainImage"):setVisible(false)
	winMgr:getWindow('ApdaterAlphaImage'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('ApdaterAlphaImage') );
end

function ItemChangeRegisterReset()

	for i=1 , #Adapter_CharacterButtonName do
			winMgr:getWindow(Adapter_CharacterButtonName[i]):setVisible(false);
	end
	
	for j=1 , #tAdapterItemRadio do
		winMgr:getWindow("AdapterItemList_Clone_Image_" .. j):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
	
	winMgr:getWindow("Adapter_Chat_popup"):setTexture("Normal", "UIData/mainbarchat.tga", 158, 381)
	winMgr:getWindow("Adapter_Chat_popup"):setTexture("Hover", "UIData/mainbarchat.tga", 158, 398)
	winMgr:getWindow("Adapter_Chat_popup"):setTexture("Pushed", "UIData/mainbarchat.tga", 158, 415)
	winMgr:getWindow("Adapter_Chat_popup"):setTexture("PushedOff", "UIData/mainbarchat.tga", 158, 415)
	winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Enabled', 'UIData/my_room.tga',	340, 0)
	winMgr:getWindow('Adapter_Selected_Popup'):setTexture('Disabled', 'UIData/my_room.tga',	340, 0)
	winMgr:getWindow("AdapterSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("AdapterSelectItemImage_Back"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("AdapterSelectItemName"):setText("")
	winMgr:getWindow("AdapterSelectItemPeriod"):setText("")	
	winMgr:getWindow("AdapterSelectItemCount"):setText("")
end

-----------------------------------------------------------------------
-- ��� ������ �̸� �����̸� �������� ����
-----------------------------------------------------------------------
function SetupApdaterItemList(i, itemName, itemFileName, itemUseCount, itemGrade, IsCloneAvatar, attach)
    
    DebugStr('itemFileName:'..itemFileName)
    DebugStr('itemName:'..itemName)
    DebugStr('itemUseCount:'..itemUseCount)
    DebugStr('����� attach:'..attach)
    
    local j=i+1
	winMgr:getWindow(tAdapterItemRadio[j]):setVisible(true)
	winMgr:getWindow(tAdapterItemButton[j]):setVisible(true)
	
	-- ������ �����̸�
	winMgr:getWindow("AdapterItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("AdapterItemList_Image_"..j):setScaleWidth(102)
	winMgr:getWindow("AdapterItemList_Image_"..j):setScaleHeight(102)
	
	-- ������ �̸�
	winMgr:getWindow("AdapterItemList_Name_"..j):setText(itemName)
	
	if itemGrade > 0 then
		winMgr:getWindow("AdapterItemList_SkillLevelImage_"..j):setVisible(true)
		winMgr:getWindow("AdapterItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		winMgr:getWindow( "AdapterItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow( "AdapterItemList_SkillLevelText_"..j):setText("+"..itemGrade)
	else
		winMgr:getWindow("AdapterItemList_SkillLevelImage_"..j):setVisible(false)
		winMgr:getWindow("AdapterItemList_SkillLevelText_"..j):setText("")
	end
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("AdapterItemList_Num_"..j):setText(szCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("AdapterItemList_Period_"..j):setText(period)	
	
	-- Ŭ�� ������ ������ ���� �Լ�
	SetAvatarIconS(	"AdapterItemList_Image_" , "AdapterItemList_Clone_Image_" , "AdapterItemList_Clone_Image_" , 
					j , IsCloneAvatar , attach )	
end

------------------------------------
---������ǥ���ؽ�Ʈ
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "AdapterItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(110, 380)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('AdapterItemImage'):addChildWindow(mywindow)

------------------------------------
---�������յڹ�ư
------------------------------------
local tMyAdapterItemList_BtnName  = {["err"]=0, [0]="MyAdapterItemList_LBtn", "MyAdapterItemList_RBtn"}
local tMyAdapterItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
local tMyAdapterItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
local tMyAdapterItemList_BtnEvent = {["err"]=0, [0]= "OnClickAdapterItemList_PrevPage", "OnClickAdapterItemList_NextPage"}
for i=0, #tMyAdapterItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyAdapterItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyAdapterItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyAdapterItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyAdapterItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyAdapterItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyAdapterItemList_BtnPosX[i], 378)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyAdapterItemList_BtnEvent[i])
	winMgr:getWindow('AdapterItemImage'):addChildWindow(mywindow)
end
---------------------------------------------------
-- AdapterItemList ���� ������ / �ִ� ������
---------------------------------------------------
function AdapterItemListPage(curPage, maxPage)
	g_curPage_AdapterItemList = curPage
	g_maxPage_AdapterItemList = maxPage
	
	winMgr:getWindow("AdapterItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---�����������̺�Ʈ-------------------
------------------------------------
		 
function  OnClickAdapterItemList_PrevPage()
  
	if	g_curPage_AdapterItemList > 1 then
			g_curPage_AdapterItemList = g_curPage_AdapterItemList - 1
			ChangedAdapterItemListCurrentPage(g_curPage_AdapterItemList)
	end
	
end
------------------------------------
---�����������̺�Ʈ-----------------
------------------------------------
function OnClickAdapterItemList_NextPage()

	if	g_curPage_AdapterItemList < g_maxPage_AdapterItemList then
			g_curPage_AdapterItemList = g_curPage_AdapterItemList + 1
			ChangedAdapterItemListCurrentPage(g_curPage_AdapterItemList)
	end
	
end
function ClearAdapterItemList()
    
	for i=1, 5 do
		winMgr:getWindow(tAdapterItemRadio[i]):setVisible(false)
		winMgr:getWindow(tAdapterItemButton[i]):setVisible(false)
	end
end


function adapterEvent(SlotIndex)
	DebugStr('adapterEvent()')
	AdapterSlotIndex = SlotIndex
	RequestAdapterList()
	ShowApdaterItemList()
end


function tAdapterItemButtonEvent(args)	

	DebugStr('tMaiItemButtonEvent start');
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("AdapterIndex")
	DebugStr("÷�θ���Ʈindex:"..index);
	index=index-1
	local bEnable = SelectAdapterItem(tonumber(index))
	if bEnable then
		AdapterSelectItem(index, itemCount, itemName, itemFileName)
	end
end

function AdapterSelectItem()
	local itemCount, itemName, itemFileName, itemskillLevel, avatarType, Attach = GetSelectChangeItemInfo()
	
	-- ������ �����̸�
	winMgr:getWindow("AdapterSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("AdapterSelectItemImage"):setScaleWidth(230)
	winMgr:getWindow("AdapterSelectItemImage"):setScaleHeight(230)
	
	-- ������ �̸�
	winMgr:getWindow("AdapterSelectItemName"):setText(itemName)
		
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("AdapterSelectItemCount"):setText(szcount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("AdapterSelectItemPeriod"):setText(period)
	
	-- Ŭ�� �ƹ�Ÿ ����
	winMgr:getWindow("AdapterSelectItemImage_Back"):setScaleWidth(230)
	winMgr:getWindow("AdapterSelectItemImage_Back"):setScaleHeight(230)
	SetAvatarIcon("AdapterSelectItemImage" , "AdapterSelectItemImage_Back" , avatarType , Attach)
end

function OnMouseEnter_AdapterItemListInfo(args)
	--DebugStr('OnMouseEnter_AdapterItemListInfo()')
	-- ���� ����ش�.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- ���� ���õ� �����츦 ã�´�.
	local index = tonumber(EnterWindow:getUserString("AdapterRadioIndex"))
	DebugStr('index:'..index)
	index = index-1
	
	local itemKind, itemNumber = GetAdaptTooltipInfo(WINDOW_MYITEM_LIST, index)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

-- �̹����� ���콺�� ����� ������ �����Ѵ�.
function OnMouseLeave_AdapterVanishTooltip()
	SetShowToolTip(false)	
end

