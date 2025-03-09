--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate()


-- 아이템 샾 툴팁에 관련된 내용.
local TT_MAX_LINE			= 5	-- 기본 툴팁의 라인이 들어갈 최대 줄수.
local TOP_YSIZE				= 115
local BASE_MIDDLE_YSIZE		= 78
local MIDDLE_YSIZE			= 1
local BOTTOM_YSIZE			= 17



--[[
-- 툴팁 메인 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TTip_Main")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(400, 200)	-- 테스트때문에..
mywindow:setSize(248, 206)	-- 기본사이즈.		--> 나중에 늘려준다. spawn할때.
mywindow:setVisible(false)		-- 테스트때매 true인 상태.
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent('EndRender', "TTip_Render")
root:addChildWindow("TTip_Main")



BaseMiddelSizeY	= 151
BaseLineCount	= 0


function TTip_Render(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	
	middlePosY		= 0
	middleSizeY		= BaseMiddelSizeY
	drawer:drawTexture("UIData/skillItem001.tga",0, 0, 248, 48, 756, 60)				-- 위 이미지
	drawer:drawTexture("UIData/skillItem001.tga",0, 48, 248, middleSizeY, 756, 108)		-- 중간 이미지
	
	-- 레벨
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	common_DrawOutlineText2(drawer, g_Level, 12, 22, 0,0,0,255, 255,255,255,255)
	
	


end

--]]
--------------------------------------------------------------------

-- Ysize가 라인수에따라 가변적으로 변하는 툴팁을 생성한다.(아이템샵 xsize 268)
-- 한번 만들어놓으면 위치만 변경해서 사용할 수 있게 만들어야함.

--------------------------------------------------------------------
function YSizeVariableToolTipCreate(WinName, Xsize, Ysize, TexX, TexY, MiddleSize)
	BASE_MIDDLE_YSIZE = MiddleSize
------------------------------------------------------------------
-- 가장 베이스가 되는 뒷판을 생성한다.
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(400, 200)	-- 테스트때문에..
	mywindow:setSize(Xsize, Ysize)	-- 기본사이즈.		--> 나중에 늘려준다. spawn할때.
	mywindow:setVisible(false)		-- 테스트때매 true인 상태.
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
------------------------------------------------------------------
-- 위에부분(이름, 설명 공간.)
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName.."TT_Top")
	mywindow:setTexture("Enabled", "UIData/skillItem001.tga", TexX, TexY)
	mywindow:setTexture("Disabled", "UIData/skillItem001.tga", TexX, TexY)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(Xsize, TOP_YSIZE)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(WinName):addChildWindow(mywindow)
------------------------------------------------------------------
-- 중간에 들어가는 이미지(이건 늘려서 사용할 수 있도록 만들어야한다.)
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName.."TT_Middle")
	mywindow:setTexture("Enabled", "UIData/skillItem001.tga", TexX, TexY + 113)
	mywindow:setTexture("Disabled", "UIData/skillItem001.tga", TexX, TexY + 113)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, TOP_YSIZE)
	mywindow:setSize(Xsize, MIDDLE_YSIZE)
	mywindow:setScaleHeight(255 * BASE_MIDDLE_YSIZE)	-- 기본 이미지의 사이즈가 90.. --> 9배를 해준다.
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(WinName):addChildWindow(mywindow)
------------------------------------------------------------------
-- 아래부분.
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName.."TT_Bottom")
	mywindow:setTexture("Enabled", "UIData/skillItem001.tga", TexX, TexY + 186)
	mywindow:setTexture("Disabled", "UIData/skillItem001.tga", TexX, TexY + 186)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, TOP_YSIZE + MIDDLE_YSIZE * BASE_MIDDLE_YSIZE)
	mywindow:setSize(Xsize, BOTTOM_YSIZE)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(WinName):addChildWindow(mywindow)
	

------------------------------------------------------------------
-- 전체 조각으로 붙여논 툴팁을 전체적으로 덮는 투명한 이미지.
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName.."TT_MainImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * BASE_MIDDLE_YSIZE) + BOTTOM_YSIZE)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent('EndRender', "TT_Render")
	winMgr:getWindow(WinName):addChildWindow(mywindow)
	
	-- 레벨, 이름, 설명 Text
	tTT_TextName	= {["protecterr"] = 0, "Level", "Name", "Desc"}
	tTT_TextPosx	= {["protecterr"] = 0,		2,		8,		18}
	tTT_TextPosy	= {["protecterr"] = 0,		10,		25,		58}
	tTT_TextSizex	= {["protecterr"] = 0,		50,		252,	228}
	
	for i = 1, #tTT_TextName do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", WinName..tTT_TextName[i])
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(tTT_TextPosx[i], tTT_TextPosy[i])
		mywindow:setSize(tTT_TextSizex[i], 20)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		mywindow:setVisible(true)
		mywindow:setViewTextMode(1)
		if i == 3 then
			mywindow:setAlign(1)
		else
			mywindow:setAlign(8)
		end
		mywindow:setLineSpacing(2)
		winMgr:getWindow(WinName.."TT_MainImg"):addChildWindow(mywindow)
	end
	
	
	for i = 1, 10 do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", WinName.."Text"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(18, 115)
		mywindow:setSize(228, 20)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		mywindow:setVisible(true)
		mywindow:setViewTextMode(1)
		mywindow:setAlign(1)
		mywindow:setLineSpacing(2)
		winMgr:getWindow(WinName.."TT_MainImg"):addChildWindow(mywindow)
	end
	

end


------------------------------------------------------------------
-- 툴팁을 띄워줄때 사용할 함수.
------------------------------------------------------------------
function YSizeVariableToolTipSpawn(WinName, Xsize, fontSize, LineSpace, LineCount, KindCount)
	winMgr:getWindow(WinName):setVisible(true)
	if LineCount > TT_MAX_LINE then		-- 라인이 기본 이미지보다 넘어갈 경우.
		winMgr:getWindow(WinName):setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * ((fontSize + 6) * LineCount)) + BOTTOM_YSIZE)		-- 최상위 부모 윈도우 설정
		winMgr:getWindow(WinName.."TT_Middle"):setScaleHeight(255 * ((fontSize + 6) * LineCount))
		winMgr:getWindow(WinName.."TT_Bottom"):setPosition(0, TOP_YSIZE + MIDDLE_YSIZE * ((fontSize + 6) * LineCount))
		winMgr:getWindow(WinName.."TT_MainImg"):setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * ((fontSize + 6) * LineCount)) + BOTTOM_YSIZE)
	else
		winMgr:getWindow(WinName):setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * BASE_MIDDLE_YSIZE) + BOTTOM_YSIZE)
		winMgr:getWindow(WinName.."TT_Middle"):setScaleHeight(255 * BASE_MIDDLE_YSIZE)
		winMgr:getWindow(WinName.."TT_Bottom"):setPosition(0, TOP_YSIZE + MIDDLE_YSIZE * BASE_MIDDLE_YSIZE)
		winMgr:getWindow(WinName.."TT_MainImg"):setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * BASE_MIDDLE_YSIZE) + BOTTOM_YSIZE)
	end
end



------------------------------------------------------------------
-- 툴팁의 랜더부분에 들어갈 값들을 받아온다
------------------------------------------------------------------
local g_Level	= ""					-- 툴팁 레벨
local g_Name	= ""					-- 툴팁 이름
local g_Desc	= ""					-- 툴팁 설명
local g_tEtc	= {['protecterr']=0, }	-- 툴팁 기타등등
local g_tPeriod	= {['protecterr']=0, }	-- 툴팁 기간


function SendtoToolTipInfo(Level, Name, Desc, tEtc, tPeriod)
	g_Level		= Level
	g_Name		= Name
	g_Desc		= Desc
	g_tEtc		= tEtc
	g_tPeriod	= tPeriod
end

--table.getn(g_tEtc)	-- 테이블의 갯수를 알려준다

------------------------------------------------------------------
-- 툴팁을 그려주는 랜더함수.
------------------------------------------------------------------
function TT_Render(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	
	-- 레벨
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	common_DrawOutlineText2(drawer, g_Level, 12, 22, 0,0,0,255, 255,255,255,255)
	
	-- 아이템 이름
	drawer:setFont(g_STRING_FONT_DODUMCHE, 13)
	local StringSize	= GetStringSize(g_STRING_FONT_DODUMCHE, 13, g_Name)
	common_DrawOutlineText2(drawer, g_Name, 135 - (StringSize / 2), 22, 0,0,0,255, 255,205,86,255)

	-- 아이템 설명
	drawer:setFont(g_STRING_FONT_DODUMCHE, 112)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:drawText(g_Desc, 15, 60)
	
	
	local EtcCount	= table.getn(g_tEtc)	-- 툴팁에 들어가는 게 몇갠지.
	-- 
	for i = 1, EtcCount do
		drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
		common_DrawOutlineText2(drawer, g_tEtc[i], 15, 120 + (i - 1) * 20, 0,0,0,255, 0,255,0,255)
	end
	
	local PeriodCount	= table.getn(g_tPeriod)	-- 툴팁에 들어가는 게 몇갠지.
	-- 
	for i = 1, PeriodCount do
		drawer:setFont(g_STRING_FONT_DODUMCHE, 112)
		common_DrawOutlineText2(drawer, g_tPeriod[i], 15, 200 + (i - 1) * 20, 0,0,0,255, 255,198,30,255)		
	end
	
	--drawer:drawTextWithAlign("", , ,  8, twidth, theight);
	--drawer:drawText("", , )
--	common_DrawOutlineText2(drawer, , 60, 48, 0,0,0,255, 87,242,9,255)
	
	
end

------------------------------------------------------------------
-- 툴팁을 닫을 때 사용할 함수.
------------------------------------------------------------------
function YSizeVariableToolTipClose(WinName)
	winMgr:getWindow(WinName):setVisible(false)
end











------------------------------------------------------------------
-- 공통으로 쓸 툴팁 띄워준다.
------------------------------------------------------------------
root:addChildWindow("CommonTooltip")
winMgr:getWindow("CommonTooltipRenderImg"):subscribeEvent('EndRender', "CommonToolTipRender")

xsize				= 248
base_ysize			= 206
top_ysize			= 50
bottom_ysize		= 8
base_middle_ysize	= 148


-- 툴팁을 스텟이나 여러가지 정보에따라 이미지셋팅을 해준다.
function SettingToolTipImg(linecount, fontsize, LineSpace)
	if linecount > 5 then	-- 라인 카운트
		winMgr:getWindow("CommonTooltip"):setSize(xsize, top_ysize + ((fontsize + 4) * linecount) + bottom_ysize)
		winMgr:getWindow("CommonTooltipMiddle"):setScaleHeight(255 * ((fontsize + 4) * linecount))
		winMgr:getWindow("CommonTooltipBottom"):setPosition(0, top_ysize + ((fontsize + 4) * linecount))
		winMgr:getWindow("CommonTooltipRenderImg"):setSize(xsize, top_ysize + ((fontsize + 4) * linecount) + bottom_ysize)		
	else					-- 기본
		winMgr:getWindow("CommonTooltip"):setSize(xsize, base_ysize)
		winMgr:getWindow("CommonTooltipMiddle"):setScaleHeight(255 * base_middle_ysize)
		winMgr:getWindow("CommonTooltipBottom"):setPosition(0, top_ysize + base_middle_ysize)
		winMgr:getWindow("CommonTooltipRenderImg"):setSize(xsize, base_ysize)
	end
end


-- 툴팁 Text를 써준다.
function CommonToolTipRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
		
	



end


