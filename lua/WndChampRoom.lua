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

local g_MAPNAME_MR1	= PreCreateString_2374	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP1)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_MR2	= PreCreateString_2375	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP2)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_MR3	= PreCreateString_2376	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP3)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_R	= PreCreateString_2081	--GetSStringInfo(LAN_LUA_BATTLEROOM_RANDOMMAP)	-- ����
local g_MAPNAME_1	= PreCreateString_1673	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP1)		-- �� ��Ʈ��Ʈ ��Ʈ (��)
local g_MAPNAME_2	= PreCreateString_1675	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP2)		-- ��� ��ġ (��)
local g_MAPNAME_3	= PreCreateString_1678	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP4)		-- ��ũ �ߵ� (��)
local g_MAPNAME_4	= PreCreateString_1677	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP3)		-- ������Ʈ ��ũ (��)
local g_MAPNAME_5	= PreCreateString_1679	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP5)		-- ������ ��Ÿ�� (��)
local g_MAPNAME_6	= PreCreateString_1680	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP6)		-- ����Ʈ ��Ʈ��Ʈ (��)
local g_MAPNAME_7	= PreCreateString_1901	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP8)		-- ��ī�� ����� (��)
local g_MAPNAME_8	= PreCreateString_1681	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP7)		-- ����ö (��)
local g_MAPNAME_9	= PreCreateString_2173	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP9)		-- �Ʒ��� �� (��)
local g_MAPNAME_10	= PreCreateString_2524	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP10)		-- �踮�� ���丮 (��)
local g_MAPNAME_11	= PreCreateString_2748	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP11)		-- ����â�� (��)

local g_MAPNAME_DUAL= PreCreateString_3447	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP12)		-- ����ġ ��


local g_STRING_WARNING_CHANGEMAP	= PreCreateString_1128	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_1)	-- �ʺ����� ���常 �Ҽ� �ֽ��ϴ�.
local g_STRING_WARNING_ADJUSTROOM	= PreCreateString_1129	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_2)	-- �漳���� ���常 �Ҽ� �ֽ��ϴ�.
local g_STRING_WARNING_1			= PreCreateString_1130	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_3)	-- �غ� Ǯ��� ������ �� �ֽ��ϴ�.
local g_STRING_PREPARING			= PreCreateString_1273	--GetSStringInfo(LAN_LUA_WND_POPUP_2)		-- �غ����Դϴ�.
local g_STRING_CANNOT_ROOMSETTING   = PreCreateString_2291	--GetSStringInfo(LAN_LUA_CANNOT_ROOMSETTING)
local g_STRING_ABUSING_SECRETROOM_DESCRIPTION = PreCreateString_3384	--GetSStringInfo(ABUSING_SECRETROOM_DESCRIPTION)
local g_SelectedBattleTab = 4
local g_currentTeamBattle = WndBattleRoom_IsTeamBattle()
local g_currentClubBattle = WndBattleRoom_IsClubBattle()

local PLAYTYPE_NOITEM = 0
local PLAYTYPE_ITEM = 1
local PLAYTYPE_CLASS = 2

local tTeamMark = { ["protecterr"]=0, [4]=169, [6]=189, [8]=209 }
local tPrivateMark = { ["protecterr"]=0, 0, 229, 249, 269, 289, 309, 329, 349 }

g_ROOM_WIN_SIZEX, g_ROOM_WIN_SIZEY = GetCurrentResolution()




--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setVisible(true)
winMgr:getWindow('ChannelPositionBG'):setWideType(6);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(false)
winMgr:getWindow('NewMoveExitBtn'):setVisible(true)
--ChangeChannelPosition('Battle room')

userInfoBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "userinfoInvisibleback")
userInfoBackWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 828)
userInfoBackWindow:setTexture("Disabled", "UIData/invisible.tga", 0, 828)
userInfoBackWindow:setProperty("FrameEnabled", "False")
userInfoBackWindow:setProperty("BackgroundEnabled", "False")
userInfoBackWindow:setWideType(6);
userInfoBackWindow:setPosition(0, 0)
userInfoBackWindow:setSize(1024, 768)
userInfoBackWindow:setZOrderingEnabled(false)
userInfoBackWindow:setEnabled(true)
userInfoBackWindow:setVisible(true)
root:addChildWindow(userInfoBackWindow)

--------------------------------------------------------------------
-- ä�� Ÿ��Ʋ �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampTitleMoveBar")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 764, 686)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 764, 686)
mywindow:setPosition(750, 10)
mywindow:setSize(260, 34)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("TitleMotion", "TitleMotion", "x", "Linear_EaseNone", 750, 20, 30, true, true, 5)
userInfoBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ä�� Ÿ��Ʋ �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampTitleMoveBar2")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 764, 686)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 764, 686)
mywindow:setPosition(750, 10)
mywindow:setSize(260, 34)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("TitleMotion2", "TitleMotion2", "x", "Linear_EaseNone", 750, 20, 30, true, true, 5)
userInfoBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ��� ����ũ �̹��� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampTitleMaskImgLeft")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 699, 720)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 699, 720)
mywindow:setPosition(2, 0)
mywindow:setSize(325, 75)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
userInfoBackWindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ��� ����ũ �̹��� ������
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampTitleMaskImgRight")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 699, 795)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 699, 795)
mywindow:setPosition(697, 0)
mywindow:setSize(325, 75)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
userInfoBackWindow:addChildWindow(mywindow)

local stamina = require("StaminaSystem")

-- �ʱ� ä��â ����
function SetChatInitChampRoom()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()

	stamina.SetLocalPosition(440,-157) -- from calculation
end


--------------------------------------------------------------------

-- drawTexture(StartRender:���۽ÿ� �׸���)

--------------------------------------------------------------------
function WndBattleRoom_BackImage(myLevel, EVENT_EX_LEVEL, currentBattleChannelName, extremeZen, 
				continueWinTeam, continueWinCount, autoBalance, bTeam, maxUser, exceptE, roomPassword, gameMode, currentLadderChannelType)
	
	--drawer:drawTexture("UIData/ChampionshipRoom.tga", 0, 0, 1024, 768, 0, 0, WIDETYPE_6) -- è�ǿ½� ���
	
	-- ����ä�� �̸�
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	--[[
	-- ���� ä���� �����(0:�Ϲ�, 1:�ͽ���Ʈ ä��)
	if currentLadderChannelType == 1 then
		drawer:drawTexture("UIData/match003.tga", 320, 33, 54, 34, 265, 200, WIDETYPE_6)
	end
	--]]
	-- ���� ������
	--[[
	drawer:drawTexture("UIData/match003.tga", 430, 68, 164, 31, 0, 656, WIDETYPE_6)
	if bTeam == 1 then
		if maxUser == 4 or maxUser == 6 or maxUser == 8 then
			drawer:drawTexture("UIData/match003.tga", 468, 72, 89, 20, 935, tTeamMark[maxUser], WIDETYPE_6)
		end
	else
		if 1 <= maxUser and maxUser <= 8 then
			drawer:drawTexture("UIData/match003.tga", 468, 72, 89, 20, 935, tPrivateMark[maxUser], WIDETYPE_6)
		end
	end
	--]]
	if string.len(roomPassword) > 0 then
		drawer:setTextColor(255, 255, 255, 255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		if CheckfacilityData(FACILITYCODE_SECRETROOMDESC) == 1 then  
			common_DrawOutlineText1(drawer, g_STRING_ABUSING_SECRETROOM_DESCRIPTION, 410, 110, 255,0,0,255, 255,255,255,255, WIDETYPE_6)
		end
	end
	
	--[[
	if gameMode == 8 then
		drawer:drawTexture("UIData/battleroom001.tga", 211, 140, 602, 46, 0, 777, WIDETYPE_6)
	end
	--]]
	
	
end


function WndBattleRoom_ClubMatchDraw(LeftEmblem, RightEmblem , LeftClubName, RightClubName)
			
	drawer:setFont(g_STRING_FONT_GULIMCHE, 17)
	drawer:setTextColor(255,255,255,255)
	drawer:drawTexture("UIData/match001.tga", 30, 0, 570, 63, 140, 705, WIDETYPE_6)	
	if LeftClubName ~= "" then
		common_DrawOutlineText1(drawer, LeftClubName, 80, 22 , 0,0,0,255, 255,255,255,255, WIDETYPE_6)
	end
	local leftName_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 17, LeftClubName))
	
	local RightName_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 17, RightClubName))
	if RightClubName ~= "" then
		common_DrawOutlineText1(drawer, RightClubName, 410, 22, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
	end
	
	drawer:drawTexture("UIData/match001.tga", 380, 200, 74, 74, 872, 166, WIDETYPE_6)
	drawer:drawTexture("UIData/match001.tga", 560, 200, 74, 74, 872, 166, WIDETYPE_6)
	
	--������
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 40, 14, 32, 32, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_6)
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 386, 206 , 32, 32, 0, 0, 495, 495, 255, 0, 0, WIDETYPE_6)
	end
	
	--������
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 370, 14, 32, 32, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_6)
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 566, 206 , 32, 32, 0, 0, 495, 495, 255, 0, 0, WIDETYPE_6)
	end
	-- 
	drawer:drawTexture("UIData/match001.tga", 470, 200, 78, 74, 946, 166, WIDETYPE_6)
	
end


--------------------------------------------------------------------

-- �������� �޴´�

--------------------------------------------------------------------
-- 1. ���ȣ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_roomIndex")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 200, 80, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(465, 45)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 2. ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_roomTitle")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setWideType(6);
mywindow:setPosition(525, 45)
mywindow:setSize(300, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 3. ��й�ȣ ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_passwordIcon")
mywindow:setTexture("Enabled", "UIData/match003.tga", 227, 137)
mywindow:setTexture("Disabled", "UIData/match003.tga", 227, 137)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(246, 38)
mywindow:setSize(22, 21)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)

--- è�Ǿ� ����� �ѷ��ش�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom__ChampImage")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 327, 666)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 666)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(390, 46)
mywindow:setSize(89, 21)
mywindow:setZOrderingEnabled(false)
--mywindow:setVisible(false)
mywindow:setEnabled(false)
root:addChildWindow(mywindow)

-- 4. ����, �ִ��ο�(���ڴ� ����)
--[[
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_userNum")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("")
mywindow:setPosition(376, 16)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
--]]

-- 5. ���Ӹ��(������ġ, ��ƿ��ġ)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_gameMode")
mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 120)
mywindow:setTexture("Disabled", "UIData/match003.tga", 319, 120)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(17, 37)
mywindow:setSize(54, 23)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)

-- 6. ������, ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_isTeamBattle")
mywindow:setTexture("Enabled", "UIData/match003.tga", 373, 74)
mywindow:setTexture("Disabled", "UIData/match003.tga", 373, 97)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(74, 37)
mywindow:setSize(54, 23)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)

-- 7. ������, ��������, EQUIP
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_isItemBattle")
mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 74)
mywindow:setTexture("Disabled", "UIData/match003.tga", 265, 97)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(131, 37)
mywindow:setSize(54, 23)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)

-- 8. �ð�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_limitTime")
mywindow:setTexture("Enabled", "UIData/match003.tga", 300, 610)
mywindow:setTexture("Disabled", "UIData/match003.tga", 300, 610)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(188, 37)
mywindow:setSize(54, 23)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)

-- 9. ��й�ȣ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_passwordDesc")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(264, 40)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 10. �����(��Ű��:0, �Ϲ�:1)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_rookieImage")
mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 166)
mywindow:setTexture("Disabled", "UIData/match003.tga", 265, 166)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(320, 33)
mywindow:setSize(54, 34)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


function WndBattleRoom_RoomInfomation(roomIndex, roomName, password, curUser, maxUser, gameMode, 
			bTeam, bItem, killCount, limitTime, roomKind , ChampionshipChampCount, LadderLimit)

	
	if g_currentClubBattle == 1 then  -- Ŭ���� ���
		winMgr:getWindow("sj_battleroom_roomIndex"):setText("")
		winMgr:getWindow("sj_battleroom_roomTitle"):setText("")
	--	winMgr:getWindow("sj_battleroom_userNum"):setText("")
		winMgr:getWindow("sj_battleroom_gameMode"):setTexture("Enabled", "UIData/Invisible.tga", 0,0)
		winMgr:getWindow("sj_battleroom_isItemBattle"):setTexture("Enabled", "UIData/Invisible.tga", 0,0)
		winMgr:getWindow("sj_battleroom_limitTime"):setTexture("Enabled", "UIData/Invisible.tga", 0,0)
		winMgr:getWindow("sj_battleroom_isTeamBattle"):setTexture("Enabled", "UIData/Invisible.tga", 0,0)
		winMgr:getWindow("sj_battleroom_passwordDesc"):setText("")
		winMgr:getWindow("sj_battleroom_rookieImage"):setVisible(false)
		winMgr:getWindow("sj_battleroom_passwordIcon"):setVisible(false)
	else
		
		-- 1. ���ȣ
		local roomIndexSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, tostring(roomIndex))
		winMgr:getWindow("sj_battleroom_roomIndex"):setPosition(44-roomIndexSize/2, 12)
		winMgr:getWindow("sj_battleroom_roomIndex"):setText("No. "..roomIndex)

		
		-- 2. ������
		local roomSummaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, roomName, 220)
		winMgr:getWindow("sj_battleroom_roomTitle"):setText(roomSummaryName)
		
		if ChampionshipChampCount == 1 then
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 561)
		elseif ChampionshipChampCount == 2 then
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 561)
		elseif ChampionshipChampCount == 4 then
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 582)
		elseif ChampionshipChampCount == 8 then
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 624)
		elseif ChampionshipChampCount == 16 then
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 603)
		else
			winMgr:getWindow('sj_battleroom__ChampImage'):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 327, 666)
		end
	
	
		-- 3. ��й�ȣ ������
		if string.len(password) > 0 then
			winMgr:getWindow("sj_battleroom_passwordIcon"):setTexture("Enabled", "UIData/match003.tga", 227, 137)
		else
			winMgr:getWindow("sj_battleroom_passwordIcon"):setTexture("Enabled", "UIData/match003.tga", 227, 158)
		end
	
	
		-- 4. �����ο�, �ִ��ο�
		--winMgr:getWindow("sj_battleroom_userNum"):setText("(" .. curUser .. " / " .. maxUser .. ")")
	
		winMgr:getWindow("sj_battleroom_mapChange_LBtn"):setVisible(true)
		winMgr:getWindow("sj_battleroom_mapChange_RBtn"):setVisible(true)

		-- 5. ���Ӹ��(������ġ) 
		if gameMode == 0 then
			winMgr:getWindow("sj_battleroom_gameMode"):setTexture("Enabled", "UIData/match003.tga", 265, 120)
		elseif gameMode == 6 then
			winMgr:getWindow("sj_battleroom_gameMode"):setTexture("Enabled", "UIData/match003.tga", 373, 120)
		elseif gameMode == 8 then
			winMgr:getWindow("sj_battleroom_gameMode"):setTexture("Enabled", "UIData/match003.tga", 408, 610)
			winMgr:getWindow("sj_battleroom_mapChange_LBtn"):setVisible(false)
			winMgr:getWindow("sj_battleroom_mapChange_RBtn"):setVisible(false)
		end
	
	
		-- 6. ����, ������
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow("sj_battleroom_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 265, 74)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow("sj_battleroom_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 319, 74)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow("sj_battleroom_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 265, 143)
		end
		
		-- 7. ��������
		if bTeam == 1 then
			winMgr:getWindow("sj_battleroom_isTeamBattle"):setTexture("Enabled", "UIData/match003.tga", 427, 74)
		else
			winMgr:getWindow("sj_battleroom_isTeamBattle"):setTexture("Enabled", "UIData/match003.tga", 373, 74)
		end
		
		-- 8. ���ѽð�
		if gameMode == 0 then
			winMgr:getWindow("sj_battleroom_limitTime"):setVisible(true)
			winMgr:getWindow("sj_battleroom_limitTime"):setTexture("Enabled", "UIData/match003.tga", 300, 633-((limitTime-1)*23))
		else
			winMgr:getWindow("sj_battleroom_limitTime"):setVisible(false)
		end
		
		-- 9. ��й�ȣ ����
		winMgr:getWindow("sj_battleroom_passwordDesc"):setText(password)
	
	
		-- 10. ��Ű �̹���
		if roomKind == 1 then
			winMgr:getWindow("sj_battleroom_rookieImage"):setVisible(true)
		else
			winMgr:getWindow("sj_battleroom_rookieImage"):setVisible(false)
		end
	end
	
end






--------------------------------------------------------------------

-- �� �̸�

--------------------------------------------------------------------
local tMapName = { ["err"]=0, [0]=g_MAPNAME_1, g_MAPNAME_2, g_MAPNAME_3, g_MAPNAME_4, 
								  g_MAPNAME_5, g_MAPNAME_6, g_MAPNAME_7, g_MAPNAME_8, 
								  g_MAPNAME_9, g_MAPNAME_10, g_MAPNAME_11}
								  
local tMRMapName = { ["err"]=0, g_MAPNAME_MR1, g_MAPNAME_MR2, g_MAPNAME_MR3}
g_currentMapName = ""

-- �� �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_mapName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText(tMapName[WndBattleRoom_CurrentMapIndex()])
mywindow:setWideType(6);
mywindow:setPosition(756, 597)
mywindow:setSize(200, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)



--------------------------------------------------------------------

-- �ʺ��� ��ư

--------------------------------------------------------------------
tLRMapButtonName  = { ["protecterr"]=0, "sj_battleroom_mapChange_LBtn", "sj_battleroom_mapChange_RBtn" }
tLRMapButtonTexX  = { ["protecterr"]=0, 227, 246 }
tLRMapButtonPosX  = { ["protecterr"]=0, 700, 982 }
tLRMapButtonEvent = { ["protecterr"]=0, "ChangeMap_Left", "ChangeMap_Right" }
for i=1, #tLRMapButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLRMapButtonName[i])
	mywindow:setTexture("Normal", "UIData/match003.tga", tLRMapButtonTexX[i], 74)
	mywindow:setTexture("Hover", "UIData/match003.tga", tLRMapButtonTexX[i], 95)
	mywindow:setTexture("Pushed", "UIData/match003.tga", tLRMapButtonTexX[i], 116)
	mywindow:setTexture("PushedOff", "UIData/match003.tga", tLRMapButtonTexX[i], 74)
	mywindow:setWideType(6);
	mywindow:setPosition(tLRMapButtonPosX[i], 594)
	mywindow:setSize(19, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLRMapButtonEvent[i])
	--root:addChildWindow(mywindow)
end


-- �� ���� ��ư Ŭ��
function ChangeMap_Left()
	if WndBattleRoom_IsMaster() == true then
		WndBattleRoom_ChangeMap(0)
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
	end
end

-- �� ������ ��ư Ŭ��
function ChangeMap_Right()
	if WndBattleRoom_IsMaster() == true then
		WndBattleRoom_ChangeMap(1)
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
	end
end


-- ������ �̸� ����
function WndBattleRoom_RandomMap()
	winMgr:getWindow("sj_battleroom_mapName"):clearTextExtends()
	winMgr:getWindow("sj_battleroom_mapName"):setTextExtends(g_MAPNAME_R, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
end

-- ���̸� ����
function WndBattleRoom_CurrentMap(mapIndex, gameMode)
	if gameMode == 0 then
		g_currentMapName = tMapName[mapIndex]
		winMgr:getWindow("sj_battleroom_mapName"):clearTextExtends()
		winMgr:getWindow("sj_battleroom_mapName"):setTextExtends(tMapName[mapIndex], g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
	elseif gameMode == 6 then
		if mapIndex >= 100 then
			local index = mapIndex / 100
			g_currentMapName = tMRMapName[index]
			winMgr:getWindow("sj_battleroom_mapName"):clearTextExtends()
			winMgr:getWindow("sj_battleroom_mapName"):setTextExtends(tMRMapName[index], g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
		end
	elseif gameMode == 8 then
		winMgr:getWindow("sj_battleroom_mapName"):clearTextExtends()
		winMgr:getWindow("sj_battleroom_mapName"):setTextExtends(g_MAPNAME_DUAL, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
	end
end




--------------------------------------------------------------------

-- �漳�� �ʿ��� ����(7��)

--------------------------------------------------------------------
nGameMode		= 0
bTeam			= true
nMaxUser		= 8
nKillCount		= 10
nTimeLimit		= 2
roomName		= ""
roomPassword	= ""


function InitBattleRoomInfo()
	nGameMode		= 0
	bTeam			= true
	nMaxUser		= 8
	nKillCount		= 10
	nTimeLimit		= 2
	roomName		= ""
	roomPassword	= ""
end





--------------------------------------------------------------------

-- �漳��, �ʴ�, ������

--------------------------------------------------------------------
tBR_Btn_Name = {["err"]=0, "sj_br_adjustRoomBtn", "sj_br_inviteBtn"}
tBR_Btn_TexX = {["err"]=0, 0, 97}
tBR_Btn_PosX = {["err"]=0, 685, 685}
tBR_Btn_PosY = {["err"]=0, 626, 671}
tBR_Btn_SizeX = {["err"]=0,  97,  97}
tBR_Btn_Event = {["err"]=0, "BattleRoomReSetupClick", "InviteUserListMode"}
tBR_Btn_DisibleTexX = {["err"]=0,  291,  388}
for i=1, #tBR_Btn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button", tBR_Btn_Name[i])
	mywindow:setTexture("Normal", "UIData/match003.tga", tBR_Btn_TexX[i], 703)
	mywindow:setTexture("Hover", "UIData/match003.tga", tBR_Btn_TexX[i], 746)
	mywindow:setTexture("Pushed", "UIData/match003.tga", tBR_Btn_TexX[i], 789)
	mywindow:setTexture("PushedOff", "UIData/match003.tga", tBR_Btn_TexX[i], 703)
	mywindow:setTexture("Disabled", "UIData/match003.tga", tBR_Btn_DisibleTexX[i], 789)
	mywindow:setWideType(6);
	mywindow:setPosition(tBR_Btn_PosX[i], tBR_Btn_PosY[i])
	mywindow:setSize(tBR_Btn_SizeX[i], 43)
	mywindow:setZOrderingEnabled(false)
	if g_currentClubBattle == true then
		mywindow:setEnabled(false)
	end
	mywindow:subscribeEvent("Clicked", tBR_Btn_Event[i])
	--root:addChildWindow(mywindow)
end


-- �漳�� �ϱ�
function BattleRoomReSetupClick()
	if WndBattleRoom_IsMaster() == true then
		if g_currentClubBattle == true then -- Ŭ�����ΰ�� �漳�� �Ҽ� �����Ѵ�
			ShowCommonAlertOkBoxWithFunction(g_STRING_CANNOT_ROOMSETTING, 'OnClickAlertOkSelfHide')
			return 
		end
		winMgr:getWindow("sj_battleroom_alphaWindow"):setVisible(true)
		winMgr:getWindow("sj_battleroom_roomAdjustWindow"):setVisible(true)
		
		nGameMode, bTeam, nMaxUser, nKillCount, nTimeLimit, roomName, roomPassword = WndBattleRoom_GetRoomInfo()
		winMgr:getWindow("sj_battleroom_roomAdjust_roomTitleWindow"):setText(roomName)
		
		if CheckfacilityData(FACILITYCODE_SETROOMPASSWORD) == 1 then
			winMgr:getWindow("sj_battleroom_roomAdjust_passwordWindow"):setText(roomPassword)
		end
		ChangeUser()
--		ChangeKillCount()
		ChangeLimitTime()
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_ADJUSTROOM)
	end
	
	-- �漳���� ������ ä��â�� ��Ȱ��ȭ ��Ų��
	winMgr:getWindow("doChatting"):setEnabled(false)
end


-- �ʴ��ϱ�
function InviteUserListMode()
	if g_currentClubBattle == true then -- Ŭ�����ΰ�� �ʴ븦 �Ҽ� ���� �Ѵ�
		return 
	end
	winMgr:getWindow("sj_battleroom_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_battleroom_inviteAdjustWindow"):setVisible(true)
	WndBattleRoom_GetInviteUserList()
end


-- ������
function BattleRoomOut()

	-- ���� ���� �غ������� Ȯ���� �ƴϸ� ������.
	if WndBattleRoom_IsObserver() == true then
		RequestExitRoom()
	else	
		if WndBattleRoom_GetReady(WndBattleRoom_GetMyIndex()) == false then
			RequestExitRoom()
		else
			ShowNotifyOKMessage_Lua(g_STRING_WARNING_1)
		end
	end
end



--------------------------------------------------------------------

-- �����ϱ�/�غ��ϱ� ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_startAndReadyBtn")
mywindow:setTexture("Normal", "UIData/match003.tga", 0, 74)
mywindow:setTexture("Hover", "UIData/match003.tga", 0, 208)
mywindow:setTexture("Pushed", "UIData/match003.tga", 0, 342)
mywindow:setTexture("PushedOff", "UIData/match003.tga", 0, 74)
mywindow:setWideType(6);
mywindow:setPosition(784, 626)
mywindow:setSize(227, 90)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndBattleRoom_Ready")
--root:addChildWindow(mywindow)





--------------------------------------------------------------------

-- ���콺 Ŭ�� �̹���

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_mouseClickImage")
mywindow:setTexture("Enabled", "UIData/other001.tga", 0, 397)
mywindow:setTexture("Disabled", "UIData/other001.tga", 0, 397)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(770, 630)
mywindow:setSize(155, 98)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
--root:addChildWindow(mywindow)




--------------------------------------------------------------------

-- ���ٲٱ� ��ư

--------------------------------------------------------------------
if g_currentClubBattle == false then  -- Ŭ�� ��尡 �ƴҰ�츸
	if g_currentTeamBattle == true then

		mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_changeTeamBtn")
		mywindow:setTexture("Normal", "UIData/battleroom001.tga", 894, 239)
		mywindow:setTexture("Hover", "UIData/battleroom001.tga", 894, 341)
		mywindow:setTexture("Pushed", "UIData/battleroom001.tga", 894, 443)
		mywindow:setTexture("PushedOff", "UIData/battleroom001.tga", 894, 545)
		mywindow:setWideType(6);
		mywindow:setPosition(447, 304)
		mywindow:setSize(130, 102)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "RequestChangeTeam")
		--root:addChildWindow(mywindow)
	
	--[[
		if WndBattleRoom_GetAutoBalanceType() == 1 then
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_autobalanceImage")
			mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 690, 555)
			mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 690, 555)
			mywindow:setProperty("FrameEnabled", "False")
			mywindow:setProperty("BackgroundEnabled", "False")
			mywindow:setPosition(424, 224)
			mywindow:setSize(176, 82)
			mywindow:setZOrderingEnabled(false)
			root:addChildWindow(mywindow)
		end
		--]]
	end
end



--------------------------------------------------------------------

-- ������ Ŭ����/���� ���ù�ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_freezoneSelectBtn")
mywindow:setTexture("Normal", "UIData/Event_FreezoneSelect.tga", 708, 0)
mywindow:setTexture("Hover", "UIData/Event_FreezoneSelect.tga", 708, 45)
mywindow:setTexture("Pushed", "UIData/Event_FreezoneSelect.tga", 708, 90)
mywindow:setTexture("PushedOff", "UIData/Event_FreezoneSelect.tga", 708, 0)
mywindow:setWideType(6);
mywindow:setPosition(465, 415)
mywindow:setSize(95, 45)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelect")
--root:addChildWindow(mywindow)

function SetFreeZoneSelectButton(bShow)
	winMgr:getWindow("sj_battleroom_freezoneSelectBtn"):setVisible(bShow)
end

function ClickedFreeZoneSelect()
	CallFreeZoneSelect(true)
end




--------------------------------------------------------------------

-- ȣ��Ʈ ����

--------------------------------------------------------------------
-- 1, 282, 564
function WndBattleRoom_HostChanged(hostindex, myindex)
	
	winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setEnabled(true)
		
	if hostindex == myindex then
	
		local allOK = PlayManager_IsAllPlayable()
		
		if( allOK > 0 ) then		
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 0, 74)
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 0, 208)
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 0, 342)
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 0, 74)
		else
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setEnabled(false)
			winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 0, 476)
		end
	else
		
		local settingOK = PlayManager_IsNetworkSettingOK(myindex)
				
		if WndBattleRoom_GetReady(myindex) == true then
			if settingOK > 0 then
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 708, 149)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 708, 283)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 708, 417)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 708, 149)
			else
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setEnabled(false)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 481, 476)
			end
		else
			if settingOK > 0 then
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 481, 74)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 481, 208)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 481, 342)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 481, 74)
			else
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setEnabled(false)
				winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 708, 551)
			end
		end
	end
end


function WndBattleRoom_ChangeReady(isReady)
	if isReady == 1 then
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 481, 74)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 481, 208)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 481, 342)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 481, 74)
	else
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 708, 149)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 708, 283)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 708, 417)
		winMgr:getWindow("sj_battleroom_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 708, 149)
	end
end




function WndBattleRoom_ClickEffectState(state)
	if winMgr:getWindow("sj_battleroom_startAndReadyBtn"):isDisabled() == false then
		if state == 1 then
			winMgr:getWindow("sj_battleroom_mouseClickImage"):setVisible(true)
		else
			winMgr:getWindow("sj_battleroom_mouseClickImage"):setVisible(false)
		end
	end
end



function WndBattleRoom_LastEffectState(state)
	if state == 1 then
		winMgr:getWindow("sj_battleroom_mouseClickImage"):setVisible(true)
	else
		winMgr:getWindow("sj_battleroom_mouseClickImage"):setVisible(false)
	end
end



function WndBattleRoom_PressingReady(flag)
	if winMgr:getWindow("sj_battleroom_startAndReadyBtn"):isDisabled() == false then
		if flag == 0 then
			winMgr:getWindow("sj_battleroom_mouseClickImage"):setTexture("Disabled", "UIData/other001.tga", 0, 397)
		else
			winMgr:getWindow("sj_battleroom_mouseClickImage"):setTexture("Disabled", "UIData/other001.tga", 0, 495)
		end
	end
end


--------------------------------------------------------------------
-- ������! �ο���! �̱���! �̺�Ʈ ��������
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroomWinCountBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 439, 200)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 439, 200)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(452, 665)
mywindow:setSize(215, 36)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------

-- ������! �ο���! �̱���! �̺�Ʈ

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroomWinCount")
mywindow:setTexture("Enabled", "UIData/match003.tga", 439, 200)
mywindow:setTexture("Disabled", "UIData/match003.tga", 439, 200)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(40, 36)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setAlign(8);
mywindow:addController("successController", "eventAction", "xscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
mywindow:addController("successController", "eventAction", "yscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
winMgr:getWindow('sj_battleroomWinCountBackImage'):addChildWindow(mywindow)
local bCallEventOnce = true

function WndBattleRoom_InitEventInfo()
	bCallEventOnce = true
end

function WndBattleRoom_ShowEventInfo(bComplete, step, winCount, currentRewardValue, timeInfo)
	
end


--------------------------------------------

-- ���� ���� �˾�â

--------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_ban_alphaWindow")
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


-- �������� ��ǥ ����â
banpollwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_ban_backWindow")
banpollwindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
banpollwindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
banpollwindow:setframeWindow(true)
banpollwindow:setProperty("FrameEnabled", "False")
banpollwindow:setProperty("BackgroundEnabled", "False")
banpollwindow:setPosition(342, 250)
banpollwindow:setSize(339, 268)
banpollwindow:setVisible(false)
banpollwindow:setAlwaysOnTop(true)
banpollwindow:setZOrderingEnabled(false)
root:addChildWindow(banpollwindow)

-- ��Ƽ ��ġ ESCŰ ���
RegistEscEventInfo("sj_battleroom_ban_backWindow", "BanToPollNo")

-- �������� ��ǥ âŸ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_ban_backWindowTitleImage")
mywindow:setTexture("Enabled", "UIData/party001.tga", 383, 907)
mywindow:setTexture("Disabled", "UIData/party001.tga", 383, 907)
mywindow:setPosition(104, 3)
mywindow:setSize(130, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �����ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_ban_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 128)
mywindow:setSize(349, 100)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:clearTextExtends()
mywindow:setAlwaysOnTop(true)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �̸� �ؽ�Ʈ ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_ban_nameBackground");
mywindow:setTexture("Enabled", "UIData/party003.tga", 557, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 557, 751)
mywindow:setPosition(34, 59)
mywindow:setSize(267, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �̸� �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_ban_nameWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 200, 80, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 30)
mywindow:setSize(349, 100)
mywindow:setAlwaysOnTop(true)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ ���� �ð� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_ban_decisionTime")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 324, 419)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 324, 419)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(300, 60)
mywindow:setSize(20, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

tTimeNumber = {["err"]=0, [0]=324, 344, 364, 384, 404, 424, 444, 464, 484, 504}
function WndBattleRoom_SetPollTime(time)
	if winMgr:getWindow("sj_battleroom_ban_decisionTime") then
		if winMgr:getWindow("sj_battleroom_ban_decisionTime"):isVisible() then
			winMgr:getWindow("sj_battleroom_ban_decisionTime"):setTexture("Enabled", "UIData/numberUi001.tga", tTimeNumber[time], 419)
			winMgr:getWindow("sj_battleroom_ban_decisionTime"):setTexture("Enabled", "UIData/numberUi001.tga", tTimeNumber[time], 419)
		end
	end
end

-- �������� ��ǥ ������ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_ban_YesBtn")
mywindow:setTexture("Normal", "UIData/party003.tga", 383, 751)
mywindow:setTexture("Hover", "UIData/party003.tga", 383, 790)
mywindow:setTexture("Pushed", "UIData/party003.tga", 383, 829)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 383, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 868)
mywindow:setPosition(62, 216)
mywindow:setSize(87, 39)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BanToPollYes")
banpollwindow:addChildWindow(mywindow)

function BanToPollYes()
	WndBattleRoom_DecisionPollToBan(true)
	ClearBanWindows(false)
end

-- �������� ��ǥ �ݴ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_ban_NoBtn")
mywindow:setTexture("Normal", "UIData/party003.tga", 470, 751)
mywindow:setTexture("Hover", "UIData/party003.tga", 470, 790)
mywindow:setTexture("Pushed", "UIData/party003.tga", 470, 829)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 470, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 470, 868)
mywindow:setPosition(189, 216)
mywindow:setSize(87, 39)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BanToPollNo")
banpollwindow:addChildWindow(mywindow)

function BanToPollNo()
	WndBattleRoom_DecisionPollToBan(false)
	ClearBanWindows(false)
end

-- �������� ��ǥ�� �������� ��
function WndBattleRoom_ProposePollToBan(name, msg)
	ClearBanWindows(true)
	winMgr:getWindow("sj_battleroom_ban_descWindow"):setTextExtends(msg, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
	
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, name)
	winMgr:getWindow("sj_battleroom_ban_nameWindow"):setPosition(171-nameSize/2, 26)
	winMgr:getWindow("sj_battleroom_ban_nameWindow"):setText(name)
end

function ClearBanWindows(bVisible)
	winMgr:getWindow("sj_battleroom_ban_alphaWindow"):setVisible(bVisible)
	winMgr:getWindow("sj_battleroom_ban_backWindow"):setVisible(bVisible)
	winMgr:getWindow("sj_battleroom_ban_nameWindow"):setText("")
end

--------------------------------------------

-- ��������(1.�ɸ�����(����)  2.�ɸ�����(�̸�)  3.��Ÿ��  4.��Ʈ��ũ  5.������  6.��������  7.������  8.����  9. ����â)

--------------------------------------------



local tReverseSort1 = {["err"]=0, [0]=1, 3, 5, 7, 4, 6, 0, 2 }	-- (������)���̾� ������ ���� �����ϰ� �ϱ�^^;
local tReverseSort2 = {["err"]=0, [0]=4, 5, 6, 7, 2, 3, 0, 1 }	-- (����)���̾� ������ ���� �����ϰ� �ϱ�^^;
for index=0, 7 do

	local i = tReverseSort1[index]
	if g_currentTeamBattle then
		i = tReverseSort2[index]
	end
	

	-- �������� �����̹���
	userInfoWindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userBackImage")
	userInfoWindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 828)
	userInfoWindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 828)
	userInfoWindow:setProperty("FrameEnabled", "False")
	userInfoWindow:setProperty("BackgroundEnabled", "False")
	userInfoWindow:setPosition(0, 0)
	userInfoWindow:setSize(128, 43)
	userInfoWindow:setZOrderingEnabled(false)
	userInfoWindow:setEnabled(true)
	userInfoWindow:setVisible(false)
	userInfoWindow:setUserString("userIndex", tostring(i))
	userInfoWindow:setUserString("posX", 0)
	userInfoWindow:setUserString("posY", 0)
	userInfoWindow:subscribeEvent("MouseMove",  "OnMouseMove_UserInfo")
	userInfoWindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo")
	userInfoWindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo")
	--root:addChildWindow(userInfoWindow)
	userInfoBackWindow:addChildWindow(userInfoWindow)	
	-- �ɸ�����(����)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(3, 25)
	mywindow:setSize(20, 15)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- �ɸ�����(�̸�)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(50, 25)
	mywindow:setSize(100, 15)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)

	-- ��Ÿ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_styleImage")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(56, -6)
	mywindow:setSize(87, 35)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_title")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-3, 26)
	mywindow:setSize(107, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Ŭ��Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_userInfo_title2")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(5, 26)
	mywindow:setSize(107, 18)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(2, 23)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- Ŭ�� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_battleroom_clubEmbleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(-41, -5) ---23, 23
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �������� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_battleroom_profileImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(-41, 18)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �ٸ� ������ Īȣ �̹���.
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_battleroom_DiffTitleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setPosition(-41, 18)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	---------------------------------
	-- ��Ʈ��ũ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_networkImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(3, 18)
	mywindow:setSize(0, 5)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ��������
	mywindow = winMgr:createWindow("TaharezLook/Button", i .. "sj_battleroom_userInfo_banBtn")
	mywindow:setTexture("Normal", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Hover", "UIData/battleroom001.tga", 770, 671)
	mywindow:setTexture("Pushed", "UIData/battleroom001.tga", 770, 687)
	mywindow:setTexture("PushedOff", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 770, 703)
	mywindow:setPosition(109, 1)
	mywindow:setSize(16, 16)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setUserString("userIndex", tostring(i))
	mywindow:subscribeEvent("Clicked", "CompulsorilyOutClick")
	--userInfoWindow:addChildWindow(mywindow)
	
	-- ���� ������ 1
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_superMasterImage1")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-29, -24)
	mywindow:setSize(95, 40)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 255, 0, 10, true, true, 10)
	mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 0, 255, 10, true, true, 10)
	--userInfoWindow:addChildWindow(mywindow)
	
	-- ���� ������ 2
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_superMasterImage2")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 224, 966)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 224, 966)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-29, -24)
	mywindow:setSize(95, 40)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:addController("motion", "AlphaMotion2", "alpha", "Sine_EaseInOut", 0, 255, 10, true, true, 10)
	mywindow:addController("motion", "AlphaMotion2", "alpha", "Sine_EaseInOut", 255, 0, 10, true, true, 10)
	--userInfoWindow:addChildWindow(mywindow)
	
	-- ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_masterImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-17, -8)
	mywindow:setSize(75, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
		
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_readyImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-17, -8)
	mywindow:setSize(75, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ����ī��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_icafeImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(128, -6)
	mywindow:setSize(64, 45)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	userInfoWindow:addChildWindow(mywindow)
		
	-- ���Ƽ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_userInfo_penaltyDesc")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(4, 45)
	mywindow:setSize(20, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	
	-----------------------------------------
	-- ����â
	-----------------------------------------
	recordwindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_userInfo_infoWindow")
	recordwindow:setTexture("Enabled", "UIData/myinfo.tga", 737, 731)
	recordwindow:setTexture("Disabled", "UIData/myinfo.tga", 737, 731)
	recordwindow:setProperty("FrameEnabled", "False")
	recordwindow:setProperty("BackgroundEnabled", "False")
	recordwindow:setPosition(0, 0)
	recordwindow:setSize(164, 241)
	recordwindow:setZOrderingEnabled(false)
	recordwindow:setEnabled(false)
	recordwindow:setVisible(false)
	root:addChildWindow(recordwindow)
	
	-- ���ϵ� ����
	---------------------------------
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_totalRecord")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,0,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 25)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_privatBattleNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(11,246,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 43)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(����)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_teamBattleNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(11,246,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 64)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(KO)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_koNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 86)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(KO��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_koRate")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 111)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(��������Ʈ)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_ladderPoint")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 111)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(MVP)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_mvpNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 134)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_teamAtkNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 157)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(��������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_doubleAtkNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 180)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(����Ʈ ���� Ƚ��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_perfectNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 203)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(�ִ뿬��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_MaxcontinueWinNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 226)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
			recordwindow:addChildWindow(mywindow)
		end
		-- ����â ���ϵ�(���°��� Ƚ��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_breakContinueWinNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 249)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
			recordwindow:addChildWindow(mywindow)
		end
		
		-- ����â ���ϵ�(�ų� ����Ʈ)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_infoWindow_mannerPoint")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 272)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
	---------------------------------
	-- ���ϵ� ��
	---------------------------------
		
end




-- ��������
function CompulsorilyOutClick(args)
	local userIndex = CEGUI.toWindowEventArgs(args).window:getUserString("userIndex")
	if userIndex ~= "" then
		WndBattleRoom_UserBan(tonumber(userIndex))
	--	UserBan(tonumber(userIndex))
	end
end


function WndBattleRoom_SetSuperMaster(slot)
	if winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage1") then
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage1"):setVisible(true)
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage1"):activeMotion("AlphaMotion1")
	end
	
	if winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage2") then
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage2"):setVisible(true)
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_superMasterImage2"):activeMotion("AlphaMotion2")
	end
end


function WndBattleRoom_ClearUserInfo(slot)	
	winMgr:getWindow(slot .. "sj_battleroom_userBackImage"):setVisible(false)	
end


local tBattlePosX = { ['protecterr']=0, [0]=50,  140, 240, 340, 839, 746, 654, 550 }
local tBattlePosY = { ['protecterr']=0, [0]=100, 500, 100, 500, 100, 500, 100, 500 }
local g_mySlot = 0
function WndBattleRoom_UpdateUserInfo(slot, mySlot, battleIndex, hostIndex, bTeam, enemyType, level, name, style, relay, network, INFINITE_PING, 
			titleNumber, ladderGrade, flag, roomKind, penalty, bSuperOwner, icafe , emblemKey, ClubTitle , ImageKey, promotion, attribute, bDiffTitleCheck)
	g_mySlot = mySlot
	
	-- 0. �����̹���
	local window = winMgr:getWindow(slot .. "sj_battleroom_userBackImage")
	window:setVisible(true)
	window:setPosition(tBattlePosX[battleIndex], tBattlePosY[battleIndex])
	window:setUserString("posX", tostring(tBattlePosX[battleIndex]))
	window:setUserString("posY", tostring(tBattlePosY[battleIndex]))
	
	
	-- Īȣ�� ������� ũ�⸦ �ٸ��� �Ѵ�.
	local TEXT_POSY = 25
	if titleNumber > 0 then
		TEXT_POSY = 46
		winMgr:getWindow(slot .. "sj_battleroom_userBackImage"):setSize(128, 65)
		if bTeam == 1 then
			if enemyType == 0 then
				window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 829)
			else
				window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 894)
			end
		else
			window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 959)
		end
		
		-- Īȣ
		if titleNumber == 26 then	-- Ŭ��Īȣ
			local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(true)
			_window2:setTextExtends(ClubTitle, g_STRING_FONT_GULIMCHE, 12, 120,200,255,255, 1, 0,0,0,255)
		elseif titleNumber > 0 and #tTitleFilName >= titleNumber then
			local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title2")
			_window:setVisible(true)
			_window2:setVisible(false)
			_window:setTexture("Disabled", "UIData/"..tTitleFilName[titleNumber], tTitleTexX[titleNumber], tTitleTexY[titleNumber])
			_window:setPosition(-2, 25)
		else
			local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(false)				
		end		
	else
		local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title")
		local _window2 = winMgr:getWindow(slot .. "sj_battleroom_userInfo_title2")
		_window:setVisible(false)
		_window2:setVisible(false)
		
		winMgr:getWindow(slot .. "sj_battleroom_userBackImage"):setSize(128, 43)
		if bTeam == 1 then
			if enemyType == 0 then
				window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 872)
			else
				window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 916)
			end
		else
			window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 828)
		end	
	end

	
	-- ���Ƽ(����)
	if roomKind == 1 then
		local PENALTY = 2
		if IsKoreanLanguage() or IsMasLanguage() then
			PENALTY = 5
		end
		
		if ladderGrade > PENALTY then
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setVisible(true)
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setPosition(4, TEXT_POSY+20)
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):clearTextExtends()
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setTextExtends("HP, GetSP -"..penalty.."%", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
		else
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setVisible(false)
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):clearTextExtends()
			winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setTextExtends("", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
		end
	else
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setVisible(false)
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):clearTextExtends()
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_penaltyDesc"):setTextExtends("", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
	end
	

	
	-- �ɸ�����(����)
	if flag == 1 then
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_level"):setVisible(true)
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_ladder"):setVisible(false)
		local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_level")
		_window:setTextColor(255,255,255,255)
		if slot == mySlot then
			_window:setTextColor(255,205,86,255)
		end
		local characterLevel = "Lv." .. level
		_window:setText(characterLevel)
		_window:setPosition(3, TEXT_POSY)
		
	-- ����
	else
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_level"):setVisible(false)
		winMgr:getWindow(slot .. "sj_battleroom_userInfo_ladder"):setVisible(true)
		local _window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_ladder")
		_window:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladderGrade)
		_window:setPosition(-2, TEXT_POSY-3)
	end
	
	-- ������ Ű
	
	winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setScaleHeight(160)

	if emblemKey > 0 then
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setVisible(true) 
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	else
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setVisible(false)
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(slot .. "sj_battleroom_clubEmbleImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	
	-- �ٸ������� Īȣ
	if bDiffTitleCheck > 0 and ImageKey > 0 then
		if flag == 1 then
			-- Īȣ 
			local titleIndex = titleNumber - 27 
			local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
			local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

			winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setVisible(false) 
			winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
			winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		else
			-- �̹��� Ű
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setVisible(false)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		end
	elseif bDiffTitleCheck > 0 then
		-- Īȣ 
		local titleIndex = titleNumber - 27 
		local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
		local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

		winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setVisible(true)
		winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setVisible(false) 
		winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
	else
		-- �̹��� Ű
		if ImageKey > 0 then
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setVisible(true) 
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		else
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
			winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		end
	end
	winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "sj_battleroom_profileImage"):setScaleHeight(160)
	winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "sj_battleroom_DiffTitleImage"):setScaleHeight(160)
	
	-- �ɸ�����(�̸�)
	window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_name")
	window:setTextColor(255,255,255,255)
	if slot == mySlot then
		window:setTextColor(255,205,86,255)
	end
	local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(summaryName))
	window:setPosition(88-nameSize/2, TEXT_POSY)
	window:setText(summaryName)
	

	-- ��Ÿ��
	window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_styleImage")
	window:setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	window:setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
		
	-- ��Ʈ��ũ
	if network == INFINITE_PING then
		window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_networkImage")
		window:setTexture("Enabled", "UIData/GameNewImage.tga", 123, 63)
		window:setTexture("Disabled", "UIData/GameNewImage.tga", 123, 63)
		window:setPosition(-38, -7)
		window:setSize(18, 18)
		window:setScaleWidth(300)
		window:setScaleHeight(300)
	else
		local WIDTH = 120
		if		 0 <= network and network <= 20 then	offset = 120
		elseif	20 <  network and network <= 40 then	offset = 96
		elseif	40 <  network and network <= 60 then	offset = 72
		elseif	60 <  network and network <= 80 then	offset = 48
		elseif	80 <  network and network <= 100 then	offset = 24
		else											offset = 24
		end
		
		window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_networkImage")
		window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
		window:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
		window:setPosition(3, 18)
		window:setSize(offset, 5)
		window:setScaleWidth(255)
		window:setScaleHeight(255)
	end
	

	-- ����ī��
	window = winMgr:getWindow(slot .. "sj_battleroom_userInfo_icafeImage")
	if icafe == 1 then
		window:setVisible(true)
		window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
		window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
		window:setScaleWidth(160)
		window:setScaleHeight(160)
		
	elseif icafe == 2 then
		window:setVisible(true)
		window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 665, 235)
		window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 665, 235)
		window:setScaleWidth(160)
		window:setScaleHeight(160)
	else
		window:setVisible(false)
	end
	
end


function WndBattleRoomClearUserInfoWindow(slot)
	winMgr:getWindow(slot .. "sj_battleroom_userInfo_infoWindow"):setVisible(false)
end



-- ���콺�� ������ ��
local tAdjustIndex = {["err"]=0, [0]=0, 4, 1, 5, 2, 6, 3, 7}
function OnMouseMove_UserInfo(args)
	
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then

		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			userIndex = tonumber(szUserIndex)
			
			local adjustIndex = userIndex
			if g_currentTeamBattle == false then
				adjustIndex = tAdjustIndex[userIndex]
			end
			local posX = CEGUI.toMouseEventArgs(args).position.x + 40
			local posY = CEGUI.toMouseEventArgs(args).position.y
			
		
			-- ������ �ѱ��� ���̻� x������ �������� �ʱ�
			if adjustIndex == 0 or adjustIndex == 2 or adjustIndex == 4 or adjustIndex == 6 then
				posY = posY + 28
			else
				posY = posY - 214
			end
			
			if posX >= g_CURRENT_WIN_SIZEX-200 then
				posX = posX - 200
			end
			
			-- ����â x, y�� ����
			if winMgr:getWindow(szUserIndex .. "sj_battleroom_userInfo_infoWindow") then
				if winMgr:getWindow(szUserIndex .. "sj_battleroom_userInfo_infoWindow"):isVisible() then
					winMgr:getWindow(szUserIndex .. "sj_battleroom_userInfo_infoWindow"):setPosition(posX, posY)
				end
			end
		end
	end
	
end




-- ���콺�� �������� �̹���â�� ��������
function OnMouseEnter_UserInfo(args)
	
	local window = CEGUI.toWindowEventArgs(args).window	
--	if tonumber(userIndex) ~= g_mySlot then
--		return
--	end
	
	if window:isVisible() then
		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			userIndex = tonumber(szUserIndex)
			winMgr:getWindow(userIndex .. "sj_battleroom_userInfo_infoWindow"):setVisible(true)
			
			local total, individual, team, ko, koRate, mvp, teamAtk, doubleAtk, ladderExp, perfect, consecutiveWin, consecutiveWinBreak, mannerPoint = WndBattleRoom_GetCharacterRecord(userIndex)
			if total < 0 then	-- �����ϰ�� ����
				return
			end
			
			local TEXT_X = 150
			local ADDTEXT_X = 10
			
			-- ������
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(total))
			local posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_totalRecord"):setPosition(posX, 26)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_totalRecord"):setText(tostring(total))
			
			-- ������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(individual))
			posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_privatBattleNum"):setPosition(posX, 41)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_privatBattleNum"):setText(tostring(individual))
			
			-- ����
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(team))
			posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_teamBattleNum"):setPosition(posX, 56)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_teamBattleNum"):setText(tostring(team))
			
			
			---------------------------
			-- KO
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(ko))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_koNum"):setPosition(posX, 74)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_koNum"):setText(tostring(ko))
		
			-- KO��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(koRate))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_koRate"):setPosition(posX, 89)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_koRate"):setText(tostring(koRate))
			
			-- ��������Ʈ
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(ladderExp))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_ladderPoint"):setPosition(posX, 105)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_ladderPoint"):setText(tostring(ladderExp))
			
			
			---------------------------
			-- MVP
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(mvp))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mvpNum"):setPosition(posX, 122)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mvpNum"):setText(tostring(mvp))
			
			-- ������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(teamAtk))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_teamAtkNum"):setPosition(posX, 138)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_teamAtkNum"):setText(tostring(teamAtk))
		
			-- ��������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(doubleAtk))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_doubleAtkNum"):setPosition(posX, 154)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_doubleAtkNum"):setText(tostring(doubleAtk))
			
			
			---------------------------
			-- ����Ʈ ���� Ƚ��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(perfect))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_perfectNum"):setPosition(posX, 174)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_perfectNum"):setText(tostring(perfect))
			
			-- �ִ뿬��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(consecutiveWin))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_MaxcontinueWinNum"):setPosition(posX, 190)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_MaxcontinueWinNum"):setText(tostring(consecutiveWin))
		
			-- ���°��� Ƚ��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(consecutiveWinBreak))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_breakContinueWinNum"):setPosition(posX, 205)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_breakContinueWinNum"):setText(tostring(consecutiveWinBreak))
			
			-- �ų� ����Ʈ
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(mannerPoint))
			posX = TEXT_X - size + ADDTEXT_X
			if mannerPoint >= 0 then
				winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mannerPoint"):setTextColor(255,255,255,255)
			else
				winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mannerPoint"):setTextColor(255,0,0,255)
			end			
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mannerPoint"):setPosition(posX, 224)
			winMgr:getWindow(szUserIndex .. "sj_battleroom_infoWindow_mannerPoint"):setText(tostring(mannerPoint))
		end
	end
	
end




-- ���콺�� �������� �̹���â�� ������ ��
function OnMouseLeave_UserInfo(args)

	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			local userIndex = szUserIndex
			winMgr:getWindow(userIndex .. "sj_battleroom_userInfo_infoWindow"):setVisible(false)
			
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_totalRecord"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_privatBattleNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_teamBattleNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_koNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_koRate"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_ladderPoint"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_mvpNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_teamAtkNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_doubleAtkNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_perfectNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_MaxcontinueWinNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_breakContinueWinNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_battleroom_infoWindow_mannerPoint"):setText("")
		end
	end

end

function OnCharacterPicking(name, index, bGM)

	if name == nil or name == "" then
		return
	end

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
					
			-- ���ϰ�� �������� ����.
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
			if name == _my_name then
				local m_pos = mouseCursor:getPosition()
				ShowPopupWindow(m_pos.x, m_pos.y, 1)
				g_strSelectRButtonUp = name
				winMgr:getWindow('pu_myInfo'):setEnabled(true)
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
				winMgr:getWindow('pu_watchEquipment'):setEnabled(true)
				
				-- ��Ƽ �ʴ�� ��밡 ��Ƽ�� ���� �ִ��� ������ Ȯ���ؾ� �Ѵ�.
				winMgr:getWindow('pu_inviteParty'):setEnabled(false)
				winMgr:getWindow('pu_vanishParty'):setEnabled(false)	-- ��Ȱ��
				-- �������� üũ
				if bGM == 1 then
					DebugStr("���������Դϴ�")
					MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty", "pu_watchEquipment");
				else
					DebugStr("������ �ƴϴ�")
					MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ); -- �Ű��ϱ� ��� ����
				end
			end
		end
	end
	
end


function WndBattleRoom_OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


function WndBattleRoom_OnRootMouseRButtonUp(args)

	if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('CJ_NotifyPopupBack'):isVisible() then
		return
	end
	
	if winMgr:getWindow('sj_battleroom_alphaWindow'):isVisible() then
		return
	end
	
	if winMgr:getWindow('UserInfo_Main'):isVisible() then
		return
	end
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			WndBattleRoom_PickObjects();
		end
	end
end

root:setSubscribeEvent("MouseButtonUp", "WndBattleRoom_OnRootMouseButtonUp");
root:setSubscribeEvent("MouseRButtonUp", "WndBattleRoom_OnRootMouseRButtonUp");




----------------------------------------------------

-- ���� ���̽� ���� �����ֱ�

----------------------------------------------------
function WndBattleRoom_ShowMRVersion(version)
--	DrawEachNumberWide("UIData/dungeonmsg.tga", version, 1, 980, 560, 516, 224, 12, 14, 15 , WIDETYPE_6)
end




------------------------------------------------

--	��ǳ�� �׸���

------------------------------------------------
function WndBattleRoom_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	local alpha  = 200
	local UNIT   = 18		-- 1edge�� ������
	local UNIT2X = UNIT*2								-- 1edge�� ������ * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- �ؽ�ó ���� x��ġ
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- �ؽ�ó ���� y��ġ
	local texX_R = texX_L+(UNIT*2)						-- �ؽ�ó ������ x��ġ
	local texY_R = texY_L+(UNIT*2)						-- �ؽ�ó ������ y��ġ
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- �ؽ�Ʈ ����(0:���, 1:������)
	local posX	 = 0 		-- ��ǳ�� x��ġ
	local posY	 = tChatBubblePosY[chatBubbleType]		-- ��ǳ�� y��ġ
	
	local textPosY = tChatTextPosY[chatBubbleType]
	
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 14)
	local AREA_X = twidth
	local AREA_Y = theight
	
	-- ��� ���� �ϱ�
	local DIV_X = twidth  / UNIT
	local DIV_Y = theight / UNIT
	local X = px-(UNIT2X+UNIT+(DIV_X*UNIT))/2 + posX
	local Y = py-AREA_Y-(UNIT*3) + posY - 14
	
	-- ������ 4����
	drawer = root:getDrawer()
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y,					 UNIT, UNIT, texX_L, texY_L, alpha)-- ���� ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y,					 UNIT, UNIT, texX_R, texY_L, alpha)-- ������ ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_L, texY_R, alpha)-- ���� �Ʒ�
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_R, texY_R, alpha)-- ������ �Ʒ�
	
	-- ���� ����
	for i=0, DIV_X do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y,						UNIT, UNIT, texX_L+UNIT, texY_L, alpha)-- ������
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT),	UNIT, UNIT, texX_L+UNIT, texY_R, alpha)-- �Ʒ�����
		
		-- ���
		for j=0, DIV_Y do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT+(j*UNIT), UNIT, UNIT, texX_L+UNIT, texY_L+UNIT, alpha)
		end
	end
	
	-- ���� ����
	for i=0, DIV_Y do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_L, texY_L+UNIT, alpha)-- ���ʶ���
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_R, texY_L+UNIT, alpha)-- �����ʶ���
	end
	

	-- �ؽ�Ʈ �׸���
	drawer:setTextColor(r,g,b,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
end




local g_LevelupMoney = 0
------------------------------------------------
-- ������ �̺�Ʈ �����ش�.
------------------------------------------------
function ShowLevelUpEvent(LevelupMoney)
	g_LevelupMoney = LevelupMoney
	RegistEscEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	RegistEnterEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	root:addChildWindow(winMgr:getWindow("LevelUpEventAlpha"))
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(true)
	
end


function LevelUpEventRender(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	
	local _left = DrawEachNumber("UIData/other001.tga", g_LevelupMoney, 8, 195, 34, 11, 683, 24, 33, 25,  drawer)
	drawer:drawTexture("UIData/other001.tga", _left-25, 35, 30, 29, 266, 685)
	

end


function LevelUpEventButtonEvent()
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(false)
end


--------------------------------------------------------------------

-- �����̹� ��ŷ���� ��ư

--------------------------------------------------------------------
function WndBattleRoom_SetGameMode(gameMode)
--[[	if gameMode == 6 then
		if winMgr:getWindow("sj_battleroom_mrRankingInfoBtn") then
			winMgr:getWindow("sj_battleroom_mrRankingInfoBtn"):setVisible(true)
		end
	end]]
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_mrRankingInfoBtn")
mywindow:setTexture("Normal", "UIData/match001.tga", 257, 508)
mywindow:setTexture("Hover", "UIData/match001.tga", 257, 538)
mywindow:setTexture("Pushed", "UIData/match001.tga", 257, 569)
mywindow:setTexture("PushedOff", "UIData/match001.tga", 257, 508)	
mywindow:setWideType(6);
mywindow:setPosition(5, 544)
mywindow:setSize(79, 30)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickTabToMRRankInfo")
root:addChildWindow(mywindow)

function ClickedMRRankInfoWindow(gameMode)
	if gameMode == 6 then
		ClickTabToMRRankInfo()
	end
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_mrRankingInfo_alphaWindow")
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

-- ��ŷ���� ����
mrrankwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_mr_rankInfo_backImage")
mrrankwindow:setTexture("Enabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setTexture("Disabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setProperty("FrameEnabled", "False")
mrrankwindow:setProperty("BackgroundEnabled", "False")
mrrankwindow:setWideType(6);
mrrankwindow:setPosition(257, 95)
mrrankwindow:setSize(510, 577)
mrrankwindow:setAlwaysOnTop(true)
mrrankwindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow"):addChildWindow(mrrankwindow)

-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_mr_rankInfo_cancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(478, 10)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMRRanking")
mrrankwindow:addChildWindow(mywindow)

function HideMRRanking()
	winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow"):setVisible(false)
	WndBattleRoom_InitMRRankInfo()
end

-- ���̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_mr_rankInfo_MapName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setPosition(230, 62)
mywindow:setSize(200, 20)
mywindow:setZOrderingEnabled(false)
mrrankwindow:addChildWindow(mywindow)

local MAX_MR_RANK = 20
local tMRRankInfoName = {["err"]=0, [0]="_rank", "_name", "_time", "_kill"}
local tMRRankInfoPosX = {["err"]=0, [0]=92, 188, 270, 392}

-- 1 ~ 20�� ��������
for i=0, MAX_MR_RANK-1 do
	for j=0, #tMRRankInfoName do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[j])
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,200,80,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setText("")
		mywindow:setPosition(tMRRankInfoPosX[j], 135+(i*21))
		mywindow:setSize(60, 20)
		mywindow:setZOrderingEnabled(false)
		mrrankwindow:addChildWindow(mywindow)
	end
end


function WndBattleRoom_SetMRRankInfo(i, rank, name, time, kill)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rank)
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[0]):setPosition(tMRRankInfoPosX[0]-size, 135+(i*21))
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[0]):setText(rank)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[1]):setPosition(tMRRankInfoPosX[1]-size/2, 135+(i*21))
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[1]):setText(name)
	
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[2]):setText(time)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kill)
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[3]):setPosition(tMRRankInfoPosX[3]-size/2, 135+(i*21))
	winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[3]):setText(kill)
end

function WndBattleRoom_InitMRRankInfo()
	for i=0, MAX_MR_RANK-1 do
		for j=0, #tMRRankInfoName do
			winMgr:getWindow("sj_battleroom_mr_rankInfo_"..i..tMRRankInfoName[j]):setText("")
		end
	end
end

function ClickTabToMRRankInfo()
--[[	if winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow") then
		if winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow"):isVisible() then
			winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow"):setVisible(false)
			winMgr:getWindow("sj_battleroom_mr_rankInfo_MapName"):setText("")
			WndBattleRoom_InitMRRankInfo()
		else
			winMgr:getWindow("sj_battleroom_mrRankingInfo_alphaWindow"):setVisible(true)

			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, g_currentMapName)
			winMgr:getWindow("sj_battleroom_mr_rankInfo_MapName"):setPosition(256-size/2, 62)
			winMgr:getWindow("sj_battleroom_mr_rankInfo_MapName"):setText(g_currentMapName)
			
			WndBattleRoom_RequestMRRank()
		end
	end]]
end
RegistEscEventInfo("sj_battleroom_mrRankingInfo_alphaWindow", "HideMRRanking")







--------------------------------------------------------------------

-- �˸��޼���

--------------------------------------------------------------------
-- ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleRoom_lphaWindow")
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleRoom_backWindow")
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

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleRoom_descWindow")
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
winMgr:getWindow("sj_battleRoom_backWindow"):addChildWindow(mywindow)

-- OK, CANCEL ��ư
local tAlertName = {['protecterr'] = 0, "sj_battleRoom_okBtn", "sj_battleRoom_CancelBtn"}
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
	winMgr:getWindow("sj_battleRoom_backWindow"):addChildWindow(mywindow)
end


---------------------------------------

-- ���� �������� �� ��

---------------------------------------
function WndBattleRoom_RequestExitRoom(msg)
	ShowbattleRoomOkCancelBoxFunction1(msg, 'OnClickExitRoomOk', 'OnClickExitRoomCancel')
end

function ShowbattleRoomOkCancelBoxFunction1(arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_battleRoom_lphaWindow') then
		local aa= winMgr:getWindow("sj_battleRoom_lphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_battleRoom_lphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_battleRoom_lphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_battleRoom_lphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_battleRoom_lphaWindow"))
		local local_window = winMgr:getWindow("sj_battleRoom_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_battleRoom_lphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_battleRoom_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_battleRoom_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_battleRoom_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- ����
function OnClickExitRoomOk(args)

	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local okfunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickExitRoomOk" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		FromWndBattleRoomGoToWndLobby()
	end
end


-- ����
function OnClickExitRoomCancel(args)
	
	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local nofunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickExitRoomCancel" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("sj_battleRoom_lphaWindow", "OnClickExitRoomOk")
RegistEscEventInfo("sj_battleRoom_lphaWindow", "OnClickExitRoomCancel")



---------------------------------------

-- ���� ������ �� �����.

---------------------------------------
function WndBattleRoom_RequestChangeTeam(msg)
	ShowbattleRoomOkCancelBoxFunction2(msg, 'OnClickChangeTeamOk', 'OnClickChangeTeamCancel')
end


function ShowbattleRoomOkCancelBoxFunction2(arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_battleRoom_lphaWindow') then
		local aa= winMgr:getWindow("sj_battleRoom_lphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_battleRoom_lphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_battleRoom_lphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_battleRoom_lphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_battleRoom_lphaWindow"))
		local local_window = winMgr:getWindow("sj_battleRoom_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_battleRoom_lphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_battleRoom_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_battleRoom_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_battleRoom_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- ����
function OnClickChangeTeamOk(args)

	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local okfunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickChangeTeamOk" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		WndBattleRoom_ChangeTeam()
	end
end


-- ����
function OnClickChangeTeamCancel(args)
	
	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local nofunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickChangeTeamCancel" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("sj_battleRoom_lphaWindow", "OnClickChangeTeamOk")
RegistEscEventInfo("sj_battleRoom_lphaWindow", "OnClickChangeTeamCancel")
--winMgr:getWindow("doChatting"):deactivate()

local WATCHING_WHO = PreCreateString_2488	--GetSStringInfo(LAN_CLUBWAR_PLAY_OBSERVER)	-- %s ������
function WndRoom_DrawObserverInfo()
	local characterName = ""
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 160, 514, 41, 0, 220, WIDETYPE_6)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
	if team == 0 then
		drawer:setTextColor(254,87,87,255)
	else
		drawer:setTextColor(97,161,240,255)
	end
	local szName = string.format(WATCHING_WHO, characterName)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, szName)
	drawer:drawText(szName, 512-size/2, 173, WIDETYPE_6)
end

DrawTitleTick = 0
function Champ_DrawTitle()	
	DrawTitleTick = DrawTitleTick + 1
	if DrawTitleTick == 1 then
		DebugStr('ù��°����')
		winMgr:getWindow("ChampTitleMoveBar"):activeMotion("TitleMotion")
	end
	
	if DrawTitleTick == 4 then
		DebugStr('�ι�°����')
		winMgr:getWindow("ChampTitleMoveBar2"):activeMotion("TitleMotion2")
	end
end

-----------------------------------------
-- è�Ǿ� �����ð�
-----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChampRemainTimeImg")
mywindow:setTexture("Enabled", "UIData/LobbyImage_champ.tga", 608, 418)
mywindow:setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 418)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(438, 625)
mywindow:setSize(168, 43)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:addController("ChampController", "ChampEffect", "visible", "Sine_EaseIn", 1, 1, 8, true, true, 10)
mywindow:addController("ChampController", "ChampEffect", "visible", "Sine_EaseIn", 0, 0, 8, true, true, 10)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


function SettingChampionshipRemainSecond(RemainSecond)
	
	winMgr:getWindow("ChampRemainTimeImg"):activeMotion("ChampEffect")
	
	if RemainSecond < 60 then
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 418)
	elseif RemainSecond < 120 then
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 461)
	elseif RemainSecond < 180 then
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 504)
	elseif RemainSecond < 240 then
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 547)
	elseif RemainSecond < 280 then
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 590)
	else
		winMgr:getWindow("ChampRemainTimeImg"):setTexture("Disabled", "UIData/LobbyImage_champ.tga", 608, 633)
	end

end