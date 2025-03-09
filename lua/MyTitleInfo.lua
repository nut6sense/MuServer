--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------


--------------------------------------------------------------------
-- 전역으로 사용할 변수들
--------------------------------------------------------------------


--------------------------------------------------------------------
-- 칭호탭 선택시 보여주는 이미지.
--------------------------------------------------------------------
MyTitleMain = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleBackImg")
MyTitleMain:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
MyTitleMain:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
MyTitleMain:setPosition(7, 80)
MyTitleMain:setSize(489, 365)
MyTitleMain:setVisible(false)
MyTitleMain:setAlwaysOnTop(false)
MyTitleMain:setZOrderingEnabled(true)
UserInfoMain:addChildWindow(MyTitleMain)

--------------------------------------------------------------------
-- 칭호리스트 보여줄 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleLine")
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 0, 1023)
mywindow:setPosition(0, 362)
mywindow:setSize(489, 1)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
MyTitleMain:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호리스트 보여줄 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleListBackImg")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 504, 133)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 504, 133)
mywindow:setPosition(8, 10)
mywindow:setSize(220, 307)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Userinfo_TitleBackImg"):addChildWindow(mywindow)


local	MaxTitleCount	= 10
local	First_PosY		= 33
local	Term			= 27

for i = 1, MaxTitleCount do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Userinfo_TitleButton"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 882)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", 504, 86)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", 504, 86)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("SelectedHover", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("SelectedPushed", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setProperty("GroupID", 151)
	mywindow:setPosition(0, First_PosY + (i - 1) * Term)
	mywindow:setSize(220, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TitleIndex", tostring(i))
	mywindow:setSubscribeEvent("SelectStateChanged", "TitleInfo_ClickEvent")
	mywindow:subscribeEvent("MouseButtonDown", "TitleInfo_ButtonMouseDown");
	mywindow:subscribeEvent("MouseButtonUp", "TitleInfo_ButtonMouseUp");
	mywindow:subscribeEvent("MouseLeave", "TitleInfo_ButtonMouseLeave");
	mywindow:subscribeEvent("MouseEnter", "TitleInfo_ButtonMouseEnter");
	mywindow:subscribeEvent("MouseDoubleClicked", "TitleInfo_ButtonDoubleClick");
	winMgr:getWindow("Userinfo_TitleListBackImg"):addChildWindow(mywindow)
	
	
	--------------------------------------------------------------------
	-- 칭호 장착버튼
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "Userinfo_TitleUseButton"..i)
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", 671, 833)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", 671, 851)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", 671, 869)
	mywindow:setTexture("PushedOff", "UIData/myinfo2.tga", 671, 869)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 671, 887)
	mywindow:setPosition(160, 2)
	mywindow:setSize(55, 18)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "TitleInfo_UseButtonEvent")
	winMgr:getWindow("Userinfo_TitleButton"..i):addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- 칭호 해제버튼
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "Userinfo_TitleReleaseButton"..i)
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", 726, 833)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", 726, 851)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", 726, 869)
	mywindow:setTexture("PushedOff", "UIData/myinfo2.tga", 726, 869)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 726, 887)
	mywindow:setPosition(160, 2)
	mywindow:setSize(55, 18)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "TitleInfo_ReleaseButtonEvent")
	winMgr:getWindow("Userinfo_TitleButton"..i):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Userinfo_TitleWithoutText"..i)
	mywindow:setPosition(160, 5)
	mywindow:setSize(55, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(3)
	mywindow:setEnabled(false)
	winMgr:getWindow("Userinfo_TitleButton"..i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Userinfo_TitleNameText"..i)
	mywindow:setPosition(7, 3)
	mywindow:setSize(150, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(80, 80, 80, 255)
	mywindow:setEnabled(false)
	winMgr:getWindow("Userinfo_TitleButton"..i):addChildWindow(mywindow)
		
end


-- 페이지 설정 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Userinfo_TitlePageText")
mywindow:setPosition(76, 325)
mywindow:setSize(70, 18)
mywindow:setZOrderingEnabled(false)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
mywindow:setEnabled(false)
winMgr:getWindow("Userinfo_TitleBackImg"):addChildWindow(mywindow)

winMgr:getWindow("Userinfo_TitlePageText"):clearTextExtends();
winMgr:getWindow("Userinfo_TitlePageText"):addTextExtends("1 / 1" ,g_STRING_FONT_GULIM, 15, 255,255,255,255,  0,  20,20,20,255);
	
----------------------------------------------------------------------------------
-- 페이지 좌, 우 버튼
----------------------------------------------------------------------------------
local tTitle_PageButtonName		= {['err']=0, "Userinfo_Title_Left", "Userinfo_Title_Right" }
local tTitle_PageButtonPosX		= {['err']=0, 65, 140 }
local tTitle_PageButtonTexX		= {['err']=0, 987,	970}
local tTitle_PageButtonEvent	= {['err']=0, "Userinfo_Title_LeftButtonClick", "Userinfo_Title_RightButtonClick" }

for i = 1, #tTitle_PageButtonName do

	mywindow = winMgr:createWindow("TaharezLook/Button", tTitle_PageButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tTitle_PageButtonTexX[i] , 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga",  tTitle_PageButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga",  tTitle_PageButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tTitle_PageButtonTexX[i], 44)
	mywindow:setPosition(tTitle_PageButtonPosX[i], 322)
	mywindow:setSize(17, 22)
	mywindow:subscribeEvent("Clicked", tTitle_PageButtonEvent[i])
	winMgr:getWindow("Userinfo_TitleBackImg"):addChildWindow(mywindow)
end

local NOT_POSSESION	= 0
local POSSESION		= 1
local USE			= 2
local SELECTED		= 3

local tPossesionColor	= {['err']=0, 255, 187, 0}		-- 노랑(보유)
local tSelectColor		= {['err']=0, 255, 255, 255}	-- 흰색(선택)
local tBaseColor		= {['err']=0, 180, 180, 180}		-- 회색(기본)
local tUseColor			= {['err']=0, 87, 242, 9}		-- 녹색(착용)

local tTitleColorOldTable	= {['err']=0, }
local tTitleStateTable	= {['err']=0, tBaseColor, tPossesionColor, tUseColor, tSelectColor}
local tSetTitleColor	= {['err']=0, }

-- 칭호 사용 버튼
function TitleInfo_UseButtonEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local mywindow		= EventWindow:getParent()		-- 부모 윈도우
	
	local Index			= tonumber(mywindow:getUserString("TitleIndex"))
	winMgr:getWindow("Userinfo_TitleButton"..Index):setProperty("Selected", "true")
	
	UseTitle(false, true, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
	--EventWindow:getparent

end


-- 칭호 해제 버튼
function TitleInfo_ReleaseButtonEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local mywindow		= EventWindow:getParent()		-- 부모 윈도우

	local Index			= tonumber(mywindow:getUserString("TitleIndex"))
	winMgr:getWindow("Userinfo_TitleButton"..Index):setProperty("Selected", "true")
	
	UseTitle(false, false, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
end

-- 칭호 사용후
function UseRefreshTitleInfoList(page)

	RefreshTitleList(page)

end

-- 칭호 왼쪽 페이지버튼 이벤트
function Userinfo_Title_LeftButtonClick(args)

	local bOK, CurrentPage	= Title_LeftButtonClick()
	if bOK then
		RefreshTitleList(CurrentPage)
		winMgr:getWindow("Userinfo_TitleButton1"):setProperty("Selected", "true")
--		tTitleColorOldTable[1]	= tSetTitleColor[1]
		tSetTitleColor[1]		= SELECTED + 1
		
		local Name, Desc, Effect = SelectTitle(1)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 200)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 200)
		TitleInfoTextRefresh(Name, Desc, Effect)		
	end

end


-- 칭호 오른쪽 페이지버튼 이벤트
function Userinfo_Title_RightButtonClick(args)
	
	local bOK, CurrentPage	= Title_RightButtonClick()
	if bOK then
		RefreshTitleList(CurrentPage)
		winMgr:getWindow("Userinfo_TitleButton1"):setProperty("Selected", "true")
--		tTitleColorOldTable[1]	= tSetTitleColor[1]
		tSetTitleColor[1]		= SELECTED + 1
		
		local Name, Desc, Effect = SelectTitle(1)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 200)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 200)
		TitleInfoTextRefresh(Name, Desc, Effect)		

	end
	
end




-- 칭호의 페이지를 세팅해준다
function SetTextTitleInfoTotalPage(CurrentPage)
	totalpage	= GetTitleTotalPage()
	winMgr:getWindow("Userinfo_TitlePageText"):clearTextExtends();
	winMgr:getWindow("Userinfo_TitlePageText"):addTextExtends(tostring(CurrentPage).." / "..tostring(totalpage), g_STRING_FONT_GULIM, 15, 255,255,255,255,  0,  20,20,20,255);
end


-- 라디오버튼 이름 초기화
function ResetTitleInfoNameText()
	for i = 1, MaxTitleCount do
		winMgr:getWindow("Userinfo_TitleNameText"..i):setText("")
		winMgr:getWindow("Userinfo_TitleButton"..i):setVisible(false)
		winMgr:getWindow("Userinfo_TitleButton"..i):setEnabled(false)
	end
end


-- 리스트 리프레쉬
function TitleInfoListTextRefresh(Index, State, Name)
	local	tableBuf	= tTitleStateTable[State + 1]
	tSetTitleColor[Index]		= State + 1
	tTitleColorOldTable[Index]	= State + 1
	winMgr:getWindow("Userinfo_TitleButton"..Index):setVisible(true)
	winMgr:getWindow("Userinfo_TitleButton"..Index):setEnabled(true)
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setTextColor(tableBuf[1], tableBuf[2], tableBuf[3], 255)
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setText(Name)
	
	if State == NOT_POSSESION then
		winMgr:getWindow("Userinfo_TitleUseButton"..Index):setVisible(false)
		winMgr:getWindow("Userinfo_TitleReleaseButton"..Index):setVisible(false)
		winMgr:getWindow("Userinfo_TitleWithoutText"..Index):setVisible(true)	
	elseif State == POSSESION then
		winMgr:getWindow("Userinfo_TitleUseButton"..Index):setVisible(true)
		winMgr:getWindow("Userinfo_TitleReleaseButton"..Index):setVisible(false)
		winMgr:getWindow("Userinfo_TitleWithoutText"..Index):setVisible(false)		
	elseif State == USE then
		winMgr:getWindow("Userinfo_TitleUseButton"..Index):setVisible(false)
		winMgr:getWindow("Userinfo_TitleReleaseButton"..Index):setVisible(true)
		winMgr:getWindow("Userinfo_TitleWithoutText"..Index):setVisible(false)				
	end	
end

function TitleInfoTextRefresh(Name, Desc, Effect)
	
	winMgr:getWindow("Userinfo_Title_NameText"):clearTextExtends();
	winMgr:getWindow("Userinfo_Title_NameText"):addTextExtends(Name ,g_STRING_FONT_GULIM, 13, 255,205,86,255,  0,  255,255,255,255);

	winMgr:getWindow("Userinfo_Title_DescText"):clearTextExtends();
	winMgr:getWindow("Userinfo_Title_DescText"):addTextExtends(Desc, g_STRING_FONT_GULIM, 12, 200,200,200,255,  0,  20,20,20,255);

	winMgr:getWindow("Userinfo_Title_EffectText"):clearTextExtends();
	winMgr:getWindow("Userinfo_Title_EffectText"):addTextExtends(Effect ,g_STRING_FONT_GULIM, 12, 87,242,9,255,  0,  20,20,20,255);


end


-- 칭호버튼 더블클릭 이벤트
function TitleInfo_ButtonDoubleClick(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(EventWindow:getUserString("TitleIndex"))
	tTitleColorOldTable[Index]		= NOT_POSSESION + 1
	UseTitle(true, false, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
end

-- 칭호 버튼 클릭 이벤트
function TitleInfo_ClickEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(EventWindow:getUserString("TitleIndex"))
	local ColorIndex	= 0
	
	if CEGUI.toRadioButton(EventWindow):isSelected() then		
		tTitleColorOldTable[Index]	= tSetTitleColor[Index]
		tSetTitleColor[Index]		= SELECTED + 1
		
		local Name, Desc, Effect = SelectTitle(Index)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 220)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 220)
		TitleInfoTextRefresh(Name, Desc, Effect)		
		
	else
		tSetTitleColor[Index]	= tTitleColorOldTable[Index]
	end
	ColorIndex	= tSetTitleColor[Index]
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setTextColor(tTitleStateTable[ColorIndex][1], tTitleStateTable[ColorIndex][2], tTitleStateTable[ColorIndex][3], 255)
end

-- 칭호 라디오버튼 마우스 들어왔을때
function TitleInfo_ButtonMouseEnter(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setTextColor(255, 255, 255, 255)
	--winMgr:getWindow("My_TitleNameText"..Index):setPosition(7, 5)

end

-- 칭호 라디오버튼 마우스 떠났을때
function TitleInfo_ButtonMouseLeave(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	local tableBuf	= tTitleStateTable[tSetTitleColor[Index]]

	winMgr:getWindow("Userinfo_TitleNameText"..Index):setTextColor(tableBuf[1], tableBuf[2], tableBuf[3], 255)
end



-- 칭호 라디오 버튼에 마우스 다운시 이벤트
function TitleInfo_ButtonMouseDown(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setPosition(9, 5)

end

-- 칭호 라디오 버튼에 마우스 업 이벤트
function TitleInfo_ButtonMouseUp(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("Userinfo_TitleNameText"..Index):setPosition(7, 3)

end

--------------------------------------------------------------------
-- 칭호정보 보여줄 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleInfoBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(240, 10)
mywindow:setSize(243, 307)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Userinfo_TitleBackImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 타이틀 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleInfoHeaderImg")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 504, 440)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 504, 440)
mywindow:setPosition(6, 1)
mywindow:setSize(74, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Userinfo_TitleInfoBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호정보에 들어가는 라인 이미지
--------------------------------------------------------------------
for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleLineImg"..i)
	mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 501, 448)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 501, 448)
	mywindow:setPosition(0, 23 + (187 * (i - 1)))
	mywindow:setSize(243, 3)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Userinfo_TitleInfoBackImg"):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Userinfo_TitleLineImg3")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 1000, 52)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 1000, 52)
mywindow:setPosition(0, 10)
mywindow:setSize(3, 283)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Userinfo_TitleInfoBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호 이름, 설명, 효과 text
--------------------------------------------------------------------
local	tTitleTextName	= {['err']=0, "Userinfo_Title_NameText", "Userinfo_Title_DescText", "Userinfo_Title_EffectText"}
local	tTitleTextPosY	= {['err']=0,		34,					58,				225}
local	tTitleTextsizeY	= {['err']=0,		17,					150,			50}


for i = 1, #tTitleTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tTitleTextName[i])
	mywindow:setPosition(12, tTitleTextPosY[i])
	mywindow:setSize(220, tTitleTextsizeY[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(3)
	winMgr:getWindow("Userinfo_TitleInfoBackImg"):addChildWindow(mywindow)

end






------------------------------------------------------
------											------
------		칭호 애니메이션으로 보여준다.		------
------											------
------------------------------------------------------
function MakeCharacterTitleWindow(titleIndex, key)--, posx, posy)
	if titleIndex ~= 26 then
		if titleIndex == 22 or titleIndex == 23 or titleIndex == 24 or titleIndex == 25 then
			if winMgr:getWindow("villageTitleWnd1_"..key) then
				return
			end
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "villageTitleWnd3_"..key)
			mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 810 + 21*(titleIndex-22))
			mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 810 + 21*(titleIndex-22))
			mywindow:setPosition(0, 0)
			mywindow:setSize(112, 18)
			mywindow:setVisible(false)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			root:addChildWindow(mywindow)
			
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "villageTitleWnd1_"..key)
			mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 643 + 21*(titleIndex-22))
			mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 643 + 21*(titleIndex-22))
			mywindow:setPosition(0, 0)
			mywindow:setSize(112, 18)
			mywindow:setVisible(false)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 255, 0, 16, true, true, 10)
			mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 0, 255, 16, true, true, 10)
			root:addChildWindow(mywindow)
			
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "villageTitleWnd2_"..key)
			mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 726 + 21*(titleIndex-22))
			mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 726 + 21*(titleIndex-22))
			mywindow:setPosition(0, 0)
			mywindow:setSize(112, 18)
			mywindow:setVisible(false)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 0, 255, 16, true, true, 10)
			mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 255, 0, 16, true, true, 10)			
			root:addChildWindow(mywindow)

			
		else
			if winMgr:getWindow("villageTitleWnd0_"..key) then
				return	
			end
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "villageTitleWnd0_"..key)
			mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201+21*(titleIndex-1))
			mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201+21*(titleIndex-1))
			mywindow:setPosition(0, 0)
			mywindow:setSize(112, 18)
			mywindow:setVisible(false)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(false)
			-- 액션
					
			root:addChildWindow(mywindow)
		end
	end
end



-- 시작 지점에 (zone_enter)
function StartAnimationTitle(titleIndex, key)
	if titleIndex ~= 26 then -- 갱 칭호
		if titleIndex == 22 or titleIndex == 23 or titleIndex == 24 or titleIndex == 25 then
			winMgr:getWindow("villageTitleWnd1_"..key):setVisible(true)
			winMgr:getWindow("villageTitleWnd2_"..key):setVisible(true)
			winMgr:getWindow("villageTitleWnd3_"..key):setVisible(true)			
			winMgr:getWindow("villageTitleWnd1_"..key):activeMotion("titleMotionEvent")
			winMgr:getWindow("villageTitleWnd2_"..key):activeMotion("titleMotionEvent")			
		else
			winMgr:getWindow("villageTitleWnd0_"..key):setVisible(true)
		end	
	end
end

-- 시작 지점에 (zone_enter)
function EndAnimationTitle(titleIndex, key)
	if titleIndex ~= 26 then -- 갱 칭호
		if titleIndex == 22 or titleIndex == 23 or titleIndex == 24 or titleIndex == 25 then
--			winMgr:getWindow("villageTitleWnd1_"..key):setVisible(true)
--			winMgr:getWindow("villageTitleWnd2_"..key):setVisible(true)
--			winMgr:getWindow("villageTitleWnd3_"..key):setVisible(true)			
			winMgr:getWindow("villageTitleWnd1_"..key):activeMotion("titleMotionEvent")
			winMgr:getWindow("villageTitleWnd2_"..key):activeMotion("titleMotionEvent")			
		else
			winMgr:getWindow("villageTitleWnd0_"..key):setVisible(true)
		end	
	end
end


-- 위치를 업데이트 해준다.
function UpdateCharacterTitlePos(characterName, bonetype, titleIndex, key, posx, posy)
	if titleIndex ~= 26 then -- 갱 칭호
		local offset = 0
		if bonetype == 2 or bonetype == 5 then		-- 소
			offset = 26
		elseif bonetype == 1 or bonetype == 4 then
			offset = 15
		end
		local id_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 14, characterName)+38) / 2
		if titleIndex > 0 then
			if titleIndex == 22 or titleIndex == 23 or titleIndex == 24 or titleIndex == 25 then
				if winMgr:getWindow("villageTitleWnd1_"..key) then
--					winMgr:getWindow("villageTitleWnd1_"..key):setVisible(true)
					winMgr:getWindow("villageTitleWnd1_"..key):setPosition(posx+88-id_width, posy+10+offset)
--					winMgr:getWindow("villageTitleWnd2_"..key):setVisible(true)
					winMgr:getWindow("villageTitleWnd2_"..key):setPosition(posx+88-id_width, posy+10+offset)
--					winMgr:getWindow("villageTitleWnd3_"..key):setVisible(true)
					winMgr:getWindow("villageTitleWnd3_"..key):setPosition(posx+88-id_width, posy+10+offset)
				end
			else
				if winMgr:getWindow("villageTitleWnd0_"..key)then
					winMgr:getWindow("villageTitleWnd0_"..key):setVisible(true)
					winMgr:getWindow("villageTitleWnd0_"..key):setPosition(posx+88-id_width, posy+10+offset)
				end
			end	
		end
	end
end


function falseTitle(titleIndex, key)
	if titleIndex == 22 or titleIndex == 23 or titleIndex == 24 or titleIndex == 25 then
		if winMgr:getWindow("villageTitleWnd1_"..key) then
			winMgr:getWindow("villageTitleWnd1_"..key):setVisible(false)
			winMgr:getWindow("villageTitleWnd2_"..key):setVisible(false)
			winMgr:getWindow("villageTitleWnd3_"..key):setVisible(false)
		end
	else
		if winMgr:getWindow("villageTitleWnd0_"..key)then
			winMgr:getWindow("villageTitleWnd0_"..key):setVisible(false)
		end
	end	

end


-- 액션 클리어
function ClearVillageTitleWnd(i, key)--, titleIndex)
	if i == 0 then
		winMgr:getWindow("villageTitleWnd0_"..key):setVisible(false)
	else
		winMgr:getWindow("villageTitleWnd"..i.."_"..key):setVisible(false)
		winMgr:getWindow("villageTitleWnd"..i.."_"..key):clearActiveController()
	end	
end



function DrawMotion(Drawer, motionIndex, key, value)
	
	--Drawer:drawTextureSA("UIData/numberUi001.tga", screenX+60-id_width, screenY+1+offset, 32, 32, 0, 0, 200, 200, 255, 0, 0)	


end

