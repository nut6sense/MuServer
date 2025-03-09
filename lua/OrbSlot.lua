--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_curPage_OrbItemList = 1
g_maxPage_OrbItemList = 1

local RewardMoney = 0
local itemDesc = ""
EffectAnimate = 0
StopAEffectAnimate1 = 0
StopAEffectAnimate2 = 0
StopAEffectAnimate3 = 0


--------------------------------------------------------------------

-- Orb Slot Machine 검은 배경(와이드)

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbSlot_Background_BlackImage")
mywindow:setTexture("Enabled", "UIData/black.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/black.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


--------------------------------------------------------------------

-- Orb Slot Machine 기본 바탕 윈도우

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbSlot_Background_Image")
mywindow:setTexture("Enabled", "UIData/slot.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/slot.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("OrbSlot_Background_Image", "CloseOrbSlotMachine")
--RegistEscEventInfo("OrbChangeMainImage", "OrbCancelBtnEvent")

-- Orb Slot Machine Count (갯수 표시)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbSlotCountText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(200, 446)
mywindow:setSize(80, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)


-- Orb Slot Machine 종료버튼 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbSlot_CloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(830, 140)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "CloseOrbSlotMachine")
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)

-- Orb Slot Machine 닫기
function CloseOrbSlotMachine()
	if winMgr:getWindow("OrbChangeMainImage"):isVisible() then  -- 교환창이 열려있을시 교환창을 닫는다
		OrbCancelBtnEvent()
		return
	end
	
	if winMgr:getWindow("RewardBackImage"):isVisible() then
		OnClickRewardOk();
	end
	--root:addChildWindow(winMgr:getWindow("OrbSlot_Background_Image"))
	winMgr:getWindow("OrbSlot_Background_BlackImage"):setVisible(false)
	winMgr:getWindow("OrbSlot_Background_Image"):setVisible(false)
	ORB_Machine_Close()
	ClickObject_ORBSLOT(false)
end

-- Orb Slot Machine 열기
function ShowOrbSlotMachine()
	root:addChildWindow(winMgr:getWindow("OrbSlot_Background_BlackImage"))
	root:addChildWindow(winMgr:getWindow("OrbSlot_Background_Image"))
	ResetOrbSlotImage()
	winMgr:getWindow("OrbSlot_Background_BlackImage"):setVisible(true)
	winMgr:getWindow("OrbSlot_Background_Image"):setVisible(true)
	RequestOrbList()  -- ORBLIST 요청
end

----------테스트용 버튼들 
--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbSlot_OpenBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(50, 50)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "ShowOrbSlotMachine")
root:addChildWindow(mywindow)
--]]
--------------- Orb Start 시작버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "OrbSlot_StartBtn")
mywindow:setTexture("Normal", "UIData/slot.tga", 681, 877)
mywindow:setTexture("Hover", "UIData/slot.tga", 746, 877)
mywindow:setTexture("Pushed", "UIData/slot.tga", 811, 877)
mywindow:setTexture("PushedOff","UIData/slot.tga", 811, 877)
mywindow:setPosition(480, 180)
mywindow:setSize(65, 65)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "startMachine")
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)

function startMachine()
	ORB_Machine_Start()
	--[[
	for i=1 , 1000 do
		ORB_Machine_StartAuto()
	end
	--]]
	
end


-- 슬롯머신 3개의 Stop 이미지
local OrbSlotStopBtnImage  = {["err"]=0, "OrbSlotStopBtn1", "OrbSlotStopBtn2" ,"OrbSlotStopBtn3"}
local OrbSlotStopBtnPosX  = {["err"]=0, 183, 292 , 405}

for i=1, #OrbSlotStopBtnImage do
	mywindow = winMgr:createWindow("TaharezLook/Button", OrbSlotStopBtnImage[i])
	mywindow:setTexture("Normal", "UIData/slot.tga", 941, 769)
	mywindow:setTexture("Hover", "UIData/slot.tga", 941, 812)
	mywindow:setTexture("Pushed", "UIData/slot.tga", 941, 855)
	mywindow:setTexture("PushedOff", "UIData/slot.tga", 941, 855)
	mywindow:setPosition(OrbSlotStopBtnPosX[i], 570)
	mywindow:setSize(83, 43)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString('StopIndex', tostring(i))
	mywindow:setSubscribeEvent("Clicked", "StopBtnPush")
	winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)
end

function StopBtnPush(args)
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("StopIndex"))
	ORB_Machine_Stop(index)
end



-----------------------------------------------------------------------
--ORB 교체하기 뜨는 창 이미지관련
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--ORB 알파이미지
-----------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)
-----------------------------------------------------------------------
----------------------------------------------------------------------
--Orb 아이템 체인지 메인 백판(선택후)
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbChangeMainImage")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(200, 250)
mywindow:setSize(349, 269)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)



-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbSelectItemImage")
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
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 창 제목
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbChangeTitle")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 677, 0)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 677, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(95, 10)
mywindow:setSize(159, 19)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 창 설명
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbChangeExplain")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 518, 41)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 518, 41)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 195)
mywindow:setSize(307, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbSelectItemName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 60)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)
	
-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbSelectItemCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 75)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)

-- 아이템 갯수(임시저장용)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbSelectItemCount2")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 75)
mywindow:setSize(220, 20)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)
	
-- 아이템 기간
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbSelectItemPeriod")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(145, 90)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 교환하기 글자 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbSelectItemAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 921, 195)
mywindow:setTexture("Disabled", "UIData/deal.tga", 921, 195)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 120)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 수량 입력칸
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbSelectItemInputImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 921, 172)
mywindow:setTexture("Disabled", "UIData/deal.tga", 921, 172)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(220, 120)
mywindow:setSize(69, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)

-- 수량 입력 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "OrbSelectItem_editbox")
mywindow:setPosition(220, 120)
mywindow:setSize(69, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(5)
mywindow:subscribeEvent("TextAccepted", "OrbOkBtnEvent")
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)


-- 슬롯머신 3개의 아이템 이미지
local OrbSlotItemImage  = {["err"]=0, "OrbSlotItemImage1", "OrbSlotItemImage2" ,"OrbSlotItemImage3"}
local OrbSlotItemImagePosX  = {["err"]=0, 190, 301 , 411}

for i=1, #OrbSlotItemImage do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", OrbSlotItemImage[i])
	mywindow:setTexture("Enabled", "UIData/blackfadein.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/blackfadein.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(OrbSlotItemImagePosX[i], 478)
	mywindow:setSize(72, 72)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("AS_PresentBoxControler", "SlotEvent", "y", "Sine_EaseInOut", 474, 481, 1, true, false, 10)
	mywindow:addController("AS_PresentBoxControler", "SlotEvent", "y", "Sine_EaseInOut", 476, 479, 1, true, false, 10)
	mywindow:addController("AS_PresentBoxControler", "SlotEvent", "y", "Sine_EaseInOut", 477, 478, 1, true, false, 10)
	winMgr:getWindow('OrbSlot_Background_Image'):addChildWindow(mywindow)
end


------------------------------------------------------
-- 슬롯머신 3개의 루프 돌리기
------------------------------------------------------
function UpdateChangeSlotImage(type, filename)
	winMgr:getWindow(OrbSlotItemImage[type]):setTexture("Enabled", filename, 0, 0)
	winMgr:getWindow(OrbSlotItemImage[type]):setTexture("Disabled", filename, 0, 0)
end

------------------------------------------------------
-- 슬롯머신 스탑이미지 깜빡이기
------------------------------------------------------
function UpdateStopBtnEffect(type)

	if type == 1 then
		if StopAEffectAnimate1 == 0 then
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 769)
			StopAEffectAnimate1 = 1 
		else
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 812)
			StopAEffectAnimate1 = 0
		end	
	elseif type == 2 then
		if StopAEffectAnimate2 == 0 then
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 769)
			StopAEffectAnimate2 = 1 
		else
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 812)
			StopAEffectAnimate2 = 0
		end
		
	else 
		if StopAEffectAnimate3 == 0 then
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 769)
			StopAEffectAnimate3 = 1 
		else
			winMgr:getWindow(OrbSlotStopBtnImage[type]):setTexture("Normal", "UIData/slot.tga", 941, 812)
			StopAEffectAnimate3 = 0
		end
	end
   
end

function UpdateChangeSlotImageStop(type, filename)
	DebugStr('filename:'..filename)
	winMgr:getWindow(OrbSlotItemImage[type]):setTexture("Enabled", filename, 0, 0)
	winMgr:getWindow(OrbSlotItemImage[type]):setTexture("Disabled", filename, 0, 0)
	winMgr:getWindow(OrbSlotItemImage[type]):clearActiveController()
	winMgr:getWindow(OrbSlotItemImage[type]):activeMotion("SlotEvent");
end


-- 수량 입력 좌우버튼
local tOrbCountLRButtonName  = {["err"]=0, [0]="Orb_InputCount_LBtn", "Orb_InputCount_RBtn"}
local tOrbCountLRButtonTexX  = {["err"]=0, [0]= 889, 905}
local tOrbCountLRButtonPosX  = {["err"]=0, [0]= 200, 293}
local tOrbCountLRButtonEvent = {["err"]=0, [0]="OrbInputCount_L", "OrbInputCount_R"}
for i=0, #tOrbCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tOrbCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tOrbCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tOrbCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tOrbCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tOrbCountLRButtonTexX[i], 172)
	mywindow:setPosition(tOrbCountLRButtonPosX[i], 123)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tOrbCountLRButtonEvent[i])
	winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)
end

function OrbInputCount_L()
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("OrbSelectItem_editbox"):getText()
	DebugStr('수량:'..amountText);
	if amountText == "" then
		amountText = "1"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	if inputAmount <= 1 then
		inputAmount = 1
		winMgr:getWindow("OrbSelectItem_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("OrbSelectItem_editbox"):setText(tostring(inputAmount))
	end
end


function OrbInputCount_R()

	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("OrbSelectItem_editbox"):getText()
	DebugStr('수량:'..amountText);
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	DebugStr('inputAmount:'..inputAmount);
	-- 현재 가능한 수량을 구해서 비교한다.
	
	local limitAmount = tonumber(winMgr:getWindow("OrbSelectItemCount2"):getText())

	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("OrbSelectItem_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount + 1
		winMgr:getWindow("OrbSelectItem_editbox"):setText(tostring(inputAmount))
	end
	
end

OrbOkCancelBtn	= {['protecterr']=0, "OrbOkBtn", "OrbCancelBtn"}
OrbOkCancelTexX	= {['protecterr']=0,	693,  858}
OrbOkCancelPosX	= {['protecterr']=0,	4,	  170}
OrbOkCancelEvent	= {['protecterr']=0, "OrbOkBtnEvent", "OrbCancelBtnEvent"}

-- 확인 취소 버튼
for i = 1, #OrbOkCancelBtn do
	mywindow = winMgr:createWindow("TaharezLook/Button", OrbOkCancelBtn[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", OrbOkCancelTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", OrbOkCancelTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", OrbOkCancelTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", OrbOkCancelTexX[i], 849)
	mywindow:setPosition(OrbOkCancelPosX[i], 237)
	mywindow:setSize(166, 29)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", OrbOkCancelEvent[i])
	winMgr:getWindow('OrbChangeMainImage'):addChildWindow(mywindow)
end

---------------------------------------------------------------------
-- ORB  칩 교체 확인
-----------------------------------------------------------------------
function OrbOkBtnEvent()
	local InputAmout = tonumber(winMgr:getWindow("OrbSelectItem_editbox"):getText())
	local limitAmount = tonumber(winMgr:getWindow("OrbSelectItemCount2"):getText())
	
	if InputAmout > limitAmount then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_1133,'OnClickAlertOkSelfHide');
	end										--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_6)
	ORB_Machine_Insert(InputAmout)
end

---------------------------------------------------------------------
-- ORB  칩 교체 취소
-----------------------------------------------------------------------
function OrbCancelBtnEvent()
	CloseOrbSelect()
	return
end
---------------------------------------------------------------------
-- ORB 교체 창을 닫는다
-----------------------------------------------------------------------
function CloseOrbSelect()
	
	--ItemChangeRegisterReset()
	winMgr:getWindow("OrbChangeMainImage"):setVisible(false)
	winMgr:getWindow('OrbAlphaImage'):setVisible(false)
end


---------------------------------------------------------------------
--ORB 아이템 리스트 백판 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbItemImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(550,180);
mywindow:setSize(296, 438)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('OrbSlot_Background_Image'):addChildWindow(mywindow)


-----------------------------------------------------------------------
-- orb 아이템 목록 창 라디오버튼
-----------------------------------------------------------------------
tOrbItemRadio =
{ ["protecterr"]=0, "OrbItemList_1", "OrbItemList_2", "OrbItemList_3", "OrbItemList_4", "OrbItemItemList_5"}


for i=1, #tOrbItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tOrbItemRadio[i]);	
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
	winMgr:getWindow('OrbItemImage'):addChildWindow( winMgr:getWindow(tOrbItemRadio[i]) );
	
		
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbItemList_Image_"..i)
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
	winMgr:getWindow(tOrbItemRadio[i]):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "OrbItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("OrbRadioIndex", i)
	--mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_OrbItemListInfo")
	--mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_OrbVanishTooltip")
	winMgr:getWindow(tOrbItemRadio[i]):addChildWindow(mywindow)
	
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tOrbItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tOrbItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tOrbItemRadio[i]):addChildWindow(mywindow)
end

-- 칩개수 표시
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbChipCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,200,255)
mywindow:setText("0")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(100, 347)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
--winMgr:getWindow("OrbItemImage"):addChildWindow(mywindow)
-----------------------------------------------------------------------
--아이템 리스트 첨부 버튼 5개
-----------------------------------------------------------------------
 
tOrbItemButton =
{ ["protecterr"]=0, "OrbItemButton_1", "OrbItemButton_2", "OrbItemButton_3", "OrbItemButton_4", "OrbItemButton_5"}
 

for i=1, #tOrbItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tOrbItemButton[i]);	
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
	mywindow:setTexture("Normal", "UIData/slot.tga", 969, 898)
	mywindow:setTexture("Hover", "UIData/slot.tga", 969, 916)
	mywindow:setTexture("Pushed", "UIData/slot.tga", 969, 934)
	mywindow:setTexture("PushedOff", "UIData/slot.tga", 969, 952)
	mywindow:setSize(55,18 );	
	mywindow:setPosition(220,95+(i-1)*54);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false);
	mywindow:setUserString('OrbIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tOrbItemButtonEvent")
	winMgr:getWindow('OrbItemImage'):addChildWindow( winMgr:getWindow(tOrbItemButton[i]));
end




-----------------------------------------------------------------------
-- ORB 아이템 이름 파일이름 갯수등을 설정
-----------------------------------------------------------------------
function SetupOrbItemList(i, itemName, itemFileName, itemUseCount)
    
    local j=i+1
	winMgr:getWindow(tOrbItemRadio[j]):setVisible(true)
	winMgr:getWindow(tOrbItemButton[j]):setVisible(true)
	
	-- 아이템 파일이름
	winMgr:getWindow("OrbItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("OrbItemList_Image_"..j):setScaleWidth(102)
	winMgr:getWindow("OrbItemList_Image_"..j):setScaleHeight(102)
	
	-- 아이템 이름
	winMgr:getWindow("OrbItemList_Name_"..j):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("OrbItemList_Num_"..j):setText(szCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("OrbItemList_Period_"..j):setText(period)		
end

------------------------------------
---페이지표시텍스트
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OrbItemList_PageText")
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
winMgr:getWindow('OrbItemImage'):addChildWindow(mywindow)

------------------------------------
---페이지앞뒤버튼
------------------------------------
local tMyOrbItemList_BtnName  = {["err"]=0, [0]="MyOrbItemList_LBtn", "MyOrbItemList_RBtn"}
local tMyOrbItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
local tMyOrbItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
local tMyOrbItemList_BtnEvent = {["err"]=0, [0]= "OnClickOrbItemList_PrevPage", "OnClickOrbItemList_NextPage"}
for i=0, #tMyOrbItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyOrbItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyOrbItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyOrbItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyOrbItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyOrbItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyOrbItemList_BtnPosX[i], 378)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyOrbItemList_BtnEvent[i])
	winMgr:getWindow('OrbItemImage'):addChildWindow(mywindow)
end

---------------------------------------------------
-- OrbItemList 현재 페이지 / 최대 페이지
---------------------------------------------------
function OrbItemListPage(curPage, maxPage)
	g_curPage_OrbItemList = curPage
	g_maxPage_OrbItemList = maxPage
	
	winMgr:getWindow("OrbItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---이전페이지이벤트-------------------
------------------------------------
		 
function  OnClickOrbItemList_PrevPage()
  
	if	g_curPage_OrbItemList > 1 then
			g_curPage_OrbItemList = g_curPage_OrbItemList - 1
			ChangedOrbItemListCurrentPage(g_curPage_OrbItemList)
	end
	
end
------------------------------------
---다음페이지이벤트-----------------
------------------------------------
function OnClickOrbItemList_NextPage()

	if	g_curPage_OrbItemList < g_maxPage_OrbItemList then
			g_curPage_OrbItemList = g_curPage_OrbItemList + 1
			ChangedOrbItemListCurrentPage(g_curPage_OrbItemList)
	end
	
end


--------------------------------------------------------------------
-- 알파 뒷판 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 뒷판이미지 위에 붙는 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardBackImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition((1024 - 339) / 2, (768 - 267) / 2)
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("EndRender", "OrbRewardRender");
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 아이템 받을시 나오는 백판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemBackImage")
mywindow:setTexture("Enabled", "UIData/slot.tga", 0, 768)
mywindow:setTexture("Disabled", "UIData/slot.tga", 0, 768)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(4, 38 )
mywindow:setSize(333, 198)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 꽝 받을시 나오는 백판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardFailBackImage")
mywindow:setTexture("Enabled", "UIData/slot.tga", 333, 768)
mywindow:setTexture("Disabled", "UIData/slot.tga", 333, 768)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition( 70, 80 )
mywindow:setSize(213, 77)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 보상 아이템 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardItem_Image")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(110, 86)
mywindow:setSize(128, 128)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 보상 아이템 개수
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RewardItem_count")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(70, 70)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RewardItem_Image"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 보상 아이템 이름
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RewardItem_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(30, 160)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RewardItemBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 보상 확인 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "RewardOkbtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setSize(331, 29)
mywindow:setPosition(4, 234)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickRewardOk")
winMgr:getWindow("RewardBackImage"):addChildWindow(mywindow)

-----------------------------------------------------------------------
-- ORB 아이템 리스트 리셋
-----------------------------------------------------------------------
function ClearOrbItemList()
    
	for i=1, 5 do
		winMgr:getWindow(tOrbItemRadio[i]):setVisible(false)
		winMgr:getWindow(tOrbItemButton[i]):setVisible(false)
	end
end


-----------------------------------------------------------------------
-- 슬롯3개의 이미지를 리셋
-----------------------------------------------------------------------
function ResetOrbSlotImage()
	for i=1, 3 do
	winMgr:getWindow(OrbSlotItemImage[i]):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow(OrbSlotItemImage[i]):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
end


function OrbRewardRender(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	if RewardMoney > 0 then
		local _left = DrawEachNumberA("UIData/other001.tga", RewardMoney, 8, 226, 105, 11, 725, 24, 33, 25, 255, drawer)
		drawer:drawTextureA("UIData/other001.tga", _left-30, 105+2, 30, 29, 266, 727, 255)
	end
	--[[
	if itemDesc ~= ""  or RewardMoney > 0 then
		drawer:setTextColor(250,250,250,255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
		NoticeText = PreCreateString_1022	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_5)
		drawer:drawText(NoticeText, 100, 195)
	end
	--]]
end


-----------------------------------------------------------------------
-- 보상이미지 세팅 
-----------------------------------------------------------------------
function RewardItemNotice(itemPath , itemName , count ,RewarditemDesc)
	
	RewardMoney = 0
	itemDesc = itemName
	DebugStr('itemName:'..itemName)
	winMgr:getWindow("RewardAlphaImage"):setVisible(true)
	winMgr:getWindow("RewardBackImage"):setVisible(true)
	DebugStr('itemName:'..itemName)
	winMgr:getWindow("RewardItem_count"):setText("")
	if itemName == "" then
		winMgr:getWindow("RewardFailBackImage"):setVisible(true)
	else
		winMgr:getWindow("RewardItemBackImage"):setVisible(true)
	end
	winMgr:getWindow("RewardItem_Image"):setTexture("Enabled", itemPath, 0, 0)
	winMgr:getWindow("RewardItem_Image"):setTexture("Disabled", itemPath, 0, 0)
	winMgr:getWindow("RewardItem_Image"):setPosition(120, 86)
	winMgr:getWindow("RewardItem_Name"):setText(itemName)
	if count > 0 then
		winMgr:getWindow("RewardItem_count"):setText('x'..count)
	end
	
end

function RewardItemNoticeETC(itemPath , MoneyAmount)
	RewardMoney = MoneyAmount
	itemDesc = ""
	winMgr:getWindow("RewardAlphaImage"):setVisible(true)
	winMgr:getWindow("RewardBackImage"):setVisible(true)
	winMgr:getWindow("RewardItem_Image"):setTexture("Enabled", itemPath, 0, 0)
	winMgr:getWindow("RewardItem_Image"):setTexture("Disabled", itemPath, 0, 0)
	winMgr:getWindow("RewardItem_Image"):setPosition(30, 66)
	winMgr:getWindow("RewardItem_Name"):setText("")
	winMgr:getWindow("RewardItem_count"):setText("")
	
end

-----------------------------------------------------------------------
-- 보상확인 버튼 클릭
-----------------------------------------------------------------------

function OnClickRewardOk()
	winMgr:getWindow("RewardAlphaImage"):setVisible(false)
	winMgr:getWindow("RewardBackImage"):setVisible(false)
	winMgr:getWindow("RewardItemBackImage"):setVisible(false)
	winMgr:getWindow("RewardFailBackImage"):setVisible(false)
	winMgr:getWindow("RewardItem_Image"):setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("RewardItem_Image"):setTexture("Disabled",  "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("RewardItem_Name"):setText("")
end

-----------------------------------------------------------------------
-- 슬롯머신 4개의 칩 개수 이미지
-----------------------------------------------------------------------
local ChipNumberImage  = {["err"]=0, "ChipNumberImage1", "ChipNumberImage2" ,"ChipNumberImage3" , "ChipNumberImage4"}
local ChipNumberImagePosX  = {["err"]=0, 290, 325 , 360 , 395}

for i=1, #ChipNumberImage do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", ChipNumberImage[i])
	mywindow:setTexture("Enabled",  "UIData/slot.tga", 601, 769)
	mywindow:setTexture("Disabled",  "UIData/slot.tga", 601, 769)
	mywindow:setPosition(ChipNumberImagePosX[i], 395)
	mywindow:setSize(34, 48)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)
end

-----------------------------------------------------------------------
-- Light Effect Image
----------------------------------------------------------------------

for i=1, 44  do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LightEffectImage"..i)
	mywindow:setTexture("Enabled",  "UIData/slot.tga", 821, 817)
	mywindow:setTexture("Disabled",  "UIData/slot.tga", 821, 817)
	
	if i <= 14 then 
		mywindow:setPosition(30+(i*60), 80)
	elseif i <= 22 then 
		mywindow:setPosition(870, 80+62*(i-14))
	elseif i <= 36 then
		mywindow:setPosition(930 - ((i-22)*60), 640)
	else
		mywindow:setPosition(90 , 638 - 62*(i-36))
	end
	
	mywindow:setSize(60, 60)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("OrbSlot_Background_Image"):addChildWindow(mywindow)
end


function AnimateReadyEffect()
	
	local EffectXpos = 821
	local StartXpos  = 681
	if EffectAnimate == 0 then
		EffectXpos = 821
		StartXpos = 681
	else
		EffectXpos = 881
		StartXpos = 746
	end
	
	winMgr:getWindow("OrbSlot_StartBtn"):setTexture("Normal",  "UIData/slot.tga", StartXpos, 877)
	winMgr:getWindow("OrbSlot_StartBtn"):setTexture("Normal",  "UIData/slot.tga", StartXpos, 877)
	
	for i =1 , 44 do
		winMgr:getWindow("LightEffectImage"..i):setTexture("Enabled",  "UIData/slot.tga", EffectXpos, 817)
		winMgr:getWindow("LightEffectImage"..i):setTexture("Disabled",  "UIData/slot.tga", EffectXpos, 817)
	end
	
	if EffectAnimate == 0 then
		EffectAnimate = 1
	else
		EffectAnimate = 0
	end
end

function AnimateMoveEffect(EffectMoveCount1, EffectMoveCount2, EffectMoveCount3, EffectMoveCount4)

	
	winMgr:getWindow("LightEffectImage"..EffectMoveCount1):setTexture("Enabled",  "UIData/slot.tga", 761, 817)
	winMgr:getWindow("LightEffectImage"..EffectMoveCount1):setTexture("Disabled",  "UIData/slot.tga", 761, 817)
	
	winMgr:getWindow("LightEffectImage"..EffectMoveCount2):setTexture("Enabled",  "UIData/slot.tga", 701, 817)
	winMgr:getWindow("LightEffectImage"..EffectMoveCount2):setTexture("Disabled",  "UIData/slot.tga", 701, 817)
	
	winMgr:getWindow("LightEffectImage"..EffectMoveCount3):setTexture("Enabled",  "UIData/slot.tga", 641, 817)
	winMgr:getWindow("LightEffectImage"..EffectMoveCount3):setTexture("Disabled",  "UIData/slot.tga", 817, 817)
	
	winMgr:getWindow("LightEffectImage"..EffectMoveCount4):setTexture("Enabled",  "UIData/slot.tga", 581, 817)
	winMgr:getWindow("LightEffectImage"..EffectMoveCount4):setTexture("Disabled",  "UIData/slot.tga", 817, 817)
	
end

function EffectAnimateReset()
	for i =1 , 44 do
		winMgr:getWindow("LightEffectImage"..i):setTexture("Enabled",  "UIData/slot.tga", 821, 817)
		winMgr:getWindow("LightEffectImage"..i):setTexture("Disabled",  "UIData/slot.tga", 821, 817)
	end
end
-----------------------------------------------------------------------
-- 슬롯머신을 사용할 칩의 개수를 세팅
-----------------------------------------------------------------------
function ChipCountCheck(chipcount)
	winMgr:getWindow("OrbChipCount"):setText(chipcount)
	
	if chipcount > 9999 then
		chipcount = 9999
	end
	
	local thousand = chipcount / 1000
	chipcount = chipcount - (thousand * 1000) 
	local hundread = chipcount / 100
	chipcount = chipcount - (hundread * 100)
	local ten = chipcount / 10
	chipcount = chipcount - (ten * 10)
	local count = chipcount
	
	winMgr:getWindow(ChipNumberImage[1]):setTexture("Enabled",  "UIData/slot.tga", 601+34*thousand , 769)
	winMgr:getWindow(ChipNumberImage[2]):setTexture("Enabled",  "UIData/slot.tga", 601+34*hundread , 769)
	winMgr:getWindow(ChipNumberImage[3]):setTexture("Enabled",  "UIData/slot.tga", 601+34*ten , 769)
	winMgr:getWindow(ChipNumberImage[4]):setTexture("Enabled",  "UIData/slot.tga", 601+34*count , 769)
	
end


-----------------------------------------------------------------------
-- ORB 교환창 호출
-----------------------------------------------------------------------
function tOrbItemButtonEvent(args)	

	winMgr:getWindow("OrbAlphaImage"):setVisible(true)
	winMgr:getWindow("OrbChangeMainImage"):setVisible(true)
	DebugStr('tMaiItemButtonEvent start');
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("OrbIndex")
	DebugStr("첨부리스트index:"..index);
	index=index-1
	local bEnable = SelectOrbItem(tonumber(index))
	if bEnable then
		OrbSelectItem()
	end
end
-----------------------------------------------------------------------
-- ORB 교환창 내용 설정
-----------------------------------------------------------------------
function OrbSelectItem()

	local itemCount, itemName, itemFileName, itemskillLevel = GetSelectOrbItemInfo()
	DebugStr('itemCount:'..itemCount);
	DebugStr('itemName:'..itemName);
	DebugStr('itemFileName:'..itemFileName);
	DebugStr('itemskillLevel:'..itemskillLevel);
	
	
	-- 아이템 파일이름
	winMgr:getWindow("OrbSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("OrbSelectItemImage"):setScaleWidth(200)
	winMgr:getWindow("OrbSelectItemImage"):setScaleHeight(200)
	
	-- 아이템 이름
	winMgr:getWindow("OrbSelectItemName"):setText(itemName)
		
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("OrbSelectItemCount"):setText(szcount)
	winMgr:getWindow("OrbSelectItemCount2"):setText(itemCount)
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("OrbSelectItemPeriod"):setText(period)
	
	winMgr:getWindow("OrbSelectItem_editbox"):setText(itemCount)
	winMgr:getWindow("OrbSelectItem_editbox"):activate()
end


function OnMouseEnter_OrbItemListInfo(args)
	DebugStr('OnMouseEnter_OrbItemListInfo()')
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)

	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("OrbRadioIndex"))
	DebugStr('index:'..index)
	index = index-1
	
	local itemKind, itemNumber = GetAdaptTooltipInfo(WINDOW_MYITEM_LIST, index)
	
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_OrbVanishTooltip()
	SetShowToolTip(false)	
end



