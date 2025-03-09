--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local MAX_ESCROW_INFO = 10
local SIZE_ESCROW_WIDTH = 1006

-- �ؽ�Ʈ ���� ���� ����
local ALIGN_LEFT	= 1
local ALIGN_RIGHT	= 2
local ALIGN_CENTER	= 3

-- �ǸŹ�ǰ ����
local TYPE_PRODUCT_ZEN	= 1
local TYPE_PRODUCT_ITEM = 2
local TYPE_PRODUCT_ETC	= 3

-- ���� ����
local ESCROW_STATE_AVAIL		= 0 -- �ŷ�����
local ESCROW_STATE_PROGRESS		= 1 -- �ŷ���
local ESCROW_STATE_COMPLETE		= 2 -- �ŷ��Ϸ�
local ESCROW_STATE_SELLING		= 3 -- �Ǹ���
local ESCROW_STATE_BUYING		= 4 -- ���Ž�û��
local ESCROW_STATE_WATING		= 5 -- �ǸŽ��δ��
local ESCROW_STATE_COMPLETE_SELL= 6 -- �ǸſϷ�
local ESCROW_STATE_COMPLETE_BUY	= 7 -- ���ſϷ�

-- State Image�� ��ġ�� ���� ESCROW_STATE_ �ε����� �ٸ��� ������ �����ִ� �ε��� �迭
local ESCROW_STATE_UIPOS = {['err']=0, [0]=0, 2, 1, 3, 5, 4, 7, 6}

-- ������ ����
local ESCROW_PAGE_SELL			= 0 -- �Ǹ� �Խ���
local ESCROW_PAGE_MY_ALL		= 1 -- ��ü �ŷ�����
local ESCROW_PAGE_MY_SELL		= 2 -- �Ǹ����� ����
local ESCROW_PAGE_MY_BUY		= 3 -- �������� ����
local ESCROW_PAGE_MY_COMPLETE	= 4 -- �ŷ��Ϸ� ����


local POS_INFO_TEXT_Y	= 13	-- StaticText ��Ʈ�� ��������� Y������
local SIZE_INFO_TEXT_Y	= 11	-- StaticText ��Ʈ�� ��������� Y������
local SIZE_INFO_FONT	= 11	-- info text�� font size

local SPEED_EFFECT = 25			-- ���콺���� �̺�Ʈ ����Ʈ�� �ӵ�

local SPEED_INFOANI = 15		-- ������â �ִϸ��̼��� �ӵ�

-- ������â �ִϸ��̼� ����
local STATE_INFOANI_STOP = 0
local STATE_INFOANI_SHOW = 1
local STATE_INFOANI_HIDE = 2

-- �ŷ����� �� �̸�
local TITLE_HISTORY = {['err'] = 0, [0] = "",	"EscrowInfoBoard_Title_History_All", "EscrowInfoBoard_Title_History_Sell",
												"EscrowInfoBoard_Title_History_Buy", "EscrowInfoBoard_Title_History_Complete"}

local MAX_REGISTER_DESCRIBE = 5 -- �Ǹŵ�� �󼼳����� Editbox ����

local g_CurPageType = ESCROW_PAGE_SELL -- ���� ������, ESCROW_PAGE �� ���� ���´�
local g_CurPage = 2 -- ���� ���õǾ� �ִ� ������ 1���� 5�� ���ڵ� ������
local g_PageNumbers = {['err']=0, [0] = 0, 1, 2, 3, 4, 5} -- ���� �������� ������ ���ڵ�
local g_MaxPage = 1

-- Info�� �ִϸ��̼��� ����
local g_InfoAni = {['err']=0, [0] = 0}
local g_InfoDetailAniPos = {['err']=0, [0] = 0}
local g_InfoAniPos = {['err']=0, [0] = 0}

for i = 1, MAX_ESCROW_INFO do
	g_InfoAni[i] = STATE_INFOANI_STOP
	g_InfoDetailAniPos[i] = 0
	g_InfoAniPos[i] = 0 
end

local g_InfoState = {['err']=0, [0] = 0} -- �Խù����� ���¸� ����

local g_CommentAniState = STATE_INFOANI_STOP	-- ���� �ִ� ����
local g_CommentAniPos = 0	-- ���� �ִ� ��ġ
local g_BottomAniPos = 0	-- ���� �ִ� �Ʒ��� ��ġ

local g_SelectedInfo = 0 -- ���� ���õ� �Խù�, ������ 1, ���õǾ� ���� �ʴٸ� 0

local g_RegisterDescribeIndex = 1 -- �Ǹŵ��â �󼼳��� ��������

local g_SelectedComment	-- ������ ����










--[[

public: -- windows

	EscrowAlphaImage	-- ����ũ��â �����̹���
	EscrowBackground	-- ��ü ����ũ��â
	{
	--	Escrow_Titlebar					-- Ÿ��Ʋ��(������, ����������)
		Escrow_CloseBtn					-- �ݱ��ư
		Escrow_TitleTextImage_Deal		-- Ÿ��Ʋ �ؽ�Ʈ �̹���(�ŷ� �Խ���)
		Escrow_TitleTextImage_History	-- Ÿ��Ʋ �ؽ�Ʈ �̹���(���� �ŷ�����)
		
		EscrowInfoBoard
		{
			EscrowInfoBoard_Title_Sell				-- �Ǹ� �Խ���
			EscrowInfoBoard_Title_History_All		-- ��ü �ŷ�����
			EscrowInfoBoard_Title_History_Sell		-- �Ǹ����� ����
			EscrowInfoBoard_Title_History_Buy		-- �������� ����
			EscrowInfoBoard_Title_History_Complete	-- �ŷ��Ϸ� ����
			EscrowInfoBoard_Label
			
			EscrowInfo_1 ~ MAX		-- ����â
				EscrowInfo_BackImage_1 ~ MAX		-- ����â �⺻ ��� �̹���
				EscrowInfo_Number_1 ~ MAX			-- ��ȣ
				EscrowInfo_Seller_1 ~ MAX			-- �Ǹ���
				EscrowInfo_ProductImage_1 ~ MAX		-- �ǸŹ�ǰ �̹���
				EscrowInfo_Title_1 ~ MAX			-- ����
				EscrowInfo_Quantity_1 ~ MAX			-- ����
				EscrowInfo_Price_1 ~ MAX			-- �ǸŰ���
				EscrowInfo_PriceImage_1 ~ MAX		-- �ǸŰ��� �̹���
				EscrowInfo_State_1 ~ MAX			-- ����
				EscrowInfo_Date_1 ~ MAX				-- �����
			
			EscrowInfo_EffectImage1	-- ���콺 ���� ����Ʈ
			EscrowInfo_EffectImage2	-- ���콺 Ŭ��(����) ����Ʈ
			
			EscrowInfoDetail_BackImage			-- ������ ����̹���
			EscrowInfoDetail_Back				-- ������ ��ü
				EscrowInfoDetail_Seller			-- �Ǹ��� ĳ���͸�
				EscrowInfoDetail_GradeImage		-- ��� �̹���
				EscrowInfoDetail_Contact		-- ����ó
				EscrowInfoDetail_Describe		-- �󼼳���
				EscrowInfoDetail_Price			-- �ǸŰ���
				EscrowInfoDetail_PriceImage		-- �ǸŰ��� �̹���
				EscrowInfoDetail_ProductImage	-- �ǸŹ�ǰ �̹���
				EscrowInfoDetail_Quantity		-- �Ǹż���
				EscrowInfoDetail_Buyer			-- ĳ���͸�
				EscrowInfoDetail_Button_Delete	-- ���� ��ư
				EscrowInfoDetail_Button_Modify	-- ������� ��ư
				EscrowInfoDetail_Button_Cancel	-- �Ǹ���� ��ư
				EscrowInfoDetail_Button_Sell	-- �ǸſϷ� ��ư
				EscrowInfoDetail_Button_Buy		-- ���Ž�û ��ư
					
			EscrowComment_BackImage			-- ���� ��� �̹���
			EscrowComment_Back				-- ���� ����
				EscrowComment_EditImage		-- ���� �Է� ����Ʈ �̹���
				EscrowComment_Edit			-- ���� �Է� ����Ʈ
				EscrowComment_Button_Input	-- ���� �Է� ��ư
				EscrowComment_Contents_1~10	-- ����
					EscrowComment_Name_1~10	-- �̸�
					EscrowComment_Arrow_1~10		-- ȭ��ǥ
					EscrowComment_Comment_1~10		-- ����
					EscrowComment_Time_1~10			-- ��� ��¥/�ð�
					EscrowComment_DeleteButton_1~10	-- ������ư
				EscrowComment_Button_Close	-- �ݱ� ��ư
				
			

			-- ��ũ�ѹ�
			EscrowScrollbar_body
			EscrowScrollbar_decbtn
			EscrowScrollbar_incbtn
			EscrowScrollbar_thumb
			
			-- Zone4 ���
			EscrowDeco_Zone4
			
			-- �̵� ��ư
			EscrowButton_Prev5
			EscrowButton_Prev
			EscrowButton_Next
			EscrowButton_Next5
			
			-- ������ ����
			EscrowButton_PageNumber_1 ~ 5
				EscrowButton_PageNumber_Text_1 ~ 5
			
			EscrowButton_Register	-- �Ǹŵ�� ��ư
			EscrowButton_History	-- �ŷ����� ��ư
			EscrowButton_SellBoard	-- �ŷ��Խ��� ��ư
			
		} -- end of EscrowInfoBoard
	} -- end of EscrowBackground


	RegisterAlphaImage	-- �Ǹ� ��� ����â(�Ⱥ���)
	RegisterBackground	-- �Ǹ� ��� â
	{
		Register_Titlebar		-- Ÿ��Ʋ��
		Register_TitleTextImage_Sell	-- �Ǹ� ���
		Register_TitleTextImage_Modify	-- �Ǹ� ��� ����
		Register_CloseBtn		-- �ݱ� ��ư
		Register_ProductImage	-- ��ǰ���� �̹���
		Register_SellImage		-- �Ǹż���, �Ǹűݾ� �̹���
		Register_QuantityImage	-- �Ǹż��� �̹���
		Register_QuantityBack	-- �Ǹż��� ����
		Register_Quantity		-- �Ǹż���
		Register_PriceImage		-- �Ǹűݾ� �̹���
		Register_PriceBack		-- �Ǹűݾ� ����
		Register_Price			-- �Ǹűݾ�
		Register_CashImage		-- �Ǹűݾ� ���� �̹���
		Register_DescribeImage	-- �������� �̹���
		Register_Title			-- ����
		Register_Describe_1~5	-- �󼼳���
		Register_Contact		-- ����ó
		Register_Complete		-- �Է¿Ϸ� ��ư
		Register_Modify			-- �����Ϸ� ��ư
		Register_Cancel			-- ��� ��ư
	}

	-- ���۾˸� ����Ʈ
	EscrowComment_1~10_EffectImage
	EscrowButton_EffectImage
	EscrowHistory_EffectImage

public: -- functions

	-- �ܺο����� * ǥ�ð� ���� �Լ��鸸�� ����Ұ��� �����մϴ�

	function Escrow_Show()			-- ����ũ��â�� ����
	function Escrow_Close()			-- ����ũ��â�� �ݴ´�
*	function Escrow_SetVisible( b )	-- ����ũ��â�� visible�� �����Ѵ�
	function Escrow_SetText( window, text, align, standard, posY, fontSize ) -- infoâ text�� pos, size�� �ѹ��� �����Ѵ�
*	function Escrow_SetInfo( index, number, seller, product, title, quantity, price, state, date ) -- ���� �������� ������� info controll�� ������ �����Ѵ�
	function Escrow_ClearInfoAll()	-- Infoâ ��ü�� DetailInfo, �ִϸ��̼� ������ �ʱ�ȭ �Ѵ�
	
	function RefreshInfo()	-- ���� ������ ����

	-- ���� �ΰ� �Լ��� ���� �μ����޿� ���Ǹ� ��￩�� �Ѵ�
	-- SetPageNumbers�� ���� ���̴� ������ ���ڸ� �����Ͽ��� �ϸ�
	-- SetPage�� ���������� ���° ��ư������ �����Ͽ��� �Ѵ�
	function Escrow_SetPageNumbers( firstPage ) -- ������ ���ڸ� �����Ѵ�
	function Escrow_SetPage( page )				-- �������� �����Ѵ�. �μ� page�� 0~6�� ���� ������
	
	function Escrow_SetMoveButtons( start, page ) -- �̵���ư���� ��ġ, Enable�� �����Ѵ�
*	function Escrow_SetMaxPage( max )			-- �ִ� �������� �����Ѵ�
	function _setPageNumCnt( ... )				-- Escrow_SetPageNumCnt�Լ��� ���� �����Լ�
	function Escrow_SetPageNumCnt( cnt )		-- �������� ��ư ������ �����Ѵ�
	function _extractNumbers( text )			-- text���� ���ڸ� ������ ��ȯ�Ѵ�
*	function Escrow_Render()					-- �����Լ�, ������â�� �ִϸ��̼�
	function Escrow_SetInfoDetail( index )		-- ������â�� ������ ä���
	
	function Escrow_SetHistory( type )			-- ���� â�� �����Ѵ�

	function Escrow_ShowEffect( index, effect, visible, start ) -- Info effect�� �����Ų��
	
	function Escrow_ClearComments()				-- ���� ����
	function Escrow_SetComment( index, name, comment, time )	-- ����
	
	function doNothing() -- Detail �̺�Ʈ ����
	
	function Register_Close()					-- �Ǹŵ�� â�� �ݴ´�
	function Register_SetVisible( b )			-- �Ǹŵ��â�� visible�� �����Ѵ�
	function Register_GetDescribeText()			-- �󼼳����� Text�� �����Ͽ� ��ȯ�Ѵ�
	
	-- ����â �̺�Ʈ
	function OnMouseEnter_Info( args )
	function OnMouseLeave_Info( args )
	function OnMouseLButtonUp_Info( args )

	-- �̵� ��ư �̺�Ʈ
	function OnClicked_Prev5( args )
	function OnClicked_Prev( args )
	function OnClicked_Next( args )
	function OnClicked_Next5( args )
	
	-- ������ ���� �̺�Ʈ
	function OnMouseEnter_PageNumber( args )
	function OnMouseLeave_PageNumber( args )
	function OnClicked_PageNumber( args )
	
	function OnClicked_Register( args )			-- �Ǹŵ�� ��ư
	function OnClicked_History( args )			-- �ŷ����� ��ư
	function OnClicked_SellBoard( args )		-- �ŷ��Խ��� ��ư
	
	
	
	function OnYes_InfoDetail_Delete()			-- ���� Ȯ�� �˾�â Yes Ŭ��
	function OnNo_InfoDetail_Delete()			-- ���� Ȯ�� �˾�â No Ŭ��
	function OnClicked_InfoDetail_Delete( args )-- ���������� ���� ��ư
	
	function OnClicked_InfoDetail_Modify( args )-- ���������� ������� ��ư
	
	function OnYes_InfoDetail_Cancel()			-- �Ǹ���� Ȯ�� �˾�â Yes Ŭ��
	function OnNo_InfoDetail_Cancel()			-- �Ǹ���� Ȯ�� �˾�â No Ŭ��
	function OnClicked_InfoDetail_Cancel( args )-- ���������� �Ǹ���� ��ư
	
	function OnYes_InfoDetail_Sell()			-- �ǸſϷ� Ȯ�� �˾�â Yes Ŭ��
	function OnNo_InfoDetail_Sell()				-- �ǸſϷ� Ȯ�� �˾�â No Ŭ��
	function OnClicked_InfoDetail_Sell( args )	-- ���������� �ǸſϷ� ��ư
	
	function OnClicked_InfoDetail_Buy( args )	-- ���������� ���Ž�û ��ư
	
	function OnRootKeyUp_Comment( args )		-- ���� �ޱ�(����)
	function OnClicked_Comment( args )			-- ���� �ޱ�
	function OnClicked_Comment_Delete( args )	-- ���� ����
	function OnClicked_Comment_Close( args )	-- ���� �ݱ�
	
	
	
	function OnClicked_HistoryTitle( args )		-- �ŷ����� Ÿ��Ʋ ���� ��ư
	
	function OnEditBoxFull(args)				-- EditBox�� ��á������ �̺�Ʈ
	
	function OnClicked_RegisterQuantityBack(args)	-- �Ǹż��� ���� �̺�Ʈ
	function OnClicked_RegisterPriceBack(args)	-- �ǸŰ��� ���� �̺�Ʈ
	
	function OnPressTab_Register(args)			-- �Ǹŵ�� â�� EditBox�鿡�� Tab�� ������ ���� �̺�Ʈ
	
	-- �Ǹŵ�� â�� �󼼳��� �̺�Ʈ
	function OnActivated_RegisterDescribe(args)
	function OnEditboxFull_RegisterDescribe(args)
	function OnTextAccepted_RegisterDescribe(args)
	function OnTextAcceptedBack_RegisterDescribe(args)
	
	function OnYes_Register_Complete()			-- �Ǹŵ�� â �Է¿Ϸ� �˾�â Yes Ŭ��
	function OnNo_Register_Complete()			-- �Ǹŵ�� â �Է¿Ϸ� �˾�â No Ŭ��
	function OnClicked_Register_Complete(args)	-- �Ǹŵ�� â �Է¿Ϸ� ��ư
	function OnClicked_Register_Modify(args)	-- �Ǹŵ�� â �����Ϸ� ��ư
	
	function OnTextChanged_Register(args) -- �Ǹŵ�� â �Ǹż���, ���� ����

]]--











-- ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- �⺻ ���� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(9, 47)
mywindow:setSize(SIZE_ESCROW_WIDTH, 674)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


-- �����̹��� ESCŰ ���
RegistEscEventInfo("EscrowBackground", "Escrow_Close")


-- Ÿ��Ʋ��
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Escrow_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_ESCROW_WIDTH-35, 45)
--winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)


-- Ÿ��Ʋ �ؽ�Ʈ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Escrow_TitleTextImage_Deal")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 0)
mywindow:setPosition(424, 6)
mywindow:setSize(178, 20)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Escrow_TitleTextImage_History")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 185, 0)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 185, 0)
mywindow:setPosition(424, 6)
mywindow:setSize(178, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)


-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Escrow_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(973, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "Escrow_Close")
winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)


-- ��������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoBoard")
mywindow:setTexture("Enabled", "UIData/frame/frame_003.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_003.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setPosition(15, 44)
mywindow:setSize(976, 618)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)

-- �������� Ÿ��Ʋ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoBoard_Title_Sell")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 88)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 88)
mywindow:setPosition(5, 2)
mywindow:setSize(182, 34)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


for i = 1, #TITLE_HISTORY do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", TITLE_HISTORY[i])
	mywindow:setTexture("Normal",			"UIData/deal5.tga", 182*i, 20)
	mywindow:setTexture("Hover",			"UIData/deal5.tga", 182*i, 54)
	mywindow:setTexture("Pushed",			"UIData/deal5.tga", 182*i, 54)
	mywindow:setTexture("PushedOff",		"UIData/deal5.tga", 182*i, 54)
	mywindow:setTexture("SelectedNormal",	"UIData/deal5.tga", 182*i, 88)
	mywindow:setTexture("SelectedHover",	"UIData/deal5.tga", 182*i, 88)
	mywindow:setTexture("SelectedPushed",	"UIData/deal5.tga", 182*i, 88)
	mywindow:setTexture("SelectedPushedOff","UIData/deal5.tga", 182*i, 88)
	mywindow:setSize(182, 34)
	mywindow:setProperty("GroupID", 3123)
	mywindow:setPosition(5 + ((i-1)*186), 2)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnClicked_HistoryTitle")
	winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)
end


-- ��� ���̺�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoBoard_Label")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 156)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 156)
mywindow:setPosition(14, 49)
mywindow:setSize(928, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


-- ��� �Խù� ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(14, 79)
mywindow:setSize(928, 470)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


--------------------------------------------------------------------

-- ����

--------------------------------------------------------------------
for i = 1, MAX_ESCROW_INFO do

	g_InfoAniPos[i] = (i-1)*34

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_" .. i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, g_InfoAniPos[i])
	mywindow:setSize(928, 33)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_Info")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_Info")
	mywindow:subscribeEvent("MouseLButtonUp", "OnMouseLButtonUp_Info")
	winMgr:getWindow("EscrowInfoBackground"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_BackImage_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/black.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/black.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(928, 33)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)
	mywindow:moveToBack()
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Number_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(0, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Seller_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(100, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_ProductImage_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/deal5.tga", 996, 0)
	mywindow:setTexture("Disabled", "UIData/deal5.tga", 996, 0)
	mywindow:setPosition(219, 2)
	mywindow:setSize(28, 28)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Title_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(300, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Quantity_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(400, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Price_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(500, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_PriceImage_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/deal5.tga", 976, 0)
	mywindow:setTexture("Disabled", "UIData/deal5.tga", 976, 21)
	mywindow:setPosition(766, 6)
	mywindow:setSize(20, 21)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_State_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 784)
	mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 784)
	mywindow:setPosition(788, 0)
	mywindow:setSize(77, 33)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfo_Date_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(700, POS_INFO_TEXT_Y)
	mywindow:setSize(100, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)
end



-- ���콺 ���� ����Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_EffectImage1")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/deal5.tga", 0, 182)
mywindow:setTexture('Disabled', "UIData/deal5.tga", 0, 182)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(0, 0);
mywindow:setSize(928, 33);
mywindow:setZOrderingEnabled(true)



-- ���콺 Ŭ��(����) ����Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_EffectImage2")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/deal5.tga", 0, 215)
mywindow:setTexture('Disabled', "UIData/deal5.tga", 0, 215)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(0, 0);
mywindow:setSize(928, 33);
mywindow:setZOrderingEnabled(true)



-------------------------------------------------------------------------
-- Detail
-------------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoDetail_BackImage")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 248)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 248)
mywindow:setPosition(0, 33)
mywindow:setSize(928, 0) -- 928, 134
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:setClippedByParent(false)
--winMgr:getWindow("EscrowInfo_" .. i):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoDetail_Back")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(928, 134)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseLButtonUp", "doNothing")
winMgr:getWindow("EscrowInfoDetail_BackImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfoDetail_Seller")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(127, 51)
mywindow:setSize(108, SIZE_INFO_TEXT_Y)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoDetail_GradeImage")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/deal5.tga", 928, 0)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 928, 0)
mywindow:setPosition(114, 66)
mywindow:setSize(28, 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfoDetail_Contact")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(127, 102)
mywindow:setSize(108, SIZE_INFO_TEXT_Y)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/MultiLineEditbox", "EscrowInfoDetail_Describe")
mywindow:setProperty("ReadOnly", "true")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(211, 46)
mywindow:setSize(314, 77)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setLineSpacing(12)
mywindow:clearTextExtends()
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfoDetail_Price")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(661, 51)
mywindow:setSize(108, SIZE_INFO_TEXT_Y)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoDetail_PriceImage")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/deal5.tga", 976, 0)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 976, 0)
mywindow:setPosition(661, 51)
mywindow:setSize(20, 21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoDetail_ProductImage")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/deal5.tga", 996, 0)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 996, 0)
mywindow:setPosition(648, 66)
mywindow:setSize(28, 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfoDetail_Quantity")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(661, 102)
mywindow:setSize(108, SIZE_INFO_TEXT_Y)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowInfoDetail_Buyer")
mywindow:setEnabled(false)
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
mywindow:setPosition(853, 51)
mywindow:setSize(108, SIZE_INFO_TEXT_Y)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowInfoDetail_Button_Delete")
mywindow:setEnabled(true)
mywindow:setTexture("Normal",	"UIData/deal5.tga", 0, 510)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 0, 548)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 0, 586)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 624)
mywindow:setPosition(738, 81)
mywindow:setSize(88, 38)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_InfoDetail_Delete")
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowInfoDetail_Button_Modify")
mywindow:setEnabled(true)
mywindow:setTexture("Normal",	"UIData/deal5.tga", 88, 510)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 88, 548)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 88, 586)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 88, 624)
mywindow:setPosition(828, 81)
mywindow:setSize(88, 38)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_InfoDetail_Modify")
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowInfoDetail_Button_Cancel")
mywindow:setEnabled(true)
mywindow:setTexture("Normal",	"UIData/deal5.tga", 176, 510)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 176, 548)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 176, 586)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 176, 624)
mywindow:setPosition(738, 81)
mywindow:setSize(88, 38)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_InfoDetail_Cancel")
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowInfoDetail_Button_Sell")
mywindow:setEnabled(true)
mywindow:setTexture("Normal",	"UIData/deal5.tga", 264, 510)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 264, 548)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 264, 586)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 264, 624)
mywindow:setPosition(828, 81)
mywindow:setSize(88, 38)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_InfoDetail_Sell")
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowInfoDetail_Button_Buy")
mywindow:setEnabled(true)
mywindow:setTexture("Normal",	"UIData/deal5.tga", 352, 510)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 352, 548)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 352, 586)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 352, 624)
mywindow:setPosition(783, 81)
mywindow:setSize(88, 38)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_InfoDetail_Buy")
winMgr:getWindow("EscrowInfoDetail_Back"):addChildWindow(mywindow)






-- ���� ����̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_BackImage")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/deal6.tga", 0, 33)
mywindow:setTexture("Disabled", "UIData/deal6.tga", 0, 33)
mywindow:setPosition(0, 33) -- 0, 33 + 126
mywindow:setSize(928, 0) -- 928, 316
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setClippedByParent(false)
--winMgr:getWindow("EscrowInfoDetail_Back" .. i):addChildWindow(mywindow)

-- ���� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_Back")
mywindow:setEnabled(true)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(928, 316) -- 928, 316
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setClippedByParent(false)
winMgr:getWindow("EscrowComment_BackImage"):addChildWindow(mywindow)

-- ���� �Է� ����Ʈ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_EditImage")
mywindow:setEnabled(false)
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 817)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 817)
mywindow:setPosition(115, 11)
mywindow:setSize(646, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowComment_Back"):addChildWindow(mywindow)

-- ���� �Է� ����Ʈ
mywindow = winMgr:createWindow("TaharezLook/Editbox", "EscrowComment_Edit")
mywindow:setPosition(123, 15)
mywindow:setSize(630, 17)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setTextColor(255,255,255,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("EscrowComment_Back"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(70)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
--CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "OnClicked_Comment")
CEGUI.toEditbox(mywindow):subscribeEvent("KeyUp", "OnRootKeyUp_Comment")

-- ���� �Է� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowComment_Button_Input")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 582, 382)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 582, 411)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 582, 440)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 582, 469)
mywindow:setPosition(762, 10)
mywindow:setSize(70, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Comment")
winMgr:getWindow("EscrowComment_Back"):addChildWindow(mywindow)


-- contents
for i = 1, 10 do

	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_Contents_" .. i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(27, 43 + ((i-1)*23))
	mywindow:setSize(873, 24)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
--	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_Info")
--	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_Info")
--	mywindow:subscribeEvent("MouseLButtonUp", "OnMouseLButtonUp_Info")
	winMgr:getWindow("EscrowComment_Back"):addChildWindow(mywindow)
	
	-- �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Name_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(13, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- ȭ��ǥ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_Arrow_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTexture("Enabled", "UIData/deal5.tga", 646, 817) -- 646, 828
	mywindow:setTexture("Disabled", "UIData/deal5.tga", 646, 817)
	mywindow:setPosition(110, 6)
	mywindow:setSize(9, 11)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Comment_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(139, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- ��� ��¥/�ð�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Time_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(740, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- ���� ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowComment_DeleteButton_" .. i)
	mywindow:setTexture("Normal",	"UIData/Profile001.tga", 685, 256)
	mywindow:setTexture("Hover",	"UIData/Profile001.tga", 685, 273)
	mywindow:setTexture("Pushed",	"UIData/Profile001.tga", 685, 290)
	mywindow:setTexture("Disabled", "UIData/Profile001.tga", 685, 307)
	mywindow:setPosition(841, 3)
	mywindow:setSize(17, 17)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "OnClicked_Comment_Delete")
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)
end

-- �ݱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowComment_Button_Close")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 486, 382)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 486, 407)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 486, 432)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 486, 457)
mywindow:setPosition(426, 277)
mywindow:setSize(96, 25)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Comment_Close")
winMgr:getWindow("EscrowComment_Back"):addChildWindow(mywindow)














-- ��ũ�ѹ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowScrollbar_body")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 1010, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 1010, 60)
mywindow:setPosition(948, 79)
mywindow:setSize(14, 475)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowScrollbar_decbtn")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 998, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 998, 111)
mywindow:setPosition(1, 458)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("EscrowScrollbar_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowScrollbar_incbtn")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 986, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 986, 111)
mywindow:setPosition(1, 0)
mywindow:setSize(12, 17)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("EscrowScrollbar_body"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowScrollbar_thumb")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 970, 60)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 970, 60)
mywindow:setPosition(-2, 1)
mywindow:setSize(16, 16)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setUserString("index", -1)
mywindow:setMousePassThroughEnabled(true)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setClippedByParent(false)
mywindow:moveToFront()
winMgr:getWindow("EscrowScrollbar_body"):addChildWindow(mywindow)



-- Zone4 ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowDeco_Zone4")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 680, 898)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 680, 898)
mywindow:setPosition(327, 423)
mywindow:setSize(344, 126)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)
mywindow:moveToBack()



-- �̵� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_Prev5")
mywindow:setTexture("Normal",	"UIData/C_Button.tga", 129, 0)
mywindow:setTexture("Hover",	"UIData/C_Button.tga", 129, 25)
mywindow:setTexture("Pushed",	"UIData/C_Button.tga", 129, 50)
mywindow:setTexture("Disabled", "UIData/C_Button.tga", 129, 75)
mywindow:setPosition(365, 564)
mywindow:setSize(22, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Prev5")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_Prev")
mywindow:setTexture("Normal",	"UIData/C_Button.tga", 0, 0)
mywindow:setTexture("Hover",	"UIData/C_Button.tga", 0, 27)
mywindow:setTexture("Pushed",	"UIData/C_Button.tga", 0, 54)
mywindow:setTexture("Disabled", "UIData/C_Button.tga", 0, 81)
mywindow:setPosition(396, 564)
mywindow:setSize(22, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Prev")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_Next")
mywindow:setTexture("Normal",	"UIData/C_Button.tga", 22, 0)
mywindow:setTexture("Hover",	"UIData/C_Button.tga", 22, 27)
mywindow:setTexture("Pushed",	"UIData/C_Button.tga", 22, 54)
mywindow:setTexture("Disabled", "UIData/C_Button.tga", 22, 81)
mywindow:setPosition(577, 564)
mywindow:setSize(22, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Next")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_Next5")
mywindow:setTexture("Normal",	"UIData/C_Button.tga", 151, 0)
mywindow:setTexture("Hover",	"UIData/C_Button.tga", 151, 25)
mywindow:setTexture("Pushed",	"UIData/C_Button.tga", 151, 50)
mywindow:setTexture("Disabled", "UIData/C_Button.tga", 151, 75)
mywindow:setPosition(608, 564)
mywindow:setSize(22, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Next5")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)



-- ������ ����
for i = 1, 5 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "EscrowButton_PageNumber_" .. i)
--	mywindow:setTexture("Normal", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("Hover", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("Pushed", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("PushedOff", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("SelectedNormal", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("SelectedHover", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("SelectedPushed", "UIData/deal5.tga", 0, 0)
--	mywindow:setTexture("SelectedPushedOff", "UIData/deal5.tga", 0, 0)
	mywindow:setSize(20, 13+POS_INFO_TEXT_Y*2)
	mywindow:setProperty("GroupID", 3313)
	mywindow:setPosition(428 + ((i-1)*30), 573-POS_INFO_TEXT_Y)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", tostring(i))
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_PageNumber")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_PageNumber")
	mywindow:subscribeEvent("MouseButtonDown", "OnClicked_PageNumber")
	winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowButton_PageNumber_Text_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(0, 0)
	mywindow:setSize(20, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowButton_PageNumber_" .. i):addChildWindow(mywindow)
end

-- �ӽ÷� ù������ ���� ����
winMgr:getWindow("EscrowButton_PageNumber_Text_1"):setTextColor(255,180,50,255)



-- �Ǹŵ�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_Register")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 0, 382)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 0, 414)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 0, 446)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 478)
mywindow:setPosition(702, 561)
mywindow:setSize(115, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Register")
mywindow:setVisible(false)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


-- �ŷ����� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_History")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 115, 382)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 115, 414)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 115, 446)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 115, 478)
mywindow:setPosition(825, 561)
mywindow:setSize(115, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_History")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)

-- �ŷ��Խ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton_SellBoard")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 230, 382)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 230, 414)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 230, 446)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 230, 478)
mywindow:setPosition(825, 561)
mywindow:setSize(115, 32)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_SellBoard")
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)













-- �Ǹ� ��� ���� �̹���(�Ⱥ���)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RegisterAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

-- �Ǹ� ��� â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RegisterBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6);
mywindow:setPosition(272, 124)
mywindow:setSize(480, 520)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("RegisterAlphaImage"):addChildWindow(mywindow)


-- �����̹��� ESCŰ ���
RegistEscEventInfo("RegisterBackground", "Register_Close")


-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Register_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(445, 45)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)


-- Ÿ��Ʋ �ؽ�Ʈ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_TitleTextImage_Sell")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 831, 382)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 831, 382)
mywindow:setPosition(152, 5)
mywindow:setSize(179, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_TitleTextImage_Modify")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 652, 382)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 652, 382)
mywindow:setPosition(152, 5)
mywindow:setSize(179, 27)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)


-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Register_CloseBtn")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(449, 6)
mywindow:setSize(24, 22)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "Register_Close")
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- ��ǰ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_ProductImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 684, 409)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 684, 409)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(17, 55)
mywindow:setSize(326, 62)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �Ǹż���, �Ǹűݾ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_SellImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 754, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 754, 471)
mywindow:setPosition(35, 121)
mywindow:setSize(98, 63)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �Ǹż��� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_QuantityImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 852, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 852, 500)
mywindow:setPosition(131, 121)
mywindow:setSize(158, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �Ǹż��� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_QuantityBack")
mywindow:setPosition(136, 125)
mywindow:setSize(140, 16)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)
mywindow:subscribeEvent("MouseButtonDown", "OnClicked_RegisterQuantityBack")

-- �Ǹż���
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Register_Quantity")
mywindow:setPosition(130, 0)
mywindow:setSize(130, 16)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("Register_QuantityBack"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(13)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Register")
CEGUI.toEditbox(mywindow):subscribeEvent("CharacterKey", "OnTextChanged_Register")

-- �Ǹűݾ� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_PriceImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 852, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 852, 500)
mywindow:setPosition(131, 155)
mywindow:setSize(158, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �Ǹűݾ� ����
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_PriceBack")
mywindow:setPosition(136, 159)
mywindow:setSize(140, 16)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)
mywindow:subscribeEvent("MouseButtonDown", "OnClicked_RegisterPriceBack")

-- �Ǹűݾ�
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Register_Price")
mywindow:setPosition(130, 0)
mywindow:setSize(130, 16)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("Register_PriceBack"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(13)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Register")
CEGUI.toEditbox(mywindow):subscribeEvent("CharacterKey", "OnTextChanged_Register")

-- �Ǹűݾ� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_CashImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 928, 156)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 928, 183)
mywindow:setPosition(290, 156)
mywindow:setSize(60, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �������� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_DescribeImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 588, 535)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 588, 535)
mywindow:setPosition(17, 195)
mywindow:setSize(436, 235)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- ����
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Register_Title")
mywindow:setPosition(136, 238)
mywindow:setSize(308, 12)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(36)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Register")


--------------------------------------------------------------------
-- �󼼳���
--------------------------------------------------------------------
for i = 1, MAX_REGISTER_DESCRIBE do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "Register_Describe_" .. i)
	mywindow:setText("")
	mywindow:setPosition(136, 273 + ((i-1)*16))
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(308, 16)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
	mywindow:setTextColor(0,0,0,255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	mywindow:setUserString("index", tostring(i))
	CEGUI.toEditbox(mywindow):setMaxTextLength(36)
	CEGUI.toEditbox(mywindow):subscribeEvent("Activated", "OnActivated_RegisterDescribe")
	CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFull_RegisterDescribe")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "OnTextAccepted_RegisterDescribe")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedBack", "OnTextAcceptedBack_RegisterDescribe")
	CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Register")
	winMgr:getWindow('RegisterBackground'):addChildWindow(mywindow)
end


-- ����ó
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Register_Contact")
mywindow:setPosition(136, 375)
mywindow:setSize(148, 16)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(0,0,0,255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)
CEGUI.toEditbox(mywindow):setMaxTextLength(15)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditBoxFull")
CEGUI.toEditbox(mywindow):subscribeEvent("TextAcceptedOnlyTab", "OnPressTab_Register")


-- �Է¿Ϸ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Register_Complete")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 0, 664)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 0, 694)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 0, 724)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 754)
mywindow:setPosition(116, 451)
mywindow:setSize(117, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Register_Complete")
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- �����Ϸ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Register_Modify")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 234, 664)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 234, 694)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 234, 724)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 234, 754)
mywindow:setPosition(116, 451)
mywindow:setSize(117, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClicked_Register_Modify")
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)


-- ��� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Register_Cancel")
mywindow:setTexture("Normal",	"UIData/deal5.tga", 117, 664)
mywindow:setTexture("Hover",	"UIData/deal5.tga", 117, 694)
mywindow:setTexture("Pushed",	"UIData/deal5.tga", 117, 724)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 117, 754)
mywindow:setPosition(268, 451)
mywindow:setSize(117, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Register_Close")
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)


-- ���۾˸� ����Ʈ1
for i = 1, MAX_ESCROW_INFO do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowComment_" .. i .. "_EffectImage")
	mywindow:setEnabled(false)
	mywindow:setTexture('Enabled', "UIData/deal6.tga", 0, 0)
	mywindow:setTexture('Disabled', "UIData/deal6.tga", 0, 0)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setPosition(0, 0);
	mywindow:setSize(928, 33);
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("EscrowInfo_" .. i ):addChildWindow(mywindow)
	
--	Escrow_NewCommentEffect("EscrowComment_" .. i)
end

-- ���۾˸� ����Ʈ2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowButton_EffectImage")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/mainbarchat.tga", 344, 700)
mywindow:setTexture('Disabled', "UIData/mainbarchat.tga", 344, 700)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(0, 0);
mywindow:setSize(86, 28);
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("EscrowButton"):addChildWindow(mywindow)

-- ���۾˸� ����Ʈ3
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowHistory_EffectImage")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/deal5.tga", 655, 812)
mywindow:setTexture('Disabled', "UIData/deal5.tga", 655, 812)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(0, 0)
mywindow:setSize(115, 32)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("EscrowButton_History"):addChildWindow(mywindow)


--Escrow_NewCommentEffect("EscrowButton")
--Escrow_NewCommentEffect("EscrowHistory")




-- ����ũ�� â�� ����.
function Escrow_Show()
	Escrow_SetVisible(true)
end

-- ����ũ�� â�� �ݴ´�.
function Escrow_Close()
	Escrow_SetVisible(false)
end


function Escrow_SetVisible( b )	-- ����ũ��â�� visible�� �����Ѵ�
	
	if b == 1 or b == true then
		b = true
		Escrow_SetPage(1)
		winMgr:getWindow("EscrowBackground"):moveToFront()
	else
		b = false
		Register_SetVisible(false)
	end
	
	winMgr:getWindow("EscrowAlphaImage"):setVisible(b)
	winMgr:getWindow("EscrowBackground"):setVisible(b)
end


function Escrow_SetText( window, text, align, standard, posY, fontSize )	-- infoâ text�� pos, size�� �ѹ��� �����Ѵ�

	window:setText(text)
	
	local size
	if fontSize == nil then
		size = SIZE_INFO_FONT
	else
		size = fontSize
	end
	
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, size, text)
	
--	FontSize�� �ٸ� ��� position�� �Բ� �ٲ� ����(���κҸ�)
--	window:setSize(textSize, SIZE_INFO_TEXT_Y)
	
	if align == ALIGN_LEFT then
		window:setPosition(standard, posY)
	elseif align == ALIGN_RIGHT then
		window:setPosition(standard - textSize, posY)	
	elseif align == ALIGN_CENTER then
		window:setPosition(standard - textSize/2, posY)
	end

end


function Escrow_SetInfo( index, number, seller, product, title, quantity, price, state, date, newComment ) -- ���� �������� ������� info controll�� ������ �����Ѵ�

	if index < 1 or MAX_ESCROW_INFO < index then
		return
	end
	
	winMgr:getWindow("EscrowInfo_" .. index):setVisible(true)
	
	-- �ؽ�Ʈ ����
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Number_"	.. index), number,						ALIGN_CENTER,	41, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Seller_"	.. index), seller,						ALIGN_CENTER,	138, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Title_"	.. index), title,						ALIGN_LEFT,		273, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Quantity_" .. index), CommatoMoneyStr(quantity),	ALIGN_RIGHT,	660, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Price_"	.. index), CommatoMoneyStr(price),		ALIGN_RIGHT,	766, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Date_"		.. index), date,						ALIGN_CENTER,	897, POS_INFO_TEXT_Y )
	
	g_InfoState[index] = state
	
	-- TextColor, �̹��� �÷� ����
	if state == ESCROW_STATE_COMPLETE then
		winMgr:getWindow("EscrowInfo_Number_"		.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_Seller_"		.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_Title_"		.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_Quantity_"		.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_Price_"		.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_Date_"			.. index):setTextColor(175,175,175,255)
		winMgr:getWindow("EscrowInfo_PriceImage_"	.. index):setTexture("Enabled", "UIData/deal5.tga", 976, 21)
		winMgr:getWindow("EscrowInfo_PriceImage_"	.. index):setTexture("Disabled", "UIData/deal5.tga", 976, 21)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Enabled", "UIData/deal5.tga", 996, 28)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Disabled", "UIData/deal5.tga", 996, 28)
	else
		winMgr:getWindow("EscrowInfo_Number_"		.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_Seller_"		.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_Title_"		.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_Quantity_"		.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_Price_"		.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_Date_"			.. index):setTextColor(255,255,255,255)
		winMgr:getWindow("EscrowInfo_PriceImage_"	.. index):setTexture("Enabled", "UIData/deal5.tga", 976, 0)
		winMgr:getWindow("EscrowInfo_PriceImage_"	.. index):setTexture("Disabled", "UIData/deal5.tga", 976, 0)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Enabled", "UIData/deal5.tga", 996, 0)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Disabled", "UIData/deal5.tga", 996, 0)
	end

	local stateIndex
	if g_CurPageType == ESCROW_PAGE_SELL then
		stateIndex = state
	elseif seller == GetMyCharacterName() then
		if state == ESCROW_STATE_AVAIL then
			stateIndex = ESCROW_STATE_SELLING
		elseif state == ESCROW_STATE_PROGRESS then
			stateIndex = ESCROW_STATE_WATING
		elseif state == ESCROW_STATE_COMPLETE then
			stateIndex = ESCROW_STATE_COMPLETE_SELL
		end
	else
		if state == ESCROW_STATE_AVAIL then
			stateIndex = ESCROW_STATE_AVAIL
		elseif state == ESCROW_STATE_PROGRESS then
			stateIndex = ESCROW_STATE_BUYING
		elseif state == ESCROW_STATE_COMPLETE then
			stateIndex = ESCROW_STATE_COMPLETE_BUY
		end
	end	
	
	-- UI ��ġ�� �°� ����
	stateIndex = ESCROW_STATE_UIPOS[stateIndex]
	
	-- state �ؽ��� ����
	winMgr:getWindow("EscrowInfo_State_" .. index):setTexture("Enabled", "UIData/deal5.tga", stateIndex*77, 784)
	winMgr:getWindow("EscrowInfo_State_" .. index):setTexture("Disabled", "UIData/deal5.tga", stateIndex*77, 784)
	
	
	-- �̹��� ����( ����� ZEN�� ����� )
--[[	if product == TYPE_PRODUCT_ZEN then
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Enabled", "UIData/deal5.tga", 996, 0)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Disabled", "UIData/deal5.tga", 996, 0)

	elseif product == TYPE_PRODUCT_ITEM then
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Enabled", "UIData/deal5.tga", 928, 0)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Disabled", "UIData/deal5.tga", 928, 0)
		
	elseif product == TYPE_PRODUCT_ETC then
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("EscrowInfo_ProductImage_" .. index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	end
]]

	-- �� ������ ������� ����Ʈ ����
--[[	if newComment then
		Escrow_NewCommentEffect("EscrowComment_" .. index)
	else
		Escrow_ClearNewComment("EscrowComment_" .. index)
	end]]
end

-- Infoâ ��ü�� DetailInfo, �ִϸ��̼� ������ �ʱ�ȭ �Ѵ�
function Escrow_ClearInfoAll()

	for i = 1, MAX_ESCROW_INFO do

		g_InfoAni[i] = STATE_INFOANI_STOP
		g_InfoDetailAniPos[i] = 0
		g_InfoAniPos[i] = (i-1)*34
		
		winMgr:getWindow("EscrowInfo_" .. i):setVisible(false)
		winMgr:getWindow("EscrowInfo_" .. i):setPosition(0, g_InfoAniPos[i])
		winMgr:getWindow("EscrowInfo_Number_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_Seller_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_Title_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_Quantity_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_Price_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_State_" .. i):setText("")
		winMgr:getWindow("EscrowInfo_Date_" .. i):setText("")
	end
	
	Escrow_ShowEffect(1, 1, false, 0)
	Escrow_ShowEffect(1, 2, false, 0)
	
	if g_SelectedInfo ~= 0 then
		winMgr:getWindow("EscrowInfo_" .. g_SelectedInfo):removeChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
		winMgr:getWindow("EscrowInfo_" .. g_SelectedInfo):removeChildWindow(winMgr:getWindow("EscrowComment_BackImage"))
		g_SelectedInfo = 0
	end
	
	g_CommentAniState = STATE_INFOANI_STOP
	g_CommentAniPos = 0
			
end

function RefreshInfo()	-- ���� ������ ����
	SetPageInfo(g_CurPageType, g_CurPage)
end

function Escrow_SetPageNumbers( firstPage ) -- ������ ���ڸ� �����Ѵ�

	for i = 1, 5 do
		index = firstPage + i - 1
		
		if index > g_MaxPage then
			break
		end
		
		g_PageNumbers[i] = index
		Escrow_SetText(winMgr:getWindow("EscrowButton_PageNumber_Text_" .. i), index, ALIGN_CENTER, 10, POS_INFO_TEXT_Y)
	end
	
end

function Escrow_SetPage( page ) -- �������� �����Ѵ�. �μ� page�� 0~6�� ���� ������

	local start
	local next
	
	local num
	
	if page == 0 or page == 6 then
		num = 1 -- ���� ������ �о�ֱ�
	else
		num = g_PageNumbers[page]
	end
	
	if 1 <= num and num <= g_MaxPage then
	
		if page == 0 then
			next = 5
			start = g_PageNumbers[1] - 5
		elseif page == 6 then
			next = 1
			start = g_PageNumbers[5] + 1
		else
			next = page
			start = num - ((num-1)%5)
		end		
			
		Escrow_SetMoveButtons( start, next )
		
		-- ���� ������ ����
		SetPageInfo( g_CurPageType, g_PageNumbers[next] )
		
	end
end
	
		
function Escrow_SetMoveButtons( start, page )

	Escrow_SetPageNumbers( start )
	winMgr:getWindow("EscrowButton_PageNumber_Text_" .. g_CurPage):setTextColor(255,255,255,255)	-- ������
	winMgr:getWindow("EscrowButton_PageNumber_Text_" .. page):setTextColor(255,180,50,255)			-- ������
	g_CurPage = page
	
	
	-- Prev ��ư Enable ����
	if g_PageNumbers[page] >= 6 then
		winMgr:getWindow("EscrowButton_Prev5"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Prev5"):setEnabled(false)
	end
	
	-- Prev ��ư Enable ����
	if g_PageNumbers[page] >= 2 then
		winMgr:getWindow("EscrowButton_Prev"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Prev"):setEnabled(false)
	end
	
	-- Next ��ư Enable ����
	if g_PageNumbers[page] < g_MaxPage then
		winMgr:getWindow("EscrowButton_Next"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Next"):setEnabled(false)
	end
	
	-- Next5 ��ư Enable ����
	if g_PageNumbers[page] <= g_MaxPage - (g_MaxPage % 5) and (g_MaxPage % 5 ~= 0 or g_PageNumbers[page] <= g_MaxPage - 5) then
		winMgr:getWindow("EscrowButton_Next5"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Next5"):setEnabled(false)
	end
	
	-- PageNumber ��ġ ����
	if g_MaxPage - start + 1 < 5 then
		Escrow_SetPageNumCnt( g_MaxPage - start + 1 )
	else
		Escrow_SetPageNumCnt( 5 )
	end

end


function Escrow_SetMaxPage( max ) -- �ִ� �������� �����Ѵ�
	g_MaxPage = max
	Escrow_SetMoveButtons(g_PageNumbers[1], g_CurPage)
end


function _setPageNumCnt( ... ) -- Escrow_SetPageNumCnt�Լ��� ���� �����Լ�
	
	for i = 1, select('#', ...)  do
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setPosition(select(i, ...), 573-POS_INFO_TEXT_Y)
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setVisible(true)
	end
	
	for i = select('#', ...) + 1, 5 do
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setVisible(false)
	end
		
end

-- 1���� cnt������ ��ư���� Ȱ��ȭ(visible)�ϰ� ��ġ�� �����Ѵ�
function Escrow_SetPageNumCnt( cnt ) -- �������� ��ư ������ �����Ѵ�

	if cnt == 1 then
		_setPageNumCnt          (488)
	elseif cnt == 2 then
		_setPageNumCnt       (473, 503)
	elseif cnt == 3 then
		_setPageNumCnt     (458, 488, 518)
	elseif cnt == 4 then
		_setPageNumCnt  (443, 473, 503, 533)
	elseif cnt == 5 then
		_setPageNumCnt(428, 458, 488, 518, 548)
	end
end

-- text���� ���ڸ� ������ ��ȯ�Ѵ�
function _extractNumbers( text )

	local result = text
	
	for i = 1, string.len(result) do
		local c = string.sub( result, i, i )
		if 	c < "0" or "9" < c then
			result = string.sub( result, 1, i-1 ) .. string.sub( result, i+1, string.len(result) )
		end
	end
	
	return result
end

-- �����Լ�, ������â�� �ִϸ��̼�
function Escrow_Render()

	-- ����ũ��â�� Ȱ��ȭ �Ǿ����� ������� ����
	if winMgr:getWindow("EscrowBackground"):isVisible() == false then
		return
	end

	-- �Ǹŵ��â ��������
	if winMgr:getWindow("RegisterBackground"):isVisible() == true then
		if winMgr:getWindow("Register_TitleTextImage_Sell"):isVisible() == true then
		
			local text = winMgr:getWindow("Register_Quantity"):getText()
			local result = CommatoMoneyStr(_extractNumbers(text))
			
			if result == "0" then
				result = ""
			end 
			
			Escrow_SetText(winMgr:getWindow("Register_Quantity"), result, ALIGN_RIGHT, 130, 0, 15)
			
			
			text = winMgr:getWindow("Register_Price"):getText()
			result = CommatoMoneyStr(_extractNumbers(text))
			
			if result == "0" then
				result = ""
			end 
			
			Escrow_SetText(winMgr:getWindow("Register_Price"), result, ALIGN_RIGHT, 130, 0, 15)
		end
	end
	
	local dist
	local distBottom
	local nextPos
	
	if g_CommentAniState == STATE_INFOANI_SHOW then -- Info + InfoDetail + ���� �ִϸ��̼�
	
		-- Info
		if g_SelectedInfo > 1 then
			if g_InfoAniPos[g_SelectedInfo] - SPEED_INFOANI <= 0 then
				dist = g_InfoAniPos[g_SelectedInfo]
			else
				dist = SPEED_INFOANI
			end
			
			for i = 1, g_SelectedInfo do
				g_InfoAniPos[i] = g_InfoAniPos[i] - dist
				if g_InfoAniPos[i] < 0 then
					winMgr:getWindow("EscrowInfo_" .. i):setVisible(false)
				else
					winMgr:getWindow("EscrowInfo_" .. i):setPosition(0, g_InfoAniPos[i])
				end
			end
		end
		
		-- comment texture, size, pos
		g_CommentAniPos = g_CommentAniPos + SPEED_INFOANI
		if dist == SPEED_INFOANI then
			g_BottomAniPos = g_CommentAniPos * 2
		else
			g_BottomAniPos = g_BottomAniPos + SPEED_INFOANI
		end
		
		if g_BottomAniPos >= 442 then -- �ִϸ��̼� ����
			nextPos = 442
		else
			nextPos = g_BottomAniPos
		end
		
		mywindow = winMgr:getWindow("EscrowComment_BackImage")
		if 316-nextPos <= 0 then
			mywindow:setTexture("Enabled", "UIData/deal6.tga", 0, 33)
			mywindow:setTexture("Disabled", "UIData/deal6.tga", 0, 33)
			mywindow:setPosition(0, nextPos - 283)
			mywindow:setSize(928, 316)
		else
			mywindow:setTexture("Enabled", "UIData/deal6.tga", 0, 349-nextPos)
			mywindow:setTexture("Disabled", "UIData/deal6.tga", 0, 349-nextPos)
			mywindow:setPosition(0, 33)
			mywindow:setSize(928, nextPos)
		end
			
		
		-- Info bottom
		if g_SelectedInfo < MAX_ESCROW_INFO then
			if g_InfoAniPos[g_SelectedInfo+1] + SPEED_INFOANI > 442 + SPEED_INFOANI then
				distBottom = 0
			elseif dist == SPEED_INFOANI then
				distBottom = SPEED_INFOANI*2
			else
				distBottom = SPEED_INFOANI
			end
			
			for i = g_SelectedInfo+1, MAX_ESCROW_INFO do
				g_InfoAniPos[i] = g_InfoAniPos[i] + distBottom
				if g_InfoAniPos[i] > 442 then
					winMgr:getWindow("EscrowInfo_" .. i):setVisible(false)
				else
					winMgr:getWindow("EscrowInfo_" .. i):setPosition(0, g_InfoAniPos[i])
				end
			end
		end
		
		
		-- detail
		if g_BottomAniPos >= 442 then -- �ִϸ��̼� ����(316 + 134 - 8)
		
			if dist ~= SPEED_INFOANI then
				g_CommentAniState = STATE_INFOANI_STOP
				
				Escrow_SetInfoDetail(g_SelectedInfo)
				winMgr:getWindow("EscrowInfoDetail_Back"):setVisible(true)
				
				RequestCommentList(tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()))
				winMgr:getWindow("EscrowComment_Back"):setVisible(true)	
			end
			
			dist = SPEED_INFOANI - (g_BottomAniPos-442)
			g_BottomAniPos = 442
		else
			dist = SPEED_INFOANI
		end
		
		mywindow = winMgr:getWindow("EscrowInfoDetail_BackImage")
		mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 690-g_BottomAniPos) -- (316 + 382 - 8)
		mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 690-g_BottomAniPos)
		mywindow:setSize(928, g_BottomAniPos - 308)
		
		
	elseif g_CommentAniState == STATE_INFOANI_HIDE then
	
		-- Info
		if g_SelectedInfo > 1 then
			if g_InfoAniPos[g_SelectedInfo] + SPEED_INFOANI >= (g_SelectedInfo-1)*34 then
				dist = (g_SelectedInfo-1)*34 - g_InfoAniPos[g_SelectedInfo]
			else
				dist = SPEED_INFOANI
			end
			
			for i = 1, g_SelectedInfo do
				g_InfoAniPos[i] = g_InfoAniPos[i] + dist
				if g_InfoAniPos[i] >= 0 then
					winMgr:getWindow("EscrowInfo_" .. i):setVisible(true)
					winMgr:getWindow("EscrowInfo_" .. i):setPosition(0, g_InfoAniPos[i])
				end
			end
		end
		
		-- Info bottom
		if g_SelectedInfo < MAX_ESCROW_INFO then
			if g_InfoAniPos[g_SelectedInfo+1] - SPEED_INFOANI <= g_SelectedInfo*34 then
				distBottom = g_InfoAniPos[g_SelectedInfo+1] - g_SelectedInfo*34
			else
				distBottom = SPEED_INFOANI
			end
			
			for i = g_SelectedInfo+1, MAX_ESCROW_INFO do
				g_InfoAniPos[i] = g_InfoAniPos[i] - distBottom
				if g_InfoAniPos[i] <= 442 and winMgr:getWindow("EscrowInfo_Number_" .. i):getText() ~= "" then
					winMgr:getWindow("EscrowInfo_" .. i):setVisible(true)
					winMgr:getWindow("EscrowInfo_" .. i):setPosition(0, g_InfoAniPos[i])
				end
			end
		end
		
		if dist ~= SPEED_INFOANI and distBottom ~= SPEED_INFOANI then
			g_SelectedInfo = 0
			g_CommentAniState = STATE_INFOANI_STOP
		end
	end
	

	-- InfoDetail �ִϸ��̼�
	for i = 1, MAX_ESCROW_INFO do
	
		if g_InfoAni[i] == STATE_INFOANI_SHOW then
		
			g_InfoDetailAniPos[i] = g_InfoDetailAniPos[i] + SPEED_INFOANI
			
			if g_InfoDetailAniPos[i] >= 134 then -- �ִϸ��̼� ����
				dist = SPEED_INFOANI - (g_InfoDetailAniPos[i]-134)
				g_InfoDetailAniPos[i] = 134
				g_InfoAni[i] = STATE_INFOANI_STOP
				Escrow_SetInfoDetail(i)
				winMgr:getWindow("EscrowInfoDetail_Back"):setVisible(true)
			else
				dist = SPEED_INFOANI
			end
			
			mywindow = winMgr:getWindow("EscrowInfoDetail_BackImage")
			mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 382-g_InfoDetailAniPos[i])
			mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 382-g_InfoDetailAniPos[i])
			mywindow:setSize(928, g_InfoDetailAniPos[i])
			
			for j = i+1, MAX_ESCROW_INFO do
				g_InfoAniPos[j] = g_InfoAniPos[j] + dist
				winMgr:getWindow("EscrowInfo_" .. j):setPosition(0, g_InfoAniPos[j])
			end
			
		elseif g_InfoAni[i] == STATE_INFOANI_HIDE then
		
			local dist
			
			g_InfoDetailAniPos[i] = g_InfoDetailAniPos[i] - SPEED_INFOANI
			
			if g_InfoDetailAniPos[i] <= 0 then -- �ִϸ��̼� ����
				dist = SPEED_INFOANI + g_InfoDetailAniPos[i]
				g_InfoDetailAniPos[i] = 0
				g_InfoAni[i] = STATE_INFOANI_STOP
			else
				dist = SPEED_INFOANI
			end
			
			for j = i+1, MAX_ESCROW_INFO do
				g_InfoAniPos[j] = g_InfoAniPos[j] - dist
				winMgr:getWindow("EscrowInfo_" .. j):setPosition(0, g_InfoAniPos[j])
			end
			
		end
	end
	
end

function Escrow_SetInfoDetail( index )	-- ������â�� ������ ä���
	
	seller, grade, contact, title, describe, price, product, quantity, buyer, state = GetInfoDetail( index )

	-- �ڽ��� ������ �Ǵ� �Ǹ��ڰ� �ƴҰ�� ����ó�� ����(****)
	if GetMyCharacterName() ~= seller and GetMyCharacterName() ~= buyer then
		contact = "****"
	end

	Escrow_SetText(winMgr:getWindow("EscrowInfoDetail_Seller"),		seller,						ALIGN_CENTER, 127, 51)
	Escrow_SetText(winMgr:getWindow("EscrowInfoDetail_Contact"),	contact,					ALIGN_CENTER, 127, 102)
	Escrow_SetText(winMgr:getWindow("EscrowInfoDetail_Price"),		CommatoMoneyStr(price),		ALIGN_CENTER, 661, 51)
	Escrow_SetText(winMgr:getWindow("EscrowInfoDetail_Quantity"),	CommatoMoneyStr(quantity),	ALIGN_CENTER, 661, 102)
	Escrow_SetText(winMgr:getWindow("EscrowInfoDetail_Buyer"),		buyer,						ALIGN_CENTER, 853, 51)
	
	local posX = 662 + (GetStringSize(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT, CommatoMoneyStr(price)) / 2)
	winMgr:getWindow("EscrowInfoDetail_PriceImage"):setPosition(posX, 44)
	
	multiEdit = CEGUI.toMultiLineEditbox(winMgr:getWindow("EscrowInfoDetail_Describe"))
	
	multiEdit:clearTextExtends()

	local num = 1
	
	for i = 1, string.len(describe) do
		if string.sub(describe, i, i) == '\n' then
			multiEdit:addTextExtends(string.sub(describe, num, i), g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT, 255,255,255,255,   0, 0,0,0,255 );
			num = i+1
		end
	end
	if num < string.len(describe) then
		multiEdit:addTextExtends(string.sub(describe, num, string.len(describe)) .. '\n', g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT, 255,255,255,255,   0, 0,0,0,255 );
	end
	

	-- grade, product




	-- buttons
	winMgr:getWindow("EscrowInfoDetail_Button_Delete"):setVisible(false)
	winMgr:getWindow("EscrowInfoDetail_Button_Modify"):setVisible(false)
	winMgr:getWindow("EscrowInfoDetail_Button_Cancel"):setVisible(false)
	winMgr:getWindow("EscrowInfoDetail_Button_Sell"):setVisible(false)
	winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setVisible(false)
	winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setEnabled(true)


	if seller == GetMyCharacterName() then
	
		if state == ESCROW_STATE_AVAIL then
			winMgr:getWindow("EscrowInfoDetail_Button_Delete"):setVisible(true)
			winMgr:getWindow("EscrowInfoDetail_Button_Modify"):setVisible(true)
			
		elseif state == ESCROW_STATE_PROGRESS then
			winMgr:getWindow("EscrowInfoDetail_Button_Cancel"):setVisible(true)
			winMgr:getWindow("EscrowInfoDetail_Button_Sell"):setVisible(true)
		end
	elseif state == ESCROW_STATE_AVAIL then
		winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setVisible(true)
	else
		winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setVisible(true)
		winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setEnabled(false)
	end
	
	-- Back �̵��� position�� �����Ǵ� ���׷� ���� �߰�
	winMgr:getWindow("EscrowInfoDetail_Describe"):setPosition(211, 46)
	winMgr:getWindow("EscrowInfoDetail_Button_Delete"):setPosition(738, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Modify"):setPosition(828, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Cancel"):setPosition(738, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Sell"):setPosition(828, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setPosition(783, 81)
end

function Escrow_SetHistory( type ) -- ���� â�� �����Ѵ�
	
	local TITLE_HISTORY = {['err']=0, [0] = "", "All", "Sell", "Buy", "Complete"}
	
	winMgr:getWindow("EscrowInfoBoard_Title_History_" .. TITLE_HISTORY[type]):setProperty("Selected", "false")
	winMgr:getWindow("EscrowInfoBoard_Title_History_" .. TITLE_HISTORY[type]):setProperty("Selected", "true")
	
end


-- Info effect�� �����Ų��
function Escrow_ShowEffect( index, effect, visible, start )
	
	effectWindow = winMgr:getWindow("EscrowInfo_EffectImage" .. effect)
	winMgr:getWindow("EscrowInfo_" .. index):addChildWindow(effectWindow)
	effectWindow:setUseEventController(false)
	effectWindow:clearControllerEvent("EscrowInfo_Effect" .. effect)
	effectWindow:clearActiveController()
	
	if visible then
		effectWindow:addController("EscrowInfo_Controller" .. effect, "EscrowInfo_Effect" .. effect, "alpha", "Sine_EaseInOut", start, 255, 8, true, false, SPEED_EFFECT)
		effectWindow:activeMotion("EscrowInfo_Effect" .. effect)
	else
		local alpha = effectWindow:getAlpha() * start
		effectWindow:addController("EscrowInfo_Controller" .. effect, "EscrowInfo_Effect" .. effect, "alpha", "Sine_EaseInOut", alpha, 0, 8, true, false, SPEED_EFFECT)
		effectWindow:activeMotion("EscrowInfo_Effect" .. effect)
	end
	
end

-- ���� ����
function Escrow_ClearComments()

	for i = 1, 10 do
		winMgr:getWindow("EscrowComment_Contents_" .. i):setVisible(false)
	end
end

-- ����
function Escrow_SetComment( index, name, comment, time )

	winMgr:getWindow("EscrowComment_Contents_" .. index):setVisible(true)
	
	winMgr:getWindow("EscrowComment_Name_" .. index):setText( name )
	winMgr:getWindow("EscrowComment_Comment_" .. index):setText( comment )
	winMgr:getWindow("EscrowComment_Time_" .. index):setText( time )
	
	if name == GetMyCharacterName() then
		winMgr:getWindow("EscrowComment_DeleteButton_" .. index):setVisible(true)
	else
		winMgr:getWindow("EscrowComment_DeleteButton_" .. index):setVisible(false)
	end
end

-- Detail �̺�Ʈ ����
function doNothing()
end


-- �Ǹŵ�� â�� �ݴ´�
function Register_Close()
	winMgr:getWindow("RegisterAlphaImage"):setVisible(false)
	winMgr:getWindow("RegisterBackground"):setVisible(false)
end


function Register_SetVisible( b ) -- �Ǹŵ��â�� visible�� �����Ѵ�
	
	if b == 1 or b == true then
		b = true
		winMgr:getWindow("RegisterAlphaImage"):moveToFront()
		winMgr:getWindow("RegisterBackground"):moveToFront()
	else
		b = false
	end
	
	winMgr:getWindow("RegisterAlphaImage"):setVisible(b)
	winMgr:getWindow("RegisterBackground"):setVisible(b)
end


function Register_GetDescribeText() -- �󼼳����� Text�� �����Ͽ� ��ȯ�Ѵ�
	
	local result = ""
	
	for i = 1, g_RegisterDescribeIndex do
		result = result .. winMgr:getWindow("Register_Describe_" .. i):getText() .. '\n'
	end
	
	return result
end


function Escrow_NewCommentEffect( name )
	
	effectWindow = winMgr:getWindow(name .. "_EffectImage")
	effectWindow:setVisible(true)
	effectWindow:setUseEventController(false);
	effectWindow:clearControllerEvent(name .. "_Effect");
	effectWindow:clearActiveController();
	
	effectWindow:addController(name .. "_Controller", name .. "_Effect", "alpha", "Sine_EaseInOut", 0, 255, 8, true, true, 20)
	effectWindow:addController(name .. "_Controller", name .. "_Effect", "alpha", "Sine_EaseInOut", 255, 0, 8, true, true, 20)

	effectWindow:activeMotion(name .. "_Effect");
end

function Escrow_ClearNewComment( name )
	effectWindow = winMgr:getWindow(name .. "_EffectImage")
	effectWindow:clearControllerEvent(name .. "_Effect");
	effectWindow:clearActiveController();
	effectWindow:setVisible(false)
end












function OnMouseEnter_Info( args ) -- ����â �̺�Ʈ

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index ~= g_SelectedInfo then
		Escrow_ShowEffect(index, 1, true, 150)
	end
end

function OnMouseLeave_Info( args ) -- ����â �̺�Ʈ

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index ~= g_SelectedInfo then
		Escrow_ShowEffect(index, 1, false, 255)
	end
end

function OnMouseLButtonUp_Info( args ) -- ����â �̺�Ʈ

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	
	if g_CommentAniState ~= STATE_INFOANI_STOP or g_CommentAniPos ~= 0 then
		return
	end
	
	seller, grade, contact, title, describe, price, product, quantity, buyer, state = GetInfoDetail( index )

	-- �Ϸ���� ���� �Խù��� ���ؼ� �ڽ��� ������ �Ǵ� �Ǹ����� ��� ������ �Բ� �����ش�
	if g_InfoState[index] == ESCROW_STATE_PROGRESS then
		if GetMyCharacterName() == seller or GetMyCharacterName() == buyer then

			if g_SelectedInfo ~= 0 then
				window:removeChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
				window:removeChildWindow(winMgr:getWindow("EscrowComment_BackImage"))
				g_InfoAni[g_SelectedInfo] = STATE_INFOANI_STOP
				
				-- clear info animation
				for i = 1, MAX_ESCROW_INFO do
					g_InfoAni[i] = STATE_INFOANI_STOP
					g_InfoDetailAniPos[i] = 0
					g_InfoAniPos[i] = (i-1)*34
				end
			end
				
			g_CommentAniState = STATE_INFOANI_SHOW
			g_SelectedInfo = index
			
			g_BottomAniPos = 0
			g_CommentAniPos = 0
			
			for i = 1, MAX_ESCROW_INFO do
				g_InfoAniPos[i] = (i-1)*34
			--	winMgr:getWindow("EscrowInfo_" .. i):setVisible(true)
			end
			
			window:addChildWindow(winMgr:getWindow("EscrowComment_BackImage"))
			winMgr:getWindow("EscrowComment_BackImage"):setVisible(true)
			winMgr:getWindow("EscrowComment_Back"):setVisible(false)
			
			window:addChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
			winMgr:getWindow("EscrowInfoDetail_BackImage"):setVisible(true)
			winMgr:getWindow("EscrowInfoDetail_Back"):setVisible(false)
			
			Escrow_ClearComments()
			
			Escrow_ShowEffect(index, 2, true, 50)
			Escrow_ShowEffect(index, 1, false, 255)
			
			Escrow_ClearNewComment("EscrowComment_" .. index)
			
			return
		end
	end
	
	if g_SelectedInfo ~= 0 then
		window:removeChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
		window:removeChildWindow(winMgr:getWindow("EscrowComment_BackImage"))
		g_InfoAni[g_SelectedInfo] = STATE_INFOANI_HIDE
	end
	

	if g_SelectedInfo == index then
	
		g_SelectedInfo = 0
		Escrow_ShowEffect(index, 2, false, 255)
		Escrow_ShowEffect(index, 1, true, 50)
		
	else
		g_SelectedInfo = index
		g_InfoAni[g_SelectedInfo] = STATE_INFOANI_SHOW
		
		window:addChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
		winMgr:getWindow("EscrowInfoDetail_BackImage"):setVisible(true)
		winMgr:getWindow("EscrowInfoDetail_Back"):setVisible(false)
		
		Escrow_ShowEffect(index, 2, true, 50)
		Escrow_ShowEffect(index, 1, false, 255)

	end
end


-- �̵� ��ư �̺�Ʈ
function OnClicked_Prev5( args )
	Escrow_SetPage(0)
end

function OnClicked_Prev( args )
	Escrow_SetPage(g_CurPage-1)
end

function OnClicked_Next( args )
	Escrow_SetPage(g_CurPage+1)
end

function OnClicked_Next5( args )
	Escrow_SetPage(6)
end


-- ������ ���� �̺�Ʈ
function OnMouseEnter_PageNumber( args )

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	

	winMgr:getWindow("EscrowButton_PageNumber_Text_" .. index):setTextColor(255,180,50,255)

end

function OnMouseLeave_PageNumber( args )

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	

	if index ~= g_CurPage then
		winMgr:getWindow("EscrowButton_PageNumber_Text_" .. index):setTextColor(255,255,255,255)
	end

end


function OnClicked_PageNumber( args )

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	

	if index ~= g_CurPage then
		Escrow_SetPage( index )	
	end
end



function OnClicked_Register( args ) -- �Ǹŵ�� ��ư

	winMgr:getWindow("Register_TitleTextImage_Sell"):setVisible(true)
	winMgr:getWindow("Register_TitleTextImage_Modify"):setVisible(false)
	winMgr:getWindow("Register_Complete"):setVisible(true)
	winMgr:getWindow("Register_Modify"):setVisible(false)
	winMgr:getWindow("Register_QuantityImage"):setEnabled(true)
	winMgr:getWindow("Register_PriceImage"):setEnabled(true)
	winMgr:getWindow("Register_CashImage"):setEnabled(true)

	winMgr:getWindow("Register_Quantity"):setEnabled( true )
	winMgr:getWindow("Register_Price"):setEnabled( true )
	
	winMgr:getWindow("Register_Quantity"):setText("")
	winMgr:getWindow("Register_Price"):setText("")
	winMgr:getWindow("Register_Title"):setText("")
	for i = 1, MAX_REGISTER_DESCRIBE do
		winMgr:getWindow("Register_Describe_" .. i):setText("")
	end
	g_RegisterDescribeIndex = 1
	winMgr:getWindow("Register_Contact"):setText("")

	Register_SetVisible(true)
	winMgr:getWindow("Register_Quantity"):activate()
end

function OnClicked_History( args ) -- �ŷ����� ��ư

	winMgr:getWindow("Escrow_TitleTextImage_Deal"):setVisible(false)
	winMgr:getWindow("Escrow_TitleTextImage_History"):setVisible(true)
	
	winMgr:getWindow("EscrowInfoBoard_Title_Sell"):setVisible(false)
	winMgr:getWindow("EscrowInfoBoard_Title_History_All"):setVisible(true)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Sell"):setVisible(true)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Buy"):setVisible(true)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Complete"):setVisible(true)
	winMgr:getWindow("EscrowButton_History"):setVisible(false)
	winMgr:getWindow("EscrowButton_SellBoard"):setVisible(true)
	
	Escrow_SetHistory( ESCROW_PAGE_MY_ALL )
	
end

function OnClicked_SellBoard( args ) -- �ŷ��Խ��� ��ư

	winMgr:getWindow("Escrow_TitleTextImage_Deal"):setVisible(true)
	winMgr:getWindow("Escrow_TitleTextImage_History"):setVisible(false)
	
	winMgr:getWindow("EscrowInfoBoard_Title_Sell"):setVisible(true)
	winMgr:getWindow("EscrowInfoBoard_Title_History_All"):setVisible(false)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Sell"):setVisible(false)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Buy"):setVisible(false)
	winMgr:getWindow("EscrowInfoBoard_Title_History_Complete"):setVisible(false)
	winMgr:getWindow("EscrowButton_History"):setVisible(true)
	winMgr:getWindow("EscrowButton_SellBoard"):setVisible(false)
	
	g_CurPageType = 0
	SetPageInfo(g_CurPageType, 1)
end



-- ���� Ȯ�� �˾�â Yes Ŭ��
function OnYes_InfoDetail_Delete()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Delete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- ����
	RequestDelete( tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()) )
	
end


-- ���� Ȯ�� �˾�â No Ŭ��
function OnNo_InfoDetail_Delete()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Delete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Delete( args ) -- ���������� ���� ��ư

	local quantity = winMgr:getWindow("EscrowInfoDetail_Quantity"):getText()
	local message = string.format(PreCreateString_4457, quantity) --GetSStringInfo(LAN_ESCROW_ASKMSG_DEL_SALE_001)
	
	-- �ǸŻ��� Ȯ��
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Delete", "OnNo_InfoDetail_Delete")

end

function OnClicked_InfoDetail_Modify( args ) -- ���������� ������� ��ư

	winMgr:getWindow("Register_TitleTextImage_Sell"):setVisible(false)
	winMgr:getWindow("Register_TitleTextImage_Modify"):setVisible(true)
	winMgr:getWindow("Register_Complete"):setVisible(false)
	winMgr:getWindow("Register_Modify"):setVisible(true)
	winMgr:getWindow("Register_QuantityImage"):setEnabled(false)
	winMgr:getWindow("Register_PriceImage"):setEnabled(false)
	winMgr:getWindow("Register_CashImage"):setEnabled(false)
	
	
	seller, grade, contact, title, describe, price, product, quantity, buyer, state = GetInfoDetail( g_SelectedInfo )

	winMgr:getWindow("Register_Quantity"):setEnabled( false )
	winMgr:getWindow("Register_Price"):setEnabled( false )
	
	Escrow_SetText(winMgr:getWindow("Register_Quantity"), CommatoMoneyStr(quantity), ALIGN_RIGHT, 130, 0, 15)
	Escrow_SetText(winMgr:getWindow("Register_Price"), CommatoMoneyStr(price), ALIGN_RIGHT, 130, 0, 15)
	
	winMgr:getWindow("Register_Title"):setText(title)
	
	for i = 1, MAX_REGISTER_DESCRIBE do
		winMgr:getWindow("Register_Describe_" .. i):setText("")
	end
	g_RegisterDescribeIndex = 1

	local num = 1
	local cnt = 1
	
	for i = 1, string.len(describe) do
	
		if string.sub(describe, i, i) == '\n' then
		
			winMgr:getWindow("Register_Describe_" .. cnt):setText(string.sub(describe, num, i-1))
			
			num = i+1
			cnt = cnt + 1
			
			if cnt > MAX_REGISTER_DESCRIBE then
				break
			end
		end
	end
	if num < string.len(describe) and cnt <= MAX_REGISTER_DESCRIBE then
		winMgr:getWindow("Register_Describe_" .. cnt):setText(string.sub(describe, num, string.len(describe)));
	end
	
	if cnt > MAX_REGISTER_DESCRIBE then
		cnt = MAX_REGISTER_DESCRIBE
	end
	
	g_RegisterDescribeIndex = cnt
	
	winMgr:getWindow("Register_Contact"):setText(contact)



	Register_SetVisible(true)
	winMgr:getWindow("Register_Title"):activate()
	
end

-- �Ǹ���� Ȯ�� �˾�â Yes Ŭ��
function OnYes_InfoDetail_Cancel()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Cancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- �Ǹ����
	RequestTrade(2, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), winMgr:getWindow("EscrowInfoDetail_Buyer"):getText() )
	
end

-- �Ǹ���� Ȯ�� �˾�â No Ŭ��
function OnNo_InfoDetail_Cancel()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Cancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Cancel( args ) -- ���������� �Ǹ���� ��ư

	local message = string.format(PreCreateString_4462, winMgr:getWindow("EscrowInfoDetail_Buyer"):getText())
									--GetSStringInfo(LAN_ESCROW_ASKMSG_CANCELSALE_001)
	-- �Ǹ����Ȯ��
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Cancel", "OnNo_InfoDetail_Cancel")
end

-- �ǸſϷ� Ȯ�� �˾�â Yes Ŭ��
function OnYes_InfoDetail_Sell()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Sell" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- �ǸſϷ�
	RequestTrade(1, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), winMgr:getWindow("EscrowInfoDetail_Buyer"):getText() )
	
end

-- �ǸſϷ� Ȯ�� �˾�â No Ŭ��
function OnNo_InfoDetail_Sell()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Sell" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Sell( args ) -- ���������� �ǸſϷ� ��ư

	local buyer = winMgr:getWindow("EscrowInfoDetail_Buyer"):getText()
	local message = string.format(PreCreateString_4464, buyer)
									--GetSStringInfo(LAN_ESCROW_ASKMSG_COMPLETIONSALE_001)
	
	-- �ǸſϷ� Ȯ��
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Sell", "OnNo_InfoDetail_Sell")
end

function OnClicked_InfoDetail_Buy( args ) -- ���������� ���Ž�û ��ư
	
	RequestTrade(0, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), "" )
end

function OnRootKeyUp_Comment(args)	-- ���� �ޱ�(����)
	local keyEvent = CEGUI.toKeyEventArgs(args);
	
	if keyEvent.scancode == 13 then
		OnClicked_Comment()
	end
end

function OnClicked_Comment( args ) -- ���� �ޱ�

	local text = winMgr:getWindow("EscrowComment_Edit"):getText()
	
	if text == "" then
		return
	end
	
	local index = tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText())
	
	RequestComment(index, text)
	
	winMgr:getWindow("EscrowComment_Edit"):setText("")
end


function OnClicked_Comment_Delete( args )	-- ���� ����

	local window = CEGUI.toWindowEventArgs(args).window	
	g_SelectedComment  = tonumber(window:getUserString("index"))
	
	local index = tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText())
	RequestCommentDelete(index, g_SelectedComment - 1)
end

function OnClicked_Comment_Close( args ) -- ���� �ݱ�

	g_CommentAniState = STATE_INFOANI_HIDE	-- ���� �ִ� ����

	g_BottomAniPos = 0
	g_CommentAniPos = 0
	
	Escrow_ShowEffect(index, 2, false, 255)
	Escrow_ShowEffect(index, 1, true, 50)
	
	winMgr:getWindow("EscrowInfoDetail_Back"):setVisible(false)
	winMgr:getWindow("EscrowComment_Back"):setVisible(false)
	
	local window = winMgr:getWindow("EscrowInfo_" .. g_SelectedInfo)
	window:removeChildWindow(winMgr:getWindow("EscrowInfoDetail_BackImage"))
	window:removeChildWindow(winMgr:getWindow("EscrowComment_BackImage"))
end


function OnClicked_HistoryTitle( args ) -- �ŷ����� Ÿ��Ʋ ���� ��ư
	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if window:getProperty("Selected") == "True" then
	
		g_CurPageType = index
		Escrow_SetPage(1)
	end
end

function OnEditBoxFull(args) -- EditBox�� ��á������ �̺�Ʈ
	PlaySound('sound/FullEdit.wav')
end


function OnPressTab_Register(args) -- �Ǹŵ�� â�� EditBox�鿡�� Tab�� ������ ���� �̺�Ʈ

	local window = CEGUI.toWindowEventArgs(args).window	
	
	if window:getName() == "Register_Quantity" then
		winMgr:getWindow("Register_Price"):activate()
	elseif window:getName() == "Register_Price" then
		winMgr:getWindow("Register_Title"):activate()
	elseif window:getName() == "Register_Title" then
		winMgr:getWindow("Register_Describe_" .. g_RegisterDescribeIndex):activate()
	elseif string.sub(window:getName(), 1, 17) == "Register_Describe" then
		winMgr:getWindow("Register_Contact"):activate()
	elseif window:getName() == "Register_Contact" then
		winMgr:getWindow("Register_Quantity"):activate()
	end
	
end

function OnClicked_RegisterQuantityBack(args)	-- �Ǹż��� ���� �̺�Ʈ
	if winMgr:getWindow("Register_TitleTextImage_Sell"):isVisible() then
		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("Register_Quantity"):activate()
	end
end

function OnClicked_RegisterPriceBack(args)	-- �ǸŰ��� ���� �̺�Ʈ
	if winMgr:getWindow("Register_TitleTextImage_Sell"):isVisible() then
		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("Register_Price"):activate()
	end
end


-- �Ǹŵ�� â�� �󼼳��� �̺�Ʈ
local bActivatedFunc = true
function OnActivated_RegisterDescribe(args)

	if bActivatedFunc == true then
	
		bActivatedFunc = false

		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("Register_Describe_" .. g_RegisterDescribeIndex):activate()
		
		bActivatedFunc = true
	end
end

function OnEditboxFull_RegisterDescribe(args)
	
	if g_RegisterDescribeIndex < MAX_REGISTER_DESCRIBE then
		g_RegisterDescribeIndex = g_RegisterDescribeIndex + 1
		winMgr:getWindow("Register_Describe_" .. g_RegisterDescribeIndex):activate()
	end
end

function OnTextAccepted_RegisterDescribe(args)

	if g_RegisterDescribeIndex < MAX_REGISTER_DESCRIBE then
		g_RegisterDescribeIndex = g_RegisterDescribeIndex + 1
		winMgr:getWindow("Register_Describe_" .. g_RegisterDescribeIndex):activate()
	end
end

function OnTextAcceptedBack_RegisterDescribe(args)

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))
	
	if g_RegisterDescribeIndex > 1 and window:getText() == "" then
		g_RegisterDescribeIndex = g_RegisterDescribeIndex - 1
		winMgr:getWindow("Register_Describe_" .. g_RegisterDescribeIndex):activate()
	end
end



-- �Ǹŵ�� â �Է¿Ϸ� �˾�â Yes Ŭ��
function OnYes_Register_Complete()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_Register_Complete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- �Է¿Ϸ�
	RequestUpload(	0, -- ��� �ε���
					0, -- ��ȣ(����̶� ���ο� ��ȣ�� �ڵ����� ��)
					TYPE_PRODUCT_ZEN,
					tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText())),
					tonumber(_extractNumbers(winMgr:getWindow("Register_Price"):getText())),
					winMgr:getWindow("Register_Title"):getText(),
					Register_GetDescribeText(),
					winMgr:getWindow("Register_Contact"):getText()
				 )
end

-- �Ǹŵ�� â �Է¿Ϸ� �˾�â No Ŭ��
function OnNo_Register_Complete()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_Register_Complete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_Register_Complete(args)	-- �Ǹŵ�� â �Է¿Ϸ� ��ư

	-- �Ǹż����� ������� ��
	if winMgr:getWindow("Register_Quantity"):getText() == "" then
		ShowNotifyOKMessage_Lua(PreCreateString_4447)	--GetSStringInfo(LAN_ESCROW_ERRMSG_002)
		return
	end
	
	-- �Ǹż����� �ڽ��� �� ���������� ���� ��
	local quantity = tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText()))
	if quantity > GetMyCharacterZen() then
		ShowNotifyOKMessage_Lua(PreCreateString_4448)	--GetSStringInfo(LAN_ESCROW_ERRMSG_003)
		return
	end
	
	-- �ǸŰ����� ������� ��
	if winMgr:getWindow("Register_Price"):getText() == "" then
		ShowNotifyOKMessage_Lua(PreCreateString_4449)	--GetSStringInfo(LAN_ESCROW_ERRMSG_004)
		return
	end
	
	local title = winMgr:getWindow("Register_Title"):getText()
	
	-- ������ 10�� �̸� �϶�
	if string.len(title) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4450)	--GetSStringInfo(LAN_ESCROW_ERRMSG_005)
		return
	end
	
	
	local describe = Register_GetDescribeText()
	
	-- ������ 10�� �̸� �϶�
	if string.len(describe) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4451)	--GetSStringInfo(LAN_ESCROW_ERRMSG_006)
		return
	end
	
	-- ������ ���Ϳ� �ɷ�����
	local bFilter, filterChat = FindBadWord(title)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end

	-- ������ ���Ϳ� �ɷ�����
	bFilter, filterChat = FindBadWord(describe)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end


	local message = string.format(PreCreateString_4453, CommatoMoneyStr(quantity))
									--GetSStringInfo(LAN_ESCROW_ASKMSG_001)
	
	-- �ǸſϷ� Ȯ��
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_Register_Complete", "OnNo_Register_Complete")

end

function OnClicked_Register_Modify(args)	-- �Ǹŵ�� â �����Ϸ� ��ư

	local title = winMgr:getWindow("Register_Title"):getText()
	
	-- ������ 10�� �̸� �϶�
	if string.len(title) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4450)	--GetSStringInfo(LAN_ESCROW_ERRMSG_005)
		return
	end

	local describe = Register_GetDescribeText()
	
	-- ������ 10�� �̸� �϶�
	if string.len(describe) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4451)	--GetSStringInfo(LAN_ESCROW_ERRMSG_006)
		return
	end
	
	-- ������ ���Ϳ� �ɷ�����
	local bFilter, filterChat = FindBadWord(title)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end

	-- ������ ���Ϳ� �ɷ�����
	bFilter, filterChat = FindBadWord(describe)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end
	

	-- ����
	RequestUpload(	1, -- ���� �ε���
					tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), -- ��ȣ
					TYPE_PRODUCT_ZEN,
					tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText())),
					tonumber(_extractNumbers(winMgr:getWindow("Register_Price"):getText())),
					winMgr:getWindow("Register_Title"):getText(),
					Register_GetDescribeText(),
					winMgr:getWindow("Register_Contact"):getText()
				 )
end


function OnTextChanged_Register(args) -- �Ǹŵ�� â �Ǹż���, ���� ����

	local window = CEGUI.toWindowEventArgs(args).window	
	
	local str = _extractNumbers(window:getText())
	
	if string.len(str) >= 10 and str ~= "1000000000" then
		Escrow_SetText(window, "1,000,000,000", ALIGN_RIGHT, 130, 0, 15)
	else
		Escrow_SetText(window, window:getText(), ALIGN_RIGHT, 130, 0, 15)
	end
end

