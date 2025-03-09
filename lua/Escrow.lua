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

-- 텍스트 정렬 상태 지정
local ALIGN_LEFT	= 1
local ALIGN_RIGHT	= 2
local ALIGN_CENTER	= 3

-- 판매물품 종류
local TYPE_PRODUCT_ZEN	= 1
local TYPE_PRODUCT_ITEM = 2
local TYPE_PRODUCT_ETC	= 3

-- 상태 종류
local ESCROW_STATE_AVAIL		= 0 -- 거래가능
local ESCROW_STATE_PROGRESS		= 1 -- 거래중
local ESCROW_STATE_COMPLETE		= 2 -- 거래완료
local ESCROW_STATE_SELLING		= 3 -- 판매중
local ESCROW_STATE_BUYING		= 4 -- 구매신청중
local ESCROW_STATE_WATING		= 5 -- 판매승인대기
local ESCROW_STATE_COMPLETE_SELL= 6 -- 판매완료
local ESCROW_STATE_COMPLETE_BUY	= 7 -- 구매완료

-- State Image의 위치가 위의 ESCROW_STATE_ 인덱스와 다르기 때문에 맞춰주는 인덱스 배열
local ESCROW_STATE_UIPOS = {['err']=0, [0]=0, 2, 1, 3, 5, 4, 7, 6}

-- 페이지 종류
local ESCROW_PAGE_SELL			= 0 -- 판매 게시판
local ESCROW_PAGE_MY_ALL		= 1 -- 전체 거래내역
local ESCROW_PAGE_MY_SELL		= 2 -- 판매중인 내역
local ESCROW_PAGE_MY_BUY		= 3 -- 구매중인 내역
local ESCROW_PAGE_MY_COMPLETE	= 4 -- 거래완료 내역


local POS_INFO_TEXT_Y	= 13	-- StaticText 컨트롤 윈도우들의 Y포지션
local SIZE_INFO_TEXT_Y	= 11	-- StaticText 컨트롤 윈도우들의 Y사이즈
local SIZE_INFO_FONT	= 11	-- info text의 font size

local SPEED_EFFECT = 25			-- 마우스엔터 이벤트 이펙트의 속도

local SPEED_INFOANI = 15		-- 상세정보창 애니메이션의 속도

-- 상세정보창 애니메이션 상태
local STATE_INFOANI_STOP = 0
local STATE_INFOANI_SHOW = 1
local STATE_INFOANI_HIDE = 2

-- 거래내역 탭 이름
local TITLE_HISTORY = {['err'] = 0, [0] = "",	"EscrowInfoBoard_Title_History_All", "EscrowInfoBoard_Title_History_Sell",
												"EscrowInfoBoard_Title_History_Buy", "EscrowInfoBoard_Title_History_Complete"}

local MAX_REGISTER_DESCRIBE = 5 -- 판매등록 상세내용의 Editbox 갯수

local g_CurPageType = ESCROW_PAGE_SELL -- 현재 페이지, ESCROW_PAGE 의 값을 갖는다
local g_CurPage = 2 -- 현재 선택되어 있는 페이지 1에서 5의 숫자들 가진다
local g_PageNumbers = {['err']=0, [0] = 0, 1, 2, 3, 4, 5} -- 현재 보여지는 페이지 숫자들
local g_MaxPage = 1

-- Info의 애니메이션을 관리
local g_InfoAni = {['err']=0, [0] = 0}
local g_InfoDetailAniPos = {['err']=0, [0] = 0}
local g_InfoAniPos = {['err']=0, [0] = 0}

for i = 1, MAX_ESCROW_INFO do
	g_InfoAni[i] = STATE_INFOANI_STOP
	g_InfoDetailAniPos[i] = 0
	g_InfoAniPos[i] = 0 
end

local g_InfoState = {['err']=0, [0] = 0} -- 게시물들의 상태를 저장

local g_CommentAniState = STATE_INFOANI_STOP	-- 덧글 애니 상태
local g_CommentAniPos = 0	-- 덧글 애니 위치
local g_BottomAniPos = 0	-- 덧글 애니 아래쪽 위치

local g_SelectedInfo = 0 -- 현재 선택된 게시물, 맨위가 1, 선택되어 있지 않다면 0

local g_RegisterDescribeIndex = 1 -- 판매등록창 상세내용 관리변수

local g_SelectedComment	-- 삭제될 덧글










--[[

public: -- windows

	EscrowAlphaImage	-- 에스크로창 알파이미지
	EscrowBackground	-- 전체 에스크로창
	{
	--	Escrow_Titlebar					-- 타이틀바(삭제됨, 고정윈도우)
		Escrow_CloseBtn					-- 닫기버튼
		Escrow_TitleTextImage_Deal		-- 타이틀 텍스트 이미지(거래 게시판)
		Escrow_TitleTextImage_History	-- 타이틀 텍스트 이미지(나의 거래내역)
		
		EscrowInfoBoard
		{
			EscrowInfoBoard_Title_Sell				-- 판매 게시판
			EscrowInfoBoard_Title_History_All		-- 전체 거래내역
			EscrowInfoBoard_Title_History_Sell		-- 판매중인 내역
			EscrowInfoBoard_Title_History_Buy		-- 구매중인 내역
			EscrowInfoBoard_Title_History_Complete	-- 거래완료 내역
			EscrowInfoBoard_Label
			
			EscrowInfo_1 ~ MAX		-- 인포창
				EscrowInfo_BackImage_1 ~ MAX		-- 인포창 기본 배경 이미지
				EscrowInfo_Number_1 ~ MAX			-- 번호
				EscrowInfo_Seller_1 ~ MAX			-- 판매자
				EscrowInfo_ProductImage_1 ~ MAX		-- 판매물품 이미지
				EscrowInfo_Title_1 ~ MAX			-- 제목
				EscrowInfo_Quantity_1 ~ MAX			-- 수량
				EscrowInfo_Price_1 ~ MAX			-- 판매가격
				EscrowInfo_PriceImage_1 ~ MAX		-- 판매가격 이미지
				EscrowInfo_State_1 ~ MAX			-- 상태
				EscrowInfo_Date_1 ~ MAX				-- 등록일
			
			EscrowInfo_EffectImage1	-- 마우스 엔터 이펙트
			EscrowInfo_EffectImage2	-- 마우스 클릭(선택) 이펙트
			
			EscrowInfoDetail_BackImage			-- 상세정보 배경이미지
			EscrowInfoDetail_Back				-- 상세정보 전체
				EscrowInfoDetail_Seller			-- 판매자 캐릭터명
				EscrowInfoDetail_GradeImage		-- 등급 이미지
				EscrowInfoDetail_Contact		-- 연락처
				EscrowInfoDetail_Describe		-- 상세내용
				EscrowInfoDetail_Price			-- 판매가격
				EscrowInfoDetail_PriceImage		-- 판매가격 이미지
				EscrowInfoDetail_ProductImage	-- 판매물품 이미지
				EscrowInfoDetail_Quantity		-- 판매수량
				EscrowInfoDetail_Buyer			-- 캐릭터명
				EscrowInfoDetail_Button_Delete	-- 삭제 버튼
				EscrowInfoDetail_Button_Modify	-- 내용수정 버튼
				EscrowInfoDetail_Button_Cancel	-- 판매취소 버튼
				EscrowInfoDetail_Button_Sell	-- 판매완료 버튼
				EscrowInfoDetail_Button_Buy		-- 구매신청 버튼
					
			EscrowComment_BackImage			-- 덧글 배경 이미지
			EscrowComment_Back				-- 덧글 뒷판
				EscrowComment_EditImage		-- 덧글 입력 에디트 이미지
				EscrowComment_Edit			-- 덧글 입력 에디트
				EscrowComment_Button_Input	-- 덧글 입력 버튼
				EscrowComment_Contents_1~10	-- 덧글
					EscrowComment_Name_1~10	-- 이름
					EscrowComment_Arrow_1~10		-- 화살표
					EscrowComment_Comment_1~10		-- 덧글
					EscrowComment_Time_1~10			-- 등록 날짜/시간
					EscrowComment_DeleteButton_1~10	-- 삭제버튼
				EscrowComment_Button_Close	-- 닫기 버튼
				
			

			-- 스크롤바
			EscrowScrollbar_body
			EscrowScrollbar_decbtn
			EscrowScrollbar_incbtn
			EscrowScrollbar_thumb
			
			-- Zone4 배경
			EscrowDeco_Zone4
			
			-- 이동 버튼
			EscrowButton_Prev5
			EscrowButton_Prev
			EscrowButton_Next
			EscrowButton_Next5
			
			-- 페이지 숫자
			EscrowButton_PageNumber_1 ~ 5
				EscrowButton_PageNumber_Text_1 ~ 5
			
			EscrowButton_Register	-- 판매등록 버튼
			EscrowButton_History	-- 거래내역 버튼
			EscrowButton_SellBoard	-- 거래게시판 버튼
			
		} -- end of EscrowInfoBoard
	} -- end of EscrowBackground


	RegisterAlphaImage	-- 판매 등록 알파창(안보임)
	RegisterBackground	-- 판매 등록 창
	{
		Register_Titlebar		-- 타이틀바
		Register_TitleTextImage_Sell	-- 판매 등록
		Register_TitleTextImage_Modify	-- 판매 등록 수정
		Register_CloseBtn		-- 닫기 버튼
		Register_ProductImage	-- 물품정보 이미지
		Register_SellImage		-- 판매수량, 판매금액 이미지
		Register_QuantityImage	-- 판매수량 이미지
		Register_QuantityBack	-- 판매수량 뒷판
		Register_Quantity		-- 판매수량
		Register_PriceImage		-- 판매금액 이미지
		Register_PriceBack		-- 판매금액 뒷판
		Register_Price			-- 판매금액
		Register_CashImage		-- 판매금액 단위 이미지
		Register_DescribeImage	-- 내용정보 이미지
		Register_Title			-- 제목
		Register_Describe_1~5	-- 상세내용
		Register_Contact		-- 연락처
		Register_Complete		-- 입력완료 버튼
		Register_Modify			-- 수정완료 버튼
		Register_Cancel			-- 취소 버튼
	}

	-- 덧글알림 이펙트
	EscrowComment_1~10_EffectImage
	EscrowButton_EffectImage
	EscrowHistory_EffectImage

public: -- functions

	-- 외부에서는 * 표시가 붙은 함수들만을 사용할것을 권장합니다

	function Escrow_Show()			-- 에스크로창을 연다
	function Escrow_Close()			-- 에스크로창을 닫는다
*	function Escrow_SetVisible( b )	-- 에스크로창의 visible을 조정한다
	function Escrow_SetText( window, text, align, standard, posY, fontSize ) -- info창 text와 pos, size를 한번에 설정한다
*	function Escrow_SetInfo( index, number, seller, product, title, quantity, price, state, date ) -- 현재 페이지와 상관없이 info controll의 내용을 변경한다
	function Escrow_ClearInfoAll()	-- Info창 전체와 DetailInfo, 애니메이션 정보를 초기화 한다
	
	function RefreshInfo()	-- 현재 페이지 갱신

	-- 다음 두개 함수는 사용시 인수전달에 주의를 기울여야 한다
	-- SetPageNumbers는 실제 보이는 페이지 숫자를 전달하여야 하며
	-- SetPage는 내부적으로 몇번째 버튼인지를 전달하여야 한다
	function Escrow_SetPageNumbers( firstPage ) -- 페이지 숫자를 설정한다
	function Escrow_SetPage( page )				-- 페이지를 설정한다. 인수 page는 0~6의 값을 가진다
	
	function Escrow_SetMoveButtons( start, page ) -- 이동버튼들의 위치, Enable을 조정한다
*	function Escrow_SetMaxPage( max )			-- 최대 페이지를 설정한다
	function _setPageNumCnt( ... )				-- Escrow_SetPageNumCnt함수의 내부 보조함수
	function Escrow_SetPageNumCnt( cnt )		-- 보여지는 버튼 갯수를 설정한다
	function _extractNumbers( text )			-- text에서 숫자만 추출해 반환한다
*	function Escrow_Render()					-- 렌더함수, 상세정보창의 애니메이션
	function Escrow_SetInfoDetail( index )		-- 상세정보창의 내용을 채운다
	
	function Escrow_SetHistory( type )			-- 내역 창을 선택한다

	function Escrow_ShowEffect( index, effect, visible, start ) -- Info effect를 실행시킨다
	
	function Escrow_ClearComments()				-- 덧글 지움
	function Escrow_SetComment( index, name, comment, time )	-- 덧글
	
	function doNothing() -- Detail 이벤트 방지
	
	function Register_Close()					-- 판매등록 창을 닫는다
	function Register_SetVisible( b )			-- 판매등록창의 visible을 조정한다
	function Register_GetDescribeText()			-- 상세내용의 Text를 조합하여 반환한다
	
	-- 인포창 이벤트
	function OnMouseEnter_Info( args )
	function OnMouseLeave_Info( args )
	function OnMouseLButtonUp_Info( args )

	-- 이동 버튼 이벤트
	function OnClicked_Prev5( args )
	function OnClicked_Prev( args )
	function OnClicked_Next( args )
	function OnClicked_Next5( args )
	
	-- 페이지 숫자 이벤트
	function OnMouseEnter_PageNumber( args )
	function OnMouseLeave_PageNumber( args )
	function OnClicked_PageNumber( args )
	
	function OnClicked_Register( args )			-- 판매등록 버튼
	function OnClicked_History( args )			-- 거래내역 버튼
	function OnClicked_SellBoard( args )		-- 거래게시판 버튼
	
	
	
	function OnYes_InfoDetail_Delete()			-- 삭제 확인 팝업창 Yes 클릭
	function OnNo_InfoDetail_Delete()			-- 삭제 확인 팝업창 No 클릭
	function OnClicked_InfoDetail_Delete( args )-- 상세정보에서 삭제 버튼
	
	function OnClicked_InfoDetail_Modify( args )-- 상세정보에서 내용수정 버튼
	
	function OnYes_InfoDetail_Cancel()			-- 판매취소 확인 팝업창 Yes 클릭
	function OnNo_InfoDetail_Cancel()			-- 판매취소 확인 팝업창 No 클릭
	function OnClicked_InfoDetail_Cancel( args )-- 상세정보에서 판매취소 버튼
	
	function OnYes_InfoDetail_Sell()			-- 판매완료 확인 팝업창 Yes 클릭
	function OnNo_InfoDetail_Sell()				-- 판매완료 확인 팝업창 No 클릭
	function OnClicked_InfoDetail_Sell( args )	-- 상세정보에서 판매완료 버튼
	
	function OnClicked_InfoDetail_Buy( args )	-- 상세정보에서 구매신청 버튼
	
	function OnRootKeyUp_Comment( args )		-- 덧글 달기(엔터)
	function OnClicked_Comment( args )			-- 덧글 달기
	function OnClicked_Comment_Delete( args )	-- 덧글 삭제
	function OnClicked_Comment_Close( args )	-- 덧글 닫기
	
	
	
	function OnClicked_HistoryTitle( args )		-- 거래내역 타이틀 라디오 버튼
	
	function OnEditBoxFull(args)				-- EditBox가 꽉찼을때의 이벤트
	
	function OnClicked_RegisterQuantityBack(args)	-- 판매수량 뒷판 이벤트
	function OnClicked_RegisterPriceBack(args)	-- 판매가격 뒷판 이벤트
	
	function OnPressTab_Register(args)			-- 판매등록 창의 EditBox들에서 Tab을 눌렀을 때의 이벤트
	
	-- 판매등록 창의 상세내용 이벤트
	function OnActivated_RegisterDescribe(args)
	function OnEditboxFull_RegisterDescribe(args)
	function OnTextAccepted_RegisterDescribe(args)
	function OnTextAcceptedBack_RegisterDescribe(args)
	
	function OnYes_Register_Complete()			-- 판매등록 창 입력완료 팝업창 Yes 클릭
	function OnNo_Register_Complete()			-- 판매등록 창 입력완료 팝업창 No 클릭
	function OnClicked_Register_Complete(args)	-- 판매등록 창 입력완료 버튼
	function OnClicked_Register_Modify(args)	-- 판매등록 창 수정완료 버튼
	
	function OnTextChanged_Register(args) -- 판매등록 창 판매수량, 가격 수정

]]--











-- 알파 이미지
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


-- 기본 바탕 윈도우
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


-- 바탕이미지 ESC키 등록
RegistEscEventInfo("EscrowBackground", "Escrow_Close")


-- 타이틀바
--mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Escrow_Titlebar")
--mywindow:setPosition(3, 1)
--mywindow:setSize(SIZE_ESCROW_WIDTH-35, 45)
--winMgr:getWindow("EscrowBackground"):addChildWindow(mywindow)


-- 타이틀 텍스트 이미지
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


-- 닫기버튼
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


-- 탭윈도우
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

-- 탭윈도우 타이틀
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


-- 목록 레이블
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfoBoard_Label")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 0, 156)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 0, 156)
mywindow:setPosition(14, 49)
mywindow:setSize(928, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EscrowInfoBoard"):addChildWindow(mywindow)


-- 모든 게시물 배경
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

-- 인포

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



-- 마우스 엔터 이펙트
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "EscrowInfo_EffectImage1")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/deal5.tga", 0, 182)
mywindow:setTexture('Disabled', "UIData/deal5.tga", 0, 182)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setPosition(0, 0);
mywindow:setSize(928, 33);
mywindow:setZOrderingEnabled(true)



-- 마우스 클릭(선택) 이펙트
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






-- 덧글 배경이미지
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

-- 덧글 뒷판
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

-- 덧글 입력 에디트 이미지
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

-- 덧글 입력 에디트
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

-- 덧글 입력 버튼
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

	-- 백판
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
	
	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Name_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(13, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- 화살표
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

	-- 덧글
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Comment_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(139, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- 등록 날짜/시간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "EscrowComment_Time_" .. i)
	mywindow:setEnabled(false)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, SIZE_INFO_FONT)
	mywindow:setPosition(740, 8)
	mywindow:setSize(108, SIZE_INFO_TEXT_Y)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("EscrowComment_Contents_" .. i):addChildWindow(mywindow)

	-- 삭제 버튼
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

-- 닫기 버튼
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














-- 스크롤바 이미지
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



-- Zone4 배경
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



-- 이동 버튼
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



-- 페이지 숫자
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

-- 임시로 첫페이지 색상 설정
winMgr:getWindow("EscrowButton_PageNumber_Text_1"):setTextColor(255,180,50,255)



-- 판매등록 버튼
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


-- 거래내역 버튼
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

-- 거래게시판 버튼
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













-- 판매 등록 알파 이미지(안보임)
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

-- 판매 등록 창
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


-- 바탕이미지 ESC키 등록
RegistEscEventInfo("RegisterBackground", "Register_Close")


-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Register_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(445, 45)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)


-- 타이틀 텍스트 이미지
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


-- 닫기버튼
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

-- 물품정보 이미지
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

-- 판매수량, 판매금액 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_SellImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 754, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 754, 471)
mywindow:setPosition(35, 121)
mywindow:setSize(98, 63)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- 판매수량 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_QuantityImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 852, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 852, 500)
mywindow:setPosition(131, 121)
mywindow:setSize(158, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- 판매수량 뒷판
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

-- 판매수량
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

-- 판매금액 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_PriceImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 852, 471)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 852, 500)
mywindow:setPosition(131, 155)
mywindow:setSize(158, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- 판매금액 뒷판
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

-- 판매금액
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

-- 판매금액 단위 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_CashImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 928, 156)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 928, 183)
mywindow:setPosition(290, 156)
mywindow:setSize(60, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- 내용정보 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Register_DescribeImage")
mywindow:setTexture("Enabled", "UIData/deal5.tga", 588, 535)
mywindow:setTexture("Disabled", "UIData/deal5.tga", 588, 535)
mywindow:setPosition(17, 195)
mywindow:setSize(436, 235)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RegisterBackground"):addChildWindow(mywindow)

-- 제목
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
-- 상세내용
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


-- 연락처
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


-- 입력완료 버튼
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

-- 수정완료 버튼
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


-- 취소 버튼
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


-- 덧글알림 이펙트1
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

-- 덧글알림 이펙트2
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

-- 덧글알림 이펙트3
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




-- 에스크로 창을 연다.
function Escrow_Show()
	Escrow_SetVisible(true)
end

-- 에스크로 창을 닫는다.
function Escrow_Close()
	Escrow_SetVisible(false)
end


function Escrow_SetVisible( b )	-- 에스크로창의 visible을 조정한다
	
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


function Escrow_SetText( window, text, align, standard, posY, fontSize )	-- info창 text와 pos, size를 한번에 설정한다

	window:setText(text)
	
	local size
	if fontSize == nil then
		size = SIZE_INFO_FONT
	else
		size = fontSize
	end
	
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, size, text)
	
--	FontSize가 다를 경우 position이 함께 바뀌어서 삭제(원인불명)
--	window:setSize(textSize, SIZE_INFO_TEXT_Y)
	
	if align == ALIGN_LEFT then
		window:setPosition(standard, posY)
	elseif align == ALIGN_RIGHT then
		window:setPosition(standard - textSize, posY)	
	elseif align == ALIGN_CENTER then
		window:setPosition(standard - textSize/2, posY)
	end

end


function Escrow_SetInfo( index, number, seller, product, title, quantity, price, state, date, newComment ) -- 현재 페이지와 상관없이 info controll의 내용을 변경한다

	if index < 1 or MAX_ESCROW_INFO < index then
		return
	end
	
	winMgr:getWindow("EscrowInfo_" .. index):setVisible(true)
	
	-- 텍스트 설정
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Number_"	.. index), number,						ALIGN_CENTER,	41, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Seller_"	.. index), seller,						ALIGN_CENTER,	138, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Title_"	.. index), title,						ALIGN_LEFT,		273, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Quantity_" .. index), CommatoMoneyStr(quantity),	ALIGN_RIGHT,	660, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Price_"	.. index), CommatoMoneyStr(price),		ALIGN_RIGHT,	766, POS_INFO_TEXT_Y )
	Escrow_SetText( winMgr:getWindow("EscrowInfo_Date_"		.. index), date,						ALIGN_CENTER,	897, POS_INFO_TEXT_Y )
	
	g_InfoState[index] = state
	
	-- TextColor, 이미지 컬러 설정
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
	
	-- UI 위치에 맞게 변경
	stateIndex = ESCROW_STATE_UIPOS[stateIndex]
	
	-- state 텍스쳐 변경
	winMgr:getWindow("EscrowInfo_State_" .. index):setTexture("Enabled", "UIData/deal5.tga", stateIndex*77, 784)
	winMgr:getWindow("EscrowInfo_State_" .. index):setTexture("Disabled", "UIData/deal5.tga", stateIndex*77, 784)
	
	
	-- 이미지 설정( 현재는 ZEN만 운용중 )
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

	-- 새 덧글이 있을경우 이펙트 설정
--[[	if newComment then
		Escrow_NewCommentEffect("EscrowComment_" .. index)
	else
		Escrow_ClearNewComment("EscrowComment_" .. index)
	end]]
end

-- Info창 전체와 DetailInfo, 애니메이션 정보를 초기화 한다
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

function RefreshInfo()	-- 현재 페이지 갱신
	SetPageInfo(g_CurPageType, g_CurPage)
end

function Escrow_SetPageNumbers( firstPage ) -- 페이지 숫자를 설정한다

	for i = 1, 5 do
		index = firstPage + i - 1
		
		if index > g_MaxPage then
			break
		end
		
		g_PageNumbers[i] = index
		Escrow_SetText(winMgr:getWindow("EscrowButton_PageNumber_Text_" .. i), index, ALIGN_CENTER, 10, POS_INFO_TEXT_Y)
	end
	
end

function Escrow_SetPage( page ) -- 페이지를 설정한다. 인수 page는 0~6의 값을 가진다

	local start
	local next
	
	local num
	
	if page == 0 or page == 6 then
		num = 1 -- 조건 안으로 밀어넣기
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
		
		-- 현재 페이지 갱신
		SetPageInfo( g_CurPageType, g_PageNumbers[next] )
		
	end
end
	
		
function Escrow_SetMoveButtons( start, page )

	Escrow_SetPageNumbers( start )
	winMgr:getWindow("EscrowButton_PageNumber_Text_" .. g_CurPage):setTextColor(255,255,255,255)	-- 이전것
	winMgr:getWindow("EscrowButton_PageNumber_Text_" .. page):setTextColor(255,180,50,255)			-- 다음것
	g_CurPage = page
	
	
	-- Prev 버튼 Enable 설정
	if g_PageNumbers[page] >= 6 then
		winMgr:getWindow("EscrowButton_Prev5"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Prev5"):setEnabled(false)
	end
	
	-- Prev 버튼 Enable 설정
	if g_PageNumbers[page] >= 2 then
		winMgr:getWindow("EscrowButton_Prev"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Prev"):setEnabled(false)
	end
	
	-- Next 버튼 Enable 설정
	if g_PageNumbers[page] < g_MaxPage then
		winMgr:getWindow("EscrowButton_Next"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Next"):setEnabled(false)
	end
	
	-- Next5 버튼 Enable 설정
	if g_PageNumbers[page] <= g_MaxPage - (g_MaxPage % 5) and (g_MaxPage % 5 ~= 0 or g_PageNumbers[page] <= g_MaxPage - 5) then
		winMgr:getWindow("EscrowButton_Next5"):setEnabled(true)
	else
		winMgr:getWindow("EscrowButton_Next5"):setEnabled(false)
	end
	
	-- PageNumber 위치 조정
	if g_MaxPage - start + 1 < 5 then
		Escrow_SetPageNumCnt( g_MaxPage - start + 1 )
	else
		Escrow_SetPageNumCnt( 5 )
	end

end


function Escrow_SetMaxPage( max ) -- 최대 페이지를 설정한다
	g_MaxPage = max
	Escrow_SetMoveButtons(g_PageNumbers[1], g_CurPage)
end


function _setPageNumCnt( ... ) -- Escrow_SetPageNumCnt함수의 내부 보조함수
	
	for i = 1, select('#', ...)  do
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setPosition(select(i, ...), 573-POS_INFO_TEXT_Y)
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setVisible(true)
	end
	
	for i = select('#', ...) + 1, 5 do
		winMgr:getWindow("EscrowButton_PageNumber_" .. i):setVisible(false)
	end
		
end

-- 1부터 cnt까지의 버튼들을 활성화(visible)하고 위치를 조정한다
function Escrow_SetPageNumCnt( cnt ) -- 보여지는 버튼 갯수를 설정한다

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

-- text에서 숫자만 추출해 반환한다
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

-- 렌더함수, 상세정보창의 애니메이션
function Escrow_Render()

	-- 에스크로창이 활성화 되어있지 않을경우 종료
	if winMgr:getWindow("EscrowBackground"):isVisible() == false then
		return
	end

	-- 판매등록창 숫자제한
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
	
	if g_CommentAniState == STATE_INFOANI_SHOW then -- Info + InfoDetail + 덧글 애니메이션
	
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
		
		if g_BottomAniPos >= 442 then -- 애니메이션 종료
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
		if g_BottomAniPos >= 442 then -- 애니메이션 종료(316 + 134 - 8)
		
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
	

	-- InfoDetail 애니메이션
	for i = 1, MAX_ESCROW_INFO do
	
		if g_InfoAni[i] == STATE_INFOANI_SHOW then
		
			g_InfoDetailAniPos[i] = g_InfoDetailAniPos[i] + SPEED_INFOANI
			
			if g_InfoDetailAniPos[i] >= 134 then -- 애니메이션 종료
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
			
			if g_InfoDetailAniPos[i] <= 0 then -- 애니메이션 종료
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

function Escrow_SetInfoDetail( index )	-- 상세정보창의 내용을 채운다
	
	seller, grade, contact, title, describe, price, product, quantity, buyer, state = GetInfoDetail( index )

	-- 자신이 구매자 또는 판매자가 아닐경우 연락처를 숨김(****)
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
	
	-- Back 이동시 position이 변동되는 버그로 인해 추가
	winMgr:getWindow("EscrowInfoDetail_Describe"):setPosition(211, 46)
	winMgr:getWindow("EscrowInfoDetail_Button_Delete"):setPosition(738, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Modify"):setPosition(828, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Cancel"):setPosition(738, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Sell"):setPosition(828, 81)
	winMgr:getWindow("EscrowInfoDetail_Button_Buy"):setPosition(783, 81)
end

function Escrow_SetHistory( type ) -- 내역 창을 선택한다
	
	local TITLE_HISTORY = {['err']=0, [0] = "", "All", "Sell", "Buy", "Complete"}
	
	winMgr:getWindow("EscrowInfoBoard_Title_History_" .. TITLE_HISTORY[type]):setProperty("Selected", "false")
	winMgr:getWindow("EscrowInfoBoard_Title_History_" .. TITLE_HISTORY[type]):setProperty("Selected", "true")
	
end


-- Info effect를 실행시킨다
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

-- 덧글 지움
function Escrow_ClearComments()

	for i = 1, 10 do
		winMgr:getWindow("EscrowComment_Contents_" .. i):setVisible(false)
	end
end

-- 덧글
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

-- Detail 이벤트 방지
function doNothing()
end


-- 판매등록 창을 닫는다
function Register_Close()
	winMgr:getWindow("RegisterAlphaImage"):setVisible(false)
	winMgr:getWindow("RegisterBackground"):setVisible(false)
end


function Register_SetVisible( b ) -- 판매등록창의 visible을 조정한다
	
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


function Register_GetDescribeText() -- 상세내용의 Text를 조합하여 반환한다
	
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












function OnMouseEnter_Info( args ) -- 인포창 이벤트

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index ~= g_SelectedInfo then
		Escrow_ShowEffect(index, 1, true, 150)
	end
end

function OnMouseLeave_Info( args ) -- 인포창 이벤트

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if index ~= g_SelectedInfo then
		Escrow_ShowEffect(index, 1, false, 255)
	end
end

function OnMouseLButtonUp_Info( args ) -- 인포창 이벤트

	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	
	if g_CommentAniState ~= STATE_INFOANI_STOP or g_CommentAniPos ~= 0 then
		return
	end
	
	seller, grade, contact, title, describe, price, product, quantity, buyer, state = GetInfoDetail( index )

	-- 완료되지 않은 게시물에 한해서 자신이 구매자 또는 판매자일 경우 덧글을 함께 보여준다
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


-- 이동 버튼 이벤트
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


-- 페이지 숫자 이벤트
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



function OnClicked_Register( args ) -- 판매등록 버튼

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

function OnClicked_History( args ) -- 거래내역 버튼

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

function OnClicked_SellBoard( args ) -- 거래게시판 버튼

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



-- 삭제 확인 팝업창 Yes 클릭
function OnYes_InfoDetail_Delete()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Delete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- 삭제
	RequestDelete( tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()) )
	
end


-- 삭제 확인 팝업창 No 클릭
function OnNo_InfoDetail_Delete()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Delete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Delete( args ) -- 상세정보에서 삭제 버튼

	local quantity = winMgr:getWindow("EscrowInfoDetail_Quantity"):getText()
	local message = string.format(PreCreateString_4457, quantity) --GetSStringInfo(LAN_ESCROW_ASKMSG_DEL_SALE_001)
	
	-- 판매삭제 확인
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Delete", "OnNo_InfoDetail_Delete")

end

function OnClicked_InfoDetail_Modify( args ) -- 상세정보에서 내용수정 버튼

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

-- 판매취소 확인 팝업창 Yes 클릭
function OnYes_InfoDetail_Cancel()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Cancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- 판매취소
	RequestTrade(2, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), winMgr:getWindow("EscrowInfoDetail_Buyer"):getText() )
	
end

-- 판매취소 확인 팝업창 No 클릭
function OnNo_InfoDetail_Cancel()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Cancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Cancel( args ) -- 상세정보에서 판매취소 버튼

	local message = string.format(PreCreateString_4462, winMgr:getWindow("EscrowInfoDetail_Buyer"):getText())
									--GetSStringInfo(LAN_ESCROW_ASKMSG_CANCELSALE_001)
	-- 판매취소확인
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Cancel", "OnNo_InfoDetail_Cancel")
end

-- 판매완료 확인 팝업창 Yes 클릭
function OnYes_InfoDetail_Sell()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_InfoDetail_Sell" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- 판매완료
	RequestTrade(1, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), winMgr:getWindow("EscrowInfoDetail_Buyer"):getText() )
	
end

-- 판매완료 확인 팝업창 No 클릭
function OnNo_InfoDetail_Sell()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_InfoDetail_Sell" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_InfoDetail_Sell( args ) -- 상세정보에서 판매완료 버튼

	local buyer = winMgr:getWindow("EscrowInfoDetail_Buyer"):getText()
	local message = string.format(PreCreateString_4464, buyer)
									--GetSStringInfo(LAN_ESCROW_ASKMSG_COMPLETIONSALE_001)
	
	-- 판매완료 확인
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_InfoDetail_Sell", "OnNo_InfoDetail_Sell")
end

function OnClicked_InfoDetail_Buy( args ) -- 상세정보에서 구매신청 버튼
	
	RequestTrade(0, tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), "" )
end

function OnRootKeyUp_Comment(args)	-- 덧글 달기(엔터)
	local keyEvent = CEGUI.toKeyEventArgs(args);
	
	if keyEvent.scancode == 13 then
		OnClicked_Comment()
	end
end

function OnClicked_Comment( args ) -- 덧글 달기

	local text = winMgr:getWindow("EscrowComment_Edit"):getText()
	
	if text == "" then
		return
	end
	
	local index = tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText())
	
	RequestComment(index, text)
	
	winMgr:getWindow("EscrowComment_Edit"):setText("")
end


function OnClicked_Comment_Delete( args )	-- 덧글 삭제

	local window = CEGUI.toWindowEventArgs(args).window	
	g_SelectedComment  = tonumber(window:getUserString("index"))
	
	local index = tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText())
	RequestCommentDelete(index, g_SelectedComment - 1)
end

function OnClicked_Comment_Close( args ) -- 덧글 닫기

	g_CommentAniState = STATE_INFOANI_HIDE	-- 덧글 애니 상태

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


function OnClicked_HistoryTitle( args ) -- 거래내역 타이틀 라디오 버튼
	local window = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(window:getUserString("index"))	
	
	if window:getProperty("Selected") == "True" then
	
		g_CurPageType = index
		Escrow_SetPage(1)
	end
end

function OnEditBoxFull(args) -- EditBox가 꽉찼을때의 이벤트
	PlaySound('sound/FullEdit.wav')
end


function OnPressTab_Register(args) -- 판매등록 창의 EditBox들에서 Tab을 눌렀을 때의 이벤트

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

function OnClicked_RegisterQuantityBack(args)	-- 판매수량 뒷판 이벤트
	if winMgr:getWindow("Register_TitleTextImage_Sell"):isVisible() then
		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("Register_Quantity"):activate()
	end
end

function OnClicked_RegisterPriceBack(args)	-- 판매가격 뒷판 이벤트
	if winMgr:getWindow("Register_TitleTextImage_Sell"):isVisible() then
		CEGUI.toWindowEventArgs(args).window:deactivate()
		winMgr:getWindow("Register_Price"):activate()
	end
end


-- 판매등록 창의 상세내용 이벤트
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



-- 판매등록 창 입력완료 팝업창 Yes 클릭
function OnYes_Register_Complete()

	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnYes_Register_Complete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	-- 입력완료
	RequestUpload(	0, -- 등록 인덱스
					0, -- 번호(등록이라서 새로운 번호가 자동으로 들어감)
					TYPE_PRODUCT_ZEN,
					tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText())),
					tonumber(_extractNumbers(winMgr:getWindow("Register_Price"):getText())),
					winMgr:getWindow("Register_Title"):getText(),
					Register_GetDescribeText(),
					winMgr:getWindow("Register_Contact"):getText()
				 )
end

-- 판매등록 창 입력완료 팝업창 No 클릭
function OnNo_Register_Complete()

	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnNo_Register_Complete" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)

end

function OnClicked_Register_Complete(args)	-- 판매등록 창 입력완료 버튼

	-- 판매수량이 비어있을 때
	if winMgr:getWindow("Register_Quantity"):getText() == "" then
		ShowNotifyOKMessage_Lua(PreCreateString_4447)	--GetSStringInfo(LAN_ESCROW_ERRMSG_002)
		return
	end
	
	-- 판매수량이 자신의 젠 보유량보다 많을 때
	local quantity = tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText()))
	if quantity > GetMyCharacterZen() then
		ShowNotifyOKMessage_Lua(PreCreateString_4448)	--GetSStringInfo(LAN_ESCROW_ERRMSG_003)
		return
	end
	
	-- 판매가격이 비어있을 때
	if winMgr:getWindow("Register_Price"):getText() == "" then
		ShowNotifyOKMessage_Lua(PreCreateString_4449)	--GetSStringInfo(LAN_ESCROW_ERRMSG_004)
		return
	end
	
	local title = winMgr:getWindow("Register_Title"):getText()
	
	-- 제목이 10자 미만 일때
	if string.len(title) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4450)	--GetSStringInfo(LAN_ESCROW_ERRMSG_005)
		return
	end
	
	
	local describe = Register_GetDescribeText()
	
	-- 내용이 10자 미만 일때
	if string.len(describe) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4451)	--GetSStringInfo(LAN_ESCROW_ERRMSG_006)
		return
	end
	
	-- 제목이 필터에 걸렸을때
	local bFilter, filterChat = FindBadWord(title)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end

	-- 내용이 필터에 걸렸을때
	bFilter, filterChat = FindBadWord(describe)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end


	local message = string.format(PreCreateString_4453, CommatoMoneyStr(quantity))
									--GetSStringInfo(LAN_ESCROW_ASKMSG_001)
	
	-- 판매완료 확인
	ShowCommonAlertOkCancelBoxWithFunction("",	message, "OnYes_Register_Complete", "OnNo_Register_Complete")

end

function OnClicked_Register_Modify(args)	-- 판매등록 창 수정완료 버튼

	local title = winMgr:getWindow("Register_Title"):getText()
	
	-- 제목이 10자 미만 일때
	if string.len(title) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4450)	--GetSStringInfo(LAN_ESCROW_ERRMSG_005)
		return
	end

	local describe = Register_GetDescribeText()
	
	-- 내용이 10자 미만 일때
	if string.len(describe) < 10 then
		ShowNotifyOKMessage_Lua(PreCreateString_4451)	--GetSStringInfo(LAN_ESCROW_ERRMSG_006)
		return
	end
	
	-- 제목이 필터에 걸렸을때
	local bFilter, filterChat = FindBadWord(title)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end

	-- 내용이 필터에 걸렸을때
	bFilter, filterChat = FindBadWord(describe)
	if bFilter == false then
		ShowNotifyOKMessage_Lua(PreCreateString_4396)	--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_02)
		return
	end
	

	-- 수정
	RequestUpload(	1, -- 수정 인덱스
					tonumber(winMgr:getWindow("EscrowInfo_Number_" .. g_SelectedInfo):getText()), -- 번호
					TYPE_PRODUCT_ZEN,
					tonumber(_extractNumbers(winMgr:getWindow("Register_Quantity"):getText())),
					tonumber(_extractNumbers(winMgr:getWindow("Register_Price"):getText())),
					winMgr:getWindow("Register_Title"):getText(),
					Register_GetDescribeText(),
					winMgr:getWindow("Register_Contact"):getText()
				 )
end


function OnTextChanged_Register(args) -- 판매등록 창 판매수량, 가격 수정

	local window = CEGUI.toWindowEventArgs(args).window	
	
	local str = _extractNumbers(window:getText())
	
	if string.len(str) >= 10 and str ~= "1000000000" then
		Escrow_SetText(window, "1,000,000,000", ALIGN_RIGHT, 130, 0, 15)
	else
		Escrow_SetText(window, window:getText(), ALIGN_RIGHT, 130, 0, 15)
	end
end

