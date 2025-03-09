--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer();
guiSystem:setGUISheet(root)
root:activate()

local CM_String_Step					= PreCreateString_1031 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_14)			-- %d �ܰ�
local CM_String_CanPlayAfterComplete	= PreCreateString_1032 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_15)			-- �Ϸ� �� �̼� ���� ����
local CM_String_RewardText1				= PreCreateString_1034 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_17)		-- �����Ⱓ���� ����� �� �ִ� ��ų�� ���� �� �ֽ��ϴ�.
local CM_String_RewardText2				= PreCreateString_1035 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_18)		-- ���� ������ ���Ǵ� ������ �������� �����ϰų� �������� �̿��� �� ���˴ϴ�.
local CM_String_RewardText3				= PreCreateString_1036 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_19)		-- ���忡 �ִ� �����̵� ����(��Ű)���� ���� �������� ������ �� �ֽ��ϴ�.
local CM_String_RewardText4				= PreCreateString_1037 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_20)		-- �������� �ʿ��� ����ġ�� �����մϴ�.
local CM_String_RewardText5				= PreCreateString_1038 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_21)		-- �����̵忡�� ����ϴ� �������� �����մϴ�
local CM_String_RewardText6				= PreCreateString_1039 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_22)		-- �����մϴ�.\nç�����̼� é��1. ü���϶� �Ϸ��ϼ̽��ϴ�.\n���� é��2. �޼��϶� �����Ͻñ� �ٶ��ϴ�.\n�پ��� ������ ��ٸ��� �ֽ��ϴ�.
local CM_String_Present					= PreCreateString_1692 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_42)		-- ����
local CM_String_Goal					= PreCreateString_1033 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_16)		-- ��ǥ
local CM_String_CostumGet				= PreCreateString_1693 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_43)		-- �ڽ�Ƭ�� ȹ���Ͽ����ϴ�

-- �̺�Ʈ ����
local CM_String_RewardGetMsg		= PreCreateString_1694 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_44)		-- �����մϴ�! �̺�Ʈ ������ ȹ���ϼ̽��ϴ�.
local CM_String_Day					= PreCreateString_1057 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_40)		-- ��
local CM_String_UntilDelete			= PreCreateString_1056 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)		-- �����ñ���



--------------------------------------------------------------------
-- ç���� �̼Ǻ��� �˾����� �������� �� ����
--------------------------------------------------------------------
CM_RenderOK	= false
local g_MotionEnd	= false
local tCM_ResultInfo = {['protecterr']=0, 0, 0, 0, 0, "", "", "",""}		-- �̼� �������

--------------------------------------------------------------------

-- ChallengeMission ���� �˾�â.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- ç���� �̼� �����˾� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardPopupAlpha")
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
-- Esc, EnterŰ ������
--------------------------------------------------------------------
--RegistEscEventInfo("CM_RewardPopupAlpha", "CMRewardOKButtonEvent")
--RegistEnterEventInfo("CM_RewardPopupAlpha", "CMRewardOKButtonEvent")


--------------------------------------------------------------------
-- ç���� �̼� �����˾�(��Ʈ�ѷ��� �־��ֱ� ���ؼ� ����â�� ���ϵ�� ��� ���ߴ�.)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardPopupImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)

mywindow:subscribeEvent("EndRender", "CM_RewardEndRender")			-- ����
mywindow:subscribeEvent("MotionEventEnd", "RewardMotionEventEnd");	-- ��Ʈ�ѷ� ����� �Ϸ������ ������ �Լ�
mywindow:setAlign(8);
mywindow:addController("CM_RewardController", "Shown", "xscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("CM_RewardController", "Shown", "yscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("CM_RewardController", "Shown", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10);

root:addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç���� �̼� ���� Ÿ��Ʋ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardTitleImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 978)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 978)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç���� �̼� �̼Ǻ��� �˾� Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_RewardOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "CMRewardOKButtonEvent")
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ç���� �̼� ���� ����
--------------------------------------------------------------------
tRewardBackTexX = {['protecterr']=0, [0] = 0,	266, 0, 266 }
tRewardBackTexY = {['protecterr']=0, [0] = 210,210, 315, 315 }

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardBackImage")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(37, 80)
mywindow:setSize(266, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ç���� �̼� ����(�̹���) ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardImageBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7, 6)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç���� �̼� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardStarEffect")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 420)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 420)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(-15, -30)
mywindow:setSize(115, 116)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̼�â�� ������ ������ �߻��ϰԵȴ�(��Ʈ���� �Ϸ������)
--------------------------------------------------------------------
function RewardMotionEventEnd()
	if winMgr:getWindow("CM_RewardPopupAlpha"):isVisible() then
		CMVisible(true)
		g_MotionEnd = true
	end
end

--------------------------------------------------------------------
-- ç���� �̼� �Ϸ� ����â �����κ�.
--------------------------------------------------------------------
function CM_RewardEndRender(args)
	if g_MotionEnd then
		-- 
		local drawer = winMgr:getWindow("CM_RewardPopupImage"):getDrawer();
		drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
		-- 1 -> �ʺ�, 2->�̼�, 3->ȸ, 4->�޼�
		if tCM_ResultInfo[1] == 1 then		--���� �̼��϶�
			local String = string.format(PreCreateString_1019, tCM_ResultInfo[7], tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, String.."!")

			common_DrawOutlineText1(drawer, String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- Ÿ��Ʋ(�ٲ��ֱ�)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 0, 978)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 0, 978)
					
		elseif tCM_ResultInfo[1] == 0 then	-- �ʺ� �̼�
			local String = string.format(PreCreateString_1019, tCM_ResultInfo[7], tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, PreCreateString_1018.." "..String.."!")

			common_DrawOutlineText1(drawer, PreCreateString_1018.." "..String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- Ÿ��Ʋ(�ٲ��ֱ�)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 0, 978)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 0, 978)
		
		else		-- ������ �ο��� �̱���.(10���� �س��� ���߿� ç�����̼� �ܰ谡 �þ �� �ֱ⋚����)
			local CM_String_WinEvent = PreCreateString_1865 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_45)	
			
			local String = string.format(CM_String_WinEvent, tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, String.."!")
			common_DrawOutlineText1(drawer, String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- Ÿ��Ʋ(�ٲ��ֱ�)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 340, 896)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 340, 896)

		end
		
		------------------
		-- ���� ����κ�
		------------------
		local RewardWhere = ""
		local RewardPosX	= 52
		-- ���� ���� Īȣ, ������ų, ���� �ڽ�Ƭ ��� ������ ���ߵɶ�.
		-- ���ڰ� ���� �׶�, ����, ����ġ�� �������� ������
		if tCM_ResultInfo[3] == 5 then	--�׶�
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 683, 24, 33, 25, drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 685)
			RewardWhere = PreCreateString_1022	-- 5
		elseif tCM_ResultInfo[3] == 6 then	--����
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 725, 24, 33, 25, drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 727)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 7 then	--����ġ
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 641, 24, 33, 25 , drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 643)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 8 then	--������
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 641, 24, 33, 25 ,drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 643)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 2 then	--��ųü���
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_1023, 157)	-- 6
			common_DrawOutlineText1(drawer, aa, 150, 105, 0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024			
		elseif tCM_ResultInfo[3] == 4 then	--�ڽ�Ƭ
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local TempString = PreCreateString_1025 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_8)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, TempString, 157)	
			common_DrawOutlineText1(drawer, aa, 150, 105, 0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024	
		else
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local NameStringSize	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, '"'..tCM_ResultInfo[5]..'"')--'"��¼�� �ѹ� ��"')
						
			--common_DrawOutlineText1(drawer, "��", 152, 94, 0,0,0,255, 255,255,255,255)
			common_DrawOutlineText1(drawer, '"'..tCM_ResultInfo[5]..'"', 146 + 77 - NameStringSize/2, 100, 0,0,0,255, 255,84,0,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			common_DrawOutlineText1(drawer, tCM_ResultInfo[6], 150, 120,  0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024	
		end
	
		
		drawer:setFont(g_STRING_FONT_DODUM, 12)
		drawer:setTextColor(255, 255, 255, 255)
		
		local TempString = PreCreateString_1026	--GetSStringInfo((LAN_LUA_CHALLENGEMISSION_9))

		common_DrawOutlineText1(drawer, "[!] "..TempString.."! "..RewardWhere, RewardPosX, 197, 0,0,0,255, 255,205,86,255)
		
	end

end

--extick = 0
tAniPosX = {['protecterr']=0, [0] = 0, 115, 0, 115 }
tAniPosY = {['protecterr']=0, [0] = 420, 420, 536, 536 }

-- ������ �����̵�뿡 ������(������ �׽�Ʈ��)
function StarAnimation(tick)
	winMgr:getWindow("CM_RewardStarEffect"):setTexture("Enabled", "UIData/GameSlotItem001.tga", tAniPosX[tick], tAniPosY[tick])
end

-- ���� �ִϸ��̼��ε� ���� �Ⱦ����� ���߿� ����..
function BackImageAnimation(tick)
	--winMgr:getWindow("CM_RewardBackImage"):setTexture("Enabled", "UIData/GameSlotItem001.tga", tRewardBackTexX[tick], tRewardBackTexY[tick])
end


--------------------------------------------------------------------
-- ç���� �̼� �̼�����, �Ϸ� �޼��� �ؽ�Ʈ
--------------------------------------------------------------------
tChallengeMissionTextName		= {['protecterr']=0, [0]= "MissionCondition", "ResultInfo"}
tChallengeMissionTextPosX		= {['protecterr']=0, [0]=	148, 14}
tChallengeMissionTextPosY		= {['protecterr']=0, [0]=	55, 195}
tChallengeMissionTextSizeX		= {['protecterr']=0, [0]=	190, 315}

for i = 0, #tChallengeMissionTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tChallengeMissionTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tChallengeMissionTextPosX[i], tChallengeMissionTextPosY[i])
	mywindow:setSize(tChallengeMissionTextSizeX[i], 20)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	
	mywindow:setLineSpacing(2)

	winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

end


--------------------------------------------------------------------
-- ç���� �̼� �Ϸ� �������� �����°� �Ϸ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_Present_OKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "CM_Present_OKButtonEvent")
root:addChildWindow(mywindow)
--

function CM_Present_OKButtonEvent()
	SettingPresentState(0)
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(false)
	winMgr:getWindow("CM_Present_OKButton"):setVisible(false)

	local bEventVisible	= winMgr:getWindow("CM_EventRewardAlpha"):isVisible()
	ChallengeMissionEvent(bEventVisible);
	CM_RenderOK	= false
	
	if bEventVisible == false then
		EventPopupOpen();
	end
end

--[[
--------------------------------------------------------------------
-- ç���� �̼� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ç���� �̼� ���� ����")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 235, 919)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 235, 919)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(55, 80)
mywindow:setSize(231, 105)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "RewardPopupImageRender")
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)


--���� ����, ���� ����, ���� ���Ⱓ.
tChallengeMissionRewardTextName		= {['protecterr']=0, [0]= "RewardName", "RewardDesc", "RewardPeriod"}
tChallengeMissionRewardTextPosX		= {['protecterr']=0, [0]=	10, 110, 110}
tChallengeMissionRewardTextPosY		= {['protecterr']=0, [0]=	5, 34, 82}
tChallengeMissionRewardTextSizeX	= {['protecterr']=0, [0]=	200, 120, 120}
tChallengeMissionRewardTextSizeY	= {['protecterr']=0, [0]=	20, 60, 20}

for i = 0, #tChallengeMissionRewardTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tChallengeMissionRewardTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0, 0, 0, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("1�ܰ� �̼� : 1000�޺�")
	mywindow:setPosition(tChallengeMissionRewardTextPosX[i], tChallengeMissionRewardTextPosY[i])
	mywindow:setSize(tChallengeMissionRewardTextSizeX[i], tChallengeMissionRewardTextSizeY[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("ç���� �̼� ���� ����"):addChildWindow(mywindow)

end
-- ���� ���� �̹���
tChallengeMissionRewardKindImageName	= {['protecterr']=0, "CM_Īȣ", "��ų ��ȯ��",  "CM_���� ������", "CM_���� �ڽ���", "CM_����Ʈ", "CM_����", "CM_����ġ", "CM_������"}
tChallengeMissionRewardKindImageTexX	= {['protecterr']=0, 	0,			98,				196,				294,			392,	   490,	  	   588,			686		}

for i=1, #tChallengeMissionRewardKindImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tChallengeMissionRewardKindImageName[i])
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", tChallengeMissionRewardKindImageTexX[i], 842)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", tChallengeMissionRewardKindImageTexX[i], 842)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(98, 91)
	mywindow:setVisible(false)		--false�� ����ٰ� ���߿� 
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ç���� �̼� ���� ����"):addChildWindow(mywindow)
end
--]]
--------------------------------------------------------------------

-- ç���� �̼Ǻ��� �˾� �Լ�.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �̼� ���� �˾� Ȯ�ι�ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function CMRewardOKButtonEvent()
	
	CMVisible(false)		-- ç���� �̼� �˾� ���ش�.
	g_MotionEnd = false;	-- ��� �Ϸ�
	--������ ����
	--PresentInPresentBox();	-- ������ Ȯ�����ش�.(����)
	winMgr:getWindow("CM_RewardPopupAlpha"):setVisible(false);	-- ���ְ�
	winMgr:getWindow("CM_RewardPopupImage"):setVisible(false);			-- ���ش�.
	
	if tCM_ResultInfo[3] == 4 then
		SettingPresentState(1)
		winMgr:getWindow("AS_RandumBackWindow"):setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
		winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
		winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(false)
		winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(false)		-- ������ Ȯ�ι�ư �Ⱥ��̰� ���ش�.
		winMgr:getWindow("AS_ExchangeOkBtn"):setVisible(false)			-- ��ư�� �Ⱥ��̰� �����.
		winMgr:getWindow("AS_ExchangeCancelBtn"):setVisible(false)
		

		
		for i = 0, 1 do
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearControllerEvent("PresentEvent");
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearActiveController()
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):setVisible(false)		-- ��Ʈ�� �޸� �̹��� ������
			
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "xscale", "Quintic_EaseIn", 30, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "yscale", "Quintic_EaseIn", 70, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54 , -253, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", -253, 54, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 15, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 15, 54, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 45, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 45, 54, 1, true, false, 10);
			if i == 1 then
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 255, 8, true, false, 10);
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 0, 12, true, false, 10);
			end
		end

	else

		local bEventVisible	= winMgr:getWindow("CM_EventRewardAlpha"):isVisible()

		ChallengeMissionEvent(bEventVisible);	
		
		if bEventVisible == false then
			EventPopupOpen();
		end
	end
	
end


--------------------------------------------------------------------
-- �̼� ���� �˾� Ȯ�ι�ư �����ش�.
--------------------------------------------------------------------
function RewardButtonVisible()
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
	winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(true)
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Enabled", "UIData/popup001.tga", 0, 363)	-- �˸� �̹���
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Disabled", "UIData/popup001.tga", 0, 363)	-- 0, 363 -->�����մϴ�
	
	winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(winMgr:getWindow("CM_Present_OKButton"))
	winMgr:getWindow("CM_Present_OKButton"):setVisible(true)
	CM_RenderOK	= true
end





-- ���� �������� ������ �ѷ��ִ� ������ ���� �����Լ�,
function CM_RandomboxRender(drawer)
		
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
	local Name	= tCM_ResultInfo[5]
	local NameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, Name)
	common_DrawOutlineText2(drawer, Name, 230 - NameSize/2, 14, 0,0,0,255, 255,205,86,255)	
	-- ������ �̹���.
	drawer:drawTextureSA("UIData/ItemUIData/"..tCM_ResultInfo[8], 20, 9, 243, 108, 0, 0, 255, 255, 255, 0, 0);	

	-- ������ ����
	local Desc	= tCM_ResultInfo[6]
	drawer:setFont(g_STRING_FONT_DODUM, 12);
	drawer:setTextColor(255, 0, 0, 255)
	drawer:drawText(Desc, 140, 42)
	
	
	drawer:setFont(g_STRING_FONT_DODUM, 13);
	common_DrawOutlineText2(drawer, CM_String_CostumGet, 80, 138, 0,0,0,255, 255,255,255,255)

end



function LevelUpEffect()
	
	WndBattleRoom_CM_MyLevelUpEffect()

end

--------------------------------------------------------------------
-- ç���� �̼� �Ϸ� ���� �̹���
--------------------------------------------------------------------
function RewardImage(RewardKindIndex)

	winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]):setPosition(0, 0);
	winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]):setVisible(true);
	winMgr:getWindow("CM_RewardImageBack"):addChildWindow(winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]))

end


--------------------------------------------------------------------
-- ��� ���� �˾�â�� ����ش�.
--------------------------------------------------------------------
function ShowChallengeMissionResult(MissionKind, Step, MissionType, TargetCount, MissionKindStr, RewardKindIndex, Rewardname, RewardDesc, RewardValue, RewardFileName)

	-- ���� �����κп��� �ѷ��ش�.
	tCM_ResultInfo[1] = MissionType		-- �ʺ����� �Ϲ�����.
	tCM_ResultInfo[2] = TargetCount		-- �̼� ��ǥ ī��Ʈ ����
	tCM_ResultInfo[3] = RewardKindIndex		-- ���� ����(Īȣ, ����ġ, �׶�, ���� ���)
	tCM_ResultInfo[4] = RewardValue		-- ������������ �޴� ������� ���� ��(ex. ����ġ 10000)���� ���°Ŵ� 0���� ����.
	tCM_ResultInfo[5] = Rewardname		-- ���� Ÿ��Ʋ(Īȣ�̸�, �������� ""�� ����.)
	tCM_ResultInfo[6] = AdjustString(g_STRING_FONT_GULIMCHE, 12, RewardDesc, 140)		-- ���� description
	tCM_ResultInfo[7] = MissionKindStr	-- ���� Ÿ�� string
	tCM_ResultInfo[8] =	RewardFileName		-- �����ڽ�Ƭ�϶�
	RewardImage(RewardKindIndex);		-- ���� �̹��� ����ش�.
	
	-- �����˾� ����
	root:addChildWindow(winMgr:getWindow("CM_RewardPopupAlpha"))
	winMgr:getWindow("CM_RewardPopupAlpha"):setVisible(true);
	
	-- �����˾�
	winMgr:getWindow("CM_RewardPopupImage"):clearActiveController();
	root:addChildWindow(winMgr:getWindow("CM_RewardPopupImage"))
	winMgr:getWindow("CM_RewardPopupImage"):setVisible(true);
	
	PlayWave('sound/TutorialReward01.wav');
end



--------------------------------------------------------------------

-- ChallengeMission ���� �̼� ������.

--------------------------------------------------------------------
-- �������� ����� ����
--------------------------------------------------------------------
local FIRSTITEM_POSX	= 2
local SECONDITEM_POSX	= 16
local THIRDITEM_POSX	= 32
local ITEM_FIRST_POSY	= 7
local ITEM_TERM			= 2
local BOTTOM_OFFSET		= 8
local STEP_COUNT		= 4
local bMouseClick		= false
local ScrollPrev		= 0
local OldScrollCount	= 0		-- ��ũ�ѹ��� ���� ��ġ
local MAX_TREELINE		= 17	-- ��ȭ�鿡 ������ �ƽ� ���μ�


g_CM_ItemCount	= 0
g_CM_tChildCount	= {['protecterr']=0, }
g_CM_tChildCount["_0"] = 0
g_CM_tChildCount["_1"] = 0
g_CM_TopWindowCount	= -1

-- ������ �Ϸ� ����Ұ�
local tCM_FontRGB	= {['protecterr']=0, 0, 0, 0 }
--------------------------------------------------------------------
-- ç���� �̼� �����˾�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChallengeMissionWindow")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 311, 504)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 311, 504)
mywindow:setWideType(6);
mywindow:setPosition((1024 - 713) / 2, (768 - 463) / 2)
mywindow:setSize(713, 463)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("ChallengeMissionWindow", "CM_CloseButtonClick")
--RegistEnterEventInfo("ChallengeMissionWindow", "CM_CloseButtonClick")

--------------------------------------------------------------------
-- ç���� �̼� Ʈ���޴�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_TreeBackWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(13, 58)
mywindow:setSize(261, 383)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent("MouseWheel", 'MouseWheelEvent');
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç�����̼� �������� �̹���
--------------------------------------------------------------------
tCM_RewardKindImageName	= {['protecterr']=0, "Reward_Title", "Reward_Skill",  "Reward_Item", "Reward_Costum", "Reward_Point", "Reward_Coin", "Reward_Exp", "Reward_Life"}
tCM_RewardKindImageTexX	= {['protecterr']=0, 	0,			98,				196,				294,			392,	   490,	  	   588,			686}

for i = 1, #tCM_RewardKindImageName do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tCM_RewardKindImageName[i])
		mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", tCM_RewardKindImageTexX[i], 843)
		mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", tCM_RewardKindImageTexX[i], 843)
		mywindow:setPosition(293, 340)
		mywindow:setSize(98, 90)
		mywindow:setVisible(true)		--false�� ����ٰ� ���߿� 
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- ��ũ�ѹ�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/VerticalScrollbar", "CM_ScrollBar")
mywindow:setSize(18, 383)
mywindow:setPosition(243, 0)
--mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
CEGUI.toScrollbar(mywindow):subscribeEvent("ScrollPosChanged", "CM_ScrollBarEvent")
CEGUI.toScrollbar(mywindow):setDocumentSize(383)
CEGUI.toScrollbar(mywindow):setPageSize(383)
CEGUI.toScrollbar(mywindow):setStepSize(20)
CEGUI.toScrollbar(mywindow):setScrollPosition(0)
winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç�����̼� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(680, 12)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CM_CloseButtonClickButtonClick")
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç�����̼� ���� Text 8��
--------------------------------------------------------------------
local tCM_TextName = {['protecterr'] = 0, "CM_MissionText", "CM_CountText", "CM_PlaceText", "CM_ConditionText", "CM_DescText", 
										"CM_RewardNameText", "CM_RewardDescText"}
local tCM_TextSizeX = {['protecterr'] = 0,	200,	75,		50,		200,	300,	100,	170}
local tCM_TextSizeY = {['protecterr'] = 0,	20,		20,		40,		40,		60,		20,		60}
local tCM_TextPosX = {['protecterr'] = 0,	297,	415,	608,	368,	297,	401,	401}
local tCM_TextPosY = {['protecterr'] = 0,	70,		106,	106,	153,	234,	345,	366}

for i=1, #tCM_TextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tCM_TextName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(true);
	mywindow:setPosition(tCM_TextPosX[i], tCM_TextPosY[i]);
	mywindow:setSize(tCM_TextSizeX[i], tCM_TextSizeY[i]);
	mywindow:setViewTextMode(1);
	mywindow:setAlign(1);
	mywindow:setLineSpacing(3);
	winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow);
end

for i=1, #tCM_TextName do
	winMgr:getWindow(tCM_TextName[i]):clearTextExtends()
	winMgr:getWindow(tCM_TextName[i]):addTextExtends("", g_STRING_FONT_GULIMCHE,13, 255,205,86,255, 1, 0,0,0,255);
end



--------------------------------------------------------------------
-- Ÿ��Ʋ��(���콺 ���� �����̰� �ϱ�)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "CM_TitleBar")
mywindow:setPosition(1, 1)
mywindow:setSize(679, 45)
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ç���� �̼� �Ϸ�, ����Ұ� �����̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_AlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 446)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 446)
mywindow:setPosition(280, 51)
mywindow:setSize(423, 398)
mywindow:setVisible(true)		--false�� ����ٰ� ���߿� 
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ç���� �̼� �Ϸ�, ����Ұ� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_StampImage")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 0, 123)
mywindow:setPosition(105, 188)
mywindow:setSize(224, 123)
mywindow:setVisible(true)		--false�� ����ٰ� ���߿� 
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("CM_AlphaImage"):addChildWindow(mywindow)





--------------------------------------------------------------------

-- ChallengeMission ���� �̼� ������ �Լ�.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- ç���� �̼� ������ �о�ͼ� üũ�ڽ��� ������ư�� �������ش�.
-- ��� ������ �ѹ��� �ҷ��ͼ� ���������Ѵ�.(������ �ϸ� ������ ���� ����)
--------------------------------------------------------------------
--1,2,3
function CreateTopTreeWindow(TopWindowIndex, ChildCount, ...)		-- ���ϵ尡 ��� �ִ��� �� �� ���⶧���� ���ڰ��� ���������� �س���.()
--	local	WindowCount	= arg.n		-- ������ �ڽ��� ���(����) �޷��ִ���..
	if TopWindowIndex == 0 then
		g_CM_ItemCount = 0
	end
	g_CM_tChildCount["_"..TopWindowIndex]	= ChildCount
	g_CM_TopWindowCount					= TopWindowIndex
	
	
------------------
-- ����
------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeItemBack_"..TopWindowIndex)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
	mywindow:setSize(236, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
	
	g_CM_ItemCount = g_CM_ItemCount + 1	-- ������ ���ڸ� ī��Ʈ �����ش�.
	
-------------------------
-- +ǥ�� ��ư(üũ�ڽ�)
-------------------------
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", "TreeItemCheckBox_"..tostring(TopWindowIndex))
	mywindow:setTexture("Normal", "UIData/guildmission.tga", 357, 453)
	mywindow:setTexture("Hover", "UIData/guildmission.tga", 377, 453)
	mywindow:setTexture("Pushed", "UIData/guildmission.tga", 397, 453)
	mywindow:setTexture("PushedOff", "UIData/guildmission.tga", 397, 453)
	
	mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 357, 473)
	mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 377, 473)
	mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 397, 473)
	mywindow:setTexture("SelectedPushedOff", "UIData/guildmission.tga", 397, 473)
	
	mywindow:setPosition(FIRSTITEM_POSX, 1)
	mywindow:setSize(19, 19)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	CEGUI.toCheckbox(mywindow):setSelected(true)
	mywindow:subscribeEvent("CheckStateChanged", "TreeItemCheckBoxEvent")
	mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex));		-- �ε����� ���� ������
	winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex)):addChildWindow(mywindow)
	
	
---------------------------------------------
-- �ؽ�Ʈ�� �־������ ��ư(���� �־����)
---------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "TreeItemButton_"..tostring(TopWindowIndex))
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(23, 2)
	mywindow:setSize(210, 16)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CM_TreeClick")
	mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
	mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
	mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
	mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
	mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex));		-- �ε����� ���� ������
	
	winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex)):addChildWindow(mywindow)
---------------------------------------------
-- �̼��� ������ �ؽ�Ʈ
---------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex))
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(3, 1)
	mywindow:setSize(207, 16)
	mywindow:setFont(g_STRING_FONT_DODUM, 14)
	mywindow:setTextColor(180, 180, 180, 255)
--	mywindow:setViewTextMode(1)
--	mywindow:setAlign(1)
--	mywindow:setLineSpacing(2)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setEnabled(false)
	mywindow:setUserString("TextStateIndex", g_String_Normal)
	winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex)):addChildWindow(mywindow)

------------------------------------
-- �ι�° ��ġ�� ���� ���ϵ�
------------------------------------
	for i = 1, ChildCount do
	------------------
	-- ����
	------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeItemBack_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
		mywindow:setSize(236, 20)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
		
		g_CM_ItemCount = g_CM_ItemCount + 1	-- ������ ���ڸ� ī��Ʈ �����ش�.
		
	------------------
	-- +��ư �̹���
	------------------		
		mywindow = winMgr:createWindow("TaharezLook/Checkbox", "TreeItemCheckBox_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Normal", "UIData/guildmission.tga", 362, 416)
		mywindow:setTexture("Hover", "UIData/guildmission.tga", 378, 416)
		mywindow:setTexture("Pushed", "UIData/guildmission.tga", 394, 416)
		mywindow:setTexture("PushedOff", "UIData/guildmission.tga", 394, 416)
		
		mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 362, 432)
		mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 378, 432)
		mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 394, 432)
		mywindow:setTexture("SelectedPushedOff", "UIData/guildmission.tga", 394, 432)
		mywindow:setPosition(SECONDITEM_POSX, 3)
		mywindow:setSize(16, 16)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		CEGUI.toCheckbox(mywindow):setSelected(true)
		mywindow:subscribeEvent("CheckStateChanged", "TreeItemCheckBoxEvent")
		mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i));		-- �ε����� ���� ������
		winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)


	------------------
	-- Ŭ���Ǵ� ��ư
	------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "TreeItemButton_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(37, 2)
		mywindow:setSize(210, 16)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "CM_TreeClick")
		mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
		mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
		mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
		mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
		mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i));		-- �ε����� ���� ������

		winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)
	---------------------------------------------
	-- �̼��� ������ �ؽ�Ʈ
	---------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(3, 1)
		mywindow:setSize(207, 16)
		mywindow:setFont(g_STRING_FONT_DODUM, 113)
		mywindow:setTextColor(180, 180, 180, 255)
--		mywindow:setViewTextMode(1)
--		mywindow:setAlign(1)
--		mywindow:setLineSpacing(2)
		mywindow:setZOrderingEnabled(false)	
		mywindow:setEnabled(false)
		mywindow:setUserString("TextStateIndex", "0")
		winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)

	------------------------------------
	-- ������ �Ǵ� ���ϵ�
	------------------------------------
		for j = 1, STEP_COUNT do
		------------------
		-- Ŭ���Ǵ� ��ư
		------------------
			mywindow = winMgr:createWindow("TaharezLook/RadioButton", "TreeItemButton_"..tostring(TopWindowIndex).."_"..i.."_"..j)
			mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 848)
			mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 865)
			mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 0, 882)
			mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 0, 882)
			mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 0, 882)
			mywindow:setProperty("GroupID", 654)
			mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
			mywindow:setSize(256, 18)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setSubscribeEvent("SelectStateChanged", "StepItemClick")
			mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
			mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
			mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
			mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
			mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i).."_"..tostring(j));		-- �ε����� ���� ������
			winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
			
			g_CM_ItemCount = g_CM_ItemCount + 1	-- ������ ���ڸ� ī��Ʈ �����ش�.

		---------------------------------------------
		-- �̼��� ������ �ؽ�Ʈ
		---------------------------------------------
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex).."_"..i.."_"..j)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setPosition(30, 2)
			mywindow:setSize(207, 16)
			mywindow:setFont(g_STRING_FONT_DODUM, 112)
			mywindow:setTextColor(180, 180, 180, 255)
			
--			mywindow:setViewTextMode(1)
--			mywindow:setAlign(1)
--			mywindow:setLineSpacing(2)
			mywindow:setZOrderingEnabled(false)	
			mywindow:setEnabled(false)
			mywindow:setUserString("TextStateIndex", "0")
			winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex).."_"..i.."_"..j):addChildWindow(mywindow)
		end
	end
	winMgr:getWindow("TreeItemText_"..tostring(TopWindowIndex)):setText(g_tChapterName[TopWindowIndex + 1])
	
	RefreshTreeWindow()		-- Ʈ�� ������ ������ �°� ����

end



--------------------------------------------------------------------
-- Ʈ�� ������ ���� �ؽ�Ʈ�� ������Ʈ ���ش�.
--------------------------------------------------------------------
function TreeTextUpdate(kind, typecount, desc, count, CurrentStep, CurrentKind)

	local state		= ""
	local ChildState = ""
	
	if CurrentKind == 0 then
		if kind == 1 then
			state = g_String_NotPlaying
		else
			if count == -1 then
				state = g_String_Complete
			else
				state = g_String_Playing
			end
		end
		
	elseif CurrentKind == 1 then	-- �޼��϶�
		if kind == 0 then
			state = g_String_Complete
		else
			if count == -1 then
				state = g_String_Complete
			else
				state = g_String_Playing
			end
		end
	elseif CurrentKind == 2 then	-- �Ϸ�
		state = g_String_Complete
	end

	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setUserString("TextStateIndex", state)
	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setTextColor(g_CM_tFontColor[1][state], g_CM_tFontColor[2][state], g_CM_tFontColor[3][state], 255)
	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setText(desc)
	--winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):addText(" ("..state..")")

	for i = 1, STEP_COUNT do
		if state == g_String_Complete then
			ChildState = g_String_Complete
		elseif state == g_String_Playing then
			if CurrentStep > i then
				ChildState = g_String_Complete
			elseif CurrentStep == i then
				ChildState = g_String_Playing
			elseif CurrentStep < i then
				ChildState = g_String_NotPlaying
			end
		elseif state == g_String_NotPlaying then
			ChildState = g_String_NotPlaying
		end
		local String = string.format(CM_String_Step, i)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setUserString("TextStateIndex", ChildState)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setTextColor(g_CM_tFontColor[1][ChildState], g_CM_tFontColor[2][ChildState], g_CM_tFontColor[3][ChildState], 255)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setText(String.." ("..ChildState..")")
	end

end




-----------------------------------------------------------------------------
-- ��ư �̺�Ʈ(Ʈ���� �θ� Ŭ�������� ȿ���� �ֱ�����)
-----------------------------------------------------------------------------
--------------------------------------------------------------------
-- ���콺�� �ٿ��̺�Ʈ �߻� ��������,
--------------------------------------------------------------------
function CM_ButtonMouseDown(args)
	
	if bMouseClick == false then
		local MyWindow = CEGUI.toMouseEventArgs(args).window;
		local WindowIndex	= MyWindow:getUserString("WindowIndex");
		
		local window_pos = MyWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		MyWindow:setPosition(win_pos_x + 2, win_pos_y + 2)
		bMouseClick = true
	end
	
end


--------------------------------------------------------------------
-- ���콺�� ���̺�Ʈ �߻� ��������,
--------------------------------------------------------------------
function CM_ButtonMouseUp(args)

	if bMouseClick == true then
		local MyWindow = CEGUI.toMouseEventArgs(args).window;
		local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
		local window_pos = MyWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		MyWindow:setPosition(win_pos_x - 2, win_pos_y - 2)
		bMouseClick = false
	end

end


--------------------------------------------------------------------
-- ���콺�� �����ȿ� �������� �̺�Ʈ
--------------------------------------------------------------------
function CM_ButtonMouseEnter(args)

	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
	MouseEventTextSetting(WindowIndex, true)		-- �ؽ�Ʈ ����
	MouseEventCheckBoxSetting(WindowIndex, true)	-- üũ�ڽ� ����
	

end


--------------------------------------------------------------------
-- ���콺�� �����ȿ��� �������� �̺�Ʈ
--------------------------------------------------------------------
function CM_ButtonMouseLeave(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
	MouseEventTextSetting(WindowIndex, false)		-- �ؽ�Ʈ ����
	MouseEventCheckBoxSetting(WindowIndex, false)	-- üũ�ڽ� ����
	

end
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

local tCM_NumberTable = {['protecterr']=0, -1, -1, -1}



--------------------------------------------------------------------
-- �ܰ� ������ư Ŭ�� �̺�Ʈ(Ŭ���� �������� �� �ѷ��ش�)
--------------------------------------------------------------------
function StepItemClick(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	if CEGUI.toRadioButton(MyWindow):isSelected() then
		local String = winMgr:getWindow("TreeItemText"..WindowIndex):getUserString("TextStateIndex")
		
		StringFindReturnNumber(WindowIndex, 1)

		-- C���� �ε����� ���߱� ���ؼ�
		if tCM_NumberTable[1] == 0 then
			tCM_NumberTable[2] = tCM_NumberTable[2] - 1		
		else
			tCM_NumberTable[2] = tCM_NumberTable[2] + 5
		end
		Get_CM_ChildInfo(tCM_NumberTable[1], tCM_NumberTable[2], tCM_NumberTable[3], String)		
		
		winMgr:getWindow("TreeItemText"..WindowIndex):setTextColor(255, 255, 255, 255)
		
		local TexY = 0;
		if String == g_String_Playing then
			TexY = 865
		elseif String == g_String_Complete then
			TexY = 848
		elseif String == g_String_NotPlaying then
			TexY = 882
		else
			TexY = 899
		end
		MyWindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 0, TexY)
		MyWindow:setTexture("SelectedHover", "UIData/guildmission.tga", 0, TexY)
		MyWindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 0, TexY)
	else
		local String = winMgr:getWindow("TreeItemText"..WindowIndex):getUserString("TextStateIndex")
		
		winMgr:getWindow("TreeItemText"..WindowIndex):setTextColor(g_CM_tFontColor[1][String], g_CM_tFontColor[2][String], g_CM_tFontColor[3][String], 255)
	end
end



--------------------------------------------------------------------
-- �̼� �������� �޾ƿ´�
--------------------------------------------------------------------
function SettingMissionInfo(Kind, TypeIndex, TypeStr, StepIndex, TargetCount, CurrentCount, RewardIndex, RewardName, RewardDesc, Select_State)
	for i = 1, #tCM_RewardKindImageName do
		if RewardIndex ~= i then
			winMgr:getWindow(tCM_RewardKindImageName[i]):setVisible(false)
		else
			winMgr:getWindow(tCM_RewardKindImageName[i]):setVisible(true)
		end
	end

	----------
	-- �ӹ� --
	local StageString = string.format(CM_String_Step, StepIndex)
	winMgr:getWindow("CM_MissionText"):clearTextExtends()
	winMgr:getWindow("CM_MissionText"):addTextExtends(g_tChapterName[Kind + 1].." : ", g_STRING_FONT_DODUMCHE,14, 255,205,86,255, 1, 0,0,0,255);
	winMgr:getWindow("CM_MissionText"):addTextExtends(TypeStr.." "..StageString, g_STRING_FONT_DODUMCHE,14, 255,255,255,255, 1, 0,0,0,255);


	----------
	-- ��� --
	winMgr:getWindow("CM_PlaceText"):setAlign(8)
	winMgr:getWindow("CM_PlaceText"):clearTextExtends()
	if TypeIndex == 0 or TypeIndex == 1 or TypeIndex == 6 or TypeIndex == 7 or TypeIndex == 8 or
		TypeIndex == 9 or TypeIndex == 10 then
		winMgr:getWindow("CM_PlaceText"):setPosition(600, 106)
	else
		winMgr:getWindow("CM_PlaceText"):setPosition(600, 114)
	end
	winMgr:getWindow("CM_PlaceText"):addTextExtends(g_tCM_PlaceName[TypeIndex + 1], g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);

	
	----------
	-- ���� --
	local	ConditionStr = ""
	winMgr:getWindow("CM_ConditionText"):clearTextExtends()
	
	if Kind == 1 and StepIndex == 1 then
		winMgr:getWindow("CM_ConditionText"):setPosition(364, 153)
		ConditionStr = g_tChapterName[Kind].."\n"..CM_String_CanPlayAfterComplete
	elseif Kind == 0 and StepIndex == 1 then
		winMgr:getWindow("CM_ConditionText"):setPosition(375, 160)
		ConditionStr = PreCreateString_1691 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_41)
	else
		winMgr:getWindow("CM_ConditionText"):setPosition(364, 153)
		StageString = string.format(CM_String_Step, StepIndex - 1)
		ConditionStr = g_tChapterName[Kind + 1]..": "..TypeStr.." "..StageString.."\n"..CM_String_CanPlayAfterComplete
	end
	winMgr:getWindow("CM_ConditionText"):addTextExtends(ConditionStr, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);


	----------
	-- ���� --
	winMgr:getWindow("CM_DescText"):clearTextExtends()
	local String	= CM_DescReturn(TypeIndex + 1, TargetCount)
	winMgr:getWindow("CM_DescText"):addTextExtends(String, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
	
	RewardDesc = RewardInfoTextReturn(RewardIndex, RewardDesc)

	--------------
	-- �����̸� --
	winMgr:getWindow("CM_RewardNameText"):clearTextExtends()
--	winMgr:getWindow("CM_RewardNameText"):addTextExtends(RewardName, g_STRING_FONT_GULIMCHE,12, 230,10,220,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_RewardNameText"):addTextExtends(RewardName, g_STRING_FONT_GULIMCHE,12, 255,255,255,255, 1, 255,0,0,255);

	----------------
	-- ���󼳸� --
	winMgr:getWindow("CM_RewardDescText"):clearTextExtends()
	winMgr:getWindow("CM_RewardDescText"):addTextExtends(RewardDesc, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);

	--------------
	-- �����Ȳ --
	winMgr:getWindow("CM_CountText"):clearTextExtends()
	
	if Select_State == g_String_Complete then
		winMgr:getWindow("CM_CountText"):setAlign(8)
		winMgr:getWindow("CM_CountText"):setPosition(384, 114)
		winMgr:getWindow("CM_CountText"):addTextExtends(g_String_Complete, g_STRING_FONT_GULIMCHE,12, 16,100,255,255, 1, 230,230,230,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(true)
		winMgr:getWindow("CM_StampImage"):setTexture("Enabled", "UIData/guildmission.tga", 0, 123)
	elseif Select_State == g_String_NotPlaying then
		winMgr:getWindow("CM_CountText"):setAlign(8)
		winMgr:getWindow("CM_CountText"):setPosition(384, 114)
		winMgr:getWindow("CM_CountText"):addTextExtends(g_String_NotPlaying, g_STRING_FONT_GULIMCHE,12, 255,63,16,255, 1, 255,255,255,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(true)
		winMgr:getWindow("CM_StampImage"):setTexture("Enabled", "UIData/guildmission.tga", 0, 0)
	else
		winMgr:getWindow("CM_CountText"):setAlign(1)
		winMgr:getWindow("CM_CountText"):setPosition(375, 106)
		winMgr:getWindow("CM_CountText"):addTextExtends(CM_String_Present.." : "..CurrentCount, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
		winMgr:getWindow("CM_CountText"):addTextExtends("\n"..CM_String_Goal.." : "..TargetCount, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(false)
	end
end



--------------------------------------------------------------------
-- ���󿡴��� �ؽ�Ʈ ����
--------------------------------------------------------------------
function RewardInfoTextReturn(RewardIndex, RewardDesc)
	local RewardItemDesc = ""

	if RewardIndex == 1 then		--Īȣ
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, RewardDesc, 280)
	elseif RewardIndex == 2 then	-- ��ų��ȯ��
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText1, 280)
	elseif RewardIndex == 3 then	-- ����������
		RewardItemDesc = ""
	elseif RewardIndex == 4 then	-- ���� �ڽ���
		local TempString = PreCreateString_1025	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_8)
		
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, TempString, 280)
		--RewardItemDesc = "�����ϰ� �ڽ�Ƭ�� ���� �� �ֽ��ϴ�"
	elseif RewardIndex == 5 then	-- �׶�
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText2, 280)
	elseif RewardIndex == 6 then	-- ���� 
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText3, 280)
	elseif RewardIndex == 7 then	-- ����ġ
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText4, 280)
	elseif RewardIndex == 8 then	-- ����ġ
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText5, 280)
	end
	return RewardItemDesc
end












--------------------------------------------------------------------
-- ��Ʈ���� �����ؼ� ���ڸ� �̾Ƴ���.
--------------------------------------------------------------------
function StringFindReturnNumber(str, NumberCount)
	if NumberCount >= 4 then	-- 4�̻� �Ѿ�� �ȉ´�
		return;
	end
	local sStart, sEnd = string.find(str, "%_")
--	local nCount	= 0;
	if sStart ~= nil then
		local str2 = string.sub(str, sEnd+1)
		local subStart, subEnd = string.find(str2, "%_")
		if subStart ~= nil then
			local strNumber = string.sub(str2, 1, subStart-1)
			tCM_NumberTable[NumberCount] = tonumber(strNumber)
			StringFindReturnNumber(str2, NumberCount + 1)		-- �ٽ��ѹ� ȣ��
		else
			local strNumber = string.sub(str2, 1)
			tCM_NumberTable[NumberCount] = tonumber(strNumber)
		end
	end
end



--------------------------------------------------------------------
-- ������ ���� ���ڸ� ã�´�(�������ֱ� ���� ����� ����)
--------------------------------------------------------------------
function StringFind(str)
	local sStart, sEnd = string.find(str, "%_")
	local nCount	= 0;
	if sStart ~= nil then
		local str2 = string.sub(str, sEnd+1)
		nCount = nCount + StringFind(str2)		
	end
	return nCount + 1
end



--------------------------------------------------------------------
-- ��޿� ���� ��Ʈ ������ ����(���콺 �����ó� Ŭ���� ȿ���� �ֱ����ؼ�)
--------------------------------------------------------------------
function MouseEventTextSetting(str, bEnter)
	local fontSize	= 0;
	local stringSize = StringFind(str) - 1
	
	if stringSize == 1 then
		fontSize = 14
	elseif stringSize == 2 then
		fontSize = 113
	elseif stringSize == 3 then
		fontSize = 112
		if CEGUI.toRadioButton(winMgr:getWindow("TreeItemButton"..str)):isSelected() then
			return
		end
	end
	winMgr:getWindow("TreeItemText"..str):setFont(g_STRING_FONT_DODUM, fontSize)
	
	local CurrentState	= winMgr:getWindow("TreeItemText"..str):getUserString("TextStateIndex")
	
	if bEnter then
		winMgr:getWindow("TreeItemText"..str):setTextColor(255, 255, 255, 255)
	else
		winMgr:getWindow("TreeItemText"..str):setTextColor(g_CM_tFontColor[1][CurrentState], g_CM_tFontColor[2][CurrentState], g_CM_tFontColor[3][CurrentState], 255)
	end

end

--------------------------------------------------------------------
-- üũ�ڽ�(��͵� ���콺 �̺�Ʈ�� ȿ���� �ֱ����ؼ�)
--------------------------------------------------------------------
function MouseEventCheckBoxSetting(str, bEnter)
	local stringSize = StringFind(str) - 1
	if stringSize > 2 then
		return
	end
	
	if bEnter then
		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..str)):isSelected() then-- - no
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 377, 473)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 378, 432)
			end
		else
			if stringSize == 1 then	-- +
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 377, 453)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 378, 416)
			end
		end
	
	else
		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..str)):isSelected() then
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 357, 473)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 362, 432)
			end
		else
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 357, 453)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 362, 416)
			end
		end
		
	end
end


--------------------------------------------------------------------
-- �ڽ��� �ִ� ��ư�� �������(�̰� ȿ���� �ƴ϶� �̺�Ʈ)
--------------------------------------------------------------------
function CM_TreeClick(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");

	if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):isSelected() then
		CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):setSelected(false)
	else
		CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):setSelected(true)		
	end

end


--------------------------------------------------------------------
-- + - üũ�ڽ� �̺�Ʈ
--------------------------------------------------------------------
function TreeItemCheckBoxEvent(args)
	local MyWindow = CEGUI.toWindowEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	local stringSize = StringFind(WindowIndex) - 1

	if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):isSelected() then
		if stringSize == 1 then
			CM_ButtonEvent(WindowIndex, true, g_CM_tChildCount[tostring(WindowIndex)])			
		else
			CM_ButtonEvent(WindowIndex, true, STEP_COUNT)
		end
	else
		if stringSize == 1 then
			CM_ButtonEvent(WindowIndex, false, g_CM_tChildCount[tostring(WindowIndex)])			
		else
			CM_ButtonEvent(WindowIndex, false, STEP_COUNT)
		end
	end
end


--------------------------------------------------------------------
-- ��ư�������� �̺�Ʈ
--------------------------------------------------------------------
function CM_ButtonEvent(WinIndexStr, bSelect, childCount)
	local stringSize = StringFind(WinIndexStr) - 1

	if stringSize > 2 then
		return
	end
	if bSelect then
		for i = 1, childCount do
			if stringSize == 2 then
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WinIndexStr)):isSelected() then
					winMgr:getWindow("TreeItemButton"..WinIndexStr.."_"..tostring(i)):setVisible(true)
					g_CM_ItemCount = g_CM_ItemCount + 1
				end
			else
				winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(true)
				g_CM_ItemCount = g_CM_ItemCount + 1
				CM_ButtonEvent(WinIndexStr.."_"..tostring(i), true, 4)	
			end			
		end

	else
		for i = 1, childCount do
			if stringSize == 2 then
				winMgr:getWindow("TreeItemButton"..WinIndexStr.."_"..tostring(i)):setVisible(false)
				g_CM_ItemCount = g_CM_ItemCount - 1
			else				
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WinIndexStr.."_"..tostring(i))):isSelected() then
					winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(false)
					g_CM_ItemCount = g_CM_ItemCount - 1			
										
					CM_ButtonEvent(WinIndexStr.."_"..tostring(i), false,4)	
				else	
					winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(false)
					g_CM_ItemCount = g_CM_ItemCount - 1
									
				end
			end
			
		end
	end
	RefreshTreeWindow()
end


--------------------------------------------------------------------
-- Ʈ�� ������ �̺�Ʈ�� �߻��Ҷ����� ����, ��ư�� ��ġ, ��ũ�ѹٸ� ó�����ش�
--------------------------------------------------------------------
function RefreshTreeWindow()
	-- ������ ���������� ���� �̹��� ������ �ٸ���
	--winMgr:getWindow("TreeItemBack"..tostring(TopWindowIndex)):
	local BackSizeY	= ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount) + BOTTOM_OFFSET
--	winMgr:getWindow("CM_TreeBackWindow"):setSize(261, BackSizeY)
	
	ButtonEventtoScreen()	-- �������� ������� ���̸� ä���ֱ����ؼ� ��ġ�� �ٽ� ��´�.
	
	-- �̹��� ����� �°� ��ũ�ѹ� ó��.(�Լ���)
	if BackSizeY > 383 then
		-- ��ũ�ѹ� ��Ÿ����ó��	
		winMgr:getWindow("CM_ScrollBar"):setVisible(true)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setDocumentSize(BackSizeY)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setPageSize(383)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setStepSize(20)
--		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(0);
	else
		-- ��ũ�ѹ� ���ش�.
		winMgr:getWindow("CM_ScrollBar"):setVisible(false)
	end

end
 
  
--------------------------------------------------------------------
-- �������� ������� ���̸� ä���ֱ����ؼ� ��ġ�� �ٽ� ��´�.
--------------------------------------------------------------------
function ButtonEventtoScreen()
	
	local	Count	= 0
	local	Count2	= 0
	local	InvisibleCount	= OldScrollCount
	
	for i = 0, g_CM_TopWindowCount do

		if Count >= MAX_TREELINE then
			winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
		else
			if InvisibleCount ~= 0 then
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
				InvisibleCount = InvisibleCount - 1
			else
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
				Count	= Count + 1
			end
		end

		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i)):isSelected() then 
			for j = 1, g_CM_tChildCount["_"..i] do
			
				if Count >= MAX_TREELINE then
					winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
				else
					if InvisibleCount ~= 0 then
						InvisibleCount = InvisibleCount - 1
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
					else
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
						Count = Count + 1
					end
				end
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i.."_"..j)):isSelected() then 
					for k = 1, STEP_COUNT do
						if Count >= MAX_TREELINE then
							winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
						else
							if InvisibleCount ~= 0 then
								InvisibleCount = InvisibleCount - 1
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)

							else
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
								Count = Count + 1
								
							end
						end
					end
				
				end
			end
		end
	end
end



function CM_ScrollBarEvent(args)
	if winMgr:getWindow("ChallengeMissionWindow"):isVisible() then
	
		local pos			= CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window):getScrollPosition()
		-- ��ũ�ѹ� ��ġ�� ��ũ�ѵ������� �������� �ʾҴٸ� ����
		local FrontDisableCount = pos / 20
		if OldScrollCount == FrontDisableCount then
			return
		end
		
		OldScrollCount = FrontDisableCount
		
		local DisableCount	= 0
		local VisibleCount	= 0
		local IsVisible		= false;
		
		for i = 0, g_CM_TopWindowCount do
			if VisibleCount >= MAX_TREELINE then
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
						
			else
				if DisableCount < FrontDisableCount then
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
				elseif DisableCount == FrontDisableCount then
					VisibleCount = 0
					IsVisible = true
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
				else
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
				end
				DisableCount	= DisableCount + 1
				if IsVisible then
					VisibleCount	= VisibleCount + 1
				end
			end
			if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i)):isSelected() then
				for j = 1, g_CM_tChildCount["_"..i] do
				
					if VisibleCount >= MAX_TREELINE then
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
						
					else	
						if DisableCount < FrontDisableCount then
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
						elseif DisableCount == FrontDisableCount then
							VisibleCount = 0
							IsVisible = true
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
						else
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
						end
						DisableCount	= DisableCount + 1
						if IsVisible then
							VisibleCount	= VisibleCount + 1
						end
					end
						
					if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i.."_"..j)):isSelected() then
						for k = 1, STEP_COUNT do
							if VisibleCount >= MAX_TREELINE then
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
							else
								if DisableCount < FrontDisableCount then
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
								elseif DisableCount == FrontDisableCount then
									VisibleCount = 0
									IsVisible = true
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
								else
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))

								end
								DisableCount	= DisableCount + 1
								if IsVisible then
									VisibleCount	= VisibleCount + 1
								end
							end
						end
					end
				end
			end
		end
	end
end



--------------------------------------------------------------------
-- ç���� �̼� ���콺�� �̺�Ʈ
--------------------------------------------------------------------
function MouseWheelEvent(args)

	local Delta = CEGUI.toMouseEventArgs(args).wheelChange
	local pos	= CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):getScrollPosition()
	local Size	= CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):getDocumentSize()

	if Delta < 0 then
		pos = pos + 20	
		if pos > Size then
			pos = Size
		end
	else
		pos = pos - 20	
		if pos < 0 then
			pos = 0
		end

	end
	CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(pos);
end



--------------------------------------------------------------------
-- ç���� �̼� �����츦 �����Ѵ�.
--------------------------------------------------------------------
function CreateChallengeMission()
	Get_CMInfoCount();		-- ç���� �̼� ������ ����
end


--------------------------------------------------------------------
-- ç���� �̼��� �����ش�
--------------------------------------------------------------------
function ShowChallengeMission(bNPCClick)
	if bNPCClick then
		winMgr:getWindow("CM_TitleBar"):setVisible(false)			--Ÿ��Ʋ�� ���ֱ�
		--winMgr:getWindow("CM_CloseButton"):setVisible(false)		--��ư ���ֱ�
		--winMgr:getWindow("ChallengeMissionWindow"):setPosition(50, 72)
	else
		winMgr:getWindow("CM_TitleBar"):setVisible(true)			--Ÿ��Ʋ�� ����
		--winMgr:getWindow("CM_CloseButton"):setVisible(true)			--��ư ������
		--winMgr:getWindow("ChallengeMissionWindow"):setPosition((g_MAIN_WIN_SIZEX - 598) / 2, (g_MAIN_WIN_SIZEY - 460) / 2)
	end
	winMgr:getWindow("ChallengeMissionWindow"):setPosition((g_MAIN_WIN_SIZEX - 713) / 2, 80)
	root:addChildWindow(winMgr:getWindow("ChallengeMissionWindow"))
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(true)
	Show_CMInfo();

	-- ���ϵ带 �� �����ش�	
	for i = 0, 1 do
		for j = 1, g_CM_tChildCount["_"..i] do
			CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..tostring(i).."_"..j)):setSelected(false)
		end	
	end
	CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(0)
	CEGUI.toRadioButton(winMgr:getWindow("TreeItemButton_0_1_1")):setSelected(true)
end


--------------------------------------------------------------------
-- ç���� �̼�â�� �ݴ´�
--------------------------------------------------------------------
function CM_CloseButtonClick()
	if "village" == GetCurWindowName() then
		VirtualImageSetVisible(false)
		--TownNpcEscBtnClickEvent()
	end
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(false)
end


--------------------------------------------------------------------
-- ç�����̼� ���Ǿ����� ���ٶ�.
--------------------------------------------------------------------
function CM_CloseButtonClickButtonClick()
	if "village" == GetCurWindowName() then
		VirtualImageSetVisible(false)
		TownNpcEscBtnClickEvent()	
	end
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(false)
end





--------------------------------------------------------------------

-- ç���� �̼� ���� é�� �ȳ� �˾� ������

--------------------------------------------------------------------
--------------------------------------------------------------------
-- ç�����̼� �ȳ� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_NextInfoBack")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("CM_NextInfoBack", "CM_NextInfoClose")
RegistEnterEventInfo("CM_NextInfoBack", "CM_NextInfoClose")

--------------------------------------------------------------------
-- ���� �������� ����Ŀ�� �̹���, ��Ʈâ.
--------------------------------------------------------------------
tWinName	= {['protecterr'] = 0, 'CM_NextInfoImage', 'CM_NextInfoWin'}
tTexName	= {['protecterr'] = 0, 'UIData/jobchange3.tga', 'UIData/tutorial001.tga'}
tTextureX	= {['protecterr'] = 0,    0,     0  }
tTextureY	= {['protecterr'] = 0,    0,     0  }
tSizeX		= {['protecterr'] = 0,  550,    1024}
tSizeY		= {['protecterr'] = 0,  706,    229 }
tPosX		= {['protecterr'] = 0,   0,    0  }
tPosY		= {['protecterr'] = 0,   62,   	526 }

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", tTexName[i], 0, 0);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setVisible(true);
	mywindow:setAlwaysOnTop(true);
	mywindow:setZOrderingEnabled(true);
	winMgr:getWindow("CM_NextInfoBack"):addChildWindow(mywindow);
end



--------------------------------------------------------------------
-- �������� �ؽ�Ʈ �׸���.
--------------------------------------------------------------------
tWinName = {['protecterr'] = 0, "CM_NextInfoTextName", "CM_NextInfoTextDesc"}
tPosX	= {['protecterr'] = 0,	75,			205}
tPosY	= {['protecterr'] = 0,	48,			53}
tSizeX	= {['protecterr'] = 0,	150,		700}
tSizeY	= {['protecterr'] = 0,	30,			70}

for i = 1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setPosition(tPosX[i], 53);
	mywindow:setSize(tSizeX[i], tSizeY[i]);	
	mywindow:setAlign(0);	
	mywindow:setViewTextMode(i);
	mywindow:setLineSpacing(15);
	mywindow:setVisible(true);
	mywindow:setProperty("Disabled", "true")
	winMgr:getWindow("CM_NextInfoWin"):addChildWindow(mywindow);
end

--winMgr:getWindow("CM_NextInfoTextName"):clearTextExtends();
winMgr:getWindow("CM_NextInfoTextName"):setTextExtends(PreCreateString_1369.."  : ", g_STRING_FONT_DODUMCHE, 18, 255,255,0,255,   3, 0,0,0,255)
														--GetSStringInfo(LAN_LUA_WND_VILLAGE_1)
--------------------------------------------------------------------
-- ç���� �̼����� �˷��ִ� �˾� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_NextInfoCloseButton")

mywindow:setTexture("Normal", "UIData/Arcade_lobby.tga", 421, 308)
mywindow:setTexture("Hover", "UIData/Arcade_lobby.tga", 421, 360)
mywindow:setTexture("Pushed", "UIData/Arcade_lobby.tga", 421, 410)
mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 421, 308)

mywindow:setPosition(890, 150)
mywindow:setSize(103, 49)
mywindow:subscribeEvent("Clicked", "CM_NextInfoClose")
winMgr:getWindow("CM_NextInfoWin"):addChildWindow(mywindow)


-- ����Ŀ�� ���� �޼���
local NextInfoText = CM_String_RewardText6


--------------------------------------------------------------------

-- ç�����̼� �������� �Լ���

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �ݱ��ư
--------------------------------------------------------------------
function CM_NextInfoClose()
	local window = winMgr:getWindow("CM_NextInfoTextDesc")

	local Complete = CEGUI.toGUISheet(window):isCompleteViewText();
	
	if Complete then
		winMgr:getWindow("CM_NextInfoBack"):setVisible(false)
	else
		CEGUI.toGUISheet(window):setCompleteViewText(true);	
	end
end


--------------------------------------------------------------------
-- �����ش�
--------------------------------------------------------------------
function CM_NextInfoOpen()
	winMgr:getWindow("CM_NextInfoBack"):setVisible(true)
	local window = winMgr:getWindow("CM_NextInfoTextDesc")
	
	window:setVisible(true)
	CEGUI.toGUISheet(window):setTextViewDelayTime(11)
	window:clearTextExtends()
	window:addTextExtends(NextInfoText, g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   1, 0,0,0,255 );
end





--------------------------------------------------------------------

-- �̺�Ʈ �����˾�

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardAlpha")
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




RegistEscEventInfo("CM_EventRewardAlpha", "EventPopUpClose")
RegistEnterEventInfo("CM_EventRewardAlpha", "EventPopUpClose")

--------------------------------------------------------------------
-- �̺�Ʈ �����˾�
--------------------------------------------------------------------
local _1NUM_Y = 200
local _2NUM_Y = 310
local _3NUM_Y = 420
local _4NUM_Y = 534
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventReward_temp")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 674, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 674, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition((1024 / 2 - 350 / 2), (768 / 2 - _4NUM_Y / 2))
mywindow:setSize(350, _4NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventRewardAlpha"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardImg1")
mywindow:setTexture("Enabled", "UIData/other001.tga", 674, 0)
mywindow:setTexture("Disabled", "UIData/other001.tga", 674, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(350, _3NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventReward_temp"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardImg2")
mywindow:setTexture("Enabled", "UIData/other001.tga", 674, _3NUM_Y)
mywindow:setTexture("Disabled", "UIData/other001.tga", 674, _3NUM_Y)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, _3NUM_Y)
mywindow:setSize(350, _4NUM_Y-_3NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventReward_temp"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ�޴� ���� �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', "CM_EventLevelText");
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(10, 50);
mywindow:setSize(319, 20);
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)

-- ���� �̺�Ʈ �ӽ� �ؽ�Ʈ
mywindow = winMgr:createWindow('TaharezLook/StaticText', "CM_EventTempText");
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(10, 250)
mywindow:setSize(319, 20)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ ���� ����
--------------------------------------------------------------------
tEventBackPos	= { ["protecterr"]=0, 80, 195, 310 }
tTextName		= { ["protecterr"]=0, "EventReward_ItemNameText", "EventReward_ItemDescText" } 
tTextPosY		= { ["protecterr"]=0, 10, 34, 58 }

for i = 1, #tEventBackPos do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardBack"..tostring(i))
	--zeustw --other001.tga 363, 558 ��ǥ�� �̹����� �����Ƿ� invisible.tga�� ��ü
	--mywindow:setTexture("Enabled", "UIData/other001.tga", 363, 558)
	--mywindow:setTexture("Disabled", "UIData/other001.tga", 363, 558)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 363, 558)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 363, 558)
	--zeustw
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, tEventBackPos[i])
	mywindow:setSize(319, 109)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)
	
--------------------------------------------------------------------
-- �̺�Ʈ ��������� ����
--------------------------------------------------------------------
--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardItemBack"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, 6)
	mywindow:setSize(105, 98)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
--]]

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardItem"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 652)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(20, 36)
	mywindow:setSize(105, 98)
	mywindow:setScaleWidth(170)
	mywindow:setScaleHeight(170)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardPromotionIcon"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(26, 66)
	mywindow:setSize(87, 35)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardItem"..tostring(i)):addChildWindow(mywindow)
	
	
	
	for j = 1, #tTextName do
		mywindow = winMgr:createWindow('TaharezLook/StaticText', tTextName[j]..tostring(i));
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(94, tTextPosY[j]);
		mywindow:setSize(145, 20);
		mywindow:setZOrderingEnabled(true)	
		mywindow:setViewTextMode(1)
		if j == 2 then
			mywindow:setAlign(1)
		else
			mywindow:setAlign(8)
		end
		mywindow:setLineSpacing(2)
		winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
		
	end
end


--------------------------------------------------------------------
-- �̺�Ʈ�ȳ� �ؽ�Ʈ
--------------------------------------------------------------------
tEventPosY  = { ["protecterr"]=0, 5, 25 }
for i=1, #tEventPosY do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', 'CM_EventInfoText'..tostring(i));
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, tEventPosY[i]);
	mywindow:setSize(319, 20);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CM_EventRewardImg2"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �̺�Ʈ�˾�â �ݱ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_EventPopupCloseButton")
mywindow:setTexture("Normal", "UIData/other001.tga", 1, 903)
mywindow:setTexture("Hover", "UIData/other001.tga", 1, 933)
mywindow:setTexture("Pushed", "UIData/other001.tga", 1, 963)
mywindow:setTexture("PushedOff", "UIData/other001.tga", 1, 903)
mywindow:setPosition(125, 58)
mywindow:setSize(87, 30)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "EventPopUpClose")
winMgr:getWindow("CM_EventRewardImg2"):addChildWindow(mywindow)





--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupAlpha")
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
-- Esc, EnterŰ ������
--------------------------------------------------------------------
RegistEscEventInfo("CM_EventSubPopupAlpha", "GranEventClose")
RegistEnterEventInfo("CM_EventSubPopupAlpha", "GranEventClose")

--------------------------------------------------------------------
-- �̺�Ʈ �����˾�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopup")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("CM_EventSubPopupAlpha"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� Ÿ��Ʋ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupTitle")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 340, 896)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 340, 896)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_EventSubPopupButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 864, 485)
mywindow:setTexture("Hover", "UIData/popup001.tga", 864, 519)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 864, 553)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 864, 485)
mywindow:setPosition(133, 228)
mywindow:setSize(80, 34)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "GranEventClose")
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(37, 80)
mywindow:setSize(266, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "SecondEndRender");
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ������ ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardItemBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7, 6)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopupRewardBack"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ���� �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(98, 91)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopupRewardItemBack"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̺�Ʈ�޴� ���� �ؽ�Ʈ
--------------------------------------------------------------------
local tEventTextName	= { ["protecterr"]=0, "CM_ComboEventText", "CM_GranEventText"}
local tEventTextPosY	= { ["protecterr"]=0, 50, 197}

for i = 1, #tEventTextName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tEventTextName[i]);
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, tEventTextPosY[i]);
	mywindow:setSize(319, 20);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)
end	
	
	
	
--------------------------------------------------------------------

-- �̺�Ʈ �����˾� �Լ�

--------------------------------------------------------------------
tEventLevel  = { ["protecterr"]=0, 3, 6, 9 }
local g_money = 0;
local g_PopupVisible	= false
local g_EventCount	= -1



--------------------------------------------------------------------
-- �̺�Ʈâ �����ش�.
--------------------------------------------------------------------
function ShowEventPopup(itemName1, itemName2, itemName3, itemFileName1, itemFileName2, itemFileName3, 
				itemDesc1, itemDesc2, itemDesc3, style1, style2, style3, itemPeriod1, itemPeriod2, itemPeriod3, Money, count)
	
	--itemFileName1 = "UIData/ItemUIData/Item/NPC_Quest2.tga"
	--itemFileName2 = "UIData/ItemUIData/Item/NPC_Quest2.tga"
	
	local tItemPromotionTexX  = { ["protecterr"]=0, 0, 0}
	local tItemPromotionTexY  = { ["protecterr"]=0, 0, 0}
	local tItemStyle		  = { ["protecterr"]=0, 0, 0}

	g_EventCount = count	-- �̺�Ʈ (����5�� 5õ�׶� ǥ�����ֱ�����)
	g_money		= Money;
	root:addChildWindow(winMgr:getWindow("CM_EventRewardAlpha"))
	winMgr:getWindow("CM_EventRewardAlpha"):setVisible(true);
	winMgr:getWindow("CM_EventRewardAlpha"):clearControllerEvent("EventMotion1")
	winMgr:getWindow("CM_EventRewardAlpha"):addController("EventMotion", "EventMotion1", "alpha", "Sine_EaseIn", 0, 255, 3, true, false, 10);
	winMgr:getWindow("CM_EventRewardAlpha"):activeMotion("EventMotion1");
	
	local my_name, money, level, promotion, my_style, type, sp_point, hp_point, experience = GetMyInfo(true);
	local My_promotion	= GetSStringInfo(my_style)	-- ����
	
	-- ������ ���� �ʱ�ȭ
	for i = 1, 3 do
		winMgr:getWindow("CM_EventRewardItem"..tostring(i)):setTexture("Disabled", "UIData/invisible.tga", 0, 652)
	end
	winMgr:getWindow("CM_EventLevelText"):clearTextExtends();
	winMgr:getWindow("CM_EventInfoText1"):clearTextExtends();
	
	-- ī��Ʈ�� ����.
	--if count ~= 3 then	-- ����������
		if IsKoreanLanguage() then
			if count == 1 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("����� 3,6,9 �̺�Ʈ! [���� 3 �޼�]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 2 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("����� 3,6,9 �̺�Ʈ! [���� 6 �޼�]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 3 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("����� 3,6,9 �̺�Ʈ! [���� 9 �޼�]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 4 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("[�̺�Ʈ] ���� �پ��!!", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			else
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_1042, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);		-- �����մϴ�!
			end
		else
			if count == 5 then
				-- �±� �ű� ���� 15���� ����
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4351, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 6 then
				-- �±� �ű� ���� 1ȸ ����
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4349, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 7 then
				-- ���� ���� �ϴ� ����
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4349, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			end			
		end 
		
	if count == 7 then
		winMgr:getWindow("CM_EventInfoText1"):addTextExtends(PreCreateString_4350, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);	-- �̺�Ʈ �Ⱓ ���� 1�� 1ȸ ���� �մϴ�.
	else
		winMgr:getWindow("CM_EventInfoText1"):addTextExtends(CM_String_RewardGetMsg, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);	-- �����մϴ�! �̺�Ʈ ������ ȹ���ϼ̽��ϴ�.
	end
	--end
	--winMgr:getWindow("CM_EventInfoText2"):clearTextExtends();
	--winMgr:getWindow("CM_EventInfoText2"):addTextExtends("�� "..CM_String_RewardPresentBoxCurfirm, g_STRING_FONT_GULIM,13, 255,205,86,255, 0, 255,255,255,255);
	
	local ExpireTime = ""
	
	winMgr:getWindow("EventReward_ItemNameText1"):clearTextExtends();
	winMgr:getWindow("EventReward_ItemNameText2"):clearTextExtends();
	winMgr:getWindow("EventReward_ItemNameText3"):clearTextExtends();
	
	tItemStyle[1] = style1
	tItemStyle[2] = style2
	tItemStyle[3] = style3

	if itemName1 ~= "" then
	
		-- ������ �׷��ش�..
		winMgr:getWindow("CM_EventRewardItem1"):setTexture("Disabled", itemFileName1, 0, 0)
		
		if itemPeriod1 == 0 then
			ExpireTime = "("..CM_String_UntilDelete..")"
		else
			ExpireTime = "("..tostring(itemPeriod1 / 24)..CM_String_Day..")"
		end
		
		if tItemStyle[1] >= 0 then
			local style		= tItemStyle[1] % 2
			local promotion = tItemStyle[1] / 2
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
			
			-- ��Ÿ�Ͽ����� �̸� ���� Ʋ���� ���ֱ� ����.
			if style == 0 then	--��Ʈ��Ʈ
				winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			else
				winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
			end
		else
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setVisible(false)
			winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
		end
	end

	-- 2��° ������
	if itemName2 == "" then
		if itemName3 == "" then
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _1NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _1NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(false)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(false)
		end
	else
		if itemName3 == "" then
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _2NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _2NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(false)
			
			---------------------------------
			-- 2��° ������ �׷��ش�..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem2"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem2"):setTexture("Disabled", itemFileName2, 0, 0)
			
			if itemPeriod2 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod2 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[2] >= 0 then
				local style		= tItemStyle[2] % 2
				local promotion = tItemStyle[2] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- ��Ÿ�Ͽ����� �̸� ���� Ʋ���� ���ֱ� ����.
				if style == 0 then	--��Ʈ��Ʈ
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
		else
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _3NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _3NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(true)
			
			---------------------------------
			-- 2��° ������ �׷��ش�..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem2"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem2"):setTexture("Disabled", itemFileName2, 0, 0)
			
			if itemPeriod2 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod2 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[2] >= 0 then
				local style		= tItemStyle[2] % 2
				local promotion = tItemStyle[2] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- ��Ÿ�Ͽ����� �̸� ���� Ʋ���� ���ֱ� ����.
				if style == 0 then	--��Ʈ��Ʈ
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
				
			---------------------------------
			-- 3��° ������ �׷��ش�..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem3"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem3"):setTexture("Disabled", itemFileName3, 0, 0)
			
			if itemPeriod3 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod3 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[3] >= 0 then
				local style		= tItemStyle[3] % 2
				local promotion = tItemStyle[3] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- ��Ÿ�Ͽ����� �̸� ���� Ʋ���� ���ֱ� ����.
				if style == 0 then	--��Ʈ��Ʈ
					winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
		end
	end
	
	local tDesc =  { ["protecterr"]=0, itemDesc1, itemDesc2, itemDesc3 }
	
	--Description �ɰ���
	for i=1, #tDesc do
		winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):clearTextExtends();
		
		if tDesc[i] ~= "" then
						
			local _DescStart, _DescEnd = string.find(tDesc[i], "%$");
			local _ItemSkillKind = "";		--��ų����
			local _ItemSkillDamage = "";	--��ų������
			local _ItemDetailDesc = "";		--��ų����
			
			if _DescStart ~= nil then
				_ItemSkillKind = string.sub(tDesc[i], 1, _DescStart - 1);
				_ItemDetailDesc = string.sub(tDesc[i], _DescEnd + 1);
			
				_DescStart, _DescEnd = string.find(_ItemDetailDesc, "%$");
				if _DescStart ~= nil then
					_ItemSkillDamage = string.sub(_ItemDetailDesc, 1, _DescStart - 1);
					_ItemDetailDesc = string.sub(_ItemDetailDesc, _DescEnd + 1);
				end
				_ItemDetailDesc = AdjustString(g_STRING_FONT_GULIM, 11, _ItemDetailDesc, 180)
				winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):addTextExtends(_ItemDetailDesc, g_STRING_FONT_DODUM,11, 255,205,86,255, 1, 0,0,0,255);
			else
				tDesc[i] = AdjustString(g_STRING_FONT_GULIM, 11, tDesc[i], 180)
				winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):addTextExtends(tDesc[i], g_STRING_FONT_DODUM,11, 255,205,86,255, 1, 30,30,30,255);
			end
		end
	end
end

winMgr:getWindow("CM_EventRewardBack2"):subscribeEvent("EndRender", "EventEndRender");

--------------------------------------------------------------------
-- �̺�Ʈâ ����.
--------------------------------------------------------------------
function EventEndRender()
	if g_PopupVisible then
		local drawer = winMgr:getWindow("CM_EventRewardBack2"):getDrawer()
		
		local _left = DrawEachNumber("UIData/other001.tga", g_money, 8, 185, 34, 11, 683, 24, 33, 25 , drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 32, 30, 29, 266, 685)
	end
end

--------------------------------------------------------------------
-- �̺�Ʈâ �ݱ�
--------------------------------------------------------------------
function EventPopUpClose()
	g_PopupVisible = false
	winMgr:getWindow("CM_EventRewardAlpha"):setVisible(false);
	winMgr:getWindow("CM_EventRewardAlpha"):clearControllerEvent("EventMotion1")
	EventDelete()
	EventPopupOpen()
	--if g_EventCount == 1 then
	--	GranEventOpen()
	--else
		CMRewardOKButtonEvent();
	--end
end

--------------------------------------------------------------------
-- �̺�Ʈ �˾� ���� �޼���
--------------------------------------------------------------------
function EventPopupOpen()
	if winMgr:getWindow("CM_RewardPopupAlpha"):isVisible() == false then
		GetEvent()
	end
end


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ����
--------------------------------------------------------------------
function GranEventOpen()
	g_PopupVisible = true
	winMgr:getWindow("CM_EventSubPopupAlpha"):setVisible(true)
	winMgr:getWindow("CM_EventSubPopupAlpha"):clearControllerEvent("SecondEventMotion")
	winMgr:getWindow("CM_EventSubPopupAlpha"):addController("EventMotion", "SecondEventMotion", "alpha", "Sine_EaseIn", 0, 255, 2, true, false, 10);
	winMgr:getWindow("CM_EventSubPopupAlpha"):activeMotion("SecondEventMotion");
	winMgr:getWindow("CM_ComboEventText"):clearTextExtends()
	winMgr:getWindow("CM_GranEventText"):clearTextExtends()
	
	winMgr:getWindow("CM_ComboEventText"):addTextExtends(PreCreateString_1042, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_GranEventText"):addTextExtends(CM_String_RewardGetMsg, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_EventSubPopupRewardImage"):setTexture("Enabled", "UIData/GameSlotItem001.tga", 392, 842)
	winMgr:getWindow("CM_EventSubPopupRewardImage"):setTexture("Disabled", "UIData/GameSlotItem001.tga", 392, 842)
	
end


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� �ݱ�
--------------------------------------------------------------------
function GranEventClose()
	g_PopupVisible = false
	winMgr:getWindow("CM_EventSubPopupAlpha"):setVisible(false)
	winMgr:getWindow("CM_EventSubPopupAlpha"):clearControllerEvent("SecondEventMotion")
	CMRewardOKButtonEvent();

end


--------------------------------------------------------------------
-- �̺�Ʈ �����˾� ����
--------------------------------------------------------------------
function SecondEndRender()
	if g_PopupVisible then
		local drawer = winMgr:getWindow("CM_EventSubPopupRewardBack"):getDrawer()
		
		local _left = DrawEachNumber("UIData/other001.tga", g_money, 8, 185, 34, 11, 683, 24, 33, 25 , drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 32, 30, 29, 266, 685)
	end

end



--------------------------------------------------------------------
-- ������ �̺�Ʈ
--------------------------------------------------------------------



