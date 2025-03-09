-----------------------------------------
-- 초대 윈도우
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow")




--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
local Dlg_String_InviteDesc = PreCreateString_1093	--GetSStringInfo(LAN_LUA_DLG_INVITE_1)	-- %s님이 %s번방으로 초대하셨습니다.\n승낙 하시겠습니까?
local Dlg_String_RoomEnter	= PreCreateString_1095	--GetSStringInfo(LAN_LUA_DLG_INVITE_3)	-- 방에 접속중입니다.




g_Tick		= -1;
g_CurrTick	= -1;
g_PrevTick	= -1;

-- 초대 메시지 정보를 저장한다.
g_tInviteInfo = {['protecterr'] = 0, RoomNumber = "", RoomName = "", Password = "", CharacterName = "", ServerAddress = ""}

--DebugStr( 'GetTick : ' .. tostring(GetTick()) );



--------------------------------------------------
-- 초대 메시지 박스에 등록되어 있는 랜더링 함수
--------------------------------------------------
function renderInviteMessageBox(args)
	g_CurrTick = GetTick();	
	if  g_CurrTick ~= nil then
		local delta_tick = g_CurrTick - g_PrevTick;
		-- 나중에 현재 지점과 타겟 지점만 지정하면 되게끔 함수만들어야 될듯...	
		if delta_tick > 20000 then
			g_PrevTick = -1;
			winMgr:getWindow('sj_inviteImage'):setVisible(false)
			winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
		end	
	
	end
end



-------------------------------------------------
-- 네트워크 초대 메세지가 왔을때 호출
-------------------------------------------------
function OnInviteInfo(roomNumber, roomName, password, characterName, serverAddress)
	
	if g_PrevTick == -1 then
		
		-- 초청이 왔을 때 이 로직을 사용하면 된다.
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
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends("님이\n", g_STRING_FONT_GULIMCHE,114, 255,255,255,255,   0, 0,0,0,255);
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends(roomNumber, g_STRING_FONT_GULIMCHE,114, 238,203,7,255,   1, 0,0,0,255);
			winMgr:getWindow('sj_inviteImage_desc'):addTextExtends("번방으로 초대하셨습니다.\n승낙 하시겠습니까?", g_STRING_FONT_GULIMCHE,114, 255,255,255,255,   0, 0,0,0,255);
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
-- 테스트용 함수!!! 초대 버튼 눌렀을 때
-------------------------------------------------
function OnInviteButton(args)
	
	-- 초청이 왔을 때 이 로직을 사용하면 된다.
	g_PrevTick = GetTick();
	
	winMgr:getWindow('sj_inviteImage'):setVisible(true)
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
end




-------------------------------------------------
-- 초대된 박스에서 수락 버튼을 눌렀을 때
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
-- 초대된 박스에서 거절 버튼을 눌렀을 때
-------------------------------------------------
function inLua_OnClickedInviteDenied()
	g_PrevTick = -1;
	winMgr:getWindow('sj_inviteImage'):setVisible(false)
	winMgr:getWindow('CommonAlphaPage2'):setVisible(false)
end




-------------------------------------------------
-- 초대 팝업 이미지
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

-- 초대된 박스 ESC키 등록
--RegistEscEventInfo("sj_inviteImage", "CloseInvitedBox")
RegistEscEventInfo("CommonAlphaPage2", "inLua_OnClickedInviteDenied")



-------------------------------------------------
-- 초대된 박스에 있는 텍스트
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
-- 초대 메시지 박스 버튼(수락/거절)
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
-- 알파 이미지
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
-- UI 관련 설정
-------------------------------------------------
-- 초대 메시지 박스에 랜더링 함수를 등록한다. ---------------------------------------------------------------------
mywindow = winMgr:getWindow('sj_inviteImage');
mywindow:subscribeEvent("EndRender", "renderInviteMessageBox" );




