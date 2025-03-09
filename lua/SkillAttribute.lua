--------------------------------------------------------------------
-- SkillAttribute.lua
--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")


local MAX_ATTRIBUTEITEM_ITEMLIST = GetOnePageAttributeListMaxCount()	-- 아이템 목록의 한페이지에 들어가는 아이템의 최대 갯수
local CHARACTER_ATTRIBUTE = 0	-- 캐릭터 속성
local SKILL_ATTRIBUTE	  = 1	-- 스킬속성
local attributeCurrentMode= 0	-- 현재 속성 모드



-- 들어오는 속성에따라 나오는 상대속성 위치가 틀려진다.
-- 지, 수, 화, 풍 이 들어왔을 때
local tAttributeGround = {['err']=0, [0] = 923, 850, 777, 704}		-- 지 속성을 선택했을 때
local tAttributeWater  = {['err']=0, [0] = 777, 704, 923, 850}		-- 수 속성을 선택했을 때
local tAttributeFire   = {['err']=0, [0] = 704, 923, 850, 777}		-- 화 속성을 선택했을 때
local tAttributeWind   = {['err']=0, [0] = 850, 777, 704, 923}		-- 풍 속성을 선택했을 때
local tAttributeTexXTable = {['err']=0, [0] = tAttributeWater, tAttributeFire, tAttributeWind, tAttributeGround}	-- 속성에 관한 테이블
local tAttributeMain   = {['err']=0, [0] = 704, 923, 777, 850}		-- 지, 수, 화, 풍


local tSkillAttributeGround = {['err']=0, [0] = 777, 704, 923, 850}		-- 지 속성을 선택했을 때
local tSkillAttributeWater  = {['err']=0, [0] = 923, 850, 777, 704}		-- 수 속성을 선택했을 때
local tSkillAttributeFire   = {['err']=0, [0] = 850, 777, 704, 923}		-- 화 속성을 선택했을 때
local tSkillAttributeWind   = {['err']=0, [0] = 704, 923, 850, 777}		-- 풍 속성을 선택했을 때
local tSkillAttributeTexXTable = {['err']=0, [0] = tSkillAttributeWater, tSkillAttributeFire, tSkillAttributeWind, tSkillAttributeGround}	-- 속성에 관한 테이블



---------------------------------
-- 화살표 이미지.
---------------------------------
local tTexX		= {["err"]=0, [0]= 818,704,780,742}--,280,312,280,312}
local tArrowTexX= {["err"]=0, [0]= 780,742,818,704}--742,780,704,818}--	818,704,780,742}--,280,312,280,312}
local tTexY		= {["err"]=0, [0]=	 0,	 0,	 0,	 0}--,642,738,738,738}
local tDisTexX  = {["err"]=0, [0]= 818,704,780,742}--,376,408,376,408}
local tArrowDisTexX = {["err"]=0, [0]= 742,780,704,818}--,376,408,376,408}
local tDisTexY  = {["err"]=0, [0]=	 0,	 0,	 0,	 0}--,642,738,738,738}
local tPosX		= {["err"]=0, [0]= 155,214,155,96}--,107,206,160,114}
local tPosY		= {["err"]=0, [0]= 341,401,461,401}--,351,406,452,406}
local tSizeX	= {["err"]=0, [0]= 38,38,38,38}--,48,32,32,32}
local tSizeY	= {["err"]=0, [0]= 38,38,38,38}--,48,32,32,32}

-- 속성이름 이미지분류(위, 오른쪽, 아래, 왼쪽)
local ttCharacterAttributeTexX  = {["err"]=0, [0]= 850, 704, 923, 777}
local ttSkillAttributeTexX		= {["err"]=0, [0]= 850, 704, 923, 777}
local ttCharacterAttributePosX  = {["err"]=0, [0]= 138, 250, 138, 25}
local ttCharacterAttributePosY  = {["err"]=0, [0]= 291, 402, 497, 402}






-- 스킬 속성 부여알파 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(g_MAIN_WIN_SIZEX, g_MAIN_WIN_SIZEY)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


RegistEscEventInfo("SkillAttributeAlphaImage", "HideSkillAttributeWindow")


------------------------------------------------------------------------------------------------------------------------------------
---------------------------------
-- 스킬에 속성부여 메인 이미지.
---------------------------------
local SkillAttributeMainWindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeMainImage")
SkillAttributeMainWindow:setTexture("Enabled", "UIData/skill_up.tga", 0, 0)
SkillAttributeMainWindow:setPosition(40,50)
SkillAttributeMainWindow:setSize(352, 700)
SkillAttributeMainWindow:setVisible(true)
SkillAttributeMainWindow:setAlwaysOnTop(true)
SkillAttributeMainWindow:setZOrderingEnabled(false)
winMgr:getWindow("SkillAttributeAlphaImage"):addChildWindow(SkillAttributeMainWindow)

--[[
ATTRIBUTE_DEFAULT,		// 기본(모든 속성에 80%)
ATTRIBUTE_GROUND,
ATTRIBUTE_WATER,
ATTRIBUTE_FIRE,	
ATTRIBUTE_WIND,
ATTRIBUTE_END,
--]]




---------------------------------
-- 속성을 부여할 스킬(등급), 재료(갯수) 60*60(아이콘 축소)
---------------------------------
local GrantItemName = {[0]="GrantAttributeSkill", "GrantAttributeStuff"}
local GrantItemPosX = {[0]= 80, 212}


for i=0, #GrantItemName do
	-- 아이템 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", GrantItemName[i].."_BackImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(GrantItemPosX[i], 125)
	mywindow:setSize(60, 60)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	SkillAttributeMainWindow:addChildWindow(mywindow)

	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", GrantItemName[i].."_MainImg")
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(-19,-19)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setAlign(8)
	mywindow:setScaleWidth(157)
	mywindow:setScaleHeight(157)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)
	mywindow:addController("ItemImg", "itemRegistr_Event", "xscale", "Sine_EaseIn", 1000, 157, 3, true, false, 10)
	mywindow:addController("ItemImg", "itemRegistr_Event", "yscale", "Sine_EaseIn", 1000, 157, 3, true, false, 10)
	mywindow:addController("ItemImg", "itemRegistr_Event", "alpha", "Sine_EaseIn", 100, 255, 3, true, false, 10)
	winMgr:getWindow(GrantItemName[i].."_BackImg"):addChildWindow(mywindow)
	
		
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", GrantItemName[i].."_GradeImg")
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(3, 3)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(GrantItemName[i].."_BackImg"):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", GrantItemName[i].."_GradeText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(8, 3)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(GrantItemName[i].."_BackImg"):addChildWindow(mywindow)
	
	-- 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", GrantItemName[i].."_CountText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(8, 4)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(GrantItemName[i].."_BackImg"):addChildWindow(mywindow)

	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/Button", GrantItemName[i].."_Tooltip")
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(70, 70)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_MySkillAttributeInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_MySkillAttributeInfo")
	winMgr:getWindow(GrantItemName[i].."_BackImg"):addChildWindow(mywindow)
	
end


-- 스킬 
for i=0, #tArrowTexX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillArrow_"..i)
	mywindow:setTexture("Enabled", "UIData/skill_up.tga", tArrowTexX[i], tTexY[i])
	mywindow:setTexture("Disabled", "UIData/skill_up.tga", tArrowDisTexX[i], tDisTexY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setVisible(true)
--	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("tAttributeBtn", "tSkillAttributeArrow_Event", "alpha", "Linear_EaseNone", 100, 255, 3, true, true, 10)
	mywindow:addController("tAttributeBtn", "tSkillAttributeArrow_Event", "alpha", "Linear_EaseNone", 255, 100, 7, true, true, 10)
	SkillAttributeMainWindow:addChildWindow(mywindow)
end


for i=0, #ttSkillAttributeTexX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeImg_"..i)
	mywindow:setTexture("Enabled", "UIData/skill_up.tga", ttSkillAttributeTexX[i], 38)
	mywindow:setTexture("Disabled", "UIData/skill_up.tga", ttSkillAttributeTexX[i], 38)
	mywindow:setPosition(ttCharacterAttributePosX[i], ttCharacterAttributePosY[i])
	mywindow:setSize(73, 34)
	mywindow:setVisible(true)
	mywindow:setAlign(8)
	--mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	mywindow:addController("SkillAttributeImg", "tSkillAttributeImage_Event", "xscale", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	mywindow:addController("SkillAttributeImg", "tSkillAttributeImage_Event", "yscale", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	mywindow:addController("SkillAttributeImg", "tSkillAttributeImage_Event", "alpha", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	--mywindow:addController("SkillAttributeImg", "tSkillAttributeImage_Event", "angle", "Sine_EaseIn", 0, 2000, 5, true, false, 10)
	SkillAttributeMainWindow:addChildWindow(mywindow)
end

-- 속성의 변화에 따라 변하는 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectSkillAttributeItemImg")
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 704, 158)
mywindow:setPosition(138, 384)
mywindow:setSize(73, 73)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
SkillAttributeMainWindow:addChildWindow(mywindow)


-- 스킬 속성 적용버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillAttributeApplyBtn")
mywindow:setTexture("Normal", "UIData/skill_up.tga", 704, 231)
mywindow:setTexture("Hover", "UIData/skill_up.tga", 704, 260)
mywindow:setTexture("Pushed", "UIData/skill_up.tga", 704, 289)
mywindow:setTexture("PushedOff", "UIData/skill_up.tga", 704, 289)
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 704, 318)
mywindow:setPosition(66, 662)
mywindow:setSize(100, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickSkillAttributeApply")
SkillAttributeMainWindow:addChildWindow(mywindow)


-- 캐릭터 속성 취소버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillAttributeCancelBtn")
mywindow:setTexture("Normal", "UIData/skill_up.tga", 804, 231)
mywindow:setTexture("Hover", "UIData/skill_up.tga", 804, 260)
mywindow:setTexture("Pushed", "UIData/skill_up.tga", 804, 289)
mywindow:setTexture("PushedOff", "UIData/skill_up.tga", 804, 289)
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 804, 318)
mywindow:setPosition(186, 662)
mywindow:setSize(100, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickSkillAttributeCancel")
SkillAttributeMainWindow:addChildWindow(mywindow)



-- 아이템에 마우스 들어왔을때 이벤트
function MouseEnter_MySkillAttributeInfo(args)


end


-- 아이템에서 마우스가 나갔을때 이벤트
function MouseLeave_MySkillAttributeInfo(args)



end


-- 속성을 부여할 아이템의 정보를 표시해준다
function SetAttributeItemInfo(itemType, fileName, fileName2, Grade, itemCount)
	
--	winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setPosition(tItemKindPosX[ItemType]-4, tItemKindPosY[ItemType]-4)
--	winMgr:getWindow(tItemKindTable[ItemType].."_BackImg"):setSize(60, 60)
--	winMgr:getWindow(tItemKindTable[ItemType].."_EmptyImg"):setVisible(false)
--	winMgr:getWindow(tItemKindTable[ItemType].."_MainImg"):setVisible(true)
	
	-- 	아이템 이미지
	winMgr:getWindow(GrantItemName[itemType].."_MainImg"):setTexture("Disabled", fileName, 0, 0)
	if ItemFileName2 ~= "" then
		winMgr:getWindow(GrantItemName[itemType].."_MainImg"):setLayered(true)		
		winMgr:getWindow(GrantItemName[itemType].."_MainImg"):setTexture("Layered", fileName2, 0, 0)
	else
		winMgr:getWindow(GrantItemName[itemType].."_MainImg"):setLayered(false)
		winMgr:getWindow(GrantItemName[itemType].."_MainImg"):setTexture("Layered", "UIData/invisible", 0, 0)
	end
	
	-- 스킬 등급표시	
	if Grade > 0 then
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(true)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[Grade], 486)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setTextColor(tGradeTextColorTable[Grade][1], tGradeTextColorTable[Grade][2], tGradeTextColorTable[Grade][3], 255)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setText("+"..Grade)
	else
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeImg"):setVisible(false)
		winMgr:getWindow(tItemKindTable[ItemType].."_GradeText"):setText("")
	end
	
	-- 아이템의 갯수
	if itemCount > 1 then
		winMgr:getWindow(tItemKindTable[ItemType].."_CountText"):setText("x "..itemCount)
	else
		winMgr:getWindow(tItemKindTable[ItemType].."_CountText"):setText("")
	end
end


-- 스킬속성 부여해 달라고 보낸다.
function ClickSkillAttributeApply()
	ShowAttributeConfirmPopup(1)
end



-- 스킬 속성에 관련된 ui들을 초기화시켜준다.
function ClearSkillAttributeUi()
	for i=0, #GrantItemName do
	-- 아이템 이미지.
		winMgr:getWindow(GrantItemName[i].."_MainImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		
	end	
	winMgr:getWindow("SelectSkillAttributeItemImg"):setTexture("Disabled", "UIData/skill_up.tga", 704, 158)

	for i=0, 3 do
		winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Enabled", "UIData/invisible.tga", 0, 38)
		winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 38)
		winMgr:getWindow("SkillArrow_"..i):clearActiveController()
	end
end

function ClearSkillAttributeValue()
	ClearSkillAttribute()
end



-- 스킬 속성부여값에 따라 ui를 세팅해준다.
function SelectSkillAttributeIndex(attributeIndex)
	if attributeIndex == -1 then
		winMgr:getWindow("SelectSkillAttributeItemImg"):setTexture("Disabled", "UIData/skill_up.tga", 704, 158)

		for i=0, 3 do
			winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Enabled", "UIData/invisible.tga", 0, 38)
			winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 38)
			winMgr:getWindow("SkillArrow_"..i):clearActiveController()
		end
		return
	end
	local tBuf = tSkillAttributeTexXTable[attributeIndex]
	for i=0, #tBuf do
		winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Enabled", "UIData/skill_up.tga", tBuf[i], 38)
		winMgr:getWindow("SkillAttributeImg_"..i):setTexture("Disabled", "UIData/skill_up.tga", tBuf[i], 38)
		winMgr:getWindow("SkillAttributeImg_"..i):activeMotion("tSkillAttributeImage_Event")
		winMgr:getWindow("SkillArrow_"..i):activeMotion("tSkillAttributeArrow_Event")
		
	end
	winMgr:getWindow("SelectSkillAttributeItemImg"):setTexture("Disabled", "UIData/skill_up.tga", tAttributeMain[attributeIndex], 85)

end



-- 등록된 스킬, 속성아이템의 이미지를 세팅해준다.
function SetSkillAttributeItemImg(type, fileName)
	if type == -1 then
		return
	end
	--winMgr:getWindow(GrantItemName[type].."_MainImg"):setTexture("Enabled", path, 0, 0)
	winMgr:getWindow(GrantItemName[type].."_MainImg"):setTexture("Disabled", fileName, 0, 0)
	winMgr:getWindow(GrantItemName[type].."_MainImg"):activeMotion("itemRegistr_Event")
	

end




--============================= 보유아이템 목록 팝업창 시작 =============================
local SkillAttributeItemListWindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeItemList_BackImage")
SkillAttributeItemListWindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
SkillAttributeItemListWindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
SkillAttributeItemListWindow:setPosition(700, 170)
SkillAttributeItemListWindow:setSize(296, 438)
SkillAttributeItemListWindow:setAlwaysOnTop(true)
SkillAttributeItemListWindow:setVisible(true)
SkillAttributeItemListWindow:setZOrderingEnabled(false)
winMgr:getWindow("SkillAttributeAlphaImage"):addChildWindow(SkillAttributeItemListWindow)


-- 현재 페이지 / 최대 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeItemList_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188, 390)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
SkillAttributeItemListWindow:addChildWindow(mywindow)


-- 페이지 좌우 버튼
local tSkillAttributeItemList_BtnName  = {["err"]=0, [0]="SkillAttributeItemList_LBtn", "SkillAttributeItemList_RBtn"}
local tSkillAttributeItemList_BtnTexX  = {["err"]=0, [0]=987, 970}
local tSkillAttributeItemList_BtnPosX  = {["err"]=0, [0]=170, 270}
local tSkillAttributeItemList_BtnEvent = {["err"]=0, [0]="OnClickSkillAttributeItemList_PrevPage", "OnClickSkillAttributeItemList_NextPage"}
for i=0, #tSkillAttributeItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tSkillAttributeItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tSkillAttributeItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tSkillAttributeItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tSkillAttributeItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tSkillAttributeItemList_BtnTexX[i], 0)
	mywindow:setPosition(tSkillAttributeItemList_BtnPosX[i], 387)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tSkillAttributeItemList_BtnEvent[i])
	SkillAttributeItemListWindow:addChildWindow(mywindow)
end

-- 페이지 좌버튼 클릭이벤트
function OnClickSkillAttributeItemList_PrevPage()
	local check = AttributeItemListPrevButtonEvent()
	if check then
		local totalPage = GetAttributeItemListTotalPage()
		local currentPage = GetAttributeItemListCurrentPage()
		winMgr:getWindow("SkillAttributeItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end

-- 페이지 우버튼 클릭이벤트
function OnClickSkillAttributeItemList_NextPage()
	local check = AttributeItemListNextButtonEvent()
	if check then
		local totalPage = GetAttributeItemListTotalPage()
		local currentPage = GetAttributeItemListCurrentPage()
		winMgr:getWindow("SkillAttributeItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
	end
end


local tMoneyTypeName = {['err']=0, [0]="SkillAttributeItemList_Gran", "SkillAttributeItemList_Coin", "SkillAttributeItemList_Cash"}
local tMoneyTypeTexX = {['err']=0, [0]=	482, 503, 461}
local tMoneyTypePosY = {['err']=0, [0]=	366, 366 + 22, 366 + 44}

for i = 0, #tMoneyTypeName do
	-- 그랑 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMoneyTypeName[i].."Image")
	mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", tMoneyTypeTexX[i], 788)
	mywindow:setPosition(16, tMoneyTypePosY[i])
	mywindow:setSize(19, 19)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	SkillAttributeItemListWindow:addChildWindow(mywindow)

	-- 현재 나의 그랑
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyTypeName[i].."Text")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(44, tMoneyTypePosY[i])
	mywindow:setSize(120, 20)
	mywindow:setZOrderingEnabled(false)
	SkillAttributeItemListWindow:addChildWindow(mywindow)
end


-- 돈을 리프레시 해준다,
function refreshSkillAttributeItemListMoney(type, value)
	if type == 0 then --그랑
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("SkillAttributeItemList_GranText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("SkillAttributeItemList_GranText"):setText(CommatoMoneyStr(value))
	elseif type == 1 then --캐시
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("SkillAttributeItemList_CashText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("SkillAttributeItemList_CashText"):setText(CommatoMoneyStr(value))	
	elseif type == 2 then --코인
		local r, g, b	= ColorToMoney(value)
		winMgr:getWindow("SkillAttributeItemList_CoinText"):setTextColor(r, g, b, 255)		
		winMgr:getWindow("SkillAttributeItemList_CoinText"):setText(CommatoMoneyStr(value))			
	end
end


-- 아이템 리스트 제목(스킬, 기타)
local BagTabName  = {["err"]=0, [0]="SkillAttributeItemList_skill", "SkillAttributeItemList_etc"}
local BagTabTexX  = {["err"]=0, [0]= 70, 140}
local BagTabPosX  = {["err"]=0, [0]= 4, 76}

for i=0, #BagTabName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", BagTabName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", BagTabTexX[i], 455)
	mywindow:setTexture("Hover", "UIData/deal.tga", BagTabTexX[i], 476)
	mywindow:setTexture("Pushed", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("Disabled", "UIData/deal.tga", BagTabTexX[i], 455)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", BagTabTexX[i], 497)
	mywindow:setPosition(BagTabPosX[i], 39)
	mywindow:setProperty("GroupID", 2019)
	mywindow:setSize(70, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelect_SkillAttributeItemListTab")
	SkillAttributeItemListWindow:addChildWindow(mywindow)
end


-- 아이템 종류탭이 눌렸을때 이벤트
function OnSelect_SkillAttributeItemListTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		SetSkillAttributeItemListTab(tabindex, attributeCurrentMode)
	end
end


-- 아이템 리스트 판매목록
for i=0, MAX_ATTRIBUTEITEM_ITEMLIST-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "SkillAttributeItemList_"..i)
	mywindow:setTexture("Normal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Hover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Pushed", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("Disabled", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedHover", "UIData/deal.tga", 296, 583)
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga", 296, 583)
	mywindow:setPosition(7, i*60+70)
	mywindow:setProperty("GroupID", 209)
	mywindow:setSize(282, 52)
	mywindow:setZOrderingEnabled(false)
	SkillAttributeItemListWindow:addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(115)
	mywindow:setScaleHeight(115)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUseEventController(false)
--	mywindow:setEnabled(false)
	mywindow:setLayered(true)		-- 레이어 기능을 활성화(아이템 이미지 일때,)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeItemList_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillAttributeItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "MouseEnter_SkillAttributeItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "MouseLeave_SkillAttributeItemListInfo")
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeItemList_Name_"..i)
	mywindow:setTextColor(255,200,50,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 0)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)

	-- 아이템 가격
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeItemList_Price_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)


	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeItemList_Num_"..i)
	mywindow:setTextColor(180,180,180,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)

	-- 아이템 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "SkillAttributeItemList_RegistBtn_"..i)
	mywindow:setTexture("Normal", "UIData/deal2.tga", 594, 92)
	mywindow:setTexture("Hover", "UIData/deal2.tga", 594, 110)
	mywindow:setTexture("Pushed", "UIData/deal2.tga", 594, 128)
	mywindow:setTexture("PushedOff", "UIData/deal2.tga", 594, 128)
	mywindow:setTexture("Disabled", "UIData/deal2.tga", 594, 146)
	mywindow:setPosition(210, 30)
	mywindow:setSize(68, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("Clicked", "ClickedSkillAttributeItemListRegist")
	winMgr:getWindow("SkillAttributeItemList_"..i):addChildWindow(mywindow)


end



-- 아이템에 마우스 들어왔을떄.
function MouseEnter_SkillAttributeItemListInfo(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	local itemKind, itemnumber, slotIndex = GetSkillAttributeItemListToolTipInfo(index)
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
	GetToolTipBaseInfo(x + 50, y, 2, Kind, slotIndex, itemnumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)

end


-- 마우스 나갔을때.
function MouseLeave_SkillAttributeItemListInfo(args)
	SetShowToolTip(false)
end


-- 등록버튼이 클릭되었을때
function ClickedSkillAttributeItemListRegist(args)
	local eventwindow = CEGUI.toWindowEventArgs(args).window
	local buttonIndex = tonumber(eventwindow:getUserString("Index"))
	
	itemListItemClickEvent(buttonIndex)
	if attributeCurrentMode == CHARACTER_ATTRIBUTE then		-- 캐릭터 속성
		
	elseif attributeCurrentMode == SKILL_ATTRIBUTE then
		
	end
--	ContainerItemClickEvent(buttonIndex)
	-- 버튼이 클릭되면 tab에 따라 어떤 아이템이 등록되는지 선택해서 적용

end


-- 가방을 세팅한다.
function SettingSkillAttributeItemList(index, useCount, itemName, fileName, fileName2, itemgrade, Check)
	winMgr:getWindow("SkillAttributeItemList_"..index):setVisible(true)

	winMgr:getWindow("SkillAttributeItemList_Image_"..index):setTexture("Enabled", fileName, 0, 0)
	-- 아이템 이미지
	if fileName2 == "" then
		winMgr:getWindow("SkillAttributeItemList_Image_"..index):setLayered(false)
	else
		winMgr:getWindow("SkillAttributeItemList_Image_"..index):setLayered(true)
		winMgr:getWindow("SkillAttributeItemList_Image_"..index):setTexture("Layered", fileName2, 0, 0)
	end
		
	winMgr:getWindow("SkillAttributeItemList_Image_"..index):setScaleWidth(120)
	winMgr:getWindow("SkillAttributeItemList_Image_"..index):setScaleHeight(120)
	
	-- 아이템 이름
	winMgr:getWindow("SkillAttributeItemList_Name_"..index):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(useCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("SkillAttributeItemList_Num_"..index):setText(szCount)

	winMgr:getWindow("SkillAttributeItemList_Price_"..index):setText(period)
	
	if Check == 1 then
		winMgr:getWindow("SkillAttributeItemList_RegistBtn_"..index):setEnabled(true)
	else
		winMgr:getWindow("SkillAttributeItemList_RegistBtn_"..index):setEnabled(false)
	end
	
	-- 스킬 등급표시	
	if itemgrade > 0 then
		winMgr:getWindow("SkillAttributeItemList_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("SkillAttributeItemList_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemgrade], 486)
		winMgr:getWindow("SkillAttributeItemList_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[itemgrade][1], tGradeTextColorTable[itemgrade][2], tGradeTextColorTable[itemgrade][3], 255)
		winMgr:getWindow("SkillAttributeItemList_SkillLevelText_"..index):setText("+"..itemgrade)
	else
		winMgr:getWindow("SkillAttributeItemList_SkillLevelImage_"..index):setVisible(false)
		winMgr:getWindow("SkillAttributeItemList_SkillLevelText_"..index):setText("")
	end	
	
end


-- 페이지를 세팅해준다.
function SettingSkillAttributeItemListPageText(currentPage, totalPage)
	winMgr:getWindow("SkillAttributeItemList_PageText"):setTextExtends(currentPage.." / "..totalPage, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end

-- 백 리스트를 지워준다.
function ClearSkillAttributeItemListList()
	for i=0, MAX_ATTRIBUTEITEM_ITEMLIST-1 do
		winMgr:getWindow("SkillAttributeItemList_"..i):setVisible(false)
	end
end



function ShowSkillAttributeItemList(viewIndex)
	
	attributeCurrentMode = viewIndex	-- 현재 모드를 저장해 놓는다.
	
	if viewIndex == CHARACTER_ATTRIBUTE then
		winMgr:getWindow("SkillAttributeItemList_skill"):setVisible(false)
		winMgr:getWindow("SkillAttributeItemList_etc"):setPosition(4, 39)
		winMgr:getWindow("SkillAttributeItemList_etc"):setProperty("Selected", "true")
	else
		winMgr:getWindow("SkillAttributeItemList_skill"):setVisible(true)
		winMgr:getWindow("SkillAttributeItemList_etc"):setPosition(76, 39)
		winMgr:getWindow("SkillAttributeItemList_skill"):setProperty("Selected", "true")
	end
end


function HideSkillAttributeItemList()
	for i=0, #BagTabName do
		if CEGUI.toRadioButton(winMgr:getWindow(BagTabName[i])):isSelected() then
			winMgr:getWindow(BagTabName[i]):setProperty("Selected", "false")
		end	
	end
end




--============================= 보유아이템 목록 팝업창 끝 =============================






------------------------------------------------------------------------------------------------------------------------------------

-- 스킬 속성 윈도우를 보여준다.
function ShowSkillAttributeWindow()
	ClearSkillAttributeUi()
	ClearSkillAttributeValue()
	root:addChildWindow(winMgr:getWindow("SkillAttributeAlphaImage"))
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(true)
	if winMgr:getWindow("SkillAttributeAlphaImage"):isChild("CharacterAttributeMainImage") then
		winMgr:getWindow("SkillAttributeAlphaImage"):removeChildWindow(winMgr:getWindow("CharacterAttributeMainImage"))	-- 스킬속성부여 윈도우 제거
	end
	winMgr:getWindow("SkillAttributeAlphaImage"):addChildWindow(winMgr:getWindow("SkillAttributeMainImage"))	-- 케릭터 속성부여 윈도우 붙여준다.
	ShowSkillAttributeItemList(SKILL_ATTRIBUTE)	
end

-- 스킬 속성 윈도우를 닫는다.
function HideSkillAttributeWindow()
	VirtualImageSetVisible(false)
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(false)
	--AttributeAllClear()
	HideSkillAttributeItemList()
end


-- 스킬 속성취소 버튼 클릭 이벤트
function ClickSkillAttributeCancel()
	VirtualImageSetVisible(false)
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(false)
	--AttributeAllClear()
	HideSkillAttributeItemList()
	TownNpcEscBtnClickEvent()
end





--========================================= 캐릭터 속성 부여 시작=======================================

-- 캐릭터 속성 부여알파 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CharacterAttributeAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(g_MAIN_WIN_SIZEX, g_MAIN_WIN_SIZEY)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("CharacterAttributeAlphaImage", "HideCharacterAttributeWindow")

---------------------------------
-- 스킬에 속성부여 메인 이미지.
---------------------------------
local ChatacterAttributeMainWindow = winMgr:createWindow("TaharezLook/StaticImage", "CharacterAttributeMainImage")
ChatacterAttributeMainWindow:setTexture("Enabled", "UIData/skill_up.tga", 352, 0)
ChatacterAttributeMainWindow:setPosition(0,0)
ChatacterAttributeMainWindow:setSize(352, 700)
ChatacterAttributeMainWindow:setVisible(true)
ChatacterAttributeMainWindow:setAlwaysOnTop(true)
ChatacterAttributeMainWindow:setZOrderingEnabled(false)
winMgr:getWindow("SkillAttributeAlphaImage"):addChildWindow(ChatacterAttributeMainWindow)


-- 속성을 부여하는 아이템 등록한다.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "characterAttributeItemImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(126, 105)
mywindow:setSize(100, 100)
mywindow:setScaleWidth(153)
mywindow:setScaleHeight(153)
mywindow:setAlign(8)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("ItemImg", "itemRegistr_Event", "xscale", "Sine_EaseIn", 1000, 154, 3, true, false, 10)
mywindow:addController("ItemImg", "itemRegistr_Event", "yscale", "Sine_EaseIn", 1000, 154, 3, true, false, 10)
mywindow:addController("ItemImg", "itemRegistr_Event", "alpha", "Sine_EaseIn", 100, 255, 3, true, false, 10)
ChatacterAttributeMainWindow:addChildWindow(mywindow)

-- 속성부여할때 등록된 아이템 마우스 이벤트 위해
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "characterAttributeItemEventImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(146, 125)
mywindow:setSize(60, 60)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "MouseEnter_characterAttributeItemInfo")
mywindow:subscribeEvent("MouseLeave", "MouseLeave_characterAttributeItemInfo")
ChatacterAttributeMainWindow:addChildWindow(mywindow)


-- 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectAttributeItemImg")
mywindow:setTexture("Enabled", "UIData/skill_up.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 777, 158)
mywindow:setPosition(138, 384)
mywindow:setSize(73, 73)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
ChatacterAttributeMainWindow:addChildWindow(mywindow)

---------------------------------
-- 화살표 이미지.
---------------------------------
for i=0, #tTexX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CharacterArrow_"..i)
	mywindow:setTexture("Enabled", "UIData/skill_up.tga", tTexX[i], tTexY[i])
	mywindow:setTexture("Disabled", "UIData/skill_up.tga", tDisTexX[i], tDisTexY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setVisible(true)
--	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("tAttributeBtn", "tCharacterAttributeArrow_Event", "alpha", "Linear_EaseNone", 100, 255, 3, true, true, 10)
	mywindow:addController("tAttributeBtn", "tCharacterAttributeArrow_Event", "alpha", "Linear_EaseNone", 255, 100, 7, true, true, 10)
	ChatacterAttributeMainWindow:addChildWindow(mywindow)
end

--[[
---------------------------------
-- 스킬속성 선택 버튼(무, 빙, 불, 땅, 뢰)
---------------------------------
local tCharacterAttributeBtnName  = {["err"]=0, [0]="Character_ATTRIBUTE_ZERO_Btn", "Character_ATTRIBUTE_ICE_Btn", "Character_ATTRIBUTE_FIRE_Btn"
								, "Character_ATTRIBUTE_GROUND_Btn", "Character_ATTRIBUTE_LIGHTNING_Btn"}
local tTexY  = {["err"]=0, [0]= 922, 782, 852, 712, 642}
local tPosX  = {["err"]=0, [0]= 141,49,141,233,141}
local tPosY  = {["err"]=0, [0]= 387,387,479,387,295}

for i=0, #tCharacterAttributeBtnName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tCharacterAttributeBtnName[i])
	mywindow:setTexture("Normal", "UIData/skill_up.tga", 210, tTexY[i])
	mywindow:setTexture("Hover", "UIData/skill_up.tga", 70, tTexY[i])
	mywindow:setTexture("Pushed", "UIData/skill_up.tga", 70, tTexY[i])
	mywindow:setTexture("Disabled", "UIData/skill_up.tga", 210, tTexY[i])
	mywindow:setTexture("SelectedNormal", "UIData/skill_up.tga", 140, tTexY[i])
	mywindow:setTexture("SelectedHover", "UIData/skill_up.tga", 140, tTexY[i])
	mywindow:setTexture("SelectedPushed", "UIData/skill_up.tga", 140, tTexY[i])
	mywindow:setPosition(tPosX[i], tPosY[i] - 197)
	mywindow:setProperty("GroupID", 2200)
	mywindow:setSize(70, 70)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:addController("tAttributeBtn", "tCharacterAttributeBtn_Event", "alpha", "Linear_EaseNone", 100, 255, 5, true, true, 10)
	mywindow:addController("tAttributeBtn", "tCharacterAttributeBtn_Event", "alpha", "Linear_EaseNone", 255, 100, 10, true, true, 10)
	mywindow:setSubscribeEvent("SelectStateChanged", "CharacterAttributeSelectBtnClick")--tMyInvenListEvent[i])
	ChatacterAttributeMainWindow:addChildWindow(mywindow)
end
--]]

for i=0, #ttCharacterAttributeTexX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CharacterAttributeImg_"..i)
	mywindow:setTexture("Enabled", "UIData/skill_up.tga", ttCharacterAttributeTexX[i], 38)
	mywindow:setTexture("Disabled", "UIData/skill_up.tga", ttCharacterAttributeTexX[i], 38)
	mywindow:setPosition(ttCharacterAttributePosX[i], ttCharacterAttributePosY[i])
	mywindow:setSize(73, 34)
	mywindow:setVisible(true)
	mywindow:setAlign(8)
	--mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	mywindow:addController("CharacterAttributeImg", "tCharacterAttributeImage_Event", "xscale", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	mywindow:addController("CharacterAttributeImg", "tCharacterAttributeImage_Event", "yscale", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	mywindow:addController("CharacterAttributeImg", "tCharacterAttributeImage_Event", "alpha", "Linear_EaseNone", 100, 255, 5, true, false, 10)
	ChatacterAttributeMainWindow:addChildWindow(mywindow)
end


-- 캐릭터 속성 적용버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "CharacterAttributeApplyBtn")
mywindow:setTexture("Normal", "UIData/skill_up.tga", 704, 231)
mywindow:setTexture("Hover", "UIData/skill_up.tga", 704, 260)
mywindow:setTexture("Pushed", "UIData/skill_up.tga", 704, 289)
mywindow:setTexture("PushedOff", "UIData/skill_up.tga", 704, 289)
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 704, 318)
mywindow:setPosition(66, 662)
mywindow:setSize(100, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickCharacterAttributeApply")
ChatacterAttributeMainWindow:addChildWindow(mywindow)


-- 캐릭터 속성 취소버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "CharacterAttributeCancelBtn")
mywindow:setTexture("Normal", "UIData/skill_up.tga", 804, 231)
mywindow:setTexture("Hover", "UIData/skill_up.tga", 804, 260)
mywindow:setTexture("Pushed", "UIData/skill_up.tga", 804, 289)
mywindow:setTexture("PushedOff", "UIData/skill_up.tga", 804, 289)
mywindow:setTexture("Disabled", "UIData/skill_up.tga", 804, 318)
mywindow:setPosition(186, 662)
mywindow:setSize(100, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickCharacterAttributeCancel")
ChatacterAttributeMainWindow:addChildWindow(mywindow)



-- 캐릭터 속성 적용버튼 이벤트
function ClickCharacterAttributeApply(args)
	-- 레벨이 20렙이 이상이어야 한다.
	ShowAttributeConfirmPopup(0)
end


-- 속성부여 완료시 들어온다.
function ShowCharacterAttributeResult(attributeIndex, promotion, style, string)
	--tAttributeMain
	local index = 0
	if attributeIndex > 0 then
		index = attributeIndex - 1
	end
	
	root:addChildWindow(winMgr:getWindow('CharacterAttributeResultAlpha'))
	winMgr:getWindow('CharacterAttributeResultAlpha'):setVisible(true)
	winMgr:getWindow("CharacterAttributeResultClassImg"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attributeIndex], tAttributeImgTexYTable[style][attributeIndex])
	winMgr:getWindow("CharacterAttributeResultClassImg"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	--winMgr:getWindow("CharacterAttributeResultText"):setTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,  2, 0,0,0,255);
	winMgr:getWindow("CharacterAttributeResultIconImg"):setTexture('Disabled', 'UIData/skill_up.tga', tAttributeMain[index], 85)
	
end



-- 캐릭터에 부여하는 속성에 따라 틀려지는 이벤트
function SelectCharacterAttributeIndex(attributeIndex)
	local tBuf = tAttributeTexXTable[attributeIndex]
	for i=0, #tBuf do
		winMgr:getWindow("CharacterAttributeImg_"..i):setTexture("Enabled", "UIData/skill_up.tga", tBuf[i], 38)
		winMgr:getWindow("CharacterAttributeImg_"..i):setTexture("Disabled", "UIData/skill_up.tga", tBuf[i], 38)
		winMgr:getWindow("CharacterAttributeImg_"..i):activeMotion("tCharacterAttributeImage_Event")
		winMgr:getWindow("CharacterArrow_"..i):activeMotion("tCharacterAttributeArrow_Event")
		
	end
	winMgr:getWindow("SelectAttributeItemImg"):setTexture("Disabled", "UIData/skill_up.tga", tAttributeMain[attributeIndex], 85)
	
end


function SetCharacterAttributeItemImg(path)
	winMgr:getWindow("characterAttributeItemImg"):setTexture("Enabled", path, 0, 0)
	winMgr:getWindow("characterAttributeItemImg"):setTexture("Disabled", path, 0, 0)
	winMgr:getWindow("characterAttributeItemImg"):activeMotion("itemRegistr_Event")
end


-- 속성을 부여할 재료에 마우스 오버했을때 이벤트
function MouseEnter_characterAttributeItemInfo(args)

end


-- 속성을 부여할 재료에 마우스 나갔을때 이벤트
function MouseLeave_characterAttributeItemInfo(args)

end



--[[

function CharacterAttributeSelectBtnClick(args)
	local currentWindow = CEGUI.toWindowEventArgs(args).window
	local Index = tonumber(currentWindow:getUserString("Index"))
	local bEnable = false
	
	if CEGUI.toRadioButton(currentWindow):isSelected() then
		bEnable = true
		winMgr:getWindow(tCharacterAttributeBtnName[Index]):activeMotion("tCharacterAttributeBtn_Event")
		winMgr:getWindow(tCharacterArrowName[Index]):activeMotion("tCharacterAttributeArrow_Event")
		if Index == 0 then
			winMgr:getWindow(tCharacterArrowName[5]):activeMotion("tCharacterAttributeArrow_Event")
			winMgr:getWindow(tCharacterArrowName[6]):activeMotion("tCharacterAttributeArrow_Event")
			winMgr:getWindow(tCharacterArrowName[7]):activeMotion("tCharacterAttributeArrow_Event")
		end
		
		winMgr:getWindow(tCharacterAttributeImgName[Index]):setVisible(true)	-- 속성 글자이미지.
		
		SelectCharacterAttributeIndex(Index + 1)	-- +1은 0은 아무것도 선택하지 않은 인덱스이기 때문에,!
	else
		bEnable = false
		winMgr:getWindow(tCharacterAttributeBtnName[Index]):clearActiveController()
		winMgr:getWindow(tCharacterArrowName[Index]):clearActiveController()
		if Index == 0 then
			winMgr:getWindow(tCharacterArrowName[5]):clearActiveController()
			winMgr:getWindow(tCharacterArrowName[6]):clearActiveController()
			winMgr:getWindow(tCharacterArrowName[7]):clearActiveController()
		end
		winMgr:getWindow(tCharacterAttributeImgName[Index]):setVisible(false)	-- 속성 글자이미지.
	end
	winMgr:getWindow(tCharacterArrowName[Index]):setEnabled(bEnable)
	if Index == 0 then
		winMgr:getWindow(tCharacterArrowName[5]):setEnabled(bEnable)
		winMgr:getWindow(tCharacterArrowName[6]):setEnabled(bEnable)
		winMgr:getWindow(tCharacterArrowName[7]):setEnabled(bEnable)
	end
	-- 현재 선택된 인덱스를 c로 넘겨준다.(이 인덱스가 속성의 인덱스가 된다.)
	

end


--]]
-- 캐릭터 속성부여의 내부적인 값을 초기화해준다.
function ClearCharacterAttributeValue()
	ClearCharacterAttribute()	-- 초기화(default)	
end


function ClearCharacterAttributeUi()
	winMgr:getWindow("characterAttributeItemImg"):clearActiveController()
	winMgr:getWindow("characterAttributeItemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("characterAttributeItemImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("SelectAttributeItemImg"):setTexture("Disabled", "UIData/skill_up.tga", 777, 158)

	for i=0, 3 do
		winMgr:getWindow("CharacterAttributeImg_"..i):setTexture("Enabled", "UIData/invisible.tga", 0, 38)
		winMgr:getWindow("CharacterAttributeImg_"..i):setTexture("Disabled", "UIData/invisible.tga", 0, 38)
		winMgr:getWindow("CharacterArrow_"..i):clearActiveController()
	end
--[[
	for i=0, #tCharacterArrowName do
		winMgr:getWindow(tCharacterArrowName[i]):clearActiveController()
		winMgr:getWindow(tCharacterArrowName[i]):setEnabled(false)
	end
	for i=0, #tCharacterAttributeBtnName do
		-- 버튼이 선택된 상태면 해제한다.(해제를 하게되면 자동으로 컨트롤러가 클리어된다.)
		if CEGUI.toRadioButton(winMgr:getWindow(tCharacterAttributeBtnName[i])):isSelected() then
			winMgr:getWindow(tCharacterAttributeBtnName[i]):setProperty("Selected", "false")
		end
	end
	for i=0, #tCharacterAttributeImgName do
		winMgr:getWindow(tCharacterAttributeImgName[i]):setVisible(false)	-- 속성 글자이미지.
	end
--]]
end



-- 캐릭터 속성윈도우를 보여준다.
function ShowCharacterAttributeWindow()
	root:addChildWindow(winMgr:getWindow("SkillAttributeAlphaImage"))
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(true)
	if winMgr:getWindow("SkillAttributeAlphaImage"):isChild("SkillAttributeMainImage") then
		winMgr:getWindow("SkillAttributeAlphaImage"):removeChildWindow(winMgr:getWindow("SkillAttributeMainImage"))	-- 스킬속성부여 윈도우 제거
	end	
	winMgr:getWindow("SkillAttributeAlphaImage"):addChildWindow(winMgr:getWindow("CharacterAttributeMainImage"))	-- 케릭터 속성부여 윈도우 붙여준다.
	ShowSkillAttributeItemList(CHARACTER_ATTRIBUTE)
	ClearCharacterAttributeUi()		-- ui초기화
	ClearCharacterAttributeValue()	-- 값 초기화
end



-- 캐릭터 속성 윈도우를 숨긴다.
function HideCharacterAttributeWindow()
	VirtualImageSetVisible(false)
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(false)
	HideSkillAttributeItemList()
end


-- 버튼 클릭으로 속성창은 없앨때.
function ClickCharacterAttributeCancel()
	VirtualImageSetVisible(false)
	winMgr:getWindow("SkillAttributeAlphaImage"):setVisible(false)
	HideSkillAttributeItemList()
	TownNpcEscBtnClickEvent()	
end




--=======================================캐릭터 속성 부여 끝=======================================


-- 캐릭터 속성부여후 들어오는 팝업창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CharacterAttributeResultAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0)
mywindow:setSize(1024, 768);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);

RegistEscEventInfo("CharacterAttributeResultAlpha", "CharacterAttributeResultButtonEvent")
RegistEnterEventInfo("CharacterAttributeResultAlpha", "CharacterAttributeResultButtonEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CharacterAttributeResultMainImg');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CharacterAttributeResultAlpha'):addChildWindow(mywindow)

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CharacterAttributeResultBackImg');
mywindow:setTexture('Enabled', 'UIData/skill_up.tga', 327, 700);
mywindow:setTexture('Disabled', 'UIData/skill_up.tga', 327, 700);
mywindow:setPosition(6, 41)
mywindow:setSize(327, 193);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CharacterAttributeResultMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CharacterAttributeResultClassImg');
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Layered', 'UIData/invisible.tga', 0, 0)
mywindow:setPosition(85, 85)
mywindow:setSize(89, 35)
mywindow:setScaleWidth(500)
mywindow:setScaleHeight(500)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CharacterAttributeResultMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CharacterAttributeResultIconImg');
mywindow:setTexture('Disabled', 'UIData/skill_up.tga', 704, 85)
mywindow:setPosition(200, 170)
mywindow:setSize(73, 73)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('CharacterAttributeResultMainImg'):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/Button", "CharacterAttributeResultButton")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CharacterAttributeResultButtonEvent")
winMgr:getWindow('CharacterAttributeResultMainImg'):addChildWindow(mywindow)

function CharacterAttributeResultButtonEvent(args)
	winMgr:getWindow('CharacterAttributeResultAlpha'):setVisible(false)
end






--=================================================
-- 스킬 속성부여후 들어오는 팝업창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'SkillAttributeResultAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0)
mywindow:setSize(1024, 768);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);

RegistEscEventInfo("SkillAttributeResultAlpha", "SkillAttributeResultButtonEvent")
RegistEnterEventInfo("SkillAttributeResultAlpha", "SkillAttributeResultButtonEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'SkillAttributeResultMainImg');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultAlpha'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'SkillAttributeResultBackImg');
mywindow:setTexture('Enabled', 'UIData/skill_up.tga', 0, 700);
mywindow:setTexture('Disabled', 'UIData/skill_up.tga', 0, 700);
mywindow:setPosition(6, 41)
mywindow:setSize(327, 193);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'SkillAttributeResultFileImg');
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Layered', 'UIData/invisible.tga', 0, 0)
mywindow:setPosition(13, 86)
mywindow:setSize(100, 100)
mywindow:setLayered(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'SkillAttributeResultClassImg');
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
mywindow:setTexture('Layered', 'UIData/invisible.tga', 0, 0)
mywindow:setPosition(133, 94)
mywindow:setSize(89, 35)
mywindow:setScaleWidth(500)
mywindow:setScaleHeight(500)
mywindow:setEnabled(false)
mywindow:setLayered(true)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeResultSkillNameText");
--mywindow:setTexture('Disabled', 'UIData/nm1.tga', 0, 0)
--mywindow:setTextColor(255,255,255,255)
--mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setPosition(14, 56)
mywindow:setSize(310, 20)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)

--[[
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillAttributeResultText");
mywindow:setPosition(3, 198)
mywindow:setSize(340, 180)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)
--]]

mywindow = winMgr:createWindow("TaharezLook/Button", "SkillAttributeResultButton")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "SkillAttributeResultButtonEvent")
winMgr:getWindow('SkillAttributeResultMainImg'):addChildWindow(mywindow)


function SkillAttributeResultButtonEvent(args)
	winMgr:getWindow('SkillAttributeResultAlpha'):setVisible(false)
end



function ShowSkillAttributeResult(attributeIndex, promotion, style, string, filePath, skillName)
	root:addChildWindow(winMgr:getWindow('SkillAttributeResultAlpha'))
	winMgr:getWindow('SkillAttributeResultAlpha'):setVisible(true)
	winMgr:getWindow("SkillAttributeResultClassImg"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attributeIndex], tAttributeImgTexYTable[style][attributeIndex])
	winMgr:getWindow("SkillAttributeResultClassImg"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	--winMgr:getWindow("SkillAttributeResultText"):setTextExtends(string, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,  2, 0,0,0,255);
	winMgr:getWindow("SkillAttributeResultSkillNameText"):setTextExtends(skillName, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,  2, 0,0,0,255);
	
	winMgr:getWindow("SkillAttributeResultFileImg"):setTexture("Enabled", "UIData/invisible.tga", 0,0)
	winMgr:getWindow("SkillAttributeResultFileImg"):setTexture("Layered", filePath, 0,0)
		
end





----========================================
-- 속성 부여전 물어보는 창
local AttributeConfirmIndex = -1

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'AttributeConfirmAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1024, 768);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("AttributeConfirmAlpha", "AttributeConfirmCancelEvent")
RegistEnterEventInfo("AttributeConfirmAlpha", "AttributeConfirmOkEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'AttributeConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('AttributeConfirmAlpha'):addChildWindow(mywindow);

mywindow = winMgr:createWindow("TaharezLook/StaticText", "AttributeConfirmText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2739, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
winMgr:getWindow('AttributeConfirmImage'):addChildWindow(mywindow);

-- ok버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "AttributeConfirmOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "AttributeConfirmOkEvent")
winMgr:getWindow('AttributeConfirmImage'):addChildWindow(mywindow)

-- cancel 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "AttributeConfirmCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "AttributeConfirmCancelEvent")
winMgr:getWindow('AttributeConfirmImage'):addChildWindow(mywindow)


-- ok버튼 이벤트
function AttributeConfirmOkEvent(args)
	winMgr:getWindow("AttributeConfirmAlpha"):setVisible(false)
	if AttributeConfirmIndex ~= -1 then
		AttributeApplyEvent(AttributeConfirmIndex)
		AttributeConfirmIndex = -1
	end
end


-- 삭제 cancel버튼 이벤트
function AttributeConfirmCancelEvent(args)
	winMgr:getWindow("AttributeConfirmAlpha"):setVisible(false)
	
end


function ShowAttributeConfirmPopup(index)
	root:addChildWindow(winMgr:getWindow("AttributeConfirmAlpha"))
	winMgr:getWindow("AttributeConfirmAlpha"):setVisible(true)
	AttributeConfirmIndex = index
end