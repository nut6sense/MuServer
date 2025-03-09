--------------------------------------------------------------------
-- 유저 스킬정보
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

local SKILL_CRASH	= 0
local SKILL_HOLD	= 1
local SKILL_SPECIAL	= 2
local SKILL_TEAMDOUBLE = 3
local SKILL_ETC		= 4


-- 유저 스킬 정보의 메인 윈도우
UserSkillInfoMain = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Main")
UserSkillInfoMain:setTexture("Enabled", "UIData/myinfo3.tga", 0, 488)
UserSkillInfoMain:setPosition(10, 70)
UserSkillInfoMain:setSize(483, 410)
UserSkillInfoMain:setVisible(false)
UserSkillInfoMain:setAlwaysOnTop(true)
UserSkillInfoMain:setZOrderingEnabled(false)
UserInfoMain:addChildWindow(UserSkillInfoMain)
--[[

-- 스킬 정보의 스킬 종류 탭 윈도우(타격, 잡기, 스페셜, 팀/더블, 기타)
local SkillKindTabName = {['err'] = 0, [0]="SkillKind_Crash", "SkillKind_Hold", "SkillKind_Special", "SkillKind_TeamDouble", "SkillKind_Etc"}
local SkillKindTabTexX = {['err'] = 0, [0]=		505,				591,				677,				763,					849}
local SkillKindTabPosX = {['err'] = 0, [0]=		6,					6 + 97*1,			6 + 97*2,			6 + 97*3,				6 + 97*4}

for i=0, #SkillKindTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SkillKindTabName[i])
	mywindow:setTexture("Normal", "UIData/myinfo3.tga", SkillKindTabTexX[i], 342)
	mywindow:setTexture("Hover", "UIData/myinfo3.tga", SkillKindTabTexX[i], 392 )
	mywindow:setTexture("Pushed", "UIData/myinfo3.tga", SkillKindTabTexX[i], 442 )
	mywindow:setTexture("SelectedNormal", "UIData/myinfo3.tga", SkillKindTabTexX[i], 442 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo3.tga", SkillKindTabTexX[i], 442 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo3.tga", SkillKindTabTexX[i], 442 )
	mywindow:setPosition(SkillKindTabPosX[i], 0)
	mywindow:setProperty("GroupID", 22)
	mywindow:setUserString("Index", i)
	mywindow:setSize(86, 50)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", "SelectSkillKindTabEvent")
	UserSkillInfoMain:addChildWindow(mywindow)
end


-- 스킬종류에 따른 버튼 이벤트
function SelectSkillKindTabEvent(args)
	local EventWindow = CEGUI.toWindowEventArgs(args).window 
	if CEGUI.toRadioButton(EventWindow):isSelected() then
		local tabIndex = EventWindow:getUserString("Index")
		SettingSkillInfoKindIndex(tabIndex)		
	end	
end


local MAX_SKILL_COUNT = 8
local MAX_SKILL_XCOUNT = 2
local MAX_SKILL_YCOUNT = 4

for i=0, MAX_SKILL_COUNT - 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_"..i)
	mywindow:setTexture("Enabled", "UIData/myinfo3.tga", 785, 492)
	mywindow:setPosition(4 + (i%MAX_SKILL_XCOUNT) * 242, 55 + (i/MAX_SKILL_XCOUNT) * 81)
	mywindow:setSize(239, 79)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	UserSkillInfoMain:addChildWindow(mywindow)

	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_Img_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(9, 26)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(112)
	mywindow:setScaleHeight(112)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
	mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_GradeImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 27)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_GradeText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 27)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- 스킬 직업 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_PromotionImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 0, 0)
	mywindow:setPosition(25, 55)
	mywindow:setSize(89, 35)
	mywindow:setScaleWidth(100)
	mywindow:setScaleHeight(100)
	mywindow:setLayered(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
		
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(9, 26)
	mywindow:setSize(44, 44)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_UserSkillInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_UserSkillInfo")
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)

	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_NameText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, 4)
	mywindow:setSize(220, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)

	-- 스킬 종류
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_SkillKindText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 26)
	mywindow:setSize(170, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- 스킬 커맨드
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_SkillCommandText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 48)
	mywindow:setSize(170, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)


end


-- 마우스 들어왔을때
function MouseEnter_UserSkillInfo(args)
	

end


-- 마우스 나갔을 때
function MouseLeave_UserSkillInfo(args)
	

end

--]]





-- 스킬 직업 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CharacterPromotionImg")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(20, 5)
mywindow:setSize(89, 35)
mywindow:setLayered(true)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
UserSkillInfoMain:addChildWindow(mywindow)




function SetUserSkillCharacterInfo(style, promotion, attribute, grade, skillCount)
	
	
	
	winMgr:getWindow("CharacterPromotionImg"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("CharacterPromotionImg"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	
	
end




-- 기본스킬을 세팅해준다.
function SetBaseSkillInfo(skillIndex, promotionIndex)

	-- 스킬이름
	winMgr:getWindow("UserSkillInfo_Skill_NameText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	-- 스킬 이미지
	winMgr:getWindow("UserSkillInfo_Skill_"..index):setTexture("Enabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setTexture("Layered", "UIData/invisible.tga", 0, 0)
	end
	-- 스킬등급
	if grade > 0 then
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("")
	end
	-- 스킬직업 아이콘
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	-- 스킬 종류
	winMgr:getWindow("UserSkillInfo_Skill_SkillKindText_"..index):setText(skillKind)
	-- 스킬 커맨드
	
	
	
	
	
	


end




local MAX_SKILL_XCOUNT = 5

-- 스킬정보를 띄워줄 이미지를 생성해준다.
function CreateSkillInfo(kindIndex, count, skillIndex)
	local posYTable = {['err']=0, [0]= 53, 168, 284, 326, 368}
	if winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex) then
		
	else
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_"..skillIndex)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(70 + (count%MAX_SKILL_XCOUNT) * 36, posYTable[kindIndex] + (count/MAX_SKILL_XCOUNT) * 37)
		mywindow:setSize(32, 32)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		UserSkillInfoMain:addChildWindow(mywindow)
	
			
		-- 아이템 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_Img_"..skillIndex)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(80)
		mywindow:setScaleHeight(80)
		mywindow:setAlwaysOnTop(true)
		mywindow:setUseEventController(false)
		mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- 스킬 레벨 테두리 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_GradeImg_"..skillIndex)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 0)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- 스킬레벨 + 글자
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_GradeText_"..skillIndex)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(8, 1)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- 툴팁 이벤트를 위한 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_EventImage_"..skillIndex)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(0, 0)
		mywindow:setSize(32, 32)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("skillIndex", skillIndex)
		mywindow:subscribeEvent("MouseEnter", "MouseEnter_UserSkillInfo")
		mywindow:subscribeEvent("MouseLeave", "MouseLeave_UserSkillInfo")
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- 스킬 직업 이미지.
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_PromotionImg_"..skillIndex)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 20)
		mywindow:setSize(89, 35)
		mywindow:setScaleWidth(100)
		mywindow:setScaleHeight(100)
		mywindow:setLayered(true)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
			
		

	end
end



function GetBaseSkillInfo()
	
	
end


function MouseEnter_UserSkillInfo(args)
	DebugStr("착용중인 스킬 정보들(왼쪽)")
	
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
	local index			= tonumber(EnterWindow:getUserString("skillIndex"))
	
	if index <= -1 then
		return
	end
	
	local itemKind, itemNumber, attributeType = UserSkillTooltipInfo(index, 0) -- 인덱스 , 타이프
	
	if itemNumber < 0 then
		return
	end
	
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
	
	GetToolTipBaseInfo(x + 33, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	ReadAnimation(itemNumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(UserSkillInfoMain)
	
	targetx = targetx - 246
	if targetx < 0 then
		targetx = 0
	end	
	if y + 223 > g_CURRENT_WIN_SIZEY then
		y = g_CURRENT_WIN_SIZEY - 223
	end
	targety = targety - 69
	
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
	
end



function MouseLeave_UserSkillInfo()
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()
end


-- 스킬 착용창 랜더링
function SetUserSkillInfo(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute)--, skillKind, command)
	
	if winMgr:getWindow("UserSkillInfo_Skill_Img_"..index) == nil then
		return
	end
	
	-- 스킬 이름
--	winMgr:getWindow("UserSkillInfo_Skill_NameText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)

	-- 스킬 이미지
	winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setTexture("Enabled", "UIData/"..itemFileName, 0, 0)
	
	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setTexture("Layered", "UIData/"..itemFileName2, 0, 0)
	end

	-- 스킬등급
	if grade > 0 then
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("")
	end
	
	-- 스킬직업 아이콘
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	
	local tSkillPromotionX = {['err']=0, 516, 484, 548}
	
	
	--********************************************************************
	-- * 스킬 미착용시	0
	-- * 스킬 착용시	1 이상의 값.
	-- * promotion의 값은 직업에 의한값. ex) 0 -> 스트리트, 1 -> 러쉬
	--********************************************************************
	if promotion == 0 then
		winMgr:getWindow("UserSkillInfo_Skill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[1], 492) -- 흰색
	else
		winMgr:getWindow("UserSkillInfo_Skill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[2], 492) -- 레드
	end
	
	
	
	-- 스킬 종류
	--winMgr:getWindow("UserSkillInfo_Skill_SkillKindText_"..index):setText(skillKind)
	-- 스킬 커맨드
end


for i=0, 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkillBack_"..i)
	mywindow:setTexture("Enabled", "UIData/myinfo3.tga", 0, 898)
	mywindow:setPosition(259, 79 + i * 58)
	mywindow:setSize(213, 57)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	UserSkillInfoMain:addChildWindow(mywindow)
end

function ClearPossessionSkillList()
	for i=0, 4 do
		if winMgr:getWindow("UserSkillInfo_PossessionSkill_"..i) then
			winMgr:getWindow("UserSkillInfo_PossessionSkill_"..i):setVisible(false)
		end
	end
end


function CreatePossessionSkillList(index)
	if winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index) then
	
	else

		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_"..index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 898)
		mywindow:setPosition(259, 79 + index * 58)
		mywindow:setSize(213, 57)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		UserSkillInfoMain:addChildWindow(mywindow)

		-- 아이템 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_Img_"..index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 4)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(80)
		mywindow:setScaleHeight(80)
		mywindow:setAlwaysOnTop(true)
		mywindow:setUseEventController(false)
		mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- 스킬 레벨 테두리 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_GradeImg_"..index)
		mywindow:setTexture("Disabled", "UIData/myinfo3.tga", 213, 898)
		mywindow:setPosition(43, 22)
		mywindow:setSize(52, 22)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- 스킬레벨 + 글자
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_PossessionSkill_GradeText_"..index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(60, 22)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- 툴팁 이벤트를 위한 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_EventImage_"..index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 3)
		mywindow:setSize(32, 32)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("skillIndex", index)
		mywindow:subscribeEvent("MouseEnter", "MouseEnter_PossessionSkillInfo")
		mywindow:subscribeEvent("MouseLeave", "MouseLeave_PossessionSkillInfo")
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		
		-- 스킬 직업 이미지.
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_PromotionImg_"..index)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 20)
		mywindow:setSize(89, 35)
		mywindow:setScaleWidth(100)
		mywindow:setScaleHeight(100)
		mywindow:setLayered(true)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- 아이템 이름
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_PossessionSkill_NameText_"..index)
		mywindow:setTextColor(255,200,50,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(43, 4)
		mywindow:setSize(220, 20)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
			
		mywindow = winMgr:createWindow("TaharezLook/Button", "UserSkillInfo_PossessionSkill_UseBtn_"..index)
		mywindow:setTexture("Normal", "UIData/myinfo3.tga", 484, 527)
		mywindow:setTexture("Hover", "UIData/myinfo3.tga", 484, 545)
		mywindow:setTexture("Pushed", "UIData/myinfo3.tga", 484, 563)
		mywindow:setTexture("PushedOff", "UIData/myinfo3.tga", 484, 563)
		mywindow:setTexture("Disabled", "UIData/myinfo3.tga", 484, 581)
		mywindow:setPosition(163,36)
		mywindow:setSize(48, 18)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", tostring(index))
		mywindow:subscribeEvent("Clicked", "PossessionSkill_UseEvent")
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)	
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "UserSkillInfo_PossessionSkill_ReleaseBtn_"..index)
		mywindow:setTexture("Normal", "UIData/myinfo3.tga", 532, 527)
		mywindow:setTexture("Hover", "UIData/myinfo3.tga", 532, 545)
		mywindow:setTexture("Pushed", "UIData/myinfo3.tga", 532, 563)
		mywindow:setTexture("PushedOff", "UIData/myinfo3.tga", 532, 563)
		mywindow:setTexture("Disabled", "UIData/myinfo3.tga", 532, 581)
		mywindow:setPosition(163,36)
		mywindow:setSize(48, 18)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", tostring(index))
		mywindow:subscribeEvent("Clicked", "PossessionSkill_ReleaseEvent")
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)	
		

	end

end

function MouseEnter_PossessionSkillInfo(args)
	-- 오른쪽 스킬 모임( 소지품에 있는.... )
	DebugStr("소지품에 있는 스킬")
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
	local index			= tonumber(EnterWindow:getUserString("skillIndex"))
	
	if index <= -1 then
		return
	end
	
	local itemKind, itemNumber, attributeType = UserSkillTooltipInfo(index, 1)
	
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
	
	GetToolTipBaseInfo(x + 37, y, 2, Kind, 0, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	
	DebugStr("-오른쪽- 착용중인 itemNumber : " .. itemNumber)
	ReadAnimation(itemNumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(UserSkillInfoMain)
	
	targetx = targetx - 245
	if targetx < 0 then
		targetx = 0
	end	
	if y + 223 > g_CURRENT_WIN_SIZEY then
		y = g_CURRENT_WIN_SIZEY - 223
	end
	targety = targety- 69
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
	
end



function MouseLeave_PossessionSkillInfo(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()

end



-- 광장 죄우버튼
local UserSkillInfo_BtnName  = {["err"]=0, [0]="UserSkillInfo_LBtn", "UserSkillInfo_RBtn"}
local UserSkillInfo_BtnTexX  = {["err"]=0, [0]= 935, 952}
local UserSkillInfo_BtnPosX  = {["err"]=0, [0]= 330, 400}
local UserSkillInfo_BtnEvent = {["err"]=0, [0]= "UserSkillInfo_LBtnEvent", "UserSkillInfo_RBtnEvent"}
for i=0, #UserSkillInfo_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", UserSkillInfo_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo3.tga", UserSkillInfo_BtnTexX[i], 342)
	mywindow:setTexture("Hover", "UIData/myinfo3.tga", UserSkillInfo_BtnTexX[i], 364)
	mywindow:setTexture("Pushed", "UIData/myinfo3.tga",UserSkillInfo_BtnTexX[i], 386)
	mywindow:setTexture("PushedOff", "UIData/myinfo3.tga", UserSkillInfo_BtnTexX[i], 386)
	mywindow:setPosition(UserSkillInfo_BtnPosX[i], 373)
	mywindow:setSize(17, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", UserSkillInfo_BtnEvent[i])
	UserSkillInfoMain:addChildWindow(mywindow)
end


function UserSkillInfo_LBtnEvent()
	SetPossessionSkillButtonEvent(0, MyinfoCheck())

end


function UserSkillInfo_RBtnEvent()
	SetPossessionSkillButtonEvent(1, MyinfoCheck())

end



-- 페이지 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_PageText")
mywindow:setPosition(354, 378)
mywindow:setSize(40, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
UserSkillInfoMain:addChildWindow(mywindow)



-- 페이지 세팅
function SetUserSkillInfoPage(current, total)
	winMgr:getWindow("UserSkillInfo_PageText"):setTextExtends(current.." / "..total, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)

end


SetUserSkillInfoPage(1, 1)

-- 스킬 보유리스트를 세팅한다. ( 우측 스킬 보유창 )
function SetPossessionSkillList(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute, bWear)--, skillKind, command))
	
	winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):setVisible(true)
	-- 스킬이름
	winMgr:getWindow("UserSkillInfo_PossessionSkill_NameText_"..index):setText(itemName)

	-- 스킬 이미지
	winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setTexture("Enabled", "UIData/"..itemFileName, 0, 0)

	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setTexture("Layered", "UIData/"..itemFileName2, 0, 0)
	end
	
	-- 스킬등급
	if grade > 0 then
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setText("+"..grade)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setPosition(58, 25)
	else
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setTextColor(tGradeTextColorTable[1][1], tGradeTextColorTable[1][2], tGradeTextColorTable[1][3], 255)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setText(grade)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_GradeText_"..index):setPosition(65, 25)
	end
	
	-- 스킬직업 아이콘 
	winMgr:getWindow("UserSkillInfo_PossessionSkill_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("UserSkillInfo_PossessionSkill_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])

	if bWear then
		winMgr:getWindow("UserSkillInfo_PossessionSkill_ReleaseBtn_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_UseBtn_"..index):setVisible(false)
	else
		winMgr:getWindow("UserSkillInfo_PossessionSkill_ReleaseBtn_"..index):setVisible(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_UseBtn_"..index):setVisible(true)
	end
		
		
	local tSkillPromotionX = {['err']=0, 516, 484, 548}
	
	
	if promotion == 0 then
		--DebugStr("테두리 없다 : " .. promotion)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[1], 492) -- 테두리 없음
	else
		--DebugStr("빨간 테두리 : " .. promotion)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[2], 492) -- 붉은색
	end
end


-- 스킬의 
function SettingWearBtn(index, bWear)
	if winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index) then
		if bWear then
			winMgr:getWindow("UserSkillInfo_PossessionSkill_ReleaseBtn_"..index):setVisible(true)
			winMgr:getWindow("UserSkillInfo_PossessionSkill_UseBtn_"..index):setVisible(false)
		else
			winMgr:getWindow("UserSkillInfo_PossessionSkill_ReleaseBtn_"..index):setVisible(false)
			winMgr:getWindow("UserSkillInfo_PossessionSkill_UseBtn_"..index):setVisible(true)
		end
	end
end


-- 스킬 사용버튼
function PossessionSkill_UseEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("Index"))

	UserSkillUseReleaseEvent(index, 0)
end


-- 스킬 해제버튼
function PossessionSkill_ReleaseEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("Index"))
	
	UserSkillUseReleaseEvent(index, 1)
end



-- 유저의 스킬정보를 보여준다.
function setVisibleUserSkillInfo(bVislble, bMy)
	if bVislble then
		SettingSkillUi(bMy)
	end	
	UserSkillInfoMain:setVisible(bVislble)
end




-- 동영상 뒤 빽판을 보여준다.
function ShowAnimationWindow(x, y)
	if winMgr:getWindow("UserSkillInfo_BackFrame") then
		root:addChildWindow(winMgr:getWindow("UserSkillInfo_BackFrame"))
		winMgr:getWindow("UserSkillInfo_BackFrame"):setPosition(x,y)
		winMgr:getWindow("UserSkillInfo_BackFrame"):setVisible(true)
	else
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_BackFrame")
		mywindow:setTexture("Disabled", "UIData/myinfo3.tga", 484, 600)
		mywindow:setPosition(x,y)
		mywindow:setSize(237, 223)
		mywindow:setEnabled(false)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		root:addChildWindow(mywindow)
	end
end



-- 동영상 뒤 빽판을 숨겨준다.
function HideAnimationWindow()
	ClearAnimation()
	if winMgr:getWindow("UserSkillInfo_BackFrame") then
		winMgr:getWindow("UserSkillInfo_BackFrame"):setVisible(false)	
	end
		
end




mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_CountText")
--mywindow:setTextColor(255,255,255,255)
--mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(240, 19)
mywindow:setSize(40, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
UserSkillInfoMain:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_GradeText")
--mywindow:setTextColor(255,255,255,255)
--mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(406, 19)
mywindow:setSize(40, 20)
mywindow:setViewTextMode(1)
mywindow:setLineSpacing(2)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
UserSkillInfoMain:addChildWindow(mywindow)



-- 스킬 갯수, 등급 세팅
function SettingSkillCount(skillCount, totalCount, Grade)
	winMgr:getWindow("UserSkillInfo_Skill_CountText"):setTextExtends(tostring(skillCount), g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("UserSkillInfo_Skill_GradeText"):setTextExtends(tostring(Grade), g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
end


