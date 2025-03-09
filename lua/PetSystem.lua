--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

PET_DECO_MAX_STAT   = 3


if IsEngLanguage() then

	PET_UPGRADE_NORMAL	= 10
	PET_UPGRADE_FIX1	= 25
	PET_UPGRADE_FIX2	= 30

	PET_OPEN_SLOT_ONE	= 20
	PET_OPEN_SLOT_TWO	= 30
	PET_OPEN_SLOT_TRREE = 50
	
else

	PET_UPGRADE_NORMAL	= 900000
	PET_UPGRADE_FIX1	= 1800000
	PET_UPGRADE_FIX2	= 3600000

	PET_OPEN_SLOT_ONE	= 900000
	PET_OPEN_SLOT_TWO	= 1800000
	PET_OPEN_SLOT_TRREE = 3600000 
end


PetOpenSlotMoney		= {['protecterr']=0, 	PET_OPEN_SLOT_ONE , PET_OPEN_SLOT_TWO,  PET_OPEN_SLOT_TRREE}


-----------------------------------------------------------------------
-- 펫 강화시스템 관련
-----------------------------------------------------------------------
RegistEscEventInfo("PetStatUpgrade_MainWindow", "PetStatUpgradeMainWindowClose")

 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgrade_MainWindow")
mywindow:setTexture("Enabled",	"UIData/frame/frame_010.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0 , 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setPosition(500 , 80)
mywindow:setSize(399, 495)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


function PetStatUpgradeMainWindowClose()
	winMgr:getWindow("PetStatUpgrade_MainWindow"):setVisible(false)
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(false)
end


-----------------------------------------------------------------------
-- 펫 강화시스템 타이틀
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeTitleimg")
mywindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 0)
mywindow:setPosition(112 , 5)	
mywindow:setSize(179, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetStatUpgrade_MainWindow"):addChildWindow(mywindow)

-----------------------------------------------------------------------
-- 펫 강화시스템 소배경
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeBackimg")
mywindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 27)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 27)
mywindow:setPosition(15 , 49)	
mywindow:setSize(370, 350)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetStatUpgrade_MainWindow"):addChildWindow(mywindow)



-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeItemimg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 370, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 370, 0)
mywindow:setPosition(154 , 34)	
mywindow:setSize(110, 110)
mywindow:setScaleHeight(170)	-- 축소해놓는다.
mywindow:setScaleWidth(170)		-- 축소해놓는다.
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)

-- 캐쉬 비용
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetStatUpgrade_cash")
mywindow:setPosition(200, 323)
mywindow:setSize(120, 14)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setTextExtends(0, g_STRING_FONT_GULIM,18, 255,255,0,255,  1,  0,0,0,255);
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)

-- 알림 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeNoticeimg")
mywindow:setTexture("Enabled", "UIData/pet_02.tga", 687, 280+55)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 687, 280+55)
mywindow:setPosition(230, 70)
mywindow:setSize(189, 55)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)

-- 알림 클릭이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeNoticeimg2")
mywindow:setTexture("Enabled", "UIData/pet_02.tga", 687, 280)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 687, 280)
mywindow:setPosition(50, 320)
mywindow:setSize(189, 55)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)

for i=1,  PET_DECO_MAX_STAT do

	-- 스텟 백판 --------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeTextBackimg"..i)
	mywindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 377+45)
	mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 377+45)
	mywindow:setPosition(25, 121+(48*i)-48)
	mywindow:setSize(273, 45)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)
	
	-- 스텟 텍스트	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetStatUpgradeText"..i)
	mywindow:setPosition(230, 135+(48*i)-48)
	mywindow:setSize(1, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)
	
	-- 스텟 이미지 --------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeimg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 885, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 885, 0)
	mywindow:setPosition(35, 121+(48*i)-48)
	mywindow:setSize(139, 45)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)
	
	
	-- 스텟 잠금 커버 이미지 --------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStatUpgradeTextCoverimg"..i)
	mywindow:setTexture("Enabled", "UIData/pet_02.tga", 0, 377)
	mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0, 377)
	mywindow:setPosition(25, 121+(48*i)-48)
	mywindow:setSize(273, 45)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)
	
	
	-- 체크 박스 --------------------
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", "PetStatUpgradeStatCheck"..i )
	mywindow:setTexture("Normal", "UIData/pet_02.tga", 370, 90+41)
	mywindow:setTexture("Hover", "UIData/pet_02.tga",370, 90+41)
	mywindow:setTexture("Pushed", "UIData/pet_02.tga", 370, 90+41)
	mywindow:setTexture("PushedOff", "UIData/pet_02.tga", 370, 90+41)
	mywindow:setTexture("SelectedNormal", "UIData/pet_02.tga", 370, 90)
	mywindow:setTexture("SelectedHover", "UIData/pet_02.tga", 370, 90)
	mywindow:setTexture("SelectedPushed", "UIData/pet_02.tga", 370, 90)
	mywindow:setTexture("SelectedPushedOff", "UIData/pet_02.tga", 370, 90)
	mywindow:setPosition(298, 123+(48*i)-48)
	mywindow:setSize(41, 41)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_PetCheckbox")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_PetUpgradeleave")
	mywindow:subscribeEvent("CheckStateChanged", "OnClickPetStatUpgradeStatFix")
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)

	-- 슬롯 오픈 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "PetStatUpgrade_"..i)
	mywindow:setTexture("Normal", "UIData/pet_02.tga", 370, 172)
	mywindow:setTexture("Hover", "UIData/pet_02.tga", 370, 172 + 45)
	mywindow:setTexture("Pushed", "UIData/pet_02.tga", 370, 172 + 90)
	mywindow:setTexture("PushedOff", "UIData/pet_02.tga", 370, 172 )
	mywindow:setTexture("Disabled", "UIData/pet_02.tga", 370, 172 + 135)
	mywindow:setPosition(25, 121+(48*i)-48)
	mywindow:setSize(317, 45)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_PetSlotOpen")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_PetUpgradeleave")
	mywindow:subscribeEvent("Clicked", "NotifyPetStatUpgradeOpenEvent")
	winMgr:getWindow("PetStatUpgradeBackimg"):addChildWindow(mywindow)
end


function OnMouseEnter_PetCheckbox(args)
	root:addChildWindow(winMgr:getWindow('PetStatUpgradeNoticeimg'))
	winMgr:getWindow('PetStatUpgradeNoticeimg'):setVisible(true)
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	winMgr:getWindow('PetStatUpgradeNoticeimg'):setPosition(x-80, y-50)
end

function OnMouseLeave_PetUpgradeleave()
	winMgr:getWindow("PetStatUpgradeNoticeimg"):setVisible(false)
	winMgr:getWindow("PetStatUpgradeNoticeimg2"):setVisible(false)
end


function OnMouseEnter_PetSlotOpen(args)
	root:addChildWindow(winMgr:getWindow('PetStatUpgradeNoticeimg2'))
	winMgr:getWindow('PetStatUpgradeNoticeimg2'):setVisible(true)
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	winMgr:getWindow('PetStatUpgradeNoticeimg2'):setPosition(x+50, y-50)
end




local checkFixcash = PET_UPGRADE_NORMAL

function OnClickPetStatUpgradeStatFix(args)

	-- 개방된 숫자부터 계산
	local opencount = 0
	local fixcount = 0
	
	for i=1, PET_DECO_MAX_STAT do
		 if winMgr:getWindow("PetStatUpgrade_"..i):isVisible() == false then
			opencount = opencount + 1
		 end
		 
		 if CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck"..i )):isSelected() then
			fixcount  = fixcount + 1
		 end
	end

	-- 개방된거보단 적게 고정시켜야함
	if opencount == fixcount then
		 local local_window = CEGUI.toWindowEventArgs(args).window;
		 local win_name = local_window:getName();
		 CEGUI.toCheckbox(local_window):setProperty('Selected', 'false');
	end

	-- 커버이미지 수정
	local count = 0
	for i=1, PET_DECO_MAX_STAT do
		if CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck"..i )):isSelected() then
	 		winMgr:getWindow("PetStatUpgradeTextCoverimg"..i):setVisible(true)
	 		count = count + 1
	 	 else
	 		winMgr:getWindow("PetStatUpgradeTextCoverimg"..i):setVisible(false)
	 	 end
	end
	
	-- 금액 설정
	if count == 0 then
		checkFixcash = PET_UPGRADE_NORMAL
	elseif count == 1 then
		checkFixcash = PET_UPGRADE_FIX1
	else
		checkFixcash = PET_UPGRADE_FIX2
	end
	 
	local r, g, b	= ColorToMoney(checkFixcash)
	winMgr:getWindow("PetStatUpgrade_cash"):setTextExtends(CommatoMoneyStr(checkFixcash), g_STRING_FONT_GULIMCHE,18, 255, 255, 0 ,255,  0,  0,0,0,255);
end




-- 강화 오픈 이벤트

local PetStatOpenIndex = 0

function NotifyPetStatUpgradeOpenEvent(args)

	PetStatOpenIndex = 0
	local local_window = CEGUI.toWindowEventArgs(args).window;
	PetStatOpenIndex = tonumber(local_window:getUserString("index"))
	
	local PreCreateString_pet = GetSStringInfo(LAN_PETITEM_ASKMSG_OPENABILITY_001)
	local petstring = string.format(PreCreateString_pet, PetOpenSlotMoney[PetStatOpenIndex] )
	
	ShowCommonAlertOkCancelBoxWithFunction("", petstring, 'PetStatSlotOpenOkEvent', 'PetStatSlotOpenCancelEvent')
	
end
	
	
	
function PetStatSlotOpenOkEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "PetStatSlotOpenOkEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	local SelectPetindex = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			SelectPetindex = i
		end
	end
	
	PetDecoSlotOpen(SelectPetindex, PetStatOpenIndex)
end
	
function PetStatSlotOpenCancelEvent()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "PetStatSlotOpenCancelEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end	
	
	
	
	
	
	
	
-- 펫 강화 확인 취소버튼
PetStatUpgradeOkCancelBtnName	= {['protecterr']=0, "PetStatUpgradeOk", "PetStatUpgradeCancel"}
PetStatUpgradeOkCancelTextX		= {['protecterr']=0, 	460 , 460 + 117 }
PetStatUpgradeOkCancelEvent		= {['protecterr']=0,  "NotifyPetStatUpgradeOk", "PetStatUpgradeMainWindowClose" }

for i=1, #PetStatUpgradeOkCancelBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetStatUpgradeOkCancelBtnName[i])
	mywindow:setTexture("Normal", "UIData/pet_02.tga", PetStatUpgradeOkCancelTextX[i], 0)
	mywindow:setTexture("Hover", "UIData/pet_02.tga", PetStatUpgradeOkCancelTextX[i], 30)
	mywindow:setTexture("Pushed", "UIData/pet_02.tga", PetStatUpgradeOkCancelTextX[i], 60)
	mywindow:setTexture("PushedOff", "UIData/pet_02.tga", PetStatUpgradeOkCancelTextX[i], 0)
	mywindow:setTexture("Disabled", "UIData/pet_02.tga", PetStatUpgradeOkCancelTextX[i], 90)
	mywindow:setPosition(75+(132*i)-132, 428)
	mywindow:setSize(117, 30)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", PetStatUpgradeOkCancelEvent[i])
	winMgr:getWindow("PetStatUpgrade_MainWindow"):addChildWindow(mywindow)
end



function NotifyPetStatUpgradeOk()
	
	local PreCreateString_pet = GetSStringInfo(LAN_PETITEM_ASKMSG_REFINE_001)
	local petstring = string.format(PreCreateString_pet, checkFixcash)
	
	ShowCommonAlertOkCancelBoxWithFunction("", petstring, 'PetStatUpgradeOkEvent', 'PetStatUpgradeCancelEvent')
	
end

function PetStatUpgradeOkEvent()
	
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "PetStatUpgradeOkEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	local SelectPetindex = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			SelectPetindex = i
		end
	end
	
	local select1 = 1
	local select2 = 1
	local select3 = 1
	
	if CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck1")):isSelected() then
		select1 = 0
	end
	
	if CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck2")):isSelected() then
		select2 = 0
	end
	
	if CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck3")):isSelected() then
		select3 = 0
	end
	  
	RequestPetDecoUpgrade(SelectPetindex, select1, select2, select3, checkFixcash)

end


function PetStatUpgradeCancelEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "PetStatUpgradeCancelEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end




-- 펫 강화 ui 세팅(초기화)
function SettingPetDecoUpgradeUi(filename)

	-- 초기화
	for i=1, PET_DECO_MAX_STAT do
		CEGUI.toCheckbox(winMgr:getWindow("PetStatUpgradeStatCheck"..i)):setProperty('Selected', 'false');
		winMgr:getWindow("PetStatUpgradeStatCheck"..i):setVisible(false)
		winMgr:getWindow("PetStatUpgrade_"..i):setVisible(true)
		winMgr:getWindow("PetStatUpgradeimg"..i):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("PetStatUpgradeText"..i):setTextExtends( "" , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
	end
	winMgr:getWindow("PetStatUpgrade_cash"):setTextExtends(CommatoMoneyStr(PET_UPGRADE_NORMAL), g_STRING_FONT_GULIMCHE,18, 255, 255, 0 ,255,  0,  0,0,0,255);
	
	
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	root:addChildWindow(winMgr:getWindow("PetStatUpgrade_MainWindow"))
	winMgr:getWindow("PetStatUpgrade_MainWindow"):setVisible(true)
	
	winMgr:getWindow("PetStatUpgradeItemimg"):setTexture("Enabled", filename, 0, 0)
end

-- 펫 강화 ui 세팅
function SettingPetUpgradeUiStat(index, stattype, statvalue, statmin , statmax)
	
	if stattype > -1 then
		winMgr:getWindow("PetStatUpgrade_"..index):setVisible(false)
		winMgr:getWindow("PetStatUpgradeimg"..index):setTexture("Enabled", "UIData/pet_02.tga", 885, stattype*45)
		winMgr:getWindow("PetStatUpgradeText"..index):setTextExtends( statvalue .." ("..statmin.."  ~  "..statmax..")" , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
		winMgr:getWindow("PetStatUpgradeStatCheck"..index):setVisible(true)
		if stattype == 2 or stattype == 13 then
			winMgr:getWindow("PetStatUpgradeText"..index):setTextExtends( (statvalue/10).."."..(statvalue%10).."%"
			.." ("..(statmin/10).."."..(statmin%10).."  ~  "..(statmax/10).."."..(statmax%10)..")" , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
		end
	end
end


function SettingPetUpgradeEnble()
	
	-- 펫 강화오픈은 순차적으로 할수 있게
	
	local visibleIndex = 0
	
	for i=1, PET_DECO_MAX_STAT  do
		if winMgr:getWindow("PetStatUpgrade_"..i):isVisible()  then
			visibleIndex = i 
			break;
		end
	end
	
	
	for i=1, PET_DECO_MAX_STAT  do
		if i > visibleIndex then
			winMgr:getWindow("PetStatUpgrade_"..i):setEnabled(false)
		else
			winMgr:getWindow("PetStatUpgrade_"..i):setEnabled(true)
		end
	end
	
	DebugStr('visibleIndex:'..visibleIndex )
	
	if visibleIndex == 1 then
		winMgr:getWindow("PetStatUpgradeNoticeimg"):setTexture("Enabled", "UIData/pet_02.tga", 687, 280)
		--winMgr:getWindow("PetStatUpgrade_cash"):setTextExtends(CommatoMoneyStr(0), g_STRING_FONT_GULIMCHE,18, 255, 255, 0 ,255,  0,  0,0,0,255);
		winMgr:getWindow("PetStatUpgradeOk"):setEnabled(false)
	elseif visibleIndex == 3 then
		winMgr:getWindow("PetStatUpgradeNoticeimg"):setTexture("Enabled", "UIData/pet_02.tga", 687, 280+55)
		winMgr:getWindow("PetStatUpgradeOk"):setEnabled(true)
	elseif visibleIndex == 0 then
		winMgr:getWindow("PetStatUpgradeNoticeimg"):setTexture("Enabled", "UIData/pet_02.tga", 687, 280+55)
		winMgr:getWindow("PetStatUpgradeOk"):setEnabled(true)
	else
		winMgr:getWindow("PetStatUpgradeNoticeimg"):setTexture("Enabled", "UIData/invisible.tga", 687, 280)
		winMgr:getWindow("PetStatUpgradeOk"):setEnabled(true)
	end
	
end
