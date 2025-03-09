-----------------------------------------
-- �ʴ� ������
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow")




--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�(���ö���¡)
--------------------------------------------------------------------
local Dlg_String_InviteDesc = PreCreateString_1093	--GetSStringInfo(LAN_LUA_DLG_INVITE_1)	-- %s���� %s�������� �ʴ��ϼ̽��ϴ�.\n�³� �Ͻðڽ��ϱ�?
local Dlg_String_RoomEnter	= PreCreateString_1095	--GetSStringInfo(LAN_LUA_DLG_INVITE_3)	-- �濡 �������Դϴ�.




g_Tick		= -1;
g_CurrTick	= -1;
g_PrevTick	= -1;

-- �ʴ� �޽��� ������ �����Ѵ�.
g_tInviteInfo = {['protecterr'] = 0, RoomNumber = "", RoomName = "", Password = "", CharacterName = "", ServerAddress = ""}

--DebugStr( 'GetTick : ' .. tostring(GetTick()) );



--------------------------------------------------
-- �ʴ� �޽��� �ڽ��� ��ϵǾ� �ִ� ������ �Լ�
--------------------------------------------------
function renderInviteMessageBox(args)
	g_CurrTick = GetTick();	
	if  g_CurrTick ~= nil then
		local delta_tick = g_CurrTick - g_PrevTick;
		-- ���߿� ���� ������ Ÿ�� ������ �����ϸ� �ǰԲ� �Լ������� �ɵ�...	
		if delta_tick > 20000 then
			g_PrevTick = -1;
			winMgr:getWindow('sj_inviteImage'):setVisible(false)
			winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
		end	
	
	end
end



-------------------------------------------------
-- ��Ʈ��ũ �ʴ� �޼����� ������ ȣ��
-------------------------------------------------
function OnInviteInfo(roomNumber, roomName, password, characterName, serverAddress)
	
	if g_PrevTick == -1 then
		
		-- ��û�� ���� �� �� ������ ����ϸ� �ȴ�.
		g_PrevTick = GetTick();

		if type(serverAddress) == "string" then
			g_tInviteInfo["ServerAddress"]		= serverAddress
		end
		
		g_tInviteInfo["RoomNumber"]		= tostring(roomNumber)
		g_tInviteInfo["RoomName"]		= roomName
		g_tInviteInfo["Password"]		= password
		g_tInviteInfo["CharacterName"]	= characterName
		winMgr:getWindow('sj_inviteImage'):setVisible(true)
		winMgr:getWindow('CommonAlphaPage2'):setVisible(true)
		
		if IsKoreanLanguage() then
			winMgr:getWindow('sj_inviteImage_desc'):clearTextExtends();
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends(characterName, g_STRING_FONT_GULIMCHE,114, 238,203,7,255,   1, 0,0,0,255);
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends("����\n", g_STRING_FONT_GULIMCHE,114, 255,255,255,255,   0, 0,0,0,255);
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends(roomNumber, g_STRING_FONT_GULIMCHE,114, 238,203,7,255,   1, 0,0,0,255);
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends("�������� �ʴ��ϼ̽��ϴ�.\n�³� �Ͻðڽ��ϱ�?", g_STRING_FONT_GULIMCHE,114, 255,255,255,255,   0, 0,0,0,255);
		else
			local str = string.format(Dlg_String_InviteDesc, characterName, roomNumber)
			if type(serverAddress) == "string" then
				str = "[MatchMaking] " .. str
			end
			winMgr:getWindow('sj_inviteImage_desc'):clearTextExtends()
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends(str, g_STRING_FONT_GULIMCHE,114, 255,255,255,255,   0, 0,0,0,255);
		end
	end	
end	

function SetTick(args)
	g_Tick = args;
end



-------------------------------------------------
-- �׽�Ʈ�� �Լ�!!! �ʴ� ��ư ������ ��
-------------------------------------------------
function OnInviteButton(args)
	
	-- ��û�� ���� �� �� ������ ����ϸ� �ȴ�.
	g_PrevTick = GetTick();
	
	winMgr:getWindow('sj_inviteImage'):setVisible(true)
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
end




-------------------------------------------------
-- �ʴ�� �ڽ����� ���� ��ư�� ������ ��
-------------------------------------------------
function inLua_OnClickedInviteAccepted()
	if g_tInviteInfo["ServerAddress"] == "" then
		OnClickedInviteAccepted(g_tInviteInfo["CharacterName"]);
	else
		OnClickedMatchMakingInviteAccepted();
	end
	winMgr:getWindow('sj_inviteImage'):setVisible(false)
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
	g_PrevTick = -1;
	ShowNotifyMessage(Dlg_String_RoomEnter)
end



-------------------------------------------------
-- �ʴ�� �ڽ����� ���� ��ư�� ������ ��
-------------------------------------------------
function inLua_OnClickedInviteDenied()
	g_PrevTick = -1;
	winMgr:getWindow('sj_inviteImage'):setVisible(false)
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
end




-------------------------------------------------
-- �ʴ� �˾� �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'sj_inviteImage');
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0)
mywindow:setProperty("FrameEnabled", 'false')
mywindow:setProperty("BackgroundEnabled", 'false')
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

function CloseInvitedBox()
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
end

-- �ʴ�� �ڽ� ESCŰ ���
--RegistEscEventInfo("sj_inviteImage", "CloseInvitedBox")
RegistEscEventInfo("CommonAlphaPage2", "inLua_OnClickedInviteDenied")



-------------------------------------------------
-- �ʴ�� �ڽ��� �ִ� �ؽ�Ʈ
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_inviteImage_desc")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIM, 12)
mywindow:setPosition(92, 120)
mywindow:setSize(170, 90)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow('sj_inviteImage'):addChildWindow(mywindow)




-------------------------------------------------
-- �ʴ� �޽��� �ڽ� ��ư(����/����)
-------------------------------------------------
tWinName		= {['err'] = 0, "sj_invite_okBtn", "sj_invite_cancelBtn"}
tEventHandler	= {['err'] = 0, "inLua_OnClickedInviteAccepted", "inLua_OnClickedInviteDenied"}
tTextureX		= {['err'] = 0, 693, 858}
tpositionY		= {['err'] = 0, 4, 169}
for i=1, #tWinName do	
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTextureX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], 849)	
	mywindow:setSize(166, 29)
	mywindow:setPosition(tpositionY[i], 235)
	mywindow:subscribeEvent("Clicked", tEventHandler[i])
	winMgr:getWindow('sj_inviteImage'):addChildWindow(mywindow)
end



-------------------------------------------------
-- ���� �̹���
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlphaPage2')
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)	
mywindow:setProperty("FrameEnabled", "false")	
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(1920, 1200)
mywindow:setPosition(0, 0)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)	

winMgr:getWindow('CommonAlphaPage2'):addChildWindow(winMgr:getWindow('sj_inviteImage'));



-------------------------------------------------
-- UI ���� ����
-------------------------------------------------
-- �ʴ� �޽��� �ڽ��� ������ �Լ��� ����Ѵ�. ---------------------------------------------------------------------
mywindow = winMgr:getWindow('sj_inviteImage');
mywindow:subscribeEvent("EndRender", "renderInviteMessageBox" );




