-------------------------------------------------------------
-- 내 창고 lua 세팅
-------------------------------------------------------------
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)



-- 클론 아바타의 상태를 정하는 변수
local COSTUME_NORMAL	= 0
local COSTUME_NO_VISUAL	= -1
local COSTUME_SEAL		= -2

--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------


--------------------------------------------------------------------
-- 변수들 설정
--------------------------------------------------------------------
local MAX_STORAGE_ITEM_X_COUNT = GetMyStorageOnePageMaxItemCount(0)		-- 한페이지에 들어가는 아이템의 최대갯수를 받아온다.
local MAX_STORAGE_ITEM_Y_COUNT = GetMyStorageOnePageMaxItemCount(1)		-- 한페이지에 들어가는 아이템의 최대갯수를 받아온다.
local Item_first_PointX = 40
local Item_first_PointY = 106
local Item_X_term = 61
local Item_Y_term = 61


-------------------------------------------------------------
-- 내 창고
-------------------------------------------------------------
-------------------------------------------------------------
MyStorageWindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_BackImage")
MyStorageWindow:setTexture("Enabled", "UIData/Match002.tga", 715, 532)
MyStorageWindow:setTexture("Disabled", "UIData/Match002.tga", 715, 532)
MyStorageWindow:setWideType(6);
MyStorageWindow:setPosition(50, (g_MAIN_WIN_SIZEY-500)/2)
MyStorageWindow:setSize(309, 437)
MyStorageWindow:setAlwaysOnTop(true)
MyStorageWindow:setVisible(false)
MyStorageWindow:setZOrderingEnabled(true)
root:addChildWindow(MyStorageWindow)


RegistEscEventInfo("MyStorage_BackImage", "HideMyStorage")


--------------------------------------------------------------------
-- 내 창고 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyStorage_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(279, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideButtonMyStorage")
MyStorageWindow:addChildWindow(mywindow)



-- 아이템 리스트 제목(코스츔, 스킬, 기타, 강화)
tMyStorageListName  = {["err"]=0, [0]="MyStorage_costume", "MyStorage_skill", "MyStorage_etc", "MyStorage_special", "MyStorage_cashTab"}
tMyStorageListTexX  = {["err"]=0, [0]=41, 97, 153, 209, 265}
tMyStorageListPosX  = {["err"]=0, [0]=12, 12 + 56, 12 + 56*2, 12 + 56*3, 12 + 56*4}

for i=0, #tMyStorageListName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyStorageListName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyStorageListTexX[i], 577)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyStorageListTexX[i], 600)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyStorageListTexX[i], 577)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyStorageListTexX[i], 623)
	mywindow:setPosition(tMyStorageListPosX[i], 43)
	mywindow:setProperty("GroupID", 2111)
	mywindow:setSize(56, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyStorageSelectTab")
	if i == 0 then
		mywindow:setProperty("Selected", "true")
	end
	MyStorageWindow:addChildWindow(mywindow)
end


local aaass = 49
-- 가방의 인덱스(최대 5개)
tMyStorageBagName  = {["err"]=0, [0]="MyStorage_Bag1", "MyStorage_Bag2", "MyStorage_Bag3", "MyStorage_Bag4", "MyStorage_Bag5"}
tMyStorageBagTexX  = {["err"]=0, [0]=	377, 426, 475, 524, 573}
tMyStorageBagPosX  = {["err"]=0, [0]=	31, 31 + aaass, 31 + aaass*2, 31 + aaass*3, 31 + aaass*4}

for i=0, #tMyStorageBagName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyStorageBagName[i])
	mywindow:setTexture("Normal", "UIData/Match002.tga", tMyStorageBagTexX[i], 646)
	mywindow:setTexture("Hover", "UIData/Match002.tga", tMyStorageBagTexX[i], 670)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("Disabled", "UIData/Match002.tga", tMyStorageBagTexX[i], 718)
	mywindow:setTexture("SelectedNormal", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", tMyStorageBagTexX[i], 694)
	mywindow:setPosition(tMyStorageBagPosX[i], 72)
	mywindow:setProperty("GroupID", 2112)
	mywindow:setSize(49, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i + 1)
	mywindow:setSubscribeEvent("SelectStateChanged", "MyStorageSelectBag")
	MyStorageWindow:addChildWindow(mywindow)
end



function MyStorageSelectBag(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local ClickWindow = CEGUI.toWindowEventArgs(args).window
		local index = tonumber(ClickWindow:getUserString("Index"))
		local check = StoragePageButtonEvent(index)
		
		if check then			
			RefreshStorageUiView(index)
		end
	end	
end


-- 아이템 리스트 판매목록
for i=0, MAX_STORAGE_ITEM_Y_COUNT-1 do
	for j=0, MAX_STORAGE_ITEM_X_COUNT-1 do
		local Index = i*MAX_STORAGE_ITEM_X_COUNT+j

		-- 아이템 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Image_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)
		mywindow:setScaleHeight(118)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		-- 아이템 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Image_Seal_"..Index)
		mywindow:setTexture("Enabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/ItemUIData/Skill_Lock.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)
		mywindow:setScaleHeight(118)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		
		-- 아이템의 아이콘(Pure OR SelectedVisual) 이미지 ★
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Avatar_Icon_Type_"..Index)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY + Item_Y_term*i)
		mywindow:setSize(100, 100)
		mywindow:setScaleWidth(118)--118)
		mywindow:setScaleHeight(118)--118)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		
		
		-- 스킬 레벨 테두리 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_SkillLevelImage_"..Index)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 16, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)

		-- 스킬레벨 + 글자
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyStorage_ItemList_SkillLevelText_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(Item_first_PointX + Item_X_term*j + 21, Item_first_PointY + Item_Y_term*i + 1)
		mywindow:setSize(40, 20)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		

		-- 아이템의 빨간 이미지
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyStorage_ItemList_Warning_"..Index)
		mywindow:setTexture("Disabled", "UIData/Match002.tga", 667, 646)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		MyStorageWindow:addChildWindow(mywindow)
		
		
		-- 아이템의 버튼(아이템 자체적인 버튼)
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "MyStorage_ItemList_Button_"..Index)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/Match002.tga", 667, 694)
		mywindow:setTexture("Pushed", "UIData/Match002.tga", 667, 742)
		mywindow:setTexture("PushedOff", "UIData/Match002.tga", 667, 26)
		mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("SelectedHover", "UIData/Match002.tga", 667, 694)
		mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", 667, 742)
		mywindow:setTexture("SelectedPushedOff", "UIData/Match002.tga", 667, 742)
		mywindow:setPosition(Item_first_PointX-1 + Item_X_term*j, Item_first_PointY-1 + Item_Y_term*i)
		mywindow:setSize(48, 48)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", tostring(-1))
		mywindow:subscribeEvent("MouseDoubleClicked", "MyStorage_ItemdoubleClick")
		mywindow:subscribeEvent("MouseEnter", "MyStorage_ItemMouseEnter")
		mywindow:subscribeEvent("MouseLeave", "MyStorage_ItemMouseLeave")
		MyStorageWindow:addChildWindow(mywindow)
		
		-- 랜덤 아이템 정보
		mywindow = winMgr:createWindow("TaharezLook/Button", "MyStorage_DetailIInfoBtn_"..Index)
		mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
		mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
		mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
		mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
		mywindow:setPosition(30, 30)
		mywindow:setSize(20, 20)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setSubscribeEvent("Clicked", "MyStorage_ShowRandomOpenItem")
		winMgr:getWindow("MyStorage_ItemList_Button_"..Index):addChildWindow(mywindow)
		
		
		-- 아이템 갯수 카운트
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyStorage_ItemList_Count_"..Index)
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(2, 2)
		mywindow:setSize(45, 20)
		mywindow:setAlign(6)
		mywindow:setLineSpacing(2)
		mywindow:setViewTextMode(1)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("MyStorage_ItemList_Button_"..Index):addChildWindow(mywindow)

	end
end


function MyStorage_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우
	local index = tonumber(mywindow:getUserString('Index'))
	local x, y = GetBasicRootPoint(local_window)
	y = y - 80
	if x + 245 > g_CURRENT_WIN_SIZEX then
		x = x - 245
	end
	if y + 175 > g_CURRENT_WIN_SIZEY then
		y = y - 175
	end
	local itemKind, itemNumber = GetMyStorageTooltipInfo(index)	
	ShowRandomOpenItem(itemNumber, x, y)

end


-- 인벤토리 아이템 더블클릭 이벤트
function MyStorage_ItemdoubleClick(args)
	-- 아이템 사용
	local ClickWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(ClickWindow:getUserString("Index"))
	
	SettingStorageInputCountWindow(index)
end



-- 아이템에 마우스가 들어올때,
function MyStorage_ItemMouseEnter(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	if index == -1 then
		return
	end
	local itemKind, itemNumber = GetMyStorageTooltipInfo(index)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
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
	
	if x + 283 > g_MAIN_WIN_SIZEX then
		x = x - 283
	end
	
	GetToolTipBaseInfo(x + 47, y, 2, Kind, index, itemNumber , 1)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
	
end


-- 아이템에서 마우스가 나갈때.
function MyStorage_ItemMouseLeave(args)
	SetShowToolTip(false)

end


-- 인벤토리의 탭이 선택됐을때 들어오는 이벤트
function MyStorageSelectTab(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local currentWindow = CEGUI.toWindowEventArgs(args).window
		local tabindex = currentWindow:getUserString("TabIndex")
		
		SetStorageTab(tabindex)	-- 인벤토리 탭 세팅
		local CurrentMaxPage = GetStorageCurrentMaxPage(tabindex)
		SettingStorageMaxPageButton(CurrentMaxPage)
		
		if GetStorageCurrentPage() == 1 then
			local check = StoragePageButtonEvent(1)

			if check then
				RefreshStorageUiView(1)
			end
		end		
		winMgr:getWindow("MyStorage_Bag1"):setProperty("Selected", "true")
	end
end


-- 현재 탭에 따른 정해진 최대 페이지에 따라 버튼 세팅
function SettingMaxPageByStorageTab(tabIndex)
	for i=0, #tMyStorageBagName do
		if i < tabIndex then
			winMgr:getWindow(tMyStorageBagName[i]):setVisible(true)
		else
			winMgr:getWindow(tMyStorageBagName[i]):setVisible(false)
		end		
	end
end





-- 인벤토리를 비워준다(초기화)
function ClearMyStorage()
	for i=0, MAX_STORAGE_ITEM_X_COUNT-1 do
		for j=0, MAX_STORAGE_ITEM_Y_COUNT-1 do
			local Index = i*(MAX_STORAGE_ITEM_X_COUNT+1)+j
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setLayered(false)
			winMgr:getWindow("MyStorage_ItemList_Image_Seal_"..Index):setVisible(false)					
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Image_"..Index):setTexture("Layered", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_Avatar_Icon_Type_"..Index):setVisible(false)
			
			-- 스킬 레벨 이미지 
			winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..Index):setVisible(false)
			winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..Index):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..Index):setText("")
			
			winMgr:getWindow("MyStorage_ItemList_Button_"..Index):setUserString("Index", tostring(-1))
			winMgr:getWindow("MyStorage_ItemList_Count_"..Index):clearTextExtends()

			winMgr:getWindow("MyStorage_ItemList_Warning_"..Index):setVisible(false)
			winMgr:getWindow("MyStorage_ItemList_Warning_"..Index):setTexture("Disabled", "UIData/Match002.tga", 667, 646)
			winMgr:getWindow("MyStorage_DetailIInfoBtn_"..Index):setVisible(false)
		end
	end
end



-- 인벤토리를 채워준다.
-- 일반, 만료, 사용못함, 변신 아이템
local tStatefile = {['err'] = 0, [0]="invisible.tga", "Match002.tga", "Match002.tga", "Match002.tga", "Match002.tga"}
local tStateY = {['err'] = 0,	[0]= 0,					646,			646,		790,				838}

function SettingMyStorage(posIndex, slotIndex, itemNumber, fileName, fileName2, itemcount, state, grade, bSeal , nCloneAvatarType , bTrade , attach)
	winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Enabled", "UIData/"..fileName, 0, 0)
	winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Disabled", "UIData/"..fileName, 0, 0)
	
	if grade > 0 then
		winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..posIndex):setVisible(true)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelImage_"..posIndex):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..posIndex):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("MyStorage_ItemList_SkillLevelText_"..posIndex):setText("+"..grade)
	end	
	
	if fileName2 == "" then
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setLayered(false)
	else
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setLayered(true)
		winMgr:getWindow("MyStorage_ItemList_Image_"..posIndex):setTexture("Layered", "UIData/"..fileName2, 0, 0)		
	end
	winMgr:getWindow("MyStorage_ItemList_Image_Seal_"..posIndex):setVisible(bSeal)
	
	winMgr:getWindow("MyStorage_ItemList_Button_"..posIndex):setUserString("Index", tostring(slotIndex))
	winMgr:getWindow("MyStorage_ItemList_Count_"..posIndex):clearTextExtends()
	winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setVisible(true)
	winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[state], 667, tStateY[state])
	
	
	-- 스킬 강화 1이상 , 거래가능한 상태의 아이템 잠금표시★
	if grade >= GetSealedSkillGrade() then
		if bTrade == true then
			winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setVisible(true)
			winMgr:getWindow("MyStorage_ItemList_Warning_"..posIndex):setTexture("Disabled", "UIData/"..tStatefile[3], 667, tStateY[3])
			DebugStr("트레이드 트루")
			--winMgr:getWindow("MyInven_ItemList_Warning_"..posIndex):setTexture("Layered", "UIData/ItemUIData/Insert/Seal.tga", 0, 0)
		end
	end
			
	if itemcount > 1 then
		winMgr:getWindow("MyStorage_ItemList_Count_"..posIndex):addTextExtends("x "..itemcount, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,    0, 0,0,0,255)
	end
	if CheckDetailInfoBtn(itemNumber) then
		winMgr:getWindow("MyStorage_DetailIInfoBtn_"..posIndex):setVisible(true)
	else
		winMgr:getWindow("MyStorage_DetailIInfoBtn_"..posIndex):setVisible(false)
	end	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS(	"MyStorage_ItemList_Image_" , "MyStorage_ItemList_Warning_" ,  "MyStorage_ItemList_Avatar_Icon_Type_" , 
					posIndex , nCloneAvatarType , attach )
end


function SettingStorageMaxPageButton(MaxPage)
	for i=0, #tMyStorageBagName do
		if i < MaxPage then
			winMgr:getWindow(tMyStorageBagName[i]):setEnabled(true)
		else
			winMgr:getWindow(tMyStorageBagName[i]):setEnabled(false)
		end		
	end
end


function SettingStorageMaxPageRefresh()
	local TabIndex = GetStorageTab()
	local CurrentMaxPage = GetStorageCurrentMaxPage(TabIndex)
	SettingStorageMaxPageButton(CurrentMaxPage)
end


function ChangeMyStorageTabEvent(tabIndex)
	local changeWindow = winMgr:getWindow(tMyStorageListName[tabIndex])
	if CEGUI.toRadioButton(changeWindow):isSelected() then
		return	
	end
	changeWindow:setProperty("Selected", "true")
end


-- 창고를 보여준다
function ShowMyStorage()
	-- 창고 --
	SetStorageTab(0)
	local CurrentMaxPage = GetStorageCurrentMaxPage(0)
	SettingStorageMaxPageButton(CurrentMaxPage)
	winMgr:getWindow("MyStorage_costume"):setProperty("Selected", "true")
	winMgr:getWindow("MyStorage_Bag1"):setProperty("Selected", "true")
	
	root:addChildWindow(winMgr:getWindow("MyStorage_BackImage"))
	winMgr:getWindow("MyStorage_BackImage"):setVisible(true)
	SetIsvisibleStorage(true)
		
	ShowMyInventory(true, true)
end



-- 인벤토리를 숨긴다.
function HideMyStorage()
	HideMyInventory()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyStorage_BackImage"):setVisible(false)
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)	
	SetIsvisibleStorage(false)	
end


-- 인벤토리를 숨긴다.
function HideButtonMyStorage()
	HideMyInventory()
	VirtualImageSetVisible(false)
	winMgr:getWindow("MyStorage_BackImage"):setVisible(false)
	winMgr:getWindow("StorageInput_BackImage"):setVisible(false)
	SetIsvisibleStorage(false)
	TownNpcEscBtnClickEvent()	
end
