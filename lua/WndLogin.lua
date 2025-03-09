--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
guiSystem:setDefaultTooltip("TaharezLook/Tooltip")

local wightSize , heightSize = GetCurrentResolution()

Diffwidth = 1920 - wightSize;
Diffheight = 1200 - heightSize;

--------------------------------------------------------------------

-- �α��� ȭ�� �����̹���

--------------------------------------------------------------------

function WndLogin_RenderBackImage(language)
	if language == LANGUAGECODE_ENG or  language == LANGUAGECODE_GSP then
		winMgr:getWindow("ThaiLoginBG"):setEnabled(false)
		winMgr:getWindow("ThaiLoginBG"):setVisible(false)
	--	DebugStr("WndLogin_RenderBackImage :: ENG")
	--	drawer:drawTexture("UIData/FirstLoadingImageW.dds", 0, 0, wightSize, heightSize, Diffwidth/2, Diffheight/2)
	--	drawer:drawTexture("UIData/FirstLoadingImageW2.tga", 0, 0+50, 1024, 512, 0, 512, WIDETYPE_6)
		drawer:drawTextureBackImage("UIData/LoginWide.dds", 0, 0, 1920, 1200, 0, 0)
		
		
	elseif language == LANGUAGECODE_KOR then
		drawer:drawTextureBackImage("UIData/FirstLoadingImageW.dds", 0, 0, 1920, 1200, 0, 0)
		
	else
		--DebugStr("WndLogin_RenderBackImage :: THAI")
		drawer:drawTextureBackImage("UIData/LoginWide.dds", 0, 0, 1920, 1200, 0, 0)
		drawer:drawTexture("UIData/Login_on.tga", 315, 500, 445, 196, 0, 0, WIDETYPE_7)
	end
	
end


--------------------------------------------------------------------
-- ID
--------------------------------------------------------------------
local ThaiLoginBG = winMgr:createWindow("TaharezLook/StaticImage", "ThaiLoginBG")
ThaiLoginBG:setPosition(0, 0)
ThaiLoginBG:setSize(wightSize, heightSize)		
ThaiLoginBG:setVisible(true)	
ThaiLoginBG:setEnabled(true)
ThaiLoginBG:setZOrderingEnabled(false)
root:addChildWindow(ThaiLoginBG)

--------------------------------------------------------------------

-- ID

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "login_ID_editbox")
mywindow:setWideType(7)
mywindow:setPosition(431, 593)
mywindow:setSize(144, 35)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:subscribeEvent("TextAccepted", "ChangeActive_Password")
CEGUI.toEditbox(mywindow):setMaxTextLength(16)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeActive_Password")
ThaiLoginBG:addChildWindow(mywindow)


function OnEditboxFullEvent(args)
	PlayWave('sound/FullEdit.wav')
end

function ChangeActive_Password()
	DebugStr("ChangeActive_Password");

	winMgr:getWindow("login_Password_editbox"):activate()
end





--------------------------------------------------------------------

-- PASSWORD

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "login_Password_editbox")
mywindow:setWideType(7)
mywindow:setPosition(431, 634)
mywindow:setSize(144, 35)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_DODUMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:subscribeEvent("TextAccepted", "ClickRequestLogin")
CEGUI.toEditbox(mywindow):setTextMasked(true)
CEGUI.toEditbox(mywindow):setMaxTextLength(16)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeActive_ID")
ThaiLoginBG:addChildWindow(mywindow)

function ChangeActive_ID()
	winMgr:getWindow("login_ID_editbox"):activate()
end





--------------------------------------------------------------------

-- �α��� ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "login_RequestLogin_btn")
mywindow:setTexture("Normal", "UIData/Login_on.tga", 1, 196)
mywindow:setTexture("Hover", "UIData/Login_on.tga", 1, 239)
mywindow:setTexture("Pushed", "UIData/Login_on.tga", 1, 282)
mywindow:setTexture("PushedOff", "UIData/Login_on.tga", 1, 196)
mywindow:setTexture("Disabled", "UIData/Login_on.tga", 1, 282)

mywindow:setWideType(7)
mywindow:setPosition(620, 584)
mywindow:setSize(102, 41)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickRequestLogin")
ThaiLoginBG:addChildWindow(mywindow)

function ClickRequestLogin()
	DebugStr("ClickRequestLogin Thai")
	local ID = winMgr:getWindow("login_ID_editbox"):getText()
	local PW = winMgr:getWindow("login_Password_editbox"):getText()
	winMgr:getWindow("login_ID_editbox"):deactivate()
	winMgr:getWindow("login_Password_editbox"):deactivate()
	winMgr:getWindow("login_RequestLogin_btn"):setEnabled(false)
	
	--DebugStr(ID)
	--DebugStr(PW)
	RequestLogin(ID, PW)
end




--------------------------------------------------------------------

-- ���� ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "login_Exit_btn")
mywindow:setTexture("Normal", "UIData/Login_on.tga", 103, 196)
mywindow:setTexture("Hover", "UIData/Login_on.tga", 103, 239)
mywindow:setTexture("Pushed", "UIData/Login_on.tga", 103, 282)
mywindow:setTexture("PushedOff", "UIData/Login_on.tga", 103, 196)

mywindow:setWideType(7)
mywindow:setPosition(620, 628)
mywindow:setSize(102, 41)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickExit_Login")
ThaiLoginBG:addChildWindow(mywindow)

function ClickExit_Login()
	ExitLogin()
end



-- �α��� ������
function WndLogin_LoginError()
	winMgr:getWindow("login_RequestLogin_btn"):setEnabled(true)
	winMgr:getWindow("login_ID_editbox"):setText("")
	winMgr:getWindow("login_ID_editbox"):activate()
	winMgr:getWindow("login_Password_editbox"):setText("")
end





function SetLogin(language)

	-- ��Ȱ��ȭ ������
	 
	if language == LANGUAGECODE_ENG or language == LANGUAGECODE_KOR or  language == LANGUAGECODE_GSP then
		winMgr:getWindow("login_ID_editbox"):setEnabled(false)
		winMgr:getWindow("login_Password_editbox"):setEnabled(false)
		winMgr:getWindow("login_RequestLogin_btn"):setEnabled(false)
		winMgr:getWindow("login_Exit_btn"):setEnabled(false)
		
		winMgr:getWindow("login_ID_editbox"):setVisible(false)
		winMgr:getWindow("login_Password_editbox"):setVisible(false)
		winMgr:getWindow("login_RequestLogin_btn"):setVisible(false)
		winMgr:getWindow("login_Exit_btn"):setVisible(false)
	-- Ȱ��ȭ ������
	else
		winMgr:getWindow("login_ID_editbox"):setEnabled(true)
		winMgr:getWindow("login_Password_editbox"):setEnabled(true)
		winMgr:getWindow("login_RequestLogin_btn"):setEnabled(true)
		winMgr:getWindow("login_Exit_btn"):setEnabled(true)
		
		winMgr:getWindow("login_ID_editbox"):setVisible(true)
		winMgr:getWindow("login_Password_editbox"):setVisible(true)
		winMgr:getWindow("login_RequestLogin_btn"):setVisible(true)
		winMgr:getWindow("login_Exit_btn"):setVisible(true)

		winMgr:getWindow("login_ID_editbox"):activate()

	end
end





------------------------------------------------------------

-- U-OTP Pop up

------------------------------------------------------------

function UOTPNotifyMessageOKClicked()

	local winMgr = CEGUI.WindowManager:getSingleton()

	winMgr:getWindow("OTP_Notify_LuaAlpha_OkCancel"):setVisible(false)
	winMgr:getWindow("OTP_Notify_LuaMain_OkCancel"):setVisible(false)
--	winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setText("")
--	SetInputEnable(true)

	-- UOTP ��й�ȣ �о� ����
	local UOTP_PW = winMgr:getWindow("OTP_editbox"):getText()
	
	DebugStr(UOTP_PW)
	
	-- ������ UOTP_PW ����
	SendUOTPPW(UOTP_PW);	
end

function UOTPNotifyMessageCancelClicked()		
	
	-- ��Ҹ� ������ �ٽ� �α��� â���� ���ư���
	ExitAskPopupSelected(2)
end


function ShowUOTPPopupOKCancel(message, ...)
	
	local winMgr	= CEGUI.WindowManager:getSingleton()
	local root		= winMgr:getWindow("DefaultWindow")
	local drawer	= root:getDrawer()
	CEGUI.MouseCursor:getSingleton():show()
	
	if winMgr:getWindow("OTP_Notify_LuaAlpha_OkCancel") then		
	else	
	
		-- ��׶��� ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaAlpha_OkCancel")
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
		
		-- OTP ���� ������ 
		mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaMain_OkCancel")
		mainwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setProperty("FrameEnabled", "False")
		mainwindow:setProperty("BackgroundEnabled", "False")
		mainwindow:setWideType(6);
		mainwindow:setPosition(338, 246)
		mainwindow:setSize(346, 275)
		mainwindow:setVisible(false)
		mainwindow:setAlwaysOnTop(true)
		mainwindow:setZOrderingEnabled(false)
		root:addChildWindow(mainwindow)		
		
		-- UOTP ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UOTPTitle")
		mywindow:setTexture("Enabled", "UIData/popup003.tga", 685, 451)
		mywindow:setTexture("Disabled", "UIData/popup003.tga", 685, 451)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")		
		mywindow:setPosition(0, 0)
		mywindow:setSize(339, 41)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)		
		mainwindow:addChildWindow(mywindow)	
		
		-- ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "OTP_Notify_LuaText_OkCancel")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_DODUM, 115)
		mywindow:setText("")
		mywindow:setPosition(44, 120)
		mywindow:setSize(250, 36)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mainwindow:addChildWindow(mywindow)		
		
		
		-- Ȯ�ι�ư  
		mywindow = winMgr:createWindow("TaharezLook/Button", "OTP_Notify_LuaOkButton")
		mywindow:setTexture("Normal", "UIData/popup001.tga",693, 849)
		mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 849)
		mywindow:setPosition(4, 235)
		mywindow:setSize(166, 29)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "UOTPNotifyMessageOKClicked")
		mainwindow:addChildWindow(mywindow)		
		
		-- ��ҹ�ư  
		mywindow = winMgr:createWindow("TaharezLook/Button", "OTP_Notify_LuaCancelButton")
		mywindow:setTexture("Normal", "UIData/popup001.tga",858, 849)
		mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", 858, 849)
		mywindow:setPosition(169, 235)
		mywindow:setSize(166, 29)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "UOTPNotifyMessageCancelClicked")
		mainwindow:addChildWindow(mywindow)		
		
		
		-- ����Ʈ �ڽ� �׵θ� ������
		editwindow = winMgr:createWindow("TaharezLook/StaticImage", "UOTPEditboxGrid")
		editwindow:setTexture("Enabled", "UIData/CreateCharacter.tga", 0, 834)
		--editwindow:setTexture("Disabled", "UIData/CreateCharacter.tga", 0, 872)
		editwindow:setProperty("FrameEnabled", "False")
		editwindow:setProperty("BackgroundEnabled", "False")
		editwindow:setPosition(70, 180)
		editwindow:setSize(204, 38)
		editwindow:setVisible(true)
		editwindow:setAlwaysOnTop(false)
		editwindow:subscribeEvent("MouseClick", "OnMouseClick_editWindow")		
		mainwindow:addChildWindow(editwindow)				
		
		
		-- OTP ����Ʈ �ڽ�
		mywindow = winMgr:createWindow("TaharezLook/Editbox", "OTP_editbox")		
		mywindow:setPosition(3, 7)
		mywindow:setSize(204, 38)
		mywindow:setAlphaWithChild(0)
		mywindow:setUseEventController(false)
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 16)
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("TextAccepted", "UOTPNotifyMessageOKClicked")
		CEGUI.toEditbox(mywindow):setTextMasked(true)
		CEGUI.toEditbox(mywindow):setMaxTextLength(6)
		CEGUI.toEditbox(mywindow):setInputOnlyNumber()
		--CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
		--CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeActive_ID")
		editwindow:addChildWindow(mywindow)
		
		-- ����, ESC ���
		RegistEnterEventInfo("OTP_Notify_LuaMain_OkCancel", "UOTPNotifyMessageOKClicked")
		RegistEscEventInfo("OTP_Notify_LuaMain_OkCancel", "UOTPNotifyMessageCancelClicked")		
		
	end
	
	if winMgr:getWindow("OTP_Notify_LuaMain_OkCancel") then
	
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaAlpha_OkCancel"));
		winMgr:getWindow("OTP_Notify_LuaAlpha_OkCancel"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaMain_OkCancel"));
		winMgr:getWindow("OTP_Notify_LuaMain_OkCancel"):setVisible(true)
		local resultMseeage = ""
		
		if select('#', ...) == 0 then
			local i, j = string.find(message, "\n")
			if i ~= nil then
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setPosition(48, 110)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setAlign(8)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setLineSpacing(5)
				resultMseeage = message
			else
			
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				local msg = ""
				if strSize > 320 then
					local msg1, msg2 = SplitString(message, 34)
					msg = msg1 .. "\n" .. msg2
					strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
					winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setPosition(173-(strSize/2), 116)
				else
					winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setPosition(173-(strSize/2), 132)
					msg = message
				end
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setAlign(1)
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setLineSpacing(5)
				resultMseeage = msg			
			end
		else
		
			-- �μ� 1: ���Ĺ��(1:��������, 8:�������)
			local align = 1
			if select(1, ...) ~= nil then
				align = select(1, ...)
			end
			
			-- �μ� 2: ���� ���� ����
			local spacing = 5
			if select(2, ...) ~= nil then
				spacing = select(2, ...)
			end
			
			-- �μ� 3: ���� x��ġ
			local posX = 84
			if select(3, ...) ~= nil then
				posX = select(3, ...)
			end
			
			-- �μ� 4: ���� y��ġ
			local posY = 116
			if select(4, ...) ~= nil then
				posY = select(4, ...)
			end

			winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setPosition(posX, posY)
			winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):clearTextExtends()
			winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setViewTextMode(1)
			winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setAlign(align)
			winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):setLineSpacing(spacing)
			resultMseeage = message
		end
		
		local tbufStringTable = {['err']=0, }
		local tbufSpecialTable = {['err']=0, }
		local count = 0
		if resultMseeage ~= "" then
			tbufStringTable = {['err']=0, }
			tbufSpecialTable = {['err']=0, }
			count = 0					
			tbufStringTable, tbufSpecialTable = cuttingString(resultMseeage, tbufStringTable, tbufSpecialTable, count)

			for i=0, #tbufStringTable do
				local colorIndex = tonumber(tbufSpecialTable[i])
				if colorIndex == nil then
					colorIndex = 0
				end
				winMgr:getWindow("OTP_Notify_LuaText_OkCancel"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 14, 
							tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
			end
		end
	end
end


function OnMouseClick_editWindow(args)
	winMgr:getWindow("UOTPEditboxGrid"):setTexture("Enabled", "UIData/CreateCharacter.tga", 0, 872)
	winMgr:getWindow("OTP_editbox"):activate()
end


function ShowUOTPPopupOK(message, ...)

	DebugStr(message)
	
	local winMgr	= CEGUI.WindowManager:getSingleton()
	local root		= winMgr:getWindow("DefaultWindow")
	local drawer	= root:getDrawer()
	CEGUI.MouseCursor:getSingleton():show()
	
	if winMgr:getWindow("OTP_Notify_LuaAlpha_Ok") then		
	else	
	
		-- ��׶��� ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaAlpha_Ok")
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

		-- UOTP ����
		mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaMain_Ok")
		mainwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setProperty("FrameEnabled", "False")
		mainwindow:setProperty("BackgroundEnabled", "False")
		mainwindow:setWideType(6);
		mainwindow:setPosition(338, 246)
		mainwindow:setSize(346, 275)
		mainwindow:setVisible(false)
		mainwindow:setAlwaysOnTop(true)
		mainwindow:setZOrderingEnabled(false)
		root:addChildWindow(mainwindow)
		
		-- UOTP ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UOTPTitle")
		mywindow:setTexture("Enabled", "UIData/popup003.tga", 685, 451)
		mywindow:setTexture("Disabled", "UIData/popup003.tga", 685, 451)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")		
		mywindow:setPosition(0, 0)
		mywindow:setSize(339, 41)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)		
		mainwindow:addChildWindow(mywindow)

		-- ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "OTP_Notify_LuaText_Ok")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_DODUM, 115)
		mywindow:setText("")
		mywindow:setPosition(44, 120)
		mywindow:setSize(250, 36)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mainwindow:addChildWindow(mywindow)

		-- Ȯ�ι�ư  --��ɷ� ����
		mywindow = winMgr:createWindow("TaharezLook/Button", "NM_Notify_LuaOkButton")
		mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
		mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
		mywindow:setPosition(4, 235)
		mywindow:setSize(331, 29)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "OTP_NotifyMessageOKClicked_Lua")
		mainwindow:addChildWindow(mywindow)
		
		-- ����, ESC ���
		RegistEnterEventInfo("OTP_Notify_LuaMain_Ok", "OTP_NotifyMessageOKClicked_Lua")
		RegistEscEventInfo("OTP_Notify_LuaMain_Ok", "OTP_NotifyMessageOKClicked_Lua")
	end
	
	if winMgr:getWindow("OTP_Notify_LuaMain_Ok") then
	
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaAlpha_Ok"));
		winMgr:getWindow("OTP_Notify_LuaAlpha_Ok"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaMain_Ok"));
		winMgr:getWindow("OTP_Notify_LuaMain_Ok"):setVisible(true)
		local resultMseeage = ""
		
		if select('#', ...) == 0 then
			local i, j = string.find(message, "\n")
			if i ~= nil then
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setPosition(48, 110)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setAlign(8)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setLineSpacing(5)
				resultMseeage = message
			else
			
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				local msg = ""
				if strSize > 320 then
					local msg1, msg2 = SplitString(message, 34)
					msg = msg1 .. "\n" .. msg2
					strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
					winMgr:getWindow("OTP_Notify_LuaText_Ok"):setPosition(173-(strSize/2), 116)
				else
					winMgr:getWindow("OTP_Notify_LuaText_Ok"):setPosition(173-(strSize/2), 132)
					msg = message
				end
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setAlign(1)
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):setLineSpacing(5)
				resultMseeage = msg			
			end
		else
		
			-- �μ� 1: ���Ĺ��(1:��������, 8:�������)
			local align = 1
			if select(1, ...) ~= nil then
				align = select(1, ...)
			end
			
			-- �μ� 2: ���� ���� ����
			local spacing = 5
			if select(2, ...) ~= nil then
				spacing = select(2, ...)
			end
			
			-- �μ� 3: ���� x��ġ
			local posX = 84
			if select(3, ...) ~= nil then
				posX = select(3, ...)
			end
			
			-- �μ� 4: ���� y��ġ
			local posY = 116
			if select(4, ...) ~= nil then
				posY = select(4, ...)
			end

			winMgr:getWindow("OTP_Notify_LuaText_Ok"):setPosition(posX, posY)
			winMgr:getWindow("OTP_Notify_LuaText_Ok"):clearTextExtends()
			winMgr:getWindow("OTP_Notify_LuaText_Ok"):setViewTextMode(1)
			winMgr:getWindow("OTP_Notify_LuaText_Ok"):setAlign(align)
			winMgr:getWindow("OTP_Notify_LuaText_Ok"):setLineSpacing(spacing)
			resultMseeage = message
		end
		
		local tbufStringTable = {['err']=0, }
		local tbufSpecialTable = {['err']=0, }
		local count = 0
		if resultMseeage ~= "" then
			tbufStringTable = {['err']=0, }
			tbufSpecialTable = {['err']=0, }
			count = 0					
			tbufStringTable, tbufSpecialTable = cuttingString(resultMseeage, tbufStringTable, tbufSpecialTable, count)

			for i=0, #tbufStringTable do
				local colorIndex = tonumber(tbufSpecialTable[i])
				if colorIndex == nil then
					colorIndex = 0
				end
				winMgr:getWindow("OTP_Notify_LuaText_Ok"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 14, 
							tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
			end
		end
	end
end


function OTP_NotifyMessageOKClicked_Lua()

	local winMgr = CEGUI.WindowManager:getSingleton()

	winMgr:getWindow("OTP_Notify_LuaAlpha_Ok"):setVisible(false)
	winMgr:getWindow("OTP_Notify_LuaMain_Ok"):setVisible(false)
	winMgr:getWindow("OTP_Notify_LuaText_Ok"):setText("")
--	SetInputEnable(true)

	U_OTPPopup()
end




function ShowUOTPPopupFiveTimesFail(message, ...)

	DebugStr(message)
	
	local winMgr	= CEGUI.WindowManager:getSingleton()
	local root		= winMgr:getWindow("DefaultWindow")
	local drawer	= root:getDrawer()
	CEGUI.MouseCursor:getSingleton():show()
	
	if winMgr:getWindow("OTP_Notify_LuaAlpha_Five") then		
	else	
	
		-- ��׶��� ���� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaAlpha_Five")
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

		-- UOTP ����
		mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "OTP_Notify_LuaMain_Five")
		mainwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
		mainwindow:setProperty("FrameEnabled", "False")
		mainwindow:setProperty("BackgroundEnabled", "False")
		mainwindow:setWideType(6);
		mainwindow:setPosition(338, 246)
		mainwindow:setSize(346, 275)
		mainwindow:setVisible(false)
		mainwindow:setAlwaysOnTop(true)
		mainwindow:setZOrderingEnabled(false)
		root:addChildWindow(mainwindow)
		
		-- UOTP ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UOTPTitle")
		mywindow:setTexture("Enabled", "UIData/popup003.tga", 685, 451)
		mywindow:setTexture("Disabled", "UIData/popup003.tga", 685, 451)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")		
		mywindow:setPosition(0, 0)
		mywindow:setSize(339, 41)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)		
		mainwindow:addChildWindow(mywindow)

		-- ����â
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "OTP_Notify_LuaText_Five")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_DODUM, 115)
		mywindow:setText("")
		mywindow:setPosition(44, 120)
		mywindow:setSize(250, 36)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mainwindow:addChildWindow(mywindow)

		-- Ȯ�ι�ư  --��ɷ� ����
		mywindow = winMgr:createWindow("TaharezLook/Button", "NM_Notify_LuaOkButton")
		mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
		mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
		mywindow:setPosition(4, 235)
		mywindow:setSize(331, 29)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("Clicked", "OTP_NotifyMessageOKClicked_Lua_Five")
		mainwindow:addChildWindow(mywindow)
		
		-- ����, ESC ���
		RegistEnterEventInfo("OTP_Notify_LuaMain_Five", "OTP_NotifyMessageOKClicked_Lua")
		RegistEscEventInfo("OTP_Notify_LuaMain_Five", "OTP_NotifyMessageOKClicked_Lua")
	end
	
	if winMgr:getWindow("OTP_Notify_LuaMain_Five") then
	
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaAlpha_Five"));
		winMgr:getWindow("OTP_Notify_LuaAlpha_Five"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("OTP_Notify_LuaMain_Five"));
		winMgr:getWindow("OTP_Notify_LuaMain_Five"):setVisible(true)
		local resultMseeage = ""
		
		if select('#', ...) == 0 then
			local i, j = string.find(message, "\n")
			if i ~= nil then
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setPosition(48, 110)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setAlign(8)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setLineSpacing(5)
				resultMseeage = message
			else
			
				local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
				local msg = ""
				if strSize > 320 then
					local msg1, msg2 = SplitString(message, 34)
					msg = msg1 .. "\n" .. msg2
					strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
					winMgr:getWindow("OTP_Notify_LuaText_Five"):setPosition(173-(strSize/2), 116)
				else
					winMgr:getWindow("OTP_Notify_LuaText_Five"):setPosition(173-(strSize/2), 132)
					msg = message
				end
				winMgr:getWindow("OTP_Notify_LuaText_Five"):clearTextExtends()
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setViewTextMode(1)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setAlign(1)
				winMgr:getWindow("OTP_Notify_LuaText_Five"):setLineSpacing(5)
				resultMseeage = msg			
			end
		else
		
			-- �μ� 1: ���Ĺ��(1:��������, 8:�������)
			local align = 1
			if select(1, ...) ~= nil then
				align = select(1, ...)
			end
			
			-- �μ� 2: ���� ���� ����
			local spacing = 5
			if select(2, ...) ~= nil then
				spacing = select(2, ...)
			end
			
			-- �μ� 3: ���� x��ġ
			local posX = 84
			if select(3, ...) ~= nil then
				posX = select(3, ...)
			end
			
			-- �μ� 4: ���� y��ġ
			local posY = 116
			if select(4, ...) ~= nil then
				posY = select(4, ...)
			end

			winMgr:getWindow("OTP_Notify_LuaText_Five"):setPosition(posX, posY)
			winMgr:getWindow("OTP_Notify_LuaText_Five"):clearTextExtends()
			winMgr:getWindow("OTP_Notify_LuaText_Five"):setViewTextMode(1)
			winMgr:getWindow("OTP_Notify_LuaText_Five"):setAlign(align)
			winMgr:getWindow("OTP_Notify_LuaText_Five"):setLineSpacing(spacing)
			resultMseeage = message
		end
		
		local tbufStringTable = {['err']=0, }
		local tbufSpecialTable = {['err']=0, }
		local count = 0
		if resultMseeage ~= "" then
			tbufStringTable = {['err']=0, }
			tbufSpecialTable = {['err']=0, }
			count = 0					
			tbufStringTable, tbufSpecialTable = cuttingString(resultMseeage, tbufStringTable, tbufSpecialTable, count)

			for i=0, #tbufStringTable do
				local colorIndex = tonumber(tbufSpecialTable[i])
				if colorIndex == nil then
					colorIndex = 0
				end
				winMgr:getWindow("OTP_Notify_LuaText_Five"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 14, 
							tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
			end
		end
	end
end


function OTP_NotifyMessageOKClicked_Lua_Five()

	local winMgr = CEGUI.WindowManager:getSingleton()

	winMgr:getWindow("OTP_Notify_LuaAlpha_Five"):setVisible(false)
	winMgr:getWindow("OTP_Notify_LuaMain_Five"):setVisible(false)
	winMgr:getWindow("OTP_Notify_LuaText_Five"):setText("")
--	SetInputEnable(true)

	-- 5ȸ �̻� Ʋ���� ������ �����Ѵ�
	ExitAskPopupSelected(1)
end




-- ��������â�� ũ�⸦ ���ϴ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginTemplate")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198, 220)
mywindow:setSize(645, 1500)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

if IsEngLanguage() or IsGSPLanguage() then
	--------------------------------------------------------------------
	-- �α��� BG �̹���
	--------------------------------------------------------------------
	local WndLoginBG = winMgr:createWindow("TaharezLook/StaticImage", "login_BG")
	WndLoginBG:setVisible(true)	
	WndLoginBG:setEnabled(true)
	WndLoginBG:setZOrderingEnabled(false)
	root:addChildWindow(WndLoginBG)

if IsEngLanguage() then
	--------------------------------------------------------------------
	-- FaceBook�α��� ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "login_RequestFaceBook_btn")
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClickRequestFaceBookLogin")
	WndLoginBG:addChildWindow(mywindow)

	function ClickRequestFaceBookLogin()
		ShowFacebookLogin();
	end
	
	--------------------------------------------------------------------
	-- Google�α��� ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "login_RequestGoogle_btn")
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClickRequestGoogleLogin")
	WndLoginBG:addChildWindow(mywindow)

	function ClickRequestGoogleLogin()
		ShowGoogleLogin();
	end
end		
	--------------------------------------------------------------------
	-- PlayID �α��� ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "login_RequestPlayID_btn")
	mywindow:setZOrderingEnabled(false)
	WndLoginBG:addChildWindow(mywindow)
	mywindow:subscribeEvent("Clicked", "ClickRequestASLogin")

	function ClickRequestASLogin()
		DebugStr("ClickRequestLogin AS")
		local ID = winMgr:getWindow("login_AS_ID_editbox"):getText()
		local PW = winMgr:getWindow("login_AS_PW_editbox"):getText()
		winMgr:getWindow("login_AS_ID_editbox"):deactivate()
		winMgr:getWindow("login_AS_PW_editbox"):deactivate()
		winMgr:getWindow("login_RequestPlayID_btn"):setEnabled(false)
		
		--DebugStr(ID)
		--DebugStr(PW)
		
		local Test = winMgr:getWindow("SavePlayIDCheck_img"):isVisible()
		
		RequestLogin(ID, PW, Test)
	end
	--------------------------------------------------------------------
	-- SAVE PlayID Check ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SavePlayID_btn")
	mywindow:setVisible(true)
	mywindow:setEnabled(true)	
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClickSavePlayID_btn")
	WndLoginBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SavePlayIDCheck_img")
	mywindow:setVisible(true)
	mywindow:setEnabled(false)	
	mywindow:setZOrderingEnabled(false)
	WndLoginBG:addChildWindow(mywindow)
	
	function ClickSavePlayID_btn()
		mywindow = winMgr:getWindow("SavePlayIDCheck_img")
		if mywindow:isVisible() == true then
			mywindow:setVisible(false)
		else
			mywindow:setVisible(true)
		end
	end
	
	function InitLoginOption(bSavePlayID, ID)
		DebugStr(ID)
		mywindow = winMgr:getWindow("SavePlayIDCheck_img")
		mywindow:setVisible(bSavePlayID)
	
		mywindow = winMgr:getWindow("login_AS_ID_editbox")
		mywindow:setText(ID)
	end
	--------------------------------------------------------------------
	-- Login ID Edit BG
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "login_AS_ID_BG")
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndLoginBG:addChildWindow(mywindow)

	--------------------------------------------------------------------
	-- Login ID Edit box
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "login_AS_ID_editbox")
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)

	mywindow:setTextColor(0, 0, 0, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("TextAccepted", "ChangeASActive_PW")
	CEGUI.toEditbox(mywindow):setMaxTextLength(37)
	CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnASIDEditboxFullEvent")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeASActive_PW")
	WndLoginBG:addChildWindow(mywindow)
	winMgr:getWindow("login_AS_ID_editbox"):activate()

	function OnASIDEditboxFullEvent(args)
		PlayWave('sound/FullEdit.wav')
	end

	function ChangeASActive_PW()
		winMgr:getWindow("login_AS_PW_editbox"):activate()
	end

	--------------------------------------------------------------------
	-- Login PW Edit BG
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "login_AS_PW_BG")

	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndLoginBG:addChildWindow(mywindow)

	--------------------------------------------------------------------
	-- Login PW Edit box
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "login_AS_PW_editbox")
	--mywindow:setWideType(7)
	--mywindow:setPosition(67, 223)
	--mywindow:setSize(256, 44)	
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 32)
	mywindow:setTextColor(0, 0, 0, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(false)
	--mywindow:subscribeEvent("TextAccepted", "ChangeActive_Password")
	mywindow:subscribeEvent("TextAccepted", "ClickRequestASLogin")
	CEGUI.toEditbox(mywindow):setTextMasked(true)
	CEGUI.toEditbox(mywindow):setMaxTextLength(16)
	CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnASPWEditboxFullEvent")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "ChangeASActive_ID")
	WndLoginBG:addChildWindow(mywindow)


	function OnASPWEditboxFullEvent(args)
		PlayWave('sound/FullEdit.wav')
	end

	function ChangeASActive_ID()
		winMgr:getWindow("login_AS_ID_editbox"):activate()
	end
	
	function Wnd_ASLogin_LoginError()
		winMgr:getWindow("login_RequestPlayID_btn"):setEnabled(true)
		--winMgr:getWindow("login_AS_ID_editbox"):setText("")
		winMgr:getWindow("login_AS_ID_editbox"):activate()
		winMgr:getWindow("login_AS_PW_editbox"):setText("")
	end
	
	if wightSize > 1300 then--�ػ󵵰� 1300 �̻��̸� ū �̹����� ����
		WndLoginBG:setTexture("Enabled", "UIData/Login_on.tga", 0, 0)
		WndLoginBG:setTexture("Disabled", "UIData/Login_on.tga", 0, 0)
		local PosX = 10 * wightSize / 1024;
		local PosY = 170 * heightSize / 768; 
		WndLoginBG:setPosition(PosX, PosY)
		WndLoginBG:setSize(377, 543)
if IsEngLanguage() then
		mywindow = winMgr:getWindow("login_RequestFaceBook_btn")
		mywindow:setPosition(140, 420)
		mywindow:setSize(91, 91)
		mywindow:setTexture("Normal", "UIData/Login_on.tga", 377, 270 + (91 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on.tga", 377, 270 + (91 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on.tga", 377, 270 + (91 * 2))
		mywindow:setTexture("PushedOff", "UIData/Login_on.tga", 377, 270 + (91 * 2))
		mywindow:setTexture("Disabled", "UIData/Login_on.tga", 377, 270 + (91 * 2))

		mywindow = winMgr:getWindow("login_RequestGoogle_btn")
		mywindow:setPosition(250, 420)
		mywindow:setSize(91, 91)
		mywindow:setTexture("Normal", "UIData/Login_on.tga", 468, 270 + (91 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on.tga", 468, 270 + (91 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on.tga", 468, 270 + (91 * 2))
		mywindow:setTexture("PushedOff", "UIData/Login_on.tga", 468, 270 + (91 * 2))
		mywindow:setTexture("Disabled", "UIData/Login_on.tga",  468, 270 + (91 * 2))
end
		mywindow = winMgr:getWindow("login_RequestPlayID_btn")
		mywindow:setPosition(80, 300)
		mywindow:setSize(224, 66)
		mywindow:setTexture("Normal", "UIData/Login_on.tga", 377, 72 + (66 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on.tga", 377, 72 + (66 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on.tga", 377, 72 + (66 * 2))

		
		mywindow = winMgr:getWindow("login_AS_ID_BG")
		mywindow:setPosition(38, 130)
		mywindow:setSize(304, 36)		
		mywindow:setTexture("Enabled", "UIData/Login_on.tga", 377, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on.tga", 377, 0)

		mywindow = winMgr:getWindow("login_AS_ID_editbox")
		mywindow:setPosition(43, 136)
		mywindow:setSize(256, 44)	
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 16)
		
		mywindow = winMgr:getWindow("login_AS_PW_BG")
		mywindow:setPosition(38, 201)
		mywindow:setSize(304, 36)	
		mywindow:setTexture("Enabled", "UIData/Login_on.tga", 377, 36)
		mywindow:setTexture("Disabled", "UIData/Login_on.tga", 377, 36)
		
		
		mywindow = winMgr:getWindow("login_AS_PW_editbox")
		mywindow:setPosition(43, 207)
		mywindow:setSize(256, 44)	
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 16)
		
		mywindow = winMgr:getWindow("SavePlayID_btn")
		mywindow:setPosition(316, 235)
		mywindow:setSize(26, 26)		
		mywindow:setTexture("Normal", "UIData/Login_on.tga", 681, 0)
		mywindow:setTexture("Hover", "UIData/Login_on.tga", 681, 0)
		mywindow:setTexture("Pushed", "UIData/Login_on.tga", 681, 0)
		mywindow:setTexture("PushedOff", "UIData/Login_on.tga", 681, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on.tga",  681, 0)
		
		mywindow = winMgr:getWindow("SavePlayIDCheck_img")
		mywindow:setPosition(316, 235)
		mywindow:setSize(26, 26)		
		mywindow:setTexture("Enabled", "UIData/Login_on.tga", 707, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on.tga", 707, 0)
	else
		WndLoginBG:setTexture("Enabled", "UIData/Login_on_002.tga", 0, 0)
		WndLoginBG:setTexture("Disabled", "UIData/Login_on_002.tga", 0, 0)
		local PosX = 10 * wightSize / 1024;
		local PosY = 170 * heightSize / 768; 
		WndLoginBG:setPosition(PosX, PosY)
		
		WndLoginBG:setSize(280, 383)
if IsEngLanguage() then
		mywindow = winMgr:getWindow("login_RequestFaceBook_btn")
		mywindow:setPosition(125, 300)
		mywindow:setSize(60, 58)
		mywindow:setTexture("Normal", "UIData/Login_on_002.tga", 281, 202 + (58 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on_002.tga", 281, 202 + (58 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on_002.tga", 281, 202 + (58 * 2))
		mywindow:setTexture("PushedOff", "UIData/Login_on_002.tga", 281, 202 + (58 * 2))
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga", 281, 202 + (58 * 2))

		mywindow = winMgr:getWindow("login_RequestGoogle_btn")
		mywindow:setPosition(195, 300)
		mywindow:setSize(60, 58)
		mywindow:setTexture("Normal", "UIData/Login_on_002.tga", 341, 202 + (58 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on_002.tga", 341, 202 + (58 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on_002.tga", 341, 202 + (58 * 2))
		mywindow:setTexture("PushedOff", "UIData/Login_on_002.tga", 341, 202 + (58 * 2))
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga",  341, 202 + (58 * 2))
end
		mywindow = winMgr:getWindow("login_RequestPlayID_btn")
		mywindow:setPosition(68, 220)
		mywindow:setSize(150, 44)
		mywindow:setTexture("Normal", "UIData/Login_on_002.tga", 281, 70 + (44 * 0))
		mywindow:setTexture("Hover", "UIData/Login_on_002.tga", 281, 70 + (44 * 1))
		mywindow:setTexture("Pushed", "UIData/Login_on_002.tga", 281, 70 + (44 * 2))

		
		mywindow = winMgr:getWindow("login_AS_ID_BG")
		mywindow:setPosition(25, 95)
		mywindow:setSize(235, 35)		
		mywindow:setTexture("Enabled", "UIData/Login_on_002.tga", 281, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga", 281, 0)

		mywindow = winMgr:getWindow("login_AS_ID_editbox")
		mywindow:setPosition(25, 102)
		mywindow:setSize(235, 35)	
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 14)
		
		mywindow = winMgr:getWindow("login_AS_PW_BG")
		mywindow:setPosition(25, 148)
		mywindow:setSize(235, 35)		
		mywindow:setTexture("Enabled", "UIData/Login_on_002.tga", 281, 0 + (35 * 1))
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga", 281, 0 + (35 * 1))
		
		mywindow = winMgr:getWindow("login_AS_PW_editbox")
		mywindow:setPosition(25, 155)
		mywindow:setSize(235, 35)	
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 14)
		
		mywindow = winMgr:getWindow("SavePlayID_btn")
		mywindow:setPosition(240, 188)
		mywindow:setSize(21, 19)		
		mywindow:setTexture("Normal", "UIData/Login_on_002.tga", 516, 0)
		mywindow:setTexture("Hover", "UIData/Login_on_002.tga", 516, 0)
		mywindow:setTexture("Pushed", "UIData/Login_on_002.tga", 516, 0)
		mywindow:setTexture("PushedOff", "UIData/Login_on_002.tga", 516, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga",  516, 0)
		
		mywindow = winMgr:getWindow("SavePlayIDCheck_img")
		mywindow:setPosition(240, 188)
		mywindow:setSize(21, 19)		
		mywindow:setTexture("Enabled", "UIData/Login_on_002.tga", 537, 0)
		mywindow:setTexture("Disabled", "UIData/Login_on_002.tga", 537, 0)
		
	end	
	
end