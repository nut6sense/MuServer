--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")


-- 아이콘의 타입 인덱스
local Icon_Type_Npc = 0
local Icon_Type_Map = 1
local Max_ConditionIndex = 5


-- 보상 타입 =================
local REWARDTYPE_NON	= 0
local REWARDTYPE_EXP	= 1
local REWARDTYPE_ZEN	= 2
local REWARDTYPE_COIN	= 3
local REWARDTYPE_CASH	= 4
local REWARDTYPE_ITEM	= 5
local REWARDTYPE_MAX	= 6
-- ===========================
		

local QuestTypeImgTableX = {['err']=0, 1010, 994,  1010}
local QuestTypeImgTableY = {['err']=0, 1009, 1009,  994}
local BasePosX = 247
local BasePosY = 318

local BasePosX = {['protecterr'] = 0, 320, 324}
local BasePosY = {['protecterr'] = 0, 293, 343}

-- 퀘스트 아이콘을 생성해준다.
function CreateQuestIcon(index, questType, pX, pY)
	local ViallgeType = GetVillageType()
	local isDrawable = 1;
	if winMgr:getWindow("MapQuestIcon_"..index) ~= nil then
		local PrevQuestType = tonumber(winMgr:getWindow("MapQuestIcon_"..index):getUserString("QuestType"))
		if PrevQuestType == questType then
			return
		end
		if PrevQuestType == 1 then
			if questType == 2 then
				isDrawable = 0;
			elseif questType == 3 then
				isDrawable = 1;
			end
		elseif PrevQuestType == 2 then
			if questType == 1 then
				isDrawable = 1; 
			elseif questType == 3 then
				isDrawable = 1;
			end
		elseif PrevQuestType == 3 then
			if questType == 1 then 
				isDrawable = 0;
			elseif questType == 2 then
				isDrawable = 0;
			end
		end
	end
	if isDrawable == 0 then
		return; 
	end
	
	ClearQuestIcon(index)	
	-- 미니맵에 붙여준다
	if winMgr:getWindow("MapQuestIcon_"..index) == nil then
		if winMgr:getWindow("MaxMapMainImg") then
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MapQuestIcon_"..index)
			mywindow:setUserString("QuestType", tostring(questType))
			mywindow:setTexture("Enabled", "UIData/quest3.tga", QuestTypeImgTableX[questType], QuestTypeImgTableY[questType])
			--DebugStr("Create QI NPC Idx  : " .. index .. "/// Quest Type " .. questType)
			if ViallgeType == 20 then
				mywindow:setPosition(pX + 4, pY - 17)
			else
				if index == 14 then
					mywindow:setPosition(pX - 6, pY - 45)
				else
					mywindow:setPosition(pX + 6, pY - 50)
				end
			end
			mywindow:setSize(15, 15)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(true)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow("MaxMapMainImg"):addChildWindow(mywindow)
		end
	end
end
-- 

function MarkIconMiniMap(bVisible, index)
	
	

end


-- 


-- 해당되는 퀘스트의 아이콘을 없애준다.
function ClearQuestIcon(index)
	--DebugStr("Clear 퀘스트 아이콘");
	if winMgr:getWindow("MapQuestIcon_"..index) ~= nil then
		winMgr:destroyWindow(winMgr:getWindow("MapQuestIcon_"..index))
	end
end








-- 퀘스트 보기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuest_ShowButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 439, 109)
mywindow:setTexture("Hover", "UIData/quest4.tga", 439, 156)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 439, 203)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 439, 203)
mywindow:setPosition(10, 300)
mywindow:setSize(47, 47)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ShowMyQuestMainWindow")
root:addChildWindow(mywindow)






-----------------------------------------
--퀘스트 클릭시 나오는 퀘스트 선택버튼
-----------------------------------------
-- 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SelectListBack")
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 281, 72)
mywindow:setPosition(70, 70)
mywindow:setSize(264, 316)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEscEventInfo("MyQuest_SelectListBack", "MyQuest_SelectCloseEvent")

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuest_SelectCloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(235, 5)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MyQuest_SelectCloseButtonEvent")
winMgr:getWindow("MyQuest_SelectListBack"):addChildWindow(mywindow)

-- 윈도우 타이틀(퀘스트)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuest_SelectTitle")
mywindow:setPosition(0, 9)
mywindow:setSize(264, 18)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(PreCreateString_2853, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
winMgr:getWindow("MyQuest_SelectListBack"):addChildWindow(mywindow)



-- 현재 내가 수행 할 수 있는 퀘스트 선택버튼을 만들어준다,
function MakeQuestButton(index, titleNameIndex, questState, questNumber, NPCIdx)
	if winMgr:getWindow("MyQuest_SelectBtn_"..index) == nil then
		mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuest_SelectBtn_"..index)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 281, 388)
		mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 281, 388)
		mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 281, 388)
		mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 281, 388)
		mywindow:setPosition(6,35+index*23)
		mywindow:setSize(252, 23)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)		
		mywindow:setUserString("questState", tostring(questState))
		mywindow:setUserString("questNumber", tostring(questNumber))
		mywindow:setUserString("questNPCIndex", tostring(NPCIdx))
		
		mywindow:setUserString("Index", tostring(index))
		mywindow:subscribeEvent("MouseButtonDown", "MyQuestBtn_Type_MouseDown")
		mywindow:subscribeEvent("MouseButtonUp", "MyQuestBtn_Type_MouseUp")
		mywindow:subscribeEvent("MouseLeave", "MyQuestBtn_Type_MouseLeave")
		mywindow:subscribeEvent("MouseEnter", "MyQuestBtn_Type_MouseEnter")
		mywindow:subscribeEvent("Clicked", "MyQuestBtn_Type_ClickEvent")--tButtonTypeEventTable[i])
		winMgr:getWindow("MyQuest_SelectListBack"):addChildWindow(mywindow)	

		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SelectBtn_Img_"..index)
		mywindow:setTexture("Enabled", "UIData/quest3.tga", QuestTypeImgTableX[questState], QuestTypeImgTableY[questState])
		mywindow:setPosition(4, 4)
		mywindow:setSize(15, 15)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("MyQuest_SelectBtn_"..index):addChildWindow(mywindow)

		-- 텍스트
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuest_SelectBtn_Text_"..index)
		mywindow:setFont(g_STRING_FONT_DODUM, 13)
		mywindow:setTextColor(255,198,30, 255)
		mywindow:setText(GetSStringInfo(titleNameIndex))
		DebugStr("GetSStringInfo를 실행하고 있습니다".. titleNameIndex)
		mywindow:setPosition(20, 4)
		mywindow:setSize(207, 16)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)	
		winMgr:getWindow("MyQuest_SelectBtn_"..index):addChildWindow(mywindow)
	else
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setVisible(true)
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setUserString("questState", tostring(questState))
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setUserString("questNumber", tostring(questNumber))
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setUserString("questNPCIndex", tostring(NPCIdx))	
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setUserString("Index", tostring(index))
		winMgr:getWindow("MyQuest_SelectBtn_"..index):setPosition(6,35+index*23)
		winMgr:getWindow("MyQuest_SelectBtn_Img_"..index):setTexture("Enabled", "UIData/quest3.tga", QuestTypeImgTableX[questState], QuestTypeImgTableY[questState])
		winMgr:getWindow("MyQuest_SelectBtn_Text_"..index):setText(GetSStringInfo(titleNameIndex))		
	end
end


-- 퀘스트 선택버튼을 모두 숨겨준다,(해당되는 것만 띄워주기 위해서,)
function HideQuestButton()
	for i=0,10 do
		if winMgr:getWindow("MyQuest_SelectBtn_"..i) then
			winMgr:getWindow("MyQuest_SelectBtn_"..i):setVisible(false)
		end
	end
end

-- 엔피씨에따라 다른 위치로 윈도우를 띄워준다.
function SettingPosQuestButton(Index)
--	for i=0,10 do
		if winMgr:getWindow("MyQuest_SelectBtn_"..Index) then
			winMgr:getWindow("MyQuest_SelectBtn_"..Index):setPosition(6, 35+Index*23)			
		end
--	end	
end          



-- 퀘스트에 해당하는 버튼의 이벤트(효과)
local bTextEvent = false
function MyQuestBtn_Type_MouseDown(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local Index = tonumber(eventWindow:getUserString("Index"))

	local pos = winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):getPosition()
	winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):setPosition(pos.x.offset + 2, pos.y.offset + 2)
	bTextEvent = true
end


function MyQuestBtn_Type_MouseUp(args)
	if bTextEvent then
		local eventWindow = CEGUI.toWindowEventArgs(args).window
		local Index = tonumber(eventWindow:getUserString("Index"))
		local pos = winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):getPosition()
		winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):setPosition(pos.x.offset - 2, pos.y.offset - 2)
		bTextEvent = false
	end
end


local bTextMouseMoveEvent = false
function MyQuestBtn_Type_MouseLeave(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local Index = tonumber(eventWindow:getUserString("Index"))
	winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):setTextColor(255,198,30, 255)
	bTextMouseMoveEvent = true
end

function MyQuestBtn_Type_MouseEnter(args)
	if bTextMouseMoveEvent then
		local eventWindow = CEGUI.toWindowEventArgs(args).window
		local Index = tonumber(eventWindow:getUserString("Index"))
		winMgr:getWindow("MyQuest_SelectBtn_Text_"..Index):setTextColor(255, 255, 255, 255)
		bTextEvent = false
	end
end


-- 엔피씨의 퀘스트 목록에서 선택했을 때 이벤트
function MyQuestBtn_Type_ClickEvent(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	
	local questState  = tonumber(eventWindow:getUserString("questState"))
	local questNumber = tonumber(eventWindow:getUserString("questNumber"))
	local Index		  = tonumber(eventWindow:getUserString("Index"))
	local NPCIdx	  =  tonumber(eventWindow:getUserString("questNPCIndex"))

	winMgr:getWindow("MyQuest_SelectListBack"):setVisible(false)
	ShowMyQuestDetailInfo(questState, questNumber, 0, NPCIdx)
	QuestListBtnClickEvent(questNumber, 1)	-- 퀘스트의 상세 정보를 요청한다.
	
	
--	ShowMyQuestTelling(NpcName, String)
	

end



-- 내 퀘스트 선택 리스트를 띄워준다.
function ShowMyQuestSelectList()
	root:addChildWindow(winMgr:getWindow("MyQuest_SelectListBack"))
	winMgr:getWindow("MyQuest_SelectListBack"):setVisible(true)
end



function MyQuest_SelectCloseEvent()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyQuest_SelectListBack"):setVisible(false)	
end


-- 내 퀘스트 선택 리스트를 숨겨준다.
function MyQuest_SelectCloseButtonEvent()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyQuest_SelectListBack"):setVisible(false)
	TownNpcEscBtnClickEvent()	
end






mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoMainBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(653, 20)
mywindow:setSize(352, 502)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoMainBack2")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(653, 20)
mywindow:setSize(352, 502)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEscEventInfo("MyQuestDetailInfoMainBack", "MyQuestDetailInfoMain_FirstOkButtonEvent")
RegistEscEventInfo("MyQuestDetailInfoMainBack2", "HideMyQuestDetailInfo")


-------------------------------------------------------------
-- 퀘스트의 상세 정보가 나오는 Main윈도우
-------------------------------------------------------------
-------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoMain")
mywindow:setTexture("Enabled", "UIData/quest4.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/quest4.tga", 0, 0)
mywindow:setPosition(400, 200)
mywindow:setSize(352, 502)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoTitleImg")
mywindow:setTexture("Enabled", "UIData/quest4.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/quest4.tga", 0, 0)
mywindow:setPosition(140, 10)
mywindow:setSize(73, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 닫기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestDetailInfoMain_CloseButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 439, 0)
mywindow:setTexture("Hover", "UIData/quest4.tga", 439, 23)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 439, 45)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 439, 45)
mywindow:setPosition(325, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMyQuestDetailInfo")
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


RegistEscEventInfo("MyQuestDetailInfoMain", "HideMyQuestDetailInfo")

-- 퀘스트 제목
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoTitleText")
mywindow:setPosition(32, 51)
mywindow:setSize(120, 14)
mywindow:setAlign(1)
mywindow:setLineSpacing(3)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)



-- 퀘스트 설명
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoDescText")
mywindow:setPosition(23, 90)
mywindow:setSize(305, 20)
mywindow:setAlign(1)
mywindow:setLineSpacing(3)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 퀘스트 스토리
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoStoryText")
mywindow:setPosition(23, 225)
mywindow:setSize(305, 20)
mywindow:setAlign(1)
mywindow:setLineSpacing(3)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 엔피씨 텔링
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoNpcTellingText")
mywindow:setPosition(23, 225)
mywindow:setSize(305, 20)
mywindow:setAlign(1)
mywindow:setLineSpacing(3)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)



-- 보상
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoReward")
mywindow:setTexture("Disabled", "UIData/quest4.tga", 439, 69)
mywindow:setPosition(7, 320)
mywindow:setSize(73, 20)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 임무
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoMissionImg")
mywindow:setTexture("Disabled", "UIData/quest4.tga", 439, 418)
mywindow:setPosition(7, 320)
mywindow:setSize(73, 20)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 
local Reward_FirstPosY = 350


function RewardTypeWindowCreate(type, count, value)
	-- 보상타입에 따라 보여주는 이미지나
	local texY = 0
	local unit = ""

	if type == REWARDTYPE_EXP then		-- 경험치
		texY = 36
		unit = " EXP"
	elseif type == REWARDTYPE_ZEN then	-- 젠
		texY = 0
		unit = " ZEN"
	elseif type == REWARDTYPE_COIN then	-- 코인
		texY = 18
		unit = " COIN"
	elseif type == REWARDTYPE_CASH then	-- 캐시
		return
	elseif type == REWARDTYPE_ITEM then	-- 아이템
	
	else	-- 암것도 아니다.
		return
	end	
	winMgr:getWindow("MyQuestDetailInfoReward"):setVisible(true)

	if winMgr:getWindow("MyQuestDetailInfoReward_"..count) == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoReward_"..count)
		mywindow:setTexture("Disabled", "UIData/quest4.tga", 462, texY)
		mywindow:setPosition(22 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		mywindow:setSize(18, 18)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
		
		-- 돈 값
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoReward_Value_"..count)
		local r,g,b = ColorToMoney(value)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setTextColor(r,g,b,255)
		mywindow:setPosition(50 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		mywindow:setSize(66, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setText(CommatoMoneyStr(value))
		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
		
		-- 돈 값
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoReward_ValueUnit_"..count)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setTextColor(255,255,255,255)
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CommatoMoneyStr(value))
		mywindow:setPosition(size + 53 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		mywindow:setSize(66, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setText(unit)
		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
		
		
	else	
		winMgr:getWindow("MyQuestDetailInfoReward_"..count):setTexture("Disabled", "UIData/quest4.tga", 462, texY)
		winMgr:getWindow("MyQuestDetailInfoReward_"..count):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoReward_"..count):setPosition(22 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		
		local r,g,b = ColorToMoney(value)
		winMgr:getWindow("MyQuestDetailInfoReward_Value_"..count):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoReward_Value_"..count):setPosition(50 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		winMgr:getWindow("MyQuestDetailInfoReward_Value_"..count):setTextColor(r,g,b,255)
		winMgr:getWindow("MyQuestDetailInfoReward_Value_"..count):setText(CommatoMoneyStr(value))
		
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CommatoMoneyStr(value))
		winMgr:getWindow("MyQuestDetailInfoReward_ValueUnit_"..count):setPosition(size + 53 + (count%2) * 150, Reward_FirstPosY + (count/2) * 22)
		winMgr:getWindow("MyQuestDetailInfoReward_ValueUnit_"..count):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoReward_ValueUnit_"..count):setText(unit)
		
		
	end
end



-- 보상 초기화
function RewardTypeWindowClear()
	-- 돈종류 초기화
	winMgr:getWindow("MyQuestDetailInfoReward"):setVisible(false)
	for i=0, 6 do
		if winMgr:getWindow("MyQuestDetailInfoReward_"..i) then
			winMgr:getWindow("MyQuestDetailInfoReward_"..i):setVisible(false)
			winMgr:getWindow("MyQuestDetailInfoReward_Value_"..i):setVisible(false)
			winMgr:getWindow("MyQuestDetailInfoReward_ValueUnit_"..i):setVisible(false)
		end
	end

	-- 보상 아이템 초기화
	if winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg") then
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg"):setVisible(false)	
	end
	for i=0, 5 do
		if winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..i) then
			winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..i):setVisible(false)
			winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..i):setVisible(false)
			winMgr:getWindow("MyQuestDetailInfoItemReward_Count_"..i):setVisible(false)
			--winMgr:getWindow("MyQuestDetailInfoItemReward_itemName_"..i):setVisible(false)
		end
	end
end



-- 보상이 아이템이라면 아이템에따른 윈도우 생성해준다.
function ItemRewardWindowCreate(BaseposY, count, value, itemNumber, fileName, fileName2, itemName)
	if winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg") == nil then
--		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoItemRewardBackImg")
--		mywindow:setTexture("Enabled", "UIData/quest3.tga", 0, 558)
--		mywindow:setPosition(17, BaseposY)
--		mywindow:setSize(310, 71)
--		mywindow:setVisible(true)
--		mywindow:setAlwaysOnTop(true)
--		mywindow:setZOrderingEnabled(false)
--		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
	else
--			winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg"):setVisible(true)	
	end	
	
	if winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count) == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoItemRewardBackImg_"..count)
		mywindow:setTexture("Enabled", "UIData/quest3.tga", 233, 700)--0, 558)
		mywindow:setPosition(17 +count * 74 , BaseposY)
		mywindow:setSize(71, 71)--310, 71)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoItemRewardItemImg_"..count)
		mywindow:setTexture("Enabled", fileName, 0, 0)
		if fileName2 == "" then
			mywindow:setLayered(false)
		else
			mywindow:setTexture("Layered", fileName2, 0, 0)
			mywindow:setLayered(true)
		end
		mywindow:setPosition(8, 8)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(140)
		mywindow:setScaleHeight(140)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):addChildWindow(mywindow)
				
		
		-- 툴팁 이벤트를 위한 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoItemRewardEvent_"..count)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(5,5)
		mywindow:setSize(61, 61)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", count)
		mywindow:subscribeEvent("MouseEnter", "MouseEnter_MyQuestDetailInfo")
		mywindow:subscribeEvent("MouseLeave", "MouseLeave_MyQuestDetailInfo")
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):addChildWindow(mywindow)
		
		
		-- 아이템 갯수 카운트
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoItemReward_Count_"..count)
		mywindow:setPosition(4, 6)
		mywindow:setSize(62, 20)
		mywindow:setAlign(6)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		mywindow:setTextExtends("x "..value, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):addChildWindow(mywindow)
		
--[[		
		-- 아이템 이름
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoItemReward_itemName_"..count)
		mywindow:setPosition(86, 6)
		mywindow:setSize(200, 60)
		mywindow:setAlign(5)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		mywindow:setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):addChildWindow(mywindow)
--]]			
		
	else
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):setVisible(true)	
		winMgr:getWindow("MyQuestDetailInfoItemRewardBackImg_"..count):setPosition(17 +count * 74 , BaseposY)
		-- 아이템 이미지
		winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..count):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..count):setTexture("Enabled", fileName, 0, 0)
		if fileName2 == "" then
			winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..count):setLayered(false)
		else
			winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..count):setTexture("Layered", fileName2, 0, 0)
			winMgr:getWindow("MyQuestDetailInfoItemRewardItemImg_"..count):setLayered(true)
		end		
		-- 아이템 갯수		
		if value > 1 then
			winMgr:getWindow("MyQuestDetailInfoItemReward_Count_"..count):setVisible(true)
			winMgr:getWindow("MyQuestDetailInfoItemReward_Count_"..count):setTextExtends("x "..value, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
		end
		-- 아이템 이름
--		winMgr:getWindow("MyQuestDetailInfoItemReward_itemName_"..count):setVisible(true)
--		winMgr:getWindow("MyQuestDetailInfoItemReward_itemName_"..count):setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	end	
end





-- 선택보상
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoSelectReward")
mywindow:setTexture("Disabled", "UIData/quest4.tga", 439, 89)
mywindow:setPosition(20, 300)
mywindow:setSize(73, 20)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)



-- 완료 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestDetailInfoMain_OKButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 352, 120)
mywindow:setTexture("Hover", "UIData/quest4.tga", 352, 150)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 352, 180)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 352, 180)
mywindow:setTexture("Disabled", "UIData/quest4.tga", 352, 210)
mywindow:setPosition(15, 455)
mywindow:setSize(87, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("questNumber", tostring(0))
mywindow:setUserString("NPCIdx", tostring(-1))
mywindow:subscribeEvent("Clicked", "MyQuestDetailInfoMain_OKEvent")
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)

-- 수락
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestDetailInfoMain_AcceptButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 423, 298)
mywindow:setTexture("Hover", "UIData/quest4.tga", 423, 328)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 423, 358)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 423, 358)
mywindow:setTexture("Disabled", "UIData/quest4.tga", 423, 388)
mywindow:setPosition(15, 455)
mywindow:setSize(87, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("questNumber", tostring(0))
mywindow:setUserString("NPCIdx", tostring(-1))
mywindow:subscribeEvent("Clicked", "MyQuestDetailInfoMain_AcceptEvent")
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 리스트 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestDetailInfoMain_CancelButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 352, 0)
mywindow:setTexture("Hover", "UIData/quest4.tga", 352, 30)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 352, 60)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 352, 60)
mywindow:setTexture("Disabled", "UIData/quest4.tga", 352, 90)
mywindow:setPosition(250, 455)
mywindow:setSize(87, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMyQuestDetailInfo")
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 선택보상
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestDetailInfoEventImg")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 439, 89)
mywindow:setPosition(20, 300)
mywindow:setSize(1, 1)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


-- 처음 들어왔을때 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestDetailInfoMain_FirstOkButton")
mywindow:setTexture("Normal", "UIData/quest2.tga", 352, 0)
mywindow:setTexture("Hover", "UIData/quest2.tga", 352, 30)
mywindow:setTexture("Pushed", "UIData/quest2.tga", 352, 60)
mywindow:setTexture("PushedOff", "UIData/quest2.tga", 352, 60)
mywindow:setTexture("Disabled", "UIData/quest2.tga", 352, 90)
mywindow:setPosition(250, 455)
mywindow:setSize(87, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MyQuestDetailInfoMain_FirstOkButtonEvent")
winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)


RegistEnterEventInfo("MyQuestDetailInfoMainBack2", "MyQuestDetailInfoMain_OKEvent")
RegistEnterEventInfo("MyQuestDetailInfoMainBack2", "MyQuestDetailInfoMain_AcceptEvent")
RegistEnterEventInfo("MyQuestDetailInfoMainBack", "MyQuestDetailInfoMain_OKEvent")
RegistEnterEventInfo("MyQuestDetailInfoMainBack", "MyQuestDetailInfoMain_AcceptEvent")



-- 마우스가 들어왔을때.
function MouseEnter_MyQuestDetailInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemNumber = GetMyQuestToolTipInfo(index)

	DebugStr(itemNumber)
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	GetToolTipBaseInfo(x + 65, y, 4, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

end

-- 마우스가 나갔을 때
function MouseLeave_MyQuestDetailInfo(args)
	SetShowToolTip(false)
end
	

-- 띄워줄 기본 위치를 잡아서 윈도우를 만든다.
function CreateQuestConditionWindow(index, basePosY, string, currentCount, maxCount, bCompletion, bShowTime)
	
	if maxCount > 0 then
		string = string.."( "..currentCount.." / "..maxCount.." )"
	end	
	string = AdjustString(g_STRING_FONT_DODUMCHE, 12, string, 337)
	-- 해당 윈도우가 없다면
	if winMgr:getWindow("MyQuestDetailInfoConditionText_"..index) == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoConditionText_"..index)
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 11)
		if bCompletion == 1 then	-- 
			mywindow:setTextColor(35, 255, 97, 255)
		else
			if maxCount ~= 0 and (currentCount-maxCount) >= 0 then
				mywindow:setTextColor(35, 255, 97, 255)
			else
				mywindow:setTextColor(255, 180, 28, 255)
			end	
		end
				
		mywindow:setPosition(23, basePosY + (index * 20))
		mywindow:setSize(305, 20)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setText(string)
		winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)	
						
	else
		if bCompletion == 1 then	-- 
			winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setTextColor(35, 255, 97, 255)
		else
			if maxCount ~= 0 and (currentCount-maxCount) >= 0 then
				winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setTextColor(35, 255, 97, 255)
			else
				winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setTextColor(255, 180, 28, 255)
			end	
		end	
		winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setPosition(23, basePosY + (index * 20))	
		winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoConditionText_"..index):setText(string)
	end
	if bShowTime then
		if winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText") == nil then
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestDetailInfoConditionbShowTimeText")
			mywindow:setFont(g_STRING_FONT_DODUMCHE, 11)
			if bCompletion == 1 then	-- 
				mywindow:setTextColor(35, 255, 97, 255)
			else
				if maxCount ~= 0 and (currentCount-maxCount) >= 0 then
					mywindow:setTextColor(35, 255, 97, 255)
				else
					mywindow:setTextColor(255, 180, 28, 255)
				end	
			end
					
			mywindow:setPosition(195, basePosY + (index * 20))
			mywindow:setSize(305, 20)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(true)
			mywindow:setZOrderingEnabled(false)
			winMgr:getWindow("MyQuestDetailInfoMain"):addChildWindow(mywindow)
		else
			if bCompletion == 1 then	-- 
				winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setTextColor(35, 255, 97, 255)
			else
				if maxCount ~= 0 and (currentCount-maxCount) >= 0 then
					winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setTextColor(35, 255, 97, 255)
				else
					winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setTextColor(255, 180, 28, 255)
				end	
			end	
			winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setPosition(195, basePosY + (index * 20))	
			winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setVisible(true)
		end
	else
		if winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText") ~= nil then
			winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setVisible(false)
			winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setPosition(195, basePosY + (index * 20))	
		end
	end
end

-- 퀘스트 세부정보를 클리어해준다.
function ClearMyQuestDetailInfo()
	winMgr:getWindow("MyQuestDetailInfoTitleText"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoDescText"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoStoryText"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setVisible(false)
end


-- 퀘스트 세부정보를 클리어해준다.
function ClearMyQuestConditionInfo()
	for i=0, Max_ConditionIndex-1 do
		if winMgr:getWindow("MyQuestDetailInfoConditionText_"..i) then
			winMgr:getWindow("MyQuestDetailInfoConditionText_"..i):setVisible(false)
		end
	end
	if winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText") then
		winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setVisible(false)
	end
end







-- 퀘스트 이름, 퀘스트 스토리, 퀘스트 설명, 퀘스트 조건, 보상
function SettingMyQuestDetailInfo(Name, windowState)
										
	if windowState == 0 then		-- 퀘스트 상태(클릭시)
		winMgr:getWindow("MyQuestDetailInfoDescText"):setVisible(true)	-- 설명
		winMgr:getWindow("MyQuestDetailInfoDescText"):setPosition(23, 90)
		
		winMgr:getWindow("MyQuestDetailInfoStoryText"):setVisible(true)	-- 스토리
		winMgr:getWindow("MyQuestDetailInfoStoryText"):setPosition(23, 225)
		
		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setVisible(false)	-- 엔피씨 텔링
		winMgr:getWindow("MyQuestDetailInfoMissionImg"):setVisible(false)		-- 임무 이미지
				
	elseif windowState == 1 or windowState == 2 then	-- 받기전
		winMgr:getWindow("MyQuestDetailInfoStoryText"):setVisible(true)			-- 스토리
		winMgr:getWindow("MyQuestDetailInfoStoryText"):setPosition(23, 90)
		
		winMgr:getWindow("MyQuestDetailInfoMissionImg"):setVisible(true)		-- 임무 이미지
		winMgr:getWindow("MyQuestDetailInfoMissionImg"):setPosition(7, 219)
				
		winMgr:getWindow("MyQuestDetailInfoDescText"):setVisible(true)			-- 설명
		winMgr:getWindow("MyQuestDetailInfoDescText"):setPosition(23, 245)
		
		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setVisible(false)	-- 엔피씨 텔링
				
--	elseif windowState == 2 then
--		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setVisible(true)	-- 엔피씨 텔링
--		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setPosition(23, 90)
--		
--		winMgr:getWindow("MyQuestDetailInfoDescText"):setVisible(false)	-- 설명
--		winMgr:getWindow("MyQuestDetailInfoStoryText"):setVisible(false)	-- 스토리
--		winMgr:getWindow("MyQuestDetailInfoMissionImg"):setVisible(false)		-- 임무 이미지
	elseif windowState == 3 then
		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setVisible(true)	-- 설명
		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):setPosition(23, 90)
		
		winMgr:getWindow("MyQuestDetailInfoDescText"):setVisible(false)			-- 설명
		winMgr:getWindow("MyQuestDetailInfoStoryText"):setVisible(false)		-- 스토리
		winMgr:getWindow("MyQuestDetailInfoMissionImg"):setVisible(false)		-- 임무 이미지
	end
	
								
	-- 제목
	winMgr:getWindow("MyQuestDetailInfoTitleText"):setVisible(true)
	winMgr:getWindow("MyQuestDetailInfoTitleText"):setTextExtends(Name, g_STRING_FONT_GULIM, 14, 80,80,80,255,   0, 255,255,255,255)
end


function SettingMyQuestDetailInfoStory(story)
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0
	if story ~= "" then
		tbufStringTable = {['err']=0, }
		tbufSpecialTable = {['err']=0, }
		count = 0
		
		tbufStringTable, tbufSpecialTable = cuttingString(story, tbufStringTable, tbufSpecialTable, count)

		winMgr:getWindow("MyQuestDetailInfoStoryText"):clearTextExtends()
		for i=0, #tbufStringTable do
			local colorIndex = tonumber(tbufSpecialTable[i])
			if colorIndex == nil then
				colorIndex = 0
			end
			winMgr:getWindow("MyQuestDetailInfoStoryText"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 11, 
						tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
		end
	end

end


function SettingMyQuestDetailInfoDescription(description)
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0

	if description ~= "" then
	
		tbufStringTable, tbufSpecialTable = cuttingString(description, tbufStringTable, tbufSpecialTable, count)
		
		winMgr:getWindow("MyQuestDetailInfoDescText"):clearTextExtends()
		for i=0, #tbufStringTable do
			local colorIndex = tonumber(tbufSpecialTable[i])
			if colorIndex == nil then
				colorIndex = 0
			end
			winMgr:getWindow("MyQuestDetailInfoDescText"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 11, 
						tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
		end
	end	

end


function SettingMyQuestDetailInfoNpcTelling(npcTelling)
	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0
	if npcTelling ~= "" then
		-- 엔피씨 텔링
		tbufStringTable = {['err']=0, }
		tbufSpecialTable = {['err']=0, }
		count = 0
		
		tbufStringTable, tbufSpecialTable = cuttingString(npcTelling, tbufStringTable, tbufSpecialTable, count)
		
		winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):clearTextExtends()
		for i=0, #tbufStringTable do
			local colorIndex = tonumber(tbufSpecialTable[i])
			if colorIndex == nil then
				colorIndex = 0
			end
			winMgr:getWindow("MyQuestDetailInfoNpcTellingText"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 11, 
						tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
		end
	end

end



-- 퀘스트 조건세팅
function SettingMyQuestCondition()
	

end


-- 퀘스트 보상세팅
function SettingMyQuestReward()
	

end



-- 퀘스트 완료 메세지를 보낼때
function MyQuestDetailInfoMain_OKEvent(args)
	if winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):isVisible() then
		-- 수락 / 완료 했다는 메세지를 보내준다.
		local questNumber = tonumber(winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):getUserString("questNumber"))
		local NpcIdx = tonumber(winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):getUserString("NPCIdx"))
		ClearQuestIcon(NpcIdx)	
		RequestQuestComplete(questNumber)
	end
--	HideMyQuestDetailInfo()
--	MyQuest_SelectCloseButtonEvent()

--	TownNpcEscBtnClickEvent()
end


-- 퀘스트의 수락버튼이 눌려졌을 때
function MyQuestDetailInfoMain_AcceptEvent(args)
	if winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):isVisible() then
		local questNumber = tonumber(winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):getUserString("questNumber"))
		--DebugStr("퀘스트의 수락버튼이 눌려졌을 때")
		local NPCIdx = tonumber(winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):getUserString("NPCIdx"))
		--DebugStr("퀘스트의 수락버튼이 눌려졌을 때" .. NPCIdx)	
		ClearQuestIcon(NPCIdx)	
		--DebugStr("퀘스트의 수락버튼이 눌려졌을 때09990" .. NPCIdx)				
		RequestQuestAccept(questNumber)
	end
--	HideMyQuestDetailInfo()
--	MyQuest_SelectCloseButtonEvent()
end


-- 퀘스트의 상세정보 메인윈도우를 띄워준다.
function ShowMyQuestDetailInfo(questState, questNumber, Event, NPCIdx)
	HideMyQuestMainWindow()
	winMgr:getWindow("MyQuestDetailInfoMain"):setPosition(0, 0)
	winMgr:getWindow("MyQuestDetailInfoMain"):setVisible(true)
	winMgr:getWindow("MyQuestDetailInfoMainBack2"):addChildWindow(winMgr:getWindow("MyQuestDetailInfoMain"))
	winMgr:getWindow("MyQuestDetailInfoMainBack2"):setVisible(true)
	winMgr:getWindow("MyQuestDetailInfoMainBack"):setVisible(false)	
	winMgr:getWindow("MyQuestDetailInfoMain_CloseButton"):setVisible(true)
		
	-- 버튼형태를 다르게.
	if questState == 1 then -- 받을 수 있음

		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("questNumber", questNumber)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("NPCIdx", NPCIdx)
		--DebugStr("받을 수 있음" .. NPCIdx)
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):setVisible(false)
	elseif questState == 2 then -- 받았음(진행중)
		--DebugStr("받았음(진행중)")
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("NPCIdx", NPCIdx)
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):setVisible(false)
	elseif questState == 3 then -- 완료했음(완료)
		--DebugStr("완료했음(완료)")
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setUserString("questNumber", questNumber)
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setUserString("NPCIdx", NPCIdx)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):setVisible(false)
	else
		--DebugStr("완료했음(완료2)")
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setUserString("questNumber", 0)
		winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("MyQuestDetailInfoMainBack"))
		winMgr:getWindow("MyQuestDetailInfoMainBack2"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoMainBack"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoMainBack"):setPosition(653, 20)
		winMgr:getWindow("MyQuestDetailInfoMainBack"):addChildWindow(winMgr:getWindow("MyQuestDetailInfoMain"))
		winMgr:getWindow("MyQuestDetailInfoMain"):setPosition(0, 0)		
		
	end
	if Event == 1 then
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(false)
		winMgr:getWindow("MyQuestDetailInfoEventImg"):setVisible(true)		
	else
		winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(true)
		winMgr:getWindow("MyQuestDetailInfoEventImg"):setVisible(false)
	end
end


-- 퀘스트의 상세정보 메인윈도우를 숨겨준다.
function HideMyQuestDetailInfo()
	if winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):isVisible() then
		MyQuestDetailInfoMain_FirstOkButtonEvent()
	end
	
	if winMgr:getWindow("MyQuestDetailInfoEventImg"):isVisible() == false then
		ShowMyQuestSelectList()
	end	
	winMgr:getWindow("MyQuestDetailInfoMainBack2"):setVisible(false)
	HideMyQuestTelling()
end



-- 첫번째 들어왔을때 띄워주는 버튼에 대한 이벤트
function MyQuestDetailInfoMain_FirstOkButtonEvent()
	winMgr:getWindow("MyQuestDetailInfoMainBack"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoMain"):setVisible(false)
	FirstCreateEventEscEvent(false)
end








local Max_QuestList = 10	-- 최대 퀘스트갯수


-- 퀘스트의 메인리스트
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestMainBackWindow")
mywindow:setTexture("Enabled", "UIData/quest3.tga", 0, 0)
mywindow:setPosition(152, 114)
mywindow:setSize(719, 557)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("MyQuestMainBackWindow", "HideMyQuestMainWindow")

-- 타이틀바
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "MyQuestMainBack_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(713, 30)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestMainBackWindow"):addChildWindow(mywindow)

-- 닫기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestMainBack_CloseButton")
mywindow:setTexture("Normal", "UIData/quest4.tga", 439, 0)
mywindow:setTexture("Hover", "UIData/quest4.tga", 439, 23)
mywindow:setTexture("Pushed", "UIData/quest4.tga", 439, 45)
mywindow:setTexture("PushedOff", "UIData/quest4.tga", 439, 45)
mywindow:setPosition(689, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMyQuestMainWindow")
winMgr:getWindow("MyQuestMainBackWindow"):addChildWindow(mywindow)


-------------------------------------------------------------
-- 퀘스트의 리스트가 나오는 윈도우 선택가능한...
-------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestListMain")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(8, 41)
mywindow:setSize(345, 502)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestMainBackWindow"):addChildWindow(mywindow)


-- 라디오 버튼을 만들어준다
for i=0, Max_QuestList-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "MyQuestListBtn_"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("SelectedNormal", "UIData/quest3.tga", 310, 558)
	mywindow:setTexture("SelectedHover", "UIData/quest3.tga", 310, 558)
	mywindow:setTexture("SelectedPushed", "UIData/quest3.tga", 310, 558)
	mywindow:setProperty("GroupID", 1010)
	mywindow:setPosition(6, 46 + i*36)
	mywindow:setSize(334, 38)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:setUserString("questNumber", 0)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyQuestListBtn_ClickEvent")
	mywindow:subscribeEvent("MouseButtonDown", "MyQuestListBtn_ButtonDownEvent");
	mywindow:subscribeEvent("MouseButtonUp", "MyQuestListBtn_ButtonUpEvent");
	mywindow:subscribeEvent("MouseLeave", "MyQuestListBtn_MouseLeaveEvent");
	mywindow:subscribeEvent("MouseEnter", "MyQuestListBtn_MouseEnterEvent");
	winMgr:getWindow("MyQuestListMain"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestListText_"..i)
	mywindow:setPosition(35, 10)
	mywindow:setSize(334, 20)
	mywindow:setFont(g_STRING_FONT_DODUM, 13)
	mywindow:setTextColor(180, 180, 180, 255)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("MyQuestListBtn_"..i):addChildWindow(mywindow)
	
	-- 진행상황 텍스트	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestListAddText_"..i)
	--mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 0)
	mywindow:setPosition(175, 13)
	mywindow:setSize(150, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestListBtn_"..i):addChildWindow(mywindow)
	
	-- 퀘스트 모드 체크박스
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", "bCheckMyQuestShow_"..i)
	mywindow:setTexture("Normal", "UIData/option.tga", 493, 1002)
	mywindow:setTexture("Hover", "UIData/option.tga", 493, 1002)
	mywindow:setTexture("Pushed", "UIData/option.tga", 514, 1002)
	mywindow:setTexture("PushedOff", "UIData/option.tga", 514, 1002)
	mywindow:setTexture("SelectedNormal", "UIData/option.tga", 514, 1002)
	mywindow:setTexture("SelectedHover", "UIData/option.tga", 514, 1002)
	mywindow:setTexture("SelectedPushed", "UIData/option.tga", 493, 1002)
	mywindow:setTexture("SelectedPushedOff", "UIData/option.tga", 493, 1002)
	mywindow:setSize(21, 21)
	mywindow:setPosition(10, 10)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:setUserString("isChecked", "false")
	mywindow:subscribeEvent("CheckStateChanged", "OnCheckShowQuest")
	winMgr:getWindow("MyQuestListBtn_"..i):addChildWindow(mywindow)

	
end
function OnCheckShowQuest(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	local iIndex = local_window:getUserString("Index")
	local iQuestNum = winMgr:getWindow("MyQuestListBtn_"..iIndex):getUserString("questNumber");
	
	if local_window:getUserString("isChecked") == "false" then 
	    local isResult = WndQuest_AddShownQuestList(iQuestNum);

		if isResult == true then 
			local_window:setUserString("isChecked", "true")
		else
			CEGUI.toCheckbox(local_window):setSelected(false)
		end
	else
		WndQuest_RemoveShownQuestList(iQuestNum);
		local_window:setUserString("isChecked", "false")
	end
	DebugStr(iIndex .. local_window:getUserString("isChecked"));
	DebugStr("OnCheckShowQuest : QuestNum :: ".. iQuestNum);
end

-- 퀘스트 포기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestList_GiveUpButton")
mywindow:setTexture("Normal", "UIData/quest3.tga", 937, 0)
mywindow:setTexture("Hover", "UIData/quest3.tga", 937, 30)
mywindow:setTexture("Pushed", "UIData/quest3.tga", 937, 60)
mywindow:setTexture("PushedOff", "UIData/quest3.tga", 937, 60)
mywindow:setTexture("Disabled", "UIData/quest3.tga", 937, 90)
mywindow:setPosition(10, 463)
mywindow:setSize(87, 30)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MyQuestList_GiveUpEvent")
winMgr:getWindow("MyQuestListMain"):addChildWindow(mywindow)




-- 퀘스트 포기버튼
function MyQuestList_GiveUpEvent(args)


end


-- 퀘스트 리스트 클릭버튼
function MyQuestListBtn_ClickEvent(args)

	local eventWindow = CEGUI.toMouseEventArgs(args).window
	local index	= eventWindow:getUserString("index")
	local questNumber = tonumber(eventWindow:getUserString("questNumber"))

	DebugStr(" 퀘스트 리스트 클릭버튼 :: questNumber : " ..questNumber)
	
	if CEGUI.toRadioButton(eventWindow):isSelected() then
		winMgr:getWindow("MyQuestListText_"..index):setTextColor(255, 255, 255, 255)
		QuestListBtnClickEvent(questNumber, 0)	-- 퀘스트의 상세 정보를 요청한다.
	else
		winMgr:getWindow("MyQuestListText_"..index):setTextColor(180, 180, 180, 255)
	end
end


local bQuestListBtnClick = false

-- 퀘스트 리스트 버튼 다운 이벤트
function MyQuestListBtn_ButtonDownEvent(args)
	if bQuestListBtnClick == false then
		local eventWindow = CEGUI.toMouseEventArgs(args).window
		local window_pos = eventWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		eventWindow:setPosition(win_pos_x + 2, win_pos_y + 2)
		bQuestListBtnClick = true
	end

	
end


-- 퀘스트 리스트 버튼 업 이벤트
function MyQuestListBtn_ButtonUpEvent(args)
	if bQuestListBtnClick == true then
		local eventWindow = CEGUI.toMouseEventArgs(args).window
		local window_pos = eventWindow:getPosition();
		local win_pos_x = window_pos.x.offset;
		local win_pos_y = window_pos.y.offset;
		
		eventWindow:setPosition(win_pos_x - 2, win_pos_y - 2)
		bQuestListBtnClick = false
	end
end


-- 퀘스트 리스트 마우스 나갔을때 이벤트
function MyQuestListBtn_MouseLeaveEvent(args)
	local eventWindow = CEGUI.toMouseEventArgs(args).window
	local index	= eventWindow:getUserString("index")
	
	MyQuestMouseEventTextSetting(index, false)

end


-- 퀘스트 리스트 마우스 들어왔을때 이벤트
function MyQuestListBtn_MouseEnterEvent(args)
	local eventWindow = CEGUI.toMouseEventArgs(args).window
	local index	= eventWindow:getUserString("index")
	
	MyQuestMouseEventTextSetting(index, true)

end

function MyQuestMouseEventTextSetting(index, bEnter)
	if CEGUI.toRadioButton(winMgr:getWindow("MyQuestListBtn_"..index)):isSelected() then
		return
	end
	
	if bEnter then
		winMgr:getWindow("MyQuestListText_"..index):setTextColor(255, 255, 255, 255)
	else
		winMgr:getWindow("MyQuestListText_"..index):setTextColor(180, 180, 180, 255)
	end

end


-- 퀘스트 리스트의 버튼을 초기화 시켜준다.
function MyQuestListBtnReset()
	for i=0, Max_QuestList-1 do
		winMgr:getWindow("MyQuestListBtn_"..i):setVisible(false)
		if CEGUI.toRadioButton(winMgr:getWindow("MyQuestListBtn_"..i)):isSelected() then
			winMgr:getWindow("MyQuestListBtn_"..i):setProperty("Selected", "false")	
		end
	end
end


-- 현재 가지고 있는 퀘스트에 맞게 세팅해준다.퀘스트
function MyQuestListBtnSetting(index, QuestName, questNumber, progressIndex, bisShown)
	DebugStr("현재 가지고 있는 퀘스트에 맞게 세팅해준다.퀘스트")
	local tTable = {['err']=0, }--[2] = PreCreateString_1030, PreCreateString_1029}-- 제일 위의 퀘스트를 선택해준다.
	tTable[2] = PreCreateString_1030
	tTable[3] = PreCreateString_1029

	winMgr:getWindow("MyQuestListBtn_"..index):setUserString("questNumber", questNumber)	-- 해당 인덱스에 퀘스트 인덱스를 저장해놓는다.
	winMgr:getWindow("MyQuestListBtn_"..index):setVisible(true)
	winMgr:getWindow("MyQuestListText_"..index):setText(QuestName)
	
	if progressIndex == 3 then
		winMgr:getWindow("MyQuestListAddText_"..index):setTextExtends("("..tTable[progressIndex]..")", g_STRING_FONT_GULIM, 12, 35, 255, 97,255,   0, 255,255,255,255)
	else
		winMgr:getWindow("MyQuestListAddText_"..index):setTextExtends("("..tTable[progressIndex]..")", g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	end
	if index == 0 then
		winMgr:getWindow("MyQuestListBtn_"..index):setProperty("Selected", "true")		
	end
	CEGUI.toCheckbox(winMgr:getWindow("bCheckMyQuestShow_"..index)):setSelected(bisShown)
end


-- 메인 퀘스트창을 띄워준다.
function ShowMyQuestMainWindow()
	ClearMyQuestDetailInfo()
	ClearMyQuestConditionInfo()
	RewardTypeWindowClear()
	ShowMyQuestListMainWindow()
	root:addChildWindow(winMgr:getWindow("MyQuestMainBackWindow"))
	winMgr:getWindow("MyQuestMainBackWindow"):setVisible(true)
	winMgr:getWindow("MyQuestMainBackWindow"):addChildWindow(winMgr:getWindow("MyQuestDetailInfoMain"))
	winMgr:getWindow("MyQuestDetailInfoMain"):setVisible(true)
	winMgr:getWindow("MyQuestDetailInfoMain"):setPosition(358, 41)
	winMgr:getWindow("MyQuestDetailInfoMain_CloseButton"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoMain_OKButton"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoMain_CancelButton"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoMain_AcceptButton"):setVisible(false)
	winMgr:getWindow("MyQuestDetailInfoMain_FirstOkButton"):setVisible(false)
		
end



-- 메인퀘스트창을 없애준다.
function HideMyQuestMainWindow()
	winMgr:getWindow("MyQuestMainBackWindow"):setVisible(false)
	SetShowToolTip(false)
	HideAnimationWindow()
end





function GetConditionStringIndex(type)
	
	

end
















-- 화면 옆에 퀘스트 표시
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SimpleWindowBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(1)
local wndtype = GetCurrentWndType()
if wndtype == WND_LUA_VILLAGE then	-- 광장
	mywindow:setPosition(790, 228)
else
	mywindow:setPosition(791, 224)
end
mywindow:setSize(233, 300)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SimpleWindowTop")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 700)
mywindow:setPosition(0, 0)
mywindow:setSize(233, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)


-- 타이틀바(마우스 따라 움직이게 하기)
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "MyQuest_SimpleTitleBar")
mywindow:setPosition(0, 0)
mywindow:setSize(233, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SimpleWindowMiddle")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 735)
mywindow:setPosition(0, 26)
mywindow:setSize(233, 17)
mywindow:setScaleHeight(255)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_SimpleWindowBottom")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 795)
mywindow:setPosition(0, 220)
mywindow:setSize(233, 7)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)



local CurrentLineCount = 0


-- 스트링안에서 찾고자하는 스트링을 찾는다.(리턴값으로는 해당 스트링의 카운트)
function findString(targetString, fString, count)
	
	local stringStart, stringEnd = string.find(targetString, fString);
	
	if stringStart ~= nil then
		targetString = string.sub(targetString, stringEnd + 1);
		count = count + 1
		return findString(targetString, fString, count)
	else
		return count
	end
end



function SettingQuestSimpleWindowTitle(index, title, bComplete)
		
	local string = AdjustString(g_STRING_FONT_DODUMCHE, 12, title, 200)
	local bufString = string

	if winMgr:getWindow("MyQuestSimpleListTitleText_"..index) == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestSimpleListTitleText_"..index)
		mywindow:setPosition(10, 26 + CurrentLineCount * 17)
		mywindow:setSize(220, 10)
		mywindow:setFont(g_STRING_FONT_DODUM, 12)
--		if bComplete == 1 then
--			mywindow:setTextColor(35, 255, 97, 255)
--		else
			mywindow:setTextColor(255, 213, 28, 255)
--		end		
		mywindow:setText(string)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)	
		winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)
	else
--		if bComplete == 1 then
--			winMgr:getWindow("MyQuestSimpleListTitleText_"..index):setTextColor(35, 255, 97, 255)
--		else
			winMgr:getWindow("MyQuestSimpleListTitleText_"..index):setTextColor(255, 213, 28, 255)
--		end
		winMgr:getWindow("MyQuestSimpleListTitleText_"..index):setPosition(10, 26 + CurrentLineCount * 17)
		winMgr:getWindow("MyQuestSimpleListTitleText_"..index):setVisible(true)
		winMgr:getWindow("MyQuestSimpleListTitleText_"..index):setText(string)
	end

	if bufString ~= "" then
		local count = findString(bufString, "\n", 0)
		CurrentLineCount = CurrentLineCount + count
	end

	CurrentLineCount = CurrentLineCount + 1
	SettingQuestSimpleWindowSize()
end




-- 퀘스트의 간단한 윈도우를 세팅해준다
function SettingQuestSimpleWindow(index, condition, conditioncCount, currentCount, MaxCount, bComplete)

	ShowQuestSimpleWindow()
	local string = condition
	
	if MaxCount > 0 then
		string = string.."("..currentCount.." / "..MaxCount..")"
	end
	
	string = AdjustString(g_STRING_FONT_DODUMCHE, 11, string, 200)
	local bufString = string

	if winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount) == nil then
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestSimpleListConditionText_"..index.."_"..conditioncCount)
		mywindow:setFont(g_STRING_FONT_DODUM, 11)
		if bComplete == 1 then
			mywindow:setTextColor(35, 255, 97, 255)
		else
			mywindow:setTextColor(255, 255, 255, 255)
		end	
		mywindow:setPosition(10, 26 + CurrentLineCount * 17)
		mywindow:setSize(220, 20)
		mywindow:setText(string)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)
--[[		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuestSimpleListCountText_"..index.."_"..conditioncCount)
		mywindow:setFont(g_STRING_FONT_DODUM, 12)
		mywindow:setTextColor(180, 180, 180, 255)
		mywindow:setPosition(15, 10 + CurrentLineCount * 15)
		mywindow:setSize(220, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("MyQuest_SimpleWindowBack"):addChildWindow(mywindow)
--]]			
	else
		if bComplete == 1 then
			winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount):setTextColor(35, 255, 97, 255)
		else
			winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount):setTextColor(255, 255, 255, 255)
		end	
		winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount):setVisible(true)
		winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount):setText(string)
		winMgr:getWindow("MyQuestSimpleListConditionText_"..index.."_"..conditioncCount):setPosition(10, 26 + CurrentLineCount * 17)
	
	end
	if bufString ~= "" then
		local count = findString(bufString, "\n", 0)
		CurrentLineCount = CurrentLineCount + count
	end
	CurrentLineCount = CurrentLineCount + 1	
	SettingQuestSimpleWindowSize()
end



-- 퀘스트 옆에 띄워주는 윈도우의 변수 윈도우들을 초기화 시켜준다.
function ClearQuestSimpleWindow()
	CurrentLineCount = 0
	for i=0, 10 do
		if winMgr:getWindow("MyQuestSimpleListTitleText_"..i) then
			winMgr:getWindow("MyQuestSimpleListTitleText_"..i):setVisible(false)
			for j=0, 5-1 do		
				if winMgr:getWindow("MyQuestSimpleListConditionText_"..i.."_"..j) then
					winMgr:getWindow("MyQuestSimpleListConditionText_"..i.."_"..j):setVisible(false)
				end
			end
		end
	end
	HideQuestSimpleWindow()
end






-- 퀘스트 간단한 윈도우 표시
function ShowQuestSimpleWindow()
	winMgr:getWindow("MyQuest_SimpleWindowBack"):setVisible(true)
end

function SettingQuestSimpleWindowSize()
	-- 화면 옆에 퀘스트 표시
	winMgr:getWindow("MyQuest_SimpleWindowBack"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("MyQuest_SimpleWindowBack"):setSize(233, 33 + CurrentLineCount * 17)
	winMgr:getWindow("MyQuest_SimpleWindowMiddle"):setScaleHeight(255 * CurrentLineCount)
	
	winMgr:getWindow("MyQuest_SimpleWindowBottom"):setPosition(0, 26 + CurrentLineCount * 17)
		
	
end






function HideQuestSimpleWindow()
	winMgr:getWindow("MyQuest_SimpleWindowBack"):setVisible(false)
end


function DrawQuestTargetRemainDistance(x, y, distance)
	-- 현재 루트의 drawer에...
	local drawer = root:getDrawer()
	drawer:setTextColor(255, 255, 255, 255)
	local distance_miter = distance / 100
--	drawer:drawText("asdasdasdadasfdsfasfadfaasdas", 100, 300)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
	--local id_width = GetStringSize(g_STRING_FONT_GULIMCHE, 13, tostring(distance_miter).." M") / 2
	common_DrawOutlineText1(drawer, tostring(distance_miter).." M", x+38, y + 26, 0,0,0,255, 120,200,255,255)
--	drawer:drawTexture("UIData/nm0.tga",100, 100, 47, 21, 113, 0)		--래더표시	


end




-----------------------------------------
-- 대화창
-----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_TellingBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(7)
mywindow:setPosition(0, 501)
mywindow:setSize(1024, 267)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_TellingImage")
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 0, 2)
mywindow:setPosition(0, 43)
mywindow:setSize(1024, 224)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_TellingBack"):addChildWindow(mywindow)

-- npc 대화 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuest_TellingText")
mywindow:setPosition(245, 45)
mywindow:setSize(700, 153)
mywindow:setViewTextMode(2)
mywindow:setLineSpacing(7)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyQuest_TellingImage'):addChildWindow(mywindow);

-- NPC 대화 이름 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuest_TellingNameImage")
mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 587, 336)
mywindow:setPosition(0, -8)
mywindow:setSize(273, 43)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuest_TellingImage"):addChildWindow(mywindow)


-- NPC 대화 이름 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyQuest_TellingNameText")
mywindow:setPosition(0, 12)
mywindow:setSize(200, 30)
mywindow:setAlign(8)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyQuest_TellingNameImage'):addChildWindow(mywindow);



-- 내 퀘스트 대화창을 보여준다.
function ShowMyQuestTelling(NpcName, String)
	root:addChildWindow(winMgr:getWindow("MyQuest_TellingBack"))
	winMgr:getWindow("MyQuest_TellingBack"):setVisible(true)
	-- 엔피씨 이름	
	winMgr:getWindow("MyQuest_TellingNameText"):setTextExtends(NpcName, g_STRING_FONT_GULIM, 18, 87,242,9,255, 0, 60,60,60,255)
	-- 대화
	local TellingText_window = winMgr:getWindow('MyQuest_TellingText')
	CEGUI.toGUISheet(TellingText_window):setTextViewDelayTime(11)

	local tbufStringTable = {['err']=0, }
	local tbufSpecialTable = {['err']=0, }
	local count = 0
	local string = String--AdjustString(g_STRING_FONT_DODUMCHE, 16, String, 700)
	tbufStringTable, tbufSpecialTable = cuttingString(string, tbufStringTable, tbufSpecialTable, count)
	
	winMgr:getWindow("MyQuest_TellingText"):clearTextExtends()
	for i=0, #tbufStringTable do
		local colorIndex = tonumber(tbufSpecialTable[i])
		if colorIndex == nil then
			colorIndex = 0
		end
		winMgr:getWindow("MyQuest_TellingText"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 16, 
					tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255,   0, 255,255,255,255)
	end
	


	
--	TellingText_window:setTextExtends(string, g_STRING_FONT_GULIM, 16, 255,255,255,255,   0, 0,0,0,255 )
	

end



-- 내 퀘스트 대화창을 숨겨준다,
function HideMyQuestTelling()
	winMgr:getWindow("MyQuest_TellingBack"):setVisible(false)
end








------- 퀘스트 보상창 ----------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyQuestRewardMainWindow")
mywindow:setTexture("Enabled", "UIData/quest2.tga", 0, 0)
mywindow:setPosition(10, 90)
mywindow:setSize(352, 525)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("MyQuestRewardMainWindow", "HideMyQuestRewardMainWindow")

-- 확인 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyQuestRewardMain_CloseButton")
mywindow:setTexture("Normal", "UIData/quest2.tga", 352, 0)
mywindow:setTexture("Hover", "UIData/quest2.tga", 352, 30)
mywindow:setTexture("Pushed", "UIData/quest2.tga", 352, 60)
mywindow:setTexture("PushedOff", "UIData/quest2.tga", 352, 60)
mywindow:setPosition(140, 483)
mywindow:setSize(87, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMyQuestRewardMainWindow")
winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)


local tRewardMainRewardWinName = {['err']=0, [0]= "MyQuestRewardMain_Zen", "MyQuestRewardMain_Exp"}
local tRewardMainRewardTexY	   = {['err']=0, [0]= 0, 36}
local tRewardMainRewardString  = {['err']=0, [0]= " ZEN", " EXP"}

for i=0, #tRewardMainRewardWinName do

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tRewardMainRewardWinName[i])
	mywindow:setTexture("Disabled", "UIData/quest4.tga", 462, tRewardMainRewardTexY[i])
	mywindow:setPosition(34 + i * 150, 86)
	mywindow:setSize(18, 18)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)
	
	-- 돈 값
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tRewardMainRewardWinName[i].."_Value")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setPosition(62 + i * 150, 87)
	mywindow:setSize(66, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)

	-- 돈 값
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tRewardMainRewardWinName[i].."_ValueUnit")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setPosition(62 + i * 150, 87)
	mywindow:setSize(66, 20)
	mywindow:setText(tRewardMainRewardString[i])
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)
		
end


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardMoney_Effect")
mywindow:setTexture("Disabled", "UIData/quest2.tga", 353, 193)
mywindow:setPosition(22, 78)
mywindow:setSize(310, 36)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)



local MAX_REWARD_COUNT = 5

for i=0, MAX_REWARD_COUNT - 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardMainRewardBackImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(28, 122 + i * 74)
	mywindow:setSize(59, 59)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardMainRewardItemImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setLayered(true)
	mywindow:setPosition(2, 2)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(140)
	mywindow:setScaleHeight(140)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("RewardMainRewardBackImg_"..i):addChildWindow(mywindow)
		
	
	-- 아이템 갯수 카운트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RewardMainReward_Count_"..i)
	mywindow:setPosition(0, 6)
	mywindow:setSize(59, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
--	mywindow:setTextExtends("x "..value, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	winMgr:getWindow("RewardMainRewardBackImg_"..i):addChildWindow(mywindow)
	
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RewardMainReward_itemName_"..i)
	mywindow:setPosition(76, 0)
	mywindow:setSize(200, 60)
	mywindow:setAlign(5)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
--	mywindow:setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	winMgr:getWindow("RewardMainRewardBackImg_"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardMainRewardEffectImg_"..i)
	mywindow:setTexture("Disabled", "UIData/quest2.tga", 353, 121)
	mywindow:setPosition(22, 116 + i * 74)
	mywindow:setSize(310, 71)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyQuestRewardMainWindow"):addChildWindow(mywindow)
	

end



-- 보상윈도우를 초기화시켜준다.
function ClearMyQuestRewardMainWindow()
	-- 보상 젠 경험치 초기화
	for i=0, #tRewardMainRewardWinName do
		winMgr:getWindow(tRewardMainRewardWinName[i]):setVisible(false)
		winMgr:getWindow(tRewardMainRewardWinName[i].."_Value"):setVisible(false)
		winMgr:getWindow(tRewardMainRewardWinName[i].."_ValueUnit"):setVisible(false)
	end
	winMgr:getWindow("RewardMoney_Effect"):setVisible(false)
	-- 보상 아이템 초기화	
	for i=0, MAX_REWARD_COUNT - 1 do
		winMgr:getWindow("RewardMainRewardBackImg_"..i):setVisible(false)
		winMgr:getWindow("RewardMainRewardEffectImg_"..i):setVisible(false)		
	end
end



--
function SettingMyQuestRewardItem(index, fileName, fileName2, itemName, itemCount)
	
	winMgr:getWindow("RewardMainRewardBackImg_"..index):setVisible(true)
	
	-- 아이템 이미지
	winMgr:getWindow("RewardMainRewardItemImg_"..index):setVisible(true)
	winMgr:getWindow("RewardMainRewardItemImg_"..index):setTexture("Enabled", fileName, 0, 0)
	if fileName2 == "" then
		winMgr:getWindow("RewardMainRewardItemImg_"..index):setLayered(false)
	else
		winMgr:getWindow("RewardMainRewardItemImg_"..index):setTexture("Layered", fileName2, 0, 0)
		winMgr:getWindow("RewardMainRewardItemImg_"..index):setLayered(true)
	end
	
	-- 아이템 갯수		
	if itemCount > 1 then
		winMgr:getWindow("RewardMainReward_Count_"..index):setVisible(true)
		winMgr:getWindow("RewardMainReward_Count_"..index):setTextExtends("x "..itemCount, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	else
		winMgr:getWindow("RewardMainReward_Count_"..index):setVisible(false)
		winMgr:getWindow("RewardMainReward_Count_"..index):clearTextExtends()	
	end
	-- 아이템 이름
	winMgr:getWindow("RewardMainReward_itemName_"..index):setVisible(true)
	winMgr:getWindow("RewardMainReward_itemName_"..index):setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 250,250,250,255,   0, 255,255,255,255)
	winMgr:getWindow("RewardMainRewardEffectImg_"..index):setVisible(true)		
end


-- 
function SettingMyQuestRewardZenExp(zen, exp)
	local bCheck = false
	if zen > 0 then
		local r,g,b = ColorToMoney(zen)
		winMgr:getWindow("MyQuestRewardMain_Zen"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Zen_Value"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Zen_Value"):setText(CommatoMoneyStr(zen))
		winMgr:getWindow("MyQuestRewardMain_Zen_Value"):setTextColor(r,g,b,255)
		
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CommatoMoneyStr(zen))
		winMgr:getWindow("MyQuestRewardMain_Zen_ValueUnit"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Zen_ValueUnit"):setPosition(65 + size, 87)
		bCheck = true	
	end
	
	if exp > 0 then
		local r,g,b = ColorToMoney(exp)
		winMgr:getWindow("MyQuestRewardMain_Exp"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Exp_Value"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Exp_Value"):setText(CommatoMoneyStr(exp))
		winMgr:getWindow("MyQuestRewardMain_Exp_Value"):setTextColor(r,g,b,255)
		
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CommatoMoneyStr(exp))
		winMgr:getWindow("MyQuestRewardMain_Exp_ValueUnit"):setVisible(true)
		winMgr:getWindow("MyQuestRewardMain_Exp_ValueUnit"):setPosition(215 + size, 87)		
		bCheck = true		
	end
	if bCheck then
		winMgr:getWindow("RewardMoney_Effect"):setVisible(true)		
	end
end

		

-- 퀘스트 보상창 보여준다
function ShowMyQuestRewardMainWindow()
	root:addChildWindow(winMgr:getWindow("MyQuestRewardMainWindow"))
	winMgr:getWindow("MyQuestRewardMainWindow"):setVisible(true)
end


-- 퀘스트 보상창 숨겨준다.
function HideMyQuestRewardMainWindow()
	winMgr:getWindow("MyQuestRewardMainWindow"):setVisible(false)
end



function UpdateMyQuestEventRemainTime(timeString, bCheck)
	if winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText") == nil then
		return
	end
	
	if bCheck then
		winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setText(timeString)
		winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setVisible(true)
	else
		winMgr:getWindow("MyQuestDetailInfoConditionbShowTimeText"):setVisible(false)
	end
end







-- 퀘스트의 진행 위치를 세팅해준다.
function GetTargetPos(questNumber, state)
	if tQuestTargetPos[questNumber] == nil then
		GetQuestTargetPos(0,0,0,questNumber)
		return
	end
	if tQuestTargetPos[questNumber][state] == nil then
		GetQuestTargetPos(0,0,0,questNumber)
		return
	end
	GetQuestTargetPos(tQuestTargetPos[questNumber][state][1], tQuestTargetPos[questNumber][state][2], tQuestTargetPos[questNumber][state][3], questNumber)
end


-- 퀘스트 조건을 세팅한다.
function GetCondition(questNumber, index, drawindex, type, parentIndex, check, currentCount, killCount)
	if tQuestCondition[questNumber] == nil then
		GetQuestCondition(0, 0, 0, 0, 0, 0, 0)
		return
	end
	GetQuestCondition(tQuestCondition[questNumber][index], drawindex, type, parentIndex, check, currentCount, killCount)
end





function GetConditionStringIndex(questNumber, index, check, currentCount, killCount)
	if tQuestCondition[questNumber] == nil then
		SetQuestNotifyMessage(0, 0, 0, 0)
		return
	end
	SetQuestNotifyMessage(tQuestCondition[questNumber][index], check, currentCount, killCount)
end
