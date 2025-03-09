--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

MsgPosIndex = GetMsgCurrentPos()
--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------

-- 광장, 로비, 클럽로비, 대전룸, 아케이드룸,  마이룸, 샵, 마이룸

local MSG_OutputPosX		= {['err']=0, 0,   15   , 10  , 598,   7,  10, 10,  0 ,0}--512
local MSG_OutputPosY		= {['err']=0, 428, 723, 485,  68, 510, 730, 730 ,0 ,0}
local MSG_WideType			= {['err']=0, WIDETYPE_2, WIDETYPE_6, WIDETYPE_6,  WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_6, WIDETYPE_2, WIDETYPE_2, WIDETYPE_2, WIDETYPE_2}


------------------------------------------------------------------
-- 공지메세지 백그라운드 이미지.
------------------------------------------------------------------

local NoticeMsgPosX, NoticeMsgPosY

-- 채팅창 위치에 맞춤
if winMgr:getWindow("ChatBackground") then
	local top, bottom, left, right = GetCEGUIWindowRect("ChatBackground")
	NoticeMsgPosX = left
	NoticeMsgPosY = top - 33
else
	NoticeMsgPosX = 3
	NoticeMsgPosY = 704
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeMsgBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 604, 967)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 604, 967)

if winMgr:getWindow("ChatBackground") == nil then 
	mywindow:setWideType(MSG_WideType[MsgPosIndex]);
end

mywindow:setPosition(NoticeMsgPosX, NoticeMsgPosY)
mywindow:setSize(426, 31)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


------------------------------------------------------------------
-- 공지메세지 Bar 이미지.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeMsgBarImage")
mywindow:setTexture("Enabled", "UIData//mainbarchat.tga", 0 ,512)  --281 42
mywindow:setTexture("Disabled", "UIData//mainbarchat.tga", 0 ,512)
mywindow:setPosition(0,0)
mywindow:setSize(426, 31)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NoticeMsgBackground'):addChildWindow(mywindow)

------------------------------------------------------------------
-- 공지메세지 아이템 이미지.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeMsgPalaceImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 281, 42)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 281, 42)
mywindow:setPosition(1, 3)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(80)
mywindow:setScaleHeight(80)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NoticeMsgBarImage'):addChildWindow(mywindow)
------------------------------------------------------------------
-- 공지메세지 아이템 이미지.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeMsgItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 281, 42)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 281, 42)
mywindow:setPosition(35, 3)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(80)
mywindow:setScaleHeight(80)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NoticeMsgBarImage'):addChildWindow(mywindow)

------------------------------------------------------------------
-- 공지메세지 내용 텍스트
------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'NoticeMsgString')
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setTextColor(36,180,255,255)
mywindow:setPosition(70, 1);
mywindow:setSize(395, 31);
mywindow:setAlign(5)
mywindow:setLineSpacing(0)
mywindow:setViewTextMode(1)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('NoticeMsgBarImage'):addChildWindow(mywindow)

------------------------------------------------------------------
-- 공지메세지 랜더이미지.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeRenderImage")
mywindow:setTexture("Enabled", "UIData/Invisible.tga", 604, 967)
mywindow:setTexture("Disabled", "UIData/Invisible.tga", 604, 967)
mywindow:setPosition(0, 0)
mywindow:setSize(1, 1)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("EndRender", "MsgRenderForTime")
winMgr:getWindow('NoticeMsgBackground'):addChildWindow(mywindow)


function ShowNoticeMsgWindow()
	winMgr:getWindow("NoticeMsgBackground"):setVisible(true)
end


function ShowNoticeMsg(PalaceType , Noticepath , NoticeMsg )
	
	if winMgr:getWindow("NoticeMsgBackground"):isVisible() == false then
		ShowNoticeMsgWindow()
	end
	local Message = MsgAdjust(g_STRING_FONT_GULIM, 13, NoticeMsg, 300)
	local PalacePath = PalaceType
	--[[
	if PalaceType == 0 then
		PalacePath = "UIData/ItemUiData/item/CASH_egg2.tga"
	elseif PalaceType == 1 then
		PalacePath = "UIData/ItemUiData/item/CASH_Drill2.tga"
	elseif PalaceType == 2 then
		PalacePath = "UIData/ItemUiData/item/Ranbox01.tga"
	elseif PalaceType == 3 then
		PalacePath = "UIData/ItemUiData/item/Ranbox02.tga"
	elseif PalaceType == 4 then
		PalacePath = "UIData/ItemUiData/item/SkillUpgradeCupon.tga"
	elseif PalaceType == 5 then
		PalacePath = "UIData/ItemUiData/item/CostumeUP_Box.tga"	
	elseif PalaceType == 6 then
		PalacePath = "UIData/ItemUiData/item/Set_Random_Box1.tga"	
	else
		PalacePath = "UIData/ItemUiData/item/CASH_Cube2.tga"
	end
	--]]
	
	winMgr:getWindow("NoticeMsgPalaceImage"):setTexture("Enabled", PalacePath , 0, 0 )
	winMgr:getWindow("NoticeMsgPalaceImage"):setTexture("Disabled", PalacePath , 0, 0 )
	
	winMgr:getWindow("NoticeMsgItemImage"):setTexture("Enabled", Noticepath , 0, 0 )
	winMgr:getWindow("NoticeMsgItemImage"):setTexture("Disabled", Noticepath , 0, 0 )
	winMgr:getWindow("NoticeMsgString"):clearTextExtends()
	winMgr:getWindow("NoticeMsgString"):addTextExtends(Message, g_STRING_FONT_GULIMCHE, 13, 112,255,253,255,    1, 0,0,0,255);

end

function MsgRenderForTime()
	NoticeMsgVisible()
end

function HideNoticeMsg()
	winMgr:getWindow("NoticeMsgBackground"):setVisible(false)
	winMgr:getWindow("NoticeMsgPalaceImage"):setTexture("Enabled", "UIData/invisible.tga" , 0, 0 )
	winMgr:getWindow("NoticeMsgPalaceImage"):setTexture("Disabled", "UIData/invisible.tga" , 0, 0 )
	winMgr:getWindow("NoticeMsgItemImage"):setTexture("Enabled", "UIData/invisible.tga" , 0, 0 )
	winMgr:getWindow("NoticeMsgItemImage"):setTexture("Disabled", "UIData/invisible.tga" , 0, 0 )
	winMgr:getWindow("NoticeMsgString"):clearTextExtends()
end

function NoticeBackEventEnd()
	winMgr:getWindow("NoticeMsgBackground"):setVisible(false)
	winMgr:getWindow("NoticeMsgString"):clearTextExtends()
end

