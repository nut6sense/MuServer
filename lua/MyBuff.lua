--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local MAX_BUFF_SPACE = 5	-- �� 5��
local MAX_BUFF_NUM   = 45	-- ���� ���� �ִ밹��


local BUFF_AUTO_POTION = 35


--------------------------------------------------------------------

-- ���� ������

--------------------------------------------------------------------

local CurrentBuffPosIndex = GetCurrentWndType()

-- ���� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_buff_tempAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
if CurrentBuffPosIndex == WND_LUA_VILLAGE or  CurrentBuffPosIndex == WND_LUA_SELECTCHARACTER or CurrentBuffPosIndex == WND_LUA_QUEST or CurrentBuffPosIndex == WND_LUA_GAME then
	mywindow:setWideType(1);
else
	mywindow:setWideType(6);
end
mywindow:setPosition(400, 5)
mywindow:setSize(400, 60)
mywindow:setVisible(true)
if CurrentBuffPosIndex == WND_LUA_GAME or CurrentBuffPosIndex == WND_LUA_QUEST or CurrentBuffPosIndex == WND_LUA_SELECTCHARACTER then
	mywindow:setVisible(false)
end
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)




tMyBuffTooltipTime	  = {["err"]=0, }
tMyBuffTooltipText	  = {["err"]=0, }
tMyBuffTooltipVisible = {["err"]=0, }
for i=0, MAX_BUFF_NUM-1 do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_buff_IconBackAlphaImage_"..i)
	mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 788)
	mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 788)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(365-(i*30), 0)
	mywindow:setSize(32, 32)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_buff_tempAlphaImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_buff_IconBackImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 788)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 788)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(365-(i*30), 0)
	mywindow:setSize(32, 32)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_buff_tempAlphaImage"):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_buff_IconImage_"..i)
	mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(32, 32)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:setUserString("buffItemType", 0)
	mywindow:setSubscribeEvent("MouseEnter", "OnMouseEnter")
	mywindow:setSubscribeEvent("MouseLeave", "OnMouseLeave")
	mywindow:setSubscribeEvent("EndRender", "EndRenderMyBuffTooltip")
	--mywindow:addController("motion1", "TwinkleMotion", "alpha", "Sine_EaseInOut", 255, 0, 6, true, true, 10)
	--mywindow:addController("motion1", "TwinkleMotion", "alpha", "Sine_EaseInOut", 0, 255, 6, true, true, 10)
	winMgr:getWindow("sj_buff_IconBackImage_"..i):addChildWindow(mywindow)
	
	
	tMyBuffTooltipTime[i] = 0
	tMyBuffTooltipText[i] = ""	
	tMyBuffTooltipVisible[i] = false
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_buff_IconText_"..i)
	mywindow:setPosition(13, 10)
	mywindow:setSize(5, 5)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("sj_buff_IconBackImage_"..i):addChildWindow(mywindow)
end


function ShowMyBuffUi()
	UpdateMyBuffItemUI()
	SetBuffUI(bShowBuffUI)
end


-- ���� ������ ����
function SetBuffIcon(buffCount, bShowBuffUI)
	SetBuffUI(bShowBuffUI)
end


--------------------------------------------

-- ���� ���� ������ ����

--------------------------------------------

-- ���� ���� ������ �ʱ�ȭ
function InitMyBuffItem(buffCount, currentColumn)
	
	if buffCount <= 0 then
		return
	end
		
	for i=0, MAX_BUFF_NUM-1 do
	
		winMgr:getWindow("sj_buff_IconImage_"..i):setVisible(false)
		winMgr:getWindow("sj_buff_IconBackAlphaImage_"..i):setVisible(false)
		
	end
end

-- ���� ������ ���� ���� ������ ����
function SetMyBuffItem(i, buffType, remaintime, count)

	winMgr:getWindow("sj_buff_IconText_"..i):clearTextExtends()
	


	-- �� ����� ���� ����
	if  buffType == (MAX_BUFF_NUM - 2) then
		
		if winMgr:getWindow("sj_buff_IconImage_"..i) then
			winMgr:getWindow("sj_buff_IconImage_"..i):setVisible(true)
			winMgr:getWindow("sj_buff_IconBackAlphaImage_"..i):setVisible(true)
			
			if remaintime <= PET_FEED_STATE_ONE then
				winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 814+96, 468)
			elseif remaintime <= PET_FEED_STATE_TWO then
				winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 814+64, 468)
			elseif remaintime <= PET_FEED_STATE_THREE then
				winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 814+32, 468)
			else
				winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 814, 468)
			end
			
			winMgr:getWindow("sj_buff_IconImage_"..i):setUserString("buffItemType", buffType)
		end
		
		return
	end
	
	-- �� ����ġ ���� ����
	
	if  buffType == (MAX_BUFF_NUM - 1) then
		if winMgr:getWindow("sj_buff_IconImage_"..i) then
		
			winMgr:getWindow("sj_buff_IconImage_"..i):setVisible(true)
			winMgr:getWindow("sj_buff_IconBackAlphaImage_"..i):setVisible(true)
			winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled",  "UIData/mainBG_button002.tga", 814+128, 468)
			winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Disabled",  "UIData/mainBG_button002.tga", 814+128, 468)
			winMgr:getWindow("sj_buff_IconImage_"..i):setUserString("buffItemType", buffType)
			winMgr:getWindow("sj_buff_IconText_"..i):setTextExtends(count , g_STRING_FONT_GULIM,13, 255,255,255,255,  1,  0,0,0,255);
			
		end
		
		return	
	end
	
		
	
	-- �Ϲ� ���� ������ ����
	local TexXIndex = buffType % 30
	local TexYIndex = buffType / 30
	if winMgr:getWindow("sj_buff_IconImage_"..i) then
		winMgr:getWindow("sj_buff_IconImage_"..i):setVisible(true)
		winMgr:getWindow("sj_buff_IconBackAlphaImage_"..i):setVisible(true)
		winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 32+(TexXIndex*32), 788 + TexYIndex*32)
		winMgr:getWindow("sj_buff_IconImage_"..i):setTexture("Disabled", "UIData/mainBG_button002.tga", 32+(TexXIndex*32), 788 + TexYIndex*32)
		winMgr:getWindow("sj_buff_IconImage_"..i):setUserString("buffItemType", buffType)
	end
end

--------------------------------------------

-- ���콺 �̺�Ʈ

--------------------------------------------

-- ���콺�� ������ ��
function OnMouseEnter(args)
	DebugStr('OnMouseEnter')
	local window = CEGUI.toWindowEventArgs(args).window
	--root:addChildWindow(window)
	if window:isVisible() == false then
		return
	end
	
	-- ���� ���� ������ �����Ѵ�.
	local index = tonumber(window:getUserString("index"))
	local buffItemType = tonumber(window:getUserString("buffItemType"))
	local remainMin = GetBuffItemRemainTime(buffItemType)
	
	if  buffItemType == (MAX_BUFF_NUM - 2) then
		
		if remainMin <= PET_FEED_STATE_ONE then
			tMyBuffTooltipTime[index] = PreCreateString_4405	--GetSStringInfo(LAN_PET_SATIETY_DESCRIPTION_08) 
		elseif remainMin <= PET_FEED_STATE_TWO then
			tMyBuffTooltipTime[index] = PreCreateString_4404	--GetSStringInfo(LAN_PET_SATIETY_DESCRIPTION_07)
		elseif remainMin <= PET_FEED_STATE_THREE then
			tMyBuffTooltipTime[index] = PreCreateString_4403	--GetSStringInfo(LAN_PET_SATIETY_DESCRIPTION_06)
		else
			tMyBuffTooltipTime[index] = PreCreateString_4402	--GetSStringInfo(LAN_PET_SATIETY_DESCRIPTION_05)
		end
	
	elseif buffItemType == BUFF_AUTO_POTION then
		tMyBuffTooltipTime[index] = "Remaining HP : "..CommatoMoneyStr(remainMin)
	else
		tMyBuffTooltipTime[index] = string.format(PreCreateString_2154, remainMin)
	end												--GetSStringInfo(LAN_LUA_MYBUFF_REMAINTIME)
	tMyBuffTooltipText[index] = GetBuffItemDesc(buffItemType)
	tMyBuffTooltipVisible[index] = true
end


-- ���콺�� ������ ��
function OnMouseLeave(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() == false then
		return
	end
	
	-- ���� ���� ������ �ʱ�ȭ �Ѵ�.
	local index = tonumber(window:getUserString("index"))	
	tMyBuffTooltipTime[index] = 0
	tMyBuffTooltipText[index] = ""
	tMyBuffTooltipVisible[index] = false
end



--------------------------------------------

-- ���� �׸���

--------------------------------------------

-- �ǽð� ��������
function EndRenderMyBuffTooltip(args)
	--DebugStr('EndRenderMyBuffTooltip:')
	local window = CEGUI.toWindowEventArgs(args).window
	local index  = tonumber(window:getUserString("index"))
	
	-- ���� ��ġ ���ϱ�	���� ������� ��ġ
	local buffWindowPos = winMgr:getWindow("sj_buff_tempAlphaImage"):getPosition()
	
	local backWindowIndex = index / 6
	local backWindowPos = winMgr:getWindow("sj_buff_IconBackImage_"..index):getPosition()
	
	local parentWindow = window:getParent()
	local parentPos = parentWindow:getPosition()
	
	-- ���� ��ġ ���
	local posX =  backWindowPos.x.offset+100 + buffWindowPos.x.offset
	local posY =  backWindowPos.y.offset+105 + buffWindowPos.y.offset+10
	local buffItemType = tonumber(window:getUserString("buffItemType"))
	local remainMin = GetBuffItemRemainTime(buffItemType)
	-- �ð� üũ
	if CheckRemainTime() then
		local index = tonumber(window:getUserString("index"))
		tMyBuffTooltipTime[index] = string.format(GetSStringInfo(LAN_LUA_MYBUFF_REMAINTIME), remainMin)
													--PreCreateString_2154
		tMyBuffTooltipText[index] = GetBuffItemDesc(buffItemType)
	end
	
	--[[
	if  buffItemType == (MAX_BUFF_NUM - 2) then
		if remainMin == 0 then
			posY = posY + 28
		end
	end
	--]]
	
	RenderMyBuffTooltip(index, posX, posY+20)
end


function SetTwinkleMyBuffItem(i)
	--[[
	if winMgr:getWindow("sj_buff_IconImage_"..i) then
		winMgr:getWindow("sj_buff_IconImage_"..i):activeMotion("TwinkleMotion")
	end
	--]]
end


-- ���� �׸���
function RenderMyBuffTooltip(index, px, py)
	
	if tMyBuffTooltipVisible[index] == false then
		return
	end
		
	local real_str_chat = tMyBuffTooltipText[index].."\n"..tMyBuffTooltipTime[index]
	if string.len(real_str_chat) <= 0 then
		return
	end
			
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 12)
	local text_area_x = twidth
	local text_area_y = theight
	local text_area_zoom_x, text_area_zoom_y = GetTextAreaZoomValue(text_area_x, text_area_y, 7)
	
	
	-- ��� ���� �ϱ�
	local ctrl_x = px-(7+7+text_area_x)
	local ctrl_y = py-text_area_y-50

	local zoom_x = 255
	local zoom_y = 255
	local alpha_value = 180

	drawer = root:getDrawer()
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y, 7, 7, 263, 65, zoom_x, zoom_y, alpha_value, 0, 0);								-- top_left
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y, 7, 7, 309, 65, zoom_x, zoom_y, alpha_value, 0, 0);				-- top_right
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y+7+text_area_y, 7, 7, 263, 87, zoom_x, zoom_y, alpha_value, 0, 0);				-- bottom_left
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y+7+text_area_y, 7, 7, 309, 87, zoom_x, zoom_y, alpha_value, 0, 0);	-- bottom_right
	
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y, 7, 7, 263+7, 65, text_area_zoom_x, zoom_y, alpha_value, 0, 0)					-- top_edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y+7+text_area_y, 7, 7, 263+7, 87, text_area_zoom_x, zoom_y, alpha_value, 0, 0)	-- bottom_edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x, ctrl_y+7, 7, 7, 263, 65+7, zoom_x, text_area_zoom_y, alpha_value, 0, 0)					-- left edge
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x, ctrl_y+7, 7, 7, 309, 65+7, zoom_x, text_area_zoom_y, alpha_value, 0, 0)	-- right edge
	
	drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7, ctrl_y+7, 7, 7, 263+7, 65+7, text_area_zoom_x, text_area_zoom_y, alpha_value, 0, 0)	-- center
	
	-- ��ǳ�� ���� �׸���
	--drawer:drawTextureSA('TaharezLook.tga', ctrl_x+7+text_area_x-18, ctrl_y+7+text_area_y+7-2, 17, 9, 277, 92, zoom_x, zoom_y, alpha_value, 0, 0)
	
	-- �ؽ�Ʈ �׸���
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	drawer:setTextColor(180,0,180,255)
	drawer:drawText(tMyBuffTooltipText[index], ctrl_x+7, ctrl_y+7)
	
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(tMyBuffTooltipTime[index], ctrl_x+7, ctrl_y+24)
end




















--------------------------------------------------------------------
-- ��ģ ���� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BestFriendBuffImage")
mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 33, 984)
mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 33, 984)
mywindow:setWideType(1);
mywindow:setPosition(975, 400)
mywindow:setSize(40, 40)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowBestBuffInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HideBestBuffClubInfo")
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "BestFriendBuffCount")
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16);
mywindow:setTextColor(255, 255, 255, 255);
mywindow:setPosition(30, 3)
mywindow:setSize(1, 1);
mywindow:clearTextExtends()
mywindow:setVisible(true);
mywindow:setViewTextMode(1);
mywindow:setAlign(8);
mywindow:setLineSpacing(1);
winMgr:getWindow('BestFriendBuffImage'):addChildWindow(mywindow)

function SettingBestBuffInVisible()
	DebugStr('SettingBestBuffInVisible()')
	winMgr:getWindow('BestFriendBuffImage'):setVisible(false)
end


--------------------------------------------------------------------
-- ��ģ ���� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BestFriendBuffInfo")
mywindow:setTexture("Enabled", "UIData/messenger4.tga", 684, 566)
mywindow:setTexture("Disabled", "UIData/messenger4.tga", 684, 566)
mywindow:setPosition(975, 280)
mywindow:setSize(151, 49)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function OnMouseEnter_ShowBestBuffInfo(args)
	--DebugStr("OnMouseEnter_ShowBestBuffInfo")
	
	-- ���� ����ش�.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	local BestCount = tonumber(winMgr:getWindow('BestFriendBuffCount'):getText())
	winMgr:getWindow('BestFriendBuffInfo'):setTexture("Disabled", "UIData/messenger4.tga", 684 , 566+(49*BestCount)-49)
	winMgr:getWindow('BestFriendBuffInfo'):setVisible(true)
	winMgr:getWindow('BestFriendBuffInfo'):setPosition(x-150, y)
end

function OnMouseLeave_HideBestBuffClubInfo()
	winMgr:getWindow('BestFriendBuffInfo'):setVisible(false)
end


function SettingPetBuffUi(feedTime)
	--winMgr:getWindow('sj_buff_tempAlphaImage'):setPosition(400 - 32, 5)
end