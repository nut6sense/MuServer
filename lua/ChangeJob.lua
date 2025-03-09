--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate()


--------------------------------------------------------------------
-- �������� �� ������.
--------------------------------------------------------------------
g_SelectPromotion	= 0;
g_Style				= 2;
g_CurrentState		= 0;
g_MissioningState	= 0;
g_tConditionCount	= {['protecterr']=0, 3, 1, 1}
local CompleatMission	= false;
local JOBCHANGE_LEVEL	= 10

-- ���� ���� ���� ǥ�� �� �׸�
local g_SumoTermsTextColorRed = { 255, 128, 128 }
local g_SumoTermsTextColorBlue = { 128, 255, 255 }
local g_SumoTermsTextColor = { g_SumoTermsTextColorRed, g_SumoTermsTextColorBlue }

-- ���� ���� ���� ���� ����
local Sumo_Result			= -1
local Sumo_Success			= 0
local Sumo_Fail				= 1
local Sumo_Rush_Success		= 2
local Sumo_Street_Success	= 3

local Sumo_Item = 0

--------------------------------------------------------------------

-- ����â ����

--------------------------------------------------------------------
-- ���� �˾� �����̹���
changejobbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MainImage")
changejobbackwindow:setTexture("Enabled", "UIData/jobchange.tga", 0, 0)		
changejobbackwindow:setTexture("Disabled", "UIData/jobchange.tga", 0, 0)
changejobbackwindow:setWideType(6);
changejobbackwindow:setPosition(250, 30)
changejobbackwindow:setSize(523, 541)
changejobbackwindow:setVisible(false)
changejobbackwindow:setAlwaysOnTop(true)
changejobbackwindow:setZOrderingEnabled(true)
root:addChildWindow(changejobbackwindow)

RegistEscEventInfo("CJ_MainImage", "CloseChangeJob")


--------------------------------------------------------------------
-- NPC ���� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CJ_MainImage_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(496, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseChangeJobBtnEvent")
changejobbackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��Ʈ��Ʈ, ���� �������� ������ư
--------------------------------------------------------------------
tJobName = {['protecterr']=0,	"Button_TaeKwonDo",		"Button_Boxing",	"Button_MuayThai",	"Button_Capoera",
								"Button_ProWrestling",	"Button_Judo",		"Button_Hapgido",	"Button_Sambo",  
								"Button_Sumo",			"Button_KungFu" }
								
tJobWinTable = {['protecterr']=0, }

tJobTexX = {['protecterr']=0, 		498,	581,	664,	747,
									0,		83,		166,	249, 
									332,	498 } -- ����, ��Ǫ
									
tJobPosX = {['protecterr']=0, 		14,		97,		180,	263,
									14,		97,		180,	263, 
									346,	14 } -- ����, ůǪ
									
for i = 1, #tJobName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tJobName[i])
	tJobWinTable[i]	= mywindow
	mywindow:setTexture("Normal",			"UIData/jobchange2.tga", tJobTexX[i], 0)
	mywindow:setTexture("Hover",			"UIData/jobchange2.tga", tJobTexX[i], 236)
	mywindow:setTexture("Pushed",			"UIData/jobchange2.tga", tJobTexX[i], 472)
	mywindow:setTexture("SelectedNormal",	"UIData/jobchange2.tga", tJobTexX[i], 472)
	mywindow:setTexture("SelectedHover",	"UIData/jobchange2.tga", tJobTexX[i], 472)
	mywindow:setTexture("SelectedPushed",	"UIData/jobchange2.tga", tJobTexX[i], 472)
	mywindow:setTexture("Enabled",			"UIData/jobchange2.tga", tJobTexX[i], 0)
	mywindow:setTexture("Disabled",			"UIData/invisible.tga" , 0, 0)
	mywindow:setPosition(tJobPosX[i], 54)
	mywindow:setProperty("GroupID", 3111)
	mywindow:setSize(83, 236)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", "JobRadioBtEvent")
	
	if i == 9 then
		mywindow:subscribeEvent("MouseEnter", "SumoTermsPopUpOpen")
		mywindow:subscribeEvent("MouseLeave", "SumoTermsPopUpClose")
	end
	
	changejobbackwindow:addChildWindow(mywindow)
end


function SetChangeClass()

	if	CheckfacilityData(FACILITYCODE_CC_TAEKWONDO)	== 1 then	winMgr:getWindow("Button_TaeKwonDo"):setEnabled(true)		end
	if	CheckfacilityData(FACILITYCODE_CC_BOXING)		== 1 then	winMgr:getWindow("Button_Boxing"):setEnabled(true)			end
	if	CheckfacilityData(FACILITYCODE_CC_MUAYTHAI)		== 1 then	winMgr:getWindow("Button_MuayThai"):setEnabled(true)		end
	if	CheckfacilityData(FACILITYCODE_CC_CAPOEIRA)		== 1 then	winMgr:getWindow("Button_Capoera"):setEnabled(true)			end
	if	CheckfacilityData(FACILITYCODE_CC_PROWRESTLING)	== 1 then	winMgr:getWindow("Button_ProWrestling"):setEnabled(true)	end
	if	CheckfacilityData(FACILITYCODE_CC_JUDO)			== 1 then	winMgr:getWindow("Button_Judo"):setEnabled(true)			end
	if	CheckfacilityData(FACILITYCODE_CC_HAPKIDO)		== 1 then	winMgr:getWindow("Button_Hapgido"):setEnabled(true)			end
	if	CheckfacilityData(FACILITYCODE_CC_SAMBO)		== 1 then	winMgr:getWindow("Button_Sambo"):setEnabled(true)			end
	if	CheckfacilityData(FACILITYCODE_CC_KUNGFU)		== 1 then	winMgr:getWindow("Button_KungFu"):setEnabled(true)			end
	
	-- �ѱ����� ���� ����
	if IsKoreanLanguage() then	
		winMgr:getWindow("Button_Sumo"):setEnabled(true) 
	end
end
SetChangeClass()


--------------------------------------------------------------------
-- ���� ������ ���� ���� �̹���.
--------------------------------------------------------------------
--tJobSelectInfoName= {['protecterr']=0,	"�±ǵ�����",		"��������", "����Ÿ������", "ī����������" 
										--	"���η���������",	"��������", "�ձ⵵����",	"�ﺸ����"}
										
tJobSelectInfoTexX	= {['protecterr']=0, 	529,	529,	529,	529,
											773,	773,	773,	773,	
											773,	773 } -- ����, ��Ǫ
											
tJobSelectInfoTexY	= {['protecterr']=0, 	0,		178,	178*2,	178*3,
											0,		178,	178*2,	178*3,  
											178*4,	178*4 }  -- ����, ��Ǫ

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PromotionInfo")
mywindow:setTexture("Enabled",	"UIData/jobchange.tga", 244, 812)
mywindow:setTexture("Disabled", "UIData/jobchange.tga", 244, 812)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(13, 304)
mywindow:setSize(244, 178)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
changejobbackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �����̼� �ޱ�, �����ϱ��ư �̺�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MissionStartButton")
mywindow:setTexture("Normal", "UIData/jobchange2.tga", 27, 713)
mywindow:setTexture("Hover", "UIData/jobchange2.tga", 27, 747)
mywindow:setTexture("Pushed", "UIData/jobchange2.tga", 27, 781)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 27, 781)
mywindow:setPosition(205, 500)
mywindow:setSize(114, 32)
mywindow:subscribeEvent("Clicked", "GetMissionBtEvent")
changejobbackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �̼Ǵܰ迡���� �� �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MissionInfoImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 237, 713)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 237, 713)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(258, 306)
mywindow:setSize(250, 179)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
changejobbackwindow:addChildWindow(mywindow)
	

--------------------------------------------------------------------
-- ���� �̼� ���� �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ChangeJobInfoText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(14, 45)
mywindow:setSize(235, 30)
mywindow:setZOrderingEnabled(false)	
mywindow:setViewTextMode(1)
mywindow:setAlign(1)
mywindow:setLineSpacing(4)
winMgr:getWindow("CJ_MissionInfoImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ���� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SumoRockImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 913, 0)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 913, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(83, 236)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "SumoTermsPopUpOpen")
mywindow:subscribeEvent("MouseLeave", "SumoTermsPopUpClose")
winMgr:getWindow("Button_Sumo"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SumoTermsBackImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 793, 896)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 793, 896)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(90, -30)
mywindow:setSize(200, 125)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SumoRockImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SumoTermsOneImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 393, 926)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 393, 926)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 27)
mywindow:setSize(200, 36)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SumoTermsBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SumoTermsTwoImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 393, 962)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 393, 962)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 65)
mywindow:setSize(200, 17)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SumoTermsBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SumoTermsThreeImage")
mywindow:setTexture("Enabled", "UIData/jobchange2.tga", 593, 979)
mywindow:setTexture("Disabled", "UIData/jobchange2.tga", 593, 979)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 85)
mywindow:setSize(200, 42)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SumoTermsBackImage"):addChildWindow(mywindow)





--------------------------------------------------------------------

-- ���� Ŭ���� ����

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �������� ���� ��ư �̺�Ʈ
--------------------------------------------------------------------
local g_oldSelectIndex = 0
local g_curSelectIndex = 0

-- ���� ���� ���� ��� �� ����
function SetSumoTermsResult(Result, ItemResult)
	Sumo_Result = Result
	Sumo_Item	= ItemResult
	
	local Success = 0
	
	if Sumo_Result == Sumo_Success then
		Success = Success + 1
	end
	
	if Sumo_Item == 1 then
		Success = Success + 1
	end

	if Success == 2 then
		winMgr:getWindow("SumoRockImage"):setVisible(false)
	else
		winMgr:getWindow("SumoRockImage"):setVisible(true)
	end
end

function SumoTermsPopUpOpen(args)
	winMgr:getWindow("SumoTermsBackImage"):setVisible(true)
	
	if Sumo_Result == Sumo_Success then
		winMgr:getWindow("SumoTermsOneImage"):setTexture("Enabled", "UIData/jobchange2.tga", 593, 926)
		winMgr:getWindow("SumoTermsOneImage"):setTexture("Disabled", "UIData/jobchange2.tga", 593, 926)
	else
		winMgr:getWindow("SumoTermsOneImage"):setTexture("Enabled", "UIData/jobchange2.tga", 393, 926)
		winMgr:getWindow("SumoTermsOneImage"):setTexture("Disabled", "UIData/jobchange2.tga", 393, 926)
	end
	
	if Sumo_Item == 1 then
		winMgr:getWindow("SumoTermsTwoImage"):setTexture("Enabled", "UIData/jobchange2.tga", 593, 962)
		winMgr:getWindow("SumoTermsTwoImage"):setTexture("Disabled", "UIData/jobchange2.tga", 593, 962)
	else
		winMgr:getWindow("SumoTermsTwoImage"):setTexture("Enabled", "UIData/jobchange2.tga", 393, 962)
		winMgr:getWindow("SumoTermsTwoImage"):setTexture("Disabled", "UIData/jobchange2.tga", 393, 962)
	end
end

function SumoTermsPopUpClose(args)
	winMgr:getWindow("SumoTermsBackImage"):setVisible(false)
end


function JobRadioBtEvent(args)

	-- ���õ� ���� true
	for i = 1, #tJobName do
		if CEGUI.toRadioButton(winMgr:getWindow(tJobName[i])):isSelected() then
			
			-- 2������ ����
			g_curSelectIndex = i	
					
			if g_oldSelectIndex ~= g_curSelectIndex then
				
				g_oldSelectIndex = g_curSelectIndex
			
				-- ������ ���� ���� �̹����� �ٲ��ش�.
				winMgr:getWindow("PromotionInfo"):setTexture("Enabled", "UIData/jobchange.tga", tJobSelectInfoTexX[i], tJobSelectInfoTexY[i])
				winMgr:getWindow("PromotionInfo"):setTexture("Disabled", "UIData/jobchange.tga", tJobSelectInfoTexX[i], tJobSelectInfoTexY[i])
				
				-- �̼ǳ����� ���������� �����ش�.
				local String	= tChangeJobMissionString[i].." "..PreCreateString_1079
				winMgr:getWindow("ChangeJobInfoText"):clearTextExtends()
				winMgr:getWindow("ChangeJobInfoText"):addTextExtends(String, g_STRING_FONT_DODUM,14, 100,70,143,255, 1, 255,255,255,255);

				g_CurrentState = 1	-- ���� ������ ���Ǿ� ��ȭ�� ����
				
				if		i == 1 then		g_SelectPromotion = 1	-- �±ǵ�
				elseif	i == 2 then		g_SelectPromotion = 2	-- ����
				elseif	i == 3 then		g_SelectPromotion = 4	-- ����Ÿ��
				elseif	i == 4 then		g_SelectPromotion = 3	-- ī������
				elseif	i == 5 then		g_SelectPromotion = 2	-- ���η�����
				elseif	i == 6 then		g_SelectPromotion = 1	-- ����
				elseif	i == 7 then		g_SelectPromotion = 3	-- �ձ⵵
				elseif	i == 8 then		g_SelectPromotion = 4	-- �ﺸ
				elseif  i == 9 then		g_SelectPromotion = 6   -- ����
				elseif  i == 10 then	g_SelectPromotion = 7   -- ��Ǫ
				end
				
				-------------------------
				-- NPC TYPE�� �־��ش�.
				-------------------------
				ShowNPCMent(4)
			end
		end
	end
end



--------------------------------------------------------------------
-- �̼ǹޱ��ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function GetMissionBtEvent()
	
	-- ���� ������ ���� ������ ���ǿ� ���� ���� ������ ���� �Ѵ�.
	if CEGUI.toRadioButton(winMgr:getWindow("Button_Sumo")):isSelected() then
		if Sumo_Item < 1 then
			ShowNotifyOKMessage_Lua("������ ���� ���� �ʽ��ϴ�.")
			return
		end
		
		if Sumo_Result > Sumo_Success then
			ShowNotifyOKMessage_Lua("������ ���� ���� �ʽ��ϴ�.")
			return
		end 
	end
	
	for i = 1, #tJobName do
		if CEGUI.toRadioButton(winMgr:getWindow(tJobName[i])):isSelected() then
			JobChangeMissionStart(g_SelectPromotion)
			return
		end
	end
	ShowNotifyOKMessage_Lua(PreCreateString_1080)
end


--------------------------------------------------------------------
-- ��� �������� �ʱ�ȭ �����ش�
--------------------------------------------------------------------
function AllResetInfo()
	
	-- ��� ������ư�� select false�� ������ش�.
	for i = 1, #tJobName do
		CEGUI.toRadioButton(winMgr:getWindow(tJobName[i])):setSelected(false)
	end
	
	g_CurrentState	= 0
	
	-- ���� ������ ���� ���� ?ǥ��
	winMgr:getWindow("PromotionInfo"):setTexture("Enabled", "UIData/jobchange.tga", 244, 812)
	winMgr:getWindow("PromotionInfo"):setTexture("Disabled", "UIData/jobchange.tga", 244, 812)
	winMgr:getWindow("ChangeJobInfoText"):clearTextExtends()
	winMgr:getWindow("ChangeJobInfoText"):addTextExtends("[!]", g_STRING_FONT_DODUM,14, 255,25,84,255, 1, 30,30,30,255);
	winMgr:getWindow("ChangeJobInfoText"):addTextExtends(" "..PreCreateString_1081, g_STRING_FONT_DODUM,14, 100,255,204,255, 1, 30,30,30,255);
end



--------------------------------------------------------------------
-- ����â ����ش�
--------------------------------------------------------------------
function ShowMissionInfo()
	-- ���� ������ �˾Ƴ���.
	local Name_str, nLevel, nPromotion, MyStyle_str = GetMyJobChangeInfo();

	-- ������ �� ���¸� �������ش�.
	if nPromotion ~= 0 or nLevel < JOBCHANGE_LEVEL then
		ShowTownNpcTelling()
		return;
	end
		
	if		MyStyle_str == 'chr_strike' then	g_Style = 1		--��Ʈ��Ʈ�϶�
	elseif	MyStyle_str == 'chr_grab' then		g_Style = 2		--�����϶�	
	end
	
	-- ������ư�� ������ �°� �����ְ� �����ش�.
	local CLASS_NUM = 4	-- ��Ʈ��Ʈ �� ������ Ŭ���� ����(���� 4��)
	for i = 1, #tJobName do
		if g_Style == (((i-1) / CLASS_NUM)+1) then		-- ��Ʈ��Ʈ �迭�̶��
			winMgr:getWindow(tJobName[i]):setVisible(true)
		else
			winMgr:getWindow(tJobName[i]):setVisible(false)
		end		
	end
	
	-- ������ ��� ���� ó�� ���ش�
	winMgr:getWindow("Button_Sumo"):setVisible(true)
	
	-- ��� �������� �ʱ�ȭ �����ش�.
	AllResetInfo()
	
	-- ����â�� ����ش�.
	winMgr:getWindow("CJ_MainImage"):setVisible(true);
	winMgr:getWindow("CJ_MainImage"):setZOrderingEnabled(true);
	root:addChildWindow(winMgr:getWindow("CJ_MainImage"));
	
	-- ���� ���ǿ� �´��� Ȯ�� �ϴ� ������ ������.
	SumoChangeClassTerms()
	
end

--------------------------------------------------------------------
-- ����â�� �ݾ��ش�. 
--------------------------------------------------------------------
function CloseChangeJob()
	-- ������ �Ϸ��� ���� â�� ������ �̺�Ʈ�޼����� �����ֱ� ���ؼ�(������ų ü��� ������).
	if CompleatMission then

	end
	VirtualImageSetVisible(false)
	winMgr:getWindow("CJ_MainImage"):setVisible(false)
end


function CloseChangeJobBtnEvent()
	VirtualImageSetVisible(false)
	winMgr:getWindow("CJ_MainImage"):setVisible(false)
	TownNpcEscBtnClickEvent()
end


--------------------------------------------------------------------

-- ���� ��Ƽ �˾�

--------------------------------------------------------------------
--------------------------------------------------------------------
-- ���� ����
--------------------------------------------------------------------



--------------------------------------------------------------------
-- ������ �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_NotifyPopupBack")
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


RegistEscEventInfo("CJ_NotifyPopupBack", "jobchangeNotifyclose")

--------------------------------------------------------------------
-- ������Ʈ �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_NPCImage")
mywindow:setTexture("Enabled", "UIData/jobchange3.tga", 0, 0)		
mywindow:setTexture("Disabled", "UIData/jobchange3.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0, 62)
mywindow:setSize(550, 706)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_NotifyPopupBack"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ����� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapContainer")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition(487, 84)
mywindow:setSize(733, 625)
mywindow:setScaleWidth(185)
mywindow:setScaleHeight(185)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_NotifyPopupBack"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��ȭâ �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_NotifyComunicateImage")
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0, 540)
mywindow:setSize(1024, 228)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_NotifyPopupBack"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ����� ���� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapMainImg")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 50, 50)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 50, 50)
mywindow:setPosition(26, 68)
mywindow:setSize(681, 532)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:setSubscribeEvent('EndRender', 'MaxMap_EndRender');
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ����� ���� �� 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapBar_Top")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 287, 929)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 287, 929)
mywindow:setPosition(25, 0)
mywindow:setSize(683, 69)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ����� ���� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapInfomation")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 781, 0)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 781, 0)
mywindow:setPosition(30, 50)
mywindow:setSize(96, 200)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ���� �̸�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapTownName")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 877, 0)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 877, 0)
mywindow:setPosition(297, 28)
mywindow:setSize(139, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ����� ���� ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapBar_Left")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 970, 419)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 970, 419)
mywindow:setPosition(0, 20)
mywindow:setSize(27, 605)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ����� ������ ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapBar_Right")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 997, 419)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 997, 419)
mywindow:setPosition(706, 20)
mywindow:setSize(27, 605)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ����� �Ʒ� ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapBar_Bottom")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 287, 998)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 287, 998)
mywindow:setPosition(25, 599)
mywindow:setSize(683, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CJ_MaxMapNotifyPos")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 877, 126)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 877, 126)
mywindow:setPosition(409, 425)
mywindow:setSize(49, 49)
mywindow:setScaleWidth(185)
mywindow:setScaleHeight(185)
mywindow:setAlign(8)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "xscale", "Sine_EaseIn", 1000, 200, 2, true, true, 10)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "yscale", "Sine_EaseIn", 1000, 200, 2, true, true, 10)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "xscale", "Sine_EaseIn", 200, 1000, 8, true, true, 10)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "yscale", "Sine_EaseIn", 200, 1000, 8, true, true, 10)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "alpha", "Sine_EaseIn", 255, 120, 2, true, true, 10)
mywindow:addController("MaxMapNotifyPos", "MaxMapNotifyPos_Event", "alpha", "Sine_EaseIn", 120, 255, 8, true, true, 10)
winMgr:getWindow("CJ_MaxMapContainer"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ��ȭ���� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CJ_NotifyCloseBtn")

mywindow:setTexture("Normal", "UIData/Arcade_lobby.tga", 421, 308)
mywindow:setTexture("Hover", "UIData/Arcade_lobby.tga", 421, 360)
mywindow:setTexture("Pushed", "UIData/Arcade_lobby.tga", 421, 410)
mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 421, 308)

mywindow:setPosition(890, 150)
mywindow:setSize(103, 49)
mywindow:subscribeEvent("Clicked", "jobchangeNotifyclose")
winMgr:getWindow("CJ_NotifyComunicateImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ������Ʈ �ؽ�Ʈ ����ֱ� 2��(���Ǿ� �̸�, ��ȭ ����)
--------------------------------------------------------------------
local tjobchangeNotifyTextName	= {['protecterr']=0, "CJ_NameText", "CJ_ComunicateText"}
local tjobchangeNotifyTexPosX	= {['protecterr']=0,	54,			205}
local tjobchangeNotifyTexSizeX	= {['protecterr']=0,	150,		700}
local tjobchangeNotifyTexSizeY	= {['protecterr']=0,	30,			70}

for i = 1, #tjobchangeNotifyTextName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tjobchangeNotifyTextName[i]);
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tjobchangeNotifyTexPosX[i], 70);
	mywindow:setSize(tjobchangeNotifyTexSizeX[i], tjobchangeNotifyTexSizeY[i]);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(15)
	winMgr:getWindow("CJ_NotifyComunicateImage"):addChildWindow(mywindow)
end


winMgr:getWindow("CJ_NameText"):setTextExtends(PreCreateString_1372.."  : ", g_STRING_FONT_DODUMCHE, 20, 255,255,0,255,   3, 0,0,0,255)
winMgr:getWindow("CJ_ComunicateText"):setTextExtends(PreCreateString_1082, g_STRING_FONT_DODUMCHE, 18, 255,255,255,255,   3, 0,0,0,255)


--------------------------------------------------------------------
-- ���� ��Ƽ �˾� ���� �̺�Ʈ
--------------------------------------------------------------------
function JobChangeNotifyOpen()
	local promotion = GetMyPromotionIndex()
	if promotion > 0 then
		winMgr:getWindow("CJ_NotifyPopupBack"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("CJ_NotifyPopupBack"))
		winMgr:getWindow("CJ_MaxMapNotifyPos"):activeMotion("MaxMapNotifyPos_Event")
	end
end


--------------------------------------------------------------------
-- ���� ��Ƽ �˾� �ݱ� ��ư �̺�Ʈ
--------------------------------------------------------------------
function jobchangeNotifyclose()

	winMgr:getWindow("CJ_NotifyPopupBack"):setVisible(false)
	winMgr:getWindow("CJ_MaxMapNotifyPos"):clearActiveController()
end
--winMgr:getWindow("CJ_NotifyPopupBack"):addController("ChangeClassController", "Shown", "alpha", "Sine_EaseIn", 1, 20, 1, true, false, 10);
--winMgr:getWindow("CJ_NotifyPopupBack"):addController("ChangeClassController", "Shown", "alpha", "Sine_EaseIn", 20, 255, 12, true, false, 10);



