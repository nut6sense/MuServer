--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


--[[

public: -- windows

	GMCommandAlphaImage	-- 게임창 알파이미지
	GMCommandBackground	-- 전체 게임창
	{
		GMCommand_Titlebar		-- 타이틀바(삭제됨, 고정윈도우)
		GMCommand_CloseBtn		-- 닫기버튼
		
		-- NPC 조정
		GMCommand_NPC_EventNPCButton
			GMCommand_NPC_EventNPCButtonName
		GMCommand_NPC_Edit_Back
			GMCommand_NPC_Edit
		GMCommand_NPC_Button1~2
			GMCommand_NPC_ButtonName1~2
			
		-- Event 조정
		GMCommand_Event_SelectButton1~2
			GMCommand_Event_SelectButtonName1~2
		GMCommand_Event_Edit_Back
			GMCommand_Event_Edit
		GMCommand_Event_Button1~2
			GMCommand_Event_ButtonName1~2
		
	} -- end of GMCommandBackground

public: -- functions

	function GMCommand_Show()				-- 창을 연다
	function GMCommand_Close()				-- 창을 닫는다
	function GMCommand_SetVisible( b )		-- 창의 visible을 조정한다
	function GMCommand_Init()				-- 초기화
	
	function OnEditBoxFull()
	
	-- NPC 조정
	function OnClicked_NPC_EventNPCButton( args )
	function OnClicked_NPC_Button1( args )
	function OnClicked_NPC_Button2( args )
	
	-- Event 조정
	function OnClicked_Event_SelectButton( args )
	function OnClicked_Event_Button1( args )
	function OnClicked_Event_Button2( args )
	
]]--








-- 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GMCommandAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:moveToFront()


-- 기본 바탕 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GMCommandBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(100, 200)
mywindow:setSize(400, 250)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:moveToFront()

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("GMCommandBackground", "GMCommand_Close")


-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "GMCommand_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(400-35, 45)
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)


-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(370, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "GMCommand_Close")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)






-- NPC 조정
mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_NPC_EventNPCButton")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(20, 55)
mywindow:setSize(50, 22)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_NPC_EventNPCButton")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_NPC_EventNPCButtonName")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 9)
mywindow:setPosition(2, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("EventNPC")
winMgr:getWindow("GMCommand_NPC_EventNPCButton"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GMCommand_NPC_Edit_Back")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(20, 85)
mywindow:setSize(70, 22)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true);
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_NPC_Edit")
mywindow:setPosition(3, 0)
mywindow:setSize(70, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setText("30")
winMgr:getWindow("GMCommand_NPC_Edit_Back"):addChildWindow(mywindow)
--[[
mywindow = winMgr:createWindow("TaharezLook/Editbox", "GMCommand_NPC_Edit")
mywindow:setPosition(0, 0)
mywindow:setSize(70, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setText("30")
winMgr:getWindow("GMCommand_NPC_Edit_Back"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(2)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
]]
mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_NPC_Button1")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(110, 80)
mywindow:setSize(100, 32)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_NPC_Button1")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_NPC_ButtonName1")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(10, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("ShowNPC")
winMgr:getWindow("GMCommand_NPC_Button1"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_NPC_Button2")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(230, 80)
mywindow:setSize(100, 32)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_NPC_Button2")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_NPC_ButtonName2")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(10, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("HideNPC")
winMgr:getWindow("GMCommand_NPC_Button2"):addChildWindow(mywindow)










-- Event 조정
mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_Event_SelectButton1")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(20, 135)
mywindow:setSize(30, 22)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("index", 1)
mywindow:subscribeEvent("Clicked", "OnClicked_Event_SelectButton")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_Event_SelectButtonName1")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 9)
mywindow:setPosition(2, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("RPS")
winMgr:getWindow("GMCommand_Event_SelectButton1"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_Event_SelectButton2")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(55, 135)
mywindow:setSize(30, 22)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("index", 2)
mywindow:subscribeEvent("Clicked", "OnClicked_Event_SelectButton")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_Event_SelectButtonName2")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 9)
mywindow:setPosition(2, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("Dice")
winMgr:getWindow("GMCommand_Event_SelectButton2"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GMCommand_Event_Edit_Back")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 359)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(20, 165)
mywindow:setSize(70, 22)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true);
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_Event_Edit")
mywindow:setPosition(3, 0)
mywindow:setSize(70, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setText("28")
winMgr:getWindow("GMCommand_Event_Edit_Back"):addChildWindow(mywindow)

--[[
mywindow = winMgr:createWindow("TaharezLook/Editbox", "GMCommand_Event_Edit")
mywindow:setPosition(0, 0)
mywindow:setSize(70, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setText("28")
winMgr:getWindow("GMCommand_Event_Edit_Back"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(2)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
]]
mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_Event_Button1")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(110, 160)
mywindow:setSize(100, 32)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Event_Button1")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_Event_ButtonName1")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(10, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("ShowEvent")
winMgr:getWindow("GMCommand_Event_Button1"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "GMCommand_Event_Button2")
mywindow:setTexture("Normal",	"UIData/fightClub_008.tga", 50, 88)
mywindow:setTexture("Hover",	"UIData/fightClub_008.tga", 50, 56)
mywindow:setTexture("Pushed",	"UIData/fightClub_008.tga", 50, 120)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 50, 13)
mywindow:setPosition(230, 160)
mywindow:setSize(100, 32)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Event_Button2")
winMgr:getWindow("GMCommandBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "GMCommand_Event_ButtonName2")
mywindow:setEnabled(false)
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(10, 2)
mywindow:setSize(60, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setText("HideEvent")
winMgr:getWindow("GMCommand_Event_Button2"):addChildWindow(mywindow)











-- 게임 창을 연다.
function GMCommand_Show()
	GMCommand_SetVisible(true)
end

-- 게임 창을 닫는다.
function GMCommand_Close()
	GMCommand_SetVisible(false)
end

-- 게임창의 visible을 조정한다
function GMCommand_SetVisible( b )

	if b == 1 or b == true then
		b = true
		winMgr:getWindow("GMCommandBackground"):moveToFront()
		GMCommand_Init()
	else
		b = false
	end
	
	winMgr:getWindow("GMCommandAlphaImage"):setVisible(b)
	winMgr:getWindow("GMCommandBackground"):setVisible(b)
end

-- 초기화
function GMCommand_Init()
	
end


function OnEditBoxFull(args) -- EditBox가 꽉찼을때의 이벤트
	PlaySound('sound/FullEdit.wav')
end




function OnClicked_NPC_EventNPCButton( args )
	winMgr:getWindow("GMCommand_NPC_Edit"):setText("30")
end

function OnClicked_NPC_Button1( args )

	ClearArgs()
	SetCommandType(1)
	SetIndex(tonumber(winMgr:getWindow("GMCommand_NPC_Edit"):getText()))
	SetVisible(true)
	RequestCommand()
end

function OnClicked_NPC_Button2( args )

	ClearArgs()
	SetCommandType(1)
	SetIndex(tonumber(winMgr:getWindow("GMCommand_NPC_Edit"):getText()))
	SetVisible(false)
	RequestCommand()
end





function OnClicked_Event_SelectButton( args )

	local window= CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(window:getUserString("index"))
	
		
	if index == 1 then
		winMgr:getWindow("GMCommand_Event_Edit"):setText("28")
	elseif index == 2 then
		winMgr:getWindow("GMCommand_Event_Edit"):setText("29")
	end
end

function OnClicked_Event_Button1( args )

	ClearArgs()
	SetCommandType(2)
	SetIndex(tonumber(winMgr:getWindow("GMCommand_Event_Edit"):getText()))
	SetVisible(true)
	RequestCommand()
end

function OnClicked_Event_Button2( args )

	ClearArgs()
	SetCommandType(2)
	SetIndex(tonumber(winMgr:getWindow("GMCommand_Event_Edit"):getText()))
	SetVisible(false)
	RequestCommand()
end







