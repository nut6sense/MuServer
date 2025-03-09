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


-- 로그인
-- 글 올리기
-- 사진 올리기



local MAX_POSTEDIT = 7			-- 글쓰기의 Editbox 갯수

local g_PostEditIndex = 1		-- PostEdit 관리변수


-- 현재 윈도우가 활성화 되어있는 상태인지( 스크린샷 기능으로인해 visible, enable과는 별개로 관리 )
local g_bActivated = false

-- 스크린샷 업로드
local g_bSendPhoto = false

-- 게시글 올리는중
local g_bUploading = false 



--[[

public : -- windows

	FBLoginAlphaImage		-- 로그인 웹페이지창 알파이미지
	FBLoginBackground		-- 로그인 웹페이지창 프레임
		FBLogin_CloseBtn	-- 로그인 웹페이지창 닫기버튼
	FBLoginTemplate			-- 웹페이지창의 크기를 정하는 윈도우
	
	FBPostBackground		-- 등록창 배경
		FBPost_Titlebar		-- 타이틀바
		FBPost_TitleImage	-- 타이틀 이미지
		FBPost_CloseBtn		-- 닫기버튼
		FBPost_BackImage	-- 배경그림
		FBPost_DescribeBack	-- 내용배경
			FBPost_Describe_1~5	-- 내용
		FBPost_AddPhoto		-- 사진첨부하기 버튼
		FBPost_PhotoName	-- 사진파일 이름
		FBPost_DeletePhoto	-- 사진지우기
		FBPost_Submit		-- 등록버튼
		FBPost_Cancel		-- 취소버튼
		FBPost_Logout		-- 로그아웃 버튼
	
	FBPhotoBackground				-- 사진창 배경
		FBPhoto_Titlebar			-- 타이틀바
		FBPhoto_TitleImage			-- 타이틀이미지
		FBPhoto_CloseBtn			-- 닫기 버튼
		FBPhoto_ListImage			-- 사진 목록 배경
			FBPhoto_List			-- 사진 목록
				FBPhoto_List__auto_vscrollbar__				-- 스크롤바 본체
				FBPhoto_List__auto_vscrollbar____auto_incbtn__	-- 스크롤바 아래 버튼
				FBPhoto_List__auto_vscrollbar____auto_decbtn__	-- 스크롤바 위 버튼
				FBPhoto_List__auto_vscrollbar____auto_thumb__	-- 스크롤바 가운데 버튼
			FBPhotoListScroll_body				-- 스크롤바 본체 이미지
				FBPhotoListScroll_decbtn		-- 스크롤바 아래 버튼 이미지
				FBPhotoListScroll_incbtn		-- 스크롤바 위 버튼 이미지
				FBPhotoListScroll_thumb			-- 스크롤바 가운데 버튼 이미지
		FBPhoto_PreviewBackImage	-- 사진올리기 미리보기 BGImage
			FBPhoto_PreviewBack		-- 사진올리기 미리보기 BG
				FBPhoto_Preview_1~4	-- 사진올리기 미리보기
		FBPhoto_PhotoName			-- 선택한 사진파일 이름
		FBPhoto_Add					-- 첨부 버튼
		FBPhoto_Cancel				-- 취소 버튼

public : -- functions

	function FBLogin_CloseBG()			-- 로그인창 배경 닫기
	function FBLogin_Close()			-- 로그인창 배경, 웹페이지 닫기
	
	function ShowFacebook()				-- 페이스북 시작
	
	function FBPost_Show()				-- 등록 창을 연다
	function FBPost_Close()				-- 등록 창을 닫는다
	function FBPost_SetVisible(b, bClear)		-- 등록 창의 visible을 조정한다
	
	function GetPostEditText()			-- PostEdit의 Text를 조합하여 반환한다
	function FBPost_ClearEdit()			-- 내용 삭제
	
	function FBPhoto_Show()				-- 사진 창을 연다
	function FBPhoto_Close()			-- 사진 창을 닫는다
	function FBPhoto_SetVisible(b)		-- 사진 창의 visible을 조정한다
	function FBPhoto_Init()				-- 사진 창 초기화
	
	function FBPhoto_AddList( str, bHighlight )			-- 리스트에 추가하기
	function FBPhoto_SelectList( args )	-- 파일을 선택한다
	function FBPhoto_ClearList()		-- 리스트 초기화

	
--	function BeforeTakeScreenShot()
--	function AfterTakeScreenShot()
--	function ChangePreview()			-- 스크린샷 프리뷰 이미지를 바꾼다


	function OnClicked_FBPost_DeletePhoto(args) -- 사진 삭제하기

	-- PostEdit 이벤트
	function OnClicked_FBPostEditBack(args)
	function OnActivated_FBPostEdit(args)
	function OnEditboxFull_FBPostEdit(args)
	function OnTextAccepted_FBPostEdit(args)
	function OnTextAcceptedBack_FBPostEdit(args)

	function OnClicked_FBPhoto_Add(args) -- 사진미리보기창 첨부 버튼
	
	function OnClickFacebookScreenshotBtn(args)	-- 스크린샷 찍기 버튼
	
	function OnClickAlertOkSelfHide(args)
	
	-- 스크롤바 그리기
	function FBPhoto_Render()
	function OnFBScrollUpMouseEnter( args )
	function OnFBScrollUpMouseLeave( args )
	function OnFBScrollDownMouseEnter( args )
	function OnFBScrollDownMouseLeave( args )

	
	-- 등록 버튼, 질문
	function OnClicked_FacebookSubmit(args) 
	function OnCheckSubmitYes()
	function OnCheckSubmitNo()
	
	-- 페이스북 로그아웃
	function OnClicked_FacebookLogout( args )
	function OnCheckFacebookLogoutYes()
	function OnCheckFacebookLogoutNo()
	
	-- 등록 완료
	function CompleteFacebookAdd(result)
	
]]--







-- 로그인창 배경 닫기
function FBLogin_CloseBG()
	winMgr:getWindow("FBLoginAlphaImage"):setVisible(false)
	winMgr:getWindow("FBLoginBackground"):setVisible(false)
	
--	FBPost_SetVisible(true)
end

-- 로그인창 닫기
function FBLogin_Close()
	FBLogin_CloseBG()
	HideFacebookLogin()
	CloseFacebook()
	
	-- Activated 상태 초기화
	g_bActivated = false
end


--------------------------------------------------------------------

-- 페이스북 시작

--------------------------------------------------------------------

function ShowFacebook()

	local b = ShowFacebookLogin()
	
	-- 로그인 성공되어 있는 상태이고 현재활성화가 안되어 있을경우에만
	if b == false and g_bActivated == false then
		FBPost_SetVisible(true)
	elseif b == true then
		winMgr:getWindow("FBLoginAlphaImage"):setVisible(true)
		winMgr:getWindow("FBLoginBackground"):setVisible(true)
		
		
		-- 윈도우 위치 조정을 위해 새로 생성
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


-- 등록 창을 연다
function FBPost_Show()
	FBPost_SetVisible(true)
end

-- 등록 창을 닫는다
function FBPost_Close()
	FBPost_SetVisible(false)
end


function FBPost_SetVisible( b, bClear )	-- 등록 창의 visible을 조정한다
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("FBPostBackground"):moveToFront()
		
		-- 내용 초기화
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

-- PostEdit의 Text를 조합하여 반환한다
function GetPostEditText() 
	
	local result = ""
	
	for i = 1, g_PostEditIndex do
		if winMgr:getWindow("FBPost_Describe_" .. i):getText() ~= "" then
			result = result .. winMgr:getWindow("FBPost_Describe_" .. i):getText() .. '\n'
		end
	end
	
	return result
end

-- 내용 삭제
function FBPost_ClearEdit()

	for i = 1, MAX_POSTEDIT do
		winMgr:getWindow("FBPost_Describe_" .. i):setText("")
	end
	
	g_PostEditIndex = 1
end


-- 파일을 선택한다
function FBPhoto_SelectList( args )
--[[
	local sel = CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):getSelectedIndex()
	if sel >= 0 then
	
		local item = CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):getListboxItemFromIndex(sel)
		local text = item:getText()
	end]]
	

	-- 클릭한 위치 문자열 가져오기
	local fileName = CEGUI.toMultiLineEditbox(CEGUI.toWindowEventArgs(args).window):getTextFromPosition(mouseCursor:getPosition().y)
	
	if fileName == "" then
		return
	end
	
	-- 미리보기 밑에 파일이름 셋팅
	winMgr:getWindow("FBPhoto_PhotoName"):setText(fileName)
	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 13, fileName)
	winMgr:getWindow("FBPhoto_PhotoName"):setPosition(495 - textSize/2, 242)
	
	-- 미리보기 이미지 셋팅
	local result = ChangePreviewImage("FBPhoto_Preview_", fileName, 215, 160)
	winMgr:getWindow("FBPhoto_Add"):setEnabled(result) -- 첨부버튼 활성화상태 조정
	
	-- 클릭한 부분 색상 넣어서 다시 보여주기
	-- 처음부터 다시 작성하기 때문에 스크롤 위치가 초기화된다
	-- 때문에 미리 저장해뒀다가 다시 설정해준다
	local pos = GetScrollPosition("FBPhoto_List")
	RefreshPhotoList( fileName )
	SetScrollPosition("FBPhoto_List", pos)
end

-- 리스트 초기화
function FBPhoto_ClearList()
	CEGUI.toMultiLineEditbox(winMgr:getWindow("FBPhoto_List")):clearTextExtends()
end

--[[
-- 리스트에 추가하기
function FBPhoto_AddList(str)

	local cols	  = CEGUI.PropertyHelper:stringToColourRect("tl:AAAAFFAA tr:AAAAFFAA bl:AAAAFFAA br:AAAAFFAA")
	local newItem = CEGUI.createListboxTextItem(str, 0, nil, false, true)
	newItem:setSelectionBrushImage("TaharezLook", "MultiListSelectionBrush")
	newItem:setSelectionColours(cols)

	CEGUI.toListbox(winMgr:getWindow("FBPhoto_List")):addItem(newItem)
end
]]

-- 리스트에 추가하기
function FBPhoto_AddList( str, bHighlight )
	local window = winMgr:getWindow("FBPhoto_List")
	if bHighlight then
		CEGUI.toMultiLineEditbox(window):addTextExtends(str .. "\n", g_STRING_FONT_GULIM, 14, 255,204,0,255, 0, 0,0,0,255 );
	else
		CEGUI.toMultiLineEditbox(window):addTextExtends(str .. "\n", g_STRING_FONT_GULIM, 14, 255,255,255,255, 0, 0,0,0,255 );
	end
end

-- 사진 창을 연다
function FBPhoto_Show()
	FBPhoto_SetVisible(true)
end

-- 사진 창을 닫는다
function FBPhoto_Close()
	FBPhoto_SetVisible(false)
end

-- 사진 창의 visible을 조정한다
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

-- 사진 창 초기화
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




-- 사진 삭제하기
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

-- 사진미리보기창 첨부 버튼
function OnClicked_FBPhoto_Add(args) 
	
	local text = winMgr:getWindow("FBPhoto_PhotoName"):getText()
	winMgr:getWindow("FBPost_PhotoName"):setText(text)
	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, text)
	winMgr:getWindow("FBPost_PhotoName"):setPosition(221 - textSize/2, 287)
	
	FBPhoto_SetVisible(false)
end



-- 스크린샷 찍기 버튼
function OnClickFacebookScreenshotBtn(args)
	TakeScreenShot()
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



-- 스크롤바 그리기
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


-- 등록 버튼
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
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
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
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

-- 페이스북 로그아웃
function OnClicked_FacebookLogout( args )

	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4559, "OnCheckFacebookLogoutYes", "OnCheckFacebookLogoutNo")
												--GetSStringInfo(LAN_MSG_FB_ASK_002)
end

function OnCheckFacebookLogoutYes()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnCheckFacebookLogoutYes" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
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
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
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
		
		-- 초기화
		FBPost_ClearEdit()
		winMgr:getWindow("FBPost_PhotoName"):setText("")
	else
		ShowCommonAlertOkBoxWithFunction(PreCreateString_4552, 'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_MSG_FB_ERR_003)
	end

end







-- 알파 이미지
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

-- 기본 바탕 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
--mywindow:setWideType(6);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- 웹페이지창의 크기를 정하는 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FBLoginTemplate")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198, 220)
mywindow:setSize(645, 325)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("FBLoginBackground", "FBLogin_Close")

-- 닫기버튼
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



-- 등록창 배경
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

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("FBPostBackground", "FBPost_Close")

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "FBPost_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(355, 45)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- 타이틀 이미지
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

-- 닫기버튼
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

-- 배경그림
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

-- 상세내용 배경
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
-- 상세내용
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

-- 사진첨부하기 버튼
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

-- 사진파일 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "FBPost_PhotoName")
mywindow:setEnabled(false)
mywindow:setTextColor(255,204,0,255) -- 241,172,6
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(221, 297)
mywindow:setSize(108, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("FBPostBackground"):addChildWindow(mywindow)

-- 사진지우기
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
	
-- 등록버튼
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

-- 취소버튼
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

-- 로그아웃 버튼
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

	
	
	



-- 사진창 배경
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

-- 바탕이미지 ESC키 등록
RegistEscEventInfo("FBPhotoBackground", "FBPhoto_Close")

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "FBPhoto_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(613, 45)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- 타이틀 이미지
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

-- 닫기버튼
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

-- 사진 목록 배경
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

-- 사진 목록
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


-- 스크롤바 이미지
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




-- 사진올리기 미리보기 BG
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

-- 사진올리기 미리보기
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



-- 사진올리기 미리보기
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

-- 사진파일 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "FBPhoto_PhotoName")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setPosition(495, 252)
mywindow:setSize(108, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("FBPhotoBackground"):addChildWindow(mywindow)

-- 첨부
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

-- 취소
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

