--------------------------------------------------------------------
-- ���� ��ų����
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


-- ���� ��ų ������ ���� ������
UserSkillInfoMain = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Main")
UserSkillInfoMain:setTexture("Enabled", "UIData/myinfo3.tga", 0, 488)
UserSkillInfoMain:setPosition(10, 70)
UserSkillInfoMain:setSize(483, 410)
UserSkillInfoMain:setVisible(false)
UserSkillInfoMain:setAlwaysOnTop(true)
UserSkillInfoMain:setZOrderingEnabled(false)
UserInfoMain:addChildWindow(UserSkillInfoMain)
--[[

-- ��ų ������ ��ų ���� �� ������(Ÿ��, ���, �����, ��/����, ��Ÿ)
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


-- ��ų������ ���� ��ư �̺�Ʈ
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

	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_Img_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(9, 26)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(112)
	mywindow:setScaleHeight(112)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
	mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_GradeImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 27)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_GradeText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 27)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �̹���.
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
		
	-- ���� �̺�Ʈ�� ���� �̹���
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

	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_NameText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, 4)
	mywindow:setSize(220, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)

	-- ��ų ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_SkillKindText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 26)
	mywindow:setSize(170, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)
	
	-- ��ų Ŀ�ǵ�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_SkillCommandText_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 48)
	mywindow:setSize(170, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserSkillInfo_Skill_"..i):addChildWindow(mywindow)


end


-- ���콺 ��������
function MouseEnter_UserSkillInfo(args)
	

end


-- ���콺 ������ ��
function MouseLeave_UserSkillInfo(args)
	

end

--]]





-- ��ų ���� �̹���.
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




-- �⺻��ų�� �������ش�.
function SetBaseSkillInfo(skillIndex, promotionIndex)

	-- ��ų�̸�
	winMgr:getWindow("UserSkillInfo_Skill_NameText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	-- ��ų �̹���
	winMgr:getWindow("UserSkillInfo_Skill_"..index):setTexture("Enabled", itemFileName, 0, 0)
	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_Skill_"..index):setTexture("Layered", "UIData/invisible.tga", 0, 0)
	end
	-- ��ų���
	if grade > 0 then
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("")
	end
	-- ��ų���� ������
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	-- ��ų ����
	winMgr:getWindow("UserSkillInfo_Skill_SkillKindText_"..index):setText(skillKind)
	-- ��ų Ŀ�ǵ�
	
	
	
	
	
	


end




local MAX_SKILL_XCOUNT = 5

-- ��ų������ ����� �̹����� �������ش�.
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
	
			
		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_Img_"..skillIndex)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(80)
		mywindow:setScaleHeight(80)
		mywindow:setAlwaysOnTop(true)
		mywindow:setUseEventController(false)
		mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- ��ų ���� �׵θ� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_Skill_GradeImg_"..skillIndex)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 0)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_Skill_GradeText_"..skillIndex)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(8, 1)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_Skill_"..skillIndex):addChildWindow(mywindow)
		
		-- ���� �̺�Ʈ�� ���� �̹���
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
		
		-- ��ų ���� �̹���.
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
	DebugStr("�������� ��ų ������(����)")
	
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
	local index			= tonumber(EnterWindow:getUserString("skillIndex"))
	
	if index <= -1 then
		return
	end
	
	local itemKind, itemNumber, attributeType = UserSkillTooltipInfo(index, 0) -- �ε��� , Ÿ����
	
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
	
	GetToolTipBaseInfo(x + 33, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)

	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
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
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()
end


-- ��ų ����â ������
function SetUserSkillInfo(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute)--, skillKind, command)
	
	if winMgr:getWindow("UserSkillInfo_Skill_Img_"..index) == nil then
		return
	end
	
	-- ��ų �̸�
--	winMgr:getWindow("UserSkillInfo_Skill_NameText_"..index):setTextExtends("", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)

	-- ��ų �̹���
	winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setTexture("Enabled", "UIData/"..itemFileName, 0, 0)
	
	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_Skill_Img_"..index):setTexture("Layered", "UIData/"..itemFileName2, 0, 0)
	end

	-- ��ų���
	if grade > 0 then
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(true)
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("UserSkillInfo_Skill_GradeImg_"..index):setVisible(false)
		winMgr:getWindow("UserSkillInfo_Skill_GradeText_"..index):setText("")
	end
	
	-- ��ų���� ������
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow("UserSkillInfo_Skill_PromotionImg_"..index):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	
	local tSkillPromotionX = {['err']=0, 516, 484, 548}
	
	
	--********************************************************************
	-- * ��ų �������	0
	-- * ��ų �����	1 �̻��� ��.
	-- * promotion�� ���� ������ ���Ѱ�. ex) 0 -> ��Ʈ��Ʈ, 1 -> ����
	--********************************************************************
	if promotion == 0 then
		winMgr:getWindow("UserSkillInfo_Skill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[1], 492) -- ���
	else
		winMgr:getWindow("UserSkillInfo_Skill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[2], 492) -- ����
	end
	
	
	
	-- ��ų ����
	--winMgr:getWindow("UserSkillInfo_Skill_SkillKindText_"..index):setText(skillKind)
	-- ��ų Ŀ�ǵ�
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

		-- ������ �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_Img_"..index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(3, 4)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(80)
		mywindow:setScaleHeight(80)
		mywindow:setAlwaysOnTop(true)
		mywindow:setUseEventController(false)
		mywindow:setLayered(true)		-- ���̾� ����� Ȱ��ȭ(������ �̹��� �϶�,)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- ��ų ���� �׵θ� �̹���
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserSkillInfo_PossessionSkill_GradeImg_"..index)
		mywindow:setTexture("Disabled", "UIData/myinfo3.tga", 213, 898)
		mywindow:setPosition(43, 22)
		mywindow:setSize(52, 22)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserSkillInfo_PossessionSkill_GradeText_"..index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(60, 22)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):addChildWindow(mywindow)
		
		-- ���� �̺�Ʈ�� ���� �̹���
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
		
		
		-- ��ų ���� �̹���.
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
		
		-- ������ �̸�
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
	-- ������ ��ų ����( ����ǰ�� �ִ�.... )
	DebugStr("����ǰ�� �ִ� ��ų")
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
	
	GetToolTipBaseInfo(x + 37, y, 2, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	
	DebugStr("-������- �������� itemNumber : " .. itemNumber)
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
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()

end



-- ���� �˿��ư
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



-- ������ �ؽ�Ʈ
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



-- ������ ����
function SetUserSkillInfoPage(current, total)
	winMgr:getWindow("UserSkillInfo_PageText"):setTextExtends(current.." / "..total, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)

end


SetUserSkillInfoPage(1, 1)

-- ��ų ��������Ʈ�� �����Ѵ�. ( ���� ��ų ����â )
function SetPossessionSkillList(index, itemName, itemFileName, itemFileName2, grade, style, promotion, attribute, bWear)--, skillKind, command))
	
	winMgr:getWindow("UserSkillInfo_PossessionSkill_"..index):setVisible(true)
	-- ��ų�̸�
	winMgr:getWindow("UserSkillInfo_PossessionSkill_NameText_"..index):setText(itemName)

	-- ��ų �̹���
	winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setTexture("Enabled", "UIData/"..itemFileName, 0, 0)

	if itemFileName2 == "" then
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setLayered(false)
	else
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setLayered(true)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_Img_"..index):setTexture("Layered", "UIData/"..itemFileName2, 0, 0)
	end
	
	-- ��ų���
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
	
	-- ��ų���� ������ 
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
		--DebugStr("�׵θ� ���� : " .. promotion)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[1], 492) -- �׵θ� ����
	else
		--DebugStr("���� �׵θ� : " .. promotion)
		winMgr:getWindow("UserSkillInfo_PossessionSkill_EventImage_"..index):setTexture("Enabled", "UIData/myinfo3.tga", tSkillPromotionX[2], 492) -- ������
	end
end


-- ��ų�� 
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


-- ��ų ����ư
function PossessionSkill_UseEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("Index"))

	UserSkillUseReleaseEvent(index, 0)
end


-- ��ų ������ư
function PossessionSkill_ReleaseEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("Index"))
	
	UserSkillUseReleaseEvent(index, 1)
end



-- ������ ��ų������ �����ش�.
function setVisibleUserSkillInfo(bVislble, bMy)
	if bVislble then
		SettingSkillUi(bMy)
	end	
	UserSkillInfoMain:setVisible(bVislble)
end




-- ������ �� ������ �����ش�.
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



-- ������ �� ������ �����ش�.
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



-- ��ų ����, ��� ����
function SettingSkillCount(skillCount, totalCount, Grade)
	winMgr:getWindow("UserSkillInfo_Skill_CountText"):setTextExtends(tostring(skillCount), g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("UserSkillInfo_Skill_GradeText"):setTextExtends(tostring(Grade), g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
end


