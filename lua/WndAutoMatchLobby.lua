-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
g_SelectedAutoMatchLobbyTab = 4 

AUTOMATCHREADY = 0
AUTOMATCHFINED = 1
AUTOMATCHSTART = 2

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

local g_STRING_WARNING_CHANGEMAP	= PreCreateString_1128	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_1)	-- �ʺ����� ���常 �Ҽ� �ֽ��ϴ�.
CurrentAutoBattleMap = 0


--------------------------------------------------------------------
-- ä�� ���� Temp ���̱�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchLobby_ChannelTemp")
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 792, 939);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 792, 939);
mywindow:setWideType(6);
mywindow:setPosition(800, 8);
mywindow:setSize(222, 36);
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)
--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
winMgr:getWindow("AutoMatchLobby_ChannelTemp"):addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setVisible(true)
winMgr:getWindow('ChannelPositionBG'):setWideType(0);
winMgr:getWindow('ChannelPositionBG'):setPosition(0, 0);
winMgr:getWindow('NewMoveServerBtn'):setVisible(false)
winMgr:getWindow('NewMoveExitBtn'):setVisible(true)


root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end
--------------------------------------------------------------------

-- drawTexture(StartRender:���۽ÿ� �׸���)

--------------------------------------------------------------------
function WndAutoMatchLobby_RenderBackImage(currentBattleChannelName)
	
	--drawer:drawTexture("UIData/mainBG_Button001.tga", 30, 15, 281, 46, 0, 440, WIDETYPE_6)	--FIGHTCLUB ����
	
	-- ����ä�� �̸�
	if g_BattleMode == BATTLETYPE_NORMAL then
		drawer:setTextColor(255, 255, 255, 255)
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		drawer:setTextColor(220, 80, 220, 255)
	end

end

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


function AutoMatchLobbyMouseClick()
	PlayWave("sound/button_click.wav");
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


-- ���Ӹ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchLobby_MapImage")
mywindow:setTexture("Enabled", "UIData/Automatch3.tga", 0, 127)
mywindow:setTexture("Disabled", "UIData/Automatch3.tga", 0, 127)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(642, 585)
mywindow:setSize(374, 128)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)

AutoMatchMapName = { g_MAPNAME_1, g_MAPNAME_2, g_MAPNAME_3, g_MAPNAME_4, g_MAPNAME_5, g_MAPNAME_6, g_MAPNAME_7, g_MAPNAME_8, g_MAPNAME_9, g_MAPNAME_10, g_MAPNAME_11}
AutoMatchLobby_MapTexPosY = {['protecterr']=0, 127,	254, 381, 508, 635, 762, 635, 635, 762, 889 , 0}
AutoMatchLobby_MapTexPosX = {['protecterr']=0, 0,	0,	 0,   0,   0,   0,  0, 0,  0,   0 ,  373}

g_currentMapIndex = 1
---------------------------------------
--- ���Ӹ� �յ� ��ư
---------------------------------------
local AutoMatch_BtnName  = {["err"]=0, "AutoMatch_LBtn", "AutoMatch_RBtn"}
local AutoMatch_BtnTexX  = {["err"]=0,  314, 347}
local AutoMatch_BtnPosX  = {["err"]=0,  685, 945}
local AutoMatch_BtnEvent = {["err"]=0, "AutoMatch_PrevPage", "AutoMatch_NextPage"}
for i=1, #AutoMatch_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", AutoMatch_BtnName[i])
	mywindow:setTexture("Normal", "UIData/AutoMatch.tga", AutoMatch_BtnTexX[i], 769)
	mywindow:setTexture("Hover", "UIData/AutoMatch.tga", AutoMatch_BtnTexX[i], 802)
	mywindow:setTexture("Pushed", "UIData/AutoMatch.tga", AutoMatch_BtnTexX[i], 835)
	mywindow:setTexture("PushedOff", "UIData/AutoMatch.tga", AutoMatch_BtnTexX[i], 769)
	mywindow:setWideType(6);
	mywindow:setPosition(AutoMatch_BtnPosX[i], 550)
	mywindow:setSize(33, 33)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", AutoMatch_BtnEvent[i])
	root:addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "AutoMatch_MapText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setWideType(6);
mywindow:setPosition(795, 560)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(g_MAPNAME_1, g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
root:addChildWindow(mywindow)

---------------------------------------
---�κ� ��Ī ���������� ��ư--
---------------------------------------
function AutoMatch_PrevPage()
	if AutoMatchLobby_IsMaster() == true then
		AutoMatchLobby_ChangeMap(-1)
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
	end
end

---------------------------------------
---�κ� ��Ī ���������� ��ư--
---------------------------------------
function AutoMatch_NextPage()
	if AutoMatchLobby_IsMaster() == true then
		AutoMatchLobby_ChangeMap(1)
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
	end
end

function AutoMatch_SettingMapImage(MapIndex)
	DebugStr('MapIndex:'..MapIndex)
	winMgr:getWindow('AutoMatch_MapText'):clearTextExtends()
	winMgr:getWindow('AutoMatch_MapText'):addTextExtends(AutoMatchMapName[MapIndex+1], g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow('AutoMatchLobby_MapImage'):setTexture('Enabled', "UIData/Automatch3.tga", 	AutoMatchLobby_MapTexPosX[MapIndex+1], AutoMatchLobby_MapTexPosY[MapIndex+1])
end


-- ã���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchLobby_SearchImage")
mywindow:setTexture("Enabled", "UIData/Automatch2.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Automatch2.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(632, 145)
mywindow:setSize(387, 343)
mywindow:setVisible(false)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)

-- ã���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoMatchLobby_SearchSubImage")
mywindow:setTexture("Enabled", "UIData/Automatch2.tga", 0, 343)
mywindow:setTexture("Disabled", "UIData/Automatch2.tga", 0, 343)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 170)
mywindow:setSize(387, 43)
mywindow:setVisible(false)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("SearchController", "SearchEffect", "visible", "Sine_EaseIn", 1, 1, 8, true, true, 10)
mywindow:addController("SearchController", "SearchEffect", "visible", "Sine_EaseIn", 0, 0, 8, true, true, 10)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('AutoMatchLobby_SearchImage'):addChildWindow(mywindow)

function ActiveSearchMatchEffect()
	winMgr:getWindow('AutoMatchLobby_SearchImage'):setVisible(true)
	winMgr:getWindow('AutoMatchLobby_SearchSubImage'):setVisible(true)
	winMgr:getWindow('AutoMatchLobby_SearchSubImage'):activeMotion('SearchEffect')
end

function StopSearchMatchEffect()
	winMgr:getWindow('AutoMatchLobby_SearchImage'):setVisible(false)
	winMgr:getWindow('AutoMatchLobby_SearchSubImage'):setVisible(false)
	winMgr:getWindow('AutoMatchLobby_SearchSubImage'):clearActiveController();	
end

function WndAutoMatchLobby_DrawStartMatchCount(RemainTime)
	RealNumber = RemainTime/1000
	if RealNumber > 9 then
		RealNumber = 9	
	end
	drawer:drawTexture("UIData/automatch2.tga", 480, 150, 46, 71, 794 -(RealNumber*46), 407, WIDETYPE_6);
end

function WndAutoMatchLobby_DrawStartNotice(type)
	if type == 0 then 
		drawer:drawTexture("UIData/automatch2.tga", 280, 100, 472, 132, 552, 141, WIDETYPE_6);
	elseif type == 10 then 
		drawer:drawTexture("UIData/automatch2.tga", 280, 100, 472, 132, 552, 480, WIDETYPE_6);
	elseif type == 20 then
		drawer:drawTexture("UIData/automatch2.tga", 280, 100, 472, 132, 552, 273, WIDETYPE_6);
	end
end

-------------------------
-- ��Ʋ�뿡�� �ۿ°�
-------------------------
local tReverseSort1 = {["err"]=0, [0]=1, 3, 5, 7, 4, 6, 0, 2 }	-- (������)���̾� ������ ���� �����ϰ� �ϱ�^^;
local tReverseSort2 = {["err"]=0, [0]=4, 5, 6, 7, 2, 3, 0, 1 }	-- (����)���̾� ������ ���� �����ϰ� �ϱ�^^;



for index=0, 7 do
	
	g_currentTeamBattle = 1
	local i = tReverseSort1[index]
	if g_currentTeamBattle then
		i = tReverseSort2[index]
	end
	
	
	-- �������� �����̹���
	userInfoWindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userBackImage")
	userInfoWindow:setTexture("Enabled", "UIData/AutoMatch.tga", 318, 901)
	userInfoWindow:setTexture("Disabled", "UIData/AutoMatch.tga", 318, 901)
	userInfoWindow:setProperty("FrameEnabled", "False")
	userInfoWindow:setProperty("BackgroundEnabled", "False")
	userInfoWindow:setPosition(0, 0)
	userInfoWindow:setSize(152, 61)
	userInfoWindow:setZOrderingEnabled(false)
	userInfoWindow:setEnabled(true)
	userInfoWindow:setVisible(true)
	userInfoWindow:setUserString("userIndex", tostring(i))
	userInfoWindow:setUserString("posX", 0)
	userInfoWindow:setUserString("posY", 0)
	--userInfoWindow:subscribeEvent("MouseMove",  "OnMouseMove_UserInfo")
	--userInfoWindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo")
	--userInfoWindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo")
	--root:addChildWindow(userInfoWindow)
	userInfoBackWindow:addChildWindow(userInfoWindow)	
	-- �ɸ�����(����)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "AutoMatchLobby_userInfo_level")
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
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "AutoMatchLobby_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(50, 55)
	mywindow:setSize(100, 15)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)

	-- ��Ÿ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_styleImage")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-3, 38)
	mywindow:setSize(87, 35)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_title")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, 26)
	mywindow:setSize(107, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Ŭ��Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "AutoMatchLobby_userInfo_title2")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(5, 26)
	mywindow:setSize(107, 18)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- Ŭ������
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "AutoMatchLobby_userInfo_Clubname")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(68, 8)
	mywindow:setSize(107, 18)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(2, 23)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- Ŭ�� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."AutoMatchLobby_clubEmbleImage")
	mywindow:setTexture('Enabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(45, 5) ---23, 23
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �������� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."AutoMatchLobby_profileImage")
	mywindow:setTexture('Enabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(4, 4)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_masterImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, -20)
	mywindow:setSize(75, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ���� ������ 1
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_superMasterImage1")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-8, -40)
	mywindow:setSize(95, 40)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	--mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 255, 0, 10, true, true, 10)
	--mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 0, 255, 10, true, true, 10)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �ٸ� ������ Īȣ �̹���.
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."AutoMatchLobby_DiffTitleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setPosition(-41, 18)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	---------------------------------
	-- ��Ʈ��ũ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "AutoMatchLobby_userInfo_networkImage")
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
end


function WndAutoMatchClearUserInfo(slot)	
	winMgr:getWindow(slot .. "AutoMatchLobby_userBackImage"):setVisible(false)	
end


local tBattlePosX = { ['protecterr']=0, [0]=50,  140, 240, 340, 839, 746, 654, 550 }
local tBattlePosY = { ['protecterr']=0, [0]=100, 450, 100, 450, 100, 450, 100, 450 }
local g_mySlot = 0
function WndAutoMatch_UpdateUserInfo(slot, mySlot, battleIndex, hostIndex, bTeam, enemyType, level, name, style, relay, network, INFINITE_PING, 
			titleNumber, ladderGrade, flag, roomKind, penalty, emblemKey, ClubTitle , ImageKey, promotion, attribute, bDiffTitleCheck , clubname, bSuperOwner)
	g_mySlot = mySlot
	
	-- 0. �����̹���
	local window = winMgr:getWindow(slot .. "AutoMatchLobby_userBackImage")
	window:setVisible(true)
	window:setPosition(tBattlePosX[battleIndex], tBattlePosY[battleIndex])
	window:setUserString("posX", tostring(tBattlePosX[battleIndex]))
	window:setUserString("posY", tostring(tBattlePosY[battleIndex]))
	
	
	-- �⺻ ����
	if enemyType == 0 then
		window:setTexture("Enabled", "UIData/automatch.tga", 0, 791)
	else
		window:setTexture("Enabled", "UIData/automatch.tga", 152, 791)
	end
	
	-- Īȣ�� Ŭ���� �ϳ��� �������
	if titleNumber > 0 or clubname ~= "" then
		if enemyType == 0 then
			window:setTexture("Enabled", "UIData/automatch.tga", 380, 769)
		else
			window:setTexture("Enabled", "UIData/automatch.tga", 380, 830)
		end
	end
	
	-- Īȣ�� Ŭ���� �Ѵ� ���� ���
	if titleNumber > 0 and clubname ~= "" then
		if enemyType == 0 then
			window:setTexture("Enabled", "UIData/automatch.tga", 532, 769)
		else
			window:setTexture("Enabled", "UIData/automatch.tga", 532, 830)
		end
	end
	
	-- Īȣ�� ������� ũ�⸦ �ٸ��� �Ѵ�.
	if titleNumber > 0 then
		-- Īȣ
		if titleNumber == 26 then	-- Ŭ��Īȣ
			local _window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(true)
			_window2:clearTextExtends()
			_window2:setTextExtends(ClubTitle, g_STRING_FONT_GULIMCHE, 11, 120,200,255,255, 1, 0,0,0,255)
			_window2:setPosition(45, 27)
		elseif titleNumber > 0 and #tTitleFilName >= titleNumber then
			local _window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title2")
			_window:setVisible(true)
			_window2:setVisible(false)
			_window:setTexture("Disabled", "UIData/"..tTitleFilName[titleNumber], tTitleTexX[titleNumber], tTitleTexY[titleNumber])
			_window:setPosition(45, 25)
		else
			local _window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(false)				
		end		

	else
		local _window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title")
		local _window2 = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_title2")
		_window:setVisible(false)
		_window2:setVisible(false)	
	end


	local PosY = 15
	if titleNumber > 0 then
		PosY = 0
	end
	-- ���� Ű
	
	winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setScaleHeight(160)
	
	-- Ŭ�� �̸�
	winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_Clubname"):setTextExtends(clubname, g_STRING_FONT_GULIMCHE, 12, 120,200,255,255, 1, 0,0,0,255)
	winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_Clubname"):setPosition(68, 8+PosY) 
	winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setPosition(45, 5+PosY) 
	
	if emblemKey > 0 then
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setVisible(true) 
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	else
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setVisible(false)
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(slot .. "AutoMatchLobby_clubEmbleImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	
	
	-- �ٸ������� Īȣ
	if bDiffTitleCheck > 0 and ImageKey > 0 then
		if flag == 1 then
			-- Īȣ 
			local titleIndex = titleNumber - 27 
			local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
			local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

			winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setVisible(true)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setVisible(false) 
			winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
			winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		else
			-- �̹��� Ű
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setVisible(true)
			--winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setVisible(false)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		end
	elseif bDiffTitleCheck > 0 then
		-- Īȣ 
		local titleIndex = titleNumber - 27 
		local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
		local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

		winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setVisible(true)
		winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setVisible(false) 
		winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
	else
		-- �̹��� Ű
		if ImageKey > 0 then
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setVisible(true) 
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		else
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setVisible(true)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Enabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
			winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setTexture('Disabled', 'UIData/ItemUIData/Photo_basic.tga', 0, 0)
		end
	end
	winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setScaleWidth(140)
	winMgr:getWindow(slot .. "AutoMatchLobby_profileImage"):setScaleHeight(140)
	winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "AutoMatchLobby_DiffTitleImage"):setScaleHeight(160)
	
	
	
	-- �ɸ�����(�̸�)
	window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_name")
	window:setTextColor(255,255,255,255)
	if slot == mySlot then
		window:setTextColor(255,205,86,255)
	end
	local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(summaryName))
	window:setPosition(98-nameSize/2, 42)
	window:setText(summaryName)
	
	if style < 0 then
		style = 0
	end
	-- ��Ÿ��
	window = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_styleImage")	
	window:setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	window:setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	
	
	local masterWindow = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_masterImage")
	local superMasterWindow1 = winMgr:getWindow(slot .. "AutoMatchLobby_userInfo_superMasterImage1")
	
	if hostIndex == 1 then
		if bSuperOwner == 1 then
			superMasterWindow1:setVisible(true)
			masterWindow:setVisible(false)
		else
			superMasterWindow1:setVisible(false)
			masterWindow:setVisible(true)
		end
	else
		masterWindow:setVisible(false)
	end
	

end

------------------------------------------------

--	��ǳ�� �׸���

------------------------------------------------
function WndAutoMatch_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
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
	local posX	 = 0		-- ��ǳ�� x��ġ
	local posY	 = tChatBubblePosY[chatBubbleType]		-- ��ǳ�� y��ġ
	
	local tailPosY = tChatBubbleTailPosY[chatBubbleType]
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



-- �ʱ� ä��â ����
function SetChatInitAutoMatchLobby()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
end
