-- 
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

-- 현재 위치가 어딘지 확인해서..
local tMainWinName = {["err"] = 0, "MyRoom_", "Shop_"}
local MYROOM	= 1
local SHOP		= 2

local CurrentWinStr		= tMainWinName[CurrentPos]		-- CurrentPos는 마이룸과 샵에서 전역으로 사용하는 변수,
local limitationLevel	= 20

-- 랜탈 스킬 여부
local g_IsRentalSkill = false

--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 캐시충전, 쿠폰, 스킬트리버튼 - (스킬트리버튼이 결제 히스토리 버튼으로 바뀜)
--------------------------------------------------------------------
--local	tShopEtcButtonName	= {['err'] = 0, "Common_CashChargeBtn", "Common_CouponBtn", "Common_SkillTreeBtn" }
--local	tShopEtcButtonTexX	= {['err'] = 0,			0,					158,				316}
--local	tShopEtcButtonPosX	= {['err'] = 0,			100,				300,				500}
--local	tShopEtcButtonEvent	= {['err'] = 0, "Common_CashChargeBtnEvent", "Common_CouponBtnEvent", "Common_CashHistorytnEvent" }
--
--for i = 1, #tShopEtcButtonName do
--	mywindow = winMgr:createWindow("TaharezLook/Button", tShopEtcButtonName[i])
--	mywindow:setTexture("Normal", "UIData/my_room.tga", tShopEtcButtonTexX[i], 442)
--	mywindow:setTexture("Hover", "UIData/my_room.tga", tShopEtcButtonTexX[i], 481)
--	mywindow:setTexture("Pushed", "UIData/my_room.tga", tShopEtcButtonTexX[i], 520)
--	mywindow:setTexture("PushedOff", "UIData/my_room.tga", tShopEtcButtonTexX[i], 442)
--	mywindow:setTexture("Disabled", "UIData/my_room.tga", tShopEtcButtonTexX[i], 559)
--	mywindow:setWideType(6);
--	mywindow:setPosition(272 + 161 * (i - 1), 640)
--	mywindow:setSize(158, 39)
--	mywindow:setAlwaysOnTop(true)
--	mywindow:setZOrderingEnabled(false)
--	mywindow:subscribeEvent("Clicked", tShopEtcButtonEvent[i])
--	if i == 3 then 
--		winMgr:getWindow('Common_SkillTreeBtn'):setEnabled(true)
--	end
--	root:addChildWindow(mywindow)
--end
--
--if IsKoreanLanguage() then
--	winMgr:getWindow('Common_CashChargeBtn'):setEnabled(true)
--	winMgr:getWindow('Common_CouponBtn'):setVisible(false)
--	winMgr:getWindow('Common_SkillTreeBtn'):setVisible(false)
--elseif IsThaiLanguage() then
--	winMgr:getWindow('Common_CashChargeBtn'):setEnabled(true)
--	winMgr:getWindow('Common_CouponBtn'):setVisible(true)
--	winMgr:getWindow('Common_SkillTreeBtn'):setEnabled(true)
--elseif IsEngLanguage() then
--	winMgr:getWindow('Common_CashChargeBtn'):setVisible(false)
--	winMgr:getWindow('Common_CashChargeBtn'):setEnabled(false)
--	winMgr:getWindow('Common_CouponBtn'):setVisible(true)
--	winMgr:getWindow('Common_CouponBtn'):setEnabled(true)
--	winMgr:getWindow('Common_SkillTreeBtn'):setVisible(false)
--	winMgr:getWindow('Common_SkillTreeBtn'):setEnabled(false)
--elseif IsGSPLanguage() then
--	winMgr:getWindow('Common_CashChargeBtn'):setVisible(true)
--	winMgr:getWindow('Common_CashChargeBtn'):setEnabled(true)
--	winMgr:getWindow('Common_CouponBtn'):setVisible(true)
--	winMgr:getWindow('Common_CouponBtn'):setEnabled(true)
--	winMgr:getWindow('Common_SkillTreeBtn'):setVisible(false)
--	winMgr:getWindow('Common_SkillTreeBtn'):setEnabled(false)	
--else
--	winMgr:getWindow('Common_CashChargeBtn'):setEnabled(false)
--	winMgr:getWindow('Common_CouponBtn'):setVisible(true)
--	winMgr:getWindow('Common_SkillTreeBtn'):setEnabled(false)
--end




--------------------------------------------------------------------
-- 캐시 충전 버튼이벤트
--------------------------------------------------------------------
function Common_CashChargeBtnEvent(args)
	if IsGSPLanguage() then
		ShowCashRefillUI()
	else
		ClickCashCharge()
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
		root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg') );
	end
end

function Common_CashChargeClose()
	if winMgr:getWindow('CommonAlertAlphaImg') ~= nil then
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	end
end

--------------------------------------------------------------------
-- 쿠폰 버튼이벤트
--------------------------------------------------------------------
function Common_CouponBtnEvent(args)
	CouponShow()
end

--------------------------------------------------------------------
-- 캐시 결재 히스토리 버튼이벤트
--------------------------------------------------------------------
function Common_CashHistorytnEvent(args)
	ClickCashHistory()
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg') );
end

function Common_CashHistoryClose()
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
end

--------------------------------------------------------------------
-- 캐시 판매 페이지 IN GSP
--------------------------------------------------------------------
local START_POS_X = 0;
local START_POS_Y = 0;

function CreateCashSailPage()
	--------------------------------------------------------------------
	-- 충전 페이지 BG
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CashSaillPageBG")
	mywindow:setTexture("Enabled", "UIData/my_room6.tga", 135, 0)
	mywindow:setTexture("Disabled", "UIData/my_room6.tga", 135, 0)
	mywindow:setPosition(START_POS_X + 0, START_POS_Y + 0)
	mywindow:setSize(770, 346)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
end

function ShowCashSailPage()
	DebugStr("ShowCashSailPage!!!")
	if winMgr:getWindow('CashSaillPageBG') ~= nil then
		DebugStr("ShowCashSailPage2!!!")
		winMgr:getWindow('CashSaillPageBG'):setVisible(true)
		winMgr:getWindow('CashSaillPageBG'):setEnabled(true)
		root:addChildWindow(winMgr:getWindow('CashSaillPageBG'));
	end
end

if IsGSPLanguage() then
	CreateCashSailPage()
end
function ShowCashRefillUI()
	DebugStr("ShowCashRefillUI")
	ShowCashSailPage()
end

--------------------------------------------------------------------

-- 스킬 트리 관련

--------------------------------------------------------------------
local BaseMode	  = 1
local StreetMode1 = 2
local StreetMode2 = 3
local RushMode	  = 4
local DirtyXMode  = 5
local KungPuMode  = 6
local NinjaMode	  = 7



local CurrentPromotion	= GetMyPromotionIndex()		-- 현재 내 직업 알아온다.


local tPromotionIndex = {['err']=0,}
local tSkillTreeMainImgName	=  {['err']=0, "party002.tga", "party002.tga", "party002.tga", "skillshop002.tga", "skillshop003.tga",  "party002.tga",  "party002.tag"}
local tSkillTreeMainImgTexY	=  {['err']=0, 		334,			334,			334,				0,				0,					334		  ,		 334	   }
-- 기본
tPromotionIndex[g_CLASS_STREET]		 = BaseMode
tPromotionIndex[g_CLASS_RUSH]		 = BaseMode
-- 스트리트1
tPromotionIndex[g_CLASS_TAEKWONDO]	 = StreetMode2
-- 스트리트2
tPromotionIndex[g_CLASS_BOXING]		 = StreetMode2
tPromotionIndex[g_CLASS_CAPOERA]	 = StreetMode2
tPromotionIndex[g_CLASS_MUAYTHAI]	 = StreetMode2
--러시ㅊ
tPromotionIndex[g_CLASS_JUDO]		 = RushMode
tPromotionIndex[g_CLASS_PROWRESTLING] = RushMode
tPromotionIndex[g_CLASS_HAPGIDO]	 = RushMode
tPromotionIndex[g_CLASS_SAMBO]		 = RushMode


tPromotionIndex[g_CLASS_S_DIRTYX]	 = DirtyXMode
tPromotionIndex[g_CLASS_R_DIRTYX]	 = DirtyXMode

tPromotionIndex[g_CLASS_S_SUMO]		 = DirtyXMode
tPromotionIndex[g_CLASS_R_SUMO]		 = DirtyXMode

tPromotionIndex[g_CLASS_S_KUNGFU]	 = KungPuMode
tPromotionIndex[g_CLASS_R_KUNGFU]	 = KungPuMode

tPromotionIndex[g_CLASS_S_NINJA]	 = NinjaMode
tPromotionIndex[g_CLASS_R_NINJA]	 = NinjaMode





-- StreetMode1
local Mode1Grade1 = {['err']=0,	{['err']=0,	34},					  280}
local Mode1Grade2 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569}, 414}
local Mode1Grade3 = {['err']=0,	{['err']=0,	157, 260},				  195}
local Mode1Grade4 = {['err']=0,	{['err']=0,	383, 486, 589, 692},	  268}
local Mode1Grade5 = {['err']=0,	{['err']=0,	383, 486, 589, 692},	  122}
local BackPosList1 = {['err']=0, Mode1Grade1, Mode1Grade2, Mode1Grade3, Mode1Grade4, Mode1Grade5}
-- x = Mode1Grade1[1][x]
-- y = Mode1Grade1[2]

local Mode2Grade1 = {['err']=0,	{['err']=0,	34},								280}
local Mode2Grade2 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775}, 414}
local Mode2Grade3 = {['err']=0,	{['err']=0,	157, 260},							195}
local Mode2Grade4 = {['err']=0,	{['err']=0,	383, 486, 589, 692},				268}
local Mode2Grade5 = {['err']=0,	{['err']=0,	383, 486, 589, 692},				122}
local BackPosList2 = {['err']=0, Mode2Grade1, Mode2Grade2, Mode2Grade3, Mode2Grade4, Mode2Grade5}

local Mode3Grade1 = {['err']=0,	{['err']=0,	34},									 267}
local Mode3Grade2 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775, 878}, 437}
local Mode3Grade3 = {['err']=0,	{['err']=0,	157, 260, 363},							 267}
local Mode3Grade4 = {['err']=0,	{['err']=0,	486, 589, 692, 795},					 327}
local Mode3Grade5 = {['err']=0,	{['err']=0,	486, 589, 692, 795},					 207}
local Mode3Grade6 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775, 878}, 96}
local BackPosList3 = {['err']=0, Mode3Grade1, Mode3Grade2, Mode3Grade3, Mode3Grade4, Mode3Grade5, Mode3Grade6}

local Mode4Grade1 = {['err']=0,	{['err']=0,	34},									 267}
local Mode4Grade2 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775, 878}, 437}
local Mode4Grade3 = {['err']=0,	{['err']=0,	157, 260, 363, 466},					 267}
local Mode4Grade4 = {['err']=0,	{['err']=0,	589, 692, 795, 898},					 327}
local Mode4Grade5 = {['err']=0,	{['err']=0, 589, 692, 795, 898},					 207}
local Mode4Grade6 = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775, 878}, 96}
local BackPosList4 = {['err']=0, Mode4Grade1, Mode4Grade2, Mode4Grade3, Mode4Grade4, Mode4Grade5, Mode4Grade6}


-- 쿵푸
local Mode5Grade1  = {['err']=0,	{['err']=0,	34},								280}		
local Mode5Grade2  = {['err']=0,	{['err']=0,	157, 260, 363, 466, 569, 672, 775}, 414}
local Mode5Grade3  = {['err']=0,	{['err']=0,	157, 260},							195}
local Mode5Grade4  = {['err']=0,	{['err']=0,	383, 486, 589, 692, 793},			268}
local Mode5Grade5  = {['err']=0,    {['err']=0,	383, 486, 589, 692, 793},			122}
local BackPosList5 = {['err']=0, Mode5Grade1, Mode5Grade2, Mode5Grade3, Mode5Grade4, Mode5Grade5}

local PosListTable = {['err']=0, BackPosList1, BackPosList1, BackPosList2, BackPosList3, BackPosList4, BackPosList5, BackPosList5}


-- 인덱스

-- Base
local tBaseGrade1 = {['err']=0,	810002}
local tBaseGrade2 = {['err']=0,	810005, 810003, 810001, 810034, 810004}
local tBaseGrade3 = {['err']=0,	811013, 811012}
local tBaseGrade4 = {['err']=0,	813039, 811009, 813041, 812048}
local tBaseGrade5 = {['err']=0,	813042, 811010, 813043, 812049}
local tBase		  = {['err']=0, tBaseGrade1, tBaseGrade2, tBaseGrade3, tBaseGrade4, tBaseGrade5 }

-- 태권도--------------------------------------------
local tTakwondoGrade1 = {['err']=0,	810003}
local tTakwondoGrade2 = {['err']=0,	810005, 810002, 810001, 810034, 810004, 810006, 810007}
local tTakwondoGrade3 = {['err']=0,	811012, 811013}
local tTakwondoGrade4 = {['err']=0,	813039, 811009, 813041, 812048}
local tTakwondoGrade5 = {['err']=0,	813042, 811010, 813043, 812049}
local tTakwondo		= {['err']=0, tTakwondoGrade1, tTakwondoGrade2, tTakwondoGrade3, tTakwondoGrade4, tTakwondoGrade5 }

-- 복싱----------------------------------------------
local tBoxingGrade1 = {['err']=0,	820001}
local tBoxingGrade2 = {['err']=0,	820006, 820007, 820005, 820035, 820002, 820003, 820004}
local tBoxingGrade3 = {['err']=0,	821010, 821009}
local tBoxingGrade4 = {['err']=0,	823039, 821012, 823041, 822048}
local tBoxingGrade5 = {['err']=0,	823043, 821013, 823042, 822049}
local tBoxing		= {['err']=0, tBoxingGrade1, tBoxingGrade2, tBoxingGrade3, tBoxingGrade4, tBoxingGrade5 }

-- 카포에라------------------------------------------
local tCapoeraGrade1 = {['err']=0,	840001}
local tCapoeraGrade2 = {['err']=0,	840005, 840002, 840003, 840034, 840004, 840006, 840007}
local tCapoeraGrade3 = {['err']=0,	841013, 841010}
local tCapoeraGrade4 = {['err']=0,	843039, 841012, 843041, 842048}
local tCapoeraGrade5 = {['err']=0,	843043, 841009, 843042, 842049}
local tCapoera	=  {['err']=0, tCapoeraGrade1, tCapoeraGrade2, tCapoeraGrade3, tCapoeraGrade4, tCapoeraGrade5 }

-- 무에타이------------------------------------------
local tMuaythaiGrade1 = {['err']=0,	830005}
local tMuaythaiGrade2 = {['err']=0,	830001, 830006, 830007, 830034, 830003, 830002, 830004}
local tMuaythaiGrade3 = {['err']=0,	831012, 831013}
local tMuaythaiGrade4 = {['err']=0,	833039, 831010, 833041, 832048}
local tMuaythaiGrade5 = {['err']=0,	833043, 831009, 833042, 832049}
local tMuaythai	=  {['err']=0, tMuaythaiGrade1, tMuaythaiGrade2, tMuaythaiGrade3, tMuaythaiGrade4, tMuaythaiGrade5 }

-- 유도----------------------------------------------
local tJudoGrade1 = {['err']=0,	921013}
local tJudoGrade2 = {['err']=0,	920001, 920002, 920003, 920005, 920034, 920006, 920007, 920004}
local tJudoGrade3 = {['err']=0,	921010, 921016, 921012}
local tJudoGrade4 = {['err']=0,	923039, 921015, 923041, 922048}
local tJudoGrade5 = {['err']=0,	923042, 921009, 923043, 922049}
local tJudoGrade6 = {['err']=0,	921026, 921027, 921029, 921028, 921030, 921031, 921032, 921033}
local tJudo	=  {['err']=0, tJudoGrade1, tJudoGrade2, tJudoGrade3, tJudoGrade4, tJudoGrade5, tJudoGrade6 }

-- 레슬링--------------------------------------------
local tProwrestlingGrade1 = {['err']=0,	911012}
local tProwrestlingGrade2 = {['err']=0,	910003, 910001, 910004, 910002, 910034, 910005, 910006, 910007}
local tProwrestlingGrade3 = {['err']=0,	911016, 911009, 911010}
local tProwrestlingGrade4 = {['err']=0,	913039, 911013, 913041, 912048}
local tProwrestlingGrade5 = {['err']=0,	913043, 911015, 913042, 912049}
local tProwrestlingGrade6 = {['err']=0,	911026, 911027, 911029, 911028, 911030, 911031, 911032, 911033}
local tProwrestling	=  {['err']=0, tProwrestlingGrade1, tProwrestlingGrade2, tProwrestlingGrade3, tProwrestlingGrade4, tProwrestlingGrade5, tProwrestlingGrade6 }

-- 합기도--------------------------------------------
local tHapgidoGrade1 = {['err']=0,	931013}
local tHapgidoGrade2 = {['err']=0,	930002, 930003, 930001, 930004, 930034, 930005, 930006, 930007}
local tHapgidoGrade3 = {['err']=0,	931010, 931012, 931009}
local tHapgidoGrade4 = {['err']=0,	933039, 931015, 933041, 932048}
local tHapgidoGrade5 = {['err']=0,	933042, 931016, 933043, 932049}
local tHapgidoGrade6 = {['err']=0,	931026, 931028, 931029, 931027, 931030, 931031, 931032, 931033}
local tHapgido	=  {['err']=0, tHapgidoGrade1, tHapgidoGrade2, tHapgidoGrade3, tHapgidoGrade4, tHapgidoGrade5, tHapgidoGrade6 }

-- 삼보----------------------------------------------
local tSamboGrade1 = {['err']=0,	941013}
local tSamboGrade2 = {['err']=0,	940002, 940003, 940004, 940005, 940034, 940001, 940006, 940007}
local tSamboGrade3 = {['err']=0,	941009, 941010, 941012}
local tSamboGrade4 = {['err']=0,	943041, 941015, 943039, 942048}
local tSamboGrade5 = {['err']=0,	943042, 941016, 943043, 942049}
local tSamboGrade6 = {['err']=0,	941026, 941027, 941028, 941029, 941030, 941031, 941033, 941032}
local tSambo	=  {['err']=0, tSamboGrade1, tSamboGrade2, tSamboGrade3, tSamboGrade4, tSamboGrade5, tSamboGrade6 }

-- Dirty-X----------------------------------------------
tDirtyXGrade1 = {['err']=0,	710000}
tDirtyXGrade2 = {['err']=0,	710001, 710004, 710005, 710003, 710034, 710002, 710006, 710007}
tDirtyXGrade3 = {['err']=0,	711015, 711010, 711009, 711012}
tDirtyXGrade4 = {['err']=0,	713039, 711013, 713041, 712048}
tDirtyXGrade5 = {['err']=0,	713042, 711016, 713043, 712049}
tDirtyXGrade6 = {['err']=0,	711026, 711027, 711028, 711029, 711030, 711031, 711033, 711032}
local tDirtyX	=  {['err']=0, tDirtyXGrade1, tDirtyXGrade2, tDirtyXGrade3, tDirtyXGrade4, tDirtyXGrade5, tDirtyXGrade6 }


-- 스모----------------------------------------------
local tSumoGrade1 = {['err']=0,	950000}
local tSumoGrade2 = {['err']=0,	950001, 950004, 950005, 950003, 950034, 950002, 950006, 950007}
local tSumoGrade3 = {['err']=0,	951015, 951010, 951009, 951012}
local tSumoGrade4 = {['err']=0,	953039, 951013, 953042, 952048}
local tSumoGrade5 = {['err']=0,	953041, 951016, 953043, 952049}
local tSumoGrade6 = {['err']=0,	951026, 951027, 951028, 951029, 951030, 951031, 951032, 951033}
local tSumo	=  {['err']=0, tSumoGrade1, tSumoGrade2, tSumoGrade3, tSumoGrade4, tSumoGrade5, tSumoGrade6 }


-- 쿵푸----------------------------------------------
local tKungFuGrade1 = {['err']=0,	960005} 
local tKungFuGrade2 = {['err']=0,	960001, 960006, 960007, 960034, 960003, 960002, 960004}
local tKungFuGrade3 = {['err']=0,	961012, 961013}
local tKungFuGrade4 = {['err']=0,	963043, 961009 ,961010, 963042, 962048}
local tKungFuGrade5 = {['err']=0,	963039, 961015, 963041, 961016, 962049}
local tKungFu	=  {['err']=0, tKungFuGrade1, tKungFuGrade2, tKungFuGrade3, tKungFuGrade4, tKungFuGrade5}

-- 닌자----------------------------------------------
local tNinjaGrade1 = {['err']=0,	970005} 
local tNinjaGrade2 = {['err']=0,	970001, 970006, 970007, 970008, 970003, 970002, 970004}
local tNinjaGrade3 = {['err']=0,	970012, 970013}
local tNinjaGrade4 = {['err']=0,	970017, 970010, 970011, 970016, 970021}
local tNinjaGrade5 = {['err']=0,	970018, 970014 ,970019, 970015, 970020}						
local tNinja	=  {['err']=0, tNinjaGrade1, tNinjaGrade2, tNinjaGrade3, tNinjaGrade4, tNinjaGrade5}




local tPromotionTable = {['err']=0, [0]=tBase, tBase, tTakwondo, tJudo, tBoxing, tProwrestling, tCapoera, tHapgido, tMuaythai, tSambo, tDirtyX, tDirtyX, tSumo, tSumo, tKungFu, tKungFu, tNinja, tNinja }



local tPromotionName = {['err']=0, [0]=	COMMON_STRING_STREET, COMMON_STRING_RUSH, COMMON_STRING_TAEKWONDO, COMMON_STRING_JUDO, COMMON_STRING_BOXING, 
										COMMON_STRING_PROWRESTLING, COMMON_STRING_CAPOERA, COMMON_STRING_HAPGIDO, COMMON_STRING_MUAYTHAI, COMMON_STRING_SAMBO,
										COMMON_STRING_DIRTYX, COMMON_STRING_DIRTYX, COMMON_STRING_SUMO, COMMON_STRING_SUMO, COMMON_STRING_KUNGFU, COMMON_STRING_KUNGFU, COMMON_STRING_NINJA, COMMON_STRING_NINJA }

local SkillInfoTable = {['err']=0, 0, "", ""}

--------------------------------------------------------------------
-- 스킬트리 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Common_SkillTreeVirtual")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(10, 10)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Common_SkillTreeBack")
mywindow:setTexture("Enabled", "UIData/skillshop002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/skillshop002.tga", 0, 0)
mywindow:setPosition(15, 24)
mywindow:setSize(994, 563)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow(CurrentWinStr.."AllBackImg"):addChildWindow(mywindow)


tTreeBaseText = {['err'] = 0, "TreeBaseLevel", "TreeBaseFighter", "TreeBaseClass"}
tTreeBasePosX = {['err'] = 0,		455,		586, 832}
tTreeBaseSizeX = {['err'] = 0,		40,			150, 125}

for i = 1, #tTreeBaseText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tTreeBaseText[i])
	--mywindow:setTexture("Enabled", "UIData/nm1.tga", 0, 0)
	--mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 0)
	mywindow:setPosition(tTreeBasePosX[i], 30)
	mywindow:setSize(tTreeBaseSizeX[i], 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTextExtends("aa", g_STRING_FONT_GULIMCHE,14, 7, 150, 252, 255,  1,  255,255,255,255);
	winMgr:getWindow('Common_SkillTreeBack'):addChildWindow(mywindow)
end

local name, money, level, promotion, styoe, type, sp, hp, exp = GetMyInfo(false)

winMgr:getWindow("TreeBaseLevel"):setTextExtends(level, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  255,255,255,255);
winMgr:getWindow("TreeBaseFighter"):setTextExtends(name, g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  255,255,255,255);
winMgr:getWindow("TreeBaseClass"):setTextExtends(tPromotionName[CurrentPromotion], g_STRING_FONT_GULIMCHE,14, 255, 255, 255, 255,  0,  255,255,255,255);

--------------------------------------------------------------------
-- 스킬트리 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Common_SkillTreeCloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(966, 5)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseSkillTreeButtonEvent")
winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 스킬트리 남는 스킬 담을 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StreetPlusSkillBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(649, 415)
mywindow:setSize(203, 80)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)

for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StreetPlus1"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 146, 899)
	mywindow:setPosition(0 + (i-1) * 103, 38)
	mywindow:setSize(23, 4)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("StreetPlusSkillBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "StreetPlus2"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 170, 899)
	mywindow:setPosition(23 + (i-1) * 103, 0)
	mywindow:setSize(80, 80)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("StreetPlusSkillBack"):addChildWindow(mywindow)
end


--800},			268}
--local Mode5Grade5  = {['err']=0,    {['err']=0,	383, 486, 589, 692, 800},			122}
--------------------------------------------------------------------
-- 쿵푸 남는 스킬 담을 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "KungpuPlusSkillBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(770, 122)
mywindow:setSize(103, 280)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)

for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "KungpuPlus1"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 146, 899)
	mywindow:setPosition(0 , 38 + (i* 146)-146)
	mywindow:setSize(23, 4)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("KungpuPlusSkillBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "KungpuPlus2"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 170, 899)
	mywindow:setPosition(23, (i* 146)-146)
	mywindow:setSize(80, 80)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("KungpuPlusSkillBack"):addChildWindow(mywindow)
end
--------------------------------------------------------------------
-- 닌자 남는 스킬 담을 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NinjaPlusSkillBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(770, 122)
mywindow:setSize(103, 280)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)

for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NinjaPlus1"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 146, 899)
	mywindow:setPosition(0 , 38 + (i* 146)-146)
	mywindow:setSize(23, 4)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NinjaPlusSkillBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NinjaPlus2"..i)
	mywindow:setTexture("Disabled", "UIData/party002.tga", 170, 899)
	mywindow:setPosition(23, (i* 146)-146)
	mywindow:setSize(80, 80)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NinjaPlusSkillBack"):addChildWindow(mywindow)
end
--------------------------------------------------------------------
-- 스킬아이템 툴팁이미지.
--------------------------------------------------------------------
-- 메인 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeToolTipFrame")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 757, 551)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 757, 551)
mywindow:setPosition(0, 0)
mywindow:setSize(235, 310)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--mywindow:subscribeEvent("EndRender", "TreeToolTipRender")
root:addChildWindow(mywindow)

-- 툴팁레벨 텍스트 
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeToolTipLevelText")
mywindow:setPosition(5, 15)
--mywindow:setPosition(8, 20)
mywindow:setSize(50, 15)
mywindow:setViewTextMode(1)
mywindow:setAlign(0)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends("Lv.30", g_STRING_FONT_GULIMCHE,12, 7, 150, 252, 255,  0,  255,255,255,255);
winMgr:getWindow('TreeToolTipFrame'):addChildWindow(mywindow)

-- 툴팁 스킬이름 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeToolTipNameText")
mywindow:setPosition(40, 15)
mywindow:setSize(165, 15)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends("Lv.30", g_STRING_FONT_GULIMCHE,14, 7, 150, 252, 255,  0,  255,255,255,255);
winMgr:getWindow('TreeToolTipFrame'):addChildWindow(mywindow)


-- 툴팁 스킬설명 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeToolTipDescText")
--mywindow:setTexture("Enabled", "UIData/nm1.tga", 0, 0)
--mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 0)
mywindow:setPosition(9, 226)
mywindow:setSize(216, 75)
mywindow:setViewTextMode(1)
mywindow:setAlign(0)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends("Lv.30asdwqdwqdwqdwq", g_STRING_FONT_GULIMCHE,12, 7, 150, 252, 255,  0,  255,255,255,255);
winMgr:getWindow('TreeToolTipFrame'):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/Titlebar", "TreeToolTipFrame_TitleBar")
mywindow:setPosition(0, 0)
mywindow:setSize(1, 1)
winMgr:getWindow("TreeToolTipFrame"):addChildWindow(mywindow)


--[[
--------------------------------------------------------------------
-- 스킬트리 이미지 세팅
--------------------------------------------------------------------
function SetSkillTreeWindow(Mode)
	winMgr:getWindow("StreetPlusSkillBack"):setVisible(false)
	if Mode == BaseMode then
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)		
	elseif Mode == StreetMode1 then
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	elseif Mode == StreetMode2 then		
		winMgr:getWindow("StreetPlusSkillBack"):setVisible(true)
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	elseif Mode == RushMode then
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	elseif Mode == DirtyXMode then
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	elseif Mode == KungPuMode then
		winMgr:getWindow("StreetPlusSkillBack"):setVisible(true)
		winMgr:getWindow("KungpuPlusSkillBack"):setVisible(true)
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	elseif Mode == NinjaMode then
		winMgr:getWindow("StreetPlusSkillBack"):setVisible(true)
		winMgr:getWindow("NinjaPlusSkillBack"):setVisible(true)
		winMgr:getWindow("Common_SkillTreeBtn"):setEnabled(false)
	end
	winMgr:getWindow("Common_SkillTreeBack"):setTexture("Enabled", "UIData/"..tSkillTreeMainImgName[Mode], 0, tSkillTreeMainImgTexY[Mode])
	winMgr:getWindow("Common_SkillTreeBack"):setTexture("Disabled", "UIData/"..tSkillTreeMainImgName[Mode], 0, tSkillTreeMainImgTexY[Mode])
end
--]]

--------------------------------------------------------------------
-- 스킬트리 처음 시작부분
--------------------------------------------------------------------
function InitSkillTree()
	--SetSkillTreeWindow(tPromotionIndex[CurrentPromotion])	-- 스킬트리 이미지 세팅

	local tPosTable	= PosListTable[tPromotionIndex[CurrentPromotion]]	-- 직업에 맞는 윈도우 위치
	
	for i = 1, #tPromotionTable[CurrentPromotion] do
		for j = 1, #tPromotionTable[CurrentPromotion][i] do
			local FileName, Level, attach = Toc_GetTreeSkillInfo(g_CLASS_TAEKWONDO, tPromotionTable[CurrentPromotion][i][j])
			local a = 0
			-- 적용 안되는 컨텐츠 일때 -- 레벨제한을 둬서 해당레벨보다 높을때는 안보이게
			if CheckfacilityData(FACILITYCODE_SKILL_TREE) ~= 1 and Level > limitationLevel then
			--if a == 0 then
				mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tree"..i..j)
				mywindow:setTexture("Enabled", "UIData/party002.tga", 250, 899)
				mywindow:setTexture("Disabled", "UIData/party002.tga", 250, 899)
				mywindow:setPosition(tPosTable[i][1][j], tPosTable[i][2])
				mywindow:setSize(80, 80)
				mywindow:setVisible(true)
				mywindow:setEnabled(false)
				mywindow:setAlwaysOnTop(true)
				mywindow:setZOrderingEnabled(false)
				winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)					
			else														-- 정상적으로 적용이 될때
				SkillIndex = tPromotionTable[CurrentPromotion][i][j]-- % 100
			
				mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Tree"..i..j)
				mywindow:setTexture("Enabled", FileName, 0, 0)
				mywindow:setTexture("Disabled", FileName, 0, 0)
				mywindow:setPosition(tPosTable[i][1][j] + 11, tPosTable[i][2] + 10)
				mywindow:setSize(100, 100)
				mywindow:setVisible(true)
				mywindow:setEnabled(false)
				mywindow:setScaleWidth(150);
				mywindow:setScaleHeight(150);
				mywindow:setAlwaysOnTop(true)
				mywindow:setZOrderingEnabled(false)
				winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)
				
							
				mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeMouseEvent"..i..j)
				mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
				mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
				mywindow:setPosition(tPosTable[i][1][j] + 2, tPosTable[i][2] + 2)
				mywindow:setSize(76, 76)
				mywindow:setVisible(true)
				mywindow:setAlwaysOnTop(true)
				mywindow:setZOrderingEnabled(true)
				mywindow:setUserString("SkillIndex", SkillIndex)			
				mywindow:subscribeEvent("MouseEnter", "TreeMouseEnterEvent")
				mywindow:subscribeEvent("MouseLeave", "TreeMouseLeaveEvent")
				winMgr:getWindow("Common_SkillTreeBack"):addChildWindow(mywindow)
							
				
				mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeLevel"..i..j)
				mywindow:setPosition(25, 62)
				mywindow:setSize(50, 15)
				mywindow:setViewTextMode(1)
				mywindow:setAlign(0)
				mywindow:setLineSpacing(2)
				mywindow:setEnabled(false)
				mywindow:setZOrderingEnabled(false)
				if level < Level then
					mywindow:setTextExtends("Lv."..Level, g_STRING_FONT_GULIMCHE,12, 225,26,40, 255,  0,  255,255,255,255);
				else
					mywindow:setTextExtends("Lv."..Level, g_STRING_FONT_GULIMCHE,12, 255,198,30, 255,  0,  255,255,255,255);
				end			
				winMgr:getWindow("TreeMouseEvent"..i..j):addChildWindow(mywindow)
				
				mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreePossesion"..i..j)
				mywindow:setTexture("Enabled", "UIData/skillshop002.tga", 1, 564)
				mywindow:setTexture("Disabled", "UIData/skillshop002.tga", 1, 564)
				mywindow:setPosition(0,0)
				mywindow:setSize(76, 76)
				mywindow:setVisible(false)
				mywindow:setEnabled(false)
				mywindow:setAlwaysOnTop(true)
				mywindow:setZOrderingEnabled(false)
				winMgr:getWindow("TreeMouseEvent"..i..j):addChildWindow(mywindow)
				
				-- rental 
				mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreePossesionRental"..i..j)
				mywindow:setTexture("Enabled",  "UIData/ItemUIData/Insert/Time.tga", 0, 0)
				mywindow:setTexture("Disabled", "UIData/ItemUIData/Insert/Time.tga", 0, 0)
				mywindow:setPosition(0,0)
				mywindow:setSize(76, 76)
				mywindow:setVisible(false)
				mywindow:setEnabled(false)
				mywindow:setAlwaysOnTop(true)
				mywindow:setZOrderingEnabled(false)
				winMgr:getWindow("TreeMouseEvent"..i..j):addChildWindow(mywindow)
							
			end
		end
	end

end


function TreeMouseEnterEvent(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	
	local Number = local_window:getUserString("SkillIndex")
	
	-- 현재 랜탈 스킬이라면 +3000000을 더한다.
--	if g_IsRentalSkill == true then
--		Number = Number + 3000000
--	end

	root:addChildWindow(winMgr:getWindow("TreeToolTipFrame"))
	winMgr:getWindow("TreeToolTipFrame"):setVisible(true)
	local x, y = GetBasicRootPoint(local_window)
	
	if x + 235 > g_MAIN_WIN_SIZEX then
		x = x - 235
	else
		x = x + 80
	end
	if y + 310 > g_MAIN_WIN_SIZEY then
		y = g_MAIN_WIN_SIZEY - 310
	end
	winMgr:getWindow("TreeToolTipFrame"):setPosition(x, y)

	-- 동영상 플레이
	ToC_SettingPreviewSkillRect(x+8, y+50, 217, 164);
	ToC_SelectedSkillContent(Number)
	
	DebugStr(Number)

	local level, Name, Desc = ToC_GetMouseEnterSkillInfo(Number)
	local	skillkind, desc = DescDivide(Desc)
	desc = AdjustString(g_STRING_FONT_GULIMCHE, 12, desc, 200)
	winMgr:getWindow('TreeToolTipLevelText'):setTextExtends("Lv."..level, g_STRING_FONT_GULIMCHE,12, 7, 150, 252, 255,  0,  255,255,255,255);
	winMgr:getWindow('TreeToolTipNameText'):setTextExtends(Name, g_STRING_FONT_GULIMCHE,12, 255,198,30, 255,  0,  255,255,255,255);
	winMgr:getWindow('TreeToolTipDescText'):setTextExtends(desc, g_STRING_FONT_GULIMCHE,12, 255, 255, 255, 255,  0,  255,255,255,255);
		
end







function TreeMouseLeaveEvent(args)
	winMgr:getWindow("TreeToolTipFrame"):setVisible(false)
	ToC_HidePreviewSkill()
end



--------------------------------------------------------------------
-- 스킬트리 버튼이벤트 
--------------------------------------------------------------------
function Common_SkillTreeBtnEvent(args)
	if CurrentPos == MYROOM then
		winMgr:getWindow("MyRoom_Skill"):setProperty("Selected", "true");
		--CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Skill"):setSelected(true)
	elseif CurrentPos == SHOP then
		winMgr:getWindow("Shop_SkillTab"):setProperty("Selected", "true");
		ToC_HidePreviewSkill()
		--CEGUI.toRadioButton(winMgr:getWindow("Shop_SkillTab"):setSelected(true)
	end
	winMgr:getWindow(CurrentWinStr.."AllBackImg"):addChildWindow(winMgr:getWindow("Common_SkillTreeBack"))
	winMgr:getWindow("Common_SkillTreeBack"):setVisible(true)
	winMgr:getWindow("Common_SkillTreeVirtual"):setVisible(true)
	
	-- 보유스킬 표시
	for i = 1, #tPromotionTable[CurrentPromotion] do
		for j = 1, #tPromotionTable[CurrentPromotion][i] do
			if winMgr:getWindow("TreePossesion"..i..j) then
				
				-- ToC_GetPossesionTreeSkill의 return 값
				-- 0 = 실패
				-- 1 = 보유하고 있는 일반스킬
				-- 2 = 보유하고 있는 랜탈스킬
				local possesion = ToC_GetPossesionTreeSkill(tPromotionTable[CurrentPromotion][i][j])
				
				winMgr:getWindow("TreePossesionRental"..i..j):setVisible(false)
				
				if possesion == 1 then
					winMgr:getWindow("TreePossesion"..i..j):setVisible(true)
					g_IsRentalSkill = false
				elseif possesion == 2 then
					winMgr:getWindow("TreePossesion"..i..j):setVisible(true)
					winMgr:getWindow("TreePossesionRental"..i..j):setVisible(true)
					g_IsRentalSkill = true
				else
					winMgr:getWindow("TreePossesion"..i..j):setVisible(false)
				end
			end
		end
	end
end

--------------------------------------------------------------------
-- 스킬트리 닫기버튼이벤트
--------------------------------------------------------------------
function CloseSkillTreeButtonEvent(args)
	winMgr:getWindow("Common_SkillTreeBack"):setVisible(false)
	winMgr:getWindow("Common_SkillTreeVirtual"):setVisible(false)
	
	winMgr:getWindow("TreeToolTipFrame"):setVisible(false)
	ToC_HidePreviewSkill()
end


function DescDivide(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--스킬종류
	local _DetailDesc = "";		--스킬설명
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
		
	end
	
	return _SkillKind, _DetailDesc
end


InitSkillTree()		-- 스킬트리 시작

RegistEscEventInfo("Common_SkillTreeVirtual", "CloseSkillTreeButtonEvent")		-- esc키

DebugStr("마지막 라인")