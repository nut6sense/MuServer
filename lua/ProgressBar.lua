-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr = CEGUI.WindowManager:getSingleton()
local root = winMgr:getWindow("DefaultWindow")

g_ProgressTick		= -1;
g_CurrProgressTick	= -1;
g_PrevProgressTick	= -1;
g_delta_tick		= 0;
g_MaxDelta			= 5350;
g_Delta				= 0;

function SetTick(args)
	g_ProgressTick = args;
end

g_ProgressBarX = 1024/2-38;
g_ProgressBarY = 784/2-20;

g_progress_cnt = 10;

function UseTooltip(args)
	if args == 'true' then
	else
	end
end

function renderProgressBar(args)
	GetTick();
	g_CurrProgressTick = g_ProgressTick + g_Delta;
	if g_delta_tick < g_MaxDelta then
		g_delta_tick = g_CurrProgressTick - g_PrevProgressTick;
	end
			
	if g_delta_tick > (g_MaxDelta-1) then
		winMgr:getWindow('CommonAlphaPage3'):setProperty('Visible', 'false');
		winMgr:getWindow('ProgressWindow'):setProperty('Visible', 'false');
	end
	
	drawer = winMgr:getWindow('ProgressWindow'):getDrawer();
	drawer:setFont(g_STRING_FONT_GULIM, 13);
	drawer:setTextColor(255,0,0,255);
	drawer:drawTextureA("UIData/createquestpopup001.tga",g_ProgressBarX, g_ProgressBarY, 135, 50, 0, 784, 222)
	g_progress_cnt = g_progress_cnt + 5;
	--drawer:drawText("진행률 : "..tostring( math.floor((g_delta_tick/g_MaxDelta)*10)*10).."%", g_ProgressBarX+9, g_ProgressBarY+17 );
	drawer:drawText("진행률 : "..tostring(g_progress_cnt), g_ProgressBarX+9, g_ProgressBarY+17 );
end

function ShowProgressWindow()
	-- 당연히 -1일 것이다.
	if g_PrevProgressTick == -1 then
		GetTick();
		g_PrevProgressTick = g_ProgressTick;
		--winMgr:getWindow('CommonAlphaPage3'):setProperty('Visible', 'true');
		winMgr:getWindow('ProgressWindow'):setProperty('Visible', 'true');
	end
end


function HideProgressWindow()
	winMgr:getWindow('ProgressWindow'):setProperty('Visible', 'false');
	--GetTick();
	-- 100 넘겨버리면 바로 사라지지 않게 하기 위해 약간 완료 전 타이밍을 준다. 2 프레임 정도 더 돌 수 있게.
	--local local_orinal_delta = g_MaxDelta + g_PrevProgressTick;
	--local local_cur_delta = g_delta_tick + g_PrevProgressTick;
	--Lua_DebugStr('local_orinal_delta : ' .. tostring(local_orinal_delta));
	--Lua_DebugStr('local_cur_delta : ' .. tostring(local_cur_delta));
	--g_Delta = (local_orinal_delta - local_cur_delta) - 2800;
	--Lua_DebugStr('HideProgressWindow end');
end

-- 프로그래스 바 알파 스태틱 이미지 -------------------------------------------------------------------------
tProgressWinAlphaName = {['protecterr'] = 0, 'CommonAlphaPage3'}
tTextureX = {['protecterr'] = 0, 0}
tTextureY = {['protecterr'] = 0, 0}
tSizeX = {['protecterr'] = 0, 1920}
tSizeY = {['protecterr'] = 0, 1200}
tPosX = {['protecterr'] = 0, 0}
tPosY = {['protecterr'] = 0, 0}

for i=1, #tProgressWinAlphaName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tProgressWinAlphaName[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setProperty("FrameEnabled", "false")	
	mywindow:setProperty("BackgroundEnabled", "false")	

	mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", tTextureX[i], tTextureY[i])
	mywindow:setProperty("AlwaysOnTop", "true")
	mywindow:setZOrderingEnabled(false)
	--mywindow:setProperty('Visible', 'false')
	root:addChildWindow(mywindow)
	
end


mywindow = winMgr:createWindow("TaharezLook/StaticText", "ProgressWindow");
mywindow:setProperty("FrameEnabled", False);
mywindow:setProperty("BackgroundEnabled", False);
mywindow:setText("");
mywindow:setPosition(0,  0);
mywindow:setSize(1024,768);
mywindow:setText(text);
mywindow:setFont(g_STRING_FONT_GULIM, 20);
mywindow:setTextColor(255,0,0,255);
mywindow:subscribeEvent("EndRender", "renderProgressBar" )
--winMgr:getWindow('CommonAlphaPage3'):addChildWindow(mywindow);
root:addChildWindow(mywindow);

winMgr:getWindow('CommonAlphaPage3'):setProperty('Visible', 'false');
winMgr:getWindow('ProgressWindow'):setProperty('Visible', 'false');
