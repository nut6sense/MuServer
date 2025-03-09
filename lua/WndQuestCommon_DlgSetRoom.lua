-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)



--[[
--------------------------------------------------------------------

-- �游��� �˾�â

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "�游��� ����â")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- �游��� ����â
makeroomwindow = winMgr:createWindow("TaharezLook/StaticImage", "�游��� ����â")
makeroomwindow:setTexture("Enabled", "UIData/createquestpopup001.tga", 376, 435)
makeroomwindow:setTexture("Disabled", "UIData/createquestpopup001.tga", 376, 435)
makeroomwindow:setProperty("FrameEnabled", "False")
makeroomwindow:setProperty("BackgroundEnabled", "False")
makeroomwindow:setPosition(350, 200)
makeroomwindow:setSize(347, 445)
makeroomwindow:setVisible(false)
makeroomwindow:setAlwaysOnTop(true)
makeroomwindow:setZOrderingEnabled(false)
root:addChildWindow(makeroomwindow)


-- �游��� Ȯ��, �游��� ��ҹ�ư
tMakeBattleRoomName  = { ["protecterr"]=0, "�游��� Ȯ�ι�ư", "�游��� ��ҹ�ư" }
tMakeBattleRoomTexX	 = { ["protecterr"]=0, 349, 429 }
tMakeBattleRoomPosX	 = { ["protecterr"]=0, 165, 248 }
tMakeBattleRoomEvent = { ["protecterr"]=0, "MakeRoom_OK", "MakeRoom_CANCEL" }

for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMakeBattleRoomName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 392)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 426)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 460)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 392)
	mywindow:setPosition(tMakeBattleRoomPosX[i], 268)
	mywindow:setSize(80, 34)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tMakeBattleRoomEvent[i])
	makeroomwindow:addChildWindow(mywindow)
end



function MakeRoom_OK()
	MakeRoom_CANCEL()
	
	roomPassword = winMgr:getWindow("�����_��й�ȣ"):getText()	
	WndQuestLobby_createRoom(tQuestListList[listIndex][roomCreate_currentquestIndex], roomCreate_difficult, roomCreate_userCount, roomPassword)
end



function MakeRoom_CANCEL()
	winMgr:getWindow("�游��� ����â"):setVisible(false)
	winMgr:getWindow("�游��� ����â"):setVisible(false)
	
	-- �游��⸦ �ϼ��ϸ� ä��â�� Ȱ��ȭ ��Ų��
	winMgr:getWindow("ä���ϱ�"):setEnabled(true)
end




--------------------------------------------------------------------

-- ����Ʈ�� ����� 5�� ����
--------------------------------------------------------------------

-- 1. ����Ʈ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "����Ʈ ����")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(130, 60)
mywindow:setSize(40, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

function QuestTitie()
	name = WndQuestLobby_GetQuestInfo(tQuestListList[listIndex][roomCreate_currentquestIndex])
	winMgr:getWindow("����Ʈ ����"):setText(name)
end




-- 2. ����Ʈ ��ȣ
for i=1, table.getn(tQuestListList[listIndex]) do

	width = 39
	widthgab = 42	

	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "�� �游��� ����Ʈ")
	mywindow:setTexture("Normal", "UIData/questlobby001.tga", 672 + width* (i - 1), 152)
	mywindow:setTexture("Hover", "UIData/questlobby001.tga",  672 + width* (i - 1), 194)
	mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  672 + width* (i - 1), 236)
	mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedNormal", "UIData/questlobby001.tga" ,672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedHover", "UIData/questlobby001.tga" , 672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedPushed", "UIData/questlobby001.tga",  672 + width* (i - 1), 236)
	mywindow:setTexture("SelectedPushedOff", "UIData/questlobby001.tga",  672 + width* (i - 1), 194)
	mywindow:setPosition(26 + widthgab * (i - 1), 90)
	mywindow:setSize(width, 42)
	mywindow:setProperty("GroupID", 400)
	
	if( i == currentquestIndex ) then	
		mywindow:setProperty("Selected", "true")
	else
		mywindow:setProperty("Selected", "false")
	end
		
	mywindow:setUserString( "QuestIndex", i )
	mywindow:subscribeEvent("SelectStateChanged","WndQuestLobby_RoomCreate_QuestSelectChanged")
	makeroomwindow:addChildWindow(mywindow)
end


function WndQuestLobby_RoomCreate_QuestSelectChanged(args)
	currentquestIndex = tonumber( CEGUI.toWindowEventArgs(args).window:getUserString( "QuestIndex" ))
end




-- 3. ���̵�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "����Ʈ ���̵�")
mywindow:setTexture("Enabled", "UIData/questlobby001.tga", 592, 189)
mywindow:setTexture("Disabled", "UIData/questlobby001.tga", 592, 189)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(178, 143)
mywindow:setSize(80, 24)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

--����Ʈ ���̵� ���� ����
mywindow = winMgr:createWindow("TaharezLook/Button", "�����_���̵�����")
mywindow:setPosition(128, 140)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 962 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  962, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  962, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 962 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_DifficultLeftClicked")
makeroomwindow:addChildWindow(mywindow)


--����Ʈ ���̵� ������ ����
mywindow = winMgr:createWindow("TaharezLook/Button", "�����_���̵�������")
mywindow:setPosition(278, 140)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 990 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  990, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  990, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 990 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_DifficultRightClicked")
makeroomwindow:addChildWindow(mywindow)


function WndQuestLobby_RoomCreate_DifficultLeftClicked()

	if( roomCreate_difficult == 0 ) then
		roomCreate_difficult = 2
	else
		roomCreate_difficult = roomCreate_difficult - 1
	end
	
	ChangeDifficult()
end


function WndQuestLobby_RoomCreate_DifficultRightClicked()
	
	if( roomCreate_difficult == 2 ) then
		roomCreate_difficult = 0
	else
		roomCreate_difficult = roomCreate_difficult + 1
	end
	
	ChangeDifficult()
end


function ChangeDifficult()
	winMgr:getWindow("����Ʈ ���̵�"):setTexture("Enabled", "UIData/questlobby001.tga", 592, 189+(roomCreate_difficult*24))
end





-- 4. �ο�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "�����_�ο�����")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("2 ��")
mywindow:setPosition(202, 182)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)


--�ο� ���� ����
mywindow = winMgr:createWindow("TaharezLook/Button", "�����_�ο�����")
mywindow:setPosition(128, 178)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 962 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  962, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  962, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 962 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_UserCountLeftClicked")
makeroomwindow:addChildWindow(mywindow)


--�ο� ������ ����
mywindow = winMgr:createWindow("TaharezLook/Button", "�����_�ο�������")
mywindow:setPosition(278, 178)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 990 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  990, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  990, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 990 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_UserCountRightClicked")
makeroomwindow:addChildWindow(mywindow)


function WndQuestLobby_RoomCreate_UserCountLeftClicked()
	
	if( roomCreate_userCount == 1 ) then
		roomCreate_userCount = 4
	else
		roomCreate_userCount = roomCreate_userCount -1
	end
	
	ChangeUserCount()
end


function WndQuestLobby_RoomCreate_UserCountRightClicked()
		
	if( roomCreate_userCount == 4 ) then	
		roomCreate_userCount = 1
	else
		roomCreate_userCount = roomCreate_userCount + 1
	end
	
	ChangeUserCount()
end


function ChangeUserCount()
	winMgr:getWindow("�����_�ο�����"):setText(roomCreate_userCount .. " ��")
end





-- 5. ��й�ȣ
mywindow = winMgr:createWindow("TaharezLook/Editbox", "�����_��й�ȣ")
mywindow:setText("")
mywindow:setPosition(161, 220)
mywindow:setSize(113,24)	
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
makeroomwindow:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("�����_��й�ȣ")):setMaxTextLength(6)








--------------------------------------------------------------------

-- �����޼���(C���� ȣ��)

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "����Ʈ�� ���� ����â")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- ���� ����â
errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "����Ʈ�� ���� ����â")
errorwindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
errorwindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 0, 392)
errorwindow:setProperty("FrameEnabled", "False")
errorwindow:setProperty("BackgroundEnabled", "False")
errorwindow:setPosition(350, 246)
errorwindow:setSize(349, 276)
errorwindow:setVisible(false)
errorwindow:setAlwaysOnTop(true)
errorwindow:setZOrderingEnabled(false)
root:addChildWindow(errorwindow)

-- ���� ����â
mywindow = winMgr:createWindow("TaharezLook/StaticText", "����Ʈ�� ���� ����â")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIM, 14)
mywindow:setText("")
mywindow:setPosition(60, 110)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
errorwindow:addChildWindow(mywindow)

-- ���� Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "����Ʈ�� ���� Ȯ�ι�ư")
mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga",349, 392)
mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 349, 426)
mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 349, 460)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 349, 494)
mywindow:setPosition(245, 236)
mywindow:setSize(80, 34)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "WndQuestRoomErrorOK")
errorwindow:addChildWindow(mywindow)

function WndQuestRoomErrorOK()
	winMgr:getWindow("����Ʈ�� ���� ����â"):setVisible(false)
	winMgr:getWindow("����Ʈ�� ���� ����â"):setVisible(false)
	winMgr:getWindow("����Ʈ�� ���� ����â"):setPosition(60, 110)
	winMgr:getWindow("����Ʈ�� ���� ����â"):setText("")
	
	-- ����OK�� ������ ä��â�� Ȱ��ȭ ��Ų��
	winMgr:getWindow("ä���ϱ�"):setEnabled(true)
end

function WndQuestRoom_WarningMessage(errorMessgae)
	winMgr:getWindow("����Ʈ�� ���� ����â"):setVisible(true)
	winMgr:getWindow("����Ʈ�� ���� ����â"):setVisible(true)
	
	-- 28���ڱ��� 1��
	if string.len(errorMessgae) <= 20 then
		winMgr:getWindow("����Ʈ�� ���� ����â"):setPosition(100, 110)
	elseif 34 <= string.len(errorMessgae) and string.len(errorMessgae) <= 38 then
		winMgr:getWindow("����Ʈ�� ���� ����â"):setPosition(30, 110)
	elseif 38 < string.len(errorMessgae) and string.len(errorMessgae) < 44 then
		winMgr:getWindow("����Ʈ�� ���� ����â"):setPosition(16, 110)
	end
	winMgr:getWindow("����Ʈ�� ���� ����â"):setText(errorMessgae)
end

--]]