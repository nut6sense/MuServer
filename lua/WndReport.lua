-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


g_bExcuseButtonClick	= false		-- ��ӹ�ư ������ ���� Ȯ�� ���� ����
g_ReportType			= nil		-- �Ű��� ���� ( 0 = �ΰ� �� , 1 = �ҹ� ���α׷� , 2 = ��� ���� , 3 = ���� �ŷ� )
g_ReportCharName		= nil		-- �Ű� ���� ĳ���� �̸�

local TEXTURE_HEIGHT	= 924
local TEXTURE_OFFSET_Y	= 18
	
RegistEscEventInfo("REPORT_MainWindow", "CancleReportData")


-- # ���� ��� �̹��� ======================================================================
myReportMainWindow = winMgr:createWindow("TaharezLook/StaticImage" , "REPORT_Alpha_Img")
myReportMainWindow:setTexture("Enabled" ,	'UIData/OnDLGBackImage.tga', 0, 0);
myReportMainWindow:setTexture("Disabled" ,	'UIData/OnDLGBackImage.tga', 0, 0);
myReportMainWindow:setProperty("BackgroundEnabled", "False")
myReportMainWindow:setProperty("FrameEnabled", "False")
myReportMainWindow:setWideType(6)
myReportMainWindow:setPosition(0,0)
myReportMainWindow:setSize(1920, 1200)
myReportMainWindow:setVisible(false)
myReportMainWindow:setEnabled(true)
myReportMainWindow:setAlwaysOnTop(true)
myReportMainWindow:setZOrderingEnabled(false)
root:addChildWindow(myReportMainWindow)


-- # �Ű�â ��� �̹��� ======================================================================
myReportMainWindow = winMgr:createWindow("TaharezLook/StaticImage" , "REPORT_MainWindow")
myReportMainWindow:setTexture("Enabled" ,	"UIData/messenger.tga" , 0 , 834)
myReportMainWindow:setTexture("Disabled" ,	"UIData/messenger.tga" , 0 , 834)

myReportMainWindow:setProperty("BackgroundEnabled", "False")
myReportMainWindow:setProperty("FrameEnabled", "False")
myReportMainWindow:setWideType(6)
myReportMainWindow:setPosition(300 , 285)
myReportMainWindow:setSize(408, 190)
myReportMainWindow:setVisible(false)
myReportMainWindow:setEnabled(true)
myReportMainWindow:setAlwaysOnTop(true)
myReportMainWindow:setZOrderingEnabled(false)
root:addChildWindow(myReportMainWindow)



-- # �Ű��� ���̵�/���� ==================================================================
myReportWindow = winMgr:createWindow("TaharezLook/StaticText" , "REPORT_BasicText")
myReportWindow:setSize(161 , 23)
myReportWindow:setPosition(125 , 45)
myReportWindow:setViewTextMode(1)
myReportWindow:setAlign(8)
myReportWindow:setLineSpacing(2)
myReportWindow:setFont(g_STRING_FONT_GULIM , 14)
myReportWindow:setTextColor(255,255,255,255)
myReportWindow:setZOrderingEnabled(false)
myReportMainWindow:addChildWindow(myReportWindow)



-- # �Ű�â Ÿ��Ʋ �� ======================================================================
myReportTitlebar = winMgr:createWindow("TaharezLook/Titlebar", "REPORT_TitleBar")
myReportTitlebar:setPosition(3 , 1)
myReportTitlebar:setSize(350 , 60)
myReportTitlebar:setEnabled(true)
myReportMainWindow:addChildWindow(myReportTitlebar)



-- # ����ڽ� ��ư ======================================================================
myReportDropButton = winMgr:createWindow("TaharezLook/Button", "REPORT_DropButton")
myReportDropButton:setTexture("Normal",		"UIData/messenger.tga", 770, 952)
myReportDropButton:setTexture("Hover",		"UIData/messenger.tga", 770, 970)
myReportDropButton:setTexture("Pushed",		"UIData/messenger.tga", 770, 988)
myReportDropButton:setTexture("PushedOff",	"UIData/messenger.tga", 770, 952)
myReportDropButton:setTexture("Disabled",	"UIData/messenger.tga", 770, 1006)

myReportDropButton:setPosition(366 , 71)
myReportDropButton:setSize(18 , 18)
myReportDropButton:setZOrderingEnabled(false)
myReportDropButton:setAlwaysOnTop(true)
myReportDropButton:subscribeEvent( "Clicked" , "ReportDropDown" )
winMgr:getWindow("REPORT_MainWindow"):addChildWindow(myReportDropButton)


-- # ����ڽ� ��ư �� ����======================================================================
myReportDropButton = winMgr:createWindow("TaharezLook/Button", "REPORT_DropImageButton")
myReportDropButton:setTexture("Normal",		"UIData/invisible.tga", 0, 0)
myReportDropButton:setTexture("Hover",		"UIData/invisible.tga", 0, 0)
myReportDropButton:setTexture("Pushed",		"UIData/invisible.tga", 0, 0)
myReportDropButton:setTexture("PushedOff",	"UIData/invisible.tga", 0, 0)
myReportDropButton:setPosition(25 , 70)	
myReportDropButton:setSize(340 , 21)
myReportDropButton:setZOrderingEnabled(false)
myReportDropButton:setAlwaysOnTop(true)
myReportDropButton:subscribeEvent( "Clicked" , "ReportDropDown" )
winMgr:getWindow("REPORT_MainWindow"):addChildWindow(myReportDropButton)



-- # �Ű�â "Ȯ��" ��ư ======================================================================
myReportSendButton = winMgr:createWindow("TaharezLook/Button", "REPORT_SendButton")
myReportSendButton:setTexture("Normal",		"UIData/messenger.tga"	, 862, 916)
myReportSendButton:setTexture("Hover",		"UIData/messenger.tga"	, 862, 943)
myReportSendButton:setTexture("Pushed",		"UIData/messenger.tga"	, 862, 970)
myReportSendButton:setTexture("PushedOff",	"UIData/messenger.tga"	, 862, 916)
myReportSendButton:setTexture("Disabled",	"UIData/messenger.tga"	, 862, 997)

myReportSendButton:setSize(81 , 27)
myReportSendButton:setPosition(122 , 145)
myReportSendButton:setEnabled(true)
myReportSendButton:setAlwaysOnTop(false)
myReportSendButton:setZOrderingEnabled(false)
myReportSendButton:subscribeEvent("Clicked", "SendReportData")

winMgr:getWindow("REPORT_MainWindow"):addChildWindow(myReportSendButton)


-- # �Ű�â "���" ��ư ======================================================================
myReportCancelButton = winMgr:createWindow("TaharezLook/Button", "REPORT_CancelButton")
myReportCancelButton:setTexture("Normal",		"UIData/messenger.tga"	, 943, 916)
myReportCancelButton:setTexture("Hover",		"UIData/messenger.tga"	, 943, 943)
myReportCancelButton:setTexture("Pushed",		"UIData/messenger.tga"	, 943, 970)
myReportCancelButton:setTexture("PushedOff",	"UIData/messenger.tga"	, 943, 916)
myReportCancelButton:setTexture("Disabled",		"UIData/messenger.tga"	, 943, 997)

myReportCancelButton:setSize(81, 27)
myReportCancelButton:setPosition(204 , 145)
myReportCancelButton:setEnabled(true)
myReportCancelButton:setZOrderingEnabled(false)
myReportCancelButton:subscribeEvent("Clicked", "CancleReportData")
winMgr:getWindow("REPORT_MainWindow"):addChildWindow(myReportCancelButton)


-- # �Ű�â "�ݱ�" ��ư ======================================================================
myReportCloseButton = winMgr:createWindow("TaharezLook/Button", "REPORT_CloseButton")
myReportCloseButton:setTexture("Normal",	"UIData/menu.tga",	197, 0)
myReportCloseButton:setTexture("Hover",		"UIData/menu.tga",	197, 23)
myReportCloseButton:setTexture("Pushed",	"UIData/menu.tga",	197, 46)
myReportCloseButton:setTexture("PushedOff",	"UIData/menu.tga",	197, 0)
myReportCloseButton:setSize(23, 23)
myReportCloseButton:setPosition(375 , 10)
myReportCloseButton:setEnabled(true)
myReportCloseButton:setZOrderingEnabled(false)
myReportCloseButton:setAlwaysOnTop(true)
myReportCloseButton:subscribeEvent("Clicked", "CancleReportData")

winMgr:getWindow("REPORT_MainWindow"):addChildWindow(myReportCloseButton)



-- # �Ű�â �Ű� ���� ���� ��ư ===============================================================
tReportExcuseName = { ["protecterr"] = 0 , [0] = "Excuse1" , "Excuse2" , "Excuse3" , "Excuse4" , "Excuse5" }

for i = 0 , #tReportExcuseName do
	myReportWnd = winMgr:createWindow("TaharezLook/RadioButton" , tReportExcuseName[i])
	
	if i == 4 then	-- ���ҽ� ������ �����ϰ� ���� �ʴ� ������ư�� ���� ����
		myReportWnd:setTexture("Normal",		"UIData/messenger.tga", 409, 1004 )
		myReportWnd:setTexture("Hover",			"UIData/messenger.tga", 409, 1004 )
		myReportWnd:setTexture("Pushed",		"UIData/messenger.tga", 409, 1004 )
		myReportWnd:setTexture("SelectedNormal","UIData/messenger.tga", 409, 1004 )
		myReportWnd:setTexture("SelectedHover", "UIData/messenger.tga", 409, 1004 )
		myReportWnd:setTexture("SelectedPushed","UIData/messenger.tga", 409, 1004 )
	else
		myReportWnd:setTexture("Normal",		"UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
		myReportWnd:setTexture("Hover",			"UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
		myReportWnd:setTexture("Pushed",		"UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
		myReportWnd:setTexture("SelectedNormal","UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
		myReportWnd:setTexture("SelectedHover", "UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
		myReportWnd:setTexture("SelectedPushed","UIData/messenger.tga", 409, TEXTURE_HEIGHT + ( 20 * i ) )
	end
	
	if i == 0 then	-- Excuse1 �̶��
		myReportWnd:setTexture("Normal",		"UIData/messenger.tga", 409, 944 )
		myReportWnd:setTexture("Hover",			"UIData/messenger.tga", 409, 944 )
		myReportWnd:setTexture("Pushed",		"UIData/messenger.tga", 409, 944 )
		myReportWnd:setTexture("SelectedNormal","UIData/messenger.tga", 409, 944 )
		myReportWnd:setTexture("SelectedHover", "UIData/messenger.tga", 409, 944 )
		myReportWnd:setTexture("SelectedPushed","UIData/messenger.tga", 409, 944 )
		
		myReportWnd:setVisible(true)
	else
		myReportWnd:setVisible(false)
	end
	
	myReportWnd:setPosition(25 , 70+(TEXTURE_OFFSET_Y * i))	
	myReportWnd:setSize(360 , 21)
	myReportWnd:setEnabled(true)
	myReportWnd:setZOrderingEnabled(false)
	myReportWnd:setProperty("GroupID" , 8195)
	myReportWnd:subscribeEvent("SelectStateChanged" , "ReportMenuSelect")

	myReportMainWindow:addChildWindow(myReportWnd)
end



-- # �Ű��ϱ� â ���� ====================================================================
function ShowReportWindow(CharName)
	if CharName == nil then
		return
	end	-- end of if
	
	-- ĳ���� �̸��� �޾ƿ�
	g_ReportCharName	= CharName	-- �Ű� ����� �̸� �޾ƿ���
	g_ReportType		= 0			-- �Ű� ���� �⺻�� �����ϱ� (0 == �ΰ� �� �� �弳)
	
	-- ĳ���� �̸��� ����
	winMgr:getWindow("REPORT_BasicText"):setTextExtends(g_ReportCharName,  g_STRING_FONT_GULIMCHE ,  12  ,255,255,255,255,  0,  0,0,0,255);
	
	-- ����â ���̱�
	root:addChildWindow(winMgr:getWindow("REPORT_Alpha_Img"))
	winMgr:getWindow("REPORT_Alpha_Img"):setVisible(true)
	
	-- ����â ���̱�
	root:addChildWindow(winMgr:getWindow("REPORT_MainWindow"))
	winMgr:getWindow("REPORT_MainWindow"):setVisible(true)
end


-- # ��� ��ư ��ġ�� ====================================================================
function ReportDropDown()
	--for i = 0 , #tReportExcuseName do
	if g_bExcuseButtonClick == false then
		winMgr:getWindow(tReportExcuseName[1]):setVisible(true)
		winMgr:getWindow(tReportExcuseName[2]):setVisible(true)
		winMgr:getWindow(tReportExcuseName[3]):setVisible(true)
		winMgr:getWindow(tReportExcuseName[4]):setVisible(true)
		
		g_bExcuseButtonClick = true
	else
		winMgr:getWindow(tReportExcuseName[1]):setVisible(false)
		winMgr:getWindow(tReportExcuseName[2]):setVisible(false)
		winMgr:getWindow(tReportExcuseName[3]):setVisible(false)
		winMgr:getWindow(tReportExcuseName[4]):setVisible(false)
		
		g_bExcuseButtonClick = false
	end	-- end of if
end	-- end of function


-- # ���� ��ư Ŭ�� ====================================================================
function ReportMenuSelect()
	if g_bExcuseButtonClick == false then
		return
	end
	
	winMgr:getWindow(tReportExcuseName[1]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[2]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[3]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[4]):setVisible(false)
	
	g_bExcuseButtonClick = false
			
	if CEGUI.toRadioButton(winMgr:getWindow("Excuse2")):isSelected() == true then
		ChangeTexturePosition(409, 944, 0)	-- x , y , ReportType
	elseif CEGUI.toRadioButton(winMgr:getWindow("Excuse3")):isSelected() == true then
		ChangeTexturePosition(409, 964, 1)	-- x , y , ReportType
	elseif CEGUI.toRadioButton(winMgr:getWindow("Excuse4")):isSelected() == true then
		ChangeTexturePosition(409, 984, 2)	-- x , y , ReportType
	elseif CEGUI.toRadioButton(winMgr:getWindow("Excuse5")):isSelected() == true then
		ChangeTexturePosition(409, 1004, 3)	-- x , y , ReportType
	end	-- end of elseif
end


-- # Ȯ�� ��ư Ŭ�� ====================================================================
function SendReportData()
	if g_ReportType == nil then	-- �Ű� Type�� ���������� �ʴٸ� ���Ͻ��Ѷ�.
		DebugStr('�Ű� Type ����')
		
		local string = "�Ű� ������ ���õ��� �ʾҽ��ϴ�."
		ShowNotifyOKMessage_Lua(string)
		return
	end	-- end of if
		
		
	DebugStr("�Ű� �����: " .. g_ReportCharName)
	DebugStr("�Ű� ����  : " .. g_ReportType)
	
	SendReportCharData(g_ReportType , g_ReportCharName)	-- static C�Լ� : ĳ���� �̸��� �Ű������� ��Ŷ���� ����.
	myReportMainWindow:setVisible(false)				-- ����â�� Off.
end


-- # ��� ��ư Ŭ�� ====================================================================
function CancleReportData()
	g_ReportType		= nil
	g_ReportCharName	= nil
	
	-- ����â�� ��ư���� �ݴ´�
	winMgr:getWindow(tReportExcuseName[1]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[2]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[3]):setVisible(false)
	winMgr:getWindow(tReportExcuseName[4]):setVisible(false)
	
	winMgr:getWindow("REPORT_Alpha_Img"):setVisible(false)
	
	g_bExcuseButtonClick = false
	myReportMainWindow:setVisible(false)
	
end


-- # �ؽ��� ��ġ ���� �Լ� =============================================================
function ChangeTexturePosition(PosX , PosY , ReportType)
	g_ReportType = ReportType
	
	winMgr:getWindow("Excuse1"):setTexture("Normal",		"UIData/messenger.tga", PosX , PosY)
	winMgr:getWindow("Excuse1"):setTexture("Hover",			"UIData/messenger.tga", PosX , PosY)
	winMgr:getWindow("Excuse1"):setTexture("Pushed",		"UIData/messenger.tga", PosX , PosY)
	winMgr:getWindow("Excuse1"):setTexture("SelectedNormal","UIData/messenger.tga", PosX , PosY)
	winMgr:getWindow("Excuse1"):setTexture("SelectedHover", "UIData/messenger.tga", PosX , PosY)
	winMgr:getWindow("Excuse1"):setTexture("SelectedPushed","UIData/messenger.tga", PosX , PosY)
		
	DebugStr("�Ű�Type: " .. ReportType)
end

