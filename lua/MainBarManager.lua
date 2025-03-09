--------------------------------------------------------------------
--
--
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

local MB_BASE 		= 0
local MB_EXTEND 	= 1

local NOW_BARTYPE	= -1

local BAR_BUTTON_MAX = 12
local SLOT_MAX	 = 10

BAR_BUTTON_NAME = { ['err'] = 0, "MainBar_Mail", "MainBar_Info", "MainBar_Bag", "MainBar_Quest", "MainBar_Profile", "MainBar_Message", "MainBar_Club",
								"MainBar_Event", "MainBar_MyShop", "MainBar_MyRoom", "MainBar_Shop", "MainBar_System" }

BAR_BUTTONTYPE_NONE		= -1 -- ��� ��ư ��Ȱ��ȭ
BAR_BUTTONTYPE_ALL		= 0  -- ��� ��ư Ȱ��ȭ
BAR_BUTTONTYPE_MAIL		= 1
BAR_BUTTONTYPE_INFO		= 2
BAR_BUTTONTYPE_BAG		= 3
BAR_BUTTONTYPE_QUEST	= 4
BAR_BUTTONTYPE_PROFILE	= 5
BAR_BUTTONTYPE_MESSAGE	= 6
BAR_BUTTONTYPE_CLUB		= 7
BAR_BUTTONTYPE_EVENT	= 8
BAR_BUTTONTYPE_MYSHOP	= 9
BAR_BUTTONTYPE_MYROOM	= 10
BAR_BUTTONTYPE_SHOP		= 11
BAR_BUTTONTYPE_SYSTEM	= 12
COUNT_BAR_BUTTONTYPE	= 12

EFFECT_INFINITE	= -8	-- addController ȣ��� INFINITE�μ� ���� TRUE�� ���޽�Ű�� ���� ���


-- tip �ִϸ��̼ǿ� �ʿ��� �μ���
local g_TipOrigPos = 135
local g_TipWindowSize = 282
local g_TipStartIndex = 60
local g_TipMinText = 100

local g_TipFontSize = 10
local g_TipText = ""
local g_TipPos = g_TipOrigPos
local g_distSum = 0


local g_mainWideType = -1

local stamina = require("StaminaSystem")

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBarWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setSize(1024, 64)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
mywindow:moveToFront()

-- ���� ������
MAIN_WINDOW = winMgr:getWindow("MainBarWindow")

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBarExtend")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 0)
mywindow:setPosition(3, 0)
mywindow:setSize(1018, 64)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MainBarExtend"):subscribeEvent("Shown", "OnShowMainBarExtend")

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBarBase")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 64)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 64)
mywindow:setPosition(3, 0)
mywindow:setSize(1018, 64)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)


--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
for i = 1, BAR_BUTTON_MAX do

	local textureX, sizeX

	if i == 1 then
		textureX = 435
		sizeX = 50
	elseif i == 12 then
		textureX = 965
		sizeX = 50
	else
		textureX = 485 + ((i - 2) * 48)
		sizeX = 48
	end
	
	mywindow = winMgr:createWindow("TaharezLook/Button", BAR_BUTTON_NAME[i])
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga", textureX, 128)
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga", textureX, 170)
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", textureX, 212)
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", textureX, 212)
	mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", textureX, 254)
	mywindow:setPosition(textureX-3, 5)
	mywindow:setSize(sizeX, 42)
	mywindow:setUserString("Index", i)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OpenPopupMenuEvent")
	mywindow:subscribeEvent("MouseButtonDown", "OnMouseButtonDownPopupMenuButton");
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnterPopupMenuButton");
	

	-- ����Ʈ
	effectWindow = winMgr:createWindow('TaharezLook/StaticImage', BAR_BUTTON_NAME[i] .. "_EffectImage");
	effectWindow:setTexture('Enabled', 'UIData/mainbarchat.tga', textureX, 296);
	effectWindow:setTexture('Disabled', 'UIData/mainbarchat.tga', textureX, 296);
	effectWindow:setEnabled(false)
	effectWindow:setVisible(false)
	effectWindow:setAlwaysOnTop(true)
	effectWindow:setPosition(0, -8);
	effectWindow:setClippedByParent(false)
	effectWindow:setSize(sizeX, 50);
	effectWindow:setZOrderingEnabled(false)
	effectWindow:addController(BAR_BUTTON_NAME[i] .. "_Controller", BAR_BUTTON_NAME[i] .. "_Effect", "alpha", "Sine_EaseInOut", 255, 0, 8, true, true, 20)
	effectWindow:addController(BAR_BUTTON_NAME[i] .. "_Controller", BAR_BUTTON_NAME[i] .. "_Effect", "alpha", "Sine_EaseInOut", 0, 255, 8, true, true, 20)
	mywindow:addChildWindow( effectWindow )
	
end


-- my shop�� �⺻������ ��Ȱ��ȭ(���忡���� Ȱ��ȭ)
winMgr:getWindow("MainBar_MyShop"):setEnabled(false)



g_FontData = {['protecterr'] = 0, 
g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 0,0,0,255 }

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
for i = 1, SLOT_MAX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_Slot"..i)
	
	if i == 1 then
		mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 128)
		mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 128)
		mywindow:setPosition(6, 5)
		mywindow:setSize(42, 42)
	elseif i == 10 then
		mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 362, 128)
		mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 362, 128)
		mywindow:setPosition(368, 5)
		mywindow:setSize(41, 42)
	else
		mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 42 + ((i - 2)  * 40), 128)
		mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 42 + ((i - 2)  * 40), 128)
		mywindow:setPosition(48 + ((i - 2) * 40), 5)
		mywindow:setSize(40, 42)
	end
	
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	mywindow:moveToBack()



	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_SlotText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(8, 24)
	mywindow:setSize(38, 18)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("MainBar_Slot"..i):addChildWindow(mywindow)
	
	

	-- ���� ��Ÿ���� �����ϱ� ���� ��Ʈ�ѵ�
	-- ���� ��ų ��Ÿ�Ӱ� �ڵ尡 ��ġ�� ����� �ణ �ٸ����� �ְ� ������ �����̳� �����۾��� �����Ǿ� ���������Ƿ�
	-- �� ������ ����� �̰��� ������ ���´�.
	--------------------------------------------------------------------------------
	-- ��Ÿ�� ( ����â )
	--------------------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_CoolTimeBtn_" .. i)
	mywindow:setTexture("Enabled",	"UIData/zombi001.tga", 37, 884)
	mywindow:setTexture("Disabled",	"UIData/zombi001.tga", 37, 884)
	mywindow:setProperty("FrameEnabled",		"False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setSize(37, 36)
--	mywindow:setPosition(525 + (i * 40) , 4)
--	mywindow:setPosition(11 + (i * 40) , 6)
	mywindow:setPosition(2, 3)
	if i == 1 then
		mywindow:setPosition(4, 3)
	end
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("MainBar_Slot" .. i):addChildWindow(mywindow)

	--------------------------------------------------------------------
	-- ���� ���� ��Ÿ�� �ؽ�Ʈ
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_RemainTime_Text_" .. i)
	mywindow:setProperty("FrameEnabled",		"false")
	mywindow:setProperty("BackgroundEnabled",	"false")
--	mywindow:setPosition(539 + (i * 40) , 16)
--	mywindow:setPosition(24 + (i * 40) , 17)
--	mywindow:setPosition(13 , 12)
	mywindow:setPosition(15 , 15)
	if i == 1 then
		mywindow:setPosition(17 , 16)
	end
	mywindow:setSize(40, 20)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(12)
	mywindow:setViewTextMode(1)
	mywindow:addTextExtends("", g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("MainBar_Slot" .. i):addChildWindow(mywindow)
end

---------------------------------------------------------------------
-- ��Ÿ��
---------------------------------------------------------------------
function MainbarSetCoolitime( num, scale, time )

	if time > 0 then
		-- ��Ÿ�� ������
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):clearTextExtends()
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):addTextExtends(time, g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):setVisible(true)
		
		winMgr:getWindow("MainBar_CoolTimeBtn_" .. num):setVisible(true)
		winMgr:getWindow("MainBar_CoolTimeBtn_" .. num):setScaleHeight(scale)
	else
		-- ��Ÿ�� ����
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):clearTextExtends()
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):addTextExtends(" " , g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
		winMgr:getWindow("MainBar_RemainTime_Text_" .. num):setVisible(false)
		
		winMgr:getWindow("MainBar_CoolTimeBtn_" .. num):setVisible(false)
	end
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
local SLOT_TAB_MOVE_NAME = { ['err'] = 0, "UP", "DWON" }

local SLOT_TEXX			= 871
local SLOT_TEXY 			= 481

for i = 1, #SLOT_TAB_MOVE_NAME do
	mywindow = winMgr:createWindow("TaharezLook/Button", "MainBar_Slot"..SLOT_TAB_MOVE_NAME[i])
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga", SLOT_TEXX + (17 * (i - 1)), SLOT_TEXY)
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga", SLOT_TEXX + (17 * (i - 1)), SLOT_TEXY + (21 * 1))
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", SLOT_TEXX + (17 * (i - 1)), SLOT_TEXY + (21 * 2))
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", SLOT_TEXX + (17 * (i - 1)), SLOT_TEXY + (21 * 3))
	mywindow:setPosition(409, 5 + (21 * (i - 1)))
	mywindow:setSize(17, 21)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_TabIndex")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 426, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 426, 359)
mywindow:setPosition(411, 20)
mywindow:setSize(9, 12)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_Help")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 0, 346)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 346)
mywindow:setPosition(8, 48)
mywindow:setSize(55, 13)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_Map")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 55, 346)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 55, 346)
mywindow:setPosition(67, 48)
mywindow:setSize(55, 13)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_Info_Key")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 110, 346)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 110, 346)
mywindow:setPosition(126, 48)
mywindow:setSize(65, 13)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MainBar_MyExp")
mywindow:setTexture("Enabled", "UIData/mainbarchat.tga", 516, 359)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 516, 359)
mywindow:setPosition(482, 51)
mywindow:setSize(378, 6)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_MyExp_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("MainBar_MyExp"):addChildWindow( winMgr:getWindow("MainBar_MyExp_Text") )

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_MyLv")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(437, 48)
mywindow:setSize(40, 18)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_MyZen")
mywindow:setTextColor(50,171,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(1000, 47)
--mywindow:setText("100,000,232")
mywindow:setSize(40, 18)
mywindow:setZOrderingEnabled(false)


--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MainBar_RandomTipText")
mywindow:setTextColor(255,198,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 10)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setPosition(135, 48)
mywindow:setSize(282, 18)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)



function OnShowMainBarExtend()
	RefreshSlot()
	stamina.SetVisible(true)
end

function MainBar_SetSlotText( index, text )
	
	local window = winMgr:getWindow("MainBar_SlotText"..index)
	
	if window ~= null then
		window:clearTextExtends()
		window:addTextExtends(text, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 0,0,0,255)
		window:setPosition(17 - string.len(text)*4, 24)
	end
	
end


function _addTipText( text )

	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0
	if text ~= "" then
		tbufStringTable = {['err']=0, }
		tbufSpecialTable = {['err']=0, }
		count = 0
		
		tbufStringTable, tbufSpecialTable = cuttingString(text, tbufStringTable, tbufSpecialTable, count)
		
		local str = ""
		
		for i = 0, #tbufStringTable do
			str = str .. tbufStringTable[i]
		end
		
		for j = 1, #str do
			if string.sub(str, j, j) == '\n' then
				local a = string.sub(str, 1, j-1)
				local b = string.sub(str, j+1, #str)
				str = a .. b
				break
			end
		end
	
		g_TipText = g_TipText .. str .. "                    "
	end
end

function MainBar_InitTip()

	 -- tip �ʱ�ȭ
	winMgr:getWindow("MainBar_RandomTipText"):clearTextExtends()
	
	_addTipText("                                                   ")
	_addTipText(GetRandomGameTip())
	_addTipText(GetRandomGameTip())
	_addTipText(GetRandomGameTip())
	
	local str = string.sub(g_TipText, 1, 55)
	winMgr:getWindow("MainBar_RandomTipText"):setText( str )

end

function MainBar_SetTipOption( origPos, winSize, startIndex, minText )

	g_TipOrigPos = origPos
	g_TipWindowSize = winSize
	g_TipStartIndex = startIndex
	g_TipMinText = minText
end



-- test

-- ���� �Լ�
function MainBar_Render()

	if winMgr:getWindow("MainBarExtend"):isVisible() then
		
		if IsVisibleGameTip() == false then
			winMgr:getWindow("MainBar_RandomTipText"):setText("")
			return
		end
		
		local valid = false

		g_TipPos = g_TipPos - 1
		g_distSum = g_distSum + 1
		
		if GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, 1)) == 0 then
			if	g_distSum >= GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, 2)) then
			
				g_TipText = string.sub(g_TipText, 3, string.len(g_TipText))
				valid = true
			end
		elseif g_distSum >= GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, 1)) then
		
			g_TipText = string.sub(g_TipText, 2, string.len(g_TipText))
			valid = true
		end
		
		if valid then
			g_TipPos = g_TipOrigPos
			g_distSum = 0
			
			
			local subStrEnd = g_TipStartIndex
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, g_TipStartIndex))
			if size < g_TipWindowSize then
				for i = g_TipStartIndex+1, string.len(g_TipText) do
					
					size = GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, i))
					
					if size > g_TipWindowSize then
						subStrEnd = i - 1
						break
					end
				end
			else
				for i = g_TipStartIndex-1, 1, -1 do

					size = GetStringSize(g_STRING_FONT_GULIMCHE, g_TipFontSize, string.sub(g_TipText, 1, i))
					
					if size < g_TipWindowSize then
						subStrEnd = i
						break
					end
				end
			end
			
			local str = string.sub(g_TipText, 1, subStrEnd)
			winMgr:getWindow("MainBar_RandomTipText"):setText( str )
			
			if string.len(g_TipText) < g_TipMinText then
				_addTipText(GetRandomGameTip())
			end
		end
		
		winMgr:getWindow("MainBar_RandomTipText"):setPosition( g_TipPos, 48 )	
	end
end


-- ��ĳ���� ���� ����
function SetMyCharacterInfoUI(level, zen, Exp, ExpbarSize, MaxExp, ExpPercent)

	if MAIN_WINDOW:isVisible() == true then
		winMgr:getWindow("MainBar_MyLv"):clearTextExtends()
		winMgr:getWindow("MainBar_MyLv"):addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 12, 255,222,36,255, 1, 0,0,0,255)
		
		local granText = CommatoMoneyStr64(zen)
		textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
		winMgr:getWindow("MainBar_MyZen"):setPosition(1000-textSize, 47)
		winMgr:getWindow("MainBar_MyZen"):setText(granText)
		
		local r,g,b = GetGranColor(zen)
		winMgr:getWindow("MainBar_MyZen"):setTextColor(r,g,b,255)
	
		winMgr:getWindow("MainBar_MyExp"):setSize(ExpbarSize, 7)
		
		SetMyCharacterInfoExp( level, Exp, MaxExp, ExpPercent )
	end
end

function SetMyCharacterInfoExp( level, Exp, MaxExp, ExpPercent )

	if MAIN_WINDOW:isVisible() == true then
		winMgr:getWindow("MainBar_MyLv"):clearTextExtends()
		winMgr:getWindow("MainBar_MyLv"):addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 12, 255,222,36,255, 1, 0,0,0,255)
		
		local expText = ExpPercent.."%  ("..Exp.." / "..MaxExp..")"
		textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, expText)
		winMgr:getWindow("MainBar_MyExp_Text"):setPosition(189 - textSize/2, -2)
		winMgr:getWindow("MainBar_MyExp_Text"):setSize(textSize, 18)
		winMgr:getWindow("MainBar_MyExp_Text"):clearTextExtends()
		winMgr:getWindow("MainBar_MyExp_Text"):addTextExtends(expText, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255, 1, 0,0,0,255)
	end
end


-- ��ĳ���� ���� ����ġ ���� ����(�����)
function SetMyCharacterInfoUIQuest(level , ExpbarSize)

	if MAIN_WINDOW:isVisible() == true then
		winMgr:getWindow("MainBar_MyLv"):clearTextExtends()
		winMgr:getWindow("MainBar_MyLv"):addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 12, 255,222,36,255, 1, 0,0,0,255)
		if ExpbarSize >= 0 then
			winMgr:getWindow("MainBar_MyExp"):setSize(ExpbarSize, 7)
		end
	end
end


-- ��ĳ���� �� ����(�����)
function SetMyCharacterInfoZenQuest(zen)
	local granText = CommatoMoneyStr64(zen)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, granText)
	winMgr:getWindow("MainBar_MyZen"):setPosition(1000-textSize, 47)
	winMgr:getWindow("MainBar_MyZen"):setText(granText)

	local r,g,b = GetGranColor(zen)
	winMgr:getWindow("MainBar_MyZen"):setTextColor(r,g,b,255)
end


--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------

function Mainbar_ActiveEffect( index, ... ) -- index, cnt = EFFECT_INFINITE, speed = 20

	local cnt = select(1, ...)
	local speed = select(2, ...)
	
	if cnt == nil then
		cnt = EFFECT_INFINITE
	end
	
	if speed == nil then
		speed = 20
	end
	
	effectWindow = winMgr:getWindow(BAR_BUTTON_NAME[index] .. "_EffectImage")
	effectWindow:setVisible(true)
	effectWindow:setUseEventController(false);
	effectWindow:clearControllerEvent(BAR_BUTTON_NAME[index] .. "_Effect");
	effectWindow:clearActiveController();
	
	if cnt == EFFECT_INFINITE then
		effectWindow:addController(BAR_BUTTON_NAME[index] .. "_Controller", BAR_BUTTON_NAME[index] .. "_Effect", "alpha", "Sine_EaseInOut", 0, 255, 8, true, true, speed)
		effectWindow:addController(BAR_BUTTON_NAME[index] .. "_Controller", BAR_BUTTON_NAME[index] .. "_Effect", "alpha", "Sine_EaseInOut", 255, 0, 8, true, true, speed)
	else
		for i = 1, cnt do
			effectWindow:addController(BAR_BUTTON_NAME[index] .. "_Controller", BAR_BUTTON_NAME[index] .. "_Effect", "alpha", "Sine_EaseInOut", 0, 255, 8, true, false, speed)
			effectWindow:addController(BAR_BUTTON_NAME[index] .. "_Controller", BAR_BUTTON_NAME[index] .. "_Effect", "alpha", "Sine_EaseInOut", 255, 0, 8, true, false, speed)
		end
	end
	
	effectWindow:activeMotion(BAR_BUTTON_NAME[index] .. "_Effect");
end

function Mainbar_ClearEffect( index )
	effectWindow = winMgr:getWindow(BAR_BUTTON_NAME[index] .. "_EffectImage")
	effectWindow:clearControllerEvent(BAR_BUTTON_NAME[index] .. "_Effect");
	effectWindow:clearActiveController();
--	effectWindow:setScaleWidth(255);
--	effectWindow:setScaleHeight(255);
	effectWindow:setVisible(false)
end


--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function OpenPopupMenuEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index = tonumber(local_window:getUserString('Index'))
	
	if local_window:isDisabled() then
		DebugStr(index .. "�� ��ư �̺�Ʈ, Enable���� : false")
	else
		DebugStr(index .. "�� ��ư �̺�Ʈ, Enable���� : true")
	end
	
	if index == 1 then
		CallPopupPresent()
	elseif index == 2 then
		CallPopupMyInfo()
	elseif index == 3 then
		CallPopupInven()
	elseif index == 4 then
		CallPopupQuest()
	elseif index == 5 then
		ShowProfileUi()
	elseif index == 6 then
		CallPopupMessenger()
	elseif index == 7 then
		CallPopupMyClub()
	elseif index == 8 then
		CallPopupEvent()
	elseif index == 9 then -- my shop
		if IsKoreanLanguage() == false then
			CloseSetVisualWindow() -- ����� ����â�� �ݴ´١�
		end
		
		if winMgr:getWindow("MailBackImage"):isVisible() then
			return
		end
		RequestMyShopCreated()
	
	elseif index == 10 then
		BtnPageMove_GoToMyItem()
	elseif index == 11 then
		BtnPageMove_GoToItemShop()
	elseif index == 12 then
		local isVisible = winMgr:getWindow("NewSystemBackImage"):isVisible()
		if isVisible == true then
			winMgr:getWindow("NewSystemBackImage"):setVisible(false)
		else
			DebugStr("TTTEST");
			root:addChildWindow(winMgr:getWindow("NewSystemBackImage"))
			winMgr:getWindow("NewSystemBackImage"):setAlwaysOnTop(true)
			winMgr:getWindow("NewSystemBackImage"):setVisible(true)
		end

	end
end

function OnMouseEnterPopupMenuButton(args)
	PlayWave('sound/Quickmenu01.wav');
end

function OnMouseButtonDownPopupMenuButton(args)
	PlayWave("sound/button_click.wav");
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function SettingBarCharacterInfo(MyLv, MyZen, MyNowExp, MyNextExp, MyExpPercent)
	
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function ZenColorRating(MyZen)

end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function MainBarUISetting(BarType)
	-- ������ Bar�� ������ �Ǿ� �ִٸ� �ʱ�ȭ�� �Ѵ�
	if NOW_BARTYPE > -1 then
		if NOW_BARTYPE == MB_BASE then
			BarBaseInit()
		elseif NOW_BARTYPE == MB_EXTEND then
			BarExtendInit()
		end
	end
	
	NOW_BARTYPE = BarType
	
	if NOW_BARTYPE == MB_BASE then
		BarBaseSetting()
	elseif NOW_BARTYPE == MB_EXTEND then
		BarExtendSetting()
	end
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function MainBar_SetWideType( type )
	if 1 <= type and type <= 10 then
		g_mainWideType = type
	end
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function BarBaseInit()

	MAIN_WINDOW:removeChildWindow( winMgr:getWindow("MainBarBase") )
	winMgr:getWindow("MainBarBase"):setVisible( false )
	
	for i = 1, BAR_BUTTON_MAX do
		winMgr:getWindow("MainBarBase"):removeChildWindow( winMgr:getWindow(BAR_BUTTON_NAME[i]) )
	end
	
	winMgr:getWindow("MainBarBase"):removeChildWindow( winMgr:getWindow("MainBar_MyExp") )
	winMgr:getWindow("MainBarBase"):removeChildWindow( winMgr:getWindow("MainBar_MyLv") )
	winMgr:getWindow("MainBarBase"):removeChildWindow( winMgr:getWindow("MainBar_MyZen") )
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function BarBaseSetting()

	if g_mainWideType == -1 then
		g_mainWideType = 6
	end
	
	MAIN_WINDOW:setWideType(g_mainWideType)
	MAIN_WINDOW:setPosition(0, 704)
	MAIN_WINDOW:addChildWindow( winMgr:getWindow("MainBarBase") )
	winMgr:getWindow("MainBarBase"):setVisible( true )
		
	for i = 1, BAR_BUTTON_MAX do
		winMgr:getWindow("MainBarBase"):addChildWindow( winMgr:getWindow(BAR_BUTTON_NAME[i]) )
	end

	winMgr:getWindow("MainBarBase"):addChildWindow( winMgr:getWindow("MainBar_MyExp") )
	winMgr:getWindow("MainBarBase"):addChildWindow( winMgr:getWindow("MainBar_MyLv") )
	winMgr:getWindow("MainBarBase"):addChildWindow( winMgr:getWindow("MainBar_MyZen") )
	
	
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function BarExtendInit()

	MAIN_WINDOW:removeChildWindow( winMgr:getWindow("MainBarExtend") )
	winMgr:getWindow("MainBarExtend"):setVisible( false )
	
	for i = 1, BAR_BUTTON_MAX do
		winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow(BAR_BUTTON_NAME[i]) )
	end
	
	for i = 1, SLOT_MAX do
		winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_Slot"..i) )
	end
	
	for i = 1, #SLOT_TAB_MOVE_NAME do
		winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_Slot"..SLOT_TAB_MOVE_NAME[i]) )
	end
	
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_TabIndex") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_Help") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_Map") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_Info_Key") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_MyExp") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_MyLv") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_MyZen") )
	winMgr:getWindow("MainBarExtend"):removeChildWindow( winMgr:getWindow("MainBar_RandomTipText") )
end

--------------------------------------------------------------------
-- NAME : 
-- DESC : 
--------------------------------------------------------------------
function BarExtendSetting()

	if g_mainWideType == -1 then
		g_mainWideType = 7
	end
	
	MAIN_WINDOW:setWideType(g_mainWideType)
	MAIN_WINDOW:setPosition(0, 704)
	MAIN_WINDOW:addChildWindow( winMgr:getWindow("MainBarExtend") )
	winMgr:getWindow("MainBarExtend"):setVisible( true )
	
	for i = 1, BAR_BUTTON_MAX do
		 winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow(BAR_BUTTON_NAME[i]) )
	end
	
	for i = 1, SLOT_MAX do
		 winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_Slot"..i) )
	end
	
	for i = 1, #SLOT_TAB_MOVE_NAME do
		 winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_Slot"..SLOT_TAB_MOVE_NAME[i]) )
	end
	
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_TabIndex") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_Help") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_Map") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_Info_Key") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_MyExp") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_MyLv") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_MyZen") )
	winMgr:getWindow("MainBarExtend"):addChildWindow( winMgr:getWindow("MainBar_RandomTipText") ) 	

end

function BarExtendLoop(StartTime, CurrentTime)
		local NowTick = CurrentTime - StartTime
		
		if NowTick > 1000 then
			SettingStartTime(CurrentTime)
		end
		DebugStr(NowTick)
end




--------------------------------------------------------------------

-- �˾�â �ʿ��� �κи� ���̰� �ϱ�
-- -> ��ġ�� �״��, enable�� �����ϴ°ɷ� ����

--------------------------------------------------------------------

-- �Ź���
function MainBar_SetBarButton( ... )

	local cnt = select('#', ...)
	
	for i = 1, COUNT_BAR_BUTTONTYPE do
		winMgr:getWindow(BAR_BUTTON_NAME[i]):setEnabled(false)
	end
	
	for i = 1, cnt do
		if select(i, ...) == BAR_BUTTONTYPE_NONE then
			for j = 1, COUNT_BAR_BUTTONTYPE do
				winMgr:getWindow(BAR_BUTTON_NAME[j]):setEnabled(false)
			end
		elseif select(i, ...) == BAR_BUTTONTYPE_ALL then
			for j = 1, COUNT_BAR_BUTTONTYPE do
				winMgr:getWindow(BAR_BUTTON_NAME[j]):setEnabled(true)
			end
		else
			winMgr:getWindow(BAR_BUTTON_NAME[select(i, ...)]):setEnabled(true)
		end
	end
end


-- ������
function SelectPopup(bMyinfo, bMyRoom, bInventory, bQuest , bProfile, bMessenger, bClub, bEvent, bCash, bSystem)
	
	DebugStr('SelectPopup()')
	
	if bSystem == 0 then
		winMgr:getWindow("MainBar_System"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_System"):setEnabled(true)
	end
		
	if bCash == 0 then
		winMgr:getWindow("MainBar_Shop"):setEnabled(false)
		winMgr:getWindow("MainBar_Bag"):setEnabled(false)	-- ĳ�ü����� �κ��丮 ����
	else
		winMgr:getWindow("MainBar_Shop"):setEnabled(true)
		winMgr:getWindow("MainBar_Bag"):setEnabled(true)   -- ĳ�ü����� �κ��丮 ���� ����
	end
	
	if bMyRoom == 0 then
		winMgr:getWindow("MainBar_MyRoom"):setEnabled(false)
		winMgr:getWindow("MainBar_Bag"):setEnabled(false)	-- ���̷뿡�� �κ��丮 ����
	else
		winMgr:getWindow("MainBar_MyRoom"):setEnabled(true)
		winMgr:getWindow("MainBar_Bag"):setEnabled(true)	-- ���̷뿡�� �κ��丮 ���� ����
		
	end
	
	if CheckfacilityData(FACILITYCODE_MYSHOP) == false then
		winMgr:getWindow("MainBar_MyRoom"):setVisible(false)
	end
	
	
	if bEvent == 0 then
		winMgr:getWindow("MainBar_Event"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Event"):setEnabled(true)
	end
	
	if bClub == 0 then
		winMgr:getWindow("MainBar_Club"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Club"):setEnabled(true)
	end
	
	if bMessenger == 0 then
		winMgr:getWindow("MainBar_Message"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Message"):setEnabled(true)
	end
	
	if bProfile == 0 then
		winMgr:getWindow("MainBar_Profile"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Profile"):setEnabled(true)
	end
	
	if bQuest == 0 then
		winMgr:getWindow("MainBar_Quest"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Quest"):setEnabled(true)
	end
	
	local CurrentWndType = GetCurrentWndType()
	
	if bInventory == 0 then
		if CurrentWndType == WND_LUA_MYROOM and CurrentWndType == WND_LUA_ITEMSHOP then
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
		end
	else
		if CurrentWndType == WND_LUA_ITEMSHOP or CurrentWndType == WND_LUA_MYROOM then
			winMgr:getWindow("MainBar_Bag"):setEnabled(false)
		else
			winMgr:getWindow("MainBar_Bag"):setEnabled(true)
		end
	end
	
	if bMyinfo == 0 then
		winMgr:getWindow("MainBar_Info"):setEnabled(false)
	else
		winMgr:getWindow("MainBar_Info"):setEnabled(true)
	end
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		winMgr:getWindow("MainBar_MyShop"):setEnabled(false)
		--winMgr:getWindow("MainBar_Shop"):setEnabled(false)
	end
	
	if CurrentWndType == WND_LUA_LOBBY then
		winMgr:getWindow("MainBar_Shop"):setEnabled(true)
	end 
	
	if CurrentWndType == WND_LUA_ITEMSHOP or CurrentWndType == WND_LUA_MYROOM then
		winMgr:getWindow("MainBar_Mail"):setEnabled(true)	
	else
		winMgr:getWindow("MainBar_Mail"):setEnabled(false)	
	end

end


function AllMainBarOff()
	DebugStr("AllPopupOff");
	OnClickMailClose();
	CloseUserInfoWindow();
	HideMyInventory();
	HideMyQuestMainWindow();
	OnClickProfileClose();
	OnClickClose();
	OnClickClubList_Close();
	OnClickedEventPopupClosed();
	CloseNewSystemMenu();
end

function MainBarOffExceptSysmenu()
	DebugStr("AllPopupOff");
	OnClickMailClose();
	CloseUserInfoWindow();
	HideMyInventory();
	HideMyQuestMainWindow();
	OnClickProfileClose();
	OnClickClose();
	OnClickClubList_Close();
	OnClickedEventPopupClosed();
	CloseNewSystemMenu();
end


stamina.InitUI(winMgr,MAIN_WINDOW)

local mainBarExtend = winMgr:getWindow("MainBarExtend")
if mainBarExtend ~= nil then
	mainBarExtend:subscribeEvent("Hidden", function()
		stamina.SetVisible(false)
	end)
end