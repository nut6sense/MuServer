--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer();
guiSystem:setGUISheet(root)
root:activate()

local CM_String_Step					= PreCreateString_1031 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_14)			-- %d 단계
local CM_String_CanPlayAfterComplete	= PreCreateString_1032 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_15)			-- 완료 후 미션 진행 가능
local CM_String_RewardText1				= PreCreateString_1034 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_17)		-- 일정기간동안 사용할 수 있는 스킬을 받을 수 있습니다.
local CM_String_RewardText2				= PreCreateString_1035 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_18)		-- 게임 내에서 사용되는 돈으로 아이템을 구입하거나 컨텐츠를 이용할 때 사용됩니다.
local CM_String_RewardText3				= PreCreateString_1036 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_19)		-- 광장에 있는 아케이드 상인(유키)에게 가면 아이템을 구입할 수 있습니다.
local CM_String_RewardText4				= PreCreateString_1037 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_20)		-- 레벨업에 필요한 경험치가 증가합니다.
local CM_String_RewardText5				= PreCreateString_1038 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_21)		-- 아케이드에서 사용하는 라이프가 증가합니다
local CM_String_RewardText6				= PreCreateString_1039 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_22)		-- 축하합니다.\n챌린지미션 챕터1. 체험하라를 완료하셨습니다.\n이제 챕터2. 달성하라에 도전하시기 바랍니다.\n다양한 보상이 기다리고 있습니다.
local CM_String_Present					= PreCreateString_1692 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_42)		-- 현재
local CM_String_Goal					= PreCreateString_1033 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_16)		-- 목표
local CM_String_CostumGet				= PreCreateString_1693 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_43)		-- 코스튬을 획득하였습니다

-- 이벤트 관련
local CM_String_RewardGetMsg		= PreCreateString_1694 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_44)		-- 축하합니다! 이벤트 보상을 획득하셨습니다.
local CM_String_Day					= PreCreateString_1057 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_40)		-- 일
local CM_String_UntilDelete			= PreCreateString_1056 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)		-- 삭제시까지



--------------------------------------------------------------------
-- 챌린지 미션보상 팝업에서 전역으로 쓸 변수
--------------------------------------------------------------------
CM_RenderOK	= false
local g_MotionEnd	= false
local tCM_ResultInfo = {['protecterr']=0, 0, 0, 0, 0, "", "", "",""}		-- 미션 결과정보

--------------------------------------------------------------------

-- ChallengeMission 보상 팝업창.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 챌린지 미션 보상팝업 알파
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardPopupAlpha")
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


--------------------------------------------------------------------
-- Esc, Enter키 먹히게
--------------------------------------------------------------------
--RegistEscEventInfo("CM_RewardPopupAlpha", "CMRewardOKButtonEvent")
--RegistEnterEventInfo("CM_RewardPopupAlpha", "CMRewardOKButtonEvent")


--------------------------------------------------------------------
-- 챌린지 미션 보상팝업(컨트롤러를 넣어주기 위해서 알파창에 차일드로 등록 안했다.)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardPopupImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)

mywindow:subscribeEvent("EndRender", "CM_RewardEndRender")			-- 랜더
mywindow:subscribeEvent("MotionEventEnd", "RewardMotionEventEnd");	-- 컨트롤러 모션이 완료됐을때 들어오는 함수
mywindow:setAlign(8);
mywindow:addController("CM_RewardController", "Shown", "xscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("CM_RewardController", "Shown", "yscale", "Quintic_EaseIn", 4, 255, 7, true, false, 10);
mywindow:addController("CM_RewardController", "Shown", "angle", "Quintic_EaseIn", 0, 1000, 7, true, false, 10);

root:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지 미션 보상 타이틀
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardTitleImage")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 978)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 978)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지 미션 미션보상 팝업 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_RewardOkButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "CMRewardOKButtonEvent")
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 챌린지 미션 보상 뒷판
--------------------------------------------------------------------
tRewardBackTexX = {['protecterr']=0, [0] = 0,	266, 0, 266 }
tRewardBackTexY = {['protecterr']=0, [0] = 210,210, 315, 315 }

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardBackImage")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(37, 80)
mywindow:setSize(266, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 챌린지 미션 보상(이미지) 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardImageBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7, 6)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지 미션 보상 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_RewardStarEffect")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 420)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 420)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(-15, -30)
mywindow:setSize(115, 116)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_RewardBackImage"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 미션창이 완전히 떴을때 발생하게된다(컨트롤이 완료됐을때)
--------------------------------------------------------------------
function RewardMotionEventEnd()
	if winMgr:getWindow("CM_RewardPopupAlpha"):isVisible() then
		CMVisible(true)
		g_MotionEnd = true
	end
end

--------------------------------------------------------------------
-- 챌린지 미션 완료 보상창 랜더부분.
--------------------------------------------------------------------
function CM_RewardEndRender(args)
	if g_MotionEnd then
		-- 
		local drawer = winMgr:getWindow("CM_RewardPopupImage"):getDrawer();
		drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
		-- 1 -> 초보, 2->미션, 3->회, 4->달성
		if tCM_ResultInfo[1] == 1 then		--선택 미션일때
			local String = string.format(PreCreateString_1019, tCM_ResultInfo[7], tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, String.."!")

			common_DrawOutlineText1(drawer, String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- 타이틀(바꿔주기)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 0, 978)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 0, 978)
					
		elseif tCM_ResultInfo[1] == 0 then	-- 초보 미션
			local String = string.format(PreCreateString_1019, tCM_ResultInfo[7], tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, PreCreateString_1018.." "..String.."!")

			common_DrawOutlineText1(drawer, PreCreateString_1018.." "..String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- 타이틀(바꿔주기)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 0, 978)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 0, 978)
		
		else		-- 나가자 싸우자 이기자.(10으로 해놨다 나중에 챌린지미션 단계가 늘어날 수 있기떄문에)
			local CM_String_WinEvent = PreCreateString_1865 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_45)	
			
			local String = string.format(CM_String_WinEvent, tCM_ResultInfo[2])
			local AllStringSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 13, String.."!")
			common_DrawOutlineText1(drawer, String.."!", (340 - AllStringSize) / 2, 55, 0,0,0,255, 255,255,255,255)
			-- 타이틀(바꿔주기)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Enabled", "UIData/popup001.tga", 340, 896)
			winMgr:getWindow("CM_RewardTitleImage"):setTexture("Disabled", "UIData/popup001.tga", 340, 896)

		end
		
		------------------
		-- 보상 설명부분
		------------------
		local RewardWhere = ""
		local RewardPosX	= 52
		-- 숫자 말고 칭호, 랜덤스킬, 랜덤 코스튬 등등 설명이 들어가야될때.
		-- 숫자가 들어가는 그랑, 코인, 경험치를 보상으로 받을때
		if tCM_ResultInfo[3] == 5 then	--그랑
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 683, 24, 33, 25, drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 685)
			RewardWhere = PreCreateString_1022	-- 5
		elseif tCM_ResultInfo[3] == 6 then	--코인
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 725, 24, 33, 25, drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 727)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 7 then	--경험치
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 641, 24, 33, 25 , drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 643)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 8 then	--라이프
			local _left = DrawEachNumber("UIData/other001.tga", tCM_ResultInfo[4], 8, 220, 116, 11, 641, 24, 33, 25 ,drawer)
			drawer:drawTexture("UIData/other001.tga", _left-25, 116, 30, 29, 266, 643)
			RewardWhere = PreCreateString_1022
		elseif tCM_ResultInfo[3] == 2 then	--스킬체험권
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_1023, 157)	-- 6
			common_DrawOutlineText1(drawer, aa, 150, 105, 0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024			
		elseif tCM_ResultInfo[3] == 4 then	--코스튬
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local TempString = PreCreateString_1025 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_8)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, TempString, 157)	
			common_DrawOutlineText1(drawer, aa, 150, 105, 0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024	
		else
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local NameStringSize	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, '"'..tCM_ResultInfo[5]..'"')--'"어쩌다 한번 진"')
						
			--common_DrawOutlineText1(drawer, "▶", 152, 94, 0,0,0,255, 255,255,255,255)
			common_DrawOutlineText1(drawer, '"'..tCM_ResultInfo[5]..'"', 146 + 77 - NameStringSize/2, 100, 0,0,0,255, 255,84,0,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			common_DrawOutlineText1(drawer, tCM_ResultInfo[6], 150, 120,  0,0,0,255, 255,255,0,255)
			RewardPosX = 41
			RewardWhere = PreCreateString_1024	
		end
	
		
		drawer:setFont(g_STRING_FONT_DODUM, 12)
		drawer:setTextColor(255, 255, 255, 255)
		
		local TempString = PreCreateString_1026	--GetSStringInfo((LAN_LUA_CHALLENGEMISSION_9))

		common_DrawOutlineText1(drawer, "[!] "..TempString.."! "..RewardWhere, RewardPosX, 197, 0,0,0,255, 255,205,86,255)
		
	end

end

--extick = 0
tAniPosX = {['protecterr']=0, [0] = 0, 115, 0, 115 }
tAniPosY = {['protecterr']=0, [0] = 420, 420, 536, 536 }

-- 대전룸 아케이드룸에 들어가야함(지금은 테스트중)
function StarAnimation(tick)
	winMgr:getWindow("CM_RewardStarEffect"):setTexture("Enabled", "UIData/GameSlotItem001.tga", tAniPosX[tick], tAniPosY[tick])
end

-- 뒷판 애니메이션인데 쓰지 안쓸지는 나중에 생각..
function BackImageAnimation(tick)
	--winMgr:getWindow("CM_RewardBackImage"):setTexture("Enabled", "UIData/GameSlotItem001.tga", tRewardBackTexX[tick], tRewardBackTexY[tick])
end


--------------------------------------------------------------------
-- 챌린지 미션 미션조건, 완료 메세지 텍스트
--------------------------------------------------------------------
tChallengeMissionTextName		= {['protecterr']=0, [0]= "MissionCondition", "ResultInfo"}
tChallengeMissionTextPosX		= {['protecterr']=0, [0]=	148, 14}
tChallengeMissionTextPosY		= {['protecterr']=0, [0]=	55, 195}
tChallengeMissionTextSizeX		= {['protecterr']=0, [0]=	190, 315}

for i = 0, #tChallengeMissionTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tChallengeMissionTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tChallengeMissionTextPosX[i], tChallengeMissionTextPosY[i])
	mywindow:setSize(tChallengeMissionTextSizeX[i], 20)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	
	mywindow:setLineSpacing(2)

	winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)

end


--------------------------------------------------------------------
-- 챌린지 미션 완료 선물상자 깨지는거 완료 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_Present_OKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "CM_Present_OKButtonEvent")
root:addChildWindow(mywindow)
--

function CM_Present_OKButtonEvent()
	SettingPresentState(0)
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(false)
	winMgr:getWindow("CM_Present_OKButton"):setVisible(false)

	local bEventVisible	= winMgr:getWindow("CM_EventRewardAlpha"):isVisible()
	ChallengeMissionEvent(bEventVisible);
	CM_RenderOK	= false
	
	if bEventVisible == false then
		EventPopupOpen();
	end
end

--[[
--------------------------------------------------------------------
-- 챌린지 미션 보상 내용
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "챌린지 미션 보상 내용")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 235, 919)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 235, 919)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(55, 80)
mywindow:setSize(231, 105)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "RewardPopupImageRender")
winMgr:getWindow("CM_RewardPopupImage"):addChildWindow(mywindow)


--보상 종류, 보상 설명, 보상 사용기간.
tChallengeMissionRewardTextName		= {['protecterr']=0, [0]= "RewardName", "RewardDesc", "RewardPeriod"}
tChallengeMissionRewardTextPosX		= {['protecterr']=0, [0]=	10, 110, 110}
tChallengeMissionRewardTextPosY		= {['protecterr']=0, [0]=	5, 34, 82}
tChallengeMissionRewardTextSizeX	= {['protecterr']=0, [0]=	200, 120, 120}
tChallengeMissionRewardTextSizeY	= {['protecterr']=0, [0]=	20, 60, 20}

for i = 0, #tChallengeMissionRewardTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tChallengeMissionRewardTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(0, 0, 0, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("1단계 미션 : 1000콤보")
	mywindow:setPosition(tChallengeMissionRewardTextPosX[i], tChallengeMissionRewardTextPosY[i])
	mywindow:setSize(tChallengeMissionRewardTextSizeX[i], tChallengeMissionRewardTextSizeY[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("챌린지 미션 보상 내용"):addChildWindow(mywindow)

end
-- 보상 종류 이미지
tChallengeMissionRewardKindImageName	= {['protecterr']=0, "CM_칭호", "스킬 교환권",  "CM_랜덤 아이탬", "CM_랜덤 코스츔", "CM_포인트", "CM_코인", "CM_경험치", "CM_라이프"}
tChallengeMissionRewardKindImageTexX	= {['protecterr']=0, 	0,			98,				196,				294,			392,	   490,	  	   588,			686		}

for i=1, #tChallengeMissionRewardKindImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tChallengeMissionRewardKindImageName[i])
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", tChallengeMissionRewardKindImageTexX[i], 842)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", tChallengeMissionRewardKindImageTexX[i], 842)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(98, 91)
	mywindow:setVisible(false)		--false로 해줬다가 나중에 
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("챌린지 미션 보상 내용"):addChildWindow(mywindow)
end
--]]
--------------------------------------------------------------------

-- 챌린지 미션보상 팝업 함수.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 미션 보상 팝업 확인버튼 클릭 이벤트
--------------------------------------------------------------------
function CMRewardOKButtonEvent()
	
	CMVisible(false)		-- 챌린지 미션 팝업 꺼준다.
	g_MotionEnd = false;	-- 모션 완료
	--선물함 정보
	--PresentInPresentBox();	-- 선물함 확인해준다.(깜빡)
	winMgr:getWindow("CM_RewardPopupAlpha"):setVisible(false);	-- 꺼주고
	winMgr:getWindow("CM_RewardPopupImage"):setVisible(false);			-- 꺼준다.
	
	if tCM_ResultInfo[3] == 4 then
		SettingPresentState(1)
		winMgr:getWindow("AS_RandumBackWindow"):setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
		winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
		winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(false)
		winMgr:getWindow("AS_ExchangeLastOkBtn"):setVisible(false)		-- 마지막 확인버튼 안보이게 해준다.
		winMgr:getWindow("AS_ExchangeOkBtn"):setVisible(false)			-- 버튼은 안보이게 감춘다.
		winMgr:getWindow("AS_ExchangeCancelBtn"):setVisible(false)
		

		
		for i = 0, 1 do
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearControllerEvent("PresentEvent");
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):clearActiveController()
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):setVisible(false)		-- 컨트롤 달린 이미지 없애줌
			
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "xscale", "Quintic_EaseIn", 30, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "yscale", "Quintic_EaseIn", 70, 255, 3, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54 , -253, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", -253, 54, 2, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 15, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 15, 54, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 54, 45, 1, true, false, 10);
			winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "y", "Sine_EaseInOut", 45, 54, 1, true, false, 10);
			if i == 1 then
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 255, 8, true, false, 10);
				winMgr:getWindow("AS_ReceiveItemInfoImg"..i):addController("AS_PresentBoxControler", "PresentEvent", "alpha", "Sine_EaseInOut", 255, 0, 12, true, false, 10);
			end
		end

	else

		local bEventVisible	= winMgr:getWindow("CM_EventRewardAlpha"):isVisible()

		ChallengeMissionEvent(bEventVisible);	
		
		if bEventVisible == false then
			EventPopupOpen();
		end
	end
	
end


--------------------------------------------------------------------
-- 미션 보상 팝업 확인버튼 보여준다.
--------------------------------------------------------------------
function RewardButtonVisible()
	winMgr:getWindow("AS_RandumBackWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("AS_RandumBackWindow"))
	winMgr:getWindow("AS_ExchangeTitleImg"):setVisible(true)
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Enabled", "UIData/popup001.tga", 0, 363)	-- 알림 이미지
	winMgr:getWindow("AS_ExchangeTitleImg"):setTexture("Disabled", "UIData/popup001.tga", 0, 363)	-- 0, 363 -->축하합니다
	
	winMgr:getWindow("AS_RandumBackWindow"):addChildWindow(winMgr:getWindow("CM_Present_OKButton"))
	winMgr:getWindow("CM_Present_OKButton"):setVisible(true)
	CM_RenderOK	= true
end





-- 랜덤 아이템을 받을때 뿌려주는 아이템 정보 랜더함수,
function CM_RandomboxRender(drawer)
		
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12);
	local Name	= tCM_ResultInfo[5]
	local NameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, Name)
	common_DrawOutlineText2(drawer, Name, 230 - NameSize/2, 14, 0,0,0,255, 255,205,86,255)	
	-- 아이템 이미지.
	drawer:drawTextureSA("UIData/ItemUIData/"..tCM_ResultInfo[8], 20, 9, 243, 108, 0, 0, 255, 255, 255, 0, 0);	

	-- 아이템 설명
	local Desc	= tCM_ResultInfo[6]
	drawer:setFont(g_STRING_FONT_DODUM, 12);
	drawer:setTextColor(255, 0, 0, 255)
	drawer:drawText(Desc, 140, 42)
	
	
	drawer:setFont(g_STRING_FONT_DODUM, 13);
	common_DrawOutlineText2(drawer, CM_String_CostumGet, 80, 138, 0,0,0,255, 255,255,255,255)

end



function LevelUpEffect()
	
	WndBattleRoom_CM_MyLevelUpEffect()

end

--------------------------------------------------------------------
-- 챌린지 미션 완료 보상 이미지
--------------------------------------------------------------------
function RewardImage(RewardKindIndex)

	winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]):setPosition(0, 0);
	winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]):setVisible(true);
	winMgr:getWindow("CM_RewardImageBack"):addChildWindow(winMgr:getWindow(tCM_RewardKindImageName[RewardKindIndex]))

end


--------------------------------------------------------------------
-- 결과 보상 팝업창을 띄워준다.
--------------------------------------------------------------------
function ShowChallengeMissionResult(MissionKind, Step, MissionType, TargetCount, MissionKindStr, RewardKindIndex, Rewardname, RewardDesc, RewardValue, RewardFileName)

	-- 요골루 랜더부분에서 뿌려준다.
	tCM_ResultInfo[1] = MissionType		-- 초보인지 일반인지.
	tCM_ResultInfo[2] = TargetCount		-- 미션 목표 카운트 정보
	tCM_ResultInfo[3] = RewardKindIndex		-- 보상 종류(칭호, 경험치, 그랑, 코인 등등)
	tCM_ResultInfo[4] = RewardValue		-- 숫자형식으로 받는 보상들의 보상 값(ex. 경험치 10000)값이 없는거는 0으로 들어옴.
	tCM_ResultInfo[5] = Rewardname		-- 보상 타이틀(칭호이름, 나머지는 ""로 들어옴.)
	tCM_ResultInfo[6] = AdjustString(g_STRING_FONT_GULIMCHE, 12, RewardDesc, 140)		-- 보상 description
	tCM_ResultInfo[7] = MissionKindStr	-- 보상 타입 string
	tCM_ResultInfo[8] =	RewardFileName		-- 랜덤코스튬일때
	RewardImage(RewardKindIndex);		-- 보상 이미지 띄워준다.
	
	-- 보상팝업 뒷판
	root:addChildWindow(winMgr:getWindow("CM_RewardPopupAlpha"))
	winMgr:getWindow("CM_RewardPopupAlpha"):setVisible(true);
	
	-- 보상팝업
	winMgr:getWindow("CM_RewardPopupImage"):clearActiveController();
	root:addChildWindow(winMgr:getWindow("CM_RewardPopupImage"))
	winMgr:getWindow("CM_RewardPopupImage"):setVisible(true);
	
	PlayWave('sound/TutorialReward01.wav');
end



--------------------------------------------------------------------

-- ChallengeMission 선택 미션 윈도우.

--------------------------------------------------------------------
-- 전역으로 사용할 변수
--------------------------------------------------------------------
local FIRSTITEM_POSX	= 2
local SECONDITEM_POSX	= 16
local THIRDITEM_POSX	= 32
local ITEM_FIRST_POSY	= 7
local ITEM_TERM			= 2
local BOTTOM_OFFSET		= 8
local STEP_COUNT		= 4
local bMouseClick		= false
local ScrollPrev		= 0
local OldScrollCount	= 0		-- 스크롤바의 이전 위치
local MAX_TREELINE		= 17	-- 한화면에 나오는 맥스 라인수


g_CM_ItemCount	= 0
g_CM_tChildCount	= {['protecterr']=0, }
g_CM_tChildCount["_0"] = 0
g_CM_tChildCount["_1"] = 0
g_CM_TopWindowCount	= -1

-- 진행중 완료 진행불가
local tCM_FontRGB	= {['protecterr']=0, 0, 0, 0 }
--------------------------------------------------------------------
-- 챌린지 미션 보상팝업
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChallengeMissionWindow")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 311, 504)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 311, 504)
mywindow:setWideType(6);
mywindow:setPosition((1024 - 713) / 2, (768 - 463) / 2)
mywindow:setSize(713, 463)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("ChallengeMissionWindow", "CM_CloseButtonClick")
--RegistEnterEventInfo("ChallengeMissionWindow", "CM_CloseButtonClick")

--------------------------------------------------------------------
-- 챌린지 미션 트리메뉴
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_TreeBackWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(13, 58)
mywindow:setSize(261, 383)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent("MouseWheel", 'MouseWheelEvent');
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지미션 보상종류 이미지
--------------------------------------------------------------------
tCM_RewardKindImageName	= {['protecterr']=0, "Reward_Title", "Reward_Skill",  "Reward_Item", "Reward_Costum", "Reward_Point", "Reward_Coin", "Reward_Exp", "Reward_Life"}
tCM_RewardKindImageTexX	= {['protecterr']=0, 	0,			98,				196,				294,			392,	   490,	  	   588,			686}

for i = 1, #tCM_RewardKindImageName do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tCM_RewardKindImageName[i])
		mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", tCM_RewardKindImageTexX[i], 843)
		mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", tCM_RewardKindImageTexX[i], 843)
		mywindow:setPosition(293, 340)
		mywindow:setSize(98, 90)
		mywindow:setVisible(true)		--false로 해줬다가 나중에 
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 스크롤바
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/VerticalScrollbar", "CM_ScrollBar")
mywindow:setSize(18, 383)
mywindow:setPosition(243, 0)
--mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
CEGUI.toScrollbar(mywindow):subscribeEvent("ScrollPosChanged", "CM_ScrollBarEvent")
CEGUI.toScrollbar(mywindow):setDocumentSize(383)
CEGUI.toScrollbar(mywindow):setPageSize(383)
CEGUI.toScrollbar(mywindow):setStepSize(20)
CEGUI.toScrollbar(mywindow):setScrollPosition(0)
winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지미션 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(680, 12)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CM_CloseButtonClickButtonClick")
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지미션 정보 Text 8개
--------------------------------------------------------------------
local tCM_TextName = {['protecterr'] = 0, "CM_MissionText", "CM_CountText", "CM_PlaceText", "CM_ConditionText", "CM_DescText", 
										"CM_RewardNameText", "CM_RewardDescText"}
local tCM_TextSizeX = {['protecterr'] = 0,	200,	75,		50,		200,	300,	100,	170}
local tCM_TextSizeY = {['protecterr'] = 0,	20,		20,		40,		40,		60,		20,		60}
local tCM_TextPosX = {['protecterr'] = 0,	297,	415,	608,	368,	297,	401,	401}
local tCM_TextPosY = {['protecterr'] = 0,	70,		106,	106,	153,	234,	345,	366}

for i=1, #tCM_TextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tCM_TextName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(true);
	mywindow:setPosition(tCM_TextPosX[i], tCM_TextPosY[i]);
	mywindow:setSize(tCM_TextSizeX[i], tCM_TextSizeY[i]);
	mywindow:setViewTextMode(1);
	mywindow:setAlign(1);
	mywindow:setLineSpacing(3);
	winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow);
end

for i=1, #tCM_TextName do
	winMgr:getWindow(tCM_TextName[i]):clearTextExtends()
	winMgr:getWindow(tCM_TextName[i]):addTextExtends("", g_STRING_FONT_GULIMCHE,13, 255,205,86,255, 1, 0,0,0,255);
end



--------------------------------------------------------------------
-- 타이틀바(마우스 따라 움직이게 하기)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "CM_TitleBar")
mywindow:setPosition(1, 1)
mywindow:setSize(679, 45)
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 챌린지 미션 완료, 진행불가 알파이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_AlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 446)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 446)
mywindow:setPosition(280, 51)
mywindow:setSize(423, 398)
mywindow:setVisible(true)		--false로 해줬다가 나중에 
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChallengeMissionWindow"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 챌린지 미션 완료, 진행불가 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_StampImage")
mywindow:setTexture("Enabled", "UIData/guildmission.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/guildmission.tga", 0, 123)
mywindow:setPosition(105, 188)
mywindow:setSize(224, 123)
mywindow:setVisible(true)		--false로 해줬다가 나중에 
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("CM_AlphaImage"):addChildWindow(mywindow)





--------------------------------------------------------------------

-- ChallengeMission 선택 미션 윈도우 함수.

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 챌린지 미션 갯수를 읽어와서 체크박스나 라디오버튼을 생성해준다.
-- 요곤 무조건 한번만 불러와서 만들어줘야한다.(여러번 하면 윈도우 생성 오류)
--------------------------------------------------------------------
--1,2,3
function CreateTopTreeWindow(TopWindowIndex, ChildCount, ...)		-- 차일드가 몇개나 있는지 알 수 없기때문에 인자값은 가변적으로 해놨다.()
--	local	WindowCount	= arg.n		-- 밑으로 자식이 어떻게(갯수) 달려있는지..
	if TopWindowIndex == 0 then
		g_CM_ItemCount = 0
	end
	g_CM_tChildCount["_"..TopWindowIndex]	= ChildCount
	g_CM_TopWindowCount					= TopWindowIndex
	
	
------------------
-- 뒷판
------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeItemBack_"..TopWindowIndex)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
	mywindow:setSize(236, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
	
	g_CM_ItemCount = g_CM_ItemCount + 1	-- 아이템 숫자를 카운트 시켜준다.
	
-------------------------
-- +표시 버튼(체크박스)
-------------------------
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", "TreeItemCheckBox_"..tostring(TopWindowIndex))
	mywindow:setTexture("Normal", "UIData/guildmission.tga", 357, 453)
	mywindow:setTexture("Hover", "UIData/guildmission.tga", 377, 453)
	mywindow:setTexture("Pushed", "UIData/guildmission.tga", 397, 453)
	mywindow:setTexture("PushedOff", "UIData/guildmission.tga", 397, 453)
	
	mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 357, 473)
	mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 377, 473)
	mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 397, 473)
	mywindow:setTexture("SelectedPushedOff", "UIData/guildmission.tga", 397, 473)
	
	mywindow:setPosition(FIRSTITEM_POSX, 1)
	mywindow:setSize(19, 19)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	CEGUI.toCheckbox(mywindow):setSelected(true)
	mywindow:subscribeEvent("CheckStateChanged", "TreeItemCheckBoxEvent")
	mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex));		-- 인덱스를 저장 시켜줌
	winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex)):addChildWindow(mywindow)
	
	
---------------------------------------------
-- 텍스트를 넣어줘야할 버튼(위에 넣어야함)
---------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "TreeItemButton_"..tostring(TopWindowIndex))
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(23, 2)
	mywindow:setSize(210, 16)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "CM_TreeClick")
	mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
	mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
	mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
	mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
	mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex));		-- 인덱스를 저장 시켜줌
	
	winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex)):addChildWindow(mywindow)
---------------------------------------------
-- 미션이 들어가야할 텍스트
---------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex))
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(3, 1)
	mywindow:setSize(207, 16)
	mywindow:setFont(g_STRING_FONT_DODUM, 14)
	mywindow:setTextColor(180, 180, 180, 255)
--	mywindow:setViewTextMode(1)
--	mywindow:setAlign(1)
--	mywindow:setLineSpacing(2)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setEnabled(false)
	mywindow:setUserString("TextStateIndex", g_String_Normal)
	winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex)):addChildWindow(mywindow)

------------------------------------
-- 두번째 위치에 들어가는 차일드
------------------------------------
	for i = 1, ChildCount do
	------------------
	-- 뒷판
	------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TreeItemBack_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
		mywindow:setSize(236, 20)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
		
		g_CM_ItemCount = g_CM_ItemCount + 1	-- 아이템 숫자를 카운트 시켜준다.
		
	------------------
	-- +버튼 이미지
	------------------		
		mywindow = winMgr:createWindow("TaharezLook/Checkbox", "TreeItemCheckBox_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Normal", "UIData/guildmission.tga", 362, 416)
		mywindow:setTexture("Hover", "UIData/guildmission.tga", 378, 416)
		mywindow:setTexture("Pushed", "UIData/guildmission.tga", 394, 416)
		mywindow:setTexture("PushedOff", "UIData/guildmission.tga", 394, 416)
		
		mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 362, 432)
		mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 378, 432)
		mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 394, 432)
		mywindow:setTexture("SelectedPushedOff", "UIData/guildmission.tga", 394, 432)
		mywindow:setPosition(SECONDITEM_POSX, 3)
		mywindow:setSize(16, 16)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		CEGUI.toCheckbox(mywindow):setSelected(true)
		mywindow:subscribeEvent("CheckStateChanged", "TreeItemCheckBoxEvent")
		mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i));		-- 인덱스를 저장 시켜줌
		winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)


	------------------
	-- 클릭되는 버튼
	------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "TreeItemButton_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(37, 2)
		mywindow:setSize(210, 16)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "CM_TreeClick")
		mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
		mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
		mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
		mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
		mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i));		-- 인덱스를 저장 시켜줌

		winMgr:getWindow("TreeItemBack_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)
	---------------------------------------------
	-- 미션이 들어가야할 텍스트
	---------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex).."_"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(3, 1)
		mywindow:setSize(207, 16)
		mywindow:setFont(g_STRING_FONT_DODUM, 113)
		mywindow:setTextColor(180, 180, 180, 255)
--		mywindow:setViewTextMode(1)
--		mywindow:setAlign(1)
--		mywindow:setLineSpacing(2)
		mywindow:setZOrderingEnabled(false)	
		mywindow:setEnabled(false)
		mywindow:setUserString("TextStateIndex", "0")
		winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex).."_"..i):addChildWindow(mywindow)

	------------------------------------
	-- 스텝이 되는 차일드
	------------------------------------
		for j = 1, STEP_COUNT do
		------------------
		-- 클릭되는 버튼
		------------------
			mywindow = winMgr:createWindow("TaharezLook/RadioButton", "TreeItemButton_"..tostring(TopWindowIndex).."_"..i.."_"..j)
			mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 848)
			mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 865)
			mywindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 0, 882)
			mywindow:setTexture("SelectedHover", "UIData/guildmission.tga", 0, 882)
			mywindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 0, 882)
			mywindow:setProperty("GroupID", 654)
			mywindow:setPosition(3, ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount))
			mywindow:setSize(256, 18)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:setSubscribeEvent("SelectStateChanged", "StepItemClick")
			mywindow:subscribeEvent("MouseButtonDown", "CM_ButtonMouseDown");
			mywindow:subscribeEvent("MouseButtonUp", "CM_ButtonMouseUp");
			mywindow:subscribeEvent("MouseLeave", "CM_ButtonMouseLeave");
			mywindow:subscribeEvent("MouseEnter", "CM_ButtonMouseEnter");
			mywindow:setUserString("WindowIndex", "_"..tostring(TopWindowIndex).."_"..tostring(i).."_"..tostring(j));		-- 인덱스를 저장 시켜줌
			winMgr:getWindow("CM_TreeBackWindow"):addChildWindow(mywindow)
			
			g_CM_ItemCount = g_CM_ItemCount + 1	-- 아이템 숫자를 카운트 시켜준다.

		---------------------------------------------
		-- 미션이 들어가야할 텍스트
		---------------------------------------------
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "TreeItemText_"..tostring(TopWindowIndex).."_"..i.."_"..j)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "false")
			mywindow:setPosition(30, 2)
			mywindow:setSize(207, 16)
			mywindow:setFont(g_STRING_FONT_DODUM, 112)
			mywindow:setTextColor(180, 180, 180, 255)
			
--			mywindow:setViewTextMode(1)
--			mywindow:setAlign(1)
--			mywindow:setLineSpacing(2)
			mywindow:setZOrderingEnabled(false)	
			mywindow:setEnabled(false)
			mywindow:setUserString("TextStateIndex", "0")
			winMgr:getWindow("TreeItemButton_"..tostring(TopWindowIndex).."_"..i.."_"..j):addChildWindow(mywindow)
		end
	end
	winMgr:getWindow("TreeItemText_"..tostring(TopWindowIndex)):setText(g_tChapterName[TopWindowIndex + 1])
	
	RefreshTreeWindow()		-- 트리 윈도우 사이즈 맞게 조절

end



--------------------------------------------------------------------
-- 트리 구조에 들어가는 텍스트를 업데이트 해준다.
--------------------------------------------------------------------
function TreeTextUpdate(kind, typecount, desc, count, CurrentStep, CurrentKind)

	local state		= ""
	local ChildState = ""
	
	if CurrentKind == 0 then
		if kind == 1 then
			state = g_String_NotPlaying
		else
			if count == -1 then
				state = g_String_Complete
			else
				state = g_String_Playing
			end
		end
		
	elseif CurrentKind == 1 then	-- 달성하라
		if kind == 0 then
			state = g_String_Complete
		else
			if count == -1 then
				state = g_String_Complete
			else
				state = g_String_Playing
			end
		end
	elseif CurrentKind == 2 then	-- 완료
		state = g_String_Complete
	end

	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setUserString("TextStateIndex", state)
	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setTextColor(g_CM_tFontColor[1][state], g_CM_tFontColor[2][state], g_CM_tFontColor[3][state], 255)
	winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):setText(desc)
	--winMgr:getWindow("TreeItemText_"..kind.."_"..typecount):addText(" ("..state..")")

	for i = 1, STEP_COUNT do
		if state == g_String_Complete then
			ChildState = g_String_Complete
		elseif state == g_String_Playing then
			if CurrentStep > i then
				ChildState = g_String_Complete
			elseif CurrentStep == i then
				ChildState = g_String_Playing
			elseif CurrentStep < i then
				ChildState = g_String_NotPlaying
			end
		elseif state == g_String_NotPlaying then
			ChildState = g_String_NotPlaying
		end
		local String = string.format(CM_String_Step, i)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setUserString("TextStateIndex", ChildState)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setTextColor(g_CM_tFontColor[1][ChildState], g_CM_tFontColor[2][ChildState], g_CM_tFontColor[3][ChildState], 255)
		winMgr:getWindow("TreeItemText_"..kind.."_"..typecount.."_"..i):setText(String.." ("..ChildState..")")
	end

end




-----------------------------------------------------------------------------
-- 버튼 이벤트(트리의 부모를 클릭했을대 효과를 주기위해)
-----------------------------------------------------------------------------
--------------------------------------------------------------------
-- 마우스로 다운이벤트 발생 시켰을때,
--------------------------------------------------------------------
function CM_ButtonMouseDown(args)
	
	if bMouseClick == false then
		local MyWindow = CEGUI.toMouseEventArgs(args).window;
		local WindowIndex	= MyWindow:getUserString("WindowIndex");
		
		local window_pos = MyWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		MyWindow:setPosition(win_pos_x + 2, win_pos_y + 2)
		bMouseClick = true
	end
	
end


--------------------------------------------------------------------
-- 마우스로 업이벤트 발생 시켰을때,
--------------------------------------------------------------------
function CM_ButtonMouseUp(args)

	if bMouseClick == true then
		local MyWindow = CEGUI.toMouseEventArgs(args).window;
		local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
		local window_pos = MyWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		MyWindow:setPosition(win_pos_x - 2, win_pos_y - 2)
		bMouseClick = false
	end

end


--------------------------------------------------------------------
-- 마우스가 영역안에 들어왔을때 이벤트
--------------------------------------------------------------------
function CM_ButtonMouseEnter(args)

	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
	MouseEventTextSetting(WindowIndex, true)		-- 텍스트 설정
	MouseEventCheckBoxSetting(WindowIndex, true)	-- 체크박스 설정
	

end


--------------------------------------------------------------------
-- 마우스가 영역안에서 나갔을때 이벤트
--------------------------------------------------------------------
function CM_ButtonMouseLeave(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	
	MouseEventTextSetting(WindowIndex, false)		-- 텍스트 설정
	MouseEventCheckBoxSetting(WindowIndex, false)	-- 체크박스 설정
	

end
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

local tCM_NumberTable = {['protecterr']=0, -1, -1, -1}



--------------------------------------------------------------------
-- 단계 라디오버튼 클릭 이벤트(클릭시 정보들을 다 뿌려준다)
--------------------------------------------------------------------
function StepItemClick(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	if CEGUI.toRadioButton(MyWindow):isSelected() then
		local String = winMgr:getWindow("TreeItemText"..WindowIndex):getUserString("TextStateIndex")
		
		StringFindReturnNumber(WindowIndex, 1)

		-- C쪽의 인덱스를 맞추기 위해서
		if tCM_NumberTable[1] == 0 then
			tCM_NumberTable[2] = tCM_NumberTable[2] - 1		
		else
			tCM_NumberTable[2] = tCM_NumberTable[2] + 5
		end
		Get_CM_ChildInfo(tCM_NumberTable[1], tCM_NumberTable[2], tCM_NumberTable[3], String)		
		
		winMgr:getWindow("TreeItemText"..WindowIndex):setTextColor(255, 255, 255, 255)
		
		local TexY = 0;
		if String == g_String_Playing then
			TexY = 865
		elseif String == g_String_Complete then
			TexY = 848
		elseif String == g_String_NotPlaying then
			TexY = 882
		else
			TexY = 899
		end
		MyWindow:setTexture("SelectedNormal", "UIData/guildmission.tga", 0, TexY)
		MyWindow:setTexture("SelectedHover", "UIData/guildmission.tga", 0, TexY)
		MyWindow:setTexture("SelectedPushed", "UIData/guildmission.tga", 0, TexY)
	else
		local String = winMgr:getWindow("TreeItemText"..WindowIndex):getUserString("TextStateIndex")
		
		winMgr:getWindow("TreeItemText"..WindowIndex):setTextColor(g_CM_tFontColor[1][String], g_CM_tFontColor[2][String], g_CM_tFontColor[3][String], 255)
	end
end



--------------------------------------------------------------------
-- 미션 정보들을 받아온다
--------------------------------------------------------------------
function SettingMissionInfo(Kind, TypeIndex, TypeStr, StepIndex, TargetCount, CurrentCount, RewardIndex, RewardName, RewardDesc, Select_State)
	for i = 1, #tCM_RewardKindImageName do
		if RewardIndex ~= i then
			winMgr:getWindow(tCM_RewardKindImageName[i]):setVisible(false)
		else
			winMgr:getWindow(tCM_RewardKindImageName[i]):setVisible(true)
		end
	end

	----------
	-- 임무 --
	local StageString = string.format(CM_String_Step, StepIndex)
	winMgr:getWindow("CM_MissionText"):clearTextExtends()
	winMgr:getWindow("CM_MissionText"):addTextExtends(g_tChapterName[Kind + 1].." : ", g_STRING_FONT_DODUMCHE,14, 255,205,86,255, 1, 0,0,0,255);
	winMgr:getWindow("CM_MissionText"):addTextExtends(TypeStr.." "..StageString, g_STRING_FONT_DODUMCHE,14, 255,255,255,255, 1, 0,0,0,255);


	----------
	-- 장소 --
	winMgr:getWindow("CM_PlaceText"):setAlign(8)
	winMgr:getWindow("CM_PlaceText"):clearTextExtends()
	if TypeIndex == 0 or TypeIndex == 1 or TypeIndex == 6 or TypeIndex == 7 or TypeIndex == 8 or
		TypeIndex == 9 or TypeIndex == 10 then
		winMgr:getWindow("CM_PlaceText"):setPosition(600, 106)
	else
		winMgr:getWindow("CM_PlaceText"):setPosition(600, 114)
	end
	winMgr:getWindow("CM_PlaceText"):addTextExtends(g_tCM_PlaceName[TypeIndex + 1], g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);

	
	----------
	-- 조건 --
	local	ConditionStr = ""
	winMgr:getWindow("CM_ConditionText"):clearTextExtends()
	
	if Kind == 1 and StepIndex == 1 then
		winMgr:getWindow("CM_ConditionText"):setPosition(364, 153)
		ConditionStr = g_tChapterName[Kind].."\n"..CM_String_CanPlayAfterComplete
	elseif Kind == 0 and StepIndex == 1 then
		winMgr:getWindow("CM_ConditionText"):setPosition(375, 160)
		ConditionStr = PreCreateString_1691 --GetSStringInfo(LAN_LUA_CHALLENGEMISSION_41)
	else
		winMgr:getWindow("CM_ConditionText"):setPosition(364, 153)
		StageString = string.format(CM_String_Step, StepIndex - 1)
		ConditionStr = g_tChapterName[Kind + 1]..": "..TypeStr.." "..StageString.."\n"..CM_String_CanPlayAfterComplete
	end
	winMgr:getWindow("CM_ConditionText"):addTextExtends(ConditionStr, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);


	----------
	-- 내용 --
	winMgr:getWindow("CM_DescText"):clearTextExtends()
	local String	= CM_DescReturn(TypeIndex + 1, TargetCount)
	winMgr:getWindow("CM_DescText"):addTextExtends(String, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
	
	RewardDesc = RewardInfoTextReturn(RewardIndex, RewardDesc)

	--------------
	-- 보상이름 --
	winMgr:getWindow("CM_RewardNameText"):clearTextExtends()
--	winMgr:getWindow("CM_RewardNameText"):addTextExtends(RewardName, g_STRING_FONT_GULIMCHE,12, 230,10,220,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_RewardNameText"):addTextExtends(RewardName, g_STRING_FONT_GULIMCHE,12, 255,255,255,255, 1, 255,0,0,255);

	----------------
	-- 보상설명 --
	winMgr:getWindow("CM_RewardDescText"):clearTextExtends()
	winMgr:getWindow("CM_RewardDescText"):addTextExtends(RewardDesc, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);

	--------------
	-- 진행상황 --
	winMgr:getWindow("CM_CountText"):clearTextExtends()
	
	if Select_State == g_String_Complete then
		winMgr:getWindow("CM_CountText"):setAlign(8)
		winMgr:getWindow("CM_CountText"):setPosition(384, 114)
		winMgr:getWindow("CM_CountText"):addTextExtends(g_String_Complete, g_STRING_FONT_GULIMCHE,12, 16,100,255,255, 1, 230,230,230,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(true)
		winMgr:getWindow("CM_StampImage"):setTexture("Enabled", "UIData/guildmission.tga", 0, 123)
	elseif Select_State == g_String_NotPlaying then
		winMgr:getWindow("CM_CountText"):setAlign(8)
		winMgr:getWindow("CM_CountText"):setPosition(384, 114)
		winMgr:getWindow("CM_CountText"):addTextExtends(g_String_NotPlaying, g_STRING_FONT_GULIMCHE,12, 255,63,16,255, 1, 255,255,255,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(true)
		winMgr:getWindow("CM_StampImage"):setTexture("Enabled", "UIData/guildmission.tga", 0, 0)
	else
		winMgr:getWindow("CM_CountText"):setAlign(1)
		winMgr:getWindow("CM_CountText"):setPosition(375, 106)
		winMgr:getWindow("CM_CountText"):addTextExtends(CM_String_Present.." : "..CurrentCount, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
		winMgr:getWindow("CM_CountText"):addTextExtends("\n"..CM_String_Goal.." : "..TargetCount, g_STRING_FONT_GULIMCHE,112, 255,255,255,255, 0, 0,0,0,255);
		winMgr:getWindow("CM_AlphaImage"):setVisible(false)
	end
end



--------------------------------------------------------------------
-- 보상에대한 텍스트 정리
--------------------------------------------------------------------
function RewardInfoTextReturn(RewardIndex, RewardDesc)
	local RewardItemDesc = ""

	if RewardIndex == 1 then		--칭호
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, RewardDesc, 280)
	elseif RewardIndex == 2 then	-- 스킬교환권
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText1, 280)
	elseif RewardIndex == 3 then	-- 랜덤아이템
		RewardItemDesc = ""
	elseif RewardIndex == 4 then	-- 랜덤 코스츔
		local TempString = PreCreateString_1025	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_8)
		
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, TempString, 280)
		--RewardItemDesc = "랜덤하게 코스튬을 받을 수 있습니다"
	elseif RewardIndex == 5 then	-- 그랑
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText2, 280)
	elseif RewardIndex == 6 then	-- 코인 
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText3, 280)
	elseif RewardIndex == 7 then	-- 경험치
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText4, 280)
	elseif RewardIndex == 8 then	-- 경험치
		RewardItemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 12, CM_String_RewardText5, 280)
	end
	return RewardItemDesc
end












--------------------------------------------------------------------
-- 스트링을 분해해서 숫자를 뽑아낸다.
--------------------------------------------------------------------
function StringFindReturnNumber(str, NumberCount)
	if NumberCount >= 4 then	-- 4이상 넘어가면 안됀다
		return;
	end
	local sStart, sEnd = string.find(str, "%_")
--	local nCount	= 0;
	if sStart ~= nil then
		local str2 = string.sub(str, sEnd+1)
		local subStart, subEnd = string.find(str2, "%_")
		if subStart ~= nil then
			local strNumber = string.sub(str2, 1, subStart-1)
			tCM_NumberTable[NumberCount] = tonumber(strNumber)
			StringFindReturnNumber(str2, NumberCount + 1)		-- 다시한번 호출
		else
			local strNumber = string.sub(str2, 1)
			tCM_NumberTable[NumberCount] = tonumber(strNumber)
		end
	end
end



--------------------------------------------------------------------
-- 설정해 놓은 문자를 찾는다(구분해주기 위해 만들어 놓음)
--------------------------------------------------------------------
function StringFind(str)
	local sStart, sEnd = string.find(str, "%_")
	local nCount	= 0;
	if sStart ~= nil then
		local str2 = string.sub(str, sEnd+1)
		nCount = nCount + StringFind(str2)		
	end
	return nCount + 1
end



--------------------------------------------------------------------
-- 등급에 따라 폰트 사이즈 설정(마우스 오버시나 클릭시 효과를 주기위해서)
--------------------------------------------------------------------
function MouseEventTextSetting(str, bEnter)
	local fontSize	= 0;
	local stringSize = StringFind(str) - 1
	
	if stringSize == 1 then
		fontSize = 14
	elseif stringSize == 2 then
		fontSize = 113
	elseif stringSize == 3 then
		fontSize = 112
		if CEGUI.toRadioButton(winMgr:getWindow("TreeItemButton"..str)):isSelected() then
			return
		end
	end
	winMgr:getWindow("TreeItemText"..str):setFont(g_STRING_FONT_DODUM, fontSize)
	
	local CurrentState	= winMgr:getWindow("TreeItemText"..str):getUserString("TextStateIndex")
	
	if bEnter then
		winMgr:getWindow("TreeItemText"..str):setTextColor(255, 255, 255, 255)
	else
		winMgr:getWindow("TreeItemText"..str):setTextColor(g_CM_tFontColor[1][CurrentState], g_CM_tFontColor[2][CurrentState], g_CM_tFontColor[3][CurrentState], 255)
	end

end

--------------------------------------------------------------------
-- 체크박스(요것도 마우스 이벤트때 효과를 주기위해서)
--------------------------------------------------------------------
function MouseEventCheckBoxSetting(str, bEnter)
	local stringSize = StringFind(str) - 1
	if stringSize > 2 then
		return
	end
	
	if bEnter then
		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..str)):isSelected() then-- - no
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 377, 473)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 378, 432)
			end
		else
			if stringSize == 1 then	-- +
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 377, 453)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 378, 416)
			end
		end
	
	else
		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..str)):isSelected() then
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 357, 473)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("SelectedNormal", "UIData/guildmission.tga", 362, 432)
			end
		else
			if stringSize == 1 then
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 357, 453)
			else
				winMgr:getWindow("TreeItemCheckBox"..str):setTexture("Normal", "UIData/guildmission.tga", 362, 416)
			end
		end
		
	end
end


--------------------------------------------------------------------
-- 자식이 있는 버튼을 누를경우(이건 효과가 아니라 이벤트)
--------------------------------------------------------------------
function CM_TreeClick(args)
	local MyWindow = CEGUI.toMouseEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");

	if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):isSelected() then
		CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):setSelected(false)
	else
		CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):setSelected(true)		
	end

end


--------------------------------------------------------------------
-- + - 체크박스 이벤트
--------------------------------------------------------------------
function TreeItemCheckBoxEvent(args)
	local MyWindow = CEGUI.toWindowEventArgs(args).window;
	local WindowIndex	= MyWindow:getUserString("WindowIndex");
	local stringSize = StringFind(WindowIndex) - 1

	if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WindowIndex)):isSelected() then
		if stringSize == 1 then
			CM_ButtonEvent(WindowIndex, true, g_CM_tChildCount[tostring(WindowIndex)])			
		else
			CM_ButtonEvent(WindowIndex, true, STEP_COUNT)
		end
	else
		if stringSize == 1 then
			CM_ButtonEvent(WindowIndex, false, g_CM_tChildCount[tostring(WindowIndex)])			
		else
			CM_ButtonEvent(WindowIndex, false, STEP_COUNT)
		end
	end
end


--------------------------------------------------------------------
-- 버튼눌렀을때 이벤트
--------------------------------------------------------------------
function CM_ButtonEvent(WinIndexStr, bSelect, childCount)
	local stringSize = StringFind(WinIndexStr) - 1

	if stringSize > 2 then
		return
	end
	if bSelect then
		for i = 1, childCount do
			if stringSize == 2 then
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WinIndexStr)):isSelected() then
					winMgr:getWindow("TreeItemButton"..WinIndexStr.."_"..tostring(i)):setVisible(true)
					g_CM_ItemCount = g_CM_ItemCount + 1
				end
			else
				winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(true)
				g_CM_ItemCount = g_CM_ItemCount + 1
				CM_ButtonEvent(WinIndexStr.."_"..tostring(i), true, 4)	
			end			
		end

	else
		for i = 1, childCount do
			if stringSize == 2 then
				winMgr:getWindow("TreeItemButton"..WinIndexStr.."_"..tostring(i)):setVisible(false)
				g_CM_ItemCount = g_CM_ItemCount - 1
			else				
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox"..WinIndexStr.."_"..tostring(i))):isSelected() then
					winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(false)
					g_CM_ItemCount = g_CM_ItemCount - 1			
										
					CM_ButtonEvent(WinIndexStr.."_"..tostring(i), false,4)	
				else	
					winMgr:getWindow("TreeItemBack"..WinIndexStr.."_"..tostring(i)):setVisible(false)
					g_CM_ItemCount = g_CM_ItemCount - 1
									
				end
			end
			
		end
	end
	RefreshTreeWindow()
end


--------------------------------------------------------------------
-- 트리 윈도우 이벤트가 발생할때마다 뒷판, 버튼들 위치, 스크롤바를 처리해준다
--------------------------------------------------------------------
function RefreshTreeWindow()
	-- 아이템 갯수에따라 뒷판 이미지 싸이즈 다르게
	--winMgr:getWindow("TreeItemBack"..tostring(TopWindowIndex)):
	local BackSizeY	= ITEM_FIRST_POSY + (20 * g_CM_ItemCount) + (ITEM_TERM * g_CM_ItemCount) + BOTTOM_OFFSET
--	winMgr:getWindow("CM_TreeBackWindow"):setSize(261, BackSizeY)
	
	ButtonEventtoScreen()	-- 없어지는 윈도우들 사이를 채워주기위해서 위치를 다시 잡는다.
	
	-- 이미지 싸이즈에 맞게 스크롤바 처리.(함수로)
	if BackSizeY > 383 then
		-- 스크롤바 나타나게처리	
		winMgr:getWindow("CM_ScrollBar"):setVisible(true)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setDocumentSize(BackSizeY)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setPageSize(383)
		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setStepSize(20)
--		CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(0);
	else
		-- 스크롤바 없앤다.
		winMgr:getWindow("CM_ScrollBar"):setVisible(false)
	end

end
 
  
--------------------------------------------------------------------
-- 없어지는 윈도우들 사이를 채워주기위해서 위치를 다시 잡는다.
--------------------------------------------------------------------
function ButtonEventtoScreen()
	
	local	Count	= 0
	local	Count2	= 0
	local	InvisibleCount	= OldScrollCount
	
	for i = 0, g_CM_TopWindowCount do

		if Count >= MAX_TREELINE then
			winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
		else
			if InvisibleCount ~= 0 then
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
				InvisibleCount = InvisibleCount - 1
			else
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
				Count	= Count + 1
			end
		end

		if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i)):isSelected() then 
			for j = 1, g_CM_tChildCount["_"..i] do
			
				if Count >= MAX_TREELINE then
					winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
				else
					if InvisibleCount ~= 0 then
						InvisibleCount = InvisibleCount - 1
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
					else
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
						Count = Count + 1
					end
				end
				if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i.."_"..j)):isSelected() then 
					for k = 1, STEP_COUNT do
						if Count >= MAX_TREELINE then
							winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
						else
							if InvisibleCount ~= 0 then
								InvisibleCount = InvisibleCount - 1
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)

							else
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * Count) + (ITEM_TERM * Count))
								Count = Count + 1
								
							end
						end
					end
				
				end
			end
		end
	end
end



function CM_ScrollBarEvent(args)
	if winMgr:getWindow("ChallengeMissionWindow"):isVisible() then
	
		local pos			= CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window):getScrollPosition()
		-- 스크롤바 위치가 스크롤될정도로 움직이지 않았다면 리턴
		local FrontDisableCount = pos / 20
		if OldScrollCount == FrontDisableCount then
			return
		end
		
		OldScrollCount = FrontDisableCount
		
		local DisableCount	= 0
		local VisibleCount	= 0
		local IsVisible		= false;
		
		for i = 0, g_CM_TopWindowCount do
			if VisibleCount >= MAX_TREELINE then
				winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
						
			else
				if DisableCount < FrontDisableCount then
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(false)
				elseif DisableCount == FrontDisableCount then
					VisibleCount = 0
					IsVisible = true
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
				else
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setVisible(true)
					winMgr:getWindow("TreeItemBack_"..tostring(i)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
				end
				DisableCount	= DisableCount + 1
				if IsVisible then
					VisibleCount	= VisibleCount + 1
				end
			end
			if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i)):isSelected() then
				for j = 1, g_CM_tChildCount["_"..i] do
				
					if VisibleCount >= MAX_TREELINE then
						winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
						
					else	
						if DisableCount < FrontDisableCount then
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(false)
						elseif DisableCount == FrontDisableCount then
							VisibleCount = 0
							IsVisible = true
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
						else
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setVisible(true)
							winMgr:getWindow("TreeItemBack_"..tostring(i).."_"..tostring(j)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
						end
						DisableCount	= DisableCount + 1
						if IsVisible then
							VisibleCount	= VisibleCount + 1
						end
					end
						
					if CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..i.."_"..j)):isSelected() then
						for k = 1, STEP_COUNT do
							if VisibleCount >= MAX_TREELINE then
								winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
							else
								if DisableCount < FrontDisableCount then
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(false)
								elseif DisableCount == FrontDisableCount then
									VisibleCount = 0
									IsVisible = true
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))
								else
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setVisible(true)
									winMgr:getWindow("TreeItemButton_"..tostring(i).."_"..tostring(j).."_"..tostring(k)):setPosition(3, ITEM_FIRST_POSY + (20 * VisibleCount) + (ITEM_TERM * VisibleCount))

								end
								DisableCount	= DisableCount + 1
								if IsVisible then
									VisibleCount	= VisibleCount + 1
								end
							end
						end
					end
				end
			end
		end
	end
end



--------------------------------------------------------------------
-- 챌린지 미션 마우스휠 이벤트
--------------------------------------------------------------------
function MouseWheelEvent(args)

	local Delta = CEGUI.toMouseEventArgs(args).wheelChange
	local pos	= CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):getScrollPosition()
	local Size	= CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):getDocumentSize()

	if Delta < 0 then
		pos = pos + 20	
		if pos > Size then
			pos = Size
		end
	else
		pos = pos - 20	
		if pos < 0 then
			pos = 0
		end

	end
	CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(pos);
end



--------------------------------------------------------------------
-- 챌린지 미션 윈도우를 생성한다.
--------------------------------------------------------------------
function CreateChallengeMission()
	Get_CMInfoCount();		-- 챌린지 미션 갯수에 따라
end


--------------------------------------------------------------------
-- 챌린지 미션을 보여준다
--------------------------------------------------------------------
function ShowChallengeMission(bNPCClick)
	if bNPCClick then
		winMgr:getWindow("CM_TitleBar"):setVisible(false)			--타이틀바 없애기
		--winMgr:getWindow("CM_CloseButton"):setVisible(false)		--버튼 없애기
		--winMgr:getWindow("ChallengeMissionWindow"):setPosition(50, 72)
	else
		winMgr:getWindow("CM_TitleBar"):setVisible(true)			--타이틀바 나와
		--winMgr:getWindow("CM_CloseButton"):setVisible(true)			--버튼 나오기
		--winMgr:getWindow("ChallengeMissionWindow"):setPosition((g_MAIN_WIN_SIZEX - 598) / 2, (g_MAIN_WIN_SIZEY - 460) / 2)
	end
	winMgr:getWindow("ChallengeMissionWindow"):setPosition((g_MAIN_WIN_SIZEX - 713) / 2, 80)
	root:addChildWindow(winMgr:getWindow("ChallengeMissionWindow"))
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(true)
	Show_CMInfo();

	-- 차일드를 다 접어준다	
	for i = 0, 1 do
		for j = 1, g_CM_tChildCount["_"..i] do
			CEGUI.toCheckbox(winMgr:getWindow("TreeItemCheckBox_"..tostring(i).."_"..j)):setSelected(false)
		end	
	end
	CEGUI.toScrollbar(winMgr:getWindow("CM_ScrollBar")):setScrollPosition(0)
	CEGUI.toRadioButton(winMgr:getWindow("TreeItemButton_0_1_1")):setSelected(true)
end


--------------------------------------------------------------------
-- 챌린지 미션창을 닫는다
--------------------------------------------------------------------
function CM_CloseButtonClick()
	if "village" == GetCurWindowName() then
		VirtualImageSetVisible(false)
		--TownNpcEscBtnClickEvent()
	end
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(false)
end


--------------------------------------------------------------------
-- 챌린지미션 엔피씨에서 없앨때.
--------------------------------------------------------------------
function CM_CloseButtonClickButtonClick()
	if "village" == GetCurWindowName() then
		VirtualImageSetVisible(false)
		TownNpcEscBtnClickEvent()	
	end
	winMgr:getWindow("ChallengeMissionWindow"):setVisible(false)
end





--------------------------------------------------------------------

-- 챌린지 미션 다음 챕터 안내 팝업 윈도우

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 챌린지미션 안내 빽판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_NextInfoBack")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


RegistEscEventInfo("CM_NextInfoBack", "CM_NextInfoClose")
RegistEnterEventInfo("CM_NextInfoBack", "CM_NextInfoClose")

--------------------------------------------------------------------
-- 광장 최초입장 스피커맨 이미지, 멘트창.
--------------------------------------------------------------------
tWinName	= {['protecterr'] = 0, 'CM_NextInfoImage', 'CM_NextInfoWin'}
tTexName	= {['protecterr'] = 0, 'UIData/jobchange3.tga', 'UIData/tutorial001.tga'}
tTextureX	= {['protecterr'] = 0,    0,     0  }
tTextureY	= {['protecterr'] = 0,    0,     0  }
tSizeX		= {['protecterr'] = 0,  550,    1024}
tSizeY		= {['protecterr'] = 0,  706,    229 }
tPosX		= {['protecterr'] = 0,   0,    0  }
tPosY		= {['protecterr'] = 0,   62,   	526 }

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
	mywindow:setTexture("Enabled", tTexName[i], 0, 0);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setSize(tSizeX[i],tSizeY[i]);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setVisible(true);
	mywindow:setAlwaysOnTop(true);
	mywindow:setZOrderingEnabled(true);
	winMgr:getWindow("CM_NextInfoBack"):addChildWindow(mywindow);
end



--------------------------------------------------------------------
-- 최초입장 텍스트 그리기.
--------------------------------------------------------------------
tWinName = {['protecterr'] = 0, "CM_NextInfoTextName", "CM_NextInfoTextDesc"}
tPosX	= {['protecterr'] = 0,	75,			205}
tPosY	= {['protecterr'] = 0,	48,			53}
tSizeX	= {['protecterr'] = 0,	150,		700}
tSizeY	= {['protecterr'] = 0,	30,			70}

for i = 1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setPosition(tPosX[i], 53);
	mywindow:setSize(tSizeX[i], tSizeY[i]);	
	mywindow:setAlign(0);	
	mywindow:setViewTextMode(i);
	mywindow:setLineSpacing(15);
	mywindow:setVisible(true);
	mywindow:setProperty("Disabled", "true")
	winMgr:getWindow("CM_NextInfoWin"):addChildWindow(mywindow);
end

--winMgr:getWindow("CM_NextInfoTextName"):clearTextExtends();
winMgr:getWindow("CM_NextInfoTextName"):setTextExtends(PreCreateString_1369.."  : ", g_STRING_FONT_DODUMCHE, 18, 255,255,0,255,   3, 0,0,0,255)
														--GetSStringInfo(LAN_LUA_WND_VILLAGE_1)
--------------------------------------------------------------------
-- 챌린지 미션정보 알려주는 팝업 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_NextInfoCloseButton")

mywindow:setTexture("Normal", "UIData/Arcade_lobby.tga", 421, 308)
mywindow:setTexture("Hover", "UIData/Arcade_lobby.tga", 421, 360)
mywindow:setTexture("Pushed", "UIData/Arcade_lobby.tga", 421, 410)
mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 421, 308)

mywindow:setPosition(890, 150)
mywindow:setSize(103, 49)
mywindow:subscribeEvent("Clicked", "CM_NextInfoClose")
winMgr:getWindow("CM_NextInfoWin"):addChildWindow(mywindow)


-- 스피커맨 축하 메세지
local NextInfoText = CM_String_RewardText6


--------------------------------------------------------------------

-- 챌린지미션 다음정보 함수들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 닫기버튼
--------------------------------------------------------------------
function CM_NextInfoClose()
	local window = winMgr:getWindow("CM_NextInfoTextDesc")

	local Complete = CEGUI.toGUISheet(window):isCompleteViewText();
	
	if Complete then
		winMgr:getWindow("CM_NextInfoBack"):setVisible(false)
	else
		CEGUI.toGUISheet(window):setCompleteViewText(true);	
	end
end


--------------------------------------------------------------------
-- 보여준다
--------------------------------------------------------------------
function CM_NextInfoOpen()
	winMgr:getWindow("CM_NextInfoBack"):setVisible(true)
	local window = winMgr:getWindow("CM_NextInfoTextDesc")
	
	window:setVisible(true)
	CEGUI.toGUISheet(window):setTextViewDelayTime(11)
	window:clearTextExtends()
	window:addTextExtends(NextInfoText, g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   1, 0,0,0,255 );
end





--------------------------------------------------------------------

-- 이벤트 보상팝업

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 이벤트 보상팝업 알파
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardAlpha")
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




RegistEscEventInfo("CM_EventRewardAlpha", "EventPopUpClose")
RegistEnterEventInfo("CM_EventRewardAlpha", "EventPopUpClose")

--------------------------------------------------------------------
-- 이벤트 보상팝업
--------------------------------------------------------------------
local _1NUM_Y = 200
local _2NUM_Y = 310
local _3NUM_Y = 420
local _4NUM_Y = 534
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventReward_temp")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 674, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 674, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition((1024 / 2 - 350 / 2), (768 / 2 - _4NUM_Y / 2))
mywindow:setSize(350, _4NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventRewardAlpha"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardImg1")
mywindow:setTexture("Enabled", "UIData/other001.tga", 674, 0)
mywindow:setTexture("Disabled", "UIData/other001.tga", 674, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(350, _3NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventReward_temp"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardImg2")
mywindow:setTexture("Enabled", "UIData/other001.tga", 674, _3NUM_Y)
mywindow:setTexture("Disabled", "UIData/other001.tga", 674, _3NUM_Y)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, _3NUM_Y)
mywindow:setSize(350, _4NUM_Y-_3NUM_Y)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventReward_temp"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트받는 레벨 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', "CM_EventLevelText");
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(10, 50);
mywindow:setSize(319, 20);
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)

-- 방학 이벤트 임시 텍스트
mywindow = winMgr:createWindow('TaharezLook/StaticText', "CM_EventTempText");
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(10, 250)
mywindow:setSize(319, 20)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트 보상 뒷판
--------------------------------------------------------------------
tEventBackPos	= { ["protecterr"]=0, 80, 195, 310 }
tTextName		= { ["protecterr"]=0, "EventReward_ItemNameText", "EventReward_ItemDescText" } 
tTextPosY		= { ["protecterr"]=0, 10, 34, 58 }

for i = 1, #tEventBackPos do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardBack"..tostring(i))
	--zeustw --other001.tga 363, 558 좌표에 이미지가 없으므로 invisible.tga로 대체
	--mywindow:setTexture("Enabled", "UIData/other001.tga", 363, 558)
	--mywindow:setTexture("Disabled", "UIData/other001.tga", 363, 558)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 363, 558)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 363, 558)
	--zeustw
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, tEventBackPos[i])
	mywindow:setSize(319, 109)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardImg1"):addChildWindow(mywindow)
	
--------------------------------------------------------------------
-- 이벤트 보상아이템 뒷판
--------------------------------------------------------------------
--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardItemBack"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(7, 6)
	mywindow:setSize(105, 98)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
--]]

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardItem"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 652)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 652)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(20, 36)
	mywindow:setSize(105, 98)
	mywindow:setScaleWidth(170)
	mywindow:setScaleHeight(170)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventRewardPromotionIcon"..tostring(i))
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(26, 66)
	mywindow:setSize(87, 35)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CM_EventRewardItem"..tostring(i)):addChildWindow(mywindow)
	
	
	
	for j = 1, #tTextName do
		mywindow = winMgr:createWindow('TaharezLook/StaticText', tTextName[j]..tostring(i));
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(94, tTextPosY[j]);
		mywindow:setSize(145, 20);
		mywindow:setZOrderingEnabled(true)	
		mywindow:setViewTextMode(1)
		if j == 2 then
			mywindow:setAlign(1)
		else
			mywindow:setAlign(8)
		end
		mywindow:setLineSpacing(2)
		winMgr:getWindow("CM_EventRewardBack"..tostring(i)):addChildWindow(mywindow)
		
	end
end


--------------------------------------------------------------------
-- 이벤트안내 텍스트
--------------------------------------------------------------------
tEventPosY  = { ["protecterr"]=0, 5, 25 }
for i=1, #tEventPosY do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', 'CM_EventInfoText'..tostring(i));
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, tEventPosY[i]);
	mywindow:setSize(319, 20);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CM_EventRewardImg2"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 이벤트팝업창 닫기버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_EventPopupCloseButton")
mywindow:setTexture("Normal", "UIData/other001.tga", 1, 903)
mywindow:setTexture("Hover", "UIData/other001.tga", 1, 933)
mywindow:setTexture("Pushed", "UIData/other001.tga", 1, 963)
mywindow:setTexture("PushedOff", "UIData/other001.tga", 1, 903)
mywindow:setPosition(125, 58)
mywindow:setSize(87, 30)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "EventPopUpClose")
winMgr:getWindow("CM_EventRewardImg2"):addChildWindow(mywindow)





--------------------------------------------------------------------
-- 이벤트 보조팝업 알파
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupAlpha")
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


--------------------------------------------------------------------
-- Esc, Enter키 먹히게
--------------------------------------------------------------------
RegistEscEventInfo("CM_EventSubPopupAlpha", "GranEventClose")
RegistEnterEventInfo("CM_EventSubPopupAlpha", "GranEventClose")

--------------------------------------------------------------------
-- 이벤트 보조팝업
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopup")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition((1024 / 2 - 340 / 2), (768 / 2 - 200))
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("CM_EventSubPopupAlpha"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트 보조팝업 타이틀
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupTitle")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 340, 896)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 340, 896)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트 보조팝업 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CM_EventSubPopupButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 864, 485)
mywindow:setTexture("Hover", "UIData/popup001.tga", 864, 519)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 864, 553)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 864, 485)
mywindow:setPosition(133, 228)
mywindow:setSize(80, 34)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "GranEventClose")
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트 보조팝업 보상 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(37, 80)
mywindow:setSize(266, 105)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "SecondEndRender");
winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 이벤트 보조팝업 아이템 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardItemBack")
mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 652)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7, 6)
mywindow:setSize(105, 98)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopupRewardBack"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 이벤트 보조팝업 보상 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CM_EventSubPopupRewardImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(98, 91)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CM_EventSubPopupRewardItemBack"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 이벤트받는 레벨 텍스트
--------------------------------------------------------------------
local tEventTextName	= { ["protecterr"]=0, "CM_ComboEventText", "CM_GranEventText"}
local tEventTextPosY	= { ["protecterr"]=0, 50, 197}

for i = 1, #tEventTextName do
	mywindow = winMgr:createWindow('TaharezLook/StaticText', tEventTextName[i]);
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, tEventTextPosY[i]);
	mywindow:setSize(319, 20);
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CM_EventSubPopup"):addChildWindow(mywindow)
end	
	
	
	
--------------------------------------------------------------------

-- 이벤트 보상팝업 함수

--------------------------------------------------------------------
tEventLevel  = { ["protecterr"]=0, 3, 6, 9 }
local g_money = 0;
local g_PopupVisible	= false
local g_EventCount	= -1



--------------------------------------------------------------------
-- 이벤트창 보여준다.
--------------------------------------------------------------------
function ShowEventPopup(itemName1, itemName2, itemName3, itemFileName1, itemFileName2, itemFileName3, 
				itemDesc1, itemDesc2, itemDesc3, style1, style2, style3, itemPeriod1, itemPeriod2, itemPeriod3, Money, count)
	
	--itemFileName1 = "UIData/ItemUIData/Item/NPC_Quest2.tga"
	--itemFileName2 = "UIData/ItemUIData/Item/NPC_Quest2.tga"
	
	local tItemPromotionTexX  = { ["protecterr"]=0, 0, 0}
	local tItemPromotionTexY  = { ["protecterr"]=0, 0, 0}
	local tItemStyle		  = { ["protecterr"]=0, 0, 0}

	g_EventCount = count	-- 이벤트 (레벨5때 5천그랑 표현해주기위해)
	g_money		= Money;
	root:addChildWindow(winMgr:getWindow("CM_EventRewardAlpha"))
	winMgr:getWindow("CM_EventRewardAlpha"):setVisible(true);
	winMgr:getWindow("CM_EventRewardAlpha"):clearControllerEvent("EventMotion1")
	winMgr:getWindow("CM_EventRewardAlpha"):addController("EventMotion", "EventMotion1", "alpha", "Sine_EaseIn", 0, 255, 3, true, false, 10);
	winMgr:getWindow("CM_EventRewardAlpha"):activeMotion("EventMotion1");
	
	local my_name, money, level, promotion, my_style, type, sp_point, hp_point, experience = GetMyInfo(true);
	local My_promotion	= GetSStringInfo(my_style)	-- 직업
	
	-- 아이템 슬롯 초기화
	for i = 1, 3 do
		winMgr:getWindow("CM_EventRewardItem"..tostring(i)):setTexture("Disabled", "UIData/invisible.tga", 0, 652)
	end
	winMgr:getWindow("CM_EventLevelText"):clearTextExtends();
	winMgr:getWindow("CM_EventInfoText1"):clearTextExtends();
	
	-- 카운트에 따라.
	--if count ~= 3 then	-- 전직했을때
		if IsKoreanLanguage() then
			if count == 1 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("삼삼한 3,6,9 이벤트! [레벨 3 달성]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 2 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("삼삼한 3,6,9 이벤트! [레벨 6 달성]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 3 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("삼삼한 3,6,9 이벤트! [레벨 9 달성]", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 4 then
				winMgr:getWindow("CM_EventLevelText"):addTextExtends("[이벤트] 한판 붙어보자!!", g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			else
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_1042, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);		-- 축하합니다!
			end
		else
			if count == 5 then
				-- 태국 신규 유저 15레벨 보상
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4351, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 6 then
				-- 태국 신규 유저 1회 지급
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4349, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			elseif count == 7 then
				-- 매일 지급 하는 보상
				winMgr:getWindow("CM_EventLevelText"):addTextExtends(PreCreateString_4349, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
			end			
		end 
		
	if count == 7 then
		winMgr:getWindow("CM_EventInfoText1"):addTextExtends(PreCreateString_4350, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);	-- 이벤트 기간 동안 1일 1회 지급 합니다.
	else
		winMgr:getWindow("CM_EventInfoText1"):addTextExtends(CM_String_RewardGetMsg, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);	-- 축하합니다! 이벤트 보상을 획득하셨습니다.
	end
	--end
	--winMgr:getWindow("CM_EventInfoText2"):clearTextExtends();
	--winMgr:getWindow("CM_EventInfoText2"):addTextExtends("※ "..CM_String_RewardPresentBoxCurfirm, g_STRING_FONT_GULIM,13, 255,205,86,255, 0, 255,255,255,255);
	
	local ExpireTime = ""
	
	winMgr:getWindow("EventReward_ItemNameText1"):clearTextExtends();
	winMgr:getWindow("EventReward_ItemNameText2"):clearTextExtends();
	winMgr:getWindow("EventReward_ItemNameText3"):clearTextExtends();
	
	tItemStyle[1] = style1
	tItemStyle[2] = style2
	tItemStyle[3] = style3

	if itemName1 ~= "" then
	
		-- 아이템 그려준다..
		winMgr:getWindow("CM_EventRewardItem1"):setTexture("Disabled", itemFileName1, 0, 0)
		
		if itemPeriod1 == 0 then
			ExpireTime = "("..CM_String_UntilDelete..")"
		else
			ExpireTime = "("..tostring(itemPeriod1 / 24)..CM_String_Day..")"
		end
		
		if tItemStyle[1] >= 0 then
			local style		= tItemStyle[1] % 2
			local promotion = tItemStyle[1] / 2
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
			
			-- 스타일에따라 이름 색깔 틀리게 해주기 위해.
			if style == 0 then	--스트리트
				winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			else
				winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
			end
		else
			winMgr:getWindow("CM_EventRewardPromotionIcon1"):setVisible(false)
			winMgr:getWindow("EventReward_ItemNameText1"):addTextExtends('"'..itemName1..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
		end
	end

	-- 2번째 아이템
	if itemName2 == "" then
		if itemName3 == "" then
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _1NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _1NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(false)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(false)
		end
	else
		if itemName3 == "" then
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _2NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _2NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(false)
			
			---------------------------------
			-- 2번째 아이템 그려준다..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem2"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem2"):setTexture("Disabled", itemFileName2, 0, 0)
			
			if itemPeriod2 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod2 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[2] >= 0 then
				local style		= tItemStyle[2] % 2
				local promotion = tItemStyle[2] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- 스타일에따라 이름 색깔 틀리게 해주기 위해.
				if style == 0 then	--스트리트
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
		else
			winMgr:getWindow("CM_EventRewardImg1"):setSize(350, _3NUM_Y)
			winMgr:getWindow("CM_EventRewardImg2"):setPosition(0, _3NUM_Y)
			winMgr:getWindow("CM_EventRewardBack1"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack2"):setVisible(true)
			winMgr:getWindow("CM_EventRewardBack3"):setVisible(true)
			
			---------------------------------
			-- 2번째 아이템 그려준다..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem2"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem2"):setTexture("Disabled", itemFileName2, 0, 0)
			
			if itemPeriod2 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod2 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[2] >= 0 then
				local style		= tItemStyle[2] % 2
				local promotion = tItemStyle[2] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- 스타일에따라 이름 색깔 틀리게 해주기 위해.
				if style == 0 then	--스트리트
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon2"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText2"):addTextExtends('"'..itemName2..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
				
			---------------------------------
			-- 3번째 아이템 그려준다..
			---------------------------------
			winMgr:getWindow("CM_EventRewardItem3"):setSize(100, 100)
			winMgr:getWindow("CM_EventRewardItem3"):setTexture("Disabled", itemFileName3, 0, 0)
			
			if itemPeriod3 == 0 then
				ExpireTime = "("..CM_String_UntilDelete..")"
			else
				ExpireTime = "("..tostring(itemPeriod3 / 24)..CM_String_Day..")"
			end
			
			if tItemStyle[3] >= 0 then
				local style		= tItemStyle[3] % 2
				local promotion = tItemStyle[3] / 2
			
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setVisible(true)
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][0], tAttributeImgTexYTable[style][0])
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				-- 스타일에따라 이름 색깔 틀리게 해주기 위해.
				if style == 0 then	--스트리트
					winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
				else
					winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 254,120,120,255, 0, 0,0,0,255);
				end
			else
				winMgr:getWindow("CM_EventRewardPromotionIcon3"):setVisible(false)
				winMgr:getWindow("EventReward_ItemNameText3"):addTextExtends('"'..itemName3..'" ', g_STRING_FONT_DODUM,12, 97,230,255,255, 0, 0,0,0,255);
			end
		end
	end
	
	local tDesc =  { ["protecterr"]=0, itemDesc1, itemDesc2, itemDesc3 }
	
	--Description 쪼개기
	for i=1, #tDesc do
		winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):clearTextExtends();
		
		if tDesc[i] ~= "" then
						
			local _DescStart, _DescEnd = string.find(tDesc[i], "%$");
			local _ItemSkillKind = "";		--스킬종류
			local _ItemSkillDamage = "";	--스킬데미지
			local _ItemDetailDesc = "";		--스킬설명
			
			if _DescStart ~= nil then
				_ItemSkillKind = string.sub(tDesc[i], 1, _DescStart - 1);
				_ItemDetailDesc = string.sub(tDesc[i], _DescEnd + 1);
			
				_DescStart, _DescEnd = string.find(_ItemDetailDesc, "%$");
				if _DescStart ~= nil then
					_ItemSkillDamage = string.sub(_ItemDetailDesc, 1, _DescStart - 1);
					_ItemDetailDesc = string.sub(_ItemDetailDesc, _DescEnd + 1);
				end
				_ItemDetailDesc = AdjustString(g_STRING_FONT_GULIM, 11, _ItemDetailDesc, 180)
				winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):addTextExtends(_ItemDetailDesc, g_STRING_FONT_DODUM,11, 255,205,86,255, 1, 0,0,0,255);
			else
				tDesc[i] = AdjustString(g_STRING_FONT_GULIM, 11, tDesc[i], 180)
				winMgr:getWindow("EventReward_ItemDescText"..tostring(i)):addTextExtends(tDesc[i], g_STRING_FONT_DODUM,11, 255,205,86,255, 1, 30,30,30,255);
			end
		end
	end
end

winMgr:getWindow("CM_EventRewardBack2"):subscribeEvent("EndRender", "EventEndRender");

--------------------------------------------------------------------
-- 이벤트창 랜더.
--------------------------------------------------------------------
function EventEndRender()
	if g_PopupVisible then
		local drawer = winMgr:getWindow("CM_EventRewardBack2"):getDrawer()
		
		local _left = DrawEachNumber("UIData/other001.tga", g_money, 8, 185, 34, 11, 683, 24, 33, 25 , drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 32, 30, 29, 266, 685)
	end
end

--------------------------------------------------------------------
-- 이벤트창 닫기
--------------------------------------------------------------------
function EventPopUpClose()
	g_PopupVisible = false
	winMgr:getWindow("CM_EventRewardAlpha"):setVisible(false);
	winMgr:getWindow("CM_EventRewardAlpha"):clearControllerEvent("EventMotion1")
	EventDelete()
	EventPopupOpen()
	--if g_EventCount == 1 then
	--	GranEventOpen()
	--else
		CMRewardOKButtonEvent();
	--end
end

--------------------------------------------------------------------
-- 이벤트 팝업 오픈 메세지
--------------------------------------------------------------------
function EventPopupOpen()
	if winMgr:getWindow("CM_RewardPopupAlpha"):isVisible() == false then
		GetEvent()
	end
end


--------------------------------------------------------------------
-- 이벤트 보조팝업 오픈
--------------------------------------------------------------------
function GranEventOpen()
	g_PopupVisible = true
	winMgr:getWindow("CM_EventSubPopupAlpha"):setVisible(true)
	winMgr:getWindow("CM_EventSubPopupAlpha"):clearControllerEvent("SecondEventMotion")
	winMgr:getWindow("CM_EventSubPopupAlpha"):addController("EventMotion", "SecondEventMotion", "alpha", "Sine_EaseIn", 0, 255, 2, true, false, 10);
	winMgr:getWindow("CM_EventSubPopupAlpha"):activeMotion("SecondEventMotion");
	winMgr:getWindow("CM_ComboEventText"):clearTextExtends()
	winMgr:getWindow("CM_GranEventText"):clearTextExtends()
	
	winMgr:getWindow("CM_ComboEventText"):addTextExtends(PreCreateString_1042, g_STRING_FONT_GULIM,15, 255,205,86,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_GranEventText"):addTextExtends(CM_String_RewardGetMsg, g_STRING_FONT_GULIM,12, 255,255,255,255, 0, 255,255,255,255);
	winMgr:getWindow("CM_EventSubPopupRewardImage"):setTexture("Enabled", "UIData/GameSlotItem001.tga", 392, 842)
	winMgr:getWindow("CM_EventSubPopupRewardImage"):setTexture("Disabled", "UIData/GameSlotItem001.tga", 392, 842)
	
end


--------------------------------------------------------------------
-- 이벤트 보조팝업 닫기
--------------------------------------------------------------------
function GranEventClose()
	g_PopupVisible = false
	winMgr:getWindow("CM_EventSubPopupAlpha"):setVisible(false)
	winMgr:getWindow("CM_EventSubPopupAlpha"):clearControllerEvent("SecondEventMotion")
	CMRewardOKButtonEvent();

end


--------------------------------------------------------------------
-- 이벤트 보조팝업 랜더
--------------------------------------------------------------------
function SecondEndRender()
	if g_PopupVisible then
		local drawer = winMgr:getWindow("CM_EventSubPopupRewardBack"):getDrawer()
		
		local _left = DrawEachNumber("UIData/other001.tga", g_money, 8, 185, 34, 11, 683, 24, 33, 25 , drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 32, 30, 29, 266, 685)
	end

end



--------------------------------------------------------------------
-- 레벨업 이벤트
--------------------------------------------------------------------



