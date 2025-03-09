----------------------------------------------------------------------
-- 선택 랜덤박스
----------------------------------------------------------------------
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


 
local MaxCount_OnePage = 5		-- 한페이지에 들어가는 아이템 갯수
local TownStoreitemString = PreCreateString_2692	--GetSStringInfo(LAN_SELECT_RANDOMI_TEM)	-- %s 선택하시겠습니까?

local tNormalPosition = {["err"]=0, [0]= (1024-298)/2 , (768-438)/2 }
local tRentalPosition = {["err"]=0, [0]= 120 , 58 }
local g_ClassTabIndex = -1 -- 클래스 인덱스


----------------------------------------------------------------------
-- 선택 랜덤 박스 뒷판
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectRandomboxMain")
mywindow:setTexture("Enabled", "UIData/Randombox_001.tga", 0,0)
mywindow:setWideType(6)
mywindow:setPosition((1024-298)/2, (768-438)/2)
mywindow:setSize(298, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("SelectRandomboxMain", "HideSelectRandomBoxSelectWindow")

mywindow = winMgr:createWindow("TaharezLook/Button", "SelectRandombox_CloseButton")
mywindow:setTexture("Normal",		"UIData/Randombox_001.tga", 476, 1)
mywindow:setTexture("Hover",		"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("Pushed",		"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("PushedOff",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setPosition(269, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideSelectRandomBoxSelectWindow")
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)


-- 아이템 리스트 제목
local RandomSelectBoxTabName  = {["err"]=0, [0]="RandomSelectBox_Strike", "RandomSelectBox_Grab", "RandomSelectBox_Special", "RandomSelectBox_TeamDouble"}
local RandomSelectBoxTabTexX  = {["err"]=0, [0]=298, 368, 298, 368}
local RandomSelectBoxTabTexY  = {["err"]=0, [0]=1, 1, 64, 64}
local RandomSelectBoxTabPosX  = {["err"]=0, [0]=4, 76, 148, 220}

for i=0, #RandomSelectBoxTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RandomSelectBoxTabName[i])
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i])
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedNormal", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedHover", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedPushed", "UIData/Randombox_001.tga", RandomSelectBoxTabTexX[i], RandomSelectBoxTabTexY[i] + 21 *2)
	mywindow:setPosition(RandomSelectBoxTabPosX[i] + 2, 39)
	mywindow:setProperty("GroupID", 2029)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RandomSelectBoxTab")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end


-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
--local BoneTypeTabName  = {["err"]=0, [0]="RandomSelectBox_Strike", "RandomSelectBox_Grab", "RandomSelectBox_Special", "RandomSelectBox_TeamDouble"}
local BoneTypeTabTexX  = {["err"]=0, [0]=368, 368, 368, 438, 438, 438}
local BoneTypeTabTexY  = {["err"]=0, [0]=127, 190, 253, 127, 190, 253}
local BoneTypeTabPosX  = {["err"]=0, [0]=4, 76, 148, 4, 76, 148}
local BoneTypeTabPosY  = {["err"]=0, [0]=39, 39, 39, 65, 65, 65}

for i=0, #BoneTypeTabTexX do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "BoneTypeTabName_"..i)
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i])
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedNormal", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedHover", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setTexture("SelectedPushed", "UIData/Randombox_001.tga", BoneTypeTabTexX[i], BoneTypeTabTexY[i] + 21 *2)
	mywindow:setPosition(BoneTypeTabPosX[i]+40, BoneTypeTabPosY[i])
	mywindow:setProperty("GroupID", 2030)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RandomSelectBoxTab")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end



for i=0, MaxCount_OnePage-1 do	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_"..i);	
	mywindow:setTexture("Enabled", "UIData/Randombox_001.tga", 0,438)
	mywindow:setSize(284, 55);
	mywindow:setPosition(6, 65 + i * 59);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString('index', tostring(i))
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow);
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_ItemImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(2, 2)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(112)
	mywindow:setScaleHeight(112)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)		
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_gradeImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_gradeText_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setTextColor(255,255,255,255)	
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RandomSelectBox_EventImg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RandomSelectBox")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_RandomSelectBox")
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_ItemName_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255,200,50,255)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:setPosition(60, 8)
	mywindow:setSize(220, 40)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_ItemCount_"..i)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(150,150,150,255)	
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)

	-- 아이템 등록버튼( 등록버튼 )
	mywindow = winMgr:createWindow("TaharezLook/Button", "RandomSelectBox_SelectBtn_"..i)
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", 298, 191)
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", 298, 214)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", 298, 237)
	mywindow:setTexture("PushedOff", "UIData/Randombox_001.tga", 298, 237)
	mywindow:setTexture("Disabled", "UIData/Randombox_001.tga", 298, 260)
	mywindow:setPosition(213, 27)
	mywindow:setSize(69, 23)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "RandomSelectBoxSelectBtnEvent")
	winMgr:getWindow("RandomSelectBox_"..i):addChildWindow(mywindow)
	
end


-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomSelectBox_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)


-- 페이지 좌우 버튼
local RandomSelectBox_BtnName  = {["err"]=0, [0]="RandomSelectBox_LBtn", "RandomSelectBox_RBtn"}
local RandomSelectBox_BtnTexX  = {["err"]=0, [0]=438, 457}
local RandomSelectBox_BtnPosX  = {["err"]=0, [0]=170, 270}
local RandomSelectBox_BtnEvent = {["err"]=0, [0]="OnClickRandomSelectBox_PrevPage", "OnClickRandomSelectBox_NextPage"}
for i=0, #RandomSelectBox_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", RandomSelectBox_BtnName[i])
	mywindow:setTexture("Normal", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 1)
	mywindow:setTexture("Hover", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 26)
	mywindow:setTexture("Pushed", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 51)
	mywindow:setTexture("PushedOff", "UIData/Randombox_001.tga", RandomSelectBox_BtnTexX[i], 51)
	mywindow:setPosition(RandomSelectBox_BtnPosX[i], 387)
	mywindow:setSize(19, 25)
	mywindow:setSubscribeEvent("Clicked", RandomSelectBox_BtnEvent[i])
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end

-- 페이지 좌버튼 클릭이벤트
function OnClickRandomSelectBox_PrevPage()
	local check = RandomSelectBoxPrevButtonEvent()
	if check then
		local totalPage = GetRandomSelectBoxTotalPage()
		local currentPage = GetRandomSelectBoxCurrentPage()
		winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- 페이지 우버튼 클릭이벤트
function OnClickRandomSelectBox_NextPage()
	local check = RandomSelectBoxNextButtonEvent()
	if check then
		local totalPage = GetRandomSelectBoxTotalPage()
		local currentPage = GetRandomSelectBoxCurrentPage()
		winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end


-- 페이지를 세팅해준다.
function SettingRandomSelectBoxPageText(currentPage, totalPage)
	winMgr:getWindow("RandomSelectBox_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end


-- 아이템 등록버튼 이벤트
function RandomSelectBoxSelectBtnEvent(args)
	local eventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(eventWindow:getUserString("index"))
	
	local itemName, nMatch, bIsRental   = SelectItemEvent(Index) -- g_ClassTabIndex
	local String						= string.format(TownStoreitemString, itemName)
	local IsUseable						= GetCharacterLevel(Index)

	-- Rental 스킬일때만, 레벨과, 클래스에 제한을 둔다
	if bIsRental == true then
		
		-- 자신의 클래스에 맞지 않는 아이템을 구입을 방지
		if nMatch == false then
			ShowNotifyOKMessage(PreCreateString_1089)	--GetSStringInfo(LAN_LUA_COMMON_AB_1)
			return
		end
		
		-- 캐릭터의 레벨이 낮아서 사용할수 없다
		if IsUseable == 0 then
			ShowNotifyOKMessage(PreCreateString_4194)	--GetSStringInfo(LAN_LEVEL_NOT_001)
			return
		end
	end
	
	
	ShowRandomBoxSelectPopup(String)
end


-- 아이템에 마우스 들어왔을때
function OnMouseEnter_RandomSelectBox(args)
	DebugStr("마우스들어온")
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
	local index			= tonumber(EnterWindow:getUserString("Index"))
	local Kind			= -1
	local itemKind, itemnumber, attributeType = GetRandomBoxInsideListToolTipInfo(index)
	
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	GetToolTipBaseInfo(x + 50, y, 2, Kind, 0, itemnumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	
	
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	if Kind ~= KIND_SKILL then
		return
	end
	ReadAnimation(itemnumber, attributeType)
	
	local targetx, targety = GetBasicRootPoint(winMgr:getWindow("SelectRandomboxMain"))
	
	targetx = targetx - 236
	if targetx < 0 then
		targetx = 0
	end	
	
	targety = targety - 69
	ShowAnimationWindow(targetx, y)
	SettingAnimationRect(y+49, targetx+9, 217, 164)
end


-- 아이템에서 마우스 나갔을때
function OnMouseLeave_RandomSelectBox(args)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- 광장만
		return
	end
	HideAnimationWindow()
	
end


-- 선택랜덤 박스의 선택ui를 보여준다.
function ShowSelectRandomBoxSelectWindow(propValue)
	
	root:addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setVisible(true)
	--DebugStr("propValue : " .. propValue)
	
	local startPosY = 65
	if propValue == 1 then
		if CEGUI.toRadioButton(winMgr:getWindow("RandomSelectBox_Strike")):isSelected() then
			SetTabIndex(0)
		else
			winMgr:getWindow("RandomSelectBox_Strike"):setProperty("Selected", "true")
		end	
	elseif propValue == 2 then
		--startPosY = 90
		if CEGUI.toRadioButton(winMgr:getWindow("BoneTypeTabName_0")):isSelected() then
			SetTabIndex(0)
		else
			winMgr:getWindow("BoneTypeTabName_0"):setProperty("Selected", "true")
		end	
	elseif propValue == 3 then
		SetTabIndex(0)
	elseif propValue == 4 then
		SetTabIndex(0)
	else
		SetTabIndex(0)
	end
	
	for i=0, MaxCount_OnePage-1 do
		winMgr:getWindow("RandomSelectBox_"..i):setPosition(6, startPosY + i * 59);
	end
	
	
	
end


-- 선택랜덤 박스의 선택ui를 숨겨준다.
function HideSelectRandomBoxSelectWindow()
	winMgr:getWindow("SelectRandomboxMain"):setVisible(false)
		
	-- 랜탈 스킬 관련 정리 함수
	CloseRentalSkillPopup()
end


-- 랜덤 박스의 아이템리스트를 초기화 해준다.
function ClearRandomboxItemList()
	for i=0, MaxCount_OnePage-1 do
		winMgr:getWindow("RandomSelectBox_"..i):setVisible(false)
	end
end



function OnSelect_RandomSelectBoxTab(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local tabIndex = tonumber(EnterWindow:getUserString("TabIndex"))
		SetTabIndex(tabIndex)
	end	
end
-- 

-- 랜덤 박스의 아이템리스트를 세팅해준다.
function SettingRandomboxItemList(ListIndex, index, itemName, filePath, filePath2, grade, itemCount, bPossession)
	winMgr:getWindow("RandomSelectBox_SelectBtn_"..index):setUserString("index", ListIndex)		-- 버튼에 실제 인덱스를 세팅한다.
	winMgr:getWindow("RandomSelectBox_EventImg_"..index):setUserString("Index", ListIndex)		-- 버튼에 실제 인덱스를 세팅한다.
	
	winMgr:getWindow("RandomSelectBox_"..index):setVisible(true)		
	winMgr:getWindow("RandomSelectBox_ItemName_"..index):setTextExtends(itemName, g_STRING_FONT_DODUMCHE, 12, 255,200,50,255,   0, 0,0,0,255)
	
	if bPossession == 1 then
		winMgr:getWindow("RandomSelectBox_ItemName_"..index):addTextExtends(" ["..PreCreateString_2924.."]", g_STRING_FONT_DODUMCHE, 12, 16, 240, 64,255,   0, 0,0,0,255)
	end
	
	if itemCount > 1 then
		winMgr:getWindow("RandomSelectBox_ItemCount_"..index):setText("x"..itemCount)	
	else
		winMgr:getWindow("RandomSelectBox_ItemCount_"..index):setText("")	
	end
	winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setTexture("Disabled", filePath, 0, 0)
	if filePath2 == "" then
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setLayered(false)
	else
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setLayered(true)
		winMgr:getWindow("RandomSelectBox_ItemImage_"..index):setTexture("Layered", filePath2, 0, 0)
	end
	if grade > 0 then
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setVisible(true)
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("RandomSelectBox_gradeImage_"..index):setVisible(false)
		winMgr:getWindow("RandomSelectBox_gradeText_"..index):setText("")
	end
end


function SectionRandomSelectBox(index)
	--DebugStr("[!]index : " .. index)
	local bTabVisible = false
	local bTabVisible2 = false
	
	if index == 1 then		-- 
		bTabVisible = true	-- 탭을 보여준다.
	elseif index == 2 then
		bTabVisible = false	-- 탭을 숨겨준다.
		--bTabVisible2 = true
	elseif index == 3 then
		bTabVisible = false	-- 탭을 숨겨준다.
	elseif index == 4 then
		bTabVisible = false	-- 탭을 숨겨준다.
	end	
	
	for i=0, #RandomSelectBoxTabName do
		winMgr:getWindow(RandomSelectBoxTabName[i]):setVisible(bTabVisible)
	end	
	for i=0, #BoneTypeTabTexX do
		winMgr:getWindow("BoneTypeTabName_"..i):setVisible(bTabVisible2)
	end	
end



--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'RandomBoxSelect_AlphaImage')
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("RandomBoxSelect_AlphaImage", "HideRandomBoxSelectPopup")

--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'RandomBoxSelect_MainImage')
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0)
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2)
mywindow:setSize(340, 268)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('RandomBoxSelect_AlphaImage'):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "RandomBoxSelect_Text")
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setPosition(3, 45)
mywindow:setSize(340, 180)
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(2)
winMgr:getWindow('RandomBoxSelect_MainImage'):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 버튼 (확인, 취소)
--------------------------------------------------------------------
local ButtonName	= {['protecterr']=0, "RandomBoxSelect_Reform", "RandomBoxSelect_Cancel"}
local ButtonTexX	= {['protecterr']=0,		693,			858}
local ButtonPosX	= {['protecterr']=0,		4,				169}		
local ButtonEvent	= {['protecterr']=0, "RandomBoxSelect_ReformEvent", "RandomBoxSelect_CancelEvent"}

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setPosition(ButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('RandomBoxSelect_MainImage'):addChildWindow(mywindow)
end


function RandomBoxSelect_ReformEvent(args)
	DebugStr("RandomBoxSelect_ReformEvent")
	
	HideSelectRandomBoxSelectWindow() 
	
	-- ★
	if GetAutoTakeFlag() == true then
		RequestAutoTakeRentalSkill(); -- 새로운 Take All 렌탈스킬
	else
		RequestSkillRandomBox(); -- 기존의 렌탈스킬
	end
	
	HideRandomBoxSelectPopup()
end



function RandomBoxSelect_CancelEvent(args)
	HideRandomBoxSelectPopup()
end


-- 
function ShowRandomBoxSelectPopup(string)
	root:addChildWindow(winMgr:getWindow('RandomBoxSelect_AlphaImage'))

	local x,y = GetWindowSize()
	x = (x/2) - (340/2)
	y = (y/2) - (268/2)
	winMgr:getWindow('RandomBoxSelect_MainImage'):setPosition(x,y)
	
	winMgr:getWindow('RandomBoxSelect_AlphaImage'):setVisible(true)
	winMgr:getWindow('RandomBoxSelect_Text'):setTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255, 2, 0,0,0,255)
end


-- 
function HideRandomBoxSelectPopup()
	winMgr:getWindow('RandomBoxSelect_AlphaImage'):setVisible(false)
end







--***************************************************************************************************************************
--											랜탈 스킬 ( 하루 기간제 +9강 스킬 )
--***************************************************************************************************************************
RegistEscEventInfo("RentalSkill_Main_Alpha", "HideSelectRandomBoxSelectWindow")


















----------------------------------------------------------------------
-- 랜탈 스킬 백판 알파
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkill_Main_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setWideType(6)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2) - 425/2 , (g_MAIN_WIN_SIZEY / 2) - 503/2 )
mywindow:setSize(425, 510)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
-- 랜탈 스킬 백판
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkill_Main")
mywindow:setTexture("Enabled",	"UIData/Randombox_002.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/Randombox_002.tga", 0,0)
mywindow:setPosition(0,0)
mywindow:setSize(425, 510)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 타이틀바
----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/Titlebar", "RentalSkill_Title")
mywindow:setPosition(0, 0)
mywindow:setSize(390, 45)
mywindow:setEnabled(true)
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)

----------------------------------------------------------------------
-- 랜탈 스킬 닫기 버튼
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "RentalSkill_Close_Btn")
mywindow:setTexture("Normal",	"UIData/Randombox_001.tga", 476, 1)
mywindow:setTexture("Hover",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("Pushed",	"UIData/Randombox_001.tga", 476, 24)
mywindow:setTexture("PushedOff","UIData/Randombox_001.tga", 476, 24)
mywindow:setPosition(390, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideSelectRandomBoxSelectWindow")
winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(mywindow)


----------------------------------------------------------------------
-- 0 = [랜탈 스킬 제목창] , 1 = [+7 이벤트 스킬 제목창] ,  rkawk
----------------------------------------------------------------------

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Rental_BoxSkill_Level")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(198, 7)
mywindow:setSize(26, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)

function SetBoxName()
	DebugStr("SetBoxName() 진입")
	
	-- Exception handling --
	local propIndex4 = GetPropIndex4();
	if propIndex4 == -1 then
		DebugStr("propIndex4가 -1이라 리턴 : 오류")
		return
	end
	DebugStr("propIndex4 : " .. propIndex4)
	
	-- Setting --
	if propIndex4 == -10 then		--> +9 렌탈 스킬.
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Enabled",		"UIData/Randombox_002.tga", 425, 176)
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Disabled",	"UIData/Randombox_002.tga", 425, 176)
	elseif propIndex4 == -11 then	--> +7 이벤트 스킬.
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Enabled",		"UIData/Randombox_002.tga", 425, 132)
		winMgr:getWindow("Rental_BoxSkill_Level"):setTexture("Disabled",	"UIData/Randombox_002.tga", 425, 132)
	end
	
end


----------------------------------------------------------------------
-- 랜탈 스킬 직업별 버튼
----------------------------------------------------------------------
local RentalSkillBtnName  = { ["err"]=0, [0] = "RentalSkill_TaeKwonDo_Btn", "RentalSkill_Boxing_Btn", "RentalSkill_Muta_Btn",   "RentalSkill_Capo_Btn",-- 스트리트
											   "RentalSkill_Pro_Btn",		"RentalSkill_Judo_Btn",   "RentalSkill_Hapgido_Btn","RentalSkill_Sambo_Btn", -- 러쉬
											   "RentalSkill_DirtyX_Btn",	"RentalSkill_Sumo_Btn",	  "RentalSkill_KungPu",		"RentalSkill_Ninja" }

local RentalSkillTexX	  = { ["err"]=0, [0] = 0  , 110 , 220 , 330 ,
											   0  , 110 , 220 , 330 ,
											   0  , 110 , 220,  330 }
											   
local RentalSkillTexY	  = { ["err"]=0, [0] = 0   , 0   , 0   , 0   ,
											   156 , 156 , 156 , 156 ,
											   312 , 312 , 312,  312 }
											   											   
local RentalSkillPosY	  = { ["err"]=0, [0] = 72, 111, 150, 189,
											   228, 267, 306, 345,
											   384, 423, 462, 462 }

local RentalItemIndex	  = { ["err"]=0, [0] = 3 , 5 , 17 , 9,
											   18, 4 , 10 , 6 ,
											   35, 67, 131, 259}			-- 스킬아이템의 promotion 값과 style 값을 더해준 값

--------------------------------------------------------------------------------
-- zeustw {
-- 캐릭터에 맞는 RentalItemIndex만 보이기 위해 캐릭터의 직업 구분용으로 추가.
-- 임의로 캐릭터의 style * 100 + promotion 을 하여 넘버링 함.
-- common.lua 에 캐릭터 번호가 있다 이것을 이용할 수 있는지 확인하자.
-- c함수 GetMyCharacterClass() 를 통해 번호를 받아온다.
local ClassIndex		  = { ["err"]=0, [0] =
							  001, 002, 004, 003, -- 태권도, 복싱, 무에타이, 카포에라
							  102, 101, 103, 104, -- 프로레슬링, 유도, 합기도, 삼보
							  005, 006, 007, 008 }     -- 더티엑스, 스모, 쿵푸
-- zeustw }
--------------------------------------------------------------------------------
							  
-- 직업별 버튼 등록하기
for i=0, #RentalSkillBtnName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RentalSkillBtnName[i])
	mywindow:setTexture("Normal",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+117)
	mywindow:setTexture("Hover",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+39)
	mywindow:setTexture("Pushed",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+78)
	mywindow:setTexture("Disabled",			"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i]+117)
	mywindow:setTexture("SelectedNormal",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	mywindow:setTexture("SelectedHover",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	mywindow:setTexture("SelectedPushed",	"UIData/Randombox_003.tga", RentalSkillTexX[i] , RentalSkillTexY[i])
	--mywindow:setPosition(10 , RentalSkillPosY[i])
	mywindow:setPosition(10 , (40*i)+72)
	mywindow:setSize(110, 39)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Rental_Index", RentalItemIndex[i])
	mywindow:setUserString("Rental_Index_Line", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RentalBoxTab")
	winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)
	
	
	-- 클래스 라디오 버튼 테두리
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", RentalSkillBtnName[i] .. "_YellowLine")
	mywindow:setTexture("Enabled", "UIData/Randombox_003.tga", 0,468)
	mywindow:setPosition(5 , (40*i)+68)
	mywindow:setSize(116, 44)
	mywindow:setScaleWidth(265)
	mywindow:setScaleHeight(265)
	
	if i == 0 then
		mywindow:setVisible(true)
	else
		mywindow:setVisible(false)
	end
	
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Rental_Index", RentalItemIndex[i])
	winMgr:getWindow("RentalSkill_Main"):addChildWindow(mywindow)
end

------------------------------------------------
-- 클래스 버튼 클릭 이벤트 함수
------------------------------------------------
function OnSelect_RentalBoxTab(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local tabIndex	= tonumber(EnterWindow:getUserString("Rental_Index"));
		local LineIndex = tonumber(EnterWindow:getUserString("Rental_Index_Line"));
		
		g_ClassTabIndex = tabIndex;
		
		-- zeustw
		--[[
		--+============================================================+
		-- ** 클래스 버튼 노란 테두리 재설정
		for i = 0 , #RentalSkillBtnName do
			winMgr:getWindow(RentalSkillBtnName[i] .. "_YellowLine"):setVisible(false)
		end
		winMgr:getWindow(RentalSkillBtnName[LineIndex] .. "_YellowLine"):setVisible(true)
		--+============================================================+
		--]]
		-- zeustw
		
		
		DebugStr("tabIndex : " .. tabIndex)
		InitRentalSkillPopup()		-- 랜탈 스킬 초기화
		ChangeClassImage(tabIndex)	-- 클래스 아이콘 이미지 재설정
		RequestRentalSkillIndex(tabIndex)
		
		SelectFirstCategory()
	end
end


----------------------------------------------------------------------
-- 랜탈 스킬 종류별 "카테고리" 버튼
----------------------------------------------------------------------
local RentalCategoryName = { ["err"]=0, [0] = "RentalCategory_Attack", "RentalCategory_Grap", "RentalCategory_Special", "RentalCategory_TeamAttack" }

local RentalCategortTexY = { ["err"]=0, [0] = 92, 191, 389, 290 } -- Texture Postion Y
local RentalCategortPosX = { ["err"]=0, [0] = 10, 79, 148, 217}	  -- Game Postion X

-- 직업별 버튼 등록하기
for i=0, #RentalCategoryName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", RentalCategoryName[i])
	mywindow:setTexture("Normal",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i])
	mywindow:setTexture("Hover",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+33)
	mywindow:setTexture("Pushed",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("Disabled",			"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+33)
	mywindow:setTexture("SelectedNormal",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("SelectedHover",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setTexture("SelectedPushed",	"UIData/Randombox_003.tga", 440 , RentalCategortTexY[i]+66)
	mywindow:setPosition(RentalCategortPosX[i] , 25)
	mywindow:setSize(67, 33)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setUserString("RentalCategory_Index", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_RentalCategory")
	winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)
end

function OnSelect_RentalCategory(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local index = tonumber(EnterWindow:getUserString("RentalCategory_Index"))
		
		SelectCategory(index) -- 인덱스 넘김. 카테고리 분류 처리
	end
end

-- 클래스 목록 전체를 불러오던 코드를 재 갱신하여 자신의 클래스에 맞는 것만
-- 표시해준다. 이 방식이 확정되면 이전에 목록 전체를 표시하던 방식과 관련한
-- 코드 없어져도 된다.
function ActivateOnlyMyCharacterClass()
	classTabIndex = GetMyCharacterClass()
	
	for i=0, #RentalItemIndex do
		winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
	end
	
	for i=0, #RentalItemIndex do
		if ClassIndex[i] == classTabIndex then
			winMgr:getWindow(RentalSkillBtnName[i]):setPosition(10 , RentalSkillPosY[0])
			winMgr:getWindow(RentalSkillBtnName[i]):setVisible(true)
			winMgr:getWindow(RentalSkillBtnName[i]):setProperty("Selected", "true")
			break
		end
	end
end

-- 현재 활성화된 카테고리 중 첫번째 카테고리를 선택한다
function SelectFirstCategory()
	-- class 의 category 가 아이템을 가지고 있지 않을 경우 invisible되는 경우가
	-- 있기 때문에 category중 첫번째로 visible 되어있는 category를 기본 선택해준다
	for i=0, #RentalCategoryName do
		if winMgr:getWindow(RentalCategoryName[i]):isVisible() == true then
			winMgr:getWindow(RentalCategoryName[i]):setProperty("Selected", "true")
			
			SelectCategory(i)
			
			break
		end
	end
end







-- 랜탈 스킬 팝업창 초기화
function InitRentalSkillPopup()
	-- 닫기 버튼 삭제
	winMgr:getWindow("SelectRandombox_CloseButton"):setVisible(false)
	
	-- 인벤 제한
	winMgr:getWindow("MainBar_Bag"):setEnabled(false)
	
	-- 카테고리 버튼 켜주기
	if g_ClassTabIndex ~= -1 then
		local visibleCount = 0 -- visible 되는 category 갯수에 따라 버튼 위치를 앞쪽으로 정렬하기 위해
		for i=0 , #RentalCategoryName do
			local itemCount = RequestRentalSkillIndexCount(g_ClassTabIndex, i);
			
			if itemCount > 0 then
				winMgr:getWindow(RentalCategoryName[i]):setVisible(true)
				winMgr:getWindow(RentalCategoryName[i]):setPosition(RentalCategortPosX[visibleCount], 25)
				visibleCount = visibleCount + 1
			else
				winMgr:getWindow(RentalCategoryName[i]):setVisible(false)
			end
		end
	end
	
	-- 리스트창의 부모 변경
	winMgr:getWindow("RentalSkill_Main_Alpha"):addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setTexture("Enabled", "UIData/invisible.tga", 0,0)
	winMgr:getWindow("SelectRandomboxMain"):setWideType(0)
	winMgr:getWindow("SelectRandomboxMain"):setPosition(tRentalPosition[0] , tRentalPosition[1])
	winMgr:getWindow("SelectRandomboxMain"):setVisible(true)
end






-- 랜탈 스킬 팝업창 종료
function CloseRentalSkillPopup()
	-- 닫기 버튼 보여주기
	winMgr:getWindow("SelectRandombox_CloseButton"):setVisible(true)
	
	-- 인벤 제한 해제
	winMgr:getWindow("MainBar_Bag"):setEnabled(true)
	
	-- 카테고리 버튼 끄기
	for i=0 , #RentalCategoryName do
		winMgr:getWindow(RentalCategoryName[i]):setVisible(false)
	end
	
	
	-- 리스트창의 부모 다시 되돌림
	root:addChildWindow(winMgr:getWindow("SelectRandomboxMain"))
	winMgr:getWindow("SelectRandomboxMain"):setTexture("Enabled", "UIData/Randombox_001.tga", 0,0)
	winMgr:getWindow("SelectRandomboxMain"):setWideType(6)
	winMgr:getWindow("SelectRandomboxMain"):setPosition(tNormalPosition[0] , tNormalPosition[1])
	winMgr:getWindow("SelectRandomboxMain"):setVisible(false)
	
	-- 창닫기
	winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(false)
	winMgr:getWindow("RentalSkill_Main"):setVisible(false)
	
	
	-- AutoTake모드 끝
	DebugStr("AutoTake모드 끝")
	SetAutoTakeFlag(false);
	
end






--*********************************************************
-- function  : RentalSkill_On()
-- Desc      : 랜탈 스킬 UI 켜기 ★
--*********************************************************
function RentalSkill_On()
	DebugStr("RentalSkill_On");
	
	-- 인벤토리 off
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	
	-- 박스 이름 설정( 렌탈, 이벤트 )
	SetBoxName();
	
	-- 클래스 버튼 초기화 ( 미선택 상태로.. )
	for i=0 , #RentalSkillBtnName do
		winMgr:getWindow(RentalSkillBtnName[i]):setProperty("Selected" , "false")
	end
	
	-- 스킬 선택창 열기
	if winMgr:getWindow("RentalSkill_Main_Alpha"):isVisible() == true then
		winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(false)
		winMgr:getWindow("RentalSkill_Main"):setVisible(false)
		
		for i=0 , #RentalSkillBtnName do
			winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
		end
				
	else
		winMgr:getWindow("RentalSkill_Main_Alpha"):setVisible(true)
		winMgr:getWindow("RentalSkill_Main"):setVisible(true)
		
		-- ★ 쿵푸 버튼 임시적으로 막기 ★
		for i=0 , #RentalSkillBtnName do
		--	if i ~= 10 then
				winMgr:getWindow(RentalSkillBtnName[i]):setVisible(true)
		--	else
		--		winMgr:getWindow(RentalSkillBtnName[i]):setVisible(false)
		--	end
		end
		
		
		InitRentalSkillPopup()			-- UI창 초기화
		RequestRentalSkillIndex(3,0)	-- 클래스 태권도, 카테고리 타격으로 강제 설정
		winMgr:getWindow("RentalCategory_Attack"):setProperty( "Selected" , "true" )	 -- 카테고리 : 타격으로 고정
		winMgr:getWindow("RentalSkill_TaeKwonDo_Btn"):setProperty( "Selected" , "true" ) -- 클래스 : 태권도로 고정
	end
	
	ActivateOnlyMyCharacterClass()
	
	
	-------------------------------------------
	-- ** bISAutoTakeMode
	-- 1. 그냥 일반 렌탈스킬창?
	-- 2. 오토 테이크 렌탈스킬창?
	-------------------------------------------
	local bISAutoTakeMode = GetAutoTakeFlag();
	SetRentalSkillButton(bISAutoTakeMode);
end









----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-- Auto Take 랜탈 스킬 관련
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

-- 버튼 옵션 변경
function SetRentalSkillButton(TakeMode)
	-- 1. 아이템 선택버튼 삭제 ============ 전부받기 버튼 생성
	-- 2. 직업 아이콘 만들기
	-- 3. 페이지 이동 버튼 이동
	
	RadioFlag = true;
	
	if TakeMode == true then
		RadioFlag = false;
	end

	
	-- [한번에 받기 버튼] 설정
	winMgr:getWindow("RandomSelectBox_AutoTakeBtn"):setVisible(TakeMode)

	
	-- [페이지 이동 버튼] 설정
	if TakeMode == true then
		
		for i = 0 , #RandomSelectBox_BtnName do
			winMgr:getWindow(RandomSelectBox_BtnName[i]):setPosition(RandomSelectBox_BtnPosX[i] - 80 , 375)
		end
		winMgr:getWindow("RandomSelectBox_PageText"):setPosition(188 - 80, 380) -- 페이지 넘버
		
	else
		
		for i = 0 , #RandomSelectBox_BtnName do
			winMgr:getWindow(RandomSelectBox_BtnName[i]):setPosition(RandomSelectBox_BtnPosX[i], 405)
		end
		winMgr:getWindow("RandomSelectBox_PageText"):setPosition(188, 410) -- 페이지 넘버
	end
	
	
	-- [선택 라디오 버튼] 지우기
	for j = 0 , MaxCount_OnePage - 1 do
		winMgr:getWindow("RandomSelectBox_SelectBtn_" .. j):setVisible(RadioFlag);
	end
	
	
end






-- 한번에 받아오기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "RandomSelectBox_AutoTakeBtn")
mywindow:setTexture("Normal",		"UIData/Randombox_001.tga", 298, 317)
mywindow:setTexture("Hover",		"UIData/Randombox_001.tga", 298, 349)
mywindow:setTexture("Pushed",		"UIData/Randombox_001.tga", 298, 381)
mywindow:setTexture("PushedOff",	"UIData/Randombox_001.tga", 298, 381)
mywindow:setTexture("Disabled",		"UIData/Randombox_001.tga", 298, 381)
mywindow:setPosition(145, 405)
mywindow:setSize(139, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "AutoTakeBtnEvent")
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)

function AutoTakeBtnEvent()
	DebugStr("AutoTakeBtnEvent")
	
	local bClassMatch, bIsRental, bIsLowLevel = GetItemInfo();
	

	-- Rental 스킬일때만, 레벨과, 클래스에 제한을 둔다
	if bIsRental == true then
		
		-- 자신의 클래스에 맞지 않는 아이템을 구입을 방지
		if bClassMatch == false then
			DebugStr("클래스가 맞지않음")
			ShowNotifyOKMessage(PreCreateString_1089)	--GetSStringInfo(LAN_LUA_COMMON_AB_1)
			return
		end
		
		-- ( Take All은 렙제가 없다 )
		-- 캐릭터의 레벨이 낮아서 사용할수 없다
		--if bIsLowLevel == true then
			--DebugStr("레벨이 맞지않음")
			--ShowNotifyOKMessage(PreCreateString_4194)	--GetSStringInfo(LAN_LEVEL_NOT_001)
			--return
		--end
		
	end
	
	local sstring = GetClassName(g_ClassTabIndex)
	ShowCommonAlertOkCancelBoxWithFunction("", sstring , "AutoTakeOKEvent", "AutoTakeNoEvent")
end

function AutoTakeOKEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "AutoTakeOKEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	
	HideSelectRandomBoxSelectWindow() 
	
	RequestAutoTakeRentalSkill(); -- 새로운 Take All 렌탈스킬
	
	HideRandomBoxSelectPopup()
	
end


function AutoTakeNoEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "AutoTakeNoEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end




-- 클래스 아이콘
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RentalSkillClassImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Layered",	"UIData/invisible.tga", 0, 0)
mywindow:setPosition(30 , 405)
mywindow:setSize(89,35)
mywindow:setLayered(true)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SelectRandomboxMain"):addChildWindow(mywindow)

function ChangeClassImage( tabindex )
	-- 자동 다 받기 모드가 아니면 설정하지 않는다.
	local IsAutoTakeMode = GetAutoTakeFlag();
	if IsAutoTakeMode == false then
		winMgr:getWindow("RentalSkillClassImage"):setVisible(false)
		DebugStr("ChangeClassImage Return")
		return
	end
	
	--local style			= 0 -- 0 : 스트리트 , 1 : 러쉬
	--local promotion		= 6 -- 직업 1 ~ 4 (5,6 : 더티,스모)ㄴ
	--local attribute		= 0 -- 0 : 파란, 0 : 레드, 2 : 그린 , 3 : 노랑
	local style, promotion, attribute = GetClassInfo(tabindex);
	
	
	winMgr:getWindow("RentalSkillClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", 
						tAttributeImgTexXTable[style][attribute],  tAttributeImgTexYTable[style][attribute])	-- 뒷배경
	winMgr:getWindow("RentalSkillClassImage"):setTexture("Layered",	 "UIData/Skill_up2.tga", 
						promotionImgTexXTable[style],				promotionImgTexYTable[promotion])			-- 클래스 글씨
	
	
	winMgr:getWindow("RentalSkillClassImage"):setScaleWidth(255)
	winMgr:getWindow("RentalSkillClassImage"):setScaleHeight(200)
	winMgr:getWindow("RentalSkillClassImage"):setVisible(true)
end

function RequestAutoTakeReturn(class)
	local sstring = GetClassName2(g_ClassTabIndex)
	ShowNotifyOKMessage(sstring)
end

