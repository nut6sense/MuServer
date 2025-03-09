-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()



local g_QUESTRESULT_1 = PreCreateString_1355	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_1)	-- ü�轺ų�� �����ؾ� ����� �� �ִ� \n��ų�� �̸� ü���ϰ� ���ִ� ������\n�Դϴ�.
local g_QUESTRESULT_2 = PreCreateString_1356	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_2)	-- ���� �������� ���� �м��뿷�� �ִ�\n�����̵���� ��Ű���� ������ �ָ�\n���� �����۵�� ��ȯ�� �����մϴ�.
local g_QUESTRESULT_4 = PreCreateString_1358	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_4)	-- �����Կ��� Ȯ���ϼ���.
local g_QUESTRESULT_5 = PreCreateString_1359	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_5)	-- ���� �������� ���� �м��뿷�� �ִ�\n�����̵� ���� ��Ű���� ������ �ָ�\n���� �����۵�� ��ȯ�� �����մϴ�.
local g_QUESTRESULT_6 = PreCreateString_1357	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_3)	-- Ŭ����
local g_QUESTRESULT_7 = PreCreateString_2341	--GetSStringInfo(LAN_LUCKY_FIGHTER_SUCCESS)			-- ��Ű ������ ����! 
local g_QUESTRESULT_8 = PreCreateString_2343	--GetSStringInfo(LAN_LUCKY_FIGHTER_ATTAINMENT)			-- %d��° ��Ű �����Ͱ� �Ǽ̽��ϴ� 
local g_QUESTRESULT_9 = PreCreateString_2340	--GetSStringInfo(LAN_LUCKY_FIGHTER_REWARD)				-- "%s"�� ���޵˴ϴ� 
local g_QUESTRESULT_10= PreCreateString_2342	--GetSStringInfo(LAN_LUCKY_FIGHTER_FAIL)				-- ��Ű ������ ����! 
local g_QUESTRESULT_11= PreCreateString_2344	--GetSStringInfo(LAN_LUCKY_FIGHTER_COUNT_NOTIFY)		-- ����� ��Ű ī��Ʈ�� %d �Դϴ� 
local g_QUESTRESULT_12= PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- �ٽ� ������ ������!

------------------------------------------------------------

-- ��� �̹���

------------------------------------------------------------
local g_characterInfoWindowsPosY = 636
function WndQuestResult_RenderBackImage()

	drawer:drawTexture("UIData/hunting_002.tga", 103, g_characterInfoWindowsPosY+10, 402, 80, 440, 755, WIDETYPE_6)	  -- ĳ���� ����â
	drawer:drawTexture("UIData/hunting_002.tga", 103, g_characterInfoWindowsPosY+95, 803, 27, 221, 715, WIDETYPE_6)	  -- ����ġ ������
	
end


-- ��Ű ī��Ʈ â ����
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountTextBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(361, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end

TexXTable = {['err']=0, [0]=431, 878}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountItemBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(86, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end
local bLuckyCountEffectOnce = true
local bLuckyCountEffectVisible = true


	
	
	
------------------------------------------------------------

-- �ɸ��� ���� �׸���

------------------------------------------------------------
tResultTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
local g_increaseExp = 0
local g_levelTable  = 0
local g_successShow = false
local g_buffExpTime = 0
local g_buffZenTime = 0


function WndHuntingResult_RenderCharacterInfo(level, name, style, exp, expPercent, increaseExp, levelTable, gran, bSuccess, ladder, 
currentCoin, deltaTime, resultState, Mylife, HPPotion, MPPotion, promotion, attribute)
											
	g_increaseExp = increaseExp
	g_levelTable  = levelTable
	
	local infoY = g_characterInfoWindowsPosY+24
	
	-- ����	
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText(level, 172, infoY, WIDETYPE_6)
	
	-- ����
	--drawer:drawTexture("UIData/numberUi001.tga", 142, infoY-6, 47, 21, 113, 600+21*ladder)
	
	-- ��Ÿ��
	drawer:drawTexture("UIData/Skill_up2.tga", 156, infoY+34,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute], WIDETYPE_6)
	drawer:drawTexture("UIData/Skill_up2.tga", 156, infoY+34,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion], WIDETYPE_6)
	
	-- �̸�
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(name))
	drawer:drawText(name, 180-nameSize/2, infoY+25, WIDETYPE_6)
	
	
	-- ����ġ %����
	local percent = 0
	if g_levelTable > 0 then
		-- ��
		--0426KSG����
		--if IsEngLanguage() or IsKoreanLanguage() then

		if IsKoreanLanguage() then
			percent = increaseExp*100/levelTable
		else
			percent = exp*100/levelTable
		end
		
	end
	drawer:setTextColor(255,255,255,255)
	-- ����ġ ������
	drawer:drawTexture("UIData/hunting_002.tga", 124, infoY+78, expPercent, 13, 221, 742, WIDETYPE_6)
	drawer:drawText(percent .. " %", 604, infoY+80, WIDETYPE_6)
	-- ����ġ ���±���
	drawer:setTextColor(255,255,255,255)
	
	-- ��
	local currentExpText
	
	--0426KSG ����
	--if IsEngLanguage() or IsKoreanLanguage() then
	if IsKoreanLanguage() then
		currentExpText = increaseExp .. "  /  " ..  levelTable
	else
		currentExpText = exp .. "  /  " ..  levelTable
	end
	
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, infoY+80, WIDETYPE_6)
	
	-- �׶�
	--gran = 10000000000
	local szMyGran = CommatoMoneyStr64(gran)
	r,g,b = GetGranColor(gran)
	drawer:setTextColor(r,g,b,255)	
	local granSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyGran)
	drawer:drawText(szMyGran, 490-granSize, infoY+22, WIDETYPE_6)
	
	-- ������
	local MylifeSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, Mylife)
	drawer:drawText(Mylife, 490-MylifeSize, infoY, WIDETYPE_6)
	
	-- HP����
	local HPPotionSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, HPPotion)
	drawer:drawText(HPPotion, 405-HPPotionSize, infoY+46, WIDETYPE_6)
	
	-- MP����
	local MPPotionSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, MPPotion)
	drawer:drawText(MPPotion, 490-MPPotionSize, infoY+46, WIDETYPE_6)
end



------------------------------------------------------------

-- 1. ���׸���(����, ���ʽ�, ����â)

------------------------------------------------------------
local g_dungeonResultX = 200
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_qeustResult_stampResult")
mywindow:setWideType(6)
mywindow:setPosition(g_dungeonResultX, 200)
mywindow:setSize(430, 150)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/quest1.tga", 594, 159)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):setAlign(1)


local g_backImageTime	= 0
local g_backImagePosX	= 1920
local g_backImagePosY	= 30
local g_backImageFlag	= 0
local g_backImageSound  = true

local g_successState	= 0
local g_successSound	= true
tSuccessY = { ["err"]=0, [0]=159, 0}

local g_min			= 0
local g_sec			= 0
local g_milliSec	= 0


function WndHuntingResult_Show1stBackImage(bSuccess, deltaTime, min, sec, milliSec)
	
	if deltaTime < 0 then
		return
	end
	
	g_backImageTime = g_backImageTime + deltaTime
	
	-- ���� or ����
	if g_successState == 0 then
		if g_backImageTime >= 1300 then
			if g_successSound then
				PlaySound("sound/Dungeon/Dungeon_Result_Grade.wav")
				g_successSound = false
				g_successShow  = true
			end
		
			if g_backImageTime >= 2200 then
				g_successState = 1
			end			
		end
	else

	end

	local show = 0
	if g_backImageTime >= 1500 then
		if g_backImageSound then
			PlaySound("sound/Dungeon/Dungeon_Result_Window.wav")
			g_backImageSound = false
		end
		g_backImagePosX, g_backImageFlag, show = Effect_Circular_EaseOut(g_backImageTime-1500, 1300, -1100, 300, 417, g_backImageFlag)
	end
	

	drawer:drawTexture("UIData/Hunting_002.tga", g_backImagePosX-150, g_backImagePosY, 663, 691, 361, 0, WIDETYPE_6)  -- ��� �ִϸ��̼� ���
	
	-- Ŭ���� Ÿ��
	g_min = min
	g_sec = sec
	g_milliSec = milliSec

	ShowClearTime(g_backImagePosX, g_min, g_sec, g_milliSec)
	
	if show == 1 then
		IncreaseStateCount()
		
	-- ��ũ���������� �ð��� �����ɰ�� �Ѿ�� �Ѵ�.
	elseif g_backImageTime >= 2000 then
		g_backImagePosX = 417
		IncreaseStateCount()
	end
	
end


function ShowClearTime(g_backImagePosX, min, sec, milliSec)

	-- Ŭ���� �ð�
	local startPos1	= 300
	local startPos2	= startPos1 + 22
	local timePosY	= g_backImagePosY+480

	-- minute
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1, timePosY, 38, 26, tResultTime[min/10], 192, WIDETYPE_6)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2, timePosY, 38, 26, tResultTime[min%10], 192, WIDETYPE_6)
	
	-- ' �� :
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+23, timePosY, 16, 26, 891, 192, WIDETYPE_6)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+30, timePosY, 16, 26, 870, 192, WIDETYPE_6)
	
	
	-- second
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1+65, timePosY, 38, 26, tResultTime[sec/10], 192, WIDETYPE_6)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+65, timePosY, 38, 26, tResultTime[sec%10], 192, WIDETYPE_6)
	
	-- ' �� .
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+23+65, timePosY, 16, 26, 891, 192, WIDETYPE_6)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+30+65, timePosY+13, 16, 13, 870, 205, WIDETYPE_6)
	
	
	-- milli second
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1+130, timePosY, 38, 26, tResultTime[milliSec/10], 192, WIDETYPE_6)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+130, timePosY, 38, 26, tResultTime[milliSec%10], 192, WIDETYPE_6)
	
	-- "
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+24+130, timePosY, 16, 26, 911, 192, WIDETYPE_6)
	
end




------------------------------------------------------------

-- 2. ���� ���� �׸���

------------------------------------------------------------

function WndHuntingResult_ShowIncreaseScore(KillNPC, killNPCBonus, gainedEXP, gainedZen , gainedItem, bossKillCount)

	-- 1. ���׸���(����, ���ʽ�, ����â)
	drawer:drawTexture("UIData/Hunting_002.tga", g_backImagePosX-150, g_backImagePosY, 663, 691, 361, 0, WIDETYPE_6)
	-- Ŭ���� �ð�
	ShowClearTime(g_backImagePosX, g_min, g_sec, g_milliSec)
		
	local _infoX = g_backImagePosX + 144
	local _left, _right
	
	--�Ű�����(�����̸�, ����, ���Ĺ��, x, y, �ؽ���x, �ؽ���y, ������x, ������y, �ؽ��� ����)			
	--DrawEachNumberWide("UIData/dungeonmsg.tga", killNPCBonus , 2, g_backImagePosX+368, 143, 286, 779, 18, 26, 29, WIDETYPE_6)	-- ī���� ���ʽ�
	
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainedEXP, 2, g_backImagePosX+368,		196, 286, 779, 18, 26, 29, WIDETYPE_6)	-- EXP
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainedZen, 2, g_backImagePosX+368,		259, 286, 779, 18, 26, 29, WIDETYPE_6)	-- ZEN
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainedItem, 2, g_backImagePosX+368,		322, 286, 779, 18, 26, 29, WIDETYPE_6)	-- �ڽ�Ƭ
	DrawEachNumberWide("UIData/dungeonmsg.tga", KillNPC, 2, g_backImagePosX+368,		385, 286, 779, 18, 26, 29, WIDETYPE_6)	-- NPC���
	DrawEachNumberWide("UIData/dungeonmsg.tga", bossKillCount, 2, g_backImagePosX+368,	448, 286, 779, 18, 26, 29, WIDETYPE_6)	-- �������Ƚ��

	DrawEachNumberWide("UIData/numberui001.tga", gainedZen , 2, g_backImagePosX+438 , 595, 716, 757, 28, 37, 28, WIDETYPE_6)  -- zen
	DrawEachNumberWide("UIData/numberui001.tga", gainedEXP , 2, g_backImagePosX+438 , 652, 716, 794, 28, 37, 28, WIDETYPE_6)
end


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_qeustResult_stampGrade")
mywindow:setTexture("Enabled", "UIData/DungeonResult.tga", 8, 530)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(637, g_backImagePosY+314)
mywindow:setSize(208, 243)
mywindow:setVisible(false)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)


------------------------------------------------------------

--����, ����ġ, ����Ʈ �׸���

------------------------------------------------------------
local g_totalScore	= 0
local g_gainExp		= 0
local g_gainPoint	= 0
local g_gainCoin	= 0
local g_currentLife	= 0
function WndQuestResult_ShowTotalScore(deltaTime, totalScore, gainExp, gainPoint, gainCoin, currentLife)

	-- ������ ���� ������ �����Ѵ�.
	g_totalScore	= totalScore
	g_gainExp		= gainExp
	g_gainPoint		= gainPoint
	g_gainCoin		= gainCoin
	g_currentLife	= currentLife

	local _infoY = g_characterInfoWindowsPosY + 38
	local _left, _right
	
	
	-- ����(������ ���� �ö�)
	if totalScore <= 0 then
		totalScore = 0
	end

	-- ����ġ
	if gainExp <= 0 then
		gainExp = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainExp, 2, 818, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- ����ġ
	drawer:drawTexture("UIData/dungeonmsg.tga", 838, _infoY, 19, 26, 582, 751, WIDETYPE_6)	-- /
	
	-- �׶�
	if gainPoint <= 0 then
		gainPoint = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainPoint, 1, 860, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- �׶�
	
	
	-- ȹ�� ����
	if gainCoin <= 0 then
		gainCoin = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", gainCoin, 8, 695, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)	-- ����
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-45, _infoY-8, 33, 41, 643, 670, WIDETYPE_6)	-- ���� �̹���
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-20, _infoY+4, 27, 22, 700, 675, WIDETYPE_6)	-- x
	
	
	-- ���� ������
	if currentLife <= 0 then
		currentLife = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", currentLife, 8, 522, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)-- ������
	drawer:drawTexture("UIData/quest.tga", _left-60, _infoY-11, 62, 38, 77, 898, WIDETYPE_6)	-- ������ �̹���
	
end





------------------------------------------------------------

-- 5. ���ʽ� �׸���

------------------------------------------------------------
-- �ؽ��� ����
local tBonusTextX = { ["err"]=0, [0]=30, 278, 30, 278, 30 }
local tBonusTextY = { ["err"]=0, [0]=31, 31, 61, 61, 91 }
local tBonusPosX  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusPosY  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }

-- ���� ����
local tEableBonus = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpValue	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusValue = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosX	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosY	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusEffectScaleX = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectScaleY = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectAlpha	 = { ["err"]=0, [0]=255, 255, 255, 255, 255 }

function WndQuestResult_IsVisibleBonusData(index, bVisible)
	tEableBonus[index] = bVisible
end


function WndQuestResult_ShowLevelupEffect()
	g_bLevelup = true
end


function DebugStr1(count)
	DebugStr('DebugStr'..count)
end

