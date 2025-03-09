--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()



--------------------------------------------------------------------

-- ��������

--------------------------------------------------------------------

-- ��Ƽ�� �ε���
local PARTY_TAB_LIST	= 0	-- ��Ƽ��� ��
local PARTY_TAB_CREATE	= 1	-- ��Ƽ���� ��
local PARTY_TAB_INVITE	= 2	-- ��Ƽ�ʴ� ��
local PARTY_TAB_INFO	= 3	-- ��Ƽ���� ��

local g_currentParty = PARTY_TAB_LIST	-- ���� ��Ƽ�� ��ġ
local g_selectPartyType = 0				-- ��Ƽ������ ������ ��Ƽ����
local g_selectPartyProperty = 0			-- ��Ƽ������ ������ ��Ƽ�Ӽ�(������, ������)
local g_selectPartyExpProperty = 1		-- ��Ƽ������ ������ ����ġ�Ӽ�( �й����, �й�)
local g_selectPartyItemProperty = 0		-- ��Ƽ������ ������ �����ۼӼ�(�й����, ����ȹ��, ����ȹ��)
local g_selectMaxNum = 3				-- ��Ƽ������ ������ ��Ƽ�ο�
local g_currentPage = 1
local g_maxPage = 1


--------------------------------------------------------------------

-- ��Ƽâ �⺻ ���� ������

--------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjparty_BackImage")
mywindow:setTexture("Enabled", "UIData/party003.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(250, 100)
mywindow:setSize(741, 482)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("sjparty_BackImage", "ClosePartyWindow")


--------------------------------------------------------------------
-- ��Ƽâ �⺻ ���� ������ �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sjparty_CloseButton")
mywindow:setTexture("Normal", "UIData/party003.tga", 650, 887)
mywindow:setTexture("Hover", "UIData/party003.tga", 650, 909)
mywindow:setTexture("Pushed", "UIData/party003.tga", 650, 931)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 650, 887)
mywindow:setPosition(705, 8)
mywindow:setSize(22, 22)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClosePartyWindowButtonEvent")
winMgr:getWindow("sjparty_BackImage"):addChildWindow(mywindow)





-- 1.��Ƽ��� / 2.���� / 3.�ʴ� / 4.���� ������ư
tPartyDescName  = {['err']=0, [0]="sjparty_List", "sjparty_Create", "sjparty_Invite", "sjparty_Info" }
tPartyDescTexX  = {['err']=0, [0]=596,	736,	876,	596}
tPartyDescPosX  = {['err']=0, [0]=12,	155,	298,	155}
tPartyDescEvent = {['err']=0, [0]="OnSelected_PartyList", "OnSelected_PartyCreate", "OnSelected_PartyInvite", "OnSelected_PartyInfo"}
for i=0, #tPartyDescName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPartyDescName[i])
	mywindow:setTexture("Normal", "UIData/party001.tga", tPartyDescTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/party001.tga", tPartyDescTexX[i], 35)
	mywindow:setTexture("Pushed", "UIData/party001.tga", tPartyDescTexX[i], 70)
	mywindow:setTexture("PushedOff", "UIData/party001.tga", tPartyDescTexX[i], 0)	
	mywindow:setTexture("SelectedNormal", "UIData/party001.tga", tPartyDescTexX[i], 70)
	mywindow:setTexture("SelectedHover", "UIData/party001.tga", tPartyDescTexX[i], 70)
	mywindow:setTexture("SelectedPushed", "UIData/party001.tga", tPartyDescTexX[i], 70)
	mywindow:setTexture("SelectedPushedOff", "UIData/party001.tga", tPartyDescTexX[i], 70)
	mywindow:setSize(140, 35)
	mywindow:setPosition(tPartyDescPosX[i], 39)
	mywindow:setAlwaysOnTop(true)
	mywindow:setProperty("GroupID", 8281)
	mywindow:setVisible(true)	
	mywindow:subscribeEvent("SelectStateChanged", tPartyDescEvent[i])
	--winMgr:getWindow("sjparty_BackImage"):addChildWindow(tPartyDescName[i])
end


-- 1.��Ƽ��� ������ư�� ���õǾ�����
function OnSelected_PartyList(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sjparty_List")):isSelected() then
		g_currentParty = PARTY_TAB_LIST
		winMgr:getWindow("sjParty_ListBackImage"):setVisible(true)
		winMgr:getWindow("sjParty_CreateBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_InviteBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_InfoBackImage"):setVisible(false)
		
		-- ��Ƽ������ �ִ� ��Ƽ����, �ο��� ���� �ٸ������� �̵��� false�� �ٲ�
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
	end
end

-- 2.��Ƽ���� ������ư�� ���õǾ�����
function OnSelected_PartyCreate(args)
	root:addChildWindow(winMgr:getWindow("sjParty_CreateBackImage"))
	winMgr:getWindow("sjParty_CreateBackImage"):setVisible(true)
	winMgr:getWindow("sjParty_InviteBackImage"):setVisible(false)
	winMgr:getWindow("sjParty_InfoBackImage"):setVisible(false)
	-- ��Ƽ���� �Ӽ� �ʱ�ȭ
	InitPartyProperty()
	-- ��Ƽ��Ͽ� ���õȰ͵� ��� �ʱ�ȭ
	ClearPartyListSelect()
end

-- 3.��Ƽ�ʴ� ������ư�� ���õǾ�����
function OnSelected_PartyInvite(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sjparty_Invite")):isSelected() then
		g_currentParty = PARTY_TAB_INVITE
		winMgr:getWindow("sjParty_ListBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_CreateBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_InviteBackImage"):setVisible(true)
		winMgr:getWindow("sjParty_InfoBackImage"):setVisible(false)
		
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
		
		ClearPartyListSelect()
	end
end

-- 4.��Ƽ���� ������ư�� ���õǾ�����
function OnSelected_PartyInfo(args)
	if CEGUI.toRadioButton(winMgr:getWindow("sjparty_Info")):isSelected() then
		g_currentParty = PARTY_TAB_INFO
		winMgr:getWindow("sjParty_ListBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_CreateBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_InviteBackImage"):setVisible(false)
		winMgr:getWindow("sjParty_InfoBackImage"):setVisible(true)
		
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
		
		ClearPartyListSelect()
	end
end





--------------------------------------------------------

-- 1.��Ƽ��� ����

--------------------------------------------------------
-- ��Ƽ��� ���(����)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_ListBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(15, 50)
mywindow:setSize(706, 428)
mywindow:setVisible(true)
winMgr:getWindow("sjparty_BackImage"):addChildWindow(mywindow)

-- ��Ƽ��Ͽ��� ������ ����鿡 ���� �����̹���(��Ƽ����, ��Ƽ�̸�, ��Ƽ��, �ο�)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_ListDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 0, 522)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(32, 0)
mywindow:setSize(506, 32)
--winMgr:getWindow("sjParty_ListBackImage"):addChildWindow(mywindow)

_PAGENUM = GetOnePageOfPartyList()
for i=0, _PAGENUM-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sjParty_List_"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 517)
	mywindow:setTexture("Hover", "UIData/party003.tga", 0, 517)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 507, 589)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 507, 519)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 507, 589)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga", 507, 589)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga", 507, 589)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 507, 589)
	mywindow:setPosition(5, 72+(i*24))
	mywindow:setSize(703, 24)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("ListIndex", i)
	mywindow:setSubscribeEvent("MouseDoubleClicked", "OnMouseDoubleClickPartyList")
	winMgr:getWindow("sjParty_ListBackImage"):addChildWindow(mywindow)
end
-- ��Ƽ��� ����Ʈ�� �ִ� ������(��Ƽ����, ��Ƽ�̸�, ��Ƽ�� �̸�, ��Ƽ�ο�)
tPartyList_infoName  = {['err']=0, [0]="sjList_PartyType", "sjList_PartyName", "sjList_PartyOwnerName", "sjList_PartyNum", "sjList_PartyExpType", "sjList_PartyItemType"}
tPartyList_infoPosX	 = {['err']=0, [0]=435, 65, 595, 253, 295, 350}
tPartyList_infoSizeX = {['err']=0, [0]=50, 100, 50, 50, 50, 50}
for i=0, _PAGENUM-1 do
	for j=0, #tPartyList_infoName do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_List_"..i..tPartyList_infoName[j])
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(tPartyList_infoPosX[j], 5)
		mywindow:setSize(tPartyList_infoSizeX[j], 20)
		mywindow:setZOrderingEnabled(false)	
		mywindow:setViewTextMode(1)
		mywindow:setAlign(8)
		mywindow:setLineSpacing(2)
		mywindow:clearTextExtends()
		mywindow:setEnabled(false)
		winMgr:getWindow("sjParty_List_"..i):addChildWindow(mywindow)
	end
end


-- ��Ƽ��� ���������� / �ִ�������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_List_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(323, 379)
mywindow:setSize(40, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
winMgr:getWindow("sjParty_ListBackImage"):addChildWindow(mywindow)


-- ��Ƽ��� L, R��ư
tPartyList_BtnName  = {["err"]=0, [0]="sjList_LBtn", "sjList_RBtn"}
tPartyList_BtnTexX  = {["err"]=0, [0]=933, 957}
tPartyList_BtnPosX  = {["err"]=0, [0]=281, 388}
tPartyList_BtnEvent = {["err"]=0, [0]="OnClickPartyList_PrevPage", "OnClickPartyList_NextPage"}
for i=0, #tPartyList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPartyList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/party003.tga", tPartyList_BtnTexX[i], 916)
	mywindow:setTexture("Hover", "UIData/party003.tga", tPartyList_BtnTexX[i], 943)
	mywindow:setTexture("Pushed", "UIData/party003.tga", tPartyList_BtnTexX[i], 969)
	mywindow:setTexture("PushedOff", "UIData/party003.tga", tPartyList_BtnTexX[i], 916)
	mywindow:setPosition(tPartyList_BtnPosX[i], 375)
	mywindow:setSize(24, 27)
	mywindow:setSubscribeEvent("Clicked", tPartyList_BtnEvent[i])
	winMgr:getWindow("sjParty_ListBackImage"):addChildWindow(mywindow)
end


-- ��Ƽ��� ������ ���ʹ�ư Ŭ��
function OnClickPartyList_PrevPage(args)
	if g_currentPage > 1 then
		g_currentPage = g_currentPage - 1
		ChangeCurrentPage(g_currentPage)
	end
end


-- ��Ƽ��� ������ �����ʹ�ư Ŭ��
function OnClickPartyList_NextPage(args)
	if g_currentPage < g_maxPage then
		g_currentPage = g_currentPage + 1
		ChangeCurrentPage(g_currentPage)
	end
end



-- ��Ƽ��� ���콺 ����Ŭ�� ������ �̺�Ʈ
function OnMouseDoubleClickPartyList(args)
	
	-- ���� �ٸ���Ƽ�� ������ �Ǿ����� ���(�̹� ��Ƽ�� ���� �ֽ��ϴ�.)
	local isJoinedd = IsPartyJoined()
	if isJoinedd == true then
		ShowPartyOkBoxFunction(PM_String_AlreadyPartyInclude, 'ClosePartyOKCancelBox');
		return
	end
	
	-- ���� ��Ƽ����� �ε����� ���ؼ� ��Ƽ������ ��û�Ѵ�
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("ListIndex")
	local ownerName = RequestPartyJoin(index)
	if ownerName ~= "" then
		if IsKoreanLanguage() then
			ShowPartyOkBoxFunction2(ownerName,'�Բ�\n��Ƽ��û �޼����� ���½��ϴ�.', 'ClosePartyOKCancelBox')
		else
			ShowPartyOkBoxFunction2("", string.format(PM_String_Send_PartyInviteMsg, ownerName), 'ClosePartyOKCancelBox')
		end
		OnChatPublicWithName("", "[!] "..string.format(PM_String_Send_PartyInviteMsg_forChat, ownerName), 5)
	end	
end


-- ��Ƽ��Ͽ� ���õȰ͵� ��� �ʱ�ȭ
function ClearPartyListSelect()
	for i=0, _PAGENUM-1 do
		winMgr:getWindow("sjParty_List_"..i):setProperty("Selected", "false")
	end
end


--------------------------------------------------------------------
-- ��Ƽâ ��Ƽ���� ��ư(NEW)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sjparty_CreatePartyBtn")
mywindow:setTexture("Normal", "UIData/party003.tga", 673, 784)
mywindow:setTexture("Hover", "UIData/party003.tga", 673, 814)
mywindow:setTexture("Pushed", "UIData/party003.tga", 673, 844)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 673, 874)
mywindow:setPosition(25, 375)
mywindow:setSize(130, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnSelected_PartyCreate")
winMgr:getWindow("sjParty_ListBackImage"):addChildWindow(mywindow)


--------------------------------------------------------

-- 2.��Ƽ���� ����

--------------------------------------------------------
-- ��Ƽ���� ���(����)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_CreateBackImage")
mywindow:setTexture("Enabled", "UIData/party003.tga", 0, 542)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(15, 100)
mywindow:setAlwaysOnTop(true)
mywindow:setSize(383, 482)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("sjParty_CreateBackImage", "ClickPartyCreateClose")

----------------------------------------------
-- (��Ƽ���� �ݱ��ư)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_CrateClose_btn")
mywindow:setTexture("Normal", "UIData/party003.tga", 650, 887)
mywindow:setTexture("Hover", "UIData/party003.tga", 650, 909)
mywindow:setTexture("Pushed", "UIData/party003.tga", 650, 931)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 650, 887)
mywindow:setPosition(350, 10)
mywindow:setSize(22, 22)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyCreateClose")
winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)


function ClickPartyCreateClose()
	winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
	winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
	winMgr:getWindow("sjParty_CreateBackImage"):setVisible(false)
end


--------------------------------------------------------
-- ��Ƽ�������� ������ ����鿡 ���� �����̹���
--------------------------------------------------------
-- (�����Ͻ� ��Ƽ�� ��Ÿ���� ������ �ּ���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_StyleDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 241)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(30, 46)
mywindow:setSize(334, 31)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (�����Ͻ� ��Ƽ�� �̸��� ������ �ּ���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_NameDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 272)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(30, 170)
mywindow:setSize(334, 31)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- 1 ~ 10���� ������ �Һ���� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_AdvantageDesc");
mywindow:setTexture("Enabled", "UIData/party003.tga", 383, 542)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(12, 318)
mywindow:setSize(508, 103)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- ��Ƽ�Ӽ�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_PartyProperty");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 453)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(34, 134)
mywindow:setSize(286, 23)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

----------------------------------------------
-- (��Ƽ�Ӽ� ���� ��ư)
----------------------------------------------
tPartyPropertyName = {["err"]=0, [0]="sjParty_Create_PartyProperty_public", "sjParty_Create_PartyProperty_private"}
tPartyPropertyPosX = {["err"]=0, [0]=126, 204}
for i=0, #tPartyPropertyName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPartyPropertyName[i])
	mywindow:setTexture("Normal", "UIData/party003.tga", 649, 976)
	mywindow:setTexture("Hover", "UIData/party003.tga",  649, 976)
	mywindow:setTexture("Pushed", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("PushedOff", "UIData/party003.tga",  649, 976)
	mywindow:setTexture("SelectedNormal", "UIData/party003.tga",  649, 1000)
	mywindow:setTexture("SelectedHover", "UIData/party003.tga",  649, 1000)
	mywindow:setTexture("SelectedPushed", "UIData/party003.tga",  649, 1000)
	mywindow:setTexture("SelectedPushedOff", "UIData/party003.tga",  649, 1000)
	mywindow:setTexture("Disabled", "UIData/party003.tga", 649, 976)
	mywindow:setPosition(tPartyPropertyPosX[i], 90)
	mywindow:setSize(24, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 8780)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedPartyProperty")
	winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)
end

function OnSelectedPartyProperty(args)
	for i=0, #tPartyPropertyName do
		if CEGUI.toRadioButton(winMgr:getWindow(tPartyPropertyName[i])):isSelected() then
			g_selectPartyProperty = i
		end
	end
end

function InitPartyProperty()
    
    -- ���� �Ӽ� �ʱ�ȭ 
	for i=0, #tPartyPropertyName do
		winMgr:getWindow(tPartyPropertyName[i]):setProperty("Selected", "false")
	end
	winMgr:getWindow(tPartyPropertyName[0]):setProperty("Selected", "true")
	
	-- ����ġ �Ӽ� �ʱ�ȭ
	--for i=0, #tPartyEXPdistributeName do
	--	winMgr:getWindow(tPartyEXPdistributeName[i]):setProperty("Selected", "false")
	--end
	--winMgr:getWindow(tPartyEXPdistributeName[0]):setProperty("Selected", "true")
	
	-- ������ �Ӽ� �ʱ�ȭ 
	for i=0, #tPartyItemdistributeName do
		winMgr:getWindow(tPartyItemdistributeName[i]):setProperty("Selected", "false")
	end
	winMgr:getWindow(tPartyItemdistributeName[0]):setProperty("Selected", "true")
	
	-- �����̵� , ���� ��ġ ����
	
	for i=0, #tSelectRadioPosBtName do
		winMgr:getWindow(tSelectRadioPosBtName[i]):setProperty("Selected", "false")
	end
	
	winMgr:getWindow(tSelectRadioPosBtName[0]):setProperty("Selected", "true")
end



----------------------------------------------
-- (����ġ�Ӽ� ���� ��ư)
----------------------------------------------
--tPartyEXPdistributeName = {["err"]=0, [0]="sjParty_Create_PartyEXP_distribute_no", "sjParty_Create_PartyEXP_distribute_yes"}
--tPartyEXPdistributePosY = {["err"]=0, [0]=200, 224}
--for i=0, #tPartyEXPdistributeName do
--	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPartyEXPdistributeName[i])
--	mywindow:setTexture("Normal", "UIData/party003.tga", 649, 976)
--	mywindow:setTexture("Hover", "UIData/party003.tga", 649, 976)
--	mywindow:setTexture("Pushed", "UIData/party003.tga", 649, 1000)
--	mywindow:setTexture("PushedOff", "UIData/party003.tga", 649, 97)
--	mywindow:setTexture("SelectedNormal", "UIData/party003.tga", 649, 1000)
--	mywindow:setTexture("SelectedHover", "UIData/party003.tga", 649, 1000)
--	mywindow:setTexture("SelectedPushed", "UIData/party003.tga", 649, 1000)
--	mywindow:setTexture("SelectedPushedOff", "UIData/party003.tga", 649, 1000)
--	mywindow:setTexture("Disabled", "UIData/party003.tga", 649, 976)
--	mywindow:setPosition(120, tPartyEXPdistributePosY[i])
--	mywindow:setSize(24, 24)
--	mywindow:setZOrderingEnabled(false)
--	mywindow:setProperty("GroupID", 8790)
--	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedPartyEXPdistribute")
--	winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)
--end

--function OnSelectedPartyEXPdistribute(args)
--	for i=0, #tPartyEXPdistributeName do
--		if CEGUI.toRadioButton(winMgr:getWindow(tPartyEXPdistributeName[i])):isSelected() then
--			g_selectPartyExpProperty = i
--		end
--	end
--end


----------------------------------------------
-- (�����ۼӼ� ���� ��ư)
----------------------------------------------
tPartyItemdistributeName = {["err"]=0, [0]="sjParty_Create_ITEM_distribute_no", "sjParty_Create_ITEM_distribute_order", "sjParty_Create_ITEM_distribute_random"}
tPartyItemdistributePosY = {["err"]=0, [0]= 235, 259, 284}
for i=0, #tPartyItemdistributeName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPartyItemdistributeName[i])
	mywindow:setTexture("Normal", "UIData/party003.tga", 649, 976)
	mywindow:setTexture("Hover", "UIData/party003.tga", 649, 976)
	mywindow:setTexture("Pushed", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("PushedOff", "UIData/party003.tga", 649, 97)
	mywindow:setTexture("SelectedNormal", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("SelectedHover", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("SelectedPushed", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("SelectedPushedOff", "UIData/party003.tga", 649, 1000)
	mywindow:setTexture("Disabled", "UIData/party003.tga", 649, 976)
	mywindow:setPosition(120, tPartyItemdistributePosY[i])
	mywindow:setSize(24, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 8791)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedPartyItemdistribute")
	winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)
end

function OnSelectedPartyItemdistribute(args)
	for i=0, #tPartyItemdistributeName do
		if CEGUI.toRadioButton(winMgr:getWindow(tPartyItemdistributeName[i])):isSelected() then
			g_selectPartyItemProperty = i
		end
	end
end

----------------------------------------------
-- (�̸� �Է�ĭ)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_InputNameDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 507, 589)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(30, 208)
mywindow:setSize(510, 35)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Editbox", "sjParty_Create_NameEditbox")
mywindow:setPosition(110, 58)
mywindow:setSize(250, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:subscribeEvent("TextAccepted", "ClickPartyCreate")
CEGUI.toEditbox(mywindow):setMaxTextLength(32)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

function OnEditboxFullEvent(args)
	PlayWave('sound/FullEdit.wav')
end



----------------------------------------------
-- (��Ƽ���� ��ư)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Create_btn")
mywindow:setTexture("Normal", "UIData/party003.tga", 673, 904)
mywindow:setTexture("Hover", "UIData/party003.tga", 673, 934)
mywindow:setTexture("Pushed", "UIData/party003.tga", 673, 964)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 673,904)
mywindow:setPosition(130, 435)
mywindow:setSize(130, 30)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyCreate")
winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)


-- ��Ƽ���� ������ Ŭ���̾�Ʈ�� ������.
function ClickPartyCreate()

	local partyName = winMgr:getWindow("sjParty_Create_NameEditbox"):getText()
	local partyType = g_selectPartyType
	local partyMaxNum = tSelectNumValue[g_selectMaxNum]	
	CreateParty(partyName, partyType, partyMaxNum, g_selectPartyProperty, g_selectPartyExpProperty, g_selectPartyItemProperty)
	
	winMgr:getWindow("sjParty_Create_NameEditbox"):setText("")
end


-- (��ġ���� â)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_TypePosWindow");
mywindow:setTexture("Enabled", "UIData/invisible.tga", 688, 303)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(115, 124)
mywindow:setSize(240, 21)
winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (��ġ���� â ȭ��ǥ)
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Create_TypePosWindow_btn")
mywindow:setTexture("Normal", "UIData/party003.tga", 629, 944)
mywindow:setTexture("Hover", "UIData/party003.tga", 629, 964)
mywindow:setTexture("Pushed", "UIData/party003.tga", 629, 984)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 629, 944)
mywindow:setPosition(215, 2)
mywindow:setSize(20, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyTypePosForSelect")
winMgr:getWindow("sjParty_Create_TypePosWindow"):addChildWindow(mywindow)

-- (��ġ���� ���õ� ����)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_Create_TypePosWindow_SelectText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(88, 6)
mywindow:setSize(40, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
winMgr:getWindow("sjParty_Create_TypePosWindow"):addChildWindow(mywindow)

-- (��ġ���� ���λ����� �ֱ����� �������)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_TypePosWindow_tempImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(125, 245)
mywindow:setSize(244, 380)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)





-- ��ġ���п��� ������ �����
if IsThaiLanguage() == true then	
	tSelectRadioPosBtName = {['err']=0, [0]="sjParty_Create_TypePos_Arcade", "sjParty_Create_TypePos_Hunting", "sjParty_Create_TypePos_HardArcade"}
end
if IsEngLanguage() == true or IsGSPLanguage() then
	tSelectRadioPosBtName = {['err']=0, [0]="sjParty_Create_TypePos_Arcade", "sjParty_Create_TypePos_Hunting"}
end


for i=0, #tSelectRadioPosBtName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tSelectRadioPosBtName[i])
	mywindow:setTexture("Normal", "UIData/party003.tga", 383, 986)
	mywindow:setTexture("Hover", "UIData/party003.tga", 383, 1005)
	mywindow:setTexture("Pushed", "UIData/party003.tga", 383, 986)
	mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 986)
	mywindow:setPosition(0, i*18)
	mywindow:setProperty("GroupID", 8300)
	mywindow:setSize(244, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectPartyTypePos")
	winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):addChildWindow(mywindow)
	
	-- ��ġ���� �����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tSelectRadioPosBtName[i].."text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(59, 1)
	mywindow:setSize(116, 5)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setTextExtends(tStringByPartyTypePos[i], g_STRING_FONT_GULIM, 13, 		
	tColorOfPartyPosType[i][1],tColorOfPartyPosType[i][2],tColorOfPartyPosType[i][3],255,  0, 255,255,255,255)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(tSelectRadioPosBtName[i]):addChildWindow(mywindow)
end

-- ��ġ������ �����ϱ� ���� ȭ��ǥ Ŭ��
function ClickPartyTypePosForSelect()
	if winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):isVisible() then
		winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
	else
		winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"))
	end
	
	winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
end

-- ���ϴ� ��ġ���� ����
function OnSelectPartyTypePos()
	DebugStr('OnSelectPartyTypePos')
	for i=0, #tSelectRadioPosBtName do
		if CEGUI.toRadioButton(winMgr:getWindow(tSelectRadioPosBtName[i])):isSelected() then
			winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
			winMgr:getWindow("sjParty_Create_TypePosWindow_SelectText"):setVisible(true)
			winMgr:getWindow("sjParty_Create_TypePosWindow_SelectText"):setTextExtends(tStringByPartyTypePos[i], g_STRING_FONT_GULIM, 12, 
					tColorOfPartyPosType[i][1],tColorOfPartyPosType[i][2],tColorOfPartyPosType[i][3],255,  0, 255,255,255,255)
			winMgr:getWindow(tSelectRadioPosBtName[i]):setProperty("Selected", "false")
			
			winMgr:getWindow(tSelectRadioBtName[0]):setProperty("Selected", "true")
			
			local tSelectRadioBtNamePos = 18
			local lastRadioBtNumber = 12
			
			for i=1 , #tSelectRadioBtName do 
				winMgr:getWindow(tSelectRadioBtName[i]):setVisible(false)
			end
			
			if i == 0 then
				if ZoneTypeNumber == 3 then
					if CheckfacilityData(tCheckArcadeTypeNumber[12]) == 1 then
						winMgr:getWindow(tSelectRadioBtName[12]):setPosition(0, tSelectRadioBtNamePos)
						winMgr:getWindow(tSelectRadioBtName[12]):setVisible(true)
					end
				else
					for i=2 , 6 do 
						if CheckfacilityData(tCheckArcadeTypeNumber[i-2]) == 1 then
							winMgr:getWindow(tSelectRadioBtName[i]):setPosition(0, tSelectRadioBtNamePos)
							tSelectRadioBtNamePos = tSelectRadioBtNamePos+18
							winMgr:getWindow(tSelectRadioBtName[i]):setVisible(true)
						end
					end	
				end
			elseif i == 2 then
				DebugStr("ZoneTypeNumber" .. ZoneTypeNumber)
				if ZoneTypeNumber == 3 then
					
				else
					for i=2 , 2 do 
						if CheckfacilityData(tCheckArcadeTypeNumber[i-2]) == 1 then
							winMgr:getWindow(tSelectRadioBtName[i]):setPosition(0, tSelectRadioBtNamePos)
							tSelectRadioBtNamePos = tSelectRadioBtNamePos+18
							winMgr:getWindow(tSelectRadioBtName[i]):setVisible(true)
						end
					end	
				end
			
			else
				if ZoneTypeNumber == 3 then
					if CheckfacilityData(tCheckArcadeTypeNumber[13]) == 1 then
						winMgr:getWindow(tSelectRadioBtName[13]):setPosition(0, tSelectRadioBtNamePos)
						winMgr:getWindow(tSelectRadioBtName[13]):setVisible(true)
					end
				else
					for i=7 , #tSelectRadioBtName-2 do 
						if CheckfacilityData(tCheckArcadeTypeNumber[i-2]) == 1 then
							winMgr:getWindow(tSelectRadioBtName[i]):setPosition(0, tSelectRadioBtNamePos)
							tSelectRadioBtNamePos = tSelectRadioBtNamePos+18
							winMgr:getWindow(tSelectRadioBtName[i]):setVisible(true)
						end
					end
				end
			end
			
			--[[
			for i=2 , TypeCheckLastNumber do --#tSelectRadioBtName
				if i > TypeCheckNumber then
					if CheckfacilityData(tCheckArcadeTypeNumber[i-2]) == 1 then
						tSelectRadioBtNamePos = tSelectRadioBtNamePos+31
						winMgr:getWindow(tSelectRadioBtName[i]):setPosition(0, tSelectRadioBtNamePos)
						winMgr:getWindow(tSelectRadioBtName[i]):setVisible(true)
						lastRadioBtNumber = i
					end	
				end	
			end
			--]]
		end
	end
end

----------------------------------------------
-- (��Ƽ����)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_TypeDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 303)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(40, 84)
mywindow:setSize(92, 31)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (��Ƽ���� â)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_TypeWindow");
mywindow:setTexture("Enabled", "UIData/invisible.tga", 688, 303)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(115, 150)
mywindow:setSize(240, 21)
winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (��Ƽ���� â ȭ��ǥ)
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Create_TypeWindow_btn")
mywindow:setTexture("Normal", "UIData/party003.tga", 629, 944)
mywindow:setTexture("Hover", "UIData/party003.tga", 629, 964)
mywindow:setTexture("Pushed", "UIData/party003.tga", 629, 984)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 629, 944)
mywindow:setPosition(215, 2)
mywindow:setSize(20, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyTypeForSelect")
winMgr:getWindow("sjParty_Create_TypeWindow"):addChildWindow(mywindow)

-- (��Ƽ���� ���õ� ����)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_Create_TypeWindow_SelectText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(88, 6)
mywindow:setSize(40, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
winMgr:getWindow("sjParty_Create_TypeWindow"):addChildWindow(mywindow)

-- (��Ƽ���� ���λ����� �ֱ����� �������)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_TypeWindow_tempImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(125, 270)
mywindow:setSize(244, 380)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- ��Ƽ���п��� ������ �����
tSelectRadioBtName = {['err']=0, [0]="sjParty_Create_Type_ready", "sjParty_Create_Type_battle", "sjParty_Create_Type_park", 
										   "sjParty_Create_Type_hotel", "sjParty_Create_Type_halem", "sjParty_Create_Type_HRoad", 
										   "sjParty_Create_Type_subway", "sjParty_Create_Type_Practice" ,"sjParty_Create_Type_Center", 
										   "sjParty_Create_Type_Fight" , "sjParty_Create_Type_Agit", "sjParty_Create_Type_CloseSubway",
										   "sjParty_Create_Type_ArcadeTemple", "sjParty_Create_Type_HuntingTemple"}

for i=0, #tSelectRadioBtName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tSelectRadioBtName[i])
	mywindow:setTexture("Normal", "UIData/party003.tga", 383, 986)
	mywindow:setTexture("Hover", "UIData/party003.tga", 383, 1005)
	mywindow:setTexture("Pushed", "UIData/party003.tga", 383, 986)
	mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 986)
	mywindow:setPosition(0, i*18)
	mywindow:setProperty("GroupID", 8200)
	mywindow:setSize(244, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectPartyType")
	winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):addChildWindow(mywindow)
	
	-- ��Ƽ���� �����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tSelectRadioBtName[i].."text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(58, 3)
	mywindow:setSize(116, 5)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 12, 
			tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,  0, 255,255,255,255)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(tSelectRadioBtName[i]):addChildWindow(mywindow)
end

-- ��Ƽ������ �����ϱ� ���� ȭ��ǥ Ŭ��
function ClickPartyTypeForSelect()
	if winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):isVisible() then
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
	else
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"))
	end
	
	winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
end

-- ���ϴ� ��Ƽ���� ����
function OnSelectPartyType()
	for i=0, #tSelectRadioBtName do
		if CEGUI.toRadioButton(winMgr:getWindow(tSelectRadioBtName[i])):isSelected() then
			winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
			
			g_selectPartyType = i
			winMgr:getWindow("sjParty_Create_TypeWindow_SelectText"):setVisible(true)
			winMgr:getWindow("sjParty_Create_TypeWindow_SelectText"):setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 12, 
					tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,  0, 255,255,255,255)
			winMgr:getWindow(tSelectRadioBtName[i]):setProperty("Selected", "false")
		end
	end
end



----------------------------------------------
-- (�ο�)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_NumDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 334)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(320, 84)
mywindow:setSize(92, 31)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (�ο� â)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_NumWindow");
mywindow:setTexture("Enabled", "UIData/party001.tga", 828, 303)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(402, 84)
mywindow:setSize(123, 31)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)

-- (�ο� â ȭ��ǥ)
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Create_NumWindow_btn")
mywindow:setTexture("Normal", "UIData/party001.tga", 92, 585)
mywindow:setTexture("Hover", "UIData/party001.tga", 92, 603)
mywindow:setTexture("Pushed", "UIData/party001.tga", 92, 621)
mywindow:setTexture("PushedOff", "UIData/party001.tga", 92, 585)
mywindow:setPosition(92, 5)
mywindow:setSize(18, 18)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyNumForSelect")
--winMgr:getWindow("sjParty_Create_NumWindow"):addChildWindow(mywindow)

-- (�ο� ���õ� ����)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_Create_NumWindow_SelectText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(30, 6)
mywindow:setSize(40, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:clearTextExtends()
mywindow:setTextExtends("4", g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 255,255,255,255)
--winMgr:getWindow("sjParty_Create_NumWindow"):addChildWindow(mywindow)

-- (�ο� ���λ����� �ֱ����� �������)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Create_NumWindow_tempImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(402, 115)
mywindow:setSize(123, 300)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--winMgr:getWindow("sjParty_CreateBackImage"):addChildWindow(mywindow)


-- �ο����� ������ �����
tSelectNumValue = {['err']=0, [0]=1, 2, 3, 4}	-- �������� ���� �޼��� ��ȣ(local ������)
local tSelectNumName  = {['err']=0, [0]="sjParty_Create_Num_1", "sjParty_Create_Num_2", "sjParty_Create_Num_3", "sjParty_Create_Num_4"}
local tSelectNumTexX  = {['err']=0, [0]=334, 334, 334, 365}
local tSelectNumText  = {['err']=0, [0]="1", "2", "3", "4"}
local tSelectNumPosY  = {['err']=0, [0]=0, 31, 31*2, 31*3}
for i=0, #tSelectNumName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tSelectNumName[i])
	mywindow:setTexture("Normal", "UIData/party001.tga", 828, tSelectNumTexX[i])
	mywindow:setTexture("Hover", "UIData/party001.tga", 828, 396)
	mywindow:setTexture("Pushed", "UIData/party001.tga", 828, 396)
	mywindow:setPosition(0, tSelectNumPosY[i])
	mywindow:setProperty("GroupID", 8201)
	mywindow:setSize(123, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectPartyNum")
	--winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):addChildWindow(mywindow)
	
	-- �ο� �����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tSelectNumName[i].."text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 6)
	mywindow:setSize(100, 31)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setTextExtends(tSelectNumText[i], g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 255,255,255,255)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	--winMgr:getWindow(tSelectNumName[i]):addChildWindow(mywindow)
end


-- ��Ƽ�ο��� �����ϱ� ���� ȭ��ǥ Ŭ��
function ClickPartyNumForSelect()
	if winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):isVisible() then
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
	else
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(true)
	end
end

-- ���ϴ� ��Ƽ�ο� ����
function OnSelectPartyNum()
	for i=0, #tSelectNumName do
		if CEGUI.toRadioButton(winMgr:getWindow(tSelectNumName[i])):isSelected() then
			winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
			
			g_selectMaxNum = i
			winMgr:getWindow("sjParty_Create_NumWindow_SelectText"):setVisible(true)
			winMgr:getWindow("sjParty_Create_NumWindow_SelectText"):setTextExtends(tSelectNumText[i], g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 255,255,255,255)
			winMgr:getWindow(tSelectNumName[i]):setProperty("Selected", "false")
		end
	end
end






--------------------------------------------------------

-- 3.��Ƽ�ʴ� ����

--------------------------------------------------------
-- ��Ƽ�ʴ� ���(����)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_InviteBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(15, 75)
mywindow:setSize(566, 428)
mywindow:setVisible(false)
winMgr:getWindow("sjparty_BackImage"):addChildWindow(mywindow)


--------------------------------------------------------
-- ��Ƽ�ʴ뿡�� ������ ����鿡 ���� �����̹���
--------------------------------------------------------
-- (��Ƽ�� �ʴ��� ������ �̸��� �Է��� �ּ���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Invite_StyleDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 210)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(30, 170)
mywindow:setSize(334, 31)
winMgr:getWindow("sjParty_InviteBackImage"):addChildWindow(mywindow)


----------------------------------------------
-- (�̸� �Է�ĭ)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Invite_InputNameDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 507, 589)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(30, 208)
mywindow:setSize(510, 35)
winMgr:getWindow("sjParty_InviteBackImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Editbox", "sjParty_Invite_NameEditbox")
mywindow:setPosition(2, 4)
mywindow:setSize(400, 25)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:subscribeEvent("TextAccepted", "ClickPartyInvite")
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow("sjParty_Invite_InputNameDesc"):addChildWindow(mywindow)



----------------------------------------------
-- (��Ƽ�ʴ� ��ư)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sjParty_Invite_btn")
mywindow:setTexture("Normal", "UIData/party001.tga", 231, 585)
mywindow:setTexture("Hover", "UIData/party001.tga", 231, 626)
mywindow:setTexture("Pushed", "UIData/party001.tga", 231, 667)
mywindow:setTexture("PushedOff", "UIData/party001.tga", 231, 585)
mywindow:setPosition(223, 270)
mywindow:setSize(121, 41)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickPartyInvite")
winMgr:getWindow("sjParty_InviteBackImage"):addChildWindow(mywindow)

function ClickPartyInvite()
	local inviteName = winMgr:getWindow("sjParty_Invite_NameEditbox"):getText()
	RequestPartyInvite(inviteName)
	winMgr:getWindow("sjParty_Invite_NameEditbox"):setText("")
end







--------------------------------------------------------

-- 4.��Ƽ���� ����

--------------------------------------------------------
-- ��Ƽ���� ���(����)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_InfoBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(15, 75)
mywindow:setSize(566, 428)
mywindow:setVisible(false)
winMgr:getWindow("sjparty_BackImage"):addChildWindow(mywindow)


-- ��Ƽ�̸� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Info_PartyNameDesc");
mywindow:setTexture("Enabled", "UIData/party001.tga", 596, 396)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(34, 30)
mywindow:setSize(92, 31)
winMgr:getWindow("sjParty_InfoBackImage"):addChildWindow(mywindow)


----------------------------------------------
-- (��Ƽ�̸� �Է�ĭ)
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sjParty_Info_PartyNameBack");
mywindow:setTexture("Enabled", "UIData/party001.tga", 0, 554)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(110, 30)
mywindow:setSize(352, 31)
winMgr:getWindow("sjParty_InfoBackImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sjParty_Info_PartyNameText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(10, 0)
mywindow:setSize(352, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(LAN_FONT_HY_GUYNGODIC, 16)
mywindow:setTextColor(97,230,255,255)
winMgr:getWindow("sjParty_Info_PartyNameBack"):addChildWindow(mywindow)



-- ��Ƽ����â�� �ִ� ������ �̹���
local tBoneImageTexX = {["err"]=0, [0]=685, 548, 411, 0, 137, 274}
local tInfoBackName  = {["err"]=0, [0]="sjParty_info_userBack1", "sjParty_info_userBack2", "sjParty_info_userBack3", "sjParty_info_userBack4"}
local tInfoBackPosX  = {["err"]=0, [0]=2, 144, 286, 428}
for i=0, #tInfoBackName do
	
	-- Empty �����̹���(�� �̹���)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i].."temp")
	mywindow:setTexture("Enabled", "UIData/party002.tga", 822, 0)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 822, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(tInfoBackPosX[i], 92)
	mywindow:setSize(137, 334)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow("sjParty_InfoBackImage"):addChildWindow(mywindow)
	
	-- �� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i])
	mywindow:setTexture("Enabled", "UIData/party002.tga", 822, 0)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 822, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(tInfoBackPosX[i], 92)
	mywindow:setSize(137, 334)
	mywindow:setEnabled(false)
	winMgr:getWindow("sjParty_InfoBackImage"):addChildWindow(mywindow)
	
	-- ������, ����, Ŭ����, Ŭ��, ���� �����̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i].."addImage")
	mywindow:setTexture("Enabled", "UIData/party001.tga", 352, 554)
	mywindow:setTexture("Disabled", "UIData/party001.tga", 352, 554)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(1, 240)
	mywindow:setSize(136, 93)
	mywindow:setEnabled(false)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 1. ������(�ؽ�Ʈ)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tInfoBackName[i].."nameText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(48, 242)
	mywindow:setSize(352, 25)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 2. ����(�ؽ�Ʈ)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tInfoBackName[i].."levelText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(52, 258)
	mywindow:setSize(352, 25)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 3. Ŭ����(�̹���)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i].."classImage")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(48, 274)
	mywindow:setSize(89, 35)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	mywindow:setScaleWidth(180)
	mywindow:setScaleHeight(180)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 4. Ŭ��(�ؽ�Ʈ)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tInfoBackName[i].."clubText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(52, 292)
	mywindow:setSize(352, 25)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 5. ����(�̹���)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i].."ladderImage")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(48, 310)
	mywindow:setSize(47, 21)
	mywindow:setEnabled(false)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
	-- 6. ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tInfoBackName[i].."masterImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(4, 4)
	mywindow:setSize(75, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow(tInfoBackName[i]):addChildWindow(mywindow)
	
end






---------------------------------------------------------

-- �����Լ�

---------------------------------------------------------

-- ���� �� �κ��丮�� �����̵� �̿���� ������츸 ���ð����ϵ���
function SetArcadeTicketEnabled(i, isTicket)
	--DebugStr('�����̵�ѹ�:'..i)
	-- ��Ƽ NPC������ ��Ƽâ���� ���°�
	if isTicket == 1 then
		winMgr:getWindow(tSelectRadioBtName[i]):setEnabled(true)
		local window = winMgr:getWindow(tSelectRadioBtName[i].."text")
		window:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 12, 
			tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,   0, 255,255,255,255)
	else
		winMgr:getWindow(tSelectRadioBtName[i]):setEnabled(true)
		local window = winMgr:getWindow(tSelectRadioBtName[i].."text")
		window:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 12, 130,130,130,255,   0, 255,255,255,255)
	end
	
	--[[
	-- ���� ��Ƽ �ƹ�Ÿ�� �ִ� ����â
	if isTicket == 1 then
		winMgr:getWindow(tSelectRadioBtName_avarta[i]):setEnabled(true)
		local window = winMgr:getWindow(tSelectRadioBtName_avarta[i].."text")
		window:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 14, 
			tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,   0, 255,255,255,255)
	else
		winMgr:getWindow(tSelectRadioBtName_avarta[i]):setEnabled(true)
		local window = winMgr:getWindow(tSelectRadioBtName_avarta[i].."text")
		window:setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 14, 130,130,130,255,   0, 255,255,255,255)
	end
	--]]
	--SetCheckArcadeEnabled()
end

tCheckArcadeTypeNumber = {['err'] = FACILITYCODE_PARK_ARCADE, FACILITYCODE_HOTEL_ARCADE, FACILITYCODE_HARLEM_ARCADE, FACILITYCODE_HROAD_ARCADE,
									FACILITYCODE_SUBWAY_ARCADE, FACILITYCODE_HUNTING_GROUND,FACILITYCODE_HUNTING_CENTER,FACILITYCODE_HUNTING_OUTLAW,
									FACILITYCODE_HUNTING_HOUSE, FACILITYCODE_HUNTING_STATION, FACILITYCODE_PARK_ARCADE, FACILITYCODE_PARK_ARCADE,
									FACILITYCODE_TEMPLE_ARCADE, FACILITYCODE_HUNTING_TEMPLE }
function SetCheckArcadeEnabled()
	
	local tSelectRadioAvatarBtNamePos = 31
	local lastRadioAvatarBtNumber = 12
	
	local TypeCheckNumber = 1
	local TypeCheckLastNumber = 11
		if ZoneTypeNumber == 3 then
			TypeCheckNumber = 11
			TypeCheckLastNumber = 13
		end
	--[[
	for i = 2 , #tSelectRadioBtName_avarta do --tSelectRadioBtName_avarta
		winMgr:getWindow(tSelectRadioBtName_avarta[i]):setVisible(false)
	end
	
	for i = 2 , TypeCheckLastNumber do --tSelectRadioBtName_avarta
		if i > TypeCheckNumber then
			if CheckfacilityData(tCheckArcadeTypeNumber[i-2]) == 1 then
				tSelectRadioAvatarBtNamePos = tSelectRadioAvatarBtNamePos+31
				winMgr:getWindow(tSelectRadioBtName_avarta[i]):setPosition(0, tSelectRadioAvatarBtNamePos)
				winMgr:getWindow(tSelectRadioBtName_avarta[i]):setVisible(true)
				lastRadioAvatarBtNumber = i
			end	
		end	
		
	end
	--]]
	

	-- ��Ƽ NPC ����â���� On, Off�� �����
	local tSelectRadioBtNamePos = 31
	local lastRadioBtNumber = 12
	
	for i=2 , #tSelectRadioBtName do --#tSelectRadioBtName
		winMgr:getWindow(tSelectRadioBtName[i]):setVisible(false)
	end
	
	for i=2 , TypeCheckLastNumber do --#tSelectRadioBtName
		if i > TypeCheckNumber then
			if CheckfacilityData(tCheckArcadeTypeNumber[i + 1]) == 1 then
				tSelectRadioBtNamePos = tSelectRadioBtNamePos+31
				winMgr:getWindow(tSelectRadioBtName[i]):setPosition(0, tSelectRadioBtNamePos)
	--			winMgr:getWindow(tSelectRadioBtName[i]):setVisible(true)
				lastRadioBtNumber = i
			end	
		end	
	end	
	winMgr:getWindow(tSelectRadioBtName[lastRadioBtNumber]):setTexture("Normal", "UIData/party001.tga", 688, 365)
	winMgr:getWindow(tSelectRadioBtName[lastRadioBtNumber]):setTexture("Hover", "UIData/party001.tga", 688, 396)
	winMgr:getWindow(tSelectRadioBtName[lastRadioBtNumber]):setTexture("Pushed", "UIData/party001.tga", 688, 396)
	winMgr:getWindow(tSelectRadioBtName[lastRadioBtNumber]):setTexture("Disabled", "UIData/party001.tga", 688, 365)
end

-----------------------------------------------
-- �����ϰ� �ִ� Ƽ���߿� 1��° Ƽ��Ÿ���� ����
-----------------------------------------------
function Set1stHaveATicket(typeIndex)
	g_selectPartyType = typeIndex
	local window = winMgr:getWindow("sjParty_Create_TypeWindow_SelectText")
	window:setTextExtends(tStringByPartyType[typeIndex], g_STRING_FONT_GULIM, 12, 
		tColorOfPartyType[typeIndex][1],tColorOfPartyType[typeIndex][2],tColorOfPartyType[typeIndex][3],255,   0, 255,255,255,255)
				
end



-----------------------------------------------
-- �ʱ⿡ ��Ƽ ������ ����
-----------------------------------------------
function InitPartyWindow()
	DebugStr('InitPartyWindow()')
	if IsPartyJoined() then
		winMgr:getWindow("sjparty_List"):setProperty("Selected", "true")
		winMgr:getWindow("sjparty_Create"):setVisible(false)
		winMgr:getWindow("sjparty_Info"):setVisible(true)
		winMgr:getWindow("sjparty_CreatePartyBtn"):setVisible(false)
	else
		winMgr:getWindow("sjparty_List"):setProperty("Selected", "true")
		winMgr:getWindow("sjparty_Create"):setVisible(true)
		winMgr:getWindow("sjparty_Info"):setVisible(false)
		winMgr:getWindow("sjparty_CreatePartyBtn"):setVisible(true)
		--InitPartyProperty()
	end
end



-----------------------
-- ��Ƽ ������ ����
-----------------------
function ShowPartyWindow()
	
	-- �����̵� �̿�� ����
	FindArcadeTicket()
	
	InitPartyWindow()
	root:addChildWindow(winMgr:getWindow("sjparty_BackImage"))
	winMgr:getWindow("sjparty_BackImage"):setVisible(true)
end



-----------------------
-- ��Ƽ ������ �ݱ�
-----------------------
function ClosePartyWindow()
	VirtualImageSetVisible(false)
	winMgr:getWindow("sjparty_BackImage"):setVisible(false)
	winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
	winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
	winMgr:getWindow('sjParty_Create_NameEditbox'):deactivate()
	winMgr:getWindow('sjParty_Invite_NameEditbox'):deactivate()
end


-----------------------
-- ��Ƽ ������ �ݱ��ư �̺�Ʈ
-----------------------
function ClosePartyWindowButtonEvent()
	VirtualImageSetVisible(false)
	winMgr:getWindow("sjparty_BackImage"):setVisible(false)
	winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
	winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
	winMgr:getWindow('sjParty_Create_NameEditbox'):deactivate()
	winMgr:getWindow('sjParty_Invite_NameEditbox'):deactivate()
	TownNpcEscBtnClickEvent()
end




-----------------------------------------------
-- ���� ��Ƽ������ �Ұ�� ��Ƽ����â�� ���δ�.
-----------------------------------------------
function UpdatePartyWindow()
	
	if	winMgr:getWindow("sjparty_Info") == nil	or winMgr:getWindow("sjparty_Create") == nil then
		return
	end
	
	if IsPartyJoined() then
		if g_currentParty == PARTY_TAB_CREATE then
			winMgr:getWindow("sjparty_Info"):setProperty("Selected", "true")
		end
		winMgr:getWindow("sjparty_Create"):setVisible(false)
		winMgr:getWindow("sjparty_Info"):setVisible(true)
	else
		if g_currentParty == PARTY_TAB_INFO then
			winMgr:getWindow("sjparty_Create"):setProperty("Selected", "true")
		end
		winMgr:getWindow("sjparty_Create"):setVisible(true)
		winMgr:getWindow("sjparty_Info"):setVisible(false)
	end
end





-------------------------------------------------------------------

-- ����Ƽ ������Ʈ

-------------------------------------------------------------------
function ClearMyPartyList(partyName)
	for i=0, #tInfoBackName do
		if winMgr:getWindow(tInfoBackName[i].."temp") then
			winMgr:getWindow(tInfoBackName[i].."temp"):setVisible(true)
			
			if winMgr:getWindow(tInfoBackName[i]) then
				winMgr:getWindow(tInfoBackName[i]):setVisible(false)
			end
		end
	end
	
	-- ��Ƽ�̸�
	if winMgr:getWindow("sjParty_Info_PartyNameText") then
		winMgr:getWindow("sjParty_Info_PartyNameText"):setText(partyName)
	end
end



function UpdateMyPartyList(i, bone, name, level, style, club, ladder, bMaster, promotion, attribute, iArcadeCoupnCount)
	
	-- ��Ƽ������ ���̰��ϱ�
	if winMgr:getWindow(tInfoBackName[i].."temp") then
		winMgr:getWindow(tInfoBackName[i].."temp"):setVisible(false)
	end
	
	-- �� �̹��� ����
	if winMgr:getWindow(tInfoBackName[i]) then
		winMgr:getWindow(tInfoBackName[i]):setVisible(true)
		winMgr:getWindow(tInfoBackName[i]):setTexture("Disabled", "UIData/party002.tga", tBoneImageTexX[bone], 0)
	end
	
	-- 1. �̸�
	if winMgr:getWindow(tInfoBackName[i].."nameText") then
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
		winMgr:getWindow(tInfoBackName[i].."nameText"):setText(summaryName)
	end
	
	-- 2. ����
	if winMgr:getWindow(tInfoBackName[i].."levelText") then
		winMgr:getWindow(tInfoBackName[i].."levelText"):setText("Lv."..level)
	end
	
	-- 3. Ŭ���� �̹���
	if winMgr:getWindow(tInfoBackName[i].."classImage") then
		winMgr:getWindow(tInfoBackName[i].."classImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
		winMgr:getWindow(tInfoBackName[i].."classImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	end
	
	-- 4. Ŭ��
	if winMgr:getWindow(tInfoBackName[i].."clubText") then
		winMgr:getWindow(tInfoBackName[i].."clubText"):setText(club)
	end
	
	-- 5. ���� �̹���
	if winMgr:getWindow(tInfoBackName[i].."ladderImage") then
		winMgr:getWindow(tInfoBackName[i].."ladderImage"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	end
	
	-- 6. ������ �̹���
	if winMgr:getWindow(tInfoBackName[i].."masterImage") then
		if bMaster == 1 then
			winMgr:getWindow(tInfoBackName[i].."masterImage"):setVisible(true)
		else
			winMgr:getWindow(tInfoBackName[i].."masterImage"):setVisible(false)
		end
	end
end






-------------------------------------------------------------------

--	��Ƽ�� -> ��Ƽ�� (��Ƽ���� ��Ƽ������ �ʴ�޼����� ������ ��)

-------------------------------------------------------------------
-- ��Ƽ�� �̸�
g_PartyRequestOwnerName = nil

-- ����
function OnClickPartyInvitedQuestOk(args)

	if winMgr:getWindow('sj_party_OkCancelBox') then
		local okfunc = winMgr:getWindow('sj_party_OkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickPartyInvitedQuestOk" then
			return
		end
		winMgr:getWindow('sj_party_OkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_party_AlphaImg'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_party_AlphaImg'))
		local local_window = winMgr:getWindow('sj_party_OkCancelBox')
		winMgr:getWindow('sj_party_AlphaImg'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		-- ��Ƽ���� ����
		if g_PartyRequestOwnerName ~= nil then
			PartyJoin(g_PartyRequestOwnerName)
		end	
	--	OnChatPublicWithName('', '[!] '..string.format(PM_String_Join_UserParty, g_PartyRequestOwnerName), 5)
	end
end


-- ����
function OnClickPartyInvitedQuestCancel(args)
	
	if winMgr:getWindow('sj_party_OkCancelBox') then
		local nofunc = winMgr:getWindow('sj_party_OkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickPartyInvitedQuestCancel" then
			return
		end
		winMgr:getWindow('sj_party_OkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_party_AlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_party_AlphaImg'))
		local local_window = winMgr:getWindow('sj_party_OkCancelBox')
		winMgr:getWindow('sj_party_AlphaImg'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		-- ��Ƽ���� ����
		if g_PartyRequestOwnerName ~= nil then
			PartyInviteRefuse(g_PartyRequestOwnerName);
		end	
		OnChatPublicWithName('', '[!] '..string.format(PM_String_Refuse_PartyInvite, g_PartyRequestOwnerName), 5)
	end
end




-------------------------------------------------------------------

--	��Ƽ�� -> ��Ƽ�� (��Ƽ���� ��Ƽ������ �ʴ��� �޶�� �޼����� ������)

-------------------------------------------------------------------
g_PartyTriedCharName = nil

-- ����(�ٷ� ���� ��Ų��)
function OnClickPartyTriedQuestOk(args)
		DebugStr('��Ƽ��->��Ƽ��')
	if winMgr:getWindow('sj_party_OkCancelBox') then
		local okfunc = winMgr:getWindow('sj_party_OkCancelBox'):getUserString("okFunction")
		if okfunc ~= "OnClickPartyTriedQuestOk" then
			return
		end
		winMgr:getWindow('sj_party_OkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_party_AlphaImg'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_party_AlphaImg'))
		local local_window = winMgr:getWindow('sj_party_OkCancelBox')
		winMgr:getWindow('sj_party_AlphaImg'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		-- ��Ƽ���� ����
		SetVillageInputEnable(true)
		PartyJoinByOwner(g_PartyTriedCharName)	
	--	OnChatPublicWithName('', '[!] '..string.format(PM_String_PartyJoinUser, g_PartyTriedCharName), 5)
	end
end


-- ����
function OnClickPartyTriedQuestCancel(args)
	
	if winMgr:getWindow('sj_party_OkCancelBox') then
	
		local nofunc = winMgr:getWindow('sj_party_OkCancelBox'):getUserString("noFunction")
		if nofunc ~= "OnClickPartyTriedQuestCancel" then
			return
		end
		winMgr:getWindow('sj_party_OkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_party_AlphaImg'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_party_AlphaImg'))
		local local_window = winMgr:getWindow('sj_party_OkCancelBox')
		winMgr:getWindow('sj_party_AlphaImg'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		-- ��Ƽ���� ����
		SetVillageInputEnable(true)
		PartyTryRefuse(g_PartyTriedCharName)
		OnChatPublicWithName('', '[!] '..string.format(PM_String_Refuse_PartyRequest_User, g_PartyTriedCharName), 5)
	end
end






-------------------------------------------------------------------

-- �޼���

-------------------------------------------------------------------

-- ��Ƽ��� �ʱ�ȭ : UserMessage_UPDATE_PARTYLIST
function WndParty_ClearPartyList()

	-- ��Ƽ��� ��� �ʱ�ȭ
	for i=0, _PAGENUM-1 do
		if winMgr:getWindow("sjParty_List_"..i) then
			winMgr:getWindow("sjParty_List_"..i):setEnabled(false)
		end
		
		for j=0, #tPartyList_infoName do
			if winMgr:getWindow("sjParty_List_"..i..tPartyList_infoName[j]) then
				winMgr:getWindow("sjParty_List_"..i..tPartyList_infoName[j]):setTextExtends("", g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 255,255,255,255)
			end
		end
	end
end


-- ��Ƽ��� ���� : UserMessage_UPDATE_PARTYLIST
function WndParty_UpdatePartyList(i, partyName, partyOwnerName, partyType, curNum, maxNum , expType, ItemType)
	winMgr:getWindow("sjParty_List_"..i):setEnabled(true)
	
	-- ��Ƽ���(��Ƽ����(����°�����), ��Ƽ�̸�, ��Ƽ�� �̸�, �ο�) ����
	winMgr:getWindow("sjParty_List_"..i.."sjList_PartyType"):setTextExtends(tStringByPartyType[partyType], g_STRING_FONT_GULIMCHE, 11, 
					tColorOfPartyType[partyType][1],tColorOfPartyType[partyType][2],tColorOfPartyType[partyType][3],255,   0, 255,255,255,255)
	
	local summarypartyName = SummaryString(g_STRING_FONT_GULIMCHE, 14, partyName, 200)
	winMgr:getWindow("sjParty_List_"..i.."sjList_PartyName"):setTextExtends(summarypartyName, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("sjParty_List_"..i.."sjList_PartyOwnerName"):setTextExtends(partyOwnerName, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("sjParty_List_"..i.."sjList_PartyItemType"):setTextExtends(tStringByPartyItemType[ItemType], g_STRING_FONT_GULIMCHE, 11, 200,100,255,255,   0, 255,255,255,255)
	winMgr:getWindow("sjParty_List_"..i.."sjList_PartyExpType"):setTextExtends(tStringByPartyExpType[expType], g_STRING_FONT_GULIMCHE, 11, 255,178,255,255,   0, 255,255,255,255)
	
	-- �ο��� �������(���úҰ� �� ������ ǥ��)
	if curNum == maxNum then
		winMgr:getWindow("sjParty_List_"..i):setEnabled(false)
		winMgr:getWindow("sjParty_List_"..i.."sjList_PartyNum"):setTextExtends(curNum.." / "..maxNum, g_STRING_FONT_GULIMCHE, 11, 255,0,0,255,   0, 255,255,255,255)
	else
		winMgr:getWindow("sjParty_List_"..i):setEnabled(true)
		winMgr:getWindow("sjParty_List_"..i.."sjList_PartyNum"):setTextExtends(curNum.." / "..maxNum, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 255,255,255,255)
	end
end


-- ��Ƽ��� ���� ������ / ��Ż ������ : UserMessage_UPDATE_PARTYLIST
function WndParty_PartyListPage(currentPage, maxPage)
	g_currentPage = currentPage
	g_maxPage = maxPage
	
	if winMgr:getWindow("sjParty_List_PageText") then
		winMgr:getWindow("sjParty_List_PageText"):setTextExtends(currentPage.." / "..maxPage, g_STRING_FONT_GULIMCHE, 16, 255,255,255,255,   0, 255,255,255,255)
	end
end



-- ��Ƽ�� �������� �� : UserMessage_PARTY_JOINED
function OnMessage_PartyJoined(joinName, myName, popupListSize)
	
	-- ���� ������ ���	
	local ownerName = GetPartyOwnerName()
	if ownerName == myName then
		
		-- ���� ������ �� �ٸ������ ����Ƽ�� ������ ��� : %s���� ��Ƽ�� �շ��Ͽ����ϴ�.
		if joinName ~= myName then
			if popupListSize <= 0 then
				ShowPartyOkBoxFunction(string.format(PM_String_PartyJoinUser, joinName), 'ClosePartyOKCancelBox')
			end
			OnChatPublicWithName('', '[!] '..string.format(PM_String_PartyJoinUser, joinName), 5)
		end
	else
		
		-- ���� ������ �ƴҰ��
		if joinName == myName then
			-- ���� ��Ƽ�� �����ϸ� : %s���� ��Ƽ�� �շ��Ͽ����ϴ�.
			ShowPartyOkBoxFunction(string.format(PM_String_Join_UserParty, ownerName), 'ClosePartyOKCancelBox')
			OnChatPublicWithName('', '[!] '..string.format(PM_String_Join_UserParty, ownerName), 5)
		else
			-- �ٸ������ ��Ƽ�� ������ ��� : %s���� ��Ƽ�� �շ��Ͽ����ϴ�.
			ShowPartyOkBoxFunction(string.format(PM_String_PartyJoinUser, joinName), 'ClosePartyOKCancelBox')
			OnChatPublicWithName('', '[!] '..string.format(PM_String_PartyJoinUser, joinName), 5)
		end
	end
end


-- ��Ƽ���� ������ �� : UserMessage_PARTY_UNJOINED
function OnMessage_PartyUnJoined(unJoinName)
	ShowPartyOkBoxFunction(string.format(PM_String_PartyLeaveUser, unJoinName), 'ClosePartyOKCancelBox')
	OnChatPublicWithName('', '[!] '..string.format(PM_String_PartyLeaveUser, unJoinName), 5)
	
	if g_strSelectRButtonUp == unJoinName then
		if winMgr:getWindow('pu_btnContainer'):isVisible() then
			root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
			
			-- ���콺 ���������� ������ ���� �̸� �ʱ�ȭ
			ClearSelectRButtonUser()
		end
	end
end


-- ��Ƽ�ʴ� �޼����� ������� : UserMessage_PARTY_INVITE_RETURN
function OnMessage_PartyInviteReturn(inviteName)
	if IsKoreanLanguage() then
		ShowPartyOkBoxFunction2(inviteName,'�Բ�\n��Ƽ�ʴ� �޼����� ���½��ϴ�.', 'ClosePartyOKCancelBox')
	else
		ShowPartyOkBoxFunction2("", string.format(PM_String_Send_PartyInviteMsg_User, inviteName), 'ClosePartyOKCancelBox')
	end
	OnChatPublicWithName('', '[!] '..string.format(PM_String_Send_PartyInviteMsg_User, inviteName), 5)
end


-- ��Ƽ �ʴ븦 �Ҷ� �������� ��Ƽ������ ���� �޼��� : UserMessage_PARTY_INVITED
function OnMessage_PartyInvited(ownerName)
	if IsKoreanLanguage() then
		ShowPartyOkCancelBoxFunction2(ownerName, '����\n��Ƽ�� �ʴ��ϼ̽��ϴ�.\n�����Ͻðڽ��ϱ�?', 'OnClickPartyInvitedQuestOk', 'OnClickPartyInvitedQuestCancel')
	else
		ShowPartyOkCancelBoxFunction2("", string.format(PM_String_PartyInviteMsgOk, ownerName), 'OnClickPartyInvitedQuestOk', 'OnClickPartyInvitedQuestCancel')	
	end
	
	-- ��Ƽ�� �̸��� �����Ѵ�.
	g_PartyRequestOwnerName = ownerName
	OnChatPublicWithName('', '[!] '..string.format(PM_String_Receive_PartyInviteMsg, ownerName), 5)
end


-- ��Ƽ �ʴ븦 �ź��Ҷ� ������ ��Ƽ�忡�� ������ �޼��� : UserMessage_PARTY_INVITE_REFUSED
function OnMessage_PartyInviteRefused(username)	
	if IsKoreanLanguage() then
		ShowPartyOkBoxFunction2(username,'����\n��Ƽ�ʴ븦 �����Ͽ����ϴ�.', 'ClosePartyOKCancelBox')
	else
		ShowPartyOkBoxFunction2("", string.format(PM_String_Refuse_User_PartyInvite, username), 'ClosePartyOKCancelBox')
	end
	OnChatPublicWithName('', '[!] '..string.format(PM_String_Refuse_User_PartyInvite2, username), 5)
end


-- ��Ƽ������ ��û�Ҷ� �������� ��Ƽ������ ���� �޼��� : UserMessage_PARTY_TRIED
function OnMessage_PartyTried(username, level, style, lifeNum, promotion, attribute)

	if IsKoreanLanguage() then
		local userInfo = "Lv."..level.." "..username
		ShowPartyOkCancelBoxFunction_Ex("", userInfo, '����\n��Ƽ������ ����մϴ�.\n�����Ͻðڽ��ϱ�?', 'OnClickPartyTriedQuestOk', 'OnClickPartyTriedQuestCancel')
	else
		local userInfo = "Lv."..level.." "..username
		ShowPartyOkCancelBoxFunctionWithImage(string.format(PM_String_User_PartyJoinOKMsg, userInfo), style, promotion, attribute, lifeNum, 'OnClickPartyTriedQuestOk', 'OnClickPartyTriedQuestCancel')
	end	
	
	-- ä��â���� �̸��� �����ش�.
	g_PartyTriedCharName = username
	OnChatPublicWithName('', '[!] '..string.format(PM_String_User_PartyJoinRequest, username), 5)
end


-- ������ ��Ƽ������ �޼����� ���´µ� ��Ƽ���� ������ �� �������� ���� �޼��� : UserMessage_PARTY_TRI_REFUSED
function OnMessage_PartyTriRefused()
	ShowPartyOkBoxFunction(PM_String_Refused_PartyRequest, 'ClosePartyOKCancelBox')
	OnChatPublicWithName('', "[!] "..PM_String_Refused_PartyRequest, 5)
	
	-- ��Ƽ��Ͽ� ���õȰ͵� ��� �ʱ�ȭ
	ClearPartyListSelect()
end


-- ������ �߹��� �� ���� �޼��� : UserMessage_PARTY_BANNED
function OnMessage_PartyBanned()
	ShowPartyOkBoxFunction(PM_String_Ban_Party, 'ClosePartyOKCancelBox')
	OnChatPublicWithName('', "[!] "..PM_String_Ban_Party, 5)
end


-- ��Ƽ�� ���ӽ� ���� �޼���
function OnMessage_PartyChangeOwnerReturn(newPartyOwnerName)
	if IsKoreanLanguage() then
		ShowPartyOkBoxFunction2(newPartyOwnerName,'������\n��Ƽ���� ����Ǿ����ϴ�.', 'ClosePartyOKCancelBox')
	else
		ShowPartyOkBoxFunction2("", string.format(PM_String_PartyChangeOwner, newPartyOwnerName), 'ClosePartyOKCancelBox')
	end
end


-- ��ƼŸ�� ����� ���� �޼���
function OnMessage_PartyChangeTypeReturn(newPartyType)
	if IsKoreanLanguage() then
		ShowPartyOkBoxFunction3(tStringByPartyType[newPartyType],'(��)��\n��Ƽ������ ����Ǿ����ϴ�.', 'ClosePartyOKCancelBox',
			tColorOfPartyType[newPartyType][1], tColorOfPartyType[newPartyType][2], tColorOfPartyType[newPartyType][3])
	else
		ShowPartyOkBoxFunction2("", string.format(PM_String_PartyChangeType, tStringByPartyType[newPartyType]), 'ClosePartyOKCancelBox')
	end
end






--------------------------------------------------------------

-- ��Ƽ ����Ʈ �ƹ�Ÿ ������ ���� ����

--------------------------------------------------------------

winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("PartyMyInfo"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoMaster"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("BigCharAbata"))
--winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoName"))
--winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("PartyMyInfoGage"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoGageHP"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoGageSP"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoQWE"))
winMgr:getWindow("PartyMyInfo"):addChildWindow(winMgr:getWindow("PartyMyInfoDistribute"))
winMgr:getWindow("PartyMyInfoDistribute"):addChildWindow(winMgr:getWindow("PartyMyInfoDistributeItem"))
winMgr:getWindow("PartyMyInfoDistribute"):addChildWindow(winMgr:getWindow("PartyMyInfoDistributeExp"))



winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("PartyInfo1"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1SmallCharAbata"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1Master"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1Level"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1Name"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1HPGage"))
winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1SPGage"))

winMgr:getWindow("PartyInfo1"):setPosition(3, 110);
winMgr:getWindow("PartyInfo2"):setPosition(3, 170);
winMgr:getWindow("PartyInfo3"):setPosition(3, 230);

winMgr:getWindow("PartyMyInfoDistribute"):setPosition(71, 51);
winMgr:getWindow("PartyMyInfoDistributeItem"):setPosition(25, 5);
winMgr:getWindow("PartyMyInfoDistributeExp"):setPosition(110, 5);

winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("PartyInfo2"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2SmallCharAbata"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyI nfo2Master"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2HPGage"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2SPGage"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2Level"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2Name"))


winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("PartyInfo3"))


winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3SmallCharAbata"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3Master"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3HPGage"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3SPGage"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3Level"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3Name"))


winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1ArcadeTicketImage"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2ArcadeTicketImage"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3ArcadeTicketImage"))

winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1ArcadeHardTicketImage"))
winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2ArcadeHardTicketImage"))
winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3ArcadeHardTicketImage"))

--winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1ArcadeTicketCount"))
--winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2ArcadeTicketCount"))
--winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3ArcadeTicketCount"))
--winMgr:getWindow("PartyInfo1"):addChildWindow(winMgr:getWindow("PartyInfo1ArcadeHardTicketCount"))
--winMgr:getWindow("PartyInfo2"):addChildWindow(winMgr:getWindow("PartyInfo2ArcadeHardTicketCount"))
--winMgr:getWindow("PartyInfo3"):addChildWindow(winMgr:getWindow("PartyInfo3ArcadeHardTicketCount"))

-- �ƹ�Ÿ �ؿ� ��ƼŸ�� �����ϴ� ������ ���
--winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("sjParty_Avarta_BackImage"))
winMgr:getWindow("sjParty_Avarta_BackImage"):addChildWindow(winMgr:getWindow("sjParty_Avarta_TypeWindow"))
winMgr:getWindow("sjParty_Avarta_TypeWindow"):addChildWindow(winMgr:getWindow("sjParty_Avarta_TypeWindow_btn"))
winMgr:getWindow("sjParty_Avarta_TypeWindow"):addChildWindow(winMgr:getWindow("sjParty_Avarta_TypeWindow_SelectText"))
winMgr:getWindow("sjParty_Avarta_BackImage"):addChildWindow(winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"))

--[[
for i=0, #tSelectRadioBtName_avarta do
	winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):addChildWindow(tSelectRadioBtName_avarta[i])
	winMgr:getWindow(tSelectRadioBtName_avarta[i]):addChildWindow(winMgr:getWindow(tSelectRadioBtName_avarta[i].."text"))
end
--]]

function SettingPartyDistribute(itemDistribute, expDistribute)
	winMgr:getWindow("PartyMyInfoDistributeItem"):setText(tStringByPartyItemType[itemDistribute])
	winMgr:getWindow("PartyMyInfoDistributeExp"):setText(tStringByPartyExpType[expDistribute])
end

-- �ƹ�Ÿ �ؿ� �ִ� ��ƼŸ�� ȭ��ǥ Ŭ��
function ClickPartyTypeForSelect_Avarta()
	--[[
	if winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):isVisible() then
		winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):setVisible(false)
	else
		winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):setVisible(true)
	end
	--]]
end


-- �ƹ�Ÿ �ؿ� �ִ� ��ƼŸ�� ����
function OnSelectPartyType_Avarta()
	--[[
	for i=0, #tSelectRadioBtName_avarta do
		if CEGUI.toRadioButton(winMgr:getWindow(tSelectRadioBtName_avarta[i])):isSelected() then
			winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):setVisible(false)
			
			-- ��ƼŸ���� �����Ѵ�.	
			g_selectPartyType = i
			ChangeMyPartyType(i)
			
			winMgr:getWindow("sjParty_Avarta_TypeWindow_SelectText"):setVisible(true)
			winMgr:getWindow("sjParty_Avarta_TypeWindow_SelectText"):setTextExtends(tStringByPartyType[i], g_STRING_FONT_GULIM, 11, 
						tColorOfPartyType[i][1],tColorOfPartyType[i][2],tColorOfPartyType[i][3],255,  0, 255,255,255,255)
			winMgr:getWindow(tSelectRadioBtName_avarta[i]):setProperty("Selected", "false")			
		end
	end
	--]]
end




-- ���� ��Ƽ �ƹ�Ÿ ������Ʈ
function UpdateMyPartyAvarta(max_slot, currentMyPartyType)
	local isJoinedd = IsPartyJoined()
	if isJoinedd then
		winMgr:getWindow('sjparty_CreatePartyBtn'):setVisible(false)
	else
		winMgr:getWindow('sjparty_CreatePartyBtn'):setVisible(true)
	end
	
	
	-- ������Ʈ�� �ʱ�ȭ
	for i=1, max_slot do
		
		-- ����Ƽ �����̸�
		if i == 1 then
			winMgr:getWindow('PartyMyInfo'):setVisible(false)
			winMgr:getWindow('PartyMyInfoGage'):setVisible(false)
			winMgr:getWindow('BigCharAbata'):setVisible(false)			
		else
			local window = 'PartyInfo'..tostring(i-1)
			winMgr:getWindow(window):setVisible(false)
			winMgr:getWindow(window..'SmallCharAbata'):setVisible(false)
		end
	end
	
	-- ��ƼŻ��� �ƹ�Ÿ ��Ƽ���� �ʱ�ȭ
	winMgr:getWindow('sjParty_Avarta_BackImage'):setVisible(false)
	winMgr:getWindow('sjParty_Avarta_TypeWindow_SelectText'):setTextExtends("", g_STRING_FONT_GULIM, 11, 255,255,255,255,   0, 255,255,255,255)
	
	-- ��Ƽ�� �̸��� �����´�.
	local ownerName = GetPartyOwnerName()
	
	local count = 1;
	for i=1, max_slot do
	
		-- ��Ƽ�� ������ �˾ƿ´�.
		local level, name, style, type, promotion, transform, lifeNum, ArcadeTicketCnt, hardArcadeTicketCnt = GetPartyUserInfo(i)
		DebugStr(" Transformed Avata Number : " .. transform);
		
		if transform == 501 then
		 transform = 26
		elseif transform == 502 then
		 transform = 27
		elseif transform == 503 then
		 transform = 28
		elseif transform == 504 then
		 transform = 29
		elseif transform == 505 then
		 transform = 30
		elseif transform == 506 then
		 transform = 31
		elseif transform == 507 then
		 transform = 32
		end


		-- ���� ���ϰ�� ū�ƹ�Ÿ ����
		if name == GetMyName() then
			winMgr:getWindow('PartyMyInfo'):setVisible(true)
			winMgr:getWindow('PartyMyInfoGage'):setVisible(true)
			
			-- ������ ��� �̹��� ����
			if transform <= 0 then
				winMgr:getWindow('BigCharAbata'):setTexture('Enabled', 'UIData/GameImage.tga', 0, type*98)
				winMgr:getWindow('BigCharAbata'):setTexture('Disabled', 'UIData/GameImage.tga', 0, type*98)
			else
				winMgr:getWindow('BigCharAbata'):setTexture('Enabled', "UIData/"..tTransformBigFileName[transform], tTransformBigTexX[transform], tTransformBigTexY[transform])
				winMgr:getWindow('BigCharAbata'):setTexture('Disabled', "UIData/"..tTransformBigFileName[transform], tTransformBigTexX[transform], tTransformBigTexY[transform])
			end
			
			-- ū �ƹ�Ÿ ��������
			local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
			local summaryNameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
			winMgr:getWindow('BigCharAbata'):setVisible(true)
			winMgr:getWindow('PartyMyInfoName'):setPosition(46-summaryNameSize/2, 60)
			winMgr:getWindow('PartyMyInfoName'):setText(summaryName)
			winMgr:getWindow('PartyMyInfoName'):setUserString("characterName", name)
			
	
			-- ������ ǥ��
			if ownerName == name then
				winMgr:getWindow('PartyMyInfoMaster'):setVisible(true)
				--winMgr:getWindow("DefaultWindow"):addChildWindow(winMgr:getWindow("sjParty_Avarta_BackImage"))
				winMgr:getWindow('sjParty_Avarta_BackImage'):setVisible(true)
				
				-- ������ ���� ��Ƽ���� ǥ���ϱ�
				local window = winMgr:getWindow('sjParty_Avarta_TypeWindow_SelectText')
				window:setTextExtends(tStringByPartyType[currentMyPartyType], g_STRING_FONT_GULIM, 11, 
					tColorOfPartyType[currentMyPartyType][1],tColorOfPartyType[currentMyPartyType][2],tColorOfPartyType[currentMyPartyType][3],255,   
					0, 255,255,255,255)	
			else
				winMgr:getWindow('PartyMyInfoMaster'):setVisible(false)
				winMgr:getWindow('sjParty_Avarta_BackImage'):setVisible(false)
				winMgr:getWindow('sjParty_Avarta_TypeWindow_SelectText'):setTextExtends("", g_STRING_FONT_GULIM, 11,    255,205,86,255,     0,     0,0,0,255)
			end
		
		-- �ٸ� ��Ƽ���� ���
		else
			-- �ʹݿ� ��Ƽ�� ������� -1�� �´�.
			if level > 0 then
				local window = 'PartyInfo'..tostring(count)
				winMgr:getWindow(window):setVisible(true)
				winMgr:getWindow(window):setUserString("lifeNum", lifeNum)
				
				if type >= 0 then
					-- ������ ��� �̹��� ����
					if transform <= 0 then
						winMgr:getWindow(window..'SmallCharAbata'):setTexture('Enabled', 'UIData/GameImage.tga', 0, 595+type*49)
						winMgr:getWindow(window..'SmallCharAbata'):setTexture('Disabled', 'UIData/GameImage.tga', 0, 595+type*49)
					else
						winMgr:getWindow(window..'SmallCharAbata'):setTexture('Enabled', "UIData/"..tTransformSmallFileName[transform], tTransformSmallTexX[transform], tTransformSmallTexY[transform])
						winMgr:getWindow(window..'SmallCharAbata'):setTexture('Disabled', "UIData/"..tTransformSmallFileName[transform], tTransformSmallTexX[transform], tTransformSmallTexY[transform])
					end
				end
				
				-- ���� �ƹ�Ÿ ��������
				local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
				winMgr:getWindow(window..'SmallCharAbata'):setVisible(true)
				winMgr:getWindow(window..'Level'):setText('Lv.'..level)
				winMgr:getWindow(window..'Name'):setText(summaryName)
				winMgr:getWindow(window..'Name'):setUserString("characterName", name)
				
				if ArcadeTicketCnt <= 0 then
					winMgr:getWindow(window..'ArcadeTicketImage'):setVisible(false)
				else
					winMgr:getWindow(window..'ArcadeTicketImage'):setVisible(true)
				end
				
				--winMgr:getWindow(window..'ArcadeTicketCount'):setText("x "..ArcadeTicketCnt)
				--winMgr:getWindow(window..'ArcadeTicketCount'):setTextColor(255,255,255,255)

				if hardArcadeTicketCnt <= 0 then
					winMgr:getWindow(window..'ArcadeHardTicketImage'):setVisible(false)
				else
					winMgr:getWindow(window..'ArcadeHardTicketImage'):setVisible(true)
				end

				--if winMgr:getWindow(window..'ArcadeHardTicketCount') ~= nil then 
				--	winMgr:getWindow(window..'ArcadeHardTicketCount'):setText("x "..hardArcadeTicketCnt)
				--	winMgr:getWindow(window..'ArcadeHardTicketCount'):setTextColor(255,0,255,255)	
				--end	

				count = count + 1
				
				-- ������ ǥ��
				if ownerName == name then
					winMgr:getWindow(window..'Master'):setVisible(true)
				else
					winMgr:getWindow(window..'Master'):setVisible(false)
				end
			end
		end
	end
end





g_IsAbataRButtonUp = false

-- ���� ��Ƽ �ƹ�Ÿ �̹��� ������ ���콺 Ŭ��
function OnAvatarRButtonUp(args)

	g_IsAbataRButtonUp = true
	local windowName = CEGUI.toWindowEventArgs(args).window:getName()
	local m_pos = mouseCursor:getPosition()
	ShowPopupWindow(m_pos.x, m_pos.y, 1)
	
	-- ���� ���� �������� �ƴ��� Ȯ���Ѵ�.
	local isOwner = IsPartyOwner()
	winMgr:getWindow('pu_showInfo'):setEnabled(true)
	winMgr:getWindow('pu_partySecession'):setEnabled(true)
	
	-- ���� �� ģ���� ��� �Ǿ� �ִ��� Ȯ���ϱ�
	winMgr:getWindow('pu_addFriend'):setEnabled(false)
	winMgr:getWindow('pu_vanishParty'):setEnabled(true)
	winMgr:getWindow('pu_chatToUser'):setEnabled(false)
	
	-- ���� ���� �����̸� �߹���� �Ҽ� �ְ� �Ѵ�
	if isOwner == true then
	
		-- Ŭ���� �ƹ�Ÿ�� �� �ƹ�Ÿ�̸�
		if windowName == 'PartyMyInfo' then 
			g_strSelectRButtonUp = winMgr:getWindow(windowName..'Name'):getUserString("characterName")
			MakeMessengerPopup("pu_showInfo", "pu_partySecession")
		else
			g_strSelectRButtonUp = winMgr:getWindow(windowName..'Name'):getUserString("characterName")
			MakeMessengerPopup("pu_showInfo", "pu_partyCommission", "pu_vanishParty", "pu_addFriend", "pu_chatToUser")
		end
	else
	
		-- Ŭ���� �ƹ�Ÿ�� �� �ƹ�Ÿ�̸�
		if windowName == 'PartyMyInfo' then
			g_strSelectRButtonUp = winMgr:getWindow(windowName..'Name'):getUserString("characterName")
			MakeMessengerPopup("pu_showInfo", "pu_partySecession")
		else
			g_strSelectRButtonUp = winMgr:getWindow(windowName..'Name'):getUserString("characterName")
			MakeMessengerPopup("pu_showInfo", "pu_addFriend")
		end
	end
	winMgr:getWindow('pu_partySecession'):setEnabled(true)
end


-- �ƹ�Ÿ �̹��� ���콺 �̺�Ʈ
winMgr:getWindow('PartyMyInfo'):setSubscribeEvent("MouseRButtonUp", "OnAvatarRButtonUp")
winMgr:getWindow('PartyInfo1'):setSubscribeEvent("MouseRButtonUp", "OnAvatarRButtonUp")
winMgr:getWindow('PartyInfo2'):setSubscribeEvent("MouseRButtonUp", "OnAvatarRButtonUp")
winMgr:getWindow('PartyInfo3'):setSubscribeEvent("MouseRButtonUp", "OnAvatarRButtonUp")





--------------------------------------------------------------

-- ���� ĳ���� ���콺 ������ Ŭ�� �̺�Ʈ

--------------------------------------------------------------

-- ���� ĳ���� ���콺 ������ Ŭ�� ��Ƽ�ʴ�
function OnClickPartyInvite(clickUserName)
	RequestPartyInvite(clickUserName)
end

-- �� ĳ���� ���콺 ������ Ŭ�� ��ƼŻƼ
function OnClickPartyUnJoin()
	PartyUnJoin()
	winMgr:getWindow('sjParty_Avarta_BackImage'):setVisible(false)
	winMgr:getWindow('sjParty_Avarta_TypeWindow_SelectText'):setTextExtends("", g_STRING_FONT_GULIM, 14,    255,205,86,255,     0,     0,0,0,255)
		
	-- ��ƼŻ��� ������ ���� ��Ƽ�Ͽ� �°� ����
	local my1stTicket = Get1stHaveATicket()
	Set1stHaveATicket(my1stTicket)
end

-- ���� ĳ���� ���콺 ������ Ŭ�� ��Ƽ�߹�
function OnClickPartyVanish(clickUserName)
	PartyUnJoinByOwner(clickUserName)
		
	-- ��Ƽ�߹��� ������ ���� ��Ƽ�Ͽ� �°� ����
	local my1stTicket = Get1stHaveATicket()
	Set1stHaveATicket(my1stTicket)
end

-- ��Ƽĳ���� ��Ƽ�� ����
function OnClickPartyCommission(clickUserName)
	ChangeMyPartyOwner(clickUserName)
end






--------------------------------------------------------------

-- ��Ƽ ���� �޼��� â

--------------------------------------------------------------
-- ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_party_AlphaImg")
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

--- OK �˸�â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_party_OkBox")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
root:addChildWindow(mywindow)

-- �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_party_OkBox_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setPosition(100, 100)
mywindow:setSize(340, 180)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(3, 45)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(1)
winMgr:getWindow("sj_party_OkBox"):addChildWindow(mywindow)

-- �˸�â Ȯ�ι�ư(OK)
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_party_OkBtn_Only")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setSize(331, 29)
mywindow:setPosition(4, 235)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClosePartyOKCancelBox")
winMgr:getWindow("sj_party_OkBox"):addChildWindow(mywindow)


---------------------------------------------
--- OK, CANCEL �˸�â
---------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_party_OkCancelBox")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_party_OkCancelBox_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setSize(340, 180)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(3, 45)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(1)
winMgr:getWindow("sj_party_OkCancelBox"):addChildWindow(mywindow)

-- OK, CANCEL ��ư
tAlertName = {['protecterr'] = 0, "sj_party_OkBtn", "sj_party_CancelBtn"}
tAlertTexX = {['protecterr'] = 0, 693, 858}
tAlertPosX = {['protecterr'] = 0, 4, 169}
tAlertPosY = {['protecterr'] = 0, 235, 235}
for i=1, #tAlertName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAlertName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tAlertTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tAlertTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setSize(166, 29)
	mywindow:setPosition(tAlertPosX[i], tAlertPosY[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_party_OkCancelBox"):addChildWindow(mywindow)
end

-- ��Ƽ���� ��û�ϴ� ���� Ŭ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_party_RequestUser_classImage")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setSize(89, 35)
mywindow:setPosition(80, 70)
mywindow:setLayered(true)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_party_OkCancelBox"):addChildWindow(mywindow)

-- ��Ƽ���� ��û�ϴ� ���� ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_party_RequestUser_lifeImage")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setTexture("Enabled", "UIData/quest.tga", 77, 898)
mywindow:setTexture("Disabled", "UIData/quest.tga", 77, 898)
mywindow:setSize(62, 38)
mywindow:setPosition(180, 66)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_party_OkCancelBox"):addChildWindow(mywindow)

-- ��Ƽ���� ��û�ϴ� ���� ������ ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_party_RequestUser_lifeNumText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setPosition(244, 82)
mywindow:setSize(50, 20)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_party_OkCancelBox"):addChildWindow(mywindow)


-- ESC, ENTER
RegistEnterEventInfo("sj_party_AlphaImg", "ClosePartyOKCancelBox")
RegistEscEventInfo("sj_party_AlphaImg", "ClosePartyOKCancelBox")
RegistEnterEventInfo("sj_party_AlphaImg", "OnClickPartyInvitedQuestOk")
RegistEscEventInfo("sj_party_AlphaImg", "OnClickPartyInvitedQuestCancel")
RegistEnterEventInfo("sj_party_AlphaImg", "OnClickPartyTriedQuestOk")
RegistEscEventInfo("sj_party_AlphaImg", "OnClickPartyTriedQuestCancel")


-----------------------------------
-- OK�� �������
-----------------------------------
function ClosePartyOKCancelBox()
	local okFunc = winMgr:getWindow("sj_party_OkBox"):getUserString("okFunction")
	if okFunc ~= "ClosePartyOKCancelBox" then
		return
	end
	winMgr:getWindow("sj_party_OkBox"):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow("sj_party_AlphaImg"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
	local local_window = winMgr:getWindow("sj_party_OkBox")
	winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(local_window)
	local_window:setVisible(false)
end




-----------------------------------
-- OK ��ư 1���ִ� �Լ�
-----------------------------------
function ShowPartyOkBoxFunction(arg, argFunc)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa = winMgr:getWindow("sj_party_AlphaImg"):getChildCount()
		if aa >= 1 then
			local bb = winMgr:getWindow("sj_party_AlphaImg"):getChildAtIdx(0)
			winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(bb)
		end
		
		winMgr:getWindow("sj_party_AlphaImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
		local local_window = winMgr:getWindow("sj_party_OkBox")
		local_window:setUserString("okFunction", argFunc)
		winMgr:getWindow("sj_party_AlphaImg"):addChildWindow(local_window)
		local_window:setVisible(true)
			
		local local_txt_window = winMgr:getWindow("sj_party_OkBox_Text")
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_party_OkBtn_Only"):setSubscribeEvent("Clicked", argFunc)
	end
end

function ShowPartyOkBoxFunction2(specialArg, arg, argFunc)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa = winMgr:getWindow("sj_party_AlphaImg"):getChildCount()
		if aa >= 1 then
			local bb = winMgr:getWindow("sj_party_AlphaImg"):getChildAtIdx(0)
			winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(bb)
		end
		
		winMgr:getWindow("sj_party_AlphaImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
		local local_window = winMgr:getWindow("sj_party_OkBox")
		local_window:setUserString("okFunction", argFunc)
		winMgr:getWindow("sj_party_AlphaImg"):addChildWindow(local_window)
		local_window:setVisible(true)
			
		local local_txt_window = winMgr:getWindow("sj_party_OkBox_Text")
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg, g_STRING_FONT_GULIMCHE, 15, 255,205,86,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_party_OkBtn_Only"):setSubscribeEvent("Clicked", argFunc)
	end
end

function ShowPartyOkBoxFunction3(specialArg, arg, argFunc, r, g, b)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa = winMgr:getWindow('sj_party_AlphaImg'):getChildCount()
		if aa >= 1 then
			local bb = winMgr:getWindow('sj_party_AlphaImg'):getChildAtIdx(0)  
			winMgr:getWindow('sj_party_AlphaImg'):removeChildWindow(bb)		
		end
		winMgr:getWindow('sj_party_AlphaImg'):setVisible(true)
		root:addChildWindow(winMgr:getWindow('sj_party_AlphaImg'))
		local local_window = winMgr:getWindow('sj_party_OkBox')
		local_window:setUserString("okFunction", argFunc)
		winMgr:getWindow('sj_party_AlphaImg'):addChildWindow(local_window)
		local_window:setVisible(true)
			
		local local_txt_window = winMgr:getWindow('sj_party_OkBox_Text')
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg, g_STRING_FONT_GULIMCHE, 15, r,g,b,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow('sj_party_OkBtn_Only'):setSubscribeEvent("Clicked", argFunc)
	end
end


-----------------------------------
-- OK, CANCE ��ư 2���ִ� �Լ�
-----------------------------------
function ShowPartyOkCancelBoxFunction2(specialArg, arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa= winMgr:getWindow("sj_party_AlphaImg"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_party_AlphaImg"):getChildAtIdx(0)  
			winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_party_AlphaImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
		local local_window = winMgr:getWindow("sj_party_OkCancelBox")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_party_AlphaImg"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_party_OkCancelBox_Text")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg, g_STRING_FONT_GULIMCHE, 15, 255,205,86,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_party_OkBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_party_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
		
		winMgr:getWindow("sj_party_RequestUser_classImage"):setVisible(false)
		winMgr:getWindow("sj_party_RequestUser_lifeImage"):setVisible(false)
		winMgr:getWindow("sj_party_RequestUser_lifeNumText"):setVisible(false)
	end
end

function ShowPartyOkCancelBoxFunction_Ex(specialArg1, specialArg2, arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa = winMgr:getWindow("sj_party_AlphaImg"):getChildCount()
		if aa >= 1 then
			local bb = winMgr:getWindow("sj_party_AlphaImg"):getChildAtIdx(0)  
			winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_party_AlphaImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
		local local_window = winMgr:getWindow("sj_party_OkCancelBox")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_party_AlphaImg"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_party_OkCancelBox_Text")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg1, g_STRING_FONT_GULIMCHE, 15, 97,230,255,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(specialArg2, g_STRING_FONT_GULIMCHE, 15, 255,205,86,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_party_OkBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_party_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
		
		winMgr:getWindow("sj_party_RequestUser_classImage"):setVisible(false)
		winMgr:getWindow("sj_party_RequestUser_lifeImage"):setVisible(false)
		winMgr:getWindow("sj_party_RequestUser_lifeNumText"):setVisible(false)
	end
end


function ShowPartyOkCancelBoxFunctionWithImage(arg, style, promotion, attribute, lifeNum, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_party_AlphaImg') then
		local aa = winMgr:getWindow("sj_party_AlphaImg"):getChildCount()
		if aa >= 1 then
			local bb = winMgr:getWindow("sj_party_AlphaImg"):getChildAtIdx(0)
			winMgr:getWindow("sj_party_AlphaImg"):removeChildWindow(bb)
		end
		winMgr:getWindow("sj_party_AlphaImg"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_party_AlphaImg"))
		local local_window = winMgr:getWindow("sj_party_OkCancelBox")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_party_AlphaImg"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_party_OkCancelBox_Text")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_party_OkBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_party_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
			
		-- ��Ÿ��, ������ �����ֱ�
		winMgr:getWindow("sj_party_RequestUser_classImage"):setVisible(true)
		winMgr:getWindow("sj_party_RequestUser_lifeImage"):setVisible(true)
		winMgr:getWindow("sj_party_RequestUser_lifeNumText"):setVisible(true)

		winMgr:getWindow("sj_party_RequestUser_classImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
		winMgr:getWindow("sj_party_RequestUser_classImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])

		local lifeText = CommatoMoneyStr(lifeNum)
		winMgr:getWindow("sj_party_RequestUser_lifeNumText"):setText(lifeText)

	end
end
