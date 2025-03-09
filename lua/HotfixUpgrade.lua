--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

--------------------------------------------------------------------
--========================== 핫픽스 ================================
--------------------------------------------------------------------
local MAX_ITEMLIST = 6


------------------------------
-- 핫픽스 해제 알파창.
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixReleaseAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("HotfixReleaseAlphaImg", "OnClickHotfixReleaseCancelEvent")
RegistEnterEventInfo("HotfixReleaseAlphaImg", "OnClickHotfixReleaseOkEvent")
------------------------------
-- 핫픽스 해제 메인 이미지
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixReleaseMainImg")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 176, 666)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 176, 666)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 341) / 2, (g_MAIN_WIN_SIZEY - 358) / 2)
mywindow:setSize(341, 358)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("HotfixReleaseAlphaImg"):addChildWindow(mywindow)

------------------------------
-- 핫픽스 해제 코스튬 등록버튼
------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "HotfixReleaseRegistBtn")
mywindow:setTexture("Normal", "UIData/skillitem001.tga", 1, 928)
mywindow:setTexture("Hover", "UIData/skillitem001.tga", 1, 952)
mywindow:setTexture("Pushed", "UIData/skillitem001.tga", 1, 976)
mywindow:setTexture("PushedOff", "UIData/skillitem001.tga", 1, 1000)
mywindow:setPosition(90, 192)
mywindow:setSize(175, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "HotfixReleaseRegistBtnEvent")
winMgr:getWindow("HotfixReleaseMainImg"):addChildWindow(mywindow)

------------------------------
-- 핫픽스 해제 확인취소버튼
------------------------------
local ButtonName	= {['protecterr']=0, "HotfixReleaseOkButton", "HotfixReleaseCancelButton"}
local ButtonTexX	= {['protecterr']=0,		693,			858}
local ButtonPosX	= {['protecterr']=0,		5,				170}
local ButtonEvent	= {['protecterr']=0, "OnClickHotfixReleaseOkEvent", "OnClickHotfixReleaseCancelEvent"}

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setPosition(ButtonPosX[i], 324)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('HotfixReleaseMainImg'):addChildWindow(mywindow)
end


-- 핫픽스 해제 ok버튼
function OnClickHotfixReleaseOkEvent()
	winMgr:getWindow("HotfixReleaseAlphaImg"):setVisible(false)
	
	local Check, String, HotfixName, CostumName = ToC_ReleaseOkCheck()
	if Check == false then
		ShowNotifyOKMessage_Lua(String)
		return 
	end
	-- 샵쪽에서 쓰는 팝업창은 공통으로 쓰기위해====
	local ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
	local ButtonEvent	= {['protecterr']=0, "HotfixReleaseConfirmOk", "HotfixReleaseConfirmCancel"}
	
	for i=1, #ButtonName do
		winMgr:getWindow(ButtonName[i]):subscribeEvent("Clicked", ButtonEvent[i])
	end
	
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "HotfixReleaseConfirmCancel")
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "HotfixReleaseConfirmOk")
	
	String	= string.format(PreCreateString_2221, HotfixName, CostumName)
	
	winMgr:getWindow('NCS_WearConfirmText'):clearTextExtends();
	winMgr:getWindow('NCS_WearConfirmText'):addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	root:addChildWindow(winMgr:getWindow('NCS_WearConfirmAlphaImage'));
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(true)	
end


-- 핫픽스 해제 확인 ok버튼 이벤트
function HotfixReleaseConfirmOk(args)
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)	
	ToC_SendReleaseOk()
end


-- 핫픽스 해제 확인 cancel버튼 이벤트
function HotfixReleaseConfirmCancel(args)
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)	


end







-- 핫픽스 해제 cancel버튼
function OnClickHotfixReleaseCancelEvent()
	winMgr:getWindow("HotfixReleaseAlphaImg"):setVisible(false)
end

------------------------------
-- 핫픽스 해제할 아이템이미지
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixReleaseItemImg")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 444, 570)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 444, 570)
mywindow:setPosition(25, 76)
mywindow:setSize(73, 96)
--mywindow:setPosition(25, 76)
--mywindow:setSize(105, 105)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("HotfixReleaseMainImg"):addChildWindow(mywindow)

------------------------------
-- 핫픽스 해제할 아이템이름
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "HotfixReleaseItemName")
mywindow:setPosition(29, 48)
mywindow:setSize(288, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(3)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("HotfixReleaseMainImg"):addChildWindow(mywindow)


------------------------------
-- 핫픽스 해제할 아이템스텟
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "HotfixReleaseItemStat")
mywindow:setPosition(150, 72)
mywindow:setSize(5, 110)
mywindow:setViewTextMode(1)
mywindow:setAlign(5)
mywindow:setLineSpacing(1)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("HotfixReleaseMainImg"):addChildWindow(mywindow)



------------------------------
-- 콤보박스로 쓸 버튼
------------------------------
mywindow = winMgr:createWindow('TaharezLook/Button', 'ReleaseHotfixSelectButton');
mywindow:setTexture('Normal', 'UIData/Itemshop001.tga', 401, 788);
mywindow:setTexture('Hover', 'UIData/Itemshop001.tga', 421, 788);
mywindow:setTexture('Pushed', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setTexture('PushedOff', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setPosition(303, 283);
mywindow:setSize(18, 17);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ReleaseHotfixSelectListShow")
winMgr:getWindow('HotfixReleaseMainImg'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 콤보박스로 쓸 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ReleaseHotfixSelectText")
mywindow:setPosition(107, 287)
mywindow:setSize(197, 17)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)	
mywindow:subscribeEvent("MouseClick", "ReleaseHotfixSelectListShow")
winMgr:getWindow('HotfixReleaseMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixReleaseHotfixImg")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 384, 606)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 384, 606)
mywindow:setPosition(20, 237)
mywindow:setSize(60, 60)
mywindow:setScaleWidth(255)
mywindow:setScaleHeight(255)
--mywindow:setPosition(20, 237)
--mywindow:setSize(105, 105)
--mywindow:setScaleWidth(177)
--mywindow:setScaleHeight(177)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("HotfixReleaseMainImg"):addChildWindow(mywindow)

 
-- 핫픽스 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ReleaseHotfixSelectNameText")
mywindow:setPosition(107, 247)
mywindow:setSize(197, 17)
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow('HotfixReleaseMainImg'):addChildWindow(mywindow)


local MAX_RELEASE_HOTFIX = 9
--------------------------------------------------------------------
-- 기간 라디오버튼 넣어줄 투명이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ReleaseHotfixSelectImage")
mywindow:setTexture("Enabled", "UIData/nm1.tga", 700, 200)		--빈공간
mywindow:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
mywindow:setPosition(448, 506)
mywindow:setSize(213, 17 * MAX_RELEASE_HOTFIX)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('HotfixReleaseAlphaImg'):addChildWindow(mywindow)


for i = 1, MAX_RELEASE_HOTFIX do
	mywindow = winMgr:createWindow("TaharezLook/Button", "ReleaseHotfixSelectPart"..i)
	mywindow:setTexture("Normal", "UIData/option.tga", 328, 418)
	mywindow:setTexture("Hover", "UIData/option.tga", 328, 438)
	mywindow:setTexture("Pushed", "UIData/option.tga", 328, 438)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 328, 438)
	mywindow:setPosition(0, (i - 1) * 17)
	mywindow:setSize(213, 17)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("AttachIndex", tostring(i))
	mywindow:subscribeEvent("Clicked", "SelectHotfixClick")
	winMgr:getWindow('ReleaseHotfixSelectImage'):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ReleaseHotfixSelectPartText"..i)
	mywindow:setPosition(0, 2)
	mywindow:setSize(221, 17)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(7)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow('ReleaseHotfixSelectPart'..i):addChildWindow(mywindow)

	
	
end


function ReleaseHotfixSelectListShow()
	if winMgr:getWindow('ReleaseHotfixSelectImage'):isVisible() then
		winMgr:getWindow('ReleaseHotfixSelectImage'):setVisible(false)
	else
		winMgr:getWindow('HotfixReleaseAlphaImg'):addChildWindow(winMgr:getWindow('ReleaseHotfixSelectImage'))
		winMgr:getWindow('ReleaseHotfixSelectImage'):setVisible(true)
	end 
	

end


-- 핫픽스 부위 선택 리스트를 숨겨준다.
function ReleaseHotfixSelectListHide()
	--winMgr:getWindow('ReleaseHotfixSelectImage'):setVisible(false)
end


function SelectHotfixClick(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local AttachIndex	= tonumber(EventWindow:getUserString("AttachIndex"))

	local String, filename, ItemName = ToC_SetReleaseHotfixAttachIndex(AttachIndex)
	
	SetReleaseHotfixInfo(ItemName, filename, String, false)
	
	winMgr:getWindow('ReleaseHotfixSelectImage'):setVisible(false)
end


function SetReleaseHotfixInfo(itemName, FileName, String, clear)
	winMgr:getWindow("ReleaseHotfixSelectText"):clearTextExtends()
	winMgr:getWindow("ReleaseHotfixSelectText"):addTextExtends(String, g_STRING_FONT_DODUMCHE, 12,255,255,255,255,    0, 0,0,0,255)
	
	winMgr:getWindow("ReleaseHotfixSelectNameText"):clearTextExtends()
	if clear then
		itemName = AdjustString(g_STRING_FONT_DODUMCHE, 12, itemName, 160)
		winMgr:getWindow("ReleaseHotfixSelectNameText"):addTextExtends(itemName, g_STRING_FONT_DODUMCHE, 112, 255,255,255,255, 0, 255,255,255,255)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setTexture("Disabled", "UIData/skillitem001.tga", 384, 606)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setPosition(26, 244)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setSize(60, 60)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setScaleWidth(255)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setScaleHeight(255)
	else
		winMgr:getWindow("ReleaseHotfixSelectNameText"):addTextExtends(itemName, g_STRING_FONT_DODUMCHE, 114, 0,0,0,255, 3, 255,255,255,255)	
		winMgr:getWindow('HotfixReleaseHotfixImg'):setTexture("Disabled", FileName, 0, 0)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setPosition(21, 240)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setSize(105, 105)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setScaleWidth(177)
		winMgr:getWindow('HotfixReleaseHotfixImg'):setScaleHeight(177)
	end	
	
end

------------------------------
-- 코스튬 등록 메인 이미지
------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeRegistWindow")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
mywindow:setPosition(700, 170)
mywindow:setSize(296, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("HotfixReleaseAlphaImg"):addChildWindow(mywindow)

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "CostumeRegistWindowTitlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
winMgr:getWindow('CostumeRegistWindow'):addChildWindow(mywindow)

-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeRegistList_PageText")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(188, 373)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CostumeRegistWindow'):addChildWindow(mywindow)

-- 페이지 좌우 버튼
local tRegistItemList_BtnName  = {["err"]=0, "RegistItemList_LBtn", "RegistItemList_RBtn"}
local tRegistItemList_BtnTexX  = {["err"]=0,			987,					970}
local tRegistItemList_BtnPosX  = {["err"]=0,			170,					270}
local tRegistItemList_BtnEvent = {["err"]=0, "OnClickRegistItemList_PrevPage", "OnClickRegistItemList_NextPage"}
for i=1, #tRegistItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tRegistItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tRegistItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tRegistItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tRegistItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tRegistItemList_BtnTexX[i], 0)
	mywindow:setPosition(tRegistItemList_BtnPosX[i], 370)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tRegistItemList_BtnEvent[i])
	winMgr:getWindow('CostumeRegistWindow'):addChildWindow(mywindow)
end

-- 앞 페이지
function OnClickRegistItemList_PrevPage()
	local Check, Currentpage, totalpage = ToC_SetHotfixReleasePrevPage()
	if Check then
		ClearMyShopItemList(totalpage, Currentpage)
		ToC_SetCostumeRegistWindow(Currentpage)	-- 윈도우 띄워준다 
	end
	
end

-- 다음페이지 전환
function OnClickRegistItemList_NextPage()
	local Check, Currentpage, totalpage = ToC_SetHotfixReleaseNextPage()
	if Check then
		ClearMyShopItemList(totalpage, Currentpage)
		ToC_SetCostumeRegistWindow(Currentpage)	-- 윈도우 띄워준다 
	end

end


-- 아이템 리스트 판매목록
for i=1, MAX_ITEMLIST do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "CostumeRegistItemList_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, (i-1)*60+70)
	mywindow:setProperty("GroupID", 309)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow('CostumeRegistWindow'):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeRegistItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumeRegistItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("slot", tostring(-1))
	mywindow:subscribeEvent("MouseEnter", "CostumeRegistItemListMouseEnter")
	mywindow:subscribeEvent("MouseLeave", "CostumeRegistItemListMouseLeave")
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeRegistItemList_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeRegistItemList_Num_"..i)
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CostumeRegistItemList_Period_"..i)
	mywindow:setTextColor(150,150,150,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "CostumeRegistItemList_RegistBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 0, 518)
	mywindow:setTexture("Hover", "UIData/deal.tga", 0, 536)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 0, 554)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", 0, 518)
	mywindow:setPosition(210, 30)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("slot", i)
	mywindow:subscribeEvent("Clicked", "CostumeRegistItemList_RegistBtnEvent")
	winMgr:getWindow("CostumeRegistItemList_"..i):addChildWindow(mywindow)
end


-- 아이템에 마우스 들어왔을때
function CostumeRegistItemListMouseEnter(args)
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local Slot = tonumber(EnterWindow:getUserString("slot"))
	
	local itemNumber, itemName, itemDesc, itemLevel = ToC_GetToolTipInfo(Slot)
	
	itemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, itemDesc, 200)
	
		
	local tItemToolTipContents = {['protecterr']=0, "", "", "", "", "", "", "", "", ""}
	local tStatPlus		= {['protecterr']=0, true, true, true, true, true, true, true, true, true}
	local tStatNormal	= {['protecterr']=0, true, true, true, true, true, true, true, true, true}

	----- 스텟 갯수 && 스텟을 넣어준다.---------
	local AtkStr,  AtkGra,  Cri,  Hp,  Sp,  DefStr,  DefGra,  TeamA,  DoubleA,  SpecialA,  TeamD,  DoubleD,  SpecialD,  CriDmg = GetItemStat(itemNumber);
	local AtkStr1, AtkGra1, Cri1, Hp1, Sp1, DefStr1, DefGra1, TeamA1, DoubleA1, SpecialA1, TeamD1, DoubleD1, SpecialD1, CriDmg1, ableCount, totalCount = ToC_GetHotfixStat(itemNumber, Slot);
	
	DebugStr(ableCount)
	
	local tStat			= {['protecterr']=0, AtkStr + AtkStr1, AtkGra + AtkGra1, Cri + Cri1, Hp + Hp1, Sp + Sp1, DefStr + DefStr1, DefGra + DefGra1,
												TeamA + TeamA1,  DoubleA + DoubleA1,  SpecialA + SpecialA1,  TeamD + TeamD1,  DoubleD + DoubleD1,  SpecialD + SpecialD1,  CriDmg + CriDmg1 }
	local tStat2		= {['protecterr']=0, AtkStr1, AtkGra1, Cri1, Hp1, Sp1, DefStr1, DefGra1, TeamA1, DoubleA1, SpecialA1, TeamD1, DoubleD1, SpecialD1, CriDmg1}
	local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, 
									"HP", "SP", PreCreateString_1125, PreCreateString_1126, PreCreateString_2646
											, PreCreateString_2648, PreCreateString_2650, PreCreateString_2647, PreCreateString_2649, PreCreateString_2651, PreCreateString_2652}
	local Stat_count	= 0;

	local Stat1	= ""
	local Stat2 = ""
	local	aa	= 0
	local	bb	= 0
	
	for i = 1, #tStatNameText do
		if tStat[i] ~= 0 then
			if i == 3 then
				aa	= tStat[i] / 10
				bb	= tStat[i] % 10
				Stat1 = tostring(aa).."."..bb
				aa	= tStat2[i] / 10
				bb	= tStat2[i] % 10
				Stat2 = tostring(aa).."."..bb
			else				
				Stat1 = tostring(tStat[i])
				Stat2 = tostring(tStat2[i])
			end
			
			local SignString = ""
			if tStat[i] > 0 then
				SignString = "+"
				
				if tStat2[i] > 0 then
					tItemToolTipContents[Stat_count+1] = tStatNameText[i].." "..SignString..Stat1.."(orb +"..Stat2..")"
				else
					tItemToolTipContents[Stat_count+1] = tStatNameText[i].." "..SignString..Stat1
				end
				tStatPlus[Stat_count+1]	= true
			else
				if tStat2[i] > 0 then
					tItemToolTipContents[Stat_count+1] = tStatNameText[i].." "..SignString..Stat1.."(orb +"..Stat2..")"
				else
					tItemToolTipContents[Stat_count+1] = tStatNameText[i].." "..SignString..Stat1
				end
				tStatPlus[Stat_count+1]	= false
			end
			Stat_count	= Stat_count + 1
		end
	end

	if ableCount == 0 then
		tItemToolTipContents[Stat_count+2] = MR_String_75
	else
		tItemToolTipContents[Stat_count+2] = MR_String_71.." ( "..totalCount.." / "..ableCount.." )"
	end
	
	Stat_count	= Stat_count + 2
	tStatPlus[Stat_count+2]		= true
	tStatNormal[Stat_count+2]	= false

		
	---------------------------------------
	-- 연관상품 갯수 --> 가격 자리를 내기 위해서.
	local LineCount		= Stat_count + 1		-- 툴팁에 들어가는 라인의 수를 알아온다.
	
	-- 툴팁 띄워준다.
	YSizeVariableToolTipSpawn("MyRoom_ItemToolTip", 252, 12, 2, LineCount, 2)
	
	root:addChildWindow(winMgr:getWindow("MyRoom_ItemToolTip"))
	local x, y = GetBasicRootPoint(EnterWindow)
	
	winMgr:getWindow("MyRoom_ItemToolTip"):setPosition(x + 55, y)
	
	local Level	= ""
	-- 현재 선택된 윈도우를 찾는다.
	if tonumber(itemLevel) < 1 then
		Level	= PreCreateString_1229
	else
		Level	= PreCreateString_1138.." "..itemLevel
	end

	winMgr:getWindow("MyRoom_ItemToolTipLevel"):clearTextExtends();
	winMgr:getWindow("MyRoom_ItemToolTipLevel"):addTextExtends(Level, g_STRING_FONT_GULIMCHE,212, 255,255,255,255,  0,  0,0,0,255);
	winMgr:getWindow("MyRoom_ItemToolTipName"):clearTextExtends();
	winMgr:getWindow("MyRoom_ItemToolTipName"):addTextExtends(itemName, g_STRING_FONT_GULIMCHE,213, 255,205,86,255,  1, 30,30,30,255)
	winMgr:getWindow("MyRoom_ItemToolTipDesc"):clearTextExtends();
	winMgr:getWindow("MyRoom_ItemToolTipDesc"):addTextExtends(itemDesc, g_STRING_FONT_GULIMCHE,112, 255,255,255,255,  0,  0,0,0,255);

	-- 스텟
	for i = 1, Stat_count do
		winMgr:getWindow("MyRoom_ItemToolTipText"..i):setVisible(true)
		winMgr:getWindow("MyRoom_ItemToolTipText"..i):setPosition(18, 115 + (i - 1) * 19)
		winMgr:getWindow("MyRoom_ItemToolTipText"..i):clearTextExtends();
		if tStatPlus[i] == true then
			if tStatNormal[i] == false then
				winMgr:getWindow("MyRoom_ItemToolTipText"..i):addTextExtends(tItemToolTipContents[i], g_STRING_FONT_GULIMCHE,12, 255,205,86,255,  1,  0,0,0,255);
			else
				winMgr:getWindow("MyRoom_ItemToolTipText"..i):addTextExtends(tItemToolTipContents[i], g_STRING_FONT_GULIMCHE,12, 0,255,0,255,  1,  0,0,0,255);
			end
		else
			winMgr:getWindow("MyRoom_ItemToolTipText"..i):addTextExtends(tItemToolTipContents[i], g_STRING_FONT_GULIMCHE,12, 231,32,20,255,  1,  0,0,0,255);
		end
	end
	for i = Stat_count + 1, 10 do
		winMgr:getWindow("MyRoom_ItemToolTipText"..i):setVisible(false)
	end

	PlayWave('sound/listmenu_click.wav');

end


-- 마우스 나갔을때.
function CostumeRegistItemListMouseLeave(args)
	YSizeVariableToolTipClose("MyRoom_ItemToolTip")
end



-- 코스튬 등록 리스트 초기화(보여주는 아이템 리스트, 페이지설정)
function ClearMyShopItemList(totalpage, Currentpage)
	for i=1, MAX_ITEMLIST do
		winMgr:getWindow("CostumeRegistItemList_"..i):setVisible(false)		
	end	
	winMgr:getWindow("CostumeRegistList_PageText"):setTextExtends(Currentpage.." / "..totalpage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end


-- 코스튬 등록 리스트 설정
function SetCostumeRegist(index, Slot, FileName, itemName, itemUseCount, period)
	winMgr:getWindow("CostumeRegistItemList_"..index):setVisible(true)
	winMgr:getWindow("CostumeRegistItemList_RegistBtn_"..index):setUserString("slot", Slot)	-- slot Index Save
	winMgr:getWindow("CostumeRegistItemList_EventImage_"..index):setUserString("slot", Slot)	-- slot Index Save
	
	-- 아이템 이미지
	winMgr:getWindow("CostumeRegistItemList_Image_"..index):setTexture("Disabled", "UIData/ItemUIData/"..FileName, 0, 0)

	-- 아이템 이름
	winMgr:getWindow("CostumeRegistItemList_Name_"..index):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("CostumeRegistItemList_Num_"..index):setText(szCount)

	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("CostumeRegistItemList_Period_"..index):setText(period)
end




-- 핫픽스 해제팝업창을 띄워준다.
function ShowHotfixReleaseWindow(useItemslot)
	root:addChildWindow(winMgr:getWindow("HotfixReleaseAlphaImg"))
	winMgr:getWindow("HotfixReleaseAlphaImg"):setVisible(true)
	ToC_ClearReleaseHotfixInfo()					-- 해제할 핫픽스정보 초기화(c)
	ToC_SetReleaseHotfixUseItemIndex(useItemslot)
	RegistHotfixReleaseItem("", "invisible.tga", PreCreateString_2219, 1)	-- 해제할 핫픽스정보 초기화(lua)
	SetReleaseHotfixInfo(PreCreateString_2220,  "UIData/invisible.tga", "", true)
	winMgr:getWindow('ReleaseHotfixSelectText'):setEnabled(false)
	winMgr:getWindow("CostumeRegistWindow"):setVisible(false)		-- 코스튬 등록 윈도우를 false시킨다.
	winMgr:getWindow('ReleaseHotfixSelectButton'):setEnabled(false)	-- 
		
end

--SelectDetachItem
-- 코스튬등록버튼 이벤트
function HotfixReleaseRegistBtnEvent(args)
	winMgr:getWindow("HotfixReleaseAlphaImg"):addChildWindow(winMgr:getWindow("CostumeRegistWindow"))
	winMgr:getWindow("CostumeRegistWindow"):setVisible(true)
	local totalpage = ToC_GetRegistListTotalPage()
	local Currentpage = 1
	ClearMyShopItemList(totalpage, Currentpage)			-- 초기화
	ToC_SetCostumeRegistWindow(1)	-- 윈도우 띄워준다 
		
end

-- 아이템 등록하기버튼
function CostumeRegistItemList_RegistBtnEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local slot			= tonumber(EventWindow:getUserString("slot"))
	winMgr:getWindow("CostumeRegistWindow"):setVisible(false)
	SetReleaseHotfixInfo(PreCreateString_2220,  "UIData/invisible.tga", "", true)
	winMgr:getWindow('ReleaseHotfixSelectText'):setEnabled(true)
	local Count	= ToC_SetHotfixReleaseItem(slot)	-- 세팅하면서 박혀있는 핫픽스 갯수를 알아온다.

	winMgr:getWindow('ReleaseHotfixSelectButton'):setEnabled(true)

	winMgr:getWindow('ReleaseHotfixSelectImage'):setSize(213, 17 * Count)
	for i = 1, MAX_RELEASE_HOTFIX do
		if i <= Count then
			winMgr:getWindow('ReleaseHotfixSelectPart'..i):setVisible(true)
			ToC_SetReleaseHotfixPart(i)
		else
			winMgr:getWindow('ReleaseHotfixSelectPart'..i):setVisible(false)
		end		
	end
end



function SetReleaseHotfixSelectPart(Index, AttachIndex, String)
	
	winMgr:getWindow('ReleaseHotfixSelectPart'..Index):setUserString("AttachIndex", AttachIndex)		-- 어태치 인덱스를 저장
	winMgr:getWindow('ReleaseHotfixSelectPartText'..Index):clearTextExtends()
	winMgr:getWindow('ReleaseHotfixSelectPartText'..Index):addTextExtends(String, g_STRING_FONT_GULIMCHE,12, 0, 0, 0, 255,  0,  0,0,0,255);	
	
end


-- 핫픽스 해제할 아이템 정보를 뿌려준다.
function RegistHotfixReleaseItem(itemName, fileName, stat, clear)
	
	winMgr:getWindow("HotfixReleaseItemName"):clearTextExtends()
	winMgr:getWindow("HotfixReleaseItemName"):addTextExtends(itemName, g_STRING_FONT_GULIMCHE,13, 255,198,30, 255,  0,  0,0,0,255);	
	
	winMgr:getWindow("HotfixReleaseItemStat"):clearTextExtends()
	if clear == 1 then
		stat = AdjustString(g_STRING_FONT_GULIMCHE, 12, stat, 160)
		winMgr:getWindow("HotfixReleaseItemStat"):addTextExtends(stat, g_STRING_FONT_GULIMCHE,12, 255, 255, 255, 255,  0,  0,0,0,255);
		winMgr:getWindow("HotfixReleaseItemImg"):setTexture("Disabled", "UIData/skillitem001.tga", 444, 570)
		winMgr:getWindow("HotfixReleaseItemImg"):setPosition(38, 78)
		winMgr:getWindow("HotfixReleaseItemImg"):setSize(73, 96)
	else
		winMgr:getWindow("HotfixReleaseItemStat"):addTextExtends(stat, g_STRING_FONT_GULIMCHE,12, 87, 242, 9, 255,  0,  0,0,0,255);
		winMgr:getWindow("HotfixReleaseItemImg"):setTexture("Disabled", "UIData/"..fileName, 0, 0)
		winMgr:getWindow("HotfixReleaseItemImg"):setPosition(25, 76)
		winMgr:getWindow("HotfixReleaseItemImg"):setSize(105, 105)
	end
end


