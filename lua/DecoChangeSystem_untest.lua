-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

local WIDTH, HEIGHT = DecoGetWindowSize()

local ANI_TIME 		= 0
local COIN_ANI_TIME = 0

local RESULT_SECCESS = 0
local RESULT_FAIL	 = 1
local RESULT_SAME    = 2

local RESULT	 = -1

local GRADENUMBER = -1

local COIN_RESULT = -1

local GRADE_LOW			= 0
local GRADE_MEDIUM		= 1	
local GRADE_HIGH		= 2
local GRADE_UNIQUE		= 3	
local GRADE_RARE		= 4

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Image BG
--------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoChangeSystemBG")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(30, 230)
mywindow:setSize(339, 329)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(140, 68)
mywindow:setSize(105, 105)
mywindow:setScaleWidth(150)
mywindow:setScaleHeight(150)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow( winMgr:getWindow("DecoUpgradeImg") )

--------------------------------------------------------------------
-- 결과 Ani Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeCoinAniImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 339, 331)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 339, 331)
mywindow:setPosition(119, 48)
mywindow:setSize(100, 100)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

function DecoCoinAnimationStart(NowTime)
	COIN_ANI_TIME = NowTime
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setVisible(true)
end

function DecoCoinAnimationEnd()
	COIN_ANI_TIME = 0
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Enabled", "UIData/Deco.tga", 339, 331)
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Disabled", "UIData/Deco.tga", 339, 331)
	
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setVisible(false)
	DecoUpgradeCoinSlotInit()
	DecoCoinAnimation()	
end

local CoinTexX = 0
local CoinTexY = 0

function DecoCoinAnimationRoot(NowTime)
	-- Khunpon.ka 
	-- Sep 28, 2022
	-- Remove animation	

	if CoinTexY == 0 then
		if CoinTexX > 3 then
			CoinTexX = 0
			CoinTexY = 1
		end
	elseif CoinTexY == 1 then
		if CoinTexX > 1 then
			CoinTexX = 0
			CoinTexY = 0
		end
	end
	
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Enabled", "UIData/Deco.tga", 339 + (CoinTexX * 100), 331 + (CoinTexY * 100))
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Disabled", "UIData/Deco.tga", 339 + (CoinTexX * 100), 331 + (CoinTexY * 100))

	CoinTexX = CoinTexX + 1
	COIN_ANI_TIME = NowTime
end
function DecoCoinAnimationRoot_unused(NowTime)
			
	local TimeTick = NowTime - COIN_ANI_TIME
	if TimeTick < 150 then
		return
	end
	
	if CoinTexY == 0 then
		if CoinTexX > 3 then
			CoinTexX = 0
			CoinTexY = 1
		end
	elseif CoinTexY == 1 then
		if CoinTexX > 1 then
			CoinTexX = 0
			CoinTexY = 0
		end
	end
	
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Enabled", "UIData/Deco.tga", 339 + (CoinTexX * 100), 331 + (CoinTexY * 100))
	winMgr:getWindow("DecoUpgradeCoinAniImg"):setTexture("Disabled", "UIData/Deco.tga", 339 + (CoinTexX * 100), 331 + (CoinTexY * 100))

	CoinTexX = CoinTexX + 1
	COIN_ANI_TIME = NowTime
end
--------------------------------------------------------------------
-- DecoChangeSysTem Popup Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeCoinImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(186, 149)
mywindow:setSize(105, 105)
mywindow:setScaleWidth(90)
mywindow:setScaleHeight(90)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow( winMgr:getWindow("DecoUpgradeCoinImg") )

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeCoinCheckButton")
mywindow:setTexture("Normal", "UIData/deco.tga", 423, 0)
mywindow:setTexture("Hover", "UIData/deco.tga", 423, 27)
mywindow:setTexture("Pushed", "UIData/deco.tga", 423, 54)
mywindow:setTexture("PushedOff", "UIData/deco.tga", 423, 81)
mywindow:setPosition(245, 155)
mywindow:setSize(66, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoUpgradeCoinRegist")
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

function DecoUpgradeCoinRegist(args)
	if COIN_RESULT > -1 then
		DecoUpgradeCoinInit()
		DecoCoinAnimationEnd()
		
		winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Normal", "UIData/deco.tga", 423, 0)
		winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Hover", "UIData/deco.tga", 423, 27)
		winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Pushed", "UIData/deco.tga", 423, 54)
		winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("PushedOff", "UIData/deco.tga", 423, 81)
	else
		local bFindCoin = DecoUpgradeCoinFind()

		if bFindCoin == 0 then
			DecoCoinAnimationStartEx()
			winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Normal", "UIData/deco.tga", 489, 0)
			winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Hover", "UIData/deco.tga", 489, 27)
			winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Pushed", "UIData/deco.tga", 489, 54)
			winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("PushedOff", "UIData/deco.tga", 489, 81)
		end
	end
end

function DecoUpgradeCoinInit()
	COIN_RESULT = -1
	
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Normal", "UIData/deco.tga", 423, 0)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Hover", "UIData/deco.tga", 423, 27)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Pushed", "UIData/deco.tga", 423, 54)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("PushedOff", "UIData/deco.tga", 423, 81)
	
	winMgr:getWindow("DecoUpgradeCoinImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeCoinImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeCoinImg"):setVisible(false)
end

function DecoUpgradeCoinCheck(CoinResult, ItemFileName)
	COIN_RESULT = CoinResult
	
	if COIN_RESULT <= -1 then
		return
	end
	
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Normal", "UIData/deco.tga", 489, 0)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Hover", "UIData/deco.tga", 489, 27)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Pushed", "UIData/deco.tga", 489, 54)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("PushedOff", "UIData/deco.tga", 489, 81)
	
	winMgr:getWindow('DecoUpgradeCoinImg'):setTexture("Enabled", ItemFileName, 0, 0)
	winMgr:getWindow('DecoUpgradeCoinImg'):setTexture("Disabled", ItemFileName, 0, 0)
	winMgr:getWindow('DecoUpgradeCoinImg'):setVisible(true)
end

--------------------------------------------------------------------
-- DecoChangeSysTem Popup OK Button Image 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 0, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 0, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 0, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 0, 774)
mywindow:setPosition(79, 284)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoUpgradeReconfirm")
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow( winMgr:getWindow("DecoUpgradeButton") )

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Close Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeCloseButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 178, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 178, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 178, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 178, 774)
mywindow:setPosition(171, 284)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoChageSystemCloseButton")
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup X Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeXButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(310, 7)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoChageSystemCloseButton")
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Charge Text
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "DecoUpgradeCharge")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 112)
mywindow:setText("0")
mywindow:setPosition(188, 251)
mywindow:setSize(250, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 성공시 나오는 등급1
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeGradeImage1")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(110, 215)
mywindow:setSize(57, 14)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 성공시 나오는 등급2
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeGradeImage2")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(175, 215)
mywindow:setSize(57, 14)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoChangeSystemBG"):addChildWindow(mywindow)
	
--------------------------------------------------------------------
-- 재 확인용 Alpha
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeReconfirmAlpha")
mywindow:setTexture("Enabled", "UIData/Black.dds", 0, 0)
mywindow:setTexture("Disabled", "UIData/Black.dds", 0, 0)
mywindow:setAlpha(170)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- 재 확인용 BG 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoChangeSystemReconfirmBG")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 267, 661)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 267, 661)
mywindow:setPosition((WIDTH / 2) - (260 / 2), (HEIGHT / 2) - (145 / 2))
mywindow:setSize(306, 145)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoUpgradeReconfirmAlpha"):addChildWindow( winMgr:getWindow("DecoChangeSystemReconfirmBG") )

--------------------------------------------------------------------
-- 재 확인용 Ok Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeOkButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 89, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 89, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 89, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 89, 774)
mywindow:setPosition(64, 92)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoUpgradeCall")
winMgr:getWindow("DecoChangeSystemReconfirmBG"):addChildWindow( winMgr:getWindow("DecoUpgradeOkButton") )

--------------------------------------------------------------------
-- 재 확인용 Cancel Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeCancelButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 178, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 178, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 178, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 178, 774)
mywindow:setPosition(154, 92)
mywindow:setSize(89, 32)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DecoUpgradeCancelReconfirm")
winMgr:getWindow("DecoChangeSystemReconfirmBG"):addChildWindow( winMgr:getWindow("DecoUpgradeCancelButton") )

--------------------------------------------------------------------
-- 결과 Alpha
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeResultAlpha")
mywindow:setTexture("Enabled", "UIData/Black.dds", 0, 0)
mywindow:setTexture("Disabled", "UIData/Black.dds", 0, 0)
mywindow:setAlpha(170)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 Main Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeResultMainImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 0, 330)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 0, 330)
mywindow:setPosition((WIDTH / 2) - (220 / 2), (HEIGHT / 2) - (165 / 2))
mywindow:setSize(339, 265)
mywindow:setScaleHeight(200)
mywindow:setScaleWidth(200)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoUpgradeResultAlpha"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 BG Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeResultBGImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(18, 48)
mywindow:setSize(303, 200)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoUpgradeResultMainImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 Item Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeResultImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(122, 55)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(150)
mywindow:setScaleHeight(150)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoUpgradeResultBGImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 Ok Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "DecoUpgradeResultOKButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 89, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 89, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 89, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 89, 774)
mywindow:setPosition(106, 158)
mywindow:setSize(89, 32)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CloseDecoResultWindow")
winMgr:getWindow("DecoUpgradeResultBGImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 Ani Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeResultAniImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(61, 136)
mywindow:setSize(0, 20)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DecoUpgradeResultBGImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- Ani Alpha
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeAniAlpha")
mywindow:setTexture("Enabled", "UIData/Black.dds", 0, 0)
mywindow:setTexture("Disabled", "UIData/Black.dds", 0, 0)
mywindow:setAlpha(170)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Ani Main Image 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeAniMainImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 555, 0)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 555, 0)
mywindow:setPosition((WIDTH / 2) - (409 / 2), (HEIGHT / 2) - (241 / 2))
mywindow:setSize(469, 241)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoUpgradeAniAlpha"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Ani Image 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeAniImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 899, 241)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 899, 241)
mywindow:setPosition(245, 5)
mywindow:setSize(125, 90)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DecoUpgradeAniMainImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- DecoChangeSysTem Popup Ani White Image 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DecoUpgradeWhiteImg")
mywindow:setTexture("Enabled", "UIData/Blwhite.dds", 0, 0)
mywindow:setTexture("Disabled", "UIData/Blwhite.dds", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlpha(0)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ESC 키 System End
--------------------------------------------------------------------
RegistEscEventInfo("DecoChangeSystemBG", "DecoChageSystemEscEnd")
RegistEscEventInfo("DecoUpgradeReconfirmAlpha", "DecoUpgradeCancelReconfirm")
RegistEscEventInfo("DecoUpgradeResultAlpha", "CloseDecoResultWindow ")

--------------------------------------------------------------------
-- ESC 키 System End
--------------------------------------------------------------------
function DecoChageSystemEscEnd()
	DecoChageSystemEnd()
	DecoUpgradeCoinInit()
end

--------------------------------------------------------------------
-- Button System End
--------------------------------------------------------------------
function DecoChageSystemCloseButton()
	DecoChageSystemEnd()
	TownNpcEscBtnClickEvent()
	DecoUpgradeCoinInit()
	DecoCoinAnimationEnd()
	winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
	winMgr:getWindow("DecoUpgradeCharge"):setPosition(178, 251)
	winMgr:getWindow("DecoUpgradeCharge"):setText("0")
	
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
end

--------------------------------------------------------------------
-- DecoChangeSysTem End
--------------------------------------------------------------------
function DecoChageSystemEnd()
	VirtualImageSetVisible(false)
	CloseCommonUpgradeFrame()
	DecoChangeSystemInit()
	DecoCoinAnimationEnd()
	winMgr:getWindow("DecoChangeSystemBG"):setVisible(false)
	
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	GRADENUMBER = -1
	DecoUpgradeMyItemListEndInit()
end

function DecoRegistItemImgInit()
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
	winMgr:getWindow("DecoUpgradeCharge"):setPosition(188, 251)
	winMgr:getWindow("DecoUpgradeCharge"):setText("0")
end

--------------------------------------------------------------------
-- DecoChangeSysTem Start
--------------------------------------------------------------------
function DecoChageSystemStart()
	WIDTH, HEIGHT = DecoGetWindowSize()
	
	winMgr:getWindow("DecoChangeSystemReconfirmBG"):setPosition((WIDTH / 2) - (260 / 2), (HEIGHT / 2) - (145 / 2))
	winMgr:getWindow("DecoUpgradeResultMainImg"):setPosition((WIDTH / 2) - (220 / 2), (HEIGHT / 2) - (165 / 2))
	winMgr:getWindow("DecoUpgradeAniMainImg"):setPosition((WIDTH / 2) - (409 / 2), (HEIGHT / 2) - (241 / 2))
	
	winMgr:getWindow("DecoChangeSystemBG"):setVisible(true)
	DecoChangeSystemStart()
	local tabTable = {['err']=0, [0] = true, false, true, true, false}
	ShowCommonUpgradeFrame(tabTable, "ClickedDecoUpgradeFrameBtn")	-- 아이템 목록창을 띄워준다.
	DecoUpgradeMyItemListInit()
end

--------------------------------------------------------------------
-- 아이템 등록
--------------------------------------------------------------------
function ClickedDecoUpgradeFrameBtn(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local SotlIndex = tonumber(eventwindow:getUserString("Index"))
	
	DecoCoinAnimationEnd()
	UpgradeDecoRegist(SotlIndex)
end

--------------------------------------------------------------------
-- ORB Check
--------------------------------------------------------------------
function DecoMoneyCheck()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_9, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_SHORT_MONEY)

function DecoOrbCheck()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_1028, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_11)

function DecoGradeNumberCheck()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_4333, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_NO_INPUT_LEGEND_001)

function DecoCoinCheck()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_4442, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_DECO_CHIPUSE_004)

function DecoCoinGradeCheck()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_4443, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_DECO_CHIPUSE_005)

--------------------------------------------------------------------
-- 등록한 Item Image Setting
--------------------------------------------------------------------
function SettingDecoUpgradeImg(FileName, GradeNumber)
	GRADENUMBER = GradeNumber
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Enabled", FileName, 0, 0)
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Disabled", FileName, 0, 0)

	if GRADENUMBER == GRADE_LOW then
		winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
		winMgr:getWindow("DecoUpgradeCharge"):setPosition(178, 251)
		winMgr:getWindow("DecoUpgradeCharge"):setText("5,000")
		
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/Deco.tga", 339, 0)
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/Deco.tga", 339, 0)
		
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/Deco.tga", 339, 14)
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/Deco.tga", 339, 14)
	elseif GRADENUMBER == GRADE_MEDIUM then
		winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
		winMgr:getWindow("DecoUpgradeCharge"):setPosition(173, 251)
		winMgr:getWindow("DecoUpgradeCharge"):setText("35,000")
		
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/Deco.tga", 339, 14)
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/Deco.tga", 339, 14)
		
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/Deco.tga", 339, 28)
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/Deco.tga", 339, 28)
	elseif GRADENUMBER == GRADE_HIGH then
		winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
		
		--04.26KSG
		--if IsEngLanguage() then
		--	winMgr:getWindow("DecoUpgradeCharge"):setPosition(170, 251)
		--	winMgr:getWindow("DecoUpgradeCharge"):setText("100,000")
		--else
			winMgr:getWindow("DecoUpgradeCharge"):setPosition(173, 251)
			winMgr:getWindow("DecoUpgradeCharge"):setText("150,000")
		--end
		
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/Deco.tga", 339, 28)
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/Deco.tga", 339, 28)
		
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/Deco.tga", 339, 42)
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/Deco.tga", 339, 42)
	elseif GRADENUMBER == GRADE_UNIQUE then
		winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
		
		--0426KSG
		--if IsEngLanguage() then
		--	winMgr:getWindow("DecoUpgradeCharge"):setPosition(166, 251)
		--	winMgr:getWindow("DecoUpgradeCharge"):setText("500,000")
		--else
			winMgr:getWindow("DecoUpgradeCharge"):setPosition(166, 251)
			winMgr:getWindow("DecoUpgradeCharge"):setText("500,000")
		--end
		
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/Deco.tga", 339, 42)
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/Deco.tga", 339, 42)
		
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/Deco.tga", 339, 56)
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/Deco.tga", 339, 56)
	elseif GRADENUMBER == GRADE_RARE then
		winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
		
		--0426KSG
		--if IsEngLanguage() then
		--	winMgr:getWindow("DecoUpgradeCharge"):setPosition(162, 251)
		--	winMgr:getWindow("DecoUpgradeCharge"):setText("1,000,000")
		--else
			winMgr:getWindow("DecoUpgradeCharge"):setPosition(166, 251)
			winMgr:getWindow("DecoUpgradeCharge"):setText("1,000,000")
		--end
		
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/Deco.tga", 339, 56)
		winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/Deco.tga", 339, 56)
		
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/Deco.tga", 339, 70)
		winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/Deco.tga", 339, 70)
	end
end

--------------------------------------------------------------------
-- DecoChangeSysTem Error
--------------------------------------------------------------------
function DecoUpgradeError()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_4441, 'OnClickAlertOkSelfHide')
end										--GetSStringInfo(LAN_DECO_CHIPUSE_003)

--------------------------------------------------------------------
-- DecoChangeSysTem 결과 창 출력
--------------------------------------------------------------------
function OpenDecoResultWindow(FileName, ResultNum)
	RESULT = ResultNum
	
	winMgr:getWindow("DecoUpgradeResultAniImg"):setVisible(true)
	winMgr:getWindow("DecoUpgradeResultOKButton"):setVisible(false)
	winMgr:getWindow("DecoUpgradeResultAlpha"):setVisible(true)
	
	winMgr:getWindow("DecoUpgradeResultImg"):setTexture("Enabled", FileName, 0, 0)
	winMgr:getWindow("DecoUpgradeResultImg"):setTexture("Disabled", FileName, 0, 0)

	if ResultNum == RESULT_SECCESS then
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Enabled", "UIData/deco.tga", 393, 595)
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Disabled", "UIData/deco.tga", 393, 595)
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 0, 824)
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 0, 824)
	elseif ResultNum == RESULT_FAIL then
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Enabled", "UIData/deco.tga", 393, 617)
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Disabled", "UIData/deco.tga", 393, 617)
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 303, 824)
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 303, 824)
	elseif ResultNum == RESULT_SAME then
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Enabled", "UIData/deco.tga", 393, 639)
		winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Disabled", "UIData/deco.tga", 393, 639)	
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 606, 824)
		winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 606, 824)
	end
	
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	GRADENUMBER = -1
	COIN_RESULT = -1
	
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage1"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeGradeImage2"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("DecoUpgradeCoinImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeCoinImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeCoinImg"):setVisible(false)
	
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Normal", "UIData/deco.tga", 423, 0)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Hover", "UIData/deco.tga", 423, 27)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("Pushed", "UIData/deco.tga", 423, 54)
	winMgr:getWindow("DecoUpgradeCoinCheckButton"):setTexture("PushedOff", "UIData/deco.tga", 423, 81)	
		
	winMgr:getWindow("DecoUpgradeCharge"):clearTextExtends()
	winMgr:getWindow("DecoUpgradeCharge"):setPosition(188, 251)
	winMgr:getWindow("DecoUpgradeCharge"):setText("0")
end

--------------------------------------------------------------------
-- 결과 애니메이션 첫번째
--------------------------------------------------------------------
function ResultWindowAnimation(NowTime)
	-- Khunpon.ka 
	-- Sep 28, 2022
	-- Remove animation
	winMgr:getWindow("DecoUpgradeResultMainImg"):setPosition((WIDTH / 2) - (300 / 2), (HEIGHT / 2) - (190 / 2))
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleHeight(250)
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleWidth(250)
		
	ANI_TIME = NowTime
	SetDecoResultAnimation()
	SetDecoResultAniTwo()
end

function ResultWindowAnimation_unused(NowTime)
	local TimeTick  = 100 + (NowTime - ANI_TIME)
	local TimeTickX = 150 + (NowTime - ANI_TIME)
	local TimeTickY = 95 + (NowTime - ANI_TIME)
	
	winMgr:getWindow("DecoUpgradeResultMainImg"):setPosition((WIDTH / 2) - (TimeTickX / 2), (HEIGHT / 2) - (TimeTickY / 2))
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleHeight(TimeTick)
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleWidth(TimeTick)
	
	if TimeTick > 250 then
		ANI_TIME = NowTime
		SetDecoResultAnimation()
		SetDecoResultAniTwo()
	end
end
--------------------------------------------------------------------
-- 결과 애니메이션 두번째
--------------------------------------------------------------------
function ResultWindowAniTwo(NowTime)
	-- Khunpon.ka 
	-- Sep 28, 2022
	-- Remove animation
	winMgr:getWindow("DecoUpgradeResultAniImg"):setSize(0 + 180, 20)
	ANI_TIME = 0
	winMgr:getWindow("DecoUpgradeResultOKButton"):setVisible(true)
	SetDecoResultAniTwo()
end
function ResultWindowAniTwo_unused(NowTime)
	
	local TimeTick = (NowTime - ANI_TIME) / 4
	
	
	if TimeTick < 180 then
		winMgr:getWindow("DecoUpgradeResultAniImg"):setSize(0 + TimeTick, 20)
	else
		ANI_TIME = 0
		winMgr:getWindow("DecoUpgradeResultOKButton"):setVisible(true)
		SetDecoResultAniTwo()
	end
end
--------------------------------------------------------------------
-- DecoChangeSysTem 결과 닫기
--------------------------------------------------------------------
function CloseDecoResultWindow()
	winMgr:getWindow("DecoUpgradeResultAlpha"):setVisible(false)
	winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeResultAniImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeResultAniImg"):setPosition(61, 136)
	winMgr:getWindow("DecoUpgradeResultAniImg"):setSize(0, 20)
	winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeResultBGImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("DecoUpgradeResultMainImg"):setPosition((WIDTH / 2) - (220 / 2), (HEIGHT / 2) - (165 / 2))
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleHeight(200)
	winMgr:getWindow("DecoUpgradeResultMainImg"):setScaleWidth(200)
	DecoUpgradeAfterInventoryReset()
end


--------------------------------------------------------------------
-- DecoChangeSysTem 애니메이션 효과
--------------------------------------------------------------------
function DecoUpgradeAnimation(NowTime)
	-- Khunpon.ka 
	-- Sep 28, 2022
	-- Remove animation
	winMgr:getWindow("DecoUpgradeAniImg"):setPosition(245, 100)
	ANI_TIME = NowTime
	DecoUpgradeAnimationControl()
	SetDecoResultAnimation()
end
	
function DecoUpgradeAnimation_unused(NowTime)
	root:addChildWindow(winMgr:getWindow("DecoUpgradeAniAlpha"))
	winMgr:getWindow("DecoUpgradeAniAlpha"):setVisible(true)
	
	local TimeTick = 5 + ((NowTime - ANI_TIME) / 8)
	if TimeTick < 110 then
		winMgr:getWindow("DecoUpgradeAniImg"):setPosition(245, TimeTick)
	end
	
	if TimeTick > 50 then
		if TimeTick < 140 then
			root:addChildWindow(winMgr:getWindow("DecoUpgradeWhiteImg"))
			winMgr:getWindow("DecoUpgradeWhiteImg"):setVisible(true)
			winMgr:getWindow("DecoUpgradeWhiteImg"):setAlpha(0 + (TimeTick - 50) * 3)
		else
			ANI_TIME = NowTime
			DecoUpgradeAnimationControl()
			SetDecoResultAnimation()
			winMgr:getWindow("DecoUpgradeWhiteImg"):setVisible(false)
			winMgr:getWindow("DecoUpgradeAniAlpha"):setVisible(false)
		end
	end
end

--------------------------------------------------------------------
-- DecoChangeSysTem 재 확인 창 보여 주기
--------------------------------------------------------------------
function DecoUpgradeReconfirm()
	local SlotIndex = DecoItemSlotIndexCheck()

	if SlotIndex < 0 then
		DecoUpgradeError()
		return
	else
		root:addChildWindow(winMgr:getWindow("DecoUpgradeReconfirmAlpha"))
		winMgr:getWindow("DecoUpgradeReconfirmAlpha"):setVisible(true)
	end
end
--------------------------------------------------------------------
-- DecoChangeSysTem 재 확인 창 닫아 주기
--------------------------------------------------------------------
function DecoUpgradeCancelReconfirm()
	winMgr:getWindow("DecoUpgradeReconfirmAlpha"):setVisible(false)
end

--------------------------------------------------------------------
-- 결과 창 알파 다시 붙혀 주기
--------------------------------------------------------------------
function ResultAlphaChild(StartTime)
	root:addChildWindow(winMgr:getWindow("DecoUpgradeResultAlpha"))
	ANI_TIME = StartTime
end
