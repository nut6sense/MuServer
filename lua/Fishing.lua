--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)



------------------------------------------------------------------
-- 낚시 시작
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "StartFishingTest")
mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 0, 588)
mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 0, 616)
mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 0, 644)
mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 0, 588)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 0, 672)
--mywindow:setWideType(4);
--mywindow:setPosition(934, 647)
mywindow:setSize(86, 28)
mywindow:setVisible(false)
mywindow:setSubscribeEvent("Clicked", "OnClickStartFishing")
root:addChildWindow(mywindow)

------------------------------------------------------------------
-- 낚시 종료
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "EndFishingTest")
mywindow:setTexture("Normal", "UIData/blackfadein.tga", 510, 312)
mywindow:setTexture("Hover", "UIData/blackfadein.tga", 510, 344)
mywindow:setTexture("Pushed", "UIData/blackfadein.tga", 510, 376)
mywindow:setTexture("PushedOff", "UIData/debug_b.tga", 510, 408)
mywindow:setPosition(620, 500)
mywindow:setSize(100, 25)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickEndFishing")
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "EndFishingTestText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(9, 10)
mywindow:setText("Fishing End")
mywindow:setSize(5, 5)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("EndFishingTest"):addChildWindow(mywindow)

fishingtypevalue = 1
function OnClickStartFishing()
	StartFishing(fishingtypevalue)
end

function OnClickEndFishing()
	EndFishing(fishingtypevalue)
end

------------------------------------------
-- 낚시 아이템
------------------------------------------

--오른손( posx, posy, posz, rotx, roty, rotz  rot는 *10의 값)
local tRightFishingAniPos_BM = {['err'] = 0, -3, 12, -2, 10, 10, 15}
local tRightFishingAniPos_MM = {['err'] = 0, -2, 10, -1, 10, 10, 15}
local tRightFishingAniPos_SM = {['err'] = 0, -3, 8, -2, 10, 10, 15}
local tRightFishingAniPos_BW = {['err'] = 0, -3, 10, -1 , 10, 10, 15}
local tRightFishingAniPos_MW = {['err'] = 0, -2, 9, -1, 10, 10, 15}
local tRightFishingAniPos_SW = {['err'] = 0, -1, 7, -1, 10, 10, 15}
local tRightFishingAniPostable = {['err'] = 0, [0]=tRightFishingAniPos_BM, tRightFishingAniPos_MM, tRightFishingAniPos_SM, tRightFishingAniPos_BW, tRightFishingAniPos_MW, tRightFishingAniPos_SW} 

--왼손
local tLeftFishingAniPos_BM = {['err'] = 0, 3, 12, -1 , 1, 10, 16}
local tLeftFishingAniPos_MM = {['err'] = 0, -2, 9, 1 ,  1, 10, 15}
local tLeftFishingAniPos_SM = {['err'] = 0, 3, 9, -1 ,  1, 10, 15}
local tLeftFishingAniPos_BW = {['err'] =0, 2, 10, -1 ,  1, 10, 15}
local tLeftFishingAniPos_MW = {['err'] =0,  2, 9, 1 ,  1, 10, 15}
local tLeftFishingAniPos_SW = {['err'] =0, 1, 8, -1,  1, 10, 15}
local tLeftFishingAniPostable = {['err'] = 0, [0]=tLeftFishingAniPos_BM, tLeftFishingAniPos_MM, tLeftFishingAniPos_SM, tLeftFishingAniPos_BW, tLeftFishingAniPos_MW, tLeftFishingAniPos_SW} 

--scale ( 스케일은*10의 값)
local tBoneFishingScale = {['err'] = 0, 7, 5, 5, 6, 5, 5}

------------------------------------------------------------------
-- 낚시 아이템 붙이는 위치 설정
------------------------------------------------------------------
function SettingFishingAttachPos(key, boneType)
	
	DebugStr('boneType:'..boneType)
	local RightPosx			= tRightFishingAniPostable[boneType][1]
	local RightPosy			= tRightFishingAniPostable[boneType][2]
	local RightPosz			= tRightFishingAniPostable[boneType][3]
	local RightRotx			= tRightFishingAniPostable[boneType][4]
	local RightRoty			= tRightFishingAniPostable[boneType][5]
	local RightRotz			= tRightFishingAniPostable[boneType][6]
	
	local LeftPosx			= tLeftFishingAniPostable[boneType][1]
	local LeftPosy			= tLeftFishingAniPostable[boneType][2]
	local LeftPosz			= tLeftFishingAniPostable[boneType][3]
	local LeftRotx			= tLeftFishingAniPostable[boneType][4]
	local LeftRoty			= tLeftFishingAniPostable[boneType][5]
	local LeftRotz			= tLeftFishingAniPostable[boneType][6]
	local FishingRodScale	= tBoneFishingScale[boneType+1]
	
	SetFishingAniPos(key, RightPosx, RightPosy, RightPosz , LeftPosx, LeftPosy, LeftPosz , RightRotx, RightRoty, RightRotz, LeftRotx, LeftRoty, LeftRotz, FishingRodScale)
	
end

-- 낚시중 게이지
function ShowFishGaegebar(screenX, screenY, DeltaTime, Maxtime, digtype)
	local drawer = winMgr:getWindow("DefaultWindow"):getDrawer()
	screenX = 451
	local gaegeX = 117 * DeltaTime / Maxtime
	
	-- 게이지 바탕
	drawer:drawTexture("UIData/fishing.tga", screenX, screenY, 121, 13, 0, 120, WIDETYPE_5)
	-- 게이지
	drawer:drawTexture("UIData/fishing.tga", screenX+1, screenY+1, gaegeX, 9, 0, 133, WIDETYPE_5)
	
	-- 더블일때.
	if digtype > 2 then
		-- 게이지 바탕
		drawer:drawTexture("UIData/fishing.tga", screenX, screenY + 17, 121, 13, 0, 120, WIDETYPE_5)
		-- 게이지
		drawer:drawTexture("UIData/fishing.tga", screenX+1, screenY+18, gaegeX, 9, 0, 133, WIDETYPE_5)
	end

	if digtype == 4 then
		-- 게이지 바탕
		drawer:drawTexture("UIData/fishing.tga", screenX, screenY + 34, 121, 13, 0, 120, WIDETYPE_5)
		-- 게이지
		drawer:drawTexture("UIData/fishing.tga", screenX+1, screenY + 35, gaegeX, 9, 0, 133, WIDETYPE_5)
	end
end

----------------------------------------------------------------------------------
---  낚시 불가능 지역 알림글
----------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FishingNoticeImage")
mywindow:setTexture("Enabled", "UIData/fishing.tga", 0, 220)
mywindow:setTexture("Disabled", "UIData/fishing.tga", 0, 220)
mywindow:setWideType(6);
mywindow:setPosition(400, 500)
mywindow:setSize(256,36)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:addController("FishingNoticeMotion", "FishingNoticeMotion", "alpha", "Linear_EaseNone", 255,255 , 10, true, false, 10)
mywindow:addController("FishingNoticeMotion", "FishingNoticeMotion", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)

function ShowFishingNotice()
	winMgr:getWindow("FishingNoticeImage"):setVisible(true)
	winMgr:getWindow("FishingNoticeImage"):activeMotion("FishingNoticeMotion")
end

--[[
----------------------------------------------------------------------------------
---  이모티콘 표시
----------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "FishingEmoticonImage")
mywindow:setTexture("Enabled", "UIData/fishing.tga", 183, 0)
mywindow:setTexture("Disabled", "UIData/fishing.tga", 183, 0)
mywindow:setPosition(400, 500)
mywindow:setSize(52,52)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow:addController("FishingNoticeMotion", "FishingNoticeMotion", "alpha", "Linear_EaseNone", 255,255 , 10, true, false, 10)
mywindow:addController("FishingNoticeMotion", "FishingNoticeMotion", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)

function ShowFishingEmoticon()
	winMgr:getWindow("FishingEmoticonImage"):setVisible(true)
	winMgr:getWindow("FishingEmoticonImage"):activeMotion("FishingNoticeMotion")
end
--]]

function ShowFishingEmoticon(boneType, x, y, bGetItem)
	--DebugStr('bGetItem:'..bGetItem)
	local offset = 0
	if boneType == 2 or boneType == 5 then		-- 소
		offset = 26
	elseif boneType == 1 or boneType == 4 then
		offset = 15
	end
	if bGetItem == 1 then
		drawer:drawTextureSA("UIData/fishing.tga", x+35, y+offset-50, 52, 52, 79, 0, 255, 255, 255, 0, 0)
	else
		drawer:drawTextureSA("UIData/fishing.tga", x+35, y+offset-50, 52, 52, 183, 0, 255, 255, 255, 0, 0)
	end
end


function ShowFishingAreaToUi(screenX, screenY)
	drawer:drawTexture("UIData/fishing.tga", screenX, screenY, 5, 5, 0, 120, WIDETYPE_6)
end
