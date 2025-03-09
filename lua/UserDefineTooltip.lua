-- ��� ���
-- executeScriptFile �Ҷ� �� �� ������ ���� �������� �ϴ� �� ����
-- �ֳ� �ϸ� root�� ���� ���߿� �ٿ��� ���� �������� ������ �׸� ���ִ�.
-- CEGUI::System::getSingleton().executeScriptFile("UserDefineTooltip.lua"); ��Ƹ� �����Ű��
-- RegisterTooltipText(pwindow, text, sizex, sizey) �� �Լ��� ��� �ϸ� ��
-- �Ķ���� pwindow�� ������ ���� ��Ű�� ���� ������, text�� ������ ����ϴ� �ؽ�Ʈ, ���� �׵θ��� ������

local guiSystem = CEGUI.System:getSingleton();
local winMgr = CEGUI.WindowManager:getSingleton();
local root = winMgr:getWindow("DefaultWindow");

-- �� �鰳�� �迭
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

-- Back_easeIn �Լ� ���� ��� 
-- ex) Back_easeIn(t, b, c, d, s)
-- t(time)			: ���� �ð�(0.0�� _dd(duration) ���� ���� ������ �Ѵ�.)
-- b(begin value)	: ��ȭ��ų ���� �ʱ� ��ǥ
-- c(change value)	: ��ǥ ������ ��ǥ
-- d(duration)		: ��ǥ �������� ���µ� �ɸ��� �ð�
-- s()				: ���ϴ� ���� �𸣰���
-- ���� ���� ��
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
		if local_find_i ~= nil then	-- ������ ������
			--Lua_DebugStr('---------- if in -----------');
			local local_cur_line = string.sub(1, local_find_i);	-- �迭�� ���� ���� ������ ���� �´�.
			--Lua_DebugStr('local_cur_line : ' .. local_cur_line);
			local_line = string.sub(local_find_j, string.len(local_line));	-- ���� �ڸ� ���� ���� ��´�.
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

-- �۷ι� ������ �׸���.
function renderGlobalTooltip(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if g_ToolTipTargetWindow ~= nil then
		local sizex = tonumber( g_ToolTipTargetWindow:getUserString('sizex') );
		local sizey = tonumber( g_ToolTipTargetWindow:getUserString('sizey') );
		local text_off_x = 5;
		local text_off_y = 5;
		local dx = tonumber(g_ToolTipTargetWindow:getUserString('mouse_x'));
		local dy = tonumber(g_ToolTipTargetWindow:getUserString('mouse_y'));
		
		-- ������ �� �Ѿ�� ��ġ�� ���� ���ش�.
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

-- ���콺�� ����������
function OnMouseMove(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if local_window:getUserString('Visible') == 'true' then
		local local_pos_x = CEGUI.toMouseEventArgs(args).position.x;
		local local_pos_y = CEGUI.toMouseEventArgs(args).position.y;
		local_window:setUserString('mouse_x', tostring(local_pos_x));
		local_window:setUserString('mouse_y', tostring(local_pos_y));
	end
end

-- ���콺�� �����츦 ������
function OnMouseEnter(args)
	winMgr:getWindow('CommonAlphaPage5'):setProperty('Visible' ,'true');
	local local_window = CEGUI.toWindowEventArgs(args).window;
	--InitCurTooltipStr();
	--SettingCurTooltipStr(local_window:getTooltipText());
	
	g_ToolTipTargetWindow = local_window;
	local local_pos_x = CEGUI.toMouseEventArgs(args).position.x;
	local local_pos_y = CEGUI.toMouseEventArgs(args).position.y;
	local_window:setUserString('Visible', 'true');
	
	local local_window_pos = local_window:getPosition(); -- �������� ��ġ�� ��� �´�.
	--Lua_DebugStr( 'local_window_pos_x : '..tostring(local_window_pos.x.offset) );
	--Lua_DebugStr( 'local_window_pos_y : '..tostring(local_window_pos.y.offset) );
	
	local_window:setUserString('offset_mouse_x', tostring(local_pos_x-local_window_pos.x.offset));
	local_window:setUserString('offset_mouse_y', tostring(local_pos_y-local_window_pos.y.offset));
	
	local_window:setUserString('mouse_x', tostring(local_pos_x));
	local_window:setUserString('mouse_y', tostring(local_pos_y));
	
	g_tooltip_alpha = 0;
	g_tooltip_frame = 0;
end

-- ���콺�� �����츦 ��������
function OnMouseLeave(args)
	winMgr:getWindow('CommonAlphaPage5'):setProperty('Visible' ,'false');
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local_window:setUserString('Visible', 'false');
	g_ToolTipTargetWindow = nil;
end


-- align���� ���� �� �� �ְԲ��Ѵ�. up, center, down
-- tooltip�� ������ �������� �����Ѵ�.
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




-- ���� �� ����� 1�� ���� ����ƽ �̹��� -------------------------------------------------------------------------
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


