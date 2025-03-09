guiSystem = CEGUI.System:getSingleton();
winMgr = CEGUI.WindowManager:getSingleton();
root = winMgr:getWindow("DefaultWindow");
root_drawer	= root:getDrawer();
guiSystem:setGUISheet(root);
root:activate();


-- �����̹��� --
backalphawindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonAlertAlphaImg")
backalphawindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
backalphawindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
backalphawindow:setProperty("FrameEnabled", "False")
backalphawindow:setProperty("BackgroundEnabled", "False")
backalphawindow:setPosition(0, 0)
backalphawindow:setSize(1920, 1200)
backalphawindow:setVisible(false)
backalphawindow:setAlwaysOnTop(true)
backalphawindow:setZOrderingEnabled(true)
root:addChildWindow(backalphawindow)


-- ģ���߰��� �����̹��� --
Friendalphawindow = winMgr:createWindow("TaharezLook/StaticImage", "FriendAlertAlphaImg")
Friendalphawindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
Friendalphawindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
Friendalphawindow:setProperty("FrameEnabled", "False")
Friendalphawindow:setProperty("BackgroundEnabled", "False")
Friendalphawindow:setPosition(0, 0)
Friendalphawindow:setSize(1920, 1200)
Friendalphawindow:setVisible(false)
Friendalphawindow:setAlwaysOnTop(true)
Friendalphawindow:setZOrderingEnabled(true)
root:addChildWindow(Friendalphawindow)

-- Ŭ���� �����̹��� --
Clubalphawindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubAlertAlphaImg")
Clubalphawindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
Clubalphawindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
Clubalphawindow:setProperty("FrameEnabled", "False")
Clubalphawindow:setProperty("BackgroundEnabled", "False")
Clubalphawindow:setPosition(0, 0)
Clubalphawindow:setSize(1920, 1200)
Clubalphawindow:setVisible(false)
Clubalphawindow:setAlwaysOnTop(true)
Clubalphawindow:setZOrderingEnabled(true)
root:addChildWindow(Clubalphawindow)


----------------------------------------------------------------------

--	ENTER, ESCŰ ���

----------------------------------------------------------------------
-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("CommonAlertAlphaImg", "CloseCommonAlertOKCancelBox")
RegistEscEventInfo("CommonAlertAlphaImg", "CloseCommonAlertOKCancelBox")


-- ���, �˾�â(Ȯ�ι�ư�� ����)
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickAlertOkSelfHide")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickAlertOkSelfHide")

-- �޽��� ����
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickFriendAddQuestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickFriendAddQuestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickReceiveFriendAddQuestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickReceiveFriendAddQuestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickFriendDeleteQuestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickFriendDeleteQuestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickBestFriendAddQuestOk")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickBestFriendAddQuestCancel")

RegistEnterEventInfo("CommonAlertAlphaImg", "OnAddBtnOKEvent")
RegistEscEventInfo("CommonAlertAlphaImg", "OnAddBtnCancelEvent")


-- ���� ����
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickMailDeleteQuestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickMailUseOk")

-- �̺�Ʈ ����
RegistEscEventInfo("CommonAlertAlphaImg", "RecommendFriendCANCELFunction")
RegistEnterEventInfo("CommonAlertAlphaImg", "RecommendFriendOKFunction")

-- ��Ƽ����
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickPartyInvitedQuestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickPartyInvitedQuestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickPartyTriedQuestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickPartyTriedQuestCancel")



-- ������, ������ ����
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickPresentUseCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnDirectlyWearOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnDirectlyWearCancel")


-- ä�� �̵��� ��Ƽüũ
RegistEscEventInfo("CommonAlertAlphaImg", "PartyCheckCancelButton")
RegistEnterEventInfo("CommonAlertAlphaImg", "PartyCheckOkButton")

-- �����κ�� �̵� üũ
RegistEscEventInfo("CommonAlertAlphaImg", "CancelGoBattle")
RegistEnterEventInfo("CommonAlertAlphaImg", "GoToBattle")

-- ���̼� ����üũ
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickClosedRegistMyShopCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickClosedRegistMyShopOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickMyShopStartCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickMyShopStartOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickMyShopRefreshCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickMyShopRefreshOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickMyShopBuyCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickMyShopBuyOk")

-- 1:1�ŷ� ����üũ
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickTradeRequestCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickTradeRequestOk")
RegistEscEventInfo("CommonAlertAlphaImg", "OnClickTradeCloseCancel")
RegistEnterEventInfo("CommonAlertAlphaImg", "OnClickTradeCloseOk")


function EmptyCancel()
end

function CloseCommonAlertOKCancelBox()

	local okFunc = winMgr:getWindow('CommonAlertOkBox'):getUserString("okFunction")
	if okFunc ~= "CloseCommonAlertOKCancelBox" then
		return
	end
	winMgr:getWindow('CommonAlertOkBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
end


--- OK �˸�â ---
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkBox');
mywindow:setSize(349, 276);
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setVisible(false);
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
root:addChildWindow( winMgr:getWindow('CommonAlertOkBox') );


-- �˸�â Ȯ�ι�ư(OK) --
tWinButtonName = {['protecterr'] = 0, 'CommonAlertOk'}
tTextureX = {['protecterr'] = 0, 693 }
tTextureY = {['protecterr'] = 0, 617 }
tTextureHoverX = {['protecterr'] = 0, 693 }
tTextureHoverY = {['protecterr'] = 0, 646 }
tTexturePushedX = {['protecterr'] = 0, 693 }
tTexturePushedY = {['protecterr'] = 0, 675 }
nSizeX = 331
nSizeY = 29
tPosX = {['protecterr'] = 0, 4}
tPosY = {['protecterr'] = 0, 235}

for i=1, #tWinButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);	
	mywindow:subscribeEvent("Clicked", "CloseCommonAlertOKCancelBox")
	
end


winMgr:getWindow('CommonAlertOkBox'):addChildWindow( winMgr:getWindow('CommonAlertOk') );

local Common_String_Not_Class	= PreCreateString_1089	--GetSStringInfo(LAN_LUA_COMMON_AB_1)
tWinName = {['protecterr'] = 0,'CommonAlertOkBox_Text'}
tWinText = {['protecterr'] = 0, Common_String_Not_Class}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(100, 100);
	_window:setSize(340, 180);
	_window:setText("");
	_window:setVisible(true);
	_window:setEnabled(false)
	
	_window:setPosition(0, 126);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(8);
	_window:setLineSpacing(1);
	
	_window:setPosition(3, 45);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(7);
	_window:setLineSpacing(1);

	winMgr:getWindow('CommonAlertOkBox'):addChildWindow(_window);
end



-------------------------------------------------------

-- OK 1���� �ִ� �Լ���

-------------------------------------------------------
function ShowCommonAlertOkBox(arg)
    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox');
	local_window:setUserString("okFunction", "CloseCommonAlertOKCancelBox")
	root:addChildWindow(local_window);
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 14,255,255,255,255,    0, 0,0,0,255);
end

function ShowCommonAlertOkBox2(specialArg, arg)
    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox');
	local_window:setUserString("okFunction", "CloseCommonAlertOKCancelBox")
	root:addChildWindow(local_window);
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(specialArg, g_STRING_FONT_DODUMCHE, 215,255,205,86,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
end

function ShowCommonAlertOkBoxWithFunctionEmphasis(emphasis, arg, argFunc)
	DebugStr('ShowCommonAlertOkBoxWithFunction start');
	local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox');
	local_window:setUserString("okFunction", argFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setVisible(true)
		
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_txt_window:clearTextExtends();
	if emphasis ~= "" then
		local_txt_window:addTextExtends(emphasis, g_STRING_FONT_DODUMCHE, 15,255,200,80,255,    1, 0,0,0,255);
	end
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertOk'):setSubscribeEvent("Clicked", argFunc);
	
	DebugStr('ShowCommonAlertOkBoxWithFunction end');
end

function ShowCommonAlertOkBoxWithFunction(arg, argFunc)
	DebugStr('ShowCommonAlertOkBoxWithFunction start');
	local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox');
	local_window:setUserString("okFunction", argFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setVisible(true)
		
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertOk'):setSubscribeEvent("Clicked", argFunc);
	
	DebugStr('ShowCommonAlertOkBoxWithFunction end');
end

function ShowCommonAlertOkBoxWithFunction2(specialArg, arg, argFunc)
	DebugStr('ShowCommonAlertOkBoxWithFunction start');
	local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox')
	local_window:setUserString("okFunction", argFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setVisible(true)
		
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(specialArg, g_STRING_FONT_DODUMCHE, 15, 255,205,86,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertOk'):setSubscribeEvent("Clicked", argFunc);
	
	DebugStr('ShowCommonAlertOkBoxWithFunction end');
end

function ShowCommonAlertOkBoxWithFunction3(specialArg, arg, argFunc, r, g, b)
	DebugStr('ShowCommonAlertOkBoxWithFunction start');
	local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkBox')
	local_window:setUserString("okFunction", argFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setVisible(true)
		
	local local_txt_window = winMgr:getWindow('CommonAlertOkBox_Text');
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(specialArg, g_STRING_FONT_DODUMCHE, 15, r,g,b,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertOk'):setSubscribeEvent("Clicked", argFunc);
	
	DebugStr('ShowCommonAlertOkBoxWithFunction end');
end


--- �˸�â OK/CANCEL ---
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkCancelBox');
mywindow:setSize(349, 276);
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setProperty("FrameEnabled", "False");
mywindow:setProperty("BackgroundEnabled", "False");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")



tWinButtonName = {['protecterr'] = 0, 'CommonAlertQuestOk', 'CommonAlertQuestCancel'}
-- 864, 485
-- 945, 485
--[[
tTextureX = {['protecterr'] = 0, 864, 944 }
tTextureY = {['protecterr'] = 0, 485, 485 }
tTextureHoverX = {['protecterr'] = 0, 864, 944 }
tTextureHoverY = {['protecterr'] = 0, 485+34, 485+34 }
tTexturePushedX = {['protecterr'] = 0, 864, 944 }
tTexturePushedY = {['protecterr'] = 0, 485+34*2, 485+34*2 }
--]]
tTextureX = {['protecterr'] = 0, 693, 858 }
tTextureY = {['protecterr'] = 0, 849, 849 }
tTextureHoverX = {['protecterr'] = 0, 693, 858 }
tTextureHoverY = {['protecterr'] = 0, 878, 878 }
tTexturePushedX = {['protecterr'] = 0, 693, 858 }
tTexturePushedY = {['protecterr'] = 0, 907, 907 }

--80 , 34
nSizeX = 166
nSizeY = 29
tPosX = {['protecterr'] = 0, 4, 169}
tPosY = {['protecterr'] = 0, 235, 235 }

for i=1, #tWinButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);
end


winMgr:getWindow('CommonAlertOkCancelBox'):addChildWindow( winMgr:getWindow('CommonAlertQuestOk') );
winMgr:getWindow('CommonAlertOkCancelBox'):addChildWindow( winMgr:getWindow('CommonAlertQuestCancel') );


-- �˸�â ���� ���� ���

mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkCancelBox2');
mywindow:setSize(349, 276);
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setProperty("FrameEnabled", "False");
mywindow:setProperty("BackgroundEnabled", "False");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")



tWinButtonName2 = {['protecterr'] = 0, 'CommonAlertQuestOk2', 'CommonAlertQuestCancel2'}
-- 864, 485
-- 945, 485

tTextureX = {['protecterr'] = 0, 693, 858 }
tTextureY = {['protecterr'] = 0, 733, 733 }
tTextureHoverX = {['protecterr'] = 0, 693, 858 }
tTextureHoverY = {['protecterr'] = 0, 762, 762 }
tTexturePushedX = {['protecterr'] = 0, 693, 858 }
tTexturePushedY = {['protecterr'] = 0, 791, 791 }
nSizeX = 166
nSizeY = 29
tPosX = {['protecterr'] = 0, 4, 169}
tPosY = {['protecterr'] = 0, 235, 235 }


for i=1, #tWinButtonName2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName2[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);
end


winMgr:getWindow('CommonAlertOkCancelBox2'):addChildWindow( winMgr:getWindow('CommonAlertQuestOk2') );
winMgr:getWindow('CommonAlertOkCancelBox2'):addChildWindow( winMgr:getWindow('CommonAlertQuestCancel2') );



-- Ŭ�� ���� ���� â

mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkCancelBox3');
mywindow:setSize(349, 276);
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setProperty("FrameEnabled", "False");
mywindow:setProperty("BackgroundEnabled", "False");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")



tWinButtonName3 = {['protecterr'] = 0, 'CommonAlertQuestOk3', 'CommonAlertQuestCancel3'}
-- 864, 485
-- 945, 485

tTextureX = {['protecterr'] = 0, 693, 858 }
tTextureY = {['protecterr'] = 0, 733, 733 }
tTextureHoverX = {['protecterr'] = 0, 693, 858 }
tTextureHoverY = {['protecterr'] = 0, 762, 762 }
tTexturePushedX = {['protecterr'] = 0, 693, 858 }
tTexturePushedY = {['protecterr'] = 0, 791, 791 }
nSizeX = 166
nSizeY = 29
tPosX = {['protecterr'] = 0, 4, 169}
tPosY = {['protecterr'] = 0, 235, 235 }


for i=1, #tWinButtonName3 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName3[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);
end


winMgr:getWindow('CommonAlertOkCancelBox3'):addChildWindow( winMgr:getWindow('CommonAlertQuestOk3') );
winMgr:getWindow('CommonAlertOkCancelBox3'):addChildWindow( winMgr:getWindow('CommonAlertQuestCancel3') );







local Common_String_Do_It	= PreCreateString_1090	--GetSStringInfo(LAN_LUA_COMMON_AB_2)

tWinName = {['protecterr'] = 0,'CommonAlertOkCancelBox_Text'}
tWinText = {['protecterr'] = 0, Common_String_Do_It}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(100, 43);
	_window:setSize(340, 180);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
	_window:setEnabled(false)
	_window:setPosition(3, 45);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(7);
	_window:setLineSpacing(1);
	winMgr:getWindow('CommonAlertOkCancelBox'):addChildWindow(_window);
	
end

tWinName2 = {['protecterr'] = 0,'CommonAlertOkCancelBox_Text2'}
for i=1, #tWinName2 do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName2[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(100, 43);
	_window:setSize(340, 180);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
	_window:setEnabled(false)
	_window:setPosition(3, 45);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(7);
	_window:setLineSpacing(1);
	winMgr:getWindow('CommonAlertOkCancelBox2'):addChildWindow(_window);
	
end   
     
tWinName3 = {['protecterr'] = 0,'CommonAlertOkCancelBox_Text3'}
for i=1, #tWinName3 do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName3[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(100, 43);
	_window:setSize(340, 180);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
	_window:setEnabled(false)
	_window:setPosition(3, 45);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(7);
	_window:setLineSpacing(1);
	winMgr:getWindow('CommonAlertOkCancelBox3'):addChildWindow(_window);
	
end   
-------------------------------------------------------

-- OK, CANCEL 2���� �ִ� �Լ���

-------------------------------------------------------
function ShowCommonAlertOkCancelBox(arg)
    DebugStr('okcancel�ڽ�Ȯ��')
    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:setUserString("okFunction", "CloseCommonAlertOKCancelBox")
	local_window:setUserString("noFunction", "CloseCommonAlertOKCancelBox")
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(local_window)
	local_window:setWideType(6);
	local_window:setPosition(338, 246);
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
end

-- �տ� emphasis(����) �߰� �����κ��� ������ Ʋ���� ��
function ShowCommonAlertOkCancelBoxWithFunction(emphasis, arg, argYesFunc, argNoFunc)
    
    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(local_window)
	local_window:setVisible(true)
	local_window:setWideType(6);
	local_window:setPosition(338, 246);
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	if emphasis ~= "" then
		local_txt_window:addTextExtends(emphasis, g_STRING_FONT_DODUMCHE, 15, 255,200,80,255,    1, 0,0,0,255);
	end
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel'):setSubscribeEvent("Clicked", argNoFunc);
end

--  ��ư ���� ���� ----------------------------------------------------------------------
function ShowCommonAlertRejectBoxWithFunction(emphasis, arg, argYesFunc, argNoFunc)

  --  local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	--if aa >= 1 then
	--	local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
	--	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	--end
    
	winMgr:getWindow('FriendAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('FriendAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox2')
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('FriendAlertAlphaImg'):addChildWindow(local_window)
	local_window:setWideType(6);
	local_window:setPosition(338, 246);
	local_window:setVisible(true)
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text2');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	if emphasis ~= "" then
		local_txt_window:addTextExtends(emphasis, g_STRING_FONT_DODUMCHE, 15, 255,200,80,255,    1, 0,0,0,255);
	end
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestOk2'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel2'):setSubscribeEvent("Clicked", argNoFunc);
end


--  Ŭ���� �ʴ� ���� ���� ----------------------------------------------------------------------
function ClubCommonAlertRejectBoxWithFunction(emphasis, arg, argYesFunc, argNoFunc)
   
	winMgr:getWindow('ClubAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('ClubAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox3')
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('ClubAlertAlphaImg'):addChildWindow(local_window)
	local_window:setVisible(true)
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text3');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	if emphasis ~= "" then
		local_txt_window:addTextExtends(emphasis, g_STRING_FONT_DODUMCHE, 15, 255,200,80,255,    1, 0,0,0,255);
	end
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestOk3'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel3'):setSubscribeEvent("Clicked", argNoFunc);
end


function ShowCommonAlertOkCancelBoxWithFunction2(specialArg, arg, argYesFunc, argNoFunc)

    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setVisible(true)
	
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(specialArg, g_STRING_FONT_DODUMCHE, 15, 255,205,86,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel'):setSubscribeEvent("Clicked", argNoFunc);
end

function ShowCommonAlertOkCancelBoxWithFunction3(arg, argYesFunc, argNoFunc)

    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg'));
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(local_window);
	local_window:setVisible(true)
	winMgr:getWindow('CommonAlertOkCancelBox'):addChildWindow(arg);	
	
	winMgr:getWindow('CommonAlertOkCancelBox_Text'):clearTextExtends();
	winMgr:getWindow('CommonAlertQuestOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel'):setSubscribeEvent("Clicked", argNoFunc);

end


function ShowCommonAlertOkCancelBoxWithFunction_Ex(specialArg1, specialArg2, arg, argYesFunc, argNoFunc)
    
    local aa= winMgr:getWindow('CommonAlertAlphaImg'):getChildCount()
	if aa >= 1 then
		local bb= winMgr:getWindow('CommonAlertAlphaImg'):getChildAtIdx(0)  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(bb)		
	end
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow(local_window);
	local_window:setVisible(true)
	
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_Text');
	local_window:setVisible(true)
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(specialArg1, g_STRING_FONT_DODUMCHE, 15, 97,230,255,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(specialArg2, g_STRING_FONT_DODUMCHE, 15, 255,205,86,255,   1, 0,0,0,255);
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestCancel'):setSubscribeEvent("Clicked", argNoFunc);
end





--------------------------------------------------------------------------------------------------------------------
--- �˸�â OK/CANCEL+EDITBOX ---
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkCancelBoxWithEdit');
mywindow:setSize(349, 276);
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true);
mywindow:setZOrderingEnabled(false);
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")



tWinButtonName = {['protecterr'] = 0, 'CommonAlertQuestWithEditOk', 'CommonAlertQuestWithEditCancel'}
-- 864, 485
-- 945, 485
--[[
tTextureX = {['protecterr'] = 0, 864, 944 }
tTextureY = {['protecterr'] = 0, 485, 485 }
tTextureHoverX = {['protecterr'] = 0, 864, 944 }
tTextureHoverY = {['protecterr'] = 0, 485+34, 485+34 }
tTexturePushedX = {['protecterr'] = 0, 864, 944 }
tTexturePushedY = {['protecterr'] = 0, 485+34*2, 485+34*2 }
--]]

tTextureX = {['protecterr'] = 0, 693, 858 }
tTextureY = {['protecterr'] = 0, 849, 849 }
tTextureHoverX = {['protecterr'] = 0, 693, 858 }
tTextureHoverY = {['protecterr'] = 0, 878, 878 }
tTexturePushedX = {['protecterr'] = 0, 693, 858 }
tTexturePushedY = {['protecterr'] = 0, 907, 907 }

nSizeX = 166
nSizeY = 29
tPosX = {['protecterr'] = 0, 4, 169}
tPosY = {['protecterr'] = 0, 235, 235 }

for i=1, #tWinButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);
end


winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):addChildWindow( winMgr:getWindow('CommonAlertQuestWithEditOk') );
winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):addChildWindow( winMgr:getWindow('CommonAlertQuestWithEditCancel') );


tWinName = {['protecterr'] = 0,'CommonAlertOkCancelBox_TextWithEdit'}
tWinText = {['protecterr'] = 0,Common_String_Do_It}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setSize(349, 70);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
	_window:setAlwaysOnTop(true)
	_window:setProperty('Disabled', 'True');
	
	_window:setPosition(0, 100);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(8);
	_window:setLineSpacing(1);
	winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):addChildWindow(_window);
end


alert_edit_window = winMgr:createWindow("TaharezLook/Editbox", "CommonAlertEditBox")
alert_edit_window:setText("")
alert_edit_window:setPosition(85, 144)
alert_edit_window:setSize(176, 22)
alert_edit_window:setFont(g_STRING_FONT_GULIMCHE, 112)
alert_edit_window:setTextColor(255, 255, 255, 255)
alert_edit_window:setZOrderingEnabled(false)
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBox")):setMaxTextLength(14)
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBox")):subscribeEvent("EditboxFull", "OnAlertEditBoxFull")
winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):addChildWindow(alert_edit_window);

function OnAlertEditBoxFull(args)
	PlayWave('sound/FullEdit.wav')
end


function ShowCommonAlertOkCancelBoxWithFunctionWithEdit(arg, argYesFunc, argNoFunc, argEditAceeptFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):setProperty('Visible', 'True');
	root:addChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	winMgr:getWindow('CommonAlertAlphaImg'):addChildWindow( local_window );
	local_window:setWideType(6);
	local_window:setPosition(338, 246);
	--root:addChildWindow( local_window );
	local_window:setProperty('Visible', 'True');
	
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_TextWithEdit');
	local_window:setProperty('Visible', 'true');
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestWithEditOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestWithEditCancel'):setSubscribeEvent("Clicked", argNoFunc);
	winMgr:getWindow('CommonAlertEditBox'):setText('');
	winMgr:getWindow('CommonAlertEditBox'):setSubscribeEvent("TextAccepted", argEditAceeptFunc);
	--winMgr:getWindow('CommonAlertEditBox'):setSubscribeEvent("TextAccepted", argYesFunc);
	winMgr:getWindow('CommonAlertEditBox'):activate();
end













--------------------------------------------------------------------------------------------------------------------
--- �˸�â OK/CANCEL+EDITBOXX ---
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'CommonAlertOkCancelBoxWithEditX');
mywindow:setSize(349, 276);
mywindow:setWideType(6);
mywindow:setPosition(338, 246);
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setProperty('Visible', 'false');
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")



tWinButtonName = {['protecterr'] = 0, 'CommonAlertQuestWithEditXOk', 'CommonAlertQuestWithEditXCancel'}
-- 864, 485
-- 945, 485
--[[
tTextureX = {['protecterr'] = 0, 864, 944 }
tTextureY = {['protecterr'] = 0, 485, 485 }
tTextureHoverX = {['protecterr'] = 0, 864, 944 }
tTextureHoverY = {['protecterr'] = 0, 485+34, 485+34 }
tTexturePushedX = {['protecterr'] = 0, 864, 944 }
tTexturePushedY = {['protecterr'] = 0, 485+34*2, 485+34*2 }
--]]

tTextureX = {['protecterr'] = 0, 693, 858 }
tTextureY = {['protecterr'] = 0, 849, 849 }
tTextureHoverX = {['protecterr'] = 0, 693, 858 }
tTextureHoverY = {['protecterr'] = 0, 878, 878 }
tTexturePushedX = {['protecterr'] = 0, 693, 858 }
tTexturePushedY = {['protecterr'] = 0, 907, 907 }
nSizeX = 166
nSizeY = 29
tPosX = {['protecterr'] = 0, 85, 187 }
tPosY = {['protecterr'] = 0, 228, 228 }

for i=1, #tWinButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(tPosX[i], tPosY[i]);
end


winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow( winMgr:getWindow('CommonAlertQuestWithEditXOk') );
winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow( winMgr:getWindow('CommonAlertQuestWithEditXCancel') );


tWinName = {['protecterr'] = 0,'CommonAlertOkCancelBox_TextWithEditX'}
tWinText = {['protecterr'] = 0, Common_String_Do_It}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setSize(349, 70);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
	_window:setAlwaysOnTop(true);
	_window:setProperty('Disabled', 'True');
	
	_window:setPosition(0, 100);
	_window:clearTextExtends();
	_window:setViewTextMode(1);
	_window:setAlign(8);
	_window:setLineSpacing(1);
	winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow(_window);
end


alert_edit_window = winMgr:createWindow("TaharezLook/Editbox", "CommonAlertEditBoxid")
alert_edit_window:setText("z4test0151")
alert_edit_window:setPosition(85, 144)
alert_edit_window:setSize(176, 22)
alert_edit_window:setFont(g_STRING_FONT_GULIMCHE, 112)
alert_edit_window:setTextColor(255, 255, 255, 255)
alert_edit_window:setZOrderingEnabled(true)
--alert_edit_window:subscribeEvent("TextAccepted", "OnMessengerChatAccepted")
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBox")):setMaxTextLength(14)
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBox")):subscribeEvent("EditboxFull", "OnAlertEditBoxFull")
winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow(alert_edit_window);

alert_edit_window1 = winMgr:createWindow("TaharezLook/Editbox", "CommonAlertEditBoxpassword")
alert_edit_window1:setText("nxpubt")
alert_edit_window1:setPosition(85, 180)
alert_edit_window1:setSize(176, 22)
alert_edit_window1:setFont(g_STRING_FONT_GULIMCHE, 112)
alert_edit_window1:setTextColor(255, 255, 255, 255)
alert_edit_window1:setZOrderingEnabled(true)
--alert_edit_window1:subscribeEvent("TextAccepted", "OnMessengerChatAccepted")
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBoxpassword")):setMaxTextLength(22)
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBoxpassword")):subscribeEvent("EditboxFull", "OnAlertEditBoxFull")
winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow(alert_edit_window1);

alert_edit_window2 = winMgr:createWindow("TaharezLook/Editbox", "CommonAlertEditBoxgametype")
alert_edit_window2:setText("0")
alert_edit_window2:setPosition(20, 20)
alert_edit_window2:setSize(50, 22)
alert_edit_window2:setFont(g_STRING_FONT_GULIMCHE, 112)
alert_edit_window2:setTextColor(255, 255, 255, 255)
alert_edit_window2:setZOrderingEnabled(true)
--alert_edit_window2:subscribeEvent("TextAccepted", "OnMessengerChatAccepted")
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBoxgametype")):setMaxTextLength(1)
CEGUI.toEditbox(winMgr:getWindow("CommonAlertEditBoxgametype")):subscribeEvent("EditboxFull", "OnAlertEditBoxFull")
winMgr:getWindow('CommonAlertOkCancelBoxWithEditX'):addChildWindow(alert_edit_window2);

function OnAlertEditBoxFull(args)
	PlayWave('sound/FullEdit.wav')
end


function ShowCommonAlertOkCancelBoxWithFunctionWithEditX(arg, argYesFunc, argNoFunc, argEditAceeptFunc)
	local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEditX');
	local_window:setUserString("okFunction", argYesFunc)
	local_window:setUserString("noFunction", argNoFunc)
	root:addChildWindow(local_window);
	local local_txt_window = winMgr:getWindow('CommonAlertOkCancelBox_TextWithEditX');
	local_window:setProperty('Visible', 'true');
	local_txt_window:clearTextExtends();
	local_txt_window:addTextExtends(arg, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);
	winMgr:getWindow('CommonAlertQuestWithEditXOk'):setSubscribeEvent("Clicked", argYesFunc);
	winMgr:getWindow('CommonAlertQuestWithEditXCancel'):setSubscribeEvent("Clicked", argNoFunc);
	winMgr:getWindow('CommonAlertEditBox'):setText('');
	winMgr:getWindow('CommonAlertEditBox'):setSubscribeEvent("TextAccepted", argEditAceeptFunc);
	winMgr:getWindow('CommonAlertEditBox'):activate();
end


