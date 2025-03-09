 --------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
--guiSystem:setDefaultTooltip("TaharezLook/Tooltip")





--------------------------------------------------------------------

-- ���÷��� ����Ʈâ ����

--------------------------------------------------------------------
function LoadReplayList()
	WndSelectChannel_LoadReplayFile()
	winMgr:getWindow("���÷��� ����â"):setVisible(true)
	winMgr:getWindow("���÷��� ����â"):setVisible(true)
end




--------------------------------------------------------------------

-- ���÷��� ����â �̹���

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "���÷��� ����â")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- ���÷��� ����â
replaywindow = winMgr:createWindow("TaharezLook/StaticImage", "���÷��� ����â")
replaywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
replaywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
replaywindow:setProperty("FrameEnabled", "False")
replaywindow:setProperty("BackgroundEnabled", "False")
replaywindow:setPosition(338, 246)
replaywindow:setSize(349, 276)
replaywindow:setVisible(false)
replaywindow:setAlwaysOnTop(true)
replaywindow:setZOrderingEnabled(false)
root:addChildWindow(replaywindow)


-- ���÷��� ����Ʈ �ڽ�
mywindow = winMgr:createWindow("TaharezLook/Listbox", "���÷��� ����Ʈ�ڽ�")
mywindow:setPosition(25, 46)
mywindow:setSize(300, 180)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:subscribeEvent("MouseDoubleClicked", "WndReplay_SelectReplay")
replaywindow:addChildWindow(mywindow)






--------------------------------------------------------------------

-- ���÷��� ����Ʈ�� �߰��ϱ�

--------------------------------------------------------------------
function WndReplay_AddReplayList(replayName)

	local cols	  = CEGUI.PropertyHelper:stringToColourRect("tl:AAAAFFAA tr:AAAAFFAA bl:AAAAFFAA br:AAAAFFAA")
	local newItem = CEGUI.createListboxTextItem(replayName, 0, nil, false, true)
	newItem:setSelectionBrushImage("TaharezLook", "MultiListSelectionBrush")
	newItem:setSelectionColours(cols)

	CEGUI.toListbox(winMgr:getWindow("���÷��� ����Ʈ�ڽ�")):addItem(newItem)
end






--------------------------------------------------------------------

-- ���÷��� ������ �����Ѵ�.

--------------------------------------------------------------------
function WndReplay_SelectReplay()

	local sel = CEGUI.toListbox(winMgr:getWindow("���÷��� ����Ʈ�ڽ�")):getSelectedIndex()
	if sel >= 0 then
	
		local item = CEGUI.toListbox(winMgr:getWindow("���÷��� ����Ʈ�ڽ�")):getListboxItemFromIndex(sel)
		local text = item:getText()
		WndSelectChannel_GoReplay(text)
		
	end
end






--------------------------------------------------------------------

-- ���÷��� ����Ʈ Ȯ��, ��� ��ư

--------------------------------------------------------------------
tChoiceReplayName  = { ["protecterr"]=0, "���÷��� ���� Ȯ�ι�ư", "���÷��� ���� ��ҹ�ư" }
tChoiceReplayTexX  = { ["protecterr"]=0, 349, 429 }
tChoiceReplayPosX  = { ["protecterr"]=0, 165, 248 }
tChoiceReplayEvent = { ["protecterr"]=0, "ChoiceReplay_OK", "ChoiceReplay_CANCEL" }


for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tChoiceReplayName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 392)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 426)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 460)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 494)
	mywindow:setPosition(tChoiceReplayPosX[i], 228)
	mywindow:setSize(80, 34)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tChoiceReplayEvent[i])
	replaywindow:addChildWindow(mywindow)
end



function ChoiceReplay_OK()
	WndReplay_SelectReplay()
	ChoiceReplay_CANCEL()
end



function ChoiceReplay_CANCEL()
	
	if winMgr:getWindow("���÷��� ����â") then
		winMgr:getWindow("���÷��� ����â"):setVisible(false)
		winMgr:getWindow("���÷��� ����â"):setVisible(false)
	end
	
	if winMgr:getWindow("���÷��� ����Ʈ�ڽ�") then
		CEGUI.toListbox(winMgr:getWindow("���÷��� ����Ʈ�ڽ�")):clearAllItem()
	end
end
