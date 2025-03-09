--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local g_singleMatchUserName1 = ""
local g_singleMatchUserName2 = ""

--------------------------------------------------------------------

-- �ϴ��� ����� ��û�� ��

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "singleMatch_backImage1")
mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 493, 474)
mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 493, 474)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(358, 223)
mywindow:setSize(308, 322)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function ShowSingleMatchInfoToRequest(name2)
	g_singleMatchUserName2 = name2
	winMgr:getWindow("singleMatch_backImage1"):setVisible(true)
end


mywindow = winMgr:createWindow("TaharezLook/Button", "singleMatch_Okbutton1")
mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 836, 796)
mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 836, 826)
mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 836, 856)
mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 836, 796)
mywindow:setPosition(55, 280)
mywindow:setSize(94, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "RequestSingleMatch")
winMgr:getWindow("singleMatch_backImage1"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "singleMatch_Cancelbutton1")
mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 930, 796)
mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 930, 826)
mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 930, 856)
mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 930, 796)
mywindow:setPosition(158, 280)
mywindow:setSize(94, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseSingleMatch")
winMgr:getWindow("singleMatch_backImage1"):addChildWindow(mywindow)


function RequestSingleMatch()
	if g_singleMatchUserName2 ~= "" then
		RequestSingleMatchBattle(g_singleMatchUserName2)
	end
	g_singleMatchUserName2 = ""
	winMgr:getWindow("singleMatch_backImage1"):setVisible(false)
end

function CloseSingleMatch()
	winMgr:getWindow("singleMatch_backImage1"):setVisible(false)
end



--------------------------------------------------------------------

-- �ϴ��� ����� ��û �޾��� ��

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "singleMatch_backImage2")
mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 493, 474)
mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 493, 474)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(358, 223)
mywindow:setSize(308, 322)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function ShowSingleMatchInfoToAsked(level1, name1)
	g_singleMatchUserName1 = name1
	winMgr:getWindow("singleMatch_backImage2"):setVisible(true)
end


mywindow = winMgr:createWindow("TaharezLook/Button", "singleMatch_Okbutton2")
mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 648, 796)
mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 648, 826)
mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 648, 856)
mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 648, 796)
mywindow:setPosition(55, 280)
mywindow:setSize(94, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "AcceptSingleMatch")
winMgr:getWindow("singleMatch_backImage2"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "singleMatch_Cancelbutton2")
mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 742, 796)
mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 742, 826)
mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 742, 856)
mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 742, 796)
mywindow:setPosition(158, 280)
mywindow:setSize(94, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "RefuseSingleMatch")
winMgr:getWindow("singleMatch_backImage2"):addChildWindow(mywindow)


function AcceptSingleMatch()
	if g_singleMatchUserName1 ~= "" then
		AcceptSingleMatchBattle(g_singleMatchUserName1)
	end
	g_singleMatchUserName1 = ""
	winMgr:getWindow("singleMatch_backImage2"):setVisible(false)
end

function RefuseSingleMatch()
	if g_singleMatchUserName1 ~= "" then
		RefuseSingleMatchBattle(g_singleMatchUserName1)
	end
	g_singleMatchUserName1 = ""
	winMgr:getWindow("singleMatch_backImage2"):setVisible(false)
end




-------------------------------------------------------------

-- �ϴ��� ��� �˾�â

-------------------------------------------------------------
function SetSingleMatchState(state, characterKey, roomNumber)

	local windowName = "sj_SingleMatchBtn_"..characterKey
	if winMgr:getWindow(windowName) == nil then

		if state == 0 then
			return
		end
		
		if state == 1 then
			local mywindow = winMgr:createWindow("TaharezLook/Button", windowName)
			mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setSize(77, 45)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setEnabled(true)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("roomNumber", roomNumber)
			mywindow:subscribeEvent("Clicked", "ClickedSingleMatchEnter")
			root:addChildWindow(mywindow)
			
		elseif state == 2 then
			local mywindow = winMgr:createWindow("TaharezLook/Button", windowName)
			mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setSize(146, 143)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setEnabled(false)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("roomNumber", roomNumber)
			mywindow:subscribeEvent("Clicked", "ClickedSingleMatchEnter")
			root:addChildWindow(mywindow)
		end
	
	else
		local mywindow = winMgr:getWindow(windowName)
		if state == 0 then
			mywindow:setVisible(false)
			root:removeChildWindow(mywindow)
			winMgr:destroyWindow(mywindow)
			return
		end
		
		if state == 1 then
			mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 504, 796)
			mywindow:setSize(77, 45)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setEnabled(true)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("roomNumber", roomNumber)
	
		elseif state == 2 then
			mywindow:setTexture("Normal", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Hover", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Pushed", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("PushedOff", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Enabled", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 360, 796)
			mywindow:setSize(146, 143)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setEnabled(false)
			mywindow:setUserString("characterKey", characterKey)
			mywindow:setUserString("posX", 0)
			mywindow:setUserString("posY", 0)
			mywindow:setUserString("roomNumber", roomNumber)
		end
	end
end


function ClickedSingleMatchEnter(args)
	
	local characterKey = CEGUI.toWindowEventArgs(args).window:getUserString("roomNumber")
	
	-- �����Ϸ� ����
end



-- ���̼� ��ǳ���� �����ش�  ( �ؽ�Ʈ ��ġ���� ����)
function ShowSingleMatchState(state, characterKey, x, y)

	local windowName = "sj_SingleMatchBtn_"..characterKey
	if winMgr:getWindow(windowName) == nil then
		return
	end
	
	if state == 0 then
		if winMgr:getWindow(windowName) then
			winMgr:getWindow(windowName):setVisible(bVisible)
		end
		return
	end
	
	if winMgr:getWindow(windowName) then
	
		local boolPosX = 0	-- ��ǳ�� ��ġ
		local boolPosY = 0	-- ��ǳ�� ��ġ
		if state == 1 then
			boolPosX = x+30
			boolPosY = y-30
			winMgr:getWindow(windowName):setVisible(true)
			winMgr:getWindow(windowName):setPosition(boolPosX, boolPosY)
			
		elseif state == 2 then
			boolPosX = x
			boolPosY = y-30
			winMgr:getWindow(windowName):setVisible(true)
			winMgr:getWindow(windowName):setPosition(boolPosX, boolPosY)
		end
			
		winMgr:getWindow(windowName):setUserString("posX", textPosX)
		winMgr:getWindow(windowName):setUserString("posY", textPosY)
	end
end
