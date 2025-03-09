--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

-- 현재 윈도우 사이즈
local WIDTH, HEIGHT = GetWindowSize()

local RESULT_SUCCESS = 0
local RESULT_FAIL1 = 1
local RESULT_FAIL2 = 2

-- Effect
local g_bEffectOn = {['err']=0, false, false, false, false}
local g_bEffectTex = {['err']=0, 0, 0, 0, 0, 0}

-- state
local g_bCouponRegistered = false

local g_ResultWhiteoutAlpha = 255
local g_bResultWhiteout = false


-- 알파 이미지
GEUpgradeBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeAlphaImage")
GEUpgradeBackWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
GEUpgradeBackWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
GEUpgradeBackWindow:setProperty("FrameEnabled", "False")
GEUpgradeBackWindow:setProperty("BackgroundEnabled", "False")
GEUpgradeBackWindow:setPosition(0, 0)
GEUpgradeBackWindow:setSize(1920, 1200)
GEUpgradeBackWindow:setVisible(false)
GEUpgradeBackWindow:setEnabled(true)
GEUpgradeBackWindow:setAlwaysOnTop(true)
GEUpgradeBackWindow:setZOrderingEnabled(false)
root:addChildWindow(GEUpgradeBackWindow)

RegistEscEventInfo("GEUpgradeAlphaImage", "CloseGEUpgrade")


-- 뒷판
--[[
local GEUpgradeWindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeBackground")
GEUpgradeWindow:setTexture("Enabled", "UIData/Crafting.tga", 0, 0)
GEUpgradeWindow:setTexture("Disabled", "UIData/Crafting.tga", 0, 0)
GEUpgradeWindow:setWideType(6)
GEUpgradeWindow:setPosition(30, 170)
GEUpgradeWindow:setSize(342, 390)
GEUpgradeWindow:setAlwaysOnTop(true)
GEUpgradeWindow:setVisible(true)
GEUpgradeWindow:setZOrderingEnabled(false)
GEUpgradeBackWindow:addChildWindow(GEUpgradeWindow)
]]

local GEUpgradeWindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeBackground")
GEUpgradeWindow:setTexture("Enabled", "UIData/frame/frame_007.tga", 0, 0)
GEUpgradeWindow:setTexture("Disabled", "UIData/frame/frame_007.tga", 0, 0)
GEUpgradeWindow:setframeWindow(true)
GEUpgradeWindow:setWideType(6);
GEUpgradeWindow:setPosition(30, 162)
GEUpgradeWindow:setSize(340, 444)
GEUpgradeWindow:setVisible(true)
GEUpgradeWindow:setAlwaysOnTop(true)
GEUpgradeWindow:setZOrderingEnabled(true)
GEUpgradeBackWindow:addChildWindow(GEUpgradeWindow)

-- 타이틀 텍스트 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeTitleImage")
mywindow:setTexture("Enabled", "UIData/my_room4.tga", 326, 0)
mywindow:setTexture("Disabled", "UIData/my_room4.tga", 326, 0)
mywindow:setPosition(79, 7)
mywindow:setSize(182, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
GEUpgradeWindow:addChildWindow(mywindow)

-- 코스튬 조합창 닫기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgrade_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(310, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseGEUpgradeButtonEvent")
GEUpgradeWindow:addChildWindow(mywindow)


-- 큐브에 들어가는 아이템들의 전체 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBackDisable")
mywindow:setTexture("Enabled", "UIData/my_room4.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/my_room4.tga", 0, 0)
mywindow:setPosition(6, 34)
mywindow:setSize(326, 402)
mywindow:setAlign(8)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
mywindow:setUseEventController(false)
GEUpgradeWindow:addChildWindow(mywindow)



-- 큐브에 들어가는 아이템들의 전체 뒷판
local GEUpgradeItemBack = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBack")
GEUpgradeItemBack:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
GEUpgradeItemBack:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
GEUpgradeItemBack:setPosition(6, 34)
GEUpgradeItemBack:setSize(326, 402)
GEUpgradeItemBack:setAlign(8)
GEUpgradeItemBack:setAlwaysOnTop(true)
GEUpgradeItemBack:setVisible(true)
GEUpgradeItemBack:setZOrderingEnabled(true)
GEUpgradeItemBack:setUseEventController(false)
GEUpgradeItemBack:subscribeEvent("MotionEventEnd", "CubeItemBackEventEnd");
GEUpgradeItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "angle", "Sine_EaseIn", 0, 3000, 8, true, false, 10)
GEUpgradeItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "xscale", "Linear_EaseNone", 255, 0, 8, true, false, 10)
GEUpgradeItemBack:addController("CubeItemEventController", "CubeItemBackEvent", "yscale", "Linear_EaseNone", 255, 0, 8, true, false, 10)
GEUpgradeWindow:addChildWindow(GEUpgradeItemBack)



--local ITEM_BACK_POS_X = {['err']=0, 42, 217, 131, 133}
--local ITEM_BACK_POS_Y = {['err']=0, 53, 62, 190, 143}
local ITEM_BACK_POS_X = {['err']=0, 31, 209, 123, 164}
local ITEM_BACK_POS_Y = {['err']=0, 42, 54, 182, 282}
local ITEM_BACK_SIZE = {['err']=0, 112, 87, 87, 43}
local ITEM_BACKIMG_POS_X = {['err']=0, 11, 8, 8, 1}
local ITEM_BACKIMG_POS_Y = {['err']=0, 11, 8, 8, 1}
local ITEM_BACKIMG_TEX_X = {['err']=0, 326, 326, 396, 414}
local ITEM_BACKIMG_TEX_Y = {['err']=0, 22, 110, 110, 22}
local ITEM_BACKIMG_SIZE = {['err']=0, 88, 70, 70, 37}

local ITEM_IMG_SCALE = {['err']=0, 220, 180, 180, 105}

local EFFECT_TEX_NAME = "my_room5.tga"

local EFFECT_TEX_POS_X = 0
local EFFECT_TEX_POS_Y = 0

local EFFECT_TEX_SIZE = {['err']=0, 124, 124, 124, 124}
local EFFECT_TEX_SCALE = {['err']=0, 265, 205, 205, 94}

for i=1, 4 do
	-- 조합 코스튬 뒷판.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBackBack"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(ITEM_BACK_POS_X[i], ITEM_BACK_POS_Y[i])
	mywindow:setSize(ITEM_BACK_SIZE[i], ITEM_BACK_SIZE[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	GEUpgradeItemBack:addChildWindow(mywindow)
	
	-- 아이템 효과.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemEffect"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(-ITEM_BACKIMG_POS_X[i], -ITEM_BACKIMG_POS_Y[i])
	mywindow:setSize(124, 124)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setScaleWidth(EFFECT_TEX_SCALE[i])
	mywindow:setScaleHeight(EFFECT_TEX_SCALE[i])
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("GEUpgradeItemBackBack"..i):addChildWindow(mywindow)
	
	-- 조합 코스튬 뒷판.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBackImg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(ITEM_BACKIMG_POS_X[i], ITEM_BACKIMG_POS_Y[i])
	mywindow:setSize(ITEM_BACKIMG_SIZE[i], ITEM_BACKIMG_SIZE[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("GEUpgradeItemBackBack"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBackEmptyImg"..i)
	mywindow:setTexture("Enabled", "UIData/my_room4.tga", ITEM_BACKIMG_TEX_X[i], ITEM_BACKIMG_TEX_Y[i])
	mywindow:setTexture("Disabled", "UIData/my_room4.tga", ITEM_BACKIMG_TEX_X[i], ITEM_BACKIMG_TEX_Y[i])
	mywindow:setPosition(0, 0)
	mywindow:setSize(ITEM_BACKIMG_SIZE[i], ITEM_BACKIMG_SIZE[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("GEUpgradeItemBackImg"..i):addChildWindow(mywindow)
	
	-- 조합 코스튬 아이템 뒷판.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemBack"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(ITEM_BACKIMG_SIZE[i], ITEM_BACKIMG_SIZE[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("GEUpgradeItemBackImg"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeItemImg"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
--	mywindow:setPosition(-ITEM_BACKIMG_POS_X[i], -ITEM_BACKIMG_POS_Y[i])
	mywindow:setPosition(0, 0)
	mywindow:setSize(125, 125)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setScaleWidth(ITEM_IMG_SCALE[i])
	mywindow:setScaleHeight(ITEM_IMG_SCALE[i])
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("GEUpgradeItemBack"..i):addChildWindow(mywindow)
	
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgradeMouseEventBtn"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(ITEM_BACKIMG_SIZE[i], ITEM_BACKIMG_SIZE[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_GEUpgrade")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_GEUpgrade")
	winMgr:getWindow("GEUpgradeItemBack"..i):addChildWindow(mywindow)
	
	
	-- 조합 코스튬 닫기버튼
	if i ~= 3 then
		mywindow = winMgr:createWindow("TaharezLook/Button", "Erase_GEUpgradeItem"..i)
		mywindow:setTexture("Normal", "UIData/my_room3.tga", 234, 912)
		mywindow:setTexture("Hover", "UIData/my_room3.tga", 234, 931)
		mywindow:setTexture("Pushed", "UIData/my_room3.tga", 234, 950)
		mywindow:setTexture("PushedOff", "UIData/my_room3.tga", 234, 950)
		mywindow:setPosition(ITEM_BACKIMG_SIZE[i]-20, 1)
		mywindow:setSize(19, 19)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", i)
		mywindow:subscribeEvent("Clicked", "OnClickGEUpgradeCostumeErase")
		winMgr:getWindow("GEUpgradeItemBack"..i):addChildWindow(mywindow)
	end
end

-- 큐브 갯수 카운트

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GEUpgradeCubeCount")

function RefreshNeedCubeCnt(NeedCubeCnt)
	DebugStr("x 111" .. NeedCubeCnt)
	mywindow = winMgr:getWindow("GEUpgradeCubeCount");
	if mywindow == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "GEUpgradeCubeCount")
	end
	
	--mywindow = winMgr:createWindow("TaharezLook/StaticText", "GEUpgradeCubeCount")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(2, 2)
	mywindow:setSize(20, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:clearTextExtends()
	mywindow:addTextExtends("x " .. NeedCubeCnt, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,    0, 0,0,0,255)
	DebugStr("x 222" .. NeedCubeCnt)
	winMgr:getWindow("GEUpgradeItemBack3"):addChildWindow(mywindow)
end
-- 조합창에 있는 아이템들의 마우스 엔터이벤트
function MouseEnter_GEUpgrade(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, itemslot = GetGEUpgradeItemToolTipInfo(index)
	DebugStr(itemnumber)
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
	GetToolTipBaseInfo(x + 70, y+3, 0, Kind, itemslot, itemnumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
end


function MouseLeave_GEUpgrade(args)
	SetShowToolTip(false)
end


-- 큐브 갯수



-- 쿠폰등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgradeItemCouponButton")
mywindow:setTexture("Normal",	"UIData/my_room4.tga",	326, 300)
mywindow:setTexture("Hover",	"UIData/my_room4.tga",	326, 333)
mywindow:setTexture("Pushed",	"UIData/my_room4.tga",	326, 366)
mywindow:setTexture("PushedOff","UIData/my_room4.tga",	326, 366)
mywindow:setTexture("Disabled", "UIData/my_room4.tga",	326, 399)
mywindow:setPosition(222, 288)
mywindow:setSize(76, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickGEUpgradeRegisterCoupon")
GEUpgradeItemBack:addChildWindow(mywindow)

-- 조합하기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgradeItemButton")
mywindow:setTexture("Normal",	"UIData/my_room4.tga",	326, 180)
mywindow:setTexture("Hover",	"UIData/my_room4.tga",	326, 210)
mywindow:setTexture("Pushed",	"UIData/my_room4.tga",	326, 240)
mywindow:setTexture("PushedOff","UIData/my_room4.tga",	326, 240)
mywindow:setTexture("Disabled", "UIData/my_room4.tga",	326, 270)
mywindow:setPosition(102, 339)
mywindow:setSize(127, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickGEUpgradeItemButton")
GEUpgradeItemBack:addChildWindow(mywindow)



--------------------------------------------------------------------
-- 결과 Alpha
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:moveToFront()
root:addChildWindow(mywindow)

RegistEscEventInfo("GEUpgradeResultAlpha", "CloseGEUpgradeResult")

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultWhiteout")
mywindow:setTexture("Enabled", "UIData/blwhite.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/blwhite.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlpha(0)
winMgr:getWindow("GEUpgradeResultAlpha"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 결과 Main Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultMainImg")
mywindow:setTexture("Enabled", "UIData/Deco.tga", 0, 330)
mywindow:setTexture("Disabled", "UIData/Deco.tga", 0, 330)
mywindow:setPosition((WIDTH / 2) - (339 / 2), (HEIGHT / 2) - (265 / 2))
mywindow:setSize(339, 265)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("GEUpgradeResultAlpha"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 결과 BG Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultBGImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(18, 48)
mywindow:setSize(303, 200)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("GEUpgradeResultMainImg"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultTitleImg")
mywindow:setTexture("Enabled", "UIData/my_room4.tga", 70, 402)
mywindow:setTexture("Disabled", "UIData/my_room4.tga", 70, 402)
mywindow:setPosition(72, 20)
mywindow:setSize(160, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("GEUpgradeResultBGImg"):addChildWindow(mywindow)

-- 조합 코스튬 아이템 뒷판.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultItemBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(122, 55)
mywindow:setSize(150, 150)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("GEUpgradeResultBGImg"):addChildWindow(mywindow)

-- 아이템 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GEUpgradeResultItemImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(100, 100)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setLayered(true)
mywindow:setScaleWidth(150)
mywindow:setScaleHeight(150)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
winMgr:getWindow("GEUpgradeResultItemBack"):addChildWindow(mywindow)


-- 툴팁 이벤트를 위한 이미지
mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgradeResultMouseEventBtn")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(60, 60)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "MouseEnter_GEUpgradeResult")
mywindow:subscribeEvent("MouseLeave", "MouseLeave_GEUpgradeResult")
winMgr:getWindow("GEUpgradeResultItemBack"):addChildWindow(mywindow)

-- 결과 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "GEUpgradeResultItemName")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(51, 133)
mywindow:setSize(200, 20)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:clearTextExtends()
-- mywindow:addTextExtends("abcdefg", g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
winMgr:getWindow("GEUpgradeResultBGImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 결과 Ok Button Image
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "GEUpgradeResultOKButton")
mywindow:setTexture("Normal", "UIData/Deco.tga", 89, 678)
mywindow:setTexture("Hover", "UIData/Deco.tga", 89, 710)
mywindow:setTexture("Pushed", "UIData/Deco.tga", 89, 742)
mywindow:setTexture("PushedOff", "UIData/Deco.tga", 89, 774)
mywindow:setPosition(106, 158)
mywindow:setSize(89, 32)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CloseGEUpgradeResult")
winMgr:getWindow("GEUpgradeResultBGImg"):addChildWindow(mywindow)




-- 코스튬 등록된것중 하나를 지운다.
function OnClickGEUpgradeCostumeErase(args)
	local localWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(localWindow:getUserString("Index"))
	
	AutoErase(index)
end


function AutoErase(index)
	DebugStr("X : " .. index)
	EraseGEUpgradeItem(index)
	winMgr:getWindow("GEUpgradeItemBack"..index):setVisible(false)
	winMgr:getWindow("GEUpgradeItemEffect"..index):setVisible(false)
	winMgr:getWindow("GEUpgradeItemBackEmptyImg"..index):setVisible(true)
	
	
	if index == 1 then
		EraseGEUpgradeItem(2)
		winMgr:getWindow("GEUpgradeItemBack2"):setVisible(false)
		winMgr:getWindow("GEUpgradeItemEffect2"):setVisible(false)
		winMgr:getWindow("GEUpgradeItemBackEmptyImg2"):setVisible(true)
		
		EraseGEUpgradeItem(3)
		winMgr:getWindow("GEUpgradeItemBack3"):setVisible(false)
		winMgr:getWindow("GEUpgradeItemEffect3"):setVisible(false)
		winMgr:getWindow("GEUpgradeItemBackEmptyImg3"):setVisible(true)

	end
	
	if index == 4 then
		UnregisterCoupon()
	end
	
	RefreshItemList()

	CheckGEUpgrade()
end


-- 모든 아이템이 들어왔는지 확인한다.
function CheckGEUpgrade()
	if CheckforReadyGEUpgrade() then
		winMgr:getWindow("GEUpgradeItemButton"):setEnabled(true)
	else
		winMgr:getWindow("GEUpgradeItemButton"):setEnabled(false)
	end
end

function UnregisterCoupon()

	GEUpgradeUnregisterCoupon()
	local couponButton = winMgr:getWindow("GEUpgradeItemCouponButton")
	couponButton:setTexture("Normal",	"UIData/my_room4.tga",	326, 300)
	couponButton:setTexture("Hover",	"UIData/my_room4.tga",	326, 333)
	couponButton:setTexture("Pushed",	"UIData/my_room4.tga",	326, 366)
	couponButton:setTexture("PushedOff","UIData/my_room4.tga",	326, 366)
	couponButton:setTexture("Disabled", "UIData/my_room4.tga",	326, 399)
	
	if GEUpgradeCheckCoupon() == false then
		winMgr:getWindow("GEUpgradeItemCouponButton"):setEnabled(false)
	end
		
	winMgr:getWindow("GEUpgradeItemBack4"):setVisible(false)
	winMgr:getWindow("GEUpgradeItemEffect4"):setVisible(false)
	
	g_bCouponRegistered = false
end

-- 쿠폰 등록 버튼
function OnClickGEUpgradeRegisterCoupon()
	
	if g_bCouponRegistered == false then
		if GEUpgradeRegisterCoupon() == true then
			local couponButton = winMgr:getWindow("GEUpgradeItemCouponButton")
			couponButton:setTexture("Normal",	"UIData/my_room4.tga",	402, 300)
			couponButton:setTexture("Hover",	"UIData/my_room4.tga",	402, 333)
			couponButton:setTexture("Pushed",	"UIData/my_room4.tga",	402, 366)
			couponButton:setTexture("PushedOff","UIData/my_room4.tga",	402, 366)
			couponButton:setTexture("Disabled", "UIData/my_room4.tga",	402, 399)
			g_bCouponRegistered = true
		else
			winMgr:getWindow("GEUpgradeItemCouponButton"):setEnabled(false)
		end
	else
		UnregisterCoupon()
	end
end

-- 아이템 조합 한다고 보내준다.
function OnClickGEUpgradeItemButton()

	GEUpgradeStart()
--	GEUpgradeShowResult3D()
	
	-- 아이템들이 안으로 들어가는 이벤트
--	winMgr:getWindow("GEUpgradeItemBack"):activeMotion("CubeItemBackEvent")
	
--	ClearCraftingItemInfo()
end



-- 보상창이 나오면
function GEUpgradeResetEvent()
	
end





-- 열기, 닫기
function ShowGEUpgrade()

	GEUpgradeBackWindow:setVisible(true)
	CheckGEUpgrade()	-- 아이템이 다 차있는지 확인(효과때문에)
	InitGEUpgrade()

	-- 아이템 목록
	local tabTable = {['err']=0, [0] = true, false, true, true, false}
	ShowCommonUpgradeFrame(tabTable, "OnClickedItemRegist")	-- 아이템 목록창을 띄워준다.

	-- 이펙트 텍스쳐
	for i = 1, 4 do
		g_bEffectOn[i] = false
		g_bEffectTex[i] = 0
	end
	
	if GEUpgradeCheckCoupon() then
		winMgr:getWindow("GEUpgradeItemCouponButton"):setEnabled(true)
	end
	
end

function CloseGEUpgrade()
	VirtualImageSetVisible(false)
	GEUpgradeBackWindow:setVisible(false)
	
	for i = 1, 4 do
		winMgr:getWindow("GEUpgradeItemBack" .. i):setVisible(false)
		winMgr:getWindow("GEUpgradeItemBackEmptyImg" .. i):setVisible(true)
		winMgr:getWindow("GEUpgradeItemEffect" .. i):setVisible(false)
	end
	
	winMgr:getWindow("GEUpgradeResultAlpha"):setVisible(false)
	winMgr:getWindow("GEUpgradeResultWhiteout"):setVisible(false)
	winMgr:getWindow("GEUpgradeResultWhiteout"):setAlpha(0)
	
	g_bResultWhiteout = false
	g_ResultWhiteoutAlpha = 255

	UnregisterCoupon()
	ClearGEUpgrade()
	CloseCommonUpgradeFrame()
end

-- 닫는다.
function CloseGEUpgradeButtonEvent()
	CloseGEUpgrade()
	TownNpcEscBtnClickEvent()
end



--------------------------------------------------------------------
-- 아이템을 등록시킬때
--------------------------------------------------------------------

function OnClickedItemRegist(args)

	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local listindex = tonumber(eventwindow:getUserString("Index"))
	local amount = tonumber(CommonUpgradeItemAmount[slotIndex])
	
	GEUpgradeRegisterItem(listindex, amount)	-- 아이템을 등록해준다.
	CheckGEUpgrade()
end


-- 조합할 아이템을 팝업창에 띄워준다.
function SettingGEUpgradePopup(slot, itemKind, itemCount, itemFileName, itemFileName2)

	winMgr:getWindow("GEUpgradeItemImg"..slot):setTexture("Enabled", itemFileName, 0, 0)
	winMgr:getWindow("GEUpgradeItemImg"..slot):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("GEUpgradeItemImg"..slot):setLayered(false)
	else
		winMgr:getWindow("GEUpgradeItemImg"..slot):setLayered(true)
		winMgr:getWindow("GEUpgradeItemImg"..slot):setTexture("Layered", itemFileName2, 0, 0)
	end		
	winMgr:getWindow("GEUpgradeItemBack"..slot):setVisible(true)
	winMgr:getWindow("GEUpgradeItemBackEmptyImg"..slot):setVisible(false)
	winMgr:getWindow("GEUpgradeItemEffect"..slot):setVisible(true)
	
	EffectOn( slot )
end




function EffectOn( index )
	g_bEffectOn[index] = true;
end

function EffectOff( index )
	g_bEffectOn[index] = false;

	winMgr:getWindow("GEUpgradeItemEffect" .. index):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("GEUpgradeItemEffect" .. index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
end


local _speed = 0

function RenderGEUpgrade( time )

	if GEUpgradeBackWindow:isVisible() == false then
		return
	end
	
	if _speed == 1 then
	
		_speed = 0
		
		for i=1, 4 do
			if g_bEffectOn[i] == true then
				local window = winMgr:getWindow("GEUpgradeItemEffect" .. i)
				local x = EFFECT_TEX_POS_X + ((g_bEffectTex[i] % 4) * EFFECT_TEX_SIZE[i])
				local y = EFFECT_TEX_POS_Y + ((g_bEffectTex[i] / 4) * EFFECT_TEX_SIZE[i])
				
				window:setTexture("Enabled", "UIData/"..EFFECT_TEX_NAME, x, y)
				window:setTexture("Disabled", "UIData/"..EFFECT_TEX_NAME, x, y)
				
				g_bEffectTex[i] = g_bEffectTex[i] + 1
				
				if g_bEffectTex[i] == 16 then
					g_bEffectTex[i] = 0
					g_bEffectOn[i] = false
				end
			end
		end
	else
		_speed = _speed + 1
	end
	
	if g_bResultWhiteout == true then
		winMgr:getWindow("GEUpgradeResultWhiteout"):setAlpha(g_ResultWhiteoutAlpha)
		g_ResultWhiteoutAlpha = g_ResultWhiteoutAlpha - 8
		if g_ResultWhiteoutAlpha < 0 then
			winMgr:getWindow("GEUpgradeResultWhiteout"):setVisible(false)
			winMgr:getWindow("GEUpgradeResultWhiteout"):setAlpha(0)
			g_ResultWhiteoutAlpha = 255
			g_bResultWhiteout = false
		end
	end

end


local resultItemKind
local resultItemNumber
local resultItemSlot

function ShowGEUpgradeResultAlpha()
	root:addChildWindow(winMgr:getWindow("GEUpgradeResultAlpha"))
	winMgr:getWindow("GEUpgradeResultAlpha"):setVisible(true)
	winMgr:getWindow("CommonUpgradeList_BackImage"):moveToBack()
end

function ShowGEUpgradeResultWhite()
	winMgr:getWindow("GEUpgradeResultAlpha"):addChildWindow(winMgr:getWindow("GEUpgradeResultWhiteout"))
	winMgr:getWindow("GEUpgradeResultWhiteout"):setVisible(true)
	winMgr:getWindow("GEUpgradeResultWhiteout"):moveToFront()
	winMgr:getWindow("GEUpgradeResultWhiteout"):setAlpha(255)
	g_ResultWhiteoutAlpha = 255
	g_bResultWhiteout = true
end

function ShowGEUpgradeResultSuccess(itemKind, itemnumber, itemslot, itemName, itemFileName, itemFileName2)

	winMgr:getWindow("GEUpgradeResultMainImg"):setVisible(true)

	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 606, 824)
	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 606, 824)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Enabled", "UIData/my_room4.tga", 70, 402)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Disabled", "UIData/my_room4.tga", 70, 402)
	
	winMgr:getWindow("GEUpgradeResultMouseEventBtn"):setEnabled(true)
	
	resultItemKind = itemKind
	resultItemNumber = itemnumber
	resultItemSlot = itemslot
	
	-- 결과 아이템을 결과창에 띄워준다.
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Enabled", itemFileName, 0, 0)
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("GEUpgradeResultItemImg"):setLayered(false)
	else
		winMgr:getWindow("GEUpgradeResultItemImg"):setLayered(true)
		winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	local itemNameWindow = winMgr:getWindow("GEUpgradeResultItemName")
	itemNameWindow:setPosition(51, 133)
	
	itemNameWindow:clearTextExtends()
	itemNameWindow:addTextExtends(itemName, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
	
end

function ShowGEUpgradeResultFail(itemKind, itemnumber, itemslot, message, itemFileName, itemFileName2)

	winMgr:getWindow("GEUpgradeResultMainImg"):setVisible(true)

	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 303, 824)
	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 303, 824)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Enabled", "UIData/my_room4.tga", 70, 426)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Disabled", "UIData/my_room4.tga", 70, 426)
	
	winMgr:getWindow("GEUpgradeResultMouseEventBtn"):setEnabled(true)
	
	resultItemKind = itemKind
	resultItemNumber = itemnumber
	resultItemSlot = itemslot
	
	-- 결과 아이템을 결과창에 띄워준다.
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Enabled", itemFileName, 0, 0)
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Disabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("GEUpgradeResultItemImg"):setLayered(false)
	else
		winMgr:getWindow("GEUpgradeResultItemImg"):setLayered(true)
		winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	local itemNameWindow = winMgr:getWindow("GEUpgradeResultItemName")
	
	local str
	if message == 0 then
		itemNameWindow:setPosition(51, 126)
		str = PreCreateString_4598	--GetSStringInfo(LAN_GOLDENEGG_UPGRADESYSTEM_006)
	else
		itemNameWindow:setPosition(51, 133)
		str = PreCreateString_4599	--GetSStringInfo(LAN_GOLDENEGG_UPGRADESYSTEM_007)
	end
	
	itemNameWindow:clearTextExtends()
	itemNameWindow:addTextExtends(str, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
	
end

function ShowGEUpgradeResultDestroy(DestroyedItemCount)

	winMgr:getWindow("GEUpgradeResultMainImg"):setVisible(true)

	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Enabled", "UIData/deco.tga", 303, 824)
	winMgr:getWindow("GEUpgradeResultBGImg"):setTexture("Disabled", "UIData/deco.tga", 303, 824)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Enabled", "UIData/my_room4.tga", 70, 426)
	winMgr:getWindow("GEUpgradeResultTitleImg"):setTexture("Disabled", "UIData/my_room4.tga", 70, 426)
	
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Enabled", "UIData/ItemUIData/Item/GoldenEgg_Upgrade_Fail_icon_001.tga", 0, 0)
	winMgr:getWindow("GEUpgradeResultItemImg"):setTexture("Disabled", "UIData/ItemUIData/Item/GoldenEgg_Upgrade_Fail_icon_001.tga", 0, 0)
	
	winMgr:getWindow("GEUpgradeResultMouseEventBtn"):setEnabled(false)
	
	local itemNameWindow = winMgr:getWindow("GEUpgradeResultItemName")
	itemNameWindow:setPosition(51, 133)
	
	itemNameWindow:clearTextExtends()
	itemNameWindow:addTextExtends(string.format(PreCreateString_4600, DestroyedItemCount), g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,    0, 0,0,0,255)
end													--GetSStringInfo(LAN_GOLDENEGG_UPGRADESYSTEM_008)

function CloseGEUpgradeResult()
	
	local alphaWindow = winMgr:getWindow("GEUpgradeResultAlpha")
	local mainWindow = winMgr:getWindow("GEUpgradeResultMainImg")
	
	winMgr:getWindow("GEUpgradeResultItemName"):clearTextExtends()
	
	if alphaWindow:isVisible() and mainWindow:isVisible() then
		alphaWindow:setVisible(false)
		mainWindow:setVisible(false)
	end
end


-- 조합창에 있는 아이템들의 마우스 엔터이벤트
function MouseEnter_GEUpgradeResult(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	local Kind = -1
	if resultItemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif resultItemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif resultItemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	
	GetToolTipBaseInfo(x + 70, y+3, 0, Kind, resultItemSlot, resultItemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
end

function MouseLeave_GEUpgradeResult(args)
	SetShowToolTip(false)
end
