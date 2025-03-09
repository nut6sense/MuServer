-- 사용 방법
-- executeScriptFile 할때 될 수 있으면 제일 마지막에 하는 게 좋음
-- 왜냐 하면 root에 제일 나중에 붙여야 제일 마지막에 툴팁을 그릴 수있다.
-- CEGUI::System::getSingleton().executeScriptFile("UserDefineTooltip.lua"); 루아를 실행시키고
-- RegisterTooltipText(pwindow, text, sizex, sizey) 를 함수를 사용 하면 됨
-- 파라미터 pwindow는 툴팁을 적용 시키고 싶은 윈도우, text는 툴팁에 사용하는 텍스트, 툴팁 테두리의 사이즈

local guiSystem = CEGUI.System:getSingleton();
local winMgr = CEGUI.WindowManager:getSingleton();
local root = winMgr:getWindow("DefaultWindow");

-- 총 백개의 배열
--[[
CurTooltipStr =
{['protecterr'] = 0, 
'none', 'none', 'none', 'none', 'none',		-- 1
'none', 'none', 'none', 'none', 'none',		-- 2
'none', 'none', 'none', 'none', 'none',		-- 3
'none', 'none', 'none', 'none', 'none',		-- 4
'none', 'none', 'none', 'none', 'none',		-- 5
'none', 'none', 'none', 'none', 'none',		-- 6
'none', 'none', 'none', 'none', 'none',		-- 7
'none', 'none', 'none', 'none', 'none',		-- 8
'none', 'none', 'none', 'none', 'none',		-- 9
'none', 'none', 'none', 'none', 'none'		-- 10
}

g_PracticeScnState = SCN_MAIN_MENU;
g_TotorialSeq = TUTORIAL_SEQ_WELCOME;
g_ScreenWidth = 1024;
g_ScreenHeight = 768;

-- Back_easeIn 함수 쓰는 방법 
-- ex) Back_easeIn(t, b, c, d, s)
-- t(time)			: 현재 시간(0.0과 _dd(duration) 사이 값을 가져야 한다.)
-- b(begin value)	: 변화시킬 값의 초기 좌표
-- c(change value)	: 목표 지점의 좌표
-- d(duration)		: 목표 지점까지 가는데 걸리는 시간
-- s()				: 모하는 건지 모르겠음
-- 실제 쓰는 예
-- Back_easeIn(0.1, 5.0, 10, 2.0, 0);
-- x = g_ReturnValue



function InitCurTooltipStr()
	for i=1, #CurTooltipStr do
		CurTooltipStr[i] = 'none';	
	end
end

function SettingCurTooltipStr(tooltip_text)
	--Lua_DebugStr('SettingCurTooltipStr start');
	--Lua_DebugStr('tooltip_text : ' .. tooltip_text);
	local local_line = tooltip_text;
	for i=1, #CurTooltipStr do
		local local_find_i,local_find_j  = string.find(local_line, '\n');
		--Lua_DebugStr( tostring(i)..'  local_find_i : '..tostring(local_find_i)..', local_find_j : '..tostring(local_find_j) );
		if local_find_i ~= nil then	-- 패턴이 있으면
			--Lua_DebugStr('---------- if in -----------');
			local local_cur_line = string.sub(1, local_find_i);	-- 배열에 담을 현재 라인을 가져 온다.
			--Lua_DebugStr('local_cur_line : ' .. local_cur_line);
			local_line = string.sub(local_find_j, string.len(local_line));	-- 현재 자른 라인 빼고 담는다.
			--Lua_DebugStr('local_line : ' .. local_line);
			CurTooltipStr[i] = local_cur_line;
		else
			CurTooltipStr[i] = 'none';
		end
	end
	--Lua_DebugStr('SettingCurTooltipStr end');
end
]]--

function SetReturnValue(args)
	g_ReturnValue = args;
end

--[[
function Back_easeIn(t, b, c, d, s)
	if s == 0 then
		s = 1.70158;
	end
	--return c * (t /= d) * t * ((s + 1) * t - s) + b;
	local_value = t / d;
	g_ReturnValue = c * (local_value) * local_value * ((s + 1) * local_value - s) + b;
end
]]--

function Linear_easeNone(t, b, c, d)
	--return c * (t /= d) * t * ((s + 1) * t - s) + b;
	g_ReturnValue = c * t / d + b;
end

-- 0 ~ 255
g_tooltip_alpha = 0;
g_tooltip_frame = 0;

-- 글로벌 툴팁을 그린다.
function renderGlobalTooltip(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if g_ToolTipTargetWindow ~= nil then
		local sizex = tonumber( g_ToolTipTargetWindow:getUserString('sizex') );
		local sizey = tonumber( g_ToolTipTargetWindow:getUserString('sizey') );
		local text_off_x = 5;
		local text_off_y = 5;
		local dx = tonumber(g_ToolTipTargetWindow:getUserString('mouse_x'));
		local dy = tonumber(g_ToolTipTargetWindow:getUserString('mouse_y'));
		
		-- 범위를 못 넘어가게 위치를 조정 해준다.
		if dx + sizex > (1024-12) then
			dx = dx - ((dx + sizex) - 1024);
			dx = dx - 12;
		end
		if dx < 0 then
			dx = 0;
		end
				
		if dy + sizey > (768-12) then
			dy = dy - ( (dy + sizey) - 768);
			dy = dy - 12;
		end
		if dy < 0 then
			dy = 0;
		end
		
		
		local_window:setSize(sizex, sizey);
		local_window:setPosition(dx+10, dy+10);
		
		drawer = local_window:getDrawer();
		drawer:setTextColor(0,0,0,255);		
		Linear_easeNone(g_tooltip_frame, 0, 190, 50);
		g_tooltip_alpha = g_ReturnValue;
		
		g_tooltip_frame = g_tooltip_frame + 1;
		if g_tooltip_frame > 50 then
			g_tooltip_frame = 50;
		end
		
		--drawer:drawTextureA('UIData/tooltip.tga', 0, 0, sizex, sizey, 0, 0, g_tooltip_alpha);
		drawer:drawText( g_ToolTipTargetWindow:getTooltipText(), text_off_x, text_off_y );
	end
end

-- 마우스가 움직였을때
function OnMouseMove(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if local_window:getUserString('Visible') == 'true' then
		local local_pos_x = CEGUI.toMouseEventArgs(args).position.x;
		local local_pos_y = CEGUI.toMouseEventArgs(args).position.y;
		local_window:setUserString('mouse_x', tostring(local_pos_x));
		local_window:setUserString('mouse_y', tostring(local_pos_y));
	end
end

-- 마우스가 윈도우를 들어갔을때
function OnMouseEnter(args)
	winMgr:getWindow('CommonAlphaPage5'):setProperty('Visible' ,'true');
	local local_window = CEGUI.toWindowEventArgs(args).window;
	--InitCurTooltipStr();
	--SettingCurTooltipStr(local_window:getTooltipText());
	
	g_ToolTipTargetWindow = local_window;
	local local_pos_x = CEGUI.toMouseEventArgs(args).position.x;
	local local_pos_y = CEGUI.toMouseEventArgs(args).position.y;
	local_window:setUserString('Visible', 'true');
	
	local local_window_pos = local_window:getPosition(); -- 윈도우의 위치를 얻어 온다.
	--Lua_DebugStr( 'local_window_pos_x : '..tostring(local_window_pos.x.offset) );
	--Lua_DebugStr( 'local_window_pos_y : '..tostring(local_window_pos.y.offset) );
	
	local_window:setUserString('offset_mouse_x', tostring(local_pos_x-local_window_pos.x.offset));
	local_window:setUserString('offset_mouse_y', tostring(local_pos_y-local_window_pos.y.offset));
	
	local_window:setUserString('mouse_x', tostring(local_pos_x));
	local_window:setUserString('mouse_y', tostring(local_pos_y));
	
	g_tooltip_alpha = 0;
	g_tooltip_frame = 0;
end

-- 마우스가 윈도우를 떠났을때
function OnMouseLeave(args)
	winMgr:getWindow('CommonAlphaPage5'):setProperty('Visible' ,'false');
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local_window:setUserString('Visible', 'false');
	g_ToolTipTargetWindow = nil;
end


-- align으로 지정 할 수 있게끔한다. up, center, down
-- tooltip이 밖으로 나갔을때 조정한다.
function RegisterTooltipText(pwindow, text, sizex, sizey)
	--pwindow:setUserString('Visible', 'false');
	--pwindow:setUserString('FontHeight', tostring(font_height));
	--pwindow:setUserString('sizex', tostring(sizex));
	--pwindow:setUserString('sizey', tostring(sizey));
	--pwindow:setTooltipText(text);
	--pwindow:subscribeEvent('MouseEnter', 'OnMouseEnter');
	--pwindow:subscribeEvent('MouseLeave', 'OnMouseLeave');
	--pwindow:subscribeEvent('MouseMove', 'OnMouseMove');
	--pwindow:subscribeEvent('EndRender', 'renderTooltip');
end




-- 완전 빈 사이즈가 1인 알파 스태틱 이미지 -------------------------------------------------------------------------
tWinAlphaPageName = {['protecterr'] = 0, 'CommonAlphaPage5'}
tTextureX = {['protecterr'] = 0, 0}
tTextureY = {['protecterr'] = 0, 0}
tSizeX = {['protecterr'] = 0, 1}
tSizeY = {['protecterr'] = 0, 1}
tPosX = {['protecterr'] = 0, 0}
tPosY = {['protecterr'] = 0, 0}

for i=1, #tWinAlphaPageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinAlphaPageName[i]);
	mywindow:setSize(tSizeX[i], tSizeY[i]);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setProperty("FrameEnabled", "falaw");
	mywindow:setProperty("BackgroundEnabled", "false");

	mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", tTextureX[i], tTextureY[i]);
	mywindow:setProperty("AlwaysOnTop", "true");
	mywindow:setZOrderingEnabled(true);
	mywindow:setProperty('Visible', 'true');
	mywindow:subscribeEvent('EndRender', 'renderGlobalTooltip');
	root:addChildWindow(mywindow);
end


