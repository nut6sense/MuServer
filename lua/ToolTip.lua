--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate()


-- ������ �� ������ ���õ� ����.
local TT_MAX_LINE			= 5	-- �⺻ ������ ������ �� �ִ� �ټ�.
local TOP_YSIZE				= 115
local BASE_MIDDLE_YSIZE		= 78
local MIDDLE_YSIZE			= 1
local BOTTOM_YSIZE			= 17



--[[
-- ���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TTip_Main")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(400, 200)	-- �׽�Ʈ������..
mywindow:setSize(248, 206)	-- �⺻������.		--> ���߿� �÷��ش�. spawn�Ҷ�.
mywindow:setVisible(false)		-- �׽�Ʈ���� true�� ����.
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
	drawer:drawTexture("UIData/skillItem001.tga",0, 0, 248, 48, 756, 60)				-- �� �̹���
	drawer:drawTexture("UIData/skillItem001.tga",0, 48, 248, middleSizeY, 756, 108)		-- �߰� �̹���
	
	-- ����
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	common_DrawOutlineText2(drawer, g_Level, 12, 22, 0,0,0,255, 255,255,255,255)
	
	


end

--]]
--------------------------------------------------------------------

-- Ysize�� ���μ������� ���������� ���ϴ� ������ �����Ѵ�.(�����ۼ� xsize 268)
-- �ѹ� ���������� ��ġ�� �����ؼ� ����� �� �ְ� ��������.

--------------------------------------------------------------------
function YSizeVariableToolTipCreate(WinName, Xsize, Ysize, TexX, TexY, MiddleSize)
	BASE_MIDDLE_YSIZE = MiddleSize
------------------------------------------------------------------
-- ���� ���̽��� �Ǵ� ������ �����Ѵ�.
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(400, 200)	-- �׽�Ʈ������..
	mywindow:setSize(Xsize, Ysize)	-- �⺻������.		--> ���߿� �÷��ش�. spawn�Ҷ�.
	mywindow:setVisible(false)		-- �׽�Ʈ���� true�� ����.
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
------------------------------------------------------------------
-- �����κ�(�̸�, ���� ����.)
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
-- �߰��� ���� �̹���(�̰� �÷��� ����� �� �ֵ��� �������Ѵ�.)
------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", WinName.."TT_Middle")
	mywindow:setTexture("Enabled", "UIData/skillItem001.tga", TexX, TexY + 113)
	mywindow:setTexture("Disabled", "UIData/skillItem001.tga", TexX, TexY + 113)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, TOP_YSIZE)
	mywindow:setSize(Xsize, MIDDLE_YSIZE)
	mywindow:setScaleHeight(255 * BASE_MIDDLE_YSIZE)	-- �⺻ �̹����� ����� 90.. --> 9�踦 ���ش�.
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(WinName):addChildWindow(mywindow)
------------------------------------------------------------------
-- �Ʒ��κ�.
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
-- ��ü �������� �ٿ��� ������ ��ü������ ���� ������ �̹���.
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
	
	-- ����, �̸�, ���� Text
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
-- ������ ����ٶ� ����� �Լ�.
------------------------------------------------------------------
function YSizeVariableToolTipSpawn(WinName, Xsize, fontSize, LineSpace, LineCount, KindCount)
	winMgr:getWindow(WinName):setVisible(true)
	if LineCount > TT_MAX_LINE then		-- ������ �⺻ �̹������� �Ѿ ���.
		winMgr:getWindow(WinName):setSize(Xsize, TOP_YSIZE + (MIDDLE_YSIZE * ((fontSize + 6) * LineCount)) + BOTTOM_YSIZE)		-- �ֻ��� �θ� ������ ����
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
-- ������ �����κп� �� ������ �޾ƿ´�
------------------------------------------------------------------
local g_Level	= ""					-- ���� ����
local g_Name	= ""					-- ���� �̸�
local g_Desc	= ""					-- ���� ����
local g_tEtc	= {['protecterr']=0, }	-- ���� ��Ÿ���
local g_tPeriod	= {['protecterr']=0, }	-- ���� �Ⱓ


function SendtoToolTipInfo(Level, Name, Desc, tEtc, tPeriod)
	g_Level		= Level
	g_Name		= Name
	g_Desc		= Desc
	g_tEtc		= tEtc
	g_tPeriod	= tPeriod
end

--table.getn(g_tEtc)	-- ���̺��� ������ �˷��ش�

------------------------------------------------------------------
-- ������ �׷��ִ� �����Լ�.
------------------------------------------------------------------
function TT_Render(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	
	-- ����
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	common_DrawOutlineText2(drawer, g_Level, 12, 22, 0,0,0,255, 255,255,255,255)
	
	-- ������ �̸�
	drawer:setFont(g_STRING_FONT_DODUMCHE, 13)
	local StringSize	= GetStringSize(g_STRING_FONT_DODUMCHE, 13, g_Name)
	common_DrawOutlineText2(drawer, g_Name, 135 - (StringSize / 2), 22, 0,0,0,255, 255,205,86,255)

	-- ������ ����
	drawer:setFont(g_STRING_FONT_DODUMCHE, 112)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:drawText(g_Desc, 15, 60)
	
	
	local EtcCount	= table.getn(g_tEtc)	-- ������ ���� �� ���.
	-- 
	for i = 1, EtcCount do
		drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
		common_DrawOutlineText2(drawer, g_tEtc[i], 15, 120 + (i - 1) * 20, 0,0,0,255, 0,255,0,255)
	end
	
	local PeriodCount	= table.getn(g_tPeriod)	-- ������ ���� �� ���.
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
-- ������ ���� �� ����� �Լ�.
------------------------------------------------------------------
function YSizeVariableToolTipClose(WinName)
	winMgr:getWindow(WinName):setVisible(false)
end











------------------------------------------------------------------
-- �������� �� ���� ����ش�.
------------------------------------------------------------------
root:addChildWindow("CommonTooltip")
winMgr:getWindow("CommonTooltipRenderImg"):subscribeEvent('EndRender', "CommonToolTipRender")

xsize				= 248
base_ysize			= 206
top_ysize			= 50
bottom_ysize		= 8
base_middle_ysize	= 148


-- ������ �����̳� �������� ���������� �̹��������� ���ش�.
function SettingToolTipImg(linecount, fontsize, LineSpace)
	if linecount > 5 then	-- ���� ī��Ʈ
		winMgr:getWindow("CommonTooltip"):setSize(xsize, top_ysize + ((fontsize + 4) * linecount) + bottom_ysize)
		winMgr:getWindow("CommonTooltipMiddle"):setScaleHeight(255 * ((fontsize + 4) * linecount))
		winMgr:getWindow("CommonTooltipBottom"):setPosition(0, top_ysize + ((fontsize + 4) * linecount))
		winMgr:getWindow("CommonTooltipRenderImg"):setSize(xsize, top_ysize + ((fontsize + 4) * linecount) + bottom_ysize)		
	else					-- �⺻
		winMgr:getWindow("CommonTooltip"):setSize(xsize, base_ysize)
		winMgr:getWindow("CommonTooltipMiddle"):setScaleHeight(255 * base_middle_ysize)
		winMgr:getWindow("CommonTooltipBottom"):setPosition(0, top_ysize + base_middle_ysize)
		winMgr:getWindow("CommonTooltipRenderImg"):setSize(xsize, base_ysize)
	end
end


-- ���� Text�� ���ش�.
function CommonToolTipRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
		
	



end


