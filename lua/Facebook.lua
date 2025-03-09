--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
--local imgMgr	= CEGUI.ImagesetManager.getSingleton()
local mouseCursor = CEGUI.MouseCursor:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


-- �α���
-- �� �ø���
-- ���� �ø���



local MAX_POSTEDIT = 7			-- �۾����� Editbox ����

local g_PostEditIndex = 1		-- PostEdit ��������


-- ���� �����찡 Ȱ��ȭ �Ǿ��ִ� ��������( ��ũ���� ����������� visible, enable���� ������ ���� )
local g_bActivated = false

-- ��ũ���� ���ε�
local g_bSendPhoto = false

-- �Խñ� �ø�����
local g_bUploading = false 



--[[

public : -- windows

	FBLoginAlphaImage		-- �α��� ��������â �����̹���
	FBLoginBackground		-- �α��� ��������â ������
		FBLogin_CloseBtn	-- �α��� ��������â �ݱ��ư
	FBLoginTemplate			-- ��������â�� ũ�⸦ ���ϴ� ������
	
	FBPostBackground		-- ���â ���
		FBPost_Titlebar		-- Ÿ��Ʋ��
		FBPost_TitleImage	-- Ÿ��Ʋ �̹���
		FBPost_CloseBtn		-- �ݱ��ư
		FBPost_BackImage	-- ���׸�
		FBPost_DescribeBack	-- ������
			FBPost_Describe_1~5	-- ����
		FBPost_AddPhoto		-- ����÷���ϱ� ��ư
		FBPost_PhotoName	-- �������� �̸�
		FBPost_DeletePhoto	-- ���������
		FBPost_Submit		-- ��Ϲ�ư
		FBPost_Cancel		-- ��ҹ�ư
		FBPost_Logout		-- �α׾ƿ� ��ư
	
	FBPhotoBackground				-- ����â ���
		FBPhoto_Titlebar			-- Ÿ��Ʋ��
		FBPhoto_TitleImage			-- Ÿ��Ʋ�̹���
		FBPhoto_CloseBtn			-- �ݱ� ��ư
		FBPhoto_ListImage			-- ���� ��� ���
			FBPhoto_List			-- ���� ���
				FBPhoto_List__auto_vscrollbar__				-- ��ũ�ѹ� ��ü
				FBPhoto_List__auto_vscrollbar____auto_incbtn__	-- ��ũ�ѹ� �Ʒ� ��ư
				FBPhoto_List__auto_vscrollbar____auto_decbtn__	-- ��ũ�ѹ� �� ��ư
				FBPhoto_List__auto_vscrollbar____auto_thumb__	-- ��ũ�ѹ� ��� ��ư
			FBPhotoListScroll_body				-- ��ũ�ѹ� ��ü �̹���
				FBPhotoListScroll_decbtn		-- ��ũ�ѹ� �Ʒ� ��ư �̹���
				FBPhotoListScroll_incbtn		-- ��ũ�ѹ� �� ��ư �̹���
				FBPhotoListScroll_thumb			-- ��ũ�ѹ� ��� ��ư �̹���
		FBPhoto_PreviewBackImage	-- �����ø��� �̸����� BGImage
			FBPhoto_PreviewBack		-- �����ø��� �̸����� BG
				FBPhoto_Preview_1~4	-- �����ø��� �̸�����
		FBPhoto_PhotoName			-- ������ �������� �̸�
		FBPhoto_Add					-- ÷�� ��ư
		FBPhoto_Cancel				-- ��� ��ư

public : -- functions

	function FBLogin_CloseBG()			-- �α���â ��� �ݱ�
	function FBLogin_Close()			-- �α���â ���, �������� �ݱ�
	
	function ShowFacebook()				-- ���̽��� ����
	
	function FBPost_Show()				-- ��� â�� ����
	function FBPost_Close()				-- ��� â�� �ݴ´�
	function FBPost_SetVisible(b, bClear)		-- ��� â�� visible�� �����Ѵ�
	
	function GetPostEditText()			-- PostEdit�� Text�� �����Ͽ� ��ȯ�Ѵ�
	function FBPost_ClearEdit()			-- ���� ����
	
	function FBPhoto_Show()				-- ���� â�� ����
	function FBPhoto_Close()			-- ���� â�� �ݴ´�
	function FBPhoto_SetVisible(b)		-- ���� â�� visible�� �����Ѵ�
	function FBPhoto_Init()				-- ���� â �ʱ�ȭ
	
	function FBPhoto_AddList( str, bHighlight )			-- ����Ʈ�� �߰��ϱ�
	function FBPhoto_SelectList( args )	-- ������ �����Ѵ�
	function FBPhoto_ClearList()		-- ����Ʈ �ʱ�ȭ

	
--	function BeforeTakeScreenShot()
--	function AfterTakeScreenShot()
--	function ChangePreview()			-- ��ũ���� ������ �̹����� �ٲ۴�


	function OnClicked_FBPost_DeletePhoto(args) -- ���� �����ϱ�

	-- PostEdit �̺�Ʈ
	function OnClicked_FBPostEditBack(args)
	function OnActivated_FBPostEdit(args)
	function OnEditboxFull_FBPostEdit(args)
	function OnTextAccepted_FBPostEdit(args)
	function OnTextAcceptedBack_FBPostEdit(args)

	function OnClicked_FBPhoto_Add(args) -- �����̸�����â ÷�� ��ư
	
	function OnClickFacebookScreenshotBtn(args)	-- ��ũ���� ��� ��ư
	
	function OnClickAlertOkSelfHide(args)
	
	-- ��ũ�ѹ� �׸���
	function FBPhoto_Render()
	function OnFBScrollUpMouseEnter( args )
	function OnFBScrollUpMouseLeave( args )
	function OnFBScrollDownMouseEnter( args )
	function OnFBScrollDownMouseLeave( args )

	
	-- ��� ��ư, ����
	function OnClicked_FacebookSubmit(args) 
	function OnCheckSubmitYes()
	function OnCheckSubmitNo()
	
	-- ���̽��� �α׾ƿ�
	function OnClicked_FacebookLogout( args )
	function OnCheckFacebookLogoutYes()
	function OnCheckFacebookLogoutNo()
	
	-- ��� �Ϸ�
	function CompleteFacebookAdd(result)
	
]]--







-- �α���â ��� �ݱ�
function FBLogin_CloseBG()
	winMgr:getWindow("FBLoginAlphaImage"):setVisible(false)
	winMgr:getWindow("FBLoginBackground"):setVisible(false)
	
--	FBPost_SetVisible(true)
end

-- �α���â �ݱ�
function FBLogin_Close()
	FBLogin_CloseBG()
	HideFacebookLogin()
	CloseFacebook()
	
	-- Activated ���� �ʱ�ȭ
	g_bActivated = false
end


--------------------------------------------------------------------

-- ���̽��� ����

--------------------------------------------------------------------

function ShowFacebook()

	local b = ShowFacebookLogin()
	
	-- �α��� �����Ǿ� �ִ� �����̰� ����Ȱ��ȭ�� �ȵǾ� ������쿡��
	if b == false and g_bActivated == false then
		FBPost_SetVisible(true)
	elseif b == true then
		winMgr:getWindow("FBLoginAlphaImage"):setVisible(true)
		winMgr:getWindow("FBLoginBackground"):setVisible(true)
		
		
		-- ������ ��ġ ������ ���� ���� ����
		winMgr:destroyWindow("FBLoginBackground")
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginBackground")
		mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
		mywindow:setframeWindow(true)
		mywindow:setWideType(6);
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		
		local width, height = GetMainWndSize()
		if width == 1024 and height == 768 then
			winMgr:getWindow("FBLoginBackground"):setPosition(189, 183)
			winMgr:getWindow("FBLoginBackground"):setSize(663, 371)
		else
			winMgr:getWindow("FBLoginBackground"):setPosition(192, 198)
			winMgr:getWindow("FBLoginBackground"):setSize(663, 371)
		end
		root:addChildWindow(mywindow)
		mywindow:addChildWindow(winMgr:getWindow("FBLogin_CloseBtn"))
	end
	
end


-- ��� â�� ����
function FBPost_Show()
	FBPost_SetVisible(true)
end

-- ��� â�� �ݴ´�
function FBPost_Close()
	FBPost_SetVisible(false)
end


function FBPost_SetVisible( b, bClear )	-- ��� â�� visible�� �����Ѵ�
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("FBPostBackground"):moveToFront()
		
		-- ���� �ʱ�ȭ
		if bClear == nil then
			FBPost_ClearEdit()
			winMgr:getWindow("FBPost_PhotoName"):setText("")
		elseif bClear == true then
			FBPost_ClearEdit()
			winMgr:getWindow("FBPost_PhotoName"):setText("")
		end
	else
		b = false
	end
	
	winMgr:getWindow("FBPostBackground"):setVisible(b)
end

-- PostEdit�� Text�� �����Ͽ� ��ȯ�Ѵ�
function GetPostEditText() 
	
	local result = ""
	
	for i = 1, g_PostEditIndex do
		if winMgr:getWindow("FBPost_Describe_" .. i):getText() ~= "" then
			result = result .. winMgr:getWindow("FBPost_Describe_" .. i):getText() .. '\n'
		end
	end
	
	return result
end

-- ���� ����
function FBPost_ClearEdit()

	for i = 1, MAX_POSTEDIT do
		winMgr:getWindow("FBPost_Describe_" .. i):setText("")
	end
	
	g_PostEditIndex = 1
end


-- ������ �����Ѵ�
function FBPhoto_SelectList( args )
--[[
	local sel = CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):getSelectedIndex()
	if sel >= 0 then
	
		local item = CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):getListboxItemFromIndex(sel)
		local text = item:getText()
	end]]
	

	-- Ŭ���� ��ġ ���ڿ� ��������
	local fileName = CEGUI.toMultiLineEditbox(CEGUI.toWindowEventArgs(args).window):getTextFromPosition(mouseCursor:getPosition().y)
	
	if fileName == "" then
		return
	end
	
	-- �̸����� �ؿ� �����̸� ����
	winMgr:getWindow("FBPhoto_PhotoName"):setText(fileName)
	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 13, fileName)
	winMgr:getWindow("FBPhoto_PhotoName"):setPosition(495 - textSize/2, 242)
	
	-- �̸����� �̹��� ����
	local result = ChangePreviewImage("FBPhoto_Preview_", fileName, 215, 160)
	winMgr:getWindow("FBPhoto_Add"):setEnabled(result) -- ÷�ι�ư Ȱ��ȭ���� ����
	
	-- Ŭ���� �κ� ���� �־ �ٽ� �����ֱ�
	-- ó������ �ٽ� �ۼ��ϱ� ������ ��ũ�� ��ġ�� �ʱ�ȭ�ȴ�
	-- ������ �̸� �����ص״ٰ� �ٽ� �������ش�
	local pos = GetScrollPosition("FBPhoto_List")
	RefreshPhotoList( fileName )
	SetScrollPosition("FBPhoto_List", pos)
end

-- ����Ʈ �ʱ�ȭ
function FBPhoto_ClearList()
	CEGUI.toMultiLineEditbox(winMgr:getWindow("FBPhoto_List")):clearTextExtends()
end

--[[
-- ����Ʈ�� �߰��ϱ�
function FBPhoto_AddList(str)

	local cols	  = CEGUI.PropertyHelper:stringToColourRect("tl:AAAAFFAA tr:AAAAFFAA bl:AAAAFFAA br:AAAAFFAA")
	local newItem = CEGUI.createListboxTextItem(str, 0, nil, false, true)
	newItem:setSelectionBrushImage("TaharezLook", "MultiListSelectionBrush")
	newItem:setSelectionColours(cols)

	CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):addItem(newItem)
end
]]

-- ����Ʈ�� �߰��ϱ�
function FBPhoto_AddList( str, bHighlight )
	local window = winMgr:getWindow("FBPhoto_List")
	if bHighlight then
		CEGUI.toMultiLineEditbox(window):addTextExtends(str .. "\n", g_STRING_FONT_GULIM, 14, 255,204,0,255, 0, 0,0,0,255 );
	else
		CEGUI.toMultiLineEditbox(window):addTextExtends(str .. "\n", g_STRING_FONT_GULIM, 14, 255,255,255,255, 0, 0,0,0,255 );
	end
end

-- ���� â�� ����
function FBPhoto_Show()
	FBPhoto_SetVisible(true)
end

-- ���� â�� �ݴ´�
function FBPhoto_Close()
	FBPhoto_SetVisible(false)
end

-- ���� â�� visible�� �����Ѵ�
function FBPhoto_SetVisible( b )	
	
	if b == 1 or b == true then
		winMgr:getWindow("FBPhotoBackground"):setVisible(true)
		FBPhoto_Init()
		winMgr:getWindow("FBPhotoBackground"):moveToFront()
		FBPost_SetVisible(false)
	else
		winMgr:getWindow("FBPhotoBackground"):setVisible(false)
		FBPost_SetVisible(true, false)
	end
	
end

-- ���� â �ʱ�ȭ
function FBPhoto_Init()
	
	RefreshPhotoList("")
	
	if winMgr:getWindow("FBPhoto_List__auto_vscrollbar__"):isVisible() == true then
		winMgr:getWindow("FBPhotoListScroll_thumb"):setVisible(true)
	else
		winMgr:getWindow("FBPhotoListScroll_thumb"):setVisible(false)
	end
	
	winMgr:getWindow("FBPhoto_Preview_1"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("FBPhoto_Preview_1"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	for i = 2, 4 do
		winMgr:getWindow("FBPhoto_Preview_" .. i):setVisible(false)
	end
	
	winMgr:getWindow("FBPhoto_PhotoName"):setText("")
	winMgr:getWindow("FBPhoto_Add"):setEnabled(false)
end


-- before, after take screentshot
function BeforeTakeScreenShot()
	if g_bActivated then
		winMgr:getWindow("FacebookWrite"):setVisible(false)
	end
end

function AfterTakeScreenShot()
	if g_bActivated then
		winMgr:getWindow("FacebookWrite"):setVisible(true)
	--	ChangePreview()
	end
end




-- ���� �����ϱ�
function OnClicked_FBPost_DeletePhoto(args)
	winMgr:getWindow("FBPost_PhotoName"):setText("")
end

function OnClicked_FBPostEditBack(args)
	winMgr:getWindow("FBPost_Describe_" .. g_PostEditIndex):activate()
end

local bActivatedFunc = true
function OnActivated_FBPostEdit(args)

	if bActivatedFunc == true then
	
		bActivatedFunc = false
		
		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("FBPost_Describe_" .. g_PostEditIndex):activate()
		
		bActivatedFunc = true
	end
end

function OnEditboxFull_FBPostEdit(args)
	
	if g_PostEditIndex < MAX_POSTEDIT then
		g_PostEditIndex = g_PostEditIndex + 1
		winMgr:getWindow("FBPost_Describe_" .. g_PostEditIndex):activate()
	end
end

function OnTextAccepted_FBPostEdit(args)

	if g_PostEditIndex < MAX_POSTEDIT then
		g_PostEditIndex = g_PostEditIndex + 1
		winMgr:getWindow("FBPost_Describe_" .. g_PostEditIndex):activate()
	end
end

function OnTextAcceptedBack_FBPostEdit(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))
	
	if g_PostEditIndex > 1 and window:getText() == "" then
		g_PostEditIndex = g_PostEditIndex - 1
		winMgr:getWindow("FBPost_Describe_" .. g_PostEditIndex):activate()
	end
end

-- �����̸�����â ÷�� ��ư
function OnClicked_FBPhoto_Add(args) 
	
	local text = winMgr:getWindow("FBPhoto_PhotoName"):getText()
	winMgr:getWindow("FBPost_PhotoName"):setText(text)
	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, text)
	winMgr:getWindow("FBPost_PhotoName"):setPosition(221 - textSize/2, 287)
	
	FBPhoto_SetVisible(false)
end



-- ��ũ���� ��� ��ư
function OnClickFacebookScreenshotBtn(args)
	TakeScreenShot()
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



-- ��ũ�ѹ� �׸���
function FBPhoto_Render()

	if	winMgr:getWindow("FBPhotoBackground"):isVisible() == true and 
		winMgr:getWindow("FBPhoto_List__auto_vscrollbar__"):isVisible() == true then
	
		top1, bottom1, left1, right1 = GetCEGUIWindowRect("FBPhoto_List__auto_vscrollbar____auto_thumb__")
		top2, bottom2, left2, right2 = GetCEGUIWindowRect("FBPhoto_List__auto_vscrollbar__")
		winMgr:getWindow("FBPhotoListScroll_thumb"):setPosition(-1, top1-top2+1)		
	end
	
end

function OnFBScrollUpMouseEnter( args )
	winMgr:getWindow("FBPhotoListScroll_decbtn"):setTexture("Enabled", "UIData/deal5.tga", 986, 77)
	winMgr:getWindow("FBPhotoListScroll_decbtn"):setTexture("Disabled", "UIData/deal5.tga", 986, 77)
end

function OnFBScrollUpMouseLeave( args )
	winMgr:getWindow("FBPhotoListScroll_decbtn"):setTexture("Enabled", "UIData/deal5.tga", 986, 60)
	winMgr:getWindow("FBPhotoListScroll_decbtn"):setTexture("Disabled", "UIData/deal5.tga", 986, 60)
end

function OnFBScrollDownMouseEnter( args )
	winMgr:getWindow("FBPhotoListScroll_incbtn"):setTexture("Enabled", "UIData/deal5.tga", 998, 77)
	winMgr:getWindow("FBPhotoListScroll_incbtn"):setTexture("Disabled", "UIData/deal5.tga", 998, 77)
end

function OnFBScrollDownMouseLeave( args )
	winMgr:getWindow("FBPhotoListScroll_incbtn"):setTexture("Enabled", "UIData/deal5.tga", 998, 60)
	winMgr:getWindow("FBPhotoListScroll_incbtn"):setTexture("Disabled", "UIData/deal5.tga", 998, 60)
end


-- ��� ��ư
function OnClicked_FacebookSubmit(args)

	if g_bUploading == true then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4555, 'OnClickAlertOkSelfHide');	--GetSStringInfo(LAN_MSG_FB_LOADING_001)
	elseif GetPostEditText() == "" and winMgr:getWindow("FBPost_PhotoName"):getText() == "" then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4551, 'OnClickAlertOkSelfHide');	--GetSStringInfo(LAN_MSG_FB_ERR_002)
	else
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4554, "OnCheckSubmitYes", "OnCheckSubmitNo")
	end												--GetSStringInfo(LAN_MSG_FB_ASK_001)
   
end


function OnCheckSubmitYes()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnCheckSubmitYes" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	g_bUploading = true
	ShowCommonAlertOkBoxWithFunction(PreCreateString_4555, 'OnClickAlertOkSelfHide');
										--GetSStringInfo(LAN_MSG_FB_LOADING_001)
	FacebookFeed( GetPostEditText(), winMgr:getWindow("FBPost_PhotoName"):getText() )
end


function OnCheckSubmitNo()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnCheckSubmitNo" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

-- ���̽��� �α׾ƿ�
function OnClicked_FacebookLogout( args )

	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4559, "OnCheckFacebookLogoutYes", "OnCheckFacebookLogoutNo")
												--GetSStringInfo(LAN_MSG_FB_ASK_002)
end

function OnCheckFacebookLogoutYes()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnCheckFacebookLogoutYes" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	FBPost_Close()
	ShowFacebookLogout()
end


function OnCheckFacebookLogoutNo()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnCheckFacebookLogoutNo" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
end

function CompleteFacebookAdd(result)

	OnClickAlertOkSelfHide()
	g_bUploading = false

	if result then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4553, 'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_MSG_FB_OK_001)
		
		-- �ʱ�ȭ
		FBPost_ClearEdit()
		winMgr:getWindow("FBPost_PhotoName"):setText("")
	else
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4552, 'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_MSG_FB_ERR_003)
	end

end







-- ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- �⺻ ���� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
--mywindow:setWideType(6);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- ��������â�� ũ�⸦ ���ϴ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginTemplate")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198, 220)
mywindow:setSize(645, 325)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- �����̹��� ESCŰ ���
RegistEscEventInfo("FBLoginBackground", "FBLogin_Close")

-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBLogin_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(626, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBLogin_Close")
--winMgr:getWindow("FBLoginBackground"):addChildWindow(mywindow)



-- ���â ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPostBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(282, 174)
mywindow:setSize(460, 420)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- �����̹��� ESCŰ ���
RegistEscEventInfo("FBPostBackground", "FBPost_Close")

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "FBPost_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(355, 45)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- Ÿ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPost_TitleImage")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 426, 0)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 426, 0)
mywindow:setPosition(141, 5)
mywindow:setSize(179, 27)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(430, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBPost_Close")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- ���׸�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPost_BackImage")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 0, 0)
mywindow:setPosition(17, 51)
mywindow:setSize(426, 285)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)
mywindow:moveToBack()

-- �󼼳��� ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPost_DescribeBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(33, 66)
mywindow:setSize(395, 156)
mywindow:setEnabled(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("MouseButtonDown", "OnClicked_FBPostEditBack")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- �󼼳���
--------------------------------------------------------------------
for i = 1, MAX_POSTEDIT do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "FBPost_Describe_" .. i)
	mywindow:setText("")
	mywindow:setPosition(12, 14 + ((i-1)*18))
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(358, 16)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setZOrderingEnabled(true)
	mywindow:setEnabled(true)
	mywindow:setUserString("index", tostring(i))
	CEGUI.toEditbox(mywindow):setMaxTextLength(30)
	CEGUI.toEditbox(mywindow):subscribeEvent("Activated", "OnActivated_FBPostEdit")
	CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFull_FBPostEdit")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "OnTextAccepted_FBPostEdit")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedBack", "OnTextAcceptedBack_FBPostEdit")
	winMgr:getWindow('FBPost_DescribeBack'):addChildWindow(mywindow)
	mywindow:moveToFront()
end

-- ����÷���ϱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_AddPhoto")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 426, 147)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 426, 178)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 426, 209)
mywindow:setTexture("Disabled",	"UIData/facebook_001.tga", 426, 241)
mywindow:setPosition(174, 245)
mywindow:setSize(113, 31)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBPhoto_Show")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- �������� �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "FBPost_PhotoName")
mywindow:setEnabled(false)
mywindow:setTextColor(255,204,0,255) -- 241,172,6
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(221, 297)
mywindow:setSize(108, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- ���������
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_DeletePhoto")
mywindow:setTexture("Normal",	"UIData/Profile001.tga", 685, 256)
mywindow:setTexture("Hover",	"UIData/Profile001.tga", 685, 273)
mywindow:setTexture("Pushed",	"UIData/Profile001.tga", 685, 290)
mywindow:setTexture("Disabled", "UIData/Profile001.tga", 685, 307)
mywindow:setPosition(391, 288)
mywindow:setSize(17, 17)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_FBPost_DeletePhoto")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)
	
-- ��Ϲ�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_Submit")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 426, 27)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 426, 57)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 426, 87)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 426, 117)
mywindow:setPosition(96, 357)
mywindow:setSize(117, 30)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClicked_FacebookSubmit")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- ��ҹ�ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_Cancel")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 543, 27)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 543, 57)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 543, 87)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 543, 117)
mywindow:setPosition(248, 357)
mywindow:setSize(117, 30)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBPost_Close")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- �α׾ƿ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPost_Logout")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 539, 147)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 539, 178)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 539, 209)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 539, 240)
mywindow:setPosition(356, 4)
mywindow:setSize(63, 31)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", "OnClicked_FacebookLogout")
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

	
	
	



-- ����â ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhotoBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(185, 188)
mywindow:setSize(654, 393)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- �����̹��� ESCŰ ���
RegistEscEventInfo("FBPhotoBackground", "FBPhoto_Close")

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "FBPhoto_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(613, 45)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- Ÿ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_TitleImage")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 605, 0)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 605, 0)
mywindow:setPosition(238, 5)
mywindow:setSize(179, 27)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPhoto_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(618, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBPhoto_Close")
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- ���� ��� ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_ListImage")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 0, 285)
mywindow:setTexture("Disabled","UIData/facebook_001.tga", 0, 285)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(32, 66)
mywindow:setSize(318, 294)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- ���� ���
--[[mywindow = winMgr:createWindow("TaharezLook/Listbox", "FBPhoto_List")
mywindow:setPosition(25, 46)
mywindow:setSize(300, 180)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:subscribeEvent("MouseDoubleClicked", "FBPhoto_SelectList")
winMgr:getWindow("FBPhoto_ListImage"):addChildWindow(mywindow)
]]

mywindow = winMgr:createWindow("TaharezLook/MultiLineEditbox", "FBPhoto_List");
mywindow:setProperty('ReadOnly', 'true');
mywindow:setProperty('VertScrollbar', 'true');
mywindow:setTextColor(255,255,255,255);
mywindow:setFont(g_STRING_FONT_GULIM, 13);
mywindow:setPosition(0, 0)
mywindow:setSize(318, 294)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setSubscribeEvent("MouseLButtonUp", "FBPhoto_SelectList")
mywindow:setLineSpacing(13)
mywindow:setClippedByParent(true)
winMgr:getWindow("FBPhoto_ListImage"):addChildWindow(mywindow)


-- ��ũ�ѹ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhotoListScroll_body")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 304, 285)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 304, 285)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(304, 0)
mywindow:setSize(14, 294)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("FBPhoto_ListImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhotoListScroll_decbtn")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 986, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 986, 60)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(1, 0)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("FBPhotoListScroll_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhotoListScroll_incbtn")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 998, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 998, 60)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(1, 277)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("FBPhotoListScroll_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhotoListScroll_thumb")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 970, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 970, 60)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(-1, 1)
mywindow:setSize(16, 16)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setClippedByParent(false)
mywindow:moveToFront()
winMgr:getWindow("FBPhotoListScroll_body"):addChildWindow(mywindow)


winMgr:getWindow('FBPhoto_List__auto_vscrollbar__'):setClippedByParent(false)
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_incbtn__'):setSubscribeEvent('MouseEnter', 'OnFBScrollDownMouseEnter');
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_incbtn__'):setSubscribeEvent('MouseLeave', 'OnFBScrollDownMouseLeave');
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_decbtn__'):setSubscribeEvent('MouseEnter', 'OnFBScrollUpMouseEnter');
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_decbtn__'):setSubscribeEvent('MouseLeave', 'OnFBScrollUpMouseLeave');
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_thumb__'):setClippedByParent(false)
winMgr:getWindow('FBPhoto_List__auto_vscrollbar____auto_thumb__'):setAlwaysOnTop(true)




-- �����ø��� �̸����� BG
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_PreviewBackImage")
mywindow:setTexture("Enabled", "UIData/facebook_001.tga", 318, 285)
mywindow:setTexture("Disabled","UIData/facebook_001.tga", 318, 285)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(368, 57)
mywindow:setSize(254, 245)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- �����ø��� �̸�����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_PreviewBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled","UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20, 15)
mywindow:setSize(215, 160)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPhoto_PreviewBackImage"):addChildWindow(mywindow)



-- �����ø��� �̸�����
--[[
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_Preview")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled","UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(215, 160)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("FBPhoto_PreviewBack"):addChildWindow(mywindow)]]
--[[

]]

for i = 1, 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBPhoto_Preview_" .. i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled","UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(215, 160)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("FBPhoto_PreviewBack"):addChildWindow(mywindow)
end

winMgr:getWindow("FBPhoto_Preview_1"):setVisible(true)

-- �������� �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "FBPhoto_PhotoName")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(495, 252)
mywindow:setSize(108, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- ÷��
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPhoto_Add")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 660, 27)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 660, 57)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 660, 87)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 660, 117)
mywindow:setEnabled(false)
mywindow:setPosition(372, 322)
mywindow:setSize(117, 30)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClicked_FBPhoto_Add")
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- ���
mywindow = winMgr:createWindow("TaharezLook/Button", "FBPhoto_Cancel")
mywindow:setTexture("Normal",	"UIData/facebook_001.tga", 543, 27)
mywindow:setTexture("Hover",	"UIData/facebook_001.tga", 543, 57)
mywindow:setTexture("Pushed",	"UIData/facebook_001.tga", 543, 87)
mywindow:setTexture("Disabled", "UIData/facebook_001.tga", 543, 117)
mywindow:setPosition(501, 322)
mywindow:setSize(117, 30)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "FBPhoto_Close")
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

