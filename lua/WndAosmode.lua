-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
--[[
local WINDOW_WIDTH	= 1024
local WINDOW_HEIGHT	= 768
local width, height = GetWindowSize()
local g_x = width / 2 
local g_y = height / 2 

--]]

CommonFrameTopfileName = "UIData/top_bottom_line_001.tga"
CommonFrameBottomfileName = "UIData/top_bottom_line_001.tga"
CommonFrameEdgefileName = "UIData/edge_line_001.tga"
CommonFrameSidefileName = "UIData/side_line_001.tga"
CommonFrameCenterfileName =  "UIData/center_line_001.tga"
CommonFrameTitlefileName = "UIData/titlebg_001.tga"
CommonEdgeTopSize = 60
CommonEdgeBottomSize = 40
CommonFrameSideSizeX = 40

function CreateFrameSetWindow(name , sizeX, sizeY, type, titletype)

	--DebugStr('name:'..name)
	
	-- EDGE LEFT
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'EdgeLeft')
	mywindow:setTexture("Enabled",	CommonFrameEdgefileName, 0+(type*120) , 0)
	mywindow:setTexture("Disabled", CommonFrameEdgefileName, 0+(type*120), 0)
	mywindow:setPosition(0 , 0)
	mywindow:setSize(CommonEdgeTopSize, CommonEdgeTopSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- EDGE RIGHT
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'EdgeRight')
	mywindow:setTexture("Enabled",	CommonFrameEdgefileName, 60+(type*120) , 0)
	mywindow:setTexture("Disabled", CommonFrameEdgefileName, 60+(type*120) , 0)
	mywindow:setPosition(sizeX-CommonEdgeTopSize , 0)
	mywindow:setSize(CommonEdgeTopSize, CommonEdgeTopSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- EDGE BOTTOM LEFT
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'EdgebottomLeft')
	mywindow:setTexture("Enabled",	CommonFrameEdgefileName, 0+(type*120) , 60)
	mywindow:setTexture("Disabled", CommonFrameEdgefileName, 0+(type*120) , 60)
	mywindow:setPosition(0 , sizeY-CommonEdgeBottomSize)
	mywindow:setSize(CommonEdgeTopSize, CommonEdgeBottomSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- EDGE BOTTOM RIGHT
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'EdgebottomRight')
	mywindow:setTexture("Enabled",	CommonFrameEdgefileName, 60+(type*120) , 60)
	mywindow:setTexture("Disabled", CommonFrameEdgefileName, 60+(type*120) , 60)
	mywindow:setPosition(sizeX-CommonEdgeTopSize , sizeY-CommonEdgeBottomSize)
	mywindow:setSize(CommonEdgeTopSize, CommonEdgeBottomSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);


	-- CENTER FRAME
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'Main')
	mywindow:setTexture("Enabled",	CommonFrameCenterfileName, 0 , 0)
	mywindow:setTexture("Disabled", CommonFrameCenterfileName, 0 , 0)
	mywindow:setPosition(CommonFrameSideSizeX , CommonEdgeTopSize)
	mywindow:setSize(sizeX-(CommonFrameSideSizeX*2), sizeY-(CommonEdgeBottomSize+CommonEdgeTopSize))
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);

	-- TOP FRAME
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'Top')
	mywindow:setTexture("Enabled",	CommonFrameTopfileName, 0 , 0 + (type*60))
	mywindow:setTexture("Disabled", CommonFrameTopfileName, 0 , 0 + (type*60))
	mywindow:setPosition(CommonEdgeTopSize , 0)
	mywindow:setSize(sizeX-(CommonEdgeTopSize*2), CommonEdgeTopSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- BOTTOM FRAME
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'Bottom')
	mywindow:setTexture("Enabled",	CommonFrameBottomfileName, 0 , 984 -(type*40))
	mywindow:setTexture("Disabled", CommonFrameBottomfileName, 0 , 984 - (type*40))
	mywindow:setPosition(CommonEdgeTopSize , sizeY-CommonEdgeBottomSize)
	mywindow:setSize(sizeX-(CommonEdgeTopSize*2), CommonEdgeBottomSize)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- SIDE LEFT FRAME
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'SideLeft')
	mywindow:setTexture("Enabled",	CommonFrameSidefileName, 0+(type*40) , 0)
	mywindow:setTexture("Disabled", CommonFrameSidefileName, 0+(type*40) , 0)
	mywindow:setPosition(0 , CommonEdgeTopSize)
	mywindow:setSize(CommonFrameSideSizeX , sizeY-(CommonEdgeTopSize+CommonEdgeBottomSize))
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- SIDE RIGHT FRAME
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'SideRight')
	mywindow:setTexture("Enabled",	CommonFrameSidefileName, 984-(type*40) , 0)
	mywindow:setTexture("Disabled", CommonFrameSidefileName, 984-(type*40) , 0)
	mywindow:setPosition(sizeX-CommonFrameSideSizeX , CommonEdgeTopSize)
	mywindow:setSize(CommonFrameSideSizeX , sizeY-(CommonEdgeTopSize+CommonEdgeBottomSize))
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
	
	-- TITLE IMAGE
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", name..'Title')
	mywindow:setTexture("Enabled",	CommonFrameTitlefileName, 0 , (titletype*42))
	mywindow:setTexture("Disabled", CommonFrameTitlefileName, 0 , (titletype*42))
	mywindow:setPosition((sizeX/2)-191 , -5)
	mywindow:setSize(382 , 42)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(name):addChildWindow(mywindow);
end




MAX_AOS_CHARACTER = 12
MY_AOS_TEAM = 1

-- AOS 캐릭터 선택창
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosCharacterBackImage")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
mywindow:setWideType(6)
mywindow:setPosition(200 , 150)
mywindow:setSize(512, 512)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
CreateFrameSetWindow(mywindow:getName(), 600, 428, 0, 0)

-- AOS 캐릭터 TITLE TEXTIMAGE
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosCharacterTitleImage")
mywindow:setTexture("Enabled",	"UIData/Aos_button_001.tga", 0 , 136)
mywindow:setTexture("Disabled", "UIData/Aos_button_001.tga", 0 , 136)
mywindow:setPosition(250 , 12)
mywindow:setSize(97, 19)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CreateAosCharacterBackImage"):addChildWindow(mywindow)




if MY_AOS_TEAM == 1 then
	AOSCHARACTERIMAGE = "UIData/Aos_character_human_001.tga"
	AOSCHARACTERBIGIMAGE = "UIData/Aos_character_humanfull_001.tga"
else
	AOSCHARACTERIMAGE = "UIData/Aos_character_zombie_001.tga"
	AOSCHARACTERBIGIMAGE = "UIData/Aos_character_zombiefull_001.tga"
end

for i = 1, MAX_AOS_CHARACTER do

	RealPosX = (i-1) % 4 
	RealPosY = (i-1) / 4
	RealTexX = (i*76)-76
	--DebugStr('RealTexX:'..RealTexX)
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "AOS_CHARACTER_SELECT"..i)
	mywindow:setTexture("Normal", AOSCHARACTERIMAGE, RealTexX, 0)
	mywindow:setTexture("Hover", AOSCHARACTERIMAGE, RealTexX, 76)
	mywindow:setTexture("Pushed", AOSCHARACTERIMAGE, RealTexX, 152)
	mywindow:setTexture("SelectedNormal",AOSCHARACTERIMAGE, RealTexX,  152)
	mywindow:setTexture("SelectedHover", AOSCHARACTERIMAGE, RealTexX,  152)
	mywindow:setTexture("SelectedPushed", AOSCHARACTERIMAGE, RealTexX,  152)
	mywindow:setTexture("Disabled", AOSCHARACTERIMAGE, 76*5,  0)
	mywindow:setProperty("GroupID", 4200)
	mywindow:setSize(76, 76)
	mywindow:setUserString("AosCharacterIndex", i)
	mywindow:setPosition((RealPosX*80)+40, (RealPosY*85)+65)
	mywindow:setZOrderingEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("SelectStateChanged", "Select_AosCharacter")
	mywindow:setProperty("Selected", "false")
	winMgr:getWindow("CreateAosCharacterBackImage"):addChildWindow(mywindow)
	
	if i > 5 then
		mywindow:setEnabled(false)
	end
	------------------------------------
	---페이지표시텍스트-----------------
	------------------------------------
	--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "AOS_CHARACTER_SELECTText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
	mywindow:setPosition(0, 0)
	mywindow:setSize(120, 20)
	mywindow:setText("text"..i)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("AOS_CHARACTER_SELECT"..i):addChildWindow(mywindow)
	--]]
end

function Select_AosCharacter(args)
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	
	if CEGUI.toRadioButton(local_window):isSelected() then
		local Index = tonumber(local_window:getUserString('AosCharacterIndex'))
		
		winMgr:getWindow("CreateAosSelectCharacterImage"):setTexture("Enabled",	AOSCHARACTERBIGIMAGE, (200*Index)-200 , 0)
		winMgr:getWindow("CreateAosSelectCharacterImage"):setTexture("Disabled", AOSCHARACTERBIGIMAGE, (200*Index)-200 , 0)
		winMgr:getWindow("CreateAosSelectCharacterBtn"):setEnabled(true)
	end
end

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosSelectCharacterImage")
mywindow:setTexture("Enabled",	AOSCHARACTERBIGIMAGE, 0 , 260)
mywindow:setTexture("Disabled", AOSCHARACTERBIGIMAGE, 0,  260)
mywindow:setPosition(390 , 60)
mywindow:setSize(200, 260)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CreateAosCharacterBackImage"):addChildWindow(mywindow)

-- 구분선
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosSelectPartImage")
mywindow:setTexture("Enabled",	"UIData/Aos_button_001.tga", 0 , 155)
mywindow:setTexture("Disabled", "UIData/Aos_button_001.tga", 0,  155)
mywindow:setPosition(40 , 345)
mywindow:setSize(527, 1)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CreateAosCharacterBackImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 캐릭터 선택 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CreateAosSelectCharacterBtn")
mywindow:setTexture("Normal", "UIData/Aos_button_001.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/Aos_button_001.tga", 0, 34)
mywindow:setTexture("Pushed", "UIData/Aos_button_001.tga", 0, 68)
mywindow:setTexture("PushedOff", "UIData/Aos_button_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Aos_button_001.tga", 0, 102)
mywindow:setEnabled(false)
mywindow:setPosition(200 , 370)
mywindow:setSize(194, 34)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnCreateAosCharacter")
winMgr:getWindow("CreateAosCharacterBackImage"):addChildWindow(mywindow)

function OnCreateAosCharacter()
	for i = 1, MAX_AOS_CHARACTER do
		if CEGUI.toRadioButton( winMgr:getWindow("AOS_CHARACTER_SELECT"..i) ):isSelected() == true then
			RequestCreateWeapon(i)
			winMgr:getWindow("CreateAosCharacterBackImage"):setVisible(false)
		end
	end
end



