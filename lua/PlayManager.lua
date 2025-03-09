-----------------------------------------
-- Script Entry Point
-----------------------------------------






-- 알림 메세지 보이기
function PlayManger_ShowBackground()

	local winMgr	= CEGUI.WindowManager:getSingleton()
	local root		= winMgr:getWindow("DefaultWindow")
	local drawer	= root:getDrawer()

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIM, 12)
	drawer:drawTexture("UIData/OnDLGBackImage.tga", 0, 0, 1920, 1200, 0, 0)
	drawer:drawTexture("UIData/popup001.tga", 350, 240, 346, 275, 0, 0)
	drawer:drawText("다른 플레이어를 기다리고 있습니다.", 414, 320)

end



-- 알림 메세지 보이기
function PlayManger_ShowText(index, count, str, remainSecond)

	local winMgr	= CEGUI.WindowManager:getSingleton()
	local root		= winMgr:getWindow("DefaultWindow")
	local drawer	= root:getDrawer()
	
	drawer:setTextColor(255, 205, 86, 255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 112)
	drawer:drawText(str, 430, 346+16*count)
	drawer:drawText(remainSecond, 582, 346+16*count)
		
end









