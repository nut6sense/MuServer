guiSystem	= CEGUI.System:getSingleton()
winMgr		= CEGUI.WindowManager:getSingleton()
mouseCursor = CEGUI.MouseCursor:getSingleton()
root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


pos_off = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
pos_on = PreCreateString_1179	--GetSStringInfo(LAN_LUA_WND_MESSENGER_11)



root:addChildWindow(winMgr:getWindow('bj_messengerBackWindow'))
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('FriendListNumText'))
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('BestFriendListNumText'))


function SettingBestFriendNum(Current, Max)
	DebugStr('SettingBestFriendNum')
	winMgr:getWindow('BestFriendListNumText'):setText(Current.." / "..Max)
	local find_window = winMgr:getWindow('BestFriendBuffImage')
	if find_window ~= nil then
		winMgr:getWindow('BestFriendBuffCount'):clearTextExtends();
		winMgr:getWindow('BestFriendBuffCount'):setText(Current)
		winMgr:getWindow('BestFriendBuffCount'):addTextExtends(Current, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     1,     0,0,0,255);
		if Current < 1 then
			winMgr:getWindow('BestFriendBuffImage'):setVisible(false)
		else
			winMgr:getWindow('BestFriendBuffImage'):setVisible(true)
		end
	end
end

function SettingFriendNum(Current, Max)
	winMgr:getWindow('FriendListNumText'):setText(Current.." / "..Max)
end

RegistEscEventInfo("bj_messengerBackWindow", "OnClickClose")


-----------------------------------------------
-- 메신저 말풍선, 효과 셋팅
-----------------------------------------------
winMgr:getWindow('sj_tab_chat'):addChildWindow(winMgr:getWindow('sj_chat_effect'))
winMgr:getWindow('sj_chat_effect'):setVisible(false)


-----------------------------------------------------------------------
-- 친구 추가를 요청
-----------------------------------------------------------------------
function OnRequestFriendOK(name)

	local systemMessage = '[!] '..string.format(PreCreateString_2920, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_1)
	if name ~= "" then
	SeparatesProperly('', systemMessage, 5)
	end
	
end


-----------------------------------------------------------------------
-- 친구 추가했는데 상대방이 거절했을때 받는 이벤트(친구 추가 요청하는 사람이 받는 이벤트)
-----------------------------------------------------------------------
function OnFriendDenyMsg(msg)
	local systemMessage = '[!] '..string.format(PreCreateString_2923,msg)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_6)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- 친구 추가했는데 상대방이 수락했을때 받는 이벤트(친구 추가 요청하는 사람이 받는 이벤트)
-----------------------------------------------------------------------
function OnFriendAgree(name)
	local systemMessage = '[!] '..string.format(PreCreateString_2921, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_3)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- 친추 정보가 변경 됐을때 받는 이벤트 디버깅용
-----------------------------------------------------------------------
function OnFriendInfoChanged(name)
	if GetCurWindowName() == 'village' then
		--OnChatPublicWithName('', '[!] '..name..' 님이 정보가 되었습니다.', 5);
	end
end

-----------------------------------------------------------------------
-- 친구 삭제
-----------------------------------------------------------------------
function OnFriendDelete(name)
	local systemMessage = '[!] '..string.format(PreCreateString_2922, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_4)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- 친구추가가 되었을때
-----------------------------------------------------------------------
function OnFriendAdd(name)
	--local systemMessage = '[!] '..name..'님이 친구로 추가 되었습니다.'
	local systemMessage = '[!] '..string.format(PreCreateString_2921, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_3)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------

-- 현재 위치에 메세지를 보낸다.

-----------------------------------------------------------------------
function SeparatesProperly(msg1, msg2, state)
	if GetCurWindowName() == 'village' then
		OnChatPublicWithName(msg1, msg2, state)
	else
		OnChatPublic(msg2, state)
	end
end



-----------------------------------------------------------------------

-- AlertBox 관련

-----------------------------------------------------------------------
function OnClickAlertOkSelfHide(args)	
	
	if winMgr:getWindow('CommonAlertOkBox') then
		DebugStr('OnClickAlertOkSelfHide start');
		local okFunc = winMgr:getWindow('CommonAlertOkBox'):getUserString("okFunction")
		if okFunc ~= "OnClickAlertOkSelfHide" then
			return
		end
		winMgr:getWindow('CommonAlertOkBox'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkBox')
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)		
		DebugStr('OnClickAlertOkSelfHide end');
	end
end

function OnClickQuestOk(args)
	DebugStr('OnClickQuestOk start');
	DebugStr('OnClickQuestOk end');
end

function OnClickQuestCancel(args)
	DebugStr('OnClickQuestCancel start');
	DebugStr('OnClickQuestCancel end');
	winMgr:getWindow('CommonAlertOkCancelBox'):setVisible(false);
end

function OnAcceptAlertEditText(args)
	DebugStr('OnAcceptAlertEditText start');
	DebugStr('OnAcceptAlertEditText end');
end




-----------------------------------------------------------------------
-- 친구 추가 에디트 박스에서 확인 눌렀을 때
-----------------------------------------------------------------------
function OnClickFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('name : ' .. winMgr:getWindow('CommonAlertEditBox'):getText());
		OnRequestFriendOK(winMgr:getWindow('CommonAlertEditBox'):getText())
		local bRet = RequestNewFriend( winMgr:getWindow('CommonAlertEditBox'):getText(), 5 );
		
	end
end

-----------------------------------------------------------------------
-- 절친 추가 에디트 박스에서 확인 눌렀을 때
-----------------------------------------------------------------------
function OnClickBestFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickBestFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setProperty('Visible', 'False');
		
		DebugStr('name : ' .. g_FriendDeleteSaveName);
		RegistBestFriend(g_FriendDeleteSaveName)
		g_FriendDeleteSaveName = '';
	end
end

-----------------------------------------------------------------------
-- 절친 추가 에디트 박스에서 취소 눌렀을 때
-----------------------------------------------------------------------
function OnClickBestFriendAddQuestCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickBestFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickBestFriendAddQuestCancel end');
	end
end

-----------------------------------------------------------------------
-- 친구 추가 에디트 박스에서 확인 눌렀을 때
-----------------------------------------------------------------------
function OnClickFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('name : ' .. winMgr:getWindow('CommonAlertEditBox'):getText());
		OnRequestFriendOK(winMgr:getWindow('CommonAlertEditBox'):getText())
		local bRet = RequestNewFriend( winMgr:getWindow('CommonAlertEditBox'):getText(), 5 );
		
	end
end



-----------------------------------------------------------------------
-- 친구 추가 에디트 박스에서 취소 눌렀을 때
-----------------------------------------------------------------------
function OnClickFriendAddQuestCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("noFunction")
		if nofunc ~= "OnClickFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );   --한줄
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickFriendAddQuestCancel end');
	end
end



-----------------------------------------------------------------------

-- 친구 추가 상대 에디트 박스에서 엔터 쳤을때 -- 이것도 친구 추가 해준다.

-----------------------------------------------------------------------
function OnAcceptFriendAddEditText(args)

end


-----------------------------------------------------------------------
-- 친구 추가 확인 버튼을 눌렀을 때
-----------------------------------------------------------------------
function OnClickReceiveFriendAddQuestOk(args)
     
   if winMgr:getWindow('CommonAlertOkCancelBox2') then
		DebugStr('OnClickReceiveFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox2'):getUserString("okFunction")
		if okfunc ~= "OnClickReceiveFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox2'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('FriendAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('FriendAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox2');
		winMgr:getWindow('FriendAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		ConfirmNewFriend(g_uSaveSerialNo, 'yes',g_FriendName);
		OnFriendAgree(g_FriendName);
		DebugStr('OnClickReceiveFriendAddQuestOk end');
		QueueName=GetQueueNumber();
		if QueueName == "" then
		return 
		end
		OnNewFriendEvent(QueueName, 0 )
	end
end


-----------------------------------------------------------------------

-- 친구 추가 취소 버튼을 눌렀을 때

-----------------------------------------------------------------------

function OnClickReceiveFriendAddQuestCancel(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBox2') then
		DebugStr('OnClickReceiveFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox2'):getUserString("noFunction")
		if nofunc ~= "OnClickReceiveFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox2'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('FriendAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('FriendAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox2');
		winMgr:getWindow('FriendAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)	
		ConfirmNewFriend(g_uSaveSerialNo, 'no', g_FriendName);
		QueueName=GetQueueNumber();
		if QueueName == "" then
		return 
		end
		OnNewFriendEvent(QueueName, 0 )
	end
end



function OnClickLoginOk(args)   -- N
	DebugStr('OnClickLoginOk start');
	winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):setVisible(false);
	local id = winMgr:getWindow('CommonAlertEditBoxid'):getText();
	local pwd = winMgr:getWindow('CommonAlertEditBoxpassword'):getText();
	local game_type = tonumber( winMgr:getWindow('CommonAlertEditBoxgametype'):getText() );
	DebugStr('id : ' .. id);
	DebugStr('pwd : ' .. pwd);
	DebugStr('game_type : ' .. tostring(game_type));
	InitializeMessenger(id, pwd, game_type);
	DebugStr('OnClickLoginOk end');
end

function OnClickLoginCancel(args)  --N
	DebugStr('OnClickLoginCancel start');
	winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):setVisible(false);
	DebugStr('OnClickLoginCancel end');
end

function OnAcceptLogin(args)  --N
	DebugStr('OnAcceptLogin start');
	DebugStr('OnAcceptLogin end');
end



function OnGuildChatRoomMessageReceived(name, message)
	DebugStr('OnGuildChatRoomMessageReceived start');
	DebugStr('name : ' .. name .. ', message : ' .. message);	
	
	local multi_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow('multichat_list_7'));
	
	
	DebugStr('multi_line_text:getLineCount() : ' .. tostring(multi_line_text:getLineCount()));
	if multi_line_text:getLineCount() > 50 then
		multi_line_text:removeLine(0);
	else
	end		
	
	
	local view_name = '';
	if name == '알림' then -- 이름이 빈칸으로 왔으면
		view_name = '알림 : ';
	elseif name == '' then
		view_name = '';
	else
		view_name = '['..name..']'..' : ';
	end
	
	chatType = -1;
	if chatType == -1 then		-- 1: 자신(흰색)
		multi_line_text:addTextExtends(view_name..message..'\n',ChatMySelfFontData[1],ChatMySelfFontData[2], 
										ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],ChatMySelfFontData[6],   
										ChatMySelfFontData[7], 
										ChatMySelfFontData[8],ChatMySelfFontData[9],ChatMySelfFontData[10],ChatMySelfFontData[11]);
	elseif chatType == 1 then
	end
										
										
										
	DebugStr('OnGuildChatRoomMessageReceived end');
end



-----------------------------------------------------------
-- 네트워크로 이벤트 올때 불려지는 함수 cpp에서 호출 된다.
-----------------------------------------------------------
g_uSaveSerialNo = -1;
g_FriendName = ''
function OnNewFriendEvent(name, uSerialNo)
	DebugStr('name:'..name)
	g_uSaveSerialNo = uSerialNo;
	g_FriendName = name
	ShowCommonAlertRejectBoxWithFunction("", string.format(PreCreateString_1176, name), 'OnClickReceiveFriendAddQuestOk', 'OnClickReceiveFriendAddQuestCancel');
end															--GetSStringInfo(LAN_LUA_WND_MESSENGER_8)


function OnServerMessageEvent(msg, ...)
	if select('#', ...) == 0 then
		ShowCommonAlertOkBoxWithFunction(msg, 'OnClickAlertOkSelfHide');		
	else
		local emphasis = select(1, ...)
		ShowCommonAlertOkBoxWithFunctionEmphasis(emphasis, msg, 'OnClickAlertOkSelfHide')
	end
end

function OnCustomMessageEvent(msg)
	ShowCommonAlertOkBoxWithFunction(msg, 'OnClickAlertOkSelfHide');
end

function OnMessengerReplyEvent(msg)
	ShowCommonAlertOkBoxWithFunction(msg, 'OnClickAlertOkSelfHide');
end



tUserButtonName =
{ ["protecterr"]=0, "sj_friendListBtn_1", "sj_friendListBtn_2", "sj_friendListBtn_3", "sj_friendListBtn_4", "sj_friendListBtn_5", 
					"sj_friendListBtn_6", "sj_friendListBtn_7", "sj_friendListBtn_8", "sj_friendListBtn_9", "sj_friendListBtn_10" }

-- 라디오 버튼 당 달리는 StaticText들(레벨, 캐릭터명, 클래스, 위치, 정보보기)
tUserInfoTextName = {['protecterr'] = 0, 'LevelText', 'CharNameText', 'PosText', 'InfoBtn' }

for i=1, #tUserButtonName do
	
	winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow(tUserButtonName[i]));
	
	for j=1, #tUserInfoTextName do
		winMgr:getWindow(tUserButtonName[i]):addChildWindow(winMgr:getWindow(tUserButtonName[i]..tUserInfoTextName[j]));
	end
end


-- 현재 선택한 탭 (1.친구, 2.파티,  3.길드, 4.대화탭 중에 하나)
g_CurSelectMainTap = 1;

g_CurFriendListPage = 1;
g_TotalFriendListPage = 5;
g_PageSize = 10;

function RefreshFriendList(selected)	-- selected 인자는 선택된것을 계속 유지 할것인가 말것인가다(유저리스트 라디오 박스로 되어있으므로)

	local SessionCnt = GetActiveChatSessionCnt()
			if SessionCnt == 0 then
				winMgr:getWindow('sj_chat_effect'):clearControllerEvent('MessengerEffect');
				winMgr:getWindow('sj_chat_effect'):clearActiveController();
				winMgr:getWindow('sj_chat_effect'):setVisible(false);
			end
	
	if g_CurSelectMainTap == 1 then
		if selected == true then
			for i=1, #tUserButtonName do
				
				winMgr:getWindow(tUserButtonName[i]):setProperty('Selected', 'False');
			end
		end
		
		g_TotalFriendListPage = GetTotalFriendPage(g_PageSize);
		winMgr:getWindow('PageInfoText'):clearTextExtends();
			
		if g_TotalFriendListPage == 0 then
			-- 모든걸 다 ''로 만들어 준다.
			-- 페이지 번호도 없애 준다.		
			winMgr:getWindow('PageInfoText'):addTextExtends('1 / 1' , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		else
		    if g_CurFriendListPage<1 then
				g_CurFriendListPage=1
		    end
			winMgr:getWindow('PageInfoText'):addTextExtends(tostring(g_CurFriendListPage)..' / '..tostring(g_TotalFriendListPage) , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		end
		
		for i=1, g_PageSize do
		
			-- 일단은 이름만 얻어온다.
			local user_window = winMgr:getWindow('sj_friendListBtn_'..tostring(i));
			
			local static_level_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'LevelText')
			local static_name_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'CharNameText')
			local static_pos_window		= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'PosText')
			local button_info_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'InfoBtn')
			
			static_level_window:clearTextExtends();
			static_name_window:clearTextExtends();
			static_pos_window:clearTextExtends();
			
				
			-- 이름, 위치, 상태, 레벨을 얻어온다.
			local name, pos, state, level, ladder = GetFriendList(i, g_CurFriendListPage, g_PageSize)
		
		
			local colorR = 200
			local colorG = 50
			local colorB = 50
			local apply_pos = '오프라인';
			local pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10);
			if pos ~= '' then
			
				-- 임시적으로 온라인일 경우 정보를 온라인만 보여준다.
				if pos ~= '오프라인' then
					colorR = 200
					colorG = 150
					colorB = 50
					apply_pos = '온라인'
					pos_output = PreCreateString_1179	--GetSStringInfo(LAN_LUA_WND_MESSENGER_11)
				end
				
			else -- 위치가 안오면
				colorR = 200
				colorG = 50
				colorB = 50
				if state == '온라인' then
					apply_pos = '오프라인'
					pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
				end
				if state == '게임중' then
					apply_pos = '게임중'
				end
				if state == '등록대기중' then
					apply_pos = '등록대기중'
				end
			end
			
			
			   
			if name ~= 'none' then
				user_window:setProperty('Disabled', 'False');
				
				-- 친구 레벨
			    static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     255,255,255,255);
				
	            
				-- 친구 이름
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     255,255,255,255);
				static_name_window:setText(name);
												
				-- 친구 위치
				
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,    colorR,colorG,colorB,255,     0,     255,255,255,255);
				static_pos_window:setText(pos_output);
				
				button_info_window:setVisible(true)	-- 친구 정보보기
				if apply_pos ~= '오프라인' then
					button_info_window:setEnabled(true)
				else
					button_info_window:setEnabled(false)
				end
				
			else
			    user_window:setProperty('Disabled', 'True');
				static_level_window:setText('');
				static_name_window:setText('');
				static_pos_window:setText('');
				button_info_window:setVisible(false)
			end
		end	
		
	end
	
	if g_SelectedUserListIndex > 0  then
	g_SelectedUserListIndex=1
	winMgr:getWindow(tUserButtonName[g_SelectedUserListIndex]):setProperty('Selected', 'True');
	end
end

-----------------------------------------------------------
-- 절친 리스트 리프레쉬
-----------------------------------------------------------
function RefreshBestFriendList(selected)	-- selected 인자는 선택된것을 계속 유지 할것인가 말것인가다(유저리스트 라디오 박스로 되어있으므로)
	DebugStr('RefreshBestFriendList start');
	if g_CurSelectMainTap == 4 then
		winMgr:getWindow('PageInfoText'):clearTextExtends();
		winMgr:getWindow('PageInfoText'):addTextExtends('1 / 1' , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		
	
		for i=1, 10 do
			local user_window = winMgr:getWindow('sj_friendListBtn_'..tostring(i));
				
			local static_level_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'LevelText')
			local static_name_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'CharNameText')
			local static_pos_window		= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'PosText')
			local button_info_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'InfoBtn')
			static_level_window:clearTextExtends();
			static_name_window:clearTextExtends();
			static_pos_window:clearTextExtends();
	
			
			local level, name, state, bFriend = GetBestFriendList(i)
				
				
			if state == 0 then
				colorR = 200
				colorG = 50
				colorB = 50	
				pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
			else
				colorR = 200
				colorG = 150
				colorB = 50
				pos_output = PreCreateString_1179	--GetSStringInfo(LAN_LUA_WND_MESSENGER_11)
			end
			
			if name ~= 'none' then
			
				-- 절친 레벨
				static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(level);
				
				-- 절친 이름
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(name);
				
				-- 절친 위치
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,     colorR,colorG,colorB,255,     0,     0,0,0,255);
				static_pos_window:setText(pos_output);
				
				user_window:setProperty('Disabled', 'False');
				
				
				button_info_window:setVisible(true)	-- 친구 정보보기
				if state == 1 then					
					button_info_window:setEnabled(true)
				else
					button_info_window:setEnabled(false)
				end
			else
				 user_window:setProperty('Disabled', 'True');
				 static_level_window:setText('');
				 static_name_window:setText('');
				 static_pos_window:setText('');
				 button_info_window:setVisible(false)
			end
		end
	end
end



g_CurGuildListPage = 1;
g_TotalGuildListPage = 5;

function RefreshGuildList(selected)	-- selected 인자는 선택된것을 계속 유지 할것인가 말것인가다(유저리스트 라디오 박스로 되어있으므로)
	DebugStr('RefreshGuildList start');
	if g_CurSelectMainTap == 3 then
		g_TotalGuildListPage = GetTotalGuildPage(g_PageSize);	
		winMgr:getWindow('PageInfoText'):clearTextExtends();
		if g_TotalGuildListPage == 0 then
			-- 모든걸 다 ''로 만들어 준다.
			-- 페이지 번호도 없애 준다.		
			winMgr:getWindow('PageInfoText'):addTextExtends('1 / 1' , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		else
			winMgr:getWindow('PageInfoText'):addTextExtends(tostring(g_CurGuildListPage)..' / '..tostring(g_TotalGuildListPage) , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		end
		for i=1, g_PageSize do
		local user_window = winMgr:getWindow('sj_friendListBtn_'..tostring(i));
			
			-- 일단은 이름만 얻어온다.
			local static_level_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'LevelText')
			local static_name_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'CharNameText')
			local static_pos_window		= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'PosText')
			local button_info_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'InfoBtn')
			static_level_window:clearTextExtends();
			static_name_window:clearTextExtends();
			static_pos_window:clearTextExtends();
			
			local level, name, state = GetGuildList(i, g_CurGuildListPage, g_PageSize)
			
			
			if state == 'offline' then
				colorR = 200
				colorG = 50
				colorB = 50
				apply_pos = '오프라인'
				pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
			else
				colorR = 200
				colorG = 150
				colorB = 50
				pos_output = state
			end
			
			
			if name ~= 'none' then
			
				-- 클럽원 레벨
				static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(level);
				
				-- 클럽원 이름
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(name);
				
				-- 클럽원 위치
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,     colorR,colorG,colorB,255,     0,     0,0,0,255);
				static_pos_window:setText(pos_output);
				
				user_window:setProperty('Disabled', 'False');
				
				
				button_info_window:setVisible(true)	-- 친구 정보보기
				if state ~= 'offline' then					
					button_info_window:setEnabled(true)
				else
					button_info_window:setEnabled(false)
				end
			else
				static_level_window:setText('');
				static_name_window:setText('');
				static_pos_window:setText('');				
				user_window:setProperty('Disabled', 'True');				
				button_info_window:setVisible(false)
				button_info_window:setVisible(false)
			end
		end
	end
	
end


g_CurPartyListPage = 1;
g_TotalPartyListPage = 10;


-----------------------------------------------------------------------
--	메신저 팝업창을 보여줄지 확인
-----------------------------------------------------------------------
function ShowFriendMessenger(bFlag)
	
	if bFlag == true then	-- 열릴때
	    g_EffectCount=0;
		
		Mainbar_ClearEffect(BAR_BUTTONTYPE_MESSAGE)
		
		winMgr:getWindow('bj_messengerBackWindow'):setVisible(true);
		root:addChildWindow( winMgr:getWindow('bj_messengerBackWindow') );
		
		-- 이런식으로 하면 안좋은게 ChangeMyLevel로 한다.
		ChangeMyLevel();
		SetMessengerVisible(true);	-- 클라이언트쪽에 메신져가 보이고 있다고 알려줌
		RefreshFriendList(true);
		if CEGUI.toRadioButton( winMgr:getWindow('sj_tab_chat') ):isSelected() == true then
			winMgr:getWindow("doChattingAtMessenger"):activate();
		else
			winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(false);
			winMgr:getWindow('sj_messenger_listWindow'):setVisible(true);
			g_CurSelectMainTap = 1;
			RefreshFriendList(true);
			winMgr:getWindow('sj_tab_friend'):setProperty('Selected', 'True')
		end
		
		
	else -- 닫힐때
		ChatSessionEnd(); -- 확실히 하기 위해서 end를 한다.
		winMgr:getWindow("doChattingAtMessenger"):deactivate();
		SetMessengerVisible(false);	-- 클라이언트쪽에 메신져가 사라졌다고 알려줌
		root:addChildWindow( winMgr:getWindow('bj_messengerBackWindow') );
		winMgr:getWindow('bj_messengerBackWindow'):setVisible(false);
	end
	
end




-----------------------------------------------------------------------

-- 에디트 박스를 보여준다.  채팅창

-----------------------------------------------------------------------
function ShowMultiLineEditBox(index, charName)
	DebugStr('ShowMultiLineEditBox() start');
	DebugStr('index : ' .. tostring(index));
	
	if index < 1 or index > 10 then
		DebugStr('범위를 벗어 났습니다. index : ' .. tostring(index));
	end
	
	for i=1, 10 do
		winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(false)
	end
	
	local editindex = 0;
	local ChatBool = false;
    for i=1, 10 do
	    if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == charName then
			winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(true);	
			editindex = i;
			ChatBool = true;
			break;
		end
	end
	
	for i=1, 10 do		
		if ChatBool==false then
			if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == ""  then
				winMgr:getWindow(tWhiteMultiLineEditBox[i]):setUserString('UserName', charName);
				DebugStr('채팅창을 새로 생성:'..charName);
				editindex = i;
				ChatBool = true;
	            break;
			end
		end
       
    end
	DebugStr('ShowMultiLineEditBox end');
end



function OnRefreshChatInfo(index, name, info)
    DebugStr('OnRefreshChatInfo');  --추가
	if name ~= '' then
		local name_static_text = winMgr:getWindow(tChatUserRadio[index+1]..'NameText');
		name_static_text:setProperty('Disabled', 'false');
		winMgr:getWindow(tChatUserRadio[index+1]):setProperty('Disabled', 'false');
		
		name_static_text:clearTextExtends();
		name_static_text:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,200,86,255,     0,     255,200,86,255);
		name_static_text:setText(name);
	end
	winMgr:getWindow('sj_chatuser_Text'):clearTextExtends();
	winMgr:getWindow('sj_chatuser_Text'):addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,	0,51,255,255,  0,  0,0,0,255);
	winMgr:getWindow('sj_chatuser_Text'):addTextExtends(info, g_STRING_FONT_GULIMCHE, 112,    0,0,0,255,     0,  0,0,0,255);
	winMgr:getWindow('sj_chatuser_Text'):setText(name..info);
end




------------------------------------------------

-- 메신져 탭을 눌렀을 경우

------------------------------------------------
-- 친구탭 눌렀을 경우
function OnSelected_FriendTap(args)
	DebugStr('OnSelected_FriendTap start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('MessengerPartyInviteBtn');
		if find_window ~= nil then
		  
			winMgr:getWindow('sj_messenger_chatBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setEnabled(true);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setEnabled(false);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setEnabled(true);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_closeBtn'):setVisible(true);
			winMgr:getWindow('MessengerPartyInviteBtn'):setVisible(false);
			winMgr:getWindow('MessengerPartyLeaveBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setVisible(true);	
			
			if CheckfacilityData(FACILITYCODE_BESTFRIEND) == 1 then
				winMgr:getWindow('sj_messenger_addBestFriendBtn'):setEnabled(true);	
			else
				winMgr:getWindow('sj_messenger_addBestFriendBtn'):setEnabled(false);
			end
			
			
		end
		winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(false);
		winMgr:getWindow('sj_messenger_listWindow'):setVisible(true);
		g_CurSelectMainTap = 1;
		RefreshFriendList(true);
	end
	
	DebugStr('OnSelected_FriendTap end');
end


-- 절친 탭 눌렀을 경우
function OnSelected_BestFriendTap(args)
	DebugStr('OnSelected_BestFriendTap start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('MessengerPartyInviteBtn');
		if find_window ~= nil then
			winMgr:getWindow('sj_messenger_chatBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_chatBtn'):setEnabled(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setEnabled(false);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setEnabled(false);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setEnabled(true);
			winMgr:getWindow('sj_messenger_closeBtn'):setVisible(true);
			winMgr:getWindow('MessengerPartyInviteBtn'):setVisible(false);
			winMgr:getWindow('MessengerPartyLeaveBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setEnabled(false);
		end
		winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(false);
		winMgr:getWindow('sj_messenger_listWindow'):setVisible(true);
		g_CurSelectMainTap = 4;
		RequestGetBestFriendList();
		--RefreshBestFriendList(true);
	end
	
	DebugStr('OnSelected_BestFriendTap end');
end


-- 클럽탭 눌렀을 경우
function OnSelected_GuildTab(args)
	DebugStr('OnSelected_GuildTab start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('MessengerPartyInviteBtn');
		if find_window ~= nil then
			winMgr:getWindow('sj_messenger_chatBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setEnabled(false);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setEnabled(false);
			winMgr:getWindow('sj_messenger_closeBtn'):setVisible(true);
			winMgr:getWindow('MessengerPartyInviteBtn'):setVisible(false);
			winMgr:getWindow('MessengerPartyLeaveBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setVisible(true);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setEnabled(false);	
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setEnabled(false);	
		end
		winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(false);
		winMgr:getWindow('sj_messenger_listWindow'):setVisible(true);
		g_CurSelectMainTap = 3;
		RefreshGuildList(true);
	end
	
	DebugStr('OnSelected_GuildTab end');
end


-- 대화탭 눌렀을 경우
function OnSelected_ChatTab(args)
	DebugStr('OnSelected_ChatTab start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('MessengerPartyInviteBtn');
		winMgr:getWindow('doChattingAtMessenger'):activate();
		if find_window ~= nil then
			winMgr:getWindow('sj_messenger_chatBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_addFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_deleteFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_deleteBestFriendBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_closeBtn'):setVisible(true);
			winMgr:getWindow('MessengerPartyInviteBtn'):setVisible(false);
			winMgr:getWindow('MessengerPartyLeaveBtn'):setVisible(false);
			winMgr:getWindow('sj_messenger_addBestFriendBtn'):setVisible(false);			
			winMgr:getWindow('sj_chat_effect'):clearControllerEvent('MessengerEffect');
		    winMgr:getWindow('sj_chat_effect'):clearActiveController();
		    winMgr:getWindow('sj_chat_effect'):setVisible(false);
		    
		
		end
		winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(true);
		winMgr:getWindow('sj_messenger_listWindow'):setVisible(false);
		g_CurSelectMainTap = 4;
	end
		
	DebugStr('OnSelected_ChatTab end');
end	



function OnClickFriendDeleteQuestOk(args) --Q

	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickFriendDeleteQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickFriendDeleteQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setProperty('Visible', 'False');
		
		DebugStr('name : ' .. g_FriendDeleteSaveName);
		local bRet = RequestFriendDelete(g_FriendDeleteSaveName);
		g_FriendDeleteSaveName = '';
		DebugStr('bRet : ' .. tostring(bRet));
		if bRet == true then
			--OnFriendDelete(g_FriendDeleteSaveName);
		else
			ShowCommonAlertOkBoxWithFunction('친구삭제를 실패했습니다.', 'OnClickAlertOkSelfHide');
			--LAN_LUA_WND_MESSENGER_14 
		end
		DebugStr('OnClickFriendDeleteQuestOk end');
		
		RefreshFriendList(true)
	end
end



function OnClickFriendDeleteQuestCancel(args)  --Q
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickFriendDeleteQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickFriendDeleteQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickFriendDeleteQuestCancel end');
	end
end









--------------------------------------------

-- 메신져 버튼 이벤트 함수들

--------------------------------------------
-- 1. 대화하기 이벤트 함수
function OnClickFriendChat(args)
	for i=1, #tUserButtonName do
		local local_window = winMgr:getWindow(tUserButtonName[i])
		if CEGUI.toRadioButton(local_window):isSelected() then
			local win_name	= local_window:getName()
			local char_name	= winMgr:getWindow(win_name..'CharNameText'):getText()
			local pos_text	= winMgr:getWindow(win_name..'PosText'):getText()

			if pos_text ~= '채널선택' and pos_text ~= '오프라인' and pos_text ~= pos_off then
				ChatReqLogic(char_name)
			else
				ShowCommonAlertOkBoxWithFunction(string.format(PreCreateString_2019, char_name), 'OnClickAlertOkSelfHide')
			end													--GetSStringInfo(LAN_LUA_WND_MESSENGER_26)
			return
		end
	end
	--ShowCommonAlertOkBoxWithFunction('대화할 친구를 선택해 주세요.', 'OnClickAlertOkSelfHide');
	ShowCommonAlertOkBoxWithFunction(PreCreateString_2018, 'OnClickAlertOkSelfHide');
														--GetSStringInfo(LAN_LUA_WND_MESSENGER_25)
end


-- 2. 친구 추가하기 이벤트 함수
function OnClickFriendAdd(args)
	DebugStr('OnClickFriendAdd start');
	local isVirtual = isVirtualLogin();
	
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit(PreCreateString_1184 , 
	'OnClickFriendAddQuestOk', 'OnClickFriendAddQuestCancel', 'OnAcceptFriendAddEditText');
														--GetSStringInfo(LAN_LUA_WND_MESSENGER_16)
	DebugStr('OnClickFriendAdd end');
end

-- 3. 절친 추가하기 이벤트 함수
function OnClickBestFriendAdd(args)
	DebugStr('OnClickBestFriendAdd start');
	
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- 내용이 비어있는지도 확인해야 한다.
		local str_select_window_name	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'CharNameText'
		local str_select_window_level	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'LevelText'
		local str_select_window_pos		= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'PosText'
		local str_name	= winMgr:getWindow( str_select_window_name ):getText();
		local str_level = winMgr:getWindow( str_select_window_level ):getText();
		local str_pos	= winMgr:getWindow( str_select_window_pos ):getText();
		
		DebugStr('str_name : ' .. str_name);
		
		if str_name ~= '' then
			g_FriendDeleteSaveName = str_name;
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2756, str_name),  'OnClickBestFriendAddQuestOk', 'OnClickBestFriendAddQuestCancel');
		end																--GetSStringInfo(LAN_BESTFRIEND_REGISTER_001)
	else
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_2769, 'OnClickAlertOkSelfHide')           
	end										--GetSStringInfo(LAN_BESTFRIEND_REGISTER_007)
	DebugStr('OnClickBestFriendAdd end');
end


-- 4. 친구 삭제하기 이벤트 함수
g_FriendDeleteSaveName = '';
function OnClickFriendDelete(args)
	DebugStr('OnClickFriendDelete start');
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- 내용이 비어있는지도 확인해야 한다.
		local str_select_window_name	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'CharNameText'
		local str_select_window_level	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'LevelText'
		local str_select_window_pos		= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'PosText'
		local str_name	= winMgr:getWindow( str_select_window_name ):getText();
		local str_level = winMgr:getWindow( str_select_window_level ):getText();
		local str_pos	= winMgr:getWindow( str_select_window_pos ):getText();
		
		DebugStr('str_name : ' .. str_name);
		
		if str_name ~= '' then
			g_FriendDeleteSaveName = str_name;
			--ShowCommonAlertOkCancelBoxWithFunction(str_name, '님과의\n친구관계를 끝내시겠습니까?', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2020, str_name),  'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
		end																--GetSStringInfo(LAN_LUA_WND_MESSENGER_27)
	else
		--ShowCommonAlertOkBoxWithFunction('삭제할 친구를 선택해 주세요.', 'OnClickAlertOkSelfHide');
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_1187	, 'OnClickAlertOkSelfHide')           
	end										--GetSStringInfo(LAN_LUA_WND_MESSENGER_19)
	
	DebugStr('OnClickFriendDelete end');
end

-- 5. 절친 삭제하기 이벤트 함수
function OnClickBestFriendDelete(args)
	DebugStr('OnClickBestFriendDelete start');
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- 내용이 비어있는지도 확인해야 한다.
		local str_select_window_name	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'CharNameText'
		local str_select_window_level	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'LevelText'
		local str_select_window_pos		= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'PosText'
		local str_name	= winMgr:getWindow( str_select_window_name ):getText();
		local str_level = winMgr:getWindow( str_select_window_level ):getText();
		local str_pos	= winMgr:getWindow( str_select_window_pos ):getText();
		
		DebugStr('str_name : ' .. str_name);
		
		if str_name ~= '' then
			g_FriendDeleteSaveName = str_name;
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2766, str_name),  'OnClickBestFriendDeleteQuestOk', 'OnClickBestFriendDeleteQuestCancel');
		end																--GetSStringInfo(LAN_BESTFRIEND_DELETE_005)
	else
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_1187, 'OnClickAlertOkSelfHide')           
	end										--GetSStringInfo(LAN_LUA_WND_MESSENGER_19)
	
	DebugStr('OnClickBestFriendDelete end');
end




-- 5. 메신저를 닫는 이벤트 함수
function OnClickClose(args)
	ShowFriendMessenger(false);
end



function OnClickBestFriendDeleteQuestOk(args)

	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendDeleteQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickBestFriendDeleteQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setProperty('Visible', 'False');
		
		DebugStr('name : ' .. g_FriendDeleteSaveName);
		CheckBreakBestFriendItem(-1, g_FriendDeleteSaveName);
		g_FriendDeleteSaveName = '';
		DebugStr('OnClickBestFriendDeleteQuestOk end');
	end
end


function OnClickBestFriendDeleteQuestCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendDeleteQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickBestFriendDeleteQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickBestFriendDeleteQuestCancel end');
	end
end


-----------------------------------------------------------------------

--	메신저 페이지 관련

-----------------------------------------------------------------------
function OnClickPrevPage(args)
   
	if g_CurSelectMainTap == 1 then
		g_CurFriendListPage = g_CurFriendListPage-1;
		if g_CurFriendListPage < 1 then
			g_CurFriendListPage = 1;
			 g_SelectedUserListIndex=1;
			RefreshFriendList(false);
		else
			RefreshFriendList(true);
		end
	elseif g_CurSelectMainTap == 2 then
	elseif g_CurSelectMainTap == 3 then
		g_CurGuildListPage = g_CurGuildListPage-1;
		if g_CurGuildListPage < 1 then
			g_CurGuildListPage = 1;
			RefreshGuildList(false);
		else
			RefreshGuildList(true);
		end
	elseif g_CurSelectMainTap == 4 then
	end
	
end

function OnClickNextPage(args)
 
	if (g_CurSelectMainTap == 1) and (g_CurFriendListPage~=g_TotalFriendListPage) then

		g_CurFriendListPage = g_CurFriendListPage+1;
		if g_CurFriendListPage > g_TotalFriendListPage then
			g_CurFriendListPage = g_TotalFriendListPage;
			 g_SelectedUserListIndex=1;
			RefreshFriendList(false);
		else
			RefreshFriendList(true);
		end
	
	elseif g_CurSelectMainTap == 2 then
	elseif g_CurSelectMainTap == 3 then
		g_CurGuildListPage = g_CurGuildListPage+1;
		if g_CurGuildListPage > g_TotalGuildListPage then
			g_CurGuildListPage = g_TotalGuildListPage;
			RefreshGuildList(false);
		else
			RefreshGuildList(true);
		end
	elseif g_CurSelectMainTap == 4 then
	end
	
end


g_EffectCount = 0;
function OnClickUserButton(args)   

end

g_lastChatReceiveIndex = -1;

function ShowMessengerBaloon()
end

function OnMessengerChatMsg(index, name, msg, friendname)
	
	local view_name = '';
	local bAlert = true
	if name == '알림' then -- 이름이 빈칸으로 왔으면
		view_name = '';
	else
		bAlert = false
		--view_name = '['..name..']'..'님의 말:\n';
		view_name = string.format(PreCreateString_2024, name)
	end								--GetSStringInfo(LAN_MESSENGER_MSG)
	
    g_lastChatReceiveIndex = GetActiveChatSessionCnt();
	--라디오 버튼 전부 조사
	local strName, strTitle
	for i=1, 10 do
	  local name_static_text = winMgr:getWindow(tChatUserRadio[i]..'NameText');
	  if name_static_text:getText()==friendname then
	  strName, strTitle = ChatInfo(i-1);
	  break;
	  end
	end
	
	local ChatBool=false;
	local editindex
	-- 상대방이 메세지를 전달할때 채팅창 윈도우 이름 세팅해줘야 한다
	for i=1, 10 do
	    if	winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == friendname then
			editindex = i;
			ChatBool = true;
			break;
		end
	end
	
	for i=1, 10 do		
		if ChatBool==false then
			if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == ""  then
				winMgr:getWindow(tWhiteMultiLineEditBox[i]):setUserString('UserName', friendname);
				g_EffectCount=g_EffectCount+1;
				editindex=i;
				ChatBool=true;
	            break;
			 end
		end
       
    end
    
   
    for i=1, 10 do
           if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == friendname then
             local local_multi_line_text = CEGUI.toMultiLineEditbox(winMgr:getWindow(tWhiteMultiLineEditBox[i]));
			if bAlert then
				local_multi_line_text:addTextExtends(view_name..msg..'\n', g_STRING_FONT_GULIMCHE, 112, 220,150,150,255,   0, 0,0,0,255);
			else
			    if friendname == name then
					local_multi_line_text:addTextExtends(view_name, g_STRING_FONT_GULIMCHE, 112, 0,230,168,255,   0, 30,30,30,255);
				else
					local_multi_line_text:addTextExtends(view_name, g_STRING_FONT_GULIMCHE, 112, 255,187,000,255,   0, 30,30,30,255);
				end
				
				local_multi_line_text:addTextExtends(msg..'\n', g_STRING_FONT_GULIMCHE, 112, 200,200,200,255,   0, 0,0,0,255);
				break;
			end
		  end
	end

	local msg_visible = winMgr:getWindow('MsgAlertBalloon'):isVisible()
	local messenger_visible = winMgr:getWindow('bj_messengerBackWindow'):isVisible()
	if msg_visible == false and messenger_visible == false then
	  -- 상황에따라
	
		if name == '알림' then
			--OnChatPublicWithName('알림', msg, 5);
		else
			DebugStr('메신져 말풍선효과1')
			
			Mainbar_ActiveEffect(BAR_BUTTONTYPE_MESSAGE)

			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setProperty('Selected', 'True');
			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setVisible(true) -- 수정
			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setProperty('Disabled', 'False');
			winMgr:getWindow(tWhiteMultiLineEditBox[editindex]):setVisible(true);
					
			winMgr:getWindow('sj_tab_chat'):setProperty('Selected', 'True');
			winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'False');
		end
	
	
	elseif  msg_visible == false and messenger_visible ==true   then
		if name == '알림' then
		else	
		    if CEGUI.toRadioButton( winMgr:getWindow('sj_tab_chat') ):isSelected() ~= true then
				DebugStr('메신져 말풍선효과2')
				
				Mainbar_ActiveEffect(BAR_BUTTONTYPE_MESSAGE, 3)
				
				winMgr:getWindow(tChatUserRadio[index+1]):setProperty('Selected', 'true');
			end
			
			
			local strName, strTitle = ChatInfo(index);
	
			if strName ~= '' then
				local name_static_text = winMgr:getWindow(tChatUserRadio[index+1]..'NameText');
				winMgr:getWindow(tChatUserRadio[index+1]):setProperty('Disabled', 'false');
				name_static_text:clearTextExtends();
				name_static_text:addTextExtends(strName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
			end
	
			winMgr:getWindow(tChatUserRadio[index+1]):setProperty('Disabled', 'False');	
			
			winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'False');
			
			if CEGUI.toRadioButton( winMgr:getWindow('sj_tab_chat') ):isSelected() ~= true then
		
				winMgr:getWindow('sj_chat_effect'):setUseEventController(false);
				winMgr:getWindow('sj_chat_effect'):clearControllerEvent('MessengerEffect');
				winMgr:getWindow('sj_chat_effect'):addController("messengerController", "MessengerEffect", "visible", "Sine_EaseIn", 1, 1, 8, true, true, 10);
				winMgr:getWindow('sj_chat_effect'):addController("messengerController", "MessengerEffect", "visible", "Sine_EaseIn", 0, 0, 8, true, true, 10);
				winMgr:getWindow('sj_chat_effect'):activeMotion('MessengerEffect');
			end
		 end
	 end
	
	if name == friendname then
		winMgr:getWindow(tChatUserRadio[index+1]):activeMotion('FireAlphaChange');
	end
end





-----------------------------------------------
-- 메신저 배경창
-----------------------------------------------
winMgr:getWindow('bj_messengerBackWindow'):setVisible(false)
winMgr:getWindow('bj_messengerBackWindow'):setPosition(377, 149)


-- 메신저 배경창을 움직이는 Titlebar
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_titlebar'))

-- 리스트배경창
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_listWindow'))

winMgr:getWindow('sj_messenger_listWindow'):setPosition(14, 133)

-- 채팅배경창
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_chatBackWindow_1'))



----------------------------------------------------------------------
-- 레벨, 캐릭터, 클래스, 길드 or 등급, 위치 (총 세게의 스태틱 이미지)
----------------------------------------------------------------------
winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow('sj_allDesc'))
winMgr:getWindow('sj_allDesc'):addChildWindow(winMgr:getWindow('sj_ladderGradeDesc'))
winMgr:getWindow('sj_ladderGradeDesc'):setVisible(false)


--여기까지

-----------------------------------------------
-- 친구, 파티, 길드 탭버튼같은 라디오 버튼
-----------------------------------------------
tWinName = {['protecterr'] = 0,	"sj_tab_friend", "chat_tab_best_friend",  "sj_tab_club", "sj_tab_chat" }
--tEventHandler	= {['err'] = 0, "OnSelected_FriendTap", "OnSelected_GuildTab", "OnSelected_ChatTab"}
for i=1, #tWinName do
	winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow(tWinName[i]));
	--winMgr:getWindow(tWinName[i]):subscribeEvent("SelectStateChanged", tEventHandler[i])
end


winMgr:getWindow('sj_tab_club'):setEnabled(true)



function OnSelectedUserList(args)
	DebugStr('OnSelectedUserList start');
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local win_name = local_window:getName();
		--DebugStr('win_name : ' .. win_name);
	end
	--DebugStr('OnSelectedUserList end');
end

g_strSelectRButtonUp = "none";
g_SelectWindowRButton = nil;
g_villageUserTitleIndex = -1;

-- 마우스 오른쪽으로 선택한 유저 이름 초기화
function ClearSelectRButtonUser()
	g_strSelectRButtonUp = ""
end


-- 친구 유저 정보보기 호출 -메신저에서 호출했을시
function CallUserInfo(args)
	local parent_window = CEGUI.toWindowEventArgs(args).window:getParent():getName()
	local char_name_window = winMgr:getWindow(parent_window..'CharNameText');
	DebugStr('Char Name Text : '..char_name_window:getText());
	g_strSelectRButtonUp = char_name_window:getText();
	GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
	ShowUserInfoWindow()
end

 -- 이동하기
 
function CallUserMove(args)
 local parent_window = CEGUI.toWindowEventArgs(args).window:getParent():getName()
	local char_name_window = winMgr:getWindow(parent_window..'CharNameText');
	DebugStr('Char Name Text : '..char_name_window:getText());
	g_strSelectRButtonUp = char_name_window:getText();
	
 end



-----------------------------------------------------------------------

-- 메신저에 있는 유저 리스트에 마우스 버튼 오른쪽 눌렀을때..

-----------------------------------------------------------------------
function OnUserListMouseRButtonUp(args)
	DebugStr('OnUserListMouseRButtonUp start');
	local m_pos = mouseCursor:getPosition();
	ShowPopupWindow(m_pos.x, m_pos.y, 1);
	
	-- 캐릭터 네임을 알아온다.
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	local char_name_window = winMgr:getWindow(win_name..'CharNameText');
	local pos_text = winMgr:getWindow(win_name..'PosText'):getText();
	DebugStr('Char Name Text : '..char_name_window:getText());
	DebugStr('Pos Text : ' .. pos_text);
	g_strSelectRButtonUp = char_name_window:getText();
	
	winMgr:getWindow('pu_showInfo'):setEnabled(true)
	winMgr:getWindow('pu_deleteFriend'):setEnabled(true)
	winMgr:getWindow('pu_privatChat'):setEnabled(true)
	winMgr:getWindow('pu_chatToUser'):setEnabled(true)
	winMgr:getWindow('pu_inviteParty'):setEnabled(true)
	
	DebugStr('g_CurSelectMainTap : ' .. tostring(g_CurSelectMainTap));
	
	if g_CurSelectMainTap == 1 then
		MakeMessengerPopup("pu_showInfo", "pu_profile" , "pu_deleteFriend", "pu_privatChat", "pu_chatToUser", "pu_inviteParty");
	else
		MakeMessengerPopup("pu_showInfo", "pu_profile" , "pu_privatChat", "pu_chatToUser", "pu_inviteParty");
	end
	
	if pos_text ~= '채널선택' and pos_text ~= '오프라인' and pos_text ~= pos_off then
		winMgr:getWindow('pu_chatToUser'):setEnabled(true)
		winMgr:getWindow('pu_privatChat'):setEnabled(true)
	else
		winMgr:getWindow('pu_showInfo'):setEnabled(false) --수정
		winMgr:getWindow('pu_chatToUser'):setEnabled(false)
		winMgr:getWindow('pu_privatChat'):setEnabled(false)
	end
	local currentWndType = GetCurrentWndType()
	if currentWndType == 12 then
		if IsMyPartyMember(g_strSelectRButtonUp) == true then
		 winMgr:getWindow('pu_inviteParty'):setEnabled(false)
		DebugStr('Already Party');
		else
		winMgr:getWindow('pu_inviteParty'):setEnabled(true)
		DebugStr('No Party');
		end
	else
		winMgr:getWindow('pu_inviteParty'):setEnabled(false)
	end
	
	if g_CurSelectMainTap == 1 then
	elseif g_CurSelectMainTap == 2 then -- 파티탭일때는 팝업비활성하기 비활성화로 놓는다.
	winMgr:getWindow('pu_chatToUser'):setProperty('Disabled', 'True');
	elseif g_CurSelectMainTap == 3 then
	end
end





function ChatReqLogic(char_name)
	DebugStr('ChatReqLogic start');
	
	-- 현재 채널 선택에 있으면 대화 못하게 한다.
	DebugStr('Char Name Text : '..char_name);
	
	-- 현재 카운트를 얻어온다.
	local active_cnt = GetActiveChatSessionCnt();
	DebugStr('active_cnt : ' .. tostring(active_cnt));
	
	if active_cnt > 9 then
		 -- 더이상 채팅창을 생성할 수 없습니다
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_1188, 'OnClickAlertOkSelfHide');
		return;								--GetSStringInfo(LAN_LUA_WND_MESSENGER_20 )
	end
	
	
	-- 현재 이름에 해당하는 이름이 채팅목록에 있는지 확인한다. iRet 값은 0~9값이 나온다.
	local success, iRet = RequestChatSession(char_name);
	DebugStr('iRet : ' .. tostring(iRet));

	if success == true then
	else -- 대화 요청을 해서 실패하면 팝업창을 띄어준다.
		--ShowCommonAlertOkBoxWithFunction(char_name..'님은\n접속하지 않으셨습니다.', 'OnClickAlertOkSelfHide');
		ShowCommonAlertOkBoxWithFunction(string.format(PreCreateString_2019, char_name), 'OnClickAlertOkSelfHide')
	end													--GetSStringInfo(LAN_LUA_WND_MESSENGER_26)
		
	ShowMultiLineEditBox(iRet+1, char_name);
	local name_static_text = winMgr:getWindow(tChatUserRadio[iRet+1]..'NameText');
	winMgr:getWindow(tChatUserRadio[iRet+1]):setProperty('Disabled', 'false');
	name_static_text:clearTextExtends();
	name_static_text:addTextExtends(char_name, g_STRING_FONT_GULIMCHE, 112,    255,200,86,255,     0,     255,200,86,255);
	name_static_text:setText(char_name);
	
	
	winMgr:getWindow('sj_messenger_chatBackWindow_1'):setVisible(true);
	local village_chat_window = winMgr:getWindow('doChatting');
	DebugStr('village_chat_window : ' .. tostring(village_chat_window));
	if village_chat_window ~= nil then
		village_chat_window:deactivate();
	end
	winMgr:getWindow('sj_messenger_listWindow'):setVisible(false);
	
	winMgr:getWindow('sj_tab_chat'):setProperty('Selected', 'True');
	winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'False');
	
	-- 친구리스트 탭도 셀렉트 해준다.
	
	--친구리스트 셀렉을 해주기 위해 이름값을 찾는다
	winMgr:getWindow(tChatUserRadio[iRet+1]):setProperty('Disabled', 'False');
	winMgr:getWindow(tChatUserRadio[iRet+1]):setProperty('Selected', 'True');

	g_ChatSelectedIndex = iRet+1;
	DebugStr('ChatReqLogic end');
end




-- 유저 리스트에 마우스 더블클릭 할때
-- 일단 비어 있는 유저 목록을 확인하고 그에 해당하는 요청을 Request로 보낸다.
function OnUserListDoubleClicked(args)
	
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local win_name		= local_window:getName()
	local char_name		= winMgr:getWindow(win_name..'CharNameText'):getText()
	local pos_text		= winMgr:getWindow(win_name..'PosText'):getText()
	if pos_text ~= '채널선택' and pos_text ~= '오프라인' and pos_text ~= pos_off then
		ChatReqLogic(char_name);
	else
		--ShowCommonAlertOkBoxWithFunction(char_name..'님은\n접속하지 않으셨습니다.', 'OnClickAlertOkSelfHide');
		ShowCommonAlertOkBoxWithFunction(string.format(PreCreateString_2019, char_name), 'OnClickAlertOkSelfHide')
	end													--GetSStringInfo(LAN_LUA_WND_MESSENGER_26)
end




g_SelectedUserListIndex = -1;
g_SelectedUserWindow = nil;

function OnUserListMouseDown(args)
	DebugStr('OnUserListClicked start');
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	g_SelectedUserWindow = win_name;
	local char_name_window = winMgr:getWindow(win_name..'CharNameText');
	DebugStr('Char Name Text['..local_window:getUserString('Index')..'] : '..char_name_window:getText());
	g_SelectedUserListIndex = tonumber(local_window:getUserString('Index'));
end







----------------------------------------------------------------------
-- 대화화기버튼, 친구추가버튼, 친구삭제버튼, 닫기버튼
----------------------------------------------------------------------
tMessengerButtonName = { ["protecterr"]=0, "sj_messenger_chatBtn", "sj_messenger_addFriendBtn", "sj_messenger_addBestFriendBtn", "sj_messenger_deleteFriendBtn", "sj_messenger_deleteBestFriendBtn","sj_messenger_closeBtn" }
for i=1, #tMessengerButtonName do
	winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow(tMessengerButtonName[i]));
end



tPageLRButtonName  = { ["protecterr"]=0, "sj_messenger_prevBtn", "sj_messenger_nextBtn" }
for i=1, #tPageLRButtonName do
	winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow(tPageLRButtonName[i]));
end
winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow('PageInfoText'));


-- 팝업 초기화
function OnClearUserPopup(exitUserName)
	if g_strSelectRButtonUp == exitUserName then
		if winMgr:getWindow('pu_btnContainer'):isVisible() then
			root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
		end
	end
end

-- 팝업 친구 초대 버튼 눌렀을때-N
function OnClickPopupPartyInvite(args)
	ShowCommonAlertOkCancelBoxWithFunction("", '모모님을 친추', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- 팝업 친구 추가 버튼 눌렀을때-N
function OnClickPopupFriendAdd(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 삭제 버튼 눌렀을때-N
function OnClickPopupFriendDelete(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 귓속말 버튼 눌렀을때-N
function OnClickPopupWhisper(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 같이하기 버튼 눌렀을때-N
function OnClickPopupPlayTogether(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 승격 버튼 눌렀을때-N
function OnClickPopupUpgrade(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 강등 버튼 눌렀을때-N
function OnClickPopupDowngrade(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- 팝업 친구 길드탈퇴-N
function OnClickPopupGuildGoOut(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- 팝업 파티 추가-N
function OnClickPopupPartyGoOut(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- 팝업 파티 탈퇴-N
function OnClickPopupPartyUnJoin(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));	
end



function ShowPopupWindow(mouse_x, mouse_y, where)  --Q
--	DebugStr('ShowPopupWindow start');
	for i=1, #tPopupButtonName do
		--DebugStr('tPopupButtonName[i] : ' .. tPopupButtonName[i]);
		winMgr:getWindow(tPopupButtonName[i]):setProperty('Selected', 'false');
	end
	
	--winMgr:getWindow(tPopupButtonName[2]):setProperty('Selected', 'true');
	
	if where == 1 then
	elseif where == 2 then
	end
	
	winMgr:getWindow('pu_btnContainer'):setPosition(mouse_x, mouse_y);
	winMgr:getWindow('pu_btnContainer'):clearControllerEvent("GoPopup");
	winMgr:getWindow('pu_btnContainer'):setVisible(true);
	root:addChildWindow(winMgr:getWindow('pu_btnContainer'));
	winMgr:getWindow('pu_btnContainer'):addController("popupContainer", "GoPopup", "visible", "Sine_EaseIn", 1, 1, 5, true, false, 10);
	winMgr:getWindow('pu_btnContainer'):addController("popupContainer", "GoPopup", "visible", "Sine_EaseIn", 1, 0, 1, true, false, 10);
	winMgr:getWindow('pu_btnContainer'):setUseEventController(true);
	--winMgr:getWindow('pu_btnContainer'):activeMotion("Sine_EaseIn");
	DebugStr('ShowPopupWindow end');
end




----------------------------------------------------------------------

-- 팝업 창 - 팝업 버튼들 담는 컨테이너

----------------------------------------------------------------------
winMgr:getWindow('pu_btnContainer'):addChildWindow( winMgr:getWindow('pu_TopImage') );
winMgr:getWindow('pu_btnContainer'):addChildWindow( winMgr:getWindow('pu_BottomImage') );

function OnSelectedUserPopup(args)
	DebugStr('OnSelectedUserPopup start');
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
	
		local win_name = local_window:getName();
		DebugStr('win_name : ' .. win_name);
		
		-- 정보보기
		if win_name == 'pu_showInfo' then
			DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
			--InfoVisibleCheck(true);	
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUserInfoWindow()
			
		-- 파티초대
		elseif win_name == 'pu_inviteParty' then
			DebugStr('name : ' .. g_strSelectRButtonUp);
			OnClickPartyInvite(g_strSelectRButtonUp)
			
		-- 친구추가
		elseif win_name == 'pu_addFriend' then
			DebugStr('name : ' .. g_strSelectRButtonUp);
			local bRet = RequestNewFriend( g_strSelectRButtonUp );
			DebugStr('bRet : ' .. tostring(bRet));
			if bRet == false then
				--ShowCommonAlertOkBoxWithFunction('친구추가를 실패했습니다.', 'OnClickAlertOkSelfHide');
				ShowCommonAlertOkBoxWithFunction(PreCreateString_1173,'OnClickAlertOkSelfHide');
			else									--GetSStringInfo(LAN_LUA_WND_MESSENGER_5)
				OnRequestFriendOK(g_strSelectRButtonUp)
			end	
			
		-- 친구삭제
		elseif win_name == 'pu_deleteFriend' then
			g_FriendDeleteSaveName = g_strSelectRButtonUp;
			--ShowCommonAlertOkCancelBoxWithFunction(g_FriendDeleteSaveName, '님과의\n친구관계를 끝내시겠습니까?', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel')
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2020, g_FriendDeleteSaveName),  'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
																		--GetSStringInfo(LAN_LUA_WND_MESSENGER_27)
		-- 나의정보
		elseif win_name == 'pu_myInfo' then
			--InfoVisibleCheck(true);
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUserInfoWindow()
			DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
		
		-- 귓속말
		elseif win_name == 'pu_privatChat' then	
			Chatting_SetChatEditVisible(true)
			Chatting_SetChatSelectedPopup(CHATTYPE_PRIVATE)
			
			winMgr:getWindow("PrivateChatting"):setText(g_strSelectRButtonUp)
			winMgr:getWindow("doChatting"):activate()
			
		-- 거래하기
		elseif win_name == 'pu_deal' then
			ClickedRequestItemTrade(g_strSelectRButtonUp)
		
		--클럽초대
		elseif win_name == 'pu_raising' then
			InviteClubMember(g_strSelectRButtonUp)
			
		--프로필보기
		elseif win_name == 'pu_profile' then
		
			ClearGuestBook()
			GetProfileInfo(g_strSelectRButtonUp)
			
		elseif win_name == 'pu_clubUserBan' then
		
		-- 파티추방
		elseif win_name == 'pu_vanishParty' then
			OnClickPartyVanish(g_strSelectRButtonUp) -- 방장일때만 할 수 있게끔한다. 이미 팝업이 안뜨게 막고 있긴 하다.
		
		-- 채팅하기
		elseif win_name == 'pu_chatToUser' then
			ChatReqLogic(g_strSelectRButtonUp);
		
		-- 파티탈퇴
		elseif win_name == 'pu_partySecession' then
			OnClickPartyUnJoin()
		
		-- 파티장 위임
		elseif win_name == "pu_partyCommission" then
			OnClickPartyCommission(g_strSelectRButtonUp)
		
		elseif win_name == "pu_watchEquipment" then
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUseGMWearItemShow()
		
		elseif win_name == "pu_createParty" then
			OnSelected_PartyCreate()
		
		elseif win_name == "pu_reportuser" then
			ShowReportWindow(g_strSelectRButtonUp)
			DebugStr('신고하기 팝업')
			
		elseif win_name == "pu_blockUser" then
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_3591, g_strSelectRButtonUp), 'OnClickUserBlockOK', 'OnClickUserBlockCancel');
			DebugStr('차단하기 팝업')									--GetSStringInfo(LAN_BLOCK_USER_1)
			
		--elseif win_name == "pu_singleMatch" then
		--	ShowSingleMatchInfoToRequest(g_strSelectRButtonUp)
		--	DebugStr('1대1 대결신청')
		end
	end
	DebugStr('OnSelectedUserPopup end');
end

--DebugStr('where0');

function OnClickUserBlockOK(args)
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickUserBlockOK start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickUserBlockOK" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setProperty('Visible', 'False');
		
		DebugStr('name : ' .. g_strSelectRButtonUp);
		SetProfileBlackList(g_strSelectRButtonUp)
		g_strSelectRButtonUp = '';
	end
end

function OnClickUserBlockCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickUserBlockCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickUserBlockCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickUserBlockCancel end');
	end
end






----------------------------------------------------------------------

-- 팝업 버튼 - 오른쪽 버튼 눌르면 나오는

----------------------------------------------------------------------
winMgr:getWindow('pu_btnContainer'):addChildWindow(winMgr:getWindow('pu_windowName'))
winMgr:getWindow('pu_windowName'):addChildWindow(winMgr:getWindow('pu_name_text'))


tPopupButtonName =
{ ["protecterr"]=0, "pu_showInfo", "pu_inviteParty", "pu_addFriend", "pu_deleteFriend", "pu_myInfo", 
					"pu_privatChat", "pu_deal", "pu_raising", "pu_profile", "pu_clubUserBan", 
	--				"pu_vanishParty", "pu_chatToUser", "pu_partySecession", "pu_partyCommission", "pu_watchEquipment" , "pu_createParty" , "pu_reportuser", "pu_singleMatch"}
					"pu_vanishParty", "pu_chatToUser", "pu_partySecession", "pu_partyCommission", "pu_watchEquipment" , "pu_createParty", "pu_blockUser" }
					
winMgr:getWindow('pu_vanishParty'):setEnabled(false)

for i=1, #tPopupButtonName do
	winMgr:getWindow('pu_btnContainer'):addChildWindow(tPopupButtonName[i]);
end

-- 이건 광장에서만 쓰이기 때문에 광장쪽으로 빼거나 파티쪽으로 빼는게 좋을 듯하다.
function OnPickCharacter(char_name, titleIndex, myShopMode)
	DebugStr('OnPickCharacter start');
	
	if char_name == nil or char_name == "" then
		return
	end
	
	-- 내캐릭터 인지 아닌지 확인해봐야 한다.
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
	
	
	if g_IsAbataRButtonUp then
		g_IsAbataRButtonUp = false
		return;
	end
	
	g_IsAbataRButtonUp = false
	
	-- 내 이름하고 같지 않으면
	if _my_name ~= char_name then
		local m_pos = mouseCursor:getPosition();
		ShowPopupWindow(m_pos.x, m_pos.y, 1);
		g_strSelectRButtonUp = char_name;
		g_villageUserTitleIndex = titleIndex
		
		local isMyMessengerFriend = IsMyMessengerFriend(char_name);
		DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
		
		--MakeMessengerPopup("pu_myInfo", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty", "pu_deal");
		--1. 팝업친구추가, 팝업친구삭제 는 리스트 검색해서 리스트에 없으면 팝업친구추가, 있으면 팝업친구삭제를 활성화 시켜준다.
		-- 팝업파티초대도 현제 파티 목록에 있는지 없는지 확인한 다음 초대시켜준다.
		-- 퍄태추방 이녀셕도 마찬가지이다. 현재 내 파티 목록에 있고 내가 마스터이면 파티추방을 가능하게 해준다.
		winMgr:getWindow('pu_showInfo'):setEnabled(true)
		
	--	local MYSHOP_MODE_NONE		= 0		-- 일반
	--	local MYSHOP_MODE_READY		= 1		-- 준비중
	--	local MYSHOP_MODE_SELLING	= 2		-- 판매중
	--	local MYSHOP_MODE_VISIT		= 3		-- 상점 구경중
	--	local MYSHOP_MODE_BUYING	= 4		-- 구매중
		
		-- 현재 내가 상점모드인지 체크한다.
		if myShopMode == 0 then		
			
			-- 현재 내 친구 목록 리스트에 있는지 확인한다.(내 친구 목록 리스트에 있으면)
			if isMyMessengerFriend == true then
				DebugStr('===friend already===');
				winMgr:getWindow('pu_addFriend'):setEnabled(false)
				winMgr:getWindow('pu_deleteFriend'):setEnabled(true)
				
			else
				DebugStr('===Not friend===');
				winMgr:getWindow('pu_addFriend'):setEnabled(true)
				winMgr:getWindow('pu_deleteFriend'):setEnabled(false)
			end
			
			-- 내 현재 파티원인지 확인해야 한다.
			if IsMyPartyMember(g_strSelectRButtonUp) == true then
			
				-- 내가 파티장일 경우(파티추방 추가)
				if IsPartyOwner() then
					winMgr:getWindow('pu_vanishParty'):setEnabled(true)
				else
					winMgr:getWindow('pu_vanishParty'):setEnabled(false)
				end
			else
				winMgr:getWindow('pu_vanishParty'):setEnabled(false)
			end
			
			-- 파티 초대는 상대가 파티가 속해 있는지 없는지 확인해야 한다.
			if IsPartyOwner() then
				winMgr:getWindow('pu_inviteParty'):setEnabled(true)
			else
				winMgr:getWindow('pu_inviteParty'):setEnabled(false)
			end
			
			-- 내가 클럽관리자인지 확인한다
			if IsPossibleClubInvite(g_strSelectRButtonUp) == true then
				winMgr:getWindow('pu_raising'):setEnabled(true)
			else
				winMgr:getWindow('pu_raising'):setEnabled(false)
			end
			
			-- 일대일 거래 활성화
			if CheckfacilityData(FACILITYCODE_DEAL) == 1 then
				winMgr:getWindow('pu_deal'):setEnabled(true)
			else
				winMgr:getWindow('pu_deal'):setEnabled(false)
			end
			
			-- 차단하기
			winMgr:getWindow('pu_blockUser'):setEnabled(true)
			
			--winMgr:getWindow('pu_singleMatch'):setEnabled(true)
		else
			winMgr:getWindow('pu_addFriend'):setEnabled(false)
			winMgr:getWindow('pu_deleteFriend'):setEnabled(false)
			winMgr:getWindow('pu_vanishParty'):setEnabled(false)
			winMgr:getWindow('pu_inviteParty'):setEnabled(false)
			winMgr:getWindow('pu_raising'):setEnabled(false)
			winMgr:getWindow('pu_deal'):setEnabled(false)
			winMgr:getWindow('pu_blockUser'):setEnabled(false)
			--winMgr:getWindow('pu_singleMatch'):setEnabled(false)
		end
		
		-- 귓속말도 왠만하면 돼긴하는데..
		winMgr:getWindow('pu_privatChat'):setEnabled(true)
				
	--	MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_singleMatch", "pu_deal" , "pu_reportuser");
		if IsKoreanLanguage() then
			MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_deal");
		else
			MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_deal");
		end
	
	-- 내 이름이면	
	else
		local m_pos = mouseCursor:getPosition();
		ShowPopupWindow(m_pos.x, m_pos.y, 1);
		g_strSelectRButtonUp = char_name;
		g_villageUserTitleIndex = titleIndex
		DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
		
		winMgr:getWindow('pu_myInfo'):setEnabled(true)
		if IsPartyJoined() == true then
			MakeMessengerPopup("pu_windowName", "pu_myInfo", "pu_profile", "pu_partySecession");
		else
			MakeMessengerPopup("pu_windowName", "pu_myInfo", "pu_profile", "pu_createParty");
		end
	end
	
	DebugStr('OnPickCharacter end');
end





---------------------------------------------------------------------

--	광장에서 마우스 오른쪽으로 유저를 클릭할 경우 선택팝업창을 만든다

---------------------------------------------------------------------
function MakeMessengerPopup(...)

	DebugStr('MakeMessengerPopup start');
	
	-- 타입을 지정해준다.
	winMgr:getWindow('pu_windowName'):setVisible(false);
	winMgr:getWindow('sj_messenger_listWindow'):removeChildWindow(winMgr:getWindow('pu_windowName'))
	for i=1, #tPopupButtonName do
		winMgr:getWindow(tPopupButtonName[i]):setVisible(false);
		winMgr:getWindow('sj_messenger_listWindow'):removeChildWindow(winMgr:getWindow(tPopupButtonName[i]))
	end
	
	local para_count = select('#', ...)
	local win_name = 'none';
	
	if para_count > 0 then
		first_win_name = select(1, ...)
		if first_win_name == 'pu_windowName' then			
			winMgr:getWindow('pu_windowName'):setPosition(0, 0)
			winMgr:getWindow('pu_windowName'):setVisible(true)
			winMgr:getWindow('pu_name_text'):setTextExtends(g_strSelectRButtonUp, g_STRING_FONT_GULIMCHE, 112, 51,255,51, 255,   1, 0,0,0,255)
			winMgr:getWindow('pu_btnContainer'):addChildWindow(winMgr:getWindow('pu_windowName'))
			
			for i=2, para_count do
				-- 위치 설정해준다.
				win_name = select(i, ...);
				winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
				winMgr:getWindow(win_name):setVisible(true)
				winMgr:getWindow('pu_btnContainer'):addChildWindow(winMgr:getWindow(win_name))
			end
		else
			for i=1, para_count do
				-- 위치 설정해준다.
				--DebugStr('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
				win_name = select(i, ...);
				winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
				winMgr:getWindow(win_name):setVisible(true)
				winMgr:getWindow('pu_btnContainer'):addChildWindow(winMgr:getWindow(win_name))
			end
		end
	end
	
	winMgr:getWindow('pu_TopImage'):setPosition(0, 0)
	winMgr:getWindow('pu_btnContainer'):setSize(94, para_count*22)
	winMgr:getWindow('pu_BottomImage'):setPosition(0, para_count*22)
		
	DebugStr('MakeMessengerPopup end');
end



tMouseUpEventControlName =
{ ["protecterr"]=0,
"sj_messenger_chatBackWindow_1",
"bj_messengerBackWindow", "sj_messenger_listWindow", "sj_allDesc", "sj_clucDesc", "sj_ladderGradeDesc", 
"sj_tab_friend", "sj_tab_club", "sj_tab_chat", 
"sj_friendListBtn_1", "sj_friendListBtn_2", "sj_friendListBtn_3", "sj_friendListBtn_4", "sj_friendListBtn_5", 
"sj_friendListBtn_6", "sj_friendListBtn_7", "sj_friendListBtn_8", "sj_friendListBtn_9", "sj_friendListBtn_10",
"sj_messenger_chatBtn", "sj_messenger_addFriendBtn", "sj_messenger_deleteFriendBtn", "sj_messenger_closeBtn",
"sj_messenger_prevBtn", "sj_messenger_nextBtn"
}

function OnMouseUpEventControl(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

for i=1, #tMouseUpEventControlName do
	winMgr:getWindow(tMouseUpEventControlName[i]):setSubscribeEvent("MouseButtonUp", "OnMouseUpEventControl");
end




--------------------------------------------------------------------

--	메신저 채팅내용

--------------------------------------------------------------------
g_ChatSelectedIndex = -1;
function OnMessengerChatAccepted(args)
	DebugStr('OnMessengerChatAccepted start');
	DebugStr('g_ChatSelectedIndex : ' .. tostring(g_ChatSelectedIndex));
	
	if g_ChatSelectedIndex < 1 then
		-- 인덱스가 잘못되었다는 말을 뿌려준다.
		local local_multi_line_text = CEGUI.toMultiLineEditbox( winMgr:getWindow(tWhiteMultiLineEditBox[g_ChatSelectedIndex]) );
		local_multi_line_text:addTextExtends('index error : index number -'..tostring(g_ChatSelectedIndex)..'\n', g_STRING_FONT_GULIMCHE, 112, 0,0,0,255,   0, 0,0,0,255);
		return;
	end
	
	-- 현재 대화할려고 시도하는 사람이 현재 (온라인)인지 (오프라인)인지 확인해서. 더이상 이야기 할 수 없다는 말을 띄어준다.
	local name_static_text = winMgr:getWindow(tChatUserRadio[g_ChatSelectedIndex]..'NameText');
	local pos, state = GetMessengerFriendInfo(name_static_text:getText());
	DebugStr('state : ' .. state);
	DebugStr('pos: |' .. pos..'|');
	local isDaejunStrFind = false;
	local _start, _end = string.find(pos, '대전룸');
	
	if _start ~= nil then
		isDaejunStrFind = true;
	end
	
	--if pos ~= "아이템샵" and  pos ~= "대전로비" and
	--	pos ~= "내아이템" and pos ~= "내스킬" and
	--	pos ~= "스킬샵" and pos ~= "광장" and
	--	pos ~= "아케이드룸" and pos ~= "온라인" and
	--	isDaejunStrFind == false then
	--	
	--	local local_multi_line_text = CEGUI.toMultiLineEditbox( winMgr:getWindow(tWhiteMultiLineEditBox[g_ChatSelectedIndex]) );
	--	local_multi_line_text:addTextExtends(name_static_text:getText()..'님은 채팅 불가능한 곳에 있습니다.\n', g_STRING_FONT_GULIMCHE, 112, 255,0,0,255,   0, 0,0,255,255);
	--	winMgr:getWindow("doChattingAtMessenger"):setText('');
	--	return;
		
	--end
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local chat_text = winMgr:getWindow("doChattingAtMessenger"):getText();
	if chat_text == '' then
		return;
	end
	
	-- 채팅필터로 확인한후 메세지를 보낸다.
	local bFilter, filterChat = FindBadWord(winMgr:getWindow("doChattingAtMessenger"):getText());	
	if bFilter == false then
		SendMessengerChatMsg(g_ChatSelectedIndex-1, filterChat);
	else
		SendMessengerChatMsg(g_ChatSelectedIndex-1, chat_text);		
	end
	
	winMgr:getWindow("doChattingAtMessenger"):setText('');
	DebugStr('OnMessengerChatAccepted end');
end


winMgr:getWindow("doChattingAtMessenger"):setSubscribeEvent('TextAccepted', 'OnMessengerChatAccepted');
function OnMessengerEditBoxFull(args)
	PlayWave('sound/FullEdit.wav')
end


-- 한글, 영문모드인지 아이콘을 보여준다
function renderMessagerBackground(args)
	local hanmode = CurrentHanMode()
	if hanmode == 0 then
		winMgr:getWindow("sj_chat_korean"):setVisible(false)
		winMgr:getWindow("sj_chat_english"):setVisible(true)
	elseif hanmode == 1 then
		winMgr:getWindow("sj_chat_korean"):setVisible(true)
		winMgr:getWindow("sj_chat_english"):setVisible(false)
	end
end


winMgr:getWindow("sj_chat_BackImage"):subscribeEvent("EndRender", "renderMessagerBackground" )






--------------------------------------------------------------------

--	대화창관련 UI Control

--------------------------------------------------------------------
tWhiteMultiLineEditBox = { ["protecterr"]=0,
"sj_multichat_1", "sj_multichat_2", "sj_multichat_3", "sj_multichat_4", "sj_multichat_5",
"sj_multichat_6", "sj_multichat_7", "sj_multichat_8", "sj_multichat_9", "sj_multichat_10" }

for i=1, #tWhiteMultiLineEditBox do
	winMgr:getWindow('sj_chat_ViewImage'):addChildWindow(winMgr:getWindow(tWhiteMultiLineEditBox[i]));
end


winMgr:getWindow('sj_messenger_chatBackWindow_1'):addChildWindow(winMgr:getWindow('sj_chat_ViewImage'));
winMgr:getWindow('sj_messenger_chatBackWindow_1'):addChildWindow(winMgr:getWindow('sj_chat_BackImage'));
winMgr:getWindow('sj_messenger_chatBackWindow_1'):addChildWindow(winMgr:getWindow('sj_chat_TopImage'));
winMgr:getWindow('sj_chat_BackImage'):setPosition(10, 300)

-- 메신저 배경창에 에디트박스에 한글, 영어 모드를 붙인다.
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow("doChattingAtMessenger"));
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow('sj_chat_english'));
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow('sj_chat_korean'));

winMgr:getWindow('sj_chat_TopImage'):addChildWindow(winMgr:getWindow('sj_chatuser_Text'));


----------------------------------------------------
--- 캐릭터 선택창으로 돌아갈시 
----------------------------------------------------
function ChangeMessengerInfo()
	DebugStr('ChangeMessengerInfo()')
	for i = 1, 10 do
		winMgr:getWindow(tWhiteMultiLineEditBox[i]):setUserString('UserName', "");
		winMgr:getWindow(tWhiteMultiLineEditBox[i]):clearTextExtends();	
		winMgr:getWindow(tChatUserRadio[i]..'NameText'):setText("");
		winMgr:getWindow(tChatUserRadio[i]..'NameText'):clearTextExtends()
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Selected', 'false');
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Disabled', 'True');
	end
end

function CloseChatSession(index)
	DebugStr('CloseChatSession start');
	
	--일단 현제 세션을 끊어 버린다.
	--DebugStr('끊어버린대상 : ' ..tostring(index));
	-- 채팅창 지워질때 이름으로 찾아서 지우게 한다
	  local strName, strTitle = ChatInfo(index);
	    
	for i = 1, 10 do
		if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == strName then
			winMgr:getWindow(tWhiteMultiLineEditBox[i]):setUserString('UserName', "");
			winMgr:getWindow(tWhiteMultiLineEditBox[i]):clearTextExtends();
			--DebugStr('대화종료한 캐릭터: ' ..strName);
		end
	end
	
	
	--채팅창을 다 사라지게 한다.
	for i=1, 10 do
		winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(false);
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Selected', 'false')--추가
	end
	
	
	-- 종료한 인덱스부터 라디오버튼 정렬
	
		for i=index , 9 do
	
		  UpdateChatSessionIndex(i+1)
	    
		end
	 
	-- 이름을 가져와서 라디오버튼 정렬
	for i=0, 9 do
	    local strName, strTitle = ChatInfo(i);
	 
	    local name_static_text = winMgr:getWindow(tChatUserRadio[i+1]..'NameText');
	    name_static_text:clearTextExtends();
	    name_static_text:addTextExtends(strName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
	    if strName == '' then
	    winMgr:getWindow(tChatUserRadio[i+1]):setProperty('Disabled', 'True');
	    end
	end
	
	
	local session_cnt = GetActiveChatSessionCnt();
	--DebugStr('가능한 채팅창수:' ..session);
	DebugStr('session_cnt : ' .. tostring(session_cnt));
	if session_cnt > 0 then  -- 지우고 남아 있는 상태
	
		-- 가능한 액티브 섹션 하나를 활성화 시킨다.
		local active_session_index = GetActiveChatSessionIndex();
		DebugStr('active_session_index : ' .. tostring(active_session_index));
		winMgr:getWindow(tChatUserRadio[active_session_index+1]):setProperty('Selected', 'true')
	
	 -- 지우고 아무것도 안남아 있는 상태
	else
	    
		-- 아니면 탭을 친구리스트로 선택을 바꿔주고
		
		winMgr:getWindow('sj_tab_friend'):setProperty('Selected', 'True')
		-- 대화창 탭을 비활성화 시킨다.
	winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'True')
	end
	session_cnt = GetActiveChatSessionCnt();
	DebugStr('session_cnt : ' .. tostring(session_cnt));
	
	DebugStr('CloseChatSession end');
end

function DeleteChatSession(index)
end


function OnClickCloseChatButton(args)
	CloseChatSession(g_ChatSelectedIndex-1);
end




tCloseChatButtonName  = { ["protecterr"]=0, "sj_chat_closeBtn" }

for i=1, #tCloseChatButtonName do
	winMgr:getWindow('sj_chat_TopImage'):addChildWindow( winMgr:getWindow(tCloseChatButtonName[i]) );
end


function OnSelectedChatUserRadio(args)	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		g_ChatSelectedIndex = tonumber(local_window:getUserString('Index'));
		local strName, strTitle = ChatInfo(g_ChatSelectedIndex-1);
		
		if strName ~= '' then
			local name_static_text = winMgr:getWindow(tChatUserRadio[g_ChatSelectedIndex]..'NameText');
			winMgr:getWindow(tChatUserRadio[g_ChatSelectedIndex]):setProperty('Disabled', 'false');
			name_static_text:clearTextExtends();
			name_static_text:addTextExtends(strName, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
			name_static_text:setText(strName);
		end
		winMgr:getWindow('sj_chatuser_Text'):clearTextExtends();
		winMgr:getWindow('sj_chatuser_Text'):addTextExtends(strTitle , g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
		
		
		for i = 1, 10 do
			if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == strName then
				winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(true);   --수정부분
			else 
			    winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(false);
			end
		end
	end
end


----------------------------------------------------------------------
-- 라디오 버튼 - 채팅 유저 리스트 만들기 라디오 버튼 만들기
----------------------------------------------------------------------
tChatUserRadio =
{ ["protecterr"]=0, "sj_chat_userList_1", "sj_chat_userList_2", "sj_chat_userList_3", "sj_chat_userList_4", "sj_chat_userList_5", 
					"sj_chat_userList_6", "sj_chat_userList_7", "sj_chat_userList_8", "sj_chat_userList_9",	"sj_chat_userList_10" }
					

for i=1, #tChatUserRadio do
	-- 해장 챗 세션이 액티브 되어 있는지 확인한다.
	winMgr:getWindow('sj_messenger_chatBackWindow_1'):addChildWindow( winMgr:getWindow(tChatUserRadio[i]) );
	
	local find_name = GetSessionNameFromIndex(i-1);
	if find_name ~= 'none' then	
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Disabled', 'False');
	else
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Disabled', 'True');
	end
	
	winMgr:getWindow(tChatUserRadio[i]):setUseEventController(false);
	winMgr:getWindow(tChatUserRadio[i]):clearControllerEvent('FireAlphaChange');
	
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 255, 50, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 50, 255, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 255, 50, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 50, 255, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 255, 50, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 50, 255, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 255, 50, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 50, 255, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 255, 50, 5, false, false, 10);
	winMgr:getWindow(tChatUserRadio[i]):addController('AlphaFireController', 'FireAlphaChange', 'alpha', 'Sine_EaseIn', 50, 255, 5, false, false, 10);
	
	winMgr:getWindow(tChatUserRadio[i]):addChildWindow( winMgr:getWindow(tChatUserRadio[i]..'NameText') );
end

function RefreshChatSessionList()

end

----------------------------------------------------------------------
-- 메세지가 도착했다고 알리는 창
----------------------------------------------------------------------

winMgr:getWindow('DefaultWindow'):addChildWindow(winMgr:getWindow('MsgAlertBalloon'));
winMgr:getWindow('MsgAlertBalloon'):addChildWindow(winMgr:getWindow('MsgAlertBalloonText'));
winMgr:getWindow('MsgAlertBalloonText'):setViewTextMode(1);
winMgr:getWindow('MsgAlertBalloonText'):setAlign(8);
winMgr:getWindow('MsgAlertBalloonText'):setLineSpacing(1);
winMgr:getWindow('MsgAlertBalloonText'):setTextExtends(' 메세지가\n도착하였습니다' , g_STRING_FONT_GULIMCHE, 112,    0,0,255,255,     0,     0,0,0,255);


-- 액션 설정
winMgr:getWindow('MsgAlertBalloon'):clearControllerEvent("AlertVisible");
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 1, 1, 4, true, false, 10);
winMgr:getWindow('MsgAlertBalloon'):addController("MsgAlertBalloonCtrl", "AlertVisible", "visible", "Sine_EaseIn", 0, 0, 2, true, false, 10);









----------------------------------------------------------------------
-- 귓속말 알리는 로직
----------------------------------------------------------------------

function OnReceiveWhisperMsg(name, msg)
	local view_name = '';
	if name == '' then -- 이름이 빈칸으로 왔으면
		view_name = '';
	else
		view_name = '['..name..']'..' : ';
	end
	
	local chatViewContainer = winMgr:getWindow('WhisperChatContainer'):isVisible()
	if chatViewContainer == false then
		winMgr:getWindow('WhisperChatContainer'):setVisible(true);
		-- 여기서 어느 정도 타이밍 돼면 지워주게 한다.
	end
	
	winMgr:getWindow('WhisperChatView'):addTextExtends(view_name..message..'\n', g_STRING_FONT_GULIMCHE,112,   102,204,102,255,    1,    0,0,0,255);
end

function OnWhisperChatAccepted(args)
	DebugStr('OnWhisperChatAccepted start');
	local accept_text = winMgr:getWindow( "WhisperChatInput" ):getText();
	DebugStr('accept_text : ' .. accept_text);
	if accept_text ~= '' then
		SendPrivateMsg( accept_text );
	end
	DebugStr('OnWhisperChatAccepted end');
end

----------------------------------------------------------------------
-- 귓속말 알리는 창
----------------------------------------------------------------------
winMgr:getWindow('DefaultWindow'):addChildWindow( winMgr:getWindow('WhisperChatContainer') );
winMgr:getWindow('WhisperChatContainer'):addChildWindow( winMgr:getWindow('WhisperChatView') );
winMgr:getWindow('WhisperChatContainer'):addChildWindow( winMgr:getWindow('WhisperChatInputContainer') );
winMgr:getWindow('WhisperChatInputContainer'):addChildWindow( winMgr:getWindow('WhisperChatInput') );
winMgr:getWindow('WhisperChatInputContainer'):addChildWindow( winMgr:getWindow('HanTextImage') );
winMgr:getWindow('WhisperChatInputContainer'):addChildWindow( winMgr:getWindow('EngTextImage') );
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow( winMgr:getWindow('MessengerPartyInviteBtn') );
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow( winMgr:getWindow('MessengerPartyLeaveBtn') );



---------------------------------------------------------------------
-- 이벤트 세팅 - 툴 완성되기전까지 이렇게 한다.					   --
---------------------------------------------------------------------
function OnClickPartyAddQuestOk(args)
	DebugStr('OnClickPartyAddQuestOk start');
	winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setVisible(false);
	DebugStr('OnClickPartyAddQuestOk end');
end

function OnClickPartyAddQuestCancel(args)
	DebugStr('OnClickPartyAddQuestCancel start');
	winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setVisible(false);
	DebugStr('OnClickPartyAddQuestCancel end');
end

function OnAcceptPartyAddEditText(args)
	DebugStr('OnAcceptPartyAddEditText start');
	winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setVisible(false);
	DebugStr('OnAcceptPartyAddEditText end');
end


-- 메신저에 있는 파티관련(추후에 구현)
function OnClickMessengerPartyLeave(args)
	DebugStr('OnClickMessengerPartyLeave start');
	
	-- 현제 파티에 가입되어 있는지 알아본다.
	local isJoined = IsPartyJoined();
	DebugStr('isJoined : ' .. tostring(isJoined));
	if isJoined == false then
		ShowCommonAlertOkBoxWithFunction('파티에 가입되어 있지 않았습니다.', 'OnClickAlertOkSelfHide');
	else
		PartyUnJoin(); -- 광장에서만 된다.
	end
	DebugStr('OnClickMessengerPartyLeave end');
end


-- 메신저에 있는 파티관련(추후에 구현)
function OnClickMessengerPartyInvite(args)
	DebugStr('OnClickMessengerPartyInvite start');
	
	-- 파티원 입력창 하나 띄어 준다.
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit('파티 추가할 캐릭터명 입력하시오\n(아직 구현 안됬음)', 
			'OnClickPartyAddQuestOk', 'OnClickPartyAddQuestCancel', 'OnAcceptPartyAddEditText');
	DebugStr('OnClickMessengerPartyInvite end');
end

winMgr:getWindow('MessengerPartyInviteBtn'):setVisible(false);
winMgr:getWindow('MessengerPartyLeaveBtn'):setVisible(false);
winMgr:getWindow('MessengerPartyInviteBtn'):setSubscribeEvent('Clicked', 'OnClickMessengerPartyInvite');
winMgr:getWindow('MessengerPartyLeaveBtn'):setSubscribeEvent('Clicked', 'OnClickMessengerPartyLeave');


chat_active_cnt = GetActiveChatSessionCnt();
if chat_active_cnt > 0 then
	winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'False');
	
	-- 현제 선택된 라디오 박스를 찾는다.
	for i=1, #tChatUserRadio do
		local isSelected = winMgr:getWindow(tChatUserRadio[i]):getProperty('Selected');
		if isSelected == 'True' then
			g_ChatSelectedIndex = i;
			break;
		end
	end
	DebugStr('g_ChatSelectedIndex : ' .. tostring(g_ChatSelectedIndex));
	
end


function EffectCountDecrease()
   g_EffectCount=g_EffectCount-1;
   if  g_EffectCount < 1 then
		Mainbar_ClearEffect(BAR_BUTTONTYPE_MESSAGE)
	end
      
end


----------------------------------------------------------------------
-- 절친 삭제 호출
----------------------------------------------------------------------
function ShowBestFriendDeleteWin()
	DebugStr('ShowBestFriendDeleteWin()')
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit(GetSStringInfo(LAN_BESTFRIEND_DELETE_006) , 
	'OnClickBestFriendDeleteOk', 'OnClickBestFriendDeleteCancel', 'OnAcceptFriendAddEditText');
end


-------------------------------------------------
--절친 삭제 이벤트 ok 
------------------------------------------------
function OnClickBestFriendDeleteOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickBestFriendDeleteOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickBestFriendDeleteOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('name : ' .. winMgr:getWindow('CommonAlertEditBox'):getText());
		
		local	PAGE_MAXITEM = 8	
		for i = 1, PAGE_MAXITEM do 
			if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
				local ListIndex		= 	tonumber(winMgr:getWindow("MyRoom_Item"..i):getUserString('ListIndex'))
				CheckBreakBestFriendItem(ListIndex, winMgr:getWindow('CommonAlertEditBox'):getText())
				break
			end
		end
	end
end

-----------------------------------------------------------------------
-- 절친 추가 에디트 박스에서 취소 눌렀을 때
-----------------------------------------------------------------------
function OnClickBestFriendDeleteCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickBestFriendDeleteCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("noFunction")
		if nofunc ~= "OnClickBestFriendDeleteCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );   --한줄
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		DebugStr('OnClickBestFriendDeleteCancel end');
	end
end



----------------------------------------------------------------------
-- 절친 확장 호출
----------------------------------------------------------------------
function ShowBestFriendExtendWin()
	DebugStr('ShowBestFriendExtendWin()')
end

-- 모든 윈도우를 만든다음에 해야 할것.
winMgr:getWindow('sj_tab_chat'):setProperty("Disabled", "True");
--winMgr:getWindow('sj_tab_friend'):setProperty('Selected', 'True');
