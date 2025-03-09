function WndSelectChannel_WndSelectChannel()


-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

local MAX_VILLAGE_CHANNEL = GetMaxVillageChannel()
local MAX_BATTLE_CHANNEL  = GetMaxBattleChannel()


Quitindex = 1

------------------------------------------------------------
-- ���� ���� �ϱ�
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectChannel_FastEnterVillageButton")
mywindow:setTexture("Normal", "UIData/channel_003.tga", 0, 323)
mywindow:setTexture("Hover", "UIData/channel_003.tga", 0, 377)
mywindow:setTexture("Pushed", "UIData/channel_003.tga", 0, 431)
mywindow:setTexture("PushedOff", "UIData/channel_003.tga", 0, 323)
mywindow:setWideType(6);
mywindow:setPosition(490, 640)
mywindow:setSize(338, 54)


--0426KSG ����
---- �Ϲ� ���� �ϰ� ���� ����
--if IsEngLanguage() == false then
--	mywindow:setVisible(true)
--else
--	mywindow:setVisible(false)
--end

mywindow:setVisible(true)

mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFastEnterVillage")
root:addChildWindow(mywindow)


function ClickedFastEnterVillage(args)
	FastEnterVillage()
end

-----------------------------------------------------------------------------

-- 2�� ��й�ȣ ���á� ("�±�","�̱�" ���� ������)

-----------------------------------------------------------------------------
--if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then -- �ѱ��� �ƴϸ� �����Ѵ�.----0421KSG
	
	if Quitindex == 1 then
	
	--================================================
	--					���� ���� 
	--================================================
	local EXIST_MODE_NOT_NEED	= 0
	local EXIST_MODE_HAVE_PW	= 1
	local EXIST_MODE_NEED		= 2
	
	-- �н����� 4���� �� ���� �Ǵ�
	g_bPassWordFullSelected		= false
	
	-- ��ü������ �������� �÷���
	local STANCE_PASSWORD_NOT_NEED		= 0
	
	local STANCE_PASSWORD_CREATE_ONE	= 1
	local STANCE_PASSWORD_CREATE_TWO	= 2
	
	local STANCE_PASSWORD_CHECK			= 3
	
	local STANCE_PASSWORD_MODIFY_ONE	= 4
	local STANCE_PASSWORD_MODIFY_TWO	= 5
	local STANCE_PASSWORD_MODIFY_THREE	= 6
	local STANCE_PASSWORD_DESTROY		= 7
	
	g_nStanceFlag						= STANCE_PASSWORD_NOT_NEED
	
	function SetPassWordStanceFlag(flag)
		g_nStanceFlag = flag		
	end


	local PASSWORD_NOT_SELECT	= -1
	local PASSWORD_ONE			= 1
	local PASSWORD_TWO			= 2
	local PASSWORD_THREE		= 3
	local PASSWORD_FOUR			= 4
	
	g_bCheck = false
	
	
	
	-- ������ �α��� �ð�1
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_LastLoginTime_Text1")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,0,0,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(2, 40)
	mywindow:setVisible(true)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- ������ �α��� �ð�2
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_LastLoginTime_Text2")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,0,0,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(2, 60)
	mywindow:setVisible(true)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- ������ �α��� �ð�3
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_LastLoginTime_Text3")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0,0,0,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(2, 80)
	mywindow:setVisible(true)
	mywindow:setSize(5, 5)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
		
	-- ���������� �α��� �ѽð�
	function RenderLastLoginTime2(str1,str2,str3,str4,str5)
		winMgr:getWindow("SecondPassWord_LastLoginTime_Text1"):setText(str1)
		winMgr:getWindow("SecondPassWord_LastLoginTime_Text2"):setText(str2)
		winMgr:getWindow("SecondPassWord_LastLoginTime_Text3"):setText(str3)
	end
	
	function DrawOutlineText( drawer
							, text, posX, posY
							, outlineR,  outlineG, outlineB, outlineA
							, textR, textG, textB, textA, WideType)	
	
		drawer:setTextColor(outlineR, outlineG, outlineB, outlineA)
		
		drawer:drawText(text, posX - 2, posY - 1, WideType)
		drawer:drawText(text, posX - 2, posY - 0, WideType)
		drawer:drawText(text, posX - 2, posY + 1, WideType)
		drawer:drawText(text, posX - 1, posY - 2, WideType)
		drawer:drawText(text, posX - 1, posY - 1, WideType)
		drawer:drawText(text, posX - 1, posY + 0, WideType)
		drawer:drawText(text, posX - 1, posY + 1, WideType)
		drawer:drawText(text, posX - 1, posY + 2, WideType)
		drawer:drawText(text, posX + 0, posY - 2, WideType)
		drawer:drawText(text, posX + 0, posY - 1, WideType)
		drawer:drawText(text, posX + 0, posY + 1, WideType)
		drawer:drawText(text, posX + 0, posY + 2, WideType)
		drawer:drawText(text, posX + 1, posY - 2, WideType)
		drawer:drawText(text, posX + 1, posY - 1, WideType)
		drawer:drawText(text, posX + 1, posY + 0, WideType)
		drawer:drawText(text, posX + 1, posY + 1, WideType)
		drawer:drawText(text, posX + 1, posY + 2, WideType)
		drawer:drawText(text, posX + 2, posY - 1, WideType)
		drawer:drawText(text, posX + 2, posY - 0, WideType)
		drawer:drawText(text, posX + 2, posY + 1, WideType)
		
		drawer:setTextColor(textR, textG, textB, textA)
		drawer:drawText(text, posX, posY, WideType)
	end
	

	
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] ���� ������ �θ� ����
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_ROOT_AlphaWindow")
	mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6)
	mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2) - 165, (g_MAIN_WIN_SIZEY / 2) - 146)
	mywindow:setSize(331, 292)
	mywindow:setVisible(false)
	mywindow:setAlpha(150)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	RegistEscEventInfo("SecondPassWord_ROOT_AlphaWindow", "CloseSecondPassWordWIndow")
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] ���� ������
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_MainWindow")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setWideType(6)
	mywindow:setPosition(0, 0)
	mywindow:setSize(331, 292)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):addChildWindow(mywindow)
	




	
	------------------------------------------------------------------------------------------
	-- [2�� ��й�ȣ] ��й�ȣ [üũ] �̹��� 1st (2�� ��й�ȣ�� �Է��ϼ��� : ���� ���5ȸ ���н� ����)
	------------------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Input_1stImage")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 512, 0)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 512, 0)
	mywindow:setPosition(12 , 45) 
	mywindow:setSize(298, 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	------------------------------------------------------------------------------------------
	-- [2�� ��й�ȣ] ��й�ȣ [üũ] �̹��� 2nd  (��й�ȣ�� ���Է� ���ּ���)
	------------------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Input_2ndImage")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 512, 48)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 512, 48)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12 , 45) 
	mywindow:setSize(298, 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	
	
	------------------------------------------------------------------------------------------
	-- [2�� ��й�ȣ] ��й�ȣ [����] �̹��� 1st (������ ��й�ȣ�� �Է����ּ���)
	------------------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Modify_1stImage")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 512, 96)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 512, 96)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12 , 45) 
	mywindow:setSize(298, 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	------------------------------------------------------------------------------------------
	-- [2�� ��й�ȣ] ��й�ȣ [����] �̹��� 2nd  (������ ��й�ȣ�� �Է����ּ���)
	------------------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Modify_2ndImage")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 512, 144)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 512, 144)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12 , 45) 
	mywindow:setSize(298, 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)	
	------------------------------------------------------------------------------------------
	-- [2�� ��й�ȣ] ��й�ȣ [����] �̹��� 3th  (Ȯ���� ���� �ٽ� �Է����ּ���)
	------------------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Modify_3thImage")
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 512, 192)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 512, 192)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12 , 45) 
	mywindow:setSize(298, 48)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)	
	
	
	
	
	
	
	
	
	
	
	
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] ���� ������ "Ȯ��"��ư
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_MainWindow_OKButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 334, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 334, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 334, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 334, 64)
	mywindow:setSize(89, 32)
	mywindow:setEnabled(true)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setAlpha(10)
	mywindow:setPosition(76, 250)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "RequestSubmitPassWord")
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	------------------------------------------------------
	-- [2�� ��й�ȣ] ���� ������ "���"��ư
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_MainWindow_CancleButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 423, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 423, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 423, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 423, 64)
	mywindow:setSize(89, 30)
	mywindow:setEnabled(true)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setAlpha(10)
	mywindow:setPosition(166, 250)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CloseSecondPassWordWIndow")
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	
	
	------------------------------------------------------
	-- CloseOnlyInputMode()
	-- �Է� ��忡���� ����ϴ� ĵ�� �̺�Ʈ
	------------------------------------------------------
	function CloseOnlyInputMode()
		CallPopupExit(0) --  �ӽ� �ڵ� �缳���ؾ���
	end
	
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] ���� ������ üũ�ϱ� ����"���"��ư
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_MainWindow_OnlyCheckModeCancleButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 423, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 423, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 423, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 423, 64)
	mywindow:setSize(89, 30)
	mywindow:setEnabled(true)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setAlpha(10)
	mywindow:setPosition(166, 250)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CloseOnlyInputMode")
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	


	------------------------------------------------------
	-- RequestSubmitPassWord()
	-- OK��ư Ŭ���� �̺�Ʈ
	------------------------------------------------------
	function RequestSubmitPassWord()
		--DebugStr("���� ���Ľ� : " .. g_nStanceFlag)
		
		if g_nStanceFlag == STANCE_PASSWORD_CREATE_ONE then
			DebugStr("STANCE_PASSWORD_CREATE_ONE")
			
			-- �ȳ� ���� ����
			winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(false)
			winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(true)
			
			SaveUserPassWord()		-- �ӽù��ۿ� ��й�ȣ ����
			UserPassWordClear(1)	-- ��ư ����
			UserPassWordClear(2)	-- ����Ʈ â Ŭ����
			SetPassWordStanceFlag(STANCE_PASSWORD_CREATE_TWO) -- ���Ľ� ���� [�н����� ����� �ι�°]
			ChangeOkBtnEnable(false)-- OK��ư ��Ȱ��ȭ
			
		elseif g_nStanceFlag == STANCE_PASSWORD_CREATE_TWO then
			DebugStr("STANCE_PASSWORD_CREATE_TWO")
			
			-- �ȳ� ���� ����
			winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(true)
			winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(false)
			
			SendUserPassWord()		-- ������ �н����带 ��Ŷ���� ����
			ChangeOkBtnEnable(false)-- OK��ư ��Ȱ��ȭ
			
		elseif g_nStanceFlag == STANCE_PASSWORD_CHECK then
			DebugStr("STANCE_PASSWORD_CHECK")
			SendCheckUserPassWord()	-- ������ ���� ��й�ȣ�� ������ �����Ѵ�
			
		elseif g_nStanceFlag == STANCE_PASSWORD_MODIFY_ONE then
			DebugStr("STANCE_PASSWORD_MODIFY_ONE")
			SendExistUserPassWord()			-- ������ ��й�ȣ�� ������ ����
		
		elseif g_nStanceFlag == STANCE_PASSWORD_MODIFY_TWO then
			DebugStr("STANCE_PASSWORD_MODIFY_TWO")
			ModifySaveUserPassWord()		-- �ӽ÷� ���ο� ����� �����Ѵ�
			ModifySecondPassWordLastPass()	-- ������ Ȯ���� �Է�â�� ����
		
		elseif g_nStanceFlag == STANCE_PASSWORD_MODIFY_THREE then
			DebugStr("STANCE_PASSWORD_MODIFY_THREE")
			ModifySendUserPassWord()		-- �ӽ����� ����� ���ؼ� ��ġ�ϴ��� ã�´�
		
		elseif g_nStanceFlag == STANCE_PASSWORD_DESTROY then
			DebugStr("STANCE_PASSWORD_DESTROY")
			SendDestroyUserPassWord()		-- ������ ����
		end
	end
	
	
	
	function ChangeOkBtnEnable(flag)
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(flag)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
	end
	
	
	function SetNowCreatedPWFlag()
		g_bCheck = true
	end
	
	
	------------------------------------------------------
	-- CloseSecondPassWordWIndow()
	-- ���� �����쿡�� ��ҹ�ư Ŭ��
	------------------------------------------------------
	function CloseSecondPassWordWIndow()
		AllCloseSecondPassWord()	-- 2�� ��� ���� ��� �ݱ�
		SetCurrentSelectIndex(-1)	-- ����(����)������ �����ϵ��� �ε��� ����
		
		-- ��й�ȣ�� ���� ��Ȳ
		if g_bCheck == true then
			DebugStr("����� ��������� �������� �������� �ʴ´�")
			SetModeButtonEnable(true , false)
			return
		end
			
				
		if GetNowExistSecondPW() == EXIST_MODE_NOT_NEED then		-- 0
			DebugStr("���� �ʿ�������")
			SetModeButtonEnable(false , true)
		elseif GetNowExistSecondPW() == EXIST_MODE_HAVE_PW then		-- 1
			DebugStr("���� ����ɸ�����")
			SetModeButtonEnable(true , false)
		elseif GetNowExistSecondPW() == EXIST_MODE_NEED then		-- 2
			DebugStr("����� �ʿ��� ���")
			SetModeButtonEnable(false , true)
		end
	end
	
	
	
	------------------------------------------------------
	-- AllCloseSecondPassWord()
	-- ù��° ��й�ȣ ������ Ȯ�ι�ư Ŭ���� �Լ�
	------------------------------------------------------
	function AllCloseSecondPassWord()
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
	
	
		-- �ȳ� ���� ��� false	
		winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(false)
		
		winMgr:getWindow("SecondPassWord_Modify_1stImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_2ndImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_3thImage"):setVisible(false)
		
		-- 
		winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(true)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(true)
		
		winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):setVisible(false)
	end
	
	
	
	------------------------------------------------------
	-- Ű�е� ��ư (����)
	------------------------------------------------------
	local nButtonSize = 10
	local nCntX = 0
	local nCntY = 0
	
	for i=1, nButtonSize do
		mywindow = winMgr:createWindow("TaharezLook/Button",	"SecondPassWord_NumButton_" .. i)
		mywindow:setTexture("Normal",		"UIData/Login001.tga",	( 70 * (i-1) ), 362)
		mywindow:setTexture("Hover",		"UIData/Login001.tga",	( 70 * (i-1) ), 387)
		mywindow:setTexture("Pushed",		"UIData/Login001.tga",	( 70 * (i-1) ), 412)
		mywindow:setTexture("PushedOff",	"UIData/Login001.tga",	( 70 * (i-1) ), 362)	
		
		if i ~= 10 then
			-- 1 ~ 9 ����
			mywindow:setPosition( (70 * nCntX) + 63 , (25 * nCntY) + 103 )
		else
			-- 0 ��ư�� ���� ����
			mywindow:setPosition( (70 * 1) + 63 , (25 * nCntY) + 103 )
		end
		
		-- X Count ����
		if nCntX >= 2 then
			nCntX = 0
		else
			nCntX = nCntX + 1
		end
		
		-- Y Count ����
		if i % 3 == 0 then
			nCntY = nCntY + 1
		end	
		
	
		mywindow:setSize(70, 25)
		mywindow:setVisible(false)
		mywindow:setEnabled(true)
		mywindow:subscribeEvent("Clicked", "tSecondPassWordClickEvent")
		mywindow:setUserString("SecondButton", i)
		winMgr:getWindow('SecondPassWord_MainWindow'):addChildWindow(mywindow)
	end
	
	
	------------------------------------------------------
	-- tSecondPassWordClickEvent()
	-- ù��° ��й�ȣ ������ Ȯ�ι�ư Ŭ���� �Լ�
	------------------------------------------------------ rkatk
	function tSecondPassWordClickEvent(args)
		local EnterWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(EnterWindow:getUserString("SecondButton"))
		
		g_bPassWordFullSelected = SetUserPassWord(index)
		
		if g_bPassWordFullSelected then
			winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(true)
			winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 0)
			winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 32)
			winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 64)
			winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 64)
		end
	end
	
	
	
	------------------------------------------------------
	-- ����� ,  ���� ��ư
	------------------------------------------------------
	tModeButtonTexPosX = { ['err'] = 0,		700,	770 }
	for j=1, 2 do
		mywindow = winMgr:createWindow("TaharezLook/Button",	"SecondPassWord_ModeButton_" .. j)
		mywindow:setTexture("Normal",	"UIData/Login001.tga",	tModeButtonTexPosX[j] , 362)
		mywindow:setTexture("Hover",	"UIData/Login001.tga",	tModeButtonTexPosX[j] , 387)
		mywindow:setTexture("Pushed",	"UIData/Login001.tga",	tModeButtonTexPosX[j] , 412)
		mywindow:setTexture("PushedOff","UIData/Login001.tga",	tModeButtonTexPosX[j] , 362)	
		
		if j == 1 then			-- 1�� ��ư
			mywindow:setPosition( 60, 175 )
		elseif j == 2 then		-- 2�� ��ư
			mywindow:setPosition( 200 , 175 )
		end
		
		mywindow:setSize(70, 25)
		--mywindow:setAlwaysOnTop(true)
		mywindow:setVisible(false)
		mywindow:setEnabled(true)
	
		mywindow:subscribeEvent("Clicked", "tSecondPassWordClickModeEvent")
		mywindow:setUserString("SecondModeButton", j)
		winMgr:getWindow('SecondPassWord_MainWindow'):addChildWindow(mywindow)
	end
	
	------------------------------------------------------
	-- tSecondPassWordClickModeEvent()
	-- ����� , ���� �̺�Ʈ
	------------------------------------------------------
	function tSecondPassWordClickModeEvent(args)
		local EnterWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(EnterWindow:getUserString("SecondModeButton"))
		
		UserPassWordClear(index)
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
	end
	
	
	------------------------------------------------------
	-- MakeNumberTable()
	-- �迭�� �޾Ƽ� ���̺��� ������Ų��
	------------------------------------------------------
	g_tNumberBuff = {}
	
	function MakeNumberTable(index , number)
		-- index��	������	1
		--			����	10
		
		g_tNumberBuff[index] = number
	end
	
	------------------------------------------------------
	-- SetRandomNumberPosition()
	-- ��ư ������ �����ϰ� ����
	------------------------------------------------------
	function SetRandomNumberPosition()
		
		local nCntX = 0
		local nCntY = 0
		
		for i = 1 , 10 do
			if i ~= 10 then
				-- 1 ~ 9 ��ư ����
				winMgr:getWindow("SecondPassWord_NumButton_" .. g_tNumberBuff[i]):setPosition( (70 * nCntX) + 60 , (25 * nCntY) + 100 )
			else
				-- 0 ��ư�� ���� ����
				winMgr:getWindow("SecondPassWord_NumButton_" .. g_tNumberBuff[i]):setPosition( (70 * 1) + 60 , (25 * nCntY) + 100 )
			end
			
			-- X Count ����
			if nCntX >= 2 then
				nCntX = 0
			else
				nCntX = nCntX + 1
			end
			
			-- Y Count ����
			if i % 3 == 0 then
				nCntY = nCntY + 1
			end
			
		end	-- end of for
		
	end	-- end of function
	
	
	------------------------------------------------------
	-- SetPassWordStarVisible()
	-- ��ȣȭ *��� ��ư �����Լ�
	------------------------------------------------------
	function SetPassWordStarVisible(StarNumber)
		--DebugStr("-1���� ���� ������ �� �ѹ� : " .. StarNumber)
		
		if StarNumber == PASSWORD_NOT_SELECT then -- (-1)
			for i = 1 , 4 do
				--DebugStr("��Ÿ�ѹ� ��ξ���")
				winMgr:getWindow("SecondPassWord_SecretStar_" .. i):setVisible(false)
			end
		elseif StarNumber == PASSWORD_ONE then -- 1
			--DebugStr("��Ÿ�ѹ� 1")
			winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(false)
			winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(false)
			winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
		elseif StarNumber == PASSWORD_TWO then -- 2
			--DebugStr("��Ÿ�ѹ� 2")
			winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(false)
			winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
		elseif StarNumber == PASSWORD_THREE then -- 3
			--DebugStr("��Ÿ�ѹ� 3")
			winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
		elseif StarNumber == PASSWORD_FOUR then -- 4
			--DebugStr("��Ÿ�ѹ� 4")	
			winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(true)
			winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(true)
		end
		
	end
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] �� ��� �̹���
	------------------------------------------------------
	for i=1 , 4 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_SecretStar_" .. i)
		mywindow:setTexture("Enabled",	"UIData/Login001.tga", 334, 256)
		mywindow:setTexture("Disabled", "UIData/Login001.tga", 334, 256)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(95 + (22*i) , 209)
		mywindow:setSize(22, 22)
		mywindow:setUserString("StarNumber_" .. i , -1)
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
	end
	
	
	
	
	
	
	
	
	
	------------------------------------------------------
	-- �� ��й�ȣ �ֻ��� �Լ� ��
	------------------------------------------------------
	function SecondPassWordRootFunc()
		SecondPassWordRootFunction()
	end
	
	
	-- 2�� ��й�ȣ Ȱ��ȭ ���� �Լ�
	function SetModeButtonEnable(bFirst , bSecond)
		
		winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(bFirst)
		if bFirst then
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 0)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 37)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 74)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 74)
		elseif bFirst == false then
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 111)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 111)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 111)
			winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 111)
		end
		
		
		winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(bSecond)
		if bSecond then
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 148)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 185)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 222)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 222)
		elseif bSecond == false then
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 259)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 259)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 259)
			winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 259)
		end
		
	end
	
	
	------------------------------------------------------
	-- ��й�ȣ ����� 1
	------------------------------------------------------
	function CreateSecondPassWord()
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setVisible(false)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		-- ��ư / ����Ʈ â ����
		UserPassWordClear(1)	-- ���� ����
		UserPassWordClear(2)	-- ����Ʈ â �����
	
		-- �̹��� ����
		if g_nStanceFlag == STANCE_PASSWORD_CREATE_ONE then
			DebugStr("�̹��� ���� ũ������Ʈ 1st ����")
			winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(true)
			winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(false)
		end
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
	
	
		-- �ʿ��� ������ �ð�ȭ
		--[[
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		]]--
		
		
		--winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		root:addChildWindow(winMgr:getWindow("SecondPassWord_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		
		--root:addChildWindow(winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
		
		
	end	-- end of function
	
	
	------------------------------------------------------
	-- ��й�ȣ üũ�ϱ� 2
	------------------------------------------------------
	function CheckSecondPassWord()
		DebugStr("CheckSecondPassWord üũ")
		
		SetModeButtonEnable(false , false)
			
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(false)
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		root:addChildWindow(winMgr:getWindow("SecondPassWord_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		
		-- ��ư �����ϰ� ��ġ ����
		UserPassWordClear(1)
		-- ����Ʈ â ����
		UserPassWordClear(2)
		
		-- ��Ȳ�� �´� �ȳ����� �ֱ�
		winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(false)
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
	
		--
		--winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
	end



	----------------------------------------------------------------------
	-- ��й�ȣ ���� �˾� ���̹���
	-----------------------------------------------------------------------
	window = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Button_PopUp_Image")
	window:setTexture("Enabled",	"UIData/Login001.tga", 0, 462)
	window:setTexture("Disabled",	"UIData/Login001.tga", 0, 462)
	window:setWideType(6)
	--window:setPosition(300 , 50)
	window:setPosition((g_MAIN_WIN_SIZEX - 335)/2, (g_MAIN_WIN_SIZEY - 165)/2)
	window:setSize(335 , 165)
	window:setVisible(false)
	window:setAlwaysOnTop(false)
	window:setZOrderingEnabled(false)
	root:addChildWindow(window)
	--------------------------------------------------------------------
	-- ��й�ȣ�� �����Ͻðڽ��ϱ�? "����" ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Agree_Button")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 334, 128)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 334, 160)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 334, 192)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 334, 192)
	mywindow:setPosition(66 , 120)
	mywindow:setSize(89 , 32)
	window:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "NotifyOkButtonEvent")
	winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):addChildWindow(mywindow)
	--------------------------------------------------------------------
	-- ��й�ȣ�� �����Ͻðڽ��ϱ�? "���߿�" ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Later_Button")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 423, 128)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 423, 160)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 423, 192)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 423, 192)
	mywindow:setPosition(179 , 120)
	mywindow:setSize(89 , 32)
	window:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "NotifyCancelButtonEvent")
	winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- [��Ʈ��] ��й�ȣ ������ �����
	--------------------------------------------------------------------
	local g_STRING_PASSWORD_CREATE_NOTIFY = PreCreateString_3521	--GetSStringInfo(LAN_SECOND_PASSWORD_REFUSE_1) -- ��й�ȣ�� �����Ͻðڽ���? �� / ���߿�
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_NotifyCreate_Text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
	mywindow:setPosition(20, 60)
	mywindow:setVisible(true)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):addChildWindow(mywindow)
	
		
	------------------------------------------------
	-- NotifyOkButtonEvent()
	------------------------------------------------
	function NotifyOkButtonEvent()	
		DebugStr("NotifyOkButtonEvent ����")
		
		-- ���â ��ư ��� �����Ѵ�
		winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Agree_Button"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Later_Button"):setVisible(false)
		
		-- ����â�� �����ش�
		SetPassWordStanceFlag(STANCE_PASSWORD_CREATE_ONE)
		CreateSecondPassWord()
		
		SetSecondPasswordFlag(1)
		
		SetModeButtonEnable(false , false)
	end
	
	------------------------------------------------
	-- NotifyCancelButtonEvent()
	------------------------------------------------
	function NotifyCancelButtonEvent()
		DebugStr("NotifyCancelButtonEvent ����")
		
		-- ���߿� ������ ���� ��Ŷ�� �����Ѵ�
		SetLaterMakeUserPassWord()
		
		-- ä�� ���� ������ ���·� ����
		DebugStr("���⼭ ����2")
		SetCurrentSelectIndex(-1)
		
		-- �˾�â ����
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		
		winMgr:getWindow("SecondPassWord_NotifyCreate_Text"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Agree_Button"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Later_Button"):setVisible(false)
		
		SetSecondPasswordFlag(1)
		
		-- ������ư ����
		SetModeButtonEnable(false , true)
	end
	
	-- �н����带 �����ϰڴ��� ����� �˾�â ����
	function NotifyCreatePassWord()
		root:addChildWindow(winMgr:getWindow("SecondPassWord_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		
		root:addChildWindow(winMgr:getWindow("SecondPassWord_Button_PopUp_Image"))
		
		winMgr:getWindow("SecondPassWord_NotifyCreate_Text"):setText(g_STRING_PASSWORD_CREATE_NOTIFY)
		winMgr:getWindow("SecondPassWord_NotifyCreate_Text"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Button_PopUp_Image"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Agree_Button"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Later_Button"):setVisible(true)
	end
	

	----------------------------------------------------------------------
	-- ��й�ȣ ���� ��ư ���� (Ȳ�ݻ� ����)
	-----------------------------------------------------------------------
	window = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Button_Back_Image")
	window:setTexture("Enabled",	"UIData/Login001.tga", 335, 462)
	window:setTexture("Disabled",	"UIData/Login001.tga", 335, 462)
	window:setWideType(6)
	window:setPosition((g_MAIN_WIN_SIZEX - g_MAIN_WIN_SIZEX) + 32 , (g_MAIN_WIN_SIZEY - g_MAIN_WIN_SIZEY) + 605)
	window:setSize(248 , 86)
	window:setVisible(true)
	window:setAlwaysOnTop(false)
	window:setZOrderingEnabled(false)
	root:addChildWindow(window)

	--------------------------------------------------------------------
	-- ��й�ȣ [����] ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Modify_Button")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 912, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 912, 37)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 912, 74)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 912, 74)
	--mywindow:setWideType(2);
	mywindow:setPosition(10 , 45)
	mywindow:setSize(112 , 37)
	mywindow:setVisible(true)
	--mywindow:setEnabled(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "ModifySecondPassWord")
	winMgr:getWindow("SecondPassWord_Button_Back_Image"):addChildWindow(mywindow)
	--------------------------------------------------------------------
	-- ��й�ȣ [����] ��ư ( ���� & ���� )
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Setting_Button")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 912, 148)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 912, 185)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 912, 222)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 912, 222)
	--mywindow:setWideType(2);
	mywindow:setPosition(125 , 45)
	mywindow:setSize(112 , 37)
	mywindow:setVisible(true)
	--mywindow:setEnabled(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "SettingPassWordEvent")
	winMgr:getWindow("SecondPassWord_Button_Back_Image"):addChildWindow(mywindow)
	
	
	------------------------------------------------------
	-- ��й�ȣ [����]�ϱ� 3
	------------------------------------------------------
	function ModifySecondPassWord()
		if	GetNowExistSecondPW() == EXIST_MODE_NEED and GetNowExistSecondPW() == EXIST_MODE_NOT_NEED then
			return
		end
	
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setVisible(false)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		DebugStr("��й�ȣ [����] �̺�Ʈ ����")
		
		-- ä�� ������ �����Ѵ�
		DebugStr("���⼭ ����3")
		SetCurrentSelectIndex(1)
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		UserPassWordClear(1)	-- ��ư ����
		UserPassWordClear(2)	-- ����Ʈ â Ŭ����
		SetPassWordStanceFlag(STANCE_PASSWORD_MODIFY_ONE)	-- ���Ľ� ���� [�н����� �����ϱ� 1]
		
		-- ��Ȳ�� �´� �ȳ����� �ֱ�
		winMgr:getWindow("SecondPassWord_Modify_1stImage"):setVisible(true)
		
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
		
		--[[
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		]]--
		
		root:addChildWindow(winMgr:getWindow("SecondPassWord_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		--winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
		
		SetModeButtonEnable(false , false)
	
	end
	
	------------------------------------------------------
	-- ��й�ȣ [����]�ϱ� 3 - 1
	------------------------------------------------------
	function ModifySecondPassWordTwoPass()
				
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setVisible(false)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		winMgr:getWindow('SecondPassWord_ROOT_AlphaWindow'):clearControllerEvent("BottonMenuUpEvent")
		winMgr:getWindow('SecondPassWord_ROOT_AlphaWindow'):clearActiveController()
		winMgr:getWindow('SecondPassWord_ROOT_AlphaWindow'):addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 800 , 223, 3, true, false, 10)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):activeMotion("BottonMenuUpEvent")
		
		
		DebugStr("��й�ȣ [����]�ϱ� 3 - 1 ����")
		
		-- ä�� ������ �����Ѵ�
		DebugStr("���⼭ ����4")
		SetCurrentSelectIndex(1)
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		UserPassWordClear(1)	-- ��ư ����
		UserPassWordClear(2)	-- ����Ʈ â Ŭ����
		SetPassWordStanceFlag(STANCE_PASSWORD_MODIFY_TWO)	-- ���Ľ� ���� [�н����� �����ϱ� 1]
		SetPassWordStanceFlag(STANCE_PASSWORD_MODIFY_TWO)	-- ���Ľ� ���� [�н����� �����ϱ� 1]
		
		
		-- ��Ȳ�� �´� �ȳ����� �ֱ�
		winMgr:getWindow("SecondPassWord_Modify_1stImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_2ndImage"):setVisible(true)
		
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
		
		--[[
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		]]--
		
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
		
		SetModeButtonEnable(false , false)
	end
	
	------------------------------------------------------
	-- ��й�ȣ [����]�ϱ� 3 - 2
	------------------------------------------------------
	function ModifySecondPassWordLastPass()
				
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setVisible(false)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		DebugStr("��й�ȣ [����]�ϱ� 3 - 2 ����")
		
		-- ä�� ������ �����Ѵ�
		DebugStr("���⼭ ����5")
		SetCurrentSelectIndex(1)
		
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		UserPassWordClear(1)	-- ��ư ����
		UserPassWordClear(2)	-- ����Ʈ â Ŭ����
		SetPassWordStanceFlag(STANCE_PASSWORD_MODIFY_THREE)	-- ���Ľ� ���� [�н����� �����ϱ� 1]
		
		-- ��Ȳ�� �´� �ȳ����� �ֱ�
		winMgr:getWindow("SecondPassWord_Modify_1stImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_2ndImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_3thImage"):setVisible(true)
		
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
		
		--[[
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"))
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		]]--
		
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
		
		SetModeButtonEnable(false , false)
	end
	
	
	------------------------------------------------------
	-- ��й�ȣ [����]�ϱ� 4	 rkawk
	------------------------------------------------------
	function SettingPassWordEvent()
		if	GetNowExistSecondPW() == EXIST_MODE_HAVE_PW then
			return
		end
		
		DebugStr("��й�ȣ [����] �̺�Ʈ ����")
		
		-- ���� Exist��� �޾ƿ���
		local nMode = GetNowExistSecondPW();

		-- �� ���� �����ϱ� ����� ���� �ʴ´�.
		if nMode == 2 or nMode == 0 then	-- [��й�ȣ �����].
			SetModeCreatePassword()
		elseif nMode == 1 then				-- [��й�ȣ �����ϱ�].
			SetModeCreatePassword()
			--SetModeDeletePassword()
		end
	end
	
	-- ��й�ȣ ���� ---> �����
	function SetModeCreatePassword()
		DebugStr("��й�ȣ [����] �̺�Ʈ ���� -> ��й�ȣ �����")
		SetCurrentSelectIndex(1)	-- ä�� ���� ����
		SetPassWordStanceFlag(STANCE_PASSWORD_CREATE_ONE)
		CreateSecondPassWord()		-- ��й�ȣ ����� â ����
		
		SetSecondPasswordFlag(1)
		SetCurrentSelectIndex(1)	-- ä�� ���� ����
		SetModeButtonEnable(false , false)
	end
	
	-- ��й�ȣ ���� ---> �����ϱ�
	function SetModeDeletePassword()
		DebugStr("��й�ȣ [����] �̺�Ʈ ���� -> ��й�ȣ ����")
		
		-- ���� ������ �ҷ�����
		SetCurrentSelectIndex(1)	-- ä�� ���� ����
		
		ShowDestroyQuestion()		-- ������ �����Ͻðڽ��ϱ�? �˾� ���
	end
	
						
	----------------------------------------------------------------------
	-- ��й�ȣ ��������
	-----------------------------------------------------------------------
	window = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Destroy_Back_Image")
	window:setTexture("Enabled",	"UIData/Login001.tga", 0, 462)
	window:setTexture("Disabled",	"UIData/Login001.tga", 0, 462)
	window:setWideType(6)
	window:setPosition((g_MAIN_WIN_SIZEX/2) - (335/2) , (g_MAIN_WIN_SIZEY/2) - (165/2))
	window:setSize(335 , 165)
	window:setVisible(false)
	window:setAlwaysOnTop(false)
	window:setZOrderingEnabled(false)
	root:addChildWindow(window)
	--------------------------------------------------------------------
	-- [��Ʈ��] ������ �����Ͻðڽ��ϱ�?
	--------------------------------------------------------------------
	local g_STRING_PASSWORD_DESTROY_QUESTION = PreCreateString_3529	--GetSStringInfo(LAN_SECOND_PASSWORD_DELETE_QUESTION)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_DestroyQuestion_Text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
	mywindow:setPosition(60, 50)
	mywindow:setVisible(false)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- ��й�ȣ [����] Ȯ�ι�ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Destroy_OKButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 334, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 334, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 334, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 334, 64)
	mywindow:setPosition(70 , 120)
	mywindow:setSize(89 , 32)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "DestroySecondPassWordOkEvent")
	winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):addChildWindow(mywindow)
	--------------------------------------------------------------------
	-- ��й�ȣ [����] ��ҹ�ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_Destroy_CancelButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 423, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 423, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 423, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 423, 64)
	mywindow:setPosition(177 , 120)
	mywindow:setSize(89 , 32)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "CloseSecondPassWordWIndow")
	winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):addChildWindow(mywindow)
	------------------------------------------------------
	-- ���� Ȯ�ι�ư �̺�Ʈ
	------------------------------------------------------
	function DestroySecondPassWordOkEvent()
		CloseSecondPassWordWIndow()						-- ���λ���
		SetPassWordStanceFlag(STANCE_PASSWORD_DESTROY)	-- ���Ľ� ����
		DestroySecondPassWordWindow()					-- ����â�� ����
		
		SetModeButtonEnable(false , false)				-- ��ư Ŭ�� ����
	end
	
	------------------------------------------------------
	-- �����ϱ� �˾� ����
	------------------------------------------------------
	function ShowDestroyQuestion()
		-- �˾� ����
		winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Destroy_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Destroy_CancelButton"):setVisible(true)
		
		winMgr:getWindow("SecondPassWord_DestroyQuestion_Text"):setText(g_STRING_PASSWORD_DESTROY_QUESTION)
		winMgr:getWindow("SecondPassWord_DestroyQuestion_Text"):setVisible(true)
	end
	
	------------------------------------------------------
	-- �����ϱ� ������ ����
	------------------------------------------------------
	function DestroySecondPassWordWindow()
		winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(false)
		
		-- �����ϱ⿡ �´� Ȯ��/��ҹ�ư ���̱�
		winMgr:getWindow("SecondPassWord_Destroy_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_Destroy_CancelButton"):setVisible(true)
		
		-- �����Ҷ� �ѹ� ������ �����ش�
		AllCloseSecondPassWord()
		
		-- ä�μ����� ���´�
		SetCurrentSelectIndex(1)
		
		-- ��ư �����ϰ� ��ġ ����
		UserPassWordClear(1)
		-- ����Ʈ â ����
		UserPassWordClear(2)
		
		-- ��Ȳ�� �´� �ȳ����� �ֱ�
		winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Input_2ndImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_2ndImage"):setVisible(false)
		winMgr:getWindow("SecondPassWord_Modify_3thImage"):setVisible(false)
		
		winMgr:getWindow("SecondPassWord_Modify_1stImage"):setVisible(true)	-- ������ ��й�ȣ�� �Է����ּ���.
		
		
		
		
		-- Ȯ�ι�ư ��Ȱ��ȭ
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 96)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 96)
	
		--
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setVisible(true)
		
		for i = 1 , 10 do
			winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
		end
		
		for j = 1 , 2 do
			winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
		end
	end
					
					
					
					
	
	
	------------------------------------------------------
	-- [2�� ��й�ȣ] ȭ�� ��ü������ ���� ���� ������
	------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_AlphaWindow")
	mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0 , 0) 
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	
	----------------------------------------------------------------------
	-- ��й�ȣ ���� Ŭ���̾�Ʈ �������� ����
	-----------------------------------------------------------------------
	window = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_FiveTimeExit_Image")
	window:setTexture("Enabled",	"UIData/Login001.tga", 0, 462)
	window:setTexture("Disabled",	"UIData/Login001.tga", 0, 462)
	window:setProperty("FrameEnabled", "False")
	window:setProperty("BackgroundEnabled", "False")
	window:setWideType(6)
	window:setPosition((g_MAIN_WIN_SIZEX - 335)/2, (g_MAIN_WIN_SIZEY - 165)/2)
	window:setSize(335 , 165)
	window:setVisible(false)
	window:setAlwaysOnTop(false)
	window:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_AlphaWindow"):addChildWindow(window)
	--------------------------------------------------------------------
	-- ��й�ȣ [����] ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "SecondPassWord_FiveTimeExit_OKButton")
	mywindow:setTexture("Normal",	"UIData/Login001.tga", 334, 0)
	mywindow:setTexture("Hover",	"UIData/Login001.tga", 334, 32)
	mywindow:setTexture("Pushed",	"UIData/Login001.tga", 334, 64)
	mywindow:setTexture("PushedOff","UIData/Login001.tga", 334, 64)
	--mywindow:setWideType(2);
	mywindow:setPosition(122 , 120)
	mywindow:setSize(89 , 32)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("Clicked", "FiveTimeExit_Client")
	winMgr:getWindow("SecondPassWord_FiveTimeExit_Image"):addChildWindow(mywindow)
	
	

	--------------------------------------------------------------------
	-- [��Ʈ��] ��й�ȣ 5ȸ �̻� Ʋ��
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SecondPassWord_FiveTimeError_Text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
	mywindow:setPosition(55, 50)
	mywindow:setVisible(true)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_FiveTimeExit_Image"):addChildWindow(mywindow)
	
	-- 5ȸ ��� Ʋ����, �������� �Լ�
	function PassWordErrorClientExit(TimelimitTest)
		winMgr:getWindow("SecondPassWord_FiveTimeError_Text"):setText(TimelimitTest)
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
		
		winMgr:getWindow("SecondPassWord_MainWindow_OKButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_CancleButton"):setEnabled(false)
		winMgr:getWindow("SecondPassWord_MainWindow_OnlyCheckModeCancleButton"):setEnabled(false)
	end
	
	function FiveTimeExit_Client()
		winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
		BtnPageMove_MoveBackWindow(0)
	end
	

	function ShowSecondPassWord(flag)
		winMgr:getWindow("SecondPassWord_Button_Back_Image"):setVisible(flag)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setVisible(flag)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setVisible(flag)
		
		if flag == true then
			SecondPassWordRootFunc();
		end
	end
	
	end	-- Quitindex end
--end	-- end of not Kor? ( 2�� ��й�ȣ ���� �� )





------------------------------------------------------------

-- ��� �̹���

------------------------------------------------------------
function WndSelectChannel_RenderBackImage()
	--drawer:drawTextureBackImage("UIData/BackGround002.tga", 0, 0, 1024, 768, 0, 0)
	drawer:drawTexture("UIData/channel_002.tga", 0, 0, 1024, 69, 0, 936, WIDETYPE_5)	-- ���� ��
	drawer:drawTexture("UIData/channel_002.tga", 355, 0, 314, 45, 493, 891, WIDETYPE_5)	-- Select Channel
	
	-- �ѱ��� �ƴҰ�츸 ��������Ʈ ���̰� �Ѵ�.
	if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
		drawer:drawTexture("UIData/channel_002.tga", 30, 90, 254, 604, 0, 0, WIDETYPE_6)	-- ���� ����Ʈ
	end
end



-- ���� ����Ʈ(�ѱ��� �ƴҰ�츸 ��������Ʈ ���̰� �Ѵ�.)
if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
	tServerList_posY = {["err"]=0, [0]=160, 202, 244, 286, 328}
	tServerName = {["err"]=0, [0]=" Server 1", "Preparing", "Preparing", "Preparing", "Preparing"}
	for i=0, #tServerList_posY do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_SelectChannel_ServerListBtn_"..i)
		mywindow:setTexture("Normal", "UIData/channel_002.tga", 0, 604)
		mywindow:setTexture("Hover", "UIData/channel_002.tga", 0, 646)
		mywindow:setTexture("Pushed", "UIData/channel_002.tga", 0, 688)
		mywindow:setTexture("PushedOff", "UIData/channel_002.tga", 0, 604)
		mywindow:setTexture("SelectedNormal", "UIData/channel_002.tga", 0, 688)
		mywindow:setTexture("SelectedHover", "UIData/channel_002.tga", 0, 688)
		mywindow:setTexture("SelectedPushed", "UIData/channel_002.tga", 0, 688)
		mywindow:setTexture("SelectedPushedOff", "UIData/channel_002.tga", 0, 688)
		mywindow:setTexture("Enabled", "UIData/channel_002.tga", 0, 604)
		mywindow:setTexture("Disabled", "UIData/channel_002.tga", 0, 730)
		mywindow:setProperty("GroupID", 1995)	
		mywindow:setWideType(6);
		mywindow:setPosition(40, tServerList_posY[i])
		mywindow:setSize(237, 42)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "ClickedServerList")
		root:addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_SelectChannel_ServerName_"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(0, 13)
		mywindow:setViewTextMode(1)
		mywindow:setAlign(8)
		mywindow:setLineSpacing(1)
		mywindow:setSize(237, 42)
		mywindow:setEnabled(false)
		mywindow:clearTextExtends()
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_SelectChannel_ServerListBtn_"..i):addChildWindow(mywindow)
		
		if i == 0 then
			winMgr:getWindow("sj_SelectChannel_ServerListBtn_"..i):setEnabled(true)
			winMgr:getWindow("sj_SelectChannel_ServerListBtn_"..i):setProperty("Selected", "true")
			winMgr:getWindow("sj_SelectChannel_ServerName_"..i):setTextExtends(tServerName[i], g_STRING_FONT_GULIMCHE, 12, 255,255,255,255,  0, 255,255,255,255)
		else
			winMgr:getWindow("sj_SelectChannel_ServerListBtn_"..i):setEnabled(false)
			winMgr:getWindow("sj_SelectChannel_ServerListBtn_"..i):setProperty("Selected", "false")
			winMgr:getWindow("sj_SelectChannel_ServerName_"..i):setTextExtends(tServerName[i], g_STRING_FONT_GULIMCHE, 12, 100,100,100,255,  0, 255,255,255,255)
		end
	end
end

function ClickedServerList(args)
end





------------------------------------------------------------

-- ���� ä�� ����Ʈ

------------------------------------------------------------
-- ���� ä�� ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectChannel_ChannelList_AlphaWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setScaleWidth(500)
mywindow:setScaleHeight(500)
mywindow:setVisible(false)
--mywindow:setAlpha(150)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

channelListbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectChannel_ChannelList_backImage")
channelListbackwindow:setTexture("Enabled", "UIData/channel_003.tga", 0, 0)
channelListbackwindow:setTexture("Disabled", "UIData/channel_003.tga", 0, 0)
channelListbackwindow:setProperty("FrameEnabled", "False")
channelListbackwindow:setProperty("BackgroundEnabled", "False")
channelListbackwindow:setWideType(6)

if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
	channelListbackwindow:setPosition(310, 1200)
	channelListbackwindow:addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 1200 , 223, 3, true, false, 10)
	channelListbackwindow:addController("channelController", "BottonMenuDownEvent", "y", "Sine_EaseInOut", 223, 1200, 3, true, false, 10)
else
	channelListbackwindow:setPosition(270, 1200)
	channelListbackwindow:addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 1200 , 260, 3, true, false, 10)
	channelListbackwindow:addController("channelController", "BottonMenuDownEvent", "y", "Sine_EaseInOut", 260, 1200, 3, true, false, 10)
end

channelListbackwindow:setSize(484, 323)
channelListbackwindow:setVisible(false)
channelListbackwindow:setZOrderingEnabled(false)
channelListbackwindow:subscribeEvent("EndRender", "RenderChannelBackImage")
root:addChildWindow(channelListbackwindow)

function RenderChannelBackImage(args)
	-- ���� ä�� ������
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	local maxVillagePage, maxBattlePage = WndSelectChannel_GetMaxChannelPage()
	local villagePageText = curVillagePage.."  /  "..maxVillagePage
	
	local window = CEGUI.toWindowEventArgs(args).window	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	local position = window:getPosition()
	local posX = position.x.offset + parentPos.x.offset + 222
	local posY = position.y.offset + parentPos.y.offset + 254
	drawer:drawText(villagePageText, posX, posY)
end

if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
	RegistEscEventInfo("sj_SelectChannel_ChannelList_AlphaWindow", "HideChannelList")
end

function HideChannelList()

	if CheckfacilityData(FACILITYCODE_ZONE3) == 0 then
		return
	end
	
	DebugStr("�Ϸ���� �ȵǴµ�@@@@@@")
	winMgr:getWindow("sj_SelectChannel_ChannelList_AlphaWindow"):setVisible(false)
	--winMgr:getWindow("sj_SelectChannel_ChannelList_backImage"):setVisible(false)
	winMgr:getWindow("sj_SelectChannel_ChannelList_backImage"):activeMotion("BottonMenuDownEvent")
	
	for i=0, MAX_VILLAGE_CHANNEL-1 do
		winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setProperty("Selected", "false")
	end
	
	CanceledChannelList()
end

function ShowChannelList(zoneIndex)
	-- ����ä���� ���
	--if zoneIndex == 5 then
	--	winMgr:getWindow("sj_SelectChannel_BattleChannelList_AlphaWindow"):setVisible(true)
	--	winMgr:getWindow("sj_SelectChannel_BattleChannelList_backImage"):setVisible(true)
	--	winMgr:getWindow('sj_SelectChannel_BattleChannelList_backImage'):clearControllerEvent("BottonMenuUpEvent")
	--	winMgr:getWindow('sj_SelectChannel_BattleChannelList_backImage'):clearActiveController()
	--	winMgr:getWindow('sj_SelectChannel_BattleChannelList_backImage'):addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 800 , 223, 3, true, false, 10)
	--	winMgr:getWindow("sj_SelectChannel_BattleChannelList_backImage"):activeMotion("BottonMenuUpEvent")
	--else
		
		--winMgr:getWindow("sj_SelectChannel_ChannelList_AlphaWindow"):setVisible(true)
		--root:addChildWindow(winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"))
		winMgr:getWindow("sj_SelectChannel_ChannelList_backImage"):setVisible(true)
		winMgr:getWindow('sj_SelectChannel_ChannelList_backImage'):clearControllerEvent("BottonMenuUpEvent")
		winMgr:getWindow('sj_SelectChannel_ChannelList_backImage'):clearActiveController()
		
		if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
			winMgr:getWindow('sj_SelectChannel_ChannelList_backImage'):addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 800 , 223, 3, true, false, 10)
		else
			winMgr:getWindow('sj_SelectChannel_ChannelList_backImage'):addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 800 , 260, 3, true, false, 10)
		end
		
		winMgr:getWindow("sj_SelectChannel_ChannelList_backImage"):activeMotion("BottonMenuUpEvent")
		
		for i=0, MAX_VILLAGE_CHANNEL-1 do
			if winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):isVisible() then
				winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setProperty("Selected", "true")
				return
			end
		end
	--end
end

local tChannelPosX = {["err"]=0, [0]=8, 8, 8, 8, 8, 242, 242, 242, 242, 242}
local tChannelPosY = {["err"]=0, [0]=42, 82, 122, 162, 202, 42, 82, 122, 162, 202}
for i=0, MAX_VILLAGE_CHANNEL-1 do
		
	-- ���� ä�� ���� ��ư
	channelwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_SelectChannel_channelRadioButton")
	channelwindow:setTexture("Normal", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("Hover", "UIData/channel_002.tga", 0, 813)
	channelwindow:setTexture("Pushed", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("PushedOff", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("SelectedNormal", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedHover", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedPushed", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedPushedOff", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("Enabled", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("Disabled", "UIData/channel_002.tga", 0, 895)
	channelwindow:setPosition(tChannelPosX[i], tChannelPosY[i])
	channelwindow:setSize(235, 41)
	channelwindow:setProperty("GroupID", 2102)
	channelwindow:setUserString("channelNumber", tostring(i))
	channelwindow:subscribeEvent("MouseDoubleClicked", "OnDoubleClickEnterVillage")
	channelwindow:subscribeEvent("EndRender", "RenderChannelInfos")
	channelListbackwindow:addChildWindow(channelwindow)
	
	-- 1. ���� ä�� �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_SelectChannel_channelNameText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(90, 8)
	mywindow:setSize(40, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	channelwindow:addChildWindow(mywindow)

	-- 2. ���� ä�� ȥ�� ��׷���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_SelectChannel_confusionIconTemp")
	mywindow:setTexture("Enabled", "UIData/channel_002.tga", 531, 700)
	mywindow:setTexture("Disabled", "UIData/channel_002.tga", 531, 700)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(47, 25)
	mywindow:setSize(134, 10)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	channelwindow:addChildWindow(mywindow)

	-- 3. ���� ä�� ȥ�� �׷���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_SelectChannel_confusionIcon")
	mywindow:setTexture("Enabled", "UIData/channel_002.tga", 531, 710)
	mywindow:setTexture("Disabled", "UIData/channel_002.tga", 531, 710)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(47, 25)
	mywindow:setSize(134, 10)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)	
	channelwindow:addChildWindow(mywindow)
end

function OnDoubleClickEnterVillage(args)
	local channelNumber = CEGUI.toWindowEventArgs(args).window:getUserString("channelNumber")
	WndSelectChannel_EnterVillage(tonumber(channelNumber))
end


function RenderChannelInfos(args)
	if MAX_VILLAGE_CHANNEL < 1 then
		return
	end
	
	local window = CEGUI.toWindowEventArgs(args).window
	local channelNumber = window:getUserString("channelNumber")
	local zoneIndex, squareIndex = GetChannelInfos(channelNumber)
	local showIndex = squareIndex / (MAX_VILLAGE_CHANNEL-1)
	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	local position = window:getPosition()
	local posX = position.x.offset + parentPos.x.offset
	local posY = position.y.offset + parentPos.y.offset
	--[[
	if zoneIndex >= 0 then
		if zoneIndex == 3 then
			if CheckfacilityData(FACILITYCODE_ZONE3) == 0 then
				drawer:drawTexture("UIData/channel_002.tga", posX+18, posY-4, 235, 41, 703, 645)
				local _left = DrawEachNumber("UIData/channel_002.tga", zoneIndex, 1, posX+52, posY+7, 703, 705, 14, 19, 14)
			else
				drawer:drawTexture("UIData/channel_002.tga", posX, posY-4, 235, 41, 703, 645)
				local _left = DrawEachNumber("UIData/channel_002.tga", zoneIndex, 1, posX+87, posY+7, 703, 705, 14, 19, 14)
			end
		elseif zoneIndex == 6 then
			if CheckfacilityData(FACILITYCODE_ZONE3) == 0 then
				drawer:drawTexture("UIData/channel_002.tga", posX+18, posY-4, 235, 41, 703, 604)
				local _left = DrawEachNumber("UIData/channel_002.tga", zoneIndex, 1, posX+52, posY+7, 703, 686, 14, 19, 14)
			else
				drawer:drawTexture("UIData/channel_002.tga", posX, posY-4, 235, 41, 703, 604)
				local _left = DrawEachNumber("UIData/channel_002.tga", zoneIndex, 1, posX+87, posY+7, 703, 686, 14, 19, 14)
			end
		end
	end	]]--
end

-- ���� ä�� ������ �ʱ�ȭ
function WndSelectChannel_ClearVillageChannelPage()
	DebugStr("ä�� ������ �ʱ�ȭ")
	for i=0, MAX_VILLAGE_CHANNEL-1 do
		winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setVisible(false)
	end
end


-- ���� ä���� ������ ��� ������Ʈ
function WndSelectChannel_VillageExistChannel(i, userPercent, name, zoneNumber)
	DebugStr("���� ä���� ������ ��� ������Ʈ")
	winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setVisible(true)
	
	if zoneNumber == 3 then
		winMgr:getWindow(i.."sj_SelectChannel_channelNameText"):setTextExtends(name, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,   1, 180,163,0,255)
	elseif zoneNumber == 6 then
		winMgr:getWindow(i.."sj_SelectChannel_channelNameText"):setTextExtends(name, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,   1, 45,170,200,255)
	end

	-- 3. ���� ä�� ȥ�� �׷���
	local tex_y = 700
	if		0 < userPercent and userPercent <= 3 then	tex_y = 710	-- �ʷ� �׷���
	elseif	3 < userPercent and userPercent <= 7 then	tex_y = 720	-- ��� �׷���
	else												tex_y = 730	-- ���� �׷���
	end
	
	local ONE_PIXEL_TEXSIZE	= 13	-- 1���� ���� �̹��� ũ��
	winMgr:getWindow(i.."sj_SelectChannel_confusionIcon"):setTexture("Enabled", "UIData/channel_002.tga", 531, tex_y)
	winMgr:getWindow(i.."sj_SelectChannel_confusionIcon"):setTexture("Disabled", "UIData/channel_002.tga", 531, tex_y)
	winMgr:getWindow(i.."sj_SelectChannel_confusionIcon"):setSize(userPercent*ONE_PIXEL_TEXSIZE, 10)
end



------------------------------------------------------------
-- ���� ä�� ������ ��, �� ��ư
------------------------------------------------------------
tZonePageButtonName  = { ["err"]=0, "sj_SelectChannel_ZoneLeftButton", "sj_SelectChannel_ZoneRightButton" }
tZonePageButtonTexX  = { ["err"]=0, 493, 512 }
tZonePageButtonPosX  = { ["err"]=0, 184, 282 }
tZonePageButtonEvent = { ["err"]=0, "ZonePageLeftClicked", "ZonePageRightClicked" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tZonePageButtonName[i])
	mywindow:setTexture("Normal", "UIData/channel_002.tga", tZonePageButtonTexX[i], 700)
	mywindow:setTexture("Hover", "UIData/channel_002.tga", tZonePageButtonTexX[i], 725)
	mywindow:setTexture("Pushed", "UIData/channel_002.tga", tZonePageButtonTexX[i], 750)
	mywindow:setTexture("PushedOff", "UIData/channel_002.tga", tZonePageButtonTexX[i], 700)
	mywindow:setPosition(tZonePageButtonPosX[i], 248)
	mywindow:setSize(19, 25)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tZonePageButtonEvent[i])
	channelListbackwindow:addChildWindow(mywindow)
end

function ZonePageLeftClicked(args)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	if curVillagePage > 1 then
		curVillagePage = curVillagePage - 1
		WndSelectChannel_ChangeVillageChannelPage(tonumber(curVillagePage))
		
		for i=0, MAX_VILLAGE_CHANNEL-1 do
			winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setProperty("Selected", "false")
		end
	end	
end

function ZonePageRightClicked(args)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	local maxVillagePage, maxBattlePage = WndSelectChannel_GetMaxChannelPage()
	if curVillagePage < maxVillagePage then
		curVillagePage = curVillagePage + 1
		WndSelectChannel_ChangeVillageChannelPage(tonumber(curVillagePage))
		
		for i=0, MAX_VILLAGE_CHANNEL-1 do
			winMgr:getWindow(i.."sj_SelectChannel_channelRadioButton"):setProperty("Selected", "false")
		end
	end
end


------------------------------------------------------------
-- ���� �����ϱ�(Ȯ�� ��ư)
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectChannel_EnterButton")
mywindow:setTexture("Normal",	"UIData/channel_002.tga", 493, 604)
mywindow:setTexture("Hover",	"UIData/channel_002.tga", 493, 636)
mywindow:setTexture("Pushed",	"UIData/channel_002.tga", 493, 668)
mywindow:setTexture("PushedOff","UIData/channel_002.tga", 493, 604)
mywindow:setTexture("Enabled",	"UIData/channel_002.tga", 493, 604)
mywindow:setTexture("Disabled", "UIData/channel_002.tga", 807, 904)

if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
	mywindow:setPosition(134, 282)
else
	mywindow:setPosition(190, 282)
end

mywindow:setSize(105, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedEnterSquare")
channelListbackwindow:addChildWindow(mywindow)

-- ���� ä���� �������� ENABLE = false
function SetEnterButtonToVillage(bEnable)
	winMgr:getWindow("sj_SelectChannel_EnterButton"):setEnabled(bEnable)
end

function ClickedEnterSquare(args)
	for i=0, MAX_VILLAGE_CHANNEL-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_SelectChannel_channelRadioButton")):isSelected() then
			local channelNumber = winMgr:getWindow(i .. "sj_SelectChannel_channelRadioButton"):getUserString("channelNumber")
			WndSelectChannel_EnterVillage(tonumber(channelNumber))
			
			for j=0, MAX_VILLAGE_CHANNEL-1 do
				winMgr:getWindow(j.."sj_SelectChannel_channelRadioButton"):setProperty("Selected", "false")
			end
			return
		end
	end	
	
	-- ���õȰ� ���� ��� ����ȣ��
	WndSelectChannel_Error(LAN_CPP_SELECT_CHANNEL_3)
end


------------------------------------------------------------
-- ���� ���� ��ҹ�ư
------------------------------------------------------------
if CheckfacilityData(FACILITYCODE_ZONE3) == 1 then
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectChannel_CloseButton")
	mywindow:setTexture("Normal", "UIData/channel_002.tga", 598, 604)
	mywindow:setTexture("Hover", "UIData/channel_002.tga", 598, 636)
	mywindow:setTexture("Pushed", "UIData/channel_002.tga", 598, 668)
	mywindow:setTexture("PushedOff", "UIData/channel_002.tga", 598, 604)
	mywindow:setPosition(244, 282)
	mywindow:setSize(105, 32)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ClickedCancelSquare")
	channelListbackwindow:addChildWindow(mywindow)

	function ClickedCancelSquare(args)
		HideChannelList()
	end
end




------------------------------------------------------------

-- ���� ä�� ����Ʈ

------------------------------------------------------------
-- ���� ä�� ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectChannel_BattleChannelList_AlphaWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlpha(150)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

battlechannelListbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectChannel_BattleChannelList_backImage")
battlechannelListbackwindow:setTexture("Enabled", "UIData/channel_002.tga", 237, 604)
battlechannelListbackwindow:setTexture("Disabled", "UIData/channel_002.tga", 237, 604)
battlechannelListbackwindow:setProperty("FrameEnabled", "False")
battlechannelListbackwindow:setProperty("BackgroundEnabled", "False")
battlechannelListbackwindow:setPosition(530, 800)
battlechannelListbackwindow:setSize(256, 322)
battlechannelListbackwindow:setVisible(false)
battlechannelListbackwindow:setZOrderingEnabled(false)
battlechannelListbackwindow:subscribeEvent("EndRender", "RenderBattleChannelBackImage")
battlechannelListbackwindow:addController("channelController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 800 , 223, 3, true, false, 10)
battlechannelListbackwindow:addController("channelController", "BottonMenuDownEvent", "y", "Sine_EaseInOut", 223, 800, 3, true, false, 10)
root:addChildWindow(battlechannelListbackwindow)

RegistEscEventInfo("sj_SelectChannel_BattleChannelList_AlphaWindow", "HideBattleChannelList")

function RenderBattleChannelBackImage(args)
	-- ���� ä�� ������
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	local maxVillagePage, maxBattlePage = WndSelectChannel_GetMaxChannelPage()
	local battlePageText = curBattlePage.."  /  "..maxBattlePage
	
	local window = CEGUI.toWindowEventArgs(args).window	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	local position = window:getPosition()
	local posX = position.x.offset + parentPos.x.offset + 108
	local posY = position.y.offset + parentPos.y.offset + 254
	drawer:drawText(battlePageText, posX, posY)
end

function HideBattleChannelList()
	winMgr:getWindow("sj_SelectChannel_BattleChannelList_AlphaWindow"):setVisible(false)
	--winMgr:getWindow("sj_SelectChannel_BattleChannelList_backImage"):setVisible(false)
	winMgr:getWindow("sj_SelectChannel_BattleChannelList_backImage"):activeMotion("BottonMenuDownEvent")
	
	for i=0, MAX_BATTLE_CHANNEL-1 do
		winMgr:getWindow(i.."sj_SelectChannel_BattlechannelRadioButton"):setProperty("Selected", "false")
	end
	
	CanceledChannelList()
end

for i=0, MAX_BATTLE_CHANNEL-1 do
	
	-- ���� ä�� ���� ��ư
	channelwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_SelectChannel_BattlechannelRadioButton")
	channelwindow:setTexture("Normal", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("Hover", "UIData/channel_002.tga", 0, 813)
	channelwindow:setTexture("Pushed", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("PushedOff", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("SelectedNormal", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedHover", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedPushed", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("SelectedPushedOff", "UIData/channel_002.tga", 0, 854)
	channelwindow:setTexture("Enabled", "UIData/channel_002.tga", 0, 772)
	channelwindow:setTexture("Disabled", "UIData/channel_002.tga", 0, 895)
	channelwindow:setPosition(11, 42+(i*40))
	channelwindow:setSize(235, 41)
	channelwindow:setProperty("GroupID", 2102)
	channelwindow:setUserString("battleIndex", tostring(i))
	channelwindow:subscribeEvent("MouseDoubleClicked", "OnDoubleClickEnterBattle")
	channelwindow:subscribeEvent("EndRender", "RenderBattleChannelInfos")
	battlechannelListbackwindow:addChildWindow(channelwindow)	
	
	-- 1. ���� ä�� �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_SelectChannel_BattlechannelName")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
	mywindow:setText("")
	mywindow:setPosition(8, 3)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	channelwindow:addChildWindow(mywindow)
	
	-- 2. ä�� ���� ���� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_SelectChannel_BattleChannelLevelText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150, 150, 150, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(86, 4)
	mywindow:setSize(70, 20)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	channelwindow:addChildWindow(mywindow)	

	-- 3. ���� ä�� ȥ�� ��׷���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_SelectChannel_BattleconfusionIconTemp")
	mywindow:setTexture("Enabled", "UIData/channel_002.tga", 531, 700)
	mywindow:setTexture("Disabled", "UIData/channel_002.tga", 531, 700)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(47, 25)
	mywindow:setSize(134, 10)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	channelwindow:addChildWindow(mywindow)

	-- 4. ���� ä�� ȥ�� �׷���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_SelectChannel_BattleconfusionIcon")
	mywindow:setTexture("Enabled", "UIData/channel_002.tga", 531, 710)
	mywindow:setTexture("Disabled", "UIData/channel_002.tga", 531, 710)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(47, 25)
	mywindow:setSize(134, 10)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)	
	channelwindow:addChildWindow(mywindow)
end

function OnDoubleClickEnterBattle(args)
	local battleIndex = CEGUI.toWindowEventArgs(args).window:getUserString("battleIndex")
	WndSelectChannel_EnterBattle(tonumber(battleIndex))
	
	for i=0, MAX_BATTLE_CHANNEL-1 do
		winMgr:getWindow(i.."sj_SelectChannel_BattlechannelRadioButton"):setProperty("Selected", "false")
	end
end

function RenderBattleChannelInfos(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local battleIndex = window:getUserString("battleIndex")
	local zoneIndex, squareIndex = GetChannelInfos(battleIndex)
	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	local position = window:getPosition()
	local posX = position.x.offset + parentPos.x.offset
	local posY = position.y.offset + parentPos.y.offset
	if zoneIndex >= 0 and squareIndex then
		local _left = DrawEachNumber("UIData/channel_002.tga", zoneIndex, 1, posX+87, posY+7, 703, 686, 14, 19, 14)
		local _left = DrawEachNumber("UIData/channel_002.tga", squareIndex, 1, posX+186, posY+7, 703, 686, 14, 19, 14)
	end
end

-- ���� ä�� ������ �ʱ�ȭ
function WndSelectChannel_ClearBattleChannelPage()
	for i=0, MAX_BATTLE_CHANNEL-1 do
		winMgr:getWindow(i.."sj_SelectChannel_BattlechannelRadioButton"):setVisible(false)
	end
end


-- ���� ä���� ������ ��� ������Ʈ
function WndSelectChannel_BattleExistChannel(i, index, userPercent, LevelFrom, LevelTo, extreme, name, limitType)
	
	winMgr:getWindow(i.."sj_SelectChannel_BattlechannelRadioButton"):setVisible(true)
	
	-- 1. ä�� �̸�
	if extreme == BATTLETYPE_NORMAL then
		if limitType == 0 then
			winMgr:getWindow(i.."sj_SelectChannel_BattlechannelName"):setTextColor(255, 255, 255, 255)
		elseif limitType == 1 then
			winMgr:getWindow(i.."sj_SelectChannel_BattlechannelName"):setTextColor(255, 200, 80, 255)
		end
	elseif extreme == BATTLETYPE_EXTREME then
		winMgr:getWindow(i.."sj_SelectChannel_BattlechannelName"):setTextColor(220, 80, 220, 255)
	end
	winMgr:getWindow(i.."sj_SelectChannel_BattlechannelName"):setText(name)
	
	-- 2. ä�� ������ ����
	if limitType == 0 then		-- ����üũ
		winMgr:getWindow(i.."sj_SelectChannel_BattleChannelLevelText"):setText("Lv"..LevelFrom.." - Lv"..LevelTo)
	elseif limitType == 1 then	-- ����üũ
		winMgr:getWindow(i.."sj_SelectChannel_BattleChannelLevelText"):setText("Ld"..(LevelFrom+1).." - Ld"..(LevelTo+1))
	end
	
	-- 3. ä�� ȥ�� �׷���
	local tex_y = 700
	if		0 < userPercent and userPercent <= 3 then	tex_y = 710	-- �ʷ� �׷���
	elseif	3 < userPercent and userPercent <= 7 then	tex_y = 720	-- ��� �׷���
	else												tex_y = 730	-- ���� �׷���
	end
	
	local ONE_PIXEL_TEXSIZE	= 13	-- 1���� ���� �̹��� ũ��
	winMgr:getWindow(i.."sj_SelectChannel_BattleconfusionIcon"):setTexture("Enabled", "UIData/channel_002.tga", 531, tex_y)
	winMgr:getWindow(i.."sj_SelectChannel_BattleconfusionIcon"):setTexture("Disabled", "UIData/channel_002.tga", 531, tex_y)
	winMgr:getWindow(i.."sj_SelectChannel_BattleconfusionIcon"):setSize(userPercent*ONE_PIXEL_TEXSIZE, 10)
end



------------------------------------------------------------
-- ���� ä�� ������ ��, �� ��ư
------------------------------------------------------------
tBattleZonePageButtonName  = { ["err"]=0, "sj_SelectChannel_BattleZoneLeftButton", "sj_SelectChannel_BattleZoneRightButton" }
tBattleZonePageButtonTexX  = { ["err"]=0, 493, 512 }
tBattleZonePageButtonPosX  = { ["err"]=0, 70, 168 }
tBattleZonePageButtonEvent = { ["err"]=0, "BattleZonePageLeftClicked", "BattleZonePageRightClicked" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tBattleZonePageButtonName[i])
	mywindow:setTexture("Normal", "UIData/channel_002.tga", tBattleZonePageButtonTexX[i], 700)
	mywindow:setTexture("Hover", "UIData/channel_002.tga", tBattleZonePageButtonTexX[i], 725)
	mywindow:setTexture("Pushed", "UIData/channel_002.tga", tBattleZonePageButtonTexX[i], 750)
	mywindow:setTexture("PushedOff", "UIData/channel_002.tga", tBattleZonePageButtonTexX[i], 700)
	mywindow:setPosition(tBattleZonePageButtonPosX[i], 248)
	mywindow:setSize(19, 25)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tBattleZonePageButtonEvent[i])
	battlechannelListbackwindow:addChildWindow(mywindow)
end

function BattleZonePageLeftClicked(args)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	if curBattlePage > 1 then
		curBattlePage = curBattlePage - 1
		WndSelectChannel_ChangeBattleChannelPage(tonumber(curBattlePage))
	end
end

function BattleZonePageRightClicked(args)
	local curVillagePage, curBattlePage = WndSelectChannel_GetCurrentChannelPage()
	local maxVillagePage, maxBattlePage = WndSelectChannel_GetMaxChannelPage()
	if curBattlePage < maxBattlePage then
		curBattlePage = curBattlePage + 1
		WndSelectChannel_ChangeBattleChannelPage(tonumber(curBattlePage))
	end
end


------------------------------------------------------------
-- ���� �����ϱ�(Ȯ�� ��ư)
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectChannel_EnterBattleButton")
mywindow:setTexture("Normal", "UIData/channel_002.tga", 493, 604)
mywindow:setTexture("Hover", "UIData/channel_002.tga", 493, 636)
mywindow:setTexture("Pushed", "UIData/channel_002.tga", 493, 668)
mywindow:setTexture("PushedOff", "UIData/channel_002.tga", 493, 604)
mywindow:setPosition(20, 282)
mywindow:setSize(105, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedEnterBattle")
battlechannelListbackwindow:addChildWindow(mywindow)

function ClickedEnterBattle(args)
	for i=0, MAX_BATTLE_CHANNEL-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_SelectChannel_BattlechannelRadioButton")):isSelected() then
			local battleIndex = winMgr:getWindow(i .. "sj_SelectChannel_BattlechannelRadioButton"):getUserString("battleIndex")
			WndSelectChannel_EnterBattle(tonumber(battleIndex))
			
			for j=0, MAX_BATTLE_CHANNEL-1 do
				winMgr:getWindow(j.."sj_SelectChannel_BattlechannelRadioButton"):setProperty("Selected", "false")
			end
			return
		end
	end	
	
	-- ���õȰ� ���� ��� ����ȣ��
	WndSelectChannel_Error(LAN_CPP_SELECT_CHANNEL_3)
end


------------------------------------------------------------
-- ���� ���� ��ҹ�ư
------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectChannel_CloseBattleButton")
mywindow:setTexture("Normal", "UIData/channel_002.tga", 598, 604)
mywindow:setTexture("Hover", "UIData/channel_002.tga", 598, 636)
mywindow:setTexture("Pushed", "UIData/channel_002.tga", 598, 668)
mywindow:setTexture("PushedOff", "UIData/channel_002.tga", 598, 604)
mywindow:setPosition(130, 282)
mywindow:setSize(105, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedCancelBattle")
battlechannelListbackwindow:addChildWindow(mywindow)

function ClickedCancelBattle(args)
	HideBattleChannelList()
end







--------------------------------------------------------------------

-- Popup Window

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectChannel_AlphaBackImg")
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

--------------------------------------------------------------------
-- �˾� �޼��� â
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectChannel_messageWindow")
mywindow:setTexture("Enabled", "UIData/popup002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup002.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(342, 300)
mywindow:setSize(340, 141)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- �޼��� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SelectChannel_messageDesc")
mywindow:setPosition(0, 20)
mywindow:setSize(340, 100)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
winMgr:getWindow("SelectChannel_messageWindow"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� Ȯ��, ��ҹ�ư
--------------------------------------------------------------------
local tPopupExitName  = {["protecterr"]=0, "SelectChannel_eixt_OkBtn", "SelectChannel_eixt_CancelBtn" }
local tPopupExitTexY  = {['protecterr']=0,		0,				108}
local tPopupExitPosX  = {['protecterr']=0,		63,				187}
local tPopupExitEvent = {["protecterr"]=0, "PopupExit_OK", "PopupExit_CANCEL" }

for i=1, #tPopupExitName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPopupExitName[i])
	mywindow:setTexture("Normal", "UIData/popup002.tga", 340, tPopupExitTexY[i])
	mywindow:setTexture("Hover", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 27)
	mywindow:setTexture("Pushed", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 54)
	mywindow:setTexture("PushedOff", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 54)
	mywindow:setPosition(tPopupExitPosX[i], 96)
	mywindow:setSize(90, 27)
	mywindow:setVisible(false)
	if i == 1 then
		mywindow:setUserString("wndType", -1)
	end
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tPopupExitEvent[i])
	winMgr:getWindow("SelectChannel_messageWindow"):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- ���� �˾�â�� ����ش�.
--------------------------------------------------------------------
function PopupMessage(message)
	winMgr:getWindow("SelectChannel_AlphaBackImg"):setVisible(true)
	winMgr:getWindow("SelectChannel_messageWindow"):setVisible(true)
	
	winMgr:getWindow("SelectChannel_messageDesc"):setPosition(0, 49)
	winMgr:getWindow("SelectChannel_messageDesc"):setTextExtends(message,g_STRING_FONT_DODUM,14,   255,255,255,255,   2,   0,0,0,255)
end


------------------------------------------------------------------------
-- �˾�(����â)
------------------------------------------------------------------------
function CallPopupExit(wndtype)
	-- ����� �����̵�, ���������� ������ ����� ��������

	local typeEnumIndex = LAN_LUA_WND_POPUP_1
	
	winMgr:getWindow("SelectChannel_eixt_OkBtn"):setUserString("wndType", wndtype)
	root:addChildWindow(winMgr:getWindow("SelectChannel_AlphaBackImg"))
	local g_STRING_EIXT = GetSStringInfo(typeEnumIndex)	-- ��4������ ���� �Ͻðڽ��ϱ�?
	DebugStr('GetSStringInfo�� �����ϰ� �ֽ��ϴ�'..typeEnumIndex)
	PopupMessage(g_STRING_EIXT)
	root:addChildWindow( winMgr:getWindow('SelectChannel_messageWindow') )
	winMgr:getWindow("SelectChannel_eixt_OkBtn"):setVisible(true)
	winMgr:getWindow("SelectChannel_eixt_CancelBtn"):setVisible(true)		
end


------------------------------------------------------------------------
-- ���� ������ ��ư
------------------------------------------------------------------------
function PopupExit_OK()
	local wndType = tonumber(winMgr:getWindow("SelectChannel_eixt_OkBtn"):getUserString("wndType"))
	DebugStr("ddd: " .. wndType)
	BtnPageMove_MoveBackWindow(wndType)
	winMgr:getWindow("SelectChannel_eixt_OkBtn"):setUserString("wndType", -1)
end


------------------------------------------------------------------------
-- ���� ��� ��ư
------------------------------------------------------------------------
function PopupExit_CANCEL()
	WndPopupButtonClickSound()
	winMgr:getWindow("SelectChannel_AlphaBackImg"):setVisible(false)
	winMgr:getWindow("SelectChannel_messageWindow"):setVisible(false)
	winMgr:getWindow("SelectChannel_eixt_OkBtn"):setVisible(false)
	winMgr:getWindow("SelectChannel_eixt_CancelBtn"):setVisible(false)
end







end