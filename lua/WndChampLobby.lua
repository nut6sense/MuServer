-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_BattleMode = GetCurrentChannelBattleMode() -- ���� ä���� ��Ʋ��带 ��´�(0:�Ϲ�, 1:�ͽ�Ʈ��)
local g_STRING_SELECTROOM			= PreCreateString_1682	--GetSStringInfo(LAN_LUA_LOBBY_SELECTROOM)	-- ���� ������ �ּ���.
local g_STRING_INPUT_PASSWORD		= PreCreateString_1161	--GetSStringInfo(LAN_LUA_WND_LOBBY_1)		-- ��й�ȣ�� �Է��� �ּ���
local STRING_SUCCESS_CHANGECLASS	= PreCreateString_1162	--GetSStringInfo(LAN_LUA_WND_LOBBY_2)		-- �����Ͽ����ϴ�.
local g_SelectedLobbyTab = 4
local MAX_USERNUM_IN_ROOM = 8

-- ��, ���� �ִ� �������� ��´�.
local MAX_ROOMPAGE, MAX_USERPAGE = WndLobby_GetMaxPages()

local g_currentRoomNumber = -1
local g_currentRoomIndex = -1

local USERINFO_POSX = 688
local USERINFO_POSY = 92	-- �������� y��ġ


--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setWideType(6);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
--ChangeChannelPosition('Battle lobby')


-- �ʱ� ä��â ����
function SetChatInitChampLobby()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
end


--------------------------------------------------------------------

-- drawTexture(StartRender:���۽ÿ� �׸���)

--------------------------------------------------------------------
function WndLobby_RenderBackImage(currentBattleChannelName)
	
	g_LOBBY_WIN_SIZEX, g_LOBBY_WIN_SIZEY = GetCurrentResolution()
	drawer:drawTexture("UIData/ChampWideBack.dds", 0, 0, g_LOBBY_WIN_SIZEX, g_LOBBY_WIN_SIZEY, (1920-g_LOBBY_WIN_SIZEX)/2 , (1200-g_LOBBY_WIN_SIZEY)/2)
	drawer:drawTexture("UIData/LobbyImage_champ.tga", 13, 123, 662, 389, 2, 3, WIDETYPE_6)		-- �� ����
	--drawer:drawTexture("UIData/LobbyImage_new002.tga", 705, 527, 289, 164, 0, 0, WIDETYPE_6)	-- ��������
	drawer:drawTexture("UIData/LobbyImage_champ.tga", USERINFO_POSX, USERINFO_POSY+29, 323, 393, 0, 396, WIDETYPE_6)		-- ��������
	--drawer:drawTexture("UIData/LobbyImage_champ.tga", 411, 81, 240, 29, 353, 632, WIDETYPE_6)		-- ������ ����	
	--drawer:drawTexture("UIData/bunhae_002.tga", 13, 88, 113, 27, 0, 82, WIDETYPE_6)		-- ���� ��ư �̹���

	-- ����ä�� �̸�
	if g_BattleMode == BATTLETYPE_NORMAL then
		drawer:setTextColor(255, 255, 255, 255)
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		drawer:setTextColor(220, 80, 220, 255)
	end
	
	if IsKoreanLanguage() then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
		--drawer:drawText("- "..currentBattleChannelName, 800, 42, WIDETYPE_6)
		--drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		--drawer:drawText("- ģ�� ������ KO��, ������ ��� ��ġ�� ������� �ʽ��ϴ� -", 250, 42, WIDETYPE_6)
	else
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawText("- "..currentBattleChannelName, 800, 42, WIDETYPE_6)
	end
end




--------------------------------------------------------------------

-- ����, ������ ����� �ٸ��� �ϱ�����

--------------------------------------------------------------------
local tRoomListReversPosX	= { ["protecterr"]=0, [0]=343, 50, 343, 50, 343, 50, 343, 50 }
local tRoomListPosX			= { ["protecterr"]=0, [0]=32, 347 }
local tRoomListPosY			= { ["protecterr"]=0, [0]=144, 144, 222, 222, 300, 300, 378, 378 }
function WndLobby_IsTeamBattle(index, gameMode, bTeam)
	if gameMode == 0 then
		if bTeam == 1 then
			drawer:drawTexture("UIData/LobbyImage_champ.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 0, 790, WIDETYPE_6)
		end
	elseif gameMode == 6 then
		drawer:drawTexture("UIData/LobbyImage_champ.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 621, 881, WIDETYPE_6)
	elseif gameMode == 8 then
		drawer:drawTexture("UIData/LobbyImage_champ.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 665, 128, WIDETYPE_6)
	end
end




--------------------------------------------------------------------

-- �� ������, ���� ������

--------------------------------------------------------------------
function WndLobby_AllPageInfo(currRoomPage, maxRoomPage, currUserPage, maxUserPage)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)

-----------------------------------------
-- �� ������
-----------------------------------------	
	local roomPageText = tostring((currRoomPage+1).."  /  "..(maxRoomPage+1))
	local roomPageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, roomPageText)
	drawer:drawText(roomPageText, 572-roomPageSize/2-230, 473, WIDETYPE_6)

-----------------------------------------
-- ���� ������
-----------------------------------------
	local userPageText = tostring((currUserPage+1).."  /  "..(maxUserPage+1))
	local userPageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, userPageText)
	drawer:drawText(userPageText, 850-userPageSize/2, USERINFO_POSY+383 , WIDETYPE_6)
end





--------------------------------------------------------------------

-- ������ �����ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_GoBattleRoomBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_champ.tga", 354, 562)
mywindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", 354, 585)
mywindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", 354, 608)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_champ.tga", 354, 562)
mywindow:setWideType(6);
mywindow:setPosition(583, 84)
mywindow:setSize(62, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "SearchGoBattleRoom")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
--root:addChildWindow(mywindow)


-- ������ ����
function SearchGoBattleRoom()

	local roomNum = winMgr:getWindow("sj_lobby_enterRoomEditBox"):getText()
	WndLobby_SearchBattleRoom(tonumber(roomNum), true)
	winMgr:getWindow("sj_lobby_enterRoomEditBox"):setText("")
	
end





--------------------------------------------------------------------

-- ������ ���� ����Ʈ �ڽ�

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_enterRoomEditBox")
mywindow:setWideType(6);
mywindow:setPosition(504, 84)
mywindow:setSize(70, 23)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:subscribeEvent("TextAccepted", "SearchGoBattleRoom")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(4)
root:addChildWindow(mywindow)







--------------------------------------------------------------------

-- �游�鶧 �ʿ��� ������(6��)

--------------------------------------------------------------------
PLAYTYPE_NOITEM = 0
PLAYTYPE_ITEM = 1
PLAYTYPE_CLASS = 2

roomName		= ""
nGameMode		= 0
bTeam			= true
bItem			= PLAYTYPE_ITEM
nMaxUser		= 8
roomPassword	= ""
extremeZen		= 0
autoBalance		= false
exceptE			= false
bLadderType		= false

function InitBattleRoomInfo()
	roomName		= ""
	nGameMode		= 0
	bTeam			= true
	bItem			= PLAYTYPE_ITEM
	nMaxUser		= 8
	roomPassword	= ""
	extremeZen		= 0
	autoBalance		= false
	exceptE			= false
	bLadderType		= false
end





--------------------------------------------------------------------

-- ��Ʋ�� ����Ʈ(MAX_ROOMPAGE)

--------------------------------------------------------------------
local tRoomListSort = {["err"]=0, [0]=1, 3, 5, 7, 0, 2, 4, 6}
for index=0, MAX_ROOMPAGE-1 do

	i = tRoomListSort[index]

	-- 1. ��Ʋ�� �渮��Ʈ(���� ��ư) ����
	roomwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_lobby_roomList_radioBtn")
	roomwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	roomwindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", 312, 790)
	roomwindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", 0, 863)
	roomwindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	roomwindow:setTexture("SelectedNormal", "UIData/LobbyImage_champ.tga", 0, 863)
	roomwindow:setTexture("SelectedHover", "UIData/LobbyImage_champ.tga", 0, 863)
	roomwindow:setTexture("SelectedPushed", "UIData/LobbyImage_champ.tga", 0, 863)
	roomwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_champ.tga", 0, 863)
	roomwindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 312, 863)				-- empty
	roomwindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 312, 863)			-- empty
	roomwindow:setTexture("SelectedEnabled", "UIData/LobbyImage_champ.tga", 312, 863)		-- empty(������ ���� ���������� ����)
	roomwindow:setTexture("SelectedDisabled", "UIData/LobbyImage_champ.tga", 312, 863)	-- empty(������ ���� ���������� ����)
	roomwindow:setWideType(6);
	roomwindow:setPosition(tRoomListPosX[i%2], tRoomListPosY[i])
	roomwindow:setSize(309, 73)
	roomwindow:setProperty("GroupID", 600)
	roomwindow:setZOrderingEnabled(false)
	roomwindow:setUserString("RoomIndex", i)
	roomwindow:setUserString("RoomNumber", 0)
	roomwindow:setVisible(true)
	roomwindow:setEnabled(false)
	roomwindow:subscribeEvent("MouseDoubleClicked", "EnterBattleRoom")	
	roomwindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo_inRoom")
	roomwindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo_inRoom")
	root:addChildWindow(roomwindow)
	
	-- 2. ���ȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomIndex")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(53, 255, 134, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
	mywindow:setPosition(40, 11)
	mywindow:setSize(60, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 3. ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomTitle")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
	mywindow:setPosition(100, 2)
	mywindow:setSize(300, 36)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 4. �������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isMRBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 462, 748)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 516, 748)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(4, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)	
		
	-- 5. ������, ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isTeamBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 462, 702)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 516, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(58, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 6. ������, ��������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isItemBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 354, 702)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 354, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(112, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 7. ��й�ȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomPassword")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 667, 206)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 667, 206)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(256, 45)
	mywindow:setSize(15, 17)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 8. �����ο�(���ڴ� ����)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomCurrentUserNum")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setPosition(274, 44)
	mywindow:setSize(80, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 9. ��Ű �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomRookieImage")
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 964, 94)
	mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 964, 94)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(255, 5)
	mywindow:setSize(47, 30)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 10. ������ �����̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomIsGamingAlphaImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 0, 936)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 0, 936)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2], tRoomListPosY[i])
	mywindow:setSize(309, 73)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	-- 11. Waiting, Playing �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomIsGamingImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 510, 664)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 510, 664)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(191, 42)
	mywindow:setSize(78, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--roomwindow:addChildWindow(mywindow)
	
	-- 12. ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_continueWinImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 608, 630)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 630)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(237, 3)
	mywindow:setSize(34, 34)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--roomwindow:addChildWindow(mywindow)
	
	-- 13. ���±���
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_continueWinText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 10)
	mywindow:setSize(33, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--winMgr:getWindow(i .. "sj_lobby_roomList_continueWinImage"):addChildWindow(mywindow)
	
	--- è�Ǿ� ����� �ѷ��ش�
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_ChampImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 327, 666)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 666)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+10, tRoomListPosY[i]+10)
	mywindow:setSize(89, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 15. �ͽ�Ʈ�� ��� ZEN
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_extremeZenText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, 11)
	mywindow:setSize(100, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--winMgr:getWindow(i .. "sj_lobby_roomList_ChampImage"):addChildWindow(mywindow)
	--[[
	-- 16. �ڵ� ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_autobalanceImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 570, 746)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 570, 746)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]-1, tRoomListPosY[i]-4)
	mywindow:setSize(52, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	--]]
	-- 16. �ڵ� ������ ����ġ �� 50%���� ǥ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_autobalanceImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 462, 771)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 462, 771)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]-1, tRoomListPosY[i]-7)
	mywindow:setSize(178, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 17. E�ʻ�� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_exceptEImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 998, 370)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 998, 370)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+166, tRoomListPosY[i]+41)
	mywindow:setSize(26, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 18. ģ��, ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_friendShipImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 419, 987)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 419, 987)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+178, tRoomListPosY[i]-7)
	mywindow:setSize(85, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--root:addChildWindow(mywindow)	
end


-- 8���� ���߿��� ���� ���� �������
function WndLobby_ClearBattleRoom()
	for i=0, MAX_ROOMPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setVisible(true)
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setEnabled(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setUserString("RoomNumber", 0)
		
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIndex"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomTitle"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isTeamBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isItemBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isMRBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomPassword"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomCurrentUserNum"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomRookieImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIsGamingImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_continueWinImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_ChampImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_autobalanceImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_exceptEImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_friendShipImage"):setVisible(false)
	end
end


--local ChampionshipTournamentCount  = {["err"]=0, [0]="TeamChampionshipAgreeList_LBtn", "TeamChampionshipAgreeList_RBtn"}


-- MAX_ROOMPAGE�� ���߿��� ���� �����Ǿ� �ִ°��
function WndLobby_ExistBattleRoom(index, roomNumber, roomName, bTeam, bItem, 
			currentUser, maxUser, password, roomState, roomKind, extremeZen, continueWin, autobalance, gameMode, exceptE, friendShip)

	-- 1. ���� ������ư
	if gameMode == 0 then
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_champ.tga", 0, 790)	-- ����
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/invisible.tga", 0, 0)			-- ������
		end
	elseif gameMode == 6 then
		winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_champ.tga", 621, 881)		-- ���� ���̽�
	elseif gameMode == 8 then
		winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_champ.tga", 665, 128)		-- �����
	end
	
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setEnabled(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setUserString("RoomNumber", roomNumber)
	
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomTitle"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setVisible(true)
	
	-- 2. ���ȣ
	local roomNum = GetStringSize(g_STRING_FONT_GULIMCHE, 14, tostring(roomNumber))
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setText(tostring(roomNumber))
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setPosition(82-roomNum/2, 10)

	-- 3. ����
	local roomSummaryName = SummaryString(g_STRING_FONT_GULIMCHE, 13, roomName, 170)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomTitle"):setText(roomSummaryName)
	
	
	-- ������϶�
	if roomState == 0 then
	
		-- 4. ������, ��������
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 354, 702)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 408, 702)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 311, 987)
		end	
		
		-- 5. ������, ����
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 516, 702)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 462, 702)
		end
		
		if gameMode == 0 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 354, 764)
		elseif gameMode == 6 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 462, 748)
		elseif gameMode == 8 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 408, 610)
		end
		
	-- �������϶�
	else
		
		-- 4. ������, ��������
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 354, 725)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 408, 725)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 311, 987)
		end
		
		-- 5. ������, ����
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 516, 725)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 462, 725)
		end
		
		
		if gameMode == 0 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 408, 764)
		elseif gameMode == 6 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 516, 748)
		elseif gameMode == 8 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 408, 633)
		end
	end
	
	
	
	-- 6. ��й�ȣ
	if string.len(password) == 0 then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 667, 206)
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 682, 206)
	end	
	
	-- 7. �����ο�
	if currentUser == maxUser then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setTextColor(255,0,0,255)
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setTextColor(255,255,255,255)
	end
	local userString = currentUser .. " / " .. maxUser
	winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setText(userString)
	
	
	-- 8. �����(�Ϲ�:0, ��Ű:1)
	if roomKind == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomRookieImage"):setVisible(true)
	end
	
	
	-- 9. ������
	if roomState == 0 then
		if currentUser == maxUser then
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(true)
			
			-- ���� ������ �Ǿ��ִµ� full�� �Ǹ� ���õȰ� ���
			if CEGUI.toRadioButton(winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn")):isSelected() then
				winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
			end
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 354, 664)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(false)
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 510, 664)
		end
		
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 432, 664)
		
		-- ���� ������ �Ǿ��ִµ� ������ ���۵Ǹ� ���õȰ� ���
		if CEGUI.toRadioButton(winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn")):isSelected() then
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
		end
	end
	
	-- 10. ���¹�
	if continueWin >= 2 then
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinText"):clearTextExtends()
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinText"):setTextExtends(continueWin, g_STRING_FONT_GULIMCHE, 13, 0,0,0,255,   0, 0,0,0,255)
		
	end
	
	
	
	if extremeZen > 0 then
		DebugStr('extremeZen:'..extremeZen)
		if extremeZen == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 561)
		elseif extremeZen == 2 then
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 561)
		elseif extremeZen == 4 then
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 582)
		elseif extremeZen == 8 then
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 624)
		elseif extremeZen == 16 then
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 603)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 666)
		end
		winMgr:getWindow(index .. "sj_lobby_roomList_ChampImage"):setVisible(true)
	end
	
	-- 12. �ڵ� ������
	if autobalance == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_autobalanceImage"):setVisible(true)
	end
	
	-- 13. E�ʻ�� ����
	if exceptE == 1 then
		if roomState == 0 then
			if currentUser == maxUser then
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_champ.tga", 998, 344)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 998, 344)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
			else
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_champ.tga", 998, 370)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 998, 370)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
			end
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_champ.tga", 998, 344)
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 998, 344)
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
		end
	end
	
	-- 14. ģ��, ����
	if friendShip == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_friendShipImage"):setVisible(true)
	end
end



-- ������ ����Ŭ�� �������(�ش� ������ ����)
function EnterBattleRoom(args)
	local roomNumber
	for i=0, MAX_ROOMPAGE-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn")):isSelected() then
			roomNumber = winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):getUserString("RoomNumber")
			WndLobby_EnterBattleRoom(tonumber(roomNumber), true)
			return
		end
	end
	
	ShowNotifyOKMessage_Lua(g_STRING_SELECTROOM)
end




--[[
--------------------------------------------------------------------

-- �游���, �����ϱ� ��ư

--------------------------------------------------------------------
tLobbyButtonName  = { ["protectErr"]=0, "sj_lobby_enterRoomBtn", "sj_lobby_makeRoomBtn" }
tLobbyButtonTexX  = { ["protectErr"]=0, 581, 697 }
tLobbyButtonPosX  = { ["protectErr"]=0, 30, 290 }
tLobbyButtonEvent = { ["protectErr"]=0, "EnterBattleRoom", "CreateBattleRoom" }

for i=1, #tLobbyButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLobbyButtonName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 512)
	mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 555)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 598)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 512)
	mywindow:setWideType(6);
	mywindow:setPosition(tLobbyButtonPosX[i], 460)
	mywindow:setSize(116, 42)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLobbyButtonEvent[i])
	mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
	mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
	root:addChildWindow(mywindow)
end
--]]

function CreateBattleRoom()
--[[
	-- �ͽ�Ʈ�� ����� ���
	if g_BattleMode == BATTLETYPE_NORMAL then
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(false)
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(false)
		
	--	winMgr:getWindow("sj_lobby_select_survival"):setEnabled(true)
		
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(true)
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(true)
		
	--	winMgr:getWindow("sj_lobby_select_survival"):setEnabled(false)
	end
	
	InitBattleRoomInfo()
	InitGameMode()
	InitTeamBattle()
	InitItemBattle()
	InitLadderType()
	InitUserNum()
	InitAutoBalance()
	--InitExceptE()
	
	local MAX_ROOM_NAME = #tRoomName
	winMgr:getWindow("sj_lobby_roomInfo_title"):setText(tRoomName[WndLobby_RandomRoomName(MAX_ROOM_NAME)])
	winMgr:getWindow("sj_lobby_roomInfo_password"):setText("")
	winMgr:getWindow("sj_lobby_makeroomAlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_makeroom_tempBackImage"):setVisible(true)
	
	-- �游��� â�� ������ ä��â�� ��Ȱ�� ��Ų��
	winMgr:getWindow("doChatting"):setEnabled(false)
--]]
end





--------------------------------------------------------------------

-- ���� ����, ���� ����(��� ��ư)

--------------------------------------------------------------------
local g_roomShowMode = 0
--[[
ttoggleButtonTexX = { ["protectErr"]=0, [0]=465, 349 }
togglewindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_showRoom_toggleBtn")
togglewindow:setTexture("Normal", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
togglewindow:setTexture("Hover", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 555)
togglewindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 598)
togglewindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
togglewindow:setWideType(6);
togglewindow:setPosition(160, 460)
togglewindow:setSize(116, 42)
togglewindow:setZOrderingEnabled(false)
togglewindow:subscribeEvent("Clicked", "ShowRoomMethodEvent")
togglewindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
togglewindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(togglewindow)
--]]
-- �⺻�� ���� ����
WndLobby_SetRoomMode(0)
g_roomShowMode = WndLobby_GetRoomMode()
function ShowRoomMethodEvent()
	if g_roomShowMode == 0 then
		g_roomShowMode = 1
	elseif g_roomShowMode == 1 then
		g_roomShowMode = 0
	end
	
	WndLobby_SetRoomMode(g_roomShowMode)
	
	togglewindow:setTexture("Normal", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
	togglewindow:setTexture("Hover", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 555)
	togglewindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 598)
	togglewindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
	
	-- ���� ���� ����
	for i=0, MAX_ROOMPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
	end
end



--------------------------------------------------------------------

-- �渮��Ʈ ���� ��, �� ��ư

--------------------------------------------------------------------

tRoomListLRButtonName  = { ["protecterr"]=0, "sj_lobby_roomlist_LBtn", "sj_lobby_roomlist_RBtn" }
tRoomListLRButtonTexX  = { ["protecterr"]=0, 987, 970}
tRoomListLRButtonPosX  = { ["protecterr"]=0, 267, 400 }
tRoomListLRButtonEvent = { ["protecterr"]=0, "ChagneRoomList_L", "ChagneRoomList_R" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tRoomListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 0)
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListLRButtonPosX[i], 470)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tRoomListLRButtonEvent[i])
	root:addChildWindow(mywindow)
end

-- �븮��Ʈ�� �������� �� �������� ������ �����ؾ� �Ѵ�.
function ChagneRoomList_L()
	local currRoomNum = WndLobby_GetCurrentRoomPage()
	if currRoomNum > 0 then
		currRoomNum = currRoomNum - 1
		WndLobby_ChangeCurrentRoomPage(tonumber(currRoomNum))
	end	
end


function ChagneRoomList_R()
	local currRoomNum = WndLobby_GetCurrentRoomPage()
	local maxRoomNum  = WndLobby_GetMaxRoomPage()
	if currRoomNum < maxRoomNum then
		currRoomNum = currRoomNum + 1
		WndLobby_ChangeCurrentRoomPage(tonumber(currRoomNum))
	end	
end




--------------------------------------------------------------------

-- �������� ��ư 4��(������(����, ��), ��������(����, ��))

--------------------------------------------------------------------
--[[
tQuickStartName  = { ["err"]=0, [0]="sj_lobby_fastStartBtn_Item(team)",   "sj_lobby_fastStartBtn_Item(pri)",  
									"sj_lobby_fastStartBtn_noItem(team)", "sj_lobby_fastStartBtn_noItem(pri)" }
tQuickStartTexX  = { ["err"]=0, [0]=746, 665, 746, 665 }
tQuickStartPosX  = { ["err"]=0, [0]=501, 585, 501, 585 }
tQuickStartPosY  = { ["err"]=0, [0]=528, 528, 605, 605 }
tQuickStartEvent = { ["err"]=0, [0]="JustGo_Item_Team", "JustGo_Item_Single", "JustGo_NoItem_Team", "JustGo_NoItem_Single" }

for i=0, 3 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tQuickStartName[i])
	mywindow:setTexture("Normal", "UIData/LobbyImage_champ.tga", tQuickStartTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", tQuickStartTexX[i], 67)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", tQuickStartTexX[i], 134)
	mywindow:setTexture("PushedOff", "UIData/LobbyImage_champ.tga", tQuickStartTexX[i], 0)
	mywindow:setPosition(tQuickStartPosX[i], tQuickStartPosY[i])
	mywindow:setSize(81, 67)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("quickButtonIndex", i)
	mywindow:subscribeEvent("Clicked", tQuickStartEvent[i])
	mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
	mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
	root:addChildWindow(mywindow)
end
--]]


--[[
-- ���� ��������
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_random")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 290, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 290, 71)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 290, 142)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 290, 0)
mywindow:setWideType(6);
mywindow:setPosition(712, 535)
mywindow:setSize(275, 71)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndLobby_JustGo_Random")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)

-- ���� ��������
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_adjust")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 565, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 565, 74)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 565, 148)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 565, 0)
mywindow:setWideType(6);
mywindow:setPosition(711, 611)
mywindow:setSize(200, 74)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickFitMatchButton")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)

-- �� ��ġ ������ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_adjustBox")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 765, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 765, 73)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 765, 146)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 765, 0)
mywindow:setWideType(6);
mywindow:setPosition(915, 611)
mywindow:setSize(73, 73)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CallQuckMatchAdjustBox")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)
--]]


-- è�ǿ½� ��ȸ����
mywindow = winMgr:createWindow("TaharezLook/Button", "Champ_lobby_JoinBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_champ.tga", 777, 418)
mywindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", 777, 485)
mywindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", 777, 552)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_champ.tga", 777, 418)
mywindow:setWideType(6);
mywindow:setPosition(727, 600)
mywindow:setSize(247, 67)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "RequestChampionshipFindRoom")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ����ǥ ����Ʈ ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_ShowTeamChampionsipListBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_champ.tga", 327, 397)
mywindow:setTexture("Hover", "UIData/LobbyImage_champ.tga",  327, 438)
mywindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", 327, 479)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_champ.tga", 327, 397)
mywindow:setWideType(6);
mywindow:setPosition(502, 454)
mywindow:setSize(156, 41)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickTeamChampionshipMathchList")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)

function CallQuckMatchAdjustBox()
	winMgr:getWindow("sj_lobby_quickmatchAlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_quickmatch_tempBackImage"):setVisible(true)
end

-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_quickmatchAlphaWindow")
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

-- ����ġ ����â ESCŰ, ENTERŰ ���
RegistEscEventInfo("sj_lobby_quickmatchAlphaWindow", "QuickMatchAdjust_OK")
RegistEnterEventInfo("sj_lobby_quickmatchAlphaWindow", "QuickMatchAdjust_OK")

quickmatchBackwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_quickmatch_tempBackImage")
quickmatchBackwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 284)
quickmatchBackwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 284)
quickmatchBackwindow:setProperty("FrameEnabled", "False")
quickmatchBackwindow:setProperty("BackgroundEnabled", "False")
quickmatchBackwindow:setWideType(6);
quickmatchBackwindow:setPosition(254, 241)
quickmatchBackwindow:setSize(515, 236)
quickmatchBackwindow:setVisible(false)
quickmatchBackwindow:setAlwaysOnTop(true)
quickmatchBackwindow:setZOrderingEnabled(false)
root:addChildWindow(quickmatchBackwindow)


local NOT_CHECK = 0
local SELECTED = 1

-- Match üũ�ڽ�
local MATCH_DEATHMATCH = 1
local MATCH_MONSTERRACING = 1
local MATCH_DUALMATCH = 1
local tMatchName  = {['err'] = 0, [0]= "sj_lobby_checkbox_deathmatch", "sj_lobby_checkbox_monsterracing", "sj_lobby_checkbox_dualMatch"}
local tMatchPosX  = {['err'] = 0, [0]= 109, 206, 303 }
local tMatchEvent = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck"}
for i=0, #tMatchName do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tMatchName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tMatchPosX[i], 72)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tMatchEvent[i])
	quickmatchBackwindow:addChildWindow(mywindow)
	
	-- �ѱ��� ���� ���� ���̽��� �������� ��
	if IsKoreanLanguage() then
		if i == 1 then
			mywindow:setVisible(false)
			MATCH_MONSTERRACING = 0
		elseif i == 2 then
			--mywindow:setVisible(false)
			--MATCH_DUALMATCH = 0
			mywindow:setPosition(tMatchPosX[1], 72)
		end
	end
end

function DeathMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_DEATHMATCH = SELECTED
	else
		MATCH_DEATHMATCH = NOT_CHECK
	end
end

function MonsterRacingCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_MONSTERRACING = SELECTED
		if IsKoreanLanguage() then
			MATCH_MONSTERRACING = NOT_CHECK
		end
	else
		MATCH_MONSTERRACING = NOT_CHECK
	end
end

function DualMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_DUALMATCH = SELECTED
	else
		MATCH_DUALMATCH = NOT_CHECK
	end
end


-- Mode üũ�ڽ�
local MODE_PRIVATE = SELECTED
local MODE_TEAM = SELECTED
local tModeName  = {['err'] = 0, [0]= "sj_lobby_checkbox_privateMode", "sj_lobby_checkbox_teamMode"}
local tModePosX  = {['err'] = 0, [0]= 109, 206 }
local tModeEvent = {['err'] = 0, [0]= "PrivateModeCheck", "TeamModeCheck"}
for i=0, #tModeName do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tModeName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tModePosX[i], 110)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tModeEvent[i])
	quickmatchBackwindow:addChildWindow(mywindow)
end

function PrivateModeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MODE_PRIVATE = SELECTED
	else
		MODE_PRIVATE = NOT_CHECK
	end
end

function TeamModeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MODE_TEAM = SELECTED
	else
		MODE_TEAM = NOT_CHECK
	end
end


-- Type üũ�ڽ�
local TYPE_NOITEM = SELECTED
local TYPE_ITEM = SELECTED
local TYPE_CLASS = SELECTED
local tTypeName  = {['err'] = 0, [0]= "sj_lobby_checkbox_NoItemType", "sj_lobby_checkbox_ItemType", "sj_lobby_checkbox_ClassType"}
local tTypePosX  = {['err'] = 0, [0]= 109, 206, 303 }
local tTypeEvent = {['err'] = 0, [0]= "NoItemTypeCheck", "ItemTypeCheck", "ClassTypeCheck"}
for i=0, #tTypeName do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tTypeName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tTypePosX[i], 148)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tTypeEvent[i])
	quickmatchBackwindow:addChildWindow(mywindow)
	
	if IsKoreanLanguage() then
		if i == 0 then
			mywindow:setVisible(false)
			TYPE_NOITEM = NOT_CHECK
		elseif i == 1 then
			mywindow:setPosition(109, 148)
		elseif i == 2 then
			mywindow:setVisible(false)
			TYPE_CLASS = NOT_CHECK
		end
	end
end

function NoItemTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_NOITEM = SELECTED
	else
		TYPE_NOITEM = NOT_CHECK
	end
end

function ItemTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_ITEM = SELECTED
	else
		TYPE_ITEM = NOT_CHECK
	end
end

function ClassTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_CLASS = SELECTED
		if IsKoreanLanguage() then
			TYPE_CLASS = NOT_CHECK
		end
	else
		TYPE_CLASS = NOT_CHECK
	end
end


-- ���� Ȯ�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_quickmatch_okBtn")
mywindow:setTexture("Normal", "UIData/Profile001.tga",813, 324)
mywindow:setTexture("Hover", "UIData/Profile001.tga", 813, 351)
mywindow:setTexture("Pushed", "UIData/Profile001.tga", 813, 378)
mywindow:setTexture("PushedOff", "UIData/Profile001.tga", 813, 324)
mywindow:setPosition(420, 196)
mywindow:setSize(81, 27)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "QuickMatchAdjust_OK")
quickmatchBackwindow:addChildWindow(mywindow)

function QuickMatchAdjust_OK()
	winMgr:getWindow("sj_lobby_quickmatchAlphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_quickmatch_tempBackImage"):setVisible(false)
	
	WndLobby_FileSaveFixMatch( MATCH_DEATHMATCH, MATCH_MONSTERRACING, MATCH_DUALMATCH,
								MODE_PRIVATE, MODE_TEAM,
								TYPE_NOITEM, TYPE_ITEM, TYPE_CLASS )
end

function ClickFitMatchButton()
	WndLobby_JustGo_Adjust( MATCH_DEATHMATCH, MATCH_MONSTERRACING, MATCH_DUALMATCH,
							MODE_PRIVATE, MODE_TEAM,
							TYPE_NOITEM, TYPE_ITEM, TYPE_CLASS )
end


-- �ʱ⼳��
function SetFitMatchInfo( _MATCH_DEATHMATCH, _MATCH_MONSTERRACING, _MATCH_DUALMATCH,
						  _MODE_PRIVATE, _MODE_TEAM,
						  _TYPE_NOITEM, _TYPE_ITEM, _TYPE_CLASS )
						  
	MATCH_DEATHMATCH	= _MATCH_DEATHMATCH
	MATCH_MONSTERRACING	= _MATCH_MONSTERRACING
	MATCH_DUALMATCH		= _MATCH_DUALMATCH
	MODE_PRIVATE		= _MODE_PRIVATE
	MODE_TEAM			= _MODE_TEAM
	TYPE_NOITEM			= _TYPE_NOITEM
	TYPE_ITEM			= _TYPE_ITEM
	TYPE_CLASS			= _TYPE_CLASS
	
	-- MATCH
	if MATCH_DEATHMATCH == 1 then
		winMgr:getWindow("sj_lobby_checkbox_deathmatch"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_deathmatch"):setProperty("Selected", "false")
	end
	
	if MATCH_MONSTERRACING == 1 then
		winMgr:getWindow("sj_lobby_checkbox_monsterracing"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_monsterracing"):setProperty("Selected", "false")
	end
	
	if MATCH_DUALMATCH == 1 then
		winMgr:getWindow("sj_lobby_checkbox_dualMatch"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_dualMatch"):setProperty("Selected", "false")
	end
	
	-- MODE
	if MODE_PRIVATE == 1 then
		winMgr:getWindow("sj_lobby_checkbox_privateMode"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_privateMode"):setProperty("Selected", "false")
	end
	
	if MODE_TEAM == 1 then
		winMgr:getWindow("sj_lobby_checkbox_teamMode"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_teamMode"):setProperty("Selected", "false")
	end
	
	-- TYPE
	if TYPE_NOITEM == 1 then
		winMgr:getWindow("sj_lobby_checkbox_NoItemType"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_NoItemType"):setProperty("Selected", "false")
	end
	
	if TYPE_ITEM == 1 then
		winMgr:getWindow("sj_lobby_checkbox_ItemType"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_ItemType"):setProperty("Selected", "false")
	end
	
	if TYPE_CLASS == 1 then
		winMgr:getWindow("sj_lobby_checkbox_ClassType"):setProperty("Selected", "true")
	else
		winMgr:getWindow("sj_lobby_checkbox_ClassType"):setProperty("Selected", "false")
	end
	
end




--------------------------------------------------------------------

-- ���� ����Ʈ(MAX_USERPAGE)

--------------------------------------------------------------------
for i=0, MAX_USERPAGE-1 do
	-- 1. ���� ����Ʈ(���� ��ư) ����
	userwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_lobby_userlist_radioBtn")
	userwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", 312, 937)
	userwindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", 312, 962)
	userwindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedNormal", "UIData/LobbyImage_champ.tga", 312, 962)
	userwindow:setTexture("SelectedHover", "UIData/LobbyImage_champ.tga", 312, 962)
	userwindow:setTexture("SelectedPushed", "UIData/LobbyImage_champ.tga", 312, 962)
	userwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_champ.tga", 312, 962)
	userwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedEnabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedDisabled", "UIData/invisible.tga", 0, 0)
	userwindow:setWideType(6);
	userwindow:setPosition(USERINFO_POSX+7, USERINFO_POSY+62+(i*31))
	userwindow:setSize(308, 23)
	userwindow:setProperty("GroupID", 700)
	userwindow:setZOrderingEnabled(false)
	userwindow:setVisible(true)
	userwindow:setRButtonEnabled(true)
	userwindow:setUserString("UserName", "")
	userwindow:subscribeEvent("MouseDoubleClicked", "UserDoubleClicked")
	userwindow:setSubscribeEvent("MouseRButtonUp", "WndLobby_OnRootMouseRButtonUp")
	userwindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
	userwindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
	root:addChildWindow(userwindow)
	
	-- 2. ���� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("9")
	mywindow:setPosition(12, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)	-- �����ص� �ٸ��͵��� ���õǰ�
	userwindow:addChildWindow(mywindow)

	-- 3. ���� �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(116, 3)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 4. ���� ��Ÿ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userlist_style")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(250, -1)
	mywindow:setSize(89, 35)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	userwindow:addChildWindow(mywindow)
	
	-- 5. ���� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userlist_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(62, 1)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 6. ���� Ŭ��
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_club")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(14, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 7. Ŭ�� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_lobby_clubEmbleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(4, 3)
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setScaleWidth(140)
	mywindow:setScaleHeight(140)
	userwindow:addChildWindow(mywindow)
	
end

function NoFunctionA()
end


-- ������ ������
function WndLobby_ClearUserList()
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_level"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_name"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_style"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_ladder"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_club"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_clubEmbleImage"):setVisible(false)
	end
end


-- ������ ������
function WndLobby_ExistUser(index, level, ladder, style, userName, userClub , Emblemkey, promotion, attribute)
	winMgr:getWindow(index .. "sj_lobby_userlist_radioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_radioBtn"):setUserString("UserName", tostring(userName))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_ladder"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_club"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(true)
	-- 2. ���� ����
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setText(tostring(level))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setPosition(46-levelSize/2, 3)
	
	-- 3. ���� �̸�
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, userName)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setText(userName)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setPosition(184-nameSize/2, 3)
	
	-- 4. ���� ��Ÿ��
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setScaleWidth(190)
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setScaleHeight(190)
	
	-- 5. ���� ����
	winMgr:getWindow(index .. "sj_lobby_userlist_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- 6. ���� Ŭ��
	if userClub == "" then
		winMgr:getWindow(index .. "sj_lobby_userlist_club"):setText("-")
	else
	
	end
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setScaleWidth(140)
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setScaleHeight(140)
	--DebugStr('Emblemkey:'..Emblemkey)

	if Emblemkey > 0 then
		--DebugStr('Emblemkey�� 0���� ũ��')
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..Emblemkey..".tga", 0, 0)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..Emblemkey..".tga", 0, 0)	
	else
		--DebugStr('Emblemkey�� 0�̴�')
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(false)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	
end


function UserDoubleClicked(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local name = local_window:getUserString("UserName")
		if name ~= nil and name ~= "" then
			WndLobby_SetPrivateChat(name)
		end
	end
end




--------------------------------------------------------------------

-- ���� ����(ä��, ģ��, Ŭ��) ���� ��ư

--------------------------------------------------------------------
--[[
tUserInfoName = { ["protectErr"]=0, [0]="sj_lobby_channel", "sj_lobby_friend", "sj_lobby_club" }
tUserInfoTexX = { ["protectErr"]=0, [0]=667, 763, 859 }
tUserInfoPosX = { ["protectErr"]=0, [0]=USERINFO_POSX, USERINFO_POSX+96, USERINFO_POSX+192 }

for i=0, 2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tUserInfoName[i])
	mywindow:setTexture("Normal", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("Hover", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 311)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("PushedOff", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_champ.tga", tUserInfoTexX[i], 278)	
	mywindow:setPosition(tUserInfoPosX[i], USERINFO_POSY)
	mywindow:setSize(96, 33)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1602)
	mywindow:setUserString("userInfoList", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangeUserInfoList")
	
	if i == 0 then
		mywindow:setEnabled(true)
	else
		mywindow:setEnabled(false)
	end
	root:addChildWindow(mywindow)
end


function ChangeUserInfoList()
	local userList
	for i=0, 2 do
		if CEGUI.toRadioButton(winMgr:getWindow(tUserInfoName[i])):isSelected() then
			userList = winMgr:getWindow(tUserInfoName[i]):getUserString("userInfoList")
		end
	end
	WndLobby_ChangeUserInfoList(tonumber(userList))
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn"):setProperty("Selected", "false")
	end
end


function SelectCurrentUserInfoList()
	local userList = WndLobby_GetUserInfoList()
	winMgr:getWindow(tUserInfoName[userList]):setProperty("Selected", "true")
end
SelectCurrentUserInfoList()
--]]



--------------------------------------------------------------------

-- ���� ����Ʈ ���� ��, �� ��ư

--------------------------------------------------------------------

tUserListLRButtonName  = { ["protecterr"]=0, "sj_lobby_userlist_LBtn", "sj_lobby_userlist_RBtn" }
tUserListLRButtonTexX  = { ["protecterr"]=0, 987, 970}
tUserListLRButtonPosX  = { ["protecterr"]=0, USERINFO_POSX+87, USERINFO_POSX+219 }
tUserListLRButtonEvent = { ["protecterr"]=0, "ChagneUserList_L", "ChagneUserList_R" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tUserListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setWideType(6);
	mywindow:setPosition(tUserListLRButtonPosX[i], 470)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tUserListLRButtonEvent[i])
	root:addChildWindow(mywindow)
end

-- �븮��Ʈ�� �������� �� �������� ������ �����ؾ� �Ѵ�.
function ChagneUserList_L()
	local currUserNum = WndLobby_GetCurrentUserPage()
	if currUserNum > 0 then
		currUserNum = currUserNum - 1
		WndLobby_GetLobbyUserList(tonumber(currUserNum))
	end	
end


function ChagneUserList_R()
	local currUserNum = WndLobby_GetCurrentUserPage()
	local maxUserNum  = WndLobby_GetMaxUserPage()
	if currUserNum < maxUserNum then
		currUserNum = currUserNum + 1
		WndLobby_GetLobbyUserList(tonumber(currUserNum))
	end	
end


--------------------------------------------------------------------

-- ��Ʋ�� ��й�ȣ Ȯ��â

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_forPassword_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


pwwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_forPassword_showWindow")
pwwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
pwwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
pwwindow:setProperty("FrameEnabled", "False")
pwwindow:setProperty("BackgroundEnabled", "False")
pwwindow:setWideType(6);
pwwindow:setPosition(338, 246)
pwwindow:setSize(346, 275)
pwwindow:setVisible(false)
pwwindow:setAlwaysOnTop(true)
pwwindow:setZOrderingEnabled(false)
root:addChildWindow(pwwindow)


-- ��й�ȣ ����â ESCŰ, ENTERŰ ���
RegistEscEventInfo("sj_lobby_forPassword_showWindow", "Password_CANCEL")


mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_lobby_forPassword_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText(g_STRING_INPUT_PASSWORD)
mywindow:setPosition(60, 106)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
pwwindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_forPassword_editbox")
mywindow:setText("")
mywindow:setPosition(82, 134)
mywindow:setSize(174, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "Password_OK")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(4)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnPasswordFull")
pwwindow:addChildWindow(mywindow)


function OnPasswordFull(args)
	PlayWave('sound/FullEdit.wav')
end


tPasswordName  = { ["protecterr"]=0, "sj_lobby_forPassword_okBtn", "sj_lobby_forPassword_cancelBtn" }
tPasswordTexX  = { ["protecterr"]=0, 693, 858}
tPasswordPosX  = { ["protecterr"]=0, 4, 169 }
tPasswordEvent = { ["protecterr"]=0, "Password_OK", "Password_CANCEL" }

for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPasswordName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tPasswordTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tPasswordTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tPasswordTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tPasswordTexX[i], 849)	
	mywindow:setPosition(tPasswordPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tPasswordEvent[i])
	pwwindow:addChildWindow(mywindow)
end



function Password_OK()
	local roomIndex  = winMgr:getWindow("sj_lobby_forPassword_showWindow"):getUserString("roomIndex")
	local password   = winMgr:getWindow("sj_lobby_forPassword_editbox"):getText()
	WndLobby_EnterPasswordBattleRoom(tonumber(roomIndex), password)
	
	Password_CANCEL()
end



function Password_CANCEL()
	winMgr:getWindow("sj_lobby_forPassword_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_forPassword_editbox"):setText("")
end



function WndLobby_NotifyPassword(roomIndex)
	winMgr:getWindow("sj_lobby_forPassword_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setVisible(true)
	
	local size = GetStringSize(g_STRING_FONT_DODUM, 115, g_STRING_INPUT_PASSWORD)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setPosition(170-size/2, 106)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):clearTextExtends()
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setViewTextMode(1)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setAlign(1)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setLineSpacing(5)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):addTextExtends(g_STRING_INPUT_PASSWORD, g_STRING_FONT_DODUM, 115, 255,255,255,255, 1, 0,0,0,255)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setUserString("roomIndex", roomIndex)
	winMgr:getWindow("sj_lobby_forPassword_editbox"):activate()
end



function WndLobby_OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


function WndLobby_OnRootMouseRButtonUp(args)

	if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
		return
	end
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	
	-- �����϶��� üũ ���ش�.	
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
	
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			local name
			for i=0, MAX_USERPAGE-1 do
				if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn")):isSelected() then
					name = winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn"):getUserString("UserName")
					
					-- ���ϰ�� �������� ����.
					local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
					if name == _my_name then
						local m_pos = mouseCursor:getPosition()
						ShowPopupWindow(m_pos.x, m_pos.y, 1)
						g_strSelectRButtonUp = name
						winMgr:getWindow('pu_myInfo'):setProperty('Disabled', 'False')
						MakeMessengerPopup("pu_windowName", "pu_myInfo" ,"pu_profile")
						
					-- �ٸ���� �� ���
					else
						local m_pos = mouseCursor:getPosition();
						ShowPopupWindow(m_pos.x, m_pos.y, 1);
						g_strSelectRButtonUp = name;
						
						local isMyMessengerFriend = IsMyMessengerFriend(name);
						winMgr:getWindow('pu_showInfo'):setEnabled(true)
						
						-- ���� �� ģ�� ��� ����Ʈ�� �ִ��� Ȯ���Ѵ�.
						-- �� ģ�� ��� ����Ʈ�� ������
						if isMyMessengerFriend == true then
							winMgr:getWindow('pu_addFriend'):setEnabled(false)	-- ��Ȱ��
							winMgr:getWindow('pu_deleteFriend'):setEnabled(true)	-- Ȱ��
							
						else -- ��ģ�� ��ϸ���Ʈ�� ������
							winMgr:getWindow('pu_addFriend'):setEnabled(true)	-- Ȱ��
							winMgr:getWindow('pu_deleteFriend'):setEnabled(false)	-- ��Ȱ��
						end
						
						-- �ӼӸ��� �ظ��ϸ� �ű��ϴµ�..
						winMgr:getWindow('pu_privatChat'):setEnabled(true)
						
						-- ��Ƽ �ʴ�� ��밡 ��Ƽ�� ���� �ִ��� ������ Ȯ���ؾ� �Ѵ�.
						winMgr:getWindow('pu_inviteParty'):setEnabled(false)
						winMgr:getWindow('pu_vanishParty'):setEnabled(false)	-- ��Ȱ��
						
						
						MakeMessengerPopup("pu_windowName", "pu_showInfo","pu_profile",  "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty");	-- �Ű��ϱ� ��� ����
					end
					return
				end
			end
		end
	end
	
end
root:setSubscribeEvent("MouseButtonUp", "WndLobby_OnRootMouseButtonUp");





-- �κ񿡼��� ���̴� ���� ���� ����
function OnMsgJobChanged(jobType)
	OnChatPublic(STRING_SUCCESS_CHANGECLASS, 4);
end


-- ���콺 ������
function BattleRoomMouseEnter(args)
	PlayWave('sound/listmenu_click.wav')
end

-- ���콺 Ŭ����.
function BattleRoomMouseClick()
	PlayWave("sound/button_click.wav");
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end




---------------------------------------------------------------

--	��Ű�� ����

---------------------------------------------------------------
local g_selectRoomIndex = 0

--------------------------------------------------------------------

-- �˸��޼���

--------------------------------------------------------------------
-- ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_alphaWindow")
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

---------------------------------------------
--- OK, CANCEL �˸�â
---------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_backWindow")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_lobby_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setSize(340, 180)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(3, 45)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(1)
winMgr:getWindow("sj_lobby_backWindow"):addChildWindow(mywindow)

-- OK, CANCEL ��ư
local tAlertName = {['protecterr'] = 0, "sj_lobby_okBtn", "sj_lobby_CancelBtn"}
local tAlertTexX = {['protecterr'] = 0, 693, 858}
local tAlertPosX = {['protecterr'] = 0, 4, 169}
local tAlertPosY = {['protecterr'] = 0, 235, 235}
for i=1, #tAlertName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAlertName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tAlertTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tAlertTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setSize(166, 29)
	mywindow:setPosition(tAlertPosX[i], tAlertPosY[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_lobby_backWindow"):addChildWindow(mywindow)
end


function WndLobby_CheckRoomEnter(roomIndex, msg)
	g_selectRoomIndex = roomIndex	
	ShowLobbyOkCancelBoxFunction('', msg, 'OnClickCheckRoomEnterOk', 'OnClickCheckRoomEnterCancel')
end

-----------------------------------
-- OK, CANCE ��ư 2���ִ� �Լ�
-----------------------------------
function ShowLobbyOkCancelBoxFunction(specialArg, arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_lobby_alphaWindow') then
		local aa= winMgr:getWindow("sj_lobby_alphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_lobby_alphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_lobby_alphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_lobby_alphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_lobby_alphaWindow"))
		local local_window = winMgr:getWindow("sj_lobby_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_lobby_alphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_lobby_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg, g_STRING_FONT_GULIMCHE, 15, 255,205,86,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_lobby_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_lobby_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- ����
function OnClickCheckRoomEnterOk(args)

	if winMgr:getWindow('sj_lobby_backWindow') then
		local okfunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickCheckRoomEnterOk" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		WndLobby_EnterBattleRoom(g_selectRoomIndex, false)
	end
end


-- ����
function OnClickCheckRoomEnterCancel(args)
	
	if winMgr:getWindow('sj_lobby_backWindow') then
		local nofunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickCheckRoomEnterCancel" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("sj_lobby_alphaWindow", "OnClickCheckRoomEnterOk")
RegistEscEventInfo("sj_lobby_alphaWindow", "OnClickCheckRoomEnterCancel")



-----------------------------------------
-- ��ȿ� �ִ� ĳ���� ����
-----------------------------------------
inroomwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_userInfo_inRoom_backImage")
inroomwindow:setTexture("Enabled", "UIData/popup001.tga", 688, 116)
inroomwindow:setTexture("Disabled", "UIData/popup001.tga", 688, 116)
inroomwindow:setProperty("FrameEnabled", "False")
inroomwindow:setProperty("BackgroundEnabled", "False")
inroomwindow:setWideType(6);
inroomwindow:setPosition(0, 0)
inroomwindow:setSize(294, 204)
inroomwindow:setZOrderingEnabled(false)
inroomwindow:setEnabled(false)
inroomwindow:setVisible(false)
inroomwindow:setAlwaysOnTop(true)
root:addChildWindow(inroomwindow)

for i=0, MAX_USERNUM_IN_ROOM-1 do

	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userInfo_inRoom_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(13, (i*22)+30)
	mywindow:setSize(20, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	inroomwindow:addChildWindow(mywindow)	
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userInfo_inRoom_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(42, (i*22)+26)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	inroomwindow:addChildWindow(mywindow)

	-- �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userInfo_inRoom_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(120, (i*22)+30)
	mywindow:setSize(100, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	inroomwindow:addChildWindow(mywindow)
	
	-- Ŭ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userInfo_inRoom_style")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(230, (i*22)+21)
	mywindow:setSize(87, 35)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	inroomwindow:addChildWindow(mywindow)
	
end

function OnMouseEnter_UserInfo_inRoom(args)
	local window = CEGUI.toWindowEventArgs(args).window	
	g_currentRoomNumber = tonumber(window:getUserString("RoomNumber"))
	g_currentRoomIndex = tonumber(window:getUserString("RoomIndex"))
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	GetUserInfoInRoom(g_currentRoomNumber, g_currentRoomIndex)
end

function OnMouseLeave_UserInfo_inRoom(args)
	g_currentRoomNumber = -1
	g_currentRoomIndex = -1
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(false)
end

function WndLobby_ShowUserInfoInRoom(roomIndex)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(true)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setPosition(tRoomListReversPosX[roomIndex], tRoomListPosY[roomIndex]-3)
end

function WndLobby_ClosedUserInfoInRoom()
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(false)
end

function WndLobby_InitUserInfoInRoom()
	for i=0, MAX_USERNUM_IN_ROOM-1 do
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_level"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_ladder"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_name"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_style"):setVisible(false)
	end
end


function WndLobby_SetUserInfoInRoom(index, level, ladder, name, style, promotion, attribute)

	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_ladder"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setVisible(true)
	
	-- ����
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))	
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setPosition(21-levelSize/2, (index*22)+30)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):clearTextExtends()
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setTextExtends(tostring(level), g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 0, 0,0,0,255)
		
	-- ����
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- �̸�
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)	
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setPosition(158-nameSize/2, (index*22)+30)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):clearTextExtends()
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setTextExtends(name, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 0, 0,0,0,255)
	
	-- Ŭ����
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setScaleWidth(190)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setScaleHeight(190)
end


function WndLobby_RequestUserInfoInRoom(roomIndex)	
	local window = winMgr:getWindow(roomIndex.."sj_lobby_roomList_radioBtn")
	g_currentRoomNumber = tonumber(window:getUserString("RoomNumber"))
	g_currentRoomIndex = tonumber(window:getUserString("RoomIndex"))
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	GetUserInfoInRoom(g_currentRoomNumber, g_currentRoomIndex)
end


-----------------------------------------

-- �ų�����Ʈ �˸� �޼���

-----------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_notify_alphaWindow")
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

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_notify_mannerPoint")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 515, 311)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 515, 311)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(5)
mywindow:setPosition(342, 314)
mywindow:setSize(340, 141)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
winMgr:getWindow("sj_lobby_notify_alphaWindow"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_notify_mannerPoint_okBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(125, 100)
mywindow:setSize(90, 27)
mywindow:subscribeEvent("Clicked", "ClickedNotifyMannerPointOK")
winMgr:getWindow("sj_lobby_notify_mannerPoint"):addChildWindow(mywindow)

function WndLobby_ShowNotifyMannerPoint()
	winMgr:getWindow("sj_lobby_notify_alphaWindow"):setVisible(true)
end

function ClickedNotifyMannerPointOK(args)
	winMgr:getWindow("sj_lobby_notify_alphaWindow"):setVisible(false)
end

RegistEscEventInfo("sj_lobby_notify_alphaWindow", "ClickedNotifyMannerPointOK")
RegistEnterEventInfo("sj_lobby_notify_alphaWindow", "ClickedNotifyMannerPointOK")
--winMgr:getWindow("doChatting"):deactivate()


