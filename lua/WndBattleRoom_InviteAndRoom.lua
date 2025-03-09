-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)


g_tEscEventWindow_toBattleRoom	= { ["err"]=0 }
g_tEscEventFunction_toBattleRoom = { ["err"]=0 }

local g_STRING_INVITE_1 = PreCreateString_1134	--GetSStringInfo(LAN_LUA_WND_BR_INVITE_1)	-- �ʴ��� ������ ���� �����ϼ���
local g_STRING_INVITE_2 = PreCreateString_1135	--GetSStringInfo(LAN_LUA_WND_BR_INVITE_2)	-- %�Կ��� �ʴ�޼����� ���½��ϴ�.


-- ��, ���� �ִ� �������� ��´�.
local MAX_USERPAGE = WndBattleRoom_GetMaxUserPages()


--------------------------------------------------------------------

-- ��׶��� ���� �̹���

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)




--------------------------------------------------------------------

-- �ʴ��ϱ�

--------------------------------------------------------------------
invitewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_inviteAdjustWindow")
invitewindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 671, 425)
invitewindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 671, 425)
invitewindow:setProperty("FrameEnabled", "False")
invitewindow:setProperty("BackgroundEnabled", "False")
invitewindow:setWideType(6);
invitewindow:setPosition(350, 130)
invitewindow:setSize(331, 453)
invitewindow:setVisible(false)
invitewindow:setAlwaysOnTop(true)
invitewindow:setZOrderingEnabled(false)
root:addChildWindow(invitewindow)

-- ��Ƽ ��ġ ESCŰ ���
RegistEscEventInfo("sj_battleroom_inviteAdjustWindow", "Invite_CANCEL")


-- ���� ���� / �ִ� ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_inviteUserList")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setText("")
mywindow:setPosition(141, 420)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
invitewindow:addChildWindow(mywindow)

function WndBattleRoom_InviteUserPageInfo(curUser, maxUser)
	local userText = tostring((curUser+1).." / "..(maxUser+1))
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, userText)	
	winMgr:getWindow("sj_battleroom_inviteUserList"):setText(userText)
	winMgr:getWindow("sj_battleroom_inviteUserList"):setPosition(170-size/2, 394)
end




for i=0, MAX_USERPAGE-1 do
	-- 1. ���� ����Ʈ(���� ��ư) ����
	userwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_battleroom_inviteUser_RadioBtn")
	userwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 312, 937)
	userwindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", 0, 0)
	userwindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedEnabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedDisabled", "UIData/invisible.tga", 0, 0)
	userwindow:setPosition(11, 78+(i*32))
	userwindow:setSize(308, 23)
	userwindow:setProperty("GroupID", 700)
	userwindow:setZOrderingEnabled(false)
	userwindow:setUserString("UserNumber", i)
	userwindow:subscribeEvent("MouseDoubleClicked", "Invite_OK")
	invitewindow:addChildWindow(userwindow)
	

	-- 2. ���� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_inviteUser_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(5, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)	-- �����ص� �ٸ��͵��� ���õǰ�
	userwindow:addChildWindow(mywindow)


	-- 3. ���� �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_inviteUser_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(52, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 4. ���� ��Ÿ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_inviteUser_style")
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
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_battleroom_inviteUser_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(64, 2)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 6. ���� Ŭ��
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_battleroom_inviteUser_club")
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

end



-- ������ ������
function WndBattleRoom_ClearInviteUserList()
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_RadioBtn"):setVisible(false)
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_level"):setVisible(false)
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_name"):setVisible(false)
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_style"):setVisible(false)
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_ladder"):setVisible(false)
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_club"):setVisible(false)
	end
end




-- ������ ������
function WndBattleRoom_ExistInviteUser(index, realIndex, level, ladder, style, userName, userClub, promotion, attribute, bEnable)

	DebugStr('bEnable:'..bEnable)
	if bEnable == 0 then
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_RadioBtn"):setEnabled(false)
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_level"):setTextColor(170, 170, 170, 255)
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_name"):setTextColor(170, 170, 170, 255)
	else
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_RadioBtn"):setEnabled(true)
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_level"):setTextColor(255, 255, 255, 255)
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_name"):setTextColor(255, 255, 255, 255)
	end
	
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_RadioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_RadioBtn"):setUserString("UserNumber", realIndex)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_level"):setVisible(true)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_name"):setVisible(true)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_style"):setVisible(true)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_ladder"):setVisible(true)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_club"):setVisible(true)
	
	
	-- 2. ���� ����
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_level"):setText(tostring(level))
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_level"):setPosition(46-levelSize/2, 3)
	
	
	-- 3. ���� �̸�
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, userName)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_name"):setText(userName)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_name"):setPosition(182-nameSize/2, 2)
	
	
	-- 4. ���� ��Ÿ��
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_style"):setScaleWidth(190)
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_style"):setScaleHeight(190)
	
	
	-- 5. ���� ����
	winMgr:getWindow(index .. "sj_battleroom_inviteUser_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- 6. ���� Ŭ��
	if userClub == "" then
		winMgr:getWindow(index .. "sj_battleroom_inviteUser_club"):setText("-")
	else
	end
end





--------------------------------------------------------------------

-- ���� ����(ä��, ģ��, Ŭ��) ���� ��ư

--------------------------------------------------------------------
--[[
tUserInfoName = { ["protectErr"]=0, [0]="sj_battleroom_invite_channel", "sj_battleroom_invite_friend", "sj_battleroom_invite_club" }
tUserInfoTexX = { ["protectErr"]=0, [0]=667, 763, 859 }
tUserInfoPosX = { ["protectErr"]=0, [0]=3, 99, 195 }

for i=0, 2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tUserInfoName[i])
	mywindow:setTexture("Normal", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("Hover", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 311)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setPosition(tUserInfoPosX[i], 43)
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
	invitewindow:addChildWindow(mywindow)
end


function ChangeUserInfoList()
	local userList
	for i=0, 2 do
		if CEGUI.toRadioButton(winMgr:getWindow(tUserInfoName[i])):isSelected() then
			userList = winMgr:getWindow(tUserInfoName[i]):getUserString("userInfoList")
		end
	end
	WndBattleRoom_ChangeUserInfoList(tonumber(userList))
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_battleroom_inviteUser_RadioBtn"):setProperty("Selected", "false")
	end
end


function SelectCurrentUserInfoList()
	local userList = WndBattleRoom_GetUserInfoList()
	winMgr:getWindow(tUserInfoName[userList]):setProperty("Selected", "true")
end
SelectCurrentUserInfoList()
--]]



--------------------------------------------------------------------

-- ���� ����Ʈ ���� ��, �� ��ư

--------------------------------------------------------------------
local tUserListLRButtonName  = {["err"]=0, [0]="sj_battleroom_inviteUser_LBtn", "sj_battleroom_inviteUser_RBtn"}
local tUserListLRButtonTexX  = {["err"]=0, [0]=987, 970}
local tUserListLRButtonPosX  = {["err"]=0, [0]=106, 218}
local tUserListLRButtonEvent = {["err"]=0, [0]="ChagneInviteUserList_L", "ChagneInviteUserList_R"}
for i=0, #tUserListLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tUserListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setPosition(tUserListLRButtonPosX[i], 394)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tUserListLRButtonEvent[i])
	invitewindow:addChildWindow(mywindow)
end


-- �븮��Ʈ�� �������� �� �������� ������ �����ؾ� �Ѵ�.
function ChagneInviteUserList_L()
	local currUserNum = WndBattleRoom_GetCurrentUserPage()
	if currUserNum > 0 then
		currUserNum = currUserNum - 1
	end
	WndBattleRoom_GetInviteUserList(tonumber(currUserNum))
end


function ChagneInviteUserList_R()
	local currUserNum = WndBattleRoom_GetCurrentUserPage()
	local maxUserNum  = WndBattleRoom_GetMaxUserPage()
	if currUserNum < maxUserNum then
		currUserNum = currUserNum + 1
	end
	WndBattleRoom_GetInviteUserList(tonumber(currUserNum))
end





--------------------------------------------------------------------

-- �ʴ��ϱ� Ȯ��, ��ҹ�ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_invite_okBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new.tga", 665, 280)
mywindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 665, 309)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 665, 338)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", 665, 280)
mywindow:setPosition(6, 421)
mywindow:setSize(319, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "Invite_OK")
invitewindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_invite_cancleBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(299, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Invite_CANCEL")
invitewindow:addChildWindow(mywindow)


-- �ʴ��ϱ� OK�� ������ ������ ������ �Ǿ��ִ��� Ȯ���� �ʴ�޼����� ������.
function Invite_OK()
	local bSelect = false
	local userNumber
	for i=0, MAX_USERPAGE-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_battleroom_inviteUser_RadioBtn")):isSelected() then
			bSelect = true
			userNumber = winMgr:getWindow(i .. "sj_battleroom_inviteUser_RadioBtn"):getUserString("UserNumber")
		end
	end
	
	-- �������� ��ư�� ������ �Ǿ� ������ �ʴ�޼����� ������ ���õǾ��ִ� ���� ��ư�� �����Ѵ�.
	if bSelect == true then
		Invite_CANCEL()
	
		local inviteUserName = WndBattleRoom_SendInviteMessage(userNumber)
		winMgr:getWindow(userNumber .. "sj_battleroom_inviteUser_RadioBtn"):setProperty("Selected", "false")
		
		if IsKoreanLanguage() then
			WndBattleRoom_WarningMessageEx(inviteUserName, '�Կ���', '�ʴ�޼����� ���½��ϴ�.');
		else
			WndBattleRoom_WarningMessage(string.format(g_STRING_INVITE_2, inviteUserName))
		end
		
	else
		
		ShowNotifyOKMessage_Lua(g_STRING_INVITE_1)
	end
end



-- �ʴ��ϱ� ��ҹ�ư�� ������ �ʴ�â�� �ݰ� ���̻� ���������� ���� �ʴ´�.
function Invite_CANCEL()

	WndBattleRoom_CloseInvite()
	
	winMgr:getWindow("sj_battleroom_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_battleroom_inviteAdjustWindow"):setVisible(false)
end




--------------------------------------------------------------------

-- ���� �ʴ� ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_invite_randomBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 944, 689)
mywindow:setTexture("Hover", "UIData/popup001.tga", 944, 723)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 944, 757)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 944, 689)
mywindow:setPosition(108, 488)
mywindow:setSize(80, 34)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "Invite_Random")
invitewindow:addChildWindow(mywindow)


function Invite_Random()
	Invite_CANCEL()
end









--------------------------------------------------------------------

-- �漳��

--------------------------------------------------------------------
-- �漳�� ����â
roomsetupwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjustWindow")
roomsetupwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
roomsetupwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
roomsetupwindow:setProperty("FrameEnabled", "False")
roomsetupwindow:setProperty("BackgroundEnabled", "False")
roomsetupwindow:setWideType(6);
roomsetupwindow:setPosition(338, 200)
roomsetupwindow:setSize(346, 270)
roomsetupwindow:setVisible(false)
roomsetupwindow:setAlwaysOnTop(true)
roomsetupwindow:setZOrderingEnabled(false)
root:addChildWindow(roomsetupwindow)

-- ��Ʋ�� �漳�� ����â ESCŰ, ENTERŰ ���
RegistEscEventInfo("sj_battleroom_roomAdjustWindow", "RoomSetup_CANCEL")
RegistEnterEventInfo("sj_battleroom_roomAdjustWindow", "RoomSetup_OK")

-- "�漳��" ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_title")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 734)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 734)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 2)
mywindow:setSize(346, 35)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- ������, ��й�ȣ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_roomNameAndpassword")
mywindow:setTexture("Enabled", "UIData/option.tga", 656, 120)
mywindow:setTexture("Disabled", "UIData/option.tga", 656, 120)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 45)
if IsKoreanLanguage() then
	mywindow:setSize(328, 36)
else
	mywindow:setSize(328, 70)
end
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- �ο�����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_userNum")
mywindow:setTexture("Enabled", "UIData/option.tga", 656, 346)
mywindow:setTexture("Disabled", "UIData/option.tga", 656, 346)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 126)
mywindow:setSize(328, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- ���ѽð�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_limitTime")
mywindow:setTexture("Enabled", "UIData/option.tga", 944, 457)
mywindow:setTexture("Disabled", "UIData/option.tga", 944, 457)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 176)
mywindow:setSize(80, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

if WndBattleRoom_GetGameMode() == 8 then
	winMgr:getWindow("sj_battleroom_roomAdjust_limitTime"):setVisible(false)
elseif WndBattleRoom_GetItemMode() == 3 or WndBattleRoom_GetItemMode() == 4 or WndBattleRoom_GetItemMode() == 5 then
	winMgr:getWindow("sj_battleroom_roomAdjust_limitTime"):setVisible(false)
else
	winMgr:getWindow("sj_battleroom_roomAdjust_limitTime"):setVisible(true)
end



------------------------------------------------------

-- �游��� Ȯ��, �游��� ��ҹ�ư

------------------------------------------------------

-- �漳�� Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_roomAdjust_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "RoomSetup_OK")
roomsetupwindow:addChildWindow(mywindow)

function RoomSetup_OK()
	RoomSetup_CANCEL()
	
	roomName	 = winMgr:getWindow("sj_battleroom_roomAdjust_roomTitleWindow"):getText()
	roomPassword = ""	
	if IsKoreanLanguage() == false then
		roomPassword = winMgr:getWindow("sj_battleroom_roomAdjust_passwordWindow"):getText()
	end
	WndBattleRoom_ChangeRoomSetup(nMaxUser, nKillCount, nTimeLimit, roomName, roomPassword)
end


-- �漳�� ��ҹ�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_roomAdjust_cancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(308, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "RoomSetup_CANCEL")
roomsetupwindow:addChildWindow(mywindow)

function RoomSetup_CANCEL()
	winMgr:getWindow("sj_battleroom_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_battleroom_roomAdjustWindow"):setVisible(false)
	
	-- �漳���� ������ ä��â�� Ȱ��ȭ ��Ų��
	winMgr:getWindow("doChatting"):activate()
end





------------------------------------------------------

-- �溯�� ����(4��)

------------------------------------------------------
-- 1. �漳�� ������
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_battleroom_roomAdjust_roomTitleWindow")
mywindow:setPosition(106, 8)
mywindow:setSize(204, 22)
mywindow:setFont(g_STRING_FONT_GULIM, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText("")
mywindow:subscribeEvent("TextAccepted", "RoomSetup_OK")
winMgr:getWindow("sj_battleroom_roomAdjust_roomNameAndpassword"):addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("sj_battleroom_roomAdjust_roomTitleWindow")):setMaxTextLength(32)


-- 2. �漳�� ��й�ȣ
if IsKoreanLanguage() == false then
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_roomAdjust_passwordWindow")
	mywindow:setPosition(106, 43)
	mywindow:setSize(113, 22)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:subscribeEvent("TextAccepted", "RoomSetup_OK")
	winMgr:getWindow("sj_battleroom_roomAdjust_roomNameAndpassword"):addChildWindow(mywindow)
end



-- 3. �漳�� �ο�����
tPersons_team	 = { ["protecterr"]=0, [4]=882, [6]=910, [8]=938 }
tPersons_private = { ["protecterr"]=0, 0, 826, 854, 882, 910, 938, 966, 994 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_userNumImage")
mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(154, 5)
mywindow:setSize(102, 26)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_battleroom_roomAdjust_userNum"):addChildWindow(mywindow)



-- 4. �漳�� ���ѽð�
tLimitTimeImage = { ["err"]=0, 826, 854 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_roomAdjust_limitTimeImage")
mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 680, 854)
mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 680, 854)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(144, 0)
mywindow:setSize(102, 26)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_battleroom_roomAdjust_limitTime"):addChildWindow(mywindow)





--------------------------------------------------------------

-- �ο�����, ��ǥ����, �ð����� L, R ��ư

--------------------------------------------------------------
tLRButtonName  = { ["protecterr"]=0, { ["protecterr"]=0, "sj_battleroom_roomAdjust_userNum_LBtn", "sj_battleroom_roomAdjust_userNum_RBtn" }, 
				 { ["protecterr"]=0, "sj_battleroom_roomAdjust_limittime_LBtn", "sj_battleroom_roomAdjust_limittime_RBtn" } }
tLRButtonTexX  = { ["protecterr"]=0, 987, 970 }
tLRButtonPosX  = { ["protecterr"]=0, 134, 270 }
tLRButtonPosY  = { ["protecterr"]=0, 134, 177 }
tLRButtonEvent = { ["protecterr"]=0, { ["protecterr"]=0, "ChangeLUserNum", "ChangeRUserNum" }, 
				 { ["protecterr"]=0, "ChangeLTimeNum", "ChangeRTimeNum" } }

for i=1, 2 do
for j=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLRButtonName[i][j])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tLRButtonTexX[j], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tLRButtonTexX[j], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tLRButtonTexX[j], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tLRButtonTexX[j], 0)
	mywindow:setPosition(tLRButtonPosX[j], tLRButtonPosY[i])
	mywindow:setSize(17, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLRButtonEvent[i][j])
	roomsetupwindow:addChildWindow(mywindow)
	
	if WndBattleRoom_GetGameMode() == 8 then
		if i == 2 then
			if j == 1 or j == 2 then
				mywindow:setVisible(false)
			end
		end
	elseif WndBattleRoom_GetItemMode() == 3 or WndBattleRoom_GetItemMode() == 4 or WndBattleRoom_GetItemMode() == 5 then -- ��ź��, �̴�Ÿ����
		mywindow:setVisible(false)
	else
		mywindow:setVisible(true)
	end
end
end

------------------------------

-- �ο�����

------------------------------
function ChangeLUserNum()
	if bTeam == 1 then
		-- �������� ���
		if WndBattleRoom_GetGameMode() == 8 or 
			WndBattleRoom_GetItemMode() == 3 or
			WndBattleRoom_GetItemMode() == 4 or
			WndBattleRoom_GetItemMode() == 5 then
			
			if nMaxUser == 6 then nMaxUser = 8
			else nMaxUser = nMaxUser - 2
			end
		else
			if nMaxUser == 4 then nMaxUser = 8
			else nMaxUser = nMaxUser - 2
			end
		end
	else
		if nMaxUser == 2 then nMaxUser = 8
		else nMaxUser = nMaxUser - 1
		end
	end	
	ChangeUser()
end

function ChangeRUserNum()
	if bTeam == 1 then
		-- �������� ���
		if WndBattleRoom_GetGameMode() == 8 or 
			WndBattleRoom_GetItemMode() == 3 or
			WndBattleRoom_GetItemMode() == 4 or
			WndBattleRoom_GetItemMode() == 5 then
			
			if nMaxUser == 8 then nMaxUser = 6
			else nMaxUser = nMaxUser + 2
			end
		else
			if nMaxUser == 8 then nMaxUser = 4
			else nMaxUser = nMaxUser + 2
			end
		end
	else
		if nMaxUser == 8 then nMaxUser = 2
		else nMaxUser = nMaxUser + 1
		end
	end
	ChangeUser()
end

function ChangeUser()
	if bTeam == 1 then
		winMgr:getWindow("sj_battleroom_roomAdjust_userNumImage"):setTexture("Disabled", "UIData/battleroom001.tga", 680, tPersons_team[nMaxUser])
	else
		winMgr:getWindow("sj_battleroom_roomAdjust_userNumImage"):setTexture("Disabled", "UIData/battleroom001.tga", 574, tPersons_private[nMaxUser])
	end
end





------------------------------

-- ���ѽð�

------------------------------
function ChangeLTimeNum()
	if nTimeLimit == 1 then
		nTimeLimit = 2
	elseif nTimeLimit == 2 then
		nTimeLimit = 1
	end
	ChangeLimitTime()
end

function ChangeRTimeNum()
	if nTimeLimit == 2 then
		nTimeLimit = 1
	elseif nTimeLimit == 1 then
		nTimeLimit = 2
	end
	ChangeLimitTime()
end

function ChangeLimitTime()
	-- �������� ���
	if WndBattleRoom_GetGameMode() == 8 then
		winMgr:getWindow("sj_battleroom_roomAdjust_limitTimeImage"):setVisible(false)
	else
		winMgr:getWindow("sj_battleroom_roomAdjust_limitTimeImage"):setVisible(true)
		winMgr:getWindow("sj_battleroom_roomAdjust_limitTimeImage"):setTexture("Disabled", "UIData/battleroom001.tga", 680, tLimitTimeImage[nTimeLimit])
	end
end







--------------------------------------------------------------------

-- �����޼���(C���� ȣ��)

--------------------------------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_error_alphaWindow")
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


-- ���� ����â
errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_error_backWindow")
errorwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
errorwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
errorwindow:setProperty("FrameEnabled", "False")
errorwindow:setProperty("BackgroundEnabled", "False")
errorwindow:setWideType(6)
errorwindow:setPosition(338, 246)
errorwindow:setSize(346, 275)
errorwindow:setVisible(false)
errorwindow:setAlwaysOnTop(true)
errorwindow:setZOrderingEnabled(false)
root:addChildWindow(errorwindow)

-- ��Ƽ ��ġ ESCŰ ���
RegistEscEventInfo("sj_battleroom_error_backWindow", "BattleRoomErrorOK")

-- ���� ����â
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battleroom_error_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 126)
mywindow:setSize(349, 100)
mywindow:setAlwaysOnTop(true)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:clearTextExtends()
errorwindow:addChildWindow(mywindow)

-- ���� Ȯ�ι�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_error_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BattleRoomErrorOK")
errorwindow:addChildWindow(mywindow)


function BattleRoomErrorOK()
	winMgr:getWindow("sj_battleroom_error_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_battleroom_error_backWindow"):setVisible(false)
	winMgr:getWindow("sj_battleroom_error_descWindow"):setText("")
	
	-- ����OK�� ������ ä��â�� Ȱ��ȭ ��Ų��
	winMgr:getWindow("doChatting"):setEnabled(true)
end


function WndBattleRoom_WarningMessage(errorMessgae)
	winMgr:getWindow("sj_battleroom_error_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_battleroom_error_backWindow"):setVisible(true)
	winMgr:getWindow("sj_battleroom_error_descWindow"):setTextExtends(errorMessgae, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
end



function WndBattleRoom_WarningMessageEx(errorMessage0, errorMsg1, errorMsg2)

	winMgr:getWindow("sj_battleroom_error_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_battleroom_error_backWindow"):setVisible(true)
	
	winMgr:getWindow("sj_battleroom_error_descWindow"):setPosition(0, 120)
	winMgr:getWindow("sj_battleroom_error_descWindow"):clearTextExtends()
	winMgr:getWindow("sj_battleroom_error_descWindow"):setViewTextMode(1)
	winMgr:getWindow("sj_battleroom_error_descWindow"):setAlign(8)
	winMgr:getWindow("sj_battleroom_error_descWindow"):setLineSpacing(7);
	winMgr:getWindow("sj_battleroom_error_descWindow"):addTextExtends(errorMessage0, g_STRING_FONT_DODUM,15, 255,205,86,255,   1, 0,0,0,255)
	winMgr:getWindow("sj_battleroom_error_descWindow"):addTextExtends('�Կ���\n', g_STRING_FONT_DODUM,115, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("sj_battleroom_error_descWindow"):addTextExtends(''.. errorMsg2, g_STRING_FONT_DODUM,115, 255,255,255,255,   0, 0,0,0,255)
	
	winMgr:getWindow("sj_battleroom_error_descWindow"):setVisible(true)
end




--------------------------------------------------------------------

-- ������ ���� ������

--------------------------------------------------------------------
local tClassName = {["err"]=0,	[0]="class_TaeKwonDo",	"class_Boxing",		"class_MuayThai",	"class_Capoera",
								"class_ProWrestling",	"class_Judo",		"class_Hapgido",	"class_Sambo"}
								
local tTransformName = {["err"]=0, [0]="t_singo", "t_violet", "t_muffin", "t_hRose", "t_crown"}
						
-- esc�� â�� ���ֱ� ���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_freeZone_emptyWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("sj_battleroom_freeZone_emptyWindow", "ClickedFreeZoneSelectCancel")
		
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_freeZone_alphaWindow")
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


-- ������ ���� ��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_freeZone_backWindow")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);

if WndBattleRoom_IsFreeZoneNormal() == true then
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 0, 510)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 0, 510)
	mywindow:setPosition(212, 236)
	mywindow:setSize(597, 296)
else
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 0, 0)
	mywindow:setPosition(212, 129)
	mywindow:setSize(597, 510)
end

mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_battleroom_freeZone_alphaWindow"):addChildWindow(mywindow)

function CallFreeZoneSelect(bShow)
	root:addChildWindow(winMgr:getWindow("sj_battleroom_freeZone_alphaWindow"))
	winMgr:getWindow("sj_battleroom_freeZone_alphaWindow"):setVisible(bShow)
	
	if WndBattleRoom_GetChangingFreeZone() then
		winMgr:getWindow("sj_battleroom_freeZone_emptyWindow"):setVisible(true)
		winMgr:getWindow("sj_battleroom_freezoneCancelBtn"):setVisible(true)
	else
		winMgr:getWindow("sj_battleroom_freeZone_emptyWindow"):setVisible(false)
		winMgr:getWindow("sj_battleroom_freezoneCancelBtn"):setVisible(false)
	end
end


-- Ŭ���� ����
local g_selectClass = -1
local tClassPosX = {["err"]=0, [0]=0, 69, 138, 207, 276, 345, 414, 483}
for i=0, #tClassName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tClassName[i])
	mywindow:setTexture("Normal", "UIData/Event_ClassImage.tga", tClassPosX[i], 0)
	mywindow:setTexture("Hover", "UIData/Event_ClassImage.tga", tClassPosX[i], 174)
	mywindow:setTexture("Pushed", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("PushedOff", "UIData/Event_ClassImage.tga", tClassPosX[i], 0)
	mywindow:setTexture("SelectedNormal", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedHover", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedPushed", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedPushedOff", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setSize(69, 174)
	mywindow:setProperty("GroupID", 7771)
	mywindow:setPosition((i*70)+19, 74)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedClass")
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ClassInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ClassInfo")
	winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)
end

local tClassNamePosY = {["err"]=0, [0]=0, 20, 40, 60, 80, 100, 120, 140}
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_freeZone_classDescImage")
mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(460, 52)
mywindow:setSize(111, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)

function OnSelectedClass(args)
	for i=0, #tClassName do
		if CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):isSelected() then
			local szIndex = winMgr:getWindow(tClassName[i]):getUserString("index")
			if szIndex ~= "" then
				g_selectClass = tonumber(szIndex)
				CheckFreeZoneSelectBtn()
				return
			end
		end
	end
end

function OnMouseEnter_ClassInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tClassNamePosY then
			winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[index])
			winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[index])
		end
	end
end

function OnMouseLeave_ClassInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tClassNamePosY then
			if g_selectClass >= 0 then
				winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[g_selectClass])
				winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[g_selectClass])
			else
				winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
				winMgr:getWindow("sj_battleroom_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
			end
		end
	end
end


if WndBattleRoom_IsFreeZoneNormal() == false then
	-- ���� ����
	local g_selecttransformIndex = -1
	local tTransformPosX = {["err"]=0, [0]=552, 621, 690, 759, 828}
	for i=0, #tTransformName do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", tTransformName[i])
		mywindow:setTexture("Normal", "UIData/Event_ClassImage.tga", tTransformPosX[i], 0)
		mywindow:setTexture("Hover", "UIData/Event_ClassImage.tga", tTransformPosX[i], 174)
		mywindow:setTexture("Pushed", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("PushedOff", "UIData/Event_ClassImage.tga", tTransformPosX[i], 0)
		mywindow:setTexture("SelectedNormal", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedHover", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedPushed", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedPushedOff", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setSize(69, 174)
		mywindow:setProperty("GroupID", 7772)
		mywindow:setPosition((i*70)+19, 286)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("index", tostring(i))
		mywindow:subscribeEvent("SelectStateChanged", "OnSelectedTransform")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_TransformInfo")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_TransformInfo")
		winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)
	end

	local tTransformNamePosY = {["err"]=0, [0]=200, 220, 240, 260, 280}
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroom_freeZone_transformDescImage")
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(460, 264)
	mywindow:setSize(111, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)
end

function OnSelectedTransform(args)
	for i=0, #tTransformName do
		if CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):isSelected() then
			local szIndex = winMgr:getWindow(tTransformName[i]):getUserString("index")
			if szIndex ~= "" then
				g_selecttransformIndex = tonumber(szIndex)
				CheckFreeZoneSelectBtn()
				return
			end
		end
	end
end

function OnMouseEnter_TransformInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tTransformNamePosY then
			winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[index])
			winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[index])
		end
	end
end

function OnMouseLeave_TransformInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tTransformNamePosY then
			if g_selecttransformIndex >= 0 then
				winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[g_selecttransformIndex])
				winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[g_selecttransformIndex])
			else
				winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
				winMgr:getWindow("sj_battleroom_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
			end
		end
	end
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_freezoneOkBtn")
mywindow:setTexture("Normal", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Hover", "UIData/profile001.tga", 813, 351)
mywindow:setTexture("Pushed", "UIData/profile001.tga", 813, 378)
mywindow:setTexture("PushedOff", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Enabled", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Disabled", "UIData/profile001.tga", 813, 405)

if WndBattleRoom_IsFreeZoneNormal() == true then
	mywindow:setPosition(506, 261)
else
	mywindow:setPosition(506, 475)
end

mywindow:setSize(81, 27)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelectOK")
winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_battleroom_freezoneCancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(565, 10)
mywindow:setSize(23, 23)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelectCancel")
winMgr:getWindow("sj_battleroom_freeZone_backWindow"):addChildWindow(mywindow)

function ClickedFreeZoneSelectOK()

	CallFreeZoneSelect(false)
	
	if WndBattleRoom_IsFreeZoneNormal() == true then
		g_selecttransformIndex = 0
	end
	
	WndBattleRoom_SetFullSkill(g_selectClass, g_selecttransformIndex)
	winMgr:getWindow("sj_battleroom_freeZone_emptyWindow"):setVisible(false)
end

function ClickedFreeZoneSelectCancel()
	CallFreeZoneSelect(false)
	winMgr:getWindow("sj_battleroom_freeZone_emptyWindow"):setVisible(false)
	local currentClass, currentTransformIndex = WndBattleRoom_GetFullSkillInfo()
	if currentClass >= 0 and currentTransformIndex >= 0 then
		for i=0, #tClassName do
			if i == currentClass then
				CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):setSelected(true)
			else
				CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):setSelected(false)
			end
		end
		
		for i=0, #tTransformName do
			if i == currentTransformIndex then
				CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):setSelected(true)
			else
				CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):setSelected(false)
			end
		end
	end
end

function CheckFreeZoneSelectBtn()

	if WndBattleRoom_IsFreeZoneNormal() == true then
		if g_selectClass >= 0 then
			winMgr:getWindow("sj_battleroom_freezoneOkBtn"):setEnabled(true)
		else
			winMgr:getWindow("sj_battleroom_freezoneOkBtn"):setEnabled(false)
		end
	else
		if g_selectClass >= 0 and g_selecttransformIndex >= 0 then
			winMgr:getWindow("sj_battleroom_freezoneOkBtn"):setEnabled(true)
		else
			winMgr:getWindow("sj_battleroom_freezoneOkBtn"):setEnabled(false)
		end
	end
end
