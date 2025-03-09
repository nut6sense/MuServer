--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate()

bResolutionButtonClick = false
bLanguageButtonClick = false

--------------------------------------------------------------------

-- �������� �� ����

--------------------------------------------------------------------
-- ������ �ػ� ������ ���̺� 
--local WindowSizeTable = {['protecterr'] = 0 
MAXRESOLUTIONCOUNT = 12

-- �⺻ ��ũ�� ���̺�
local tBaseMacroTable = {['protecterr'] = 0 
	,[1] = PreCreateString_1268
	,[2] = PreCreateString_1269
	,[3] = PreCreateString_1270
	,[4] = PreCreateString_1271
	}
-- ���� ��ũ�� ���̺�
local tCurrentMacroTable = {['protecterr'] = 0, "","","",""}

-- �ɼ� ���� ���̺�
local tOptionInfoTable = {['protecterr'] = 0 
		,[0]	= true	-- �ܰ���
		,[1]	= 2		-- ��Ƽ���ø�
		,[2]	= 0		-- ȭ����
		,[3]	= true	-- ������ ���(��ü, â���)
		,[4]	= false	-- BGM Mute
		,[5]	= false	-- ȿ���� Mute
		,[6]	= 0		-- BGM ��������
		,[7]	= 0		-- ȿ���� ��������
		,[8]	= true	-- �����ʴ� ����
		,[9]	= true	-- ��Ƽ�ʴ� ����
		,[10]	= true	-- �ӼӸ� ����
		,[11]	= false	-- ģ���ʴ� ����
		,[12]	= false	-- �ŷ�
		}

local	bShowOptionCheck	= false

--------------------------------------------------------------------

-- �ɼ� �������

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �ɼ� ���� �̹���
--------------------------------------------------------------------
optionbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_MainBackImg")
optionbackwindow:setTexture("Enabled", "UIData/invisible.tga", 700, 200)		--�����
optionbackwindow:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
optionbackwindow:setProperty("FrameEnabled", "False")
optionbackwindow:setProperty("BackgroundEnabled", "False")
optionbackwindow:setWideType(6);
optionbackwindow:setPosition(360, 160)
optionbackwindow:setSize(360, 535)
optionbackwindow:setVisible(false)
optionbackwindow:setAlwaysOnTop(true)
optionbackwindow:setZOrderingEnabled(true)
root:addChildWindow(optionbackwindow)


-------------------------------------------------------------------
-- �ɼ� �����̹��� ESCŰ, ENTERŰ ���
-------------------------------------------------------------------
RegistEscEventInfo("Option_MainBackImg", "CancleButton")
RegistEnterEventInfo("Option_MainBackImg", "OKButton")


-------------------------------------------------------------------
-- �ɼ� Ÿ��Ʋ �̹���
-------------------------------------------------------------------
--optiontopwindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_TitleImg")
--optiontopwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 815)
--optiontopwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 815)
--optiontopwindow:setProperty("FrameEnabled", "False")
--optiontopwindow:setProperty("BackgroundEnabled", "False")
--optiontopwindow:setPosition(0, 1)
--optiontopwindow:setSize(340, 41)
--optiontopwindow:setVisible(true)
--optiontopwindow:setAlwaysOnTop(true)
--optiontopwindow:setZOrderingEnabled(false)
--optionbackwindow:addChildWindow(optiontopwindow)


-------------------------------------------------------------------
-- �ɼ� �߰� �̹���
-------------------------------------------------------------------
optionmiddlewindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_MiddleImg")
optionmiddlewindow:setTexture("Enabled", "UIData/option2.tga", 0, 0)
optionmiddlewindow:setTexture("Disabled", "UIData/option2.tga", 0, 0)
optionmiddlewindow:setProperty("FrameEnabled", "False")
optionmiddlewindow:setProperty("BackgroundEnabled", "False")
optionmiddlewindow:setPosition(0, 1)
--optionmiddlewindow:setSize(360, 407)--�ɼ�â �̻��ϰ� ©���� ���� ����
optionmiddlewindow:setSize(360, 535)
optionmiddlewindow:setVisible(true)
optionmiddlewindow:setAlwaysOnTop(false)
optionmiddlewindow:setZOrderingEnabled(false)
optionbackwindow:addChildWindow(optionmiddlewindow)


-------------------------------------------------------------------
-- �ɼ� �Ʒ� �̹���
-------------------------------------------------------------------
--optionbottomwindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_BottomImg")
--optionbottomwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 222)
--optionbottomwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 222)
--optionbottomwindow:setProperty("FrameEnabled", "False")
--optionbottomwindow:setProperty("BackgroundEnabled", "False")
--optionbottomwindow:setPosition(0, 377)
--optionbottomwindow:setSize(340, 53)
--optionbottomwindow:setVisible(true)
--optionbottomwindow:setAlwaysOnTop(true)
--optionbottomwindow:setZOrderingEnabled(false)
--optionbackwindow:addChildWindow(optionbottomwindow)


-------------------------------------------------------------------
-- �ɼ� Ÿ��Ʋ��(���콺 ���� �����̰� �ϱ�)
-------------------------------------------------------------------
titlebarwindow = winMgr:createWindow("TaharezLook/Titlebar", "Option_TitleImg")
titlebarwindow:setPosition(3, 1)
titlebarwindow:setSize(310, 40)
optionbackwindow:addChildWindow(titlebarwindow)



--------------------------------------------------------------------
-- �ɼ� System, Game �̹���
--------------------------------------------------------------------

local BackImageName = {['protecterr']=0, [0] = "Option_SystemImg", "Option_GameImg"}
local BackImageTexY	= {['protecterr']=0, [0] =	348, 0}
local BackImageSizeY	= {['protecterr']=0, [0] =	345, 345}

for i = 0, #BackImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", BackImageName[i])
	mywindow:setTexture("Enabled", "UIData/option2.tga", 659, BackImageTexY[i])
	mywindow:setTexture("Disabled", "UIData/option2.tga", 659, BackImageTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, 80)
    mywindow:setSize(337, BackImageSizeY[i])--�̰� �۾����� ��Ʈ���� ������ �ȵȴ�
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	optionmiddlewindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ɼ� System, Game �̹���(������ư)
--------------------------------------------------------------------
tOptionName		= {['protecterr']=0, [0]="Option_SystemButton", "Option_GameButton" }
tOptionTexX		= {['protecterr']=0, [0]=	364,	509 }
tOptionPosX		= {['protecterr']=0, [0]=	155,	  6 }
tOptionEvent	= {['protecterr']=0, [0]="ShowOptionSystem", "ShowOptionGame" }
for i=0, #tOptionName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tOptionName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", tOptionTexX[i], 72)
	mywindow:setTexture("Hover", "UIData/option2.tga", tOptionTexX[i], 36)
	mywindow:setTexture("Pushed", "UIData/option2.tga", tOptionTexX[i], 72)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", tOptionTexX[i], 0)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", tOptionTexX[i], 0)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", tOptionTexX[i], 0)	
	mywindow:setPosition(tOptionPosX[i], 41)
	mywindow:setProperty("GroupID", 3000)	--??
	mywindow:setSize(145, 36)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", tOptionEvent[i])
	mywindow:setEnabled(true)
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	optionmiddlewindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ػ� �޺��ڽ� ���� (���� ��ư, Text, ��Ӵٿ� �߻� ��ư)
--------------------------------------------------------------------
--���� �ػ� �ѷ���
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Option_CurrentScreen")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIM, 14)
mywindow:setText("1024 X 768")
mywindow:setPosition(195, 31)
mywindow:setSize(161, 23)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)

-------------------------------------------------------------------
-- �ػ� ���� �̹���
-------------------------------------------------------------------
Resolutionbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_ScreenBackImg")
Resolutionbackwindow:setTexture("Enabled", "UIData/invisible.tga", 700, 200)		--�����
Resolutionbackwindow:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
Resolutionbackwindow:setProperty("FrameEnabled", "False")
Resolutionbackwindow:setProperty("BackgroundEnabled", "False")
Resolutionbackwindow:setPosition(153, 54)
Resolutionbackwindow:setSize(161, 250)
Resolutionbackwindow:setVisible(false)
Resolutionbackwindow:setAlwaysOnTop(true)
Resolutionbackwindow:setZOrderingEnabled(false)
winMgr:getWindow("Option_SystemImg"):addChildWindow(Resolutionbackwindow)


-------------------------------------------------------------------
-- �ػ� �����̹���(������ư), �ȿ� �� ���� Text
-------------------------------------------------------------------
tResolutionitemName		= {['protecterr']=0, [0]= "ResolutionSize1","ResolutionSize2", "ResolutionSize3", "ResolutionSize4", "ResolutionSize5",
												 "ResolutionSize6", "ResolutionSize7", "ResolutionSize8", "ResolutionSize9", "ResolutionSize10",
												 "ResolutionSize11", "ResolutionSize12"}
tResolutionitemEvent	= {['protecterr']=0, [0]= "ChangeWindowSize" }

for i=0, #tResolutionitemName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tResolutionitemName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 364, 272)
	mywindow:setTexture("Hover", "UIData/option2.tga", 364, 292)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 364, 272)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 364, 272)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", 364, 272)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 364, 272)
	mywindow:setPosition(0, 0 + (i * 21))
	mywindow:setUserString("ResolutionWidth", 0)
	mywindow:setUserString("ResolutionHeight", 0)
	mywindow:setProperty("GroupID", 3010)	--??
	mywindow:setSize(170, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "ChangeWindowSize")
	if i == 0 then
		mywindow:setEnabled(true)							--������ �޾ƿ� ���õ� �ػ󵵸� Selected�������
	end
	Resolutionbackwindow:addChildWindow(mywindow)

	
	--Text	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ResolutionText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0, 0, 0, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setPosition(43, 0)
	mywindow:setSize(161, 20)
	mywindow:setProperty("Disabled", "true")
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tResolutionitemName[i]):addChildWindow(mywindow)
end


-------------------------------------------------------------------
--�ػ� ��Ӵٿ� �߻� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Option_ScreenDropDownBt")
mywindow:setTexture("Normal", "UIData/option2.tga", 634, 233)
mywindow:setTexture("Hover", "UIData/option2.tga", 634, 253)
mywindow:setTexture("Pushed", "UIData/option2.tga", 634, 273)
mywindow:setTexture("PushedOff", "UIData/option2.tga", 634, 293)
mywindow:setPosition(303, 34)
--mywindow:setEnabled(false)
mywindow:setSize(20, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ComboDropDownButton")
winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �ܰ������� ���� ��ư
--------------------------------------------------------------------
tOutLineOptionName		= {['protecterr']=0, [0]= "Option_OutLineOn", "Option_OutLineOff"}
tOutLineOptionPosX		= {['protecterr']=0, [0]=	105,	185}
tOutLineOptionEvent		= {['protecterr']=0, [0]= "OutLineOnEvent", "OutLineOffEvent"}

for i = 0, #tOutLineOptionName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tOutLineOptionName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Hover", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Disabled", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 611, 166)
	mywindow:setPosition(tOutLineOptionPosX[i], 60)
	mywindow:setProperty("GroupID", 3001)	--??
	mywindow:setSize(21, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", tOutLineOptionEvent[i])
	if i == 0 then
		mywindow:setEnabled(true)
		mywindow:setProperty("Selected", "true")
	else
		mywindow:setEnabled(false)	
	end
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ɼ� �ý��� Ǯ���, â���
--------------------------------------------------------------------
OptionName		= {['protecterr']=0, [0]= "Option_fullMode", "Option_WinMode"}
OptionPosX		= {['protecterr']=0, [0]=	105,	185}
OptionEvent		= {['protecterr']=0, [0]= "FullMode", "WinMode"}

for i=0, #OptionName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", OptionName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Hover", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Disabled", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 611, 166)
	mywindow:setPosition(OptionPosX[i], 60)
	mywindow:setProperty("GroupID", 3011)	--??
	mywindow:setSize(21, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", OptionEvent[i])
	if i == 0 then
		mywindow:setProperty("Selected", "true")		-- ���ý����ش�.
	end
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ɼ� ��Ƽ ���ø� 3�ܰ�
--------------------------------------------------------------------
tCameraZoominOptionName		= {['protecterr']=0, [0]= "Option_MS_Low", "Option_MS_Medium", "Option_MS_High"}
tCameraZoominOptionPosX		= {['protecterr']=0, [0]=	105,	185,	262}
tCameraZoominOptionEvent	= {['protecterr']=0, [0]= "Option_MS_LowEvent", "Option_MS_MediumEvent","Option_MS_HighEvent"}

for i=0, #tCameraZoominOptionName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tCameraZoominOptionName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Hover", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Disabled", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 611, 166)
	mywindow:setPosition(tCameraZoominOptionPosX[i], 86)
	mywindow:setProperty("GroupID", 3002)	--??
	mywindow:setSize(21, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", tCameraZoominOptionEvent[i])
	if i == 0  then
		mywindow:setProperty("Selected", "true")
	end

	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ɼ�â ȿ���� ����� ������ Image Setting
--------------------------------------------------------------------
tSoundControlName	= {['protecterr']=0, [0]="Option_EffectSoundGaugeImage", "Option_BackSoundGaugeImage" }
tOSoundControlPosY	= {['protecterr']=0, [0]=	182,	211 }
SoundButtonMax	= 10

--[[
for i=0, #tSoundControlName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tSoundControlName[i])
	mywindow:setTexture("Enabled", "UIData/option2.tga", 364, 374)
	mywindow:setTexture("Disabled", "UIData/option2.tga", 364, 374)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(130, tOSoundControlPosY[i] )
	mywindow:setSize(157, 12)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end
--]]
for i=0, #tSoundControlName do
	for j=1, SoundButtonMax do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tSoundControlName[i]..j)
		mywindow:setTexture("Enabled", "UIData/option2.tga", 374, 355)
		mywindow:setTexture("Disabled", "UIData/option2.tga", 374, 355)
--		mywindow:setTexture("Normal", "UIData/option2.tga", 374, 355)
--		mywindow:setTexture("Hover", "UIData/option2.tga", 374, 355)
--		mywindow:setTexture("Pushed", "UIData/option2.tga", 374, 355)
--		mywindow:setTexture("PushedOff", "UIData/option2.tga", 374, 355)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(113 + (8 * j), tOSoundControlPosY[i] )
		mywindow:setSize(6, 7)
		mywindow:setVisible(false)
--		mywindow:subscribeEvent("Clicked", tSoundControlFunction[i][j])
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
	end
end

--------------------------------------------------------------------
-- ȿ���� PrevButton Image Setting
--------------------------------------------------------------------
tSoundPrevButtonName		= {['protecterr']=0, [0]="Option_EffectSoundPrevButton", "Option_BackSoundPrevButton"}
tSoundPrevButtonPosY		= {['protecterr']=0, [0]=	178,	208}
tSoundPrevButtonFunction	= {['protecterr']=0, [0]="EffectSoundPrev", "BackSoundPrev"}

for i=0, #tSoundPrevButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tSoundPrevButtonName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 586, 146)
	mywindow:setTexture("Hover", "UIData/option2.tga", 586, 159)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 586, 172)
	mywindow:setTexture("PushedOff", "UIData/option2.tga", 586, 172)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(92, tSoundPrevButtonPosY[i])
	mywindow:setSize(12, 13)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", tSoundPrevButtonFunction[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end

-- Effect Prev Button Function
function EffectSoundPrev(args)
	tOptionInfoTable[7] = tOptionInfoTable[7] - 1
	
	if tOptionInfoTable[7] < 0 then
		tOptionInfoTable[7] = tOptionInfoTable[7] + 1
	end
	
	EffectSoundSetting(tOptionInfoTable[7])
	ApplicationSystem(7, tOptionInfoTable[7], bShowOptionCheck)
end

-- Effect Prev Button Function
function BackSoundPrev(args)
	tOptionInfoTable[6] = tOptionInfoTable[6] - 1
	
	if tOptionInfoTable[6] < 0 then
		tOptionInfoTable[6] = tOptionInfoTable[6] + 1
	end
	
	BackSoundSetting(tOptionInfoTable[6])
	ApplicationSystem(6, tOptionInfoTable[6], bShowOptionCheck)
end

--------------------------------------------------------------------
-- ȿ���� NextButton Image Setting
--------------------------------------------------------------------
tSoundNextButtonName		= {['protecterr']=0, [0]="Option_EffectSoundNextButton", "Option_BackSoundNextButton"}
tSoundNextButtonPosY		= {['protecterr']=0, [0]=	178,	208}
tSoundNextButtonFunction	= {['protecterr']=0, [0]="EffectSoundNext", "BackSoundNext"}

for i=0, #tSoundNextButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tSoundNextButtonName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 598, 146)
	mywindow:setTexture("Hover", "UIData/option2.tga", 598, 159)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 598, 172)
	mywindow:setTexture("PushedOff", "UIData/option2.tga", 598, 172)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(218, tSoundNextButtonPosY[i])
	mywindow:setSize(12, 13)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", tSoundNextButtonFunction[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end

-- Effect Next Button Function
function EffectSoundNext(args)
	tOptionInfoTable[7] = tOptionInfoTable[7] + 1
	
	if tOptionInfoTable[7] > 10 then
		tOptionInfoTable[7] = tOptionInfoTable[7] - 1
	end
	
	EffectSoundSetting(tOptionInfoTable[7])
	ApplicationSystem(7, tOptionInfoTable[7], bShowOptionCheck)
end

-- Back Next Button Function
function BackSoundNext(args)
	tOptionInfoTable[6] = tOptionInfoTable[6] + 1
	
	if tOptionInfoTable[6] > 10 then
		tOptionInfoTable[6] = tOptionInfoTable[6] - 1
	end
	
	BackSoundSetting(tOptionInfoTable[6])
	ApplicationSystem(6, tOptionInfoTable[6], bShowOptionCheck)
end

--------------------------------------------------------------------
-- ���� ���� ��ũ�ѹ�
--------------------------------------------------------------------
--[[
tSoundControlScrollName		= {['protecterr']=0, [0]="Option_EffectSoundScrollBar", "Option_BackSoundScrollBar" }
tOSoundControlScrollPosY	= {['protecterr']=0, [0]=	185,	214 }
tSoundControlScrollfunction	= {['protecterr']=0, [0]="ChangeSoundEffectGauge", "ChangeSoundBGMGauge" }

for i=0, #tSoundControlScrollName do
	mySoundControlScrollwindow = winMgr:createWindow("TaharezLook/HorizontalScrollbar", tSoundControlScrollName[i])
	mySoundControlScrollwindow:setSize(140, 22)
	mySoundControlScrollwindow:setPosition(115, tOSoundControlScrollPosY[i])
	mySoundControlScrollwindow:setVisible(true)
	mySoundControlScrollwindow:setAlwaysOnTop(true)
	

	-- ��ũ�ѹ� ������� ����ȯ�Ͽ� ��ũ�ѹ� ������ �Լ����� ����Ѵ�.
	CEGUI.toScrollbar(mySoundControlScrollwindow):subscribeEvent("ScrollPosChanged", tSoundControlScrollfunction[i])
	CEGUI.toScrollbar(mySoundControlScrollwindow):setDocumentSize(100)
	CEGUI.toScrollbar(mySoundControlScrollwindow):setPageSize(0)
	CEGUI.toScrollbar(mySoundControlScrollwindow):setStepSize(10)
--	CEGUI.toScrollbar(mySoundControlScrollwindow):setScrollPosition(60)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mySoundControlScrollwindow)

end
--]]
--------------------------------------------------------------------
-- ���� üũ�ڽ�
--------------------------------------------------------------------
tSoundoffName		= {['protecterr'] = 0, [0]=	"EffectSoundOffCheckBox", "BGMOffCheckBox" }
tSoundoffPositionY	= {['protecterr'] = 0, [0]=		180,	209 }
tSoundoffEvent		= {['protecterr'] = 0, [0]=	"EffectSoundOff", "BGMOff" }

for i=0, #tSoundoffName do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tSoundoffName[i])
	mywindow:setTexture("Normal", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Hover", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("PushedOff", "UIData/option2.tga", 611, 145)
	mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedHover", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 611, 166)
	mywindow:setTexture("SelectedPushedOff", "UIData/option2.tga", 611, 166)
	mywindow:setPosition(255, tSoundoffPositionY[i])
	mywindow:setSize(21, 21)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tSoundoffEvent[i])
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �ɼ�â ������ (������ �ʴ�ź�, ��Ƽ�ʴ� �ź�, �ӼӸ� �ź�)������ư
--------------------------------------------------------------------
tOptionGameTabName	=	{['protecterr']=0, 
						{['protecterr']=0, "Option_FightInviteOnBtn",	"Option_FightInviteOffBtn" },
						{['protecterr']=0, "Option_PartyInviteOnBtn",	"Option_PartyInviteOffBtn" },
						{['protecterr']=0, "Option_WhisperOnBtn",		"Option_WhisperOffBtn" },
						{['protecterr']=0, "Option_FriendInviteOnBtn",	"Option_FriendInviteOffBtn" },
						{['protecterr']=0, "Option_TradeOnBtn",			"Option_TradeOffBtn" },
						{['protecterr']=0, "Option_GameTipOnBtn",		"Option_GameTipOffBtn" } 
						}
tOptionGameTabPosX	=	{['protecterr']=0, 	 172,	252 }
tOptionGameTabEvent	=	{['protecterr']=0, 
						{['protecterr']=0,  "tInviteFightOn",	"tInviteFightOff" },
						{['protecterr']=0,  "tInvitePartyOn",	"tInvitePartyOff" }, 
						{['protecterr']=0,  "tInviteWhisperOn", "tInviteWhisperOff" },
						{['protecterr']=0,  "tInviteFriendOn",  "tInviteFriendOff" },
						{['protecterr']=0,  "tTradeOn",			"tTradeOff" },
						{['protecterr']=0,  "tGameTipOn",		"tGameTipOff" }
						 }


for i = 1, #tOptionGameTabName do
	for j = 1, #tOptionGameTabName[i] do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", tOptionGameTabName[i][j])
		mywindow:setTexture("Normal", "UIData/option2.tga", 611, 145)
		mywindow:setTexture("Hover", "UIData/option2.tga", 611, 145)
		mywindow:setTexture("Pushed", "UIData/option2.tga", 611, 145)
		mywindow:setTexture("Disabled", "UIData/option2.tga", 611, 145)
		mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 611, 166)
		mywindow:setTexture("SelectedHover", "UIData/option2.tga", 611, 166)
		mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 611, 166)
		mywindow:setPosition(tOptionGameTabPosX[j], 34 + 26 * (i - 1))
		mywindow:setProperty("GroupID", 3003 + ((i - 1) * 2))
		mywindow:setSize(21, 21)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("SelectStateChanged", tOptionGameTabEvent[i][j])
		mywindow:setEnabled(true)
		winMgr:getWindow("Option_GameImg"):addChildWindow(mywindow)
	end
end



--------------------------------------------------------------------
-- �ɼ�â ������ ��ũ�� EditBox
--------------------------------------------------------------------
tMacroEditBoxName	= {['protecterr'] = 0, [0]=	"MacroEditBox_1", "MacroEditBox_2", "MacroEditBox_3", "MacroEditBox_4" }

for i = 0, #tMacroEditBoxName do
	macro_editwindow = winMgr:createWindow("TaharezLook/Editbox", tMacroEditBoxName[i])
	macro_editwindow:setText("")
	macro_editwindow:setPosition(55, 230 + (i*27))
	macro_editwindow:setSize(260, 22)
	macro_editwindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	macro_editwindow:setTextColor(255, 255, 255, 255)
	macro_editwindow:setAlphaWithChild(0)
	macro_editwindow:setZOrderingEnabled(false)
	macro_editwindow:setUseEventController(false)
	CEGUI.toEditbox(winMgr:getWindow(tMacroEditBoxName[i])):setMaxTextLength(36)
	--CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBox")):subscribeEvent("EditboxFull", "OnAlertEditBoxFull")--�ƽ��϶� �Ҹ� �̺�Ʈ
	winMgr:getWindow("Option_GameImg"):addChildWindow(macro_editwindow);
	
end



--------------------------------------------------------------------
-- �ɼ� �⺻��, Ȯ��, ��� ��ư �̹���
--------------------------------------------------------------------
--�⺻�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Option_DefaultBtn")
mywindow:setTexture("Normal", "UIData/option2.tga", 364, 144)
mywindow:setTexture("Hover", "UIData/option2.tga", 364, 176)
mywindow:setTexture("Pushed", "UIData/option2.tga", 364, 208)
mywindow:setTexture("PushedOff", "UIData/option2.tga", 364, 208)
mywindow:setTexture("Disabled", "UIData/option2.tga", 364, 240)
mywindow:setPosition(90, 425)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DefaultButton")
optionmiddlewindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- Ȯ�ι�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Option_OKBtn")
mywindow:setTexture("Normal", "UIData/option2.tga", 453, 144)
mywindow:setTexture("Hover", "UIData/option2.tga", 453, 176)
mywindow:setTexture("Pushed", "UIData/option2.tga", 453, 208)
mywindow:setTexture("PushedOff", "UIData/option2.tga", 453, 208)
mywindow:setTexture("Disabled", "UIData/option2.tga", 453, 240)
mywindow:setPosition(182, 425)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OKButton")
optionmiddlewindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ��ҹ�ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Option_CancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(328, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CancleButton")
optionmiddlewindow:addChildWindow(mywindow)


--------------------------------------------------------------------

-- �ɼ� ���� �Լ���

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �ɼ� ����(�ý���)���ý� ȣ��
--------------------------------------------------------------------
function ShowOptionSystem(args)
	if CEGUI.toRadioButton(winMgr:getWindow("Option_SystemButton")):isSelected() then
		winMgr:getWindow("Option_SystemImg"):setVisible(true)
		winMgr:getWindow("Option_GameImg"):setVisible(false)
		ChangeResolutionWidth , ChangeResolutionHeight = GetChangeResolutionValue()
		winMgr:getWindow("Option_CurrentScreen"):setText(ChangeResolutionWidth.." X "..ChangeResolutionHeight)
	end
end


--------------------------------------------------------------------
-- �ɼ� ����(����)���ý� ȣ��
--------------------------------------------------------------------
function ShowOptionGame(args)
	if CEGUI.toRadioButton(winMgr:getWindow("Option_GameButton")):isSelected() then
		winMgr:getWindow("Option_GameImg"):setVisible(true)
		winMgr:getWindow("Option_SystemImg"):setVisible(false)
	end
	
	if IsEngLanguage() then
		UpdateCurrentLanguage()
	end
end


--------------------------------------------------------------------
-- �ػ� ��Ӵٿ��ư �̺�Ʈ
--------------------------------------------------------------------
function ComboDropDownButton()
	
	for i=0, 11 do
		winMgr:getWindow(tResolutionitemName[i]):setVisible(false)
	end
	DeviceSize = GetEnableDeviceSize()
	--DebugStr('DeviceSize:'..DeviceSize)
	
	if bResolutionButtonClick == false then
		winMgr:getWindow("Option_SystemImg"):addChildWindow(winMgr:getWindow("Option_ScreenBackImg"))
		winMgr:getWindow("Option_ScreenBackImg"):setVisible(true)
		bResolutionButtonClick = true
	else
		winMgr:getWindow("Option_ScreenBackImg"):setVisible(false)
		bResolutionButtonClick = false
	end
end

--------------------------------------------------------------------
-- �ػ� ���� ��ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function ChangeWindowSize(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
	
		Changewidth = CEGUI.toWindowEventArgs(args).window:getUserString("ResolutionWidth")
		Changeheight = CEGUI.toWindowEventArgs(args).window:getUserString("ResolutionHeight")

		winMgr:getWindow("Option_CurrentScreen"):setText(Changewidth.." X "..Changeheight)
		SaveResolutionValue(Changewidth, Changeheight)
		--ShowCommonAlertOkBoxWithFunction(PreCreateString_2837,'OnClickAlertOkSelfHide');		-- GetSStringInfo(LUA_CHANGE_RESOLUTION)
	end	
	
	winMgr:getWindow("Option_ScreenBackImg"):setVisible(false)
	bResolutionButtonClick = false
end

--------------------------------------------------------------------
-- �ػ� ����
--------------------------------------------------------------------
function SettingResolutionSize(index, width, height)
	
	if index > MAXRESOLUTIONCOUNT then
		return 
	end
	
	winMgr:getWindow(tResolutionitemName[index]):setVisible(true)
	winMgr:getWindow(tResolutionitemName[index]):setUserString("ResolutionWidth", width)
	winMgr:getWindow(tResolutionitemName[index]):setUserString("ResolutionHeight", height)
	winMgr:getWindow("ResolutionText"..index):setText(width.." X "..height)
end


--------------------------------------------------------------------
-- �ܰ���On
--------------------------------------------------------------------
function OutLineOnEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_OutLineOn")):isSelected() then
		ApplicationSystem(0, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- �ܰ���off
--------------------------------------------------------------------
function OutLineOffEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_OutLineOff")):isSelected() then
		ApplicationSystem(0, false, bShowOptionCheck)
	end
end

--------------------------------------------------------------------
-- ��ü���
--------------------------------------------------------------------
function FullMode()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_fullMode")):isSelected() == true then
		ApplicationSystem(3, true, bShowOptionCheck)
	end
end

--------------------------------------------------------------------
-- ������ ���
--------------------------------------------------------------------
function WinMode()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_WinMode")):isSelected() == true then
		ApplicationSystem(3, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ��Ƽ ���ø�(��)
--------------------------------------------------------------------
function Option_MS_LowEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_MS_Low")):isSelected() == true then
		ApplicationSystem(1, 0, bShowOptionCheck)
	end

end

--------------------------------------------------------------------
-- ��Ƽ ���ø�(��)
--------------------------------------------------------------------
function Option_MS_MediumEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_MS_Medium")):isSelected() == true then
		ApplicationSystem(1, 1, bShowOptionCheck)
	end

end


--------------------------------------------------------------------
-- ��Ƽ ���ø�(��)
--------------------------------------------------------------------
function Option_MS_HighEvent()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_MS_High")):isSelected() == true then
		ApplicationSystem(1, 2, bShowOptionCheck)
	end

end



function CameraZoominOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_MS_Medium")):isSelected() == true then
--		ApplicationSystem(1, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ī�޶� ȿ�� �̺�Ʈ(���� ON)
--------------------------------------------------------------------
function CameraZoominOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_MS_Low")):isSelected() == true then
--		ApplicationSystem(1, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ����Ʈ ���� ������ ���� �̺�Ʈ
--------------------------------------------------------------------
--function ChangeSoundEffectGauge(args)
--	if winMgr:getWindow("Option_MainBackImg"):isVisible() then
--		local pos = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window):getScrollPosition()
--		winMgr:getWindow("Option_EffectSoundGaugeImage"):setSize(pos + 5, 12)
--		winMgr:getWindow("Option_EffectSoundControlImage"):setPosition(pos + 128, tOSoundControlImagePosY[0]);
--		local EffectSonndControl = pos / 10;
--		ApplicationSystem(7, EffectSonndControl, bShowOptionCheck)
--	end
--end


function EffectSoundSetting(EffectNum)
	for i = 1,  SoundButtonMax do
		winMgr:getWindow("Option_EffectSoundGaugeImage"..i):setVisible(false)
	end
	
	for i = 1,  EffectNum do
		winMgr:getWindow("Option_EffectSoundGaugeImage"..i):setVisible(true)
	end
end
--------------------------------------------------------------------
-- BGM ���� ������ ���� �̺�Ʈ
--------------------------------------------------------------------

--function ChangeSoundBGMGauge(args)
--	if winMgr:getWindow("Option_MainBackImg"):isVisible() then
--		local pos = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window):getScrollPosition()
--		winMgr:getWindow("Option_BackSoundGaugeImage"):setSize(pos + 5, 12)
--		winMgr:getWindow("Option_BackSoundControlImage"):setPosition(pos + 128, tOSoundControlImagePosY[1]);
--		local BackgroundSoundControl = pos / 10;
--		ApplicationSystem(6, BackgroundSoundControl, bShowOptionCheck)
--	end
--end

function BackSoundSetting(BackNum)
	for i = 1,  SoundButtonMax do
		winMgr:getWindow("Option_BackSoundGaugeImage"..i):setVisible(false)
	end
	
	for i = 1,  BackNum do
		winMgr:getWindow("Option_BackSoundGaugeImage"..i):setVisible(true)
	end
end

--------------------------------------------------------------------
-- ȿ���� ���⸦ ������ ������ ��Ȱ��, ��ũ�ѹ� ��Ȱ��
--------------------------------------------------------------------
function EffectSoundOff()
	--WndPopupButtonClickSound()
	if CEGUI.toCheckbox(winMgr:getWindow("EffectSoundOffCheckBox")):isSelected() then
--		winMgr:getWindow("Option_EffectSoundGaugeImage"):setVisible(false)
--		winMgr:getWindow("Option_EffectSoundGaugeImage"):setEnabled(false)
--		winMgr:getWindow("Option_EffectSoundScrollBar"):setEnabled(false)

		for i = 1,  SoundButtonMax do
			winMgr:getWindow("Option_EffectSoundGaugeImage"..i):setVisible(false)
		end
		
		ApplicationSystem(5, true, bShowOptionCheck)

	else
--		winMgr:getWindow("Option_EffectSoundGaugeImage"):setVisible(true)
--		winMgr:getWindow("Option_EffectSoundGaugeImage"):setEnabled(true)
--		winMgr:getWindow("Option_EffectSoundScrollBar"):setEnabled(true)

		EffectSoundSetting(tOptionInfoTable[7])		
		ApplicationSystem(5, false, bShowOptionCheck)
	end

end


--------------------------------------------------------------------
-- ����� ���⸦ ������ ������ ��Ȱ��, ��ũ�ѹ� ��Ȱ��
--------------------------------------------------------------------
function BGMOff()
	--WndPopupButtonClickSound()
	if CEGUI.toCheckbox(winMgr:getWindow("BGMOffCheckBox")):isSelected() then
--		winMgr:getWindow("Option_BackSoundGaugeImage"):setVisible(false)
--		winMgr:getWindow("Option_BackSoundGaugeImage"):setEnabled(false)
--		winMgr:getWindow("Option_BackSoundScrollBar"):setEnabled(false)
--		bBGMActive = true
--		nBackgroundSoundOnOff = 1;

		for i = 1,  SoundButtonMax do
			winMgr:getWindow("Option_BackSoundGaugeImage"..i):setVisible(false)
		end
		
		ApplicationSystem(4, true, bShowOptionCheck)
	else
--		winMgr:getWindow("Option_BackSoundGaugeImage"):setVisible(true)
--		winMgr:getWindow("Option_BackSoundGaugeImage"):setEnabled(true)
--		winMgr:getWindow("Option_BackSoundScrollBar"):setEnabled(true)
--		bBGMActive = false;		
--		nBackgroundSoundOnOff = 0;

		BackSoundSetting(tOptionInfoTable[6])
		ApplicationSystem(4, false, bShowOptionCheck)
	end

end



--------------------------------------------------------------------
-- �����ʴ� ON�Լ�
--------------------------------------------------------------------
function tInviteFightOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_FightInviteOnBtn")):isSelected() == true then
		bInviteFight = true;
		ApplicationSystem(8, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- �����ʴ� OFF�Լ�
--------------------------------------------------------------------
function tInviteFightOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_FightInviteOffBtn")):isSelected() == true then
		bInviteFight = false;
		ApplicationSystem(8, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ��Ƽ�ʴ� ON�Լ�
--------------------------------------------------------------------
function  tInvitePartyOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_PartyInviteOnBtn")):isSelected() == true then
		bInviteParty = true;
		ApplicationSystem(9, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ��Ƽ�ʴ� OFF�Լ�
--------------------------------------------------------------------
function tInvitePartyOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_PartyInviteOffBtn")):isSelected() == true then
		bInviteParty = false;
		ApplicationSystem(9, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- �ӼӸ� ���� 
--------------------------------------------------------------------
function tInviteWhisperOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_WhisperOnBtn")):isSelected() == true then
		bWhisper = true;
		ApplicationSystem(10, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- �ӼӸ� ����
--------------------------------------------------------------------
function  tInviteWhisperOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_WhisperOffBtn")):isSelected() == true then
		local bWhisper = false;
		ApplicationSystem(10, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ģ���ʴ� ����
--------------------------------------------------------------------
function tInviteFriendOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_FriendInviteOnBtn")):isSelected() == true then
		bInviteFriend = false;
		ApplicationSystem(11, bInviteFriend, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ģ���ʴ� ����
--------------------------------------------------------------------
function tInviteFriendOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_FriendInviteOffBtn")):isSelected() == true then
		bInviteFriend = true;
		ApplicationSystem(11, bInviteFriend, bShowOptionCheck)
	end
end




--------------------------------------------------------------------
-- �ŷ� ����
--------------------------------------------------------------------
function tTradeOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_TradeOnBtn")):isSelected() == true then
		bTrade = false;
		ApplicationSystem(12, false, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- �ŷ� ����
--------------------------------------------------------------------
function tTradeOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_TradeOffBtn")):isSelected() == true then
		bTrade = true;
		ApplicationSystem(12, true, bShowOptionCheck)
	end
end

--------------------------------------------------------------------
-- ���� ��
--------------------------------------------------------------------
function tGameTipOn()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_GameTipOnBtn")):isSelected() == true then
		bGameTip = true;
		ApplicationSystem(13, true, bShowOptionCheck)
	end
end


--------------------------------------------------------------------
-- ���� ��
--------------------------------------------------------------------
function tGameTipOff()
	if CEGUI.toRadioButton(winMgr:getWindow("Option_GameTipOffBtn")):isSelected() == true then
		bGameTip = false;
		ApplicationSystem(13, false, bShowOptionCheck)
	end
end



--------------------------------------------------------------------
-- Ȯ��
--------------------------------------------------------------------
function OKButton()

	SystemOptionOk(winMgr:getWindow("MacroEditBox_1"):getText(), winMgr:getWindow("MacroEditBox_2"):getText(),
					winMgr:getWindow("MacroEditBox_3"):getText(), winMgr:getWindow("MacroEditBox_4"):getText());
	winMgr:getWindow("Option_MainBackImg"):setVisible(false);

end


--------------------------------------------------------------------
-- ���
--------------------------------------------------------------------
function CancleButton()
	SystemOptionCancel();
	winMgr:getWindow("Option_MainBackImg"):setVisible(false);
	RefreshOption()
end

--------------------------------------------------------------------
-- �⺻�� ��ư Ŭ��
--------------------------------------------------------------------
function DefaultButton()
	
	if winMgr:getWindow("Option_SystemImg"):isVisible() then
		DefaultApplication(0);		-- �ý��� ����
	elseif winMgr:getWindow("Option_GameImg"):isVisible() then
		DefaultApplication(1);		-- �ý��� ����
	else
	
	end

	
end


--------------------------------------------------------------------
--�ɼǿ� �� ���� �� �޾ƿ�
--------------------------------------------------------------------
function SetUpOption(OutLineOnOff, MultiSampling, nScreenBrightness, WindowMode, bBGMEnable, bEffectEnable, nBGMControl, nEffectControl, 
						bInviteFight, bInviteParty, bWhisper, bInviteFriend, bTrade, bGameTip)
	local	firstCheck	= false
	--�ܰ���
	if OutLineOnOff then
		winMgr:getWindow("Option_OutLineOn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_OutLineOff"):setProperty("Selected", "true");
	end
	
	-- ������ ���
	if WindowMode then
		winMgr:getWindow("Option_fullMode"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_WinMode"):setProperty("Selected", "true");
	end

	-- ��Ƽ ���ø�
	if MultiSampling == 0 then
		winMgr:getWindow("Option_MS_Low"):setProperty("Selected", "true");
	elseif MultiSampling == 1 then
		winMgr:getWindow("Option_MS_Medium"):setProperty("Selected", "true");
	elseif MultiSampling == 2 then
		winMgr:getWindow("Option_MS_High"):setProperty("Selected", "true");
	end

	-- ����(ȿ����) ������ Setting
	if bEffectEnable == false then
		tOptionInfoTable[7]= nEffectControl
		EffectSoundSetting(nEffectControl)
	end
	
	-- ����(�����) ������ Setting
	if bBGMEnable == false then
		tOptionInfoTable[6] = nBGMControl
		BackSoundSetting(nBGMControl)
	end
	
	--����(ȿ����)����
--	CEGUI.toScrollbar(winMgr:getWindow("Option_EffectSoundScrollBar")):setScrollPosition(nEffectControl * 10);
--	local pos = CEGUI.toScrollbar(winMgr:getWindow("Option_EffectSoundScrollBar")):getScrollPosition();
--	winMgr:getWindow("Option_EffectSoundGaugeImage"):setSize(pos + 5, 12);
	
	--����(�����)����
--	CEGUI.toScrollbar(winMgr:getWindow("Option_BackSoundScrollBar")):setScrollPosition(nBGMControl * 10);
--	pos = CEGUI.toScrollbar(winMgr:getWindow("Option_BackSoundScrollBar")):getScrollPosition();
--	winMgr:getWindow("Option_BackSoundGaugeImage"):setSize(pos + 5, 12);
	
	--ȿ���� �Ұ�
	if bEffectEnable == false then
		if CEGUI.toCheckbox(winMgr:getWindow("EffectSoundOffCheckBox")):isSelected() == true then
			winMgr:getWindow("EffectSoundOffCheckBox"):setProperty("Selected", "false")
			--EffectSoundOff();
		end
	else
		if CEGUI.toCheckbox(winMgr:getWindow("EffectSoundOffCheckBox")):isSelected() == false then
			winMgr:getWindow("EffectSoundOffCheckBox"):setProperty("Selected", "true")
			--EffectSoundOff();	
		end
	end
		
	--����� �Ұ�	
	if bBGMEnable == false then
		if CEGUI.toCheckbox(winMgr:getWindow("BGMOffCheckBox")):isSelected() == true then
			winMgr:getWindow("BGMOffCheckBox"):setProperty("Selected", "false")
			--BGMOff();
		end
	else
		if CEGUI.toCheckbox(winMgr:getWindow("BGMOffCheckBox")):isSelected() == false then
			winMgr:getWindow("BGMOffCheckBox"):setProperty("Selected", "true")
			--BGMOff();
		end
	end
		
	--�����ʴ� ����
	if bInviteFight == false then
		winMgr:getWindow("Option_FightInviteOffBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_FightInviteOnBtn"):setProperty("Selected", "true");
	end
	
	--��Ƽ�ʴ� ����
	if bInviteParty == false then
		winMgr:getWindow("Option_PartyInviteOffBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_PartyInviteOnBtn"):setProperty("Selected", "true");
	end
	
	--�ӼӸ� ���� ����
	if bWhisper == false then
		winMgr:getWindow("Option_WhisperOffBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_WhisperOnBtn"):setProperty("Selected", "true");
	end
	
	if bInviteFriend == false then
		winMgr:getWindow("Option_FriendInviteOnBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_FriendInviteOffBtn"):setProperty("Selected", "true");
	end
	
	if bTrade == false then
		winMgr:getWindow("Option_TradeOnBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_TradeOffBtn"):setProperty("Selected", "true");
	end
	
	-- ���� �� ���� 
	if bGameTip == false then
		winMgr:getWindow("Option_GameTipOffBtn"):setProperty("Selected", "true");
	else
		winMgr:getWindow("Option_GameTipOnBtn"):setProperty("Selected", "true");
	end
	
	winMgr:getWindow("MacroEditBox_1"):setText(tCurrentMacroTable[1]);
	winMgr:getWindow("MacroEditBox_2"):setText(tCurrentMacroTable[2]);
	winMgr:getWindow("MacroEditBox_3"):setText(tCurrentMacroTable[3]);
	winMgr:getWindow("MacroEditBox_4"):setText(tCurrentMacroTable[4]);


end


--------------------------------------------------------------------
-- �ɼ� �⺻�� ����
--------------------------------------------------------------------
function SettingDefaultValue()

	local Outline, MultiSampling, nScreenBrightness, WindowMode, bBGMEnable, bEffectEnable, nBGMControl, nEffectControl,
		MacroList1, MacroList2, MacroList3, MacroList4, bGameTip, bInviteFight, bInviteParty, bWhisper, bInviteFriend, bTrade = DefaultInfo(
				true, 2, 5, true, false, false, 8, 8, tBaseMacroTable[1], tBaseMacroTable[2], tBaseMacroTable[3], tBaseMacroTable[4], true)	-- c�� �Ѱܼ� �������ش�

	SetUpOption(Outline, MultiSampling, nScreenBrightness, WindowMode, bBGMEnable, bEffectEnable
					,nBGMControl, nEffectControl, bInviteFight, bInviteParty, bWhisper, bInviteFriend, bTrade, bGameTip)	

end


--------------------------------------------------------------------
-- �ɼ�â�� �����ش�
--------------------------------------------------------------------
function ShowOption()
	winMgr:getWindow("Option_GameButton"):setProperty("Selected", "true")
	winMgr:getWindow("Option_MainBackImg"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("Option_MainBackImg"))
	
	RefreshOption()		-- �ٽ� �ҷ��ش�.
	
	-- ���ӿɼ��� �켱 �����ش�. 
	winMgr:getWindow("Option_SystemImg"):setVisible(false)
	winMgr:getWindow("Option_GameImg"):setVisible(true)

end

--------------------------------------------------------------------
-- �ɼ�â�� ���� �ҷ��ش�
--------------------------------------------------------------------
function RefreshOption()
	local Outline, MultiSampling, nScreenBrightness, WindowMode, bBGMEnable, bEffectEnable, nBGMControl, nEffectControl,
			MacroList1, MacroList2, MacroList3, MacroList4, bInviteFight, bInviteParty, bWhisper, bInviteFriend, bTrade, bGameTip = CurrentInfo();

	tOptionInfoTable[0]		= Outline
	tOptionInfoTable[1]		= MultiSampling
	tOptionInfoTable[2]		= nScreenBrightness
	tOptionInfoTable[3]		= WindowMode
	tOptionInfoTable[4]		= bBGMEnable
	tOptionInfoTable[5]		= bEffectEnable
	tOptionInfoTable[6]		= nBGMControl
	tOptionInfoTable[7]		= nEffectControl
	tOptionInfoTable[8]		= bInviteFight
	tOptionInfoTable[9]		= bInviteParty
	tOptionInfoTable[10]	= bWhisper
	tOptionInfoTable[11]	= bInviteFriend
	tOptionInfoTable[12]	= bTrade
	tOptionInfoTable[13]	= bGameTip
	

	-- ���� ��ũ�θ� ����.
	tCurrentMacroTable[1] = MacroList1
	tCurrentMacroTable[2] = MacroList2
	tCurrentMacroTable[3] = MacroList3
	tCurrentMacroTable[4] = MacroList4

	bShowOptionCheck = true
	-- �ɼ� ui�� ���� �ѷ��ش�.
	SetUpOption(Outline, MultiSampling, nScreenBrightness, WindowMode, bBGMEnable, bEffectEnable
					,nBGMControl, nEffectControl, bInviteFight, bInviteParty, bWhisper, bInviteFriend, bTrade, bGameTip)	
	
	bShowOptionCheck = false
end



--------------------------------------------------------------------
-- ���� ENG ���� �߰��Ѵ�~~~~~
--------------------------------------------------------------------

if IsEngLanguage() then
	DebugStr("Create CCCCRECCCCCCCCCCCCCCCCRE CCCRE LANGUAGE");
	tLanguageKind		= {['protecterr']=0, [0]= "Language1","Language2"}
	tLanguageName		= {['protecterr']=0, [0]= "English","Vietnamese"}
	tChangeLanguageEvent	= {['protecterr']=0, [0]= "ChangeLanguage" }
	--------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------
	-- ���� �޺��ڽ� ���� (���� ��ư, Text, ��Ӵٿ� �߻� ��ư)
	--------------------------------------------------------------------
	--���� ��� �ѷ���
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Option_CurrentLanguage")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 14)
	mywindow:setText("Test")
	mywindow:setPosition(195, 283)
	mywindow:setSize(161, 23)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)

	function UpdateCurrentLanguage()
		local SubLanguage = GetSubLanguageType();
		winMgr:getWindow("Option_CurrentLanguage"):setText(tLanguageName[SubLanguage]);
	end


	-------------------------------------------------------------------
	--���� ��Ӵٿ� �߻� ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "Option_LanguageDropDownBt")
	mywindow:setTexture("Normal", "UIData/option2.tga", 634, 233)
	mywindow:setTexture("Hover", "UIData/option2.tga", 634, 253)
	mywindow:setTexture("Pushed", "UIData/option2.tga", 634, 273)
	mywindow:setTexture("PushedOff", "UIData/option2.tga", 634, 293)
	mywindow:setPosition(303, 283)
	--mywindow:setEnabled(false)
	mywindow:setSize(20, 20)
	mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "OnClickedLanguageDropDownBt")
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)

	-------------------------------------------------------------------
	-- ���� ���� �̹���
	-------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Option_LanguageBackImg")
	mywindow:setTexture("Enabled", "UIData//Black.tga", 0, 0)		--�����
	mywindow:setTexture("Disabled", "UIData/Black.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(153, 305)
	mywindow:setSize(161, 40)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Option_SystemImg"):addChildWindow(mywindow)

	-------------------------------------------------------------------
	-- ���� �����̹���(������ư), �ȿ� �� ���� Text
	-------------------------------------------------------------------
	for i=0, #tLanguageKind do
		DebugStr("Create _ " .. tLanguageKind[i])
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", tLanguageKind[i])
		mywindow:setTexture("Normal", "UIData/option2.tga", 364, 272)
		mywindow:setTexture("Hover", "UIData/option2.tga", 364, 292)
		mywindow:setTexture("Pushed", "UIData/option2.tga", 364, 272)
		mywindow:setTexture("SelectedNormal", "UIData/option2.tga", 364, 272)
		mywindow:setTexture("SelectedHover", "UIData/option2.tga", 364, 272)
		mywindow:setTexture("SelectedPushed", "UIData/option2.tga", 364, 272)
		mywindow:setPosition(0, 0 + (i * 21))
		mywindow:setSize(170, 20)
		mywindow:setProperty('GroupID', 112)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUserString("LanguageName", tLanguageName[i])
		mywindow:subscribeEvent("SelectStateChanged", "ChangeLanguage")
		winMgr:getWindow("Option_LanguageBackImg"):addChildWindow(mywindow)

		
		--Text	
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "LanguageKind"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(0, 0, 0, 255)
		mywindow:setFont(g_STRING_FONT_GULIM, 12)
		mywindow:setPosition(43, 0)
		mywindow:setSize(161, 20)
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		mywindow:setText(tLanguageName[i])
		winMgr:getWindow(tLanguageKind[i]):addChildWindow(mywindow)
	end

	--------------------------------------------------------------------
	-- ���� ��Ӵٿ��ư �̺�Ʈ
	--------------------------------------------------------------------
	function OnClickedLanguageDropDownBt()
		local Eng = 0;
		local VNM = 1;
	
		if bLanguageButtonClick == false then
			winMgr:getWindow("Option_SystemImg"):addChildWindow(winMgr:getWindow("Option_LanguageBackImg"))
			winMgr:getWindow("Option_LanguageBackImg"):setVisible(true)
			

			
			bLanguageButtonClick = true			
		else
			winMgr:getWindow("Option_LanguageBackImg"):setVisible(false)
			bLanguageButtonClick = false
		end
	end

	--------------------------------------------------------------------
	-- ���� ���� ��ư Ŭ�� �̺�Ʈ
	--------------------------------------------------------------------
	local SelectedLanguageWnd;
	function ChangeLanguage(args)
		DebugStr("---ChangeLanguage ChangeLanguage---")
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected()  == false then
			return
		end
		DebugStr("ChangeLanguageChangeLanguageChangeLanguage")
		
		local SelectedName = CEGUI.toWindowEventArgs(args).window:getUserString("LanguageName")
		local CurrentName =  winMgr:getWindow("Option_CurrentLanguage"):getText()
		DebugStr(SelectedName .. "====?" .. CurrentName)

		if SelectedName == CurrentName then
			return
		end

		DebugStr("ChangeLanguageChangeLanguageChangeLanguage2")
		MainBarOffExceptSysmenu();

		winMgr:getWindow("WndOption_PopupAlpha"):setAlwaysOnTop(true)
		winMgr:getWindow("WndOption_PopupAlpha"):setVisible(true)
		--winMgr:getWindow("WndOption_PopupImage"):setAlwaysOnTop(true)
		--winMgr:getWindow("WndOption_PopupImage"):setVisible(true)
		winMgr:getWindow('NewSystemBackImage'):setAlwaysOnTop(false)
		--optionbackwindow:setAlwaysOnTop(false)
		winMgr:getWindow("Option_MainBackImg"):setAlwaysOnTop(false)
		bLanguageButtonClick = false
		
		SelectedLanguageWnd = local_window;
	end

	--------------------------------------------------------------------
	-- Option ���� â���� ���ϰ������� ���� �˾�â
	--------------------------------------------------------------------
	--------------------------------------------------------------------
	-- ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'WndOption_PopupAlpha');
	mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setPosition(0,0);
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow);


	RegistEscEventInfo("WndOption_PopupAlpha", "WndOptionPopupEscEvent")
	RegistEnterEventInfo("WndOption_PopupAlpha", "WndOptionPopupEnterEvent")


	--------------------------------------------------------------------
	-- ����.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'WndOption_PopupImage');
	mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setWideType(6)
	mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 268) / 2);
	mywindow:setSize(340, 268);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('WndOption_PopupAlpha'):addChildWindow(mywindow);

	--------------------------------------------------------------------
	-- �ؽ�Ʈ
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndOption_PopupText");
	mywindow:setPosition(3, 45);
	mywindow:setSize(340, 180);
	mywindow:setAlign(7);
	mywindow:setLineSpacing(2);
	mywindow:setViewTextMode(1);
	mywindow:setEnabled(false)
	mywindow:clearTextExtends();
	--LAN_Language_Option_Notice_01
	
	mywindow:addTextExtends(PreCreateString_5292, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	winMgr:getWindow('WndOption_PopupImage'):addChildWindow(mywindow);
			

	--------------------------------------------------------------------
	-- ��ư (Ȯ��, ���)
	--------------------------------------------------------------------
	local ButtonName	= {['protecterr']=0, "WndOption_PopupOKButton", "WndOption_PopupCancelButton"}
	local ButtonTexX	= {['protecterr']=0,			693,					858}
	local ButtonPosX	= {['protecterr']=0,			4,						169}		
	local ButtonEvent	= {['protecterr']=0, "WndOptionPopupEnterEvent", "WndOptionPopupEscEvent"}

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
		mywindow:setUserString("index", 0)
		mywindow:subscribeEvent("Clicked", ButtonEvent[i])
		winMgr:getWindow('WndOption_PopupImage'):addChildWindow(mywindow)
	end


	-- �κ��丮 �˾�â�� cancel �̺�Ʈ
	function WndOptionPopupEscEvent()
		DebugStr("WndOptionPopupEscEvent");
		winMgr:getWindow("WndOption_PopupAlpha"):setVisible(false)
		winMgr:getWindow('NewSystemBackImage'):setAlwaysOnTop(true)
		optionbackwindow:setAlwaysOnTop(true)
		winMgr:getWindow("Option_LanguageBackImg"):setVisible(false)
		bLanguageButtonClick = false
		UpdateCurrentLanguage();
		
	end



	-- �κ��丮 �˾�â�� enter �̺�Ʈ
	function WndOptionPopupEnterEvent()	 
		local Name = SelectedLanguageWnd:getName();
		local SelectedSubLanguage;
		for i=0, #tLanguageKind do
			if tLanguageKind[i] == Name then
				DebugStr("SelectedSubLanguageID" ..	i);
				SelectedSubLanguage = i
			end
		end

		DebugStr("WndOptionPopupEnterEvent" ..	SelectedLanguageWnd:getName());
		DebugStr("SelectedSubLanguageID" ..	SelectedSubLanguage);

		ChangeSubLanguage(SelectedSubLanguage)
		WndOptionPopupEscEvent();
		
		local SelectedName = SelectedLanguageWnd:getUserString("LanguageName")
		winMgr:getWindow("Option_CurrentLanguage"):setText(SelectedName);
	end
end



