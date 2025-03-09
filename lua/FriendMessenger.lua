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
-- �޽��� ��ǳ��, ȿ�� ����
-----------------------------------------------
winMgr:getWindow('sj_tab_chat'):addChildWindow(winMgr:getWindow('sj_chat_effect'))
winMgr:getWindow('sj_chat_effect'):setVisible(false)


-----------------------------------------------------------------------
-- ģ�� �߰��� ��û
-----------------------------------------------------------------------
function OnRequestFriendOK(name)

	local systemMessage = '[!] '..string.format(PreCreateString_2920, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_1)
	if name ~= "" then
	SeparatesProperly('', systemMessage, 5)
	end
	
end


-----------------------------------------------------------------------
-- ģ�� �߰��ߴµ� ������ ���������� �޴� �̺�Ʈ(ģ�� �߰� ��û�ϴ� ����� �޴� �̺�Ʈ)
-----------------------------------------------------------------------
function OnFriendDenyMsg(msg)
	local systemMessage = '[!] '..string.format(PreCreateString_2923,msg)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_6)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- ģ�� �߰��ߴµ� ������ ���������� �޴� �̺�Ʈ(ģ�� �߰� ��û�ϴ� ����� �޴� �̺�Ʈ)
-----------------------------------------------------------------------
function OnFriendAgree(name)
	local systemMessage = '[!] '..string.format(PreCreateString_2921, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_3)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- ģ�� ������ ���� ������ �޴� �̺�Ʈ ������
-----------------------------------------------------------------------
function OnFriendInfoChanged(name)
	if GetCurWindowName() == 'village' then
		--OnChatPublicWithName('', '[!] '..name..' ���� ������ �Ǿ����ϴ�.', 5);
	end
end

-----------------------------------------------------------------------
-- ģ�� ����
-----------------------------------------------------------------------
function OnFriendDelete(name)
	local systemMessage = '[!] '..string.format(PreCreateString_2922, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_4)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------
-- ģ���߰��� �Ǿ�����
-----------------------------------------------------------------------
function OnFriendAdd(name)
	--local systemMessage = '[!] '..name..'���� ģ���� �߰� �Ǿ����ϴ�.'
	local systemMessage = '[!] '..string.format(PreCreateString_2921, name)	--GetSStringInfo(LAN_LUA_WND_MESSENGER00_3)
	SeparatesProperly('', systemMessage, 5)
end


-----------------------------------------------------------------------

-- ���� ��ġ�� �޼����� ������.

-----------------------------------------------------------------------
function SeparatesProperly(msg1, msg2, state)
	if GetCurWindowName() == 'village' then
		OnChatPublicWithName(msg1, msg2, state)
	else
		OnChatPublic(msg2, state)
	end
end



-----------------------------------------------------------------------

-- AlertBox ����

-----------------------------------------------------------------------
function OnClickAlertOkSelfHide(args)	
	
	if winMgr:getWindow('CommonAlertOkBox') then
		DebugStr('OnClickAlertOkSelfHide start');
		local okFunc = winMgr:getWindow('CommonAlertOkBox'):getUserString("okFunction")
		if okFunc ~= "OnClickAlertOkSelfHide" then
			return
		end
		winMgr:getWindow('CommonAlertOkBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
-- ģ�� �߰� ����Ʈ �ڽ����� Ȯ�� ������ ��
-----------------------------------------------------------------------
function OnClickFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
-- ��ģ �߰� ����Ʈ �ڽ����� Ȯ�� ������ ��
-----------------------------------------------------------------------
function OnClickBestFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickBestFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
-- ��ģ �߰� ����Ʈ �ڽ����� ��� ������ ��
-----------------------------------------------------------------------
function OnClickBestFriendAddQuestCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBox') then
		DebugStr('OnClickBestFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickBestFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickBestFriendAddQuestCancel end');
	end
end

-----------------------------------------------------------------------
-- ģ�� �߰� ����Ʈ �ڽ����� Ȯ�� ������ ��
-----------------------------------------------------------------------
function OnClickFriendAddQuestOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
-- ģ�� �߰� ����Ʈ �ڽ����� ��� ������ ��
-----------------------------------------------------------------------
function OnClickFriendAddQuestCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("noFunction")
		if nofunc ~= "OnClickFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );   --����
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickFriendAddQuestCancel end');
	end
end



-----------------------------------------------------------------------

-- ģ�� �߰� ��� ����Ʈ �ڽ����� ���� ������ -- �̰͵� ģ�� �߰� ���ش�.

-----------------------------------------------------------------------
function OnAcceptFriendAddEditText(args)

end


-----------------------------------------------------------------------
-- ģ�� �߰� Ȯ�� ��ư�� ������ ��
-----------------------------------------------------------------------
function OnClickReceiveFriendAddQuestOk(args)
     
   if winMgr:getWindow('CommonAlertOkCancelBox2') then
		DebugStr('OnClickReceiveFriendAddQuestOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBox2'):getUserString("okFunction")
		if okfunc ~= "OnClickReceiveFriendAddQuestOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox2'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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

-- ģ�� �߰� ��� ��ư�� ������ ��

-----------------------------------------------------------------------

function OnClickReceiveFriendAddQuestCancel(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBox2') then
		DebugStr('OnClickReceiveFriendAddQuestCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBox2'):getUserString("noFunction")
		if nofunc ~= "OnClickReceiveFriendAddQuestCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBox2'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
	if name == '�˸�' then -- �̸��� ��ĭ���� ������
		view_name = '�˸� : ';
	elseif name == '' then
		view_name = '';
	else
		view_name = '['..name..']'..' : ';
	end
	
	chatType = -1;
	if chatType == -1 then		-- 1: �ڽ�(���)
		multi_line_text:addTextExtends(view_name..message..'\n',ChatMySelfFontData[1],ChatMySelfFontData[2], 
										ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],ChatMySelfFontData[6],   
										ChatMySelfFontData[7], 
										ChatMySelfFontData[8],ChatMySelfFontData[9],ChatMySelfFontData[10],ChatMySelfFontData[11]);
	elseif chatType == 1 then
	end
										
										
										
	DebugStr('OnGuildChatRoomMessageReceived end');
end



-----------------------------------------------------------
-- ��Ʈ��ũ�� �̺�Ʈ �ö� �ҷ����� �Լ� cpp���� ȣ�� �ȴ�.
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

-- ���� ��ư �� �޸��� StaticText��(����, ĳ���͸�, Ŭ����, ��ġ, ��������)
tUserInfoTextName = {['protecterr'] = 0, 'LevelText', 'CharNameText', 'PosText', 'InfoBtn' }

for i=1, #tUserButtonName do
	
	winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow(tUserButtonName[i]));
	
	for j=1, #tUserInfoTextName do
		winMgr:getWindow(tUserButtonName[i]):addChildWindow(winMgr:getWindow(tUserButtonName[i]..tUserInfoTextName[j]));
	end
end


-- ���� ������ �� (1.ģ��, 2.��Ƽ,  3.���, 4.��ȭ�� �߿� �ϳ�)
g_CurSelectMainTap = 1;

g_CurFriendListPage = 1;
g_TotalFriendListPage = 5;
g_PageSize = 10;

function RefreshFriendList(selected)	-- selected ���ڴ� ���õȰ��� ��� ���� �Ұ��ΰ� �����ΰ���(��������Ʈ ���� �ڽ��� �Ǿ������Ƿ�)

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
			-- ���� �� ''�� ����� �ش�.
			-- ������ ��ȣ�� ���� �ش�.		
			winMgr:getWindow('PageInfoText'):addTextExtends('1 / 1' , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		else
		    if g_CurFriendListPage<1 then
				g_CurFriendListPage=1
		    end
			winMgr:getWindow('PageInfoText'):addTextExtends(tostring(g_CurFriendListPage)..' / '..tostring(g_TotalFriendListPage) , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		end
		
		for i=1, g_PageSize do
		
			-- �ϴ��� �̸��� ���´�.
			local user_window = winMgr:getWindow('sj_friendListBtn_'..tostring(i));
			
			local static_level_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'LevelText')
			local static_name_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'CharNameText')
			local static_pos_window		= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'PosText')
			local button_info_window	= winMgr:getWindow('sj_friendListBtn_'..tostring(i)..'InfoBtn')
			
			static_level_window:clearTextExtends();
			static_name_window:clearTextExtends();
			static_pos_window:clearTextExtends();
			
				
			-- �̸�, ��ġ, ����, ������ ���´�.
			local name, pos, state, level, ladder = GetFriendList(i, g_CurFriendListPage, g_PageSize)
		
		
			local colorR = 200
			local colorG = 50
			local colorB = 50
			local apply_pos = '��������';
			local pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10);
			if pos ~= '' then
			
				-- �ӽ������� �¶����� ��� ������ �¶��θ� �����ش�.
				if pos ~= '��������' then
					colorR = 200
					colorG = 150
					colorB = 50
					apply_pos = '�¶���'
					pos_output = PreCreateString_1179	--GetSStringInfo(LAN_LUA_WND_MESSENGER_11)
				end
				
			else -- ��ġ�� �ȿ���
				colorR = 200
				colorG = 50
				colorB = 50
				if state == '�¶���' then
					apply_pos = '��������'
					pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
				end
				if state == '������' then
					apply_pos = '������'
				end
				if state == '��ϴ����' then
					apply_pos = '��ϴ����'
				end
			end
			
			
			   
			if name ~= 'none' then
				user_window:setProperty('Disabled', 'False');
				
				-- ģ�� ����
			    static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     255,255,255,255);
				
	            
				-- ģ�� �̸�
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     255,255,255,255);
				static_name_window:setText(name);
												
				-- ģ�� ��ġ
				
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,    colorR,colorG,colorB,255,     0,     255,255,255,255);
				static_pos_window:setText(pos_output);
				
				button_info_window:setVisible(true)	-- ģ�� ��������
				if apply_pos ~= '��������' then
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
-- ��ģ ����Ʈ ��������
-----------------------------------------------------------
function RefreshBestFriendList(selected)	-- selected ���ڴ� ���õȰ��� ��� ���� �Ұ��ΰ� �����ΰ���(��������Ʈ ���� �ڽ��� �Ǿ������Ƿ�)
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
			
				-- ��ģ ����
				static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(level);
				
				-- ��ģ �̸�
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(name);
				
				-- ��ģ ��ġ
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,     colorR,colorG,colorB,255,     0,     0,0,0,255);
				static_pos_window:setText(pos_output);
				
				user_window:setProperty('Disabled', 'False');
				
				
				button_info_window:setVisible(true)	-- ģ�� ��������
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

function RefreshGuildList(selected)	-- selected ���ڴ� ���õȰ��� ��� ���� �Ұ��ΰ� �����ΰ���(��������Ʈ ���� �ڽ��� �Ǿ������Ƿ�)
	DebugStr('RefreshGuildList start');
	if g_CurSelectMainTap == 3 then
		g_TotalGuildListPage = GetTotalGuildPage(g_PageSize);	
		winMgr:getWindow('PageInfoText'):clearTextExtends();
		if g_TotalGuildListPage == 0 then
			-- ���� �� ''�� ����� �ش�.
			-- ������ ��ȣ�� ���� �ش�.		
			winMgr:getWindow('PageInfoText'):addTextExtends('1 / 1' , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		else
			winMgr:getWindow('PageInfoText'):addTextExtends(tostring(g_CurGuildListPage)..' / '..tostring(g_TotalGuildListPage) , g_STRING_FONT_GULIMCHE, 16,    255,255,255,255,     0,     0,0,0,255);
		end
		for i=1, g_PageSize do
		local user_window = winMgr:getWindow('sj_friendListBtn_'..tostring(i));
			
			-- �ϴ��� �̸��� ���´�.
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
				apply_pos = '��������'
				pos_output = PreCreateString_1178	--GetSStringInfo(LAN_LUA_WND_MESSENGER_10)
			else
				colorR = 200
				colorG = 150
				colorB = 50
				pos_output = state
			end
			
			
			if name ~= 'none' then
			
				-- Ŭ���� ����
				static_level_window:setAlign(1)
				static_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(level);
				
				-- Ŭ���� �̸�
				static_name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
				static_name_window:setText(name);
				
				-- Ŭ���� ��ġ
				static_pos_window:addTextExtends(pos_output, g_STRING_FONT_GULIMCHE, 112,     colorR,colorG,colorB,255,     0,     0,0,0,255);
				static_pos_window:setText(pos_output);
				
				user_window:setProperty('Disabled', 'False');
				
				
				button_info_window:setVisible(true)	-- ģ�� ��������
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
--	�޽��� �˾�â�� �������� Ȯ��
-----------------------------------------------------------------------
function ShowFriendMessenger(bFlag)
	
	if bFlag == true then	-- ������
	    g_EffectCount=0;
		
		Mainbar_ClearEffect(BAR_BUTTONTYPE_MESSAGE)
		
		winMgr:getWindow('bj_messengerBackWindow'):setVisible(true);
		root:addChildWindow( winMgr:getWindow('bj_messengerBackWindow') );
		
		-- �̷������� �ϸ� �������� ChangeMyLevel�� �Ѵ�.
		ChangeMyLevel();
		SetMessengerVisible(true);	-- Ŭ���̾�Ʈ�ʿ� �޽����� ���̰� �ִٰ� �˷���
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
		
		
	else -- ������
		ChatSessionEnd(); -- Ȯ���� �ϱ� ���ؼ� end�� �Ѵ�.
		winMgr:getWindow("doChattingAtMessenger"):deactivate();
		SetMessengerVisible(false);	-- Ŭ���̾�Ʈ�ʿ� �޽����� ������ٰ� �˷���
		root:addChildWindow( winMgr:getWindow('bj_messengerBackWindow') );
		winMgr:getWindow('bj_messengerBackWindow'):setVisible(false);
	end
	
end




-----------------------------------------------------------------------

-- ����Ʈ �ڽ��� �����ش�.  ä��â

-----------------------------------------------------------------------
function ShowMultiLineEditBox(index, charName)
	DebugStr('ShowMultiLineEditBox() start');
	DebugStr('index : ' .. tostring(index));
	
	if index < 1 or index > 10 then
		DebugStr('������ ���� �����ϴ�. index : ' .. tostring(index));
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
				DebugStr('ä��â�� ���� ����:'..charName);
				editindex = i;
				ChatBool = true;
	            break;
			end
		end
       
    end
	DebugStr('ShowMultiLineEditBox end');
end



function OnRefreshChatInfo(index, name, info)
    DebugStr('OnRefreshChatInfo');  --�߰�
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

-- �޽��� ���� ������ ���

------------------------------------------------
-- ģ���� ������ ���
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


-- ��ģ �� ������ ���
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


-- Ŭ���� ������ ���
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


-- ��ȭ�� ������ ���
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
			ShowCommonAlertOkBoxWithFunction('ģ�������� �����߽��ϴ�.', 'OnClickAlertOkSelfHide');
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickFriendDeleteQuestCancel end');
	end
end









--------------------------------------------

-- �޽��� ��ư �̺�Ʈ �Լ���

--------------------------------------------
-- 1. ��ȭ�ϱ� �̺�Ʈ �Լ�
function OnClickFriendChat(args)
	for i=1, #tUserButtonName do
		local local_window = winMgr:getWindow(tUserButtonName[i])
		if CEGUI.toRadioButton(local_window):isSelected() then
			local win_name	= local_window:getName()
			local char_name	= winMgr:getWindow(win_name..'CharNameText'):getText()
			local pos_text	= winMgr:getWindow(win_name..'PosText'):getText()

			if pos_text ~= 'ä�μ���' and pos_text ~= '��������' and pos_text ~= pos_off then
				ChatReqLogic(char_name)
			else
				ShowCommonAlertOkBoxWithFunction(string.format(PreCreateString_2019, char_name), 'OnClickAlertOkSelfHide')
			end													--GetSStringInfo(LAN_LUA_WND_MESSENGER_26)
			return
		end
	end
	--ShowCommonAlertOkBoxWithFunction('��ȭ�� ģ���� ������ �ּ���.', 'OnClickAlertOkSelfHide');
	ShowCommonAlertOkBoxWithFunction(PreCreateString_2018, 'OnClickAlertOkSelfHide');
														--GetSStringInfo(LAN_LUA_WND_MESSENGER_25)
end


-- 2. ģ�� �߰��ϱ� �̺�Ʈ �Լ�
function OnClickFriendAdd(args)
	DebugStr('OnClickFriendAdd start');
	local isVirtual = isVirtualLogin();
	
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit(PreCreateString_1184 , 
	'OnClickFriendAddQuestOk', 'OnClickFriendAddQuestCancel', 'OnAcceptFriendAddEditText');
														--GetSStringInfo(LAN_LUA_WND_MESSENGER_16)
	DebugStr('OnClickFriendAdd end');
end

-- 3. ��ģ �߰��ϱ� �̺�Ʈ �Լ�
function OnClickBestFriendAdd(args)
	DebugStr('OnClickBestFriendAdd start');
	
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- ������ ����ִ����� Ȯ���ؾ� �Ѵ�.
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


-- 4. ģ�� �����ϱ� �̺�Ʈ �Լ�
g_FriendDeleteSaveName = '';
function OnClickFriendDelete(args)
	DebugStr('OnClickFriendDelete start');
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- ������ ����ִ����� Ȯ���ؾ� �Ѵ�.
		local str_select_window_name	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'CharNameText'
		local str_select_window_level	= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'LevelText'
		local str_select_window_pos		= 'sj_friendListBtn_'..tostring(g_SelectedUserListIndex)..'PosText'
		local str_name	= winMgr:getWindow( str_select_window_name ):getText();
		local str_level = winMgr:getWindow( str_select_window_level ):getText();
		local str_pos	= winMgr:getWindow( str_select_window_pos ):getText();
		
		DebugStr('str_name : ' .. str_name);
		
		if str_name ~= '' then
			g_FriendDeleteSaveName = str_name;
			--ShowCommonAlertOkCancelBoxWithFunction(str_name, '�԰���\nģ�����踦 �����ðڽ��ϱ�?', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2020, str_name),  'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
		end																--GetSStringInfo(LAN_LUA_WND_MESSENGER_27)
	else
		--ShowCommonAlertOkBoxWithFunction('������ ģ���� ������ �ּ���.', 'OnClickAlertOkSelfHide');
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_1187	, 'OnClickAlertOkSelfHide')           
	end										--GetSStringInfo(LAN_LUA_WND_MESSENGER_19)
	
	DebugStr('OnClickFriendDelete end');
end

-- 5. ��ģ �����ϱ� �̺�Ʈ �Լ�
function OnClickBestFriendDelete(args)
	DebugStr('OnClickBestFriendDelete start');
	if g_SelectedUserWindow ~= nil then		
	end
	
	if g_SelectedUserListIndex > 0 then
		-- ������ ����ִ����� Ȯ���ؾ� �Ѵ�.
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




-- 5. �޽����� �ݴ� �̺�Ʈ �Լ�
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickBestFriendDeleteQuestCancel end');
	end
end


-----------------------------------------------------------------------

--	�޽��� ������ ����

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
	if name == '�˸�' then -- �̸��� ��ĭ���� ������
		view_name = '';
	else
		bAlert = false
		--view_name = '['..name..']'..'���� ��:\n';
		view_name = string.format(PreCreateString_2024, name)
	end								--GetSStringInfo(LAN_MESSENGER_MSG)
	
    g_lastChatReceiveIndex = GetActiveChatSessionCnt();
	--���� ��ư ���� ����
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
	-- ������ �޼����� �����Ҷ� ä��â ������ �̸� ��������� �Ѵ�
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
	  -- ��Ȳ������
	
		if name == '�˸�' then
			--OnChatPublicWithName('�˸�', msg, 5);
		else
			DebugStr('�޽��� ��ǳ��ȿ��1')
			
			Mainbar_ActiveEffect(BAR_BUTTONTYPE_MESSAGE)

			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setProperty('Selected', 'True');
			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setVisible(true) -- ����
			winMgr:getWindow(tChatUserRadio[g_lastChatReceiveIndex]):setProperty('Disabled', 'False');
			winMgr:getWindow(tWhiteMultiLineEditBox[editindex]):setVisible(true);
					
			winMgr:getWindow('sj_tab_chat'):setProperty('Selected', 'True');
			winMgr:getWindow('sj_tab_chat'):setProperty('Disabled', 'False');
		end
	
	
	elseif  msg_visible == false and messenger_visible ==true   then
		if name == '�˸�' then
		else	
		    if CEGUI.toRadioButton( winMgr:getWindow('sj_tab_chat') ):isSelected() ~= true then
				DebugStr('�޽��� ��ǳ��ȿ��2')
				
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
-- �޽��� ���â
-----------------------------------------------
winMgr:getWindow('bj_messengerBackWindow'):setVisible(false)
winMgr:getWindow('bj_messengerBackWindow'):setPosition(377, 149)


-- �޽��� ���â�� �����̴� Titlebar
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_titlebar'))

-- ����Ʈ���â
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_listWindow'))

winMgr:getWindow('sj_messenger_listWindow'):setPosition(14, 133)

-- ä�ù��â
winMgr:getWindow('bj_messengerBackWindow'):addChildWindow(winMgr:getWindow('sj_messenger_chatBackWindow_1'))



----------------------------------------------------------------------
-- ����, ĳ����, Ŭ����, ��� or ���, ��ġ (�� ������ ����ƽ �̹���)
----------------------------------------------------------------------
winMgr:getWindow('sj_messenger_listWindow'):addChildWindow(winMgr:getWindow('sj_allDesc'))
winMgr:getWindow('sj_allDesc'):addChildWindow(winMgr:getWindow('sj_ladderGradeDesc'))
winMgr:getWindow('sj_ladderGradeDesc'):setVisible(false)


--�������

-----------------------------------------------
-- ģ��, ��Ƽ, ��� �ǹ�ư���� ���� ��ư
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

-- ���콺 ���������� ������ ���� �̸� �ʱ�ȭ
function ClearSelectRButtonUser()
	g_strSelectRButtonUp = ""
end


-- ģ�� ���� �������� ȣ�� -�޽������� ȣ��������
function CallUserInfo(args)
	local parent_window = CEGUI.toWindowEventArgs(args).window:getParent():getName()
	local char_name_window = winMgr:getWindow(parent_window..'CharNameText');
	DebugStr('Char Name Text : '..char_name_window:getText());
	g_strSelectRButtonUp = char_name_window:getText();
	GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
	ShowUserInfoWindow()
end

 -- �̵��ϱ�
 
function CallUserMove(args)
 local parent_window = CEGUI.toWindowEventArgs(args).window:getParent():getName()
	local char_name_window = winMgr:getWindow(parent_window..'CharNameText');
	DebugStr('Char Name Text : '..char_name_window:getText());
	g_strSelectRButtonUp = char_name_window:getText();
	
 end



-----------------------------------------------------------------------

-- �޽����� �ִ� ���� ����Ʈ�� ���콺 ��ư ������ ��������..

-----------------------------------------------------------------------
function OnUserListMouseRButtonUp(args)
	DebugStr('OnUserListMouseRButtonUp start');
	local m_pos = mouseCursor:getPosition();
	ShowPopupWindow(m_pos.x, m_pos.y, 1);
	
	-- ĳ���� ������ �˾ƿ´�.
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
	
	if pos_text ~= 'ä�μ���' and pos_text ~= '��������' and pos_text ~= pos_off then
		winMgr:getWindow('pu_chatToUser'):setEnabled(true)
		winMgr:getWindow('pu_privatChat'):setEnabled(true)
	else
		winMgr:getWindow('pu_showInfo'):setEnabled(false) --����
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
	elseif g_CurSelectMainTap == 2 then -- ��Ƽ���϶��� �˾���Ȱ���ϱ� ��Ȱ��ȭ�� ���´�.
	winMgr:getWindow('pu_chatToUser'):setProperty('Disabled', 'True');
	elseif g_CurSelectMainTap == 3 then
	end
end





function ChatReqLogic(char_name)
	DebugStr('ChatReqLogic start');
	
	-- ���� ä�� ���ÿ� ������ ��ȭ ���ϰ� �Ѵ�.
	DebugStr('Char Name Text : '..char_name);
	
	-- ���� ī��Ʈ�� ���´�.
	local active_cnt = GetActiveChatSessionCnt();
	DebugStr('active_cnt : ' .. tostring(active_cnt));
	
	if active_cnt > 9 then
		 -- ���̻� ä��â�� ������ �� �����ϴ�
		 ShowCommonAlertOkBoxWithFunction(PreCreateString_1188, 'OnClickAlertOkSelfHide');
		return;								--GetSStringInfo(LAN_LUA_WND_MESSENGER_20 )
	end
	
	
	-- ���� �̸��� �ش��ϴ� �̸��� ä�ø�Ͽ� �ִ��� Ȯ���Ѵ�. iRet ���� 0~9���� ���´�.
	local success, iRet = RequestChatSession(char_name);
	DebugStr('iRet : ' .. tostring(iRet));

	if success == true then
	else -- ��ȭ ��û�� �ؼ� �����ϸ� �˾�â�� ����ش�.
		--ShowCommonAlertOkBoxWithFunction(char_name..'����\n�������� �����̽��ϴ�.', 'OnClickAlertOkSelfHide');
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
	
	-- ģ������Ʈ �ǵ� ����Ʈ ���ش�.
	
	--ģ������Ʈ ������ ���ֱ� ���� �̸����� ã�´�
	winMgr:getWindow(tChatUserRadio[iRet+1]):setProperty('Disabled', 'False');
	winMgr:getWindow(tChatUserRadio[iRet+1]):setProperty('Selected', 'True');

	g_ChatSelectedIndex = iRet+1;
	DebugStr('ChatReqLogic end');
end




-- ���� ����Ʈ�� ���콺 ����Ŭ�� �Ҷ�
-- �ϴ� ��� �ִ� ���� ����� Ȯ���ϰ� �׿� �ش��ϴ� ��û�� Request�� ������.
function OnUserListDoubleClicked(args)
	
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local win_name		= local_window:getName()
	local char_name		= winMgr:getWindow(win_name..'CharNameText'):getText()
	local pos_text		= winMgr:getWindow(win_name..'PosText'):getText()
	if pos_text ~= 'ä�μ���' and pos_text ~= '��������' and pos_text ~= pos_off then
		ChatReqLogic(char_name);
	else
		--ShowCommonAlertOkBoxWithFunction(char_name..'����\n�������� �����̽��ϴ�.', 'OnClickAlertOkSelfHide');
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
-- ��ȭȭ���ư, ģ���߰���ư, ģ��������ư, �ݱ��ư
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


-- �˾� �ʱ�ȭ
function OnClearUserPopup(exitUserName)
	if g_strSelectRButtonUp == exitUserName then
		if winMgr:getWindow('pu_btnContainer'):isVisible() then
			root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
		end
	end
end

-- �˾� ģ�� �ʴ� ��ư ��������-N
function OnClickPopupPartyInvite(args)
	ShowCommonAlertOkCancelBoxWithFunction("", '������ ģ��', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- �˾� ģ�� �߰� ��ư ��������-N
function OnClickPopupFriendAdd(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� ���� ��ư ��������-N
function OnClickPopupFriendDelete(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� �ӼӸ� ��ư ��������-N
function OnClickPopupWhisper(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� �����ϱ� ��ư ��������-N
function OnClickPopupPlayTogether(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� �°� ��ư ��������-N
function OnClickPopupUpgrade(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� ���� ��ư ��������-N
function OnClickPopupDowngrade(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

-- �˾� ģ�� ���Ż��-N
function OnClickPopupGuildGoOut(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- �˾� ��Ƽ �߰�-N
function OnClickPopupPartyGoOut(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end

-- �˾� ��Ƽ Ż��-N
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

-- �˾� â - �˾� ��ư�� ��� �����̳�

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
		
		-- ��������
		if win_name == 'pu_showInfo' then
			DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
			--InfoVisibleCheck(true);	
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUserInfoWindow()
			
		-- ��Ƽ�ʴ�
		elseif win_name == 'pu_inviteParty' then
			DebugStr('name : ' .. g_strSelectRButtonUp);
			OnClickPartyInvite(g_strSelectRButtonUp)
			
		-- ģ���߰�
		elseif win_name == 'pu_addFriend' then
			DebugStr('name : ' .. g_strSelectRButtonUp);
			local bRet = RequestNewFriend( g_strSelectRButtonUp );
			DebugStr('bRet : ' .. tostring(bRet));
			if bRet == false then
				--ShowCommonAlertOkBoxWithFunction('ģ���߰��� �����߽��ϴ�.', 'OnClickAlertOkSelfHide');
				ShowCommonAlertOkBoxWithFunction(PreCreateString_1173,'OnClickAlertOkSelfHide');
			else									--GetSStringInfo(LAN_LUA_WND_MESSENGER_5)
				OnRequestFriendOK(g_strSelectRButtonUp)
			end	
			
		-- ģ������
		elseif win_name == 'pu_deleteFriend' then
			g_FriendDeleteSaveName = g_strSelectRButtonUp;
			--ShowCommonAlertOkCancelBoxWithFunction(g_FriendDeleteSaveName, '�԰���\nģ�����踦 �����ðڽ��ϱ�?', 'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel')
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_2020, g_FriendDeleteSaveName),  'OnClickFriendDeleteQuestOk', 'OnClickFriendDeleteQuestCancel');
																		--GetSStringInfo(LAN_LUA_WND_MESSENGER_27)
		-- ��������
		elseif win_name == 'pu_myInfo' then
			--InfoVisibleCheck(true);
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUserInfoWindow()
			DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
		
		-- �ӼӸ�
		elseif win_name == 'pu_privatChat' then	
			Chatting_SetChatEditVisible(true)
			Chatting_SetChatSelectedPopup(CHATTYPE_PRIVATE)
			
			winMgr:getWindow("PrivateChatting"):setText(g_strSelectRButtonUp)
			winMgr:getWindow("doChatting"):activate()
			
		-- �ŷ��ϱ�
		elseif win_name == 'pu_deal' then
			ClickedRequestItemTrade(g_strSelectRButtonUp)
		
		--Ŭ���ʴ�
		elseif win_name == 'pu_raising' then
			InviteClubMember(g_strSelectRButtonUp)
			
		--�����ʺ���
		elseif win_name == 'pu_profile' then
		
			ClearGuestBook()
			GetProfileInfo(g_strSelectRButtonUp)
			
		elseif win_name == 'pu_clubUserBan' then
		
		-- ��Ƽ�߹�
		elseif win_name == 'pu_vanishParty' then
			OnClickPartyVanish(g_strSelectRButtonUp) -- �����϶��� �� �� �ְԲ��Ѵ�. �̹� �˾��� �ȶ߰� ���� �ֱ� �ϴ�.
		
		-- ä���ϱ�
		elseif win_name == 'pu_chatToUser' then
			ChatReqLogic(g_strSelectRButtonUp);
		
		-- ��ƼŻ��
		elseif win_name == 'pu_partySecession' then
			OnClickPartyUnJoin()
		
		-- ��Ƽ�� ����
		elseif win_name == "pu_partyCommission" then
			OnClickPartyCommission(g_strSelectRButtonUp)
		
		elseif win_name == "pu_watchEquipment" then
			GetCharacterInfo(g_strSelectRButtonUp, g_villageUserTitleIndex);
			ShowUseGMWearItemShow()
		
		elseif win_name == "pu_createParty" then
			OnSelected_PartyCreate()
		
		elseif win_name == "pu_reportuser" then
			ShowReportWindow(g_strSelectRButtonUp)
			DebugStr('�Ű��ϱ� �˾�')
			
		elseif win_name == "pu_blockUser" then
			ShowCommonAlertOkCancelBoxWithFunction("", string.format(PreCreateString_3591, g_strSelectRButtonUp), 'OnClickUserBlockOK', 'OnClickUserBlockCancel');
			DebugStr('�����ϱ� �˾�')									--GetSStringInfo(LAN_BLOCK_USER_1)
			
		--elseif win_name == "pu_singleMatch" then
		--	ShowSingleMatchInfoToRequest(g_strSelectRButtonUp)
		--	DebugStr('1��1 ����û')
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
		winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		DebugStr('OnClickUserBlockCancel end');
	end
end






----------------------------------------------------------------------

-- �˾� ��ư - ������ ��ư ������ ������

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

-- �̰� ���忡���� ���̱� ������ ���������� ���ų� ��Ƽ������ ���°� ���� ���ϴ�.
function OnPickCharacter(char_name, titleIndex, myShopMode)
	DebugStr('OnPickCharacter start');
	
	if char_name == nil or char_name == "" then
		return
	end
	
	-- ��ĳ���� ���� �ƴ��� Ȯ���غ��� �Ѵ�.
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
	
	
	if g_IsAbataRButtonUp then
		g_IsAbataRButtonUp = false
		return;
	end
	
	g_IsAbataRButtonUp = false
	
	-- �� �̸��ϰ� ���� ������
	if _my_name ~= char_name then
		local m_pos = mouseCursor:getPosition();
		ShowPopupWindow(m_pos.x, m_pos.y, 1);
		g_strSelectRButtonUp = char_name;
		g_villageUserTitleIndex = titleIndex
		
		local isMyMessengerFriend = IsMyMessengerFriend(char_name);
		DebugStr('g_strSelectRButtonUp : ' .. g_strSelectRButtonUp);
		
		--MakeMessengerPopup("pu_myInfo", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty", "pu_deal");
		--1. �˾�ģ���߰�, �˾�ģ������ �� ����Ʈ �˻��ؼ� ����Ʈ�� ������ �˾�ģ���߰�, ������ �˾�ģ�������� Ȱ��ȭ �����ش�.
		-- �˾���Ƽ�ʴ뵵 ���� ��Ƽ ��Ͽ� �ִ��� ������ Ȯ���� ���� �ʴ�����ش�.
		-- �����߹� �̳�Ƶ� ���������̴�. ���� �� ��Ƽ ��Ͽ� �ְ� ���� �������̸� ��Ƽ�߹��� �����ϰ� ���ش�.
		winMgr:getWindow('pu_showInfo'):setEnabled(true)
		
	--	local MYSHOP_MODE_NONE		= 0		-- �Ϲ�
	--	local MYSHOP_MODE_READY		= 1		-- �غ���
	--	local MYSHOP_MODE_SELLING	= 2		-- �Ǹ���
	--	local MYSHOP_MODE_VISIT		= 3		-- ���� ������
	--	local MYSHOP_MODE_BUYING	= 4		-- ������
		
		-- ���� ���� ����������� üũ�Ѵ�.
		if myShopMode == 0 then		
			
			-- ���� �� ģ�� ��� ����Ʈ�� �ִ��� Ȯ���Ѵ�.(�� ģ�� ��� ����Ʈ�� ������)
			if isMyMessengerFriend == true then
				DebugStr('===friend already===');
				winMgr:getWindow('pu_addFriend'):setEnabled(false)
				winMgr:getWindow('pu_deleteFriend'):setEnabled(true)
				
			else
				DebugStr('===Not friend===');
				winMgr:getWindow('pu_addFriend'):setEnabled(true)
				winMgr:getWindow('pu_deleteFriend'):setEnabled(false)
			end
			
			-- �� ���� ��Ƽ������ Ȯ���ؾ� �Ѵ�.
			if IsMyPartyMember(g_strSelectRButtonUp) == true then
			
				-- ���� ��Ƽ���� ���(��Ƽ�߹� �߰�)
				if IsPartyOwner() then
					winMgr:getWindow('pu_vanishParty'):setEnabled(true)
				else
					winMgr:getWindow('pu_vanishParty'):setEnabled(false)
				end
			else
				winMgr:getWindow('pu_vanishParty'):setEnabled(false)
			end
			
			-- ��Ƽ �ʴ�� ��밡 ��Ƽ�� ���� �ִ��� ������ Ȯ���ؾ� �Ѵ�.
			if IsPartyOwner() then
				winMgr:getWindow('pu_inviteParty'):setEnabled(true)
			else
				winMgr:getWindow('pu_inviteParty'):setEnabled(false)
			end
			
			-- ���� Ŭ������������ Ȯ���Ѵ�
			if IsPossibleClubInvite(g_strSelectRButtonUp) == true then
				winMgr:getWindow('pu_raising'):setEnabled(true)
			else
				winMgr:getWindow('pu_raising'):setEnabled(false)
			end
			
			-- �ϴ��� �ŷ� Ȱ��ȭ
			if CheckfacilityData(FACILITYCODE_DEAL) == 1 then
				winMgr:getWindow('pu_deal'):setEnabled(true)
			else
				winMgr:getWindow('pu_deal'):setEnabled(false)
			end
			
			-- �����ϱ�
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
		
		-- �ӼӸ��� �ظ��ϸ� �ű��ϴµ�..
		winMgr:getWindow('pu_privatChat'):setEnabled(true)
				
	--	MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_singleMatch", "pu_deal" , "pu_reportuser");
		if IsKoreanLanguage() then
			MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_deal");
		else
			MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ,"pu_raising", "pu_deal");
		end
	
	-- �� �̸��̸�	
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

--	���忡�� ���콺 ���������� ������ Ŭ���� ��� �����˾�â�� �����

---------------------------------------------------------------------
function MakeMessengerPopup(...)

	DebugStr('MakeMessengerPopup start');
	
	-- Ÿ���� �������ش�.
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
				-- ��ġ �������ش�.
				win_name = select(i, ...);
				winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
				winMgr:getWindow(win_name):setVisible(true)
				winMgr:getWindow('pu_btnContainer'):addChildWindow(winMgr:getWindow(win_name))
			end
		else
			for i=1, para_count do
				-- ��ġ �������ش�.
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

--	�޽��� ä�ó���

--------------------------------------------------------------------
g_ChatSelectedIndex = -1;
function OnMessengerChatAccepted(args)
	DebugStr('OnMessengerChatAccepted start');
	DebugStr('g_ChatSelectedIndex : ' .. tostring(g_ChatSelectedIndex));
	
	if g_ChatSelectedIndex < 1 then
		-- �ε����� �߸��Ǿ��ٴ� ���� �ѷ��ش�.
		local local_multi_line_text = CEGUI.toMultiLineEditbox( winMgr:getWindow(tWhiteMultiLineEditBox[g_ChatSelectedIndex]) );
		local_multi_line_text:addTextExtends('index error : index number -'..tostring(g_ChatSelectedIndex)..'\n', g_STRING_FONT_GULIMCHE, 112, 0,0,0,255,   0, 0,0,0,255);
		return;
	end
	
	-- ���� ��ȭ�ҷ��� �õ��ϴ� ����� ���� (�¶���)���� (��������)���� Ȯ���ؼ�. ���̻� �̾߱� �� �� ���ٴ� ���� ����ش�.
	local name_static_text = winMgr:getWindow(tChatUserRadio[g_ChatSelectedIndex]..'NameText');
	local pos, state = GetMessengerFriendInfo(name_static_text:getText());
	DebugStr('state : ' .. state);
	DebugStr('pos: |' .. pos..'|');
	local isDaejunStrFind = false;
	local _start, _end = string.find(pos, '������');
	
	if _start ~= nil then
		isDaejunStrFind = true;
	end
	
	--if pos ~= "�����ۼ�" and  pos ~= "�����κ�" and
	--	pos ~= "��������" and pos ~= "����ų" and
	--	pos ~= "��ų��" and pos ~= "����" and
	--	pos ~= "�����̵��" and pos ~= "�¶���" and
	--	isDaejunStrFind == false then
	--	
	--	local local_multi_line_text = CEGUI.toMultiLineEditbox( winMgr:getWindow(tWhiteMultiLineEditBox[g_ChatSelectedIndex]) );
	--	local_multi_line_text:addTextExtends(name_static_text:getText()..'���� ä�� �Ұ����� ���� �ֽ��ϴ�.\n', g_STRING_FONT_GULIMCHE, 112, 255,0,0,255,   0, 0,0,255,255);
	--	winMgr:getWindow("doChattingAtMessenger"):setText('');
	--	return;
		
	--end
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local chat_text = winMgr:getWindow("doChattingAtMessenger"):getText();
	if chat_text == '' then
		return;
	end
	
	-- ä�����ͷ� Ȯ������ �޼����� ������.
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


-- �ѱ�, ����������� �������� �����ش�
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

--	��ȭâ���� UI Control

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

-- �޽��� ���â�� ����Ʈ�ڽ��� �ѱ�, ���� ��带 ���δ�.
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow("doChattingAtMessenger"));
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow('sj_chat_english'));
winMgr:getWindow('sj_chat_BackImage'):addChildWindow(winMgr:getWindow('sj_chat_korean'));

winMgr:getWindow('sj_chat_TopImage'):addChildWindow(winMgr:getWindow('sj_chatuser_Text'));


----------------------------------------------------
--- ĳ���� ����â���� ���ư��� 
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
	
	--�ϴ� ���� ������ ���� ������.
	--DebugStr('���������� : ' ..tostring(index));
	-- ä��â �������� �̸����� ã�Ƽ� ����� �Ѵ�
	  local strName, strTitle = ChatInfo(index);
	    
	for i = 1, 10 do
		if winMgr:getWindow(tWhiteMultiLineEditBox[i]):getUserString("UserName") == strName then
			winMgr:getWindow(tWhiteMultiLineEditBox[i]):setUserString('UserName', "");
			winMgr:getWindow(tWhiteMultiLineEditBox[i]):clearTextExtends();
			--DebugStr('��ȭ������ ĳ����: ' ..strName);
		end
	end
	
	
	--ä��â�� �� ������� �Ѵ�.
	for i=1, 10 do
		winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(false);
		winMgr:getWindow(tChatUserRadio[i]):setProperty('Selected', 'false')--�߰�
	end
	
	
	-- ������ �ε������� ������ư ����
	
		for i=index , 9 do
	
		  UpdateChatSessionIndex(i+1)
	    
		end
	 
	-- �̸��� �����ͼ� ������ư ����
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
	--DebugStr('������ ä��â��:' ..session);
	DebugStr('session_cnt : ' .. tostring(session_cnt));
	if session_cnt > 0 then  -- ����� ���� �ִ� ����
	
		-- ������ ��Ƽ�� ���� �ϳ��� Ȱ��ȭ ��Ų��.
		local active_session_index = GetActiveChatSessionIndex();
		DebugStr('active_session_index : ' .. tostring(active_session_index));
		winMgr:getWindow(tChatUserRadio[active_session_index+1]):setProperty('Selected', 'true')
	
	 -- ����� �ƹ��͵� �ȳ��� �ִ� ����
	else
	    
		-- �ƴϸ� ���� ģ������Ʈ�� ������ �ٲ��ְ�
		
		winMgr:getWindow('sj_tab_friend'):setProperty('Selected', 'True')
		-- ��ȭâ ���� ��Ȱ��ȭ ��Ų��.
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
				winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(true);   --�����κ�
			else 
			    winMgr:getWindow(tWhiteMultiLineEditBox[i]):setVisible(false);
			end
		end
	end
end


----------------------------------------------------------------------
-- ���� ��ư - ä�� ���� ����Ʈ ����� ���� ��ư �����
----------------------------------------------------------------------
tChatUserRadio =
{ ["protecterr"]=0, "sj_chat_userList_1", "sj_chat_userList_2", "sj_chat_userList_3", "sj_chat_userList_4", "sj_chat_userList_5", 
					"sj_chat_userList_6", "sj_chat_userList_7", "sj_chat_userList_8", "sj_chat_userList_9",	"sj_chat_userList_10" }
					

for i=1, #tChatUserRadio do
	-- ���� ê ������ ��Ƽ�� �Ǿ� �ִ��� Ȯ���Ѵ�.
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
-- �޼����� �����ߴٰ� �˸��� â
----------------------------------------------------------------------

winMgr:getWindow('DefaultWindow'):addChildWindow(winMgr:getWindow('MsgAlertBalloon'));
winMgr:getWindow('MsgAlertBalloon'):addChildWindow(winMgr:getWindow('MsgAlertBalloonText'));
winMgr:getWindow('MsgAlertBalloonText'):setViewTextMode(1);
winMgr:getWindow('MsgAlertBalloonText'):setAlign(8);
winMgr:getWindow('MsgAlertBalloonText'):setLineSpacing(1);
winMgr:getWindow('MsgAlertBalloonText'):setTextExtends(' �޼�����\n�����Ͽ����ϴ�' , g_STRING_FONT_GULIMCHE, 112,    0,0,255,255,     0,     0,0,0,255);


-- �׼� ����
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
-- �ӼӸ� �˸��� ����
----------------------------------------------------------------------

function OnReceiveWhisperMsg(name, msg)
	local view_name = '';
	if name == '' then -- �̸��� ��ĭ���� ������
		view_name = '';
	else
		view_name = '['..name..']'..' : ';
	end
	
	local chatViewContainer = winMgr:getWindow('WhisperChatContainer'):isVisible()
	if chatViewContainer == false then
		winMgr:getWindow('WhisperChatContainer'):setVisible(true);
		-- ���⼭ ��� ���� Ÿ�̹� �Ÿ� �����ְ� �Ѵ�.
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
-- �ӼӸ� �˸��� â
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
-- �̺�Ʈ ���� - �� �ϼ��Ǳ������� �̷��� �Ѵ�.					   --
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


-- �޽����� �ִ� ��Ƽ����(���Ŀ� ����)
function OnClickMessengerPartyLeave(args)
	DebugStr('OnClickMessengerPartyLeave start');
	
	-- ���� ��Ƽ�� ���ԵǾ� �ִ��� �˾ƺ���.
	local isJoined = IsPartyJoined();
	DebugStr('isJoined : ' .. tostring(isJoined));
	if isJoined == false then
		ShowCommonAlertOkBoxWithFunction('��Ƽ�� ���ԵǾ� ���� �ʾҽ��ϴ�.', 'OnClickAlertOkSelfHide');
	else
		PartyUnJoin(); -- ���忡���� �ȴ�.
	end
	DebugStr('OnClickMessengerPartyLeave end');
end


-- �޽����� �ִ� ��Ƽ����(���Ŀ� ����)
function OnClickMessengerPartyInvite(args)
	DebugStr('OnClickMessengerPartyInvite start');
	
	-- ��Ƽ�� �Է�â �ϳ� ��� �ش�.
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit('��Ƽ �߰��� ĳ���͸� �Է��Ͻÿ�\n(���� ���� �ȉ���)', 
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
	
	-- ���� ���õ� ���� �ڽ��� ã�´�.
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
-- ��ģ ���� ȣ��
----------------------------------------------------------------------
function ShowBestFriendDeleteWin()
	DebugStr('ShowBestFriendDeleteWin()')
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit(GetSStringInfo(LAN_BESTFRIEND_DELETE_006) , 
	'OnClickBestFriendDeleteOk', 'OnClickBestFriendDeleteCancel', 'OnAcceptFriendAddEditText');
end


-------------------------------------------------
--��ģ ���� �̺�Ʈ ok 
------------------------------------------------
function OnClickBestFriendDeleteOk(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickBestFriendDeleteOk start');
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		if okfunc ~= "OnClickBestFriendDeleteOk" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
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
-- ��ģ �߰� ����Ʈ �ڽ����� ��� ������ ��
-----------------------------------------------------------------------
function OnClickBestFriendDeleteCancel(args)
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		DebugStr('OnClickBestFriendDeleteCancel start');
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("noFunction")
		if nofunc ~= "OnClickBestFriendDeleteCancel" then
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );   --����
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		DebugStr('OnClickBestFriendDeleteCancel end');
	end
end



----------------------------------------------------------------------
-- ��ģ Ȯ�� ȣ��
----------------------------------------------------------------------
function ShowBestFriendExtendWin()
	DebugStr('ShowBestFriendExtendWin()')
end

-- ��� �����츦 ��������� �ؾ� �Ұ�.
winMgr:getWindow('sj_tab_chat'):setProperty("Disabled", "True");
--winMgr:getWindow('sj_tab_friend'):setProperty('Selected', 'True');
