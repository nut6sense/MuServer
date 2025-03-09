--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


g_curPage_EffectItemList = 1
g_maxPage_EffectItemList = 1


WindowPosIndex = GetMsgCurrentPos()

--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------

-- ����, �κ�, Ŭ���κ�, ������, �����̵��,  ���̷�, ��, ���̷�

local Use_OutputPosX		= {['err']=0, 856, 835, 835,  938, 938, 835, 835,  835 ,835}--512
local Use_OutputPosY		= {['err']=0, 215, 325, 325,  480, 480, 325, 325 ,325 ,325}

local Set_OutputPosX		= {['err']=0, 936, 835, 835,  938, 938, 835, 835,  835 ,835}--512
local Set_OutputPosY		= {['err']=0, 215, 325, 325,  511, 511, 325, 325 ,325 ,325}


------------------------------------------------------------------
-- ����Ʈ ��� ��ư(�ӽ÷�).
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "UseEffectItemBtn")
mywindow:setTexture("Normal", "UIData/profile002.tga", 301, 593)
mywindow:setTexture("Hover", "UIData/profile002.tga", 301, 625)
mywindow:setTexture("Pushed", "UIData/profile002.tga", 301, 657)
mywindow:setTexture("PushedOff", "UIData/profile002.tga", 301, 593)
--mywindow:setWideType(1);
--mywindow:setPosition(Use_OutputPosX[WindowPosIndex], Use_OutputPosY[WindowPosIndex])
mywindow:setPosition(10, 125)
mywindow:setSize(81, 32)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickEffectBtn")
root:addChildWindow(mywindow)

function OnClickEffectBtn()
	UseEffectItem()
end

RegistEscEventInfo("EffectItemImage", "OnClickCloseEffectItemList")
---------------------------------------------------------------------
--EffectItem������ ����Ʈ ���� 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EffectItemImage")
mywindow:setTexture("Enabled", "UIData/profile002.tga", 0, 442)
mywindow:setTexture("Disabled", "UIData/profile002.tga", 0, 442)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(380,180);
mywindow:setAlwaysOnTop(true)
mywindow:setSize(301, 406)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

------------------------------------------------------------------
-- �����۸���Ʈ ȣ��(�ӽ÷�).
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowEffectItemBtn")
mywindow:setTexture("Normal", "UIData/profile002.tga", 510, 312)
mywindow:setTexture("Hover", "UIData/profile002.tga", 510, 344)
mywindow:setTexture("Pushed", "UIData/profile002.tga", 510, 376)
mywindow:setTexture("PushedOff", "UIData/profile002.tga", 510, 408)
--mywindow:setWideType(1);
--mywindow:setPosition(Set_OutputPosX[WindowPosIndex], Set_OutputPosY[WindowPosIndex])
mywindow:setPosition(10, 95)
mywindow:setSize(81, 32)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ShowEffectItemList")
root:addChildWindow(mywindow)


function ShowEffectItemList()
	root:addChildWindow(winMgr:getWindow("EffectItemImage"))
	winMgr:getWindow("EffectItemImage"):setVisible(true)
	RequestEffectList()
	--EffectSelectItem()
end

-----------------------------------------------------------------------
-- EffectItem ������ ��� â ������ư
-----------------------------------------------------------------------
tEffectItemRadio =
{ ["protecterr"]=0, "EffectItemList_1", "EffectItemList_2", "EffectItemList_3", "EffectItemList_4"}


for i=1, #tEffectItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tEffectItemRadio[i]);	
	mywindow:setTexture("Normal", "UIData/profile002.tga",			301,538 );
	mywindow:setTexture("Hover", "UIData/profile002.tga",			301,538);
	mywindow:setTexture("Pushed", "UIData/profile002.tga",			301,538);
	mywindow:setTexture("PushedOff", "UIData/profile002.tga",		301,538);	
	mywindow:setTexture("SelectedNormal", "UIData/profile002.tga",	301,538);
	mywindow:setTexture("SelectedHover", "UIData/profile002.tga",	301,538);
	mywindow:setTexture("SelectedPushed", "UIData/profile002.tga",	301,538);
	mywindow:setTexture("SelectedPushedOff", "UIData/profile002.tga",301,538);
	mywindow:setTexture("Disabled", "UIData/profile002.tga",			301, 538);
	mywindow:setSize(287, 55);
	mywindow:setPosition(7, 140+(i-1)*57);
	mywindow:setVisible(false);
	mywindow:setUserString('index', tostring(i))
	mywindow:setEnabled(true)
	winMgr:getWindow('EffectItemImage'):addChildWindow( winMgr:getWindow(tEffectItemRadio[i]) );
	
		
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EffectItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, 10)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(90)
	mywindow:setScaleHeight(90)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tEffectItemRadio[i]):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EffectItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("EffectItemRadioIndex", i)
	winMgr:getWindow(tEffectItemRadio[i]):addChildWindow(mywindow)
	
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tEffectItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tEffectItemRadio[i]):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tEffectItemRadio[i]):addChildWindow(mywindow)
end


--���õǾ��� ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EffectSelectItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(17, 75)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(90)
mywindow:setScaleHeight(90)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)

-- ���õǾ��� ������ �̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectSelectItemName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(70, 72)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)

-- ���õǾ��� ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectSelectItemCount")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setText("")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(70, 90)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)

-- ���õǾ��� ������ ���� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button","EffectSelectItemCancel");	
mywindow:setTexture("Disabled", "UIData/invisible.tga",	371, 442);
mywindow:setTexture("Normal", "UIData/profile002.tga", 371, 442)
mywindow:setTexture("Hover", "UIData/profile002.tga", 371, 466)
mywindow:setTexture("Pushed", "UIData/profile002.tga", 371, 490)
mywindow:setTexture("PushedOff", "UIData/profile002.tga",371, 442)
mywindow:setSize(71,24 );	
mywindow:setPosition(220, 90);
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "OnClickSelectItemCancel")
winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)

function OnClickSelectItemCancel()
	ResetSelectEffectItem()
	winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("EffectSelectItemName"):setText("")
	winMgr:getWindow("EffectSelectItemCount"):setText("")
end

------------------------------------------------------------------
-- ����Ʈ �����۸���Ʈ �ݱ��ư
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseEffectItemList");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(260, 5)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseEffectItemList");
winMgr:getWindow("EffectItemImage"):addChildWindow(mywindow)

function OnClickCloseEffectItemList()
	winMgr:getWindow("EffectItemImage"):setVisible(false)
end

-----------------------------------------------------------------------
--������ ����Ʈ ÷�� ��ư 4��
-----------------------------------------------------------------------
 
tEffectItemButton =
{ ["protecterr"]=0, "EffectItemButton_1", "EffectItemButton_2", "EffectItemButton_3", "EffectItemButton_4"}
 

for i=1, #tEffectItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tEffectItemButton[i]);	
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		301, 442);
	mywindow:setTexture("Normal", "UIData/profile002.tga", 301, 442)
	mywindow:setTexture("Hover", "UIData/profile002.tga", 301, 466)
	mywindow:setTexture("Pushed", "UIData/profile002.tga", 301, 490)
	mywindow:setTexture("PushedOff", "UIData/profile002.tga",301, 442)
	mywindow:setSize(71,24 );	
	mywindow:setPosition(220,165+(i-1)*56);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false);
	mywindow:setUserString('EffectItemIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tEffectItemButtonEvent")
	winMgr:getWindow('EffectItemImage'):addChildWindow( winMgr:getWindow(tEffectItemButton[i]));
end


function tEffectItemButtonEvent(args)	


	local index = CEGUI.toWindowEventArgs(args).window:getUserString("EffectItemIndex")
	index = index-1
	local bEnable = SelectUseEffectItem(tonumber(index))
	if bEnable then
		EffectSelectItem()
	end
end
-----------------------------------------------------------------------
-- EffectItem ������ �̸� �����̸� �������� ����
-----------------------------------------------------------------------
function SetupEffectItemList(i, itemName, itemFileName, itemUseCount)
    
    local j=i+1
	winMgr:getWindow(tEffectItemRadio[j]):setVisible(true)
	winMgr:getWindow(tEffectItemButton[j]):setVisible(true)
	
	-- ������ �����̸�
	winMgr:getWindow("EffectItemList_Image_"..j):setTexture("Disabled",itemFileName , 0, 0)
	winMgr:getWindow("EffectItemList_Image_"..j):setScaleWidth(90)
	winMgr:getWindow("EffectItemList_Image_"..j):setScaleHeight(90)
	
	-- ������ �̸�
	winMgr:getWindow("EffectItemList_Name_"..j):setText(itemName)
	
	-- ������ ����
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("EffectItemList_Num_"..j):setText(szCount)
	
	-- ������ �Ⱓ
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("EffectItemList_Period_"..j):setText(period)		
end

function EffectSelectItem()
	local itemCount, itemName, itemFileName = GetSelectEffectItemInfo()
	
	if itemCount < 1 then
		winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("EffectSelectItemName"):setText("")
		winMgr:getWindow("EffectSelectItemCount"):setText("")
		return
	end
	
	-- ������ �����̸�
	winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("EffectSelectItemImage"):setScaleWidth(90)
	winMgr:getWindow("EffectSelectItemImage"):setScaleHeight(90)
	
	-- ������ �̸�
	winMgr:getWindow("EffectSelectItemName"):setText(itemName)
		
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("EffectSelectItemCount"):setText(szcount)
	--winMgr:getWindow("EffectSelectItemCount2"):setText(itemCount)
end


function ResetSelectItem()
	winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("EffectSelectItemName"):setText("")
	winMgr:getWindow("EffectSelectItemCount"):setText("")
end

function SetupSelectItem(itemName, itemFileName, itemCount)
	if itemCount < 1 then
		winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("EffectSelectItemName"):setText("")
		winMgr:getWindow("EffectSelectItemCount"):setText("")
		return
	end
	
	-- ������ �����̸�
	winMgr:getWindow("EffectSelectItemImage"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("EffectSelectItemImage"):setScaleWidth(90)
	winMgr:getWindow("EffectSelectItemImage"):setScaleHeight(90)
	
	-- ������ �̸�
	winMgr:getWindow("EffectSelectItemName"):setText(itemName)
		
	-- ������ ����
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("EffectSelectItemCount"):setText(szcount)
end

------------------------------------
---������ǥ���ؽ�Ʈ
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "EffectItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(110, 380)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(g_curPage_EffectItemList.." / "..g_maxPage_EffectItemList, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)

------------------------------------
---�������յڹ�ư
------------------------------------
local tMyEffectItemList_BtnName  = {["err"]=0, [0]= "MyEffectItemList_LBtn", "MyEffectItemList_RBtn"}
local tMyEffectItemList_BtnTexX  = {["err"]=0, [0]= 0, 22}

local tMyEffectItemList_BtnPosX  = {["err"]=0, [0]= 91, 190}
local tMyEffectItemList_BtnEvent = {["err"]=0, [0]= "OnClickEffectItemList_PrevPage", "OnClickEffectItemList_NextPage"}
for i=0, #tMyEffectItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyEffectItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", tMyEffectItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", tMyEffectItemList_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga", tMyEffectItemList_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", tMyEffectItemList_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", tMyEffectItemList_BtnTexX[i], 81)
	mywindow:setPosition(tMyEffectItemList_BtnPosX[i], 375)
	mywindow:setSize(22, 27)
	
	mywindow:setSubscribeEvent("Clicked", tMyEffectItemList_BtnEvent[i])
	winMgr:getWindow('EffectItemImage'):addChildWindow(mywindow)
end

---------------------------------------------------
-- EffectItemList ���� ������ / �ִ� ������
---------------------------------------------------
function EffectItemListPage(curPage, maxPage)
	g_curPage_EffectItemList = curPage
	g_maxPage_EffectItemList = maxPage
	
	winMgr:getWindow("EffectItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end

------------------------------------
---�����������̺�Ʈ-------------------
------------------------------------
		 
function  OnClickEffectItemList_PrevPage()
  
	if	g_curPage_EffectItemList > 1 then
			g_curPage_EffectItemList = g_curPage_EffectItemList - 1
			ChangedEffectItemListCurrentPage(g_curPage_EffectItemList)
	end
	
end
------------------------------------
---�����������̺�Ʈ-----------------
------------------------------------
function OnClickEffectItemList_NextPage()

	if	g_curPage_EffectItemList < g_maxPage_EffectItemList then
			g_curPage_EffectItemList = g_curPage_EffectItemList + 1
			ChangedEffectItemListCurrentPage(g_curPage_EffectItemList)
	end
	
end

-----------------------------------------------------------------------
-- Effect ������ ����Ʈ ����
-----------------------------------------------------------------------
function ClearEffectItemList()
    
	for i=1, 4 do
		winMgr:getWindow(tEffectItemRadio[i]):setVisible(false)
		winMgr:getWindow(tEffectItemButton[i]):setVisible(false)
	end
end

-----------------------------------------------------------------------
-- ���� ���¿� ���� ����Ʈ ��ư�� �������� �����Ѵ�
-----------------------------------------------------------------------
function CheckVisibleEffectBtn(bVisible)
	winMgr:getWindow("UseEffectItemBtn"):setVisible(false)
	winMgr:getWindow("ShowEffectItemBtn"):setVisible(false)
	if bVisible == 1 then
		--winMgr:getWindow("UseEffectItemBtn"):setVisible(true)
		--winMgr:getWindow("ShowEffectItemBtn"):setVisible(true)
	else
		winMgr:getWindow("UseEffectItemBtn"):setVisible(false)
		winMgr:getWindow("ShowEffectItemBtn"):setVisible(false)
	end
end




